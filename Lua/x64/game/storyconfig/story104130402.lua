return {
	Play413042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413042001
		arg_1_1.duration_ = 7.1

		local var_1_0 = {
			zh = 7.1,
			ja = 6.233
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
				arg_1_0:Play413042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F10f"

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
				local var_4_5 = arg_1_1.bgs_.F10f

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
					if iter_4_0 ~= "F10f" then
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

			local var_4_24 = "10022"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

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

			local var_4_28 = arg_1_1.actors_["10022"].transform
			local var_4_29 = 2

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos10022 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10022", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "split_8" or not string.find(var_4_31.name, "split") then
						var_4_31.gameObject:SetActive(true)
					else
						var_4_31.gameObject:SetActive(false)
					end
				end
			end

			local var_4_32 = 0.001

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_29) / var_4_32
				local var_4_34 = Vector3.New(0, -315, -320)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10022, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, -315, -320)
			end

			local var_4_35 = arg_1_1.actors_["10022"]
			local var_4_36 = 2

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10022 == nil then
				arg_1_1.var_.actorSpriteComps10022 = var_4_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_37 = 0.2

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 and not isNil(var_4_35) then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37

				if arg_1_1.var_.actorSpriteComps10022 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10022 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10022 = nil
			end

			local var_4_43 = 0
			local var_4_44 = 0.266666666666667

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

			local var_4_49 = 0.366666666666667
			local var_4_50 = 0.833333333333333

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_55 = 2
			local var_4_56 = 0.75

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_57 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_57:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_58 = arg_1_1:FormatText(StoryNameCfg[614].name)

				arg_1_1.leftNameTxt_.text = var_4_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_59 = arg_1_1:GetWordFromCfg(413042001)
				local var_4_60 = arg_1_1:FormatText(var_4_59.content)

				arg_1_1.text_.text = var_4_60

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_61 = 30
				local var_4_62 = utf8.len(var_4_60)
				local var_4_63 = var_4_61 <= 0 and var_4_56 or var_4_56 * (var_4_62 / var_4_61)

				if var_4_63 > 0 and var_4_56 < var_4_63 then
					arg_1_1.talkMaxDuration = var_4_63
					var_4_55 = var_4_55 + 0.3

					if var_4_63 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_55
					end
				end

				arg_1_1.text_.text = var_4_60
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042001", "story_v_out_413042.awb") ~= 0 then
					local var_4_64 = manager.audio:GetVoiceLength("story_v_out_413042", "413042001", "story_v_out_413042.awb") / 1000

					if var_4_64 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_55
					end

					if var_4_59.prefab_name ~= "" and arg_1_1.actors_[var_4_59.prefab_name] ~= nil then
						local var_4_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_59.prefab_name].transform, "story_v_out_413042", "413042001", "story_v_out_413042.awb")

						arg_1_1:RecordAudio("413042001", var_4_65)
						arg_1_1:RecordAudio("413042001", var_4_65)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413042", "413042001", "story_v_out_413042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413042", "413042001", "story_v_out_413042.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_66 = var_4_55 + 0.3
			local var_4_67 = math.max(var_4_56, arg_1_1.talkMaxDuration)

			if var_4_66 <= arg_1_1.time_ and arg_1_1.time_ < var_4_66 + var_4_67 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_66) / var_4_67

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_66 + var_4_67 and arg_1_1.time_ < var_4_66 + var_4_67 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413042002
		arg_9_1.duration_ = 12.3

		local var_9_0 = {
			zh = 12.3,
			ja = 3
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
				arg_9_0:Play413042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10097"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10097")

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

			local var_12_4 = arg_9_1.actors_["10097"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos10097 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10097", 2)

				local var_12_6 = var_12_4.childCount

				for iter_12_2 = 0, var_12_6 - 1 do
					local var_12_7 = var_12_4:GetChild(iter_12_2)

					if var_12_7.name == "split_3" or not string.find(var_12_7.name, "split") then
						var_12_7.gameObject:SetActive(true)
					else
						var_12_7.gameObject:SetActive(false)
					end
				end
			end

			local var_12_8 = 0.001

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_5) / var_12_8
				local var_12_10 = Vector3.New(-390, -350, -180)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10097, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_12_11 = arg_9_1.actors_["10022"]
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10022 == nil then
				arg_9_1.var_.actorSpriteComps10022 = var_12_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_13 = 2

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_13 and not isNil(var_12_11) then
				local var_12_14 = (arg_9_1.time_ - var_12_12) / var_12_13

				if arg_9_1.var_.actorSpriteComps10022 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_9_1.time_ >= var_12_12 + var_12_13 and arg_9_1.time_ < var_12_12 + var_12_13 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10022 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_12_6 then
						if arg_9_1.isInRecall_ then
							iter_12_6.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10022 = nil
			end

			local var_12_19 = arg_9_1.actors_["10097"]
			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.actorSpriteComps10097 == nil then
				arg_9_1.var_.actorSpriteComps10097 = var_12_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_21 = 2

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_21 and not isNil(var_12_19) then
				local var_12_22 = (arg_9_1.time_ - var_12_20) / var_12_21

				if arg_9_1.var_.actorSpriteComps10097 then
					for iter_12_7, iter_12_8 in pairs(arg_9_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_9_1.time_ >= var_12_20 + var_12_21 and arg_9_1.time_ < var_12_20 + var_12_21 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.actorSpriteComps10097 then
				for iter_12_9, iter_12_10 in pairs(arg_9_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_12_10 then
						if arg_9_1.isInRecall_ then
							iter_12_10.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10097 = nil
			end

			local var_12_27 = arg_9_1.actors_["10097"]
			local var_12_28 = 0

			if var_12_28 < arg_9_1.time_ and arg_9_1.time_ <= var_12_28 + arg_12_0 then
				local var_12_29 = var_12_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_29 then
					arg_9_1.var_.alphaOldValue10097 = var_12_29.alpha
					arg_9_1.var_.characterEffect10097 = var_12_29
				end

				arg_9_1.var_.alphaOldValue10097 = 0
			end

			local var_12_30 = 0.2

			if var_12_28 <= arg_9_1.time_ and arg_9_1.time_ < var_12_28 + var_12_30 then
				local var_12_31 = (arg_9_1.time_ - var_12_28) / var_12_30
				local var_12_32 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10097, 1, var_12_31)

				if arg_9_1.var_.characterEffect10097 then
					arg_9_1.var_.characterEffect10097.alpha = var_12_32
				end
			end

			if arg_9_1.time_ >= var_12_28 + var_12_30 and arg_9_1.time_ < var_12_28 + var_12_30 + arg_12_0 and arg_9_1.var_.characterEffect10097 then
				arg_9_1.var_.characterEffect10097.alpha = 1
			end

			local var_12_33 = arg_9_1.actors_["10022"].transform
			local var_12_34 = 0

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1.var_.moveOldPos10022 = var_12_33.localPosition
				var_12_33.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10022", 4)

				local var_12_35 = var_12_33.childCount

				for iter_12_11 = 0, var_12_35 - 1 do
					local var_12_36 = var_12_33:GetChild(iter_12_11)

					if var_12_36.name == "split_8" or not string.find(var_12_36.name, "split") then
						var_12_36.gameObject:SetActive(true)
					else
						var_12_36.gameObject:SetActive(false)
					end
				end
			end

			local var_12_37 = 0.001

			if var_12_34 <= arg_9_1.time_ and arg_9_1.time_ < var_12_34 + var_12_37 then
				local var_12_38 = (arg_9_1.time_ - var_12_34) / var_12_37
				local var_12_39 = Vector3.New(390, -315, -320)

				var_12_33.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10022, var_12_39, var_12_38)
			end

			if arg_9_1.time_ >= var_12_34 + var_12_37 and arg_9_1.time_ < var_12_34 + var_12_37 + arg_12_0 then
				var_12_33.localPosition = Vector3.New(390, -315, -320)
			end

			local var_12_40 = 0
			local var_12_41 = 0.875

			if var_12_40 < arg_9_1.time_ and arg_9_1.time_ <= var_12_40 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_42 = arg_9_1:FormatText(StoryNameCfg[1001].name)

				arg_9_1.leftNameTxt_.text = var_12_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_43 = arg_9_1:GetWordFromCfg(413042002)
				local var_12_44 = arg_9_1:FormatText(var_12_43.content)

				arg_9_1.text_.text = var_12_44

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_45 = 35
				local var_12_46 = utf8.len(var_12_44)
				local var_12_47 = var_12_45 <= 0 and var_12_41 or var_12_41 * (var_12_46 / var_12_45)

				if var_12_47 > 0 and var_12_41 < var_12_47 then
					arg_9_1.talkMaxDuration = var_12_47

					if var_12_47 + var_12_40 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_47 + var_12_40
					end
				end

				arg_9_1.text_.text = var_12_44
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042002", "story_v_out_413042.awb") ~= 0 then
					local var_12_48 = manager.audio:GetVoiceLength("story_v_out_413042", "413042002", "story_v_out_413042.awb") / 1000

					if var_12_48 + var_12_40 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_48 + var_12_40
					end

					if var_12_43.prefab_name ~= "" and arg_9_1.actors_[var_12_43.prefab_name] ~= nil then
						local var_12_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_43.prefab_name].transform, "story_v_out_413042", "413042002", "story_v_out_413042.awb")

						arg_9_1:RecordAudio("413042002", var_12_49)
						arg_9_1:RecordAudio("413042002", var_12_49)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413042", "413042002", "story_v_out_413042.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413042", "413042002", "story_v_out_413042.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_50 = math.max(var_12_41, arg_9_1.talkMaxDuration)

			if var_12_40 <= arg_9_1.time_ and arg_9_1.time_ < var_12_40 + var_12_50 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_40) / var_12_50

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_40 + var_12_50 and arg_9_1.time_ < var_12_40 + var_12_50 + arg_12_0 then
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
			},
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

		arg_9_1:InitPlayNodeList()
	end,
	Play413042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413042003
		arg_13_1.duration_ = 7.33

		local var_13_0 = {
			zh = 7.333,
			ja = 5.533
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
				arg_13_0:Play413042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.75

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[1001].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(413042003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 30
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042003", "story_v_out_413042.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042003", "story_v_out_413042.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_413042", "413042003", "story_v_out_413042.awb")

						arg_13_1:RecordAudio("413042003", var_16_9)
						arg_13_1:RecordAudio("413042003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413042", "413042003", "story_v_out_413042.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413042", "413042003", "story_v_out_413042.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play413042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413042004
		arg_17_1.duration_ = 5.93

		local var_17_0 = {
			zh = 3.866,
			ja = 5.933
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
				arg_17_0:Play413042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10022"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10022 == nil then
				arg_17_1.var_.actorSpriteComps10022 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10022 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10022 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10022 = nil
			end

			local var_20_8 = arg_17_1.actors_["10097"]
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps10097 == nil then
				arg_17_1.var_.actorSpriteComps10097 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_10 = 2

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_10 and not isNil(var_20_8) then
				local var_20_11 = (arg_17_1.time_ - var_20_9) / var_20_10

				if arg_17_1.var_.actorSpriteComps10097 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_17_1.time_ >= var_20_9 + var_20_10 and arg_17_1.time_ < var_20_9 + var_20_10 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps10097 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_20_7 then
						if arg_17_1.isInRecall_ then
							iter_20_7.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10097 = nil
			end

			local var_20_16 = 0
			local var_20_17 = 0.575

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_18 = arg_17_1:FormatText(StoryNameCfg[614].name)

				arg_17_1.leftNameTxt_.text = var_20_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_19 = arg_17_1:GetWordFromCfg(413042004)
				local var_20_20 = arg_17_1:FormatText(var_20_19.content)

				arg_17_1.text_.text = var_20_20

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_21 = 23
				local var_20_22 = utf8.len(var_20_20)
				local var_20_23 = var_20_21 <= 0 and var_20_17 or var_20_17 * (var_20_22 / var_20_21)

				if var_20_23 > 0 and var_20_17 < var_20_23 then
					arg_17_1.talkMaxDuration = var_20_23

					if var_20_23 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_16
					end
				end

				arg_17_1.text_.text = var_20_20
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042004", "story_v_out_413042.awb") ~= 0 then
					local var_20_24 = manager.audio:GetVoiceLength("story_v_out_413042", "413042004", "story_v_out_413042.awb") / 1000

					if var_20_24 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_24 + var_20_16
					end

					if var_20_19.prefab_name ~= "" and arg_17_1.actors_[var_20_19.prefab_name] ~= nil then
						local var_20_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_19.prefab_name].transform, "story_v_out_413042", "413042004", "story_v_out_413042.awb")

						arg_17_1:RecordAudio("413042004", var_20_25)
						arg_17_1:RecordAudio("413042004", var_20_25)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413042", "413042004", "story_v_out_413042.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413042", "413042004", "story_v_out_413042.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_26 = math.max(var_20_17, arg_17_1.talkMaxDuration)

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_26 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_16) / var_20_26

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_16 + var_20_26 and arg_17_1.time_ < var_20_16 + var_20_26 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play413042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413042005
		arg_21_1.duration_ = 10.9

		local var_21_0 = {
			zh = 6.733,
			ja = 10.9
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
				arg_21_0:Play413042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10022"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10022 == nil then
				arg_21_1.var_.actorSpriteComps10022 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10022 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10022 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10022 = nil
			end

			local var_24_8 = arg_21_1.actors_["10097"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10097 == nil then
				arg_21_1.var_.actorSpriteComps10097 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 2

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps10097 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10097 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10097 = nil
			end

			local var_24_16 = 0
			local var_24_17 = 0.45

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_18 = arg_21_1:FormatText(StoryNameCfg[1001].name)

				arg_21_1.leftNameTxt_.text = var_24_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:GetWordFromCfg(413042005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042005", "story_v_out_413042.awb") ~= 0 then
					local var_24_24 = manager.audio:GetVoiceLength("story_v_out_413042", "413042005", "story_v_out_413042.awb") / 1000

					if var_24_24 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_16
					end

					if var_24_19.prefab_name ~= "" and arg_21_1.actors_[var_24_19.prefab_name] ~= nil then
						local var_24_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_19.prefab_name].transform, "story_v_out_413042", "413042005", "story_v_out_413042.awb")

						arg_21_1:RecordAudio("413042005", var_24_25)
						arg_21_1:RecordAudio("413042005", var_24_25)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413042", "413042005", "story_v_out_413042.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413042", "413042005", "story_v_out_413042.awb")
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
	Play413042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413042006
		arg_25_1.duration_ = 10.63

		local var_25_0 = {
			zh = 9.533,
			ja = 10.633
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
				arg_25_0:Play413042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.9

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[1001].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(413042006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042006", "story_v_out_413042.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042006", "story_v_out_413042.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_413042", "413042006", "story_v_out_413042.awb")

						arg_25_1:RecordAudio("413042006", var_28_9)
						arg_25_1:RecordAudio("413042006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413042", "413042006", "story_v_out_413042.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413042", "413042006", "story_v_out_413042.awb")
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
	Play413042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413042007
		arg_29_1.duration_ = 8.2

		local var_29_0 = {
			zh = 7.2,
			ja = 8.2
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
				arg_29_0:Play413042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10022"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10022 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10022", 4)

				local var_32_2 = var_32_0.childCount

				for iter_32_0 = 0, var_32_2 - 1 do
					local var_32_3 = var_32_0:GetChild(iter_32_0)

					if var_32_3.name == "split_1" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_4 then
				local var_32_5 = (arg_29_1.time_ - var_32_1) / var_32_4
				local var_32_6 = Vector3.New(390, -315, -320)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10022, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_32_7 = arg_29_1.actors_["10097"].transform
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.var_.moveOldPos10097 = var_32_7.localPosition
				var_32_7.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10097", 2)

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
				local var_32_13 = Vector3.New(-390, -350, -180)

				var_32_7.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10097, var_32_13, var_32_12)
			end

			if arg_29_1.time_ >= var_32_8 + var_32_11 and arg_29_1.time_ < var_32_8 + var_32_11 + arg_32_0 then
				var_32_7.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_32_14 = arg_29_1.actors_["10022"]
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps10022 == nil then
				arg_29_1.var_.actorSpriteComps10022 = var_32_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_16 = 2

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 and not isNil(var_32_14) then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16

				if arg_29_1.var_.actorSpriteComps10022 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps10022 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_32_5 then
						if arg_29_1.isInRecall_ then
							iter_32_5.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10022 = nil
			end

			local var_32_22 = arg_29_1.actors_["10097"]
			local var_32_23 = 0

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 and not isNil(var_32_22) and arg_29_1.var_.actorSpriteComps10097 == nil then
				arg_29_1.var_.actorSpriteComps10097 = var_32_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_24 = 2

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 and not isNil(var_32_22) then
				local var_32_25 = (arg_29_1.time_ - var_32_23) / var_32_24

				if arg_29_1.var_.actorSpriteComps10097 then
					for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 and not isNil(var_32_22) and arg_29_1.var_.actorSpriteComps10097 then
				for iter_32_8, iter_32_9 in pairs(arg_29_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_32_9 then
						if arg_29_1.isInRecall_ then
							iter_32_9.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10097 = nil
			end

			local var_32_30 = 0
			local var_32_31 = 0.7

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_32 = arg_29_1:FormatText(StoryNameCfg[614].name)

				arg_29_1.leftNameTxt_.text = var_32_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_33 = arg_29_1:GetWordFromCfg(413042007)
				local var_32_34 = arg_29_1:FormatText(var_32_33.content)

				arg_29_1.text_.text = var_32_34

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_35 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042007", "story_v_out_413042.awb") ~= 0 then
					local var_32_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042007", "story_v_out_413042.awb") / 1000

					if var_32_38 + var_32_30 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_38 + var_32_30
					end

					if var_32_33.prefab_name ~= "" and arg_29_1.actors_[var_32_33.prefab_name] ~= nil then
						local var_32_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_33.prefab_name].transform, "story_v_out_413042", "413042007", "story_v_out_413042.awb")

						arg_29_1:RecordAudio("413042007", var_32_39)
						arg_29_1:RecordAudio("413042007", var_32_39)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413042", "413042007", "story_v_out_413042.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413042", "413042007", "story_v_out_413042.awb")
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_29_1:InitPlayNodeList()
	end,
	Play413042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413042008
		arg_33_1.duration_ = 9.9

		local var_33_0 = {
			zh = 9.9,
			ja = 7.333
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
				arg_33_0:Play413042009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10097"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10097 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10097", 2)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "split_2" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(-390, -350, -180)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10097, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_36_7 = arg_33_1.actors_["10022"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10022 == nil then
				arg_33_1.var_.actorSpriteComps10022 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 2

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps10022 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10022 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10022 = nil
			end

			local var_36_15 = arg_33_1.actors_["10097"]
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.actorSpriteComps10097 == nil then
				arg_33_1.var_.actorSpriteComps10097 = var_36_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_17 = 2

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 and not isNil(var_36_15) then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17

				if arg_33_1.var_.actorSpriteComps10097 then
					for iter_36_5, iter_36_6 in pairs(arg_33_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.actorSpriteComps10097 then
				for iter_36_7, iter_36_8 in pairs(arg_33_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_36_8 then
						if arg_33_1.isInRecall_ then
							iter_36_8.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10097 = nil
			end

			local var_36_23 = 0
			local var_36_24 = 0.825

			if var_36_23 < arg_33_1.time_ and arg_33_1.time_ <= var_36_23 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_25 = arg_33_1:FormatText(StoryNameCfg[1001].name)

				arg_33_1.leftNameTxt_.text = var_36_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_26 = arg_33_1:GetWordFromCfg(413042008)
				local var_36_27 = arg_33_1:FormatText(var_36_26.content)

				arg_33_1.text_.text = var_36_27

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_28 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042008", "story_v_out_413042.awb") ~= 0 then
					local var_36_31 = manager.audio:GetVoiceLength("story_v_out_413042", "413042008", "story_v_out_413042.awb") / 1000

					if var_36_31 + var_36_23 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_31 + var_36_23
					end

					if var_36_26.prefab_name ~= "" and arg_33_1.actors_[var_36_26.prefab_name] ~= nil then
						local var_36_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_26.prefab_name].transform, "story_v_out_413042", "413042008", "story_v_out_413042.awb")

						arg_33_1:RecordAudio("413042008", var_36_32)
						arg_33_1:RecordAudio("413042008", var_36_32)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413042", "413042008", "story_v_out_413042.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413042", "413042008", "story_v_out_413042.awb")
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
				actorName = "10097",
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
	Play413042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413042009
		arg_37_1.duration_ = 8.83

		local var_37_0 = {
			zh = 4.8,
			ja = 8.833
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
				arg_37_0:Play413042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10022"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10022 == nil then
				arg_37_1.var_.actorSpriteComps10022 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps10022 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10022 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10022 = nil
			end

			local var_40_8 = arg_37_1.actors_["10097"]
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10097 == nil then
				arg_37_1.var_.actorSpriteComps10097 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_10 = 2

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 and not isNil(var_40_8) then
				local var_40_11 = (arg_37_1.time_ - var_40_9) / var_40_10

				if arg_37_1.var_.actorSpriteComps10097 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10097 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_40_7 then
						if arg_37_1.isInRecall_ then
							iter_40_7.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10097 = nil
			end

			local var_40_16 = 0
			local var_40_17 = 0.65

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_18 = arg_37_1:FormatText(StoryNameCfg[614].name)

				arg_37_1.leftNameTxt_.text = var_40_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_19 = arg_37_1:GetWordFromCfg(413042009)
				local var_40_20 = arg_37_1:FormatText(var_40_19.content)

				arg_37_1.text_.text = var_40_20

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_21 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042009", "story_v_out_413042.awb") ~= 0 then
					local var_40_24 = manager.audio:GetVoiceLength("story_v_out_413042", "413042009", "story_v_out_413042.awb") / 1000

					if var_40_24 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_24 + var_40_16
					end

					if var_40_19.prefab_name ~= "" and arg_37_1.actors_[var_40_19.prefab_name] ~= nil then
						local var_40_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_19.prefab_name].transform, "story_v_out_413042", "413042009", "story_v_out_413042.awb")

						arg_37_1:RecordAudio("413042009", var_40_25)
						arg_37_1:RecordAudio("413042009", var_40_25)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413042", "413042009", "story_v_out_413042.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413042", "413042009", "story_v_out_413042.awb")
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
	Play413042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413042010
		arg_41_1.duration_ = 14

		local var_41_0 = {
			zh = 9.333,
			ja = 14
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
				arg_41_0:Play413042011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10022"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10022 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10022", 4)

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
				local var_44_6 = Vector3.New(390, -315, -320)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10022, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_44_7 = 0
			local var_44_8 = 1.175

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_9 = arg_41_1:FormatText(StoryNameCfg[614].name)

				arg_41_1.leftNameTxt_.text = var_44_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(413042010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_12 = 47
				local var_44_13 = utf8.len(var_44_11)
				local var_44_14 = var_44_12 <= 0 and var_44_8 or var_44_8 * (var_44_13 / var_44_12)

				if var_44_14 > 0 and var_44_8 < var_44_14 then
					arg_41_1.talkMaxDuration = var_44_14

					if var_44_14 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_7
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042010", "story_v_out_413042.awb") ~= 0 then
					local var_44_15 = manager.audio:GetVoiceLength("story_v_out_413042", "413042010", "story_v_out_413042.awb") / 1000

					if var_44_15 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_15 + var_44_7
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_413042", "413042010", "story_v_out_413042.awb")

						arg_41_1:RecordAudio("413042010", var_44_16)
						arg_41_1:RecordAudio("413042010", var_44_16)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413042", "413042010", "story_v_out_413042.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413042", "413042010", "story_v_out_413042.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_17 = math.max(var_44_8, arg_41_1.talkMaxDuration)

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_17 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_7) / var_44_17

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_7 + var_44_17 and arg_41_1.time_ < var_44_7 + var_44_17 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play413042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413042011
		arg_45_1.duration_ = 13.53

		local var_45_0 = {
			zh = 6.6,
			ja = 13.533
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
				arg_45_0:Play413042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.85

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[614].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(413042011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 34
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042011", "story_v_out_413042.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042011", "story_v_out_413042.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_413042", "413042011", "story_v_out_413042.awb")

						arg_45_1:RecordAudio("413042011", var_48_9)
						arg_45_1:RecordAudio("413042011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413042", "413042011", "story_v_out_413042.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413042", "413042011", "story_v_out_413042.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play413042012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413042012
		arg_49_1.duration_ = 8.13

		local var_49_0 = {
			zh = 8.133,
			ja = 6.1
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
				arg_49_0:Play413042013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10022"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10022 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10022", 4)

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
				local var_52_6 = Vector3.New(390, -315, -320)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10022, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_52_7 = arg_49_1.actors_["10097"].transform
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.var_.moveOldPos10097 = var_52_7.localPosition
				var_52_7.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10097", 2)

				local var_52_9 = var_52_7.childCount

				for iter_52_1 = 0, var_52_9 - 1 do
					local var_52_10 = var_52_7:GetChild(iter_52_1)

					if var_52_10.name == "" or not string.find(var_52_10.name, "split") then
						var_52_10.gameObject:SetActive(true)
					else
						var_52_10.gameObject:SetActive(false)
					end
				end
			end

			local var_52_11 = 0.001

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_11 then
				local var_52_12 = (arg_49_1.time_ - var_52_8) / var_52_11
				local var_52_13 = Vector3.New(-390, -350, -180)

				var_52_7.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10097, var_52_13, var_52_12)
			end

			if arg_49_1.time_ >= var_52_8 + var_52_11 and arg_49_1.time_ < var_52_8 + var_52_11 + arg_52_0 then
				var_52_7.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_52_14 = arg_49_1.actors_["10022"]
			local var_52_15 = 0

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.actorSpriteComps10022 == nil then
				arg_49_1.var_.actorSpriteComps10022 = var_52_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_16 = 2

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_16 and not isNil(var_52_14) then
				local var_52_17 = (arg_49_1.time_ - var_52_15) / var_52_16

				if arg_49_1.var_.actorSpriteComps10022 then
					for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_52_3 then
							if arg_49_1.isInRecall_ then
								local var_52_18 = Mathf.Lerp(iter_52_3.color.r, arg_49_1.hightColor2.r, var_52_17)
								local var_52_19 = Mathf.Lerp(iter_52_3.color.g, arg_49_1.hightColor2.g, var_52_17)
								local var_52_20 = Mathf.Lerp(iter_52_3.color.b, arg_49_1.hightColor2.b, var_52_17)

								iter_52_3.color = Color.New(var_52_18, var_52_19, var_52_20)
							else
								local var_52_21 = Mathf.Lerp(iter_52_3.color.r, 0.5, var_52_17)

								iter_52_3.color = Color.New(var_52_21, var_52_21, var_52_21)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_15 + var_52_16 and arg_49_1.time_ < var_52_15 + var_52_16 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.actorSpriteComps10022 then
				for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_52_5 then
						if arg_49_1.isInRecall_ then
							iter_52_5.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10022 = nil
			end

			local var_52_22 = arg_49_1.actors_["10097"]
			local var_52_23 = 0

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 and not isNil(var_52_22) and arg_49_1.var_.actorSpriteComps10097 == nil then
				arg_49_1.var_.actorSpriteComps10097 = var_52_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_24 = 2

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_24 and not isNil(var_52_22) then
				local var_52_25 = (arg_49_1.time_ - var_52_23) / var_52_24

				if arg_49_1.var_.actorSpriteComps10097 then
					for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_52_7 then
							if arg_49_1.isInRecall_ then
								local var_52_26 = Mathf.Lerp(iter_52_7.color.r, arg_49_1.hightColor1.r, var_52_25)
								local var_52_27 = Mathf.Lerp(iter_52_7.color.g, arg_49_1.hightColor1.g, var_52_25)
								local var_52_28 = Mathf.Lerp(iter_52_7.color.b, arg_49_1.hightColor1.b, var_52_25)

								iter_52_7.color = Color.New(var_52_26, var_52_27, var_52_28)
							else
								local var_52_29 = Mathf.Lerp(iter_52_7.color.r, 1, var_52_25)

								iter_52_7.color = Color.New(var_52_29, var_52_29, var_52_29)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_23 + var_52_24 and arg_49_1.time_ < var_52_23 + var_52_24 + arg_52_0 and not isNil(var_52_22) and arg_49_1.var_.actorSpriteComps10097 then
				for iter_52_8, iter_52_9 in pairs(arg_49_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_52_9 then
						if arg_49_1.isInRecall_ then
							iter_52_9.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10097 = nil
			end

			local var_52_30 = 0
			local var_52_31 = 0.7

			if var_52_30 < arg_49_1.time_ and arg_49_1.time_ <= var_52_30 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_32 = arg_49_1:FormatText(StoryNameCfg[1001].name)

				arg_49_1.leftNameTxt_.text = var_52_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_33 = arg_49_1:GetWordFromCfg(413042012)
				local var_52_34 = arg_49_1:FormatText(var_52_33.content)

				arg_49_1.text_.text = var_52_34

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_35 = 28
				local var_52_36 = utf8.len(var_52_34)
				local var_52_37 = var_52_35 <= 0 and var_52_31 or var_52_31 * (var_52_36 / var_52_35)

				if var_52_37 > 0 and var_52_31 < var_52_37 then
					arg_49_1.talkMaxDuration = var_52_37

					if var_52_37 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_37 + var_52_30
					end
				end

				arg_49_1.text_.text = var_52_34
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042012", "story_v_out_413042.awb") ~= 0 then
					local var_52_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042012", "story_v_out_413042.awb") / 1000

					if var_52_38 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_38 + var_52_30
					end

					if var_52_33.prefab_name ~= "" and arg_49_1.actors_[var_52_33.prefab_name] ~= nil then
						local var_52_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_33.prefab_name].transform, "story_v_out_413042", "413042012", "story_v_out_413042.awb")

						arg_49_1:RecordAudio("413042012", var_52_39)
						arg_49_1:RecordAudio("413042012", var_52_39)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413042", "413042012", "story_v_out_413042.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413042", "413042012", "story_v_out_413042.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_40 = math.max(var_52_31, arg_49_1.talkMaxDuration)

			if var_52_30 <= arg_49_1.time_ and arg_49_1.time_ < var_52_30 + var_52_40 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_30) / var_52_40

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_30 + var_52_40 and arg_49_1.time_ < var_52_30 + var_52_40 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_49_1:InitPlayNodeList()
	end,
	Play413042013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413042013
		arg_53_1.duration_ = 11

		local var_53_0 = {
			zh = 8.333,
			ja = 11
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
				arg_53_0:Play413042014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.825

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1001].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(413042013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 33
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042013", "story_v_out_413042.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042013", "story_v_out_413042.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_413042", "413042013", "story_v_out_413042.awb")

						arg_53_1:RecordAudio("413042013", var_56_9)
						arg_53_1:RecordAudio("413042013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413042", "413042013", "story_v_out_413042.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413042", "413042013", "story_v_out_413042.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play413042014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413042014
		arg_57_1.duration_ = 9.97

		local var_57_0 = {
			zh = 6.4,
			ja = 9.966
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
				arg_57_0:Play413042015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10022"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10022 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10022", 4)

				local var_60_2 = var_60_0.childCount

				for iter_60_0 = 0, var_60_2 - 1 do
					local var_60_3 = var_60_0:GetChild(iter_60_0)

					if var_60_3.name == "split_8" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_4 then
				local var_60_5 = (arg_57_1.time_ - var_60_1) / var_60_4
				local var_60_6 = Vector3.New(390, -315, -320)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10022, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_60_7 = arg_57_1.actors_["10097"].transform
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.var_.moveOldPos10097 = var_60_7.localPosition
				var_60_7.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10097", 2)

				local var_60_9 = var_60_7.childCount

				for iter_60_1 = 0, var_60_9 - 1 do
					local var_60_10 = var_60_7:GetChild(iter_60_1)

					if var_60_10.name == "split_1" or not string.find(var_60_10.name, "split") then
						var_60_10.gameObject:SetActive(true)
					else
						var_60_10.gameObject:SetActive(false)
					end
				end
			end

			local var_60_11 = 0.001

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_11 then
				local var_60_12 = (arg_57_1.time_ - var_60_8) / var_60_11
				local var_60_13 = Vector3.New(-390, -350, -180)

				var_60_7.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10097, var_60_13, var_60_12)
			end

			if arg_57_1.time_ >= var_60_8 + var_60_11 and arg_57_1.time_ < var_60_8 + var_60_11 + arg_60_0 then
				var_60_7.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_60_14 = arg_57_1.actors_["10022"]
			local var_60_15 = 0

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 and not isNil(var_60_14) and arg_57_1.var_.actorSpriteComps10022 == nil then
				arg_57_1.var_.actorSpriteComps10022 = var_60_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_16 = 2

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_16 and not isNil(var_60_14) then
				local var_60_17 = (arg_57_1.time_ - var_60_15) / var_60_16

				if arg_57_1.var_.actorSpriteComps10022 then
					for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_60_3 then
							if arg_57_1.isInRecall_ then
								local var_60_18 = Mathf.Lerp(iter_60_3.color.r, arg_57_1.hightColor1.r, var_60_17)
								local var_60_19 = Mathf.Lerp(iter_60_3.color.g, arg_57_1.hightColor1.g, var_60_17)
								local var_60_20 = Mathf.Lerp(iter_60_3.color.b, arg_57_1.hightColor1.b, var_60_17)

								iter_60_3.color = Color.New(var_60_18, var_60_19, var_60_20)
							else
								local var_60_21 = Mathf.Lerp(iter_60_3.color.r, 1, var_60_17)

								iter_60_3.color = Color.New(var_60_21, var_60_21, var_60_21)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_15 + var_60_16 and arg_57_1.time_ < var_60_15 + var_60_16 + arg_60_0 and not isNil(var_60_14) and arg_57_1.var_.actorSpriteComps10022 then
				for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_60_5 then
						if arg_57_1.isInRecall_ then
							iter_60_5.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10022 = nil
			end

			local var_60_22 = arg_57_1.actors_["10097"]
			local var_60_23 = 0

			if var_60_23 < arg_57_1.time_ and arg_57_1.time_ <= var_60_23 + arg_60_0 and not isNil(var_60_22) and arg_57_1.var_.actorSpriteComps10097 == nil then
				arg_57_1.var_.actorSpriteComps10097 = var_60_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_24 = 2

			if var_60_23 <= arg_57_1.time_ and arg_57_1.time_ < var_60_23 + var_60_24 and not isNil(var_60_22) then
				local var_60_25 = (arg_57_1.time_ - var_60_23) / var_60_24

				if arg_57_1.var_.actorSpriteComps10097 then
					for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_60_7 then
							if arg_57_1.isInRecall_ then
								local var_60_26 = Mathf.Lerp(iter_60_7.color.r, arg_57_1.hightColor2.r, var_60_25)
								local var_60_27 = Mathf.Lerp(iter_60_7.color.g, arg_57_1.hightColor2.g, var_60_25)
								local var_60_28 = Mathf.Lerp(iter_60_7.color.b, arg_57_1.hightColor2.b, var_60_25)

								iter_60_7.color = Color.New(var_60_26, var_60_27, var_60_28)
							else
								local var_60_29 = Mathf.Lerp(iter_60_7.color.r, 0.5, var_60_25)

								iter_60_7.color = Color.New(var_60_29, var_60_29, var_60_29)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_23 + var_60_24 and arg_57_1.time_ < var_60_23 + var_60_24 + arg_60_0 and not isNil(var_60_22) and arg_57_1.var_.actorSpriteComps10097 then
				for iter_60_8, iter_60_9 in pairs(arg_57_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_60_9 then
						if arg_57_1.isInRecall_ then
							iter_60_9.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10097 = nil
			end

			local var_60_30 = 0
			local var_60_31 = 0.825

			if var_60_30 < arg_57_1.time_ and arg_57_1.time_ <= var_60_30 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_32 = arg_57_1:FormatText(StoryNameCfg[614].name)

				arg_57_1.leftNameTxt_.text = var_60_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_33 = arg_57_1:GetWordFromCfg(413042014)
				local var_60_34 = arg_57_1:FormatText(var_60_33.content)

				arg_57_1.text_.text = var_60_34

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_35 = 33
				local var_60_36 = utf8.len(var_60_34)
				local var_60_37 = var_60_35 <= 0 and var_60_31 or var_60_31 * (var_60_36 / var_60_35)

				if var_60_37 > 0 and var_60_31 < var_60_37 then
					arg_57_1.talkMaxDuration = var_60_37

					if var_60_37 + var_60_30 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_37 + var_60_30
					end
				end

				arg_57_1.text_.text = var_60_34
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042014", "story_v_out_413042.awb") ~= 0 then
					local var_60_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042014", "story_v_out_413042.awb") / 1000

					if var_60_38 + var_60_30 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_38 + var_60_30
					end

					if var_60_33.prefab_name ~= "" and arg_57_1.actors_[var_60_33.prefab_name] ~= nil then
						local var_60_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_33.prefab_name].transform, "story_v_out_413042", "413042014", "story_v_out_413042.awb")

						arg_57_1:RecordAudio("413042014", var_60_39)
						arg_57_1:RecordAudio("413042014", var_60_39)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413042", "413042014", "story_v_out_413042.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413042", "413042014", "story_v_out_413042.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_40 = math.max(var_60_31, arg_57_1.talkMaxDuration)

			if var_60_30 <= arg_57_1.time_ and arg_57_1.time_ < var_60_30 + var_60_40 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_30) / var_60_40

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_30 + var_60_40 and arg_57_1.time_ < var_60_30 + var_60_40 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_57_1:InitPlayNodeList()
	end,
	Play413042015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413042015
		arg_61_1.duration_ = 14.1

		local var_61_0 = {
			zh = 8,
			ja = 14.1
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
				arg_61_0:Play413042016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.075

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[614].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(413042015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 43
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042015", "story_v_out_413042.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042015", "story_v_out_413042.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_413042", "413042015", "story_v_out_413042.awb")

						arg_61_1:RecordAudio("413042015", var_64_9)
						arg_61_1:RecordAudio("413042015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413042", "413042015", "story_v_out_413042.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413042", "413042015", "story_v_out_413042.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play413042016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413042016
		arg_65_1.duration_ = 12.77

		local var_65_0 = {
			zh = 12.766,
			ja = 11.866
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
				arg_65_0:Play413042017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10022"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10022 == nil then
				arg_65_1.var_.actorSpriteComps10022 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10022 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10022 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10022 = nil
			end

			local var_68_8 = arg_65_1.actors_["10097"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10097 == nil then
				arg_65_1.var_.actorSpriteComps10097 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps10097 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								local var_68_12 = Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor1.r, var_68_11)
								local var_68_13 = Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor1.g, var_68_11)
								local var_68_14 = Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor1.b, var_68_11)

								iter_68_5.color = Color.New(var_68_12, var_68_13, var_68_14)
							else
								local var_68_15 = Mathf.Lerp(iter_68_5.color.r, 1, var_68_11)

								iter_68_5.color = Color.New(var_68_15, var_68_15, var_68_15)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10097 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10097 = nil
			end

			local var_68_16 = 0
			local var_68_17 = 0.95

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_18 = arg_65_1:FormatText(StoryNameCfg[1001].name)

				arg_65_1.leftNameTxt_.text = var_68_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(413042016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 38
				local var_68_22 = utf8.len(var_68_20)
				local var_68_23 = var_68_21 <= 0 and var_68_17 or var_68_17 * (var_68_22 / var_68_21)

				if var_68_23 > 0 and var_68_17 < var_68_23 then
					arg_65_1.talkMaxDuration = var_68_23

					if var_68_23 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_16
					end
				end

				arg_65_1.text_.text = var_68_20
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042016", "story_v_out_413042.awb") ~= 0 then
					local var_68_24 = manager.audio:GetVoiceLength("story_v_out_413042", "413042016", "story_v_out_413042.awb") / 1000

					if var_68_24 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_24 + var_68_16
					end

					if var_68_19.prefab_name ~= "" and arg_65_1.actors_[var_68_19.prefab_name] ~= nil then
						local var_68_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_19.prefab_name].transform, "story_v_out_413042", "413042016", "story_v_out_413042.awb")

						arg_65_1:RecordAudio("413042016", var_68_25)
						arg_65_1:RecordAudio("413042016", var_68_25)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413042", "413042016", "story_v_out_413042.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413042", "413042016", "story_v_out_413042.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_26 = math.max(var_68_17, arg_65_1.talkMaxDuration)

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_26 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_16) / var_68_26

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_16 + var_68_26 and arg_65_1.time_ < var_68_16 + var_68_26 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play413042017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413042017
		arg_69_1.duration_ = 2

		local var_69_0 = {
			zh = 1.999999999999,
			ja = 2
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play413042018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10022"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10022 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10022", 4)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "split_3" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(390, -315, -320)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10022, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_72_7 = arg_69_1.actors_["10097"].transform
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.var_.moveOldPos10097 = var_72_7.localPosition
				var_72_7.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10097", 2)

				local var_72_9 = var_72_7.childCount

				for iter_72_1 = 0, var_72_9 - 1 do
					local var_72_10 = var_72_7:GetChild(iter_72_1)

					if var_72_10.name == "split_3" or not string.find(var_72_10.name, "split") then
						var_72_10.gameObject:SetActive(true)
					else
						var_72_10.gameObject:SetActive(false)
					end
				end
			end

			local var_72_11 = 0.001

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_11 then
				local var_72_12 = (arg_69_1.time_ - var_72_8) / var_72_11
				local var_72_13 = Vector3.New(-390, -350, -180)

				var_72_7.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10097, var_72_13, var_72_12)
			end

			if arg_69_1.time_ >= var_72_8 + var_72_11 and arg_69_1.time_ < var_72_8 + var_72_11 + arg_72_0 then
				var_72_7.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_72_14 = arg_69_1.actors_["10022"]
			local var_72_15 = 0

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.actorSpriteComps10022 == nil then
				arg_69_1.var_.actorSpriteComps10022 = var_72_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_16 = 2

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_16 and not isNil(var_72_14) then
				local var_72_17 = (arg_69_1.time_ - var_72_15) / var_72_16

				if arg_69_1.var_.actorSpriteComps10022 then
					for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_72_3 then
							if arg_69_1.isInRecall_ then
								local var_72_18 = Mathf.Lerp(iter_72_3.color.r, arg_69_1.hightColor1.r, var_72_17)
								local var_72_19 = Mathf.Lerp(iter_72_3.color.g, arg_69_1.hightColor1.g, var_72_17)
								local var_72_20 = Mathf.Lerp(iter_72_3.color.b, arg_69_1.hightColor1.b, var_72_17)

								iter_72_3.color = Color.New(var_72_18, var_72_19, var_72_20)
							else
								local var_72_21 = Mathf.Lerp(iter_72_3.color.r, 1, var_72_17)

								iter_72_3.color = Color.New(var_72_21, var_72_21, var_72_21)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_15 + var_72_16 and arg_69_1.time_ < var_72_15 + var_72_16 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.actorSpriteComps10022 then
				for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_72_5 then
						if arg_69_1.isInRecall_ then
							iter_72_5.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10022 = nil
			end

			local var_72_22 = arg_69_1.actors_["10097"]
			local var_72_23 = 0

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 and not isNil(var_72_22) and arg_69_1.var_.actorSpriteComps10097 == nil then
				arg_69_1.var_.actorSpriteComps10097 = var_72_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_24 = 2

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_24 and not isNil(var_72_22) then
				local var_72_25 = (arg_69_1.time_ - var_72_23) / var_72_24

				if arg_69_1.var_.actorSpriteComps10097 then
					for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_72_7 then
							if arg_69_1.isInRecall_ then
								local var_72_26 = Mathf.Lerp(iter_72_7.color.r, arg_69_1.hightColor2.r, var_72_25)
								local var_72_27 = Mathf.Lerp(iter_72_7.color.g, arg_69_1.hightColor2.g, var_72_25)
								local var_72_28 = Mathf.Lerp(iter_72_7.color.b, arg_69_1.hightColor2.b, var_72_25)

								iter_72_7.color = Color.New(var_72_26, var_72_27, var_72_28)
							else
								local var_72_29 = Mathf.Lerp(iter_72_7.color.r, 0.5, var_72_25)

								iter_72_7.color = Color.New(var_72_29, var_72_29, var_72_29)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_23 + var_72_24 and arg_69_1.time_ < var_72_23 + var_72_24 + arg_72_0 and not isNil(var_72_22) and arg_69_1.var_.actorSpriteComps10097 then
				for iter_72_8, iter_72_9 in pairs(arg_69_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_72_9 then
						if arg_69_1.isInRecall_ then
							iter_72_9.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10097 = nil
			end

			local var_72_30 = 0
			local var_72_31 = 0.15

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_32 = arg_69_1:FormatText(StoryNameCfg[614].name)

				arg_69_1.leftNameTxt_.text = var_72_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_33 = arg_69_1:GetWordFromCfg(413042017)
				local var_72_34 = arg_69_1:FormatText(var_72_33.content)

				arg_69_1.text_.text = var_72_34

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_35 = 6
				local var_72_36 = utf8.len(var_72_34)
				local var_72_37 = var_72_35 <= 0 and var_72_31 or var_72_31 * (var_72_36 / var_72_35)

				if var_72_37 > 0 and var_72_31 < var_72_37 then
					arg_69_1.talkMaxDuration = var_72_37

					if var_72_37 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_37 + var_72_30
					end
				end

				arg_69_1.text_.text = var_72_34
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042017", "story_v_out_413042.awb") ~= 0 then
					local var_72_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042017", "story_v_out_413042.awb") / 1000

					if var_72_38 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_38 + var_72_30
					end

					if var_72_33.prefab_name ~= "" and arg_69_1.actors_[var_72_33.prefab_name] ~= nil then
						local var_72_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_33.prefab_name].transform, "story_v_out_413042", "413042017", "story_v_out_413042.awb")

						arg_69_1:RecordAudio("413042017", var_72_39)
						arg_69_1:RecordAudio("413042017", var_72_39)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413042", "413042017", "story_v_out_413042.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413042", "413042017", "story_v_out_413042.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_40 = math.max(var_72_31, arg_69_1.talkMaxDuration)

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_40 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_30) / var_72_40

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_30 + var_72_40 and arg_69_1.time_ < var_72_30 + var_72_40 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_69_1:InitPlayNodeList()
	end,
	Play413042018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413042018
		arg_73_1.duration_ = 6.57

		local var_73_0 = {
			zh = 6.566,
			ja = 5.033
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
				arg_73_0:Play413042019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10097"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10097 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10097", 2)

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
				local var_76_6 = Vector3.New(-390, -350, -180)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10097, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_76_7 = arg_73_1.actors_["10022"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10022 == nil then
				arg_73_1.var_.actorSpriteComps10022 = var_76_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 2

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.actorSpriteComps10022 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								local var_76_11 = Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor2.r, var_76_10)
								local var_76_12 = Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor2.g, var_76_10)
								local var_76_13 = Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor2.b, var_76_10)

								iter_76_2.color = Color.New(var_76_11, var_76_12, var_76_13)
							else
								local var_76_14 = Mathf.Lerp(iter_76_2.color.r, 0.5, var_76_10)

								iter_76_2.color = Color.New(var_76_14, var_76_14, var_76_14)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10022 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_76_4 then
						if arg_73_1.isInRecall_ then
							iter_76_4.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10022 = nil
			end

			local var_76_15 = arg_73_1.actors_["10097"]
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.actorSpriteComps10097 == nil then
				arg_73_1.var_.actorSpriteComps10097 = var_76_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_17 = 2

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 and not isNil(var_76_15) then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17

				if arg_73_1.var_.actorSpriteComps10097 then
					for iter_76_5, iter_76_6 in pairs(arg_73_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_76_6 then
							if arg_73_1.isInRecall_ then
								local var_76_19 = Mathf.Lerp(iter_76_6.color.r, arg_73_1.hightColor1.r, var_76_18)
								local var_76_20 = Mathf.Lerp(iter_76_6.color.g, arg_73_1.hightColor1.g, var_76_18)
								local var_76_21 = Mathf.Lerp(iter_76_6.color.b, arg_73_1.hightColor1.b, var_76_18)

								iter_76_6.color = Color.New(var_76_19, var_76_20, var_76_21)
							else
								local var_76_22 = Mathf.Lerp(iter_76_6.color.r, 1, var_76_18)

								iter_76_6.color = Color.New(var_76_22, var_76_22, var_76_22)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.actorSpriteComps10097 then
				for iter_76_7, iter_76_8 in pairs(arg_73_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_76_8 then
						if arg_73_1.isInRecall_ then
							iter_76_8.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10097 = nil
			end

			local var_76_23 = 0
			local var_76_24 = 0.55

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_25 = arg_73_1:FormatText(StoryNameCfg[1001].name)

				arg_73_1.leftNameTxt_.text = var_76_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_26 = arg_73_1:GetWordFromCfg(413042018)
				local var_76_27 = arg_73_1:FormatText(var_76_26.content)

				arg_73_1.text_.text = var_76_27

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_28 = 22
				local var_76_29 = utf8.len(var_76_27)
				local var_76_30 = var_76_28 <= 0 and var_76_24 or var_76_24 * (var_76_29 / var_76_28)

				if var_76_30 > 0 and var_76_24 < var_76_30 then
					arg_73_1.talkMaxDuration = var_76_30

					if var_76_30 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_30 + var_76_23
					end
				end

				arg_73_1.text_.text = var_76_27
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042018", "story_v_out_413042.awb") ~= 0 then
					local var_76_31 = manager.audio:GetVoiceLength("story_v_out_413042", "413042018", "story_v_out_413042.awb") / 1000

					if var_76_31 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_31 + var_76_23
					end

					if var_76_26.prefab_name ~= "" and arg_73_1.actors_[var_76_26.prefab_name] ~= nil then
						local var_76_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_26.prefab_name].transform, "story_v_out_413042", "413042018", "story_v_out_413042.awb")

						arg_73_1:RecordAudio("413042018", var_76_32)
						arg_73_1:RecordAudio("413042018", var_76_32)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413042", "413042018", "story_v_out_413042.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413042", "413042018", "story_v_out_413042.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_33 = math.max(var_76_24, arg_73_1.talkMaxDuration)

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_33 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_23) / var_76_33

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_23 + var_76_33 and arg_73_1.time_ < var_76_23 + var_76_33 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play413042019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413042019
		arg_77_1.duration_ = 10.9

		local var_77_0 = {
			zh = 6.566,
			ja = 10.9
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
				arg_77_0:Play413042020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.7

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[1001].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(413042019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 28
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042019", "story_v_out_413042.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042019", "story_v_out_413042.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_413042", "413042019", "story_v_out_413042.awb")

						arg_77_1:RecordAudio("413042019", var_80_9)
						arg_77_1:RecordAudio("413042019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413042", "413042019", "story_v_out_413042.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413042", "413042019", "story_v_out_413042.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play413042020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413042020
		arg_81_1.duration_ = 14.33

		local var_81_0 = {
			zh = 4.366,
			ja = 14.333
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
				arg_81_0:Play413042021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10022"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10022 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10022", 0)

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
				local var_84_6 = Vector3.New(-1500, -350, -180)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10022, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_84_7 = arg_81_1.actors_["10097"].transform
			local var_84_8 = 0

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.var_.moveOldPos10097 = var_84_7.localPosition
				var_84_7.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10097", 0)

				local var_84_9 = var_84_7.childCount

				for iter_84_1 = 0, var_84_9 - 1 do
					local var_84_10 = var_84_7:GetChild(iter_84_1)

					if var_84_10.name == "" or not string.find(var_84_10.name, "split") then
						var_84_10.gameObject:SetActive(true)
					else
						var_84_10.gameObject:SetActive(false)
					end
				end
			end

			local var_84_11 = 0.001

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_11 then
				local var_84_12 = (arg_81_1.time_ - var_84_8) / var_84_11
				local var_84_13 = Vector3.New(-1500, -350, -180)

				var_84_7.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10097, var_84_13, var_84_12)
			end

			if arg_81_1.time_ >= var_84_8 + var_84_11 and arg_81_1.time_ < var_84_8 + var_84_11 + arg_84_0 then
				var_84_7.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_84_14 = "10092"

			if arg_81_1.actors_[var_84_14] == nil then
				local var_84_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_84_15) then
					local var_84_16 = Object.Instantiate(var_84_15, arg_81_1.canvasGo_.transform)

					var_84_16.transform:SetSiblingIndex(1)

					var_84_16.name = var_84_14
					var_84_16.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_81_1.actors_[var_84_14] = var_84_16

					local var_84_17 = var_84_16:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_81_1.isInRecall_ then
						for iter_84_2, iter_84_3 in ipairs(var_84_17) do
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_84_18 = arg_81_1.actors_["10092"].transform
			local var_84_19 = 0

			if var_84_19 < arg_81_1.time_ and arg_81_1.time_ <= var_84_19 + arg_84_0 then
				arg_81_1.var_.moveOldPos10092 = var_84_18.localPosition
				var_84_18.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10092", 3)

				local var_84_20 = var_84_18.childCount

				for iter_84_4 = 0, var_84_20 - 1 do
					local var_84_21 = var_84_18:GetChild(iter_84_4)

					if var_84_21.name == "split_5" or not string.find(var_84_21.name, "split") then
						var_84_21.gameObject:SetActive(true)
					else
						var_84_21.gameObject:SetActive(false)
					end
				end
			end

			local var_84_22 = 0.001

			if var_84_19 <= arg_81_1.time_ and arg_81_1.time_ < var_84_19 + var_84_22 then
				local var_84_23 = (arg_81_1.time_ - var_84_19) / var_84_22
				local var_84_24 = Vector3.New(0, -300, -295)

				var_84_18.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10092, var_84_24, var_84_23)
			end

			if arg_81_1.time_ >= var_84_19 + var_84_22 and arg_81_1.time_ < var_84_19 + var_84_22 + arg_84_0 then
				var_84_18.localPosition = Vector3.New(0, -300, -295)
			end

			local var_84_25 = arg_81_1.actors_["10022"]
			local var_84_26 = 0

			if var_84_26 < arg_81_1.time_ and arg_81_1.time_ <= var_84_26 + arg_84_0 and not isNil(var_84_25) and arg_81_1.var_.actorSpriteComps10022 == nil then
				arg_81_1.var_.actorSpriteComps10022 = var_84_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_27 = 2

			if var_84_26 <= arg_81_1.time_ and arg_81_1.time_ < var_84_26 + var_84_27 and not isNil(var_84_25) then
				local var_84_28 = (arg_81_1.time_ - var_84_26) / var_84_27

				if arg_81_1.var_.actorSpriteComps10022 then
					for iter_84_5, iter_84_6 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_84_6 then
							if arg_81_1.isInRecall_ then
								local var_84_29 = Mathf.Lerp(iter_84_6.color.r, arg_81_1.hightColor2.r, var_84_28)
								local var_84_30 = Mathf.Lerp(iter_84_6.color.g, arg_81_1.hightColor2.g, var_84_28)
								local var_84_31 = Mathf.Lerp(iter_84_6.color.b, arg_81_1.hightColor2.b, var_84_28)

								iter_84_6.color = Color.New(var_84_29, var_84_30, var_84_31)
							else
								local var_84_32 = Mathf.Lerp(iter_84_6.color.r, 0.5, var_84_28)

								iter_84_6.color = Color.New(var_84_32, var_84_32, var_84_32)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_26 + var_84_27 and arg_81_1.time_ < var_84_26 + var_84_27 + arg_84_0 and not isNil(var_84_25) and arg_81_1.var_.actorSpriteComps10022 then
				for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_84_8 then
						if arg_81_1.isInRecall_ then
							iter_84_8.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10022 = nil
			end

			local var_84_33 = arg_81_1.actors_["10097"]
			local var_84_34 = 0

			if var_84_34 < arg_81_1.time_ and arg_81_1.time_ <= var_84_34 + arg_84_0 and not isNil(var_84_33) and arg_81_1.var_.actorSpriteComps10097 == nil then
				arg_81_1.var_.actorSpriteComps10097 = var_84_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_35 = 2

			if var_84_34 <= arg_81_1.time_ and arg_81_1.time_ < var_84_34 + var_84_35 and not isNil(var_84_33) then
				local var_84_36 = (arg_81_1.time_ - var_84_34) / var_84_35

				if arg_81_1.var_.actorSpriteComps10097 then
					for iter_84_9, iter_84_10 in pairs(arg_81_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_84_10 then
							if arg_81_1.isInRecall_ then
								local var_84_37 = Mathf.Lerp(iter_84_10.color.r, arg_81_1.hightColor2.r, var_84_36)
								local var_84_38 = Mathf.Lerp(iter_84_10.color.g, arg_81_1.hightColor2.g, var_84_36)
								local var_84_39 = Mathf.Lerp(iter_84_10.color.b, arg_81_1.hightColor2.b, var_84_36)

								iter_84_10.color = Color.New(var_84_37, var_84_38, var_84_39)
							else
								local var_84_40 = Mathf.Lerp(iter_84_10.color.r, 0.5, var_84_36)

								iter_84_10.color = Color.New(var_84_40, var_84_40, var_84_40)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_34 + var_84_35 and arg_81_1.time_ < var_84_34 + var_84_35 + arg_84_0 and not isNil(var_84_33) and arg_81_1.var_.actorSpriteComps10097 then
				for iter_84_11, iter_84_12 in pairs(arg_81_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_84_12 then
						if arg_81_1.isInRecall_ then
							iter_84_12.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10097 = nil
			end

			local var_84_41 = arg_81_1.actors_["10092"]
			local var_84_42 = 0

			if var_84_42 < arg_81_1.time_ and arg_81_1.time_ <= var_84_42 + arg_84_0 and not isNil(var_84_41) and arg_81_1.var_.actorSpriteComps10092 == nil then
				arg_81_1.var_.actorSpriteComps10092 = var_84_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_43 = 2

			if var_84_42 <= arg_81_1.time_ and arg_81_1.time_ < var_84_42 + var_84_43 and not isNil(var_84_41) then
				local var_84_44 = (arg_81_1.time_ - var_84_42) / var_84_43

				if arg_81_1.var_.actorSpriteComps10092 then
					for iter_84_13, iter_84_14 in pairs(arg_81_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_84_14 then
							if arg_81_1.isInRecall_ then
								local var_84_45 = Mathf.Lerp(iter_84_14.color.r, arg_81_1.hightColor1.r, var_84_44)
								local var_84_46 = Mathf.Lerp(iter_84_14.color.g, arg_81_1.hightColor1.g, var_84_44)
								local var_84_47 = Mathf.Lerp(iter_84_14.color.b, arg_81_1.hightColor1.b, var_84_44)

								iter_84_14.color = Color.New(var_84_45, var_84_46, var_84_47)
							else
								local var_84_48 = Mathf.Lerp(iter_84_14.color.r, 1, var_84_44)

								iter_84_14.color = Color.New(var_84_48, var_84_48, var_84_48)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_42 + var_84_43 and arg_81_1.time_ < var_84_42 + var_84_43 + arg_84_0 and not isNil(var_84_41) and arg_81_1.var_.actorSpriteComps10092 then
				for iter_84_15, iter_84_16 in pairs(arg_81_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_84_16 then
						if arg_81_1.isInRecall_ then
							iter_84_16.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_16.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10092 = nil
			end

			local var_84_49 = 0
			local var_84_50 = 0.55

			if var_84_49 < arg_81_1.time_ and arg_81_1.time_ <= var_84_49 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_51 = arg_81_1:FormatText(StoryNameCfg[996].name)

				arg_81_1.leftNameTxt_.text = var_84_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_52 = arg_81_1:GetWordFromCfg(413042020)
				local var_84_53 = arg_81_1:FormatText(var_84_52.content)

				arg_81_1.text_.text = var_84_53

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_54 = 22
				local var_84_55 = utf8.len(var_84_53)
				local var_84_56 = var_84_54 <= 0 and var_84_50 or var_84_50 * (var_84_55 / var_84_54)

				if var_84_56 > 0 and var_84_50 < var_84_56 then
					arg_81_1.talkMaxDuration = var_84_56

					if var_84_56 + var_84_49 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_56 + var_84_49
					end
				end

				arg_81_1.text_.text = var_84_53
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042020", "story_v_out_413042.awb") ~= 0 then
					local var_84_57 = manager.audio:GetVoiceLength("story_v_out_413042", "413042020", "story_v_out_413042.awb") / 1000

					if var_84_57 + var_84_49 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_57 + var_84_49
					end

					if var_84_52.prefab_name ~= "" and arg_81_1.actors_[var_84_52.prefab_name] ~= nil then
						local var_84_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_52.prefab_name].transform, "story_v_out_413042", "413042020", "story_v_out_413042.awb")

						arg_81_1:RecordAudio("413042020", var_84_58)
						arg_81_1:RecordAudio("413042020", var_84_58)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413042", "413042020", "story_v_out_413042.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413042", "413042020", "story_v_out_413042.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_59 = math.max(var_84_50, arg_81_1.talkMaxDuration)

			if var_84_49 <= arg_81_1.time_ and arg_81_1.time_ < var_84_49 + var_84_59 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_49) / var_84_59

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_49 + var_84_59 and arg_81_1.time_ < var_84_49 + var_84_59 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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
				actorName = "10092",
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
	Play413042021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413042021
		arg_85_1.duration_ = 9.83

		local var_85_0 = {
			zh = 9.633,
			ja = 9.833
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
				arg_85_0:Play413042022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.95

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[996].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(413042021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 38
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042021", "story_v_out_413042.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042021", "story_v_out_413042.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_413042", "413042021", "story_v_out_413042.awb")

						arg_85_1:RecordAudio("413042021", var_88_9)
						arg_85_1:RecordAudio("413042021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413042", "413042021", "story_v_out_413042.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413042", "413042021", "story_v_out_413042.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413042022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413042022
		arg_89_1.duration_ = 3.8

		local var_89_0 = {
			zh = 3.6,
			ja = 3.8
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
				arg_89_0:Play413042023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.325

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[996].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(413042022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042022", "story_v_out_413042.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042022", "story_v_out_413042.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_413042", "413042022", "story_v_out_413042.awb")

						arg_89_1:RecordAudio("413042022", var_92_9)
						arg_89_1:RecordAudio("413042022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413042", "413042022", "story_v_out_413042.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413042", "413042022", "story_v_out_413042.awb")
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
	Play413042023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413042023
		arg_93_1.duration_ = 2.47

		local var_93_0 = {
			zh = 1.999999999999,
			ja = 2.466
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
				arg_93_0:Play413042024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10092"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10092 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10092", 0)

				local var_96_2 = var_96_0.childCount

				for iter_96_0 = 0, var_96_2 - 1 do
					local var_96_3 = var_96_0:GetChild(iter_96_0)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_4 then
				local var_96_5 = (arg_93_1.time_ - var_96_1) / var_96_4
				local var_96_6 = Vector3.New(0, -5000, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10092, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_96_7 = arg_93_1.actors_["10022"].transform
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.var_.moveOldPos10022 = var_96_7.localPosition
				var_96_7.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10022", 3)

				local var_96_9 = var_96_7.childCount

				for iter_96_1 = 0, var_96_9 - 1 do
					local var_96_10 = var_96_7:GetChild(iter_96_1)

					if var_96_10.name == "" or not string.find(var_96_10.name, "split") then
						var_96_10.gameObject:SetActive(true)
					else
						var_96_10.gameObject:SetActive(false)
					end
				end
			end

			local var_96_11 = 0.001

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_11 then
				local var_96_12 = (arg_93_1.time_ - var_96_8) / var_96_11
				local var_96_13 = Vector3.New(0, -315, -320)

				var_96_7.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10022, var_96_13, var_96_12)
			end

			if arg_93_1.time_ >= var_96_8 + var_96_11 and arg_93_1.time_ < var_96_8 + var_96_11 + arg_96_0 then
				var_96_7.localPosition = Vector3.New(0, -315, -320)
			end

			local var_96_14 = arg_93_1.actors_["10092"]
			local var_96_15 = 0

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.actorSpriteComps10092 == nil then
				arg_93_1.var_.actorSpriteComps10092 = var_96_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_16 = 2

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_16 and not isNil(var_96_14) then
				local var_96_17 = (arg_93_1.time_ - var_96_15) / var_96_16

				if arg_93_1.var_.actorSpriteComps10092 then
					for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_96_3 then
							if arg_93_1.isInRecall_ then
								local var_96_18 = Mathf.Lerp(iter_96_3.color.r, arg_93_1.hightColor2.r, var_96_17)
								local var_96_19 = Mathf.Lerp(iter_96_3.color.g, arg_93_1.hightColor2.g, var_96_17)
								local var_96_20 = Mathf.Lerp(iter_96_3.color.b, arg_93_1.hightColor2.b, var_96_17)

								iter_96_3.color = Color.New(var_96_18, var_96_19, var_96_20)
							else
								local var_96_21 = Mathf.Lerp(iter_96_3.color.r, 0.5, var_96_17)

								iter_96_3.color = Color.New(var_96_21, var_96_21, var_96_21)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_15 + var_96_16 and arg_93_1.time_ < var_96_15 + var_96_16 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.actorSpriteComps10092 then
				for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_96_5 then
						if arg_93_1.isInRecall_ then
							iter_96_5.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10092 = nil
			end

			local var_96_22 = arg_93_1.actors_["10022"]
			local var_96_23 = 0

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.actorSpriteComps10022 == nil then
				arg_93_1.var_.actorSpriteComps10022 = var_96_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_24 = 2

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_24 and not isNil(var_96_22) then
				local var_96_25 = (arg_93_1.time_ - var_96_23) / var_96_24

				if arg_93_1.var_.actorSpriteComps10022 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_96_7 then
							if arg_93_1.isInRecall_ then
								local var_96_26 = Mathf.Lerp(iter_96_7.color.r, arg_93_1.hightColor1.r, var_96_25)
								local var_96_27 = Mathf.Lerp(iter_96_7.color.g, arg_93_1.hightColor1.g, var_96_25)
								local var_96_28 = Mathf.Lerp(iter_96_7.color.b, arg_93_1.hightColor1.b, var_96_25)

								iter_96_7.color = Color.New(var_96_26, var_96_27, var_96_28)
							else
								local var_96_29 = Mathf.Lerp(iter_96_7.color.r, 1, var_96_25)

								iter_96_7.color = Color.New(var_96_29, var_96_29, var_96_29)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_23 + var_96_24 and arg_93_1.time_ < var_96_23 + var_96_24 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.actorSpriteComps10022 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_96_9 then
						if arg_93_1.isInRecall_ then
							iter_96_9.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10022 = nil
			end

			local var_96_30 = 0
			local var_96_31 = 0.075

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_32 = arg_93_1:FormatText(StoryNameCfg[614].name)

				arg_93_1.leftNameTxt_.text = var_96_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_33 = arg_93_1:GetWordFromCfg(413042023)
				local var_96_34 = arg_93_1:FormatText(var_96_33.content)

				arg_93_1.text_.text = var_96_34

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_35 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042023", "story_v_out_413042.awb") ~= 0 then
					local var_96_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042023", "story_v_out_413042.awb") / 1000

					if var_96_38 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_38 + var_96_30
					end

					if var_96_33.prefab_name ~= "" and arg_93_1.actors_[var_96_33.prefab_name] ~= nil then
						local var_96_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_33.prefab_name].transform, "story_v_out_413042", "413042023", "story_v_out_413042.awb")

						arg_93_1:RecordAudio("413042023", var_96_39)
						arg_93_1:RecordAudio("413042023", var_96_39)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413042", "413042023", "story_v_out_413042.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413042", "413042023", "story_v_out_413042.awb")
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
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_93_1:InitPlayNodeList()
	end,
	Play413042024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413042024
		arg_97_1.duration_ = 2.87

		local var_97_0 = {
			zh = 1.999999999999,
			ja = 2.866
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
				arg_97_0:Play413042025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10092"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10092 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10092", 3)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(0, -300, -295)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10092, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_100_7 = arg_97_1.actors_["10022"].transform
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.var_.moveOldPos10022 = var_100_7.localPosition
				var_100_7.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10022", 0)

				local var_100_9 = var_100_7.childCount

				for iter_100_1 = 0, var_100_9 - 1 do
					local var_100_10 = var_100_7:GetChild(iter_100_1)

					if var_100_10.name == "" or not string.find(var_100_10.name, "split") then
						var_100_10.gameObject:SetActive(true)
					else
						var_100_10.gameObject:SetActive(false)
					end
				end
			end

			local var_100_11 = 0.001

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_11 then
				local var_100_12 = (arg_97_1.time_ - var_100_8) / var_100_11
				local var_100_13 = Vector3.New(0, -5000, 0)

				var_100_7.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10022, var_100_13, var_100_12)
			end

			if arg_97_1.time_ >= var_100_8 + var_100_11 and arg_97_1.time_ < var_100_8 + var_100_11 + arg_100_0 then
				var_100_7.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_100_14 = arg_97_1.actors_["10092"]
			local var_100_15 = 0

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 and not isNil(var_100_14) and arg_97_1.var_.actorSpriteComps10092 == nil then
				arg_97_1.var_.actorSpriteComps10092 = var_100_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_16 = 2

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_16 and not isNil(var_100_14) then
				local var_100_17 = (arg_97_1.time_ - var_100_15) / var_100_16

				if arg_97_1.var_.actorSpriteComps10092 then
					for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_100_3 then
							if arg_97_1.isInRecall_ then
								local var_100_18 = Mathf.Lerp(iter_100_3.color.r, arg_97_1.hightColor1.r, var_100_17)
								local var_100_19 = Mathf.Lerp(iter_100_3.color.g, arg_97_1.hightColor1.g, var_100_17)
								local var_100_20 = Mathf.Lerp(iter_100_3.color.b, arg_97_1.hightColor1.b, var_100_17)

								iter_100_3.color = Color.New(var_100_18, var_100_19, var_100_20)
							else
								local var_100_21 = Mathf.Lerp(iter_100_3.color.r, 1, var_100_17)

								iter_100_3.color = Color.New(var_100_21, var_100_21, var_100_21)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_15 + var_100_16 and arg_97_1.time_ < var_100_15 + var_100_16 + arg_100_0 and not isNil(var_100_14) and arg_97_1.var_.actorSpriteComps10092 then
				for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_100_5 then
						if arg_97_1.isInRecall_ then
							iter_100_5.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10092 = nil
			end

			local var_100_22 = arg_97_1.actors_["10022"]
			local var_100_23 = 0

			if var_100_23 < arg_97_1.time_ and arg_97_1.time_ <= var_100_23 + arg_100_0 and not isNil(var_100_22) and arg_97_1.var_.actorSpriteComps10022 == nil then
				arg_97_1.var_.actorSpriteComps10022 = var_100_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_24 = 2

			if var_100_23 <= arg_97_1.time_ and arg_97_1.time_ < var_100_23 + var_100_24 and not isNil(var_100_22) then
				local var_100_25 = (arg_97_1.time_ - var_100_23) / var_100_24

				if arg_97_1.var_.actorSpriteComps10022 then
					for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_100_7 then
							if arg_97_1.isInRecall_ then
								local var_100_26 = Mathf.Lerp(iter_100_7.color.r, arg_97_1.hightColor2.r, var_100_25)
								local var_100_27 = Mathf.Lerp(iter_100_7.color.g, arg_97_1.hightColor2.g, var_100_25)
								local var_100_28 = Mathf.Lerp(iter_100_7.color.b, arg_97_1.hightColor2.b, var_100_25)

								iter_100_7.color = Color.New(var_100_26, var_100_27, var_100_28)
							else
								local var_100_29 = Mathf.Lerp(iter_100_7.color.r, 0.5, var_100_25)

								iter_100_7.color = Color.New(var_100_29, var_100_29, var_100_29)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_23 + var_100_24 and arg_97_1.time_ < var_100_23 + var_100_24 + arg_100_0 and not isNil(var_100_22) and arg_97_1.var_.actorSpriteComps10022 then
				for iter_100_8, iter_100_9 in pairs(arg_97_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_100_9 then
						if arg_97_1.isInRecall_ then
							iter_100_9.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10022 = nil
			end

			local var_100_30 = 0
			local var_100_31 = 0.075

			if var_100_30 < arg_97_1.time_ and arg_97_1.time_ <= var_100_30 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_32 = arg_97_1:FormatText(StoryNameCfg[996].name)

				arg_97_1.leftNameTxt_.text = var_100_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_33 = arg_97_1:GetWordFromCfg(413042024)
				local var_100_34 = arg_97_1:FormatText(var_100_33.content)

				arg_97_1.text_.text = var_100_34

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_35 = 3
				local var_100_36 = utf8.len(var_100_34)
				local var_100_37 = var_100_35 <= 0 and var_100_31 or var_100_31 * (var_100_36 / var_100_35)

				if var_100_37 > 0 and var_100_31 < var_100_37 then
					arg_97_1.talkMaxDuration = var_100_37

					if var_100_37 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_37 + var_100_30
					end
				end

				arg_97_1.text_.text = var_100_34
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042024", "story_v_out_413042.awb") ~= 0 then
					local var_100_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042024", "story_v_out_413042.awb") / 1000

					if var_100_38 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_38 + var_100_30
					end

					if var_100_33.prefab_name ~= "" and arg_97_1.actors_[var_100_33.prefab_name] ~= nil then
						local var_100_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_33.prefab_name].transform, "story_v_out_413042", "413042024", "story_v_out_413042.awb")

						arg_97_1:RecordAudio("413042024", var_100_39)
						arg_97_1:RecordAudio("413042024", var_100_39)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413042", "413042024", "story_v_out_413042.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413042", "413042024", "story_v_out_413042.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_40 = math.max(var_100_31, arg_97_1.talkMaxDuration)

			if var_100_30 <= arg_97_1.time_ and arg_97_1.time_ < var_100_30 + var_100_40 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_30) / var_100_40

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_30 + var_100_40 and arg_97_1.time_ < var_100_30 + var_100_40 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_97_1:InitPlayNodeList()
	end,
	Play413042025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413042025
		arg_101_1.duration_ = 10.8

		local var_101_0 = {
			zh = 5.633,
			ja = 10.8
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
				arg_101_0:Play413042026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.7

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[996].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(413042025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 28
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042025", "story_v_out_413042.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042025", "story_v_out_413042.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_413042", "413042025", "story_v_out_413042.awb")

						arg_101_1:RecordAudio("413042025", var_104_9)
						arg_101_1:RecordAudio("413042025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413042", "413042025", "story_v_out_413042.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413042", "413042025", "story_v_out_413042.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_10 and arg_101_1.time_ < var_104_0 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play413042026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413042026
		arg_105_1.duration_ = 9.37

		local var_105_0 = {
			zh = 5.333,
			ja = 9.366
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
				arg_105_0:Play413042027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10092"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10092 = var_108_0.localPosition
				var_108_0.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10092", 0)

				local var_108_2 = var_108_0.childCount

				for iter_108_0 = 0, var_108_2 - 1 do
					local var_108_3 = var_108_0:GetChild(iter_108_0)

					if var_108_3.name == "" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_4 then
				local var_108_5 = (arg_105_1.time_ - var_108_1) / var_108_4
				local var_108_6 = Vector3.New(0, -5000, 0)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10092, var_108_6, var_108_5)
			end

			if arg_105_1.time_ >= var_108_1 + var_108_4 and arg_105_1.time_ < var_108_1 + var_108_4 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_108_7 = arg_105_1.actors_["10022"].transform
			local var_108_8 = 0

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.var_.moveOldPos10022 = var_108_7.localPosition
				var_108_7.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10022", 3)

				local var_108_9 = var_108_7.childCount

				for iter_108_1 = 0, var_108_9 - 1 do
					local var_108_10 = var_108_7:GetChild(iter_108_1)

					if var_108_10.name == "" or not string.find(var_108_10.name, "split") then
						var_108_10.gameObject:SetActive(true)
					else
						var_108_10.gameObject:SetActive(false)
					end
				end
			end

			local var_108_11 = 0.001

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_11 then
				local var_108_12 = (arg_105_1.time_ - var_108_8) / var_108_11
				local var_108_13 = Vector3.New(0, -315, -320)

				var_108_7.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10022, var_108_13, var_108_12)
			end

			if arg_105_1.time_ >= var_108_8 + var_108_11 and arg_105_1.time_ < var_108_8 + var_108_11 + arg_108_0 then
				var_108_7.localPosition = Vector3.New(0, -315, -320)
			end

			local var_108_14 = arg_105_1.actors_["10022"]
			local var_108_15 = 0

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 and not isNil(var_108_14) and arg_105_1.var_.actorSpriteComps10022 == nil then
				arg_105_1.var_.actorSpriteComps10022 = var_108_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_16 = 2

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_16 and not isNil(var_108_14) then
				local var_108_17 = (arg_105_1.time_ - var_108_15) / var_108_16

				if arg_105_1.var_.actorSpriteComps10022 then
					for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_108_3 then
							if arg_105_1.isInRecall_ then
								local var_108_18 = Mathf.Lerp(iter_108_3.color.r, arg_105_1.hightColor1.r, var_108_17)
								local var_108_19 = Mathf.Lerp(iter_108_3.color.g, arg_105_1.hightColor1.g, var_108_17)
								local var_108_20 = Mathf.Lerp(iter_108_3.color.b, arg_105_1.hightColor1.b, var_108_17)

								iter_108_3.color = Color.New(var_108_18, var_108_19, var_108_20)
							else
								local var_108_21 = Mathf.Lerp(iter_108_3.color.r, 1, var_108_17)

								iter_108_3.color = Color.New(var_108_21, var_108_21, var_108_21)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_15 + var_108_16 and arg_105_1.time_ < var_108_15 + var_108_16 + arg_108_0 and not isNil(var_108_14) and arg_105_1.var_.actorSpriteComps10022 then
				for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_108_5 then
						if arg_105_1.isInRecall_ then
							iter_108_5.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10022 = nil
			end

			local var_108_22 = 0
			local var_108_23 = 0.675

			if var_108_22 < arg_105_1.time_ and arg_105_1.time_ <= var_108_22 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_24 = arg_105_1:FormatText(StoryNameCfg[614].name)

				arg_105_1.leftNameTxt_.text = var_108_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_25 = arg_105_1:GetWordFromCfg(413042026)
				local var_108_26 = arg_105_1:FormatText(var_108_25.content)

				arg_105_1.text_.text = var_108_26

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_27 = 27
				local var_108_28 = utf8.len(var_108_26)
				local var_108_29 = var_108_27 <= 0 and var_108_23 or var_108_23 * (var_108_28 / var_108_27)

				if var_108_29 > 0 and var_108_23 < var_108_29 then
					arg_105_1.talkMaxDuration = var_108_29

					if var_108_29 + var_108_22 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_29 + var_108_22
					end
				end

				arg_105_1.text_.text = var_108_26
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042026", "story_v_out_413042.awb") ~= 0 then
					local var_108_30 = manager.audio:GetVoiceLength("story_v_out_413042", "413042026", "story_v_out_413042.awb") / 1000

					if var_108_30 + var_108_22 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_30 + var_108_22
					end

					if var_108_25.prefab_name ~= "" and arg_105_1.actors_[var_108_25.prefab_name] ~= nil then
						local var_108_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_25.prefab_name].transform, "story_v_out_413042", "413042026", "story_v_out_413042.awb")

						arg_105_1:RecordAudio("413042026", var_108_31)
						arg_105_1:RecordAudio("413042026", var_108_31)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413042", "413042026", "story_v_out_413042.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413042", "413042026", "story_v_out_413042.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_32 = math.max(var_108_23, arg_105_1.talkMaxDuration)

			if var_108_22 <= arg_105_1.time_ and arg_105_1.time_ < var_108_22 + var_108_32 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_22) / var_108_32

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_22 + var_108_32 and arg_105_1.time_ < var_108_22 + var_108_32 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_105_1:InitPlayNodeList()
	end,
	Play413042027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413042027
		arg_109_1.duration_ = 6.3

		local var_109_0 = {
			zh = 2.766,
			ja = 6.3
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
				arg_109_0:Play413042028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10022"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10022 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10022", 0)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(-1500, -350, -180)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10022, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_112_7 = arg_109_1.actors_["10097"].transform
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.var_.moveOldPos10097 = var_112_7.localPosition
				var_112_7.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10097", 3)

				local var_112_9 = var_112_7.childCount

				for iter_112_1 = 0, var_112_9 - 1 do
					local var_112_10 = var_112_7:GetChild(iter_112_1)

					if var_112_10.name == "" or not string.find(var_112_10.name, "split") then
						var_112_10.gameObject:SetActive(true)
					else
						var_112_10.gameObject:SetActive(false)
					end
				end
			end

			local var_112_11 = 0.001

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_11 then
				local var_112_12 = (arg_109_1.time_ - var_112_8) / var_112_11
				local var_112_13 = Vector3.New(0, -350, -180)

				var_112_7.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10097, var_112_13, var_112_12)
			end

			if arg_109_1.time_ >= var_112_8 + var_112_11 and arg_109_1.time_ < var_112_8 + var_112_11 + arg_112_0 then
				var_112_7.localPosition = Vector3.New(0, -350, -180)
			end

			local var_112_14 = arg_109_1.actors_["10022"]
			local var_112_15 = 0

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 and not isNil(var_112_14) and arg_109_1.var_.actorSpriteComps10022 == nil then
				arg_109_1.var_.actorSpriteComps10022 = var_112_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_16 = 2

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_16 and not isNil(var_112_14) then
				local var_112_17 = (arg_109_1.time_ - var_112_15) / var_112_16

				if arg_109_1.var_.actorSpriteComps10022 then
					for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_112_3 then
							if arg_109_1.isInRecall_ then
								local var_112_18 = Mathf.Lerp(iter_112_3.color.r, arg_109_1.hightColor2.r, var_112_17)
								local var_112_19 = Mathf.Lerp(iter_112_3.color.g, arg_109_1.hightColor2.g, var_112_17)
								local var_112_20 = Mathf.Lerp(iter_112_3.color.b, arg_109_1.hightColor2.b, var_112_17)

								iter_112_3.color = Color.New(var_112_18, var_112_19, var_112_20)
							else
								local var_112_21 = Mathf.Lerp(iter_112_3.color.r, 0.5, var_112_17)

								iter_112_3.color = Color.New(var_112_21, var_112_21, var_112_21)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_15 + var_112_16 and arg_109_1.time_ < var_112_15 + var_112_16 + arg_112_0 and not isNil(var_112_14) and arg_109_1.var_.actorSpriteComps10022 then
				for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_112_5 then
						if arg_109_1.isInRecall_ then
							iter_112_5.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10022 = nil
			end

			local var_112_22 = arg_109_1.actors_["10097"]
			local var_112_23 = 0

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 and not isNil(var_112_22) and arg_109_1.var_.actorSpriteComps10097 == nil then
				arg_109_1.var_.actorSpriteComps10097 = var_112_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_24 = 2

			if var_112_23 <= arg_109_1.time_ and arg_109_1.time_ < var_112_23 + var_112_24 and not isNil(var_112_22) then
				local var_112_25 = (arg_109_1.time_ - var_112_23) / var_112_24

				if arg_109_1.var_.actorSpriteComps10097 then
					for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_112_7 then
							if arg_109_1.isInRecall_ then
								local var_112_26 = Mathf.Lerp(iter_112_7.color.r, arg_109_1.hightColor1.r, var_112_25)
								local var_112_27 = Mathf.Lerp(iter_112_7.color.g, arg_109_1.hightColor1.g, var_112_25)
								local var_112_28 = Mathf.Lerp(iter_112_7.color.b, arg_109_1.hightColor1.b, var_112_25)

								iter_112_7.color = Color.New(var_112_26, var_112_27, var_112_28)
							else
								local var_112_29 = Mathf.Lerp(iter_112_7.color.r, 1, var_112_25)

								iter_112_7.color = Color.New(var_112_29, var_112_29, var_112_29)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_23 + var_112_24 and arg_109_1.time_ < var_112_23 + var_112_24 + arg_112_0 and not isNil(var_112_22) and arg_109_1.var_.actorSpriteComps10097 then
				for iter_112_8, iter_112_9 in pairs(arg_109_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_112_9 then
						if arg_109_1.isInRecall_ then
							iter_112_9.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10097 = nil
			end

			local var_112_30 = 0
			local var_112_31 = 0.35

			if var_112_30 < arg_109_1.time_ and arg_109_1.time_ <= var_112_30 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_32 = arg_109_1:FormatText(StoryNameCfg[1001].name)

				arg_109_1.leftNameTxt_.text = var_112_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_33 = arg_109_1:GetWordFromCfg(413042027)
				local var_112_34 = arg_109_1:FormatText(var_112_33.content)

				arg_109_1.text_.text = var_112_34

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_35 = 14
				local var_112_36 = utf8.len(var_112_34)
				local var_112_37 = var_112_35 <= 0 and var_112_31 or var_112_31 * (var_112_36 / var_112_35)

				if var_112_37 > 0 and var_112_31 < var_112_37 then
					arg_109_1.talkMaxDuration = var_112_37

					if var_112_37 + var_112_30 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_37 + var_112_30
					end
				end

				arg_109_1.text_.text = var_112_34
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042027", "story_v_out_413042.awb") ~= 0 then
					local var_112_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042027", "story_v_out_413042.awb") / 1000

					if var_112_38 + var_112_30 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_38 + var_112_30
					end

					if var_112_33.prefab_name ~= "" and arg_109_1.actors_[var_112_33.prefab_name] ~= nil then
						local var_112_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_33.prefab_name].transform, "story_v_out_413042", "413042027", "story_v_out_413042.awb")

						arg_109_1:RecordAudio("413042027", var_112_39)
						arg_109_1:RecordAudio("413042027", var_112_39)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413042", "413042027", "story_v_out_413042.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413042", "413042027", "story_v_out_413042.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_40 = math.max(var_112_31, arg_109_1.talkMaxDuration)

			if var_112_30 <= arg_109_1.time_ and arg_109_1.time_ < var_112_30 + var_112_40 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_30) / var_112_40

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_30 + var_112_40 and arg_109_1.time_ < var_112_30 + var_112_40 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_109_1:InitPlayNodeList()
	end,
	Play413042028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413042028
		arg_113_1.duration_ = 13.9

		local var_113_0 = {
			zh = 12.2,
			ja = 13.9
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
				arg_113_0:Play413042029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 1.075

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[1001].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(413042028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 43
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042028", "story_v_out_413042.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042028", "story_v_out_413042.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_413042", "413042028", "story_v_out_413042.awb")

						arg_113_1:RecordAudio("413042028", var_116_9)
						arg_113_1:RecordAudio("413042028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413042", "413042028", "story_v_out_413042.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413042", "413042028", "story_v_out_413042.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play413042029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413042029
		arg_117_1.duration_ = 6.47

		local var_117_0 = {
			zh = 2.933,
			ja = 6.466
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
				arg_117_0:Play413042030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10097"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10097 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10097", 0)

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
				local var_120_6 = Vector3.New(-1500, -350, -180)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10097, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_120_7 = arg_117_1.actors_["10022"].transform
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.var_.moveOldPos10022 = var_120_7.localPosition
				var_120_7.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10022", 2)

				local var_120_9 = var_120_7.childCount

				for iter_120_1 = 0, var_120_9 - 1 do
					local var_120_10 = var_120_7:GetChild(iter_120_1)

					if var_120_10.name == "" or not string.find(var_120_10.name, "split") then
						var_120_10.gameObject:SetActive(true)
					else
						var_120_10.gameObject:SetActive(false)
					end
				end
			end

			local var_120_11 = 0.001

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_11 then
				local var_120_12 = (arg_117_1.time_ - var_120_8) / var_120_11
				local var_120_13 = Vector3.New(-390, -315, -320)

				var_120_7.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10022, var_120_13, var_120_12)
			end

			if arg_117_1.time_ >= var_120_8 + var_120_11 and arg_117_1.time_ < var_120_8 + var_120_11 + arg_120_0 then
				var_120_7.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_120_14 = arg_117_1.actors_["10097"]
			local var_120_15 = 0

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.actorSpriteComps10097 == nil then
				arg_117_1.var_.actorSpriteComps10097 = var_120_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_16 = 2

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_16 and not isNil(var_120_14) then
				local var_120_17 = (arg_117_1.time_ - var_120_15) / var_120_16

				if arg_117_1.var_.actorSpriteComps10097 then
					for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_120_3 then
							if arg_117_1.isInRecall_ then
								local var_120_18 = Mathf.Lerp(iter_120_3.color.r, arg_117_1.hightColor2.r, var_120_17)
								local var_120_19 = Mathf.Lerp(iter_120_3.color.g, arg_117_1.hightColor2.g, var_120_17)
								local var_120_20 = Mathf.Lerp(iter_120_3.color.b, arg_117_1.hightColor2.b, var_120_17)

								iter_120_3.color = Color.New(var_120_18, var_120_19, var_120_20)
							else
								local var_120_21 = Mathf.Lerp(iter_120_3.color.r, 0.5, var_120_17)

								iter_120_3.color = Color.New(var_120_21, var_120_21, var_120_21)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_15 + var_120_16 and arg_117_1.time_ < var_120_15 + var_120_16 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.actorSpriteComps10097 then
				for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_120_5 then
						if arg_117_1.isInRecall_ then
							iter_120_5.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10097 = nil
			end

			local var_120_22 = arg_117_1.actors_["10022"]
			local var_120_23 = 0

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 and not isNil(var_120_22) and arg_117_1.var_.actorSpriteComps10022 == nil then
				arg_117_1.var_.actorSpriteComps10022 = var_120_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_24 = 2

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_24 and not isNil(var_120_22) then
				local var_120_25 = (arg_117_1.time_ - var_120_23) / var_120_24

				if arg_117_1.var_.actorSpriteComps10022 then
					for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_120_7 then
							if arg_117_1.isInRecall_ then
								local var_120_26 = Mathf.Lerp(iter_120_7.color.r, arg_117_1.hightColor1.r, var_120_25)
								local var_120_27 = Mathf.Lerp(iter_120_7.color.g, arg_117_1.hightColor1.g, var_120_25)
								local var_120_28 = Mathf.Lerp(iter_120_7.color.b, arg_117_1.hightColor1.b, var_120_25)

								iter_120_7.color = Color.New(var_120_26, var_120_27, var_120_28)
							else
								local var_120_29 = Mathf.Lerp(iter_120_7.color.r, 1, var_120_25)

								iter_120_7.color = Color.New(var_120_29, var_120_29, var_120_29)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_23 + var_120_24 and arg_117_1.time_ < var_120_23 + var_120_24 + arg_120_0 and not isNil(var_120_22) and arg_117_1.var_.actorSpriteComps10022 then
				for iter_120_8, iter_120_9 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_120_9 then
						if arg_117_1.isInRecall_ then
							iter_120_9.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10022 = nil
			end

			local var_120_30 = 0
			local var_120_31 = 0.375

			if var_120_30 < arg_117_1.time_ and arg_117_1.time_ <= var_120_30 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_32 = arg_117_1:FormatText(StoryNameCfg[614].name)

				arg_117_1.leftNameTxt_.text = var_120_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_33 = arg_117_1:GetWordFromCfg(413042029)
				local var_120_34 = arg_117_1:FormatText(var_120_33.content)

				arg_117_1.text_.text = var_120_34

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_35 = 15
				local var_120_36 = utf8.len(var_120_34)
				local var_120_37 = var_120_35 <= 0 and var_120_31 or var_120_31 * (var_120_36 / var_120_35)

				if var_120_37 > 0 and var_120_31 < var_120_37 then
					arg_117_1.talkMaxDuration = var_120_37

					if var_120_37 + var_120_30 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_37 + var_120_30
					end
				end

				arg_117_1.text_.text = var_120_34
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042029", "story_v_out_413042.awb") ~= 0 then
					local var_120_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042029", "story_v_out_413042.awb") / 1000

					if var_120_38 + var_120_30 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_38 + var_120_30
					end

					if var_120_33.prefab_name ~= "" and arg_117_1.actors_[var_120_33.prefab_name] ~= nil then
						local var_120_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_33.prefab_name].transform, "story_v_out_413042", "413042029", "story_v_out_413042.awb")

						arg_117_1:RecordAudio("413042029", var_120_39)
						arg_117_1:RecordAudio("413042029", var_120_39)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413042", "413042029", "story_v_out_413042.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413042", "413042029", "story_v_out_413042.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_40 = math.max(var_120_31, arg_117_1.talkMaxDuration)

			if var_120_30 <= arg_117_1.time_ and arg_117_1.time_ < var_120_30 + var_120_40 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_30) / var_120_40

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_30 + var_120_40 and arg_117_1.time_ < var_120_30 + var_120_40 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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
				actorName = "10022",
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
	Play413042030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 413042030
		arg_121_1.duration_ = 10.3

		local var_121_0 = {
			zh = 9.533,
			ja = 10.3
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play413042031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10092"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10092 = var_124_0.localPosition
				var_124_0.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10092", 4)

				local var_124_2 = var_124_0.childCount

				for iter_124_0 = 0, var_124_2 - 1 do
					local var_124_3 = var_124_0:GetChild(iter_124_0)

					if var_124_3.name == "split_8" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_1) / var_124_4
				local var_124_6 = Vector3.New(390, -300, -295)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10092, var_124_6, var_124_5)
			end

			if arg_121_1.time_ >= var_124_1 + var_124_4 and arg_121_1.time_ < var_124_1 + var_124_4 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_124_7 = arg_121_1.actors_["10022"].transform
			local var_124_8 = 0

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.var_.moveOldPos10022 = var_124_7.localPosition
				var_124_7.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10022", 2)

				local var_124_9 = var_124_7.childCount

				for iter_124_1 = 0, var_124_9 - 1 do
					local var_124_10 = var_124_7:GetChild(iter_124_1)

					if var_124_10.name == "" or not string.find(var_124_10.name, "split") then
						var_124_10.gameObject:SetActive(true)
					else
						var_124_10.gameObject:SetActive(false)
					end
				end
			end

			local var_124_11 = 0.001

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_11 then
				local var_124_12 = (arg_121_1.time_ - var_124_8) / var_124_11
				local var_124_13 = Vector3.New(-390, -315, -320)

				var_124_7.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10022, var_124_13, var_124_12)
			end

			if arg_121_1.time_ >= var_124_8 + var_124_11 and arg_121_1.time_ < var_124_8 + var_124_11 + arg_124_0 then
				var_124_7.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_124_14 = arg_121_1.actors_["10092"]
			local var_124_15 = 0

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.actorSpriteComps10092 == nil then
				arg_121_1.var_.actorSpriteComps10092 = var_124_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_16 = 2

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_16 and not isNil(var_124_14) then
				local var_124_17 = (arg_121_1.time_ - var_124_15) / var_124_16

				if arg_121_1.var_.actorSpriteComps10092 then
					for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_124_3 then
							if arg_121_1.isInRecall_ then
								local var_124_18 = Mathf.Lerp(iter_124_3.color.r, arg_121_1.hightColor1.r, var_124_17)
								local var_124_19 = Mathf.Lerp(iter_124_3.color.g, arg_121_1.hightColor1.g, var_124_17)
								local var_124_20 = Mathf.Lerp(iter_124_3.color.b, arg_121_1.hightColor1.b, var_124_17)

								iter_124_3.color = Color.New(var_124_18, var_124_19, var_124_20)
							else
								local var_124_21 = Mathf.Lerp(iter_124_3.color.r, 1, var_124_17)

								iter_124_3.color = Color.New(var_124_21, var_124_21, var_124_21)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_15 + var_124_16 and arg_121_1.time_ < var_124_15 + var_124_16 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.actorSpriteComps10092 then
				for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_124_5 then
						if arg_121_1.isInRecall_ then
							iter_124_5.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10092 = nil
			end

			local var_124_22 = arg_121_1.actors_["10022"]
			local var_124_23 = 0

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 and not isNil(var_124_22) and arg_121_1.var_.actorSpriteComps10022 == nil then
				arg_121_1.var_.actorSpriteComps10022 = var_124_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_24 = 2

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_24 and not isNil(var_124_22) then
				local var_124_25 = (arg_121_1.time_ - var_124_23) / var_124_24

				if arg_121_1.var_.actorSpriteComps10022 then
					for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_124_7 then
							if arg_121_1.isInRecall_ then
								local var_124_26 = Mathf.Lerp(iter_124_7.color.r, arg_121_1.hightColor2.r, var_124_25)
								local var_124_27 = Mathf.Lerp(iter_124_7.color.g, arg_121_1.hightColor2.g, var_124_25)
								local var_124_28 = Mathf.Lerp(iter_124_7.color.b, arg_121_1.hightColor2.b, var_124_25)

								iter_124_7.color = Color.New(var_124_26, var_124_27, var_124_28)
							else
								local var_124_29 = Mathf.Lerp(iter_124_7.color.r, 0.5, var_124_25)

								iter_124_7.color = Color.New(var_124_29, var_124_29, var_124_29)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_23 + var_124_24 and arg_121_1.time_ < var_124_23 + var_124_24 + arg_124_0 and not isNil(var_124_22) and arg_121_1.var_.actorSpriteComps10022 then
				for iter_124_8, iter_124_9 in pairs(arg_121_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_124_9 then
						if arg_121_1.isInRecall_ then
							iter_124_9.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10022 = nil
			end

			local var_124_30 = 0
			local var_124_31 = 1.175

			if var_124_30 < arg_121_1.time_ and arg_121_1.time_ <= var_124_30 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_32 = arg_121_1:FormatText(StoryNameCfg[996].name)

				arg_121_1.leftNameTxt_.text = var_124_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_33 = arg_121_1:GetWordFromCfg(413042030)
				local var_124_34 = arg_121_1:FormatText(var_124_33.content)

				arg_121_1.text_.text = var_124_34

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_35 = 47
				local var_124_36 = utf8.len(var_124_34)
				local var_124_37 = var_124_35 <= 0 and var_124_31 or var_124_31 * (var_124_36 / var_124_35)

				if var_124_37 > 0 and var_124_31 < var_124_37 then
					arg_121_1.talkMaxDuration = var_124_37

					if var_124_37 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_37 + var_124_30
					end
				end

				arg_121_1.text_.text = var_124_34
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042030", "story_v_out_413042.awb") ~= 0 then
					local var_124_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042030", "story_v_out_413042.awb") / 1000

					if var_124_38 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_38 + var_124_30
					end

					if var_124_33.prefab_name ~= "" and arg_121_1.actors_[var_124_33.prefab_name] ~= nil then
						local var_124_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_33.prefab_name].transform, "story_v_out_413042", "413042030", "story_v_out_413042.awb")

						arg_121_1:RecordAudio("413042030", var_124_39)
						arg_121_1:RecordAudio("413042030", var_124_39)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_413042", "413042030", "story_v_out_413042.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_413042", "413042030", "story_v_out_413042.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_40 = math.max(var_124_31, arg_121_1.talkMaxDuration)

			if var_124_30 <= arg_121_1.time_ and arg_121_1.time_ < var_124_30 + var_124_40 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_30) / var_124_40

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_30 + var_124_40 and arg_121_1.time_ < var_124_30 + var_124_40 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_121_1:InitPlayNodeList()
	end,
	Play413042031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 413042031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play413042032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10092"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10092 == nil then
				arg_125_1.var_.actorSpriteComps10092 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps10092 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								local var_128_4 = Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor2.r, var_128_3)
								local var_128_5 = Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor2.g, var_128_3)
								local var_128_6 = Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor2.b, var_128_3)

								iter_128_1.color = Color.New(var_128_4, var_128_5, var_128_6)
							else
								local var_128_7 = Mathf.Lerp(iter_128_1.color.r, 0.5, var_128_3)

								iter_128_1.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10092 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10092 = nil
			end

			local var_128_8 = 0
			local var_128_9 = 1.25

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(413042031)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_12 = 50
				local var_128_13 = utf8.len(var_128_11)
				local var_128_14 = var_128_12 <= 0 and var_128_9 or var_128_9 * (var_128_13 / var_128_12)

				if var_128_14 > 0 and var_128_9 < var_128_14 then
					arg_125_1.talkMaxDuration = var_128_14

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_15 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_15 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_15

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_15 and arg_125_1.time_ < var_128_8 + var_128_15 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play413042032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413042032
		arg_129_1.duration_ = 2.93

		local var_129_0 = {
			zh = 2.933,
			ja = 1.999999999999
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
				arg_129_0:Play413042033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10092"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10092 == nil then
				arg_129_1.var_.actorSpriteComps10092 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps10092 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								local var_132_4 = Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, var_132_3)
								local var_132_5 = Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, var_132_3)
								local var_132_6 = Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, var_132_3)

								iter_132_1.color = Color.New(var_132_4, var_132_5, var_132_6)
							else
								local var_132_7 = Mathf.Lerp(iter_132_1.color.r, 1, var_132_3)

								iter_132_1.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10092 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10092 = nil
			end

			local var_132_8 = 0
			local var_132_9 = 0.15

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_10 = arg_129_1:FormatText(StoryNameCfg[996].name)

				arg_129_1.leftNameTxt_.text = var_132_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_11 = arg_129_1:GetWordFromCfg(413042032)
				local var_132_12 = arg_129_1:FormatText(var_132_11.content)

				arg_129_1.text_.text = var_132_12

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 6
				local var_132_14 = utf8.len(var_132_12)
				local var_132_15 = var_132_13 <= 0 and var_132_9 or var_132_9 * (var_132_14 / var_132_13)

				if var_132_15 > 0 and var_132_9 < var_132_15 then
					arg_129_1.talkMaxDuration = var_132_15

					if var_132_15 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_15 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_12
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042032", "story_v_out_413042.awb") ~= 0 then
					local var_132_16 = manager.audio:GetVoiceLength("story_v_out_413042", "413042032", "story_v_out_413042.awb") / 1000

					if var_132_16 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_16 + var_132_8
					end

					if var_132_11.prefab_name ~= "" and arg_129_1.actors_[var_132_11.prefab_name] ~= nil then
						local var_132_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_11.prefab_name].transform, "story_v_out_413042", "413042032", "story_v_out_413042.awb")

						arg_129_1:RecordAudio("413042032", var_132_17)
						arg_129_1:RecordAudio("413042032", var_132_17)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413042", "413042032", "story_v_out_413042.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413042", "413042032", "story_v_out_413042.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_18 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_18 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_18

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_18 and arg_129_1.time_ < var_132_8 + var_132_18 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play413042033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413042033
		arg_133_1.duration_ = 6.03

		local var_133_0 = {
			zh = 4.866,
			ja = 6.033
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
				arg_133_0:Play413042034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10022"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10022 = var_136_0.localPosition
				var_136_0.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10022", 2)

				local var_136_2 = var_136_0.childCount

				for iter_136_0 = 0, var_136_2 - 1 do
					local var_136_3 = var_136_0:GetChild(iter_136_0)

					if var_136_3.name == "split_8" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_4 then
				local var_136_5 = (arg_133_1.time_ - var_136_1) / var_136_4
				local var_136_6 = Vector3.New(-390, -315, -320)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10022, var_136_6, var_136_5)
			end

			if arg_133_1.time_ >= var_136_1 + var_136_4 and arg_133_1.time_ < var_136_1 + var_136_4 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(-390, -315, -320)
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

			local var_136_15 = arg_133_1.actors_["10092"]
			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 and not isNil(var_136_15) and arg_133_1.var_.actorSpriteComps10092 == nil then
				arg_133_1.var_.actorSpriteComps10092 = var_136_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_17 = 2

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_17 and not isNil(var_136_15) then
				local var_136_18 = (arg_133_1.time_ - var_136_16) / var_136_17

				if arg_133_1.var_.actorSpriteComps10092 then
					for iter_136_5, iter_136_6 in pairs(arg_133_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_136_6 then
							if arg_133_1.isInRecall_ then
								local var_136_19 = Mathf.Lerp(iter_136_6.color.r, arg_133_1.hightColor2.r, var_136_18)
								local var_136_20 = Mathf.Lerp(iter_136_6.color.g, arg_133_1.hightColor2.g, var_136_18)
								local var_136_21 = Mathf.Lerp(iter_136_6.color.b, arg_133_1.hightColor2.b, var_136_18)

								iter_136_6.color = Color.New(var_136_19, var_136_20, var_136_21)
							else
								local var_136_22 = Mathf.Lerp(iter_136_6.color.r, 0.5, var_136_18)

								iter_136_6.color = Color.New(var_136_22, var_136_22, var_136_22)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_16 + var_136_17 and arg_133_1.time_ < var_136_16 + var_136_17 + arg_136_0 and not isNil(var_136_15) and arg_133_1.var_.actorSpriteComps10092 then
				for iter_136_7, iter_136_8 in pairs(arg_133_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_136_8 then
						if arg_133_1.isInRecall_ then
							iter_136_8.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10092 = nil
			end

			local var_136_23 = 0
			local var_136_24 = 0.675

			if var_136_23 < arg_133_1.time_ and arg_133_1.time_ <= var_136_23 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_25 = arg_133_1:FormatText(StoryNameCfg[614].name)

				arg_133_1.leftNameTxt_.text = var_136_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_26 = arg_133_1:GetWordFromCfg(413042033)
				local var_136_27 = arg_133_1:FormatText(var_136_26.content)

				arg_133_1.text_.text = var_136_27

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_28 = 27
				local var_136_29 = utf8.len(var_136_27)
				local var_136_30 = var_136_28 <= 0 and var_136_24 or var_136_24 * (var_136_29 / var_136_28)

				if var_136_30 > 0 and var_136_24 < var_136_30 then
					arg_133_1.talkMaxDuration = var_136_30

					if var_136_30 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_30 + var_136_23
					end
				end

				arg_133_1.text_.text = var_136_27
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042033", "story_v_out_413042.awb") ~= 0 then
					local var_136_31 = manager.audio:GetVoiceLength("story_v_out_413042", "413042033", "story_v_out_413042.awb") / 1000

					if var_136_31 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_31 + var_136_23
					end

					if var_136_26.prefab_name ~= "" and arg_133_1.actors_[var_136_26.prefab_name] ~= nil then
						local var_136_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_26.prefab_name].transform, "story_v_out_413042", "413042033", "story_v_out_413042.awb")

						arg_133_1:RecordAudio("413042033", var_136_32)
						arg_133_1:RecordAudio("413042033", var_136_32)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413042", "413042033", "story_v_out_413042.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413042", "413042033", "story_v_out_413042.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_33 = math.max(var_136_24, arg_133_1.talkMaxDuration)

			if var_136_23 <= arg_133_1.time_ and arg_133_1.time_ < var_136_23 + var_136_33 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_23) / var_136_33

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_23 + var_136_33 and arg_133_1.time_ < var_136_23 + var_136_33 + arg_136_0 then
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
	Play413042034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413042034
		arg_137_1.duration_ = 9

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play413042035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 2

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				local var_140_1 = manager.ui.mainCamera.transform.localPosition
				local var_140_2 = Vector3.New(0, 0, 10) + Vector3.New(var_140_1.x, var_140_1.y, 0)
				local var_140_3 = arg_137_1.bgs_.F10f

				var_140_3.transform.localPosition = var_140_2
				var_140_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_4 = var_140_3:GetComponent("SpriteRenderer")

				if var_140_4 and var_140_4.sprite then
					local var_140_5 = (var_140_3.transform.localPosition - var_140_1).z
					local var_140_6 = manager.ui.mainCameraCom_
					local var_140_7 = 2 * var_140_5 * Mathf.Tan(var_140_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_140_8 = var_140_7 * var_140_6.aspect
					local var_140_9 = var_140_4.sprite.bounds.size.x
					local var_140_10 = var_140_4.sprite.bounds.size.y
					local var_140_11 = var_140_8 / var_140_9
					local var_140_12 = var_140_7 / var_140_10
					local var_140_13 = var_140_12 < var_140_11 and var_140_11 or var_140_12

					var_140_3.transform.localScale = Vector3.New(var_140_13, var_140_13, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "F10f" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_14 = 4

			if var_140_14 < arg_137_1.time_ and arg_137_1.time_ <= var_140_14 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			local var_140_15 = 0.3

			if arg_137_1.time_ >= var_140_14 + var_140_15 and arg_137_1.time_ < var_140_14 + var_140_15 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end

			local var_140_16 = 0

			if var_140_16 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_17 = 2

			if var_140_16 <= arg_137_1.time_ and arg_137_1.time_ < var_140_16 + var_140_17 then
				local var_140_18 = (arg_137_1.time_ - var_140_16) / var_140_17
				local var_140_19 = Color.New(0, 0, 0)

				var_140_19.a = Mathf.Lerp(0, 1, var_140_18)
				arg_137_1.mask_.color = var_140_19
			end

			if arg_137_1.time_ >= var_140_16 + var_140_17 and arg_137_1.time_ < var_140_16 + var_140_17 + arg_140_0 then
				local var_140_20 = Color.New(0, 0, 0)

				var_140_20.a = 1
				arg_137_1.mask_.color = var_140_20
			end

			local var_140_21 = 2

			if var_140_21 < arg_137_1.time_ and arg_137_1.time_ <= var_140_21 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_22 = 2

			if var_140_21 <= arg_137_1.time_ and arg_137_1.time_ < var_140_21 + var_140_22 then
				local var_140_23 = (arg_137_1.time_ - var_140_21) / var_140_22
				local var_140_24 = Color.New(0, 0, 0)

				var_140_24.a = Mathf.Lerp(1, 0, var_140_23)
				arg_137_1.mask_.color = var_140_24
			end

			if arg_137_1.time_ >= var_140_21 + var_140_22 and arg_137_1.time_ < var_140_21 + var_140_22 + arg_140_0 then
				local var_140_25 = Color.New(0, 0, 0)
				local var_140_26 = 0

				arg_137_1.mask_.enabled = false
				var_140_25.a = var_140_26
				arg_137_1.mask_.color = var_140_25
			end

			local var_140_27 = arg_137_1.actors_["10022"].transform
			local var_140_28 = 1.966

			if var_140_28 < arg_137_1.time_ and arg_137_1.time_ <= var_140_28 + arg_140_0 then
				arg_137_1.var_.moveOldPos10022 = var_140_27.localPosition
				var_140_27.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10022", 0)

				local var_140_29 = var_140_27.childCount

				for iter_140_2 = 0, var_140_29 - 1 do
					local var_140_30 = var_140_27:GetChild(iter_140_2)

					if var_140_30.name == "" or not string.find(var_140_30.name, "split") then
						var_140_30.gameObject:SetActive(true)
					else
						var_140_30.gameObject:SetActive(false)
					end
				end
			end

			local var_140_31 = 0.001

			if var_140_28 <= arg_137_1.time_ and arg_137_1.time_ < var_140_28 + var_140_31 then
				local var_140_32 = (arg_137_1.time_ - var_140_28) / var_140_31
				local var_140_33 = Vector3.New(-1500, -350, -180)

				var_140_27.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10022, var_140_33, var_140_32)
			end

			if arg_137_1.time_ >= var_140_28 + var_140_31 and arg_137_1.time_ < var_140_28 + var_140_31 + arg_140_0 then
				var_140_27.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_140_34 = arg_137_1.actors_["10092"].transform
			local var_140_35 = 1.966

			if var_140_35 < arg_137_1.time_ and arg_137_1.time_ <= var_140_35 + arg_140_0 then
				arg_137_1.var_.moveOldPos10092 = var_140_34.localPosition
				var_140_34.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10092", 0)

				local var_140_36 = var_140_34.childCount

				for iter_140_3 = 0, var_140_36 - 1 do
					local var_140_37 = var_140_34:GetChild(iter_140_3)

					if var_140_37.name == "" or not string.find(var_140_37.name, "split") then
						var_140_37.gameObject:SetActive(true)
					else
						var_140_37.gameObject:SetActive(false)
					end
				end
			end

			local var_140_38 = 0.001

			if var_140_35 <= arg_137_1.time_ and arg_137_1.time_ < var_140_35 + var_140_38 then
				local var_140_39 = (arg_137_1.time_ - var_140_35) / var_140_38
				local var_140_40 = Vector3.New(0, -5000, 0)

				var_140_34.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10092, var_140_40, var_140_39)
			end

			if arg_137_1.time_ >= var_140_35 + var_140_38 and arg_137_1.time_ < var_140_35 + var_140_38 + arg_140_0 then
				var_140_34.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_140_41 = arg_137_1.actors_["10022"]
			local var_140_42 = 1.966

			if var_140_42 < arg_137_1.time_ and arg_137_1.time_ <= var_140_42 + arg_140_0 and not isNil(var_140_41) and arg_137_1.var_.actorSpriteComps10022 == nil then
				arg_137_1.var_.actorSpriteComps10022 = var_140_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_43 = 0.034

			if var_140_42 <= arg_137_1.time_ and arg_137_1.time_ < var_140_42 + var_140_43 and not isNil(var_140_41) then
				local var_140_44 = (arg_137_1.time_ - var_140_42) / var_140_43

				if arg_137_1.var_.actorSpriteComps10022 then
					for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_140_5 then
							if arg_137_1.isInRecall_ then
								local var_140_45 = Mathf.Lerp(iter_140_5.color.r, arg_137_1.hightColor2.r, var_140_44)
								local var_140_46 = Mathf.Lerp(iter_140_5.color.g, arg_137_1.hightColor2.g, var_140_44)
								local var_140_47 = Mathf.Lerp(iter_140_5.color.b, arg_137_1.hightColor2.b, var_140_44)

								iter_140_5.color = Color.New(var_140_45, var_140_46, var_140_47)
							else
								local var_140_48 = Mathf.Lerp(iter_140_5.color.r, 0.5, var_140_44)

								iter_140_5.color = Color.New(var_140_48, var_140_48, var_140_48)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_42 + var_140_43 and arg_137_1.time_ < var_140_42 + var_140_43 + arg_140_0 and not isNil(var_140_41) and arg_137_1.var_.actorSpriteComps10022 then
				for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_140_7 then
						if arg_137_1.isInRecall_ then
							iter_140_7.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10022 = nil
			end

			local var_140_49 = arg_137_1.actors_["10092"]
			local var_140_50 = 1.966

			if var_140_50 < arg_137_1.time_ and arg_137_1.time_ <= var_140_50 + arg_140_0 and not isNil(var_140_49) and arg_137_1.var_.actorSpriteComps10092 == nil then
				arg_137_1.var_.actorSpriteComps10092 = var_140_49:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_51 = 0.034

			if var_140_50 <= arg_137_1.time_ and arg_137_1.time_ < var_140_50 + var_140_51 and not isNil(var_140_49) then
				local var_140_52 = (arg_137_1.time_ - var_140_50) / var_140_51

				if arg_137_1.var_.actorSpriteComps10092 then
					for iter_140_8, iter_140_9 in pairs(arg_137_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_140_9 then
							if arg_137_1.isInRecall_ then
								local var_140_53 = Mathf.Lerp(iter_140_9.color.r, arg_137_1.hightColor2.r, var_140_52)
								local var_140_54 = Mathf.Lerp(iter_140_9.color.g, arg_137_1.hightColor2.g, var_140_52)
								local var_140_55 = Mathf.Lerp(iter_140_9.color.b, arg_137_1.hightColor2.b, var_140_52)

								iter_140_9.color = Color.New(var_140_53, var_140_54, var_140_55)
							else
								local var_140_56 = Mathf.Lerp(iter_140_9.color.r, 0.5, var_140_52)

								iter_140_9.color = Color.New(var_140_56, var_140_56, var_140_56)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_50 + var_140_51 and arg_137_1.time_ < var_140_50 + var_140_51 + arg_140_0 and not isNil(var_140_49) and arg_137_1.var_.actorSpriteComps10092 then
				for iter_140_10, iter_140_11 in pairs(arg_137_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_140_11 then
						if arg_137_1.isInRecall_ then
							iter_140_11.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10092 = nil
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_57 = 4
			local var_140_58 = 1.175

			if var_140_57 < arg_137_1.time_ and arg_137_1.time_ <= var_140_57 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_59 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_59:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_60 = arg_137_1:GetWordFromCfg(413042034)
				local var_140_61 = arg_137_1:FormatText(var_140_60.content)

				arg_137_1.text_.text = var_140_61

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_62 = 47
				local var_140_63 = utf8.len(var_140_61)
				local var_140_64 = var_140_62 <= 0 and var_140_58 or var_140_58 * (var_140_63 / var_140_62)

				if var_140_64 > 0 and var_140_58 < var_140_64 then
					arg_137_1.talkMaxDuration = var_140_64
					var_140_57 = var_140_57 + 0.3

					if var_140_64 + var_140_57 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_64 + var_140_57
					end
				end

				arg_137_1.text_.text = var_140_61
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_65 = var_140_57 + 0.3
			local var_140_66 = math.max(var_140_58, arg_137_1.talkMaxDuration)

			if var_140_65 <= arg_137_1.time_ and arg_137_1.time_ < var_140_65 + var_140_66 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_65) / var_140_66

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_65 + var_140_66 and arg_137_1.time_ < var_140_65 + var_140_66 + arg_140_0 then
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
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play413042035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413042035
		arg_143_1.duration_ = 8.67

		local var_143_0 = {
			zh = 5.133,
			ja = 8.666
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
				arg_143_0:Play413042036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = "10094"

			if arg_143_1.actors_[var_146_0] == nil then
				local var_146_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_146_1) then
					local var_146_2 = Object.Instantiate(var_146_1, arg_143_1.canvasGo_.transform)

					var_146_2.transform:SetSiblingIndex(1)

					var_146_2.name = var_146_0
					var_146_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_143_1.actors_[var_146_0] = var_146_2

					local var_146_3 = var_146_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_143_1.isInRecall_ then
						for iter_146_0, iter_146_1 in ipairs(var_146_3) do
							iter_146_1.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_146_4 = arg_143_1.actors_["10094"].transform
			local var_146_5 = 0

			if var_146_5 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.var_.moveOldPos10094 = var_146_4.localPosition
				var_146_4.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10094", 3)

				local var_146_6 = var_146_4.childCount

				for iter_146_2 = 0, var_146_6 - 1 do
					local var_146_7 = var_146_4:GetChild(iter_146_2)

					if var_146_7.name == "" or not string.find(var_146_7.name, "split") then
						var_146_7.gameObject:SetActive(true)
					else
						var_146_7.gameObject:SetActive(false)
					end
				end
			end

			local var_146_8 = 0.001

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_8 then
				local var_146_9 = (arg_143_1.time_ - var_146_5) / var_146_8
				local var_146_10 = Vector3.New(0, -340, -414)

				var_146_4.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10094, var_146_10, var_146_9)
			end

			if arg_143_1.time_ >= var_146_5 + var_146_8 and arg_143_1.time_ < var_146_5 + var_146_8 + arg_146_0 then
				var_146_4.localPosition = Vector3.New(0, -340, -414)
			end

			local var_146_11 = arg_143_1.actors_["10094"]
			local var_146_12 = 0

			if var_146_12 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 and not isNil(var_146_11) and arg_143_1.var_.actorSpriteComps10094 == nil then
				arg_143_1.var_.actorSpriteComps10094 = var_146_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_13 = 2

			if var_146_12 <= arg_143_1.time_ and arg_143_1.time_ < var_146_12 + var_146_13 and not isNil(var_146_11) then
				local var_146_14 = (arg_143_1.time_ - var_146_12) / var_146_13

				if arg_143_1.var_.actorSpriteComps10094 then
					for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_146_4 then
							if arg_143_1.isInRecall_ then
								local var_146_15 = Mathf.Lerp(iter_146_4.color.r, arg_143_1.hightColor1.r, var_146_14)
								local var_146_16 = Mathf.Lerp(iter_146_4.color.g, arg_143_1.hightColor1.g, var_146_14)
								local var_146_17 = Mathf.Lerp(iter_146_4.color.b, arg_143_1.hightColor1.b, var_146_14)

								iter_146_4.color = Color.New(var_146_15, var_146_16, var_146_17)
							else
								local var_146_18 = Mathf.Lerp(iter_146_4.color.r, 1, var_146_14)

								iter_146_4.color = Color.New(var_146_18, var_146_18, var_146_18)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_12 + var_146_13 and arg_143_1.time_ < var_146_12 + var_146_13 + arg_146_0 and not isNil(var_146_11) and arg_143_1.var_.actorSpriteComps10094 then
				for iter_146_5, iter_146_6 in pairs(arg_143_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_146_6 then
						if arg_143_1.isInRecall_ then
							iter_146_6.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10094 = nil
			end

			local var_146_19 = 0
			local var_146_20 = 0.45

			if var_146_19 < arg_143_1.time_ and arg_143_1.time_ <= var_146_19 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_21 = arg_143_1:FormatText(StoryNameCfg[259].name)

				arg_143_1.leftNameTxt_.text = var_146_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_22 = arg_143_1:GetWordFromCfg(413042035)
				local var_146_23 = arg_143_1:FormatText(var_146_22.content)

				arg_143_1.text_.text = var_146_23

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_24 = 18
				local var_146_25 = utf8.len(var_146_23)
				local var_146_26 = var_146_24 <= 0 and var_146_20 or var_146_20 * (var_146_25 / var_146_24)

				if var_146_26 > 0 and var_146_20 < var_146_26 then
					arg_143_1.talkMaxDuration = var_146_26

					if var_146_26 + var_146_19 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_26 + var_146_19
					end
				end

				arg_143_1.text_.text = var_146_23
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042035", "story_v_out_413042.awb") ~= 0 then
					local var_146_27 = manager.audio:GetVoiceLength("story_v_out_413042", "413042035", "story_v_out_413042.awb") / 1000

					if var_146_27 + var_146_19 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_27 + var_146_19
					end

					if var_146_22.prefab_name ~= "" and arg_143_1.actors_[var_146_22.prefab_name] ~= nil then
						local var_146_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_22.prefab_name].transform, "story_v_out_413042", "413042035", "story_v_out_413042.awb")

						arg_143_1:RecordAudio("413042035", var_146_28)
						arg_143_1:RecordAudio("413042035", var_146_28)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413042", "413042035", "story_v_out_413042.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413042", "413042035", "story_v_out_413042.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_29 = math.max(var_146_20, arg_143_1.talkMaxDuration)

			if var_146_19 <= arg_143_1.time_ and arg_143_1.time_ < var_146_19 + var_146_29 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_19) / var_146_29

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_19 + var_146_29 and arg_143_1.time_ < var_146_19 + var_146_29 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play413042036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413042036
		arg_147_1.duration_ = 11.5

		local var_147_0 = {
			zh = 5.9,
			ja = 11.5
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
				arg_147_0:Play413042037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10094"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos10094 = var_150_0.localPosition
				var_150_0.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10094", 0)

				local var_150_2 = var_150_0.childCount

				for iter_150_0 = 0, var_150_2 - 1 do
					local var_150_3 = var_150_0:GetChild(iter_150_0)

					if var_150_3.name == "" or not string.find(var_150_3.name, "split") then
						var_150_3.gameObject:SetActive(true)
					else
						var_150_3.gameObject:SetActive(false)
					end
				end
			end

			local var_150_4 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_4 then
				local var_150_5 = (arg_147_1.time_ - var_150_1) / var_150_4
				local var_150_6 = Vector3.New(-5000, -340, -414)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10094, var_150_6, var_150_5)
			end

			if arg_147_1.time_ >= var_150_1 + var_150_4 and arg_147_1.time_ < var_150_1 + var_150_4 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_150_7 = arg_147_1.actors_["10022"].transform
			local var_150_8 = 0

			if var_150_8 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.var_.moveOldPos10022 = var_150_7.localPosition
				var_150_7.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10022", 3)

				local var_150_9 = var_150_7.childCount

				for iter_150_1 = 0, var_150_9 - 1 do
					local var_150_10 = var_150_7:GetChild(iter_150_1)

					if var_150_10.name == "" or not string.find(var_150_10.name, "split") then
						var_150_10.gameObject:SetActive(true)
					else
						var_150_10.gameObject:SetActive(false)
					end
				end
			end

			local var_150_11 = 0.001

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_11 then
				local var_150_12 = (arg_147_1.time_ - var_150_8) / var_150_11
				local var_150_13 = Vector3.New(0, -315, -320)

				var_150_7.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10022, var_150_13, var_150_12)
			end

			if arg_147_1.time_ >= var_150_8 + var_150_11 and arg_147_1.time_ < var_150_8 + var_150_11 + arg_150_0 then
				var_150_7.localPosition = Vector3.New(0, -315, -320)
			end

			local var_150_14 = arg_147_1.actors_["10094"]
			local var_150_15 = 0

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 and not isNil(var_150_14) and arg_147_1.var_.actorSpriteComps10094 == nil then
				arg_147_1.var_.actorSpriteComps10094 = var_150_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_16 = 2

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_16 and not isNil(var_150_14) then
				local var_150_17 = (arg_147_1.time_ - var_150_15) / var_150_16

				if arg_147_1.var_.actorSpriteComps10094 then
					for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_150_3 then
							if arg_147_1.isInRecall_ then
								local var_150_18 = Mathf.Lerp(iter_150_3.color.r, arg_147_1.hightColor2.r, var_150_17)
								local var_150_19 = Mathf.Lerp(iter_150_3.color.g, arg_147_1.hightColor2.g, var_150_17)
								local var_150_20 = Mathf.Lerp(iter_150_3.color.b, arg_147_1.hightColor2.b, var_150_17)

								iter_150_3.color = Color.New(var_150_18, var_150_19, var_150_20)
							else
								local var_150_21 = Mathf.Lerp(iter_150_3.color.r, 0.5, var_150_17)

								iter_150_3.color = Color.New(var_150_21, var_150_21, var_150_21)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_15 + var_150_16 and arg_147_1.time_ < var_150_15 + var_150_16 + arg_150_0 and not isNil(var_150_14) and arg_147_1.var_.actorSpriteComps10094 then
				for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_150_5 then
						if arg_147_1.isInRecall_ then
							iter_150_5.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10094 = nil
			end

			local var_150_22 = arg_147_1.actors_["10022"]
			local var_150_23 = 0

			if var_150_23 < arg_147_1.time_ and arg_147_1.time_ <= var_150_23 + arg_150_0 and not isNil(var_150_22) and arg_147_1.var_.actorSpriteComps10022 == nil then
				arg_147_1.var_.actorSpriteComps10022 = var_150_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_24 = 2

			if var_150_23 <= arg_147_1.time_ and arg_147_1.time_ < var_150_23 + var_150_24 and not isNil(var_150_22) then
				local var_150_25 = (arg_147_1.time_ - var_150_23) / var_150_24

				if arg_147_1.var_.actorSpriteComps10022 then
					for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_150_7 then
							if arg_147_1.isInRecall_ then
								local var_150_26 = Mathf.Lerp(iter_150_7.color.r, arg_147_1.hightColor1.r, var_150_25)
								local var_150_27 = Mathf.Lerp(iter_150_7.color.g, arg_147_1.hightColor1.g, var_150_25)
								local var_150_28 = Mathf.Lerp(iter_150_7.color.b, arg_147_1.hightColor1.b, var_150_25)

								iter_150_7.color = Color.New(var_150_26, var_150_27, var_150_28)
							else
								local var_150_29 = Mathf.Lerp(iter_150_7.color.r, 1, var_150_25)

								iter_150_7.color = Color.New(var_150_29, var_150_29, var_150_29)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_23 + var_150_24 and arg_147_1.time_ < var_150_23 + var_150_24 + arg_150_0 and not isNil(var_150_22) and arg_147_1.var_.actorSpriteComps10022 then
				for iter_150_8, iter_150_9 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_150_9 then
						if arg_147_1.isInRecall_ then
							iter_150_9.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10022 = nil
			end

			local var_150_30 = 0
			local var_150_31 = 0.775

			if var_150_30 < arg_147_1.time_ and arg_147_1.time_ <= var_150_30 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_32 = arg_147_1:FormatText(StoryNameCfg[614].name)

				arg_147_1.leftNameTxt_.text = var_150_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_33 = arg_147_1:GetWordFromCfg(413042036)
				local var_150_34 = arg_147_1:FormatText(var_150_33.content)

				arg_147_1.text_.text = var_150_34

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_35 = 31
				local var_150_36 = utf8.len(var_150_34)
				local var_150_37 = var_150_35 <= 0 and var_150_31 or var_150_31 * (var_150_36 / var_150_35)

				if var_150_37 > 0 and var_150_31 < var_150_37 then
					arg_147_1.talkMaxDuration = var_150_37

					if var_150_37 + var_150_30 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_37 + var_150_30
					end
				end

				arg_147_1.text_.text = var_150_34
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042036", "story_v_out_413042.awb") ~= 0 then
					local var_150_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042036", "story_v_out_413042.awb") / 1000

					if var_150_38 + var_150_30 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_38 + var_150_30
					end

					if var_150_33.prefab_name ~= "" and arg_147_1.actors_[var_150_33.prefab_name] ~= nil then
						local var_150_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_33.prefab_name].transform, "story_v_out_413042", "413042036", "story_v_out_413042.awb")

						arg_147_1:RecordAudio("413042036", var_150_39)
						arg_147_1:RecordAudio("413042036", var_150_39)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413042", "413042036", "story_v_out_413042.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413042", "413042036", "story_v_out_413042.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_40 = math.max(var_150_31, arg_147_1.talkMaxDuration)

			if var_150_30 <= arg_147_1.time_ and arg_147_1.time_ < var_150_30 + var_150_40 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_30) / var_150_40

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_30 + var_150_40 and arg_147_1.time_ < var_150_30 + var_150_40 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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
				actorName = "10022",
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
	Play413042037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413042037
		arg_151_1.duration_ = 3.23

		local var_151_0 = {
			zh = 1.366,
			ja = 3.233
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
				arg_151_0:Play413042038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.2

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[614].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(413042037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 8
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042037", "story_v_out_413042.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042037", "story_v_out_413042.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_413042", "413042037", "story_v_out_413042.awb")

						arg_151_1:RecordAudio("413042037", var_154_9)
						arg_151_1:RecordAudio("413042037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413042", "413042037", "story_v_out_413042.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413042", "413042037", "story_v_out_413042.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play413042038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 413042038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play413042039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10022"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10022 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10022", 0)

				local var_158_2 = var_158_0.childCount

				for iter_158_0 = 0, var_158_2 - 1 do
					local var_158_3 = var_158_0:GetChild(iter_158_0)

					if var_158_3.name == "" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_4 then
				local var_158_5 = (arg_155_1.time_ - var_158_1) / var_158_4
				local var_158_6 = Vector3.New(-1500, -350, -180)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10022, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_158_7 = arg_155_1.actors_["10022"]
			local var_158_8 = 0

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10022 == nil then
				arg_155_1.var_.actorSpriteComps10022 = var_158_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 2

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 and not isNil(var_158_7) then
				local var_158_10 = (arg_155_1.time_ - var_158_8) / var_158_9

				if arg_155_1.var_.actorSpriteComps10022 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								local var_158_11 = Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor2.r, var_158_10)
								local var_158_12 = Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor2.g, var_158_10)
								local var_158_13 = Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor2.b, var_158_10)

								iter_158_2.color = Color.New(var_158_11, var_158_12, var_158_13)
							else
								local var_158_14 = Mathf.Lerp(iter_158_2.color.r, 0.5, var_158_10)

								iter_158_2.color = Color.New(var_158_14, var_158_14, var_158_14)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10022 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_158_4 then
						if arg_155_1.isInRecall_ then
							iter_158_4.color = arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_158_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10022 = nil
			end

			local var_158_15 = 0
			local var_158_16 = 1.15

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_17 = arg_155_1:GetWordFromCfg(413042038)
				local var_158_18 = arg_155_1:FormatText(var_158_17.content)

				arg_155_1.text_.text = var_158_18

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_19 = 46
				local var_158_20 = utf8.len(var_158_18)
				local var_158_21 = var_158_19 <= 0 and var_158_16 or var_158_16 * (var_158_20 / var_158_19)

				if var_158_21 > 0 and var_158_16 < var_158_21 then
					arg_155_1.talkMaxDuration = var_158_21

					if var_158_21 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_21 + var_158_15
					end
				end

				arg_155_1.text_.text = var_158_18
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_22 = math.max(var_158_16, arg_155_1.talkMaxDuration)

			if var_158_15 <= arg_155_1.time_ and arg_155_1.time_ < var_158_15 + var_158_22 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_15) / var_158_22

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_15 + var_158_22 and arg_155_1.time_ < var_158_15 + var_158_22 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play413042039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 413042039
		arg_159_1.duration_ = 2.2

		local var_159_0 = {
			zh = 2.2,
			ja = 1.999999999999
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
				arg_159_0:Play413042040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10022"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10022 == nil then
				arg_159_1.var_.actorSpriteComps10022 = var_162_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_2 = 2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.actorSpriteComps10022 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10022 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_162_3 then
						if arg_159_1.isInRecall_ then
							iter_162_3.color = arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_162_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10022 = nil
			end

			local var_162_8 = arg_159_1.actors_["10022"].transform
			local var_162_9 = 0

			if var_162_9 < arg_159_1.time_ and arg_159_1.time_ <= var_162_9 + arg_162_0 then
				arg_159_1.var_.moveOldPos10022 = var_162_8.localPosition
				var_162_8.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10022", 3)

				local var_162_10 = var_162_8.childCount

				for iter_162_4 = 0, var_162_10 - 1 do
					local var_162_11 = var_162_8:GetChild(iter_162_4)

					if var_162_11.name == "split_6" or not string.find(var_162_11.name, "split") then
						var_162_11.gameObject:SetActive(true)
					else
						var_162_11.gameObject:SetActive(false)
					end
				end
			end

			local var_162_12 = 0.001

			if var_162_9 <= arg_159_1.time_ and arg_159_1.time_ < var_162_9 + var_162_12 then
				local var_162_13 = (arg_159_1.time_ - var_162_9) / var_162_12
				local var_162_14 = Vector3.New(0, -315, -320)

				var_162_8.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10022, var_162_14, var_162_13)
			end

			if arg_159_1.time_ >= var_162_9 + var_162_12 and arg_159_1.time_ < var_162_9 + var_162_12 + arg_162_0 then
				var_162_8.localPosition = Vector3.New(0, -315, -320)
			end

			local var_162_15 = 0
			local var_162_16 = 0.35

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_17 = arg_159_1:FormatText(StoryNameCfg[614].name)

				arg_159_1.leftNameTxt_.text = var_162_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_18 = arg_159_1:GetWordFromCfg(413042039)
				local var_162_19 = arg_159_1:FormatText(var_162_18.content)

				arg_159_1.text_.text = var_162_19

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_20 = 14
				local var_162_21 = utf8.len(var_162_19)
				local var_162_22 = var_162_20 <= 0 and var_162_16 or var_162_16 * (var_162_21 / var_162_20)

				if var_162_22 > 0 and var_162_16 < var_162_22 then
					arg_159_1.talkMaxDuration = var_162_22

					if var_162_22 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_22 + var_162_15
					end
				end

				arg_159_1.text_.text = var_162_19
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042039", "story_v_out_413042.awb") ~= 0 then
					local var_162_23 = manager.audio:GetVoiceLength("story_v_out_413042", "413042039", "story_v_out_413042.awb") / 1000

					if var_162_23 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_15
					end

					if var_162_18.prefab_name ~= "" and arg_159_1.actors_[var_162_18.prefab_name] ~= nil then
						local var_162_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_18.prefab_name].transform, "story_v_out_413042", "413042039", "story_v_out_413042.awb")

						arg_159_1:RecordAudio("413042039", var_162_24)
						arg_159_1:RecordAudio("413042039", var_162_24)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413042", "413042039", "story_v_out_413042.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413042", "413042039", "story_v_out_413042.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_25 = math.max(var_162_16, arg_159_1.talkMaxDuration)

			if var_162_15 <= arg_159_1.time_ and arg_159_1.time_ < var_162_15 + var_162_25 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_15) / var_162_25

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_15 + var_162_25 and arg_159_1.time_ < var_162_15 + var_162_25 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play413042040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413042040
		arg_163_1.duration_ = 2.07

		local var_163_0 = {
			zh = 1.999999999999,
			ja = 2.066
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
				arg_163_0:Play413042041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10022"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10022 == nil then
				arg_163_1.var_.actorSpriteComps10022 = var_166_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_2 = 2

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.actorSpriteComps10022 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								local var_166_4 = Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor2.r, var_166_3)
								local var_166_5 = Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor2.g, var_166_3)
								local var_166_6 = Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor2.b, var_166_3)

								iter_166_1.color = Color.New(var_166_4, var_166_5, var_166_6)
							else
								local var_166_7 = Mathf.Lerp(iter_166_1.color.r, 0.5, var_166_3)

								iter_166_1.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10022 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_166_3 then
						if arg_163_1.isInRecall_ then
							iter_166_3.color = arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_166_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10022 = nil
			end

			local var_166_8 = 0
			local var_166_9 = 0.833333333333333

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				local var_166_10 = "play"
				local var_166_11 = "music"

				arg_163_1:AudioAction(var_166_10, var_166_11, "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_166_12 = ""
				local var_166_13 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

				if var_166_13 ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_13 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_13

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_13
						arg_163_1.bgmTxt2_.text = var_166_13
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_166_14 = 0.7
			local var_166_15 = 1

			if var_166_14 < arg_163_1.time_ and arg_163_1.time_ <= var_166_14 + arg_166_0 then
				local var_166_16 = "play"
				local var_166_17 = "effect"

				arg_163_1:AudioAction(var_166_16, var_166_17, "se_story_130", "se_story_130_noise", "")
			end

			local var_166_18 = 0
			local var_166_19 = 0.075

			if var_166_18 < arg_163_1.time_ and arg_163_1.time_ <= var_166_18 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_20 = arg_163_1:FormatText(StoryNameCfg[36].name)

				arg_163_1.leftNameTxt_.text = var_166_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_21 = arg_163_1:GetWordFromCfg(413042040)
				local var_166_22 = arg_163_1:FormatText(var_166_21.content)

				arg_163_1.text_.text = var_166_22

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_23 = 3
				local var_166_24 = utf8.len(var_166_22)
				local var_166_25 = var_166_23 <= 0 and var_166_19 or var_166_19 * (var_166_24 / var_166_23)

				if var_166_25 > 0 and var_166_19 < var_166_25 then
					arg_163_1.talkMaxDuration = var_166_25

					if var_166_25 + var_166_18 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_25 + var_166_18
					end
				end

				arg_163_1.text_.text = var_166_22
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042040", "story_v_out_413042.awb") ~= 0 then
					local var_166_26 = manager.audio:GetVoiceLength("story_v_out_413042", "413042040", "story_v_out_413042.awb") / 1000

					if var_166_26 + var_166_18 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_26 + var_166_18
					end

					if var_166_21.prefab_name ~= "" and arg_163_1.actors_[var_166_21.prefab_name] ~= nil then
						local var_166_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_21.prefab_name].transform, "story_v_out_413042", "413042040", "story_v_out_413042.awb")

						arg_163_1:RecordAudio("413042040", var_166_27)
						arg_163_1:RecordAudio("413042040", var_166_27)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413042", "413042040", "story_v_out_413042.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413042", "413042040", "story_v_out_413042.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_28 = math.max(var_166_19, arg_163_1.talkMaxDuration)

			if var_166_18 <= arg_163_1.time_ and arg_163_1.time_ < var_166_18 + var_166_28 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_18) / var_166_28

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_18 + var_166_28 and arg_163_1.time_ < var_166_18 + var_166_28 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play413042041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 413042041
		arg_168_1.duration_ = 2

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play413042042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10022"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos10022 = var_171_0.localPosition
				var_171_0.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10022", 3)

				local var_171_2 = var_171_0.childCount

				for iter_171_0 = 0, var_171_2 - 1 do
					local var_171_3 = var_171_0:GetChild(iter_171_0)

					if var_171_3.name == "split_2" or not string.find(var_171_3.name, "split") then
						var_171_3.gameObject:SetActive(true)
					else
						var_171_3.gameObject:SetActive(false)
					end
				end
			end

			local var_171_4 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_4 then
				local var_171_5 = (arg_168_1.time_ - var_171_1) / var_171_4
				local var_171_6 = Vector3.New(0, -315, -320)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10022, var_171_6, var_171_5)
			end

			if arg_168_1.time_ >= var_171_1 + var_171_4 and arg_168_1.time_ < var_171_1 + var_171_4 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_171_7 = arg_168_1.actors_["10022"]
			local var_171_8 = 0

			if var_171_8 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 and not isNil(var_171_7) and arg_168_1.var_.actorSpriteComps10022 == nil then
				arg_168_1.var_.actorSpriteComps10022 = var_171_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_9 = 2

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_9 and not isNil(var_171_7) then
				local var_171_10 = (arg_168_1.time_ - var_171_8) / var_171_9

				if arg_168_1.var_.actorSpriteComps10022 then
					for iter_171_1, iter_171_2 in pairs(arg_168_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_171_2 then
							if arg_168_1.isInRecall_ then
								local var_171_11 = Mathf.Lerp(iter_171_2.color.r, arg_168_1.hightColor1.r, var_171_10)
								local var_171_12 = Mathf.Lerp(iter_171_2.color.g, arg_168_1.hightColor1.g, var_171_10)
								local var_171_13 = Mathf.Lerp(iter_171_2.color.b, arg_168_1.hightColor1.b, var_171_10)

								iter_171_2.color = Color.New(var_171_11, var_171_12, var_171_13)
							else
								local var_171_14 = Mathf.Lerp(iter_171_2.color.r, 1, var_171_10)

								iter_171_2.color = Color.New(var_171_14, var_171_14, var_171_14)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= var_171_8 + var_171_9 and arg_168_1.time_ < var_171_8 + var_171_9 + arg_171_0 and not isNil(var_171_7) and arg_168_1.var_.actorSpriteComps10022 then
				for iter_171_3, iter_171_4 in pairs(arg_168_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_171_4 then
						if arg_168_1.isInRecall_ then
							iter_171_4.color = arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_171_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps10022 = nil
			end

			local var_171_15 = 0
			local var_171_16 = 0.175

			if var_171_15 < arg_168_1.time_ and arg_168_1.time_ <= var_171_15 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_17 = arg_168_1:FormatText(StoryNameCfg[614].name)

				arg_168_1.leftNameTxt_.text = var_171_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_18 = arg_168_1:GetWordFromCfg(413042041)
				local var_171_19 = arg_168_1:FormatText(var_171_18.content)

				arg_168_1.text_.text = var_171_19

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_20 = 7
				local var_171_21 = utf8.len(var_171_19)
				local var_171_22 = var_171_20 <= 0 and var_171_16 or var_171_16 * (var_171_21 / var_171_20)

				if var_171_22 > 0 and var_171_16 < var_171_22 then
					arg_168_1.talkMaxDuration = var_171_22

					if var_171_22 + var_171_15 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_22 + var_171_15
					end
				end

				arg_168_1.text_.text = var_171_19
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042041", "story_v_out_413042.awb") ~= 0 then
					local var_171_23 = manager.audio:GetVoiceLength("story_v_out_413042", "413042041", "story_v_out_413042.awb") / 1000

					if var_171_23 + var_171_15 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_23 + var_171_15
					end

					if var_171_18.prefab_name ~= "" and arg_168_1.actors_[var_171_18.prefab_name] ~= nil then
						local var_171_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_18.prefab_name].transform, "story_v_out_413042", "413042041", "story_v_out_413042.awb")

						arg_168_1:RecordAudio("413042041", var_171_24)
						arg_168_1:RecordAudio("413042041", var_171_24)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_413042", "413042041", "story_v_out_413042.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_413042", "413042041", "story_v_out_413042.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_25 = math.max(var_171_16, arg_168_1.talkMaxDuration)

			if var_171_15 <= arg_168_1.time_ and arg_168_1.time_ < var_171_15 + var_171_25 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_15) / var_171_25

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_15 + var_171_25 and arg_168_1.time_ < var_171_15 + var_171_25 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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

		arg_168_1:InitPlayNodeList()
	end,
	Play413042042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 413042042
		arg_172_1.duration_ = 5

		local var_172_0 = {
			zh = 5,
			ja = 1.999999999999
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play413042043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10022"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps10022 == nil then
				arg_172_1.var_.actorSpriteComps10022 = var_175_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_2 = 2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.actorSpriteComps10022 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								local var_175_4 = Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor2.r, var_175_3)
								local var_175_5 = Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor2.g, var_175_3)
								local var_175_6 = Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor2.b, var_175_3)

								iter_175_1.color = Color.New(var_175_4, var_175_5, var_175_6)
							else
								local var_175_7 = Mathf.Lerp(iter_175_1.color.r, 0.5, var_175_3)

								iter_175_1.color = Color.New(var_175_7, var_175_7, var_175_7)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps10022 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_175_3 then
						if arg_172_1.isInRecall_ then
							iter_175_3.color = arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_175_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps10022 = nil
			end

			local var_175_8 = 0.366666666666667
			local var_175_9 = 1

			if var_175_8 < arg_172_1.time_ and arg_172_1.time_ <= var_175_8 + arg_175_0 then
				local var_175_10 = "play"
				local var_175_11 = "effect"

				arg_172_1:AudioAction(var_175_10, var_175_11, "se_story_130", "se_story_130_noise", "")
			end

			local var_175_12 = 0
			local var_175_13 = 0.15

			if var_175_12 < arg_172_1.time_ and arg_172_1.time_ <= var_175_12 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_14 = arg_172_1:FormatText(StoryNameCfg[36].name)

				arg_172_1.leftNameTxt_.text = var_175_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_15 = arg_172_1:GetWordFromCfg(413042042)
				local var_175_16 = arg_172_1:FormatText(var_175_15.content)

				arg_172_1.text_.text = var_175_16

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_17 = 6
				local var_175_18 = utf8.len(var_175_16)
				local var_175_19 = var_175_17 <= 0 and var_175_13 or var_175_13 * (var_175_18 / var_175_17)

				if var_175_19 > 0 and var_175_13 < var_175_19 then
					arg_172_1.talkMaxDuration = var_175_19

					if var_175_19 + var_175_12 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_19 + var_175_12
					end
				end

				arg_172_1.text_.text = var_175_16
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042042", "story_v_out_413042.awb") ~= 0 then
					local var_175_20 = manager.audio:GetVoiceLength("story_v_out_413042", "413042042", "story_v_out_413042.awb") / 1000

					if var_175_20 + var_175_12 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_20 + var_175_12
					end

					if var_175_15.prefab_name ~= "" and arg_172_1.actors_[var_175_15.prefab_name] ~= nil then
						local var_175_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_15.prefab_name].transform, "story_v_out_413042", "413042042", "story_v_out_413042.awb")

						arg_172_1:RecordAudio("413042042", var_175_21)
						arg_172_1:RecordAudio("413042042", var_175_21)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_413042", "413042042", "story_v_out_413042.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_413042", "413042042", "story_v_out_413042.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_22 = math.max(var_175_13, arg_172_1.talkMaxDuration)

			if var_175_12 <= arg_172_1.time_ and arg_172_1.time_ < var_175_12 + var_175_22 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_12) / var_175_22

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_12 + var_175_22 and arg_172_1.time_ < var_175_12 + var_175_22 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play413042043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 413042043
		arg_176_1.duration_ = 4.5

		local var_176_0 = {
			zh = 2.7,
			ja = 4.5
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play413042044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10022"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos10022 = var_179_0.localPosition
				var_179_0.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10022", 0)

				local var_179_2 = var_179_0.childCount

				for iter_179_0 = 0, var_179_2 - 1 do
					local var_179_3 = var_179_0:GetChild(iter_179_0)

					if var_179_3.name == "" or not string.find(var_179_3.name, "split") then
						var_179_3.gameObject:SetActive(true)
					else
						var_179_3.gameObject:SetActive(false)
					end
				end
			end

			local var_179_4 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_4 then
				local var_179_5 = (arg_176_1.time_ - var_179_1) / var_179_4
				local var_179_6 = Vector3.New(-1500, -350, -180)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10022, var_179_6, var_179_5)
			end

			if arg_176_1.time_ >= var_179_1 + var_179_4 and arg_176_1.time_ < var_179_1 + var_179_4 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_179_7 = arg_176_1.actors_["10094"].transform
			local var_179_8 = 0

			if var_179_8 < arg_176_1.time_ and arg_176_1.time_ <= var_179_8 + arg_179_0 then
				arg_176_1.var_.moveOldPos10094 = var_179_7.localPosition
				var_179_7.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10094", 3)

				local var_179_9 = var_179_7.childCount

				for iter_179_1 = 0, var_179_9 - 1 do
					local var_179_10 = var_179_7:GetChild(iter_179_1)

					if var_179_10.name == "" or not string.find(var_179_10.name, "split") then
						var_179_10.gameObject:SetActive(true)
					else
						var_179_10.gameObject:SetActive(false)
					end
				end
			end

			local var_179_11 = 0.001

			if var_179_8 <= arg_176_1.time_ and arg_176_1.time_ < var_179_8 + var_179_11 then
				local var_179_12 = (arg_176_1.time_ - var_179_8) / var_179_11
				local var_179_13 = Vector3.New(0, -340, -414)

				var_179_7.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10094, var_179_13, var_179_12)
			end

			if arg_176_1.time_ >= var_179_8 + var_179_11 and arg_176_1.time_ < var_179_8 + var_179_11 + arg_179_0 then
				var_179_7.localPosition = Vector3.New(0, -340, -414)
			end

			local var_179_14 = arg_176_1.actors_["10022"]
			local var_179_15 = 0

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 and not isNil(var_179_14) and arg_176_1.var_.actorSpriteComps10022 == nil then
				arg_176_1.var_.actorSpriteComps10022 = var_179_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_16 = 2

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_16 and not isNil(var_179_14) then
				local var_179_17 = (arg_176_1.time_ - var_179_15) / var_179_16

				if arg_176_1.var_.actorSpriteComps10022 then
					for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_179_3 then
							if arg_176_1.isInRecall_ then
								local var_179_18 = Mathf.Lerp(iter_179_3.color.r, arg_176_1.hightColor2.r, var_179_17)
								local var_179_19 = Mathf.Lerp(iter_179_3.color.g, arg_176_1.hightColor2.g, var_179_17)
								local var_179_20 = Mathf.Lerp(iter_179_3.color.b, arg_176_1.hightColor2.b, var_179_17)

								iter_179_3.color = Color.New(var_179_18, var_179_19, var_179_20)
							else
								local var_179_21 = Mathf.Lerp(iter_179_3.color.r, 0.5, var_179_17)

								iter_179_3.color = Color.New(var_179_21, var_179_21, var_179_21)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_15 + var_179_16 and arg_176_1.time_ < var_179_15 + var_179_16 + arg_179_0 and not isNil(var_179_14) and arg_176_1.var_.actorSpriteComps10022 then
				for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_179_5 then
						if arg_176_1.isInRecall_ then
							iter_179_5.color = arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_179_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10022 = nil
			end

			local var_179_22 = arg_176_1.actors_["10094"]
			local var_179_23 = 0

			if var_179_23 < arg_176_1.time_ and arg_176_1.time_ <= var_179_23 + arg_179_0 and not isNil(var_179_22) and arg_176_1.var_.actorSpriteComps10094 == nil then
				arg_176_1.var_.actorSpriteComps10094 = var_179_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_24 = 2

			if var_179_23 <= arg_176_1.time_ and arg_176_1.time_ < var_179_23 + var_179_24 and not isNil(var_179_22) then
				local var_179_25 = (arg_176_1.time_ - var_179_23) / var_179_24

				if arg_176_1.var_.actorSpriteComps10094 then
					for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_179_7 then
							if arg_176_1.isInRecall_ then
								local var_179_26 = Mathf.Lerp(iter_179_7.color.r, arg_176_1.hightColor1.r, var_179_25)
								local var_179_27 = Mathf.Lerp(iter_179_7.color.g, arg_176_1.hightColor1.g, var_179_25)
								local var_179_28 = Mathf.Lerp(iter_179_7.color.b, arg_176_1.hightColor1.b, var_179_25)

								iter_179_7.color = Color.New(var_179_26, var_179_27, var_179_28)
							else
								local var_179_29 = Mathf.Lerp(iter_179_7.color.r, 1, var_179_25)

								iter_179_7.color = Color.New(var_179_29, var_179_29, var_179_29)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_23 + var_179_24 and arg_176_1.time_ < var_179_23 + var_179_24 + arg_179_0 and not isNil(var_179_22) and arg_176_1.var_.actorSpriteComps10094 then
				for iter_179_8, iter_179_9 in pairs(arg_176_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_179_9 then
						if arg_176_1.isInRecall_ then
							iter_179_9.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_179_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10094 = nil
			end

			local var_179_30 = 0
			local var_179_31 = 0.325

			if var_179_30 < arg_176_1.time_ and arg_176_1.time_ <= var_179_30 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_32 = arg_176_1:FormatText(StoryNameCfg[259].name)

				arg_176_1.leftNameTxt_.text = var_179_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_33 = arg_176_1:GetWordFromCfg(413042043)
				local var_179_34 = arg_176_1:FormatText(var_179_33.content)

				arg_176_1.text_.text = var_179_34

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_35 = 13
				local var_179_36 = utf8.len(var_179_34)
				local var_179_37 = var_179_35 <= 0 and var_179_31 or var_179_31 * (var_179_36 / var_179_35)

				if var_179_37 > 0 and var_179_31 < var_179_37 then
					arg_176_1.talkMaxDuration = var_179_37

					if var_179_37 + var_179_30 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_37 + var_179_30
					end
				end

				arg_176_1.text_.text = var_179_34
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042043", "story_v_out_413042.awb") ~= 0 then
					local var_179_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042043", "story_v_out_413042.awb") / 1000

					if var_179_38 + var_179_30 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_38 + var_179_30
					end

					if var_179_33.prefab_name ~= "" and arg_176_1.actors_[var_179_33.prefab_name] ~= nil then
						local var_179_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_33.prefab_name].transform, "story_v_out_413042", "413042043", "story_v_out_413042.awb")

						arg_176_1:RecordAudio("413042043", var_179_39)
						arg_176_1:RecordAudio("413042043", var_179_39)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_413042", "413042043", "story_v_out_413042.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_413042", "413042043", "story_v_out_413042.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_40 = math.max(var_179_31, arg_176_1.talkMaxDuration)

			if var_179_30 <= arg_176_1.time_ and arg_176_1.time_ < var_179_30 + var_179_40 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_30) / var_179_40

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_30 + var_179_40 and arg_176_1.time_ < var_179_30 + var_179_40 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_176_1:InitPlayNodeList()
	end,
	Play413042044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 413042044
		arg_180_1.duration_ = 5.97

		local var_180_0 = {
			zh = 3.1,
			ja = 5.966
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play413042045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10094"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos10094 = var_183_0.localPosition
				var_183_0.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10094", 0)

				local var_183_2 = var_183_0.childCount

				for iter_183_0 = 0, var_183_2 - 1 do
					local var_183_3 = var_183_0:GetChild(iter_183_0)

					if var_183_3.name == "" or not string.find(var_183_3.name, "split") then
						var_183_3.gameObject:SetActive(true)
					else
						var_183_3.gameObject:SetActive(false)
					end
				end
			end

			local var_183_4 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_4 then
				local var_183_5 = (arg_180_1.time_ - var_183_1) / var_183_4
				local var_183_6 = Vector3.New(-5000, -340, -414)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10094, var_183_6, var_183_5)
			end

			if arg_180_1.time_ >= var_183_1 + var_183_4 and arg_180_1.time_ < var_183_1 + var_183_4 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_183_7 = arg_180_1.actors_["10022"].transform
			local var_183_8 = 0

			if var_183_8 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.var_.moveOldPos10022 = var_183_7.localPosition
				var_183_7.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10022", 3)

				local var_183_9 = var_183_7.childCount

				for iter_183_1 = 0, var_183_9 - 1 do
					local var_183_10 = var_183_7:GetChild(iter_183_1)

					if var_183_10.name == "split_8" or not string.find(var_183_10.name, "split") then
						var_183_10.gameObject:SetActive(true)
					else
						var_183_10.gameObject:SetActive(false)
					end
				end
			end

			local var_183_11 = 0.001

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_11 then
				local var_183_12 = (arg_180_1.time_ - var_183_8) / var_183_11
				local var_183_13 = Vector3.New(0, -315, -320)

				var_183_7.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10022, var_183_13, var_183_12)
			end

			if arg_180_1.time_ >= var_183_8 + var_183_11 and arg_180_1.time_ < var_183_8 + var_183_11 + arg_183_0 then
				var_183_7.localPosition = Vector3.New(0, -315, -320)
			end

			local var_183_14 = arg_180_1.actors_["10094"]
			local var_183_15 = 0

			if var_183_15 < arg_180_1.time_ and arg_180_1.time_ <= var_183_15 + arg_183_0 and not isNil(var_183_14) and arg_180_1.var_.actorSpriteComps10094 == nil then
				arg_180_1.var_.actorSpriteComps10094 = var_183_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_16 = 2

			if var_183_15 <= arg_180_1.time_ and arg_180_1.time_ < var_183_15 + var_183_16 and not isNil(var_183_14) then
				local var_183_17 = (arg_180_1.time_ - var_183_15) / var_183_16

				if arg_180_1.var_.actorSpriteComps10094 then
					for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_183_3 then
							if arg_180_1.isInRecall_ then
								local var_183_18 = Mathf.Lerp(iter_183_3.color.r, arg_180_1.hightColor2.r, var_183_17)
								local var_183_19 = Mathf.Lerp(iter_183_3.color.g, arg_180_1.hightColor2.g, var_183_17)
								local var_183_20 = Mathf.Lerp(iter_183_3.color.b, arg_180_1.hightColor2.b, var_183_17)

								iter_183_3.color = Color.New(var_183_18, var_183_19, var_183_20)
							else
								local var_183_21 = Mathf.Lerp(iter_183_3.color.r, 0.5, var_183_17)

								iter_183_3.color = Color.New(var_183_21, var_183_21, var_183_21)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_15 + var_183_16 and arg_180_1.time_ < var_183_15 + var_183_16 + arg_183_0 and not isNil(var_183_14) and arg_180_1.var_.actorSpriteComps10094 then
				for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_183_5 then
						if arg_180_1.isInRecall_ then
							iter_183_5.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10094 = nil
			end

			local var_183_22 = arg_180_1.actors_["10022"]
			local var_183_23 = 0

			if var_183_23 < arg_180_1.time_ and arg_180_1.time_ <= var_183_23 + arg_183_0 and not isNil(var_183_22) and arg_180_1.var_.actorSpriteComps10022 == nil then
				arg_180_1.var_.actorSpriteComps10022 = var_183_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_24 = 2

			if var_183_23 <= arg_180_1.time_ and arg_180_1.time_ < var_183_23 + var_183_24 and not isNil(var_183_22) then
				local var_183_25 = (arg_180_1.time_ - var_183_23) / var_183_24

				if arg_180_1.var_.actorSpriteComps10022 then
					for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_183_7 then
							if arg_180_1.isInRecall_ then
								local var_183_26 = Mathf.Lerp(iter_183_7.color.r, arg_180_1.hightColor1.r, var_183_25)
								local var_183_27 = Mathf.Lerp(iter_183_7.color.g, arg_180_1.hightColor1.g, var_183_25)
								local var_183_28 = Mathf.Lerp(iter_183_7.color.b, arg_180_1.hightColor1.b, var_183_25)

								iter_183_7.color = Color.New(var_183_26, var_183_27, var_183_28)
							else
								local var_183_29 = Mathf.Lerp(iter_183_7.color.r, 1, var_183_25)

								iter_183_7.color = Color.New(var_183_29, var_183_29, var_183_29)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_23 + var_183_24 and arg_180_1.time_ < var_183_23 + var_183_24 + arg_183_0 and not isNil(var_183_22) and arg_180_1.var_.actorSpriteComps10022 then
				for iter_183_8, iter_183_9 in pairs(arg_180_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_183_9 then
						if arg_180_1.isInRecall_ then
							iter_183_9.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10022 = nil
			end

			local var_183_30 = 0
			local var_183_31 = 0.425

			if var_183_30 < arg_180_1.time_ and arg_180_1.time_ <= var_183_30 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_32 = arg_180_1:FormatText(StoryNameCfg[614].name)

				arg_180_1.leftNameTxt_.text = var_183_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_33 = arg_180_1:GetWordFromCfg(413042044)
				local var_183_34 = arg_180_1:FormatText(var_183_33.content)

				arg_180_1.text_.text = var_183_34

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_35 = 17
				local var_183_36 = utf8.len(var_183_34)
				local var_183_37 = var_183_35 <= 0 and var_183_31 or var_183_31 * (var_183_36 / var_183_35)

				if var_183_37 > 0 and var_183_31 < var_183_37 then
					arg_180_1.talkMaxDuration = var_183_37

					if var_183_37 + var_183_30 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_37 + var_183_30
					end
				end

				arg_180_1.text_.text = var_183_34
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042044", "story_v_out_413042.awb") ~= 0 then
					local var_183_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042044", "story_v_out_413042.awb") / 1000

					if var_183_38 + var_183_30 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_38 + var_183_30
					end

					if var_183_33.prefab_name ~= "" and arg_180_1.actors_[var_183_33.prefab_name] ~= nil then
						local var_183_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_33.prefab_name].transform, "story_v_out_413042", "413042044", "story_v_out_413042.awb")

						arg_180_1:RecordAudio("413042044", var_183_39)
						arg_180_1:RecordAudio("413042044", var_183_39)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_413042", "413042044", "story_v_out_413042.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_413042", "413042044", "story_v_out_413042.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_40 = math.max(var_183_31, arg_180_1.talkMaxDuration)

			if var_183_30 <= arg_180_1.time_ and arg_180_1.time_ < var_183_30 + var_183_40 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_30) / var_183_40

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_30 + var_183_40 and arg_180_1.time_ < var_183_30 + var_183_40 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play413042045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 413042045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play413042046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10022"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps10022 == nil then
				arg_184_1.var_.actorSpriteComps10022 = var_187_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_2 = 2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.actorSpriteComps10022 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								local var_187_4 = Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor2.r, var_187_3)
								local var_187_5 = Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor2.g, var_187_3)
								local var_187_6 = Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor2.b, var_187_3)

								iter_187_1.color = Color.New(var_187_4, var_187_5, var_187_6)
							else
								local var_187_7 = Mathf.Lerp(iter_187_1.color.r, 0.5, var_187_3)

								iter_187_1.color = Color.New(var_187_7, var_187_7, var_187_7)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps10022 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_187_3 then
						if arg_184_1.isInRecall_ then
							iter_187_3.color = arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_187_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10022 = nil
			end

			local var_187_8 = 0
			local var_187_9 = 1.1

			if var_187_8 < arg_184_1.time_ and arg_184_1.time_ <= var_187_8 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_10 = arg_184_1:GetWordFromCfg(413042045)
				local var_187_11 = arg_184_1:FormatText(var_187_10.content)

				arg_184_1.text_.text = var_187_11

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_12 = 44
				local var_187_13 = utf8.len(var_187_11)
				local var_187_14 = var_187_12 <= 0 and var_187_9 or var_187_9 * (var_187_13 / var_187_12)

				if var_187_14 > 0 and var_187_9 < var_187_14 then
					arg_184_1.talkMaxDuration = var_187_14

					if var_187_14 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_8
					end
				end

				arg_184_1.text_.text = var_187_11
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_15 = math.max(var_187_9, arg_184_1.talkMaxDuration)

			if var_187_8 <= arg_184_1.time_ and arg_184_1.time_ < var_187_8 + var_187_15 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_8) / var_187_15

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_8 + var_187_15 and arg_184_1.time_ < var_187_8 + var_187_15 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play413042046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 413042046
		arg_188_1.duration_ = 2.83

		local var_188_0 = {
			zh = 2.833,
			ja = 2.466
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play413042047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10022"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos10022 = var_191_0.localPosition
				var_191_0.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10022", 0)

				local var_191_2 = var_191_0.childCount

				for iter_191_0 = 0, var_191_2 - 1 do
					local var_191_3 = var_191_0:GetChild(iter_191_0)

					if var_191_3.name == "" or not string.find(var_191_3.name, "split") then
						var_191_3.gameObject:SetActive(true)
					else
						var_191_3.gameObject:SetActive(false)
					end
				end
			end

			local var_191_4 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_4 then
				local var_191_5 = (arg_188_1.time_ - var_191_1) / var_191_4
				local var_191_6 = Vector3.New(-1500, -350, -180)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10022, var_191_6, var_191_5)
			end

			if arg_188_1.time_ >= var_191_1 + var_191_4 and arg_188_1.time_ < var_191_1 + var_191_4 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_191_7 = "10093"

			if arg_188_1.actors_[var_191_7] == nil then
				local var_191_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_191_8) then
					local var_191_9 = Object.Instantiate(var_191_8, arg_188_1.canvasGo_.transform)

					var_191_9.transform:SetSiblingIndex(1)

					var_191_9.name = var_191_7
					var_191_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_188_1.actors_[var_191_7] = var_191_9

					local var_191_10 = var_191_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_188_1.isInRecall_ then
						for iter_191_1, iter_191_2 in ipairs(var_191_10) do
							iter_191_2.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_191_11 = arg_188_1.actors_["10093"].transform
			local var_191_12 = 0

			if var_191_12 < arg_188_1.time_ and arg_188_1.time_ <= var_191_12 + arg_191_0 then
				arg_188_1.var_.moveOldPos10093 = var_191_11.localPosition
				var_191_11.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10093", 3)

				local var_191_13 = var_191_11.childCount

				for iter_191_3 = 0, var_191_13 - 1 do
					local var_191_14 = var_191_11:GetChild(iter_191_3)

					if var_191_14.name == "split_3" or not string.find(var_191_14.name, "split") then
						var_191_14.gameObject:SetActive(true)
					else
						var_191_14.gameObject:SetActive(false)
					end
				end
			end

			local var_191_15 = 0.001

			if var_191_12 <= arg_188_1.time_ and arg_188_1.time_ < var_191_12 + var_191_15 then
				local var_191_16 = (arg_188_1.time_ - var_191_12) / var_191_15
				local var_191_17 = Vector3.New(0, -345, -245)

				var_191_11.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10093, var_191_17, var_191_16)
			end

			if arg_188_1.time_ >= var_191_12 + var_191_15 and arg_188_1.time_ < var_191_12 + var_191_15 + arg_191_0 then
				var_191_11.localPosition = Vector3.New(0, -345, -245)
			end

			local var_191_18 = arg_188_1.actors_["10022"]
			local var_191_19 = 0

			if var_191_19 < arg_188_1.time_ and arg_188_1.time_ <= var_191_19 + arg_191_0 and not isNil(var_191_18) and arg_188_1.var_.actorSpriteComps10022 == nil then
				arg_188_1.var_.actorSpriteComps10022 = var_191_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_20 = 2

			if var_191_19 <= arg_188_1.time_ and arg_188_1.time_ < var_191_19 + var_191_20 and not isNil(var_191_18) then
				local var_191_21 = (arg_188_1.time_ - var_191_19) / var_191_20

				if arg_188_1.var_.actorSpriteComps10022 then
					for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_191_5 then
							if arg_188_1.isInRecall_ then
								local var_191_22 = Mathf.Lerp(iter_191_5.color.r, arg_188_1.hightColor2.r, var_191_21)
								local var_191_23 = Mathf.Lerp(iter_191_5.color.g, arg_188_1.hightColor2.g, var_191_21)
								local var_191_24 = Mathf.Lerp(iter_191_5.color.b, arg_188_1.hightColor2.b, var_191_21)

								iter_191_5.color = Color.New(var_191_22, var_191_23, var_191_24)
							else
								local var_191_25 = Mathf.Lerp(iter_191_5.color.r, 0.5, var_191_21)

								iter_191_5.color = Color.New(var_191_25, var_191_25, var_191_25)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_19 + var_191_20 and arg_188_1.time_ < var_191_19 + var_191_20 + arg_191_0 and not isNil(var_191_18) and arg_188_1.var_.actorSpriteComps10022 then
				for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_191_7 then
						if arg_188_1.isInRecall_ then
							iter_191_7.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10022 = nil
			end

			local var_191_26 = arg_188_1.actors_["10093"]
			local var_191_27 = 0

			if var_191_27 < arg_188_1.time_ and arg_188_1.time_ <= var_191_27 + arg_191_0 and not isNil(var_191_26) and arg_188_1.var_.actorSpriteComps10093 == nil then
				arg_188_1.var_.actorSpriteComps10093 = var_191_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_28 = 2

			if var_191_27 <= arg_188_1.time_ and arg_188_1.time_ < var_191_27 + var_191_28 and not isNil(var_191_26) then
				local var_191_29 = (arg_188_1.time_ - var_191_27) / var_191_28

				if arg_188_1.var_.actorSpriteComps10093 then
					for iter_191_8, iter_191_9 in pairs(arg_188_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_191_9 then
							if arg_188_1.isInRecall_ then
								local var_191_30 = Mathf.Lerp(iter_191_9.color.r, arg_188_1.hightColor1.r, var_191_29)
								local var_191_31 = Mathf.Lerp(iter_191_9.color.g, arg_188_1.hightColor1.g, var_191_29)
								local var_191_32 = Mathf.Lerp(iter_191_9.color.b, arg_188_1.hightColor1.b, var_191_29)

								iter_191_9.color = Color.New(var_191_30, var_191_31, var_191_32)
							else
								local var_191_33 = Mathf.Lerp(iter_191_9.color.r, 1, var_191_29)

								iter_191_9.color = Color.New(var_191_33, var_191_33, var_191_33)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_27 + var_191_28 and arg_188_1.time_ < var_191_27 + var_191_28 + arg_191_0 and not isNil(var_191_26) and arg_188_1.var_.actorSpriteComps10093 then
				for iter_191_10, iter_191_11 in pairs(arg_188_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_191_11 then
						if arg_188_1.isInRecall_ then
							iter_191_11.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_191_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10093 = nil
			end

			local var_191_34 = arg_188_1.actors_["10093"]
			local var_191_35 = 0

			if var_191_35 < arg_188_1.time_ and arg_188_1.time_ <= var_191_35 + arg_191_0 then
				local var_191_36 = var_191_34:GetComponentInChildren(typeof(CanvasGroup))

				if var_191_36 then
					arg_188_1.var_.alphaOldValue10093 = var_191_36.alpha
					arg_188_1.var_.characterEffect10093 = var_191_36
				end

				arg_188_1.var_.alphaOldValue10093 = 0
			end

			local var_191_37 = 0.2

			if var_191_35 <= arg_188_1.time_ and arg_188_1.time_ < var_191_35 + var_191_37 then
				local var_191_38 = (arg_188_1.time_ - var_191_35) / var_191_37
				local var_191_39 = Mathf.Lerp(arg_188_1.var_.alphaOldValue10093, 1, var_191_38)

				if arg_188_1.var_.characterEffect10093 then
					arg_188_1.var_.characterEffect10093.alpha = var_191_39
				end
			end

			if arg_188_1.time_ >= var_191_35 + var_191_37 and arg_188_1.time_ < var_191_35 + var_191_37 + arg_191_0 and arg_188_1.var_.characterEffect10093 then
				arg_188_1.var_.characterEffect10093.alpha = 1
			end

			local var_191_40 = 0
			local var_191_41 = 0.275

			if var_191_40 < arg_188_1.time_ and arg_188_1.time_ <= var_191_40 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_42 = arg_188_1:FormatText(StoryNameCfg[28].name)

				arg_188_1.leftNameTxt_.text = var_191_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_43 = arg_188_1:GetWordFromCfg(413042046)
				local var_191_44 = arg_188_1:FormatText(var_191_43.content)

				arg_188_1.text_.text = var_191_44

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_45 = 11
				local var_191_46 = utf8.len(var_191_44)
				local var_191_47 = var_191_45 <= 0 and var_191_41 or var_191_41 * (var_191_46 / var_191_45)

				if var_191_47 > 0 and var_191_41 < var_191_47 then
					arg_188_1.talkMaxDuration = var_191_47

					if var_191_47 + var_191_40 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_47 + var_191_40
					end
				end

				arg_188_1.text_.text = var_191_44
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042046", "story_v_out_413042.awb") ~= 0 then
					local var_191_48 = manager.audio:GetVoiceLength("story_v_out_413042", "413042046", "story_v_out_413042.awb") / 1000

					if var_191_48 + var_191_40 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_48 + var_191_40
					end

					if var_191_43.prefab_name ~= "" and arg_188_1.actors_[var_191_43.prefab_name] ~= nil then
						local var_191_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_43.prefab_name].transform, "story_v_out_413042", "413042046", "story_v_out_413042.awb")

						arg_188_1:RecordAudio("413042046", var_191_49)
						arg_188_1:RecordAudio("413042046", var_191_49)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_413042", "413042046", "story_v_out_413042.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_413042", "413042046", "story_v_out_413042.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_50 = math.max(var_191_41, arg_188_1.talkMaxDuration)

			if var_191_40 <= arg_188_1.time_ and arg_188_1.time_ < var_191_40 + var_191_50 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_40) / var_191_50

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_40 + var_191_50 and arg_188_1.time_ < var_191_40 + var_191_50 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_188_1:InitPlayNodeList()
	end,
	Play413042047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 413042047
		arg_192_1.duration_ = 4.6

		local var_192_0 = {
			zh = 4.6,
			ja = 2
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play413042048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10093"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos10093 = var_195_0.localPosition
				var_195_0.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10093", 0)

				local var_195_2 = var_195_0.childCount

				for iter_195_0 = 0, var_195_2 - 1 do
					local var_195_3 = var_195_0:GetChild(iter_195_0)

					if var_195_3.name == "" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_4 then
				local var_195_5 = (arg_192_1.time_ - var_195_1) / var_195_4
				local var_195_6 = Vector3.New(-1500, -350, -180)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10093, var_195_6, var_195_5)
			end

			if arg_192_1.time_ >= var_195_1 + var_195_4 and arg_192_1.time_ < var_195_1 + var_195_4 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_195_7 = arg_192_1.actors_["10093"]
			local var_195_8 = 0

			if var_195_8 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 and not isNil(var_195_7) and arg_192_1.var_.actorSpriteComps10093 == nil then
				arg_192_1.var_.actorSpriteComps10093 = var_195_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_9 = 2

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_9 and not isNil(var_195_7) then
				local var_195_10 = (arg_192_1.time_ - var_195_8) / var_195_9

				if arg_192_1.var_.actorSpriteComps10093 then
					for iter_195_1, iter_195_2 in pairs(arg_192_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_195_2 then
							if arg_192_1.isInRecall_ then
								local var_195_11 = Mathf.Lerp(iter_195_2.color.r, arg_192_1.hightColor2.r, var_195_10)
								local var_195_12 = Mathf.Lerp(iter_195_2.color.g, arg_192_1.hightColor2.g, var_195_10)
								local var_195_13 = Mathf.Lerp(iter_195_2.color.b, arg_192_1.hightColor2.b, var_195_10)

								iter_195_2.color = Color.New(var_195_11, var_195_12, var_195_13)
							else
								local var_195_14 = Mathf.Lerp(iter_195_2.color.r, 0.5, var_195_10)

								iter_195_2.color = Color.New(var_195_14, var_195_14, var_195_14)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_8 + var_195_9 and arg_192_1.time_ < var_195_8 + var_195_9 + arg_195_0 and not isNil(var_195_7) and arg_192_1.var_.actorSpriteComps10093 then
				for iter_195_3, iter_195_4 in pairs(arg_192_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_195_4 then
						if arg_192_1.isInRecall_ then
							iter_195_4.color = arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_195_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps10093 = nil
			end

			local var_195_15 = 0.433333333333333
			local var_195_16 = 1

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				local var_195_17 = "play"
				local var_195_18 = "effect"

				arg_192_1:AudioAction(var_195_17, var_195_18, "se_story_130", "se_story_130_noise", "")
			end

			local var_195_19 = 0
			local var_195_20 = 0.175

			if var_195_19 < arg_192_1.time_ and arg_192_1.time_ <= var_195_19 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_21 = arg_192_1:FormatText(StoryNameCfg[36].name)

				arg_192_1.leftNameTxt_.text = var_195_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_22 = arg_192_1:GetWordFromCfg(413042047)
				local var_195_23 = arg_192_1:FormatText(var_195_22.content)

				arg_192_1.text_.text = var_195_23

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_24 = 7
				local var_195_25 = utf8.len(var_195_23)
				local var_195_26 = var_195_24 <= 0 and var_195_20 or var_195_20 * (var_195_25 / var_195_24)

				if var_195_26 > 0 and var_195_20 < var_195_26 then
					arg_192_1.talkMaxDuration = var_195_26

					if var_195_26 + var_195_19 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_26 + var_195_19
					end
				end

				arg_192_1.text_.text = var_195_23
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042047", "story_v_out_413042.awb") ~= 0 then
					local var_195_27 = manager.audio:GetVoiceLength("story_v_out_413042", "413042047", "story_v_out_413042.awb") / 1000

					if var_195_27 + var_195_19 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_27 + var_195_19
					end

					if var_195_22.prefab_name ~= "" and arg_192_1.actors_[var_195_22.prefab_name] ~= nil then
						local var_195_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_22.prefab_name].transform, "story_v_out_413042", "413042047", "story_v_out_413042.awb")

						arg_192_1:RecordAudio("413042047", var_195_28)
						arg_192_1:RecordAudio("413042047", var_195_28)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_413042", "413042047", "story_v_out_413042.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_413042", "413042047", "story_v_out_413042.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_29 = math.max(var_195_20, arg_192_1.talkMaxDuration)

			if var_195_19 <= arg_192_1.time_ and arg_192_1.time_ < var_195_19 + var_195_29 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_19) / var_195_29

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_19 + var_195_29 and arg_192_1.time_ < var_195_19 + var_195_29 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	Play413042048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 413042048
		arg_196_1.duration_ = 4.7

		local var_196_0 = {
			zh = 2.133,
			ja = 4.7
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play413042049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10092"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos10092 = var_199_0.localPosition
				var_199_0.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10092", 3)

				local var_199_2 = var_199_0.childCount

				for iter_199_0 = 0, var_199_2 - 1 do
					local var_199_3 = var_199_0:GetChild(iter_199_0)

					if var_199_3.name == "split_5" or not string.find(var_199_3.name, "split") then
						var_199_3.gameObject:SetActive(true)
					else
						var_199_3.gameObject:SetActive(false)
					end
				end
			end

			local var_199_4 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_4 then
				local var_199_5 = (arg_196_1.time_ - var_199_1) / var_199_4
				local var_199_6 = Vector3.New(0, -300, -295)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10092, var_199_6, var_199_5)
			end

			if arg_196_1.time_ >= var_199_1 + var_199_4 and arg_196_1.time_ < var_199_1 + var_199_4 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_199_7 = arg_196_1.actors_["10092"]
			local var_199_8 = 0

			if var_199_8 < arg_196_1.time_ and arg_196_1.time_ <= var_199_8 + arg_199_0 and not isNil(var_199_7) and arg_196_1.var_.actorSpriteComps10092 == nil then
				arg_196_1.var_.actorSpriteComps10092 = var_199_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_9 = 2

			if var_199_8 <= arg_196_1.time_ and arg_196_1.time_ < var_199_8 + var_199_9 and not isNil(var_199_7) then
				local var_199_10 = (arg_196_1.time_ - var_199_8) / var_199_9

				if arg_196_1.var_.actorSpriteComps10092 then
					for iter_199_1, iter_199_2 in pairs(arg_196_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_199_2 then
							if arg_196_1.isInRecall_ then
								local var_199_11 = Mathf.Lerp(iter_199_2.color.r, arg_196_1.hightColor1.r, var_199_10)
								local var_199_12 = Mathf.Lerp(iter_199_2.color.g, arg_196_1.hightColor1.g, var_199_10)
								local var_199_13 = Mathf.Lerp(iter_199_2.color.b, arg_196_1.hightColor1.b, var_199_10)

								iter_199_2.color = Color.New(var_199_11, var_199_12, var_199_13)
							else
								local var_199_14 = Mathf.Lerp(iter_199_2.color.r, 1, var_199_10)

								iter_199_2.color = Color.New(var_199_14, var_199_14, var_199_14)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_8 + var_199_9 and arg_196_1.time_ < var_199_8 + var_199_9 + arg_199_0 and not isNil(var_199_7) and arg_196_1.var_.actorSpriteComps10092 then
				for iter_199_3, iter_199_4 in pairs(arg_196_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_199_4 then
						if arg_196_1.isInRecall_ then
							iter_199_4.color = arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_199_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps10092 = nil
			end

			local var_199_15 = 0
			local var_199_16 = 0.225

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_17 = arg_196_1:FormatText(StoryNameCfg[996].name)

				arg_196_1.leftNameTxt_.text = var_199_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_18 = arg_196_1:GetWordFromCfg(413042048)
				local var_199_19 = arg_196_1:FormatText(var_199_18.content)

				arg_196_1.text_.text = var_199_19

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_20 = 9
				local var_199_21 = utf8.len(var_199_19)
				local var_199_22 = var_199_20 <= 0 and var_199_16 or var_199_16 * (var_199_21 / var_199_20)

				if var_199_22 > 0 and var_199_16 < var_199_22 then
					arg_196_1.talkMaxDuration = var_199_22

					if var_199_22 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_22 + var_199_15
					end
				end

				arg_196_1.text_.text = var_199_19
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042048", "story_v_out_413042.awb") ~= 0 then
					local var_199_23 = manager.audio:GetVoiceLength("story_v_out_413042", "413042048", "story_v_out_413042.awb") / 1000

					if var_199_23 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_23 + var_199_15
					end

					if var_199_18.prefab_name ~= "" and arg_196_1.actors_[var_199_18.prefab_name] ~= nil then
						local var_199_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_18.prefab_name].transform, "story_v_out_413042", "413042048", "story_v_out_413042.awb")

						arg_196_1:RecordAudio("413042048", var_199_24)
						arg_196_1:RecordAudio("413042048", var_199_24)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_413042", "413042048", "story_v_out_413042.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_413042", "413042048", "story_v_out_413042.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_25 = math.max(var_199_16, arg_196_1.talkMaxDuration)

			if var_199_15 <= arg_196_1.time_ and arg_196_1.time_ < var_199_15 + var_199_25 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_15) / var_199_25

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_15 + var_199_25 and arg_196_1.time_ < var_199_15 + var_199_25 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play413042049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 413042049
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play413042050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10092"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos10092 = var_203_0.localPosition
				var_203_0.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10092", 0)

				local var_203_2 = var_203_0.childCount

				for iter_203_0 = 0, var_203_2 - 1 do
					local var_203_3 = var_203_0:GetChild(iter_203_0)

					if var_203_3.name == "" or not string.find(var_203_3.name, "split") then
						var_203_3.gameObject:SetActive(true)
					else
						var_203_3.gameObject:SetActive(false)
					end
				end
			end

			local var_203_4 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_4 then
				local var_203_5 = (arg_200_1.time_ - var_203_1) / var_203_4
				local var_203_6 = Vector3.New(0, -5000, 0)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10092, var_203_6, var_203_5)
			end

			if arg_200_1.time_ >= var_203_1 + var_203_4 and arg_200_1.time_ < var_203_1 + var_203_4 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_203_7 = arg_200_1.actors_["10092"]
			local var_203_8 = 0

			if var_203_8 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 and not isNil(var_203_7) and arg_200_1.var_.actorSpriteComps10092 == nil then
				arg_200_1.var_.actorSpriteComps10092 = var_203_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_9 = 2

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_9 and not isNil(var_203_7) then
				local var_203_10 = (arg_200_1.time_ - var_203_8) / var_203_9

				if arg_200_1.var_.actorSpriteComps10092 then
					for iter_203_1, iter_203_2 in pairs(arg_200_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_203_2 then
							if arg_200_1.isInRecall_ then
								local var_203_11 = Mathf.Lerp(iter_203_2.color.r, arg_200_1.hightColor2.r, var_203_10)
								local var_203_12 = Mathf.Lerp(iter_203_2.color.g, arg_200_1.hightColor2.g, var_203_10)
								local var_203_13 = Mathf.Lerp(iter_203_2.color.b, arg_200_1.hightColor2.b, var_203_10)

								iter_203_2.color = Color.New(var_203_11, var_203_12, var_203_13)
							else
								local var_203_14 = Mathf.Lerp(iter_203_2.color.r, 0.5, var_203_10)

								iter_203_2.color = Color.New(var_203_14, var_203_14, var_203_14)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_8 + var_203_9 and arg_200_1.time_ < var_203_8 + var_203_9 + arg_203_0 and not isNil(var_203_7) and arg_200_1.var_.actorSpriteComps10092 then
				for iter_203_3, iter_203_4 in pairs(arg_200_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_203_4 then
						if arg_200_1.isInRecall_ then
							iter_203_4.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10092 = nil
			end

			local var_203_15 = 0
			local var_203_16 = 1.025

			if var_203_15 < arg_200_1.time_ and arg_200_1.time_ <= var_203_15 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_17 = arg_200_1:GetWordFromCfg(413042049)
				local var_203_18 = arg_200_1:FormatText(var_203_17.content)

				arg_200_1.text_.text = var_203_18

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_19 = 41
				local var_203_20 = utf8.len(var_203_18)
				local var_203_21 = var_203_19 <= 0 and var_203_16 or var_203_16 * (var_203_20 / var_203_19)

				if var_203_21 > 0 and var_203_16 < var_203_21 then
					arg_200_1.talkMaxDuration = var_203_21

					if var_203_21 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_21 + var_203_15
					end
				end

				arg_200_1.text_.text = var_203_18
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_22 = math.max(var_203_16, arg_200_1.talkMaxDuration)

			if var_203_15 <= arg_200_1.time_ and arg_200_1.time_ < var_203_15 + var_203_22 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_15) / var_203_22

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_15 + var_203_22 and arg_200_1.time_ < var_203_15 + var_203_22 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play413042050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 413042050
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play413042051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 1.15

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_2 = arg_204_1:GetWordFromCfg(413042050)
				local var_207_3 = arg_204_1:FormatText(var_207_2.content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 46
				local var_207_5 = utf8.len(var_207_3)
				local var_207_6 = var_207_4 <= 0 and var_207_1 or var_207_1 * (var_207_5 / var_207_4)

				if var_207_6 > 0 and var_207_1 < var_207_6 then
					arg_204_1.talkMaxDuration = var_207_6

					if var_207_6 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_6 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_3
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_7 and arg_204_1.time_ < var_207_0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play413042051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 413042051
		arg_208_1.duration_ = 4.64

		local var_208_0 = {
			zh = 3.908,
			ja = 4.641
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play413042052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = manager.ui.mainCamera.transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.shakeOldPos = var_211_0.localPosition
			end

			local var_211_2 = 0.6

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / 0.066
				local var_211_4, var_211_5 = math.modf(var_211_3)

				var_211_0.localPosition = Vector3.New(var_211_5 * 0.13, var_211_5 * 0.13, var_211_5 * 0.13) + arg_208_1.var_.shakeOldPos
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 then
				var_211_0.localPosition = arg_208_1.var_.shakeOldPos
			end

			local var_211_6 = 0

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			local var_211_7 = 0.6

			if arg_208_1.time_ >= var_211_6 + var_211_7 and arg_208_1.time_ < var_211_6 + var_211_7 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_8 = 0.575
			local var_211_9 = 0.425

			if var_211_8 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_10 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_10:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_11 = arg_208_1:FormatText(StoryNameCfg[996].name)

				arg_208_1.leftNameTxt_.text = var_211_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_3")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_12 = arg_208_1:GetWordFromCfg(413042051)
				local var_211_13 = arg_208_1:FormatText(var_211_12.content)

				arg_208_1.text_.text = var_211_13

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_14 = 17
				local var_211_15 = utf8.len(var_211_13)
				local var_211_16 = var_211_14 <= 0 and var_211_9 or var_211_9 * (var_211_15 / var_211_14)

				if var_211_16 > 0 and var_211_9 < var_211_16 then
					arg_208_1.talkMaxDuration = var_211_16
					var_211_8 = var_211_8 + 0.3

					if var_211_16 + var_211_8 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_16 + var_211_8
					end
				end

				arg_208_1.text_.text = var_211_13
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042051", "story_v_out_413042.awb") ~= 0 then
					local var_211_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042051", "story_v_out_413042.awb") / 1000

					if var_211_17 + var_211_8 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_17 + var_211_8
					end

					if var_211_12.prefab_name ~= "" and arg_208_1.actors_[var_211_12.prefab_name] ~= nil then
						local var_211_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_12.prefab_name].transform, "story_v_out_413042", "413042051", "story_v_out_413042.awb")

						arg_208_1:RecordAudio("413042051", var_211_18)
						arg_208_1:RecordAudio("413042051", var_211_18)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_413042", "413042051", "story_v_out_413042.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_413042", "413042051", "story_v_out_413042.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_19 = var_211_8 + 0.3
			local var_211_20 = math.max(var_211_9, arg_208_1.talkMaxDuration)

			if var_211_19 <= arg_208_1.time_ and arg_208_1.time_ < var_211_19 + var_211_20 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_19) / var_211_20

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_19 + var_211_20 and arg_208_1.time_ < var_211_19 + var_211_20 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play413042052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 413042052
		arg_214_1.duration_ = 2

		local var_214_0 = {
			zh = 2,
			ja = 1.999999999999
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play413042053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10097"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos10097 = var_217_0.localPosition
				var_217_0.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("10097", 3)

				local var_217_2 = var_217_0.childCount

				for iter_217_0 = 0, var_217_2 - 1 do
					local var_217_3 = var_217_0:GetChild(iter_217_0)

					if var_217_3.name == "" or not string.find(var_217_3.name, "split") then
						var_217_3.gameObject:SetActive(true)
					else
						var_217_3.gameObject:SetActive(false)
					end
				end
			end

			local var_217_4 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_4 then
				local var_217_5 = (arg_214_1.time_ - var_217_1) / var_217_4
				local var_217_6 = Vector3.New(0, -350, -180)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10097, var_217_6, var_217_5)
			end

			if arg_214_1.time_ >= var_217_1 + var_217_4 and arg_214_1.time_ < var_217_1 + var_217_4 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_217_7 = arg_214_1.actors_["10097"]
			local var_217_8 = 0

			if var_217_8 < arg_214_1.time_ and arg_214_1.time_ <= var_217_8 + arg_217_0 and not isNil(var_217_7) and arg_214_1.var_.actorSpriteComps10097 == nil then
				arg_214_1.var_.actorSpriteComps10097 = var_217_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_9 = 2

			if var_217_8 <= arg_214_1.time_ and arg_214_1.time_ < var_217_8 + var_217_9 and not isNil(var_217_7) then
				local var_217_10 = (arg_214_1.time_ - var_217_8) / var_217_9

				if arg_214_1.var_.actorSpriteComps10097 then
					for iter_217_1, iter_217_2 in pairs(arg_214_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_217_2 then
							if arg_214_1.isInRecall_ then
								local var_217_11 = Mathf.Lerp(iter_217_2.color.r, arg_214_1.hightColor1.r, var_217_10)
								local var_217_12 = Mathf.Lerp(iter_217_2.color.g, arg_214_1.hightColor1.g, var_217_10)
								local var_217_13 = Mathf.Lerp(iter_217_2.color.b, arg_214_1.hightColor1.b, var_217_10)

								iter_217_2.color = Color.New(var_217_11, var_217_12, var_217_13)
							else
								local var_217_14 = Mathf.Lerp(iter_217_2.color.r, 1, var_217_10)

								iter_217_2.color = Color.New(var_217_14, var_217_14, var_217_14)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_8 + var_217_9 and arg_214_1.time_ < var_217_8 + var_217_9 + arg_217_0 and not isNil(var_217_7) and arg_214_1.var_.actorSpriteComps10097 then
				for iter_217_3, iter_217_4 in pairs(arg_214_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_217_4 then
						if arg_214_1.isInRecall_ then
							iter_217_4.color = arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_217_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps10097 = nil
			end

			local var_217_15 = arg_214_1.actors_["10092"]
			local var_217_16 = 0

			if var_217_16 < arg_214_1.time_ and arg_214_1.time_ <= var_217_16 + arg_217_0 and not isNil(var_217_15) and arg_214_1.var_.actorSpriteComps10092 == nil then
				arg_214_1.var_.actorSpriteComps10092 = var_217_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_17 = 2

			if var_217_16 <= arg_214_1.time_ and arg_214_1.time_ < var_217_16 + var_217_17 and not isNil(var_217_15) then
				local var_217_18 = (arg_214_1.time_ - var_217_16) / var_217_17

				if arg_214_1.var_.actorSpriteComps10092 then
					for iter_217_5, iter_217_6 in pairs(arg_214_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_217_6 then
							if arg_214_1.isInRecall_ then
								local var_217_19 = Mathf.Lerp(iter_217_6.color.r, arg_214_1.hightColor2.r, var_217_18)
								local var_217_20 = Mathf.Lerp(iter_217_6.color.g, arg_214_1.hightColor2.g, var_217_18)
								local var_217_21 = Mathf.Lerp(iter_217_6.color.b, arg_214_1.hightColor2.b, var_217_18)

								iter_217_6.color = Color.New(var_217_19, var_217_20, var_217_21)
							else
								local var_217_22 = Mathf.Lerp(iter_217_6.color.r, 0.5, var_217_18)

								iter_217_6.color = Color.New(var_217_22, var_217_22, var_217_22)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_16 + var_217_17 and arg_214_1.time_ < var_217_16 + var_217_17 + arg_217_0 and not isNil(var_217_15) and arg_214_1.var_.actorSpriteComps10092 then
				for iter_217_7, iter_217_8 in pairs(arg_214_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_217_8 then
						if arg_214_1.isInRecall_ then
							iter_217_8.color = arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_217_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps10092 = nil
			end

			local var_217_23 = 0
			local var_217_24 = 0.225

			if var_217_23 < arg_214_1.time_ and arg_214_1.time_ <= var_217_23 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_25 = arg_214_1:FormatText(StoryNameCfg[1001].name)

				arg_214_1.leftNameTxt_.text = var_217_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_26 = arg_214_1:GetWordFromCfg(413042052)
				local var_217_27 = arg_214_1:FormatText(var_217_26.content)

				arg_214_1.text_.text = var_217_27

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_28 = 9
				local var_217_29 = utf8.len(var_217_27)
				local var_217_30 = var_217_28 <= 0 and var_217_24 or var_217_24 * (var_217_29 / var_217_28)

				if var_217_30 > 0 and var_217_24 < var_217_30 then
					arg_214_1.talkMaxDuration = var_217_30

					if var_217_30 + var_217_23 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_30 + var_217_23
					end
				end

				arg_214_1.text_.text = var_217_27
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042052", "story_v_out_413042.awb") ~= 0 then
					local var_217_31 = manager.audio:GetVoiceLength("story_v_out_413042", "413042052", "story_v_out_413042.awb") / 1000

					if var_217_31 + var_217_23 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_31 + var_217_23
					end

					if var_217_26.prefab_name ~= "" and arg_214_1.actors_[var_217_26.prefab_name] ~= nil then
						local var_217_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_26.prefab_name].transform, "story_v_out_413042", "413042052", "story_v_out_413042.awb")

						arg_214_1:RecordAudio("413042052", var_217_32)
						arg_214_1:RecordAudio("413042052", var_217_32)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_413042", "413042052", "story_v_out_413042.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_413042", "413042052", "story_v_out_413042.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_33 = math.max(var_217_24, arg_214_1.talkMaxDuration)

			if var_217_23 <= arg_214_1.time_ and arg_214_1.time_ < var_217_23 + var_217_33 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_23) / var_217_33

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_23 + var_217_33 and arg_214_1.time_ < var_217_23 + var_217_33 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
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

		arg_214_1:InitPlayNodeList()
	end,
	Play413042053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 413042053
		arg_218_1.duration_ = 5.27

		local var_218_0 = {
			zh = 3.666,
			ja = 5.266
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play413042054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["10097"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos10097 = var_221_0.localPosition
				var_221_0.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10097", 0)

				local var_221_2 = var_221_0.childCount

				for iter_221_0 = 0, var_221_2 - 1 do
					local var_221_3 = var_221_0:GetChild(iter_221_0)

					if var_221_3.name == "" or not string.find(var_221_3.name, "split") then
						var_221_3.gameObject:SetActive(true)
					else
						var_221_3.gameObject:SetActive(false)
					end
				end
			end

			local var_221_4 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_4 then
				local var_221_5 = (arg_218_1.time_ - var_221_1) / var_221_4
				local var_221_6 = Vector3.New(-1500, -350, -180)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10097, var_221_6, var_221_5)
			end

			if arg_218_1.time_ >= var_221_1 + var_221_4 and arg_218_1.time_ < var_221_1 + var_221_4 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_221_7 = arg_218_1.actors_["10093"].transform
			local var_221_8 = 0

			if var_221_8 < arg_218_1.time_ and arg_218_1.time_ <= var_221_8 + arg_221_0 then
				arg_218_1.var_.moveOldPos10093 = var_221_7.localPosition
				var_221_7.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10093", 3)

				local var_221_9 = var_221_7.childCount

				for iter_221_1 = 0, var_221_9 - 1 do
					local var_221_10 = var_221_7:GetChild(iter_221_1)

					if var_221_10.name == "split_5" or not string.find(var_221_10.name, "split") then
						var_221_10.gameObject:SetActive(true)
					else
						var_221_10.gameObject:SetActive(false)
					end
				end
			end

			local var_221_11 = 0.001

			if var_221_8 <= arg_218_1.time_ and arg_218_1.time_ < var_221_8 + var_221_11 then
				local var_221_12 = (arg_218_1.time_ - var_221_8) / var_221_11
				local var_221_13 = Vector3.New(0, -345, -245)

				var_221_7.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10093, var_221_13, var_221_12)
			end

			if arg_218_1.time_ >= var_221_8 + var_221_11 and arg_218_1.time_ < var_221_8 + var_221_11 + arg_221_0 then
				var_221_7.localPosition = Vector3.New(0, -345, -245)
			end

			local var_221_14 = arg_218_1.actors_["10097"]
			local var_221_15 = 0

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 and not isNil(var_221_14) and arg_218_1.var_.actorSpriteComps10097 == nil then
				arg_218_1.var_.actorSpriteComps10097 = var_221_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_16 = 2

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_16 and not isNil(var_221_14) then
				local var_221_17 = (arg_218_1.time_ - var_221_15) / var_221_16

				if arg_218_1.var_.actorSpriteComps10097 then
					for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_221_3 then
							if arg_218_1.isInRecall_ then
								local var_221_18 = Mathf.Lerp(iter_221_3.color.r, arg_218_1.hightColor2.r, var_221_17)
								local var_221_19 = Mathf.Lerp(iter_221_3.color.g, arg_218_1.hightColor2.g, var_221_17)
								local var_221_20 = Mathf.Lerp(iter_221_3.color.b, arg_218_1.hightColor2.b, var_221_17)

								iter_221_3.color = Color.New(var_221_18, var_221_19, var_221_20)
							else
								local var_221_21 = Mathf.Lerp(iter_221_3.color.r, 0.5, var_221_17)

								iter_221_3.color = Color.New(var_221_21, var_221_21, var_221_21)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= var_221_15 + var_221_16 and arg_218_1.time_ < var_221_15 + var_221_16 + arg_221_0 and not isNil(var_221_14) and arg_218_1.var_.actorSpriteComps10097 then
				for iter_221_4, iter_221_5 in pairs(arg_218_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_221_5 then
						if arg_218_1.isInRecall_ then
							iter_221_5.color = arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_221_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps10097 = nil
			end

			local var_221_22 = arg_218_1.actors_["10093"]
			local var_221_23 = 0

			if var_221_23 < arg_218_1.time_ and arg_218_1.time_ <= var_221_23 + arg_221_0 and not isNil(var_221_22) and arg_218_1.var_.actorSpriteComps10093 == nil then
				arg_218_1.var_.actorSpriteComps10093 = var_221_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_24 = 2

			if var_221_23 <= arg_218_1.time_ and arg_218_1.time_ < var_221_23 + var_221_24 and not isNil(var_221_22) then
				local var_221_25 = (arg_218_1.time_ - var_221_23) / var_221_24

				if arg_218_1.var_.actorSpriteComps10093 then
					for iter_221_6, iter_221_7 in pairs(arg_218_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_221_7 then
							if arg_218_1.isInRecall_ then
								local var_221_26 = Mathf.Lerp(iter_221_7.color.r, arg_218_1.hightColor1.r, var_221_25)
								local var_221_27 = Mathf.Lerp(iter_221_7.color.g, arg_218_1.hightColor1.g, var_221_25)
								local var_221_28 = Mathf.Lerp(iter_221_7.color.b, arg_218_1.hightColor1.b, var_221_25)

								iter_221_7.color = Color.New(var_221_26, var_221_27, var_221_28)
							else
								local var_221_29 = Mathf.Lerp(iter_221_7.color.r, 1, var_221_25)

								iter_221_7.color = Color.New(var_221_29, var_221_29, var_221_29)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= var_221_23 + var_221_24 and arg_218_1.time_ < var_221_23 + var_221_24 + arg_221_0 and not isNil(var_221_22) and arg_218_1.var_.actorSpriteComps10093 then
				for iter_221_8, iter_221_9 in pairs(arg_218_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_221_9 then
						if arg_218_1.isInRecall_ then
							iter_221_9.color = arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_221_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps10093 = nil
			end

			local var_221_30 = 0
			local var_221_31 = 0.55

			if var_221_30 < arg_218_1.time_ and arg_218_1.time_ <= var_221_30 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_32 = arg_218_1:FormatText(StoryNameCfg[28].name)

				arg_218_1.leftNameTxt_.text = var_221_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_33 = arg_218_1:GetWordFromCfg(413042053)
				local var_221_34 = arg_218_1:FormatText(var_221_33.content)

				arg_218_1.text_.text = var_221_34

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_35 = 22
				local var_221_36 = utf8.len(var_221_34)
				local var_221_37 = var_221_35 <= 0 and var_221_31 or var_221_31 * (var_221_36 / var_221_35)

				if var_221_37 > 0 and var_221_31 < var_221_37 then
					arg_218_1.talkMaxDuration = var_221_37

					if var_221_37 + var_221_30 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_37 + var_221_30
					end
				end

				arg_218_1.text_.text = var_221_34
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042053", "story_v_out_413042.awb") ~= 0 then
					local var_221_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042053", "story_v_out_413042.awb") / 1000

					if var_221_38 + var_221_30 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_38 + var_221_30
					end

					if var_221_33.prefab_name ~= "" and arg_218_1.actors_[var_221_33.prefab_name] ~= nil then
						local var_221_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_33.prefab_name].transform, "story_v_out_413042", "413042053", "story_v_out_413042.awb")

						arg_218_1:RecordAudio("413042053", var_221_39)
						arg_218_1:RecordAudio("413042053", var_221_39)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_413042", "413042053", "story_v_out_413042.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_413042", "413042053", "story_v_out_413042.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_40 = math.max(var_221_31, arg_218_1.talkMaxDuration)

			if var_221_30 <= arg_218_1.time_ and arg_218_1.time_ < var_221_30 + var_221_40 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_30) / var_221_40

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_30 + var_221_40 and arg_218_1.time_ < var_221_30 + var_221_40 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play413042054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 413042054
		arg_222_1.duration_ = 2

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play413042055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10097"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos10097 = var_225_0.localPosition
				var_225_0.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10097", 3)

				local var_225_2 = var_225_0.childCount

				for iter_225_0 = 0, var_225_2 - 1 do
					local var_225_3 = var_225_0:GetChild(iter_225_0)

					if var_225_3.name == "split_2" or not string.find(var_225_3.name, "split") then
						var_225_3.gameObject:SetActive(true)
					else
						var_225_3.gameObject:SetActive(false)
					end
				end
			end

			local var_225_4 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_4 then
				local var_225_5 = (arg_222_1.time_ - var_225_1) / var_225_4
				local var_225_6 = Vector3.New(0, -350, -180)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10097, var_225_6, var_225_5)
			end

			if arg_222_1.time_ >= var_225_1 + var_225_4 and arg_222_1.time_ < var_225_1 + var_225_4 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_225_7 = arg_222_1.actors_["10093"].transform
			local var_225_8 = 0

			if var_225_8 < arg_222_1.time_ and arg_222_1.time_ <= var_225_8 + arg_225_0 then
				arg_222_1.var_.moveOldPos10093 = var_225_7.localPosition
				var_225_7.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10093", 0)

				local var_225_9 = var_225_7.childCount

				for iter_225_1 = 0, var_225_9 - 1 do
					local var_225_10 = var_225_7:GetChild(iter_225_1)

					if var_225_10.name == "split_7" or not string.find(var_225_10.name, "split") then
						var_225_10.gameObject:SetActive(true)
					else
						var_225_10.gameObject:SetActive(false)
					end
				end
			end

			local var_225_11 = 0.001

			if var_225_8 <= arg_222_1.time_ and arg_222_1.time_ < var_225_8 + var_225_11 then
				local var_225_12 = (arg_222_1.time_ - var_225_8) / var_225_11
				local var_225_13 = Vector3.New(-1500, -350, -180)

				var_225_7.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10093, var_225_13, var_225_12)
			end

			if arg_222_1.time_ >= var_225_8 + var_225_11 and arg_222_1.time_ < var_225_8 + var_225_11 + arg_225_0 then
				var_225_7.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_225_14 = arg_222_1.actors_["10097"]
			local var_225_15 = 0

			if var_225_15 < arg_222_1.time_ and arg_222_1.time_ <= var_225_15 + arg_225_0 and not isNil(var_225_14) and arg_222_1.var_.actorSpriteComps10097 == nil then
				arg_222_1.var_.actorSpriteComps10097 = var_225_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_16 = 2

			if var_225_15 <= arg_222_1.time_ and arg_222_1.time_ < var_225_15 + var_225_16 and not isNil(var_225_14) then
				local var_225_17 = (arg_222_1.time_ - var_225_15) / var_225_16

				if arg_222_1.var_.actorSpriteComps10097 then
					for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_225_3 then
							if arg_222_1.isInRecall_ then
								local var_225_18 = Mathf.Lerp(iter_225_3.color.r, arg_222_1.hightColor1.r, var_225_17)
								local var_225_19 = Mathf.Lerp(iter_225_3.color.g, arg_222_1.hightColor1.g, var_225_17)
								local var_225_20 = Mathf.Lerp(iter_225_3.color.b, arg_222_1.hightColor1.b, var_225_17)

								iter_225_3.color = Color.New(var_225_18, var_225_19, var_225_20)
							else
								local var_225_21 = Mathf.Lerp(iter_225_3.color.r, 1, var_225_17)

								iter_225_3.color = Color.New(var_225_21, var_225_21, var_225_21)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_15 + var_225_16 and arg_222_1.time_ < var_225_15 + var_225_16 + arg_225_0 and not isNil(var_225_14) and arg_222_1.var_.actorSpriteComps10097 then
				for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_225_5 then
						if arg_222_1.isInRecall_ then
							iter_225_5.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps10097 = nil
			end

			local var_225_22 = arg_222_1.actors_["10093"]
			local var_225_23 = 0

			if var_225_23 < arg_222_1.time_ and arg_222_1.time_ <= var_225_23 + arg_225_0 and not isNil(var_225_22) and arg_222_1.var_.actorSpriteComps10093 == nil then
				arg_222_1.var_.actorSpriteComps10093 = var_225_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_24 = 2

			if var_225_23 <= arg_222_1.time_ and arg_222_1.time_ < var_225_23 + var_225_24 and not isNil(var_225_22) then
				local var_225_25 = (arg_222_1.time_ - var_225_23) / var_225_24

				if arg_222_1.var_.actorSpriteComps10093 then
					for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_225_7 then
							if arg_222_1.isInRecall_ then
								local var_225_26 = Mathf.Lerp(iter_225_7.color.r, arg_222_1.hightColor2.r, var_225_25)
								local var_225_27 = Mathf.Lerp(iter_225_7.color.g, arg_222_1.hightColor2.g, var_225_25)
								local var_225_28 = Mathf.Lerp(iter_225_7.color.b, arg_222_1.hightColor2.b, var_225_25)

								iter_225_7.color = Color.New(var_225_26, var_225_27, var_225_28)
							else
								local var_225_29 = Mathf.Lerp(iter_225_7.color.r, 0.5, var_225_25)

								iter_225_7.color = Color.New(var_225_29, var_225_29, var_225_29)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_23 + var_225_24 and arg_222_1.time_ < var_225_23 + var_225_24 + arg_225_0 and not isNil(var_225_22) and arg_222_1.var_.actorSpriteComps10093 then
				for iter_225_8, iter_225_9 in pairs(arg_222_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_225_9 then
						if arg_222_1.isInRecall_ then
							iter_225_9.color = arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_225_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps10093 = nil
			end

			local var_225_30 = 0
			local var_225_31 = 0.05

			if var_225_30 < arg_222_1.time_ and arg_222_1.time_ <= var_225_30 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_32 = arg_222_1:FormatText(StoryNameCfg[1001].name)

				arg_222_1.leftNameTxt_.text = var_225_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_33 = arg_222_1:GetWordFromCfg(413042054)
				local var_225_34 = arg_222_1:FormatText(var_225_33.content)

				arg_222_1.text_.text = var_225_34

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_35 = 2
				local var_225_36 = utf8.len(var_225_34)
				local var_225_37 = var_225_35 <= 0 and var_225_31 or var_225_31 * (var_225_36 / var_225_35)

				if var_225_37 > 0 and var_225_31 < var_225_37 then
					arg_222_1.talkMaxDuration = var_225_37

					if var_225_37 + var_225_30 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_37 + var_225_30
					end
				end

				arg_222_1.text_.text = var_225_34
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042054", "story_v_out_413042.awb") ~= 0 then
					local var_225_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042054", "story_v_out_413042.awb") / 1000

					if var_225_38 + var_225_30 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_38 + var_225_30
					end

					if var_225_33.prefab_name ~= "" and arg_222_1.actors_[var_225_33.prefab_name] ~= nil then
						local var_225_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_33.prefab_name].transform, "story_v_out_413042", "413042054", "story_v_out_413042.awb")

						arg_222_1:RecordAudio("413042054", var_225_39)
						arg_222_1:RecordAudio("413042054", var_225_39)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_413042", "413042054", "story_v_out_413042.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_413042", "413042054", "story_v_out_413042.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_40 = math.max(var_225_31, arg_222_1.talkMaxDuration)

			if var_225_30 <= arg_222_1.time_ and arg_222_1.time_ < var_225_30 + var_225_40 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_30) / var_225_40

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_30 + var_225_40 and arg_222_1.time_ < var_225_30 + var_225_40 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play413042055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 413042055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play413042056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["10097"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos10097 = var_229_0.localPosition
				var_229_0.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10097", 0)

				local var_229_2 = var_229_0.childCount

				for iter_229_0 = 0, var_229_2 - 1 do
					local var_229_3 = var_229_0:GetChild(iter_229_0)

					if var_229_3.name == "" or not string.find(var_229_3.name, "split") then
						var_229_3.gameObject:SetActive(true)
					else
						var_229_3.gameObject:SetActive(false)
					end
				end
			end

			local var_229_4 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_4 then
				local var_229_5 = (arg_226_1.time_ - var_229_1) / var_229_4
				local var_229_6 = Vector3.New(-1500, -350, -180)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10097, var_229_6, var_229_5)
			end

			if arg_226_1.time_ >= var_229_1 + var_229_4 and arg_226_1.time_ < var_229_1 + var_229_4 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_229_7 = arg_226_1.actors_["10097"]
			local var_229_8 = 0

			if var_229_8 < arg_226_1.time_ and arg_226_1.time_ <= var_229_8 + arg_229_0 and not isNil(var_229_7) and arg_226_1.var_.actorSpriteComps10097 == nil then
				arg_226_1.var_.actorSpriteComps10097 = var_229_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_9 = 2

			if var_229_8 <= arg_226_1.time_ and arg_226_1.time_ < var_229_8 + var_229_9 and not isNil(var_229_7) then
				local var_229_10 = (arg_226_1.time_ - var_229_8) / var_229_9

				if arg_226_1.var_.actorSpriteComps10097 then
					for iter_229_1, iter_229_2 in pairs(arg_226_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_229_2 then
							if arg_226_1.isInRecall_ then
								local var_229_11 = Mathf.Lerp(iter_229_2.color.r, arg_226_1.hightColor2.r, var_229_10)
								local var_229_12 = Mathf.Lerp(iter_229_2.color.g, arg_226_1.hightColor2.g, var_229_10)
								local var_229_13 = Mathf.Lerp(iter_229_2.color.b, arg_226_1.hightColor2.b, var_229_10)

								iter_229_2.color = Color.New(var_229_11, var_229_12, var_229_13)
							else
								local var_229_14 = Mathf.Lerp(iter_229_2.color.r, 0.5, var_229_10)

								iter_229_2.color = Color.New(var_229_14, var_229_14, var_229_14)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_8 + var_229_9 and arg_226_1.time_ < var_229_8 + var_229_9 + arg_229_0 and not isNil(var_229_7) and arg_226_1.var_.actorSpriteComps10097 then
				for iter_229_3, iter_229_4 in pairs(arg_226_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_229_4 then
						if arg_226_1.isInRecall_ then
							iter_229_4.color = arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_229_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps10097 = nil
			end

			local var_229_15 = 0
			local var_229_16 = 1.175

			if var_229_15 < arg_226_1.time_ and arg_226_1.time_ <= var_229_15 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_17 = arg_226_1:GetWordFromCfg(413042055)
				local var_229_18 = arg_226_1:FormatText(var_229_17.content)

				arg_226_1.text_.text = var_229_18

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_19 = 47
				local var_229_20 = utf8.len(var_229_18)
				local var_229_21 = var_229_19 <= 0 and var_229_16 or var_229_16 * (var_229_20 / var_229_19)

				if var_229_21 > 0 and var_229_16 < var_229_21 then
					arg_226_1.talkMaxDuration = var_229_21

					if var_229_21 + var_229_15 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_21 + var_229_15
					end
				end

				arg_226_1.text_.text = var_229_18
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_22 = math.max(var_229_16, arg_226_1.talkMaxDuration)

			if var_229_15 <= arg_226_1.time_ and arg_226_1.time_ < var_229_15 + var_229_22 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_15) / var_229_22

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_15 + var_229_22 and arg_226_1.time_ < var_229_15 + var_229_22 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
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

		arg_226_1:InitPlayNodeList()
	end,
	Play413042056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 413042056
		arg_230_1.duration_ = 2.13

		local var_230_0 = {
			zh = 1.5,
			ja = 2.133
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play413042057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = manager.ui.mainCamera.transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.shakeOldPos = var_233_0.localPosition
			end

			local var_233_2 = 0.6

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / 0.066
				local var_233_4, var_233_5 = math.modf(var_233_3)

				var_233_0.localPosition = Vector3.New(var_233_5 * 0.13, var_233_5 * 0.13, var_233_5 * 0.13) + arg_230_1.var_.shakeOldPos
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 then
				var_233_0.localPosition = arg_230_1.var_.shakeOldPos
			end

			local var_233_6 = 0

			if var_233_6 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			local var_233_7 = 0.6

			if arg_230_1.time_ >= var_233_6 + var_233_7 and arg_230_1.time_ < var_233_6 + var_233_7 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_8 = 0.4
			local var_233_9 = 0.1

			if var_233_8 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_10 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_10:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_11 = arg_230_1:FormatText(StoryNameCfg[614].name)

				arg_230_1.leftNameTxt_.text = var_233_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_4")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_12 = arg_230_1:GetWordFromCfg(413042056)
				local var_233_13 = arg_230_1:FormatText(var_233_12.content)

				arg_230_1.text_.text = var_233_13

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_14 = 4
				local var_233_15 = utf8.len(var_233_13)
				local var_233_16 = var_233_14 <= 0 and var_233_9 or var_233_9 * (var_233_15 / var_233_14)

				if var_233_16 > 0 and var_233_9 < var_233_16 then
					arg_230_1.talkMaxDuration = var_233_16
					var_233_8 = var_233_8 + 0.3

					if var_233_16 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_16 + var_233_8
					end
				end

				arg_230_1.text_.text = var_233_13
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042056", "story_v_out_413042.awb") ~= 0 then
					local var_233_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042056", "story_v_out_413042.awb") / 1000

					if var_233_17 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_17 + var_233_8
					end

					if var_233_12.prefab_name ~= "" and arg_230_1.actors_[var_233_12.prefab_name] ~= nil then
						local var_233_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_12.prefab_name].transform, "story_v_out_413042", "413042056", "story_v_out_413042.awb")

						arg_230_1:RecordAudio("413042056", var_233_18)
						arg_230_1:RecordAudio("413042056", var_233_18)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_413042", "413042056", "story_v_out_413042.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_413042", "413042056", "story_v_out_413042.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_19 = var_233_8 + 0.3
			local var_233_20 = math.max(var_233_9, arg_230_1.talkMaxDuration)

			if var_233_19 <= arg_230_1.time_ and arg_230_1.time_ < var_233_19 + var_233_20 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_19) / var_233_20

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_19 + var_233_20 and arg_230_1.time_ < var_233_19 + var_233_20 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play413042057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 413042057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play413042058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 1.2

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_2 = arg_236_1:GetWordFromCfg(413042057)
				local var_239_3 = arg_236_1:FormatText(var_239_2.content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 48
				local var_239_5 = utf8.len(var_239_3)
				local var_239_6 = var_239_4 <= 0 and var_239_1 or var_239_1 * (var_239_5 / var_239_4)

				if var_239_6 > 0 and var_239_1 < var_239_6 then
					arg_236_1.talkMaxDuration = var_239_6

					if var_239_6 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_6 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_7 and arg_236_1.time_ < var_239_0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play413042058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 413042058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play413042059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 1.45

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(413042058)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 58
				local var_243_5 = utf8.len(var_243_3)
				local var_243_6 = var_243_4 <= 0 and var_243_1 or var_243_1 * (var_243_5 / var_243_4)

				if var_243_6 > 0 and var_243_1 < var_243_6 then
					arg_240_1.talkMaxDuration = var_243_6

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_7 and arg_240_1.time_ < var_243_0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play413042059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 413042059
		arg_244_1.duration_ = 7.17

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play413042060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = "SS1303"

			if arg_244_1.bgs_[var_247_0] == nil then
				local var_247_1 = Object.Instantiate(arg_244_1.paintGo_)

				var_247_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_247_0)
				var_247_1.name = var_247_0
				var_247_1.transform.parent = arg_244_1.stage_.transform
				var_247_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_244_1.bgs_[var_247_0] = var_247_1
			end

			local var_247_2 = 0.666666666666666

			if var_247_2 < arg_244_1.time_ and arg_244_1.time_ <= var_247_2 + arg_247_0 then
				local var_247_3 = manager.ui.mainCamera.transform.localPosition
				local var_247_4 = Vector3.New(0, 0, 10) + Vector3.New(var_247_3.x, var_247_3.y, 0)
				local var_247_5 = arg_244_1.bgs_.SS1303

				var_247_5.transform.localPosition = var_247_4
				var_247_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_247_6 = var_247_5:GetComponent("SpriteRenderer")

				if var_247_6 and var_247_6.sprite then
					local var_247_7 = (var_247_5.transform.localPosition - var_247_3).z
					local var_247_8 = manager.ui.mainCameraCom_
					local var_247_9 = 2 * var_247_7 * Mathf.Tan(var_247_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_247_10 = var_247_9 * var_247_8.aspect
					local var_247_11 = var_247_6.sprite.bounds.size.x
					local var_247_12 = var_247_6.sprite.bounds.size.y
					local var_247_13 = var_247_10 / var_247_11
					local var_247_14 = var_247_9 / var_247_12
					local var_247_15 = var_247_14 < var_247_13 and var_247_13 or var_247_14

					var_247_5.transform.localScale = Vector3.New(var_247_15, var_247_15, 0)
				end

				for iter_247_0, iter_247_1 in pairs(arg_244_1.bgs_) do
					if iter_247_0 ~= "SS1303" then
						iter_247_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_247_16 = 0

			if var_247_16 < arg_244_1.time_ and arg_244_1.time_ <= var_247_16 + arg_247_0 then
				arg_244_1.mask_.enabled = true
				arg_244_1.mask_.raycastTarget = true

				arg_244_1:SetGaussion(false)
			end

			local var_247_17 = 0.733333333333333

			if var_247_16 <= arg_244_1.time_ and arg_244_1.time_ < var_247_16 + var_247_17 then
				local var_247_18 = (arg_244_1.time_ - var_247_16) / var_247_17
				local var_247_19 = Color.New(1, 1, 1)

				var_247_19.a = Mathf.Lerp(0, 1, var_247_18)
				arg_244_1.mask_.color = var_247_19
			end

			if arg_244_1.time_ >= var_247_16 + var_247_17 and arg_244_1.time_ < var_247_16 + var_247_17 + arg_247_0 then
				local var_247_20 = Color.New(1, 1, 1)

				var_247_20.a = 1
				arg_244_1.mask_.color = var_247_20
			end

			local var_247_21 = 0.733333333333333

			if var_247_21 < arg_244_1.time_ and arg_244_1.time_ <= var_247_21 + arg_247_0 then
				arg_244_1.mask_.enabled = true
				arg_244_1.mask_.raycastTarget = true

				arg_244_1:SetGaussion(false)
			end

			local var_247_22 = 0.8

			if var_247_21 <= arg_244_1.time_ and arg_244_1.time_ < var_247_21 + var_247_22 then
				local var_247_23 = (arg_244_1.time_ - var_247_21) / var_247_22
				local var_247_24 = Color.New(1, 1, 1)

				var_247_24.a = Mathf.Lerp(1, 0, var_247_23)
				arg_244_1.mask_.color = var_247_24
			end

			if arg_244_1.time_ >= var_247_21 + var_247_22 and arg_244_1.time_ < var_247_21 + var_247_22 + arg_247_0 then
				local var_247_25 = Color.New(1, 1, 1)
				local var_247_26 = 0

				arg_244_1.mask_.enabled = false
				var_247_25.a = var_247_26
				arg_244_1.mask_.color = var_247_25
			end

			local var_247_27 = manager.ui.mainCamera.transform
			local var_247_28 = 1.06666666666667

			if var_247_28 < arg_244_1.time_ and arg_244_1.time_ <= var_247_28 + arg_247_0 then
				arg_244_1.var_.shakeOldPos = var_247_27.localPosition
			end

			local var_247_29 = 0.6

			if var_247_28 <= arg_244_1.time_ and arg_244_1.time_ < var_247_28 + var_247_29 then
				local var_247_30 = (arg_244_1.time_ - var_247_28) / 0.066
				local var_247_31, var_247_32 = math.modf(var_247_30)

				var_247_27.localPosition = Vector3.New(var_247_32 * 0.13, var_247_32 * 0.13, var_247_32 * 0.13) + arg_244_1.var_.shakeOldPos
			end

			if arg_244_1.time_ >= var_247_28 + var_247_29 and arg_244_1.time_ < var_247_28 + var_247_29 + arg_247_0 then
				var_247_27.localPosition = arg_244_1.var_.shakeOldPos
			end

			local var_247_33 = 1.33333333333333

			if var_247_33 < arg_244_1.time_ and arg_244_1.time_ <= var_247_33 + arg_247_0 then
				arg_244_1.allBtn_.enabled = false
			end

			local var_247_34 = 0.333333333333333

			if arg_244_1.time_ >= var_247_33 + var_247_34 and arg_244_1.time_ < var_247_33 + var_247_34 + arg_247_0 then
				arg_244_1.allBtn_.enabled = true
			end

			local var_247_35 = arg_244_1.bgs_.SS1303.transform
			local var_247_36 = 0.733333333333333

			if var_247_36 < arg_244_1.time_ and arg_244_1.time_ <= var_247_36 + arg_247_0 then
				arg_244_1.var_.moveOldPosSS1303 = var_247_35.localPosition
			end

			local var_247_37 = 0.001

			if var_247_36 <= arg_244_1.time_ and arg_244_1.time_ < var_247_36 + var_247_37 then
				local var_247_38 = (arg_244_1.time_ - var_247_36) / var_247_37
				local var_247_39 = Vector3.New(0, 1, 10)

				var_247_35.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPosSS1303, var_247_39, var_247_38)
			end

			if arg_244_1.time_ >= var_247_36 + var_247_37 and arg_244_1.time_ < var_247_36 + var_247_37 + arg_247_0 then
				var_247_35.localPosition = Vector3.New(0, 1, 10)
			end

			local var_247_40 = arg_244_1.bgs_.SS1303.transform
			local var_247_41 = 0.75

			if var_247_41 < arg_244_1.time_ and arg_244_1.time_ <= var_247_41 + arg_247_0 then
				arg_244_1.var_.moveOldPosSS1303 = var_247_40.localPosition
			end

			local var_247_42 = 1.93333333333333

			if var_247_41 <= arg_244_1.time_ and arg_244_1.time_ < var_247_41 + var_247_42 then
				local var_247_43 = (arg_244_1.time_ - var_247_41) / var_247_42
				local var_247_44 = Vector3.New(0, 1, 8.6)

				var_247_40.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPosSS1303, var_247_44, var_247_43)
			end

			if arg_244_1.time_ >= var_247_41 + var_247_42 and arg_244_1.time_ < var_247_41 + var_247_42 + arg_247_0 then
				var_247_40.localPosition = Vector3.New(0, 1, 8.6)
			end

			local var_247_45 = manager.ui.mainCamera.transform
			local var_247_46 = 0.733333333333333

			if var_247_46 < arg_244_1.time_ and arg_244_1.time_ <= var_247_46 + arg_247_0 then
				local var_247_47 = arg_244_1.var_.effect破坏1
				local var_247_48
				local var_247_49 = var_247_45

				if not var_247_47 then
					var_247_47 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_247_49)
					var_247_47.name = "破坏1"
					arg_244_1.var_.effect破坏1 = var_247_47
				else
					var_247_47.transform:SetParent(var_247_49)
				end

				var_247_47.transform.localPosition = Vector3.New(0, 0, 0)
				var_247_47.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_247_50 = 0.3
			local var_247_51 = 1

			if var_247_50 < arg_244_1.time_ and arg_244_1.time_ <= var_247_50 + arg_247_0 then
				local var_247_52 = "play"
				local var_247_53 = "effect"

				arg_244_1:AudioAction(var_247_52, var_247_53, "se_story_130", "se_story_130_shot2", "")
			end

			if arg_244_1.frameCnt_ <= 1 then
				arg_244_1.dialog_:SetActive(false)
			end

			local var_247_54 = 2.16666666666667
			local var_247_55 = 1.275

			if var_247_54 < arg_244_1.time_ and arg_244_1.time_ <= var_247_54 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0

				arg_244_1.dialog_:SetActive(true)

				arg_244_1.dialogCg_.alpha = 0

				local var_247_56 = LeanTween.value(arg_244_1.dialog_, 0, 1, 0.3)

				var_247_56:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_244_1.dialogCg_.alpha = arg_248_0
				end))
				var_247_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_244_1.dialog_)
					var_247_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_244_1.duration_ = arg_244_1.duration_ + 0.3

				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_57 = arg_244_1:GetWordFromCfg(413042059)
				local var_247_58 = arg_244_1:FormatText(var_247_57.content)

				arg_244_1.text_.text = var_247_58

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_59 = 51
				local var_247_60 = utf8.len(var_247_58)
				local var_247_61 = var_247_59 <= 0 and var_247_55 or var_247_55 * (var_247_60 / var_247_59)

				if var_247_61 > 0 and var_247_55 < var_247_61 then
					arg_244_1.talkMaxDuration = var_247_61
					var_247_54 = var_247_54 + 0.3

					if var_247_61 + var_247_54 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_61 + var_247_54
					end
				end

				arg_244_1.text_.text = var_247_58
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_62 = var_247_54 + 0.3
			local var_247_63 = math.max(var_247_55, arg_244_1.talkMaxDuration)

			if var_247_62 <= arg_244_1.time_ and arg_244_1.time_ < var_247_62 + var_247_63 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_62) / var_247_63

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_62 + var_247_63 and arg_244_1.time_ < var_247_62 + var_247_63 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1303",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.733333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1303",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.93333333333333,
				className = "StoryMoveNode",
				startTime = 0.75,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play413042060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 413042060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play413042061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.9

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_2 = arg_250_1:GetWordFromCfg(413042060)
				local var_253_3 = arg_250_1:FormatText(var_253_2.content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 36
				local var_253_5 = utf8.len(var_253_3)
				local var_253_6 = var_253_4 <= 0 and var_253_1 or var_253_1 * (var_253_5 / var_253_4)

				if var_253_6 > 0 and var_253_1 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_7 and arg_250_1.time_ < var_253_0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play413042061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 413042061
		arg_254_1.duration_ = 4.77

		local var_254_0 = {
			zh = 3.8,
			ja = 4.766
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play413042062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 0.4

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_2 = arg_254_1:FormatText(StoryNameCfg[614].name)

				arg_254_1.leftNameTxt_.text = var_257_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:GetWordFromCfg(413042061)
				local var_257_4 = arg_254_1:FormatText(var_257_3.content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 16
				local var_257_6 = utf8.len(var_257_4)
				local var_257_7 = var_257_5 <= 0 and var_257_1 or var_257_1 * (var_257_6 / var_257_5)

				if var_257_7 > 0 and var_257_1 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_4
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042061", "story_v_out_413042.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042061", "story_v_out_413042.awb") / 1000

					if var_257_8 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_0
					end

					if var_257_3.prefab_name ~= "" and arg_254_1.actors_[var_257_3.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_3.prefab_name].transform, "story_v_out_413042", "413042061", "story_v_out_413042.awb")

						arg_254_1:RecordAudio("413042061", var_257_9)
						arg_254_1:RecordAudio("413042061", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_413042", "413042061", "story_v_out_413042.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_413042", "413042061", "story_v_out_413042.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_10 and arg_254_1.time_ < var_257_0 + var_257_10 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play413042062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 413042062
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play413042063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 1

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_2 = arg_258_1:GetWordFromCfg(413042062)
				local var_261_3 = arg_258_1:FormatText(var_261_2.content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 40
				local var_261_5 = utf8.len(var_261_3)
				local var_261_6 = var_261_4 <= 0 and var_261_1 or var_261_1 * (var_261_5 / var_261_4)

				if var_261_6 > 0 and var_261_1 < var_261_6 then
					arg_258_1.talkMaxDuration = var_261_6

					if var_261_6 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_6 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_3
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_7 and arg_258_1.time_ < var_261_0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play413042063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 413042063
		arg_262_1.duration_ = 5.8

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play413042064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = manager.ui.mainCamera.transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				local var_265_2 = arg_262_1.var_.effect破坏1

				if var_265_2 then
					Object.Destroy(var_265_2)

					arg_262_1.var_.effect破坏1 = nil
				end
			end

			local var_265_3 = manager.ui.mainCamera.transform
			local var_265_4 = 0

			if var_265_4 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1.var_.shakeOldPos = var_265_3.localPosition
			end

			local var_265_5 = 0.599676461021105

			if var_265_4 <= arg_262_1.time_ and arg_262_1.time_ < var_265_4 + var_265_5 then
				local var_265_6 = (arg_262_1.time_ - var_265_4) / 0.066
				local var_265_7, var_265_8 = math.modf(var_265_6)

				var_265_3.localPosition = Vector3.New(var_265_8 * 0.13, var_265_8 * 0.13, var_265_8 * 0.13) + arg_262_1.var_.shakeOldPos
			end

			if arg_262_1.time_ >= var_265_4 + var_265_5 and arg_262_1.time_ < var_265_4 + var_265_5 + arg_265_0 then
				var_265_3.localPosition = arg_262_1.var_.shakeOldPos
			end

			local var_265_9 = manager.ui.mainCamera.transform
			local var_265_10 = 0.8

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1.var_.shakeOldPos = var_265_9.localPosition
			end

			local var_265_11 = 0.2

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_11 then
				local var_265_12 = (arg_262_1.time_ - var_265_10) / 0.099
				local var_265_13, var_265_14 = math.modf(var_265_12)

				var_265_9.localPosition = Vector3.New(var_265_14 * 0.13, var_265_14 * 0.13, var_265_14 * 0.13) + arg_262_1.var_.shakeOldPos
			end

			if arg_262_1.time_ >= var_265_10 + var_265_11 and arg_262_1.time_ < var_265_10 + var_265_11 + arg_265_0 then
				var_265_9.localPosition = arg_262_1.var_.shakeOldPos
			end

			local var_265_15 = manager.ui.mainCamera.transform
			local var_265_16 = 1.175

			if var_265_16 < arg_262_1.time_ and arg_262_1.time_ <= var_265_16 + arg_265_0 then
				arg_262_1.var_.shakeOldPos = var_265_15.localPosition
			end

			local var_265_17 = 0.5

			if var_265_16 <= arg_262_1.time_ and arg_262_1.time_ < var_265_16 + var_265_17 then
				local var_265_18 = (arg_262_1.time_ - var_265_16) / 0.066
				local var_265_19, var_265_20 = math.modf(var_265_18)

				var_265_15.localPosition = Vector3.New(var_265_20 * 0.13, var_265_20 * 0.13, var_265_20 * 0.13) + arg_262_1.var_.shakeOldPos
			end

			if arg_262_1.time_ >= var_265_16 + var_265_17 and arg_262_1.time_ < var_265_16 + var_265_17 + arg_265_0 then
				var_265_15.localPosition = arg_262_1.var_.shakeOldPos
			end

			local var_265_21 = 0

			if var_265_21 < arg_262_1.time_ and arg_262_1.time_ <= var_265_21 + arg_265_0 then
				arg_262_1.allBtn_.enabled = false
			end

			local var_265_22 = 1.675

			if arg_262_1.time_ >= var_265_21 + var_265_22 and arg_262_1.time_ < var_265_21 + var_265_22 + arg_265_0 then
				arg_262_1.allBtn_.enabled = true
			end

			if arg_262_1.frameCnt_ <= 1 then
				arg_262_1.dialog_:SetActive(false)
			end

			local var_265_23 = 0.8
			local var_265_24 = 1.175

			if var_265_23 < arg_262_1.time_ and arg_262_1.time_ <= var_265_23 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0

				arg_262_1.dialog_:SetActive(true)

				arg_262_1.dialogCg_.alpha = 0

				local var_265_25 = LeanTween.value(arg_262_1.dialog_, 0, 1, 0.3)

				var_265_25:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_262_1.dialogCg_.alpha = arg_266_0
				end))
				var_265_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_262_1.dialog_)
					var_265_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_262_1.duration_ = arg_262_1.duration_ + 0.3

				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_26 = arg_262_1:GetWordFromCfg(413042063)
				local var_265_27 = arg_262_1:FormatText(var_265_26.content)

				arg_262_1.text_.text = var_265_27

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_28 = 47
				local var_265_29 = utf8.len(var_265_27)
				local var_265_30 = var_265_28 <= 0 and var_265_24 or var_265_24 * (var_265_29 / var_265_28)

				if var_265_30 > 0 and var_265_24 < var_265_30 then
					arg_262_1.talkMaxDuration = var_265_30
					var_265_23 = var_265_23 + 0.3

					if var_265_30 + var_265_23 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_30 + var_265_23
					end
				end

				arg_262_1.text_.text = var_265_27
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_31 = var_265_23 + 0.3
			local var_265_32 = math.max(var_265_24, arg_262_1.talkMaxDuration)

			if var_265_31 <= arg_262_1.time_ and arg_262_1.time_ < var_265_31 + var_265_32 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_31) / var_265_32

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_31 + var_265_32 and arg_262_1.time_ < var_265_31 + var_265_32 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play413042064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 413042064
		arg_268_1.duration_ = 3.6

		local var_268_0 = {
			zh = 3.6,
			ja = 2.566
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play413042065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 0.425

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_2 = arg_268_1:FormatText(StoryNameCfg[614].name)

				arg_268_1.leftNameTxt_.text = var_271_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_3 = arg_268_1:GetWordFromCfg(413042064)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 17
				local var_271_6 = utf8.len(var_271_4)
				local var_271_7 = var_271_5 <= 0 and var_271_1 or var_271_1 * (var_271_6 / var_271_5)

				if var_271_7 > 0 and var_271_1 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042064", "story_v_out_413042.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042064", "story_v_out_413042.awb") / 1000

					if var_271_8 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_0
					end

					if var_271_3.prefab_name ~= "" and arg_268_1.actors_[var_271_3.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_3.prefab_name].transform, "story_v_out_413042", "413042064", "story_v_out_413042.awb")

						arg_268_1:RecordAudio("413042064", var_271_9)
						arg_268_1:RecordAudio("413042064", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_413042", "413042064", "story_v_out_413042.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_413042", "413042064", "story_v_out_413042.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_10 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_10 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_10

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_10 and arg_268_1.time_ < var_271_0 + var_271_10 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play413042065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 413042065
		arg_272_1.duration_ = 5.43

		local var_272_0 = {
			zh = 5.433,
			ja = 2.066
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play413042066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.275

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[614].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_3 = arg_272_1:GetWordFromCfg(413042065)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 11
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042065", "story_v_out_413042.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042065", "story_v_out_413042.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_413042", "413042065", "story_v_out_413042.awb")

						arg_272_1:RecordAudio("413042065", var_275_9)
						arg_272_1:RecordAudio("413042065", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_413042", "413042065", "story_v_out_413042.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_413042", "413042065", "story_v_out_413042.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_10 and arg_272_1.time_ < var_275_0 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play413042066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 413042066
		arg_276_1.duration_ = 4.27

		local var_276_0 = {
			zh = 3.7,
			ja = 4.267
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play413042067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				local var_279_1 = manager.ui.mainCamera.transform.localPosition
				local var_279_2 = Vector3.New(0, 0, 10) + Vector3.New(var_279_1.x, var_279_1.y, 0)
				local var_279_3 = arg_276_1.bgs_.F10f

				var_279_3.transform.localPosition = var_279_2
				var_279_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_279_4 = var_279_3:GetComponent("SpriteRenderer")

				if var_279_4 and var_279_4.sprite then
					local var_279_5 = (var_279_3.transform.localPosition - var_279_1).z
					local var_279_6 = manager.ui.mainCameraCom_
					local var_279_7 = 2 * var_279_5 * Mathf.Tan(var_279_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_279_8 = var_279_7 * var_279_6.aspect
					local var_279_9 = var_279_4.sprite.bounds.size.x
					local var_279_10 = var_279_4.sprite.bounds.size.y
					local var_279_11 = var_279_8 / var_279_9
					local var_279_12 = var_279_7 / var_279_10
					local var_279_13 = var_279_12 < var_279_11 and var_279_11 or var_279_12

					var_279_3.transform.localScale = Vector3.New(var_279_13, var_279_13, 0)
				end

				for iter_279_0, iter_279_1 in pairs(arg_276_1.bgs_) do
					if iter_279_0 ~= "F10f" then
						iter_279_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_279_14 = 0.834

			if var_279_14 < arg_276_1.time_ and arg_276_1.time_ <= var_279_14 + arg_279_0 then
				arg_276_1.allBtn_.enabled = false
			end

			local var_279_15 = 0.3

			if arg_276_1.time_ >= var_279_14 + var_279_15 and arg_276_1.time_ < var_279_14 + var_279_15 + arg_279_0 then
				arg_276_1.allBtn_.enabled = true
			end

			local var_279_16 = 0

			if var_279_16 < arg_276_1.time_ and arg_276_1.time_ <= var_279_16 + arg_279_0 then
				arg_276_1.mask_.enabled = true
				arg_276_1.mask_.raycastTarget = true

				arg_276_1:SetGaussion(false)
			end

			local var_279_17 = 2

			if var_279_16 <= arg_276_1.time_ and arg_276_1.time_ < var_279_16 + var_279_17 then
				local var_279_18 = (arg_276_1.time_ - var_279_16) / var_279_17
				local var_279_19 = Color.New(0, 0, 0)

				var_279_19.a = Mathf.Lerp(1, 0, var_279_18)
				arg_276_1.mask_.color = var_279_19
			end

			if arg_276_1.time_ >= var_279_16 + var_279_17 and arg_276_1.time_ < var_279_16 + var_279_17 + arg_279_0 then
				local var_279_20 = Color.New(0, 0, 0)
				local var_279_21 = 0

				arg_276_1.mask_.enabled = false
				var_279_20.a = var_279_21
				arg_276_1.mask_.color = var_279_20
			end

			local var_279_22 = arg_276_1.actors_["10022"].transform
			local var_279_23 = 0

			if var_279_23 < arg_276_1.time_ and arg_276_1.time_ <= var_279_23 + arg_279_0 then
				arg_276_1.var_.moveOldPos10022 = var_279_22.localPosition
				var_279_22.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10022", 7)

				local var_279_24 = var_279_22.childCount

				for iter_279_2 = 0, var_279_24 - 1 do
					local var_279_25 = var_279_22:GetChild(iter_279_2)

					if var_279_25.name == "" or not string.find(var_279_25.name, "split") then
						var_279_25.gameObject:SetActive(true)
					else
						var_279_25.gameObject:SetActive(false)
					end
				end
			end

			local var_279_26 = 0.001

			if var_279_23 <= arg_276_1.time_ and arg_276_1.time_ < var_279_23 + var_279_26 then
				local var_279_27 = (arg_276_1.time_ - var_279_23) / var_279_26
				local var_279_28 = Vector3.New(0, -2000, -180)

				var_279_22.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10022, var_279_28, var_279_27)
			end

			if arg_276_1.time_ >= var_279_23 + var_279_26 and arg_276_1.time_ < var_279_23 + var_279_26 + arg_279_0 then
				var_279_22.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_279_29 = arg_276_1.actors_["10092"].transform
			local var_279_30 = 0.8

			if var_279_30 < arg_276_1.time_ and arg_276_1.time_ <= var_279_30 + arg_279_0 then
				arg_276_1.var_.moveOldPos10092 = var_279_29.localPosition
				var_279_29.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10092", 3)

				local var_279_31 = var_279_29.childCount

				for iter_279_3 = 0, var_279_31 - 1 do
					local var_279_32 = var_279_29:GetChild(iter_279_3)

					if var_279_32.name == "split_2" or not string.find(var_279_32.name, "split") then
						var_279_32.gameObject:SetActive(true)
					else
						var_279_32.gameObject:SetActive(false)
					end
				end
			end

			local var_279_33 = 0.001

			if var_279_30 <= arg_276_1.time_ and arg_276_1.time_ < var_279_30 + var_279_33 then
				local var_279_34 = (arg_276_1.time_ - var_279_30) / var_279_33
				local var_279_35 = Vector3.New(0, -300, -295)

				var_279_29.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10092, var_279_35, var_279_34)
			end

			if arg_276_1.time_ >= var_279_30 + var_279_33 and arg_276_1.time_ < var_279_30 + var_279_33 + arg_279_0 then
				var_279_29.localPosition = Vector3.New(0, -300, -295)
			end

			local var_279_36 = arg_276_1.actors_["10022"]
			local var_279_37 = 0

			if var_279_37 < arg_276_1.time_ and arg_276_1.time_ <= var_279_37 + arg_279_0 and not isNil(var_279_36) and arg_276_1.var_.actorSpriteComps10022 == nil then
				arg_276_1.var_.actorSpriteComps10022 = var_279_36:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_38 = 0.034

			if var_279_37 <= arg_276_1.time_ and arg_276_1.time_ < var_279_37 + var_279_38 and not isNil(var_279_36) then
				local var_279_39 = (arg_276_1.time_ - var_279_37) / var_279_38

				if arg_276_1.var_.actorSpriteComps10022 then
					for iter_279_4, iter_279_5 in pairs(arg_276_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_279_5 then
							if arg_276_1.isInRecall_ then
								local var_279_40 = Mathf.Lerp(iter_279_5.color.r, arg_276_1.hightColor2.r, var_279_39)
								local var_279_41 = Mathf.Lerp(iter_279_5.color.g, arg_276_1.hightColor2.g, var_279_39)
								local var_279_42 = Mathf.Lerp(iter_279_5.color.b, arg_276_1.hightColor2.b, var_279_39)

								iter_279_5.color = Color.New(var_279_40, var_279_41, var_279_42)
							else
								local var_279_43 = Mathf.Lerp(iter_279_5.color.r, 0.5, var_279_39)

								iter_279_5.color = Color.New(var_279_43, var_279_43, var_279_43)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= var_279_37 + var_279_38 and arg_276_1.time_ < var_279_37 + var_279_38 + arg_279_0 and not isNil(var_279_36) and arg_276_1.var_.actorSpriteComps10022 then
				for iter_279_6, iter_279_7 in pairs(arg_276_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_279_7 then
						if arg_276_1.isInRecall_ then
							iter_279_7.color = arg_276_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_279_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_276_1.var_.actorSpriteComps10022 = nil
			end

			local var_279_44 = arg_276_1.actors_["10092"]
			local var_279_45 = 0.8

			if var_279_45 < arg_276_1.time_ and arg_276_1.time_ <= var_279_45 + arg_279_0 and not isNil(var_279_44) and arg_276_1.var_.actorSpriteComps10092 == nil then
				arg_276_1.var_.actorSpriteComps10092 = var_279_44:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_46 = 0.2

			if var_279_45 <= arg_276_1.time_ and arg_276_1.time_ < var_279_45 + var_279_46 and not isNil(var_279_44) then
				local var_279_47 = (arg_276_1.time_ - var_279_45) / var_279_46

				if arg_276_1.var_.actorSpriteComps10092 then
					for iter_279_8, iter_279_9 in pairs(arg_276_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_279_9 then
							if arg_276_1.isInRecall_ then
								local var_279_48 = Mathf.Lerp(iter_279_9.color.r, arg_276_1.hightColor1.r, var_279_47)
								local var_279_49 = Mathf.Lerp(iter_279_9.color.g, arg_276_1.hightColor1.g, var_279_47)
								local var_279_50 = Mathf.Lerp(iter_279_9.color.b, arg_276_1.hightColor1.b, var_279_47)

								iter_279_9.color = Color.New(var_279_48, var_279_49, var_279_50)
							else
								local var_279_51 = Mathf.Lerp(iter_279_9.color.r, 1, var_279_47)

								iter_279_9.color = Color.New(var_279_51, var_279_51, var_279_51)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= var_279_45 + var_279_46 and arg_276_1.time_ < var_279_45 + var_279_46 + arg_279_0 and not isNil(var_279_44) and arg_276_1.var_.actorSpriteComps10092 then
				for iter_279_10, iter_279_11 in pairs(arg_276_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_279_11 then
						if arg_276_1.isInRecall_ then
							iter_279_11.color = arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_279_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_276_1.var_.actorSpriteComps10092 = nil
			end

			local var_279_52 = 0

			if var_279_52 < arg_276_1.time_ and arg_276_1.time_ <= var_279_52 + arg_279_0 then
				arg_276_1.mask_.enabled = true
				arg_276_1.mask_.raycastTarget = false

				arg_276_1:SetGaussion(false)
			end

			local var_279_53 = 1

			if var_279_52 <= arg_276_1.time_ and arg_276_1.time_ < var_279_52 + var_279_53 then
				local var_279_54 = (arg_276_1.time_ - var_279_52) / var_279_53
				local var_279_55 = Color.New(1, 1, 1)

				var_279_55.a = Mathf.Lerp(1, 0, var_279_54)
				arg_276_1.mask_.color = var_279_55
			end

			if arg_276_1.time_ >= var_279_52 + var_279_53 and arg_276_1.time_ < var_279_52 + var_279_53 + arg_279_0 then
				local var_279_56 = Color.New(1, 1, 1)
				local var_279_57 = 0

				arg_276_1.mask_.enabled = false
				var_279_56.a = var_279_57
				arg_276_1.mask_.color = var_279_56
			end

			local var_279_58 = arg_276_1.actors_["10092"]
			local var_279_59 = 0.8

			if var_279_59 < arg_276_1.time_ and arg_276_1.time_ <= var_279_59 + arg_279_0 then
				local var_279_60 = var_279_58:GetComponentInChildren(typeof(CanvasGroup))

				if var_279_60 then
					arg_276_1.var_.alphaOldValue10092 = var_279_60.alpha
					arg_276_1.var_.characterEffect10092 = var_279_60
				end

				arg_276_1.var_.alphaOldValue10092 = 0
			end

			local var_279_61 = 0.2

			if var_279_59 <= arg_276_1.time_ and arg_276_1.time_ < var_279_59 + var_279_61 then
				local var_279_62 = (arg_276_1.time_ - var_279_59) / var_279_61
				local var_279_63 = Mathf.Lerp(arg_276_1.var_.alphaOldValue10092, 1, var_279_62)

				if arg_276_1.var_.characterEffect10092 then
					arg_276_1.var_.characterEffect10092.alpha = var_279_63
				end
			end

			if arg_276_1.time_ >= var_279_59 + var_279_61 and arg_276_1.time_ < var_279_59 + var_279_61 + arg_279_0 and arg_276_1.var_.characterEffect10092 then
				arg_276_1.var_.characterEffect10092.alpha = 1
			end

			if arg_276_1.frameCnt_ <= 1 then
				arg_276_1.dialog_:SetActive(false)
			end

			local var_279_64 = 0.834
			local var_279_65 = 0.375

			if var_279_64 < arg_276_1.time_ and arg_276_1.time_ <= var_279_64 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0

				arg_276_1.dialog_:SetActive(true)

				arg_276_1.dialogCg_.alpha = 0

				local var_279_66 = LeanTween.value(arg_276_1.dialog_, 0, 1, 0.3)

				var_279_66:setOnUpdate(LuaHelper.FloatAction(function(arg_280_0)
					arg_276_1.dialogCg_.alpha = arg_280_0
				end))
				var_279_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_276_1.dialog_)
					var_279_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_276_1.duration_ = arg_276_1.duration_ + 0.3

				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_67 = arg_276_1:FormatText(StoryNameCfg[996].name)

				arg_276_1.leftNameTxt_.text = var_279_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_68 = arg_276_1:GetWordFromCfg(413042066)
				local var_279_69 = arg_276_1:FormatText(var_279_68.content)

				arg_276_1.text_.text = var_279_69

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_70 = 15
				local var_279_71 = utf8.len(var_279_69)
				local var_279_72 = var_279_70 <= 0 and var_279_65 or var_279_65 * (var_279_71 / var_279_70)

				if var_279_72 > 0 and var_279_65 < var_279_72 then
					arg_276_1.talkMaxDuration = var_279_72
					var_279_64 = var_279_64 + 0.3

					if var_279_72 + var_279_64 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_72 + var_279_64
					end
				end

				arg_276_1.text_.text = var_279_69
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042066", "story_v_out_413042.awb") ~= 0 then
					local var_279_73 = manager.audio:GetVoiceLength("story_v_out_413042", "413042066", "story_v_out_413042.awb") / 1000

					if var_279_73 + var_279_64 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_73 + var_279_64
					end

					if var_279_68.prefab_name ~= "" and arg_276_1.actors_[var_279_68.prefab_name] ~= nil then
						local var_279_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_68.prefab_name].transform, "story_v_out_413042", "413042066", "story_v_out_413042.awb")

						arg_276_1:RecordAudio("413042066", var_279_74)
						arg_276_1:RecordAudio("413042066", var_279_74)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_413042", "413042066", "story_v_out_413042.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_413042", "413042066", "story_v_out_413042.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_75 = var_279_64 + 0.3
			local var_279_76 = math.max(var_279_65, arg_276_1.talkMaxDuration)

			if var_279_75 <= arg_276_1.time_ and arg_276_1.time_ < var_279_75 + var_279_76 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_75) / var_279_76

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_75 + var_279_76 and arg_276_1.time_ < var_279_75 + var_279_76 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play413042067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 413042067
		arg_282_1.duration_ = 2.23

		local var_282_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_282_0:Play413042068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["10022"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos10022 = var_285_0.localPosition
				var_285_0.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("10022", 3)

				local var_285_2 = var_285_0.childCount

				for iter_285_0 = 0, var_285_2 - 1 do
					local var_285_3 = var_285_0:GetChild(iter_285_0)

					if var_285_3.name == "split_8" or not string.find(var_285_3.name, "split") then
						var_285_3.gameObject:SetActive(true)
					else
						var_285_3.gameObject:SetActive(false)
					end
				end
			end

			local var_285_4 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_4 then
				local var_285_5 = (arg_282_1.time_ - var_285_1) / var_285_4
				local var_285_6 = Vector3.New(0, -315, -320)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10022, var_285_6, var_285_5)
			end

			if arg_282_1.time_ >= var_285_1 + var_285_4 and arg_282_1.time_ < var_285_1 + var_285_4 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_285_7 = arg_282_1.actors_["10092"].transform
			local var_285_8 = 0

			if var_285_8 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				arg_282_1.var_.moveOldPos10092 = var_285_7.localPosition
				var_285_7.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("10092", 7)

				local var_285_9 = var_285_7.childCount

				for iter_285_1 = 0, var_285_9 - 1 do
					local var_285_10 = var_285_7:GetChild(iter_285_1)

					if var_285_10.name == "split_1_1" or not string.find(var_285_10.name, "split") then
						var_285_10.gameObject:SetActive(true)
					else
						var_285_10.gameObject:SetActive(false)
					end
				end
			end

			local var_285_11 = 0.001

			if var_285_8 <= arg_282_1.time_ and arg_282_1.time_ < var_285_8 + var_285_11 then
				local var_285_12 = (arg_282_1.time_ - var_285_8) / var_285_11
				local var_285_13 = Vector3.New(0, -2000, 0)

				var_285_7.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10092, var_285_13, var_285_12)
			end

			if arg_282_1.time_ >= var_285_8 + var_285_11 and arg_282_1.time_ < var_285_8 + var_285_11 + arg_285_0 then
				var_285_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_285_14 = arg_282_1.actors_["10022"]
			local var_285_15 = 0

			if var_285_15 < arg_282_1.time_ and arg_282_1.time_ <= var_285_15 + arg_285_0 and not isNil(var_285_14) and arg_282_1.var_.actorSpriteComps10022 == nil then
				arg_282_1.var_.actorSpriteComps10022 = var_285_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_16 = 2

			if var_285_15 <= arg_282_1.time_ and arg_282_1.time_ < var_285_15 + var_285_16 and not isNil(var_285_14) then
				local var_285_17 = (arg_282_1.time_ - var_285_15) / var_285_16

				if arg_282_1.var_.actorSpriteComps10022 then
					for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_285_3 then
							if arg_282_1.isInRecall_ then
								local var_285_18 = Mathf.Lerp(iter_285_3.color.r, arg_282_1.hightColor1.r, var_285_17)
								local var_285_19 = Mathf.Lerp(iter_285_3.color.g, arg_282_1.hightColor1.g, var_285_17)
								local var_285_20 = Mathf.Lerp(iter_285_3.color.b, arg_282_1.hightColor1.b, var_285_17)

								iter_285_3.color = Color.New(var_285_18, var_285_19, var_285_20)
							else
								local var_285_21 = Mathf.Lerp(iter_285_3.color.r, 1, var_285_17)

								iter_285_3.color = Color.New(var_285_21, var_285_21, var_285_21)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_15 + var_285_16 and arg_282_1.time_ < var_285_15 + var_285_16 + arg_285_0 and not isNil(var_285_14) and arg_282_1.var_.actorSpriteComps10022 then
				for iter_285_4, iter_285_5 in pairs(arg_282_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_285_5 then
						if arg_282_1.isInRecall_ then
							iter_285_5.color = arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_285_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps10022 = nil
			end

			local var_285_22 = arg_282_1.actors_["10092"]
			local var_285_23 = 0

			if var_285_23 < arg_282_1.time_ and arg_282_1.time_ <= var_285_23 + arg_285_0 and not isNil(var_285_22) and arg_282_1.var_.actorSpriteComps10092 == nil then
				arg_282_1.var_.actorSpriteComps10092 = var_285_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_24 = 2

			if var_285_23 <= arg_282_1.time_ and arg_282_1.time_ < var_285_23 + var_285_24 and not isNil(var_285_22) then
				local var_285_25 = (arg_282_1.time_ - var_285_23) / var_285_24

				if arg_282_1.var_.actorSpriteComps10092 then
					for iter_285_6, iter_285_7 in pairs(arg_282_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_285_7 then
							if arg_282_1.isInRecall_ then
								local var_285_26 = Mathf.Lerp(iter_285_7.color.r, arg_282_1.hightColor2.r, var_285_25)
								local var_285_27 = Mathf.Lerp(iter_285_7.color.g, arg_282_1.hightColor2.g, var_285_25)
								local var_285_28 = Mathf.Lerp(iter_285_7.color.b, arg_282_1.hightColor2.b, var_285_25)

								iter_285_7.color = Color.New(var_285_26, var_285_27, var_285_28)
							else
								local var_285_29 = Mathf.Lerp(iter_285_7.color.r, 0.5, var_285_25)

								iter_285_7.color = Color.New(var_285_29, var_285_29, var_285_29)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_23 + var_285_24 and arg_282_1.time_ < var_285_23 + var_285_24 + arg_285_0 and not isNil(var_285_22) and arg_282_1.var_.actorSpriteComps10092 then
				for iter_285_8, iter_285_9 in pairs(arg_282_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_285_9 then
						if arg_282_1.isInRecall_ then
							iter_285_9.color = arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_285_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps10092 = nil
			end

			local var_285_30 = 0
			local var_285_31 = 0.15

			if var_285_30 < arg_282_1.time_ and arg_282_1.time_ <= var_285_30 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_32 = arg_282_1:FormatText(StoryNameCfg[614].name)

				arg_282_1.leftNameTxt_.text = var_285_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_33 = arg_282_1:GetWordFromCfg(413042067)
				local var_285_34 = arg_282_1:FormatText(var_285_33.content)

				arg_282_1.text_.text = var_285_34

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_35 = 6
				local var_285_36 = utf8.len(var_285_34)
				local var_285_37 = var_285_35 <= 0 and var_285_31 or var_285_31 * (var_285_36 / var_285_35)

				if var_285_37 > 0 and var_285_31 < var_285_37 then
					arg_282_1.talkMaxDuration = var_285_37

					if var_285_37 + var_285_30 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_37 + var_285_30
					end
				end

				arg_282_1.text_.text = var_285_34
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042067", "story_v_out_413042.awb") ~= 0 then
					local var_285_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042067", "story_v_out_413042.awb") / 1000

					if var_285_38 + var_285_30 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_38 + var_285_30
					end

					if var_285_33.prefab_name ~= "" and arg_282_1.actors_[var_285_33.prefab_name] ~= nil then
						local var_285_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_33.prefab_name].transform, "story_v_out_413042", "413042067", "story_v_out_413042.awb")

						arg_282_1:RecordAudio("413042067", var_285_39)
						arg_282_1:RecordAudio("413042067", var_285_39)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_413042", "413042067", "story_v_out_413042.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_413042", "413042067", "story_v_out_413042.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_40 = math.max(var_285_31, arg_282_1.talkMaxDuration)

			if var_285_30 <= arg_282_1.time_ and arg_282_1.time_ < var_285_30 + var_285_40 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_30) / var_285_40

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_30 + var_285_40 and arg_282_1.time_ < var_285_30 + var_285_40 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play413042068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 413042068
		arg_286_1.duration_ = 4.2

		local var_286_0 = {
			zh = 3.6,
			ja = 4.2
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
				arg_286_0:Play413042069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["10022"].transform
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.var_.moveOldPos10022 = var_289_0.localPosition
				var_289_0.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("10022", 0)

				local var_289_2 = var_289_0.childCount

				for iter_289_0 = 0, var_289_2 - 1 do
					local var_289_3 = var_289_0:GetChild(iter_289_0)

					if var_289_3.name == "" or not string.find(var_289_3.name, "split") then
						var_289_3.gameObject:SetActive(true)
					else
						var_289_3.gameObject:SetActive(false)
					end
				end
			end

			local var_289_4 = 0.001

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_4 then
				local var_289_5 = (arg_286_1.time_ - var_289_1) / var_289_4
				local var_289_6 = Vector3.New(-1500, -350, -180)

				var_289_0.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10022, var_289_6, var_289_5)
			end

			if arg_286_1.time_ >= var_289_1 + var_289_4 and arg_286_1.time_ < var_289_1 + var_289_4 + arg_289_0 then
				var_289_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_289_7 = arg_286_1.actors_["10092"].transform
			local var_289_8 = 0

			if var_289_8 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 then
				arg_286_1.var_.moveOldPos10092 = var_289_7.localPosition
				var_289_7.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("10092", 3)

				local var_289_9 = var_289_7.childCount

				for iter_289_1 = 0, var_289_9 - 1 do
					local var_289_10 = var_289_7:GetChild(iter_289_1)

					if var_289_10.name == "" or not string.find(var_289_10.name, "split") then
						var_289_10.gameObject:SetActive(true)
					else
						var_289_10.gameObject:SetActive(false)
					end
				end
			end

			local var_289_11 = 0.001

			if var_289_8 <= arg_286_1.time_ and arg_286_1.time_ < var_289_8 + var_289_11 then
				local var_289_12 = (arg_286_1.time_ - var_289_8) / var_289_11
				local var_289_13 = Vector3.New(0, -300, -295)

				var_289_7.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10092, var_289_13, var_289_12)
			end

			if arg_286_1.time_ >= var_289_8 + var_289_11 and arg_286_1.time_ < var_289_8 + var_289_11 + arg_289_0 then
				var_289_7.localPosition = Vector3.New(0, -300, -295)
			end

			local var_289_14 = arg_286_1.actors_["10022"]
			local var_289_15 = 0

			if var_289_15 < arg_286_1.time_ and arg_286_1.time_ <= var_289_15 + arg_289_0 and not isNil(var_289_14) and arg_286_1.var_.actorSpriteComps10022 == nil then
				arg_286_1.var_.actorSpriteComps10022 = var_289_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_16 = 2

			if var_289_15 <= arg_286_1.time_ and arg_286_1.time_ < var_289_15 + var_289_16 and not isNil(var_289_14) then
				local var_289_17 = (arg_286_1.time_ - var_289_15) / var_289_16

				if arg_286_1.var_.actorSpriteComps10022 then
					for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_289_3 then
							if arg_286_1.isInRecall_ then
								local var_289_18 = Mathf.Lerp(iter_289_3.color.r, arg_286_1.hightColor2.r, var_289_17)
								local var_289_19 = Mathf.Lerp(iter_289_3.color.g, arg_286_1.hightColor2.g, var_289_17)
								local var_289_20 = Mathf.Lerp(iter_289_3.color.b, arg_286_1.hightColor2.b, var_289_17)

								iter_289_3.color = Color.New(var_289_18, var_289_19, var_289_20)
							else
								local var_289_21 = Mathf.Lerp(iter_289_3.color.r, 0.5, var_289_17)

								iter_289_3.color = Color.New(var_289_21, var_289_21, var_289_21)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_15 + var_289_16 and arg_286_1.time_ < var_289_15 + var_289_16 + arg_289_0 and not isNil(var_289_14) and arg_286_1.var_.actorSpriteComps10022 then
				for iter_289_4, iter_289_5 in pairs(arg_286_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_289_5 then
						if arg_286_1.isInRecall_ then
							iter_289_5.color = arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_289_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps10022 = nil
			end

			local var_289_22 = arg_286_1.actors_["10092"]
			local var_289_23 = 0

			if var_289_23 < arg_286_1.time_ and arg_286_1.time_ <= var_289_23 + arg_289_0 and not isNil(var_289_22) and arg_286_1.var_.actorSpriteComps10092 == nil then
				arg_286_1.var_.actorSpriteComps10092 = var_289_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_24 = 2

			if var_289_23 <= arg_286_1.time_ and arg_286_1.time_ < var_289_23 + var_289_24 and not isNil(var_289_22) then
				local var_289_25 = (arg_286_1.time_ - var_289_23) / var_289_24

				if arg_286_1.var_.actorSpriteComps10092 then
					for iter_289_6, iter_289_7 in pairs(arg_286_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_289_7 then
							if arg_286_1.isInRecall_ then
								local var_289_26 = Mathf.Lerp(iter_289_7.color.r, arg_286_1.hightColor1.r, var_289_25)
								local var_289_27 = Mathf.Lerp(iter_289_7.color.g, arg_286_1.hightColor1.g, var_289_25)
								local var_289_28 = Mathf.Lerp(iter_289_7.color.b, arg_286_1.hightColor1.b, var_289_25)

								iter_289_7.color = Color.New(var_289_26, var_289_27, var_289_28)
							else
								local var_289_29 = Mathf.Lerp(iter_289_7.color.r, 1, var_289_25)

								iter_289_7.color = Color.New(var_289_29, var_289_29, var_289_29)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_23 + var_289_24 and arg_286_1.time_ < var_289_23 + var_289_24 + arg_289_0 and not isNil(var_289_22) and arg_286_1.var_.actorSpriteComps10092 then
				for iter_289_8, iter_289_9 in pairs(arg_286_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_289_9 then
						if arg_286_1.isInRecall_ then
							iter_289_9.color = arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_289_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps10092 = nil
			end

			local var_289_30 = 0
			local var_289_31 = 0.375

			if var_289_30 < arg_286_1.time_ and arg_286_1.time_ <= var_289_30 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_32 = arg_286_1:FormatText(StoryNameCfg[996].name)

				arg_286_1.leftNameTxt_.text = var_289_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_33 = arg_286_1:GetWordFromCfg(413042068)
				local var_289_34 = arg_286_1:FormatText(var_289_33.content)

				arg_286_1.text_.text = var_289_34

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_35 = 15
				local var_289_36 = utf8.len(var_289_34)
				local var_289_37 = var_289_35 <= 0 and var_289_31 or var_289_31 * (var_289_36 / var_289_35)

				if var_289_37 > 0 and var_289_31 < var_289_37 then
					arg_286_1.talkMaxDuration = var_289_37

					if var_289_37 + var_289_30 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_37 + var_289_30
					end
				end

				arg_286_1.text_.text = var_289_34
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042068", "story_v_out_413042.awb") ~= 0 then
					local var_289_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042068", "story_v_out_413042.awb") / 1000

					if var_289_38 + var_289_30 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_38 + var_289_30
					end

					if var_289_33.prefab_name ~= "" and arg_286_1.actors_[var_289_33.prefab_name] ~= nil then
						local var_289_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_33.prefab_name].transform, "story_v_out_413042", "413042068", "story_v_out_413042.awb")

						arg_286_1:RecordAudio("413042068", var_289_39)
						arg_286_1:RecordAudio("413042068", var_289_39)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_413042", "413042068", "story_v_out_413042.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_413042", "413042068", "story_v_out_413042.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_40 = math.max(var_289_31, arg_286_1.talkMaxDuration)

			if var_289_30 <= arg_286_1.time_ and arg_286_1.time_ < var_289_30 + var_289_40 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_30) / var_289_40

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_30 + var_289_40 and arg_286_1.time_ < var_289_30 + var_289_40 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play413042069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 413042069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play413042070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["10092"].transform
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.var_.moveOldPos10092 = var_293_0.localPosition
				var_293_0.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("10092", 7)

				local var_293_2 = var_293_0.childCount

				for iter_293_0 = 0, var_293_2 - 1 do
					local var_293_3 = var_293_0:GetChild(iter_293_0)

					if var_293_3.name == "" or not string.find(var_293_3.name, "split") then
						var_293_3.gameObject:SetActive(true)
					else
						var_293_3.gameObject:SetActive(false)
					end
				end
			end

			local var_293_4 = 0.001

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_4 then
				local var_293_5 = (arg_290_1.time_ - var_293_1) / var_293_4
				local var_293_6 = Vector3.New(0, -2000, 0)

				var_293_0.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos10092, var_293_6, var_293_5)
			end

			if arg_290_1.time_ >= var_293_1 + var_293_4 and arg_290_1.time_ < var_293_1 + var_293_4 + arg_293_0 then
				var_293_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_293_7 = arg_290_1.actors_["10092"]
			local var_293_8 = 0

			if var_293_8 < arg_290_1.time_ and arg_290_1.time_ <= var_293_8 + arg_293_0 and not isNil(var_293_7) and arg_290_1.var_.actorSpriteComps10092 == nil then
				arg_290_1.var_.actorSpriteComps10092 = var_293_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_9 = 2

			if var_293_8 <= arg_290_1.time_ and arg_290_1.time_ < var_293_8 + var_293_9 and not isNil(var_293_7) then
				local var_293_10 = (arg_290_1.time_ - var_293_8) / var_293_9

				if arg_290_1.var_.actorSpriteComps10092 then
					for iter_293_1, iter_293_2 in pairs(arg_290_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_293_2 then
							if arg_290_1.isInRecall_ then
								local var_293_11 = Mathf.Lerp(iter_293_2.color.r, arg_290_1.hightColor2.r, var_293_10)
								local var_293_12 = Mathf.Lerp(iter_293_2.color.g, arg_290_1.hightColor2.g, var_293_10)
								local var_293_13 = Mathf.Lerp(iter_293_2.color.b, arg_290_1.hightColor2.b, var_293_10)

								iter_293_2.color = Color.New(var_293_11, var_293_12, var_293_13)
							else
								local var_293_14 = Mathf.Lerp(iter_293_2.color.r, 0.5, var_293_10)

								iter_293_2.color = Color.New(var_293_14, var_293_14, var_293_14)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= var_293_8 + var_293_9 and arg_290_1.time_ < var_293_8 + var_293_9 + arg_293_0 and not isNil(var_293_7) and arg_290_1.var_.actorSpriteComps10092 then
				for iter_293_3, iter_293_4 in pairs(arg_290_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_293_4 then
						if arg_290_1.isInRecall_ then
							iter_293_4.color = arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_293_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_290_1.var_.actorSpriteComps10092 = nil
			end

			local var_293_15 = manager.ui.mainCamera.transform
			local var_293_16 = 0

			if var_293_16 < arg_290_1.time_ and arg_290_1.time_ <= var_293_16 + arg_293_0 then
				arg_290_1.var_.shakeOldPos = var_293_15.localPosition
			end

			local var_293_17 = 0.6

			if var_293_16 <= arg_290_1.time_ and arg_290_1.time_ < var_293_16 + var_293_17 then
				local var_293_18 = (arg_290_1.time_ - var_293_16) / 0.066
				local var_293_19, var_293_20 = math.modf(var_293_18)

				var_293_15.localPosition = Vector3.New(var_293_20 * 0.13, var_293_20 * 0.13, var_293_20 * 0.13) + arg_290_1.var_.shakeOldPos
			end

			if arg_290_1.time_ >= var_293_16 + var_293_17 and arg_290_1.time_ < var_293_16 + var_293_17 + arg_293_0 then
				var_293_15.localPosition = arg_290_1.var_.shakeOldPos
			end

			local var_293_21 = 0

			if var_293_21 < arg_290_1.time_ and arg_290_1.time_ <= var_293_21 + arg_293_0 then
				arg_290_1.allBtn_.enabled = false
			end

			local var_293_22 = 0.6

			if arg_290_1.time_ >= var_293_21 + var_293_22 and arg_290_1.time_ < var_293_21 + var_293_22 + arg_293_0 then
				arg_290_1.allBtn_.enabled = true
			end

			local var_293_23 = 0
			local var_293_24 = 1.15

			if var_293_23 < arg_290_1.time_ and arg_290_1.time_ <= var_293_23 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_25 = arg_290_1:GetWordFromCfg(413042069)
				local var_293_26 = arg_290_1:FormatText(var_293_25.content)

				arg_290_1.text_.text = var_293_26

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_27 = 46
				local var_293_28 = utf8.len(var_293_26)
				local var_293_29 = var_293_27 <= 0 and var_293_24 or var_293_24 * (var_293_28 / var_293_27)

				if var_293_29 > 0 and var_293_24 < var_293_29 then
					arg_290_1.talkMaxDuration = var_293_29

					if var_293_29 + var_293_23 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_29 + var_293_23
					end
				end

				arg_290_1.text_.text = var_293_26
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_30 = math.max(var_293_24, arg_290_1.talkMaxDuration)

			if var_293_23 <= arg_290_1.time_ and arg_290_1.time_ < var_293_23 + var_293_30 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_23) / var_293_30

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_23 + var_293_30 and arg_290_1.time_ < var_293_23 + var_293_30 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play413042070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 413042070
		arg_294_1.duration_ = 3.57

		local var_294_0 = {
			zh = 3.26666666666667,
			ja = 3.56666666666667
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play413042071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["10094"].transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPos10094 = var_297_0.localPosition
				var_297_0.localScale = Vector3.New(1, 1, 1)

				arg_294_1:CheckSpriteTmpPos("10094", 3)

				local var_297_2 = var_297_0.childCount

				for iter_297_0 = 0, var_297_2 - 1 do
					local var_297_3 = var_297_0:GetChild(iter_297_0)

					if var_297_3.name == "" or not string.find(var_297_3.name, "split") then
						var_297_3.gameObject:SetActive(true)
					else
						var_297_3.gameObject:SetActive(false)
					end
				end
			end

			local var_297_4 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_4 then
				local var_297_5 = (arg_294_1.time_ - var_297_1) / var_297_4
				local var_297_6 = Vector3.New(0, -340, -414)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10094, var_297_6, var_297_5)
			end

			if arg_294_1.time_ >= var_297_1 + var_297_4 and arg_294_1.time_ < var_297_1 + var_297_4 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_297_7 = arg_294_1.actors_["10094"]
			local var_297_8 = 0

			if var_297_8 < arg_294_1.time_ and arg_294_1.time_ <= var_297_8 + arg_297_0 and not isNil(var_297_7) and arg_294_1.var_.actorSpriteComps10094 == nil then
				arg_294_1.var_.actorSpriteComps10094 = var_297_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_9 = 2

			if var_297_8 <= arg_294_1.time_ and arg_294_1.time_ < var_297_8 + var_297_9 and not isNil(var_297_7) then
				local var_297_10 = (arg_294_1.time_ - var_297_8) / var_297_9

				if arg_294_1.var_.actorSpriteComps10094 then
					for iter_297_1, iter_297_2 in pairs(arg_294_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_297_2 then
							if arg_294_1.isInRecall_ then
								local var_297_11 = Mathf.Lerp(iter_297_2.color.r, arg_294_1.hightColor1.r, var_297_10)
								local var_297_12 = Mathf.Lerp(iter_297_2.color.g, arg_294_1.hightColor1.g, var_297_10)
								local var_297_13 = Mathf.Lerp(iter_297_2.color.b, arg_294_1.hightColor1.b, var_297_10)

								iter_297_2.color = Color.New(var_297_11, var_297_12, var_297_13)
							else
								local var_297_14 = Mathf.Lerp(iter_297_2.color.r, 1, var_297_10)

								iter_297_2.color = Color.New(var_297_14, var_297_14, var_297_14)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= var_297_8 + var_297_9 and arg_294_1.time_ < var_297_8 + var_297_9 + arg_297_0 and not isNil(var_297_7) and arg_294_1.var_.actorSpriteComps10094 then
				for iter_297_3, iter_297_4 in pairs(arg_294_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_297_4 then
						if arg_294_1.isInRecall_ then
							iter_297_4.color = arg_294_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_297_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_294_1.var_.actorSpriteComps10094 = nil
			end

			local var_297_15 = 0.378775801509619
			local var_297_16 = 0.621224198490381

			if var_297_15 < arg_294_1.time_ and arg_294_1.time_ <= var_297_15 + arg_297_0 then
				local var_297_17 = "play"
				local var_297_18 = "effect"

				arg_294_1:AudioAction(var_297_17, var_297_18, "se_story_134_01", "se_story_134_01_skill01", "")
			end

			local var_297_19 = arg_294_1.actors_["10094"]
			local var_297_20 = 0

			if var_297_20 < arg_294_1.time_ and arg_294_1.time_ <= var_297_20 + arg_297_0 then
				local var_297_21 = var_297_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_297_21 then
					arg_294_1.var_.alphaOldValue10094 = var_297_21.alpha
					arg_294_1.var_.characterEffect10094 = var_297_21
				end

				arg_294_1.var_.alphaOldValue10094 = 0
			end

			local var_297_22 = 0.378775801509619

			if var_297_20 <= arg_294_1.time_ and arg_294_1.time_ < var_297_20 + var_297_22 then
				local var_297_23 = (arg_294_1.time_ - var_297_20) / var_297_22
				local var_297_24 = Mathf.Lerp(arg_294_1.var_.alphaOldValue10094, 1, var_297_23)

				if arg_294_1.var_.characterEffect10094 then
					arg_294_1.var_.characterEffect10094.alpha = var_297_24
				end
			end

			if arg_294_1.time_ >= var_297_20 + var_297_22 and arg_294_1.time_ < var_297_20 + var_297_22 + arg_297_0 and arg_294_1.var_.characterEffect10094 then
				arg_294_1.var_.characterEffect10094.alpha = 1
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_25 = 0.666666666666667
			local var_297_26 = 0.125

			if var_297_25 < arg_294_1.time_ and arg_294_1.time_ <= var_297_25 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_27 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_27:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_28 = arg_294_1:FormatText(StoryNameCfg[259].name)

				arg_294_1.leftNameTxt_.text = var_297_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_29 = arg_294_1:GetWordFromCfg(413042070)
				local var_297_30 = arg_294_1:FormatText(var_297_29.content)

				arg_294_1.text_.text = var_297_30

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_31 = 5
				local var_297_32 = utf8.len(var_297_30)
				local var_297_33 = var_297_31 <= 0 and var_297_26 or var_297_26 * (var_297_32 / var_297_31)

				if var_297_33 > 0 and var_297_26 < var_297_33 then
					arg_294_1.talkMaxDuration = var_297_33
					var_297_25 = var_297_25 + 0.3

					if var_297_33 + var_297_25 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_33 + var_297_25
					end
				end

				arg_294_1.text_.text = var_297_30
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042070", "story_v_out_413042.awb") ~= 0 then
					local var_297_34 = manager.audio:GetVoiceLength("story_v_out_413042", "413042070", "story_v_out_413042.awb") / 1000

					if var_297_34 + var_297_25 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_34 + var_297_25
					end

					if var_297_29.prefab_name ~= "" and arg_294_1.actors_[var_297_29.prefab_name] ~= nil then
						local var_297_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_29.prefab_name].transform, "story_v_out_413042", "413042070", "story_v_out_413042.awb")

						arg_294_1:RecordAudio("413042070", var_297_35)
						arg_294_1:RecordAudio("413042070", var_297_35)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_413042", "413042070", "story_v_out_413042.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_413042", "413042070", "story_v_out_413042.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_36 = var_297_25 + 0.3
			local var_297_37 = math.max(var_297_26, arg_294_1.talkMaxDuration)

			if var_297_36 <= arg_294_1.time_ and arg_294_1.time_ < var_297_36 + var_297_37 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_36) / var_297_37

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_36 + var_297_37 and arg_294_1.time_ < var_297_36 + var_297_37 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
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

		arg_294_1:InitPlayNodeList()
	end,
	Play413042071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 413042071
		arg_300_1.duration_ = 5.88

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play413042072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10094"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos10094 = var_303_0.localPosition
				var_303_0.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("10094", 0)

				local var_303_2 = var_303_0.childCount

				for iter_303_0 = 0, var_303_2 - 1 do
					local var_303_3 = var_303_0:GetChild(iter_303_0)

					if var_303_3.name == "" or not string.find(var_303_3.name, "split") then
						var_303_3.gameObject:SetActive(true)
					else
						var_303_3.gameObject:SetActive(false)
					end
				end
			end

			local var_303_4 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_4 then
				local var_303_5 = (arg_300_1.time_ - var_303_1) / var_303_4
				local var_303_6 = Vector3.New(-5000, -340, -414)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10094, var_303_6, var_303_5)
			end

			if arg_300_1.time_ >= var_303_1 + var_303_4 and arg_300_1.time_ < var_303_1 + var_303_4 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_303_7 = arg_300_1.actors_["10094"]
			local var_303_8 = 0

			if var_303_8 < arg_300_1.time_ and arg_300_1.time_ <= var_303_8 + arg_303_0 and not isNil(var_303_7) and arg_300_1.var_.actorSpriteComps10094 == nil then
				arg_300_1.var_.actorSpriteComps10094 = var_303_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_9 = 2

			if var_303_8 <= arg_300_1.time_ and arg_300_1.time_ < var_303_8 + var_303_9 and not isNil(var_303_7) then
				local var_303_10 = (arg_300_1.time_ - var_303_8) / var_303_9

				if arg_300_1.var_.actorSpriteComps10094 then
					for iter_303_1, iter_303_2 in pairs(arg_300_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_303_2 then
							if arg_300_1.isInRecall_ then
								local var_303_11 = Mathf.Lerp(iter_303_2.color.r, arg_300_1.hightColor2.r, var_303_10)
								local var_303_12 = Mathf.Lerp(iter_303_2.color.g, arg_300_1.hightColor2.g, var_303_10)
								local var_303_13 = Mathf.Lerp(iter_303_2.color.b, arg_300_1.hightColor2.b, var_303_10)

								iter_303_2.color = Color.New(var_303_11, var_303_12, var_303_13)
							else
								local var_303_14 = Mathf.Lerp(iter_303_2.color.r, 0.5, var_303_10)

								iter_303_2.color = Color.New(var_303_14, var_303_14, var_303_14)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= var_303_8 + var_303_9 and arg_300_1.time_ < var_303_8 + var_303_9 + arg_303_0 and not isNil(var_303_7) and arg_300_1.var_.actorSpriteComps10094 then
				for iter_303_3, iter_303_4 in pairs(arg_300_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_303_4 then
						if arg_300_1.isInRecall_ then
							iter_303_4.color = arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_303_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_300_1.var_.actorSpriteComps10094 = nil
			end

			local var_303_15 = 0

			if var_303_15 < arg_300_1.time_ and arg_300_1.time_ <= var_303_15 + arg_303_0 then
				arg_300_1.allBtn_.enabled = false
			end

			local var_303_16 = 1

			if arg_300_1.time_ >= var_303_15 + var_303_16 and arg_300_1.time_ < var_303_15 + var_303_16 + arg_303_0 then
				arg_300_1.allBtn_.enabled = true
			end

			local var_303_17 = 1.75755160301924
			local var_303_18 = 0.621224198490381

			if var_303_17 < arg_300_1.time_ and arg_300_1.time_ <= var_303_17 + arg_303_0 then
				local var_303_19 = "play"
				local var_303_20 = "effect"

				arg_300_1:AudioAction(var_303_19, var_303_20, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_303_21 = 0

			if var_303_21 < arg_300_1.time_ and arg_300_1.time_ <= var_303_21 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_22 = 0.666666666666667

			if var_303_21 <= arg_300_1.time_ and arg_300_1.time_ < var_303_21 + var_303_22 then
				local var_303_23 = (arg_300_1.time_ - var_303_21) / var_303_22
				local var_303_24 = Color.New(1, 1, 1)

				var_303_24.a = Mathf.Lerp(1, 0, var_303_23)
				arg_300_1.mask_.color = var_303_24
			end

			if arg_300_1.time_ >= var_303_21 + var_303_22 and arg_300_1.time_ < var_303_21 + var_303_22 + arg_303_0 then
				local var_303_25 = Color.New(1, 1, 1)
				local var_303_26 = 0

				arg_300_1.mask_.enabled = false
				var_303_25.a = var_303_26
				arg_300_1.mask_.color = var_303_25
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_27 = 0.878775801509619
			local var_303_28 = 1.5

			if var_303_27 < arg_300_1.time_ and arg_300_1.time_ <= var_303_27 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_29 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_29:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_300_1.dialogCg_.alpha = arg_304_0
				end))
				var_303_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_30 = arg_300_1:GetWordFromCfg(413042071)
				local var_303_31 = arg_300_1:FormatText(var_303_30.content)

				arg_300_1.text_.text = var_303_31

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_32 = 60
				local var_303_33 = utf8.len(var_303_31)
				local var_303_34 = var_303_32 <= 0 and var_303_28 or var_303_28 * (var_303_33 / var_303_32)

				if var_303_34 > 0 and var_303_28 < var_303_34 then
					arg_300_1.talkMaxDuration = var_303_34
					var_303_27 = var_303_27 + 0.3

					if var_303_34 + var_303_27 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_34 + var_303_27
					end
				end

				arg_300_1.text_.text = var_303_31
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_35 = var_303_27 + 0.3
			local var_303_36 = math.max(var_303_28, arg_300_1.talkMaxDuration)

			if var_303_35 <= arg_300_1.time_ and arg_300_1.time_ < var_303_35 + var_303_36 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_35) / var_303_36

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_35 + var_303_36 and arg_300_1.time_ < var_303_35 + var_303_36 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
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

		arg_300_1:InitPlayNodeList()
	end,
	Play413042072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 413042072
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play413042073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.8

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_2 = arg_306_1:GetWordFromCfg(413042072)
				local var_309_3 = arg_306_1:FormatText(var_309_2.content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 32
				local var_309_5 = utf8.len(var_309_3)
				local var_309_6 = var_309_4 <= 0 and var_309_1 or var_309_1 * (var_309_5 / var_309_4)

				if var_309_6 > 0 and var_309_1 < var_309_6 then
					arg_306_1.talkMaxDuration = var_309_6

					if var_309_6 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_6 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_7 and arg_306_1.time_ < var_309_0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play413042073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 413042073
		arg_310_1.duration_ = 3.27

		local var_310_0 = {
			zh = 1.999999999999,
			ja = 3.266
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play413042074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["10092"].transform
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.var_.moveOldPos10092 = var_313_0.localPosition
				var_313_0.localScale = Vector3.New(1, 1, 1)

				arg_310_1:CheckSpriteTmpPos("10092", 3)

				local var_313_2 = var_313_0.childCount

				for iter_313_0 = 0, var_313_2 - 1 do
					local var_313_3 = var_313_0:GetChild(iter_313_0)

					if var_313_3.name == "split_3" or not string.find(var_313_3.name, "split") then
						var_313_3.gameObject:SetActive(true)
					else
						var_313_3.gameObject:SetActive(false)
					end
				end
			end

			local var_313_4 = 0.001

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_4 then
				local var_313_5 = (arg_310_1.time_ - var_313_1) / var_313_4
				local var_313_6 = Vector3.New(0, -300, -295)

				var_313_0.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10092, var_313_6, var_313_5)
			end

			if arg_310_1.time_ >= var_313_1 + var_313_4 and arg_310_1.time_ < var_313_1 + var_313_4 + arg_313_0 then
				var_313_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_313_7 = arg_310_1.actors_["10092"]
			local var_313_8 = 0

			if var_313_8 < arg_310_1.time_ and arg_310_1.time_ <= var_313_8 + arg_313_0 and not isNil(var_313_7) and arg_310_1.var_.actorSpriteComps10092 == nil then
				arg_310_1.var_.actorSpriteComps10092 = var_313_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_9 = 2

			if var_313_8 <= arg_310_1.time_ and arg_310_1.time_ < var_313_8 + var_313_9 and not isNil(var_313_7) then
				local var_313_10 = (arg_310_1.time_ - var_313_8) / var_313_9

				if arg_310_1.var_.actorSpriteComps10092 then
					for iter_313_1, iter_313_2 in pairs(arg_310_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_313_2 then
							if arg_310_1.isInRecall_ then
								local var_313_11 = Mathf.Lerp(iter_313_2.color.r, arg_310_1.hightColor1.r, var_313_10)
								local var_313_12 = Mathf.Lerp(iter_313_2.color.g, arg_310_1.hightColor1.g, var_313_10)
								local var_313_13 = Mathf.Lerp(iter_313_2.color.b, arg_310_1.hightColor1.b, var_313_10)

								iter_313_2.color = Color.New(var_313_11, var_313_12, var_313_13)
							else
								local var_313_14 = Mathf.Lerp(iter_313_2.color.r, 1, var_313_10)

								iter_313_2.color = Color.New(var_313_14, var_313_14, var_313_14)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_8 + var_313_9 and arg_310_1.time_ < var_313_8 + var_313_9 + arg_313_0 and not isNil(var_313_7) and arg_310_1.var_.actorSpriteComps10092 then
				for iter_313_3, iter_313_4 in pairs(arg_310_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_313_4 then
						if arg_310_1.isInRecall_ then
							iter_313_4.color = arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_313_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps10092 = nil
			end

			local var_313_15 = 0
			local var_313_16 = 0.25

			if var_313_15 < arg_310_1.time_ and arg_310_1.time_ <= var_313_15 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_17 = arg_310_1:FormatText(StoryNameCfg[996].name)

				arg_310_1.leftNameTxt_.text = var_313_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_18 = arg_310_1:GetWordFromCfg(413042073)
				local var_313_19 = arg_310_1:FormatText(var_313_18.content)

				arg_310_1.text_.text = var_313_19

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_20 = 10
				local var_313_21 = utf8.len(var_313_19)
				local var_313_22 = var_313_20 <= 0 and var_313_16 or var_313_16 * (var_313_21 / var_313_20)

				if var_313_22 > 0 and var_313_16 < var_313_22 then
					arg_310_1.talkMaxDuration = var_313_22

					if var_313_22 + var_313_15 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_22 + var_313_15
					end
				end

				arg_310_1.text_.text = var_313_19
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042073", "story_v_out_413042.awb") ~= 0 then
					local var_313_23 = manager.audio:GetVoiceLength("story_v_out_413042", "413042073", "story_v_out_413042.awb") / 1000

					if var_313_23 + var_313_15 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_23 + var_313_15
					end

					if var_313_18.prefab_name ~= "" and arg_310_1.actors_[var_313_18.prefab_name] ~= nil then
						local var_313_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_18.prefab_name].transform, "story_v_out_413042", "413042073", "story_v_out_413042.awb")

						arg_310_1:RecordAudio("413042073", var_313_24)
						arg_310_1:RecordAudio("413042073", var_313_24)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_413042", "413042073", "story_v_out_413042.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_413042", "413042073", "story_v_out_413042.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_25 = math.max(var_313_16, arg_310_1.talkMaxDuration)

			if var_313_15 <= arg_310_1.time_ and arg_310_1.time_ < var_313_15 + var_313_25 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_15) / var_313_25

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_15 + var_313_25 and arg_310_1.time_ < var_313_15 + var_313_25 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play413042074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 413042074
		arg_314_1.duration_ = 6.47

		local var_314_0 = {
			zh = 2.066,
			ja = 6.466
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play413042075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["10092"].transform
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.var_.moveOldPos10092 = var_317_0.localPosition
				var_317_0.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("10092", 0)

				local var_317_2 = var_317_0.childCount

				for iter_317_0 = 0, var_317_2 - 1 do
					local var_317_3 = var_317_0:GetChild(iter_317_0)

					if var_317_3.name == "" or not string.find(var_317_3.name, "split") then
						var_317_3.gameObject:SetActive(true)
					else
						var_317_3.gameObject:SetActive(false)
					end
				end
			end

			local var_317_4 = 0.001

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_4 then
				local var_317_5 = (arg_314_1.time_ - var_317_1) / var_317_4
				local var_317_6 = Vector3.New(0, -5000, 0)

				var_317_0.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10092, var_317_6, var_317_5)
			end

			if arg_314_1.time_ >= var_317_1 + var_317_4 and arg_314_1.time_ < var_317_1 + var_317_4 + arg_317_0 then
				var_317_0.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_317_7 = arg_314_1.actors_["10094"].transform
			local var_317_8 = 0

			if var_317_8 < arg_314_1.time_ and arg_314_1.time_ <= var_317_8 + arg_317_0 then
				arg_314_1.var_.moveOldPos10094 = var_317_7.localPosition
				var_317_7.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("10094", 3)

				local var_317_9 = var_317_7.childCount

				for iter_317_1 = 0, var_317_9 - 1 do
					local var_317_10 = var_317_7:GetChild(iter_317_1)

					if var_317_10.name == "" or not string.find(var_317_10.name, "split") then
						var_317_10.gameObject:SetActive(true)
					else
						var_317_10.gameObject:SetActive(false)
					end
				end
			end

			local var_317_11 = 0.001

			if var_317_8 <= arg_314_1.time_ and arg_314_1.time_ < var_317_8 + var_317_11 then
				local var_317_12 = (arg_314_1.time_ - var_317_8) / var_317_11
				local var_317_13 = Vector3.New(0, -340, -414)

				var_317_7.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10094, var_317_13, var_317_12)
			end

			if arg_314_1.time_ >= var_317_8 + var_317_11 and arg_314_1.time_ < var_317_8 + var_317_11 + arg_317_0 then
				var_317_7.localPosition = Vector3.New(0, -340, -414)
			end

			local var_317_14 = arg_314_1.actors_["10092"]
			local var_317_15 = 0

			if var_317_15 < arg_314_1.time_ and arg_314_1.time_ <= var_317_15 + arg_317_0 and not isNil(var_317_14) and arg_314_1.var_.actorSpriteComps10092 == nil then
				arg_314_1.var_.actorSpriteComps10092 = var_317_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_16 = 2

			if var_317_15 <= arg_314_1.time_ and arg_314_1.time_ < var_317_15 + var_317_16 and not isNil(var_317_14) then
				local var_317_17 = (arg_314_1.time_ - var_317_15) / var_317_16

				if arg_314_1.var_.actorSpriteComps10092 then
					for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_317_3 then
							if arg_314_1.isInRecall_ then
								local var_317_18 = Mathf.Lerp(iter_317_3.color.r, arg_314_1.hightColor2.r, var_317_17)
								local var_317_19 = Mathf.Lerp(iter_317_3.color.g, arg_314_1.hightColor2.g, var_317_17)
								local var_317_20 = Mathf.Lerp(iter_317_3.color.b, arg_314_1.hightColor2.b, var_317_17)

								iter_317_3.color = Color.New(var_317_18, var_317_19, var_317_20)
							else
								local var_317_21 = Mathf.Lerp(iter_317_3.color.r, 0.5, var_317_17)

								iter_317_3.color = Color.New(var_317_21, var_317_21, var_317_21)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_15 + var_317_16 and arg_314_1.time_ < var_317_15 + var_317_16 + arg_317_0 and not isNil(var_317_14) and arg_314_1.var_.actorSpriteComps10092 then
				for iter_317_4, iter_317_5 in pairs(arg_314_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_317_5 then
						if arg_314_1.isInRecall_ then
							iter_317_5.color = arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_317_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps10092 = nil
			end

			local var_317_22 = arg_314_1.actors_["10094"]
			local var_317_23 = 0

			if var_317_23 < arg_314_1.time_ and arg_314_1.time_ <= var_317_23 + arg_317_0 and not isNil(var_317_22) and arg_314_1.var_.actorSpriteComps10094 == nil then
				arg_314_1.var_.actorSpriteComps10094 = var_317_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_24 = 2

			if var_317_23 <= arg_314_1.time_ and arg_314_1.time_ < var_317_23 + var_317_24 and not isNil(var_317_22) then
				local var_317_25 = (arg_314_1.time_ - var_317_23) / var_317_24

				if arg_314_1.var_.actorSpriteComps10094 then
					for iter_317_6, iter_317_7 in pairs(arg_314_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_317_7 then
							if arg_314_1.isInRecall_ then
								local var_317_26 = Mathf.Lerp(iter_317_7.color.r, arg_314_1.hightColor1.r, var_317_25)
								local var_317_27 = Mathf.Lerp(iter_317_7.color.g, arg_314_1.hightColor1.g, var_317_25)
								local var_317_28 = Mathf.Lerp(iter_317_7.color.b, arg_314_1.hightColor1.b, var_317_25)

								iter_317_7.color = Color.New(var_317_26, var_317_27, var_317_28)
							else
								local var_317_29 = Mathf.Lerp(iter_317_7.color.r, 1, var_317_25)

								iter_317_7.color = Color.New(var_317_29, var_317_29, var_317_29)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_23 + var_317_24 and arg_314_1.time_ < var_317_23 + var_317_24 + arg_317_0 and not isNil(var_317_22) and arg_314_1.var_.actorSpriteComps10094 then
				for iter_317_8, iter_317_9 in pairs(arg_314_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_317_9 then
						if arg_314_1.isInRecall_ then
							iter_317_9.color = arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_317_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps10094 = nil
			end

			local var_317_30 = 0
			local var_317_31 = 0.25

			if var_317_30 < arg_314_1.time_ and arg_314_1.time_ <= var_317_30 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_32 = arg_314_1:FormatText(StoryNameCfg[259].name)

				arg_314_1.leftNameTxt_.text = var_317_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_33 = arg_314_1:GetWordFromCfg(413042074)
				local var_317_34 = arg_314_1:FormatText(var_317_33.content)

				arg_314_1.text_.text = var_317_34

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_35 = 10
				local var_317_36 = utf8.len(var_317_34)
				local var_317_37 = var_317_35 <= 0 and var_317_31 or var_317_31 * (var_317_36 / var_317_35)

				if var_317_37 > 0 and var_317_31 < var_317_37 then
					arg_314_1.talkMaxDuration = var_317_37

					if var_317_37 + var_317_30 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_37 + var_317_30
					end
				end

				arg_314_1.text_.text = var_317_34
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042074", "story_v_out_413042.awb") ~= 0 then
					local var_317_38 = manager.audio:GetVoiceLength("story_v_out_413042", "413042074", "story_v_out_413042.awb") / 1000

					if var_317_38 + var_317_30 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_38 + var_317_30
					end

					if var_317_33.prefab_name ~= "" and arg_314_1.actors_[var_317_33.prefab_name] ~= nil then
						local var_317_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_33.prefab_name].transform, "story_v_out_413042", "413042074", "story_v_out_413042.awb")

						arg_314_1:RecordAudio("413042074", var_317_39)
						arg_314_1:RecordAudio("413042074", var_317_39)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_413042", "413042074", "story_v_out_413042.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_413042", "413042074", "story_v_out_413042.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_40 = math.max(var_317_31, arg_314_1.talkMaxDuration)

			if var_317_30 <= arg_314_1.time_ and arg_314_1.time_ < var_317_30 + var_317_40 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_30) / var_317_40

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_30 + var_317_40 and arg_314_1.time_ < var_317_30 + var_317_40 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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

		arg_314_1:InitPlayNodeList()
	end,
	Play413042075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 413042075
		arg_318_1.duration_ = 3.6

		local var_318_0 = {
			zh = 2.7,
			ja = 3.6
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
			arg_318_1.auto_ = false
		end

		function arg_318_1.playNext_(arg_320_0)
			arg_318_1.onStoryFinished_()
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 0.275

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[259].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_3 = arg_318_1:GetWordFromCfg(413042075)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 11
				local var_321_6 = utf8.len(var_321_4)
				local var_321_7 = var_321_5 <= 0 and var_321_1 or var_321_1 * (var_321_6 / var_321_5)

				if var_321_7 > 0 and var_321_1 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042075", "story_v_out_413042.awb") ~= 0 then
					local var_321_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042075", "story_v_out_413042.awb") / 1000

					if var_321_8 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_8 + var_321_0
					end

					if var_321_3.prefab_name ~= "" and arg_318_1.actors_[var_321_3.prefab_name] ~= nil then
						local var_321_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_3.prefab_name].transform, "story_v_out_413042", "413042075", "story_v_out_413042.awb")

						arg_318_1:RecordAudio("413042075", var_321_9)
						arg_318_1:RecordAudio("413042075", var_321_9)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_413042", "413042075", "story_v_out_413042.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_413042", "413042075", "story_v_out_413042.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_10 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_10 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_10

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_10 and arg_318_1.time_ < var_321_0 + var_321_10 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F10f",
		"TextureConfig/Background/SS1303"
	},
	voices = {
		"story_v_out_413042.awb"
	}
}
