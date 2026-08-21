return {
	Play418011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play418011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "H01a"

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
				local var_4_5 = arg_1_1.bgs_.H01a

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
					if iter_4_0 ~= "H01a" then
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

			local var_4_24 = 0.4
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily.awb")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily")

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

			local var_4_30 = 0.05
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_140", "se_story_140_amb_ship", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 1.15

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(418011001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 46
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play418011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418011002
		arg_8_1.duration_ = 8.6

		local var_8_0 = {
			ja = 4.866,
			CriLanguages = 8.6,
			zh = 8.6
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
				arg_8_0:Play418011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1071"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1071")

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

			local var_11_4 = arg_8_1.actors_["1071"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps1071 == nil then
				arg_8_1.var_.actorSpriteComps1071 = var_11_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.actorSpriteComps1071 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps1071 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_11_5 then
						if arg_8_1.isInRecall_ then
							iter_11_5.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_11_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps1071 = nil
			end

			local var_11_12 = arg_8_1.actors_["1071"].transform
			local var_11_13 = 0

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 then
				arg_8_1.var_.moveOldPos1071 = var_11_12.localPosition
				var_11_12.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("1071", 3)

				local var_11_14 = var_11_12.childCount

				for iter_11_6 = 0, var_11_14 - 1 do
					local var_11_15 = var_11_12:GetChild(iter_11_6)

					if var_11_15.name == "split_5" or not string.find(var_11_15.name, "split") then
						var_11_15.gameObject:SetActive(true)
					else
						var_11_15.gameObject:SetActive(false)
					end
				end
			end

			local var_11_16 = 0.001

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_16 then
				local var_11_17 = (arg_8_1.time_ - var_11_13) / var_11_16
				local var_11_18 = Vector3.New(13.6, -392.9, -306.6)

				var_11_12.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1071, var_11_18, var_11_17)
			end

			if arg_8_1.time_ >= var_11_13 + var_11_16 and arg_8_1.time_ < var_11_13 + var_11_16 + arg_11_0 then
				var_11_12.localPosition = Vector3.New(13.6, -392.9, -306.6)
			end

			local var_11_19 = arg_8_1.actors_["1071"].transform
			local var_11_20 = 0

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.var_.moveOldPos1071 = var_11_19.localPosition
				var_11_19.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("1071", 3)

				local var_11_21 = var_11_19.childCount

				for iter_11_7 = 0, var_11_21 - 1 do
					local var_11_22 = var_11_19:GetChild(iter_11_7)

					if var_11_22.name == "split_8" or not string.find(var_11_22.name, "split") then
						var_11_22.gameObject:SetActive(true)
					else
						var_11_22.gameObject:SetActive(false)
					end
				end
			end

			local var_11_23 = 0.001

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_23 then
				local var_11_24 = (arg_8_1.time_ - var_11_20) / var_11_23
				local var_11_25 = Vector3.New(13.6, -392.9, -306.6)

				var_11_19.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1071, var_11_25, var_11_24)
			end

			if arg_8_1.time_ >= var_11_20 + var_11_23 and arg_8_1.time_ < var_11_20 + var_11_23 + arg_11_0 then
				var_11_19.localPosition = Vector3.New(13.6, -392.9, -306.6)
			end

			local var_11_26 = 0
			local var_11_27 = 0.55

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_28 = arg_8_1:FormatText(StoryNameCfg[384].name)

				arg_8_1.leftNameTxt_.text = var_11_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_29 = arg_8_1:GetWordFromCfg(418011002)
				local var_11_30 = arg_8_1:FormatText(var_11_29.content)

				arg_8_1.text_.text = var_11_30

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_31 = 22
				local var_11_32 = utf8.len(var_11_30)
				local var_11_33 = var_11_31 <= 0 and var_11_27 or var_11_27 * (var_11_32 / var_11_31)

				if var_11_33 > 0 and var_11_27 < var_11_33 then
					arg_8_1.talkMaxDuration = var_11_33

					if var_11_33 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_33 + var_11_26
					end
				end

				arg_8_1.text_.text = var_11_30
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011002", "story_v_side_old_418011.awb") ~= 0 then
					local var_11_34 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011002", "story_v_side_old_418011.awb") / 1000

					if var_11_34 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_26
					end

					if var_11_29.prefab_name ~= "" and arg_8_1.actors_[var_11_29.prefab_name] ~= nil then
						local var_11_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_29.prefab_name].transform, "story_v_side_old_418011", "418011002", "story_v_side_old_418011.awb")

						arg_8_1:RecordAudio("418011002", var_11_35)
						arg_8_1:RecordAudio("418011002", var_11_35)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011002", "story_v_side_old_418011.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011002", "story_v_side_old_418011.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_36 = math.max(var_11_27, arg_8_1.talkMaxDuration)

			if var_11_26 <= arg_8_1.time_ and arg_8_1.time_ < var_11_26 + var_11_36 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_26) / var_11_36

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_26 + var_11_36 and arg_8_1.time_ < var_11_26 + var_11_36 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1071",
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
	Play418011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418011003
		arg_12_1.duration_ = 5.8

		local var_12_0 = {
			ja = 5.8,
			CriLanguages = 3.5,
			zh = 3.5
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
				arg_12_0:Play418011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1073"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1073")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(var_15_1, arg_12_1.canvasGo_.transform)

					var_15_2.transform:SetSiblingIndex(1)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_12_1.isInRecall_ then
						for iter_15_0, iter_15_1 in ipairs(var_15_3) do
							iter_15_1.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_15_4 = arg_12_1.actors_["1073"]
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.actorSpriteComps1073 == nil then
				arg_12_1.var_.actorSpriteComps1073 = var_15_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_6 = 0.2

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 and not isNil(var_15_4) then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6

				if arg_12_1.var_.actorSpriteComps1073 then
					for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_15_3 then
							if arg_12_1.isInRecall_ then
								local var_15_8 = Mathf.Lerp(iter_15_3.color.r, arg_12_1.hightColor1.r, var_15_7)
								local var_15_9 = Mathf.Lerp(iter_15_3.color.g, arg_12_1.hightColor1.g, var_15_7)
								local var_15_10 = Mathf.Lerp(iter_15_3.color.b, arg_12_1.hightColor1.b, var_15_7)

								iter_15_3.color = Color.New(var_15_8, var_15_9, var_15_10)
							else
								local var_15_11 = Mathf.Lerp(iter_15_3.color.r, 1, var_15_7)

								iter_15_3.color = Color.New(var_15_11, var_15_11, var_15_11)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.actorSpriteComps1073 then
				for iter_15_4, iter_15_5 in pairs(arg_12_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_15_5 then
						if arg_12_1.isInRecall_ then
							iter_15_5.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_15_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps1073 = nil
			end

			local var_15_12 = arg_12_1.actors_["1071"]
			local var_15_13 = 0

			if var_15_13 < arg_12_1.time_ and arg_12_1.time_ <= var_15_13 + arg_15_0 and not isNil(var_15_12) and arg_12_1.var_.actorSpriteComps1071 == nil then
				arg_12_1.var_.actorSpriteComps1071 = var_15_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_14 = 0.2

			if var_15_13 <= arg_12_1.time_ and arg_12_1.time_ < var_15_13 + var_15_14 and not isNil(var_15_12) then
				local var_15_15 = (arg_12_1.time_ - var_15_13) / var_15_14

				if arg_12_1.var_.actorSpriteComps1071 then
					for iter_15_6, iter_15_7 in pairs(arg_12_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_15_7 then
							if arg_12_1.isInRecall_ then
								local var_15_16 = Mathf.Lerp(iter_15_7.color.r, arg_12_1.hightColor2.r, var_15_15)
								local var_15_17 = Mathf.Lerp(iter_15_7.color.g, arg_12_1.hightColor2.g, var_15_15)
								local var_15_18 = Mathf.Lerp(iter_15_7.color.b, arg_12_1.hightColor2.b, var_15_15)

								iter_15_7.color = Color.New(var_15_16, var_15_17, var_15_18)
							else
								local var_15_19 = Mathf.Lerp(iter_15_7.color.r, 0.5, var_15_15)

								iter_15_7.color = Color.New(var_15_19, var_15_19, var_15_19)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_13 + var_15_14 and arg_12_1.time_ < var_15_13 + var_15_14 + arg_15_0 and not isNil(var_15_12) and arg_12_1.var_.actorSpriteComps1071 then
				for iter_15_8, iter_15_9 in pairs(arg_12_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_15_9 then
						if arg_12_1.isInRecall_ then
							iter_15_9.color = arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_15_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps1071 = nil
			end

			local var_15_20 = arg_12_1.actors_["1071"].transform
			local var_15_21 = 0

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1.var_.moveOldPos1071 = var_15_20.localPosition
				var_15_20.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("1071", 4)

				local var_15_22 = var_15_20.childCount

				for iter_15_10 = 0, var_15_22 - 1 do
					local var_15_23 = var_15_20:GetChild(iter_15_10)

					if var_15_23.name == "split_8" or not string.find(var_15_23.name, "split") then
						var_15_23.gameObject:SetActive(true)
					else
						var_15_23.gameObject:SetActive(false)
					end
				end
			end

			local var_15_24 = 0.001

			if var_15_21 <= arg_12_1.time_ and arg_12_1.time_ < var_15_21 + var_15_24 then
				local var_15_25 = (arg_12_1.time_ - var_15_21) / var_15_24
				local var_15_26 = Vector3.New(519.94, -392.9, -306.6)

				var_15_20.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1071, var_15_26, var_15_25)
			end

			if arg_12_1.time_ >= var_15_21 + var_15_24 and arg_12_1.time_ < var_15_21 + var_15_24 + arg_15_0 then
				var_15_20.localPosition = Vector3.New(519.94, -392.9, -306.6)
			end

			local var_15_27 = arg_12_1.actors_["1073"].transform
			local var_15_28 = 0

			if var_15_28 < arg_12_1.time_ and arg_12_1.time_ <= var_15_28 + arg_15_0 then
				arg_12_1.var_.moveOldPos1073 = var_15_27.localPosition
				var_15_27.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("1073", 2)

				local var_15_29 = var_15_27.childCount

				for iter_15_11 = 0, var_15_29 - 1 do
					local var_15_30 = var_15_27:GetChild(iter_15_11)

					if var_15_30.name == "" or not string.find(var_15_30.name, "split") then
						var_15_30.gameObject:SetActive(true)
					else
						var_15_30.gameObject:SetActive(false)
					end
				end
			end

			local var_15_31 = 0.001

			if var_15_28 <= arg_12_1.time_ and arg_12_1.time_ < var_15_28 + var_15_31 then
				local var_15_32 = (arg_12_1.time_ - var_15_28) / var_15_31
				local var_15_33 = Vector3.New(-405.76, -414.5, -207.2)

				var_15_27.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1073, var_15_33, var_15_32)
			end

			if arg_12_1.time_ >= var_15_28 + var_15_31 and arg_12_1.time_ < var_15_28 + var_15_31 + arg_15_0 then
				var_15_27.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_15_34 = 0
			local var_15_35 = 0.525

			if var_15_34 < arg_12_1.time_ and arg_12_1.time_ <= var_15_34 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_36 = arg_12_1:FormatText(StoryNameCfg[380].name)

				arg_12_1.leftNameTxt_.text = var_15_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_37 = arg_12_1:GetWordFromCfg(418011003)
				local var_15_38 = arg_12_1:FormatText(var_15_37.content)

				arg_12_1.text_.text = var_15_38

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_39 = 21
				local var_15_40 = utf8.len(var_15_38)
				local var_15_41 = var_15_39 <= 0 and var_15_35 or var_15_35 * (var_15_40 / var_15_39)

				if var_15_41 > 0 and var_15_35 < var_15_41 then
					arg_12_1.talkMaxDuration = var_15_41

					if var_15_41 + var_15_34 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_41 + var_15_34
					end
				end

				arg_12_1.text_.text = var_15_38
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011003", "story_v_side_old_418011.awb") ~= 0 then
					local var_15_42 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011003", "story_v_side_old_418011.awb") / 1000

					if var_15_42 + var_15_34 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_42 + var_15_34
					end

					if var_15_37.prefab_name ~= "" and arg_12_1.actors_[var_15_37.prefab_name] ~= nil then
						local var_15_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_37.prefab_name].transform, "story_v_side_old_418011", "418011003", "story_v_side_old_418011.awb")

						arg_12_1:RecordAudio("418011003", var_15_43)
						arg_12_1:RecordAudio("418011003", var_15_43)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011003", "story_v_side_old_418011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011003", "story_v_side_old_418011.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_44 = math.max(var_15_35, arg_12_1.talkMaxDuration)

			if var_15_34 <= arg_12_1.time_ and arg_12_1.time_ < var_15_34 + var_15_44 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_34) / var_15_44

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_34 + var_15_44 and arg_12_1.time_ < var_15_34 + var_15_44 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071",
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

		arg_12_1:InitPlayNodeList()
	end,
	Play418011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418011004
		arg_16_1.duration_ = 3.07

		local var_16_0 = {
			ja = 3.066,
			CriLanguages = 2.166,
			zh = 2.166
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
				arg_16_0:Play418011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1071"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps1071 == nil then
				arg_16_1.var_.actorSpriteComps1071 = var_19_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.actorSpriteComps1071 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps1071 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_19_3 then
						if arg_16_1.isInRecall_ then
							iter_19_3.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_19_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps1071 = nil
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

			local var_19_16 = arg_16_1.actors_["1071"].transform
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.var_.moveOldPos1071 = var_19_16.localPosition
				var_19_16.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("1071", 4)

				local var_19_18 = var_19_16.childCount

				for iter_19_8 = 0, var_19_18 - 1 do
					local var_19_19 = var_19_16:GetChild(iter_19_8)

					if var_19_19.name == "split_1" or not string.find(var_19_19.name, "split") then
						var_19_19.gameObject:SetActive(true)
					else
						var_19_19.gameObject:SetActive(false)
					end
				end
			end

			local var_19_20 = 0.001

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_20 then
				local var_19_21 = (arg_16_1.time_ - var_19_17) / var_19_20
				local var_19_22 = Vector3.New(519.94, -392.9, -306.6)

				var_19_16.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1071, var_19_22, var_19_21)
			end

			if arg_16_1.time_ >= var_19_17 + var_19_20 and arg_16_1.time_ < var_19_17 + var_19_20 + arg_19_0 then
				var_19_16.localPosition = Vector3.New(519.94, -392.9, -306.6)
			end

			local var_19_23 = 0
			local var_19_24 = 0.275

			if var_19_23 < arg_16_1.time_ and arg_16_1.time_ <= var_19_23 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_25 = arg_16_1:FormatText(StoryNameCfg[384].name)

				arg_16_1.leftNameTxt_.text = var_19_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_26 = arg_16_1:GetWordFromCfg(418011004)
				local var_19_27 = arg_16_1:FormatText(var_19_26.content)

				arg_16_1.text_.text = var_19_27

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_28 = 11
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011004", "story_v_side_old_418011.awb") ~= 0 then
					local var_19_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011004", "story_v_side_old_418011.awb") / 1000

					if var_19_31 + var_19_23 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_31 + var_19_23
					end

					if var_19_26.prefab_name ~= "" and arg_16_1.actors_[var_19_26.prefab_name] ~= nil then
						local var_19_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_26.prefab_name].transform, "story_v_side_old_418011", "418011004", "story_v_side_old_418011.awb")

						arg_16_1:RecordAudio("418011004", var_19_32)
						arg_16_1:RecordAudio("418011004", var_19_32)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011004", "story_v_side_old_418011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011004", "story_v_side_old_418011.awb")
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
				actorName = "1071",
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
	Play418011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418011005
		arg_20_1.duration_ = 13.23

		local var_20_0 = {
			ja = 13.233,
			CriLanguages = 10.4,
			zh = 10.4
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
				arg_20_0:Play418011006(arg_20_1)
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

			local var_23_8 = arg_20_1.actors_["1071"]
			local var_23_9 = 0

			if var_23_9 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 and not isNil(var_23_8) and arg_20_1.var_.actorSpriteComps1071 == nil then
				arg_20_1.var_.actorSpriteComps1071 = var_23_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_10 = 0.2

			if var_23_9 <= arg_20_1.time_ and arg_20_1.time_ < var_23_9 + var_23_10 and not isNil(var_23_8) then
				local var_23_11 = (arg_20_1.time_ - var_23_9) / var_23_10

				if arg_20_1.var_.actorSpriteComps1071 then
					for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_20_1.time_ >= var_23_9 + var_23_10 and arg_20_1.time_ < var_23_9 + var_23_10 + arg_23_0 and not isNil(var_23_8) and arg_20_1.var_.actorSpriteComps1071 then
				for iter_23_6, iter_23_7 in pairs(arg_20_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_23_7 then
						if arg_20_1.isInRecall_ then
							iter_23_7.color = arg_20_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_23_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps1071 = nil
			end

			local var_23_16 = 0
			local var_23_17 = 1.3

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_18 = arg_20_1:FormatText(StoryNameCfg[380].name)

				arg_20_1.leftNameTxt_.text = var_23_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_19 = arg_20_1:GetWordFromCfg(418011005)
				local var_23_20 = arg_20_1:FormatText(var_23_19.content)

				arg_20_1.text_.text = var_23_20

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 52
				local var_23_22 = utf8.len(var_23_20)
				local var_23_23 = var_23_21 <= 0 and var_23_17 or var_23_17 * (var_23_22 / var_23_21)

				if var_23_23 > 0 and var_23_17 < var_23_23 then
					arg_20_1.talkMaxDuration = var_23_23

					if var_23_23 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_16
					end
				end

				arg_20_1.text_.text = var_23_20
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011005", "story_v_side_old_418011.awb") ~= 0 then
					local var_23_24 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011005", "story_v_side_old_418011.awb") / 1000

					if var_23_24 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_24 + var_23_16
					end

					if var_23_19.prefab_name ~= "" and arg_20_1.actors_[var_23_19.prefab_name] ~= nil then
						local var_23_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_19.prefab_name].transform, "story_v_side_old_418011", "418011005", "story_v_side_old_418011.awb")

						arg_20_1:RecordAudio("418011005", var_23_25)
						arg_20_1:RecordAudio("418011005", var_23_25)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011005", "story_v_side_old_418011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011005", "story_v_side_old_418011.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_26 = math.max(var_23_17, arg_20_1.talkMaxDuration)

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_26 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_16) / var_23_26

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_16 + var_23_26 and arg_20_1.time_ < var_23_16 + var_23_26 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play418011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418011006
		arg_24_1.duration_ = 7.1

		local var_24_0 = {
			ja = 7.1,
			CriLanguages = 3.433,
			zh = 3.433
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
				arg_24_0:Play418011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1071"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps1071 == nil then
				arg_24_1.var_.actorSpriteComps1071 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps1071 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps1071 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_27_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps1071 = nil
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

			local var_27_16 = arg_24_1.actors_["1071"].transform
			local var_27_17 = 0

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 then
				arg_24_1.var_.moveOldPos1071 = var_27_16.localPosition
				var_27_16.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("1071", 4)

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
				local var_27_22 = Vector3.New(519.94, -392.9, -306.6)

				var_27_16.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1071, var_27_22, var_27_21)
			end

			if arg_24_1.time_ >= var_27_17 + var_27_20 and arg_24_1.time_ < var_27_17 + var_27_20 + arg_27_0 then
				var_27_16.localPosition = Vector3.New(519.94, -392.9, -306.6)
			end

			local var_27_23 = 0
			local var_27_24 = 0.375

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_25 = arg_24_1:FormatText(StoryNameCfg[384].name)

				arg_24_1.leftNameTxt_.text = var_27_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_26 = arg_24_1:GetWordFromCfg(418011006)
				local var_27_27 = arg_24_1:FormatText(var_27_26.content)

				arg_24_1.text_.text = var_27_27

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_28 = 15
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011006", "story_v_side_old_418011.awb") ~= 0 then
					local var_27_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011006", "story_v_side_old_418011.awb") / 1000

					if var_27_31 + var_27_23 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_31 + var_27_23
					end

					if var_27_26.prefab_name ~= "" and arg_24_1.actors_[var_27_26.prefab_name] ~= nil then
						local var_27_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_26.prefab_name].transform, "story_v_side_old_418011", "418011006", "story_v_side_old_418011.awb")

						arg_24_1:RecordAudio("418011006", var_27_32)
						arg_24_1:RecordAudio("418011006", var_27_32)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011006", "story_v_side_old_418011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011006", "story_v_side_old_418011.awb")
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
				actorName = "1071",
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
	Play418011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 418011007
		arg_28_1.duration_ = 7.67

		local var_28_0 = {
			ja = 7.666,
			CriLanguages = 4.766,
			zh = 4.766
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
				arg_28_0:Play418011008(arg_28_1)
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

			local var_31_8 = arg_28_1.actors_["1071"]
			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.actorSpriteComps1071 == nil then
				arg_28_1.var_.actorSpriteComps1071 = var_31_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_10 = 0.2

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 and not isNil(var_31_8) then
				local var_31_11 = (arg_28_1.time_ - var_31_9) / var_31_10

				if arg_28_1.var_.actorSpriteComps1071 then
					for iter_31_4, iter_31_5 in pairs(arg_28_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.actorSpriteComps1071 then
				for iter_31_6, iter_31_7 in pairs(arg_28_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_31_7 then
						if arg_28_1.isInRecall_ then
							iter_31_7.color = arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_31_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps1071 = nil
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
			local var_31_24 = 0.675

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

				local var_31_26 = arg_28_1:GetWordFromCfg(418011007)
				local var_31_27 = arg_28_1:FormatText(var_31_26.content)

				arg_28_1.text_.text = var_31_27

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_28 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011007", "story_v_side_old_418011.awb") ~= 0 then
					local var_31_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011007", "story_v_side_old_418011.awb") / 1000

					if var_31_31 + var_31_23 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_31 + var_31_23
					end

					if var_31_26.prefab_name ~= "" and arg_28_1.actors_[var_31_26.prefab_name] ~= nil then
						local var_31_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_26.prefab_name].transform, "story_v_side_old_418011", "418011007", "story_v_side_old_418011.awb")

						arg_28_1:RecordAudio("418011007", var_31_32)
						arg_28_1:RecordAudio("418011007", var_31_32)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011007", "story_v_side_old_418011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011007", "story_v_side_old_418011.awb")
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
	Play418011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 418011008
		arg_32_1.duration_ = 11.07

		local var_32_0 = {
			ja = 11.066,
			CriLanguages = 7.3,
			zh = 7.3
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
				arg_32_0:Play418011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1073"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1073 = var_35_0.localPosition
				var_35_0.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("1073", 2)

				local var_35_2 = var_35_0.childCount

				for iter_35_0 = 0, var_35_2 - 1 do
					local var_35_3 = var_35_0:GetChild(iter_35_0)

					if var_35_3.name == "" or not string.find(var_35_3.name, "split") then
						var_35_3.gameObject:SetActive(true)
					else
						var_35_3.gameObject:SetActive(false)
					end
				end
			end

			local var_35_4 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_4 then
				local var_35_5 = (arg_32_1.time_ - var_35_1) / var_35_4
				local var_35_6 = Vector3.New(-405.76, -414.5, -207.2)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1073, var_35_6, var_35_5)
			end

			if arg_32_1.time_ >= var_35_1 + var_35_4 and arg_32_1.time_ < var_35_1 + var_35_4 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_35_7 = 0
			local var_35_8 = 1.075

			if var_35_7 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_9 = arg_32_1:FormatText(StoryNameCfg[380].name)

				arg_32_1.leftNameTxt_.text = var_35_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_10 = arg_32_1:GetWordFromCfg(418011008)
				local var_35_11 = arg_32_1:FormatText(var_35_10.content)

				arg_32_1.text_.text = var_35_11

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_12 = 43
				local var_35_13 = utf8.len(var_35_11)
				local var_35_14 = var_35_12 <= 0 and var_35_8 or var_35_8 * (var_35_13 / var_35_12)

				if var_35_14 > 0 and var_35_8 < var_35_14 then
					arg_32_1.talkMaxDuration = var_35_14

					if var_35_14 + var_35_7 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_7
					end
				end

				arg_32_1.text_.text = var_35_11
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011008", "story_v_side_old_418011.awb") ~= 0 then
					local var_35_15 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011008", "story_v_side_old_418011.awb") / 1000

					if var_35_15 + var_35_7 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_7
					end

					if var_35_10.prefab_name ~= "" and arg_32_1.actors_[var_35_10.prefab_name] ~= nil then
						local var_35_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_10.prefab_name].transform, "story_v_side_old_418011", "418011008", "story_v_side_old_418011.awb")

						arg_32_1:RecordAudio("418011008", var_35_16)
						arg_32_1:RecordAudio("418011008", var_35_16)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011008", "story_v_side_old_418011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011008", "story_v_side_old_418011.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_17 = math.max(var_35_8, arg_32_1.talkMaxDuration)

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_17 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_7) / var_35_17

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_7 + var_35_17 and arg_32_1.time_ < var_35_7 + var_35_17 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play418011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 418011009
		arg_36_1.duration_ = 3.37

		local var_36_0 = {
			ja = 3.366,
			CriLanguages = 2.033,
			zh = 2.033
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
				arg_36_0:Play418011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1071"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps1071 == nil then
				arg_36_1.var_.actorSpriteComps1071 = var_39_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.actorSpriteComps1071 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps1071 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_39_3 then
						if arg_36_1.isInRecall_ then
							iter_39_3.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_39_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps1071 = nil
			end

			local var_39_8 = arg_36_1.actors_["1073"]
			local var_39_9 = 0

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps1073 == nil then
				arg_36_1.var_.actorSpriteComps1073 = var_39_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_10 = 0.2

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_10 and not isNil(var_39_8) then
				local var_39_11 = (arg_36_1.time_ - var_39_9) / var_39_10

				if arg_36_1.var_.actorSpriteComps1073 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_36_1.time_ >= var_39_9 + var_39_10 and arg_36_1.time_ < var_39_9 + var_39_10 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps1073 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_39_7 then
						if arg_36_1.isInRecall_ then
							iter_39_7.color = arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_39_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps1073 = nil
			end

			local var_39_16 = arg_36_1.actors_["1071"].transform
			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.var_.moveOldPos1071 = var_39_16.localPosition
				var_39_16.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("1071", 4)

				local var_39_18 = var_39_16.childCount

				for iter_39_8 = 0, var_39_18 - 1 do
					local var_39_19 = var_39_16:GetChild(iter_39_8)

					if var_39_19.name == "split_1" or not string.find(var_39_19.name, "split") then
						var_39_19.gameObject:SetActive(true)
					else
						var_39_19.gameObject:SetActive(false)
					end
				end
			end

			local var_39_20 = 0.001

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_20 then
				local var_39_21 = (arg_36_1.time_ - var_39_17) / var_39_20
				local var_39_22 = Vector3.New(519.94, -392.9, -306.6)

				var_39_16.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1071, var_39_22, var_39_21)
			end

			if arg_36_1.time_ >= var_39_17 + var_39_20 and arg_36_1.time_ < var_39_17 + var_39_20 + arg_39_0 then
				var_39_16.localPosition = Vector3.New(519.94, -392.9, -306.6)
			end

			local var_39_23 = 0
			local var_39_24 = 0.275

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_25 = arg_36_1:FormatText(StoryNameCfg[384].name)

				arg_36_1.leftNameTxt_.text = var_39_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_26 = arg_36_1:GetWordFromCfg(418011009)
				local var_39_27 = arg_36_1:FormatText(var_39_26.content)

				arg_36_1.text_.text = var_39_27

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_28 = 11
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011009", "story_v_side_old_418011.awb") ~= 0 then
					local var_39_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011009", "story_v_side_old_418011.awb") / 1000

					if var_39_31 + var_39_23 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_31 + var_39_23
					end

					if var_39_26.prefab_name ~= "" and arg_36_1.actors_[var_39_26.prefab_name] ~= nil then
						local var_39_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_26.prefab_name].transform, "story_v_side_old_418011", "418011009", "story_v_side_old_418011.awb")

						arg_36_1:RecordAudio("418011009", var_39_32)
						arg_36_1:RecordAudio("418011009", var_39_32)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011009", "story_v_side_old_418011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011009", "story_v_side_old_418011.awb")
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
				actorName = "1071",
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
	Play418011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 418011010
		arg_40_1.duration_ = 11.33

		local var_40_0 = {
			ja = 11.333,
			CriLanguages = 7.933,
			zh = 7.933
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
				arg_40_0:Play418011011(arg_40_1)
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

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps1073 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps1073 = nil
			end

			local var_43_8 = arg_40_1.actors_["1071"]
			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps1071 == nil then
				arg_40_1.var_.actorSpriteComps1071 = var_43_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_10 = 0.2

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_10 and not isNil(var_43_8) then
				local var_43_11 = (arg_40_1.time_ - var_43_9) / var_43_10

				if arg_40_1.var_.actorSpriteComps1071 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_40_1.time_ >= var_43_9 + var_43_10 and arg_40_1.time_ < var_43_9 + var_43_10 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps1071 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_43_7 then
						if arg_40_1.isInRecall_ then
							iter_43_7.color = arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_43_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps1071 = nil
			end

			local var_43_16 = arg_40_1.actors_["1073"].transform
			local var_43_17 = 0

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.var_.moveOldPos1073 = var_43_16.localPosition
				var_43_16.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("1073", 2)

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
				local var_43_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_43_16.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1073, var_43_22, var_43_21)
			end

			if arg_40_1.time_ >= var_43_17 + var_43_20 and arg_40_1.time_ < var_43_17 + var_43_20 + arg_43_0 then
				var_43_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_43_23 = 0
			local var_43_24 = 1.05

			if var_43_23 < arg_40_1.time_ and arg_40_1.time_ <= var_43_23 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_25 = arg_40_1:FormatText(StoryNameCfg[380].name)

				arg_40_1.leftNameTxt_.text = var_43_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_26 = arg_40_1:GetWordFromCfg(418011010)
				local var_43_27 = arg_40_1:FormatText(var_43_26.content)

				arg_40_1.text_.text = var_43_27

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_28 = 42
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011010", "story_v_side_old_418011.awb") ~= 0 then
					local var_43_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011010", "story_v_side_old_418011.awb") / 1000

					if var_43_31 + var_43_23 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_31 + var_43_23
					end

					if var_43_26.prefab_name ~= "" and arg_40_1.actors_[var_43_26.prefab_name] ~= nil then
						local var_43_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_26.prefab_name].transform, "story_v_side_old_418011", "418011010", "story_v_side_old_418011.awb")

						arg_40_1:RecordAudio("418011010", var_43_32)
						arg_40_1:RecordAudio("418011010", var_43_32)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011010", "story_v_side_old_418011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011010", "story_v_side_old_418011.awb")
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
				actorName = "1073",
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
	Play418011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 418011011
		arg_44_1.duration_ = 10.63

		local var_44_0 = {
			ja = 10.633,
			CriLanguages = 8.9,
			zh = 8.9
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
				arg_44_0:Play418011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.2

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[380].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(418011011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011011", "story_v_side_old_418011.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011011", "story_v_side_old_418011.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_side_old_418011", "418011011", "story_v_side_old_418011.awb")

						arg_44_1:RecordAudio("418011011", var_47_9)
						arg_44_1:RecordAudio("418011011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011011", "story_v_side_old_418011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011011", "story_v_side_old_418011.awb")
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
	Play418011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 418011012
		arg_48_1.duration_ = 7.93

		local var_48_0 = {
			ja = 7.933,
			CriLanguages = 5.4,
			zh = 5.4
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
				arg_48_0:Play418011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1071"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1071 == nil then
				arg_48_1.var_.actorSpriteComps1071 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps1071 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1071 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_51_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps1071 = nil
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

			local var_51_16 = arg_48_1.actors_["1071"].transform
			local var_51_17 = 0

			if var_51_17 < arg_48_1.time_ and arg_48_1.time_ <= var_51_17 + arg_51_0 then
				arg_48_1.var_.moveOldPos1071 = var_51_16.localPosition
				var_51_16.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("1071", 4)

				local var_51_18 = var_51_16.childCount

				for iter_51_8 = 0, var_51_18 - 1 do
					local var_51_19 = var_51_16:GetChild(iter_51_8)

					if var_51_19.name == "split_5" or not string.find(var_51_19.name, "split") then
						var_51_19.gameObject:SetActive(true)
					else
						var_51_19.gameObject:SetActive(false)
					end
				end
			end

			local var_51_20 = 0.001

			if var_51_17 <= arg_48_1.time_ and arg_48_1.time_ < var_51_17 + var_51_20 then
				local var_51_21 = (arg_48_1.time_ - var_51_17) / var_51_20
				local var_51_22 = Vector3.New(519.94, -392.9, -306.6)

				var_51_16.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1071, var_51_22, var_51_21)
			end

			if arg_48_1.time_ >= var_51_17 + var_51_20 and arg_48_1.time_ < var_51_17 + var_51_20 + arg_51_0 then
				var_51_16.localPosition = Vector3.New(519.94, -392.9, -306.6)
			end

			local var_51_23 = 0
			local var_51_24 = 0.625

			if var_51_23 < arg_48_1.time_ and arg_48_1.time_ <= var_51_23 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_25 = arg_48_1:FormatText(StoryNameCfg[384].name)

				arg_48_1.leftNameTxt_.text = var_51_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_26 = arg_48_1:GetWordFromCfg(418011012)
				local var_51_27 = arg_48_1:FormatText(var_51_26.content)

				arg_48_1.text_.text = var_51_27

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_28 = 25
				local var_51_29 = utf8.len(var_51_27)
				local var_51_30 = var_51_28 <= 0 and var_51_24 or var_51_24 * (var_51_29 / var_51_28)

				if var_51_30 > 0 and var_51_24 < var_51_30 then
					arg_48_1.talkMaxDuration = var_51_30

					if var_51_30 + var_51_23 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_30 + var_51_23
					end
				end

				arg_48_1.text_.text = var_51_27
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011012", "story_v_side_old_418011.awb") ~= 0 then
					local var_51_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011012", "story_v_side_old_418011.awb") / 1000

					if var_51_31 + var_51_23 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_31 + var_51_23
					end

					if var_51_26.prefab_name ~= "" and arg_48_1.actors_[var_51_26.prefab_name] ~= nil then
						local var_51_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_26.prefab_name].transform, "story_v_side_old_418011", "418011012", "story_v_side_old_418011.awb")

						arg_48_1:RecordAudio("418011012", var_51_32)
						arg_48_1:RecordAudio("418011012", var_51_32)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011012", "story_v_side_old_418011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011012", "story_v_side_old_418011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_33 = math.max(var_51_24, arg_48_1.talkMaxDuration)

			if var_51_23 <= arg_48_1.time_ and arg_48_1.time_ < var_51_23 + var_51_33 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_23) / var_51_33

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_23 + var_51_33 and arg_48_1.time_ < var_51_23 + var_51_33 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071",
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
	Play418011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 418011013
		arg_52_1.duration_ = 6.2

		local var_52_0 = {
			ja = 5.6,
			CriLanguages = 6.2,
			zh = 6.2
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
				arg_52_0:Play418011014(arg_52_1)
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

			local var_55_8 = arg_52_1.actors_["1071"]
			local var_55_9 = 0

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps1071 == nil then
				arg_52_1.var_.actorSpriteComps1071 = var_55_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_10 = 0.2

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_10 and not isNil(var_55_8) then
				local var_55_11 = (arg_52_1.time_ - var_55_9) / var_55_10

				if arg_52_1.var_.actorSpriteComps1071 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_52_1.time_ >= var_55_9 + var_55_10 and arg_52_1.time_ < var_55_9 + var_55_10 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps1071 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_55_7 then
						if arg_52_1.isInRecall_ then
							iter_55_7.color = arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_55_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps1071 = nil
			end

			local var_55_16 = 0
			local var_55_17 = 0.725

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

				local var_55_19 = arg_52_1:GetWordFromCfg(418011013)
				local var_55_20 = arg_52_1:FormatText(var_55_19.content)

				arg_52_1.text_.text = var_55_20

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_21 = 29
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011013", "story_v_side_old_418011.awb") ~= 0 then
					local var_55_24 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011013", "story_v_side_old_418011.awb") / 1000

					if var_55_24 + var_55_16 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_16
					end

					if var_55_19.prefab_name ~= "" and arg_52_1.actors_[var_55_19.prefab_name] ~= nil then
						local var_55_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_19.prefab_name].transform, "story_v_side_old_418011", "418011013", "story_v_side_old_418011.awb")

						arg_52_1:RecordAudio("418011013", var_55_25)
						arg_52_1:RecordAudio("418011013", var_55_25)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011013", "story_v_side_old_418011.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011013", "story_v_side_old_418011.awb")
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
	Play418011014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 418011014
		arg_56_1.duration_ = 5

		local var_56_0 = {
			ja = 4.6,
			CriLanguages = 5,
			zh = 5
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
				arg_56_0:Play418011015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1071"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1071 == nil then
				arg_56_1.var_.actorSpriteComps1071 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps1071 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1071 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_59_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps1071 = nil
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

			local var_59_16 = arg_56_1.actors_["1071"].transform
			local var_59_17 = 0

			if var_59_17 < arg_56_1.time_ and arg_56_1.time_ <= var_59_17 + arg_59_0 then
				arg_56_1.var_.moveOldPos1071 = var_59_16.localPosition
				var_59_16.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("1071", 4)

				local var_59_18 = var_59_16.childCount

				for iter_59_8 = 0, var_59_18 - 1 do
					local var_59_19 = var_59_16:GetChild(iter_59_8)

					if var_59_19.name == "split_1" or not string.find(var_59_19.name, "split") then
						var_59_19.gameObject:SetActive(true)
					else
						var_59_19.gameObject:SetActive(false)
					end
				end
			end

			local var_59_20 = 0.001

			if var_59_17 <= arg_56_1.time_ and arg_56_1.time_ < var_59_17 + var_59_20 then
				local var_59_21 = (arg_56_1.time_ - var_59_17) / var_59_20
				local var_59_22 = Vector3.New(519.94, -392.9, -306.6)

				var_59_16.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1071, var_59_22, var_59_21)
			end

			if arg_56_1.time_ >= var_59_17 + var_59_20 and arg_56_1.time_ < var_59_17 + var_59_20 + arg_59_0 then
				var_59_16.localPosition = Vector3.New(519.94, -392.9, -306.6)
			end

			local var_59_23 = 0
			local var_59_24 = 0.55

			if var_59_23 < arg_56_1.time_ and arg_56_1.time_ <= var_59_23 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_25 = arg_56_1:FormatText(StoryNameCfg[384].name)

				arg_56_1.leftNameTxt_.text = var_59_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_26 = arg_56_1:GetWordFromCfg(418011014)
				local var_59_27 = arg_56_1:FormatText(var_59_26.content)

				arg_56_1.text_.text = var_59_27

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_28 = 22
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011014", "story_v_side_old_418011.awb") ~= 0 then
					local var_59_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011014", "story_v_side_old_418011.awb") / 1000

					if var_59_31 + var_59_23 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_31 + var_59_23
					end

					if var_59_26.prefab_name ~= "" and arg_56_1.actors_[var_59_26.prefab_name] ~= nil then
						local var_59_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_26.prefab_name].transform, "story_v_side_old_418011", "418011014", "story_v_side_old_418011.awb")

						arg_56_1:RecordAudio("418011014", var_59_32)
						arg_56_1:RecordAudio("418011014", var_59_32)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011014", "story_v_side_old_418011.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011014", "story_v_side_old_418011.awb")
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
				actorName = "1071",
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
	Play418011015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 418011015
		arg_60_1.duration_ = 7.13

		local var_60_0 = {
			ja = 5.566,
			CriLanguages = 7.133,
			zh = 7.133
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
				arg_60_0:Play418011016(arg_60_1)
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

			local var_63_8 = arg_60_1.actors_["1071"]
			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps1071 == nil then
				arg_60_1.var_.actorSpriteComps1071 = var_63_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_10 = 0.2

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 and not isNil(var_63_8) then
				local var_63_11 = (arg_60_1.time_ - var_63_9) / var_63_10

				if arg_60_1.var_.actorSpriteComps1071 then
					for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps1071 then
				for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_63_7 then
						if arg_60_1.isInRecall_ then
							iter_63_7.color = arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_63_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps1071 = nil
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

					if var_63_19.name == "split_1" or not string.find(var_63_19.name, "split") then
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
			local var_63_24 = 0.95

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

				local var_63_26 = arg_60_1:GetWordFromCfg(418011015)
				local var_63_27 = arg_60_1:FormatText(var_63_26.content)

				arg_60_1.text_.text = var_63_27

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_28 = 38
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011015", "story_v_side_old_418011.awb") ~= 0 then
					local var_63_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011015", "story_v_side_old_418011.awb") / 1000

					if var_63_31 + var_63_23 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_31 + var_63_23
					end

					if var_63_26.prefab_name ~= "" and arg_60_1.actors_[var_63_26.prefab_name] ~= nil then
						local var_63_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_26.prefab_name].transform, "story_v_side_old_418011", "418011015", "story_v_side_old_418011.awb")

						arg_60_1:RecordAudio("418011015", var_63_32)
						arg_60_1:RecordAudio("418011015", var_63_32)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011015", "story_v_side_old_418011.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011015", "story_v_side_old_418011.awb")
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
	Play418011016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 418011016
		arg_64_1.duration_ = 7.7

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play418011017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1071"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1071 == nil then
				arg_64_1.var_.actorSpriteComps1071 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps1071 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1071 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps1071 = nil
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

			local var_67_16 = arg_64_1.actors_["1071"].transform
			local var_67_17 = 0

			if var_67_17 < arg_64_1.time_ and arg_64_1.time_ <= var_67_17 + arg_67_0 then
				arg_64_1.var_.moveOldPos1071 = var_67_16.localPosition
				var_67_16.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("1071", 4)

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
				local var_67_22 = Vector3.New(519.94, -392.9, -306.6)

				var_67_16.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1071, var_67_22, var_67_21)
			end

			if arg_64_1.time_ >= var_67_17 + var_67_20 and arg_64_1.time_ < var_67_17 + var_67_20 + arg_67_0 then
				var_67_16.localPosition = Vector3.New(519.94, -392.9, -306.6)
			end

			local var_67_23 = 0
			local var_67_24 = 0.75

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_25 = arg_64_1:FormatText(StoryNameCfg[384].name)

				arg_64_1.leftNameTxt_.text = var_67_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_26 = arg_64_1:GetWordFromCfg(418011016)
				local var_67_27 = arg_64_1:FormatText(var_67_26.content)

				arg_64_1.text_.text = var_67_27

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_28 = 30
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011016", "story_v_side_old_418011.awb") ~= 0 then
					local var_67_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011016", "story_v_side_old_418011.awb") / 1000

					if var_67_31 + var_67_23 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_31 + var_67_23
					end

					if var_67_26.prefab_name ~= "" and arg_64_1.actors_[var_67_26.prefab_name] ~= nil then
						local var_67_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_26.prefab_name].transform, "story_v_side_old_418011", "418011016", "story_v_side_old_418011.awb")

						arg_64_1:RecordAudio("418011016", var_67_32)
						arg_64_1:RecordAudio("418011016", var_67_32)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011016", "story_v_side_old_418011.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011016", "story_v_side_old_418011.awb")
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
				actorName = "1071",
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
	Play418011017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 418011017
		arg_68_1.duration_ = 13.37

		local var_68_0 = {
			ja = 13.366,
			CriLanguages = 9.1,
			zh = 9.1
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
				arg_68_0:Play418011018(arg_68_1)
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

			local var_71_8 = arg_68_1.actors_["1071"]
			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 and not isNil(var_71_8) and arg_68_1.var_.actorSpriteComps1071 == nil then
				arg_68_1.var_.actorSpriteComps1071 = var_71_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_10 = 0.2

			if var_71_9 <= arg_68_1.time_ and arg_68_1.time_ < var_71_9 + var_71_10 and not isNil(var_71_8) then
				local var_71_11 = (arg_68_1.time_ - var_71_9) / var_71_10

				if arg_68_1.var_.actorSpriteComps1071 then
					for iter_71_4, iter_71_5 in pairs(arg_68_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_68_1.time_ >= var_71_9 + var_71_10 and arg_68_1.time_ < var_71_9 + var_71_10 + arg_71_0 and not isNil(var_71_8) and arg_68_1.var_.actorSpriteComps1071 then
				for iter_71_6, iter_71_7 in pairs(arg_68_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_71_7 then
						if arg_68_1.isInRecall_ then
							iter_71_7.color = arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_71_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps1071 = nil
			end

			local var_71_16 = 0
			local var_71_17 = 1.225

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_18 = arg_68_1:FormatText(StoryNameCfg[380].name)

				arg_68_1.leftNameTxt_.text = var_71_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_19 = arg_68_1:GetWordFromCfg(418011017)
				local var_71_20 = arg_68_1:FormatText(var_71_19.content)

				arg_68_1.text_.text = var_71_20

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_21 = 49
				local var_71_22 = utf8.len(var_71_20)
				local var_71_23 = var_71_21 <= 0 and var_71_17 or var_71_17 * (var_71_22 / var_71_21)

				if var_71_23 > 0 and var_71_17 < var_71_23 then
					arg_68_1.talkMaxDuration = var_71_23

					if var_71_23 + var_71_16 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_16
					end
				end

				arg_68_1.text_.text = var_71_20
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011017", "story_v_side_old_418011.awb") ~= 0 then
					local var_71_24 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011017", "story_v_side_old_418011.awb") / 1000

					if var_71_24 + var_71_16 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_24 + var_71_16
					end

					if var_71_19.prefab_name ~= "" and arg_68_1.actors_[var_71_19.prefab_name] ~= nil then
						local var_71_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_19.prefab_name].transform, "story_v_side_old_418011", "418011017", "story_v_side_old_418011.awb")

						arg_68_1:RecordAudio("418011017", var_71_25)
						arg_68_1:RecordAudio("418011017", var_71_25)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011017", "story_v_side_old_418011.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011017", "story_v_side_old_418011.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_26 = math.max(var_71_17, arg_68_1.talkMaxDuration)

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_26 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_16) / var_71_26

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_16 + var_71_26 and arg_68_1.time_ < var_71_16 + var_71_26 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play418011018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 418011018
		arg_72_1.duration_ = 5.03

		local var_72_0 = {
			ja = 4.5,
			CriLanguages = 5.033,
			zh = 5.033
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
				arg_72_0:Play418011019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.65

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

				local var_75_3 = arg_72_1:GetWordFromCfg(418011018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011018", "story_v_side_old_418011.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011018", "story_v_side_old_418011.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_side_old_418011", "418011018", "story_v_side_old_418011.awb")

						arg_72_1:RecordAudio("418011018", var_75_9)
						arg_72_1:RecordAudio("418011018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011018", "story_v_side_old_418011.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011018", "story_v_side_old_418011.awb")
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
	Play418011019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 418011019
		arg_76_1.duration_ = 8.2

		local var_76_0 = {
			ja = 8.1,
			CriLanguages = 8.2,
			zh = 8.2
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
				arg_76_0:Play418011020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1071"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps1071 == nil then
				arg_76_1.var_.actorSpriteComps1071 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps1071 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps1071 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps1071 = nil
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

			local var_79_16 = arg_76_1.actors_["1071"].transform
			local var_79_17 = 0

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.var_.moveOldPos1071 = var_79_16.localPosition
				var_79_16.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1071", 4)

				local var_79_18 = var_79_16.childCount

				for iter_79_8 = 0, var_79_18 - 1 do
					local var_79_19 = var_79_16:GetChild(iter_79_8)

					if var_79_19.name == "split_8" or not string.find(var_79_19.name, "split") then
						var_79_19.gameObject:SetActive(true)
					else
						var_79_19.gameObject:SetActive(false)
					end
				end
			end

			local var_79_20 = 0.001

			if var_79_17 <= arg_76_1.time_ and arg_76_1.time_ < var_79_17 + var_79_20 then
				local var_79_21 = (arg_76_1.time_ - var_79_17) / var_79_20
				local var_79_22 = Vector3.New(519.94, -392.9, -306.6)

				var_79_16.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1071, var_79_22, var_79_21)
			end

			if arg_76_1.time_ >= var_79_17 + var_79_20 and arg_76_1.time_ < var_79_17 + var_79_20 + arg_79_0 then
				var_79_16.localPosition = Vector3.New(519.94, -392.9, -306.6)
			end

			local var_79_23 = 0
			local var_79_24 = 1.025

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_25 = arg_76_1:FormatText(StoryNameCfg[384].name)

				arg_76_1.leftNameTxt_.text = var_79_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_26 = arg_76_1:GetWordFromCfg(418011019)
				local var_79_27 = arg_76_1:FormatText(var_79_26.content)

				arg_76_1.text_.text = var_79_27

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_28 = 41
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011019", "story_v_side_old_418011.awb") ~= 0 then
					local var_79_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011019", "story_v_side_old_418011.awb") / 1000

					if var_79_31 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_31 + var_79_23
					end

					if var_79_26.prefab_name ~= "" and arg_76_1.actors_[var_79_26.prefab_name] ~= nil then
						local var_79_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_26.prefab_name].transform, "story_v_side_old_418011", "418011019", "story_v_side_old_418011.awb")

						arg_76_1:RecordAudio("418011019", var_79_32)
						arg_76_1:RecordAudio("418011019", var_79_32)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011019", "story_v_side_old_418011.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011019", "story_v_side_old_418011.awb")
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
				actorName = "1071",
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
	Play418011020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 418011020
		arg_80_1.duration_ = 3

		local var_80_0 = {
			ja = 3,
			CriLanguages = 1.866,
			zh = 1.866
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
				arg_80_0:Play418011021(arg_80_1)
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

			local var_83_8 = arg_80_1.actors_["1071"]
			local var_83_9 = 0

			if var_83_9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps1071 == nil then
				arg_80_1.var_.actorSpriteComps1071 = var_83_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_10 = 0.2

			if var_83_9 <= arg_80_1.time_ and arg_80_1.time_ < var_83_9 + var_83_10 and not isNil(var_83_8) then
				local var_83_11 = (arg_80_1.time_ - var_83_9) / var_83_10

				if arg_80_1.var_.actorSpriteComps1071 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_80_1.time_ >= var_83_9 + var_83_10 and arg_80_1.time_ < var_83_9 + var_83_10 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps1071 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_83_7 then
						if arg_80_1.isInRecall_ then
							iter_83_7.color = arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_83_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps1071 = nil
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

					if var_83_19.name == "split_1" or not string.find(var_83_19.name, "split") then
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
			local var_83_24 = 0.2

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

				local var_83_26 = arg_80_1:GetWordFromCfg(418011020)
				local var_83_27 = arg_80_1:FormatText(var_83_26.content)

				arg_80_1.text_.text = var_83_27

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_28 = 8
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011020", "story_v_side_old_418011.awb") ~= 0 then
					local var_83_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011020", "story_v_side_old_418011.awb") / 1000

					if var_83_31 + var_83_23 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_31 + var_83_23
					end

					if var_83_26.prefab_name ~= "" and arg_80_1.actors_[var_83_26.prefab_name] ~= nil then
						local var_83_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_26.prefab_name].transform, "story_v_side_old_418011", "418011020", "story_v_side_old_418011.awb")

						arg_80_1:RecordAudio("418011020", var_83_32)
						arg_80_1:RecordAudio("418011020", var_83_32)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011020", "story_v_side_old_418011.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011020", "story_v_side_old_418011.awb")
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
	Play418011021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 418011021
		arg_84_1.duration_ = 5.63

		local var_84_0 = {
			ja = 5.633,
			CriLanguages = 4,
			zh = 4
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
				arg_84_0:Play418011022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1071"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps1071 == nil then
				arg_84_1.var_.actorSpriteComps1071 = var_87_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.actorSpriteComps1071 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps1071 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_87_3 then
						if arg_84_1.isInRecall_ then
							iter_87_3.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_87_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps1071 = nil
			end

			local var_87_8 = arg_84_1.actors_["1073"]
			local var_87_9 = 0

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.actorSpriteComps1073 == nil then
				arg_84_1.var_.actorSpriteComps1073 = var_87_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_10 = 0.2

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_10 and not isNil(var_87_8) then
				local var_87_11 = (arg_84_1.time_ - var_87_9) / var_87_10

				if arg_84_1.var_.actorSpriteComps1073 then
					for iter_87_4, iter_87_5 in pairs(arg_84_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_84_1.time_ >= var_87_9 + var_87_10 and arg_84_1.time_ < var_87_9 + var_87_10 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.actorSpriteComps1073 then
				for iter_87_6, iter_87_7 in pairs(arg_84_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_87_7 then
						if arg_84_1.isInRecall_ then
							iter_87_7.color = arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_87_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps1073 = nil
			end

			local var_87_16 = 0
			local var_87_17 = 0.525

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_18 = arg_84_1:FormatText(StoryNameCfg[384].name)

				arg_84_1.leftNameTxt_.text = var_87_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_19 = arg_84_1:GetWordFromCfg(418011021)
				local var_87_20 = arg_84_1:FormatText(var_87_19.content)

				arg_84_1.text_.text = var_87_20

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_21 = 21
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011021", "story_v_side_old_418011.awb") ~= 0 then
					local var_87_24 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011021", "story_v_side_old_418011.awb") / 1000

					if var_87_24 + var_87_16 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_24 + var_87_16
					end

					if var_87_19.prefab_name ~= "" and arg_84_1.actors_[var_87_19.prefab_name] ~= nil then
						local var_87_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_19.prefab_name].transform, "story_v_side_old_418011", "418011021", "story_v_side_old_418011.awb")

						arg_84_1:RecordAudio("418011021", var_87_25)
						arg_84_1:RecordAudio("418011021", var_87_25)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011021", "story_v_side_old_418011.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011021", "story_v_side_old_418011.awb")
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
	Play418011022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 418011022
		arg_88_1.duration_ = 10.37

		local var_88_0 = {
			ja = 10.366,
			CriLanguages = 9.866,
			zh = 9.866
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
				arg_88_0:Play418011023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1073"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps1073 == nil then
				arg_88_1.var_.actorSpriteComps1073 = var_91_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.actorSpriteComps1073 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								local var_91_4 = Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor1.r, var_91_3)
								local var_91_5 = Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor1.g, var_91_3)
								local var_91_6 = Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor1.b, var_91_3)

								iter_91_1.color = Color.New(var_91_4, var_91_5, var_91_6)
							else
								local var_91_7 = Mathf.Lerp(iter_91_1.color.r, 1, var_91_3)

								iter_91_1.color = Color.New(var_91_7, var_91_7, var_91_7)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps1073 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_91_3 then
						if arg_88_1.isInRecall_ then
							iter_91_3.color = arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_91_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps1073 = nil
			end

			local var_91_8 = arg_88_1.actors_["1071"]
			local var_91_9 = 0

			if var_91_9 < arg_88_1.time_ and arg_88_1.time_ <= var_91_9 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps1071 == nil then
				arg_88_1.var_.actorSpriteComps1071 = var_91_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_10 = 0.2

			if var_91_9 <= arg_88_1.time_ and arg_88_1.time_ < var_91_9 + var_91_10 and not isNil(var_91_8) then
				local var_91_11 = (arg_88_1.time_ - var_91_9) / var_91_10

				if arg_88_1.var_.actorSpriteComps1071 then
					for iter_91_4, iter_91_5 in pairs(arg_88_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_91_5 then
							if arg_88_1.isInRecall_ then
								local var_91_12 = Mathf.Lerp(iter_91_5.color.r, arg_88_1.hightColor2.r, var_91_11)
								local var_91_13 = Mathf.Lerp(iter_91_5.color.g, arg_88_1.hightColor2.g, var_91_11)
								local var_91_14 = Mathf.Lerp(iter_91_5.color.b, arg_88_1.hightColor2.b, var_91_11)

								iter_91_5.color = Color.New(var_91_12, var_91_13, var_91_14)
							else
								local var_91_15 = Mathf.Lerp(iter_91_5.color.r, 0.5, var_91_11)

								iter_91_5.color = Color.New(var_91_15, var_91_15, var_91_15)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_9 + var_91_10 and arg_88_1.time_ < var_91_9 + var_91_10 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps1071 then
				for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_91_7 then
						if arg_88_1.isInRecall_ then
							iter_91_7.color = arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_91_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps1071 = nil
			end

			local var_91_16 = arg_88_1.actors_["1073"].transform
			local var_91_17 = 0

			if var_91_17 < arg_88_1.time_ and arg_88_1.time_ <= var_91_17 + arg_91_0 then
				arg_88_1.var_.moveOldPos1073 = var_91_16.localPosition
				var_91_16.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("1073", 2)

				local var_91_18 = var_91_16.childCount

				for iter_91_8 = 0, var_91_18 - 1 do
					local var_91_19 = var_91_16:GetChild(iter_91_8)

					if var_91_19.name == "" or not string.find(var_91_19.name, "split") then
						var_91_19.gameObject:SetActive(true)
					else
						var_91_19.gameObject:SetActive(false)
					end
				end
			end

			local var_91_20 = 0.001

			if var_91_17 <= arg_88_1.time_ and arg_88_1.time_ < var_91_17 + var_91_20 then
				local var_91_21 = (arg_88_1.time_ - var_91_17) / var_91_20
				local var_91_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_91_16.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1073, var_91_22, var_91_21)
			end

			if arg_88_1.time_ >= var_91_17 + var_91_20 and arg_88_1.time_ < var_91_17 + var_91_20 + arg_91_0 then
				var_91_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_91_23 = 0
			local var_91_24 = 1.2

			if var_91_23 < arg_88_1.time_ and arg_88_1.time_ <= var_91_23 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_25 = arg_88_1:FormatText(StoryNameCfg[380].name)

				arg_88_1.leftNameTxt_.text = var_91_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_26 = arg_88_1:GetWordFromCfg(418011022)
				local var_91_27 = arg_88_1:FormatText(var_91_26.content)

				arg_88_1.text_.text = var_91_27

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_28 = 48
				local var_91_29 = utf8.len(var_91_27)
				local var_91_30 = var_91_28 <= 0 and var_91_24 or var_91_24 * (var_91_29 / var_91_28)

				if var_91_30 > 0 and var_91_24 < var_91_30 then
					arg_88_1.talkMaxDuration = var_91_30

					if var_91_30 + var_91_23 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_30 + var_91_23
					end
				end

				arg_88_1.text_.text = var_91_27
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011022", "story_v_side_old_418011.awb") ~= 0 then
					local var_91_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011022", "story_v_side_old_418011.awb") / 1000

					if var_91_31 + var_91_23 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_31 + var_91_23
					end

					if var_91_26.prefab_name ~= "" and arg_88_1.actors_[var_91_26.prefab_name] ~= nil then
						local var_91_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_26.prefab_name].transform, "story_v_side_old_418011", "418011022", "story_v_side_old_418011.awb")

						arg_88_1:RecordAudio("418011022", var_91_32)
						arg_88_1:RecordAudio("418011022", var_91_32)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011022", "story_v_side_old_418011.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011022", "story_v_side_old_418011.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_33 = math.max(var_91_24, arg_88_1.talkMaxDuration)

			if var_91_23 <= arg_88_1.time_ and arg_88_1.time_ < var_91_23 + var_91_33 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_23) / var_91_33

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_23 + var_91_33 and arg_88_1.time_ < var_91_23 + var_91_33 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play418011023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 418011023
		arg_92_1.duration_ = 1.3

		local var_92_0 = {
			ja = 1.033,
			CriLanguages = 1.3,
			zh = 1.3
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
				arg_92_0:Play418011024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1071"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps1071 == nil then
				arg_92_1.var_.actorSpriteComps1071 = var_95_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.actorSpriteComps1071 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps1071 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_95_3 then
						if arg_92_1.isInRecall_ then
							iter_95_3.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_95_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps1071 = nil
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

			local var_95_16 = arg_92_1.actors_["1071"].transform
			local var_95_17 = 0

			if var_95_17 < arg_92_1.time_ and arg_92_1.time_ <= var_95_17 + arg_95_0 then
				arg_92_1.var_.moveOldPos1071 = var_95_16.localPosition
				var_95_16.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1071", 4)

				local var_95_18 = var_95_16.childCount

				for iter_95_8 = 0, var_95_18 - 1 do
					local var_95_19 = var_95_16:GetChild(iter_95_8)

					if var_95_19.name == "split_1" or not string.find(var_95_19.name, "split") then
						var_95_19.gameObject:SetActive(true)
					else
						var_95_19.gameObject:SetActive(false)
					end
				end
			end

			local var_95_20 = 0.001

			if var_95_17 <= arg_92_1.time_ and arg_92_1.time_ < var_95_17 + var_95_20 then
				local var_95_21 = (arg_92_1.time_ - var_95_17) / var_95_20
				local var_95_22 = Vector3.New(519.94, -392.9, -306.6)

				var_95_16.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1071, var_95_22, var_95_21)
			end

			if arg_92_1.time_ >= var_95_17 + var_95_20 and arg_92_1.time_ < var_95_17 + var_95_20 + arg_95_0 then
				var_95_16.localPosition = Vector3.New(519.94, -392.9, -306.6)
			end

			local var_95_23 = 0
			local var_95_24 = 0.05

			if var_95_23 < arg_92_1.time_ and arg_92_1.time_ <= var_95_23 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_25 = arg_92_1:FormatText(StoryNameCfg[384].name)

				arg_92_1.leftNameTxt_.text = var_95_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_26 = arg_92_1:GetWordFromCfg(418011023)
				local var_95_27 = arg_92_1:FormatText(var_95_26.content)

				arg_92_1.text_.text = var_95_27

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_28 = 2
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

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011023", "story_v_side_old_418011.awb") ~= 0 then
					local var_95_31 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011023", "story_v_side_old_418011.awb") / 1000

					if var_95_31 + var_95_23 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_31 + var_95_23
					end

					if var_95_26.prefab_name ~= "" and arg_92_1.actors_[var_95_26.prefab_name] ~= nil then
						local var_95_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_26.prefab_name].transform, "story_v_side_old_418011", "418011023", "story_v_side_old_418011.awb")

						arg_92_1:RecordAudio("418011023", var_95_32)
						arg_92_1:RecordAudio("418011023", var_95_32)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011023", "story_v_side_old_418011.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011023", "story_v_side_old_418011.awb")
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
				actorName = "1071",
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
	Play418011024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 418011024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play418011025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1071"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps1071 == nil then
				arg_96_1.var_.actorSpriteComps1071 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps1071 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps1071 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_99_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps1071 = nil
			end

			local var_99_8 = arg_96_1.actors_["1073"].transform
			local var_99_9 = 0

			if var_99_9 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 then
				arg_96_1.var_.moveOldPos1073 = var_99_8.localPosition
				var_99_8.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1073", 7)

				local var_99_10 = var_99_8.childCount

				for iter_99_4 = 0, var_99_10 - 1 do
					local var_99_11 = var_99_8:GetChild(iter_99_4)

					if var_99_11.name == "" or not string.find(var_99_11.name, "split") then
						var_99_11.gameObject:SetActive(true)
					else
						var_99_11.gameObject:SetActive(false)
					end
				end
			end

			local var_99_12 = 0.001

			if var_99_9 <= arg_96_1.time_ and arg_96_1.time_ < var_99_9 + var_99_12 then
				local var_99_13 = (arg_96_1.time_ - var_99_9) / var_99_12
				local var_99_14 = Vector3.New(0, -2000, 0)

				var_99_8.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1073, var_99_14, var_99_13)
			end

			if arg_96_1.time_ >= var_99_9 + var_99_12 and arg_96_1.time_ < var_99_9 + var_99_12 + arg_99_0 then
				var_99_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_99_15 = arg_96_1.actors_["1071"].transform
			local var_99_16 = 0

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.var_.moveOldPos1071 = var_99_15.localPosition
				var_99_15.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1071", 7)

				local var_99_17 = var_99_15.childCount

				for iter_99_5 = 0, var_99_17 - 1 do
					local var_99_18 = var_99_15:GetChild(iter_99_5)

					if var_99_18.name == "" or not string.find(var_99_18.name, "split") then
						var_99_18.gameObject:SetActive(true)
					else
						var_99_18.gameObject:SetActive(false)
					end
				end
			end

			local var_99_19 = 0.001

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_19 then
				local var_99_20 = (arg_96_1.time_ - var_99_16) / var_99_19
				local var_99_21 = Vector3.New(0, -2000, 7.24)

				var_99_15.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1071, var_99_21, var_99_20)
			end

			if arg_96_1.time_ >= var_99_16 + var_99_19 and arg_96_1.time_ < var_99_16 + var_99_19 + arg_99_0 then
				var_99_15.localPosition = Vector3.New(0, -2000, 7.24)
			end

			local var_99_22 = 0
			local var_99_23 = 0.625

			if var_99_22 < arg_96_1.time_ and arg_96_1.time_ <= var_99_22 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_24 = arg_96_1:GetWordFromCfg(418011024)
				local var_99_25 = arg_96_1:FormatText(var_99_24.content)

				arg_96_1.text_.text = var_99_25

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_26 = 25
				local var_99_27 = utf8.len(var_99_25)
				local var_99_28 = var_99_26 <= 0 and var_99_23 or var_99_23 * (var_99_27 / var_99_26)

				if var_99_28 > 0 and var_99_23 < var_99_28 then
					arg_96_1.talkMaxDuration = var_99_28

					if var_99_28 + var_99_22 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_28 + var_99_22
					end
				end

				arg_96_1.text_.text = var_99_25
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_29 = math.max(var_99_23, arg_96_1.talkMaxDuration)

			if var_99_22 <= arg_96_1.time_ and arg_96_1.time_ < var_99_22 + var_99_29 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_22) / var_99_29

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_22 + var_99_29 and arg_96_1.time_ < var_99_22 + var_99_29 + arg_99_0 then
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
			},
			{
				assetPath = "",
				actorName = "1071",
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
	Play418011025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 418011025
		arg_100_1.duration_ = 12.13

		local var_100_0 = {
			ja = 12.133,
			CriLanguages = 9.866,
			zh = 9.866
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
				arg_100_0:Play418011026(arg_100_1)
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

			local var_103_8 = arg_100_1.actors_["1073"].transform
			local var_103_9 = 0

			if var_103_9 < arg_100_1.time_ and arg_100_1.time_ <= var_103_9 + arg_103_0 then
				arg_100_1.var_.moveOldPos1073 = var_103_8.localPosition
				var_103_8.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("1073", 3)

				local var_103_10 = var_103_8.childCount

				for iter_103_4 = 0, var_103_10 - 1 do
					local var_103_11 = var_103_8:GetChild(iter_103_4)

					if var_103_11.name == "split_2" or not string.find(var_103_11.name, "split") then
						var_103_11.gameObject:SetActive(true)
					else
						var_103_11.gameObject:SetActive(false)
					end
				end
			end

			local var_103_12 = 0.001

			if var_103_9 <= arg_100_1.time_ and arg_100_1.time_ < var_103_9 + var_103_12 then
				local var_103_13 = (arg_100_1.time_ - var_103_9) / var_103_12
				local var_103_14 = Vector3.New(38.6, -414.5, -207.2)

				var_103_8.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1073, var_103_14, var_103_13)
			end

			if arg_100_1.time_ >= var_103_9 + var_103_12 and arg_100_1.time_ < var_103_9 + var_103_12 + arg_103_0 then
				var_103_8.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_103_15 = 0
			local var_103_16 = 1.25

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_17 = arg_100_1:FormatText(StoryNameCfg[380].name)

				arg_100_1.leftNameTxt_.text = var_103_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_18 = arg_100_1:GetWordFromCfg(418011025)
				local var_103_19 = arg_100_1:FormatText(var_103_18.content)

				arg_100_1.text_.text = var_103_19

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_20 = 50
				local var_103_21 = utf8.len(var_103_19)
				local var_103_22 = var_103_20 <= 0 and var_103_16 or var_103_16 * (var_103_21 / var_103_20)

				if var_103_22 > 0 and var_103_16 < var_103_22 then
					arg_100_1.talkMaxDuration = var_103_22

					if var_103_22 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_22 + var_103_15
					end
				end

				arg_100_1.text_.text = var_103_19
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011025", "story_v_side_old_418011.awb") ~= 0 then
					local var_103_23 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011025", "story_v_side_old_418011.awb") / 1000

					if var_103_23 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_23 + var_103_15
					end

					if var_103_18.prefab_name ~= "" and arg_100_1.actors_[var_103_18.prefab_name] ~= nil then
						local var_103_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_18.prefab_name].transform, "story_v_side_old_418011", "418011025", "story_v_side_old_418011.awb")

						arg_100_1:RecordAudio("418011025", var_103_24)
						arg_100_1:RecordAudio("418011025", var_103_24)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011025", "story_v_side_old_418011.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011025", "story_v_side_old_418011.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_25 = math.max(var_103_16, arg_100_1.talkMaxDuration)

			if var_103_15 <= arg_100_1.time_ and arg_100_1.time_ < var_103_15 + var_103_25 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_15) / var_103_25

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_15 + var_103_25 and arg_100_1.time_ < var_103_15 + var_103_25 + arg_103_0 then
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
	Play418011026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 418011026
		arg_104_1.duration_ = 8.47

		local var_104_0 = {
			ja = 8.466,
			CriLanguages = 6.866,
			zh = 6.866
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
				arg_104_0:Play418011027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1071"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps1071 == nil then
				arg_104_1.var_.actorSpriteComps1071 = var_107_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.actorSpriteComps1071 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps1071 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_107_3 then
						if arg_104_1.isInRecall_ then
							iter_107_3.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_107_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps1071 = nil
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

			local var_107_16 = arg_104_1.actors_["1071"].transform
			local var_107_17 = 0

			if var_107_17 < arg_104_1.time_ and arg_104_1.time_ <= var_107_17 + arg_107_0 then
				arg_104_1.var_.moveOldPos1071 = var_107_16.localPosition
				var_107_16.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1071", 4)

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
				local var_107_22 = Vector3.New(519.94, -392.9, -306.6)

				var_107_16.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1071, var_107_22, var_107_21)
			end

			if arg_104_1.time_ >= var_107_17 + var_107_20 and arg_104_1.time_ < var_107_17 + var_107_20 + arg_107_0 then
				var_107_16.localPosition = Vector3.New(519.94, -392.9, -306.6)
			end

			local var_107_23 = arg_104_1.actors_["1073"].transform
			local var_107_24 = 0

			if var_107_24 < arg_104_1.time_ and arg_104_1.time_ <= var_107_24 + arg_107_0 then
				arg_104_1.var_.moveOldPos1073 = var_107_23.localPosition
				var_107_23.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1073", 2)

				local var_107_25 = var_107_23.childCount

				for iter_107_9 = 0, var_107_25 - 1 do
					local var_107_26 = var_107_23:GetChild(iter_107_9)

					if var_107_26.name == "split_2" or not string.find(var_107_26.name, "split") then
						var_107_26.gameObject:SetActive(true)
					else
						var_107_26.gameObject:SetActive(false)
					end
				end
			end

			local var_107_27 = 0.001

			if var_107_24 <= arg_104_1.time_ and arg_104_1.time_ < var_107_24 + var_107_27 then
				local var_107_28 = (arg_104_1.time_ - var_107_24) / var_107_27
				local var_107_29 = Vector3.New(-405.76, -414.5, -207.2)

				var_107_23.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1073, var_107_29, var_107_28)
			end

			if arg_104_1.time_ >= var_107_24 + var_107_27 and arg_104_1.time_ < var_107_24 + var_107_27 + arg_107_0 then
				var_107_23.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_107_30 = 0
			local var_107_31 = 0.725

			if var_107_30 < arg_104_1.time_ and arg_104_1.time_ <= var_107_30 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_32 = arg_104_1:FormatText(StoryNameCfg[384].name)

				arg_104_1.leftNameTxt_.text = var_107_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_33 = arg_104_1:GetWordFromCfg(418011026)
				local var_107_34 = arg_104_1:FormatText(var_107_33.content)

				arg_104_1.text_.text = var_107_34

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_35 = 29
				local var_107_36 = utf8.len(var_107_34)
				local var_107_37 = var_107_35 <= 0 and var_107_31 or var_107_31 * (var_107_36 / var_107_35)

				if var_107_37 > 0 and var_107_31 < var_107_37 then
					arg_104_1.talkMaxDuration = var_107_37

					if var_107_37 + var_107_30 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_37 + var_107_30
					end
				end

				arg_104_1.text_.text = var_107_34
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011026", "story_v_side_old_418011.awb") ~= 0 then
					local var_107_38 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011026", "story_v_side_old_418011.awb") / 1000

					if var_107_38 + var_107_30 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_38 + var_107_30
					end

					if var_107_33.prefab_name ~= "" and arg_104_1.actors_[var_107_33.prefab_name] ~= nil then
						local var_107_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_33.prefab_name].transform, "story_v_side_old_418011", "418011026", "story_v_side_old_418011.awb")

						arg_104_1:RecordAudio("418011026", var_107_39)
						arg_104_1:RecordAudio("418011026", var_107_39)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011026", "story_v_side_old_418011.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011026", "story_v_side_old_418011.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_40 = math.max(var_107_31, arg_104_1.talkMaxDuration)

			if var_107_30 <= arg_104_1.time_ and arg_104_1.time_ < var_107_30 + var_107_40 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_30) / var_107_40

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_30 + var_107_40 and arg_104_1.time_ < var_107_30 + var_107_40 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071",
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

		arg_104_1:InitPlayNodeList()
	end,
	Play418011027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 418011027
		arg_108_1.duration_ = 3.7

		local var_108_0 = {
			ja = 3.7,
			CriLanguages = 2.633,
			zh = 2.633
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
			arg_108_1.auto_ = false
		end

		function arg_108_1.playNext_(arg_110_0)
			arg_108_1.onStoryFinished_()
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.325

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[384].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(418011027)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 13
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418011", "418011027", "story_v_side_old_418011.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_side_old_418011", "418011027", "story_v_side_old_418011.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_side_old_418011", "418011027", "story_v_side_old_418011.awb")

						arg_108_1:RecordAudio("418011027", var_111_9)
						arg_108_1:RecordAudio("418011027", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_old_418011", "418011027", "story_v_side_old_418011.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_old_418011", "418011027", "story_v_side_old_418011.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H01a"
	},
	voices = {
		"story_v_side_old_418011.awb"
	}
}
