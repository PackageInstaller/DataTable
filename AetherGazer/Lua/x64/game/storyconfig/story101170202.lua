return {
	Play117022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 117022001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play117022002(arg_1_1)
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
			local var_4_23 = 0.6

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

			local var_4_28 = 2
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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
			local var_4_35 = 1.05

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

				local var_4_37 = arg_1_1:GetWordFromCfg(117022001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 42
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
	Play117022002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 117022002
		arg_9_1.duration_ = 5.1

		local var_9_0 = {
			zh = 5.1,
			ja = 4.866
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
				arg_9_0:Play117022003(arg_9_1)
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

			local var_12_4 = arg_9_1.actors_["1033"]
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				local var_12_6 = var_12_4:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_6 then
					arg_9_1.var_.alphaOldValue1033 = var_12_6.alpha
					arg_9_1.var_.characterEffect1033 = var_12_6
				end

				arg_9_1.var_.alphaOldValue1033 = 0
			end

			local var_12_7 = 0.333333333333333

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_5) / var_12_7
				local var_12_9 = Mathf.Lerp(arg_9_1.var_.alphaOldValue1033, 1, var_12_8)

				if arg_9_1.var_.characterEffect1033 then
					arg_9_1.var_.characterEffect1033.alpha = var_12_9
				end
			end

			if arg_9_1.time_ >= var_12_5 + var_12_7 and arg_9_1.time_ < var_12_5 + var_12_7 + arg_12_0 and arg_9_1.var_.characterEffect1033 then
				arg_9_1.var_.characterEffect1033.alpha = 1
			end

			local var_12_10 = arg_9_1.actors_["1033"].transform
			local var_12_11 = 0

			if var_12_11 < arg_9_1.time_ and arg_9_1.time_ <= var_12_11 + arg_12_0 then
				arg_9_1.var_.moveOldPos1033 = var_12_10.localPosition
				var_12_10.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1033", 3)

				local var_12_12 = var_12_10.childCount

				for iter_12_2 = 0, var_12_12 - 1 do
					local var_12_13 = var_12_10:GetChild(iter_12_2)

					if var_12_13.name == "split_6" or not string.find(var_12_13.name, "split") then
						var_12_13.gameObject:SetActive(true)
					else
						var_12_13.gameObject:SetActive(false)
					end
				end
			end

			local var_12_14 = 0.001

			if var_12_11 <= arg_9_1.time_ and arg_9_1.time_ < var_12_11 + var_12_14 then
				local var_12_15 = (arg_9_1.time_ - var_12_11) / var_12_14
				local var_12_16 = Vector3.New(0, -420, 0)

				var_12_10.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1033, var_12_16, var_12_15)
			end

			if arg_9_1.time_ >= var_12_11 + var_12_14 and arg_9_1.time_ < var_12_11 + var_12_14 + arg_12_0 then
				var_12_10.localPosition = Vector3.New(0, -420, 0)
			end

			local var_12_17 = arg_9_1.actors_["1033"]
			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 and not isNil(var_12_17) and arg_9_1.var_.actorSpriteComps1033 == nil then
				arg_9_1.var_.actorSpriteComps1033 = var_12_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_19 = 0.2

			if var_12_18 <= arg_9_1.time_ and arg_9_1.time_ < var_12_18 + var_12_19 and not isNil(var_12_17) then
				local var_12_20 = (arg_9_1.time_ - var_12_18) / var_12_19

				if arg_9_1.var_.actorSpriteComps1033 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								local var_12_21 = Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor1.r, var_12_20)
								local var_12_22 = Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor1.g, var_12_20)
								local var_12_23 = Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor1.b, var_12_20)

								iter_12_4.color = Color.New(var_12_21, var_12_22, var_12_23)
							else
								local var_12_24 = Mathf.Lerp(iter_12_4.color.r, 1, var_12_20)

								iter_12_4.color = Color.New(var_12_24, var_12_24, var_12_24)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_18 + var_12_19 and arg_9_1.time_ < var_12_18 + var_12_19 + arg_12_0 and not isNil(var_12_17) and arg_9_1.var_.actorSpriteComps1033 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_12_6 then
						if arg_9_1.isInRecall_ then
							iter_12_6.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1033 = nil
			end

			local var_12_25 = 0
			local var_12_26 = 0.675

			if var_12_25 < arg_9_1.time_ and arg_9_1.time_ <= var_12_25 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_27 = arg_9_1:FormatText(StoryNameCfg[236].name)

				arg_9_1.leftNameTxt_.text = var_12_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_28 = arg_9_1:GetWordFromCfg(117022002)
				local var_12_29 = arg_9_1:FormatText(var_12_28.content)

				arg_9_1.text_.text = var_12_29

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_30 = 27
				local var_12_31 = utf8.len(var_12_29)
				local var_12_32 = var_12_30 <= 0 and var_12_26 or var_12_26 * (var_12_31 / var_12_30)

				if var_12_32 > 0 and var_12_26 < var_12_32 then
					arg_9_1.talkMaxDuration = var_12_32

					if var_12_32 + var_12_25 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_32 + var_12_25
					end
				end

				arg_9_1.text_.text = var_12_29
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117022", "117022002", "story_v_out_117022.awb") ~= 0 then
					local var_12_33 = manager.audio:GetVoiceLength("story_v_out_117022", "117022002", "story_v_out_117022.awb") / 1000

					if var_12_33 + var_12_25 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_33 + var_12_25
					end

					if var_12_28.prefab_name ~= "" and arg_9_1.actors_[var_12_28.prefab_name] ~= nil then
						local var_12_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_28.prefab_name].transform, "story_v_out_117022", "117022002", "story_v_out_117022.awb")

						arg_9_1:RecordAudio("117022002", var_12_34)
						arg_9_1:RecordAudio("117022002", var_12_34)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_117022", "117022002", "story_v_out_117022.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_117022", "117022002", "story_v_out_117022.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_35 = math.max(var_12_26, arg_9_1.talkMaxDuration)

			if var_12_25 <= arg_9_1.time_ and arg_9_1.time_ < var_12_25 + var_12_35 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_25) / var_12_35

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_25 + var_12_35 and arg_9_1.time_ < var_12_25 + var_12_35 + arg_12_0 then
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
	Play117022003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 117022003
		arg_13_1.duration_ = 5.6

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play117022004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = manager.ui.mainCamera.transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = var_16_0.localPosition
			end

			local var_16_2 = 0.6

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / 0.066
				local var_16_4, var_16_5 = math.modf(var_16_3)

				var_16_0.localPosition = Vector3.New(var_16_5 * 0.13, var_16_5 * 0.13, var_16_5 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = arg_13_1.var_.shakeOldPos
			end

			local var_16_6 = arg_13_1.actors_["1033"]
			local var_16_7 = 0

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				local var_16_8 = var_16_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_8 then
					arg_13_1.var_.alphaOldValue1033 = var_16_8.alpha
					arg_13_1.var_.characterEffect1033 = var_16_8
				end

				arg_13_1.var_.alphaOldValue1033 = 1
			end

			local var_16_9 = 0.333333333333333

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_9 then
				local var_16_10 = (arg_13_1.time_ - var_16_7) / var_16_9
				local var_16_11 = Mathf.Lerp(arg_13_1.var_.alphaOldValue1033, 0, var_16_10)

				if arg_13_1.var_.characterEffect1033 then
					arg_13_1.var_.characterEffect1033.alpha = var_16_11
				end
			end

			if arg_13_1.time_ >= var_16_7 + var_16_9 and arg_13_1.time_ < var_16_7 + var_16_9 + arg_16_0 and arg_13_1.var_.characterEffect1033 then
				arg_13_1.var_.characterEffect1033.alpha = 0
			end

			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			local var_16_13 = 0.6

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_14 = 0.6
			local var_16_15 = 1

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				local var_16_16 = "play"
				local var_16_17 = "effect"

				arg_13_1:AudioAction(var_16_16, var_16_17, "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks04", "")
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_18 = 0.6
			local var_16_19 = 1.15

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_20 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_20:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_21 = arg_13_1:GetWordFromCfg(117022003)
				local var_16_22 = arg_13_1:FormatText(var_16_21.content)

				arg_13_1.text_.text = var_16_22

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_23 = 46
				local var_16_24 = utf8.len(var_16_22)
				local var_16_25 = var_16_23 <= 0 and var_16_19 or var_16_19 * (var_16_24 / var_16_23)

				if var_16_25 > 0 and var_16_19 < var_16_25 then
					arg_13_1.talkMaxDuration = var_16_25
					var_16_18 = var_16_18 + 0.3

					if var_16_25 + var_16_18 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_25 + var_16_18
					end
				end

				arg_13_1.text_.text = var_16_22
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_26 = var_16_18 + 0.3
			local var_16_27 = math.max(var_16_19, arg_13_1.talkMaxDuration)

			if var_16_26 <= arg_13_1.time_ and arg_13_1.time_ < var_16_26 + var_16_27 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_26) / var_16_27

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_26 + var_16_27 and arg_13_1.time_ < var_16_26 + var_16_27 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play117022004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 117022004
		arg_19_1.duration_ = 2.6

		local var_19_0 = {
			zh = 2.233,
			ja = 2.6
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play117022005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1033"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				local var_22_2 = var_22_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_2 then
					arg_19_1.var_.alphaOldValue1033 = var_22_2.alpha
					arg_19_1.var_.characterEffect1033 = var_22_2
				end

				arg_19_1.var_.alphaOldValue1033 = 0
			end

			local var_22_3 = 0.333333333333333

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_3 then
				local var_22_4 = (arg_19_1.time_ - var_22_1) / var_22_3
				local var_22_5 = Mathf.Lerp(arg_19_1.var_.alphaOldValue1033, 1, var_22_4)

				if arg_19_1.var_.characterEffect1033 then
					arg_19_1.var_.characterEffect1033.alpha = var_22_5
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_3 and arg_19_1.time_ < var_22_1 + var_22_3 + arg_22_0 and arg_19_1.var_.characterEffect1033 then
				arg_19_1.var_.characterEffect1033.alpha = 1
			end

			local var_22_6 = arg_19_1.actors_["1033"].transform
			local var_22_7 = 0

			if var_22_7 < arg_19_1.time_ and arg_19_1.time_ <= var_22_7 + arg_22_0 then
				arg_19_1.var_.moveOldPos1033 = var_22_6.localPosition
				var_22_6.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1033", 3)

				local var_22_8 = var_22_6.childCount

				for iter_22_0 = 0, var_22_8 - 1 do
					local var_22_9 = var_22_6:GetChild(iter_22_0)

					if var_22_9.name == "split_6" or not string.find(var_22_9.name, "split") then
						var_22_9.gameObject:SetActive(true)
					else
						var_22_9.gameObject:SetActive(false)
					end
				end
			end

			local var_22_10 = 0.001

			if var_22_7 <= arg_19_1.time_ and arg_19_1.time_ < var_22_7 + var_22_10 then
				local var_22_11 = (arg_19_1.time_ - var_22_7) / var_22_10
				local var_22_12 = Vector3.New(0, -420, 0)

				var_22_6.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1033, var_22_12, var_22_11)
			end

			if arg_19_1.time_ >= var_22_7 + var_22_10 and arg_19_1.time_ < var_22_7 + var_22_10 + arg_22_0 then
				var_22_6.localPosition = Vector3.New(0, -420, 0)
			end

			local var_22_13 = arg_19_1.actors_["1033"]
			local var_22_14 = 0

			if var_22_14 < arg_19_1.time_ and arg_19_1.time_ <= var_22_14 + arg_22_0 and not isNil(var_22_13) and arg_19_1.var_.actorSpriteComps1033 == nil then
				arg_19_1.var_.actorSpriteComps1033 = var_22_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_15 = 0.2

			if var_22_14 <= arg_19_1.time_ and arg_19_1.time_ < var_22_14 + var_22_15 and not isNil(var_22_13) then
				local var_22_16 = (arg_19_1.time_ - var_22_14) / var_22_15

				if arg_19_1.var_.actorSpriteComps1033 then
					for iter_22_1, iter_22_2 in pairs(arg_19_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_22_2 then
							if arg_19_1.isInRecall_ then
								local var_22_17 = Mathf.Lerp(iter_22_2.color.r, arg_19_1.hightColor1.r, var_22_16)
								local var_22_18 = Mathf.Lerp(iter_22_2.color.g, arg_19_1.hightColor1.g, var_22_16)
								local var_22_19 = Mathf.Lerp(iter_22_2.color.b, arg_19_1.hightColor1.b, var_22_16)

								iter_22_2.color = Color.New(var_22_17, var_22_18, var_22_19)
							else
								local var_22_20 = Mathf.Lerp(iter_22_2.color.r, 1, var_22_16)

								iter_22_2.color = Color.New(var_22_20, var_22_20, var_22_20)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_14 + var_22_15 and arg_19_1.time_ < var_22_14 + var_22_15 + arg_22_0 and not isNil(var_22_13) and arg_19_1.var_.actorSpriteComps1033 then
				for iter_22_3, iter_22_4 in pairs(arg_19_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_22_4 then
						if arg_19_1.isInRecall_ then
							iter_22_4.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_22_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_19_1.var_.actorSpriteComps1033 = nil
			end

			local var_22_21 = 0
			local var_22_22 = 0.1

			if var_22_21 < arg_19_1.time_ and arg_19_1.time_ <= var_22_21 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_23 = arg_19_1:FormatText(StoryNameCfg[236].name)

				arg_19_1.leftNameTxt_.text = var_22_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_24 = arg_19_1:GetWordFromCfg(117022004)
				local var_22_25 = arg_19_1:FormatText(var_22_24.content)

				arg_19_1.text_.text = var_22_25

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_26 = 4
				local var_22_27 = utf8.len(var_22_25)
				local var_22_28 = var_22_26 <= 0 and var_22_22 or var_22_22 * (var_22_27 / var_22_26)

				if var_22_28 > 0 and var_22_22 < var_22_28 then
					arg_19_1.talkMaxDuration = var_22_28

					if var_22_28 + var_22_21 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_28 + var_22_21
					end
				end

				arg_19_1.text_.text = var_22_25
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117022", "117022004", "story_v_out_117022.awb") ~= 0 then
					local var_22_29 = manager.audio:GetVoiceLength("story_v_out_117022", "117022004", "story_v_out_117022.awb") / 1000

					if var_22_29 + var_22_21 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_29 + var_22_21
					end

					if var_22_24.prefab_name ~= "" and arg_19_1.actors_[var_22_24.prefab_name] ~= nil then
						local var_22_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_24.prefab_name].transform, "story_v_out_117022", "117022004", "story_v_out_117022.awb")

						arg_19_1:RecordAudio("117022004", var_22_30)
						arg_19_1:RecordAudio("117022004", var_22_30)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_117022", "117022004", "story_v_out_117022.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_117022", "117022004", "story_v_out_117022.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_31 = math.max(var_22_22, arg_19_1.talkMaxDuration)

			if var_22_21 <= arg_19_1.time_ and arg_19_1.time_ < var_22_21 + var_22_31 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_21) / var_22_31

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_21 + var_22_31 and arg_19_1.time_ < var_22_21 + var_22_31 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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

		arg_19_1:InitPlayNodeList()
	end,
	Play117022005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 117022005
		arg_23_1.duration_ = 9

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play117022006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = "TI0102"

			if arg_23_1.bgs_[var_26_0] == nil then
				local var_26_1 = Object.Instantiate(arg_23_1.paintGo_)

				var_26_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_26_0)
				var_26_1.name = var_26_0
				var_26_1.transform.parent = arg_23_1.stage_.transform
				var_26_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.bgs_[var_26_0] = var_26_1
			end

			local var_26_2 = 2

			if var_26_2 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				local var_26_3 = manager.ui.mainCamera.transform.localPosition
				local var_26_4 = Vector3.New(0, 0, 10) + Vector3.New(var_26_3.x, var_26_3.y, 0)
				local var_26_5 = arg_23_1.bgs_.TI0102

				var_26_5.transform.localPosition = var_26_4
				var_26_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_26_6 = var_26_5:GetComponent("SpriteRenderer")

				if var_26_6 and var_26_6.sprite then
					local var_26_7 = (var_26_5.transform.localPosition - var_26_3).z
					local var_26_8 = manager.ui.mainCameraCom_
					local var_26_9 = 2 * var_26_7 * Mathf.Tan(var_26_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_26_10 = var_26_9 * var_26_8.aspect
					local var_26_11 = var_26_6.sprite.bounds.size.x
					local var_26_12 = var_26_6.sprite.bounds.size.y
					local var_26_13 = var_26_10 / var_26_11
					local var_26_14 = var_26_9 / var_26_12
					local var_26_15 = var_26_14 < var_26_13 and var_26_13 or var_26_14

					var_26_5.transform.localScale = Vector3.New(var_26_15, var_26_15, 0)
				end

				for iter_26_0, iter_26_1 in pairs(arg_23_1.bgs_) do
					if iter_26_0 ~= "TI0102" then
						iter_26_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_26_16 = 0

			if var_26_16 < arg_23_1.time_ and arg_23_1.time_ <= var_26_16 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_17 = 2

			if var_26_16 <= arg_23_1.time_ and arg_23_1.time_ < var_26_16 + var_26_17 then
				local var_26_18 = (arg_23_1.time_ - var_26_16) / var_26_17
				local var_26_19 = Color.New(0, 0, 0)

				var_26_19.a = Mathf.Lerp(0, 1, var_26_18)
				arg_23_1.mask_.color = var_26_19
			end

			if arg_23_1.time_ >= var_26_16 + var_26_17 and arg_23_1.time_ < var_26_16 + var_26_17 + arg_26_0 then
				local var_26_20 = Color.New(0, 0, 0)

				var_26_20.a = 1
				arg_23_1.mask_.color = var_26_20
			end

			local var_26_21 = 2

			if var_26_21 < arg_23_1.time_ and arg_23_1.time_ <= var_26_21 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_22 = 2

			if var_26_21 <= arg_23_1.time_ and arg_23_1.time_ < var_26_21 + var_26_22 then
				local var_26_23 = (arg_23_1.time_ - var_26_21) / var_26_22
				local var_26_24 = Color.New(0, 0, 0)

				var_26_24.a = Mathf.Lerp(1, 0, var_26_23)
				arg_23_1.mask_.color = var_26_24
			end

			if arg_23_1.time_ >= var_26_21 + var_26_22 and arg_23_1.time_ < var_26_21 + var_26_22 + arg_26_0 then
				local var_26_25 = Color.New(0, 0, 0)
				local var_26_26 = 0

				arg_23_1.mask_.enabled = false
				var_26_25.a = var_26_26
				arg_23_1.mask_.color = var_26_25
			end

			local var_26_27 = arg_23_1.actors_["1033"]
			local var_26_28 = 1.98333333333333

			if var_26_28 < arg_23_1.time_ and arg_23_1.time_ <= var_26_28 + arg_26_0 then
				local var_26_29 = var_26_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_26_29 then
					arg_23_1.var_.alphaOldValue1033 = var_26_29.alpha
					arg_23_1.var_.characterEffect1033 = var_26_29
				end

				arg_23_1.var_.alphaOldValue1033 = 1
			end

			local var_26_30 = 0.0166666666666667

			if var_26_28 <= arg_23_1.time_ and arg_23_1.time_ < var_26_28 + var_26_30 then
				local var_26_31 = (arg_23_1.time_ - var_26_28) / var_26_30
				local var_26_32 = Mathf.Lerp(arg_23_1.var_.alphaOldValue1033, 0, var_26_31)

				if arg_23_1.var_.characterEffect1033 then
					arg_23_1.var_.characterEffect1033.alpha = var_26_32
				end
			end

			if arg_23_1.time_ >= var_26_28 + var_26_30 and arg_23_1.time_ < var_26_28 + var_26_30 + arg_26_0 and arg_23_1.var_.characterEffect1033 then
				arg_23_1.var_.characterEffect1033.alpha = 0
			end

			local var_26_33 = arg_23_1.bgs_.TI0102.transform
			local var_26_34 = 2

			if var_26_34 < arg_23_1.time_ and arg_23_1.time_ <= var_26_34 + arg_26_0 then
				arg_23_1.var_.moveOldPosTI0102 = var_26_33.localPosition
			end

			local var_26_35 = 0.001

			if var_26_34 <= arg_23_1.time_ and arg_23_1.time_ < var_26_34 + var_26_35 then
				local var_26_36 = (arg_23_1.time_ - var_26_34) / var_26_35
				local var_26_37 = Vector3.New(-0.5, -1, 1)

				var_26_33.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPosTI0102, var_26_37, var_26_36)
			end

			if arg_23_1.time_ >= var_26_34 + var_26_35 and arg_23_1.time_ < var_26_34 + var_26_35 + arg_26_0 then
				var_26_33.localPosition = Vector3.New(-0.5, -1, 1)
			end

			local var_26_38 = arg_23_1.bgs_.TI0102.transform
			local var_26_39 = 2.034

			if var_26_39 < arg_23_1.time_ and arg_23_1.time_ <= var_26_39 + arg_26_0 then
				arg_23_1.var_.moveOldPosTI0102 = var_26_38.localPosition
			end

			local var_26_40 = 2.73333333333333

			if var_26_39 <= arg_23_1.time_ and arg_23_1.time_ < var_26_39 + var_26_40 then
				local var_26_41 = (arg_23_1.time_ - var_26_39) / var_26_40
				local var_26_42 = Vector3.New(-0.5, -0.5, 1)

				var_26_38.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPosTI0102, var_26_42, var_26_41)
			end

			if arg_23_1.time_ >= var_26_39 + var_26_40 and arg_23_1.time_ < var_26_39 + var_26_40 + arg_26_0 then
				var_26_38.localPosition = Vector3.New(-0.5, -0.5, 1)
			end

			if arg_23_1.frameCnt_ <= 1 then
				arg_23_1.dialog_:SetActive(false)
			end

			local var_26_43 = 4
			local var_26_44 = 1.075

			if var_26_43 < arg_23_1.time_ and arg_23_1.time_ <= var_26_43 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				arg_23_1.dialog_:SetActive(true)

				arg_23_1.dialogCg_.alpha = 0

				local var_26_45 = LeanTween.value(arg_23_1.dialog_, 0, 1, 0.3)

				var_26_45:setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
					arg_23_1.dialogCg_.alpha = arg_27_0
				end))
				var_26_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_23_1.dialog_)
					var_26_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_23_1.duration_ = arg_23_1.duration_ + 0.3

				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_46 = arg_23_1:GetWordFromCfg(117022005)
				local var_26_47 = arg_23_1:FormatText(var_26_46.content)

				arg_23_1.text_.text = var_26_47

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_48 = 43
				local var_26_49 = utf8.len(var_26_47)
				local var_26_50 = var_26_48 <= 0 and var_26_44 or var_26_44 * (var_26_49 / var_26_48)

				if var_26_50 > 0 and var_26_44 < var_26_50 then
					arg_23_1.talkMaxDuration = var_26_50
					var_26_43 = var_26_43 + 0.3

					if var_26_50 + var_26_43 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_50 + var_26_43
					end
				end

				arg_23_1.text_.text = var_26_47
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_51 = var_26_43 + 0.3
			local var_26_52 = math.max(var_26_44, arg_23_1.talkMaxDuration)

			if var_26_51 <= arg_23_1.time_ and arg_23_1.time_ < var_26_51 + var_26_52 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_51) / var_26_52

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_51 + var_26_52 and arg_23_1.time_ < var_26_51 + var_26_52 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "TI0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "TI0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.73333333333333,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play117022006 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 117022006
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play117022007(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.8

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(117022006)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 32
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play117022007 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 117022007
		arg_33_1.duration_ = 7

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play117022008(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				local var_36_1 = manager.ui.mainCamera.transform.localPosition
				local var_36_2 = Vector3.New(0, 0, 10) + Vector3.New(var_36_1.x, var_36_1.y, 0)
				local var_36_3 = arg_33_1.bgs_.TI0102

				var_36_3.transform.localPosition = var_36_2
				var_36_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_4 = var_36_3:GetComponent("SpriteRenderer")

				if var_36_4 and var_36_4.sprite then
					local var_36_5 = (var_36_3.transform.localPosition - var_36_1).z
					local var_36_6 = manager.ui.mainCameraCom_
					local var_36_7 = 2 * var_36_5 * Mathf.Tan(var_36_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_36_8 = var_36_7 * var_36_6.aspect
					local var_36_9 = var_36_4.sprite.bounds.size.x
					local var_36_10 = var_36_4.sprite.bounds.size.y
					local var_36_11 = var_36_8 / var_36_9
					local var_36_12 = var_36_7 / var_36_10
					local var_36_13 = var_36_12 < var_36_11 and var_36_11 or var_36_12

					var_36_3.transform.localScale = Vector3.New(var_36_13, var_36_13, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "TI0102" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_15 = 2

			if var_36_14 <= arg_33_1.time_ and arg_33_1.time_ < var_36_14 + var_36_15 then
				local var_36_16 = (arg_33_1.time_ - var_36_14) / var_36_15
				local var_36_17 = Color.New(1, 1, 1)

				var_36_17.a = Mathf.Lerp(1, 0, var_36_16)
				arg_33_1.mask_.color = var_36_17
			end

			if arg_33_1.time_ >= var_36_14 + var_36_15 and arg_33_1.time_ < var_36_14 + var_36_15 + arg_36_0 then
				local var_36_18 = Color.New(1, 1, 1)
				local var_36_19 = 0

				arg_33_1.mask_.enabled = false
				var_36_18.a = var_36_19
				arg_33_1.mask_.color = var_36_18
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_20 = 2
			local var_36_21 = 1.075

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_22 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_22:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_23 = arg_33_1:GetWordFromCfg(117022007)
				local var_36_24 = arg_33_1:FormatText(var_36_23.content)

				arg_33_1.text_.text = var_36_24

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_25 = 43
				local var_36_26 = utf8.len(var_36_24)
				local var_36_27 = var_36_25 <= 0 and var_36_21 or var_36_21 * (var_36_26 / var_36_25)

				if var_36_27 > 0 and var_36_21 < var_36_27 then
					arg_33_1.talkMaxDuration = var_36_27
					var_36_20 = var_36_20 + 0.3

					if var_36_27 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_27 + var_36_20
					end
				end

				arg_33_1.text_.text = var_36_24
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_28 = var_36_20 + 0.3
			local var_36_29 = math.max(var_36_21, arg_33_1.talkMaxDuration)

			if var_36_28 <= arg_33_1.time_ and arg_33_1.time_ < var_36_28 + var_36_29 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_28) / var_36_29

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_28 + var_36_29 and arg_33_1.time_ < var_36_28 + var_36_29 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play117022008 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 117022008
		arg_39_1.duration_ = 2.9

		local var_39_0 = {
			zh = 2,
			ja = 2.9
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
			arg_39_1.auto_ = false
		end

		function arg_39_1.playNext_(arg_41_0)
			arg_39_1.onStoryFinished_()
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.175

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[236].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(117022008)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 7
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117022", "117022008", "story_v_out_117022.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_117022", "117022008", "story_v_out_117022.awb") / 1000

					if var_42_8 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_0
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_117022", "117022008", "story_v_out_117022.awb")

						arg_39_1:RecordAudio("117022008", var_42_9)
						arg_39_1:RecordAudio("117022008", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_117022", "117022008", "story_v_out_117022.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_117022", "117022008", "story_v_out_117022.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_10 and arg_39_1.time_ < var_42_0 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I08a",
		"TextureConfig/Background/TI0102"
	},
	voices = {
		"story_v_out_117022.awb"
	}
}
