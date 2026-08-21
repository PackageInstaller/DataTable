return {
	Play418031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418031001
		arg_1_1.duration_ = 16.17

		local var_1_0 = {
			ja = 16.166,
			CriLanguages = 10.733,
			zh = 10.733
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
				arg_1_0:Play418031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST1001b"

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
				local var_4_5 = arg_1_1.bgs_.ST1001b

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
					if iter_4_0 ~= "ST1001b" then
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

			local var_4_24 = 0.05
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_140", "se_story_140_amb_harbor", "")
			end

			local var_4_28 = 0.4
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.875

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[1188].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(418031001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 35
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031001", "story_v_side_old_418031.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031001", "story_v_side_old_418031.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_side_old_418031", "418031001", "story_v_side_old_418031.awb")

						arg_1_1:RecordAudio("418031001", var_4_44)
						arg_1_1:RecordAudio("418031001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031001", "story_v_side_old_418031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031001", "story_v_side_old_418031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_34 + 0.3
			local var_4_46 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play418031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418031002
		arg_8_1.duration_ = 3.1

		local var_8_0 = {
			ja = 2.633,
			CriLanguages = 3.1,
			zh = 3.1
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
				arg_8_0:Play418031003(arg_8_1)
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

			local var_11_12 = arg_8_1.actors_["10135"].transform
			local var_11_13 = 0

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 then
				arg_8_1.var_.moveOldPos10135 = var_11_12.localPosition
				var_11_12.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10135", 3)

				local var_11_14 = var_11_12.childCount

				for iter_11_6 = 0, var_11_14 - 1 do
					local var_11_15 = var_11_12:GetChild(iter_11_6)

					if var_11_15.name == "split_6" or not string.find(var_11_15.name, "split") then
						var_11_15.gameObject:SetActive(true)
					else
						var_11_15.gameObject:SetActive(false)
					end
				end
			end

			local var_11_16 = 0.001

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_16 then
				local var_11_17 = (arg_8_1.time_ - var_11_13) / var_11_16
				local var_11_18 = Vector3.New(-12.7, -363.6, -305.9)

				var_11_12.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10135, var_11_18, var_11_17)
			end

			if arg_8_1.time_ >= var_11_13 + var_11_16 and arg_8_1.time_ < var_11_13 + var_11_16 + arg_11_0 then
				var_11_12.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_11_19 = 0
			local var_11_20 = 0.4

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_21 = arg_8_1:FormatText(StoryNameCfg[1187].name)

				arg_8_1.leftNameTxt_.text = var_11_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_22 = arg_8_1:GetWordFromCfg(418031002)
				local var_11_23 = arg_8_1:FormatText(var_11_22.content)

				arg_8_1.text_.text = var_11_23

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_24 = 16
				local var_11_25 = utf8.len(var_11_23)
				local var_11_26 = var_11_24 <= 0 and var_11_20 or var_11_20 * (var_11_25 / var_11_24)

				if var_11_26 > 0 and var_11_20 < var_11_26 then
					arg_8_1.talkMaxDuration = var_11_26

					if var_11_26 + var_11_19 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_26 + var_11_19
					end
				end

				arg_8_1.text_.text = var_11_23
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031002", "story_v_side_old_418031.awb") ~= 0 then
					local var_11_27 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031002", "story_v_side_old_418031.awb") / 1000

					if var_11_27 + var_11_19 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_27 + var_11_19
					end

					if var_11_22.prefab_name ~= "" and arg_8_1.actors_[var_11_22.prefab_name] ~= nil then
						local var_11_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_22.prefab_name].transform, "story_v_side_old_418031", "418031002", "story_v_side_old_418031.awb")

						arg_8_1:RecordAudio("418031002", var_11_28)
						arg_8_1:RecordAudio("418031002", var_11_28)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031002", "story_v_side_old_418031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031002", "story_v_side_old_418031.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_29 = math.max(var_11_20, arg_8_1.talkMaxDuration)

			if var_11_19 <= arg_8_1.time_ and arg_8_1.time_ < var_11_19 + var_11_29 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_19) / var_11_29

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_19 + var_11_29 and arg_8_1.time_ < var_11_19 + var_11_29 + arg_11_0 then
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
	Play418031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418031003
		arg_12_1.duration_ = 8.3

		local var_12_0 = {
			ja = 8.3,
			CriLanguages = 8.2,
			zh = 8.2
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
				arg_12_0:Play418031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["10135"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps10135 == nil then
				arg_12_1.var_.actorSpriteComps10135 = var_15_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.actorSpriteComps10135 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_15_1 then
							if arg_12_1.isInRecall_ then
								local var_15_4 = Mathf.Lerp(iter_15_1.color.r, arg_12_1.hightColor2.r, var_15_3)
								local var_15_5 = Mathf.Lerp(iter_15_1.color.g, arg_12_1.hightColor2.g, var_15_3)
								local var_15_6 = Mathf.Lerp(iter_15_1.color.b, arg_12_1.hightColor2.b, var_15_3)

								iter_15_1.color = Color.New(var_15_4, var_15_5, var_15_6)
							else
								local var_15_7 = Mathf.Lerp(iter_15_1.color.r, 0.5, var_15_3)

								iter_15_1.color = Color.New(var_15_7, var_15_7, var_15_7)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps10135 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_15_3 then
						if arg_12_1.isInRecall_ then
							iter_15_3.color = arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_15_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps10135 = nil
			end

			local var_15_8 = 0
			local var_15_9 = 0.825

			if var_15_8 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_10 = arg_12_1:FormatText(StoryNameCfg[1188].name)

				arg_12_1.leftNameTxt_.text = var_15_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_11 = arg_12_1:GetWordFromCfg(418031003)
				local var_15_12 = arg_12_1:FormatText(var_15_11.content)

				arg_12_1.text_.text = var_15_12

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 33
				local var_15_14 = utf8.len(var_15_12)
				local var_15_15 = var_15_13 <= 0 and var_15_9 or var_15_9 * (var_15_14 / var_15_13)

				if var_15_15 > 0 and var_15_9 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_12
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031003", "story_v_side_old_418031.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031003", "story_v_side_old_418031.awb") / 1000

					if var_15_16 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_8
					end

					if var_15_11.prefab_name ~= "" and arg_12_1.actors_[var_15_11.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_11.prefab_name].transform, "story_v_side_old_418031", "418031003", "story_v_side_old_418031.awb")

						arg_12_1:RecordAudio("418031003", var_15_17)
						arg_12_1:RecordAudio("418031003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031003", "story_v_side_old_418031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031003", "story_v_side_old_418031.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_18 and arg_12_1.time_ < var_15_8 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play418031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418031004
		arg_16_1.duration_ = 4.83

		local var_16_0 = {
			ja = 4.833,
			CriLanguages = 4.333,
			zh = 4.333
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
				arg_16_0:Play418031005(arg_16_1)
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

			local var_19_8 = arg_16_1.actors_["10135"].transform
			local var_19_9 = 0

			if var_19_9 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 then
				arg_16_1.var_.moveOldPos10135 = var_19_8.localPosition
				var_19_8.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10135", 3)

				local var_19_10 = var_19_8.childCount

				for iter_19_4 = 0, var_19_10 - 1 do
					local var_19_11 = var_19_8:GetChild(iter_19_4)

					if var_19_11.name == "split_4" or not string.find(var_19_11.name, "split") then
						var_19_11.gameObject:SetActive(true)
					else
						var_19_11.gameObject:SetActive(false)
					end
				end
			end

			local var_19_12 = 0.001

			if var_19_9 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_12 then
				local var_19_13 = (arg_16_1.time_ - var_19_9) / var_19_12
				local var_19_14 = Vector3.New(-12.7, -363.6, -305.9)

				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10135, var_19_14, var_19_13)
			end

			if arg_16_1.time_ >= var_19_9 + var_19_12 and arg_16_1.time_ < var_19_9 + var_19_12 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_19_15 = 0
			local var_19_16 = 0.6

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_17 = arg_16_1:FormatText(StoryNameCfg[1187].name)

				arg_16_1.leftNameTxt_.text = var_19_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_18 = arg_16_1:GetWordFromCfg(418031004)
				local var_19_19 = arg_16_1:FormatText(var_19_18.content)

				arg_16_1.text_.text = var_19_19

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_20 = 24
				local var_19_21 = utf8.len(var_19_19)
				local var_19_22 = var_19_20 <= 0 and var_19_16 or var_19_16 * (var_19_21 / var_19_20)

				if var_19_22 > 0 and var_19_16 < var_19_22 then
					arg_16_1.talkMaxDuration = var_19_22

					if var_19_22 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_19
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031004", "story_v_side_old_418031.awb") ~= 0 then
					local var_19_23 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031004", "story_v_side_old_418031.awb") / 1000

					if var_19_23 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_23 + var_19_15
					end

					if var_19_18.prefab_name ~= "" and arg_16_1.actors_[var_19_18.prefab_name] ~= nil then
						local var_19_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_18.prefab_name].transform, "story_v_side_old_418031", "418031004", "story_v_side_old_418031.awb")

						arg_16_1:RecordAudio("418031004", var_19_24)
						arg_16_1:RecordAudio("418031004", var_19_24)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031004", "story_v_side_old_418031.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031004", "story_v_side_old_418031.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_25 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_25 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_15) / var_19_25

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_15 + var_19_25 and arg_16_1.time_ < var_19_15 + var_19_25 + arg_19_0 then
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
	Play418031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418031005
		arg_20_1.duration_ = 9.03

		local var_20_0 = {
			ja = 9.033,
			CriLanguages = 7.1,
			zh = 7.1
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
				arg_20_0:Play418031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1073"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1073")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(var_23_1, arg_20_1.canvasGo_.transform)

					var_23_2.transform:SetSiblingIndex(1)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_20_1.isInRecall_ then
						for iter_23_0, iter_23_1 in ipairs(var_23_3) do
							iter_23_1.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_23_4 = arg_20_1.actors_["1073"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.actorSpriteComps1073 == nil then
				arg_20_1.var_.actorSpriteComps1073 = var_23_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_6 = 0.2

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.actorSpriteComps1073 then
					for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_23_3 then
							if arg_20_1.isInRecall_ then
								local var_23_8 = Mathf.Lerp(iter_23_3.color.r, arg_20_1.hightColor1.r, var_23_7)
								local var_23_9 = Mathf.Lerp(iter_23_3.color.g, arg_20_1.hightColor1.g, var_23_7)
								local var_23_10 = Mathf.Lerp(iter_23_3.color.b, arg_20_1.hightColor1.b, var_23_7)

								iter_23_3.color = Color.New(var_23_8, var_23_9, var_23_10)
							else
								local var_23_11 = Mathf.Lerp(iter_23_3.color.r, 1, var_23_7)

								iter_23_3.color = Color.New(var_23_11, var_23_11, var_23_11)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.actorSpriteComps1073 then
				for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_23_5 then
						if arg_20_1.isInRecall_ then
							iter_23_5.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_23_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps1073 = nil
			end

			local var_23_12 = arg_20_1.actors_["10135"]
			local var_23_13 = 0

			if var_23_13 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 and not isNil(var_23_12) and arg_20_1.var_.actorSpriteComps10135 == nil then
				arg_20_1.var_.actorSpriteComps10135 = var_23_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_14 = 0.2

			if var_23_13 <= arg_20_1.time_ and arg_20_1.time_ < var_23_13 + var_23_14 and not isNil(var_23_12) then
				local var_23_15 = (arg_20_1.time_ - var_23_13) / var_23_14

				if arg_20_1.var_.actorSpriteComps10135 then
					for iter_23_6, iter_23_7 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_23_7 then
							if arg_20_1.isInRecall_ then
								local var_23_16 = Mathf.Lerp(iter_23_7.color.r, arg_20_1.hightColor2.r, var_23_15)
								local var_23_17 = Mathf.Lerp(iter_23_7.color.g, arg_20_1.hightColor2.g, var_23_15)
								local var_23_18 = Mathf.Lerp(iter_23_7.color.b, arg_20_1.hightColor2.b, var_23_15)

								iter_23_7.color = Color.New(var_23_16, var_23_17, var_23_18)
							else
								local var_23_19 = Mathf.Lerp(iter_23_7.color.r, 0.5, var_23_15)

								iter_23_7.color = Color.New(var_23_19, var_23_19, var_23_19)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_13 + var_23_14 and arg_20_1.time_ < var_23_13 + var_23_14 + arg_23_0 and not isNil(var_23_12) and arg_20_1.var_.actorSpriteComps10135 then
				for iter_23_8, iter_23_9 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_23_9 then
						if arg_20_1.isInRecall_ then
							iter_23_9.color = arg_20_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_23_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps10135 = nil
			end

			local var_23_20 = arg_20_1.actors_["10135"].transform
			local var_23_21 = 0

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.var_.moveOldPos10135 = var_23_20.localPosition
				var_23_20.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("10135", 7)

				local var_23_22 = var_23_20.childCount

				for iter_23_10 = 0, var_23_22 - 1 do
					local var_23_23 = var_23_20:GetChild(iter_23_10)

					if var_23_23.name == "" or not string.find(var_23_23.name, "split") then
						var_23_23.gameObject:SetActive(true)
					else
						var_23_23.gameObject:SetActive(false)
					end
				end
			end

			local var_23_24 = 0.001

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_24 then
				local var_23_25 = (arg_20_1.time_ - var_23_21) / var_23_24
				local var_23_26 = Vector3.New(0, -2000, 0)

				var_23_20.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10135, var_23_26, var_23_25)
			end

			if arg_20_1.time_ >= var_23_21 + var_23_24 and arg_20_1.time_ < var_23_21 + var_23_24 + arg_23_0 then
				var_23_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_23_27 = arg_20_1.actors_["1073"].transform
			local var_23_28 = 0

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 then
				arg_20_1.var_.moveOldPos1073 = var_23_27.localPosition
				var_23_27.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("1073", 3)

				local var_23_29 = var_23_27.childCount

				for iter_23_11 = 0, var_23_29 - 1 do
					local var_23_30 = var_23_27:GetChild(iter_23_11)

					if var_23_30.name == "" or not string.find(var_23_30.name, "split") then
						var_23_30.gameObject:SetActive(true)
					else
						var_23_30.gameObject:SetActive(false)
					end
				end
			end

			local var_23_31 = 0.001

			if var_23_28 <= arg_20_1.time_ and arg_20_1.time_ < var_23_28 + var_23_31 then
				local var_23_32 = (arg_20_1.time_ - var_23_28) / var_23_31
				local var_23_33 = Vector3.New(38.6, -414.5, -207.2)

				var_23_27.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1073, var_23_33, var_23_32)
			end

			if arg_20_1.time_ >= var_23_28 + var_23_31 and arg_20_1.time_ < var_23_28 + var_23_31 + arg_23_0 then
				var_23_27.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_23_34 = 0
			local var_23_35 = 0.8

			if var_23_34 < arg_20_1.time_ and arg_20_1.time_ <= var_23_34 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_36 = arg_20_1:FormatText(StoryNameCfg[380].name)

				arg_20_1.leftNameTxt_.text = var_23_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_37 = arg_20_1:GetWordFromCfg(418031005)
				local var_23_38 = arg_20_1:FormatText(var_23_37.content)

				arg_20_1.text_.text = var_23_38

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_39 = 32
				local var_23_40 = utf8.len(var_23_38)
				local var_23_41 = var_23_39 <= 0 and var_23_35 or var_23_35 * (var_23_40 / var_23_39)

				if var_23_41 > 0 and var_23_35 < var_23_41 then
					arg_20_1.talkMaxDuration = var_23_41

					if var_23_41 + var_23_34 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_41 + var_23_34
					end
				end

				arg_20_1.text_.text = var_23_38
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031005", "story_v_side_old_418031.awb") ~= 0 then
					local var_23_42 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031005", "story_v_side_old_418031.awb") / 1000

					if var_23_42 + var_23_34 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_42 + var_23_34
					end

					if var_23_37.prefab_name ~= "" and arg_20_1.actors_[var_23_37.prefab_name] ~= nil then
						local var_23_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_37.prefab_name].transform, "story_v_side_old_418031", "418031005", "story_v_side_old_418031.awb")

						arg_20_1:RecordAudio("418031005", var_23_43)
						arg_20_1:RecordAudio("418031005", var_23_43)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031005", "story_v_side_old_418031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031005", "story_v_side_old_418031.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_44 = math.max(var_23_35, arg_20_1.talkMaxDuration)

			if var_23_34 <= arg_20_1.time_ and arg_20_1.time_ < var_23_34 + var_23_44 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_34) / var_23_44

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_34 + var_23_44 and arg_20_1.time_ < var_23_34 + var_23_44 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play418031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418031006
		arg_24_1.duration_ = 14.4

		local var_24_0 = {
			ja = 14.4,
			CriLanguages = 11.866,
			zh = 11.866
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
				arg_24_0:Play418031007(arg_24_1)
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

				arg_24_1:CheckSpriteTmpPos("10135", 3)

				local var_27_18 = var_27_16.childCount

				for iter_27_8 = 0, var_27_18 - 1 do
					local var_27_19 = var_27_16:GetChild(iter_27_8)

					if var_27_19.name == "split_5" or not string.find(var_27_19.name, "split") then
						var_27_19.gameObject:SetActive(true)
					else
						var_27_19.gameObject:SetActive(false)
					end
				end
			end

			local var_27_20 = 0.001

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_20 then
				local var_27_21 = (arg_24_1.time_ - var_27_17) / var_27_20
				local var_27_22 = Vector3.New(-12.7, -363.6, -305.9)

				var_27_16.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10135, var_27_22, var_27_21)
			end

			if arg_24_1.time_ >= var_27_17 + var_27_20 and arg_24_1.time_ < var_27_17 + var_27_20 + arg_27_0 then
				var_27_16.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_27_23 = arg_24_1.actors_["1073"].transform
			local var_27_24 = 0

			if var_27_24 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 then
				arg_24_1.var_.moveOldPos1073 = var_27_23.localPosition
				var_27_23.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("1073", 7)

				local var_27_25 = var_27_23.childCount

				for iter_27_9 = 0, var_27_25 - 1 do
					local var_27_26 = var_27_23:GetChild(iter_27_9)

					if var_27_26.name == "" or not string.find(var_27_26.name, "split") then
						var_27_26.gameObject:SetActive(true)
					else
						var_27_26.gameObject:SetActive(false)
					end
				end
			end

			local var_27_27 = 0.001

			if var_27_24 <= arg_24_1.time_ and arg_24_1.time_ < var_27_24 + var_27_27 then
				local var_27_28 = (arg_24_1.time_ - var_27_24) / var_27_27
				local var_27_29 = Vector3.New(0, -2000, 0)

				var_27_23.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1073, var_27_29, var_27_28)
			end

			if arg_24_1.time_ >= var_27_24 + var_27_27 and arg_24_1.time_ < var_27_24 + var_27_27 + arg_27_0 then
				var_27_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_27_30 = 0
			local var_27_31 = 1.3

			if var_27_30 < arg_24_1.time_ and arg_24_1.time_ <= var_27_30 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_32 = arg_24_1:FormatText(StoryNameCfg[1187].name)

				arg_24_1.leftNameTxt_.text = var_27_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_33 = arg_24_1:GetWordFromCfg(418031006)
				local var_27_34 = arg_24_1:FormatText(var_27_33.content)

				arg_24_1.text_.text = var_27_34

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_35 = 52
				local var_27_36 = utf8.len(var_27_34)
				local var_27_37 = var_27_35 <= 0 and var_27_31 or var_27_31 * (var_27_36 / var_27_35)

				if var_27_37 > 0 and var_27_31 < var_27_37 then
					arg_24_1.talkMaxDuration = var_27_37

					if var_27_37 + var_27_30 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_37 + var_27_30
					end
				end

				arg_24_1.text_.text = var_27_34
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031006", "story_v_side_old_418031.awb") ~= 0 then
					local var_27_38 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031006", "story_v_side_old_418031.awb") / 1000

					if var_27_38 + var_27_30 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_38 + var_27_30
					end

					if var_27_33.prefab_name ~= "" and arg_24_1.actors_[var_27_33.prefab_name] ~= nil then
						local var_27_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_33.prefab_name].transform, "story_v_side_old_418031", "418031006", "story_v_side_old_418031.awb")

						arg_24_1:RecordAudio("418031006", var_27_39)
						arg_24_1:RecordAudio("418031006", var_27_39)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031006", "story_v_side_old_418031.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031006", "story_v_side_old_418031.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_40 = math.max(var_27_31, arg_24_1.talkMaxDuration)

			if var_27_30 <= arg_24_1.time_ and arg_24_1.time_ < var_27_30 + var_27_40 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_30) / var_27_40

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_30 + var_27_40 and arg_24_1.time_ < var_27_30 + var_27_40 + arg_27_0 then
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

		arg_24_1:InitPlayNodeList()
	end,
	Play418031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 418031007
		arg_28_1.duration_ = 12.7

		local var_28_0 = {
			ja = 12.7,
			CriLanguages = 11.2,
			zh = 11.2
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
				arg_28_0:Play418031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10135"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps10135 == nil then
				arg_28_1.var_.actorSpriteComps10135 = var_31_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.actorSpriteComps10135 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_31_1 then
							if arg_28_1.isInRecall_ then
								local var_31_4 = Mathf.Lerp(iter_31_1.color.r, arg_28_1.hightColor2.r, var_31_3)
								local var_31_5 = Mathf.Lerp(iter_31_1.color.g, arg_28_1.hightColor2.g, var_31_3)
								local var_31_6 = Mathf.Lerp(iter_31_1.color.b, arg_28_1.hightColor2.b, var_31_3)

								iter_31_1.color = Color.New(var_31_4, var_31_5, var_31_6)
							else
								local var_31_7 = Mathf.Lerp(iter_31_1.color.r, 0.5, var_31_3)

								iter_31_1.color = Color.New(var_31_7, var_31_7, var_31_7)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps10135 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_31_3 then
						if arg_28_1.isInRecall_ then
							iter_31_3.color = arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_31_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps10135 = nil
			end

			local var_31_8 = 0
			local var_31_9 = 1.15

			if var_31_8 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_10 = arg_28_1:FormatText(StoryNameCfg[1188].name)

				arg_28_1.leftNameTxt_.text = var_31_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_11 = arg_28_1:GetWordFromCfg(418031007)
				local var_31_12 = arg_28_1:FormatText(var_31_11.content)

				arg_28_1.text_.text = var_31_12

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 46
				local var_31_14 = utf8.len(var_31_12)
				local var_31_15 = var_31_13 <= 0 and var_31_9 or var_31_9 * (var_31_14 / var_31_13)

				if var_31_15 > 0 and var_31_9 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_12
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031007", "story_v_side_old_418031.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031007", "story_v_side_old_418031.awb") / 1000

					if var_31_16 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_8
					end

					if var_31_11.prefab_name ~= "" and arg_28_1.actors_[var_31_11.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_11.prefab_name].transform, "story_v_side_old_418031", "418031007", "story_v_side_old_418031.awb")

						arg_28_1:RecordAudio("418031007", var_31_17)
						arg_28_1:RecordAudio("418031007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031007", "story_v_side_old_418031.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031007", "story_v_side_old_418031.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_18 and arg_28_1.time_ < var_31_8 + var_31_18 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play418031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 418031008
		arg_32_1.duration_ = 22.27

		local var_32_0 = {
			ja = 22.266,
			CriLanguages = 12.3,
			zh = 12.3
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
				arg_32_0:Play418031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1.425

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[1188].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(418031008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 57
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031008", "story_v_side_old_418031.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031008", "story_v_side_old_418031.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_side_old_418031", "418031008", "story_v_side_old_418031.awb")

						arg_32_1:RecordAudio("418031008", var_35_9)
						arg_32_1:RecordAudio("418031008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031008", "story_v_side_old_418031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031008", "story_v_side_old_418031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play418031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 418031009
		arg_36_1.duration_ = 7.7

		local var_36_0 = {
			ja = 7.7,
			CriLanguages = 6.133,
			zh = 6.133
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
				arg_36_0:Play418031010(arg_36_1)
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

			local var_39_8 = arg_36_1.actors_["10135"].transform
			local var_39_9 = 0

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 then
				arg_36_1.var_.moveOldPos10135 = var_39_8.localPosition
				var_39_8.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("10135", 7)

				local var_39_10 = var_39_8.childCount

				for iter_39_4 = 0, var_39_10 - 1 do
					local var_39_11 = var_39_8:GetChild(iter_39_4)

					if var_39_11.name == "" or not string.find(var_39_11.name, "split") then
						var_39_11.gameObject:SetActive(true)
					else
						var_39_11.gameObject:SetActive(false)
					end
				end
			end

			local var_39_12 = 0.001

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_12 then
				local var_39_13 = (arg_36_1.time_ - var_39_9) / var_39_12
				local var_39_14 = Vector3.New(0, -2000, 0)

				var_39_8.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10135, var_39_14, var_39_13)
			end

			if arg_36_1.time_ >= var_39_9 + var_39_12 and arg_36_1.time_ < var_39_9 + var_39_12 + arg_39_0 then
				var_39_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_39_15 = arg_36_1.actors_["1073"].transform
			local var_39_16 = 0

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.var_.moveOldPos1073 = var_39_15.localPosition
				var_39_15.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("1073", 3)

				local var_39_17 = var_39_15.childCount

				for iter_39_5 = 0, var_39_17 - 1 do
					local var_39_18 = var_39_15:GetChild(iter_39_5)

					if var_39_18.name == "" or not string.find(var_39_18.name, "split") then
						var_39_18.gameObject:SetActive(true)
					else
						var_39_18.gameObject:SetActive(false)
					end
				end
			end

			local var_39_19 = 0.001

			if var_39_16 <= arg_36_1.time_ and arg_36_1.time_ < var_39_16 + var_39_19 then
				local var_39_20 = (arg_36_1.time_ - var_39_16) / var_39_19
				local var_39_21 = Vector3.New(38.6, -414.5, -207.2)

				var_39_15.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1073, var_39_21, var_39_20)
			end

			if arg_36_1.time_ >= var_39_16 + var_39_19 and arg_36_1.time_ < var_39_16 + var_39_19 + arg_39_0 then
				var_39_15.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_39_22 = 0
			local var_39_23 = 0.75

			if var_39_22 < arg_36_1.time_ and arg_36_1.time_ <= var_39_22 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_24 = arg_36_1:FormatText(StoryNameCfg[380].name)

				arg_36_1.leftNameTxt_.text = var_39_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_25 = arg_36_1:GetWordFromCfg(418031009)
				local var_39_26 = arg_36_1:FormatText(var_39_25.content)

				arg_36_1.text_.text = var_39_26

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_27 = 30
				local var_39_28 = utf8.len(var_39_26)
				local var_39_29 = var_39_27 <= 0 and var_39_23 or var_39_23 * (var_39_28 / var_39_27)

				if var_39_29 > 0 and var_39_23 < var_39_29 then
					arg_36_1.talkMaxDuration = var_39_29

					if var_39_29 + var_39_22 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_29 + var_39_22
					end
				end

				arg_36_1.text_.text = var_39_26
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031009", "story_v_side_old_418031.awb") ~= 0 then
					local var_39_30 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031009", "story_v_side_old_418031.awb") / 1000

					if var_39_30 + var_39_22 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_30 + var_39_22
					end

					if var_39_25.prefab_name ~= "" and arg_36_1.actors_[var_39_25.prefab_name] ~= nil then
						local var_39_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_25.prefab_name].transform, "story_v_side_old_418031", "418031009", "story_v_side_old_418031.awb")

						arg_36_1:RecordAudio("418031009", var_39_31)
						arg_36_1:RecordAudio("418031009", var_39_31)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031009", "story_v_side_old_418031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031009", "story_v_side_old_418031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_32 = math.max(var_39_23, arg_36_1.talkMaxDuration)

			if var_39_22 <= arg_36_1.time_ and arg_36_1.time_ < var_39_22 + var_39_32 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_22) / var_39_32

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_22 + var_39_32 and arg_36_1.time_ < var_39_22 + var_39_32 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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

		arg_36_1:InitPlayNodeList()
	end,
	Play418031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 418031010
		arg_40_1.duration_ = 15.6

		local var_40_0 = {
			ja = 15.6,
			CriLanguages = 13.4,
			zh = 13.4
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
				arg_40_0:Play418031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1073"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps1073 == nil then
				arg_40_1.var_.actorSpriteComps1073 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps1073 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								local var_43_4 = Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor2.r, var_43_3)
								local var_43_5 = Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor2.g, var_43_3)
								local var_43_6 = Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor2.b, var_43_3)

								iter_43_1.color = Color.New(var_43_4, var_43_5, var_43_6)
							else
								local var_43_7 = Mathf.Lerp(iter_43_1.color.r, 0.5, var_43_3)

								iter_43_1.color = Color.New(var_43_7, var_43_7, var_43_7)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps1073 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_43_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps1073 = nil
			end

			local var_43_8 = 0
			local var_43_9 = 1.375

			if var_43_8 < arg_40_1.time_ and arg_40_1.time_ <= var_43_8 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_10 = arg_40_1:FormatText(StoryNameCfg[1188].name)

				arg_40_1.leftNameTxt_.text = var_43_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_11 = arg_40_1:GetWordFromCfg(418031010)
				local var_43_12 = arg_40_1:FormatText(var_43_11.content)

				arg_40_1.text_.text = var_43_12

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_13 = 55
				local var_43_14 = utf8.len(var_43_12)
				local var_43_15 = var_43_13 <= 0 and var_43_9 or var_43_9 * (var_43_14 / var_43_13)

				if var_43_15 > 0 and var_43_9 < var_43_15 then
					arg_40_1.talkMaxDuration = var_43_15

					if var_43_15 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_15 + var_43_8
					end
				end

				arg_40_1.text_.text = var_43_12
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031010", "story_v_side_old_418031.awb") ~= 0 then
					local var_43_16 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031010", "story_v_side_old_418031.awb") / 1000

					if var_43_16 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_16 + var_43_8
					end

					if var_43_11.prefab_name ~= "" and arg_40_1.actors_[var_43_11.prefab_name] ~= nil then
						local var_43_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_11.prefab_name].transform, "story_v_side_old_418031", "418031010", "story_v_side_old_418031.awb")

						arg_40_1:RecordAudio("418031010", var_43_17)
						arg_40_1:RecordAudio("418031010", var_43_17)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031010", "story_v_side_old_418031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031010", "story_v_side_old_418031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_18 = math.max(var_43_9, arg_40_1.talkMaxDuration)

			if var_43_8 <= arg_40_1.time_ and arg_40_1.time_ < var_43_8 + var_43_18 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_8) / var_43_18

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_8 + var_43_18 and arg_40_1.time_ < var_43_8 + var_43_18 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play418031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 418031011
		arg_44_1.duration_ = 14.7

		local var_44_0 = {
			ja = 14.7,
			CriLanguages = 11.766,
			zh = 11.766
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
				arg_44_0:Play418031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.175

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[1188].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(418031011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 47
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031011", "story_v_side_old_418031.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031011", "story_v_side_old_418031.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_side_old_418031", "418031011", "story_v_side_old_418031.awb")

						arg_44_1:RecordAudio("418031011", var_47_9)
						arg_44_1:RecordAudio("418031011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031011", "story_v_side_old_418031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031011", "story_v_side_old_418031.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play418031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 418031012
		arg_48_1.duration_ = 8.93

		local var_48_0 = {
			ja = 8.933,
			CriLanguages = 5.133,
			zh = 5.133
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
				arg_48_0:Play418031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1073"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1073 == nil then
				arg_48_1.var_.actorSpriteComps1073 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps1073 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1073 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_51_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps1073 = nil
			end

			local var_51_8 = 0
			local var_51_9 = 0.65

			if var_51_8 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_10 = arg_48_1:FormatText(StoryNameCfg[380].name)

				arg_48_1.leftNameTxt_.text = var_51_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_11 = arg_48_1:GetWordFromCfg(418031012)
				local var_51_12 = arg_48_1:FormatText(var_51_11.content)

				arg_48_1.text_.text = var_51_12

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_13 = 26
				local var_51_14 = utf8.len(var_51_12)
				local var_51_15 = var_51_13 <= 0 and var_51_9 or var_51_9 * (var_51_14 / var_51_13)

				if var_51_15 > 0 and var_51_9 < var_51_15 then
					arg_48_1.talkMaxDuration = var_51_15

					if var_51_15 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_15 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_12
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031012", "story_v_side_old_418031.awb") ~= 0 then
					local var_51_16 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031012", "story_v_side_old_418031.awb") / 1000

					if var_51_16 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_16 + var_51_8
					end

					if var_51_11.prefab_name ~= "" and arg_48_1.actors_[var_51_11.prefab_name] ~= nil then
						local var_51_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_11.prefab_name].transform, "story_v_side_old_418031", "418031012", "story_v_side_old_418031.awb")

						arg_48_1:RecordAudio("418031012", var_51_17)
						arg_48_1:RecordAudio("418031012", var_51_17)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031012", "story_v_side_old_418031.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031012", "story_v_side_old_418031.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_18 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_18 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_18

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_18 and arg_48_1.time_ < var_51_8 + var_51_18 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play418031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 418031013
		arg_52_1.duration_ = 24.8

		local var_52_0 = {
			ja = 24.8,
			CriLanguages = 15.966,
			zh = 15.966
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
				arg_52_0:Play418031014(arg_52_1)
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
								local var_55_4 = Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor2.r, var_55_3)
								local var_55_5 = Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor2.g, var_55_3)
								local var_55_6 = Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor2.b, var_55_3)

								iter_55_1.color = Color.New(var_55_4, var_55_5, var_55_6)
							else
								local var_55_7 = Mathf.Lerp(iter_55_1.color.r, 0.5, var_55_3)

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
							iter_55_3.color = arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_55_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps1073 = nil
			end

			local var_55_8 = 0
			local var_55_9 = 1.55

			if var_55_8 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_10 = arg_52_1:FormatText(StoryNameCfg[1188].name)

				arg_52_1.leftNameTxt_.text = var_55_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_11 = arg_52_1:GetWordFromCfg(418031013)
				local var_55_12 = arg_52_1:FormatText(var_55_11.content)

				arg_52_1.text_.text = var_55_12

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 62
				local var_55_14 = utf8.len(var_55_12)
				local var_55_15 = var_55_13 <= 0 and var_55_9 or var_55_9 * (var_55_14 / var_55_13)

				if var_55_15 > 0 and var_55_9 < var_55_15 then
					arg_52_1.talkMaxDuration = var_55_15

					if var_55_15 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_15 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_12
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031013", "story_v_side_old_418031.awb") ~= 0 then
					local var_55_16 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031013", "story_v_side_old_418031.awb") / 1000

					if var_55_16 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_16 + var_55_8
					end

					if var_55_11.prefab_name ~= "" and arg_52_1.actors_[var_55_11.prefab_name] ~= nil then
						local var_55_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_11.prefab_name].transform, "story_v_side_old_418031", "418031013", "story_v_side_old_418031.awb")

						arg_52_1:RecordAudio("418031013", var_55_17)
						arg_52_1:RecordAudio("418031013", var_55_17)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031013", "story_v_side_old_418031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031013", "story_v_side_old_418031.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_18 = math.max(var_55_9, arg_52_1.talkMaxDuration)

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_18 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_8) / var_55_18

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_8 + var_55_18 and arg_52_1.time_ < var_55_8 + var_55_18 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play418031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 418031014
		arg_56_1.duration_ = 8.4

		local var_56_0 = {
			ja = 8.4,
			CriLanguages = 7.266,
			zh = 7.266
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
				arg_56_0:Play418031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1073"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1073 == nil then
				arg_56_1.var_.actorSpriteComps1073 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps1073 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1073 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_59_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps1073 = nil
			end

			local var_59_8 = arg_56_1.actors_["1073"].transform
			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.var_.moveOldPos1073 = var_59_8.localPosition
				var_59_8.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("1073", 3)

				local var_59_10 = var_59_8.childCount

				for iter_59_4 = 0, var_59_10 - 1 do
					local var_59_11 = var_59_8:GetChild(iter_59_4)

					if var_59_11.name == "split_3" or not string.find(var_59_11.name, "split") then
						var_59_11.gameObject:SetActive(true)
					else
						var_59_11.gameObject:SetActive(false)
					end
				end
			end

			local var_59_12 = 0.001

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_12 then
				local var_59_13 = (arg_56_1.time_ - var_59_9) / var_59_12
				local var_59_14 = Vector3.New(38.6, -414.5, -207.2)

				var_59_8.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1073, var_59_14, var_59_13)
			end

			if arg_56_1.time_ >= var_59_9 + var_59_12 and arg_56_1.time_ < var_59_9 + var_59_12 + arg_59_0 then
				var_59_8.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_59_15 = 0
			local var_59_16 = 0.8

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_17 = arg_56_1:FormatText(StoryNameCfg[380].name)

				arg_56_1.leftNameTxt_.text = var_59_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(418031014)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 32
				local var_59_21 = utf8.len(var_59_19)
				local var_59_22 = var_59_20 <= 0 and var_59_16 or var_59_16 * (var_59_21 / var_59_20)

				if var_59_22 > 0 and var_59_16 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22

					if var_59_22 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031014", "story_v_side_old_418031.awb") ~= 0 then
					local var_59_23 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031014", "story_v_side_old_418031.awb") / 1000

					if var_59_23 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_15
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_side_old_418031", "418031014", "story_v_side_old_418031.awb")

						arg_56_1:RecordAudio("418031014", var_59_24)
						arg_56_1:RecordAudio("418031014", var_59_24)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031014", "story_v_side_old_418031.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031014", "story_v_side_old_418031.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_25 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_25 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_25

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_25 and arg_56_1.time_ < var_59_15 + var_59_25 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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

		arg_56_1:InitPlayNodeList()
	end,
	Play418031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 418031015
		arg_60_1.duration_ = 8.5

		local var_60_0 = {
			ja = 8.5,
			CriLanguages = 6.9,
			zh = 6.9
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
				arg_60_0:Play418031016(arg_60_1)
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
								local var_63_4 = Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor2.r, var_63_3)
								local var_63_5 = Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor2.g, var_63_3)
								local var_63_6 = Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor2.b, var_63_3)

								iter_63_1.color = Color.New(var_63_4, var_63_5, var_63_6)
							else
								local var_63_7 = Mathf.Lerp(iter_63_1.color.r, 0.5, var_63_3)

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
							iter_63_3.color = arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_63_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps1073 = nil
			end

			local var_63_8 = 0
			local var_63_9 = 0.6

			if var_63_8 < arg_60_1.time_ and arg_60_1.time_ <= var_63_8 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_10 = arg_60_1:FormatText(StoryNameCfg[1188].name)

				arg_60_1.leftNameTxt_.text = var_63_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_11 = arg_60_1:GetWordFromCfg(418031015)
				local var_63_12 = arg_60_1:FormatText(var_63_11.content)

				arg_60_1.text_.text = var_63_12

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_13 = 24
				local var_63_14 = utf8.len(var_63_12)
				local var_63_15 = var_63_13 <= 0 and var_63_9 or var_63_9 * (var_63_14 / var_63_13)

				if var_63_15 > 0 and var_63_9 < var_63_15 then
					arg_60_1.talkMaxDuration = var_63_15

					if var_63_15 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_15 + var_63_8
					end
				end

				arg_60_1.text_.text = var_63_12
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031015", "story_v_side_old_418031.awb") ~= 0 then
					local var_63_16 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031015", "story_v_side_old_418031.awb") / 1000

					if var_63_16 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_16 + var_63_8
					end

					if var_63_11.prefab_name ~= "" and arg_60_1.actors_[var_63_11.prefab_name] ~= nil then
						local var_63_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_11.prefab_name].transform, "story_v_side_old_418031", "418031015", "story_v_side_old_418031.awb")

						arg_60_1:RecordAudio("418031015", var_63_17)
						arg_60_1:RecordAudio("418031015", var_63_17)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031015", "story_v_side_old_418031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031015", "story_v_side_old_418031.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_18 = math.max(var_63_9, arg_60_1.talkMaxDuration)

			if var_63_8 <= arg_60_1.time_ and arg_60_1.time_ < var_63_8 + var_63_18 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_8) / var_63_18

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_8 + var_63_18 and arg_60_1.time_ < var_63_8 + var_63_18 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play418031016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 418031016
		arg_64_1.duration_ = 1

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"

			SetActive(arg_64_1.choicesGo_, true)

			for iter_65_0, iter_65_1 in ipairs(arg_64_1.choices_) do
				local var_65_0 = iter_65_0 <= 2

				SetActive(iter_65_1.go, var_65_0)
			end

			arg_64_1.choices_[1].txt.text = arg_64_1:FormatText(StoryChoiceCfg[1276].name)
			arg_64_1.choices_[2].txt.text = arg_64_1:FormatText(StoryChoiceCfg[1277].name)
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play418031017(arg_64_1)
			end

			if arg_66_0 == 2 then
				arg_64_0:Play418031017(arg_64_1)
			end

			arg_64_1:RecordChoiceLog(418031016, 1276, 1277)
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			return
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play418031017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 418031017
		arg_68_1.duration_ = 5.57

		local var_68_0 = {
			ja = 4.733,
			CriLanguages = 5.566,
			zh = 5.566
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
				arg_68_0:Play418031018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10135"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10135 == nil then
				arg_68_1.var_.actorSpriteComps10135 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps10135 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10135 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_71_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps10135 = nil
			end

			local var_71_8 = arg_68_1.actors_["10135"].transform
			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 then
				arg_68_1.var_.moveOldPos10135 = var_71_8.localPosition
				var_71_8.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10135", 3)

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
				local var_71_14 = Vector3.New(-12.7, -363.6, -305.9)

				var_71_8.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10135, var_71_14, var_71_13)
			end

			if arg_68_1.time_ >= var_71_9 + var_71_12 and arg_68_1.time_ < var_71_9 + var_71_12 + arg_71_0 then
				var_71_8.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_71_15 = arg_68_1.actors_["1073"].transform
			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.var_.moveOldPos1073 = var_71_15.localPosition
				var_71_15.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("1073", 7)

				local var_71_17 = var_71_15.childCount

				for iter_71_5 = 0, var_71_17 - 1 do
					local var_71_18 = var_71_15:GetChild(iter_71_5)

					if var_71_18.name == "" or not string.find(var_71_18.name, "split") then
						var_71_18.gameObject:SetActive(true)
					else
						var_71_18.gameObject:SetActive(false)
					end
				end
			end

			local var_71_19 = 0.001

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_19 then
				local var_71_20 = (arg_68_1.time_ - var_71_16) / var_71_19
				local var_71_21 = Vector3.New(0, -2000, 0)

				var_71_15.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1073, var_71_21, var_71_20)
			end

			if arg_68_1.time_ >= var_71_16 + var_71_19 and arg_68_1.time_ < var_71_16 + var_71_19 + arg_71_0 then
				var_71_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_71_22 = 0
			local var_71_23 = 0.525

			if var_71_22 < arg_68_1.time_ and arg_68_1.time_ <= var_71_22 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_24 = arg_68_1:FormatText(StoryNameCfg[1187].name)

				arg_68_1.leftNameTxt_.text = var_71_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_25 = arg_68_1:GetWordFromCfg(418031017)
				local var_71_26 = arg_68_1:FormatText(var_71_25.content)

				arg_68_1.text_.text = var_71_26

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_27 = 21
				local var_71_28 = utf8.len(var_71_26)
				local var_71_29 = var_71_27 <= 0 and var_71_23 or var_71_23 * (var_71_28 / var_71_27)

				if var_71_29 > 0 and var_71_23 < var_71_29 then
					arg_68_1.talkMaxDuration = var_71_29

					if var_71_29 + var_71_22 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_29 + var_71_22
					end
				end

				arg_68_1.text_.text = var_71_26
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031017", "story_v_side_old_418031.awb") ~= 0 then
					local var_71_30 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031017", "story_v_side_old_418031.awb") / 1000

					if var_71_30 + var_71_22 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_30 + var_71_22
					end

					if var_71_25.prefab_name ~= "" and arg_68_1.actors_[var_71_25.prefab_name] ~= nil then
						local var_71_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_25.prefab_name].transform, "story_v_side_old_418031", "418031017", "story_v_side_old_418031.awb")

						arg_68_1:RecordAudio("418031017", var_71_31)
						arg_68_1:RecordAudio("418031017", var_71_31)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031017", "story_v_side_old_418031.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031017", "story_v_side_old_418031.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_32 = math.max(var_71_23, arg_68_1.talkMaxDuration)

			if var_71_22 <= arg_68_1.time_ and arg_68_1.time_ < var_71_22 + var_71_32 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_22) / var_71_32

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_22 + var_71_32 and arg_68_1.time_ < var_71_22 + var_71_32 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play418031018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 418031018
		arg_72_1.duration_ = 8.83

		local var_72_0 = {
			ja = 8.833,
			CriLanguages = 8.3,
			zh = 8.3
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
				arg_72_0:Play418031019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1073"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps1073 == nil then
				arg_72_1.var_.actorSpriteComps1073 = var_75_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.actorSpriteComps1073 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps1073 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_75_3 then
						if arg_72_1.isInRecall_ then
							iter_75_3.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_75_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps1073 = nil
			end

			local var_75_8 = arg_72_1.actors_["10135"]
			local var_75_9 = 0

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 and not isNil(var_75_8) and arg_72_1.var_.actorSpriteComps10135 == nil then
				arg_72_1.var_.actorSpriteComps10135 = var_75_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_10 = 0.2

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_10 and not isNil(var_75_8) then
				local var_75_11 = (arg_72_1.time_ - var_75_9) / var_75_10

				if arg_72_1.var_.actorSpriteComps10135 then
					for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_72_1.time_ >= var_75_9 + var_75_10 and arg_72_1.time_ < var_75_9 + var_75_10 + arg_75_0 and not isNil(var_75_8) and arg_72_1.var_.actorSpriteComps10135 then
				for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_75_7 then
						if arg_72_1.isInRecall_ then
							iter_75_7.color = arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_75_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps10135 = nil
			end

			local var_75_16 = arg_72_1.actors_["10135"].transform
			local var_75_17 = 0

			if var_75_17 < arg_72_1.time_ and arg_72_1.time_ <= var_75_17 + arg_75_0 then
				arg_72_1.var_.moveOldPos10135 = var_75_16.localPosition
				var_75_16.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10135", 4)

				local var_75_18 = var_75_16.childCount

				for iter_75_8 = 0, var_75_18 - 1 do
					local var_75_19 = var_75_16:GetChild(iter_75_8)

					if var_75_19.name == "split_6" or not string.find(var_75_19.name, "split") then
						var_75_19.gameObject:SetActive(true)
					else
						var_75_19.gameObject:SetActive(false)
					end
				end
			end

			local var_75_20 = 0.001

			if var_75_17 <= arg_72_1.time_ and arg_72_1.time_ < var_75_17 + var_75_20 then
				local var_75_21 = (arg_72_1.time_ - var_75_17) / var_75_20
				local var_75_22 = Vector3.New(432.72, -363.6, -305.9)

				var_75_16.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10135, var_75_22, var_75_21)
			end

			if arg_72_1.time_ >= var_75_17 + var_75_20 and arg_72_1.time_ < var_75_17 + var_75_20 + arg_75_0 then
				var_75_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_75_23 = arg_72_1.actors_["1073"].transform
			local var_75_24 = 0

			if var_75_24 < arg_72_1.time_ and arg_72_1.time_ <= var_75_24 + arg_75_0 then
				arg_72_1.var_.moveOldPos1073 = var_75_23.localPosition
				var_75_23.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("1073", 2)

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
				local var_75_29 = Vector3.New(-405.76, -414.5, -207.2)

				var_75_23.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1073, var_75_29, var_75_28)
			end

			if arg_72_1.time_ >= var_75_24 + var_75_27 and arg_72_1.time_ < var_75_24 + var_75_27 + arg_75_0 then
				var_75_23.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_75_30 = 0
			local var_75_31 = 1

			if var_75_30 < arg_72_1.time_ and arg_72_1.time_ <= var_75_30 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_32 = arg_72_1:FormatText(StoryNameCfg[380].name)

				arg_72_1.leftNameTxt_.text = var_75_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_33 = arg_72_1:GetWordFromCfg(418031018)
				local var_75_34 = arg_72_1:FormatText(var_75_33.content)

				arg_72_1.text_.text = var_75_34

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_35 = 40
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

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031018", "story_v_side_old_418031.awb") ~= 0 then
					local var_75_38 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031018", "story_v_side_old_418031.awb") / 1000

					if var_75_38 + var_75_30 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_38 + var_75_30
					end

					if var_75_33.prefab_name ~= "" and arg_72_1.actors_[var_75_33.prefab_name] ~= nil then
						local var_75_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_33.prefab_name].transform, "story_v_side_old_418031", "418031018", "story_v_side_old_418031.awb")

						arg_72_1:RecordAudio("418031018", var_75_39)
						arg_72_1:RecordAudio("418031018", var_75_39)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031018", "story_v_side_old_418031.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031018", "story_v_side_old_418031.awb")
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

		arg_72_1:InitPlayNodeList()
	end,
	Play418031019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 418031019
		arg_76_1.duration_ = 4.1

		local var_76_0 = {
			ja = 4.1,
			CriLanguages = 3.7,
			zh = 3.7
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
				arg_76_0:Play418031020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10135"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10135 == nil then
				arg_76_1.var_.actorSpriteComps10135 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps10135 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10135 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10135 = nil
			end

			local var_79_8 = arg_76_1.actors_["1073"]
			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps1073 == nil then
				arg_76_1.var_.actorSpriteComps1073 = var_79_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_10 = 0.2

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_10 and not isNil(var_79_8) then
				local var_79_11 = (arg_76_1.time_ - var_79_9) / var_79_10

				if arg_76_1.var_.actorSpriteComps1073 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_76_1.time_ >= var_79_9 + var_79_10 and arg_76_1.time_ < var_79_9 + var_79_10 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps1073 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_79_7 then
						if arg_76_1.isInRecall_ then
							iter_79_7.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps1073 = nil
			end

			local var_79_16 = arg_76_1.actors_["10135"].transform
			local var_79_17 = 0

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.var_.moveOldPos10135 = var_79_16.localPosition
				var_79_16.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10135", 4)

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
				local var_79_22 = Vector3.New(432.72, -363.6, -305.9)

				var_79_16.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10135, var_79_22, var_79_21)
			end

			if arg_76_1.time_ >= var_79_17 + var_79_20 and arg_76_1.time_ < var_79_17 + var_79_20 + arg_79_0 then
				var_79_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_79_23 = 0
			local var_79_24 = 0.25

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_25 = arg_76_1:FormatText(StoryNameCfg[1187].name)

				arg_76_1.leftNameTxt_.text = var_79_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_26 = arg_76_1:GetWordFromCfg(418031019)
				local var_79_27 = arg_76_1:FormatText(var_79_26.content)

				arg_76_1.text_.text = var_79_27

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_28 = 10
				local var_79_29 = utf8.len(var_79_27)
				local var_79_30 = var_79_28 <= 0 and var_79_24 or var_79_24 * (var_79_29 / var_79_28)

				if var_79_30 > 0 and var_79_24 < var_79_30 then
					arg_76_1.talkMaxDuration = var_79_30

					if var_79_30 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_30 + var_79_23
					end
				end

				arg_76_1.text_.text = var_79_27
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031019", "story_v_side_old_418031.awb") ~= 0 then
					local var_79_31 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031019", "story_v_side_old_418031.awb") / 1000

					if var_79_31 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_31 + var_79_23
					end

					if var_79_26.prefab_name ~= "" and arg_76_1.actors_[var_79_26.prefab_name] ~= nil then
						local var_79_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_26.prefab_name].transform, "story_v_side_old_418031", "418031019", "story_v_side_old_418031.awb")

						arg_76_1:RecordAudio("418031019", var_79_32)
						arg_76_1:RecordAudio("418031019", var_79_32)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031019", "story_v_side_old_418031.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031019", "story_v_side_old_418031.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_33 = math.max(var_79_24, arg_76_1.talkMaxDuration)

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_33 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_23) / var_79_33

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_23 + var_79_33 and arg_76_1.time_ < var_79_23 + var_79_33 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play418031020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 418031020
		arg_80_1.duration_ = 5.93

		local var_80_0 = {
			ja = 5.233,
			CriLanguages = 5.933,
			zh = 5.933
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
				arg_80_0:Play418031021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1073"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps1073 == nil then
				arg_80_1.var_.actorSpriteComps1073 = var_83_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.actorSpriteComps1073 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps1073 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_83_3 then
						if arg_80_1.isInRecall_ then
							iter_83_3.color = arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_83_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps1073 = nil
			end

			local var_83_8 = arg_80_1.actors_["10135"]
			local var_83_9 = 0

			if var_83_9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps10135 == nil then
				arg_80_1.var_.actorSpriteComps10135 = var_83_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_10 = 0.2

			if var_83_9 <= arg_80_1.time_ and arg_80_1.time_ < var_83_9 + var_83_10 and not isNil(var_83_8) then
				local var_83_11 = (arg_80_1.time_ - var_83_9) / var_83_10

				if arg_80_1.var_.actorSpriteComps10135 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_80_1.time_ >= var_83_9 + var_83_10 and arg_80_1.time_ < var_83_9 + var_83_10 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps10135 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_83_7 then
						if arg_80_1.isInRecall_ then
							iter_83_7.color = arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_83_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps10135 = nil
			end

			local var_83_16 = arg_80_1.actors_["1073"].transform
			local var_83_17 = 0

			if var_83_17 < arg_80_1.time_ and arg_80_1.time_ <= var_83_17 + arg_83_0 then
				arg_80_1.var_.moveOldPos1073 = var_83_16.localPosition
				var_83_16.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("1073", 2)

				local var_83_18 = var_83_16.childCount

				for iter_83_8 = 0, var_83_18 - 1 do
					local var_83_19 = var_83_16:GetChild(iter_83_8)

					if var_83_19.name == "split_2" or not string.find(var_83_19.name, "split") then
						var_83_19.gameObject:SetActive(true)
					else
						var_83_19.gameObject:SetActive(false)
					end
				end
			end

			local var_83_20 = 0.001

			if var_83_17 <= arg_80_1.time_ and arg_80_1.time_ < var_83_17 + var_83_20 then
				local var_83_21 = (arg_80_1.time_ - var_83_17) / var_83_20
				local var_83_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_83_16.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1073, var_83_22, var_83_21)
			end

			if arg_80_1.time_ >= var_83_17 + var_83_20 and arg_80_1.time_ < var_83_17 + var_83_20 + arg_83_0 then
				var_83_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_83_23 = 0
			local var_83_24 = 0.7

			if var_83_23 < arg_80_1.time_ and arg_80_1.time_ <= var_83_23 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_25 = arg_80_1:FormatText(StoryNameCfg[380].name)

				arg_80_1.leftNameTxt_.text = var_83_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_26 = arg_80_1:GetWordFromCfg(418031020)
				local var_83_27 = arg_80_1:FormatText(var_83_26.content)

				arg_80_1.text_.text = var_83_27

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_28 = 28
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

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031020", "story_v_side_old_418031.awb") ~= 0 then
					local var_83_31 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031020", "story_v_side_old_418031.awb") / 1000

					if var_83_31 + var_83_23 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_31 + var_83_23
					end

					if var_83_26.prefab_name ~= "" and arg_80_1.actors_[var_83_26.prefab_name] ~= nil then
						local var_83_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_26.prefab_name].transform, "story_v_side_old_418031", "418031020", "story_v_side_old_418031.awb")

						arg_80_1:RecordAudio("418031020", var_83_32)
						arg_80_1:RecordAudio("418031020", var_83_32)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031020", "story_v_side_old_418031.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031020", "story_v_side_old_418031.awb")
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
				actorName = "1073",
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
	Play418031021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 418031021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play418031022(arg_84_1)
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
								local var_87_4 = Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor2.r, var_87_3)
								local var_87_5 = Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor2.g, var_87_3)
								local var_87_6 = Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor2.b, var_87_3)

								iter_87_1.color = Color.New(var_87_4, var_87_5, var_87_6)
							else
								local var_87_7 = Mathf.Lerp(iter_87_1.color.r, 0.5, var_87_3)

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
							iter_87_3.color = arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_87_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps1073 = nil
			end

			local var_87_8 = arg_84_1.actors_["1073"].transform
			local var_87_9 = 0

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				arg_84_1.var_.moveOldPos1073 = var_87_8.localPosition
				var_87_8.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("1073", 7)

				local var_87_10 = var_87_8.childCount

				for iter_87_4 = 0, var_87_10 - 1 do
					local var_87_11 = var_87_8:GetChild(iter_87_4)

					if var_87_11.name == "" or not string.find(var_87_11.name, "split") then
						var_87_11.gameObject:SetActive(true)
					else
						var_87_11.gameObject:SetActive(false)
					end
				end
			end

			local var_87_12 = 0.001

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_9) / var_87_12
				local var_87_14 = Vector3.New(0, -2000, 0)

				var_87_8.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1073, var_87_14, var_87_13)
			end

			if arg_84_1.time_ >= var_87_9 + var_87_12 and arg_84_1.time_ < var_87_9 + var_87_12 + arg_87_0 then
				var_87_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_87_15 = arg_84_1.actors_["10135"].transform
			local var_87_16 = 0

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 then
				arg_84_1.var_.moveOldPos10135 = var_87_15.localPosition
				var_87_15.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("10135", 7)

				local var_87_17 = var_87_15.childCount

				for iter_87_5 = 0, var_87_17 - 1 do
					local var_87_18 = var_87_15:GetChild(iter_87_5)

					if var_87_18.name == "" or not string.find(var_87_18.name, "split") then
						var_87_18.gameObject:SetActive(true)
					else
						var_87_18.gameObject:SetActive(false)
					end
				end
			end

			local var_87_19 = 0.001

			if var_87_16 <= arg_84_1.time_ and arg_84_1.time_ < var_87_16 + var_87_19 then
				local var_87_20 = (arg_84_1.time_ - var_87_16) / var_87_19
				local var_87_21 = Vector3.New(0, -2000, 0)

				var_87_15.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10135, var_87_21, var_87_20)
			end

			if arg_84_1.time_ >= var_87_16 + var_87_19 and arg_84_1.time_ < var_87_16 + var_87_19 + arg_87_0 then
				var_87_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_87_22 = 0
			local var_87_23 = 0.5

			if var_87_22 < arg_84_1.time_ and arg_84_1.time_ <= var_87_22 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_24 = arg_84_1:GetWordFromCfg(418031021)
				local var_87_25 = arg_84_1:FormatText(var_87_24.content)

				arg_84_1.text_.text = var_87_25

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_26 = 20
				local var_87_27 = utf8.len(var_87_25)
				local var_87_28 = var_87_26 <= 0 and var_87_23 or var_87_23 * (var_87_27 / var_87_26)

				if var_87_28 > 0 and var_87_23 < var_87_28 then
					arg_84_1.talkMaxDuration = var_87_28

					if var_87_28 + var_87_22 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_28 + var_87_22
					end
				end

				arg_84_1.text_.text = var_87_25
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_29 = math.max(var_87_23, arg_84_1.talkMaxDuration)

			if var_87_22 <= arg_84_1.time_ and arg_84_1.time_ < var_87_22 + var_87_29 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_22) / var_87_29

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_22 + var_87_29 and arg_84_1.time_ < var_87_22 + var_87_29 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play418031022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 418031022
		arg_88_1.duration_ = 6.4

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play418031023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_1 = 1.4

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_1 then
				local var_91_2 = (arg_88_1.time_ - var_91_0) / var_91_1
				local var_91_3 = Color.New(0, 0, 0)

				var_91_3.a = Mathf.Lerp(0, 1, var_91_2)
				arg_88_1.mask_.color = var_91_3
			end

			if arg_88_1.time_ >= var_91_0 + var_91_1 and arg_88_1.time_ < var_91_0 + var_91_1 + arg_91_0 then
				local var_91_4 = Color.New(0, 0, 0)

				var_91_4.a = 1
				arg_88_1.mask_.color = var_91_4
			end

			local var_91_5 = 1.4

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_6 = 1.4

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6
				local var_91_8 = Color.New(0, 0, 0)

				var_91_8.a = Mathf.Lerp(1, 0, var_91_7)
				arg_88_1.mask_.color = var_91_8
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 then
				local var_91_9 = Color.New(0, 0, 0)
				local var_91_10 = 0

				arg_88_1.mask_.enabled = false
				var_91_9.a = var_91_10
				arg_88_1.mask_.color = var_91_9
			end

			local var_91_11 = 1.4

			if var_91_11 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.fswbg_:SetActive(true)
				arg_88_1.dialog_:SetActive(false)

				arg_88_1.fswtw_.percent = 0

				local var_91_12 = arg_88_1:GetWordFromCfg(418031022)
				local var_91_13 = arg_88_1:FormatText(var_91_12.content)

				arg_88_1.fswt_.text = var_91_13

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.fswt_)

				arg_88_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_88_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_88_1.fswtw_:SetDirty()

				arg_88_1.typewritterCharCountI18N = 0

				SetActive(arg_88_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_88_1:ShowNextGo(false)
			end

			local var_91_14 = 2.2

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1.var_.oldValueTypewriter = arg_88_1.fswtw_.percent

				SetActive(arg_88_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_88_1:ShowNextGo(false)
			end

			local var_91_15 = 5
			local var_91_16 = 0.333333333333333
			local var_91_17 = arg_88_1:GetWordFromCfg(418031022)
			local var_91_18 = arg_88_1:FormatText(var_91_17.content)
			local var_91_19, var_91_20 = arg_88_1:GetPercentByPara(var_91_18, 1)

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				local var_91_21 = var_91_15 <= 0 and var_91_16 or var_91_16 * ((var_91_20 - arg_88_1.typewritterCharCountI18N) / var_91_15)

				if var_91_21 > 0 and var_91_16 < var_91_21 then
					arg_88_1.talkMaxDuration = var_91_21

					if var_91_21 + var_91_14 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_21 + var_91_14
					end
				end
			end

			local var_91_22 = 0.333333333333333
			local var_91_23 = math.max(var_91_22, arg_88_1.talkMaxDuration)

			if var_91_14 <= arg_88_1.time_ and arg_88_1.time_ < var_91_14 + var_91_23 then
				local var_91_24 = (arg_88_1.time_ - var_91_14) / var_91_23

				arg_88_1.fswtw_.percent = Mathf.Lerp(arg_88_1.var_.oldValueTypewriter, var_91_19, var_91_24)
				arg_88_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_88_1.fswtw_:SetDirty()
			end

			if arg_88_1.time_ >= var_91_14 + var_91_23 and arg_88_1.time_ < var_91_14 + var_91_23 + arg_91_0 then
				arg_88_1.fswtw_.percent = var_91_19

				arg_88_1.fswtw_:SetDirty()
				arg_88_1:ShowNextGo(true)

				arg_88_1.typewritterCharCountI18N = var_91_20
			end

			local var_91_25 = 1.4

			if var_91_25 < arg_88_1.time_ and arg_88_1.time_ <= var_91_25 + arg_91_0 then
				local var_91_26 = arg_88_1.fswbg_.transform:Find("textbox/adapt/content") or arg_88_1.fswbg_.transform:Find("textbox/content")
				local var_91_27 = arg_88_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_91_28 = var_91_26:GetComponent("Text")
				local var_91_29 = var_91_26:GetComponent("RectTransform")

				var_91_28.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_91_29.offsetMin = Vector2.New(0, 0)
				var_91_29.offsetMax = Vector2.New(0, 0)
			end

			local var_91_30 = "STblack"

			if arg_88_1.bgs_[var_91_30] == nil then
				local var_91_31 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_31:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_91_30)
				var_91_31.name = var_91_30
				var_91_31.transform.parent = arg_88_1.stage_.transform
				var_91_31.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_[var_91_30] = var_91_31
			end

			local var_91_32 = 1.4

			if var_91_32 < arg_88_1.time_ and arg_88_1.time_ <= var_91_32 + arg_91_0 then
				local var_91_33 = manager.ui.mainCamera.transform.localPosition
				local var_91_34 = Vector3.New(0, 0, 10) + Vector3.New(var_91_33.x, var_91_33.y, 0)
				local var_91_35 = arg_88_1.bgs_.STblack

				var_91_35.transform.localPosition = var_91_34
				var_91_35.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_36 = var_91_35:GetComponent("SpriteRenderer")

				if var_91_36 and var_91_36.sprite then
					local var_91_37 = (var_91_35.transform.localPosition - var_91_33).z
					local var_91_38 = manager.ui.mainCameraCom_
					local var_91_39 = 2 * var_91_37 * Mathf.Tan(var_91_38.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_91_40 = var_91_39 * var_91_38.aspect
					local var_91_41 = var_91_36.sprite.bounds.size.x
					local var_91_42 = var_91_36.sprite.bounds.size.y
					local var_91_43 = var_91_40 / var_91_41
					local var_91_44 = var_91_39 / var_91_42
					local var_91_45 = var_91_44 < var_91_43 and var_91_43 or var_91_44

					var_91_35.transform.localScale = Vector3.New(var_91_45, var_91_45, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "STblack" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play418031023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 418031023
		arg_92_1.duration_ = 8.8

		local var_92_0 = {
			ja = 8.8,
			CriLanguages = 7.533,
			zh = 7.533
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
				arg_92_0:Play418031024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1073"]
			local var_95_1 = 2.93333333333333

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps1073 == nil then
				arg_92_1.var_.actorSpriteComps1073 = var_95_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.actorSpriteComps1073 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps1073 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_95_3 then
						if arg_92_1.isInRecall_ then
							iter_95_3.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_95_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps1073 = nil
			end

			local var_95_8 = arg_92_1.actors_["1073"].transform
			local var_95_9 = 2.93333333333333

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				arg_92_1.var_.moveOldPos1073 = var_95_8.localPosition
				var_95_8.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1073", 3)

				local var_95_10 = var_95_8.childCount

				for iter_95_4 = 0, var_95_10 - 1 do
					local var_95_11 = var_95_8:GetChild(iter_95_4)

					if var_95_11.name == "" or not string.find(var_95_11.name, "split") then
						var_95_11.gameObject:SetActive(true)
					else
						var_95_11.gameObject:SetActive(false)
					end
				end
			end

			local var_95_12 = 0.001

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_12 then
				local var_95_13 = (arg_92_1.time_ - var_95_9) / var_95_12
				local var_95_14 = Vector3.New(38.6, -414.5, -207.2)

				var_95_8.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1073, var_95_14, var_95_13)
			end

			if arg_92_1.time_ >= var_95_9 + var_95_12 and arg_92_1.time_ < var_95_9 + var_95_12 + arg_95_0 then
				var_95_8.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_95_15 = 0

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_16 = 1.4

			if var_95_15 <= arg_92_1.time_ and arg_92_1.time_ < var_95_15 + var_95_16 then
				local var_95_17 = (arg_92_1.time_ - var_95_15) / var_95_16
				local var_95_18 = Color.New(0, 0, 0)

				var_95_18.a = Mathf.Lerp(0, 1, var_95_17)
				arg_92_1.mask_.color = var_95_18
			end

			if arg_92_1.time_ >= var_95_15 + var_95_16 and arg_92_1.time_ < var_95_15 + var_95_16 + arg_95_0 then
				local var_95_19 = Color.New(0, 0, 0)

				var_95_19.a = 1
				arg_92_1.mask_.color = var_95_19
			end

			local var_95_20 = 1.4

			if var_95_20 < arg_92_1.time_ and arg_92_1.time_ <= var_95_20 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_21 = 1.9

			if var_95_20 <= arg_92_1.time_ and arg_92_1.time_ < var_95_20 + var_95_21 then
				local var_95_22 = (arg_92_1.time_ - var_95_20) / var_95_21
				local var_95_23 = Color.New(0, 0, 0)

				var_95_23.a = Mathf.Lerp(1, 0, var_95_22)
				arg_92_1.mask_.color = var_95_23
			end

			if arg_92_1.time_ >= var_95_20 + var_95_21 and arg_92_1.time_ < var_95_20 + var_95_21 + arg_95_0 then
				local var_95_24 = Color.New(0, 0, 0)
				local var_95_25 = 0

				arg_92_1.mask_.enabled = false
				var_95_24.a = var_95_25
				arg_92_1.mask_.color = var_95_24
			end

			local var_95_26 = 1.4

			if var_95_26 < arg_92_1.time_ and arg_92_1.time_ <= var_95_26 + arg_95_0 then
				arg_92_1.fswbg_:SetActive(false)
				arg_92_1.dialog_:SetActive(false)
				SetActive(arg_92_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_92_1:ShowNextGo(false)
			end

			local var_95_27 = 1.41666666666667

			if var_95_27 < arg_92_1.time_ and arg_92_1.time_ <= var_95_27 + arg_95_0 then
				arg_92_1.fswbg_:SetActive(false)
				arg_92_1.dialog_:SetActive(false)
				SetActive(arg_92_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_92_1:ShowNextGo(false)
			end

			local var_95_28 = 1.4

			if var_95_28 < arg_92_1.time_ and arg_92_1.time_ <= var_95_28 + arg_95_0 then
				local var_95_29 = manager.ui.mainCamera.transform.localPosition
				local var_95_30 = Vector3.New(0, 0, 10) + Vector3.New(var_95_29.x, var_95_29.y, 0)
				local var_95_31 = arg_92_1.bgs_.ST1001b

				var_95_31.transform.localPosition = var_95_30
				var_95_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_95_32 = var_95_31:GetComponent("SpriteRenderer")

				if var_95_32 and var_95_32.sprite then
					local var_95_33 = (var_95_31.transform.localPosition - var_95_29).z
					local var_95_34 = manager.ui.mainCameraCom_
					local var_95_35 = 2 * var_95_33 * Mathf.Tan(var_95_34.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_95_36 = var_95_35 * var_95_34.aspect
					local var_95_37 = var_95_32.sprite.bounds.size.x
					local var_95_38 = var_95_32.sprite.bounds.size.y
					local var_95_39 = var_95_36 / var_95_37
					local var_95_40 = var_95_35 / var_95_38
					local var_95_41 = var_95_40 < var_95_39 and var_95_39 or var_95_40

					var_95_31.transform.localScale = Vector3.New(var_95_41, var_95_41, 0)
				end

				for iter_95_5, iter_95_6 in pairs(arg_92_1.bgs_) do
					if iter_95_5 ~= "ST1001b" then
						iter_95_6.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_95_42 = 3.3
			local var_95_43 = 0.35

			if var_95_42 < arg_92_1.time_ and arg_92_1.time_ <= var_95_42 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_44 = arg_92_1:FormatText(StoryNameCfg[380].name)

				arg_92_1.leftNameTxt_.text = var_95_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_45 = arg_92_1:GetWordFromCfg(418031023)
				local var_95_46 = arg_92_1:FormatText(var_95_45.content)

				arg_92_1.text_.text = var_95_46

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_47 = 14
				local var_95_48 = utf8.len(var_95_46)
				local var_95_49 = var_95_47 <= 0 and var_95_43 or var_95_43 * (var_95_48 / var_95_47)

				if var_95_49 > 0 and var_95_43 < var_95_49 then
					arg_92_1.talkMaxDuration = var_95_49

					if var_95_49 + var_95_42 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_49 + var_95_42
					end
				end

				arg_92_1.text_.text = var_95_46
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031023", "story_v_side_old_418031.awb") ~= 0 then
					local var_95_50 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031023", "story_v_side_old_418031.awb") / 1000

					if var_95_50 + var_95_42 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_50 + var_95_42
					end

					if var_95_45.prefab_name ~= "" and arg_92_1.actors_[var_95_45.prefab_name] ~= nil then
						local var_95_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_45.prefab_name].transform, "story_v_side_old_418031", "418031023", "story_v_side_old_418031.awb")

						arg_92_1:RecordAudio("418031023", var_95_51)
						arg_92_1:RecordAudio("418031023", var_95_51)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031023", "story_v_side_old_418031.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031023", "story_v_side_old_418031.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_52 = math.max(var_95_43, arg_92_1.talkMaxDuration)

			if var_95_42 <= arg_92_1.time_ and arg_92_1.time_ < var_95_42 + var_95_52 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_42) / var_95_52

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_42 + var_95_52 and arg_92_1.time_ < var_95_42 + var_95_52 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.93333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play418031024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 418031024
		arg_96_1.duration_ = 3.7

		local var_96_0 = {
			ja = 3.7,
			CriLanguages = 2.666,
			zh = 2.666
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
				arg_96_0:Play418031025(arg_96_1)
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
								local var_99_4 = Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor2.r, var_99_3)
								local var_99_5 = Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor2.g, var_99_3)
								local var_99_6 = Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor2.b, var_99_3)

								iter_99_1.color = Color.New(var_99_4, var_99_5, var_99_6)
							else
								local var_99_7 = Mathf.Lerp(iter_99_1.color.r, 0.5, var_99_3)

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
							iter_99_3.color = arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_99_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps1073 = nil
			end

			local var_99_8 = 0
			local var_99_9 = 0.2

			if var_99_8 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_10 = arg_96_1:FormatText(StoryNameCfg[1188].name)

				arg_96_1.leftNameTxt_.text = var_99_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_11 = arg_96_1:GetWordFromCfg(418031024)
				local var_99_12 = arg_96_1:FormatText(var_99_11.content)

				arg_96_1.text_.text = var_99_12

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_13 = 8
				local var_99_14 = utf8.len(var_99_12)
				local var_99_15 = var_99_13 <= 0 and var_99_9 or var_99_9 * (var_99_14 / var_99_13)

				if var_99_15 > 0 and var_99_9 < var_99_15 then
					arg_96_1.talkMaxDuration = var_99_15

					if var_99_15 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_15 + var_99_8
					end
				end

				arg_96_1.text_.text = var_99_12
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031024", "story_v_side_old_418031.awb") ~= 0 then
					local var_99_16 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031024", "story_v_side_old_418031.awb") / 1000

					if var_99_16 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_16 + var_99_8
					end

					if var_99_11.prefab_name ~= "" and arg_96_1.actors_[var_99_11.prefab_name] ~= nil then
						local var_99_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_11.prefab_name].transform, "story_v_side_old_418031", "418031024", "story_v_side_old_418031.awb")

						arg_96_1:RecordAudio("418031024", var_99_17)
						arg_96_1:RecordAudio("418031024", var_99_17)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031024", "story_v_side_old_418031.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031024", "story_v_side_old_418031.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_18 = math.max(var_99_9, arg_96_1.talkMaxDuration)

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_18 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_8) / var_99_18

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_8 + var_99_18 and arg_96_1.time_ < var_99_8 + var_99_18 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play418031025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 418031025
		arg_100_1.duration_ = 8.97

		local var_100_0 = {
			ja = 8.966,
			CriLanguages = 7.966,
			zh = 7.966
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
				arg_100_0:Play418031026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1073"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps1073 == nil then
				arg_100_1.var_.actorSpriteComps1073 = var_103_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.actorSpriteComps1073 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								local var_103_4 = Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor1.r, var_103_3)
								local var_103_5 = Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor1.g, var_103_3)
								local var_103_6 = Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor1.b, var_103_3)

								iter_103_1.color = Color.New(var_103_4, var_103_5, var_103_6)
							else
								local var_103_7 = Mathf.Lerp(iter_103_1.color.r, 1, var_103_3)

								iter_103_1.color = Color.New(var_103_7, var_103_7, var_103_7)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps1073 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_103_3 then
						if arg_100_1.isInRecall_ then
							iter_103_3.color = arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_103_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps1073 = nil
			end

			local var_103_8 = 0
			local var_103_9 = 1.075

			if var_103_8 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_10 = arg_100_1:FormatText(StoryNameCfg[380].name)

				arg_100_1.leftNameTxt_.text = var_103_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_11 = arg_100_1:GetWordFromCfg(418031025)
				local var_103_12 = arg_100_1:FormatText(var_103_11.content)

				arg_100_1.text_.text = var_103_12

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 43
				local var_103_14 = utf8.len(var_103_12)
				local var_103_15 = var_103_13 <= 0 and var_103_9 or var_103_9 * (var_103_14 / var_103_13)

				if var_103_15 > 0 and var_103_9 < var_103_15 then
					arg_100_1.talkMaxDuration = var_103_15

					if var_103_15 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_15 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_12
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031025", "story_v_side_old_418031.awb") ~= 0 then
					local var_103_16 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031025", "story_v_side_old_418031.awb") / 1000

					if var_103_16 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_16 + var_103_8
					end

					if var_103_11.prefab_name ~= "" and arg_100_1.actors_[var_103_11.prefab_name] ~= nil then
						local var_103_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_11.prefab_name].transform, "story_v_side_old_418031", "418031025", "story_v_side_old_418031.awb")

						arg_100_1:RecordAudio("418031025", var_103_17)
						arg_100_1:RecordAudio("418031025", var_103_17)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031025", "story_v_side_old_418031.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031025", "story_v_side_old_418031.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_18 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_18 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_18

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_18 and arg_100_1.time_ < var_103_8 + var_103_18 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play418031026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 418031026
		arg_104_1.duration_ = 6.63

		local var_104_0 = {
			ja = 6.2,
			CriLanguages = 6.633,
			zh = 6.633
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
				arg_104_0:Play418031027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1073"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1073 = var_107_0.localPosition
				var_107_0.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1073", 3)

				local var_107_2 = var_107_0.childCount

				for iter_107_0 = 0, var_107_2 - 1 do
					local var_107_3 = var_107_0:GetChild(iter_107_0)

					if var_107_3.name == "" or not string.find(var_107_3.name, "split") then
						var_107_3.gameObject:SetActive(true)
					else
						var_107_3.gameObject:SetActive(false)
					end
				end
			end

			local var_107_4 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_4 then
				local var_107_5 = (arg_104_1.time_ - var_107_1) / var_107_4
				local var_107_6 = Vector3.New(38.6, -414.5, -207.2)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1073, var_107_6, var_107_5)
			end

			if arg_104_1.time_ >= var_107_1 + var_107_4 and arg_104_1.time_ < var_107_1 + var_107_4 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_107_7 = 0
			local var_107_8 = 0.8

			if var_107_7 < arg_104_1.time_ and arg_104_1.time_ <= var_107_7 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_9 = arg_104_1:FormatText(StoryNameCfg[380].name)

				arg_104_1.leftNameTxt_.text = var_107_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_10 = arg_104_1:GetWordFromCfg(418031026)
				local var_107_11 = arg_104_1:FormatText(var_107_10.content)

				arg_104_1.text_.text = var_107_11

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_12 = 32
				local var_107_13 = utf8.len(var_107_11)
				local var_107_14 = var_107_12 <= 0 and var_107_8 or var_107_8 * (var_107_13 / var_107_12)

				if var_107_14 > 0 and var_107_8 < var_107_14 then
					arg_104_1.talkMaxDuration = var_107_14

					if var_107_14 + var_107_7 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_7
					end
				end

				arg_104_1.text_.text = var_107_11
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031026", "story_v_side_old_418031.awb") ~= 0 then
					local var_107_15 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031026", "story_v_side_old_418031.awb") / 1000

					if var_107_15 + var_107_7 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_15 + var_107_7
					end

					if var_107_10.prefab_name ~= "" and arg_104_1.actors_[var_107_10.prefab_name] ~= nil then
						local var_107_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_10.prefab_name].transform, "story_v_side_old_418031", "418031026", "story_v_side_old_418031.awb")

						arg_104_1:RecordAudio("418031026", var_107_16)
						arg_104_1:RecordAudio("418031026", var_107_16)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031026", "story_v_side_old_418031.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031026", "story_v_side_old_418031.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_17 = math.max(var_107_8, arg_104_1.talkMaxDuration)

			if var_107_7 <= arg_104_1.time_ and arg_104_1.time_ < var_107_7 + var_107_17 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_7) / var_107_17

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_7 + var_107_17 and arg_104_1.time_ < var_107_7 + var_107_17 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play418031027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 418031027
		arg_108_1.duration_ = 9.53

		local var_108_0 = {
			ja = 8.7,
			CriLanguages = 9.533,
			zh = 9.533
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
				arg_108_0:Play418031028(arg_108_1)
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
								local var_111_4 = Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor2.r, var_111_3)
								local var_111_5 = Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor2.g, var_111_3)
								local var_111_6 = Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor2.b, var_111_3)

								iter_111_1.color = Color.New(var_111_4, var_111_5, var_111_6)
							else
								local var_111_7 = Mathf.Lerp(iter_111_1.color.r, 0.5, var_111_3)

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
							iter_111_3.color = arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_111_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1073 = nil
			end

			local var_111_8 = 0
			local var_111_9 = 0.825

			if var_111_8 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_10 = arg_108_1:FormatText(StoryNameCfg[1188].name)

				arg_108_1.leftNameTxt_.text = var_111_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_11 = arg_108_1:GetWordFromCfg(418031027)
				local var_111_12 = arg_108_1:FormatText(var_111_11.content)

				arg_108_1.text_.text = var_111_12

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 33
				local var_111_14 = utf8.len(var_111_12)
				local var_111_15 = var_111_13 <= 0 and var_111_9 or var_111_9 * (var_111_14 / var_111_13)

				if var_111_15 > 0 and var_111_9 < var_111_15 then
					arg_108_1.talkMaxDuration = var_111_15

					if var_111_15 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_15 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_12
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031027", "story_v_side_old_418031.awb") ~= 0 then
					local var_111_16 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031027", "story_v_side_old_418031.awb") / 1000

					if var_111_16 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_16 + var_111_8
					end

					if var_111_11.prefab_name ~= "" and arg_108_1.actors_[var_111_11.prefab_name] ~= nil then
						local var_111_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_11.prefab_name].transform, "story_v_side_old_418031", "418031027", "story_v_side_old_418031.awb")

						arg_108_1:RecordAudio("418031027", var_111_17)
						arg_108_1:RecordAudio("418031027", var_111_17)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031027", "story_v_side_old_418031.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031027", "story_v_side_old_418031.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_18 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_18 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_18

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_18 and arg_108_1.time_ < var_111_8 + var_111_18 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play418031028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 418031028
		arg_112_1.duration_ = 3.7

		local var_112_0 = {
			ja = 3.666,
			CriLanguages = 3.7,
			zh = 3.7
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
			arg_112_1.auto_ = false
		end

		function arg_112_1.playNext_(arg_114_0)
			arg_112_1.onStoryFinished_()
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10135"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps10135 == nil then
				arg_112_1.var_.actorSpriteComps10135 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps10135 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								local var_115_4 = Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, var_115_3)
								local var_115_5 = Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, var_115_3)
								local var_115_6 = Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, var_115_3)

								iter_115_1.color = Color.New(var_115_4, var_115_5, var_115_6)
							else
								local var_115_7 = Mathf.Lerp(iter_115_1.color.r, 1, var_115_3)

								iter_115_1.color = Color.New(var_115_7, var_115_7, var_115_7)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps10135 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps10135 = nil
			end

			local var_115_8 = arg_112_1.actors_["10135"].transform
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 then
				arg_112_1.var_.moveOldPos10135 = var_115_8.localPosition
				var_115_8.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10135", 3)

				local var_115_10 = var_115_8.childCount

				for iter_115_4 = 0, var_115_10 - 1 do
					local var_115_11 = var_115_8:GetChild(iter_115_4)

					if var_115_11.name == "split_2" or not string.find(var_115_11.name, "split") then
						var_115_11.gameObject:SetActive(true)
					else
						var_115_11.gameObject:SetActive(false)
					end
				end
			end

			local var_115_12 = 0.001

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_12 then
				local var_115_13 = (arg_112_1.time_ - var_115_9) / var_115_12
				local var_115_14 = Vector3.New(-12.7, -363.6, -305.9)

				var_115_8.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10135, var_115_14, var_115_13)
			end

			if arg_112_1.time_ >= var_115_9 + var_115_12 and arg_112_1.time_ < var_115_9 + var_115_12 + arg_115_0 then
				var_115_8.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_115_15 = arg_112_1.actors_["1073"].transform
			local var_115_16 = 0

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 then
				arg_112_1.var_.moveOldPos1073 = var_115_15.localPosition
				var_115_15.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("1073", 7)

				local var_115_17 = var_115_15.childCount

				for iter_115_5 = 0, var_115_17 - 1 do
					local var_115_18 = var_115_15:GetChild(iter_115_5)

					if var_115_18.name == "" or not string.find(var_115_18.name, "split") then
						var_115_18.gameObject:SetActive(true)
					else
						var_115_18.gameObject:SetActive(false)
					end
				end
			end

			local var_115_19 = 0.001

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_19 then
				local var_115_20 = (arg_112_1.time_ - var_115_16) / var_115_19
				local var_115_21 = Vector3.New(0, -2000, 0)

				var_115_15.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1073, var_115_21, var_115_20)
			end

			if arg_112_1.time_ >= var_115_16 + var_115_19 and arg_112_1.time_ < var_115_16 + var_115_19 + arg_115_0 then
				var_115_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_115_22 = 0
			local var_115_23 = 0.325

			if var_115_22 < arg_112_1.time_ and arg_112_1.time_ <= var_115_22 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_24 = arg_112_1:FormatText(StoryNameCfg[1187].name)

				arg_112_1.leftNameTxt_.text = var_115_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_25 = arg_112_1:GetWordFromCfg(418031028)
				local var_115_26 = arg_112_1:FormatText(var_115_25.content)

				arg_112_1.text_.text = var_115_26

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_27 = 13
				local var_115_28 = utf8.len(var_115_26)
				local var_115_29 = var_115_27 <= 0 and var_115_23 or var_115_23 * (var_115_28 / var_115_27)

				if var_115_29 > 0 and var_115_23 < var_115_29 then
					arg_112_1.talkMaxDuration = var_115_29

					if var_115_29 + var_115_22 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_29 + var_115_22
					end
				end

				arg_112_1.text_.text = var_115_26
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418031", "418031028", "story_v_side_old_418031.awb") ~= 0 then
					local var_115_30 = manager.audio:GetVoiceLength("story_v_side_old_418031", "418031028", "story_v_side_old_418031.awb") / 1000

					if var_115_30 + var_115_22 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_30 + var_115_22
					end

					if var_115_25.prefab_name ~= "" and arg_112_1.actors_[var_115_25.prefab_name] ~= nil then
						local var_115_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_25.prefab_name].transform, "story_v_side_old_418031", "418031028", "story_v_side_old_418031.awb")

						arg_112_1:RecordAudio("418031028", var_115_31)
						arg_112_1:RecordAudio("418031028", var_115_31)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_old_418031", "418031028", "story_v_side_old_418031.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_old_418031", "418031028", "story_v_side_old_418031.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_32 = math.max(var_115_23, arg_112_1.talkMaxDuration)

			if var_115_22 <= arg_112_1.time_ and arg_112_1.time_ < var_115_22 + var_115_32 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_22) / var_115_32

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_22 + var_115_32 and arg_112_1.time_ < var_115_22 + var_115_32 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST1001b",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_side_old_418031.awb"
	}
}
