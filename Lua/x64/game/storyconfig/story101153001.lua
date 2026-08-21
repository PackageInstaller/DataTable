return {
	Play115301001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115301001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115301002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F01"

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
				local var_4_5 = arg_1_1.bgs_.F01

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
					if iter_4_0 ~= "F01" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

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
			local var_4_23 = 0.266666666666667

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
			local var_4_29 = 0.6

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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

			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_35 = 3

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_36 = 2
			local var_4_37 = 1.3

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_38 = arg_1_1:GetWordFromCfg(115301001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 52
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_37 or var_4_37 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_37 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42

					if var_4_42 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_43 and arg_1_1.time_ < var_4_36 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play115301002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 115301002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play115301003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 1.325

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_2 = arg_7_1:GetWordFromCfg(115301002)
				local var_10_3 = arg_7_1:FormatText(var_10_2.content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 53
				local var_10_5 = utf8.len(var_10_3)
				local var_10_6 = var_10_4 <= 0 and var_10_1 or var_10_1 * (var_10_5 / var_10_4)

				if var_10_6 > 0 and var_10_1 < var_10_6 then
					arg_7_1.talkMaxDuration = var_10_6

					if var_10_6 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_6 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_7 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_7 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_7

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_7 and arg_7_1.time_ < var_10_0 + var_10_7 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play115301003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 115301003
		arg_11_1.duration_ = 5.6

		local var_11_0 = {
			ja = 2.1,
			ko = 3.933,
			zh = 5.6,
			en = 3.833
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play115301004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = "1038"

			if arg_11_1.actors_[var_14_0] == nil then
				local var_14_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_14_1) then
					local var_14_2 = Object.Instantiate(var_14_1, arg_11_1.canvasGo_.transform)

					var_14_2.transform:SetSiblingIndex(1)

					var_14_2.name = var_14_0
					var_14_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_11_1.actors_[var_14_0] = var_14_2

					local var_14_3 = var_14_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_11_1.isInRecall_ then
						for iter_14_0, iter_14_1 in ipairs(var_14_3) do
							iter_14_1.color = arg_11_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_14_4 = arg_11_1.actors_["1038"].transform
			local var_14_5 = 0

			if var_14_5 < arg_11_1.time_ and arg_11_1.time_ <= var_14_5 + arg_14_0 then
				arg_11_1.var_.moveOldPos1038 = var_14_4.localPosition
				var_14_4.localScale = Vector3.New(1, 1, 1)

				arg_11_1:CheckSpriteTmpPos("1038", 2)

				local var_14_6 = var_14_4.childCount

				for iter_14_2 = 0, var_14_6 - 1 do
					local var_14_7 = var_14_4:GetChild(iter_14_2)

					if var_14_7.name == "split_1" or not string.find(var_14_7.name, "split") then
						var_14_7.gameObject:SetActive(true)
					else
						var_14_7.gameObject:SetActive(false)
					end
				end
			end

			local var_14_8 = 0.001

			if var_14_5 <= arg_11_1.time_ and arg_11_1.time_ < var_14_5 + var_14_8 then
				local var_14_9 = (arg_11_1.time_ - var_14_5) / var_14_8
				local var_14_10 = Vector3.New(-390, -400, 0)

				var_14_4.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1038, var_14_10, var_14_9)
			end

			if arg_11_1.time_ >= var_14_5 + var_14_8 and arg_11_1.time_ < var_14_5 + var_14_8 + arg_14_0 then
				var_14_4.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_14_11 = arg_11_1.actors_["1038"]
			local var_14_12 = 0

			if var_14_12 < arg_11_1.time_ and arg_11_1.time_ <= var_14_12 + arg_14_0 then
				local var_14_13 = var_14_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_14_13 then
					arg_11_1.var_.alphaOldValue1038 = var_14_13.alpha
					arg_11_1.var_.characterEffect1038 = var_14_13
				end

				arg_11_1.var_.alphaOldValue1038 = 0
			end

			local var_14_14 = 0.333333333333333

			if var_14_12 <= arg_11_1.time_ and arg_11_1.time_ < var_14_12 + var_14_14 then
				local var_14_15 = (arg_11_1.time_ - var_14_12) / var_14_14
				local var_14_16 = Mathf.Lerp(arg_11_1.var_.alphaOldValue1038, 1, var_14_15)

				if arg_11_1.var_.characterEffect1038 then
					arg_11_1.var_.characterEffect1038.alpha = var_14_16
				end
			end

			if arg_11_1.time_ >= var_14_12 + var_14_14 and arg_11_1.time_ < var_14_12 + var_14_14 + arg_14_0 and arg_11_1.var_.characterEffect1038 then
				arg_11_1.var_.characterEffect1038.alpha = 1
			end

			local var_14_17 = 0
			local var_14_18 = 0.4

			if var_14_17 < arg_11_1.time_ and arg_11_1.time_ <= var_14_17 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_19 = arg_11_1:FormatText(StoryNameCfg[94].name)

				arg_11_1.leftNameTxt_.text = var_14_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_20 = arg_11_1:GetWordFromCfg(115301003)
				local var_14_21 = arg_11_1:FormatText(var_14_20.content)

				arg_11_1.text_.text = var_14_21

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_22 = 16
				local var_14_23 = utf8.len(var_14_21)
				local var_14_24 = var_14_22 <= 0 and var_14_18 or var_14_18 * (var_14_23 / var_14_22)

				if var_14_24 > 0 and var_14_18 < var_14_24 then
					arg_11_1.talkMaxDuration = var_14_24

					if var_14_24 + var_14_17 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_24 + var_14_17
					end
				end

				arg_11_1.text_.text = var_14_21
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301003", "story_v_out_115301.awb") ~= 0 then
					local var_14_25 = manager.audio:GetVoiceLength("story_v_out_115301", "115301003", "story_v_out_115301.awb") / 1000

					if var_14_25 + var_14_17 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_25 + var_14_17
					end

					if var_14_20.prefab_name ~= "" and arg_11_1.actors_[var_14_20.prefab_name] ~= nil then
						local var_14_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_20.prefab_name].transform, "story_v_out_115301", "115301003", "story_v_out_115301.awb")

						arg_11_1:RecordAudio("115301003", var_14_26)
						arg_11_1:RecordAudio("115301003", var_14_26)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_115301", "115301003", "story_v_out_115301.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_115301", "115301003", "story_v_out_115301.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_27 = math.max(var_14_18, arg_11_1.talkMaxDuration)

			if var_14_17 <= arg_11_1.time_ and arg_11_1.time_ < var_14_17 + var_14_27 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_17) / var_14_27

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_17 + var_14_27 and arg_11_1.time_ < var_14_17 + var_14_27 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play115301004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 115301004
		arg_15_1.duration_ = 3.43

		local var_15_0 = {
			ja = 3.433,
			ko = 1.966,
			zh = 2.233,
			en = 2.266
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play115301005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = "10030"

			if arg_15_1.actors_[var_18_0] == nil then
				local var_18_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10030")

				if not isNil(var_18_1) then
					local var_18_2 = Object.Instantiate(var_18_1, arg_15_1.canvasGo_.transform)

					var_18_2.transform:SetSiblingIndex(1)

					var_18_2.name = var_18_0
					var_18_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_15_1.actors_[var_18_0] = var_18_2

					local var_18_3 = var_18_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_15_1.isInRecall_ then
						for iter_18_0, iter_18_1 in ipairs(var_18_3) do
							iter_18_1.color = arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_18_4 = arg_15_1.actors_["10030"].transform
			local var_18_5 = 0

			if var_18_5 < arg_15_1.time_ and arg_15_1.time_ <= var_18_5 + arg_18_0 then
				arg_15_1.var_.moveOldPos10030 = var_18_4.localPosition
				var_18_4.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("10030", 4)

				local var_18_6 = var_18_4.childCount

				for iter_18_2 = 0, var_18_6 - 1 do
					local var_18_7 = var_18_4:GetChild(iter_18_2)

					if var_18_7.name == "split_1" or not string.find(var_18_7.name, "split") then
						var_18_7.gameObject:SetActive(true)
					else
						var_18_7.gameObject:SetActive(false)
					end
				end
			end

			local var_18_8 = 0.001

			if var_18_5 <= arg_15_1.time_ and arg_15_1.time_ < var_18_5 + var_18_8 then
				local var_18_9 = (arg_15_1.time_ - var_18_5) / var_18_8
				local var_18_10 = Vector3.New(390, -390, 150)

				var_18_4.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10030, var_18_10, var_18_9)
			end

			if arg_15_1.time_ >= var_18_5 + var_18_8 and arg_15_1.time_ < var_18_5 + var_18_8 + arg_18_0 then
				var_18_4.localPosition = Vector3.New(390, -390, 150)
			end

			local var_18_11 = arg_15_1.actors_["1038"]
			local var_18_12 = 0

			if var_18_12 < arg_15_1.time_ and arg_15_1.time_ <= var_18_12 + arg_18_0 and not isNil(var_18_11) and arg_15_1.var_.actorSpriteComps1038 == nil then
				arg_15_1.var_.actorSpriteComps1038 = var_18_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_13 = 0.2

			if var_18_12 <= arg_15_1.time_ and arg_15_1.time_ < var_18_12 + var_18_13 and not isNil(var_18_11) then
				local var_18_14 = (arg_15_1.time_ - var_18_12) / var_18_13

				if arg_15_1.var_.actorSpriteComps1038 then
					for iter_18_3, iter_18_4 in pairs(arg_15_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_18_4 then
							if arg_15_1.isInRecall_ then
								local var_18_15 = Mathf.Lerp(iter_18_4.color.r, arg_15_1.hightColor2.r, var_18_14)
								local var_18_16 = Mathf.Lerp(iter_18_4.color.g, arg_15_1.hightColor2.g, var_18_14)
								local var_18_17 = Mathf.Lerp(iter_18_4.color.b, arg_15_1.hightColor2.b, var_18_14)

								iter_18_4.color = Color.New(var_18_15, var_18_16, var_18_17)
							else
								local var_18_18 = Mathf.Lerp(iter_18_4.color.r, 0.5, var_18_14)

								iter_18_4.color = Color.New(var_18_18, var_18_18, var_18_18)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= var_18_12 + var_18_13 and arg_15_1.time_ < var_18_12 + var_18_13 + arg_18_0 and not isNil(var_18_11) and arg_15_1.var_.actorSpriteComps1038 then
				for iter_18_5, iter_18_6 in pairs(arg_15_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_18_6 then
						if arg_15_1.isInRecall_ then
							iter_18_6.color = arg_15_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_18_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_15_1.var_.actorSpriteComps1038 = nil
			end

			local var_18_19 = arg_15_1.actors_["10030"]
			local var_18_20 = 0

			if var_18_20 < arg_15_1.time_ and arg_15_1.time_ <= var_18_20 + arg_18_0 then
				local var_18_21 = var_18_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_18_21 then
					arg_15_1.var_.alphaOldValue10030 = var_18_21.alpha
					arg_15_1.var_.characterEffect10030 = var_18_21
				end

				arg_15_1.var_.alphaOldValue10030 = 0
			end

			local var_18_22 = 0.333333333333333

			if var_18_20 <= arg_15_1.time_ and arg_15_1.time_ < var_18_20 + var_18_22 then
				local var_18_23 = (arg_15_1.time_ - var_18_20) / var_18_22
				local var_18_24 = Mathf.Lerp(arg_15_1.var_.alphaOldValue10030, 1, var_18_23)

				if arg_15_1.var_.characterEffect10030 then
					arg_15_1.var_.characterEffect10030.alpha = var_18_24
				end
			end

			if arg_15_1.time_ >= var_18_20 + var_18_22 and arg_15_1.time_ < var_18_20 + var_18_22 + arg_18_0 and arg_15_1.var_.characterEffect10030 then
				arg_15_1.var_.characterEffect10030.alpha = 1
			end

			local var_18_25 = 0
			local var_18_26 = 0.15

			if var_18_25 < arg_15_1.time_ and arg_15_1.time_ <= var_18_25 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_27 = arg_15_1:FormatText(StoryNameCfg[309].name)

				arg_15_1.leftNameTxt_.text = var_18_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_28 = arg_15_1:GetWordFromCfg(115301004)
				local var_18_29 = arg_15_1:FormatText(var_18_28.content)

				arg_15_1.text_.text = var_18_29

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_30 = 6
				local var_18_31 = utf8.len(var_18_29)
				local var_18_32 = var_18_30 <= 0 and var_18_26 or var_18_26 * (var_18_31 / var_18_30)

				if var_18_32 > 0 and var_18_26 < var_18_32 then
					arg_15_1.talkMaxDuration = var_18_32

					if var_18_32 + var_18_25 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_32 + var_18_25
					end
				end

				arg_15_1.text_.text = var_18_29
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301004", "story_v_out_115301.awb") ~= 0 then
					local var_18_33 = manager.audio:GetVoiceLength("story_v_out_115301", "115301004", "story_v_out_115301.awb") / 1000

					if var_18_33 + var_18_25 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_33 + var_18_25
					end

					if var_18_28.prefab_name ~= "" and arg_15_1.actors_[var_18_28.prefab_name] ~= nil then
						local var_18_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_28.prefab_name].transform, "story_v_out_115301", "115301004", "story_v_out_115301.awb")

						arg_15_1:RecordAudio("115301004", var_18_34)
						arg_15_1:RecordAudio("115301004", var_18_34)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_115301", "115301004", "story_v_out_115301.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_115301", "115301004", "story_v_out_115301.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_35 = math.max(var_18_26, arg_15_1.talkMaxDuration)

			if var_18_25 <= arg_15_1.time_ and arg_15_1.time_ < var_18_25 + var_18_35 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_25) / var_18_35

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_25 + var_18_35 and arg_15_1.time_ < var_18_25 + var_18_35 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play115301005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 115301005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play115301006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["10030"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				local var_22_2 = var_22_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_2 then
					arg_19_1.var_.alphaOldValue10030 = var_22_2.alpha
					arg_19_1.var_.characterEffect10030 = var_22_2
				end

				arg_19_1.var_.alphaOldValue10030 = 1
			end

			local var_22_3 = 0.333333333333333

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_3 then
				local var_22_4 = (arg_19_1.time_ - var_22_1) / var_22_3
				local var_22_5 = Mathf.Lerp(arg_19_1.var_.alphaOldValue10030, 0, var_22_4)

				if arg_19_1.var_.characterEffect10030 then
					arg_19_1.var_.characterEffect10030.alpha = var_22_5
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_3 and arg_19_1.time_ < var_22_1 + var_22_3 + arg_22_0 and arg_19_1.var_.characterEffect10030 then
				arg_19_1.var_.characterEffect10030.alpha = 0
			end

			local var_22_6 = arg_19_1.actors_["1038"]
			local var_22_7 = 0

			if var_22_7 < arg_19_1.time_ and arg_19_1.time_ <= var_22_7 + arg_22_0 then
				local var_22_8 = var_22_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_8 then
					arg_19_1.var_.alphaOldValue1038 = var_22_8.alpha
					arg_19_1.var_.characterEffect1038 = var_22_8
				end

				arg_19_1.var_.alphaOldValue1038 = 1
			end

			local var_22_9 = 0.333333333333333

			if var_22_7 <= arg_19_1.time_ and arg_19_1.time_ < var_22_7 + var_22_9 then
				local var_22_10 = (arg_19_1.time_ - var_22_7) / var_22_9
				local var_22_11 = Mathf.Lerp(arg_19_1.var_.alphaOldValue1038, 0, var_22_10)

				if arg_19_1.var_.characterEffect1038 then
					arg_19_1.var_.characterEffect1038.alpha = var_22_11
				end
			end

			if arg_19_1.time_ >= var_22_7 + var_22_9 and arg_19_1.time_ < var_22_7 + var_22_9 + arg_22_0 and arg_19_1.var_.characterEffect1038 then
				arg_19_1.var_.characterEffect1038.alpha = 0
			end

			local var_22_12 = 0
			local var_22_13 = 0.5

			if var_22_12 < arg_19_1.time_ and arg_19_1.time_ <= var_22_12 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_14 = arg_19_1:GetWordFromCfg(115301005)
				local var_22_15 = arg_19_1:FormatText(var_22_14.content)

				arg_19_1.text_.text = var_22_15

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_16 = 20
				local var_22_17 = utf8.len(var_22_15)
				local var_22_18 = var_22_16 <= 0 and var_22_13 or var_22_13 * (var_22_17 / var_22_16)

				if var_22_18 > 0 and var_22_13 < var_22_18 then
					arg_19_1.talkMaxDuration = var_22_18

					if var_22_18 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_18 + var_22_12
					end
				end

				arg_19_1.text_.text = var_22_15
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_19 = math.max(var_22_13, arg_19_1.talkMaxDuration)

			if var_22_12 <= arg_19_1.time_ and arg_19_1.time_ < var_22_12 + var_22_19 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_12) / var_22_19

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_12 + var_22_19 and arg_19_1.time_ < var_22_12 + var_22_19 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play115301006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 115301006
		arg_23_1.duration_ = 5.77

		local var_23_0 = {
			ja = 3.233,
			ko = 4.566,
			zh = 4.366,
			en = 5.766
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play115301007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["10030"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos10030 = var_26_0.localPosition
				var_26_0.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("10030", 3)

				local var_26_2 = var_26_0.childCount

				for iter_26_0 = 0, var_26_2 - 1 do
					local var_26_3 = var_26_0:GetChild(iter_26_0)

					if var_26_3.name == "split_2" or not string.find(var_26_3.name, "split") then
						var_26_3.gameObject:SetActive(true)
					else
						var_26_3.gameObject:SetActive(false)
					end
				end
			end

			local var_26_4 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_4 then
				local var_26_5 = (arg_23_1.time_ - var_26_1) / var_26_4
				local var_26_6 = Vector3.New(0, -390, 150)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10030, var_26_6, var_26_5)
			end

			if arg_23_1.time_ >= var_26_1 + var_26_4 and arg_23_1.time_ < var_26_1 + var_26_4 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_26_7 = arg_23_1.actors_["10030"]
			local var_26_8 = 0

			if var_26_8 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				local var_26_9 = var_26_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_26_9 then
					arg_23_1.var_.alphaOldValue10030 = var_26_9.alpha
					arg_23_1.var_.characterEffect10030 = var_26_9
				end

				arg_23_1.var_.alphaOldValue10030 = 0
			end

			local var_26_10 = 0.333333333333333

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_10 then
				local var_26_11 = (arg_23_1.time_ - var_26_8) / var_26_10
				local var_26_12 = Mathf.Lerp(arg_23_1.var_.alphaOldValue10030, 1, var_26_11)

				if arg_23_1.var_.characterEffect10030 then
					arg_23_1.var_.characterEffect10030.alpha = var_26_12
				end
			end

			if arg_23_1.time_ >= var_26_8 + var_26_10 and arg_23_1.time_ < var_26_8 + var_26_10 + arg_26_0 and arg_23_1.var_.characterEffect10030 then
				arg_23_1.var_.characterEffect10030.alpha = 1
			end

			local var_26_13 = 0
			local var_26_14 = 0.25

			if var_26_13 < arg_23_1.time_ and arg_23_1.time_ <= var_26_13 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_15 = arg_23_1:FormatText(StoryNameCfg[309].name)

				arg_23_1.leftNameTxt_.text = var_26_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_16 = arg_23_1:GetWordFromCfg(115301006)
				local var_26_17 = arg_23_1:FormatText(var_26_16.content)

				arg_23_1.text_.text = var_26_17

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_18 = 10
				local var_26_19 = utf8.len(var_26_17)
				local var_26_20 = var_26_18 <= 0 and var_26_14 or var_26_14 * (var_26_19 / var_26_18)

				if var_26_20 > 0 and var_26_14 < var_26_20 then
					arg_23_1.talkMaxDuration = var_26_20

					if var_26_20 + var_26_13 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_20 + var_26_13
					end
				end

				arg_23_1.text_.text = var_26_17
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301006", "story_v_out_115301.awb") ~= 0 then
					local var_26_21 = manager.audio:GetVoiceLength("story_v_out_115301", "115301006", "story_v_out_115301.awb") / 1000

					if var_26_21 + var_26_13 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_21 + var_26_13
					end

					if var_26_16.prefab_name ~= "" and arg_23_1.actors_[var_26_16.prefab_name] ~= nil then
						local var_26_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_16.prefab_name].transform, "story_v_out_115301", "115301006", "story_v_out_115301.awb")

						arg_23_1:RecordAudio("115301006", var_26_22)
						arg_23_1:RecordAudio("115301006", var_26_22)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_115301", "115301006", "story_v_out_115301.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_115301", "115301006", "story_v_out_115301.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_23 = math.max(var_26_14, arg_23_1.talkMaxDuration)

			if var_26_13 <= arg_23_1.time_ and arg_23_1.time_ < var_26_13 + var_26_23 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_13) / var_26_23

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_13 + var_26_23 and arg_23_1.time_ < var_26_13 + var_26_23 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play115301007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 115301007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play115301008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["10030"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				local var_30_2 = var_30_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_30_2 then
					arg_27_1.var_.alphaOldValue10030 = var_30_2.alpha
					arg_27_1.var_.characterEffect10030 = var_30_2
				end

				arg_27_1.var_.alphaOldValue10030 = 1
			end

			local var_30_3 = 0.333333333333333

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_3 then
				local var_30_4 = (arg_27_1.time_ - var_30_1) / var_30_3
				local var_30_5 = Mathf.Lerp(arg_27_1.var_.alphaOldValue10030, 0, var_30_4)

				if arg_27_1.var_.characterEffect10030 then
					arg_27_1.var_.characterEffect10030.alpha = var_30_5
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_3 and arg_27_1.time_ < var_30_1 + var_30_3 + arg_30_0 and arg_27_1.var_.characterEffect10030 then
				arg_27_1.var_.characterEffect10030.alpha = 0
			end

			local var_30_6 = 0
			local var_30_7 = 0.975

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_8 = arg_27_1:GetWordFromCfg(115301007)
				local var_30_9 = arg_27_1:FormatText(var_30_8.content)

				arg_27_1.text_.text = var_30_9

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 39
				local var_30_11 = utf8.len(var_30_9)
				local var_30_12 = var_30_10 <= 0 and var_30_7 or var_30_7 * (var_30_11 / var_30_10)

				if var_30_12 > 0 and var_30_7 < var_30_12 then
					arg_27_1.talkMaxDuration = var_30_12

					if var_30_12 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_12 + var_30_6
					end
				end

				arg_27_1.text_.text = var_30_9
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_13 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_13 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_13

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_13 and arg_27_1.time_ < var_30_6 + var_30_13 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play115301008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 115301008
		arg_31_1.duration_ = 5.93

		local var_31_0 = {
			ja = 5.933,
			ko = 3.166,
			zh = 4.3,
			en = 5.6
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play115301009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10030"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos10030 = var_34_0.localPosition
				var_34_0.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("10030", 3)

				local var_34_2 = var_34_0.childCount

				for iter_34_0 = 0, var_34_2 - 1 do
					local var_34_3 = var_34_0:GetChild(iter_34_0)

					if var_34_3.name == "split_1" or not string.find(var_34_3.name, "split") then
						var_34_3.gameObject:SetActive(true)
					else
						var_34_3.gameObject:SetActive(false)
					end
				end
			end

			local var_34_4 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_4 then
				local var_34_5 = (arg_31_1.time_ - var_34_1) / var_34_4
				local var_34_6 = Vector3.New(0, -390, 150)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10030, var_34_6, var_34_5)
			end

			if arg_31_1.time_ >= var_34_1 + var_34_4 and arg_31_1.time_ < var_34_1 + var_34_4 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_34_7 = arg_31_1.actors_["10030"]
			local var_34_8 = 0

			if var_34_8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				local var_34_9 = var_34_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_34_9 then
					arg_31_1.var_.alphaOldValue10030 = var_34_9.alpha
					arg_31_1.var_.characterEffect10030 = var_34_9
				end

				arg_31_1.var_.alphaOldValue10030 = 0
			end

			local var_34_10 = 0.333333333333333

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_10 then
				local var_34_11 = (arg_31_1.time_ - var_34_8) / var_34_10
				local var_34_12 = Mathf.Lerp(arg_31_1.var_.alphaOldValue10030, 1, var_34_11)

				if arg_31_1.var_.characterEffect10030 then
					arg_31_1.var_.characterEffect10030.alpha = var_34_12
				end
			end

			if arg_31_1.time_ >= var_34_8 + var_34_10 and arg_31_1.time_ < var_34_8 + var_34_10 + arg_34_0 and arg_31_1.var_.characterEffect10030 then
				arg_31_1.var_.characterEffect10030.alpha = 1
			end

			local var_34_13 = 0
			local var_34_14 = 0.35

			if var_34_13 < arg_31_1.time_ and arg_31_1.time_ <= var_34_13 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_15 = arg_31_1:FormatText(StoryNameCfg[309].name)

				arg_31_1.leftNameTxt_.text = var_34_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_16 = arg_31_1:GetWordFromCfg(115301008)
				local var_34_17 = arg_31_1:FormatText(var_34_16.content)

				arg_31_1.text_.text = var_34_17

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_18 = 14
				local var_34_19 = utf8.len(var_34_17)
				local var_34_20 = var_34_18 <= 0 and var_34_14 or var_34_14 * (var_34_19 / var_34_18)

				if var_34_20 > 0 and var_34_14 < var_34_20 then
					arg_31_1.talkMaxDuration = var_34_20

					if var_34_20 + var_34_13 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_20 + var_34_13
					end
				end

				arg_31_1.text_.text = var_34_17
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301008", "story_v_out_115301.awb") ~= 0 then
					local var_34_21 = manager.audio:GetVoiceLength("story_v_out_115301", "115301008", "story_v_out_115301.awb") / 1000

					if var_34_21 + var_34_13 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_21 + var_34_13
					end

					if var_34_16.prefab_name ~= "" and arg_31_1.actors_[var_34_16.prefab_name] ~= nil then
						local var_34_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_16.prefab_name].transform, "story_v_out_115301", "115301008", "story_v_out_115301.awb")

						arg_31_1:RecordAudio("115301008", var_34_22)
						arg_31_1:RecordAudio("115301008", var_34_22)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_115301", "115301008", "story_v_out_115301.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_115301", "115301008", "story_v_out_115301.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_23 = math.max(var_34_14, arg_31_1.talkMaxDuration)

			if var_34_13 <= arg_31_1.time_ and arg_31_1.time_ < var_34_13 + var_34_23 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_13) / var_34_23

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_13 + var_34_23 and arg_31_1.time_ < var_34_13 + var_34_23 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play115301009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 115301009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play115301010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["10030"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				local var_38_2 = var_38_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_38_2 then
					arg_35_1.var_.alphaOldValue10030 = var_38_2.alpha
					arg_35_1.var_.characterEffect10030 = var_38_2
				end

				arg_35_1.var_.alphaOldValue10030 = 1
			end

			local var_38_3 = 0.333333333333333

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_3 then
				local var_38_4 = (arg_35_1.time_ - var_38_1) / var_38_3
				local var_38_5 = Mathf.Lerp(arg_35_1.var_.alphaOldValue10030, 0, var_38_4)

				if arg_35_1.var_.characterEffect10030 then
					arg_35_1.var_.characterEffect10030.alpha = var_38_5
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_3 and arg_35_1.time_ < var_38_1 + var_38_3 + arg_38_0 and arg_35_1.var_.characterEffect10030 then
				arg_35_1.var_.characterEffect10030.alpha = 0
			end

			local var_38_6 = 0
			local var_38_7 = 1.375

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_8 = arg_35_1:GetWordFromCfg(115301009)
				local var_38_9 = arg_35_1:FormatText(var_38_8.content)

				arg_35_1.text_.text = var_38_9

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_10 = 55
				local var_38_11 = utf8.len(var_38_9)
				local var_38_12 = var_38_10 <= 0 and var_38_7 or var_38_7 * (var_38_11 / var_38_10)

				if var_38_12 > 0 and var_38_7 < var_38_12 then
					arg_35_1.talkMaxDuration = var_38_12

					if var_38_12 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_12 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_9
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_13 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_13 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_13

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_13 and arg_35_1.time_ < var_38_6 + var_38_13 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play115301010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 115301010
		arg_39_1.duration_ = 5.57

		local var_39_0 = {
			ja = 5.566,
			ko = 2.433,
			zh = 3.166,
			en = 1.766
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
				arg_39_0:Play115301011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1038"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1038 = var_42_0.localPosition
				var_42_0.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1038", 3)

				local var_42_2 = var_42_0.childCount

				for iter_42_0 = 0, var_42_2 - 1 do
					local var_42_3 = var_42_0:GetChild(iter_42_0)

					if var_42_3.name == "split_1" or not string.find(var_42_3.name, "split") then
						var_42_3.gameObject:SetActive(true)
					else
						var_42_3.gameObject:SetActive(false)
					end
				end
			end

			local var_42_4 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_4 then
				local var_42_5 = (arg_39_1.time_ - var_42_1) / var_42_4
				local var_42_6 = Vector3.New(0, -400, 0)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1038, var_42_6, var_42_5)
			end

			if arg_39_1.time_ >= var_42_1 + var_42_4 and arg_39_1.time_ < var_42_1 + var_42_4 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_42_7 = arg_39_1.actors_["1038"]
			local var_42_8 = 0

			if var_42_8 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				local var_42_9 = var_42_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_42_9 then
					arg_39_1.var_.alphaOldValue1038 = var_42_9.alpha
					arg_39_1.var_.characterEffect1038 = var_42_9
				end

				arg_39_1.var_.alphaOldValue1038 = 0
			end

			local var_42_10 = 0.333333333333333

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_10 then
				local var_42_11 = (arg_39_1.time_ - var_42_8) / var_42_10
				local var_42_12 = Mathf.Lerp(arg_39_1.var_.alphaOldValue1038, 1, var_42_11)

				if arg_39_1.var_.characterEffect1038 then
					arg_39_1.var_.characterEffect1038.alpha = var_42_12
				end
			end

			if arg_39_1.time_ >= var_42_8 + var_42_10 and arg_39_1.time_ < var_42_8 + var_42_10 + arg_42_0 and arg_39_1.var_.characterEffect1038 then
				arg_39_1.var_.characterEffect1038.alpha = 1
			end

			local var_42_13 = arg_39_1.actors_["1038"]
			local var_42_14 = 0

			if var_42_14 < arg_39_1.time_ and arg_39_1.time_ <= var_42_14 + arg_42_0 and not isNil(var_42_13) and arg_39_1.var_.actorSpriteComps1038 == nil then
				arg_39_1.var_.actorSpriteComps1038 = var_42_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_15 = 0.2

			if var_42_14 <= arg_39_1.time_ and arg_39_1.time_ < var_42_14 + var_42_15 and not isNil(var_42_13) then
				local var_42_16 = (arg_39_1.time_ - var_42_14) / var_42_15

				if arg_39_1.var_.actorSpriteComps1038 then
					for iter_42_1, iter_42_2 in pairs(arg_39_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_42_2 then
							if arg_39_1.isInRecall_ then
								local var_42_17 = Mathf.Lerp(iter_42_2.color.r, arg_39_1.hightColor1.r, var_42_16)
								local var_42_18 = Mathf.Lerp(iter_42_2.color.g, arg_39_1.hightColor1.g, var_42_16)
								local var_42_19 = Mathf.Lerp(iter_42_2.color.b, arg_39_1.hightColor1.b, var_42_16)

								iter_42_2.color = Color.New(var_42_17, var_42_18, var_42_19)
							else
								local var_42_20 = Mathf.Lerp(iter_42_2.color.r, 1, var_42_16)

								iter_42_2.color = Color.New(var_42_20, var_42_20, var_42_20)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_14 + var_42_15 and arg_39_1.time_ < var_42_14 + var_42_15 + arg_42_0 and not isNil(var_42_13) and arg_39_1.var_.actorSpriteComps1038 then
				for iter_42_3, iter_42_4 in pairs(arg_39_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_42_4 then
						if arg_39_1.isInRecall_ then
							iter_42_4.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_42_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps1038 = nil
			end

			local var_42_21 = 0
			local var_42_22 = 0.2

			if var_42_21 < arg_39_1.time_ and arg_39_1.time_ <= var_42_21 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_23 = arg_39_1:FormatText(StoryNameCfg[94].name)

				arg_39_1.leftNameTxt_.text = var_42_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_24 = arg_39_1:GetWordFromCfg(115301010)
				local var_42_25 = arg_39_1:FormatText(var_42_24.content)

				arg_39_1.text_.text = var_42_25

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_26 = 8
				local var_42_27 = utf8.len(var_42_25)
				local var_42_28 = var_42_26 <= 0 and var_42_22 or var_42_22 * (var_42_27 / var_42_26)

				if var_42_28 > 0 and var_42_22 < var_42_28 then
					arg_39_1.talkMaxDuration = var_42_28

					if var_42_28 + var_42_21 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_28 + var_42_21
					end
				end

				arg_39_1.text_.text = var_42_25
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301010", "story_v_out_115301.awb") ~= 0 then
					local var_42_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301010", "story_v_out_115301.awb") / 1000

					if var_42_29 + var_42_21 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_29 + var_42_21
					end

					if var_42_24.prefab_name ~= "" and arg_39_1.actors_[var_42_24.prefab_name] ~= nil then
						local var_42_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_24.prefab_name].transform, "story_v_out_115301", "115301010", "story_v_out_115301.awb")

						arg_39_1:RecordAudio("115301010", var_42_30)
						arg_39_1:RecordAudio("115301010", var_42_30)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_115301", "115301010", "story_v_out_115301.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_115301", "115301010", "story_v_out_115301.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_31 = math.max(var_42_22, arg_39_1.talkMaxDuration)

			if var_42_21 <= arg_39_1.time_ and arg_39_1.time_ < var_42_21 + var_42_31 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_21) / var_42_31

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_21 + var_42_31 and arg_39_1.time_ < var_42_21 + var_42_31 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play115301011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 115301011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play115301012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1038"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				local var_46_2 = var_46_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_46_2 then
					arg_43_1.var_.alphaOldValue1038 = var_46_2.alpha
					arg_43_1.var_.characterEffect1038 = var_46_2
				end

				arg_43_1.var_.alphaOldValue1038 = 1
			end

			local var_46_3 = 0.333333333333333

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_3 then
				local var_46_4 = (arg_43_1.time_ - var_46_1) / var_46_3
				local var_46_5 = Mathf.Lerp(arg_43_1.var_.alphaOldValue1038, 0, var_46_4)

				if arg_43_1.var_.characterEffect1038 then
					arg_43_1.var_.characterEffect1038.alpha = var_46_5
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_3 and arg_43_1.time_ < var_46_1 + var_46_3 + arg_46_0 and arg_43_1.var_.characterEffect1038 then
				arg_43_1.var_.characterEffect1038.alpha = 0
			end

			local var_46_6 = 0
			local var_46_7 = 1.35

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_8 = arg_43_1:GetWordFromCfg(115301011)
				local var_46_9 = arg_43_1:FormatText(var_46_8.content)

				arg_43_1.text_.text = var_46_9

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_10 = 53
				local var_46_11 = utf8.len(var_46_9)
				local var_46_12 = var_46_10 <= 0 and var_46_7 or var_46_7 * (var_46_11 / var_46_10)

				if var_46_12 > 0 and var_46_7 < var_46_12 then
					arg_43_1.talkMaxDuration = var_46_12

					if var_46_12 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_6
					end
				end

				arg_43_1.text_.text = var_46_9
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_13 = math.max(var_46_7, arg_43_1.talkMaxDuration)

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_13 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_6) / var_46_13

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_6 + var_46_13 and arg_43_1.time_ < var_46_6 + var_46_13 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play115301012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 115301012
		arg_47_1.duration_ = 4.47

		local var_47_0 = {
			ja = 4.4,
			ko = 3.1,
			zh = 4.466,
			en = 2.7
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play115301013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10030"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos10030 = var_50_0.localPosition
				var_50_0.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10030", 4)

				local var_50_2 = var_50_0.childCount

				for iter_50_0 = 0, var_50_2 - 1 do
					local var_50_3 = var_50_0:GetChild(iter_50_0)

					if var_50_3.name == "split_3" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_4 then
				local var_50_5 = (arg_47_1.time_ - var_50_1) / var_50_4
				local var_50_6 = Vector3.New(390, -390, 150)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10030, var_50_6, var_50_5)
			end

			if arg_47_1.time_ >= var_50_1 + var_50_4 and arg_47_1.time_ < var_50_1 + var_50_4 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_50_7 = arg_47_1.actors_["10030"]
			local var_50_8 = 0

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				local var_50_9 = var_50_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_50_9 then
					arg_47_1.var_.alphaOldValue10030 = var_50_9.alpha
					arg_47_1.var_.characterEffect10030 = var_50_9
				end

				arg_47_1.var_.alphaOldValue10030 = 0
			end

			local var_50_10 = 0.333333333333333

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_10 then
				local var_50_11 = (arg_47_1.time_ - var_50_8) / var_50_10
				local var_50_12 = Mathf.Lerp(arg_47_1.var_.alphaOldValue10030, 1, var_50_11)

				if arg_47_1.var_.characterEffect10030 then
					arg_47_1.var_.characterEffect10030.alpha = var_50_12
				end
			end

			if arg_47_1.time_ >= var_50_8 + var_50_10 and arg_47_1.time_ < var_50_8 + var_50_10 + arg_50_0 and arg_47_1.var_.characterEffect10030 then
				arg_47_1.var_.characterEffect10030.alpha = 1
			end

			local var_50_13 = arg_47_1.actors_["10030"]
			local var_50_14 = 0

			if var_50_14 < arg_47_1.time_ and arg_47_1.time_ <= var_50_14 + arg_50_0 and not isNil(var_50_13) and arg_47_1.var_.actorSpriteComps10030 == nil then
				arg_47_1.var_.actorSpriteComps10030 = var_50_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_15 = 0.2

			if var_50_14 <= arg_47_1.time_ and arg_47_1.time_ < var_50_14 + var_50_15 and not isNil(var_50_13) then
				local var_50_16 = (arg_47_1.time_ - var_50_14) / var_50_15

				if arg_47_1.var_.actorSpriteComps10030 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								local var_50_17 = Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor1.r, var_50_16)
								local var_50_18 = Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor1.g, var_50_16)
								local var_50_19 = Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor1.b, var_50_16)

								iter_50_2.color = Color.New(var_50_17, var_50_18, var_50_19)
							else
								local var_50_20 = Mathf.Lerp(iter_50_2.color.r, 1, var_50_16)

								iter_50_2.color = Color.New(var_50_20, var_50_20, var_50_20)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_14 + var_50_15 and arg_47_1.time_ < var_50_14 + var_50_15 + arg_50_0 and not isNil(var_50_13) and arg_47_1.var_.actorSpriteComps10030 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_50_4 then
						if arg_47_1.isInRecall_ then
							iter_50_4.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_50_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps10030 = nil
			end

			local var_50_21 = 0
			local var_50_22 = 1

			if var_50_21 < arg_47_1.time_ and arg_47_1.time_ <= var_50_21 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_23 = arg_47_1:FormatText(StoryNameCfg[309].name)

				arg_47_1.leftNameTxt_.text = var_50_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_24 = arg_47_1:GetWordFromCfg(115301012)
				local var_50_25 = arg_47_1:FormatText(var_50_24.content)

				arg_47_1.text_.text = var_50_25

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_26 = 11
				local var_50_27 = utf8.len(var_50_25)
				local var_50_28 = var_50_26 <= 0 and var_50_22 or var_50_22 * (var_50_27 / var_50_26)

				if var_50_28 > 0 and var_50_22 < var_50_28 then
					arg_47_1.talkMaxDuration = var_50_28

					if var_50_28 + var_50_21 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_28 + var_50_21
					end
				end

				arg_47_1.text_.text = var_50_25
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301012", "story_v_out_115301.awb") ~= 0 then
					local var_50_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301012", "story_v_out_115301.awb") / 1000

					if var_50_29 + var_50_21 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_29 + var_50_21
					end

					if var_50_24.prefab_name ~= "" and arg_47_1.actors_[var_50_24.prefab_name] ~= nil then
						local var_50_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_24.prefab_name].transform, "story_v_out_115301", "115301012", "story_v_out_115301.awb")

						arg_47_1:RecordAudio("115301012", var_50_30)
						arg_47_1:RecordAudio("115301012", var_50_30)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_115301", "115301012", "story_v_out_115301.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_115301", "115301012", "story_v_out_115301.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_31 = math.max(var_50_22, arg_47_1.talkMaxDuration)

			if var_50_21 <= arg_47_1.time_ and arg_47_1.time_ < var_50_21 + var_50_31 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_21) / var_50_31

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_21 + var_50_31 and arg_47_1.time_ < var_50_21 + var_50_31 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play115301013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 115301013
		arg_51_1.duration_ = 3.27

		local var_51_0 = {
			ja = 1.733,
			ko = 1.466,
			zh = 2.533,
			en = 3.266
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play115301014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1038"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1038 = var_54_0.localPosition
				var_54_0.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1038", 2)

				local var_54_2 = var_54_0.childCount

				for iter_54_0 = 0, var_54_2 - 1 do
					local var_54_3 = var_54_0:GetChild(iter_54_0)

					if var_54_3.name == "split_1" or not string.find(var_54_3.name, "split") then
						var_54_3.gameObject:SetActive(true)
					else
						var_54_3.gameObject:SetActive(false)
					end
				end
			end

			local var_54_4 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_4 then
				local var_54_5 = (arg_51_1.time_ - var_54_1) / var_54_4
				local var_54_6 = Vector3.New(-390, -400, 0)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1038, var_54_6, var_54_5)
			end

			if arg_51_1.time_ >= var_54_1 + var_54_4 and arg_51_1.time_ < var_54_1 + var_54_4 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_54_7 = arg_51_1.actors_["10030"]
			local var_54_8 = 0

			if var_54_8 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.actorSpriteComps10030 == nil then
				arg_51_1.var_.actorSpriteComps10030 = var_54_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_9 = 0.2

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_9 and not isNil(var_54_7) then
				local var_54_10 = (arg_51_1.time_ - var_54_8) / var_54_9

				if arg_51_1.var_.actorSpriteComps10030 then
					for iter_54_1, iter_54_2 in pairs(arg_51_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_54_2 then
							if arg_51_1.isInRecall_ then
								local var_54_11 = Mathf.Lerp(iter_54_2.color.r, arg_51_1.hightColor2.r, var_54_10)
								local var_54_12 = Mathf.Lerp(iter_54_2.color.g, arg_51_1.hightColor2.g, var_54_10)
								local var_54_13 = Mathf.Lerp(iter_54_2.color.b, arg_51_1.hightColor2.b, var_54_10)

								iter_54_2.color = Color.New(var_54_11, var_54_12, var_54_13)
							else
								local var_54_14 = Mathf.Lerp(iter_54_2.color.r, 0.5, var_54_10)

								iter_54_2.color = Color.New(var_54_14, var_54_14, var_54_14)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_8 + var_54_9 and arg_51_1.time_ < var_54_8 + var_54_9 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.actorSpriteComps10030 then
				for iter_54_3, iter_54_4 in pairs(arg_51_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_54_4 then
						if arg_51_1.isInRecall_ then
							iter_54_4.color = arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_54_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps10030 = nil
			end

			local var_54_15 = arg_51_1.actors_["1038"]
			local var_54_16 = 0

			if var_54_16 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				local var_54_17 = var_54_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_54_17 then
					arg_51_1.var_.alphaOldValue1038 = var_54_17.alpha
					arg_51_1.var_.characterEffect1038 = var_54_17
				end

				arg_51_1.var_.alphaOldValue1038 = 0
			end

			local var_54_18 = 0.333333333333333

			if var_54_16 <= arg_51_1.time_ and arg_51_1.time_ < var_54_16 + var_54_18 then
				local var_54_19 = (arg_51_1.time_ - var_54_16) / var_54_18
				local var_54_20 = Mathf.Lerp(arg_51_1.var_.alphaOldValue1038, 1, var_54_19)

				if arg_51_1.var_.characterEffect1038 then
					arg_51_1.var_.characterEffect1038.alpha = var_54_20
				end
			end

			if arg_51_1.time_ >= var_54_16 + var_54_18 and arg_51_1.time_ < var_54_16 + var_54_18 + arg_54_0 and arg_51_1.var_.characterEffect1038 then
				arg_51_1.var_.characterEffect1038.alpha = 1
			end

			local var_54_21 = arg_51_1.actors_["1038"]
			local var_54_22 = 0

			if var_54_22 < arg_51_1.time_ and arg_51_1.time_ <= var_54_22 + arg_54_0 and not isNil(var_54_21) and arg_51_1.var_.actorSpriteComps1038 == nil then
				arg_51_1.var_.actorSpriteComps1038 = var_54_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_23 = 0.2

			if var_54_22 <= arg_51_1.time_ and arg_51_1.time_ < var_54_22 + var_54_23 and not isNil(var_54_21) then
				local var_54_24 = (arg_51_1.time_ - var_54_22) / var_54_23

				if arg_51_1.var_.actorSpriteComps1038 then
					for iter_54_5, iter_54_6 in pairs(arg_51_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_54_6 then
							if arg_51_1.isInRecall_ then
								local var_54_25 = Mathf.Lerp(iter_54_6.color.r, arg_51_1.hightColor1.r, var_54_24)
								local var_54_26 = Mathf.Lerp(iter_54_6.color.g, arg_51_1.hightColor1.g, var_54_24)
								local var_54_27 = Mathf.Lerp(iter_54_6.color.b, arg_51_1.hightColor1.b, var_54_24)

								iter_54_6.color = Color.New(var_54_25, var_54_26, var_54_27)
							else
								local var_54_28 = Mathf.Lerp(iter_54_6.color.r, 1, var_54_24)

								iter_54_6.color = Color.New(var_54_28, var_54_28, var_54_28)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_22 + var_54_23 and arg_51_1.time_ < var_54_22 + var_54_23 + arg_54_0 and not isNil(var_54_21) and arg_51_1.var_.actorSpriteComps1038 then
				for iter_54_7, iter_54_8 in pairs(arg_51_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_54_8 then
						if arg_51_1.isInRecall_ then
							iter_54_8.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_54_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps1038 = nil
			end

			local var_54_29 = 0
			local var_54_30 = 0.15

			if var_54_29 < arg_51_1.time_ and arg_51_1.time_ <= var_54_29 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_31 = arg_51_1:FormatText(StoryNameCfg[94].name)

				arg_51_1.leftNameTxt_.text = var_54_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_32 = arg_51_1:GetWordFromCfg(115301013)
				local var_54_33 = arg_51_1:FormatText(var_54_32.content)

				arg_51_1.text_.text = var_54_33

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_34 = 6
				local var_54_35 = utf8.len(var_54_33)
				local var_54_36 = var_54_34 <= 0 and var_54_30 or var_54_30 * (var_54_35 / var_54_34)

				if var_54_36 > 0 and var_54_30 < var_54_36 then
					arg_51_1.talkMaxDuration = var_54_36

					if var_54_36 + var_54_29 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_36 + var_54_29
					end
				end

				arg_51_1.text_.text = var_54_33
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301013", "story_v_out_115301.awb") ~= 0 then
					local var_54_37 = manager.audio:GetVoiceLength("story_v_out_115301", "115301013", "story_v_out_115301.awb") / 1000

					if var_54_37 + var_54_29 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_37 + var_54_29
					end

					if var_54_32.prefab_name ~= "" and arg_51_1.actors_[var_54_32.prefab_name] ~= nil then
						local var_54_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_32.prefab_name].transform, "story_v_out_115301", "115301013", "story_v_out_115301.awb")

						arg_51_1:RecordAudio("115301013", var_54_38)
						arg_51_1:RecordAudio("115301013", var_54_38)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_115301", "115301013", "story_v_out_115301.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_115301", "115301013", "story_v_out_115301.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_39 = math.max(var_54_30, arg_51_1.talkMaxDuration)

			if var_54_29 <= arg_51_1.time_ and arg_51_1.time_ < var_54_29 + var_54_39 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_29) / var_54_39

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_29 + var_54_39 and arg_51_1.time_ < var_54_29 + var_54_39 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play115301014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 115301014
		arg_55_1.duration_ = 2.73

		local var_55_0 = {
			ja = 2.733,
			ko = 1.8,
			zh = 2.066,
			en = 2.533
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play115301015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1038"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps1038 == nil then
				arg_55_1.var_.actorSpriteComps1038 = var_58_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.actorSpriteComps1038 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								local var_58_4 = Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor2.r, var_58_3)
								local var_58_5 = Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor2.g, var_58_3)
								local var_58_6 = Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor2.b, var_58_3)

								iter_58_1.color = Color.New(var_58_4, var_58_5, var_58_6)
							else
								local var_58_7 = Mathf.Lerp(iter_58_1.color.r, 0.5, var_58_3)

								iter_58_1.color = Color.New(var_58_7, var_58_7, var_58_7)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps1038 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_58_3 then
						if arg_55_1.isInRecall_ then
							iter_58_3.color = arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_58_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps1038 = nil
			end

			local var_58_8 = arg_55_1.actors_["10030"]
			local var_58_9 = 0

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps10030 == nil then
				arg_55_1.var_.actorSpriteComps10030 = var_58_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_10 = 0.2

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_10 and not isNil(var_58_8) then
				local var_58_11 = (arg_55_1.time_ - var_58_9) / var_58_10

				if arg_55_1.var_.actorSpriteComps10030 then
					for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_58_5 then
							if arg_55_1.isInRecall_ then
								local var_58_12 = Mathf.Lerp(iter_58_5.color.r, arg_55_1.hightColor1.r, var_58_11)
								local var_58_13 = Mathf.Lerp(iter_58_5.color.g, arg_55_1.hightColor1.g, var_58_11)
								local var_58_14 = Mathf.Lerp(iter_58_5.color.b, arg_55_1.hightColor1.b, var_58_11)

								iter_58_5.color = Color.New(var_58_12, var_58_13, var_58_14)
							else
								local var_58_15 = Mathf.Lerp(iter_58_5.color.r, 1, var_58_11)

								iter_58_5.color = Color.New(var_58_15, var_58_15, var_58_15)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_9 + var_58_10 and arg_55_1.time_ < var_58_9 + var_58_10 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps10030 then
				for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_58_7 then
						if arg_55_1.isInRecall_ then
							iter_58_7.color = arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_58_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps10030 = nil
			end

			local var_58_16 = 0
			local var_58_17 = 0.2

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_18 = arg_55_1:FormatText(StoryNameCfg[309].name)

				arg_55_1.leftNameTxt_.text = var_58_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_19 = arg_55_1:GetWordFromCfg(115301014)
				local var_58_20 = arg_55_1:FormatText(var_58_19.content)

				arg_55_1.text_.text = var_58_20

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_21 = 8
				local var_58_22 = utf8.len(var_58_20)
				local var_58_23 = var_58_21 <= 0 and var_58_17 or var_58_17 * (var_58_22 / var_58_21)

				if var_58_23 > 0 and var_58_17 < var_58_23 then
					arg_55_1.talkMaxDuration = var_58_23

					if var_58_23 + var_58_16 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_16
					end
				end

				arg_55_1.text_.text = var_58_20
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301014", "story_v_out_115301.awb") ~= 0 then
					local var_58_24 = manager.audio:GetVoiceLength("story_v_out_115301", "115301014", "story_v_out_115301.awb") / 1000

					if var_58_24 + var_58_16 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_24 + var_58_16
					end

					if var_58_19.prefab_name ~= "" and arg_55_1.actors_[var_58_19.prefab_name] ~= nil then
						local var_58_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_19.prefab_name].transform, "story_v_out_115301", "115301014", "story_v_out_115301.awb")

						arg_55_1:RecordAudio("115301014", var_58_25)
						arg_55_1:RecordAudio("115301014", var_58_25)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_115301", "115301014", "story_v_out_115301.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_115301", "115301014", "story_v_out_115301.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_26 = math.max(var_58_17, arg_55_1.talkMaxDuration)

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_26 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_16) / var_58_26

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_16 + var_58_26 and arg_55_1.time_ < var_58_16 + var_58_26 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play115301015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 115301015
		arg_59_1.duration_ = 10.1

		local var_59_0 = {
			ja = 10.1,
			ko = 8,
			zh = 5.033,
			en = 5.533
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
				arg_59_0:Play115301016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.575

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[309].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:GetWordFromCfg(115301015)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 23
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301015", "story_v_out_115301.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301015", "story_v_out_115301.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_115301", "115301015", "story_v_out_115301.awb")

						arg_59_1:RecordAudio("115301015", var_62_9)
						arg_59_1:RecordAudio("115301015", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_115301", "115301015", "story_v_out_115301.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_115301", "115301015", "story_v_out_115301.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_10 and arg_59_1.time_ < var_62_0 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play115301016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 115301016
		arg_63_1.duration_ = 9.7

		local var_63_0 = {
			ja = 3.5,
			ko = 5.833,
			zh = 9.7,
			en = 7.1
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
				arg_63_0:Play115301017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1038"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps1038 == nil then
				arg_63_1.var_.actorSpriteComps1038 = var_66_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.actorSpriteComps1038 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								local var_66_4 = Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, var_66_3)
								local var_66_5 = Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, var_66_3)
								local var_66_6 = Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, var_66_3)

								iter_66_1.color = Color.New(var_66_4, var_66_5, var_66_6)
							else
								local var_66_7 = Mathf.Lerp(iter_66_1.color.r, 1, var_66_3)

								iter_66_1.color = Color.New(var_66_7, var_66_7, var_66_7)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps1038 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_66_3 then
						if arg_63_1.isInRecall_ then
							iter_66_3.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps1038 = nil
			end

			local var_66_8 = arg_63_1.actors_["10030"]
			local var_66_9 = 0

			if var_66_9 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 and not isNil(var_66_8) and arg_63_1.var_.actorSpriteComps10030 == nil then
				arg_63_1.var_.actorSpriteComps10030 = var_66_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_10 = 0.2

			if var_66_9 <= arg_63_1.time_ and arg_63_1.time_ < var_66_9 + var_66_10 and not isNil(var_66_8) then
				local var_66_11 = (arg_63_1.time_ - var_66_9) / var_66_10

				if arg_63_1.var_.actorSpriteComps10030 then
					for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_66_5 then
							if arg_63_1.isInRecall_ then
								local var_66_12 = Mathf.Lerp(iter_66_5.color.r, arg_63_1.hightColor2.r, var_66_11)
								local var_66_13 = Mathf.Lerp(iter_66_5.color.g, arg_63_1.hightColor2.g, var_66_11)
								local var_66_14 = Mathf.Lerp(iter_66_5.color.b, arg_63_1.hightColor2.b, var_66_11)

								iter_66_5.color = Color.New(var_66_12, var_66_13, var_66_14)
							else
								local var_66_15 = Mathf.Lerp(iter_66_5.color.r, 0.5, var_66_11)

								iter_66_5.color = Color.New(var_66_15, var_66_15, var_66_15)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_9 + var_66_10 and arg_63_1.time_ < var_66_9 + var_66_10 + arg_66_0 and not isNil(var_66_8) and arg_63_1.var_.actorSpriteComps10030 then
				for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_66_7 then
						if arg_63_1.isInRecall_ then
							iter_66_7.color = arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_66_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10030 = nil
			end

			local var_66_16 = 0
			local var_66_17 = 0.725

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_18 = arg_63_1:FormatText(StoryNameCfg[94].name)

				arg_63_1.leftNameTxt_.text = var_66_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_19 = arg_63_1:GetWordFromCfg(115301016)
				local var_66_20 = arg_63_1:FormatText(var_66_19.content)

				arg_63_1.text_.text = var_66_20

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_21 = 28
				local var_66_22 = utf8.len(var_66_20)
				local var_66_23 = var_66_21 <= 0 and var_66_17 or var_66_17 * (var_66_22 / var_66_21)

				if var_66_23 > 0 and var_66_17 < var_66_23 then
					arg_63_1.talkMaxDuration = var_66_23

					if var_66_23 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_16
					end
				end

				arg_63_1.text_.text = var_66_20
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301016", "story_v_out_115301.awb") ~= 0 then
					local var_66_24 = manager.audio:GetVoiceLength("story_v_out_115301", "115301016", "story_v_out_115301.awb") / 1000

					if var_66_24 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_24 + var_66_16
					end

					if var_66_19.prefab_name ~= "" and arg_63_1.actors_[var_66_19.prefab_name] ~= nil then
						local var_66_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_19.prefab_name].transform, "story_v_out_115301", "115301016", "story_v_out_115301.awb")

						arg_63_1:RecordAudio("115301016", var_66_25)
						arg_63_1:RecordAudio("115301016", var_66_25)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_115301", "115301016", "story_v_out_115301.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_115301", "115301016", "story_v_out_115301.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_26 = math.max(var_66_17, arg_63_1.talkMaxDuration)

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_26 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_16) / var_66_26

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_16 + var_66_26 and arg_63_1.time_ < var_66_16 + var_66_26 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play115301017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 115301017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play115301018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1038"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps1038 == nil then
				arg_67_1.var_.actorSpriteComps1038 = var_70_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.actorSpriteComps1038 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_70_1 then
							if arg_67_1.isInRecall_ then
								local var_70_4 = Mathf.Lerp(iter_70_1.color.r, arg_67_1.hightColor2.r, var_70_3)
								local var_70_5 = Mathf.Lerp(iter_70_1.color.g, arg_67_1.hightColor2.g, var_70_3)
								local var_70_6 = Mathf.Lerp(iter_70_1.color.b, arg_67_1.hightColor2.b, var_70_3)

								iter_70_1.color = Color.New(var_70_4, var_70_5, var_70_6)
							else
								local var_70_7 = Mathf.Lerp(iter_70_1.color.r, 0.5, var_70_3)

								iter_70_1.color = Color.New(var_70_7, var_70_7, var_70_7)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps1038 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_70_3 then
						if arg_67_1.isInRecall_ then
							iter_70_3.color = arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_70_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps1038 = nil
			end

			local var_70_8 = 0
			local var_70_9 = 0.9

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_10 = arg_67_1:GetWordFromCfg(115301017)
				local var_70_11 = arg_67_1:FormatText(var_70_10.content)

				arg_67_1.text_.text = var_70_11

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_12 = 36
				local var_70_13 = utf8.len(var_70_11)
				local var_70_14 = var_70_12 <= 0 and var_70_9 or var_70_9 * (var_70_13 / var_70_12)

				if var_70_14 > 0 and var_70_9 < var_70_14 then
					arg_67_1.talkMaxDuration = var_70_14

					if var_70_14 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_11
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_15 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_15 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_15

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_15 and arg_67_1.time_ < var_70_8 + var_70_15 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play115301018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 115301018
		arg_71_1.duration_ = 5.83

		local var_71_0 = {
			ja = 5.833,
			ko = 4.5,
			zh = 4.866,
			en = 3.166
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
				arg_71_0:Play115301019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10030"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos10030 = var_74_0.localPosition
				var_74_0.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10030", 4)

				local var_74_2 = var_74_0.childCount

				for iter_74_0 = 0, var_74_2 - 1 do
					local var_74_3 = var_74_0:GetChild(iter_74_0)

					if var_74_3.name == "split_5" or not string.find(var_74_3.name, "split") then
						var_74_3.gameObject:SetActive(true)
					else
						var_74_3.gameObject:SetActive(false)
					end
				end
			end

			local var_74_4 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_4 then
				local var_74_5 = (arg_71_1.time_ - var_74_1) / var_74_4
				local var_74_6 = Vector3.New(390, -390, 150)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10030, var_74_6, var_74_5)
			end

			if arg_71_1.time_ >= var_74_1 + var_74_4 and arg_71_1.time_ < var_74_1 + var_74_4 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_74_7 = arg_71_1.actors_["10030"]
			local var_74_8 = 0

			if var_74_8 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.actorSpriteComps10030 == nil then
				arg_71_1.var_.actorSpriteComps10030 = var_74_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_9 = 0.2

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_9 and not isNil(var_74_7) then
				local var_74_10 = (arg_71_1.time_ - var_74_8) / var_74_9

				if arg_71_1.var_.actorSpriteComps10030 then
					for iter_74_1, iter_74_2 in pairs(arg_71_1.var_.actorSpriteComps10030:ToTable()) do
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

			if arg_71_1.time_ >= var_74_8 + var_74_9 and arg_71_1.time_ < var_74_8 + var_74_9 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.actorSpriteComps10030 then
				for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_74_4 then
						if arg_71_1.isInRecall_ then
							iter_74_4.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_74_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps10030 = nil
			end

			local var_74_15 = 0
			local var_74_16 = 0.45

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_17 = arg_71_1:FormatText(StoryNameCfg[309].name)

				arg_71_1.leftNameTxt_.text = var_74_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_18 = arg_71_1:GetWordFromCfg(115301018)
				local var_74_19 = arg_71_1:FormatText(var_74_18.content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_20 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301018", "story_v_out_115301.awb") ~= 0 then
					local var_74_23 = manager.audio:GetVoiceLength("story_v_out_115301", "115301018", "story_v_out_115301.awb") / 1000

					if var_74_23 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_15
					end

					if var_74_18.prefab_name ~= "" and arg_71_1.actors_[var_74_18.prefab_name] ~= nil then
						local var_74_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_18.prefab_name].transform, "story_v_out_115301", "115301018", "story_v_out_115301.awb")

						arg_71_1:RecordAudio("115301018", var_74_24)
						arg_71_1:RecordAudio("115301018", var_74_24)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_115301", "115301018", "story_v_out_115301.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_115301", "115301018", "story_v_out_115301.awb")
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
				actorName = "10030",
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
	Play115301019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 115301019
		arg_75_1.duration_ = 7.77

		local var_75_0 = {
			ja = 7.766,
			ko = 6.166,
			zh = 6.366,
			en = 4.466
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
				arg_75_0:Play115301020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10030"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.actorSpriteComps10030 == nil then
				arg_75_1.var_.actorSpriteComps10030 = var_78_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_2 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.actorSpriteComps10030 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								local var_78_4 = Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor2.r, var_78_3)
								local var_78_5 = Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor2.g, var_78_3)
								local var_78_6 = Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor2.b, var_78_3)

								iter_78_1.color = Color.New(var_78_4, var_78_5, var_78_6)
							else
								local var_78_7 = Mathf.Lerp(iter_78_1.color.r, 0.5, var_78_3)

								iter_78_1.color = Color.New(var_78_7, var_78_7, var_78_7)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.actorSpriteComps10030 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_78_3 then
						if arg_75_1.isInRecall_ then
							iter_78_3.color = arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_78_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps10030 = nil
			end

			local var_78_8 = arg_75_1.actors_["1038"].transform
			local var_78_9 = 0

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1.var_.moveOldPos1038 = var_78_8.localPosition
				var_78_8.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1038", 2)

				local var_78_10 = var_78_8.childCount

				for iter_78_4 = 0, var_78_10 - 1 do
					local var_78_11 = var_78_8:GetChild(iter_78_4)

					if var_78_11.name == "split_1" or not string.find(var_78_11.name, "split") then
						var_78_11.gameObject:SetActive(true)
					else
						var_78_11.gameObject:SetActive(false)
					end
				end
			end

			local var_78_12 = 0.001

			if var_78_9 <= arg_75_1.time_ and arg_75_1.time_ < var_78_9 + var_78_12 then
				local var_78_13 = (arg_75_1.time_ - var_78_9) / var_78_12
				local var_78_14 = Vector3.New(-390, -400, 0)

				var_78_8.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1038, var_78_14, var_78_13)
			end

			if arg_75_1.time_ >= var_78_9 + var_78_12 and arg_75_1.time_ < var_78_9 + var_78_12 + arg_78_0 then
				var_78_8.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_78_15 = arg_75_1.actors_["1038"]
			local var_78_16 = 0

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 and not isNil(var_78_15) and arg_75_1.var_.actorSpriteComps1038 == nil then
				arg_75_1.var_.actorSpriteComps1038 = var_78_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_17 = 0.2

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_17 and not isNil(var_78_15) then
				local var_78_18 = (arg_75_1.time_ - var_78_16) / var_78_17

				if arg_75_1.var_.actorSpriteComps1038 then
					for iter_78_5, iter_78_6 in pairs(arg_75_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_78_6 then
							if arg_75_1.isInRecall_ then
								local var_78_19 = Mathf.Lerp(iter_78_6.color.r, arg_75_1.hightColor1.r, var_78_18)
								local var_78_20 = Mathf.Lerp(iter_78_6.color.g, arg_75_1.hightColor1.g, var_78_18)
								local var_78_21 = Mathf.Lerp(iter_78_6.color.b, arg_75_1.hightColor1.b, var_78_18)

								iter_78_6.color = Color.New(var_78_19, var_78_20, var_78_21)
							else
								local var_78_22 = Mathf.Lerp(iter_78_6.color.r, 1, var_78_18)

								iter_78_6.color = Color.New(var_78_22, var_78_22, var_78_22)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_16 + var_78_17 and arg_75_1.time_ < var_78_16 + var_78_17 + arg_78_0 and not isNil(var_78_15) and arg_75_1.var_.actorSpriteComps1038 then
				for iter_78_7, iter_78_8 in pairs(arg_75_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_78_8 then
						if arg_75_1.isInRecall_ then
							iter_78_8.color = arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_78_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps1038 = nil
			end

			local var_78_23 = 0
			local var_78_24 = 0.475

			if var_78_23 < arg_75_1.time_ and arg_75_1.time_ <= var_78_23 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_25 = arg_75_1:FormatText(StoryNameCfg[94].name)

				arg_75_1.leftNameTxt_.text = var_78_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_26 = arg_75_1:GetWordFromCfg(115301019)
				local var_78_27 = arg_75_1:FormatText(var_78_26.content)

				arg_75_1.text_.text = var_78_27

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_28 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301019", "story_v_out_115301.awb") ~= 0 then
					local var_78_31 = manager.audio:GetVoiceLength("story_v_out_115301", "115301019", "story_v_out_115301.awb") / 1000

					if var_78_31 + var_78_23 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_31 + var_78_23
					end

					if var_78_26.prefab_name ~= "" and arg_75_1.actors_[var_78_26.prefab_name] ~= nil then
						local var_78_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_26.prefab_name].transform, "story_v_out_115301", "115301019", "story_v_out_115301.awb")

						arg_75_1:RecordAudio("115301019", var_78_32)
						arg_75_1:RecordAudio("115301019", var_78_32)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_115301", "115301019", "story_v_out_115301.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_115301", "115301019", "story_v_out_115301.awb")
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
				actorName = "1038",
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
	Play115301020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 115301020
		arg_79_1.duration_ = 4.03

		local var_79_0 = {
			ja = 2.733,
			ko = 3.366,
			zh = 4.033,
			en = 3.3
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
				arg_79_0:Play115301021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1038"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps1038 == nil then
				arg_79_1.var_.actorSpriteComps1038 = var_82_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.actorSpriteComps1038 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								local var_82_4 = Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, var_82_3)
								local var_82_5 = Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, var_82_3)
								local var_82_6 = Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, var_82_3)

								iter_82_1.color = Color.New(var_82_4, var_82_5, var_82_6)
							else
								local var_82_7 = Mathf.Lerp(iter_82_1.color.r, 0.5, var_82_3)

								iter_82_1.color = Color.New(var_82_7, var_82_7, var_82_7)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps1038 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_82_3 then
						if arg_79_1.isInRecall_ then
							iter_82_3.color = arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_82_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps1038 = nil
			end

			local var_82_8 = arg_79_1.actors_["10030"]
			local var_82_9 = 0

			if var_82_9 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 and not isNil(var_82_8) and arg_79_1.var_.actorSpriteComps10030 == nil then
				arg_79_1.var_.actorSpriteComps10030 = var_82_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_10 = 0.2

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_10 and not isNil(var_82_8) then
				local var_82_11 = (arg_79_1.time_ - var_82_9) / var_82_10

				if arg_79_1.var_.actorSpriteComps10030 then
					for iter_82_4, iter_82_5 in pairs(arg_79_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_82_5 then
							if arg_79_1.isInRecall_ then
								local var_82_12 = Mathf.Lerp(iter_82_5.color.r, arg_79_1.hightColor1.r, var_82_11)
								local var_82_13 = Mathf.Lerp(iter_82_5.color.g, arg_79_1.hightColor1.g, var_82_11)
								local var_82_14 = Mathf.Lerp(iter_82_5.color.b, arg_79_1.hightColor1.b, var_82_11)

								iter_82_5.color = Color.New(var_82_12, var_82_13, var_82_14)
							else
								local var_82_15 = Mathf.Lerp(iter_82_5.color.r, 1, var_82_11)

								iter_82_5.color = Color.New(var_82_15, var_82_15, var_82_15)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_9 + var_82_10 and arg_79_1.time_ < var_82_9 + var_82_10 + arg_82_0 and not isNil(var_82_8) and arg_79_1.var_.actorSpriteComps10030 then
				for iter_82_6, iter_82_7 in pairs(arg_79_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_82_7 then
						if arg_79_1.isInRecall_ then
							iter_82_7.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_82_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps10030 = nil
			end

			local var_82_16 = 0
			local var_82_17 = 0.35

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_18 = arg_79_1:FormatText(StoryNameCfg[309].name)

				arg_79_1.leftNameTxt_.text = var_82_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_19 = arg_79_1:GetWordFromCfg(115301020)
				local var_82_20 = arg_79_1:FormatText(var_82_19.content)

				arg_79_1.text_.text = var_82_20

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_21 = 14
				local var_82_22 = utf8.len(var_82_20)
				local var_82_23 = var_82_21 <= 0 and var_82_17 or var_82_17 * (var_82_22 / var_82_21)

				if var_82_23 > 0 and var_82_17 < var_82_23 then
					arg_79_1.talkMaxDuration = var_82_23

					if var_82_23 + var_82_16 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_23 + var_82_16
					end
				end

				arg_79_1.text_.text = var_82_20
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301020", "story_v_out_115301.awb") ~= 0 then
					local var_82_24 = manager.audio:GetVoiceLength("story_v_out_115301", "115301020", "story_v_out_115301.awb") / 1000

					if var_82_24 + var_82_16 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_24 + var_82_16
					end

					if var_82_19.prefab_name ~= "" and arg_79_1.actors_[var_82_19.prefab_name] ~= nil then
						local var_82_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_19.prefab_name].transform, "story_v_out_115301", "115301020", "story_v_out_115301.awb")

						arg_79_1:RecordAudio("115301020", var_82_25)
						arg_79_1:RecordAudio("115301020", var_82_25)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_115301", "115301020", "story_v_out_115301.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_115301", "115301020", "story_v_out_115301.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_26 = math.max(var_82_17, arg_79_1.talkMaxDuration)

			if var_82_16 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_26 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_16) / var_82_26

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_16 + var_82_26 and arg_79_1.time_ < var_82_16 + var_82_26 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play115301021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 115301021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play115301022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10030"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				local var_86_2 = var_86_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_86_2 then
					arg_83_1.var_.alphaOldValue10030 = var_86_2.alpha
					arg_83_1.var_.characterEffect10030 = var_86_2
				end

				arg_83_1.var_.alphaOldValue10030 = 1
			end

			local var_86_3 = 0.333333333333333

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_3 then
				local var_86_4 = (arg_83_1.time_ - var_86_1) / var_86_3
				local var_86_5 = Mathf.Lerp(arg_83_1.var_.alphaOldValue10030, 0, var_86_4)

				if arg_83_1.var_.characterEffect10030 then
					arg_83_1.var_.characterEffect10030.alpha = var_86_5
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_3 and arg_83_1.time_ < var_86_1 + var_86_3 + arg_86_0 and arg_83_1.var_.characterEffect10030 then
				arg_83_1.var_.characterEffect10030.alpha = 0
			end

			local var_86_6 = arg_83_1.actors_["1038"]
			local var_86_7 = 0

			if var_86_7 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 then
				local var_86_8 = var_86_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_86_8 then
					arg_83_1.var_.alphaOldValue1038 = var_86_8.alpha
					arg_83_1.var_.characterEffect1038 = var_86_8
				end

				arg_83_1.var_.alphaOldValue1038 = 1
			end

			local var_86_9 = 0.333333333333333

			if var_86_7 <= arg_83_1.time_ and arg_83_1.time_ < var_86_7 + var_86_9 then
				local var_86_10 = (arg_83_1.time_ - var_86_7) / var_86_9
				local var_86_11 = Mathf.Lerp(arg_83_1.var_.alphaOldValue1038, 0, var_86_10)

				if arg_83_1.var_.characterEffect1038 then
					arg_83_1.var_.characterEffect1038.alpha = var_86_11
				end
			end

			if arg_83_1.time_ >= var_86_7 + var_86_9 and arg_83_1.time_ < var_86_7 + var_86_9 + arg_86_0 and arg_83_1.var_.characterEffect1038 then
				arg_83_1.var_.characterEffect1038.alpha = 0
			end

			local var_86_12 = 0
			local var_86_13 = 0.925

			if var_86_12 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_14 = arg_83_1:GetWordFromCfg(115301021)
				local var_86_15 = arg_83_1:FormatText(var_86_14.content)

				arg_83_1.text_.text = var_86_15

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_16 = 37
				local var_86_17 = utf8.len(var_86_15)
				local var_86_18 = var_86_16 <= 0 and var_86_13 or var_86_13 * (var_86_17 / var_86_16)

				if var_86_18 > 0 and var_86_13 < var_86_18 then
					arg_83_1.talkMaxDuration = var_86_18

					if var_86_18 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_18 + var_86_12
					end
				end

				arg_83_1.text_.text = var_86_15
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_19 = math.max(var_86_13, arg_83_1.talkMaxDuration)

			if var_86_12 <= arg_83_1.time_ and arg_83_1.time_ < var_86_12 + var_86_19 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_12) / var_86_19

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_12 + var_86_19 and arg_83_1.time_ < var_86_12 + var_86_19 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play115301022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 115301022
		arg_87_1.duration_ = 8.37

		local var_87_0 = {
			ja = 6.2,
			ko = 8.333,
			zh = 8.366,
			en = 8.266
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
				arg_87_0:Play115301023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10030"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos10030 = var_90_0.localPosition
				var_90_0.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10030", 3)

				local var_90_2 = var_90_0.childCount

				for iter_90_0 = 0, var_90_2 - 1 do
					local var_90_3 = var_90_0:GetChild(iter_90_0)

					if var_90_3.name == "split_5" or not string.find(var_90_3.name, "split") then
						var_90_3.gameObject:SetActive(true)
					else
						var_90_3.gameObject:SetActive(false)
					end
				end
			end

			local var_90_4 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_4 then
				local var_90_5 = (arg_87_1.time_ - var_90_1) / var_90_4
				local var_90_6 = Vector3.New(0, -390, 150)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10030, var_90_6, var_90_5)
			end

			if arg_87_1.time_ >= var_90_1 + var_90_4 and arg_87_1.time_ < var_90_1 + var_90_4 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_90_7 = arg_87_1.actors_["10030"]
			local var_90_8 = 0

			if var_90_8 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				local var_90_9 = var_90_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_90_9 then
					arg_87_1.var_.alphaOldValue10030 = var_90_9.alpha
					arg_87_1.var_.characterEffect10030 = var_90_9
				end

				arg_87_1.var_.alphaOldValue10030 = 0
			end

			local var_90_10 = 0.333333333333333

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_10 then
				local var_90_11 = (arg_87_1.time_ - var_90_8) / var_90_10
				local var_90_12 = Mathf.Lerp(arg_87_1.var_.alphaOldValue10030, 1, var_90_11)

				if arg_87_1.var_.characterEffect10030 then
					arg_87_1.var_.characterEffect10030.alpha = var_90_12
				end
			end

			if arg_87_1.time_ >= var_90_8 + var_90_10 and arg_87_1.time_ < var_90_8 + var_90_10 + arg_90_0 and arg_87_1.var_.characterEffect10030 then
				arg_87_1.var_.characterEffect10030.alpha = 1
			end

			local var_90_13 = 0
			local var_90_14 = 1.125

			if var_90_13 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_15 = arg_87_1:FormatText(StoryNameCfg[309].name)

				arg_87_1.leftNameTxt_.text = var_90_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_16 = arg_87_1:GetWordFromCfg(115301022)
				local var_90_17 = arg_87_1:FormatText(var_90_16.content)

				arg_87_1.text_.text = var_90_17

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_18 = 45
				local var_90_19 = utf8.len(var_90_17)
				local var_90_20 = var_90_18 <= 0 and var_90_14 or var_90_14 * (var_90_19 / var_90_18)

				if var_90_20 > 0 and var_90_14 < var_90_20 then
					arg_87_1.talkMaxDuration = var_90_20

					if var_90_20 + var_90_13 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_20 + var_90_13
					end
				end

				arg_87_1.text_.text = var_90_17
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301022", "story_v_out_115301.awb") ~= 0 then
					local var_90_21 = manager.audio:GetVoiceLength("story_v_out_115301", "115301022", "story_v_out_115301.awb") / 1000

					if var_90_21 + var_90_13 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_21 + var_90_13
					end

					if var_90_16.prefab_name ~= "" and arg_87_1.actors_[var_90_16.prefab_name] ~= nil then
						local var_90_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_16.prefab_name].transform, "story_v_out_115301", "115301022", "story_v_out_115301.awb")

						arg_87_1:RecordAudio("115301022", var_90_22)
						arg_87_1:RecordAudio("115301022", var_90_22)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_115301", "115301022", "story_v_out_115301.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_115301", "115301022", "story_v_out_115301.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_23 = math.max(var_90_14, arg_87_1.talkMaxDuration)

			if var_90_13 <= arg_87_1.time_ and arg_87_1.time_ < var_90_13 + var_90_23 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_13) / var_90_23

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_13 + var_90_23 and arg_87_1.time_ < var_90_13 + var_90_23 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115301023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 115301023
		arg_91_1.duration_ = 11.87

		local var_91_0 = {
			ja = 9.766,
			ko = 11.866,
			zh = 9.6,
			en = 11.433
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
				arg_91_0:Play115301024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 1.25

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[309].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(115301023)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 50
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301023", "story_v_out_115301.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301023", "story_v_out_115301.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_115301", "115301023", "story_v_out_115301.awb")

						arg_91_1:RecordAudio("115301023", var_94_9)
						arg_91_1:RecordAudio("115301023", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_115301", "115301023", "story_v_out_115301.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_115301", "115301023", "story_v_out_115301.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play115301024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 115301024
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play115301025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10030"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				local var_98_2 = var_98_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_98_2 then
					arg_95_1.var_.alphaOldValue10030 = var_98_2.alpha
					arg_95_1.var_.characterEffect10030 = var_98_2
				end

				arg_95_1.var_.alphaOldValue10030 = 1
			end

			local var_98_3 = 0.333333333333333

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_3 then
				local var_98_4 = (arg_95_1.time_ - var_98_1) / var_98_3
				local var_98_5 = Mathf.Lerp(arg_95_1.var_.alphaOldValue10030, 0, var_98_4)

				if arg_95_1.var_.characterEffect10030 then
					arg_95_1.var_.characterEffect10030.alpha = var_98_5
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_3 and arg_95_1.time_ < var_98_1 + var_98_3 + arg_98_0 and arg_95_1.var_.characterEffect10030 then
				arg_95_1.var_.characterEffect10030.alpha = 0
			end

			local var_98_6 = 0
			local var_98_7 = 0.55

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_8 = arg_95_1:GetWordFromCfg(115301024)
				local var_98_9 = arg_95_1:FormatText(var_98_8.content)

				arg_95_1.text_.text = var_98_9

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_10 = 22
				local var_98_11 = utf8.len(var_98_9)
				local var_98_12 = var_98_10 <= 0 and var_98_7 or var_98_7 * (var_98_11 / var_98_10)

				if var_98_12 > 0 and var_98_7 < var_98_12 then
					arg_95_1.talkMaxDuration = var_98_12

					if var_98_12 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_12 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_9
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_13 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_13 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_13

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_13 and arg_95_1.time_ < var_98_6 + var_98_13 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play115301025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 115301025
		arg_99_1.duration_ = 4.1

		local var_99_0 = {
			ja = 4.1,
			ko = 1.4,
			zh = 2.866,
			en = 1.366
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
				arg_99_0:Play115301026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1038"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1038 = var_102_0.localPosition
				var_102_0.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1038", 3)

				local var_102_2 = var_102_0.childCount

				for iter_102_0 = 0, var_102_2 - 1 do
					local var_102_3 = var_102_0:GetChild(iter_102_0)

					if var_102_3.name == "split_1" or not string.find(var_102_3.name, "split") then
						var_102_3.gameObject:SetActive(true)
					else
						var_102_3.gameObject:SetActive(false)
					end
				end
			end

			local var_102_4 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_4 then
				local var_102_5 = (arg_99_1.time_ - var_102_1) / var_102_4
				local var_102_6 = Vector3.New(0, -400, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1038, var_102_6, var_102_5)
			end

			if arg_99_1.time_ >= var_102_1 + var_102_4 and arg_99_1.time_ < var_102_1 + var_102_4 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_102_7 = arg_99_1.actors_["1038"]
			local var_102_8 = 0

			if var_102_8 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				local var_102_9 = var_102_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_102_9 then
					arg_99_1.var_.alphaOldValue1038 = var_102_9.alpha
					arg_99_1.var_.characterEffect1038 = var_102_9
				end

				arg_99_1.var_.alphaOldValue1038 = 0
			end

			local var_102_10 = 0.333333333333333

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_10 then
				local var_102_11 = (arg_99_1.time_ - var_102_8) / var_102_10
				local var_102_12 = Mathf.Lerp(arg_99_1.var_.alphaOldValue1038, 1, var_102_11)

				if arg_99_1.var_.characterEffect1038 then
					arg_99_1.var_.characterEffect1038.alpha = var_102_12
				end
			end

			if arg_99_1.time_ >= var_102_8 + var_102_10 and arg_99_1.time_ < var_102_8 + var_102_10 + arg_102_0 and arg_99_1.var_.characterEffect1038 then
				arg_99_1.var_.characterEffect1038.alpha = 1
			end

			local var_102_13 = arg_99_1.actors_["1038"]
			local var_102_14 = 0

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 and not isNil(var_102_13) and arg_99_1.var_.actorSpriteComps1038 == nil then
				arg_99_1.var_.actorSpriteComps1038 = var_102_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_15 = 0.2

			if var_102_14 <= arg_99_1.time_ and arg_99_1.time_ < var_102_14 + var_102_15 and not isNil(var_102_13) then
				local var_102_16 = (arg_99_1.time_ - var_102_14) / var_102_15

				if arg_99_1.var_.actorSpriteComps1038 then
					for iter_102_1, iter_102_2 in pairs(arg_99_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_102_2 then
							if arg_99_1.isInRecall_ then
								local var_102_17 = Mathf.Lerp(iter_102_2.color.r, arg_99_1.hightColor1.r, var_102_16)
								local var_102_18 = Mathf.Lerp(iter_102_2.color.g, arg_99_1.hightColor1.g, var_102_16)
								local var_102_19 = Mathf.Lerp(iter_102_2.color.b, arg_99_1.hightColor1.b, var_102_16)

								iter_102_2.color = Color.New(var_102_17, var_102_18, var_102_19)
							else
								local var_102_20 = Mathf.Lerp(iter_102_2.color.r, 1, var_102_16)

								iter_102_2.color = Color.New(var_102_20, var_102_20, var_102_20)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_14 + var_102_15 and arg_99_1.time_ < var_102_14 + var_102_15 + arg_102_0 and not isNil(var_102_13) and arg_99_1.var_.actorSpriteComps1038 then
				for iter_102_3, iter_102_4 in pairs(arg_99_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_102_4 then
						if arg_99_1.isInRecall_ then
							iter_102_4.color = arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_102_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps1038 = nil
			end

			local var_102_21 = 0
			local var_102_22 = 0.125

			if var_102_21 < arg_99_1.time_ and arg_99_1.time_ <= var_102_21 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_23 = arg_99_1:FormatText(StoryNameCfg[94].name)

				arg_99_1.leftNameTxt_.text = var_102_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_24 = arg_99_1:GetWordFromCfg(115301025)
				local var_102_25 = arg_99_1:FormatText(var_102_24.content)

				arg_99_1.text_.text = var_102_25

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_26 = 5
				local var_102_27 = utf8.len(var_102_25)
				local var_102_28 = var_102_26 <= 0 and var_102_22 or var_102_22 * (var_102_27 / var_102_26)

				if var_102_28 > 0 and var_102_22 < var_102_28 then
					arg_99_1.talkMaxDuration = var_102_28

					if var_102_28 + var_102_21 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_28 + var_102_21
					end
				end

				arg_99_1.text_.text = var_102_25
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301025", "story_v_out_115301.awb") ~= 0 then
					local var_102_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301025", "story_v_out_115301.awb") / 1000

					if var_102_29 + var_102_21 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_29 + var_102_21
					end

					if var_102_24.prefab_name ~= "" and arg_99_1.actors_[var_102_24.prefab_name] ~= nil then
						local var_102_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_24.prefab_name].transform, "story_v_out_115301", "115301025", "story_v_out_115301.awb")

						arg_99_1:RecordAudio("115301025", var_102_30)
						arg_99_1:RecordAudio("115301025", var_102_30)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_115301", "115301025", "story_v_out_115301.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_115301", "115301025", "story_v_out_115301.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_31 = math.max(var_102_22, arg_99_1.talkMaxDuration)

			if var_102_21 <= arg_99_1.time_ and arg_99_1.time_ < var_102_21 + var_102_31 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_21) / var_102_31

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_21 + var_102_31 and arg_99_1.time_ < var_102_21 + var_102_31 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
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
	Play115301026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 115301026
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play115301027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1038"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				local var_106_2 = var_106_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_106_2 then
					arg_103_1.var_.alphaOldValue1038 = var_106_2.alpha
					arg_103_1.var_.characterEffect1038 = var_106_2
				end

				arg_103_1.var_.alphaOldValue1038 = 1
			end

			local var_106_3 = 0.333333333333333

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_3 then
				local var_106_4 = (arg_103_1.time_ - var_106_1) / var_106_3
				local var_106_5 = Mathf.Lerp(arg_103_1.var_.alphaOldValue1038, 0, var_106_4)

				if arg_103_1.var_.characterEffect1038 then
					arg_103_1.var_.characterEffect1038.alpha = var_106_5
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_3 and arg_103_1.time_ < var_106_1 + var_106_3 + arg_106_0 and arg_103_1.var_.characterEffect1038 then
				arg_103_1.var_.characterEffect1038.alpha = 0
			end

			local var_106_6 = 0
			local var_106_7 = 1.675

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_8 = arg_103_1:GetWordFromCfg(115301026)
				local var_106_9 = arg_103_1:FormatText(var_106_8.content)

				arg_103_1.text_.text = var_106_9

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 67
				local var_106_11 = utf8.len(var_106_9)
				local var_106_12 = var_106_10 <= 0 and var_106_7 or var_106_7 * (var_106_11 / var_106_10)

				if var_106_12 > 0 and var_106_7 < var_106_12 then
					arg_103_1.talkMaxDuration = var_106_12

					if var_106_12 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_12 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_9
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_13 and arg_103_1.time_ < var_106_6 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play115301027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 115301027
		arg_107_1.duration_ = 8.73

		local var_107_0 = {
			ja = 5.066,
			ko = 7.4,
			zh = 8.733,
			en = 5.433
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
				arg_107_0:Play115301028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10030"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10030 = var_110_0.localPosition
				var_110_0.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10030", 3)

				local var_110_2 = var_110_0.childCount

				for iter_110_0 = 0, var_110_2 - 1 do
					local var_110_3 = var_110_0:GetChild(iter_110_0)

					if var_110_3.name == "split_3" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_4 then
				local var_110_5 = (arg_107_1.time_ - var_110_1) / var_110_4
				local var_110_6 = Vector3.New(0, -390, 150)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10030, var_110_6, var_110_5)
			end

			if arg_107_1.time_ >= var_110_1 + var_110_4 and arg_107_1.time_ < var_110_1 + var_110_4 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_110_7 = arg_107_1.actors_["10030"]
			local var_110_8 = 0

			if var_110_8 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.actorSpriteComps10030 == nil then
				arg_107_1.var_.actorSpriteComps10030 = var_110_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_9 = 0.2

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_9 and not isNil(var_110_7) then
				local var_110_10 = (arg_107_1.time_ - var_110_8) / var_110_9

				if arg_107_1.var_.actorSpriteComps10030 then
					for iter_110_1, iter_110_2 in pairs(arg_107_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_110_2 then
							if arg_107_1.isInRecall_ then
								local var_110_11 = Mathf.Lerp(iter_110_2.color.r, arg_107_1.hightColor1.r, var_110_10)
								local var_110_12 = Mathf.Lerp(iter_110_2.color.g, arg_107_1.hightColor1.g, var_110_10)
								local var_110_13 = Mathf.Lerp(iter_110_2.color.b, arg_107_1.hightColor1.b, var_110_10)

								iter_110_2.color = Color.New(var_110_11, var_110_12, var_110_13)
							else
								local var_110_14 = Mathf.Lerp(iter_110_2.color.r, 1, var_110_10)

								iter_110_2.color = Color.New(var_110_14, var_110_14, var_110_14)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_8 + var_110_9 and arg_107_1.time_ < var_110_8 + var_110_9 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.actorSpriteComps10030 then
				for iter_110_3, iter_110_4 in pairs(arg_107_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_110_4 then
						if arg_107_1.isInRecall_ then
							iter_110_4.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10030 = nil
			end

			local var_110_15 = arg_107_1.actors_["10030"]
			local var_110_16 = 0

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				local var_110_17 = var_110_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_110_17 then
					arg_107_1.var_.alphaOldValue10030 = var_110_17.alpha
					arg_107_1.var_.characterEffect10030 = var_110_17
				end

				arg_107_1.var_.alphaOldValue10030 = 0
			end

			local var_110_18 = 0.333333333333333

			if var_110_16 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_18 then
				local var_110_19 = (arg_107_1.time_ - var_110_16) / var_110_18
				local var_110_20 = Mathf.Lerp(arg_107_1.var_.alphaOldValue10030, 1, var_110_19)

				if arg_107_1.var_.characterEffect10030 then
					arg_107_1.var_.characterEffect10030.alpha = var_110_20
				end
			end

			if arg_107_1.time_ >= var_110_16 + var_110_18 and arg_107_1.time_ < var_110_16 + var_110_18 + arg_110_0 and arg_107_1.var_.characterEffect10030 then
				arg_107_1.var_.characterEffect10030.alpha = 1
			end

			local var_110_21 = 0
			local var_110_22 = 0.65

			if var_110_21 < arg_107_1.time_ and arg_107_1.time_ <= var_110_21 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_23 = arg_107_1:FormatText(StoryNameCfg[309].name)

				arg_107_1.leftNameTxt_.text = var_110_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_24 = arg_107_1:GetWordFromCfg(115301027)
				local var_110_25 = arg_107_1:FormatText(var_110_24.content)

				arg_107_1.text_.text = var_110_25

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_26 = 26
				local var_110_27 = utf8.len(var_110_25)
				local var_110_28 = var_110_26 <= 0 and var_110_22 or var_110_22 * (var_110_27 / var_110_26)

				if var_110_28 > 0 and var_110_22 < var_110_28 then
					arg_107_1.talkMaxDuration = var_110_28

					if var_110_28 + var_110_21 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_28 + var_110_21
					end
				end

				arg_107_1.text_.text = var_110_25
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301027", "story_v_out_115301.awb") ~= 0 then
					local var_110_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301027", "story_v_out_115301.awb") / 1000

					if var_110_29 + var_110_21 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_29 + var_110_21
					end

					if var_110_24.prefab_name ~= "" and arg_107_1.actors_[var_110_24.prefab_name] ~= nil then
						local var_110_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_24.prefab_name].transform, "story_v_out_115301", "115301027", "story_v_out_115301.awb")

						arg_107_1:RecordAudio("115301027", var_110_30)
						arg_107_1:RecordAudio("115301027", var_110_30)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_115301", "115301027", "story_v_out_115301.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_115301", "115301027", "story_v_out_115301.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_31 = math.max(var_110_22, arg_107_1.talkMaxDuration)

			if var_110_21 <= arg_107_1.time_ and arg_107_1.time_ < var_110_21 + var_110_31 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_21) / var_110_31

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_21 + var_110_31 and arg_107_1.time_ < var_110_21 + var_110_31 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115301028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 115301028
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play115301029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10030"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10030 == nil then
				arg_111_1.var_.actorSpriteComps10030 = var_114_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.actorSpriteComps10030 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								local var_114_4 = Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor2.r, var_114_3)
								local var_114_5 = Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor2.g, var_114_3)
								local var_114_6 = Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor2.b, var_114_3)

								iter_114_1.color = Color.New(var_114_4, var_114_5, var_114_6)
							else
								local var_114_7 = Mathf.Lerp(iter_114_1.color.r, 0.5, var_114_3)

								iter_114_1.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10030 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_114_3 then
						if arg_111_1.isInRecall_ then
							iter_114_3.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10030 = nil
			end

			local var_114_8 = 0
			local var_114_9 = 0.5

			if var_114_8 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_10 = arg_111_1:GetWordFromCfg(115301028)
				local var_114_11 = arg_111_1:FormatText(var_114_10.content)

				arg_111_1.text_.text = var_114_11

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_12 = 20
				local var_114_13 = utf8.len(var_114_11)
				local var_114_14 = var_114_12 <= 0 and var_114_9 or var_114_9 * (var_114_13 / var_114_12)

				if var_114_14 > 0 and var_114_9 < var_114_14 then
					arg_111_1.talkMaxDuration = var_114_14

					if var_114_14 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_8
					end
				end

				arg_111_1.text_.text = var_114_11
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_15 = math.max(var_114_9, arg_111_1.talkMaxDuration)

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_15 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_8) / var_114_15

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_8 + var_114_15 and arg_111_1.time_ < var_114_8 + var_114_15 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play115301029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 115301029
		arg_115_1.duration_ = 13.37

		local var_115_0 = {
			ja = 13.366,
			ko = 8.9,
			zh = 11.7,
			en = 9.1
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
				arg_115_0:Play115301030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1038"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1038 = var_118_0.localPosition
				var_118_0.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1038", 2)

				local var_118_2 = var_118_0.childCount

				for iter_118_0 = 0, var_118_2 - 1 do
					local var_118_3 = var_118_0:GetChild(iter_118_0)

					if var_118_3.name == "split_1" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_4 then
				local var_118_5 = (arg_115_1.time_ - var_118_1) / var_118_4
				local var_118_6 = Vector3.New(-390, -400, 0)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1038, var_118_6, var_118_5)
			end

			if arg_115_1.time_ >= var_118_1 + var_118_4 and arg_115_1.time_ < var_118_1 + var_118_4 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_118_7 = arg_115_1.actors_["10030"].transform
			local var_118_8 = 0

			if var_118_8 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.var_.moveOldPos10030 = var_118_7.localPosition
				var_118_7.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10030", 4)

				local var_118_9 = var_118_7.childCount

				for iter_118_1 = 0, var_118_9 - 1 do
					local var_118_10 = var_118_7:GetChild(iter_118_1)

					if var_118_10.name == "split_3" or not string.find(var_118_10.name, "split") then
						var_118_10.gameObject:SetActive(true)
					else
						var_118_10.gameObject:SetActive(false)
					end
				end
			end

			local var_118_11 = 0.001

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_11 then
				local var_118_12 = (arg_115_1.time_ - var_118_8) / var_118_11
				local var_118_13 = Vector3.New(390, -390, 150)

				var_118_7.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10030, var_118_13, var_118_12)
			end

			if arg_115_1.time_ >= var_118_8 + var_118_11 and arg_115_1.time_ < var_118_8 + var_118_11 + arg_118_0 then
				var_118_7.localPosition = Vector3.New(390, -390, 150)
			end

			local var_118_14 = arg_115_1.actors_["1038"]
			local var_118_15 = 0

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				local var_118_16 = var_118_14:GetComponentInChildren(typeof(CanvasGroup))

				if var_118_16 then
					arg_115_1.var_.alphaOldValue1038 = var_118_16.alpha
					arg_115_1.var_.characterEffect1038 = var_118_16
				end

				arg_115_1.var_.alphaOldValue1038 = 0
			end

			local var_118_17 = 0.333333333333333

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_17 then
				local var_118_18 = (arg_115_1.time_ - var_118_15) / var_118_17
				local var_118_19 = Mathf.Lerp(arg_115_1.var_.alphaOldValue1038, 1, var_118_18)

				if arg_115_1.var_.characterEffect1038 then
					arg_115_1.var_.characterEffect1038.alpha = var_118_19
				end
			end

			if arg_115_1.time_ >= var_118_15 + var_118_17 and arg_115_1.time_ < var_118_15 + var_118_17 + arg_118_0 and arg_115_1.var_.characterEffect1038 then
				arg_115_1.var_.characterEffect1038.alpha = 1
			end

			local var_118_20 = arg_115_1.actors_["1038"]
			local var_118_21 = 0

			if var_118_21 < arg_115_1.time_ and arg_115_1.time_ <= var_118_21 + arg_118_0 and not isNil(var_118_20) and arg_115_1.var_.actorSpriteComps1038 == nil then
				arg_115_1.var_.actorSpriteComps1038 = var_118_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_22 = 0.2

			if var_118_21 <= arg_115_1.time_ and arg_115_1.time_ < var_118_21 + var_118_22 and not isNil(var_118_20) then
				local var_118_23 = (arg_115_1.time_ - var_118_21) / var_118_22

				if arg_115_1.var_.actorSpriteComps1038 then
					for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_118_3 then
							if arg_115_1.isInRecall_ then
								local var_118_24 = Mathf.Lerp(iter_118_3.color.r, arg_115_1.hightColor1.r, var_118_23)
								local var_118_25 = Mathf.Lerp(iter_118_3.color.g, arg_115_1.hightColor1.g, var_118_23)
								local var_118_26 = Mathf.Lerp(iter_118_3.color.b, arg_115_1.hightColor1.b, var_118_23)

								iter_118_3.color = Color.New(var_118_24, var_118_25, var_118_26)
							else
								local var_118_27 = Mathf.Lerp(iter_118_3.color.r, 1, var_118_23)

								iter_118_3.color = Color.New(var_118_27, var_118_27, var_118_27)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_21 + var_118_22 and arg_115_1.time_ < var_118_21 + var_118_22 + arg_118_0 and not isNil(var_118_20) and arg_115_1.var_.actorSpriteComps1038 then
				for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_118_5 then
						if arg_115_1.isInRecall_ then
							iter_118_5.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1038 = nil
			end

			local var_118_28 = 0
			local var_118_29 = 1.125

			if var_118_28 < arg_115_1.time_ and arg_115_1.time_ <= var_118_28 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_30 = arg_115_1:FormatText(StoryNameCfg[94].name)

				arg_115_1.leftNameTxt_.text = var_118_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_31 = arg_115_1:GetWordFromCfg(115301029)
				local var_118_32 = arg_115_1:FormatText(var_118_31.content)

				arg_115_1.text_.text = var_118_32

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_33 = 45
				local var_118_34 = utf8.len(var_118_32)
				local var_118_35 = var_118_33 <= 0 and var_118_29 or var_118_29 * (var_118_34 / var_118_33)

				if var_118_35 > 0 and var_118_29 < var_118_35 then
					arg_115_1.talkMaxDuration = var_118_35

					if var_118_35 + var_118_28 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_35 + var_118_28
					end
				end

				arg_115_1.text_.text = var_118_32
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301029", "story_v_out_115301.awb") ~= 0 then
					local var_118_36 = manager.audio:GetVoiceLength("story_v_out_115301", "115301029", "story_v_out_115301.awb") / 1000

					if var_118_36 + var_118_28 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_36 + var_118_28
					end

					if var_118_31.prefab_name ~= "" and arg_115_1.actors_[var_118_31.prefab_name] ~= nil then
						local var_118_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_31.prefab_name].transform, "story_v_out_115301", "115301029", "story_v_out_115301.awb")

						arg_115_1:RecordAudio("115301029", var_118_37)
						arg_115_1:RecordAudio("115301029", var_118_37)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_115301", "115301029", "story_v_out_115301.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_115301", "115301029", "story_v_out_115301.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_38 = math.max(var_118_29, arg_115_1.talkMaxDuration)

			if var_118_28 <= arg_115_1.time_ and arg_115_1.time_ < var_118_28 + var_118_38 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_28) / var_118_38

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_28 + var_118_38 and arg_115_1.time_ < var_118_28 + var_118_38 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10030",
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
	Play115301030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 115301030
		arg_119_1.duration_ = 16.6

		local var_119_0 = {
			ja = 16.6,
			ko = 12.066,
			zh = 12.6,
			en = 10.333
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
				arg_119_0:Play115301031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1038"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1038 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1038", 2)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "split_9" or not string.find(var_122_3.name, "split") then
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

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1038, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_122_7 = 0
			local var_122_8 = 1.1

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_9 = arg_119_1:FormatText(StoryNameCfg[94].name)

				arg_119_1.leftNameTxt_.text = var_122_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(115301030)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_12 = 44
				local var_122_13 = utf8.len(var_122_11)
				local var_122_14 = var_122_12 <= 0 and var_122_8 or var_122_8 * (var_122_13 / var_122_12)

				if var_122_14 > 0 and var_122_8 < var_122_14 then
					arg_119_1.talkMaxDuration = var_122_14

					if var_122_14 + var_122_7 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_7
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301030", "story_v_out_115301.awb") ~= 0 then
					local var_122_15 = manager.audio:GetVoiceLength("story_v_out_115301", "115301030", "story_v_out_115301.awb") / 1000

					if var_122_15 + var_122_7 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_15 + var_122_7
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_115301", "115301030", "story_v_out_115301.awb")

						arg_119_1:RecordAudio("115301030", var_122_16)
						arg_119_1:RecordAudio("115301030", var_122_16)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_115301", "115301030", "story_v_out_115301.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_115301", "115301030", "story_v_out_115301.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_17 = math.max(var_122_8, arg_119_1.talkMaxDuration)

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_17 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_7) / var_122_17

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_7 + var_122_17 and arg_119_1.time_ < var_122_7 + var_122_17 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
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
	Play115301031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 115301031
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play115301032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1038"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps1038 == nil then
				arg_123_1.var_.actorSpriteComps1038 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps1038 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								local var_126_4 = Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, var_126_3)
								local var_126_5 = Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, var_126_3)
								local var_126_6 = Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, var_126_3)

								iter_126_1.color = Color.New(var_126_4, var_126_5, var_126_6)
							else
								local var_126_7 = Mathf.Lerp(iter_126_1.color.r, 0.5, var_126_3)

								iter_126_1.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps1038 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps1038 = nil
			end

			local var_126_8 = 0
			local var_126_9 = 0.775

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(115301031)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_12 = 31
				local var_126_13 = utf8.len(var_126_11)
				local var_126_14 = var_126_12 <= 0 and var_126_9 or var_126_9 * (var_126_13 / var_126_12)

				if var_126_14 > 0 and var_126_9 < var_126_14 then
					arg_123_1.talkMaxDuration = var_126_14

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_15 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_15 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_15

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_15 and arg_123_1.time_ < var_126_8 + var_126_15 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play115301032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 115301032
		arg_127_1.duration_ = 3.93

		local var_127_0 = {
			ja = 3.3,
			ko = 3.933,
			zh = 3.133,
			en = 3.433
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
				arg_127_0:Play115301033(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10030"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos10030 = var_130_0.localPosition
				var_130_0.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10030", 4)

				local var_130_2 = var_130_0.childCount

				for iter_130_0 = 0, var_130_2 - 1 do
					local var_130_3 = var_130_0:GetChild(iter_130_0)

					if var_130_3.name == "split_5" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_4 then
				local var_130_5 = (arg_127_1.time_ - var_130_1) / var_130_4
				local var_130_6 = Vector3.New(390, -390, 150)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10030, var_130_6, var_130_5)
			end

			if arg_127_1.time_ >= var_130_1 + var_130_4 and arg_127_1.time_ < var_130_1 + var_130_4 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_130_7 = arg_127_1.actors_["10030"]
			local var_130_8 = 0

			if var_130_8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.actorSpriteComps10030 == nil then
				arg_127_1.var_.actorSpriteComps10030 = var_130_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_9 = 0.2

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_9 and not isNil(var_130_7) then
				local var_130_10 = (arg_127_1.time_ - var_130_8) / var_130_9

				if arg_127_1.var_.actorSpriteComps10030 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								local var_130_11 = Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor1.r, var_130_10)
								local var_130_12 = Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor1.g, var_130_10)
								local var_130_13 = Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor1.b, var_130_10)

								iter_130_2.color = Color.New(var_130_11, var_130_12, var_130_13)
							else
								local var_130_14 = Mathf.Lerp(iter_130_2.color.r, 1, var_130_10)

								iter_130_2.color = Color.New(var_130_14, var_130_14, var_130_14)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_8 + var_130_9 and arg_127_1.time_ < var_130_8 + var_130_9 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.actorSpriteComps10030 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_130_4 then
						if arg_127_1.isInRecall_ then
							iter_130_4.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10030 = nil
			end

			local var_130_15 = arg_127_1.actors_["10030"]
			local var_130_16 = 0

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				local var_130_17 = var_130_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_130_17 then
					arg_127_1.var_.alphaOldValue10030 = var_130_17.alpha
					arg_127_1.var_.characterEffect10030 = var_130_17
				end

				arg_127_1.var_.alphaOldValue10030 = 0
			end

			local var_130_18 = 0.0166666666666667

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_18 then
				local var_130_19 = (arg_127_1.time_ - var_130_16) / var_130_18
				local var_130_20 = Mathf.Lerp(arg_127_1.var_.alphaOldValue10030, 1, var_130_19)

				if arg_127_1.var_.characterEffect10030 then
					arg_127_1.var_.characterEffect10030.alpha = var_130_20
				end
			end

			if arg_127_1.time_ >= var_130_16 + var_130_18 and arg_127_1.time_ < var_130_16 + var_130_18 + arg_130_0 and arg_127_1.var_.characterEffect10030 then
				arg_127_1.var_.characterEffect10030.alpha = 1
			end

			local var_130_21 = 0
			local var_130_22 = 0.475

			if var_130_21 < arg_127_1.time_ and arg_127_1.time_ <= var_130_21 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_23 = arg_127_1:FormatText(StoryNameCfg[309].name)

				arg_127_1.leftNameTxt_.text = var_130_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_24 = arg_127_1:GetWordFromCfg(115301032)
				local var_130_25 = arg_127_1:FormatText(var_130_24.content)

				arg_127_1.text_.text = var_130_25

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_26 = 19
				local var_130_27 = utf8.len(var_130_25)
				local var_130_28 = var_130_26 <= 0 and var_130_22 or var_130_22 * (var_130_27 / var_130_26)

				if var_130_28 > 0 and var_130_22 < var_130_28 then
					arg_127_1.talkMaxDuration = var_130_28

					if var_130_28 + var_130_21 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_28 + var_130_21
					end
				end

				arg_127_1.text_.text = var_130_25
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301032", "story_v_out_115301.awb") ~= 0 then
					local var_130_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301032", "story_v_out_115301.awb") / 1000

					if var_130_29 + var_130_21 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_29 + var_130_21
					end

					if var_130_24.prefab_name ~= "" and arg_127_1.actors_[var_130_24.prefab_name] ~= nil then
						local var_130_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_24.prefab_name].transform, "story_v_out_115301", "115301032", "story_v_out_115301.awb")

						arg_127_1:RecordAudio("115301032", var_130_30)
						arg_127_1:RecordAudio("115301032", var_130_30)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_115301", "115301032", "story_v_out_115301.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_115301", "115301032", "story_v_out_115301.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_31 = math.max(var_130_22, arg_127_1.talkMaxDuration)

			if var_130_21 <= arg_127_1.time_ and arg_127_1.time_ < var_130_21 + var_130_31 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_21) / var_130_31

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_21 + var_130_31 and arg_127_1.time_ < var_130_21 + var_130_31 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115301033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 115301033
		arg_131_1.duration_ = 6.6

		local var_131_0 = {
			ja = 4.633,
			ko = 6.6,
			zh = 6.366,
			en = 6.266
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
				arg_131_0:Play115301034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10030"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos10030 = var_134_0.localPosition
				var_134_0.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10030", 4)

				local var_134_2 = var_134_0.childCount

				for iter_134_0 = 0, var_134_2 - 1 do
					local var_134_3 = var_134_0:GetChild(iter_134_0)

					if var_134_3.name == "split_5" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_4 then
				local var_134_5 = (arg_131_1.time_ - var_134_1) / var_134_4
				local var_134_6 = Vector3.New(390, -390, 150)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10030, var_134_6, var_134_5)
			end

			if arg_131_1.time_ >= var_134_1 + var_134_4 and arg_131_1.time_ < var_134_1 + var_134_4 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_134_7 = 0
			local var_134_8 = 0.65

			if var_134_7 < arg_131_1.time_ and arg_131_1.time_ <= var_134_7 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_9 = arg_131_1:FormatText(StoryNameCfg[309].name)

				arg_131_1.leftNameTxt_.text = var_134_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(115301033)
				local var_134_11 = arg_131_1:FormatText(var_134_10.content)

				arg_131_1.text_.text = var_134_11

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_12 = 26
				local var_134_13 = utf8.len(var_134_11)
				local var_134_14 = var_134_12 <= 0 and var_134_8 or var_134_8 * (var_134_13 / var_134_12)

				if var_134_14 > 0 and var_134_8 < var_134_14 then
					arg_131_1.talkMaxDuration = var_134_14

					if var_134_14 + var_134_7 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_7
					end
				end

				arg_131_1.text_.text = var_134_11
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301033", "story_v_out_115301.awb") ~= 0 then
					local var_134_15 = manager.audio:GetVoiceLength("story_v_out_115301", "115301033", "story_v_out_115301.awb") / 1000

					if var_134_15 + var_134_7 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_15 + var_134_7
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_115301", "115301033", "story_v_out_115301.awb")

						arg_131_1:RecordAudio("115301033", var_134_16)
						arg_131_1:RecordAudio("115301033", var_134_16)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_115301", "115301033", "story_v_out_115301.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_115301", "115301033", "story_v_out_115301.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_17 = math.max(var_134_8, arg_131_1.talkMaxDuration)

			if var_134_7 <= arg_131_1.time_ and arg_131_1.time_ < var_134_7 + var_134_17 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_7) / var_134_17

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_7 + var_134_17 and arg_131_1.time_ < var_134_7 + var_134_17 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115301034 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 115301034
		arg_135_1.duration_ = 6.73

		local var_135_0 = {
			ja = 6.733,
			ko = 4.166,
			zh = 5.366,
			en = 4
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
				arg_135_0:Play115301035(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1038"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1038 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1038", 2)

				local var_138_2 = var_138_0.childCount

				for iter_138_0 = 0, var_138_2 - 1 do
					local var_138_3 = var_138_0:GetChild(iter_138_0)

					if var_138_3.name == "split_1" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_4 then
				local var_138_5 = (arg_135_1.time_ - var_138_1) / var_138_4
				local var_138_6 = Vector3.New(-390, -400, 0)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1038, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_138_7 = arg_135_1.actors_["10030"]
			local var_138_8 = 0

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10030 == nil then
				arg_135_1.var_.actorSpriteComps10030 = var_138_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 0.2

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_9 and not isNil(var_138_7) then
				local var_138_10 = (arg_135_1.time_ - var_138_8) / var_138_9

				if arg_135_1.var_.actorSpriteComps10030 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								local var_138_11 = Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor2.r, var_138_10)
								local var_138_12 = Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor2.g, var_138_10)
								local var_138_13 = Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor2.b, var_138_10)

								iter_138_2.color = Color.New(var_138_11, var_138_12, var_138_13)
							else
								local var_138_14 = Mathf.Lerp(iter_138_2.color.r, 0.5, var_138_10)

								iter_138_2.color = Color.New(var_138_14, var_138_14, var_138_14)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_8 + var_138_9 and arg_135_1.time_ < var_138_8 + var_138_9 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10030 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_138_4 then
						if arg_135_1.isInRecall_ then
							iter_138_4.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10030 = nil
			end

			local var_138_15 = 0
			local var_138_16 = 0.55

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_17 = arg_135_1:FormatText(StoryNameCfg[94].name)

				arg_135_1.leftNameTxt_.text = var_138_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_18 = arg_135_1:GetWordFromCfg(115301034)
				local var_138_19 = arg_135_1:FormatText(var_138_18.content)

				arg_135_1.text_.text = var_138_19

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_20 = 22
				local var_138_21 = utf8.len(var_138_19)
				local var_138_22 = var_138_20 <= 0 and var_138_16 or var_138_16 * (var_138_21 / var_138_20)

				if var_138_22 > 0 and var_138_16 < var_138_22 then
					arg_135_1.talkMaxDuration = var_138_22

					if var_138_22 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_22 + var_138_15
					end
				end

				arg_135_1.text_.text = var_138_19
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301034", "story_v_out_115301.awb") ~= 0 then
					local var_138_23 = manager.audio:GetVoiceLength("story_v_out_115301", "115301034", "story_v_out_115301.awb") / 1000

					if var_138_23 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_23 + var_138_15
					end

					if var_138_18.prefab_name ~= "" and arg_135_1.actors_[var_138_18.prefab_name] ~= nil then
						local var_138_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_18.prefab_name].transform, "story_v_out_115301", "115301034", "story_v_out_115301.awb")

						arg_135_1:RecordAudio("115301034", var_138_24)
						arg_135_1:RecordAudio("115301034", var_138_24)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_115301", "115301034", "story_v_out_115301.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_115301", "115301034", "story_v_out_115301.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_25 = math.max(var_138_16, arg_135_1.talkMaxDuration)

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_25 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_15) / var_138_25

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_15 + var_138_25 and arg_135_1.time_ < var_138_15 + var_138_25 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play115301035 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115301035
		arg_139_1.duration_ = 4.17

		local var_139_0 = {
			ja = 2.3,
			ko = 4.166,
			zh = 2.3,
			en = 1.533
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
				arg_139_0:Play115301036(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10030"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10030 == nil then
				arg_139_1.var_.actorSpriteComps10030 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps10030 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10030:ToTable()) do
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

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10030 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10030 = nil
			end

			local var_142_8 = arg_139_1.actors_["1038"]
			local var_142_9 = 0

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps1038 == nil then
				arg_139_1.var_.actorSpriteComps1038 = var_142_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_10 = 0.2

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_10 and not isNil(var_142_8) then
				local var_142_11 = (arg_139_1.time_ - var_142_9) / var_142_10

				if arg_139_1.var_.actorSpriteComps1038 then
					for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_142_5 then
							if arg_139_1.isInRecall_ then
								local var_142_12 = Mathf.Lerp(iter_142_5.color.r, arg_139_1.hightColor2.r, var_142_11)
								local var_142_13 = Mathf.Lerp(iter_142_5.color.g, arg_139_1.hightColor2.g, var_142_11)
								local var_142_14 = Mathf.Lerp(iter_142_5.color.b, arg_139_1.hightColor2.b, var_142_11)

								iter_142_5.color = Color.New(var_142_12, var_142_13, var_142_14)
							else
								local var_142_15 = Mathf.Lerp(iter_142_5.color.r, 0.5, var_142_11)

								iter_142_5.color = Color.New(var_142_15, var_142_15, var_142_15)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_9 + var_142_10 and arg_139_1.time_ < var_142_9 + var_142_10 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps1038 then
				for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_142_7 then
						if arg_139_1.isInRecall_ then
							iter_142_7.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps1038 = nil
			end

			local var_142_16 = arg_139_1.actors_["10030"].transform
			local var_142_17 = 0

			if var_142_17 < arg_139_1.time_ and arg_139_1.time_ <= var_142_17 + arg_142_0 then
				arg_139_1.var_.moveOldPos10030 = var_142_16.localPosition
				var_142_16.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10030", 4)

				local var_142_18 = var_142_16.childCount

				for iter_142_8 = 0, var_142_18 - 1 do
					local var_142_19 = var_142_16:GetChild(iter_142_8)

					if var_142_19.name == "split_1" or not string.find(var_142_19.name, "split") then
						var_142_19.gameObject:SetActive(true)
					else
						var_142_19.gameObject:SetActive(false)
					end
				end
			end

			local var_142_20 = 0.001

			if var_142_17 <= arg_139_1.time_ and arg_139_1.time_ < var_142_17 + var_142_20 then
				local var_142_21 = (arg_139_1.time_ - var_142_17) / var_142_20
				local var_142_22 = Vector3.New(390, -390, 150)

				var_142_16.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10030, var_142_22, var_142_21)
			end

			if arg_139_1.time_ >= var_142_17 + var_142_20 and arg_139_1.time_ < var_142_17 + var_142_20 + arg_142_0 then
				var_142_16.localPosition = Vector3.New(390, -390, 150)
			end

			local var_142_23 = arg_139_1.actors_["10030"]
			local var_142_24 = 0

			if var_142_24 < arg_139_1.time_ and arg_139_1.time_ <= var_142_24 + arg_142_0 then
				local var_142_25 = var_142_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_142_25 then
					arg_139_1.var_.alphaOldValue10030 = var_142_25.alpha
					arg_139_1.var_.characterEffect10030 = var_142_25
				end

				arg_139_1.var_.alphaOldValue10030 = 0
			end

			local var_142_26 = 0.0166666666666667

			if var_142_24 <= arg_139_1.time_ and arg_139_1.time_ < var_142_24 + var_142_26 then
				local var_142_27 = (arg_139_1.time_ - var_142_24) / var_142_26
				local var_142_28 = Mathf.Lerp(arg_139_1.var_.alphaOldValue10030, 1, var_142_27)

				if arg_139_1.var_.characterEffect10030 then
					arg_139_1.var_.characterEffect10030.alpha = var_142_28
				end
			end

			if arg_139_1.time_ >= var_142_24 + var_142_26 and arg_139_1.time_ < var_142_24 + var_142_26 + arg_142_0 and arg_139_1.var_.characterEffect10030 then
				arg_139_1.var_.characterEffect10030.alpha = 1
			end

			local var_142_29 = 0
			local var_142_30 = 0.3

			if var_142_29 < arg_139_1.time_ and arg_139_1.time_ <= var_142_29 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_31 = arg_139_1:FormatText(StoryNameCfg[309].name)

				arg_139_1.leftNameTxt_.text = var_142_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_32 = arg_139_1:GetWordFromCfg(115301035)
				local var_142_33 = arg_139_1:FormatText(var_142_32.content)

				arg_139_1.text_.text = var_142_33

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_34 = 12
				local var_142_35 = utf8.len(var_142_33)
				local var_142_36 = var_142_34 <= 0 and var_142_30 or var_142_30 * (var_142_35 / var_142_34)

				if var_142_36 > 0 and var_142_30 < var_142_36 then
					arg_139_1.talkMaxDuration = var_142_36

					if var_142_36 + var_142_29 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_36 + var_142_29
					end
				end

				arg_139_1.text_.text = var_142_33
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301035", "story_v_out_115301.awb") ~= 0 then
					local var_142_37 = manager.audio:GetVoiceLength("story_v_out_115301", "115301035", "story_v_out_115301.awb") / 1000

					if var_142_37 + var_142_29 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_37 + var_142_29
					end

					if var_142_32.prefab_name ~= "" and arg_139_1.actors_[var_142_32.prefab_name] ~= nil then
						local var_142_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_32.prefab_name].transform, "story_v_out_115301", "115301035", "story_v_out_115301.awb")

						arg_139_1:RecordAudio("115301035", var_142_38)
						arg_139_1:RecordAudio("115301035", var_142_38)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_115301", "115301035", "story_v_out_115301.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_115301", "115301035", "story_v_out_115301.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_39 = math.max(var_142_30, arg_139_1.talkMaxDuration)

			if var_142_29 <= arg_139_1.time_ and arg_139_1.time_ < var_142_29 + var_142_39 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_29) / var_142_39

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_29 + var_142_39 and arg_139_1.time_ < var_142_29 + var_142_39 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play115301036 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115301036
		arg_143_1.duration_ = 9.03

		local var_143_0 = {
			ja = 8.5,
			ko = 8.366,
			zh = 9.033,
			en = 7.733
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
				arg_143_0:Play115301037(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10030"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps10030 == nil then
				arg_143_1.var_.actorSpriteComps10030 = var_146_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_2 = 0.2

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.actorSpriteComps10030 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								local var_146_4 = Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor2.r, var_146_3)
								local var_146_5 = Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor2.g, var_146_3)
								local var_146_6 = Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor2.b, var_146_3)

								iter_146_1.color = Color.New(var_146_4, var_146_5, var_146_6)
							else
								local var_146_7 = Mathf.Lerp(iter_146_1.color.r, 0.5, var_146_3)

								iter_146_1.color = Color.New(var_146_7, var_146_7, var_146_7)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps10030 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_146_3 then
						if arg_143_1.isInRecall_ then
							iter_146_3.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10030 = nil
			end

			local var_146_8 = arg_143_1.actors_["1038"]
			local var_146_9 = 0

			if var_146_9 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps1038 == nil then
				arg_143_1.var_.actorSpriteComps1038 = var_146_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_10 = 0.2

			if var_146_9 <= arg_143_1.time_ and arg_143_1.time_ < var_146_9 + var_146_10 and not isNil(var_146_8) then
				local var_146_11 = (arg_143_1.time_ - var_146_9) / var_146_10

				if arg_143_1.var_.actorSpriteComps1038 then
					for iter_146_4, iter_146_5 in pairs(arg_143_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_146_5 then
							if arg_143_1.isInRecall_ then
								local var_146_12 = Mathf.Lerp(iter_146_5.color.r, arg_143_1.hightColor1.r, var_146_11)
								local var_146_13 = Mathf.Lerp(iter_146_5.color.g, arg_143_1.hightColor1.g, var_146_11)
								local var_146_14 = Mathf.Lerp(iter_146_5.color.b, arg_143_1.hightColor1.b, var_146_11)

								iter_146_5.color = Color.New(var_146_12, var_146_13, var_146_14)
							else
								local var_146_15 = Mathf.Lerp(iter_146_5.color.r, 1, var_146_11)

								iter_146_5.color = Color.New(var_146_15, var_146_15, var_146_15)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_9 + var_146_10 and arg_143_1.time_ < var_146_9 + var_146_10 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps1038 then
				for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_146_7 then
						if arg_143_1.isInRecall_ then
							iter_146_7.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps1038 = nil
			end

			local var_146_16 = arg_143_1.actors_["1038"].transform
			local var_146_17 = 0

			if var_146_17 < arg_143_1.time_ and arg_143_1.time_ <= var_146_17 + arg_146_0 then
				arg_143_1.var_.moveOldPos1038 = var_146_16.localPosition
				var_146_16.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1038", 2)

				local var_146_18 = var_146_16.childCount

				for iter_146_8 = 0, var_146_18 - 1 do
					local var_146_19 = var_146_16:GetChild(iter_146_8)

					if var_146_19.name == "split_9" or not string.find(var_146_19.name, "split") then
						var_146_19.gameObject:SetActive(true)
					else
						var_146_19.gameObject:SetActive(false)
					end
				end
			end

			local var_146_20 = 0.001

			if var_146_17 <= arg_143_1.time_ and arg_143_1.time_ < var_146_17 + var_146_20 then
				local var_146_21 = (arg_143_1.time_ - var_146_17) / var_146_20
				local var_146_22 = Vector3.New(-390, -400, 0)

				var_146_16.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1038, var_146_22, var_146_21)
			end

			if arg_143_1.time_ >= var_146_17 + var_146_20 and arg_143_1.time_ < var_146_17 + var_146_20 + arg_146_0 then
				var_146_16.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_146_23 = 0
			local var_146_24 = 0.825

			if var_146_23 < arg_143_1.time_ and arg_143_1.time_ <= var_146_23 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_25 = arg_143_1:FormatText(StoryNameCfg[94].name)

				arg_143_1.leftNameTxt_.text = var_146_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_26 = arg_143_1:GetWordFromCfg(115301036)
				local var_146_27 = arg_143_1:FormatText(var_146_26.content)

				arg_143_1.text_.text = var_146_27

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_28 = 33
				local var_146_29 = utf8.len(var_146_27)
				local var_146_30 = var_146_28 <= 0 and var_146_24 or var_146_24 * (var_146_29 / var_146_28)

				if var_146_30 > 0 and var_146_24 < var_146_30 then
					arg_143_1.talkMaxDuration = var_146_30

					if var_146_30 + var_146_23 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_30 + var_146_23
					end
				end

				arg_143_1.text_.text = var_146_27
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301036", "story_v_out_115301.awb") ~= 0 then
					local var_146_31 = manager.audio:GetVoiceLength("story_v_out_115301", "115301036", "story_v_out_115301.awb") / 1000

					if var_146_31 + var_146_23 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_31 + var_146_23
					end

					if var_146_26.prefab_name ~= "" and arg_143_1.actors_[var_146_26.prefab_name] ~= nil then
						local var_146_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_26.prefab_name].transform, "story_v_out_115301", "115301036", "story_v_out_115301.awb")

						arg_143_1:RecordAudio("115301036", var_146_32)
						arg_143_1:RecordAudio("115301036", var_146_32)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_115301", "115301036", "story_v_out_115301.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_115301", "115301036", "story_v_out_115301.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_33 = math.max(var_146_24, arg_143_1.talkMaxDuration)

			if var_146_23 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_33 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_23) / var_146_33

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_23 + var_146_33 and arg_143_1.time_ < var_146_23 + var_146_33 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
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
	Play115301037 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115301037
		arg_147_1.duration_ = 16.63

		local var_147_0 = {
			ja = 16.633,
			ko = 10.733,
			zh = 14.666,
			en = 13.8
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
				arg_147_0:Play115301038(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.3

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[94].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(115301037)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 52
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301037", "story_v_out_115301.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301037", "story_v_out_115301.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_115301", "115301037", "story_v_out_115301.awb")

						arg_147_1:RecordAudio("115301037", var_150_9)
						arg_147_1:RecordAudio("115301037", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_115301", "115301037", "story_v_out_115301.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_115301", "115301037", "story_v_out_115301.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play115301038 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115301038
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play115301039(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10030"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				local var_154_2 = var_154_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_154_2 then
					arg_151_1.var_.alphaOldValue10030 = var_154_2.alpha
					arg_151_1.var_.characterEffect10030 = var_154_2
				end

				arg_151_1.var_.alphaOldValue10030 = 1
			end

			local var_154_3 = 0.333333333333333

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_3 then
				local var_154_4 = (arg_151_1.time_ - var_154_1) / var_154_3
				local var_154_5 = Mathf.Lerp(arg_151_1.var_.alphaOldValue10030, 0, var_154_4)

				if arg_151_1.var_.characterEffect10030 then
					arg_151_1.var_.characterEffect10030.alpha = var_154_5
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_3 and arg_151_1.time_ < var_154_1 + var_154_3 + arg_154_0 and arg_151_1.var_.characterEffect10030 then
				arg_151_1.var_.characterEffect10030.alpha = 0
			end

			local var_154_6 = arg_151_1.actors_["1038"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 then
				local var_154_8 = var_154_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_154_8 then
					arg_151_1.var_.alphaOldValue1038 = var_154_8.alpha
					arg_151_1.var_.characterEffect1038 = var_154_8
				end

				arg_151_1.var_.alphaOldValue1038 = 1
			end

			local var_154_9 = 0.333333333333333

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_9 then
				local var_154_10 = (arg_151_1.time_ - var_154_7) / var_154_9
				local var_154_11 = Mathf.Lerp(arg_151_1.var_.alphaOldValue1038, 0, var_154_10)

				if arg_151_1.var_.characterEffect1038 then
					arg_151_1.var_.characterEffect1038.alpha = var_154_11
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_9 and arg_151_1.time_ < var_154_7 + var_154_9 + arg_154_0 and arg_151_1.var_.characterEffect1038 then
				arg_151_1.var_.characterEffect1038.alpha = 0
			end

			local var_154_12 = 0
			local var_154_13 = 0.825

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_14 = arg_151_1:GetWordFromCfg(115301038)
				local var_154_15 = arg_151_1:FormatText(var_154_14.content)

				arg_151_1.text_.text = var_154_15

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_16 = 33
				local var_154_17 = utf8.len(var_154_15)
				local var_154_18 = var_154_16 <= 0 and var_154_13 or var_154_13 * (var_154_17 / var_154_16)

				if var_154_18 > 0 and var_154_13 < var_154_18 then
					arg_151_1.talkMaxDuration = var_154_18

					if var_154_18 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_18 + var_154_12
					end
				end

				arg_151_1.text_.text = var_154_15
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_19 = math.max(var_154_13, arg_151_1.talkMaxDuration)

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_19 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_12) / var_154_19

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_12 + var_154_19 and arg_151_1.time_ < var_154_12 + var_154_19 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play115301039 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115301039
		arg_155_1.duration_ = 11.27

		local var_155_0 = {
			ja = 11.266,
			ko = 10.866,
			zh = 9.533,
			en = 9.1
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
				arg_155_0:Play115301040(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10030"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10030 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10030", 3)

				local var_158_2 = var_158_0.childCount

				for iter_158_0 = 0, var_158_2 - 1 do
					local var_158_3 = var_158_0:GetChild(iter_158_0)

					if var_158_3.name == "split_3" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_4 then
				local var_158_5 = (arg_155_1.time_ - var_158_1) / var_158_4
				local var_158_6 = Vector3.New(0, -390, 150)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10030, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_158_7 = arg_155_1.actors_["10030"]
			local var_158_8 = 0

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10030 == nil then
				arg_155_1.var_.actorSpriteComps10030 = var_158_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 0.2

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 and not isNil(var_158_7) then
				local var_158_10 = (arg_155_1.time_ - var_158_8) / var_158_9

				if arg_155_1.var_.actorSpriteComps10030 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								local var_158_11 = Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, var_158_10)
								local var_158_12 = Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, var_158_10)
								local var_158_13 = Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, var_158_10)

								iter_158_2.color = Color.New(var_158_11, var_158_12, var_158_13)
							else
								local var_158_14 = Mathf.Lerp(iter_158_2.color.r, 1, var_158_10)

								iter_158_2.color = Color.New(var_158_14, var_158_14, var_158_14)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10030 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_158_4 then
						if arg_155_1.isInRecall_ then
							iter_158_4.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10030 = nil
			end

			local var_158_15 = arg_155_1.actors_["10030"]
			local var_158_16 = 0

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 then
				local var_158_17 = var_158_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_158_17 then
					arg_155_1.var_.alphaOldValue10030 = var_158_17.alpha
					arg_155_1.var_.characterEffect10030 = var_158_17
				end

				arg_155_1.var_.alphaOldValue10030 = 0
			end

			local var_158_18 = 0.333333333333333

			if var_158_16 <= arg_155_1.time_ and arg_155_1.time_ < var_158_16 + var_158_18 then
				local var_158_19 = (arg_155_1.time_ - var_158_16) / var_158_18
				local var_158_20 = Mathf.Lerp(arg_155_1.var_.alphaOldValue10030, 1, var_158_19)

				if arg_155_1.var_.characterEffect10030 then
					arg_155_1.var_.characterEffect10030.alpha = var_158_20
				end
			end

			if arg_155_1.time_ >= var_158_16 + var_158_18 and arg_155_1.time_ < var_158_16 + var_158_18 + arg_158_0 and arg_155_1.var_.characterEffect10030 then
				arg_155_1.var_.characterEffect10030.alpha = 1
			end

			local var_158_21 = 0
			local var_158_22 = 1.025

			if var_158_21 < arg_155_1.time_ and arg_155_1.time_ <= var_158_21 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_23 = arg_155_1:FormatText(StoryNameCfg[309].name)

				arg_155_1.leftNameTxt_.text = var_158_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_24 = arg_155_1:GetWordFromCfg(115301039)
				local var_158_25 = arg_155_1:FormatText(var_158_24.content)

				arg_155_1.text_.text = var_158_25

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_26 = 41
				local var_158_27 = utf8.len(var_158_25)
				local var_158_28 = var_158_26 <= 0 and var_158_22 or var_158_22 * (var_158_27 / var_158_26)

				if var_158_28 > 0 and var_158_22 < var_158_28 then
					arg_155_1.talkMaxDuration = var_158_28

					if var_158_28 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_28 + var_158_21
					end
				end

				arg_155_1.text_.text = var_158_25
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301039", "story_v_out_115301.awb") ~= 0 then
					local var_158_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301039", "story_v_out_115301.awb") / 1000

					if var_158_29 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_29 + var_158_21
					end

					if var_158_24.prefab_name ~= "" and arg_155_1.actors_[var_158_24.prefab_name] ~= nil then
						local var_158_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_24.prefab_name].transform, "story_v_out_115301", "115301039", "story_v_out_115301.awb")

						arg_155_1:RecordAudio("115301039", var_158_30)
						arg_155_1:RecordAudio("115301039", var_158_30)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_115301", "115301039", "story_v_out_115301.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_115301", "115301039", "story_v_out_115301.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_31 = math.max(var_158_22, arg_155_1.talkMaxDuration)

			if var_158_21 <= arg_155_1.time_ and arg_155_1.time_ < var_158_21 + var_158_31 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_21) / var_158_31

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_21 + var_158_31 and arg_155_1.time_ < var_158_21 + var_158_31 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115301040 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115301040
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play115301041(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10030"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				local var_162_2 = var_162_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_162_2 then
					arg_159_1.var_.alphaOldValue10030 = var_162_2.alpha
					arg_159_1.var_.characterEffect10030 = var_162_2
				end

				arg_159_1.var_.alphaOldValue10030 = 1
			end

			local var_162_3 = 0.333333333333333

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_3 then
				local var_162_4 = (arg_159_1.time_ - var_162_1) / var_162_3
				local var_162_5 = Mathf.Lerp(arg_159_1.var_.alphaOldValue10030, 0, var_162_4)

				if arg_159_1.var_.characterEffect10030 then
					arg_159_1.var_.characterEffect10030.alpha = var_162_5
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_3 and arg_159_1.time_ < var_162_1 + var_162_3 + arg_162_0 and arg_159_1.var_.characterEffect10030 then
				arg_159_1.var_.characterEffect10030.alpha = 0
			end

			local var_162_6 = 0
			local var_162_7 = 1.175

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(115301040)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 47
				local var_162_11 = utf8.len(var_162_9)
				local var_162_12 = var_162_10 <= 0 and var_162_7 or var_162_7 * (var_162_11 / var_162_10)

				if var_162_12 > 0 and var_162_7 < var_162_12 then
					arg_159_1.talkMaxDuration = var_162_12

					if var_162_12 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_13 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_13 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_13

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_13 and arg_159_1.time_ < var_162_6 + var_162_13 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115301041 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115301041
		arg_163_1.duration_ = 4.9

		local var_163_0 = {
			ja = 4.233,
			ko = 4.9,
			zh = 3.433,
			en = 4.1
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
				arg_163_0:Play115301042(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10030"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10030 = var_166_0.localPosition
				var_166_0.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10030", 4)

				local var_166_2 = var_166_0.childCount

				for iter_166_0 = 0, var_166_2 - 1 do
					local var_166_3 = var_166_0:GetChild(iter_166_0)

					if var_166_3.name == "split_5" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_4 then
				local var_166_5 = (arg_163_1.time_ - var_166_1) / var_166_4
				local var_166_6 = Vector3.New(390, -390, 150)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10030, var_166_6, var_166_5)
			end

			if arg_163_1.time_ >= var_166_1 + var_166_4 and arg_163_1.time_ < var_166_1 + var_166_4 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_166_7 = arg_163_1.actors_["10030"]
			local var_166_8 = 0

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				local var_166_9 = var_166_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_166_9 then
					arg_163_1.var_.alphaOldValue10030 = var_166_9.alpha
					arg_163_1.var_.characterEffect10030 = var_166_9
				end

				arg_163_1.var_.alphaOldValue10030 = 0
			end

			local var_166_10 = 0.333333333333333

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_10 then
				local var_166_11 = (arg_163_1.time_ - var_166_8) / var_166_10
				local var_166_12 = Mathf.Lerp(arg_163_1.var_.alphaOldValue10030, 1, var_166_11)

				if arg_163_1.var_.characterEffect10030 then
					arg_163_1.var_.characterEffect10030.alpha = var_166_12
				end
			end

			if arg_163_1.time_ >= var_166_8 + var_166_10 and arg_163_1.time_ < var_166_8 + var_166_10 + arg_166_0 and arg_163_1.var_.characterEffect10030 then
				arg_163_1.var_.characterEffect10030.alpha = 1
			end

			local var_166_13 = arg_163_1.actors_["10030"]
			local var_166_14 = 0

			if var_166_14 < arg_163_1.time_ and arg_163_1.time_ <= var_166_14 + arg_166_0 and not isNil(var_166_13) and arg_163_1.var_.actorSpriteComps10030 == nil then
				arg_163_1.var_.actorSpriteComps10030 = var_166_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_15 = 0.2

			if var_166_14 <= arg_163_1.time_ and arg_163_1.time_ < var_166_14 + var_166_15 and not isNil(var_166_13) then
				local var_166_16 = (arg_163_1.time_ - var_166_14) / var_166_15

				if arg_163_1.var_.actorSpriteComps10030 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								local var_166_17 = Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, var_166_16)
								local var_166_18 = Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, var_166_16)
								local var_166_19 = Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, var_166_16)

								iter_166_2.color = Color.New(var_166_17, var_166_18, var_166_19)
							else
								local var_166_20 = Mathf.Lerp(iter_166_2.color.r, 1, var_166_16)

								iter_166_2.color = Color.New(var_166_20, var_166_20, var_166_20)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_14 + var_166_15 and arg_163_1.time_ < var_166_14 + var_166_15 + arg_166_0 and not isNil(var_166_13) and arg_163_1.var_.actorSpriteComps10030 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_166_4 then
						if arg_163_1.isInRecall_ then
							iter_166_4.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10030 = nil
			end

			local var_166_21 = 0
			local var_166_22 = 0.3

			if var_166_21 < arg_163_1.time_ and arg_163_1.time_ <= var_166_21 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_23 = arg_163_1:FormatText(StoryNameCfg[309].name)

				arg_163_1.leftNameTxt_.text = var_166_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_24 = arg_163_1:GetWordFromCfg(115301041)
				local var_166_25 = arg_163_1:FormatText(var_166_24.content)

				arg_163_1.text_.text = var_166_25

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_26 = 12
				local var_166_27 = utf8.len(var_166_25)
				local var_166_28 = var_166_26 <= 0 and var_166_22 or var_166_22 * (var_166_27 / var_166_26)

				if var_166_28 > 0 and var_166_22 < var_166_28 then
					arg_163_1.talkMaxDuration = var_166_28

					if var_166_28 + var_166_21 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_28 + var_166_21
					end
				end

				arg_163_1.text_.text = var_166_25
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301041", "story_v_out_115301.awb") ~= 0 then
					local var_166_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301041", "story_v_out_115301.awb") / 1000

					if var_166_29 + var_166_21 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_29 + var_166_21
					end

					if var_166_24.prefab_name ~= "" and arg_163_1.actors_[var_166_24.prefab_name] ~= nil then
						local var_166_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_24.prefab_name].transform, "story_v_out_115301", "115301041", "story_v_out_115301.awb")

						arg_163_1:RecordAudio("115301041", var_166_30)
						arg_163_1:RecordAudio("115301041", var_166_30)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_115301", "115301041", "story_v_out_115301.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_115301", "115301041", "story_v_out_115301.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_31 = math.max(var_166_22, arg_163_1.talkMaxDuration)

			if var_166_21 <= arg_163_1.time_ and arg_163_1.time_ < var_166_21 + var_166_31 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_21) / var_166_31

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_21 + var_166_31 and arg_163_1.time_ < var_166_21 + var_166_31 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115301042 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115301042
		arg_167_1.duration_ = 5.2

		local var_167_0 = {
			ja = 5.2,
			ko = 2.666,
			zh = 4.766,
			en = 3.7
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
				arg_167_0:Play115301043(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1038"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1038 = var_170_0.localPosition
				var_170_0.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1038", 2)

				local var_170_2 = var_170_0.childCount

				for iter_170_0 = 0, var_170_2 - 1 do
					local var_170_3 = var_170_0:GetChild(iter_170_0)

					if var_170_3.name == "split_7" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_4 then
				local var_170_5 = (arg_167_1.time_ - var_170_1) / var_170_4
				local var_170_6 = Vector3.New(-390, -400, 0)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1038, var_170_6, var_170_5)
			end

			if arg_167_1.time_ >= var_170_1 + var_170_4 and arg_167_1.time_ < var_170_1 + var_170_4 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_170_7 = arg_167_1.actors_["10030"]
			local var_170_8 = 0

			if var_170_8 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps10030 == nil then
				arg_167_1.var_.actorSpriteComps10030 = var_170_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_9 = 0.2

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_9 and not isNil(var_170_7) then
				local var_170_10 = (arg_167_1.time_ - var_170_8) / var_170_9

				if arg_167_1.var_.actorSpriteComps10030 then
					for iter_170_1, iter_170_2 in pairs(arg_167_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_170_2 then
							if arg_167_1.isInRecall_ then
								local var_170_11 = Mathf.Lerp(iter_170_2.color.r, arg_167_1.hightColor2.r, var_170_10)
								local var_170_12 = Mathf.Lerp(iter_170_2.color.g, arg_167_1.hightColor2.g, var_170_10)
								local var_170_13 = Mathf.Lerp(iter_170_2.color.b, arg_167_1.hightColor2.b, var_170_10)

								iter_170_2.color = Color.New(var_170_11, var_170_12, var_170_13)
							else
								local var_170_14 = Mathf.Lerp(iter_170_2.color.r, 0.5, var_170_10)

								iter_170_2.color = Color.New(var_170_14, var_170_14, var_170_14)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_8 + var_170_9 and arg_167_1.time_ < var_170_8 + var_170_9 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps10030 then
				for iter_170_3, iter_170_4 in pairs(arg_167_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_170_4 then
						if arg_167_1.isInRecall_ then
							iter_170_4.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10030 = nil
			end

			local var_170_15 = arg_167_1.actors_["1038"]
			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				local var_170_17 = var_170_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_170_17 then
					arg_167_1.var_.alphaOldValue1038 = var_170_17.alpha
					arg_167_1.var_.characterEffect1038 = var_170_17
				end

				arg_167_1.var_.alphaOldValue1038 = 0
			end

			local var_170_18 = 0.333333333333333

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_18 then
				local var_170_19 = (arg_167_1.time_ - var_170_16) / var_170_18
				local var_170_20 = Mathf.Lerp(arg_167_1.var_.alphaOldValue1038, 1, var_170_19)

				if arg_167_1.var_.characterEffect1038 then
					arg_167_1.var_.characterEffect1038.alpha = var_170_20
				end
			end

			if arg_167_1.time_ >= var_170_16 + var_170_18 and arg_167_1.time_ < var_170_16 + var_170_18 + arg_170_0 and arg_167_1.var_.characterEffect1038 then
				arg_167_1.var_.characterEffect1038.alpha = 1
			end

			local var_170_21 = arg_167_1.actors_["1038"]
			local var_170_22 = 0

			if var_170_22 < arg_167_1.time_ and arg_167_1.time_ <= var_170_22 + arg_170_0 and not isNil(var_170_21) and arg_167_1.var_.actorSpriteComps1038 == nil then
				arg_167_1.var_.actorSpriteComps1038 = var_170_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_23 = 0.2

			if var_170_22 <= arg_167_1.time_ and arg_167_1.time_ < var_170_22 + var_170_23 and not isNil(var_170_21) then
				local var_170_24 = (arg_167_1.time_ - var_170_22) / var_170_23

				if arg_167_1.var_.actorSpriteComps1038 then
					for iter_170_5, iter_170_6 in pairs(arg_167_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_170_6 then
							if arg_167_1.isInRecall_ then
								local var_170_25 = Mathf.Lerp(iter_170_6.color.r, arg_167_1.hightColor1.r, var_170_24)
								local var_170_26 = Mathf.Lerp(iter_170_6.color.g, arg_167_1.hightColor1.g, var_170_24)
								local var_170_27 = Mathf.Lerp(iter_170_6.color.b, arg_167_1.hightColor1.b, var_170_24)

								iter_170_6.color = Color.New(var_170_25, var_170_26, var_170_27)
							else
								local var_170_28 = Mathf.Lerp(iter_170_6.color.r, 1, var_170_24)

								iter_170_6.color = Color.New(var_170_28, var_170_28, var_170_28)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_22 + var_170_23 and arg_167_1.time_ < var_170_22 + var_170_23 + arg_170_0 and not isNil(var_170_21) and arg_167_1.var_.actorSpriteComps1038 then
				for iter_170_7, iter_170_8 in pairs(arg_167_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_170_8 then
						if arg_167_1.isInRecall_ then
							iter_170_8.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps1038 = nil
			end

			local var_170_29 = 0
			local var_170_30 = 1

			if var_170_29 < arg_167_1.time_ and arg_167_1.time_ <= var_170_29 + arg_170_0 then
				local var_170_31 = "play"
				local var_170_32 = "music"

				arg_167_1:AudioAction(var_170_31, var_170_32, "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess.awb")

				local var_170_33 = ""
				local var_170_34 = manager.audio:GetAudioName("bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess")

				if var_170_34 ~= "" then
					if arg_167_1.bgmTxt_.text ~= var_170_34 and arg_167_1.bgmTxt_.text ~= "" then
						if arg_167_1.bgmTxt2_.text ~= "" then
							arg_167_1.bgmTxt_.text = arg_167_1.bgmTxt2_.text
						end

						arg_167_1.bgmTxt2_.text = var_170_34

						arg_167_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_167_1.bgmTxt_.text = var_170_34
						arg_167_1.bgmTxt2_.text = var_170_34
					end

					if arg_167_1.bgmTimer then
						arg_167_1.bgmTimer:Stop()

						arg_167_1.bgmTimer = nil
					end

					if arg_167_1.settingData.show_music_name == 1 then
						arg_167_1.musicController:SetSelectedState("show")
						arg_167_1.musicAnimator_:Play("open", 0, 0)

						if arg_167_1.settingData.music_time ~= 0 then
							arg_167_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_167_1.settingData.music_time), function()
								if arg_167_1 == nil or isNil(arg_167_1.bgmTxt_) then
									return
								end

								arg_167_1.musicController:SetSelectedState("hide")
								arg_167_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_170_35 = 0
			local var_170_36 = 0.25

			if var_170_35 < arg_167_1.time_ and arg_167_1.time_ <= var_170_35 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_37 = arg_167_1:FormatText(StoryNameCfg[94].name)

				arg_167_1.leftNameTxt_.text = var_170_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_38 = arg_167_1:GetWordFromCfg(115301042)
				local var_170_39 = arg_167_1:FormatText(var_170_38.content)

				arg_167_1.text_.text = var_170_39

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_40 = 10
				local var_170_41 = utf8.len(var_170_39)
				local var_170_42 = var_170_40 <= 0 and var_170_36 or var_170_36 * (var_170_41 / var_170_40)

				if var_170_42 > 0 and var_170_36 < var_170_42 then
					arg_167_1.talkMaxDuration = var_170_42

					if var_170_42 + var_170_35 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_42 + var_170_35
					end
				end

				arg_167_1.text_.text = var_170_39
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301042", "story_v_out_115301.awb") ~= 0 then
					local var_170_43 = manager.audio:GetVoiceLength("story_v_out_115301", "115301042", "story_v_out_115301.awb") / 1000

					if var_170_43 + var_170_35 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_43 + var_170_35
					end

					if var_170_38.prefab_name ~= "" and arg_167_1.actors_[var_170_38.prefab_name] ~= nil then
						local var_170_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_38.prefab_name].transform, "story_v_out_115301", "115301042", "story_v_out_115301.awb")

						arg_167_1:RecordAudio("115301042", var_170_44)
						arg_167_1:RecordAudio("115301042", var_170_44)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_115301", "115301042", "story_v_out_115301.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_115301", "115301042", "story_v_out_115301.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_45 = math.max(var_170_36, arg_167_1.talkMaxDuration)

			if var_170_35 <= arg_167_1.time_ and arg_167_1.time_ < var_170_35 + var_170_45 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_35) / var_170_45

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_35 + var_170_45 and arg_167_1.time_ < var_170_35 + var_170_45 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
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
	Play115301043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 115301043
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play115301044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1038"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps1038 == nil then
				arg_172_1.var_.actorSpriteComps1038 = var_175_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.actorSpriteComps1038 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps1038:ToTable()) do
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

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps1038 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_175_3 then
						if arg_172_1.isInRecall_ then
							iter_175_3.color = arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_175_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps1038 = nil
			end

			local var_175_8 = 0
			local var_175_9 = 0.65

			if var_175_8 < arg_172_1.time_ and arg_172_1.time_ <= var_175_8 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_10 = arg_172_1:GetWordFromCfg(115301043)
				local var_175_11 = arg_172_1:FormatText(var_175_10.content)

				arg_172_1.text_.text = var_175_11

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_12 = 26
				local var_175_13 = utf8.len(var_175_11)
				local var_175_14 = var_175_12 <= 0 and var_175_9 or var_175_9 * (var_175_13 / var_175_12)

				if var_175_14 > 0 and var_175_9 < var_175_14 then
					arg_172_1.talkMaxDuration = var_175_14

					if var_175_14 + var_175_8 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_14 + var_175_8
					end
				end

				arg_172_1.text_.text = var_175_11
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_15 = math.max(var_175_9, arg_172_1.talkMaxDuration)

			if var_175_8 <= arg_172_1.time_ and arg_172_1.time_ < var_175_8 + var_175_15 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_8) / var_175_15

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_8 + var_175_15 and arg_172_1.time_ < var_175_8 + var_175_15 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play115301044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 115301044
		arg_176_1.duration_ = 4.57

		local var_176_0 = {
			ja = 4.566,
			ko = 3.666,
			zh = 3.933,
			en = 4.133
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
				arg_176_0:Play115301045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10030"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps10030 == nil then
				arg_176_1.var_.actorSpriteComps10030 = var_179_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.actorSpriteComps10030 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps10030:ToTable()) do
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

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps10030 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_179_3 then
						if arg_176_1.isInRecall_ then
							iter_179_3.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_179_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10030 = nil
			end

			local var_179_8 = arg_176_1.actors_["10030"].transform
			local var_179_9 = 0

			if var_179_9 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 then
				arg_176_1.var_.moveOldPos10030 = var_179_8.localPosition
				var_179_8.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10030", 4)

				local var_179_10 = var_179_8.childCount

				for iter_179_4 = 0, var_179_10 - 1 do
					local var_179_11 = var_179_8:GetChild(iter_179_4)

					if var_179_11.name == "split_1" or not string.find(var_179_11.name, "split") then
						var_179_11.gameObject:SetActive(true)
					else
						var_179_11.gameObject:SetActive(false)
					end
				end
			end

			local var_179_12 = 0.001

			if var_179_9 <= arg_176_1.time_ and arg_176_1.time_ < var_179_9 + var_179_12 then
				local var_179_13 = (arg_176_1.time_ - var_179_9) / var_179_12
				local var_179_14 = Vector3.New(390, -390, 150)

				var_179_8.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10030, var_179_14, var_179_13)
			end

			if arg_176_1.time_ >= var_179_9 + var_179_12 and arg_176_1.time_ < var_179_9 + var_179_12 + arg_179_0 then
				var_179_8.localPosition = Vector3.New(390, -390, 150)
			end

			local var_179_15 = arg_176_1.actors_["10030"]
			local var_179_16 = 0

			if var_179_16 < arg_176_1.time_ and arg_176_1.time_ <= var_179_16 + arg_179_0 then
				local var_179_17 = var_179_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_179_17 then
					arg_176_1.var_.alphaOldValue10030 = var_179_17.alpha
					arg_176_1.var_.characterEffect10030 = var_179_17
				end

				arg_176_1.var_.alphaOldValue10030 = 0
			end

			local var_179_18 = 0.0166666666666667

			if var_179_16 <= arg_176_1.time_ and arg_176_1.time_ < var_179_16 + var_179_18 then
				local var_179_19 = (arg_176_1.time_ - var_179_16) / var_179_18
				local var_179_20 = Mathf.Lerp(arg_176_1.var_.alphaOldValue10030, 1, var_179_19)

				if arg_176_1.var_.characterEffect10030 then
					arg_176_1.var_.characterEffect10030.alpha = var_179_20
				end
			end

			if arg_176_1.time_ >= var_179_16 + var_179_18 and arg_176_1.time_ < var_179_16 + var_179_18 + arg_179_0 and arg_176_1.var_.characterEffect10030 then
				arg_176_1.var_.characterEffect10030.alpha = 1
			end

			local var_179_21 = 0
			local var_179_22 = 0.35

			if var_179_21 < arg_176_1.time_ and arg_176_1.time_ <= var_179_21 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_23 = arg_176_1:FormatText(StoryNameCfg[309].name)

				arg_176_1.leftNameTxt_.text = var_179_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_24 = arg_176_1:GetWordFromCfg(115301044)
				local var_179_25 = arg_176_1:FormatText(var_179_24.content)

				arg_176_1.text_.text = var_179_25

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_26 = 14
				local var_179_27 = utf8.len(var_179_25)
				local var_179_28 = var_179_26 <= 0 and var_179_22 or var_179_22 * (var_179_27 / var_179_26)

				if var_179_28 > 0 and var_179_22 < var_179_28 then
					arg_176_1.talkMaxDuration = var_179_28

					if var_179_28 + var_179_21 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_28 + var_179_21
					end
				end

				arg_176_1.text_.text = var_179_25
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301044", "story_v_out_115301.awb") ~= 0 then
					local var_179_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301044", "story_v_out_115301.awb") / 1000

					if var_179_29 + var_179_21 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_29 + var_179_21
					end

					if var_179_24.prefab_name ~= "" and arg_176_1.actors_[var_179_24.prefab_name] ~= nil then
						local var_179_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_24.prefab_name].transform, "story_v_out_115301", "115301044", "story_v_out_115301.awb")

						arg_176_1:RecordAudio("115301044", var_179_30)
						arg_176_1:RecordAudio("115301044", var_179_30)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_115301", "115301044", "story_v_out_115301.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_115301", "115301044", "story_v_out_115301.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_31 = math.max(var_179_22, arg_176_1.talkMaxDuration)

			if var_179_21 <= arg_176_1.time_ and arg_176_1.time_ < var_179_21 + var_179_31 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_21) / var_179_31

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_21 + var_179_31 and arg_176_1.time_ < var_179_21 + var_179_31 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115301045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 115301045
		arg_180_1.duration_ = 2.8

		local var_180_0 = {
			ja = 2.4,
			ko = 1.166,
			zh = 2.8,
			en = 1.3
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
				arg_180_0:Play115301046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1038"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos1038 = var_183_0.localPosition
				var_183_0.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("1038", 2)

				local var_183_2 = var_183_0.childCount

				for iter_183_0 = 0, var_183_2 - 1 do
					local var_183_3 = var_183_0:GetChild(iter_183_0)

					if var_183_3.name == "split_1" or not string.find(var_183_3.name, "split") then
						var_183_3.gameObject:SetActive(true)
					else
						var_183_3.gameObject:SetActive(false)
					end
				end
			end

			local var_183_4 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_4 then
				local var_183_5 = (arg_180_1.time_ - var_183_1) / var_183_4
				local var_183_6 = Vector3.New(-390, -400, 0)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1038, var_183_6, var_183_5)
			end

			if arg_180_1.time_ >= var_183_1 + var_183_4 and arg_180_1.time_ < var_183_1 + var_183_4 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_183_7 = arg_180_1.actors_["10030"]
			local var_183_8 = 0

			if var_183_8 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 and not isNil(var_183_7) and arg_180_1.var_.actorSpriteComps10030 == nil then
				arg_180_1.var_.actorSpriteComps10030 = var_183_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_9 = 0.2

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_9 and not isNil(var_183_7) then
				local var_183_10 = (arg_180_1.time_ - var_183_8) / var_183_9

				if arg_180_1.var_.actorSpriteComps10030 then
					for iter_183_1, iter_183_2 in pairs(arg_180_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_183_2 then
							if arg_180_1.isInRecall_ then
								local var_183_11 = Mathf.Lerp(iter_183_2.color.r, arg_180_1.hightColor2.r, var_183_10)
								local var_183_12 = Mathf.Lerp(iter_183_2.color.g, arg_180_1.hightColor2.g, var_183_10)
								local var_183_13 = Mathf.Lerp(iter_183_2.color.b, arg_180_1.hightColor2.b, var_183_10)

								iter_183_2.color = Color.New(var_183_11, var_183_12, var_183_13)
							else
								local var_183_14 = Mathf.Lerp(iter_183_2.color.r, 0.5, var_183_10)

								iter_183_2.color = Color.New(var_183_14, var_183_14, var_183_14)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_8 + var_183_9 and arg_180_1.time_ < var_183_8 + var_183_9 + arg_183_0 and not isNil(var_183_7) and arg_180_1.var_.actorSpriteComps10030 then
				for iter_183_3, iter_183_4 in pairs(arg_180_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_183_4 then
						if arg_180_1.isInRecall_ then
							iter_183_4.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10030 = nil
			end

			local var_183_15 = arg_180_1.actors_["1038"]
			local var_183_16 = 0

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 and not isNil(var_183_15) and arg_180_1.var_.actorSpriteComps1038 == nil then
				arg_180_1.var_.actorSpriteComps1038 = var_183_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_17 = 0.2

			if var_183_16 <= arg_180_1.time_ and arg_180_1.time_ < var_183_16 + var_183_17 and not isNil(var_183_15) then
				local var_183_18 = (arg_180_1.time_ - var_183_16) / var_183_17

				if arg_180_1.var_.actorSpriteComps1038 then
					for iter_183_5, iter_183_6 in pairs(arg_180_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_183_6 then
							if arg_180_1.isInRecall_ then
								local var_183_19 = Mathf.Lerp(iter_183_6.color.r, arg_180_1.hightColor1.r, var_183_18)
								local var_183_20 = Mathf.Lerp(iter_183_6.color.g, arg_180_1.hightColor1.g, var_183_18)
								local var_183_21 = Mathf.Lerp(iter_183_6.color.b, arg_180_1.hightColor1.b, var_183_18)

								iter_183_6.color = Color.New(var_183_19, var_183_20, var_183_21)
							else
								local var_183_22 = Mathf.Lerp(iter_183_6.color.r, 1, var_183_18)

								iter_183_6.color = Color.New(var_183_22, var_183_22, var_183_22)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_16 + var_183_17 and arg_180_1.time_ < var_183_16 + var_183_17 + arg_183_0 and not isNil(var_183_15) and arg_180_1.var_.actorSpriteComps1038 then
				for iter_183_7, iter_183_8 in pairs(arg_180_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_183_8 then
						if arg_180_1.isInRecall_ then
							iter_183_8.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1038 = nil
			end

			local var_183_23 = 0
			local var_183_24 = 0.125

			if var_183_23 < arg_180_1.time_ and arg_180_1.time_ <= var_183_23 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_25 = arg_180_1:FormatText(StoryNameCfg[94].name)

				arg_180_1.leftNameTxt_.text = var_183_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_26 = arg_180_1:GetWordFromCfg(115301045)
				local var_183_27 = arg_180_1:FormatText(var_183_26.content)

				arg_180_1.text_.text = var_183_27

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_28 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301045", "story_v_out_115301.awb") ~= 0 then
					local var_183_31 = manager.audio:GetVoiceLength("story_v_out_115301", "115301045", "story_v_out_115301.awb") / 1000

					if var_183_31 + var_183_23 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_31 + var_183_23
					end

					if var_183_26.prefab_name ~= "" and arg_180_1.actors_[var_183_26.prefab_name] ~= nil then
						local var_183_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_26.prefab_name].transform, "story_v_out_115301", "115301045", "story_v_out_115301.awb")

						arg_180_1:RecordAudio("115301045", var_183_32)
						arg_180_1:RecordAudio("115301045", var_183_32)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_115301", "115301045", "story_v_out_115301.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_115301", "115301045", "story_v_out_115301.awb")
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
				actorName = "1038",
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
	Play115301046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 115301046
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play115301047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10030"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				local var_187_2 = var_187_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_187_2 then
					arg_184_1.var_.alphaOldValue10030 = var_187_2.alpha
					arg_184_1.var_.characterEffect10030 = var_187_2
				end

				arg_184_1.var_.alphaOldValue10030 = 1
			end

			local var_187_3 = 0.333333333333333

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_3 then
				local var_187_4 = (arg_184_1.time_ - var_187_1) / var_187_3
				local var_187_5 = Mathf.Lerp(arg_184_1.var_.alphaOldValue10030, 0, var_187_4)

				if arg_184_1.var_.characterEffect10030 then
					arg_184_1.var_.characterEffect10030.alpha = var_187_5
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_3 and arg_184_1.time_ < var_187_1 + var_187_3 + arg_187_0 and arg_184_1.var_.characterEffect10030 then
				arg_184_1.var_.characterEffect10030.alpha = 0
			end

			local var_187_6 = arg_184_1.actors_["1038"]
			local var_187_7 = 0

			if var_187_7 < arg_184_1.time_ and arg_184_1.time_ <= var_187_7 + arg_187_0 then
				local var_187_8 = var_187_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_187_8 then
					arg_184_1.var_.alphaOldValue1038 = var_187_8.alpha
					arg_184_1.var_.characterEffect1038 = var_187_8
				end

				arg_184_1.var_.alphaOldValue1038 = 1
			end

			local var_187_9 = 0.333333333333333

			if var_187_7 <= arg_184_1.time_ and arg_184_1.time_ < var_187_7 + var_187_9 then
				local var_187_10 = (arg_184_1.time_ - var_187_7) / var_187_9
				local var_187_11 = Mathf.Lerp(arg_184_1.var_.alphaOldValue1038, 0, var_187_10)

				if arg_184_1.var_.characterEffect1038 then
					arg_184_1.var_.characterEffect1038.alpha = var_187_11
				end
			end

			if arg_184_1.time_ >= var_187_7 + var_187_9 and arg_184_1.time_ < var_187_7 + var_187_9 + arg_187_0 and arg_184_1.var_.characterEffect1038 then
				arg_184_1.var_.characterEffect1038.alpha = 0
			end

			local var_187_12 = 0
			local var_187_13 = 0.6

			if var_187_12 < arg_184_1.time_ and arg_184_1.time_ <= var_187_12 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_14 = arg_184_1:GetWordFromCfg(115301046)
				local var_187_15 = arg_184_1:FormatText(var_187_14.content)

				arg_184_1.text_.text = var_187_15

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_16 = 24
				local var_187_17 = utf8.len(var_187_15)
				local var_187_18 = var_187_16 <= 0 and var_187_13 or var_187_13 * (var_187_17 / var_187_16)

				if var_187_18 > 0 and var_187_13 < var_187_18 then
					arg_184_1.talkMaxDuration = var_187_18

					if var_187_18 + var_187_12 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_18 + var_187_12
					end
				end

				arg_184_1.text_.text = var_187_15
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_19 = math.max(var_187_13, arg_184_1.talkMaxDuration)

			if var_187_12 <= arg_184_1.time_ and arg_184_1.time_ < var_187_12 + var_187_19 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_12) / var_187_19

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_12 + var_187_19 and arg_184_1.time_ < var_187_12 + var_187_19 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play115301047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 115301047
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play115301048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 0.9

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_2 = arg_188_1:GetWordFromCfg(115301047)
				local var_191_3 = arg_188_1:FormatText(var_191_2.content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 36
				local var_191_5 = utf8.len(var_191_3)
				local var_191_6 = var_191_4 <= 0 and var_191_1 or var_191_1 * (var_191_5 / var_191_4)

				if var_191_6 > 0 and var_191_1 < var_191_6 then
					arg_188_1.talkMaxDuration = var_191_6

					if var_191_6 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_6 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_7 and arg_188_1.time_ < var_191_0 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play115301048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 115301048
		arg_192_1.duration_ = 16.03

		local var_192_0 = {
			ja = 16.033,
			ko = 6.833,
			zh = 8.3,
			en = 8.766
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
				arg_192_0:Play115301049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10030"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos10030 = var_195_0.localPosition
				var_195_0.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10030", 3)

				local var_195_2 = var_195_0.childCount

				for iter_195_0 = 0, var_195_2 - 1 do
					local var_195_3 = var_195_0:GetChild(iter_195_0)

					if var_195_3.name == "split_1" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_4 then
				local var_195_5 = (arg_192_1.time_ - var_195_1) / var_195_4
				local var_195_6 = Vector3.New(0, -390, 150)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10030, var_195_6, var_195_5)
			end

			if arg_192_1.time_ >= var_195_1 + var_195_4 and arg_192_1.time_ < var_195_1 + var_195_4 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_195_7 = arg_192_1.actors_["10030"]
			local var_195_8 = 0

			if var_195_8 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 and not isNil(var_195_7) and arg_192_1.var_.actorSpriteComps10030 == nil then
				arg_192_1.var_.actorSpriteComps10030 = var_195_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_9 = 0.2

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_9 and not isNil(var_195_7) then
				local var_195_10 = (arg_192_1.time_ - var_195_8) / var_195_9

				if arg_192_1.var_.actorSpriteComps10030 then
					for iter_195_1, iter_195_2 in pairs(arg_192_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_195_2 then
							if arg_192_1.isInRecall_ then
								local var_195_11 = Mathf.Lerp(iter_195_2.color.r, arg_192_1.hightColor1.r, var_195_10)
								local var_195_12 = Mathf.Lerp(iter_195_2.color.g, arg_192_1.hightColor1.g, var_195_10)
								local var_195_13 = Mathf.Lerp(iter_195_2.color.b, arg_192_1.hightColor1.b, var_195_10)

								iter_195_2.color = Color.New(var_195_11, var_195_12, var_195_13)
							else
								local var_195_14 = Mathf.Lerp(iter_195_2.color.r, 1, var_195_10)

								iter_195_2.color = Color.New(var_195_14, var_195_14, var_195_14)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_8 + var_195_9 and arg_192_1.time_ < var_195_8 + var_195_9 + arg_195_0 and not isNil(var_195_7) and arg_192_1.var_.actorSpriteComps10030 then
				for iter_195_3, iter_195_4 in pairs(arg_192_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_195_4 then
						if arg_192_1.isInRecall_ then
							iter_195_4.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_195_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps10030 = nil
			end

			local var_195_15 = arg_192_1.actors_["10030"]
			local var_195_16 = 0

			if var_195_16 < arg_192_1.time_ and arg_192_1.time_ <= var_195_16 + arg_195_0 then
				local var_195_17 = var_195_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_195_17 then
					arg_192_1.var_.alphaOldValue10030 = var_195_17.alpha
					arg_192_1.var_.characterEffect10030 = var_195_17
				end

				arg_192_1.var_.alphaOldValue10030 = 0
			end

			local var_195_18 = 0.333333333333333

			if var_195_16 <= arg_192_1.time_ and arg_192_1.time_ < var_195_16 + var_195_18 then
				local var_195_19 = (arg_192_1.time_ - var_195_16) / var_195_18
				local var_195_20 = Mathf.Lerp(arg_192_1.var_.alphaOldValue10030, 1, var_195_19)

				if arg_192_1.var_.characterEffect10030 then
					arg_192_1.var_.characterEffect10030.alpha = var_195_20
				end
			end

			if arg_192_1.time_ >= var_195_16 + var_195_18 and arg_192_1.time_ < var_195_16 + var_195_18 + arg_195_0 and arg_192_1.var_.characterEffect10030 then
				arg_192_1.var_.characterEffect10030.alpha = 1
			end

			local var_195_21 = 0
			local var_195_22 = 0.575

			if var_195_21 < arg_192_1.time_ and arg_192_1.time_ <= var_195_21 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_23 = arg_192_1:FormatText(StoryNameCfg[309].name)

				arg_192_1.leftNameTxt_.text = var_195_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_24 = arg_192_1:GetWordFromCfg(115301048)
				local var_195_25 = arg_192_1:FormatText(var_195_24.content)

				arg_192_1.text_.text = var_195_25

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_26 = 23
				local var_195_27 = utf8.len(var_195_25)
				local var_195_28 = var_195_26 <= 0 and var_195_22 or var_195_22 * (var_195_27 / var_195_26)

				if var_195_28 > 0 and var_195_22 < var_195_28 then
					arg_192_1.talkMaxDuration = var_195_28

					if var_195_28 + var_195_21 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_28 + var_195_21
					end
				end

				arg_192_1.text_.text = var_195_25
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301048", "story_v_out_115301.awb") ~= 0 then
					local var_195_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301048", "story_v_out_115301.awb") / 1000

					if var_195_29 + var_195_21 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_29 + var_195_21
					end

					if var_195_24.prefab_name ~= "" and arg_192_1.actors_[var_195_24.prefab_name] ~= nil then
						local var_195_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_24.prefab_name].transform, "story_v_out_115301", "115301048", "story_v_out_115301.awb")

						arg_192_1:RecordAudio("115301048", var_195_30)
						arg_192_1:RecordAudio("115301048", var_195_30)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_115301", "115301048", "story_v_out_115301.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_115301", "115301048", "story_v_out_115301.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_31 = math.max(var_195_22, arg_192_1.talkMaxDuration)

			if var_195_21 <= arg_192_1.time_ and arg_192_1.time_ < var_195_21 + var_195_31 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_21) / var_195_31

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_21 + var_195_31 and arg_192_1.time_ < var_195_21 + var_195_31 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115301049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 115301049
		arg_196_1.duration_ = 9.17

		local var_196_0 = {
			ja = 8.3,
			ko = 6.566,
			zh = 7.233,
			en = 9.166
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
				arg_196_0:Play115301050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.725

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[309].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_3 = arg_196_1:GetWordFromCfg(115301049)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 29
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301049", "story_v_out_115301.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301049", "story_v_out_115301.awb") / 1000

					if var_199_8 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_0
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_out_115301", "115301049", "story_v_out_115301.awb")

						arg_196_1:RecordAudio("115301049", var_199_9)
						arg_196_1:RecordAudio("115301049", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_115301", "115301049", "story_v_out_115301.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_115301", "115301049", "story_v_out_115301.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_10 and arg_196_1.time_ < var_199_0 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play115301050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 115301050
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play115301051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10030"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				local var_203_2 = var_203_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_203_2 then
					arg_200_1.var_.alphaOldValue10030 = var_203_2.alpha
					arg_200_1.var_.characterEffect10030 = var_203_2
				end

				arg_200_1.var_.alphaOldValue10030 = 1
			end

			local var_203_3 = 0.333333333333333

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_3 then
				local var_203_4 = (arg_200_1.time_ - var_203_1) / var_203_3
				local var_203_5 = Mathf.Lerp(arg_200_1.var_.alphaOldValue10030, 0, var_203_4)

				if arg_200_1.var_.characterEffect10030 then
					arg_200_1.var_.characterEffect10030.alpha = var_203_5
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_3 and arg_200_1.time_ < var_203_1 + var_203_3 + arg_203_0 and arg_200_1.var_.characterEffect10030 then
				arg_200_1.var_.characterEffect10030.alpha = 0
			end

			local var_203_6 = 0
			local var_203_7 = 1.575

			if var_203_6 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_8 = arg_200_1:GetWordFromCfg(115301050)
				local var_203_9 = arg_200_1:FormatText(var_203_8.content)

				arg_200_1.text_.text = var_203_9

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_10 = 63
				local var_203_11 = utf8.len(var_203_9)
				local var_203_12 = var_203_10 <= 0 and var_203_7 or var_203_7 * (var_203_11 / var_203_10)

				if var_203_12 > 0 and var_203_7 < var_203_12 then
					arg_200_1.talkMaxDuration = var_203_12

					if var_203_12 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_12 + var_203_6
					end
				end

				arg_200_1.text_.text = var_203_9
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_13 = math.max(var_203_7, arg_200_1.talkMaxDuration)

			if var_203_6 <= arg_200_1.time_ and arg_200_1.time_ < var_203_6 + var_203_13 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_6) / var_203_13

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_6 + var_203_13 and arg_200_1.time_ < var_203_6 + var_203_13 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play115301051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 115301051
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play115301052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 1.075

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

				local var_207_2 = arg_204_1:GetWordFromCfg(115301051)
				local var_207_3 = arg_204_1:FormatText(var_207_2.content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 43
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
	Play115301052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 115301052
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play115301053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 1.6

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_2 = arg_208_1:GetWordFromCfg(115301052)
				local var_211_3 = arg_208_1:FormatText(var_211_2.content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 64
				local var_211_5 = utf8.len(var_211_3)
				local var_211_6 = var_211_4 <= 0 and var_211_1 or var_211_1 * (var_211_5 / var_211_4)

				if var_211_6 > 0 and var_211_1 < var_211_6 then
					arg_208_1.talkMaxDuration = var_211_6

					if var_211_6 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_6 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_7 and arg_208_1.time_ < var_211_0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play115301053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 115301053
		arg_212_1.duration_ = 7.8

		local var_212_0 = {
			ja = 7.8,
			ko = 6.866,
			zh = 6.933,
			en = 7.366
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
				arg_212_0:Play115301054(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["10030"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos10030 = var_215_0.localPosition
				var_215_0.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("10030", 3)

				local var_215_2 = var_215_0.childCount

				for iter_215_0 = 0, var_215_2 - 1 do
					local var_215_3 = var_215_0:GetChild(iter_215_0)

					if var_215_3.name == "split_3" or not string.find(var_215_3.name, "split") then
						var_215_3.gameObject:SetActive(true)
					else
						var_215_3.gameObject:SetActive(false)
					end
				end
			end

			local var_215_4 = 0.001

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_4 then
				local var_215_5 = (arg_212_1.time_ - var_215_1) / var_215_4
				local var_215_6 = Vector3.New(0, -390, 150)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10030, var_215_6, var_215_5)
			end

			if arg_212_1.time_ >= var_215_1 + var_215_4 and arg_212_1.time_ < var_215_1 + var_215_4 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_215_7 = arg_212_1.actors_["10030"]
			local var_215_8 = 0

			if var_215_8 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 and not isNil(var_215_7) and arg_212_1.var_.actorSpriteComps10030 == nil then
				arg_212_1.var_.actorSpriteComps10030 = var_215_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_9 = 0.2

			if var_215_8 <= arg_212_1.time_ and arg_212_1.time_ < var_215_8 + var_215_9 and not isNil(var_215_7) then
				local var_215_10 = (arg_212_1.time_ - var_215_8) / var_215_9

				if arg_212_1.var_.actorSpriteComps10030 then
					for iter_215_1, iter_215_2 in pairs(arg_212_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_215_2 then
							if arg_212_1.isInRecall_ then
								local var_215_11 = Mathf.Lerp(iter_215_2.color.r, arg_212_1.hightColor1.r, var_215_10)
								local var_215_12 = Mathf.Lerp(iter_215_2.color.g, arg_212_1.hightColor1.g, var_215_10)
								local var_215_13 = Mathf.Lerp(iter_215_2.color.b, arg_212_1.hightColor1.b, var_215_10)

								iter_215_2.color = Color.New(var_215_11, var_215_12, var_215_13)
							else
								local var_215_14 = Mathf.Lerp(iter_215_2.color.r, 1, var_215_10)

								iter_215_2.color = Color.New(var_215_14, var_215_14, var_215_14)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= var_215_8 + var_215_9 and arg_212_1.time_ < var_215_8 + var_215_9 + arg_215_0 and not isNil(var_215_7) and arg_212_1.var_.actorSpriteComps10030 then
				for iter_215_3, iter_215_4 in pairs(arg_212_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_215_4 then
						if arg_212_1.isInRecall_ then
							iter_215_4.color = arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_215_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_212_1.var_.actorSpriteComps10030 = nil
			end

			local var_215_15 = arg_212_1.actors_["10030"]
			local var_215_16 = 0

			if var_215_16 < arg_212_1.time_ and arg_212_1.time_ <= var_215_16 + arg_215_0 then
				local var_215_17 = var_215_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_215_17 then
					arg_212_1.var_.alphaOldValue10030 = var_215_17.alpha
					arg_212_1.var_.characterEffect10030 = var_215_17
				end

				arg_212_1.var_.alphaOldValue10030 = 0
			end

			local var_215_18 = 0.333333333333333

			if var_215_16 <= arg_212_1.time_ and arg_212_1.time_ < var_215_16 + var_215_18 then
				local var_215_19 = (arg_212_1.time_ - var_215_16) / var_215_18
				local var_215_20 = Mathf.Lerp(arg_212_1.var_.alphaOldValue10030, 1, var_215_19)

				if arg_212_1.var_.characterEffect10030 then
					arg_212_1.var_.characterEffect10030.alpha = var_215_20
				end
			end

			if arg_212_1.time_ >= var_215_16 + var_215_18 and arg_212_1.time_ < var_215_16 + var_215_18 + arg_215_0 and arg_212_1.var_.characterEffect10030 then
				arg_212_1.var_.characterEffect10030.alpha = 1
			end

			local var_215_21 = 0
			local var_215_22 = 0.775

			if var_215_21 < arg_212_1.time_ and arg_212_1.time_ <= var_215_21 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_23 = arg_212_1:FormatText(StoryNameCfg[309].name)

				arg_212_1.leftNameTxt_.text = var_215_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_24 = arg_212_1:GetWordFromCfg(115301053)
				local var_215_25 = arg_212_1:FormatText(var_215_24.content)

				arg_212_1.text_.text = var_215_25

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_26 = 31
				local var_215_27 = utf8.len(var_215_25)
				local var_215_28 = var_215_26 <= 0 and var_215_22 or var_215_22 * (var_215_27 / var_215_26)

				if var_215_28 > 0 and var_215_22 < var_215_28 then
					arg_212_1.talkMaxDuration = var_215_28

					if var_215_28 + var_215_21 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_28 + var_215_21
					end
				end

				arg_212_1.text_.text = var_215_25
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301053", "story_v_out_115301.awb") ~= 0 then
					local var_215_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301053", "story_v_out_115301.awb") / 1000

					if var_215_29 + var_215_21 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_29 + var_215_21
					end

					if var_215_24.prefab_name ~= "" and arg_212_1.actors_[var_215_24.prefab_name] ~= nil then
						local var_215_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_24.prefab_name].transform, "story_v_out_115301", "115301053", "story_v_out_115301.awb")

						arg_212_1:RecordAudio("115301053", var_215_30)
						arg_212_1:RecordAudio("115301053", var_215_30)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_115301", "115301053", "story_v_out_115301.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_115301", "115301053", "story_v_out_115301.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_31 = math.max(var_215_22, arg_212_1.talkMaxDuration)

			if var_215_21 <= arg_212_1.time_ and arg_212_1.time_ < var_215_21 + var_215_31 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_21) / var_215_31

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_21 + var_215_31 and arg_212_1.time_ < var_215_21 + var_215_31 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play115301054 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 115301054
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play115301055(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10030"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				local var_219_2 = var_219_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_219_2 then
					arg_216_1.var_.alphaOldValue10030 = var_219_2.alpha
					arg_216_1.var_.characterEffect10030 = var_219_2
				end

				arg_216_1.var_.alphaOldValue10030 = 1
			end

			local var_219_3 = 0.333333333333333

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_3 then
				local var_219_4 = (arg_216_1.time_ - var_219_1) / var_219_3
				local var_219_5 = Mathf.Lerp(arg_216_1.var_.alphaOldValue10030, 0, var_219_4)

				if arg_216_1.var_.characterEffect10030 then
					arg_216_1.var_.characterEffect10030.alpha = var_219_5
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_3 and arg_216_1.time_ < var_219_1 + var_219_3 + arg_219_0 and arg_216_1.var_.characterEffect10030 then
				arg_216_1.var_.characterEffect10030.alpha = 0
			end

			local var_219_6 = 0
			local var_219_7 = 1.575

			if var_219_6 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_8 = arg_216_1:GetWordFromCfg(115301054)
				local var_219_9 = arg_216_1:FormatText(var_219_8.content)

				arg_216_1.text_.text = var_219_9

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_10 = 63
				local var_219_11 = utf8.len(var_219_9)
				local var_219_12 = var_219_10 <= 0 and var_219_7 or var_219_7 * (var_219_11 / var_219_10)

				if var_219_12 > 0 and var_219_7 < var_219_12 then
					arg_216_1.talkMaxDuration = var_219_12

					if var_219_12 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_12 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_9
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_13 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_13 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_13

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_13 and arg_216_1.time_ < var_219_6 + var_219_13 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play115301055 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 115301055
		arg_220_1.duration_ = 14.33

		local var_220_0 = {
			ja = 14.333,
			ko = 9.4,
			zh = 9.6,
			en = 12.2
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play115301056(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1038"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos1038 = var_223_0.localPosition
				var_223_0.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("1038", 2)

				local var_223_2 = var_223_0.childCount

				for iter_223_0 = 0, var_223_2 - 1 do
					local var_223_3 = var_223_0:GetChild(iter_223_0)

					if var_223_3.name == "split_1" or not string.find(var_223_3.name, "split") then
						var_223_3.gameObject:SetActive(true)
					else
						var_223_3.gameObject:SetActive(false)
					end
				end
			end

			local var_223_4 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_4 then
				local var_223_5 = (arg_220_1.time_ - var_223_1) / var_223_4
				local var_223_6 = Vector3.New(-390, -400, 0)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1038, var_223_6, var_223_5)
			end

			if arg_220_1.time_ >= var_223_1 + var_223_4 and arg_220_1.time_ < var_223_1 + var_223_4 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_223_7 = arg_220_1.actors_["1038"]
			local var_223_8 = 0

			if var_223_8 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 then
				local var_223_9 = var_223_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_223_9 then
					arg_220_1.var_.alphaOldValue1038 = var_223_9.alpha
					arg_220_1.var_.characterEffect1038 = var_223_9
				end

				arg_220_1.var_.alphaOldValue1038 = 0
			end

			local var_223_10 = 0.333333333333333

			if var_223_8 <= arg_220_1.time_ and arg_220_1.time_ < var_223_8 + var_223_10 then
				local var_223_11 = (arg_220_1.time_ - var_223_8) / var_223_10
				local var_223_12 = Mathf.Lerp(arg_220_1.var_.alphaOldValue1038, 1, var_223_11)

				if arg_220_1.var_.characterEffect1038 then
					arg_220_1.var_.characterEffect1038.alpha = var_223_12
				end
			end

			if arg_220_1.time_ >= var_223_8 + var_223_10 and arg_220_1.time_ < var_223_8 + var_223_10 + arg_223_0 and arg_220_1.var_.characterEffect1038 then
				arg_220_1.var_.characterEffect1038.alpha = 1
			end

			local var_223_13 = 0
			local var_223_14 = 0.9

			if var_223_13 < arg_220_1.time_ and arg_220_1.time_ <= var_223_13 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_15 = arg_220_1:FormatText(StoryNameCfg[94].name)

				arg_220_1.leftNameTxt_.text = var_223_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_16 = arg_220_1:GetWordFromCfg(115301055)
				local var_223_17 = arg_220_1:FormatText(var_223_16.content)

				arg_220_1.text_.text = var_223_17

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_18 = 36
				local var_223_19 = utf8.len(var_223_17)
				local var_223_20 = var_223_18 <= 0 and var_223_14 or var_223_14 * (var_223_19 / var_223_18)

				if var_223_20 > 0 and var_223_14 < var_223_20 then
					arg_220_1.talkMaxDuration = var_223_20

					if var_223_20 + var_223_13 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_20 + var_223_13
					end
				end

				arg_220_1.text_.text = var_223_17
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301055", "story_v_out_115301.awb") ~= 0 then
					local var_223_21 = manager.audio:GetVoiceLength("story_v_out_115301", "115301055", "story_v_out_115301.awb") / 1000

					if var_223_21 + var_223_13 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_21 + var_223_13
					end

					if var_223_16.prefab_name ~= "" and arg_220_1.actors_[var_223_16.prefab_name] ~= nil then
						local var_223_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_16.prefab_name].transform, "story_v_out_115301", "115301055", "story_v_out_115301.awb")

						arg_220_1:RecordAudio("115301055", var_223_22)
						arg_220_1:RecordAudio("115301055", var_223_22)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_115301", "115301055", "story_v_out_115301.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_115301", "115301055", "story_v_out_115301.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_23 = math.max(var_223_14, arg_220_1.talkMaxDuration)

			if var_223_13 <= arg_220_1.time_ and arg_220_1.time_ < var_223_13 + var_223_23 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_13) / var_223_23

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_13 + var_223_23 and arg_220_1.time_ < var_223_13 + var_223_23 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play115301056 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 115301056
		arg_224_1.duration_ = 1.3

		local var_224_0 = {
			ja = 0.999999999999,
			ko = 1,
			zh = 1.233,
			en = 1.3
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play115301057(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10030"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos10030 = var_227_0.localPosition
				var_227_0.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("10030", 4)

				local var_227_2 = var_227_0.childCount

				for iter_227_0 = 0, var_227_2 - 1 do
					local var_227_3 = var_227_0:GetChild(iter_227_0)

					if var_227_3.name == "split_1" or not string.find(var_227_3.name, "split") then
						var_227_3.gameObject:SetActive(true)
					else
						var_227_3.gameObject:SetActive(false)
					end
				end
			end

			local var_227_4 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_4 then
				local var_227_5 = (arg_224_1.time_ - var_227_1) / var_227_4
				local var_227_6 = Vector3.New(390, -390, 150)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10030, var_227_6, var_227_5)
			end

			if arg_224_1.time_ >= var_227_1 + var_227_4 and arg_224_1.time_ < var_227_1 + var_227_4 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_227_7 = arg_224_1.actors_["1038"]
			local var_227_8 = 0

			if var_227_8 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 and not isNil(var_227_7) and arg_224_1.var_.actorSpriteComps1038 == nil then
				arg_224_1.var_.actorSpriteComps1038 = var_227_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_9 = 0.2

			if var_227_8 <= arg_224_1.time_ and arg_224_1.time_ < var_227_8 + var_227_9 and not isNil(var_227_7) then
				local var_227_10 = (arg_224_1.time_ - var_227_8) / var_227_9

				if arg_224_1.var_.actorSpriteComps1038 then
					for iter_227_1, iter_227_2 in pairs(arg_224_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_227_2 then
							if arg_224_1.isInRecall_ then
								local var_227_11 = Mathf.Lerp(iter_227_2.color.r, arg_224_1.hightColor2.r, var_227_10)
								local var_227_12 = Mathf.Lerp(iter_227_2.color.g, arg_224_1.hightColor2.g, var_227_10)
								local var_227_13 = Mathf.Lerp(iter_227_2.color.b, arg_224_1.hightColor2.b, var_227_10)

								iter_227_2.color = Color.New(var_227_11, var_227_12, var_227_13)
							else
								local var_227_14 = Mathf.Lerp(iter_227_2.color.r, 0.5, var_227_10)

								iter_227_2.color = Color.New(var_227_14, var_227_14, var_227_14)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_8 + var_227_9 and arg_224_1.time_ < var_227_8 + var_227_9 + arg_227_0 and not isNil(var_227_7) and arg_224_1.var_.actorSpriteComps1038 then
				for iter_227_3, iter_227_4 in pairs(arg_224_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_227_4 then
						if arg_224_1.isInRecall_ then
							iter_227_4.color = arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_227_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps1038 = nil
			end

			local var_227_15 = arg_224_1.actors_["10030"]
			local var_227_16 = 0

			if var_227_16 < arg_224_1.time_ and arg_224_1.time_ <= var_227_16 + arg_227_0 then
				local var_227_17 = var_227_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_227_17 then
					arg_224_1.var_.alphaOldValue10030 = var_227_17.alpha
					arg_224_1.var_.characterEffect10030 = var_227_17
				end

				arg_224_1.var_.alphaOldValue10030 = 0
			end

			local var_227_18 = 0.333333333333333

			if var_227_16 <= arg_224_1.time_ and arg_224_1.time_ < var_227_16 + var_227_18 then
				local var_227_19 = (arg_224_1.time_ - var_227_16) / var_227_18
				local var_227_20 = Mathf.Lerp(arg_224_1.var_.alphaOldValue10030, 1, var_227_19)

				if arg_224_1.var_.characterEffect10030 then
					arg_224_1.var_.characterEffect10030.alpha = var_227_20
				end
			end

			if arg_224_1.time_ >= var_227_16 + var_227_18 and arg_224_1.time_ < var_227_16 + var_227_18 + arg_227_0 and arg_224_1.var_.characterEffect10030 then
				arg_224_1.var_.characterEffect10030.alpha = 1
			end

			local var_227_21 = 0
			local var_227_22 = 0.1

			if var_227_21 < arg_224_1.time_ and arg_224_1.time_ <= var_227_21 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_23 = arg_224_1:FormatText(StoryNameCfg[309].name)

				arg_224_1.leftNameTxt_.text = var_227_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_24 = arg_224_1:GetWordFromCfg(115301056)
				local var_227_25 = arg_224_1:FormatText(var_227_24.content)

				arg_224_1.text_.text = var_227_25

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_26 = 4
				local var_227_27 = utf8.len(var_227_25)
				local var_227_28 = var_227_26 <= 0 and var_227_22 or var_227_22 * (var_227_27 / var_227_26)

				if var_227_28 > 0 and var_227_22 < var_227_28 then
					arg_224_1.talkMaxDuration = var_227_28

					if var_227_28 + var_227_21 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_28 + var_227_21
					end
				end

				arg_224_1.text_.text = var_227_25
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301056", "story_v_out_115301.awb") ~= 0 then
					local var_227_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301056", "story_v_out_115301.awb") / 1000

					if var_227_29 + var_227_21 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_29 + var_227_21
					end

					if var_227_24.prefab_name ~= "" and arg_224_1.actors_[var_227_24.prefab_name] ~= nil then
						local var_227_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_24.prefab_name].transform, "story_v_out_115301", "115301056", "story_v_out_115301.awb")

						arg_224_1:RecordAudio("115301056", var_227_30)
						arg_224_1:RecordAudio("115301056", var_227_30)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_115301", "115301056", "story_v_out_115301.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_115301", "115301056", "story_v_out_115301.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_31 = math.max(var_227_22, arg_224_1.talkMaxDuration)

			if var_227_21 <= arg_224_1.time_ and arg_224_1.time_ < var_227_21 + var_227_31 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_21) / var_227_31

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_21 + var_227_31 and arg_224_1.time_ < var_227_21 + var_227_31 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play115301057 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 115301057
		arg_228_1.duration_ = 8.3

		local var_228_0 = {
			ja = 8.3,
			ko = 5.033,
			zh = 6.2,
			en = 6.766
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play115301058(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10030"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps10030 == nil then
				arg_228_1.var_.actorSpriteComps10030 = var_231_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_2 = 0.2

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.actorSpriteComps10030 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								local var_231_4 = Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor2.r, var_231_3)
								local var_231_5 = Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor2.g, var_231_3)
								local var_231_6 = Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor2.b, var_231_3)

								iter_231_1.color = Color.New(var_231_4, var_231_5, var_231_6)
							else
								local var_231_7 = Mathf.Lerp(iter_231_1.color.r, 0.5, var_231_3)

								iter_231_1.color = Color.New(var_231_7, var_231_7, var_231_7)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps10030 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_231_3 then
						if arg_228_1.isInRecall_ then
							iter_231_3.color = arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_231_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10030 = nil
			end

			local var_231_8 = arg_228_1.actors_["1038"]
			local var_231_9 = 0

			if var_231_9 < arg_228_1.time_ and arg_228_1.time_ <= var_231_9 + arg_231_0 and not isNil(var_231_8) and arg_228_1.var_.actorSpriteComps1038 == nil then
				arg_228_1.var_.actorSpriteComps1038 = var_231_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_10 = 0.2

			if var_231_9 <= arg_228_1.time_ and arg_228_1.time_ < var_231_9 + var_231_10 and not isNil(var_231_8) then
				local var_231_11 = (arg_228_1.time_ - var_231_9) / var_231_10

				if arg_228_1.var_.actorSpriteComps1038 then
					for iter_231_4, iter_231_5 in pairs(arg_228_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_231_5 then
							if arg_228_1.isInRecall_ then
								local var_231_12 = Mathf.Lerp(iter_231_5.color.r, arg_228_1.hightColor1.r, var_231_11)
								local var_231_13 = Mathf.Lerp(iter_231_5.color.g, arg_228_1.hightColor1.g, var_231_11)
								local var_231_14 = Mathf.Lerp(iter_231_5.color.b, arg_228_1.hightColor1.b, var_231_11)

								iter_231_5.color = Color.New(var_231_12, var_231_13, var_231_14)
							else
								local var_231_15 = Mathf.Lerp(iter_231_5.color.r, 1, var_231_11)

								iter_231_5.color = Color.New(var_231_15, var_231_15, var_231_15)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_9 + var_231_10 and arg_228_1.time_ < var_231_9 + var_231_10 + arg_231_0 and not isNil(var_231_8) and arg_228_1.var_.actorSpriteComps1038 then
				for iter_231_6, iter_231_7 in pairs(arg_228_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_231_7 then
						if arg_228_1.isInRecall_ then
							iter_231_7.color = arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_231_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps1038 = nil
			end

			local var_231_16 = 0
			local var_231_17 = 0.6

			if var_231_16 < arg_228_1.time_ and arg_228_1.time_ <= var_231_16 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_18 = arg_228_1:FormatText(StoryNameCfg[94].name)

				arg_228_1.leftNameTxt_.text = var_231_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_19 = arg_228_1:GetWordFromCfg(115301057)
				local var_231_20 = arg_228_1:FormatText(var_231_19.content)

				arg_228_1.text_.text = var_231_20

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_21 = 24
				local var_231_22 = utf8.len(var_231_20)
				local var_231_23 = var_231_21 <= 0 and var_231_17 or var_231_17 * (var_231_22 / var_231_21)

				if var_231_23 > 0 and var_231_17 < var_231_23 then
					arg_228_1.talkMaxDuration = var_231_23

					if var_231_23 + var_231_16 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_23 + var_231_16
					end
				end

				arg_228_1.text_.text = var_231_20
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301057", "story_v_out_115301.awb") ~= 0 then
					local var_231_24 = manager.audio:GetVoiceLength("story_v_out_115301", "115301057", "story_v_out_115301.awb") / 1000

					if var_231_24 + var_231_16 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_24 + var_231_16
					end

					if var_231_19.prefab_name ~= "" and arg_228_1.actors_[var_231_19.prefab_name] ~= nil then
						local var_231_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_19.prefab_name].transform, "story_v_out_115301", "115301057", "story_v_out_115301.awb")

						arg_228_1:RecordAudio("115301057", var_231_25)
						arg_228_1:RecordAudio("115301057", var_231_25)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_115301", "115301057", "story_v_out_115301.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_115301", "115301057", "story_v_out_115301.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_26 = math.max(var_231_17, arg_228_1.talkMaxDuration)

			if var_231_16 <= arg_228_1.time_ and arg_228_1.time_ < var_231_16 + var_231_26 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_16) / var_231_26

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_16 + var_231_26 and arg_228_1.time_ < var_231_16 + var_231_26 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play115301058 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 115301058
		arg_232_1.duration_ = 10.4

		local var_232_0 = {
			ja = 10.4,
			ko = 7.3,
			zh = 7.566,
			en = 7.7
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play115301059(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10030"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps10030 == nil then
				arg_232_1.var_.actorSpriteComps10030 = var_235_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_2 = 0.2

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.actorSpriteComps10030 then
					for iter_235_0, iter_235_1 in pairs(arg_232_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_235_1 then
							if arg_232_1.isInRecall_ then
								local var_235_4 = Mathf.Lerp(iter_235_1.color.r, arg_232_1.hightColor1.r, var_235_3)
								local var_235_5 = Mathf.Lerp(iter_235_1.color.g, arg_232_1.hightColor1.g, var_235_3)
								local var_235_6 = Mathf.Lerp(iter_235_1.color.b, arg_232_1.hightColor1.b, var_235_3)

								iter_235_1.color = Color.New(var_235_4, var_235_5, var_235_6)
							else
								local var_235_7 = Mathf.Lerp(iter_235_1.color.r, 1, var_235_3)

								iter_235_1.color = Color.New(var_235_7, var_235_7, var_235_7)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps10030 then
				for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_235_3 then
						if arg_232_1.isInRecall_ then
							iter_235_3.color = arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_235_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps10030 = nil
			end

			local var_235_8 = arg_232_1.actors_["1038"]
			local var_235_9 = 0

			if var_235_9 < arg_232_1.time_ and arg_232_1.time_ <= var_235_9 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps1038 == nil then
				arg_232_1.var_.actorSpriteComps1038 = var_235_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_10 = 0.2

			if var_235_9 <= arg_232_1.time_ and arg_232_1.time_ < var_235_9 + var_235_10 and not isNil(var_235_8) then
				local var_235_11 = (arg_232_1.time_ - var_235_9) / var_235_10

				if arg_232_1.var_.actorSpriteComps1038 then
					for iter_235_4, iter_235_5 in pairs(arg_232_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_235_5 then
							if arg_232_1.isInRecall_ then
								local var_235_12 = Mathf.Lerp(iter_235_5.color.r, arg_232_1.hightColor2.r, var_235_11)
								local var_235_13 = Mathf.Lerp(iter_235_5.color.g, arg_232_1.hightColor2.g, var_235_11)
								local var_235_14 = Mathf.Lerp(iter_235_5.color.b, arg_232_1.hightColor2.b, var_235_11)

								iter_235_5.color = Color.New(var_235_12, var_235_13, var_235_14)
							else
								local var_235_15 = Mathf.Lerp(iter_235_5.color.r, 0.5, var_235_11)

								iter_235_5.color = Color.New(var_235_15, var_235_15, var_235_15)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_9 + var_235_10 and arg_232_1.time_ < var_235_9 + var_235_10 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps1038 then
				for iter_235_6, iter_235_7 in pairs(arg_232_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_235_7 then
						if arg_232_1.isInRecall_ then
							iter_235_7.color = arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_235_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps1038 = nil
			end

			local var_235_16 = 0
			local var_235_17 = 0.775

			if var_235_16 < arg_232_1.time_ and arg_232_1.time_ <= var_235_16 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_18 = arg_232_1:FormatText(StoryNameCfg[309].name)

				arg_232_1.leftNameTxt_.text = var_235_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_19 = arg_232_1:GetWordFromCfg(115301058)
				local var_235_20 = arg_232_1:FormatText(var_235_19.content)

				arg_232_1.text_.text = var_235_20

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_21 = 31
				local var_235_22 = utf8.len(var_235_20)
				local var_235_23 = var_235_21 <= 0 and var_235_17 or var_235_17 * (var_235_22 / var_235_21)

				if var_235_23 > 0 and var_235_17 < var_235_23 then
					arg_232_1.talkMaxDuration = var_235_23

					if var_235_23 + var_235_16 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_23 + var_235_16
					end
				end

				arg_232_1.text_.text = var_235_20
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301058", "story_v_out_115301.awb") ~= 0 then
					local var_235_24 = manager.audio:GetVoiceLength("story_v_out_115301", "115301058", "story_v_out_115301.awb") / 1000

					if var_235_24 + var_235_16 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_24 + var_235_16
					end

					if var_235_19.prefab_name ~= "" and arg_232_1.actors_[var_235_19.prefab_name] ~= nil then
						local var_235_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_19.prefab_name].transform, "story_v_out_115301", "115301058", "story_v_out_115301.awb")

						arg_232_1:RecordAudio("115301058", var_235_25)
						arg_232_1:RecordAudio("115301058", var_235_25)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_115301", "115301058", "story_v_out_115301.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_115301", "115301058", "story_v_out_115301.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_26 = math.max(var_235_17, arg_232_1.talkMaxDuration)

			if var_235_16 <= arg_232_1.time_ and arg_232_1.time_ < var_235_16 + var_235_26 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_16) / var_235_26

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_16 + var_235_26 and arg_232_1.time_ < var_235_16 + var_235_26 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play115301059 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 115301059
		arg_236_1.duration_ = 2.4

		local var_236_0 = {
			ja = 1.766,
			ko = 1.333,
			zh = 2.4,
			en = 1.366
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play115301060(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10030"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps10030 == nil then
				arg_236_1.var_.actorSpriteComps10030 = var_239_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_2 = 0.2

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.actorSpriteComps10030 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								local var_239_4 = Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor2.r, var_239_3)
								local var_239_5 = Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor2.g, var_239_3)
								local var_239_6 = Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor2.b, var_239_3)

								iter_239_1.color = Color.New(var_239_4, var_239_5, var_239_6)
							else
								local var_239_7 = Mathf.Lerp(iter_239_1.color.r, 0.5, var_239_3)

								iter_239_1.color = Color.New(var_239_7, var_239_7, var_239_7)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps10030 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_239_3 then
						if arg_236_1.isInRecall_ then
							iter_239_3.color = arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_239_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps10030 = nil
			end

			local var_239_8 = arg_236_1.actors_["1038"]
			local var_239_9 = 0

			if var_239_9 < arg_236_1.time_ and arg_236_1.time_ <= var_239_9 + arg_239_0 and not isNil(var_239_8) and arg_236_1.var_.actorSpriteComps1038 == nil then
				arg_236_1.var_.actorSpriteComps1038 = var_239_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_10 = 0.2

			if var_239_9 <= arg_236_1.time_ and arg_236_1.time_ < var_239_9 + var_239_10 and not isNil(var_239_8) then
				local var_239_11 = (arg_236_1.time_ - var_239_9) / var_239_10

				if arg_236_1.var_.actorSpriteComps1038 then
					for iter_239_4, iter_239_5 in pairs(arg_236_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_239_5 then
							if arg_236_1.isInRecall_ then
								local var_239_12 = Mathf.Lerp(iter_239_5.color.r, arg_236_1.hightColor1.r, var_239_11)
								local var_239_13 = Mathf.Lerp(iter_239_5.color.g, arg_236_1.hightColor1.g, var_239_11)
								local var_239_14 = Mathf.Lerp(iter_239_5.color.b, arg_236_1.hightColor1.b, var_239_11)

								iter_239_5.color = Color.New(var_239_12, var_239_13, var_239_14)
							else
								local var_239_15 = Mathf.Lerp(iter_239_5.color.r, 1, var_239_11)

								iter_239_5.color = Color.New(var_239_15, var_239_15, var_239_15)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_9 + var_239_10 and arg_236_1.time_ < var_239_9 + var_239_10 + arg_239_0 and not isNil(var_239_8) and arg_236_1.var_.actorSpriteComps1038 then
				for iter_239_6, iter_239_7 in pairs(arg_236_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_239_7 then
						if arg_236_1.isInRecall_ then
							iter_239_7.color = arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_239_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps1038 = nil
			end

			local var_239_16 = arg_236_1.actors_["1038"].transform
			local var_239_17 = 0

			if var_239_17 < arg_236_1.time_ and arg_236_1.time_ <= var_239_17 + arg_239_0 then
				arg_236_1.var_.moveOldPos1038 = var_239_16.localPosition
				var_239_16.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("1038", 2)

				local var_239_18 = var_239_16.childCount

				for iter_239_8 = 0, var_239_18 - 1 do
					local var_239_19 = var_239_16:GetChild(iter_239_8)

					if var_239_19.name == "split_7" or not string.find(var_239_19.name, "split") then
						var_239_19.gameObject:SetActive(true)
					else
						var_239_19.gameObject:SetActive(false)
					end
				end
			end

			local var_239_20 = 0.001

			if var_239_17 <= arg_236_1.time_ and arg_236_1.time_ < var_239_17 + var_239_20 then
				local var_239_21 = (arg_236_1.time_ - var_239_17) / var_239_20
				local var_239_22 = Vector3.New(-390, -400, 0)

				var_239_16.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1038, var_239_22, var_239_21)
			end

			if arg_236_1.time_ >= var_239_17 + var_239_20 and arg_236_1.time_ < var_239_17 + var_239_20 + arg_239_0 then
				var_239_16.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_239_23 = 0
			local var_239_24 = 0.075

			if var_239_23 < arg_236_1.time_ and arg_236_1.time_ <= var_239_23 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_25 = arg_236_1:FormatText(StoryNameCfg[94].name)

				arg_236_1.leftNameTxt_.text = var_239_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_26 = arg_236_1:GetWordFromCfg(115301059)
				local var_239_27 = arg_236_1:FormatText(var_239_26.content)

				arg_236_1.text_.text = var_239_27

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_28 = 3
				local var_239_29 = utf8.len(var_239_27)
				local var_239_30 = var_239_28 <= 0 and var_239_24 or var_239_24 * (var_239_29 / var_239_28)

				if var_239_30 > 0 and var_239_24 < var_239_30 then
					arg_236_1.talkMaxDuration = var_239_30

					if var_239_30 + var_239_23 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_30 + var_239_23
					end
				end

				arg_236_1.text_.text = var_239_27
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301059", "story_v_out_115301.awb") ~= 0 then
					local var_239_31 = manager.audio:GetVoiceLength("story_v_out_115301", "115301059", "story_v_out_115301.awb") / 1000

					if var_239_31 + var_239_23 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_31 + var_239_23
					end

					if var_239_26.prefab_name ~= "" and arg_236_1.actors_[var_239_26.prefab_name] ~= nil then
						local var_239_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_26.prefab_name].transform, "story_v_out_115301", "115301059", "story_v_out_115301.awb")

						arg_236_1:RecordAudio("115301059", var_239_32)
						arg_236_1:RecordAudio("115301059", var_239_32)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_115301", "115301059", "story_v_out_115301.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_115301", "115301059", "story_v_out_115301.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_33 = math.max(var_239_24, arg_236_1.talkMaxDuration)

			if var_239_23 <= arg_236_1.time_ and arg_236_1.time_ < var_239_23 + var_239_33 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_23) / var_239_33

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_23 + var_239_33 and arg_236_1.time_ < var_239_23 + var_239_33 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play115301060 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 115301060
		arg_240_1.duration_ = 2.27

		local var_240_0 = {
			ja = 2.266,
			ko = 1.7,
			zh = 1.933,
			en = 1.333
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play115301061(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["10030"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps10030 == nil then
				arg_240_1.var_.actorSpriteComps10030 = var_243_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_2 = 0.2

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.actorSpriteComps10030 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_243_1 then
							if arg_240_1.isInRecall_ then
								local var_243_4 = Mathf.Lerp(iter_243_1.color.r, arg_240_1.hightColor1.r, var_243_3)
								local var_243_5 = Mathf.Lerp(iter_243_1.color.g, arg_240_1.hightColor1.g, var_243_3)
								local var_243_6 = Mathf.Lerp(iter_243_1.color.b, arg_240_1.hightColor1.b, var_243_3)

								iter_243_1.color = Color.New(var_243_4, var_243_5, var_243_6)
							else
								local var_243_7 = Mathf.Lerp(iter_243_1.color.r, 1, var_243_3)

								iter_243_1.color = Color.New(var_243_7, var_243_7, var_243_7)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps10030 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_243_3 then
						if arg_240_1.isInRecall_ then
							iter_243_3.color = arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_243_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_240_1.var_.actorSpriteComps10030 = nil
			end

			local var_243_8 = arg_240_1.actors_["1038"]
			local var_243_9 = 0

			if var_243_9 < arg_240_1.time_ and arg_240_1.time_ <= var_243_9 + arg_243_0 and not isNil(var_243_8) and arg_240_1.var_.actorSpriteComps1038 == nil then
				arg_240_1.var_.actorSpriteComps1038 = var_243_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_10 = 0.2

			if var_243_9 <= arg_240_1.time_ and arg_240_1.time_ < var_243_9 + var_243_10 and not isNil(var_243_8) then
				local var_243_11 = (arg_240_1.time_ - var_243_9) / var_243_10

				if arg_240_1.var_.actorSpriteComps1038 then
					for iter_243_4, iter_243_5 in pairs(arg_240_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_243_5 then
							if arg_240_1.isInRecall_ then
								local var_243_12 = Mathf.Lerp(iter_243_5.color.r, arg_240_1.hightColor2.r, var_243_11)
								local var_243_13 = Mathf.Lerp(iter_243_5.color.g, arg_240_1.hightColor2.g, var_243_11)
								local var_243_14 = Mathf.Lerp(iter_243_5.color.b, arg_240_1.hightColor2.b, var_243_11)

								iter_243_5.color = Color.New(var_243_12, var_243_13, var_243_14)
							else
								local var_243_15 = Mathf.Lerp(iter_243_5.color.r, 0.5, var_243_11)

								iter_243_5.color = Color.New(var_243_15, var_243_15, var_243_15)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= var_243_9 + var_243_10 and arg_240_1.time_ < var_243_9 + var_243_10 + arg_243_0 and not isNil(var_243_8) and arg_240_1.var_.actorSpriteComps1038 then
				for iter_243_6, iter_243_7 in pairs(arg_240_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_243_7 then
						if arg_240_1.isInRecall_ then
							iter_243_7.color = arg_240_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_243_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_240_1.var_.actorSpriteComps1038 = nil
			end

			local var_243_16 = arg_240_1.actors_["10030"].transform
			local var_243_17 = 0

			if var_243_17 < arg_240_1.time_ and arg_240_1.time_ <= var_243_17 + arg_243_0 then
				arg_240_1.var_.moveOldPos10030 = var_243_16.localPosition
				var_243_16.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10030", 4)

				local var_243_18 = var_243_16.childCount

				for iter_243_8 = 0, var_243_18 - 1 do
					local var_243_19 = var_243_16:GetChild(iter_243_8)

					if var_243_19.name == "split_4" or not string.find(var_243_19.name, "split") then
						var_243_19.gameObject:SetActive(true)
					else
						var_243_19.gameObject:SetActive(false)
					end
				end
			end

			local var_243_20 = 0.001

			if var_243_17 <= arg_240_1.time_ and arg_240_1.time_ < var_243_17 + var_243_20 then
				local var_243_21 = (arg_240_1.time_ - var_243_17) / var_243_20
				local var_243_22 = Vector3.New(390, -390, 150)

				var_243_16.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10030, var_243_22, var_243_21)
			end

			if arg_240_1.time_ >= var_243_17 + var_243_20 and arg_240_1.time_ < var_243_17 + var_243_20 + arg_243_0 then
				var_243_16.localPosition = Vector3.New(390, -390, 150)
			end

			local var_243_23 = 0
			local var_243_24 = 0.075

			if var_243_23 < arg_240_1.time_ and arg_240_1.time_ <= var_243_23 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_25 = arg_240_1:FormatText(StoryNameCfg[309].name)

				arg_240_1.leftNameTxt_.text = var_243_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_26 = arg_240_1:GetWordFromCfg(115301060)
				local var_243_27 = arg_240_1:FormatText(var_243_26.content)

				arg_240_1.text_.text = var_243_27

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_28 = 3
				local var_243_29 = utf8.len(var_243_27)
				local var_243_30 = var_243_28 <= 0 and var_243_24 or var_243_24 * (var_243_29 / var_243_28)

				if var_243_30 > 0 and var_243_24 < var_243_30 then
					arg_240_1.talkMaxDuration = var_243_30

					if var_243_30 + var_243_23 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_30 + var_243_23
					end
				end

				arg_240_1.text_.text = var_243_27
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301060", "story_v_out_115301.awb") ~= 0 then
					local var_243_31 = manager.audio:GetVoiceLength("story_v_out_115301", "115301060", "story_v_out_115301.awb") / 1000

					if var_243_31 + var_243_23 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_31 + var_243_23
					end

					if var_243_26.prefab_name ~= "" and arg_240_1.actors_[var_243_26.prefab_name] ~= nil then
						local var_243_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_26.prefab_name].transform, "story_v_out_115301", "115301060", "story_v_out_115301.awb")

						arg_240_1:RecordAudio("115301060", var_243_32)
						arg_240_1:RecordAudio("115301060", var_243_32)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_115301", "115301060", "story_v_out_115301.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_115301", "115301060", "story_v_out_115301.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_33 = math.max(var_243_24, arg_240_1.talkMaxDuration)

			if var_243_23 <= arg_240_1.time_ and arg_240_1.time_ < var_243_23 + var_243_33 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_23) / var_243_33

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_23 + var_243_33 and arg_240_1.time_ < var_243_23 + var_243_33 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play115301061 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 115301061
		arg_244_1.duration_ = 8.13

		local var_244_0 = {
			ja = 6.8,
			ko = 4.533,
			zh = 8.133,
			en = 5.566
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play115301062(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10030"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps10030 == nil then
				arg_244_1.var_.actorSpriteComps10030 = var_247_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_2 = 0.2

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.actorSpriteComps10030 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								local var_247_4 = Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor2.r, var_247_3)
								local var_247_5 = Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor2.g, var_247_3)
								local var_247_6 = Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor2.b, var_247_3)

								iter_247_1.color = Color.New(var_247_4, var_247_5, var_247_6)
							else
								local var_247_7 = Mathf.Lerp(iter_247_1.color.r, 0.5, var_247_3)

								iter_247_1.color = Color.New(var_247_7, var_247_7, var_247_7)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps10030 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_247_3 then
						if arg_244_1.isInRecall_ then
							iter_247_3.color = arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_247_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps10030 = nil
			end

			local var_247_8 = arg_244_1.actors_["1038"]
			local var_247_9 = 0

			if var_247_9 < arg_244_1.time_ and arg_244_1.time_ <= var_247_9 + arg_247_0 and not isNil(var_247_8) and arg_244_1.var_.actorSpriteComps1038 == nil then
				arg_244_1.var_.actorSpriteComps1038 = var_247_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_10 = 0.2

			if var_247_9 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_10 and not isNil(var_247_8) then
				local var_247_11 = (arg_244_1.time_ - var_247_9) / var_247_10

				if arg_244_1.var_.actorSpriteComps1038 then
					for iter_247_4, iter_247_5 in pairs(arg_244_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_247_5 then
							if arg_244_1.isInRecall_ then
								local var_247_12 = Mathf.Lerp(iter_247_5.color.r, arg_244_1.hightColor1.r, var_247_11)
								local var_247_13 = Mathf.Lerp(iter_247_5.color.g, arg_244_1.hightColor1.g, var_247_11)
								local var_247_14 = Mathf.Lerp(iter_247_5.color.b, arg_244_1.hightColor1.b, var_247_11)

								iter_247_5.color = Color.New(var_247_12, var_247_13, var_247_14)
							else
								local var_247_15 = Mathf.Lerp(iter_247_5.color.r, 1, var_247_11)

								iter_247_5.color = Color.New(var_247_15, var_247_15, var_247_15)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_9 + var_247_10 and arg_244_1.time_ < var_247_9 + var_247_10 + arg_247_0 and not isNil(var_247_8) and arg_244_1.var_.actorSpriteComps1038 then
				for iter_247_6, iter_247_7 in pairs(arg_244_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_247_7 then
						if arg_244_1.isInRecall_ then
							iter_247_7.color = arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_247_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps1038 = nil
			end

			local var_247_16 = 0
			local var_247_17 = 0.775

			if var_247_16 < arg_244_1.time_ and arg_244_1.time_ <= var_247_16 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_18 = arg_244_1:FormatText(StoryNameCfg[94].name)

				arg_244_1.leftNameTxt_.text = var_247_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_19 = arg_244_1:GetWordFromCfg(115301061)
				local var_247_20 = arg_244_1:FormatText(var_247_19.content)

				arg_244_1.text_.text = var_247_20

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_21 = 31
				local var_247_22 = utf8.len(var_247_20)
				local var_247_23 = var_247_21 <= 0 and var_247_17 or var_247_17 * (var_247_22 / var_247_21)

				if var_247_23 > 0 and var_247_17 < var_247_23 then
					arg_244_1.talkMaxDuration = var_247_23

					if var_247_23 + var_247_16 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_23 + var_247_16
					end
				end

				arg_244_1.text_.text = var_247_20
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301061", "story_v_out_115301.awb") ~= 0 then
					local var_247_24 = manager.audio:GetVoiceLength("story_v_out_115301", "115301061", "story_v_out_115301.awb") / 1000

					if var_247_24 + var_247_16 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_24 + var_247_16
					end

					if var_247_19.prefab_name ~= "" and arg_244_1.actors_[var_247_19.prefab_name] ~= nil then
						local var_247_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_19.prefab_name].transform, "story_v_out_115301", "115301061", "story_v_out_115301.awb")

						arg_244_1:RecordAudio("115301061", var_247_25)
						arg_244_1:RecordAudio("115301061", var_247_25)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_115301", "115301061", "story_v_out_115301.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_115301", "115301061", "story_v_out_115301.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_26 = math.max(var_247_17, arg_244_1.talkMaxDuration)

			if var_247_16 <= arg_244_1.time_ and arg_244_1.time_ < var_247_16 + var_247_26 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_16) / var_247_26

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_16 + var_247_26 and arg_244_1.time_ < var_247_16 + var_247_26 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play115301062 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 115301062
		arg_248_1.duration_ = 1.8

		local var_248_0 = {
			ja = 1.2,
			ko = 0.999999999999,
			zh = 1.8,
			en = 1.1
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play115301063(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10030"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps10030 == nil then
				arg_248_1.var_.actorSpriteComps10030 = var_251_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_2 = 0.2

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.actorSpriteComps10030 then
					for iter_251_0, iter_251_1 in pairs(arg_248_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_251_1 then
							if arg_248_1.isInRecall_ then
								local var_251_4 = Mathf.Lerp(iter_251_1.color.r, arg_248_1.hightColor1.r, var_251_3)
								local var_251_5 = Mathf.Lerp(iter_251_1.color.g, arg_248_1.hightColor1.g, var_251_3)
								local var_251_6 = Mathf.Lerp(iter_251_1.color.b, arg_248_1.hightColor1.b, var_251_3)

								iter_251_1.color = Color.New(var_251_4, var_251_5, var_251_6)
							else
								local var_251_7 = Mathf.Lerp(iter_251_1.color.r, 1, var_251_3)

								iter_251_1.color = Color.New(var_251_7, var_251_7, var_251_7)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps10030 then
				for iter_251_2, iter_251_3 in pairs(arg_248_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_251_3 then
						if arg_248_1.isInRecall_ then
							iter_251_3.color = arg_248_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_251_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_248_1.var_.actorSpriteComps10030 = nil
			end

			local var_251_8 = arg_248_1.actors_["1038"]
			local var_251_9 = 0

			if var_251_9 < arg_248_1.time_ and arg_248_1.time_ <= var_251_9 + arg_251_0 and not isNil(var_251_8) and arg_248_1.var_.actorSpriteComps1038 == nil then
				arg_248_1.var_.actorSpriteComps1038 = var_251_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_10 = 0.2

			if var_251_9 <= arg_248_1.time_ and arg_248_1.time_ < var_251_9 + var_251_10 and not isNil(var_251_8) then
				local var_251_11 = (arg_248_1.time_ - var_251_9) / var_251_10

				if arg_248_1.var_.actorSpriteComps1038 then
					for iter_251_4, iter_251_5 in pairs(arg_248_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_251_5 then
							if arg_248_1.isInRecall_ then
								local var_251_12 = Mathf.Lerp(iter_251_5.color.r, arg_248_1.hightColor2.r, var_251_11)
								local var_251_13 = Mathf.Lerp(iter_251_5.color.g, arg_248_1.hightColor2.g, var_251_11)
								local var_251_14 = Mathf.Lerp(iter_251_5.color.b, arg_248_1.hightColor2.b, var_251_11)

								iter_251_5.color = Color.New(var_251_12, var_251_13, var_251_14)
							else
								local var_251_15 = Mathf.Lerp(iter_251_5.color.r, 0.5, var_251_11)

								iter_251_5.color = Color.New(var_251_15, var_251_15, var_251_15)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= var_251_9 + var_251_10 and arg_248_1.time_ < var_251_9 + var_251_10 + arg_251_0 and not isNil(var_251_8) and arg_248_1.var_.actorSpriteComps1038 then
				for iter_251_6, iter_251_7 in pairs(arg_248_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_251_7 then
						if arg_248_1.isInRecall_ then
							iter_251_7.color = arg_248_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_251_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_248_1.var_.actorSpriteComps1038 = nil
			end

			local var_251_16 = arg_248_1.actors_["10030"].transform
			local var_251_17 = 0

			if var_251_17 < arg_248_1.time_ and arg_248_1.time_ <= var_251_17 + arg_251_0 then
				arg_248_1.var_.moveOldPos10030 = var_251_16.localPosition
				var_251_16.localScale = Vector3.New(1, 1, 1)

				arg_248_1:CheckSpriteTmpPos("10030", 4)

				local var_251_18 = var_251_16.childCount

				for iter_251_8 = 0, var_251_18 - 1 do
					local var_251_19 = var_251_16:GetChild(iter_251_8)

					if var_251_19.name == "split_1" or not string.find(var_251_19.name, "split") then
						var_251_19.gameObject:SetActive(true)
					else
						var_251_19.gameObject:SetActive(false)
					end
				end
			end

			local var_251_20 = 0.001

			if var_251_17 <= arg_248_1.time_ and arg_248_1.time_ < var_251_17 + var_251_20 then
				local var_251_21 = (arg_248_1.time_ - var_251_17) / var_251_20
				local var_251_22 = Vector3.New(390, -390, 150)

				var_251_16.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10030, var_251_22, var_251_21)
			end

			if arg_248_1.time_ >= var_251_17 + var_251_20 and arg_248_1.time_ < var_251_17 + var_251_20 + arg_251_0 then
				var_251_16.localPosition = Vector3.New(390, -390, 150)
			end

			local var_251_23 = 0
			local var_251_24 = 0.1

			if var_251_23 < arg_248_1.time_ and arg_248_1.time_ <= var_251_23 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_25 = arg_248_1:FormatText(StoryNameCfg[309].name)

				arg_248_1.leftNameTxt_.text = var_251_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_26 = arg_248_1:GetWordFromCfg(115301062)
				local var_251_27 = arg_248_1:FormatText(var_251_26.content)

				arg_248_1.text_.text = var_251_27

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_28 = 4
				local var_251_29 = utf8.len(var_251_27)
				local var_251_30 = var_251_28 <= 0 and var_251_24 or var_251_24 * (var_251_29 / var_251_28)

				if var_251_30 > 0 and var_251_24 < var_251_30 then
					arg_248_1.talkMaxDuration = var_251_30

					if var_251_30 + var_251_23 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_30 + var_251_23
					end
				end

				arg_248_1.text_.text = var_251_27
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301062", "story_v_out_115301.awb") ~= 0 then
					local var_251_31 = manager.audio:GetVoiceLength("story_v_out_115301", "115301062", "story_v_out_115301.awb") / 1000

					if var_251_31 + var_251_23 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_31 + var_251_23
					end

					if var_251_26.prefab_name ~= "" and arg_248_1.actors_[var_251_26.prefab_name] ~= nil then
						local var_251_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_26.prefab_name].transform, "story_v_out_115301", "115301062", "story_v_out_115301.awb")

						arg_248_1:RecordAudio("115301062", var_251_32)
						arg_248_1:RecordAudio("115301062", var_251_32)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_115301", "115301062", "story_v_out_115301.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_115301", "115301062", "story_v_out_115301.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_33 = math.max(var_251_24, arg_248_1.talkMaxDuration)

			if var_251_23 <= arg_248_1.time_ and arg_248_1.time_ < var_251_23 + var_251_33 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_23) / var_251_33

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_23 + var_251_33 and arg_248_1.time_ < var_251_23 + var_251_33 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play115301063 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 115301063
		arg_252_1.duration_ = 12.57

		local var_252_0 = {
			ja = 9.766,
			ko = 7.6,
			zh = 11.666,
			en = 12.566
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play115301064(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10030"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps10030 == nil then
				arg_252_1.var_.actorSpriteComps10030 = var_255_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_2 = 0.2

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.actorSpriteComps10030 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								local var_255_4 = Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor2.r, var_255_3)
								local var_255_5 = Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor2.g, var_255_3)
								local var_255_6 = Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor2.b, var_255_3)

								iter_255_1.color = Color.New(var_255_4, var_255_5, var_255_6)
							else
								local var_255_7 = Mathf.Lerp(iter_255_1.color.r, 0.5, var_255_3)

								iter_255_1.color = Color.New(var_255_7, var_255_7, var_255_7)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps10030 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_255_3 then
						if arg_252_1.isInRecall_ then
							iter_255_3.color = arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_255_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps10030 = nil
			end

			local var_255_8 = arg_252_1.actors_["1038"]
			local var_255_9 = 0

			if var_255_9 < arg_252_1.time_ and arg_252_1.time_ <= var_255_9 + arg_255_0 and not isNil(var_255_8) and arg_252_1.var_.actorSpriteComps1038 == nil then
				arg_252_1.var_.actorSpriteComps1038 = var_255_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_10 = 0.2

			if var_255_9 <= arg_252_1.time_ and arg_252_1.time_ < var_255_9 + var_255_10 and not isNil(var_255_8) then
				local var_255_11 = (arg_252_1.time_ - var_255_9) / var_255_10

				if arg_252_1.var_.actorSpriteComps1038 then
					for iter_255_4, iter_255_5 in pairs(arg_252_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_255_5 then
							if arg_252_1.isInRecall_ then
								local var_255_12 = Mathf.Lerp(iter_255_5.color.r, arg_252_1.hightColor1.r, var_255_11)
								local var_255_13 = Mathf.Lerp(iter_255_5.color.g, arg_252_1.hightColor1.g, var_255_11)
								local var_255_14 = Mathf.Lerp(iter_255_5.color.b, arg_252_1.hightColor1.b, var_255_11)

								iter_255_5.color = Color.New(var_255_12, var_255_13, var_255_14)
							else
								local var_255_15 = Mathf.Lerp(iter_255_5.color.r, 1, var_255_11)

								iter_255_5.color = Color.New(var_255_15, var_255_15, var_255_15)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_9 + var_255_10 and arg_252_1.time_ < var_255_9 + var_255_10 + arg_255_0 and not isNil(var_255_8) and arg_252_1.var_.actorSpriteComps1038 then
				for iter_255_6, iter_255_7 in pairs(arg_252_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_255_7 then
						if arg_252_1.isInRecall_ then
							iter_255_7.color = arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_255_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps1038 = nil
			end

			local var_255_16 = 0
			local var_255_17 = 1.125

			if var_255_16 < arg_252_1.time_ and arg_252_1.time_ <= var_255_16 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_18 = arg_252_1:FormatText(StoryNameCfg[94].name)

				arg_252_1.leftNameTxt_.text = var_255_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_19 = arg_252_1:GetWordFromCfg(115301063)
				local var_255_20 = arg_252_1:FormatText(var_255_19.content)

				arg_252_1.text_.text = var_255_20

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_21 = 45
				local var_255_22 = utf8.len(var_255_20)
				local var_255_23 = var_255_21 <= 0 and var_255_17 or var_255_17 * (var_255_22 / var_255_21)

				if var_255_23 > 0 and var_255_17 < var_255_23 then
					arg_252_1.talkMaxDuration = var_255_23

					if var_255_23 + var_255_16 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_23 + var_255_16
					end
				end

				arg_252_1.text_.text = var_255_20
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301063", "story_v_out_115301.awb") ~= 0 then
					local var_255_24 = manager.audio:GetVoiceLength("story_v_out_115301", "115301063", "story_v_out_115301.awb") / 1000

					if var_255_24 + var_255_16 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_24 + var_255_16
					end

					if var_255_19.prefab_name ~= "" and arg_252_1.actors_[var_255_19.prefab_name] ~= nil then
						local var_255_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_19.prefab_name].transform, "story_v_out_115301", "115301063", "story_v_out_115301.awb")

						arg_252_1:RecordAudio("115301063", var_255_25)
						arg_252_1:RecordAudio("115301063", var_255_25)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_115301", "115301063", "story_v_out_115301.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_115301", "115301063", "story_v_out_115301.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_26 = math.max(var_255_17, arg_252_1.talkMaxDuration)

			if var_255_16 <= arg_252_1.time_ and arg_252_1.time_ < var_255_16 + var_255_26 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_16) / var_255_26

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_16 + var_255_26 and arg_252_1.time_ < var_255_16 + var_255_26 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play115301064 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 115301064
		arg_256_1.duration_ = 13.17

		local var_256_0 = {
			ja = 13.166,
			ko = 11.9,
			zh = 12.5,
			en = 12.366
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play115301065(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 1.2

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[94].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:GetWordFromCfg(115301064)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 48
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301064", "story_v_out_115301.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301064", "story_v_out_115301.awb") / 1000

					if var_259_8 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_0
					end

					if var_259_3.prefab_name ~= "" and arg_256_1.actors_[var_259_3.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_3.prefab_name].transform, "story_v_out_115301", "115301064", "story_v_out_115301.awb")

						arg_256_1:RecordAudio("115301064", var_259_9)
						arg_256_1:RecordAudio("115301064", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_115301", "115301064", "story_v_out_115301.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_115301", "115301064", "story_v_out_115301.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_10 and arg_256_1.time_ < var_259_0 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play115301065 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 115301065
		arg_260_1.duration_ = 9.93

		local var_260_0 = {
			ja = 9.933,
			ko = 5.966,
			zh = 7.6,
			en = 5.6
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play115301066(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.7

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[94].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_3 = arg_260_1:GetWordFromCfg(115301065)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 28
				local var_263_6 = utf8.len(var_263_4)
				local var_263_7 = var_263_5 <= 0 and var_263_1 or var_263_1 * (var_263_6 / var_263_5)

				if var_263_7 > 0 and var_263_1 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301065", "story_v_out_115301.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301065", "story_v_out_115301.awb") / 1000

					if var_263_8 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_0
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_115301", "115301065", "story_v_out_115301.awb")

						arg_260_1:RecordAudio("115301065", var_263_9)
						arg_260_1:RecordAudio("115301065", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_115301", "115301065", "story_v_out_115301.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_115301", "115301065", "story_v_out_115301.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_10 and arg_260_1.time_ < var_263_0 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play115301066 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 115301066
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play115301067(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1038"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.actorSpriteComps1038 == nil then
				arg_264_1.var_.actorSpriteComps1038 = var_267_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_2 = 0.2

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.actorSpriteComps1038 then
					for iter_267_0, iter_267_1 in pairs(arg_264_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_267_1 then
							if arg_264_1.isInRecall_ then
								local var_267_4 = Mathf.Lerp(iter_267_1.color.r, arg_264_1.hightColor2.r, var_267_3)
								local var_267_5 = Mathf.Lerp(iter_267_1.color.g, arg_264_1.hightColor2.g, var_267_3)
								local var_267_6 = Mathf.Lerp(iter_267_1.color.b, arg_264_1.hightColor2.b, var_267_3)

								iter_267_1.color = Color.New(var_267_4, var_267_5, var_267_6)
							else
								local var_267_7 = Mathf.Lerp(iter_267_1.color.r, 0.5, var_267_3)

								iter_267_1.color = Color.New(var_267_7, var_267_7, var_267_7)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.actorSpriteComps1038 then
				for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_267_3 then
						if arg_264_1.isInRecall_ then
							iter_267_3.color = arg_264_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_267_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_264_1.var_.actorSpriteComps1038 = nil
			end

			local var_267_8 = 0
			local var_267_9 = 1.125

			if var_267_8 < arg_264_1.time_ and arg_264_1.time_ <= var_267_8 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_10 = arg_264_1:GetWordFromCfg(115301066)
				local var_267_11 = arg_264_1:FormatText(var_267_10.content)

				arg_264_1.text_.text = var_267_11

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_12 = 45
				local var_267_13 = utf8.len(var_267_11)
				local var_267_14 = var_267_12 <= 0 and var_267_9 or var_267_9 * (var_267_13 / var_267_12)

				if var_267_14 > 0 and var_267_9 < var_267_14 then
					arg_264_1.talkMaxDuration = var_267_14

					if var_267_14 + var_267_8 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_14 + var_267_8
					end
				end

				arg_264_1.text_.text = var_267_11
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_15 = math.max(var_267_9, arg_264_1.talkMaxDuration)

			if var_267_8 <= arg_264_1.time_ and arg_264_1.time_ < var_267_8 + var_267_15 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_8) / var_267_15

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_8 + var_267_15 and arg_264_1.time_ < var_267_8 + var_267_15 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play115301067 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 115301067
		arg_268_1.duration_ = 3.77

		local var_268_0 = {
			ja = 1.033,
			ko = 2.133,
			zh = 3.766,
			en = 1.6
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
				arg_268_0:Play115301068(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["10030"].transform
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.var_.moveOldPos10030 = var_271_0.localPosition
				var_271_0.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10030", 4)

				local var_271_2 = var_271_0.childCount

				for iter_271_0 = 0, var_271_2 - 1 do
					local var_271_3 = var_271_0:GetChild(iter_271_0)

					if var_271_3.name == "split_3" or not string.find(var_271_3.name, "split") then
						var_271_3.gameObject:SetActive(true)
					else
						var_271_3.gameObject:SetActive(false)
					end
				end
			end

			local var_271_4 = 0.001

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_4 then
				local var_271_5 = (arg_268_1.time_ - var_271_1) / var_271_4
				local var_271_6 = Vector3.New(390, -390, 150)

				var_271_0.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10030, var_271_6, var_271_5)
			end

			if arg_268_1.time_ >= var_271_1 + var_271_4 and arg_268_1.time_ < var_271_1 + var_271_4 + arg_271_0 then
				var_271_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_271_7 = arg_268_1.actors_["10030"]
			local var_271_8 = 0

			if var_271_8 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 and not isNil(var_271_7) and arg_268_1.var_.actorSpriteComps10030 == nil then
				arg_268_1.var_.actorSpriteComps10030 = var_271_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_9 = 0.2

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_9 and not isNil(var_271_7) then
				local var_271_10 = (arg_268_1.time_ - var_271_8) / var_271_9

				if arg_268_1.var_.actorSpriteComps10030 then
					for iter_271_1, iter_271_2 in pairs(arg_268_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_271_2 then
							if arg_268_1.isInRecall_ then
								local var_271_11 = Mathf.Lerp(iter_271_2.color.r, arg_268_1.hightColor1.r, var_271_10)
								local var_271_12 = Mathf.Lerp(iter_271_2.color.g, arg_268_1.hightColor1.g, var_271_10)
								local var_271_13 = Mathf.Lerp(iter_271_2.color.b, arg_268_1.hightColor1.b, var_271_10)

								iter_271_2.color = Color.New(var_271_11, var_271_12, var_271_13)
							else
								local var_271_14 = Mathf.Lerp(iter_271_2.color.r, 1, var_271_10)

								iter_271_2.color = Color.New(var_271_14, var_271_14, var_271_14)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= var_271_8 + var_271_9 and arg_268_1.time_ < var_271_8 + var_271_9 + arg_271_0 and not isNil(var_271_7) and arg_268_1.var_.actorSpriteComps10030 then
				for iter_271_3, iter_271_4 in pairs(arg_268_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_271_4 then
						if arg_268_1.isInRecall_ then
							iter_271_4.color = arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_271_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_268_1.var_.actorSpriteComps10030 = nil
			end

			local var_271_15 = arg_268_1.actors_["10030"]
			local var_271_16 = 0

			if var_271_16 < arg_268_1.time_ and arg_268_1.time_ <= var_271_16 + arg_271_0 then
				local var_271_17 = var_271_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_271_17 then
					arg_268_1.var_.alphaOldValue10030 = var_271_17.alpha
					arg_268_1.var_.characterEffect10030 = var_271_17
				end

				arg_268_1.var_.alphaOldValue10030 = 0
			end

			local var_271_18 = 0.0166666666666667

			if var_271_16 <= arg_268_1.time_ and arg_268_1.time_ < var_271_16 + var_271_18 then
				local var_271_19 = (arg_268_1.time_ - var_271_16) / var_271_18
				local var_271_20 = Mathf.Lerp(arg_268_1.var_.alphaOldValue10030, 1, var_271_19)

				if arg_268_1.var_.characterEffect10030 then
					arg_268_1.var_.characterEffect10030.alpha = var_271_20
				end
			end

			if arg_268_1.time_ >= var_271_16 + var_271_18 and arg_268_1.time_ < var_271_16 + var_271_18 + arg_271_0 and arg_268_1.var_.characterEffect10030 then
				arg_268_1.var_.characterEffect10030.alpha = 1
			end

			local var_271_21 = 0
			local var_271_22 = 0.125

			if var_271_21 < arg_268_1.time_ and arg_268_1.time_ <= var_271_21 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_23 = arg_268_1:FormatText(StoryNameCfg[309].name)

				arg_268_1.leftNameTxt_.text = var_271_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_24 = arg_268_1:GetWordFromCfg(115301067)
				local var_271_25 = arg_268_1:FormatText(var_271_24.content)

				arg_268_1.text_.text = var_271_25

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_26 = 5
				local var_271_27 = utf8.len(var_271_25)
				local var_271_28 = var_271_26 <= 0 and var_271_22 or var_271_22 * (var_271_27 / var_271_26)

				if var_271_28 > 0 and var_271_22 < var_271_28 then
					arg_268_1.talkMaxDuration = var_271_28

					if var_271_28 + var_271_21 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_28 + var_271_21
					end
				end

				arg_268_1.text_.text = var_271_25
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301067", "story_v_out_115301.awb") ~= 0 then
					local var_271_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301067", "story_v_out_115301.awb") / 1000

					if var_271_29 + var_271_21 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_29 + var_271_21
					end

					if var_271_24.prefab_name ~= "" and arg_268_1.actors_[var_271_24.prefab_name] ~= nil then
						local var_271_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_24.prefab_name].transform, "story_v_out_115301", "115301067", "story_v_out_115301.awb")

						arg_268_1:RecordAudio("115301067", var_271_30)
						arg_268_1:RecordAudio("115301067", var_271_30)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_115301", "115301067", "story_v_out_115301.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_115301", "115301067", "story_v_out_115301.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_31 = math.max(var_271_22, arg_268_1.talkMaxDuration)

			if var_271_21 <= arg_268_1.time_ and arg_268_1.time_ < var_271_21 + var_271_31 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_21) / var_271_31

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_21 + var_271_31 and arg_268_1.time_ < var_271_21 + var_271_31 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play115301068 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 115301068
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play115301069(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["10030"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				local var_275_2 = var_275_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_275_2 then
					arg_272_1.var_.alphaOldValue10030 = var_275_2.alpha
					arg_272_1.var_.characterEffect10030 = var_275_2
				end

				arg_272_1.var_.alphaOldValue10030 = 1
			end

			local var_275_3 = 0.333333333333333

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_3 then
				local var_275_4 = (arg_272_1.time_ - var_275_1) / var_275_3
				local var_275_5 = Mathf.Lerp(arg_272_1.var_.alphaOldValue10030, 0, var_275_4)

				if arg_272_1.var_.characterEffect10030 then
					arg_272_1.var_.characterEffect10030.alpha = var_275_5
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_3 and arg_272_1.time_ < var_275_1 + var_275_3 + arg_275_0 and arg_272_1.var_.characterEffect10030 then
				arg_272_1.var_.characterEffect10030.alpha = 0
			end

			local var_275_6 = arg_272_1.actors_["1038"]
			local var_275_7 = 0

			if var_275_7 < arg_272_1.time_ and arg_272_1.time_ <= var_275_7 + arg_275_0 then
				local var_275_8 = var_275_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_275_8 then
					arg_272_1.var_.alphaOldValue1038 = var_275_8.alpha
					arg_272_1.var_.characterEffect1038 = var_275_8
				end

				arg_272_1.var_.alphaOldValue1038 = 1
			end

			local var_275_9 = 0.333333333333333

			if var_275_7 <= arg_272_1.time_ and arg_272_1.time_ < var_275_7 + var_275_9 then
				local var_275_10 = (arg_272_1.time_ - var_275_7) / var_275_9
				local var_275_11 = Mathf.Lerp(arg_272_1.var_.alphaOldValue1038, 0, var_275_10)

				if arg_272_1.var_.characterEffect1038 then
					arg_272_1.var_.characterEffect1038.alpha = var_275_11
				end
			end

			if arg_272_1.time_ >= var_275_7 + var_275_9 and arg_272_1.time_ < var_275_7 + var_275_9 + arg_275_0 and arg_272_1.var_.characterEffect1038 then
				arg_272_1.var_.characterEffect1038.alpha = 0
			end

			local var_275_12 = 0
			local var_275_13 = 0.85

			if var_275_12 < arg_272_1.time_ and arg_272_1.time_ <= var_275_12 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_14 = arg_272_1:GetWordFromCfg(115301068)
				local var_275_15 = arg_272_1:FormatText(var_275_14.content)

				arg_272_1.text_.text = var_275_15

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_16 = 34
				local var_275_17 = utf8.len(var_275_15)
				local var_275_18 = var_275_16 <= 0 and var_275_13 or var_275_13 * (var_275_17 / var_275_16)

				if var_275_18 > 0 and var_275_13 < var_275_18 then
					arg_272_1.talkMaxDuration = var_275_18

					if var_275_18 + var_275_12 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_18 + var_275_12
					end
				end

				arg_272_1.text_.text = var_275_15
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_19 = math.max(var_275_13, arg_272_1.talkMaxDuration)

			if var_275_12 <= arg_272_1.time_ and arg_272_1.time_ < var_275_12 + var_275_19 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_12) / var_275_19

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_12 + var_275_19 and arg_272_1.time_ < var_275_12 + var_275_19 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play115301069 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 115301069
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play115301070(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 0.95

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_2 = arg_276_1:GetWordFromCfg(115301069)
				local var_279_3 = arg_276_1:FormatText(var_279_2.content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_4 = 38
				local var_279_5 = utf8.len(var_279_3)
				local var_279_6 = var_279_4 <= 0 and var_279_1 or var_279_1 * (var_279_5 / var_279_4)

				if var_279_6 > 0 and var_279_1 < var_279_6 then
					arg_276_1.talkMaxDuration = var_279_6

					if var_279_6 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_6 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_7 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_7 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_7

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_7 and arg_276_1.time_ < var_279_0 + var_279_7 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play115301070 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 115301070
		arg_280_1.duration_ = 15.97

		local var_280_0 = {
			ja = 15.966,
			ko = 12.466,
			zh = 12.333,
			en = 12.833
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play115301071(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1038"].transform
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.var_.moveOldPos1038 = var_283_0.localPosition
				var_283_0.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("1038", 3)

				local var_283_2 = var_283_0.childCount

				for iter_283_0 = 0, var_283_2 - 1 do
					local var_283_3 = var_283_0:GetChild(iter_283_0)

					if var_283_3.name == "split_1" or not string.find(var_283_3.name, "split") then
						var_283_3.gameObject:SetActive(true)
					else
						var_283_3.gameObject:SetActive(false)
					end
				end
			end

			local var_283_4 = 0.001

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_4 then
				local var_283_5 = (arg_280_1.time_ - var_283_1) / var_283_4
				local var_283_6 = Vector3.New(0, -400, 0)

				var_283_0.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1038, var_283_6, var_283_5)
			end

			if arg_280_1.time_ >= var_283_1 + var_283_4 and arg_280_1.time_ < var_283_1 + var_283_4 + arg_283_0 then
				var_283_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_283_7 = arg_280_1.actors_["1038"]
			local var_283_8 = 0

			if var_283_8 < arg_280_1.time_ and arg_280_1.time_ <= var_283_8 + arg_283_0 and not isNil(var_283_7) and arg_280_1.var_.actorSpriteComps1038 == nil then
				arg_280_1.var_.actorSpriteComps1038 = var_283_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_9 = 0.2

			if var_283_8 <= arg_280_1.time_ and arg_280_1.time_ < var_283_8 + var_283_9 and not isNil(var_283_7) then
				local var_283_10 = (arg_280_1.time_ - var_283_8) / var_283_9

				if arg_280_1.var_.actorSpriteComps1038 then
					for iter_283_1, iter_283_2 in pairs(arg_280_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_283_2 then
							if arg_280_1.isInRecall_ then
								local var_283_11 = Mathf.Lerp(iter_283_2.color.r, arg_280_1.hightColor1.r, var_283_10)
								local var_283_12 = Mathf.Lerp(iter_283_2.color.g, arg_280_1.hightColor1.g, var_283_10)
								local var_283_13 = Mathf.Lerp(iter_283_2.color.b, arg_280_1.hightColor1.b, var_283_10)

								iter_283_2.color = Color.New(var_283_11, var_283_12, var_283_13)
							else
								local var_283_14 = Mathf.Lerp(iter_283_2.color.r, 1, var_283_10)

								iter_283_2.color = Color.New(var_283_14, var_283_14, var_283_14)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= var_283_8 + var_283_9 and arg_280_1.time_ < var_283_8 + var_283_9 + arg_283_0 and not isNil(var_283_7) and arg_280_1.var_.actorSpriteComps1038 then
				for iter_283_3, iter_283_4 in pairs(arg_280_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_283_4 then
						if arg_280_1.isInRecall_ then
							iter_283_4.color = arg_280_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_283_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_280_1.var_.actorSpriteComps1038 = nil
			end

			local var_283_15 = arg_280_1.actors_["1038"]
			local var_283_16 = 0

			if var_283_16 < arg_280_1.time_ and arg_280_1.time_ <= var_283_16 + arg_283_0 then
				local var_283_17 = var_283_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_283_17 then
					arg_280_1.var_.alphaOldValue1038 = var_283_17.alpha
					arg_280_1.var_.characterEffect1038 = var_283_17
				end

				arg_280_1.var_.alphaOldValue1038 = 0
			end

			local var_283_18 = 0.333333333333333

			if var_283_16 <= arg_280_1.time_ and arg_280_1.time_ < var_283_16 + var_283_18 then
				local var_283_19 = (arg_280_1.time_ - var_283_16) / var_283_18
				local var_283_20 = Mathf.Lerp(arg_280_1.var_.alphaOldValue1038, 1, var_283_19)

				if arg_280_1.var_.characterEffect1038 then
					arg_280_1.var_.characterEffect1038.alpha = var_283_20
				end
			end

			if arg_280_1.time_ >= var_283_16 + var_283_18 and arg_280_1.time_ < var_283_16 + var_283_18 + arg_283_0 and arg_280_1.var_.characterEffect1038 then
				arg_280_1.var_.characterEffect1038.alpha = 1
			end

			local var_283_21 = 0
			local var_283_22 = 1.15

			if var_283_21 < arg_280_1.time_ and arg_280_1.time_ <= var_283_21 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_23 = arg_280_1:FormatText(StoryNameCfg[94].name)

				arg_280_1.leftNameTxt_.text = var_283_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_24 = arg_280_1:GetWordFromCfg(115301070)
				local var_283_25 = arg_280_1:FormatText(var_283_24.content)

				arg_280_1.text_.text = var_283_25

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_26 = 46
				local var_283_27 = utf8.len(var_283_25)
				local var_283_28 = var_283_26 <= 0 and var_283_22 or var_283_22 * (var_283_27 / var_283_26)

				if var_283_28 > 0 and var_283_22 < var_283_28 then
					arg_280_1.talkMaxDuration = var_283_28

					if var_283_28 + var_283_21 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_28 + var_283_21
					end
				end

				arg_280_1.text_.text = var_283_25
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301070", "story_v_out_115301.awb") ~= 0 then
					local var_283_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301070", "story_v_out_115301.awb") / 1000

					if var_283_29 + var_283_21 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_29 + var_283_21
					end

					if var_283_24.prefab_name ~= "" and arg_280_1.actors_[var_283_24.prefab_name] ~= nil then
						local var_283_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_24.prefab_name].transform, "story_v_out_115301", "115301070", "story_v_out_115301.awb")

						arg_280_1:RecordAudio("115301070", var_283_30)
						arg_280_1:RecordAudio("115301070", var_283_30)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_115301", "115301070", "story_v_out_115301.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_115301", "115301070", "story_v_out_115301.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_31 = math.max(var_283_22, arg_280_1.talkMaxDuration)

			if var_283_21 <= arg_280_1.time_ and arg_280_1.time_ < var_283_21 + var_283_31 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_21) / var_283_31

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_21 + var_283_31 and arg_280_1.time_ < var_283_21 + var_283_31 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play115301071 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 115301071
		arg_284_1.duration_ = 11.6

		local var_284_0 = {
			ja = 11.6,
			ko = 8.766,
			zh = 10.266,
			en = 8.966
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play115301072(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.9

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_2 = arg_284_1:FormatText(StoryNameCfg[94].name)

				arg_284_1.leftNameTxt_.text = var_287_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_3 = arg_284_1:GetWordFromCfg(115301071)
				local var_287_4 = arg_284_1:FormatText(var_287_3.content)

				arg_284_1.text_.text = var_287_4

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 36
				local var_287_6 = utf8.len(var_287_4)
				local var_287_7 = var_287_5 <= 0 and var_287_1 or var_287_1 * (var_287_6 / var_287_5)

				if var_287_7 > 0 and var_287_1 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_4
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301071", "story_v_out_115301.awb") ~= 0 then
					local var_287_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301071", "story_v_out_115301.awb") / 1000

					if var_287_8 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_8 + var_287_0
					end

					if var_287_3.prefab_name ~= "" and arg_284_1.actors_[var_287_3.prefab_name] ~= nil then
						local var_287_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_3.prefab_name].transform, "story_v_out_115301", "115301071", "story_v_out_115301.awb")

						arg_284_1:RecordAudio("115301071", var_287_9)
						arg_284_1:RecordAudio("115301071", var_287_9)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_115301", "115301071", "story_v_out_115301.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_115301", "115301071", "story_v_out_115301.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_10 and arg_284_1.time_ < var_287_0 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play115301072 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 115301072
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play115301073(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1038"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				local var_291_2 = var_291_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_291_2 then
					arg_288_1.var_.alphaOldValue1038 = var_291_2.alpha
					arg_288_1.var_.characterEffect1038 = var_291_2
				end

				arg_288_1.var_.alphaOldValue1038 = 1
			end

			local var_291_3 = 0.333333333333333

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_3 then
				local var_291_4 = (arg_288_1.time_ - var_291_1) / var_291_3
				local var_291_5 = Mathf.Lerp(arg_288_1.var_.alphaOldValue1038, 0, var_291_4)

				if arg_288_1.var_.characterEffect1038 then
					arg_288_1.var_.characterEffect1038.alpha = var_291_5
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_3 and arg_288_1.time_ < var_291_1 + var_291_3 + arg_291_0 and arg_288_1.var_.characterEffect1038 then
				arg_288_1.var_.characterEffect1038.alpha = 0
			end

			local var_291_6 = 0
			local var_291_7 = 0.675

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_8 = arg_288_1:GetWordFromCfg(115301072)
				local var_291_9 = arg_288_1:FormatText(var_291_8.content)

				arg_288_1.text_.text = var_291_9

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_10 = 27
				local var_291_11 = utf8.len(var_291_9)
				local var_291_12 = var_291_10 <= 0 and var_291_7 or var_291_7 * (var_291_11 / var_291_10)

				if var_291_12 > 0 and var_291_7 < var_291_12 then
					arg_288_1.talkMaxDuration = var_291_12

					if var_291_12 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_12 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_9
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_13 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_13 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_13

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_13 and arg_288_1.time_ < var_291_6 + var_291_13 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play115301073 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 115301073
		arg_292_1.duration_ = 13.1

		local var_292_0 = {
			ja = 13.1,
			ko = 9.6,
			zh = 11,
			en = 10.166
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play115301074(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1038"].transform
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.var_.moveOldPos1038 = var_295_0.localPosition
				var_295_0.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("1038", 2)

				local var_295_2 = var_295_0.childCount

				for iter_295_0 = 0, var_295_2 - 1 do
					local var_295_3 = var_295_0:GetChild(iter_295_0)

					if var_295_3.name == "split_1" or not string.find(var_295_3.name, "split") then
						var_295_3.gameObject:SetActive(true)
					else
						var_295_3.gameObject:SetActive(false)
					end
				end
			end

			local var_295_4 = 0.001

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_4 then
				local var_295_5 = (arg_292_1.time_ - var_295_1) / var_295_4
				local var_295_6 = Vector3.New(-390, -400, 0)

				var_295_0.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1038, var_295_6, var_295_5)
			end

			if arg_292_1.time_ >= var_295_1 + var_295_4 and arg_292_1.time_ < var_295_1 + var_295_4 + arg_295_0 then
				var_295_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_295_7 = arg_292_1.actors_["1038"]
			local var_295_8 = 0

			if var_295_8 < arg_292_1.time_ and arg_292_1.time_ <= var_295_8 + arg_295_0 then
				local var_295_9 = var_295_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_295_9 then
					arg_292_1.var_.alphaOldValue1038 = var_295_9.alpha
					arg_292_1.var_.characterEffect1038 = var_295_9
				end

				arg_292_1.var_.alphaOldValue1038 = 0
			end

			local var_295_10 = 0.333333333333333

			if var_295_8 <= arg_292_1.time_ and arg_292_1.time_ < var_295_8 + var_295_10 then
				local var_295_11 = (arg_292_1.time_ - var_295_8) / var_295_10
				local var_295_12 = Mathf.Lerp(arg_292_1.var_.alphaOldValue1038, 1, var_295_11)

				if arg_292_1.var_.characterEffect1038 then
					arg_292_1.var_.characterEffect1038.alpha = var_295_12
				end
			end

			if arg_292_1.time_ >= var_295_8 + var_295_10 and arg_292_1.time_ < var_295_8 + var_295_10 + arg_295_0 and arg_292_1.var_.characterEffect1038 then
				arg_292_1.var_.characterEffect1038.alpha = 1
			end

			local var_295_13 = arg_292_1.actors_["1038"]
			local var_295_14 = 0

			if var_295_14 < arg_292_1.time_ and arg_292_1.time_ <= var_295_14 + arg_295_0 and not isNil(var_295_13) and arg_292_1.var_.actorSpriteComps1038 == nil then
				arg_292_1.var_.actorSpriteComps1038 = var_295_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_15 = 0.2

			if var_295_14 <= arg_292_1.time_ and arg_292_1.time_ < var_295_14 + var_295_15 and not isNil(var_295_13) then
				local var_295_16 = (arg_292_1.time_ - var_295_14) / var_295_15

				if arg_292_1.var_.actorSpriteComps1038 then
					for iter_295_1, iter_295_2 in pairs(arg_292_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_295_2 then
							if arg_292_1.isInRecall_ then
								local var_295_17 = Mathf.Lerp(iter_295_2.color.r, arg_292_1.hightColor1.r, var_295_16)
								local var_295_18 = Mathf.Lerp(iter_295_2.color.g, arg_292_1.hightColor1.g, var_295_16)
								local var_295_19 = Mathf.Lerp(iter_295_2.color.b, arg_292_1.hightColor1.b, var_295_16)

								iter_295_2.color = Color.New(var_295_17, var_295_18, var_295_19)
							else
								local var_295_20 = Mathf.Lerp(iter_295_2.color.r, 1, var_295_16)

								iter_295_2.color = Color.New(var_295_20, var_295_20, var_295_20)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= var_295_14 + var_295_15 and arg_292_1.time_ < var_295_14 + var_295_15 + arg_295_0 and not isNil(var_295_13) and arg_292_1.var_.actorSpriteComps1038 then
				for iter_295_3, iter_295_4 in pairs(arg_292_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_295_4 then
						if arg_292_1.isInRecall_ then
							iter_295_4.color = arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_295_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_292_1.var_.actorSpriteComps1038 = nil
			end

			local var_295_21 = 0
			local var_295_22 = 0.95

			if var_295_21 < arg_292_1.time_ and arg_292_1.time_ <= var_295_21 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_23 = arg_292_1:FormatText(StoryNameCfg[94].name)

				arg_292_1.leftNameTxt_.text = var_295_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_24 = arg_292_1:GetWordFromCfg(115301073)
				local var_295_25 = arg_292_1:FormatText(var_295_24.content)

				arg_292_1.text_.text = var_295_25

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_26 = 38
				local var_295_27 = utf8.len(var_295_25)
				local var_295_28 = var_295_26 <= 0 and var_295_22 or var_295_22 * (var_295_27 / var_295_26)

				if var_295_28 > 0 and var_295_22 < var_295_28 then
					arg_292_1.talkMaxDuration = var_295_28

					if var_295_28 + var_295_21 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_28 + var_295_21
					end
				end

				arg_292_1.text_.text = var_295_25
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301073", "story_v_out_115301.awb") ~= 0 then
					local var_295_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301073", "story_v_out_115301.awb") / 1000

					if var_295_29 + var_295_21 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_29 + var_295_21
					end

					if var_295_24.prefab_name ~= "" and arg_292_1.actors_[var_295_24.prefab_name] ~= nil then
						local var_295_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_24.prefab_name].transform, "story_v_out_115301", "115301073", "story_v_out_115301.awb")

						arg_292_1:RecordAudio("115301073", var_295_30)
						arg_292_1:RecordAudio("115301073", var_295_30)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_115301", "115301073", "story_v_out_115301.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_115301", "115301073", "story_v_out_115301.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_31 = math.max(var_295_22, arg_292_1.talkMaxDuration)

			if var_295_21 <= arg_292_1.time_ and arg_292_1.time_ < var_295_21 + var_295_31 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_21) / var_295_31

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_21 + var_295_31 and arg_292_1.time_ < var_295_21 + var_295_31 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play115301074 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 115301074
		arg_296_1.duration_ = 7.1

		local var_296_0 = {
			ja = 5.266,
			ko = 5,
			zh = 7.1,
			en = 6.333
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play115301075(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10030"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos10030 = var_299_0.localPosition
				var_299_0.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10030", 4)

				local var_299_2 = var_299_0.childCount

				for iter_299_0 = 0, var_299_2 - 1 do
					local var_299_3 = var_299_0:GetChild(iter_299_0)

					if var_299_3.name == "split_3" or not string.find(var_299_3.name, "split") then
						var_299_3.gameObject:SetActive(true)
					else
						var_299_3.gameObject:SetActive(false)
					end
				end
			end

			local var_299_4 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_4 then
				local var_299_5 = (arg_296_1.time_ - var_299_1) / var_299_4
				local var_299_6 = Vector3.New(390, -390, 150)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10030, var_299_6, var_299_5)
			end

			if arg_296_1.time_ >= var_299_1 + var_299_4 and arg_296_1.time_ < var_299_1 + var_299_4 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_299_7 = arg_296_1.actors_["1038"]
			local var_299_8 = 0

			if var_299_8 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 and not isNil(var_299_7) and arg_296_1.var_.actorSpriteComps1038 == nil then
				arg_296_1.var_.actorSpriteComps1038 = var_299_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_9 = 0.2

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_9 and not isNil(var_299_7) then
				local var_299_10 = (arg_296_1.time_ - var_299_8) / var_299_9

				if arg_296_1.var_.actorSpriteComps1038 then
					for iter_299_1, iter_299_2 in pairs(arg_296_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_299_2 then
							if arg_296_1.isInRecall_ then
								local var_299_11 = Mathf.Lerp(iter_299_2.color.r, arg_296_1.hightColor2.r, var_299_10)
								local var_299_12 = Mathf.Lerp(iter_299_2.color.g, arg_296_1.hightColor2.g, var_299_10)
								local var_299_13 = Mathf.Lerp(iter_299_2.color.b, arg_296_1.hightColor2.b, var_299_10)

								iter_299_2.color = Color.New(var_299_11, var_299_12, var_299_13)
							else
								local var_299_14 = Mathf.Lerp(iter_299_2.color.r, 0.5, var_299_10)

								iter_299_2.color = Color.New(var_299_14, var_299_14, var_299_14)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= var_299_8 + var_299_9 and arg_296_1.time_ < var_299_8 + var_299_9 + arg_299_0 and not isNil(var_299_7) and arg_296_1.var_.actorSpriteComps1038 then
				for iter_299_3, iter_299_4 in pairs(arg_296_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_299_4 then
						if arg_296_1.isInRecall_ then
							iter_299_4.color = arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_299_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps1038 = nil
			end

			local var_299_15 = arg_296_1.actors_["10030"]
			local var_299_16 = 0

			if var_299_16 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 then
				local var_299_17 = var_299_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_299_17 then
					arg_296_1.var_.alphaOldValue10030 = var_299_17.alpha
					arg_296_1.var_.characterEffect10030 = var_299_17
				end

				arg_296_1.var_.alphaOldValue10030 = 0
			end

			local var_299_18 = 0.333333333333333

			if var_299_16 <= arg_296_1.time_ and arg_296_1.time_ < var_299_16 + var_299_18 then
				local var_299_19 = (arg_296_1.time_ - var_299_16) / var_299_18
				local var_299_20 = Mathf.Lerp(arg_296_1.var_.alphaOldValue10030, 1, var_299_19)

				if arg_296_1.var_.characterEffect10030 then
					arg_296_1.var_.characterEffect10030.alpha = var_299_20
				end
			end

			if arg_296_1.time_ >= var_299_16 + var_299_18 and arg_296_1.time_ < var_299_16 + var_299_18 + arg_299_0 and arg_296_1.var_.characterEffect10030 then
				arg_296_1.var_.characterEffect10030.alpha = 1
			end

			local var_299_21 = 0
			local var_299_22 = 0.35

			if var_299_21 < arg_296_1.time_ and arg_296_1.time_ <= var_299_21 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_23 = arg_296_1:FormatText(StoryNameCfg[309].name)

				arg_296_1.leftNameTxt_.text = var_299_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_24 = arg_296_1:GetWordFromCfg(115301074)
				local var_299_25 = arg_296_1:FormatText(var_299_24.content)

				arg_296_1.text_.text = var_299_25

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_26 = 14
				local var_299_27 = utf8.len(var_299_25)
				local var_299_28 = var_299_26 <= 0 and var_299_22 or var_299_22 * (var_299_27 / var_299_26)

				if var_299_28 > 0 and var_299_22 < var_299_28 then
					arg_296_1.talkMaxDuration = var_299_28

					if var_299_28 + var_299_21 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_28 + var_299_21
					end
				end

				arg_296_1.text_.text = var_299_25
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301074", "story_v_out_115301.awb") ~= 0 then
					local var_299_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301074", "story_v_out_115301.awb") / 1000

					if var_299_29 + var_299_21 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_29 + var_299_21
					end

					if var_299_24.prefab_name ~= "" and arg_296_1.actors_[var_299_24.prefab_name] ~= nil then
						local var_299_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_24.prefab_name].transform, "story_v_out_115301", "115301074", "story_v_out_115301.awb")

						arg_296_1:RecordAudio("115301074", var_299_30)
						arg_296_1:RecordAudio("115301074", var_299_30)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_115301", "115301074", "story_v_out_115301.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_115301", "115301074", "story_v_out_115301.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_31 = math.max(var_299_22, arg_296_1.talkMaxDuration)

			if var_299_21 <= arg_296_1.time_ and arg_296_1.time_ < var_299_21 + var_299_31 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_21) / var_299_31

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_21 + var_299_31 and arg_296_1.time_ < var_299_21 + var_299_31 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play115301075 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 115301075
		arg_300_1.duration_ = 6.9

		local var_300_0 = {
			ja = 4.3,
			ko = 4.8,
			zh = 6.9,
			en = 5.733
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play115301076(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10030"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps10030 == nil then
				arg_300_1.var_.actorSpriteComps10030 = var_303_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_2 = 0.2

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.actorSpriteComps10030 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								local var_303_4 = Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor2.r, var_303_3)
								local var_303_5 = Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor2.g, var_303_3)
								local var_303_6 = Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor2.b, var_303_3)

								iter_303_1.color = Color.New(var_303_4, var_303_5, var_303_6)
							else
								local var_303_7 = Mathf.Lerp(iter_303_1.color.r, 0.5, var_303_3)

								iter_303_1.color = Color.New(var_303_7, var_303_7, var_303_7)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps10030 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_303_3 then
						if arg_300_1.isInRecall_ then
							iter_303_3.color = arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_303_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_300_1.var_.actorSpriteComps10030 = nil
			end

			local var_303_8 = arg_300_1.actors_["1038"]
			local var_303_9 = 0

			if var_303_9 < arg_300_1.time_ and arg_300_1.time_ <= var_303_9 + arg_303_0 and not isNil(var_303_8) and arg_300_1.var_.actorSpriteComps1038 == nil then
				arg_300_1.var_.actorSpriteComps1038 = var_303_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_10 = 0.2

			if var_303_9 <= arg_300_1.time_ and arg_300_1.time_ < var_303_9 + var_303_10 and not isNil(var_303_8) then
				local var_303_11 = (arg_300_1.time_ - var_303_9) / var_303_10

				if arg_300_1.var_.actorSpriteComps1038 then
					for iter_303_4, iter_303_5 in pairs(arg_300_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_303_5 then
							if arg_300_1.isInRecall_ then
								local var_303_12 = Mathf.Lerp(iter_303_5.color.r, arg_300_1.hightColor1.r, var_303_11)
								local var_303_13 = Mathf.Lerp(iter_303_5.color.g, arg_300_1.hightColor1.g, var_303_11)
								local var_303_14 = Mathf.Lerp(iter_303_5.color.b, arg_300_1.hightColor1.b, var_303_11)

								iter_303_5.color = Color.New(var_303_12, var_303_13, var_303_14)
							else
								local var_303_15 = Mathf.Lerp(iter_303_5.color.r, 1, var_303_11)

								iter_303_5.color = Color.New(var_303_15, var_303_15, var_303_15)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= var_303_9 + var_303_10 and arg_300_1.time_ < var_303_9 + var_303_10 + arg_303_0 and not isNil(var_303_8) and arg_300_1.var_.actorSpriteComps1038 then
				for iter_303_6, iter_303_7 in pairs(arg_300_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_303_7 then
						if arg_300_1.isInRecall_ then
							iter_303_7.color = arg_300_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_303_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_300_1.var_.actorSpriteComps1038 = nil
			end

			local var_303_16 = 0
			local var_303_17 = 0.475

			if var_303_16 < arg_300_1.time_ and arg_300_1.time_ <= var_303_16 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_18 = arg_300_1:FormatText(StoryNameCfg[94].name)

				arg_300_1.leftNameTxt_.text = var_303_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_19 = arg_300_1:GetWordFromCfg(115301075)
				local var_303_20 = arg_300_1:FormatText(var_303_19.content)

				arg_300_1.text_.text = var_303_20

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_21 = 19
				local var_303_22 = utf8.len(var_303_20)
				local var_303_23 = var_303_21 <= 0 and var_303_17 or var_303_17 * (var_303_22 / var_303_21)

				if var_303_23 > 0 and var_303_17 < var_303_23 then
					arg_300_1.talkMaxDuration = var_303_23

					if var_303_23 + var_303_16 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_23 + var_303_16
					end
				end

				arg_300_1.text_.text = var_303_20
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301075", "story_v_out_115301.awb") ~= 0 then
					local var_303_24 = manager.audio:GetVoiceLength("story_v_out_115301", "115301075", "story_v_out_115301.awb") / 1000

					if var_303_24 + var_303_16 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_24 + var_303_16
					end

					if var_303_19.prefab_name ~= "" and arg_300_1.actors_[var_303_19.prefab_name] ~= nil then
						local var_303_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_19.prefab_name].transform, "story_v_out_115301", "115301075", "story_v_out_115301.awb")

						arg_300_1:RecordAudio("115301075", var_303_25)
						arg_300_1:RecordAudio("115301075", var_303_25)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_115301", "115301075", "story_v_out_115301.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_115301", "115301075", "story_v_out_115301.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_26 = math.max(var_303_17, arg_300_1.talkMaxDuration)

			if var_303_16 <= arg_300_1.time_ and arg_300_1.time_ < var_303_16 + var_303_26 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_16) / var_303_26

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_16 + var_303_26 and arg_300_1.time_ < var_303_16 + var_303_26 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play115301076 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 115301076
		arg_304_1.duration_ = 11.23

		local var_304_0 = {
			ja = 11.233,
			ko = 7.566,
			zh = 10.6,
			en = 9.733
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play115301077(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1038"].transform
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.var_.moveOldPos1038 = var_307_0.localPosition
				var_307_0.localScale = Vector3.New(1, 1, 1)

				arg_304_1:CheckSpriteTmpPos("1038", 2)

				local var_307_2 = var_307_0.childCount

				for iter_307_0 = 0, var_307_2 - 1 do
					local var_307_3 = var_307_0:GetChild(iter_307_0)

					if var_307_3.name == "split_1" or not string.find(var_307_3.name, "split") then
						var_307_3.gameObject:SetActive(true)
					else
						var_307_3.gameObject:SetActive(false)
					end
				end
			end

			local var_307_4 = 0.001

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_4 then
				local var_307_5 = (arg_304_1.time_ - var_307_1) / var_307_4
				local var_307_6 = Vector3.New(-390, -400, 0)

				var_307_0.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1038, var_307_6, var_307_5)
			end

			if arg_304_1.time_ >= var_307_1 + var_307_4 and arg_304_1.time_ < var_307_1 + var_307_4 + arg_307_0 then
				var_307_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_307_7 = arg_304_1.actors_["1038"].transform
			local var_307_8 = 0

			if var_307_8 < arg_304_1.time_ and arg_304_1.time_ <= var_307_8 + arg_307_0 then
				arg_304_1.var_.moveOldPos1038 = var_307_7.localPosition
				var_307_7.localScale = Vector3.New(1, 1, 1)

				arg_304_1:CheckSpriteTmpPos("1038", 2)

				local var_307_9 = var_307_7.childCount

				for iter_307_1 = 0, var_307_9 - 1 do
					local var_307_10 = var_307_7:GetChild(iter_307_1)

					if var_307_10.name == "split_7" or not string.find(var_307_10.name, "split") then
						var_307_10.gameObject:SetActive(true)
					else
						var_307_10.gameObject:SetActive(false)
					end
				end
			end

			local var_307_11 = 0.001

			if var_307_8 <= arg_304_1.time_ and arg_304_1.time_ < var_307_8 + var_307_11 then
				local var_307_12 = (arg_304_1.time_ - var_307_8) / var_307_11
				local var_307_13 = Vector3.New(-390, -400, 0)

				var_307_7.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1038, var_307_13, var_307_12)
			end

			if arg_304_1.time_ >= var_307_8 + var_307_11 and arg_304_1.time_ < var_307_8 + var_307_11 + arg_307_0 then
				var_307_7.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_307_14 = arg_304_1.actors_["1038"]
			local var_307_15 = 0

			if var_307_15 < arg_304_1.time_ and arg_304_1.time_ <= var_307_15 + arg_307_0 then
				local var_307_16 = var_307_14:GetComponentInChildren(typeof(CanvasGroup))

				if var_307_16 then
					arg_304_1.var_.alphaOldValue1038 = var_307_16.alpha
					arg_304_1.var_.characterEffect1038 = var_307_16
				end

				arg_304_1.var_.alphaOldValue1038 = 0
			end

			local var_307_17 = 0.0166666666666667

			if var_307_15 <= arg_304_1.time_ and arg_304_1.time_ < var_307_15 + var_307_17 then
				local var_307_18 = (arg_304_1.time_ - var_307_15) / var_307_17
				local var_307_19 = Mathf.Lerp(arg_304_1.var_.alphaOldValue1038, 1, var_307_18)

				if arg_304_1.var_.characterEffect1038 then
					arg_304_1.var_.characterEffect1038.alpha = var_307_19
				end
			end

			if arg_304_1.time_ >= var_307_15 + var_307_17 and arg_304_1.time_ < var_307_15 + var_307_17 + arg_307_0 and arg_304_1.var_.characterEffect1038 then
				arg_304_1.var_.characterEffect1038.alpha = 1
			end

			local var_307_20 = arg_304_1.actors_["1038"]
			local var_307_21 = 0

			if var_307_21 < arg_304_1.time_ and arg_304_1.time_ <= var_307_21 + arg_307_0 and not isNil(var_307_20) and arg_304_1.var_.actorSpriteComps1038 == nil then
				arg_304_1.var_.actorSpriteComps1038 = var_307_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_22 = 0.0166666666666667

			if var_307_21 <= arg_304_1.time_ and arg_304_1.time_ < var_307_21 + var_307_22 and not isNil(var_307_20) then
				local var_307_23 = (arg_304_1.time_ - var_307_21) / var_307_22

				if arg_304_1.var_.actorSpriteComps1038 then
					for iter_307_2, iter_307_3 in pairs(arg_304_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_307_3 then
							if arg_304_1.isInRecall_ then
								local var_307_24 = Mathf.Lerp(iter_307_3.color.r, arg_304_1.hightColor1.r, var_307_23)
								local var_307_25 = Mathf.Lerp(iter_307_3.color.g, arg_304_1.hightColor1.g, var_307_23)
								local var_307_26 = Mathf.Lerp(iter_307_3.color.b, arg_304_1.hightColor1.b, var_307_23)

								iter_307_3.color = Color.New(var_307_24, var_307_25, var_307_26)
							else
								local var_307_27 = Mathf.Lerp(iter_307_3.color.r, 1, var_307_23)

								iter_307_3.color = Color.New(var_307_27, var_307_27, var_307_27)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= var_307_21 + var_307_22 and arg_304_1.time_ < var_307_21 + var_307_22 + arg_307_0 and not isNil(var_307_20) and arg_304_1.var_.actorSpriteComps1038 then
				for iter_307_4, iter_307_5 in pairs(arg_304_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_307_5 then
						if arg_304_1.isInRecall_ then
							iter_307_5.color = arg_304_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_307_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_304_1.var_.actorSpriteComps1038 = nil
			end

			local var_307_28 = 0
			local var_307_29 = 1

			if var_307_28 < arg_304_1.time_ and arg_304_1.time_ <= var_307_28 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_30 = arg_304_1:FormatText(StoryNameCfg[94].name)

				arg_304_1.leftNameTxt_.text = var_307_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_31 = arg_304_1:GetWordFromCfg(115301076)
				local var_307_32 = arg_304_1:FormatText(var_307_31.content)

				arg_304_1.text_.text = var_307_32

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_33 = 40
				local var_307_34 = utf8.len(var_307_32)
				local var_307_35 = var_307_33 <= 0 and var_307_29 or var_307_29 * (var_307_34 / var_307_33)

				if var_307_35 > 0 and var_307_29 < var_307_35 then
					arg_304_1.talkMaxDuration = var_307_35

					if var_307_35 + var_307_28 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_35 + var_307_28
					end
				end

				arg_304_1.text_.text = var_307_32
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301076", "story_v_out_115301.awb") ~= 0 then
					local var_307_36 = manager.audio:GetVoiceLength("story_v_out_115301", "115301076", "story_v_out_115301.awb") / 1000

					if var_307_36 + var_307_28 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_36 + var_307_28
					end

					if var_307_31.prefab_name ~= "" and arg_304_1.actors_[var_307_31.prefab_name] ~= nil then
						local var_307_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_31.prefab_name].transform, "story_v_out_115301", "115301076", "story_v_out_115301.awb")

						arg_304_1:RecordAudio("115301076", var_307_37)
						arg_304_1:RecordAudio("115301076", var_307_37)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_115301", "115301076", "story_v_out_115301.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_115301", "115301076", "story_v_out_115301.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_38 = math.max(var_307_29, arg_304_1.talkMaxDuration)

			if var_307_28 <= arg_304_1.time_ and arg_304_1.time_ < var_307_28 + var_307_38 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_28) / var_307_38

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_28 + var_307_38 and arg_304_1.time_ < var_307_28 + var_307_38 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play115301077 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 115301077
		arg_308_1.duration_ = 5.73

		local var_308_0 = {
			ja = 5.6,
			ko = 4.9,
			zh = 5.733,
			en = 5.266
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play115301078(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 0.55

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_2 = arg_308_1:FormatText(StoryNameCfg[94].name)

				arg_308_1.leftNameTxt_.text = var_311_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_3 = arg_308_1:GetWordFromCfg(115301077)
				local var_311_4 = arg_308_1:FormatText(var_311_3.content)

				arg_308_1.text_.text = var_311_4

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 22
				local var_311_6 = utf8.len(var_311_4)
				local var_311_7 = var_311_5 <= 0 and var_311_1 or var_311_1 * (var_311_6 / var_311_5)

				if var_311_7 > 0 and var_311_1 < var_311_7 then
					arg_308_1.talkMaxDuration = var_311_7

					if var_311_7 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_4
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301077", "story_v_out_115301.awb") ~= 0 then
					local var_311_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301077", "story_v_out_115301.awb") / 1000

					if var_311_8 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_8 + var_311_0
					end

					if var_311_3.prefab_name ~= "" and arg_308_1.actors_[var_311_3.prefab_name] ~= nil then
						local var_311_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_3.prefab_name].transform, "story_v_out_115301", "115301077", "story_v_out_115301.awb")

						arg_308_1:RecordAudio("115301077", var_311_9)
						arg_308_1:RecordAudio("115301077", var_311_9)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_115301", "115301077", "story_v_out_115301.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_115301", "115301077", "story_v_out_115301.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_10 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_10 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_10

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_10 and arg_308_1.time_ < var_311_0 + var_311_10 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play115301078 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 115301078
		arg_312_1.duration_ = 8

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play115301079(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = "STblack"

			if arg_312_1.bgs_[var_315_0] == nil then
				local var_315_1 = Object.Instantiate(arg_312_1.paintGo_)

				var_315_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_315_0)
				var_315_1.name = var_315_0
				var_315_1.transform.parent = arg_312_1.stage_.transform
				var_315_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_312_1.bgs_[var_315_0] = var_315_1
			end

			local var_315_2 = 1

			if var_315_2 < arg_312_1.time_ and arg_312_1.time_ <= var_315_2 + arg_315_0 then
				local var_315_3 = manager.ui.mainCamera.transform.localPosition
				local var_315_4 = Vector3.New(0, 0, 10) + Vector3.New(var_315_3.x, var_315_3.y, 0)
				local var_315_5 = arg_312_1.bgs_.STblack

				var_315_5.transform.localPosition = var_315_4
				var_315_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_315_6 = var_315_5:GetComponent("SpriteRenderer")

				if var_315_6 and var_315_6.sprite then
					local var_315_7 = (var_315_5.transform.localPosition - var_315_3).z
					local var_315_8 = manager.ui.mainCameraCom_
					local var_315_9 = 2 * var_315_7 * Mathf.Tan(var_315_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_315_10 = var_315_9 * var_315_8.aspect
					local var_315_11 = var_315_6.sprite.bounds.size.x
					local var_315_12 = var_315_6.sprite.bounds.size.y
					local var_315_13 = var_315_10 / var_315_11
					local var_315_14 = var_315_9 / var_315_12
					local var_315_15 = var_315_14 < var_315_13 and var_315_13 or var_315_14

					var_315_5.transform.localScale = Vector3.New(var_315_15, var_315_15, 0)
				end

				for iter_315_0, iter_315_1 in pairs(arg_312_1.bgs_) do
					if iter_315_0 ~= "STblack" then
						iter_315_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_315_16 = 0

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = false

				arg_312_1:SetGaussion(false)
			end

			local var_315_17 = 1

			if var_315_16 <= arg_312_1.time_ and arg_312_1.time_ < var_315_16 + var_315_17 then
				local var_315_18 = (arg_312_1.time_ - var_315_16) / var_315_17
				local var_315_19 = Color.New(0, 0, 0)

				var_315_19.a = Mathf.Lerp(0, 1, var_315_18)
				arg_312_1.mask_.color = var_315_19
			end

			if arg_312_1.time_ >= var_315_16 + var_315_17 and arg_312_1.time_ < var_315_16 + var_315_17 + arg_315_0 then
				local var_315_20 = Color.New(0, 0, 0)

				var_315_20.a = 1
				arg_312_1.mask_.color = var_315_20
			end

			local var_315_21 = 1

			if var_315_21 < arg_312_1.time_ and arg_312_1.time_ <= var_315_21 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = false

				arg_312_1:SetGaussion(false)
			end

			local var_315_22 = 2

			if var_315_21 <= arg_312_1.time_ and arg_312_1.time_ < var_315_21 + var_315_22 then
				local var_315_23 = (arg_312_1.time_ - var_315_21) / var_315_22
				local var_315_24 = Color.New(0, 0, 0)

				var_315_24.a = Mathf.Lerp(1, 0, var_315_23)
				arg_312_1.mask_.color = var_315_24
			end

			if arg_312_1.time_ >= var_315_21 + var_315_22 and arg_312_1.time_ < var_315_21 + var_315_22 + arg_315_0 then
				local var_315_25 = Color.New(0, 0, 0)
				local var_315_26 = 0

				arg_312_1.mask_.enabled = false
				var_315_25.a = var_315_26
				arg_312_1.mask_.color = var_315_25
			end

			local var_315_27 = arg_312_1.actors_["1038"].transform
			local var_315_28 = 1

			if var_315_28 < arg_312_1.time_ and arg_312_1.time_ <= var_315_28 + arg_315_0 then
				arg_312_1.var_.moveOldPos1038 = var_315_27.localPosition
				var_315_27.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1038", 0)

				local var_315_29 = var_315_27.childCount

				for iter_315_2 = 0, var_315_29 - 1 do
					local var_315_30 = var_315_27:GetChild(iter_315_2)

					if var_315_30.name == "split_7" or not string.find(var_315_30.name, "split") then
						var_315_30.gameObject:SetActive(true)
					else
						var_315_30.gameObject:SetActive(false)
					end
				end
			end

			local var_315_31 = 0.001

			if var_315_28 <= arg_312_1.time_ and arg_312_1.time_ < var_315_28 + var_315_31 then
				local var_315_32 = (arg_312_1.time_ - var_315_28) / var_315_31
				local var_315_33 = Vector3.New(-2000, -400, 0)

				var_315_27.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1038, var_315_33, var_315_32)
			end

			if arg_312_1.time_ >= var_315_28 + var_315_31 and arg_312_1.time_ < var_315_28 + var_315_31 + arg_315_0 then
				var_315_27.localPosition = Vector3.New(-2000, -400, 0)
			end

			local var_315_34 = arg_312_1.actors_["10030"].transform
			local var_315_35 = 1

			if var_315_35 < arg_312_1.time_ and arg_312_1.time_ <= var_315_35 + arg_315_0 then
				arg_312_1.var_.moveOldPos10030 = var_315_34.localPosition
				var_315_34.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("10030", 0)

				local var_315_36 = var_315_34.childCount

				for iter_315_3 = 0, var_315_36 - 1 do
					local var_315_37 = var_315_34:GetChild(iter_315_3)

					if var_315_37.name == "split_3" or not string.find(var_315_37.name, "split") then
						var_315_37.gameObject:SetActive(true)
					else
						var_315_37.gameObject:SetActive(false)
					end
				end
			end

			local var_315_38 = 0.001

			if var_315_35 <= arg_312_1.time_ and arg_312_1.time_ < var_315_35 + var_315_38 then
				local var_315_39 = (arg_312_1.time_ - var_315_35) / var_315_38
				local var_315_40 = Vector3.New(-2000, -390, 150)

				var_315_34.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10030, var_315_40, var_315_39)
			end

			if arg_312_1.time_ >= var_315_35 + var_315_38 and arg_312_1.time_ < var_315_35 + var_315_38 + arg_315_0 then
				var_315_34.localPosition = Vector3.New(-2000, -390, 150)
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_41 = 3
			local var_315_42 = 0.4

			if var_315_41 < arg_312_1.time_ and arg_312_1.time_ <= var_315_41 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_43 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_43:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_312_1.dialogCg_.alpha = arg_316_0
				end))
				var_315_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_44 = arg_312_1:GetWordFromCfg(115301078)
				local var_315_45 = arg_312_1:FormatText(var_315_44.content)

				arg_312_1.text_.text = var_315_45

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_46 = 16
				local var_315_47 = utf8.len(var_315_45)
				local var_315_48 = var_315_46 <= 0 and var_315_42 or var_315_42 * (var_315_47 / var_315_46)

				if var_315_48 > 0 and var_315_42 < var_315_48 then
					arg_312_1.talkMaxDuration = var_315_48
					var_315_41 = var_315_41 + 0.3

					if var_315_48 + var_315_41 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_48 + var_315_41
					end
				end

				arg_312_1.text_.text = var_315_45
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_49 = var_315_41 + 0.3
			local var_315_50 = math.max(var_315_42, arg_312_1.talkMaxDuration)

			if var_315_49 <= arg_312_1.time_ and arg_312_1.time_ < var_315_49 + var_315_50 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_49) / var_315_50

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_49 + var_315_50 and arg_312_1.time_ < var_315_49 + var_315_50 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play115301079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 115301079
		arg_318_1.duration_ = 6.33

		local var_318_0 = {
			ja = 6.333,
			ko = 1.333,
			zh = 2.3,
			en = 1.233
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
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play115301080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 0.075

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[309].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_3")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:GetWordFromCfg(115301079)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301079", "story_v_out_115301.awb") ~= 0 then
					local var_321_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301079", "story_v_out_115301.awb") / 1000

					if var_321_8 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_8 + var_321_0
					end

					if var_321_3.prefab_name ~= "" and arg_318_1.actors_[var_321_3.prefab_name] ~= nil then
						local var_321_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_3.prefab_name].transform, "story_v_out_115301", "115301079", "story_v_out_115301.awb")

						arg_318_1:RecordAudio("115301079", var_321_9)
						arg_318_1:RecordAudio("115301079", var_321_9)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_115301", "115301079", "story_v_out_115301.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_115301", "115301079", "story_v_out_115301.awb")
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
	Play115301080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 115301080
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play115301081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.525

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_2 = arg_322_1:GetWordFromCfg(115301080)
				local var_325_3 = arg_322_1:FormatText(var_325_2.content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 21
				local var_325_5 = utf8.len(var_325_3)
				local var_325_6 = var_325_4 <= 0 and var_325_1 or var_325_1 * (var_325_5 / var_325_4)

				if var_325_6 > 0 and var_325_1 < var_325_6 then
					arg_322_1.talkMaxDuration = var_325_6

					if var_325_6 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_6 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_7 and arg_322_1.time_ < var_325_0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play115301081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 115301081
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play115301082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 1.05

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_2 = arg_326_1:GetWordFromCfg(115301081)
				local var_329_3 = arg_326_1:FormatText(var_329_2.content)

				arg_326_1.text_.text = var_329_3

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 42
				local var_329_5 = utf8.len(var_329_3)
				local var_329_6 = var_329_4 <= 0 and var_329_1 or var_329_1 * (var_329_5 / var_329_4)

				if var_329_6 > 0 and var_329_1 < var_329_6 then
					arg_326_1.talkMaxDuration = var_329_6

					if var_329_6 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_6 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_3
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_7 and arg_326_1.time_ < var_329_0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play115301082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 115301082
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play115301083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.625

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_2 = arg_330_1:GetWordFromCfg(115301082)
				local var_333_3 = arg_330_1:FormatText(var_333_2.content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 25
				local var_333_5 = utf8.len(var_333_3)
				local var_333_6 = var_333_4 <= 0 and var_333_1 or var_333_1 * (var_333_5 / var_333_4)

				if var_333_6 > 0 and var_333_1 < var_333_6 then
					arg_330_1.talkMaxDuration = var_333_6

					if var_333_6 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_6 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_7 and arg_330_1.time_ < var_333_0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play115301083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 115301083
		arg_334_1.duration_ = 5.9

		local var_334_0 = {
			ja = 5.8,
			ko = 5.9,
			zh = 5.833,
			en = 5.5
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play115301084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = "RO0503"

			if arg_334_1.bgs_[var_337_0] == nil then
				local var_337_1 = Object.Instantiate(arg_334_1.paintGo_)

				var_337_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_337_0)
				var_337_1.name = var_337_0
				var_337_1.transform.parent = arg_334_1.stage_.transform
				var_337_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.bgs_[var_337_0] = var_337_1
			end

			local var_337_2 = 2

			if var_337_2 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				local var_337_3 = manager.ui.mainCamera.transform.localPosition
				local var_337_4 = Vector3.New(0, 0, 10) + Vector3.New(var_337_3.x, var_337_3.y, 0)
				local var_337_5 = arg_334_1.bgs_.RO0503

				var_337_5.transform.localPosition = var_337_4
				var_337_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_337_6 = var_337_5:GetComponent("SpriteRenderer")

				if var_337_6 and var_337_6.sprite then
					local var_337_7 = (var_337_5.transform.localPosition - var_337_3).z
					local var_337_8 = manager.ui.mainCameraCom_
					local var_337_9 = 2 * var_337_7 * Mathf.Tan(var_337_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_337_10 = var_337_9 * var_337_8.aspect
					local var_337_11 = var_337_6.sprite.bounds.size.x
					local var_337_12 = var_337_6.sprite.bounds.size.y
					local var_337_13 = var_337_10 / var_337_11
					local var_337_14 = var_337_9 / var_337_12
					local var_337_15 = var_337_14 < var_337_13 and var_337_13 or var_337_14

					var_337_5.transform.localScale = Vector3.New(var_337_15, var_337_15, 0)
				end

				for iter_337_0, iter_337_1 in pairs(arg_334_1.bgs_) do
					if iter_337_0 ~= "RO0503" then
						iter_337_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_337_16 = 0

			if var_337_16 < arg_334_1.time_ and arg_334_1.time_ <= var_337_16 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = false

				arg_334_1:SetGaussion(false)
			end

			local var_337_17 = 2

			if var_337_16 <= arg_334_1.time_ and arg_334_1.time_ < var_337_16 + var_337_17 then
				local var_337_18 = (arg_334_1.time_ - var_337_16) / var_337_17
				local var_337_19 = Color.New(0, 0, 0)

				var_337_19.a = Mathf.Lerp(0, 1, var_337_18)
				arg_334_1.mask_.color = var_337_19
			end

			if arg_334_1.time_ >= var_337_16 + var_337_17 and arg_334_1.time_ < var_337_16 + var_337_17 + arg_337_0 then
				local var_337_20 = Color.New(0, 0, 0)

				var_337_20.a = 1
				arg_334_1.mask_.color = var_337_20
			end

			local var_337_21 = 2

			if var_337_21 < arg_334_1.time_ and arg_334_1.time_ <= var_337_21 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = false

				arg_334_1:SetGaussion(false)
			end

			local var_337_22 = 2

			if var_337_21 <= arg_334_1.time_ and arg_334_1.time_ < var_337_21 + var_337_22 then
				local var_337_23 = (arg_334_1.time_ - var_337_21) / var_337_22
				local var_337_24 = Color.New(0, 0, 0)

				var_337_24.a = Mathf.Lerp(1, 0, var_337_23)
				arg_334_1.mask_.color = var_337_24
			end

			if arg_334_1.time_ >= var_337_21 + var_337_22 and arg_334_1.time_ < var_337_21 + var_337_22 + arg_337_0 then
				local var_337_25 = Color.New(0, 0, 0)
				local var_337_26 = 0

				arg_334_1.mask_.enabled = false
				var_337_25.a = var_337_26
				arg_334_1.mask_.color = var_337_25
			end

			if arg_334_1.frameCnt_ <= 1 then
				arg_334_1.dialog_:SetActive(false)
			end

			local var_337_27 = 4
			local var_337_28 = 0.075

			if var_337_27 < arg_334_1.time_ and arg_334_1.time_ <= var_337_27 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0

				arg_334_1.dialog_:SetActive(true)

				arg_334_1.dialogCg_.alpha = 0

				local var_337_29 = LeanTween.value(arg_334_1.dialog_, 0, 1, 0.3)

				var_337_29:setOnUpdate(LuaHelper.FloatAction(function(arg_338_0)
					arg_334_1.dialogCg_.alpha = arg_338_0
				end))
				var_337_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_334_1.dialog_)
					var_337_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_334_1.duration_ = arg_334_1.duration_ + 0.3

				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_30 = arg_334_1:FormatText(StoryNameCfg[309].name)

				arg_334_1.leftNameTxt_.text = var_337_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_31 = arg_334_1:GetWordFromCfg(115301083)
				local var_337_32 = arg_334_1:FormatText(var_337_31.content)

				arg_334_1.text_.text = var_337_32

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_33 = 3
				local var_337_34 = utf8.len(var_337_32)
				local var_337_35 = var_337_33 <= 0 and var_337_28 or var_337_28 * (var_337_34 / var_337_33)

				if var_337_35 > 0 and var_337_28 < var_337_35 then
					arg_334_1.talkMaxDuration = var_337_35
					var_337_27 = var_337_27 + 0.3

					if var_337_35 + var_337_27 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_35 + var_337_27
					end
				end

				arg_334_1.text_.text = var_337_32
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301083", "story_v_out_115301.awb") ~= 0 then
					local var_337_36 = manager.audio:GetVoiceLength("story_v_out_115301", "115301083", "story_v_out_115301.awb") / 1000

					if var_337_36 + var_337_27 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_36 + var_337_27
					end

					if var_337_31.prefab_name ~= "" and arg_334_1.actors_[var_337_31.prefab_name] ~= nil then
						local var_337_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_31.prefab_name].transform, "story_v_out_115301", "115301083", "story_v_out_115301.awb")

						arg_334_1:RecordAudio("115301083", var_337_37)
						arg_334_1:RecordAudio("115301083", var_337_37)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_115301", "115301083", "story_v_out_115301.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_115301", "115301083", "story_v_out_115301.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_38 = var_337_27 + 0.3
			local var_337_39 = math.max(var_337_28, arg_334_1.talkMaxDuration)

			if var_337_38 <= arg_334_1.time_ and arg_334_1.time_ < var_337_38 + var_337_39 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_38) / var_337_39

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_38 + var_337_39 and arg_334_1.time_ < var_337_38 + var_337_39 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play115301084 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 115301084
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play115301085(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 0.875

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_2 = arg_340_1:GetWordFromCfg(115301084)
				local var_343_3 = arg_340_1:FormatText(var_343_2.content)

				arg_340_1.text_.text = var_343_3

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 35
				local var_343_5 = utf8.len(var_343_3)
				local var_343_6 = var_343_4 <= 0 and var_343_1 or var_343_1 * (var_343_5 / var_343_4)

				if var_343_6 > 0 and var_343_1 < var_343_6 then
					arg_340_1.talkMaxDuration = var_343_6

					if var_343_6 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_6 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_3
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_7 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_7 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_7

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_7 and arg_340_1.time_ < var_343_0 + var_343_7 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play115301085 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 115301085
		arg_344_1.duration_ = 3.63

		local var_344_0 = {
			ja = 3.633,
			ko = 3.166,
			zh = 2.866,
			en = 1.9
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play115301086(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.275

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_2 = arg_344_1:FormatText(StoryNameCfg[309].name)

				arg_344_1.leftNameTxt_.text = var_347_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_3 = arg_344_1:GetWordFromCfg(115301085)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 11
				local var_347_6 = utf8.len(var_347_4)
				local var_347_7 = var_347_5 <= 0 and var_347_1 or var_347_1 * (var_347_6 / var_347_5)

				if var_347_7 > 0 and var_347_1 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301085", "story_v_out_115301.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301085", "story_v_out_115301.awb") / 1000

					if var_347_8 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_0
					end

					if var_347_3.prefab_name ~= "" and arg_344_1.actors_[var_347_3.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_3.prefab_name].transform, "story_v_out_115301", "115301085", "story_v_out_115301.awb")

						arg_344_1:RecordAudio("115301085", var_347_9)
						arg_344_1:RecordAudio("115301085", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_115301", "115301085", "story_v_out_115301.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_115301", "115301085", "story_v_out_115301.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_10 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_10 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_10

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_10 and arg_344_1.time_ < var_347_0 + var_347_10 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play115301086 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 115301086
		arg_348_1.duration_ = 6.9

		local var_348_0 = {
			ja = 2.6,
			ko = 3.166,
			zh = 3.766,
			en = 6.9
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play115301087(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.325

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[317].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_3 = arg_348_1:GetWordFromCfg(115301086)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 13
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301086", "story_v_out_115301.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301086", "story_v_out_115301.awb") / 1000

					if var_351_8 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_0
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_out_115301", "115301086", "story_v_out_115301.awb")

						arg_348_1:RecordAudio("115301086", var_351_9)
						arg_348_1:RecordAudio("115301086", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_115301", "115301086", "story_v_out_115301.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_115301", "115301086", "story_v_out_115301.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_10 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_10 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_10

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_10 and arg_348_1.time_ < var_351_0 + var_351_10 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play115301087 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 115301087
		arg_352_1.duration_ = 5.77

		local var_352_0 = {
			ja = 5.766,
			ko = 4,
			zh = 4.1,
			en = 5.033
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play115301088(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0
			local var_355_1 = 0.375

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_2 = arg_352_1:FormatText(StoryNameCfg[309].name)

				arg_352_1.leftNameTxt_.text = var_355_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_3 = arg_352_1:GetWordFromCfg(115301087)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 15
				local var_355_6 = utf8.len(var_355_4)
				local var_355_7 = var_355_5 <= 0 and var_355_1 or var_355_1 * (var_355_6 / var_355_5)

				if var_355_7 > 0 and var_355_1 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_0
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301087", "story_v_out_115301.awb") ~= 0 then
					local var_355_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301087", "story_v_out_115301.awb") / 1000

					if var_355_8 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_8 + var_355_0
					end

					if var_355_3.prefab_name ~= "" and arg_352_1.actors_[var_355_3.prefab_name] ~= nil then
						local var_355_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_3.prefab_name].transform, "story_v_out_115301", "115301087", "story_v_out_115301.awb")

						arg_352_1:RecordAudio("115301087", var_355_9)
						arg_352_1:RecordAudio("115301087", var_355_9)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_115301", "115301087", "story_v_out_115301.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_115301", "115301087", "story_v_out_115301.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_10 = math.max(var_355_1, arg_352_1.talkMaxDuration)

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_10 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_0) / var_355_10

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_0 + var_355_10 and arg_352_1.time_ < var_355_0 + var_355_10 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play115301088 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 115301088
		arg_356_1.duration_ = 7.07

		local var_356_0 = {
			ja = 5.166,
			ko = 6.733,
			zh = 5.866,
			en = 7.066
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play115301089(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.525

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[317].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:GetWordFromCfg(115301088)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 21
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301088", "story_v_out_115301.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301088", "story_v_out_115301.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_115301", "115301088", "story_v_out_115301.awb")

						arg_356_1:RecordAudio("115301088", var_359_9)
						arg_356_1:RecordAudio("115301088", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_115301", "115301088", "story_v_out_115301.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_115301", "115301088", "story_v_out_115301.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play115301089 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 115301089
		arg_360_1.duration_ = 15.5

		local var_360_0 = {
			ja = 9.466,
			ko = 11.533,
			zh = 11.833,
			en = 15.5
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play115301090(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 1.2

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[317].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_3 = arg_360_1:GetWordFromCfg(115301089)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 48
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301089", "story_v_out_115301.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301089", "story_v_out_115301.awb") / 1000

					if var_363_8 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_0
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_115301", "115301089", "story_v_out_115301.awb")

						arg_360_1:RecordAudio("115301089", var_363_9)
						arg_360_1:RecordAudio("115301089", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_115301", "115301089", "story_v_out_115301.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_115301", "115301089", "story_v_out_115301.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_10 and arg_360_1.time_ < var_363_0 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play115301090 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 115301090
		arg_364_1.duration_ = 5.63

		local var_364_0 = {
			ja = 5.633,
			ko = 2.9,
			zh = 2.633,
			en = 3.733
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play115301091(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.3

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[309].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_3 = arg_364_1:GetWordFromCfg(115301090)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 12
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301090", "story_v_out_115301.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301090", "story_v_out_115301.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_115301", "115301090", "story_v_out_115301.awb")

						arg_364_1:RecordAudio("115301090", var_367_9)
						arg_364_1:RecordAudio("115301090", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_115301", "115301090", "story_v_out_115301.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_115301", "115301090", "story_v_out_115301.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_10 and arg_364_1.time_ < var_367_0 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play115301091 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 115301091
		arg_368_1.duration_ = 11.6

		local var_368_0 = {
			ja = 11.6,
			ko = 7.333,
			zh = 6.8,
			en = 8.9
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play115301092(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.825

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[317].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_3 = arg_368_1:GetWordFromCfg(115301091)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 33
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301091", "story_v_out_115301.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301091", "story_v_out_115301.awb") / 1000

					if var_371_8 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_0
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_115301", "115301091", "story_v_out_115301.awb")

						arg_368_1:RecordAudio("115301091", var_371_9)
						arg_368_1:RecordAudio("115301091", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_115301", "115301091", "story_v_out_115301.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_115301", "115301091", "story_v_out_115301.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_10 and arg_368_1.time_ < var_371_0 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play115301092 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 115301092
		arg_372_1.duration_ = 7.43

		local var_372_0 = {
			ja = 7.433,
			ko = 5.566,
			zh = 4.1,
			en = 4.533
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play115301093(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 0.475

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_2 = arg_372_1:FormatText(StoryNameCfg[309].name)

				arg_372_1.leftNameTxt_.text = var_375_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_3 = arg_372_1:GetWordFromCfg(115301092)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 19
				local var_375_6 = utf8.len(var_375_4)
				local var_375_7 = var_375_5 <= 0 and var_375_1 or var_375_1 * (var_375_6 / var_375_5)

				if var_375_7 > 0 and var_375_1 < var_375_7 then
					arg_372_1.talkMaxDuration = var_375_7

					if var_375_7 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301092", "story_v_out_115301.awb") ~= 0 then
					local var_375_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301092", "story_v_out_115301.awb") / 1000

					if var_375_8 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_8 + var_375_0
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_out_115301", "115301092", "story_v_out_115301.awb")

						arg_372_1:RecordAudio("115301092", var_375_9)
						arg_372_1:RecordAudio("115301092", var_375_9)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_115301", "115301092", "story_v_out_115301.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_115301", "115301092", "story_v_out_115301.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_10 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_10 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_10

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_10 and arg_372_1.time_ < var_375_0 + var_375_10 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play115301093 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 115301093
		arg_376_1.duration_ = 5.93

		local var_376_0 = {
			ja = 3.7,
			ko = 5.8,
			zh = 4.766,
			en = 5.933
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play115301094(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.45

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_2 = arg_376_1:FormatText(StoryNameCfg[317].name)

				arg_376_1.leftNameTxt_.text = var_379_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_3 = arg_376_1:GetWordFromCfg(115301093)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 18
				local var_379_6 = utf8.len(var_379_4)
				local var_379_7 = var_379_5 <= 0 and var_379_1 or var_379_1 * (var_379_6 / var_379_5)

				if var_379_7 > 0 and var_379_1 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_4
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301093", "story_v_out_115301.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301093", "story_v_out_115301.awb") / 1000

					if var_379_8 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_0
					end

					if var_379_3.prefab_name ~= "" and arg_376_1.actors_[var_379_3.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_3.prefab_name].transform, "story_v_out_115301", "115301093", "story_v_out_115301.awb")

						arg_376_1:RecordAudio("115301093", var_379_9)
						arg_376_1:RecordAudio("115301093", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_115301", "115301093", "story_v_out_115301.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_115301", "115301093", "story_v_out_115301.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_10 and arg_376_1.time_ < var_379_0 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play115301094 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 115301094
		arg_380_1.duration_ = 7.47

		local var_380_0 = {
			ja = 7.466,
			ko = 6,
			zh = 5.7,
			en = 5.933
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play115301095(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.65

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_2 = arg_380_1:FormatText(StoryNameCfg[317].name)

				arg_380_1.leftNameTxt_.text = var_383_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_3 = arg_380_1:GetWordFromCfg(115301094)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 26
				local var_383_6 = utf8.len(var_383_4)
				local var_383_7 = var_383_5 <= 0 and var_383_1 or var_383_1 * (var_383_6 / var_383_5)

				if var_383_7 > 0 and var_383_1 < var_383_7 then
					arg_380_1.talkMaxDuration = var_383_7

					if var_383_7 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301094", "story_v_out_115301.awb") ~= 0 then
					local var_383_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301094", "story_v_out_115301.awb") / 1000

					if var_383_8 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_0
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_out_115301", "115301094", "story_v_out_115301.awb")

						arg_380_1:RecordAudio("115301094", var_383_9)
						arg_380_1:RecordAudio("115301094", var_383_9)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_115301", "115301094", "story_v_out_115301.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_115301", "115301094", "story_v_out_115301.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_10 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_10 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_10

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_10 and arg_380_1.time_ < var_383_0 + var_383_10 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play115301095 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 115301095
		arg_384_1.duration_ = 9

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play115301096(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 2

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				local var_387_1 = manager.ui.mainCamera.transform.localPosition
				local var_387_2 = Vector3.New(0, 0, 10) + Vector3.New(var_387_1.x, var_387_1.y, 0)
				local var_387_3 = arg_384_1.bgs_.F01

				var_387_3.transform.localPosition = var_387_2
				var_387_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_387_4 = var_387_3:GetComponent("SpriteRenderer")

				if var_387_4 and var_387_4.sprite then
					local var_387_5 = (var_387_3.transform.localPosition - var_387_1).z
					local var_387_6 = manager.ui.mainCameraCom_
					local var_387_7 = 2 * var_387_5 * Mathf.Tan(var_387_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_387_8 = var_387_7 * var_387_6.aspect
					local var_387_9 = var_387_4.sprite.bounds.size.x
					local var_387_10 = var_387_4.sprite.bounds.size.y
					local var_387_11 = var_387_8 / var_387_9
					local var_387_12 = var_387_7 / var_387_10
					local var_387_13 = var_387_12 < var_387_11 and var_387_11 or var_387_12

					var_387_3.transform.localScale = Vector3.New(var_387_13, var_387_13, 0)
				end

				for iter_387_0, iter_387_1 in pairs(arg_384_1.bgs_) do
					if iter_387_0 ~= "F01" then
						iter_387_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_387_14 = 0

			if var_387_14 < arg_384_1.time_ and arg_384_1.time_ <= var_387_14 + arg_387_0 then
				arg_384_1.mask_.enabled = true
				arg_384_1.mask_.raycastTarget = false

				arg_384_1:SetGaussion(false)
			end

			local var_387_15 = 2

			if var_387_14 <= arg_384_1.time_ and arg_384_1.time_ < var_387_14 + var_387_15 then
				local var_387_16 = (arg_384_1.time_ - var_387_14) / var_387_15
				local var_387_17 = Color.New(0, 0, 0)

				var_387_17.a = Mathf.Lerp(0, 1, var_387_16)
				arg_384_1.mask_.color = var_387_17
			end

			if arg_384_1.time_ >= var_387_14 + var_387_15 and arg_384_1.time_ < var_387_14 + var_387_15 + arg_387_0 then
				local var_387_18 = Color.New(0, 0, 0)

				var_387_18.a = 1
				arg_384_1.mask_.color = var_387_18
			end

			local var_387_19 = 2

			if var_387_19 < arg_384_1.time_ and arg_384_1.time_ <= var_387_19 + arg_387_0 then
				arg_384_1.mask_.enabled = true
				arg_384_1.mask_.raycastTarget = false

				arg_384_1:SetGaussion(false)
			end

			local var_387_20 = 2

			if var_387_19 <= arg_384_1.time_ and arg_384_1.time_ < var_387_19 + var_387_20 then
				local var_387_21 = (arg_384_1.time_ - var_387_19) / var_387_20
				local var_387_22 = Color.New(0, 0, 0)

				var_387_22.a = Mathf.Lerp(1, 0, var_387_21)
				arg_384_1.mask_.color = var_387_22
			end

			if arg_384_1.time_ >= var_387_19 + var_387_20 and arg_384_1.time_ < var_387_19 + var_387_20 + arg_387_0 then
				local var_387_23 = Color.New(0, 0, 0)
				local var_387_24 = 0

				arg_384_1.mask_.enabled = false
				var_387_23.a = var_387_24
				arg_384_1.mask_.color = var_387_23
			end

			if arg_384_1.frameCnt_ <= 1 then
				arg_384_1.dialog_:SetActive(false)
			end

			local var_387_25 = 4
			local var_387_26 = 0.875

			if var_387_25 < arg_384_1.time_ and arg_384_1.time_ <= var_387_25 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0

				arg_384_1.dialog_:SetActive(true)

				arg_384_1.dialogCg_.alpha = 0

				local var_387_27 = LeanTween.value(arg_384_1.dialog_, 0, 1, 0.3)

				var_387_27:setOnUpdate(LuaHelper.FloatAction(function(arg_388_0)
					arg_384_1.dialogCg_.alpha = arg_388_0
				end))
				var_387_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_384_1.dialog_)
					var_387_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_384_1.duration_ = arg_384_1.duration_ + 0.3

				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_28 = arg_384_1:GetWordFromCfg(115301095)
				local var_387_29 = arg_384_1:FormatText(var_387_28.content)

				arg_384_1.text_.text = var_387_29

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_30 = 35
				local var_387_31 = utf8.len(var_387_29)
				local var_387_32 = var_387_30 <= 0 and var_387_26 or var_387_26 * (var_387_31 / var_387_30)

				if var_387_32 > 0 and var_387_26 < var_387_32 then
					arg_384_1.talkMaxDuration = var_387_32
					var_387_25 = var_387_25 + 0.3

					if var_387_32 + var_387_25 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_32 + var_387_25
					end
				end

				arg_384_1.text_.text = var_387_29
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_33 = var_387_25 + 0.3
			local var_387_34 = math.max(var_387_26, arg_384_1.talkMaxDuration)

			if var_387_33 <= arg_384_1.time_ and arg_384_1.time_ < var_387_33 + var_387_34 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_33) / var_387_34

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_33 + var_387_34 and arg_384_1.time_ < var_387_33 + var_387_34 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play115301096 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 115301096
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play115301097(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 1.5

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_2 = arg_390_1:GetWordFromCfg(115301096)
				local var_393_3 = arg_390_1:FormatText(var_393_2.content)

				arg_390_1.text_.text = var_393_3

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 60
				local var_393_5 = utf8.len(var_393_3)
				local var_393_6 = var_393_4 <= 0 and var_393_1 or var_393_1 * (var_393_5 / var_393_4)

				if var_393_6 > 0 and var_393_1 < var_393_6 then
					arg_390_1.talkMaxDuration = var_393_6

					if var_393_6 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_6 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_3
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_7 and arg_390_1.time_ < var_393_0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play115301097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 115301097
		arg_394_1.duration_ = 10.4

		local var_394_0 = {
			ja = 4.7,
			ko = 8.266,
			zh = 8.166,
			en = 10.4
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play115301098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["10030"].transform
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.var_.moveOldPos10030 = var_397_0.localPosition
				var_397_0.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("10030", 3)

				local var_397_2 = var_397_0.childCount

				for iter_397_0 = 0, var_397_2 - 1 do
					local var_397_3 = var_397_0:GetChild(iter_397_0)

					if var_397_3.name == "split_3" or not string.find(var_397_3.name, "split") then
						var_397_3.gameObject:SetActive(true)
					else
						var_397_3.gameObject:SetActive(false)
					end
				end
			end

			local var_397_4 = 0.001

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_4 then
				local var_397_5 = (arg_394_1.time_ - var_397_1) / var_397_4
				local var_397_6 = Vector3.New(0, -390, 150)

				var_397_0.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos10030, var_397_6, var_397_5)
			end

			if arg_394_1.time_ >= var_397_1 + var_397_4 and arg_394_1.time_ < var_397_1 + var_397_4 + arg_397_0 then
				var_397_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_397_7 = arg_394_1.actors_["10030"]
			local var_397_8 = 0

			if var_397_8 < arg_394_1.time_ and arg_394_1.time_ <= var_397_8 + arg_397_0 and not isNil(var_397_7) and arg_394_1.var_.actorSpriteComps10030 == nil then
				arg_394_1.var_.actorSpriteComps10030 = var_397_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_9 = 0.2

			if var_397_8 <= arg_394_1.time_ and arg_394_1.time_ < var_397_8 + var_397_9 and not isNil(var_397_7) then
				local var_397_10 = (arg_394_1.time_ - var_397_8) / var_397_9

				if arg_394_1.var_.actorSpriteComps10030 then
					for iter_397_1, iter_397_2 in pairs(arg_394_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_397_2 then
							if arg_394_1.isInRecall_ then
								local var_397_11 = Mathf.Lerp(iter_397_2.color.r, arg_394_1.hightColor1.r, var_397_10)
								local var_397_12 = Mathf.Lerp(iter_397_2.color.g, arg_394_1.hightColor1.g, var_397_10)
								local var_397_13 = Mathf.Lerp(iter_397_2.color.b, arg_394_1.hightColor1.b, var_397_10)

								iter_397_2.color = Color.New(var_397_11, var_397_12, var_397_13)
							else
								local var_397_14 = Mathf.Lerp(iter_397_2.color.r, 1, var_397_10)

								iter_397_2.color = Color.New(var_397_14, var_397_14, var_397_14)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= var_397_8 + var_397_9 and arg_394_1.time_ < var_397_8 + var_397_9 + arg_397_0 and not isNil(var_397_7) and arg_394_1.var_.actorSpriteComps10030 then
				for iter_397_3, iter_397_4 in pairs(arg_394_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_397_4 then
						if arg_394_1.isInRecall_ then
							iter_397_4.color = arg_394_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_397_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_394_1.var_.actorSpriteComps10030 = nil
			end

			local var_397_15 = arg_394_1.actors_["10030"]
			local var_397_16 = 0

			if var_397_16 < arg_394_1.time_ and arg_394_1.time_ <= var_397_16 + arg_397_0 then
				local var_397_17 = var_397_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_397_17 then
					arg_394_1.var_.alphaOldValue10030 = var_397_17.alpha
					arg_394_1.var_.characterEffect10030 = var_397_17
				end

				arg_394_1.var_.alphaOldValue10030 = 0
			end

			local var_397_18 = 0.333333333333333

			if var_397_16 <= arg_394_1.time_ and arg_394_1.time_ < var_397_16 + var_397_18 then
				local var_397_19 = (arg_394_1.time_ - var_397_16) / var_397_18
				local var_397_20 = Mathf.Lerp(arg_394_1.var_.alphaOldValue10030, 1, var_397_19)

				if arg_394_1.var_.characterEffect10030 then
					arg_394_1.var_.characterEffect10030.alpha = var_397_20
				end
			end

			if arg_394_1.time_ >= var_397_16 + var_397_18 and arg_394_1.time_ < var_397_16 + var_397_18 + arg_397_0 and arg_394_1.var_.characterEffect10030 then
				arg_394_1.var_.characterEffect10030.alpha = 1
			end

			local var_397_21 = 0
			local var_397_22 = 0.725

			if var_397_21 < arg_394_1.time_ and arg_394_1.time_ <= var_397_21 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_23 = arg_394_1:FormatText(StoryNameCfg[309].name)

				arg_394_1.leftNameTxt_.text = var_397_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_24 = arg_394_1:GetWordFromCfg(115301097)
				local var_397_25 = arg_394_1:FormatText(var_397_24.content)

				arg_394_1.text_.text = var_397_25

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_26 = 29
				local var_397_27 = utf8.len(var_397_25)
				local var_397_28 = var_397_26 <= 0 and var_397_22 or var_397_22 * (var_397_27 / var_397_26)

				if var_397_28 > 0 and var_397_22 < var_397_28 then
					arg_394_1.talkMaxDuration = var_397_28

					if var_397_28 + var_397_21 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_28 + var_397_21
					end
				end

				arg_394_1.text_.text = var_397_25
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301097", "story_v_out_115301.awb") ~= 0 then
					local var_397_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301097", "story_v_out_115301.awb") / 1000

					if var_397_29 + var_397_21 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_29 + var_397_21
					end

					if var_397_24.prefab_name ~= "" and arg_394_1.actors_[var_397_24.prefab_name] ~= nil then
						local var_397_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_24.prefab_name].transform, "story_v_out_115301", "115301097", "story_v_out_115301.awb")

						arg_394_1:RecordAudio("115301097", var_397_30)
						arg_394_1:RecordAudio("115301097", var_397_30)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_115301", "115301097", "story_v_out_115301.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_115301", "115301097", "story_v_out_115301.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_31 = math.max(var_397_22, arg_394_1.talkMaxDuration)

			if var_397_21 <= arg_394_1.time_ and arg_394_1.time_ < var_397_21 + var_397_31 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_21) / var_397_31

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_21 + var_397_31 and arg_394_1.time_ < var_397_21 + var_397_31 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play115301098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 115301098
		arg_398_1.duration_ = 14.3

		local var_398_0 = {
			ja = 14.3,
			ko = 8.466,
			zh = 7.233,
			en = 8.233
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play115301099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.675

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[309].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_3 = arg_398_1:GetWordFromCfg(115301098)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 27
				local var_401_6 = utf8.len(var_401_4)
				local var_401_7 = var_401_5 <= 0 and var_401_1 or var_401_1 * (var_401_6 / var_401_5)

				if var_401_7 > 0 and var_401_1 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301098", "story_v_out_115301.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301098", "story_v_out_115301.awb") / 1000

					if var_401_8 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_0
					end

					if var_401_3.prefab_name ~= "" and arg_398_1.actors_[var_401_3.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_3.prefab_name].transform, "story_v_out_115301", "115301098", "story_v_out_115301.awb")

						arg_398_1:RecordAudio("115301098", var_401_9)
						arg_398_1:RecordAudio("115301098", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_115301", "115301098", "story_v_out_115301.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_115301", "115301098", "story_v_out_115301.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_10 and arg_398_1.time_ < var_401_0 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play115301099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 115301099
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play115301100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["10030"]
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				local var_405_2 = var_405_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_405_2 then
					arg_402_1.var_.alphaOldValue10030 = var_405_2.alpha
					arg_402_1.var_.characterEffect10030 = var_405_2
				end

				arg_402_1.var_.alphaOldValue10030 = 1
			end

			local var_405_3 = 0.333333333333333

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_3 then
				local var_405_4 = (arg_402_1.time_ - var_405_1) / var_405_3
				local var_405_5 = Mathf.Lerp(arg_402_1.var_.alphaOldValue10030, 0, var_405_4)

				if arg_402_1.var_.characterEffect10030 then
					arg_402_1.var_.characterEffect10030.alpha = var_405_5
				end
			end

			if arg_402_1.time_ >= var_405_1 + var_405_3 and arg_402_1.time_ < var_405_1 + var_405_3 + arg_405_0 and arg_402_1.var_.characterEffect10030 then
				arg_402_1.var_.characterEffect10030.alpha = 0
			end

			local var_405_6 = 0
			local var_405_7 = 0.925

			if var_405_6 < arg_402_1.time_ and arg_402_1.time_ <= var_405_6 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, false)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_8 = arg_402_1:GetWordFromCfg(115301099)
				local var_405_9 = arg_402_1:FormatText(var_405_8.content)

				arg_402_1.text_.text = var_405_9

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_10 = 37
				local var_405_11 = utf8.len(var_405_9)
				local var_405_12 = var_405_10 <= 0 and var_405_7 or var_405_7 * (var_405_11 / var_405_10)

				if var_405_12 > 0 and var_405_7 < var_405_12 then
					arg_402_1.talkMaxDuration = var_405_12

					if var_405_12 + var_405_6 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_12 + var_405_6
					end
				end

				arg_402_1.text_.text = var_405_9
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_13 = math.max(var_405_7, arg_402_1.talkMaxDuration)

			if var_405_6 <= arg_402_1.time_ and arg_402_1.time_ < var_405_6 + var_405_13 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_6) / var_405_13

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_6 + var_405_13 and arg_402_1.time_ < var_405_6 + var_405_13 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play115301100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 115301100
		arg_406_1.duration_ = 10.1

		local var_406_0 = {
			ja = 10.1,
			ko = 8.066,
			zh = 5.833,
			en = 5.466
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play115301101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["10030"].transform
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.var_.moveOldPos10030 = var_409_0.localPosition
				var_409_0.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("10030", 4)

				local var_409_2 = var_409_0.childCount

				for iter_409_0 = 0, var_409_2 - 1 do
					local var_409_3 = var_409_0:GetChild(iter_409_0)

					if var_409_3.name == "split_3" or not string.find(var_409_3.name, "split") then
						var_409_3.gameObject:SetActive(true)
					else
						var_409_3.gameObject:SetActive(false)
					end
				end
			end

			local var_409_4 = 0.001

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_4 then
				local var_409_5 = (arg_406_1.time_ - var_409_1) / var_409_4
				local var_409_6 = Vector3.New(390, -390, 150)

				var_409_0.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos10030, var_409_6, var_409_5)
			end

			if arg_406_1.time_ >= var_409_1 + var_409_4 and arg_406_1.time_ < var_409_1 + var_409_4 + arg_409_0 then
				var_409_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_409_7 = arg_406_1.actors_["10030"]
			local var_409_8 = 0

			if var_409_8 < arg_406_1.time_ and arg_406_1.time_ <= var_409_8 + arg_409_0 then
				local var_409_9 = var_409_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_409_9 then
					arg_406_1.var_.alphaOldValue10030 = var_409_9.alpha
					arg_406_1.var_.characterEffect10030 = var_409_9
				end

				arg_406_1.var_.alphaOldValue10030 = 0
			end

			local var_409_10 = 0.333333333333333

			if var_409_8 <= arg_406_1.time_ and arg_406_1.time_ < var_409_8 + var_409_10 then
				local var_409_11 = (arg_406_1.time_ - var_409_8) / var_409_10
				local var_409_12 = Mathf.Lerp(arg_406_1.var_.alphaOldValue10030, 1, var_409_11)

				if arg_406_1.var_.characterEffect10030 then
					arg_406_1.var_.characterEffect10030.alpha = var_409_12
				end
			end

			if arg_406_1.time_ >= var_409_8 + var_409_10 and arg_406_1.time_ < var_409_8 + var_409_10 + arg_409_0 and arg_406_1.var_.characterEffect10030 then
				arg_406_1.var_.characterEffect10030.alpha = 1
			end

			local var_409_13 = 0
			local var_409_14 = 0.6

			if var_409_13 < arg_406_1.time_ and arg_406_1.time_ <= var_409_13 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_15 = arg_406_1:FormatText(StoryNameCfg[309].name)

				arg_406_1.leftNameTxt_.text = var_409_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_16 = arg_406_1:GetWordFromCfg(115301100)
				local var_409_17 = arg_406_1:FormatText(var_409_16.content)

				arg_406_1.text_.text = var_409_17

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_18 = 24
				local var_409_19 = utf8.len(var_409_17)
				local var_409_20 = var_409_18 <= 0 and var_409_14 or var_409_14 * (var_409_19 / var_409_18)

				if var_409_20 > 0 and var_409_14 < var_409_20 then
					arg_406_1.talkMaxDuration = var_409_20

					if var_409_20 + var_409_13 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_20 + var_409_13
					end
				end

				arg_406_1.text_.text = var_409_17
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301100", "story_v_out_115301.awb") ~= 0 then
					local var_409_21 = manager.audio:GetVoiceLength("story_v_out_115301", "115301100", "story_v_out_115301.awb") / 1000

					if var_409_21 + var_409_13 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_21 + var_409_13
					end

					if var_409_16.prefab_name ~= "" and arg_406_1.actors_[var_409_16.prefab_name] ~= nil then
						local var_409_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_16.prefab_name].transform, "story_v_out_115301", "115301100", "story_v_out_115301.awb")

						arg_406_1:RecordAudio("115301100", var_409_22)
						arg_406_1:RecordAudio("115301100", var_409_22)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_115301", "115301100", "story_v_out_115301.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_115301", "115301100", "story_v_out_115301.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_23 = math.max(var_409_14, arg_406_1.talkMaxDuration)

			if var_409_13 <= arg_406_1.time_ and arg_406_1.time_ < var_409_13 + var_409_23 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_13) / var_409_23

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_13 + var_409_23 and arg_406_1.time_ < var_409_13 + var_409_23 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play115301101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 115301101
		arg_410_1.duration_ = 9.93

		local var_410_0 = {
			ja = 8.566,
			ko = 6.8,
			zh = 9.933,
			en = 7.066
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play115301102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1038"].transform
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.var_.moveOldPos1038 = var_413_0.localPosition
				var_413_0.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1038", 2)

				local var_413_2 = var_413_0.childCount

				for iter_413_0 = 0, var_413_2 - 1 do
					local var_413_3 = var_413_0:GetChild(iter_413_0)

					if var_413_3.name == "split_1" or not string.find(var_413_3.name, "split") then
						var_413_3.gameObject:SetActive(true)
					else
						var_413_3.gameObject:SetActive(false)
					end
				end
			end

			local var_413_4 = 0.001

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_4 then
				local var_413_5 = (arg_410_1.time_ - var_413_1) / var_413_4
				local var_413_6 = Vector3.New(-390, -400, 0)

				var_413_0.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1038, var_413_6, var_413_5)
			end

			if arg_410_1.time_ >= var_413_1 + var_413_4 and arg_410_1.time_ < var_413_1 + var_413_4 + arg_413_0 then
				var_413_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_413_7 = arg_410_1.actors_["10030"]
			local var_413_8 = 0

			if var_413_8 < arg_410_1.time_ and arg_410_1.time_ <= var_413_8 + arg_413_0 and not isNil(var_413_7) and arg_410_1.var_.actorSpriteComps10030 == nil then
				arg_410_1.var_.actorSpriteComps10030 = var_413_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_9 = 0.2

			if var_413_8 <= arg_410_1.time_ and arg_410_1.time_ < var_413_8 + var_413_9 and not isNil(var_413_7) then
				local var_413_10 = (arg_410_1.time_ - var_413_8) / var_413_9

				if arg_410_1.var_.actorSpriteComps10030 then
					for iter_413_1, iter_413_2 in pairs(arg_410_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_413_2 then
							if arg_410_1.isInRecall_ then
								local var_413_11 = Mathf.Lerp(iter_413_2.color.r, arg_410_1.hightColor2.r, var_413_10)
								local var_413_12 = Mathf.Lerp(iter_413_2.color.g, arg_410_1.hightColor2.g, var_413_10)
								local var_413_13 = Mathf.Lerp(iter_413_2.color.b, arg_410_1.hightColor2.b, var_413_10)

								iter_413_2.color = Color.New(var_413_11, var_413_12, var_413_13)
							else
								local var_413_14 = Mathf.Lerp(iter_413_2.color.r, 0.5, var_413_10)

								iter_413_2.color = Color.New(var_413_14, var_413_14, var_413_14)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= var_413_8 + var_413_9 and arg_410_1.time_ < var_413_8 + var_413_9 + arg_413_0 and not isNil(var_413_7) and arg_410_1.var_.actorSpriteComps10030 then
				for iter_413_3, iter_413_4 in pairs(arg_410_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_413_4 then
						if arg_410_1.isInRecall_ then
							iter_413_4.color = arg_410_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_413_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_410_1.var_.actorSpriteComps10030 = nil
			end

			local var_413_15 = arg_410_1.actors_["1038"]
			local var_413_16 = 0

			if var_413_16 < arg_410_1.time_ and arg_410_1.time_ <= var_413_16 + arg_413_0 then
				local var_413_17 = var_413_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_413_17 then
					arg_410_1.var_.alphaOldValue1038 = var_413_17.alpha
					arg_410_1.var_.characterEffect1038 = var_413_17
				end

				arg_410_1.var_.alphaOldValue1038 = 0
			end

			local var_413_18 = 0.333333333333333

			if var_413_16 <= arg_410_1.time_ and arg_410_1.time_ < var_413_16 + var_413_18 then
				local var_413_19 = (arg_410_1.time_ - var_413_16) / var_413_18
				local var_413_20 = Mathf.Lerp(arg_410_1.var_.alphaOldValue1038, 1, var_413_19)

				if arg_410_1.var_.characterEffect1038 then
					arg_410_1.var_.characterEffect1038.alpha = var_413_20
				end
			end

			if arg_410_1.time_ >= var_413_16 + var_413_18 and arg_410_1.time_ < var_413_16 + var_413_18 + arg_413_0 and arg_410_1.var_.characterEffect1038 then
				arg_410_1.var_.characterEffect1038.alpha = 1
			end

			local var_413_21 = arg_410_1.actors_["1038"]
			local var_413_22 = 0

			if var_413_22 < arg_410_1.time_ and arg_410_1.time_ <= var_413_22 + arg_413_0 and not isNil(var_413_21) and arg_410_1.var_.actorSpriteComps1038 == nil then
				arg_410_1.var_.actorSpriteComps1038 = var_413_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_23 = 0.2

			if var_413_22 <= arg_410_1.time_ and arg_410_1.time_ < var_413_22 + var_413_23 and not isNil(var_413_21) then
				local var_413_24 = (arg_410_1.time_ - var_413_22) / var_413_23

				if arg_410_1.var_.actorSpriteComps1038 then
					for iter_413_5, iter_413_6 in pairs(arg_410_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_413_6 then
							if arg_410_1.isInRecall_ then
								local var_413_25 = Mathf.Lerp(iter_413_6.color.r, arg_410_1.hightColor1.r, var_413_24)
								local var_413_26 = Mathf.Lerp(iter_413_6.color.g, arg_410_1.hightColor1.g, var_413_24)
								local var_413_27 = Mathf.Lerp(iter_413_6.color.b, arg_410_1.hightColor1.b, var_413_24)

								iter_413_6.color = Color.New(var_413_25, var_413_26, var_413_27)
							else
								local var_413_28 = Mathf.Lerp(iter_413_6.color.r, 1, var_413_24)

								iter_413_6.color = Color.New(var_413_28, var_413_28, var_413_28)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= var_413_22 + var_413_23 and arg_410_1.time_ < var_413_22 + var_413_23 + arg_413_0 and not isNil(var_413_21) and arg_410_1.var_.actorSpriteComps1038 then
				for iter_413_7, iter_413_8 in pairs(arg_410_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_413_8 then
						if arg_410_1.isInRecall_ then
							iter_413_8.color = arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_413_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_410_1.var_.actorSpriteComps1038 = nil
			end

			local var_413_29 = 0
			local var_413_30 = 0.725

			if var_413_29 < arg_410_1.time_ and arg_410_1.time_ <= var_413_29 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_31 = arg_410_1:FormatText(StoryNameCfg[94].name)

				arg_410_1.leftNameTxt_.text = var_413_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_32 = arg_410_1:GetWordFromCfg(115301101)
				local var_413_33 = arg_410_1:FormatText(var_413_32.content)

				arg_410_1.text_.text = var_413_33

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_34 = 29
				local var_413_35 = utf8.len(var_413_33)
				local var_413_36 = var_413_34 <= 0 and var_413_30 or var_413_30 * (var_413_35 / var_413_34)

				if var_413_36 > 0 and var_413_30 < var_413_36 then
					arg_410_1.talkMaxDuration = var_413_36

					if var_413_36 + var_413_29 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_36 + var_413_29
					end
				end

				arg_410_1.text_.text = var_413_33
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301101", "story_v_out_115301.awb") ~= 0 then
					local var_413_37 = manager.audio:GetVoiceLength("story_v_out_115301", "115301101", "story_v_out_115301.awb") / 1000

					if var_413_37 + var_413_29 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_37 + var_413_29
					end

					if var_413_32.prefab_name ~= "" and arg_410_1.actors_[var_413_32.prefab_name] ~= nil then
						local var_413_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_32.prefab_name].transform, "story_v_out_115301", "115301101", "story_v_out_115301.awb")

						arg_410_1:RecordAudio("115301101", var_413_38)
						arg_410_1:RecordAudio("115301101", var_413_38)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_115301", "115301101", "story_v_out_115301.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_115301", "115301101", "story_v_out_115301.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_39 = math.max(var_413_30, arg_410_1.talkMaxDuration)

			if var_413_29 <= arg_410_1.time_ and arg_410_1.time_ < var_413_29 + var_413_39 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_29) / var_413_39

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_29 + var_413_39 and arg_410_1.time_ < var_413_29 + var_413_39 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play115301102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 115301102
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play115301103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1038"]
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.actorSpriteComps1038 == nil then
				arg_414_1.var_.actorSpriteComps1038 = var_417_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_2 = 0.2

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 and not isNil(var_417_0) then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2

				if arg_414_1.var_.actorSpriteComps1038 then
					for iter_417_0, iter_417_1 in pairs(arg_414_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_417_1 then
							if arg_414_1.isInRecall_ then
								local var_417_4 = Mathf.Lerp(iter_417_1.color.r, arg_414_1.hightColor2.r, var_417_3)
								local var_417_5 = Mathf.Lerp(iter_417_1.color.g, arg_414_1.hightColor2.g, var_417_3)
								local var_417_6 = Mathf.Lerp(iter_417_1.color.b, arg_414_1.hightColor2.b, var_417_3)

								iter_417_1.color = Color.New(var_417_4, var_417_5, var_417_6)
							else
								local var_417_7 = Mathf.Lerp(iter_417_1.color.r, 0.5, var_417_3)

								iter_417_1.color = Color.New(var_417_7, var_417_7, var_417_7)
							end
						end
					end
				end
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.actorSpriteComps1038 then
				for iter_417_2, iter_417_3 in pairs(arg_414_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_417_3 then
						if arg_414_1.isInRecall_ then
							iter_417_3.color = arg_414_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_417_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_414_1.var_.actorSpriteComps1038 = nil
			end

			local var_417_8 = 0
			local var_417_9 = 1

			if var_417_8 < arg_414_1.time_ and arg_414_1.time_ <= var_417_8 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_10 = arg_414_1:GetWordFromCfg(115301102)
				local var_417_11 = arg_414_1:FormatText(var_417_10.content)

				arg_414_1.text_.text = var_417_11

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_12 = 40
				local var_417_13 = utf8.len(var_417_11)
				local var_417_14 = var_417_12 <= 0 and var_417_9 or var_417_9 * (var_417_13 / var_417_12)

				if var_417_14 > 0 and var_417_9 < var_417_14 then
					arg_414_1.talkMaxDuration = var_417_14

					if var_417_14 + var_417_8 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_14 + var_417_8
					end
				end

				arg_414_1.text_.text = var_417_11
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_15 = math.max(var_417_9, arg_414_1.talkMaxDuration)

			if var_417_8 <= arg_414_1.time_ and arg_414_1.time_ < var_417_8 + var_417_15 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_8) / var_417_15

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_8 + var_417_15 and arg_414_1.time_ < var_417_8 + var_417_15 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play115301103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 115301103
		arg_418_1.duration_ = 19.8

		local var_418_0 = {
			ja = 12.733,
			ko = 13.8,
			zh = 13.8,
			en = 19.8
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play115301104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["1038"]
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.actorSpriteComps1038 == nil then
				arg_418_1.var_.actorSpriteComps1038 = var_421_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_421_2 = 0.2

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 and not isNil(var_421_0) then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2

				if arg_418_1.var_.actorSpriteComps1038 then
					for iter_421_0, iter_421_1 in pairs(arg_418_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_421_1 then
							if arg_418_1.isInRecall_ then
								local var_421_4 = Mathf.Lerp(iter_421_1.color.r, arg_418_1.hightColor1.r, var_421_3)
								local var_421_5 = Mathf.Lerp(iter_421_1.color.g, arg_418_1.hightColor1.g, var_421_3)
								local var_421_6 = Mathf.Lerp(iter_421_1.color.b, arg_418_1.hightColor1.b, var_421_3)

								iter_421_1.color = Color.New(var_421_4, var_421_5, var_421_6)
							else
								local var_421_7 = Mathf.Lerp(iter_421_1.color.r, 1, var_421_3)

								iter_421_1.color = Color.New(var_421_7, var_421_7, var_421_7)
							end
						end
					end
				end
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.actorSpriteComps1038 then
				for iter_421_2, iter_421_3 in pairs(arg_418_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_421_3 then
						if arg_418_1.isInRecall_ then
							iter_421_3.color = arg_418_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_421_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_418_1.var_.actorSpriteComps1038 = nil
			end

			local var_421_8 = 0
			local var_421_9 = 1.225

			if var_421_8 < arg_418_1.time_ and arg_418_1.time_ <= var_421_8 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_10 = arg_418_1:FormatText(StoryNameCfg[94].name)

				arg_418_1.leftNameTxt_.text = var_421_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_11 = arg_418_1:GetWordFromCfg(115301103)
				local var_421_12 = arg_418_1:FormatText(var_421_11.content)

				arg_418_1.text_.text = var_421_12

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_13 = 49
				local var_421_14 = utf8.len(var_421_12)
				local var_421_15 = var_421_13 <= 0 and var_421_9 or var_421_9 * (var_421_14 / var_421_13)

				if var_421_15 > 0 and var_421_9 < var_421_15 then
					arg_418_1.talkMaxDuration = var_421_15

					if var_421_15 + var_421_8 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_15 + var_421_8
					end
				end

				arg_418_1.text_.text = var_421_12
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301103", "story_v_out_115301.awb") ~= 0 then
					local var_421_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301103", "story_v_out_115301.awb") / 1000

					if var_421_16 + var_421_8 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_16 + var_421_8
					end

					if var_421_11.prefab_name ~= "" and arg_418_1.actors_[var_421_11.prefab_name] ~= nil then
						local var_421_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_11.prefab_name].transform, "story_v_out_115301", "115301103", "story_v_out_115301.awb")

						arg_418_1:RecordAudio("115301103", var_421_17)
						arg_418_1:RecordAudio("115301103", var_421_17)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_115301", "115301103", "story_v_out_115301.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_115301", "115301103", "story_v_out_115301.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_18 = math.max(var_421_9, arg_418_1.talkMaxDuration)

			if var_421_8 <= arg_418_1.time_ and arg_418_1.time_ < var_421_8 + var_421_18 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_8) / var_421_18

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_8 + var_421_18 and arg_418_1.time_ < var_421_8 + var_421_18 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play115301104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 115301104
		arg_422_1.duration_ = 13.8

		local var_422_0 = {
			ja = 12.8,
			ko = 9.666,
			zh = 11.2,
			en = 13.8
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play115301105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0
			local var_425_1 = 1.075

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_2 = arg_422_1:FormatText(StoryNameCfg[94].name)

				arg_422_1.leftNameTxt_.text = var_425_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_3 = arg_422_1:GetWordFromCfg(115301104)
				local var_425_4 = arg_422_1:FormatText(var_425_3.content)

				arg_422_1.text_.text = var_425_4

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_5 = 43
				local var_425_6 = utf8.len(var_425_4)
				local var_425_7 = var_425_5 <= 0 and var_425_1 or var_425_1 * (var_425_6 / var_425_5)

				if var_425_7 > 0 and var_425_1 < var_425_7 then
					arg_422_1.talkMaxDuration = var_425_7

					if var_425_7 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_4
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301104", "story_v_out_115301.awb") ~= 0 then
					local var_425_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301104", "story_v_out_115301.awb") / 1000

					if var_425_8 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_8 + var_425_0
					end

					if var_425_3.prefab_name ~= "" and arg_422_1.actors_[var_425_3.prefab_name] ~= nil then
						local var_425_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_3.prefab_name].transform, "story_v_out_115301", "115301104", "story_v_out_115301.awb")

						arg_422_1:RecordAudio("115301104", var_425_9)
						arg_422_1:RecordAudio("115301104", var_425_9)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_115301", "115301104", "story_v_out_115301.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_115301", "115301104", "story_v_out_115301.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_10 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_10 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_10

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_10 and arg_422_1.time_ < var_425_0 + var_425_10 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play115301105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 115301105
		arg_426_1.duration_ = 18.5

		local var_426_0 = {
			ja = 14.033,
			ko = 17.466,
			zh = 18.5,
			en = 18
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play115301106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 1.55

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_2 = arg_426_1:FormatText(StoryNameCfg[94].name)

				arg_426_1.leftNameTxt_.text = var_429_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_3 = arg_426_1:GetWordFromCfg(115301105)
				local var_429_4 = arg_426_1:FormatText(var_429_3.content)

				arg_426_1.text_.text = var_429_4

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 62
				local var_429_6 = utf8.len(var_429_4)
				local var_429_7 = var_429_5 <= 0 and var_429_1 or var_429_1 * (var_429_6 / var_429_5)

				if var_429_7 > 0 and var_429_1 < var_429_7 then
					arg_426_1.talkMaxDuration = var_429_7

					if var_429_7 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_7 + var_429_0
					end
				end

				arg_426_1.text_.text = var_429_4
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301105", "story_v_out_115301.awb") ~= 0 then
					local var_429_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301105", "story_v_out_115301.awb") / 1000

					if var_429_8 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_8 + var_429_0
					end

					if var_429_3.prefab_name ~= "" and arg_426_1.actors_[var_429_3.prefab_name] ~= nil then
						local var_429_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_3.prefab_name].transform, "story_v_out_115301", "115301105", "story_v_out_115301.awb")

						arg_426_1:RecordAudio("115301105", var_429_9)
						arg_426_1:RecordAudio("115301105", var_429_9)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_115301", "115301105", "story_v_out_115301.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_115301", "115301105", "story_v_out_115301.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_10 = math.max(var_429_1, arg_426_1.talkMaxDuration)

			if var_429_0 <= arg_426_1.time_ and arg_426_1.time_ < var_429_0 + var_429_10 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_0) / var_429_10

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_0 + var_429_10 and arg_426_1.time_ < var_429_0 + var_429_10 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play115301106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 115301106
		arg_430_1.duration_ = 16.5

		local var_430_0 = {
			ja = 14.9,
			ko = 16.5,
			zh = 16.433,
			en = 13.3
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play115301107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 1.625

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_2 = arg_430_1:FormatText(StoryNameCfg[94].name)

				arg_430_1.leftNameTxt_.text = var_433_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_3 = arg_430_1:GetWordFromCfg(115301106)
				local var_433_4 = arg_430_1:FormatText(var_433_3.content)

				arg_430_1.text_.text = var_433_4

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_5 = 65
				local var_433_6 = utf8.len(var_433_4)
				local var_433_7 = var_433_5 <= 0 and var_433_1 or var_433_1 * (var_433_6 / var_433_5)

				if var_433_7 > 0 and var_433_1 < var_433_7 then
					arg_430_1.talkMaxDuration = var_433_7

					if var_433_7 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_0
					end
				end

				arg_430_1.text_.text = var_433_4
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301106", "story_v_out_115301.awb") ~= 0 then
					local var_433_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301106", "story_v_out_115301.awb") / 1000

					if var_433_8 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_8 + var_433_0
					end

					if var_433_3.prefab_name ~= "" and arg_430_1.actors_[var_433_3.prefab_name] ~= nil then
						local var_433_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_3.prefab_name].transform, "story_v_out_115301", "115301106", "story_v_out_115301.awb")

						arg_430_1:RecordAudio("115301106", var_433_9)
						arg_430_1:RecordAudio("115301106", var_433_9)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_115301", "115301106", "story_v_out_115301.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_115301", "115301106", "story_v_out_115301.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_10 = math.max(var_433_1, arg_430_1.talkMaxDuration)

			if var_433_0 <= arg_430_1.time_ and arg_430_1.time_ < var_433_0 + var_433_10 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_0) / var_433_10

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_0 + var_433_10 and arg_430_1.time_ < var_433_0 + var_433_10 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play115301107 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 115301107
		arg_434_1.duration_ = 7.23

		local var_434_0 = {
			ja = 7.233,
			ko = 5.2,
			zh = 6.166,
			en = 5.733
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play115301108(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 0.625

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_2 = arg_434_1:FormatText(StoryNameCfg[94].name)

				arg_434_1.leftNameTxt_.text = var_437_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_3 = arg_434_1:GetWordFromCfg(115301107)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 25
				local var_437_6 = utf8.len(var_437_4)
				local var_437_7 = var_437_5 <= 0 and var_437_1 or var_437_1 * (var_437_6 / var_437_5)

				if var_437_7 > 0 and var_437_1 < var_437_7 then
					arg_434_1.talkMaxDuration = var_437_7

					if var_437_7 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301107", "story_v_out_115301.awb") ~= 0 then
					local var_437_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301107", "story_v_out_115301.awb") / 1000

					if var_437_8 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_8 + var_437_0
					end

					if var_437_3.prefab_name ~= "" and arg_434_1.actors_[var_437_3.prefab_name] ~= nil then
						local var_437_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_3.prefab_name].transform, "story_v_out_115301", "115301107", "story_v_out_115301.awb")

						arg_434_1:RecordAudio("115301107", var_437_9)
						arg_434_1:RecordAudio("115301107", var_437_9)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_115301", "115301107", "story_v_out_115301.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_115301", "115301107", "story_v_out_115301.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_10 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_10 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_10

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_10 and arg_434_1.time_ < var_437_0 + var_437_10 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play115301108 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 115301108
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play115301109(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1038"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.actorSpriteComps1038 == nil then
				arg_438_1.var_.actorSpriteComps1038 = var_441_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_2 = 0.2

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.actorSpriteComps1038 then
					for iter_441_0, iter_441_1 in pairs(arg_438_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_441_1 then
							if arg_438_1.isInRecall_ then
								local var_441_4 = Mathf.Lerp(iter_441_1.color.r, arg_438_1.hightColor2.r, var_441_3)
								local var_441_5 = Mathf.Lerp(iter_441_1.color.g, arg_438_1.hightColor2.g, var_441_3)
								local var_441_6 = Mathf.Lerp(iter_441_1.color.b, arg_438_1.hightColor2.b, var_441_3)

								iter_441_1.color = Color.New(var_441_4, var_441_5, var_441_6)
							else
								local var_441_7 = Mathf.Lerp(iter_441_1.color.r, 0.5, var_441_3)

								iter_441_1.color = Color.New(var_441_7, var_441_7, var_441_7)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.actorSpriteComps1038 then
				for iter_441_2, iter_441_3 in pairs(arg_438_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_441_3 then
						if arg_438_1.isInRecall_ then
							iter_441_3.color = arg_438_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_441_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_438_1.var_.actorSpriteComps1038 = nil
			end

			local var_441_8 = 0
			local var_441_9 = 0.975

			if var_441_8 < arg_438_1.time_ and arg_438_1.time_ <= var_441_8 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_10 = arg_438_1:GetWordFromCfg(115301108)
				local var_441_11 = arg_438_1:FormatText(var_441_10.content)

				arg_438_1.text_.text = var_441_11

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_12 = 39
				local var_441_13 = utf8.len(var_441_11)
				local var_441_14 = var_441_12 <= 0 and var_441_9 or var_441_9 * (var_441_13 / var_441_12)

				if var_441_14 > 0 and var_441_9 < var_441_14 then
					arg_438_1.talkMaxDuration = var_441_14

					if var_441_14 + var_441_8 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_14 + var_441_8
					end
				end

				arg_438_1.text_.text = var_441_11
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_15 = math.max(var_441_9, arg_438_1.talkMaxDuration)

			if var_441_8 <= arg_438_1.time_ and arg_438_1.time_ < var_441_8 + var_441_15 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_8) / var_441_15

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_8 + var_441_15 and arg_438_1.time_ < var_441_8 + var_441_15 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play115301109 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 115301109
		arg_442_1.duration_ = 6.4

		local var_442_0 = {
			ja = 6.4,
			ko = 4.633,
			zh = 6.133,
			en = 4.066
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play115301110(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1038"]
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.actorSpriteComps1038 == nil then
				arg_442_1.var_.actorSpriteComps1038 = var_445_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_2 = 0.2

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 and not isNil(var_445_0) then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2

				if arg_442_1.var_.actorSpriteComps1038 then
					for iter_445_0, iter_445_1 in pairs(arg_442_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_445_1 then
							if arg_442_1.isInRecall_ then
								local var_445_4 = Mathf.Lerp(iter_445_1.color.r, arg_442_1.hightColor1.r, var_445_3)
								local var_445_5 = Mathf.Lerp(iter_445_1.color.g, arg_442_1.hightColor1.g, var_445_3)
								local var_445_6 = Mathf.Lerp(iter_445_1.color.b, arg_442_1.hightColor1.b, var_445_3)

								iter_445_1.color = Color.New(var_445_4, var_445_5, var_445_6)
							else
								local var_445_7 = Mathf.Lerp(iter_445_1.color.r, 1, var_445_3)

								iter_445_1.color = Color.New(var_445_7, var_445_7, var_445_7)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.actorSpriteComps1038 then
				for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_445_3 then
						if arg_442_1.isInRecall_ then
							iter_445_3.color = arg_442_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_445_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_442_1.var_.actorSpriteComps1038 = nil
			end

			local var_445_8 = 0
			local var_445_9 = 0.525

			if var_445_8 < arg_442_1.time_ and arg_442_1.time_ <= var_445_8 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_10 = arg_442_1:FormatText(StoryNameCfg[94].name)

				arg_442_1.leftNameTxt_.text = var_445_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_11 = arg_442_1:GetWordFromCfg(115301109)
				local var_445_12 = arg_442_1:FormatText(var_445_11.content)

				arg_442_1.text_.text = var_445_12

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_13 = 21
				local var_445_14 = utf8.len(var_445_12)
				local var_445_15 = var_445_13 <= 0 and var_445_9 or var_445_9 * (var_445_14 / var_445_13)

				if var_445_15 > 0 and var_445_9 < var_445_15 then
					arg_442_1.talkMaxDuration = var_445_15

					if var_445_15 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_15 + var_445_8
					end
				end

				arg_442_1.text_.text = var_445_12
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301109", "story_v_out_115301.awb") ~= 0 then
					local var_445_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301109", "story_v_out_115301.awb") / 1000

					if var_445_16 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_16 + var_445_8
					end

					if var_445_11.prefab_name ~= "" and arg_442_1.actors_[var_445_11.prefab_name] ~= nil then
						local var_445_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_11.prefab_name].transform, "story_v_out_115301", "115301109", "story_v_out_115301.awb")

						arg_442_1:RecordAudio("115301109", var_445_17)
						arg_442_1:RecordAudio("115301109", var_445_17)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_115301", "115301109", "story_v_out_115301.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_115301", "115301109", "story_v_out_115301.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_18 = math.max(var_445_9, arg_442_1.talkMaxDuration)

			if var_445_8 <= arg_442_1.time_ and arg_442_1.time_ < var_445_8 + var_445_18 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_8) / var_445_18

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_8 + var_445_18 and arg_442_1.time_ < var_445_8 + var_445_18 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play115301110 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 115301110
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play115301111(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["1038"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 then
				local var_449_2 = var_449_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_449_2 then
					arg_446_1.var_.alphaOldValue1038 = var_449_2.alpha
					arg_446_1.var_.characterEffect1038 = var_449_2
				end

				arg_446_1.var_.alphaOldValue1038 = 1
			end

			local var_449_3 = 0.333333333333333

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_3 then
				local var_449_4 = (arg_446_1.time_ - var_449_1) / var_449_3
				local var_449_5 = Mathf.Lerp(arg_446_1.var_.alphaOldValue1038, 0, var_449_4)

				if arg_446_1.var_.characterEffect1038 then
					arg_446_1.var_.characterEffect1038.alpha = var_449_5
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_3 and arg_446_1.time_ < var_449_1 + var_449_3 + arg_449_0 and arg_446_1.var_.characterEffect1038 then
				arg_446_1.var_.characterEffect1038.alpha = 0
			end

			local var_449_6 = arg_446_1.actors_["10030"]
			local var_449_7 = 0

			if var_449_7 < arg_446_1.time_ and arg_446_1.time_ <= var_449_7 + arg_449_0 then
				local var_449_8 = var_449_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_449_8 then
					arg_446_1.var_.alphaOldValue10030 = var_449_8.alpha
					arg_446_1.var_.characterEffect10030 = var_449_8
				end

				arg_446_1.var_.alphaOldValue10030 = 1
			end

			local var_449_9 = 0.333333333333333

			if var_449_7 <= arg_446_1.time_ and arg_446_1.time_ < var_449_7 + var_449_9 then
				local var_449_10 = (arg_446_1.time_ - var_449_7) / var_449_9
				local var_449_11 = Mathf.Lerp(arg_446_1.var_.alphaOldValue10030, 0, var_449_10)

				if arg_446_1.var_.characterEffect10030 then
					arg_446_1.var_.characterEffect10030.alpha = var_449_11
				end
			end

			if arg_446_1.time_ >= var_449_7 + var_449_9 and arg_446_1.time_ < var_449_7 + var_449_9 + arg_449_0 and arg_446_1.var_.characterEffect10030 then
				arg_446_1.var_.characterEffect10030.alpha = 0
			end

			local var_449_12 = 0
			local var_449_13 = 1.175

			if var_449_12 < arg_446_1.time_ and arg_446_1.time_ <= var_449_12 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_14 = arg_446_1:GetWordFromCfg(115301110)
				local var_449_15 = arg_446_1:FormatText(var_449_14.content)

				arg_446_1.text_.text = var_449_15

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_16 = 47
				local var_449_17 = utf8.len(var_449_15)
				local var_449_18 = var_449_16 <= 0 and var_449_13 or var_449_13 * (var_449_17 / var_449_16)

				if var_449_18 > 0 and var_449_13 < var_449_18 then
					arg_446_1.talkMaxDuration = var_449_18

					if var_449_18 + var_449_12 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_18 + var_449_12
					end
				end

				arg_446_1.text_.text = var_449_15
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_19 = math.max(var_449_13, arg_446_1.talkMaxDuration)

			if var_449_12 <= arg_446_1.time_ and arg_446_1.time_ < var_449_12 + var_449_19 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_12) / var_449_19

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_12 + var_449_19 and arg_446_1.time_ < var_449_12 + var_449_19 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play115301111 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 115301111
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play115301112(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 0.975

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, false)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_2 = arg_450_1:GetWordFromCfg(115301111)
				local var_453_3 = arg_450_1:FormatText(var_453_2.content)

				arg_450_1.text_.text = var_453_3

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_4 = 39
				local var_453_5 = utf8.len(var_453_3)
				local var_453_6 = var_453_4 <= 0 and var_453_1 or var_453_1 * (var_453_5 / var_453_4)

				if var_453_6 > 0 and var_453_1 < var_453_6 then
					arg_450_1.talkMaxDuration = var_453_6

					if var_453_6 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_6 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_3
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_7 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 <= arg_450_1.time_ and arg_450_1.time_ < var_453_0 + var_453_7 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_0) / var_453_7

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_0 + var_453_7 and arg_450_1.time_ < var_453_0 + var_453_7 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play115301112 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 115301112
		arg_454_1.duration_ = 11.07

		local var_454_0 = {
			ja = 11.066,
			ko = 5.1,
			zh = 6,
			en = 4.666
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play115301113(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["10030"].transform
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 then
				arg_454_1.var_.moveOldPos10030 = var_457_0.localPosition
				var_457_0.localScale = Vector3.New(1, 1, 1)

				arg_454_1:CheckSpriteTmpPos("10030", 3)

				local var_457_2 = var_457_0.childCount

				for iter_457_0 = 0, var_457_2 - 1 do
					local var_457_3 = var_457_0:GetChild(iter_457_0)

					if var_457_3.name == "split_3" or not string.find(var_457_3.name, "split") then
						var_457_3.gameObject:SetActive(true)
					else
						var_457_3.gameObject:SetActive(false)
					end
				end
			end

			local var_457_4 = 0.001

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_4 then
				local var_457_5 = (arg_454_1.time_ - var_457_1) / var_457_4
				local var_457_6 = Vector3.New(0, -390, 150)

				var_457_0.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos10030, var_457_6, var_457_5)
			end

			if arg_454_1.time_ >= var_457_1 + var_457_4 and arg_454_1.time_ < var_457_1 + var_457_4 + arg_457_0 then
				var_457_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_457_7 = arg_454_1.actors_["10030"]
			local var_457_8 = 0

			if var_457_8 < arg_454_1.time_ and arg_454_1.time_ <= var_457_8 + arg_457_0 and not isNil(var_457_7) and arg_454_1.var_.actorSpriteComps10030 == nil then
				arg_454_1.var_.actorSpriteComps10030 = var_457_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_457_9 = 0.2

			if var_457_8 <= arg_454_1.time_ and arg_454_1.time_ < var_457_8 + var_457_9 and not isNil(var_457_7) then
				local var_457_10 = (arg_454_1.time_ - var_457_8) / var_457_9

				if arg_454_1.var_.actorSpriteComps10030 then
					for iter_457_1, iter_457_2 in pairs(arg_454_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_457_2 then
							if arg_454_1.isInRecall_ then
								local var_457_11 = Mathf.Lerp(iter_457_2.color.r, arg_454_1.hightColor1.r, var_457_10)
								local var_457_12 = Mathf.Lerp(iter_457_2.color.g, arg_454_1.hightColor1.g, var_457_10)
								local var_457_13 = Mathf.Lerp(iter_457_2.color.b, arg_454_1.hightColor1.b, var_457_10)

								iter_457_2.color = Color.New(var_457_11, var_457_12, var_457_13)
							else
								local var_457_14 = Mathf.Lerp(iter_457_2.color.r, 1, var_457_10)

								iter_457_2.color = Color.New(var_457_14, var_457_14, var_457_14)
							end
						end
					end
				end
			end

			if arg_454_1.time_ >= var_457_8 + var_457_9 and arg_454_1.time_ < var_457_8 + var_457_9 + arg_457_0 and not isNil(var_457_7) and arg_454_1.var_.actorSpriteComps10030 then
				for iter_457_3, iter_457_4 in pairs(arg_454_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_457_4 then
						if arg_454_1.isInRecall_ then
							iter_457_4.color = arg_454_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_457_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_454_1.var_.actorSpriteComps10030 = nil
			end

			local var_457_15 = arg_454_1.actors_["10030"]
			local var_457_16 = 0

			if var_457_16 < arg_454_1.time_ and arg_454_1.time_ <= var_457_16 + arg_457_0 then
				local var_457_17 = var_457_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_457_17 then
					arg_454_1.var_.alphaOldValue10030 = var_457_17.alpha
					arg_454_1.var_.characterEffect10030 = var_457_17
				end

				arg_454_1.var_.alphaOldValue10030 = 0
			end

			local var_457_18 = 0.333333333333333

			if var_457_16 <= arg_454_1.time_ and arg_454_1.time_ < var_457_16 + var_457_18 then
				local var_457_19 = (arg_454_1.time_ - var_457_16) / var_457_18
				local var_457_20 = Mathf.Lerp(arg_454_1.var_.alphaOldValue10030, 1, var_457_19)

				if arg_454_1.var_.characterEffect10030 then
					arg_454_1.var_.characterEffect10030.alpha = var_457_20
				end
			end

			if arg_454_1.time_ >= var_457_16 + var_457_18 and arg_454_1.time_ < var_457_16 + var_457_18 + arg_457_0 and arg_454_1.var_.characterEffect10030 then
				arg_454_1.var_.characterEffect10030.alpha = 1
			end

			local var_457_21 = 0
			local var_457_22 = 0.3

			if var_457_21 < arg_454_1.time_ and arg_454_1.time_ <= var_457_21 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_23 = arg_454_1:FormatText(StoryNameCfg[309].name)

				arg_454_1.leftNameTxt_.text = var_457_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_24 = arg_454_1:GetWordFromCfg(115301112)
				local var_457_25 = arg_454_1:FormatText(var_457_24.content)

				arg_454_1.text_.text = var_457_25

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_26 = 12
				local var_457_27 = utf8.len(var_457_25)
				local var_457_28 = var_457_26 <= 0 and var_457_22 or var_457_22 * (var_457_27 / var_457_26)

				if var_457_28 > 0 and var_457_22 < var_457_28 then
					arg_454_1.talkMaxDuration = var_457_28

					if var_457_28 + var_457_21 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_28 + var_457_21
					end
				end

				arg_454_1.text_.text = var_457_25
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301112", "story_v_out_115301.awb") ~= 0 then
					local var_457_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301112", "story_v_out_115301.awb") / 1000

					if var_457_29 + var_457_21 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_29 + var_457_21
					end

					if var_457_24.prefab_name ~= "" and arg_454_1.actors_[var_457_24.prefab_name] ~= nil then
						local var_457_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_24.prefab_name].transform, "story_v_out_115301", "115301112", "story_v_out_115301.awb")

						arg_454_1:RecordAudio("115301112", var_457_30)
						arg_454_1:RecordAudio("115301112", var_457_30)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_115301", "115301112", "story_v_out_115301.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_115301", "115301112", "story_v_out_115301.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_31 = math.max(var_457_22, arg_454_1.talkMaxDuration)

			if var_457_21 <= arg_454_1.time_ and arg_454_1.time_ < var_457_21 + var_457_31 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_21) / var_457_31

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_21 + var_457_31 and arg_454_1.time_ < var_457_21 + var_457_31 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play115301113 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 115301113
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play115301114(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["10030"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				local var_461_2 = var_461_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_461_2 then
					arg_458_1.var_.alphaOldValue10030 = var_461_2.alpha
					arg_458_1.var_.characterEffect10030 = var_461_2
				end

				arg_458_1.var_.alphaOldValue10030 = 1
			end

			local var_461_3 = 0.333333333333333

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_3 then
				local var_461_4 = (arg_458_1.time_ - var_461_1) / var_461_3
				local var_461_5 = Mathf.Lerp(arg_458_1.var_.alphaOldValue10030, 0, var_461_4)

				if arg_458_1.var_.characterEffect10030 then
					arg_458_1.var_.characterEffect10030.alpha = var_461_5
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_3 and arg_458_1.time_ < var_461_1 + var_461_3 + arg_461_0 and arg_458_1.var_.characterEffect10030 then
				arg_458_1.var_.characterEffect10030.alpha = 0
			end

			local var_461_6 = 0
			local var_461_7 = 0.725

			if var_461_6 < arg_458_1.time_ and arg_458_1.time_ <= var_461_6 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_8 = arg_458_1:GetWordFromCfg(115301113)
				local var_461_9 = arg_458_1:FormatText(var_461_8.content)

				arg_458_1.text_.text = var_461_9

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_10 = 29
				local var_461_11 = utf8.len(var_461_9)
				local var_461_12 = var_461_10 <= 0 and var_461_7 or var_461_7 * (var_461_11 / var_461_10)

				if var_461_12 > 0 and var_461_7 < var_461_12 then
					arg_458_1.talkMaxDuration = var_461_12

					if var_461_12 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_12 + var_461_6
					end
				end

				arg_458_1.text_.text = var_461_9
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_13 = math.max(var_461_7, arg_458_1.talkMaxDuration)

			if var_461_6 <= arg_458_1.time_ and arg_458_1.time_ < var_461_6 + var_461_13 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_6) / var_461_13

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_6 + var_461_13 and arg_458_1.time_ < var_461_6 + var_461_13 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play115301114 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 115301114
		arg_462_1.duration_ = 14.83

		local var_462_0 = {
			ja = 14.833,
			ko = 11.566,
			zh = 7.533,
			en = 10.2
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play115301115(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["10030"].transform
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.var_.moveOldPos10030 = var_465_0.localPosition
				var_465_0.localScale = Vector3.New(1, 1, 1)

				arg_462_1:CheckSpriteTmpPos("10030", 3)

				local var_465_2 = var_465_0.childCount

				for iter_465_0 = 0, var_465_2 - 1 do
					local var_465_3 = var_465_0:GetChild(iter_465_0)

					if var_465_3.name == "split_3" or not string.find(var_465_3.name, "split") then
						var_465_3.gameObject:SetActive(true)
					else
						var_465_3.gameObject:SetActive(false)
					end
				end
			end

			local var_465_4 = 0.001

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_4 then
				local var_465_5 = (arg_462_1.time_ - var_465_1) / var_465_4
				local var_465_6 = Vector3.New(0, -390, 150)

				var_465_0.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos10030, var_465_6, var_465_5)
			end

			if arg_462_1.time_ >= var_465_1 + var_465_4 and arg_462_1.time_ < var_465_1 + var_465_4 + arg_465_0 then
				var_465_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_465_7 = arg_462_1.actors_["10030"]
			local var_465_8 = 0

			if var_465_8 < arg_462_1.time_ and arg_462_1.time_ <= var_465_8 + arg_465_0 then
				local var_465_9 = var_465_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_465_9 then
					arg_462_1.var_.alphaOldValue10030 = var_465_9.alpha
					arg_462_1.var_.characterEffect10030 = var_465_9
				end

				arg_462_1.var_.alphaOldValue10030 = 0
			end

			local var_465_10 = 0.333333333333333

			if var_465_8 <= arg_462_1.time_ and arg_462_1.time_ < var_465_8 + var_465_10 then
				local var_465_11 = (arg_462_1.time_ - var_465_8) / var_465_10
				local var_465_12 = Mathf.Lerp(arg_462_1.var_.alphaOldValue10030, 1, var_465_11)

				if arg_462_1.var_.characterEffect10030 then
					arg_462_1.var_.characterEffect10030.alpha = var_465_12
				end
			end

			if arg_462_1.time_ >= var_465_8 + var_465_10 and arg_462_1.time_ < var_465_8 + var_465_10 + arg_465_0 and arg_462_1.var_.characterEffect10030 then
				arg_462_1.var_.characterEffect10030.alpha = 1
			end

			local var_465_13 = 0
			local var_465_14 = 0.825

			if var_465_13 < arg_462_1.time_ and arg_462_1.time_ <= var_465_13 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_15 = arg_462_1:FormatText(StoryNameCfg[309].name)

				arg_462_1.leftNameTxt_.text = var_465_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_16 = arg_462_1:GetWordFromCfg(115301114)
				local var_465_17 = arg_462_1:FormatText(var_465_16.content)

				arg_462_1.text_.text = var_465_17

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_18 = 33
				local var_465_19 = utf8.len(var_465_17)
				local var_465_20 = var_465_18 <= 0 and var_465_14 or var_465_14 * (var_465_19 / var_465_18)

				if var_465_20 > 0 and var_465_14 < var_465_20 then
					arg_462_1.talkMaxDuration = var_465_20

					if var_465_20 + var_465_13 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_20 + var_465_13
					end
				end

				arg_462_1.text_.text = var_465_17
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301114", "story_v_out_115301.awb") ~= 0 then
					local var_465_21 = manager.audio:GetVoiceLength("story_v_out_115301", "115301114", "story_v_out_115301.awb") / 1000

					if var_465_21 + var_465_13 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_21 + var_465_13
					end

					if var_465_16.prefab_name ~= "" and arg_462_1.actors_[var_465_16.prefab_name] ~= nil then
						local var_465_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_16.prefab_name].transform, "story_v_out_115301", "115301114", "story_v_out_115301.awb")

						arg_462_1:RecordAudio("115301114", var_465_22)
						arg_462_1:RecordAudio("115301114", var_465_22)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_115301", "115301114", "story_v_out_115301.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_115301", "115301114", "story_v_out_115301.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_23 = math.max(var_465_14, arg_462_1.talkMaxDuration)

			if var_465_13 <= arg_462_1.time_ and arg_462_1.time_ < var_465_13 + var_465_23 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_13) / var_465_23

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_13 + var_465_23 and arg_462_1.time_ < var_465_13 + var_465_23 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play115301115 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 115301115
		arg_466_1.duration_ = 12.23

		local var_466_0 = {
			ja = 6.066,
			ko = 9.933,
			zh = 8.966,
			en = 12.233
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play115301116(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0
			local var_469_1 = 1

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_2 = arg_466_1:FormatText(StoryNameCfg[309].name)

				arg_466_1.leftNameTxt_.text = var_469_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_3 = arg_466_1:GetWordFromCfg(115301115)
				local var_469_4 = arg_466_1:FormatText(var_469_3.content)

				arg_466_1.text_.text = var_469_4

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 40
				local var_469_6 = utf8.len(var_469_4)
				local var_469_7 = var_469_5 <= 0 and var_469_1 or var_469_1 * (var_469_6 / var_469_5)

				if var_469_7 > 0 and var_469_1 < var_469_7 then
					arg_466_1.talkMaxDuration = var_469_7

					if var_469_7 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_0
					end
				end

				arg_466_1.text_.text = var_469_4
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301115", "story_v_out_115301.awb") ~= 0 then
					local var_469_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301115", "story_v_out_115301.awb") / 1000

					if var_469_8 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_8 + var_469_0
					end

					if var_469_3.prefab_name ~= "" and arg_466_1.actors_[var_469_3.prefab_name] ~= nil then
						local var_469_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_3.prefab_name].transform, "story_v_out_115301", "115301115", "story_v_out_115301.awb")

						arg_466_1:RecordAudio("115301115", var_469_9)
						arg_466_1:RecordAudio("115301115", var_469_9)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_115301", "115301115", "story_v_out_115301.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_115301", "115301115", "story_v_out_115301.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_10 = math.max(var_469_1, arg_466_1.talkMaxDuration)

			if var_469_0 <= arg_466_1.time_ and arg_466_1.time_ < var_469_0 + var_469_10 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_0) / var_469_10

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_0 + var_469_10 and arg_466_1.time_ < var_469_0 + var_469_10 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play115301116 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 115301116
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play115301117(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["10030"]
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				local var_473_2 = var_473_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_473_2 then
					arg_470_1.var_.alphaOldValue10030 = var_473_2.alpha
					arg_470_1.var_.characterEffect10030 = var_473_2
				end

				arg_470_1.var_.alphaOldValue10030 = 1
			end

			local var_473_3 = 0.333333333333333

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_3 then
				local var_473_4 = (arg_470_1.time_ - var_473_1) / var_473_3
				local var_473_5 = Mathf.Lerp(arg_470_1.var_.alphaOldValue10030, 0, var_473_4)

				if arg_470_1.var_.characterEffect10030 then
					arg_470_1.var_.characterEffect10030.alpha = var_473_5
				end
			end

			if arg_470_1.time_ >= var_473_1 + var_473_3 and arg_470_1.time_ < var_473_1 + var_473_3 + arg_473_0 and arg_470_1.var_.characterEffect10030 then
				arg_470_1.var_.characterEffect10030.alpha = 0
			end

			local var_473_6 = 0
			local var_473_7 = 1.25

			if var_473_6 < arg_470_1.time_ and arg_470_1.time_ <= var_473_6 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_8 = arg_470_1:GetWordFromCfg(115301116)
				local var_473_9 = arg_470_1:FormatText(var_473_8.content)

				arg_470_1.text_.text = var_473_9

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_10 = 50
				local var_473_11 = utf8.len(var_473_9)
				local var_473_12 = var_473_10 <= 0 and var_473_7 or var_473_7 * (var_473_11 / var_473_10)

				if var_473_12 > 0 and var_473_7 < var_473_12 then
					arg_470_1.talkMaxDuration = var_473_12

					if var_473_12 + var_473_6 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_12 + var_473_6
					end
				end

				arg_470_1.text_.text = var_473_9
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_13 = math.max(var_473_7, arg_470_1.talkMaxDuration)

			if var_473_6 <= arg_470_1.time_ and arg_470_1.time_ < var_473_6 + var_473_13 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_6) / var_473_13

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_6 + var_473_13 and arg_470_1.time_ < var_473_6 + var_473_13 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play115301117 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 115301117
		arg_474_1.duration_ = 3.23

		local var_474_0 = {
			ja = 3.166,
			ko = 3.233,
			zh = 3.1,
			en = 3.033
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play115301118(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["10030"].transform
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.var_.moveOldPos10030 = var_477_0.localPosition
				var_477_0.localScale = Vector3.New(1, 1, 1)

				arg_474_1:CheckSpriteTmpPos("10030", 4)

				local var_477_2 = var_477_0.childCount

				for iter_477_0 = 0, var_477_2 - 1 do
					local var_477_3 = var_477_0:GetChild(iter_477_0)

					if var_477_3.name == "split_2" or not string.find(var_477_3.name, "split") then
						var_477_3.gameObject:SetActive(true)
					else
						var_477_3.gameObject:SetActive(false)
					end
				end
			end

			local var_477_4 = 0.001

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_4 then
				local var_477_5 = (arg_474_1.time_ - var_477_1) / var_477_4
				local var_477_6 = Vector3.New(390, -390, 150)

				var_477_0.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos10030, var_477_6, var_477_5)
			end

			if arg_474_1.time_ >= var_477_1 + var_477_4 and arg_474_1.time_ < var_477_1 + var_477_4 + arg_477_0 then
				var_477_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_477_7 = arg_474_1.actors_["10030"]
			local var_477_8 = 0

			if var_477_8 < arg_474_1.time_ and arg_474_1.time_ <= var_477_8 + arg_477_0 then
				local var_477_9 = var_477_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_477_9 then
					arg_474_1.var_.alphaOldValue10030 = var_477_9.alpha
					arg_474_1.var_.characterEffect10030 = var_477_9
				end

				arg_474_1.var_.alphaOldValue10030 = 0
			end

			local var_477_10 = 0.333333333333333

			if var_477_8 <= arg_474_1.time_ and arg_474_1.time_ < var_477_8 + var_477_10 then
				local var_477_11 = (arg_474_1.time_ - var_477_8) / var_477_10
				local var_477_12 = Mathf.Lerp(arg_474_1.var_.alphaOldValue10030, 1, var_477_11)

				if arg_474_1.var_.characterEffect10030 then
					arg_474_1.var_.characterEffect10030.alpha = var_477_12
				end
			end

			if arg_474_1.time_ >= var_477_8 + var_477_10 and arg_474_1.time_ < var_477_8 + var_477_10 + arg_477_0 and arg_474_1.var_.characterEffect10030 then
				arg_474_1.var_.characterEffect10030.alpha = 1
			end

			local var_477_13 = 0
			local var_477_14 = 0.275

			if var_477_13 < arg_474_1.time_ and arg_474_1.time_ <= var_477_13 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_15 = arg_474_1:FormatText(StoryNameCfg[309].name)

				arg_474_1.leftNameTxt_.text = var_477_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_16 = arg_474_1:GetWordFromCfg(115301117)
				local var_477_17 = arg_474_1:FormatText(var_477_16.content)

				arg_474_1.text_.text = var_477_17

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_18 = 11
				local var_477_19 = utf8.len(var_477_17)
				local var_477_20 = var_477_18 <= 0 and var_477_14 or var_477_14 * (var_477_19 / var_477_18)

				if var_477_20 > 0 and var_477_14 < var_477_20 then
					arg_474_1.talkMaxDuration = var_477_20

					if var_477_20 + var_477_13 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_20 + var_477_13
					end
				end

				arg_474_1.text_.text = var_477_17
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301117", "story_v_out_115301.awb") ~= 0 then
					local var_477_21 = manager.audio:GetVoiceLength("story_v_out_115301", "115301117", "story_v_out_115301.awb") / 1000

					if var_477_21 + var_477_13 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_21 + var_477_13
					end

					if var_477_16.prefab_name ~= "" and arg_474_1.actors_[var_477_16.prefab_name] ~= nil then
						local var_477_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_16.prefab_name].transform, "story_v_out_115301", "115301117", "story_v_out_115301.awb")

						arg_474_1:RecordAudio("115301117", var_477_22)
						arg_474_1:RecordAudio("115301117", var_477_22)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_115301", "115301117", "story_v_out_115301.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_115301", "115301117", "story_v_out_115301.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_23 = math.max(var_477_14, arg_474_1.talkMaxDuration)

			if var_477_13 <= arg_474_1.time_ and arg_474_1.time_ < var_477_13 + var_477_23 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_13) / var_477_23

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_13 + var_477_23 and arg_474_1.time_ < var_477_13 + var_477_23 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play115301118 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 115301118
		arg_478_1.duration_ = 2.2

		local var_478_0 = {
			ja = 2.133,
			ko = 1.333,
			zh = 2.2,
			en = 1.4
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play115301119(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["1038"].transform
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 then
				arg_478_1.var_.moveOldPos1038 = var_481_0.localPosition
				var_481_0.localScale = Vector3.New(1, 1, 1)

				arg_478_1:CheckSpriteTmpPos("1038", 2)

				local var_481_2 = var_481_0.childCount

				for iter_481_0 = 0, var_481_2 - 1 do
					local var_481_3 = var_481_0:GetChild(iter_481_0)

					if var_481_3.name == "split_1" or not string.find(var_481_3.name, "split") then
						var_481_3.gameObject:SetActive(true)
					else
						var_481_3.gameObject:SetActive(false)
					end
				end
			end

			local var_481_4 = 0.001

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_4 then
				local var_481_5 = (arg_478_1.time_ - var_481_1) / var_481_4
				local var_481_6 = Vector3.New(-390, -400, 0)

				var_481_0.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1038, var_481_6, var_481_5)
			end

			if arg_478_1.time_ >= var_481_1 + var_481_4 and arg_478_1.time_ < var_481_1 + var_481_4 + arg_481_0 then
				var_481_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_481_7 = arg_478_1.actors_["10030"]
			local var_481_8 = 0

			if var_481_8 < arg_478_1.time_ and arg_478_1.time_ <= var_481_8 + arg_481_0 and not isNil(var_481_7) and arg_478_1.var_.actorSpriteComps10030 == nil then
				arg_478_1.var_.actorSpriteComps10030 = var_481_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_9 = 0.2

			if var_481_8 <= arg_478_1.time_ and arg_478_1.time_ < var_481_8 + var_481_9 and not isNil(var_481_7) then
				local var_481_10 = (arg_478_1.time_ - var_481_8) / var_481_9

				if arg_478_1.var_.actorSpriteComps10030 then
					for iter_481_1, iter_481_2 in pairs(arg_478_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_481_2 then
							if arg_478_1.isInRecall_ then
								local var_481_11 = Mathf.Lerp(iter_481_2.color.r, arg_478_1.hightColor2.r, var_481_10)
								local var_481_12 = Mathf.Lerp(iter_481_2.color.g, arg_478_1.hightColor2.g, var_481_10)
								local var_481_13 = Mathf.Lerp(iter_481_2.color.b, arg_478_1.hightColor2.b, var_481_10)

								iter_481_2.color = Color.New(var_481_11, var_481_12, var_481_13)
							else
								local var_481_14 = Mathf.Lerp(iter_481_2.color.r, 0.5, var_481_10)

								iter_481_2.color = Color.New(var_481_14, var_481_14, var_481_14)
							end
						end
					end
				end
			end

			if arg_478_1.time_ >= var_481_8 + var_481_9 and arg_478_1.time_ < var_481_8 + var_481_9 + arg_481_0 and not isNil(var_481_7) and arg_478_1.var_.actorSpriteComps10030 then
				for iter_481_3, iter_481_4 in pairs(arg_478_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_481_4 then
						if arg_478_1.isInRecall_ then
							iter_481_4.color = arg_478_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_481_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_478_1.var_.actorSpriteComps10030 = nil
			end

			local var_481_15 = arg_478_1.actors_["1038"]
			local var_481_16 = 0

			if var_481_16 < arg_478_1.time_ and arg_478_1.time_ <= var_481_16 + arg_481_0 then
				local var_481_17 = var_481_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_481_17 then
					arg_478_1.var_.alphaOldValue1038 = var_481_17.alpha
					arg_478_1.var_.characterEffect1038 = var_481_17
				end

				arg_478_1.var_.alphaOldValue1038 = 0
			end

			local var_481_18 = 0.333333333333333

			if var_481_16 <= arg_478_1.time_ and arg_478_1.time_ < var_481_16 + var_481_18 then
				local var_481_19 = (arg_478_1.time_ - var_481_16) / var_481_18
				local var_481_20 = Mathf.Lerp(arg_478_1.var_.alphaOldValue1038, 1, var_481_19)

				if arg_478_1.var_.characterEffect1038 then
					arg_478_1.var_.characterEffect1038.alpha = var_481_20
				end
			end

			if arg_478_1.time_ >= var_481_16 + var_481_18 and arg_478_1.time_ < var_481_16 + var_481_18 + arg_481_0 and arg_478_1.var_.characterEffect1038 then
				arg_478_1.var_.characterEffect1038.alpha = 1
			end

			local var_481_21 = arg_478_1.actors_["1038"]
			local var_481_22 = 0

			if var_481_22 < arg_478_1.time_ and arg_478_1.time_ <= var_481_22 + arg_481_0 and not isNil(var_481_21) and arg_478_1.var_.actorSpriteComps1038 == nil then
				arg_478_1.var_.actorSpriteComps1038 = var_481_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_23 = 0.2

			if var_481_22 <= arg_478_1.time_ and arg_478_1.time_ < var_481_22 + var_481_23 and not isNil(var_481_21) then
				local var_481_24 = (arg_478_1.time_ - var_481_22) / var_481_23

				if arg_478_1.var_.actorSpriteComps1038 then
					for iter_481_5, iter_481_6 in pairs(arg_478_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_481_6 then
							if arg_478_1.isInRecall_ then
								local var_481_25 = Mathf.Lerp(iter_481_6.color.r, arg_478_1.hightColor1.r, var_481_24)
								local var_481_26 = Mathf.Lerp(iter_481_6.color.g, arg_478_1.hightColor1.g, var_481_24)
								local var_481_27 = Mathf.Lerp(iter_481_6.color.b, arg_478_1.hightColor1.b, var_481_24)

								iter_481_6.color = Color.New(var_481_25, var_481_26, var_481_27)
							else
								local var_481_28 = Mathf.Lerp(iter_481_6.color.r, 1, var_481_24)

								iter_481_6.color = Color.New(var_481_28, var_481_28, var_481_28)
							end
						end
					end
				end
			end

			if arg_478_1.time_ >= var_481_22 + var_481_23 and arg_478_1.time_ < var_481_22 + var_481_23 + arg_481_0 and not isNil(var_481_21) and arg_478_1.var_.actorSpriteComps1038 then
				for iter_481_7, iter_481_8 in pairs(arg_478_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_481_8 then
						if arg_478_1.isInRecall_ then
							iter_481_8.color = arg_478_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_481_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_478_1.var_.actorSpriteComps1038 = nil
			end

			local var_481_29 = 0
			local var_481_30 = 0.075

			if var_481_29 < arg_478_1.time_ and arg_478_1.time_ <= var_481_29 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_31 = arg_478_1:FormatText(StoryNameCfg[94].name)

				arg_478_1.leftNameTxt_.text = var_481_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_32 = arg_478_1:GetWordFromCfg(115301118)
				local var_481_33 = arg_478_1:FormatText(var_481_32.content)

				arg_478_1.text_.text = var_481_33

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_34 = 3
				local var_481_35 = utf8.len(var_481_33)
				local var_481_36 = var_481_34 <= 0 and var_481_30 or var_481_30 * (var_481_35 / var_481_34)

				if var_481_36 > 0 and var_481_30 < var_481_36 then
					arg_478_1.talkMaxDuration = var_481_36

					if var_481_36 + var_481_29 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_36 + var_481_29
					end
				end

				arg_478_1.text_.text = var_481_33
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301118", "story_v_out_115301.awb") ~= 0 then
					local var_481_37 = manager.audio:GetVoiceLength("story_v_out_115301", "115301118", "story_v_out_115301.awb") / 1000

					if var_481_37 + var_481_29 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_37 + var_481_29
					end

					if var_481_32.prefab_name ~= "" and arg_478_1.actors_[var_481_32.prefab_name] ~= nil then
						local var_481_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_32.prefab_name].transform, "story_v_out_115301", "115301118", "story_v_out_115301.awb")

						arg_478_1:RecordAudio("115301118", var_481_38)
						arg_478_1:RecordAudio("115301118", var_481_38)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_115301", "115301118", "story_v_out_115301.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_115301", "115301118", "story_v_out_115301.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_39 = math.max(var_481_30, arg_478_1.talkMaxDuration)

			if var_481_29 <= arg_478_1.time_ and arg_478_1.time_ < var_481_29 + var_481_39 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_29) / var_481_39

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_29 + var_481_39 and arg_478_1.time_ < var_481_29 + var_481_39 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play115301119 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 115301119
		arg_482_1.duration_ = 4

		local var_482_0 = {
			ja = 2.866,
			ko = 3.866,
			zh = 2.933,
			en = 4
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play115301120(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["10030"]
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.actorSpriteComps10030 == nil then
				arg_482_1.var_.actorSpriteComps10030 = var_485_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_485_2 = 0.2

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 and not isNil(var_485_0) then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2

				if arg_482_1.var_.actorSpriteComps10030 then
					for iter_485_0, iter_485_1 in pairs(arg_482_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_485_1 then
							if arg_482_1.isInRecall_ then
								local var_485_4 = Mathf.Lerp(iter_485_1.color.r, arg_482_1.hightColor1.r, var_485_3)
								local var_485_5 = Mathf.Lerp(iter_485_1.color.g, arg_482_1.hightColor1.g, var_485_3)
								local var_485_6 = Mathf.Lerp(iter_485_1.color.b, arg_482_1.hightColor1.b, var_485_3)

								iter_485_1.color = Color.New(var_485_4, var_485_5, var_485_6)
							else
								local var_485_7 = Mathf.Lerp(iter_485_1.color.r, 1, var_485_3)

								iter_485_1.color = Color.New(var_485_7, var_485_7, var_485_7)
							end
						end
					end
				end
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.actorSpriteComps10030 then
				for iter_485_2, iter_485_3 in pairs(arg_482_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_485_3 then
						if arg_482_1.isInRecall_ then
							iter_485_3.color = arg_482_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_485_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_482_1.var_.actorSpriteComps10030 = nil
			end

			local var_485_8 = arg_482_1.actors_["1038"]
			local var_485_9 = 0

			if var_485_9 < arg_482_1.time_ and arg_482_1.time_ <= var_485_9 + arg_485_0 and not isNil(var_485_8) and arg_482_1.var_.actorSpriteComps1038 == nil then
				arg_482_1.var_.actorSpriteComps1038 = var_485_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_485_10 = 0.2

			if var_485_9 <= arg_482_1.time_ and arg_482_1.time_ < var_485_9 + var_485_10 and not isNil(var_485_8) then
				local var_485_11 = (arg_482_1.time_ - var_485_9) / var_485_10

				if arg_482_1.var_.actorSpriteComps1038 then
					for iter_485_4, iter_485_5 in pairs(arg_482_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_485_5 then
							if arg_482_1.isInRecall_ then
								local var_485_12 = Mathf.Lerp(iter_485_5.color.r, arg_482_1.hightColor2.r, var_485_11)
								local var_485_13 = Mathf.Lerp(iter_485_5.color.g, arg_482_1.hightColor2.g, var_485_11)
								local var_485_14 = Mathf.Lerp(iter_485_5.color.b, arg_482_1.hightColor2.b, var_485_11)

								iter_485_5.color = Color.New(var_485_12, var_485_13, var_485_14)
							else
								local var_485_15 = Mathf.Lerp(iter_485_5.color.r, 0.5, var_485_11)

								iter_485_5.color = Color.New(var_485_15, var_485_15, var_485_15)
							end
						end
					end
				end
			end

			if arg_482_1.time_ >= var_485_9 + var_485_10 and arg_482_1.time_ < var_485_9 + var_485_10 + arg_485_0 and not isNil(var_485_8) and arg_482_1.var_.actorSpriteComps1038 then
				for iter_485_6, iter_485_7 in pairs(arg_482_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_485_7 then
						if arg_482_1.isInRecall_ then
							iter_485_7.color = arg_482_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_485_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_482_1.var_.actorSpriteComps1038 = nil
			end

			local var_485_16 = 0
			local var_485_17 = 0.25

			if var_485_16 < arg_482_1.time_ and arg_482_1.time_ <= var_485_16 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_18 = arg_482_1:FormatText(StoryNameCfg[309].name)

				arg_482_1.leftNameTxt_.text = var_485_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_19 = arg_482_1:GetWordFromCfg(115301119)
				local var_485_20 = arg_482_1:FormatText(var_485_19.content)

				arg_482_1.text_.text = var_485_20

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_21 = 10
				local var_485_22 = utf8.len(var_485_20)
				local var_485_23 = var_485_21 <= 0 and var_485_17 or var_485_17 * (var_485_22 / var_485_21)

				if var_485_23 > 0 and var_485_17 < var_485_23 then
					arg_482_1.talkMaxDuration = var_485_23

					if var_485_23 + var_485_16 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_23 + var_485_16
					end
				end

				arg_482_1.text_.text = var_485_20
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301119", "story_v_out_115301.awb") ~= 0 then
					local var_485_24 = manager.audio:GetVoiceLength("story_v_out_115301", "115301119", "story_v_out_115301.awb") / 1000

					if var_485_24 + var_485_16 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_24 + var_485_16
					end

					if var_485_19.prefab_name ~= "" and arg_482_1.actors_[var_485_19.prefab_name] ~= nil then
						local var_485_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_19.prefab_name].transform, "story_v_out_115301", "115301119", "story_v_out_115301.awb")

						arg_482_1:RecordAudio("115301119", var_485_25)
						arg_482_1:RecordAudio("115301119", var_485_25)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_115301", "115301119", "story_v_out_115301.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_115301", "115301119", "story_v_out_115301.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_26 = math.max(var_485_17, arg_482_1.talkMaxDuration)

			if var_485_16 <= arg_482_1.time_ and arg_482_1.time_ < var_485_16 + var_485_26 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_16) / var_485_26

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_16 + var_485_26 and arg_482_1.time_ < var_485_16 + var_485_26 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play115301120 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 115301120
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play115301121(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["10030"]
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.actorSpriteComps10030 == nil then
				arg_486_1.var_.actorSpriteComps10030 = var_489_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_489_2 = 0.2

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 and not isNil(var_489_0) then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2

				if arg_486_1.var_.actorSpriteComps10030 then
					for iter_489_0, iter_489_1 in pairs(arg_486_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_489_1 then
							if arg_486_1.isInRecall_ then
								local var_489_4 = Mathf.Lerp(iter_489_1.color.r, arg_486_1.hightColor2.r, var_489_3)
								local var_489_5 = Mathf.Lerp(iter_489_1.color.g, arg_486_1.hightColor2.g, var_489_3)
								local var_489_6 = Mathf.Lerp(iter_489_1.color.b, arg_486_1.hightColor2.b, var_489_3)

								iter_489_1.color = Color.New(var_489_4, var_489_5, var_489_6)
							else
								local var_489_7 = Mathf.Lerp(iter_489_1.color.r, 0.5, var_489_3)

								iter_489_1.color = Color.New(var_489_7, var_489_7, var_489_7)
							end
						end
					end
				end
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.actorSpriteComps10030 then
				for iter_489_2, iter_489_3 in pairs(arg_486_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_489_3 then
						if arg_486_1.isInRecall_ then
							iter_489_3.color = arg_486_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_489_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_486_1.var_.actorSpriteComps10030 = nil
			end

			local var_489_8 = arg_486_1.actors_["1038"]
			local var_489_9 = 0

			if var_489_9 < arg_486_1.time_ and arg_486_1.time_ <= var_489_9 + arg_489_0 and not isNil(var_489_8) and arg_486_1.var_.actorSpriteComps1038 == nil then
				arg_486_1.var_.actorSpriteComps1038 = var_489_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_489_10 = 0.2

			if var_489_9 <= arg_486_1.time_ and arg_486_1.time_ < var_489_9 + var_489_10 and not isNil(var_489_8) then
				local var_489_11 = (arg_486_1.time_ - var_489_9) / var_489_10

				if arg_486_1.var_.actorSpriteComps1038 then
					for iter_489_4, iter_489_5 in pairs(arg_486_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_489_5 then
							if arg_486_1.isInRecall_ then
								local var_489_12 = Mathf.Lerp(iter_489_5.color.r, arg_486_1.hightColor2.r, var_489_11)
								local var_489_13 = Mathf.Lerp(iter_489_5.color.g, arg_486_1.hightColor2.g, var_489_11)
								local var_489_14 = Mathf.Lerp(iter_489_5.color.b, arg_486_1.hightColor2.b, var_489_11)

								iter_489_5.color = Color.New(var_489_12, var_489_13, var_489_14)
							else
								local var_489_15 = Mathf.Lerp(iter_489_5.color.r, 0.5, var_489_11)

								iter_489_5.color = Color.New(var_489_15, var_489_15, var_489_15)
							end
						end
					end
				end
			end

			if arg_486_1.time_ >= var_489_9 + var_489_10 and arg_486_1.time_ < var_489_9 + var_489_10 + arg_489_0 and not isNil(var_489_8) and arg_486_1.var_.actorSpriteComps1038 then
				for iter_489_6, iter_489_7 in pairs(arg_486_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_489_7 then
						if arg_486_1.isInRecall_ then
							iter_489_7.color = arg_486_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_489_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_486_1.var_.actorSpriteComps1038 = nil
			end

			local var_489_16 = 0
			local var_489_17 = 0.65

			if var_489_16 < arg_486_1.time_ and arg_486_1.time_ <= var_489_16 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_18 = arg_486_1:GetWordFromCfg(115301120)
				local var_489_19 = arg_486_1:FormatText(var_489_18.content)

				arg_486_1.text_.text = var_489_19

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_20 = 26
				local var_489_21 = utf8.len(var_489_19)
				local var_489_22 = var_489_20 <= 0 and var_489_17 or var_489_17 * (var_489_21 / var_489_20)

				if var_489_22 > 0 and var_489_17 < var_489_22 then
					arg_486_1.talkMaxDuration = var_489_22

					if var_489_22 + var_489_16 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_22 + var_489_16
					end
				end

				arg_486_1.text_.text = var_489_19
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_23 = math.max(var_489_17, arg_486_1.talkMaxDuration)

			if var_489_16 <= arg_486_1.time_ and arg_486_1.time_ < var_489_16 + var_489_23 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_16) / var_489_23

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_16 + var_489_23 and arg_486_1.time_ < var_489_16 + var_489_23 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play115301121 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 115301121
		arg_490_1.duration_ = 8.9

		local var_490_0 = {
			ja = 8.9,
			ko = 7.166,
			zh = 7.566,
			en = 5.766
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play115301122(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["1038"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.actorSpriteComps1038 == nil then
				arg_490_1.var_.actorSpriteComps1038 = var_493_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_493_2 = 0.2

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.actorSpriteComps1038 then
					for iter_493_0, iter_493_1 in pairs(arg_490_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_493_1 then
							if arg_490_1.isInRecall_ then
								local var_493_4 = Mathf.Lerp(iter_493_1.color.r, arg_490_1.hightColor1.r, var_493_3)
								local var_493_5 = Mathf.Lerp(iter_493_1.color.g, arg_490_1.hightColor1.g, var_493_3)
								local var_493_6 = Mathf.Lerp(iter_493_1.color.b, arg_490_1.hightColor1.b, var_493_3)

								iter_493_1.color = Color.New(var_493_4, var_493_5, var_493_6)
							else
								local var_493_7 = Mathf.Lerp(iter_493_1.color.r, 1, var_493_3)

								iter_493_1.color = Color.New(var_493_7, var_493_7, var_493_7)
							end
						end
					end
				end
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.actorSpriteComps1038 then
				for iter_493_2, iter_493_3 in pairs(arg_490_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_493_3 then
						if arg_490_1.isInRecall_ then
							iter_493_3.color = arg_490_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_493_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_490_1.var_.actorSpriteComps1038 = nil
			end

			local var_493_8 = arg_490_1.actors_["1038"].transform
			local var_493_9 = 0

			if var_493_9 < arg_490_1.time_ and arg_490_1.time_ <= var_493_9 + arg_493_0 then
				arg_490_1.var_.moveOldPos1038 = var_493_8.localPosition
				var_493_8.localScale = Vector3.New(1, 1, 1)

				arg_490_1:CheckSpriteTmpPos("1038", 2)

				local var_493_10 = var_493_8.childCount

				for iter_493_4 = 0, var_493_10 - 1 do
					local var_493_11 = var_493_8:GetChild(iter_493_4)

					if var_493_11.name == "split_9" or not string.find(var_493_11.name, "split") then
						var_493_11.gameObject:SetActive(true)
					else
						var_493_11.gameObject:SetActive(false)
					end
				end
			end

			local var_493_12 = 0.001

			if var_493_9 <= arg_490_1.time_ and arg_490_1.time_ < var_493_9 + var_493_12 then
				local var_493_13 = (arg_490_1.time_ - var_493_9) / var_493_12
				local var_493_14 = Vector3.New(-390, -400, 0)

				var_493_8.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1038, var_493_14, var_493_13)
			end

			if arg_490_1.time_ >= var_493_9 + var_493_12 and arg_490_1.time_ < var_493_9 + var_493_12 + arg_493_0 then
				var_493_8.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_493_15 = arg_490_1.actors_["1038"]
			local var_493_16 = 0

			if var_493_16 < arg_490_1.time_ and arg_490_1.time_ <= var_493_16 + arg_493_0 then
				local var_493_17 = var_493_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_493_17 then
					arg_490_1.var_.alphaOldValue1038 = var_493_17.alpha
					arg_490_1.var_.characterEffect1038 = var_493_17
				end

				arg_490_1.var_.alphaOldValue1038 = 0
			end

			local var_493_18 = 0.0166666666666667

			if var_493_16 <= arg_490_1.time_ and arg_490_1.time_ < var_493_16 + var_493_18 then
				local var_493_19 = (arg_490_1.time_ - var_493_16) / var_493_18
				local var_493_20 = Mathf.Lerp(arg_490_1.var_.alphaOldValue1038, 1, var_493_19)

				if arg_490_1.var_.characterEffect1038 then
					arg_490_1.var_.characterEffect1038.alpha = var_493_20
				end
			end

			if arg_490_1.time_ >= var_493_16 + var_493_18 and arg_490_1.time_ < var_493_16 + var_493_18 + arg_493_0 and arg_490_1.var_.characterEffect1038 then
				arg_490_1.var_.characterEffect1038.alpha = 1
			end

			local var_493_21 = 0
			local var_493_22 = 0.7

			if var_493_21 < arg_490_1.time_ and arg_490_1.time_ <= var_493_21 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_23 = arg_490_1:FormatText(StoryNameCfg[94].name)

				arg_490_1.leftNameTxt_.text = var_493_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_24 = arg_490_1:GetWordFromCfg(115301121)
				local var_493_25 = arg_490_1:FormatText(var_493_24.content)

				arg_490_1.text_.text = var_493_25

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_26 = 28
				local var_493_27 = utf8.len(var_493_25)
				local var_493_28 = var_493_26 <= 0 and var_493_22 or var_493_22 * (var_493_27 / var_493_26)

				if var_493_28 > 0 and var_493_22 < var_493_28 then
					arg_490_1.talkMaxDuration = var_493_28

					if var_493_28 + var_493_21 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_28 + var_493_21
					end
				end

				arg_490_1.text_.text = var_493_25
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301121", "story_v_out_115301.awb") ~= 0 then
					local var_493_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301121", "story_v_out_115301.awb") / 1000

					if var_493_29 + var_493_21 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_29 + var_493_21
					end

					if var_493_24.prefab_name ~= "" and arg_490_1.actors_[var_493_24.prefab_name] ~= nil then
						local var_493_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_24.prefab_name].transform, "story_v_out_115301", "115301121", "story_v_out_115301.awb")

						arg_490_1:RecordAudio("115301121", var_493_30)
						arg_490_1:RecordAudio("115301121", var_493_30)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_115301", "115301121", "story_v_out_115301.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_115301", "115301121", "story_v_out_115301.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_31 = math.max(var_493_22, arg_490_1.talkMaxDuration)

			if var_493_21 <= arg_490_1.time_ and arg_490_1.time_ < var_493_21 + var_493_31 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_21) / var_493_31

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_21 + var_493_31 and arg_490_1.time_ < var_493_21 + var_493_31 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play115301122 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 115301122
		arg_494_1.duration_ = 4.27

		local var_494_0 = {
			ja = 4.266,
			ko = 3.466,
			zh = 3.3,
			en = 3.433
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play115301123(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1038"]
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.actorSpriteComps1038 == nil then
				arg_494_1.var_.actorSpriteComps1038 = var_497_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_497_2 = 0.2

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 and not isNil(var_497_0) then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2

				if arg_494_1.var_.actorSpriteComps1038 then
					for iter_497_0, iter_497_1 in pairs(arg_494_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_497_1 then
							if arg_494_1.isInRecall_ then
								local var_497_4 = Mathf.Lerp(iter_497_1.color.r, arg_494_1.hightColor2.r, var_497_3)
								local var_497_5 = Mathf.Lerp(iter_497_1.color.g, arg_494_1.hightColor2.g, var_497_3)
								local var_497_6 = Mathf.Lerp(iter_497_1.color.b, arg_494_1.hightColor2.b, var_497_3)

								iter_497_1.color = Color.New(var_497_4, var_497_5, var_497_6)
							else
								local var_497_7 = Mathf.Lerp(iter_497_1.color.r, 0.5, var_497_3)

								iter_497_1.color = Color.New(var_497_7, var_497_7, var_497_7)
							end
						end
					end
				end
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.actorSpriteComps1038 then
				for iter_497_2, iter_497_3 in pairs(arg_494_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_497_3 then
						if arg_494_1.isInRecall_ then
							iter_497_3.color = arg_494_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_497_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_494_1.var_.actorSpriteComps1038 = nil
			end

			local var_497_8 = arg_494_1.actors_["10030"]
			local var_497_9 = 0

			if var_497_9 < arg_494_1.time_ and arg_494_1.time_ <= var_497_9 + arg_497_0 and not isNil(var_497_8) and arg_494_1.var_.actorSpriteComps10030 == nil then
				arg_494_1.var_.actorSpriteComps10030 = var_497_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_497_10 = 0.2

			if var_497_9 <= arg_494_1.time_ and arg_494_1.time_ < var_497_9 + var_497_10 and not isNil(var_497_8) then
				local var_497_11 = (arg_494_1.time_ - var_497_9) / var_497_10

				if arg_494_1.var_.actorSpriteComps10030 then
					for iter_497_4, iter_497_5 in pairs(arg_494_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_497_5 then
							if arg_494_1.isInRecall_ then
								local var_497_12 = Mathf.Lerp(iter_497_5.color.r, arg_494_1.hightColor1.r, var_497_11)
								local var_497_13 = Mathf.Lerp(iter_497_5.color.g, arg_494_1.hightColor1.g, var_497_11)
								local var_497_14 = Mathf.Lerp(iter_497_5.color.b, arg_494_1.hightColor1.b, var_497_11)

								iter_497_5.color = Color.New(var_497_12, var_497_13, var_497_14)
							else
								local var_497_15 = Mathf.Lerp(iter_497_5.color.r, 1, var_497_11)

								iter_497_5.color = Color.New(var_497_15, var_497_15, var_497_15)
							end
						end
					end
				end
			end

			if arg_494_1.time_ >= var_497_9 + var_497_10 and arg_494_1.time_ < var_497_9 + var_497_10 + arg_497_0 and not isNil(var_497_8) and arg_494_1.var_.actorSpriteComps10030 then
				for iter_497_6, iter_497_7 in pairs(arg_494_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_497_7 then
						if arg_494_1.isInRecall_ then
							iter_497_7.color = arg_494_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_497_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_494_1.var_.actorSpriteComps10030 = nil
			end

			local var_497_16 = 0
			local var_497_17 = 0.3

			if var_497_16 < arg_494_1.time_ and arg_494_1.time_ <= var_497_16 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_18 = arg_494_1:FormatText(StoryNameCfg[309].name)

				arg_494_1.leftNameTxt_.text = var_497_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_19 = arg_494_1:GetWordFromCfg(115301122)
				local var_497_20 = arg_494_1:FormatText(var_497_19.content)

				arg_494_1.text_.text = var_497_20

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_21 = 12
				local var_497_22 = utf8.len(var_497_20)
				local var_497_23 = var_497_21 <= 0 and var_497_17 or var_497_17 * (var_497_22 / var_497_21)

				if var_497_23 > 0 and var_497_17 < var_497_23 then
					arg_494_1.talkMaxDuration = var_497_23

					if var_497_23 + var_497_16 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_23 + var_497_16
					end
				end

				arg_494_1.text_.text = var_497_20
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301122", "story_v_out_115301.awb") ~= 0 then
					local var_497_24 = manager.audio:GetVoiceLength("story_v_out_115301", "115301122", "story_v_out_115301.awb") / 1000

					if var_497_24 + var_497_16 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_24 + var_497_16
					end

					if var_497_19.prefab_name ~= "" and arg_494_1.actors_[var_497_19.prefab_name] ~= nil then
						local var_497_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_19.prefab_name].transform, "story_v_out_115301", "115301122", "story_v_out_115301.awb")

						arg_494_1:RecordAudio("115301122", var_497_25)
						arg_494_1:RecordAudio("115301122", var_497_25)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_115301", "115301122", "story_v_out_115301.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_115301", "115301122", "story_v_out_115301.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_26 = math.max(var_497_17, arg_494_1.talkMaxDuration)

			if var_497_16 <= arg_494_1.time_ and arg_494_1.time_ < var_497_16 + var_497_26 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_16) / var_497_26

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_16 + var_497_26 and arg_494_1.time_ < var_497_16 + var_497_26 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play115301123 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 115301123
		arg_498_1.duration_ = 3.73

		local var_498_0 = {
			ja = 3.733,
			ko = 3.3,
			zh = 3.466,
			en = 3.1
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play115301124(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0
			local var_501_1 = 0.4

			if var_501_0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_2 = arg_498_1:FormatText(StoryNameCfg[309].name)

				arg_498_1.leftNameTxt_.text = var_501_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_3 = arg_498_1:GetWordFromCfg(115301123)
				local var_501_4 = arg_498_1:FormatText(var_501_3.content)

				arg_498_1.text_.text = var_501_4

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_5 = 16
				local var_501_6 = utf8.len(var_501_4)
				local var_501_7 = var_501_5 <= 0 and var_501_1 or var_501_1 * (var_501_6 / var_501_5)

				if var_501_7 > 0 and var_501_1 < var_501_7 then
					arg_498_1.talkMaxDuration = var_501_7

					if var_501_7 + var_501_0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_7 + var_501_0
					end
				end

				arg_498_1.text_.text = var_501_4
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301123", "story_v_out_115301.awb") ~= 0 then
					local var_501_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301123", "story_v_out_115301.awb") / 1000

					if var_501_8 + var_501_0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_8 + var_501_0
					end

					if var_501_3.prefab_name ~= "" and arg_498_1.actors_[var_501_3.prefab_name] ~= nil then
						local var_501_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_3.prefab_name].transform, "story_v_out_115301", "115301123", "story_v_out_115301.awb")

						arg_498_1:RecordAudio("115301123", var_501_9)
						arg_498_1:RecordAudio("115301123", var_501_9)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_115301", "115301123", "story_v_out_115301.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_115301", "115301123", "story_v_out_115301.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_10 = math.max(var_501_1, arg_498_1.talkMaxDuration)

			if var_501_0 <= arg_498_1.time_ and arg_498_1.time_ < var_501_0 + var_501_10 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_0) / var_501_10

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_0 + var_501_10 and arg_498_1.time_ < var_501_0 + var_501_10 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play115301124 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 115301124
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play115301125(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["10030"]
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
				local var_505_2 = var_505_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_505_2 then
					arg_502_1.var_.alphaOldValue10030 = var_505_2.alpha
					arg_502_1.var_.characterEffect10030 = var_505_2
				end

				arg_502_1.var_.alphaOldValue10030 = 1
			end

			local var_505_3 = 0.333333333333333

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_3 then
				local var_505_4 = (arg_502_1.time_ - var_505_1) / var_505_3
				local var_505_5 = Mathf.Lerp(arg_502_1.var_.alphaOldValue10030, 0, var_505_4)

				if arg_502_1.var_.characterEffect10030 then
					arg_502_1.var_.characterEffect10030.alpha = var_505_5
				end
			end

			if arg_502_1.time_ >= var_505_1 + var_505_3 and arg_502_1.time_ < var_505_1 + var_505_3 + arg_505_0 and arg_502_1.var_.characterEffect10030 then
				arg_502_1.var_.characterEffect10030.alpha = 0
			end

			local var_505_6 = arg_502_1.actors_["1038"]
			local var_505_7 = 0

			if var_505_7 < arg_502_1.time_ and arg_502_1.time_ <= var_505_7 + arg_505_0 then
				local var_505_8 = var_505_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_505_8 then
					arg_502_1.var_.alphaOldValue1038 = var_505_8.alpha
					arg_502_1.var_.characterEffect1038 = var_505_8
				end

				arg_502_1.var_.alphaOldValue1038 = 1
			end

			local var_505_9 = 0.333333333333333

			if var_505_7 <= arg_502_1.time_ and arg_502_1.time_ < var_505_7 + var_505_9 then
				local var_505_10 = (arg_502_1.time_ - var_505_7) / var_505_9
				local var_505_11 = Mathf.Lerp(arg_502_1.var_.alphaOldValue1038, 0, var_505_10)

				if arg_502_1.var_.characterEffect1038 then
					arg_502_1.var_.characterEffect1038.alpha = var_505_11
				end
			end

			if arg_502_1.time_ >= var_505_7 + var_505_9 and arg_502_1.time_ < var_505_7 + var_505_9 + arg_505_0 and arg_502_1.var_.characterEffect1038 then
				arg_502_1.var_.characterEffect1038.alpha = 0
			end

			local var_505_12 = 0
			local var_505_13 = 0.45

			if var_505_12 < arg_502_1.time_ and arg_502_1.time_ <= var_505_12 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_14 = arg_502_1:GetWordFromCfg(115301124)
				local var_505_15 = arg_502_1:FormatText(var_505_14.content)

				arg_502_1.text_.text = var_505_15

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_16 = 18
				local var_505_17 = utf8.len(var_505_15)
				local var_505_18 = var_505_16 <= 0 and var_505_13 or var_505_13 * (var_505_17 / var_505_16)

				if var_505_18 > 0 and var_505_13 < var_505_18 then
					arg_502_1.talkMaxDuration = var_505_18

					if var_505_18 + var_505_12 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_18 + var_505_12
					end
				end

				arg_502_1.text_.text = var_505_15
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_19 = math.max(var_505_13, arg_502_1.talkMaxDuration)

			if var_505_12 <= arg_502_1.time_ and arg_502_1.time_ < var_505_12 + var_505_19 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_12) / var_505_19

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_12 + var_505_19 and arg_502_1.time_ < var_505_12 + var_505_19 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play115301125 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 115301125
		arg_506_1.duration_ = 4.47

		local var_506_0 = {
			ja = 2.7,
			ko = 3.733,
			zh = 4.466,
			en = 4.2
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play115301126(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0
			local var_509_1 = 0.35

			if var_509_0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_2 = arg_506_1:FormatText(StoryNameCfg[94].name)

				arg_506_1.leftNameTxt_.text = var_509_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_9")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_3 = arg_506_1:GetWordFromCfg(115301125)
				local var_509_4 = arg_506_1:FormatText(var_509_3.content)

				arg_506_1.text_.text = var_509_4

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 14
				local var_509_6 = utf8.len(var_509_4)
				local var_509_7 = var_509_5 <= 0 and var_509_1 or var_509_1 * (var_509_6 / var_509_5)

				if var_509_7 > 0 and var_509_1 < var_509_7 then
					arg_506_1.talkMaxDuration = var_509_7

					if var_509_7 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_7 + var_509_0
					end
				end

				arg_506_1.text_.text = var_509_4
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301125", "story_v_out_115301.awb") ~= 0 then
					local var_509_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301125", "story_v_out_115301.awb") / 1000

					if var_509_8 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_8 + var_509_0
					end

					if var_509_3.prefab_name ~= "" and arg_506_1.actors_[var_509_3.prefab_name] ~= nil then
						local var_509_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_3.prefab_name].transform, "story_v_out_115301", "115301125", "story_v_out_115301.awb")

						arg_506_1:RecordAudio("115301125", var_509_9)
						arg_506_1:RecordAudio("115301125", var_509_9)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_115301", "115301125", "story_v_out_115301.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_115301", "115301125", "story_v_out_115301.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_10 = math.max(var_509_1, arg_506_1.talkMaxDuration)

			if var_509_0 <= arg_506_1.time_ and arg_506_1.time_ < var_509_0 + var_509_10 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_0) / var_509_10

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_0 + var_509_10 and arg_506_1.time_ < var_509_0 + var_509_10 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play115301126 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 115301126
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play115301127(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0
			local var_513_1 = 0.575

			if var_513_0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_2 = arg_510_1:GetWordFromCfg(115301126)
				local var_513_3 = arg_510_1:FormatText(var_513_2.content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_4 = 23
				local var_513_5 = utf8.len(var_513_3)
				local var_513_6 = var_513_4 <= 0 and var_513_1 or var_513_1 * (var_513_5 / var_513_4)

				if var_513_6 > 0 and var_513_1 < var_513_6 then
					arg_510_1.talkMaxDuration = var_513_6

					if var_513_6 + var_513_0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_6 + var_513_0
					end
				end

				arg_510_1.text_.text = var_513_3
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_7 = math.max(var_513_1, arg_510_1.talkMaxDuration)

			if var_513_0 <= arg_510_1.time_ and arg_510_1.time_ < var_513_0 + var_513_7 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_0) / var_513_7

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_0 + var_513_7 and arg_510_1.time_ < var_513_0 + var_513_7 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play115301127 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 115301127
		arg_514_1.duration_ = 4.57

		local var_514_0 = {
			ja = 2.433,
			ko = 2.833,
			zh = 4.566,
			en = 2.533
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play115301128(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["1038"].transform
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 then
				arg_514_1.var_.moveOldPos1038 = var_517_0.localPosition
				var_517_0.localScale = Vector3.New(1, 1, 1)

				arg_514_1:CheckSpriteTmpPos("1038", 2)

				local var_517_2 = var_517_0.childCount

				for iter_517_0 = 0, var_517_2 - 1 do
					local var_517_3 = var_517_0:GetChild(iter_517_0)

					if var_517_3.name == "split_1" or not string.find(var_517_3.name, "split") then
						var_517_3.gameObject:SetActive(true)
					else
						var_517_3.gameObject:SetActive(false)
					end
				end
			end

			local var_517_4 = 0.001

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_4 then
				local var_517_5 = (arg_514_1.time_ - var_517_1) / var_517_4
				local var_517_6 = Vector3.New(-390, -400, 0)

				var_517_0.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1038, var_517_6, var_517_5)
			end

			if arg_514_1.time_ >= var_517_1 + var_517_4 and arg_514_1.time_ < var_517_1 + var_517_4 + arg_517_0 then
				var_517_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_517_7 = arg_514_1.actors_["1038"]
			local var_517_8 = 0

			if var_517_8 < arg_514_1.time_ and arg_514_1.time_ <= var_517_8 + arg_517_0 and not isNil(var_517_7) and arg_514_1.var_.actorSpriteComps1038 == nil then
				arg_514_1.var_.actorSpriteComps1038 = var_517_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_517_9 = 0.2

			if var_517_8 <= arg_514_1.time_ and arg_514_1.time_ < var_517_8 + var_517_9 and not isNil(var_517_7) then
				local var_517_10 = (arg_514_1.time_ - var_517_8) / var_517_9

				if arg_514_1.var_.actorSpriteComps1038 then
					for iter_517_1, iter_517_2 in pairs(arg_514_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_517_2 then
							if arg_514_1.isInRecall_ then
								local var_517_11 = Mathf.Lerp(iter_517_2.color.r, arg_514_1.hightColor1.r, var_517_10)
								local var_517_12 = Mathf.Lerp(iter_517_2.color.g, arg_514_1.hightColor1.g, var_517_10)
								local var_517_13 = Mathf.Lerp(iter_517_2.color.b, arg_514_1.hightColor1.b, var_517_10)

								iter_517_2.color = Color.New(var_517_11, var_517_12, var_517_13)
							else
								local var_517_14 = Mathf.Lerp(iter_517_2.color.r, 1, var_517_10)

								iter_517_2.color = Color.New(var_517_14, var_517_14, var_517_14)
							end
						end
					end
				end
			end

			if arg_514_1.time_ >= var_517_8 + var_517_9 and arg_514_1.time_ < var_517_8 + var_517_9 + arg_517_0 and not isNil(var_517_7) and arg_514_1.var_.actorSpriteComps1038 then
				for iter_517_3, iter_517_4 in pairs(arg_514_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_517_4 then
						if arg_514_1.isInRecall_ then
							iter_517_4.color = arg_514_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_517_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_514_1.var_.actorSpriteComps1038 = nil
			end

			local var_517_15 = arg_514_1.actors_["1038"]
			local var_517_16 = 0

			if var_517_16 < arg_514_1.time_ and arg_514_1.time_ <= var_517_16 + arg_517_0 then
				local var_517_17 = var_517_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_517_17 then
					arg_514_1.var_.alphaOldValue1038 = var_517_17.alpha
					arg_514_1.var_.characterEffect1038 = var_517_17
				end

				arg_514_1.var_.alphaOldValue1038 = 0
			end

			local var_517_18 = 0.333333333333333

			if var_517_16 <= arg_514_1.time_ and arg_514_1.time_ < var_517_16 + var_517_18 then
				local var_517_19 = (arg_514_1.time_ - var_517_16) / var_517_18
				local var_517_20 = Mathf.Lerp(arg_514_1.var_.alphaOldValue1038, 1, var_517_19)

				if arg_514_1.var_.characterEffect1038 then
					arg_514_1.var_.characterEffect1038.alpha = var_517_20
				end
			end

			if arg_514_1.time_ >= var_517_16 + var_517_18 and arg_514_1.time_ < var_517_16 + var_517_18 + arg_517_0 and arg_514_1.var_.characterEffect1038 then
				arg_514_1.var_.characterEffect1038.alpha = 1
			end

			local var_517_21 = 0
			local var_517_22 = 0.4

			if var_517_21 < arg_514_1.time_ and arg_514_1.time_ <= var_517_21 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_23 = arg_514_1:FormatText(StoryNameCfg[94].name)

				arg_514_1.leftNameTxt_.text = var_517_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_24 = arg_514_1:GetWordFromCfg(115301127)
				local var_517_25 = arg_514_1:FormatText(var_517_24.content)

				arg_514_1.text_.text = var_517_25

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_26 = 16
				local var_517_27 = utf8.len(var_517_25)
				local var_517_28 = var_517_26 <= 0 and var_517_22 or var_517_22 * (var_517_27 / var_517_26)

				if var_517_28 > 0 and var_517_22 < var_517_28 then
					arg_514_1.talkMaxDuration = var_517_28

					if var_517_28 + var_517_21 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_28 + var_517_21
					end
				end

				arg_514_1.text_.text = var_517_25
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301127", "story_v_out_115301.awb") ~= 0 then
					local var_517_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301127", "story_v_out_115301.awb") / 1000

					if var_517_29 + var_517_21 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_29 + var_517_21
					end

					if var_517_24.prefab_name ~= "" and arg_514_1.actors_[var_517_24.prefab_name] ~= nil then
						local var_517_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_24.prefab_name].transform, "story_v_out_115301", "115301127", "story_v_out_115301.awb")

						arg_514_1:RecordAudio("115301127", var_517_30)
						arg_514_1:RecordAudio("115301127", var_517_30)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_115301", "115301127", "story_v_out_115301.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_115301", "115301127", "story_v_out_115301.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_31 = math.max(var_517_22, arg_514_1.talkMaxDuration)

			if var_517_21 <= arg_514_1.time_ and arg_514_1.time_ < var_517_21 + var_517_31 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_21) / var_517_31

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_21 + var_517_31 and arg_514_1.time_ < var_517_21 + var_517_31 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play115301128 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 115301128
		arg_518_1.duration_ = 7.23

		local var_518_0 = {
			ja = 5.3,
			ko = 6.7,
			zh = 5.433,
			en = 7.233
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play115301129(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["10030"].transform
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
				arg_518_1.var_.moveOldPos10030 = var_521_0.localPosition
				var_521_0.localScale = Vector3.New(1, 1, 1)

				arg_518_1:CheckSpriteTmpPos("10030", 4)

				local var_521_2 = var_521_0.childCount

				for iter_521_0 = 0, var_521_2 - 1 do
					local var_521_3 = var_521_0:GetChild(iter_521_0)

					if var_521_3.name == "split_1" or not string.find(var_521_3.name, "split") then
						var_521_3.gameObject:SetActive(true)
					else
						var_521_3.gameObject:SetActive(false)
					end
				end
			end

			local var_521_4 = 0.001

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_4 then
				local var_521_5 = (arg_518_1.time_ - var_521_1) / var_521_4
				local var_521_6 = Vector3.New(390, -390, 150)

				var_521_0.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos10030, var_521_6, var_521_5)
			end

			if arg_518_1.time_ >= var_521_1 + var_521_4 and arg_518_1.time_ < var_521_1 + var_521_4 + arg_521_0 then
				var_521_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_521_7 = arg_518_1.actors_["1038"]
			local var_521_8 = 0

			if var_521_8 < arg_518_1.time_ and arg_518_1.time_ <= var_521_8 + arg_521_0 and not isNil(var_521_7) and arg_518_1.var_.actorSpriteComps1038 == nil then
				arg_518_1.var_.actorSpriteComps1038 = var_521_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_521_9 = 0.2

			if var_521_8 <= arg_518_1.time_ and arg_518_1.time_ < var_521_8 + var_521_9 and not isNil(var_521_7) then
				local var_521_10 = (arg_518_1.time_ - var_521_8) / var_521_9

				if arg_518_1.var_.actorSpriteComps1038 then
					for iter_521_1, iter_521_2 in pairs(arg_518_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_521_2 then
							if arg_518_1.isInRecall_ then
								local var_521_11 = Mathf.Lerp(iter_521_2.color.r, arg_518_1.hightColor2.r, var_521_10)
								local var_521_12 = Mathf.Lerp(iter_521_2.color.g, arg_518_1.hightColor2.g, var_521_10)
								local var_521_13 = Mathf.Lerp(iter_521_2.color.b, arg_518_1.hightColor2.b, var_521_10)

								iter_521_2.color = Color.New(var_521_11, var_521_12, var_521_13)
							else
								local var_521_14 = Mathf.Lerp(iter_521_2.color.r, 0.5, var_521_10)

								iter_521_2.color = Color.New(var_521_14, var_521_14, var_521_14)
							end
						end
					end
				end
			end

			if arg_518_1.time_ >= var_521_8 + var_521_9 and arg_518_1.time_ < var_521_8 + var_521_9 + arg_521_0 and not isNil(var_521_7) and arg_518_1.var_.actorSpriteComps1038 then
				for iter_521_3, iter_521_4 in pairs(arg_518_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_521_4 then
						if arg_518_1.isInRecall_ then
							iter_521_4.color = arg_518_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_521_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_518_1.var_.actorSpriteComps1038 = nil
			end

			local var_521_15 = arg_518_1.actors_["10030"]
			local var_521_16 = 0

			if var_521_16 < arg_518_1.time_ and arg_518_1.time_ <= var_521_16 + arg_521_0 and not isNil(var_521_15) and arg_518_1.var_.actorSpriteComps10030 == nil then
				arg_518_1.var_.actorSpriteComps10030 = var_521_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_521_17 = 0.2

			if var_521_16 <= arg_518_1.time_ and arg_518_1.time_ < var_521_16 + var_521_17 and not isNil(var_521_15) then
				local var_521_18 = (arg_518_1.time_ - var_521_16) / var_521_17

				if arg_518_1.var_.actorSpriteComps10030 then
					for iter_521_5, iter_521_6 in pairs(arg_518_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_521_6 then
							if arg_518_1.isInRecall_ then
								local var_521_19 = Mathf.Lerp(iter_521_6.color.r, arg_518_1.hightColor1.r, var_521_18)
								local var_521_20 = Mathf.Lerp(iter_521_6.color.g, arg_518_1.hightColor1.g, var_521_18)
								local var_521_21 = Mathf.Lerp(iter_521_6.color.b, arg_518_1.hightColor1.b, var_521_18)

								iter_521_6.color = Color.New(var_521_19, var_521_20, var_521_21)
							else
								local var_521_22 = Mathf.Lerp(iter_521_6.color.r, 1, var_521_18)

								iter_521_6.color = Color.New(var_521_22, var_521_22, var_521_22)
							end
						end
					end
				end
			end

			if arg_518_1.time_ >= var_521_16 + var_521_17 and arg_518_1.time_ < var_521_16 + var_521_17 + arg_521_0 and not isNil(var_521_15) and arg_518_1.var_.actorSpriteComps10030 then
				for iter_521_7, iter_521_8 in pairs(arg_518_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_521_8 then
						if arg_518_1.isInRecall_ then
							iter_521_8.color = arg_518_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_521_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_518_1.var_.actorSpriteComps10030 = nil
			end

			local var_521_23 = arg_518_1.actors_["10030"]
			local var_521_24 = 0

			if var_521_24 < arg_518_1.time_ and arg_518_1.time_ <= var_521_24 + arg_521_0 then
				local var_521_25 = var_521_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_521_25 then
					arg_518_1.var_.alphaOldValue10030 = var_521_25.alpha
					arg_518_1.var_.characterEffect10030 = var_521_25
				end

				arg_518_1.var_.alphaOldValue10030 = 0
			end

			local var_521_26 = 0.333333333333333

			if var_521_24 <= arg_518_1.time_ and arg_518_1.time_ < var_521_24 + var_521_26 then
				local var_521_27 = (arg_518_1.time_ - var_521_24) / var_521_26
				local var_521_28 = Mathf.Lerp(arg_518_1.var_.alphaOldValue10030, 1, var_521_27)

				if arg_518_1.var_.characterEffect10030 then
					arg_518_1.var_.characterEffect10030.alpha = var_521_28
				end
			end

			if arg_518_1.time_ >= var_521_24 + var_521_26 and arg_518_1.time_ < var_521_24 + var_521_26 + arg_521_0 and arg_518_1.var_.characterEffect10030 then
				arg_518_1.var_.characterEffect10030.alpha = 1
			end

			local var_521_29 = 0
			local var_521_30 = 0.525

			if var_521_29 < arg_518_1.time_ and arg_518_1.time_ <= var_521_29 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_31 = arg_518_1:FormatText(StoryNameCfg[309].name)

				arg_518_1.leftNameTxt_.text = var_521_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_32 = arg_518_1:GetWordFromCfg(115301128)
				local var_521_33 = arg_518_1:FormatText(var_521_32.content)

				arg_518_1.text_.text = var_521_33

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_34 = 21
				local var_521_35 = utf8.len(var_521_33)
				local var_521_36 = var_521_34 <= 0 and var_521_30 or var_521_30 * (var_521_35 / var_521_34)

				if var_521_36 > 0 and var_521_30 < var_521_36 then
					arg_518_1.talkMaxDuration = var_521_36

					if var_521_36 + var_521_29 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_36 + var_521_29
					end
				end

				arg_518_1.text_.text = var_521_33
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301128", "story_v_out_115301.awb") ~= 0 then
					local var_521_37 = manager.audio:GetVoiceLength("story_v_out_115301", "115301128", "story_v_out_115301.awb") / 1000

					if var_521_37 + var_521_29 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_37 + var_521_29
					end

					if var_521_32.prefab_name ~= "" and arg_518_1.actors_[var_521_32.prefab_name] ~= nil then
						local var_521_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_32.prefab_name].transform, "story_v_out_115301", "115301128", "story_v_out_115301.awb")

						arg_518_1:RecordAudio("115301128", var_521_38)
						arg_518_1:RecordAudio("115301128", var_521_38)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_115301", "115301128", "story_v_out_115301.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_115301", "115301128", "story_v_out_115301.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_39 = math.max(var_521_30, arg_518_1.talkMaxDuration)

			if var_521_29 <= arg_518_1.time_ and arg_518_1.time_ < var_521_29 + var_521_39 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_29) / var_521_39

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_29 + var_521_39 and arg_518_1.time_ < var_521_29 + var_521_39 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play115301129 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 115301129
		arg_522_1.duration_ = 11.07

		local var_522_0 = {
			ja = 6.666,
			ko = 6.6,
			zh = 8.1,
			en = 11.066
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play115301130(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["10030"]
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.actorSpriteComps10030 == nil then
				arg_522_1.var_.actorSpriteComps10030 = var_525_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_525_2 = 0.2

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 and not isNil(var_525_0) then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2

				if arg_522_1.var_.actorSpriteComps10030 then
					for iter_525_0, iter_525_1 in pairs(arg_522_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_525_1 then
							if arg_522_1.isInRecall_ then
								local var_525_4 = Mathf.Lerp(iter_525_1.color.r, arg_522_1.hightColor2.r, var_525_3)
								local var_525_5 = Mathf.Lerp(iter_525_1.color.g, arg_522_1.hightColor2.g, var_525_3)
								local var_525_6 = Mathf.Lerp(iter_525_1.color.b, arg_522_1.hightColor2.b, var_525_3)

								iter_525_1.color = Color.New(var_525_4, var_525_5, var_525_6)
							else
								local var_525_7 = Mathf.Lerp(iter_525_1.color.r, 0.5, var_525_3)

								iter_525_1.color = Color.New(var_525_7, var_525_7, var_525_7)
							end
						end
					end
				end
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.actorSpriteComps10030 then
				for iter_525_2, iter_525_3 in pairs(arg_522_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_525_3 then
						if arg_522_1.isInRecall_ then
							iter_525_3.color = arg_522_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_525_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_522_1.var_.actorSpriteComps10030 = nil
			end

			local var_525_8 = arg_522_1.actors_["1038"]
			local var_525_9 = 0

			if var_525_9 < arg_522_1.time_ and arg_522_1.time_ <= var_525_9 + arg_525_0 and not isNil(var_525_8) and arg_522_1.var_.actorSpriteComps1038 == nil then
				arg_522_1.var_.actorSpriteComps1038 = var_525_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_525_10 = 0.2

			if var_525_9 <= arg_522_1.time_ and arg_522_1.time_ < var_525_9 + var_525_10 and not isNil(var_525_8) then
				local var_525_11 = (arg_522_1.time_ - var_525_9) / var_525_10

				if arg_522_1.var_.actorSpriteComps1038 then
					for iter_525_4, iter_525_5 in pairs(arg_522_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_525_5 then
							if arg_522_1.isInRecall_ then
								local var_525_12 = Mathf.Lerp(iter_525_5.color.r, arg_522_1.hightColor1.r, var_525_11)
								local var_525_13 = Mathf.Lerp(iter_525_5.color.g, arg_522_1.hightColor1.g, var_525_11)
								local var_525_14 = Mathf.Lerp(iter_525_5.color.b, arg_522_1.hightColor1.b, var_525_11)

								iter_525_5.color = Color.New(var_525_12, var_525_13, var_525_14)
							else
								local var_525_15 = Mathf.Lerp(iter_525_5.color.r, 1, var_525_11)

								iter_525_5.color = Color.New(var_525_15, var_525_15, var_525_15)
							end
						end
					end
				end
			end

			if arg_522_1.time_ >= var_525_9 + var_525_10 and arg_522_1.time_ < var_525_9 + var_525_10 + arg_525_0 and not isNil(var_525_8) and arg_522_1.var_.actorSpriteComps1038 then
				for iter_525_6, iter_525_7 in pairs(arg_522_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_525_7 then
						if arg_522_1.isInRecall_ then
							iter_525_7.color = arg_522_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_525_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_522_1.var_.actorSpriteComps1038 = nil
			end

			local var_525_16 = 0
			local var_525_17 = 0.75

			if var_525_16 < arg_522_1.time_ and arg_522_1.time_ <= var_525_16 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_18 = arg_522_1:FormatText(StoryNameCfg[94].name)

				arg_522_1.leftNameTxt_.text = var_525_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_19 = arg_522_1:GetWordFromCfg(115301129)
				local var_525_20 = arg_522_1:FormatText(var_525_19.content)

				arg_522_1.text_.text = var_525_20

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_21 = 29
				local var_525_22 = utf8.len(var_525_20)
				local var_525_23 = var_525_21 <= 0 and var_525_17 or var_525_17 * (var_525_22 / var_525_21)

				if var_525_23 > 0 and var_525_17 < var_525_23 then
					arg_522_1.talkMaxDuration = var_525_23

					if var_525_23 + var_525_16 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_23 + var_525_16
					end
				end

				arg_522_1.text_.text = var_525_20
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301129", "story_v_out_115301.awb") ~= 0 then
					local var_525_24 = manager.audio:GetVoiceLength("story_v_out_115301", "115301129", "story_v_out_115301.awb") / 1000

					if var_525_24 + var_525_16 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_24 + var_525_16
					end

					if var_525_19.prefab_name ~= "" and arg_522_1.actors_[var_525_19.prefab_name] ~= nil then
						local var_525_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_19.prefab_name].transform, "story_v_out_115301", "115301129", "story_v_out_115301.awb")

						arg_522_1:RecordAudio("115301129", var_525_25)
						arg_522_1:RecordAudio("115301129", var_525_25)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_115301", "115301129", "story_v_out_115301.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_115301", "115301129", "story_v_out_115301.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_26 = math.max(var_525_17, arg_522_1.talkMaxDuration)

			if var_525_16 <= arg_522_1.time_ and arg_522_1.time_ < var_525_16 + var_525_26 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_16) / var_525_26

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_16 + var_525_26 and arg_522_1.time_ < var_525_16 + var_525_26 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play115301130 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 115301130
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play115301131(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["1038"]
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.actorSpriteComps1038 == nil then
				arg_526_1.var_.actorSpriteComps1038 = var_529_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_529_2 = 0.2

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 and not isNil(var_529_0) then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2

				if arg_526_1.var_.actorSpriteComps1038 then
					for iter_529_0, iter_529_1 in pairs(arg_526_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_529_1 then
							if arg_526_1.isInRecall_ then
								local var_529_4 = Mathf.Lerp(iter_529_1.color.r, arg_526_1.hightColor2.r, var_529_3)
								local var_529_5 = Mathf.Lerp(iter_529_1.color.g, arg_526_1.hightColor2.g, var_529_3)
								local var_529_6 = Mathf.Lerp(iter_529_1.color.b, arg_526_1.hightColor2.b, var_529_3)

								iter_529_1.color = Color.New(var_529_4, var_529_5, var_529_6)
							else
								local var_529_7 = Mathf.Lerp(iter_529_1.color.r, 0.5, var_529_3)

								iter_529_1.color = Color.New(var_529_7, var_529_7, var_529_7)
							end
						end
					end
				end
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.actorSpriteComps1038 then
				for iter_529_2, iter_529_3 in pairs(arg_526_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_529_3 then
						if arg_526_1.isInRecall_ then
							iter_529_3.color = arg_526_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_529_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_526_1.var_.actorSpriteComps1038 = nil
			end

			local var_529_8 = 0
			local var_529_9 = 0.825

			if var_529_8 < arg_526_1.time_ and arg_526_1.time_ <= var_529_8 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, false)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_10 = arg_526_1:GetWordFromCfg(115301130)
				local var_529_11 = arg_526_1:FormatText(var_529_10.content)

				arg_526_1.text_.text = var_529_11

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_12 = 33
				local var_529_13 = utf8.len(var_529_11)
				local var_529_14 = var_529_12 <= 0 and var_529_9 or var_529_9 * (var_529_13 / var_529_12)

				if var_529_14 > 0 and var_529_9 < var_529_14 then
					arg_526_1.talkMaxDuration = var_529_14

					if var_529_14 + var_529_8 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_14 + var_529_8
					end
				end

				arg_526_1.text_.text = var_529_11
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_15 = math.max(var_529_9, arg_526_1.talkMaxDuration)

			if var_529_8 <= arg_526_1.time_ and arg_526_1.time_ < var_529_8 + var_529_15 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_8) / var_529_15

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_8 + var_529_15 and arg_526_1.time_ < var_529_8 + var_529_15 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play115301131 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 115301131
		arg_530_1.duration_ = 4.3

		local var_530_0 = {
			ja = 4.3,
			ko = 2.5,
			zh = 3.333,
			en = 3.1
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play115301132(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["10030"]
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.actorSpriteComps10030 == nil then
				arg_530_1.var_.actorSpriteComps10030 = var_533_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_533_2 = 0.2

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 and not isNil(var_533_0) then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2

				if arg_530_1.var_.actorSpriteComps10030 then
					for iter_533_0, iter_533_1 in pairs(arg_530_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_533_1 then
							if arg_530_1.isInRecall_ then
								local var_533_4 = Mathf.Lerp(iter_533_1.color.r, arg_530_1.hightColor1.r, var_533_3)
								local var_533_5 = Mathf.Lerp(iter_533_1.color.g, arg_530_1.hightColor1.g, var_533_3)
								local var_533_6 = Mathf.Lerp(iter_533_1.color.b, arg_530_1.hightColor1.b, var_533_3)

								iter_533_1.color = Color.New(var_533_4, var_533_5, var_533_6)
							else
								local var_533_7 = Mathf.Lerp(iter_533_1.color.r, 1, var_533_3)

								iter_533_1.color = Color.New(var_533_7, var_533_7, var_533_7)
							end
						end
					end
				end
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.actorSpriteComps10030 then
				for iter_533_2, iter_533_3 in pairs(arg_530_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_533_3 then
						if arg_530_1.isInRecall_ then
							iter_533_3.color = arg_530_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_533_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_530_1.var_.actorSpriteComps10030 = nil
			end

			local var_533_8 = 0
			local var_533_9 = 0.275

			if var_533_8 < arg_530_1.time_ and arg_530_1.time_ <= var_533_8 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_10 = arg_530_1:FormatText(StoryNameCfg[309].name)

				arg_530_1.leftNameTxt_.text = var_533_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_11 = arg_530_1:GetWordFromCfg(115301131)
				local var_533_12 = arg_530_1:FormatText(var_533_11.content)

				arg_530_1.text_.text = var_533_12

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_13 = 11
				local var_533_14 = utf8.len(var_533_12)
				local var_533_15 = var_533_13 <= 0 and var_533_9 or var_533_9 * (var_533_14 / var_533_13)

				if var_533_15 > 0 and var_533_9 < var_533_15 then
					arg_530_1.talkMaxDuration = var_533_15

					if var_533_15 + var_533_8 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_15 + var_533_8
					end
				end

				arg_530_1.text_.text = var_533_12
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301131", "story_v_out_115301.awb") ~= 0 then
					local var_533_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301131", "story_v_out_115301.awb") / 1000

					if var_533_16 + var_533_8 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_16 + var_533_8
					end

					if var_533_11.prefab_name ~= "" and arg_530_1.actors_[var_533_11.prefab_name] ~= nil then
						local var_533_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_11.prefab_name].transform, "story_v_out_115301", "115301131", "story_v_out_115301.awb")

						arg_530_1:RecordAudio("115301131", var_533_17)
						arg_530_1:RecordAudio("115301131", var_533_17)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_115301", "115301131", "story_v_out_115301.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_115301", "115301131", "story_v_out_115301.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_18 = math.max(var_533_9, arg_530_1.talkMaxDuration)

			if var_533_8 <= arg_530_1.time_ and arg_530_1.time_ < var_533_8 + var_533_18 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_8) / var_533_18

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_8 + var_533_18 and arg_530_1.time_ < var_533_8 + var_533_18 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play115301132 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 115301132
		arg_534_1.duration_ = 9.9

		local var_534_0 = {
			ja = 9.9,
			ko = 4.466,
			zh = 5.1,
			en = 4.766
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play115301133(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["10030"]
			local var_537_1 = 0

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.actorSpriteComps10030 == nil then
				arg_534_1.var_.actorSpriteComps10030 = var_537_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_537_2 = 0.2

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 and not isNil(var_537_0) then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2

				if arg_534_1.var_.actorSpriteComps10030 then
					for iter_537_0, iter_537_1 in pairs(arg_534_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_537_1 then
							if arg_534_1.isInRecall_ then
								local var_537_4 = Mathf.Lerp(iter_537_1.color.r, arg_534_1.hightColor2.r, var_537_3)
								local var_537_5 = Mathf.Lerp(iter_537_1.color.g, arg_534_1.hightColor2.g, var_537_3)
								local var_537_6 = Mathf.Lerp(iter_537_1.color.b, arg_534_1.hightColor2.b, var_537_3)

								iter_537_1.color = Color.New(var_537_4, var_537_5, var_537_6)
							else
								local var_537_7 = Mathf.Lerp(iter_537_1.color.r, 0.5, var_537_3)

								iter_537_1.color = Color.New(var_537_7, var_537_7, var_537_7)
							end
						end
					end
				end
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.actorSpriteComps10030 then
				for iter_537_2, iter_537_3 in pairs(arg_534_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_537_3 then
						if arg_534_1.isInRecall_ then
							iter_537_3.color = arg_534_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_537_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_534_1.var_.actorSpriteComps10030 = nil
			end

			local var_537_8 = arg_534_1.actors_["1038"].transform
			local var_537_9 = 0

			if var_537_9 < arg_534_1.time_ and arg_534_1.time_ <= var_537_9 + arg_537_0 then
				arg_534_1.var_.moveOldPos1038 = var_537_8.localPosition
				var_537_8.localScale = Vector3.New(1, 1, 1)

				arg_534_1:CheckSpriteTmpPos("1038", 2)

				local var_537_10 = var_537_8.childCount

				for iter_537_4 = 0, var_537_10 - 1 do
					local var_537_11 = var_537_8:GetChild(iter_537_4)

					if var_537_11.name == "split_7" or not string.find(var_537_11.name, "split") then
						var_537_11.gameObject:SetActive(true)
					else
						var_537_11.gameObject:SetActive(false)
					end
				end
			end

			local var_537_12 = 0.001

			if var_537_9 <= arg_534_1.time_ and arg_534_1.time_ < var_537_9 + var_537_12 then
				local var_537_13 = (arg_534_1.time_ - var_537_9) / var_537_12
				local var_537_14 = Vector3.New(-390, -400, 0)

				var_537_8.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos1038, var_537_14, var_537_13)
			end

			if arg_534_1.time_ >= var_537_9 + var_537_12 and arg_534_1.time_ < var_537_9 + var_537_12 + arg_537_0 then
				var_537_8.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_537_15 = arg_534_1.actors_["1038"]
			local var_537_16 = 0

			if var_537_16 < arg_534_1.time_ and arg_534_1.time_ <= var_537_16 + arg_537_0 then
				local var_537_17 = var_537_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_537_17 then
					arg_534_1.var_.alphaOldValue1038 = var_537_17.alpha
					arg_534_1.var_.characterEffect1038 = var_537_17
				end

				arg_534_1.var_.alphaOldValue1038 = 0
			end

			local var_537_18 = 0.0166666666666667

			if var_537_16 <= arg_534_1.time_ and arg_534_1.time_ < var_537_16 + var_537_18 then
				local var_537_19 = (arg_534_1.time_ - var_537_16) / var_537_18
				local var_537_20 = Mathf.Lerp(arg_534_1.var_.alphaOldValue1038, 1, var_537_19)

				if arg_534_1.var_.characterEffect1038 then
					arg_534_1.var_.characterEffect1038.alpha = var_537_20
				end
			end

			if arg_534_1.time_ >= var_537_16 + var_537_18 and arg_534_1.time_ < var_537_16 + var_537_18 + arg_537_0 and arg_534_1.var_.characterEffect1038 then
				arg_534_1.var_.characterEffect1038.alpha = 1
			end

			local var_537_21 = 0
			local var_537_22 = 0.5

			if var_537_21 < arg_534_1.time_ and arg_534_1.time_ <= var_537_21 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_23 = arg_534_1:FormatText(StoryNameCfg[94].name)

				arg_534_1.leftNameTxt_.text = var_537_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_24 = arg_534_1:GetWordFromCfg(115301132)
				local var_537_25 = arg_534_1:FormatText(var_537_24.content)

				arg_534_1.text_.text = var_537_25

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_26 = 20
				local var_537_27 = utf8.len(var_537_25)
				local var_537_28 = var_537_26 <= 0 and var_537_22 or var_537_22 * (var_537_27 / var_537_26)

				if var_537_28 > 0 and var_537_22 < var_537_28 then
					arg_534_1.talkMaxDuration = var_537_28

					if var_537_28 + var_537_21 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_28 + var_537_21
					end
				end

				arg_534_1.text_.text = var_537_25
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301132", "story_v_out_115301.awb") ~= 0 then
					local var_537_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301132", "story_v_out_115301.awb") / 1000

					if var_537_29 + var_537_21 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_29 + var_537_21
					end

					if var_537_24.prefab_name ~= "" and arg_534_1.actors_[var_537_24.prefab_name] ~= nil then
						local var_537_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_24.prefab_name].transform, "story_v_out_115301", "115301132", "story_v_out_115301.awb")

						arg_534_1:RecordAudio("115301132", var_537_30)
						arg_534_1:RecordAudio("115301132", var_537_30)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_115301", "115301132", "story_v_out_115301.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_115301", "115301132", "story_v_out_115301.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_31 = math.max(var_537_22, arg_534_1.talkMaxDuration)

			if var_537_21 <= arg_534_1.time_ and arg_534_1.time_ < var_537_21 + var_537_31 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_21) / var_537_31

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_21 + var_537_31 and arg_534_1.time_ < var_537_21 + var_537_31 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_534_1:InitPlayNodeList()
	end,
	Play115301133 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 115301133
		arg_538_1.duration_ = 4

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play115301134(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = 1

			if var_541_0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_0 + arg_541_0 then
				local var_541_1 = manager.ui.mainCamera.transform.localPosition
				local var_541_2 = Vector3.New(0, 0, 10) + Vector3.New(var_541_1.x, var_541_1.y, 0)
				local var_541_3 = arg_538_1.bgs_.STblack

				var_541_3.transform.localPosition = var_541_2
				var_541_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_541_4 = var_541_3:GetComponent("SpriteRenderer")

				if var_541_4 and var_541_4.sprite then
					local var_541_5 = (var_541_3.transform.localPosition - var_541_1).z
					local var_541_6 = manager.ui.mainCameraCom_
					local var_541_7 = 2 * var_541_5 * Mathf.Tan(var_541_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_541_8 = var_541_7 * var_541_6.aspect
					local var_541_9 = var_541_4.sprite.bounds.size.x
					local var_541_10 = var_541_4.sprite.bounds.size.y
					local var_541_11 = var_541_8 / var_541_9
					local var_541_12 = var_541_7 / var_541_10
					local var_541_13 = var_541_12 < var_541_11 and var_541_11 or var_541_12

					var_541_3.transform.localScale = Vector3.New(var_541_13, var_541_13, 0)
				end

				for iter_541_0, iter_541_1 in pairs(arg_538_1.bgs_) do
					if iter_541_0 ~= "STblack" then
						iter_541_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_541_14 = 0

			if var_541_14 < arg_538_1.time_ and arg_538_1.time_ <= var_541_14 + arg_541_0 then
				arg_538_1.mask_.enabled = true
				arg_538_1.mask_.raycastTarget = true

				arg_538_1:SetGaussion(false)
			end

			local var_541_15 = 1

			if var_541_14 <= arg_538_1.time_ and arg_538_1.time_ < var_541_14 + var_541_15 then
				local var_541_16 = (arg_538_1.time_ - var_541_14) / var_541_15
				local var_541_17 = Color.New(0, 0, 0)

				var_541_17.a = Mathf.Lerp(0, 1, var_541_16)
				arg_538_1.mask_.color = var_541_17
			end

			if arg_538_1.time_ >= var_541_14 + var_541_15 and arg_538_1.time_ < var_541_14 + var_541_15 + arg_541_0 then
				local var_541_18 = Color.New(0, 0, 0)

				var_541_18.a = 1
				arg_538_1.mask_.color = var_541_18
			end

			local var_541_19 = 1

			if var_541_19 < arg_538_1.time_ and arg_538_1.time_ <= var_541_19 + arg_541_0 then
				arg_538_1.mask_.enabled = true
				arg_538_1.mask_.raycastTarget = false

				arg_538_1:SetGaussion(false)
			end

			local var_541_20 = 0.0333333333333333

			if var_541_19 <= arg_538_1.time_ and arg_538_1.time_ < var_541_19 + var_541_20 then
				local var_541_21 = (arg_538_1.time_ - var_541_19) / var_541_20
				local var_541_22 = Color.New(0, 0, 0)

				var_541_22.a = Mathf.Lerp(1, 0, var_541_21)
				arg_538_1.mask_.color = var_541_22
			end

			if arg_538_1.time_ >= var_541_19 + var_541_20 and arg_538_1.time_ < var_541_19 + var_541_20 + arg_541_0 then
				local var_541_23 = Color.New(0, 0, 0)
				local var_541_24 = 0

				arg_538_1.mask_.enabled = false
				var_541_23.a = var_541_24
				arg_538_1.mask_.color = var_541_23
			end

			local var_541_25 = 1

			if var_541_25 < arg_538_1.time_ and arg_538_1.time_ <= var_541_25 + arg_541_0 then
				arg_538_1.fswbg_:SetActive(true)
				arg_538_1.dialog_:SetActive(false)

				arg_538_1.fswtw_.percent = 0

				local var_541_26 = arg_538_1:GetWordFromCfg(115301133)
				local var_541_27 = arg_538_1:FormatText(var_541_26.content)

				arg_538_1.fswt_.text = var_541_27

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.fswt_)

				arg_538_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_538_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_538_1.fswtw_:SetDirty()

				arg_538_1.typewritterCharCountI18N = 0

				SetActive(arg_538_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_538_1:ShowNextGo(false)
			end

			local var_541_28 = 1.01666666666667

			if var_541_28 < arg_538_1.time_ and arg_538_1.time_ <= var_541_28 + arg_541_0 then
				arg_538_1.var_.oldValueTypewriter = arg_538_1.fswtw_.percent

				SetActive(arg_538_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_538_1:ShowNextGo(false)
			end

			local var_541_29 = 14
			local var_541_30 = 0.933333333333333
			local var_541_31 = arg_538_1:GetWordFromCfg(115301133)
			local var_541_32 = arg_538_1:FormatText(var_541_31.content)
			local var_541_33, var_541_34 = arg_538_1:GetPercentByPara(var_541_32, 1)

			if var_541_28 < arg_538_1.time_ and arg_538_1.time_ <= var_541_28 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0

				local var_541_35 = var_541_29 <= 0 and var_541_30 or var_541_30 * ((var_541_34 - arg_538_1.typewritterCharCountI18N) / var_541_29)

				if var_541_35 > 0 and var_541_30 < var_541_35 then
					arg_538_1.talkMaxDuration = var_541_35

					if var_541_35 + var_541_28 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_35 + var_541_28
					end
				end
			end

			local var_541_36 = 0.933333333333333
			local var_541_37 = math.max(var_541_36, arg_538_1.talkMaxDuration)

			if var_541_28 <= arg_538_1.time_ and arg_538_1.time_ < var_541_28 + var_541_37 then
				local var_541_38 = (arg_538_1.time_ - var_541_28) / var_541_37

				arg_538_1.fswtw_.percent = Mathf.Lerp(arg_538_1.var_.oldValueTypewriter, var_541_33, var_541_38)
				arg_538_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_538_1.fswtw_:SetDirty()
			end

			if arg_538_1.time_ >= var_541_28 + var_541_37 and arg_538_1.time_ < var_541_28 + var_541_37 + arg_541_0 then
				arg_538_1.fswtw_.percent = var_541_33

				arg_538_1.fswtw_:SetDirty()
				arg_538_1:ShowNextGo(true)

				arg_538_1.typewritterCharCountI18N = var_541_34
			end

			local var_541_39 = arg_538_1.actors_["10030"].transform
			local var_541_40 = 1

			if var_541_40 < arg_538_1.time_ and arg_538_1.time_ <= var_541_40 + arg_541_0 then
				arg_538_1.var_.moveOldPos10030 = var_541_39.localPosition
				var_541_39.localScale = Vector3.New(1, 1, 1)

				arg_538_1:CheckSpriteTmpPos("10030", 0)

				local var_541_41 = var_541_39.childCount

				for iter_541_2 = 0, var_541_41 - 1 do
					local var_541_42 = var_541_39:GetChild(iter_541_2)

					if var_541_42.name == "split_1" or not string.find(var_541_42.name, "split") then
						var_541_42.gameObject:SetActive(true)
					else
						var_541_42.gameObject:SetActive(false)
					end
				end
			end

			local var_541_43 = 0.001

			if var_541_40 <= arg_538_1.time_ and arg_538_1.time_ < var_541_40 + var_541_43 then
				local var_541_44 = (arg_538_1.time_ - var_541_40) / var_541_43
				local var_541_45 = Vector3.New(-1500, -350, -180)

				var_541_39.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos10030, var_541_45, var_541_44)
			end

			if arg_538_1.time_ >= var_541_40 + var_541_43 and arg_538_1.time_ < var_541_40 + var_541_43 + arg_541_0 then
				var_541_39.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_541_46 = arg_538_1.actors_["1038"].transform
			local var_541_47 = 1

			if var_541_47 < arg_538_1.time_ and arg_538_1.time_ <= var_541_47 + arg_541_0 then
				arg_538_1.var_.moveOldPos1038 = var_541_46.localPosition
				var_541_46.localScale = Vector3.New(1, 1, 1)

				arg_538_1:CheckSpriteTmpPos("1038", 0)

				local var_541_48 = var_541_46.childCount

				for iter_541_3 = 0, var_541_48 - 1 do
					local var_541_49 = var_541_46:GetChild(iter_541_3)

					if var_541_49.name == "split_7" or not string.find(var_541_49.name, "split") then
						var_541_49.gameObject:SetActive(true)
					else
						var_541_49.gameObject:SetActive(false)
					end
				end
			end

			local var_541_50 = 0.001

			if var_541_47 <= arg_538_1.time_ and arg_538_1.time_ < var_541_47 + var_541_50 then
				local var_541_51 = (arg_538_1.time_ - var_541_47) / var_541_50
				local var_541_52 = Vector3.New(-1500, -350, -180)

				var_541_46.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos1038, var_541_52, var_541_51)
			end

			if arg_538_1.time_ >= var_541_47 + var_541_50 and arg_538_1.time_ < var_541_47 + var_541_50 + arg_541_0 then
				var_541_46.localPosition = Vector3.New(-1500, -350, -180)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play115301134 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 115301134
		arg_542_1.duration_ = 1

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play115301135(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				arg_542_1.var_.oldValueTypewriter = arg_542_1.fswtw_.percent

				SetActive(arg_542_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_542_1:ShowNextGo(false)
			end

			local var_545_1 = 26
			local var_545_2 = 0.8
			local var_545_3 = arg_542_1:GetWordFromCfg(115301133)
			local var_545_4 = arg_542_1:FormatText(var_545_3.content)
			local var_545_5, var_545_6 = arg_542_1:GetPercentByPara(var_545_4, 2)

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0

				local var_545_7 = var_545_1 <= 0 and var_545_2 or var_545_2 * ((var_545_6 - arg_542_1.typewritterCharCountI18N) / var_545_1)

				if var_545_7 > 0 and var_545_2 < var_545_7 then
					arg_542_1.talkMaxDuration = var_545_7

					if var_545_7 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_7 + var_545_0
					end
				end
			end

			local var_545_8 = 0.8
			local var_545_9 = math.max(var_545_8, arg_542_1.talkMaxDuration)

			if var_545_0 <= arg_542_1.time_ and arg_542_1.time_ < var_545_0 + var_545_9 then
				local var_545_10 = (arg_542_1.time_ - var_545_0) / var_545_9

				arg_542_1.fswtw_.percent = Mathf.Lerp(arg_542_1.var_.oldValueTypewriter, var_545_5, var_545_10)
				arg_542_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_542_1.fswtw_:SetDirty()
			end

			if arg_542_1.time_ >= var_545_0 + var_545_9 and arg_542_1.time_ < var_545_0 + var_545_9 + arg_545_0 then
				arg_542_1.fswtw_.percent = var_545_5

				arg_542_1.fswtw_:SetDirty()
				arg_542_1:ShowNextGo(true)

				arg_542_1.typewritterCharCountI18N = var_545_6
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play115301135 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 115301135
		arg_546_1.duration_ = 1

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play115301136(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.var_.oldValueTypewriter = arg_546_1.fswtw_.percent

				SetActive(arg_546_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_546_1:ShowNextGo(false)
			end

			local var_549_1 = 12
			local var_549_2 = 0.8
			local var_549_3 = arg_546_1:GetWordFromCfg(115301133)
			local var_549_4 = arg_546_1:FormatText(var_549_3.content)
			local var_549_5, var_549_6 = arg_546_1:GetPercentByPara(var_549_4, 3)

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0

				local var_549_7 = var_549_1 <= 0 and var_549_2 or var_549_2 * ((var_549_6 - arg_546_1.typewritterCharCountI18N) / var_549_1)

				if var_549_7 > 0 and var_549_2 < var_549_7 then
					arg_546_1.talkMaxDuration = var_549_7

					if var_549_7 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_7 + var_549_0
					end
				end
			end

			local var_549_8 = 0.8
			local var_549_9 = math.max(var_549_8, arg_546_1.talkMaxDuration)

			if var_549_0 <= arg_546_1.time_ and arg_546_1.time_ < var_549_0 + var_549_9 then
				local var_549_10 = (arg_546_1.time_ - var_549_0) / var_549_9

				arg_546_1.fswtw_.percent = Mathf.Lerp(arg_546_1.var_.oldValueTypewriter, var_549_5, var_549_10)
				arg_546_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_546_1.fswtw_:SetDirty()
			end

			if arg_546_1.time_ >= var_549_0 + var_549_9 and arg_546_1.time_ < var_549_0 + var_549_9 + arg_549_0 then
				arg_546_1.fswtw_.percent = var_549_5

				arg_546_1.fswtw_:SetDirty()
				arg_546_1:ShowNextGo(true)

				arg_546_1.typewritterCharCountI18N = var_549_6
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play115301136 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 115301136
		arg_550_1.duration_ = 1

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play115301137(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0

			if var_553_0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_0 + arg_553_0 then
				arg_550_1.var_.oldValueTypewriter = arg_550_1.fswtw_.percent

				SetActive(arg_550_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_550_1:ShowNextGo(false)
			end

			local var_553_1 = 13
			local var_553_2 = 0.866666666666667
			local var_553_3 = arg_550_1:GetWordFromCfg(115301133)
			local var_553_4 = arg_550_1:FormatText(var_553_3.content)
			local var_553_5, var_553_6 = arg_550_1:GetPercentByPara(var_553_4, 4)

			if var_553_0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0

				local var_553_7 = var_553_1 <= 0 and var_553_2 or var_553_2 * ((var_553_6 - arg_550_1.typewritterCharCountI18N) / var_553_1)

				if var_553_7 > 0 and var_553_2 < var_553_7 then
					arg_550_1.talkMaxDuration = var_553_7

					if var_553_7 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_7 + var_553_0
					end
				end
			end

			local var_553_8 = 0.866666666666667
			local var_553_9 = math.max(var_553_8, arg_550_1.talkMaxDuration)

			if var_553_0 <= arg_550_1.time_ and arg_550_1.time_ < var_553_0 + var_553_9 then
				local var_553_10 = (arg_550_1.time_ - var_553_0) / var_553_9

				arg_550_1.fswtw_.percent = Mathf.Lerp(arg_550_1.var_.oldValueTypewriter, var_553_5, var_553_10)
				arg_550_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_550_1.fswtw_:SetDirty()
			end

			if arg_550_1.time_ >= var_553_0 + var_553_9 and arg_550_1.time_ < var_553_0 + var_553_9 + arg_553_0 then
				arg_550_1.fswtw_.percent = var_553_5

				arg_550_1.fswtw_:SetDirty()
				arg_550_1:ShowNextGo(true)

				arg_550_1.typewritterCharCountI18N = var_553_6
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play115301137 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 115301137
		arg_554_1.duration_ = 1.07

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play115301138(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				arg_554_1.var_.oldValueTypewriter = arg_554_1.fswtw_.percent

				SetActive(arg_554_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_554_1:ShowNextGo(false)
			end

			local var_557_1 = 16
			local var_557_2 = 1.06666666666667
			local var_557_3 = arg_554_1:GetWordFromCfg(115301133)
			local var_557_4 = arg_554_1:FormatText(var_557_3.content)
			local var_557_5, var_557_6 = arg_554_1:GetPercentByPara(var_557_4, 5)

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0

				local var_557_7 = var_557_1 <= 0 and var_557_2 or var_557_2 * ((var_557_6 - arg_554_1.typewritterCharCountI18N) / var_557_1)

				if var_557_7 > 0 and var_557_2 < var_557_7 then
					arg_554_1.talkMaxDuration = var_557_7

					if var_557_7 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_7 + var_557_0
					end
				end
			end

			local var_557_8 = 1.06666666666667
			local var_557_9 = math.max(var_557_8, arg_554_1.talkMaxDuration)

			if var_557_0 <= arg_554_1.time_ and arg_554_1.time_ < var_557_0 + var_557_9 then
				local var_557_10 = (arg_554_1.time_ - var_557_0) / var_557_9

				arg_554_1.fswtw_.percent = Mathf.Lerp(arg_554_1.var_.oldValueTypewriter, var_557_5, var_557_10)
				arg_554_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_554_1.fswtw_:SetDirty()
			end

			if arg_554_1.time_ >= var_557_0 + var_557_9 and arg_554_1.time_ < var_557_0 + var_557_9 + arg_557_0 then
				arg_554_1.fswtw_.percent = var_557_5

				arg_554_1.fswtw_:SetDirty()
				arg_554_1:ShowNextGo(true)

				arg_554_1.typewritterCharCountI18N = var_557_6
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play115301138 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 115301138
		arg_558_1.duration_ = 1.07

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play115301139(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0

			if var_561_0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_0 + arg_561_0 then
				arg_558_1.var_.oldValueTypewriter = arg_558_1.fswtw_.percent

				SetActive(arg_558_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_558_1:ShowNextGo(false)
			end

			local var_561_1 = 16
			local var_561_2 = 1.06666666666667
			local var_561_3 = arg_558_1:GetWordFromCfg(115301133)
			local var_561_4 = arg_558_1:FormatText(var_561_3.content)
			local var_561_5, var_561_6 = arg_558_1:GetPercentByPara(var_561_4, 6)

			if var_561_0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0

				local var_561_7 = var_561_1 <= 0 and var_561_2 or var_561_2 * ((var_561_6 - arg_558_1.typewritterCharCountI18N) / var_561_1)

				if var_561_7 > 0 and var_561_2 < var_561_7 then
					arg_558_1.talkMaxDuration = var_561_7

					if var_561_7 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_7 + var_561_0
					end
				end
			end

			local var_561_8 = 1.06666666666667
			local var_561_9 = math.max(var_561_8, arg_558_1.talkMaxDuration)

			if var_561_0 <= arg_558_1.time_ and arg_558_1.time_ < var_561_0 + var_561_9 then
				local var_561_10 = (arg_558_1.time_ - var_561_0) / var_561_9

				arg_558_1.fswtw_.percent = Mathf.Lerp(arg_558_1.var_.oldValueTypewriter, var_561_5, var_561_10)
				arg_558_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_558_1.fswtw_:SetDirty()
			end

			if arg_558_1.time_ >= var_561_0 + var_561_9 and arg_558_1.time_ < var_561_0 + var_561_9 + arg_561_0 then
				arg_558_1.fswtw_.percent = var_561_5

				arg_558_1.fswtw_:SetDirty()
				arg_558_1:ShowNextGo(true)

				arg_558_1.typewritterCharCountI18N = var_561_6
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play115301139 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 115301139
		arg_562_1.duration_ = 1.4

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play115301140(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.var_.oldValueTypewriter = arg_562_1.fswtw_.percent

				SetActive(arg_562_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_562_1:ShowNextGo(false)
			end

			local var_565_1 = 21
			local var_565_2 = 1.4
			local var_565_3 = arg_562_1:GetWordFromCfg(115301133)
			local var_565_4 = arg_562_1:FormatText(var_565_3.content)
			local var_565_5, var_565_6 = arg_562_1:GetPercentByPara(var_565_4, 7)

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0

				local var_565_7 = var_565_1 <= 0 and var_565_2 or var_565_2 * ((var_565_6 - arg_562_1.typewritterCharCountI18N) / var_565_1)

				if var_565_7 > 0 and var_565_2 < var_565_7 then
					arg_562_1.talkMaxDuration = var_565_7

					if var_565_7 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_7 + var_565_0
					end
				end
			end

			local var_565_8 = 1.4
			local var_565_9 = math.max(var_565_8, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_9 then
				local var_565_10 = (arg_562_1.time_ - var_565_0) / var_565_9

				arg_562_1.fswtw_.percent = Mathf.Lerp(arg_562_1.var_.oldValueTypewriter, var_565_5, var_565_10)
				arg_562_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_562_1.fswtw_:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_9 and arg_562_1.time_ < var_565_0 + var_565_9 + arg_565_0 then
				arg_562_1.fswtw_.percent = var_565_5

				arg_562_1.fswtw_:SetDirty()
				arg_562_1:ShowNextGo(true)

				arg_562_1.typewritterCharCountI18N = var_565_6
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play115301140 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 115301140
		arg_566_1.duration_ = 8.57

		local var_566_0 = {
			ja = 7.4,
			ko = 8.566,
			zh = 7.766,
			en = 7.933
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play115301141(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = "ST22"

			if arg_566_1.bgs_[var_569_0] == nil then
				local var_569_1 = Object.Instantiate(arg_566_1.paintGo_)

				var_569_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_569_0)
				var_569_1.name = var_569_0
				var_569_1.transform.parent = arg_566_1.stage_.transform
				var_569_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_566_1.bgs_[var_569_0] = var_569_1
			end

			local var_569_2 = 2

			if var_569_2 < arg_566_1.time_ and arg_566_1.time_ <= var_569_2 + arg_569_0 then
				local var_569_3 = manager.ui.mainCamera.transform.localPosition
				local var_569_4 = Vector3.New(0, 0, 10) + Vector3.New(var_569_3.x, var_569_3.y, 0)
				local var_569_5 = arg_566_1.bgs_.ST22

				var_569_5.transform.localPosition = var_569_4
				var_569_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_569_6 = var_569_5:GetComponent("SpriteRenderer")

				if var_569_6 and var_569_6.sprite then
					local var_569_7 = (var_569_5.transform.localPosition - var_569_3).z
					local var_569_8 = manager.ui.mainCameraCom_
					local var_569_9 = 2 * var_569_7 * Mathf.Tan(var_569_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_569_10 = var_569_9 * var_569_8.aspect
					local var_569_11 = var_569_6.sprite.bounds.size.x
					local var_569_12 = var_569_6.sprite.bounds.size.y
					local var_569_13 = var_569_10 / var_569_11
					local var_569_14 = var_569_9 / var_569_12
					local var_569_15 = var_569_14 < var_569_13 and var_569_13 or var_569_14

					var_569_5.transform.localScale = Vector3.New(var_569_15, var_569_15, 0)
				end

				for iter_569_0, iter_569_1 in pairs(arg_566_1.bgs_) do
					if iter_569_0 ~= "ST22" then
						iter_569_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_569_16 = 2

			if var_569_16 < arg_566_1.time_ and arg_566_1.time_ <= var_569_16 + arg_569_0 then
				arg_566_1.mask_.enabled = true
				arg_566_1.mask_.raycastTarget = false

				arg_566_1:SetGaussion(false)
			end

			local var_569_17 = 2

			if var_569_16 <= arg_566_1.time_ and arg_566_1.time_ < var_569_16 + var_569_17 then
				local var_569_18 = (arg_566_1.time_ - var_569_16) / var_569_17
				local var_569_19 = Color.New(0, 0, 0)

				var_569_19.a = Mathf.Lerp(1, 0, var_569_18)
				arg_566_1.mask_.color = var_569_19
			end

			if arg_566_1.time_ >= var_569_16 + var_569_17 and arg_566_1.time_ < var_569_16 + var_569_17 + arg_569_0 then
				local var_569_20 = Color.New(0, 0, 0)
				local var_569_21 = 0

				arg_566_1.mask_.enabled = false
				var_569_20.a = var_569_21
				arg_566_1.mask_.color = var_569_20
			end

			local var_569_22 = 0

			if var_569_22 < arg_566_1.time_ and arg_566_1.time_ <= var_569_22 + arg_569_0 then
				arg_566_1.fswbg_:SetActive(false)
				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_566_1:ShowNextGo(false)
			end

			local var_569_23 = 0

			if var_569_23 < arg_566_1.time_ and arg_566_1.time_ <= var_569_23 + arg_569_0 then
				arg_566_1.allBtn_.enabled = false
			end

			local var_569_24 = 4

			if arg_566_1.time_ >= var_569_23 + var_569_24 and arg_566_1.time_ < var_569_23 + var_569_24 + arg_569_0 then
				arg_566_1.allBtn_.enabled = true
			end

			if arg_566_1.frameCnt_ <= 1 then
				arg_566_1.dialog_:SetActive(false)
			end

			local var_569_25 = 4
			local var_569_26 = 0.3

			if var_569_25 < arg_566_1.time_ and arg_566_1.time_ <= var_569_25 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0

				arg_566_1.dialog_:SetActive(true)

				arg_566_1.dialogCg_.alpha = 0

				local var_569_27 = LeanTween.value(arg_566_1.dialog_, 0, 1, 0.3)

				var_569_27:setOnUpdate(LuaHelper.FloatAction(function(arg_570_0)
					arg_566_1.dialogCg_.alpha = arg_570_0
				end))
				var_569_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_566_1.dialog_)
					var_569_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_566_1.duration_ = arg_566_1.duration_ + 0.3

				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_28 = arg_566_1:FormatText(StoryNameCfg[306].name)

				arg_566_1.leftNameTxt_.text = var_569_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_29 = arg_566_1:GetWordFromCfg(115301140)
				local var_569_30 = arg_566_1:FormatText(var_569_29.content)

				arg_566_1.text_.text = var_569_30

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_31 = 12
				local var_569_32 = utf8.len(var_569_30)
				local var_569_33 = var_569_31 <= 0 and var_569_26 or var_569_26 * (var_569_32 / var_569_31)

				if var_569_33 > 0 and var_569_26 < var_569_33 then
					arg_566_1.talkMaxDuration = var_569_33
					var_569_25 = var_569_25 + 0.3

					if var_569_33 + var_569_25 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_33 + var_569_25
					end
				end

				arg_566_1.text_.text = var_569_30
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301140", "story_v_out_115301.awb") ~= 0 then
					local var_569_34 = manager.audio:GetVoiceLength("story_v_out_115301", "115301140", "story_v_out_115301.awb") / 1000

					if var_569_34 + var_569_25 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_34 + var_569_25
					end

					if var_569_29.prefab_name ~= "" and arg_566_1.actors_[var_569_29.prefab_name] ~= nil then
						local var_569_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_29.prefab_name].transform, "story_v_out_115301", "115301140", "story_v_out_115301.awb")

						arg_566_1:RecordAudio("115301140", var_569_35)
						arg_566_1:RecordAudio("115301140", var_569_35)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_115301", "115301140", "story_v_out_115301.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_115301", "115301140", "story_v_out_115301.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_36 = var_569_25 + 0.3
			local var_569_37 = math.max(var_569_26, arg_566_1.talkMaxDuration)

			if var_569_36 <= arg_566_1.time_ and arg_566_1.time_ < var_569_36 + var_569_37 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_36) / var_569_37

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_36 + var_569_37 and arg_566_1.time_ < var_569_36 + var_569_37 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play115301141 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 115301141
		arg_572_1.duration_ = 5.5

		local var_572_0 = {
			ja = 3.333,
			ko = 5.5,
			zh = 3.5,
			en = 3.7
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play115301142(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0
			local var_575_1 = 0.3

			if var_575_0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_2 = arg_572_1:FormatText(StoryNameCfg[306].name)

				arg_572_1.leftNameTxt_.text = var_575_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_3 = arg_572_1:GetWordFromCfg(115301141)
				local var_575_4 = arg_572_1:FormatText(var_575_3.content)

				arg_572_1.text_.text = var_575_4

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_5 = 12
				local var_575_6 = utf8.len(var_575_4)
				local var_575_7 = var_575_5 <= 0 and var_575_1 or var_575_1 * (var_575_6 / var_575_5)

				if var_575_7 > 0 and var_575_1 < var_575_7 then
					arg_572_1.talkMaxDuration = var_575_7

					if var_575_7 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_7 + var_575_0
					end
				end

				arg_572_1.text_.text = var_575_4
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301141", "story_v_out_115301.awb") ~= 0 then
					local var_575_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301141", "story_v_out_115301.awb") / 1000

					if var_575_8 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_8 + var_575_0
					end

					if var_575_3.prefab_name ~= "" and arg_572_1.actors_[var_575_3.prefab_name] ~= nil then
						local var_575_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_3.prefab_name].transform, "story_v_out_115301", "115301141", "story_v_out_115301.awb")

						arg_572_1:RecordAudio("115301141", var_575_9)
						arg_572_1:RecordAudio("115301141", var_575_9)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_115301", "115301141", "story_v_out_115301.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_115301", "115301141", "story_v_out_115301.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_10 = math.max(var_575_1, arg_572_1.talkMaxDuration)

			if var_575_0 <= arg_572_1.time_ and arg_572_1.time_ < var_575_0 + var_575_10 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_0) / var_575_10

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_0 + var_575_10 and arg_572_1.time_ < var_575_0 + var_575_10 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play115301142 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 115301142
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play115301143(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 0
			local var_579_1 = 1.425

			if var_579_0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_2 = arg_576_1:GetWordFromCfg(115301142)
				local var_579_3 = arg_576_1:FormatText(var_579_2.content)

				arg_576_1.text_.text = var_579_3

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_4 = 57
				local var_579_5 = utf8.len(var_579_3)
				local var_579_6 = var_579_4 <= 0 and var_579_1 or var_579_1 * (var_579_5 / var_579_4)

				if var_579_6 > 0 and var_579_1 < var_579_6 then
					arg_576_1.talkMaxDuration = var_579_6

					if var_579_6 + var_579_0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_6 + var_579_0
					end
				end

				arg_576_1.text_.text = var_579_3
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_7 = math.max(var_579_1, arg_576_1.talkMaxDuration)

			if var_579_0 <= arg_576_1.time_ and arg_576_1.time_ < var_579_0 + var_579_7 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_0) / var_579_7

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_0 + var_579_7 and arg_576_1.time_ < var_579_0 + var_579_7 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play115301143 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 115301143
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play115301144(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = 0
			local var_583_1 = 1.15

			if var_583_0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_0 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, false)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_2 = arg_580_1:GetWordFromCfg(115301143)
				local var_583_3 = arg_580_1:FormatText(var_583_2.content)

				arg_580_1.text_.text = var_583_3

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_4 = 46
				local var_583_5 = utf8.len(var_583_3)
				local var_583_6 = var_583_4 <= 0 and var_583_1 or var_583_1 * (var_583_5 / var_583_4)

				if var_583_6 > 0 and var_583_1 < var_583_6 then
					arg_580_1.talkMaxDuration = var_583_6

					if var_583_6 + var_583_0 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_6 + var_583_0
					end
				end

				arg_580_1.text_.text = var_583_3
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_7 = math.max(var_583_1, arg_580_1.talkMaxDuration)

			if var_583_0 <= arg_580_1.time_ and arg_580_1.time_ < var_583_0 + var_583_7 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_0) / var_583_7

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_0 + var_583_7 and arg_580_1.time_ < var_583_0 + var_583_7 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play115301144 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 115301144
		arg_584_1.duration_ = 5

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play115301145(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 0
			local var_587_1 = 0.925

			if var_587_0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_0 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, false)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_2 = arg_584_1:GetWordFromCfg(115301144)
				local var_587_3 = arg_584_1:FormatText(var_587_2.content)

				arg_584_1.text_.text = var_587_3

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_4 = 37
				local var_587_5 = utf8.len(var_587_3)
				local var_587_6 = var_587_4 <= 0 and var_587_1 or var_587_1 * (var_587_5 / var_587_4)

				if var_587_6 > 0 and var_587_1 < var_587_6 then
					arg_584_1.talkMaxDuration = var_587_6

					if var_587_6 + var_587_0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_6 + var_587_0
					end
				end

				arg_584_1.text_.text = var_587_3
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)
				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_7 = math.max(var_587_1, arg_584_1.talkMaxDuration)

			if var_587_0 <= arg_584_1.time_ and arg_584_1.time_ < var_587_0 + var_587_7 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_0) / var_587_7

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_0 + var_587_7 and arg_584_1.time_ < var_587_0 + var_587_7 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play115301145 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 115301145
		arg_588_1.duration_ = 4.3

		local var_588_0 = {
			ja = 4.1,
			ko = 3.333,
			zh = 2.1,
			en = 4.3
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play115301146(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = arg_588_1.actors_["10030"].transform
			local var_591_1 = 0

			if var_591_1 < arg_588_1.time_ and arg_588_1.time_ <= var_591_1 + arg_591_0 then
				arg_588_1.var_.moveOldPos10030 = var_591_0.localPosition
				var_591_0.localScale = Vector3.New(1, 1, 1)

				arg_588_1:CheckSpriteTmpPos("10030", 3)

				local var_591_2 = var_591_0.childCount

				for iter_591_0 = 0, var_591_2 - 1 do
					local var_591_3 = var_591_0:GetChild(iter_591_0)

					if var_591_3.name == "split_1" or not string.find(var_591_3.name, "split") then
						var_591_3.gameObject:SetActive(true)
					else
						var_591_3.gameObject:SetActive(false)
					end
				end
			end

			local var_591_4 = 0.001

			if var_591_1 <= arg_588_1.time_ and arg_588_1.time_ < var_591_1 + var_591_4 then
				local var_591_5 = (arg_588_1.time_ - var_591_1) / var_591_4
				local var_591_6 = Vector3.New(0, -390, 150)

				var_591_0.localPosition = Vector3.Lerp(arg_588_1.var_.moveOldPos10030, var_591_6, var_591_5)
			end

			if arg_588_1.time_ >= var_591_1 + var_591_4 and arg_588_1.time_ < var_591_1 + var_591_4 + arg_591_0 then
				var_591_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_591_7 = arg_588_1.actors_["10030"]
			local var_591_8 = 0

			if var_591_8 < arg_588_1.time_ and arg_588_1.time_ <= var_591_8 + arg_591_0 and not isNil(var_591_7) and arg_588_1.var_.actorSpriteComps10030 == nil then
				arg_588_1.var_.actorSpriteComps10030 = var_591_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_591_9 = 0.2

			if var_591_8 <= arg_588_1.time_ and arg_588_1.time_ < var_591_8 + var_591_9 and not isNil(var_591_7) then
				local var_591_10 = (arg_588_1.time_ - var_591_8) / var_591_9

				if arg_588_1.var_.actorSpriteComps10030 then
					for iter_591_1, iter_591_2 in pairs(arg_588_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_591_2 then
							if arg_588_1.isInRecall_ then
								local var_591_11 = Mathf.Lerp(iter_591_2.color.r, arg_588_1.hightColor1.r, var_591_10)
								local var_591_12 = Mathf.Lerp(iter_591_2.color.g, arg_588_1.hightColor1.g, var_591_10)
								local var_591_13 = Mathf.Lerp(iter_591_2.color.b, arg_588_1.hightColor1.b, var_591_10)

								iter_591_2.color = Color.New(var_591_11, var_591_12, var_591_13)
							else
								local var_591_14 = Mathf.Lerp(iter_591_2.color.r, 1, var_591_10)

								iter_591_2.color = Color.New(var_591_14, var_591_14, var_591_14)
							end
						end
					end
				end
			end

			if arg_588_1.time_ >= var_591_8 + var_591_9 and arg_588_1.time_ < var_591_8 + var_591_9 + arg_591_0 and not isNil(var_591_7) and arg_588_1.var_.actorSpriteComps10030 then
				for iter_591_3, iter_591_4 in pairs(arg_588_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_591_4 then
						if arg_588_1.isInRecall_ then
							iter_591_4.color = arg_588_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_591_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_588_1.var_.actorSpriteComps10030 = nil
			end

			local var_591_15 = arg_588_1.actors_["10030"]
			local var_591_16 = 0

			if var_591_16 < arg_588_1.time_ and arg_588_1.time_ <= var_591_16 + arg_591_0 then
				local var_591_17 = var_591_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_591_17 then
					arg_588_1.var_.alphaOldValue10030 = var_591_17.alpha
					arg_588_1.var_.characterEffect10030 = var_591_17
				end

				arg_588_1.var_.alphaOldValue10030 = 0
			end

			local var_591_18 = 0.333333333333333

			if var_591_16 <= arg_588_1.time_ and arg_588_1.time_ < var_591_16 + var_591_18 then
				local var_591_19 = (arg_588_1.time_ - var_591_16) / var_591_18
				local var_591_20 = Mathf.Lerp(arg_588_1.var_.alphaOldValue10030, 1, var_591_19)

				if arg_588_1.var_.characterEffect10030 then
					arg_588_1.var_.characterEffect10030.alpha = var_591_20
				end
			end

			if arg_588_1.time_ >= var_591_16 + var_591_18 and arg_588_1.time_ < var_591_16 + var_591_18 + arg_591_0 and arg_588_1.var_.characterEffect10030 then
				arg_588_1.var_.characterEffect10030.alpha = 1
			end

			local var_591_21 = 0
			local var_591_22 = 0.25

			if var_591_21 < arg_588_1.time_ and arg_588_1.time_ <= var_591_21 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				local var_591_23 = arg_588_1:FormatText(StoryNameCfg[309].name)

				arg_588_1.leftNameTxt_.text = var_591_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_24 = arg_588_1:GetWordFromCfg(115301145)
				local var_591_25 = arg_588_1:FormatText(var_591_24.content)

				arg_588_1.text_.text = var_591_25

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_26 = 10
				local var_591_27 = utf8.len(var_591_25)
				local var_591_28 = var_591_26 <= 0 and var_591_22 or var_591_22 * (var_591_27 / var_591_26)

				if var_591_28 > 0 and var_591_22 < var_591_28 then
					arg_588_1.talkMaxDuration = var_591_28

					if var_591_28 + var_591_21 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_28 + var_591_21
					end
				end

				arg_588_1.text_.text = var_591_25
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301145", "story_v_out_115301.awb") ~= 0 then
					local var_591_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301145", "story_v_out_115301.awb") / 1000

					if var_591_29 + var_591_21 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_29 + var_591_21
					end

					if var_591_24.prefab_name ~= "" and arg_588_1.actors_[var_591_24.prefab_name] ~= nil then
						local var_591_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_24.prefab_name].transform, "story_v_out_115301", "115301145", "story_v_out_115301.awb")

						arg_588_1:RecordAudio("115301145", var_591_30)
						arg_588_1:RecordAudio("115301145", var_591_30)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_out_115301", "115301145", "story_v_out_115301.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_out_115301", "115301145", "story_v_out_115301.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_31 = math.max(var_591_22, arg_588_1.talkMaxDuration)

			if var_591_21 <= arg_588_1.time_ and arg_588_1.time_ < var_591_21 + var_591_31 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_21) / var_591_31

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_21 + var_591_31 and arg_588_1.time_ < var_591_21 + var_591_31 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_588_1:InitPlayNodeList()
	end,
	Play115301146 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 115301146
		arg_592_1.duration_ = 5

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play115301147(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = arg_592_1.actors_["10030"]
			local var_595_1 = 0

			if var_595_1 < arg_592_1.time_ and arg_592_1.time_ <= var_595_1 + arg_595_0 then
				local var_595_2 = var_595_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_595_2 then
					arg_592_1.var_.alphaOldValue10030 = var_595_2.alpha
					arg_592_1.var_.characterEffect10030 = var_595_2
				end

				arg_592_1.var_.alphaOldValue10030 = 1
			end

			local var_595_3 = 0.333333333333333

			if var_595_1 <= arg_592_1.time_ and arg_592_1.time_ < var_595_1 + var_595_3 then
				local var_595_4 = (arg_592_1.time_ - var_595_1) / var_595_3
				local var_595_5 = Mathf.Lerp(arg_592_1.var_.alphaOldValue10030, 0, var_595_4)

				if arg_592_1.var_.characterEffect10030 then
					arg_592_1.var_.characterEffect10030.alpha = var_595_5
				end
			end

			if arg_592_1.time_ >= var_595_1 + var_595_3 and arg_592_1.time_ < var_595_1 + var_595_3 + arg_595_0 and arg_592_1.var_.characterEffect10030 then
				arg_592_1.var_.characterEffect10030.alpha = 0
			end

			local var_595_6 = 0
			local var_595_7 = 0.7

			if var_595_6 < arg_592_1.time_ and arg_592_1.time_ <= var_595_6 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, false)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_8 = arg_592_1:GetWordFromCfg(115301146)
				local var_595_9 = arg_592_1:FormatText(var_595_8.content)

				arg_592_1.text_.text = var_595_9

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_10 = 28
				local var_595_11 = utf8.len(var_595_9)
				local var_595_12 = var_595_10 <= 0 and var_595_7 or var_595_7 * (var_595_11 / var_595_10)

				if var_595_12 > 0 and var_595_7 < var_595_12 then
					arg_592_1.talkMaxDuration = var_595_12

					if var_595_12 + var_595_6 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_12 + var_595_6
					end
				end

				arg_592_1.text_.text = var_595_9
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)
				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_13 = math.max(var_595_7, arg_592_1.talkMaxDuration)

			if var_595_6 <= arg_592_1.time_ and arg_592_1.time_ < var_595_6 + var_595_13 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_6) / var_595_13

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_6 + var_595_13 and arg_592_1.time_ < var_595_6 + var_595_13 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play115301147 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 115301147
		arg_596_1.duration_ = 8

		local var_596_0 = {
			ja = 8,
			ko = 4.966,
			zh = 5.266,
			en = 4.9
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play115301148(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = arg_596_1.actors_["10030"].transform
			local var_599_1 = 0

			if var_599_1 < arg_596_1.time_ and arg_596_1.time_ <= var_599_1 + arg_599_0 then
				arg_596_1.var_.moveOldPos10030 = var_599_0.localPosition
				var_599_0.localScale = Vector3.New(1, 1, 1)

				arg_596_1:CheckSpriteTmpPos("10030", 3)

				local var_599_2 = var_599_0.childCount

				for iter_599_0 = 0, var_599_2 - 1 do
					local var_599_3 = var_599_0:GetChild(iter_599_0)

					if var_599_3.name == "split_3" or not string.find(var_599_3.name, "split") then
						var_599_3.gameObject:SetActive(true)
					else
						var_599_3.gameObject:SetActive(false)
					end
				end
			end

			local var_599_4 = 0.001

			if var_599_1 <= arg_596_1.time_ and arg_596_1.time_ < var_599_1 + var_599_4 then
				local var_599_5 = (arg_596_1.time_ - var_599_1) / var_599_4
				local var_599_6 = Vector3.New(0, -390, 150)

				var_599_0.localPosition = Vector3.Lerp(arg_596_1.var_.moveOldPos10030, var_599_6, var_599_5)
			end

			if arg_596_1.time_ >= var_599_1 + var_599_4 and arg_596_1.time_ < var_599_1 + var_599_4 + arg_599_0 then
				var_599_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_599_7 = arg_596_1.actors_["10030"]
			local var_599_8 = 0

			if var_599_8 < arg_596_1.time_ and arg_596_1.time_ <= var_599_8 + arg_599_0 then
				local var_599_9 = var_599_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_599_9 then
					arg_596_1.var_.alphaOldValue10030 = var_599_9.alpha
					arg_596_1.var_.characterEffect10030 = var_599_9
				end

				arg_596_1.var_.alphaOldValue10030 = 0
			end

			local var_599_10 = 0.333333333333333

			if var_599_8 <= arg_596_1.time_ and arg_596_1.time_ < var_599_8 + var_599_10 then
				local var_599_11 = (arg_596_1.time_ - var_599_8) / var_599_10
				local var_599_12 = Mathf.Lerp(arg_596_1.var_.alphaOldValue10030, 1, var_599_11)

				if arg_596_1.var_.characterEffect10030 then
					arg_596_1.var_.characterEffect10030.alpha = var_599_12
				end
			end

			if arg_596_1.time_ >= var_599_8 + var_599_10 and arg_596_1.time_ < var_599_8 + var_599_10 + arg_599_0 and arg_596_1.var_.characterEffect10030 then
				arg_596_1.var_.characterEffect10030.alpha = 1
			end

			local var_599_13 = 0
			local var_599_14 = 0.45

			if var_599_13 < arg_596_1.time_ and arg_596_1.time_ <= var_599_13 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_15 = arg_596_1:FormatText(StoryNameCfg[309].name)

				arg_596_1.leftNameTxt_.text = var_599_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_16 = arg_596_1:GetWordFromCfg(115301147)
				local var_599_17 = arg_596_1:FormatText(var_599_16.content)

				arg_596_1.text_.text = var_599_17

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_18 = 18
				local var_599_19 = utf8.len(var_599_17)
				local var_599_20 = var_599_18 <= 0 and var_599_14 or var_599_14 * (var_599_19 / var_599_18)

				if var_599_20 > 0 and var_599_14 < var_599_20 then
					arg_596_1.talkMaxDuration = var_599_20

					if var_599_20 + var_599_13 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_20 + var_599_13
					end
				end

				arg_596_1.text_.text = var_599_17
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301147", "story_v_out_115301.awb") ~= 0 then
					local var_599_21 = manager.audio:GetVoiceLength("story_v_out_115301", "115301147", "story_v_out_115301.awb") / 1000

					if var_599_21 + var_599_13 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_21 + var_599_13
					end

					if var_599_16.prefab_name ~= "" and arg_596_1.actors_[var_599_16.prefab_name] ~= nil then
						local var_599_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_16.prefab_name].transform, "story_v_out_115301", "115301147", "story_v_out_115301.awb")

						arg_596_1:RecordAudio("115301147", var_599_22)
						arg_596_1:RecordAudio("115301147", var_599_22)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_out_115301", "115301147", "story_v_out_115301.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_out_115301", "115301147", "story_v_out_115301.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_23 = math.max(var_599_14, arg_596_1.talkMaxDuration)

			if var_599_13 <= arg_596_1.time_ and arg_596_1.time_ < var_599_13 + var_599_23 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_13) / var_599_23

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_13 + var_599_23 and arg_596_1.time_ < var_599_13 + var_599_23 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_596_1:InitPlayNodeList()
	end,
	Play115301148 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 115301148
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play115301149(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = arg_600_1.actors_["10030"]
			local var_603_1 = 0

			if var_603_1 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 then
				local var_603_2 = var_603_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_603_2 then
					arg_600_1.var_.alphaOldValue10030 = var_603_2.alpha
					arg_600_1.var_.characterEffect10030 = var_603_2
				end

				arg_600_1.var_.alphaOldValue10030 = 1
			end

			local var_603_3 = 0.333333333333333

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_3 then
				local var_603_4 = (arg_600_1.time_ - var_603_1) / var_603_3
				local var_603_5 = Mathf.Lerp(arg_600_1.var_.alphaOldValue10030, 0, var_603_4)

				if arg_600_1.var_.characterEffect10030 then
					arg_600_1.var_.characterEffect10030.alpha = var_603_5
				end
			end

			if arg_600_1.time_ >= var_603_1 + var_603_3 and arg_600_1.time_ < var_603_1 + var_603_3 + arg_603_0 and arg_600_1.var_.characterEffect10030 then
				arg_600_1.var_.characterEffect10030.alpha = 0
			end

			local var_603_6 = 0
			local var_603_7 = 0.75

			if var_603_6 < arg_600_1.time_ and arg_600_1.time_ <= var_603_6 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, false)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_8 = arg_600_1:GetWordFromCfg(115301148)
				local var_603_9 = arg_600_1:FormatText(var_603_8.content)

				arg_600_1.text_.text = var_603_9

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_10 = 30
				local var_603_11 = utf8.len(var_603_9)
				local var_603_12 = var_603_10 <= 0 and var_603_7 or var_603_7 * (var_603_11 / var_603_10)

				if var_603_12 > 0 and var_603_7 < var_603_12 then
					arg_600_1.talkMaxDuration = var_603_12

					if var_603_12 + var_603_6 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_12 + var_603_6
					end
				end

				arg_600_1.text_.text = var_603_9
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_13 = math.max(var_603_7, arg_600_1.talkMaxDuration)

			if var_603_6 <= arg_600_1.time_ and arg_600_1.time_ < var_603_6 + var_603_13 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_6) / var_603_13

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_6 + var_603_13 and arg_600_1.time_ < var_603_6 + var_603_13 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play115301149 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 115301149
		arg_604_1.duration_ = 3.4

		local var_604_0 = {
			ja = 3.4,
			ko = 1.9,
			zh = 1.666,
			en = 2.866
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play115301150(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = arg_604_1.actors_["10030"].transform
			local var_607_1 = 0

			if var_607_1 < arg_604_1.time_ and arg_604_1.time_ <= var_607_1 + arg_607_0 then
				arg_604_1.var_.moveOldPos10030 = var_607_0.localPosition
				var_607_0.localScale = Vector3.New(1, 1, 1)

				arg_604_1:CheckSpriteTmpPos("10030", 3)

				local var_607_2 = var_607_0.childCount

				for iter_607_0 = 0, var_607_2 - 1 do
					local var_607_3 = var_607_0:GetChild(iter_607_0)

					if var_607_3.name == "split_3" or not string.find(var_607_3.name, "split") then
						var_607_3.gameObject:SetActive(true)
					else
						var_607_3.gameObject:SetActive(false)
					end
				end
			end

			local var_607_4 = 0.001

			if var_607_1 <= arg_604_1.time_ and arg_604_1.time_ < var_607_1 + var_607_4 then
				local var_607_5 = (arg_604_1.time_ - var_607_1) / var_607_4
				local var_607_6 = Vector3.New(0, -390, 150)

				var_607_0.localPosition = Vector3.Lerp(arg_604_1.var_.moveOldPos10030, var_607_6, var_607_5)
			end

			if arg_604_1.time_ >= var_607_1 + var_607_4 and arg_604_1.time_ < var_607_1 + var_607_4 + arg_607_0 then
				var_607_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_607_7 = arg_604_1.actors_["10030"]
			local var_607_8 = 0

			if var_607_8 < arg_604_1.time_ and arg_604_1.time_ <= var_607_8 + arg_607_0 then
				local var_607_9 = var_607_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_607_9 then
					arg_604_1.var_.alphaOldValue10030 = var_607_9.alpha
					arg_604_1.var_.characterEffect10030 = var_607_9
				end

				arg_604_1.var_.alphaOldValue10030 = 0
			end

			local var_607_10 = 0.333333333333333

			if var_607_8 <= arg_604_1.time_ and arg_604_1.time_ < var_607_8 + var_607_10 then
				local var_607_11 = (arg_604_1.time_ - var_607_8) / var_607_10
				local var_607_12 = Mathf.Lerp(arg_604_1.var_.alphaOldValue10030, 1, var_607_11)

				if arg_604_1.var_.characterEffect10030 then
					arg_604_1.var_.characterEffect10030.alpha = var_607_12
				end
			end

			if arg_604_1.time_ >= var_607_8 + var_607_10 and arg_604_1.time_ < var_607_8 + var_607_10 + arg_607_0 and arg_604_1.var_.characterEffect10030 then
				arg_604_1.var_.characterEffect10030.alpha = 1
			end

			local var_607_13 = 0
			local var_607_14 = 0.15

			if var_607_13 < arg_604_1.time_ and arg_604_1.time_ <= var_607_13 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_15 = arg_604_1:FormatText(StoryNameCfg[309].name)

				arg_604_1.leftNameTxt_.text = var_607_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_16 = arg_604_1:GetWordFromCfg(115301149)
				local var_607_17 = arg_604_1:FormatText(var_607_16.content)

				arg_604_1.text_.text = var_607_17

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_18 = 6
				local var_607_19 = utf8.len(var_607_17)
				local var_607_20 = var_607_18 <= 0 and var_607_14 or var_607_14 * (var_607_19 / var_607_18)

				if var_607_20 > 0 and var_607_14 < var_607_20 then
					arg_604_1.talkMaxDuration = var_607_20

					if var_607_20 + var_607_13 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_20 + var_607_13
					end
				end

				arg_604_1.text_.text = var_607_17
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301149", "story_v_out_115301.awb") ~= 0 then
					local var_607_21 = manager.audio:GetVoiceLength("story_v_out_115301", "115301149", "story_v_out_115301.awb") / 1000

					if var_607_21 + var_607_13 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_21 + var_607_13
					end

					if var_607_16.prefab_name ~= "" and arg_604_1.actors_[var_607_16.prefab_name] ~= nil then
						local var_607_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_16.prefab_name].transform, "story_v_out_115301", "115301149", "story_v_out_115301.awb")

						arg_604_1:RecordAudio("115301149", var_607_22)
						arg_604_1:RecordAudio("115301149", var_607_22)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_115301", "115301149", "story_v_out_115301.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_115301", "115301149", "story_v_out_115301.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_23 = math.max(var_607_14, arg_604_1.talkMaxDuration)

			if var_607_13 <= arg_604_1.time_ and arg_604_1.time_ < var_607_13 + var_607_23 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_13) / var_607_23

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_13 + var_607_23 and arg_604_1.time_ < var_607_13 + var_607_23 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_604_1:InitPlayNodeList()
	end,
	Play115301150 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 115301150
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play115301151(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = arg_608_1.actors_["10030"]
			local var_611_1 = 0

			if var_611_1 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 then
				local var_611_2 = var_611_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_611_2 then
					arg_608_1.var_.alphaOldValue10030 = var_611_2.alpha
					arg_608_1.var_.characterEffect10030 = var_611_2
				end

				arg_608_1.var_.alphaOldValue10030 = 1
			end

			local var_611_3 = 0.333333333333333

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_3 then
				local var_611_4 = (arg_608_1.time_ - var_611_1) / var_611_3
				local var_611_5 = Mathf.Lerp(arg_608_1.var_.alphaOldValue10030, 0, var_611_4)

				if arg_608_1.var_.characterEffect10030 then
					arg_608_1.var_.characterEffect10030.alpha = var_611_5
				end
			end

			if arg_608_1.time_ >= var_611_1 + var_611_3 and arg_608_1.time_ < var_611_1 + var_611_3 + arg_611_0 and arg_608_1.var_.characterEffect10030 then
				arg_608_1.var_.characterEffect10030.alpha = 0
			end

			local var_611_6 = 0
			local var_611_7 = 0.875

			if var_611_6 < arg_608_1.time_ and arg_608_1.time_ <= var_611_6 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, false)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_8 = arg_608_1:GetWordFromCfg(115301150)
				local var_611_9 = arg_608_1:FormatText(var_611_8.content)

				arg_608_1.text_.text = var_611_9

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_10 = 35
				local var_611_11 = utf8.len(var_611_9)
				local var_611_12 = var_611_10 <= 0 and var_611_7 or var_611_7 * (var_611_11 / var_611_10)

				if var_611_12 > 0 and var_611_7 < var_611_12 then
					arg_608_1.talkMaxDuration = var_611_12

					if var_611_12 + var_611_6 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_12 + var_611_6
					end
				end

				arg_608_1.text_.text = var_611_9
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_13 = math.max(var_611_7, arg_608_1.talkMaxDuration)

			if var_611_6 <= arg_608_1.time_ and arg_608_1.time_ < var_611_6 + var_611_13 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_6) / var_611_13

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_6 + var_611_13 and arg_608_1.time_ < var_611_6 + var_611_13 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play115301151 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 115301151
		arg_612_1.duration_ = 5.17

		local var_612_0 = {
			ja = 3.866,
			ko = 5.166,
			zh = 4.6,
			en = 4.466
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play115301152(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = arg_612_1.actors_["10030"].transform
			local var_615_1 = 0

			if var_615_1 < arg_612_1.time_ and arg_612_1.time_ <= var_615_1 + arg_615_0 then
				arg_612_1.var_.moveOldPos10030 = var_615_0.localPosition
				var_615_0.localScale = Vector3.New(1, 1, 1)

				arg_612_1:CheckSpriteTmpPos("10030", 3)

				local var_615_2 = var_615_0.childCount

				for iter_615_0 = 0, var_615_2 - 1 do
					local var_615_3 = var_615_0:GetChild(iter_615_0)

					if var_615_3.name == "split_2" or not string.find(var_615_3.name, "split") then
						var_615_3.gameObject:SetActive(true)
					else
						var_615_3.gameObject:SetActive(false)
					end
				end
			end

			local var_615_4 = 0.001

			if var_615_1 <= arg_612_1.time_ and arg_612_1.time_ < var_615_1 + var_615_4 then
				local var_615_5 = (arg_612_1.time_ - var_615_1) / var_615_4
				local var_615_6 = Vector3.New(0, -390, 150)

				var_615_0.localPosition = Vector3.Lerp(arg_612_1.var_.moveOldPos10030, var_615_6, var_615_5)
			end

			if arg_612_1.time_ >= var_615_1 + var_615_4 and arg_612_1.time_ < var_615_1 + var_615_4 + arg_615_0 then
				var_615_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_615_7 = arg_612_1.actors_["10030"]
			local var_615_8 = 0

			if var_615_8 < arg_612_1.time_ and arg_612_1.time_ <= var_615_8 + arg_615_0 then
				local var_615_9 = var_615_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_615_9 then
					arg_612_1.var_.alphaOldValue10030 = var_615_9.alpha
					arg_612_1.var_.characterEffect10030 = var_615_9
				end

				arg_612_1.var_.alphaOldValue10030 = 0
			end

			local var_615_10 = 0.333333333333333

			if var_615_8 <= arg_612_1.time_ and arg_612_1.time_ < var_615_8 + var_615_10 then
				local var_615_11 = (arg_612_1.time_ - var_615_8) / var_615_10
				local var_615_12 = Mathf.Lerp(arg_612_1.var_.alphaOldValue10030, 1, var_615_11)

				if arg_612_1.var_.characterEffect10030 then
					arg_612_1.var_.characterEffect10030.alpha = var_615_12
				end
			end

			if arg_612_1.time_ >= var_615_8 + var_615_10 and arg_612_1.time_ < var_615_8 + var_615_10 + arg_615_0 and arg_612_1.var_.characterEffect10030 then
				arg_612_1.var_.characterEffect10030.alpha = 1
			end

			local var_615_13 = 0
			local var_615_14 = 0.275

			if var_615_13 < arg_612_1.time_ and arg_612_1.time_ <= var_615_13 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				local var_615_15 = arg_612_1:FormatText(StoryNameCfg[309].name)

				arg_612_1.leftNameTxt_.text = var_615_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_16 = arg_612_1:GetWordFromCfg(115301151)
				local var_615_17 = arg_612_1:FormatText(var_615_16.content)

				arg_612_1.text_.text = var_615_17

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_18 = 11
				local var_615_19 = utf8.len(var_615_17)
				local var_615_20 = var_615_18 <= 0 and var_615_14 or var_615_14 * (var_615_19 / var_615_18)

				if var_615_20 > 0 and var_615_14 < var_615_20 then
					arg_612_1.talkMaxDuration = var_615_20

					if var_615_20 + var_615_13 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_20 + var_615_13
					end
				end

				arg_612_1.text_.text = var_615_17
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301151", "story_v_out_115301.awb") ~= 0 then
					local var_615_21 = manager.audio:GetVoiceLength("story_v_out_115301", "115301151", "story_v_out_115301.awb") / 1000

					if var_615_21 + var_615_13 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_21 + var_615_13
					end

					if var_615_16.prefab_name ~= "" and arg_612_1.actors_[var_615_16.prefab_name] ~= nil then
						local var_615_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_16.prefab_name].transform, "story_v_out_115301", "115301151", "story_v_out_115301.awb")

						arg_612_1:RecordAudio("115301151", var_615_22)
						arg_612_1:RecordAudio("115301151", var_615_22)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_out_115301", "115301151", "story_v_out_115301.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_out_115301", "115301151", "story_v_out_115301.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_23 = math.max(var_615_14, arg_612_1.talkMaxDuration)

			if var_615_13 <= arg_612_1.time_ and arg_612_1.time_ < var_615_13 + var_615_23 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_13) / var_615_23

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_13 + var_615_23 and arg_612_1.time_ < var_615_13 + var_615_23 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_612_1:InitPlayNodeList()
	end,
	Play115301152 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 115301152
		arg_616_1.duration_ = 5

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play115301153(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = arg_616_1.actors_["10030"]
			local var_619_1 = 0

			if var_619_1 < arg_616_1.time_ and arg_616_1.time_ <= var_619_1 + arg_619_0 then
				local var_619_2 = var_619_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_619_2 then
					arg_616_1.var_.alphaOldValue10030 = var_619_2.alpha
					arg_616_1.var_.characterEffect10030 = var_619_2
				end

				arg_616_1.var_.alphaOldValue10030 = 1
			end

			local var_619_3 = 0.333333333333333

			if var_619_1 <= arg_616_1.time_ and arg_616_1.time_ < var_619_1 + var_619_3 then
				local var_619_4 = (arg_616_1.time_ - var_619_1) / var_619_3
				local var_619_5 = Mathf.Lerp(arg_616_1.var_.alphaOldValue10030, 0, var_619_4)

				if arg_616_1.var_.characterEffect10030 then
					arg_616_1.var_.characterEffect10030.alpha = var_619_5
				end
			end

			if arg_616_1.time_ >= var_619_1 + var_619_3 and arg_616_1.time_ < var_619_1 + var_619_3 + arg_619_0 and arg_616_1.var_.characterEffect10030 then
				arg_616_1.var_.characterEffect10030.alpha = 0
			end

			local var_619_6 = 0
			local var_619_7 = 0.8

			if var_619_6 < arg_616_1.time_ and arg_616_1.time_ <= var_619_6 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, false)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_8 = arg_616_1:GetWordFromCfg(115301152)
				local var_619_9 = arg_616_1:FormatText(var_619_8.content)

				arg_616_1.text_.text = var_619_9

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_10 = 32
				local var_619_11 = utf8.len(var_619_9)
				local var_619_12 = var_619_10 <= 0 and var_619_7 or var_619_7 * (var_619_11 / var_619_10)

				if var_619_12 > 0 and var_619_7 < var_619_12 then
					arg_616_1.talkMaxDuration = var_619_12

					if var_619_12 + var_619_6 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_12 + var_619_6
					end
				end

				arg_616_1.text_.text = var_619_9
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_13 = math.max(var_619_7, arg_616_1.talkMaxDuration)

			if var_619_6 <= arg_616_1.time_ and arg_616_1.time_ < var_619_6 + var_619_13 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_6) / var_619_13

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_6 + var_619_13 and arg_616_1.time_ < var_619_6 + var_619_13 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play115301153 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 115301153
		arg_620_1.duration_ = 10.13

		local var_620_0 = {
			ja = 6.3,
			ko = 6.9,
			zh = 8.566,
			en = 10.133
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play115301154(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = "F01a"

			if arg_620_1.bgs_[var_623_0] == nil then
				local var_623_1 = Object.Instantiate(arg_620_1.paintGo_)

				var_623_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_623_0)
				var_623_1.name = var_623_0
				var_623_1.transform.parent = arg_620_1.stage_.transform
				var_623_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_620_1.bgs_[var_623_0] = var_623_1
			end

			local var_623_2 = 2

			if var_623_2 < arg_620_1.time_ and arg_620_1.time_ <= var_623_2 + arg_623_0 then
				local var_623_3 = manager.ui.mainCamera.transform.localPosition
				local var_623_4 = Vector3.New(0, 0, 10) + Vector3.New(var_623_3.x, var_623_3.y, 0)
				local var_623_5 = arg_620_1.bgs_.F01a

				var_623_5.transform.localPosition = var_623_4
				var_623_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_623_6 = var_623_5:GetComponent("SpriteRenderer")

				if var_623_6 and var_623_6.sprite then
					local var_623_7 = (var_623_5.transform.localPosition - var_623_3).z
					local var_623_8 = manager.ui.mainCameraCom_
					local var_623_9 = 2 * var_623_7 * Mathf.Tan(var_623_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_623_10 = var_623_9 * var_623_8.aspect
					local var_623_11 = var_623_6.sprite.bounds.size.x
					local var_623_12 = var_623_6.sprite.bounds.size.y
					local var_623_13 = var_623_10 / var_623_11
					local var_623_14 = var_623_9 / var_623_12
					local var_623_15 = var_623_14 < var_623_13 and var_623_13 or var_623_14

					var_623_5.transform.localScale = Vector3.New(var_623_15, var_623_15, 0)
				end

				for iter_623_0, iter_623_1 in pairs(arg_620_1.bgs_) do
					if iter_623_0 ~= "F01a" then
						iter_623_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_623_16 = 0

			if var_623_16 < arg_620_1.time_ and arg_620_1.time_ <= var_623_16 + arg_623_0 then
				arg_620_1.mask_.enabled = true
				arg_620_1.mask_.raycastTarget = false

				arg_620_1:SetGaussion(false)
			end

			local var_623_17 = 2

			if var_623_16 <= arg_620_1.time_ and arg_620_1.time_ < var_623_16 + var_623_17 then
				local var_623_18 = (arg_620_1.time_ - var_623_16) / var_623_17
				local var_623_19 = Color.New(0, 0, 0)

				var_623_19.a = Mathf.Lerp(0, 1, var_623_18)
				arg_620_1.mask_.color = var_623_19
			end

			if arg_620_1.time_ >= var_623_16 + var_623_17 and arg_620_1.time_ < var_623_16 + var_623_17 + arg_623_0 then
				local var_623_20 = Color.New(0, 0, 0)

				var_623_20.a = 1
				arg_620_1.mask_.color = var_623_20
			end

			local var_623_21 = 2

			if var_623_21 < arg_620_1.time_ and arg_620_1.time_ <= var_623_21 + arg_623_0 then
				arg_620_1.mask_.enabled = true
				arg_620_1.mask_.raycastTarget = false

				arg_620_1:SetGaussion(false)
			end

			local var_623_22 = 2

			if var_623_21 <= arg_620_1.time_ and arg_620_1.time_ < var_623_21 + var_623_22 then
				local var_623_23 = (arg_620_1.time_ - var_623_21) / var_623_22
				local var_623_24 = Color.New(0, 0, 0)

				var_623_24.a = Mathf.Lerp(1, 0, var_623_23)
				arg_620_1.mask_.color = var_623_24
			end

			if arg_620_1.time_ >= var_623_21 + var_623_22 and arg_620_1.time_ < var_623_21 + var_623_22 + arg_623_0 then
				local var_623_25 = Color.New(0, 0, 0)
				local var_623_26 = 0

				arg_620_1.mask_.enabled = false
				var_623_25.a = var_623_26
				arg_620_1.mask_.color = var_623_25
			end

			local var_623_27 = arg_620_1.actors_["1038"].transform
			local var_623_28 = 4

			if var_623_28 < arg_620_1.time_ and arg_620_1.time_ <= var_623_28 + arg_623_0 then
				arg_620_1.var_.moveOldPos1038 = var_623_27.localPosition
				var_623_27.localScale = Vector3.New(1, 1, 1)

				arg_620_1:CheckSpriteTmpPos("1038", 3)

				local var_623_29 = var_623_27.childCount

				for iter_623_2 = 0, var_623_29 - 1 do
					local var_623_30 = var_623_27:GetChild(iter_623_2)

					if var_623_30.name == "split_5" or not string.find(var_623_30.name, "split") then
						var_623_30.gameObject:SetActive(true)
					else
						var_623_30.gameObject:SetActive(false)
					end
				end
			end

			local var_623_31 = 0.001

			if var_623_28 <= arg_620_1.time_ and arg_620_1.time_ < var_623_28 + var_623_31 then
				local var_623_32 = (arg_620_1.time_ - var_623_28) / var_623_31
				local var_623_33 = Vector3.New(0, -400, 0)

				var_623_27.localPosition = Vector3.Lerp(arg_620_1.var_.moveOldPos1038, var_623_33, var_623_32)
			end

			if arg_620_1.time_ >= var_623_28 + var_623_31 and arg_620_1.time_ < var_623_28 + var_623_31 + arg_623_0 then
				var_623_27.localPosition = Vector3.New(0, -400, 0)
			end

			local var_623_34 = 0

			arg_620_1.isInRecall_ = false

			if var_623_34 < arg_620_1.time_ and arg_620_1.time_ <= var_623_34 + arg_623_0 then
				arg_620_1.screenFilterGo_:SetActive(true)

				arg_620_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_623_3, iter_623_4 in pairs(arg_620_1.actors_) do
					local var_623_35 = iter_623_4:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_623_5, iter_623_6 in ipairs(var_623_35) do
						if iter_623_6.color.r > 0.51 then
							iter_623_6.color = Color.New(1, 1, 1)
						else
							iter_623_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_623_36 = 5.5

			if var_623_34 <= arg_620_1.time_ and arg_620_1.time_ < var_623_34 + var_623_36 then
				local var_623_37 = (arg_620_1.time_ - var_623_34) / var_623_36

				arg_620_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_623_37)
			end

			if arg_620_1.time_ >= var_623_34 + var_623_36 and arg_620_1.time_ < var_623_34 + var_623_36 + arg_623_0 then
				arg_620_1.screenFilterEffect_.weight = 1
			end

			local var_623_38 = arg_620_1.actors_["1038"]
			local var_623_39 = 4

			if var_623_39 < arg_620_1.time_ and arg_620_1.time_ <= var_623_39 + arg_623_0 then
				local var_623_40 = var_623_38:GetComponentInChildren(typeof(CanvasGroup))

				if var_623_40 then
					arg_620_1.var_.alphaOldValue1038 = var_623_40.alpha
					arg_620_1.var_.characterEffect1038 = var_623_40
				end

				arg_620_1.var_.alphaOldValue1038 = 0
			end

			local var_623_41 = 0.333333333333333

			if var_623_39 <= arg_620_1.time_ and arg_620_1.time_ < var_623_39 + var_623_41 then
				local var_623_42 = (arg_620_1.time_ - var_623_39) / var_623_41
				local var_623_43 = Mathf.Lerp(arg_620_1.var_.alphaOldValue1038, 1, var_623_42)

				if arg_620_1.var_.characterEffect1038 then
					arg_620_1.var_.characterEffect1038.alpha = var_623_43
				end
			end

			if arg_620_1.time_ >= var_623_39 + var_623_41 and arg_620_1.time_ < var_623_39 + var_623_41 + arg_623_0 and arg_620_1.var_.characterEffect1038 then
				arg_620_1.var_.characterEffect1038.alpha = 1
			end

			if arg_620_1.frameCnt_ <= 1 then
				arg_620_1.dialog_:SetActive(false)
			end

			local var_623_44 = 4
			local var_623_45 = 0.3

			if var_623_44 < arg_620_1.time_ and arg_620_1.time_ <= var_623_44 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0

				arg_620_1.dialog_:SetActive(true)

				arg_620_1.dialogCg_.alpha = 0

				local var_623_46 = LeanTween.value(arg_620_1.dialog_, 0, 1, 0.3)

				var_623_46:setOnUpdate(LuaHelper.FloatAction(function(arg_624_0)
					arg_620_1.dialogCg_.alpha = arg_624_0
				end))
				var_623_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_620_1.dialog_)
					var_623_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_620_1.duration_ = arg_620_1.duration_ + 0.3

				SetActive(arg_620_1.leftNameGo_, true)

				local var_623_47 = arg_620_1:FormatText(StoryNameCfg[94].name)

				arg_620_1.leftNameTxt_.text = var_623_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_48 = arg_620_1:GetWordFromCfg(115301153)
				local var_623_49 = arg_620_1:FormatText(var_623_48.content)

				arg_620_1.text_.text = var_623_49

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_50 = 12
				local var_623_51 = utf8.len(var_623_49)
				local var_623_52 = var_623_50 <= 0 and var_623_45 or var_623_45 * (var_623_51 / var_623_50)

				if var_623_52 > 0 and var_623_45 < var_623_52 then
					arg_620_1.talkMaxDuration = var_623_52
					var_623_44 = var_623_44 + 0.3

					if var_623_52 + var_623_44 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_52 + var_623_44
					end
				end

				arg_620_1.text_.text = var_623_49
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301153", "story_v_out_115301.awb") ~= 0 then
					local var_623_53 = manager.audio:GetVoiceLength("story_v_out_115301", "115301153", "story_v_out_115301.awb") / 1000

					if var_623_53 + var_623_44 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_53 + var_623_44
					end

					if var_623_48.prefab_name ~= "" and arg_620_1.actors_[var_623_48.prefab_name] ~= nil then
						local var_623_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_48.prefab_name].transform, "story_v_out_115301", "115301153", "story_v_out_115301.awb")

						arg_620_1:RecordAudio("115301153", var_623_54)
						arg_620_1:RecordAudio("115301153", var_623_54)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_out_115301", "115301153", "story_v_out_115301.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_out_115301", "115301153", "story_v_out_115301.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_55 = var_623_44 + 0.3
			local var_623_56 = math.max(var_623_45, arg_620_1.talkMaxDuration)

			if var_623_55 <= arg_620_1.time_ and arg_620_1.time_ < var_623_55 + var_623_56 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_55) / var_623_56

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_55 + var_623_56 and arg_620_1.time_ < var_623_55 + var_623_56 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_620_1:InitPlayNodeList()
	end,
	Play115301154 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 115301154
		arg_626_1.duration_ = 6.4

		local var_626_0 = {
			ja = 3.766,
			ko = 5.433,
			zh = 5.833,
			en = 6.4
		}
		local var_626_1 = manager.audio:GetLocalizationFlag()

		if var_626_0[var_626_1] ~= nil then
			arg_626_1.duration_ = var_626_0[var_626_1]
		end

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play115301155(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = arg_626_1.actors_["1038"]
			local var_629_1 = 0

			if var_629_1 < arg_626_1.time_ and arg_626_1.time_ <= var_629_1 + arg_629_0 and not isNil(var_629_0) and arg_626_1.var_.actorSpriteComps1038 == nil then
				arg_626_1.var_.actorSpriteComps1038 = var_629_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_629_2 = 0.2

			if var_629_1 <= arg_626_1.time_ and arg_626_1.time_ < var_629_1 + var_629_2 and not isNil(var_629_0) then
				local var_629_3 = (arg_626_1.time_ - var_629_1) / var_629_2

				if arg_626_1.var_.actorSpriteComps1038 then
					for iter_629_0, iter_629_1 in pairs(arg_626_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_629_1 then
							if arg_626_1.isInRecall_ then
								local var_629_4 = Mathf.Lerp(iter_629_1.color.r, arg_626_1.hightColor2.r, var_629_3)
								local var_629_5 = Mathf.Lerp(iter_629_1.color.g, arg_626_1.hightColor2.g, var_629_3)
								local var_629_6 = Mathf.Lerp(iter_629_1.color.b, arg_626_1.hightColor2.b, var_629_3)

								iter_629_1.color = Color.New(var_629_4, var_629_5, var_629_6)
							else
								local var_629_7 = Mathf.Lerp(iter_629_1.color.r, 0.5, var_629_3)

								iter_629_1.color = Color.New(var_629_7, var_629_7, var_629_7)
							end
						end
					end
				end
			end

			if arg_626_1.time_ >= var_629_1 + var_629_2 and arg_626_1.time_ < var_629_1 + var_629_2 + arg_629_0 and not isNil(var_629_0) and arg_626_1.var_.actorSpriteComps1038 then
				for iter_629_2, iter_629_3 in pairs(arg_626_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_629_3 then
						if arg_626_1.isInRecall_ then
							iter_629_3.color = arg_626_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_629_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_626_1.var_.actorSpriteComps1038 = nil
			end

			local var_629_8 = 0
			local var_629_9 = 0.475

			if var_629_8 < arg_626_1.time_ and arg_626_1.time_ <= var_629_8 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				local var_629_10 = arg_626_1:FormatText(StoryNameCfg[36].name)

				arg_626_1.leftNameTxt_.text = var_629_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_11 = arg_626_1:GetWordFromCfg(115301154)
				local var_629_12 = arg_626_1:FormatText(var_629_11.content)

				arg_626_1.text_.text = var_629_12

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_13 = 19
				local var_629_14 = utf8.len(var_629_12)
				local var_629_15 = var_629_13 <= 0 and var_629_9 or var_629_9 * (var_629_14 / var_629_13)

				if var_629_15 > 0 and var_629_9 < var_629_15 then
					arg_626_1.talkMaxDuration = var_629_15

					if var_629_15 + var_629_8 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_15 + var_629_8
					end
				end

				arg_626_1.text_.text = var_629_12
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301154", "story_v_out_115301.awb") ~= 0 then
					local var_629_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301154", "story_v_out_115301.awb") / 1000

					if var_629_16 + var_629_8 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_16 + var_629_8
					end

					if var_629_11.prefab_name ~= "" and arg_626_1.actors_[var_629_11.prefab_name] ~= nil then
						local var_629_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_11.prefab_name].transform, "story_v_out_115301", "115301154", "story_v_out_115301.awb")

						arg_626_1:RecordAudio("115301154", var_629_17)
						arg_626_1:RecordAudio("115301154", var_629_17)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_out_115301", "115301154", "story_v_out_115301.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_out_115301", "115301154", "story_v_out_115301.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_18 = math.max(var_629_9, arg_626_1.talkMaxDuration)

			if var_629_8 <= arg_626_1.time_ and arg_626_1.time_ < var_629_8 + var_629_18 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - var_629_8) / var_629_18

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= var_629_8 + var_629_18 and arg_626_1.time_ < var_629_8 + var_629_18 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play115301155 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 115301155
		arg_630_1.duration_ = 8.73

		local var_630_0 = {
			ja = 7.666,
			ko = 8.133,
			zh = 8.733,
			en = 8.733
		}
		local var_630_1 = manager.audio:GetLocalizationFlag()

		if var_630_0[var_630_1] ~= nil then
			arg_630_1.duration_ = var_630_0[var_630_1]
		end

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play115301156(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = 0
			local var_633_1 = 0.825

			if var_633_0 < arg_630_1.time_ and arg_630_1.time_ <= var_633_0 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				local var_633_2 = arg_630_1:FormatText(StoryNameCfg[36].name)

				arg_630_1.leftNameTxt_.text = var_633_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_3 = arg_630_1:GetWordFromCfg(115301155)
				local var_633_4 = arg_630_1:FormatText(var_633_3.content)

				arg_630_1.text_.text = var_633_4

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_5 = 33
				local var_633_6 = utf8.len(var_633_4)
				local var_633_7 = var_633_5 <= 0 and var_633_1 or var_633_1 * (var_633_6 / var_633_5)

				if var_633_7 > 0 and var_633_1 < var_633_7 then
					arg_630_1.talkMaxDuration = var_633_7

					if var_633_7 + var_633_0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_7 + var_633_0
					end
				end

				arg_630_1.text_.text = var_633_4
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301155", "story_v_out_115301.awb") ~= 0 then
					local var_633_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301155", "story_v_out_115301.awb") / 1000

					if var_633_8 + var_633_0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_8 + var_633_0
					end

					if var_633_3.prefab_name ~= "" and arg_630_1.actors_[var_633_3.prefab_name] ~= nil then
						local var_633_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_630_1.actors_[var_633_3.prefab_name].transform, "story_v_out_115301", "115301155", "story_v_out_115301.awb")

						arg_630_1:RecordAudio("115301155", var_633_9)
						arg_630_1:RecordAudio("115301155", var_633_9)
					else
						arg_630_1:AudioAction("play", "voice", "story_v_out_115301", "115301155", "story_v_out_115301.awb")
					end

					arg_630_1:RecordHistoryTalkVoice("story_v_out_115301", "115301155", "story_v_out_115301.awb")
				end

				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_10 = math.max(var_633_1, arg_630_1.talkMaxDuration)

			if var_633_0 <= arg_630_1.time_ and arg_630_1.time_ < var_633_0 + var_633_10 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - var_633_0) / var_633_10

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= var_633_0 + var_633_10 and arg_630_1.time_ < var_633_0 + var_633_10 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play115301156 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 115301156
		arg_634_1.duration_ = 4.4

		local var_634_0 = {
			ja = 3.833,
			ko = 3,
			zh = 4.4,
			en = 4.333
		}
		local var_634_1 = manager.audio:GetLocalizationFlag()

		if var_634_0[var_634_1] ~= nil then
			arg_634_1.duration_ = var_634_0[var_634_1]
		end

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play115301157(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			local var_637_0 = arg_634_1.actors_["1038"].transform
			local var_637_1 = 0

			if var_637_1 < arg_634_1.time_ and arg_634_1.time_ <= var_637_1 + arg_637_0 then
				arg_634_1.var_.moveOldPos1038 = var_637_0.localPosition
				var_637_0.localScale = Vector3.New(1, 1, 1)

				arg_634_1:CheckSpriteTmpPos("1038", 3)

				local var_637_2 = var_637_0.childCount

				for iter_637_0 = 0, var_637_2 - 1 do
					local var_637_3 = var_637_0:GetChild(iter_637_0)

					if var_637_3.name == "split_9" or not string.find(var_637_3.name, "split") then
						var_637_3.gameObject:SetActive(true)
					else
						var_637_3.gameObject:SetActive(false)
					end
				end
			end

			local var_637_4 = 0.001

			if var_637_1 <= arg_634_1.time_ and arg_634_1.time_ < var_637_1 + var_637_4 then
				local var_637_5 = (arg_634_1.time_ - var_637_1) / var_637_4
				local var_637_6 = Vector3.New(0, -400, 0)

				var_637_0.localPosition = Vector3.Lerp(arg_634_1.var_.moveOldPos1038, var_637_6, var_637_5)
			end

			if arg_634_1.time_ >= var_637_1 + var_637_4 and arg_634_1.time_ < var_637_1 + var_637_4 + arg_637_0 then
				var_637_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_637_7 = arg_634_1.actors_["1038"]
			local var_637_8 = 0

			if var_637_8 < arg_634_1.time_ and arg_634_1.time_ <= var_637_8 + arg_637_0 then
				local var_637_9 = var_637_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_637_9 then
					arg_634_1.var_.alphaOldValue1038 = var_637_9.alpha
					arg_634_1.var_.characterEffect1038 = var_637_9
				end

				arg_634_1.var_.alphaOldValue1038 = 0
			end

			local var_637_10 = 0.0166666666666667

			if var_637_8 <= arg_634_1.time_ and arg_634_1.time_ < var_637_8 + var_637_10 then
				local var_637_11 = (arg_634_1.time_ - var_637_8) / var_637_10
				local var_637_12 = Mathf.Lerp(arg_634_1.var_.alphaOldValue1038, 1, var_637_11)

				if arg_634_1.var_.characterEffect1038 then
					arg_634_1.var_.characterEffect1038.alpha = var_637_12
				end
			end

			if arg_634_1.time_ >= var_637_8 + var_637_10 and arg_634_1.time_ < var_637_8 + var_637_10 + arg_637_0 and arg_634_1.var_.characterEffect1038 then
				arg_634_1.var_.characterEffect1038.alpha = 1
			end

			local var_637_13 = arg_634_1.actors_["1038"]
			local var_637_14 = 0

			if var_637_14 < arg_634_1.time_ and arg_634_1.time_ <= var_637_14 + arg_637_0 and not isNil(var_637_13) and arg_634_1.var_.actorSpriteComps1038 == nil then
				arg_634_1.var_.actorSpriteComps1038 = var_637_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_637_15 = 0.2

			if var_637_14 <= arg_634_1.time_ and arg_634_1.time_ < var_637_14 + var_637_15 and not isNil(var_637_13) then
				local var_637_16 = (arg_634_1.time_ - var_637_14) / var_637_15

				if arg_634_1.var_.actorSpriteComps1038 then
					for iter_637_1, iter_637_2 in pairs(arg_634_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_637_2 then
							if arg_634_1.isInRecall_ then
								local var_637_17 = Mathf.Lerp(iter_637_2.color.r, arg_634_1.hightColor1.r, var_637_16)
								local var_637_18 = Mathf.Lerp(iter_637_2.color.g, arg_634_1.hightColor1.g, var_637_16)
								local var_637_19 = Mathf.Lerp(iter_637_2.color.b, arg_634_1.hightColor1.b, var_637_16)

								iter_637_2.color = Color.New(var_637_17, var_637_18, var_637_19)
							else
								local var_637_20 = Mathf.Lerp(iter_637_2.color.r, 1, var_637_16)

								iter_637_2.color = Color.New(var_637_20, var_637_20, var_637_20)
							end
						end
					end
				end
			end

			if arg_634_1.time_ >= var_637_14 + var_637_15 and arg_634_1.time_ < var_637_14 + var_637_15 + arg_637_0 and not isNil(var_637_13) and arg_634_1.var_.actorSpriteComps1038 then
				for iter_637_3, iter_637_4 in pairs(arg_634_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_637_4 then
						if arg_634_1.isInRecall_ then
							iter_637_4.color = arg_634_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_637_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_634_1.var_.actorSpriteComps1038 = nil
			end

			local var_637_21 = 0
			local var_637_22 = 0.4

			if var_637_21 < arg_634_1.time_ and arg_634_1.time_ <= var_637_21 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				local var_637_23 = arg_634_1:FormatText(StoryNameCfg[94].name)

				arg_634_1.leftNameTxt_.text = var_637_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, false)
				arg_634_1.callingController_:SetSelectedState("normal")

				local var_637_24 = arg_634_1:GetWordFromCfg(115301156)
				local var_637_25 = arg_634_1:FormatText(var_637_24.content)

				arg_634_1.text_.text = var_637_25

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_26 = 16
				local var_637_27 = utf8.len(var_637_25)
				local var_637_28 = var_637_26 <= 0 and var_637_22 or var_637_22 * (var_637_27 / var_637_26)

				if var_637_28 > 0 and var_637_22 < var_637_28 then
					arg_634_1.talkMaxDuration = var_637_28

					if var_637_28 + var_637_21 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_28 + var_637_21
					end
				end

				arg_634_1.text_.text = var_637_25
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301156", "story_v_out_115301.awb") ~= 0 then
					local var_637_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301156", "story_v_out_115301.awb") / 1000

					if var_637_29 + var_637_21 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_29 + var_637_21
					end

					if var_637_24.prefab_name ~= "" and arg_634_1.actors_[var_637_24.prefab_name] ~= nil then
						local var_637_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_634_1.actors_[var_637_24.prefab_name].transform, "story_v_out_115301", "115301156", "story_v_out_115301.awb")

						arg_634_1:RecordAudio("115301156", var_637_30)
						arg_634_1:RecordAudio("115301156", var_637_30)
					else
						arg_634_1:AudioAction("play", "voice", "story_v_out_115301", "115301156", "story_v_out_115301.awb")
					end

					arg_634_1:RecordHistoryTalkVoice("story_v_out_115301", "115301156", "story_v_out_115301.awb")
				end

				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_31 = math.max(var_637_22, arg_634_1.talkMaxDuration)

			if var_637_21 <= arg_634_1.time_ and arg_634_1.time_ < var_637_21 + var_637_31 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_21) / var_637_31

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_21 + var_637_31 and arg_634_1.time_ < var_637_21 + var_637_31 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_634_1:InitPlayNodeList()
	end,
	Play115301157 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 115301157
		arg_638_1.duration_ = 7.27

		local var_638_0 = {
			ja = 4.4,
			ko = 5.6,
			zh = 5.166,
			en = 7.266
		}
		local var_638_1 = manager.audio:GetLocalizationFlag()

		if var_638_0[var_638_1] ~= nil then
			arg_638_1.duration_ = var_638_0[var_638_1]
		end

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play115301158(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			local var_641_0 = arg_638_1.actors_["1038"]
			local var_641_1 = 0

			if var_641_1 < arg_638_1.time_ and arg_638_1.time_ <= var_641_1 + arg_641_0 and not isNil(var_641_0) and arg_638_1.var_.actorSpriteComps1038 == nil then
				arg_638_1.var_.actorSpriteComps1038 = var_641_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_641_2 = 0.2

			if var_641_1 <= arg_638_1.time_ and arg_638_1.time_ < var_641_1 + var_641_2 and not isNil(var_641_0) then
				local var_641_3 = (arg_638_1.time_ - var_641_1) / var_641_2

				if arg_638_1.var_.actorSpriteComps1038 then
					for iter_641_0, iter_641_1 in pairs(arg_638_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_641_1 then
							if arg_638_1.isInRecall_ then
								local var_641_4 = Mathf.Lerp(iter_641_1.color.r, arg_638_1.hightColor2.r, var_641_3)
								local var_641_5 = Mathf.Lerp(iter_641_1.color.g, arg_638_1.hightColor2.g, var_641_3)
								local var_641_6 = Mathf.Lerp(iter_641_1.color.b, arg_638_1.hightColor2.b, var_641_3)

								iter_641_1.color = Color.New(var_641_4, var_641_5, var_641_6)
							else
								local var_641_7 = Mathf.Lerp(iter_641_1.color.r, 0.5, var_641_3)

								iter_641_1.color = Color.New(var_641_7, var_641_7, var_641_7)
							end
						end
					end
				end
			end

			if arg_638_1.time_ >= var_641_1 + var_641_2 and arg_638_1.time_ < var_641_1 + var_641_2 + arg_641_0 and not isNil(var_641_0) and arg_638_1.var_.actorSpriteComps1038 then
				for iter_641_2, iter_641_3 in pairs(arg_638_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_641_3 then
						if arg_638_1.isInRecall_ then
							iter_641_3.color = arg_638_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_641_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_638_1.var_.actorSpriteComps1038 = nil
			end

			local var_641_8 = 0
			local var_641_9 = 0.525

			if var_641_8 < arg_638_1.time_ and arg_638_1.time_ <= var_641_8 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, true)

				local var_641_10 = arg_638_1:FormatText(StoryNameCfg[36].name)

				arg_638_1.leftNameTxt_.text = var_641_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_638_1.leftNameTxt_.transform)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1.leftNameTxt_.text)
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_11 = arg_638_1:GetWordFromCfg(115301157)
				local var_641_12 = arg_638_1:FormatText(var_641_11.content)

				arg_638_1.text_.text = var_641_12

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_13 = 21
				local var_641_14 = utf8.len(var_641_12)
				local var_641_15 = var_641_13 <= 0 and var_641_9 or var_641_9 * (var_641_14 / var_641_13)

				if var_641_15 > 0 and var_641_9 < var_641_15 then
					arg_638_1.talkMaxDuration = var_641_15

					if var_641_15 + var_641_8 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_15 + var_641_8
					end
				end

				arg_638_1.text_.text = var_641_12
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301157", "story_v_out_115301.awb") ~= 0 then
					local var_641_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301157", "story_v_out_115301.awb") / 1000

					if var_641_16 + var_641_8 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_16 + var_641_8
					end

					if var_641_11.prefab_name ~= "" and arg_638_1.actors_[var_641_11.prefab_name] ~= nil then
						local var_641_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_638_1.actors_[var_641_11.prefab_name].transform, "story_v_out_115301", "115301157", "story_v_out_115301.awb")

						arg_638_1:RecordAudio("115301157", var_641_17)
						arg_638_1:RecordAudio("115301157", var_641_17)
					else
						arg_638_1:AudioAction("play", "voice", "story_v_out_115301", "115301157", "story_v_out_115301.awb")
					end

					arg_638_1:RecordHistoryTalkVoice("story_v_out_115301", "115301157", "story_v_out_115301.awb")
				end

				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_18 = math.max(var_641_9, arg_638_1.talkMaxDuration)

			if var_641_8 <= arg_638_1.time_ and arg_638_1.time_ < var_641_8 + var_641_18 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_8) / var_641_18

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_8 + var_641_18 and arg_638_1.time_ < var_641_8 + var_641_18 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {}

		arg_638_1:InitPlayNodeList()
	end,
	Play115301158 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 115301158
		arg_642_1.duration_ = 16.37

		local var_642_0 = {
			ja = 14.333,
			ko = 11.666,
			zh = 12.7,
			en = 16.366
		}
		local var_642_1 = manager.audio:GetLocalizationFlag()

		if var_642_0[var_642_1] ~= nil then
			arg_642_1.duration_ = var_642_0[var_642_1]
		end

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play115301159(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			local var_645_0 = 0
			local var_645_1 = 1.125

			if var_645_0 < arg_642_1.time_ and arg_642_1.time_ <= var_645_0 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				local var_645_2 = arg_642_1:FormatText(StoryNameCfg[36].name)

				arg_642_1.leftNameTxt_.text = var_645_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, false)
				arg_642_1.callingController_:SetSelectedState("normal")

				local var_645_3 = arg_642_1:GetWordFromCfg(115301158)
				local var_645_4 = arg_642_1:FormatText(var_645_3.content)

				arg_642_1.text_.text = var_645_4

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_5 = 45
				local var_645_6 = utf8.len(var_645_4)
				local var_645_7 = var_645_5 <= 0 and var_645_1 or var_645_1 * (var_645_6 / var_645_5)

				if var_645_7 > 0 and var_645_1 < var_645_7 then
					arg_642_1.talkMaxDuration = var_645_7

					if var_645_7 + var_645_0 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_7 + var_645_0
					end
				end

				arg_642_1.text_.text = var_645_4
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301158", "story_v_out_115301.awb") ~= 0 then
					local var_645_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301158", "story_v_out_115301.awb") / 1000

					if var_645_8 + var_645_0 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_8 + var_645_0
					end

					if var_645_3.prefab_name ~= "" and arg_642_1.actors_[var_645_3.prefab_name] ~= nil then
						local var_645_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_642_1.actors_[var_645_3.prefab_name].transform, "story_v_out_115301", "115301158", "story_v_out_115301.awb")

						arg_642_1:RecordAudio("115301158", var_645_9)
						arg_642_1:RecordAudio("115301158", var_645_9)
					else
						arg_642_1:AudioAction("play", "voice", "story_v_out_115301", "115301158", "story_v_out_115301.awb")
					end

					arg_642_1:RecordHistoryTalkVoice("story_v_out_115301", "115301158", "story_v_out_115301.awb")
				end

				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_10 = math.max(var_645_1, arg_642_1.talkMaxDuration)

			if var_645_0 <= arg_642_1.time_ and arg_642_1.time_ < var_645_0 + var_645_10 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_0) / var_645_10

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_0 + var_645_10 and arg_642_1.time_ < var_645_0 + var_645_10 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {}

		arg_642_1:InitPlayNodeList()
	end,
	Play115301159 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 115301159
		arg_646_1.duration_ = 5.5

		local var_646_0 = {
			ja = 5.5,
			ko = 3.4,
			zh = 4.7,
			en = 3.833
		}
		local var_646_1 = manager.audio:GetLocalizationFlag()

		if var_646_0[var_646_1] ~= nil then
			arg_646_1.duration_ = var_646_0[var_646_1]
		end

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play115301160(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			local var_649_0 = arg_646_1.actors_["1038"]
			local var_649_1 = 0

			if var_649_1 < arg_646_1.time_ and arg_646_1.time_ <= var_649_1 + arg_649_0 and not isNil(var_649_0) and arg_646_1.var_.actorSpriteComps1038 == nil then
				arg_646_1.var_.actorSpriteComps1038 = var_649_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_649_2 = 0.2

			if var_649_1 <= arg_646_1.time_ and arg_646_1.time_ < var_649_1 + var_649_2 and not isNil(var_649_0) then
				local var_649_3 = (arg_646_1.time_ - var_649_1) / var_649_2

				if arg_646_1.var_.actorSpriteComps1038 then
					for iter_649_0, iter_649_1 in pairs(arg_646_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_649_1 then
							if arg_646_1.isInRecall_ then
								local var_649_4 = Mathf.Lerp(iter_649_1.color.r, arg_646_1.hightColor1.r, var_649_3)
								local var_649_5 = Mathf.Lerp(iter_649_1.color.g, arg_646_1.hightColor1.g, var_649_3)
								local var_649_6 = Mathf.Lerp(iter_649_1.color.b, arg_646_1.hightColor1.b, var_649_3)

								iter_649_1.color = Color.New(var_649_4, var_649_5, var_649_6)
							else
								local var_649_7 = Mathf.Lerp(iter_649_1.color.r, 1, var_649_3)

								iter_649_1.color = Color.New(var_649_7, var_649_7, var_649_7)
							end
						end
					end
				end
			end

			if arg_646_1.time_ >= var_649_1 + var_649_2 and arg_646_1.time_ < var_649_1 + var_649_2 + arg_649_0 and not isNil(var_649_0) and arg_646_1.var_.actorSpriteComps1038 then
				for iter_649_2, iter_649_3 in pairs(arg_646_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_649_3 then
						if arg_646_1.isInRecall_ then
							iter_649_3.color = arg_646_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_649_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_646_1.var_.actorSpriteComps1038 = nil
			end

			local var_649_8 = arg_646_1.actors_["1038"].transform
			local var_649_9 = 0

			if var_649_9 < arg_646_1.time_ and arg_646_1.time_ <= var_649_9 + arg_649_0 then
				arg_646_1.var_.moveOldPos1038 = var_649_8.localPosition
				var_649_8.localScale = Vector3.New(1, 1, 1)

				arg_646_1:CheckSpriteTmpPos("1038", 3)

				local var_649_10 = var_649_8.childCount

				for iter_649_4 = 0, var_649_10 - 1 do
					local var_649_11 = var_649_8:GetChild(iter_649_4)

					if var_649_11.name == "split_1" or not string.find(var_649_11.name, "split") then
						var_649_11.gameObject:SetActive(true)
					else
						var_649_11.gameObject:SetActive(false)
					end
				end
			end

			local var_649_12 = 0.001

			if var_649_9 <= arg_646_1.time_ and arg_646_1.time_ < var_649_9 + var_649_12 then
				local var_649_13 = (arg_646_1.time_ - var_649_9) / var_649_12
				local var_649_14 = Vector3.New(0, -400, 0)

				var_649_8.localPosition = Vector3.Lerp(arg_646_1.var_.moveOldPos1038, var_649_14, var_649_13)
			end

			if arg_646_1.time_ >= var_649_9 + var_649_12 and arg_646_1.time_ < var_649_9 + var_649_12 + arg_649_0 then
				var_649_8.localPosition = Vector3.New(0, -400, 0)
			end

			local var_649_15 = 0
			local var_649_16 = 0.425

			if var_649_15 < arg_646_1.time_ and arg_646_1.time_ <= var_649_15 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, true)

				local var_649_17 = arg_646_1:FormatText(StoryNameCfg[94].name)

				arg_646_1.leftNameTxt_.text = var_649_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_646_1.leftNameTxt_.transform)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1.leftNameTxt_.text)
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_18 = arg_646_1:GetWordFromCfg(115301159)
				local var_649_19 = arg_646_1:FormatText(var_649_18.content)

				arg_646_1.text_.text = var_649_19

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_20 = 17
				local var_649_21 = utf8.len(var_649_19)
				local var_649_22 = var_649_20 <= 0 and var_649_16 or var_649_16 * (var_649_21 / var_649_20)

				if var_649_22 > 0 and var_649_16 < var_649_22 then
					arg_646_1.talkMaxDuration = var_649_22

					if var_649_22 + var_649_15 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_22 + var_649_15
					end
				end

				arg_646_1.text_.text = var_649_19
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301159", "story_v_out_115301.awb") ~= 0 then
					local var_649_23 = manager.audio:GetVoiceLength("story_v_out_115301", "115301159", "story_v_out_115301.awb") / 1000

					if var_649_23 + var_649_15 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_23 + var_649_15
					end

					if var_649_18.prefab_name ~= "" and arg_646_1.actors_[var_649_18.prefab_name] ~= nil then
						local var_649_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_646_1.actors_[var_649_18.prefab_name].transform, "story_v_out_115301", "115301159", "story_v_out_115301.awb")

						arg_646_1:RecordAudio("115301159", var_649_24)
						arg_646_1:RecordAudio("115301159", var_649_24)
					else
						arg_646_1:AudioAction("play", "voice", "story_v_out_115301", "115301159", "story_v_out_115301.awb")
					end

					arg_646_1:RecordHistoryTalkVoice("story_v_out_115301", "115301159", "story_v_out_115301.awb")
				end

				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_25 = math.max(var_649_16, arg_646_1.talkMaxDuration)

			if var_649_15 <= arg_646_1.time_ and arg_646_1.time_ < var_649_15 + var_649_25 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_15) / var_649_25

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_15 + var_649_25 and arg_646_1.time_ < var_649_15 + var_649_25 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_646_1:InitPlayNodeList()
	end,
	Play115301160 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 115301160
		arg_650_1.duration_ = 7.57

		local var_650_0 = {
			ja = 6.6,
			ko = 5.8,
			zh = 5.5,
			en = 7.566
		}
		local var_650_1 = manager.audio:GetLocalizationFlag()

		if var_650_0[var_650_1] ~= nil then
			arg_650_1.duration_ = var_650_0[var_650_1]
		end

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play115301161(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			local var_653_0 = arg_650_1.actors_["1038"]
			local var_653_1 = 0

			if var_653_1 < arg_650_1.time_ and arg_650_1.time_ <= var_653_1 + arg_653_0 and not isNil(var_653_0) and arg_650_1.var_.actorSpriteComps1038 == nil then
				arg_650_1.var_.actorSpriteComps1038 = var_653_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_653_2 = 0.2

			if var_653_1 <= arg_650_1.time_ and arg_650_1.time_ < var_653_1 + var_653_2 and not isNil(var_653_0) then
				local var_653_3 = (arg_650_1.time_ - var_653_1) / var_653_2

				if arg_650_1.var_.actorSpriteComps1038 then
					for iter_653_0, iter_653_1 in pairs(arg_650_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_653_1 then
							if arg_650_1.isInRecall_ then
								local var_653_4 = Mathf.Lerp(iter_653_1.color.r, arg_650_1.hightColor2.r, var_653_3)
								local var_653_5 = Mathf.Lerp(iter_653_1.color.g, arg_650_1.hightColor2.g, var_653_3)
								local var_653_6 = Mathf.Lerp(iter_653_1.color.b, arg_650_1.hightColor2.b, var_653_3)

								iter_653_1.color = Color.New(var_653_4, var_653_5, var_653_6)
							else
								local var_653_7 = Mathf.Lerp(iter_653_1.color.r, 0.5, var_653_3)

								iter_653_1.color = Color.New(var_653_7, var_653_7, var_653_7)
							end
						end
					end
				end
			end

			if arg_650_1.time_ >= var_653_1 + var_653_2 and arg_650_1.time_ < var_653_1 + var_653_2 + arg_653_0 and not isNil(var_653_0) and arg_650_1.var_.actorSpriteComps1038 then
				for iter_653_2, iter_653_3 in pairs(arg_650_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_653_3 then
						if arg_650_1.isInRecall_ then
							iter_653_3.color = arg_650_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_653_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_650_1.var_.actorSpriteComps1038 = nil
			end

			local var_653_8 = 0
			local var_653_9 = 0.6

			if var_653_8 < arg_650_1.time_ and arg_650_1.time_ <= var_653_8 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, true)

				local var_653_10 = arg_650_1:FormatText(StoryNameCfg[36].name)

				arg_650_1.leftNameTxt_.text = var_653_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, false)
				arg_650_1.callingController_:SetSelectedState("normal")

				local var_653_11 = arg_650_1:GetWordFromCfg(115301160)
				local var_653_12 = arg_650_1:FormatText(var_653_11.content)

				arg_650_1.text_.text = var_653_12

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_13 = 24
				local var_653_14 = utf8.len(var_653_12)
				local var_653_15 = var_653_13 <= 0 and var_653_9 or var_653_9 * (var_653_14 / var_653_13)

				if var_653_15 > 0 and var_653_9 < var_653_15 then
					arg_650_1.talkMaxDuration = var_653_15

					if var_653_15 + var_653_8 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_15 + var_653_8
					end
				end

				arg_650_1.text_.text = var_653_12
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301160", "story_v_out_115301.awb") ~= 0 then
					local var_653_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301160", "story_v_out_115301.awb") / 1000

					if var_653_16 + var_653_8 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_16 + var_653_8
					end

					if var_653_11.prefab_name ~= "" and arg_650_1.actors_[var_653_11.prefab_name] ~= nil then
						local var_653_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_650_1.actors_[var_653_11.prefab_name].transform, "story_v_out_115301", "115301160", "story_v_out_115301.awb")

						arg_650_1:RecordAudio("115301160", var_653_17)
						arg_650_1:RecordAudio("115301160", var_653_17)
					else
						arg_650_1:AudioAction("play", "voice", "story_v_out_115301", "115301160", "story_v_out_115301.awb")
					end

					arg_650_1:RecordHistoryTalkVoice("story_v_out_115301", "115301160", "story_v_out_115301.awb")
				end

				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_18 = math.max(var_653_9, arg_650_1.talkMaxDuration)

			if var_653_8 <= arg_650_1.time_ and arg_650_1.time_ < var_653_8 + var_653_18 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_8) / var_653_18

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_8 + var_653_18 and arg_650_1.time_ < var_653_8 + var_653_18 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {}

		arg_650_1:InitPlayNodeList()
	end,
	Play115301161 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 115301161
		arg_654_1.duration_ = 14.47

		local var_654_0 = {
			ja = 14.466,
			ko = 10,
			zh = 10.933,
			en = 10.9
		}
		local var_654_1 = manager.audio:GetLocalizationFlag()

		if var_654_0[var_654_1] ~= nil then
			arg_654_1.duration_ = var_654_0[var_654_1]
		end

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play115301162(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			local var_657_0 = 0
			local var_657_1 = 1.075

			if var_657_0 < arg_654_1.time_ and arg_654_1.time_ <= var_657_0 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				local var_657_2 = arg_654_1:FormatText(StoryNameCfg[36].name)

				arg_654_1.leftNameTxt_.text = var_657_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, false)
				arg_654_1.callingController_:SetSelectedState("normal")

				local var_657_3 = arg_654_1:GetWordFromCfg(115301161)
				local var_657_4 = arg_654_1:FormatText(var_657_3.content)

				arg_654_1.text_.text = var_657_4

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_5 = 43
				local var_657_6 = utf8.len(var_657_4)
				local var_657_7 = var_657_5 <= 0 and var_657_1 or var_657_1 * (var_657_6 / var_657_5)

				if var_657_7 > 0 and var_657_1 < var_657_7 then
					arg_654_1.talkMaxDuration = var_657_7

					if var_657_7 + var_657_0 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_7 + var_657_0
					end
				end

				arg_654_1.text_.text = var_657_4
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301161", "story_v_out_115301.awb") ~= 0 then
					local var_657_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301161", "story_v_out_115301.awb") / 1000

					if var_657_8 + var_657_0 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_8 + var_657_0
					end

					if var_657_3.prefab_name ~= "" and arg_654_1.actors_[var_657_3.prefab_name] ~= nil then
						local var_657_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_654_1.actors_[var_657_3.prefab_name].transform, "story_v_out_115301", "115301161", "story_v_out_115301.awb")

						arg_654_1:RecordAudio("115301161", var_657_9)
						arg_654_1:RecordAudio("115301161", var_657_9)
					else
						arg_654_1:AudioAction("play", "voice", "story_v_out_115301", "115301161", "story_v_out_115301.awb")
					end

					arg_654_1:RecordHistoryTalkVoice("story_v_out_115301", "115301161", "story_v_out_115301.awb")
				end

				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_10 = math.max(var_657_1, arg_654_1.talkMaxDuration)

			if var_657_0 <= arg_654_1.time_ and arg_654_1.time_ < var_657_0 + var_657_10 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - var_657_0) / var_657_10

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= var_657_0 + var_657_10 and arg_654_1.time_ < var_657_0 + var_657_10 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play115301162 = function(arg_658_0, arg_658_1)
		arg_658_1.time_ = 0
		arg_658_1.frameCnt_ = 0
		arg_658_1.state_ = "playing"
		arg_658_1.curTalkId_ = 115301162
		arg_658_1.duration_ = 4.23

		local var_658_0 = {
			ja = 3.166,
			ko = 2.633,
			zh = 4.233,
			en = 3.466
		}
		local var_658_1 = manager.audio:GetLocalizationFlag()

		if var_658_0[var_658_1] ~= nil then
			arg_658_1.duration_ = var_658_0[var_658_1]
		end

		SetActive(arg_658_1.tipsGo_, false)

		function arg_658_1.onSingleLineFinish_()
			arg_658_1.onSingleLineUpdate_ = nil
			arg_658_1.onSingleLineFinish_ = nil
			arg_658_1.state_ = "waiting"
		end

		function arg_658_1.playNext_(arg_660_0)
			if arg_660_0 == 1 then
				arg_658_0:Play115301163(arg_658_1)
			end
		end

		function arg_658_1.onSingleLineUpdate_(arg_661_0)
			local var_661_0 = 0
			local var_661_1 = 0.275

			if var_661_0 < arg_658_1.time_ and arg_658_1.time_ <= var_661_0 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, true)

				local var_661_2 = arg_658_1:FormatText(StoryNameCfg[36].name)

				arg_658_1.leftNameTxt_.text = var_661_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_658_1.leftNameTxt_.transform)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1.leftNameTxt_.text)
				SetActive(arg_658_1.iconTrs_.gameObject, false)
				arg_658_1.callingController_:SetSelectedState("normal")

				local var_661_3 = arg_658_1:GetWordFromCfg(115301162)
				local var_661_4 = arg_658_1:FormatText(var_661_3.content)

				arg_658_1.text_.text = var_661_4

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_5 = 11
				local var_661_6 = utf8.len(var_661_4)
				local var_661_7 = var_661_5 <= 0 and var_661_1 or var_661_1 * (var_661_6 / var_661_5)

				if var_661_7 > 0 and var_661_1 < var_661_7 then
					arg_658_1.talkMaxDuration = var_661_7

					if var_661_7 + var_661_0 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_7 + var_661_0
					end
				end

				arg_658_1.text_.text = var_661_4
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301162", "story_v_out_115301.awb") ~= 0 then
					local var_661_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301162", "story_v_out_115301.awb") / 1000

					if var_661_8 + var_661_0 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_8 + var_661_0
					end

					if var_661_3.prefab_name ~= "" and arg_658_1.actors_[var_661_3.prefab_name] ~= nil then
						local var_661_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_658_1.actors_[var_661_3.prefab_name].transform, "story_v_out_115301", "115301162", "story_v_out_115301.awb")

						arg_658_1:RecordAudio("115301162", var_661_9)
						arg_658_1:RecordAudio("115301162", var_661_9)
					else
						arg_658_1:AudioAction("play", "voice", "story_v_out_115301", "115301162", "story_v_out_115301.awb")
					end

					arg_658_1:RecordHistoryTalkVoice("story_v_out_115301", "115301162", "story_v_out_115301.awb")
				end

				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_10 = math.max(var_661_1, arg_658_1.talkMaxDuration)

			if var_661_0 <= arg_658_1.time_ and arg_658_1.time_ < var_661_0 + var_661_10 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - var_661_0) / var_661_10

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= var_661_0 + var_661_10 and arg_658_1.time_ < var_661_0 + var_661_10 + arg_661_0 then
				arg_658_1.typewritter.percent = 1

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(true)
			end
		end

		arg_658_1.nodeConfigList_ = {}

		arg_658_1:InitPlayNodeList()
	end,
	Play115301163 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 115301163
		arg_662_1.duration_ = 9.23

		local var_662_0 = {
			ja = 8.233,
			ko = 8.4,
			zh = 9.233,
			en = 8.666
		}
		local var_662_1 = manager.audio:GetLocalizationFlag()

		if var_662_0[var_662_1] ~= nil then
			arg_662_1.duration_ = var_662_0[var_662_1]
		end

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play115301164(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			local var_665_0 = arg_662_1.actors_["1038"]
			local var_665_1 = 0

			if var_665_1 < arg_662_1.time_ and arg_662_1.time_ <= var_665_1 + arg_665_0 and not isNil(var_665_0) and arg_662_1.var_.actorSpriteComps1038 == nil then
				arg_662_1.var_.actorSpriteComps1038 = var_665_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_665_2 = 0.2

			if var_665_1 <= arg_662_1.time_ and arg_662_1.time_ < var_665_1 + var_665_2 and not isNil(var_665_0) then
				local var_665_3 = (arg_662_1.time_ - var_665_1) / var_665_2

				if arg_662_1.var_.actorSpriteComps1038 then
					for iter_665_0, iter_665_1 in pairs(arg_662_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_665_1 then
							if arg_662_1.isInRecall_ then
								local var_665_4 = Mathf.Lerp(iter_665_1.color.r, arg_662_1.hightColor1.r, var_665_3)
								local var_665_5 = Mathf.Lerp(iter_665_1.color.g, arg_662_1.hightColor1.g, var_665_3)
								local var_665_6 = Mathf.Lerp(iter_665_1.color.b, arg_662_1.hightColor1.b, var_665_3)

								iter_665_1.color = Color.New(var_665_4, var_665_5, var_665_6)
							else
								local var_665_7 = Mathf.Lerp(iter_665_1.color.r, 1, var_665_3)

								iter_665_1.color = Color.New(var_665_7, var_665_7, var_665_7)
							end
						end
					end
				end
			end

			if arg_662_1.time_ >= var_665_1 + var_665_2 and arg_662_1.time_ < var_665_1 + var_665_2 + arg_665_0 and not isNil(var_665_0) and arg_662_1.var_.actorSpriteComps1038 then
				for iter_665_2, iter_665_3 in pairs(arg_662_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_665_3 then
						if arg_662_1.isInRecall_ then
							iter_665_3.color = arg_662_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_665_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_662_1.var_.actorSpriteComps1038 = nil
			end

			local var_665_8 = 0
			local var_665_9 = 0.8

			if var_665_8 < arg_662_1.time_ and arg_662_1.time_ <= var_665_8 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				local var_665_10 = arg_662_1:FormatText(StoryNameCfg[94].name)

				arg_662_1.leftNameTxt_.text = var_665_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, false)
				arg_662_1.callingController_:SetSelectedState("normal")

				local var_665_11 = arg_662_1:GetWordFromCfg(115301163)
				local var_665_12 = arg_662_1:FormatText(var_665_11.content)

				arg_662_1.text_.text = var_665_12

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_13 = 32
				local var_665_14 = utf8.len(var_665_12)
				local var_665_15 = var_665_13 <= 0 and var_665_9 or var_665_9 * (var_665_14 / var_665_13)

				if var_665_15 > 0 and var_665_9 < var_665_15 then
					arg_662_1.talkMaxDuration = var_665_15

					if var_665_15 + var_665_8 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_15 + var_665_8
					end
				end

				arg_662_1.text_.text = var_665_12
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301163", "story_v_out_115301.awb") ~= 0 then
					local var_665_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301163", "story_v_out_115301.awb") / 1000

					if var_665_16 + var_665_8 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_16 + var_665_8
					end

					if var_665_11.prefab_name ~= "" and arg_662_1.actors_[var_665_11.prefab_name] ~= nil then
						local var_665_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_662_1.actors_[var_665_11.prefab_name].transform, "story_v_out_115301", "115301163", "story_v_out_115301.awb")

						arg_662_1:RecordAudio("115301163", var_665_17)
						arg_662_1:RecordAudio("115301163", var_665_17)
					else
						arg_662_1:AudioAction("play", "voice", "story_v_out_115301", "115301163", "story_v_out_115301.awb")
					end

					arg_662_1:RecordHistoryTalkVoice("story_v_out_115301", "115301163", "story_v_out_115301.awb")
				end

				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_18 = math.max(var_665_9, arg_662_1.talkMaxDuration)

			if var_665_8 <= arg_662_1.time_ and arg_662_1.time_ < var_665_8 + var_665_18 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_8) / var_665_18

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_8 + var_665_18 and arg_662_1.time_ < var_665_8 + var_665_18 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {}

		arg_662_1:InitPlayNodeList()
	end,
	Play115301164 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 115301164
		arg_666_1.duration_ = 6.3

		local var_666_0 = {
			ja = 6.3,
			ko = 6.266,
			zh = 5.433,
			en = 5.633
		}
		local var_666_1 = manager.audio:GetLocalizationFlag()

		if var_666_0[var_666_1] ~= nil then
			arg_666_1.duration_ = var_666_0[var_666_1]
		end

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play115301165(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			local var_669_0 = 0
			local var_669_1 = 0.525

			if var_669_0 < arg_666_1.time_ and arg_666_1.time_ <= var_669_0 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0
				arg_666_1.dialogCg_.alpha = 1

				arg_666_1.dialog_:SetActive(true)
				SetActive(arg_666_1.leftNameGo_, true)

				local var_669_2 = arg_666_1:FormatText(StoryNameCfg[94].name)

				arg_666_1.leftNameTxt_.text = var_669_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_666_1.leftNameTxt_.transform)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1.leftNameTxt_.text)
				SetActive(arg_666_1.iconTrs_.gameObject, false)
				arg_666_1.callingController_:SetSelectedState("normal")

				local var_669_3 = arg_666_1:GetWordFromCfg(115301164)
				local var_669_4 = arg_666_1:FormatText(var_669_3.content)

				arg_666_1.text_.text = var_669_4

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_5 = 21
				local var_669_6 = utf8.len(var_669_4)
				local var_669_7 = var_669_5 <= 0 and var_669_1 or var_669_1 * (var_669_6 / var_669_5)

				if var_669_7 > 0 and var_669_1 < var_669_7 then
					arg_666_1.talkMaxDuration = var_669_7

					if var_669_7 + var_669_0 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_7 + var_669_0
					end
				end

				arg_666_1.text_.text = var_669_4
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301164", "story_v_out_115301.awb") ~= 0 then
					local var_669_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301164", "story_v_out_115301.awb") / 1000

					if var_669_8 + var_669_0 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_8 + var_669_0
					end

					if var_669_3.prefab_name ~= "" and arg_666_1.actors_[var_669_3.prefab_name] ~= nil then
						local var_669_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_666_1.actors_[var_669_3.prefab_name].transform, "story_v_out_115301", "115301164", "story_v_out_115301.awb")

						arg_666_1:RecordAudio("115301164", var_669_9)
						arg_666_1:RecordAudio("115301164", var_669_9)
					else
						arg_666_1:AudioAction("play", "voice", "story_v_out_115301", "115301164", "story_v_out_115301.awb")
					end

					arg_666_1:RecordHistoryTalkVoice("story_v_out_115301", "115301164", "story_v_out_115301.awb")
				end

				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_10 = math.max(var_669_1, arg_666_1.talkMaxDuration)

			if var_669_0 <= arg_666_1.time_ and arg_666_1.time_ < var_669_0 + var_669_10 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - var_669_0) / var_669_10

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= var_669_0 + var_669_10 and arg_666_1.time_ < var_669_0 + var_669_10 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {}

		arg_666_1:InitPlayNodeList()
	end,
	Play115301165 = function(arg_670_0, arg_670_1)
		arg_670_1.time_ = 0
		arg_670_1.frameCnt_ = 0
		arg_670_1.state_ = "playing"
		arg_670_1.curTalkId_ = 115301165
		arg_670_1.duration_ = 6.1

		local var_670_0 = {
			ja = 4.9,
			ko = 5.233,
			zh = 6.1,
			en = 4.866
		}
		local var_670_1 = manager.audio:GetLocalizationFlag()

		if var_670_0[var_670_1] ~= nil then
			arg_670_1.duration_ = var_670_0[var_670_1]
		end

		SetActive(arg_670_1.tipsGo_, false)

		function arg_670_1.onSingleLineFinish_()
			arg_670_1.onSingleLineUpdate_ = nil
			arg_670_1.onSingleLineFinish_ = nil
			arg_670_1.state_ = "waiting"
		end

		function arg_670_1.playNext_(arg_672_0)
			if arg_672_0 == 1 then
				arg_670_0:Play115301166(arg_670_1)
			end
		end

		function arg_670_1.onSingleLineUpdate_(arg_673_0)
			local var_673_0 = arg_670_1.actors_["1038"]
			local var_673_1 = 0

			if var_673_1 < arg_670_1.time_ and arg_670_1.time_ <= var_673_1 + arg_673_0 and not isNil(var_673_0) and arg_670_1.var_.actorSpriteComps1038 == nil then
				arg_670_1.var_.actorSpriteComps1038 = var_673_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_673_2 = 0.2

			if var_673_1 <= arg_670_1.time_ and arg_670_1.time_ < var_673_1 + var_673_2 and not isNil(var_673_0) then
				local var_673_3 = (arg_670_1.time_ - var_673_1) / var_673_2

				if arg_670_1.var_.actorSpriteComps1038 then
					for iter_673_0, iter_673_1 in pairs(arg_670_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_673_1 then
							if arg_670_1.isInRecall_ then
								local var_673_4 = Mathf.Lerp(iter_673_1.color.r, arg_670_1.hightColor2.r, var_673_3)
								local var_673_5 = Mathf.Lerp(iter_673_1.color.g, arg_670_1.hightColor2.g, var_673_3)
								local var_673_6 = Mathf.Lerp(iter_673_1.color.b, arg_670_1.hightColor2.b, var_673_3)

								iter_673_1.color = Color.New(var_673_4, var_673_5, var_673_6)
							else
								local var_673_7 = Mathf.Lerp(iter_673_1.color.r, 0.5, var_673_3)

								iter_673_1.color = Color.New(var_673_7, var_673_7, var_673_7)
							end
						end
					end
				end
			end

			if arg_670_1.time_ >= var_673_1 + var_673_2 and arg_670_1.time_ < var_673_1 + var_673_2 + arg_673_0 and not isNil(var_673_0) and arg_670_1.var_.actorSpriteComps1038 then
				for iter_673_2, iter_673_3 in pairs(arg_670_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_673_3 then
						if arg_670_1.isInRecall_ then
							iter_673_3.color = arg_670_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_673_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_670_1.var_.actorSpriteComps1038 = nil
			end

			local var_673_8 = 0
			local var_673_9 = 0.45

			if var_673_8 < arg_670_1.time_ and arg_670_1.time_ <= var_673_8 + arg_673_0 then
				arg_670_1.talkMaxDuration = 0
				arg_670_1.dialogCg_.alpha = 1

				arg_670_1.dialog_:SetActive(true)
				SetActive(arg_670_1.leftNameGo_, true)

				local var_673_10 = arg_670_1:FormatText(StoryNameCfg[36].name)

				arg_670_1.leftNameTxt_.text = var_673_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_670_1.leftNameTxt_.transform)

				arg_670_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_670_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_670_1:RecordName(arg_670_1.leftNameTxt_.text)
				SetActive(arg_670_1.iconTrs_.gameObject, false)
				arg_670_1.callingController_:SetSelectedState("normal")

				local var_673_11 = arg_670_1:GetWordFromCfg(115301165)
				local var_673_12 = arg_670_1:FormatText(var_673_11.content)

				arg_670_1.text_.text = var_673_12

				LuaForUtil.ClearLinePrefixSymbol(arg_670_1.text_)

				local var_673_13 = 18
				local var_673_14 = utf8.len(var_673_12)
				local var_673_15 = var_673_13 <= 0 and var_673_9 or var_673_9 * (var_673_14 / var_673_13)

				if var_673_15 > 0 and var_673_9 < var_673_15 then
					arg_670_1.talkMaxDuration = var_673_15

					if var_673_15 + var_673_8 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_15 + var_673_8
					end
				end

				arg_670_1.text_.text = var_673_12
				arg_670_1.typewritter.percent = 0

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301165", "story_v_out_115301.awb") ~= 0 then
					local var_673_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301165", "story_v_out_115301.awb") / 1000

					if var_673_16 + var_673_8 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_16 + var_673_8
					end

					if var_673_11.prefab_name ~= "" and arg_670_1.actors_[var_673_11.prefab_name] ~= nil then
						local var_673_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_670_1.actors_[var_673_11.prefab_name].transform, "story_v_out_115301", "115301165", "story_v_out_115301.awb")

						arg_670_1:RecordAudio("115301165", var_673_17)
						arg_670_1:RecordAudio("115301165", var_673_17)
					else
						arg_670_1:AudioAction("play", "voice", "story_v_out_115301", "115301165", "story_v_out_115301.awb")
					end

					arg_670_1:RecordHistoryTalkVoice("story_v_out_115301", "115301165", "story_v_out_115301.awb")
				end

				arg_670_1:RecordContent(arg_670_1.text_.text)
			end

			local var_673_18 = math.max(var_673_9, arg_670_1.talkMaxDuration)

			if var_673_8 <= arg_670_1.time_ and arg_670_1.time_ < var_673_8 + var_673_18 then
				arg_670_1.typewritter.percent = (arg_670_1.time_ - var_673_8) / var_673_18

				arg_670_1.typewritter:SetDirty()
			end

			if arg_670_1.time_ >= var_673_8 + var_673_18 and arg_670_1.time_ < var_673_8 + var_673_18 + arg_673_0 then
				arg_670_1.typewritter.percent = 1

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(true)
			end
		end

		arg_670_1.nodeConfigList_ = {}

		arg_670_1:InitPlayNodeList()
	end,
	Play115301166 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 115301166
		arg_674_1.duration_ = 18.43

		local var_674_0 = {
			ja = 12.6,
			ko = 14.066,
			zh = 13.6,
			en = 18.433
		}
		local var_674_1 = manager.audio:GetLocalizationFlag()

		if var_674_0[var_674_1] ~= nil then
			arg_674_1.duration_ = var_674_0[var_674_1]
		end

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
		end

		function arg_674_1.playNext_(arg_676_0)
			if arg_676_0 == 1 then
				arg_674_0:Play115301167(arg_674_1)
			end
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			local var_677_0 = 0
			local var_677_1 = 1.25

			if var_677_0 < arg_674_1.time_ and arg_674_1.time_ <= var_677_0 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, true)

				local var_677_2 = arg_674_1:FormatText(StoryNameCfg[36].name)

				arg_674_1.leftNameTxt_.text = var_677_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_674_1.leftNameTxt_.transform)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1.leftNameTxt_.text)
				SetActive(arg_674_1.iconTrs_.gameObject, false)
				arg_674_1.callingController_:SetSelectedState("normal")

				local var_677_3 = arg_674_1:GetWordFromCfg(115301166)
				local var_677_4 = arg_674_1:FormatText(var_677_3.content)

				arg_674_1.text_.text = var_677_4

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_5 = 50
				local var_677_6 = utf8.len(var_677_4)
				local var_677_7 = var_677_5 <= 0 and var_677_1 or var_677_1 * (var_677_6 / var_677_5)

				if var_677_7 > 0 and var_677_1 < var_677_7 then
					arg_674_1.talkMaxDuration = var_677_7

					if var_677_7 + var_677_0 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_7 + var_677_0
					end
				end

				arg_674_1.text_.text = var_677_4
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301166", "story_v_out_115301.awb") ~= 0 then
					local var_677_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301166", "story_v_out_115301.awb") / 1000

					if var_677_8 + var_677_0 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_8 + var_677_0
					end

					if var_677_3.prefab_name ~= "" and arg_674_1.actors_[var_677_3.prefab_name] ~= nil then
						local var_677_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_674_1.actors_[var_677_3.prefab_name].transform, "story_v_out_115301", "115301166", "story_v_out_115301.awb")

						arg_674_1:RecordAudio("115301166", var_677_9)
						arg_674_1:RecordAudio("115301166", var_677_9)
					else
						arg_674_1:AudioAction("play", "voice", "story_v_out_115301", "115301166", "story_v_out_115301.awb")
					end

					arg_674_1:RecordHistoryTalkVoice("story_v_out_115301", "115301166", "story_v_out_115301.awb")
				end

				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_10 = math.max(var_677_1, arg_674_1.talkMaxDuration)

			if var_677_0 <= arg_674_1.time_ and arg_674_1.time_ < var_677_0 + var_677_10 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - var_677_0) / var_677_10

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= var_677_0 + var_677_10 and arg_674_1.time_ < var_677_0 + var_677_10 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {}

		arg_674_1:InitPlayNodeList()
	end,
	Play115301167 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 115301167
		arg_678_1.duration_ = 9.97

		local var_678_0 = {
			ja = 9.2,
			ko = 9.133,
			zh = 9.966,
			en = 9.466
		}
		local var_678_1 = manager.audio:GetLocalizationFlag()

		if var_678_0[var_678_1] ~= nil then
			arg_678_1.duration_ = var_678_0[var_678_1]
		end

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play115301168(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			local var_681_0 = 0
			local var_681_1 = 0.925

			if var_681_0 < arg_678_1.time_ and arg_678_1.time_ <= var_681_0 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, true)

				local var_681_2 = arg_678_1:FormatText(StoryNameCfg[36].name)

				arg_678_1.leftNameTxt_.text = var_681_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_678_1.leftNameTxt_.transform)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1.leftNameTxt_.text)
				SetActive(arg_678_1.iconTrs_.gameObject, false)
				arg_678_1.callingController_:SetSelectedState("normal")

				local var_681_3 = arg_678_1:GetWordFromCfg(115301167)
				local var_681_4 = arg_678_1:FormatText(var_681_3.content)

				arg_678_1.text_.text = var_681_4

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_5 = 37
				local var_681_6 = utf8.len(var_681_4)
				local var_681_7 = var_681_5 <= 0 and var_681_1 or var_681_1 * (var_681_6 / var_681_5)

				if var_681_7 > 0 and var_681_1 < var_681_7 then
					arg_678_1.talkMaxDuration = var_681_7

					if var_681_7 + var_681_0 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_7 + var_681_0
					end
				end

				arg_678_1.text_.text = var_681_4
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301167", "story_v_out_115301.awb") ~= 0 then
					local var_681_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301167", "story_v_out_115301.awb") / 1000

					if var_681_8 + var_681_0 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_8 + var_681_0
					end

					if var_681_3.prefab_name ~= "" and arg_678_1.actors_[var_681_3.prefab_name] ~= nil then
						local var_681_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_678_1.actors_[var_681_3.prefab_name].transform, "story_v_out_115301", "115301167", "story_v_out_115301.awb")

						arg_678_1:RecordAudio("115301167", var_681_9)
						arg_678_1:RecordAudio("115301167", var_681_9)
					else
						arg_678_1:AudioAction("play", "voice", "story_v_out_115301", "115301167", "story_v_out_115301.awb")
					end

					arg_678_1:RecordHistoryTalkVoice("story_v_out_115301", "115301167", "story_v_out_115301.awb")
				end

				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_10 = math.max(var_681_1, arg_678_1.talkMaxDuration)

			if var_681_0 <= arg_678_1.time_ and arg_678_1.time_ < var_681_0 + var_681_10 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - var_681_0) / var_681_10

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= var_681_0 + var_681_10 and arg_678_1.time_ < var_681_0 + var_681_10 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {}

		arg_678_1:InitPlayNodeList()
	end,
	Play115301168 = function(arg_682_0, arg_682_1)
		arg_682_1.time_ = 0
		arg_682_1.frameCnt_ = 0
		arg_682_1.state_ = "playing"
		arg_682_1.curTalkId_ = 115301168
		arg_682_1.duration_ = 9

		SetActive(arg_682_1.tipsGo_, false)

		function arg_682_1.onSingleLineFinish_()
			arg_682_1.onSingleLineUpdate_ = nil
			arg_682_1.onSingleLineFinish_ = nil
			arg_682_1.state_ = "waiting"
		end

		function arg_682_1.playNext_(arg_684_0)
			if arg_684_0 == 1 then
				arg_682_0:Play115301169(arg_682_1)
			end
		end

		function arg_682_1.onSingleLineUpdate_(arg_685_0)
			local var_685_0 = 2

			if var_685_0 < arg_682_1.time_ and arg_682_1.time_ <= var_685_0 + arg_685_0 then
				local var_685_1 = manager.ui.mainCamera.transform.localPosition
				local var_685_2 = Vector3.New(0, 0, 10) + Vector3.New(var_685_1.x, var_685_1.y, 0)
				local var_685_3 = arg_682_1.bgs_.F01

				var_685_3.transform.localPosition = var_685_2
				var_685_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_685_4 = var_685_3:GetComponent("SpriteRenderer")

				if var_685_4 and var_685_4.sprite then
					local var_685_5 = (var_685_3.transform.localPosition - var_685_1).z
					local var_685_6 = manager.ui.mainCameraCom_
					local var_685_7 = 2 * var_685_5 * Mathf.Tan(var_685_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_685_8 = var_685_7 * var_685_6.aspect
					local var_685_9 = var_685_4.sprite.bounds.size.x
					local var_685_10 = var_685_4.sprite.bounds.size.y
					local var_685_11 = var_685_8 / var_685_9
					local var_685_12 = var_685_7 / var_685_10
					local var_685_13 = var_685_12 < var_685_11 and var_685_11 or var_685_12

					var_685_3.transform.localScale = Vector3.New(var_685_13, var_685_13, 0)
				end

				for iter_685_0, iter_685_1 in pairs(arg_682_1.bgs_) do
					if iter_685_0 ~= "F01" then
						iter_685_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_685_14 = 0

			if var_685_14 < arg_682_1.time_ and arg_682_1.time_ <= var_685_14 + arg_685_0 then
				arg_682_1.mask_.enabled = true
				arg_682_1.mask_.raycastTarget = false

				arg_682_1:SetGaussion(false)
			end

			local var_685_15 = 2

			if var_685_14 <= arg_682_1.time_ and arg_682_1.time_ < var_685_14 + var_685_15 then
				local var_685_16 = (arg_682_1.time_ - var_685_14) / var_685_15
				local var_685_17 = Color.New(0, 0, 0)

				var_685_17.a = Mathf.Lerp(0, 1, var_685_16)
				arg_682_1.mask_.color = var_685_17
			end

			if arg_682_1.time_ >= var_685_14 + var_685_15 and arg_682_1.time_ < var_685_14 + var_685_15 + arg_685_0 then
				local var_685_18 = Color.New(0, 0, 0)

				var_685_18.a = 1
				arg_682_1.mask_.color = var_685_18
			end

			local var_685_19 = 2

			if var_685_19 < arg_682_1.time_ and arg_682_1.time_ <= var_685_19 + arg_685_0 then
				arg_682_1.mask_.enabled = true
				arg_682_1.mask_.raycastTarget = false

				arg_682_1:SetGaussion(false)
			end

			local var_685_20 = 2

			if var_685_19 <= arg_682_1.time_ and arg_682_1.time_ < var_685_19 + var_685_20 then
				local var_685_21 = (arg_682_1.time_ - var_685_19) / var_685_20
				local var_685_22 = Color.New(0, 0, 0)

				var_685_22.a = Mathf.Lerp(1, 0, var_685_21)
				arg_682_1.mask_.color = var_685_22
			end

			if arg_682_1.time_ >= var_685_19 + var_685_20 and arg_682_1.time_ < var_685_19 + var_685_20 + arg_685_0 then
				local var_685_23 = Color.New(0, 0, 0)
				local var_685_24 = 0

				arg_682_1.mask_.enabled = false
				var_685_23.a = var_685_24
				arg_682_1.mask_.color = var_685_23
			end

			local var_685_25 = arg_682_1.actors_["1038"].transform
			local var_685_26 = 2

			if var_685_26 < arg_682_1.time_ and arg_682_1.time_ <= var_685_26 + arg_685_0 then
				arg_682_1.var_.moveOldPos1038 = var_685_25.localPosition
				var_685_25.localScale = Vector3.New(1, 1, 1)

				arg_682_1:CheckSpriteTmpPos("1038", 0)

				local var_685_27 = var_685_25.childCount

				for iter_685_2 = 0, var_685_27 - 1 do
					local var_685_28 = var_685_25:GetChild(iter_685_2)

					if var_685_28.name == "split_1" or not string.find(var_685_28.name, "split") then
						var_685_28.gameObject:SetActive(true)
					else
						var_685_28.gameObject:SetActive(false)
					end
				end
			end

			local var_685_29 = 0.001

			if var_685_26 <= arg_682_1.time_ and arg_682_1.time_ < var_685_26 + var_685_29 then
				local var_685_30 = (arg_682_1.time_ - var_685_26) / var_685_29
				local var_685_31 = Vector3.New(-2000, -400, 0)

				var_685_25.localPosition = Vector3.Lerp(arg_682_1.var_.moveOldPos1038, var_685_31, var_685_30)
			end

			if arg_682_1.time_ >= var_685_26 + var_685_29 and arg_682_1.time_ < var_685_26 + var_685_29 + arg_685_0 then
				var_685_25.localPosition = Vector3.New(-2000, -400, 0)
			end

			local var_685_32 = 2

			arg_682_1.isInRecall_ = false

			if var_685_32 < arg_682_1.time_ and arg_682_1.time_ <= var_685_32 + arg_685_0 then
				arg_682_1.screenFilterGo_:SetActive(false)

				for iter_685_3, iter_685_4 in pairs(arg_682_1.actors_) do
					local var_685_33 = iter_685_4:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_685_5, iter_685_6 in ipairs(var_685_33) do
						if iter_685_6.color.r > 0.51 then
							iter_685_6.color = Color.New(1, 1, 1)
						else
							iter_685_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_685_34 = 0.0166666666666667

			if var_685_32 <= arg_682_1.time_ and arg_682_1.time_ < var_685_32 + var_685_34 then
				local var_685_35 = (arg_682_1.time_ - var_685_32) / var_685_34

				arg_682_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_685_35)
			end

			if arg_682_1.time_ >= var_685_32 + var_685_34 and arg_682_1.time_ < var_685_32 + var_685_34 + arg_685_0 then
				arg_682_1.screenFilterEffect_.weight = 0
			end

			if arg_682_1.frameCnt_ <= 1 then
				arg_682_1.dialog_:SetActive(false)
			end

			local var_685_36 = 4
			local var_685_37 = 0.625

			if var_685_36 < arg_682_1.time_ and arg_682_1.time_ <= var_685_36 + arg_685_0 then
				arg_682_1.talkMaxDuration = 0

				arg_682_1.dialog_:SetActive(true)

				arg_682_1.dialogCg_.alpha = 0

				local var_685_38 = LeanTween.value(arg_682_1.dialog_, 0, 1, 0.3)

				var_685_38:setOnUpdate(LuaHelper.FloatAction(function(arg_686_0)
					arg_682_1.dialogCg_.alpha = arg_686_0
				end))
				var_685_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_682_1.dialog_)
					var_685_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_682_1.duration_ = arg_682_1.duration_ + 0.3

				SetActive(arg_682_1.leftNameGo_, false)

				arg_682_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_682_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_682_1:RecordName(arg_682_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_682_1.iconTrs_.gameObject, false)
				arg_682_1.callingController_:SetSelectedState("normal")

				local var_685_39 = arg_682_1:GetWordFromCfg(115301168)
				local var_685_40 = arg_682_1:FormatText(var_685_39.content)

				arg_682_1.text_.text = var_685_40

				LuaForUtil.ClearLinePrefixSymbol(arg_682_1.text_)

				local var_685_41 = 25
				local var_685_42 = utf8.len(var_685_40)
				local var_685_43 = var_685_41 <= 0 and var_685_37 or var_685_37 * (var_685_42 / var_685_41)

				if var_685_43 > 0 and var_685_37 < var_685_43 then
					arg_682_1.talkMaxDuration = var_685_43
					var_685_36 = var_685_36 + 0.3

					if var_685_43 + var_685_36 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_43 + var_685_36
					end
				end

				arg_682_1.text_.text = var_685_40
				arg_682_1.typewritter.percent = 0

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(false)
				arg_682_1:RecordContent(arg_682_1.text_.text)
			end

			local var_685_44 = var_685_36 + 0.3
			local var_685_45 = math.max(var_685_37, arg_682_1.talkMaxDuration)

			if var_685_44 <= arg_682_1.time_ and arg_682_1.time_ < var_685_44 + var_685_45 then
				arg_682_1.typewritter.percent = (arg_682_1.time_ - var_685_44) / var_685_45

				arg_682_1.typewritter:SetDirty()
			end

			if arg_682_1.time_ >= var_685_44 + var_685_45 and arg_682_1.time_ < var_685_44 + var_685_45 + arg_685_0 then
				arg_682_1.typewritter.percent = 1

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(true)
			end
		end

		arg_682_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_682_1:InitPlayNodeList()
	end,
	Play115301169 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 115301169
		arg_688_1.duration_ = 9.77

		local var_688_0 = {
			ja = 8.466,
			ko = 9.233,
			zh = 9.766,
			en = 6.9
		}
		local var_688_1 = manager.audio:GetLocalizationFlag()

		if var_688_0[var_688_1] ~= nil then
			arg_688_1.duration_ = var_688_0[var_688_1]
		end

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
			arg_688_1.auto_ = false
		end

		function arg_688_1.playNext_(arg_690_0)
			arg_688_1.onStoryFinished_()
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			local var_691_0 = arg_688_1.actors_["1038"].transform
			local var_691_1 = 0

			if var_691_1 < arg_688_1.time_ and arg_688_1.time_ <= var_691_1 + arg_691_0 then
				arg_688_1.var_.moveOldPos1038 = var_691_0.localPosition
				var_691_0.localScale = Vector3.New(1, 1, 1)

				arg_688_1:CheckSpriteTmpPos("1038", 3)

				local var_691_2 = var_691_0.childCount

				for iter_691_0 = 0, var_691_2 - 1 do
					local var_691_3 = var_691_0:GetChild(iter_691_0)

					if var_691_3.name == "split_9" or not string.find(var_691_3.name, "split") then
						var_691_3.gameObject:SetActive(true)
					else
						var_691_3.gameObject:SetActive(false)
					end
				end
			end

			local var_691_4 = 0.001

			if var_691_1 <= arg_688_1.time_ and arg_688_1.time_ < var_691_1 + var_691_4 then
				local var_691_5 = (arg_688_1.time_ - var_691_1) / var_691_4
				local var_691_6 = Vector3.New(0, -400, 0)

				var_691_0.localPosition = Vector3.Lerp(arg_688_1.var_.moveOldPos1038, var_691_6, var_691_5)
			end

			if arg_688_1.time_ >= var_691_1 + var_691_4 and arg_688_1.time_ < var_691_1 + var_691_4 + arg_691_0 then
				var_691_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_691_7 = arg_688_1.actors_["1038"]
			local var_691_8 = 0

			if var_691_8 < arg_688_1.time_ and arg_688_1.time_ <= var_691_8 + arg_691_0 and not isNil(var_691_7) and arg_688_1.var_.actorSpriteComps1038 == nil then
				arg_688_1.var_.actorSpriteComps1038 = var_691_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_691_9 = 0.2

			if var_691_8 <= arg_688_1.time_ and arg_688_1.time_ < var_691_8 + var_691_9 and not isNil(var_691_7) then
				local var_691_10 = (arg_688_1.time_ - var_691_8) / var_691_9

				if arg_688_1.var_.actorSpriteComps1038 then
					for iter_691_1, iter_691_2 in pairs(arg_688_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_691_2 then
							if arg_688_1.isInRecall_ then
								local var_691_11 = Mathf.Lerp(iter_691_2.color.r, arg_688_1.hightColor1.r, var_691_10)
								local var_691_12 = Mathf.Lerp(iter_691_2.color.g, arg_688_1.hightColor1.g, var_691_10)
								local var_691_13 = Mathf.Lerp(iter_691_2.color.b, arg_688_1.hightColor1.b, var_691_10)

								iter_691_2.color = Color.New(var_691_11, var_691_12, var_691_13)
							else
								local var_691_14 = Mathf.Lerp(iter_691_2.color.r, 1, var_691_10)

								iter_691_2.color = Color.New(var_691_14, var_691_14, var_691_14)
							end
						end
					end
				end
			end

			if arg_688_1.time_ >= var_691_8 + var_691_9 and arg_688_1.time_ < var_691_8 + var_691_9 + arg_691_0 and not isNil(var_691_7) and arg_688_1.var_.actorSpriteComps1038 then
				for iter_691_3, iter_691_4 in pairs(arg_688_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_691_4 then
						if arg_688_1.isInRecall_ then
							iter_691_4.color = arg_688_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_691_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_688_1.var_.actorSpriteComps1038 = nil
			end

			local var_691_15 = arg_688_1.actors_["1038"]
			local var_691_16 = 0

			if var_691_16 < arg_688_1.time_ and arg_688_1.time_ <= var_691_16 + arg_691_0 then
				local var_691_17 = var_691_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_691_17 then
					arg_688_1.var_.alphaOldValue1038 = var_691_17.alpha
					arg_688_1.var_.characterEffect1038 = var_691_17
				end

				arg_688_1.var_.alphaOldValue1038 = 0
			end

			local var_691_18 = 0.333333333333333

			if var_691_16 <= arg_688_1.time_ and arg_688_1.time_ < var_691_16 + var_691_18 then
				local var_691_19 = (arg_688_1.time_ - var_691_16) / var_691_18
				local var_691_20 = Mathf.Lerp(arg_688_1.var_.alphaOldValue1038, 1, var_691_19)

				if arg_688_1.var_.characterEffect1038 then
					arg_688_1.var_.characterEffect1038.alpha = var_691_20
				end
			end

			if arg_688_1.time_ >= var_691_16 + var_691_18 and arg_688_1.time_ < var_691_16 + var_691_18 + arg_691_0 and arg_688_1.var_.characterEffect1038 then
				arg_688_1.var_.characterEffect1038.alpha = 1
			end

			local var_691_21 = 0
			local var_691_22 = 0.7

			if var_691_21 < arg_688_1.time_ and arg_688_1.time_ <= var_691_21 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0
				arg_688_1.dialogCg_.alpha = 1

				arg_688_1.dialog_:SetActive(true)
				SetActive(arg_688_1.leftNameGo_, true)

				local var_691_23 = arg_688_1:FormatText(StoryNameCfg[94].name)

				arg_688_1.leftNameTxt_.text = var_691_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_688_1.leftNameTxt_.transform)

				arg_688_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_688_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_688_1:RecordName(arg_688_1.leftNameTxt_.text)
				SetActive(arg_688_1.iconTrs_.gameObject, false)
				arg_688_1.callingController_:SetSelectedState("normal")

				local var_691_24 = arg_688_1:GetWordFromCfg(115301169)
				local var_691_25 = arg_688_1:FormatText(var_691_24.content)

				arg_688_1.text_.text = var_691_25

				LuaForUtil.ClearLinePrefixSymbol(arg_688_1.text_)

				local var_691_26 = 28
				local var_691_27 = utf8.len(var_691_25)
				local var_691_28 = var_691_26 <= 0 and var_691_22 or var_691_22 * (var_691_27 / var_691_26)

				if var_691_28 > 0 and var_691_22 < var_691_28 then
					arg_688_1.talkMaxDuration = var_691_28

					if var_691_28 + var_691_21 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_28 + var_691_21
					end
				end

				arg_688_1.text_.text = var_691_25
				arg_688_1.typewritter.percent = 0

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301169", "story_v_out_115301.awb") ~= 0 then
					local var_691_29 = manager.audio:GetVoiceLength("story_v_out_115301", "115301169", "story_v_out_115301.awb") / 1000

					if var_691_29 + var_691_21 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_29 + var_691_21
					end

					if var_691_24.prefab_name ~= "" and arg_688_1.actors_[var_691_24.prefab_name] ~= nil then
						local var_691_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_688_1.actors_[var_691_24.prefab_name].transform, "story_v_out_115301", "115301169", "story_v_out_115301.awb")

						arg_688_1:RecordAudio("115301169", var_691_30)
						arg_688_1:RecordAudio("115301169", var_691_30)
					else
						arg_688_1:AudioAction("play", "voice", "story_v_out_115301", "115301169", "story_v_out_115301.awb")
					end

					arg_688_1:RecordHistoryTalkVoice("story_v_out_115301", "115301169", "story_v_out_115301.awb")
				end

				arg_688_1:RecordContent(arg_688_1.text_.text)
			end

			local var_691_31 = math.max(var_691_22, arg_688_1.talkMaxDuration)

			if var_691_21 <= arg_688_1.time_ and arg_688_1.time_ < var_691_21 + var_691_31 then
				arg_688_1.typewritter.percent = (arg_688_1.time_ - var_691_21) / var_691_31

				arg_688_1.typewritter:SetDirty()
			end

			if arg_688_1.time_ >= var_691_21 + var_691_31 and arg_688_1.time_ < var_691_21 + var_691_31 + arg_691_0 then
				arg_688_1.typewritter.percent = 1

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(true)
			end
		end

		arg_688_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_688_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F01",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/RO0503",
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/F01a"
	},
	voices = {
		"story_v_out_115301.awb"
	}
}
