return {
	Play418071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418071001
		arg_1_1.duration_ = 7.97

		local var_1_0 = {
			ja = 7.966,
			CriLanguages = 6.566,
			zh = 6.566
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
				arg_1_0:Play418071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST40"

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
				local var_4_5 = arg_1_1.bgs_.ST40

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
					if iter_4_0 ~= "ST40" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = "1073"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1073")

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

			local var_4_28 = arg_1_1.actors_["1073"]
			local var_4_29 = 1.78835209617391

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1073 == nil then
				arg_1_1.var_.actorSpriteComps1073 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps1073 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1073 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1073 = nil
			end

			local var_4_36 = arg_1_1.actors_["1073"].transform
			local var_4_37 = 1.78835209617391

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos1073 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1073", 2)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(-405.76, -414.5, -207.2)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1073, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_4_43 = 0.05
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "effect"

				arg_1_1:AudioAction(var_4_45, var_4_46, "se_story_140", "se_story_140_amb_chinese restaurant", "")
			end

			local var_4_47 = 0.4
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily.awb")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily")

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
			local var_4_54 = 0.675

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_55 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_55:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[380].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(418071001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 27
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

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071001", "story_v_side_old_418071.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071001", "story_v_side_old_418071.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_side_old_418071", "418071001", "story_v_side_old_418071.awb")

						arg_1_1:RecordAudio("418071001", var_4_63)
						arg_1_1:RecordAudio("418071001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071001", "story_v_side_old_418071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071001", "story_v_side_old_418071.awb")
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
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.78835209617391,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play418071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418071002
		arg_8_1.duration_ = 10.17

		local var_8_0 = {
			ja = 10.166,
			CriLanguages = 9.4,
			zh = 9.4
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
				arg_8_0:Play418071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "10135"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10135")

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

			local var_11_4 = arg_8_1.actors_["10135"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps10135 == nil then
				arg_8_1.var_.actorSpriteComps10135 = var_11_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.actorSpriteComps10135 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps10135 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_11_5 then
						if arg_8_1.isInRecall_ then
							iter_11_5.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_11_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps10135 = nil
			end

			local var_11_12 = arg_8_1.actors_["1073"]
			local var_11_13 = 0

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 and not isNil(var_11_12) and arg_8_1.var_.actorSpriteComps1073 == nil then
				arg_8_1.var_.actorSpriteComps1073 = var_11_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_14 = 0.2

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_14 and not isNil(var_11_12) then
				local var_11_15 = (arg_8_1.time_ - var_11_13) / var_11_14

				if arg_8_1.var_.actorSpriteComps1073 then
					for iter_11_6, iter_11_7 in pairs(arg_8_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_11_7 then
							if arg_8_1.isInRecall_ then
								local var_11_16 = Mathf.Lerp(iter_11_7.color.r, arg_8_1.hightColor2.r, var_11_15)
								local var_11_17 = Mathf.Lerp(iter_11_7.color.g, arg_8_1.hightColor2.g, var_11_15)
								local var_11_18 = Mathf.Lerp(iter_11_7.color.b, arg_8_1.hightColor2.b, var_11_15)

								iter_11_7.color = Color.New(var_11_16, var_11_17, var_11_18)
							else
								local var_11_19 = Mathf.Lerp(iter_11_7.color.r, 0.5, var_11_15)

								iter_11_7.color = Color.New(var_11_19, var_11_19, var_11_19)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= var_11_13 + var_11_14 and arg_8_1.time_ < var_11_13 + var_11_14 + arg_11_0 and not isNil(var_11_12) and arg_8_1.var_.actorSpriteComps1073 then
				for iter_11_8, iter_11_9 in pairs(arg_8_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_11_9 then
						if arg_8_1.isInRecall_ then
							iter_11_9.color = arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_11_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps1073 = nil
			end

			local var_11_20 = arg_8_1.actors_["10135"].transform
			local var_11_21 = 0

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.var_.moveOldPos10135 = var_11_20.localPosition
				var_11_20.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10135", 4)

				local var_11_22 = var_11_20.childCount

				for iter_11_10 = 0, var_11_22 - 1 do
					local var_11_23 = var_11_20:GetChild(iter_11_10)

					if var_11_23.name == "" or not string.find(var_11_23.name, "split") then
						var_11_23.gameObject:SetActive(true)
					else
						var_11_23.gameObject:SetActive(false)
					end
				end
			end

			local var_11_24 = 0.001

			if var_11_21 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_24 then
				local var_11_25 = (arg_8_1.time_ - var_11_21) / var_11_24
				local var_11_26 = Vector3.New(432.72, -363.6, -305.9)

				var_11_20.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10135, var_11_26, var_11_25)
			end

			if arg_8_1.time_ >= var_11_21 + var_11_24 and arg_8_1.time_ < var_11_21 + var_11_24 + arg_11_0 then
				var_11_20.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_11_27 = 0
			local var_11_28 = 1.125

			if var_11_27 < arg_8_1.time_ and arg_8_1.time_ <= var_11_27 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_29 = arg_8_1:FormatText(StoryNameCfg[1187].name)

				arg_8_1.leftNameTxt_.text = var_11_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_30 = arg_8_1:GetWordFromCfg(418071002)
				local var_11_31 = arg_8_1:FormatText(var_11_30.content)

				arg_8_1.text_.text = var_11_31

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_32 = 45
				local var_11_33 = utf8.len(var_11_31)
				local var_11_34 = var_11_32 <= 0 and var_11_28 or var_11_28 * (var_11_33 / var_11_32)

				if var_11_34 > 0 and var_11_28 < var_11_34 then
					arg_8_1.talkMaxDuration = var_11_34

					if var_11_34 + var_11_27 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_27
					end
				end

				arg_8_1.text_.text = var_11_31
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071002", "story_v_side_old_418071.awb") ~= 0 then
					local var_11_35 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071002", "story_v_side_old_418071.awb") / 1000

					if var_11_35 + var_11_27 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_35 + var_11_27
					end

					if var_11_30.prefab_name ~= "" and arg_8_1.actors_[var_11_30.prefab_name] ~= nil then
						local var_11_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_30.prefab_name].transform, "story_v_side_old_418071", "418071002", "story_v_side_old_418071.awb")

						arg_8_1:RecordAudio("418071002", var_11_36)
						arg_8_1:RecordAudio("418071002", var_11_36)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071002", "story_v_side_old_418071.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071002", "story_v_side_old_418071.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_37 = math.max(var_11_28, arg_8_1.talkMaxDuration)

			if var_11_27 <= arg_8_1.time_ and arg_8_1.time_ < var_11_27 + var_11_37 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_27) / var_11_37

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_27 + var_11_37 and arg_8_1.time_ < var_11_27 + var_11_37 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
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
	Play418071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418071003
		arg_12_1.duration_ = 9.03

		local var_12_0 = {
			ja = 9.033,
			CriLanguages = 7.633,
			zh = 7.633
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play418071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1073"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps1073 == nil then
				arg_12_1.var_.actorSpriteComps1073 = var_15_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.actorSpriteComps1073 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_15_1 then
							if arg_12_1.isInRecall_ then
								local var_15_4 = Mathf.Lerp(iter_15_1.color.r, arg_12_1.hightColor1.r, var_15_3)
								local var_15_5 = Mathf.Lerp(iter_15_1.color.g, arg_12_1.hightColor1.g, var_15_3)
								local var_15_6 = Mathf.Lerp(iter_15_1.color.b, arg_12_1.hightColor1.b, var_15_3)

								iter_15_1.color = Color.New(var_15_4, var_15_5, var_15_6)
							else
								local var_15_7 = Mathf.Lerp(iter_15_1.color.r, 1, var_15_3)

								iter_15_1.color = Color.New(var_15_7, var_15_7, var_15_7)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps1073 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_15_3 then
						if arg_12_1.isInRecall_ then
							iter_15_3.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_15_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps1073 = nil
			end

			local var_15_8 = arg_12_1.actors_["10135"]
			local var_15_9 = 0

			if var_15_9 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 and not isNil(var_15_8) and arg_12_1.var_.actorSpriteComps10135 == nil then
				arg_12_1.var_.actorSpriteComps10135 = var_15_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_10 = 0.2

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_10 and not isNil(var_15_8) then
				local var_15_11 = (arg_12_1.time_ - var_15_9) / var_15_10

				if arg_12_1.var_.actorSpriteComps10135 then
					for iter_15_4, iter_15_5 in pairs(arg_12_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_15_5 then
							if arg_12_1.isInRecall_ then
								local var_15_12 = Mathf.Lerp(iter_15_5.color.r, arg_12_1.hightColor2.r, var_15_11)
								local var_15_13 = Mathf.Lerp(iter_15_5.color.g, arg_12_1.hightColor2.g, var_15_11)
								local var_15_14 = Mathf.Lerp(iter_15_5.color.b, arg_12_1.hightColor2.b, var_15_11)

								iter_15_5.color = Color.New(var_15_12, var_15_13, var_15_14)
							else
								local var_15_15 = Mathf.Lerp(iter_15_5.color.r, 0.5, var_15_11)

								iter_15_5.color = Color.New(var_15_15, var_15_15, var_15_15)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_9 + var_15_10 and arg_12_1.time_ < var_15_9 + var_15_10 + arg_15_0 and not isNil(var_15_8) and arg_12_1.var_.actorSpriteComps10135 then
				for iter_15_6, iter_15_7 in pairs(arg_12_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_15_7 then
						if arg_12_1.isInRecall_ then
							iter_15_7.color = arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_15_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps10135 = nil
			end

			local var_15_16 = arg_12_1.actors_["1073"].transform
			local var_15_17 = 0

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 then
				arg_12_1.var_.moveOldPos1073 = var_15_16.localPosition
				var_15_16.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("1073", 2)

				local var_15_18 = var_15_16.childCount

				for iter_15_8 = 0, var_15_18 - 1 do
					local var_15_19 = var_15_16:GetChild(iter_15_8)

					if var_15_19.name == "split_2" or not string.find(var_15_19.name, "split") then
						var_15_19.gameObject:SetActive(true)
					else
						var_15_19.gameObject:SetActive(false)
					end
				end
			end

			local var_15_20 = 0.001

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_20 then
				local var_15_21 = (arg_12_1.time_ - var_15_17) / var_15_20
				local var_15_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_15_16.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1073, var_15_22, var_15_21)
			end

			if arg_12_1.time_ >= var_15_17 + var_15_20 and arg_12_1.time_ < var_15_17 + var_15_20 + arg_15_0 then
				var_15_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_15_23 = 0
			local var_15_24 = 0.95

			if var_15_23 < arg_12_1.time_ and arg_12_1.time_ <= var_15_23 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_25 = arg_12_1:FormatText(StoryNameCfg[380].name)

				arg_12_1.leftNameTxt_.text = var_15_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_26 = arg_12_1:GetWordFromCfg(418071003)
				local var_15_27 = arg_12_1:FormatText(var_15_26.content)

				arg_12_1.text_.text = var_15_27

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_28 = 38
				local var_15_29 = utf8.len(var_15_27)
				local var_15_30 = var_15_28 <= 0 and var_15_24 or var_15_24 * (var_15_29 / var_15_28)

				if var_15_30 > 0 and var_15_24 < var_15_30 then
					arg_12_1.talkMaxDuration = var_15_30

					if var_15_30 + var_15_23 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_30 + var_15_23
					end
				end

				arg_12_1.text_.text = var_15_27
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071003", "story_v_side_old_418071.awb") ~= 0 then
					local var_15_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071003", "story_v_side_old_418071.awb") / 1000

					if var_15_31 + var_15_23 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_31 + var_15_23
					end

					if var_15_26.prefab_name ~= "" and arg_12_1.actors_[var_15_26.prefab_name] ~= nil then
						local var_15_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_26.prefab_name].transform, "story_v_side_old_418071", "418071003", "story_v_side_old_418071.awb")

						arg_12_1:RecordAudio("418071003", var_15_32)
						arg_12_1:RecordAudio("418071003", var_15_32)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071003", "story_v_side_old_418071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071003", "story_v_side_old_418071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_33 = math.max(var_15_24, arg_12_1.talkMaxDuration)

			if var_15_23 <= arg_12_1.time_ and arg_12_1.time_ < var_15_23 + var_15_33 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_23) / var_15_33

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_23 + var_15_33 and arg_12_1.time_ < var_15_23 + var_15_33 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play418071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418071004
		arg_16_1.duration_ = 9.23

		local var_16_0 = {
			ja = 9.233,
			CriLanguages = 6.033,
			zh = 6.033
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play418071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10135"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps10135 == nil then
				arg_16_1.var_.actorSpriteComps10135 = var_19_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.actorSpriteComps10135 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_19_1 then
							if arg_16_1.isInRecall_ then
								local var_19_4 = Mathf.Lerp(iter_19_1.color.r, arg_16_1.hightColor1.r, var_19_3)
								local var_19_5 = Mathf.Lerp(iter_19_1.color.g, arg_16_1.hightColor1.g, var_19_3)
								local var_19_6 = Mathf.Lerp(iter_19_1.color.b, arg_16_1.hightColor1.b, var_19_3)

								iter_19_1.color = Color.New(var_19_4, var_19_5, var_19_6)
							else
								local var_19_7 = Mathf.Lerp(iter_19_1.color.r, 1, var_19_3)

								iter_19_1.color = Color.New(var_19_7, var_19_7, var_19_7)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps10135 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_19_3 then
						if arg_16_1.isInRecall_ then
							iter_19_3.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_19_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps10135 = nil
			end

			local var_19_8 = arg_16_1.actors_["1073"]
			local var_19_9 = 0

			if var_19_9 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 and not isNil(var_19_8) and arg_16_1.var_.actorSpriteComps1073 == nil then
				arg_16_1.var_.actorSpriteComps1073 = var_19_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_10 = 0.2

			if var_19_9 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_10 and not isNil(var_19_8) then
				local var_19_11 = (arg_16_1.time_ - var_19_9) / var_19_10

				if arg_16_1.var_.actorSpriteComps1073 then
					for iter_19_4, iter_19_5 in pairs(arg_16_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_19_5 then
							if arg_16_1.isInRecall_ then
								local var_19_12 = Mathf.Lerp(iter_19_5.color.r, arg_16_1.hightColor2.r, var_19_11)
								local var_19_13 = Mathf.Lerp(iter_19_5.color.g, arg_16_1.hightColor2.g, var_19_11)
								local var_19_14 = Mathf.Lerp(iter_19_5.color.b, arg_16_1.hightColor2.b, var_19_11)

								iter_19_5.color = Color.New(var_19_12, var_19_13, var_19_14)
							else
								local var_19_15 = Mathf.Lerp(iter_19_5.color.r, 0.5, var_19_11)

								iter_19_5.color = Color.New(var_19_15, var_19_15, var_19_15)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= var_19_9 + var_19_10 and arg_16_1.time_ < var_19_9 + var_19_10 + arg_19_0 and not isNil(var_19_8) and arg_16_1.var_.actorSpriteComps1073 then
				for iter_19_6, iter_19_7 in pairs(arg_16_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_19_7 then
						if arg_16_1.isInRecall_ then
							iter_19_7.color = arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_19_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps1073 = nil
			end

			local var_19_16 = arg_16_1.actors_["10135"].transform
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.var_.moveOldPos10135 = var_19_16.localPosition
				var_19_16.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10135", 4)

				local var_19_18 = var_19_16.childCount

				for iter_19_8 = 0, var_19_18 - 1 do
					local var_19_19 = var_19_16:GetChild(iter_19_8)

					if var_19_19.name == "split_2" or not string.find(var_19_19.name, "split") then
						var_19_19.gameObject:SetActive(true)
					else
						var_19_19.gameObject:SetActive(false)
					end
				end
			end

			local var_19_20 = 0.001

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_20 then
				local var_19_21 = (arg_16_1.time_ - var_19_17) / var_19_20
				local var_19_22 = Vector3.New(432.72, -363.6, -305.9)

				var_19_16.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10135, var_19_22, var_19_21)
			end

			if arg_16_1.time_ >= var_19_17 + var_19_20 and arg_16_1.time_ < var_19_17 + var_19_20 + arg_19_0 then
				var_19_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_19_23 = 0
			local var_19_24 = 0.775

			if var_19_23 < arg_16_1.time_ and arg_16_1.time_ <= var_19_23 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_25 = arg_16_1:FormatText(StoryNameCfg[1187].name)

				arg_16_1.leftNameTxt_.text = var_19_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_26 = arg_16_1:GetWordFromCfg(418071004)
				local var_19_27 = arg_16_1:FormatText(var_19_26.content)

				arg_16_1.text_.text = var_19_27

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_28 = 31
				local var_19_29 = utf8.len(var_19_27)
				local var_19_30 = var_19_28 <= 0 and var_19_24 or var_19_24 * (var_19_29 / var_19_28)

				if var_19_30 > 0 and var_19_24 < var_19_30 then
					arg_16_1.talkMaxDuration = var_19_30

					if var_19_30 + var_19_23 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_30 + var_19_23
					end
				end

				arg_16_1.text_.text = var_19_27
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071004", "story_v_side_old_418071.awb") ~= 0 then
					local var_19_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071004", "story_v_side_old_418071.awb") / 1000

					if var_19_31 + var_19_23 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_31 + var_19_23
					end

					if var_19_26.prefab_name ~= "" and arg_16_1.actors_[var_19_26.prefab_name] ~= nil then
						local var_19_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_26.prefab_name].transform, "story_v_side_old_418071", "418071004", "story_v_side_old_418071.awb")

						arg_16_1:RecordAudio("418071004", var_19_32)
						arg_16_1:RecordAudio("418071004", var_19_32)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071004", "story_v_side_old_418071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071004", "story_v_side_old_418071.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_33 = math.max(var_19_24, arg_16_1.talkMaxDuration)

			if var_19_23 <= arg_16_1.time_ and arg_16_1.time_ < var_19_23 + var_19_33 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_23) / var_19_33

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_23 + var_19_33 and arg_16_1.time_ < var_19_23 + var_19_33 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play418071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418071005
		arg_20_1.duration_ = 10.4

		local var_20_0 = {
			ja = 10.4,
			CriLanguages = 7.966,
			zh = 7.966
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play418071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1073"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps1073 == nil then
				arg_20_1.var_.actorSpriteComps1073 = var_23_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.actorSpriteComps1073 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_23_1 then
							if arg_20_1.isInRecall_ then
								local var_23_4 = Mathf.Lerp(iter_23_1.color.r, arg_20_1.hightColor1.r, var_23_3)
								local var_23_5 = Mathf.Lerp(iter_23_1.color.g, arg_20_1.hightColor1.g, var_23_3)
								local var_23_6 = Mathf.Lerp(iter_23_1.color.b, arg_20_1.hightColor1.b, var_23_3)

								iter_23_1.color = Color.New(var_23_4, var_23_5, var_23_6)
							else
								local var_23_7 = Mathf.Lerp(iter_23_1.color.r, 1, var_23_3)

								iter_23_1.color = Color.New(var_23_7, var_23_7, var_23_7)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps1073 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_23_3 then
						if arg_20_1.isInRecall_ then
							iter_23_3.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_23_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps1073 = nil
			end

			local var_23_8 = arg_20_1.actors_["10135"]
			local var_23_9 = 0

			if var_23_9 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 and not isNil(var_23_8) and arg_20_1.var_.actorSpriteComps10135 == nil then
				arg_20_1.var_.actorSpriteComps10135 = var_23_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_10 = 0.2

			if var_23_9 <= arg_20_1.time_ and arg_20_1.time_ < var_23_9 + var_23_10 and not isNil(var_23_8) then
				local var_23_11 = (arg_20_1.time_ - var_23_9) / var_23_10

				if arg_20_1.var_.actorSpriteComps10135 then
					for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_23_5 then
							if arg_20_1.isInRecall_ then
								local var_23_12 = Mathf.Lerp(iter_23_5.color.r, arg_20_1.hightColor2.r, var_23_11)
								local var_23_13 = Mathf.Lerp(iter_23_5.color.g, arg_20_1.hightColor2.g, var_23_11)
								local var_23_14 = Mathf.Lerp(iter_23_5.color.b, arg_20_1.hightColor2.b, var_23_11)

								iter_23_5.color = Color.New(var_23_12, var_23_13, var_23_14)
							else
								local var_23_15 = Mathf.Lerp(iter_23_5.color.r, 0.5, var_23_11)

								iter_23_5.color = Color.New(var_23_15, var_23_15, var_23_15)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_9 + var_23_10 and arg_20_1.time_ < var_23_9 + var_23_10 + arg_23_0 and not isNil(var_23_8) and arg_20_1.var_.actorSpriteComps10135 then
				for iter_23_6, iter_23_7 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_23_7 then
						if arg_20_1.isInRecall_ then
							iter_23_7.color = arg_20_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_23_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps10135 = nil
			end

			local var_23_16 = arg_20_1.actors_["1073"].transform
			local var_23_17 = 0

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				arg_20_1.var_.moveOldPos1073 = var_23_16.localPosition
				var_23_16.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("1073", 2)

				local var_23_18 = var_23_16.childCount

				for iter_23_8 = 0, var_23_18 - 1 do
					local var_23_19 = var_23_16:GetChild(iter_23_8)

					if var_23_19.name == "split_5" or not string.find(var_23_19.name, "split") then
						var_23_19.gameObject:SetActive(true)
					else
						var_23_19.gameObject:SetActive(false)
					end
				end
			end

			local var_23_20 = 0.001

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_20 then
				local var_23_21 = (arg_20_1.time_ - var_23_17) / var_23_20
				local var_23_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_23_16.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1073, var_23_22, var_23_21)
			end

			if arg_20_1.time_ >= var_23_17 + var_23_20 and arg_20_1.time_ < var_23_17 + var_23_20 + arg_23_0 then
				var_23_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_23_23 = 0
			local var_23_24 = 1.1

			if var_23_23 < arg_20_1.time_ and arg_20_1.time_ <= var_23_23 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_25 = arg_20_1:FormatText(StoryNameCfg[380].name)

				arg_20_1.leftNameTxt_.text = var_23_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_26 = arg_20_1:GetWordFromCfg(418071005)
				local var_23_27 = arg_20_1:FormatText(var_23_26.content)

				arg_20_1.text_.text = var_23_27

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_28 = 44
				local var_23_29 = utf8.len(var_23_27)
				local var_23_30 = var_23_28 <= 0 and var_23_24 or var_23_24 * (var_23_29 / var_23_28)

				if var_23_30 > 0 and var_23_24 < var_23_30 then
					arg_20_1.talkMaxDuration = var_23_30

					if var_23_30 + var_23_23 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_30 + var_23_23
					end
				end

				arg_20_1.text_.text = var_23_27
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071005", "story_v_side_old_418071.awb") ~= 0 then
					local var_23_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071005", "story_v_side_old_418071.awb") / 1000

					if var_23_31 + var_23_23 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_31 + var_23_23
					end

					if var_23_26.prefab_name ~= "" and arg_20_1.actors_[var_23_26.prefab_name] ~= nil then
						local var_23_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_26.prefab_name].transform, "story_v_side_old_418071", "418071005", "story_v_side_old_418071.awb")

						arg_20_1:RecordAudio("418071005", var_23_32)
						arg_20_1:RecordAudio("418071005", var_23_32)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071005", "story_v_side_old_418071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071005", "story_v_side_old_418071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_33 = math.max(var_23_24, arg_20_1.talkMaxDuration)

			if var_23_23 <= arg_20_1.time_ and arg_20_1.time_ < var_23_23 + var_23_33 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_23) / var_23_33

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_23 + var_23_33 and arg_20_1.time_ < var_23_23 + var_23_33 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play418071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418071006
		arg_24_1.duration_ = 2.83

		local var_24_0 = {
			ja = 2.833,
			CriLanguages = 1.466,
			zh = 1.466
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play418071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10135"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps10135 == nil then
				arg_24_1.var_.actorSpriteComps10135 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps10135 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								local var_27_4 = Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor1.r, var_27_3)
								local var_27_5 = Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor1.g, var_27_3)
								local var_27_6 = Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor1.b, var_27_3)

								iter_27_1.color = Color.New(var_27_4, var_27_5, var_27_6)
							else
								local var_27_7 = Mathf.Lerp(iter_27_1.color.r, 1, var_27_3)

								iter_27_1.color = Color.New(var_27_7, var_27_7, var_27_7)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps10135 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_27_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps10135 = nil
			end

			local var_27_8 = arg_24_1.actors_["1073"]
			local var_27_9 = 0

			if var_27_9 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.actorSpriteComps1073 == nil then
				arg_24_1.var_.actorSpriteComps1073 = var_27_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_10 = 0.2

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_10 and not isNil(var_27_8) then
				local var_27_11 = (arg_24_1.time_ - var_27_9) / var_27_10

				if arg_24_1.var_.actorSpriteComps1073 then
					for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_27_5 then
							if arg_24_1.isInRecall_ then
								local var_27_12 = Mathf.Lerp(iter_27_5.color.r, arg_24_1.hightColor2.r, var_27_11)
								local var_27_13 = Mathf.Lerp(iter_27_5.color.g, arg_24_1.hightColor2.g, var_27_11)
								local var_27_14 = Mathf.Lerp(iter_27_5.color.b, arg_24_1.hightColor2.b, var_27_11)

								iter_27_5.color = Color.New(var_27_12, var_27_13, var_27_14)
							else
								local var_27_15 = Mathf.Lerp(iter_27_5.color.r, 0.5, var_27_11)

								iter_27_5.color = Color.New(var_27_15, var_27_15, var_27_15)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_9 + var_27_10 and arg_24_1.time_ < var_27_9 + var_27_10 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.actorSpriteComps1073 then
				for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_27_7 then
						if arg_24_1.isInRecall_ then
							iter_27_7.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps1073 = nil
			end

			local var_27_16 = arg_24_1.actors_["10135"].transform
			local var_27_17 = 0

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 then
				arg_24_1.var_.moveOldPos10135 = var_27_16.localPosition
				var_27_16.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("10135", 4)

				local var_27_18 = var_27_16.childCount

				for iter_27_8 = 0, var_27_18 - 1 do
					local var_27_19 = var_27_16:GetChild(iter_27_8)

					if var_27_19.name == "" or not string.find(var_27_19.name, "split") then
						var_27_19.gameObject:SetActive(true)
					else
						var_27_19.gameObject:SetActive(false)
					end
				end
			end

			local var_27_20 = 0.001

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_20 then
				local var_27_21 = (arg_24_1.time_ - var_27_17) / var_27_20
				local var_27_22 = Vector3.New(432.72, -363.6, -305.9)

				var_27_16.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10135, var_27_22, var_27_21)
			end

			if arg_24_1.time_ >= var_27_17 + var_27_20 and arg_24_1.time_ < var_27_17 + var_27_20 + arg_27_0 then
				var_27_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_27_23 = 0
			local var_27_24 = 0.15

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_25 = arg_24_1:FormatText(StoryNameCfg[1187].name)

				arg_24_1.leftNameTxt_.text = var_27_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_26 = arg_24_1:GetWordFromCfg(418071006)
				local var_27_27 = arg_24_1:FormatText(var_27_26.content)

				arg_24_1.text_.text = var_27_27

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_28 = 6
				local var_27_29 = utf8.len(var_27_27)
				local var_27_30 = var_27_28 <= 0 and var_27_24 or var_27_24 * (var_27_29 / var_27_28)

				if var_27_30 > 0 and var_27_24 < var_27_30 then
					arg_24_1.talkMaxDuration = var_27_30

					if var_27_30 + var_27_23 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_30 + var_27_23
					end
				end

				arg_24_1.text_.text = var_27_27
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071006", "story_v_side_old_418071.awb") ~= 0 then
					local var_27_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071006", "story_v_side_old_418071.awb") / 1000

					if var_27_31 + var_27_23 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_31 + var_27_23
					end

					if var_27_26.prefab_name ~= "" and arg_24_1.actors_[var_27_26.prefab_name] ~= nil then
						local var_27_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_26.prefab_name].transform, "story_v_side_old_418071", "418071006", "story_v_side_old_418071.awb")

						arg_24_1:RecordAudio("418071006", var_27_32)
						arg_24_1:RecordAudio("418071006", var_27_32)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071006", "story_v_side_old_418071.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071006", "story_v_side_old_418071.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_33 = math.max(var_27_24, arg_24_1.talkMaxDuration)

			if var_27_23 <= arg_24_1.time_ and arg_24_1.time_ < var_27_23 + var_27_33 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_23) / var_27_33

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_23 + var_27_33 and arg_24_1.time_ < var_27_23 + var_27_33 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play418071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 418071007
		arg_28_1.duration_ = 8.43

		local var_28_0 = {
			ja = 8.433,
			CriLanguages = 4.8,
			zh = 4.8
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play418071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1073"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps1073 == nil then
				arg_28_1.var_.actorSpriteComps1073 = var_31_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.actorSpriteComps1073 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_31_1 then
							if arg_28_1.isInRecall_ then
								local var_31_4 = Mathf.Lerp(iter_31_1.color.r, arg_28_1.hightColor1.r, var_31_3)
								local var_31_5 = Mathf.Lerp(iter_31_1.color.g, arg_28_1.hightColor1.g, var_31_3)
								local var_31_6 = Mathf.Lerp(iter_31_1.color.b, arg_28_1.hightColor1.b, var_31_3)

								iter_31_1.color = Color.New(var_31_4, var_31_5, var_31_6)
							else
								local var_31_7 = Mathf.Lerp(iter_31_1.color.r, 1, var_31_3)

								iter_31_1.color = Color.New(var_31_7, var_31_7, var_31_7)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps1073 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_31_3 then
						if arg_28_1.isInRecall_ then
							iter_31_3.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_31_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps1073 = nil
			end

			local var_31_8 = arg_28_1.actors_["10135"]
			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.actorSpriteComps10135 == nil then
				arg_28_1.var_.actorSpriteComps10135 = var_31_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_10 = 0.2

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 and not isNil(var_31_8) then
				local var_31_11 = (arg_28_1.time_ - var_31_9) / var_31_10

				if arg_28_1.var_.actorSpriteComps10135 then
					for iter_31_4, iter_31_5 in pairs(arg_28_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_31_5 then
							if arg_28_1.isInRecall_ then
								local var_31_12 = Mathf.Lerp(iter_31_5.color.r, arg_28_1.hightColor2.r, var_31_11)
								local var_31_13 = Mathf.Lerp(iter_31_5.color.g, arg_28_1.hightColor2.g, var_31_11)
								local var_31_14 = Mathf.Lerp(iter_31_5.color.b, arg_28_1.hightColor2.b, var_31_11)

								iter_31_5.color = Color.New(var_31_12, var_31_13, var_31_14)
							else
								local var_31_15 = Mathf.Lerp(iter_31_5.color.r, 0.5, var_31_11)

								iter_31_5.color = Color.New(var_31_15, var_31_15, var_31_15)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.actorSpriteComps10135 then
				for iter_31_6, iter_31_7 in pairs(arg_28_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_31_7 then
						if arg_28_1.isInRecall_ then
							iter_31_7.color = arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_31_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps10135 = nil
			end

			local var_31_16 = arg_28_1.actors_["1073"].transform
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				arg_28_1.var_.moveOldPos1073 = var_31_16.localPosition
				var_31_16.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("1073", 2)

				local var_31_18 = var_31_16.childCount

				for iter_31_8 = 0, var_31_18 - 1 do
					local var_31_19 = var_31_16:GetChild(iter_31_8)

					if var_31_19.name == "split_1" or not string.find(var_31_19.name, "split") then
						var_31_19.gameObject:SetActive(true)
					else
						var_31_19.gameObject:SetActive(false)
					end
				end
			end

			local var_31_20 = 0.001

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_20 then
				local var_31_21 = (arg_28_1.time_ - var_31_17) / var_31_20
				local var_31_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_31_16.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1073, var_31_22, var_31_21)
			end

			if arg_28_1.time_ >= var_31_17 + var_31_20 and arg_28_1.time_ < var_31_17 + var_31_20 + arg_31_0 then
				var_31_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_31_23 = 0
			local var_31_24 = 0.575

			if var_31_23 < arg_28_1.time_ and arg_28_1.time_ <= var_31_23 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_25 = arg_28_1:FormatText(StoryNameCfg[380].name)

				arg_28_1.leftNameTxt_.text = var_31_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_26 = arg_28_1:GetWordFromCfg(418071007)
				local var_31_27 = arg_28_1:FormatText(var_31_26.content)

				arg_28_1.text_.text = var_31_27

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_28 = 23
				local var_31_29 = utf8.len(var_31_27)
				local var_31_30 = var_31_28 <= 0 and var_31_24 or var_31_24 * (var_31_29 / var_31_28)

				if var_31_30 > 0 and var_31_24 < var_31_30 then
					arg_28_1.talkMaxDuration = var_31_30

					if var_31_30 + var_31_23 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_30 + var_31_23
					end
				end

				arg_28_1.text_.text = var_31_27
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071007", "story_v_side_old_418071.awb") ~= 0 then
					local var_31_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071007", "story_v_side_old_418071.awb") / 1000

					if var_31_31 + var_31_23 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_31 + var_31_23
					end

					if var_31_26.prefab_name ~= "" and arg_28_1.actors_[var_31_26.prefab_name] ~= nil then
						local var_31_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_26.prefab_name].transform, "story_v_side_old_418071", "418071007", "story_v_side_old_418071.awb")

						arg_28_1:RecordAudio("418071007", var_31_32)
						arg_28_1:RecordAudio("418071007", var_31_32)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071007", "story_v_side_old_418071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071007", "story_v_side_old_418071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_33 = math.max(var_31_24, arg_28_1.talkMaxDuration)

			if var_31_23 <= arg_28_1.time_ and arg_28_1.time_ < var_31_23 + var_31_33 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_23) / var_31_33

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_23 + var_31_33 and arg_28_1.time_ < var_31_23 + var_31_33 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play418071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 418071008
		arg_32_1.duration_ = 5.7

		local var_32_0 = {
			ja = 5.6,
			CriLanguages = 5.7,
			zh = 5.7
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play418071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10135"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10135 == nil then
				arg_32_1.var_.actorSpriteComps10135 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps10135 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								local var_35_4 = Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor1.r, var_35_3)
								local var_35_5 = Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor1.g, var_35_3)
								local var_35_6 = Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor1.b, var_35_3)

								iter_35_1.color = Color.New(var_35_4, var_35_5, var_35_6)
							else
								local var_35_7 = Mathf.Lerp(iter_35_1.color.r, 1, var_35_3)

								iter_35_1.color = Color.New(var_35_7, var_35_7, var_35_7)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10135 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_35_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps10135 = nil
			end

			local var_35_8 = arg_32_1.actors_["1073"]
			local var_35_9 = 0

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps1073 == nil then
				arg_32_1.var_.actorSpriteComps1073 = var_35_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_10 = 0.2

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_10 and not isNil(var_35_8) then
				local var_35_11 = (arg_32_1.time_ - var_35_9) / var_35_10

				if arg_32_1.var_.actorSpriteComps1073 then
					for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_35_5 then
							if arg_32_1.isInRecall_ then
								local var_35_12 = Mathf.Lerp(iter_35_5.color.r, arg_32_1.hightColor2.r, var_35_11)
								local var_35_13 = Mathf.Lerp(iter_35_5.color.g, arg_32_1.hightColor2.g, var_35_11)
								local var_35_14 = Mathf.Lerp(iter_35_5.color.b, arg_32_1.hightColor2.b, var_35_11)

								iter_35_5.color = Color.New(var_35_12, var_35_13, var_35_14)
							else
								local var_35_15 = Mathf.Lerp(iter_35_5.color.r, 0.5, var_35_11)

								iter_35_5.color = Color.New(var_35_15, var_35_15, var_35_15)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_9 + var_35_10 and arg_32_1.time_ < var_35_9 + var_35_10 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps1073 then
				for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_35_7 then
						if arg_32_1.isInRecall_ then
							iter_35_7.color = arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_35_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps1073 = nil
			end

			local var_35_16 = arg_32_1.actors_["10135"].transform
			local var_35_17 = 0

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 then
				arg_32_1.var_.moveOldPos10135 = var_35_16.localPosition
				var_35_16.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10135", 4)

				local var_35_18 = var_35_16.childCount

				for iter_35_8 = 0, var_35_18 - 1 do
					local var_35_19 = var_35_16:GetChild(iter_35_8)

					if var_35_19.name == "" or not string.find(var_35_19.name, "split") then
						var_35_19.gameObject:SetActive(true)
					else
						var_35_19.gameObject:SetActive(false)
					end
				end
			end

			local var_35_20 = 0.001

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_20 then
				local var_35_21 = (arg_32_1.time_ - var_35_17) / var_35_20
				local var_35_22 = Vector3.New(432.72, -363.6, -305.9)

				var_35_16.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10135, var_35_22, var_35_21)
			end

			if arg_32_1.time_ >= var_35_17 + var_35_20 and arg_32_1.time_ < var_35_17 + var_35_20 + arg_35_0 then
				var_35_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_35_23 = 0
			local var_35_24 = 0.525

			if var_35_23 < arg_32_1.time_ and arg_32_1.time_ <= var_35_23 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_25 = arg_32_1:FormatText(StoryNameCfg[1187].name)

				arg_32_1.leftNameTxt_.text = var_35_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_26 = arg_32_1:GetWordFromCfg(418071008)
				local var_35_27 = arg_32_1:FormatText(var_35_26.content)

				arg_32_1.text_.text = var_35_27

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_28 = 21
				local var_35_29 = utf8.len(var_35_27)
				local var_35_30 = var_35_28 <= 0 and var_35_24 or var_35_24 * (var_35_29 / var_35_28)

				if var_35_30 > 0 and var_35_24 < var_35_30 then
					arg_32_1.talkMaxDuration = var_35_30

					if var_35_30 + var_35_23 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_30 + var_35_23
					end
				end

				arg_32_1.text_.text = var_35_27
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071008", "story_v_side_old_418071.awb") ~= 0 then
					local var_35_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071008", "story_v_side_old_418071.awb") / 1000

					if var_35_31 + var_35_23 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_31 + var_35_23
					end

					if var_35_26.prefab_name ~= "" and arg_32_1.actors_[var_35_26.prefab_name] ~= nil then
						local var_35_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_26.prefab_name].transform, "story_v_side_old_418071", "418071008", "story_v_side_old_418071.awb")

						arg_32_1:RecordAudio("418071008", var_35_32)
						arg_32_1:RecordAudio("418071008", var_35_32)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071008", "story_v_side_old_418071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071008", "story_v_side_old_418071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_33 = math.max(var_35_24, arg_32_1.talkMaxDuration)

			if var_35_23 <= arg_32_1.time_ and arg_32_1.time_ < var_35_23 + var_35_33 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_23) / var_35_33

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_23 + var_35_33 and arg_32_1.time_ < var_35_23 + var_35_33 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play418071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 418071009
		arg_36_1.duration_ = 7.37

		local var_36_0 = {
			ja = 7.366,
			CriLanguages = 6.1,
			zh = 6.1
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play418071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1073"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps1073 == nil then
				arg_36_1.var_.actorSpriteComps1073 = var_39_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.actorSpriteComps1073 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_39_1 then
							if arg_36_1.isInRecall_ then
								local var_39_4 = Mathf.Lerp(iter_39_1.color.r, arg_36_1.hightColor1.r, var_39_3)
								local var_39_5 = Mathf.Lerp(iter_39_1.color.g, arg_36_1.hightColor1.g, var_39_3)
								local var_39_6 = Mathf.Lerp(iter_39_1.color.b, arg_36_1.hightColor1.b, var_39_3)

								iter_39_1.color = Color.New(var_39_4, var_39_5, var_39_6)
							else
								local var_39_7 = Mathf.Lerp(iter_39_1.color.r, 1, var_39_3)

								iter_39_1.color = Color.New(var_39_7, var_39_7, var_39_7)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps1073 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_39_3 then
						if arg_36_1.isInRecall_ then
							iter_39_3.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_39_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps1073 = nil
			end

			local var_39_8 = arg_36_1.actors_["10135"]
			local var_39_9 = 0

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps10135 == nil then
				arg_36_1.var_.actorSpriteComps10135 = var_39_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_10 = 0.2

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_10 and not isNil(var_39_8) then
				local var_39_11 = (arg_36_1.time_ - var_39_9) / var_39_10

				if arg_36_1.var_.actorSpriteComps10135 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_39_5 then
							if arg_36_1.isInRecall_ then
								local var_39_12 = Mathf.Lerp(iter_39_5.color.r, arg_36_1.hightColor2.r, var_39_11)
								local var_39_13 = Mathf.Lerp(iter_39_5.color.g, arg_36_1.hightColor2.g, var_39_11)
								local var_39_14 = Mathf.Lerp(iter_39_5.color.b, arg_36_1.hightColor2.b, var_39_11)

								iter_39_5.color = Color.New(var_39_12, var_39_13, var_39_14)
							else
								local var_39_15 = Mathf.Lerp(iter_39_5.color.r, 0.5, var_39_11)

								iter_39_5.color = Color.New(var_39_15, var_39_15, var_39_15)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_9 + var_39_10 and arg_36_1.time_ < var_39_9 + var_39_10 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps10135 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_39_7 then
						if arg_36_1.isInRecall_ then
							iter_39_7.color = arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_39_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps10135 = nil
			end

			local var_39_16 = arg_36_1.actors_["1073"].transform
			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.var_.moveOldPos1073 = var_39_16.localPosition
				var_39_16.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("1073", 2)

				local var_39_18 = var_39_16.childCount

				for iter_39_8 = 0, var_39_18 - 1 do
					local var_39_19 = var_39_16:GetChild(iter_39_8)

					if var_39_19.name == "" or not string.find(var_39_19.name, "split") then
						var_39_19.gameObject:SetActive(true)
					else
						var_39_19.gameObject:SetActive(false)
					end
				end
			end

			local var_39_20 = 0.001

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_20 then
				local var_39_21 = (arg_36_1.time_ - var_39_17) / var_39_20
				local var_39_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_39_16.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1073, var_39_22, var_39_21)
			end

			if arg_36_1.time_ >= var_39_17 + var_39_20 and arg_36_1.time_ < var_39_17 + var_39_20 + arg_39_0 then
				var_39_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_39_23 = 0
			local var_39_24 = 0.575

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_25 = arg_36_1:FormatText(StoryNameCfg[380].name)

				arg_36_1.leftNameTxt_.text = var_39_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_26 = arg_36_1:GetWordFromCfg(418071009)
				local var_39_27 = arg_36_1:FormatText(var_39_26.content)

				arg_36_1.text_.text = var_39_27

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_28 = 23
				local var_39_29 = utf8.len(var_39_27)
				local var_39_30 = var_39_28 <= 0 and var_39_24 or var_39_24 * (var_39_29 / var_39_28)

				if var_39_30 > 0 and var_39_24 < var_39_30 then
					arg_36_1.talkMaxDuration = var_39_30

					if var_39_30 + var_39_23 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_30 + var_39_23
					end
				end

				arg_36_1.text_.text = var_39_27
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071009", "story_v_side_old_418071.awb") ~= 0 then
					local var_39_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071009", "story_v_side_old_418071.awb") / 1000

					if var_39_31 + var_39_23 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_31 + var_39_23
					end

					if var_39_26.prefab_name ~= "" and arg_36_1.actors_[var_39_26.prefab_name] ~= nil then
						local var_39_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_26.prefab_name].transform, "story_v_side_old_418071", "418071009", "story_v_side_old_418071.awb")

						arg_36_1:RecordAudio("418071009", var_39_32)
						arg_36_1:RecordAudio("418071009", var_39_32)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071009", "story_v_side_old_418071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071009", "story_v_side_old_418071.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_33 = math.max(var_39_24, arg_36_1.talkMaxDuration)

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_33 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_23) / var_39_33

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_23 + var_39_33 and arg_36_1.time_ < var_39_23 + var_39_33 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play418071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 418071010
		arg_40_1.duration_ = 10.77

		local var_40_0 = {
			ja = 10.766,
			CriLanguages = 10,
			zh = 10
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play418071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10135"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10135 == nil then
				arg_40_1.var_.actorSpriteComps10135 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps10135 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								local var_43_4 = Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor1.r, var_43_3)
								local var_43_5 = Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor1.g, var_43_3)
								local var_43_6 = Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor1.b, var_43_3)

								iter_43_1.color = Color.New(var_43_4, var_43_5, var_43_6)
							else
								local var_43_7 = Mathf.Lerp(iter_43_1.color.r, 1, var_43_3)

								iter_43_1.color = Color.New(var_43_7, var_43_7, var_43_7)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10135 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps10135 = nil
			end

			local var_43_8 = arg_40_1.actors_["1073"]
			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps1073 == nil then
				arg_40_1.var_.actorSpriteComps1073 = var_43_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_10 = 0.2

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_10 and not isNil(var_43_8) then
				local var_43_11 = (arg_40_1.time_ - var_43_9) / var_43_10

				if arg_40_1.var_.actorSpriteComps1073 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_43_5 then
							if arg_40_1.isInRecall_ then
								local var_43_12 = Mathf.Lerp(iter_43_5.color.r, arg_40_1.hightColor2.r, var_43_11)
								local var_43_13 = Mathf.Lerp(iter_43_5.color.g, arg_40_1.hightColor2.g, var_43_11)
								local var_43_14 = Mathf.Lerp(iter_43_5.color.b, arg_40_1.hightColor2.b, var_43_11)

								iter_43_5.color = Color.New(var_43_12, var_43_13, var_43_14)
							else
								local var_43_15 = Mathf.Lerp(iter_43_5.color.r, 0.5, var_43_11)

								iter_43_5.color = Color.New(var_43_15, var_43_15, var_43_15)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_9 + var_43_10 and arg_40_1.time_ < var_43_9 + var_43_10 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps1073 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_43_7 then
						if arg_40_1.isInRecall_ then
							iter_43_7.color = arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_43_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps1073 = nil
			end

			local var_43_16 = arg_40_1.actors_["10135"].transform
			local var_43_17 = 0

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.var_.moveOldPos10135 = var_43_16.localPosition
				var_43_16.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10135", 4)

				local var_43_18 = var_43_16.childCount

				for iter_43_8 = 0, var_43_18 - 1 do
					local var_43_19 = var_43_16:GetChild(iter_43_8)

					if var_43_19.name == "split_2" or not string.find(var_43_19.name, "split") then
						var_43_19.gameObject:SetActive(true)
					else
						var_43_19.gameObject:SetActive(false)
					end
				end
			end

			local var_43_20 = 0.001

			if var_43_17 <= arg_40_1.time_ and arg_40_1.time_ < var_43_17 + var_43_20 then
				local var_43_21 = (arg_40_1.time_ - var_43_17) / var_43_20
				local var_43_22 = Vector3.New(432.72, -363.6, -305.9)

				var_43_16.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10135, var_43_22, var_43_21)
			end

			if arg_40_1.time_ >= var_43_17 + var_43_20 and arg_40_1.time_ < var_43_17 + var_43_20 + arg_43_0 then
				var_43_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_43_23 = 0
			local var_43_24 = 1.125

			if var_43_23 < arg_40_1.time_ and arg_40_1.time_ <= var_43_23 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_25 = arg_40_1:FormatText(StoryNameCfg[1187].name)

				arg_40_1.leftNameTxt_.text = var_43_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_26 = arg_40_1:GetWordFromCfg(418071010)
				local var_43_27 = arg_40_1:FormatText(var_43_26.content)

				arg_40_1.text_.text = var_43_27

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_28 = 45
				local var_43_29 = utf8.len(var_43_27)
				local var_43_30 = var_43_28 <= 0 and var_43_24 or var_43_24 * (var_43_29 / var_43_28)

				if var_43_30 > 0 and var_43_24 < var_43_30 then
					arg_40_1.talkMaxDuration = var_43_30

					if var_43_30 + var_43_23 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_30 + var_43_23
					end
				end

				arg_40_1.text_.text = var_43_27
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071010", "story_v_side_old_418071.awb") ~= 0 then
					local var_43_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071010", "story_v_side_old_418071.awb") / 1000

					if var_43_31 + var_43_23 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_31 + var_43_23
					end

					if var_43_26.prefab_name ~= "" and arg_40_1.actors_[var_43_26.prefab_name] ~= nil then
						local var_43_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_26.prefab_name].transform, "story_v_side_old_418071", "418071010", "story_v_side_old_418071.awb")

						arg_40_1:RecordAudio("418071010", var_43_32)
						arg_40_1:RecordAudio("418071010", var_43_32)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071010", "story_v_side_old_418071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071010", "story_v_side_old_418071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_33 = math.max(var_43_24, arg_40_1.talkMaxDuration)

			if var_43_23 <= arg_40_1.time_ and arg_40_1.time_ < var_43_23 + var_43_33 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_23) / var_43_33

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_23 + var_43_33 and arg_40_1.time_ < var_43_23 + var_43_33 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play418071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 418071011
		arg_44_1.duration_ = 7.93

		local var_44_0 = {
			ja = 7.933,
			CriLanguages = 6.6,
			zh = 6.6
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play418071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1073"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps1073 == nil then
				arg_44_1.var_.actorSpriteComps1073 = var_47_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.actorSpriteComps1073 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								local var_47_4 = Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor1.r, var_47_3)
								local var_47_5 = Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor1.g, var_47_3)
								local var_47_6 = Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor1.b, var_47_3)

								iter_47_1.color = Color.New(var_47_4, var_47_5, var_47_6)
							else
								local var_47_7 = Mathf.Lerp(iter_47_1.color.r, 1, var_47_3)

								iter_47_1.color = Color.New(var_47_7, var_47_7, var_47_7)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps1073 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_47_3 then
						if arg_44_1.isInRecall_ then
							iter_47_3.color = arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_47_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps1073 = nil
			end

			local var_47_8 = arg_44_1.actors_["10135"]
			local var_47_9 = 0

			if var_47_9 < arg_44_1.time_ and arg_44_1.time_ <= var_47_9 + arg_47_0 and not isNil(var_47_8) and arg_44_1.var_.actorSpriteComps10135 == nil then
				arg_44_1.var_.actorSpriteComps10135 = var_47_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_10 = 0.2

			if var_47_9 <= arg_44_1.time_ and arg_44_1.time_ < var_47_9 + var_47_10 and not isNil(var_47_8) then
				local var_47_11 = (arg_44_1.time_ - var_47_9) / var_47_10

				if arg_44_1.var_.actorSpriteComps10135 then
					for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_47_5 then
							if arg_44_1.isInRecall_ then
								local var_47_12 = Mathf.Lerp(iter_47_5.color.r, arg_44_1.hightColor2.r, var_47_11)
								local var_47_13 = Mathf.Lerp(iter_47_5.color.g, arg_44_1.hightColor2.g, var_47_11)
								local var_47_14 = Mathf.Lerp(iter_47_5.color.b, arg_44_1.hightColor2.b, var_47_11)

								iter_47_5.color = Color.New(var_47_12, var_47_13, var_47_14)
							else
								local var_47_15 = Mathf.Lerp(iter_47_5.color.r, 0.5, var_47_11)

								iter_47_5.color = Color.New(var_47_15, var_47_15, var_47_15)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_9 + var_47_10 and arg_44_1.time_ < var_47_9 + var_47_10 + arg_47_0 and not isNil(var_47_8) and arg_44_1.var_.actorSpriteComps10135 then
				for iter_47_6, iter_47_7 in pairs(arg_44_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_47_7 then
						if arg_44_1.isInRecall_ then
							iter_47_7.color = arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_47_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps10135 = nil
			end

			local var_47_16 = 0
			local var_47_17 = 0.775

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_18 = arg_44_1:FormatText(StoryNameCfg[380].name)

				arg_44_1.leftNameTxt_.text = var_47_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_19 = arg_44_1:GetWordFromCfg(418071011)
				local var_47_20 = arg_44_1:FormatText(var_47_19.content)

				arg_44_1.text_.text = var_47_20

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_21 = 31
				local var_47_22 = utf8.len(var_47_20)
				local var_47_23 = var_47_21 <= 0 and var_47_17 or var_47_17 * (var_47_22 / var_47_21)

				if var_47_23 > 0 and var_47_17 < var_47_23 then
					arg_44_1.talkMaxDuration = var_47_23

					if var_47_23 + var_47_16 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_16
					end
				end

				arg_44_1.text_.text = var_47_20
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071011", "story_v_side_old_418071.awb") ~= 0 then
					local var_47_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071011", "story_v_side_old_418071.awb") / 1000

					if var_47_24 + var_47_16 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_24 + var_47_16
					end

					if var_47_19.prefab_name ~= "" and arg_44_1.actors_[var_47_19.prefab_name] ~= nil then
						local var_47_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_19.prefab_name].transform, "story_v_side_old_418071", "418071011", "story_v_side_old_418071.awb")

						arg_44_1:RecordAudio("418071011", var_47_25)
						arg_44_1:RecordAudio("418071011", var_47_25)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071011", "story_v_side_old_418071.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071011", "story_v_side_old_418071.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_26 = math.max(var_47_17, arg_44_1.talkMaxDuration)

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_26 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_16) / var_47_26

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_16 + var_47_26 and arg_44_1.time_ < var_47_16 + var_47_26 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play418071012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 418071012
		arg_48_1.duration_ = 8.87

		local var_48_0 = {
			ja = 7.933,
			CriLanguages = 8.866,
			zh = 8.866
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play418071013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10135"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10135 == nil then
				arg_48_1.var_.actorSpriteComps10135 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps10135 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								local var_51_4 = Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor1.r, var_51_3)
								local var_51_5 = Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor1.g, var_51_3)
								local var_51_6 = Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor1.b, var_51_3)

								iter_51_1.color = Color.New(var_51_4, var_51_5, var_51_6)
							else
								local var_51_7 = Mathf.Lerp(iter_51_1.color.r, 1, var_51_3)

								iter_51_1.color = Color.New(var_51_7, var_51_7, var_51_7)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10135 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_51_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps10135 = nil
			end

			local var_51_8 = arg_48_1.actors_["1073"]
			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 and not isNil(var_51_8) and arg_48_1.var_.actorSpriteComps1073 == nil then
				arg_48_1.var_.actorSpriteComps1073 = var_51_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_10 = 0.2

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_10 and not isNil(var_51_8) then
				local var_51_11 = (arg_48_1.time_ - var_51_9) / var_51_10

				if arg_48_1.var_.actorSpriteComps1073 then
					for iter_51_4, iter_51_5 in pairs(arg_48_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_51_5 then
							if arg_48_1.isInRecall_ then
								local var_51_12 = Mathf.Lerp(iter_51_5.color.r, arg_48_1.hightColor2.r, var_51_11)
								local var_51_13 = Mathf.Lerp(iter_51_5.color.g, arg_48_1.hightColor2.g, var_51_11)
								local var_51_14 = Mathf.Lerp(iter_51_5.color.b, arg_48_1.hightColor2.b, var_51_11)

								iter_51_5.color = Color.New(var_51_12, var_51_13, var_51_14)
							else
								local var_51_15 = Mathf.Lerp(iter_51_5.color.r, 0.5, var_51_11)

								iter_51_5.color = Color.New(var_51_15, var_51_15, var_51_15)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_9 + var_51_10 and arg_48_1.time_ < var_51_9 + var_51_10 + arg_51_0 and not isNil(var_51_8) and arg_48_1.var_.actorSpriteComps1073 then
				for iter_51_6, iter_51_7 in pairs(arg_48_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_51_7 then
						if arg_48_1.isInRecall_ then
							iter_51_7.color = arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_51_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps1073 = nil
			end

			local var_51_16 = 0
			local var_51_17 = 1.1

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_18 = arg_48_1:FormatText(StoryNameCfg[1187].name)

				arg_48_1.leftNameTxt_.text = var_51_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_19 = arg_48_1:GetWordFromCfg(418071012)
				local var_51_20 = arg_48_1:FormatText(var_51_19.content)

				arg_48_1.text_.text = var_51_20

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_21 = 44
				local var_51_22 = utf8.len(var_51_20)
				local var_51_23 = var_51_21 <= 0 and var_51_17 or var_51_17 * (var_51_22 / var_51_21)

				if var_51_23 > 0 and var_51_17 < var_51_23 then
					arg_48_1.talkMaxDuration = var_51_23

					if var_51_23 + var_51_16 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_16
					end
				end

				arg_48_1.text_.text = var_51_20
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071012", "story_v_side_old_418071.awb") ~= 0 then
					local var_51_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071012", "story_v_side_old_418071.awb") / 1000

					if var_51_24 + var_51_16 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_24 + var_51_16
					end

					if var_51_19.prefab_name ~= "" and arg_48_1.actors_[var_51_19.prefab_name] ~= nil then
						local var_51_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_19.prefab_name].transform, "story_v_side_old_418071", "418071012", "story_v_side_old_418071.awb")

						arg_48_1:RecordAudio("418071012", var_51_25)
						arg_48_1:RecordAudio("418071012", var_51_25)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071012", "story_v_side_old_418071.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071012", "story_v_side_old_418071.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_26 = math.max(var_51_17, arg_48_1.talkMaxDuration)

			if var_51_16 <= arg_48_1.time_ and arg_48_1.time_ < var_51_16 + var_51_26 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_16) / var_51_26

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_16 + var_51_26 and arg_48_1.time_ < var_51_16 + var_51_26 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play418071013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 418071013
		arg_52_1.duration_ = 1.53

		local var_52_0 = {
			ja = 1.533,
			CriLanguages = 1.166,
			zh = 1.166
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play418071014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1073"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps1073 == nil then
				arg_52_1.var_.actorSpriteComps1073 = var_55_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.actorSpriteComps1073 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_55_1 then
							if arg_52_1.isInRecall_ then
								local var_55_4 = Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor1.r, var_55_3)
								local var_55_5 = Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor1.g, var_55_3)
								local var_55_6 = Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor1.b, var_55_3)

								iter_55_1.color = Color.New(var_55_4, var_55_5, var_55_6)
							else
								local var_55_7 = Mathf.Lerp(iter_55_1.color.r, 1, var_55_3)

								iter_55_1.color = Color.New(var_55_7, var_55_7, var_55_7)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps1073 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_55_3 then
						if arg_52_1.isInRecall_ then
							iter_55_3.color = arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_55_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps1073 = nil
			end

			local var_55_8 = arg_52_1.actors_["10135"]
			local var_55_9 = 0

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps10135 == nil then
				arg_52_1.var_.actorSpriteComps10135 = var_55_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_10 = 0.2

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_10 and not isNil(var_55_8) then
				local var_55_11 = (arg_52_1.time_ - var_55_9) / var_55_10

				if arg_52_1.var_.actorSpriteComps10135 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_55_5 then
							if arg_52_1.isInRecall_ then
								local var_55_12 = Mathf.Lerp(iter_55_5.color.r, arg_52_1.hightColor2.r, var_55_11)
								local var_55_13 = Mathf.Lerp(iter_55_5.color.g, arg_52_1.hightColor2.g, var_55_11)
								local var_55_14 = Mathf.Lerp(iter_55_5.color.b, arg_52_1.hightColor2.b, var_55_11)

								iter_55_5.color = Color.New(var_55_12, var_55_13, var_55_14)
							else
								local var_55_15 = Mathf.Lerp(iter_55_5.color.r, 0.5, var_55_11)

								iter_55_5.color = Color.New(var_55_15, var_55_15, var_55_15)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_9 + var_55_10 and arg_52_1.time_ < var_55_9 + var_55_10 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps10135 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_55_7 then
						if arg_52_1.isInRecall_ then
							iter_55_7.color = arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_55_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps10135 = nil
			end

			local var_55_16 = 0
			local var_55_17 = 0.1

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_18 = arg_52_1:FormatText(StoryNameCfg[380].name)

				arg_52_1.leftNameTxt_.text = var_55_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_19 = arg_52_1:GetWordFromCfg(418071013)
				local var_55_20 = arg_52_1:FormatText(var_55_19.content)

				arg_52_1.text_.text = var_55_20

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_21 = 4
				local var_55_22 = utf8.len(var_55_20)
				local var_55_23 = var_55_21 <= 0 and var_55_17 or var_55_17 * (var_55_22 / var_55_21)

				if var_55_23 > 0 and var_55_17 < var_55_23 then
					arg_52_1.talkMaxDuration = var_55_23

					if var_55_23 + var_55_16 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_16
					end
				end

				arg_52_1.text_.text = var_55_20
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071013", "story_v_side_old_418071.awb") ~= 0 then
					local var_55_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071013", "story_v_side_old_418071.awb") / 1000

					if var_55_24 + var_55_16 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_16
					end

					if var_55_19.prefab_name ~= "" and arg_52_1.actors_[var_55_19.prefab_name] ~= nil then
						local var_55_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_19.prefab_name].transform, "story_v_side_old_418071", "418071013", "story_v_side_old_418071.awb")

						arg_52_1:RecordAudio("418071013", var_55_25)
						arg_52_1:RecordAudio("418071013", var_55_25)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071013", "story_v_side_old_418071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071013", "story_v_side_old_418071.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_26 = math.max(var_55_17, arg_52_1.talkMaxDuration)

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_26 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_16) / var_55_26

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_16 + var_55_26 and arg_52_1.time_ < var_55_16 + var_55_26 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play418071014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 418071014
		arg_56_1.duration_ = 13.33

		local var_56_0 = {
			ja = 13.333,
			CriLanguages = 10.066,
			zh = 10.066
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play418071015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10135"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps10135 == nil then
				arg_56_1.var_.actorSpriteComps10135 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps10135 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								local var_59_4 = Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor1.r, var_59_3)
								local var_59_5 = Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor1.g, var_59_3)
								local var_59_6 = Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor1.b, var_59_3)

								iter_59_1.color = Color.New(var_59_4, var_59_5, var_59_6)
							else
								local var_59_7 = Mathf.Lerp(iter_59_1.color.r, 1, var_59_3)

								iter_59_1.color = Color.New(var_59_7, var_59_7, var_59_7)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps10135 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_59_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps10135 = nil
			end

			local var_59_8 = arg_56_1.actors_["1073"]
			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 and not isNil(var_59_8) and arg_56_1.var_.actorSpriteComps1073 == nil then
				arg_56_1.var_.actorSpriteComps1073 = var_59_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_10 = 0.2

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_10 and not isNil(var_59_8) then
				local var_59_11 = (arg_56_1.time_ - var_59_9) / var_59_10

				if arg_56_1.var_.actorSpriteComps1073 then
					for iter_59_4, iter_59_5 in pairs(arg_56_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_59_5 then
							if arg_56_1.isInRecall_ then
								local var_59_12 = Mathf.Lerp(iter_59_5.color.r, arg_56_1.hightColor2.r, var_59_11)
								local var_59_13 = Mathf.Lerp(iter_59_5.color.g, arg_56_1.hightColor2.g, var_59_11)
								local var_59_14 = Mathf.Lerp(iter_59_5.color.b, arg_56_1.hightColor2.b, var_59_11)

								iter_59_5.color = Color.New(var_59_12, var_59_13, var_59_14)
							else
								local var_59_15 = Mathf.Lerp(iter_59_5.color.r, 0.5, var_59_11)

								iter_59_5.color = Color.New(var_59_15, var_59_15, var_59_15)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_9 + var_59_10 and arg_56_1.time_ < var_59_9 + var_59_10 + arg_59_0 and not isNil(var_59_8) and arg_56_1.var_.actorSpriteComps1073 then
				for iter_59_6, iter_59_7 in pairs(arg_56_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_59_7 then
						if arg_56_1.isInRecall_ then
							iter_59_7.color = arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_59_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps1073 = nil
			end

			local var_59_16 = arg_56_1.actors_["10135"].transform
			local var_59_17 = 0

			if var_59_17 < arg_56_1.time_ and arg_56_1.time_ <= var_59_17 + arg_59_0 then
				arg_56_1.var_.moveOldPos10135 = var_59_16.localPosition
				var_59_16.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("10135", 4)

				local var_59_18 = var_59_16.childCount

				for iter_59_8 = 0, var_59_18 - 1 do
					local var_59_19 = var_59_16:GetChild(iter_59_8)

					if var_59_19.name == "" or not string.find(var_59_19.name, "split") then
						var_59_19.gameObject:SetActive(true)
					else
						var_59_19.gameObject:SetActive(false)
					end
				end
			end

			local var_59_20 = 0.001

			if var_59_17 <= arg_56_1.time_ and arg_56_1.time_ < var_59_17 + var_59_20 then
				local var_59_21 = (arg_56_1.time_ - var_59_17) / var_59_20
				local var_59_22 = Vector3.New(432.72, -363.6, -305.9)

				var_59_16.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10135, var_59_22, var_59_21)
			end

			if arg_56_1.time_ >= var_59_17 + var_59_20 and arg_56_1.time_ < var_59_17 + var_59_20 + arg_59_0 then
				var_59_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_59_23 = 0
			local var_59_24 = 1.25

			if var_59_23 < arg_56_1.time_ and arg_56_1.time_ <= var_59_23 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_25 = arg_56_1:FormatText(StoryNameCfg[1187].name)

				arg_56_1.leftNameTxt_.text = var_59_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_26 = arg_56_1:GetWordFromCfg(418071014)
				local var_59_27 = arg_56_1:FormatText(var_59_26.content)

				arg_56_1.text_.text = var_59_27

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_28 = 50
				local var_59_29 = utf8.len(var_59_27)
				local var_59_30 = var_59_28 <= 0 and var_59_24 or var_59_24 * (var_59_29 / var_59_28)

				if var_59_30 > 0 and var_59_24 < var_59_30 then
					arg_56_1.talkMaxDuration = var_59_30

					if var_59_30 + var_59_23 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_30 + var_59_23
					end
				end

				arg_56_1.text_.text = var_59_27
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071014", "story_v_side_old_418071.awb") ~= 0 then
					local var_59_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071014", "story_v_side_old_418071.awb") / 1000

					if var_59_31 + var_59_23 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_31 + var_59_23
					end

					if var_59_26.prefab_name ~= "" and arg_56_1.actors_[var_59_26.prefab_name] ~= nil then
						local var_59_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_26.prefab_name].transform, "story_v_side_old_418071", "418071014", "story_v_side_old_418071.awb")

						arg_56_1:RecordAudio("418071014", var_59_32)
						arg_56_1:RecordAudio("418071014", var_59_32)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071014", "story_v_side_old_418071.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071014", "story_v_side_old_418071.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_33 = math.max(var_59_24, arg_56_1.talkMaxDuration)

			if var_59_23 <= arg_56_1.time_ and arg_56_1.time_ < var_59_23 + var_59_33 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_23) / var_59_33

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_23 + var_59_33 and arg_56_1.time_ < var_59_23 + var_59_33 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
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
	Play418071015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 418071015
		arg_60_1.duration_ = 10.3

		local var_60_0 = {
			ja = 10.3,
			CriLanguages = 7.466,
			zh = 7.466
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play418071016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1073"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps1073 == nil then
				arg_60_1.var_.actorSpriteComps1073 = var_63_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.actorSpriteComps1073 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								local var_63_4 = Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor1.r, var_63_3)
								local var_63_5 = Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor1.g, var_63_3)
								local var_63_6 = Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor1.b, var_63_3)

								iter_63_1.color = Color.New(var_63_4, var_63_5, var_63_6)
							else
								local var_63_7 = Mathf.Lerp(iter_63_1.color.r, 1, var_63_3)

								iter_63_1.color = Color.New(var_63_7, var_63_7, var_63_7)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps1073 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_63_3 then
						if arg_60_1.isInRecall_ then
							iter_63_3.color = arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_63_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps1073 = nil
			end

			local var_63_8 = arg_60_1.actors_["10135"]
			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps10135 == nil then
				arg_60_1.var_.actorSpriteComps10135 = var_63_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_10 = 0.2

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 and not isNil(var_63_8) then
				local var_63_11 = (arg_60_1.time_ - var_63_9) / var_63_10

				if arg_60_1.var_.actorSpriteComps10135 then
					for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_63_5 then
							if arg_60_1.isInRecall_ then
								local var_63_12 = Mathf.Lerp(iter_63_5.color.r, arg_60_1.hightColor2.r, var_63_11)
								local var_63_13 = Mathf.Lerp(iter_63_5.color.g, arg_60_1.hightColor2.g, var_63_11)
								local var_63_14 = Mathf.Lerp(iter_63_5.color.b, arg_60_1.hightColor2.b, var_63_11)

								iter_63_5.color = Color.New(var_63_12, var_63_13, var_63_14)
							else
								local var_63_15 = Mathf.Lerp(iter_63_5.color.r, 0.5, var_63_11)

								iter_63_5.color = Color.New(var_63_15, var_63_15, var_63_15)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps10135 then
				for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_63_7 then
						if arg_60_1.isInRecall_ then
							iter_63_7.color = arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_63_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps10135 = nil
			end

			local var_63_16 = arg_60_1.actors_["1073"].transform
			local var_63_17 = 0

			if var_63_17 < arg_60_1.time_ and arg_60_1.time_ <= var_63_17 + arg_63_0 then
				arg_60_1.var_.moveOldPos1073 = var_63_16.localPosition
				var_63_16.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("1073", 2)

				local var_63_18 = var_63_16.childCount

				for iter_63_8 = 0, var_63_18 - 1 do
					local var_63_19 = var_63_16:GetChild(iter_63_8)

					if var_63_19.name == "" or not string.find(var_63_19.name, "split") then
						var_63_19.gameObject:SetActive(true)
					else
						var_63_19.gameObject:SetActive(false)
					end
				end
			end

			local var_63_20 = 0.001

			if var_63_17 <= arg_60_1.time_ and arg_60_1.time_ < var_63_17 + var_63_20 then
				local var_63_21 = (arg_60_1.time_ - var_63_17) / var_63_20
				local var_63_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_63_16.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1073, var_63_22, var_63_21)
			end

			if arg_60_1.time_ >= var_63_17 + var_63_20 and arg_60_1.time_ < var_63_17 + var_63_20 + arg_63_0 then
				var_63_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_63_23 = 0
			local var_63_24 = 0.975

			if var_63_23 < arg_60_1.time_ and arg_60_1.time_ <= var_63_23 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_25 = arg_60_1:FormatText(StoryNameCfg[380].name)

				arg_60_1.leftNameTxt_.text = var_63_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_26 = arg_60_1:GetWordFromCfg(418071015)
				local var_63_27 = arg_60_1:FormatText(var_63_26.content)

				arg_60_1.text_.text = var_63_27

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_28 = 39
				local var_63_29 = utf8.len(var_63_27)
				local var_63_30 = var_63_28 <= 0 and var_63_24 or var_63_24 * (var_63_29 / var_63_28)

				if var_63_30 > 0 and var_63_24 < var_63_30 then
					arg_60_1.talkMaxDuration = var_63_30

					if var_63_30 + var_63_23 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_30 + var_63_23
					end
				end

				arg_60_1.text_.text = var_63_27
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071015", "story_v_side_old_418071.awb") ~= 0 then
					local var_63_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071015", "story_v_side_old_418071.awb") / 1000

					if var_63_31 + var_63_23 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_31 + var_63_23
					end

					if var_63_26.prefab_name ~= "" and arg_60_1.actors_[var_63_26.prefab_name] ~= nil then
						local var_63_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_26.prefab_name].transform, "story_v_side_old_418071", "418071015", "story_v_side_old_418071.awb")

						arg_60_1:RecordAudio("418071015", var_63_32)
						arg_60_1:RecordAudio("418071015", var_63_32)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071015", "story_v_side_old_418071.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071015", "story_v_side_old_418071.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_33 = math.max(var_63_24, arg_60_1.talkMaxDuration)

			if var_63_23 <= arg_60_1.time_ and arg_60_1.time_ < var_63_23 + var_63_33 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_23) / var_63_33

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_23 + var_63_33 and arg_60_1.time_ < var_63_23 + var_63_33 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play418071016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 418071016
		arg_64_1.duration_ = 6.3

		local var_64_0 = {
			ja = 6.3,
			CriLanguages = 4.233,
			zh = 4.233
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play418071017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10135"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps10135 == nil then
				arg_64_1.var_.actorSpriteComps10135 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps10135 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								local var_67_4 = Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor1.r, var_67_3)
								local var_67_5 = Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor1.g, var_67_3)
								local var_67_6 = Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor1.b, var_67_3)

								iter_67_1.color = Color.New(var_67_4, var_67_5, var_67_6)
							else
								local var_67_7 = Mathf.Lerp(iter_67_1.color.r, 1, var_67_3)

								iter_67_1.color = Color.New(var_67_7, var_67_7, var_67_7)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps10135 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps10135 = nil
			end

			local var_67_8 = arg_64_1.actors_["1073"]
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps1073 == nil then
				arg_64_1.var_.actorSpriteComps1073 = var_67_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_10 = 0.2

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_10 and not isNil(var_67_8) then
				local var_67_11 = (arg_64_1.time_ - var_67_9) / var_67_10

				if arg_64_1.var_.actorSpriteComps1073 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_67_5 then
							if arg_64_1.isInRecall_ then
								local var_67_12 = Mathf.Lerp(iter_67_5.color.r, arg_64_1.hightColor2.r, var_67_11)
								local var_67_13 = Mathf.Lerp(iter_67_5.color.g, arg_64_1.hightColor2.g, var_67_11)
								local var_67_14 = Mathf.Lerp(iter_67_5.color.b, arg_64_1.hightColor2.b, var_67_11)

								iter_67_5.color = Color.New(var_67_12, var_67_13, var_67_14)
							else
								local var_67_15 = Mathf.Lerp(iter_67_5.color.r, 0.5, var_67_11)

								iter_67_5.color = Color.New(var_67_15, var_67_15, var_67_15)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_9 + var_67_10 and arg_64_1.time_ < var_67_9 + var_67_10 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps1073 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_67_7 then
						if arg_64_1.isInRecall_ then
							iter_67_7.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps1073 = nil
			end

			local var_67_16 = arg_64_1.actors_["10135"].transform
			local var_67_17 = 0

			if var_67_17 < arg_64_1.time_ and arg_64_1.time_ <= var_67_17 + arg_67_0 then
				arg_64_1.var_.moveOldPos10135 = var_67_16.localPosition
				var_67_16.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10135", 4)

				local var_67_18 = var_67_16.childCount

				for iter_67_8 = 0, var_67_18 - 1 do
					local var_67_19 = var_67_16:GetChild(iter_67_8)

					if var_67_19.name == "" or not string.find(var_67_19.name, "split") then
						var_67_19.gameObject:SetActive(true)
					else
						var_67_19.gameObject:SetActive(false)
					end
				end
			end

			local var_67_20 = 0.001

			if var_67_17 <= arg_64_1.time_ and arg_64_1.time_ < var_67_17 + var_67_20 then
				local var_67_21 = (arg_64_1.time_ - var_67_17) / var_67_20
				local var_67_22 = Vector3.New(432.72, -363.6, -305.9)

				var_67_16.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10135, var_67_22, var_67_21)
			end

			if arg_64_1.time_ >= var_67_17 + var_67_20 and arg_64_1.time_ < var_67_17 + var_67_20 + arg_67_0 then
				var_67_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_67_23 = 0
			local var_67_24 = 0.525

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_25 = arg_64_1:FormatText(StoryNameCfg[1187].name)

				arg_64_1.leftNameTxt_.text = var_67_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_26 = arg_64_1:GetWordFromCfg(418071016)
				local var_67_27 = arg_64_1:FormatText(var_67_26.content)

				arg_64_1.text_.text = var_67_27

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_28 = 21
				local var_67_29 = utf8.len(var_67_27)
				local var_67_30 = var_67_28 <= 0 and var_67_24 or var_67_24 * (var_67_29 / var_67_28)

				if var_67_30 > 0 and var_67_24 < var_67_30 then
					arg_64_1.talkMaxDuration = var_67_30

					if var_67_30 + var_67_23 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_30 + var_67_23
					end
				end

				arg_64_1.text_.text = var_67_27
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071016", "story_v_side_old_418071.awb") ~= 0 then
					local var_67_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071016", "story_v_side_old_418071.awb") / 1000

					if var_67_31 + var_67_23 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_31 + var_67_23
					end

					if var_67_26.prefab_name ~= "" and arg_64_1.actors_[var_67_26.prefab_name] ~= nil then
						local var_67_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_26.prefab_name].transform, "story_v_side_old_418071", "418071016", "story_v_side_old_418071.awb")

						arg_64_1:RecordAudio("418071016", var_67_32)
						arg_64_1:RecordAudio("418071016", var_67_32)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071016", "story_v_side_old_418071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071016", "story_v_side_old_418071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_33 = math.max(var_67_24, arg_64_1.talkMaxDuration)

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_33 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_23) / var_67_33

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_23 + var_67_33 and arg_64_1.time_ < var_67_23 + var_67_33 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play418071017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 418071017
		arg_68_1.duration_ = 16.2

		local var_68_0 = {
			ja = 16.2,
			CriLanguages = 11.666,
			zh = 11.666
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
				arg_68_0:Play418071018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1073"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps1073 == nil then
				arg_68_1.var_.actorSpriteComps1073 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps1073 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps1073 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_71_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps1073 = nil
			end

			local var_71_8 = arg_68_1.actors_["10135"]
			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 and not isNil(var_71_8) and arg_68_1.var_.actorSpriteComps10135 == nil then
				arg_68_1.var_.actorSpriteComps10135 = var_71_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_10 = 0.2

			if var_71_9 <= arg_68_1.time_ and arg_68_1.time_ < var_71_9 + var_71_10 and not isNil(var_71_8) then
				local var_71_11 = (arg_68_1.time_ - var_71_9) / var_71_10

				if arg_68_1.var_.actorSpriteComps10135 then
					for iter_71_4, iter_71_5 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_71_5 then
							if arg_68_1.isInRecall_ then
								local var_71_12 = Mathf.Lerp(iter_71_5.color.r, arg_68_1.hightColor2.r, var_71_11)
								local var_71_13 = Mathf.Lerp(iter_71_5.color.g, arg_68_1.hightColor2.g, var_71_11)
								local var_71_14 = Mathf.Lerp(iter_71_5.color.b, arg_68_1.hightColor2.b, var_71_11)

								iter_71_5.color = Color.New(var_71_12, var_71_13, var_71_14)
							else
								local var_71_15 = Mathf.Lerp(iter_71_5.color.r, 0.5, var_71_11)

								iter_71_5.color = Color.New(var_71_15, var_71_15, var_71_15)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= var_71_9 + var_71_10 and arg_68_1.time_ < var_71_9 + var_71_10 + arg_71_0 and not isNil(var_71_8) and arg_68_1.var_.actorSpriteComps10135 then
				for iter_71_6, iter_71_7 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_71_7 then
						if arg_68_1.isInRecall_ then
							iter_71_7.color = arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_71_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps10135 = nil
			end

			local var_71_16 = arg_68_1.actors_["1073"].transform
			local var_71_17 = 0

			if var_71_17 < arg_68_1.time_ and arg_68_1.time_ <= var_71_17 + arg_71_0 then
				arg_68_1.var_.moveOldPos1073 = var_71_16.localPosition
				var_71_16.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("1073", 2)

				local var_71_18 = var_71_16.childCount

				for iter_71_8 = 0, var_71_18 - 1 do
					local var_71_19 = var_71_16:GetChild(iter_71_8)

					if var_71_19.name == "split_5" or not string.find(var_71_19.name, "split") then
						var_71_19.gameObject:SetActive(true)
					else
						var_71_19.gameObject:SetActive(false)
					end
				end
			end

			local var_71_20 = 0.001

			if var_71_17 <= arg_68_1.time_ and arg_68_1.time_ < var_71_17 + var_71_20 then
				local var_71_21 = (arg_68_1.time_ - var_71_17) / var_71_20
				local var_71_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_71_16.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1073, var_71_22, var_71_21)
			end

			if arg_68_1.time_ >= var_71_17 + var_71_20 and arg_68_1.time_ < var_71_17 + var_71_20 + arg_71_0 then
				var_71_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_71_23 = 0
			local var_71_24 = 1.4

			if var_71_23 < arg_68_1.time_ and arg_68_1.time_ <= var_71_23 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_25 = arg_68_1:FormatText(StoryNameCfg[380].name)

				arg_68_1.leftNameTxt_.text = var_71_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_26 = arg_68_1:GetWordFromCfg(418071017)
				local var_71_27 = arg_68_1:FormatText(var_71_26.content)

				arg_68_1.text_.text = var_71_27

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_28 = 56
				local var_71_29 = utf8.len(var_71_27)
				local var_71_30 = var_71_28 <= 0 and var_71_24 or var_71_24 * (var_71_29 / var_71_28)

				if var_71_30 > 0 and var_71_24 < var_71_30 then
					arg_68_1.talkMaxDuration = var_71_30

					if var_71_30 + var_71_23 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_30 + var_71_23
					end
				end

				arg_68_1.text_.text = var_71_27
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071017", "story_v_side_old_418071.awb") ~= 0 then
					local var_71_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071017", "story_v_side_old_418071.awb") / 1000

					if var_71_31 + var_71_23 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_31 + var_71_23
					end

					if var_71_26.prefab_name ~= "" and arg_68_1.actors_[var_71_26.prefab_name] ~= nil then
						local var_71_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_26.prefab_name].transform, "story_v_side_old_418071", "418071017", "story_v_side_old_418071.awb")

						arg_68_1:RecordAudio("418071017", var_71_32)
						arg_68_1:RecordAudio("418071017", var_71_32)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071017", "story_v_side_old_418071.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071017", "story_v_side_old_418071.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_33 = math.max(var_71_24, arg_68_1.talkMaxDuration)

			if var_71_23 <= arg_68_1.time_ and arg_68_1.time_ < var_71_23 + var_71_33 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_23) / var_71_33

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_23 + var_71_33 and arg_68_1.time_ < var_71_23 + var_71_33 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
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
	Play418071018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 418071018
		arg_72_1.duration_ = 19.07

		local var_72_0 = {
			ja = 19.066,
			CriLanguages = 17.566,
			zh = 17.566
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
				arg_72_0:Play418071019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 2.125

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[380].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(418071018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 85
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071018", "story_v_side_old_418071.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071018", "story_v_side_old_418071.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_side_old_418071", "418071018", "story_v_side_old_418071.awb")

						arg_72_1:RecordAudio("418071018", var_75_9)
						arg_72_1:RecordAudio("418071018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071018", "story_v_side_old_418071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071018", "story_v_side_old_418071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play418071019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 418071019
		arg_76_1.duration_ = 14.23

		local var_76_0 = {
			ja = 14.233,
			CriLanguages = 13.933,
			zh = 13.933
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
				arg_76_0:Play418071020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1073"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos1073 = var_79_0.localPosition
				var_79_0.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1073", 2)

				local var_79_2 = var_79_0.childCount

				for iter_79_0 = 0, var_79_2 - 1 do
					local var_79_3 = var_79_0:GetChild(iter_79_0)

					if var_79_3.name == "" or not string.find(var_79_3.name, "split") then
						var_79_3.gameObject:SetActive(true)
					else
						var_79_3.gameObject:SetActive(false)
					end
				end
			end

			local var_79_4 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_4 then
				local var_79_5 = (arg_76_1.time_ - var_79_1) / var_79_4
				local var_79_6 = Vector3.New(-405.76, -414.5, -207.2)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1073, var_79_6, var_79_5)
			end

			if arg_76_1.time_ >= var_79_1 + var_79_4 and arg_76_1.time_ < var_79_1 + var_79_4 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_79_7 = 0
			local var_79_8 = 1.7

			if var_79_7 < arg_76_1.time_ and arg_76_1.time_ <= var_79_7 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_9 = arg_76_1:FormatText(StoryNameCfg[380].name)

				arg_76_1.leftNameTxt_.text = var_79_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_10 = arg_76_1:GetWordFromCfg(418071019)
				local var_79_11 = arg_76_1:FormatText(var_79_10.content)

				arg_76_1.text_.text = var_79_11

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_12 = 68
				local var_79_13 = utf8.len(var_79_11)
				local var_79_14 = var_79_12 <= 0 and var_79_8 or var_79_8 * (var_79_13 / var_79_12)

				if var_79_14 > 0 and var_79_8 < var_79_14 then
					arg_76_1.talkMaxDuration = var_79_14

					if var_79_14 + var_79_7 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_7
					end
				end

				arg_76_1.text_.text = var_79_11
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071019", "story_v_side_old_418071.awb") ~= 0 then
					local var_79_15 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071019", "story_v_side_old_418071.awb") / 1000

					if var_79_15 + var_79_7 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_15 + var_79_7
					end

					if var_79_10.prefab_name ~= "" and arg_76_1.actors_[var_79_10.prefab_name] ~= nil then
						local var_79_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_10.prefab_name].transform, "story_v_side_old_418071", "418071019", "story_v_side_old_418071.awb")

						arg_76_1:RecordAudio("418071019", var_79_16)
						arg_76_1:RecordAudio("418071019", var_79_16)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071019", "story_v_side_old_418071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071019", "story_v_side_old_418071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_17 = math.max(var_79_8, arg_76_1.talkMaxDuration)

			if var_79_7 <= arg_76_1.time_ and arg_76_1.time_ < var_79_7 + var_79_17 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_7) / var_79_17

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_7 + var_79_17 and arg_76_1.time_ < var_79_7 + var_79_17 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
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
	Play418071020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 418071020
		arg_80_1.duration_ = 3.27

		local var_80_0 = {
			ja = 3,
			CriLanguages = 3.266,
			zh = 3.266
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
				arg_80_0:Play418071021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10135"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps10135 == nil then
				arg_80_1.var_.actorSpriteComps10135 = var_83_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.actorSpriteComps10135 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps10135 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_83_3 then
						if arg_80_1.isInRecall_ then
							iter_83_3.color = arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_83_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps10135 = nil
			end

			local var_83_8 = arg_80_1.actors_["1073"]
			local var_83_9 = 0

			if var_83_9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps1073 == nil then
				arg_80_1.var_.actorSpriteComps1073 = var_83_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_10 = 0.2

			if var_83_9 <= arg_80_1.time_ and arg_80_1.time_ < var_83_9 + var_83_10 and not isNil(var_83_8) then
				local var_83_11 = (arg_80_1.time_ - var_83_9) / var_83_10

				if arg_80_1.var_.actorSpriteComps1073 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_80_1.time_ >= var_83_9 + var_83_10 and arg_80_1.time_ < var_83_9 + var_83_10 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps1073 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_83_7 then
						if arg_80_1.isInRecall_ then
							iter_83_7.color = arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_83_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps1073 = nil
			end

			local var_83_16 = arg_80_1.actors_["10135"].transform
			local var_83_17 = 0

			if var_83_17 < arg_80_1.time_ and arg_80_1.time_ <= var_83_17 + arg_83_0 then
				arg_80_1.var_.moveOldPos10135 = var_83_16.localPosition
				var_83_16.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("10135", 4)

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
				local var_83_22 = Vector3.New(432.72, -363.6, -305.9)

				var_83_16.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10135, var_83_22, var_83_21)
			end

			if arg_80_1.time_ >= var_83_17 + var_83_20 and arg_80_1.time_ < var_83_17 + var_83_20 + arg_83_0 then
				var_83_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_83_23 = 0
			local var_83_24 = 0.375

			if var_83_23 < arg_80_1.time_ and arg_80_1.time_ <= var_83_23 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_25 = arg_80_1:FormatText(StoryNameCfg[1187].name)

				arg_80_1.leftNameTxt_.text = var_83_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_26 = arg_80_1:GetWordFromCfg(418071020)
				local var_83_27 = arg_80_1:FormatText(var_83_26.content)

				arg_80_1.text_.text = var_83_27

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_28 = 15
				local var_83_29 = utf8.len(var_83_27)
				local var_83_30 = var_83_28 <= 0 and var_83_24 or var_83_24 * (var_83_29 / var_83_28)

				if var_83_30 > 0 and var_83_24 < var_83_30 then
					arg_80_1.talkMaxDuration = var_83_30

					if var_83_30 + var_83_23 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_30 + var_83_23
					end
				end

				arg_80_1.text_.text = var_83_27
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071020", "story_v_side_old_418071.awb") ~= 0 then
					local var_83_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071020", "story_v_side_old_418071.awb") / 1000

					if var_83_31 + var_83_23 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_31 + var_83_23
					end

					if var_83_26.prefab_name ~= "" and arg_80_1.actors_[var_83_26.prefab_name] ~= nil then
						local var_83_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_26.prefab_name].transform, "story_v_side_old_418071", "418071020", "story_v_side_old_418071.awb")

						arg_80_1:RecordAudio("418071020", var_83_32)
						arg_80_1:RecordAudio("418071020", var_83_32)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071020", "story_v_side_old_418071.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071020", "story_v_side_old_418071.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_33 = math.max(var_83_24, arg_80_1.talkMaxDuration)

			if var_83_23 <= arg_80_1.time_ and arg_80_1.time_ < var_83_23 + var_83_33 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_23) / var_83_33

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_23 + var_83_33 and arg_80_1.time_ < var_83_23 + var_83_33 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
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
	Play418071021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 418071021
		arg_84_1.duration_ = 12.97

		local var_84_0 = {
			ja = 12.966,
			CriLanguages = 10.366,
			zh = 10.366
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
				arg_84_0:Play418071022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1073"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps1073 == nil then
				arg_84_1.var_.actorSpriteComps1073 = var_87_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.actorSpriteComps1073 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								local var_87_4 = Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor1.r, var_87_3)
								local var_87_5 = Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor1.g, var_87_3)
								local var_87_6 = Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor1.b, var_87_3)

								iter_87_1.color = Color.New(var_87_4, var_87_5, var_87_6)
							else
								local var_87_7 = Mathf.Lerp(iter_87_1.color.r, 1, var_87_3)

								iter_87_1.color = Color.New(var_87_7, var_87_7, var_87_7)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps1073 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_87_3 then
						if arg_84_1.isInRecall_ then
							iter_87_3.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_87_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps1073 = nil
			end

			local var_87_8 = arg_84_1.actors_["10135"]
			local var_87_9 = 0

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.actorSpriteComps10135 == nil then
				arg_84_1.var_.actorSpriteComps10135 = var_87_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_10 = 0.2

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_10 and not isNil(var_87_8) then
				local var_87_11 = (arg_84_1.time_ - var_87_9) / var_87_10

				if arg_84_1.var_.actorSpriteComps10135 then
					for iter_87_4, iter_87_5 in pairs(arg_84_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_87_5 then
							if arg_84_1.isInRecall_ then
								local var_87_12 = Mathf.Lerp(iter_87_5.color.r, arg_84_1.hightColor2.r, var_87_11)
								local var_87_13 = Mathf.Lerp(iter_87_5.color.g, arg_84_1.hightColor2.g, var_87_11)
								local var_87_14 = Mathf.Lerp(iter_87_5.color.b, arg_84_1.hightColor2.b, var_87_11)

								iter_87_5.color = Color.New(var_87_12, var_87_13, var_87_14)
							else
								local var_87_15 = Mathf.Lerp(iter_87_5.color.r, 0.5, var_87_11)

								iter_87_5.color = Color.New(var_87_15, var_87_15, var_87_15)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_9 + var_87_10 and arg_84_1.time_ < var_87_9 + var_87_10 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.actorSpriteComps10135 then
				for iter_87_6, iter_87_7 in pairs(arg_84_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_87_7 then
						if arg_84_1.isInRecall_ then
							iter_87_7.color = arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_87_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps10135 = nil
			end

			local var_87_16 = 0
			local var_87_17 = 1.275

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_18 = arg_84_1:FormatText(StoryNameCfg[380].name)

				arg_84_1.leftNameTxt_.text = var_87_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_19 = arg_84_1:GetWordFromCfg(418071021)
				local var_87_20 = arg_84_1:FormatText(var_87_19.content)

				arg_84_1.text_.text = var_87_20

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_21 = 51
				local var_87_22 = utf8.len(var_87_20)
				local var_87_23 = var_87_21 <= 0 and var_87_17 or var_87_17 * (var_87_22 / var_87_21)

				if var_87_23 > 0 and var_87_17 < var_87_23 then
					arg_84_1.talkMaxDuration = var_87_23

					if var_87_23 + var_87_16 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_16
					end
				end

				arg_84_1.text_.text = var_87_20
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071021", "story_v_side_old_418071.awb") ~= 0 then
					local var_87_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071021", "story_v_side_old_418071.awb") / 1000

					if var_87_24 + var_87_16 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_24 + var_87_16
					end

					if var_87_19.prefab_name ~= "" and arg_84_1.actors_[var_87_19.prefab_name] ~= nil then
						local var_87_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_19.prefab_name].transform, "story_v_side_old_418071", "418071021", "story_v_side_old_418071.awb")

						arg_84_1:RecordAudio("418071021", var_87_25)
						arg_84_1:RecordAudio("418071021", var_87_25)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071021", "story_v_side_old_418071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071021", "story_v_side_old_418071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_26 = math.max(var_87_17, arg_84_1.talkMaxDuration)

			if var_87_16 <= arg_84_1.time_ and arg_84_1.time_ < var_87_16 + var_87_26 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_16) / var_87_26

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_16 + var_87_26 and arg_84_1.time_ < var_87_16 + var_87_26 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play418071022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 418071022
		arg_88_1.duration_ = 14.23

		local var_88_0 = {
			ja = 14.233,
			CriLanguages = 10.1,
			zh = 10.1
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
				arg_88_0:Play418071023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1.35

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[380].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_3 = arg_88_1:GetWordFromCfg(418071022)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 54
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071022", "story_v_side_old_418071.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071022", "story_v_side_old_418071.awb") / 1000

					if var_91_8 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_0
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_side_old_418071", "418071022", "story_v_side_old_418071.awb")

						arg_88_1:RecordAudio("418071022", var_91_9)
						arg_88_1:RecordAudio("418071022", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071022", "story_v_side_old_418071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071022", "story_v_side_old_418071.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_10 and arg_88_1.time_ < var_91_0 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play418071023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 418071023
		arg_92_1.duration_ = 4.73

		local var_92_0 = {
			ja = 4.2,
			CriLanguages = 4.733,
			zh = 4.733
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
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play418071024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10135"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10135 == nil then
				arg_92_1.var_.actorSpriteComps10135 = var_95_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.actorSpriteComps10135 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								local var_95_4 = Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor1.r, var_95_3)
								local var_95_5 = Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor1.g, var_95_3)
								local var_95_6 = Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor1.b, var_95_3)

								iter_95_1.color = Color.New(var_95_4, var_95_5, var_95_6)
							else
								local var_95_7 = Mathf.Lerp(iter_95_1.color.r, 1, var_95_3)

								iter_95_1.color = Color.New(var_95_7, var_95_7, var_95_7)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10135 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_95_3 then
						if arg_92_1.isInRecall_ then
							iter_95_3.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_95_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps10135 = nil
			end

			local var_95_8 = arg_92_1.actors_["1073"]
			local var_95_9 = 0

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 and not isNil(var_95_8) and arg_92_1.var_.actorSpriteComps1073 == nil then
				arg_92_1.var_.actorSpriteComps1073 = var_95_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_10 = 0.2

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_10 and not isNil(var_95_8) then
				local var_95_11 = (arg_92_1.time_ - var_95_9) / var_95_10

				if arg_92_1.var_.actorSpriteComps1073 then
					for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_95_5 then
							if arg_92_1.isInRecall_ then
								local var_95_12 = Mathf.Lerp(iter_95_5.color.r, arg_92_1.hightColor2.r, var_95_11)
								local var_95_13 = Mathf.Lerp(iter_95_5.color.g, arg_92_1.hightColor2.g, var_95_11)
								local var_95_14 = Mathf.Lerp(iter_95_5.color.b, arg_92_1.hightColor2.b, var_95_11)

								iter_95_5.color = Color.New(var_95_12, var_95_13, var_95_14)
							else
								local var_95_15 = Mathf.Lerp(iter_95_5.color.r, 0.5, var_95_11)

								iter_95_5.color = Color.New(var_95_15, var_95_15, var_95_15)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_9 + var_95_10 and arg_92_1.time_ < var_95_9 + var_95_10 + arg_95_0 and not isNil(var_95_8) and arg_92_1.var_.actorSpriteComps1073 then
				for iter_95_6, iter_95_7 in pairs(arg_92_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_95_7 then
						if arg_92_1.isInRecall_ then
							iter_95_7.color = arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_95_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps1073 = nil
			end

			local var_95_16 = arg_92_1.actors_["10135"].transform
			local var_95_17 = 0

			if var_95_17 < arg_92_1.time_ and arg_92_1.time_ <= var_95_17 + arg_95_0 then
				arg_92_1.var_.moveOldPos10135 = var_95_16.localPosition
				var_95_16.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10135", 4)

				local var_95_18 = var_95_16.childCount

				for iter_95_8 = 0, var_95_18 - 1 do
					local var_95_19 = var_95_16:GetChild(iter_95_8)

					if var_95_19.name == "" or not string.find(var_95_19.name, "split") then
						var_95_19.gameObject:SetActive(true)
					else
						var_95_19.gameObject:SetActive(false)
					end
				end
			end

			local var_95_20 = 0.001

			if var_95_17 <= arg_92_1.time_ and arg_92_1.time_ < var_95_17 + var_95_20 then
				local var_95_21 = (arg_92_1.time_ - var_95_17) / var_95_20
				local var_95_22 = Vector3.New(432.72, -363.6, -305.9)

				var_95_16.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10135, var_95_22, var_95_21)
			end

			if arg_92_1.time_ >= var_95_17 + var_95_20 and arg_92_1.time_ < var_95_17 + var_95_20 + arg_95_0 then
				var_95_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_95_23 = 0
			local var_95_24 = 0.625

			if var_95_23 < arg_92_1.time_ and arg_92_1.time_ <= var_95_23 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_25 = arg_92_1:FormatText(StoryNameCfg[1187].name)

				arg_92_1.leftNameTxt_.text = var_95_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_26 = arg_92_1:GetWordFromCfg(418071023)
				local var_95_27 = arg_92_1:FormatText(var_95_26.content)

				arg_92_1.text_.text = var_95_27

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_28 = 25
				local var_95_29 = utf8.len(var_95_27)
				local var_95_30 = var_95_28 <= 0 and var_95_24 or var_95_24 * (var_95_29 / var_95_28)

				if var_95_30 > 0 and var_95_24 < var_95_30 then
					arg_92_1.talkMaxDuration = var_95_30

					if var_95_30 + var_95_23 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_30 + var_95_23
					end
				end

				arg_92_1.text_.text = var_95_27
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071023", "story_v_side_old_418071.awb") ~= 0 then
					local var_95_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071023", "story_v_side_old_418071.awb") / 1000

					if var_95_31 + var_95_23 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_31 + var_95_23
					end

					if var_95_26.prefab_name ~= "" and arg_92_1.actors_[var_95_26.prefab_name] ~= nil then
						local var_95_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_26.prefab_name].transform, "story_v_side_old_418071", "418071023", "story_v_side_old_418071.awb")

						arg_92_1:RecordAudio("418071023", var_95_32)
						arg_92_1:RecordAudio("418071023", var_95_32)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071023", "story_v_side_old_418071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071023", "story_v_side_old_418071.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_33 = math.max(var_95_24, arg_92_1.talkMaxDuration)

			if var_95_23 <= arg_92_1.time_ and arg_92_1.time_ < var_95_23 + var_95_33 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_23) / var_95_33

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_23 + var_95_33 and arg_92_1.time_ < var_95_23 + var_95_33 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play418071024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 418071024
		arg_96_1.duration_ = 15.97

		local var_96_0 = {
			ja = 15.966,
			CriLanguages = 12.566,
			zh = 12.566
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play418071025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1073"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps1073 == nil then
				arg_96_1.var_.actorSpriteComps1073 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps1073 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								local var_99_4 = Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor1.r, var_99_3)
								local var_99_5 = Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor1.g, var_99_3)
								local var_99_6 = Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor1.b, var_99_3)

								iter_99_1.color = Color.New(var_99_4, var_99_5, var_99_6)
							else
								local var_99_7 = Mathf.Lerp(iter_99_1.color.r, 1, var_99_3)

								iter_99_1.color = Color.New(var_99_7, var_99_7, var_99_7)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps1073 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_99_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps1073 = nil
			end

			local var_99_8 = arg_96_1.actors_["10135"]
			local var_99_9 = 0

			if var_99_9 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 and not isNil(var_99_8) and arg_96_1.var_.actorSpriteComps10135 == nil then
				arg_96_1.var_.actorSpriteComps10135 = var_99_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_10 = 0.2

			if var_99_9 <= arg_96_1.time_ and arg_96_1.time_ < var_99_9 + var_99_10 and not isNil(var_99_8) then
				local var_99_11 = (arg_96_1.time_ - var_99_9) / var_99_10

				if arg_96_1.var_.actorSpriteComps10135 then
					for iter_99_4, iter_99_5 in pairs(arg_96_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_99_5 then
							if arg_96_1.isInRecall_ then
								local var_99_12 = Mathf.Lerp(iter_99_5.color.r, arg_96_1.hightColor2.r, var_99_11)
								local var_99_13 = Mathf.Lerp(iter_99_5.color.g, arg_96_1.hightColor2.g, var_99_11)
								local var_99_14 = Mathf.Lerp(iter_99_5.color.b, arg_96_1.hightColor2.b, var_99_11)

								iter_99_5.color = Color.New(var_99_12, var_99_13, var_99_14)
							else
								local var_99_15 = Mathf.Lerp(iter_99_5.color.r, 0.5, var_99_11)

								iter_99_5.color = Color.New(var_99_15, var_99_15, var_99_15)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_9 + var_99_10 and arg_96_1.time_ < var_99_9 + var_99_10 + arg_99_0 and not isNil(var_99_8) and arg_96_1.var_.actorSpriteComps10135 then
				for iter_99_6, iter_99_7 in pairs(arg_96_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_99_7 then
						if arg_96_1.isInRecall_ then
							iter_99_7.color = arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_99_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps10135 = nil
			end

			local var_99_16 = arg_96_1.actors_["1073"].transform
			local var_99_17 = 0

			if var_99_17 < arg_96_1.time_ and arg_96_1.time_ <= var_99_17 + arg_99_0 then
				arg_96_1.var_.moveOldPos1073 = var_99_16.localPosition
				var_99_16.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1073", 2)

				local var_99_18 = var_99_16.childCount

				for iter_99_8 = 0, var_99_18 - 1 do
					local var_99_19 = var_99_16:GetChild(iter_99_8)

					if var_99_19.name == "split_4" or not string.find(var_99_19.name, "split") then
						var_99_19.gameObject:SetActive(true)
					else
						var_99_19.gameObject:SetActive(false)
					end
				end
			end

			local var_99_20 = 0.001

			if var_99_17 <= arg_96_1.time_ and arg_96_1.time_ < var_99_17 + var_99_20 then
				local var_99_21 = (arg_96_1.time_ - var_99_17) / var_99_20
				local var_99_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_99_16.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1073, var_99_22, var_99_21)
			end

			if arg_96_1.time_ >= var_99_17 + var_99_20 and arg_96_1.time_ < var_99_17 + var_99_20 + arg_99_0 then
				var_99_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_99_23 = 0
			local var_99_24 = 1.425

			if var_99_23 < arg_96_1.time_ and arg_96_1.time_ <= var_99_23 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_25 = arg_96_1:FormatText(StoryNameCfg[380].name)

				arg_96_1.leftNameTxt_.text = var_99_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_26 = arg_96_1:GetWordFromCfg(418071024)
				local var_99_27 = arg_96_1:FormatText(var_99_26.content)

				arg_96_1.text_.text = var_99_27

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_28 = 57
				local var_99_29 = utf8.len(var_99_27)
				local var_99_30 = var_99_28 <= 0 and var_99_24 or var_99_24 * (var_99_29 / var_99_28)

				if var_99_30 > 0 and var_99_24 < var_99_30 then
					arg_96_1.talkMaxDuration = var_99_30

					if var_99_30 + var_99_23 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_30 + var_99_23
					end
				end

				arg_96_1.text_.text = var_99_27
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071024", "story_v_side_old_418071.awb") ~= 0 then
					local var_99_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071024", "story_v_side_old_418071.awb") / 1000

					if var_99_31 + var_99_23 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_31 + var_99_23
					end

					if var_99_26.prefab_name ~= "" and arg_96_1.actors_[var_99_26.prefab_name] ~= nil then
						local var_99_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_26.prefab_name].transform, "story_v_side_old_418071", "418071024", "story_v_side_old_418071.awb")

						arg_96_1:RecordAudio("418071024", var_99_32)
						arg_96_1:RecordAudio("418071024", var_99_32)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071024", "story_v_side_old_418071.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071024", "story_v_side_old_418071.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_33 = math.max(var_99_24, arg_96_1.talkMaxDuration)

			if var_99_23 <= arg_96_1.time_ and arg_96_1.time_ < var_99_23 + var_99_33 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_23) / var_99_33

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_23 + var_99_33 and arg_96_1.time_ < var_99_23 + var_99_33 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play418071025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 418071025
		arg_100_1.duration_ = 10.1

		local var_100_0 = {
			ja = 10.1,
			CriLanguages = 7.5,
			zh = 7.5
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play418071026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1073"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos1073 = var_103_0.localPosition
				var_103_0.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("1073", 2)

				local var_103_2 = var_103_0.childCount

				for iter_103_0 = 0, var_103_2 - 1 do
					local var_103_3 = var_103_0:GetChild(iter_103_0)

					if var_103_3.name == "" or not string.find(var_103_3.name, "split") then
						var_103_3.gameObject:SetActive(true)
					else
						var_103_3.gameObject:SetActive(false)
					end
				end
			end

			local var_103_4 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_4 then
				local var_103_5 = (arg_100_1.time_ - var_103_1) / var_103_4
				local var_103_6 = Vector3.New(-405.76, -414.5, -207.2)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1073, var_103_6, var_103_5)
			end

			if arg_100_1.time_ >= var_103_1 + var_103_4 and arg_100_1.time_ < var_103_1 + var_103_4 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_103_7 = 0
			local var_103_8 = 1

			if var_103_7 < arg_100_1.time_ and arg_100_1.time_ <= var_103_7 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_9 = arg_100_1:FormatText(StoryNameCfg[380].name)

				arg_100_1.leftNameTxt_.text = var_103_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_10 = arg_100_1:GetWordFromCfg(418071025)
				local var_103_11 = arg_100_1:FormatText(var_103_10.content)

				arg_100_1.text_.text = var_103_11

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_12 = 40
				local var_103_13 = utf8.len(var_103_11)
				local var_103_14 = var_103_12 <= 0 and var_103_8 or var_103_8 * (var_103_13 / var_103_12)

				if var_103_14 > 0 and var_103_8 < var_103_14 then
					arg_100_1.talkMaxDuration = var_103_14

					if var_103_14 + var_103_7 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_7
					end
				end

				arg_100_1.text_.text = var_103_11
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071025", "story_v_side_old_418071.awb") ~= 0 then
					local var_103_15 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071025", "story_v_side_old_418071.awb") / 1000

					if var_103_15 + var_103_7 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_15 + var_103_7
					end

					if var_103_10.prefab_name ~= "" and arg_100_1.actors_[var_103_10.prefab_name] ~= nil then
						local var_103_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_10.prefab_name].transform, "story_v_side_old_418071", "418071025", "story_v_side_old_418071.awb")

						arg_100_1:RecordAudio("418071025", var_103_16)
						arg_100_1:RecordAudio("418071025", var_103_16)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071025", "story_v_side_old_418071.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071025", "story_v_side_old_418071.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_17 = math.max(var_103_8, arg_100_1.talkMaxDuration)

			if var_103_7 <= arg_100_1.time_ and arg_100_1.time_ < var_103_7 + var_103_17 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_7) / var_103_17

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_7 + var_103_17 and arg_100_1.time_ < var_103_7 + var_103_17 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play418071026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 418071026
		arg_104_1.duration_ = 8.07

		local var_104_0 = {
			ja = 8.066,
			CriLanguages = 6.6,
			zh = 6.6
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play418071027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10135"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10135 == nil then
				arg_104_1.var_.actorSpriteComps10135 = var_107_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.actorSpriteComps10135 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								local var_107_4 = Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor1.r, var_107_3)
								local var_107_5 = Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor1.g, var_107_3)
								local var_107_6 = Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor1.b, var_107_3)

								iter_107_1.color = Color.New(var_107_4, var_107_5, var_107_6)
							else
								local var_107_7 = Mathf.Lerp(iter_107_1.color.r, 1, var_107_3)

								iter_107_1.color = Color.New(var_107_7, var_107_7, var_107_7)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10135 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_107_3 then
						if arg_104_1.isInRecall_ then
							iter_107_3.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_107_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10135 = nil
			end

			local var_107_8 = arg_104_1.actors_["1073"]
			local var_107_9 = 0

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps1073 == nil then
				arg_104_1.var_.actorSpriteComps1073 = var_107_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_10 = 0.2

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_10 and not isNil(var_107_8) then
				local var_107_11 = (arg_104_1.time_ - var_107_9) / var_107_10

				if arg_104_1.var_.actorSpriteComps1073 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								local var_107_12 = Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor2.r, var_107_11)
								local var_107_13 = Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor2.g, var_107_11)
								local var_107_14 = Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor2.b, var_107_11)

								iter_107_5.color = Color.New(var_107_12, var_107_13, var_107_14)
							else
								local var_107_15 = Mathf.Lerp(iter_107_5.color.r, 0.5, var_107_11)

								iter_107_5.color = Color.New(var_107_15, var_107_15, var_107_15)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_9 + var_107_10 and arg_104_1.time_ < var_107_9 + var_107_10 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps1073 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_107_7 then
						if arg_104_1.isInRecall_ then
							iter_107_7.color = arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_107_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps1073 = nil
			end

			local var_107_16 = arg_104_1.actors_["10135"].transform
			local var_107_17 = 0

			if var_107_17 < arg_104_1.time_ and arg_104_1.time_ <= var_107_17 + arg_107_0 then
				arg_104_1.var_.moveOldPos10135 = var_107_16.localPosition
				var_107_16.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10135", 4)

				local var_107_18 = var_107_16.childCount

				for iter_107_8 = 0, var_107_18 - 1 do
					local var_107_19 = var_107_16:GetChild(iter_107_8)

					if var_107_19.name == "" or not string.find(var_107_19.name, "split") then
						var_107_19.gameObject:SetActive(true)
					else
						var_107_19.gameObject:SetActive(false)
					end
				end
			end

			local var_107_20 = 0.001

			if var_107_17 <= arg_104_1.time_ and arg_104_1.time_ < var_107_17 + var_107_20 then
				local var_107_21 = (arg_104_1.time_ - var_107_17) / var_107_20
				local var_107_22 = Vector3.New(432.72, -363.6, -305.9)

				var_107_16.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10135, var_107_22, var_107_21)
			end

			if arg_104_1.time_ >= var_107_17 + var_107_20 and arg_104_1.time_ < var_107_17 + var_107_20 + arg_107_0 then
				var_107_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_107_23 = 0
			local var_107_24 = 0.725

			if var_107_23 < arg_104_1.time_ and arg_104_1.time_ <= var_107_23 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_25 = arg_104_1:FormatText(StoryNameCfg[1187].name)

				arg_104_1.leftNameTxt_.text = var_107_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_26 = arg_104_1:GetWordFromCfg(418071026)
				local var_107_27 = arg_104_1:FormatText(var_107_26.content)

				arg_104_1.text_.text = var_107_27

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_28 = 29
				local var_107_29 = utf8.len(var_107_27)
				local var_107_30 = var_107_28 <= 0 and var_107_24 or var_107_24 * (var_107_29 / var_107_28)

				if var_107_30 > 0 and var_107_24 < var_107_30 then
					arg_104_1.talkMaxDuration = var_107_30

					if var_107_30 + var_107_23 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_30 + var_107_23
					end
				end

				arg_104_1.text_.text = var_107_27
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071026", "story_v_side_old_418071.awb") ~= 0 then
					local var_107_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071026", "story_v_side_old_418071.awb") / 1000

					if var_107_31 + var_107_23 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_31 + var_107_23
					end

					if var_107_26.prefab_name ~= "" and arg_104_1.actors_[var_107_26.prefab_name] ~= nil then
						local var_107_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_26.prefab_name].transform, "story_v_side_old_418071", "418071026", "story_v_side_old_418071.awb")

						arg_104_1:RecordAudio("418071026", var_107_32)
						arg_104_1:RecordAudio("418071026", var_107_32)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071026", "story_v_side_old_418071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071026", "story_v_side_old_418071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_33 = math.max(var_107_24, arg_104_1.talkMaxDuration)

			if var_107_23 <= arg_104_1.time_ and arg_104_1.time_ < var_107_23 + var_107_33 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_23) / var_107_33

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_23 + var_107_33 and arg_104_1.time_ < var_107_23 + var_107_33 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play418071027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 418071027
		arg_108_1.duration_ = 15.6

		local var_108_0 = {
			ja = 15.6,
			CriLanguages = 10.5,
			zh = 10.5
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play418071028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1073"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1073 == nil then
				arg_108_1.var_.actorSpriteComps1073 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps1073 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								local var_111_4 = Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, var_111_3)
								local var_111_5 = Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, var_111_3)
								local var_111_6 = Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, var_111_3)

								iter_111_1.color = Color.New(var_111_4, var_111_5, var_111_6)
							else
								local var_111_7 = Mathf.Lerp(iter_111_1.color.r, 1, var_111_3)

								iter_111_1.color = Color.New(var_111_7, var_111_7, var_111_7)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1073 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1073 = nil
			end

			local var_111_8 = arg_108_1.actors_["10135"]
			local var_111_9 = 0

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps10135 == nil then
				arg_108_1.var_.actorSpriteComps10135 = var_111_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_10 = 0.2

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_10 and not isNil(var_111_8) then
				local var_111_11 = (arg_108_1.time_ - var_111_9) / var_111_10

				if arg_108_1.var_.actorSpriteComps10135 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_111_5 then
							if arg_108_1.isInRecall_ then
								local var_111_12 = Mathf.Lerp(iter_111_5.color.r, arg_108_1.hightColor2.r, var_111_11)
								local var_111_13 = Mathf.Lerp(iter_111_5.color.g, arg_108_1.hightColor2.g, var_111_11)
								local var_111_14 = Mathf.Lerp(iter_111_5.color.b, arg_108_1.hightColor2.b, var_111_11)

								iter_111_5.color = Color.New(var_111_12, var_111_13, var_111_14)
							else
								local var_111_15 = Mathf.Lerp(iter_111_5.color.r, 0.5, var_111_11)

								iter_111_5.color = Color.New(var_111_15, var_111_15, var_111_15)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_9 + var_111_10 and arg_108_1.time_ < var_111_9 + var_111_10 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps10135 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_111_7 then
						if arg_108_1.isInRecall_ then
							iter_111_7.color = arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_111_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps10135 = nil
			end

			local var_111_16 = 0
			local var_111_17 = 1.3

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_18 = arg_108_1:FormatText(StoryNameCfg[380].name)

				arg_108_1.leftNameTxt_.text = var_111_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_19 = arg_108_1:GetWordFromCfg(418071027)
				local var_111_20 = arg_108_1:FormatText(var_111_19.content)

				arg_108_1.text_.text = var_111_20

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_21 = 52
				local var_111_22 = utf8.len(var_111_20)
				local var_111_23 = var_111_21 <= 0 and var_111_17 or var_111_17 * (var_111_22 / var_111_21)

				if var_111_23 > 0 and var_111_17 < var_111_23 then
					arg_108_1.talkMaxDuration = var_111_23

					if var_111_23 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_16
					end
				end

				arg_108_1.text_.text = var_111_20
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071027", "story_v_side_old_418071.awb") ~= 0 then
					local var_111_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071027", "story_v_side_old_418071.awb") / 1000

					if var_111_24 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_24 + var_111_16
					end

					if var_111_19.prefab_name ~= "" and arg_108_1.actors_[var_111_19.prefab_name] ~= nil then
						local var_111_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_19.prefab_name].transform, "story_v_side_old_418071", "418071027", "story_v_side_old_418071.awb")

						arg_108_1:RecordAudio("418071027", var_111_25)
						arg_108_1:RecordAudio("418071027", var_111_25)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071027", "story_v_side_old_418071.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071027", "story_v_side_old_418071.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_26 = math.max(var_111_17, arg_108_1.talkMaxDuration)

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_26 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_16) / var_111_26

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_16 + var_111_26 and arg_108_1.time_ < var_111_16 + var_111_26 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play418071028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 418071028
		arg_112_1.duration_ = 14.9

		local var_112_0 = {
			ja = 14.9,
			CriLanguages = 10.7,
			zh = 10.7
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play418071029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 1.05

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[380].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_3 = arg_112_1:GetWordFromCfg(418071028)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 42
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071028", "story_v_side_old_418071.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071028", "story_v_side_old_418071.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_side_old_418071", "418071028", "story_v_side_old_418071.awb")

						arg_112_1:RecordAudio("418071028", var_115_9)
						arg_112_1:RecordAudio("418071028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071028", "story_v_side_old_418071.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071028", "story_v_side_old_418071.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play418071029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 418071029
		arg_116_1.duration_ = 21.13

		local var_116_0 = {
			ja = 21.133,
			CriLanguages = 14.166,
			zh = 14.166
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play418071030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10135"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps10135 == nil then
				arg_116_1.var_.actorSpriteComps10135 = var_119_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.actorSpriteComps10135 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								local var_119_4 = Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, var_119_3)
								local var_119_5 = Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, var_119_3)
								local var_119_6 = Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, var_119_3)

								iter_119_1.color = Color.New(var_119_4, var_119_5, var_119_6)
							else
								local var_119_7 = Mathf.Lerp(iter_119_1.color.r, 1, var_119_3)

								iter_119_1.color = Color.New(var_119_7, var_119_7, var_119_7)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps10135 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_119_3 then
						if arg_116_1.isInRecall_ then
							iter_119_3.color = arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_119_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps10135 = nil
			end

			local var_119_8 = arg_116_1.actors_["1073"]
			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps1073 == nil then
				arg_116_1.var_.actorSpriteComps1073 = var_119_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_10 = 0.2

			if var_119_9 <= arg_116_1.time_ and arg_116_1.time_ < var_119_9 + var_119_10 and not isNil(var_119_8) then
				local var_119_11 = (arg_116_1.time_ - var_119_9) / var_119_10

				if arg_116_1.var_.actorSpriteComps1073 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_119_5 then
							if arg_116_1.isInRecall_ then
								local var_119_12 = Mathf.Lerp(iter_119_5.color.r, arg_116_1.hightColor2.r, var_119_11)
								local var_119_13 = Mathf.Lerp(iter_119_5.color.g, arg_116_1.hightColor2.g, var_119_11)
								local var_119_14 = Mathf.Lerp(iter_119_5.color.b, arg_116_1.hightColor2.b, var_119_11)

								iter_119_5.color = Color.New(var_119_12, var_119_13, var_119_14)
							else
								local var_119_15 = Mathf.Lerp(iter_119_5.color.r, 0.5, var_119_11)

								iter_119_5.color = Color.New(var_119_15, var_119_15, var_119_15)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_9 + var_119_10 and arg_116_1.time_ < var_119_9 + var_119_10 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps1073 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_119_7 then
						if arg_116_1.isInRecall_ then
							iter_119_7.color = arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_119_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps1073 = nil
			end

			local var_119_16 = arg_116_1.actors_["1073"].transform
			local var_119_17 = 0

			if var_119_17 < arg_116_1.time_ and arg_116_1.time_ <= var_119_17 + arg_119_0 then
				arg_116_1.var_.moveOldPos1073 = var_119_16.localPosition
				var_119_16.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1073", 2)

				local var_119_18 = var_119_16.childCount

				for iter_119_8 = 0, var_119_18 - 1 do
					local var_119_19 = var_119_16:GetChild(iter_119_8)

					if var_119_19.name == "" or not string.find(var_119_19.name, "split") then
						var_119_19.gameObject:SetActive(true)
					else
						var_119_19.gameObject:SetActive(false)
					end
				end
			end

			local var_119_20 = 0.001

			if var_119_17 <= arg_116_1.time_ and arg_116_1.time_ < var_119_17 + var_119_20 then
				local var_119_21 = (arg_116_1.time_ - var_119_17) / var_119_20
				local var_119_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_119_16.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1073, var_119_22, var_119_21)
			end

			if arg_116_1.time_ >= var_119_17 + var_119_20 and arg_116_1.time_ < var_119_17 + var_119_20 + arg_119_0 then
				var_119_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_119_23 = 0
			local var_119_24 = 1.6

			if var_119_23 < arg_116_1.time_ and arg_116_1.time_ <= var_119_23 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_25 = arg_116_1:FormatText(StoryNameCfg[1187].name)

				arg_116_1.leftNameTxt_.text = var_119_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_26 = arg_116_1:GetWordFromCfg(418071029)
				local var_119_27 = arg_116_1:FormatText(var_119_26.content)

				arg_116_1.text_.text = var_119_27

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_28 = 64
				local var_119_29 = utf8.len(var_119_27)
				local var_119_30 = var_119_28 <= 0 and var_119_24 or var_119_24 * (var_119_29 / var_119_28)

				if var_119_30 > 0 and var_119_24 < var_119_30 then
					arg_116_1.talkMaxDuration = var_119_30

					if var_119_30 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_30 + var_119_23
					end
				end

				arg_116_1.text_.text = var_119_27
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071029", "story_v_side_old_418071.awb") ~= 0 then
					local var_119_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071029", "story_v_side_old_418071.awb") / 1000

					if var_119_31 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_31 + var_119_23
					end

					if var_119_26.prefab_name ~= "" and arg_116_1.actors_[var_119_26.prefab_name] ~= nil then
						local var_119_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_26.prefab_name].transform, "story_v_side_old_418071", "418071029", "story_v_side_old_418071.awb")

						arg_116_1:RecordAudio("418071029", var_119_32)
						arg_116_1:RecordAudio("418071029", var_119_32)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071029", "story_v_side_old_418071.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071029", "story_v_side_old_418071.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_33 = math.max(var_119_24, arg_116_1.talkMaxDuration)

			if var_119_23 <= arg_116_1.time_ and arg_116_1.time_ < var_119_23 + var_119_33 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_23) / var_119_33

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_23 + var_119_33 and arg_116_1.time_ < var_119_23 + var_119_33 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play418071030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 418071030
		arg_120_1.duration_ = 12.23

		local var_120_0 = {
			ja = 12,
			CriLanguages = 12.233,
			zh = 12.233
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play418071031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1073"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps1073 == nil then
				arg_120_1.var_.actorSpriteComps1073 = var_123_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.actorSpriteComps1073 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								local var_123_4 = Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, var_123_3)
								local var_123_5 = Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, var_123_3)
								local var_123_6 = Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, var_123_3)

								iter_123_1.color = Color.New(var_123_4, var_123_5, var_123_6)
							else
								local var_123_7 = Mathf.Lerp(iter_123_1.color.r, 1, var_123_3)

								iter_123_1.color = Color.New(var_123_7, var_123_7, var_123_7)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps1073 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_123_3 then
						if arg_120_1.isInRecall_ then
							iter_123_3.color = arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_123_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps1073 = nil
			end

			local var_123_8 = arg_120_1.actors_["10135"]
			local var_123_9 = 0

			if var_123_9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps10135 == nil then
				arg_120_1.var_.actorSpriteComps10135 = var_123_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_10 = 0.2

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_10 and not isNil(var_123_8) then
				local var_123_11 = (arg_120_1.time_ - var_123_9) / var_123_10

				if arg_120_1.var_.actorSpriteComps10135 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								local var_123_12 = Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, var_123_11)
								local var_123_13 = Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, var_123_11)
								local var_123_14 = Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, var_123_11)

								iter_123_5.color = Color.New(var_123_12, var_123_13, var_123_14)
							else
								local var_123_15 = Mathf.Lerp(iter_123_5.color.r, 0.5, var_123_11)

								iter_123_5.color = Color.New(var_123_15, var_123_15, var_123_15)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_9 + var_123_10 and arg_120_1.time_ < var_123_9 + var_123_10 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps10135 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_123_7 then
						if arg_120_1.isInRecall_ then
							iter_123_7.color = arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_123_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps10135 = nil
			end

			local var_123_16 = 0
			local var_123_17 = 1.45

			if var_123_16 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_18 = arg_120_1:FormatText(StoryNameCfg[380].name)

				arg_120_1.leftNameTxt_.text = var_123_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_19 = arg_120_1:GetWordFromCfg(418071030)
				local var_123_20 = arg_120_1:FormatText(var_123_19.content)

				arg_120_1.text_.text = var_123_20

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_21 = 58
				local var_123_22 = utf8.len(var_123_20)
				local var_123_23 = var_123_21 <= 0 and var_123_17 or var_123_17 * (var_123_22 / var_123_21)

				if var_123_23 > 0 and var_123_17 < var_123_23 then
					arg_120_1.talkMaxDuration = var_123_23

					if var_123_23 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_16
					end
				end

				arg_120_1.text_.text = var_123_20
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071030", "story_v_side_old_418071.awb") ~= 0 then
					local var_123_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071030", "story_v_side_old_418071.awb") / 1000

					if var_123_24 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_24 + var_123_16
					end

					if var_123_19.prefab_name ~= "" and arg_120_1.actors_[var_123_19.prefab_name] ~= nil then
						local var_123_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_19.prefab_name].transform, "story_v_side_old_418071", "418071030", "story_v_side_old_418071.awb")

						arg_120_1:RecordAudio("418071030", var_123_25)
						arg_120_1:RecordAudio("418071030", var_123_25)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071030", "story_v_side_old_418071.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071030", "story_v_side_old_418071.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_26 = math.max(var_123_17, arg_120_1.talkMaxDuration)

			if var_123_16 <= arg_120_1.time_ and arg_120_1.time_ < var_123_16 + var_123_26 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_16) / var_123_26

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_16 + var_123_26 and arg_120_1.time_ < var_123_16 + var_123_26 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play418071031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 418071031
		arg_124_1.duration_ = 5.6

		local var_124_0 = {
			ja = 5.6,
			CriLanguages = 4,
			zh = 4
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play418071032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10135"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10135 == nil then
				arg_124_1.var_.actorSpriteComps10135 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps10135 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								local var_127_4 = Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor1.r, var_127_3)
								local var_127_5 = Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor1.g, var_127_3)
								local var_127_6 = Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor1.b, var_127_3)

								iter_127_1.color = Color.New(var_127_4, var_127_5, var_127_6)
							else
								local var_127_7 = Mathf.Lerp(iter_127_1.color.r, 1, var_127_3)

								iter_127_1.color = Color.New(var_127_7, var_127_7, var_127_7)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10135 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps10135 = nil
			end

			local var_127_8 = arg_124_1.actors_["1073"]
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps1073 == nil then
				arg_124_1.var_.actorSpriteComps1073 = var_127_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_10 = 0.2

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_10 and not isNil(var_127_8) then
				local var_127_11 = (arg_124_1.time_ - var_127_9) / var_127_10

				if arg_124_1.var_.actorSpriteComps1073 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								local var_127_12 = Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor2.r, var_127_11)
								local var_127_13 = Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor2.g, var_127_11)
								local var_127_14 = Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor2.b, var_127_11)

								iter_127_5.color = Color.New(var_127_12, var_127_13, var_127_14)
							else
								local var_127_15 = Mathf.Lerp(iter_127_5.color.r, 0.5, var_127_11)

								iter_127_5.color = Color.New(var_127_15, var_127_15, var_127_15)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_9 + var_127_10 and arg_124_1.time_ < var_127_9 + var_127_10 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps1073 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_127_7 then
						if arg_124_1.isInRecall_ then
							iter_127_7.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps1073 = nil
			end

			local var_127_16 = arg_124_1.actors_["10135"].transform
			local var_127_17 = 0

			if var_127_17 < arg_124_1.time_ and arg_124_1.time_ <= var_127_17 + arg_127_0 then
				arg_124_1.var_.moveOldPos10135 = var_127_16.localPosition
				var_127_16.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10135", 4)

				local var_127_18 = var_127_16.childCount

				for iter_127_8 = 0, var_127_18 - 1 do
					local var_127_19 = var_127_16:GetChild(iter_127_8)

					if var_127_19.name == "split_5" or not string.find(var_127_19.name, "split") then
						var_127_19.gameObject:SetActive(true)
					else
						var_127_19.gameObject:SetActive(false)
					end
				end
			end

			local var_127_20 = 0.001

			if var_127_17 <= arg_124_1.time_ and arg_124_1.time_ < var_127_17 + var_127_20 then
				local var_127_21 = (arg_124_1.time_ - var_127_17) / var_127_20
				local var_127_22 = Vector3.New(432.72, -363.6, -305.9)

				var_127_16.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10135, var_127_22, var_127_21)
			end

			if arg_124_1.time_ >= var_127_17 + var_127_20 and arg_124_1.time_ < var_127_17 + var_127_20 + arg_127_0 then
				var_127_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_127_23 = 0
			local var_127_24 = 0.525

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_25 = arg_124_1:FormatText(StoryNameCfg[1187].name)

				arg_124_1.leftNameTxt_.text = var_127_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_26 = arg_124_1:GetWordFromCfg(418071031)
				local var_127_27 = arg_124_1:FormatText(var_127_26.content)

				arg_124_1.text_.text = var_127_27

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_28 = 21
				local var_127_29 = utf8.len(var_127_27)
				local var_127_30 = var_127_28 <= 0 and var_127_24 or var_127_24 * (var_127_29 / var_127_28)

				if var_127_30 > 0 and var_127_24 < var_127_30 then
					arg_124_1.talkMaxDuration = var_127_30

					if var_127_30 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_30 + var_127_23
					end
				end

				arg_124_1.text_.text = var_127_27
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071031", "story_v_side_old_418071.awb") ~= 0 then
					local var_127_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071031", "story_v_side_old_418071.awb") / 1000

					if var_127_31 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_31 + var_127_23
					end

					if var_127_26.prefab_name ~= "" and arg_124_1.actors_[var_127_26.prefab_name] ~= nil then
						local var_127_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_26.prefab_name].transform, "story_v_side_old_418071", "418071031", "story_v_side_old_418071.awb")

						arg_124_1:RecordAudio("418071031", var_127_32)
						arg_124_1:RecordAudio("418071031", var_127_32)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071031", "story_v_side_old_418071.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071031", "story_v_side_old_418071.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_33 = math.max(var_127_24, arg_124_1.talkMaxDuration)

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_33 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_23) / var_127_33

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_23 + var_127_33 and arg_124_1.time_ < var_127_23 + var_127_33 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play418071032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 418071032
		arg_128_1.duration_ = 8.63

		local var_128_0 = {
			ja = 8.633,
			CriLanguages = 6.8,
			zh = 6.8
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play418071033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1073"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1073 == nil then
				arg_128_1.var_.actorSpriteComps1073 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps1073 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								local var_131_4 = Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, var_131_3)
								local var_131_5 = Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, var_131_3)
								local var_131_6 = Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, var_131_3)

								iter_131_1.color = Color.New(var_131_4, var_131_5, var_131_6)
							else
								local var_131_7 = Mathf.Lerp(iter_131_1.color.r, 1, var_131_3)

								iter_131_1.color = Color.New(var_131_7, var_131_7, var_131_7)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1073 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps1073 = nil
			end

			local var_131_8 = arg_128_1.actors_["10135"]
			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps10135 == nil then
				arg_128_1.var_.actorSpriteComps10135 = var_131_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_10 = 0.2

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_10 and not isNil(var_131_8) then
				local var_131_11 = (arg_128_1.time_ - var_131_9) / var_131_10

				if arg_128_1.var_.actorSpriteComps10135 then
					for iter_131_4, iter_131_5 in pairs(arg_128_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_131_5 then
							if arg_128_1.isInRecall_ then
								local var_131_12 = Mathf.Lerp(iter_131_5.color.r, arg_128_1.hightColor2.r, var_131_11)
								local var_131_13 = Mathf.Lerp(iter_131_5.color.g, arg_128_1.hightColor2.g, var_131_11)
								local var_131_14 = Mathf.Lerp(iter_131_5.color.b, arg_128_1.hightColor2.b, var_131_11)

								iter_131_5.color = Color.New(var_131_12, var_131_13, var_131_14)
							else
								local var_131_15 = Mathf.Lerp(iter_131_5.color.r, 0.5, var_131_11)

								iter_131_5.color = Color.New(var_131_15, var_131_15, var_131_15)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_9 + var_131_10 and arg_128_1.time_ < var_131_9 + var_131_10 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps10135 then
				for iter_131_6, iter_131_7 in pairs(arg_128_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_131_7 then
						if arg_128_1.isInRecall_ then
							iter_131_7.color = arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_131_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10135 = nil
			end

			local var_131_16 = 0
			local var_131_17 = 0.825

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_18 = arg_128_1:FormatText(StoryNameCfg[380].name)

				arg_128_1.leftNameTxt_.text = var_131_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_19 = arg_128_1:GetWordFromCfg(418071032)
				local var_131_20 = arg_128_1:FormatText(var_131_19.content)

				arg_128_1.text_.text = var_131_20

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_21 = 33
				local var_131_22 = utf8.len(var_131_20)
				local var_131_23 = var_131_21 <= 0 and var_131_17 or var_131_17 * (var_131_22 / var_131_21)

				if var_131_23 > 0 and var_131_17 < var_131_23 then
					arg_128_1.talkMaxDuration = var_131_23

					if var_131_23 + var_131_16 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_16
					end
				end

				arg_128_1.text_.text = var_131_20
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071032", "story_v_side_old_418071.awb") ~= 0 then
					local var_131_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071032", "story_v_side_old_418071.awb") / 1000

					if var_131_24 + var_131_16 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_24 + var_131_16
					end

					if var_131_19.prefab_name ~= "" and arg_128_1.actors_[var_131_19.prefab_name] ~= nil then
						local var_131_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_19.prefab_name].transform, "story_v_side_old_418071", "418071032", "story_v_side_old_418071.awb")

						arg_128_1:RecordAudio("418071032", var_131_25)
						arg_128_1:RecordAudio("418071032", var_131_25)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071032", "story_v_side_old_418071.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071032", "story_v_side_old_418071.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_26 = math.max(var_131_17, arg_128_1.talkMaxDuration)

			if var_131_16 <= arg_128_1.time_ and arg_128_1.time_ < var_131_16 + var_131_26 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_16) / var_131_26

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_16 + var_131_26 and arg_128_1.time_ < var_131_16 + var_131_26 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play418071033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 418071033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play418071034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1073"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1073 == nil then
				arg_132_1.var_.actorSpriteComps1073 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps1073 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								local var_135_4 = Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor2.r, var_135_3)
								local var_135_5 = Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor2.g, var_135_3)
								local var_135_6 = Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor2.b, var_135_3)

								iter_135_1.color = Color.New(var_135_4, var_135_5, var_135_6)
							else
								local var_135_7 = Mathf.Lerp(iter_135_1.color.r, 0.5, var_135_3)

								iter_135_1.color = Color.New(var_135_7, var_135_7, var_135_7)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1073 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1073 = nil
			end

			local var_135_8 = arg_132_1.actors_["1073"].transform
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 then
				arg_132_1.var_.moveOldPos1073 = var_135_8.localPosition
				var_135_8.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("1073", 7)

				local var_135_10 = var_135_8.childCount

				for iter_135_4 = 0, var_135_10 - 1 do
					local var_135_11 = var_135_8:GetChild(iter_135_4)

					if var_135_11.name == "" or not string.find(var_135_11.name, "split") then
						var_135_11.gameObject:SetActive(true)
					else
						var_135_11.gameObject:SetActive(false)
					end
				end
			end

			local var_135_12 = 0.001

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_12 then
				local var_135_13 = (arg_132_1.time_ - var_135_9) / var_135_12
				local var_135_14 = Vector3.New(0, -2000, 0)

				var_135_8.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1073, var_135_14, var_135_13)
			end

			if arg_132_1.time_ >= var_135_9 + var_135_12 and arg_132_1.time_ < var_135_9 + var_135_12 + arg_135_0 then
				var_135_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_135_15 = arg_132_1.actors_["10135"].transform
			local var_135_16 = 0

			if var_135_16 < arg_132_1.time_ and arg_132_1.time_ <= var_135_16 + arg_135_0 then
				arg_132_1.var_.moveOldPos10135 = var_135_15.localPosition
				var_135_15.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("10135", 7)

				local var_135_17 = var_135_15.childCount

				for iter_135_5 = 0, var_135_17 - 1 do
					local var_135_18 = var_135_15:GetChild(iter_135_5)

					if var_135_18.name == "" or not string.find(var_135_18.name, "split") then
						var_135_18.gameObject:SetActive(true)
					else
						var_135_18.gameObject:SetActive(false)
					end
				end
			end

			local var_135_19 = 0.001

			if var_135_16 <= arg_132_1.time_ and arg_132_1.time_ < var_135_16 + var_135_19 then
				local var_135_20 = (arg_132_1.time_ - var_135_16) / var_135_19
				local var_135_21 = Vector3.New(0, -2000, 0)

				var_135_15.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10135, var_135_21, var_135_20)
			end

			if arg_132_1.time_ >= var_135_16 + var_135_19 and arg_132_1.time_ < var_135_16 + var_135_19 + arg_135_0 then
				var_135_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_135_22 = 0
			local var_135_23 = 0.625

			if var_135_22 < arg_132_1.time_ and arg_132_1.time_ <= var_135_22 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_24 = arg_132_1:GetWordFromCfg(418071033)
				local var_135_25 = arg_132_1:FormatText(var_135_24.content)

				arg_132_1.text_.text = var_135_25

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_26 = 25
				local var_135_27 = utf8.len(var_135_25)
				local var_135_28 = var_135_26 <= 0 and var_135_23 or var_135_23 * (var_135_27 / var_135_26)

				if var_135_28 > 0 and var_135_23 < var_135_28 then
					arg_132_1.talkMaxDuration = var_135_28

					if var_135_28 + var_135_22 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_28 + var_135_22
					end
				end

				arg_132_1.text_.text = var_135_25
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_29 = math.max(var_135_23, arg_132_1.talkMaxDuration)

			if var_135_22 <= arg_132_1.time_ and arg_132_1.time_ < var_135_22 + var_135_29 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_22) / var_135_29

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_22 + var_135_29 and arg_132_1.time_ < var_135_22 + var_135_29 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play418071034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 418071034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play418071035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 1.125

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_2 = arg_136_1:GetWordFromCfg(418071034)
				local var_139_3 = arg_136_1:FormatText(var_139_2.content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 45
				local var_139_5 = utf8.len(var_139_3)
				local var_139_6 = var_139_4 <= 0 and var_139_1 or var_139_1 * (var_139_5 / var_139_4)

				if var_139_6 > 0 and var_139_1 < var_139_6 then
					arg_136_1.talkMaxDuration = var_139_6

					if var_139_6 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_6 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_7 and arg_136_1.time_ < var_139_0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play418071035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 418071035
		arg_140_1.duration_ = 10.93

		local var_140_0 = {
			ja = 10.933,
			CriLanguages = 7.5,
			zh = 7.5
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
				arg_140_0:Play418071036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1073"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1073 == nil then
				arg_140_1.var_.actorSpriteComps1073 = var_143_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.actorSpriteComps1073 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1073 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_143_3 then
						if arg_140_1.isInRecall_ then
							iter_143_3.color = arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_143_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps1073 = nil
			end

			local var_143_8 = arg_140_1.actors_["1073"].transform
			local var_143_9 = 0

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.var_.moveOldPos1073 = var_143_8.localPosition
				var_143_8.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1073", 2)

				local var_143_10 = var_143_8.childCount

				for iter_143_4 = 0, var_143_10 - 1 do
					local var_143_11 = var_143_8:GetChild(iter_143_4)

					if var_143_11.name == "" or not string.find(var_143_11.name, "split") then
						var_143_11.gameObject:SetActive(true)
					else
						var_143_11.gameObject:SetActive(false)
					end
				end
			end

			local var_143_12 = 0.001

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_12 then
				local var_143_13 = (arg_140_1.time_ - var_143_9) / var_143_12
				local var_143_14 = Vector3.New(-405.76, -414.5, -207.2)

				var_143_8.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1073, var_143_14, var_143_13)
			end

			if arg_140_1.time_ >= var_143_9 + var_143_12 and arg_140_1.time_ < var_143_9 + var_143_12 + arg_143_0 then
				var_143_8.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_143_15 = 0
			local var_143_16 = 0.975

			if var_143_15 < arg_140_1.time_ and arg_140_1.time_ <= var_143_15 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_17 = arg_140_1:FormatText(StoryNameCfg[380].name)

				arg_140_1.leftNameTxt_.text = var_143_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_18 = arg_140_1:GetWordFromCfg(418071035)
				local var_143_19 = arg_140_1:FormatText(var_143_18.content)

				arg_140_1.text_.text = var_143_19

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_20 = 39
				local var_143_21 = utf8.len(var_143_19)
				local var_143_22 = var_143_20 <= 0 and var_143_16 or var_143_16 * (var_143_21 / var_143_20)

				if var_143_22 > 0 and var_143_16 < var_143_22 then
					arg_140_1.talkMaxDuration = var_143_22

					if var_143_22 + var_143_15 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_22 + var_143_15
					end
				end

				arg_140_1.text_.text = var_143_19
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071035", "story_v_side_old_418071.awb") ~= 0 then
					local var_143_23 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071035", "story_v_side_old_418071.awb") / 1000

					if var_143_23 + var_143_15 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_23 + var_143_15
					end

					if var_143_18.prefab_name ~= "" and arg_140_1.actors_[var_143_18.prefab_name] ~= nil then
						local var_143_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_18.prefab_name].transform, "story_v_side_old_418071", "418071035", "story_v_side_old_418071.awb")

						arg_140_1:RecordAudio("418071035", var_143_24)
						arg_140_1:RecordAudio("418071035", var_143_24)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071035", "story_v_side_old_418071.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071035", "story_v_side_old_418071.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_25 = math.max(var_143_16, arg_140_1.talkMaxDuration)

			if var_143_15 <= arg_140_1.time_ and arg_140_1.time_ < var_143_15 + var_143_25 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_15) / var_143_25

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_15 + var_143_25 and arg_140_1.time_ < var_143_15 + var_143_25 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
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
	Play418071036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 418071036
		arg_144_1.duration_ = 10.33

		local var_144_0 = {
			ja = 10.333,
			CriLanguages = 8.666,
			zh = 8.666
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play418071037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["10135"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps10135 == nil then
				arg_144_1.var_.actorSpriteComps10135 = var_147_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.actorSpriteComps10135 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								local var_147_4 = Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor1.r, var_147_3)
								local var_147_5 = Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor1.g, var_147_3)
								local var_147_6 = Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor1.b, var_147_3)

								iter_147_1.color = Color.New(var_147_4, var_147_5, var_147_6)
							else
								local var_147_7 = Mathf.Lerp(iter_147_1.color.r, 1, var_147_3)

								iter_147_1.color = Color.New(var_147_7, var_147_7, var_147_7)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps10135 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_147_3 then
						if arg_144_1.isInRecall_ then
							iter_147_3.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_147_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps10135 = nil
			end

			local var_147_8 = arg_144_1.actors_["1073"]
			local var_147_9 = 0

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.actorSpriteComps1073 == nil then
				arg_144_1.var_.actorSpriteComps1073 = var_147_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_10 = 0.2

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_10 and not isNil(var_147_8) then
				local var_147_11 = (arg_144_1.time_ - var_147_9) / var_147_10

				if arg_144_1.var_.actorSpriteComps1073 then
					for iter_147_4, iter_147_5 in pairs(arg_144_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_147_5 then
							if arg_144_1.isInRecall_ then
								local var_147_12 = Mathf.Lerp(iter_147_5.color.r, arg_144_1.hightColor2.r, var_147_11)
								local var_147_13 = Mathf.Lerp(iter_147_5.color.g, arg_144_1.hightColor2.g, var_147_11)
								local var_147_14 = Mathf.Lerp(iter_147_5.color.b, arg_144_1.hightColor2.b, var_147_11)

								iter_147_5.color = Color.New(var_147_12, var_147_13, var_147_14)
							else
								local var_147_15 = Mathf.Lerp(iter_147_5.color.r, 0.5, var_147_11)

								iter_147_5.color = Color.New(var_147_15, var_147_15, var_147_15)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_9 + var_147_10 and arg_144_1.time_ < var_147_9 + var_147_10 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.actorSpriteComps1073 then
				for iter_147_6, iter_147_7 in pairs(arg_144_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_147_7 then
						if arg_144_1.isInRecall_ then
							iter_147_7.color = arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_147_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps1073 = nil
			end

			local var_147_16 = arg_144_1.actors_["10135"].transform
			local var_147_17 = 0

			if var_147_17 < arg_144_1.time_ and arg_144_1.time_ <= var_147_17 + arg_147_0 then
				arg_144_1.var_.moveOldPos10135 = var_147_16.localPosition
				var_147_16.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("10135", 4)

				local var_147_18 = var_147_16.childCount

				for iter_147_8 = 0, var_147_18 - 1 do
					local var_147_19 = var_147_16:GetChild(iter_147_8)

					if var_147_19.name == "" or not string.find(var_147_19.name, "split") then
						var_147_19.gameObject:SetActive(true)
					else
						var_147_19.gameObject:SetActive(false)
					end
				end
			end

			local var_147_20 = 0.001

			if var_147_17 <= arg_144_1.time_ and arg_144_1.time_ < var_147_17 + var_147_20 then
				local var_147_21 = (arg_144_1.time_ - var_147_17) / var_147_20
				local var_147_22 = Vector3.New(432.72, -363.6, -305.9)

				var_147_16.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10135, var_147_22, var_147_21)
			end

			if arg_144_1.time_ >= var_147_17 + var_147_20 and arg_144_1.time_ < var_147_17 + var_147_20 + arg_147_0 then
				var_147_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_147_23 = 0
			local var_147_24 = 0.875

			if var_147_23 < arg_144_1.time_ and arg_144_1.time_ <= var_147_23 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_25 = arg_144_1:FormatText(StoryNameCfg[1187].name)

				arg_144_1.leftNameTxt_.text = var_147_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_26 = arg_144_1:GetWordFromCfg(418071036)
				local var_147_27 = arg_144_1:FormatText(var_147_26.content)

				arg_144_1.text_.text = var_147_27

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_28 = 35
				local var_147_29 = utf8.len(var_147_27)
				local var_147_30 = var_147_28 <= 0 and var_147_24 or var_147_24 * (var_147_29 / var_147_28)

				if var_147_30 > 0 and var_147_24 < var_147_30 then
					arg_144_1.talkMaxDuration = var_147_30

					if var_147_30 + var_147_23 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_30 + var_147_23
					end
				end

				arg_144_1.text_.text = var_147_27
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071036", "story_v_side_old_418071.awb") ~= 0 then
					local var_147_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071036", "story_v_side_old_418071.awb") / 1000

					if var_147_31 + var_147_23 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_31 + var_147_23
					end

					if var_147_26.prefab_name ~= "" and arg_144_1.actors_[var_147_26.prefab_name] ~= nil then
						local var_147_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_26.prefab_name].transform, "story_v_side_old_418071", "418071036", "story_v_side_old_418071.awb")

						arg_144_1:RecordAudio("418071036", var_147_32)
						arg_144_1:RecordAudio("418071036", var_147_32)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071036", "story_v_side_old_418071.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071036", "story_v_side_old_418071.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_33 = math.max(var_147_24, arg_144_1.talkMaxDuration)

			if var_147_23 <= arg_144_1.time_ and arg_144_1.time_ < var_147_23 + var_147_33 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_23) / var_147_33

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_23 + var_147_33 and arg_144_1.time_ < var_147_23 + var_147_33 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play418071037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 418071037
		arg_148_1.duration_ = 10.4

		local var_148_0 = {
			ja = 10.4,
			CriLanguages = 8.233,
			zh = 8.233
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play418071038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1073"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1073 == nil then
				arg_148_1.var_.actorSpriteComps1073 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps1073 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								local var_151_4 = Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, var_151_3)
								local var_151_5 = Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, var_151_3)
								local var_151_6 = Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, var_151_3)

								iter_151_1.color = Color.New(var_151_4, var_151_5, var_151_6)
							else
								local var_151_7 = Mathf.Lerp(iter_151_1.color.r, 1, var_151_3)

								iter_151_1.color = Color.New(var_151_7, var_151_7, var_151_7)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1073 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_151_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps1073 = nil
			end

			local var_151_8 = arg_148_1.actors_["10135"]
			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 and not isNil(var_151_8) and arg_148_1.var_.actorSpriteComps10135 == nil then
				arg_148_1.var_.actorSpriteComps10135 = var_151_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_10 = 0.2

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_10 and not isNil(var_151_8) then
				local var_151_11 = (arg_148_1.time_ - var_151_9) / var_151_10

				if arg_148_1.var_.actorSpriteComps10135 then
					for iter_151_4, iter_151_5 in pairs(arg_148_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_151_5 then
							if arg_148_1.isInRecall_ then
								local var_151_12 = Mathf.Lerp(iter_151_5.color.r, arg_148_1.hightColor2.r, var_151_11)
								local var_151_13 = Mathf.Lerp(iter_151_5.color.g, arg_148_1.hightColor2.g, var_151_11)
								local var_151_14 = Mathf.Lerp(iter_151_5.color.b, arg_148_1.hightColor2.b, var_151_11)

								iter_151_5.color = Color.New(var_151_12, var_151_13, var_151_14)
							else
								local var_151_15 = Mathf.Lerp(iter_151_5.color.r, 0.5, var_151_11)

								iter_151_5.color = Color.New(var_151_15, var_151_15, var_151_15)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_9 + var_151_10 and arg_148_1.time_ < var_151_9 + var_151_10 + arg_151_0 and not isNil(var_151_8) and arg_148_1.var_.actorSpriteComps10135 then
				for iter_151_6, iter_151_7 in pairs(arg_148_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_151_7 then
						if arg_148_1.isInRecall_ then
							iter_151_7.color = arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_151_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps10135 = nil
			end

			local var_151_16 = 0
			local var_151_17 = 1.025

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_18 = arg_148_1:FormatText(StoryNameCfg[380].name)

				arg_148_1.leftNameTxt_.text = var_151_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_19 = arg_148_1:GetWordFromCfg(418071037)
				local var_151_20 = arg_148_1:FormatText(var_151_19.content)

				arg_148_1.text_.text = var_151_20

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_21 = 41
				local var_151_22 = utf8.len(var_151_20)
				local var_151_23 = var_151_21 <= 0 and var_151_17 or var_151_17 * (var_151_22 / var_151_21)

				if var_151_23 > 0 and var_151_17 < var_151_23 then
					arg_148_1.talkMaxDuration = var_151_23

					if var_151_23 + var_151_16 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_16
					end
				end

				arg_148_1.text_.text = var_151_20
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071037", "story_v_side_old_418071.awb") ~= 0 then
					local var_151_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071037", "story_v_side_old_418071.awb") / 1000

					if var_151_24 + var_151_16 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_24 + var_151_16
					end

					if var_151_19.prefab_name ~= "" and arg_148_1.actors_[var_151_19.prefab_name] ~= nil then
						local var_151_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_19.prefab_name].transform, "story_v_side_old_418071", "418071037", "story_v_side_old_418071.awb")

						arg_148_1:RecordAudio("418071037", var_151_25)
						arg_148_1:RecordAudio("418071037", var_151_25)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071037", "story_v_side_old_418071.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071037", "story_v_side_old_418071.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_26 = math.max(var_151_17, arg_148_1.talkMaxDuration)

			if var_151_16 <= arg_148_1.time_ and arg_148_1.time_ < var_151_16 + var_151_26 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_16) / var_151_26

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_16 + var_151_26 and arg_148_1.time_ < var_151_16 + var_151_26 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play418071038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 418071038
		arg_152_1.duration_ = 1.97

		local var_152_0 = {
			ja = 1.5,
			CriLanguages = 1.966,
			zh = 1.966
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play418071039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10135"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps10135 == nil then
				arg_152_1.var_.actorSpriteComps10135 = var_155_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_2 = 0.2

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.actorSpriteComps10135 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								local var_155_4 = Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor1.r, var_155_3)
								local var_155_5 = Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor1.g, var_155_3)
								local var_155_6 = Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor1.b, var_155_3)

								iter_155_1.color = Color.New(var_155_4, var_155_5, var_155_6)
							else
								local var_155_7 = Mathf.Lerp(iter_155_1.color.r, 1, var_155_3)

								iter_155_1.color = Color.New(var_155_7, var_155_7, var_155_7)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps10135 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_155_3 then
						if arg_152_1.isInRecall_ then
							iter_155_3.color = arg_152_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_155_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps10135 = nil
			end

			local var_155_8 = arg_152_1.actors_["1073"]
			local var_155_9 = 0

			if var_155_9 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 and not isNil(var_155_8) and arg_152_1.var_.actorSpriteComps1073 == nil then
				arg_152_1.var_.actorSpriteComps1073 = var_155_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_10 = 0.2

			if var_155_9 <= arg_152_1.time_ and arg_152_1.time_ < var_155_9 + var_155_10 and not isNil(var_155_8) then
				local var_155_11 = (arg_152_1.time_ - var_155_9) / var_155_10

				if arg_152_1.var_.actorSpriteComps1073 then
					for iter_155_4, iter_155_5 in pairs(arg_152_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_155_5 then
							if arg_152_1.isInRecall_ then
								local var_155_12 = Mathf.Lerp(iter_155_5.color.r, arg_152_1.hightColor2.r, var_155_11)
								local var_155_13 = Mathf.Lerp(iter_155_5.color.g, arg_152_1.hightColor2.g, var_155_11)
								local var_155_14 = Mathf.Lerp(iter_155_5.color.b, arg_152_1.hightColor2.b, var_155_11)

								iter_155_5.color = Color.New(var_155_12, var_155_13, var_155_14)
							else
								local var_155_15 = Mathf.Lerp(iter_155_5.color.r, 0.5, var_155_11)

								iter_155_5.color = Color.New(var_155_15, var_155_15, var_155_15)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_9 + var_155_10 and arg_152_1.time_ < var_155_9 + var_155_10 + arg_155_0 and not isNil(var_155_8) and arg_152_1.var_.actorSpriteComps1073 then
				for iter_155_6, iter_155_7 in pairs(arg_152_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_155_7 then
						if arg_152_1.isInRecall_ then
							iter_155_7.color = arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_155_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps1073 = nil
			end

			local var_155_16 = arg_152_1.actors_["10135"].transform
			local var_155_17 = 0

			if var_155_17 < arg_152_1.time_ and arg_152_1.time_ <= var_155_17 + arg_155_0 then
				arg_152_1.var_.moveOldPos10135 = var_155_16.localPosition
				var_155_16.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("10135", 4)

				local var_155_18 = var_155_16.childCount

				for iter_155_8 = 0, var_155_18 - 1 do
					local var_155_19 = var_155_16:GetChild(iter_155_8)

					if var_155_19.name == "split_5" or not string.find(var_155_19.name, "split") then
						var_155_19.gameObject:SetActive(true)
					else
						var_155_19.gameObject:SetActive(false)
					end
				end
			end

			local var_155_20 = 0.001

			if var_155_17 <= arg_152_1.time_ and arg_152_1.time_ < var_155_17 + var_155_20 then
				local var_155_21 = (arg_152_1.time_ - var_155_17) / var_155_20
				local var_155_22 = Vector3.New(432.72, -363.6, -305.9)

				var_155_16.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10135, var_155_22, var_155_21)
			end

			if arg_152_1.time_ >= var_155_17 + var_155_20 and arg_152_1.time_ < var_155_17 + var_155_20 + arg_155_0 then
				var_155_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_155_23 = 0
			local var_155_24 = 0.05

			if var_155_23 < arg_152_1.time_ and arg_152_1.time_ <= var_155_23 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_25 = arg_152_1:FormatText(StoryNameCfg[1187].name)

				arg_152_1.leftNameTxt_.text = var_155_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_26 = arg_152_1:GetWordFromCfg(418071038)
				local var_155_27 = arg_152_1:FormatText(var_155_26.content)

				arg_152_1.text_.text = var_155_27

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_28 = 2
				local var_155_29 = utf8.len(var_155_27)
				local var_155_30 = var_155_28 <= 0 and var_155_24 or var_155_24 * (var_155_29 / var_155_28)

				if var_155_30 > 0 and var_155_24 < var_155_30 then
					arg_152_1.talkMaxDuration = var_155_30

					if var_155_30 + var_155_23 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_30 + var_155_23
					end
				end

				arg_152_1.text_.text = var_155_27
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071038", "story_v_side_old_418071.awb") ~= 0 then
					local var_155_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071038", "story_v_side_old_418071.awb") / 1000

					if var_155_31 + var_155_23 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_31 + var_155_23
					end

					if var_155_26.prefab_name ~= "" and arg_152_1.actors_[var_155_26.prefab_name] ~= nil then
						local var_155_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_26.prefab_name].transform, "story_v_side_old_418071", "418071038", "story_v_side_old_418071.awb")

						arg_152_1:RecordAudio("418071038", var_155_32)
						arg_152_1:RecordAudio("418071038", var_155_32)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071038", "story_v_side_old_418071.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071038", "story_v_side_old_418071.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_33 = math.max(var_155_24, arg_152_1.talkMaxDuration)

			if var_155_23 <= arg_152_1.time_ and arg_152_1.time_ < var_155_23 + var_155_33 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_23) / var_155_33

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_23 + var_155_33 and arg_152_1.time_ < var_155_23 + var_155_33 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play418071039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 418071039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play418071040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10135"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps10135 == nil then
				arg_156_1.var_.actorSpriteComps10135 = var_159_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.actorSpriteComps10135 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								local var_159_4 = Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor2.r, var_159_3)
								local var_159_5 = Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor2.g, var_159_3)
								local var_159_6 = Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor2.b, var_159_3)

								iter_159_1.color = Color.New(var_159_4, var_159_5, var_159_6)
							else
								local var_159_7 = Mathf.Lerp(iter_159_1.color.r, 0.5, var_159_3)

								iter_159_1.color = Color.New(var_159_7, var_159_7, var_159_7)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps10135 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_159_3 then
						if arg_156_1.isInRecall_ then
							iter_159_3.color = arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_159_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps10135 = nil
			end

			local var_159_8 = arg_156_1.actors_["1073"].transform
			local var_159_9 = 0

			if var_159_9 < arg_156_1.time_ and arg_156_1.time_ <= var_159_9 + arg_159_0 then
				arg_156_1.var_.moveOldPos1073 = var_159_8.localPosition
				var_159_8.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("1073", 7)

				local var_159_10 = var_159_8.childCount

				for iter_159_4 = 0, var_159_10 - 1 do
					local var_159_11 = var_159_8:GetChild(iter_159_4)

					if var_159_11.name == "" or not string.find(var_159_11.name, "split") then
						var_159_11.gameObject:SetActive(true)
					else
						var_159_11.gameObject:SetActive(false)
					end
				end
			end

			local var_159_12 = 0.001

			if var_159_9 <= arg_156_1.time_ and arg_156_1.time_ < var_159_9 + var_159_12 then
				local var_159_13 = (arg_156_1.time_ - var_159_9) / var_159_12
				local var_159_14 = Vector3.New(0, -2000, 0)

				var_159_8.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1073, var_159_14, var_159_13)
			end

			if arg_156_1.time_ >= var_159_9 + var_159_12 and arg_156_1.time_ < var_159_9 + var_159_12 + arg_159_0 then
				var_159_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_159_15 = arg_156_1.actors_["10135"].transform
			local var_159_16 = 0

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.var_.moveOldPos10135 = var_159_15.localPosition
				var_159_15.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("10135", 7)

				local var_159_17 = var_159_15.childCount

				for iter_159_5 = 0, var_159_17 - 1 do
					local var_159_18 = var_159_15:GetChild(iter_159_5)

					if var_159_18.name == "" or not string.find(var_159_18.name, "split") then
						var_159_18.gameObject:SetActive(true)
					else
						var_159_18.gameObject:SetActive(false)
					end
				end
			end

			local var_159_19 = 0.001

			if var_159_16 <= arg_156_1.time_ and arg_156_1.time_ < var_159_16 + var_159_19 then
				local var_159_20 = (arg_156_1.time_ - var_159_16) / var_159_19
				local var_159_21 = Vector3.New(0, -2000, 0)

				var_159_15.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10135, var_159_21, var_159_20)
			end

			if arg_156_1.time_ >= var_159_16 + var_159_19 and arg_156_1.time_ < var_159_16 + var_159_19 + arg_159_0 then
				var_159_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_159_22 = 0
			local var_159_23 = 1.375

			if var_159_22 < arg_156_1.time_ and arg_156_1.time_ <= var_159_22 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_24 = arg_156_1:GetWordFromCfg(418071039)
				local var_159_25 = arg_156_1:FormatText(var_159_24.content)

				arg_156_1.text_.text = var_159_25

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_26 = 55
				local var_159_27 = utf8.len(var_159_25)
				local var_159_28 = var_159_26 <= 0 and var_159_23 or var_159_23 * (var_159_27 / var_159_26)

				if var_159_28 > 0 and var_159_23 < var_159_28 then
					arg_156_1.talkMaxDuration = var_159_28

					if var_159_28 + var_159_22 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_28 + var_159_22
					end
				end

				arg_156_1.text_.text = var_159_25
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_29 = math.max(var_159_23, arg_156_1.talkMaxDuration)

			if var_159_22 <= arg_156_1.time_ and arg_156_1.time_ < var_159_22 + var_159_29 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_22) / var_159_29

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_22 + var_159_29 and arg_156_1.time_ < var_159_22 + var_159_29 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play418071040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 418071040
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play418071041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.975

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_2 = arg_160_1:GetWordFromCfg(418071040)
				local var_163_3 = arg_160_1:FormatText(var_163_2.content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 39
				local var_163_5 = utf8.len(var_163_3)
				local var_163_6 = var_163_4 <= 0 and var_163_1 or var_163_1 * (var_163_5 / var_163_4)

				if var_163_6 > 0 and var_163_1 < var_163_6 then
					arg_160_1.talkMaxDuration = var_163_6

					if var_163_6 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_6 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_7 and arg_160_1.time_ < var_163_0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play418071041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 418071041
		arg_164_1.duration_ = 6.67

		local var_164_0 = {
			ja = 6.033,
			CriLanguages = 6.666,
			zh = 6.666
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play418071042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["10135"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.actorSpriteComps10135 == nil then
				arg_164_1.var_.actorSpriteComps10135 = var_167_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_2 = 0.2

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.actorSpriteComps10135 then
					for iter_167_0, iter_167_1 in pairs(arg_164_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_167_1 then
							if arg_164_1.isInRecall_ then
								local var_167_4 = Mathf.Lerp(iter_167_1.color.r, arg_164_1.hightColor1.r, var_167_3)
								local var_167_5 = Mathf.Lerp(iter_167_1.color.g, arg_164_1.hightColor1.g, var_167_3)
								local var_167_6 = Mathf.Lerp(iter_167_1.color.b, arg_164_1.hightColor1.b, var_167_3)

								iter_167_1.color = Color.New(var_167_4, var_167_5, var_167_6)
							else
								local var_167_7 = Mathf.Lerp(iter_167_1.color.r, 1, var_167_3)

								iter_167_1.color = Color.New(var_167_7, var_167_7, var_167_7)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.actorSpriteComps10135 then
				for iter_167_2, iter_167_3 in pairs(arg_164_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_167_3 then
						if arg_164_1.isInRecall_ then
							iter_167_3.color = arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_167_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_164_1.var_.actorSpriteComps10135 = nil
			end

			local var_167_8 = arg_164_1.actors_["10135"].transform
			local var_167_9 = 0

			if var_167_9 < arg_164_1.time_ and arg_164_1.time_ <= var_167_9 + arg_167_0 then
				arg_164_1.var_.moveOldPos10135 = var_167_8.localPosition
				var_167_8.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("10135", 4)

				local var_167_10 = var_167_8.childCount

				for iter_167_4 = 0, var_167_10 - 1 do
					local var_167_11 = var_167_8:GetChild(iter_167_4)

					if var_167_11.name == "" or not string.find(var_167_11.name, "split") then
						var_167_11.gameObject:SetActive(true)
					else
						var_167_11.gameObject:SetActive(false)
					end
				end
			end

			local var_167_12 = 0.001

			if var_167_9 <= arg_164_1.time_ and arg_164_1.time_ < var_167_9 + var_167_12 then
				local var_167_13 = (arg_164_1.time_ - var_167_9) / var_167_12
				local var_167_14 = Vector3.New(432.72, -363.6, -305.9)

				var_167_8.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10135, var_167_14, var_167_13)
			end

			if arg_164_1.time_ >= var_167_9 + var_167_12 and arg_164_1.time_ < var_167_9 + var_167_12 + arg_167_0 then
				var_167_8.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_167_15 = 0
			local var_167_16 = 0.85

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_17 = arg_164_1:FormatText(StoryNameCfg[1187].name)

				arg_164_1.leftNameTxt_.text = var_167_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_18 = arg_164_1:GetWordFromCfg(418071041)
				local var_167_19 = arg_164_1:FormatText(var_167_18.content)

				arg_164_1.text_.text = var_167_19

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_20 = 33
				local var_167_21 = utf8.len(var_167_19)
				local var_167_22 = var_167_20 <= 0 and var_167_16 or var_167_16 * (var_167_21 / var_167_20)

				if var_167_22 > 0 and var_167_16 < var_167_22 then
					arg_164_1.talkMaxDuration = var_167_22

					if var_167_22 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_22 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_19
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071041", "story_v_side_old_418071.awb") ~= 0 then
					local var_167_23 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071041", "story_v_side_old_418071.awb") / 1000

					if var_167_23 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_23 + var_167_15
					end

					if var_167_18.prefab_name ~= "" and arg_164_1.actors_[var_167_18.prefab_name] ~= nil then
						local var_167_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_18.prefab_name].transform, "story_v_side_old_418071", "418071041", "story_v_side_old_418071.awb")

						arg_164_1:RecordAudio("418071041", var_167_24)
						arg_164_1:RecordAudio("418071041", var_167_24)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071041", "story_v_side_old_418071.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071041", "story_v_side_old_418071.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_25 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 <= arg_164_1.time_ and arg_164_1.time_ < var_167_15 + var_167_25 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_15) / var_167_25

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_15 + var_167_25 and arg_164_1.time_ < var_167_15 + var_167_25 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play418071042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 418071042
		arg_168_1.duration_ = 3.73

		local var_168_0 = {
			ja = 2.9,
			CriLanguages = 3.733,
			zh = 3.733
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play418071043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1073"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1073 == nil then
				arg_168_1.var_.actorSpriteComps1073 = var_171_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.actorSpriteComps1073 then
					for iter_171_0, iter_171_1 in pairs(arg_168_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_171_1 then
							if arg_168_1.isInRecall_ then
								local var_171_4 = Mathf.Lerp(iter_171_1.color.r, arg_168_1.hightColor1.r, var_171_3)
								local var_171_5 = Mathf.Lerp(iter_171_1.color.g, arg_168_1.hightColor1.g, var_171_3)
								local var_171_6 = Mathf.Lerp(iter_171_1.color.b, arg_168_1.hightColor1.b, var_171_3)

								iter_171_1.color = Color.New(var_171_4, var_171_5, var_171_6)
							else
								local var_171_7 = Mathf.Lerp(iter_171_1.color.r, 1, var_171_3)

								iter_171_1.color = Color.New(var_171_7, var_171_7, var_171_7)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1073 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_171_3 then
						if arg_168_1.isInRecall_ then
							iter_171_3.color = arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_171_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps1073 = nil
			end

			local var_171_8 = arg_168_1.actors_["10135"]
			local var_171_9 = 0

			if var_171_9 < arg_168_1.time_ and arg_168_1.time_ <= var_171_9 + arg_171_0 and not isNil(var_171_8) and arg_168_1.var_.actorSpriteComps10135 == nil then
				arg_168_1.var_.actorSpriteComps10135 = var_171_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_10 = 0.2

			if var_171_9 <= arg_168_1.time_ and arg_168_1.time_ < var_171_9 + var_171_10 and not isNil(var_171_8) then
				local var_171_11 = (arg_168_1.time_ - var_171_9) / var_171_10

				if arg_168_1.var_.actorSpriteComps10135 then
					for iter_171_4, iter_171_5 in pairs(arg_168_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_171_5 then
							if arg_168_1.isInRecall_ then
								local var_171_12 = Mathf.Lerp(iter_171_5.color.r, arg_168_1.hightColor2.r, var_171_11)
								local var_171_13 = Mathf.Lerp(iter_171_5.color.g, arg_168_1.hightColor2.g, var_171_11)
								local var_171_14 = Mathf.Lerp(iter_171_5.color.b, arg_168_1.hightColor2.b, var_171_11)

								iter_171_5.color = Color.New(var_171_12, var_171_13, var_171_14)
							else
								local var_171_15 = Mathf.Lerp(iter_171_5.color.r, 0.5, var_171_11)

								iter_171_5.color = Color.New(var_171_15, var_171_15, var_171_15)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= var_171_9 + var_171_10 and arg_168_1.time_ < var_171_9 + var_171_10 + arg_171_0 and not isNil(var_171_8) and arg_168_1.var_.actorSpriteComps10135 then
				for iter_171_6, iter_171_7 in pairs(arg_168_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_171_7 then
						if arg_168_1.isInRecall_ then
							iter_171_7.color = arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_171_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps10135 = nil
			end

			local var_171_16 = arg_168_1.actors_["1073"].transform
			local var_171_17 = 0

			if var_171_17 < arg_168_1.time_ and arg_168_1.time_ <= var_171_17 + arg_171_0 then
				arg_168_1.var_.moveOldPos1073 = var_171_16.localPosition
				var_171_16.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("1073", 2)

				local var_171_18 = var_171_16.childCount

				for iter_171_8 = 0, var_171_18 - 1 do
					local var_171_19 = var_171_16:GetChild(iter_171_8)

					if var_171_19.name == "" or not string.find(var_171_19.name, "split") then
						var_171_19.gameObject:SetActive(true)
					else
						var_171_19.gameObject:SetActive(false)
					end
				end
			end

			local var_171_20 = 0.001

			if var_171_17 <= arg_168_1.time_ and arg_168_1.time_ < var_171_17 + var_171_20 then
				local var_171_21 = (arg_168_1.time_ - var_171_17) / var_171_20
				local var_171_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_171_16.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1073, var_171_22, var_171_21)
			end

			if arg_168_1.time_ >= var_171_17 + var_171_20 and arg_168_1.time_ < var_171_17 + var_171_20 + arg_171_0 then
				var_171_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_171_23 = 0
			local var_171_24 = 0.425

			if var_171_23 < arg_168_1.time_ and arg_168_1.time_ <= var_171_23 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_25 = arg_168_1:FormatText(StoryNameCfg[380].name)

				arg_168_1.leftNameTxt_.text = var_171_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_26 = arg_168_1:GetWordFromCfg(418071042)
				local var_171_27 = arg_168_1:FormatText(var_171_26.content)

				arg_168_1.text_.text = var_171_27

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_28 = 17
				local var_171_29 = utf8.len(var_171_27)
				local var_171_30 = var_171_28 <= 0 and var_171_24 or var_171_24 * (var_171_29 / var_171_28)

				if var_171_30 > 0 and var_171_24 < var_171_30 then
					arg_168_1.talkMaxDuration = var_171_30

					if var_171_30 + var_171_23 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_30 + var_171_23
					end
				end

				arg_168_1.text_.text = var_171_27
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071042", "story_v_side_old_418071.awb") ~= 0 then
					local var_171_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071042", "story_v_side_old_418071.awb") / 1000

					if var_171_31 + var_171_23 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_31 + var_171_23
					end

					if var_171_26.prefab_name ~= "" and arg_168_1.actors_[var_171_26.prefab_name] ~= nil then
						local var_171_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_26.prefab_name].transform, "story_v_side_old_418071", "418071042", "story_v_side_old_418071.awb")

						arg_168_1:RecordAudio("418071042", var_171_32)
						arg_168_1:RecordAudio("418071042", var_171_32)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071042", "story_v_side_old_418071.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071042", "story_v_side_old_418071.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_33 = math.max(var_171_24, arg_168_1.talkMaxDuration)

			if var_171_23 <= arg_168_1.time_ and arg_168_1.time_ < var_171_23 + var_171_33 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_23) / var_171_33

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_23 + var_171_33 and arg_168_1.time_ < var_171_23 + var_171_33 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
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
	Play418071043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 418071043
		arg_172_1.duration_ = 11.8

		local var_172_0 = {
			ja = 11.8,
			CriLanguages = 6.066,
			zh = 6.066
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
				arg_172_0:Play418071044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10135"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps10135 == nil then
				arg_172_1.var_.actorSpriteComps10135 = var_175_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.actorSpriteComps10135 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								local var_175_4 = Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor1.r, var_175_3)
								local var_175_5 = Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor1.g, var_175_3)
								local var_175_6 = Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor1.b, var_175_3)

								iter_175_1.color = Color.New(var_175_4, var_175_5, var_175_6)
							else
								local var_175_7 = Mathf.Lerp(iter_175_1.color.r, 1, var_175_3)

								iter_175_1.color = Color.New(var_175_7, var_175_7, var_175_7)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps10135 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_175_3 then
						if arg_172_1.isInRecall_ then
							iter_175_3.color = arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_175_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps10135 = nil
			end

			local var_175_8 = arg_172_1.actors_["1073"]
			local var_175_9 = 0

			if var_175_9 < arg_172_1.time_ and arg_172_1.time_ <= var_175_9 + arg_175_0 and not isNil(var_175_8) and arg_172_1.var_.actorSpriteComps1073 == nil then
				arg_172_1.var_.actorSpriteComps1073 = var_175_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_10 = 0.2

			if var_175_9 <= arg_172_1.time_ and arg_172_1.time_ < var_175_9 + var_175_10 and not isNil(var_175_8) then
				local var_175_11 = (arg_172_1.time_ - var_175_9) / var_175_10

				if arg_172_1.var_.actorSpriteComps1073 then
					for iter_175_4, iter_175_5 in pairs(arg_172_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_175_5 then
							if arg_172_1.isInRecall_ then
								local var_175_12 = Mathf.Lerp(iter_175_5.color.r, arg_172_1.hightColor2.r, var_175_11)
								local var_175_13 = Mathf.Lerp(iter_175_5.color.g, arg_172_1.hightColor2.g, var_175_11)
								local var_175_14 = Mathf.Lerp(iter_175_5.color.b, arg_172_1.hightColor2.b, var_175_11)

								iter_175_5.color = Color.New(var_175_12, var_175_13, var_175_14)
							else
								local var_175_15 = Mathf.Lerp(iter_175_5.color.r, 0.5, var_175_11)

								iter_175_5.color = Color.New(var_175_15, var_175_15, var_175_15)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= var_175_9 + var_175_10 and arg_172_1.time_ < var_175_9 + var_175_10 + arg_175_0 and not isNil(var_175_8) and arg_172_1.var_.actorSpriteComps1073 then
				for iter_175_6, iter_175_7 in pairs(arg_172_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_175_7 then
						if arg_172_1.isInRecall_ then
							iter_175_7.color = arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_175_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps1073 = nil
			end

			local var_175_16 = 0
			local var_175_17 = 0.625

			if var_175_16 < arg_172_1.time_ and arg_172_1.time_ <= var_175_16 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_18 = arg_172_1:FormatText(StoryNameCfg[1187].name)

				arg_172_1.leftNameTxt_.text = var_175_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_19 = arg_172_1:GetWordFromCfg(418071043)
				local var_175_20 = arg_172_1:FormatText(var_175_19.content)

				arg_172_1.text_.text = var_175_20

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_21 = 25
				local var_175_22 = utf8.len(var_175_20)
				local var_175_23 = var_175_21 <= 0 and var_175_17 or var_175_17 * (var_175_22 / var_175_21)

				if var_175_23 > 0 and var_175_17 < var_175_23 then
					arg_172_1.talkMaxDuration = var_175_23

					if var_175_23 + var_175_16 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_16
					end
				end

				arg_172_1.text_.text = var_175_20
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071043", "story_v_side_old_418071.awb") ~= 0 then
					local var_175_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071043", "story_v_side_old_418071.awb") / 1000

					if var_175_24 + var_175_16 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_24 + var_175_16
					end

					if var_175_19.prefab_name ~= "" and arg_172_1.actors_[var_175_19.prefab_name] ~= nil then
						local var_175_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_19.prefab_name].transform, "story_v_side_old_418071", "418071043", "story_v_side_old_418071.awb")

						arg_172_1:RecordAudio("418071043", var_175_25)
						arg_172_1:RecordAudio("418071043", var_175_25)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071043", "story_v_side_old_418071.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071043", "story_v_side_old_418071.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_26 = math.max(var_175_17, arg_172_1.talkMaxDuration)

			if var_175_16 <= arg_172_1.time_ and arg_172_1.time_ < var_175_16 + var_175_26 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_16) / var_175_26

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_16 + var_175_26 and arg_172_1.time_ < var_175_16 + var_175_26 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play418071044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 418071044
		arg_176_1.duration_ = 6.13

		local var_176_0 = {
			ja = 5.4,
			CriLanguages = 6.133,
			zh = 6.133
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
				arg_176_0:Play418071045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1073"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1073 == nil then
				arg_176_1.var_.actorSpriteComps1073 = var_179_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.actorSpriteComps1073 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_179_1 then
							if arg_176_1.isInRecall_ then
								local var_179_4 = Mathf.Lerp(iter_179_1.color.r, arg_176_1.hightColor1.r, var_179_3)
								local var_179_5 = Mathf.Lerp(iter_179_1.color.g, arg_176_1.hightColor1.g, var_179_3)
								local var_179_6 = Mathf.Lerp(iter_179_1.color.b, arg_176_1.hightColor1.b, var_179_3)

								iter_179_1.color = Color.New(var_179_4, var_179_5, var_179_6)
							else
								local var_179_7 = Mathf.Lerp(iter_179_1.color.r, 1, var_179_3)

								iter_179_1.color = Color.New(var_179_7, var_179_7, var_179_7)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1073 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_179_3 then
						if arg_176_1.isInRecall_ then
							iter_179_3.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_179_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps1073 = nil
			end

			local var_179_8 = arg_176_1.actors_["10135"]
			local var_179_9 = 0

			if var_179_9 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps10135 == nil then
				arg_176_1.var_.actorSpriteComps10135 = var_179_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_10 = 0.2

			if var_179_9 <= arg_176_1.time_ and arg_176_1.time_ < var_179_9 + var_179_10 and not isNil(var_179_8) then
				local var_179_11 = (arg_176_1.time_ - var_179_9) / var_179_10

				if arg_176_1.var_.actorSpriteComps10135 then
					for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_179_5 then
							if arg_176_1.isInRecall_ then
								local var_179_12 = Mathf.Lerp(iter_179_5.color.r, arg_176_1.hightColor2.r, var_179_11)
								local var_179_13 = Mathf.Lerp(iter_179_5.color.g, arg_176_1.hightColor2.g, var_179_11)
								local var_179_14 = Mathf.Lerp(iter_179_5.color.b, arg_176_1.hightColor2.b, var_179_11)

								iter_179_5.color = Color.New(var_179_12, var_179_13, var_179_14)
							else
								local var_179_15 = Mathf.Lerp(iter_179_5.color.r, 0.5, var_179_11)

								iter_179_5.color = Color.New(var_179_15, var_179_15, var_179_15)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_9 + var_179_10 and arg_176_1.time_ < var_179_9 + var_179_10 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps10135 then
				for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_179_7 then
						if arg_176_1.isInRecall_ then
							iter_179_7.color = arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_179_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10135 = nil
			end

			local var_179_16 = arg_176_1.actors_["1073"].transform
			local var_179_17 = 0

			if var_179_17 < arg_176_1.time_ and arg_176_1.time_ <= var_179_17 + arg_179_0 then
				arg_176_1.var_.moveOldPos1073 = var_179_16.localPosition
				var_179_16.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("1073", 2)

				local var_179_18 = var_179_16.childCount

				for iter_179_8 = 0, var_179_18 - 1 do
					local var_179_19 = var_179_16:GetChild(iter_179_8)

					if var_179_19.name == "split_2" or not string.find(var_179_19.name, "split") then
						var_179_19.gameObject:SetActive(true)
					else
						var_179_19.gameObject:SetActive(false)
					end
				end
			end

			local var_179_20 = 0.001

			if var_179_17 <= arg_176_1.time_ and arg_176_1.time_ < var_179_17 + var_179_20 then
				local var_179_21 = (arg_176_1.time_ - var_179_17) / var_179_20
				local var_179_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_179_16.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1073, var_179_22, var_179_21)
			end

			if arg_176_1.time_ >= var_179_17 + var_179_20 and arg_176_1.time_ < var_179_17 + var_179_20 + arg_179_0 then
				var_179_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_179_23 = 0
			local var_179_24 = 0.525

			if var_179_23 < arg_176_1.time_ and arg_176_1.time_ <= var_179_23 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_25 = arg_176_1:FormatText(StoryNameCfg[380].name)

				arg_176_1.leftNameTxt_.text = var_179_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_26 = arg_176_1:GetWordFromCfg(418071044)
				local var_179_27 = arg_176_1:FormatText(var_179_26.content)

				arg_176_1.text_.text = var_179_27

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_28 = 21
				local var_179_29 = utf8.len(var_179_27)
				local var_179_30 = var_179_28 <= 0 and var_179_24 or var_179_24 * (var_179_29 / var_179_28)

				if var_179_30 > 0 and var_179_24 < var_179_30 then
					arg_176_1.talkMaxDuration = var_179_30

					if var_179_30 + var_179_23 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_30 + var_179_23
					end
				end

				arg_176_1.text_.text = var_179_27
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071044", "story_v_side_old_418071.awb") ~= 0 then
					local var_179_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071044", "story_v_side_old_418071.awb") / 1000

					if var_179_31 + var_179_23 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_31 + var_179_23
					end

					if var_179_26.prefab_name ~= "" and arg_176_1.actors_[var_179_26.prefab_name] ~= nil then
						local var_179_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_26.prefab_name].transform, "story_v_side_old_418071", "418071044", "story_v_side_old_418071.awb")

						arg_176_1:RecordAudio("418071044", var_179_32)
						arg_176_1:RecordAudio("418071044", var_179_32)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071044", "story_v_side_old_418071.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071044", "story_v_side_old_418071.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_33 = math.max(var_179_24, arg_176_1.talkMaxDuration)

			if var_179_23 <= arg_176_1.time_ and arg_176_1.time_ < var_179_23 + var_179_33 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_23) / var_179_33

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_23 + var_179_33 and arg_176_1.time_ < var_179_23 + var_179_33 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
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
	Play418071045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 418071045
		arg_180_1.duration_ = 5.6

		local var_180_0 = {
			ja = 5.6,
			CriLanguages = 5.566,
			zh = 5.566
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
				arg_180_0:Play418071046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10135"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10135 == nil then
				arg_180_1.var_.actorSpriteComps10135 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps10135 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								local var_183_4 = Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor1.r, var_183_3)
								local var_183_5 = Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor1.g, var_183_3)
								local var_183_6 = Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor1.b, var_183_3)

								iter_183_1.color = Color.New(var_183_4, var_183_5, var_183_6)
							else
								local var_183_7 = Mathf.Lerp(iter_183_1.color.r, 1, var_183_3)

								iter_183_1.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10135 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10135 = nil
			end

			local var_183_8 = arg_180_1.actors_["1073"]
			local var_183_9 = 0

			if var_183_9 < arg_180_1.time_ and arg_180_1.time_ <= var_183_9 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps1073 == nil then
				arg_180_1.var_.actorSpriteComps1073 = var_183_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_10 = 0.2

			if var_183_9 <= arg_180_1.time_ and arg_180_1.time_ < var_183_9 + var_183_10 and not isNil(var_183_8) then
				local var_183_11 = (arg_180_1.time_ - var_183_9) / var_183_10

				if arg_180_1.var_.actorSpriteComps1073 then
					for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_183_5 then
							if arg_180_1.isInRecall_ then
								local var_183_12 = Mathf.Lerp(iter_183_5.color.r, arg_180_1.hightColor2.r, var_183_11)
								local var_183_13 = Mathf.Lerp(iter_183_5.color.g, arg_180_1.hightColor2.g, var_183_11)
								local var_183_14 = Mathf.Lerp(iter_183_5.color.b, arg_180_1.hightColor2.b, var_183_11)

								iter_183_5.color = Color.New(var_183_12, var_183_13, var_183_14)
							else
								local var_183_15 = Mathf.Lerp(iter_183_5.color.r, 0.5, var_183_11)

								iter_183_5.color = Color.New(var_183_15, var_183_15, var_183_15)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_9 + var_183_10 and arg_180_1.time_ < var_183_9 + var_183_10 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps1073 then
				for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_183_7 then
						if arg_180_1.isInRecall_ then
							iter_183_7.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1073 = nil
			end

			local var_183_16 = arg_180_1.actors_["10135"].transform
			local var_183_17 = 0

			if var_183_17 < arg_180_1.time_ and arg_180_1.time_ <= var_183_17 + arg_183_0 then
				arg_180_1.var_.moveOldPos10135 = var_183_16.localPosition
				var_183_16.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10135", 4)

				local var_183_18 = var_183_16.childCount

				for iter_183_8 = 0, var_183_18 - 1 do
					local var_183_19 = var_183_16:GetChild(iter_183_8)

					if var_183_19.name == "split_2" or not string.find(var_183_19.name, "split") then
						var_183_19.gameObject:SetActive(true)
					else
						var_183_19.gameObject:SetActive(false)
					end
				end
			end

			local var_183_20 = 0.001

			if var_183_17 <= arg_180_1.time_ and arg_180_1.time_ < var_183_17 + var_183_20 then
				local var_183_21 = (arg_180_1.time_ - var_183_17) / var_183_20
				local var_183_22 = Vector3.New(432.72, -363.6, -305.9)

				var_183_16.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10135, var_183_22, var_183_21)
			end

			if arg_180_1.time_ >= var_183_17 + var_183_20 and arg_180_1.time_ < var_183_17 + var_183_20 + arg_183_0 then
				var_183_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_183_23 = 0
			local var_183_24 = 0.65

			if var_183_23 < arg_180_1.time_ and arg_180_1.time_ <= var_183_23 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_25 = arg_180_1:FormatText(StoryNameCfg[1187].name)

				arg_180_1.leftNameTxt_.text = var_183_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_26 = arg_180_1:GetWordFromCfg(418071045)
				local var_183_27 = arg_180_1:FormatText(var_183_26.content)

				arg_180_1.text_.text = var_183_27

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_28 = 26
				local var_183_29 = utf8.len(var_183_27)
				local var_183_30 = var_183_28 <= 0 and var_183_24 or var_183_24 * (var_183_29 / var_183_28)

				if var_183_30 > 0 and var_183_24 < var_183_30 then
					arg_180_1.talkMaxDuration = var_183_30

					if var_183_30 + var_183_23 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_30 + var_183_23
					end
				end

				arg_180_1.text_.text = var_183_27
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071045", "story_v_side_old_418071.awb") ~= 0 then
					local var_183_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071045", "story_v_side_old_418071.awb") / 1000

					if var_183_31 + var_183_23 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_31 + var_183_23
					end

					if var_183_26.prefab_name ~= "" and arg_180_1.actors_[var_183_26.prefab_name] ~= nil then
						local var_183_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_26.prefab_name].transform, "story_v_side_old_418071", "418071045", "story_v_side_old_418071.awb")

						arg_180_1:RecordAudio("418071045", var_183_32)
						arg_180_1:RecordAudio("418071045", var_183_32)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071045", "story_v_side_old_418071.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071045", "story_v_side_old_418071.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_33 = math.max(var_183_24, arg_180_1.talkMaxDuration)

			if var_183_23 <= arg_180_1.time_ and arg_180_1.time_ < var_183_23 + var_183_33 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_23) / var_183_33

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_23 + var_183_33 and arg_180_1.time_ < var_183_23 + var_183_33 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
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
	Play418071046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 418071046
		arg_184_1.duration_ = 3.9

		local var_184_0 = {
			ja = 3.633,
			CriLanguages = 3.9,
			zh = 3.9
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play418071047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1073"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps1073 == nil then
				arg_184_1.var_.actorSpriteComps1073 = var_187_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.actorSpriteComps1073 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								local var_187_4 = Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor1.r, var_187_3)
								local var_187_5 = Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor1.g, var_187_3)
								local var_187_6 = Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor1.b, var_187_3)

								iter_187_1.color = Color.New(var_187_4, var_187_5, var_187_6)
							else
								local var_187_7 = Mathf.Lerp(iter_187_1.color.r, 1, var_187_3)

								iter_187_1.color = Color.New(var_187_7, var_187_7, var_187_7)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps1073 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_187_3 then
						if arg_184_1.isInRecall_ then
							iter_187_3.color = arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_187_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps1073 = nil
			end

			local var_187_8 = arg_184_1.actors_["10135"]
			local var_187_9 = 0

			if var_187_9 < arg_184_1.time_ and arg_184_1.time_ <= var_187_9 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.actorSpriteComps10135 == nil then
				arg_184_1.var_.actorSpriteComps10135 = var_187_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_10 = 0.2

			if var_187_9 <= arg_184_1.time_ and arg_184_1.time_ < var_187_9 + var_187_10 and not isNil(var_187_8) then
				local var_187_11 = (arg_184_1.time_ - var_187_9) / var_187_10

				if arg_184_1.var_.actorSpriteComps10135 then
					for iter_187_4, iter_187_5 in pairs(arg_184_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_187_5 then
							if arg_184_1.isInRecall_ then
								local var_187_12 = Mathf.Lerp(iter_187_5.color.r, arg_184_1.hightColor2.r, var_187_11)
								local var_187_13 = Mathf.Lerp(iter_187_5.color.g, arg_184_1.hightColor2.g, var_187_11)
								local var_187_14 = Mathf.Lerp(iter_187_5.color.b, arg_184_1.hightColor2.b, var_187_11)

								iter_187_5.color = Color.New(var_187_12, var_187_13, var_187_14)
							else
								local var_187_15 = Mathf.Lerp(iter_187_5.color.r, 0.5, var_187_11)

								iter_187_5.color = Color.New(var_187_15, var_187_15, var_187_15)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_9 + var_187_10 and arg_184_1.time_ < var_187_9 + var_187_10 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.actorSpriteComps10135 then
				for iter_187_6, iter_187_7 in pairs(arg_184_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_187_7 then
						if arg_184_1.isInRecall_ then
							iter_187_7.color = arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_187_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10135 = nil
			end

			local var_187_16 = arg_184_1.actors_["1073"].transform
			local var_187_17 = 0

			if var_187_17 < arg_184_1.time_ and arg_184_1.time_ <= var_187_17 + arg_187_0 then
				arg_184_1.var_.moveOldPos1073 = var_187_16.localPosition
				var_187_16.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("1073", 2)

				local var_187_18 = var_187_16.childCount

				for iter_187_8 = 0, var_187_18 - 1 do
					local var_187_19 = var_187_16:GetChild(iter_187_8)

					if var_187_19.name == "" or not string.find(var_187_19.name, "split") then
						var_187_19.gameObject:SetActive(true)
					else
						var_187_19.gameObject:SetActive(false)
					end
				end
			end

			local var_187_20 = 0.001

			if var_187_17 <= arg_184_1.time_ and arg_184_1.time_ < var_187_17 + var_187_20 then
				local var_187_21 = (arg_184_1.time_ - var_187_17) / var_187_20
				local var_187_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_187_16.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1073, var_187_22, var_187_21)
			end

			if arg_184_1.time_ >= var_187_17 + var_187_20 and arg_184_1.time_ < var_187_17 + var_187_20 + arg_187_0 then
				var_187_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_187_23 = 0
			local var_187_24 = 0.35

			if var_187_23 < arg_184_1.time_ and arg_184_1.time_ <= var_187_23 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_25 = arg_184_1:FormatText(StoryNameCfg[380].name)

				arg_184_1.leftNameTxt_.text = var_187_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_26 = arg_184_1:GetWordFromCfg(418071046)
				local var_187_27 = arg_184_1:FormatText(var_187_26.content)

				arg_184_1.text_.text = var_187_27

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_28 = 14
				local var_187_29 = utf8.len(var_187_27)
				local var_187_30 = var_187_28 <= 0 and var_187_24 or var_187_24 * (var_187_29 / var_187_28)

				if var_187_30 > 0 and var_187_24 < var_187_30 then
					arg_184_1.talkMaxDuration = var_187_30

					if var_187_30 + var_187_23 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_30 + var_187_23
					end
				end

				arg_184_1.text_.text = var_187_27
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071046", "story_v_side_old_418071.awb") ~= 0 then
					local var_187_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071046", "story_v_side_old_418071.awb") / 1000

					if var_187_31 + var_187_23 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_31 + var_187_23
					end

					if var_187_26.prefab_name ~= "" and arg_184_1.actors_[var_187_26.prefab_name] ~= nil then
						local var_187_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_26.prefab_name].transform, "story_v_side_old_418071", "418071046", "story_v_side_old_418071.awb")

						arg_184_1:RecordAudio("418071046", var_187_32)
						arg_184_1:RecordAudio("418071046", var_187_32)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071046", "story_v_side_old_418071.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071046", "story_v_side_old_418071.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_33 = math.max(var_187_24, arg_184_1.talkMaxDuration)

			if var_187_23 <= arg_184_1.time_ and arg_184_1.time_ < var_187_23 + var_187_33 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_23) / var_187_33

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_23 + var_187_33 and arg_184_1.time_ < var_187_23 + var_187_33 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play418071047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 418071047
		arg_188_1.duration_ = 4.4

		local var_188_0 = {
			ja = 4.4,
			CriLanguages = 3.8,
			zh = 3.8
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
				arg_188_0:Play418071048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10135"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps10135 == nil then
				arg_188_1.var_.actorSpriteComps10135 = var_191_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.actorSpriteComps10135 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								local var_191_4 = Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor1.r, var_191_3)
								local var_191_5 = Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor1.g, var_191_3)
								local var_191_6 = Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor1.b, var_191_3)

								iter_191_1.color = Color.New(var_191_4, var_191_5, var_191_6)
							else
								local var_191_7 = Mathf.Lerp(iter_191_1.color.r, 1, var_191_3)

								iter_191_1.color = Color.New(var_191_7, var_191_7, var_191_7)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps10135 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_191_3 then
						if arg_188_1.isInRecall_ then
							iter_191_3.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_191_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10135 = nil
			end

			local var_191_8 = arg_188_1.actors_["1073"]
			local var_191_9 = 0

			if var_191_9 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps1073 == nil then
				arg_188_1.var_.actorSpriteComps1073 = var_191_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_10 = 0.2

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_10 and not isNil(var_191_8) then
				local var_191_11 = (arg_188_1.time_ - var_191_9) / var_191_10

				if arg_188_1.var_.actorSpriteComps1073 then
					for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_191_5 then
							if arg_188_1.isInRecall_ then
								local var_191_12 = Mathf.Lerp(iter_191_5.color.r, arg_188_1.hightColor2.r, var_191_11)
								local var_191_13 = Mathf.Lerp(iter_191_5.color.g, arg_188_1.hightColor2.g, var_191_11)
								local var_191_14 = Mathf.Lerp(iter_191_5.color.b, arg_188_1.hightColor2.b, var_191_11)

								iter_191_5.color = Color.New(var_191_12, var_191_13, var_191_14)
							else
								local var_191_15 = Mathf.Lerp(iter_191_5.color.r, 0.5, var_191_11)

								iter_191_5.color = Color.New(var_191_15, var_191_15, var_191_15)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_9 + var_191_10 and arg_188_1.time_ < var_191_9 + var_191_10 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps1073 then
				for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_191_7 then
						if arg_188_1.isInRecall_ then
							iter_191_7.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps1073 = nil
			end

			local var_191_16 = arg_188_1.actors_["10135"].transform
			local var_191_17 = 0

			if var_191_17 < arg_188_1.time_ and arg_188_1.time_ <= var_191_17 + arg_191_0 then
				arg_188_1.var_.moveOldPos10135 = var_191_16.localPosition
				var_191_16.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10135", 4)

				local var_191_18 = var_191_16.childCount

				for iter_191_8 = 0, var_191_18 - 1 do
					local var_191_19 = var_191_16:GetChild(iter_191_8)

					if var_191_19.name == "" or not string.find(var_191_19.name, "split") then
						var_191_19.gameObject:SetActive(true)
					else
						var_191_19.gameObject:SetActive(false)
					end
				end
			end

			local var_191_20 = 0.001

			if var_191_17 <= arg_188_1.time_ and arg_188_1.time_ < var_191_17 + var_191_20 then
				local var_191_21 = (arg_188_1.time_ - var_191_17) / var_191_20
				local var_191_22 = Vector3.New(432.72, -363.6, -305.9)

				var_191_16.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10135, var_191_22, var_191_21)
			end

			if arg_188_1.time_ >= var_191_17 + var_191_20 and arg_188_1.time_ < var_191_17 + var_191_20 + arg_191_0 then
				var_191_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_191_23 = 0
			local var_191_24 = 0.425

			if var_191_23 < arg_188_1.time_ and arg_188_1.time_ <= var_191_23 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_25 = arg_188_1:FormatText(StoryNameCfg[1187].name)

				arg_188_1.leftNameTxt_.text = var_191_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_26 = arg_188_1:GetWordFromCfg(418071047)
				local var_191_27 = arg_188_1:FormatText(var_191_26.content)

				arg_188_1.text_.text = var_191_27

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_28 = 17
				local var_191_29 = utf8.len(var_191_27)
				local var_191_30 = var_191_28 <= 0 and var_191_24 or var_191_24 * (var_191_29 / var_191_28)

				if var_191_30 > 0 and var_191_24 < var_191_30 then
					arg_188_1.talkMaxDuration = var_191_30

					if var_191_30 + var_191_23 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_30 + var_191_23
					end
				end

				arg_188_1.text_.text = var_191_27
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071047", "story_v_side_old_418071.awb") ~= 0 then
					local var_191_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071047", "story_v_side_old_418071.awb") / 1000

					if var_191_31 + var_191_23 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_31 + var_191_23
					end

					if var_191_26.prefab_name ~= "" and arg_188_1.actors_[var_191_26.prefab_name] ~= nil then
						local var_191_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_26.prefab_name].transform, "story_v_side_old_418071", "418071047", "story_v_side_old_418071.awb")

						arg_188_1:RecordAudio("418071047", var_191_32)
						arg_188_1:RecordAudio("418071047", var_191_32)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071047", "story_v_side_old_418071.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071047", "story_v_side_old_418071.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_33 = math.max(var_191_24, arg_188_1.talkMaxDuration)

			if var_191_23 <= arg_188_1.time_ and arg_188_1.time_ < var_191_23 + var_191_33 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_23) / var_191_33

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_23 + var_191_33 and arg_188_1.time_ < var_191_23 + var_191_33 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
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
	Play418071048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 418071048
		arg_192_1.duration_ = 7.53

		local var_192_0 = {
			ja = 7.533,
			CriLanguages = 7,
			zh = 7
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
				arg_192_0:Play418071049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1073"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1073 == nil then
				arg_192_1.var_.actorSpriteComps1073 = var_195_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.actorSpriteComps1073 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								local var_195_4 = Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor1.r, var_195_3)
								local var_195_5 = Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor1.g, var_195_3)
								local var_195_6 = Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor1.b, var_195_3)

								iter_195_1.color = Color.New(var_195_4, var_195_5, var_195_6)
							else
								local var_195_7 = Mathf.Lerp(iter_195_1.color.r, 1, var_195_3)

								iter_195_1.color = Color.New(var_195_7, var_195_7, var_195_7)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1073 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_195_3 then
						if arg_192_1.isInRecall_ then
							iter_195_3.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_195_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps1073 = nil
			end

			local var_195_8 = arg_192_1.actors_["10135"]
			local var_195_9 = 0

			if var_195_9 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps10135 == nil then
				arg_192_1.var_.actorSpriteComps10135 = var_195_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_10 = 0.2

			if var_195_9 <= arg_192_1.time_ and arg_192_1.time_ < var_195_9 + var_195_10 and not isNil(var_195_8) then
				local var_195_11 = (arg_192_1.time_ - var_195_9) / var_195_10

				if arg_192_1.var_.actorSpriteComps10135 then
					for iter_195_4, iter_195_5 in pairs(arg_192_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_195_5 then
							if arg_192_1.isInRecall_ then
								local var_195_12 = Mathf.Lerp(iter_195_5.color.r, arg_192_1.hightColor2.r, var_195_11)
								local var_195_13 = Mathf.Lerp(iter_195_5.color.g, arg_192_1.hightColor2.g, var_195_11)
								local var_195_14 = Mathf.Lerp(iter_195_5.color.b, arg_192_1.hightColor2.b, var_195_11)

								iter_195_5.color = Color.New(var_195_12, var_195_13, var_195_14)
							else
								local var_195_15 = Mathf.Lerp(iter_195_5.color.r, 0.5, var_195_11)

								iter_195_5.color = Color.New(var_195_15, var_195_15, var_195_15)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_9 + var_195_10 and arg_192_1.time_ < var_195_9 + var_195_10 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps10135 then
				for iter_195_6, iter_195_7 in pairs(arg_192_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_195_7 then
						if arg_192_1.isInRecall_ then
							iter_195_7.color = arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_195_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps10135 = nil
			end

			local var_195_16 = arg_192_1.actors_["1073"].transform
			local var_195_17 = 0

			if var_195_17 < arg_192_1.time_ and arg_192_1.time_ <= var_195_17 + arg_195_0 then
				arg_192_1.var_.moveOldPos1073 = var_195_16.localPosition
				var_195_16.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1073", 2)

				local var_195_18 = var_195_16.childCount

				for iter_195_8 = 0, var_195_18 - 1 do
					local var_195_19 = var_195_16:GetChild(iter_195_8)

					if var_195_19.name == "split_4" or not string.find(var_195_19.name, "split") then
						var_195_19.gameObject:SetActive(true)
					else
						var_195_19.gameObject:SetActive(false)
					end
				end
			end

			local var_195_20 = 0.001

			if var_195_17 <= arg_192_1.time_ and arg_192_1.time_ < var_195_17 + var_195_20 then
				local var_195_21 = (arg_192_1.time_ - var_195_17) / var_195_20
				local var_195_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_195_16.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1073, var_195_22, var_195_21)
			end

			if arg_192_1.time_ >= var_195_17 + var_195_20 and arg_192_1.time_ < var_195_17 + var_195_20 + arg_195_0 then
				var_195_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_195_23 = 0
			local var_195_24 = 0.775

			if var_195_23 < arg_192_1.time_ and arg_192_1.time_ <= var_195_23 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_25 = arg_192_1:FormatText(StoryNameCfg[380].name)

				arg_192_1.leftNameTxt_.text = var_195_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_26 = arg_192_1:GetWordFromCfg(418071048)
				local var_195_27 = arg_192_1:FormatText(var_195_26.content)

				arg_192_1.text_.text = var_195_27

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_28 = 31
				local var_195_29 = utf8.len(var_195_27)
				local var_195_30 = var_195_28 <= 0 and var_195_24 or var_195_24 * (var_195_29 / var_195_28)

				if var_195_30 > 0 and var_195_24 < var_195_30 then
					arg_192_1.talkMaxDuration = var_195_30

					if var_195_30 + var_195_23 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_30 + var_195_23
					end
				end

				arg_192_1.text_.text = var_195_27
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071048", "story_v_side_old_418071.awb") ~= 0 then
					local var_195_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071048", "story_v_side_old_418071.awb") / 1000

					if var_195_31 + var_195_23 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_31 + var_195_23
					end

					if var_195_26.prefab_name ~= "" and arg_192_1.actors_[var_195_26.prefab_name] ~= nil then
						local var_195_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_26.prefab_name].transform, "story_v_side_old_418071", "418071048", "story_v_side_old_418071.awb")

						arg_192_1:RecordAudio("418071048", var_195_32)
						arg_192_1:RecordAudio("418071048", var_195_32)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071048", "story_v_side_old_418071.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071048", "story_v_side_old_418071.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_33 = math.max(var_195_24, arg_192_1.talkMaxDuration)

			if var_195_23 <= arg_192_1.time_ and arg_192_1.time_ < var_195_23 + var_195_33 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_23) / var_195_33

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_23 + var_195_33 and arg_192_1.time_ < var_195_23 + var_195_33 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
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
	Play418071049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 418071049
		arg_196_1.duration_ = 7.6

		local var_196_0 = {
			ja = 7.6,
			CriLanguages = 5.033,
			zh = 5.033
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
				arg_196_0:Play418071050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10135"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps10135 == nil then
				arg_196_1.var_.actorSpriteComps10135 = var_199_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_2 = 0.2

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.actorSpriteComps10135 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								local var_199_4 = Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor1.r, var_199_3)
								local var_199_5 = Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor1.g, var_199_3)
								local var_199_6 = Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor1.b, var_199_3)

								iter_199_1.color = Color.New(var_199_4, var_199_5, var_199_6)
							else
								local var_199_7 = Mathf.Lerp(iter_199_1.color.r, 1, var_199_3)

								iter_199_1.color = Color.New(var_199_7, var_199_7, var_199_7)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps10135 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_199_3 then
						if arg_196_1.isInRecall_ then
							iter_199_3.color = arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_199_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps10135 = nil
			end

			local var_199_8 = arg_196_1.actors_["1073"]
			local var_199_9 = 0

			if var_199_9 < arg_196_1.time_ and arg_196_1.time_ <= var_199_9 + arg_199_0 and not isNil(var_199_8) and arg_196_1.var_.actorSpriteComps1073 == nil then
				arg_196_1.var_.actorSpriteComps1073 = var_199_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_10 = 0.2

			if var_199_9 <= arg_196_1.time_ and arg_196_1.time_ < var_199_9 + var_199_10 and not isNil(var_199_8) then
				local var_199_11 = (arg_196_1.time_ - var_199_9) / var_199_10

				if arg_196_1.var_.actorSpriteComps1073 then
					for iter_199_4, iter_199_5 in pairs(arg_196_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_199_5 then
							if arg_196_1.isInRecall_ then
								local var_199_12 = Mathf.Lerp(iter_199_5.color.r, arg_196_1.hightColor2.r, var_199_11)
								local var_199_13 = Mathf.Lerp(iter_199_5.color.g, arg_196_1.hightColor2.g, var_199_11)
								local var_199_14 = Mathf.Lerp(iter_199_5.color.b, arg_196_1.hightColor2.b, var_199_11)

								iter_199_5.color = Color.New(var_199_12, var_199_13, var_199_14)
							else
								local var_199_15 = Mathf.Lerp(iter_199_5.color.r, 0.5, var_199_11)

								iter_199_5.color = Color.New(var_199_15, var_199_15, var_199_15)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_9 + var_199_10 and arg_196_1.time_ < var_199_9 + var_199_10 + arg_199_0 and not isNil(var_199_8) and arg_196_1.var_.actorSpriteComps1073 then
				for iter_199_6, iter_199_7 in pairs(arg_196_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_199_7 then
						if arg_196_1.isInRecall_ then
							iter_199_7.color = arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_199_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps1073 = nil
			end

			local var_199_16 = 0
			local var_199_17 = 0.65

			if var_199_16 < arg_196_1.time_ and arg_196_1.time_ <= var_199_16 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_18 = arg_196_1:FormatText(StoryNameCfg[1187].name)

				arg_196_1.leftNameTxt_.text = var_199_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_19 = arg_196_1:GetWordFromCfg(418071049)
				local var_199_20 = arg_196_1:FormatText(var_199_19.content)

				arg_196_1.text_.text = var_199_20

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_21 = 26
				local var_199_22 = utf8.len(var_199_20)
				local var_199_23 = var_199_21 <= 0 and var_199_17 or var_199_17 * (var_199_22 / var_199_21)

				if var_199_23 > 0 and var_199_17 < var_199_23 then
					arg_196_1.talkMaxDuration = var_199_23

					if var_199_23 + var_199_16 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_23 + var_199_16
					end
				end

				arg_196_1.text_.text = var_199_20
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071049", "story_v_side_old_418071.awb") ~= 0 then
					local var_199_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071049", "story_v_side_old_418071.awb") / 1000

					if var_199_24 + var_199_16 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_24 + var_199_16
					end

					if var_199_19.prefab_name ~= "" and arg_196_1.actors_[var_199_19.prefab_name] ~= nil then
						local var_199_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_19.prefab_name].transform, "story_v_side_old_418071", "418071049", "story_v_side_old_418071.awb")

						arg_196_1:RecordAudio("418071049", var_199_25)
						arg_196_1:RecordAudio("418071049", var_199_25)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071049", "story_v_side_old_418071.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071049", "story_v_side_old_418071.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_26 = math.max(var_199_17, arg_196_1.talkMaxDuration)

			if var_199_16 <= arg_196_1.time_ and arg_196_1.time_ < var_199_16 + var_199_26 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_16) / var_199_26

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_16 + var_199_26 and arg_196_1.time_ < var_199_16 + var_199_26 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play418071050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 418071050
		arg_200_1.duration_ = 8.87

		local var_200_0 = {
			ja = 7.1,
			CriLanguages = 8.866,
			zh = 8.866
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play418071051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1073"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps1073 == nil then
				arg_200_1.var_.actorSpriteComps1073 = var_203_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_2 = 0.2

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.actorSpriteComps1073 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								local var_203_4 = Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor1.r, var_203_3)
								local var_203_5 = Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor1.g, var_203_3)
								local var_203_6 = Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor1.b, var_203_3)

								iter_203_1.color = Color.New(var_203_4, var_203_5, var_203_6)
							else
								local var_203_7 = Mathf.Lerp(iter_203_1.color.r, 1, var_203_3)

								iter_203_1.color = Color.New(var_203_7, var_203_7, var_203_7)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps1073 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_203_3 then
						if arg_200_1.isInRecall_ then
							iter_203_3.color = arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_203_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps1073 = nil
			end

			local var_203_8 = arg_200_1.actors_["10135"]
			local var_203_9 = 0

			if var_203_9 < arg_200_1.time_ and arg_200_1.time_ <= var_203_9 + arg_203_0 and not isNil(var_203_8) and arg_200_1.var_.actorSpriteComps10135 == nil then
				arg_200_1.var_.actorSpriteComps10135 = var_203_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_10 = 0.2

			if var_203_9 <= arg_200_1.time_ and arg_200_1.time_ < var_203_9 + var_203_10 and not isNil(var_203_8) then
				local var_203_11 = (arg_200_1.time_ - var_203_9) / var_203_10

				if arg_200_1.var_.actorSpriteComps10135 then
					for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_203_5 then
							if arg_200_1.isInRecall_ then
								local var_203_12 = Mathf.Lerp(iter_203_5.color.r, arg_200_1.hightColor2.r, var_203_11)
								local var_203_13 = Mathf.Lerp(iter_203_5.color.g, arg_200_1.hightColor2.g, var_203_11)
								local var_203_14 = Mathf.Lerp(iter_203_5.color.b, arg_200_1.hightColor2.b, var_203_11)

								iter_203_5.color = Color.New(var_203_12, var_203_13, var_203_14)
							else
								local var_203_15 = Mathf.Lerp(iter_203_5.color.r, 0.5, var_203_11)

								iter_203_5.color = Color.New(var_203_15, var_203_15, var_203_15)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_9 + var_203_10 and arg_200_1.time_ < var_203_9 + var_203_10 + arg_203_0 and not isNil(var_203_8) and arg_200_1.var_.actorSpriteComps10135 then
				for iter_203_6, iter_203_7 in pairs(arg_200_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_203_7 then
						if arg_200_1.isInRecall_ then
							iter_203_7.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10135 = nil
			end

			local var_203_16 = arg_200_1.actors_["1073"].transform
			local var_203_17 = 0

			if var_203_17 < arg_200_1.time_ and arg_200_1.time_ <= var_203_17 + arg_203_0 then
				arg_200_1.var_.moveOldPos1073 = var_203_16.localPosition
				var_203_16.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1073", 2)

				local var_203_18 = var_203_16.childCount

				for iter_203_8 = 0, var_203_18 - 1 do
					local var_203_19 = var_203_16:GetChild(iter_203_8)

					if var_203_19.name == "split_5" or not string.find(var_203_19.name, "split") then
						var_203_19.gameObject:SetActive(true)
					else
						var_203_19.gameObject:SetActive(false)
					end
				end
			end

			local var_203_20 = 0.001

			if var_203_17 <= arg_200_1.time_ and arg_200_1.time_ < var_203_17 + var_203_20 then
				local var_203_21 = (arg_200_1.time_ - var_203_17) / var_203_20
				local var_203_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_203_16.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1073, var_203_22, var_203_21)
			end

			if arg_200_1.time_ >= var_203_17 + var_203_20 and arg_200_1.time_ < var_203_17 + var_203_20 + arg_203_0 then
				var_203_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_203_23 = 0
			local var_203_24 = 0.95

			if var_203_23 < arg_200_1.time_ and arg_200_1.time_ <= var_203_23 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_25 = arg_200_1:FormatText(StoryNameCfg[380].name)

				arg_200_1.leftNameTxt_.text = var_203_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_26 = arg_200_1:GetWordFromCfg(418071050)
				local var_203_27 = arg_200_1:FormatText(var_203_26.content)

				arg_200_1.text_.text = var_203_27

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_28 = 38
				local var_203_29 = utf8.len(var_203_27)
				local var_203_30 = var_203_28 <= 0 and var_203_24 or var_203_24 * (var_203_29 / var_203_28)

				if var_203_30 > 0 and var_203_24 < var_203_30 then
					arg_200_1.talkMaxDuration = var_203_30

					if var_203_30 + var_203_23 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_30 + var_203_23
					end
				end

				arg_200_1.text_.text = var_203_27
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071050", "story_v_side_old_418071.awb") ~= 0 then
					local var_203_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071050", "story_v_side_old_418071.awb") / 1000

					if var_203_31 + var_203_23 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_31 + var_203_23
					end

					if var_203_26.prefab_name ~= "" and arg_200_1.actors_[var_203_26.prefab_name] ~= nil then
						local var_203_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_26.prefab_name].transform, "story_v_side_old_418071", "418071050", "story_v_side_old_418071.awb")

						arg_200_1:RecordAudio("418071050", var_203_32)
						arg_200_1:RecordAudio("418071050", var_203_32)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071050", "story_v_side_old_418071.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071050", "story_v_side_old_418071.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_33 = math.max(var_203_24, arg_200_1.talkMaxDuration)

			if var_203_23 <= arg_200_1.time_ and arg_200_1.time_ < var_203_23 + var_203_33 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_23) / var_203_33

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_23 + var_203_33 and arg_200_1.time_ < var_203_23 + var_203_33 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
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
	Play418071051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 418071051
		arg_204_1.duration_ = 14.4

		local var_204_0 = {
			ja = 14.4,
			CriLanguages = 11,
			zh = 11
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play418071052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["10135"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps10135 == nil then
				arg_204_1.var_.actorSpriteComps10135 = var_207_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_2 = 0.2

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.actorSpriteComps10135 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								local var_207_4 = Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor1.r, var_207_3)
								local var_207_5 = Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor1.g, var_207_3)
								local var_207_6 = Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor1.b, var_207_3)

								iter_207_1.color = Color.New(var_207_4, var_207_5, var_207_6)
							else
								local var_207_7 = Mathf.Lerp(iter_207_1.color.r, 1, var_207_3)

								iter_207_1.color = Color.New(var_207_7, var_207_7, var_207_7)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps10135 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_207_3 then
						if arg_204_1.isInRecall_ then
							iter_207_3.color = arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_207_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps10135 = nil
			end

			local var_207_8 = arg_204_1.actors_["1073"]
			local var_207_9 = 0

			if var_207_9 < arg_204_1.time_ and arg_204_1.time_ <= var_207_9 + arg_207_0 and not isNil(var_207_8) and arg_204_1.var_.actorSpriteComps1073 == nil then
				arg_204_1.var_.actorSpriteComps1073 = var_207_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_10 = 0.2

			if var_207_9 <= arg_204_1.time_ and arg_204_1.time_ < var_207_9 + var_207_10 and not isNil(var_207_8) then
				local var_207_11 = (arg_204_1.time_ - var_207_9) / var_207_10

				if arg_204_1.var_.actorSpriteComps1073 then
					for iter_207_4, iter_207_5 in pairs(arg_204_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_207_5 then
							if arg_204_1.isInRecall_ then
								local var_207_12 = Mathf.Lerp(iter_207_5.color.r, arg_204_1.hightColor2.r, var_207_11)
								local var_207_13 = Mathf.Lerp(iter_207_5.color.g, arg_204_1.hightColor2.g, var_207_11)
								local var_207_14 = Mathf.Lerp(iter_207_5.color.b, arg_204_1.hightColor2.b, var_207_11)

								iter_207_5.color = Color.New(var_207_12, var_207_13, var_207_14)
							else
								local var_207_15 = Mathf.Lerp(iter_207_5.color.r, 0.5, var_207_11)

								iter_207_5.color = Color.New(var_207_15, var_207_15, var_207_15)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= var_207_9 + var_207_10 and arg_204_1.time_ < var_207_9 + var_207_10 + arg_207_0 and not isNil(var_207_8) and arg_204_1.var_.actorSpriteComps1073 then
				for iter_207_6, iter_207_7 in pairs(arg_204_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_207_7 then
						if arg_204_1.isInRecall_ then
							iter_207_7.color = arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_207_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps1073 = nil
			end

			local var_207_16 = 0
			local var_207_17 = 1.35

			if var_207_16 < arg_204_1.time_ and arg_204_1.time_ <= var_207_16 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_18 = arg_204_1:FormatText(StoryNameCfg[1187].name)

				arg_204_1.leftNameTxt_.text = var_207_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_19 = arg_204_1:GetWordFromCfg(418071051)
				local var_207_20 = arg_204_1:FormatText(var_207_19.content)

				arg_204_1.text_.text = var_207_20

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_21 = 54
				local var_207_22 = utf8.len(var_207_20)
				local var_207_23 = var_207_21 <= 0 and var_207_17 or var_207_17 * (var_207_22 / var_207_21)

				if var_207_23 > 0 and var_207_17 < var_207_23 then
					arg_204_1.talkMaxDuration = var_207_23

					if var_207_23 + var_207_16 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_23 + var_207_16
					end
				end

				arg_204_1.text_.text = var_207_20
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071051", "story_v_side_old_418071.awb") ~= 0 then
					local var_207_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071051", "story_v_side_old_418071.awb") / 1000

					if var_207_24 + var_207_16 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_24 + var_207_16
					end

					if var_207_19.prefab_name ~= "" and arg_204_1.actors_[var_207_19.prefab_name] ~= nil then
						local var_207_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_19.prefab_name].transform, "story_v_side_old_418071", "418071051", "story_v_side_old_418071.awb")

						arg_204_1:RecordAudio("418071051", var_207_25)
						arg_204_1:RecordAudio("418071051", var_207_25)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071051", "story_v_side_old_418071.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071051", "story_v_side_old_418071.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_26 = math.max(var_207_17, arg_204_1.talkMaxDuration)

			if var_207_16 <= arg_204_1.time_ and arg_204_1.time_ < var_207_16 + var_207_26 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_16) / var_207_26

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_16 + var_207_26 and arg_204_1.time_ < var_207_16 + var_207_26 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play418071052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 418071052
		arg_208_1.duration_ = 2.07

		local var_208_0 = {
			ja = 1.866,
			CriLanguages = 2.066,
			zh = 2.066
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
				arg_208_0:Play418071053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1073"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.actorSpriteComps1073 == nil then
				arg_208_1.var_.actorSpriteComps1073 = var_211_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_2 = 0.2

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.actorSpriteComps1073 then
					for iter_211_0, iter_211_1 in pairs(arg_208_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_211_1 then
							if arg_208_1.isInRecall_ then
								local var_211_4 = Mathf.Lerp(iter_211_1.color.r, arg_208_1.hightColor1.r, var_211_3)
								local var_211_5 = Mathf.Lerp(iter_211_1.color.g, arg_208_1.hightColor1.g, var_211_3)
								local var_211_6 = Mathf.Lerp(iter_211_1.color.b, arg_208_1.hightColor1.b, var_211_3)

								iter_211_1.color = Color.New(var_211_4, var_211_5, var_211_6)
							else
								local var_211_7 = Mathf.Lerp(iter_211_1.color.r, 1, var_211_3)

								iter_211_1.color = Color.New(var_211_7, var_211_7, var_211_7)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.actorSpriteComps1073 then
				for iter_211_2, iter_211_3 in pairs(arg_208_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_211_3 then
						if arg_208_1.isInRecall_ then
							iter_211_3.color = arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_211_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_208_1.var_.actorSpriteComps1073 = nil
			end

			local var_211_8 = arg_208_1.actors_["10135"]
			local var_211_9 = 0

			if var_211_9 < arg_208_1.time_ and arg_208_1.time_ <= var_211_9 + arg_211_0 and not isNil(var_211_8) and arg_208_1.var_.actorSpriteComps10135 == nil then
				arg_208_1.var_.actorSpriteComps10135 = var_211_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_10 = 0.2

			if var_211_9 <= arg_208_1.time_ and arg_208_1.time_ < var_211_9 + var_211_10 and not isNil(var_211_8) then
				local var_211_11 = (arg_208_1.time_ - var_211_9) / var_211_10

				if arg_208_1.var_.actorSpriteComps10135 then
					for iter_211_4, iter_211_5 in pairs(arg_208_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_211_5 then
							if arg_208_1.isInRecall_ then
								local var_211_12 = Mathf.Lerp(iter_211_5.color.r, arg_208_1.hightColor2.r, var_211_11)
								local var_211_13 = Mathf.Lerp(iter_211_5.color.g, arg_208_1.hightColor2.g, var_211_11)
								local var_211_14 = Mathf.Lerp(iter_211_5.color.b, arg_208_1.hightColor2.b, var_211_11)

								iter_211_5.color = Color.New(var_211_12, var_211_13, var_211_14)
							else
								local var_211_15 = Mathf.Lerp(iter_211_5.color.r, 0.5, var_211_11)

								iter_211_5.color = Color.New(var_211_15, var_211_15, var_211_15)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= var_211_9 + var_211_10 and arg_208_1.time_ < var_211_9 + var_211_10 + arg_211_0 and not isNil(var_211_8) and arg_208_1.var_.actorSpriteComps10135 then
				for iter_211_6, iter_211_7 in pairs(arg_208_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_211_7 then
						if arg_208_1.isInRecall_ then
							iter_211_7.color = arg_208_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_211_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_208_1.var_.actorSpriteComps10135 = nil
			end

			local var_211_16 = 0
			local var_211_17 = 0.075

			if var_211_16 < arg_208_1.time_ and arg_208_1.time_ <= var_211_16 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_18 = arg_208_1:FormatText(StoryNameCfg[380].name)

				arg_208_1.leftNameTxt_.text = var_211_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_19 = arg_208_1:GetWordFromCfg(418071052)
				local var_211_20 = arg_208_1:FormatText(var_211_19.content)

				arg_208_1.text_.text = var_211_20

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_21 = 3
				local var_211_22 = utf8.len(var_211_20)
				local var_211_23 = var_211_21 <= 0 and var_211_17 or var_211_17 * (var_211_22 / var_211_21)

				if var_211_23 > 0 and var_211_17 < var_211_23 then
					arg_208_1.talkMaxDuration = var_211_23

					if var_211_23 + var_211_16 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_23 + var_211_16
					end
				end

				arg_208_1.text_.text = var_211_20
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071052", "story_v_side_old_418071.awb") ~= 0 then
					local var_211_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071052", "story_v_side_old_418071.awb") / 1000

					if var_211_24 + var_211_16 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_24 + var_211_16
					end

					if var_211_19.prefab_name ~= "" and arg_208_1.actors_[var_211_19.prefab_name] ~= nil then
						local var_211_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_19.prefab_name].transform, "story_v_side_old_418071", "418071052", "story_v_side_old_418071.awb")

						arg_208_1:RecordAudio("418071052", var_211_25)
						arg_208_1:RecordAudio("418071052", var_211_25)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071052", "story_v_side_old_418071.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071052", "story_v_side_old_418071.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_26 = math.max(var_211_17, arg_208_1.talkMaxDuration)

			if var_211_16 <= arg_208_1.time_ and arg_208_1.time_ < var_211_16 + var_211_26 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_16) / var_211_26

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_16 + var_211_26 and arg_208_1.time_ < var_211_16 + var_211_26 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play418071053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 418071053
		arg_212_1.duration_ = 7.9

		local var_212_0 = {
			ja = 6.933,
			CriLanguages = 7.9,
			zh = 7.9
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play418071054(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["10135"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps10135 == nil then
				arg_212_1.var_.actorSpriteComps10135 = var_215_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_2 = 0.2

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.actorSpriteComps10135 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								local var_215_4 = Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor1.r, var_215_3)
								local var_215_5 = Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor1.g, var_215_3)
								local var_215_6 = Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor1.b, var_215_3)

								iter_215_1.color = Color.New(var_215_4, var_215_5, var_215_6)
							else
								local var_215_7 = Mathf.Lerp(iter_215_1.color.r, 1, var_215_3)

								iter_215_1.color = Color.New(var_215_7, var_215_7, var_215_7)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps10135 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_215_3 then
						if arg_212_1.isInRecall_ then
							iter_215_3.color = arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_215_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_212_1.var_.actorSpriteComps10135 = nil
			end

			local var_215_8 = arg_212_1.actors_["1073"]
			local var_215_9 = 0

			if var_215_9 < arg_212_1.time_ and arg_212_1.time_ <= var_215_9 + arg_215_0 and not isNil(var_215_8) and arg_212_1.var_.actorSpriteComps1073 == nil then
				arg_212_1.var_.actorSpriteComps1073 = var_215_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_10 = 0.2

			if var_215_9 <= arg_212_1.time_ and arg_212_1.time_ < var_215_9 + var_215_10 and not isNil(var_215_8) then
				local var_215_11 = (arg_212_1.time_ - var_215_9) / var_215_10

				if arg_212_1.var_.actorSpriteComps1073 then
					for iter_215_4, iter_215_5 in pairs(arg_212_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_215_5 then
							if arg_212_1.isInRecall_ then
								local var_215_12 = Mathf.Lerp(iter_215_5.color.r, arg_212_1.hightColor2.r, var_215_11)
								local var_215_13 = Mathf.Lerp(iter_215_5.color.g, arg_212_1.hightColor2.g, var_215_11)
								local var_215_14 = Mathf.Lerp(iter_215_5.color.b, arg_212_1.hightColor2.b, var_215_11)

								iter_215_5.color = Color.New(var_215_12, var_215_13, var_215_14)
							else
								local var_215_15 = Mathf.Lerp(iter_215_5.color.r, 0.5, var_215_11)

								iter_215_5.color = Color.New(var_215_15, var_215_15, var_215_15)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= var_215_9 + var_215_10 and arg_212_1.time_ < var_215_9 + var_215_10 + arg_215_0 and not isNil(var_215_8) and arg_212_1.var_.actorSpriteComps1073 then
				for iter_215_6, iter_215_7 in pairs(arg_212_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_215_7 then
						if arg_212_1.isInRecall_ then
							iter_215_7.color = arg_212_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_215_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_212_1.var_.actorSpriteComps1073 = nil
			end

			local var_215_16 = 0
			local var_215_17 = 0.925

			if var_215_16 < arg_212_1.time_ and arg_212_1.time_ <= var_215_16 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_18 = arg_212_1:FormatText(StoryNameCfg[1187].name)

				arg_212_1.leftNameTxt_.text = var_215_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_19 = arg_212_1:GetWordFromCfg(418071053)
				local var_215_20 = arg_212_1:FormatText(var_215_19.content)

				arg_212_1.text_.text = var_215_20

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_21 = 37
				local var_215_22 = utf8.len(var_215_20)
				local var_215_23 = var_215_21 <= 0 and var_215_17 or var_215_17 * (var_215_22 / var_215_21)

				if var_215_23 > 0 and var_215_17 < var_215_23 then
					arg_212_1.talkMaxDuration = var_215_23

					if var_215_23 + var_215_16 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_23 + var_215_16
					end
				end

				arg_212_1.text_.text = var_215_20
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071053", "story_v_side_old_418071.awb") ~= 0 then
					local var_215_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071053", "story_v_side_old_418071.awb") / 1000

					if var_215_24 + var_215_16 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_24 + var_215_16
					end

					if var_215_19.prefab_name ~= "" and arg_212_1.actors_[var_215_19.prefab_name] ~= nil then
						local var_215_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_19.prefab_name].transform, "story_v_side_old_418071", "418071053", "story_v_side_old_418071.awb")

						arg_212_1:RecordAudio("418071053", var_215_25)
						arg_212_1:RecordAudio("418071053", var_215_25)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071053", "story_v_side_old_418071.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071053", "story_v_side_old_418071.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_26 = math.max(var_215_17, arg_212_1.talkMaxDuration)

			if var_215_16 <= arg_212_1.time_ and arg_212_1.time_ < var_215_16 + var_215_26 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_16) / var_215_26

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_16 + var_215_26 and arg_212_1.time_ < var_215_16 + var_215_26 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play418071054 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 418071054
		arg_216_1.duration_ = 2.8

		local var_216_0 = {
			ja = 2.8,
			CriLanguages = 2.333,
			zh = 2.333
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play418071055(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1073"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps1073 == nil then
				arg_216_1.var_.actorSpriteComps1073 = var_219_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_2 = 0.2

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.actorSpriteComps1073 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								local var_219_4 = Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor1.r, var_219_3)
								local var_219_5 = Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor1.g, var_219_3)
								local var_219_6 = Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor1.b, var_219_3)

								iter_219_1.color = Color.New(var_219_4, var_219_5, var_219_6)
							else
								local var_219_7 = Mathf.Lerp(iter_219_1.color.r, 1, var_219_3)

								iter_219_1.color = Color.New(var_219_7, var_219_7, var_219_7)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps1073 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_219_3 then
						if arg_216_1.isInRecall_ then
							iter_219_3.color = arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_219_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps1073 = nil
			end

			local var_219_8 = arg_216_1.actors_["10135"]
			local var_219_9 = 0

			if var_219_9 < arg_216_1.time_ and arg_216_1.time_ <= var_219_9 + arg_219_0 and not isNil(var_219_8) and arg_216_1.var_.actorSpriteComps10135 == nil then
				arg_216_1.var_.actorSpriteComps10135 = var_219_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_10 = 0.2

			if var_219_9 <= arg_216_1.time_ and arg_216_1.time_ < var_219_9 + var_219_10 and not isNil(var_219_8) then
				local var_219_11 = (arg_216_1.time_ - var_219_9) / var_219_10

				if arg_216_1.var_.actorSpriteComps10135 then
					for iter_219_4, iter_219_5 in pairs(arg_216_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_219_5 then
							if arg_216_1.isInRecall_ then
								local var_219_12 = Mathf.Lerp(iter_219_5.color.r, arg_216_1.hightColor2.r, var_219_11)
								local var_219_13 = Mathf.Lerp(iter_219_5.color.g, arg_216_1.hightColor2.g, var_219_11)
								local var_219_14 = Mathf.Lerp(iter_219_5.color.b, arg_216_1.hightColor2.b, var_219_11)

								iter_219_5.color = Color.New(var_219_12, var_219_13, var_219_14)
							else
								local var_219_15 = Mathf.Lerp(iter_219_5.color.r, 0.5, var_219_11)

								iter_219_5.color = Color.New(var_219_15, var_219_15, var_219_15)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= var_219_9 + var_219_10 and arg_216_1.time_ < var_219_9 + var_219_10 + arg_219_0 and not isNil(var_219_8) and arg_216_1.var_.actorSpriteComps10135 then
				for iter_219_6, iter_219_7 in pairs(arg_216_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_219_7 then
						if arg_216_1.isInRecall_ then
							iter_219_7.color = arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_219_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps10135 = nil
			end

			local var_219_16 = arg_216_1.actors_["1073"].transform
			local var_219_17 = 0

			if var_219_17 < arg_216_1.time_ and arg_216_1.time_ <= var_219_17 + arg_219_0 then
				arg_216_1.var_.moveOldPos1073 = var_219_16.localPosition
				var_219_16.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("1073", 2)

				local var_219_18 = var_219_16.childCount

				for iter_219_8 = 0, var_219_18 - 1 do
					local var_219_19 = var_219_16:GetChild(iter_219_8)

					if var_219_19.name == "" or not string.find(var_219_19.name, "split") then
						var_219_19.gameObject:SetActive(true)
					else
						var_219_19.gameObject:SetActive(false)
					end
				end
			end

			local var_219_20 = 0.001

			if var_219_17 <= arg_216_1.time_ and arg_216_1.time_ < var_219_17 + var_219_20 then
				local var_219_21 = (arg_216_1.time_ - var_219_17) / var_219_20
				local var_219_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_219_16.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1073, var_219_22, var_219_21)
			end

			if arg_216_1.time_ >= var_219_17 + var_219_20 and arg_216_1.time_ < var_219_17 + var_219_20 + arg_219_0 then
				var_219_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_219_23 = 0
			local var_219_24 = 0.15

			if var_219_23 < arg_216_1.time_ and arg_216_1.time_ <= var_219_23 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_25 = arg_216_1:FormatText(StoryNameCfg[380].name)

				arg_216_1.leftNameTxt_.text = var_219_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_26 = arg_216_1:GetWordFromCfg(418071054)
				local var_219_27 = arg_216_1:FormatText(var_219_26.content)

				arg_216_1.text_.text = var_219_27

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_28 = 6
				local var_219_29 = utf8.len(var_219_27)
				local var_219_30 = var_219_28 <= 0 and var_219_24 or var_219_24 * (var_219_29 / var_219_28)

				if var_219_30 > 0 and var_219_24 < var_219_30 then
					arg_216_1.talkMaxDuration = var_219_30

					if var_219_30 + var_219_23 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_30 + var_219_23
					end
				end

				arg_216_1.text_.text = var_219_27
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071054", "story_v_side_old_418071.awb") ~= 0 then
					local var_219_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071054", "story_v_side_old_418071.awb") / 1000

					if var_219_31 + var_219_23 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_31 + var_219_23
					end

					if var_219_26.prefab_name ~= "" and arg_216_1.actors_[var_219_26.prefab_name] ~= nil then
						local var_219_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_26.prefab_name].transform, "story_v_side_old_418071", "418071054", "story_v_side_old_418071.awb")

						arg_216_1:RecordAudio("418071054", var_219_32)
						arg_216_1:RecordAudio("418071054", var_219_32)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071054", "story_v_side_old_418071.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071054", "story_v_side_old_418071.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_33 = math.max(var_219_24, arg_216_1.talkMaxDuration)

			if var_219_23 <= arg_216_1.time_ and arg_216_1.time_ < var_219_23 + var_219_33 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_23) / var_219_33

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_23 + var_219_33 and arg_216_1.time_ < var_219_23 + var_219_33 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play418071055 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 418071055
		arg_220_1.duration_ = 7.8

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play418071056(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1073"]
			local var_223_1 = 1.36666666666667

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps1073 == nil then
				arg_220_1.var_.actorSpriteComps1073 = var_223_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_2 = 0.2

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.actorSpriteComps1073 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								local var_223_4 = Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor2.r, var_223_3)
								local var_223_5 = Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor2.g, var_223_3)
								local var_223_6 = Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor2.b, var_223_3)

								iter_223_1.color = Color.New(var_223_4, var_223_5, var_223_6)
							else
								local var_223_7 = Mathf.Lerp(iter_223_1.color.r, 0.5, var_223_3)

								iter_223_1.color = Color.New(var_223_7, var_223_7, var_223_7)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps1073 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_223_3 then
						if arg_220_1.isInRecall_ then
							iter_223_3.color = arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_223_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps1073 = nil
			end

			local var_223_8 = arg_220_1.actors_["1073"].transform
			local var_223_9 = 1.36666666666667

			if var_223_9 < arg_220_1.time_ and arg_220_1.time_ <= var_223_9 + arg_223_0 then
				arg_220_1.var_.moveOldPos1073 = var_223_8.localPosition
				var_223_8.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("1073", 7)

				local var_223_10 = var_223_8.childCount

				for iter_223_4 = 0, var_223_10 - 1 do
					local var_223_11 = var_223_8:GetChild(iter_223_4)

					if var_223_11.name == "" or not string.find(var_223_11.name, "split") then
						var_223_11.gameObject:SetActive(true)
					else
						var_223_11.gameObject:SetActive(false)
					end
				end
			end

			local var_223_12 = 0.001

			if var_223_9 <= arg_220_1.time_ and arg_220_1.time_ < var_223_9 + var_223_12 then
				local var_223_13 = (arg_220_1.time_ - var_223_9) / var_223_12
				local var_223_14 = Vector3.New(0, -2000, 0)

				var_223_8.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1073, var_223_14, var_223_13)
			end

			if arg_220_1.time_ >= var_223_9 + var_223_12 and arg_220_1.time_ < var_223_9 + var_223_12 + arg_223_0 then
				var_223_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_223_15 = arg_220_1.actors_["10135"].transform
			local var_223_16 = 1.36666666666667

			if var_223_16 < arg_220_1.time_ and arg_220_1.time_ <= var_223_16 + arg_223_0 then
				arg_220_1.var_.moveOldPos10135 = var_223_15.localPosition
				var_223_15.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("10135", 7)

				local var_223_17 = var_223_15.childCount

				for iter_223_5 = 0, var_223_17 - 1 do
					local var_223_18 = var_223_15:GetChild(iter_223_5)

					if var_223_18.name == "" or not string.find(var_223_18.name, "split") then
						var_223_18.gameObject:SetActive(true)
					else
						var_223_18.gameObject:SetActive(false)
					end
				end
			end

			local var_223_19 = 0.001

			if var_223_16 <= arg_220_1.time_ and arg_220_1.time_ < var_223_16 + var_223_19 then
				local var_223_20 = (arg_220_1.time_ - var_223_16) / var_223_19
				local var_223_21 = Vector3.New(0, -2000, 0)

				var_223_15.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10135, var_223_21, var_223_20)
			end

			if arg_220_1.time_ >= var_223_16 + var_223_19 and arg_220_1.time_ < var_223_16 + var_223_19 + arg_223_0 then
				var_223_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_223_22 = 1.40066666666667

			if var_223_22 < arg_220_1.time_ and arg_220_1.time_ <= var_223_22 + arg_223_0 then
				local var_223_23 = manager.ui.mainCamera.transform.localPosition
				local var_223_24 = Vector3.New(0, 0, 10) + Vector3.New(var_223_23.x, var_223_23.y, 0)
				local var_223_25 = arg_220_1.bgs_.ST40

				var_223_25.transform.localPosition = var_223_24
				var_223_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_223_26 = var_223_25:GetComponent("SpriteRenderer")

				if var_223_26 and var_223_26.sprite then
					local var_223_27 = (var_223_25.transform.localPosition - var_223_23).z
					local var_223_28 = manager.ui.mainCameraCom_
					local var_223_29 = 2 * var_223_27 * Mathf.Tan(var_223_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_223_30 = var_223_29 * var_223_28.aspect
					local var_223_31 = var_223_26.sprite.bounds.size.x
					local var_223_32 = var_223_26.sprite.bounds.size.y
					local var_223_33 = var_223_30 / var_223_31
					local var_223_34 = var_223_29 / var_223_32
					local var_223_35 = var_223_34 < var_223_33 and var_223_33 or var_223_34

					var_223_25.transform.localScale = Vector3.New(var_223_35, var_223_35, 0)
				end

				for iter_223_6, iter_223_7 in pairs(arg_220_1.bgs_) do
					if iter_223_6 ~= "ST40" then
						iter_223_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_223_36 = 0

			if var_223_36 < arg_220_1.time_ and arg_220_1.time_ <= var_223_36 + arg_223_0 then
				arg_220_1.mask_.enabled = true
				arg_220_1.mask_.raycastTarget = true

				arg_220_1:SetGaussion(false)
			end

			local var_223_37 = 1.4

			if var_223_36 <= arg_220_1.time_ and arg_220_1.time_ < var_223_36 + var_223_37 then
				local var_223_38 = (arg_220_1.time_ - var_223_36) / var_223_37
				local var_223_39 = Color.New(0, 0, 0)

				var_223_39.a = Mathf.Lerp(0, 1, var_223_38)
				arg_220_1.mask_.color = var_223_39
			end

			if arg_220_1.time_ >= var_223_36 + var_223_37 and arg_220_1.time_ < var_223_36 + var_223_37 + arg_223_0 then
				local var_223_40 = Color.New(0, 0, 0)

				var_223_40.a = 1
				arg_220_1.mask_.color = var_223_40
			end

			local var_223_41 = 1.4

			if var_223_41 < arg_220_1.time_ and arg_220_1.time_ <= var_223_41 + arg_223_0 then
				arg_220_1.mask_.enabled = true
				arg_220_1.mask_.raycastTarget = true

				arg_220_1:SetGaussion(false)
			end

			local var_223_42 = 1.4

			if var_223_41 <= arg_220_1.time_ and arg_220_1.time_ < var_223_41 + var_223_42 then
				local var_223_43 = (arg_220_1.time_ - var_223_41) / var_223_42
				local var_223_44 = Color.New(0, 0, 0)

				var_223_44.a = Mathf.Lerp(1, 0, var_223_43)
				arg_220_1.mask_.color = var_223_44
			end

			if arg_220_1.time_ >= var_223_41 + var_223_42 and arg_220_1.time_ < var_223_41 + var_223_42 + arg_223_0 then
				local var_223_45 = Color.New(0, 0, 0)
				local var_223_46 = 0

				arg_220_1.mask_.enabled = false
				var_223_45.a = var_223_46
				arg_220_1.mask_.color = var_223_45
			end

			if arg_220_1.frameCnt_ <= 1 then
				arg_220_1.dialog_:SetActive(false)
			end

			local var_223_47 = 2.8
			local var_223_48 = 0.15

			if var_223_47 < arg_220_1.time_ and arg_220_1.time_ <= var_223_47 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0

				arg_220_1.dialog_:SetActive(true)

				arg_220_1.dialogCg_.alpha = 0

				local var_223_49 = LeanTween.value(arg_220_1.dialog_, 0, 1, 0.3)

				var_223_49:setOnUpdate(LuaHelper.FloatAction(function(arg_224_0)
					arg_220_1.dialogCg_.alpha = arg_224_0
				end))
				var_223_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_220_1.dialog_)
					var_223_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_220_1.duration_ = arg_220_1.duration_ + 0.3

				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_50 = arg_220_1:GetWordFromCfg(418071055)
				local var_223_51 = arg_220_1:FormatText(var_223_50.content)

				arg_220_1.text_.text = var_223_51

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_52 = 6
				local var_223_53 = utf8.len(var_223_51)
				local var_223_54 = var_223_52 <= 0 and var_223_48 or var_223_48 * (var_223_53 / var_223_52)

				if var_223_54 > 0 and var_223_48 < var_223_54 then
					arg_220_1.talkMaxDuration = var_223_54
					var_223_47 = var_223_47 + 0.3

					if var_223_54 + var_223_47 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_54 + var_223_47
					end
				end

				arg_220_1.text_.text = var_223_51
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_55 = var_223_47 + 0.3
			local var_223_56 = math.max(var_223_48, arg_220_1.talkMaxDuration)

			if var_223_55 <= arg_220_1.time_ and arg_220_1.time_ < var_223_55 + var_223_56 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_55) / var_223_56

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_55 + var_223_56 and arg_220_1.time_ < var_223_55 + var_223_56 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play418071056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 418071056
		arg_226_1.duration_ = 2.8

		local var_226_0 = {
			ja = 2.8,
			CriLanguages = 1.866,
			zh = 1.866
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play418071057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = "107301"

			if arg_226_1.actors_[var_229_0] == nil then
				local var_229_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "107301")

				if not isNil(var_229_1) then
					local var_229_2 = Object.Instantiate(var_229_1, arg_226_1.canvasGo_.transform)

					var_229_2.transform:SetSiblingIndex(1)

					var_229_2.name = var_229_0
					var_229_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_226_1.actors_[var_229_0] = var_229_2

					local var_229_3 = var_229_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_226_1.isInRecall_ then
						for iter_229_0, iter_229_1 in ipairs(var_229_3) do
							iter_229_1.color = arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_229_4 = arg_226_1.actors_["107301"]
			local var_229_5 = 0

			if var_229_5 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 and not isNil(var_229_4) and arg_226_1.var_.actorSpriteComps107301 == nil then
				arg_226_1.var_.actorSpriteComps107301 = var_229_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_6 = 0.2

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_6 and not isNil(var_229_4) then
				local var_229_7 = (arg_226_1.time_ - var_229_5) / var_229_6

				if arg_226_1.var_.actorSpriteComps107301 then
					for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_229_3 then
							if arg_226_1.isInRecall_ then
								local var_229_8 = Mathf.Lerp(iter_229_3.color.r, arg_226_1.hightColor1.r, var_229_7)
								local var_229_9 = Mathf.Lerp(iter_229_3.color.g, arg_226_1.hightColor1.g, var_229_7)
								local var_229_10 = Mathf.Lerp(iter_229_3.color.b, arg_226_1.hightColor1.b, var_229_7)

								iter_229_3.color = Color.New(var_229_8, var_229_9, var_229_10)
							else
								local var_229_11 = Mathf.Lerp(iter_229_3.color.r, 1, var_229_7)

								iter_229_3.color = Color.New(var_229_11, var_229_11, var_229_11)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_5 + var_229_6 and arg_226_1.time_ < var_229_5 + var_229_6 + arg_229_0 and not isNil(var_229_4) and arg_226_1.var_.actorSpriteComps107301 then
				for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_229_5 then
						if arg_226_1.isInRecall_ then
							iter_229_5.color = arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_229_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps107301 = nil
			end

			local var_229_12 = arg_226_1.actors_["1073"].transform
			local var_229_13 = 0

			if var_229_13 < arg_226_1.time_ and arg_226_1.time_ <= var_229_13 + arg_229_0 then
				arg_226_1.var_.moveOldPos1073 = var_229_12.localPosition
				var_229_12.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("1073", 7)

				local var_229_14 = var_229_12.childCount

				for iter_229_6 = 0, var_229_14 - 1 do
					local var_229_15 = var_229_12:GetChild(iter_229_6)

					if var_229_15.name == "" or not string.find(var_229_15.name, "split") then
						var_229_15.gameObject:SetActive(true)
					else
						var_229_15.gameObject:SetActive(false)
					end
				end
			end

			local var_229_16 = 0.001

			if var_229_13 <= arg_226_1.time_ and arg_226_1.time_ < var_229_13 + var_229_16 then
				local var_229_17 = (arg_226_1.time_ - var_229_13) / var_229_16
				local var_229_18 = Vector3.New(0, -2000, 0)

				var_229_12.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1073, var_229_18, var_229_17)
			end

			if arg_226_1.time_ >= var_229_13 + var_229_16 and arg_226_1.time_ < var_229_13 + var_229_16 + arg_229_0 then
				var_229_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_229_19 = arg_226_1.actors_["10135"].transform
			local var_229_20 = 0

			if var_229_20 < arg_226_1.time_ and arg_226_1.time_ <= var_229_20 + arg_229_0 then
				arg_226_1.var_.moveOldPos10135 = var_229_19.localPosition
				var_229_19.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10135", 7)

				local var_229_21 = var_229_19.childCount

				for iter_229_7 = 0, var_229_21 - 1 do
					local var_229_22 = var_229_19:GetChild(iter_229_7)

					if var_229_22.name == "" or not string.find(var_229_22.name, "split") then
						var_229_22.gameObject:SetActive(true)
					else
						var_229_22.gameObject:SetActive(false)
					end
				end
			end

			local var_229_23 = 0.001

			if var_229_20 <= arg_226_1.time_ and arg_226_1.time_ < var_229_20 + var_229_23 then
				local var_229_24 = (arg_226_1.time_ - var_229_20) / var_229_23
				local var_229_25 = Vector3.New(0, -2000, 0)

				var_229_19.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10135, var_229_25, var_229_24)
			end

			if arg_226_1.time_ >= var_229_20 + var_229_23 and arg_226_1.time_ < var_229_20 + var_229_23 + arg_229_0 then
				var_229_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_229_26 = arg_226_1.actors_["107301"].transform
			local var_229_27 = 0

			if var_229_27 < arg_226_1.time_ and arg_226_1.time_ <= var_229_27 + arg_229_0 then
				arg_226_1.var_.moveOldPos107301 = var_229_26.localPosition
				var_229_26.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("107301", 3)

				local var_229_28 = var_229_26.childCount

				for iter_229_8 = 0, var_229_28 - 1 do
					local var_229_29 = var_229_26:GetChild(iter_229_8)

					if var_229_29.name == "split_4" or not string.find(var_229_29.name, "split") then
						var_229_29.gameObject:SetActive(true)
					else
						var_229_29.gameObject:SetActive(false)
					end
				end
			end

			local var_229_30 = 0.001

			if var_229_27 <= arg_226_1.time_ and arg_226_1.time_ < var_229_27 + var_229_30 then
				local var_229_31 = (arg_226_1.time_ - var_229_27) / var_229_30
				local var_229_32 = Vector3.New(-14.4, -367.6, -201.9)

				var_229_26.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos107301, var_229_32, var_229_31)
			end

			if arg_226_1.time_ >= var_229_27 + var_229_30 and arg_226_1.time_ < var_229_27 + var_229_30 + arg_229_0 then
				var_229_26.localPosition = Vector3.New(-14.4, -367.6, -201.9)
			end

			local var_229_33 = 0
			local var_229_34 = 0.2

			if var_229_33 < arg_226_1.time_ and arg_226_1.time_ <= var_229_33 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_35 = arg_226_1:FormatText(StoryNameCfg[380].name)

				arg_226_1.leftNameTxt_.text = var_229_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_36 = arg_226_1:GetWordFromCfg(418071056)
				local var_229_37 = arg_226_1:FormatText(var_229_36.content)

				arg_226_1.text_.text = var_229_37

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_38 = 8
				local var_229_39 = utf8.len(var_229_37)
				local var_229_40 = var_229_38 <= 0 and var_229_34 or var_229_34 * (var_229_39 / var_229_38)

				if var_229_40 > 0 and var_229_34 < var_229_40 then
					arg_226_1.talkMaxDuration = var_229_40

					if var_229_40 + var_229_33 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_40 + var_229_33
					end
				end

				arg_226_1.text_.text = var_229_37
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071056", "story_v_side_old_418071.awb") ~= 0 then
					local var_229_41 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071056", "story_v_side_old_418071.awb") / 1000

					if var_229_41 + var_229_33 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_41 + var_229_33
					end

					if var_229_36.prefab_name ~= "" and arg_226_1.actors_[var_229_36.prefab_name] ~= nil then
						local var_229_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_36.prefab_name].transform, "story_v_side_old_418071", "418071056", "story_v_side_old_418071.awb")

						arg_226_1:RecordAudio("418071056", var_229_42)
						arg_226_1:RecordAudio("418071056", var_229_42)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071056", "story_v_side_old_418071.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071056", "story_v_side_old_418071.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_43 = math.max(var_229_34, arg_226_1.talkMaxDuration)

			if var_229_33 <= arg_226_1.time_ and arg_226_1.time_ < var_229_33 + var_229_43 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_33) / var_229_43

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_33 + var_229_43 and arg_226_1.time_ < var_229_33 + var_229_43 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "107301",
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
	Play418071057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 418071057
		arg_230_1.duration_ = 4.87

		local var_230_0 = {
			ja = 4.6,
			CriLanguages = 4.866,
			zh = 4.866
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
				arg_230_0:Play418071058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10135"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps10135 == nil then
				arg_230_1.var_.actorSpriteComps10135 = var_233_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_2 = 0.2

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.actorSpriteComps10135 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								local var_233_4 = Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, var_233_3)
								local var_233_5 = Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, var_233_3)
								local var_233_6 = Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, var_233_3)

								iter_233_1.color = Color.New(var_233_4, var_233_5, var_233_6)
							else
								local var_233_7 = Mathf.Lerp(iter_233_1.color.r, 1, var_233_3)

								iter_233_1.color = Color.New(var_233_7, var_233_7, var_233_7)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps10135 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_233_3 then
						if arg_230_1.isInRecall_ then
							iter_233_3.color = arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_233_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps10135 = nil
			end

			local var_233_8 = arg_230_1.actors_["107301"]
			local var_233_9 = 0

			if var_233_9 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 and not isNil(var_233_8) and arg_230_1.var_.actorSpriteComps107301 == nil then
				arg_230_1.var_.actorSpriteComps107301 = var_233_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_10 = 0.2

			if var_233_9 <= arg_230_1.time_ and arg_230_1.time_ < var_233_9 + var_233_10 and not isNil(var_233_8) then
				local var_233_11 = (arg_230_1.time_ - var_233_9) / var_233_10

				if arg_230_1.var_.actorSpriteComps107301 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_233_5 then
							if arg_230_1.isInRecall_ then
								local var_233_12 = Mathf.Lerp(iter_233_5.color.r, arg_230_1.hightColor2.r, var_233_11)
								local var_233_13 = Mathf.Lerp(iter_233_5.color.g, arg_230_1.hightColor2.g, var_233_11)
								local var_233_14 = Mathf.Lerp(iter_233_5.color.b, arg_230_1.hightColor2.b, var_233_11)

								iter_233_5.color = Color.New(var_233_12, var_233_13, var_233_14)
							else
								local var_233_15 = Mathf.Lerp(iter_233_5.color.r, 0.5, var_233_11)

								iter_233_5.color = Color.New(var_233_15, var_233_15, var_233_15)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_9 + var_233_10 and arg_230_1.time_ < var_233_9 + var_233_10 + arg_233_0 and not isNil(var_233_8) and arg_230_1.var_.actorSpriteComps107301 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_233_7 then
						if arg_230_1.isInRecall_ then
							iter_233_7.color = arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_233_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps107301 = nil
			end

			local var_233_16 = arg_230_1.actors_["107301"].transform
			local var_233_17 = 0

			if var_233_17 < arg_230_1.time_ and arg_230_1.time_ <= var_233_17 + arg_233_0 then
				arg_230_1.var_.moveOldPos107301 = var_233_16.localPosition
				var_233_16.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("107301", 4)

				local var_233_18 = var_233_16.childCount

				for iter_233_8 = 0, var_233_18 - 1 do
					local var_233_19 = var_233_16:GetChild(iter_233_8)

					if var_233_19.name == "split_4" or not string.find(var_233_19.name, "split") then
						var_233_19.gameObject:SetActive(true)
					else
						var_233_19.gameObject:SetActive(false)
					end
				end
			end

			local var_233_20 = 0.001

			if var_233_17 <= arg_230_1.time_ and arg_230_1.time_ < var_233_17 + var_233_20 then
				local var_233_21 = (arg_230_1.time_ - var_233_17) / var_233_20
				local var_233_22 = Vector3.New(500, -367.6, -206)

				var_233_16.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos107301, var_233_22, var_233_21)
			end

			if arg_230_1.time_ >= var_233_17 + var_233_20 and arg_230_1.time_ < var_233_17 + var_233_20 + arg_233_0 then
				var_233_16.localPosition = Vector3.New(500, -367.6, -206)
			end

			local var_233_23 = arg_230_1.actors_["10135"].transform
			local var_233_24 = 0

			if var_233_24 < arg_230_1.time_ and arg_230_1.time_ <= var_233_24 + arg_233_0 then
				arg_230_1.var_.moveOldPos10135 = var_233_23.localPosition
				var_233_23.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("10135", 2)

				local var_233_25 = var_233_23.childCount

				for iter_233_9 = 0, var_233_25 - 1 do
					local var_233_26 = var_233_23:GetChild(iter_233_9)

					if var_233_26.name == "split_2" or not string.find(var_233_26.name, "split") then
						var_233_26.gameObject:SetActive(true)
					else
						var_233_26.gameObject:SetActive(false)
					end
				end
			end

			local var_233_27 = 0.001

			if var_233_24 <= arg_230_1.time_ and arg_230_1.time_ < var_233_24 + var_233_27 then
				local var_233_28 = (arg_230_1.time_ - var_233_24) / var_233_27
				local var_233_29 = Vector3.New(-448.9, -363.6, -305.9)

				var_233_23.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10135, var_233_29, var_233_28)
			end

			if arg_230_1.time_ >= var_233_24 + var_233_27 and arg_230_1.time_ < var_233_24 + var_233_27 + arg_233_0 then
				var_233_23.localPosition = Vector3.New(-448.9, -363.6, -305.9)
			end

			local var_233_30 = arg_230_1.actors_["1073"].transform
			local var_233_31 = 0

			if var_233_31 < arg_230_1.time_ and arg_230_1.time_ <= var_233_31 + arg_233_0 then
				arg_230_1.var_.moveOldPos1073 = var_233_30.localPosition
				var_233_30.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("1073", 7)

				local var_233_32 = var_233_30.childCount

				for iter_233_10 = 0, var_233_32 - 1 do
					local var_233_33 = var_233_30:GetChild(iter_233_10)

					if var_233_33.name == "" or not string.find(var_233_33.name, "split") then
						var_233_33.gameObject:SetActive(true)
					else
						var_233_33.gameObject:SetActive(false)
					end
				end
			end

			local var_233_34 = 0.001

			if var_233_31 <= arg_230_1.time_ and arg_230_1.time_ < var_233_31 + var_233_34 then
				local var_233_35 = (arg_230_1.time_ - var_233_31) / var_233_34
				local var_233_36 = Vector3.New(0, -2000, 0)

				var_233_30.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1073, var_233_36, var_233_35)
			end

			if arg_230_1.time_ >= var_233_31 + var_233_34 and arg_230_1.time_ < var_233_31 + var_233_34 + arg_233_0 then
				var_233_30.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_233_37 = 0
			local var_233_38 = 0.5

			if var_233_37 < arg_230_1.time_ and arg_230_1.time_ <= var_233_37 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_39 = arg_230_1:FormatText(StoryNameCfg[1187].name)

				arg_230_1.leftNameTxt_.text = var_233_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_40 = arg_230_1:GetWordFromCfg(418071057)
				local var_233_41 = arg_230_1:FormatText(var_233_40.content)

				arg_230_1.text_.text = var_233_41

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_42 = 20
				local var_233_43 = utf8.len(var_233_41)
				local var_233_44 = var_233_42 <= 0 and var_233_38 or var_233_38 * (var_233_43 / var_233_42)

				if var_233_44 > 0 and var_233_38 < var_233_44 then
					arg_230_1.talkMaxDuration = var_233_44

					if var_233_44 + var_233_37 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_44 + var_233_37
					end
				end

				arg_230_1.text_.text = var_233_41
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071057", "story_v_side_old_418071.awb") ~= 0 then
					local var_233_45 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071057", "story_v_side_old_418071.awb") / 1000

					if var_233_45 + var_233_37 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_45 + var_233_37
					end

					if var_233_40.prefab_name ~= "" and arg_230_1.actors_[var_233_40.prefab_name] ~= nil then
						local var_233_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_40.prefab_name].transform, "story_v_side_old_418071", "418071057", "story_v_side_old_418071.awb")

						arg_230_1:RecordAudio("418071057", var_233_46)
						arg_230_1:RecordAudio("418071057", var_233_46)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071057", "story_v_side_old_418071.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071057", "story_v_side_old_418071.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_47 = math.max(var_233_38, arg_230_1.talkMaxDuration)

			if var_233_37 <= arg_230_1.time_ and arg_230_1.time_ < var_233_37 + var_233_47 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_37) / var_233_47

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_37 + var_233_47 and arg_230_1.time_ < var_233_37 + var_233_47 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play418071058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 418071058
		arg_234_1.duration_ = 9.5

		local var_234_0 = {
			ja = 9.5,
			CriLanguages = 8,
			zh = 8
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play418071059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10135"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos10135 = var_237_0.localPosition
				var_237_0.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10135", 2)

				local var_237_2 = var_237_0.childCount

				for iter_237_0 = 0, var_237_2 - 1 do
					local var_237_3 = var_237_0:GetChild(iter_237_0)

					if var_237_3.name == "split_1" or not string.find(var_237_3.name, "split") then
						var_237_3.gameObject:SetActive(true)
					else
						var_237_3.gameObject:SetActive(false)
					end
				end
			end

			local var_237_4 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_4 then
				local var_237_5 = (arg_234_1.time_ - var_237_1) / var_237_4
				local var_237_6 = Vector3.New(-448.9, -363.6, -305.9)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10135, var_237_6, var_237_5)
			end

			if arg_234_1.time_ >= var_237_1 + var_237_4 and arg_234_1.time_ < var_237_1 + var_237_4 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(-448.9, -363.6, -305.9)
			end

			local var_237_7 = 0
			local var_237_8 = 0.75

			if var_237_7 < arg_234_1.time_ and arg_234_1.time_ <= var_237_7 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_9 = arg_234_1:FormatText(StoryNameCfg[1187].name)

				arg_234_1.leftNameTxt_.text = var_237_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_10 = arg_234_1:GetWordFromCfg(418071058)
				local var_237_11 = arg_234_1:FormatText(var_237_10.content)

				arg_234_1.text_.text = var_237_11

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_12 = 30
				local var_237_13 = utf8.len(var_237_11)
				local var_237_14 = var_237_12 <= 0 and var_237_8 or var_237_8 * (var_237_13 / var_237_12)

				if var_237_14 > 0 and var_237_8 < var_237_14 then
					arg_234_1.talkMaxDuration = var_237_14

					if var_237_14 + var_237_7 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_14 + var_237_7
					end
				end

				arg_234_1.text_.text = var_237_11
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071058", "story_v_side_old_418071.awb") ~= 0 then
					local var_237_15 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071058", "story_v_side_old_418071.awb") / 1000

					if var_237_15 + var_237_7 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_15 + var_237_7
					end

					if var_237_10.prefab_name ~= "" and arg_234_1.actors_[var_237_10.prefab_name] ~= nil then
						local var_237_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_10.prefab_name].transform, "story_v_side_old_418071", "418071058", "story_v_side_old_418071.awb")

						arg_234_1:RecordAudio("418071058", var_237_16)
						arg_234_1:RecordAudio("418071058", var_237_16)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071058", "story_v_side_old_418071.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071058", "story_v_side_old_418071.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_17 = math.max(var_237_8, arg_234_1.talkMaxDuration)

			if var_237_7 <= arg_234_1.time_ and arg_234_1.time_ < var_237_7 + var_237_17 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_7) / var_237_17

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_7 + var_237_17 and arg_234_1.time_ < var_237_7 + var_237_17 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play418071059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 418071059
		arg_238_1.duration_ = 2.27

		local var_238_0 = {
			ja = 2.066,
			CriLanguages = 2.266,
			zh = 2.266
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play418071060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["107301"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.actorSpriteComps107301 == nil then
				arg_238_1.var_.actorSpriteComps107301 = var_241_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_2 = 0.2

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.actorSpriteComps107301 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								local var_241_4 = Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor1.r, var_241_3)
								local var_241_5 = Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor1.g, var_241_3)
								local var_241_6 = Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor1.b, var_241_3)

								iter_241_1.color = Color.New(var_241_4, var_241_5, var_241_6)
							else
								local var_241_7 = Mathf.Lerp(iter_241_1.color.r, 1, var_241_3)

								iter_241_1.color = Color.New(var_241_7, var_241_7, var_241_7)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.actorSpriteComps107301 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_241_3 then
						if arg_238_1.isInRecall_ then
							iter_241_3.color = arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_241_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_238_1.var_.actorSpriteComps107301 = nil
			end

			local var_241_8 = arg_238_1.actors_["10135"]
			local var_241_9 = 0

			if var_241_9 < arg_238_1.time_ and arg_238_1.time_ <= var_241_9 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.actorSpriteComps10135 == nil then
				arg_238_1.var_.actorSpriteComps10135 = var_241_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_10 = 0.2

			if var_241_9 <= arg_238_1.time_ and arg_238_1.time_ < var_241_9 + var_241_10 and not isNil(var_241_8) then
				local var_241_11 = (arg_238_1.time_ - var_241_9) / var_241_10

				if arg_238_1.var_.actorSpriteComps10135 then
					for iter_241_4, iter_241_5 in pairs(arg_238_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_241_5 then
							if arg_238_1.isInRecall_ then
								local var_241_12 = Mathf.Lerp(iter_241_5.color.r, arg_238_1.hightColor2.r, var_241_11)
								local var_241_13 = Mathf.Lerp(iter_241_5.color.g, arg_238_1.hightColor2.g, var_241_11)
								local var_241_14 = Mathf.Lerp(iter_241_5.color.b, arg_238_1.hightColor2.b, var_241_11)

								iter_241_5.color = Color.New(var_241_12, var_241_13, var_241_14)
							else
								local var_241_15 = Mathf.Lerp(iter_241_5.color.r, 0.5, var_241_11)

								iter_241_5.color = Color.New(var_241_15, var_241_15, var_241_15)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= var_241_9 + var_241_10 and arg_238_1.time_ < var_241_9 + var_241_10 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.actorSpriteComps10135 then
				for iter_241_6, iter_241_7 in pairs(arg_238_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_241_7 then
						if arg_238_1.isInRecall_ then
							iter_241_7.color = arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_241_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_238_1.var_.actorSpriteComps10135 = nil
			end

			local var_241_16 = arg_238_1.actors_["107301"].transform
			local var_241_17 = 0

			if var_241_17 < arg_238_1.time_ and arg_238_1.time_ <= var_241_17 + arg_241_0 then
				arg_238_1.var_.moveOldPos107301 = var_241_16.localPosition
				var_241_16.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("107301", 4)

				local var_241_18 = var_241_16.childCount

				for iter_241_8 = 0, var_241_18 - 1 do
					local var_241_19 = var_241_16:GetChild(iter_241_8)

					if var_241_19.name == "split_4" or not string.find(var_241_19.name, "split") then
						var_241_19.gameObject:SetActive(true)
					else
						var_241_19.gameObject:SetActive(false)
					end
				end
			end

			local var_241_20 = 0.001

			if var_241_17 <= arg_238_1.time_ and arg_238_1.time_ < var_241_17 + var_241_20 then
				local var_241_21 = (arg_238_1.time_ - var_241_17) / var_241_20
				local var_241_22 = Vector3.New(500, -367.6, -206)

				var_241_16.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos107301, var_241_22, var_241_21)
			end

			if arg_238_1.time_ >= var_241_17 + var_241_20 and arg_238_1.time_ < var_241_17 + var_241_20 + arg_241_0 then
				var_241_16.localPosition = Vector3.New(500, -367.6, -206)
			end

			local var_241_23 = 0
			local var_241_24 = 0.125

			if var_241_23 < arg_238_1.time_ and arg_238_1.time_ <= var_241_23 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_25 = arg_238_1:FormatText(StoryNameCfg[380].name)

				arg_238_1.leftNameTxt_.text = var_241_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_26 = arg_238_1:GetWordFromCfg(418071059)
				local var_241_27 = arg_238_1:FormatText(var_241_26.content)

				arg_238_1.text_.text = var_241_27

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_28 = 5
				local var_241_29 = utf8.len(var_241_27)
				local var_241_30 = var_241_28 <= 0 and var_241_24 or var_241_24 * (var_241_29 / var_241_28)

				if var_241_30 > 0 and var_241_24 < var_241_30 then
					arg_238_1.talkMaxDuration = var_241_30

					if var_241_30 + var_241_23 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_30 + var_241_23
					end
				end

				arg_238_1.text_.text = var_241_27
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071059", "story_v_side_old_418071.awb") ~= 0 then
					local var_241_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071059", "story_v_side_old_418071.awb") / 1000

					if var_241_31 + var_241_23 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_31 + var_241_23
					end

					if var_241_26.prefab_name ~= "" and arg_238_1.actors_[var_241_26.prefab_name] ~= nil then
						local var_241_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_26.prefab_name].transform, "story_v_side_old_418071", "418071059", "story_v_side_old_418071.awb")

						arg_238_1:RecordAudio("418071059", var_241_32)
						arg_238_1:RecordAudio("418071059", var_241_32)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071059", "story_v_side_old_418071.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071059", "story_v_side_old_418071.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_33 = math.max(var_241_24, arg_238_1.talkMaxDuration)

			if var_241_23 <= arg_238_1.time_ and arg_238_1.time_ < var_241_23 + var_241_33 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_23) / var_241_33

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_23 + var_241_33 and arg_238_1.time_ < var_241_23 + var_241_33 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play418071060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 418071060
		arg_242_1.duration_ = 9

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play418071061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = "ST1003a"

			if arg_242_1.bgs_[var_245_0] == nil then
				local var_245_1 = Object.Instantiate(arg_242_1.paintGo_)

				var_245_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_245_0)
				var_245_1.name = var_245_0
				var_245_1.transform.parent = arg_242_1.stage_.transform
				var_245_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.bgs_[var_245_0] = var_245_1
			end

			local var_245_2 = 2

			if var_245_2 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				local var_245_3 = manager.ui.mainCamera.transform.localPosition
				local var_245_4 = Vector3.New(0, 0, 10) + Vector3.New(var_245_3.x, var_245_3.y, 0)
				local var_245_5 = arg_242_1.bgs_.ST1003a

				var_245_5.transform.localPosition = var_245_4
				var_245_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_6 = var_245_5:GetComponent("SpriteRenderer")

				if var_245_6 and var_245_6.sprite then
					local var_245_7 = (var_245_5.transform.localPosition - var_245_3).z
					local var_245_8 = manager.ui.mainCameraCom_
					local var_245_9 = 2 * var_245_7 * Mathf.Tan(var_245_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_245_10 = var_245_9 * var_245_8.aspect
					local var_245_11 = var_245_6.sprite.bounds.size.x
					local var_245_12 = var_245_6.sprite.bounds.size.y
					local var_245_13 = var_245_10 / var_245_11
					local var_245_14 = var_245_9 / var_245_12
					local var_245_15 = var_245_14 < var_245_13 and var_245_13 or var_245_14

					var_245_5.transform.localScale = Vector3.New(var_245_15, var_245_15, 0)
				end

				for iter_245_0, iter_245_1 in pairs(arg_242_1.bgs_) do
					if iter_245_0 ~= "ST1003a" then
						iter_245_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_245_16 = 0

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 then
				arg_242_1.allBtn_.enabled = false
			end

			local var_245_17 = 0.3

			if arg_242_1.time_ >= var_245_16 + var_245_17 and arg_242_1.time_ < var_245_16 + var_245_17 + arg_245_0 then
				arg_242_1.allBtn_.enabled = true
			end

			local var_245_18 = 0

			if var_245_18 < arg_242_1.time_ and arg_242_1.time_ <= var_245_18 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_19 = 2

			if var_245_18 <= arg_242_1.time_ and arg_242_1.time_ < var_245_18 + var_245_19 then
				local var_245_20 = (arg_242_1.time_ - var_245_18) / var_245_19
				local var_245_21 = Color.New(0, 0, 0)

				var_245_21.a = Mathf.Lerp(0, 1, var_245_20)
				arg_242_1.mask_.color = var_245_21
			end

			if arg_242_1.time_ >= var_245_18 + var_245_19 and arg_242_1.time_ < var_245_18 + var_245_19 + arg_245_0 then
				local var_245_22 = Color.New(0, 0, 0)

				var_245_22.a = 1
				arg_242_1.mask_.color = var_245_22
			end

			local var_245_23 = 2

			if var_245_23 < arg_242_1.time_ and arg_242_1.time_ <= var_245_23 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_24 = 2

			if var_245_23 <= arg_242_1.time_ and arg_242_1.time_ < var_245_23 + var_245_24 then
				local var_245_25 = (arg_242_1.time_ - var_245_23) / var_245_24
				local var_245_26 = Color.New(0, 0, 0)

				var_245_26.a = Mathf.Lerp(1, 0, var_245_25)
				arg_242_1.mask_.color = var_245_26
			end

			if arg_242_1.time_ >= var_245_23 + var_245_24 and arg_242_1.time_ < var_245_23 + var_245_24 + arg_245_0 then
				local var_245_27 = Color.New(0, 0, 0)
				local var_245_28 = 0

				arg_242_1.mask_.enabled = false
				var_245_27.a = var_245_28
				arg_242_1.mask_.color = var_245_27
			end

			local var_245_29 = arg_242_1.actors_["107301"]
			local var_245_30 = 0

			if var_245_30 < arg_242_1.time_ and arg_242_1.time_ <= var_245_30 + arg_245_0 and not isNil(var_245_29) and arg_242_1.var_.actorSpriteComps107301 == nil then
				arg_242_1.var_.actorSpriteComps107301 = var_245_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_31 = 0.2

			if var_245_30 <= arg_242_1.time_ and arg_242_1.time_ < var_245_30 + var_245_31 and not isNil(var_245_29) then
				local var_245_32 = (arg_242_1.time_ - var_245_30) / var_245_31

				if arg_242_1.var_.actorSpriteComps107301 then
					for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_245_3 then
							if arg_242_1.isInRecall_ then
								local var_245_33 = Mathf.Lerp(iter_245_3.color.r, arg_242_1.hightColor2.r, var_245_32)
								local var_245_34 = Mathf.Lerp(iter_245_3.color.g, arg_242_1.hightColor2.g, var_245_32)
								local var_245_35 = Mathf.Lerp(iter_245_3.color.b, arg_242_1.hightColor2.b, var_245_32)

								iter_245_3.color = Color.New(var_245_33, var_245_34, var_245_35)
							else
								local var_245_36 = Mathf.Lerp(iter_245_3.color.r, 0.5, var_245_32)

								iter_245_3.color = Color.New(var_245_36, var_245_36, var_245_36)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= var_245_30 + var_245_31 and arg_242_1.time_ < var_245_30 + var_245_31 + arg_245_0 and not isNil(var_245_29) and arg_242_1.var_.actorSpriteComps107301 then
				for iter_245_4, iter_245_5 in pairs(arg_242_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_245_5 then
						if arg_242_1.isInRecall_ then
							iter_245_5.color = arg_242_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_245_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_242_1.var_.actorSpriteComps107301 = nil
			end

			local var_245_37 = arg_242_1.actors_["107301"].transform
			local var_245_38 = 1.988

			if var_245_38 < arg_242_1.time_ and arg_242_1.time_ <= var_245_38 + arg_245_0 then
				arg_242_1.var_.moveOldPos107301 = var_245_37.localPosition
				var_245_37.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("107301", 7)

				local var_245_39 = var_245_37.childCount

				for iter_245_6 = 0, var_245_39 - 1 do
					local var_245_40 = var_245_37:GetChild(iter_245_6)

					if var_245_40.name == "" or not string.find(var_245_40.name, "split") then
						var_245_40.gameObject:SetActive(true)
					else
						var_245_40.gameObject:SetActive(false)
					end
				end
			end

			local var_245_41 = 0.001

			if var_245_38 <= arg_242_1.time_ and arg_242_1.time_ < var_245_38 + var_245_41 then
				local var_245_42 = (arg_242_1.time_ - var_245_38) / var_245_41
				local var_245_43 = Vector3.New(0, -2000, 0)

				var_245_37.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos107301, var_245_43, var_245_42)
			end

			if arg_242_1.time_ >= var_245_38 + var_245_41 and arg_242_1.time_ < var_245_38 + var_245_41 + arg_245_0 then
				var_245_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_245_44 = 0.533333333333333
			local var_245_45 = 0.2

			if var_245_44 < arg_242_1.time_ and arg_242_1.time_ <= var_245_44 + arg_245_0 then
				local var_245_46 = "play"
				local var_245_47 = "music"

				arg_242_1:AudioAction(var_245_46, var_245_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_245_48 = ""
				local var_245_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_245_49 ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_49 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_49

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_49
						arg_242_1.bgmTxt2_.text = var_245_49
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_245_50 = 0.533333333333333
			local var_245_51 = 1

			if var_245_50 < arg_242_1.time_ and arg_242_1.time_ <= var_245_50 + arg_245_0 then
				local var_245_52 = "stop"
				local var_245_53 = "effect"

				arg_242_1:AudioAction(var_245_52, var_245_53, "se_story_140", "se_story_140_amb_chinese restaurant", "")
			end

			local var_245_54 = 1.83333333333333
			local var_245_55 = 1

			if var_245_54 < arg_242_1.time_ and arg_242_1.time_ <= var_245_54 + arg_245_0 then
				local var_245_56 = "play"
				local var_245_57 = "effect"

				arg_242_1:AudioAction(var_245_56, var_245_57, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_245_58 = 4
			local var_245_59 = 1

			if var_245_58 < arg_242_1.time_ and arg_242_1.time_ <= var_245_58 + arg_245_0 then
				local var_245_60 = "play"
				local var_245_61 = "effect"

				arg_242_1:AudioAction(var_245_60, var_245_61, "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_245_62 = arg_242_1.actors_["10135"].transform
			local var_245_63 = 2

			if var_245_63 < arg_242_1.time_ and arg_242_1.time_ <= var_245_63 + arg_245_0 then
				arg_242_1.var_.moveOldPos10135 = var_245_62.localPosition
				var_245_62.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10135", 7)

				local var_245_64 = var_245_62.childCount

				for iter_245_7 = 0, var_245_64 - 1 do
					local var_245_65 = var_245_62:GetChild(iter_245_7)

					if var_245_65.name == "split_2" or not string.find(var_245_65.name, "split") then
						var_245_65.gameObject:SetActive(true)
					else
						var_245_65.gameObject:SetActive(false)
					end
				end
			end

			local var_245_66 = 0.001

			if var_245_63 <= arg_242_1.time_ and arg_242_1.time_ < var_245_63 + var_245_66 then
				local var_245_67 = (arg_242_1.time_ - var_245_63) / var_245_66
				local var_245_68 = Vector3.New(0, -2000, 0)

				var_245_62.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10135, var_245_68, var_245_67)
			end

			if arg_242_1.time_ >= var_245_63 + var_245_66 and arg_242_1.time_ < var_245_63 + var_245_66 + arg_245_0 then
				var_245_62.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_69 = 3.999999999999
			local var_245_70 = 0.7

			if var_245_69 < arg_242_1.time_ and arg_242_1.time_ <= var_245_69 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_71 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_71:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_242_1.dialogCg_.alpha = arg_247_0
				end))
				var_245_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_72 = arg_242_1:GetWordFromCfg(418071060)
				local var_245_73 = arg_242_1:FormatText(var_245_72.content)

				arg_242_1.text_.text = var_245_73

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_74 = 28
				local var_245_75 = utf8.len(var_245_73)
				local var_245_76 = var_245_74 <= 0 and var_245_70 or var_245_70 * (var_245_75 / var_245_74)

				if var_245_76 > 0 and var_245_70 < var_245_76 then
					arg_242_1.talkMaxDuration = var_245_76
					var_245_69 = var_245_69 + 0.3

					if var_245_76 + var_245_69 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_76 + var_245_69
					end
				end

				arg_242_1.text_.text = var_245_73
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_77 = var_245_69 + 0.3
			local var_245_78 = math.max(var_245_70, arg_242_1.talkMaxDuration)

			if var_245_77 <= arg_242_1.time_ and arg_242_1.time_ < var_245_77 + var_245_78 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_77) / var_245_78

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_77 + var_245_78 and arg_242_1.time_ < var_245_77 + var_245_78 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.988,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play418071061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 418071061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play418071062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.725

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_2 = arg_249_1:GetWordFromCfg(418071061)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 29
				local var_252_5 = utf8.len(var_252_3)
				local var_252_6 = var_252_4 <= 0 and var_252_1 or var_252_1 * (var_252_5 / var_252_4)

				if var_252_6 > 0 and var_252_1 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_7 and arg_249_1.time_ < var_252_0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play418071062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 418071062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play418071063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.725

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(418071062)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 29
				local var_256_5 = utf8.len(var_256_3)
				local var_256_6 = var_256_4 <= 0 and var_256_1 or var_256_1 * (var_256_5 / var_256_4)

				if var_256_6 > 0 and var_256_1 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_7 and arg_253_1.time_ < var_256_0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play418071063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 418071063
		arg_257_1.duration_ = 4.37

		local var_257_0 = {
			ja = 3.2,
			CriLanguages = 4.366,
			zh = 4.366
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
				arg_257_0:Play418071064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.325

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[1187].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10135_split_1")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(418071063)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 13
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071063", "story_v_side_old_418071.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071063", "story_v_side_old_418071.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_side_old_418071", "418071063", "story_v_side_old_418071.awb")

						arg_257_1:RecordAudio("418071063", var_260_9)
						arg_257_1:RecordAudio("418071063", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071063", "story_v_side_old_418071.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071063", "story_v_side_old_418071.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play418071064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 418071064
		arg_261_1.duration_ = 6.67

		local var_261_0 = {
			ja = 6.666,
			CriLanguages = 6.166,
			zh = 6.166
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
				arg_261_0:Play418071065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["107301"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps107301 == nil then
				arg_261_1.var_.actorSpriteComps107301 = var_264_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_2 = 0.2

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.actorSpriteComps107301 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_264_1 then
							if arg_261_1.isInRecall_ then
								local var_264_4 = Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor1.r, var_264_3)
								local var_264_5 = Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor1.g, var_264_3)
								local var_264_6 = Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor1.b, var_264_3)

								iter_264_1.color = Color.New(var_264_4, var_264_5, var_264_6)
							else
								local var_264_7 = Mathf.Lerp(iter_264_1.color.r, 1, var_264_3)

								iter_264_1.color = Color.New(var_264_7, var_264_7, var_264_7)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps107301 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_264_3 then
						if arg_261_1.isInRecall_ then
							iter_264_3.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps107301 = nil
			end

			local var_264_8 = arg_261_1.actors_["10135"]
			local var_264_9 = 0

			if var_264_9 < arg_261_1.time_ and arg_261_1.time_ <= var_264_9 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.actorSpriteComps10135 == nil then
				arg_261_1.var_.actorSpriteComps10135 = var_264_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_10 = 0.2

			if var_264_9 <= arg_261_1.time_ and arg_261_1.time_ < var_264_9 + var_264_10 and not isNil(var_264_8) then
				local var_264_11 = (arg_261_1.time_ - var_264_9) / var_264_10

				if arg_261_1.var_.actorSpriteComps10135 then
					for iter_264_4, iter_264_5 in pairs(arg_261_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_264_5 then
							if arg_261_1.isInRecall_ then
								local var_264_12 = Mathf.Lerp(iter_264_5.color.r, arg_261_1.hightColor2.r, var_264_11)
								local var_264_13 = Mathf.Lerp(iter_264_5.color.g, arg_261_1.hightColor2.g, var_264_11)
								local var_264_14 = Mathf.Lerp(iter_264_5.color.b, arg_261_1.hightColor2.b, var_264_11)

								iter_264_5.color = Color.New(var_264_12, var_264_13, var_264_14)
							else
								local var_264_15 = Mathf.Lerp(iter_264_5.color.r, 0.5, var_264_11)

								iter_264_5.color = Color.New(var_264_15, var_264_15, var_264_15)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_9 + var_264_10 and arg_261_1.time_ < var_264_9 + var_264_10 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.actorSpriteComps10135 then
				for iter_264_6, iter_264_7 in pairs(arg_261_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_264_7 then
						if arg_261_1.isInRecall_ then
							iter_264_7.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10135 = nil
			end

			local var_264_16 = arg_261_1.actors_["10135"].transform
			local var_264_17 = 0

			if var_264_17 < arg_261_1.time_ and arg_261_1.time_ <= var_264_17 + arg_264_0 then
				arg_261_1.var_.moveOldPos10135 = var_264_16.localPosition
				var_264_16.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10135", 7)

				local var_264_18 = var_264_16.childCount

				for iter_264_8 = 0, var_264_18 - 1 do
					local var_264_19 = var_264_16:GetChild(iter_264_8)

					if var_264_19.name == "" or not string.find(var_264_19.name, "split") then
						var_264_19.gameObject:SetActive(true)
					else
						var_264_19.gameObject:SetActive(false)
					end
				end
			end

			local var_264_20 = 0.001

			if var_264_17 <= arg_261_1.time_ and arg_261_1.time_ < var_264_17 + var_264_20 then
				local var_264_21 = (arg_261_1.time_ - var_264_17) / var_264_20
				local var_264_22 = Vector3.New(0, -2000, 0)

				var_264_16.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10135, var_264_22, var_264_21)
			end

			if arg_261_1.time_ >= var_264_17 + var_264_20 and arg_261_1.time_ < var_264_17 + var_264_20 + arg_264_0 then
				var_264_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_264_23 = arg_261_1.actors_["107301"].transform
			local var_264_24 = 0

			if var_264_24 < arg_261_1.time_ and arg_261_1.time_ <= var_264_24 + arg_264_0 then
				arg_261_1.var_.moveOldPos107301 = var_264_23.localPosition
				var_264_23.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("107301", 3)

				local var_264_25 = var_264_23.childCount

				for iter_264_9 = 0, var_264_25 - 1 do
					local var_264_26 = var_264_23:GetChild(iter_264_9)

					if var_264_26.name == "" or not string.find(var_264_26.name, "split") then
						var_264_26.gameObject:SetActive(true)
					else
						var_264_26.gameObject:SetActive(false)
					end
				end
			end

			local var_264_27 = 0.001

			if var_264_24 <= arg_261_1.time_ and arg_261_1.time_ < var_264_24 + var_264_27 then
				local var_264_28 = (arg_261_1.time_ - var_264_24) / var_264_27
				local var_264_29 = Vector3.New(-14.4, -367.6, -201.9)

				var_264_23.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos107301, var_264_29, var_264_28)
			end

			if arg_261_1.time_ >= var_264_24 + var_264_27 and arg_261_1.time_ < var_264_24 + var_264_27 + arg_264_0 then
				var_264_23.localPosition = Vector3.New(-14.4, -367.6, -201.9)
			end

			local var_264_30 = 0
			local var_264_31 = 0.575

			if var_264_30 < arg_261_1.time_ and arg_261_1.time_ <= var_264_30 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_32 = arg_261_1:FormatText(StoryNameCfg[380].name)

				arg_261_1.leftNameTxt_.text = var_264_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_33 = arg_261_1:GetWordFromCfg(418071064)
				local var_264_34 = arg_261_1:FormatText(var_264_33.content)

				arg_261_1.text_.text = var_264_34

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_35 = 23
				local var_264_36 = utf8.len(var_264_34)
				local var_264_37 = var_264_35 <= 0 and var_264_31 or var_264_31 * (var_264_36 / var_264_35)

				if var_264_37 > 0 and var_264_31 < var_264_37 then
					arg_261_1.talkMaxDuration = var_264_37

					if var_264_37 + var_264_30 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_37 + var_264_30
					end
				end

				arg_261_1.text_.text = var_264_34
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071064", "story_v_side_old_418071.awb") ~= 0 then
					local var_264_38 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071064", "story_v_side_old_418071.awb") / 1000

					if var_264_38 + var_264_30 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_38 + var_264_30
					end

					if var_264_33.prefab_name ~= "" and arg_261_1.actors_[var_264_33.prefab_name] ~= nil then
						local var_264_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_33.prefab_name].transform, "story_v_side_old_418071", "418071064", "story_v_side_old_418071.awb")

						arg_261_1:RecordAudio("418071064", var_264_39)
						arg_261_1:RecordAudio("418071064", var_264_39)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071064", "story_v_side_old_418071.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071064", "story_v_side_old_418071.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_40 = math.max(var_264_31, arg_261_1.talkMaxDuration)

			if var_264_30 <= arg_261_1.time_ and arg_261_1.time_ < var_264_30 + var_264_40 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_30) / var_264_40

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_30 + var_264_40 and arg_261_1.time_ < var_264_30 + var_264_40 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "107301",
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
	Play418071065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 418071065
		arg_265_1.duration_ = 6.8

		local var_265_0 = {
			ja = 6.8,
			CriLanguages = 5.366,
			zh = 5.366
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
				arg_265_0:Play418071066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10135"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps10135 == nil then
				arg_265_1.var_.actorSpriteComps10135 = var_268_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_2 = 0.2

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.actorSpriteComps10135 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								local var_268_4 = Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor1.r, var_268_3)
								local var_268_5 = Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor1.g, var_268_3)
								local var_268_6 = Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor1.b, var_268_3)

								iter_268_1.color = Color.New(var_268_4, var_268_5, var_268_6)
							else
								local var_268_7 = Mathf.Lerp(iter_268_1.color.r, 1, var_268_3)

								iter_268_1.color = Color.New(var_268_7, var_268_7, var_268_7)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps10135 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_268_3 then
						if arg_265_1.isInRecall_ then
							iter_268_3.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10135 = nil
			end

			local var_268_8 = arg_265_1.actors_["107301"]
			local var_268_9 = 0

			if var_268_9 < arg_265_1.time_ and arg_265_1.time_ <= var_268_9 + arg_268_0 and not isNil(var_268_8) and arg_265_1.var_.actorSpriteComps107301 == nil then
				arg_265_1.var_.actorSpriteComps107301 = var_268_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_10 = 0.2

			if var_268_9 <= arg_265_1.time_ and arg_265_1.time_ < var_268_9 + var_268_10 and not isNil(var_268_8) then
				local var_268_11 = (arg_265_1.time_ - var_268_9) / var_268_10

				if arg_265_1.var_.actorSpriteComps107301 then
					for iter_268_4, iter_268_5 in pairs(arg_265_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_268_5 then
							if arg_265_1.isInRecall_ then
								local var_268_12 = Mathf.Lerp(iter_268_5.color.r, arg_265_1.hightColor2.r, var_268_11)
								local var_268_13 = Mathf.Lerp(iter_268_5.color.g, arg_265_1.hightColor2.g, var_268_11)
								local var_268_14 = Mathf.Lerp(iter_268_5.color.b, arg_265_1.hightColor2.b, var_268_11)

								iter_268_5.color = Color.New(var_268_12, var_268_13, var_268_14)
							else
								local var_268_15 = Mathf.Lerp(iter_268_5.color.r, 0.5, var_268_11)

								iter_268_5.color = Color.New(var_268_15, var_268_15, var_268_15)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_9 + var_268_10 and arg_265_1.time_ < var_268_9 + var_268_10 + arg_268_0 and not isNil(var_268_8) and arg_265_1.var_.actorSpriteComps107301 then
				for iter_268_6, iter_268_7 in pairs(arg_265_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_268_7 then
						if arg_265_1.isInRecall_ then
							iter_268_7.color = arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_268_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps107301 = nil
			end

			local var_268_16 = 0
			local var_268_17 = 0.475

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_18 = arg_265_1:FormatText(StoryNameCfg[1187].name)

				arg_265_1.leftNameTxt_.text = var_268_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10135_split_1")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_19 = arg_265_1:GetWordFromCfg(418071065)
				local var_268_20 = arg_265_1:FormatText(var_268_19.content)

				arg_265_1.text_.text = var_268_20

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_21 = 19
				local var_268_22 = utf8.len(var_268_20)
				local var_268_23 = var_268_21 <= 0 and var_268_17 or var_268_17 * (var_268_22 / var_268_21)

				if var_268_23 > 0 and var_268_17 < var_268_23 then
					arg_265_1.talkMaxDuration = var_268_23

					if var_268_23 + var_268_16 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_23 + var_268_16
					end
				end

				arg_265_1.text_.text = var_268_20
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071065", "story_v_side_old_418071.awb") ~= 0 then
					local var_268_24 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071065", "story_v_side_old_418071.awb") / 1000

					if var_268_24 + var_268_16 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_24 + var_268_16
					end

					if var_268_19.prefab_name ~= "" and arg_265_1.actors_[var_268_19.prefab_name] ~= nil then
						local var_268_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_19.prefab_name].transform, "story_v_side_old_418071", "418071065", "story_v_side_old_418071.awb")

						arg_265_1:RecordAudio("418071065", var_268_25)
						arg_265_1:RecordAudio("418071065", var_268_25)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071065", "story_v_side_old_418071.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071065", "story_v_side_old_418071.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_26 = math.max(var_268_17, arg_265_1.talkMaxDuration)

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_26 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_16) / var_268_26

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_16 + var_268_26 and arg_265_1.time_ < var_268_16 + var_268_26 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play418071066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 418071066
		arg_269_1.duration_ = 8.1

		local var_269_0 = {
			ja = 8.1,
			CriLanguages = 6.3,
			zh = 6.3
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
			arg_269_1.auto_ = false
		end

		function arg_269_1.playNext_(arg_271_0)
			arg_269_1.onStoryFinished_()
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["107301"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps107301 == nil then
				arg_269_1.var_.actorSpriteComps107301 = var_272_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_2 = 0.2

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.actorSpriteComps107301 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								local var_272_4 = Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor1.r, var_272_3)
								local var_272_5 = Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor1.g, var_272_3)
								local var_272_6 = Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor1.b, var_272_3)

								iter_272_1.color = Color.New(var_272_4, var_272_5, var_272_6)
							else
								local var_272_7 = Mathf.Lerp(iter_272_1.color.r, 1, var_272_3)

								iter_272_1.color = Color.New(var_272_7, var_272_7, var_272_7)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps107301 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_272_3 then
						if arg_269_1.isInRecall_ then
							iter_272_3.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps107301 = nil
			end

			local var_272_8 = arg_269_1.actors_["10135"]
			local var_272_9 = 0

			if var_272_9 < arg_269_1.time_ and arg_269_1.time_ <= var_272_9 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps10135 == nil then
				arg_269_1.var_.actorSpriteComps10135 = var_272_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_10 = 0.2

			if var_272_9 <= arg_269_1.time_ and arg_269_1.time_ < var_272_9 + var_272_10 and not isNil(var_272_8) then
				local var_272_11 = (arg_269_1.time_ - var_272_9) / var_272_10

				if arg_269_1.var_.actorSpriteComps10135 then
					for iter_272_4, iter_272_5 in pairs(arg_269_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_272_5 then
							if arg_269_1.isInRecall_ then
								local var_272_12 = Mathf.Lerp(iter_272_5.color.r, arg_269_1.hightColor2.r, var_272_11)
								local var_272_13 = Mathf.Lerp(iter_272_5.color.g, arg_269_1.hightColor2.g, var_272_11)
								local var_272_14 = Mathf.Lerp(iter_272_5.color.b, arg_269_1.hightColor2.b, var_272_11)

								iter_272_5.color = Color.New(var_272_12, var_272_13, var_272_14)
							else
								local var_272_15 = Mathf.Lerp(iter_272_5.color.r, 0.5, var_272_11)

								iter_272_5.color = Color.New(var_272_15, var_272_15, var_272_15)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_9 + var_272_10 and arg_269_1.time_ < var_272_9 + var_272_10 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps10135 then
				for iter_272_6, iter_272_7 in pairs(arg_269_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_272_7 then
						if arg_269_1.isInRecall_ then
							iter_272_7.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10135 = nil
			end

			local var_272_16 = arg_269_1.actors_["107301"].transform
			local var_272_17 = 0

			if var_272_17 < arg_269_1.time_ and arg_269_1.time_ <= var_272_17 + arg_272_0 then
				arg_269_1.var_.moveOldPos107301 = var_272_16.localPosition
				var_272_16.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("107301", 3)

				local var_272_18 = var_272_16.childCount

				for iter_272_8 = 0, var_272_18 - 1 do
					local var_272_19 = var_272_16:GetChild(iter_272_8)

					if var_272_19.name == "split_4" or not string.find(var_272_19.name, "split") then
						var_272_19.gameObject:SetActive(true)
					else
						var_272_19.gameObject:SetActive(false)
					end
				end
			end

			local var_272_20 = 0.001

			if var_272_17 <= arg_269_1.time_ and arg_269_1.time_ < var_272_17 + var_272_20 then
				local var_272_21 = (arg_269_1.time_ - var_272_17) / var_272_20
				local var_272_22 = Vector3.New(-14.4, -367.6, -201.9)

				var_272_16.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos107301, var_272_22, var_272_21)
			end

			if arg_269_1.time_ >= var_272_17 + var_272_20 and arg_269_1.time_ < var_272_17 + var_272_20 + arg_272_0 then
				var_272_16.localPosition = Vector3.New(-14.4, -367.6, -201.9)
			end

			local var_272_23 = 0
			local var_272_24 = 0.675

			if var_272_23 < arg_269_1.time_ and arg_269_1.time_ <= var_272_23 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_25 = arg_269_1:FormatText(StoryNameCfg[380].name)

				arg_269_1.leftNameTxt_.text = var_272_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_26 = arg_269_1:GetWordFromCfg(418071066)
				local var_272_27 = arg_269_1:FormatText(var_272_26.content)

				arg_269_1.text_.text = var_272_27

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_28 = 27
				local var_272_29 = utf8.len(var_272_27)
				local var_272_30 = var_272_28 <= 0 and var_272_24 or var_272_24 * (var_272_29 / var_272_28)

				if var_272_30 > 0 and var_272_24 < var_272_30 then
					arg_269_1.talkMaxDuration = var_272_30

					if var_272_30 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_30 + var_272_23
					end
				end

				arg_269_1.text_.text = var_272_27
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071066", "story_v_side_old_418071.awb") ~= 0 then
					local var_272_31 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071066", "story_v_side_old_418071.awb") / 1000

					if var_272_31 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_31 + var_272_23
					end

					if var_272_26.prefab_name ~= "" and arg_269_1.actors_[var_272_26.prefab_name] ~= nil then
						local var_272_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_26.prefab_name].transform, "story_v_side_old_418071", "418071066", "story_v_side_old_418071.awb")

						arg_269_1:RecordAudio("418071066", var_272_32)
						arg_269_1:RecordAudio("418071066", var_272_32)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071066", "story_v_side_old_418071.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071066", "story_v_side_old_418071.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_33 = math.max(var_272_24, arg_269_1.talkMaxDuration)

			if var_272_23 <= arg_269_1.time_ and arg_269_1.time_ < var_272_23 + var_272_33 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_23) / var_272_33

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_23 + var_272_33 and arg_269_1.time_ < var_272_23 + var_272_33 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST40",
		"TextureConfig/Background/ST1003a"
	},
	voices = {
		"story_v_side_old_418071.awb"
	}
}
