return {
	Play117032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 117032001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play117032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I08a"

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
				local var_4_5 = arg_1_1.bgs_.I08a

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
					if iter_4_0 ~= "I08a" then
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
			local var_4_23 = 0.5

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "", "", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("", "")

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

			local var_4_28 = 2.03333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_7_story_firehouse", "bgm_activity_1_7_story_firehouse", "bgm_activity_1_7_story_firehouse.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_7_story_firehouse", "bgm_activity_1_7_story_firehouse")

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
			local var_4_35 = 0.725

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

				local var_4_37 = arg_1_1:GetWordFromCfg(117032001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 29
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
	Play117032002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 117032002
		arg_9_1.duration_ = 6.73

		local var_9_0 = {
			zh = 3.366,
			ja = 6.733
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
				arg_9_0:Play117032003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1033"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

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

			local var_12_4 = arg_9_1.actors_["1033"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos1033 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1033", 4)

				local var_12_6 = var_12_4.childCount

				for iter_12_2 = 0, var_12_6 - 1 do
					local var_12_7 = var_12_4:GetChild(iter_12_2)

					if var_12_7.name == "split_6" or not string.find(var_12_7.name, "split") then
						var_12_7.gameObject:SetActive(true)
					else
						var_12_7.gameObject:SetActive(false)
					end
				end
			end

			local var_12_8 = 0.001

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_5) / var_12_8
				local var_12_10 = Vector3.New(390, -420, 0)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1033, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(390, -420, 0)
			end

			local var_12_11 = arg_9_1.actors_["1033"]
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				local var_12_13 = var_12_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_13 then
					arg_9_1.var_.alphaOldValue1033 = var_12_13.alpha
					arg_9_1.var_.characterEffect1033 = var_12_13
				end

				arg_9_1.var_.alphaOldValue1033 = 0
			end

			local var_12_14 = 0.333333333333333

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_14 then
				local var_12_15 = (arg_9_1.time_ - var_12_12) / var_12_14
				local var_12_16 = Mathf.Lerp(arg_9_1.var_.alphaOldValue1033, 1, var_12_15)

				if arg_9_1.var_.characterEffect1033 then
					arg_9_1.var_.characterEffect1033.alpha = var_12_16
				end
			end

			if arg_9_1.time_ >= var_12_12 + var_12_14 and arg_9_1.time_ < var_12_12 + var_12_14 + arg_12_0 and arg_9_1.var_.characterEffect1033 then
				arg_9_1.var_.characterEffect1033.alpha = 1
			end

			local var_12_17 = 0
			local var_12_18 = 0.325

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_19 = arg_9_1:FormatText(StoryNameCfg[236].name)

				arg_9_1.leftNameTxt_.text = var_12_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_20 = arg_9_1:GetWordFromCfg(117032002)
				local var_12_21 = arg_9_1:FormatText(var_12_20.content)

				arg_9_1.text_.text = var_12_21

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_22 = 13
				local var_12_23 = utf8.len(var_12_21)
				local var_12_24 = var_12_22 <= 0 and var_12_18 or var_12_18 * (var_12_23 / var_12_22)

				if var_12_24 > 0 and var_12_18 < var_12_24 then
					arg_9_1.talkMaxDuration = var_12_24

					if var_12_24 + var_12_17 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_24 + var_12_17
					end
				end

				arg_9_1.text_.text = var_12_21
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032002", "story_v_out_117032.awb") ~= 0 then
					local var_12_25 = manager.audio:GetVoiceLength("story_v_out_117032", "117032002", "story_v_out_117032.awb") / 1000

					if var_12_25 + var_12_17 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_25 + var_12_17
					end

					if var_12_20.prefab_name ~= "" and arg_9_1.actors_[var_12_20.prefab_name] ~= nil then
						local var_12_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_20.prefab_name].transform, "story_v_out_117032", "117032002", "story_v_out_117032.awb")

						arg_9_1:RecordAudio("117032002", var_12_26)
						arg_9_1:RecordAudio("117032002", var_12_26)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_117032", "117032002", "story_v_out_117032.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_117032", "117032002", "story_v_out_117032.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_27 = math.max(var_12_18, arg_9_1.talkMaxDuration)

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_27 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_17) / var_12_27

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_17 + var_12_27 and arg_9_1.time_ < var_12_17 + var_12_27 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play117032003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 117032003
		arg_13_1.duration_ = 1.73

		local var_13_0 = {
			zh = 1.733,
			ja = 1.166
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
				arg_13_0:Play117032004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1132"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1132")

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

			local var_16_4 = arg_13_1.actors_["1132"].transform
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.var_.moveOldPos1132 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1132", 2)

				local var_16_6 = var_16_4.childCount

				for iter_16_2 = 0, var_16_6 - 1 do
					local var_16_7 = var_16_4:GetChild(iter_16_2)

					if var_16_7.name == "split_6" or not string.find(var_16_7.name, "split") then
						var_16_7.gameObject:SetActive(true)
					else
						var_16_7.gameObject:SetActive(false)
					end
				end
			end

			local var_16_8 = 0.001

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_5) / var_16_8
				local var_16_10 = Vector3.New(-390, -413, -185)

				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1132, var_16_10, var_16_9)
			end

			if arg_13_1.time_ >= var_16_5 + var_16_8 and arg_13_1.time_ < var_16_5 + var_16_8 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_16_11 = arg_13_1.actors_["1132"]
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				local var_16_13 = var_16_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_13 then
					arg_13_1.var_.alphaOldValue1132 = var_16_13.alpha
					arg_13_1.var_.characterEffect1132 = var_16_13
				end

				arg_13_1.var_.alphaOldValue1132 = 0
			end

			local var_16_14 = 0.333333333333333

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_14 then
				local var_16_15 = (arg_13_1.time_ - var_16_12) / var_16_14
				local var_16_16 = Mathf.Lerp(arg_13_1.var_.alphaOldValue1132, 1, var_16_15)

				if arg_13_1.var_.characterEffect1132 then
					arg_13_1.var_.characterEffect1132.alpha = var_16_16
				end
			end

			if arg_13_1.time_ >= var_16_12 + var_16_14 and arg_13_1.time_ < var_16_12 + var_16_14 + arg_16_0 and arg_13_1.var_.characterEffect1132 then
				arg_13_1.var_.characterEffect1132.alpha = 1
			end

			local var_16_17 = arg_13_1.actors_["1132"]
			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 and not isNil(var_16_17) and arg_13_1.var_.actorSpriteComps1132 == nil then
				arg_13_1.var_.actorSpriteComps1132 = var_16_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_19 = 0.2

			if var_16_18 <= arg_13_1.time_ and arg_13_1.time_ < var_16_18 + var_16_19 and not isNil(var_16_17) then
				local var_16_20 = (arg_13_1.time_ - var_16_18) / var_16_19

				if arg_13_1.var_.actorSpriteComps1132 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								local var_16_21 = Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor1.r, var_16_20)
								local var_16_22 = Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor1.g, var_16_20)
								local var_16_23 = Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor1.b, var_16_20)

								iter_16_4.color = Color.New(var_16_21, var_16_22, var_16_23)
							else
								local var_16_24 = Mathf.Lerp(iter_16_4.color.r, 1, var_16_20)

								iter_16_4.color = Color.New(var_16_24, var_16_24, var_16_24)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_18 + var_16_19 and arg_13_1.time_ < var_16_18 + var_16_19 + arg_16_0 and not isNil(var_16_17) and arg_13_1.var_.actorSpriteComps1132 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_16_6 then
						if arg_13_1.isInRecall_ then
							iter_16_6.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1132 = nil
			end

			local var_16_25 = arg_13_1.actors_["1033"]
			local var_16_26 = 0

			if var_16_26 < arg_13_1.time_ and arg_13_1.time_ <= var_16_26 + arg_16_0 and not isNil(var_16_25) and arg_13_1.var_.actorSpriteComps1033 == nil then
				arg_13_1.var_.actorSpriteComps1033 = var_16_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_27 = 0.2

			if var_16_26 <= arg_13_1.time_ and arg_13_1.time_ < var_16_26 + var_16_27 and not isNil(var_16_25) then
				local var_16_28 = (arg_13_1.time_ - var_16_26) / var_16_27

				if arg_13_1.var_.actorSpriteComps1033 then
					for iter_16_7, iter_16_8 in pairs(arg_13_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_16_8 then
							if arg_13_1.isInRecall_ then
								local var_16_29 = Mathf.Lerp(iter_16_8.color.r, arg_13_1.hightColor2.r, var_16_28)
								local var_16_30 = Mathf.Lerp(iter_16_8.color.g, arg_13_1.hightColor2.g, var_16_28)
								local var_16_31 = Mathf.Lerp(iter_16_8.color.b, arg_13_1.hightColor2.b, var_16_28)

								iter_16_8.color = Color.New(var_16_29, var_16_30, var_16_31)
							else
								local var_16_32 = Mathf.Lerp(iter_16_8.color.r, 0.5, var_16_28)

								iter_16_8.color = Color.New(var_16_32, var_16_32, var_16_32)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_26 + var_16_27 and arg_13_1.time_ < var_16_26 + var_16_27 + arg_16_0 and not isNil(var_16_25) and arg_13_1.var_.actorSpriteComps1033 then
				for iter_16_9, iter_16_10 in pairs(arg_13_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_16_10 then
						if arg_13_1.isInRecall_ then
							iter_16_10.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1033 = nil
			end

			local var_16_33 = 0
			local var_16_34 = 0.125

			if var_16_33 < arg_13_1.time_ and arg_13_1.time_ <= var_16_33 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_35 = arg_13_1:FormatText(StoryNameCfg[61].name)

				arg_13_1.leftNameTxt_.text = var_16_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_36 = arg_13_1:GetWordFromCfg(117032003)
				local var_16_37 = arg_13_1:FormatText(var_16_36.content)

				arg_13_1.text_.text = var_16_37

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_38 = 5
				local var_16_39 = utf8.len(var_16_37)
				local var_16_40 = var_16_38 <= 0 and var_16_34 or var_16_34 * (var_16_39 / var_16_38)

				if var_16_40 > 0 and var_16_34 < var_16_40 then
					arg_13_1.talkMaxDuration = var_16_40

					if var_16_40 + var_16_33 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_40 + var_16_33
					end
				end

				arg_13_1.text_.text = var_16_37
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032003", "story_v_out_117032.awb") ~= 0 then
					local var_16_41 = manager.audio:GetVoiceLength("story_v_out_117032", "117032003", "story_v_out_117032.awb") / 1000

					if var_16_41 + var_16_33 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_41 + var_16_33
					end

					if var_16_36.prefab_name ~= "" and arg_13_1.actors_[var_16_36.prefab_name] ~= nil then
						local var_16_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_36.prefab_name].transform, "story_v_out_117032", "117032003", "story_v_out_117032.awb")

						arg_13_1:RecordAudio("117032003", var_16_42)
						arg_13_1:RecordAudio("117032003", var_16_42)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_117032", "117032003", "story_v_out_117032.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_117032", "117032003", "story_v_out_117032.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_43 = math.max(var_16_34, arg_13_1.talkMaxDuration)

			if var_16_33 <= arg_13_1.time_ and arg_13_1.time_ < var_16_33 + var_16_43 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_33) / var_16_43

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_33 + var_16_43 and arg_13_1.time_ < var_16_33 + var_16_43 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
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
	Play117032004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 117032004
		arg_17_1.duration_ = 9.67

		local var_17_0 = {
			zh = 6.366,
			ja = 9.666
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
				arg_17_0:Play117032005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1132"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1132 == nil then
				arg_17_1.var_.actorSpriteComps1132 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps1132 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 0.5, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1132 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1132 = nil
			end

			local var_20_8 = arg_17_1.actors_["1033"]
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1033 == nil then
				arg_17_1.var_.actorSpriteComps1033 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_10 = 0.2

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_10 and not isNil(var_20_8) then
				local var_20_11 = (arg_17_1.time_ - var_20_9) / var_20_10

				if arg_17_1.var_.actorSpriteComps1033 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								local var_20_12 = Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor1.r, var_20_11)
								local var_20_13 = Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor1.g, var_20_11)
								local var_20_14 = Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor1.b, var_20_11)

								iter_20_5.color = Color.New(var_20_12, var_20_13, var_20_14)
							else
								local var_20_15 = Mathf.Lerp(iter_20_5.color.r, 1, var_20_11)

								iter_20_5.color = Color.New(var_20_15, var_20_15, var_20_15)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_9 + var_20_10 and arg_17_1.time_ < var_20_9 + var_20_10 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1033 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_20_7 then
						if arg_17_1.isInRecall_ then
							iter_20_7.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1033 = nil
			end

			local var_20_16 = 0
			local var_20_17 = 0.65

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_18 = arg_17_1:FormatText(StoryNameCfg[236].name)

				arg_17_1.leftNameTxt_.text = var_20_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_19 = arg_17_1:GetWordFromCfg(117032004)
				local var_20_20 = arg_17_1:FormatText(var_20_19.content)

				arg_17_1.text_.text = var_20_20

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_21 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032004", "story_v_out_117032.awb") ~= 0 then
					local var_20_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032004", "story_v_out_117032.awb") / 1000

					if var_20_24 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_24 + var_20_16
					end

					if var_20_19.prefab_name ~= "" and arg_17_1.actors_[var_20_19.prefab_name] ~= nil then
						local var_20_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_19.prefab_name].transform, "story_v_out_117032", "117032004", "story_v_out_117032.awb")

						arg_17_1:RecordAudio("117032004", var_20_25)
						arg_17_1:RecordAudio("117032004", var_20_25)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_117032", "117032004", "story_v_out_117032.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_117032", "117032004", "story_v_out_117032.awb")
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
	Play117032005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 117032005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play117032006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1033"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1033 == nil then
				arg_21_1.var_.actorSpriteComps1033 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps1033 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1033 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1033 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.775

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(117032005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_12 = 31
				local var_24_13 = utf8.len(var_24_11)
				local var_24_14 = var_24_12 <= 0 and var_24_9 or var_24_9 * (var_24_13 / var_24_12)

				if var_24_14 > 0 and var_24_9 < var_24_14 then
					arg_21_1.talkMaxDuration = var_24_14

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_15 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_15 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_15

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_15 and arg_21_1.time_ < var_24_8 + var_24_15 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play117032006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 117032006
		arg_25_1.duration_ = 7.57

		local var_25_0 = {
			zh = 6.633,
			ja = 7.566
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
				arg_25_0:Play117032007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1132"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1132 == nil then
				arg_25_1.var_.actorSpriteComps1132 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps1132 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1132 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1132 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 0.6

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_10 = arg_25_1:FormatText(StoryNameCfg[61].name)

				arg_25_1.leftNameTxt_.text = var_28_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_11 = arg_25_1:GetWordFromCfg(117032006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 24
				local var_28_14 = utf8.len(var_28_12)
				local var_28_15 = var_28_13 <= 0 and var_28_9 or var_28_9 * (var_28_14 / var_28_13)

				if var_28_15 > 0 and var_28_9 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032006", "story_v_out_117032.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_out_117032", "117032006", "story_v_out_117032.awb") / 1000

					if var_28_16 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_8
					end

					if var_28_11.prefab_name ~= "" and arg_25_1.actors_[var_28_11.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_11.prefab_name].transform, "story_v_out_117032", "117032006", "story_v_out_117032.awb")

						arg_25_1:RecordAudio("117032006", var_28_17)
						arg_25_1:RecordAudio("117032006", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_117032", "117032006", "story_v_out_117032.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_117032", "117032006", "story_v_out_117032.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_18 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_18

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_18 and arg_25_1.time_ < var_28_8 + var_28_18 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play117032007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 117032007
		arg_29_1.duration_ = 10.17

		local var_29_0 = {
			zh = 8.733,
			ja = 10.166
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
				arg_29_0:Play117032008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.75

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[61].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(117032007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 30
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032007", "story_v_out_117032.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032007", "story_v_out_117032.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_117032", "117032007", "story_v_out_117032.awb")

						arg_29_1:RecordAudio("117032007", var_32_9)
						arg_29_1:RecordAudio("117032007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_117032", "117032007", "story_v_out_117032.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_117032", "117032007", "story_v_out_117032.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play117032008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 117032008
		arg_33_1.duration_ = 9.03

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play117032009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_1 = 2

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_1 then
				local var_36_2 = (arg_33_1.time_ - var_36_0) / var_36_1
				local var_36_3 = Color.New(0, 0, 0)

				var_36_3.a = Mathf.Lerp(0, 1, var_36_2)
				arg_33_1.mask_.color = var_36_3
			end

			if arg_33_1.time_ >= var_36_0 + var_36_1 and arg_33_1.time_ < var_36_0 + var_36_1 + arg_36_0 then
				local var_36_4 = Color.New(0, 0, 0)

				var_36_4.a = 1
				arg_33_1.mask_.color = var_36_4
			end

			local var_36_5 = 2

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_6 = 2.033333

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6
				local var_36_8 = Color.New(0, 0, 0)

				var_36_8.a = Mathf.Lerp(1, 0, var_36_7)
				arg_33_1.mask_.color = var_36_8
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 then
				local var_36_9 = Color.New(0, 0, 0)
				local var_36_10 = 0

				arg_33_1.mask_.enabled = false
				var_36_9.a = var_36_10
				arg_33_1.mask_.color = var_36_9
			end

			local var_36_11 = arg_33_1.actors_["1132"]
			local var_36_12 = 0

			if var_36_12 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 and not isNil(var_36_11) and arg_33_1.var_.actorSpriteComps1132 == nil then
				arg_33_1.var_.actorSpriteComps1132 = var_36_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_13 = 0.2

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_13 and not isNil(var_36_11) then
				local var_36_14 = (arg_33_1.time_ - var_36_12) / var_36_13

				if arg_33_1.var_.actorSpriteComps1132 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_15 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor2.r, var_36_14)
								local var_36_16 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor2.g, var_36_14)
								local var_36_17 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor2.b, var_36_14)

								iter_36_1.color = Color.New(var_36_15, var_36_16, var_36_17)
							else
								local var_36_18 = Mathf.Lerp(iter_36_1.color.r, 0.5, var_36_14)

								iter_36_1.color = Color.New(var_36_18, var_36_18, var_36_18)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_12 + var_36_13 and arg_33_1.time_ < var_36_12 + var_36_13 + arg_36_0 and not isNil(var_36_11) and arg_33_1.var_.actorSpriteComps1132 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1132 = nil
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_19 = 4.033333
			local var_36_20 = 0.575

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_21 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_21:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_22 = arg_33_1:GetWordFromCfg(117032008)
				local var_36_23 = arg_33_1:FormatText(var_36_22.content)

				arg_33_1.text_.text = var_36_23

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_24 = 23
				local var_36_25 = utf8.len(var_36_23)
				local var_36_26 = var_36_24 <= 0 and var_36_20 or var_36_20 * (var_36_25 / var_36_24)

				if var_36_26 > 0 and var_36_20 < var_36_26 then
					arg_33_1.talkMaxDuration = var_36_26
					var_36_19 = var_36_19 + 0.3

					if var_36_26 + var_36_19 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_26 + var_36_19
					end
				end

				arg_33_1.text_.text = var_36_23
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_27 = var_36_19 + 0.3
			local var_36_28 = math.max(var_36_20, arg_33_1.talkMaxDuration)

			if var_36_27 <= arg_33_1.time_ and arg_33_1.time_ < var_36_27 + var_36_28 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_27) / var_36_28

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_27 + var_36_28 and arg_33_1.time_ < var_36_27 + var_36_28 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play117032009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 117032009
		arg_39_1.duration_ = 7.17

		local var_39_0 = {
			zh = 5,
			ja = 7.166
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play117032010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1033"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1033 == nil then
				arg_39_1.var_.actorSpriteComps1033 = var_42_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_2 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.actorSpriteComps1033 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								local var_42_4 = Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor1.r, var_42_3)
								local var_42_5 = Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor1.g, var_42_3)
								local var_42_6 = Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor1.b, var_42_3)

								iter_42_1.color = Color.New(var_42_4, var_42_5, var_42_6)
							else
								local var_42_7 = Mathf.Lerp(iter_42_1.color.r, 1, var_42_3)

								iter_42_1.color = Color.New(var_42_7, var_42_7, var_42_7)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1033 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_42_3 then
						if arg_39_1.isInRecall_ then
							iter_42_3.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_42_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps1033 = nil
			end

			local var_42_8 = 0
			local var_42_9 = 0.7

			if var_42_8 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_10 = arg_39_1:FormatText(StoryNameCfg[236].name)

				arg_39_1.leftNameTxt_.text = var_42_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_11 = arg_39_1:GetWordFromCfg(117032009)
				local var_42_12 = arg_39_1:FormatText(var_42_11.content)

				arg_39_1.text_.text = var_42_12

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 28
				local var_42_14 = utf8.len(var_42_12)
				local var_42_15 = var_42_13 <= 0 and var_42_9 or var_42_9 * (var_42_14 / var_42_13)

				if var_42_15 > 0 and var_42_9 < var_42_15 then
					arg_39_1.talkMaxDuration = var_42_15

					if var_42_15 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_15 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_12
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032009", "story_v_out_117032.awb") ~= 0 then
					local var_42_16 = manager.audio:GetVoiceLength("story_v_out_117032", "117032009", "story_v_out_117032.awb") / 1000

					if var_42_16 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_16 + var_42_8
					end

					if var_42_11.prefab_name ~= "" and arg_39_1.actors_[var_42_11.prefab_name] ~= nil then
						local var_42_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_11.prefab_name].transform, "story_v_out_117032", "117032009", "story_v_out_117032.awb")

						arg_39_1:RecordAudio("117032009", var_42_17)
						arg_39_1:RecordAudio("117032009", var_42_17)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_117032", "117032009", "story_v_out_117032.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_117032", "117032009", "story_v_out_117032.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_18 = math.max(var_42_9, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_18 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_18

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_18 and arg_39_1.time_ < var_42_8 + var_42_18 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play117032010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 117032010
		arg_43_1.duration_ = 6.63

		local var_43_0 = {
			zh = 3.7,
			ja = 6.633
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play117032011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1132"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps1132 == nil then
				arg_43_1.var_.actorSpriteComps1132 = var_46_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_2 = 0.2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.actorSpriteComps1132 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								local var_46_4 = Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor1.r, var_46_3)
								local var_46_5 = Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor1.g, var_46_3)
								local var_46_6 = Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor1.b, var_46_3)

								iter_46_1.color = Color.New(var_46_4, var_46_5, var_46_6)
							else
								local var_46_7 = Mathf.Lerp(iter_46_1.color.r, 1, var_46_3)

								iter_46_1.color = Color.New(var_46_7, var_46_7, var_46_7)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps1132 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_46_3 then
						if arg_43_1.isInRecall_ then
							iter_46_3.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps1132 = nil
			end

			local var_46_8 = arg_43_1.actors_["1033"]
			local var_46_9 = 0

			if var_46_9 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 and not isNil(var_46_8) and arg_43_1.var_.actorSpriteComps1033 == nil then
				arg_43_1.var_.actorSpriteComps1033 = var_46_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_10 = 0.2

			if var_46_9 <= arg_43_1.time_ and arg_43_1.time_ < var_46_9 + var_46_10 and not isNil(var_46_8) then
				local var_46_11 = (arg_43_1.time_ - var_46_9) / var_46_10

				if arg_43_1.var_.actorSpriteComps1033 then
					for iter_46_4, iter_46_5 in pairs(arg_43_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_46_5 then
							if arg_43_1.isInRecall_ then
								local var_46_12 = Mathf.Lerp(iter_46_5.color.r, arg_43_1.hightColor2.r, var_46_11)
								local var_46_13 = Mathf.Lerp(iter_46_5.color.g, arg_43_1.hightColor2.g, var_46_11)
								local var_46_14 = Mathf.Lerp(iter_46_5.color.b, arg_43_1.hightColor2.b, var_46_11)

								iter_46_5.color = Color.New(var_46_12, var_46_13, var_46_14)
							else
								local var_46_15 = Mathf.Lerp(iter_46_5.color.r, 0.5, var_46_11)

								iter_46_5.color = Color.New(var_46_15, var_46_15, var_46_15)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_9 + var_46_10 and arg_43_1.time_ < var_46_9 + var_46_10 + arg_46_0 and not isNil(var_46_8) and arg_43_1.var_.actorSpriteComps1033 then
				for iter_46_6, iter_46_7 in pairs(arg_43_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_46_7 then
						if arg_43_1.isInRecall_ then
							iter_46_7.color = arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_46_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps1033 = nil
			end

			local var_46_16 = 0
			local var_46_17 = 0.4

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_18 = arg_43_1:FormatText(StoryNameCfg[61].name)

				arg_43_1.leftNameTxt_.text = var_46_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_19 = arg_43_1:GetWordFromCfg(117032010)
				local var_46_20 = arg_43_1:FormatText(var_46_19.content)

				arg_43_1.text_.text = var_46_20

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_21 = 16
				local var_46_22 = utf8.len(var_46_20)
				local var_46_23 = var_46_21 <= 0 and var_46_17 or var_46_17 * (var_46_22 / var_46_21)

				if var_46_23 > 0 and var_46_17 < var_46_23 then
					arg_43_1.talkMaxDuration = var_46_23

					if var_46_23 + var_46_16 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_23 + var_46_16
					end
				end

				arg_43_1.text_.text = var_46_20
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032010", "story_v_out_117032.awb") ~= 0 then
					local var_46_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032010", "story_v_out_117032.awb") / 1000

					if var_46_24 + var_46_16 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_24 + var_46_16
					end

					if var_46_19.prefab_name ~= "" and arg_43_1.actors_[var_46_19.prefab_name] ~= nil then
						local var_46_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_19.prefab_name].transform, "story_v_out_117032", "117032010", "story_v_out_117032.awb")

						arg_43_1:RecordAudio("117032010", var_46_25)
						arg_43_1:RecordAudio("117032010", var_46_25)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_117032", "117032010", "story_v_out_117032.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_117032", "117032010", "story_v_out_117032.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_26 = math.max(var_46_17, arg_43_1.talkMaxDuration)

			if var_46_16 <= arg_43_1.time_ and arg_43_1.time_ < var_46_16 + var_46_26 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_16) / var_46_26

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_16 + var_46_26 and arg_43_1.time_ < var_46_16 + var_46_26 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play117032011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 117032011
		arg_47_1.duration_ = 9

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play117032012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = "ST28"

			if arg_47_1.bgs_[var_50_0] == nil then
				local var_50_1 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_50_0)
				var_50_1.name = var_50_0
				var_50_1.transform.parent = arg_47_1.stage_.transform
				var_50_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_[var_50_0] = var_50_1
			end

			local var_50_2 = 2

			if var_50_2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				local var_50_3 = manager.ui.mainCamera.transform.localPosition
				local var_50_4 = Vector3.New(0, 0, 10) + Vector3.New(var_50_3.x, var_50_3.y, 0)
				local var_50_5 = arg_47_1.bgs_.ST28

				var_50_5.transform.localPosition = var_50_4
				var_50_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_6 = var_50_5:GetComponent("SpriteRenderer")

				if var_50_6 and var_50_6.sprite then
					local var_50_7 = (var_50_5.transform.localPosition - var_50_3).z
					local var_50_8 = manager.ui.mainCameraCom_
					local var_50_9 = 2 * var_50_7 * Mathf.Tan(var_50_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_50_10 = var_50_9 * var_50_8.aspect
					local var_50_11 = var_50_6.sprite.bounds.size.x
					local var_50_12 = var_50_6.sprite.bounds.size.y
					local var_50_13 = var_50_10 / var_50_11
					local var_50_14 = var_50_9 / var_50_12
					local var_50_15 = var_50_14 < var_50_13 and var_50_13 or var_50_14

					var_50_5.transform.localScale = Vector3.New(var_50_15, var_50_15, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "ST28" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_16 = 0

			if var_50_16 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_17 = 2

			if var_50_16 <= arg_47_1.time_ and arg_47_1.time_ < var_50_16 + var_50_17 then
				local var_50_18 = (arg_47_1.time_ - var_50_16) / var_50_17
				local var_50_19 = Color.New(0, 0, 0)

				var_50_19.a = Mathf.Lerp(0, 1, var_50_18)
				arg_47_1.mask_.color = var_50_19
			end

			if arg_47_1.time_ >= var_50_16 + var_50_17 and arg_47_1.time_ < var_50_16 + var_50_17 + arg_50_0 then
				local var_50_20 = Color.New(0, 0, 0)

				var_50_20.a = 1
				arg_47_1.mask_.color = var_50_20
			end

			local var_50_21 = 2

			if var_50_21 < arg_47_1.time_ and arg_47_1.time_ <= var_50_21 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_22 = 2

			if var_50_21 <= arg_47_1.time_ and arg_47_1.time_ < var_50_21 + var_50_22 then
				local var_50_23 = (arg_47_1.time_ - var_50_21) / var_50_22
				local var_50_24 = Color.New(0, 0, 0)

				var_50_24.a = Mathf.Lerp(1, 0, var_50_23)
				arg_47_1.mask_.color = var_50_24
			end

			if arg_47_1.time_ >= var_50_21 + var_50_22 and arg_47_1.time_ < var_50_21 + var_50_22 + arg_50_0 then
				local var_50_25 = Color.New(0, 0, 0)
				local var_50_26 = 0

				arg_47_1.mask_.enabled = false
				var_50_25.a = var_50_26
				arg_47_1.mask_.color = var_50_25
			end

			local var_50_27 = arg_47_1.actors_["1033"].transform
			local var_50_28 = 2

			if var_50_28 < arg_47_1.time_ and arg_47_1.time_ <= var_50_28 + arg_50_0 then
				arg_47_1.var_.moveOldPos1033 = var_50_27.localPosition
				var_50_27.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1033", 7)

				local var_50_29 = var_50_27.childCount

				for iter_50_2 = 0, var_50_29 - 1 do
					local var_50_30 = var_50_27:GetChild(iter_50_2)

					if var_50_30.name == "split_6" or not string.find(var_50_30.name, "split") then
						var_50_30.gameObject:SetActive(true)
					else
						var_50_30.gameObject:SetActive(false)
					end
				end
			end

			local var_50_31 = 0.001

			if var_50_28 <= arg_47_1.time_ and arg_47_1.time_ < var_50_28 + var_50_31 then
				local var_50_32 = (arg_47_1.time_ - var_50_28) / var_50_31
				local var_50_33 = Vector3.New(0, -2000, 0)

				var_50_27.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1033, var_50_33, var_50_32)
			end

			if arg_47_1.time_ >= var_50_28 + var_50_31 and arg_47_1.time_ < var_50_28 + var_50_31 + arg_50_0 then
				var_50_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_50_34 = arg_47_1.actors_["1132"].transform
			local var_50_35 = 2

			if var_50_35 < arg_47_1.time_ and arg_47_1.time_ <= var_50_35 + arg_50_0 then
				arg_47_1.var_.moveOldPos1132 = var_50_34.localPosition
				var_50_34.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1132", 7)

				local var_50_36 = var_50_34.childCount

				for iter_50_3 = 0, var_50_36 - 1 do
					local var_50_37 = var_50_34:GetChild(iter_50_3)

					if var_50_37.name == "split_6" or not string.find(var_50_37.name, "split") then
						var_50_37.gameObject:SetActive(true)
					else
						var_50_37.gameObject:SetActive(false)
					end
				end
			end

			local var_50_38 = 0.001

			if var_50_35 <= arg_47_1.time_ and arg_47_1.time_ < var_50_35 + var_50_38 then
				local var_50_39 = (arg_47_1.time_ - var_50_35) / var_50_38
				local var_50_40 = Vector3.New(0, -2000, -185)

				var_50_34.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1132, var_50_40, var_50_39)
			end

			if arg_47_1.time_ >= var_50_35 + var_50_38 and arg_47_1.time_ < var_50_35 + var_50_38 + arg_50_0 then
				var_50_34.localPosition = Vector3.New(0, -2000, -185)
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_41 = 4
			local var_50_42 = 1.2

			if var_50_41 < arg_47_1.time_ and arg_47_1.time_ <= var_50_41 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_43 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_43:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_44 = arg_47_1:GetWordFromCfg(117032011)
				local var_50_45 = arg_47_1:FormatText(var_50_44.content)

				arg_47_1.text_.text = var_50_45

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_46 = 48
				local var_50_47 = utf8.len(var_50_45)
				local var_50_48 = var_50_46 <= 0 and var_50_42 or var_50_42 * (var_50_47 / var_50_46)

				if var_50_48 > 0 and var_50_42 < var_50_48 then
					arg_47_1.talkMaxDuration = var_50_48
					var_50_41 = var_50_41 + 0.3

					if var_50_48 + var_50_41 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_48 + var_50_41
					end
				end

				arg_47_1.text_.text = var_50_45
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_49 = var_50_41 + 0.3
			local var_50_50 = math.max(var_50_42, arg_47_1.talkMaxDuration)

			if var_50_49 <= arg_47_1.time_ and arg_47_1.time_ < var_50_49 + var_50_50 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_49) / var_50_50

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_49 + var_50_50 and arg_47_1.time_ < var_50_49 + var_50_50 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play117032012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 117032012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play117032013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.225

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(117032012)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 49
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play117032013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 117032013
		arg_57_1.duration_ = 3.03

		local var_57_0 = {
			zh = 1.2,
			ja = 3.033
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
				arg_57_0:Play117032014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1033"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1033 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1033", 4)

				local var_60_2 = var_60_0.childCount

				for iter_60_0 = 0, var_60_2 - 1 do
					local var_60_3 = var_60_0:GetChild(iter_60_0)

					if var_60_3.name == "split_1" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_4 then
				local var_60_5 = (arg_57_1.time_ - var_60_1) / var_60_4
				local var_60_6 = Vector3.New(390, -420, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1033, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(390, -420, 0)
			end

			local var_60_7 = arg_57_1.actors_["1132"].transform
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.var_.moveOldPos1132 = var_60_7.localPosition
				var_60_7.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1132", 2)

				local var_60_9 = var_60_7.childCount

				for iter_60_1 = 0, var_60_9 - 1 do
					local var_60_10 = var_60_7:GetChild(iter_60_1)

					if var_60_10.name == "split_6" or not string.find(var_60_10.name, "split") then
						var_60_10.gameObject:SetActive(true)
					else
						var_60_10.gameObject:SetActive(false)
					end
				end
			end

			local var_60_11 = 0.001

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_11 then
				local var_60_12 = (arg_57_1.time_ - var_60_8) / var_60_11
				local var_60_13 = Vector3.New(-390, -413, -185)

				var_60_7.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1132, var_60_13, var_60_12)
			end

			if arg_57_1.time_ >= var_60_8 + var_60_11 and arg_57_1.time_ < var_60_8 + var_60_11 + arg_60_0 then
				var_60_7.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_60_14 = arg_57_1.actors_["1033"]
			local var_60_15 = 0

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				local var_60_16 = var_60_14:GetComponentInChildren(typeof(CanvasGroup))

				if var_60_16 then
					arg_57_1.var_.alphaOldValue1033 = var_60_16.alpha
					arg_57_1.var_.characterEffect1033 = var_60_16
				end

				arg_57_1.var_.alphaOldValue1033 = 0
			end

			local var_60_17 = 0.333333333333333

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_17 then
				local var_60_18 = (arg_57_1.time_ - var_60_15) / var_60_17
				local var_60_19 = Mathf.Lerp(arg_57_1.var_.alphaOldValue1033, 1, var_60_18)

				if arg_57_1.var_.characterEffect1033 then
					arg_57_1.var_.characterEffect1033.alpha = var_60_19
				end
			end

			if arg_57_1.time_ >= var_60_15 + var_60_17 and arg_57_1.time_ < var_60_15 + var_60_17 + arg_60_0 and arg_57_1.var_.characterEffect1033 then
				arg_57_1.var_.characterEffect1033.alpha = 1
			end

			local var_60_20 = arg_57_1.actors_["1132"]
			local var_60_21 = 0

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 then
				local var_60_22 = var_60_20:GetComponentInChildren(typeof(CanvasGroup))

				if var_60_22 then
					arg_57_1.var_.alphaOldValue1132 = var_60_22.alpha
					arg_57_1.var_.characterEffect1132 = var_60_22
				end

				arg_57_1.var_.alphaOldValue1132 = 0
			end

			local var_60_23 = 0.333333333333333

			if var_60_21 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_23 then
				local var_60_24 = (arg_57_1.time_ - var_60_21) / var_60_23
				local var_60_25 = Mathf.Lerp(arg_57_1.var_.alphaOldValue1132, 1, var_60_24)

				if arg_57_1.var_.characterEffect1132 then
					arg_57_1.var_.characterEffect1132.alpha = var_60_25
				end
			end

			if arg_57_1.time_ >= var_60_21 + var_60_23 and arg_57_1.time_ < var_60_21 + var_60_23 + arg_60_0 and arg_57_1.var_.characterEffect1132 then
				arg_57_1.var_.characterEffect1132.alpha = 1
			end

			local var_60_26 = arg_57_1.actors_["1033"]
			local var_60_27 = 0

			if var_60_27 < arg_57_1.time_ and arg_57_1.time_ <= var_60_27 + arg_60_0 and not isNil(var_60_26) and arg_57_1.var_.actorSpriteComps1033 == nil then
				arg_57_1.var_.actorSpriteComps1033 = var_60_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_28 = 0.2

			if var_60_27 <= arg_57_1.time_ and arg_57_1.time_ < var_60_27 + var_60_28 and not isNil(var_60_26) then
				local var_60_29 = (arg_57_1.time_ - var_60_27) / var_60_28

				if arg_57_1.var_.actorSpriteComps1033 then
					for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_60_3 then
							if arg_57_1.isInRecall_ then
								local var_60_30 = Mathf.Lerp(iter_60_3.color.r, arg_57_1.hightColor1.r, var_60_29)
								local var_60_31 = Mathf.Lerp(iter_60_3.color.g, arg_57_1.hightColor1.g, var_60_29)
								local var_60_32 = Mathf.Lerp(iter_60_3.color.b, arg_57_1.hightColor1.b, var_60_29)

								iter_60_3.color = Color.New(var_60_30, var_60_31, var_60_32)
							else
								local var_60_33 = Mathf.Lerp(iter_60_3.color.r, 1, var_60_29)

								iter_60_3.color = Color.New(var_60_33, var_60_33, var_60_33)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_27 + var_60_28 and arg_57_1.time_ < var_60_27 + var_60_28 + arg_60_0 and not isNil(var_60_26) and arg_57_1.var_.actorSpriteComps1033 then
				for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_60_5 then
						if arg_57_1.isInRecall_ then
							iter_60_5.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1033 = nil
			end

			local var_60_34 = arg_57_1.actors_["1132"]
			local var_60_35 = 0

			if var_60_35 < arg_57_1.time_ and arg_57_1.time_ <= var_60_35 + arg_60_0 and not isNil(var_60_34) and arg_57_1.var_.actorSpriteComps1132 == nil then
				arg_57_1.var_.actorSpriteComps1132 = var_60_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_36 = 0.2

			if var_60_35 <= arg_57_1.time_ and arg_57_1.time_ < var_60_35 + var_60_36 and not isNil(var_60_34) then
				local var_60_37 = (arg_57_1.time_ - var_60_35) / var_60_36

				if arg_57_1.var_.actorSpriteComps1132 then
					for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_60_7 then
							if arg_57_1.isInRecall_ then
								local var_60_38 = Mathf.Lerp(iter_60_7.color.r, arg_57_1.hightColor2.r, var_60_37)
								local var_60_39 = Mathf.Lerp(iter_60_7.color.g, arg_57_1.hightColor2.g, var_60_37)
								local var_60_40 = Mathf.Lerp(iter_60_7.color.b, arg_57_1.hightColor2.b, var_60_37)

								iter_60_7.color = Color.New(var_60_38, var_60_39, var_60_40)
							else
								local var_60_41 = Mathf.Lerp(iter_60_7.color.r, 0.5, var_60_37)

								iter_60_7.color = Color.New(var_60_41, var_60_41, var_60_41)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_35 + var_60_36 and arg_57_1.time_ < var_60_35 + var_60_36 + arg_60_0 and not isNil(var_60_34) and arg_57_1.var_.actorSpriteComps1132 then
				for iter_60_8, iter_60_9 in pairs(arg_57_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_60_9 then
						if arg_57_1.isInRecall_ then
							iter_60_9.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1132 = nil
			end

			local var_60_42 = 0
			local var_60_43 = 0.1

			if var_60_42 < arg_57_1.time_ and arg_57_1.time_ <= var_60_42 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_44 = arg_57_1:FormatText(StoryNameCfg[236].name)

				arg_57_1.leftNameTxt_.text = var_60_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_45 = arg_57_1:GetWordFromCfg(117032013)
				local var_60_46 = arg_57_1:FormatText(var_60_45.content)

				arg_57_1.text_.text = var_60_46

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_47 = 4
				local var_60_48 = utf8.len(var_60_46)
				local var_60_49 = var_60_47 <= 0 and var_60_43 or var_60_43 * (var_60_48 / var_60_47)

				if var_60_49 > 0 and var_60_43 < var_60_49 then
					arg_57_1.talkMaxDuration = var_60_49

					if var_60_49 + var_60_42 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_49 + var_60_42
					end
				end

				arg_57_1.text_.text = var_60_46
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032013", "story_v_out_117032.awb") ~= 0 then
					local var_60_50 = manager.audio:GetVoiceLength("story_v_out_117032", "117032013", "story_v_out_117032.awb") / 1000

					if var_60_50 + var_60_42 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_50 + var_60_42
					end

					if var_60_45.prefab_name ~= "" and arg_57_1.actors_[var_60_45.prefab_name] ~= nil then
						local var_60_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_45.prefab_name].transform, "story_v_out_117032", "117032013", "story_v_out_117032.awb")

						arg_57_1:RecordAudio("117032013", var_60_51)
						arg_57_1:RecordAudio("117032013", var_60_51)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_117032", "117032013", "story_v_out_117032.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_117032", "117032013", "story_v_out_117032.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_52 = math.max(var_60_43, arg_57_1.talkMaxDuration)

			if var_60_42 <= arg_57_1.time_ and arg_57_1.time_ < var_60_42 + var_60_52 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_42) / var_60_52

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_42 + var_60_52 and arg_57_1.time_ < var_60_42 + var_60_52 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1132",
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
	Play117032014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 117032014
		arg_61_1.duration_ = 4.8

		local var_61_0 = {
			zh = 3.3,
			ja = 4.8
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
				arg_61_0:Play117032015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1033"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1033 == nil then
				arg_61_1.var_.actorSpriteComps1033 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps1033 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor2.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor2.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor2.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 0.5, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1033 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1033 = nil
			end

			local var_64_8 = arg_61_1.actors_["1132"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1132 == nil then
				arg_61_1.var_.actorSpriteComps1132 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps1132 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor1.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor1.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor1.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 1, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1132 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1132 = nil
			end

			local var_64_16 = 0
			local var_64_17 = 0.4

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_18 = arg_61_1:FormatText(StoryNameCfg[61].name)

				arg_61_1.leftNameTxt_.text = var_64_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(117032014)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 16
				local var_64_22 = utf8.len(var_64_20)
				local var_64_23 = var_64_21 <= 0 and var_64_17 or var_64_17 * (var_64_22 / var_64_21)

				if var_64_23 > 0 and var_64_17 < var_64_23 then
					arg_61_1.talkMaxDuration = var_64_23

					if var_64_23 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_20
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032014", "story_v_out_117032.awb") ~= 0 then
					local var_64_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032014", "story_v_out_117032.awb") / 1000

					if var_64_24 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_16
					end

					if var_64_19.prefab_name ~= "" and arg_61_1.actors_[var_64_19.prefab_name] ~= nil then
						local var_64_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_19.prefab_name].transform, "story_v_out_117032", "117032014", "story_v_out_117032.awb")

						arg_61_1:RecordAudio("117032014", var_64_25)
						arg_61_1:RecordAudio("117032014", var_64_25)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_117032", "117032014", "story_v_out_117032.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_117032", "117032014", "story_v_out_117032.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_26 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_26 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_16) / var_64_26

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_16 + var_64_26 and arg_61_1.time_ < var_64_16 + var_64_26 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play117032015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 117032015
		arg_65_1.duration_ = 9.57

		local var_65_0 = {
			zh = 6.5,
			ja = 9.566
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
				arg_65_0:Play117032016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.8

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[61].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(117032015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 32
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032015", "story_v_out_117032.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032015", "story_v_out_117032.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_117032", "117032015", "story_v_out_117032.awb")

						arg_65_1:RecordAudio("117032015", var_68_9)
						arg_65_1:RecordAudio("117032015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_117032", "117032015", "story_v_out_117032.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_117032", "117032015", "story_v_out_117032.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play117032016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 117032016
		arg_69_1.duration_ = 10.47

		local var_69_0 = {
			zh = 9.833,
			ja = 10.466
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
				arg_69_0:Play117032017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1033"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1033 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1033", 4)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "split_6" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(390, -420, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1033, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(390, -420, 0)
			end

			local var_72_7 = arg_69_1.actors_["1132"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1132 == nil then
				arg_69_1.var_.actorSpriteComps1132 = var_72_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 0.2

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 and not isNil(var_72_7) then
				local var_72_10 = (arg_69_1.time_ - var_72_8) / var_72_9

				if arg_69_1.var_.actorSpriteComps1132 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1132 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1132 = nil
			end

			local var_72_15 = arg_69_1.actors_["1033"]
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.actorSpriteComps1033 == nil then
				arg_69_1.var_.actorSpriteComps1033 = var_72_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_17 = 0.2

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 and not isNil(var_72_15) then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17

				if arg_69_1.var_.actorSpriteComps1033 then
					for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_72_6 then
							if arg_69_1.isInRecall_ then
								local var_72_19 = Mathf.Lerp(iter_72_6.color.r, arg_69_1.hightColor1.r, var_72_18)
								local var_72_20 = Mathf.Lerp(iter_72_6.color.g, arg_69_1.hightColor1.g, var_72_18)
								local var_72_21 = Mathf.Lerp(iter_72_6.color.b, arg_69_1.hightColor1.b, var_72_18)

								iter_72_6.color = Color.New(var_72_19, var_72_20, var_72_21)
							else
								local var_72_22 = Mathf.Lerp(iter_72_6.color.r, 1, var_72_18)

								iter_72_6.color = Color.New(var_72_22, var_72_22, var_72_22)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.actorSpriteComps1033 then
				for iter_72_7, iter_72_8 in pairs(arg_69_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_72_8 then
						if arg_69_1.isInRecall_ then
							iter_72_8.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1033 = nil
			end

			local var_72_23 = 0
			local var_72_24 = 1.175

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_25 = arg_69_1:FormatText(StoryNameCfg[236].name)

				arg_69_1.leftNameTxt_.text = var_72_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_26 = arg_69_1:GetWordFromCfg(117032016)
				local var_72_27 = arg_69_1:FormatText(var_72_26.content)

				arg_69_1.text_.text = var_72_27

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_28 = 47
				local var_72_29 = utf8.len(var_72_27)
				local var_72_30 = var_72_28 <= 0 and var_72_24 or var_72_24 * (var_72_29 / var_72_28)

				if var_72_30 > 0 and var_72_24 < var_72_30 then
					arg_69_1.talkMaxDuration = var_72_30

					if var_72_30 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_30 + var_72_23
					end
				end

				arg_69_1.text_.text = var_72_27
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032016", "story_v_out_117032.awb") ~= 0 then
					local var_72_31 = manager.audio:GetVoiceLength("story_v_out_117032", "117032016", "story_v_out_117032.awb") / 1000

					if var_72_31 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_31 + var_72_23
					end

					if var_72_26.prefab_name ~= "" and arg_69_1.actors_[var_72_26.prefab_name] ~= nil then
						local var_72_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_26.prefab_name].transform, "story_v_out_117032", "117032016", "story_v_out_117032.awb")

						arg_69_1:RecordAudio("117032016", var_72_32)
						arg_69_1:RecordAudio("117032016", var_72_32)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_117032", "117032016", "story_v_out_117032.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_117032", "117032016", "story_v_out_117032.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_33 = math.max(var_72_24, arg_69_1.talkMaxDuration)

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_33 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_23) / var_72_33

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_23 + var_72_33 and arg_69_1.time_ < var_72_23 + var_72_33 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play117032017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 117032017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play117032018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1033"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1033 == nil then
				arg_73_1.var_.actorSpriteComps1033 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps1033 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 0.5, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1033 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1033 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.7

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(117032017)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_12 = 28
				local var_76_13 = utf8.len(var_76_11)
				local var_76_14 = var_76_12 <= 0 and var_76_9 or var_76_9 * (var_76_13 / var_76_12)

				if var_76_14 > 0 and var_76_9 < var_76_14 then
					arg_73_1.talkMaxDuration = var_76_14

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_15 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_15 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_15

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_15 and arg_73_1.time_ < var_76_8 + var_76_15 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play117032018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 117032018
		arg_77_1.duration_ = 8.2

		local var_77_0 = {
			zh = 5.533,
			ja = 8.2
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
				arg_77_0:Play117032019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1132"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1132 == nil then
				arg_77_1.var_.actorSpriteComps1132 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps1132 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 1, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1132 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1132 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 0.65

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_10 = arg_77_1:FormatText(StoryNameCfg[61].name)

				arg_77_1.leftNameTxt_.text = var_80_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_11 = arg_77_1:GetWordFromCfg(117032018)
				local var_80_12 = arg_77_1:FormatText(var_80_11.content)

				arg_77_1.text_.text = var_80_12

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 26
				local var_80_14 = utf8.len(var_80_12)
				local var_80_15 = var_80_13 <= 0 and var_80_9 or var_80_9 * (var_80_14 / var_80_13)

				if var_80_15 > 0 and var_80_9 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15

					if var_80_15 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_12
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032018", "story_v_out_117032.awb") ~= 0 then
					local var_80_16 = manager.audio:GetVoiceLength("story_v_out_117032", "117032018", "story_v_out_117032.awb") / 1000

					if var_80_16 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_8
					end

					if var_80_11.prefab_name ~= "" and arg_77_1.actors_[var_80_11.prefab_name] ~= nil then
						local var_80_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_11.prefab_name].transform, "story_v_out_117032", "117032018", "story_v_out_117032.awb")

						arg_77_1:RecordAudio("117032018", var_80_17)
						arg_77_1:RecordAudio("117032018", var_80_17)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_117032", "117032018", "story_v_out_117032.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_117032", "117032018", "story_v_out_117032.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_18 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_18 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_18

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_18 and arg_77_1.time_ < var_80_8 + var_80_18 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play117032019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 117032019
		arg_81_1.duration_ = 10.93

		local var_81_0 = {
			zh = 8.2,
			ja = 10.933
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
				arg_81_0:Play117032020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1132"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1132 == nil then
				arg_81_1.var_.actorSpriteComps1132 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps1132 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								local var_84_4 = Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor2.r, var_84_3)
								local var_84_5 = Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor2.g, var_84_3)
								local var_84_6 = Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor2.b, var_84_3)

								iter_84_1.color = Color.New(var_84_4, var_84_5, var_84_6)
							else
								local var_84_7 = Mathf.Lerp(iter_84_1.color.r, 0.5, var_84_3)

								iter_84_1.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1132 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1132 = nil
			end

			local var_84_8 = arg_81_1.actors_["1033"]
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps1033 == nil then
				arg_81_1.var_.actorSpriteComps1033 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_10 = 0.2

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 and not isNil(var_84_8) then
				local var_84_11 = (arg_81_1.time_ - var_84_9) / var_84_10

				if arg_81_1.var_.actorSpriteComps1033 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								local var_84_12 = Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor1.r, var_84_11)
								local var_84_13 = Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor1.g, var_84_11)
								local var_84_14 = Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor1.b, var_84_11)

								iter_84_5.color = Color.New(var_84_12, var_84_13, var_84_14)
							else
								local var_84_15 = Mathf.Lerp(iter_84_5.color.r, 1, var_84_11)

								iter_84_5.color = Color.New(var_84_15, var_84_15, var_84_15)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps1033 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_84_7 then
						if arg_81_1.isInRecall_ then
							iter_84_7.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1033 = nil
			end

			local var_84_16 = 0
			local var_84_17 = 1.1

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_18 = arg_81_1:FormatText(StoryNameCfg[236].name)

				arg_81_1.leftNameTxt_.text = var_84_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_19 = arg_81_1:GetWordFromCfg(117032019)
				local var_84_20 = arg_81_1:FormatText(var_84_19.content)

				arg_81_1.text_.text = var_84_20

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_21 = 44
				local var_84_22 = utf8.len(var_84_20)
				local var_84_23 = var_84_21 <= 0 and var_84_17 or var_84_17 * (var_84_22 / var_84_21)

				if var_84_23 > 0 and var_84_17 < var_84_23 then
					arg_81_1.talkMaxDuration = var_84_23

					if var_84_23 + var_84_16 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_16
					end
				end

				arg_81_1.text_.text = var_84_20
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032019", "story_v_out_117032.awb") ~= 0 then
					local var_84_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032019", "story_v_out_117032.awb") / 1000

					if var_84_24 + var_84_16 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_24 + var_84_16
					end

					if var_84_19.prefab_name ~= "" and arg_81_1.actors_[var_84_19.prefab_name] ~= nil then
						local var_84_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_19.prefab_name].transform, "story_v_out_117032", "117032019", "story_v_out_117032.awb")

						arg_81_1:RecordAudio("117032019", var_84_25)
						arg_81_1:RecordAudio("117032019", var_84_25)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_117032", "117032019", "story_v_out_117032.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_117032", "117032019", "story_v_out_117032.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_26 = math.max(var_84_17, arg_81_1.talkMaxDuration)

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_26 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_16) / var_84_26

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_16 + var_84_26 and arg_81_1.time_ < var_84_16 + var_84_26 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play117032020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 117032020
		arg_85_1.duration_ = 10.9

		local var_85_0 = {
			zh = 9.666,
			ja = 10.9
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
				arg_85_0:Play117032021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1132"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1132 == nil then
				arg_85_1.var_.actorSpriteComps1132 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps1132 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1132 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1132 = nil
			end

			local var_88_8 = arg_85_1.actors_["1033"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps1033 == nil then
				arg_85_1.var_.actorSpriteComps1033 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 0.2

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps1033 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								local var_88_12 = Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor2.r, var_88_11)
								local var_88_13 = Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor2.g, var_88_11)
								local var_88_14 = Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor2.b, var_88_11)

								iter_88_5.color = Color.New(var_88_12, var_88_13, var_88_14)
							else
								local var_88_15 = Mathf.Lerp(iter_88_5.color.r, 0.5, var_88_11)

								iter_88_5.color = Color.New(var_88_15, var_88_15, var_88_15)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps1033 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1033 = nil
			end

			local var_88_16 = 0
			local var_88_17 = 0.975

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_18 = arg_85_1:FormatText(StoryNameCfg[61].name)

				arg_85_1.leftNameTxt_.text = var_88_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_19 = arg_85_1:GetWordFromCfg(117032020)
				local var_88_20 = arg_85_1:FormatText(var_88_19.content)

				arg_85_1.text_.text = var_88_20

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_21 = 39
				local var_88_22 = utf8.len(var_88_20)
				local var_88_23 = var_88_21 <= 0 and var_88_17 or var_88_17 * (var_88_22 / var_88_21)

				if var_88_23 > 0 and var_88_17 < var_88_23 then
					arg_85_1.talkMaxDuration = var_88_23

					if var_88_23 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_16
					end
				end

				arg_85_1.text_.text = var_88_20
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032020", "story_v_out_117032.awb") ~= 0 then
					local var_88_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032020", "story_v_out_117032.awb") / 1000

					if var_88_24 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_16
					end

					if var_88_19.prefab_name ~= "" and arg_85_1.actors_[var_88_19.prefab_name] ~= nil then
						local var_88_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_19.prefab_name].transform, "story_v_out_117032", "117032020", "story_v_out_117032.awb")

						arg_85_1:RecordAudio("117032020", var_88_25)
						arg_85_1:RecordAudio("117032020", var_88_25)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_117032", "117032020", "story_v_out_117032.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_117032", "117032020", "story_v_out_117032.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_26 = math.max(var_88_17, arg_85_1.talkMaxDuration)

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_26 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_16) / var_88_26

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_16 + var_88_26 and arg_85_1.time_ < var_88_16 + var_88_26 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play117032021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 117032021
		arg_89_1.duration_ = 6.47

		local var_89_0 = {
			zh = 3.4,
			ja = 6.466
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
				arg_89_0:Play117032022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.275

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[61].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(117032021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032021", "story_v_out_117032.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032021", "story_v_out_117032.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_117032", "117032021", "story_v_out_117032.awb")

						arg_89_1:RecordAudio("117032021", var_92_9)
						arg_89_1:RecordAudio("117032021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_117032", "117032021", "story_v_out_117032.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_117032", "117032021", "story_v_out_117032.awb")
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
	Play117032022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 117032022
		arg_93_1.duration_ = 11.07

		local var_93_0 = {
			zh = 11.066,
			ja = 10.966
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
				arg_93_0:Play117032023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1132"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1132 == nil then
				arg_93_1.var_.actorSpriteComps1132 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps1132 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 0.5, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1132 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1132 = nil
			end

			local var_96_8 = arg_93_1.actors_["1033"]
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1033 == nil then
				arg_93_1.var_.actorSpriteComps1033 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_10 = 0.2

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_10 and not isNil(var_96_8) then
				local var_96_11 = (arg_93_1.time_ - var_96_9) / var_96_10

				if arg_93_1.var_.actorSpriteComps1033 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								local var_96_12 = Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor1.r, var_96_11)
								local var_96_13 = Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor1.g, var_96_11)
								local var_96_14 = Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor1.b, var_96_11)

								iter_96_5.color = Color.New(var_96_12, var_96_13, var_96_14)
							else
								local var_96_15 = Mathf.Lerp(iter_96_5.color.r, 1, var_96_11)

								iter_96_5.color = Color.New(var_96_15, var_96_15, var_96_15)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_9 + var_96_10 and arg_93_1.time_ < var_96_9 + var_96_10 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1033 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_96_7 then
						if arg_93_1.isInRecall_ then
							iter_96_7.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1033 = nil
			end

			local var_96_16 = 0
			local var_96_17 = 1.35

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_18 = arg_93_1:FormatText(StoryNameCfg[236].name)

				arg_93_1.leftNameTxt_.text = var_96_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_19 = arg_93_1:GetWordFromCfg(117032022)
				local var_96_20 = arg_93_1:FormatText(var_96_19.content)

				arg_93_1.text_.text = var_96_20

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_21 = 54
				local var_96_22 = utf8.len(var_96_20)
				local var_96_23 = var_96_21 <= 0 and var_96_17 or var_96_17 * (var_96_22 / var_96_21)

				if var_96_23 > 0 and var_96_17 < var_96_23 then
					arg_93_1.talkMaxDuration = var_96_23

					if var_96_23 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_16
					end
				end

				arg_93_1.text_.text = var_96_20
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032022", "story_v_out_117032.awb") ~= 0 then
					local var_96_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032022", "story_v_out_117032.awb") / 1000

					if var_96_24 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_24 + var_96_16
					end

					if var_96_19.prefab_name ~= "" and arg_93_1.actors_[var_96_19.prefab_name] ~= nil then
						local var_96_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_19.prefab_name].transform, "story_v_out_117032", "117032022", "story_v_out_117032.awb")

						arg_93_1:RecordAudio("117032022", var_96_25)
						arg_93_1:RecordAudio("117032022", var_96_25)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_117032", "117032022", "story_v_out_117032.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_117032", "117032022", "story_v_out_117032.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_26 = math.max(var_96_17, arg_93_1.talkMaxDuration)

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_26 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_16) / var_96_26

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_16 + var_96_26 and arg_93_1.time_ < var_96_16 + var_96_26 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play117032023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 117032023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play117032024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1033"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1033 == nil then
				arg_97_1.var_.actorSpriteComps1033 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps1033 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 0.5, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1033 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1033 = nil
			end

			local var_100_8 = 0
			local var_100_9 = 0.575

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(117032023)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_12 = 23
				local var_100_13 = utf8.len(var_100_11)
				local var_100_14 = var_100_12 <= 0 and var_100_9 or var_100_9 * (var_100_13 / var_100_12)

				if var_100_14 > 0 and var_100_9 < var_100_14 then
					arg_97_1.talkMaxDuration = var_100_14

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_15 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_15 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_15

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_15 and arg_97_1.time_ < var_100_8 + var_100_15 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play117032024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 117032024
		arg_101_1.duration_ = 9.9

		local var_101_0 = {
			zh = 6.1,
			ja = 9.9
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
				arg_101_0:Play117032025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1033"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps1033 == nil then
				arg_101_1.var_.actorSpriteComps1033 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps1033 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								local var_104_4 = Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, var_104_3)
								local var_104_5 = Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, var_104_3)
								local var_104_6 = Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, var_104_3)

								iter_104_1.color = Color.New(var_104_4, var_104_5, var_104_6)
							else
								local var_104_7 = Mathf.Lerp(iter_104_1.color.r, 1, var_104_3)

								iter_104_1.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps1033 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1033 = nil
			end

			local var_104_8 = 0
			local var_104_9 = 0.775

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_10 = arg_101_1:FormatText(StoryNameCfg[236].name)

				arg_101_1.leftNameTxt_.text = var_104_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_11 = arg_101_1:GetWordFromCfg(117032024)
				local var_104_12 = arg_101_1:FormatText(var_104_11.content)

				arg_101_1.text_.text = var_104_12

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 31
				local var_104_14 = utf8.len(var_104_12)
				local var_104_15 = var_104_13 <= 0 and var_104_9 or var_104_9 * (var_104_14 / var_104_13)

				if var_104_15 > 0 and var_104_9 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15

					if var_104_15 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_12
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032024", "story_v_out_117032.awb") ~= 0 then
					local var_104_16 = manager.audio:GetVoiceLength("story_v_out_117032", "117032024", "story_v_out_117032.awb") / 1000

					if var_104_16 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_16 + var_104_8
					end

					if var_104_11.prefab_name ~= "" and arg_101_1.actors_[var_104_11.prefab_name] ~= nil then
						local var_104_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_11.prefab_name].transform, "story_v_out_117032", "117032024", "story_v_out_117032.awb")

						arg_101_1:RecordAudio("117032024", var_104_17)
						arg_101_1:RecordAudio("117032024", var_104_17)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_117032", "117032024", "story_v_out_117032.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_117032", "117032024", "story_v_out_117032.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_18 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_18 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_18

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_18 and arg_101_1.time_ < var_104_8 + var_104_18 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play117032025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 117032025
		arg_105_1.duration_ = 3

		local var_105_0 = {
			zh = 2.633,
			ja = 3
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
				arg_105_0:Play117032026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1132"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1132 == nil then
				arg_105_1.var_.actorSpriteComps1132 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps1132 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1132 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1132 = nil
			end

			local var_108_8 = arg_105_1.actors_["1033"]
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps1033 == nil then
				arg_105_1.var_.actorSpriteComps1033 = var_108_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_10 = 0.2

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_10 and not isNil(var_108_8) then
				local var_108_11 = (arg_105_1.time_ - var_108_9) / var_108_10

				if arg_105_1.var_.actorSpriteComps1033 then
					for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_108_5 then
							if arg_105_1.isInRecall_ then
								local var_108_12 = Mathf.Lerp(iter_108_5.color.r, arg_105_1.hightColor2.r, var_108_11)
								local var_108_13 = Mathf.Lerp(iter_108_5.color.g, arg_105_1.hightColor2.g, var_108_11)
								local var_108_14 = Mathf.Lerp(iter_108_5.color.b, arg_105_1.hightColor2.b, var_108_11)

								iter_108_5.color = Color.New(var_108_12, var_108_13, var_108_14)
							else
								local var_108_15 = Mathf.Lerp(iter_108_5.color.r, 0.5, var_108_11)

								iter_108_5.color = Color.New(var_108_15, var_108_15, var_108_15)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_9 + var_108_10 and arg_105_1.time_ < var_108_9 + var_108_10 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps1033 then
				for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_108_7 then
						if arg_105_1.isInRecall_ then
							iter_108_7.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1033 = nil
			end

			local var_108_16 = 0
			local var_108_17 = 0.3

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_18 = arg_105_1:FormatText(StoryNameCfg[61].name)

				arg_105_1.leftNameTxt_.text = var_108_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_19 = arg_105_1:GetWordFromCfg(117032025)
				local var_108_20 = arg_105_1:FormatText(var_108_19.content)

				arg_105_1.text_.text = var_108_20

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_21 = 12
				local var_108_22 = utf8.len(var_108_20)
				local var_108_23 = var_108_21 <= 0 and var_108_17 or var_108_17 * (var_108_22 / var_108_21)

				if var_108_23 > 0 and var_108_17 < var_108_23 then
					arg_105_1.talkMaxDuration = var_108_23

					if var_108_23 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_16
					end
				end

				arg_105_1.text_.text = var_108_20
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032025", "story_v_out_117032.awb") ~= 0 then
					local var_108_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032025", "story_v_out_117032.awb") / 1000

					if var_108_24 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_24 + var_108_16
					end

					if var_108_19.prefab_name ~= "" and arg_105_1.actors_[var_108_19.prefab_name] ~= nil then
						local var_108_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_19.prefab_name].transform, "story_v_out_117032", "117032025", "story_v_out_117032.awb")

						arg_105_1:RecordAudio("117032025", var_108_25)
						arg_105_1:RecordAudio("117032025", var_108_25)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_117032", "117032025", "story_v_out_117032.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_117032", "117032025", "story_v_out_117032.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_26 = math.max(var_108_17, arg_105_1.talkMaxDuration)

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_26 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_16) / var_108_26

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_16 + var_108_26 and arg_105_1.time_ < var_108_16 + var_108_26 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play117032026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 117032026
		arg_109_1.duration_ = 10.77

		local var_109_0 = {
			zh = 9.633,
			ja = 10.766
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
				arg_109_0:Play117032027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1132"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1132 == nil then
				arg_109_1.var_.actorSpriteComps1132 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps1132 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								local var_112_4 = Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor2.r, var_112_3)
								local var_112_5 = Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor2.g, var_112_3)
								local var_112_6 = Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor2.b, var_112_3)

								iter_112_1.color = Color.New(var_112_4, var_112_5, var_112_6)
							else
								local var_112_7 = Mathf.Lerp(iter_112_1.color.r, 0.5, var_112_3)

								iter_112_1.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1132 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1132 = nil
			end

			local var_112_8 = arg_109_1.actors_["1033"]
			local var_112_9 = 0

			if var_112_9 < arg_109_1.time_ and arg_109_1.time_ <= var_112_9 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps1033 == nil then
				arg_109_1.var_.actorSpriteComps1033 = var_112_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_10 = 0.2

			if var_112_9 <= arg_109_1.time_ and arg_109_1.time_ < var_112_9 + var_112_10 and not isNil(var_112_8) then
				local var_112_11 = (arg_109_1.time_ - var_112_9) / var_112_10

				if arg_109_1.var_.actorSpriteComps1033 then
					for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_112_5 then
							if arg_109_1.isInRecall_ then
								local var_112_12 = Mathf.Lerp(iter_112_5.color.r, arg_109_1.hightColor1.r, var_112_11)
								local var_112_13 = Mathf.Lerp(iter_112_5.color.g, arg_109_1.hightColor1.g, var_112_11)
								local var_112_14 = Mathf.Lerp(iter_112_5.color.b, arg_109_1.hightColor1.b, var_112_11)

								iter_112_5.color = Color.New(var_112_12, var_112_13, var_112_14)
							else
								local var_112_15 = Mathf.Lerp(iter_112_5.color.r, 1, var_112_11)

								iter_112_5.color = Color.New(var_112_15, var_112_15, var_112_15)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_9 + var_112_10 and arg_109_1.time_ < var_112_9 + var_112_10 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps1033 then
				for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_112_7 then
						if arg_109_1.isInRecall_ then
							iter_112_7.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1033 = nil
			end

			local var_112_16 = 0
			local var_112_17 = 1.025

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_18 = arg_109_1:FormatText(StoryNameCfg[236].name)

				arg_109_1.leftNameTxt_.text = var_112_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_19 = arg_109_1:GetWordFromCfg(117032026)
				local var_112_20 = arg_109_1:FormatText(var_112_19.content)

				arg_109_1.text_.text = var_112_20

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_21 = 41
				local var_112_22 = utf8.len(var_112_20)
				local var_112_23 = var_112_21 <= 0 and var_112_17 or var_112_17 * (var_112_22 / var_112_21)

				if var_112_23 > 0 and var_112_17 < var_112_23 then
					arg_109_1.talkMaxDuration = var_112_23

					if var_112_23 + var_112_16 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_16
					end
				end

				arg_109_1.text_.text = var_112_20
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032026", "story_v_out_117032.awb") ~= 0 then
					local var_112_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032026", "story_v_out_117032.awb") / 1000

					if var_112_24 + var_112_16 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_24 + var_112_16
					end

					if var_112_19.prefab_name ~= "" and arg_109_1.actors_[var_112_19.prefab_name] ~= nil then
						local var_112_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_19.prefab_name].transform, "story_v_out_117032", "117032026", "story_v_out_117032.awb")

						arg_109_1:RecordAudio("117032026", var_112_25)
						arg_109_1:RecordAudio("117032026", var_112_25)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_117032", "117032026", "story_v_out_117032.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_117032", "117032026", "story_v_out_117032.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_26 = math.max(var_112_17, arg_109_1.talkMaxDuration)

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_26 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_16) / var_112_26

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_16 + var_112_26 and arg_109_1.time_ < var_112_16 + var_112_26 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play117032027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 117032027
		arg_113_1.duration_ = 6.17

		local var_113_0 = {
			zh = 1.333,
			ja = 6.166
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
				arg_113_0:Play117032028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1132"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps1132 == nil then
				arg_113_1.var_.actorSpriteComps1132 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps1132 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_4 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor1.r, var_116_3)
								local var_116_5 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor1.g, var_116_3)
								local var_116_6 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor1.b, var_116_3)

								iter_116_1.color = Color.New(var_116_4, var_116_5, var_116_6)
							else
								local var_116_7 = Mathf.Lerp(iter_116_1.color.r, 1, var_116_3)

								iter_116_1.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps1132 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1132 = nil
			end

			local var_116_8 = arg_113_1.actors_["1033"]
			local var_116_9 = 0

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps1033 == nil then
				arg_113_1.var_.actorSpriteComps1033 = var_116_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_10 = 0.2

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 and not isNil(var_116_8) then
				local var_116_11 = (arg_113_1.time_ - var_116_9) / var_116_10

				if arg_113_1.var_.actorSpriteComps1033 then
					for iter_116_4, iter_116_5 in pairs(arg_113_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_116_5 then
							if arg_113_1.isInRecall_ then
								local var_116_12 = Mathf.Lerp(iter_116_5.color.r, arg_113_1.hightColor2.r, var_116_11)
								local var_116_13 = Mathf.Lerp(iter_116_5.color.g, arg_113_1.hightColor2.g, var_116_11)
								local var_116_14 = Mathf.Lerp(iter_116_5.color.b, arg_113_1.hightColor2.b, var_116_11)

								iter_116_5.color = Color.New(var_116_12, var_116_13, var_116_14)
							else
								local var_116_15 = Mathf.Lerp(iter_116_5.color.r, 0.5, var_116_11)

								iter_116_5.color = Color.New(var_116_15, var_116_15, var_116_15)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps1033 then
				for iter_116_6, iter_116_7 in pairs(arg_113_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_116_7 then
						if arg_113_1.isInRecall_ then
							iter_116_7.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1033 = nil
			end

			local var_116_16 = 0
			local var_116_17 = 0.125

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_18 = arg_113_1:FormatText(StoryNameCfg[61].name)

				arg_113_1.leftNameTxt_.text = var_116_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_19 = arg_113_1:GetWordFromCfg(117032027)
				local var_116_20 = arg_113_1:FormatText(var_116_19.content)

				arg_113_1.text_.text = var_116_20

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_21 = 5
				local var_116_22 = utf8.len(var_116_20)
				local var_116_23 = var_116_21 <= 0 and var_116_17 or var_116_17 * (var_116_22 / var_116_21)

				if var_116_23 > 0 and var_116_17 < var_116_23 then
					arg_113_1.talkMaxDuration = var_116_23

					if var_116_23 + var_116_16 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_16
					end
				end

				arg_113_1.text_.text = var_116_20
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032027", "story_v_out_117032.awb") ~= 0 then
					local var_116_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032027", "story_v_out_117032.awb") / 1000

					if var_116_24 + var_116_16 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_24 + var_116_16
					end

					if var_116_19.prefab_name ~= "" and arg_113_1.actors_[var_116_19.prefab_name] ~= nil then
						local var_116_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_19.prefab_name].transform, "story_v_out_117032", "117032027", "story_v_out_117032.awb")

						arg_113_1:RecordAudio("117032027", var_116_25)
						arg_113_1:RecordAudio("117032027", var_116_25)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_117032", "117032027", "story_v_out_117032.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_117032", "117032027", "story_v_out_117032.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_26 = math.max(var_116_17, arg_113_1.talkMaxDuration)

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_26 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_16) / var_116_26

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_16 + var_116_26 and arg_113_1.time_ < var_116_16 + var_116_26 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play117032028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 117032028
		arg_117_1.duration_ = 2.67

		local var_117_0 = {
			zh = 1.133,
			ja = 2.666
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
				arg_117_0:Play117032029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1132"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps1132 == nil then
				arg_117_1.var_.actorSpriteComps1132 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps1132 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_4 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor2.r, var_120_3)
								local var_120_5 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor2.g, var_120_3)
								local var_120_6 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor2.b, var_120_3)

								iter_120_1.color = Color.New(var_120_4, var_120_5, var_120_6)
							else
								local var_120_7 = Mathf.Lerp(iter_120_1.color.r, 0.5, var_120_3)

								iter_120_1.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps1132 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1132 = nil
			end

			local var_120_8 = arg_117_1.actors_["1033"]
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps1033 == nil then
				arg_117_1.var_.actorSpriteComps1033 = var_120_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_10 = 0.2

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_10 and not isNil(var_120_8) then
				local var_120_11 = (arg_117_1.time_ - var_120_9) / var_120_10

				if arg_117_1.var_.actorSpriteComps1033 then
					for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_120_5 then
							if arg_117_1.isInRecall_ then
								local var_120_12 = Mathf.Lerp(iter_120_5.color.r, arg_117_1.hightColor1.r, var_120_11)
								local var_120_13 = Mathf.Lerp(iter_120_5.color.g, arg_117_1.hightColor1.g, var_120_11)
								local var_120_14 = Mathf.Lerp(iter_120_5.color.b, arg_117_1.hightColor1.b, var_120_11)

								iter_120_5.color = Color.New(var_120_12, var_120_13, var_120_14)
							else
								local var_120_15 = Mathf.Lerp(iter_120_5.color.r, 1, var_120_11)

								iter_120_5.color = Color.New(var_120_15, var_120_15, var_120_15)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_9 + var_120_10 and arg_117_1.time_ < var_120_9 + var_120_10 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps1033 then
				for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_120_7 then
						if arg_117_1.isInRecall_ then
							iter_120_7.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1033 = nil
			end

			local var_120_16 = arg_117_1.actors_["1033"].transform
			local var_120_17 = 0

			if var_120_17 < arg_117_1.time_ and arg_117_1.time_ <= var_120_17 + arg_120_0 then
				arg_117_1.var_.moveOldPos1033 = var_120_16.localPosition
				var_120_16.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1033", 4)

				local var_120_18 = var_120_16.childCount

				for iter_120_8 = 0, var_120_18 - 1 do
					local var_120_19 = var_120_16:GetChild(iter_120_8)

					if var_120_19.name == "split_4" or not string.find(var_120_19.name, "split") then
						var_120_19.gameObject:SetActive(true)
					else
						var_120_19.gameObject:SetActive(false)
					end
				end
			end

			local var_120_20 = 0.001

			if var_120_17 <= arg_117_1.time_ and arg_117_1.time_ < var_120_17 + var_120_20 then
				local var_120_21 = (arg_117_1.time_ - var_120_17) / var_120_20
				local var_120_22 = Vector3.New(390, -420, 0)

				var_120_16.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1033, var_120_22, var_120_21)
			end

			if arg_117_1.time_ >= var_120_17 + var_120_20 and arg_117_1.time_ < var_120_17 + var_120_20 + arg_120_0 then
				var_120_16.localPosition = Vector3.New(390, -420, 0)
			end

			local var_120_23 = 0
			local var_120_24 = 0.15

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_25 = arg_117_1:FormatText(StoryNameCfg[236].name)

				arg_117_1.leftNameTxt_.text = var_120_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_26 = arg_117_1:GetWordFromCfg(117032028)
				local var_120_27 = arg_117_1:FormatText(var_120_26.content)

				arg_117_1.text_.text = var_120_27

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_28 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032028", "story_v_out_117032.awb") ~= 0 then
					local var_120_31 = manager.audio:GetVoiceLength("story_v_out_117032", "117032028", "story_v_out_117032.awb") / 1000

					if var_120_31 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_31 + var_120_23
					end

					if var_120_26.prefab_name ~= "" and arg_117_1.actors_[var_120_26.prefab_name] ~= nil then
						local var_120_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_26.prefab_name].transform, "story_v_out_117032", "117032028", "story_v_out_117032.awb")

						arg_117_1:RecordAudio("117032028", var_120_32)
						arg_117_1:RecordAudio("117032028", var_120_32)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_117032", "117032028", "story_v_out_117032.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_117032", "117032028", "story_v_out_117032.awb")
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
				actorName = "1033",
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
	Play117032029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 117032029
		arg_121_1.duration_ = 10.33

		local var_121_0 = {
			zh = 8.5,
			ja = 10.333
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
				arg_121_0:Play117032030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1132"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps1132 == nil then
				arg_121_1.var_.actorSpriteComps1132 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps1132 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								local var_124_4 = Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor1.r, var_124_3)
								local var_124_5 = Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor1.g, var_124_3)
								local var_124_6 = Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor1.b, var_124_3)

								iter_124_1.color = Color.New(var_124_4, var_124_5, var_124_6)
							else
								local var_124_7 = Mathf.Lerp(iter_124_1.color.r, 1, var_124_3)

								iter_124_1.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps1132 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1132 = nil
			end

			local var_124_8 = arg_121_1.actors_["1033"]
			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps1033 == nil then
				arg_121_1.var_.actorSpriteComps1033 = var_124_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_10 = 0.2

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_10 and not isNil(var_124_8) then
				local var_124_11 = (arg_121_1.time_ - var_124_9) / var_124_10

				if arg_121_1.var_.actorSpriteComps1033 then
					for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_124_5 then
							if arg_121_1.isInRecall_ then
								local var_124_12 = Mathf.Lerp(iter_124_5.color.r, arg_121_1.hightColor2.r, var_124_11)
								local var_124_13 = Mathf.Lerp(iter_124_5.color.g, arg_121_1.hightColor2.g, var_124_11)
								local var_124_14 = Mathf.Lerp(iter_124_5.color.b, arg_121_1.hightColor2.b, var_124_11)

								iter_124_5.color = Color.New(var_124_12, var_124_13, var_124_14)
							else
								local var_124_15 = Mathf.Lerp(iter_124_5.color.r, 0.5, var_124_11)

								iter_124_5.color = Color.New(var_124_15, var_124_15, var_124_15)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_9 + var_124_10 and arg_121_1.time_ < var_124_9 + var_124_10 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps1033 then
				for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_124_7 then
						if arg_121_1.isInRecall_ then
							iter_124_7.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1033 = nil
			end

			local var_124_16 = 0
			local var_124_17 = 1.15

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_18 = arg_121_1:FormatText(StoryNameCfg[61].name)

				arg_121_1.leftNameTxt_.text = var_124_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_19 = arg_121_1:GetWordFromCfg(117032029)
				local var_124_20 = arg_121_1:FormatText(var_124_19.content)

				arg_121_1.text_.text = var_124_20

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_21 = 46
				local var_124_22 = utf8.len(var_124_20)
				local var_124_23 = var_124_21 <= 0 and var_124_17 or var_124_17 * (var_124_22 / var_124_21)

				if var_124_23 > 0 and var_124_17 < var_124_23 then
					arg_121_1.talkMaxDuration = var_124_23

					if var_124_23 + var_124_16 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_16
					end
				end

				arg_121_1.text_.text = var_124_20
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032029", "story_v_out_117032.awb") ~= 0 then
					local var_124_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032029", "story_v_out_117032.awb") / 1000

					if var_124_24 + var_124_16 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_24 + var_124_16
					end

					if var_124_19.prefab_name ~= "" and arg_121_1.actors_[var_124_19.prefab_name] ~= nil then
						local var_124_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_19.prefab_name].transform, "story_v_out_117032", "117032029", "story_v_out_117032.awb")

						arg_121_1:RecordAudio("117032029", var_124_25)
						arg_121_1:RecordAudio("117032029", var_124_25)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_117032", "117032029", "story_v_out_117032.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_117032", "117032029", "story_v_out_117032.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_26 = math.max(var_124_17, arg_121_1.talkMaxDuration)

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_26 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_16) / var_124_26

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_16 + var_124_26 and arg_121_1.time_ < var_124_16 + var_124_26 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play117032030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 117032030
		arg_125_1.duration_ = 7.13

		local var_125_0 = {
			zh = 4,
			ja = 7.133
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play117032031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1132"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps1132 == nil then
				arg_125_1.var_.actorSpriteComps1132 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps1132 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps1132 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1132 = nil
			end

			local var_128_8 = arg_125_1.actors_["1033"]
			local var_128_9 = 0

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps1033 == nil then
				arg_125_1.var_.actorSpriteComps1033 = var_128_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_10 = 0.2

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_10 and not isNil(var_128_8) then
				local var_128_11 = (arg_125_1.time_ - var_128_9) / var_128_10

				if arg_125_1.var_.actorSpriteComps1033 then
					for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_128_5 then
							if arg_125_1.isInRecall_ then
								local var_128_12 = Mathf.Lerp(iter_128_5.color.r, arg_125_1.hightColor1.r, var_128_11)
								local var_128_13 = Mathf.Lerp(iter_128_5.color.g, arg_125_1.hightColor1.g, var_128_11)
								local var_128_14 = Mathf.Lerp(iter_128_5.color.b, arg_125_1.hightColor1.b, var_128_11)

								iter_128_5.color = Color.New(var_128_12, var_128_13, var_128_14)
							else
								local var_128_15 = Mathf.Lerp(iter_128_5.color.r, 1, var_128_11)

								iter_128_5.color = Color.New(var_128_15, var_128_15, var_128_15)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_9 + var_128_10 and arg_125_1.time_ < var_128_9 + var_128_10 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps1033 then
				for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_128_7 then
						if arg_125_1.isInRecall_ then
							iter_128_7.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1033 = nil
			end

			local var_128_16 = arg_125_1.actors_["1033"].transform
			local var_128_17 = 0

			if var_128_17 < arg_125_1.time_ and arg_125_1.time_ <= var_128_17 + arg_128_0 then
				arg_125_1.var_.moveOldPos1033 = var_128_16.localPosition
				var_128_16.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1033", 4)

				local var_128_18 = var_128_16.childCount

				for iter_128_8 = 0, var_128_18 - 1 do
					local var_128_19 = var_128_16:GetChild(iter_128_8)

					if var_128_19.name == "split_6" or not string.find(var_128_19.name, "split") then
						var_128_19.gameObject:SetActive(true)
					else
						var_128_19.gameObject:SetActive(false)
					end
				end
			end

			local var_128_20 = 0.001

			if var_128_17 <= arg_125_1.time_ and arg_125_1.time_ < var_128_17 + var_128_20 then
				local var_128_21 = (arg_125_1.time_ - var_128_17) / var_128_20
				local var_128_22 = Vector3.New(390, -420, 0)

				var_128_16.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1033, var_128_22, var_128_21)
			end

			if arg_125_1.time_ >= var_128_17 + var_128_20 and arg_125_1.time_ < var_128_17 + var_128_20 + arg_128_0 then
				var_128_16.localPosition = Vector3.New(390, -420, 0)
			end

			local var_128_23 = 0
			local var_128_24 = 0.375

			if var_128_23 < arg_125_1.time_ and arg_125_1.time_ <= var_128_23 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_25 = arg_125_1:FormatText(StoryNameCfg[236].name)

				arg_125_1.leftNameTxt_.text = var_128_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_26 = arg_125_1:GetWordFromCfg(117032030)
				local var_128_27 = arg_125_1:FormatText(var_128_26.content)

				arg_125_1.text_.text = var_128_27

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_28 = 15
				local var_128_29 = utf8.len(var_128_27)
				local var_128_30 = var_128_28 <= 0 and var_128_24 or var_128_24 * (var_128_29 / var_128_28)

				if var_128_30 > 0 and var_128_24 < var_128_30 then
					arg_125_1.talkMaxDuration = var_128_30

					if var_128_30 + var_128_23 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_30 + var_128_23
					end
				end

				arg_125_1.text_.text = var_128_27
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032030", "story_v_out_117032.awb") ~= 0 then
					local var_128_31 = manager.audio:GetVoiceLength("story_v_out_117032", "117032030", "story_v_out_117032.awb") / 1000

					if var_128_31 + var_128_23 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_31 + var_128_23
					end

					if var_128_26.prefab_name ~= "" and arg_125_1.actors_[var_128_26.prefab_name] ~= nil then
						local var_128_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_26.prefab_name].transform, "story_v_out_117032", "117032030", "story_v_out_117032.awb")

						arg_125_1:RecordAudio("117032030", var_128_32)
						arg_125_1:RecordAudio("117032030", var_128_32)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_117032", "117032030", "story_v_out_117032.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_117032", "117032030", "story_v_out_117032.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_33 = math.max(var_128_24, arg_125_1.talkMaxDuration)

			if var_128_23 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_33 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_23) / var_128_33

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_23 + var_128_33 and arg_125_1.time_ < var_128_23 + var_128_33 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play117032031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 117032031
		arg_129_1.duration_ = 7

		local var_129_0 = {
			zh = 7,
			ja = 6.5
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
				arg_129_0:Play117032032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.85

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[236].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(117032031)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 34
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032031", "story_v_out_117032.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032031", "story_v_out_117032.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_117032", "117032031", "story_v_out_117032.awb")

						arg_129_1:RecordAudio("117032031", var_132_9)
						arg_129_1:RecordAudio("117032031", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_117032", "117032031", "story_v_out_117032.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_117032", "117032031", "story_v_out_117032.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play117032032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 117032032
		arg_133_1.duration_ = 4.37

		local var_133_0 = {
			zh = 2.066,
			ja = 4.366
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
				arg_133_0:Play117032033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.275

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[236].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(117032032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 11
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032032", "story_v_out_117032.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032032", "story_v_out_117032.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_117032", "117032032", "story_v_out_117032.awb")

						arg_133_1:RecordAudio("117032032", var_136_9)
						arg_133_1:RecordAudio("117032032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_117032", "117032032", "story_v_out_117032.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_117032", "117032032", "story_v_out_117032.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play117032033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 117032033
		arg_137_1.duration_ = 3.67

		local var_137_0 = {
			zh = 1.033,
			ja = 3.666
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
				arg_137_0:Play117032034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1132"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1132 == nil then
				arg_137_1.var_.actorSpriteComps1132 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps1132 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								local var_140_4 = Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor1.r, var_140_3)
								local var_140_5 = Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor1.g, var_140_3)
								local var_140_6 = Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor1.b, var_140_3)

								iter_140_1.color = Color.New(var_140_4, var_140_5, var_140_6)
							else
								local var_140_7 = Mathf.Lerp(iter_140_1.color.r, 1, var_140_3)

								iter_140_1.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps1132 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1132 = nil
			end

			local var_140_8 = arg_137_1.actors_["1033"]
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps1033 == nil then
				arg_137_1.var_.actorSpriteComps1033 = var_140_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_10 = 0.2

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_10 and not isNil(var_140_8) then
				local var_140_11 = (arg_137_1.time_ - var_140_9) / var_140_10

				if arg_137_1.var_.actorSpriteComps1033 then
					for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_140_5 then
							if arg_137_1.isInRecall_ then
								local var_140_12 = Mathf.Lerp(iter_140_5.color.r, arg_137_1.hightColor2.r, var_140_11)
								local var_140_13 = Mathf.Lerp(iter_140_5.color.g, arg_137_1.hightColor2.g, var_140_11)
								local var_140_14 = Mathf.Lerp(iter_140_5.color.b, arg_137_1.hightColor2.b, var_140_11)

								iter_140_5.color = Color.New(var_140_12, var_140_13, var_140_14)
							else
								local var_140_15 = Mathf.Lerp(iter_140_5.color.r, 0.5, var_140_11)

								iter_140_5.color = Color.New(var_140_15, var_140_15, var_140_15)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_9 + var_140_10 and arg_137_1.time_ < var_140_9 + var_140_10 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps1033 then
				for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_140_7 then
						if arg_137_1.isInRecall_ then
							iter_140_7.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1033 = nil
			end

			local var_140_16 = 0
			local var_140_17 = 0.125

			if var_140_16 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_18 = arg_137_1:FormatText(StoryNameCfg[61].name)

				arg_137_1.leftNameTxt_.text = var_140_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_19 = arg_137_1:GetWordFromCfg(117032033)
				local var_140_20 = arg_137_1:FormatText(var_140_19.content)

				arg_137_1.text_.text = var_140_20

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_21 = 5
				local var_140_22 = utf8.len(var_140_20)
				local var_140_23 = var_140_21 <= 0 and var_140_17 or var_140_17 * (var_140_22 / var_140_21)

				if var_140_23 > 0 and var_140_17 < var_140_23 then
					arg_137_1.talkMaxDuration = var_140_23

					if var_140_23 + var_140_16 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_16
					end
				end

				arg_137_1.text_.text = var_140_20
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032033", "story_v_out_117032.awb") ~= 0 then
					local var_140_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032033", "story_v_out_117032.awb") / 1000

					if var_140_24 + var_140_16 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_24 + var_140_16
					end

					if var_140_19.prefab_name ~= "" and arg_137_1.actors_[var_140_19.prefab_name] ~= nil then
						local var_140_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_19.prefab_name].transform, "story_v_out_117032", "117032033", "story_v_out_117032.awb")

						arg_137_1:RecordAudio("117032033", var_140_25)
						arg_137_1:RecordAudio("117032033", var_140_25)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_117032", "117032033", "story_v_out_117032.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_117032", "117032033", "story_v_out_117032.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_26 = math.max(var_140_17, arg_137_1.talkMaxDuration)

			if var_140_16 <= arg_137_1.time_ and arg_137_1.time_ < var_140_16 + var_140_26 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_16) / var_140_26

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_16 + var_140_26 and arg_137_1.time_ < var_140_16 + var_140_26 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play117032034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 117032034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play117032035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1132"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps1132 == nil then
				arg_141_1.var_.actorSpriteComps1132 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps1132 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps1132 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps1132 = nil
			end

			local var_144_8 = 0
			local var_144_9 = 0.95

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

				local var_144_10 = arg_141_1:GetWordFromCfg(117032034)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_12 = 38
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
	Play117032035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 117032035
		arg_145_1.duration_ = 6.3

		local var_145_0 = {
			zh = 2.566,
			ja = 6.3
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play117032036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1132"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1132 == nil then
				arg_145_1.var_.actorSpriteComps1132 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps1132 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								local var_148_4 = Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor1.r, var_148_3)
								local var_148_5 = Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor1.g, var_148_3)
								local var_148_6 = Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor1.b, var_148_3)

								iter_148_1.color = Color.New(var_148_4, var_148_5, var_148_6)
							else
								local var_148_7 = Mathf.Lerp(iter_148_1.color.r, 1, var_148_3)

								iter_148_1.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1132 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1132 = nil
			end

			local var_148_8 = 0
			local var_148_9 = 0.35

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_10 = arg_145_1:FormatText(StoryNameCfg[61].name)

				arg_145_1.leftNameTxt_.text = var_148_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_11 = arg_145_1:GetWordFromCfg(117032035)
				local var_148_12 = arg_145_1:FormatText(var_148_11.content)

				arg_145_1.text_.text = var_148_12

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 14
				local var_148_14 = utf8.len(var_148_12)
				local var_148_15 = var_148_13 <= 0 and var_148_9 or var_148_9 * (var_148_14 / var_148_13)

				if var_148_15 > 0 and var_148_9 < var_148_15 then
					arg_145_1.talkMaxDuration = var_148_15

					if var_148_15 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_15 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_12
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032035", "story_v_out_117032.awb") ~= 0 then
					local var_148_16 = manager.audio:GetVoiceLength("story_v_out_117032", "117032035", "story_v_out_117032.awb") / 1000

					if var_148_16 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_16 + var_148_8
					end

					if var_148_11.prefab_name ~= "" and arg_145_1.actors_[var_148_11.prefab_name] ~= nil then
						local var_148_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_11.prefab_name].transform, "story_v_out_117032", "117032035", "story_v_out_117032.awb")

						arg_145_1:RecordAudio("117032035", var_148_17)
						arg_145_1:RecordAudio("117032035", var_148_17)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_117032", "117032035", "story_v_out_117032.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_117032", "117032035", "story_v_out_117032.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_18 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_18 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_18

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_18 and arg_145_1.time_ < var_148_8 + var_148_18 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play117032036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 117032036
		arg_149_1.duration_ = 9.3

		local var_149_0 = {
			zh = 8.133,
			ja = 9.3
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
				arg_149_0:Play117032037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 1.1

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[61].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(117032036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 44
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032036", "story_v_out_117032.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032036", "story_v_out_117032.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_117032", "117032036", "story_v_out_117032.awb")

						arg_149_1:RecordAudio("117032036", var_152_9)
						arg_149_1:RecordAudio("117032036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_117032", "117032036", "story_v_out_117032.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_117032", "117032036", "story_v_out_117032.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play117032037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 117032037
		arg_153_1.duration_ = 9.87

		local var_153_0 = {
			zh = 5.8,
			ja = 9.866
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
				arg_153_0:Play117032038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1132"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1132 == nil then
				arg_153_1.var_.actorSpriteComps1132 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps1132 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								local var_156_4 = Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor2.r, var_156_3)
								local var_156_5 = Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor2.g, var_156_3)
								local var_156_6 = Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor2.b, var_156_3)

								iter_156_1.color = Color.New(var_156_4, var_156_5, var_156_6)
							else
								local var_156_7 = Mathf.Lerp(iter_156_1.color.r, 0.5, var_156_3)

								iter_156_1.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1132 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1132 = nil
			end

			local var_156_8 = arg_153_1.actors_["1033"]
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps1033 == nil then
				arg_153_1.var_.actorSpriteComps1033 = var_156_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_10 = 0.2

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_10 and not isNil(var_156_8) then
				local var_156_11 = (arg_153_1.time_ - var_156_9) / var_156_10

				if arg_153_1.var_.actorSpriteComps1033 then
					for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_156_5 then
							if arg_153_1.isInRecall_ then
								local var_156_12 = Mathf.Lerp(iter_156_5.color.r, arg_153_1.hightColor1.r, var_156_11)
								local var_156_13 = Mathf.Lerp(iter_156_5.color.g, arg_153_1.hightColor1.g, var_156_11)
								local var_156_14 = Mathf.Lerp(iter_156_5.color.b, arg_153_1.hightColor1.b, var_156_11)

								iter_156_5.color = Color.New(var_156_12, var_156_13, var_156_14)
							else
								local var_156_15 = Mathf.Lerp(iter_156_5.color.r, 1, var_156_11)

								iter_156_5.color = Color.New(var_156_15, var_156_15, var_156_15)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_9 + var_156_10 and arg_153_1.time_ < var_156_9 + var_156_10 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps1033 then
				for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_156_7 then
						if arg_153_1.isInRecall_ then
							iter_156_7.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1033 = nil
			end

			local var_156_16 = 0
			local var_156_17 = 0.7

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_18 = arg_153_1:FormatText(StoryNameCfg[236].name)

				arg_153_1.leftNameTxt_.text = var_156_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_19 = arg_153_1:GetWordFromCfg(117032037)
				local var_156_20 = arg_153_1:FormatText(var_156_19.content)

				arg_153_1.text_.text = var_156_20

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_21 = 28
				local var_156_22 = utf8.len(var_156_20)
				local var_156_23 = var_156_21 <= 0 and var_156_17 or var_156_17 * (var_156_22 / var_156_21)

				if var_156_23 > 0 and var_156_17 < var_156_23 then
					arg_153_1.talkMaxDuration = var_156_23

					if var_156_23 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_16
					end
				end

				arg_153_1.text_.text = var_156_20
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032037", "story_v_out_117032.awb") ~= 0 then
					local var_156_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032037", "story_v_out_117032.awb") / 1000

					if var_156_24 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_24 + var_156_16
					end

					if var_156_19.prefab_name ~= "" and arg_153_1.actors_[var_156_19.prefab_name] ~= nil then
						local var_156_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_19.prefab_name].transform, "story_v_out_117032", "117032037", "story_v_out_117032.awb")

						arg_153_1:RecordAudio("117032037", var_156_25)
						arg_153_1:RecordAudio("117032037", var_156_25)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_117032", "117032037", "story_v_out_117032.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_117032", "117032037", "story_v_out_117032.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_26 = math.max(var_156_17, arg_153_1.talkMaxDuration)

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_26 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_16) / var_156_26

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_16 + var_156_26 and arg_153_1.time_ < var_156_16 + var_156_26 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play117032038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 117032038
		arg_157_1.duration_ = 9.9

		local var_157_0 = {
			zh = 4.566,
			ja = 9.9
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
				arg_157_0:Play117032039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1132"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1132 == nil then
				arg_157_1.var_.actorSpriteComps1132 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps1132 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								local var_160_4 = Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor1.r, var_160_3)
								local var_160_5 = Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor1.g, var_160_3)
								local var_160_6 = Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor1.b, var_160_3)

								iter_160_1.color = Color.New(var_160_4, var_160_5, var_160_6)
							else
								local var_160_7 = Mathf.Lerp(iter_160_1.color.r, 1, var_160_3)

								iter_160_1.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1132 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1132 = nil
			end

			local var_160_8 = arg_157_1.actors_["1033"]
			local var_160_9 = 0

			if var_160_9 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps1033 == nil then
				arg_157_1.var_.actorSpriteComps1033 = var_160_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_10 = 0.2

			if var_160_9 <= arg_157_1.time_ and arg_157_1.time_ < var_160_9 + var_160_10 and not isNil(var_160_8) then
				local var_160_11 = (arg_157_1.time_ - var_160_9) / var_160_10

				if arg_157_1.var_.actorSpriteComps1033 then
					for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_160_5 then
							if arg_157_1.isInRecall_ then
								local var_160_12 = Mathf.Lerp(iter_160_5.color.r, arg_157_1.hightColor2.r, var_160_11)
								local var_160_13 = Mathf.Lerp(iter_160_5.color.g, arg_157_1.hightColor2.g, var_160_11)
								local var_160_14 = Mathf.Lerp(iter_160_5.color.b, arg_157_1.hightColor2.b, var_160_11)

								iter_160_5.color = Color.New(var_160_12, var_160_13, var_160_14)
							else
								local var_160_15 = Mathf.Lerp(iter_160_5.color.r, 0.5, var_160_11)

								iter_160_5.color = Color.New(var_160_15, var_160_15, var_160_15)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_9 + var_160_10 and arg_157_1.time_ < var_160_9 + var_160_10 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps1033 then
				for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_160_7 then
						if arg_157_1.isInRecall_ then
							iter_160_7.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1033 = nil
			end

			local var_160_16 = 0
			local var_160_17 = 0.5

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_18 = arg_157_1:FormatText(StoryNameCfg[61].name)

				arg_157_1.leftNameTxt_.text = var_160_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_19 = arg_157_1:GetWordFromCfg(117032038)
				local var_160_20 = arg_157_1:FormatText(var_160_19.content)

				arg_157_1.text_.text = var_160_20

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_21 = 20
				local var_160_22 = utf8.len(var_160_20)
				local var_160_23 = var_160_21 <= 0 and var_160_17 or var_160_17 * (var_160_22 / var_160_21)

				if var_160_23 > 0 and var_160_17 < var_160_23 then
					arg_157_1.talkMaxDuration = var_160_23

					if var_160_23 + var_160_16 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_23 + var_160_16
					end
				end

				arg_157_1.text_.text = var_160_20
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032038", "story_v_out_117032.awb") ~= 0 then
					local var_160_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032038", "story_v_out_117032.awb") / 1000

					if var_160_24 + var_160_16 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_24 + var_160_16
					end

					if var_160_19.prefab_name ~= "" and arg_157_1.actors_[var_160_19.prefab_name] ~= nil then
						local var_160_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_19.prefab_name].transform, "story_v_out_117032", "117032038", "story_v_out_117032.awb")

						arg_157_1:RecordAudio("117032038", var_160_25)
						arg_157_1:RecordAudio("117032038", var_160_25)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_117032", "117032038", "story_v_out_117032.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_117032", "117032038", "story_v_out_117032.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_26 = math.max(var_160_17, arg_157_1.talkMaxDuration)

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_26 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_16) / var_160_26

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_16 + var_160_26 and arg_157_1.time_ < var_160_16 + var_160_26 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play117032039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 117032039
		arg_161_1.duration_ = 15.97

		local var_161_0 = {
			zh = 12.1,
			ja = 15.966
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
				arg_161_0:Play117032040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1132"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1132 == nil then
				arg_161_1.var_.actorSpriteComps1132 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps1132 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1132 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps1132 = nil
			end

			local var_164_8 = arg_161_1.actors_["1033"]
			local var_164_9 = 0

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps1033 == nil then
				arg_161_1.var_.actorSpriteComps1033 = var_164_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_10 = 0.2

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_10 and not isNil(var_164_8) then
				local var_164_11 = (arg_161_1.time_ - var_164_9) / var_164_10

				if arg_161_1.var_.actorSpriteComps1033 then
					for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_164_5 then
							if arg_161_1.isInRecall_ then
								local var_164_12 = Mathf.Lerp(iter_164_5.color.r, arg_161_1.hightColor1.r, var_164_11)
								local var_164_13 = Mathf.Lerp(iter_164_5.color.g, arg_161_1.hightColor1.g, var_164_11)
								local var_164_14 = Mathf.Lerp(iter_164_5.color.b, arg_161_1.hightColor1.b, var_164_11)

								iter_164_5.color = Color.New(var_164_12, var_164_13, var_164_14)
							else
								local var_164_15 = Mathf.Lerp(iter_164_5.color.r, 1, var_164_11)

								iter_164_5.color = Color.New(var_164_15, var_164_15, var_164_15)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_9 + var_164_10 and arg_161_1.time_ < var_164_9 + var_164_10 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps1033 then
				for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_164_7 then
						if arg_161_1.isInRecall_ then
							iter_164_7.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps1033 = nil
			end

			local var_164_16 = 0
			local var_164_17 = 1.15

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_18 = arg_161_1:FormatText(StoryNameCfg[236].name)

				arg_161_1.leftNameTxt_.text = var_164_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_19 = arg_161_1:GetWordFromCfg(117032039)
				local var_164_20 = arg_161_1:FormatText(var_164_19.content)

				arg_161_1.text_.text = var_164_20

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_21 = 46
				local var_164_22 = utf8.len(var_164_20)
				local var_164_23 = var_164_21 <= 0 and var_164_17 or var_164_17 * (var_164_22 / var_164_21)

				if var_164_23 > 0 and var_164_17 < var_164_23 then
					arg_161_1.talkMaxDuration = var_164_23

					if var_164_23 + var_164_16 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_23 + var_164_16
					end
				end

				arg_161_1.text_.text = var_164_20
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032039", "story_v_out_117032.awb") ~= 0 then
					local var_164_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032039", "story_v_out_117032.awb") / 1000

					if var_164_24 + var_164_16 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_24 + var_164_16
					end

					if var_164_19.prefab_name ~= "" and arg_161_1.actors_[var_164_19.prefab_name] ~= nil then
						local var_164_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_19.prefab_name].transform, "story_v_out_117032", "117032039", "story_v_out_117032.awb")

						arg_161_1:RecordAudio("117032039", var_164_25)
						arg_161_1:RecordAudio("117032039", var_164_25)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_117032", "117032039", "story_v_out_117032.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_117032", "117032039", "story_v_out_117032.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_26 = math.max(var_164_17, arg_161_1.talkMaxDuration)

			if var_164_16 <= arg_161_1.time_ and arg_161_1.time_ < var_164_16 + var_164_26 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_16) / var_164_26

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_16 + var_164_26 and arg_161_1.time_ < var_164_16 + var_164_26 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play117032040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 117032040
		arg_165_1.duration_ = 7.07

		local var_165_0 = {
			zh = 7.066,
			ja = 4.533
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
				arg_165_0:Play117032041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.925

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[236].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(117032040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032040", "story_v_out_117032.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032040", "story_v_out_117032.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_117032", "117032040", "story_v_out_117032.awb")

						arg_165_1:RecordAudio("117032040", var_168_9)
						arg_165_1:RecordAudio("117032040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_117032", "117032040", "story_v_out_117032.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_117032", "117032040", "story_v_out_117032.awb")
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
	Play117032041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 117032041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play117032042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1033"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps1033 == nil then
				arg_169_1.var_.actorSpriteComps1033 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps1033 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								local var_172_4 = Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor2.r, var_172_3)
								local var_172_5 = Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor2.g, var_172_3)
								local var_172_6 = Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor2.b, var_172_3)

								iter_172_1.color = Color.New(var_172_4, var_172_5, var_172_6)
							else
								local var_172_7 = Mathf.Lerp(iter_172_1.color.r, 0.5, var_172_3)

								iter_172_1.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps1033 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps1033 = nil
			end

			local var_172_8 = 0
			local var_172_9 = 0.675

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_10 = arg_169_1:GetWordFromCfg(117032041)
				local var_172_11 = arg_169_1:FormatText(var_172_10.content)

				arg_169_1.text_.text = var_172_11

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_12 = 27
				local var_172_13 = utf8.len(var_172_11)
				local var_172_14 = var_172_12 <= 0 and var_172_9 or var_172_9 * (var_172_13 / var_172_12)

				if var_172_14 > 0 and var_172_9 < var_172_14 then
					arg_169_1.talkMaxDuration = var_172_14

					if var_172_14 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_11
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_15 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_15 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_15

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_15 and arg_169_1.time_ < var_172_8 + var_172_15 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play117032042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 117032042
		arg_173_1.duration_ = 11

		local var_173_0 = {
			zh = 11,
			ja = 8.133
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
				arg_173_0:Play117032043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1033"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps1033 == nil then
				arg_173_1.var_.actorSpriteComps1033 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps1033 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 1, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps1033 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps1033 = nil
			end

			local var_176_8 = 0
			local var_176_9 = 1.175

			if var_176_8 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_10 = arg_173_1:FormatText(StoryNameCfg[236].name)

				arg_173_1.leftNameTxt_.text = var_176_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_11 = arg_173_1:GetWordFromCfg(117032042)
				local var_176_12 = arg_173_1:FormatText(var_176_11.content)

				arg_173_1.text_.text = var_176_12

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 47
				local var_176_14 = utf8.len(var_176_12)
				local var_176_15 = var_176_13 <= 0 and var_176_9 or var_176_9 * (var_176_14 / var_176_13)

				if var_176_15 > 0 and var_176_9 < var_176_15 then
					arg_173_1.talkMaxDuration = var_176_15

					if var_176_15 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_15 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_12
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032042", "story_v_out_117032.awb") ~= 0 then
					local var_176_16 = manager.audio:GetVoiceLength("story_v_out_117032", "117032042", "story_v_out_117032.awb") / 1000

					if var_176_16 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_16 + var_176_8
					end

					if var_176_11.prefab_name ~= "" and arg_173_1.actors_[var_176_11.prefab_name] ~= nil then
						local var_176_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_11.prefab_name].transform, "story_v_out_117032", "117032042", "story_v_out_117032.awb")

						arg_173_1:RecordAudio("117032042", var_176_17)
						arg_173_1:RecordAudio("117032042", var_176_17)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_117032", "117032042", "story_v_out_117032.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_117032", "117032042", "story_v_out_117032.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_18 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_18 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_18

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_18 and arg_173_1.time_ < var_176_8 + var_176_18 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play117032043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 117032043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play117032044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1033"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1033 == nil then
				arg_177_1.var_.actorSpriteComps1033 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps1033 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_4 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor2.r, var_180_3)
								local var_180_5 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor2.g, var_180_3)
								local var_180_6 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor2.b, var_180_3)

								iter_180_1.color = Color.New(var_180_4, var_180_5, var_180_6)
							else
								local var_180_7 = Mathf.Lerp(iter_180_1.color.r, 0.5, var_180_3)

								iter_180_1.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1033 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1033 = nil
			end

			local var_180_8 = 0
			local var_180_9 = 0.675

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(117032043)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_12 = 27
				local var_180_13 = utf8.len(var_180_11)
				local var_180_14 = var_180_12 <= 0 and var_180_9 or var_180_9 * (var_180_13 / var_180_12)

				if var_180_14 > 0 and var_180_9 < var_180_14 then
					arg_177_1.talkMaxDuration = var_180_14

					if var_180_14 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_15 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_15 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_15

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_15 and arg_177_1.time_ < var_180_8 + var_180_15 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play117032044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 117032044
		arg_181_1.duration_ = 3.47

		local var_181_0 = {
			zh = 2.966,
			ja = 3.466
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
				arg_181_0:Play117032045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.25

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[369].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_4")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(117032044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 10
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032044", "story_v_out_117032.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032044", "story_v_out_117032.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_117032", "117032044", "story_v_out_117032.awb")

						arg_181_1:RecordAudio("117032044", var_184_9)
						arg_181_1:RecordAudio("117032044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_117032", "117032044", "story_v_out_117032.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_117032", "117032044", "story_v_out_117032.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_10 and arg_181_1.time_ < var_184_0 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play117032045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 117032045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play117032046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.65

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(117032045)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 26
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play117032046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 117032046
		arg_189_1.duration_ = 2.5

		local var_189_0 = {
			zh = 2.133,
			ja = 2.5
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
				arg_189_0:Play117032047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = "10035"

			if arg_189_1.actors_[var_192_0] == nil then
				local var_192_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10035")

				if not isNil(var_192_1) then
					local var_192_2 = Object.Instantiate(var_192_1, arg_189_1.canvasGo_.transform)

					var_192_2.transform:SetSiblingIndex(1)

					var_192_2.name = var_192_0
					var_192_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_189_1.actors_[var_192_0] = var_192_2

					local var_192_3 = var_192_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_189_1.isInRecall_ then
						for iter_192_0, iter_192_1 in ipairs(var_192_3) do
							iter_192_1.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_192_4 = arg_189_1.actors_["10035"].transform
			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.var_.moveOldPos10035 = var_192_4.localPosition
				var_192_4.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10035", 4)

				local var_192_6 = var_192_4.childCount

				for iter_192_2 = 0, var_192_6 - 1 do
					local var_192_7 = var_192_4:GetChild(iter_192_2)

					if var_192_7.name == "split_1" or not string.find(var_192_7.name, "split") then
						var_192_7.gameObject:SetActive(true)
					else
						var_192_7.gameObject:SetActive(false)
					end
				end
			end

			local var_192_8 = 0.001

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_8 then
				local var_192_9 = (arg_189_1.time_ - var_192_5) / var_192_8
				local var_192_10 = Vector3.New(390, -410, -235)

				var_192_4.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10035, var_192_10, var_192_9)
			end

			if arg_189_1.time_ >= var_192_5 + var_192_8 and arg_189_1.time_ < var_192_5 + var_192_8 + arg_192_0 then
				var_192_4.localPosition = Vector3.New(390, -410, -235)
			end

			local var_192_11 = arg_189_1.actors_["10035"]
			local var_192_12 = 0

			if var_192_12 < arg_189_1.time_ and arg_189_1.time_ <= var_192_12 + arg_192_0 and not isNil(var_192_11) and arg_189_1.var_.actorSpriteComps10035 == nil then
				arg_189_1.var_.actorSpriteComps10035 = var_192_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_13 = 0.2

			if var_192_12 <= arg_189_1.time_ and arg_189_1.time_ < var_192_12 + var_192_13 and not isNil(var_192_11) then
				local var_192_14 = (arg_189_1.time_ - var_192_12) / var_192_13

				if arg_189_1.var_.actorSpriteComps10035 then
					for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_192_4 then
							if arg_189_1.isInRecall_ then
								local var_192_15 = Mathf.Lerp(iter_192_4.color.r, arg_189_1.hightColor1.r, var_192_14)
								local var_192_16 = Mathf.Lerp(iter_192_4.color.g, arg_189_1.hightColor1.g, var_192_14)
								local var_192_17 = Mathf.Lerp(iter_192_4.color.b, arg_189_1.hightColor1.b, var_192_14)

								iter_192_4.color = Color.New(var_192_15, var_192_16, var_192_17)
							else
								local var_192_18 = Mathf.Lerp(iter_192_4.color.r, 1, var_192_14)

								iter_192_4.color = Color.New(var_192_18, var_192_18, var_192_18)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_12 + var_192_13 and arg_189_1.time_ < var_192_12 + var_192_13 + arg_192_0 and not isNil(var_192_11) and arg_189_1.var_.actorSpriteComps10035 then
				for iter_192_5, iter_192_6 in pairs(arg_189_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_192_6 then
						if arg_189_1.isInRecall_ then
							iter_192_6.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10035 = nil
			end

			local var_192_19 = arg_189_1.actors_["10035"]
			local var_192_20 = 0

			if var_192_20 < arg_189_1.time_ and arg_189_1.time_ <= var_192_20 + arg_192_0 then
				local var_192_21 = var_192_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_192_21 then
					arg_189_1.var_.alphaOldValue10035 = var_192_21.alpha
					arg_189_1.var_.characterEffect10035 = var_192_21
				end

				arg_189_1.var_.alphaOldValue10035 = 0
			end

			local var_192_22 = 0.33

			if var_192_20 <= arg_189_1.time_ and arg_189_1.time_ < var_192_20 + var_192_22 then
				local var_192_23 = (arg_189_1.time_ - var_192_20) / var_192_22
				local var_192_24 = Mathf.Lerp(arg_189_1.var_.alphaOldValue10035, 1, var_192_23)

				if arg_189_1.var_.characterEffect10035 then
					arg_189_1.var_.characterEffect10035.alpha = var_192_24
				end
			end

			if arg_189_1.time_ >= var_192_20 + var_192_22 and arg_189_1.time_ < var_192_20 + var_192_22 + arg_192_0 and arg_189_1.var_.characterEffect10035 then
				arg_189_1.var_.characterEffect10035.alpha = 1
			end

			local var_192_25 = 0
			local var_192_26 = 0.15

			if var_192_25 < arg_189_1.time_ and arg_189_1.time_ <= var_192_25 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_27 = arg_189_1:FormatText(StoryNameCfg[369].name)

				arg_189_1.leftNameTxt_.text = var_192_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_28 = arg_189_1:GetWordFromCfg(117032046)
				local var_192_29 = arg_189_1:FormatText(var_192_28.content)

				arg_189_1.text_.text = var_192_29

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_30 = 6
				local var_192_31 = utf8.len(var_192_29)
				local var_192_32 = var_192_30 <= 0 and var_192_26 or var_192_26 * (var_192_31 / var_192_30)

				if var_192_32 > 0 and var_192_26 < var_192_32 then
					arg_189_1.talkMaxDuration = var_192_32

					if var_192_32 + var_192_25 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_32 + var_192_25
					end
				end

				arg_189_1.text_.text = var_192_29
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032046", "story_v_out_117032.awb") ~= 0 then
					local var_192_33 = manager.audio:GetVoiceLength("story_v_out_117032", "117032046", "story_v_out_117032.awb") / 1000

					if var_192_33 + var_192_25 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_33 + var_192_25
					end

					if var_192_28.prefab_name ~= "" and arg_189_1.actors_[var_192_28.prefab_name] ~= nil then
						local var_192_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_28.prefab_name].transform, "story_v_out_117032", "117032046", "story_v_out_117032.awb")

						arg_189_1:RecordAudio("117032046", var_192_34)
						arg_189_1:RecordAudio("117032046", var_192_34)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_117032", "117032046", "story_v_out_117032.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_117032", "117032046", "story_v_out_117032.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_35 = math.max(var_192_26, arg_189_1.talkMaxDuration)

			if var_192_25 <= arg_189_1.time_ and arg_189_1.time_ < var_192_25 + var_192_35 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_25) / var_192_35

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_25 + var_192_35 and arg_189_1.time_ < var_192_25 + var_192_35 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
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
	Play117032047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 117032047
		arg_193_1.duration_ = 5.67

		local var_193_0 = {
			zh = 5.666,
			ja = 3.366
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
				arg_193_0:Play117032048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1132"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1132 == nil then
				arg_193_1.var_.actorSpriteComps1132 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps1132 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								local var_196_4 = Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor1.r, var_196_3)
								local var_196_5 = Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor1.g, var_196_3)
								local var_196_6 = Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor1.b, var_196_3)

								iter_196_1.color = Color.New(var_196_4, var_196_5, var_196_6)
							else
								local var_196_7 = Mathf.Lerp(iter_196_1.color.r, 1, var_196_3)

								iter_196_1.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1132 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1132 = nil
			end

			local var_196_8 = arg_193_1.actors_["10035"]
			local var_196_9 = 0

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10035 == nil then
				arg_193_1.var_.actorSpriteComps10035 = var_196_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_10 = 0.2

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_10 and not isNil(var_196_8) then
				local var_196_11 = (arg_193_1.time_ - var_196_9) / var_196_10

				if arg_193_1.var_.actorSpriteComps10035 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								local var_196_12 = Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor2.r, var_196_11)
								local var_196_13 = Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor2.g, var_196_11)
								local var_196_14 = Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor2.b, var_196_11)

								iter_196_5.color = Color.New(var_196_12, var_196_13, var_196_14)
							else
								local var_196_15 = Mathf.Lerp(iter_196_5.color.r, 0.5, var_196_11)

								iter_196_5.color = Color.New(var_196_15, var_196_15, var_196_15)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_9 + var_196_10 and arg_193_1.time_ < var_196_9 + var_196_10 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10035 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_196_7 then
						if arg_193_1.isInRecall_ then
							iter_196_7.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10035 = nil
			end

			local var_196_16 = 0
			local var_196_17 = 0.625

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_18 = arg_193_1:FormatText(StoryNameCfg[61].name)

				arg_193_1.leftNameTxt_.text = var_196_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_19 = arg_193_1:GetWordFromCfg(117032047)
				local var_196_20 = arg_193_1:FormatText(var_196_19.content)

				arg_193_1.text_.text = var_196_20

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_21 = 25
				local var_196_22 = utf8.len(var_196_20)
				local var_196_23 = var_196_21 <= 0 and var_196_17 or var_196_17 * (var_196_22 / var_196_21)

				if var_196_23 > 0 and var_196_17 < var_196_23 then
					arg_193_1.talkMaxDuration = var_196_23

					if var_196_23 + var_196_16 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_16
					end
				end

				arg_193_1.text_.text = var_196_20
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032047", "story_v_out_117032.awb") ~= 0 then
					local var_196_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032047", "story_v_out_117032.awb") / 1000

					if var_196_24 + var_196_16 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_24 + var_196_16
					end

					if var_196_19.prefab_name ~= "" and arg_193_1.actors_[var_196_19.prefab_name] ~= nil then
						local var_196_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_19.prefab_name].transform, "story_v_out_117032", "117032047", "story_v_out_117032.awb")

						arg_193_1:RecordAudio("117032047", var_196_25)
						arg_193_1:RecordAudio("117032047", var_196_25)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_117032", "117032047", "story_v_out_117032.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_117032", "117032047", "story_v_out_117032.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_26 = math.max(var_196_17, arg_193_1.talkMaxDuration)

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_26 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_16) / var_196_26

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_16 + var_196_26 and arg_193_1.time_ < var_196_16 + var_196_26 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play117032048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 117032048
		arg_197_1.duration_ = 1.6

		local var_197_0 = {
			zh = 1.6,
			ja = 1.4
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
				arg_197_0:Play117032049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1132"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps1132 == nil then
				arg_197_1.var_.actorSpriteComps1132 = var_200_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_2 = 0.2

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.actorSpriteComps1132 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps1132 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_200_3 then
						if arg_197_1.isInRecall_ then
							iter_200_3.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1132 = nil
			end

			local var_200_8 = arg_197_1.actors_["10035"].transform
			local var_200_9 = 0

			if var_200_9 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 then
				arg_197_1.var_.moveOldPos10035 = var_200_8.localPosition
				var_200_8.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10035", 4)

				local var_200_10 = var_200_8.childCount

				for iter_200_4 = 0, var_200_10 - 1 do
					local var_200_11 = var_200_8:GetChild(iter_200_4)

					if var_200_11.name == "split_4" or not string.find(var_200_11.name, "split") then
						var_200_11.gameObject:SetActive(true)
					else
						var_200_11.gameObject:SetActive(false)
					end
				end
			end

			local var_200_12 = 0.001

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_12 then
				local var_200_13 = (arg_197_1.time_ - var_200_9) / var_200_12
				local var_200_14 = Vector3.New(390, -410, -235)

				var_200_8.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10035, var_200_14, var_200_13)
			end

			if arg_197_1.time_ >= var_200_9 + var_200_12 and arg_197_1.time_ < var_200_9 + var_200_12 + arg_200_0 then
				var_200_8.localPosition = Vector3.New(390, -410, -235)
			end

			local var_200_15 = 0
			local var_200_16 = 0.075

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_17 = arg_197_1:FormatText(StoryNameCfg[369].name)

				arg_197_1.leftNameTxt_.text = var_200_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_18 = arg_197_1:GetWordFromCfg(117032048)
				local var_200_19 = arg_197_1:FormatText(var_200_18.content)

				arg_197_1.text_.text = var_200_19

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_20 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032048", "story_v_out_117032.awb") ~= 0 then
					local var_200_23 = manager.audio:GetVoiceLength("story_v_out_117032", "117032048", "story_v_out_117032.awb") / 1000

					if var_200_23 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_15
					end

					if var_200_18.prefab_name ~= "" and arg_197_1.actors_[var_200_18.prefab_name] ~= nil then
						local var_200_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_18.prefab_name].transform, "story_v_out_117032", "117032048", "story_v_out_117032.awb")

						arg_197_1:RecordAudio("117032048", var_200_24)
						arg_197_1:RecordAudio("117032048", var_200_24)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_117032", "117032048", "story_v_out_117032.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_117032", "117032048", "story_v_out_117032.awb")
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
				actorName = "10035",
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
	Play117032049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 117032049
		arg_201_1.duration_ = 3.9

		local var_201_0 = {
			zh = 2.2,
			ja = 3.9
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
				arg_201_0:Play117032050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1132"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1132 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1132", 7)

				local var_204_2 = var_204_0.childCount

				for iter_204_0 = 0, var_204_2 - 1 do
					local var_204_3 = var_204_0:GetChild(iter_204_0)

					if var_204_3.name == "split_6" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_4 then
				local var_204_5 = (arg_201_1.time_ - var_204_1) / var_204_4
				local var_204_6 = Vector3.New(0, -2000, -185)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1132, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, -2000, -185)
			end

			local var_204_7 = arg_201_1.actors_["10035"].transform
			local var_204_8 = 0

			if var_204_8 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.var_.moveOldPos10035 = var_204_7.localPosition
				var_204_7.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10035", 7)

				local var_204_9 = var_204_7.childCount

				for iter_204_1 = 0, var_204_9 - 1 do
					local var_204_10 = var_204_7:GetChild(iter_204_1)

					if var_204_10.name == "split_4" or not string.find(var_204_10.name, "split") then
						var_204_10.gameObject:SetActive(true)
					else
						var_204_10.gameObject:SetActive(false)
					end
				end
			end

			local var_204_11 = 0.001

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_11 then
				local var_204_12 = (arg_201_1.time_ - var_204_8) / var_204_11
				local var_204_13 = Vector3.New(0, -2000, -235)

				var_204_7.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10035, var_204_13, var_204_12)
			end

			if arg_201_1.time_ >= var_204_8 + var_204_11 and arg_201_1.time_ < var_204_8 + var_204_11 + arg_204_0 then
				var_204_7.localPosition = Vector3.New(0, -2000, -235)
			end

			local var_204_14 = arg_201_1.actors_["1033"].transform
			local var_204_15 = 0

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				arg_201_1.var_.moveOldPos1033 = var_204_14.localPosition
				var_204_14.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1033", 3)

				local var_204_16 = var_204_14.childCount

				for iter_204_2 = 0, var_204_16 - 1 do
					local var_204_17 = var_204_14:GetChild(iter_204_2)

					if var_204_17.name == "split_4" or not string.find(var_204_17.name, "split") then
						var_204_17.gameObject:SetActive(true)
					else
						var_204_17.gameObject:SetActive(false)
					end
				end
			end

			local var_204_18 = 0.001

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_18 then
				local var_204_19 = (arg_201_1.time_ - var_204_15) / var_204_18
				local var_204_20 = Vector3.New(0, -420, 0)

				var_204_14.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1033, var_204_20, var_204_19)
			end

			if arg_201_1.time_ >= var_204_15 + var_204_18 and arg_201_1.time_ < var_204_15 + var_204_18 + arg_204_0 then
				var_204_14.localPosition = Vector3.New(0, -420, 0)
			end

			local var_204_21 = arg_201_1.actors_["1033"]
			local var_204_22 = 0

			if var_204_22 < arg_201_1.time_ and arg_201_1.time_ <= var_204_22 + arg_204_0 then
				local var_204_23 = var_204_21:GetComponentInChildren(typeof(CanvasGroup))

				if var_204_23 then
					arg_201_1.var_.alphaOldValue1033 = var_204_23.alpha
					arg_201_1.var_.characterEffect1033 = var_204_23
				end

				arg_201_1.var_.alphaOldValue1033 = 0
			end

			local var_204_24 = 0.333333333333333

			if var_204_22 <= arg_201_1.time_ and arg_201_1.time_ < var_204_22 + var_204_24 then
				local var_204_25 = (arg_201_1.time_ - var_204_22) / var_204_24
				local var_204_26 = Mathf.Lerp(arg_201_1.var_.alphaOldValue1033, 1, var_204_25)

				if arg_201_1.var_.characterEffect1033 then
					arg_201_1.var_.characterEffect1033.alpha = var_204_26
				end
			end

			if arg_201_1.time_ >= var_204_22 + var_204_24 and arg_201_1.time_ < var_204_22 + var_204_24 + arg_204_0 and arg_201_1.var_.characterEffect1033 then
				arg_201_1.var_.characterEffect1033.alpha = 1
			end

			local var_204_27 = arg_201_1.actors_["1033"]
			local var_204_28 = 0

			if var_204_28 < arg_201_1.time_ and arg_201_1.time_ <= var_204_28 + arg_204_0 and not isNil(var_204_27) and arg_201_1.var_.actorSpriteComps1033 == nil then
				arg_201_1.var_.actorSpriteComps1033 = var_204_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_29 = 0.2

			if var_204_28 <= arg_201_1.time_ and arg_201_1.time_ < var_204_28 + var_204_29 and not isNil(var_204_27) then
				local var_204_30 = (arg_201_1.time_ - var_204_28) / var_204_29

				if arg_201_1.var_.actorSpriteComps1033 then
					for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_204_4 then
							if arg_201_1.isInRecall_ then
								local var_204_31 = Mathf.Lerp(iter_204_4.color.r, arg_201_1.hightColor1.r, var_204_30)
								local var_204_32 = Mathf.Lerp(iter_204_4.color.g, arg_201_1.hightColor1.g, var_204_30)
								local var_204_33 = Mathf.Lerp(iter_204_4.color.b, arg_201_1.hightColor1.b, var_204_30)

								iter_204_4.color = Color.New(var_204_31, var_204_32, var_204_33)
							else
								local var_204_34 = Mathf.Lerp(iter_204_4.color.r, 1, var_204_30)

								iter_204_4.color = Color.New(var_204_34, var_204_34, var_204_34)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_28 + var_204_29 and arg_201_1.time_ < var_204_28 + var_204_29 + arg_204_0 and not isNil(var_204_27) and arg_201_1.var_.actorSpriteComps1033 then
				for iter_204_5, iter_204_6 in pairs(arg_201_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_204_6 then
						if arg_201_1.isInRecall_ then
							iter_204_6.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1033 = nil
			end

			local var_204_35 = 0
			local var_204_36 = 0.15

			if var_204_35 < arg_201_1.time_ and arg_201_1.time_ <= var_204_35 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_37 = arg_201_1:FormatText(StoryNameCfg[236].name)

				arg_201_1.leftNameTxt_.text = var_204_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_38 = arg_201_1:GetWordFromCfg(117032049)
				local var_204_39 = arg_201_1:FormatText(var_204_38.content)

				arg_201_1.text_.text = var_204_39

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_40 = 6
				local var_204_41 = utf8.len(var_204_39)
				local var_204_42 = var_204_40 <= 0 and var_204_36 or var_204_36 * (var_204_41 / var_204_40)

				if var_204_42 > 0 and var_204_36 < var_204_42 then
					arg_201_1.talkMaxDuration = var_204_42

					if var_204_42 + var_204_35 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_42 + var_204_35
					end
				end

				arg_201_1.text_.text = var_204_39
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032049", "story_v_out_117032.awb") ~= 0 then
					local var_204_43 = manager.audio:GetVoiceLength("story_v_out_117032", "117032049", "story_v_out_117032.awb") / 1000

					if var_204_43 + var_204_35 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_43 + var_204_35
					end

					if var_204_38.prefab_name ~= "" and arg_201_1.actors_[var_204_38.prefab_name] ~= nil then
						local var_204_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_38.prefab_name].transform, "story_v_out_117032", "117032049", "story_v_out_117032.awb")

						arg_201_1:RecordAudio("117032049", var_204_44)
						arg_201_1:RecordAudio("117032049", var_204_44)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_117032", "117032049", "story_v_out_117032.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_117032", "117032049", "story_v_out_117032.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_45 = math.max(var_204_36, arg_201_1.talkMaxDuration)

			if var_204_35 <= arg_201_1.time_ and arg_201_1.time_ < var_204_35 + var_204_45 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_35) / var_204_45

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_35 + var_204_45 and arg_201_1.time_ < var_204_35 + var_204_45 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
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
	Play117032050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 117032050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play117032051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1033"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1033 == nil then
				arg_205_1.var_.actorSpriteComps1033 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 0.2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps1033 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								local var_208_4 = Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor2.r, var_208_3)
								local var_208_5 = Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor2.g, var_208_3)
								local var_208_6 = Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor2.b, var_208_3)

								iter_208_1.color = Color.New(var_208_4, var_208_5, var_208_6)
							else
								local var_208_7 = Mathf.Lerp(iter_208_1.color.r, 0.5, var_208_3)

								iter_208_1.color = Color.New(var_208_7, var_208_7, var_208_7)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1033 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1033 = nil
			end

			local var_208_8 = arg_205_1.actors_["1033"]
			local var_208_9 = 0

			if var_208_9 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps1033 == nil then
				arg_205_1.var_.actorSpriteComps1033 = var_208_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_10 = 0.2

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_10 and not isNil(var_208_8) then
				local var_208_11 = (arg_205_1.time_ - var_208_9) / var_208_10

				if arg_205_1.var_.actorSpriteComps1033 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_208_5 then
							if arg_205_1.isInRecall_ then
								local var_208_12 = Mathf.Lerp(iter_208_5.color.r, arg_205_1.hightColor1.r, var_208_11)
								local var_208_13 = Mathf.Lerp(iter_208_5.color.g, arg_205_1.hightColor1.g, var_208_11)
								local var_208_14 = Mathf.Lerp(iter_208_5.color.b, arg_205_1.hightColor1.b, var_208_11)

								iter_208_5.color = Color.New(var_208_12, var_208_13, var_208_14)
							else
								local var_208_15 = Mathf.Lerp(iter_208_5.color.r, 1, var_208_11)

								iter_208_5.color = Color.New(var_208_15, var_208_15, var_208_15)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_9 + var_208_10 and arg_205_1.time_ < var_208_9 + var_208_10 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps1033 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_208_7 then
						if arg_205_1.isInRecall_ then
							iter_208_7.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1033 = nil
			end

			local var_208_16 = 0
			local var_208_17 = 1.375

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_18 = arg_205_1:GetWordFromCfg(117032050)
				local var_208_19 = arg_205_1:FormatText(var_208_18.content)

				arg_205_1.text_.text = var_208_19

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_20 = 55
				local var_208_21 = utf8.len(var_208_19)
				local var_208_22 = var_208_20 <= 0 and var_208_17 or var_208_17 * (var_208_21 / var_208_20)

				if var_208_22 > 0 and var_208_17 < var_208_22 then
					arg_205_1.talkMaxDuration = var_208_22

					if var_208_22 + var_208_16 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_22 + var_208_16
					end
				end

				arg_205_1.text_.text = var_208_19
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_23 = math.max(var_208_17, arg_205_1.talkMaxDuration)

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_23 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_16) / var_208_23

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_16 + var_208_23 and arg_205_1.time_ < var_208_16 + var_208_23 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play117032051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 117032051
		arg_209_1.duration_ = 12.9

		local var_209_0 = {
			zh = 9.6,
			ja = 12.9
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
				arg_209_0:Play117032052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1033"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1033 = var_212_0.localPosition
				var_212_0.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1033", 3)

				local var_212_2 = var_212_0.childCount

				for iter_212_0 = 0, var_212_2 - 1 do
					local var_212_3 = var_212_0:GetChild(iter_212_0)

					if var_212_3.name == "split_6" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_4 then
				local var_212_5 = (arg_209_1.time_ - var_212_1) / var_212_4
				local var_212_6 = Vector3.New(0, -420, 0)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1033, var_212_6, var_212_5)
			end

			if arg_209_1.time_ >= var_212_1 + var_212_4 and arg_209_1.time_ < var_212_1 + var_212_4 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -420, 0)
			end

			local var_212_7 = 0
			local var_212_8 = 1.075

			if var_212_7 < arg_209_1.time_ and arg_209_1.time_ <= var_212_7 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_9 = arg_209_1:FormatText(StoryNameCfg[236].name)

				arg_209_1.leftNameTxt_.text = var_212_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(117032051)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_12 = 43
				local var_212_13 = utf8.len(var_212_11)
				local var_212_14 = var_212_12 <= 0 and var_212_8 or var_212_8 * (var_212_13 / var_212_12)

				if var_212_14 > 0 and var_212_8 < var_212_14 then
					arg_209_1.talkMaxDuration = var_212_14

					if var_212_14 + var_212_7 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_7
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032051", "story_v_out_117032.awb") ~= 0 then
					local var_212_15 = manager.audio:GetVoiceLength("story_v_out_117032", "117032051", "story_v_out_117032.awb") / 1000

					if var_212_15 + var_212_7 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_15 + var_212_7
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_117032", "117032051", "story_v_out_117032.awb")

						arg_209_1:RecordAudio("117032051", var_212_16)
						arg_209_1:RecordAudio("117032051", var_212_16)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_117032", "117032051", "story_v_out_117032.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_117032", "117032051", "story_v_out_117032.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_17 = math.max(var_212_8, arg_209_1.talkMaxDuration)

			if var_212_7 <= arg_209_1.time_ and arg_209_1.time_ < var_212_7 + var_212_17 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_7) / var_212_17

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_7 + var_212_17 and arg_209_1.time_ < var_212_7 + var_212_17 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play117032052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 117032052
		arg_213_1.duration_ = 3.87

		local var_213_0 = {
			zh = 1.966,
			ja = 3.866
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
				arg_213_0:Play117032053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.25

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[236].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:GetWordFromCfg(117032052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 10
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032052", "story_v_out_117032.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032052", "story_v_out_117032.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_117032", "117032052", "story_v_out_117032.awb")

						arg_213_1:RecordAudio("117032052", var_216_9)
						arg_213_1:RecordAudio("117032052", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_117032", "117032052", "story_v_out_117032.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_117032", "117032052", "story_v_out_117032.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_10 and arg_213_1.time_ < var_216_0 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play117032053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 117032053
		arg_217_1.duration_ = 4.6

		local var_217_0 = {
			zh = 4.6,
			ja = 3.433
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
				arg_217_0:Play117032054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1132"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1132 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1132", 2)

				local var_220_2 = var_220_0.childCount

				for iter_220_0 = 0, var_220_2 - 1 do
					local var_220_3 = var_220_0:GetChild(iter_220_0)

					if var_220_3.name == "split_6" or not string.find(var_220_3.name, "split") then
						var_220_3.gameObject:SetActive(true)
					else
						var_220_3.gameObject:SetActive(false)
					end
				end
			end

			local var_220_4 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_4 then
				local var_220_5 = (arg_217_1.time_ - var_220_1) / var_220_4
				local var_220_6 = Vector3.New(-390, -413, -185)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1132, var_220_6, var_220_5)
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_220_7 = arg_217_1.actors_["10035"].transform
			local var_220_8 = 0

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.var_.moveOldPos10035 = var_220_7.localPosition
				var_220_7.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10035", 4)

				local var_220_9 = var_220_7.childCount

				for iter_220_1 = 0, var_220_9 - 1 do
					local var_220_10 = var_220_7:GetChild(iter_220_1)

					if var_220_10.name == "split_1" or not string.find(var_220_10.name, "split") then
						var_220_10.gameObject:SetActive(true)
					else
						var_220_10.gameObject:SetActive(false)
					end
				end
			end

			local var_220_11 = 0.001

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_11 then
				local var_220_12 = (arg_217_1.time_ - var_220_8) / var_220_11
				local var_220_13 = Vector3.New(390, -410, -235)

				var_220_7.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10035, var_220_13, var_220_12)
			end

			if arg_217_1.time_ >= var_220_8 + var_220_11 and arg_217_1.time_ < var_220_8 + var_220_11 + arg_220_0 then
				var_220_7.localPosition = Vector3.New(390, -410, -235)
			end

			local var_220_14 = arg_217_1.actors_["1033"].transform
			local var_220_15 = 0

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.var_.moveOldPos1033 = var_220_14.localPosition
				var_220_14.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1033", 7)

				local var_220_16 = var_220_14.childCount

				for iter_220_2 = 0, var_220_16 - 1 do
					local var_220_17 = var_220_14:GetChild(iter_220_2)

					if var_220_17.name == "split_6" or not string.find(var_220_17.name, "split") then
						var_220_17.gameObject:SetActive(true)
					else
						var_220_17.gameObject:SetActive(false)
					end
				end
			end

			local var_220_18 = 0.001

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_18 then
				local var_220_19 = (arg_217_1.time_ - var_220_15) / var_220_18
				local var_220_20 = Vector3.New(0, -2000, -235)

				var_220_14.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1033, var_220_20, var_220_19)
			end

			if arg_217_1.time_ >= var_220_15 + var_220_18 and arg_217_1.time_ < var_220_15 + var_220_18 + arg_220_0 then
				var_220_14.localPosition = Vector3.New(0, -2000, -235)
			end

			local var_220_21 = arg_217_1.actors_["1132"]
			local var_220_22 = 0

			if var_220_22 < arg_217_1.time_ and arg_217_1.time_ <= var_220_22 + arg_220_0 and not isNil(var_220_21) and arg_217_1.var_.actorSpriteComps1132 == nil then
				arg_217_1.var_.actorSpriteComps1132 = var_220_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_23 = 0.2

			if var_220_22 <= arg_217_1.time_ and arg_217_1.time_ < var_220_22 + var_220_23 and not isNil(var_220_21) then
				local var_220_24 = (arg_217_1.time_ - var_220_22) / var_220_23

				if arg_217_1.var_.actorSpriteComps1132 then
					for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_220_4 then
							if arg_217_1.isInRecall_ then
								local var_220_25 = Mathf.Lerp(iter_220_4.color.r, arg_217_1.hightColor1.r, var_220_24)
								local var_220_26 = Mathf.Lerp(iter_220_4.color.g, arg_217_1.hightColor1.g, var_220_24)
								local var_220_27 = Mathf.Lerp(iter_220_4.color.b, arg_217_1.hightColor1.b, var_220_24)

								iter_220_4.color = Color.New(var_220_25, var_220_26, var_220_27)
							else
								local var_220_28 = Mathf.Lerp(iter_220_4.color.r, 1, var_220_24)

								iter_220_4.color = Color.New(var_220_28, var_220_28, var_220_28)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_22 + var_220_23 and arg_217_1.time_ < var_220_22 + var_220_23 + arg_220_0 and not isNil(var_220_21) and arg_217_1.var_.actorSpriteComps1132 then
				for iter_220_5, iter_220_6 in pairs(arg_217_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_220_6 then
						if arg_217_1.isInRecall_ then
							iter_220_6.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1132 = nil
			end

			local var_220_29 = arg_217_1.actors_["10035"]
			local var_220_30 = 0

			if var_220_30 < arg_217_1.time_ and arg_217_1.time_ <= var_220_30 + arg_220_0 and not isNil(var_220_29) and arg_217_1.var_.actorSpriteComps10035 == nil then
				arg_217_1.var_.actorSpriteComps10035 = var_220_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_31 = 0.2

			if var_220_30 <= arg_217_1.time_ and arg_217_1.time_ < var_220_30 + var_220_31 and not isNil(var_220_29) then
				local var_220_32 = (arg_217_1.time_ - var_220_30) / var_220_31

				if arg_217_1.var_.actorSpriteComps10035 then
					for iter_220_7, iter_220_8 in pairs(arg_217_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_220_8 then
							if arg_217_1.isInRecall_ then
								local var_220_33 = Mathf.Lerp(iter_220_8.color.r, arg_217_1.hightColor2.r, var_220_32)
								local var_220_34 = Mathf.Lerp(iter_220_8.color.g, arg_217_1.hightColor2.g, var_220_32)
								local var_220_35 = Mathf.Lerp(iter_220_8.color.b, arg_217_1.hightColor2.b, var_220_32)

								iter_220_8.color = Color.New(var_220_33, var_220_34, var_220_35)
							else
								local var_220_36 = Mathf.Lerp(iter_220_8.color.r, 0.5, var_220_32)

								iter_220_8.color = Color.New(var_220_36, var_220_36, var_220_36)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_30 + var_220_31 and arg_217_1.time_ < var_220_30 + var_220_31 + arg_220_0 and not isNil(var_220_29) and arg_217_1.var_.actorSpriteComps10035 then
				for iter_220_9, iter_220_10 in pairs(arg_217_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_220_10 then
						if arg_217_1.isInRecall_ then
							iter_220_10.color = arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_220_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10035 = nil
			end

			local var_220_37 = 0
			local var_220_38 = 0.575

			if var_220_37 < arg_217_1.time_ and arg_217_1.time_ <= var_220_37 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_39 = arg_217_1:FormatText(StoryNameCfg[61].name)

				arg_217_1.leftNameTxt_.text = var_220_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_40 = arg_217_1:GetWordFromCfg(117032053)
				local var_220_41 = arg_217_1:FormatText(var_220_40.content)

				arg_217_1.text_.text = var_220_41

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_42 = 23
				local var_220_43 = utf8.len(var_220_41)
				local var_220_44 = var_220_42 <= 0 and var_220_38 or var_220_38 * (var_220_43 / var_220_42)

				if var_220_44 > 0 and var_220_38 < var_220_44 then
					arg_217_1.talkMaxDuration = var_220_44

					if var_220_44 + var_220_37 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_44 + var_220_37
					end
				end

				arg_217_1.text_.text = var_220_41
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032053", "story_v_out_117032.awb") ~= 0 then
					local var_220_45 = manager.audio:GetVoiceLength("story_v_out_117032", "117032053", "story_v_out_117032.awb") / 1000

					if var_220_45 + var_220_37 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_45 + var_220_37
					end

					if var_220_40.prefab_name ~= "" and arg_217_1.actors_[var_220_40.prefab_name] ~= nil then
						local var_220_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_40.prefab_name].transform, "story_v_out_117032", "117032053", "story_v_out_117032.awb")

						arg_217_1:RecordAudio("117032053", var_220_46)
						arg_217_1:RecordAudio("117032053", var_220_46)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_117032", "117032053", "story_v_out_117032.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_117032", "117032053", "story_v_out_117032.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_47 = math.max(var_220_38, arg_217_1.talkMaxDuration)

			if var_220_37 <= arg_217_1.time_ and arg_217_1.time_ < var_220_37 + var_220_47 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_37) / var_220_47

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_37 + var_220_47 and arg_217_1.time_ < var_220_37 + var_220_47 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
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
	Play117032054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 117032054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play117032055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1132"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1132 == nil then
				arg_221_1.var_.actorSpriteComps1132 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps1132 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								local var_224_4 = Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, var_224_3)
								local var_224_5 = Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, var_224_3)
								local var_224_6 = Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, var_224_3)

								iter_224_1.color = Color.New(var_224_4, var_224_5, var_224_6)
							else
								local var_224_7 = Mathf.Lerp(iter_224_1.color.r, 0.5, var_224_3)

								iter_224_1.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1132 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1132 = nil
			end

			local var_224_8 = 0
			local var_224_9 = 0.4

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_10 = arg_221_1:GetWordFromCfg(117032054)
				local var_224_11 = arg_221_1:FormatText(var_224_10.content)

				arg_221_1.text_.text = var_224_11

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_12 = 16
				local var_224_13 = utf8.len(var_224_11)
				local var_224_14 = var_224_12 <= 0 and var_224_9 or var_224_9 * (var_224_13 / var_224_12)

				if var_224_14 > 0 and var_224_9 < var_224_14 then
					arg_221_1.talkMaxDuration = var_224_14

					if var_224_14 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_11
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_15 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_15 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_15

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_15 and arg_221_1.time_ < var_224_8 + var_224_15 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play117032055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 117032055
		arg_225_1.duration_ = 5.93

		local var_225_0 = {
			zh = 5.933,
			ja = 5.8
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
				arg_225_0:Play117032056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10035"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos10035 = var_228_0.localPosition
				var_228_0.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10035", 4)

				local var_228_2 = var_228_0.childCount

				for iter_228_0 = 0, var_228_2 - 1 do
					local var_228_3 = var_228_0:GetChild(iter_228_0)

					if var_228_3.name == "split_4" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_4 then
				local var_228_5 = (arg_225_1.time_ - var_228_1) / var_228_4
				local var_228_6 = Vector3.New(390, -410, -235)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10035, var_228_6, var_228_5)
			end

			if arg_225_1.time_ >= var_228_1 + var_228_4 and arg_225_1.time_ < var_228_1 + var_228_4 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(390, -410, -235)
			end

			local var_228_7 = arg_225_1.actors_["10035"]
			local var_228_8 = 0

			if var_228_8 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps10035 == nil then
				arg_225_1.var_.actorSpriteComps10035 = var_228_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_9 = 0.2

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_9 and not isNil(var_228_7) then
				local var_228_10 = (arg_225_1.time_ - var_228_8) / var_228_9

				if arg_225_1.var_.actorSpriteComps10035 then
					for iter_228_1, iter_228_2 in pairs(arg_225_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_228_2 then
							if arg_225_1.isInRecall_ then
								local var_228_11 = Mathf.Lerp(iter_228_2.color.r, arg_225_1.hightColor1.r, var_228_10)
								local var_228_12 = Mathf.Lerp(iter_228_2.color.g, arg_225_1.hightColor1.g, var_228_10)
								local var_228_13 = Mathf.Lerp(iter_228_2.color.b, arg_225_1.hightColor1.b, var_228_10)

								iter_228_2.color = Color.New(var_228_11, var_228_12, var_228_13)
							else
								local var_228_14 = Mathf.Lerp(iter_228_2.color.r, 1, var_228_10)

								iter_228_2.color = Color.New(var_228_14, var_228_14, var_228_14)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_8 + var_228_9 and arg_225_1.time_ < var_228_8 + var_228_9 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps10035 then
				for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_228_4 then
						if arg_225_1.isInRecall_ then
							iter_228_4.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10035 = nil
			end

			local var_228_15 = 0
			local var_228_16 = 0.7

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_17 = arg_225_1:FormatText(StoryNameCfg[369].name)

				arg_225_1.leftNameTxt_.text = var_228_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_18 = arg_225_1:GetWordFromCfg(117032055)
				local var_228_19 = arg_225_1:FormatText(var_228_18.content)

				arg_225_1.text_.text = var_228_19

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_20 = 28
				local var_228_21 = utf8.len(var_228_19)
				local var_228_22 = var_228_20 <= 0 and var_228_16 or var_228_16 * (var_228_21 / var_228_20)

				if var_228_22 > 0 and var_228_16 < var_228_22 then
					arg_225_1.talkMaxDuration = var_228_22

					if var_228_22 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_22 + var_228_15
					end
				end

				arg_225_1.text_.text = var_228_19
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032055", "story_v_out_117032.awb") ~= 0 then
					local var_228_23 = manager.audio:GetVoiceLength("story_v_out_117032", "117032055", "story_v_out_117032.awb") / 1000

					if var_228_23 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_15
					end

					if var_228_18.prefab_name ~= "" and arg_225_1.actors_[var_228_18.prefab_name] ~= nil then
						local var_228_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_18.prefab_name].transform, "story_v_out_117032", "117032055", "story_v_out_117032.awb")

						arg_225_1:RecordAudio("117032055", var_228_24)
						arg_225_1:RecordAudio("117032055", var_228_24)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_117032", "117032055", "story_v_out_117032.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_117032", "117032055", "story_v_out_117032.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_25 = math.max(var_228_16, arg_225_1.talkMaxDuration)

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_25 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_15) / var_228_25

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_15 + var_228_25 and arg_225_1.time_ < var_228_15 + var_228_25 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
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
	Play117032056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 117032056
		arg_229_1.duration_ = 2.9

		local var_229_0 = {
			zh = 2.133,
			ja = 2.9
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
				arg_229_0:Play117032057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1132"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1132 == nil then
				arg_229_1.var_.actorSpriteComps1132 = var_232_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_2 = 0.2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.actorSpriteComps1132 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								local var_232_4 = Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor1.r, var_232_3)
								local var_232_5 = Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor1.g, var_232_3)
								local var_232_6 = Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor1.b, var_232_3)

								iter_232_1.color = Color.New(var_232_4, var_232_5, var_232_6)
							else
								local var_232_7 = Mathf.Lerp(iter_232_1.color.r, 1, var_232_3)

								iter_232_1.color = Color.New(var_232_7, var_232_7, var_232_7)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1132 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_232_3 then
						if arg_229_1.isInRecall_ then
							iter_232_3.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1132 = nil
			end

			local var_232_8 = arg_229_1.actors_["10035"]
			local var_232_9 = 0

			if var_232_9 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.actorSpriteComps10035 == nil then
				arg_229_1.var_.actorSpriteComps10035 = var_232_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_10 = 0.2

			if var_232_9 <= arg_229_1.time_ and arg_229_1.time_ < var_232_9 + var_232_10 and not isNil(var_232_8) then
				local var_232_11 = (arg_229_1.time_ - var_232_9) / var_232_10

				if arg_229_1.var_.actorSpriteComps10035 then
					for iter_232_4, iter_232_5 in pairs(arg_229_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_232_5 then
							if arg_229_1.isInRecall_ then
								local var_232_12 = Mathf.Lerp(iter_232_5.color.r, arg_229_1.hightColor2.r, var_232_11)
								local var_232_13 = Mathf.Lerp(iter_232_5.color.g, arg_229_1.hightColor2.g, var_232_11)
								local var_232_14 = Mathf.Lerp(iter_232_5.color.b, arg_229_1.hightColor2.b, var_232_11)

								iter_232_5.color = Color.New(var_232_12, var_232_13, var_232_14)
							else
								local var_232_15 = Mathf.Lerp(iter_232_5.color.r, 0.5, var_232_11)

								iter_232_5.color = Color.New(var_232_15, var_232_15, var_232_15)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_9 + var_232_10 and arg_229_1.time_ < var_232_9 + var_232_10 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.actorSpriteComps10035 then
				for iter_232_6, iter_232_7 in pairs(arg_229_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_232_7 then
						if arg_229_1.isInRecall_ then
							iter_232_7.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10035 = nil
			end

			local var_232_16 = 0
			local var_232_17 = 0.25

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_18 = arg_229_1:FormatText(StoryNameCfg[61].name)

				arg_229_1.leftNameTxt_.text = var_232_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_19 = arg_229_1:GetWordFromCfg(117032056)
				local var_232_20 = arg_229_1:FormatText(var_232_19.content)

				arg_229_1.text_.text = var_232_20

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_21 = 10
				local var_232_22 = utf8.len(var_232_20)
				local var_232_23 = var_232_21 <= 0 and var_232_17 or var_232_17 * (var_232_22 / var_232_21)

				if var_232_23 > 0 and var_232_17 < var_232_23 then
					arg_229_1.talkMaxDuration = var_232_23

					if var_232_23 + var_232_16 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_23 + var_232_16
					end
				end

				arg_229_1.text_.text = var_232_20
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032056", "story_v_out_117032.awb") ~= 0 then
					local var_232_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032056", "story_v_out_117032.awb") / 1000

					if var_232_24 + var_232_16 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_24 + var_232_16
					end

					if var_232_19.prefab_name ~= "" and arg_229_1.actors_[var_232_19.prefab_name] ~= nil then
						local var_232_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_19.prefab_name].transform, "story_v_out_117032", "117032056", "story_v_out_117032.awb")

						arg_229_1:RecordAudio("117032056", var_232_25)
						arg_229_1:RecordAudio("117032056", var_232_25)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_117032", "117032056", "story_v_out_117032.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_117032", "117032056", "story_v_out_117032.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_26 = math.max(var_232_17, arg_229_1.talkMaxDuration)

			if var_232_16 <= arg_229_1.time_ and arg_229_1.time_ < var_232_16 + var_232_26 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_16) / var_232_26

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_16 + var_232_26 and arg_229_1.time_ < var_232_16 + var_232_26 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play117032057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 117032057
		arg_233_1.duration_ = 1.27

		local var_233_0 = {
			zh = 1.266,
			ja = 1.166
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
				arg_233_0:Play117032058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1132"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps1132 == nil then
				arg_233_1.var_.actorSpriteComps1132 = var_236_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_2 = 0.2

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.actorSpriteComps1132 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								local var_236_4 = Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor2.r, var_236_3)
								local var_236_5 = Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor2.g, var_236_3)
								local var_236_6 = Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor2.b, var_236_3)

								iter_236_1.color = Color.New(var_236_4, var_236_5, var_236_6)
							else
								local var_236_7 = Mathf.Lerp(iter_236_1.color.r, 0.5, var_236_3)

								iter_236_1.color = Color.New(var_236_7, var_236_7, var_236_7)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps1132 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_236_3 then
						if arg_233_1.isInRecall_ then
							iter_236_3.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1132 = nil
			end

			local var_236_8 = arg_233_1.actors_["10035"]
			local var_236_9 = 0

			if var_236_9 < arg_233_1.time_ and arg_233_1.time_ <= var_236_9 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.actorSpriteComps10035 == nil then
				arg_233_1.var_.actorSpriteComps10035 = var_236_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_10 = 0.2

			if var_236_9 <= arg_233_1.time_ and arg_233_1.time_ < var_236_9 + var_236_10 and not isNil(var_236_8) then
				local var_236_11 = (arg_233_1.time_ - var_236_9) / var_236_10

				if arg_233_1.var_.actorSpriteComps10035 then
					for iter_236_4, iter_236_5 in pairs(arg_233_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_236_5 then
							if arg_233_1.isInRecall_ then
								local var_236_12 = Mathf.Lerp(iter_236_5.color.r, arg_233_1.hightColor1.r, var_236_11)
								local var_236_13 = Mathf.Lerp(iter_236_5.color.g, arg_233_1.hightColor1.g, var_236_11)
								local var_236_14 = Mathf.Lerp(iter_236_5.color.b, arg_233_1.hightColor1.b, var_236_11)

								iter_236_5.color = Color.New(var_236_12, var_236_13, var_236_14)
							else
								local var_236_15 = Mathf.Lerp(iter_236_5.color.r, 1, var_236_11)

								iter_236_5.color = Color.New(var_236_15, var_236_15, var_236_15)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_9 + var_236_10 and arg_233_1.time_ < var_236_9 + var_236_10 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.actorSpriteComps10035 then
				for iter_236_6, iter_236_7 in pairs(arg_233_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_236_7 then
						if arg_233_1.isInRecall_ then
							iter_236_7.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10035 = nil
			end

			local var_236_16 = 0
			local var_236_17 = 0.1

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_18 = arg_233_1:FormatText(StoryNameCfg[369].name)

				arg_233_1.leftNameTxt_.text = var_236_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_19 = arg_233_1:GetWordFromCfg(117032057)
				local var_236_20 = arg_233_1:FormatText(var_236_19.content)

				arg_233_1.text_.text = var_236_20

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_21 = 4
				local var_236_22 = utf8.len(var_236_20)
				local var_236_23 = var_236_21 <= 0 and var_236_17 or var_236_17 * (var_236_22 / var_236_21)

				if var_236_23 > 0 and var_236_17 < var_236_23 then
					arg_233_1.talkMaxDuration = var_236_23

					if var_236_23 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_23 + var_236_16
					end
				end

				arg_233_1.text_.text = var_236_20
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032057", "story_v_out_117032.awb") ~= 0 then
					local var_236_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032057", "story_v_out_117032.awb") / 1000

					if var_236_24 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_24 + var_236_16
					end

					if var_236_19.prefab_name ~= "" and arg_233_1.actors_[var_236_19.prefab_name] ~= nil then
						local var_236_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_19.prefab_name].transform, "story_v_out_117032", "117032057", "story_v_out_117032.awb")

						arg_233_1:RecordAudio("117032057", var_236_25)
						arg_233_1:RecordAudio("117032057", var_236_25)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_117032", "117032057", "story_v_out_117032.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_117032", "117032057", "story_v_out_117032.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_26 = math.max(var_236_17, arg_233_1.talkMaxDuration)

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_26 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_16) / var_236_26

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_16 + var_236_26 and arg_233_1.time_ < var_236_16 + var_236_26 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play117032058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 117032058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play117032059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10035"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos10035 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10035", 4)

				local var_240_2 = var_240_0.childCount

				for iter_240_0 = 0, var_240_2 - 1 do
					local var_240_3 = var_240_0:GetChild(iter_240_0)

					if var_240_3.name == "split_4" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_4 then
				local var_240_5 = (arg_237_1.time_ - var_240_1) / var_240_4
				local var_240_6 = Vector3.New(390, -410, -235)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10035, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(390, -410, -235)
			end

			local var_240_7 = arg_237_1.actors_["10035"]
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps10035 == nil then
				arg_237_1.var_.actorSpriteComps10035 = var_240_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_9 = 0.2

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_9 and not isNil(var_240_7) then
				local var_240_10 = (arg_237_1.time_ - var_240_8) / var_240_9

				if arg_237_1.var_.actorSpriteComps10035 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								local var_240_11 = Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor2.r, var_240_10)
								local var_240_12 = Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor2.g, var_240_10)
								local var_240_13 = Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor2.b, var_240_10)

								iter_240_2.color = Color.New(var_240_11, var_240_12, var_240_13)
							else
								local var_240_14 = Mathf.Lerp(iter_240_2.color.r, 0.5, var_240_10)

								iter_240_2.color = Color.New(var_240_14, var_240_14, var_240_14)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_8 + var_240_9 and arg_237_1.time_ < var_240_8 + var_240_9 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps10035 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_240_4 then
						if arg_237_1.isInRecall_ then
							iter_240_4.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10035 = nil
			end

			local var_240_15 = 0
			local var_240_16 = 0.875

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_17 = arg_237_1:GetWordFromCfg(117032058)
				local var_240_18 = arg_237_1:FormatText(var_240_17.content)

				arg_237_1.text_.text = var_240_18

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_19 = 35
				local var_240_20 = utf8.len(var_240_18)
				local var_240_21 = var_240_19 <= 0 and var_240_16 or var_240_16 * (var_240_20 / var_240_19)

				if var_240_21 > 0 and var_240_16 < var_240_21 then
					arg_237_1.talkMaxDuration = var_240_21

					if var_240_21 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_21 + var_240_15
					end
				end

				arg_237_1.text_.text = var_240_18
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_22 = math.max(var_240_16, arg_237_1.talkMaxDuration)

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_22 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_22

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_22 and arg_237_1.time_ < var_240_15 + var_240_22 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
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
	Play117032059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 117032059
		arg_241_1.duration_ = 7.03

		local var_241_0 = {
			zh = 5.7,
			ja = 7.033
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
				arg_241_0:Play117032060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10035"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps10035 == nil then
				arg_241_1.var_.actorSpriteComps10035 = var_244_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_2 = 0.2

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.actorSpriteComps10035 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_244_1 then
							if arg_241_1.isInRecall_ then
								local var_244_4 = Mathf.Lerp(iter_244_1.color.r, arg_241_1.hightColor1.r, var_244_3)
								local var_244_5 = Mathf.Lerp(iter_244_1.color.g, arg_241_1.hightColor1.g, var_244_3)
								local var_244_6 = Mathf.Lerp(iter_244_1.color.b, arg_241_1.hightColor1.b, var_244_3)

								iter_244_1.color = Color.New(var_244_4, var_244_5, var_244_6)
							else
								local var_244_7 = Mathf.Lerp(iter_244_1.color.r, 1, var_244_3)

								iter_244_1.color = Color.New(var_244_7, var_244_7, var_244_7)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps10035 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_244_3 then
						if arg_241_1.isInRecall_ then
							iter_244_3.color = arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_244_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps10035 = nil
			end

			local var_244_8 = 0
			local var_244_9 = 0.725

			if var_244_8 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_10 = arg_241_1:FormatText(StoryNameCfg[369].name)

				arg_241_1.leftNameTxt_.text = var_244_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_11 = arg_241_1:GetWordFromCfg(117032059)
				local var_244_12 = arg_241_1:FormatText(var_244_11.content)

				arg_241_1.text_.text = var_244_12

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_13 = 29
				local var_244_14 = utf8.len(var_244_12)
				local var_244_15 = var_244_13 <= 0 and var_244_9 or var_244_9 * (var_244_14 / var_244_13)

				if var_244_15 > 0 and var_244_9 < var_244_15 then
					arg_241_1.talkMaxDuration = var_244_15

					if var_244_15 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_15 + var_244_8
					end
				end

				arg_241_1.text_.text = var_244_12
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032059", "story_v_out_117032.awb") ~= 0 then
					local var_244_16 = manager.audio:GetVoiceLength("story_v_out_117032", "117032059", "story_v_out_117032.awb") / 1000

					if var_244_16 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_16 + var_244_8
					end

					if var_244_11.prefab_name ~= "" and arg_241_1.actors_[var_244_11.prefab_name] ~= nil then
						local var_244_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_11.prefab_name].transform, "story_v_out_117032", "117032059", "story_v_out_117032.awb")

						arg_241_1:RecordAudio("117032059", var_244_17)
						arg_241_1:RecordAudio("117032059", var_244_17)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_117032", "117032059", "story_v_out_117032.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_117032", "117032059", "story_v_out_117032.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_18 = math.max(var_244_9, arg_241_1.talkMaxDuration)

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_18 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_8) / var_244_18

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_8 + var_244_18 and arg_241_1.time_ < var_244_8 + var_244_18 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play117032060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 117032060
		arg_245_1.duration_ = 9.37

		local var_245_0 = {
			zh = 9.366,
			ja = 7.533
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
				arg_245_0:Play117032061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 1.125

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[369].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:GetWordFromCfg(117032060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 45
				local var_248_6 = utf8.len(var_248_4)
				local var_248_7 = var_248_5 <= 0 and var_248_1 or var_248_1 * (var_248_6 / var_248_5)

				if var_248_7 > 0 and var_248_1 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032060", "story_v_out_117032.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032060", "story_v_out_117032.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_117032", "117032060", "story_v_out_117032.awb")

						arg_245_1:RecordAudio("117032060", var_248_9)
						arg_245_1:RecordAudio("117032060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_117032", "117032060", "story_v_out_117032.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_117032", "117032060", "story_v_out_117032.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_10 and arg_245_1.time_ < var_248_0 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play117032061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 117032061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play117032062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10035"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.actorSpriteComps10035 == nil then
				arg_249_1.var_.actorSpriteComps10035 = var_252_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_2 = 0.2

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.actorSpriteComps10035 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_252_1 then
							if arg_249_1.isInRecall_ then
								local var_252_4 = Mathf.Lerp(iter_252_1.color.r, arg_249_1.hightColor2.r, var_252_3)
								local var_252_5 = Mathf.Lerp(iter_252_1.color.g, arg_249_1.hightColor2.g, var_252_3)
								local var_252_6 = Mathf.Lerp(iter_252_1.color.b, arg_249_1.hightColor2.b, var_252_3)

								iter_252_1.color = Color.New(var_252_4, var_252_5, var_252_6)
							else
								local var_252_7 = Mathf.Lerp(iter_252_1.color.r, 0.5, var_252_3)

								iter_252_1.color = Color.New(var_252_7, var_252_7, var_252_7)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.actorSpriteComps10035 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_252_3 then
						if arg_249_1.isInRecall_ then
							iter_252_3.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps10035 = nil
			end

			local var_252_8 = 0
			local var_252_9 = 0.375

			if var_252_8 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:GetWordFromCfg(117032061)
				local var_252_11 = arg_249_1:FormatText(var_252_10.content)

				arg_249_1.text_.text = var_252_11

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_12 = 15
				local var_252_13 = utf8.len(var_252_11)
				local var_252_14 = var_252_12 <= 0 and var_252_9 or var_252_9 * (var_252_13 / var_252_12)

				if var_252_14 > 0 and var_252_9 < var_252_14 then
					arg_249_1.talkMaxDuration = var_252_14

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_11
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_15 = math.max(var_252_9, arg_249_1.talkMaxDuration)

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_15 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_8) / var_252_15

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_8 + var_252_15 and arg_249_1.time_ < var_252_8 + var_252_15 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play117032062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 117032062
		arg_253_1.duration_ = 5.63

		local var_253_0 = {
			zh = 5.633,
			ja = 2.9
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play117032063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1132"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps1132 == nil then
				arg_253_1.var_.actorSpriteComps1132 = var_256_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_2 = 0.2

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.actorSpriteComps1132 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								local var_256_4 = Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor1.r, var_256_3)
								local var_256_5 = Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor1.g, var_256_3)
								local var_256_6 = Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor1.b, var_256_3)

								iter_256_1.color = Color.New(var_256_4, var_256_5, var_256_6)
							else
								local var_256_7 = Mathf.Lerp(iter_256_1.color.r, 1, var_256_3)

								iter_256_1.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps1132 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_256_3 then
						if arg_253_1.isInRecall_ then
							iter_256_3.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1132 = nil
			end

			local var_256_8 = 0
			local var_256_9 = 0.25

			if var_256_8 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_10 = arg_253_1:FormatText(StoryNameCfg[61].name)

				arg_253_1.leftNameTxt_.text = var_256_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_11 = arg_253_1:GetWordFromCfg(117032062)
				local var_256_12 = arg_253_1:FormatText(var_256_11.content)

				arg_253_1.text_.text = var_256_12

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 10
				local var_256_14 = utf8.len(var_256_12)
				local var_256_15 = var_256_13 <= 0 and var_256_9 or var_256_9 * (var_256_14 / var_256_13)

				if var_256_15 > 0 and var_256_9 < var_256_15 then
					arg_253_1.talkMaxDuration = var_256_15

					if var_256_15 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_15 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_12
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032062", "story_v_out_117032.awb") ~= 0 then
					local var_256_16 = manager.audio:GetVoiceLength("story_v_out_117032", "117032062", "story_v_out_117032.awb") / 1000

					if var_256_16 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_16 + var_256_8
					end

					if var_256_11.prefab_name ~= "" and arg_253_1.actors_[var_256_11.prefab_name] ~= nil then
						local var_256_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_11.prefab_name].transform, "story_v_out_117032", "117032062", "story_v_out_117032.awb")

						arg_253_1:RecordAudio("117032062", var_256_17)
						arg_253_1:RecordAudio("117032062", var_256_17)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_117032", "117032062", "story_v_out_117032.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_117032", "117032062", "story_v_out_117032.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_18 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_18 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_18

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_18 and arg_253_1.time_ < var_256_8 + var_256_18 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play117032063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 117032063
		arg_257_1.duration_ = 2.87

		local var_257_0 = {
			zh = 2.866,
			ja = 2.8
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
				arg_257_0:Play117032064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10035"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10035 == nil then
				arg_257_1.var_.actorSpriteComps10035 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps10035 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10035:ToTable()) do
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

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10035 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10035 = nil
			end

			local var_260_8 = arg_257_1.actors_["1132"]
			local var_260_9 = 0

			if var_260_9 < arg_257_1.time_ and arg_257_1.time_ <= var_260_9 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps1132 == nil then
				arg_257_1.var_.actorSpriteComps1132 = var_260_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_10 = 0.2

			if var_260_9 <= arg_257_1.time_ and arg_257_1.time_ < var_260_9 + var_260_10 and not isNil(var_260_8) then
				local var_260_11 = (arg_257_1.time_ - var_260_9) / var_260_10

				if arg_257_1.var_.actorSpriteComps1132 then
					for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_260_5 then
							if arg_257_1.isInRecall_ then
								local var_260_12 = Mathf.Lerp(iter_260_5.color.r, arg_257_1.hightColor2.r, var_260_11)
								local var_260_13 = Mathf.Lerp(iter_260_5.color.g, arg_257_1.hightColor2.g, var_260_11)
								local var_260_14 = Mathf.Lerp(iter_260_5.color.b, arg_257_1.hightColor2.b, var_260_11)

								iter_260_5.color = Color.New(var_260_12, var_260_13, var_260_14)
							else
								local var_260_15 = Mathf.Lerp(iter_260_5.color.r, 0.5, var_260_11)

								iter_260_5.color = Color.New(var_260_15, var_260_15, var_260_15)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_9 + var_260_10 and arg_257_1.time_ < var_260_9 + var_260_10 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps1132 then
				for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_260_7 then
						if arg_257_1.isInRecall_ then
							iter_260_7.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1132 = nil
			end

			local var_260_16 = 0
			local var_260_17 = 0.375

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_18 = arg_257_1:FormatText(StoryNameCfg[369].name)

				arg_257_1.leftNameTxt_.text = var_260_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_19 = arg_257_1:GetWordFromCfg(117032063)
				local var_260_20 = arg_257_1:FormatText(var_260_19.content)

				arg_257_1.text_.text = var_260_20

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_21 = 15
				local var_260_22 = utf8.len(var_260_20)
				local var_260_23 = var_260_21 <= 0 and var_260_17 or var_260_17 * (var_260_22 / var_260_21)

				if var_260_23 > 0 and var_260_17 < var_260_23 then
					arg_257_1.talkMaxDuration = var_260_23

					if var_260_23 + var_260_16 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_16
					end
				end

				arg_257_1.text_.text = var_260_20
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032063", "story_v_out_117032.awb") ~= 0 then
					local var_260_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032063", "story_v_out_117032.awb") / 1000

					if var_260_24 + var_260_16 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_24 + var_260_16
					end

					if var_260_19.prefab_name ~= "" and arg_257_1.actors_[var_260_19.prefab_name] ~= nil then
						local var_260_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_19.prefab_name].transform, "story_v_out_117032", "117032063", "story_v_out_117032.awb")

						arg_257_1:RecordAudio("117032063", var_260_25)
						arg_257_1:RecordAudio("117032063", var_260_25)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_117032", "117032063", "story_v_out_117032.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_117032", "117032063", "story_v_out_117032.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_26 = math.max(var_260_17, arg_257_1.talkMaxDuration)

			if var_260_16 <= arg_257_1.time_ and arg_257_1.time_ < var_260_16 + var_260_26 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_16) / var_260_26

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_16 + var_260_26 and arg_257_1.time_ < var_260_16 + var_260_26 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play117032064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 117032064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play117032065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10035"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				local var_264_2 = var_264_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_264_2 then
					arg_261_1.var_.alphaOldValue10035 = var_264_2.alpha
					arg_261_1.var_.characterEffect10035 = var_264_2
				end

				arg_261_1.var_.alphaOldValue10035 = 1
			end

			local var_264_3 = 0.333333333333333

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_3 then
				local var_264_4 = (arg_261_1.time_ - var_264_1) / var_264_3
				local var_264_5 = Mathf.Lerp(arg_261_1.var_.alphaOldValue10035, 0, var_264_4)

				if arg_261_1.var_.characterEffect10035 then
					arg_261_1.var_.characterEffect10035.alpha = var_264_5
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_3 and arg_261_1.time_ < var_264_1 + var_264_3 + arg_264_0 and arg_261_1.var_.characterEffect10035 then
				arg_261_1.var_.characterEffect10035.alpha = 0
			end

			local var_264_6 = arg_261_1.actors_["1132"]
			local var_264_7 = 0

			if var_264_7 < arg_261_1.time_ and arg_261_1.time_ <= var_264_7 + arg_264_0 then
				local var_264_8 = var_264_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_264_8 then
					arg_261_1.var_.alphaOldValue1132 = var_264_8.alpha
					arg_261_1.var_.characterEffect1132 = var_264_8
				end

				arg_261_1.var_.alphaOldValue1132 = 1
			end

			local var_264_9 = 0.333333333333333

			if var_264_7 <= arg_261_1.time_ and arg_261_1.time_ < var_264_7 + var_264_9 then
				local var_264_10 = (arg_261_1.time_ - var_264_7) / var_264_9
				local var_264_11 = Mathf.Lerp(arg_261_1.var_.alphaOldValue1132, 0, var_264_10)

				if arg_261_1.var_.characterEffect1132 then
					arg_261_1.var_.characterEffect1132.alpha = var_264_11
				end
			end

			if arg_261_1.time_ >= var_264_7 + var_264_9 and arg_261_1.time_ < var_264_7 + var_264_9 + arg_264_0 and arg_261_1.var_.characterEffect1132 then
				arg_261_1.var_.characterEffect1132.alpha = 0
			end

			local var_264_12 = 0
			local var_264_13 = 1.075

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_14 = arg_261_1:GetWordFromCfg(117032064)
				local var_264_15 = arg_261_1:FormatText(var_264_14.content)

				arg_261_1.text_.text = var_264_15

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_16 = 43
				local var_264_17 = utf8.len(var_264_15)
				local var_264_18 = var_264_16 <= 0 and var_264_13 or var_264_13 * (var_264_17 / var_264_16)

				if var_264_18 > 0 and var_264_13 < var_264_18 then
					arg_261_1.talkMaxDuration = var_264_18

					if var_264_18 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_18 + var_264_12
					end
				end

				arg_261_1.text_.text = var_264_15
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_19 = math.max(var_264_13, arg_261_1.talkMaxDuration)

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_19 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_12) / var_264_19

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_12 + var_264_19 and arg_261_1.time_ < var_264_12 + var_264_19 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play117032065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 117032065
		arg_265_1.duration_ = 7.7

		local var_265_0 = {
			zh = 5.233,
			ja = 7.7
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
				arg_265_0:Play117032066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1132"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1132 = var_268_0.localPosition
				var_268_0.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1132", 2)

				local var_268_2 = var_268_0.childCount

				for iter_268_0 = 0, var_268_2 - 1 do
					local var_268_3 = var_268_0:GetChild(iter_268_0)

					if var_268_3.name == "split_6" or not string.find(var_268_3.name, "split") then
						var_268_3.gameObject:SetActive(true)
					else
						var_268_3.gameObject:SetActive(false)
					end
				end
			end

			local var_268_4 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_4 then
				local var_268_5 = (arg_265_1.time_ - var_268_1) / var_268_4
				local var_268_6 = Vector3.New(-390, -413, -185)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1132, var_268_6, var_268_5)
			end

			if arg_265_1.time_ >= var_268_1 + var_268_4 and arg_265_1.time_ < var_268_1 + var_268_4 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_268_7 = arg_265_1.actors_["1132"]
			local var_268_8 = 0

			if var_268_8 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				local var_268_9 = var_268_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_268_9 then
					arg_265_1.var_.alphaOldValue1132 = var_268_9.alpha
					arg_265_1.var_.characterEffect1132 = var_268_9
				end

				arg_265_1.var_.alphaOldValue1132 = 0
			end

			local var_268_10 = 0.333333333333333

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_10 then
				local var_268_11 = (arg_265_1.time_ - var_268_8) / var_268_10
				local var_268_12 = Mathf.Lerp(arg_265_1.var_.alphaOldValue1132, 1, var_268_11)

				if arg_265_1.var_.characterEffect1132 then
					arg_265_1.var_.characterEffect1132.alpha = var_268_12
				end
			end

			if arg_265_1.time_ >= var_268_8 + var_268_10 and arg_265_1.time_ < var_268_8 + var_268_10 + arg_268_0 and arg_265_1.var_.characterEffect1132 then
				arg_265_1.var_.characterEffect1132.alpha = 1
			end

			local var_268_13 = arg_265_1.actors_["1132"]
			local var_268_14 = 0

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 and not isNil(var_268_13) and arg_265_1.var_.actorSpriteComps1132 == nil then
				arg_265_1.var_.actorSpriteComps1132 = var_268_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_15 = 0.2

			if var_268_14 <= arg_265_1.time_ and arg_265_1.time_ < var_268_14 + var_268_15 and not isNil(var_268_13) then
				local var_268_16 = (arg_265_1.time_ - var_268_14) / var_268_15

				if arg_265_1.var_.actorSpriteComps1132 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								local var_268_17 = Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor1.r, var_268_16)
								local var_268_18 = Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor1.g, var_268_16)
								local var_268_19 = Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor1.b, var_268_16)

								iter_268_2.color = Color.New(var_268_17, var_268_18, var_268_19)
							else
								local var_268_20 = Mathf.Lerp(iter_268_2.color.r, 1, var_268_16)

								iter_268_2.color = Color.New(var_268_20, var_268_20, var_268_20)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_14 + var_268_15 and arg_265_1.time_ < var_268_14 + var_268_15 + arg_268_0 and not isNil(var_268_13) and arg_265_1.var_.actorSpriteComps1132 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_268_4 then
						if arg_265_1.isInRecall_ then
							iter_268_4.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1132 = nil
			end

			local var_268_21 = 0
			local var_268_22 = 0.5

			if var_268_21 < arg_265_1.time_ and arg_265_1.time_ <= var_268_21 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_23 = arg_265_1:FormatText(StoryNameCfg[61].name)

				arg_265_1.leftNameTxt_.text = var_268_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_24 = arg_265_1:GetWordFromCfg(117032065)
				local var_268_25 = arg_265_1:FormatText(var_268_24.content)

				arg_265_1.text_.text = var_268_25

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_26 = 20
				local var_268_27 = utf8.len(var_268_25)
				local var_268_28 = var_268_26 <= 0 and var_268_22 or var_268_22 * (var_268_27 / var_268_26)

				if var_268_28 > 0 and var_268_22 < var_268_28 then
					arg_265_1.talkMaxDuration = var_268_28

					if var_268_28 + var_268_21 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_28 + var_268_21
					end
				end

				arg_265_1.text_.text = var_268_25
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032065", "story_v_out_117032.awb") ~= 0 then
					local var_268_29 = manager.audio:GetVoiceLength("story_v_out_117032", "117032065", "story_v_out_117032.awb") / 1000

					if var_268_29 + var_268_21 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_29 + var_268_21
					end

					if var_268_24.prefab_name ~= "" and arg_265_1.actors_[var_268_24.prefab_name] ~= nil then
						local var_268_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_24.prefab_name].transform, "story_v_out_117032", "117032065", "story_v_out_117032.awb")

						arg_265_1:RecordAudio("117032065", var_268_30)
						arg_265_1:RecordAudio("117032065", var_268_30)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_117032", "117032065", "story_v_out_117032.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_117032", "117032065", "story_v_out_117032.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_31 = math.max(var_268_22, arg_265_1.talkMaxDuration)

			if var_268_21 <= arg_265_1.time_ and arg_265_1.time_ < var_268_21 + var_268_31 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_21) / var_268_31

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_21 + var_268_31 and arg_265_1.time_ < var_268_21 + var_268_31 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play117032066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 117032066
		arg_269_1.duration_ = 2.6

		local var_269_0 = {
			zh = 1.7,
			ja = 2.6
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
				arg_269_0:Play117032067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1033"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1033 = var_272_0.localPosition
				var_272_0.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1033", 4)

				local var_272_2 = var_272_0.childCount

				for iter_272_0 = 0, var_272_2 - 1 do
					local var_272_3 = var_272_0:GetChild(iter_272_0)

					if var_272_3.name == "split_6" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_4 then
				local var_272_5 = (arg_269_1.time_ - var_272_1) / var_272_4
				local var_272_6 = Vector3.New(390, -420, 0)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1033, var_272_6, var_272_5)
			end

			if arg_269_1.time_ >= var_272_1 + var_272_4 and arg_269_1.time_ < var_272_1 + var_272_4 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(390, -420, 0)
			end

			local var_272_7 = arg_269_1.actors_["1132"]
			local var_272_8 = 0

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps1132 == nil then
				arg_269_1.var_.actorSpriteComps1132 = var_272_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_9 = 0.2

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_9 and not isNil(var_272_7) then
				local var_272_10 = (arg_269_1.time_ - var_272_8) / var_272_9

				if arg_269_1.var_.actorSpriteComps1132 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								local var_272_11 = Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor2.r, var_272_10)
								local var_272_12 = Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor2.g, var_272_10)
								local var_272_13 = Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor2.b, var_272_10)

								iter_272_2.color = Color.New(var_272_11, var_272_12, var_272_13)
							else
								local var_272_14 = Mathf.Lerp(iter_272_2.color.r, 0.5, var_272_10)

								iter_272_2.color = Color.New(var_272_14, var_272_14, var_272_14)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_8 + var_272_9 and arg_269_1.time_ < var_272_8 + var_272_9 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps1132 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_272_4 then
						if arg_269_1.isInRecall_ then
							iter_272_4.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1132 = nil
			end

			local var_272_15 = arg_269_1.actors_["1033"]
			local var_272_16 = 0

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.actorSpriteComps1033 == nil then
				arg_269_1.var_.actorSpriteComps1033 = var_272_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_17 = 0.2

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_17 and not isNil(var_272_15) then
				local var_272_18 = (arg_269_1.time_ - var_272_16) / var_272_17

				if arg_269_1.var_.actorSpriteComps1033 then
					for iter_272_5, iter_272_6 in pairs(arg_269_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_272_6 then
							if arg_269_1.isInRecall_ then
								local var_272_19 = Mathf.Lerp(iter_272_6.color.r, arg_269_1.hightColor1.r, var_272_18)
								local var_272_20 = Mathf.Lerp(iter_272_6.color.g, arg_269_1.hightColor1.g, var_272_18)
								local var_272_21 = Mathf.Lerp(iter_272_6.color.b, arg_269_1.hightColor1.b, var_272_18)

								iter_272_6.color = Color.New(var_272_19, var_272_20, var_272_21)
							else
								local var_272_22 = Mathf.Lerp(iter_272_6.color.r, 1, var_272_18)

								iter_272_6.color = Color.New(var_272_22, var_272_22, var_272_22)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_16 + var_272_17 and arg_269_1.time_ < var_272_16 + var_272_17 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.actorSpriteComps1033 then
				for iter_272_7, iter_272_8 in pairs(arg_269_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_272_8 then
						if arg_269_1.isInRecall_ then
							iter_272_8.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1033 = nil
			end

			local var_272_23 = arg_269_1.actors_["1033"]
			local var_272_24 = 0

			if var_272_24 < arg_269_1.time_ and arg_269_1.time_ <= var_272_24 + arg_272_0 then
				local var_272_25 = var_272_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_272_25 then
					arg_269_1.var_.alphaOldValue1033 = var_272_25.alpha
					arg_269_1.var_.characterEffect1033 = var_272_25
				end

				arg_269_1.var_.alphaOldValue1033 = 0
			end

			local var_272_26 = 0.2

			if var_272_24 <= arg_269_1.time_ and arg_269_1.time_ < var_272_24 + var_272_26 then
				local var_272_27 = (arg_269_1.time_ - var_272_24) / var_272_26
				local var_272_28 = Mathf.Lerp(arg_269_1.var_.alphaOldValue1033, 1, var_272_27)

				if arg_269_1.var_.characterEffect1033 then
					arg_269_1.var_.characterEffect1033.alpha = var_272_28
				end
			end

			if arg_269_1.time_ >= var_272_24 + var_272_26 and arg_269_1.time_ < var_272_24 + var_272_26 + arg_272_0 and arg_269_1.var_.characterEffect1033 then
				arg_269_1.var_.characterEffect1033.alpha = 1
			end

			local var_272_29 = 0
			local var_272_30 = 0.225

			if var_272_29 < arg_269_1.time_ and arg_269_1.time_ <= var_272_29 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_31 = arg_269_1:FormatText(StoryNameCfg[236].name)

				arg_269_1.leftNameTxt_.text = var_272_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_32 = arg_269_1:GetWordFromCfg(117032066)
				local var_272_33 = arg_269_1:FormatText(var_272_32.content)

				arg_269_1.text_.text = var_272_33

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_34 = 9
				local var_272_35 = utf8.len(var_272_33)
				local var_272_36 = var_272_34 <= 0 and var_272_30 or var_272_30 * (var_272_35 / var_272_34)

				if var_272_36 > 0 and var_272_30 < var_272_36 then
					arg_269_1.talkMaxDuration = var_272_36

					if var_272_36 + var_272_29 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_36 + var_272_29
					end
				end

				arg_269_1.text_.text = var_272_33
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032066", "story_v_out_117032.awb") ~= 0 then
					local var_272_37 = manager.audio:GetVoiceLength("story_v_out_117032", "117032066", "story_v_out_117032.awb") / 1000

					if var_272_37 + var_272_29 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_37 + var_272_29
					end

					if var_272_32.prefab_name ~= "" and arg_269_1.actors_[var_272_32.prefab_name] ~= nil then
						local var_272_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_32.prefab_name].transform, "story_v_out_117032", "117032066", "story_v_out_117032.awb")

						arg_269_1:RecordAudio("117032066", var_272_38)
						arg_269_1:RecordAudio("117032066", var_272_38)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_117032", "117032066", "story_v_out_117032.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_117032", "117032066", "story_v_out_117032.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_39 = math.max(var_272_30, arg_269_1.talkMaxDuration)

			if var_272_29 <= arg_269_1.time_ and arg_269_1.time_ < var_272_29 + var_272_39 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_29) / var_272_39

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_29 + var_272_39 and arg_269_1.time_ < var_272_29 + var_272_39 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play117032067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 117032067
		arg_273_1.duration_ = 6.47

		local var_273_0 = {
			zh = 6.366,
			ja = 6.466
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play117032068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.875

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[236].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:GetWordFromCfg(117032067)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 35
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032067", "story_v_out_117032.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032067", "story_v_out_117032.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_117032", "117032067", "story_v_out_117032.awb")

						arg_273_1:RecordAudio("117032067", var_276_9)
						arg_273_1:RecordAudio("117032067", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_117032", "117032067", "story_v_out_117032.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_117032", "117032067", "story_v_out_117032.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_10 and arg_273_1.time_ < var_276_0 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play117032068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 117032068
		arg_277_1.duration_ = 10.53

		local var_277_0 = {
			zh = 10.366,
			ja = 10.533
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
				arg_277_0:Play117032069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1132"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps1132 == nil then
				arg_277_1.var_.actorSpriteComps1132 = var_280_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_2 = 0.2

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.actorSpriteComps1132 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								local var_280_4 = Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor1.r, var_280_3)
								local var_280_5 = Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor1.g, var_280_3)
								local var_280_6 = Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor1.b, var_280_3)

								iter_280_1.color = Color.New(var_280_4, var_280_5, var_280_6)
							else
								local var_280_7 = Mathf.Lerp(iter_280_1.color.r, 1, var_280_3)

								iter_280_1.color = Color.New(var_280_7, var_280_7, var_280_7)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps1132 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_280_3 then
						if arg_277_1.isInRecall_ then
							iter_280_3.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1132 = nil
			end

			local var_280_8 = arg_277_1.actors_["1033"]
			local var_280_9 = 0

			if var_280_9 < arg_277_1.time_ and arg_277_1.time_ <= var_280_9 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps1033 == nil then
				arg_277_1.var_.actorSpriteComps1033 = var_280_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_10 = 0.2

			if var_280_9 <= arg_277_1.time_ and arg_277_1.time_ < var_280_9 + var_280_10 and not isNil(var_280_8) then
				local var_280_11 = (arg_277_1.time_ - var_280_9) / var_280_10

				if arg_277_1.var_.actorSpriteComps1033 then
					for iter_280_4, iter_280_5 in pairs(arg_277_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_280_5 then
							if arg_277_1.isInRecall_ then
								local var_280_12 = Mathf.Lerp(iter_280_5.color.r, arg_277_1.hightColor2.r, var_280_11)
								local var_280_13 = Mathf.Lerp(iter_280_5.color.g, arg_277_1.hightColor2.g, var_280_11)
								local var_280_14 = Mathf.Lerp(iter_280_5.color.b, arg_277_1.hightColor2.b, var_280_11)

								iter_280_5.color = Color.New(var_280_12, var_280_13, var_280_14)
							else
								local var_280_15 = Mathf.Lerp(iter_280_5.color.r, 0.5, var_280_11)

								iter_280_5.color = Color.New(var_280_15, var_280_15, var_280_15)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_9 + var_280_10 and arg_277_1.time_ < var_280_9 + var_280_10 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps1033 then
				for iter_280_6, iter_280_7 in pairs(arg_277_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_280_7 then
						if arg_277_1.isInRecall_ then
							iter_280_7.color = arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_280_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1033 = nil
			end

			local var_280_16 = 0
			local var_280_17 = 0.8

			if var_280_16 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_18 = arg_277_1:FormatText(StoryNameCfg[61].name)

				arg_277_1.leftNameTxt_.text = var_280_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_19 = arg_277_1:GetWordFromCfg(117032068)
				local var_280_20 = arg_277_1:FormatText(var_280_19.content)

				arg_277_1.text_.text = var_280_20

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_21 = 32
				local var_280_22 = utf8.len(var_280_20)
				local var_280_23 = var_280_21 <= 0 and var_280_17 or var_280_17 * (var_280_22 / var_280_21)

				if var_280_23 > 0 and var_280_17 < var_280_23 then
					arg_277_1.talkMaxDuration = var_280_23

					if var_280_23 + var_280_16 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_16
					end
				end

				arg_277_1.text_.text = var_280_20
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032068", "story_v_out_117032.awb") ~= 0 then
					local var_280_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032068", "story_v_out_117032.awb") / 1000

					if var_280_24 + var_280_16 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_24 + var_280_16
					end

					if var_280_19.prefab_name ~= "" and arg_277_1.actors_[var_280_19.prefab_name] ~= nil then
						local var_280_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_19.prefab_name].transform, "story_v_out_117032", "117032068", "story_v_out_117032.awb")

						arg_277_1:RecordAudio("117032068", var_280_25)
						arg_277_1:RecordAudio("117032068", var_280_25)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_117032", "117032068", "story_v_out_117032.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_117032", "117032068", "story_v_out_117032.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_26 = math.max(var_280_17, arg_277_1.talkMaxDuration)

			if var_280_16 <= arg_277_1.time_ and arg_277_1.time_ < var_280_16 + var_280_26 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_16) / var_280_26

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_16 + var_280_26 and arg_277_1.time_ < var_280_16 + var_280_26 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play117032069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 117032069
		arg_281_1.duration_ = 9.83

		local var_281_0 = {
			zh = 7.133,
			ja = 9.833
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play117032070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1132"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps1132 == nil then
				arg_281_1.var_.actorSpriteComps1132 = var_284_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_2 = 0.2

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.actorSpriteComps1132 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps1132 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_284_3 then
						if arg_281_1.isInRecall_ then
							iter_284_3.color = arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_284_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps1132 = nil
			end

			local var_284_8 = arg_281_1.actors_["1033"]
			local var_284_9 = 0

			if var_284_9 < arg_281_1.time_ and arg_281_1.time_ <= var_284_9 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.actorSpriteComps1033 == nil then
				arg_281_1.var_.actorSpriteComps1033 = var_284_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_10 = 0.2

			if var_284_9 <= arg_281_1.time_ and arg_281_1.time_ < var_284_9 + var_284_10 and not isNil(var_284_8) then
				local var_284_11 = (arg_281_1.time_ - var_284_9) / var_284_10

				if arg_281_1.var_.actorSpriteComps1033 then
					for iter_284_4, iter_284_5 in pairs(arg_281_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_284_5 then
							if arg_281_1.isInRecall_ then
								local var_284_12 = Mathf.Lerp(iter_284_5.color.r, arg_281_1.hightColor1.r, var_284_11)
								local var_284_13 = Mathf.Lerp(iter_284_5.color.g, arg_281_1.hightColor1.g, var_284_11)
								local var_284_14 = Mathf.Lerp(iter_284_5.color.b, arg_281_1.hightColor1.b, var_284_11)

								iter_284_5.color = Color.New(var_284_12, var_284_13, var_284_14)
							else
								local var_284_15 = Mathf.Lerp(iter_284_5.color.r, 1, var_284_11)

								iter_284_5.color = Color.New(var_284_15, var_284_15, var_284_15)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_9 + var_284_10 and arg_281_1.time_ < var_284_9 + var_284_10 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.actorSpriteComps1033 then
				for iter_284_6, iter_284_7 in pairs(arg_281_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_284_7 then
						if arg_281_1.isInRecall_ then
							iter_284_7.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_284_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps1033 = nil
			end

			local var_284_16 = 0
			local var_284_17 = 0.925

			if var_284_16 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_18 = arg_281_1:FormatText(StoryNameCfg[236].name)

				arg_281_1.leftNameTxt_.text = var_284_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_19 = arg_281_1:GetWordFromCfg(117032069)
				local var_284_20 = arg_281_1:FormatText(var_284_19.content)

				arg_281_1.text_.text = var_284_20

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_21 = 37
				local var_284_22 = utf8.len(var_284_20)
				local var_284_23 = var_284_21 <= 0 and var_284_17 or var_284_17 * (var_284_22 / var_284_21)

				if var_284_23 > 0 and var_284_17 < var_284_23 then
					arg_281_1.talkMaxDuration = var_284_23

					if var_284_23 + var_284_16 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_16
					end
				end

				arg_281_1.text_.text = var_284_20
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032069", "story_v_out_117032.awb") ~= 0 then
					local var_284_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032069", "story_v_out_117032.awb") / 1000

					if var_284_24 + var_284_16 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_24 + var_284_16
					end

					if var_284_19.prefab_name ~= "" and arg_281_1.actors_[var_284_19.prefab_name] ~= nil then
						local var_284_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_19.prefab_name].transform, "story_v_out_117032", "117032069", "story_v_out_117032.awb")

						arg_281_1:RecordAudio("117032069", var_284_25)
						arg_281_1:RecordAudio("117032069", var_284_25)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_117032", "117032069", "story_v_out_117032.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_117032", "117032069", "story_v_out_117032.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_26 = math.max(var_284_17, arg_281_1.talkMaxDuration)

			if var_284_16 <= arg_281_1.time_ and arg_281_1.time_ < var_284_16 + var_284_26 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_16) / var_284_26

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_16 + var_284_26 and arg_281_1.time_ < var_284_16 + var_284_26 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play117032070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 117032070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play117032071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1033"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps1033 == nil then
				arg_285_1.var_.actorSpriteComps1033 = var_288_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_2 = 0.2

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.actorSpriteComps1033 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								local var_288_4 = Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor2.r, var_288_3)
								local var_288_5 = Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor2.g, var_288_3)
								local var_288_6 = Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor2.b, var_288_3)

								iter_288_1.color = Color.New(var_288_4, var_288_5, var_288_6)
							else
								local var_288_7 = Mathf.Lerp(iter_288_1.color.r, 0.5, var_288_3)

								iter_288_1.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps1033 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_288_3 then
						if arg_285_1.isInRecall_ then
							iter_288_3.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1033 = nil
			end

			local var_288_8 = 0
			local var_288_9 = 0.75

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_10 = arg_285_1:GetWordFromCfg(117032070)
				local var_288_11 = arg_285_1:FormatText(var_288_10.content)

				arg_285_1.text_.text = var_288_11

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_12 = 30
				local var_288_13 = utf8.len(var_288_11)
				local var_288_14 = var_288_12 <= 0 and var_288_9 or var_288_9 * (var_288_13 / var_288_12)

				if var_288_14 > 0 and var_288_9 < var_288_14 then
					arg_285_1.talkMaxDuration = var_288_14

					if var_288_14 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_8
					end
				end

				arg_285_1.text_.text = var_288_11
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_15 = math.max(var_288_9, arg_285_1.talkMaxDuration)

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_15 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_8) / var_288_15

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_8 + var_288_15 and arg_285_1.time_ < var_288_8 + var_288_15 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play117032071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 117032071
		arg_289_1.duration_ = 4.83

		local var_289_0 = {
			zh = 4.233,
			ja = 4.833
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play117032072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1132"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1132 == nil then
				arg_289_1.var_.actorSpriteComps1132 = var_292_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_2 = 0.2

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.actorSpriteComps1132 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								local var_292_4 = Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor1.r, var_292_3)
								local var_292_5 = Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor1.g, var_292_3)
								local var_292_6 = Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor1.b, var_292_3)

								iter_292_1.color = Color.New(var_292_4, var_292_5, var_292_6)
							else
								local var_292_7 = Mathf.Lerp(iter_292_1.color.r, 1, var_292_3)

								iter_292_1.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1132 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_292_3 then
						if arg_289_1.isInRecall_ then
							iter_292_3.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1132 = nil
			end

			local var_292_8 = 0
			local var_292_9 = 0.3

			if var_292_8 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_10 = arg_289_1:FormatText(StoryNameCfg[61].name)

				arg_289_1.leftNameTxt_.text = var_292_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_11 = arg_289_1:GetWordFromCfg(117032071)
				local var_292_12 = arg_289_1:FormatText(var_292_11.content)

				arg_289_1.text_.text = var_292_12

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_13 = 12
				local var_292_14 = utf8.len(var_292_12)
				local var_292_15 = var_292_13 <= 0 and var_292_9 or var_292_9 * (var_292_14 / var_292_13)

				if var_292_15 > 0 and var_292_9 < var_292_15 then
					arg_289_1.talkMaxDuration = var_292_15

					if var_292_15 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_15 + var_292_8
					end
				end

				arg_289_1.text_.text = var_292_12
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032071", "story_v_out_117032.awb") ~= 0 then
					local var_292_16 = manager.audio:GetVoiceLength("story_v_out_117032", "117032071", "story_v_out_117032.awb") / 1000

					if var_292_16 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_16 + var_292_8
					end

					if var_292_11.prefab_name ~= "" and arg_289_1.actors_[var_292_11.prefab_name] ~= nil then
						local var_292_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_11.prefab_name].transform, "story_v_out_117032", "117032071", "story_v_out_117032.awb")

						arg_289_1:RecordAudio("117032071", var_292_17)
						arg_289_1:RecordAudio("117032071", var_292_17)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_117032", "117032071", "story_v_out_117032.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_117032", "117032071", "story_v_out_117032.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_18 = math.max(var_292_9, arg_289_1.talkMaxDuration)

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_18 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_8) / var_292_18

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_8 + var_292_18 and arg_289_1.time_ < var_292_8 + var_292_18 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play117032072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 117032072
		arg_293_1.duration_ = 6.9

		local var_293_0 = {
			zh = 3.833,
			ja = 6.9
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play117032073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1132"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps1132 == nil then
				arg_293_1.var_.actorSpriteComps1132 = var_296_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_2 = 0.2

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.actorSpriteComps1132 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								local var_296_4 = Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor2.r, var_296_3)
								local var_296_5 = Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor2.g, var_296_3)
								local var_296_6 = Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor2.b, var_296_3)

								iter_296_1.color = Color.New(var_296_4, var_296_5, var_296_6)
							else
								local var_296_7 = Mathf.Lerp(iter_296_1.color.r, 0.5, var_296_3)

								iter_296_1.color = Color.New(var_296_7, var_296_7, var_296_7)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps1132 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_296_3 then
						if arg_293_1.isInRecall_ then
							iter_296_3.color = arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_296_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps1132 = nil
			end

			local var_296_8 = arg_293_1.actors_["1033"]
			local var_296_9 = 0

			if var_296_9 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.actorSpriteComps1033 == nil then
				arg_293_1.var_.actorSpriteComps1033 = var_296_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_10 = 0.2

			if var_296_9 <= arg_293_1.time_ and arg_293_1.time_ < var_296_9 + var_296_10 and not isNil(var_296_8) then
				local var_296_11 = (arg_293_1.time_ - var_296_9) / var_296_10

				if arg_293_1.var_.actorSpriteComps1033 then
					for iter_296_4, iter_296_5 in pairs(arg_293_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_296_5 then
							if arg_293_1.isInRecall_ then
								local var_296_12 = Mathf.Lerp(iter_296_5.color.r, arg_293_1.hightColor1.r, var_296_11)
								local var_296_13 = Mathf.Lerp(iter_296_5.color.g, arg_293_1.hightColor1.g, var_296_11)
								local var_296_14 = Mathf.Lerp(iter_296_5.color.b, arg_293_1.hightColor1.b, var_296_11)

								iter_296_5.color = Color.New(var_296_12, var_296_13, var_296_14)
							else
								local var_296_15 = Mathf.Lerp(iter_296_5.color.r, 1, var_296_11)

								iter_296_5.color = Color.New(var_296_15, var_296_15, var_296_15)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_9 + var_296_10 and arg_293_1.time_ < var_296_9 + var_296_10 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.actorSpriteComps1033 then
				for iter_296_6, iter_296_7 in pairs(arg_293_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_296_7 then
						if arg_293_1.isInRecall_ then
							iter_296_7.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps1033 = nil
			end

			local var_296_16 = 0
			local var_296_17 = 0.45

			if var_296_16 < arg_293_1.time_ and arg_293_1.time_ <= var_296_16 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_18 = arg_293_1:FormatText(StoryNameCfg[236].name)

				arg_293_1.leftNameTxt_.text = var_296_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_19 = arg_293_1:GetWordFromCfg(117032072)
				local var_296_20 = arg_293_1:FormatText(var_296_19.content)

				arg_293_1.text_.text = var_296_20

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_21 = 18
				local var_296_22 = utf8.len(var_296_20)
				local var_296_23 = var_296_21 <= 0 and var_296_17 or var_296_17 * (var_296_22 / var_296_21)

				if var_296_23 > 0 and var_296_17 < var_296_23 then
					arg_293_1.talkMaxDuration = var_296_23

					if var_296_23 + var_296_16 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_16
					end
				end

				arg_293_1.text_.text = var_296_20
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032072", "story_v_out_117032.awb") ~= 0 then
					local var_296_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032072", "story_v_out_117032.awb") / 1000

					if var_296_24 + var_296_16 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_24 + var_296_16
					end

					if var_296_19.prefab_name ~= "" and arg_293_1.actors_[var_296_19.prefab_name] ~= nil then
						local var_296_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_19.prefab_name].transform, "story_v_out_117032", "117032072", "story_v_out_117032.awb")

						arg_293_1:RecordAudio("117032072", var_296_25)
						arg_293_1:RecordAudio("117032072", var_296_25)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_117032", "117032072", "story_v_out_117032.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_117032", "117032072", "story_v_out_117032.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_26 = math.max(var_296_17, arg_293_1.talkMaxDuration)

			if var_296_16 <= arg_293_1.time_ and arg_293_1.time_ < var_296_16 + var_296_26 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_16) / var_296_26

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_16 + var_296_26 and arg_293_1.time_ < var_296_16 + var_296_26 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play117032073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 117032073
		arg_297_1.duration_ = 6.8

		local var_297_0 = {
			zh = 4.833,
			ja = 6.8
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play117032074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1132"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps1132 == nil then
				arg_297_1.var_.actorSpriteComps1132 = var_300_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_2 = 0.2

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.actorSpriteComps1132 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								local var_300_4 = Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor1.r, var_300_3)
								local var_300_5 = Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor1.g, var_300_3)
								local var_300_6 = Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor1.b, var_300_3)

								iter_300_1.color = Color.New(var_300_4, var_300_5, var_300_6)
							else
								local var_300_7 = Mathf.Lerp(iter_300_1.color.r, 1, var_300_3)

								iter_300_1.color = Color.New(var_300_7, var_300_7, var_300_7)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps1132 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_300_3 then
						if arg_297_1.isInRecall_ then
							iter_300_3.color = arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_300_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1132 = nil
			end

			local var_300_8 = arg_297_1.actors_["1033"]
			local var_300_9 = 0

			if var_300_9 < arg_297_1.time_ and arg_297_1.time_ <= var_300_9 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.actorSpriteComps1033 == nil then
				arg_297_1.var_.actorSpriteComps1033 = var_300_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_10 = 0.2

			if var_300_9 <= arg_297_1.time_ and arg_297_1.time_ < var_300_9 + var_300_10 and not isNil(var_300_8) then
				local var_300_11 = (arg_297_1.time_ - var_300_9) / var_300_10

				if arg_297_1.var_.actorSpriteComps1033 then
					for iter_300_4, iter_300_5 in pairs(arg_297_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_300_5 then
							if arg_297_1.isInRecall_ then
								local var_300_12 = Mathf.Lerp(iter_300_5.color.r, arg_297_1.hightColor2.r, var_300_11)
								local var_300_13 = Mathf.Lerp(iter_300_5.color.g, arg_297_1.hightColor2.g, var_300_11)
								local var_300_14 = Mathf.Lerp(iter_300_5.color.b, arg_297_1.hightColor2.b, var_300_11)

								iter_300_5.color = Color.New(var_300_12, var_300_13, var_300_14)
							else
								local var_300_15 = Mathf.Lerp(iter_300_5.color.r, 0.5, var_300_11)

								iter_300_5.color = Color.New(var_300_15, var_300_15, var_300_15)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_9 + var_300_10 and arg_297_1.time_ < var_300_9 + var_300_10 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.actorSpriteComps1033 then
				for iter_300_6, iter_300_7 in pairs(arg_297_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_300_7 then
						if arg_297_1.isInRecall_ then
							iter_300_7.color = arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_300_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1033 = nil
			end

			local var_300_16 = 0
			local var_300_17 = 0.6

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_18 = arg_297_1:FormatText(StoryNameCfg[61].name)

				arg_297_1.leftNameTxt_.text = var_300_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_19 = arg_297_1:GetWordFromCfg(117032073)
				local var_300_20 = arg_297_1:FormatText(var_300_19.content)

				arg_297_1.text_.text = var_300_20

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_21 = 24
				local var_300_22 = utf8.len(var_300_20)
				local var_300_23 = var_300_21 <= 0 and var_300_17 or var_300_17 * (var_300_22 / var_300_21)

				if var_300_23 > 0 and var_300_17 < var_300_23 then
					arg_297_1.talkMaxDuration = var_300_23

					if var_300_23 + var_300_16 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_23 + var_300_16
					end
				end

				arg_297_1.text_.text = var_300_20
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032073", "story_v_out_117032.awb") ~= 0 then
					local var_300_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032073", "story_v_out_117032.awb") / 1000

					if var_300_24 + var_300_16 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_24 + var_300_16
					end

					if var_300_19.prefab_name ~= "" and arg_297_1.actors_[var_300_19.prefab_name] ~= nil then
						local var_300_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_19.prefab_name].transform, "story_v_out_117032", "117032073", "story_v_out_117032.awb")

						arg_297_1:RecordAudio("117032073", var_300_25)
						arg_297_1:RecordAudio("117032073", var_300_25)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_117032", "117032073", "story_v_out_117032.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_117032", "117032073", "story_v_out_117032.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_26 = math.max(var_300_17, arg_297_1.talkMaxDuration)

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_26 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_16) / var_300_26

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_16 + var_300_26 and arg_297_1.time_ < var_300_16 + var_300_26 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play117032074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 117032074
		arg_301_1.duration_ = 9.8

		local var_301_0 = {
			zh = 9.8,
			ja = 8.8
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
				arg_301_0:Play117032075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 1.175

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[61].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:GetWordFromCfg(117032074)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 47
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032074", "story_v_out_117032.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_117032", "117032074", "story_v_out_117032.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_117032", "117032074", "story_v_out_117032.awb")

						arg_301_1:RecordAudio("117032074", var_304_9)
						arg_301_1:RecordAudio("117032074", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_117032", "117032074", "story_v_out_117032.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_117032", "117032074", "story_v_out_117032.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_10 and arg_301_1.time_ < var_304_0 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play117032075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 117032075
		arg_305_1.duration_ = 4.57

		local var_305_0 = {
			zh = 2.3,
			ja = 4.566
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
				arg_305_0:Play117032076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1132"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps1132 == nil then
				arg_305_1.var_.actorSpriteComps1132 = var_308_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_2 = 0.2

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.actorSpriteComps1132 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_308_1 then
							if arg_305_1.isInRecall_ then
								local var_308_4 = Mathf.Lerp(iter_308_1.color.r, arg_305_1.hightColor2.r, var_308_3)
								local var_308_5 = Mathf.Lerp(iter_308_1.color.g, arg_305_1.hightColor2.g, var_308_3)
								local var_308_6 = Mathf.Lerp(iter_308_1.color.b, arg_305_1.hightColor2.b, var_308_3)

								iter_308_1.color = Color.New(var_308_4, var_308_5, var_308_6)
							else
								local var_308_7 = Mathf.Lerp(iter_308_1.color.r, 0.5, var_308_3)

								iter_308_1.color = Color.New(var_308_7, var_308_7, var_308_7)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps1132 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_308_3 then
						if arg_305_1.isInRecall_ then
							iter_308_3.color = arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_308_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps1132 = nil
			end

			local var_308_8 = arg_305_1.actors_["1033"]
			local var_308_9 = 0

			if var_308_9 < arg_305_1.time_ and arg_305_1.time_ <= var_308_9 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.actorSpriteComps1033 == nil then
				arg_305_1.var_.actorSpriteComps1033 = var_308_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_10 = 0.2

			if var_308_9 <= arg_305_1.time_ and arg_305_1.time_ < var_308_9 + var_308_10 and not isNil(var_308_8) then
				local var_308_11 = (arg_305_1.time_ - var_308_9) / var_308_10

				if arg_305_1.var_.actorSpriteComps1033 then
					for iter_308_4, iter_308_5 in pairs(arg_305_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_308_5 then
							if arg_305_1.isInRecall_ then
								local var_308_12 = Mathf.Lerp(iter_308_5.color.r, arg_305_1.hightColor1.r, var_308_11)
								local var_308_13 = Mathf.Lerp(iter_308_5.color.g, arg_305_1.hightColor1.g, var_308_11)
								local var_308_14 = Mathf.Lerp(iter_308_5.color.b, arg_305_1.hightColor1.b, var_308_11)

								iter_308_5.color = Color.New(var_308_12, var_308_13, var_308_14)
							else
								local var_308_15 = Mathf.Lerp(iter_308_5.color.r, 1, var_308_11)

								iter_308_5.color = Color.New(var_308_15, var_308_15, var_308_15)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_9 + var_308_10 and arg_305_1.time_ < var_308_9 + var_308_10 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.actorSpriteComps1033 then
				for iter_308_6, iter_308_7 in pairs(arg_305_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_308_7 then
						if arg_305_1.isInRecall_ then
							iter_308_7.color = arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_308_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps1033 = nil
			end

			local var_308_16 = 0
			local var_308_17 = 0.2

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_18 = arg_305_1:FormatText(StoryNameCfg[236].name)

				arg_305_1.leftNameTxt_.text = var_308_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_19 = arg_305_1:GetWordFromCfg(117032075)
				local var_308_20 = arg_305_1:FormatText(var_308_19.content)

				arg_305_1.text_.text = var_308_20

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_21 = 8
				local var_308_22 = utf8.len(var_308_20)
				local var_308_23 = var_308_21 <= 0 and var_308_17 or var_308_17 * (var_308_22 / var_308_21)

				if var_308_23 > 0 and var_308_17 < var_308_23 then
					arg_305_1.talkMaxDuration = var_308_23

					if var_308_23 + var_308_16 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_23 + var_308_16
					end
				end

				arg_305_1.text_.text = var_308_20
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032075", "story_v_out_117032.awb") ~= 0 then
					local var_308_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032075", "story_v_out_117032.awb") / 1000

					if var_308_24 + var_308_16 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_24 + var_308_16
					end

					if var_308_19.prefab_name ~= "" and arg_305_1.actors_[var_308_19.prefab_name] ~= nil then
						local var_308_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_19.prefab_name].transform, "story_v_out_117032", "117032075", "story_v_out_117032.awb")

						arg_305_1:RecordAudio("117032075", var_308_25)
						arg_305_1:RecordAudio("117032075", var_308_25)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_117032", "117032075", "story_v_out_117032.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_117032", "117032075", "story_v_out_117032.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_26 = math.max(var_308_17, arg_305_1.talkMaxDuration)

			if var_308_16 <= arg_305_1.time_ and arg_305_1.time_ < var_308_16 + var_308_26 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_16) / var_308_26

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_16 + var_308_26 and arg_305_1.time_ < var_308_16 + var_308_26 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play117032076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 117032076
		arg_309_1.duration_ = 5.3

		local var_309_0 = {
			zh = 3.2,
			ja = 5.3
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play117032077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1132"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.actorSpriteComps1132 == nil then
				arg_309_1.var_.actorSpriteComps1132 = var_312_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_2 = 0.2

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.actorSpriteComps1132 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_312_1 then
							if arg_309_1.isInRecall_ then
								local var_312_4 = Mathf.Lerp(iter_312_1.color.r, arg_309_1.hightColor1.r, var_312_3)
								local var_312_5 = Mathf.Lerp(iter_312_1.color.g, arg_309_1.hightColor1.g, var_312_3)
								local var_312_6 = Mathf.Lerp(iter_312_1.color.b, arg_309_1.hightColor1.b, var_312_3)

								iter_312_1.color = Color.New(var_312_4, var_312_5, var_312_6)
							else
								local var_312_7 = Mathf.Lerp(iter_312_1.color.r, 1, var_312_3)

								iter_312_1.color = Color.New(var_312_7, var_312_7, var_312_7)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.actorSpriteComps1132 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_312_3 then
						if arg_309_1.isInRecall_ then
							iter_312_3.color = arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_312_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps1132 = nil
			end

			local var_312_8 = arg_309_1.actors_["1033"]
			local var_312_9 = 0

			if var_312_9 < arg_309_1.time_ and arg_309_1.time_ <= var_312_9 + arg_312_0 and not isNil(var_312_8) and arg_309_1.var_.actorSpriteComps1033 == nil then
				arg_309_1.var_.actorSpriteComps1033 = var_312_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_10 = 0.2

			if var_312_9 <= arg_309_1.time_ and arg_309_1.time_ < var_312_9 + var_312_10 and not isNil(var_312_8) then
				local var_312_11 = (arg_309_1.time_ - var_312_9) / var_312_10

				if arg_309_1.var_.actorSpriteComps1033 then
					for iter_312_4, iter_312_5 in pairs(arg_309_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_312_5 then
							if arg_309_1.isInRecall_ then
								local var_312_12 = Mathf.Lerp(iter_312_5.color.r, arg_309_1.hightColor2.r, var_312_11)
								local var_312_13 = Mathf.Lerp(iter_312_5.color.g, arg_309_1.hightColor2.g, var_312_11)
								local var_312_14 = Mathf.Lerp(iter_312_5.color.b, arg_309_1.hightColor2.b, var_312_11)

								iter_312_5.color = Color.New(var_312_12, var_312_13, var_312_14)
							else
								local var_312_15 = Mathf.Lerp(iter_312_5.color.r, 0.5, var_312_11)

								iter_312_5.color = Color.New(var_312_15, var_312_15, var_312_15)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_9 + var_312_10 and arg_309_1.time_ < var_312_9 + var_312_10 + arg_312_0 and not isNil(var_312_8) and arg_309_1.var_.actorSpriteComps1033 then
				for iter_312_6, iter_312_7 in pairs(arg_309_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_312_7 then
						if arg_309_1.isInRecall_ then
							iter_312_7.color = arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_312_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps1033 = nil
			end

			local var_312_16 = 0
			local var_312_17 = 0.375

			if var_312_16 < arg_309_1.time_ and arg_309_1.time_ <= var_312_16 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_18 = arg_309_1:FormatText(StoryNameCfg[61].name)

				arg_309_1.leftNameTxt_.text = var_312_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_19 = arg_309_1:GetWordFromCfg(117032076)
				local var_312_20 = arg_309_1:FormatText(var_312_19.content)

				arg_309_1.text_.text = var_312_20

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_21 = 15
				local var_312_22 = utf8.len(var_312_20)
				local var_312_23 = var_312_21 <= 0 and var_312_17 or var_312_17 * (var_312_22 / var_312_21)

				if var_312_23 > 0 and var_312_17 < var_312_23 then
					arg_309_1.talkMaxDuration = var_312_23

					if var_312_23 + var_312_16 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_23 + var_312_16
					end
				end

				arg_309_1.text_.text = var_312_20
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117032", "117032076", "story_v_out_117032.awb") ~= 0 then
					local var_312_24 = manager.audio:GetVoiceLength("story_v_out_117032", "117032076", "story_v_out_117032.awb") / 1000

					if var_312_24 + var_312_16 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_24 + var_312_16
					end

					if var_312_19.prefab_name ~= "" and arg_309_1.actors_[var_312_19.prefab_name] ~= nil then
						local var_312_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_19.prefab_name].transform, "story_v_out_117032", "117032076", "story_v_out_117032.awb")

						arg_309_1:RecordAudio("117032076", var_312_25)
						arg_309_1:RecordAudio("117032076", var_312_25)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_117032", "117032076", "story_v_out_117032.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_117032", "117032076", "story_v_out_117032.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_26 = math.max(var_312_17, arg_309_1.talkMaxDuration)

			if var_312_16 <= arg_309_1.time_ and arg_309_1.time_ < var_312_16 + var_312_26 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_16) / var_312_26

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_16 + var_312_26 and arg_309_1.time_ < var_312_16 + var_312_26 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play117032077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 117032077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
			arg_313_1.auto_ = false
		end

		function arg_313_1.playNext_(arg_315_0)
			arg_313_1.onStoryFinished_()
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1132"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				local var_316_2 = var_316_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_316_2 then
					arg_313_1.var_.alphaOldValue1132 = var_316_2.alpha
					arg_313_1.var_.characterEffect1132 = var_316_2
				end

				arg_313_1.var_.alphaOldValue1132 = 1
			end

			local var_316_3 = 0.333333333333333

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_3 then
				local var_316_4 = (arg_313_1.time_ - var_316_1) / var_316_3
				local var_316_5 = Mathf.Lerp(arg_313_1.var_.alphaOldValue1132, 0, var_316_4)

				if arg_313_1.var_.characterEffect1132 then
					arg_313_1.var_.characterEffect1132.alpha = var_316_5
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_3 and arg_313_1.time_ < var_316_1 + var_316_3 + arg_316_0 and arg_313_1.var_.characterEffect1132 then
				arg_313_1.var_.characterEffect1132.alpha = 0
			end

			local var_316_6 = arg_313_1.actors_["1033"]
			local var_316_7 = 0

			if var_316_7 < arg_313_1.time_ and arg_313_1.time_ <= var_316_7 + arg_316_0 then
				local var_316_8 = var_316_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_316_8 then
					arg_313_1.var_.alphaOldValue1033 = var_316_8.alpha
					arg_313_1.var_.characterEffect1033 = var_316_8
				end

				arg_313_1.var_.alphaOldValue1033 = 1
			end

			local var_316_9 = 0.333333333333333

			if var_316_7 <= arg_313_1.time_ and arg_313_1.time_ < var_316_7 + var_316_9 then
				local var_316_10 = (arg_313_1.time_ - var_316_7) / var_316_9
				local var_316_11 = Mathf.Lerp(arg_313_1.var_.alphaOldValue1033, 0, var_316_10)

				if arg_313_1.var_.characterEffect1033 then
					arg_313_1.var_.characterEffect1033.alpha = var_316_11
				end
			end

			if arg_313_1.time_ >= var_316_7 + var_316_9 and arg_313_1.time_ < var_316_7 + var_316_9 + arg_316_0 and arg_313_1.var_.characterEffect1033 then
				arg_313_1.var_.characterEffect1033.alpha = 0
			end

			local var_316_12 = 0
			local var_316_13 = 1.4

			if var_316_12 < arg_313_1.time_ and arg_313_1.time_ <= var_316_12 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_14 = arg_313_1:GetWordFromCfg(117032077)
				local var_316_15 = arg_313_1:FormatText(var_316_14.content)

				arg_313_1.text_.text = var_316_15

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_16 = 56
				local var_316_17 = utf8.len(var_316_15)
				local var_316_18 = var_316_16 <= 0 and var_316_13 or var_316_13 * (var_316_17 / var_316_16)

				if var_316_18 > 0 and var_316_13 < var_316_18 then
					arg_313_1.talkMaxDuration = var_316_18

					if var_316_18 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_18 + var_316_12
					end
				end

				arg_313_1.text_.text = var_316_15
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_19 = math.max(var_316_13, arg_313_1.talkMaxDuration)

			if var_316_12 <= arg_313_1.time_ and arg_313_1.time_ < var_316_12 + var_316_19 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_12) / var_316_19

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_12 + var_316_19 and arg_313_1.time_ < var_316_12 + var_316_19 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I08a",
		"TextureConfig/Background/ST28"
	},
	voices = {
		"story_v_out_117032.awb"
	}
}
