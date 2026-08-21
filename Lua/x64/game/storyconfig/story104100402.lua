return {
	Play410042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410042001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play410042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L03f"

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
				local var_4_5 = arg_1_1.bgs_.L03f

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
					if iter_4_0 ~= "L03f" then
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

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 1.56666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_8_story_tara_garden", "bgm_activity_2_8_story_tara_garden", "bgm_activity_2_8_story_tara_garden.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_garden", "bgm_activity_2_8_story_tara_garden")

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

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
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

				local var_4_37 = arg_1_1:GetWordFromCfg(410042001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 35
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
	Play410042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410042002
		arg_9_1.duration_ = 2.57

		local var_9_0 = {
			zh = 1.933,
			ja = 2.566
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
				arg_9_0:Play410042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1056"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

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

			local var_12_4 = arg_9_1.actors_["1056"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos1056 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1056", 3)

				local var_12_6 = var_12_4.childCount

				for iter_12_2 = 0, var_12_6 - 1 do
					local var_12_7 = var_12_4:GetChild(iter_12_2)

					if var_12_7.name == "split_1" or not string.find(var_12_7.name, "split") then
						var_12_7.gameObject:SetActive(true)
					else
						var_12_7.gameObject:SetActive(false)
					end
				end
			end

			local var_12_8 = 0.001

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_5) / var_12_8
				local var_12_10 = Vector3.New(0, -350, -180)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1056, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(0, -350, -180)
			end

			local var_12_11 = arg_9_1.actors_["1056"]
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps1056 == nil then
				arg_9_1.var_.actorSpriteComps1056 = var_12_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_13 = 0.034

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_13 and not isNil(var_12_11) then
				local var_12_14 = (arg_9_1.time_ - var_12_12) / var_12_13

				if arg_9_1.var_.actorSpriteComps1056 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_9_1.time_ >= var_12_12 + var_12_13 and arg_9_1.time_ < var_12_12 + var_12_13 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps1056 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_12_6 then
						if arg_9_1.isInRecall_ then
							iter_12_6.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1056 = nil
			end

			local var_12_19 = 0
			local var_12_20 = 0.25

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_21 = arg_9_1:FormatText(StoryNameCfg[605].name)

				arg_9_1.leftNameTxt_.text = var_12_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_22 = arg_9_1:GetWordFromCfg(410042002)
				local var_12_23 = arg_9_1:FormatText(var_12_22.content)

				arg_9_1.text_.text = var_12_23

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_24 = 10
				local var_12_25 = utf8.len(var_12_23)
				local var_12_26 = var_12_24 <= 0 and var_12_20 or var_12_20 * (var_12_25 / var_12_24)

				if var_12_26 > 0 and var_12_20 < var_12_26 then
					arg_9_1.talkMaxDuration = var_12_26

					if var_12_26 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_26 + var_12_19
					end
				end

				arg_9_1.text_.text = var_12_23
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042002", "story_v_out_410042.awb") ~= 0 then
					local var_12_27 = manager.audio:GetVoiceLength("story_v_out_410042", "410042002", "story_v_out_410042.awb") / 1000

					if var_12_27 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_19
					end

					if var_12_22.prefab_name ~= "" and arg_9_1.actors_[var_12_22.prefab_name] ~= nil then
						local var_12_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_22.prefab_name].transform, "story_v_out_410042", "410042002", "story_v_out_410042.awb")

						arg_9_1:RecordAudio("410042002", var_12_28)
						arg_9_1:RecordAudio("410042002", var_12_28)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410042", "410042002", "story_v_out_410042.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410042", "410042002", "story_v_out_410042.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_29 = math.max(var_12_20, arg_9_1.talkMaxDuration)

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_29 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_19) / var_12_29

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_19 + var_12_29 and arg_9_1.time_ < var_12_19 + var_12_29 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410042003
		arg_13_1.duration_ = 2.83

		local var_13_0 = {
			zh = 1.133,
			ja = 2.833
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
				arg_13_0:Play410042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10059"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

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

			local var_16_4 = arg_13_1.actors_["10059"].transform
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.var_.moveOldPos10059 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10059", 3)

				local var_16_6 = var_16_4.childCount

				for iter_16_2 = 0, var_16_6 - 1 do
					local var_16_7 = var_16_4:GetChild(iter_16_2)

					if var_16_7.name == "" or not string.find(var_16_7.name, "split") then
						var_16_7.gameObject:SetActive(true)
					else
						var_16_7.gameObject:SetActive(false)
					end
				end
			end

			local var_16_8 = 0.001

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_5) / var_16_8
				local var_16_10 = Vector3.New(0, -530, 35)

				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10059, var_16_10, var_16_9)
			end

			if arg_13_1.time_ >= var_16_5 + var_16_8 and arg_13_1.time_ < var_16_5 + var_16_8 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(0, -530, 35)
			end

			local var_16_11 = arg_13_1.actors_["10059"]
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10059 == nil then
				arg_13_1.var_.actorSpriteComps10059 = var_16_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_13 = 0.034

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_13 and not isNil(var_16_11) then
				local var_16_14 = (arg_13_1.time_ - var_16_12) / var_16_13

				if arg_13_1.var_.actorSpriteComps10059 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								local var_16_15 = Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor1.r, var_16_14)
								local var_16_16 = Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor1.g, var_16_14)
								local var_16_17 = Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor1.b, var_16_14)

								iter_16_4.color = Color.New(var_16_15, var_16_16, var_16_17)
							else
								local var_16_18 = Mathf.Lerp(iter_16_4.color.r, 1, var_16_14)

								iter_16_4.color = Color.New(var_16_18, var_16_18, var_16_18)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10059 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_16_6 then
						if arg_13_1.isInRecall_ then
							iter_16_6.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10059 = nil
			end

			local var_16_19 = 0
			local var_16_20 = 0.075

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_21 = arg_13_1:FormatText(StoryNameCfg[596].name)

				arg_13_1.leftNameTxt_.text = var_16_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_22 = arg_13_1:GetWordFromCfg(410042003)
				local var_16_23 = arg_13_1:FormatText(var_16_22.content)

				arg_13_1.text_.text = var_16_23

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_24 = 3
				local var_16_25 = utf8.len(var_16_23)
				local var_16_26 = var_16_24 <= 0 and var_16_20 or var_16_20 * (var_16_25 / var_16_24)

				if var_16_26 > 0 and var_16_20 < var_16_26 then
					arg_13_1.talkMaxDuration = var_16_26

					if var_16_26 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_26 + var_16_19
					end
				end

				arg_13_1.text_.text = var_16_23
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042003", "story_v_out_410042.awb") ~= 0 then
					local var_16_27 = manager.audio:GetVoiceLength("story_v_out_410042", "410042003", "story_v_out_410042.awb") / 1000

					if var_16_27 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_19
					end

					if var_16_22.prefab_name ~= "" and arg_13_1.actors_[var_16_22.prefab_name] ~= nil then
						local var_16_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_22.prefab_name].transform, "story_v_out_410042", "410042003", "story_v_out_410042.awb")

						arg_13_1:RecordAudio("410042003", var_16_28)
						arg_13_1:RecordAudio("410042003", var_16_28)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410042", "410042003", "story_v_out_410042.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410042", "410042003", "story_v_out_410042.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_29 = math.max(var_16_20, arg_13_1.talkMaxDuration)

			if var_16_19 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_29 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_19) / var_16_29

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_19 + var_16_29 and arg_13_1.time_ < var_16_19 + var_16_29 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play410042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410042004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1060"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(var_20_1, arg_17_1.canvasGo_.transform)

					var_20_2.transform:SetSiblingIndex(1)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs(var_20_3) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_4 = arg_17_1.actors_["1060"].transform
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.var_.moveOldPos1060 = var_20_4.localPosition
				var_20_4.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1060", 2)

				local var_20_6 = var_20_4.childCount

				for iter_20_2 = 0, var_20_6 - 1 do
					local var_20_7 = var_20_4:GetChild(iter_20_2)

					if var_20_7.name == "" or not string.find(var_20_7.name, "split") then
						var_20_7.gameObject:SetActive(true)
					else
						var_20_7.gameObject:SetActive(false)
					end
				end
			end

			local var_20_8 = 0.001

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_8 then
				local var_20_9 = (arg_17_1.time_ - var_20_5) / var_20_8
				local var_20_10 = Vector3.New(-440.94, -430.8, 6.9)

				var_20_4.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1060, var_20_10, var_20_9)
			end

			if arg_17_1.time_ >= var_20_5 + var_20_8 and arg_17_1.time_ < var_20_5 + var_20_8 + arg_20_0 then
				var_20_4.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_20_11 = arg_17_1.actors_["10059"].transform
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.var_.moveOldPos10059 = var_20_11.localPosition
				var_20_11.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10059", 4)

				local var_20_13 = var_20_11.childCount

				for iter_20_3 = 0, var_20_13 - 1 do
					local var_20_14 = var_20_11:GetChild(iter_20_3)

					if var_20_14.name == "" or not string.find(var_20_14.name, "split") then
						var_20_14.gameObject:SetActive(true)
					else
						var_20_14.gameObject:SetActive(false)
					end
				end
			end

			local var_20_15 = 0.001

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_15 then
				local var_20_16 = (arg_17_1.time_ - var_20_12) / var_20_15
				local var_20_17 = Vector3.New(390, -530, 35)

				var_20_11.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10059, var_20_17, var_20_16)
			end

			if arg_17_1.time_ >= var_20_12 + var_20_15 and arg_17_1.time_ < var_20_12 + var_20_15 + arg_20_0 then
				var_20_11.localPosition = Vector3.New(390, -530, 35)
			end

			local var_20_18 = arg_17_1.actors_["1056"].transform
			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1.var_.moveOldPos1056 = var_20_18.localPosition
				var_20_18.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1056", 7)

				local var_20_20 = var_20_18.childCount

				for iter_20_4 = 0, var_20_20 - 1 do
					local var_20_21 = var_20_18:GetChild(iter_20_4)

					if var_20_21.name == "" or not string.find(var_20_21.name, "split") then
						var_20_21.gameObject:SetActive(true)
					else
						var_20_21.gameObject:SetActive(false)
					end
				end
			end

			local var_20_22 = 0.001

			if var_20_19 <= arg_17_1.time_ and arg_17_1.time_ < var_20_19 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_19) / var_20_22
				local var_20_24 = Vector3.New(0, -2000, -180)

				var_20_18.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1056, var_20_24, var_20_23)
			end

			if arg_17_1.time_ >= var_20_19 + var_20_22 and arg_17_1.time_ < var_20_19 + var_20_22 + arg_20_0 then
				var_20_18.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_20_25 = arg_17_1.actors_["1060"]
			local var_20_26 = 0

			if var_20_26 < arg_17_1.time_ and arg_17_1.time_ <= var_20_26 + arg_20_0 and not isNil(var_20_25) and arg_17_1.var_.actorSpriteComps1060 == nil then
				arg_17_1.var_.actorSpriteComps1060 = var_20_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_27 = 0.034

			if var_20_26 <= arg_17_1.time_ and arg_17_1.time_ < var_20_26 + var_20_27 and not isNil(var_20_25) then
				local var_20_28 = (arg_17_1.time_ - var_20_26) / var_20_27

				if arg_17_1.var_.actorSpriteComps1060 then
					for iter_20_5, iter_20_6 in pairs(arg_17_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_20_6 then
							if arg_17_1.isInRecall_ then
								local var_20_29 = Mathf.Lerp(iter_20_6.color.r, arg_17_1.hightColor2.r, var_20_28)
								local var_20_30 = Mathf.Lerp(iter_20_6.color.g, arg_17_1.hightColor2.g, var_20_28)
								local var_20_31 = Mathf.Lerp(iter_20_6.color.b, arg_17_1.hightColor2.b, var_20_28)

								iter_20_6.color = Color.New(var_20_29, var_20_30, var_20_31)
							else
								local var_20_32 = Mathf.Lerp(iter_20_6.color.r, 0.5, var_20_28)

								iter_20_6.color = Color.New(var_20_32, var_20_32, var_20_32)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_26 + var_20_27 and arg_17_1.time_ < var_20_26 + var_20_27 + arg_20_0 and not isNil(var_20_25) and arg_17_1.var_.actorSpriteComps1060 then
				for iter_20_7, iter_20_8 in pairs(arg_17_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_20_8 then
						if arg_17_1.isInRecall_ then
							iter_20_8.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1060 = nil
			end

			local var_20_33 = arg_17_1.actors_["10059"]
			local var_20_34 = 0

			if var_20_34 < arg_17_1.time_ and arg_17_1.time_ <= var_20_34 + arg_20_0 and not isNil(var_20_33) and arg_17_1.var_.actorSpriteComps10059 == nil then
				arg_17_1.var_.actorSpriteComps10059 = var_20_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_35 = 0.034

			if var_20_34 <= arg_17_1.time_ and arg_17_1.time_ < var_20_34 + var_20_35 and not isNil(var_20_33) then
				local var_20_36 = (arg_17_1.time_ - var_20_34) / var_20_35

				if arg_17_1.var_.actorSpriteComps10059 then
					for iter_20_9, iter_20_10 in pairs(arg_17_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_20_10 then
							if arg_17_1.isInRecall_ then
								local var_20_37 = Mathf.Lerp(iter_20_10.color.r, arg_17_1.hightColor2.r, var_20_36)
								local var_20_38 = Mathf.Lerp(iter_20_10.color.g, arg_17_1.hightColor2.g, var_20_36)
								local var_20_39 = Mathf.Lerp(iter_20_10.color.b, arg_17_1.hightColor2.b, var_20_36)

								iter_20_10.color = Color.New(var_20_37, var_20_38, var_20_39)
							else
								local var_20_40 = Mathf.Lerp(iter_20_10.color.r, 0.5, var_20_36)

								iter_20_10.color = Color.New(var_20_40, var_20_40, var_20_40)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_34 + var_20_35 and arg_17_1.time_ < var_20_34 + var_20_35 + arg_20_0 and not isNil(var_20_33) and arg_17_1.var_.actorSpriteComps10059 then
				for iter_20_11, iter_20_12 in pairs(arg_17_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_20_12 then
						if arg_17_1.isInRecall_ then
							iter_20_12.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10059 = nil
			end

			local var_20_41 = arg_17_1.actors_["1056"]
			local var_20_42 = 0

			if var_20_42 < arg_17_1.time_ and arg_17_1.time_ <= var_20_42 + arg_20_0 and not isNil(var_20_41) and arg_17_1.var_.actorSpriteComps1056 == nil then
				arg_17_1.var_.actorSpriteComps1056 = var_20_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_43 = 0.034

			if var_20_42 <= arg_17_1.time_ and arg_17_1.time_ < var_20_42 + var_20_43 and not isNil(var_20_41) then
				local var_20_44 = (arg_17_1.time_ - var_20_42) / var_20_43

				if arg_17_1.var_.actorSpriteComps1056 then
					for iter_20_13, iter_20_14 in pairs(arg_17_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_20_14 then
							if arg_17_1.isInRecall_ then
								local var_20_45 = Mathf.Lerp(iter_20_14.color.r, arg_17_1.hightColor2.r, var_20_44)
								local var_20_46 = Mathf.Lerp(iter_20_14.color.g, arg_17_1.hightColor2.g, var_20_44)
								local var_20_47 = Mathf.Lerp(iter_20_14.color.b, arg_17_1.hightColor2.b, var_20_44)

								iter_20_14.color = Color.New(var_20_45, var_20_46, var_20_47)
							else
								local var_20_48 = Mathf.Lerp(iter_20_14.color.r, 0.5, var_20_44)

								iter_20_14.color = Color.New(var_20_48, var_20_48, var_20_48)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_42 + var_20_43 and arg_17_1.time_ < var_20_42 + var_20_43 + arg_20_0 and not isNil(var_20_41) and arg_17_1.var_.actorSpriteComps1056 then
				for iter_20_15, iter_20_16 in pairs(arg_17_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_20_16 then
						if arg_17_1.isInRecall_ then
							iter_20_16.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_16.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1056 = nil
			end

			local var_20_49 = 0
			local var_20_50 = 0.925

			if var_20_49 < arg_17_1.time_ and arg_17_1.time_ <= var_20_49 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_51 = arg_17_1:GetWordFromCfg(410042004)
				local var_20_52 = arg_17_1:FormatText(var_20_51.content)

				arg_17_1.text_.text = var_20_52

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_53 = 37
				local var_20_54 = utf8.len(var_20_52)
				local var_20_55 = var_20_53 <= 0 and var_20_50 or var_20_50 * (var_20_54 / var_20_53)

				if var_20_55 > 0 and var_20_50 < var_20_55 then
					arg_17_1.talkMaxDuration = var_20_55

					if var_20_55 + var_20_49 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_55 + var_20_49
					end
				end

				arg_17_1.text_.text = var_20_52
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_56 = math.max(var_20_50, arg_17_1.talkMaxDuration)

			if var_20_49 <= arg_17_1.time_ and arg_17_1.time_ < var_20_49 + var_20_56 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_49) / var_20_56

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_49 + var_20_56 and arg_17_1.time_ < var_20_49 + var_20_56 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
				actorName = "1056",
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
	Play410042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410042005
		arg_21_1.duration_ = 9.4

		local var_21_0 = {
			zh = 6.066,
			ja = 9.4
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
				arg_21_0:Play410042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10059"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10059 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10059", 4)

				local var_24_2 = var_24_0.childCount

				for iter_24_0 = 0, var_24_2 - 1 do
					local var_24_3 = var_24_0:GetChild(iter_24_0)

					if var_24_3.name == "split_2" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_4 then
				local var_24_5 = (arg_21_1.time_ - var_24_1) / var_24_4
				local var_24_6 = Vector3.New(390, -530, 35)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10059, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_24_7 = arg_21_1.actors_["10059"]
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps10059 == nil then
				arg_21_1.var_.actorSpriteComps10059 = var_24_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 0.034

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 and not isNil(var_24_7) then
				local var_24_10 = (arg_21_1.time_ - var_24_8) / var_24_9

				if arg_21_1.var_.actorSpriteComps10059 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps10059 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_24_4 then
						if arg_21_1.isInRecall_ then
							iter_24_4.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10059 = nil
			end

			local var_24_15 = 0
			local var_24_16 = 0.525

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[596].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(410042005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042005", "story_v_out_410042.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_410042", "410042005", "story_v_out_410042.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_410042", "410042005", "story_v_out_410042.awb")

						arg_21_1:RecordAudio("410042005", var_24_24)
						arg_21_1:RecordAudio("410042005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410042", "410042005", "story_v_out_410042.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410042", "410042005", "story_v_out_410042.awb")
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
				actorName = "10059",
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
	Play410042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410042006
		arg_25_1.duration_ = 12.73

		local var_25_0 = {
			zh = 4.233,
			ja = 12.733
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
				arg_25_0:Play410042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1060"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1060 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1060", 2)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "split_1" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1060, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_28_7 = arg_25_1.actors_["1060"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1060 == nil then
				arg_25_1.var_.actorSpriteComps1060 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.034

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps1060 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1060 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1060 = nil
			end

			local var_28_15 = arg_25_1.actors_["10059"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps10059 == nil then
				arg_25_1.var_.actorSpriteComps10059 = var_28_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_17 = 0.034

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.actorSpriteComps10059 then
					for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_28_6 then
							if arg_25_1.isInRecall_ then
								local var_28_19 = Mathf.Lerp(iter_28_6.color.r, arg_25_1.hightColor2.r, var_28_18)
								local var_28_20 = Mathf.Lerp(iter_28_6.color.g, arg_25_1.hightColor2.g, var_28_18)
								local var_28_21 = Mathf.Lerp(iter_28_6.color.b, arg_25_1.hightColor2.b, var_28_18)

								iter_28_6.color = Color.New(var_28_19, var_28_20, var_28_21)
							else
								local var_28_22 = Mathf.Lerp(iter_28_6.color.r, 0.5, var_28_18)

								iter_28_6.color = Color.New(var_28_22, var_28_22, var_28_22)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps10059 then
				for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_28_8 then
						if arg_25_1.isInRecall_ then
							iter_28_8.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10059 = nil
			end

			local var_28_23 = 0
			local var_28_24 = 0.425

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_25 = arg_25_1:FormatText(StoryNameCfg[584].name)

				arg_25_1.leftNameTxt_.text = var_28_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_26 = arg_25_1:GetWordFromCfg(410042006)
				local var_28_27 = arg_25_1:FormatText(var_28_26.content)

				arg_25_1.text_.text = var_28_27

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_28 = 17
				local var_28_29 = utf8.len(var_28_27)
				local var_28_30 = var_28_28 <= 0 and var_28_24 or var_28_24 * (var_28_29 / var_28_28)

				if var_28_30 > 0 and var_28_24 < var_28_30 then
					arg_25_1.talkMaxDuration = var_28_30

					if var_28_30 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_30 + var_28_23
					end
				end

				arg_25_1.text_.text = var_28_27
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042006", "story_v_out_410042.awb") ~= 0 then
					local var_28_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042006", "story_v_out_410042.awb") / 1000

					if var_28_31 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_31 + var_28_23
					end

					if var_28_26.prefab_name ~= "" and arg_25_1.actors_[var_28_26.prefab_name] ~= nil then
						local var_28_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_26.prefab_name].transform, "story_v_out_410042", "410042006", "story_v_out_410042.awb")

						arg_25_1:RecordAudio("410042006", var_28_32)
						arg_25_1:RecordAudio("410042006", var_28_32)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410042", "410042006", "story_v_out_410042.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410042", "410042006", "story_v_out_410042.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_33 = math.max(var_28_24, arg_25_1.talkMaxDuration)

			if var_28_23 <= arg_25_1.time_ and arg_25_1.time_ < var_28_23 + var_28_33 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_23) / var_28_33

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_23 + var_28_33 and arg_25_1.time_ < var_28_23 + var_28_33 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410042007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play410042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1060"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1060 == nil then
				arg_29_1.var_.actorSpriteComps1060 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.034

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps1060 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1060 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1060 = nil
			end

			local var_32_8 = arg_29_1.actors_["10059"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10059 == nil then
				arg_29_1.var_.actorSpriteComps10059 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.034

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps10059 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10059 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10059 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.975

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(410042007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 39
				local var_32_21 = utf8.len(var_32_19)
				local var_32_22 = var_32_20 <= 0 and var_32_17 or var_32_17 * (var_32_21 / var_32_20)

				if var_32_22 > 0 and var_32_17 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_16
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_23 = math.max(var_32_17, arg_29_1.talkMaxDuration)

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_23 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_16) / var_32_23

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_16 + var_32_23 and arg_29_1.time_ < var_32_16 + var_32_23 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play410042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410042008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play410042009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				local var_36_2 = "play"
				local var_36_3 = "effect"

				arg_33_1:AudioAction(var_36_2, var_36_3, "se_story_side_1055", "se_story_side_1055_rain", "")
			end

			local var_36_4 = 0
			local var_36_5 = 0.825

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(410042008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_8 = 33
				local var_36_9 = utf8.len(var_36_7)
				local var_36_10 = var_36_8 <= 0 and var_36_5 or var_36_5 * (var_36_9 / var_36_8)

				if var_36_10 > 0 and var_36_5 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_11 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_11 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_11

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_11 and arg_33_1.time_ < var_36_4 + var_36_11 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play410042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410042009
		arg_37_1.duration_ = 3.23

		local var_37_0 = {
			zh = 2.3,
			ja = 3.233
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
				arg_37_0:Play410042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1056"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1056 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1056", 2)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_4" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(-390, -350, -180)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1056, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_40_7 = arg_37_1.actors_["1060"].transform
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.var_.moveOldPos1060 = var_40_7.localPosition
				var_40_7.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1060", 7)

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
				local var_40_13 = Vector3.New(0, -2000, -40)

				var_40_7.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1060, var_40_13, var_40_12)
			end

			if arg_37_1.time_ >= var_40_8 + var_40_11 and arg_37_1.time_ < var_40_8 + var_40_11 + arg_40_0 then
				var_40_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_40_14 = arg_37_1.actors_["1056"]
			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.actorSpriteComps1056 == nil then
				arg_37_1.var_.actorSpriteComps1056 = var_40_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_16 = 0.034

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_16 and not isNil(var_40_14) then
				local var_40_17 = (arg_37_1.time_ - var_40_15) / var_40_16

				if arg_37_1.var_.actorSpriteComps1056 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								local var_40_18 = Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, var_40_17)
								local var_40_19 = Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, var_40_17)
								local var_40_20 = Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, var_40_17)

								iter_40_3.color = Color.New(var_40_18, var_40_19, var_40_20)
							else
								local var_40_21 = Mathf.Lerp(iter_40_3.color.r, 1, var_40_17)

								iter_40_3.color = Color.New(var_40_21, var_40_21, var_40_21)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_15 + var_40_16 and arg_37_1.time_ < var_40_15 + var_40_16 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.actorSpriteComps1056 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_40_5 then
						if arg_37_1.isInRecall_ then
							iter_40_5.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1056 = nil
			end

			local var_40_22 = arg_37_1.actors_["1060"]
			local var_40_23 = 0

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 and not isNil(var_40_22) and arg_37_1.var_.actorSpriteComps1060 == nil then
				arg_37_1.var_.actorSpriteComps1060 = var_40_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_24 = 0.034

			if var_40_23 <= arg_37_1.time_ and arg_37_1.time_ < var_40_23 + var_40_24 and not isNil(var_40_22) then
				local var_40_25 = (arg_37_1.time_ - var_40_23) / var_40_24

				if arg_37_1.var_.actorSpriteComps1060 then
					for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_40_7 then
							if arg_37_1.isInRecall_ then
								local var_40_26 = Mathf.Lerp(iter_40_7.color.r, arg_37_1.hightColor2.r, var_40_25)
								local var_40_27 = Mathf.Lerp(iter_40_7.color.g, arg_37_1.hightColor2.g, var_40_25)
								local var_40_28 = Mathf.Lerp(iter_40_7.color.b, arg_37_1.hightColor2.b, var_40_25)

								iter_40_7.color = Color.New(var_40_26, var_40_27, var_40_28)
							else
								local var_40_29 = Mathf.Lerp(iter_40_7.color.r, 0.5, var_40_25)

								iter_40_7.color = Color.New(var_40_29, var_40_29, var_40_29)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_23 + var_40_24 and arg_37_1.time_ < var_40_23 + var_40_24 + arg_40_0 and not isNil(var_40_22) and arg_37_1.var_.actorSpriteComps1060 then
				for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_40_9 then
						if arg_37_1.isInRecall_ then
							iter_40_9.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1060 = nil
			end

			local var_40_30 = 0
			local var_40_31 = 0.225

			if var_40_30 < arg_37_1.time_ and arg_37_1.time_ <= var_40_30 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_32 = arg_37_1:FormatText(StoryNameCfg[605].name)

				arg_37_1.leftNameTxt_.text = var_40_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_33 = arg_37_1:GetWordFromCfg(410042009)
				local var_40_34 = arg_37_1:FormatText(var_40_33.content)

				arg_37_1.text_.text = var_40_34

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_35 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042009", "story_v_out_410042.awb") ~= 0 then
					local var_40_38 = manager.audio:GetVoiceLength("story_v_out_410042", "410042009", "story_v_out_410042.awb") / 1000

					if var_40_38 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_38 + var_40_30
					end

					if var_40_33.prefab_name ~= "" and arg_37_1.actors_[var_40_33.prefab_name] ~= nil then
						local var_40_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_33.prefab_name].transform, "story_v_out_410042", "410042009", "story_v_out_410042.awb")

						arg_37_1:RecordAudio("410042009", var_40_39)
						arg_37_1:RecordAudio("410042009", var_40_39)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410042", "410042009", "story_v_out_410042.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410042", "410042009", "story_v_out_410042.awb")
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
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410042010
		arg_41_1.duration_ = 8.1

		local var_41_0 = {
			zh = 3.133,
			ja = 8.1
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
				arg_41_0:Play410042011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1060"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1060 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1060", 2)

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
				local var_44_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1060, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_44_7 = arg_41_1.actors_["1056"].transform
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.var_.moveOldPos1056 = var_44_7.localPosition
				var_44_7.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1056", 7)

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
				local var_44_13 = Vector3.New(0, -2000, -180)

				var_44_7.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1056, var_44_13, var_44_12)
			end

			if arg_41_1.time_ >= var_44_8 + var_44_11 and arg_41_1.time_ < var_44_8 + var_44_11 + arg_44_0 then
				var_44_7.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_44_14 = arg_41_1.actors_["1060"]
			local var_44_15 = 0

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 and not isNil(var_44_14) and arg_41_1.var_.actorSpriteComps1060 == nil then
				arg_41_1.var_.actorSpriteComps1060 = var_44_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_16 = 0.034

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_16 and not isNil(var_44_14) then
				local var_44_17 = (arg_41_1.time_ - var_44_15) / var_44_16

				if arg_41_1.var_.actorSpriteComps1060 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_44_3 then
							if arg_41_1.isInRecall_ then
								local var_44_18 = Mathf.Lerp(iter_44_3.color.r, arg_41_1.hightColor1.r, var_44_17)
								local var_44_19 = Mathf.Lerp(iter_44_3.color.g, arg_41_1.hightColor1.g, var_44_17)
								local var_44_20 = Mathf.Lerp(iter_44_3.color.b, arg_41_1.hightColor1.b, var_44_17)

								iter_44_3.color = Color.New(var_44_18, var_44_19, var_44_20)
							else
								local var_44_21 = Mathf.Lerp(iter_44_3.color.r, 1, var_44_17)

								iter_44_3.color = Color.New(var_44_21, var_44_21, var_44_21)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_15 + var_44_16 and arg_41_1.time_ < var_44_15 + var_44_16 + arg_44_0 and not isNil(var_44_14) and arg_41_1.var_.actorSpriteComps1060 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_44_5 then
						if arg_41_1.isInRecall_ then
							iter_44_5.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1060 = nil
			end

			local var_44_22 = arg_41_1.actors_["1056"]
			local var_44_23 = 0

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.actorSpriteComps1056 == nil then
				arg_41_1.var_.actorSpriteComps1056 = var_44_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_24 = 0.034

			if var_44_23 <= arg_41_1.time_ and arg_41_1.time_ < var_44_23 + var_44_24 and not isNil(var_44_22) then
				local var_44_25 = (arg_41_1.time_ - var_44_23) / var_44_24

				if arg_41_1.var_.actorSpriteComps1056 then
					for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_44_7 then
							if arg_41_1.isInRecall_ then
								local var_44_26 = Mathf.Lerp(iter_44_7.color.r, arg_41_1.hightColor2.r, var_44_25)
								local var_44_27 = Mathf.Lerp(iter_44_7.color.g, arg_41_1.hightColor2.g, var_44_25)
								local var_44_28 = Mathf.Lerp(iter_44_7.color.b, arg_41_1.hightColor2.b, var_44_25)

								iter_44_7.color = Color.New(var_44_26, var_44_27, var_44_28)
							else
								local var_44_29 = Mathf.Lerp(iter_44_7.color.r, 0.5, var_44_25)

								iter_44_7.color = Color.New(var_44_29, var_44_29, var_44_29)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_23 + var_44_24 and arg_41_1.time_ < var_44_23 + var_44_24 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.actorSpriteComps1056 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_44_9 then
						if arg_41_1.isInRecall_ then
							iter_44_9.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1056 = nil
			end

			local var_44_30 = 0
			local var_44_31 = 0.4

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[584].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(410042010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 16
				local var_44_36 = utf8.len(var_44_34)
				local var_44_37 = var_44_35 <= 0 and var_44_31 or var_44_31 * (var_44_36 / var_44_35)

				if var_44_37 > 0 and var_44_31 < var_44_37 then
					arg_41_1.talkMaxDuration = var_44_37

					if var_44_37 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_37 + var_44_30
					end
				end

				arg_41_1.text_.text = var_44_34
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042010", "story_v_out_410042.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_410042", "410042010", "story_v_out_410042.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_410042", "410042010", "story_v_out_410042.awb")

						arg_41_1:RecordAudio("410042010", var_44_39)
						arg_41_1:RecordAudio("410042010", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410042", "410042010", "story_v_out_410042.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410042", "410042010", "story_v_out_410042.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_40 = math.max(var_44_31, arg_41_1.talkMaxDuration)

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_40 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_30) / var_44_40

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_30 + var_44_40 and arg_41_1.time_ < var_44_30 + var_44_40 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
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
	Play410042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410042011
		arg_45_1.duration_ = 4.8

		local var_45_0 = {
			zh = 4.3,
			ja = 4.8
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
				arg_45_0:Play410042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10059"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10059 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10059", 4)

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
				local var_48_6 = Vector3.New(390, -530, 35)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10059, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_48_7 = arg_45_1.actors_["10059"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10059 == nil then
				arg_45_1.var_.actorSpriteComps10059 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 0.034

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps10059 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10059 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10059 = nil
			end

			local var_48_15 = arg_45_1.actors_["1060"]
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps1060 == nil then
				arg_45_1.var_.actorSpriteComps1060 = var_48_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_17 = 0.034

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 and not isNil(var_48_15) then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17

				if arg_45_1.var_.actorSpriteComps1060 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								local var_48_19 = Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor2.r, var_48_18)
								local var_48_20 = Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor2.g, var_48_18)
								local var_48_21 = Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor2.b, var_48_18)

								iter_48_6.color = Color.New(var_48_19, var_48_20, var_48_21)
							else
								local var_48_22 = Mathf.Lerp(iter_48_6.color.r, 0.5, var_48_18)

								iter_48_6.color = Color.New(var_48_22, var_48_22, var_48_22)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps1060 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_48_8 then
						if arg_45_1.isInRecall_ then
							iter_48_8.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1060 = nil
			end

			local var_48_23 = 0
			local var_48_24 = 0.525

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_25 = arg_45_1:FormatText(StoryNameCfg[596].name)

				arg_45_1.leftNameTxt_.text = var_48_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_26 = arg_45_1:GetWordFromCfg(410042011)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 21
				local var_48_29 = utf8.len(var_48_27)
				local var_48_30 = var_48_28 <= 0 and var_48_24 or var_48_24 * (var_48_29 / var_48_28)

				if var_48_30 > 0 and var_48_24 < var_48_30 then
					arg_45_1.talkMaxDuration = var_48_30

					if var_48_30 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_30 + var_48_23
					end
				end

				arg_45_1.text_.text = var_48_27
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042011", "story_v_out_410042.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042011", "story_v_out_410042.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_410042", "410042011", "story_v_out_410042.awb")

						arg_45_1:RecordAudio("410042011", var_48_32)
						arg_45_1:RecordAudio("410042011", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410042", "410042011", "story_v_out_410042.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410042", "410042011", "story_v_out_410042.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_33 = math.max(var_48_24, arg_45_1.talkMaxDuration)

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_33 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_23) / var_48_33

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_23 + var_48_33 and arg_45_1.time_ < var_48_23 + var_48_33 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play410042012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410042012
		arg_49_1.duration_ = 11.57

		local var_49_0 = {
			zh = 4.3,
			ja = 11.566
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
				arg_49_0:Play410042013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10059"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10059 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10059", 4)

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
				local var_52_6 = Vector3.New(390, -530, 35)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10059, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_52_7 = arg_49_1.actors_["10059"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10059 == nil then
				arg_49_1.var_.actorSpriteComps10059 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.034

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps10059 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								local var_52_11 = Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, var_52_10)
								local var_52_12 = Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, var_52_10)
								local var_52_13 = Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, var_52_10)

								iter_52_2.color = Color.New(var_52_11, var_52_12, var_52_13)
							else
								local var_52_14 = Mathf.Lerp(iter_52_2.color.r, 1, var_52_10)

								iter_52_2.color = Color.New(var_52_14, var_52_14, var_52_14)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10059 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10059 = nil
			end

			local var_52_15 = 0
			local var_52_16 = 0.55

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[596].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(410042012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 23
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042012", "story_v_out_410042.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_410042", "410042012", "story_v_out_410042.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_410042", "410042012", "story_v_out_410042.awb")

						arg_49_1:RecordAudio("410042012", var_52_24)
						arg_49_1:RecordAudio("410042012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410042", "410042012", "story_v_out_410042.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410042", "410042012", "story_v_out_410042.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_25 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_25

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_25 and arg_49_1.time_ < var_52_15 + var_52_25 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play410042013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410042013
		arg_53_1.duration_ = 9.97

		local var_53_0 = {
			zh = 8.733,
			ja = 9.966
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
				arg_53_0:Play410042014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1056"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1056 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1056", 2)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "split_1" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(-390, -350, -180)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1056, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_56_7 = arg_53_1.actors_["1060"].transform
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.var_.moveOldPos1060 = var_56_7.localPosition
				var_56_7.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1060", 7)

				local var_56_9 = var_56_7.childCount

				for iter_56_1 = 0, var_56_9 - 1 do
					local var_56_10 = var_56_7:GetChild(iter_56_1)

					if var_56_10.name == "" or not string.find(var_56_10.name, "split") then
						var_56_10.gameObject:SetActive(true)
					else
						var_56_10.gameObject:SetActive(false)
					end
				end
			end

			local var_56_11 = 0.001

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_8) / var_56_11
				local var_56_13 = Vector3.New(0, -2000, -40)

				var_56_7.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1060, var_56_13, var_56_12)
			end

			if arg_53_1.time_ >= var_56_8 + var_56_11 and arg_53_1.time_ < var_56_8 + var_56_11 + arg_56_0 then
				var_56_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_56_14 = arg_53_1.actors_["1056"]
			local var_56_15 = 0

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.actorSpriteComps1056 == nil then
				arg_53_1.var_.actorSpriteComps1056 = var_56_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_16 = 0.034

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_16 and not isNil(var_56_14) then
				local var_56_17 = (arg_53_1.time_ - var_56_15) / var_56_16

				if arg_53_1.var_.actorSpriteComps1056 then
					for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_56_3 then
							if arg_53_1.isInRecall_ then
								local var_56_18 = Mathf.Lerp(iter_56_3.color.r, arg_53_1.hightColor1.r, var_56_17)
								local var_56_19 = Mathf.Lerp(iter_56_3.color.g, arg_53_1.hightColor1.g, var_56_17)
								local var_56_20 = Mathf.Lerp(iter_56_3.color.b, arg_53_1.hightColor1.b, var_56_17)

								iter_56_3.color = Color.New(var_56_18, var_56_19, var_56_20)
							else
								local var_56_21 = Mathf.Lerp(iter_56_3.color.r, 1, var_56_17)

								iter_56_3.color = Color.New(var_56_21, var_56_21, var_56_21)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_15 + var_56_16 and arg_53_1.time_ < var_56_15 + var_56_16 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.actorSpriteComps1056 then
				for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_56_5 then
						if arg_53_1.isInRecall_ then
							iter_56_5.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1056 = nil
			end

			local var_56_22 = arg_53_1.actors_["1060"]
			local var_56_23 = 0

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 and not isNil(var_56_22) and arg_53_1.var_.actorSpriteComps1060 == nil then
				arg_53_1.var_.actorSpriteComps1060 = var_56_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_24 = 0.034

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_24 and not isNil(var_56_22) then
				local var_56_25 = (arg_53_1.time_ - var_56_23) / var_56_24

				if arg_53_1.var_.actorSpriteComps1060 then
					for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_56_7 then
							if arg_53_1.isInRecall_ then
								local var_56_26 = Mathf.Lerp(iter_56_7.color.r, arg_53_1.hightColor2.r, var_56_25)
								local var_56_27 = Mathf.Lerp(iter_56_7.color.g, arg_53_1.hightColor2.g, var_56_25)
								local var_56_28 = Mathf.Lerp(iter_56_7.color.b, arg_53_1.hightColor2.b, var_56_25)

								iter_56_7.color = Color.New(var_56_26, var_56_27, var_56_28)
							else
								local var_56_29 = Mathf.Lerp(iter_56_7.color.r, 0.5, var_56_25)

								iter_56_7.color = Color.New(var_56_29, var_56_29, var_56_29)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_23 + var_56_24 and arg_53_1.time_ < var_56_23 + var_56_24 + arg_56_0 and not isNil(var_56_22) and arg_53_1.var_.actorSpriteComps1060 then
				for iter_56_8, iter_56_9 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_56_9 then
						if arg_53_1.isInRecall_ then
							iter_56_9.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1060 = nil
			end

			local var_56_30 = arg_53_1.actors_["10059"]
			local var_56_31 = 0

			if var_56_31 < arg_53_1.time_ and arg_53_1.time_ <= var_56_31 + arg_56_0 and not isNil(var_56_30) and arg_53_1.var_.actorSpriteComps10059 == nil then
				arg_53_1.var_.actorSpriteComps10059 = var_56_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_32 = 0.034

			if var_56_31 <= arg_53_1.time_ and arg_53_1.time_ < var_56_31 + var_56_32 and not isNil(var_56_30) then
				local var_56_33 = (arg_53_1.time_ - var_56_31) / var_56_32

				if arg_53_1.var_.actorSpriteComps10059 then
					for iter_56_10, iter_56_11 in pairs(arg_53_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_56_11 then
							if arg_53_1.isInRecall_ then
								local var_56_34 = Mathf.Lerp(iter_56_11.color.r, arg_53_1.hightColor2.r, var_56_33)
								local var_56_35 = Mathf.Lerp(iter_56_11.color.g, arg_53_1.hightColor2.g, var_56_33)
								local var_56_36 = Mathf.Lerp(iter_56_11.color.b, arg_53_1.hightColor2.b, var_56_33)

								iter_56_11.color = Color.New(var_56_34, var_56_35, var_56_36)
							else
								local var_56_37 = Mathf.Lerp(iter_56_11.color.r, 0.5, var_56_33)

								iter_56_11.color = Color.New(var_56_37, var_56_37, var_56_37)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_31 + var_56_32 and arg_53_1.time_ < var_56_31 + var_56_32 + arg_56_0 and not isNil(var_56_30) and arg_53_1.var_.actorSpriteComps10059 then
				for iter_56_12, iter_56_13 in pairs(arg_53_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_56_13 then
						if arg_53_1.isInRecall_ then
							iter_56_13.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_13.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10059 = nil
			end

			local var_56_38 = 0
			local var_56_39 = 1.3

			if var_56_38 < arg_53_1.time_ and arg_53_1.time_ <= var_56_38 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_40 = arg_53_1:FormatText(StoryNameCfg[605].name)

				arg_53_1.leftNameTxt_.text = var_56_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_41 = arg_53_1:GetWordFromCfg(410042013)
				local var_56_42 = arg_53_1:FormatText(var_56_41.content)

				arg_53_1.text_.text = var_56_42

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_43 = 52
				local var_56_44 = utf8.len(var_56_42)
				local var_56_45 = var_56_43 <= 0 and var_56_39 or var_56_39 * (var_56_44 / var_56_43)

				if var_56_45 > 0 and var_56_39 < var_56_45 then
					arg_53_1.talkMaxDuration = var_56_45

					if var_56_45 + var_56_38 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_45 + var_56_38
					end
				end

				arg_53_1.text_.text = var_56_42
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042013", "story_v_out_410042.awb") ~= 0 then
					local var_56_46 = manager.audio:GetVoiceLength("story_v_out_410042", "410042013", "story_v_out_410042.awb") / 1000

					if var_56_46 + var_56_38 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_46 + var_56_38
					end

					if var_56_41.prefab_name ~= "" and arg_53_1.actors_[var_56_41.prefab_name] ~= nil then
						local var_56_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_41.prefab_name].transform, "story_v_out_410042", "410042013", "story_v_out_410042.awb")

						arg_53_1:RecordAudio("410042013", var_56_47)
						arg_53_1:RecordAudio("410042013", var_56_47)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410042", "410042013", "story_v_out_410042.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410042", "410042013", "story_v_out_410042.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_48 = math.max(var_56_39, arg_53_1.talkMaxDuration)

			if var_56_38 <= arg_53_1.time_ and arg_53_1.time_ < var_56_38 + var_56_48 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_38) / var_56_48

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_38 + var_56_48 and arg_53_1.time_ < var_56_38 + var_56_48 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410042014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410042014
		arg_57_1.duration_ = 8.93

		local var_57_0 = {
			zh = 6.2,
			ja = 8.933
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
				arg_57_0:Play410042015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10059"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10059 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10059", 4)

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
				local var_60_6 = Vector3.New(390, -530, 35)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10059, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_60_7 = arg_57_1.actors_["10059"]
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps10059 == nil then
				arg_57_1.var_.actorSpriteComps10059 = var_60_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_9 = 0.034

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 and not isNil(var_60_7) then
				local var_60_10 = (arg_57_1.time_ - var_60_8) / var_60_9

				if arg_57_1.var_.actorSpriteComps10059 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps10059 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_60_4 then
						if arg_57_1.isInRecall_ then
							iter_60_4.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10059 = nil
			end

			local var_60_15 = arg_57_1.actors_["1056"]
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 and not isNil(var_60_15) and arg_57_1.var_.actorSpriteComps1056 == nil then
				arg_57_1.var_.actorSpriteComps1056 = var_60_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_17 = 0.034

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_17 and not isNil(var_60_15) then
				local var_60_18 = (arg_57_1.time_ - var_60_16) / var_60_17

				if arg_57_1.var_.actorSpriteComps1056 then
					for iter_60_5, iter_60_6 in pairs(arg_57_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_60_6 then
							if arg_57_1.isInRecall_ then
								local var_60_19 = Mathf.Lerp(iter_60_6.color.r, arg_57_1.hightColor2.r, var_60_18)
								local var_60_20 = Mathf.Lerp(iter_60_6.color.g, arg_57_1.hightColor2.g, var_60_18)
								local var_60_21 = Mathf.Lerp(iter_60_6.color.b, arg_57_1.hightColor2.b, var_60_18)

								iter_60_6.color = Color.New(var_60_19, var_60_20, var_60_21)
							else
								local var_60_22 = Mathf.Lerp(iter_60_6.color.r, 0.5, var_60_18)

								iter_60_6.color = Color.New(var_60_22, var_60_22, var_60_22)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_16 + var_60_17 and arg_57_1.time_ < var_60_16 + var_60_17 + arg_60_0 and not isNil(var_60_15) and arg_57_1.var_.actorSpriteComps1056 then
				for iter_60_7, iter_60_8 in pairs(arg_57_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_60_8 then
						if arg_57_1.isInRecall_ then
							iter_60_8.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1056 = nil
			end

			local var_60_23 = 0
			local var_60_24 = 0.625

			if var_60_23 < arg_57_1.time_ and arg_57_1.time_ <= var_60_23 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_25 = arg_57_1:FormatText(StoryNameCfg[596].name)

				arg_57_1.leftNameTxt_.text = var_60_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_26 = arg_57_1:GetWordFromCfg(410042014)
				local var_60_27 = arg_57_1:FormatText(var_60_26.content)

				arg_57_1.text_.text = var_60_27

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_28 = 25
				local var_60_29 = utf8.len(var_60_27)
				local var_60_30 = var_60_28 <= 0 and var_60_24 or var_60_24 * (var_60_29 / var_60_28)

				if var_60_30 > 0 and var_60_24 < var_60_30 then
					arg_57_1.talkMaxDuration = var_60_30

					if var_60_30 + var_60_23 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_30 + var_60_23
					end
				end

				arg_57_1.text_.text = var_60_27
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042014", "story_v_out_410042.awb") ~= 0 then
					local var_60_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042014", "story_v_out_410042.awb") / 1000

					if var_60_31 + var_60_23 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_31 + var_60_23
					end

					if var_60_26.prefab_name ~= "" and arg_57_1.actors_[var_60_26.prefab_name] ~= nil then
						local var_60_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_26.prefab_name].transform, "story_v_out_410042", "410042014", "story_v_out_410042.awb")

						arg_57_1:RecordAudio("410042014", var_60_32)
						arg_57_1:RecordAudio("410042014", var_60_32)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_410042", "410042014", "story_v_out_410042.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_410042", "410042014", "story_v_out_410042.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_33 = math.max(var_60_24, arg_57_1.talkMaxDuration)

			if var_60_23 <= arg_57_1.time_ and arg_57_1.time_ < var_60_23 + var_60_33 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_23) / var_60_33

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_23 + var_60_33 and arg_57_1.time_ < var_60_23 + var_60_33 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play410042015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410042015
		arg_61_1.duration_ = 2.07

		local var_61_0 = {
			zh = 1.6,
			ja = 2.066
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
				arg_61_0:Play410042016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1056"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1056 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1056", 2)

				local var_64_2 = var_64_0.childCount

				for iter_64_0 = 0, var_64_2 - 1 do
					local var_64_3 = var_64_0:GetChild(iter_64_0)

					if var_64_3.name == "split_4" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_4 then
				local var_64_5 = (arg_61_1.time_ - var_64_1) / var_64_4
				local var_64_6 = Vector3.New(-390, -350, -180)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1056, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_64_7 = arg_61_1.actors_["1056"]
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps1056 == nil then
				arg_61_1.var_.actorSpriteComps1056 = var_64_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_9 = 0.034

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 and not isNil(var_64_7) then
				local var_64_10 = (arg_61_1.time_ - var_64_8) / var_64_9

				if arg_61_1.var_.actorSpriteComps1056 then
					for iter_64_1, iter_64_2 in pairs(arg_61_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps1056 then
				for iter_64_3, iter_64_4 in pairs(arg_61_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_64_4 then
						if arg_61_1.isInRecall_ then
							iter_64_4.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1056 = nil
			end

			local var_64_15 = arg_61_1.actors_["10059"]
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.actorSpriteComps10059 == nil then
				arg_61_1.var_.actorSpriteComps10059 = var_64_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_17 = 0.034

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 and not isNil(var_64_15) then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17

				if arg_61_1.var_.actorSpriteComps10059 then
					for iter_64_5, iter_64_6 in pairs(arg_61_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_64_6 then
							if arg_61_1.isInRecall_ then
								local var_64_19 = Mathf.Lerp(iter_64_6.color.r, arg_61_1.hightColor2.r, var_64_18)
								local var_64_20 = Mathf.Lerp(iter_64_6.color.g, arg_61_1.hightColor2.g, var_64_18)
								local var_64_21 = Mathf.Lerp(iter_64_6.color.b, arg_61_1.hightColor2.b, var_64_18)

								iter_64_6.color = Color.New(var_64_19, var_64_20, var_64_21)
							else
								local var_64_22 = Mathf.Lerp(iter_64_6.color.r, 0.5, var_64_18)

								iter_64_6.color = Color.New(var_64_22, var_64_22, var_64_22)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.actorSpriteComps10059 then
				for iter_64_7, iter_64_8 in pairs(arg_61_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_64_8 then
						if arg_61_1.isInRecall_ then
							iter_64_8.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10059 = nil
			end

			local var_64_23 = 0
			local var_64_24 = 0.175

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_25 = arg_61_1:FormatText(StoryNameCfg[605].name)

				arg_61_1.leftNameTxt_.text = var_64_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_26 = arg_61_1:GetWordFromCfg(410042015)
				local var_64_27 = arg_61_1:FormatText(var_64_26.content)

				arg_61_1.text_.text = var_64_27

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_28 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042015", "story_v_out_410042.awb") ~= 0 then
					local var_64_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042015", "story_v_out_410042.awb") / 1000

					if var_64_31 + var_64_23 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_31 + var_64_23
					end

					if var_64_26.prefab_name ~= "" and arg_61_1.actors_[var_64_26.prefab_name] ~= nil then
						local var_64_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_26.prefab_name].transform, "story_v_out_410042", "410042015", "story_v_out_410042.awb")

						arg_61_1:RecordAudio("410042015", var_64_32)
						arg_61_1:RecordAudio("410042015", var_64_32)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410042", "410042015", "story_v_out_410042.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410042", "410042015", "story_v_out_410042.awb")
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
				actorName = "1056",
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
	Play410042016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410042016
		arg_65_1.duration_ = 4.2

		local var_65_0 = {
			zh = 4.2,
			ja = 2
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
				arg_65_0:Play410042017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10059"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10059 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10059", 4)

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
				local var_68_6 = Vector3.New(390, -530, 35)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10059, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_68_7 = arg_65_1.actors_["10059"]
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10059 == nil then
				arg_65_1.var_.actorSpriteComps10059 = var_68_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 0.034

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 and not isNil(var_68_7) then
				local var_68_10 = (arg_65_1.time_ - var_68_8) / var_68_9

				if arg_65_1.var_.actorSpriteComps10059 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10059 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_68_4 then
						if arg_65_1.isInRecall_ then
							iter_68_4.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10059 = nil
			end

			local var_68_15 = arg_65_1.actors_["1056"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps1056 == nil then
				arg_65_1.var_.actorSpriteComps1056 = var_68_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_17 = 0.034

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.actorSpriteComps1056 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_68_6 then
							if arg_65_1.isInRecall_ then
								local var_68_19 = Mathf.Lerp(iter_68_6.color.r, arg_65_1.hightColor2.r, var_68_18)
								local var_68_20 = Mathf.Lerp(iter_68_6.color.g, arg_65_1.hightColor2.g, var_68_18)
								local var_68_21 = Mathf.Lerp(iter_68_6.color.b, arg_65_1.hightColor2.b, var_68_18)

								iter_68_6.color = Color.New(var_68_19, var_68_20, var_68_21)
							else
								local var_68_22 = Mathf.Lerp(iter_68_6.color.r, 0.5, var_68_18)

								iter_68_6.color = Color.New(var_68_22, var_68_22, var_68_22)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps1056 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_68_8 then
						if arg_65_1.isInRecall_ then
							iter_68_8.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1056 = nil
			end

			local var_68_23 = 0
			local var_68_24 = 0.45

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_25 = arg_65_1:FormatText(StoryNameCfg[596].name)

				arg_65_1.leftNameTxt_.text = var_68_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_26 = arg_65_1:GetWordFromCfg(410042016)
				local var_68_27 = arg_65_1:FormatText(var_68_26.content)

				arg_65_1.text_.text = var_68_27

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_28 = 18
				local var_68_29 = utf8.len(var_68_27)
				local var_68_30 = var_68_28 <= 0 and var_68_24 or var_68_24 * (var_68_29 / var_68_28)

				if var_68_30 > 0 and var_68_24 < var_68_30 then
					arg_65_1.talkMaxDuration = var_68_30

					if var_68_30 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_30 + var_68_23
					end
				end

				arg_65_1.text_.text = var_68_27
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042016", "story_v_out_410042.awb") ~= 0 then
					local var_68_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042016", "story_v_out_410042.awb") / 1000

					if var_68_31 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_31 + var_68_23
					end

					if var_68_26.prefab_name ~= "" and arg_65_1.actors_[var_68_26.prefab_name] ~= nil then
						local var_68_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_26.prefab_name].transform, "story_v_out_410042", "410042016", "story_v_out_410042.awb")

						arg_65_1:RecordAudio("410042016", var_68_32)
						arg_65_1:RecordAudio("410042016", var_68_32)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410042", "410042016", "story_v_out_410042.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410042", "410042016", "story_v_out_410042.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_33 = math.max(var_68_24, arg_65_1.talkMaxDuration)

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_33 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_23) / var_68_33

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_23 + var_68_33 and arg_65_1.time_ < var_68_23 + var_68_33 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play410042017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410042017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play410042018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10059"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10059 == nil then
				arg_69_1.var_.actorSpriteComps10059 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.034

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps10059 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor2.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor2.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor2.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 0.5, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10059 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10059 = nil
			end

			local var_72_8 = 0
			local var_72_9 = 1.1

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(410042017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_12 = 44
				local var_72_13 = utf8.len(var_72_11)
				local var_72_14 = var_72_12 <= 0 and var_72_9 or var_72_9 * (var_72_13 / var_72_12)

				if var_72_14 > 0 and var_72_9 < var_72_14 then
					arg_69_1.talkMaxDuration = var_72_14

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_15 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_15 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_15

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_15 and arg_69_1.time_ < var_72_8 + var_72_15 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play410042018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410042018
		arg_73_1.duration_ = 4.87

		local var_73_0 = {
			zh = 3.1,
			ja = 4.866
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
				arg_73_0:Play410042019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1060"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1060 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1060", 2)

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
				local var_76_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1060, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_76_7 = arg_73_1.actors_["1060"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps1060 == nil then
				arg_73_1.var_.actorSpriteComps1060 = var_76_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 0.034

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.actorSpriteComps1060 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps1060 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_76_4 then
						if arg_73_1.isInRecall_ then
							iter_76_4.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1060 = nil
			end

			local var_76_15 = 0
			local var_76_16 = 0.4

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[584].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(410042018)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042018", "story_v_out_410042.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_410042", "410042018", "story_v_out_410042.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_410042", "410042018", "story_v_out_410042.awb")

						arg_73_1:RecordAudio("410042018", var_76_24)
						arg_73_1:RecordAudio("410042018", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410042", "410042018", "story_v_out_410042.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410042", "410042018", "story_v_out_410042.awb")
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
				actorName = "1060",
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
	Play410042019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410042019
		arg_77_1.duration_ = 4.73

		local var_77_0 = {
			zh = 4.4,
			ja = 4.733
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
				arg_77_0:Play410042020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10059"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10059 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10059", 4)

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
				local var_80_6 = Vector3.New(390, -530, 35)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10059, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_80_7 = arg_77_1.actors_["10059"]
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10059 == nil then
				arg_77_1.var_.actorSpriteComps10059 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 0.034

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 and not isNil(var_80_7) then
				local var_80_10 = (arg_77_1.time_ - var_80_8) / var_80_9

				if arg_77_1.var_.actorSpriteComps10059 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10059 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_80_4 then
						if arg_77_1.isInRecall_ then
							iter_80_4.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10059 = nil
			end

			local var_80_15 = arg_77_1.actors_["1060"]
			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps1060 == nil then
				arg_77_1.var_.actorSpriteComps1060 = var_80_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_17 = 0.034

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 and not isNil(var_80_15) then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17

				if arg_77_1.var_.actorSpriteComps1060 then
					for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_80_6 then
							if arg_77_1.isInRecall_ then
								local var_80_19 = Mathf.Lerp(iter_80_6.color.r, arg_77_1.hightColor2.r, var_80_18)
								local var_80_20 = Mathf.Lerp(iter_80_6.color.g, arg_77_1.hightColor2.g, var_80_18)
								local var_80_21 = Mathf.Lerp(iter_80_6.color.b, arg_77_1.hightColor2.b, var_80_18)

								iter_80_6.color = Color.New(var_80_19, var_80_20, var_80_21)
							else
								local var_80_22 = Mathf.Lerp(iter_80_6.color.r, 0.5, var_80_18)

								iter_80_6.color = Color.New(var_80_22, var_80_22, var_80_22)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps1060 then
				for iter_80_7, iter_80_8 in pairs(arg_77_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_80_8 then
						if arg_77_1.isInRecall_ then
							iter_80_8.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1060 = nil
			end

			local var_80_23 = 0
			local var_80_24 = 0.475

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_25 = arg_77_1:FormatText(StoryNameCfg[596].name)

				arg_77_1.leftNameTxt_.text = var_80_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_26 = arg_77_1:GetWordFromCfg(410042019)
				local var_80_27 = arg_77_1:FormatText(var_80_26.content)

				arg_77_1.text_.text = var_80_27

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_28 = 19
				local var_80_29 = utf8.len(var_80_27)
				local var_80_30 = var_80_28 <= 0 and var_80_24 or var_80_24 * (var_80_29 / var_80_28)

				if var_80_30 > 0 and var_80_24 < var_80_30 then
					arg_77_1.talkMaxDuration = var_80_30

					if var_80_30 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_30 + var_80_23
					end
				end

				arg_77_1.text_.text = var_80_27
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042019", "story_v_out_410042.awb") ~= 0 then
					local var_80_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042019", "story_v_out_410042.awb") / 1000

					if var_80_31 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_23
					end

					if var_80_26.prefab_name ~= "" and arg_77_1.actors_[var_80_26.prefab_name] ~= nil then
						local var_80_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_26.prefab_name].transform, "story_v_out_410042", "410042019", "story_v_out_410042.awb")

						arg_77_1:RecordAudio("410042019", var_80_32)
						arg_77_1:RecordAudio("410042019", var_80_32)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410042", "410042019", "story_v_out_410042.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410042", "410042019", "story_v_out_410042.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_33 = math.max(var_80_24, arg_77_1.talkMaxDuration)

			if var_80_23 <= arg_77_1.time_ and arg_77_1.time_ < var_80_23 + var_80_33 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_23) / var_80_33

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_23 + var_80_33 and arg_77_1.time_ < var_80_23 + var_80_33 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play410042020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410042020
		arg_81_1.duration_ = 12.47

		local var_81_0 = {
			zh = 7.033,
			ja = 12.466
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
				arg_81_0:Play410042021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1060"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1060 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1060", 2)

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
				local var_84_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1060, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_84_7 = arg_81_1.actors_["1060"]
			local var_84_8 = 0

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps1060 == nil then
				arg_81_1.var_.actorSpriteComps1060 = var_84_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_9 = 0.034

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_9 and not isNil(var_84_7) then
				local var_84_10 = (arg_81_1.time_ - var_84_8) / var_84_9

				if arg_81_1.var_.actorSpriteComps1060 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								local var_84_11 = Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor1.r, var_84_10)
								local var_84_12 = Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor1.g, var_84_10)
								local var_84_13 = Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor1.b, var_84_10)

								iter_84_2.color = Color.New(var_84_11, var_84_12, var_84_13)
							else
								local var_84_14 = Mathf.Lerp(iter_84_2.color.r, 1, var_84_10)

								iter_84_2.color = Color.New(var_84_14, var_84_14, var_84_14)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_8 + var_84_9 and arg_81_1.time_ < var_84_8 + var_84_9 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps1060 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_84_4 then
						if arg_81_1.isInRecall_ then
							iter_84_4.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1060 = nil
			end

			local var_84_15 = arg_81_1.actors_["10059"]
			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.actorSpriteComps10059 == nil then
				arg_81_1.var_.actorSpriteComps10059 = var_84_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_17 = 0.034

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_17 and not isNil(var_84_15) then
				local var_84_18 = (arg_81_1.time_ - var_84_16) / var_84_17

				if arg_81_1.var_.actorSpriteComps10059 then
					for iter_84_5, iter_84_6 in pairs(arg_81_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_84_6 then
							if arg_81_1.isInRecall_ then
								local var_84_19 = Mathf.Lerp(iter_84_6.color.r, arg_81_1.hightColor2.r, var_84_18)
								local var_84_20 = Mathf.Lerp(iter_84_6.color.g, arg_81_1.hightColor2.g, var_84_18)
								local var_84_21 = Mathf.Lerp(iter_84_6.color.b, arg_81_1.hightColor2.b, var_84_18)

								iter_84_6.color = Color.New(var_84_19, var_84_20, var_84_21)
							else
								local var_84_22 = Mathf.Lerp(iter_84_6.color.r, 0.5, var_84_18)

								iter_84_6.color = Color.New(var_84_22, var_84_22, var_84_22)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.actorSpriteComps10059 then
				for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_84_8 then
						if arg_81_1.isInRecall_ then
							iter_84_8.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10059 = nil
			end

			local var_84_23 = 0
			local var_84_24 = 0.825

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_25 = arg_81_1:FormatText(StoryNameCfg[584].name)

				arg_81_1.leftNameTxt_.text = var_84_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_26 = arg_81_1:GetWordFromCfg(410042020)
				local var_84_27 = arg_81_1:FormatText(var_84_26.content)

				arg_81_1.text_.text = var_84_27

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 33
				local var_84_29 = utf8.len(var_84_27)
				local var_84_30 = var_84_28 <= 0 and var_84_24 or var_84_24 * (var_84_29 / var_84_28)

				if var_84_30 > 0 and var_84_24 < var_84_30 then
					arg_81_1.talkMaxDuration = var_84_30

					if var_84_30 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_30 + var_84_23
					end
				end

				arg_81_1.text_.text = var_84_27
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042020", "story_v_out_410042.awb") ~= 0 then
					local var_84_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042020", "story_v_out_410042.awb") / 1000

					if var_84_31 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_31 + var_84_23
					end

					if var_84_26.prefab_name ~= "" and arg_81_1.actors_[var_84_26.prefab_name] ~= nil then
						local var_84_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_26.prefab_name].transform, "story_v_out_410042", "410042020", "story_v_out_410042.awb")

						arg_81_1:RecordAudio("410042020", var_84_32)
						arg_81_1:RecordAudio("410042020", var_84_32)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410042", "410042020", "story_v_out_410042.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410042", "410042020", "story_v_out_410042.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_33 = math.max(var_84_24, arg_81_1.talkMaxDuration)

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_33 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_23) / var_84_33

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_23 + var_84_33 and arg_81_1.time_ < var_84_23 + var_84_33 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410042021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410042021
		arg_85_1.duration_ = 12.83

		local var_85_0 = {
			zh = 6.166,
			ja = 12.833
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
				arg_85_0:Play410042022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10059"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10059 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10059", 4)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "split_3" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(390, -530, 35)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10059, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_88_7 = arg_85_1.actors_["10059"]
			local var_88_8 = 0

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps10059 == nil then
				arg_85_1.var_.actorSpriteComps10059 = var_88_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_9 = 0.034

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 and not isNil(var_88_7) then
				local var_88_10 = (arg_85_1.time_ - var_88_8) / var_88_9

				if arg_85_1.var_.actorSpriteComps10059 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								local var_88_11 = Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, var_88_10)
								local var_88_12 = Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, var_88_10)
								local var_88_13 = Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, var_88_10)

								iter_88_2.color = Color.New(var_88_11, var_88_12, var_88_13)
							else
								local var_88_14 = Mathf.Lerp(iter_88_2.color.r, 1, var_88_10)

								iter_88_2.color = Color.New(var_88_14, var_88_14, var_88_14)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps10059 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_88_4 then
						if arg_85_1.isInRecall_ then
							iter_88_4.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10059 = nil
			end

			local var_88_15 = arg_85_1.actors_["1060"]
			local var_88_16 = 0

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.actorSpriteComps1060 == nil then
				arg_85_1.var_.actorSpriteComps1060 = var_88_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_17 = 0.034

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_17 and not isNil(var_88_15) then
				local var_88_18 = (arg_85_1.time_ - var_88_16) / var_88_17

				if arg_85_1.var_.actorSpriteComps1060 then
					for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_88_6 then
							if arg_85_1.isInRecall_ then
								local var_88_19 = Mathf.Lerp(iter_88_6.color.r, arg_85_1.hightColor2.r, var_88_18)
								local var_88_20 = Mathf.Lerp(iter_88_6.color.g, arg_85_1.hightColor2.g, var_88_18)
								local var_88_21 = Mathf.Lerp(iter_88_6.color.b, arg_85_1.hightColor2.b, var_88_18)

								iter_88_6.color = Color.New(var_88_19, var_88_20, var_88_21)
							else
								local var_88_22 = Mathf.Lerp(iter_88_6.color.r, 0.5, var_88_18)

								iter_88_6.color = Color.New(var_88_22, var_88_22, var_88_22)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_16 + var_88_17 and arg_85_1.time_ < var_88_16 + var_88_17 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.actorSpriteComps1060 then
				for iter_88_7, iter_88_8 in pairs(arg_85_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_88_8 then
						if arg_85_1.isInRecall_ then
							iter_88_8.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1060 = nil
			end

			local var_88_23 = 0
			local var_88_24 = 0.625

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_25 = arg_85_1:FormatText(StoryNameCfg[596].name)

				arg_85_1.leftNameTxt_.text = var_88_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:GetWordFromCfg(410042021)
				local var_88_27 = arg_85_1:FormatText(var_88_26.content)

				arg_85_1.text_.text = var_88_27

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 25
				local var_88_29 = utf8.len(var_88_27)
				local var_88_30 = var_88_28 <= 0 and var_88_24 or var_88_24 * (var_88_29 / var_88_28)

				if var_88_30 > 0 and var_88_24 < var_88_30 then
					arg_85_1.talkMaxDuration = var_88_30

					if var_88_30 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_30 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_27
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042021", "story_v_out_410042.awb") ~= 0 then
					local var_88_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042021", "story_v_out_410042.awb") / 1000

					if var_88_31 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_31 + var_88_23
					end

					if var_88_26.prefab_name ~= "" and arg_85_1.actors_[var_88_26.prefab_name] ~= nil then
						local var_88_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_26.prefab_name].transform, "story_v_out_410042", "410042021", "story_v_out_410042.awb")

						arg_85_1:RecordAudio("410042021", var_88_32)
						arg_85_1:RecordAudio("410042021", var_88_32)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410042", "410042021", "story_v_out_410042.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410042", "410042021", "story_v_out_410042.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_33 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_33 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_23) / var_88_33

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_23 + var_88_33 and arg_85_1.time_ < var_88_23 + var_88_33 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play410042022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410042022
		arg_89_1.duration_ = 7.37

		local var_89_0 = {
			zh = 7.366,
			ja = 5.933
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
				arg_89_0:Play410042023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1060"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1060 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1060", 2)

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
				local var_92_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1060, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_92_7 = arg_89_1.actors_["1060"]
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps1060 == nil then
				arg_89_1.var_.actorSpriteComps1060 = var_92_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 0.034

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_9 and not isNil(var_92_7) then
				local var_92_10 = (arg_89_1.time_ - var_92_8) / var_92_9

				if arg_89_1.var_.actorSpriteComps1060 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								local var_92_11 = Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor1.r, var_92_10)
								local var_92_12 = Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor1.g, var_92_10)
								local var_92_13 = Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor1.b, var_92_10)

								iter_92_2.color = Color.New(var_92_11, var_92_12, var_92_13)
							else
								local var_92_14 = Mathf.Lerp(iter_92_2.color.r, 1, var_92_10)

								iter_92_2.color = Color.New(var_92_14, var_92_14, var_92_14)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_8 + var_92_9 and arg_89_1.time_ < var_92_8 + var_92_9 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps1060 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_92_4 then
						if arg_89_1.isInRecall_ then
							iter_92_4.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1060 = nil
			end

			local var_92_15 = arg_89_1.actors_["10059"]
			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.actorSpriteComps10059 == nil then
				arg_89_1.var_.actorSpriteComps10059 = var_92_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_17 = 0.034

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 and not isNil(var_92_15) then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17

				if arg_89_1.var_.actorSpriteComps10059 then
					for iter_92_5, iter_92_6 in pairs(arg_89_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_92_6 then
							if arg_89_1.isInRecall_ then
								local var_92_19 = Mathf.Lerp(iter_92_6.color.r, arg_89_1.hightColor2.r, var_92_18)
								local var_92_20 = Mathf.Lerp(iter_92_6.color.g, arg_89_1.hightColor2.g, var_92_18)
								local var_92_21 = Mathf.Lerp(iter_92_6.color.b, arg_89_1.hightColor2.b, var_92_18)

								iter_92_6.color = Color.New(var_92_19, var_92_20, var_92_21)
							else
								local var_92_22 = Mathf.Lerp(iter_92_6.color.r, 0.5, var_92_18)

								iter_92_6.color = Color.New(var_92_22, var_92_22, var_92_22)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.actorSpriteComps10059 then
				for iter_92_7, iter_92_8 in pairs(arg_89_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_92_8 then
						if arg_89_1.isInRecall_ then
							iter_92_8.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10059 = nil
			end

			local var_92_23 = 0
			local var_92_24 = 0.825

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_25 = arg_89_1:FormatText(StoryNameCfg[584].name)

				arg_89_1.leftNameTxt_.text = var_92_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_26 = arg_89_1:GetWordFromCfg(410042022)
				local var_92_27 = arg_89_1:FormatText(var_92_26.content)

				arg_89_1.text_.text = var_92_27

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_28 = 33
				local var_92_29 = utf8.len(var_92_27)
				local var_92_30 = var_92_28 <= 0 and var_92_24 or var_92_24 * (var_92_29 / var_92_28)

				if var_92_30 > 0 and var_92_24 < var_92_30 then
					arg_89_1.talkMaxDuration = var_92_30

					if var_92_30 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_30 + var_92_23
					end
				end

				arg_89_1.text_.text = var_92_27
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042022", "story_v_out_410042.awb") ~= 0 then
					local var_92_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042022", "story_v_out_410042.awb") / 1000

					if var_92_31 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_31 + var_92_23
					end

					if var_92_26.prefab_name ~= "" and arg_89_1.actors_[var_92_26.prefab_name] ~= nil then
						local var_92_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_26.prefab_name].transform, "story_v_out_410042", "410042022", "story_v_out_410042.awb")

						arg_89_1:RecordAudio("410042022", var_92_32)
						arg_89_1:RecordAudio("410042022", var_92_32)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410042", "410042022", "story_v_out_410042.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410042", "410042022", "story_v_out_410042.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_33 = math.max(var_92_24, arg_89_1.talkMaxDuration)

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_33 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_23) / var_92_33

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_23 + var_92_33 and arg_89_1.time_ < var_92_23 + var_92_33 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410042023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410042023
		arg_93_1.duration_ = 17.33

		local var_93_0 = {
			zh = 7.2,
			ja = 17.333
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
				arg_93_0:Play410042024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10059"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10059 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10059", 4)

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
				local var_96_6 = Vector3.New(390, -530, 35)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10059, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_96_7 = arg_93_1.actors_["10059"]
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10059 == nil then
				arg_93_1.var_.actorSpriteComps10059 = var_96_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 0.034

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 and not isNil(var_96_7) then
				local var_96_10 = (arg_93_1.time_ - var_96_8) / var_96_9

				if arg_93_1.var_.actorSpriteComps10059 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								local var_96_11 = Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor1.r, var_96_10)
								local var_96_12 = Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor1.g, var_96_10)
								local var_96_13 = Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor1.b, var_96_10)

								iter_96_2.color = Color.New(var_96_11, var_96_12, var_96_13)
							else
								local var_96_14 = Mathf.Lerp(iter_96_2.color.r, 1, var_96_10)

								iter_96_2.color = Color.New(var_96_14, var_96_14, var_96_14)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10059 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_96_4 then
						if arg_93_1.isInRecall_ then
							iter_96_4.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10059 = nil
			end

			local var_96_15 = arg_93_1.actors_["1060"]
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 and not isNil(var_96_15) and arg_93_1.var_.actorSpriteComps1060 == nil then
				arg_93_1.var_.actorSpriteComps1060 = var_96_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_17 = 0.034

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 and not isNil(var_96_15) then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17

				if arg_93_1.var_.actorSpriteComps1060 then
					for iter_96_5, iter_96_6 in pairs(arg_93_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_96_6 then
							if arg_93_1.isInRecall_ then
								local var_96_19 = Mathf.Lerp(iter_96_6.color.r, arg_93_1.hightColor2.r, var_96_18)
								local var_96_20 = Mathf.Lerp(iter_96_6.color.g, arg_93_1.hightColor2.g, var_96_18)
								local var_96_21 = Mathf.Lerp(iter_96_6.color.b, arg_93_1.hightColor2.b, var_96_18)

								iter_96_6.color = Color.New(var_96_19, var_96_20, var_96_21)
							else
								local var_96_22 = Mathf.Lerp(iter_96_6.color.r, 0.5, var_96_18)

								iter_96_6.color = Color.New(var_96_22, var_96_22, var_96_22)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 and not isNil(var_96_15) and arg_93_1.var_.actorSpriteComps1060 then
				for iter_96_7, iter_96_8 in pairs(arg_93_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_96_8 then
						if arg_93_1.isInRecall_ then
							iter_96_8.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1060 = nil
			end

			local var_96_23 = 0
			local var_96_24 = 0.575

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_25 = arg_93_1:FormatText(StoryNameCfg[596].name)

				arg_93_1.leftNameTxt_.text = var_96_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_26 = arg_93_1:GetWordFromCfg(410042023)
				local var_96_27 = arg_93_1:FormatText(var_96_26.content)

				arg_93_1.text_.text = var_96_27

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_28 = 23
				local var_96_29 = utf8.len(var_96_27)
				local var_96_30 = var_96_28 <= 0 and var_96_24 or var_96_24 * (var_96_29 / var_96_28)

				if var_96_30 > 0 and var_96_24 < var_96_30 then
					arg_93_1.talkMaxDuration = var_96_30

					if var_96_30 + var_96_23 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_30 + var_96_23
					end
				end

				arg_93_1.text_.text = var_96_27
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042023", "story_v_out_410042.awb") ~= 0 then
					local var_96_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042023", "story_v_out_410042.awb") / 1000

					if var_96_31 + var_96_23 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_31 + var_96_23
					end

					if var_96_26.prefab_name ~= "" and arg_93_1.actors_[var_96_26.prefab_name] ~= nil then
						local var_96_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_26.prefab_name].transform, "story_v_out_410042", "410042023", "story_v_out_410042.awb")

						arg_93_1:RecordAudio("410042023", var_96_32)
						arg_93_1:RecordAudio("410042023", var_96_32)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410042", "410042023", "story_v_out_410042.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410042", "410042023", "story_v_out_410042.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_33 = math.max(var_96_24, arg_93_1.talkMaxDuration)

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_33 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_23) / var_96_33

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_23 + var_96_33 and arg_93_1.time_ < var_96_23 + var_96_33 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play410042024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410042024
		arg_97_1.duration_ = 11.97

		local var_97_0 = {
			zh = 5.9,
			ja = 11.966
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
				arg_97_0:Play410042025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10059"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10059 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10059", 4)

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
				local var_100_6 = Vector3.New(390, -530, 35)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10059, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_100_7 = arg_97_1.actors_["10059"]
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps10059 == nil then
				arg_97_1.var_.actorSpriteComps10059 = var_100_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_9 = 0.034

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_9 and not isNil(var_100_7) then
				local var_100_10 = (arg_97_1.time_ - var_100_8) / var_100_9

				if arg_97_1.var_.actorSpriteComps10059 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_100_2 then
							if arg_97_1.isInRecall_ then
								local var_100_11 = Mathf.Lerp(iter_100_2.color.r, arg_97_1.hightColor1.r, var_100_10)
								local var_100_12 = Mathf.Lerp(iter_100_2.color.g, arg_97_1.hightColor1.g, var_100_10)
								local var_100_13 = Mathf.Lerp(iter_100_2.color.b, arg_97_1.hightColor1.b, var_100_10)

								iter_100_2.color = Color.New(var_100_11, var_100_12, var_100_13)
							else
								local var_100_14 = Mathf.Lerp(iter_100_2.color.r, 1, var_100_10)

								iter_100_2.color = Color.New(var_100_14, var_100_14, var_100_14)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_8 + var_100_9 and arg_97_1.time_ < var_100_8 + var_100_9 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps10059 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_100_4 then
						if arg_97_1.isInRecall_ then
							iter_100_4.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10059 = nil
			end

			local var_100_15 = 0
			local var_100_16 = 0.725

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[596].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(410042024)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 29
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042024", "story_v_out_410042.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_410042", "410042024", "story_v_out_410042.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_410042", "410042024", "story_v_out_410042.awb")

						arg_97_1:RecordAudio("410042024", var_100_24)
						arg_97_1:RecordAudio("410042024", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_410042", "410042024", "story_v_out_410042.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_410042", "410042024", "story_v_out_410042.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_25 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_25 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_25

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_25 and arg_97_1.time_ < var_100_15 + var_100_25 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play410042025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410042025
		arg_101_1.duration_ = 17.97

		local var_101_0 = {
			zh = 8.833,
			ja = 17.966
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
				arg_101_0:Play410042026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10059"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10059 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10059", 4)

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
				local var_104_6 = Vector3.New(390, -530, 35)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10059, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_104_7 = arg_101_1.actors_["10059"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10059 == nil then
				arg_101_1.var_.actorSpriteComps10059 = var_104_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 0.034

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.actorSpriteComps10059 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								local var_104_11 = Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor1.r, var_104_10)
								local var_104_12 = Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor1.g, var_104_10)
								local var_104_13 = Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor1.b, var_104_10)

								iter_104_2.color = Color.New(var_104_11, var_104_12, var_104_13)
							else
								local var_104_14 = Mathf.Lerp(iter_104_2.color.r, 1, var_104_10)

								iter_104_2.color = Color.New(var_104_14, var_104_14, var_104_14)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10059 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_104_4 then
						if arg_101_1.isInRecall_ then
							iter_104_4.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10059 = nil
			end

			local var_104_15 = 0
			local var_104_16 = 0.95

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[596].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(410042025)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 38
				local var_104_21 = utf8.len(var_104_19)
				local var_104_22 = var_104_20 <= 0 and var_104_16 or var_104_16 * (var_104_21 / var_104_20)

				if var_104_22 > 0 and var_104_16 < var_104_22 then
					arg_101_1.talkMaxDuration = var_104_22

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042025", "story_v_out_410042.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_out_410042", "410042025", "story_v_out_410042.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_out_410042", "410042025", "story_v_out_410042.awb")

						arg_101_1:RecordAudio("410042025", var_104_24)
						arg_101_1:RecordAudio("410042025", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_410042", "410042025", "story_v_out_410042.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_410042", "410042025", "story_v_out_410042.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_25 and arg_101_1.time_ < var_104_15 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play410042026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410042026
		arg_105_1.duration_ = 9.23

		local var_105_0 = {
			zh = 8.566,
			ja = 9.233
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
				arg_105_0:Play410042027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1060"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1060 = var_108_0.localPosition
				var_108_0.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1060", 2)

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
				local var_108_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1060, var_108_6, var_108_5)
			end

			if arg_105_1.time_ >= var_108_1 + var_108_4 and arg_105_1.time_ < var_108_1 + var_108_4 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_108_7 = arg_105_1.actors_["1060"]
			local var_108_8 = 0

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps1060 == nil then
				arg_105_1.var_.actorSpriteComps1060 = var_108_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_9 = 0.034

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 and not isNil(var_108_7) then
				local var_108_10 = (arg_105_1.time_ - var_108_8) / var_108_9

				if arg_105_1.var_.actorSpriteComps1060 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps1060 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_108_4 then
						if arg_105_1.isInRecall_ then
							iter_108_4.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1060 = nil
			end

			local var_108_15 = arg_105_1.actors_["10059"]
			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 and not isNil(var_108_15) and arg_105_1.var_.actorSpriteComps10059 == nil then
				arg_105_1.var_.actorSpriteComps10059 = var_108_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_17 = 0.034

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 and not isNil(var_108_15) then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17

				if arg_105_1.var_.actorSpriteComps10059 then
					for iter_108_5, iter_108_6 in pairs(arg_105_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_108_6 then
							if arg_105_1.isInRecall_ then
								local var_108_19 = Mathf.Lerp(iter_108_6.color.r, arg_105_1.hightColor2.r, var_108_18)
								local var_108_20 = Mathf.Lerp(iter_108_6.color.g, arg_105_1.hightColor2.g, var_108_18)
								local var_108_21 = Mathf.Lerp(iter_108_6.color.b, arg_105_1.hightColor2.b, var_108_18)

								iter_108_6.color = Color.New(var_108_19, var_108_20, var_108_21)
							else
								local var_108_22 = Mathf.Lerp(iter_108_6.color.r, 0.5, var_108_18)

								iter_108_6.color = Color.New(var_108_22, var_108_22, var_108_22)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 and not isNil(var_108_15) and arg_105_1.var_.actorSpriteComps10059 then
				for iter_108_7, iter_108_8 in pairs(arg_105_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_108_8 then
						if arg_105_1.isInRecall_ then
							iter_108_8.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10059 = nil
			end

			local var_108_23 = 0
			local var_108_24 = 0.95

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_25 = arg_105_1:FormatText(StoryNameCfg[584].name)

				arg_105_1.leftNameTxt_.text = var_108_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_26 = arg_105_1:GetWordFromCfg(410042026)
				local var_108_27 = arg_105_1:FormatText(var_108_26.content)

				arg_105_1.text_.text = var_108_27

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_28 = 38
				local var_108_29 = utf8.len(var_108_27)
				local var_108_30 = var_108_28 <= 0 and var_108_24 or var_108_24 * (var_108_29 / var_108_28)

				if var_108_30 > 0 and var_108_24 < var_108_30 then
					arg_105_1.talkMaxDuration = var_108_30

					if var_108_30 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_30 + var_108_23
					end
				end

				arg_105_1.text_.text = var_108_27
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042026", "story_v_out_410042.awb") ~= 0 then
					local var_108_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042026", "story_v_out_410042.awb") / 1000

					if var_108_31 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_31 + var_108_23
					end

					if var_108_26.prefab_name ~= "" and arg_105_1.actors_[var_108_26.prefab_name] ~= nil then
						local var_108_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_26.prefab_name].transform, "story_v_out_410042", "410042026", "story_v_out_410042.awb")

						arg_105_1:RecordAudio("410042026", var_108_32)
						arg_105_1:RecordAudio("410042026", var_108_32)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_410042", "410042026", "story_v_out_410042.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_410042", "410042026", "story_v_out_410042.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_33 = math.max(var_108_24, arg_105_1.talkMaxDuration)

			if var_108_23 <= arg_105_1.time_ and arg_105_1.time_ < var_108_23 + var_108_33 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_23) / var_108_33

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_23 + var_108_33 and arg_105_1.time_ < var_108_23 + var_108_33 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410042027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410042027
		arg_109_1.duration_ = 5.9

		local var_109_0 = {
			zh = 3.366,
			ja = 5.9
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
				arg_109_0:Play410042028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10059"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10059 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10059", 4)

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
				local var_112_6 = Vector3.New(390, -530, 35)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10059, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_112_7 = arg_109_1.actors_["10059"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10059 == nil then
				arg_109_1.var_.actorSpriteComps10059 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 0.034

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps10059 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_11 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, var_112_10)
								local var_112_12 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, var_112_10)
								local var_112_13 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, var_112_10)

								iter_112_2.color = Color.New(var_112_11, var_112_12, var_112_13)
							else
								local var_112_14 = Mathf.Lerp(iter_112_2.color.r, 1, var_112_10)

								iter_112_2.color = Color.New(var_112_14, var_112_14, var_112_14)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10059 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10059 = nil
			end

			local var_112_15 = arg_109_1.actors_["1060"]
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.actorSpriteComps1060 == nil then
				arg_109_1.var_.actorSpriteComps1060 = var_112_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_17 = 0.034

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 and not isNil(var_112_15) then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17

				if arg_109_1.var_.actorSpriteComps1060 then
					for iter_112_5, iter_112_6 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_112_6 then
							if arg_109_1.isInRecall_ then
								local var_112_19 = Mathf.Lerp(iter_112_6.color.r, arg_109_1.hightColor2.r, var_112_18)
								local var_112_20 = Mathf.Lerp(iter_112_6.color.g, arg_109_1.hightColor2.g, var_112_18)
								local var_112_21 = Mathf.Lerp(iter_112_6.color.b, arg_109_1.hightColor2.b, var_112_18)

								iter_112_6.color = Color.New(var_112_19, var_112_20, var_112_21)
							else
								local var_112_22 = Mathf.Lerp(iter_112_6.color.r, 0.5, var_112_18)

								iter_112_6.color = Color.New(var_112_22, var_112_22, var_112_22)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.actorSpriteComps1060 then
				for iter_112_7, iter_112_8 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_112_8 then
						if arg_109_1.isInRecall_ then
							iter_112_8.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1060 = nil
			end

			local var_112_23 = 0
			local var_112_24 = 0.35

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_25 = arg_109_1:FormatText(StoryNameCfg[596].name)

				arg_109_1.leftNameTxt_.text = var_112_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_26 = arg_109_1:GetWordFromCfg(410042027)
				local var_112_27 = arg_109_1:FormatText(var_112_26.content)

				arg_109_1.text_.text = var_112_27

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_28 = 14
				local var_112_29 = utf8.len(var_112_27)
				local var_112_30 = var_112_28 <= 0 and var_112_24 or var_112_24 * (var_112_29 / var_112_28)

				if var_112_30 > 0 and var_112_24 < var_112_30 then
					arg_109_1.talkMaxDuration = var_112_30

					if var_112_30 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_30 + var_112_23
					end
				end

				arg_109_1.text_.text = var_112_27
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042027", "story_v_out_410042.awb") ~= 0 then
					local var_112_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042027", "story_v_out_410042.awb") / 1000

					if var_112_31 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_31 + var_112_23
					end

					if var_112_26.prefab_name ~= "" and arg_109_1.actors_[var_112_26.prefab_name] ~= nil then
						local var_112_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_26.prefab_name].transform, "story_v_out_410042", "410042027", "story_v_out_410042.awb")

						arg_109_1:RecordAudio("410042027", var_112_32)
						arg_109_1:RecordAudio("410042027", var_112_32)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410042", "410042027", "story_v_out_410042.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410042", "410042027", "story_v_out_410042.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_33 = math.max(var_112_24, arg_109_1.talkMaxDuration)

			if var_112_23 <= arg_109_1.time_ and arg_109_1.time_ < var_112_23 + var_112_33 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_23) / var_112_33

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_23 + var_112_33 and arg_109_1.time_ < var_112_23 + var_112_33 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play410042028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410042028
		arg_113_1.duration_ = 9.97

		local var_113_0 = {
			zh = 3.233,
			ja = 9.966
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
				arg_113_0:Play410042029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1060"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1060 = var_116_0.localPosition
				var_116_0.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1060", 2)

				local var_116_2 = var_116_0.childCount

				for iter_116_0 = 0, var_116_2 - 1 do
					local var_116_3 = var_116_0:GetChild(iter_116_0)

					if var_116_3.name == "" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_4 then
				local var_116_5 = (arg_113_1.time_ - var_116_1) / var_116_4
				local var_116_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1060, var_116_6, var_116_5)
			end

			if arg_113_1.time_ >= var_116_1 + var_116_4 and arg_113_1.time_ < var_116_1 + var_116_4 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_116_7 = arg_113_1.actors_["1060"]
			local var_116_8 = 0

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps1060 == nil then
				arg_113_1.var_.actorSpriteComps1060 = var_116_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_9 = 0.034

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 and not isNil(var_116_7) then
				local var_116_10 = (arg_113_1.time_ - var_116_8) / var_116_9

				if arg_113_1.var_.actorSpriteComps1060 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								local var_116_11 = Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor1.r, var_116_10)
								local var_116_12 = Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor1.g, var_116_10)
								local var_116_13 = Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor1.b, var_116_10)

								iter_116_2.color = Color.New(var_116_11, var_116_12, var_116_13)
							else
								local var_116_14 = Mathf.Lerp(iter_116_2.color.r, 1, var_116_10)

								iter_116_2.color = Color.New(var_116_14, var_116_14, var_116_14)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps1060 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_116_4 then
						if arg_113_1.isInRecall_ then
							iter_116_4.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1060 = nil
			end

			local var_116_15 = arg_113_1.actors_["10059"]
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps10059 == nil then
				arg_113_1.var_.actorSpriteComps10059 = var_116_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_17 = 0.034

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 and not isNil(var_116_15) then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17

				if arg_113_1.var_.actorSpriteComps10059 then
					for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_116_6 then
							if arg_113_1.isInRecall_ then
								local var_116_19 = Mathf.Lerp(iter_116_6.color.r, arg_113_1.hightColor2.r, var_116_18)
								local var_116_20 = Mathf.Lerp(iter_116_6.color.g, arg_113_1.hightColor2.g, var_116_18)
								local var_116_21 = Mathf.Lerp(iter_116_6.color.b, arg_113_1.hightColor2.b, var_116_18)

								iter_116_6.color = Color.New(var_116_19, var_116_20, var_116_21)
							else
								local var_116_22 = Mathf.Lerp(iter_116_6.color.r, 0.5, var_116_18)

								iter_116_6.color = Color.New(var_116_22, var_116_22, var_116_22)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps10059 then
				for iter_116_7, iter_116_8 in pairs(arg_113_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_116_8 then
						if arg_113_1.isInRecall_ then
							iter_116_8.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10059 = nil
			end

			local var_116_23 = 0
			local var_116_24 = 0.425

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_25 = arg_113_1:FormatText(StoryNameCfg[584].name)

				arg_113_1.leftNameTxt_.text = var_116_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_26 = arg_113_1:GetWordFromCfg(410042028)
				local var_116_27 = arg_113_1:FormatText(var_116_26.content)

				arg_113_1.text_.text = var_116_27

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_28 = 17
				local var_116_29 = utf8.len(var_116_27)
				local var_116_30 = var_116_28 <= 0 and var_116_24 or var_116_24 * (var_116_29 / var_116_28)

				if var_116_30 > 0 and var_116_24 < var_116_30 then
					arg_113_1.talkMaxDuration = var_116_30

					if var_116_30 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_30 + var_116_23
					end
				end

				arg_113_1.text_.text = var_116_27
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042028", "story_v_out_410042.awb") ~= 0 then
					local var_116_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042028", "story_v_out_410042.awb") / 1000

					if var_116_31 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_23
					end

					if var_116_26.prefab_name ~= "" and arg_113_1.actors_[var_116_26.prefab_name] ~= nil then
						local var_116_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_26.prefab_name].transform, "story_v_out_410042", "410042028", "story_v_out_410042.awb")

						arg_113_1:RecordAudio("410042028", var_116_32)
						arg_113_1:RecordAudio("410042028", var_116_32)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410042", "410042028", "story_v_out_410042.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410042", "410042028", "story_v_out_410042.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_33 = math.max(var_116_24, arg_113_1.talkMaxDuration)

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_33 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_23) / var_116_33

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_23 + var_116_33 and arg_113_1.time_ < var_116_23 + var_116_33 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play410042029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410042029
		arg_117_1.duration_ = 15.53

		local var_117_0 = {
			zh = 5.5,
			ja = 15.533
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
				arg_117_0:Play410042030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10059"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10059 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10059", 4)

				local var_120_2 = var_120_0.childCount

				for iter_120_0 = 0, var_120_2 - 1 do
					local var_120_3 = var_120_0:GetChild(iter_120_0)

					if var_120_3.name == "split_2" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_4 then
				local var_120_5 = (arg_117_1.time_ - var_120_1) / var_120_4
				local var_120_6 = Vector3.New(390, -530, 35)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10059, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_120_7 = arg_117_1.actors_["10059"]
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps10059 == nil then
				arg_117_1.var_.actorSpriteComps10059 = var_120_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_9 = 0.034

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 and not isNil(var_120_7) then
				local var_120_10 = (arg_117_1.time_ - var_120_8) / var_120_9

				if arg_117_1.var_.actorSpriteComps10059 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								local var_120_11 = Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, var_120_10)
								local var_120_12 = Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, var_120_10)
								local var_120_13 = Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, var_120_10)

								iter_120_2.color = Color.New(var_120_11, var_120_12, var_120_13)
							else
								local var_120_14 = Mathf.Lerp(iter_120_2.color.r, 1, var_120_10)

								iter_120_2.color = Color.New(var_120_14, var_120_14, var_120_14)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps10059 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_120_4 then
						if arg_117_1.isInRecall_ then
							iter_120_4.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10059 = nil
			end

			local var_120_15 = arg_117_1.actors_["1060"]
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps1060 == nil then
				arg_117_1.var_.actorSpriteComps1060 = var_120_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_17 = 0.034

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 and not isNil(var_120_15) then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17

				if arg_117_1.var_.actorSpriteComps1060 then
					for iter_120_5, iter_120_6 in pairs(arg_117_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_120_6 then
							if arg_117_1.isInRecall_ then
								local var_120_19 = Mathf.Lerp(iter_120_6.color.r, arg_117_1.hightColor2.r, var_120_18)
								local var_120_20 = Mathf.Lerp(iter_120_6.color.g, arg_117_1.hightColor2.g, var_120_18)
								local var_120_21 = Mathf.Lerp(iter_120_6.color.b, arg_117_1.hightColor2.b, var_120_18)

								iter_120_6.color = Color.New(var_120_19, var_120_20, var_120_21)
							else
								local var_120_22 = Mathf.Lerp(iter_120_6.color.r, 0.5, var_120_18)

								iter_120_6.color = Color.New(var_120_22, var_120_22, var_120_22)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps1060 then
				for iter_120_7, iter_120_8 in pairs(arg_117_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_120_8 then
						if arg_117_1.isInRecall_ then
							iter_120_8.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1060 = nil
			end

			local var_120_23 = 0
			local var_120_24 = 0.65

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_25 = arg_117_1:FormatText(StoryNameCfg[596].name)

				arg_117_1.leftNameTxt_.text = var_120_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_26 = arg_117_1:GetWordFromCfg(410042029)
				local var_120_27 = arg_117_1:FormatText(var_120_26.content)

				arg_117_1.text_.text = var_120_27

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_28 = 26
				local var_120_29 = utf8.len(var_120_27)
				local var_120_30 = var_120_28 <= 0 and var_120_24 or var_120_24 * (var_120_29 / var_120_28)

				if var_120_30 > 0 and var_120_24 < var_120_30 then
					arg_117_1.talkMaxDuration = var_120_30

					if var_120_30 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_30 + var_120_23
					end
				end

				arg_117_1.text_.text = var_120_27
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042029", "story_v_out_410042.awb") ~= 0 then
					local var_120_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042029", "story_v_out_410042.awb") / 1000

					if var_120_31 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_31 + var_120_23
					end

					if var_120_26.prefab_name ~= "" and arg_117_1.actors_[var_120_26.prefab_name] ~= nil then
						local var_120_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_26.prefab_name].transform, "story_v_out_410042", "410042029", "story_v_out_410042.awb")

						arg_117_1:RecordAudio("410042029", var_120_32)
						arg_117_1:RecordAudio("410042029", var_120_32)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_410042", "410042029", "story_v_out_410042.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_410042", "410042029", "story_v_out_410042.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_33 = math.max(var_120_24, arg_117_1.talkMaxDuration)

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_33 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_23) / var_120_33

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_23 + var_120_33 and arg_117_1.time_ < var_120_23 + var_120_33 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play410042030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410042030
		arg_121_1.duration_ = 9.7

		local var_121_0 = {
			zh = 1.2,
			ja = 9.7
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
				arg_121_0:Play410042031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1060"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1060 = var_124_0.localPosition
				var_124_0.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1060", 2)

				local var_124_2 = var_124_0.childCount

				for iter_124_0 = 0, var_124_2 - 1 do
					local var_124_3 = var_124_0:GetChild(iter_124_0)

					if var_124_3.name == "" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_1) / var_124_4
				local var_124_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1060, var_124_6, var_124_5)
			end

			if arg_121_1.time_ >= var_124_1 + var_124_4 and arg_121_1.time_ < var_124_1 + var_124_4 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_124_7 = arg_121_1.actors_["1060"]
			local var_124_8 = 0

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps1060 == nil then
				arg_121_1.var_.actorSpriteComps1060 = var_124_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_9 = 0.034

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_9 and not isNil(var_124_7) then
				local var_124_10 = (arg_121_1.time_ - var_124_8) / var_124_9

				if arg_121_1.var_.actorSpriteComps1060 then
					for iter_124_1, iter_124_2 in pairs(arg_121_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_124_2 then
							if arg_121_1.isInRecall_ then
								local var_124_11 = Mathf.Lerp(iter_124_2.color.r, arg_121_1.hightColor1.r, var_124_10)
								local var_124_12 = Mathf.Lerp(iter_124_2.color.g, arg_121_1.hightColor1.g, var_124_10)
								local var_124_13 = Mathf.Lerp(iter_124_2.color.b, arg_121_1.hightColor1.b, var_124_10)

								iter_124_2.color = Color.New(var_124_11, var_124_12, var_124_13)
							else
								local var_124_14 = Mathf.Lerp(iter_124_2.color.r, 1, var_124_10)

								iter_124_2.color = Color.New(var_124_14, var_124_14, var_124_14)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_8 + var_124_9 and arg_121_1.time_ < var_124_8 + var_124_9 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps1060 then
				for iter_124_3, iter_124_4 in pairs(arg_121_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_124_4 then
						if arg_121_1.isInRecall_ then
							iter_124_4.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1060 = nil
			end

			local var_124_15 = arg_121_1.actors_["10059"]
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.actorSpriteComps10059 == nil then
				arg_121_1.var_.actorSpriteComps10059 = var_124_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_17 = 0.034

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 and not isNil(var_124_15) then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / var_124_17

				if arg_121_1.var_.actorSpriteComps10059 then
					for iter_124_5, iter_124_6 in pairs(arg_121_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_124_6 then
							if arg_121_1.isInRecall_ then
								local var_124_19 = Mathf.Lerp(iter_124_6.color.r, arg_121_1.hightColor2.r, var_124_18)
								local var_124_20 = Mathf.Lerp(iter_124_6.color.g, arg_121_1.hightColor2.g, var_124_18)
								local var_124_21 = Mathf.Lerp(iter_124_6.color.b, arg_121_1.hightColor2.b, var_124_18)

								iter_124_6.color = Color.New(var_124_19, var_124_20, var_124_21)
							else
								local var_124_22 = Mathf.Lerp(iter_124_6.color.r, 0.5, var_124_18)

								iter_124_6.color = Color.New(var_124_22, var_124_22, var_124_22)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.actorSpriteComps10059 then
				for iter_124_7, iter_124_8 in pairs(arg_121_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_124_8 then
						if arg_121_1.isInRecall_ then
							iter_124_8.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10059 = nil
			end

			local var_124_23 = 0
			local var_124_24 = 0.15

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_25 = arg_121_1:FormatText(StoryNameCfg[584].name)

				arg_121_1.leftNameTxt_.text = var_124_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_26 = arg_121_1:GetWordFromCfg(410042030)
				local var_124_27 = arg_121_1:FormatText(var_124_26.content)

				arg_121_1.text_.text = var_124_27

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_28 = 6
				local var_124_29 = utf8.len(var_124_27)
				local var_124_30 = var_124_28 <= 0 and var_124_24 or var_124_24 * (var_124_29 / var_124_28)

				if var_124_30 > 0 and var_124_24 < var_124_30 then
					arg_121_1.talkMaxDuration = var_124_30

					if var_124_30 + var_124_23 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_30 + var_124_23
					end
				end

				arg_121_1.text_.text = var_124_27
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042030", "story_v_out_410042.awb") ~= 0 then
					local var_124_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042030", "story_v_out_410042.awb") / 1000

					if var_124_31 + var_124_23 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_31 + var_124_23
					end

					if var_124_26.prefab_name ~= "" and arg_121_1.actors_[var_124_26.prefab_name] ~= nil then
						local var_124_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_26.prefab_name].transform, "story_v_out_410042", "410042030", "story_v_out_410042.awb")

						arg_121_1:RecordAudio("410042030", var_124_32)
						arg_121_1:RecordAudio("410042030", var_124_32)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_410042", "410042030", "story_v_out_410042.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_410042", "410042030", "story_v_out_410042.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_33 = math.max(var_124_24, arg_121_1.talkMaxDuration)

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_33 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_23) / var_124_33

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_23 + var_124_33 and arg_121_1.time_ < var_124_23 + var_124_33 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410042031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410042031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play410042032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1060"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1060 = var_128_0.localPosition
				var_128_0.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1060", 7)

				local var_128_2 = var_128_0.childCount

				for iter_128_0 = 0, var_128_2 - 1 do
					local var_128_3 = var_128_0:GetChild(iter_128_0)

					if var_128_3.name == "" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_4 then
				local var_128_5 = (arg_125_1.time_ - var_128_1) / var_128_4
				local var_128_6 = Vector3.New(0, -2000, -40)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1060, var_128_6, var_128_5)
			end

			if arg_125_1.time_ >= var_128_1 + var_128_4 and arg_125_1.time_ < var_128_1 + var_128_4 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_128_7 = arg_125_1.actors_["10059"].transform
			local var_128_8 = 0

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.var_.moveOldPos10059 = var_128_7.localPosition
				var_128_7.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10059", 7)

				local var_128_9 = var_128_7.childCount

				for iter_128_1 = 0, var_128_9 - 1 do
					local var_128_10 = var_128_7:GetChild(iter_128_1)

					if var_128_10.name == "" or not string.find(var_128_10.name, "split") then
						var_128_10.gameObject:SetActive(true)
					else
						var_128_10.gameObject:SetActive(false)
					end
				end
			end

			local var_128_11 = 0.001

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_11 then
				local var_128_12 = (arg_125_1.time_ - var_128_8) / var_128_11
				local var_128_13 = Vector3.New(0, -2000, 35)

				var_128_7.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10059, var_128_13, var_128_12)
			end

			if arg_125_1.time_ >= var_128_8 + var_128_11 and arg_125_1.time_ < var_128_8 + var_128_11 + arg_128_0 then
				var_128_7.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_128_14 = arg_125_1.actors_["1056"].transform
			local var_128_15 = 0

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.var_.moveOldPos1056 = var_128_14.localPosition
				var_128_14.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1056", 3)

				local var_128_16 = var_128_14.childCount

				for iter_128_2 = 0, var_128_16 - 1 do
					local var_128_17 = var_128_14:GetChild(iter_128_2)

					if var_128_17.name == "" or not string.find(var_128_17.name, "split") then
						var_128_17.gameObject:SetActive(true)
					else
						var_128_17.gameObject:SetActive(false)
					end
				end
			end

			local var_128_18 = 0.001

			if var_128_15 <= arg_125_1.time_ and arg_125_1.time_ < var_128_15 + var_128_18 then
				local var_128_19 = (arg_125_1.time_ - var_128_15) / var_128_18
				local var_128_20 = Vector3.New(0, -350, -180)

				var_128_14.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1056, var_128_20, var_128_19)
			end

			if arg_125_1.time_ >= var_128_15 + var_128_18 and arg_125_1.time_ < var_128_15 + var_128_18 + arg_128_0 then
				var_128_14.localPosition = Vector3.New(0, -350, -180)
			end

			local var_128_21 = arg_125_1.actors_["1060"]
			local var_128_22 = 0

			if var_128_22 < arg_125_1.time_ and arg_125_1.time_ <= var_128_22 + arg_128_0 and not isNil(var_128_21) and arg_125_1.var_.actorSpriteComps1060 == nil then
				arg_125_1.var_.actorSpriteComps1060 = var_128_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_23 = 0.034

			if var_128_22 <= arg_125_1.time_ and arg_125_1.time_ < var_128_22 + var_128_23 and not isNil(var_128_21) then
				local var_128_24 = (arg_125_1.time_ - var_128_22) / var_128_23

				if arg_125_1.var_.actorSpriteComps1060 then
					for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_128_4 then
							if arg_125_1.isInRecall_ then
								local var_128_25 = Mathf.Lerp(iter_128_4.color.r, arg_125_1.hightColor2.r, var_128_24)
								local var_128_26 = Mathf.Lerp(iter_128_4.color.g, arg_125_1.hightColor2.g, var_128_24)
								local var_128_27 = Mathf.Lerp(iter_128_4.color.b, arg_125_1.hightColor2.b, var_128_24)

								iter_128_4.color = Color.New(var_128_25, var_128_26, var_128_27)
							else
								local var_128_28 = Mathf.Lerp(iter_128_4.color.r, 0.5, var_128_24)

								iter_128_4.color = Color.New(var_128_28, var_128_28, var_128_28)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_22 + var_128_23 and arg_125_1.time_ < var_128_22 + var_128_23 + arg_128_0 and not isNil(var_128_21) and arg_125_1.var_.actorSpriteComps1060 then
				for iter_128_5, iter_128_6 in pairs(arg_125_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_128_6 then
						if arg_125_1.isInRecall_ then
							iter_128_6.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1060 = nil
			end

			local var_128_29 = arg_125_1.actors_["10059"]
			local var_128_30 = 0

			if var_128_30 < arg_125_1.time_ and arg_125_1.time_ <= var_128_30 + arg_128_0 and not isNil(var_128_29) and arg_125_1.var_.actorSpriteComps10059 == nil then
				arg_125_1.var_.actorSpriteComps10059 = var_128_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_31 = 0.034

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_31 and not isNil(var_128_29) then
				local var_128_32 = (arg_125_1.time_ - var_128_30) / var_128_31

				if arg_125_1.var_.actorSpriteComps10059 then
					for iter_128_7, iter_128_8 in pairs(arg_125_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_128_8 then
							if arg_125_1.isInRecall_ then
								local var_128_33 = Mathf.Lerp(iter_128_8.color.r, arg_125_1.hightColor2.r, var_128_32)
								local var_128_34 = Mathf.Lerp(iter_128_8.color.g, arg_125_1.hightColor2.g, var_128_32)
								local var_128_35 = Mathf.Lerp(iter_128_8.color.b, arg_125_1.hightColor2.b, var_128_32)

								iter_128_8.color = Color.New(var_128_33, var_128_34, var_128_35)
							else
								local var_128_36 = Mathf.Lerp(iter_128_8.color.r, 0.5, var_128_32)

								iter_128_8.color = Color.New(var_128_36, var_128_36, var_128_36)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_30 + var_128_31 and arg_125_1.time_ < var_128_30 + var_128_31 + arg_128_0 and not isNil(var_128_29) and arg_125_1.var_.actorSpriteComps10059 then
				for iter_128_9, iter_128_10 in pairs(arg_125_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_128_10 then
						if arg_125_1.isInRecall_ then
							iter_128_10.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10059 = nil
			end

			local var_128_37 = arg_125_1.actors_["1056"]
			local var_128_38 = 0

			if var_128_38 < arg_125_1.time_ and arg_125_1.time_ <= var_128_38 + arg_128_0 and not isNil(var_128_37) and arg_125_1.var_.actorSpriteComps1056 == nil then
				arg_125_1.var_.actorSpriteComps1056 = var_128_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_39 = 0.034

			if var_128_38 <= arg_125_1.time_ and arg_125_1.time_ < var_128_38 + var_128_39 and not isNil(var_128_37) then
				local var_128_40 = (arg_125_1.time_ - var_128_38) / var_128_39

				if arg_125_1.var_.actorSpriteComps1056 then
					for iter_128_11, iter_128_12 in pairs(arg_125_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_128_12 then
							if arg_125_1.isInRecall_ then
								local var_128_41 = Mathf.Lerp(iter_128_12.color.r, arg_125_1.hightColor2.r, var_128_40)
								local var_128_42 = Mathf.Lerp(iter_128_12.color.g, arg_125_1.hightColor2.g, var_128_40)
								local var_128_43 = Mathf.Lerp(iter_128_12.color.b, arg_125_1.hightColor2.b, var_128_40)

								iter_128_12.color = Color.New(var_128_41, var_128_42, var_128_43)
							else
								local var_128_44 = Mathf.Lerp(iter_128_12.color.r, 0.5, var_128_40)

								iter_128_12.color = Color.New(var_128_44, var_128_44, var_128_44)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_38 + var_128_39 and arg_125_1.time_ < var_128_38 + var_128_39 + arg_128_0 and not isNil(var_128_37) and arg_125_1.var_.actorSpriteComps1056 then
				for iter_128_13, iter_128_14 in pairs(arg_125_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_128_14 then
						if arg_125_1.isInRecall_ then
							iter_128_14.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_14.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1056 = nil
			end

			local var_128_45 = 0
			local var_128_46 = 1

			if var_128_45 < arg_125_1.time_ and arg_125_1.time_ <= var_128_45 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_47 = arg_125_1:GetWordFromCfg(410042031)
				local var_128_48 = arg_125_1:FormatText(var_128_47.content)

				arg_125_1.text_.text = var_128_48

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_49 = 40
				local var_128_50 = utf8.len(var_128_48)
				local var_128_51 = var_128_49 <= 0 and var_128_46 or var_128_46 * (var_128_50 / var_128_49)

				if var_128_51 > 0 and var_128_46 < var_128_51 then
					arg_125_1.talkMaxDuration = var_128_51

					if var_128_51 + var_128_45 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_51 + var_128_45
					end
				end

				arg_125_1.text_.text = var_128_48
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_52 = math.max(var_128_46, arg_125_1.talkMaxDuration)

			if var_128_45 <= arg_125_1.time_ and arg_125_1.time_ < var_128_45 + var_128_52 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_45) / var_128_52

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_45 + var_128_52 and arg_125_1.time_ < var_128_45 + var_128_52 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play410042032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410042032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play410042033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1056"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1056 = var_132_0.localPosition
				var_132_0.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1056", 7)

				local var_132_2 = var_132_0.childCount

				for iter_132_0 = 0, var_132_2 - 1 do
					local var_132_3 = var_132_0:GetChild(iter_132_0)

					if var_132_3.name == "" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_4 then
				local var_132_5 = (arg_129_1.time_ - var_132_1) / var_132_4
				local var_132_6 = Vector3.New(0, -2000, -180)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1056, var_132_6, var_132_5)
			end

			if arg_129_1.time_ >= var_132_1 + var_132_4 and arg_129_1.time_ < var_132_1 + var_132_4 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_132_7 = 0
			local var_132_8 = 1

			if var_132_7 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				local var_132_9 = "stop"
				local var_132_10 = "effect"

				arg_129_1:AudioAction(var_132_9, var_132_10, "se_story_side_1055", "se_story_side_1055_rain", "")
			end

			local var_132_11 = 0
			local var_132_12 = 1.125

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_13 = arg_129_1:GetWordFromCfg(410042032)
				local var_132_14 = arg_129_1:FormatText(var_132_13.content)

				arg_129_1.text_.text = var_132_14

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_15 = 45
				local var_132_16 = utf8.len(var_132_14)
				local var_132_17 = var_132_15 <= 0 and var_132_12 or var_132_12 * (var_132_16 / var_132_15)

				if var_132_17 > 0 and var_132_12 < var_132_17 then
					arg_129_1.talkMaxDuration = var_132_17

					if var_132_17 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_17 + var_132_11
					end
				end

				arg_129_1.text_.text = var_132_14
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_18 = math.max(var_132_12, arg_129_1.talkMaxDuration)

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_18 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_11) / var_132_18

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_11 + var_132_18 and arg_129_1.time_ < var_132_11 + var_132_18 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play410042033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 410042033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play410042034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = "10063"

			if arg_133_1.actors_[var_136_0] == nil then
				local var_136_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10063")

				if not isNil(var_136_1) then
					local var_136_2 = Object.Instantiate(var_136_1, arg_133_1.canvasGo_.transform)

					var_136_2.transform:SetSiblingIndex(1)

					var_136_2.name = var_136_0
					var_136_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_133_1.actors_[var_136_0] = var_136_2

					local var_136_3 = var_136_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_133_1.isInRecall_ then
						for iter_136_0, iter_136_1 in ipairs(var_136_3) do
							iter_136_1.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_136_4 = arg_133_1.actors_["10063"].transform
			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.var_.moveOldPos10063 = var_136_4.localPosition
				var_136_4.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10063", 2)

				local var_136_6 = var_136_4.childCount

				for iter_136_2 = 0, var_136_6 - 1 do
					local var_136_7 = var_136_4:GetChild(iter_136_2)

					if var_136_7.name == "" or not string.find(var_136_7.name, "split") then
						var_136_7.gameObject:SetActive(true)
					else
						var_136_7.gameObject:SetActive(false)
					end
				end
			end

			local var_136_8 = 0.001

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_8 then
				local var_136_9 = (arg_133_1.time_ - var_136_5) / var_136_8
				local var_136_10 = Vector3.New(-390, -535, -105)

				var_136_4.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10063, var_136_10, var_136_9)
			end

			if arg_133_1.time_ >= var_136_5 + var_136_8 and arg_133_1.time_ < var_136_5 + var_136_8 + arg_136_0 then
				var_136_4.localPosition = Vector3.New(-390, -535, -105)
			end

			local var_136_11 = "10060"

			if arg_133_1.actors_[var_136_11] == nil then
				local var_136_12 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10060")

				if not isNil(var_136_12) then
					local var_136_13 = Object.Instantiate(var_136_12, arg_133_1.canvasGo_.transform)

					var_136_13.transform:SetSiblingIndex(1)

					var_136_13.name = var_136_11
					var_136_13.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_133_1.actors_[var_136_11] = var_136_13

					local var_136_14 = var_136_13:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_133_1.isInRecall_ then
						for iter_136_3, iter_136_4 in ipairs(var_136_14) do
							iter_136_4.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_136_15 = arg_133_1.actors_["10060"].transform
			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.var_.moveOldPos10060 = var_136_15.localPosition
				var_136_15.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10060", 4)

				local var_136_17 = var_136_15.childCount

				for iter_136_5 = 0, var_136_17 - 1 do
					local var_136_18 = var_136_15:GetChild(iter_136_5)

					if var_136_18.name == "" or not string.find(var_136_18.name, "split") then
						var_136_18.gameObject:SetActive(true)
					else
						var_136_18.gameObject:SetActive(false)
					end
				end
			end

			local var_136_19 = 0.001

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_19 then
				local var_136_20 = (arg_133_1.time_ - var_136_16) / var_136_19
				local var_136_21 = Vector3.New(390, -400, 0)

				var_136_15.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10060, var_136_21, var_136_20)
			end

			if arg_133_1.time_ >= var_136_16 + var_136_19 and arg_133_1.time_ < var_136_16 + var_136_19 + arg_136_0 then
				var_136_15.localPosition = Vector3.New(390, -400, 0)
			end

			local var_136_22 = arg_133_1.actors_["10063"]
			local var_136_23 = 0

			if var_136_23 < arg_133_1.time_ and arg_133_1.time_ <= var_136_23 + arg_136_0 and not isNil(var_136_22) and arg_133_1.var_.actorSpriteComps10063 == nil then
				arg_133_1.var_.actorSpriteComps10063 = var_136_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_24 = 0.034

			if var_136_23 <= arg_133_1.time_ and arg_133_1.time_ < var_136_23 + var_136_24 and not isNil(var_136_22) then
				local var_136_25 = (arg_133_1.time_ - var_136_23) / var_136_24

				if arg_133_1.var_.actorSpriteComps10063 then
					for iter_136_6, iter_136_7 in pairs(arg_133_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_136_7 then
							if arg_133_1.isInRecall_ then
								local var_136_26 = Mathf.Lerp(iter_136_7.color.r, arg_133_1.hightColor2.r, var_136_25)
								local var_136_27 = Mathf.Lerp(iter_136_7.color.g, arg_133_1.hightColor2.g, var_136_25)
								local var_136_28 = Mathf.Lerp(iter_136_7.color.b, arg_133_1.hightColor2.b, var_136_25)

								iter_136_7.color = Color.New(var_136_26, var_136_27, var_136_28)
							else
								local var_136_29 = Mathf.Lerp(iter_136_7.color.r, 0.5, var_136_25)

								iter_136_7.color = Color.New(var_136_29, var_136_29, var_136_29)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_23 + var_136_24 and arg_133_1.time_ < var_136_23 + var_136_24 + arg_136_0 and not isNil(var_136_22) and arg_133_1.var_.actorSpriteComps10063 then
				for iter_136_8, iter_136_9 in pairs(arg_133_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_136_9 then
						if arg_133_1.isInRecall_ then
							iter_136_9.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10063 = nil
			end

			local var_136_30 = arg_133_1.actors_["10060"]
			local var_136_31 = 0

			if var_136_31 < arg_133_1.time_ and arg_133_1.time_ <= var_136_31 + arg_136_0 and not isNil(var_136_30) and arg_133_1.var_.actorSpriteComps10060 == nil then
				arg_133_1.var_.actorSpriteComps10060 = var_136_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_32 = 0.034

			if var_136_31 <= arg_133_1.time_ and arg_133_1.time_ < var_136_31 + var_136_32 and not isNil(var_136_30) then
				local var_136_33 = (arg_133_1.time_ - var_136_31) / var_136_32

				if arg_133_1.var_.actorSpriteComps10060 then
					for iter_136_10, iter_136_11 in pairs(arg_133_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_136_11 then
							if arg_133_1.isInRecall_ then
								local var_136_34 = Mathf.Lerp(iter_136_11.color.r, arg_133_1.hightColor2.r, var_136_33)
								local var_136_35 = Mathf.Lerp(iter_136_11.color.g, arg_133_1.hightColor2.g, var_136_33)
								local var_136_36 = Mathf.Lerp(iter_136_11.color.b, arg_133_1.hightColor2.b, var_136_33)

								iter_136_11.color = Color.New(var_136_34, var_136_35, var_136_36)
							else
								local var_136_37 = Mathf.Lerp(iter_136_11.color.r, 0.5, var_136_33)

								iter_136_11.color = Color.New(var_136_37, var_136_37, var_136_37)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_31 + var_136_32 and arg_133_1.time_ < var_136_31 + var_136_32 + arg_136_0 and not isNil(var_136_30) and arg_133_1.var_.actorSpriteComps10060 then
				for iter_136_12, iter_136_13 in pairs(arg_133_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_136_13 then
						if arg_133_1.isInRecall_ then
							iter_136_13.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_13.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10060 = nil
			end

			local var_136_38 = arg_133_1.actors_["1056"].transform
			local var_136_39 = 0

			if var_136_39 < arg_133_1.time_ and arg_133_1.time_ <= var_136_39 + arg_136_0 then
				arg_133_1.var_.moveOldPos1056 = var_136_38.localPosition
				var_136_38.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("1056", 7)

				local var_136_40 = var_136_38.childCount

				for iter_136_14 = 0, var_136_40 - 1 do
					local var_136_41 = var_136_38:GetChild(iter_136_14)

					if var_136_41.name == "" or not string.find(var_136_41.name, "split") then
						var_136_41.gameObject:SetActive(true)
					else
						var_136_41.gameObject:SetActive(false)
					end
				end
			end

			local var_136_42 = 0.001

			if var_136_39 <= arg_133_1.time_ and arg_133_1.time_ < var_136_39 + var_136_42 then
				local var_136_43 = (arg_133_1.time_ - var_136_39) / var_136_42
				local var_136_44 = Vector3.New(0, -2000, -180)

				var_136_38.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1056, var_136_44, var_136_43)
			end

			if arg_133_1.time_ >= var_136_39 + var_136_42 and arg_133_1.time_ < var_136_39 + var_136_42 + arg_136_0 then
				var_136_38.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_136_45 = 0
			local var_136_46 = 1.1

			if var_136_45 < arg_133_1.time_ and arg_133_1.time_ <= var_136_45 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_47 = arg_133_1:GetWordFromCfg(410042033)
				local var_136_48 = arg_133_1:FormatText(var_136_47.content)

				arg_133_1.text_.text = var_136_48

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_49 = 44
				local var_136_50 = utf8.len(var_136_48)
				local var_136_51 = var_136_49 <= 0 and var_136_46 or var_136_46 * (var_136_50 / var_136_49)

				if var_136_51 > 0 and var_136_46 < var_136_51 then
					arg_133_1.talkMaxDuration = var_136_51

					if var_136_51 + var_136_45 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_51 + var_136_45
					end
				end

				arg_133_1.text_.text = var_136_48
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_52 = math.max(var_136_46, arg_133_1.talkMaxDuration)

			if var_136_45 <= arg_133_1.time_ and arg_133_1.time_ < var_136_45 + var_136_52 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_45) / var_136_52

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_45 + var_136_52 and arg_133_1.time_ < var_136_45 + var_136_52 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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
				actorName = "1056",
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
	Play410042034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410042034
		arg_137_1.duration_ = 6.43

		local var_137_0 = {
			zh = 3.2,
			ja = 6.433
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
				arg_137_0:Play410042035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10060"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10060 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10060", 4)

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
				local var_140_6 = Vector3.New(390, -400, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10060, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_140_7 = arg_137_1.actors_["10060"]
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps10060 == nil then
				arg_137_1.var_.actorSpriteComps10060 = var_140_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_9 = 0.034

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 and not isNil(var_140_7) then
				local var_140_10 = (arg_137_1.time_ - var_140_8) / var_140_9

				if arg_137_1.var_.actorSpriteComps10060 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps10060 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_140_4 then
						if arg_137_1.isInRecall_ then
							iter_140_4.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10060 = nil
			end

			local var_140_15 = 0
			local var_140_16 = 0.3

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_17 = arg_137_1:FormatText(StoryNameCfg[36].name)

				arg_137_1.leftNameTxt_.text = var_140_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(410042034)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042034", "story_v_out_410042.awb") ~= 0 then
					local var_140_23 = manager.audio:GetVoiceLength("story_v_out_410042", "410042034", "story_v_out_410042.awb") / 1000

					if var_140_23 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_15
					end

					if var_140_18.prefab_name ~= "" and arg_137_1.actors_[var_140_18.prefab_name] ~= nil then
						local var_140_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_18.prefab_name].transform, "story_v_out_410042", "410042034", "story_v_out_410042.awb")

						arg_137_1:RecordAudio("410042034", var_140_24)
						arg_137_1:RecordAudio("410042034", var_140_24)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_410042", "410042034", "story_v_out_410042.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_410042", "410042034", "story_v_out_410042.awb")
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
				actorName = "10060",
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
	Play410042035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410042035
		arg_141_1.duration_ = 5.8

		local var_141_0 = {
			zh = 3.333,
			ja = 5.8
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
				arg_141_0:Play410042036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10063"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10063 = var_144_0.localPosition
				var_144_0.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10063", 7)

				local var_144_2 = var_144_0.childCount

				for iter_144_0 = 0, var_144_2 - 1 do
					local var_144_3 = var_144_0:GetChild(iter_144_0)

					if var_144_3.name == "" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_4 then
				local var_144_5 = (arg_141_1.time_ - var_144_1) / var_144_4
				local var_144_6 = Vector3.New(0, -2000, -105)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10063, var_144_6, var_144_5)
			end

			if arg_141_1.time_ >= var_144_1 + var_144_4 and arg_141_1.time_ < var_144_1 + var_144_4 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_144_7 = arg_141_1.actors_["10060"].transform
			local var_144_8 = 0

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.var_.moveOldPos10060 = var_144_7.localPosition
				var_144_7.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10060", 7)

				local var_144_9 = var_144_7.childCount

				for iter_144_1 = 0, var_144_9 - 1 do
					local var_144_10 = var_144_7:GetChild(iter_144_1)

					if var_144_10.name == "" or not string.find(var_144_10.name, "split") then
						var_144_10.gameObject:SetActive(true)
					else
						var_144_10.gameObject:SetActive(false)
					end
				end
			end

			local var_144_11 = 0.001

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_11 then
				local var_144_12 = (arg_141_1.time_ - var_144_8) / var_144_11
				local var_144_13 = Vector3.New(0, -2000, 0)

				var_144_7.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10060, var_144_13, var_144_12)
			end

			if arg_141_1.time_ >= var_144_8 + var_144_11 and arg_141_1.time_ < var_144_8 + var_144_11 + arg_144_0 then
				var_144_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_14 = arg_141_1.actors_["10059"].transform
			local var_144_15 = 0

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.var_.moveOldPos10059 = var_144_14.localPosition
				var_144_14.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10059", 3)

				local var_144_16 = var_144_14.childCount

				for iter_144_2 = 0, var_144_16 - 1 do
					local var_144_17 = var_144_14:GetChild(iter_144_2)

					if var_144_17.name == "" or not string.find(var_144_17.name, "split") then
						var_144_17.gameObject:SetActive(true)
					else
						var_144_17.gameObject:SetActive(false)
					end
				end
			end

			local var_144_18 = 0.001

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_18 then
				local var_144_19 = (arg_141_1.time_ - var_144_15) / var_144_18
				local var_144_20 = Vector3.New(0, -530, 35)

				var_144_14.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10059, var_144_20, var_144_19)
			end

			if arg_141_1.time_ >= var_144_15 + var_144_18 and arg_141_1.time_ < var_144_15 + var_144_18 + arg_144_0 then
				var_144_14.localPosition = Vector3.New(0, -530, 35)
			end

			local var_144_21 = arg_141_1.actors_["10063"]
			local var_144_22 = 0

			if var_144_22 < arg_141_1.time_ and arg_141_1.time_ <= var_144_22 + arg_144_0 and not isNil(var_144_21) and arg_141_1.var_.actorSpriteComps10063 == nil then
				arg_141_1.var_.actorSpriteComps10063 = var_144_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_23 = 0.034

			if var_144_22 <= arg_141_1.time_ and arg_141_1.time_ < var_144_22 + var_144_23 and not isNil(var_144_21) then
				local var_144_24 = (arg_141_1.time_ - var_144_22) / var_144_23

				if arg_141_1.var_.actorSpriteComps10063 then
					for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_144_4 then
							if arg_141_1.isInRecall_ then
								local var_144_25 = Mathf.Lerp(iter_144_4.color.r, arg_141_1.hightColor2.r, var_144_24)
								local var_144_26 = Mathf.Lerp(iter_144_4.color.g, arg_141_1.hightColor2.g, var_144_24)
								local var_144_27 = Mathf.Lerp(iter_144_4.color.b, arg_141_1.hightColor2.b, var_144_24)

								iter_144_4.color = Color.New(var_144_25, var_144_26, var_144_27)
							else
								local var_144_28 = Mathf.Lerp(iter_144_4.color.r, 0.5, var_144_24)

								iter_144_4.color = Color.New(var_144_28, var_144_28, var_144_28)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_22 + var_144_23 and arg_141_1.time_ < var_144_22 + var_144_23 + arg_144_0 and not isNil(var_144_21) and arg_141_1.var_.actorSpriteComps10063 then
				for iter_144_5, iter_144_6 in pairs(arg_141_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_144_6 then
						if arg_141_1.isInRecall_ then
							iter_144_6.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10063 = nil
			end

			local var_144_29 = arg_141_1.actors_["10060"]
			local var_144_30 = 0

			if var_144_30 < arg_141_1.time_ and arg_141_1.time_ <= var_144_30 + arg_144_0 and not isNil(var_144_29) and arg_141_1.var_.actorSpriteComps10060 == nil then
				arg_141_1.var_.actorSpriteComps10060 = var_144_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_31 = 0.034

			if var_144_30 <= arg_141_1.time_ and arg_141_1.time_ < var_144_30 + var_144_31 and not isNil(var_144_29) then
				local var_144_32 = (arg_141_1.time_ - var_144_30) / var_144_31

				if arg_141_1.var_.actorSpriteComps10060 then
					for iter_144_7, iter_144_8 in pairs(arg_141_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_144_8 then
							if arg_141_1.isInRecall_ then
								local var_144_33 = Mathf.Lerp(iter_144_8.color.r, arg_141_1.hightColor2.r, var_144_32)
								local var_144_34 = Mathf.Lerp(iter_144_8.color.g, arg_141_1.hightColor2.g, var_144_32)
								local var_144_35 = Mathf.Lerp(iter_144_8.color.b, arg_141_1.hightColor2.b, var_144_32)

								iter_144_8.color = Color.New(var_144_33, var_144_34, var_144_35)
							else
								local var_144_36 = Mathf.Lerp(iter_144_8.color.r, 0.5, var_144_32)

								iter_144_8.color = Color.New(var_144_36, var_144_36, var_144_36)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_30 + var_144_31 and arg_141_1.time_ < var_144_30 + var_144_31 + arg_144_0 and not isNil(var_144_29) and arg_141_1.var_.actorSpriteComps10060 then
				for iter_144_9, iter_144_10 in pairs(arg_141_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_144_10 then
						if arg_141_1.isInRecall_ then
							iter_144_10.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10060 = nil
			end

			local var_144_37 = arg_141_1.actors_["10059"]
			local var_144_38 = 0

			if var_144_38 < arg_141_1.time_ and arg_141_1.time_ <= var_144_38 + arg_144_0 and not isNil(var_144_37) and arg_141_1.var_.actorSpriteComps10059 == nil then
				arg_141_1.var_.actorSpriteComps10059 = var_144_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_39 = 0.034

			if var_144_38 <= arg_141_1.time_ and arg_141_1.time_ < var_144_38 + var_144_39 and not isNil(var_144_37) then
				local var_144_40 = (arg_141_1.time_ - var_144_38) / var_144_39

				if arg_141_1.var_.actorSpriteComps10059 then
					for iter_144_11, iter_144_12 in pairs(arg_141_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_144_12 then
							if arg_141_1.isInRecall_ then
								local var_144_41 = Mathf.Lerp(iter_144_12.color.r, arg_141_1.hightColor1.r, var_144_40)
								local var_144_42 = Mathf.Lerp(iter_144_12.color.g, arg_141_1.hightColor1.g, var_144_40)
								local var_144_43 = Mathf.Lerp(iter_144_12.color.b, arg_141_1.hightColor1.b, var_144_40)

								iter_144_12.color = Color.New(var_144_41, var_144_42, var_144_43)
							else
								local var_144_44 = Mathf.Lerp(iter_144_12.color.r, 1, var_144_40)

								iter_144_12.color = Color.New(var_144_44, var_144_44, var_144_44)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_38 + var_144_39 and arg_141_1.time_ < var_144_38 + var_144_39 + arg_144_0 and not isNil(var_144_37) and arg_141_1.var_.actorSpriteComps10059 then
				for iter_144_13, iter_144_14 in pairs(arg_141_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_144_14 then
						if arg_141_1.isInRecall_ then
							iter_144_14.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_14.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10059 = nil
			end

			local var_144_45 = 0
			local var_144_46 = 0.325

			if var_144_45 < arg_141_1.time_ and arg_141_1.time_ <= var_144_45 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_47 = arg_141_1:FormatText(StoryNameCfg[596].name)

				arg_141_1.leftNameTxt_.text = var_144_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_48 = arg_141_1:GetWordFromCfg(410042035)
				local var_144_49 = arg_141_1:FormatText(var_144_48.content)

				arg_141_1.text_.text = var_144_49

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_50 = 13
				local var_144_51 = utf8.len(var_144_49)
				local var_144_52 = var_144_50 <= 0 and var_144_46 or var_144_46 * (var_144_51 / var_144_50)

				if var_144_52 > 0 and var_144_46 < var_144_52 then
					arg_141_1.talkMaxDuration = var_144_52

					if var_144_52 + var_144_45 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_52 + var_144_45
					end
				end

				arg_141_1.text_.text = var_144_49
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042035", "story_v_out_410042.awb") ~= 0 then
					local var_144_53 = manager.audio:GetVoiceLength("story_v_out_410042", "410042035", "story_v_out_410042.awb") / 1000

					if var_144_53 + var_144_45 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_53 + var_144_45
					end

					if var_144_48.prefab_name ~= "" and arg_141_1.actors_[var_144_48.prefab_name] ~= nil then
						local var_144_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_48.prefab_name].transform, "story_v_out_410042", "410042035", "story_v_out_410042.awb")

						arg_141_1:RecordAudio("410042035", var_144_54)
						arg_141_1:RecordAudio("410042035", var_144_54)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_410042", "410042035", "story_v_out_410042.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_410042", "410042035", "story_v_out_410042.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_55 = math.max(var_144_46, arg_141_1.talkMaxDuration)

			if var_144_45 <= arg_141_1.time_ and arg_141_1.time_ < var_144_45 + var_144_55 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_45) / var_144_55

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_45 + var_144_55 and arg_141_1.time_ < var_144_45 + var_144_55 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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

		arg_141_1:InitPlayNodeList()
	end,
	Play410042036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410042036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play410042037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1060"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1060 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1060", 2)

				local var_148_2 = var_148_0.childCount

				for iter_148_0 = 0, var_148_2 - 1 do
					local var_148_3 = var_148_0:GetChild(iter_148_0)

					if var_148_3.name == "" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_4 then
				local var_148_5 = (arg_145_1.time_ - var_148_1) / var_148_4
				local var_148_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1060, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_148_7 = arg_145_1.actors_["10063"].transform
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.var_.moveOldPos10063 = var_148_7.localPosition
				var_148_7.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10063", 4)

				local var_148_9 = var_148_7.childCount

				for iter_148_1 = 0, var_148_9 - 1 do
					local var_148_10 = var_148_7:GetChild(iter_148_1)

					if var_148_10.name == "" or not string.find(var_148_10.name, "split") then
						var_148_10.gameObject:SetActive(true)
					else
						var_148_10.gameObject:SetActive(false)
					end
				end
			end

			local var_148_11 = 0.001

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_11 then
				local var_148_12 = (arg_145_1.time_ - var_148_8) / var_148_11
				local var_148_13 = Vector3.New(390, -535, -105)

				var_148_7.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10063, var_148_13, var_148_12)
			end

			if arg_145_1.time_ >= var_148_8 + var_148_11 and arg_145_1.time_ < var_148_8 + var_148_11 + arg_148_0 then
				var_148_7.localPosition = Vector3.New(390, -535, -105)
			end

			local var_148_14 = arg_145_1.actors_["1060"]
			local var_148_15 = 0

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 and not isNil(var_148_14) and arg_145_1.var_.actorSpriteComps1060 == nil then
				arg_145_1.var_.actorSpriteComps1060 = var_148_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_16 = 0.034

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_16 and not isNil(var_148_14) then
				local var_148_17 = (arg_145_1.time_ - var_148_15) / var_148_16

				if arg_145_1.var_.actorSpriteComps1060 then
					for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_148_3 then
							if arg_145_1.isInRecall_ then
								local var_148_18 = Mathf.Lerp(iter_148_3.color.r, arg_145_1.hightColor2.r, var_148_17)
								local var_148_19 = Mathf.Lerp(iter_148_3.color.g, arg_145_1.hightColor2.g, var_148_17)
								local var_148_20 = Mathf.Lerp(iter_148_3.color.b, arg_145_1.hightColor2.b, var_148_17)

								iter_148_3.color = Color.New(var_148_18, var_148_19, var_148_20)
							else
								local var_148_21 = Mathf.Lerp(iter_148_3.color.r, 0.5, var_148_17)

								iter_148_3.color = Color.New(var_148_21, var_148_21, var_148_21)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_15 + var_148_16 and arg_145_1.time_ < var_148_15 + var_148_16 + arg_148_0 and not isNil(var_148_14) and arg_145_1.var_.actorSpriteComps1060 then
				for iter_148_4, iter_148_5 in pairs(arg_145_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_148_5 then
						if arg_145_1.isInRecall_ then
							iter_148_5.color = arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_148_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1060 = nil
			end

			local var_148_22 = arg_145_1.actors_["10063"]
			local var_148_23 = 0

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 and not isNil(var_148_22) and arg_145_1.var_.actorSpriteComps10063 == nil then
				arg_145_1.var_.actorSpriteComps10063 = var_148_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_24 = 0.034

			if var_148_23 <= arg_145_1.time_ and arg_145_1.time_ < var_148_23 + var_148_24 and not isNil(var_148_22) then
				local var_148_25 = (arg_145_1.time_ - var_148_23) / var_148_24

				if arg_145_1.var_.actorSpriteComps10063 then
					for iter_148_6, iter_148_7 in pairs(arg_145_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_148_7 then
							if arg_145_1.isInRecall_ then
								local var_148_26 = Mathf.Lerp(iter_148_7.color.r, arg_145_1.hightColor2.r, var_148_25)
								local var_148_27 = Mathf.Lerp(iter_148_7.color.g, arg_145_1.hightColor2.g, var_148_25)
								local var_148_28 = Mathf.Lerp(iter_148_7.color.b, arg_145_1.hightColor2.b, var_148_25)

								iter_148_7.color = Color.New(var_148_26, var_148_27, var_148_28)
							else
								local var_148_29 = Mathf.Lerp(iter_148_7.color.r, 0.5, var_148_25)

								iter_148_7.color = Color.New(var_148_29, var_148_29, var_148_29)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_23 + var_148_24 and arg_145_1.time_ < var_148_23 + var_148_24 + arg_148_0 and not isNil(var_148_22) and arg_145_1.var_.actorSpriteComps10063 then
				for iter_148_8, iter_148_9 in pairs(arg_145_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_148_9 then
						if arg_145_1.isInRecall_ then
							iter_148_9.color = arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_148_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10063 = nil
			end

			local var_148_30 = arg_145_1.actors_["10059"].transform
			local var_148_31 = 0

			if var_148_31 < arg_145_1.time_ and arg_145_1.time_ <= var_148_31 + arg_148_0 then
				arg_145_1.var_.moveOldPos10059 = var_148_30.localPosition
				var_148_30.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10059", 7)

				local var_148_32 = var_148_30.childCount

				for iter_148_10 = 0, var_148_32 - 1 do
					local var_148_33 = var_148_30:GetChild(iter_148_10)

					if var_148_33.name == "" or not string.find(var_148_33.name, "split") then
						var_148_33.gameObject:SetActive(true)
					else
						var_148_33.gameObject:SetActive(false)
					end
				end
			end

			local var_148_34 = 0.001

			if var_148_31 <= arg_145_1.time_ and arg_145_1.time_ < var_148_31 + var_148_34 then
				local var_148_35 = (arg_145_1.time_ - var_148_31) / var_148_34
				local var_148_36 = Vector3.New(0, -2000, 35)

				var_148_30.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10059, var_148_36, var_148_35)
			end

			if arg_145_1.time_ >= var_148_31 + var_148_34 and arg_145_1.time_ < var_148_31 + var_148_34 + arg_148_0 then
				var_148_30.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_148_37 = 0
			local var_148_38 = 0.975

			if var_148_37 < arg_145_1.time_ and arg_145_1.time_ <= var_148_37 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_39 = arg_145_1:GetWordFromCfg(410042036)
				local var_148_40 = arg_145_1:FormatText(var_148_39.content)

				arg_145_1.text_.text = var_148_40

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_41 = 39
				local var_148_42 = utf8.len(var_148_40)
				local var_148_43 = var_148_41 <= 0 and var_148_38 or var_148_38 * (var_148_42 / var_148_41)

				if var_148_43 > 0 and var_148_38 < var_148_43 then
					arg_145_1.talkMaxDuration = var_148_43

					if var_148_43 + var_148_37 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_43 + var_148_37
					end
				end

				arg_145_1.text_.text = var_148_40
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_44 = math.max(var_148_38, arg_145_1.talkMaxDuration)

			if var_148_37 <= arg_145_1.time_ and arg_145_1.time_ < var_148_37 + var_148_44 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_37) / var_148_44

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_37 + var_148_44 and arg_145_1.time_ < var_148_37 + var_148_44 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10063",
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

		arg_145_1:InitPlayNodeList()
	end,
	Play410042037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410042037
		arg_149_1.duration_ = 5.53

		local var_149_0 = {
			zh = 3.933,
			ja = 5.533
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
				arg_149_0:Play410042038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1056"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1056 = var_152_0.localPosition
				var_152_0.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1056", 2)

				local var_152_2 = var_152_0.childCount

				for iter_152_0 = 0, var_152_2 - 1 do
					local var_152_3 = var_152_0:GetChild(iter_152_0)

					if var_152_3.name == "split_4" or not string.find(var_152_3.name, "split") then
						var_152_3.gameObject:SetActive(true)
					else
						var_152_3.gameObject:SetActive(false)
					end
				end
			end

			local var_152_4 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_4 then
				local var_152_5 = (arg_149_1.time_ - var_152_1) / var_152_4
				local var_152_6 = Vector3.New(-390, -350, -180)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1056, var_152_6, var_152_5)
			end

			if arg_149_1.time_ >= var_152_1 + var_152_4 and arg_149_1.time_ < var_152_1 + var_152_4 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_152_7 = arg_149_1.actors_["1060"].transform
			local var_152_8 = 0

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.var_.moveOldPos1060 = var_152_7.localPosition
				var_152_7.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1060", 7)

				local var_152_9 = var_152_7.childCount

				for iter_152_1 = 0, var_152_9 - 1 do
					local var_152_10 = var_152_7:GetChild(iter_152_1)

					if var_152_10.name == "" or not string.find(var_152_10.name, "split") then
						var_152_10.gameObject:SetActive(true)
					else
						var_152_10.gameObject:SetActive(false)
					end
				end
			end

			local var_152_11 = 0.001

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_11 then
				local var_152_12 = (arg_149_1.time_ - var_152_8) / var_152_11
				local var_152_13 = Vector3.New(0, -2000, -40)

				var_152_7.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1060, var_152_13, var_152_12)
			end

			if arg_149_1.time_ >= var_152_8 + var_152_11 and arg_149_1.time_ < var_152_8 + var_152_11 + arg_152_0 then
				var_152_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_152_14 = arg_149_1.actors_["1056"]
			local var_152_15 = 0

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 and not isNil(var_152_14) and arg_149_1.var_.actorSpriteComps1056 == nil then
				arg_149_1.var_.actorSpriteComps1056 = var_152_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_16 = 0.034

			if var_152_15 <= arg_149_1.time_ and arg_149_1.time_ < var_152_15 + var_152_16 and not isNil(var_152_14) then
				local var_152_17 = (arg_149_1.time_ - var_152_15) / var_152_16

				if arg_149_1.var_.actorSpriteComps1056 then
					for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_152_3 then
							if arg_149_1.isInRecall_ then
								local var_152_18 = Mathf.Lerp(iter_152_3.color.r, arg_149_1.hightColor1.r, var_152_17)
								local var_152_19 = Mathf.Lerp(iter_152_3.color.g, arg_149_1.hightColor1.g, var_152_17)
								local var_152_20 = Mathf.Lerp(iter_152_3.color.b, arg_149_1.hightColor1.b, var_152_17)

								iter_152_3.color = Color.New(var_152_18, var_152_19, var_152_20)
							else
								local var_152_21 = Mathf.Lerp(iter_152_3.color.r, 1, var_152_17)

								iter_152_3.color = Color.New(var_152_21, var_152_21, var_152_21)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_15 + var_152_16 and arg_149_1.time_ < var_152_15 + var_152_16 + arg_152_0 and not isNil(var_152_14) and arg_149_1.var_.actorSpriteComps1056 then
				for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_152_5 then
						if arg_149_1.isInRecall_ then
							iter_152_5.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1056 = nil
			end

			local var_152_22 = arg_149_1.actors_["1060"]
			local var_152_23 = 0

			if var_152_23 < arg_149_1.time_ and arg_149_1.time_ <= var_152_23 + arg_152_0 and not isNil(var_152_22) and arg_149_1.var_.actorSpriteComps1060 == nil then
				arg_149_1.var_.actorSpriteComps1060 = var_152_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_24 = 0.034

			if var_152_23 <= arg_149_1.time_ and arg_149_1.time_ < var_152_23 + var_152_24 and not isNil(var_152_22) then
				local var_152_25 = (arg_149_1.time_ - var_152_23) / var_152_24

				if arg_149_1.var_.actorSpriteComps1060 then
					for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_152_7 then
							if arg_149_1.isInRecall_ then
								local var_152_26 = Mathf.Lerp(iter_152_7.color.r, arg_149_1.hightColor2.r, var_152_25)
								local var_152_27 = Mathf.Lerp(iter_152_7.color.g, arg_149_1.hightColor2.g, var_152_25)
								local var_152_28 = Mathf.Lerp(iter_152_7.color.b, arg_149_1.hightColor2.b, var_152_25)

								iter_152_7.color = Color.New(var_152_26, var_152_27, var_152_28)
							else
								local var_152_29 = Mathf.Lerp(iter_152_7.color.r, 0.5, var_152_25)

								iter_152_7.color = Color.New(var_152_29, var_152_29, var_152_29)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_23 + var_152_24 and arg_149_1.time_ < var_152_23 + var_152_24 + arg_152_0 and not isNil(var_152_22) and arg_149_1.var_.actorSpriteComps1060 then
				for iter_152_8, iter_152_9 in pairs(arg_149_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_152_9 then
						if arg_149_1.isInRecall_ then
							iter_152_9.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1060 = nil
			end

			local var_152_30 = 0
			local var_152_31 = 0.575

			if var_152_30 < arg_149_1.time_ and arg_149_1.time_ <= var_152_30 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_32 = arg_149_1:FormatText(StoryNameCfg[605].name)

				arg_149_1.leftNameTxt_.text = var_152_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_33 = arg_149_1:GetWordFromCfg(410042037)
				local var_152_34 = arg_149_1:FormatText(var_152_33.content)

				arg_149_1.text_.text = var_152_34

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_35 = 23
				local var_152_36 = utf8.len(var_152_34)
				local var_152_37 = var_152_35 <= 0 and var_152_31 or var_152_31 * (var_152_36 / var_152_35)

				if var_152_37 > 0 and var_152_31 < var_152_37 then
					arg_149_1.talkMaxDuration = var_152_37

					if var_152_37 + var_152_30 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_37 + var_152_30
					end
				end

				arg_149_1.text_.text = var_152_34
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042037", "story_v_out_410042.awb") ~= 0 then
					local var_152_38 = manager.audio:GetVoiceLength("story_v_out_410042", "410042037", "story_v_out_410042.awb") / 1000

					if var_152_38 + var_152_30 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_38 + var_152_30
					end

					if var_152_33.prefab_name ~= "" and arg_149_1.actors_[var_152_33.prefab_name] ~= nil then
						local var_152_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_33.prefab_name].transform, "story_v_out_410042", "410042037", "story_v_out_410042.awb")

						arg_149_1:RecordAudio("410042037", var_152_39)
						arg_149_1:RecordAudio("410042037", var_152_39)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_410042", "410042037", "story_v_out_410042.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_410042", "410042037", "story_v_out_410042.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_40 = math.max(var_152_31, arg_149_1.talkMaxDuration)

			if var_152_30 <= arg_149_1.time_ and arg_149_1.time_ < var_152_30 + var_152_40 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_30) / var_152_40

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_30 + var_152_40 and arg_149_1.time_ < var_152_30 + var_152_40 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play410042038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410042038
		arg_153_1.duration_ = 4.27

		local var_153_0 = {
			zh = 3,
			ja = 4.266
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
				arg_153_0:Play410042039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10063"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos10063 = var_156_0.localPosition
				var_156_0.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10063", 4)

				local var_156_2 = var_156_0.childCount

				for iter_156_0 = 0, var_156_2 - 1 do
					local var_156_3 = var_156_0:GetChild(iter_156_0)

					if var_156_3.name == "split_4" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_4 then
				local var_156_5 = (arg_153_1.time_ - var_156_1) / var_156_4
				local var_156_6 = Vector3.New(390, -535, -105)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10063, var_156_6, var_156_5)
			end

			if arg_153_1.time_ >= var_156_1 + var_156_4 and arg_153_1.time_ < var_156_1 + var_156_4 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(390, -535, -105)
			end

			local var_156_7 = arg_153_1.actors_["10063"]
			local var_156_8 = 0

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.actorSpriteComps10063 == nil then
				arg_153_1.var_.actorSpriteComps10063 = var_156_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_9 = 0.034

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_9 and not isNil(var_156_7) then
				local var_156_10 = (arg_153_1.time_ - var_156_8) / var_156_9

				if arg_153_1.var_.actorSpriteComps10063 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								local var_156_11 = Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor1.r, var_156_10)
								local var_156_12 = Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor1.g, var_156_10)
								local var_156_13 = Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor1.b, var_156_10)

								iter_156_2.color = Color.New(var_156_11, var_156_12, var_156_13)
							else
								local var_156_14 = Mathf.Lerp(iter_156_2.color.r, 1, var_156_10)

								iter_156_2.color = Color.New(var_156_14, var_156_14, var_156_14)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_8 + var_156_9 and arg_153_1.time_ < var_156_8 + var_156_9 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.actorSpriteComps10063 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_156_4 then
						if arg_153_1.isInRecall_ then
							iter_156_4.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10063 = nil
			end

			local var_156_15 = arg_153_1.actors_["1056"]
			local var_156_16 = 0

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.actorSpriteComps1056 == nil then
				arg_153_1.var_.actorSpriteComps1056 = var_156_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_17 = 0.034

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_17 and not isNil(var_156_15) then
				local var_156_18 = (arg_153_1.time_ - var_156_16) / var_156_17

				if arg_153_1.var_.actorSpriteComps1056 then
					for iter_156_5, iter_156_6 in pairs(arg_153_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_156_6 then
							if arg_153_1.isInRecall_ then
								local var_156_19 = Mathf.Lerp(iter_156_6.color.r, arg_153_1.hightColor2.r, var_156_18)
								local var_156_20 = Mathf.Lerp(iter_156_6.color.g, arg_153_1.hightColor2.g, var_156_18)
								local var_156_21 = Mathf.Lerp(iter_156_6.color.b, arg_153_1.hightColor2.b, var_156_18)

								iter_156_6.color = Color.New(var_156_19, var_156_20, var_156_21)
							else
								local var_156_22 = Mathf.Lerp(iter_156_6.color.r, 0.5, var_156_18)

								iter_156_6.color = Color.New(var_156_22, var_156_22, var_156_22)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.actorSpriteComps1056 then
				for iter_156_7, iter_156_8 in pairs(arg_153_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_156_8 then
						if arg_153_1.isInRecall_ then
							iter_156_8.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1056 = nil
			end

			local var_156_23 = 0
			local var_156_24 = 0.225

			if var_156_23 < arg_153_1.time_ and arg_153_1.time_ <= var_156_23 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_25 = arg_153_1:FormatText(StoryNameCfg[591].name)

				arg_153_1.leftNameTxt_.text = var_156_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_26 = arg_153_1:GetWordFromCfg(410042038)
				local var_156_27 = arg_153_1:FormatText(var_156_26.content)

				arg_153_1.text_.text = var_156_27

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_28 = 9
				local var_156_29 = utf8.len(var_156_27)
				local var_156_30 = var_156_28 <= 0 and var_156_24 or var_156_24 * (var_156_29 / var_156_28)

				if var_156_30 > 0 and var_156_24 < var_156_30 then
					arg_153_1.talkMaxDuration = var_156_30

					if var_156_30 + var_156_23 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_30 + var_156_23
					end
				end

				arg_153_1.text_.text = var_156_27
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042038", "story_v_out_410042.awb") ~= 0 then
					local var_156_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042038", "story_v_out_410042.awb") / 1000

					if var_156_31 + var_156_23 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_31 + var_156_23
					end

					if var_156_26.prefab_name ~= "" and arg_153_1.actors_[var_156_26.prefab_name] ~= nil then
						local var_156_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_26.prefab_name].transform, "story_v_out_410042", "410042038", "story_v_out_410042.awb")

						arg_153_1:RecordAudio("410042038", var_156_32)
						arg_153_1:RecordAudio("410042038", var_156_32)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410042", "410042038", "story_v_out_410042.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410042", "410042038", "story_v_out_410042.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_33 = math.max(var_156_24, arg_153_1.talkMaxDuration)

			if var_156_23 <= arg_153_1.time_ and arg_153_1.time_ < var_156_23 + var_156_33 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_23) / var_156_33

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_23 + var_156_33 and arg_153_1.time_ < var_156_23 + var_156_33 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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
	Play410042039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410042039
		arg_157_1.duration_ = 12.77

		local var_157_0 = {
			zh = 8.266,
			ja = 12.766
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
				arg_157_0:Play410042040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1056"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1056 = var_160_0.localPosition
				var_160_0.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1056", 2)

				local var_160_2 = var_160_0.childCount

				for iter_160_0 = 0, var_160_2 - 1 do
					local var_160_3 = var_160_0:GetChild(iter_160_0)

					if var_160_3.name == "split_4" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_4 then
				local var_160_5 = (arg_157_1.time_ - var_160_1) / var_160_4
				local var_160_6 = Vector3.New(-390, -350, -180)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1056, var_160_6, var_160_5)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_4 and arg_157_1.time_ < var_160_1 + var_160_4 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_160_7 = arg_157_1.actors_["1056"]
			local var_160_8 = 0

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps1056 == nil then
				arg_157_1.var_.actorSpriteComps1056 = var_160_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 0.034

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 and not isNil(var_160_7) then
				local var_160_10 = (arg_157_1.time_ - var_160_8) / var_160_9

				if arg_157_1.var_.actorSpriteComps1056 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps1056 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_160_4 then
						if arg_157_1.isInRecall_ then
							iter_160_4.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1056 = nil
			end

			local var_160_15 = arg_157_1.actors_["10063"]
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps10063 == nil then
				arg_157_1.var_.actorSpriteComps10063 = var_160_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_17 = 0.034

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 and not isNil(var_160_15) then
				local var_160_18 = (arg_157_1.time_ - var_160_16) / var_160_17

				if arg_157_1.var_.actorSpriteComps10063 then
					for iter_160_5, iter_160_6 in pairs(arg_157_1.var_.actorSpriteComps10063:ToTable()) do
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

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps10063 then
				for iter_160_7, iter_160_8 in pairs(arg_157_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_160_8 then
						if arg_157_1.isInRecall_ then
							iter_160_8.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10063 = nil
			end

			local var_160_23 = 0
			local var_160_24 = 1.05

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_25 = arg_157_1:FormatText(StoryNameCfg[605].name)

				arg_157_1.leftNameTxt_.text = var_160_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_26 = arg_157_1:GetWordFromCfg(410042039)
				local var_160_27 = arg_157_1:FormatText(var_160_26.content)

				arg_157_1.text_.text = var_160_27

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_28 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042039", "story_v_out_410042.awb") ~= 0 then
					local var_160_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042039", "story_v_out_410042.awb") / 1000

					if var_160_31 + var_160_23 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_31 + var_160_23
					end

					if var_160_26.prefab_name ~= "" and arg_157_1.actors_[var_160_26.prefab_name] ~= nil then
						local var_160_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_26.prefab_name].transform, "story_v_out_410042", "410042039", "story_v_out_410042.awb")

						arg_157_1:RecordAudio("410042039", var_160_32)
						arg_157_1:RecordAudio("410042039", var_160_32)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410042", "410042039", "story_v_out_410042.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410042", "410042039", "story_v_out_410042.awb")
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
				actorName = "1056",
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
	Play410042040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410042040
		arg_161_1.duration_ = 5.07

		local var_161_0 = {
			zh = 4,
			ja = 5.066
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play410042041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1056"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1056 = var_164_0.localPosition
				var_164_0.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1056", 2)

				local var_164_2 = var_164_0.childCount

				for iter_164_0 = 0, var_164_2 - 1 do
					local var_164_3 = var_164_0:GetChild(iter_164_0)

					if var_164_3.name == "split_4" or not string.find(var_164_3.name, "split") then
						var_164_3.gameObject:SetActive(true)
					else
						var_164_3.gameObject:SetActive(false)
					end
				end
			end

			local var_164_4 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_4 then
				local var_164_5 = (arg_161_1.time_ - var_164_1) / var_164_4
				local var_164_6 = Vector3.New(-390, -350, -180)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1056, var_164_6, var_164_5)
			end

			if arg_161_1.time_ >= var_164_1 + var_164_4 and arg_161_1.time_ < var_164_1 + var_164_4 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_164_7 = arg_161_1.actors_["1056"]
			local var_164_8 = 0

			if var_164_8 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.actorSpriteComps1056 == nil then
				arg_161_1.var_.actorSpriteComps1056 = var_164_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_9 = 0.034

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_9 and not isNil(var_164_7) then
				local var_164_10 = (arg_161_1.time_ - var_164_8) / var_164_9

				if arg_161_1.var_.actorSpriteComps1056 then
					for iter_164_1, iter_164_2 in pairs(arg_161_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_164_2 then
							if arg_161_1.isInRecall_ then
								local var_164_11 = Mathf.Lerp(iter_164_2.color.r, arg_161_1.hightColor1.r, var_164_10)
								local var_164_12 = Mathf.Lerp(iter_164_2.color.g, arg_161_1.hightColor1.g, var_164_10)
								local var_164_13 = Mathf.Lerp(iter_164_2.color.b, arg_161_1.hightColor1.b, var_164_10)

								iter_164_2.color = Color.New(var_164_11, var_164_12, var_164_13)
							else
								local var_164_14 = Mathf.Lerp(iter_164_2.color.r, 1, var_164_10)

								iter_164_2.color = Color.New(var_164_14, var_164_14, var_164_14)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_8 + var_164_9 and arg_161_1.time_ < var_164_8 + var_164_9 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.actorSpriteComps1056 then
				for iter_164_3, iter_164_4 in pairs(arg_161_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_164_4 then
						if arg_161_1.isInRecall_ then
							iter_164_4.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps1056 = nil
			end

			local var_164_15 = 0
			local var_164_16 = 0.55

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_17 = arg_161_1:FormatText(StoryNameCfg[605].name)

				arg_161_1.leftNameTxt_.text = var_164_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_18 = arg_161_1:GetWordFromCfg(410042040)
				local var_164_19 = arg_161_1:FormatText(var_164_18.content)

				arg_161_1.text_.text = var_164_19

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_20 = 22
				local var_164_21 = utf8.len(var_164_19)
				local var_164_22 = var_164_20 <= 0 and var_164_16 or var_164_16 * (var_164_21 / var_164_20)

				if var_164_22 > 0 and var_164_16 < var_164_22 then
					arg_161_1.talkMaxDuration = var_164_22

					if var_164_22 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_22 + var_164_15
					end
				end

				arg_161_1.text_.text = var_164_19
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042040", "story_v_out_410042.awb") ~= 0 then
					local var_164_23 = manager.audio:GetVoiceLength("story_v_out_410042", "410042040", "story_v_out_410042.awb") / 1000

					if var_164_23 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_23 + var_164_15
					end

					if var_164_18.prefab_name ~= "" and arg_161_1.actors_[var_164_18.prefab_name] ~= nil then
						local var_164_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_18.prefab_name].transform, "story_v_out_410042", "410042040", "story_v_out_410042.awb")

						arg_161_1:RecordAudio("410042040", var_164_24)
						arg_161_1:RecordAudio("410042040", var_164_24)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410042", "410042040", "story_v_out_410042.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410042", "410042040", "story_v_out_410042.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_25 = math.max(var_164_16, arg_161_1.talkMaxDuration)

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_25 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_15) / var_164_25

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_15 + var_164_25 and arg_161_1.time_ < var_164_15 + var_164_25 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play410042041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410042041
		arg_165_1.duration_ = 10.9

		local var_165_0 = {
			zh = 10.9,
			ja = 8.1
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
				arg_165_0:Play410042042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10063"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos10063 = var_168_0.localPosition
				var_168_0.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10063", 4)

				local var_168_2 = var_168_0.childCount

				for iter_168_0 = 0, var_168_2 - 1 do
					local var_168_3 = var_168_0:GetChild(iter_168_0)

					if var_168_3.name == "split_4" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_4 then
				local var_168_5 = (arg_165_1.time_ - var_168_1) / var_168_4
				local var_168_6 = Vector3.New(390, -535, -105)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10063, var_168_6, var_168_5)
			end

			if arg_165_1.time_ >= var_168_1 + var_168_4 and arg_165_1.time_ < var_168_1 + var_168_4 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(390, -535, -105)
			end

			local var_168_7 = arg_165_1.actors_["10063"]
			local var_168_8 = 0

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps10063 == nil then
				arg_165_1.var_.actorSpriteComps10063 = var_168_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_9 = 0.034

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_9 and not isNil(var_168_7) then
				local var_168_10 = (arg_165_1.time_ - var_168_8) / var_168_9

				if arg_165_1.var_.actorSpriteComps10063 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps10063:ToTable()) do
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

			if arg_165_1.time_ >= var_168_8 + var_168_9 and arg_165_1.time_ < var_168_8 + var_168_9 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps10063 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_168_4 then
						if arg_165_1.isInRecall_ then
							iter_168_4.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10063 = nil
			end

			local var_168_15 = arg_165_1.actors_["1056"]
			local var_168_16 = 0

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 and not isNil(var_168_15) and arg_165_1.var_.actorSpriteComps1056 == nil then
				arg_165_1.var_.actorSpriteComps1056 = var_168_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_17 = 0.034

			if var_168_16 <= arg_165_1.time_ and arg_165_1.time_ < var_168_16 + var_168_17 and not isNil(var_168_15) then
				local var_168_18 = (arg_165_1.time_ - var_168_16) / var_168_17

				if arg_165_1.var_.actorSpriteComps1056 then
					for iter_168_5, iter_168_6 in pairs(arg_165_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_168_6 then
							if arg_165_1.isInRecall_ then
								local var_168_19 = Mathf.Lerp(iter_168_6.color.r, arg_165_1.hightColor2.r, var_168_18)
								local var_168_20 = Mathf.Lerp(iter_168_6.color.g, arg_165_1.hightColor2.g, var_168_18)
								local var_168_21 = Mathf.Lerp(iter_168_6.color.b, arg_165_1.hightColor2.b, var_168_18)

								iter_168_6.color = Color.New(var_168_19, var_168_20, var_168_21)
							else
								local var_168_22 = Mathf.Lerp(iter_168_6.color.r, 0.5, var_168_18)

								iter_168_6.color = Color.New(var_168_22, var_168_22, var_168_22)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 and not isNil(var_168_15) and arg_165_1.var_.actorSpriteComps1056 then
				for iter_168_7, iter_168_8 in pairs(arg_165_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_168_8 then
						if arg_165_1.isInRecall_ then
							iter_168_8.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1056 = nil
			end

			local var_168_23 = 0
			local var_168_24 = 0.85

			if var_168_23 < arg_165_1.time_ and arg_165_1.time_ <= var_168_23 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_25 = arg_165_1:FormatText(StoryNameCfg[591].name)

				arg_165_1.leftNameTxt_.text = var_168_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_26 = arg_165_1:GetWordFromCfg(410042041)
				local var_168_27 = arg_165_1:FormatText(var_168_26.content)

				arg_165_1.text_.text = var_168_27

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_28 = 34
				local var_168_29 = utf8.len(var_168_27)
				local var_168_30 = var_168_28 <= 0 and var_168_24 or var_168_24 * (var_168_29 / var_168_28)

				if var_168_30 > 0 and var_168_24 < var_168_30 then
					arg_165_1.talkMaxDuration = var_168_30

					if var_168_30 + var_168_23 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_30 + var_168_23
					end
				end

				arg_165_1.text_.text = var_168_27
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042041", "story_v_out_410042.awb") ~= 0 then
					local var_168_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042041", "story_v_out_410042.awb") / 1000

					if var_168_31 + var_168_23 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_31 + var_168_23
					end

					if var_168_26.prefab_name ~= "" and arg_165_1.actors_[var_168_26.prefab_name] ~= nil then
						local var_168_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_26.prefab_name].transform, "story_v_out_410042", "410042041", "story_v_out_410042.awb")

						arg_165_1:RecordAudio("410042041", var_168_32)
						arg_165_1:RecordAudio("410042041", var_168_32)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_410042", "410042041", "story_v_out_410042.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_410042", "410042041", "story_v_out_410042.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_33 = math.max(var_168_24, arg_165_1.talkMaxDuration)

			if var_168_23 <= arg_165_1.time_ and arg_165_1.time_ < var_168_23 + var_168_33 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_23) / var_168_33

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_23 + var_168_33 and arg_165_1.time_ < var_168_23 + var_168_33 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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
	Play410042042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410042042
		arg_169_1.duration_ = 6.3

		local var_169_0 = {
			zh = 4.866,
			ja = 6.3
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
				arg_169_0:Play410042043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1056"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1056 = var_172_0.localPosition
				var_172_0.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("1056", 2)

				local var_172_2 = var_172_0.childCount

				for iter_172_0 = 0, var_172_2 - 1 do
					local var_172_3 = var_172_0:GetChild(iter_172_0)

					if var_172_3.name == "split_4" or not string.find(var_172_3.name, "split") then
						var_172_3.gameObject:SetActive(true)
					else
						var_172_3.gameObject:SetActive(false)
					end
				end
			end

			local var_172_4 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_4 then
				local var_172_5 = (arg_169_1.time_ - var_172_1) / var_172_4
				local var_172_6 = Vector3.New(-390, -350, -180)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1056, var_172_6, var_172_5)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_4 and arg_169_1.time_ < var_172_1 + var_172_4 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_172_7 = arg_169_1.actors_["1056"]
			local var_172_8 = 0

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps1056 == nil then
				arg_169_1.var_.actorSpriteComps1056 = var_172_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_9 = 0.034

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_9 and not isNil(var_172_7) then
				local var_172_10 = (arg_169_1.time_ - var_172_8) / var_172_9

				if arg_169_1.var_.actorSpriteComps1056 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_172_2 then
							if arg_169_1.isInRecall_ then
								local var_172_11 = Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor1.r, var_172_10)
								local var_172_12 = Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor1.g, var_172_10)
								local var_172_13 = Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor1.b, var_172_10)

								iter_172_2.color = Color.New(var_172_11, var_172_12, var_172_13)
							else
								local var_172_14 = Mathf.Lerp(iter_172_2.color.r, 1, var_172_10)

								iter_172_2.color = Color.New(var_172_14, var_172_14, var_172_14)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_8 + var_172_9 and arg_169_1.time_ < var_172_8 + var_172_9 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps1056 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_172_4 then
						if arg_169_1.isInRecall_ then
							iter_172_4.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps1056 = nil
			end

			local var_172_15 = arg_169_1.actors_["10063"]
			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.actorSpriteComps10063 == nil then
				arg_169_1.var_.actorSpriteComps10063 = var_172_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_17 = 0.034

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 and not isNil(var_172_15) then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17

				if arg_169_1.var_.actorSpriteComps10063 then
					for iter_172_5, iter_172_6 in pairs(arg_169_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_172_6 then
							if arg_169_1.isInRecall_ then
								local var_172_19 = Mathf.Lerp(iter_172_6.color.r, arg_169_1.hightColor2.r, var_172_18)
								local var_172_20 = Mathf.Lerp(iter_172_6.color.g, arg_169_1.hightColor2.g, var_172_18)
								local var_172_21 = Mathf.Lerp(iter_172_6.color.b, arg_169_1.hightColor2.b, var_172_18)

								iter_172_6.color = Color.New(var_172_19, var_172_20, var_172_21)
							else
								local var_172_22 = Mathf.Lerp(iter_172_6.color.r, 0.5, var_172_18)

								iter_172_6.color = Color.New(var_172_22, var_172_22, var_172_22)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.actorSpriteComps10063 then
				for iter_172_7, iter_172_8 in pairs(arg_169_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_172_8 then
						if arg_169_1.isInRecall_ then
							iter_172_8.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10063 = nil
			end

			local var_172_23 = 0
			local var_172_24 = 0.575

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_25 = arg_169_1:FormatText(StoryNameCfg[605].name)

				arg_169_1.leftNameTxt_.text = var_172_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_26 = arg_169_1:GetWordFromCfg(410042042)
				local var_172_27 = arg_169_1:FormatText(var_172_26.content)

				arg_169_1.text_.text = var_172_27

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_28 = 23
				local var_172_29 = utf8.len(var_172_27)
				local var_172_30 = var_172_28 <= 0 and var_172_24 or var_172_24 * (var_172_29 / var_172_28)

				if var_172_30 > 0 and var_172_24 < var_172_30 then
					arg_169_1.talkMaxDuration = var_172_30

					if var_172_30 + var_172_23 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_30 + var_172_23
					end
				end

				arg_169_1.text_.text = var_172_27
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042042", "story_v_out_410042.awb") ~= 0 then
					local var_172_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042042", "story_v_out_410042.awb") / 1000

					if var_172_31 + var_172_23 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_31 + var_172_23
					end

					if var_172_26.prefab_name ~= "" and arg_169_1.actors_[var_172_26.prefab_name] ~= nil then
						local var_172_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_26.prefab_name].transform, "story_v_out_410042", "410042042", "story_v_out_410042.awb")

						arg_169_1:RecordAudio("410042042", var_172_32)
						arg_169_1:RecordAudio("410042042", var_172_32)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_410042", "410042042", "story_v_out_410042.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_410042", "410042042", "story_v_out_410042.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_33 = math.max(var_172_24, arg_169_1.talkMaxDuration)

			if var_172_23 <= arg_169_1.time_ and arg_169_1.time_ < var_172_23 + var_172_33 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_23) / var_172_33

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_23 + var_172_33 and arg_169_1.time_ < var_172_23 + var_172_33 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play410042043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410042043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play410042044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1056"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1056 = var_176_0.localPosition
				var_176_0.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("1056", 7)

				local var_176_2 = var_176_0.childCount

				for iter_176_0 = 0, var_176_2 - 1 do
					local var_176_3 = var_176_0:GetChild(iter_176_0)

					if var_176_3.name == "" or not string.find(var_176_3.name, "split") then
						var_176_3.gameObject:SetActive(true)
					else
						var_176_3.gameObject:SetActive(false)
					end
				end
			end

			local var_176_4 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_4 then
				local var_176_5 = (arg_173_1.time_ - var_176_1) / var_176_4
				local var_176_6 = Vector3.New(0, -2000, -180)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1056, var_176_6, var_176_5)
			end

			if arg_173_1.time_ >= var_176_1 + var_176_4 and arg_173_1.time_ < var_176_1 + var_176_4 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_176_7 = arg_173_1.actors_["10063"].transform
			local var_176_8 = 0

			if var_176_8 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.var_.moveOldPos10063 = var_176_7.localPosition
				var_176_7.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10063", 7)

				local var_176_9 = var_176_7.childCount

				for iter_176_1 = 0, var_176_9 - 1 do
					local var_176_10 = var_176_7:GetChild(iter_176_1)

					if var_176_10.name == "" or not string.find(var_176_10.name, "split") then
						var_176_10.gameObject:SetActive(true)
					else
						var_176_10.gameObject:SetActive(false)
					end
				end
			end

			local var_176_11 = 0.001

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_11 then
				local var_176_12 = (arg_173_1.time_ - var_176_8) / var_176_11
				local var_176_13 = Vector3.New(0, -2000, -105)

				var_176_7.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10063, var_176_13, var_176_12)
			end

			if arg_173_1.time_ >= var_176_8 + var_176_11 and arg_173_1.time_ < var_176_8 + var_176_11 + arg_176_0 then
				var_176_7.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_176_14 = arg_173_1.actors_["10060"].transform
			local var_176_15 = 0

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.var_.moveOldPos10060 = var_176_14.localPosition
				var_176_14.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10060", 3)

				local var_176_16 = var_176_14.childCount

				for iter_176_2 = 0, var_176_16 - 1 do
					local var_176_17 = var_176_14:GetChild(iter_176_2)

					if var_176_17.name == "" or not string.find(var_176_17.name, "split") then
						var_176_17.gameObject:SetActive(true)
					else
						var_176_17.gameObject:SetActive(false)
					end
				end
			end

			local var_176_18 = 0.001

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_18 then
				local var_176_19 = (arg_173_1.time_ - var_176_15) / var_176_18
				local var_176_20 = Vector3.New(0, -400, 0)

				var_176_14.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10060, var_176_20, var_176_19)
			end

			if arg_173_1.time_ >= var_176_15 + var_176_18 and arg_173_1.time_ < var_176_15 + var_176_18 + arg_176_0 then
				var_176_14.localPosition = Vector3.New(0, -400, 0)
			end

			local var_176_21 = arg_173_1.actors_["1056"]
			local var_176_22 = 0

			if var_176_22 < arg_173_1.time_ and arg_173_1.time_ <= var_176_22 + arg_176_0 and not isNil(var_176_21) and arg_173_1.var_.actorSpriteComps1056 == nil then
				arg_173_1.var_.actorSpriteComps1056 = var_176_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_23 = 0.034

			if var_176_22 <= arg_173_1.time_ and arg_173_1.time_ < var_176_22 + var_176_23 and not isNil(var_176_21) then
				local var_176_24 = (arg_173_1.time_ - var_176_22) / var_176_23

				if arg_173_1.var_.actorSpriteComps1056 then
					for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_176_4 then
							if arg_173_1.isInRecall_ then
								local var_176_25 = Mathf.Lerp(iter_176_4.color.r, arg_173_1.hightColor2.r, var_176_24)
								local var_176_26 = Mathf.Lerp(iter_176_4.color.g, arg_173_1.hightColor2.g, var_176_24)
								local var_176_27 = Mathf.Lerp(iter_176_4.color.b, arg_173_1.hightColor2.b, var_176_24)

								iter_176_4.color = Color.New(var_176_25, var_176_26, var_176_27)
							else
								local var_176_28 = Mathf.Lerp(iter_176_4.color.r, 0.5, var_176_24)

								iter_176_4.color = Color.New(var_176_28, var_176_28, var_176_28)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_22 + var_176_23 and arg_173_1.time_ < var_176_22 + var_176_23 + arg_176_0 and not isNil(var_176_21) and arg_173_1.var_.actorSpriteComps1056 then
				for iter_176_5, iter_176_6 in pairs(arg_173_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_176_6 then
						if arg_173_1.isInRecall_ then
							iter_176_6.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps1056 = nil
			end

			local var_176_29 = arg_173_1.actors_["10063"]
			local var_176_30 = 0

			if var_176_30 < arg_173_1.time_ and arg_173_1.time_ <= var_176_30 + arg_176_0 and not isNil(var_176_29) and arg_173_1.var_.actorSpriteComps10063 == nil then
				arg_173_1.var_.actorSpriteComps10063 = var_176_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_31 = 0.034

			if var_176_30 <= arg_173_1.time_ and arg_173_1.time_ < var_176_30 + var_176_31 and not isNil(var_176_29) then
				local var_176_32 = (arg_173_1.time_ - var_176_30) / var_176_31

				if arg_173_1.var_.actorSpriteComps10063 then
					for iter_176_7, iter_176_8 in pairs(arg_173_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_176_8 then
							if arg_173_1.isInRecall_ then
								local var_176_33 = Mathf.Lerp(iter_176_8.color.r, arg_173_1.hightColor2.r, var_176_32)
								local var_176_34 = Mathf.Lerp(iter_176_8.color.g, arg_173_1.hightColor2.g, var_176_32)
								local var_176_35 = Mathf.Lerp(iter_176_8.color.b, arg_173_1.hightColor2.b, var_176_32)

								iter_176_8.color = Color.New(var_176_33, var_176_34, var_176_35)
							else
								local var_176_36 = Mathf.Lerp(iter_176_8.color.r, 0.5, var_176_32)

								iter_176_8.color = Color.New(var_176_36, var_176_36, var_176_36)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_30 + var_176_31 and arg_173_1.time_ < var_176_30 + var_176_31 + arg_176_0 and not isNil(var_176_29) and arg_173_1.var_.actorSpriteComps10063 then
				for iter_176_9, iter_176_10 in pairs(arg_173_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_176_10 then
						if arg_173_1.isInRecall_ then
							iter_176_10.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10063 = nil
			end

			local var_176_37 = arg_173_1.actors_["10060"]
			local var_176_38 = 0

			if var_176_38 < arg_173_1.time_ and arg_173_1.time_ <= var_176_38 + arg_176_0 and not isNil(var_176_37) and arg_173_1.var_.actorSpriteComps10060 == nil then
				arg_173_1.var_.actorSpriteComps10060 = var_176_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_39 = 0.034

			if var_176_38 <= arg_173_1.time_ and arg_173_1.time_ < var_176_38 + var_176_39 and not isNil(var_176_37) then
				local var_176_40 = (arg_173_1.time_ - var_176_38) / var_176_39

				if arg_173_1.var_.actorSpriteComps10060 then
					for iter_176_11, iter_176_12 in pairs(arg_173_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_176_12 then
							if arg_173_1.isInRecall_ then
								local var_176_41 = Mathf.Lerp(iter_176_12.color.r, arg_173_1.hightColor2.r, var_176_40)
								local var_176_42 = Mathf.Lerp(iter_176_12.color.g, arg_173_1.hightColor2.g, var_176_40)
								local var_176_43 = Mathf.Lerp(iter_176_12.color.b, arg_173_1.hightColor2.b, var_176_40)

								iter_176_12.color = Color.New(var_176_41, var_176_42, var_176_43)
							else
								local var_176_44 = Mathf.Lerp(iter_176_12.color.r, 0.5, var_176_40)

								iter_176_12.color = Color.New(var_176_44, var_176_44, var_176_44)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_38 + var_176_39 and arg_173_1.time_ < var_176_38 + var_176_39 + arg_176_0 and not isNil(var_176_37) and arg_173_1.var_.actorSpriteComps10060 then
				for iter_176_13, iter_176_14 in pairs(arg_173_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_176_14 then
						if arg_173_1.isInRecall_ then
							iter_176_14.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_14.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10060 = nil
			end

			local var_176_45 = 0
			local var_176_46 = 1.05

			if var_176_45 < arg_173_1.time_ and arg_173_1.time_ <= var_176_45 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_47 = arg_173_1:GetWordFromCfg(410042043)
				local var_176_48 = arg_173_1:FormatText(var_176_47.content)

				arg_173_1.text_.text = var_176_48

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_49 = 42
				local var_176_50 = utf8.len(var_176_48)
				local var_176_51 = var_176_49 <= 0 and var_176_46 or var_176_46 * (var_176_50 / var_176_49)

				if var_176_51 > 0 and var_176_46 < var_176_51 then
					arg_173_1.talkMaxDuration = var_176_51

					if var_176_51 + var_176_45 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_51 + var_176_45
					end
				end

				arg_173_1.text_.text = var_176_48
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_52 = math.max(var_176_46, arg_173_1.talkMaxDuration)

			if var_176_45 <= arg_173_1.time_ and arg_173_1.time_ < var_176_45 + var_176_52 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_45) / var_176_52

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_45 + var_176_52 and arg_173_1.time_ < var_176_45 + var_176_52 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10063",
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

		arg_173_1:InitPlayNodeList()
	end,
	Play410042044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410042044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play410042045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 1.15

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_2 = arg_177_1:GetWordFromCfg(410042044)
				local var_180_3 = arg_177_1:FormatText(var_180_2.content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 46
				local var_180_5 = utf8.len(var_180_3)
				local var_180_6 = var_180_4 <= 0 and var_180_1 or var_180_1 * (var_180_5 / var_180_4)

				if var_180_6 > 0 and var_180_1 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_7 and arg_177_1.time_ < var_180_0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play410042045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410042045
		arg_181_1.duration_ = 3.53

		local var_181_0 = {
			zh = 1.033,
			ja = 3.533
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
				arg_181_0:Play410042046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1056"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1056 = var_184_0.localPosition
				var_184_0.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1056", 2)

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
				local var_184_6 = Vector3.New(-390, -350, -180)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1056, var_184_6, var_184_5)
			end

			if arg_181_1.time_ >= var_184_1 + var_184_4 and arg_181_1.time_ < var_184_1 + var_184_4 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_184_7 = arg_181_1.actors_["10060"].transform
			local var_184_8 = 0

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.var_.moveOldPos10060 = var_184_7.localPosition
				var_184_7.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10060", 4)

				local var_184_9 = var_184_7.childCount

				for iter_184_1 = 0, var_184_9 - 1 do
					local var_184_10 = var_184_7:GetChild(iter_184_1)

					if var_184_10.name == "split_4" or not string.find(var_184_10.name, "split") then
						var_184_10.gameObject:SetActive(true)
					else
						var_184_10.gameObject:SetActive(false)
					end
				end
			end

			local var_184_11 = 0.001

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_11 then
				local var_184_12 = (arg_181_1.time_ - var_184_8) / var_184_11
				local var_184_13 = Vector3.New(390, -400, 0)

				var_184_7.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10060, var_184_13, var_184_12)
			end

			if arg_181_1.time_ >= var_184_8 + var_184_11 and arg_181_1.time_ < var_184_8 + var_184_11 + arg_184_0 then
				var_184_7.localPosition = Vector3.New(390, -400, 0)
			end

			local var_184_14 = arg_181_1.actors_["1056"]
			local var_184_15 = 0

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 and not isNil(var_184_14) and arg_181_1.var_.actorSpriteComps1056 == nil then
				arg_181_1.var_.actorSpriteComps1056 = var_184_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_16 = 0.034

			if var_184_15 <= arg_181_1.time_ and arg_181_1.time_ < var_184_15 + var_184_16 and not isNil(var_184_14) then
				local var_184_17 = (arg_181_1.time_ - var_184_15) / var_184_16

				if arg_181_1.var_.actorSpriteComps1056 then
					for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_184_3 then
							if arg_181_1.isInRecall_ then
								local var_184_18 = Mathf.Lerp(iter_184_3.color.r, arg_181_1.hightColor2.r, var_184_17)
								local var_184_19 = Mathf.Lerp(iter_184_3.color.g, arg_181_1.hightColor2.g, var_184_17)
								local var_184_20 = Mathf.Lerp(iter_184_3.color.b, arg_181_1.hightColor2.b, var_184_17)

								iter_184_3.color = Color.New(var_184_18, var_184_19, var_184_20)
							else
								local var_184_21 = Mathf.Lerp(iter_184_3.color.r, 0.5, var_184_17)

								iter_184_3.color = Color.New(var_184_21, var_184_21, var_184_21)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_15 + var_184_16 and arg_181_1.time_ < var_184_15 + var_184_16 + arg_184_0 and not isNil(var_184_14) and arg_181_1.var_.actorSpriteComps1056 then
				for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_184_5 then
						if arg_181_1.isInRecall_ then
							iter_184_5.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1056 = nil
			end

			local var_184_22 = arg_181_1.actors_["10060"]
			local var_184_23 = 0

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.actorSpriteComps10060 == nil then
				arg_181_1.var_.actorSpriteComps10060 = var_184_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_24 = 0.034

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_24 and not isNil(var_184_22) then
				local var_184_25 = (arg_181_1.time_ - var_184_23) / var_184_24

				if arg_181_1.var_.actorSpriteComps10060 then
					for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_184_7 then
							if arg_181_1.isInRecall_ then
								local var_184_26 = Mathf.Lerp(iter_184_7.color.r, arg_181_1.hightColor1.r, var_184_25)
								local var_184_27 = Mathf.Lerp(iter_184_7.color.g, arg_181_1.hightColor1.g, var_184_25)
								local var_184_28 = Mathf.Lerp(iter_184_7.color.b, arg_181_1.hightColor1.b, var_184_25)

								iter_184_7.color = Color.New(var_184_26, var_184_27, var_184_28)
							else
								local var_184_29 = Mathf.Lerp(iter_184_7.color.r, 1, var_184_25)

								iter_184_7.color = Color.New(var_184_29, var_184_29, var_184_29)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_23 + var_184_24 and arg_181_1.time_ < var_184_23 + var_184_24 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.actorSpriteComps10060 then
				for iter_184_8, iter_184_9 in pairs(arg_181_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_184_9 then
						if arg_181_1.isInRecall_ then
							iter_184_9.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10060 = nil
			end

			local var_184_30 = 0
			local var_184_31 = 0.1

			if var_184_30 < arg_181_1.time_ and arg_181_1.time_ <= var_184_30 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_32 = arg_181_1:FormatText(StoryNameCfg[597].name)

				arg_181_1.leftNameTxt_.text = var_184_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_33 = arg_181_1:GetWordFromCfg(410042045)
				local var_184_34 = arg_181_1:FormatText(var_184_33.content)

				arg_181_1.text_.text = var_184_34

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_35 = 4
				local var_184_36 = utf8.len(var_184_34)
				local var_184_37 = var_184_35 <= 0 and var_184_31 or var_184_31 * (var_184_36 / var_184_35)

				if var_184_37 > 0 and var_184_31 < var_184_37 then
					arg_181_1.talkMaxDuration = var_184_37

					if var_184_37 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_37 + var_184_30
					end
				end

				arg_181_1.text_.text = var_184_34
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042045", "story_v_out_410042.awb") ~= 0 then
					local var_184_38 = manager.audio:GetVoiceLength("story_v_out_410042", "410042045", "story_v_out_410042.awb") / 1000

					if var_184_38 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_38 + var_184_30
					end

					if var_184_33.prefab_name ~= "" and arg_181_1.actors_[var_184_33.prefab_name] ~= nil then
						local var_184_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_33.prefab_name].transform, "story_v_out_410042", "410042045", "story_v_out_410042.awb")

						arg_181_1:RecordAudio("410042045", var_184_39)
						arg_181_1:RecordAudio("410042045", var_184_39)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_410042", "410042045", "story_v_out_410042.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_410042", "410042045", "story_v_out_410042.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_40 = math.max(var_184_31, arg_181_1.talkMaxDuration)

			if var_184_30 <= arg_181_1.time_ and arg_181_1.time_ < var_184_30 + var_184_40 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_30) / var_184_40

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_30 + var_184_40 and arg_181_1.time_ < var_184_30 + var_184_40 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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

		arg_181_1:InitPlayNodeList()
	end,
	Play410042046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410042046
		arg_185_1.duration_ = 5.37

		local var_185_0 = {
			zh = 5.366,
			ja = 5.1
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
				arg_185_0:Play410042047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1056"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1056 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1056", 2)

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

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1056, var_188_6, var_188_5)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_188_7 = arg_185_1.actors_["1056"]
			local var_188_8 = 0

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps1056 == nil then
				arg_185_1.var_.actorSpriteComps1056 = var_188_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_9 = 0.034

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_9 and not isNil(var_188_7) then
				local var_188_10 = (arg_185_1.time_ - var_188_8) / var_188_9

				if arg_185_1.var_.actorSpriteComps1056 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								local var_188_11 = Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor1.r, var_188_10)
								local var_188_12 = Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor1.g, var_188_10)
								local var_188_13 = Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor1.b, var_188_10)

								iter_188_2.color = Color.New(var_188_11, var_188_12, var_188_13)
							else
								local var_188_14 = Mathf.Lerp(iter_188_2.color.r, 1, var_188_10)

								iter_188_2.color = Color.New(var_188_14, var_188_14, var_188_14)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_8 + var_188_9 and arg_185_1.time_ < var_188_8 + var_188_9 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps1056 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_188_4 then
						if arg_185_1.isInRecall_ then
							iter_188_4.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps1056 = nil
			end

			local var_188_15 = arg_185_1.actors_["10060"]
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps10060 == nil then
				arg_185_1.var_.actorSpriteComps10060 = var_188_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_17 = 0.034

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 and not isNil(var_188_15) then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17

				if arg_185_1.var_.actorSpriteComps10060 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_188_6 then
							if arg_185_1.isInRecall_ then
								local var_188_19 = Mathf.Lerp(iter_188_6.color.r, arg_185_1.hightColor2.r, var_188_18)
								local var_188_20 = Mathf.Lerp(iter_188_6.color.g, arg_185_1.hightColor2.g, var_188_18)
								local var_188_21 = Mathf.Lerp(iter_188_6.color.b, arg_185_1.hightColor2.b, var_188_18)

								iter_188_6.color = Color.New(var_188_19, var_188_20, var_188_21)
							else
								local var_188_22 = Mathf.Lerp(iter_188_6.color.r, 0.5, var_188_18)

								iter_188_6.color = Color.New(var_188_22, var_188_22, var_188_22)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps10060 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_188_8 then
						if arg_185_1.isInRecall_ then
							iter_188_8.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10060 = nil
			end

			local var_188_23 = 0
			local var_188_24 = 0.7

			if var_188_23 < arg_185_1.time_ and arg_185_1.time_ <= var_188_23 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_25 = arg_185_1:FormatText(StoryNameCfg[605].name)

				arg_185_1.leftNameTxt_.text = var_188_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_26 = arg_185_1:GetWordFromCfg(410042046)
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

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042046", "story_v_out_410042.awb") ~= 0 then
					local var_188_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042046", "story_v_out_410042.awb") / 1000

					if var_188_31 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_31 + var_188_23
					end

					if var_188_26.prefab_name ~= "" and arg_185_1.actors_[var_188_26.prefab_name] ~= nil then
						local var_188_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_26.prefab_name].transform, "story_v_out_410042", "410042046", "story_v_out_410042.awb")

						arg_185_1:RecordAudio("410042046", var_188_32)
						arg_185_1:RecordAudio("410042046", var_188_32)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_410042", "410042046", "story_v_out_410042.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_410042", "410042046", "story_v_out_410042.awb")
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
				actorName = "1056",
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
	Play410042047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410042047
		arg_189_1.duration_ = 6.53

		local var_189_0 = {
			zh = 4.466,
			ja = 6.533
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
				arg_189_0:Play410042048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10060"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10060 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10060", 4)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(390, -400, 0)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10060, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_192_7 = arg_189_1.actors_["10060"]
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10060 == nil then
				arg_189_1.var_.actorSpriteComps10060 = var_192_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 0.034

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 and not isNil(var_192_7) then
				local var_192_10 = (arg_189_1.time_ - var_192_8) / var_192_9

				if arg_189_1.var_.actorSpriteComps10060 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								local var_192_11 = Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, var_192_10)
								local var_192_12 = Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, var_192_10)
								local var_192_13 = Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, var_192_10)

								iter_192_2.color = Color.New(var_192_11, var_192_12, var_192_13)
							else
								local var_192_14 = Mathf.Lerp(iter_192_2.color.r, 1, var_192_10)

								iter_192_2.color = Color.New(var_192_14, var_192_14, var_192_14)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10060 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_192_4 then
						if arg_189_1.isInRecall_ then
							iter_192_4.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10060 = nil
			end

			local var_192_15 = arg_189_1.actors_["1056"]
			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 and not isNil(var_192_15) and arg_189_1.var_.actorSpriteComps1056 == nil then
				arg_189_1.var_.actorSpriteComps1056 = var_192_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_17 = 0.034

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_17 and not isNil(var_192_15) then
				local var_192_18 = (arg_189_1.time_ - var_192_16) / var_192_17

				if arg_189_1.var_.actorSpriteComps1056 then
					for iter_192_5, iter_192_6 in pairs(arg_189_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_192_6 then
							if arg_189_1.isInRecall_ then
								local var_192_19 = Mathf.Lerp(iter_192_6.color.r, arg_189_1.hightColor2.r, var_192_18)
								local var_192_20 = Mathf.Lerp(iter_192_6.color.g, arg_189_1.hightColor2.g, var_192_18)
								local var_192_21 = Mathf.Lerp(iter_192_6.color.b, arg_189_1.hightColor2.b, var_192_18)

								iter_192_6.color = Color.New(var_192_19, var_192_20, var_192_21)
							else
								local var_192_22 = Mathf.Lerp(iter_192_6.color.r, 0.5, var_192_18)

								iter_192_6.color = Color.New(var_192_22, var_192_22, var_192_22)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_16 + var_192_17 and arg_189_1.time_ < var_192_16 + var_192_17 + arg_192_0 and not isNil(var_192_15) and arg_189_1.var_.actorSpriteComps1056 then
				for iter_192_7, iter_192_8 in pairs(arg_189_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_192_8 then
						if arg_189_1.isInRecall_ then
							iter_192_8.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps1056 = nil
			end

			local var_192_23 = 0
			local var_192_24 = 0.4

			if var_192_23 < arg_189_1.time_ and arg_189_1.time_ <= var_192_23 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_25 = arg_189_1:FormatText(StoryNameCfg[597].name)

				arg_189_1.leftNameTxt_.text = var_192_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_26 = arg_189_1:GetWordFromCfg(410042047)
				local var_192_27 = arg_189_1:FormatText(var_192_26.content)

				arg_189_1.text_.text = var_192_27

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_28 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042047", "story_v_out_410042.awb") ~= 0 then
					local var_192_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042047", "story_v_out_410042.awb") / 1000

					if var_192_31 + var_192_23 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_31 + var_192_23
					end

					if var_192_26.prefab_name ~= "" and arg_189_1.actors_[var_192_26.prefab_name] ~= nil then
						local var_192_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_26.prefab_name].transform, "story_v_out_410042", "410042047", "story_v_out_410042.awb")

						arg_189_1:RecordAudio("410042047", var_192_32)
						arg_189_1:RecordAudio("410042047", var_192_32)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410042", "410042047", "story_v_out_410042.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410042", "410042047", "story_v_out_410042.awb")
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
				actorName = "10060",
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
	Play410042048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410042048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play410042049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10063"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10063 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10063", 4)

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
				local var_196_6 = Vector3.New(390, -535, -105)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10063, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(390, -535, -105)
			end

			local var_196_7 = arg_193_1.actors_["10060"].transform
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.var_.moveOldPos10060 = var_196_7.localPosition
				var_196_7.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10060", 7)

				local var_196_9 = var_196_7.childCount

				for iter_196_1 = 0, var_196_9 - 1 do
					local var_196_10 = var_196_7:GetChild(iter_196_1)

					if var_196_10.name == "" or not string.find(var_196_10.name, "split") then
						var_196_10.gameObject:SetActive(true)
					else
						var_196_10.gameObject:SetActive(false)
					end
				end
			end

			local var_196_11 = 0.001

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_11 then
				local var_196_12 = (arg_193_1.time_ - var_196_8) / var_196_11
				local var_196_13 = Vector3.New(0, -2000, 0)

				var_196_7.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10060, var_196_13, var_196_12)
			end

			if arg_193_1.time_ >= var_196_8 + var_196_11 and arg_193_1.time_ < var_196_8 + var_196_11 + arg_196_0 then
				var_196_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_14 = arg_193_1.actors_["10063"]
			local var_196_15 = 0

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 and not isNil(var_196_14) and arg_193_1.var_.actorSpriteComps10063 == nil then
				arg_193_1.var_.actorSpriteComps10063 = var_196_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_16 = 0.034

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_16 and not isNil(var_196_14) then
				local var_196_17 = (arg_193_1.time_ - var_196_15) / var_196_16

				if arg_193_1.var_.actorSpriteComps10063 then
					for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_196_3 then
							if arg_193_1.isInRecall_ then
								local var_196_18 = Mathf.Lerp(iter_196_3.color.r, arg_193_1.hightColor2.r, var_196_17)
								local var_196_19 = Mathf.Lerp(iter_196_3.color.g, arg_193_1.hightColor2.g, var_196_17)
								local var_196_20 = Mathf.Lerp(iter_196_3.color.b, arg_193_1.hightColor2.b, var_196_17)

								iter_196_3.color = Color.New(var_196_18, var_196_19, var_196_20)
							else
								local var_196_21 = Mathf.Lerp(iter_196_3.color.r, 0.5, var_196_17)

								iter_196_3.color = Color.New(var_196_21, var_196_21, var_196_21)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_15 + var_196_16 and arg_193_1.time_ < var_196_15 + var_196_16 + arg_196_0 and not isNil(var_196_14) and arg_193_1.var_.actorSpriteComps10063 then
				for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_196_5 then
						if arg_193_1.isInRecall_ then
							iter_196_5.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10063 = nil
			end

			local var_196_22 = arg_193_1.actors_["10060"]
			local var_196_23 = 0

			if var_196_23 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 and not isNil(var_196_22) and arg_193_1.var_.actorSpriteComps10060 == nil then
				arg_193_1.var_.actorSpriteComps10060 = var_196_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_24 = 0.034

			if var_196_23 <= arg_193_1.time_ and arg_193_1.time_ < var_196_23 + var_196_24 and not isNil(var_196_22) then
				local var_196_25 = (arg_193_1.time_ - var_196_23) / var_196_24

				if arg_193_1.var_.actorSpriteComps10060 then
					for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_196_7 then
							if arg_193_1.isInRecall_ then
								local var_196_26 = Mathf.Lerp(iter_196_7.color.r, arg_193_1.hightColor2.r, var_196_25)
								local var_196_27 = Mathf.Lerp(iter_196_7.color.g, arg_193_1.hightColor2.g, var_196_25)
								local var_196_28 = Mathf.Lerp(iter_196_7.color.b, arg_193_1.hightColor2.b, var_196_25)

								iter_196_7.color = Color.New(var_196_26, var_196_27, var_196_28)
							else
								local var_196_29 = Mathf.Lerp(iter_196_7.color.r, 0.5, var_196_25)

								iter_196_7.color = Color.New(var_196_29, var_196_29, var_196_29)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_23 + var_196_24 and arg_193_1.time_ < var_196_23 + var_196_24 + arg_196_0 and not isNil(var_196_22) and arg_193_1.var_.actorSpriteComps10060 then
				for iter_196_8, iter_196_9 in pairs(arg_193_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_196_9 then
						if arg_193_1.isInRecall_ then
							iter_196_9.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10060 = nil
			end

			local var_196_30 = 0
			local var_196_31 = 1.075

			if var_196_30 < arg_193_1.time_ and arg_193_1.time_ <= var_196_30 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_32 = arg_193_1:GetWordFromCfg(410042048)
				local var_196_33 = arg_193_1:FormatText(var_196_32.content)

				arg_193_1.text_.text = var_196_33

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_34 = 43
				local var_196_35 = utf8.len(var_196_33)
				local var_196_36 = var_196_34 <= 0 and var_196_31 or var_196_31 * (var_196_35 / var_196_34)

				if var_196_36 > 0 and var_196_31 < var_196_36 then
					arg_193_1.talkMaxDuration = var_196_36

					if var_196_36 + var_196_30 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_36 + var_196_30
					end
				end

				arg_193_1.text_.text = var_196_33
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_37 = math.max(var_196_31, arg_193_1.talkMaxDuration)

			if var_196_30 <= arg_193_1.time_ and arg_193_1.time_ < var_196_30 + var_196_37 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_30) / var_196_37

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_30 + var_196_37 and arg_193_1.time_ < var_196_30 + var_196_37 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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

		arg_193_1:InitPlayNodeList()
	end,
	Play410042049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410042049
		arg_197_1.duration_ = 8.93

		local var_197_0 = {
			zh = 8.4,
			ja = 8.933
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
				arg_197_0:Play410042050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10063"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10063 = var_200_0.localPosition
				var_200_0.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10063", 4)

				local var_200_2 = var_200_0.childCount

				for iter_200_0 = 0, var_200_2 - 1 do
					local var_200_3 = var_200_0:GetChild(iter_200_0)

					if var_200_3.name == "split_4" or not string.find(var_200_3.name, "split") then
						var_200_3.gameObject:SetActive(true)
					else
						var_200_3.gameObject:SetActive(false)
					end
				end
			end

			local var_200_4 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_4 then
				local var_200_5 = (arg_197_1.time_ - var_200_1) / var_200_4
				local var_200_6 = Vector3.New(390, -535, -105)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10063, var_200_6, var_200_5)
			end

			if arg_197_1.time_ >= var_200_1 + var_200_4 and arg_197_1.time_ < var_200_1 + var_200_4 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(390, -535, -105)
			end

			local var_200_7 = arg_197_1.actors_["10063"]
			local var_200_8 = 0

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps10063 == nil then
				arg_197_1.var_.actorSpriteComps10063 = var_200_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_9 = 0.034

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_9 and not isNil(var_200_7) then
				local var_200_10 = (arg_197_1.time_ - var_200_8) / var_200_9

				if arg_197_1.var_.actorSpriteComps10063 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								local var_200_11 = Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor1.r, var_200_10)
								local var_200_12 = Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor1.g, var_200_10)
								local var_200_13 = Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor1.b, var_200_10)

								iter_200_2.color = Color.New(var_200_11, var_200_12, var_200_13)
							else
								local var_200_14 = Mathf.Lerp(iter_200_2.color.r, 1, var_200_10)

								iter_200_2.color = Color.New(var_200_14, var_200_14, var_200_14)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_8 + var_200_9 and arg_197_1.time_ < var_200_8 + var_200_9 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps10063 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_200_4 then
						if arg_197_1.isInRecall_ then
							iter_200_4.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10063 = nil
			end

			local var_200_15 = 0
			local var_200_16 = 0.8

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_17 = arg_197_1:FormatText(StoryNameCfg[591].name)

				arg_197_1.leftNameTxt_.text = var_200_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_18 = arg_197_1:GetWordFromCfg(410042049)
				local var_200_19 = arg_197_1:FormatText(var_200_18.content)

				arg_197_1.text_.text = var_200_19

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_20 = 32
				local var_200_21 = utf8.len(var_200_19)
				local var_200_22 = var_200_20 <= 0 and var_200_16 or var_200_16 * (var_200_21 / var_200_20)

				if var_200_22 > 0 and var_200_16 < var_200_22 then
					arg_197_1.talkMaxDuration = var_200_22

					if var_200_22 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_22 + var_200_15
					end
				end

				arg_197_1.text_.text = var_200_19
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042049", "story_v_out_410042.awb") ~= 0 then
					local var_200_23 = manager.audio:GetVoiceLength("story_v_out_410042", "410042049", "story_v_out_410042.awb") / 1000

					if var_200_23 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_15
					end

					if var_200_18.prefab_name ~= "" and arg_197_1.actors_[var_200_18.prefab_name] ~= nil then
						local var_200_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_18.prefab_name].transform, "story_v_out_410042", "410042049", "story_v_out_410042.awb")

						arg_197_1:RecordAudio("410042049", var_200_24)
						arg_197_1:RecordAudio("410042049", var_200_24)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410042", "410042049", "story_v_out_410042.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410042", "410042049", "story_v_out_410042.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_25 = math.max(var_200_16, arg_197_1.talkMaxDuration)

			if var_200_15 <= arg_197_1.time_ and arg_197_1.time_ < var_200_15 + var_200_25 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_15) / var_200_25

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_15 + var_200_25 and arg_197_1.time_ < var_200_15 + var_200_25 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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
	Play410042050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410042050
		arg_201_1.duration_ = 2.57

		local var_201_0 = {
			zh = 2,
			ja = 2.566
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
				arg_201_0:Play410042051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1056"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1056 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1056", 2)

				local var_204_2 = var_204_0.childCount

				for iter_204_0 = 0, var_204_2 - 1 do
					local var_204_3 = var_204_0:GetChild(iter_204_0)

					if var_204_3.name == "split_4" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_4 then
				local var_204_5 = (arg_201_1.time_ - var_204_1) / var_204_4
				local var_204_6 = Vector3.New(-390, -350, -180)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1056, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_204_7 = arg_201_1.actors_["1056"]
			local var_204_8 = 0

			if var_204_8 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 and not isNil(var_204_7) and arg_201_1.var_.actorSpriteComps1056 == nil then
				arg_201_1.var_.actorSpriteComps1056 = var_204_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_9 = 0.034

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_9 and not isNil(var_204_7) then
				local var_204_10 = (arg_201_1.time_ - var_204_8) / var_204_9

				if arg_201_1.var_.actorSpriteComps1056 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_204_2 then
							if arg_201_1.isInRecall_ then
								local var_204_11 = Mathf.Lerp(iter_204_2.color.r, arg_201_1.hightColor1.r, var_204_10)
								local var_204_12 = Mathf.Lerp(iter_204_2.color.g, arg_201_1.hightColor1.g, var_204_10)
								local var_204_13 = Mathf.Lerp(iter_204_2.color.b, arg_201_1.hightColor1.b, var_204_10)

								iter_204_2.color = Color.New(var_204_11, var_204_12, var_204_13)
							else
								local var_204_14 = Mathf.Lerp(iter_204_2.color.r, 1, var_204_10)

								iter_204_2.color = Color.New(var_204_14, var_204_14, var_204_14)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_8 + var_204_9 and arg_201_1.time_ < var_204_8 + var_204_9 + arg_204_0 and not isNil(var_204_7) and arg_201_1.var_.actorSpriteComps1056 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_204_4 then
						if arg_201_1.isInRecall_ then
							iter_204_4.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1056 = nil
			end

			local var_204_15 = arg_201_1.actors_["10063"]
			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.actorSpriteComps10063 == nil then
				arg_201_1.var_.actorSpriteComps10063 = var_204_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_17 = 0.034

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 and not isNil(var_204_15) then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17

				if arg_201_1.var_.actorSpriteComps10063 then
					for iter_204_5, iter_204_6 in pairs(arg_201_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_204_6 then
							if arg_201_1.isInRecall_ then
								local var_204_19 = Mathf.Lerp(iter_204_6.color.r, arg_201_1.hightColor2.r, var_204_18)
								local var_204_20 = Mathf.Lerp(iter_204_6.color.g, arg_201_1.hightColor2.g, var_204_18)
								local var_204_21 = Mathf.Lerp(iter_204_6.color.b, arg_201_1.hightColor2.b, var_204_18)

								iter_204_6.color = Color.New(var_204_19, var_204_20, var_204_21)
							else
								local var_204_22 = Mathf.Lerp(iter_204_6.color.r, 0.5, var_204_18)

								iter_204_6.color = Color.New(var_204_22, var_204_22, var_204_22)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.actorSpriteComps10063 then
				for iter_204_7, iter_204_8 in pairs(arg_201_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_204_8 then
						if arg_201_1.isInRecall_ then
							iter_204_8.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10063 = nil
			end

			local var_204_23 = 0
			local var_204_24 = 0.15

			if var_204_23 < arg_201_1.time_ and arg_201_1.time_ <= var_204_23 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_25 = arg_201_1:FormatText(StoryNameCfg[605].name)

				arg_201_1.leftNameTxt_.text = var_204_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_26 = arg_201_1:GetWordFromCfg(410042050)
				local var_204_27 = arg_201_1:FormatText(var_204_26.content)

				arg_201_1.text_.text = var_204_27

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_28 = 6
				local var_204_29 = utf8.len(var_204_27)
				local var_204_30 = var_204_28 <= 0 and var_204_24 or var_204_24 * (var_204_29 / var_204_28)

				if var_204_30 > 0 and var_204_24 < var_204_30 then
					arg_201_1.talkMaxDuration = var_204_30

					if var_204_30 + var_204_23 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_30 + var_204_23
					end
				end

				arg_201_1.text_.text = var_204_27
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042050", "story_v_out_410042.awb") ~= 0 then
					local var_204_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042050", "story_v_out_410042.awb") / 1000

					if var_204_31 + var_204_23 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_31 + var_204_23
					end

					if var_204_26.prefab_name ~= "" and arg_201_1.actors_[var_204_26.prefab_name] ~= nil then
						local var_204_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_26.prefab_name].transform, "story_v_out_410042", "410042050", "story_v_out_410042.awb")

						arg_201_1:RecordAudio("410042050", var_204_32)
						arg_201_1:RecordAudio("410042050", var_204_32)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_410042", "410042050", "story_v_out_410042.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_410042", "410042050", "story_v_out_410042.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_33 = math.max(var_204_24, arg_201_1.talkMaxDuration)

			if var_204_23 <= arg_201_1.time_ and arg_201_1.time_ < var_204_23 + var_204_33 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_23) / var_204_33

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_23 + var_204_33 and arg_201_1.time_ < var_204_23 + var_204_33 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410042051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410042051
		arg_205_1.duration_ = 7.03

		local var_205_0 = {
			zh = 4.966,
			ja = 7.033
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
				arg_205_0:Play410042052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1060"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1060 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1060", 2)

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
				local var_208_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1060, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_208_7 = arg_205_1.actors_["1056"].transform
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.var_.moveOldPos1056 = var_208_7.localPosition
				var_208_7.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1056", 7)

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
				local var_208_13 = Vector3.New(0, -2000, -180)

				var_208_7.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1056, var_208_13, var_208_12)
			end

			if arg_205_1.time_ >= var_208_8 + var_208_11 and arg_205_1.time_ < var_208_8 + var_208_11 + arg_208_0 then
				var_208_7.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_208_14 = arg_205_1.actors_["1060"]
			local var_208_15 = 0

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 and not isNil(var_208_14) and arg_205_1.var_.actorSpriteComps1060 == nil then
				arg_205_1.var_.actorSpriteComps1060 = var_208_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_16 = 0.034

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_16 and not isNil(var_208_14) then
				local var_208_17 = (arg_205_1.time_ - var_208_15) / var_208_16

				if arg_205_1.var_.actorSpriteComps1060 then
					for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_208_3 then
							if arg_205_1.isInRecall_ then
								local var_208_18 = Mathf.Lerp(iter_208_3.color.r, arg_205_1.hightColor1.r, var_208_17)
								local var_208_19 = Mathf.Lerp(iter_208_3.color.g, arg_205_1.hightColor1.g, var_208_17)
								local var_208_20 = Mathf.Lerp(iter_208_3.color.b, arg_205_1.hightColor1.b, var_208_17)

								iter_208_3.color = Color.New(var_208_18, var_208_19, var_208_20)
							else
								local var_208_21 = Mathf.Lerp(iter_208_3.color.r, 1, var_208_17)

								iter_208_3.color = Color.New(var_208_21, var_208_21, var_208_21)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_15 + var_208_16 and arg_205_1.time_ < var_208_15 + var_208_16 + arg_208_0 and not isNil(var_208_14) and arg_205_1.var_.actorSpriteComps1060 then
				for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_208_5 then
						if arg_205_1.isInRecall_ then
							iter_208_5.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1060 = nil
			end

			local var_208_22 = arg_205_1.actors_["1056"]
			local var_208_23 = 0

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 and not isNil(var_208_22) and arg_205_1.var_.actorSpriteComps1056 == nil then
				arg_205_1.var_.actorSpriteComps1056 = var_208_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_24 = 0.034

			if var_208_23 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_24 and not isNil(var_208_22) then
				local var_208_25 = (arg_205_1.time_ - var_208_23) / var_208_24

				if arg_205_1.var_.actorSpriteComps1056 then
					for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_205_1.time_ >= var_208_23 + var_208_24 and arg_205_1.time_ < var_208_23 + var_208_24 + arg_208_0 and not isNil(var_208_22) and arg_205_1.var_.actorSpriteComps1056 then
				for iter_208_8, iter_208_9 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_208_9 then
						if arg_205_1.isInRecall_ then
							iter_208_9.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1056 = nil
			end

			local var_208_30 = 0
			local var_208_31 = 0.525

			if var_208_30 < arg_205_1.time_ and arg_205_1.time_ <= var_208_30 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_32 = arg_205_1:FormatText(StoryNameCfg[584].name)

				arg_205_1.leftNameTxt_.text = var_208_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_33 = arg_205_1:GetWordFromCfg(410042051)
				local var_208_34 = arg_205_1:FormatText(var_208_33.content)

				arg_205_1.text_.text = var_208_34

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_35 = 21
				local var_208_36 = utf8.len(var_208_34)
				local var_208_37 = var_208_35 <= 0 and var_208_31 or var_208_31 * (var_208_36 / var_208_35)

				if var_208_37 > 0 and var_208_31 < var_208_37 then
					arg_205_1.talkMaxDuration = var_208_37

					if var_208_37 + var_208_30 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_37 + var_208_30
					end
				end

				arg_205_1.text_.text = var_208_34
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042051", "story_v_out_410042.awb") ~= 0 then
					local var_208_38 = manager.audio:GetVoiceLength("story_v_out_410042", "410042051", "story_v_out_410042.awb") / 1000

					if var_208_38 + var_208_30 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_38 + var_208_30
					end

					if var_208_33.prefab_name ~= "" and arg_205_1.actors_[var_208_33.prefab_name] ~= nil then
						local var_208_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_33.prefab_name].transform, "story_v_out_410042", "410042051", "story_v_out_410042.awb")

						arg_205_1:RecordAudio("410042051", var_208_39)
						arg_205_1:RecordAudio("410042051", var_208_39)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410042", "410042051", "story_v_out_410042.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410042", "410042051", "story_v_out_410042.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_40 = math.max(var_208_31, arg_205_1.talkMaxDuration)

			if var_208_30 <= arg_205_1.time_ and arg_205_1.time_ < var_208_30 + var_208_40 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_30) / var_208_40

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_30 + var_208_40 and arg_205_1.time_ < var_208_30 + var_208_40 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
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
	Play410042052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410042052
		arg_209_1.duration_ = 8.47

		local var_209_0 = {
			zh = 4.433,
			ja = 8.466
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play410042053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10063"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos10063 = var_212_0.localPosition
				var_212_0.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10063", 4)

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
				local var_212_6 = Vector3.New(390, -535, -105)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10063, var_212_6, var_212_5)
			end

			if arg_209_1.time_ >= var_212_1 + var_212_4 and arg_209_1.time_ < var_212_1 + var_212_4 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(390, -535, -105)
			end

			local var_212_7 = arg_209_1.actors_["10063"]
			local var_212_8 = 0

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 and not isNil(var_212_7) and arg_209_1.var_.actorSpriteComps10063 == nil then
				arg_209_1.var_.actorSpriteComps10063 = var_212_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_9 = 0.034

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_9 and not isNil(var_212_7) then
				local var_212_10 = (arg_209_1.time_ - var_212_8) / var_212_9

				if arg_209_1.var_.actorSpriteComps10063 then
					for iter_212_1, iter_212_2 in pairs(arg_209_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_212_2 then
							if arg_209_1.isInRecall_ then
								local var_212_11 = Mathf.Lerp(iter_212_2.color.r, arg_209_1.hightColor1.r, var_212_10)
								local var_212_12 = Mathf.Lerp(iter_212_2.color.g, arg_209_1.hightColor1.g, var_212_10)
								local var_212_13 = Mathf.Lerp(iter_212_2.color.b, arg_209_1.hightColor1.b, var_212_10)

								iter_212_2.color = Color.New(var_212_11, var_212_12, var_212_13)
							else
								local var_212_14 = Mathf.Lerp(iter_212_2.color.r, 1, var_212_10)

								iter_212_2.color = Color.New(var_212_14, var_212_14, var_212_14)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_8 + var_212_9 and arg_209_1.time_ < var_212_8 + var_212_9 + arg_212_0 and not isNil(var_212_7) and arg_209_1.var_.actorSpriteComps10063 then
				for iter_212_3, iter_212_4 in pairs(arg_209_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_212_4 then
						if arg_209_1.isInRecall_ then
							iter_212_4.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10063 = nil
			end

			local var_212_15 = arg_209_1.actors_["1060"]
			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 and not isNil(var_212_15) and arg_209_1.var_.actorSpriteComps1060 == nil then
				arg_209_1.var_.actorSpriteComps1060 = var_212_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_17 = 0.034

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 and not isNil(var_212_15) then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17

				if arg_209_1.var_.actorSpriteComps1060 then
					for iter_212_5, iter_212_6 in pairs(arg_209_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_212_6 then
							if arg_209_1.isInRecall_ then
								local var_212_19 = Mathf.Lerp(iter_212_6.color.r, arg_209_1.hightColor2.r, var_212_18)
								local var_212_20 = Mathf.Lerp(iter_212_6.color.g, arg_209_1.hightColor2.g, var_212_18)
								local var_212_21 = Mathf.Lerp(iter_212_6.color.b, arg_209_1.hightColor2.b, var_212_18)

								iter_212_6.color = Color.New(var_212_19, var_212_20, var_212_21)
							else
								local var_212_22 = Mathf.Lerp(iter_212_6.color.r, 0.5, var_212_18)

								iter_212_6.color = Color.New(var_212_22, var_212_22, var_212_22)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 and not isNil(var_212_15) and arg_209_1.var_.actorSpriteComps1060 then
				for iter_212_7, iter_212_8 in pairs(arg_209_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_212_8 then
						if arg_209_1.isInRecall_ then
							iter_212_8.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1060 = nil
			end

			local var_212_23 = 0
			local var_212_24 = 0.45

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_25 = arg_209_1:FormatText(StoryNameCfg[591].name)

				arg_209_1.leftNameTxt_.text = var_212_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_26 = arg_209_1:GetWordFromCfg(410042052)
				local var_212_27 = arg_209_1:FormatText(var_212_26.content)

				arg_209_1.text_.text = var_212_27

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_28 = 18
				local var_212_29 = utf8.len(var_212_27)
				local var_212_30 = var_212_28 <= 0 and var_212_24 or var_212_24 * (var_212_29 / var_212_28)

				if var_212_30 > 0 and var_212_24 < var_212_30 then
					arg_209_1.talkMaxDuration = var_212_30

					if var_212_30 + var_212_23 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_30 + var_212_23
					end
				end

				arg_209_1.text_.text = var_212_27
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042052", "story_v_out_410042.awb") ~= 0 then
					local var_212_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042052", "story_v_out_410042.awb") / 1000

					if var_212_31 + var_212_23 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_31 + var_212_23
					end

					if var_212_26.prefab_name ~= "" and arg_209_1.actors_[var_212_26.prefab_name] ~= nil then
						local var_212_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_26.prefab_name].transform, "story_v_out_410042", "410042052", "story_v_out_410042.awb")

						arg_209_1:RecordAudio("410042052", var_212_32)
						arg_209_1:RecordAudio("410042052", var_212_32)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_410042", "410042052", "story_v_out_410042.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_410042", "410042052", "story_v_out_410042.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_33 = math.max(var_212_24, arg_209_1.talkMaxDuration)

			if var_212_23 <= arg_209_1.time_ and arg_209_1.time_ < var_212_23 + var_212_33 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_23) / var_212_33

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_23 + var_212_33 and arg_209_1.time_ < var_212_23 + var_212_33 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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
	Play410042053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410042053
		arg_213_1.duration_ = 13

		local var_213_0 = {
			zh = 8.1,
			ja = 13
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
				arg_213_0:Play410042054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10060"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos10060 = var_216_0.localPosition
				var_216_0.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10060", 4)

				local var_216_2 = var_216_0.childCount

				for iter_216_0 = 0, var_216_2 - 1 do
					local var_216_3 = var_216_0:GetChild(iter_216_0)

					if var_216_3.name == "split_4" or not string.find(var_216_3.name, "split") then
						var_216_3.gameObject:SetActive(true)
					else
						var_216_3.gameObject:SetActive(false)
					end
				end
			end

			local var_216_4 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_4 then
				local var_216_5 = (arg_213_1.time_ - var_216_1) / var_216_4
				local var_216_6 = Vector3.New(390, -400, 0)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10060, var_216_6, var_216_5)
			end

			if arg_213_1.time_ >= var_216_1 + var_216_4 and arg_213_1.time_ < var_216_1 + var_216_4 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_216_7 = arg_213_1.actors_["10063"].transform
			local var_216_8 = 0

			if var_216_8 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.var_.moveOldPos10063 = var_216_7.localPosition
				var_216_7.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10063", 7)

				local var_216_9 = var_216_7.childCount

				for iter_216_1 = 0, var_216_9 - 1 do
					local var_216_10 = var_216_7:GetChild(iter_216_1)

					if var_216_10.name == "" or not string.find(var_216_10.name, "split") then
						var_216_10.gameObject:SetActive(true)
					else
						var_216_10.gameObject:SetActive(false)
					end
				end
			end

			local var_216_11 = 0.001

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_11 then
				local var_216_12 = (arg_213_1.time_ - var_216_8) / var_216_11
				local var_216_13 = Vector3.New(0, -2000, -105)

				var_216_7.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10063, var_216_13, var_216_12)
			end

			if arg_213_1.time_ >= var_216_8 + var_216_11 and arg_213_1.time_ < var_216_8 + var_216_11 + arg_216_0 then
				var_216_7.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_216_14 = arg_213_1.actors_["10060"]
			local var_216_15 = 0

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 and not isNil(var_216_14) and arg_213_1.var_.actorSpriteComps10060 == nil then
				arg_213_1.var_.actorSpriteComps10060 = var_216_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_16 = 0.034

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_16 and not isNil(var_216_14) then
				local var_216_17 = (arg_213_1.time_ - var_216_15) / var_216_16

				if arg_213_1.var_.actorSpriteComps10060 then
					for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_216_3 then
							if arg_213_1.isInRecall_ then
								local var_216_18 = Mathf.Lerp(iter_216_3.color.r, arg_213_1.hightColor1.r, var_216_17)
								local var_216_19 = Mathf.Lerp(iter_216_3.color.g, arg_213_1.hightColor1.g, var_216_17)
								local var_216_20 = Mathf.Lerp(iter_216_3.color.b, arg_213_1.hightColor1.b, var_216_17)

								iter_216_3.color = Color.New(var_216_18, var_216_19, var_216_20)
							else
								local var_216_21 = Mathf.Lerp(iter_216_3.color.r, 1, var_216_17)

								iter_216_3.color = Color.New(var_216_21, var_216_21, var_216_21)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_15 + var_216_16 and arg_213_1.time_ < var_216_15 + var_216_16 + arg_216_0 and not isNil(var_216_14) and arg_213_1.var_.actorSpriteComps10060 then
				for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_216_5 then
						if arg_213_1.isInRecall_ then
							iter_216_5.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10060 = nil
			end

			local var_216_22 = arg_213_1.actors_["10063"]
			local var_216_23 = 0

			if var_216_23 < arg_213_1.time_ and arg_213_1.time_ <= var_216_23 + arg_216_0 and not isNil(var_216_22) and arg_213_1.var_.actorSpriteComps10063 == nil then
				arg_213_1.var_.actorSpriteComps10063 = var_216_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_24 = 0.034

			if var_216_23 <= arg_213_1.time_ and arg_213_1.time_ < var_216_23 + var_216_24 and not isNil(var_216_22) then
				local var_216_25 = (arg_213_1.time_ - var_216_23) / var_216_24

				if arg_213_1.var_.actorSpriteComps10063 then
					for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_216_7 then
							if arg_213_1.isInRecall_ then
								local var_216_26 = Mathf.Lerp(iter_216_7.color.r, arg_213_1.hightColor2.r, var_216_25)
								local var_216_27 = Mathf.Lerp(iter_216_7.color.g, arg_213_1.hightColor2.g, var_216_25)
								local var_216_28 = Mathf.Lerp(iter_216_7.color.b, arg_213_1.hightColor2.b, var_216_25)

								iter_216_7.color = Color.New(var_216_26, var_216_27, var_216_28)
							else
								local var_216_29 = Mathf.Lerp(iter_216_7.color.r, 0.5, var_216_25)

								iter_216_7.color = Color.New(var_216_29, var_216_29, var_216_29)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_23 + var_216_24 and arg_213_1.time_ < var_216_23 + var_216_24 + arg_216_0 and not isNil(var_216_22) and arg_213_1.var_.actorSpriteComps10063 then
				for iter_216_8, iter_216_9 in pairs(arg_213_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_216_9 then
						if arg_213_1.isInRecall_ then
							iter_216_9.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10063 = nil
			end

			local var_216_30 = 0
			local var_216_31 = 1.1

			if var_216_30 < arg_213_1.time_ and arg_213_1.time_ <= var_216_30 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_32 = arg_213_1:FormatText(StoryNameCfg[597].name)

				arg_213_1.leftNameTxt_.text = var_216_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_33 = arg_213_1:GetWordFromCfg(410042053)
				local var_216_34 = arg_213_1:FormatText(var_216_33.content)

				arg_213_1.text_.text = var_216_34

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_35 = 44
				local var_216_36 = utf8.len(var_216_34)
				local var_216_37 = var_216_35 <= 0 and var_216_31 or var_216_31 * (var_216_36 / var_216_35)

				if var_216_37 > 0 and var_216_31 < var_216_37 then
					arg_213_1.talkMaxDuration = var_216_37

					if var_216_37 + var_216_30 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_37 + var_216_30
					end
				end

				arg_213_1.text_.text = var_216_34
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042053", "story_v_out_410042.awb") ~= 0 then
					local var_216_38 = manager.audio:GetVoiceLength("story_v_out_410042", "410042053", "story_v_out_410042.awb") / 1000

					if var_216_38 + var_216_30 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_38 + var_216_30
					end

					if var_216_33.prefab_name ~= "" and arg_213_1.actors_[var_216_33.prefab_name] ~= nil then
						local var_216_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_33.prefab_name].transform, "story_v_out_410042", "410042053", "story_v_out_410042.awb")

						arg_213_1:RecordAudio("410042053", var_216_39)
						arg_213_1:RecordAudio("410042053", var_216_39)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_410042", "410042053", "story_v_out_410042.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_410042", "410042053", "story_v_out_410042.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_40 = math.max(var_216_31, arg_213_1.talkMaxDuration)

			if var_216_30 <= arg_213_1.time_ and arg_213_1.time_ < var_216_30 + var_216_40 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_30) / var_216_40

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_30 + var_216_40 and arg_213_1.time_ < var_216_30 + var_216_40 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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
				actorName = "10063",
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
	Play410042054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410042054
		arg_217_1.duration_ = 4.5

		local var_217_0 = {
			zh = 4.5,
			ja = 4
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
				arg_217_0:Play410042055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10060"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos10060 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10060", 4)

				local var_220_2 = var_220_0.childCount

				for iter_220_0 = 0, var_220_2 - 1 do
					local var_220_3 = var_220_0:GetChild(iter_220_0)

					if var_220_3.name == "split_4" or not string.find(var_220_3.name, "split") then
						var_220_3.gameObject:SetActive(true)
					else
						var_220_3.gameObject:SetActive(false)
					end
				end
			end

			local var_220_4 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_4 then
				local var_220_5 = (arg_217_1.time_ - var_220_1) / var_220_4
				local var_220_6 = Vector3.New(390, -400, 0)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10060, var_220_6, var_220_5)
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(390, -400, 0)
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
			local var_220_16 = 0.575

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

				local var_220_18 = arg_217_1:GetWordFromCfg(410042054)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042054", "story_v_out_410042.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_out_410042", "410042054", "story_v_out_410042.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_out_410042", "410042054", "story_v_out_410042.awb")

						arg_217_1:RecordAudio("410042054", var_220_24)
						arg_217_1:RecordAudio("410042054", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_410042", "410042054", "story_v_out_410042.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_410042", "410042054", "story_v_out_410042.awb")
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
	Play410042055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410042055
		arg_221_1.duration_ = 8.8

		local var_221_0 = {
			zh = 3.066,
			ja = 8.8
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
				arg_221_0:Play410042056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10059"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10059 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10059", 4)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "split_2" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(390, -530, 35)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10059, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_224_7 = arg_221_1.actors_["10060"].transform
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.var_.moveOldPos10060 = var_224_7.localPosition
				var_224_7.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10060", 7)

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
				local var_224_13 = Vector3.New(0, -2000, 0)

				var_224_7.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10060, var_224_13, var_224_12)
			end

			if arg_221_1.time_ >= var_224_8 + var_224_11 and arg_221_1.time_ < var_224_8 + var_224_11 + arg_224_0 then
				var_224_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_224_14 = arg_221_1.actors_["10059"]
			local var_224_15 = 0

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 and not isNil(var_224_14) and arg_221_1.var_.actorSpriteComps10059 == nil then
				arg_221_1.var_.actorSpriteComps10059 = var_224_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_16 = 0.034

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_16 and not isNil(var_224_14) then
				local var_224_17 = (arg_221_1.time_ - var_224_15) / var_224_16

				if arg_221_1.var_.actorSpriteComps10059 then
					for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_224_3 then
							if arg_221_1.isInRecall_ then
								local var_224_18 = Mathf.Lerp(iter_224_3.color.r, arg_221_1.hightColor1.r, var_224_17)
								local var_224_19 = Mathf.Lerp(iter_224_3.color.g, arg_221_1.hightColor1.g, var_224_17)
								local var_224_20 = Mathf.Lerp(iter_224_3.color.b, arg_221_1.hightColor1.b, var_224_17)

								iter_224_3.color = Color.New(var_224_18, var_224_19, var_224_20)
							else
								local var_224_21 = Mathf.Lerp(iter_224_3.color.r, 1, var_224_17)

								iter_224_3.color = Color.New(var_224_21, var_224_21, var_224_21)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_15 + var_224_16 and arg_221_1.time_ < var_224_15 + var_224_16 + arg_224_0 and not isNil(var_224_14) and arg_221_1.var_.actorSpriteComps10059 then
				for iter_224_4, iter_224_5 in pairs(arg_221_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_224_5 then
						if arg_221_1.isInRecall_ then
							iter_224_5.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10059 = nil
			end

			local var_224_22 = arg_221_1.actors_["10060"]
			local var_224_23 = 0

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 and not isNil(var_224_22) and arg_221_1.var_.actorSpriteComps10060 == nil then
				arg_221_1.var_.actorSpriteComps10060 = var_224_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_24 = 0.034

			if var_224_23 <= arg_221_1.time_ and arg_221_1.time_ < var_224_23 + var_224_24 and not isNil(var_224_22) then
				local var_224_25 = (arg_221_1.time_ - var_224_23) / var_224_24

				if arg_221_1.var_.actorSpriteComps10060 then
					for iter_224_6, iter_224_7 in pairs(arg_221_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_224_7 then
							if arg_221_1.isInRecall_ then
								local var_224_26 = Mathf.Lerp(iter_224_7.color.r, arg_221_1.hightColor2.r, var_224_25)
								local var_224_27 = Mathf.Lerp(iter_224_7.color.g, arg_221_1.hightColor2.g, var_224_25)
								local var_224_28 = Mathf.Lerp(iter_224_7.color.b, arg_221_1.hightColor2.b, var_224_25)

								iter_224_7.color = Color.New(var_224_26, var_224_27, var_224_28)
							else
								local var_224_29 = Mathf.Lerp(iter_224_7.color.r, 0.5, var_224_25)

								iter_224_7.color = Color.New(var_224_29, var_224_29, var_224_29)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_23 + var_224_24 and arg_221_1.time_ < var_224_23 + var_224_24 + arg_224_0 and not isNil(var_224_22) and arg_221_1.var_.actorSpriteComps10060 then
				for iter_224_8, iter_224_9 in pairs(arg_221_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_224_9 then
						if arg_221_1.isInRecall_ then
							iter_224_9.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10060 = nil
			end

			local var_224_30 = 0
			local var_224_31 = 0.3

			if var_224_30 < arg_221_1.time_ and arg_221_1.time_ <= var_224_30 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_32 = arg_221_1:FormatText(StoryNameCfg[596].name)

				arg_221_1.leftNameTxt_.text = var_224_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_33 = arg_221_1:GetWordFromCfg(410042055)
				local var_224_34 = arg_221_1:FormatText(var_224_33.content)

				arg_221_1.text_.text = var_224_34

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_35 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042055", "story_v_out_410042.awb") ~= 0 then
					local var_224_38 = manager.audio:GetVoiceLength("story_v_out_410042", "410042055", "story_v_out_410042.awb") / 1000

					if var_224_38 + var_224_30 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_38 + var_224_30
					end

					if var_224_33.prefab_name ~= "" and arg_221_1.actors_[var_224_33.prefab_name] ~= nil then
						local var_224_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_33.prefab_name].transform, "story_v_out_410042", "410042055", "story_v_out_410042.awb")

						arg_221_1:RecordAudio("410042055", var_224_39)
						arg_221_1:RecordAudio("410042055", var_224_39)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410042", "410042055", "story_v_out_410042.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410042", "410042055", "story_v_out_410042.awb")
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

		arg_221_1:InitPlayNodeList()
	end,
	Play410042056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410042056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play410042057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10059"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos10059 = var_228_0.localPosition
				var_228_0.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10059", 7)

				local var_228_2 = var_228_0.childCount

				for iter_228_0 = 0, var_228_2 - 1 do
					local var_228_3 = var_228_0:GetChild(iter_228_0)

					if var_228_3.name == "" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_4 then
				local var_228_5 = (arg_225_1.time_ - var_228_1) / var_228_4
				local var_228_6 = Vector3.New(0, -2000, 35)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10059, var_228_6, var_228_5)
			end

			if arg_225_1.time_ >= var_228_1 + var_228_4 and arg_225_1.time_ < var_228_1 + var_228_4 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_228_7 = arg_225_1.actors_["10059"]
			local var_228_8 = 0

			if var_228_8 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps10059 == nil then
				arg_225_1.var_.actorSpriteComps10059 = var_228_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_9 = 0.034

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_9 and not isNil(var_228_7) then
				local var_228_10 = (arg_225_1.time_ - var_228_8) / var_228_9

				if arg_225_1.var_.actorSpriteComps10059 then
					for iter_228_1, iter_228_2 in pairs(arg_225_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_228_2 then
							if arg_225_1.isInRecall_ then
								local var_228_11 = Mathf.Lerp(iter_228_2.color.r, arg_225_1.hightColor2.r, var_228_10)
								local var_228_12 = Mathf.Lerp(iter_228_2.color.g, arg_225_1.hightColor2.g, var_228_10)
								local var_228_13 = Mathf.Lerp(iter_228_2.color.b, arg_225_1.hightColor2.b, var_228_10)

								iter_228_2.color = Color.New(var_228_11, var_228_12, var_228_13)
							else
								local var_228_14 = Mathf.Lerp(iter_228_2.color.r, 0.5, var_228_10)

								iter_228_2.color = Color.New(var_228_14, var_228_14, var_228_14)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_8 + var_228_9 and arg_225_1.time_ < var_228_8 + var_228_9 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps10059 then
				for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_228_4 then
						if arg_225_1.isInRecall_ then
							iter_228_4.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10059 = nil
			end

			local var_228_15 = arg_225_1.actors_["1060"].transform
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 then
				arg_225_1.var_.moveOldPos1060 = var_228_15.localPosition
				var_228_15.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1060", 3)

				local var_228_17 = var_228_15.childCount

				for iter_228_5 = 0, var_228_17 - 1 do
					local var_228_18 = var_228_15:GetChild(iter_228_5)

					if var_228_18.name == "" or not string.find(var_228_18.name, "split") then
						var_228_18.gameObject:SetActive(true)
					else
						var_228_18.gameObject:SetActive(false)
					end
				end
			end

			local var_228_19 = 0.001

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_19 then
				local var_228_20 = (arg_225_1.time_ - var_228_16) / var_228_19
				local var_228_21 = Vector3.New(33.4, -430.8, 6.9)

				var_228_15.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1060, var_228_21, var_228_20)
			end

			if arg_225_1.time_ >= var_228_16 + var_228_19 and arg_225_1.time_ < var_228_16 + var_228_19 + arg_228_0 then
				var_228_15.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_228_22 = arg_225_1.actors_["1060"]
			local var_228_23 = 0

			if var_228_23 < arg_225_1.time_ and arg_225_1.time_ <= var_228_23 + arg_228_0 and not isNil(var_228_22) and arg_225_1.var_.actorSpriteComps1060 == nil then
				arg_225_1.var_.actorSpriteComps1060 = var_228_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_24 = 0.034

			if var_228_23 <= arg_225_1.time_ and arg_225_1.time_ < var_228_23 + var_228_24 and not isNil(var_228_22) then
				local var_228_25 = (arg_225_1.time_ - var_228_23) / var_228_24

				if arg_225_1.var_.actorSpriteComps1060 then
					for iter_228_6, iter_228_7 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_228_7 then
							if arg_225_1.isInRecall_ then
								local var_228_26 = Mathf.Lerp(iter_228_7.color.r, arg_225_1.hightColor2.r, var_228_25)
								local var_228_27 = Mathf.Lerp(iter_228_7.color.g, arg_225_1.hightColor2.g, var_228_25)
								local var_228_28 = Mathf.Lerp(iter_228_7.color.b, arg_225_1.hightColor2.b, var_228_25)

								iter_228_7.color = Color.New(var_228_26, var_228_27, var_228_28)
							else
								local var_228_29 = Mathf.Lerp(iter_228_7.color.r, 0.5, var_228_25)

								iter_228_7.color = Color.New(var_228_29, var_228_29, var_228_29)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_23 + var_228_24 and arg_225_1.time_ < var_228_23 + var_228_24 + arg_228_0 and not isNil(var_228_22) and arg_225_1.var_.actorSpriteComps1060 then
				for iter_228_8, iter_228_9 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_228_9 then
						if arg_225_1.isInRecall_ then
							iter_228_9.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1060 = nil
			end

			local var_228_30 = 0
			local var_228_31 = 0.85

			if var_228_30 < arg_225_1.time_ and arg_225_1.time_ <= var_228_30 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_32 = arg_225_1:GetWordFromCfg(410042056)
				local var_228_33 = arg_225_1:FormatText(var_228_32.content)

				arg_225_1.text_.text = var_228_33

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_34 = 34
				local var_228_35 = utf8.len(var_228_33)
				local var_228_36 = var_228_34 <= 0 and var_228_31 or var_228_31 * (var_228_35 / var_228_34)

				if var_228_36 > 0 and var_228_31 < var_228_36 then
					arg_225_1.talkMaxDuration = var_228_36

					if var_228_36 + var_228_30 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_36 + var_228_30
					end
				end

				arg_225_1.text_.text = var_228_33
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_37 = math.max(var_228_31, arg_225_1.talkMaxDuration)

			if var_228_30 <= arg_225_1.time_ and arg_225_1.time_ < var_228_30 + var_228_37 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_30) / var_228_37

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_30 + var_228_37 and arg_225_1.time_ < var_228_30 + var_228_37 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play410042057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410042057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play410042058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10060"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos10060 = var_232_0.localPosition
				var_232_0.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10060", 3)

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
				local var_232_6 = Vector3.New(0, -400, 0)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10060, var_232_6, var_232_5)
			end

			if arg_229_1.time_ >= var_232_1 + var_232_4 and arg_229_1.time_ < var_232_1 + var_232_4 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_232_7 = arg_229_1.actors_["10060"]
			local var_232_8 = 0

			if var_232_8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps10060 == nil then
				arg_229_1.var_.actorSpriteComps10060 = var_232_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_9 = 0.034

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 and not isNil(var_232_7) then
				local var_232_10 = (arg_229_1.time_ - var_232_8) / var_232_9

				if arg_229_1.var_.actorSpriteComps10060 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_232_2 then
							if arg_229_1.isInRecall_ then
								local var_232_11 = Mathf.Lerp(iter_232_2.color.r, arg_229_1.hightColor2.r, var_232_10)
								local var_232_12 = Mathf.Lerp(iter_232_2.color.g, arg_229_1.hightColor2.g, var_232_10)
								local var_232_13 = Mathf.Lerp(iter_232_2.color.b, arg_229_1.hightColor2.b, var_232_10)

								iter_232_2.color = Color.New(var_232_11, var_232_12, var_232_13)
							else
								local var_232_14 = Mathf.Lerp(iter_232_2.color.r, 0.5, var_232_10)

								iter_232_2.color = Color.New(var_232_14, var_232_14, var_232_14)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps10060 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_232_4 then
						if arg_229_1.isInRecall_ then
							iter_232_4.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10060 = nil
			end

			local var_232_15 = 0
			local var_232_16 = 0.95

			if var_232_15 < arg_229_1.time_ and arg_229_1.time_ <= var_232_15 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_17 = arg_229_1:GetWordFromCfg(410042057)
				local var_232_18 = arg_229_1:FormatText(var_232_17.content)

				arg_229_1.text_.text = var_232_18

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_19 = 38
				local var_232_20 = utf8.len(var_232_18)
				local var_232_21 = var_232_19 <= 0 and var_232_16 or var_232_16 * (var_232_20 / var_232_19)

				if var_232_21 > 0 and var_232_16 < var_232_21 then
					arg_229_1.talkMaxDuration = var_232_21

					if var_232_21 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_21 + var_232_15
					end
				end

				arg_229_1.text_.text = var_232_18
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_22 = math.max(var_232_16, arg_229_1.talkMaxDuration)

			if var_232_15 <= arg_229_1.time_ and arg_229_1.time_ < var_232_15 + var_232_22 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_15) / var_232_22

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_15 + var_232_22 and arg_229_1.time_ < var_232_15 + var_232_22 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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

		arg_229_1:InitPlayNodeList()
	end,
	Play410042058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410042058
		arg_233_1.duration_ = 5.4

		local var_233_0 = {
			zh = 5.4,
			ja = 4.966
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
				arg_233_0:Play410042059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10060"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10060 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10060", 4)

				local var_236_2 = var_236_0.childCount

				for iter_236_0 = 0, var_236_2 - 1 do
					local var_236_3 = var_236_0:GetChild(iter_236_0)

					if var_236_3.name == "split_4" or not string.find(var_236_3.name, "split") then
						var_236_3.gameObject:SetActive(true)
					else
						var_236_3.gameObject:SetActive(false)
					end
				end
			end

			local var_236_4 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_4 then
				local var_236_5 = (arg_233_1.time_ - var_236_1) / var_236_4
				local var_236_6 = Vector3.New(390, -400, 0)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10060, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_236_7 = arg_233_1.actors_["1060"].transform
			local var_236_8 = 0

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.var_.moveOldPos1060 = var_236_7.localPosition
				var_236_7.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1060", 2)

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
				local var_236_13 = Vector3.New(-440.94, -430.8, 6.9)

				var_236_7.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1060, var_236_13, var_236_12)
			end

			if arg_233_1.time_ >= var_236_8 + var_236_11 and arg_233_1.time_ < var_236_8 + var_236_11 + arg_236_0 then
				var_236_7.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_236_14 = arg_233_1.actors_["10060"]
			local var_236_15 = 0

			if var_236_15 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 and not isNil(var_236_14) and arg_233_1.var_.actorSpriteComps10060 == nil then
				arg_233_1.var_.actorSpriteComps10060 = var_236_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_16 = 0.034

			if var_236_15 <= arg_233_1.time_ and arg_233_1.time_ < var_236_15 + var_236_16 and not isNil(var_236_14) then
				local var_236_17 = (arg_233_1.time_ - var_236_15) / var_236_16

				if arg_233_1.var_.actorSpriteComps10060 then
					for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_233_1.time_ >= var_236_15 + var_236_16 and arg_233_1.time_ < var_236_15 + var_236_16 + arg_236_0 and not isNil(var_236_14) and arg_233_1.var_.actorSpriteComps10060 then
				for iter_236_4, iter_236_5 in pairs(arg_233_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_236_5 then
						if arg_233_1.isInRecall_ then
							iter_236_5.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10060 = nil
			end

			local var_236_22 = arg_233_1.actors_["1060"]
			local var_236_23 = 0

			if var_236_23 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 and not isNil(var_236_22) and arg_233_1.var_.actorSpriteComps1060 == nil then
				arg_233_1.var_.actorSpriteComps1060 = var_236_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_24 = 0.034

			if var_236_23 <= arg_233_1.time_ and arg_233_1.time_ < var_236_23 + var_236_24 and not isNil(var_236_22) then
				local var_236_25 = (arg_233_1.time_ - var_236_23) / var_236_24

				if arg_233_1.var_.actorSpriteComps1060 then
					for iter_236_6, iter_236_7 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_233_1.time_ >= var_236_23 + var_236_24 and arg_233_1.time_ < var_236_23 + var_236_24 + arg_236_0 and not isNil(var_236_22) and arg_233_1.var_.actorSpriteComps1060 then
				for iter_236_8, iter_236_9 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_236_9 then
						if arg_233_1.isInRecall_ then
							iter_236_9.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1060 = nil
			end

			local var_236_30 = 0
			local var_236_31 = 0.55

			if var_236_30 < arg_233_1.time_ and arg_233_1.time_ <= var_236_30 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_32 = arg_233_1:FormatText(StoryNameCfg[597].name)

				arg_233_1.leftNameTxt_.text = var_236_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_33 = arg_233_1:GetWordFromCfg(410042058)
				local var_236_34 = arg_233_1:FormatText(var_236_33.content)

				arg_233_1.text_.text = var_236_34

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_35 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042058", "story_v_out_410042.awb") ~= 0 then
					local var_236_38 = manager.audio:GetVoiceLength("story_v_out_410042", "410042058", "story_v_out_410042.awb") / 1000

					if var_236_38 + var_236_30 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_38 + var_236_30
					end

					if var_236_33.prefab_name ~= "" and arg_233_1.actors_[var_236_33.prefab_name] ~= nil then
						local var_236_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_33.prefab_name].transform, "story_v_out_410042", "410042058", "story_v_out_410042.awb")

						arg_233_1:RecordAudio("410042058", var_236_39)
						arg_233_1:RecordAudio("410042058", var_236_39)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_410042", "410042058", "story_v_out_410042.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_410042", "410042058", "story_v_out_410042.awb")
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
				actorName = "1060",
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
	Play410042059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410042059
		arg_237_1.duration_ = 8.2

		local var_237_0 = {
			zh = 6.3,
			ja = 8.2
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
				arg_237_0:Play410042060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1060"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1060 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1060", 2)

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
				local var_240_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1060, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_240_7 = arg_237_1.actors_["1060"]
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps1060 == nil then
				arg_237_1.var_.actorSpriteComps1060 = var_240_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_9 = 0.034

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_9 and not isNil(var_240_7) then
				local var_240_10 = (arg_237_1.time_ - var_240_8) / var_240_9

				if arg_237_1.var_.actorSpriteComps1060 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								local var_240_11 = Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor1.r, var_240_10)
								local var_240_12 = Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor1.g, var_240_10)
								local var_240_13 = Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor1.b, var_240_10)

								iter_240_2.color = Color.New(var_240_11, var_240_12, var_240_13)
							else
								local var_240_14 = Mathf.Lerp(iter_240_2.color.r, 1, var_240_10)

								iter_240_2.color = Color.New(var_240_14, var_240_14, var_240_14)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_8 + var_240_9 and arg_237_1.time_ < var_240_8 + var_240_9 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps1060 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_240_4 then
						if arg_237_1.isInRecall_ then
							iter_240_4.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps1060 = nil
			end

			local var_240_15 = arg_237_1.actors_["10060"]
			local var_240_16 = 0

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps10060 == nil then
				arg_237_1.var_.actorSpriteComps10060 = var_240_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_17 = 0.034

			if var_240_16 <= arg_237_1.time_ and arg_237_1.time_ < var_240_16 + var_240_17 and not isNil(var_240_15) then
				local var_240_18 = (arg_237_1.time_ - var_240_16) / var_240_17

				if arg_237_1.var_.actorSpriteComps10060 then
					for iter_240_5, iter_240_6 in pairs(arg_237_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_240_6 then
							if arg_237_1.isInRecall_ then
								local var_240_19 = Mathf.Lerp(iter_240_6.color.r, arg_237_1.hightColor2.r, var_240_18)
								local var_240_20 = Mathf.Lerp(iter_240_6.color.g, arg_237_1.hightColor2.g, var_240_18)
								local var_240_21 = Mathf.Lerp(iter_240_6.color.b, arg_237_1.hightColor2.b, var_240_18)

								iter_240_6.color = Color.New(var_240_19, var_240_20, var_240_21)
							else
								local var_240_22 = Mathf.Lerp(iter_240_6.color.r, 0.5, var_240_18)

								iter_240_6.color = Color.New(var_240_22, var_240_22, var_240_22)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_16 + var_240_17 and arg_237_1.time_ < var_240_16 + var_240_17 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps10060 then
				for iter_240_7, iter_240_8 in pairs(arg_237_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_240_8 then
						if arg_237_1.isInRecall_ then
							iter_240_8.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10060 = nil
			end

			local var_240_23 = 0
			local var_240_24 = 0.85

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_25 = arg_237_1:FormatText(StoryNameCfg[584].name)

				arg_237_1.leftNameTxt_.text = var_240_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_26 = arg_237_1:GetWordFromCfg(410042059)
				local var_240_27 = arg_237_1:FormatText(var_240_26.content)

				arg_237_1.text_.text = var_240_27

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_28 = 34
				local var_240_29 = utf8.len(var_240_27)
				local var_240_30 = var_240_28 <= 0 and var_240_24 or var_240_24 * (var_240_29 / var_240_28)

				if var_240_30 > 0 and var_240_24 < var_240_30 then
					arg_237_1.talkMaxDuration = var_240_30

					if var_240_30 + var_240_23 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_30 + var_240_23
					end
				end

				arg_237_1.text_.text = var_240_27
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042059", "story_v_out_410042.awb") ~= 0 then
					local var_240_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042059", "story_v_out_410042.awb") / 1000

					if var_240_31 + var_240_23 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_31 + var_240_23
					end

					if var_240_26.prefab_name ~= "" and arg_237_1.actors_[var_240_26.prefab_name] ~= nil then
						local var_240_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_26.prefab_name].transform, "story_v_out_410042", "410042059", "story_v_out_410042.awb")

						arg_237_1:RecordAudio("410042059", var_240_32)
						arg_237_1:RecordAudio("410042059", var_240_32)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410042", "410042059", "story_v_out_410042.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410042", "410042059", "story_v_out_410042.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_33 = math.max(var_240_24, arg_237_1.talkMaxDuration)

			if var_240_23 <= arg_237_1.time_ and arg_237_1.time_ < var_240_23 + var_240_33 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_23) / var_240_33

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_23 + var_240_33 and arg_237_1.time_ < var_240_23 + var_240_33 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410042060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410042060
		arg_241_1.duration_ = 2.57

		local var_241_0 = {
			zh = 1.233,
			ja = 2.566
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play410042061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10060"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos10060 = var_244_0.localPosition
				var_244_0.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("10060", 4)

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
				local var_244_6 = Vector3.New(390, -400, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10060, var_244_6, var_244_5)
			end

			if arg_241_1.time_ >= var_244_1 + var_244_4 and arg_241_1.time_ < var_244_1 + var_244_4 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_244_7 = arg_241_1.actors_["10060"]
			local var_244_8 = 0

			if var_244_8 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.actorSpriteComps10060 == nil then
				arg_241_1.var_.actorSpriteComps10060 = var_244_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_9 = 0.034

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_9 and not isNil(var_244_7) then
				local var_244_10 = (arg_241_1.time_ - var_244_8) / var_244_9

				if arg_241_1.var_.actorSpriteComps10060 then
					for iter_244_1, iter_244_2 in pairs(arg_241_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_244_2 then
							if arg_241_1.isInRecall_ then
								local var_244_11 = Mathf.Lerp(iter_244_2.color.r, arg_241_1.hightColor1.r, var_244_10)
								local var_244_12 = Mathf.Lerp(iter_244_2.color.g, arg_241_1.hightColor1.g, var_244_10)
								local var_244_13 = Mathf.Lerp(iter_244_2.color.b, arg_241_1.hightColor1.b, var_244_10)

								iter_244_2.color = Color.New(var_244_11, var_244_12, var_244_13)
							else
								local var_244_14 = Mathf.Lerp(iter_244_2.color.r, 1, var_244_10)

								iter_244_2.color = Color.New(var_244_14, var_244_14, var_244_14)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_8 + var_244_9 and arg_241_1.time_ < var_244_8 + var_244_9 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.actorSpriteComps10060 then
				for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_244_4 then
						if arg_241_1.isInRecall_ then
							iter_244_4.color = arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_244_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps10060 = nil
			end

			local var_244_15 = arg_241_1.actors_["1060"]
			local var_244_16 = 0

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.actorSpriteComps1060 == nil then
				arg_241_1.var_.actorSpriteComps1060 = var_244_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_17 = 0.034

			if var_244_16 <= arg_241_1.time_ and arg_241_1.time_ < var_244_16 + var_244_17 and not isNil(var_244_15) then
				local var_244_18 = (arg_241_1.time_ - var_244_16) / var_244_17

				if arg_241_1.var_.actorSpriteComps1060 then
					for iter_244_5, iter_244_6 in pairs(arg_241_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_244_6 then
							if arg_241_1.isInRecall_ then
								local var_244_19 = Mathf.Lerp(iter_244_6.color.r, arg_241_1.hightColor2.r, var_244_18)
								local var_244_20 = Mathf.Lerp(iter_244_6.color.g, arg_241_1.hightColor2.g, var_244_18)
								local var_244_21 = Mathf.Lerp(iter_244_6.color.b, arg_241_1.hightColor2.b, var_244_18)

								iter_244_6.color = Color.New(var_244_19, var_244_20, var_244_21)
							else
								local var_244_22 = Mathf.Lerp(iter_244_6.color.r, 0.5, var_244_18)

								iter_244_6.color = Color.New(var_244_22, var_244_22, var_244_22)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_16 + var_244_17 and arg_241_1.time_ < var_244_16 + var_244_17 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.actorSpriteComps1060 then
				for iter_244_7, iter_244_8 in pairs(arg_241_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_244_8 then
						if arg_241_1.isInRecall_ then
							iter_244_8.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps1060 = nil
			end

			local var_244_23 = 0
			local var_244_24 = 0.175

			if var_244_23 < arg_241_1.time_ and arg_241_1.time_ <= var_244_23 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_25 = arg_241_1:FormatText(StoryNameCfg[597].name)

				arg_241_1.leftNameTxt_.text = var_244_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_26 = arg_241_1:GetWordFromCfg(410042060)
				local var_244_27 = arg_241_1:FormatText(var_244_26.content)

				arg_241_1.text_.text = var_244_27

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_28 = 7
				local var_244_29 = utf8.len(var_244_27)
				local var_244_30 = var_244_28 <= 0 and var_244_24 or var_244_24 * (var_244_29 / var_244_28)

				if var_244_30 > 0 and var_244_24 < var_244_30 then
					arg_241_1.talkMaxDuration = var_244_30

					if var_244_30 + var_244_23 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_30 + var_244_23
					end
				end

				arg_241_1.text_.text = var_244_27
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042060", "story_v_out_410042.awb") ~= 0 then
					local var_244_31 = manager.audio:GetVoiceLength("story_v_out_410042", "410042060", "story_v_out_410042.awb") / 1000

					if var_244_31 + var_244_23 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_31 + var_244_23
					end

					if var_244_26.prefab_name ~= "" and arg_241_1.actors_[var_244_26.prefab_name] ~= nil then
						local var_244_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_26.prefab_name].transform, "story_v_out_410042", "410042060", "story_v_out_410042.awb")

						arg_241_1:RecordAudio("410042060", var_244_32)
						arg_241_1:RecordAudio("410042060", var_244_32)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410042", "410042060", "story_v_out_410042.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410042", "410042060", "story_v_out_410042.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_33 = math.max(var_244_24, arg_241_1.talkMaxDuration)

			if var_244_23 <= arg_241_1.time_ and arg_241_1.time_ < var_244_23 + var_244_33 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_23) / var_244_33

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_23 + var_244_33 and arg_241_1.time_ < var_244_23 + var_244_33 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play410042061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410042061
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play410042062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["10060"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps10060 == nil then
				arg_245_1.var_.actorSpriteComps10060 = var_248_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_2 = 0.034

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.actorSpriteComps10060 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								local var_248_4 = Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor2.r, var_248_3)
								local var_248_5 = Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor2.g, var_248_3)
								local var_248_6 = Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor2.b, var_248_3)

								iter_248_1.color = Color.New(var_248_4, var_248_5, var_248_6)
							else
								local var_248_7 = Mathf.Lerp(iter_248_1.color.r, 0.5, var_248_3)

								iter_248_1.color = Color.New(var_248_7, var_248_7, var_248_7)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps10060 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_248_3 then
						if arg_245_1.isInRecall_ then
							iter_248_3.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps10060 = nil
			end

			local var_248_8 = 0
			local var_248_9 = 1.25

			if var_248_8 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_10 = arg_245_1:GetWordFromCfg(410042061)
				local var_248_11 = arg_245_1:FormatText(var_248_10.content)

				arg_245_1.text_.text = var_248_11

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_12 = 50
				local var_248_13 = utf8.len(var_248_11)
				local var_248_14 = var_248_12 <= 0 and var_248_9 or var_248_9 * (var_248_13 / var_248_12)

				if var_248_14 > 0 and var_248_9 < var_248_14 then
					arg_245_1.talkMaxDuration = var_248_14

					if var_248_14 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_14 + var_248_8
					end
				end

				arg_245_1.text_.text = var_248_11
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_15 = math.max(var_248_9, arg_245_1.talkMaxDuration)

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_15 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_8) / var_248_15

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_8 + var_248_15 and arg_245_1.time_ < var_248_8 + var_248_15 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play410042062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410042062
		arg_249_1.duration_ = 7.27

		local var_249_0 = {
			zh = 3.566,
			ja = 7.266
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
			arg_249_1.auto_ = false
		end

		function arg_249_1.playNext_(arg_251_0)
			arg_249_1.onStoryFinished_()
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10060"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos10060 = var_252_0.localPosition
				var_252_0.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10060", 3)

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
				local var_252_6 = Vector3.New(0, -400, 0)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10060, var_252_6, var_252_5)
			end

			if arg_249_1.time_ >= var_252_1 + var_252_4 and arg_249_1.time_ < var_252_1 + var_252_4 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_252_7 = arg_249_1.actors_["10060"]
			local var_252_8 = 0

			if var_252_8 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps10060 == nil then
				arg_249_1.var_.actorSpriteComps10060 = var_252_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_9 = 0.034

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_9 and not isNil(var_252_7) then
				local var_252_10 = (arg_249_1.time_ - var_252_8) / var_252_9

				if arg_249_1.var_.actorSpriteComps10060 then
					for iter_252_1, iter_252_2 in pairs(arg_249_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_249_1.time_ >= var_252_8 + var_252_9 and arg_249_1.time_ < var_252_8 + var_252_9 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps10060 then
				for iter_252_3, iter_252_4 in pairs(arg_249_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_252_4 then
						if arg_249_1.isInRecall_ then
							iter_252_4.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps10060 = nil
			end

			local var_252_15 = arg_249_1.actors_["1060"].transform
			local var_252_16 = 0

			if var_252_16 < arg_249_1.time_ and arg_249_1.time_ <= var_252_16 + arg_252_0 then
				arg_249_1.var_.moveOldPos1060 = var_252_15.localPosition
				var_252_15.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1060", 7)

				local var_252_17 = var_252_15.childCount

				for iter_252_5 = 0, var_252_17 - 1 do
					local var_252_18 = var_252_15:GetChild(iter_252_5)

					if var_252_18.name == "" or not string.find(var_252_18.name, "split") then
						var_252_18.gameObject:SetActive(true)
					else
						var_252_18.gameObject:SetActive(false)
					end
				end
			end

			local var_252_19 = 0.001

			if var_252_16 <= arg_249_1.time_ and arg_249_1.time_ < var_252_16 + var_252_19 then
				local var_252_20 = (arg_249_1.time_ - var_252_16) / var_252_19
				local var_252_21 = Vector3.New(0, -2000, -40)

				var_252_15.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1060, var_252_21, var_252_20)
			end

			if arg_249_1.time_ >= var_252_16 + var_252_19 and arg_249_1.time_ < var_252_16 + var_252_19 + arg_252_0 then
				var_252_15.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_252_22 = arg_249_1.actors_["1060"]
			local var_252_23 = 0

			if var_252_23 < arg_249_1.time_ and arg_249_1.time_ <= var_252_23 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.actorSpriteComps1060 == nil then
				arg_249_1.var_.actorSpriteComps1060 = var_252_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_24 = 0.034

			if var_252_23 <= arg_249_1.time_ and arg_249_1.time_ < var_252_23 + var_252_24 and not isNil(var_252_22) then
				local var_252_25 = (arg_249_1.time_ - var_252_23) / var_252_24

				if arg_249_1.var_.actorSpriteComps1060 then
					for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_252_7 then
							if arg_249_1.isInRecall_ then
								local var_252_26 = Mathf.Lerp(iter_252_7.color.r, arg_249_1.hightColor2.r, var_252_25)
								local var_252_27 = Mathf.Lerp(iter_252_7.color.g, arg_249_1.hightColor2.g, var_252_25)
								local var_252_28 = Mathf.Lerp(iter_252_7.color.b, arg_249_1.hightColor2.b, var_252_25)

								iter_252_7.color = Color.New(var_252_26, var_252_27, var_252_28)
							else
								local var_252_29 = Mathf.Lerp(iter_252_7.color.r, 0.5, var_252_25)

								iter_252_7.color = Color.New(var_252_29, var_252_29, var_252_29)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_23 + var_252_24 and arg_249_1.time_ < var_252_23 + var_252_24 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.actorSpriteComps1060 then
				for iter_252_8, iter_252_9 in pairs(arg_249_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_252_9 then
						if arg_249_1.isInRecall_ then
							iter_252_9.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1060 = nil
			end

			local var_252_30 = 0
			local var_252_31 = 0.45

			if var_252_30 < arg_249_1.time_ and arg_249_1.time_ <= var_252_30 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_32 = arg_249_1:FormatText(StoryNameCfg[597].name)

				arg_249_1.leftNameTxt_.text = var_252_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_33 = arg_249_1:GetWordFromCfg(410042062)
				local var_252_34 = arg_249_1:FormatText(var_252_33.content)

				arg_249_1.text_.text = var_252_34

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_35 = 18
				local var_252_36 = utf8.len(var_252_34)
				local var_252_37 = var_252_35 <= 0 and var_252_31 or var_252_31 * (var_252_36 / var_252_35)

				if var_252_37 > 0 and var_252_31 < var_252_37 then
					arg_249_1.talkMaxDuration = var_252_37

					if var_252_37 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_37 + var_252_30
					end
				end

				arg_249_1.text_.text = var_252_34
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410042", "410042062", "story_v_out_410042.awb") ~= 0 then
					local var_252_38 = manager.audio:GetVoiceLength("story_v_out_410042", "410042062", "story_v_out_410042.awb") / 1000

					if var_252_38 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_38 + var_252_30
					end

					if var_252_33.prefab_name ~= "" and arg_249_1.actors_[var_252_33.prefab_name] ~= nil then
						local var_252_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_33.prefab_name].transform, "story_v_out_410042", "410042062", "story_v_out_410042.awb")

						arg_249_1:RecordAudio("410042062", var_252_39)
						arg_249_1:RecordAudio("410042062", var_252_39)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410042", "410042062", "story_v_out_410042.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410042", "410042062", "story_v_out_410042.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_40 = math.max(var_252_31, arg_249_1.talkMaxDuration)

			if var_252_30 <= arg_249_1.time_ and arg_249_1.time_ < var_252_30 + var_252_40 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_30) / var_252_40

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_30 + var_252_40 and arg_249_1.time_ < var_252_30 + var_252_40 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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
				actorName = "1060",
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
	assets = {
		"TextureConfig/Background/L03f"
	},
	voices = {
		"story_v_out_410042.awb"
	}
}
