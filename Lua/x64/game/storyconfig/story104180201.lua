return {
	Play418021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418021001
		arg_1_1.duration_ = 13.57

		local var_1_0 = {
			ja = 13.565999999999,
			CriLanguages = 8.165999999999,
			zh = 8.165999999999
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
				arg_1_0:Play418021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST1002"

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
				local var_4_5 = arg_1_1.bgs_.ST1002

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
					if iter_4_0 ~= "ST1002" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.0166666666666667

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

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_140", "se_story_140_amb_square", "")
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

			local var_4_34 = 1.999999999999
			local var_4_35 = 0.575

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

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[672].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(418021001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 23
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

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021001", "story_v_side_old_418021.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021001", "story_v_side_old_418021.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_side_old_418021", "418021001", "story_v_side_old_418021.awb")

						arg_1_1:RecordAudio("418021001", var_4_44)
						arg_1_1:RecordAudio("418021001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021001", "story_v_side_old_418021.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021001", "story_v_side_old_418021.awb")
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
	Play418021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418021002
		arg_8_1.duration_ = 6.5

		local var_8_0 = {
			ja = 6.5,
			CriLanguages = 6.233,
			zh = 6.233
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
				arg_8_0:Play418021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1073"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1073")

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

			local var_11_4 = arg_8_1.actors_["1073"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps1073 == nil then
				arg_8_1.var_.actorSpriteComps1073 = var_11_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.actorSpriteComps1073 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps1073 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_11_5 then
						if arg_8_1.isInRecall_ then
							iter_11_5.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_11_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps1073 = nil
			end

			local var_11_12 = arg_8_1.actors_["1073"].transform
			local var_11_13 = 0

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 then
				arg_8_1.var_.moveOldPos1073 = var_11_12.localPosition
				var_11_12.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("1073", 3)

				local var_11_14 = var_11_12.childCount

				for iter_11_6 = 0, var_11_14 - 1 do
					local var_11_15 = var_11_12:GetChild(iter_11_6)

					if var_11_15.name == "" or not string.find(var_11_15.name, "split") then
						var_11_15.gameObject:SetActive(true)
					else
						var_11_15.gameObject:SetActive(false)
					end
				end
			end

			local var_11_16 = 0.001

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_16 then
				local var_11_17 = (arg_8_1.time_ - var_11_13) / var_11_16
				local var_11_18 = Vector3.New(38.6, -414.5, -207.2)

				var_11_12.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1073, var_11_18, var_11_17)
			end

			if arg_8_1.time_ >= var_11_13 + var_11_16 and arg_8_1.time_ < var_11_13 + var_11_16 + arg_11_0 then
				var_11_12.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_11_19 = 0
			local var_11_20 = 0.65

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_21 = arg_8_1:FormatText(StoryNameCfg[380].name)

				arg_8_1.leftNameTxt_.text = var_11_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_22 = arg_8_1:GetWordFromCfg(418021002)
				local var_11_23 = arg_8_1:FormatText(var_11_22.content)

				arg_8_1.text_.text = var_11_23

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_24 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021002", "story_v_side_old_418021.awb") ~= 0 then
					local var_11_27 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021002", "story_v_side_old_418021.awb") / 1000

					if var_11_27 + var_11_19 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_27 + var_11_19
					end

					if var_11_22.prefab_name ~= "" and arg_8_1.actors_[var_11_22.prefab_name] ~= nil then
						local var_11_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_22.prefab_name].transform, "story_v_side_old_418021", "418021002", "story_v_side_old_418021.awb")

						arg_8_1:RecordAudio("418021002", var_11_28)
						arg_8_1:RecordAudio("418021002", var_11_28)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021002", "story_v_side_old_418021.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021002", "story_v_side_old_418021.awb")
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
				actorName = "1073",
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
	Play418021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418021003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play418021004(arg_12_1)
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

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps1073 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_15_3 then
						if arg_12_1.isInRecall_ then
							iter_15_3.color = arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_15_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps1073 = nil
			end

			local var_15_8 = arg_12_1.actors_["1073"].transform
			local var_15_9 = 0

			if var_15_9 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1.var_.moveOldPos1073 = var_15_8.localPosition
				var_15_8.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("1073", 7)

				local var_15_10 = var_15_8.childCount

				for iter_15_4 = 0, var_15_10 - 1 do
					local var_15_11 = var_15_8:GetChild(iter_15_4)

					if var_15_11.name == "" or not string.find(var_15_11.name, "split") then
						var_15_11.gameObject:SetActive(true)
					else
						var_15_11.gameObject:SetActive(false)
					end
				end
			end

			local var_15_12 = 0.001

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_12 then
				local var_15_13 = (arg_12_1.time_ - var_15_9) / var_15_12
				local var_15_14 = Vector3.New(0, -2000, 0)

				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1073, var_15_14, var_15_13)
			end

			if arg_12_1.time_ >= var_15_9 + var_15_12 and arg_12_1.time_ < var_15_9 + var_15_12 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_15 = 0
			local var_15_16 = 1.025

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_17 = arg_12_1:GetWordFromCfg(418021003)
				local var_15_18 = arg_12_1:FormatText(var_15_17.content)

				arg_12_1.text_.text = var_15_18

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_19 = 41
				local var_15_20 = utf8.len(var_15_18)
				local var_15_21 = var_15_19 <= 0 and var_15_16 or var_15_16 * (var_15_20 / var_15_19)

				if var_15_21 > 0 and var_15_16 < var_15_21 then
					arg_12_1.talkMaxDuration = var_15_21

					if var_15_21 + var_15_15 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_21 + var_15_15
					end
				end

				arg_12_1.text_.text = var_15_18
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_22 = math.max(var_15_16, arg_12_1.talkMaxDuration)

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_22 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_15) / var_15_22

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_15 + var_15_22 and arg_12_1.time_ < var_15_15 + var_15_22 + arg_15_0 then
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
	Play418021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418021004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play418021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.35

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(418021004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 54
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play418021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418021005
		arg_20_1.duration_ = 7.47

		local var_20_0 = {
			ja = 7.466,
			CriLanguages = 4.966,
			zh = 4.966
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
				arg_20_0:Play418021006(arg_20_1)
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

			local var_23_8 = arg_20_1.actors_["1073"].transform
			local var_23_9 = 0

			if var_23_9 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 then
				arg_20_1.var_.moveOldPos1073 = var_23_8.localPosition
				var_23_8.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("1073", 3)

				local var_23_10 = var_23_8.childCount

				for iter_23_4 = 0, var_23_10 - 1 do
					local var_23_11 = var_23_8:GetChild(iter_23_4)

					if var_23_11.name == "" or not string.find(var_23_11.name, "split") then
						var_23_11.gameObject:SetActive(true)
					else
						var_23_11.gameObject:SetActive(false)
					end
				end
			end

			local var_23_12 = 0.001

			if var_23_9 <= arg_20_1.time_ and arg_20_1.time_ < var_23_9 + var_23_12 then
				local var_23_13 = (arg_20_1.time_ - var_23_9) / var_23_12
				local var_23_14 = Vector3.New(38.6, -414.5, -207.2)

				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1073, var_23_14, var_23_13)
			end

			if arg_20_1.time_ >= var_23_9 + var_23_12 and arg_20_1.time_ < var_23_9 + var_23_12 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_23_15 = 0
			local var_23_16 = 0.5

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_17 = arg_20_1:FormatText(StoryNameCfg[380].name)

				arg_20_1.leftNameTxt_.text = var_23_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(418021005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_20 = 20
				local var_23_21 = utf8.len(var_23_19)
				local var_23_22 = var_23_20 <= 0 and var_23_16 or var_23_16 * (var_23_21 / var_23_20)

				if var_23_22 > 0 and var_23_16 < var_23_22 then
					arg_20_1.talkMaxDuration = var_23_22

					if var_23_22 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021005", "story_v_side_old_418021.awb") ~= 0 then
					local var_23_23 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021005", "story_v_side_old_418021.awb") / 1000

					if var_23_23 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_15
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_side_old_418021", "418021005", "story_v_side_old_418021.awb")

						arg_20_1:RecordAudio("418021005", var_23_24)
						arg_20_1:RecordAudio("418021005", var_23_24)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021005", "story_v_side_old_418021.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021005", "story_v_side_old_418021.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_25 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_25 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_15) / var_23_25

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_15 + var_23_25 and arg_20_1.time_ < var_23_15 + var_23_25 + arg_23_0 then
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
	Play418021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418021006
		arg_24_1.duration_ = 12.2

		local var_24_0 = {
			ja = 12.2,
			CriLanguages = 6.866,
			zh = 6.866
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
				arg_24_0:Play418021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1075"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1075")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(var_27_1, arg_24_1.canvasGo_.transform)

					var_27_2.transform:SetSiblingIndex(1)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_24_1.isInRecall_ then
						for iter_27_0, iter_27_1 in ipairs(var_27_3) do
							iter_27_1.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_27_4 = arg_24_1.actors_["1075"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.actorSpriteComps1075 == nil then
				arg_24_1.var_.actorSpriteComps1075 = var_27_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_6 = 0.2

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.actorSpriteComps1075 then
					for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps1075:ToTable()) do
						if iter_27_3 then
							if arg_24_1.isInRecall_ then
								local var_27_8 = Mathf.Lerp(iter_27_3.color.r, arg_24_1.hightColor1.r, var_27_7)
								local var_27_9 = Mathf.Lerp(iter_27_3.color.g, arg_24_1.hightColor1.g, var_27_7)
								local var_27_10 = Mathf.Lerp(iter_27_3.color.b, arg_24_1.hightColor1.b, var_27_7)

								iter_27_3.color = Color.New(var_27_8, var_27_9, var_27_10)
							else
								local var_27_11 = Mathf.Lerp(iter_27_3.color.r, 1, var_27_7)

								iter_27_3.color = Color.New(var_27_11, var_27_11, var_27_11)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.actorSpriteComps1075 then
				for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_27_5 then
						if arg_24_1.isInRecall_ then
							iter_27_5.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_27_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps1075 = nil
			end

			local var_27_12 = arg_24_1.actors_["1073"]
			local var_27_13 = 0

			if var_27_13 < arg_24_1.time_ and arg_24_1.time_ <= var_27_13 + arg_27_0 and not isNil(var_27_12) and arg_24_1.var_.actorSpriteComps1073 == nil then
				arg_24_1.var_.actorSpriteComps1073 = var_27_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_14 = 0.2

			if var_27_13 <= arg_24_1.time_ and arg_24_1.time_ < var_27_13 + var_27_14 and not isNil(var_27_12) then
				local var_27_15 = (arg_24_1.time_ - var_27_13) / var_27_14

				if arg_24_1.var_.actorSpriteComps1073 then
					for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_27_7 then
							if arg_24_1.isInRecall_ then
								local var_27_16 = Mathf.Lerp(iter_27_7.color.r, arg_24_1.hightColor2.r, var_27_15)
								local var_27_17 = Mathf.Lerp(iter_27_7.color.g, arg_24_1.hightColor2.g, var_27_15)
								local var_27_18 = Mathf.Lerp(iter_27_7.color.b, arg_24_1.hightColor2.b, var_27_15)

								iter_27_7.color = Color.New(var_27_16, var_27_17, var_27_18)
							else
								local var_27_19 = Mathf.Lerp(iter_27_7.color.r, 0.5, var_27_15)

								iter_27_7.color = Color.New(var_27_19, var_27_19, var_27_19)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_13 + var_27_14 and arg_24_1.time_ < var_27_13 + var_27_14 + arg_27_0 and not isNil(var_27_12) and arg_24_1.var_.actorSpriteComps1073 then
				for iter_27_8, iter_27_9 in pairs(arg_24_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_27_9 then
						if arg_24_1.isInRecall_ then
							iter_27_9.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps1073 = nil
			end

			local var_27_20 = 0
			local var_27_21 = 0.85

			if var_27_20 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_22 = arg_24_1:FormatText(StoryNameCfg[410].name)

				arg_24_1.leftNameTxt_.text = var_27_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074_split_1")

				arg_24_1.callingController_:SetSelectedState("calling")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_23 = arg_24_1:GetWordFromCfg(418021006)
				local var_27_24 = arg_24_1:FormatText(var_27_23.content)

				arg_24_1.text_.text = var_27_24

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_25 = 34
				local var_27_26 = utf8.len(var_27_24)
				local var_27_27 = var_27_25 <= 0 and var_27_21 or var_27_21 * (var_27_26 / var_27_25)

				if var_27_27 > 0 and var_27_21 < var_27_27 then
					arg_24_1.talkMaxDuration = var_27_27

					if var_27_27 + var_27_20 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_27 + var_27_20
					end
				end

				arg_24_1.text_.text = var_27_24
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021006", "story_v_side_old_418021.awb") ~= 0 then
					local var_27_28 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021006", "story_v_side_old_418021.awb") / 1000

					if var_27_28 + var_27_20 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_28 + var_27_20
					end

					if var_27_23.prefab_name ~= "" and arg_24_1.actors_[var_27_23.prefab_name] ~= nil then
						local var_27_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_23.prefab_name].transform, "story_v_side_old_418021", "418021006", "story_v_side_old_418021.awb")

						arg_24_1:RecordAudio("418021006", var_27_29)
						arg_24_1:RecordAudio("418021006", var_27_29)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021006", "story_v_side_old_418021.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021006", "story_v_side_old_418021.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_30 = math.max(var_27_21, arg_24_1.talkMaxDuration)

			if var_27_20 <= arg_24_1.time_ and arg_24_1.time_ < var_27_20 + var_27_30 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_20) / var_27_30

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_20 + var_27_30 and arg_24_1.time_ < var_27_20 + var_27_30 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play418021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 418021007
		arg_28_1.duration_ = 10

		local var_28_0 = {
			ja = 10,
			CriLanguages = 8.4,
			zh = 8.4
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
				arg_28_0:Play418021008(arg_28_1)
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

			local var_31_8 = arg_28_1.actors_["1075"]
			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.actorSpriteComps1075 == nil then
				arg_28_1.var_.actorSpriteComps1075 = var_31_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_10 = 0.2

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 and not isNil(var_31_8) then
				local var_31_11 = (arg_28_1.time_ - var_31_9) / var_31_10

				if arg_28_1.var_.actorSpriteComps1075 then
					for iter_31_4, iter_31_5 in pairs(arg_28_1.var_.actorSpriteComps1075:ToTable()) do
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

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.actorSpriteComps1075 then
				for iter_31_6, iter_31_7 in pairs(arg_28_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_31_7 then
						if arg_28_1.isInRecall_ then
							iter_31_7.color = arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_31_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps1075 = nil
			end

			local var_31_16 = arg_28_1.actors_["1073"].transform
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				arg_28_1.var_.moveOldPos1073 = var_31_16.localPosition
				var_31_16.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("1073", 3)

				local var_31_18 = var_31_16.childCount

				for iter_31_8 = 0, var_31_18 - 1 do
					local var_31_19 = var_31_16:GetChild(iter_31_8)

					if var_31_19.name == "split_5" or not string.find(var_31_19.name, "split") then
						var_31_19.gameObject:SetActive(true)
					else
						var_31_19.gameObject:SetActive(false)
					end
				end
			end

			local var_31_20 = 0.001

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_20 then
				local var_31_21 = (arg_28_1.time_ - var_31_17) / var_31_20
				local var_31_22 = Vector3.New(38.6, -414.5, -207.2)

				var_31_16.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1073, var_31_22, var_31_21)
			end

			if arg_28_1.time_ >= var_31_17 + var_31_20 and arg_28_1.time_ < var_31_17 + var_31_20 + arg_31_0 then
				var_31_16.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_31_23 = 0
			local var_31_24 = 0.9

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

				local var_31_26 = arg_28_1:GetWordFromCfg(418021007)
				local var_31_27 = arg_28_1:FormatText(var_31_26.content)

				arg_28_1.text_.text = var_31_27

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_28 = 36
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

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021007", "story_v_side_old_418021.awb") ~= 0 then
					local var_31_31 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021007", "story_v_side_old_418021.awb") / 1000

					if var_31_31 + var_31_23 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_31 + var_31_23
					end

					if var_31_26.prefab_name ~= "" and arg_28_1.actors_[var_31_26.prefab_name] ~= nil then
						local var_31_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_26.prefab_name].transform, "story_v_side_old_418021", "418021007", "story_v_side_old_418021.awb")

						arg_28_1:RecordAudio("418021007", var_31_32)
						arg_28_1:RecordAudio("418021007", var_31_32)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021007", "story_v_side_old_418021.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021007", "story_v_side_old_418021.awb")
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
	Play418021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 418021008
		arg_32_1.duration_ = 6.63

		local var_32_0 = {
			ja = 6,
			CriLanguages = 6.633,
			zh = 6.633
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
				arg_32_0:Play418021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1075"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps1075 == nil then
				arg_32_1.var_.actorSpriteComps1075 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps1075 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps1075:ToTable()) do
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

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps1075 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_35_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps1075 = nil
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

			local var_35_16 = 0
			local var_35_17 = 0.7

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_18 = arg_32_1:FormatText(StoryNameCfg[410].name)

				arg_32_1.leftNameTxt_.text = var_35_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074_split_1")

				arg_32_1.callingController_:SetSelectedState("calling")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_19 = arg_32_1:GetWordFromCfg(418021008)
				local var_35_20 = arg_32_1:FormatText(var_35_19.content)

				arg_32_1.text_.text = var_35_20

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_21 = 28
				local var_35_22 = utf8.len(var_35_20)
				local var_35_23 = var_35_21 <= 0 and var_35_17 or var_35_17 * (var_35_22 / var_35_21)

				if var_35_23 > 0 and var_35_17 < var_35_23 then
					arg_32_1.talkMaxDuration = var_35_23

					if var_35_23 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_16
					end
				end

				arg_32_1.text_.text = var_35_20
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021008", "story_v_side_old_418021.awb") ~= 0 then
					local var_35_24 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021008", "story_v_side_old_418021.awb") / 1000

					if var_35_24 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_24 + var_35_16
					end

					if var_35_19.prefab_name ~= "" and arg_32_1.actors_[var_35_19.prefab_name] ~= nil then
						local var_35_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_19.prefab_name].transform, "story_v_side_old_418021", "418021008", "story_v_side_old_418021.awb")

						arg_32_1:RecordAudio("418021008", var_35_25)
						arg_32_1:RecordAudio("418021008", var_35_25)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021008", "story_v_side_old_418021.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021008", "story_v_side_old_418021.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_26 = math.max(var_35_17, arg_32_1.talkMaxDuration)

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_26 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_16) / var_35_26

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_16 + var_35_26 and arg_32_1.time_ < var_35_16 + var_35_26 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play418021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 418021009
		arg_36_1.duration_ = 5.73

		local var_36_0 = {
			ja = 5.733,
			CriLanguages = 3.9,
			zh = 3.9
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
				arg_36_0:Play418021010(arg_36_1)
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

			local var_39_8 = arg_36_1.actors_["1075"]
			local var_39_9 = 0

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps1075 == nil then
				arg_36_1.var_.actorSpriteComps1075 = var_39_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_10 = 0.2

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_10 and not isNil(var_39_8) then
				local var_39_11 = (arg_36_1.time_ - var_39_9) / var_39_10

				if arg_36_1.var_.actorSpriteComps1075 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps1075:ToTable()) do
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

			if arg_36_1.time_ >= var_39_9 + var_39_10 and arg_36_1.time_ < var_39_9 + var_39_10 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps1075 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_39_7 then
						if arg_36_1.isInRecall_ then
							iter_39_7.color = arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_39_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps1075 = nil
			end

			local var_39_16 = arg_36_1.actors_["1073"].transform
			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.var_.moveOldPos1073 = var_39_16.localPosition
				var_39_16.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("1073", 3)

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
				local var_39_22 = Vector3.New(38.6, -414.5, -207.2)

				var_39_16.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1073, var_39_22, var_39_21)
			end

			if arg_36_1.time_ >= var_39_17 + var_39_20 and arg_36_1.time_ < var_39_17 + var_39_20 + arg_39_0 then
				var_39_16.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_39_23 = 0
			local var_39_24 = 0.4

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

				local var_39_26 = arg_36_1:GetWordFromCfg(418021009)
				local var_39_27 = arg_36_1:FormatText(var_39_26.content)

				arg_36_1.text_.text = var_39_27

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_28 = 16
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

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021009", "story_v_side_old_418021.awb") ~= 0 then
					local var_39_31 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021009", "story_v_side_old_418021.awb") / 1000

					if var_39_31 + var_39_23 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_31 + var_39_23
					end

					if var_39_26.prefab_name ~= "" and arg_36_1.actors_[var_39_26.prefab_name] ~= nil then
						local var_39_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_26.prefab_name].transform, "story_v_side_old_418021", "418021009", "story_v_side_old_418021.awb")

						arg_36_1:RecordAudio("418021009", var_39_32)
						arg_36_1:RecordAudio("418021009", var_39_32)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021009", "story_v_side_old_418021.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021009", "story_v_side_old_418021.awb")
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
	Play418021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 418021010
		arg_40_1.duration_ = 6.87

		local var_40_0 = {
			ja = 6.866,
			CriLanguages = 4.766,
			zh = 4.766
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
				arg_40_0:Play418021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1075"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps1075 == nil then
				arg_40_1.var_.actorSpriteComps1075 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps1075 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps1075:ToTable()) do
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

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps1075 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps1075 = nil
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

			local var_43_16 = 0
			local var_43_17 = 0.4

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_18 = arg_40_1:FormatText(StoryNameCfg[410].name)

				arg_40_1.leftNameTxt_.text = var_43_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074_split_1")

				arg_40_1.callingController_:SetSelectedState("calling")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_19 = arg_40_1:GetWordFromCfg(418021010)
				local var_43_20 = arg_40_1:FormatText(var_43_19.content)

				arg_40_1.text_.text = var_43_20

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_21 = 16
				local var_43_22 = utf8.len(var_43_20)
				local var_43_23 = var_43_21 <= 0 and var_43_17 or var_43_17 * (var_43_22 / var_43_21)

				if var_43_23 > 0 and var_43_17 < var_43_23 then
					arg_40_1.talkMaxDuration = var_43_23

					if var_43_23 + var_43_16 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_16
					end
				end

				arg_40_1.text_.text = var_43_20
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021010", "story_v_side_old_418021.awb") ~= 0 then
					local var_43_24 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021010", "story_v_side_old_418021.awb") / 1000

					if var_43_24 + var_43_16 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_24 + var_43_16
					end

					if var_43_19.prefab_name ~= "" and arg_40_1.actors_[var_43_19.prefab_name] ~= nil then
						local var_43_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_19.prefab_name].transform, "story_v_side_old_418021", "418021010", "story_v_side_old_418021.awb")

						arg_40_1:RecordAudio("418021010", var_43_25)
						arg_40_1:RecordAudio("418021010", var_43_25)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021010", "story_v_side_old_418021.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021010", "story_v_side_old_418021.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_26 = math.max(var_43_17, arg_40_1.talkMaxDuration)

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_26 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_16) / var_43_26

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_16 + var_43_26 and arg_40_1.time_ < var_43_16 + var_43_26 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play418021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 418021011
		arg_44_1.duration_ = 6.13

		local var_44_0 = {
			ja = 5.9,
			CriLanguages = 6.133,
			zh = 6.133
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
				arg_44_0:Play418021012(arg_44_1)
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

			local var_47_8 = arg_44_1.actors_["1075"]
			local var_47_9 = 0

			if var_47_9 < arg_44_1.time_ and arg_44_1.time_ <= var_47_9 + arg_47_0 and not isNil(var_47_8) and arg_44_1.var_.actorSpriteComps1075 == nil then
				arg_44_1.var_.actorSpriteComps1075 = var_47_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_10 = 0.2

			if var_47_9 <= arg_44_1.time_ and arg_44_1.time_ < var_47_9 + var_47_10 and not isNil(var_47_8) then
				local var_47_11 = (arg_44_1.time_ - var_47_9) / var_47_10

				if arg_44_1.var_.actorSpriteComps1075 then
					for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps1075:ToTable()) do
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

			if arg_44_1.time_ >= var_47_9 + var_47_10 and arg_44_1.time_ < var_47_9 + var_47_10 + arg_47_0 and not isNil(var_47_8) and arg_44_1.var_.actorSpriteComps1075 then
				for iter_47_6, iter_47_7 in pairs(arg_44_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_47_7 then
						if arg_44_1.isInRecall_ then
							iter_47_7.color = arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_47_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps1075 = nil
			end

			local var_47_16 = 0
			local var_47_17 = 0.675

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

				local var_47_19 = arg_44_1:GetWordFromCfg(418021011)
				local var_47_20 = arg_44_1:FormatText(var_47_19.content)

				arg_44_1.text_.text = var_47_20

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_21 = 27
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

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021011", "story_v_side_old_418021.awb") ~= 0 then
					local var_47_24 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021011", "story_v_side_old_418021.awb") / 1000

					if var_47_24 + var_47_16 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_24 + var_47_16
					end

					if var_47_19.prefab_name ~= "" and arg_44_1.actors_[var_47_19.prefab_name] ~= nil then
						local var_47_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_19.prefab_name].transform, "story_v_side_old_418021", "418021011", "story_v_side_old_418021.awb")

						arg_44_1:RecordAudio("418021011", var_47_25)
						arg_44_1:RecordAudio("418021011", var_47_25)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021011", "story_v_side_old_418021.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021011", "story_v_side_old_418021.awb")
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
	Play418021012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 418021012
		arg_48_1.duration_ = 3.1

		local var_48_0 = {
			ja = 3.1,
			CriLanguages = 2.1,
			zh = 2.1
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
				arg_48_0:Play418021013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1073"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1073 = var_51_0.localPosition
				var_51_0.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("1073", 3)

				local var_51_2 = var_51_0.childCount

				for iter_51_0 = 0, var_51_2 - 1 do
					local var_51_3 = var_51_0:GetChild(iter_51_0)

					if var_51_3.name == "split_1" or not string.find(var_51_3.name, "split") then
						var_51_3.gameObject:SetActive(true)
					else
						var_51_3.gameObject:SetActive(false)
					end
				end
			end

			local var_51_4 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_4 then
				local var_51_5 = (arg_48_1.time_ - var_51_1) / var_51_4
				local var_51_6 = Vector3.New(38.6, -414.5, -207.2)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1073, var_51_6, var_51_5)
			end

			if arg_48_1.time_ >= var_51_1 + var_51_4 and arg_48_1.time_ < var_51_1 + var_51_4 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_51_7 = 0
			local var_51_8 = 0.15

			if var_51_7 < arg_48_1.time_ and arg_48_1.time_ <= var_51_7 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_9 = arg_48_1:FormatText(StoryNameCfg[380].name)

				arg_48_1.leftNameTxt_.text = var_51_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_10 = arg_48_1:GetWordFromCfg(418021012)
				local var_51_11 = arg_48_1:FormatText(var_51_10.content)

				arg_48_1.text_.text = var_51_11

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_12 = 6
				local var_51_13 = utf8.len(var_51_11)
				local var_51_14 = var_51_12 <= 0 and var_51_8 or var_51_8 * (var_51_13 / var_51_12)

				if var_51_14 > 0 and var_51_8 < var_51_14 then
					arg_48_1.talkMaxDuration = var_51_14

					if var_51_14 + var_51_7 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_7
					end
				end

				arg_48_1.text_.text = var_51_11
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021012", "story_v_side_old_418021.awb") ~= 0 then
					local var_51_15 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021012", "story_v_side_old_418021.awb") / 1000

					if var_51_15 + var_51_7 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_15 + var_51_7
					end

					if var_51_10.prefab_name ~= "" and arg_48_1.actors_[var_51_10.prefab_name] ~= nil then
						local var_51_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_10.prefab_name].transform, "story_v_side_old_418021", "418021012", "story_v_side_old_418021.awb")

						arg_48_1:RecordAudio("418021012", var_51_16)
						arg_48_1:RecordAudio("418021012", var_51_16)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021012", "story_v_side_old_418021.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021012", "story_v_side_old_418021.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_17 = math.max(var_51_8, arg_48_1.talkMaxDuration)

			if var_51_7 <= arg_48_1.time_ and arg_48_1.time_ < var_51_7 + var_51_17 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_7) / var_51_17

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_7 + var_51_17 and arg_48_1.time_ < var_51_7 + var_51_17 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play418021013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 418021013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play418021014(arg_52_1)
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

			local var_55_8 = arg_52_1.actors_["1073"].transform
			local var_55_9 = 0

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 then
				arg_52_1.var_.moveOldPos1073 = var_55_8.localPosition
				var_55_8.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("1073", 7)

				local var_55_10 = var_55_8.childCount

				for iter_55_4 = 0, var_55_10 - 1 do
					local var_55_11 = var_55_8:GetChild(iter_55_4)

					if var_55_11.name == "" or not string.find(var_55_11.name, "split") then
						var_55_11.gameObject:SetActive(true)
					else
						var_55_11.gameObject:SetActive(false)
					end
				end
			end

			local var_55_12 = 0.001

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_12 then
				local var_55_13 = (arg_52_1.time_ - var_55_9) / var_55_12
				local var_55_14 = Vector3.New(0, -2000, 0)

				var_55_8.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1073, var_55_14, var_55_13)
			end

			if arg_52_1.time_ >= var_55_9 + var_55_12 and arg_52_1.time_ < var_55_9 + var_55_12 + arg_55_0 then
				var_55_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_55_15 = 0.05
			local var_55_16 = 1

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				local var_55_17 = "play"
				local var_55_18 = "effect"

				arg_52_1:AudioAction(var_55_17, var_55_18, "se_story_1310", "se_story_1310_footstep08", "")
			end

			local var_55_19 = 0
			local var_55_20 = 1.075

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_21 = arg_52_1:GetWordFromCfg(418021013)
				local var_55_22 = arg_52_1:FormatText(var_55_21.content)

				arg_52_1.text_.text = var_55_22

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_23 = 43
				local var_55_24 = utf8.len(var_55_22)
				local var_55_25 = var_55_23 <= 0 and var_55_20 or var_55_20 * (var_55_24 / var_55_23)

				if var_55_25 > 0 and var_55_20 < var_55_25 then
					arg_52_1.talkMaxDuration = var_55_25

					if var_55_25 + var_55_19 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_25 + var_55_19
					end
				end

				arg_52_1.text_.text = var_55_22
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_26 = math.max(var_55_20, arg_52_1.talkMaxDuration)

			if var_55_19 <= arg_52_1.time_ and arg_52_1.time_ < var_55_19 + var_55_26 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_19) / var_55_26

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_19 + var_55_26 and arg_52_1.time_ < var_55_19 + var_55_26 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play418021014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 418021014
		arg_56_1.duration_ = 1.17

		local var_56_0 = {
			ja = 1.166,
			CriLanguages = 1.033,
			zh = 1.033
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
				arg_56_0:Play418021015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1075"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1075 == nil then
				arg_56_1.var_.actorSpriteComps1075 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps1075 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1075:ToTable()) do
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

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1075 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_59_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps1075 = nil
			end

			local var_59_8 = 0
			local var_59_9 = 0.1

			if var_59_8 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_10 = arg_56_1:FormatText(StoryNameCfg[410].name)

				arg_56_1.leftNameTxt_.text = var_59_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074_split_1")

				arg_56_1.callingController_:SetSelectedState("calling")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_11 = arg_56_1:GetWordFromCfg(418021014)
				local var_59_12 = arg_56_1:FormatText(var_59_11.content)

				arg_56_1.text_.text = var_59_12

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_13 = 4
				local var_59_14 = utf8.len(var_59_12)
				local var_59_15 = var_59_13 <= 0 and var_59_9 or var_59_9 * (var_59_14 / var_59_13)

				if var_59_15 > 0 and var_59_9 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15

					if var_59_15 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_8
					end
				end

				arg_56_1.text_.text = var_59_12
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021014", "story_v_side_old_418021.awb") ~= 0 then
					local var_59_16 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021014", "story_v_side_old_418021.awb") / 1000

					if var_59_16 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_16 + var_59_8
					end

					if var_59_11.prefab_name ~= "" and arg_56_1.actors_[var_59_11.prefab_name] ~= nil then
						local var_59_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_11.prefab_name].transform, "story_v_side_old_418021", "418021014", "story_v_side_old_418021.awb")

						arg_56_1:RecordAudio("418021014", var_59_17)
						arg_56_1:RecordAudio("418021014", var_59_17)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021014", "story_v_side_old_418021.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021014", "story_v_side_old_418021.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_18 = math.max(var_59_9, arg_56_1.talkMaxDuration)

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_18 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_8) / var_59_18

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_8 + var_59_18 and arg_56_1.time_ < var_59_8 + var_59_18 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play418021015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 418021015
		arg_60_1.duration_ = 7.03

		local var_60_0 = {
			ja = 5.333,
			CriLanguages = 7.033,
			zh = 7.033
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
				arg_60_0:Play418021016(arg_60_1)
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

			local var_63_8 = arg_60_1.actors_["1075"]
			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps1075 == nil then
				arg_60_1.var_.actorSpriteComps1075 = var_63_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_10 = 0.2

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 and not isNil(var_63_8) then
				local var_63_11 = (arg_60_1.time_ - var_63_9) / var_63_10

				if arg_60_1.var_.actorSpriteComps1075 then
					for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps1075:ToTable()) do
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

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps1075 then
				for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_63_7 then
						if arg_60_1.isInRecall_ then
							iter_63_7.color = arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_63_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps1075 = nil
			end

			local var_63_16 = arg_60_1.actors_["1073"].transform
			local var_63_17 = 0

			if var_63_17 < arg_60_1.time_ and arg_60_1.time_ <= var_63_17 + arg_63_0 then
				arg_60_1.var_.moveOldPos1073 = var_63_16.localPosition
				var_63_16.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("1073", 3)

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
				local var_63_22 = Vector3.New(38.6, -414.5, -207.2)

				var_63_16.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1073, var_63_22, var_63_21)
			end

			if arg_60_1.time_ >= var_63_17 + var_63_20 and arg_60_1.time_ < var_63_17 + var_63_20 + arg_63_0 then
				var_63_16.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_63_23 = 0
			local var_63_24 = 0.675

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

				local var_63_26 = arg_60_1:GetWordFromCfg(418021015)
				local var_63_27 = arg_60_1:FormatText(var_63_26.content)

				arg_60_1.text_.text = var_63_27

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_28 = 27
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

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021015", "story_v_side_old_418021.awb") ~= 0 then
					local var_63_31 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021015", "story_v_side_old_418021.awb") / 1000

					if var_63_31 + var_63_23 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_31 + var_63_23
					end

					if var_63_26.prefab_name ~= "" and arg_60_1.actors_[var_63_26.prefab_name] ~= nil then
						local var_63_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_26.prefab_name].transform, "story_v_side_old_418021", "418021015", "story_v_side_old_418021.awb")

						arg_60_1:RecordAudio("418021015", var_63_32)
						arg_60_1:RecordAudio("418021015", var_63_32)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021015", "story_v_side_old_418021.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021015", "story_v_side_old_418021.awb")
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
	Play418021016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 418021016
		arg_64_1.duration_ = 4.73

		local var_64_0 = {
			ja = 4.733,
			CriLanguages = 3.2,
			zh = 3.2
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
				arg_64_0:Play418021017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1075"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1075 == nil then
				arg_64_1.var_.actorSpriteComps1075 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps1075 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps1075:ToTable()) do
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

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1075 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps1075 = nil
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

			local var_67_16 = 0
			local var_67_17 = 0.25

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_18 = arg_64_1:FormatText(StoryNameCfg[410].name)

				arg_64_1.leftNameTxt_.text = var_67_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074_split_5")

				arg_64_1.callingController_:SetSelectedState("calling")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_19 = arg_64_1:GetWordFromCfg(418021016)
				local var_67_20 = arg_64_1:FormatText(var_67_19.content)

				arg_64_1.text_.text = var_67_20

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_21 = 10
				local var_67_22 = utf8.len(var_67_20)
				local var_67_23 = var_67_21 <= 0 and var_67_17 or var_67_17 * (var_67_22 / var_67_21)

				if var_67_23 > 0 and var_67_17 < var_67_23 then
					arg_64_1.talkMaxDuration = var_67_23

					if var_67_23 + var_67_16 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_16
					end
				end

				arg_64_1.text_.text = var_67_20
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021016", "story_v_side_old_418021.awb") ~= 0 then
					local var_67_24 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021016", "story_v_side_old_418021.awb") / 1000

					if var_67_24 + var_67_16 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_24 + var_67_16
					end

					if var_67_19.prefab_name ~= "" and arg_64_1.actors_[var_67_19.prefab_name] ~= nil then
						local var_67_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_19.prefab_name].transform, "story_v_side_old_418021", "418021016", "story_v_side_old_418021.awb")

						arg_64_1:RecordAudio("418021016", var_67_25)
						arg_64_1:RecordAudio("418021016", var_67_25)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021016", "story_v_side_old_418021.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021016", "story_v_side_old_418021.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_26 = math.max(var_67_17, arg_64_1.talkMaxDuration)

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_26 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_16) / var_67_26

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_16 + var_67_26 and arg_64_1.time_ < var_67_16 + var_67_26 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play418021017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 418021017
		arg_68_1.duration_ = 3.83

		local var_68_0 = {
			ja = 3.833,
			CriLanguages = 3.733,
			zh = 3.733
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
				arg_68_0:Play418021018(arg_68_1)
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

			local var_71_8 = arg_68_1.actors_["1075"]
			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 and not isNil(var_71_8) and arg_68_1.var_.actorSpriteComps1075 == nil then
				arg_68_1.var_.actorSpriteComps1075 = var_71_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_10 = 0.2

			if var_71_9 <= arg_68_1.time_ and arg_68_1.time_ < var_71_9 + var_71_10 and not isNil(var_71_8) then
				local var_71_11 = (arg_68_1.time_ - var_71_9) / var_71_10

				if arg_68_1.var_.actorSpriteComps1075 then
					for iter_71_4, iter_71_5 in pairs(arg_68_1.var_.actorSpriteComps1075:ToTable()) do
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

			if arg_68_1.time_ >= var_71_9 + var_71_10 and arg_68_1.time_ < var_71_9 + var_71_10 + arg_71_0 and not isNil(var_71_8) and arg_68_1.var_.actorSpriteComps1075 then
				for iter_71_6, iter_71_7 in pairs(arg_68_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_71_7 then
						if arg_68_1.isInRecall_ then
							iter_71_7.color = arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_71_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps1075 = nil
			end

			local var_71_16 = arg_68_1.actors_["1073"].transform
			local var_71_17 = 0

			if var_71_17 < arg_68_1.time_ and arg_68_1.time_ <= var_71_17 + arg_71_0 then
				arg_68_1.var_.moveOldPos1073 = var_71_16.localPosition
				var_71_16.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("1073", 3)

				local var_71_18 = var_71_16.childCount

				for iter_71_8 = 0, var_71_18 - 1 do
					local var_71_19 = var_71_16:GetChild(iter_71_8)

					if var_71_19.name == "split_4" or not string.find(var_71_19.name, "split") then
						var_71_19.gameObject:SetActive(true)
					else
						var_71_19.gameObject:SetActive(false)
					end
				end
			end

			local var_71_20 = 0.001

			if var_71_17 <= arg_68_1.time_ and arg_68_1.time_ < var_71_17 + var_71_20 then
				local var_71_21 = (arg_68_1.time_ - var_71_17) / var_71_20
				local var_71_22 = Vector3.New(38.6, -414.5, -207.2)

				var_71_16.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1073, var_71_22, var_71_21)
			end

			if arg_68_1.time_ >= var_71_17 + var_71_20 and arg_68_1.time_ < var_71_17 + var_71_20 + arg_71_0 then
				var_71_16.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_71_23 = 0
			local var_71_24 = 0.45

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

				local var_71_26 = arg_68_1:GetWordFromCfg(418021017)
				local var_71_27 = arg_68_1:FormatText(var_71_26.content)

				arg_68_1.text_.text = var_71_27

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_28 = 18
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

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021017", "story_v_side_old_418021.awb") ~= 0 then
					local var_71_31 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021017", "story_v_side_old_418021.awb") / 1000

					if var_71_31 + var_71_23 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_31 + var_71_23
					end

					if var_71_26.prefab_name ~= "" and arg_68_1.actors_[var_71_26.prefab_name] ~= nil then
						local var_71_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_26.prefab_name].transform, "story_v_side_old_418021", "418021017", "story_v_side_old_418021.awb")

						arg_68_1:RecordAudio("418021017", var_71_32)
						arg_68_1:RecordAudio("418021017", var_71_32)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021017", "story_v_side_old_418021.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021017", "story_v_side_old_418021.awb")
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
	Play418021018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 418021018
		arg_72_1.duration_ = 4.63

		local var_72_0 = {
			ja = 4.63333333333333,
			CriLanguages = 4.46633333333333,
			zh = 4.46633333333333
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
				arg_72_0:Play418021019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 1.4

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				local var_75_1 = manager.ui.mainCamera.transform.localPosition
				local var_75_2 = Vector3.New(0, 0, 10) + Vector3.New(var_75_1.x, var_75_1.y, 0)
				local var_75_3 = arg_72_1.bgs_.ST1002

				var_75_3.transform.localPosition = var_75_2
				var_75_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_4 = var_75_3:GetComponent("SpriteRenderer")

				if var_75_4 and var_75_4.sprite then
					local var_75_5 = (var_75_3.transform.localPosition - var_75_1).z
					local var_75_6 = manager.ui.mainCameraCom_
					local var_75_7 = 2 * var_75_5 * Mathf.Tan(var_75_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_75_8 = var_75_7 * var_75_6.aspect
					local var_75_9 = var_75_4.sprite.bounds.size.x
					local var_75_10 = var_75_4.sprite.bounds.size.y
					local var_75_11 = var_75_8 / var_75_9
					local var_75_12 = var_75_7 / var_75_10
					local var_75_13 = var_75_12 < var_75_11 and var_75_11 or var_75_12

					var_75_3.transform.localScale = Vector3.New(var_75_13, var_75_13, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "ST1002" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_14 = 0

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			local var_75_15 = 0.3

			if arg_72_1.time_ >= var_75_14 + var_75_15 and arg_72_1.time_ < var_75_14 + var_75_15 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_17 = 1.4

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_17 then
				local var_75_18 = (arg_72_1.time_ - var_75_16) / var_75_17
				local var_75_19 = Color.New(0, 0, 0)

				var_75_19.a = Mathf.Lerp(0, 1, var_75_18)
				arg_72_1.mask_.color = var_75_19
			end

			if arg_72_1.time_ >= var_75_16 + var_75_17 and arg_72_1.time_ < var_75_16 + var_75_17 + arg_75_0 then
				local var_75_20 = Color.New(0, 0, 0)

				var_75_20.a = 1
				arg_72_1.mask_.color = var_75_20
			end

			local var_75_21 = 1.4

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_22 = 2

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_22 then
				local var_75_23 = (arg_72_1.time_ - var_75_21) / var_75_22
				local var_75_24 = Color.New(0, 0, 0)

				var_75_24.a = Mathf.Lerp(1, 0, var_75_23)
				arg_72_1.mask_.color = var_75_24
			end

			if arg_72_1.time_ >= var_75_21 + var_75_22 and arg_72_1.time_ < var_75_21 + var_75_22 + arg_75_0 then
				local var_75_25 = Color.New(0, 0, 0)
				local var_75_26 = 0

				arg_72_1.mask_.enabled = false
				var_75_25.a = var_75_26
				arg_72_1.mask_.color = var_75_25
			end

			local var_75_27 = arg_72_1.actors_["1073"].transform
			local var_75_28 = 1.38333333333333

			if var_75_28 < arg_72_1.time_ and arg_72_1.time_ <= var_75_28 + arg_75_0 then
				arg_72_1.var_.moveOldPos1073 = var_75_27.localPosition
				var_75_27.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("1073", 7)

				local var_75_29 = var_75_27.childCount

				for iter_75_2 = 0, var_75_29 - 1 do
					local var_75_30 = var_75_27:GetChild(iter_75_2)

					if var_75_30.name == "" or not string.find(var_75_30.name, "split") then
						var_75_30.gameObject:SetActive(true)
					else
						var_75_30.gameObject:SetActive(false)
					end
				end
			end

			local var_75_31 = 0.001

			if var_75_28 <= arg_72_1.time_ and arg_72_1.time_ < var_75_28 + var_75_31 then
				local var_75_32 = (arg_72_1.time_ - var_75_28) / var_75_31
				local var_75_33 = Vector3.New(0, -2000, 0)

				var_75_27.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1073, var_75_33, var_75_32)
			end

			if arg_72_1.time_ >= var_75_28 + var_75_31 and arg_72_1.time_ < var_75_28 + var_75_31 + arg_75_0 then
				var_75_27.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_34 = 3.13333333333333
			local var_75_35 = 0.125

			if var_75_34 < arg_72_1.time_ and arg_72_1.time_ <= var_75_34 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_36 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_36:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_37 = arg_72_1:FormatText(StoryNameCfg[380].name)

				arg_72_1.leftNameTxt_.text = var_75_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1073")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_38 = arg_72_1:GetWordFromCfg(418021018)
				local var_75_39 = arg_72_1:FormatText(var_75_38.content)

				arg_72_1.text_.text = var_75_39

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_40 = 5
				local var_75_41 = utf8.len(var_75_39)
				local var_75_42 = var_75_40 <= 0 and var_75_35 or var_75_35 * (var_75_41 / var_75_40)

				if var_75_42 > 0 and var_75_35 < var_75_42 then
					arg_72_1.talkMaxDuration = var_75_42
					var_75_34 = var_75_34 + 0.3

					if var_75_42 + var_75_34 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_42 + var_75_34
					end
				end

				arg_72_1.text_.text = var_75_39
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021018", "story_v_side_old_418021.awb") ~= 0 then
					local var_75_43 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021018", "story_v_side_old_418021.awb") / 1000

					if var_75_43 + var_75_34 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_43 + var_75_34
					end

					if var_75_38.prefab_name ~= "" and arg_72_1.actors_[var_75_38.prefab_name] ~= nil then
						local var_75_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_38.prefab_name].transform, "story_v_side_old_418021", "418021018", "story_v_side_old_418021.awb")

						arg_72_1:RecordAudio("418021018", var_75_44)
						arg_72_1:RecordAudio("418021018", var_75_44)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021018", "story_v_side_old_418021.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021018", "story_v_side_old_418021.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_45 = var_75_34 + 0.3
			local var_75_46 = math.max(var_75_35, arg_72_1.talkMaxDuration)

			if var_75_45 <= arg_72_1.time_ and arg_72_1.time_ < var_75_45 + var_75_46 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_45) / var_75_46

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_45 + var_75_46 and arg_72_1.time_ < var_75_45 + var_75_46 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.38333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play418021019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 418021019
		arg_78_1.duration_ = 4.47

		local var_78_0 = {
			ja = 3.7,
			CriLanguages = 4.466,
			zh = 4.466
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play418021020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = "10135"

			if arg_78_1.actors_[var_81_0] == nil then
				local var_81_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10135")

				if not isNil(var_81_1) then
					local var_81_2 = Object.Instantiate(var_81_1, arg_78_1.canvasGo_.transform)

					var_81_2.transform:SetSiblingIndex(1)

					var_81_2.name = var_81_0
					var_81_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_78_1.actors_[var_81_0] = var_81_2

					local var_81_3 = var_81_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_78_1.isInRecall_ then
						for iter_81_0, iter_81_1 in ipairs(var_81_3) do
							iter_81_1.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_81_4 = arg_78_1.actors_["10135"]
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.actorSpriteComps10135 == nil then
				arg_78_1.var_.actorSpriteComps10135 = var_81_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_6 = 0.2

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 and not isNil(var_81_4) then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / var_81_6

				if arg_78_1.var_.actorSpriteComps10135 then
					for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_81_3 then
							if arg_78_1.isInRecall_ then
								local var_81_8 = Mathf.Lerp(iter_81_3.color.r, arg_78_1.hightColor1.r, var_81_7)
								local var_81_9 = Mathf.Lerp(iter_81_3.color.g, arg_78_1.hightColor1.g, var_81_7)
								local var_81_10 = Mathf.Lerp(iter_81_3.color.b, arg_78_1.hightColor1.b, var_81_7)

								iter_81_3.color = Color.New(var_81_8, var_81_9, var_81_10)
							else
								local var_81_11 = Mathf.Lerp(iter_81_3.color.r, 1, var_81_7)

								iter_81_3.color = Color.New(var_81_11, var_81_11, var_81_11)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.actorSpriteComps10135 then
				for iter_81_4, iter_81_5 in pairs(arg_78_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_81_5 then
						if arg_78_1.isInRecall_ then
							iter_81_5.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_81_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps10135 = nil
			end

			local var_81_12 = arg_78_1.actors_["1073"]
			local var_81_13 = 0

			if var_81_13 < arg_78_1.time_ and arg_78_1.time_ <= var_81_13 + arg_81_0 and not isNil(var_81_12) and arg_78_1.var_.actorSpriteComps1073 == nil then
				arg_78_1.var_.actorSpriteComps1073 = var_81_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_14 = 0.2

			if var_81_13 <= arg_78_1.time_ and arg_78_1.time_ < var_81_13 + var_81_14 and not isNil(var_81_12) then
				local var_81_15 = (arg_78_1.time_ - var_81_13) / var_81_14

				if arg_78_1.var_.actorSpriteComps1073 then
					for iter_81_6, iter_81_7 in pairs(arg_78_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_81_7 then
							if arg_78_1.isInRecall_ then
								local var_81_16 = Mathf.Lerp(iter_81_7.color.r, arg_78_1.hightColor2.r, var_81_15)
								local var_81_17 = Mathf.Lerp(iter_81_7.color.g, arg_78_1.hightColor2.g, var_81_15)
								local var_81_18 = Mathf.Lerp(iter_81_7.color.b, arg_78_1.hightColor2.b, var_81_15)

								iter_81_7.color = Color.New(var_81_16, var_81_17, var_81_18)
							else
								local var_81_19 = Mathf.Lerp(iter_81_7.color.r, 0.5, var_81_15)

								iter_81_7.color = Color.New(var_81_19, var_81_19, var_81_19)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= var_81_13 + var_81_14 and arg_78_1.time_ < var_81_13 + var_81_14 + arg_81_0 and not isNil(var_81_12) and arg_78_1.var_.actorSpriteComps1073 then
				for iter_81_8, iter_81_9 in pairs(arg_78_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_81_9 then
						if arg_78_1.isInRecall_ then
							iter_81_9.color = arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_81_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps1073 = nil
			end

			local var_81_20 = arg_78_1.actors_["1073"].transform
			local var_81_21 = 0

			if var_81_21 < arg_78_1.time_ and arg_78_1.time_ <= var_81_21 + arg_81_0 then
				arg_78_1.var_.moveOldPos1073 = var_81_20.localPosition
				var_81_20.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1073", 7)

				local var_81_22 = var_81_20.childCount

				for iter_81_10 = 0, var_81_22 - 1 do
					local var_81_23 = var_81_20:GetChild(iter_81_10)

					if var_81_23.name == "" or not string.find(var_81_23.name, "split") then
						var_81_23.gameObject:SetActive(true)
					else
						var_81_23.gameObject:SetActive(false)
					end
				end
			end

			local var_81_24 = 0.001

			if var_81_21 <= arg_78_1.time_ and arg_78_1.time_ < var_81_21 + var_81_24 then
				local var_81_25 = (arg_78_1.time_ - var_81_21) / var_81_24
				local var_81_26 = Vector3.New(0, -2000, 0)

				var_81_20.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1073, var_81_26, var_81_25)
			end

			if arg_78_1.time_ >= var_81_21 + var_81_24 and arg_78_1.time_ < var_81_21 + var_81_24 + arg_81_0 then
				var_81_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_81_27 = arg_78_1.actors_["10135"].transform
			local var_81_28 = 0

			if var_81_28 < arg_78_1.time_ and arg_78_1.time_ <= var_81_28 + arg_81_0 then
				arg_78_1.var_.moveOldPos10135 = var_81_27.localPosition
				var_81_27.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("10135", 3)

				local var_81_29 = var_81_27.childCount

				for iter_81_11 = 0, var_81_29 - 1 do
					local var_81_30 = var_81_27:GetChild(iter_81_11)

					if var_81_30.name == "split_6" or not string.find(var_81_30.name, "split") then
						var_81_30.gameObject:SetActive(true)
					else
						var_81_30.gameObject:SetActive(false)
					end
				end
			end

			local var_81_31 = 0.001

			if var_81_28 <= arg_78_1.time_ and arg_78_1.time_ < var_81_28 + var_81_31 then
				local var_81_32 = (arg_78_1.time_ - var_81_28) / var_81_31
				local var_81_33 = Vector3.New(-12.7, -363.6, -305.9)

				var_81_27.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10135, var_81_33, var_81_32)
			end

			if arg_78_1.time_ >= var_81_28 + var_81_31 and arg_78_1.time_ < var_81_28 + var_81_31 + arg_81_0 then
				var_81_27.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_81_34 = 0
			local var_81_35 = 0.25

			if var_81_34 < arg_78_1.time_ and arg_78_1.time_ <= var_81_34 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_36 = arg_78_1:FormatText(StoryNameCfg[1187].name)

				arg_78_1.leftNameTxt_.text = var_81_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_37 = arg_78_1:GetWordFromCfg(418021019)
				local var_81_38 = arg_78_1:FormatText(var_81_37.content)

				arg_78_1.text_.text = var_81_38

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_39 = 10
				local var_81_40 = utf8.len(var_81_38)
				local var_81_41 = var_81_39 <= 0 and var_81_35 or var_81_35 * (var_81_40 / var_81_39)

				if var_81_41 > 0 and var_81_35 < var_81_41 then
					arg_78_1.talkMaxDuration = var_81_41

					if var_81_41 + var_81_34 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_41 + var_81_34
					end
				end

				arg_78_1.text_.text = var_81_38
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021019", "story_v_side_old_418021.awb") ~= 0 then
					local var_81_42 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021019", "story_v_side_old_418021.awb") / 1000

					if var_81_42 + var_81_34 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_42 + var_81_34
					end

					if var_81_37.prefab_name ~= "" and arg_78_1.actors_[var_81_37.prefab_name] ~= nil then
						local var_81_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_37.prefab_name].transform, "story_v_side_old_418021", "418021019", "story_v_side_old_418021.awb")

						arg_78_1:RecordAudio("418021019", var_81_43)
						arg_78_1:RecordAudio("418021019", var_81_43)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021019", "story_v_side_old_418021.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021019", "story_v_side_old_418021.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_44 = math.max(var_81_35, arg_78_1.talkMaxDuration)

			if var_81_34 <= arg_78_1.time_ and arg_78_1.time_ < var_81_34 + var_81_44 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_34) / var_81_44

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_34 + var_81_44 and arg_78_1.time_ < var_81_34 + var_81_44 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play418021020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 418021020
		arg_82_1.duration_ = 3.8

		local var_82_0 = {
			ja = 3.8,
			CriLanguages = 3.2,
			zh = 3.2
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play418021021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1073"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1073 == nil then
				arg_82_1.var_.actorSpriteComps1073 = var_85_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.actorSpriteComps1073 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								local var_85_4 = Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor1.r, var_85_3)
								local var_85_5 = Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor1.g, var_85_3)
								local var_85_6 = Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor1.b, var_85_3)

								iter_85_1.color = Color.New(var_85_4, var_85_5, var_85_6)
							else
								local var_85_7 = Mathf.Lerp(iter_85_1.color.r, 1, var_85_3)

								iter_85_1.color = Color.New(var_85_7, var_85_7, var_85_7)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1073 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_85_3 then
						if arg_82_1.isInRecall_ then
							iter_85_3.color = arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_85_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps1073 = nil
			end

			local var_85_8 = arg_82_1.actors_["10135"]
			local var_85_9 = 0

			if var_85_9 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps10135 == nil then
				arg_82_1.var_.actorSpriteComps10135 = var_85_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_10 = 0.2

			if var_85_9 <= arg_82_1.time_ and arg_82_1.time_ < var_85_9 + var_85_10 and not isNil(var_85_8) then
				local var_85_11 = (arg_82_1.time_ - var_85_9) / var_85_10

				if arg_82_1.var_.actorSpriteComps10135 then
					for iter_85_4, iter_85_5 in pairs(arg_82_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_85_5 then
							if arg_82_1.isInRecall_ then
								local var_85_12 = Mathf.Lerp(iter_85_5.color.r, arg_82_1.hightColor2.r, var_85_11)
								local var_85_13 = Mathf.Lerp(iter_85_5.color.g, arg_82_1.hightColor2.g, var_85_11)
								local var_85_14 = Mathf.Lerp(iter_85_5.color.b, arg_82_1.hightColor2.b, var_85_11)

								iter_85_5.color = Color.New(var_85_12, var_85_13, var_85_14)
							else
								local var_85_15 = Mathf.Lerp(iter_85_5.color.r, 0.5, var_85_11)

								iter_85_5.color = Color.New(var_85_15, var_85_15, var_85_15)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_9 + var_85_10 and arg_82_1.time_ < var_85_9 + var_85_10 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps10135 then
				for iter_85_6, iter_85_7 in pairs(arg_82_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_85_7 then
						if arg_82_1.isInRecall_ then
							iter_85_7.color = arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_85_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps10135 = nil
			end

			local var_85_16 = arg_82_1.actors_["10135"].transform
			local var_85_17 = 0

			if var_85_17 < arg_82_1.time_ and arg_82_1.time_ <= var_85_17 + arg_85_0 then
				arg_82_1.var_.moveOldPos10135 = var_85_16.localPosition
				var_85_16.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("10135", 4)

				local var_85_18 = var_85_16.childCount

				for iter_85_8 = 0, var_85_18 - 1 do
					local var_85_19 = var_85_16:GetChild(iter_85_8)

					if var_85_19.name == "split_6" or not string.find(var_85_19.name, "split") then
						var_85_19.gameObject:SetActive(true)
					else
						var_85_19.gameObject:SetActive(false)
					end
				end
			end

			local var_85_20 = 0.001

			if var_85_17 <= arg_82_1.time_ and arg_82_1.time_ < var_85_17 + var_85_20 then
				local var_85_21 = (arg_82_1.time_ - var_85_17) / var_85_20
				local var_85_22 = Vector3.New(432.72, -363.6, -305.9)

				var_85_16.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10135, var_85_22, var_85_21)
			end

			if arg_82_1.time_ >= var_85_17 + var_85_20 and arg_82_1.time_ < var_85_17 + var_85_20 + arg_85_0 then
				var_85_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_85_23 = arg_82_1.actors_["1073"].transform
			local var_85_24 = 0

			if var_85_24 < arg_82_1.time_ and arg_82_1.time_ <= var_85_24 + arg_85_0 then
				arg_82_1.var_.moveOldPos1073 = var_85_23.localPosition
				var_85_23.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("1073", 2)

				local var_85_25 = var_85_23.childCount

				for iter_85_9 = 0, var_85_25 - 1 do
					local var_85_26 = var_85_23:GetChild(iter_85_9)

					if var_85_26.name == "" or not string.find(var_85_26.name, "split") then
						var_85_26.gameObject:SetActive(true)
					else
						var_85_26.gameObject:SetActive(false)
					end
				end
			end

			local var_85_27 = 0.001

			if var_85_24 <= arg_82_1.time_ and arg_82_1.time_ < var_85_24 + var_85_27 then
				local var_85_28 = (arg_82_1.time_ - var_85_24) / var_85_27
				local var_85_29 = Vector3.New(-405.76, -414.5, -207.2)

				var_85_23.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1073, var_85_29, var_85_28)
			end

			if arg_82_1.time_ >= var_85_24 + var_85_27 and arg_82_1.time_ < var_85_24 + var_85_27 + arg_85_0 then
				var_85_23.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_85_30 = 0
			local var_85_31 = 0.35

			if var_85_30 < arg_82_1.time_ and arg_82_1.time_ <= var_85_30 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_32 = arg_82_1:FormatText(StoryNameCfg[380].name)

				arg_82_1.leftNameTxt_.text = var_85_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_33 = arg_82_1:GetWordFromCfg(418021020)
				local var_85_34 = arg_82_1:FormatText(var_85_33.content)

				arg_82_1.text_.text = var_85_34

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_35 = 14
				local var_85_36 = utf8.len(var_85_34)
				local var_85_37 = var_85_35 <= 0 and var_85_31 or var_85_31 * (var_85_36 / var_85_35)

				if var_85_37 > 0 and var_85_31 < var_85_37 then
					arg_82_1.talkMaxDuration = var_85_37

					if var_85_37 + var_85_30 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_37 + var_85_30
					end
				end

				arg_82_1.text_.text = var_85_34
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021020", "story_v_side_old_418021.awb") ~= 0 then
					local var_85_38 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021020", "story_v_side_old_418021.awb") / 1000

					if var_85_38 + var_85_30 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_38 + var_85_30
					end

					if var_85_33.prefab_name ~= "" and arg_82_1.actors_[var_85_33.prefab_name] ~= nil then
						local var_85_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_33.prefab_name].transform, "story_v_side_old_418021", "418021020", "story_v_side_old_418021.awb")

						arg_82_1:RecordAudio("418021020", var_85_39)
						arg_82_1:RecordAudio("418021020", var_85_39)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021020", "story_v_side_old_418021.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021020", "story_v_side_old_418021.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_40 = math.max(var_85_31, arg_82_1.talkMaxDuration)

			if var_85_30 <= arg_82_1.time_ and arg_82_1.time_ < var_85_30 + var_85_40 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_30) / var_85_40

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_30 + var_85_40 and arg_82_1.time_ < var_85_30 + var_85_40 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
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

		arg_82_1:InitPlayNodeList()
	end,
	Play418021021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 418021021
		arg_86_1.duration_ = 5.63

		local var_86_0 = {
			ja = 5.633,
			CriLanguages = 4.9,
			zh = 4.9
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play418021022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10135"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10135 == nil then
				arg_86_1.var_.actorSpriteComps10135 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps10135 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								local var_89_4 = Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor1.r, var_89_3)
								local var_89_5 = Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor1.g, var_89_3)
								local var_89_6 = Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor1.b, var_89_3)

								iter_89_1.color = Color.New(var_89_4, var_89_5, var_89_6)
							else
								local var_89_7 = Mathf.Lerp(iter_89_1.color.r, 1, var_89_3)

								iter_89_1.color = Color.New(var_89_7, var_89_7, var_89_7)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10135 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_89_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps10135 = nil
			end

			local var_89_8 = arg_86_1.actors_["1073"]
			local var_89_9 = 0

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 and not isNil(var_89_8) and arg_86_1.var_.actorSpriteComps1073 == nil then
				arg_86_1.var_.actorSpriteComps1073 = var_89_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_10 = 0.2

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_10 and not isNil(var_89_8) then
				local var_89_11 = (arg_86_1.time_ - var_89_9) / var_89_10

				if arg_86_1.var_.actorSpriteComps1073 then
					for iter_89_4, iter_89_5 in pairs(arg_86_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_89_5 then
							if arg_86_1.isInRecall_ then
								local var_89_12 = Mathf.Lerp(iter_89_5.color.r, arg_86_1.hightColor2.r, var_89_11)
								local var_89_13 = Mathf.Lerp(iter_89_5.color.g, arg_86_1.hightColor2.g, var_89_11)
								local var_89_14 = Mathf.Lerp(iter_89_5.color.b, arg_86_1.hightColor2.b, var_89_11)

								iter_89_5.color = Color.New(var_89_12, var_89_13, var_89_14)
							else
								local var_89_15 = Mathf.Lerp(iter_89_5.color.r, 0.5, var_89_11)

								iter_89_5.color = Color.New(var_89_15, var_89_15, var_89_15)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_9 + var_89_10 and arg_86_1.time_ < var_89_9 + var_89_10 + arg_89_0 and not isNil(var_89_8) and arg_86_1.var_.actorSpriteComps1073 then
				for iter_89_6, iter_89_7 in pairs(arg_86_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_89_7 then
						if arg_86_1.isInRecall_ then
							iter_89_7.color = arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_89_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps1073 = nil
			end

			local var_89_16 = arg_86_1.actors_["10135"].transform
			local var_89_17 = 0

			if var_89_17 < arg_86_1.time_ and arg_86_1.time_ <= var_89_17 + arg_89_0 then
				arg_86_1.var_.moveOldPos10135 = var_89_16.localPosition
				var_89_16.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10135", 4)

				local var_89_18 = var_89_16.childCount

				for iter_89_8 = 0, var_89_18 - 1 do
					local var_89_19 = var_89_16:GetChild(iter_89_8)

					if var_89_19.name == "split_1" or not string.find(var_89_19.name, "split") then
						var_89_19.gameObject:SetActive(true)
					else
						var_89_19.gameObject:SetActive(false)
					end
				end
			end

			local var_89_20 = 0.001

			if var_89_17 <= arg_86_1.time_ and arg_86_1.time_ < var_89_17 + var_89_20 then
				local var_89_21 = (arg_86_1.time_ - var_89_17) / var_89_20
				local var_89_22 = Vector3.New(432.72, -363.6, -305.9)

				var_89_16.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10135, var_89_22, var_89_21)
			end

			if arg_86_1.time_ >= var_89_17 + var_89_20 and arg_86_1.time_ < var_89_17 + var_89_20 + arg_89_0 then
				var_89_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_89_23 = 0
			local var_89_24 = 0.7

			if var_89_23 < arg_86_1.time_ and arg_86_1.time_ <= var_89_23 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_25 = arg_86_1:FormatText(StoryNameCfg[1187].name)

				arg_86_1.leftNameTxt_.text = var_89_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_26 = arg_86_1:GetWordFromCfg(418021021)
				local var_89_27 = arg_86_1:FormatText(var_89_26.content)

				arg_86_1.text_.text = var_89_27

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_28 = 23
				local var_89_29 = utf8.len(var_89_27)
				local var_89_30 = var_89_28 <= 0 and var_89_24 or var_89_24 * (var_89_29 / var_89_28)

				if var_89_30 > 0 and var_89_24 < var_89_30 then
					arg_86_1.talkMaxDuration = var_89_30

					if var_89_30 + var_89_23 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_30 + var_89_23
					end
				end

				arg_86_1.text_.text = var_89_27
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021021", "story_v_side_old_418021.awb") ~= 0 then
					local var_89_31 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021021", "story_v_side_old_418021.awb") / 1000

					if var_89_31 + var_89_23 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_31 + var_89_23
					end

					if var_89_26.prefab_name ~= "" and arg_86_1.actors_[var_89_26.prefab_name] ~= nil then
						local var_89_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_26.prefab_name].transform, "story_v_side_old_418021", "418021021", "story_v_side_old_418021.awb")

						arg_86_1:RecordAudio("418021021", var_89_32)
						arg_86_1:RecordAudio("418021021", var_89_32)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021021", "story_v_side_old_418021.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021021", "story_v_side_old_418021.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_33 = math.max(var_89_24, arg_86_1.talkMaxDuration)

			if var_89_23 <= arg_86_1.time_ and arg_86_1.time_ < var_89_23 + var_89_33 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_23) / var_89_33

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_23 + var_89_33 and arg_86_1.time_ < var_89_23 + var_89_33 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play418021022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 418021022
		arg_90_1.duration_ = 3.2

		local var_90_0 = {
			ja = 2.866,
			CriLanguages = 3.2,
			zh = 3.2
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play418021023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1073"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1073 == nil then
				arg_90_1.var_.actorSpriteComps1073 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps1073 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								local var_93_4 = Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, var_93_3)
								local var_93_5 = Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, var_93_3)
								local var_93_6 = Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, var_93_3)

								iter_93_1.color = Color.New(var_93_4, var_93_5, var_93_6)
							else
								local var_93_7 = Mathf.Lerp(iter_93_1.color.r, 1, var_93_3)

								iter_93_1.color = Color.New(var_93_7, var_93_7, var_93_7)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1073 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_93_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps1073 = nil
			end

			local var_93_8 = arg_90_1.actors_["10135"]
			local var_93_9 = 0

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 and not isNil(var_93_8) and arg_90_1.var_.actorSpriteComps10135 == nil then
				arg_90_1.var_.actorSpriteComps10135 = var_93_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_10 = 0.2

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_10 and not isNil(var_93_8) then
				local var_93_11 = (arg_90_1.time_ - var_93_9) / var_93_10

				if arg_90_1.var_.actorSpriteComps10135 then
					for iter_93_4, iter_93_5 in pairs(arg_90_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_93_5 then
							if arg_90_1.isInRecall_ then
								local var_93_12 = Mathf.Lerp(iter_93_5.color.r, arg_90_1.hightColor2.r, var_93_11)
								local var_93_13 = Mathf.Lerp(iter_93_5.color.g, arg_90_1.hightColor2.g, var_93_11)
								local var_93_14 = Mathf.Lerp(iter_93_5.color.b, arg_90_1.hightColor2.b, var_93_11)

								iter_93_5.color = Color.New(var_93_12, var_93_13, var_93_14)
							else
								local var_93_15 = Mathf.Lerp(iter_93_5.color.r, 0.5, var_93_11)

								iter_93_5.color = Color.New(var_93_15, var_93_15, var_93_15)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_9 + var_93_10 and arg_90_1.time_ < var_93_9 + var_93_10 + arg_93_0 and not isNil(var_93_8) and arg_90_1.var_.actorSpriteComps10135 then
				for iter_93_6, iter_93_7 in pairs(arg_90_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_93_7 then
						if arg_90_1.isInRecall_ then
							iter_93_7.color = arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_93_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps10135 = nil
			end

			local var_93_16 = arg_90_1.actors_["1073"].transform
			local var_93_17 = 0

			if var_93_17 < arg_90_1.time_ and arg_90_1.time_ <= var_93_17 + arg_93_0 then
				arg_90_1.var_.moveOldPos1073 = var_93_16.localPosition
				var_93_16.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("1073", 2)

				local var_93_18 = var_93_16.childCount

				for iter_93_8 = 0, var_93_18 - 1 do
					local var_93_19 = var_93_16:GetChild(iter_93_8)

					if var_93_19.name == "split_4" or not string.find(var_93_19.name, "split") then
						var_93_19.gameObject:SetActive(true)
					else
						var_93_19.gameObject:SetActive(false)
					end
				end
			end

			local var_93_20 = 0.001

			if var_93_17 <= arg_90_1.time_ and arg_90_1.time_ < var_93_17 + var_93_20 then
				local var_93_21 = (arg_90_1.time_ - var_93_17) / var_93_20
				local var_93_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_93_16.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1073, var_93_22, var_93_21)
			end

			if arg_90_1.time_ >= var_93_17 + var_93_20 and arg_90_1.time_ < var_93_17 + var_93_20 + arg_93_0 then
				var_93_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_93_23 = 0
			local var_93_24 = 0.225

			if var_93_23 < arg_90_1.time_ and arg_90_1.time_ <= var_93_23 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_25 = arg_90_1:FormatText(StoryNameCfg[380].name)

				arg_90_1.leftNameTxt_.text = var_93_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_26 = arg_90_1:GetWordFromCfg(418021022)
				local var_93_27 = arg_90_1:FormatText(var_93_26.content)

				arg_90_1.text_.text = var_93_27

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_28 = 9
				local var_93_29 = utf8.len(var_93_27)
				local var_93_30 = var_93_28 <= 0 and var_93_24 or var_93_24 * (var_93_29 / var_93_28)

				if var_93_30 > 0 and var_93_24 < var_93_30 then
					arg_90_1.talkMaxDuration = var_93_30

					if var_93_30 + var_93_23 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_30 + var_93_23
					end
				end

				arg_90_1.text_.text = var_93_27
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021022", "story_v_side_old_418021.awb") ~= 0 then
					local var_93_31 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021022", "story_v_side_old_418021.awb") / 1000

					if var_93_31 + var_93_23 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_31 + var_93_23
					end

					if var_93_26.prefab_name ~= "" and arg_90_1.actors_[var_93_26.prefab_name] ~= nil then
						local var_93_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_26.prefab_name].transform, "story_v_side_old_418021", "418021022", "story_v_side_old_418021.awb")

						arg_90_1:RecordAudio("418021022", var_93_32)
						arg_90_1:RecordAudio("418021022", var_93_32)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021022", "story_v_side_old_418021.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021022", "story_v_side_old_418021.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_33 = math.max(var_93_24, arg_90_1.talkMaxDuration)

			if var_93_23 <= arg_90_1.time_ and arg_90_1.time_ < var_93_23 + var_93_33 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_23) / var_93_33

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_23 + var_93_33 and arg_90_1.time_ < var_93_23 + var_93_33 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play418021023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 418021023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play418021024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1073"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps1073 == nil then
				arg_94_1.var_.actorSpriteComps1073 = var_97_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.actorSpriteComps1073 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								local var_97_4 = Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor2.r, var_97_3)
								local var_97_5 = Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor2.g, var_97_3)
								local var_97_6 = Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor2.b, var_97_3)

								iter_97_1.color = Color.New(var_97_4, var_97_5, var_97_6)
							else
								local var_97_7 = Mathf.Lerp(iter_97_1.color.r, 0.5, var_97_3)

								iter_97_1.color = Color.New(var_97_7, var_97_7, var_97_7)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps1073 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_97_3 then
						if arg_94_1.isInRecall_ then
							iter_97_3.color = arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_97_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps1073 = nil
			end

			local var_97_8 = 0
			local var_97_9 = 0.85

			if var_97_8 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:GetWordFromCfg(418021023)
				local var_97_11 = arg_94_1:FormatText(var_97_10.content)

				arg_94_1.text_.text = var_97_11

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_12 = 34
				local var_97_13 = utf8.len(var_97_11)
				local var_97_14 = var_97_12 <= 0 and var_97_9 or var_97_9 * (var_97_13 / var_97_12)

				if var_97_14 > 0 and var_97_9 < var_97_14 then
					arg_94_1.talkMaxDuration = var_97_14

					if var_97_14 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_11
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_15 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_15 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_15

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_15 and arg_94_1.time_ < var_97_8 + var_97_15 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play418021024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 418021024
		arg_98_1.duration_ = 4.53

		local var_98_0 = {
			ja = 4.4,
			CriLanguages = 4.533,
			zh = 4.533
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play418021025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1073"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps1073 == nil then
				arg_98_1.var_.actorSpriteComps1073 = var_101_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.actorSpriteComps1073 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								local var_101_4 = Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor1.r, var_101_3)
								local var_101_5 = Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor1.g, var_101_3)
								local var_101_6 = Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor1.b, var_101_3)

								iter_101_1.color = Color.New(var_101_4, var_101_5, var_101_6)
							else
								local var_101_7 = Mathf.Lerp(iter_101_1.color.r, 1, var_101_3)

								iter_101_1.color = Color.New(var_101_7, var_101_7, var_101_7)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps1073 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_101_3 then
						if arg_98_1.isInRecall_ then
							iter_101_3.color = arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_101_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps1073 = nil
			end

			local var_101_8 = arg_98_1.actors_["1073"].transform
			local var_101_9 = 0

			if var_101_9 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 then
				arg_98_1.var_.moveOldPos1073 = var_101_8.localPosition
				var_101_8.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("1073", 2)

				local var_101_10 = var_101_8.childCount

				for iter_101_4 = 0, var_101_10 - 1 do
					local var_101_11 = var_101_8:GetChild(iter_101_4)

					if var_101_11.name == "" or not string.find(var_101_11.name, "split") then
						var_101_11.gameObject:SetActive(true)
					else
						var_101_11.gameObject:SetActive(false)
					end
				end
			end

			local var_101_12 = 0.001

			if var_101_9 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_12 then
				local var_101_13 = (arg_98_1.time_ - var_101_9) / var_101_12
				local var_101_14 = Vector3.New(-405.76, -414.5, -207.2)

				var_101_8.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1073, var_101_14, var_101_13)
			end

			if arg_98_1.time_ >= var_101_9 + var_101_12 and arg_98_1.time_ < var_101_9 + var_101_12 + arg_101_0 then
				var_101_8.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_101_15 = 0
			local var_101_16 = 0.525

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_17 = arg_98_1:FormatText(StoryNameCfg[380].name)

				arg_98_1.leftNameTxt_.text = var_101_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_18 = arg_98_1:GetWordFromCfg(418021024)
				local var_101_19 = arg_98_1:FormatText(var_101_18.content)

				arg_98_1.text_.text = var_101_19

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_20 = 21
				local var_101_21 = utf8.len(var_101_19)
				local var_101_22 = var_101_20 <= 0 and var_101_16 or var_101_16 * (var_101_21 / var_101_20)

				if var_101_22 > 0 and var_101_16 < var_101_22 then
					arg_98_1.talkMaxDuration = var_101_22

					if var_101_22 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_22 + var_101_15
					end
				end

				arg_98_1.text_.text = var_101_19
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021024", "story_v_side_old_418021.awb") ~= 0 then
					local var_101_23 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021024", "story_v_side_old_418021.awb") / 1000

					if var_101_23 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_23 + var_101_15
					end

					if var_101_18.prefab_name ~= "" and arg_98_1.actors_[var_101_18.prefab_name] ~= nil then
						local var_101_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_18.prefab_name].transform, "story_v_side_old_418021", "418021024", "story_v_side_old_418021.awb")

						arg_98_1:RecordAudio("418021024", var_101_24)
						arg_98_1:RecordAudio("418021024", var_101_24)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021024", "story_v_side_old_418021.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021024", "story_v_side_old_418021.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_25 = math.max(var_101_16, arg_98_1.talkMaxDuration)

			if var_101_15 <= arg_98_1.time_ and arg_98_1.time_ < var_101_15 + var_101_25 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_15) / var_101_25

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_15 + var_101_25 and arg_98_1.time_ < var_101_15 + var_101_25 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play418021025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 418021025
		arg_102_1.duration_ = 13.13

		local var_102_0 = {
			ja = 13.133,
			CriLanguages = 7.3,
			zh = 7.3
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play418021026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10135"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps10135 == nil then
				arg_102_1.var_.actorSpriteComps10135 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps10135 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								local var_105_4 = Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor1.r, var_105_3)
								local var_105_5 = Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor1.g, var_105_3)
								local var_105_6 = Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor1.b, var_105_3)

								iter_105_1.color = Color.New(var_105_4, var_105_5, var_105_6)
							else
								local var_105_7 = Mathf.Lerp(iter_105_1.color.r, 1, var_105_3)

								iter_105_1.color = Color.New(var_105_7, var_105_7, var_105_7)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps10135 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_105_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps10135 = nil
			end

			local var_105_8 = arg_102_1.actors_["1073"]
			local var_105_9 = 0

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.actorSpriteComps1073 == nil then
				arg_102_1.var_.actorSpriteComps1073 = var_105_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_10 = 0.2

			if var_105_9 <= arg_102_1.time_ and arg_102_1.time_ < var_105_9 + var_105_10 and not isNil(var_105_8) then
				local var_105_11 = (arg_102_1.time_ - var_105_9) / var_105_10

				if arg_102_1.var_.actorSpriteComps1073 then
					for iter_105_4, iter_105_5 in pairs(arg_102_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_105_5 then
							if arg_102_1.isInRecall_ then
								local var_105_12 = Mathf.Lerp(iter_105_5.color.r, arg_102_1.hightColor2.r, var_105_11)
								local var_105_13 = Mathf.Lerp(iter_105_5.color.g, arg_102_1.hightColor2.g, var_105_11)
								local var_105_14 = Mathf.Lerp(iter_105_5.color.b, arg_102_1.hightColor2.b, var_105_11)

								iter_105_5.color = Color.New(var_105_12, var_105_13, var_105_14)
							else
								local var_105_15 = Mathf.Lerp(iter_105_5.color.r, 0.5, var_105_11)

								iter_105_5.color = Color.New(var_105_15, var_105_15, var_105_15)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_9 + var_105_10 and arg_102_1.time_ < var_105_9 + var_105_10 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.actorSpriteComps1073 then
				for iter_105_6, iter_105_7 in pairs(arg_102_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_105_7 then
						if arg_102_1.isInRecall_ then
							iter_105_7.color = arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_105_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps1073 = nil
			end

			local var_105_16 = arg_102_1.actors_["10135"].transform
			local var_105_17 = 0

			if var_105_17 < arg_102_1.time_ and arg_102_1.time_ <= var_105_17 + arg_105_0 then
				arg_102_1.var_.moveOldPos10135 = var_105_16.localPosition
				var_105_16.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("10135", 4)

				local var_105_18 = var_105_16.childCount

				for iter_105_8 = 0, var_105_18 - 1 do
					local var_105_19 = var_105_16:GetChild(iter_105_8)

					if var_105_19.name == "split_1" or not string.find(var_105_19.name, "split") then
						var_105_19.gameObject:SetActive(true)
					else
						var_105_19.gameObject:SetActive(false)
					end
				end
			end

			local var_105_20 = 0.001

			if var_105_17 <= arg_102_1.time_ and arg_102_1.time_ < var_105_17 + var_105_20 then
				local var_105_21 = (arg_102_1.time_ - var_105_17) / var_105_20
				local var_105_22 = Vector3.New(432.72, -363.6, -305.9)

				var_105_16.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10135, var_105_22, var_105_21)
			end

			if arg_102_1.time_ >= var_105_17 + var_105_20 and arg_102_1.time_ < var_105_17 + var_105_20 + arg_105_0 then
				var_105_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_105_23 = 0
			local var_105_24 = 0.7

			if var_105_23 < arg_102_1.time_ and arg_102_1.time_ <= var_105_23 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_25 = arg_102_1:FormatText(StoryNameCfg[1187].name)

				arg_102_1.leftNameTxt_.text = var_105_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_26 = arg_102_1:GetWordFromCfg(418021025)
				local var_105_27 = arg_102_1:FormatText(var_105_26.content)

				arg_102_1.text_.text = var_105_27

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_28 = 28
				local var_105_29 = utf8.len(var_105_27)
				local var_105_30 = var_105_28 <= 0 and var_105_24 or var_105_24 * (var_105_29 / var_105_28)

				if var_105_30 > 0 and var_105_24 < var_105_30 then
					arg_102_1.talkMaxDuration = var_105_30

					if var_105_30 + var_105_23 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_30 + var_105_23
					end
				end

				arg_102_1.text_.text = var_105_27
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021025", "story_v_side_old_418021.awb") ~= 0 then
					local var_105_31 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021025", "story_v_side_old_418021.awb") / 1000

					if var_105_31 + var_105_23 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_31 + var_105_23
					end

					if var_105_26.prefab_name ~= "" and arg_102_1.actors_[var_105_26.prefab_name] ~= nil then
						local var_105_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_26.prefab_name].transform, "story_v_side_old_418021", "418021025", "story_v_side_old_418021.awb")

						arg_102_1:RecordAudio("418021025", var_105_32)
						arg_102_1:RecordAudio("418021025", var_105_32)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021025", "story_v_side_old_418021.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021025", "story_v_side_old_418021.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_33 = math.max(var_105_24, arg_102_1.talkMaxDuration)

			if var_105_23 <= arg_102_1.time_ and arg_102_1.time_ < var_105_23 + var_105_33 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_23) / var_105_33

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_23 + var_105_33 and arg_102_1.time_ < var_105_23 + var_105_33 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play418021026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 418021026
		arg_106_1.duration_ = 4.33

		local var_106_0 = {
			ja = 4.333,
			CriLanguages = 3.033,
			zh = 3.033
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play418021027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1073"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps1073 == nil then
				arg_106_1.var_.actorSpriteComps1073 = var_109_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.actorSpriteComps1073 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								local var_109_4 = Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, var_109_3)
								local var_109_5 = Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, var_109_3)
								local var_109_6 = Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, var_109_3)

								iter_109_1.color = Color.New(var_109_4, var_109_5, var_109_6)
							else
								local var_109_7 = Mathf.Lerp(iter_109_1.color.r, 1, var_109_3)

								iter_109_1.color = Color.New(var_109_7, var_109_7, var_109_7)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps1073 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_109_3 then
						if arg_106_1.isInRecall_ then
							iter_109_3.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_109_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps1073 = nil
			end

			local var_109_8 = arg_106_1.actors_["10135"]
			local var_109_9 = 0

			if var_109_9 < arg_106_1.time_ and arg_106_1.time_ <= var_109_9 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.actorSpriteComps10135 == nil then
				arg_106_1.var_.actorSpriteComps10135 = var_109_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_10 = 0.2

			if var_109_9 <= arg_106_1.time_ and arg_106_1.time_ < var_109_9 + var_109_10 and not isNil(var_109_8) then
				local var_109_11 = (arg_106_1.time_ - var_109_9) / var_109_10

				if arg_106_1.var_.actorSpriteComps10135 then
					for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_109_5 then
							if arg_106_1.isInRecall_ then
								local var_109_12 = Mathf.Lerp(iter_109_5.color.r, arg_106_1.hightColor2.r, var_109_11)
								local var_109_13 = Mathf.Lerp(iter_109_5.color.g, arg_106_1.hightColor2.g, var_109_11)
								local var_109_14 = Mathf.Lerp(iter_109_5.color.b, arg_106_1.hightColor2.b, var_109_11)

								iter_109_5.color = Color.New(var_109_12, var_109_13, var_109_14)
							else
								local var_109_15 = Mathf.Lerp(iter_109_5.color.r, 0.5, var_109_11)

								iter_109_5.color = Color.New(var_109_15, var_109_15, var_109_15)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_9 + var_109_10 and arg_106_1.time_ < var_109_9 + var_109_10 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.actorSpriteComps10135 then
				for iter_109_6, iter_109_7 in pairs(arg_106_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_109_7 then
						if arg_106_1.isInRecall_ then
							iter_109_7.color = arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_109_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps10135 = nil
			end

			local var_109_16 = arg_106_1.actors_["1073"].transform
			local var_109_17 = 0

			if var_109_17 < arg_106_1.time_ and arg_106_1.time_ <= var_109_17 + arg_109_0 then
				arg_106_1.var_.moveOldPos1073 = var_109_16.localPosition
				var_109_16.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("1073", 2)

				local var_109_18 = var_109_16.childCount

				for iter_109_8 = 0, var_109_18 - 1 do
					local var_109_19 = var_109_16:GetChild(iter_109_8)

					if var_109_19.name == "" or not string.find(var_109_19.name, "split") then
						var_109_19.gameObject:SetActive(true)
					else
						var_109_19.gameObject:SetActive(false)
					end
				end
			end

			local var_109_20 = 0.001

			if var_109_17 <= arg_106_1.time_ and arg_106_1.time_ < var_109_17 + var_109_20 then
				local var_109_21 = (arg_106_1.time_ - var_109_17) / var_109_20
				local var_109_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_109_16.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1073, var_109_22, var_109_21)
			end

			if arg_106_1.time_ >= var_109_17 + var_109_20 and arg_106_1.time_ < var_109_17 + var_109_20 + arg_109_0 then
				var_109_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_109_23 = 0
			local var_109_24 = 0.45

			if var_109_23 < arg_106_1.time_ and arg_106_1.time_ <= var_109_23 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_25 = arg_106_1:FormatText(StoryNameCfg[380].name)

				arg_106_1.leftNameTxt_.text = var_109_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_26 = arg_106_1:GetWordFromCfg(418021026)
				local var_109_27 = arg_106_1:FormatText(var_109_26.content)

				arg_106_1.text_.text = var_109_27

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_28 = 18
				local var_109_29 = utf8.len(var_109_27)
				local var_109_30 = var_109_28 <= 0 and var_109_24 or var_109_24 * (var_109_29 / var_109_28)

				if var_109_30 > 0 and var_109_24 < var_109_30 then
					arg_106_1.talkMaxDuration = var_109_30

					if var_109_30 + var_109_23 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_30 + var_109_23
					end
				end

				arg_106_1.text_.text = var_109_27
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021026", "story_v_side_old_418021.awb") ~= 0 then
					local var_109_31 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021026", "story_v_side_old_418021.awb") / 1000

					if var_109_31 + var_109_23 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_31 + var_109_23
					end

					if var_109_26.prefab_name ~= "" and arg_106_1.actors_[var_109_26.prefab_name] ~= nil then
						local var_109_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_26.prefab_name].transform, "story_v_side_old_418021", "418021026", "story_v_side_old_418021.awb")

						arg_106_1:RecordAudio("418021026", var_109_32)
						arg_106_1:RecordAudio("418021026", var_109_32)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021026", "story_v_side_old_418021.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021026", "story_v_side_old_418021.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_33 = math.max(var_109_24, arg_106_1.talkMaxDuration)

			if var_109_23 <= arg_106_1.time_ and arg_106_1.time_ < var_109_23 + var_109_33 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_23) / var_109_33

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_23 + var_109_33 and arg_106_1.time_ < var_109_23 + var_109_33 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play418021027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 418021027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play418021028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1073"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps1073 == nil then
				arg_110_1.var_.actorSpriteComps1073 = var_113_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_2 = 0.2

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.actorSpriteComps1073 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								local var_113_4 = Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor2.r, var_113_3)
								local var_113_5 = Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor2.g, var_113_3)
								local var_113_6 = Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor2.b, var_113_3)

								iter_113_1.color = Color.New(var_113_4, var_113_5, var_113_6)
							else
								local var_113_7 = Mathf.Lerp(iter_113_1.color.r, 0.5, var_113_3)

								iter_113_1.color = Color.New(var_113_7, var_113_7, var_113_7)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps1073 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_113_3 then
						if arg_110_1.isInRecall_ then
							iter_113_3.color = arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_113_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps1073 = nil
			end

			local var_113_8 = arg_110_1.actors_["1073"].transform
			local var_113_9 = 0

			if var_113_9 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1.var_.moveOldPos1073 = var_113_8.localPosition
				var_113_8.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("1073", 7)

				local var_113_10 = var_113_8.childCount

				for iter_113_4 = 0, var_113_10 - 1 do
					local var_113_11 = var_113_8:GetChild(iter_113_4)

					if var_113_11.name == "" or not string.find(var_113_11.name, "split") then
						var_113_11.gameObject:SetActive(true)
					else
						var_113_11.gameObject:SetActive(false)
					end
				end
			end

			local var_113_12 = 0.001

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_12 then
				local var_113_13 = (arg_110_1.time_ - var_113_9) / var_113_12
				local var_113_14 = Vector3.New(0, -2000, 0)

				var_113_8.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1073, var_113_14, var_113_13)
			end

			if arg_110_1.time_ >= var_113_9 + var_113_12 and arg_110_1.time_ < var_113_9 + var_113_12 + arg_113_0 then
				var_113_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_113_15 = arg_110_1.actors_["10135"].transform
			local var_113_16 = 0

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.var_.moveOldPos10135 = var_113_15.localPosition
				var_113_15.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("10135", 7)

				local var_113_17 = var_113_15.childCount

				for iter_113_5 = 0, var_113_17 - 1 do
					local var_113_18 = var_113_15:GetChild(iter_113_5)

					if var_113_18.name == "" or not string.find(var_113_18.name, "split") then
						var_113_18.gameObject:SetActive(true)
					else
						var_113_18.gameObject:SetActive(false)
					end
				end
			end

			local var_113_19 = 0.001

			if var_113_16 <= arg_110_1.time_ and arg_110_1.time_ < var_113_16 + var_113_19 then
				local var_113_20 = (arg_110_1.time_ - var_113_16) / var_113_19
				local var_113_21 = Vector3.New(0, -2000, 0)

				var_113_15.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10135, var_113_21, var_113_20)
			end

			if arg_110_1.time_ >= var_113_16 + var_113_19 and arg_110_1.time_ < var_113_16 + var_113_19 + arg_113_0 then
				var_113_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_113_22 = 0
			local var_113_23 = 0.375

			if var_113_22 < arg_110_1.time_ and arg_110_1.time_ <= var_113_22 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_24 = arg_110_1:GetWordFromCfg(418021027)
				local var_113_25 = arg_110_1:FormatText(var_113_24.content)

				arg_110_1.text_.text = var_113_25

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_26 = 15
				local var_113_27 = utf8.len(var_113_25)
				local var_113_28 = var_113_26 <= 0 and var_113_23 or var_113_23 * (var_113_27 / var_113_26)

				if var_113_28 > 0 and var_113_23 < var_113_28 then
					arg_110_1.talkMaxDuration = var_113_28

					if var_113_28 + var_113_22 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_28 + var_113_22
					end
				end

				arg_110_1.text_.text = var_113_25
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_29 = math.max(var_113_23, arg_110_1.talkMaxDuration)

			if var_113_22 <= arg_110_1.time_ and arg_110_1.time_ < var_113_22 + var_113_29 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_22) / var_113_29

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_22 + var_113_29 and arg_110_1.time_ < var_113_22 + var_113_29 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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

		arg_110_1:InitPlayNodeList()
	end,
	Play418021028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 418021028
		arg_114_1.duration_ = 10

		local var_114_0 = {
			ja = 10,
			CriLanguages = 7.166,
			zh = 7.166
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play418021029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1073"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps1073 == nil then
				arg_114_1.var_.actorSpriteComps1073 = var_117_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.actorSpriteComps1073 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								local var_117_4 = Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor1.r, var_117_3)
								local var_117_5 = Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor1.g, var_117_3)
								local var_117_6 = Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor1.b, var_117_3)

								iter_117_1.color = Color.New(var_117_4, var_117_5, var_117_6)
							else
								local var_117_7 = Mathf.Lerp(iter_117_1.color.r, 1, var_117_3)

								iter_117_1.color = Color.New(var_117_7, var_117_7, var_117_7)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps1073 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_117_3 then
						if arg_114_1.isInRecall_ then
							iter_117_3.color = arg_114_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_117_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps1073 = nil
			end

			local var_117_8 = arg_114_1.actors_["1073"].transform
			local var_117_9 = 0

			if var_117_9 < arg_114_1.time_ and arg_114_1.time_ <= var_117_9 + arg_117_0 then
				arg_114_1.var_.moveOldPos1073 = var_117_8.localPosition
				var_117_8.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("1073", 2)

				local var_117_10 = var_117_8.childCount

				for iter_117_4 = 0, var_117_10 - 1 do
					local var_117_11 = var_117_8:GetChild(iter_117_4)

					if var_117_11.name == "" or not string.find(var_117_11.name, "split") then
						var_117_11.gameObject:SetActive(true)
					else
						var_117_11.gameObject:SetActive(false)
					end
				end
			end

			local var_117_12 = 0.001

			if var_117_9 <= arg_114_1.time_ and arg_114_1.time_ < var_117_9 + var_117_12 then
				local var_117_13 = (arg_114_1.time_ - var_117_9) / var_117_12
				local var_117_14 = Vector3.New(-405.76, -414.5, -207.2)

				var_117_8.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1073, var_117_14, var_117_13)
			end

			if arg_114_1.time_ >= var_117_9 + var_117_12 and arg_114_1.time_ < var_117_9 + var_117_12 + arg_117_0 then
				var_117_8.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_117_15 = 0
			local var_117_16 = 0.95

			if var_117_15 < arg_114_1.time_ and arg_114_1.time_ <= var_117_15 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_17 = arg_114_1:FormatText(StoryNameCfg[380].name)

				arg_114_1.leftNameTxt_.text = var_117_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_18 = arg_114_1:GetWordFromCfg(418021028)
				local var_117_19 = arg_114_1:FormatText(var_117_18.content)

				arg_114_1.text_.text = var_117_19

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_20 = 38
				local var_117_21 = utf8.len(var_117_19)
				local var_117_22 = var_117_20 <= 0 and var_117_16 or var_117_16 * (var_117_21 / var_117_20)

				if var_117_22 > 0 and var_117_16 < var_117_22 then
					arg_114_1.talkMaxDuration = var_117_22

					if var_117_22 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_22 + var_117_15
					end
				end

				arg_114_1.text_.text = var_117_19
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021028", "story_v_side_old_418021.awb") ~= 0 then
					local var_117_23 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021028", "story_v_side_old_418021.awb") / 1000

					if var_117_23 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_23 + var_117_15
					end

					if var_117_18.prefab_name ~= "" and arg_114_1.actors_[var_117_18.prefab_name] ~= nil then
						local var_117_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_18.prefab_name].transform, "story_v_side_old_418021", "418021028", "story_v_side_old_418021.awb")

						arg_114_1:RecordAudio("418021028", var_117_24)
						arg_114_1:RecordAudio("418021028", var_117_24)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021028", "story_v_side_old_418021.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021028", "story_v_side_old_418021.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_25 = math.max(var_117_16, arg_114_1.talkMaxDuration)

			if var_117_15 <= arg_114_1.time_ and arg_114_1.time_ < var_117_15 + var_117_25 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_15) / var_117_25

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_15 + var_117_25 and arg_114_1.time_ < var_117_15 + var_117_25 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play418021029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 418021029
		arg_118_1.duration_ = 3.23

		local var_118_0 = {
			ja = 3.233,
			CriLanguages = 2.533,
			zh = 2.533
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play418021030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["10135"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps10135 == nil then
				arg_118_1.var_.actorSpriteComps10135 = var_121_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.actorSpriteComps10135 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								local var_121_4 = Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor1.r, var_121_3)
								local var_121_5 = Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor1.g, var_121_3)
								local var_121_6 = Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor1.b, var_121_3)

								iter_121_1.color = Color.New(var_121_4, var_121_5, var_121_6)
							else
								local var_121_7 = Mathf.Lerp(iter_121_1.color.r, 1, var_121_3)

								iter_121_1.color = Color.New(var_121_7, var_121_7, var_121_7)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps10135 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_121_3 then
						if arg_118_1.isInRecall_ then
							iter_121_3.color = arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_121_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps10135 = nil
			end

			local var_121_8 = arg_118_1.actors_["1073"]
			local var_121_9 = 0

			if var_121_9 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 and not isNil(var_121_8) and arg_118_1.var_.actorSpriteComps1073 == nil then
				arg_118_1.var_.actorSpriteComps1073 = var_121_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_10 = 0.2

			if var_121_9 <= arg_118_1.time_ and arg_118_1.time_ < var_121_9 + var_121_10 and not isNil(var_121_8) then
				local var_121_11 = (arg_118_1.time_ - var_121_9) / var_121_10

				if arg_118_1.var_.actorSpriteComps1073 then
					for iter_121_4, iter_121_5 in pairs(arg_118_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_121_5 then
							if arg_118_1.isInRecall_ then
								local var_121_12 = Mathf.Lerp(iter_121_5.color.r, arg_118_1.hightColor2.r, var_121_11)
								local var_121_13 = Mathf.Lerp(iter_121_5.color.g, arg_118_1.hightColor2.g, var_121_11)
								local var_121_14 = Mathf.Lerp(iter_121_5.color.b, arg_118_1.hightColor2.b, var_121_11)

								iter_121_5.color = Color.New(var_121_12, var_121_13, var_121_14)
							else
								local var_121_15 = Mathf.Lerp(iter_121_5.color.r, 0.5, var_121_11)

								iter_121_5.color = Color.New(var_121_15, var_121_15, var_121_15)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= var_121_9 + var_121_10 and arg_118_1.time_ < var_121_9 + var_121_10 + arg_121_0 and not isNil(var_121_8) and arg_118_1.var_.actorSpriteComps1073 then
				for iter_121_6, iter_121_7 in pairs(arg_118_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_121_7 then
						if arg_118_1.isInRecall_ then
							iter_121_7.color = arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_121_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps1073 = nil
			end

			local var_121_16 = arg_118_1.actors_["10135"].transform
			local var_121_17 = 0

			if var_121_17 < arg_118_1.time_ and arg_118_1.time_ <= var_121_17 + arg_121_0 then
				arg_118_1.var_.moveOldPos10135 = var_121_16.localPosition
				var_121_16.localScale = Vector3.New(1, 1, 1)

				arg_118_1:CheckSpriteTmpPos("10135", 4)

				local var_121_18 = var_121_16.childCount

				for iter_121_8 = 0, var_121_18 - 1 do
					local var_121_19 = var_121_16:GetChild(iter_121_8)

					if var_121_19.name == "" or not string.find(var_121_19.name, "split") then
						var_121_19.gameObject:SetActive(true)
					else
						var_121_19.gameObject:SetActive(false)
					end
				end
			end

			local var_121_20 = 0.001

			if var_121_17 <= arg_118_1.time_ and arg_118_1.time_ < var_121_17 + var_121_20 then
				local var_121_21 = (arg_118_1.time_ - var_121_17) / var_121_20
				local var_121_22 = Vector3.New(432.72, -363.6, -305.9)

				var_121_16.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10135, var_121_22, var_121_21)
			end

			if arg_118_1.time_ >= var_121_17 + var_121_20 and arg_118_1.time_ < var_121_17 + var_121_20 + arg_121_0 then
				var_121_16.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_121_23 = 0
			local var_121_24 = 0.3

			if var_121_23 < arg_118_1.time_ and arg_118_1.time_ <= var_121_23 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_25 = arg_118_1:FormatText(StoryNameCfg[1187].name)

				arg_118_1.leftNameTxt_.text = var_121_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_26 = arg_118_1:GetWordFromCfg(418021029)
				local var_121_27 = arg_118_1:FormatText(var_121_26.content)

				arg_118_1.text_.text = var_121_27

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_28 = 12
				local var_121_29 = utf8.len(var_121_27)
				local var_121_30 = var_121_28 <= 0 and var_121_24 or var_121_24 * (var_121_29 / var_121_28)

				if var_121_30 > 0 and var_121_24 < var_121_30 then
					arg_118_1.talkMaxDuration = var_121_30

					if var_121_30 + var_121_23 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_30 + var_121_23
					end
				end

				arg_118_1.text_.text = var_121_27
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021029", "story_v_side_old_418021.awb") ~= 0 then
					local var_121_31 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021029", "story_v_side_old_418021.awb") / 1000

					if var_121_31 + var_121_23 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_31 + var_121_23
					end

					if var_121_26.prefab_name ~= "" and arg_118_1.actors_[var_121_26.prefab_name] ~= nil then
						local var_121_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_26.prefab_name].transform, "story_v_side_old_418021", "418021029", "story_v_side_old_418021.awb")

						arg_118_1:RecordAudio("418021029", var_121_32)
						arg_118_1:RecordAudio("418021029", var_121_32)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021029", "story_v_side_old_418021.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021029", "story_v_side_old_418021.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_33 = math.max(var_121_24, arg_118_1.talkMaxDuration)

			if var_121_23 <= arg_118_1.time_ and arg_118_1.time_ < var_121_23 + var_121_33 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_23) / var_121_33

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_23 + var_121_33 and arg_118_1.time_ < var_121_23 + var_121_33 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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

		arg_118_1:InitPlayNodeList()
	end,
	Play418021030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 418021030
		arg_122_1.duration_ = 3.4

		local var_122_0 = {
			ja = 3.4,
			CriLanguages = 1.666,
			zh = 1.666
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play418021031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1073"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps1073 == nil then
				arg_122_1.var_.actorSpriteComps1073 = var_125_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.actorSpriteComps1073 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								local var_125_4 = Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor1.r, var_125_3)
								local var_125_5 = Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor1.g, var_125_3)
								local var_125_6 = Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor1.b, var_125_3)

								iter_125_1.color = Color.New(var_125_4, var_125_5, var_125_6)
							else
								local var_125_7 = Mathf.Lerp(iter_125_1.color.r, 1, var_125_3)

								iter_125_1.color = Color.New(var_125_7, var_125_7, var_125_7)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps1073 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_125_3 then
						if arg_122_1.isInRecall_ then
							iter_125_3.color = arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_125_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps1073 = nil
			end

			local var_125_8 = arg_122_1.actors_["10135"]
			local var_125_9 = 0

			if var_125_9 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 and not isNil(var_125_8) and arg_122_1.var_.actorSpriteComps10135 == nil then
				arg_122_1.var_.actorSpriteComps10135 = var_125_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_10 = 0.2

			if var_125_9 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_10 and not isNil(var_125_8) then
				local var_125_11 = (arg_122_1.time_ - var_125_9) / var_125_10

				if arg_122_1.var_.actorSpriteComps10135 then
					for iter_125_4, iter_125_5 in pairs(arg_122_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_125_5 then
							if arg_122_1.isInRecall_ then
								local var_125_12 = Mathf.Lerp(iter_125_5.color.r, arg_122_1.hightColor2.r, var_125_11)
								local var_125_13 = Mathf.Lerp(iter_125_5.color.g, arg_122_1.hightColor2.g, var_125_11)
								local var_125_14 = Mathf.Lerp(iter_125_5.color.b, arg_122_1.hightColor2.b, var_125_11)

								iter_125_5.color = Color.New(var_125_12, var_125_13, var_125_14)
							else
								local var_125_15 = Mathf.Lerp(iter_125_5.color.r, 0.5, var_125_11)

								iter_125_5.color = Color.New(var_125_15, var_125_15, var_125_15)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_9 + var_125_10 and arg_122_1.time_ < var_125_9 + var_125_10 + arg_125_0 and not isNil(var_125_8) and arg_122_1.var_.actorSpriteComps10135 then
				for iter_125_6, iter_125_7 in pairs(arg_122_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_125_7 then
						if arg_122_1.isInRecall_ then
							iter_125_7.color = arg_122_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_125_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps10135 = nil
			end

			local var_125_16 = 0
			local var_125_17 = 0.2

			if var_125_16 < arg_122_1.time_ and arg_122_1.time_ <= var_125_16 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_18 = arg_122_1:FormatText(StoryNameCfg[380].name)

				arg_122_1.leftNameTxt_.text = var_125_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_19 = arg_122_1:GetWordFromCfg(418021030)
				local var_125_20 = arg_122_1:FormatText(var_125_19.content)

				arg_122_1.text_.text = var_125_20

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_21 = 8
				local var_125_22 = utf8.len(var_125_20)
				local var_125_23 = var_125_21 <= 0 and var_125_17 or var_125_17 * (var_125_22 / var_125_21)

				if var_125_23 > 0 and var_125_17 < var_125_23 then
					arg_122_1.talkMaxDuration = var_125_23

					if var_125_23 + var_125_16 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_23 + var_125_16
					end
				end

				arg_122_1.text_.text = var_125_20
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021030", "story_v_side_old_418021.awb") ~= 0 then
					local var_125_24 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021030", "story_v_side_old_418021.awb") / 1000

					if var_125_24 + var_125_16 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_24 + var_125_16
					end

					if var_125_19.prefab_name ~= "" and arg_122_1.actors_[var_125_19.prefab_name] ~= nil then
						local var_125_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_19.prefab_name].transform, "story_v_side_old_418021", "418021030", "story_v_side_old_418021.awb")

						arg_122_1:RecordAudio("418021030", var_125_25)
						arg_122_1:RecordAudio("418021030", var_125_25)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021030", "story_v_side_old_418021.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021030", "story_v_side_old_418021.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_26 = math.max(var_125_17, arg_122_1.talkMaxDuration)

			if var_125_16 <= arg_122_1.time_ and arg_122_1.time_ < var_125_16 + var_125_26 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_16) / var_125_26

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_16 + var_125_26 and arg_122_1.time_ < var_125_16 + var_125_26 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play418021031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 418021031
		arg_126_1.duration_ = 6.77

		local var_126_0 = {
			ja = 6.766,
			CriLanguages = 5.533,
			zh = 5.533
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play418021032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["10135"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps10135 == nil then
				arg_126_1.var_.actorSpriteComps10135 = var_129_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_2 = 0.2

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.actorSpriteComps10135 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								local var_129_4 = Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor1.r, var_129_3)
								local var_129_5 = Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor1.g, var_129_3)
								local var_129_6 = Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor1.b, var_129_3)

								iter_129_1.color = Color.New(var_129_4, var_129_5, var_129_6)
							else
								local var_129_7 = Mathf.Lerp(iter_129_1.color.r, 1, var_129_3)

								iter_129_1.color = Color.New(var_129_7, var_129_7, var_129_7)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps10135 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_129_3 then
						if arg_126_1.isInRecall_ then
							iter_129_3.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_129_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps10135 = nil
			end

			local var_129_8 = arg_126_1.actors_["1073"]
			local var_129_9 = 0

			if var_129_9 < arg_126_1.time_ and arg_126_1.time_ <= var_129_9 + arg_129_0 and not isNil(var_129_8) and arg_126_1.var_.actorSpriteComps1073 == nil then
				arg_126_1.var_.actorSpriteComps1073 = var_129_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_10 = 0.2

			if var_129_9 <= arg_126_1.time_ and arg_126_1.time_ < var_129_9 + var_129_10 and not isNil(var_129_8) then
				local var_129_11 = (arg_126_1.time_ - var_129_9) / var_129_10

				if arg_126_1.var_.actorSpriteComps1073 then
					for iter_129_4, iter_129_5 in pairs(arg_126_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_129_5 then
							if arg_126_1.isInRecall_ then
								local var_129_12 = Mathf.Lerp(iter_129_5.color.r, arg_126_1.hightColor2.r, var_129_11)
								local var_129_13 = Mathf.Lerp(iter_129_5.color.g, arg_126_1.hightColor2.g, var_129_11)
								local var_129_14 = Mathf.Lerp(iter_129_5.color.b, arg_126_1.hightColor2.b, var_129_11)

								iter_129_5.color = Color.New(var_129_12, var_129_13, var_129_14)
							else
								local var_129_15 = Mathf.Lerp(iter_129_5.color.r, 0.5, var_129_11)

								iter_129_5.color = Color.New(var_129_15, var_129_15, var_129_15)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_9 + var_129_10 and arg_126_1.time_ < var_129_9 + var_129_10 + arg_129_0 and not isNil(var_129_8) and arg_126_1.var_.actorSpriteComps1073 then
				for iter_129_6, iter_129_7 in pairs(arg_126_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_129_7 then
						if arg_126_1.isInRecall_ then
							iter_129_7.color = arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_129_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps1073 = nil
			end

			local var_129_16 = 0
			local var_129_17 = 0.675

			if var_129_16 < arg_126_1.time_ and arg_126_1.time_ <= var_129_16 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_18 = arg_126_1:FormatText(StoryNameCfg[1187].name)

				arg_126_1.leftNameTxt_.text = var_129_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_19 = arg_126_1:GetWordFromCfg(418021031)
				local var_129_20 = arg_126_1:FormatText(var_129_19.content)

				arg_126_1.text_.text = var_129_20

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_21 = 27
				local var_129_22 = utf8.len(var_129_20)
				local var_129_23 = var_129_21 <= 0 and var_129_17 or var_129_17 * (var_129_22 / var_129_21)

				if var_129_23 > 0 and var_129_17 < var_129_23 then
					arg_126_1.talkMaxDuration = var_129_23

					if var_129_23 + var_129_16 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_23 + var_129_16
					end
				end

				arg_126_1.text_.text = var_129_20
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021031", "story_v_side_old_418021.awb") ~= 0 then
					local var_129_24 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021031", "story_v_side_old_418021.awb") / 1000

					if var_129_24 + var_129_16 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_24 + var_129_16
					end

					if var_129_19.prefab_name ~= "" and arg_126_1.actors_[var_129_19.prefab_name] ~= nil then
						local var_129_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_19.prefab_name].transform, "story_v_side_old_418021", "418021031", "story_v_side_old_418021.awb")

						arg_126_1:RecordAudio("418021031", var_129_25)
						arg_126_1:RecordAudio("418021031", var_129_25)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021031", "story_v_side_old_418021.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021031", "story_v_side_old_418021.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_26 = math.max(var_129_17, arg_126_1.talkMaxDuration)

			if var_129_16 <= arg_126_1.time_ and arg_126_1.time_ < var_129_16 + var_129_26 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_16) / var_129_26

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_16 + var_129_26 and arg_126_1.time_ < var_129_16 + var_129_26 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play418021032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 418021032
		arg_130_1.duration_ = 4.9

		local var_130_0 = {
			ja = 4.9,
			CriLanguages = 3.466,
			zh = 3.466
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play418021033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10135"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos10135 = var_133_0.localPosition
				var_133_0.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("10135", 4)

				local var_133_2 = var_133_0.childCount

				for iter_133_0 = 0, var_133_2 - 1 do
					local var_133_3 = var_133_0:GetChild(iter_133_0)

					if var_133_3.name == "" or not string.find(var_133_3.name, "split") then
						var_133_3.gameObject:SetActive(true)
					else
						var_133_3.gameObject:SetActive(false)
					end
				end
			end

			local var_133_4 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_4 then
				local var_133_5 = (arg_130_1.time_ - var_133_1) / var_133_4
				local var_133_6 = Vector3.New(432.72, -363.6, -305.9)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10135, var_133_6, var_133_5)
			end

			if arg_130_1.time_ >= var_133_1 + var_133_4 and arg_130_1.time_ < var_133_1 + var_133_4 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_133_7 = 0
			local var_133_8 = 0.5

			if var_133_7 < arg_130_1.time_ and arg_130_1.time_ <= var_133_7 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_9 = arg_130_1:FormatText(StoryNameCfg[1187].name)

				arg_130_1.leftNameTxt_.text = var_133_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_10 = arg_130_1:GetWordFromCfg(418021032)
				local var_133_11 = arg_130_1:FormatText(var_133_10.content)

				arg_130_1.text_.text = var_133_11

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_12 = 20
				local var_133_13 = utf8.len(var_133_11)
				local var_133_14 = var_133_12 <= 0 and var_133_8 or var_133_8 * (var_133_13 / var_133_12)

				if var_133_14 > 0 and var_133_8 < var_133_14 then
					arg_130_1.talkMaxDuration = var_133_14

					if var_133_14 + var_133_7 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_14 + var_133_7
					end
				end

				arg_130_1.text_.text = var_133_11
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021032", "story_v_side_old_418021.awb") ~= 0 then
					local var_133_15 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021032", "story_v_side_old_418021.awb") / 1000

					if var_133_15 + var_133_7 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_15 + var_133_7
					end

					if var_133_10.prefab_name ~= "" and arg_130_1.actors_[var_133_10.prefab_name] ~= nil then
						local var_133_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_10.prefab_name].transform, "story_v_side_old_418021", "418021032", "story_v_side_old_418021.awb")

						arg_130_1:RecordAudio("418021032", var_133_16)
						arg_130_1:RecordAudio("418021032", var_133_16)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021032", "story_v_side_old_418021.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021032", "story_v_side_old_418021.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_17 = math.max(var_133_8, arg_130_1.talkMaxDuration)

			if var_133_7 <= arg_130_1.time_ and arg_130_1.time_ < var_133_7 + var_133_17 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_7) / var_133_17

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_7 + var_133_17 and arg_130_1.time_ < var_133_7 + var_133_17 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play418021033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 418021033
		arg_134_1.duration_ = 3.57

		local var_134_0 = {
			ja = 2.666,
			CriLanguages = 3.566,
			zh = 3.566
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
			arg_134_1.auto_ = false
		end

		function arg_134_1.playNext_(arg_136_0)
			arg_134_1.onStoryFinished_()
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1073"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps1073 == nil then
				arg_134_1.var_.actorSpriteComps1073 = var_137_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_2 = 0.2

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.actorSpriteComps1073 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								local var_137_4 = Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor1.r, var_137_3)
								local var_137_5 = Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor1.g, var_137_3)
								local var_137_6 = Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor1.b, var_137_3)

								iter_137_1.color = Color.New(var_137_4, var_137_5, var_137_6)
							else
								local var_137_7 = Mathf.Lerp(iter_137_1.color.r, 1, var_137_3)

								iter_137_1.color = Color.New(var_137_7, var_137_7, var_137_7)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps1073 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_137_3 then
						if arg_134_1.isInRecall_ then
							iter_137_3.color = arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_137_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps1073 = nil
			end

			local var_137_8 = arg_134_1.actors_["10135"]
			local var_137_9 = 0

			if var_137_9 < arg_134_1.time_ and arg_134_1.time_ <= var_137_9 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.actorSpriteComps10135 == nil then
				arg_134_1.var_.actorSpriteComps10135 = var_137_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_10 = 0.2

			if var_137_9 <= arg_134_1.time_ and arg_134_1.time_ < var_137_9 + var_137_10 and not isNil(var_137_8) then
				local var_137_11 = (arg_134_1.time_ - var_137_9) / var_137_10

				if arg_134_1.var_.actorSpriteComps10135 then
					for iter_137_4, iter_137_5 in pairs(arg_134_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_137_5 then
							if arg_134_1.isInRecall_ then
								local var_137_12 = Mathf.Lerp(iter_137_5.color.r, arg_134_1.hightColor2.r, var_137_11)
								local var_137_13 = Mathf.Lerp(iter_137_5.color.g, arg_134_1.hightColor2.g, var_137_11)
								local var_137_14 = Mathf.Lerp(iter_137_5.color.b, arg_134_1.hightColor2.b, var_137_11)

								iter_137_5.color = Color.New(var_137_12, var_137_13, var_137_14)
							else
								local var_137_15 = Mathf.Lerp(iter_137_5.color.r, 0.5, var_137_11)

								iter_137_5.color = Color.New(var_137_15, var_137_15, var_137_15)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_9 + var_137_10 and arg_134_1.time_ < var_137_9 + var_137_10 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.actorSpriteComps10135 then
				for iter_137_6, iter_137_7 in pairs(arg_134_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_137_7 then
						if arg_134_1.isInRecall_ then
							iter_137_7.color = arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_137_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps10135 = nil
			end

			local var_137_16 = arg_134_1.actors_["1073"].transform
			local var_137_17 = 0

			if var_137_17 < arg_134_1.time_ and arg_134_1.time_ <= var_137_17 + arg_137_0 then
				arg_134_1.var_.moveOldPos1073 = var_137_16.localPosition
				var_137_16.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("1073", 2)

				local var_137_18 = var_137_16.childCount

				for iter_137_8 = 0, var_137_18 - 1 do
					local var_137_19 = var_137_16:GetChild(iter_137_8)

					if var_137_19.name == "" or not string.find(var_137_19.name, "split") then
						var_137_19.gameObject:SetActive(true)
					else
						var_137_19.gameObject:SetActive(false)
					end
				end
			end

			local var_137_20 = 0.001

			if var_137_17 <= arg_134_1.time_ and arg_134_1.time_ < var_137_17 + var_137_20 then
				local var_137_21 = (arg_134_1.time_ - var_137_17) / var_137_20
				local var_137_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_137_16.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1073, var_137_22, var_137_21)
			end

			if arg_134_1.time_ >= var_137_17 + var_137_20 and arg_134_1.time_ < var_137_17 + var_137_20 + arg_137_0 then
				var_137_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_137_23 = 0
			local var_137_24 = 0.225

			if var_137_23 < arg_134_1.time_ and arg_134_1.time_ <= var_137_23 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_25 = arg_134_1:FormatText(StoryNameCfg[380].name)

				arg_134_1.leftNameTxt_.text = var_137_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_26 = arg_134_1:GetWordFromCfg(418021033)
				local var_137_27 = arg_134_1:FormatText(var_137_26.content)

				arg_134_1.text_.text = var_137_27

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_28 = 9
				local var_137_29 = utf8.len(var_137_27)
				local var_137_30 = var_137_28 <= 0 and var_137_24 or var_137_24 * (var_137_29 / var_137_28)

				if var_137_30 > 0 and var_137_24 < var_137_30 then
					arg_134_1.talkMaxDuration = var_137_30

					if var_137_30 + var_137_23 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_30 + var_137_23
					end
				end

				arg_134_1.text_.text = var_137_27
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418021", "418021033", "story_v_side_old_418021.awb") ~= 0 then
					local var_137_31 = manager.audio:GetVoiceLength("story_v_side_old_418021", "418021033", "story_v_side_old_418021.awb") / 1000

					if var_137_31 + var_137_23 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_31 + var_137_23
					end

					if var_137_26.prefab_name ~= "" and arg_134_1.actors_[var_137_26.prefab_name] ~= nil then
						local var_137_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_26.prefab_name].transform, "story_v_side_old_418021", "418021033", "story_v_side_old_418021.awb")

						arg_134_1:RecordAudio("418021033", var_137_32)
						arg_134_1:RecordAudio("418021033", var_137_32)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_side_old_418021", "418021033", "story_v_side_old_418021.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_side_old_418021", "418021033", "story_v_side_old_418021.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_33 = math.max(var_137_24, arg_134_1.talkMaxDuration)

			if var_137_23 <= arg_134_1.time_ and arg_134_1.time_ < var_137_23 + var_137_33 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_23) / var_137_33

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_23 + var_137_33 and arg_134_1.time_ < var_137_23 + var_137_33 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
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

		arg_134_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST1002"
	},
	voices = {
		"story_v_side_old_418021.awb"
	}
}
