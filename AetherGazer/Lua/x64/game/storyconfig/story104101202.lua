return {
	Play410122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410122001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play410122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST62a"

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
				local var_4_5 = arg_1_1.bgs_.ST62a

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
					if iter_4_0 ~= "ST62a" then
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

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

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
			local var_4_35 = 1.225

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

				local var_4_37 = arg_1_1:GetWordFromCfg(410122001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 49
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
	Play410122002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410122002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410122003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.725

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(410122002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 69
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play410122003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410122003
		arg_13_1.duration_ = 8.47

		local var_13_0 = {
			zh = 3.2,
			ja = 8.466
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
				arg_13_0:Play410122004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.5

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[589].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(410122003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122003", "story_v_out_410122.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122003", "story_v_out_410122.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_410122", "410122003", "story_v_out_410122.awb")

						arg_13_1:RecordAudio("410122003", var_16_9)
						arg_13_1:RecordAudio("410122003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410122", "410122003", "story_v_out_410122.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410122", "410122003", "story_v_out_410122.awb")
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
	Play410122004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410122004
		arg_17_1.duration_ = 5.57

		local var_17_0 = {
			zh = 2.966,
			ja = 5.566
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
				arg_17_0:Play410122005(arg_17_1)
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

			local var_20_11 = "1052"

			if arg_17_1.actors_[var_20_11] == nil then
				local var_20_12 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1052")

				if not isNil(var_20_12) then
					local var_20_13 = Object.Instantiate(var_20_12, arg_17_1.canvasGo_.transform)

					var_20_13.transform:SetSiblingIndex(1)

					var_20_13.name = var_20_11
					var_20_13.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_11] = var_20_13

					local var_20_14 = var_20_13:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_3, iter_20_4 in ipairs(var_20_14) do
							iter_20_4.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_15 = arg_17_1.actors_["1052"].transform
			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.var_.moveOldPos1052 = var_20_15.localPosition
				var_20_15.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1052", 4)

				local var_20_17 = var_20_15.childCount

				for iter_20_5 = 0, var_20_17 - 1 do
					local var_20_18 = var_20_15:GetChild(iter_20_5)

					if var_20_18.name == "" or not string.find(var_20_18.name, "split") then
						var_20_18.gameObject:SetActive(true)
					else
						var_20_18.gameObject:SetActive(false)
					end
				end
			end

			local var_20_19 = 0.001

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_19 then
				local var_20_20 = (arg_17_1.time_ - var_20_16) / var_20_19
				local var_20_21 = Vector3.New(390, -435, -200)

				var_20_15.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1052, var_20_21, var_20_20)
			end

			if arg_17_1.time_ >= var_20_16 + var_20_19 and arg_17_1.time_ < var_20_16 + var_20_19 + arg_20_0 then
				var_20_15.localPosition = Vector3.New(390, -435, -200)
			end

			local var_20_22 = arg_17_1.actors_["1060"]
			local var_20_23 = 0

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.actorSpriteComps1060 == nil then
				arg_17_1.var_.actorSpriteComps1060 = var_20_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_24 = 0.034

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_24 and not isNil(var_20_22) then
				local var_20_25 = (arg_17_1.time_ - var_20_23) / var_20_24

				if arg_17_1.var_.actorSpriteComps1060 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								local var_20_26 = Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor1.r, var_20_25)
								local var_20_27 = Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor1.g, var_20_25)
								local var_20_28 = Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor1.b, var_20_25)

								iter_20_7.color = Color.New(var_20_26, var_20_27, var_20_28)
							else
								local var_20_29 = Mathf.Lerp(iter_20_7.color.r, 1, var_20_25)

								iter_20_7.color = Color.New(var_20_29, var_20_29, var_20_29)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_23 + var_20_24 and arg_17_1.time_ < var_20_23 + var_20_24 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.actorSpriteComps1060 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_20_9 then
						if arg_17_1.isInRecall_ then
							iter_20_9.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1060 = nil
			end

			local var_20_30 = arg_17_1.actors_["1052"]
			local var_20_31 = 0

			if var_20_31 < arg_17_1.time_ and arg_17_1.time_ <= var_20_31 + arg_20_0 and not isNil(var_20_30) and arg_17_1.var_.actorSpriteComps1052 == nil then
				arg_17_1.var_.actorSpriteComps1052 = var_20_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_32 = 0.034

			if var_20_31 <= arg_17_1.time_ and arg_17_1.time_ < var_20_31 + var_20_32 and not isNil(var_20_30) then
				local var_20_33 = (arg_17_1.time_ - var_20_31) / var_20_32

				if arg_17_1.var_.actorSpriteComps1052 then
					for iter_20_10, iter_20_11 in pairs(arg_17_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_20_11 then
							if arg_17_1.isInRecall_ then
								local var_20_34 = Mathf.Lerp(iter_20_11.color.r, arg_17_1.hightColor2.r, var_20_33)
								local var_20_35 = Mathf.Lerp(iter_20_11.color.g, arg_17_1.hightColor2.g, var_20_33)
								local var_20_36 = Mathf.Lerp(iter_20_11.color.b, arg_17_1.hightColor2.b, var_20_33)

								iter_20_11.color = Color.New(var_20_34, var_20_35, var_20_36)
							else
								local var_20_37 = Mathf.Lerp(iter_20_11.color.r, 0.5, var_20_33)

								iter_20_11.color = Color.New(var_20_37, var_20_37, var_20_37)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_31 + var_20_32 and arg_17_1.time_ < var_20_31 + var_20_32 + arg_20_0 and not isNil(var_20_30) and arg_17_1.var_.actorSpriteComps1052 then
				for iter_20_12, iter_20_13 in pairs(arg_17_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_20_13 then
						if arg_17_1.isInRecall_ then
							iter_20_13.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_13.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1052 = nil
			end

			local var_20_38 = 0
			local var_20_39 = 0.375

			if var_20_38 < arg_17_1.time_ and arg_17_1.time_ <= var_20_38 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_40 = arg_17_1:FormatText(StoryNameCfg[584].name)

				arg_17_1.leftNameTxt_.text = var_20_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_41 = arg_17_1:GetWordFromCfg(410122004)
				local var_20_42 = arg_17_1:FormatText(var_20_41.content)

				arg_17_1.text_.text = var_20_42

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_43 = 15
				local var_20_44 = utf8.len(var_20_42)
				local var_20_45 = var_20_43 <= 0 and var_20_39 or var_20_39 * (var_20_44 / var_20_43)

				if var_20_45 > 0 and var_20_39 < var_20_45 then
					arg_17_1.talkMaxDuration = var_20_45

					if var_20_45 + var_20_38 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_45 + var_20_38
					end
				end

				arg_17_1.text_.text = var_20_42
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122004", "story_v_out_410122.awb") ~= 0 then
					local var_20_46 = manager.audio:GetVoiceLength("story_v_out_410122", "410122004", "story_v_out_410122.awb") / 1000

					if var_20_46 + var_20_38 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_46 + var_20_38
					end

					if var_20_41.prefab_name ~= "" and arg_17_1.actors_[var_20_41.prefab_name] ~= nil then
						local var_20_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_41.prefab_name].transform, "story_v_out_410122", "410122004", "story_v_out_410122.awb")

						arg_17_1:RecordAudio("410122004", var_20_47)
						arg_17_1:RecordAudio("410122004", var_20_47)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410122", "410122004", "story_v_out_410122.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410122", "410122004", "story_v_out_410122.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_48 = math.max(var_20_39, arg_17_1.talkMaxDuration)

			if var_20_38 <= arg_17_1.time_ and arg_17_1.time_ < var_20_38 + var_20_48 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_38) / var_20_48

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_38 + var_20_48 and arg_17_1.time_ < var_20_38 + var_20_48 + arg_20_0 then
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
				actorName = "1052",
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
	Play410122005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410122005
		arg_21_1.duration_ = 9.57

		local var_21_0 = {
			zh = 5.4,
			ja = 9.566
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
				arg_21_0:Play410122006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1060"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1060 == nil then
				arg_21_1.var_.actorSpriteComps1060 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.034

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps1060 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1060 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1060 = nil
			end

			local var_24_8 = arg_21_1.actors_["1052"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1052 == nil then
				arg_21_1.var_.actorSpriteComps1052 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.034

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps1052 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1052:ToTable()) do
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

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1052 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1052 = nil
			end

			local var_24_16 = 0
			local var_24_17 = 0.7

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_18 = arg_21_1:FormatText(StoryNameCfg[263].name)

				arg_21_1.leftNameTxt_.text = var_24_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:GetWordFromCfg(410122005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122005", "story_v_out_410122.awb") ~= 0 then
					local var_24_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122005", "story_v_out_410122.awb") / 1000

					if var_24_24 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_16
					end

					if var_24_19.prefab_name ~= "" and arg_21_1.actors_[var_24_19.prefab_name] ~= nil then
						local var_24_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_19.prefab_name].transform, "story_v_out_410122", "410122005", "story_v_out_410122.awb")

						arg_21_1:RecordAudio("410122005", var_24_25)
						arg_21_1:RecordAudio("410122005", var_24_25)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410122", "410122005", "story_v_out_410122.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410122", "410122005", "story_v_out_410122.awb")
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
	Play410122006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410122006
		arg_25_1.duration_ = 9.57

		local var_25_0 = {
			zh = 9.566,
			ja = 8.433
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
				arg_25_0:Play410122007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 1.2

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[263].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(410122006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122006", "story_v_out_410122.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122006", "story_v_out_410122.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_410122", "410122006", "story_v_out_410122.awb")

						arg_25_1:RecordAudio("410122006", var_28_9)
						arg_25_1:RecordAudio("410122006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410122", "410122006", "story_v_out_410122.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410122", "410122006", "story_v_out_410122.awb")
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
	Play410122007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410122007
		arg_29_1.duration_ = 7.8

		local var_29_0 = {
			zh = 7.8,
			ja = 7.766
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
				arg_29_0:Play410122008(arg_29_1)
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
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor1.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor1.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor1.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 1, var_32_3)

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
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1060 = nil
			end

			local var_32_8 = arg_29_1.actors_["1052"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1052 == nil then
				arg_29_1.var_.actorSpriteComps1052 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.034

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps1052 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps1052:ToTable()) do
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

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1052 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1052 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.9

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_18 = arg_29_1:FormatText(StoryNameCfg[584].name)

				arg_29_1.leftNameTxt_.text = var_32_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(410122007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 36
				local var_32_22 = utf8.len(var_32_20)
				local var_32_23 = var_32_21 <= 0 and var_32_17 or var_32_17 * (var_32_22 / var_32_21)

				if var_32_23 > 0 and var_32_17 < var_32_23 then
					arg_29_1.talkMaxDuration = var_32_23

					if var_32_23 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_16
					end
				end

				arg_29_1.text_.text = var_32_20
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122007", "story_v_out_410122.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122007", "story_v_out_410122.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_410122", "410122007", "story_v_out_410122.awb")

						arg_29_1:RecordAudio("410122007", var_32_25)
						arg_29_1:RecordAudio("410122007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410122", "410122007", "story_v_out_410122.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410122", "410122007", "story_v_out_410122.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_26 = math.max(var_32_17, arg_29_1.talkMaxDuration)

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_26 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_16) / var_32_26

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_16 + var_32_26 and arg_29_1.time_ < var_32_16 + var_32_26 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play410122008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410122008
		arg_33_1.duration_ = 8.3

		local var_33_0 = {
			zh = 5.566,
			ja = 8.3
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
				arg_33_0:Play410122009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1052"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1052 == nil then
				arg_33_1.var_.actorSpriteComps1052 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.034

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps1052 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_4 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, var_36_3)
								local var_36_5 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, var_36_3)
								local var_36_6 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, var_36_3)

								iter_36_1.color = Color.New(var_36_4, var_36_5, var_36_6)
							else
								local var_36_7 = Mathf.Lerp(iter_36_1.color.r, 1, var_36_3)

								iter_36_1.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1052 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1052 = nil
			end

			local var_36_8 = arg_33_1.actors_["1060"]
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps1060 == nil then
				arg_33_1.var_.actorSpriteComps1060 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_10 = 0.034

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_10 and not isNil(var_36_8) then
				local var_36_11 = (arg_33_1.time_ - var_36_9) / var_36_10

				if arg_33_1.var_.actorSpriteComps1060 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								local var_36_12 = Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor2.r, var_36_11)
								local var_36_13 = Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor2.g, var_36_11)
								local var_36_14 = Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor2.b, var_36_11)

								iter_36_5.color = Color.New(var_36_12, var_36_13, var_36_14)
							else
								local var_36_15 = Mathf.Lerp(iter_36_5.color.r, 0.5, var_36_11)

								iter_36_5.color = Color.New(var_36_15, var_36_15, var_36_15)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_9 + var_36_10 and arg_33_1.time_ < var_36_9 + var_36_10 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps1060 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_36_7 then
						if arg_33_1.isInRecall_ then
							iter_36_7.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1060 = nil
			end

			local var_36_16 = 0
			local var_36_17 = 0.7

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_18 = arg_33_1:FormatText(StoryNameCfg[263].name)

				arg_33_1.leftNameTxt_.text = var_36_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_19 = arg_33_1:GetWordFromCfg(410122008)
				local var_36_20 = arg_33_1:FormatText(var_36_19.content)

				arg_33_1.text_.text = var_36_20

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_21 = 28
				local var_36_22 = utf8.len(var_36_20)
				local var_36_23 = var_36_21 <= 0 and var_36_17 or var_36_17 * (var_36_22 / var_36_21)

				if var_36_23 > 0 and var_36_17 < var_36_23 then
					arg_33_1.talkMaxDuration = var_36_23

					if var_36_23 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_16
					end
				end

				arg_33_1.text_.text = var_36_20
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122008", "story_v_out_410122.awb") ~= 0 then
					local var_36_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122008", "story_v_out_410122.awb") / 1000

					if var_36_24 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_24 + var_36_16
					end

					if var_36_19.prefab_name ~= "" and arg_33_1.actors_[var_36_19.prefab_name] ~= nil then
						local var_36_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_19.prefab_name].transform, "story_v_out_410122", "410122008", "story_v_out_410122.awb")

						arg_33_1:RecordAudio("410122008", var_36_25)
						arg_33_1:RecordAudio("410122008", var_36_25)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410122", "410122008", "story_v_out_410122.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410122", "410122008", "story_v_out_410122.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_26 = math.max(var_36_17, arg_33_1.talkMaxDuration)

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_26 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_16) / var_36_26

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_16 + var_36_26 and arg_33_1.time_ < var_36_16 + var_36_26 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play410122009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410122009
		arg_37_1.duration_ = 8.2

		local var_37_0 = {
			zh = 3.933,
			ja = 8.2
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
				arg_37_0:Play410122010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.5

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[589].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(410122009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 20
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122009", "story_v_out_410122.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122009", "story_v_out_410122.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_410122", "410122009", "story_v_out_410122.awb")

						arg_37_1:RecordAudio("410122009", var_40_9)
						arg_37_1:RecordAudio("410122009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410122", "410122009", "story_v_out_410122.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410122", "410122009", "story_v_out_410122.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play410122010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410122010
		arg_41_1.duration_ = 7.37

		local var_41_0 = {
			zh = 3.8,
			ja = 7.366
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
				arg_41_0:Play410122011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1060"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1060 == nil then
				arg_41_1.var_.actorSpriteComps1060 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.034

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps1060 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 0.5, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1060 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1060 = nil
			end

			local var_44_8 = arg_41_1.actors_["1052"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps1052 == nil then
				arg_41_1.var_.actorSpriteComps1052 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.034

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps1052 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								local var_44_12 = Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor1.r, var_44_11)
								local var_44_13 = Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor1.g, var_44_11)
								local var_44_14 = Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor1.b, var_44_11)

								iter_44_5.color = Color.New(var_44_12, var_44_13, var_44_14)
							else
								local var_44_15 = Mathf.Lerp(iter_44_5.color.r, 1, var_44_11)

								iter_44_5.color = Color.New(var_44_15, var_44_15, var_44_15)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps1052 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1052 = nil
			end

			local var_44_16 = 0
			local var_44_17 = 0.525

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_18 = arg_41_1:FormatText(StoryNameCfg[263].name)

				arg_41_1.leftNameTxt_.text = var_44_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_19 = arg_41_1:GetWordFromCfg(410122010)
				local var_44_20 = arg_41_1:FormatText(var_44_19.content)

				arg_41_1.text_.text = var_44_20

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_21 = 21
				local var_44_22 = utf8.len(var_44_20)
				local var_44_23 = var_44_21 <= 0 and var_44_17 or var_44_17 * (var_44_22 / var_44_21)

				if var_44_23 > 0 and var_44_17 < var_44_23 then
					arg_41_1.talkMaxDuration = var_44_23

					if var_44_23 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_16
					end
				end

				arg_41_1.text_.text = var_44_20
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122010", "story_v_out_410122.awb") ~= 0 then
					local var_44_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122010", "story_v_out_410122.awb") / 1000

					if var_44_24 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_16
					end

					if var_44_19.prefab_name ~= "" and arg_41_1.actors_[var_44_19.prefab_name] ~= nil then
						local var_44_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_19.prefab_name].transform, "story_v_out_410122", "410122010", "story_v_out_410122.awb")

						arg_41_1:RecordAudio("410122010", var_44_25)
						arg_41_1:RecordAudio("410122010", var_44_25)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410122", "410122010", "story_v_out_410122.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410122", "410122010", "story_v_out_410122.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_26 = math.max(var_44_17, arg_41_1.talkMaxDuration)

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_26 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_16) / var_44_26

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_16 + var_44_26 and arg_41_1.time_ < var_44_16 + var_44_26 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play410122011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410122011
		arg_45_1.duration_ = 13.43

		local var_45_0 = {
			zh = 8.866,
			ja = 13.433
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
				arg_45_0:Play410122012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.025

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[263].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(410122011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122011", "story_v_out_410122.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122011", "story_v_out_410122.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_410122", "410122011", "story_v_out_410122.awb")

						arg_45_1:RecordAudio("410122011", var_48_9)
						arg_45_1:RecordAudio("410122011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410122", "410122011", "story_v_out_410122.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410122", "410122011", "story_v_out_410122.awb")
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
	Play410122012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410122012
		arg_49_1.duration_ = 3.87

		local var_49_0 = {
			zh = 2.2,
			ja = 3.866
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
				arg_49_0:Play410122013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.175

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[589].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(410122012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 7
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122012", "story_v_out_410122.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122012", "story_v_out_410122.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_410122", "410122012", "story_v_out_410122.awb")

						arg_49_1:RecordAudio("410122012", var_52_9)
						arg_49_1:RecordAudio("410122012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410122", "410122012", "story_v_out_410122.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410122", "410122012", "story_v_out_410122.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play410122013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410122013
		arg_53_1.duration_ = 9.3

		local var_53_0 = {
			zh = 4.033,
			ja = 9.3
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
				arg_53_0:Play410122014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.575

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[263].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(410122013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122013", "story_v_out_410122.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122013", "story_v_out_410122.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_410122", "410122013", "story_v_out_410122.awb")

						arg_53_1:RecordAudio("410122013", var_56_9)
						arg_53_1:RecordAudio("410122013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410122", "410122013", "story_v_out_410122.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410122", "410122013", "story_v_out_410122.awb")
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
	Play410122014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410122014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410122015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1060"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1060 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1060", 7)

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
				local var_60_6 = Vector3.New(0, -2000, -40)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1060, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_60_7 = arg_57_1.actors_["1052"].transform
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.var_.moveOldPos1052 = var_60_7.localPosition
				var_60_7.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1052", 7)

				local var_60_9 = var_60_7.childCount

				for iter_60_1 = 0, var_60_9 - 1 do
					local var_60_10 = var_60_7:GetChild(iter_60_1)

					if var_60_10.name == "" or not string.find(var_60_10.name, "split") then
						var_60_10.gameObject:SetActive(true)
					else
						var_60_10.gameObject:SetActive(false)
					end
				end
			end

			local var_60_11 = 0.001

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_11 then
				local var_60_12 = (arg_57_1.time_ - var_60_8) / var_60_11
				local var_60_13 = Vector3.New(0, -2000, -200)

				var_60_7.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1052, var_60_13, var_60_12)
			end

			if arg_57_1.time_ >= var_60_8 + var_60_11 and arg_57_1.time_ < var_60_8 + var_60_11 + arg_60_0 then
				var_60_7.localPosition = Vector3.New(0, -2000, -200)
			end

			local var_60_14 = arg_57_1.actors_["1060"]
			local var_60_15 = 0

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 and not isNil(var_60_14) and arg_57_1.var_.actorSpriteComps1060 == nil then
				arg_57_1.var_.actorSpriteComps1060 = var_60_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_16 = 0.034

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_16 and not isNil(var_60_14) then
				local var_60_17 = (arg_57_1.time_ - var_60_15) / var_60_16

				if arg_57_1.var_.actorSpriteComps1060 then
					for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_60_3 then
							if arg_57_1.isInRecall_ then
								local var_60_18 = Mathf.Lerp(iter_60_3.color.r, arg_57_1.hightColor2.r, var_60_17)
								local var_60_19 = Mathf.Lerp(iter_60_3.color.g, arg_57_1.hightColor2.g, var_60_17)
								local var_60_20 = Mathf.Lerp(iter_60_3.color.b, arg_57_1.hightColor2.b, var_60_17)

								iter_60_3.color = Color.New(var_60_18, var_60_19, var_60_20)
							else
								local var_60_21 = Mathf.Lerp(iter_60_3.color.r, 0.5, var_60_17)

								iter_60_3.color = Color.New(var_60_21, var_60_21, var_60_21)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_15 + var_60_16 and arg_57_1.time_ < var_60_15 + var_60_16 + arg_60_0 and not isNil(var_60_14) and arg_57_1.var_.actorSpriteComps1060 then
				for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_60_5 then
						if arg_57_1.isInRecall_ then
							iter_60_5.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1060 = nil
			end

			local var_60_22 = arg_57_1.actors_["1052"]
			local var_60_23 = 0

			if var_60_23 < arg_57_1.time_ and arg_57_1.time_ <= var_60_23 + arg_60_0 and not isNil(var_60_22) and arg_57_1.var_.actorSpriteComps1052 == nil then
				arg_57_1.var_.actorSpriteComps1052 = var_60_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_24 = 0.034

			if var_60_23 <= arg_57_1.time_ and arg_57_1.time_ < var_60_23 + var_60_24 and not isNil(var_60_22) then
				local var_60_25 = (arg_57_1.time_ - var_60_23) / var_60_24

				if arg_57_1.var_.actorSpriteComps1052 then
					for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps1052:ToTable()) do
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

			if arg_57_1.time_ >= var_60_23 + var_60_24 and arg_57_1.time_ < var_60_23 + var_60_24 + arg_60_0 and not isNil(var_60_22) and arg_57_1.var_.actorSpriteComps1052 then
				for iter_60_8, iter_60_9 in pairs(arg_57_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_60_9 then
						if arg_57_1.isInRecall_ then
							iter_60_9.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1052 = nil
			end

			local var_60_30 = 0
			local var_60_31 = 0.875

			if var_60_30 < arg_57_1.time_ and arg_57_1.time_ <= var_60_30 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_32 = arg_57_1:GetWordFromCfg(410122014)
				local var_60_33 = arg_57_1:FormatText(var_60_32.content)

				arg_57_1.text_.text = var_60_33

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_34 = 35
				local var_60_35 = utf8.len(var_60_33)
				local var_60_36 = var_60_34 <= 0 and var_60_31 or var_60_31 * (var_60_35 / var_60_34)

				if var_60_36 > 0 and var_60_31 < var_60_36 then
					arg_57_1.talkMaxDuration = var_60_36

					if var_60_36 + var_60_30 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_36 + var_60_30
					end
				end

				arg_57_1.text_.text = var_60_33
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_37 = math.max(var_60_31, arg_57_1.talkMaxDuration)

			if var_60_30 <= arg_57_1.time_ and arg_57_1.time_ < var_60_30 + var_60_37 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_30) / var_60_37

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_30 + var_60_37 and arg_57_1.time_ < var_60_30 + var_60_37 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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
				actorName = "1052",
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
	Play410122015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410122015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play410122016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.45

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(410122015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 58
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play410122016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410122016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play410122017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 1.25

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(410122016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 50
				local var_68_5 = utf8.len(var_68_3)
				local var_68_6 = var_68_4 <= 0 and var_68_1 or var_68_1 * (var_68_5 / var_68_4)

				if var_68_6 > 0 and var_68_1 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_7 and arg_65_1.time_ < var_68_0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play410122017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410122017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play410122018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.225

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(410122017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 49
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play410122018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410122018
		arg_73_1.duration_ = 5.4

		local var_73_0 = {
			zh = 5.4,
			ja = 4.366
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
				arg_73_0:Play410122019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.725

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[36].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(410122018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 29
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122018", "story_v_out_410122.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122018", "story_v_out_410122.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_410122", "410122018", "story_v_out_410122.awb")

						arg_73_1:RecordAudio("410122018", var_76_9)
						arg_73_1:RecordAudio("410122018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410122", "410122018", "story_v_out_410122.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410122", "410122018", "story_v_out_410122.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play410122019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410122019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play410122020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.4

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(410122019)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 56
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play410122020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410122020
		arg_81_1.duration_ = 2.23

		local var_81_0 = {
			zh = 2.233,
			ja = 1.833
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
				arg_81_0:Play410122021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1060"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1060 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1060", 3)

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
				local var_84_6 = Vector3.New(33.4, -430.8, 6.9)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1060, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
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

			local var_84_15 = 0
			local var_84_16 = 0.175

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_17 = arg_81_1:FormatText(StoryNameCfg[584].name)

				arg_81_1.leftNameTxt_.text = var_84_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_18 = arg_81_1:GetWordFromCfg(410122020)
				local var_84_19 = arg_81_1:FormatText(var_84_18.content)

				arg_81_1.text_.text = var_84_19

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_20 = 7
				local var_84_21 = utf8.len(var_84_19)
				local var_84_22 = var_84_20 <= 0 and var_84_16 or var_84_16 * (var_84_21 / var_84_20)

				if var_84_22 > 0 and var_84_16 < var_84_22 then
					arg_81_1.talkMaxDuration = var_84_22

					if var_84_22 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_22 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_19
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122020", "story_v_out_410122.awb") ~= 0 then
					local var_84_23 = manager.audio:GetVoiceLength("story_v_out_410122", "410122020", "story_v_out_410122.awb") / 1000

					if var_84_23 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_15
					end

					if var_84_18.prefab_name ~= "" and arg_81_1.actors_[var_84_18.prefab_name] ~= nil then
						local var_84_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_18.prefab_name].transform, "story_v_out_410122", "410122020", "story_v_out_410122.awb")

						arg_81_1:RecordAudio("410122020", var_84_24)
						arg_81_1:RecordAudio("410122020", var_84_24)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410122", "410122020", "story_v_out_410122.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410122", "410122020", "story_v_out_410122.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_25 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_25 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_25

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_25 and arg_81_1.time_ < var_84_15 + var_84_25 + arg_84_0 then
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
	Play410122021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410122021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play410122022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1060"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1060 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1060", 7)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(0, -2000, -40)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1060, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_88_7 = arg_85_1.actors_["1060"]
			local var_88_8 = 0

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps1060 == nil then
				arg_85_1.var_.actorSpriteComps1060 = var_88_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_9 = 0.034

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 and not isNil(var_88_7) then
				local var_88_10 = (arg_85_1.time_ - var_88_8) / var_88_9

				if arg_85_1.var_.actorSpriteComps1060 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								local var_88_11 = Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor2.r, var_88_10)
								local var_88_12 = Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor2.g, var_88_10)
								local var_88_13 = Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor2.b, var_88_10)

								iter_88_2.color = Color.New(var_88_11, var_88_12, var_88_13)
							else
								local var_88_14 = Mathf.Lerp(iter_88_2.color.r, 0.5, var_88_10)

								iter_88_2.color = Color.New(var_88_14, var_88_14, var_88_14)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps1060 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_88_4 then
						if arg_85_1.isInRecall_ then
							iter_88_4.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1060 = nil
			end

			local var_88_15 = 0
			local var_88_16 = 1.3

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_17 = arg_85_1:GetWordFromCfg(410122021)
				local var_88_18 = arg_85_1:FormatText(var_88_17.content)

				arg_85_1.text_.text = var_88_18

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_19 = 52
				local var_88_20 = utf8.len(var_88_18)
				local var_88_21 = var_88_19 <= 0 and var_88_16 or var_88_16 * (var_88_20 / var_88_19)

				if var_88_21 > 0 and var_88_16 < var_88_21 then
					arg_85_1.talkMaxDuration = var_88_21

					if var_88_21 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_21 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_18
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_22 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_22 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_22

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_22 and arg_85_1.time_ < var_88_15 + var_88_22 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play410122022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410122022
		arg_89_1.duration_ = 4.87

		local var_89_0 = {
			zh = 4.866,
			ja = 3.466
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
				arg_89_0:Play410122023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1060"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1060 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1060", 3)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "split_3" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(33.4, -430.8, 6.9)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1060, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
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

			local var_92_15 = 0
			local var_92_16 = 0.575

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[584].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(410122022)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 23
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122022", "story_v_out_410122.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_410122", "410122022", "story_v_out_410122.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_410122", "410122022", "story_v_out_410122.awb")

						arg_89_1:RecordAudio("410122022", var_92_24)
						arg_89_1:RecordAudio("410122022", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410122", "410122022", "story_v_out_410122.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410122", "410122022", "story_v_out_410122.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
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
	Play410122023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410122023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play410122024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1060"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1060 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1060", 7)

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
				local var_96_6 = Vector3.New(0, -2000, -40)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1060, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_96_7 = arg_93_1.actors_["1060"]
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps1060 == nil then
				arg_93_1.var_.actorSpriteComps1060 = var_96_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 0.034

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 and not isNil(var_96_7) then
				local var_96_10 = (arg_93_1.time_ - var_96_8) / var_96_9

				if arg_93_1.var_.actorSpriteComps1060 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								local var_96_11 = Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor2.r, var_96_10)
								local var_96_12 = Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor2.g, var_96_10)
								local var_96_13 = Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor2.b, var_96_10)

								iter_96_2.color = Color.New(var_96_11, var_96_12, var_96_13)
							else
								local var_96_14 = Mathf.Lerp(iter_96_2.color.r, 0.5, var_96_10)

								iter_96_2.color = Color.New(var_96_14, var_96_14, var_96_14)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps1060 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_96_4 then
						if arg_93_1.isInRecall_ then
							iter_96_4.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1060 = nil
			end

			local var_96_15 = 0
			local var_96_16 = 1.575

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_17 = arg_93_1:GetWordFromCfg(410122023)
				local var_96_18 = arg_93_1:FormatText(var_96_17.content)

				arg_93_1.text_.text = var_96_18

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_19 = 63
				local var_96_20 = utf8.len(var_96_18)
				local var_96_21 = var_96_19 <= 0 and var_96_16 or var_96_16 * (var_96_20 / var_96_19)

				if var_96_21 > 0 and var_96_16 < var_96_21 then
					arg_93_1.talkMaxDuration = var_96_21

					if var_96_21 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_18
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_22 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_22

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_22 and arg_93_1.time_ < var_96_15 + var_96_22 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play410122024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410122024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play410122025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1.15

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(410122024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 46
				local var_100_5 = utf8.len(var_100_3)
				local var_100_6 = var_100_4 <= 0 and var_100_1 or var_100_1 * (var_100_5 / var_100_4)

				if var_100_6 > 0 and var_100_1 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_7 and arg_97_1.time_ < var_100_0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play410122025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410122025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play410122026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.125

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(410122025)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 45
				local var_104_5 = utf8.len(var_104_3)
				local var_104_6 = var_104_4 <= 0 and var_104_1 or var_104_1 * (var_104_5 / var_104_4)

				if var_104_6 > 0 and var_104_1 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_7 and arg_101_1.time_ < var_104_0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play410122026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410122026
		arg_105_1.duration_ = 2.9

		local var_105_0 = {
			zh = 0.999999999999,
			ja = 2.9
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
				arg_105_0:Play410122027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1052"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1052 = var_108_0.localPosition
				var_108_0.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1052", 3)

				local var_108_2 = var_108_0.childCount

				for iter_108_0 = 0, var_108_2 - 1 do
					local var_108_3 = var_108_0:GetChild(iter_108_0)

					if var_108_3.name == "split_2" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_4 then
				local var_108_5 = (arg_105_1.time_ - var_108_1) / var_108_4
				local var_108_6 = Vector3.New(0, -435, -200)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1052, var_108_6, var_108_5)
			end

			if arg_105_1.time_ >= var_108_1 + var_108_4 and arg_105_1.time_ < var_108_1 + var_108_4 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -435, -200)
			end

			local var_108_7 = arg_105_1.actors_["1052"]
			local var_108_8 = 0

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps1052 == nil then
				arg_105_1.var_.actorSpriteComps1052 = var_108_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_9 = 0.034

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 and not isNil(var_108_7) then
				local var_108_10 = (arg_105_1.time_ - var_108_8) / var_108_9

				if arg_105_1.var_.actorSpriteComps1052 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps1052:ToTable()) do
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

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps1052 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_108_4 then
						if arg_105_1.isInRecall_ then
							iter_108_4.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1052 = nil
			end

			local var_108_15 = 0
			local var_108_16 = 0.075

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[263].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(410122026)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 3
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122026", "story_v_out_410122.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_410122", "410122026", "story_v_out_410122.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_410122", "410122026", "story_v_out_410122.awb")

						arg_105_1:RecordAudio("410122026", var_108_24)
						arg_105_1:RecordAudio("410122026", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_410122", "410122026", "story_v_out_410122.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_410122", "410122026", "story_v_out_410122.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_25 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_25 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_25

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_25 and arg_105_1.time_ < var_108_15 + var_108_25 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052",
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
	Play410122027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410122027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play410122028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1052"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1052 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1052", 7)

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
				local var_112_6 = Vector3.New(0, -2000, -200)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1052, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -2000, -200)
			end

			local var_112_7 = arg_109_1.actors_["1052"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps1052 == nil then
				arg_109_1.var_.actorSpriteComps1052 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 0.034

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps1052 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_11 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor2.r, var_112_10)
								local var_112_12 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor2.g, var_112_10)
								local var_112_13 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor2.b, var_112_10)

								iter_112_2.color = Color.New(var_112_11, var_112_12, var_112_13)
							else
								local var_112_14 = Mathf.Lerp(iter_112_2.color.r, 0.5, var_112_10)

								iter_112_2.color = Color.New(var_112_14, var_112_14, var_112_14)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps1052 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1052 = nil
			end

			local var_112_15 = 0
			local var_112_16 = 1

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				local var_112_17 = "play"
				local var_112_18 = "effect"

				arg_109_1:AudioAction(var_112_17, var_112_18, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_112_19 = 0
			local var_112_20 = 1.4

			if var_112_19 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_21 = arg_109_1:GetWordFromCfg(410122027)
				local var_112_22 = arg_109_1:FormatText(var_112_21.content)

				arg_109_1.text_.text = var_112_22

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_23 = 56
				local var_112_24 = utf8.len(var_112_22)
				local var_112_25 = var_112_23 <= 0 and var_112_20 or var_112_20 * (var_112_24 / var_112_23)

				if var_112_25 > 0 and var_112_20 < var_112_25 then
					arg_109_1.talkMaxDuration = var_112_25

					if var_112_25 + var_112_19 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_25 + var_112_19
					end
				end

				arg_109_1.text_.text = var_112_22
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_26 = math.max(var_112_20, arg_109_1.talkMaxDuration)

			if var_112_19 <= arg_109_1.time_ and arg_109_1.time_ < var_112_19 + var_112_26 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_19) / var_112_26

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_19 + var_112_26 and arg_109_1.time_ < var_112_19 + var_112_26 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052",
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
	Play410122028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410122028
		arg_113_1.duration_ = 5.4

		local var_113_0 = {
			zh = 2.7,
			ja = 5.4
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
				arg_113_0:Play410122029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = "1056"

			if arg_113_1.actors_[var_116_0] == nil then
				local var_116_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

				if not isNil(var_116_1) then
					local var_116_2 = Object.Instantiate(var_116_1, arg_113_1.canvasGo_.transform)

					var_116_2.transform:SetSiblingIndex(1)

					var_116_2.name = var_116_0
					var_116_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_113_1.actors_[var_116_0] = var_116_2

					local var_116_3 = var_116_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_113_1.isInRecall_ then
						for iter_116_0, iter_116_1 in ipairs(var_116_3) do
							iter_116_1.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_116_4 = arg_113_1.actors_["1056"].transform
			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.var_.moveOldPos1056 = var_116_4.localPosition
				var_116_4.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1056", 3)

				local var_116_6 = var_116_4.childCount

				for iter_116_2 = 0, var_116_6 - 1 do
					local var_116_7 = var_116_4:GetChild(iter_116_2)

					if var_116_7.name == "" or not string.find(var_116_7.name, "split") then
						var_116_7.gameObject:SetActive(true)
					else
						var_116_7.gameObject:SetActive(false)
					end
				end
			end

			local var_116_8 = 0.001

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_8 then
				local var_116_9 = (arg_113_1.time_ - var_116_5) / var_116_8
				local var_116_10 = Vector3.New(0, -350, -180)

				var_116_4.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1056, var_116_10, var_116_9)
			end

			if arg_113_1.time_ >= var_116_5 + var_116_8 and arg_113_1.time_ < var_116_5 + var_116_8 + arg_116_0 then
				var_116_4.localPosition = Vector3.New(0, -350, -180)
			end

			local var_116_11 = arg_113_1.actors_["1056"]
			local var_116_12 = 0

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.actorSpriteComps1056 == nil then
				arg_113_1.var_.actorSpriteComps1056 = var_116_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_13 = 0.034

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_13 and not isNil(var_116_11) then
				local var_116_14 = (arg_113_1.time_ - var_116_12) / var_116_13

				if arg_113_1.var_.actorSpriteComps1056 then
					for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_116_4 then
							if arg_113_1.isInRecall_ then
								local var_116_15 = Mathf.Lerp(iter_116_4.color.r, arg_113_1.hightColor1.r, var_116_14)
								local var_116_16 = Mathf.Lerp(iter_116_4.color.g, arg_113_1.hightColor1.g, var_116_14)
								local var_116_17 = Mathf.Lerp(iter_116_4.color.b, arg_113_1.hightColor1.b, var_116_14)

								iter_116_4.color = Color.New(var_116_15, var_116_16, var_116_17)
							else
								local var_116_18 = Mathf.Lerp(iter_116_4.color.r, 1, var_116_14)

								iter_116_4.color = Color.New(var_116_18, var_116_18, var_116_18)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_12 + var_116_13 and arg_113_1.time_ < var_116_12 + var_116_13 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.actorSpriteComps1056 then
				for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_116_6 then
						if arg_113_1.isInRecall_ then
							iter_116_6.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1056 = nil
			end

			local var_116_19 = 0
			local var_116_20 = 0.25

			if var_116_19 < arg_113_1.time_ and arg_113_1.time_ <= var_116_19 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_21 = arg_113_1:FormatText(StoryNameCfg[605].name)

				arg_113_1.leftNameTxt_.text = var_116_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_22 = arg_113_1:GetWordFromCfg(410122028)
				local var_116_23 = arg_113_1:FormatText(var_116_22.content)

				arg_113_1.text_.text = var_116_23

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_24 = 10
				local var_116_25 = utf8.len(var_116_23)
				local var_116_26 = var_116_24 <= 0 and var_116_20 or var_116_20 * (var_116_25 / var_116_24)

				if var_116_26 > 0 and var_116_20 < var_116_26 then
					arg_113_1.talkMaxDuration = var_116_26

					if var_116_26 + var_116_19 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_26 + var_116_19
					end
				end

				arg_113_1.text_.text = var_116_23
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122028", "story_v_out_410122.awb") ~= 0 then
					local var_116_27 = manager.audio:GetVoiceLength("story_v_out_410122", "410122028", "story_v_out_410122.awb") / 1000

					if var_116_27 + var_116_19 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_27 + var_116_19
					end

					if var_116_22.prefab_name ~= "" and arg_113_1.actors_[var_116_22.prefab_name] ~= nil then
						local var_116_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_22.prefab_name].transform, "story_v_out_410122", "410122028", "story_v_out_410122.awb")

						arg_113_1:RecordAudio("410122028", var_116_28)
						arg_113_1:RecordAudio("410122028", var_116_28)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410122", "410122028", "story_v_out_410122.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410122", "410122028", "story_v_out_410122.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_29 = math.max(var_116_20, arg_113_1.talkMaxDuration)

			if var_116_19 <= arg_113_1.time_ and arg_113_1.time_ < var_116_19 + var_116_29 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_19) / var_116_29

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_19 + var_116_29 and arg_113_1.time_ < var_116_19 + var_116_29 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play410122029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410122029
		arg_117_1.duration_ = 7.97

		local var_117_0 = {
			zh = 6.766,
			ja = 7.966
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
				arg_117_0:Play410122030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = "LZ0107"

			if arg_117_1.bgs_[var_120_0] == nil then
				local var_120_1 = Object.Instantiate(arg_117_1.paintGo_)

				var_120_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_120_0)
				var_120_1.name = var_120_0
				var_120_1.transform.parent = arg_117_1.stage_.transform
				var_120_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.bgs_[var_120_0] = var_120_1
			end

			local var_120_2 = 2

			if var_120_2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				local var_120_3 = manager.ui.mainCamera.transform.localPosition
				local var_120_4 = Vector3.New(0, 0, 10) + Vector3.New(var_120_3.x, var_120_3.y, 0)
				local var_120_5 = arg_117_1.bgs_.LZ0107

				var_120_5.transform.localPosition = var_120_4
				var_120_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_6 = var_120_5:GetComponent("SpriteRenderer")

				if var_120_6 and var_120_6.sprite then
					local var_120_7 = (var_120_5.transform.localPosition - var_120_3).z
					local var_120_8 = manager.ui.mainCameraCom_
					local var_120_9 = 2 * var_120_7 * Mathf.Tan(var_120_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_120_10 = var_120_9 * var_120_8.aspect
					local var_120_11 = var_120_6.sprite.bounds.size.x
					local var_120_12 = var_120_6.sprite.bounds.size.y
					local var_120_13 = var_120_10 / var_120_11
					local var_120_14 = var_120_9 / var_120_12
					local var_120_15 = var_120_14 < var_120_13 and var_120_13 or var_120_14

					var_120_5.transform.localScale = Vector3.New(var_120_15, var_120_15, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "LZ0107" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_17 = 2

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17
				local var_120_19 = Color.New(0, 0, 0)

				var_120_19.a = Mathf.Lerp(0, 1, var_120_18)
				arg_117_1.mask_.color = var_120_19
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 then
				local var_120_20 = Color.New(0, 0, 0)

				var_120_20.a = 1
				arg_117_1.mask_.color = var_120_20
			end

			local var_120_21 = 2

			if var_120_21 < arg_117_1.time_ and arg_117_1.time_ <= var_120_21 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_22 = 2

			if var_120_21 <= arg_117_1.time_ and arg_117_1.time_ < var_120_21 + var_120_22 then
				local var_120_23 = (arg_117_1.time_ - var_120_21) / var_120_22
				local var_120_24 = Color.New(0, 0, 0)

				var_120_24.a = Mathf.Lerp(1, 0, var_120_23)
				arg_117_1.mask_.color = var_120_24
			end

			if arg_117_1.time_ >= var_120_21 + var_120_22 and arg_117_1.time_ < var_120_21 + var_120_22 + arg_120_0 then
				local var_120_25 = Color.New(0, 0, 0)
				local var_120_26 = 0

				arg_117_1.mask_.enabled = false
				var_120_25.a = var_120_26
				arg_117_1.mask_.color = var_120_25
			end

			local var_120_27 = arg_117_1.actors_["1056"].transform
			local var_120_28 = 2

			if var_120_28 < arg_117_1.time_ and arg_117_1.time_ <= var_120_28 + arg_120_0 then
				arg_117_1.var_.moveOldPos1056 = var_120_27.localPosition
				var_120_27.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1056", 7)

				local var_120_29 = var_120_27.childCount

				for iter_120_2 = 0, var_120_29 - 1 do
					local var_120_30 = var_120_27:GetChild(iter_120_2)

					if var_120_30.name == "" or not string.find(var_120_30.name, "split") then
						var_120_30.gameObject:SetActive(true)
					else
						var_120_30.gameObject:SetActive(false)
					end
				end
			end

			local var_120_31 = 0.001

			if var_120_28 <= arg_117_1.time_ and arg_117_1.time_ < var_120_28 + var_120_31 then
				local var_120_32 = (arg_117_1.time_ - var_120_28) / var_120_31
				local var_120_33 = Vector3.New(0, -2000, -180)

				var_120_27.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1056, var_120_33, var_120_32)
			end

			if arg_117_1.time_ >= var_120_28 + var_120_31 and arg_117_1.time_ < var_120_28 + var_120_31 + arg_120_0 then
				var_120_27.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_34 = 4
			local var_120_35 = 0.325

			if var_120_34 < arg_117_1.time_ and arg_117_1.time_ <= var_120_34 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_36 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_36:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_37 = arg_117_1:FormatText(StoryNameCfg[584].name)

				arg_117_1.leftNameTxt_.text = var_120_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_38 = arg_117_1:GetWordFromCfg(410122029)
				local var_120_39 = arg_117_1:FormatText(var_120_38.content)

				arg_117_1.text_.text = var_120_39

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_40 = 13
				local var_120_41 = utf8.len(var_120_39)
				local var_120_42 = var_120_40 <= 0 and var_120_35 or var_120_35 * (var_120_41 / var_120_40)

				if var_120_42 > 0 and var_120_35 < var_120_42 then
					arg_117_1.talkMaxDuration = var_120_42
					var_120_34 = var_120_34 + 0.3

					if var_120_42 + var_120_34 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_42 + var_120_34
					end
				end

				arg_117_1.text_.text = var_120_39
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122029", "story_v_out_410122.awb") ~= 0 then
					local var_120_43 = manager.audio:GetVoiceLength("story_v_out_410122", "410122029", "story_v_out_410122.awb") / 1000

					if var_120_43 + var_120_34 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_43 + var_120_34
					end

					if var_120_38.prefab_name ~= "" and arg_117_1.actors_[var_120_38.prefab_name] ~= nil then
						local var_120_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_38.prefab_name].transform, "story_v_out_410122", "410122029", "story_v_out_410122.awb")

						arg_117_1:RecordAudio("410122029", var_120_44)
						arg_117_1:RecordAudio("410122029", var_120_44)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_410122", "410122029", "story_v_out_410122.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_410122", "410122029", "story_v_out_410122.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_45 = var_120_34 + 0.3
			local var_120_46 = math.max(var_120_35, arg_117_1.talkMaxDuration)

			if var_120_45 <= arg_117_1.time_ and arg_117_1.time_ < var_120_45 + var_120_46 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_45) / var_120_46

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_45 + var_120_46 and arg_117_1.time_ < var_120_45 + var_120_46 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play410122030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410122030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play410122031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.875

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(410122030)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 35
				local var_126_5 = utf8.len(var_126_3)
				local var_126_6 = var_126_4 <= 0 and var_126_1 or var_126_1 * (var_126_5 / var_126_4)

				if var_126_6 > 0 and var_126_1 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_7 and arg_123_1.time_ < var_126_0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play410122031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410122031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play410122032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.85

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_2 = arg_127_1:GetWordFromCfg(410122031)
				local var_130_3 = arg_127_1:FormatText(var_130_2.content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 34
				local var_130_5 = utf8.len(var_130_3)
				local var_130_6 = var_130_4 <= 0 and var_130_1 or var_130_1 * (var_130_5 / var_130_4)

				if var_130_6 > 0 and var_130_1 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_7 and arg_127_1.time_ < var_130_0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play410122032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410122032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play410122033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1.35

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(410122032)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 54
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play410122033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410122033
		arg_135_1.duration_ = 3.1

		local var_135_0 = {
			zh = 2.9,
			ja = 3.1
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
				arg_135_0:Play410122034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.225

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[591].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10063_split_4")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(410122033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 9
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122033", "story_v_out_410122.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122033", "story_v_out_410122.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_410122", "410122033", "story_v_out_410122.awb")

						arg_135_1:RecordAudio("410122033", var_138_9)
						arg_135_1:RecordAudio("410122033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410122", "410122033", "story_v_out_410122.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410122", "410122033", "story_v_out_410122.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play410122034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410122034
		arg_139_1.duration_ = 3.37

		local var_139_0 = {
			zh = 2.7,
			ja = 3.366
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
				arg_139_0:Play410122035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.325

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[605].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(410122034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 13
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122034", "story_v_out_410122.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122034", "story_v_out_410122.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_410122", "410122034", "story_v_out_410122.awb")

						arg_139_1:RecordAudio("410122034", var_142_9)
						arg_139_1:RecordAudio("410122034", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_410122", "410122034", "story_v_out_410122.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_410122", "410122034", "story_v_out_410122.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play410122035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410122035
		arg_143_1.duration_ = 5.47

		local var_143_0 = {
			zh = 2.766,
			ja = 5.466
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
				arg_143_0:Play410122036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.325

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[605].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(410122035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 13
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122035", "story_v_out_410122.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122035", "story_v_out_410122.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_410122", "410122035", "story_v_out_410122.awb")

						arg_143_1:RecordAudio("410122035", var_146_9)
						arg_143_1:RecordAudio("410122035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_410122", "410122035", "story_v_out_410122.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_410122", "410122035", "story_v_out_410122.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play410122036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410122036
		arg_147_1.duration_ = 4.6

		local var_147_0 = {
			zh = 4.3,
			ja = 4.6
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
				arg_147_0:Play410122037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.475

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[263].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052_split_1")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(410122036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122036", "story_v_out_410122.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122036", "story_v_out_410122.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_410122", "410122036", "story_v_out_410122.awb")

						arg_147_1:RecordAudio("410122036", var_150_9)
						arg_147_1:RecordAudio("410122036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410122", "410122036", "story_v_out_410122.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410122", "410122036", "story_v_out_410122.awb")
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
	Play410122037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 410122037
		arg_151_1.duration_ = 9.4

		local var_151_0 = {
			zh = 6.1,
			ja = 9.4
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
				arg_151_0:Play410122038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.75

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[605].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(410122037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122037", "story_v_out_410122.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122037", "story_v_out_410122.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_410122", "410122037", "story_v_out_410122.awb")

						arg_151_1:RecordAudio("410122037", var_154_9)
						arg_151_1:RecordAudio("410122037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_410122", "410122037", "story_v_out_410122.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_410122", "410122037", "story_v_out_410122.awb")
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
	Play410122038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 410122038
		arg_155_1.duration_ = 3.67

		local var_155_0 = {
			zh = 2.1,
			ja = 3.666
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
				arg_155_0:Play410122039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.25

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[263].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052_split_2")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(410122038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 10
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122038", "story_v_out_410122.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122038", "story_v_out_410122.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_410122", "410122038", "story_v_out_410122.awb")

						arg_155_1:RecordAudio("410122038", var_158_9)
						arg_155_1:RecordAudio("410122038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_410122", "410122038", "story_v_out_410122.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_410122", "410122038", "story_v_out_410122.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play410122039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 410122039
		arg_159_1.duration_ = 6.8

		local var_159_0 = {
			zh = 3.9,
			ja = 6.8
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
				arg_159_0:Play410122040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.525

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[605].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(410122039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 21
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122039", "story_v_out_410122.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122039", "story_v_out_410122.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_410122", "410122039", "story_v_out_410122.awb")

						arg_159_1:RecordAudio("410122039", var_162_9)
						arg_159_1:RecordAudio("410122039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_410122", "410122039", "story_v_out_410122.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_410122", "410122039", "story_v_out_410122.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play410122040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410122040
		arg_163_1.duration_ = 6.43

		local var_163_0 = {
			zh = 3.2,
			ja = 6.433
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
				arg_163_0:Play410122041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.425

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[263].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052_split_3")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(410122040)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 17
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122040", "story_v_out_410122.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122040", "story_v_out_410122.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_410122", "410122040", "story_v_out_410122.awb")

						arg_163_1:RecordAudio("410122040", var_166_9)
						arg_163_1:RecordAudio("410122040", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_410122", "410122040", "story_v_out_410122.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_410122", "410122040", "story_v_out_410122.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play410122041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 410122041
		arg_167_1.duration_ = 5.6

		local var_167_0 = {
			zh = 2.733,
			ja = 5.6
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
				arg_167_0:Play410122042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.25

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[605].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(410122041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 10
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122041", "story_v_out_410122.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122041", "story_v_out_410122.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_410122", "410122041", "story_v_out_410122.awb")

						arg_167_1:RecordAudio("410122041", var_170_9)
						arg_167_1:RecordAudio("410122041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_410122", "410122041", "story_v_out_410122.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_410122", "410122041", "story_v_out_410122.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play410122042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 410122042
		arg_171_1.duration_ = 7.33

		local var_171_0 = {
			zh = 4.233,
			ja = 7.333
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play410122043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.375

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[605].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(410122042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 15
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122042", "story_v_out_410122.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122042", "story_v_out_410122.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_410122", "410122042", "story_v_out_410122.awb")

						arg_171_1:RecordAudio("410122042", var_174_9)
						arg_171_1:RecordAudio("410122042", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_410122", "410122042", "story_v_out_410122.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_410122", "410122042", "story_v_out_410122.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play410122043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410122043
		arg_175_1.duration_ = 9

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play410122044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = "L04g"

			if arg_175_1.bgs_[var_178_0] == nil then
				local var_178_1 = Object.Instantiate(arg_175_1.paintGo_)

				var_178_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_178_0)
				var_178_1.name = var_178_0
				var_178_1.transform.parent = arg_175_1.stage_.transform
				var_178_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.bgs_[var_178_0] = var_178_1
			end

			local var_178_2 = 2

			if var_178_2 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				local var_178_3 = manager.ui.mainCamera.transform.localPosition
				local var_178_4 = Vector3.New(0, 0, 10) + Vector3.New(var_178_3.x, var_178_3.y, 0)
				local var_178_5 = arg_175_1.bgs_.L04g

				var_178_5.transform.localPosition = var_178_4
				var_178_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_6 = var_178_5:GetComponent("SpriteRenderer")

				if var_178_6 and var_178_6.sprite then
					local var_178_7 = (var_178_5.transform.localPosition - var_178_3).z
					local var_178_8 = manager.ui.mainCameraCom_
					local var_178_9 = 2 * var_178_7 * Mathf.Tan(var_178_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_178_10 = var_178_9 * var_178_8.aspect
					local var_178_11 = var_178_6.sprite.bounds.size.x
					local var_178_12 = var_178_6.sprite.bounds.size.y
					local var_178_13 = var_178_10 / var_178_11
					local var_178_14 = var_178_9 / var_178_12
					local var_178_15 = var_178_14 < var_178_13 and var_178_13 or var_178_14

					var_178_5.transform.localScale = Vector3.New(var_178_15, var_178_15, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "L04g" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_17 = 2

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 then
				local var_178_18 = (arg_175_1.time_ - var_178_16) / var_178_17
				local var_178_19 = Color.New(0, 0, 0)

				var_178_19.a = Mathf.Lerp(0, 1, var_178_18)
				arg_175_1.mask_.color = var_178_19
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 then
				local var_178_20 = Color.New(0, 0, 0)

				var_178_20.a = 1
				arg_175_1.mask_.color = var_178_20
			end

			local var_178_21 = 2

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_22 = 2

			if var_178_21 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_22 then
				local var_178_23 = (arg_175_1.time_ - var_178_21) / var_178_22
				local var_178_24 = Color.New(0, 0, 0)

				var_178_24.a = Mathf.Lerp(1, 0, var_178_23)
				arg_175_1.mask_.color = var_178_24
			end

			if arg_175_1.time_ >= var_178_21 + var_178_22 and arg_175_1.time_ < var_178_21 + var_178_22 + arg_178_0 then
				local var_178_25 = Color.New(0, 0, 0)
				local var_178_26 = 0

				arg_175_1.mask_.enabled = false
				var_178_25.a = var_178_26
				arg_175_1.mask_.color = var_178_25
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_27 = 4
			local var_178_28 = 1.075

			if var_178_27 < arg_175_1.time_ and arg_175_1.time_ <= var_178_27 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_29 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_29:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_30 = arg_175_1:GetWordFromCfg(410122043)
				local var_178_31 = arg_175_1:FormatText(var_178_30.content)

				arg_175_1.text_.text = var_178_31

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_32 = 43
				local var_178_33 = utf8.len(var_178_31)
				local var_178_34 = var_178_32 <= 0 and var_178_28 or var_178_28 * (var_178_33 / var_178_32)

				if var_178_34 > 0 and var_178_28 < var_178_34 then
					arg_175_1.talkMaxDuration = var_178_34
					var_178_27 = var_178_27 + 0.3

					if var_178_34 + var_178_27 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_34 + var_178_27
					end
				end

				arg_175_1.text_.text = var_178_31
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_35 = var_178_27 + 0.3
			local var_178_36 = math.max(var_178_28, arg_175_1.talkMaxDuration)

			if var_178_35 <= arg_175_1.time_ and arg_175_1.time_ < var_178_35 + var_178_36 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_35) / var_178_36

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_35 + var_178_36 and arg_175_1.time_ < var_178_35 + var_178_36 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play410122044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410122044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play410122045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.9

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(410122044)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 36
				local var_184_5 = utf8.len(var_184_3)
				local var_184_6 = var_184_4 <= 0 and var_184_1 or var_184_1 * (var_184_5 / var_184_4)

				if var_184_6 > 0 and var_184_1 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_7 and arg_181_1.time_ < var_184_0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play410122045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410122045
		arg_185_1.duration_ = 6.07

		local var_185_0 = {
			zh = 4.633,
			ja = 6.066
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
				arg_185_0:Play410122046(arg_185_1)
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

			local var_188_7 = arg_185_1.actors_["1060"].transform
			local var_188_8 = 0

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.var_.moveOldPos1060 = var_188_7.localPosition
				var_188_7.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1060", 4)

				local var_188_9 = var_188_7.childCount

				for iter_188_1 = 0, var_188_9 - 1 do
					local var_188_10 = var_188_7:GetChild(iter_188_1)

					if var_188_10.name == "" or not string.find(var_188_10.name, "split") then
						var_188_10.gameObject:SetActive(true)
					else
						var_188_10.gameObject:SetActive(false)
					end
				end
			end

			local var_188_11 = 0.001

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_11 then
				local var_188_12 = (arg_185_1.time_ - var_188_8) / var_188_11
				local var_188_13 = Vector3.New(420.9, -430.8, 6.9)

				var_188_7.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1060, var_188_13, var_188_12)
			end

			if arg_185_1.time_ >= var_188_8 + var_188_11 and arg_185_1.time_ < var_188_8 + var_188_11 + arg_188_0 then
				var_188_7.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_188_14 = arg_185_1.actors_["1056"]
			local var_188_15 = 0

			if var_188_15 < arg_185_1.time_ and arg_185_1.time_ <= var_188_15 + arg_188_0 and not isNil(var_188_14) and arg_185_1.var_.actorSpriteComps1056 == nil then
				arg_185_1.var_.actorSpriteComps1056 = var_188_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_16 = 0.034

			if var_188_15 <= arg_185_1.time_ and arg_185_1.time_ < var_188_15 + var_188_16 and not isNil(var_188_14) then
				local var_188_17 = (arg_185_1.time_ - var_188_15) / var_188_16

				if arg_185_1.var_.actorSpriteComps1056 then
					for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_188_3 then
							if arg_185_1.isInRecall_ then
								local var_188_18 = Mathf.Lerp(iter_188_3.color.r, arg_185_1.hightColor1.r, var_188_17)
								local var_188_19 = Mathf.Lerp(iter_188_3.color.g, arg_185_1.hightColor1.g, var_188_17)
								local var_188_20 = Mathf.Lerp(iter_188_3.color.b, arg_185_1.hightColor1.b, var_188_17)

								iter_188_3.color = Color.New(var_188_18, var_188_19, var_188_20)
							else
								local var_188_21 = Mathf.Lerp(iter_188_3.color.r, 1, var_188_17)

								iter_188_3.color = Color.New(var_188_21, var_188_21, var_188_21)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_15 + var_188_16 and arg_185_1.time_ < var_188_15 + var_188_16 + arg_188_0 and not isNil(var_188_14) and arg_185_1.var_.actorSpriteComps1056 then
				for iter_188_4, iter_188_5 in pairs(arg_185_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_188_5 then
						if arg_185_1.isInRecall_ then
							iter_188_5.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps1056 = nil
			end

			local var_188_22 = arg_185_1.actors_["1060"]
			local var_188_23 = 0

			if var_188_23 < arg_185_1.time_ and arg_185_1.time_ <= var_188_23 + arg_188_0 and not isNil(var_188_22) and arg_185_1.var_.actorSpriteComps1060 == nil then
				arg_185_1.var_.actorSpriteComps1060 = var_188_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_24 = 0.034

			if var_188_23 <= arg_185_1.time_ and arg_185_1.time_ < var_188_23 + var_188_24 and not isNil(var_188_22) then
				local var_188_25 = (arg_185_1.time_ - var_188_23) / var_188_24

				if arg_185_1.var_.actorSpriteComps1060 then
					for iter_188_6, iter_188_7 in pairs(arg_185_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_188_7 then
							if arg_185_1.isInRecall_ then
								local var_188_26 = Mathf.Lerp(iter_188_7.color.r, arg_185_1.hightColor2.r, var_188_25)
								local var_188_27 = Mathf.Lerp(iter_188_7.color.g, arg_185_1.hightColor2.g, var_188_25)
								local var_188_28 = Mathf.Lerp(iter_188_7.color.b, arg_185_1.hightColor2.b, var_188_25)

								iter_188_7.color = Color.New(var_188_26, var_188_27, var_188_28)
							else
								local var_188_29 = Mathf.Lerp(iter_188_7.color.r, 0.5, var_188_25)

								iter_188_7.color = Color.New(var_188_29, var_188_29, var_188_29)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_23 + var_188_24 and arg_185_1.time_ < var_188_23 + var_188_24 + arg_188_0 and not isNil(var_188_22) and arg_185_1.var_.actorSpriteComps1060 then
				for iter_188_8, iter_188_9 in pairs(arg_185_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_188_9 then
						if arg_185_1.isInRecall_ then
							iter_188_9.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps1060 = nil
			end

			local var_188_30 = 0
			local var_188_31 = 0.775

			if var_188_30 < arg_185_1.time_ and arg_185_1.time_ <= var_188_30 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_32 = arg_185_1:FormatText(StoryNameCfg[605].name)

				arg_185_1.leftNameTxt_.text = var_188_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_33 = arg_185_1:GetWordFromCfg(410122045)
				local var_188_34 = arg_185_1:FormatText(var_188_33.content)

				arg_185_1.text_.text = var_188_34

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_35 = 29
				local var_188_36 = utf8.len(var_188_34)
				local var_188_37 = var_188_35 <= 0 and var_188_31 or var_188_31 * (var_188_36 / var_188_35)

				if var_188_37 > 0 and var_188_31 < var_188_37 then
					arg_185_1.talkMaxDuration = var_188_37

					if var_188_37 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_37 + var_188_30
					end
				end

				arg_185_1.text_.text = var_188_34
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122045", "story_v_out_410122.awb") ~= 0 then
					local var_188_38 = manager.audio:GetVoiceLength("story_v_out_410122", "410122045", "story_v_out_410122.awb") / 1000

					if var_188_38 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_38 + var_188_30
					end

					if var_188_33.prefab_name ~= "" and arg_185_1.actors_[var_188_33.prefab_name] ~= nil then
						local var_188_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_33.prefab_name].transform, "story_v_out_410122", "410122045", "story_v_out_410122.awb")

						arg_185_1:RecordAudio("410122045", var_188_39)
						arg_185_1:RecordAudio("410122045", var_188_39)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_410122", "410122045", "story_v_out_410122.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_410122", "410122045", "story_v_out_410122.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_40 = math.max(var_188_31, arg_185_1.talkMaxDuration)

			if var_188_30 <= arg_185_1.time_ and arg_185_1.time_ < var_188_30 + var_188_40 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_30) / var_188_40

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_30 + var_188_40 and arg_185_1.time_ < var_188_30 + var_188_40 + arg_188_0 then
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

		arg_185_1:InitPlayNodeList()
	end,
	Play410122046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410122046
		arg_189_1.duration_ = 7.13

		local var_189_0 = {
			zh = 5,
			ja = 7.133
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
				arg_189_0:Play410122047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.6

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[605].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(410122046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122046", "story_v_out_410122.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122046", "story_v_out_410122.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_410122", "410122046", "story_v_out_410122.awb")

						arg_189_1:RecordAudio("410122046", var_192_9)
						arg_189_1:RecordAudio("410122046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410122", "410122046", "story_v_out_410122.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410122", "410122046", "story_v_out_410122.awb")
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
	Play410122047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410122047
		arg_193_1.duration_ = 3.8

		local var_193_0 = {
			zh = 1.7,
			ja = 3.8
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
				arg_193_0:Play410122048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1060"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1060 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1060", 4)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "split_4" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(420.9, -430.8, 6.9)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1060, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_196_7 = arg_193_1.actors_["1060"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps1060 == nil then
				arg_193_1.var_.actorSpriteComps1060 = var_196_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 0.034

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 and not isNil(var_196_7) then
				local var_196_10 = (arg_193_1.time_ - var_196_8) / var_196_9

				if arg_193_1.var_.actorSpriteComps1060 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps1060 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1060 = nil
			end

			local var_196_15 = arg_193_1.actors_["1056"]
			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps1056 == nil then
				arg_193_1.var_.actorSpriteComps1056 = var_196_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_17 = 0.034

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 and not isNil(var_196_15) then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17

				if arg_193_1.var_.actorSpriteComps1056 then
					for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps1056 then
				for iter_196_7, iter_196_8 in pairs(arg_193_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_196_8 then
						if arg_193_1.isInRecall_ then
							iter_196_8.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1056 = nil
			end

			local var_196_23 = 0
			local var_196_24 = 0.075

			if var_196_23 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_25 = arg_193_1:FormatText(StoryNameCfg[584].name)

				arg_193_1.leftNameTxt_.text = var_196_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_26 = arg_193_1:GetWordFromCfg(410122047)
				local var_196_27 = arg_193_1:FormatText(var_196_26.content)

				arg_193_1.text_.text = var_196_27

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_28 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122047", "story_v_out_410122.awb") ~= 0 then
					local var_196_31 = manager.audio:GetVoiceLength("story_v_out_410122", "410122047", "story_v_out_410122.awb") / 1000

					if var_196_31 + var_196_23 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_31 + var_196_23
					end

					if var_196_26.prefab_name ~= "" and arg_193_1.actors_[var_196_26.prefab_name] ~= nil then
						local var_196_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_26.prefab_name].transform, "story_v_out_410122", "410122047", "story_v_out_410122.awb")

						arg_193_1:RecordAudio("410122047", var_196_32)
						arg_193_1:RecordAudio("410122047", var_196_32)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410122", "410122047", "story_v_out_410122.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410122", "410122047", "story_v_out_410122.awb")
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
				actorName = "1060",
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
	Play410122048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410122048
		arg_197_1.duration_ = 6.3

		local var_197_0 = {
			zh = 2.833,
			ja = 6.3
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
				arg_197_0:Play410122049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1056"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1056 = var_200_0.localPosition
				var_200_0.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1056", 2)

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
				local var_200_6 = Vector3.New(-390, -350, -180)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1056, var_200_6, var_200_5)
			end

			if arg_197_1.time_ >= var_200_1 + var_200_4 and arg_197_1.time_ < var_200_1 + var_200_4 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_200_7 = arg_197_1.actors_["1056"]
			local var_200_8 = 0

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps1056 == nil then
				arg_197_1.var_.actorSpriteComps1056 = var_200_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_9 = 0.034

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_9 and not isNil(var_200_7) then
				local var_200_10 = (arg_197_1.time_ - var_200_8) / var_200_9

				if arg_197_1.var_.actorSpriteComps1056 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_197_1.time_ >= var_200_8 + var_200_9 and arg_197_1.time_ < var_200_8 + var_200_9 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps1056 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_200_4 then
						if arg_197_1.isInRecall_ then
							iter_200_4.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1056 = nil
			end

			local var_200_15 = arg_197_1.actors_["1060"]
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps1060 == nil then
				arg_197_1.var_.actorSpriteComps1060 = var_200_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_17 = 0.034

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 and not isNil(var_200_15) then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17

				if arg_197_1.var_.actorSpriteComps1060 then
					for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_200_6 then
							if arg_197_1.isInRecall_ then
								local var_200_19 = Mathf.Lerp(iter_200_6.color.r, arg_197_1.hightColor2.r, var_200_18)
								local var_200_20 = Mathf.Lerp(iter_200_6.color.g, arg_197_1.hightColor2.g, var_200_18)
								local var_200_21 = Mathf.Lerp(iter_200_6.color.b, arg_197_1.hightColor2.b, var_200_18)

								iter_200_6.color = Color.New(var_200_19, var_200_20, var_200_21)
							else
								local var_200_22 = Mathf.Lerp(iter_200_6.color.r, 0.5, var_200_18)

								iter_200_6.color = Color.New(var_200_22, var_200_22, var_200_22)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps1060 then
				for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_200_8 then
						if arg_197_1.isInRecall_ then
							iter_200_8.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1060 = nil
			end

			local var_200_23 = 0
			local var_200_24 = 0.325

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_25 = arg_197_1:FormatText(StoryNameCfg[605].name)

				arg_197_1.leftNameTxt_.text = var_200_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_26 = arg_197_1:GetWordFromCfg(410122048)
				local var_200_27 = arg_197_1:FormatText(var_200_26.content)

				arg_197_1.text_.text = var_200_27

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_28 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122048", "story_v_out_410122.awb") ~= 0 then
					local var_200_31 = manager.audio:GetVoiceLength("story_v_out_410122", "410122048", "story_v_out_410122.awb") / 1000

					if var_200_31 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_31 + var_200_23
					end

					if var_200_26.prefab_name ~= "" and arg_197_1.actors_[var_200_26.prefab_name] ~= nil then
						local var_200_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_26.prefab_name].transform, "story_v_out_410122", "410122048", "story_v_out_410122.awb")

						arg_197_1:RecordAudio("410122048", var_200_32)
						arg_197_1:RecordAudio("410122048", var_200_32)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410122", "410122048", "story_v_out_410122.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410122", "410122048", "story_v_out_410122.awb")
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
				actorName = "1056",
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
	Play410122049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410122049
		arg_201_1.duration_ = 6.33

		local var_201_0 = {
			zh = 1.5,
			ja = 6.333
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
				arg_201_0:Play410122050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.175

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[605].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(410122049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122049", "story_v_out_410122.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122049", "story_v_out_410122.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_410122", "410122049", "story_v_out_410122.awb")

						arg_201_1:RecordAudio("410122049", var_204_9)
						arg_201_1:RecordAudio("410122049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_410122", "410122049", "story_v_out_410122.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_410122", "410122049", "story_v_out_410122.awb")
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
	Play410122050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410122050
		arg_205_1.duration_ = 7.3

		local var_205_0 = {
			zh = 4,
			ja = 7.3
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
				arg_205_0:Play410122051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1060"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1060 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1060", 4)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "split_1" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(420.9, -430.8, 6.9)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1060, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_208_7 = arg_205_1.actors_["1060"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps1060 == nil then
				arg_205_1.var_.actorSpriteComps1060 = var_208_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 0.034

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 and not isNil(var_208_7) then
				local var_208_10 = (arg_205_1.time_ - var_208_8) / var_208_9

				if arg_205_1.var_.actorSpriteComps1060 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								local var_208_11 = Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, var_208_10)
								local var_208_12 = Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, var_208_10)
								local var_208_13 = Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, var_208_10)

								iter_208_2.color = Color.New(var_208_11, var_208_12, var_208_13)
							else
								local var_208_14 = Mathf.Lerp(iter_208_2.color.r, 1, var_208_10)

								iter_208_2.color = Color.New(var_208_14, var_208_14, var_208_14)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps1060 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_208_4 then
						if arg_205_1.isInRecall_ then
							iter_208_4.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1060 = nil
			end

			local var_208_15 = arg_205_1.actors_["1056"]
			local var_208_16 = 0

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.actorSpriteComps1056 == nil then
				arg_205_1.var_.actorSpriteComps1056 = var_208_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_17 = 0.034

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_17 and not isNil(var_208_15) then
				local var_208_18 = (arg_205_1.time_ - var_208_16) / var_208_17

				if arg_205_1.var_.actorSpriteComps1056 then
					for iter_208_5, iter_208_6 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_208_6 then
							if arg_205_1.isInRecall_ then
								local var_208_19 = Mathf.Lerp(iter_208_6.color.r, arg_205_1.hightColor2.r, var_208_18)
								local var_208_20 = Mathf.Lerp(iter_208_6.color.g, arg_205_1.hightColor2.g, var_208_18)
								local var_208_21 = Mathf.Lerp(iter_208_6.color.b, arg_205_1.hightColor2.b, var_208_18)

								iter_208_6.color = Color.New(var_208_19, var_208_20, var_208_21)
							else
								local var_208_22 = Mathf.Lerp(iter_208_6.color.r, 0.5, var_208_18)

								iter_208_6.color = Color.New(var_208_22, var_208_22, var_208_22)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_16 + var_208_17 and arg_205_1.time_ < var_208_16 + var_208_17 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.actorSpriteComps1056 then
				for iter_208_7, iter_208_8 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_208_8 then
						if arg_205_1.isInRecall_ then
							iter_208_8.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1056 = nil
			end

			local var_208_23 = 0
			local var_208_24 = 0.35

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_25 = arg_205_1:FormatText(StoryNameCfg[584].name)

				arg_205_1.leftNameTxt_.text = var_208_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_26 = arg_205_1:GetWordFromCfg(410122050)
				local var_208_27 = arg_205_1:FormatText(var_208_26.content)

				arg_205_1.text_.text = var_208_27

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_28 = 14
				local var_208_29 = utf8.len(var_208_27)
				local var_208_30 = var_208_28 <= 0 and var_208_24 or var_208_24 * (var_208_29 / var_208_28)

				if var_208_30 > 0 and var_208_24 < var_208_30 then
					arg_205_1.talkMaxDuration = var_208_30

					if var_208_30 + var_208_23 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_30 + var_208_23
					end
				end

				arg_205_1.text_.text = var_208_27
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122050", "story_v_out_410122.awb") ~= 0 then
					local var_208_31 = manager.audio:GetVoiceLength("story_v_out_410122", "410122050", "story_v_out_410122.awb") / 1000

					if var_208_31 + var_208_23 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_31 + var_208_23
					end

					if var_208_26.prefab_name ~= "" and arg_205_1.actors_[var_208_26.prefab_name] ~= nil then
						local var_208_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_26.prefab_name].transform, "story_v_out_410122", "410122050", "story_v_out_410122.awb")

						arg_205_1:RecordAudio("410122050", var_208_32)
						arg_205_1:RecordAudio("410122050", var_208_32)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410122", "410122050", "story_v_out_410122.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410122", "410122050", "story_v_out_410122.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_33 = math.max(var_208_24, arg_205_1.talkMaxDuration)

			if var_208_23 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_33 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_23) / var_208_33

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_23 + var_208_33 and arg_205_1.time_ < var_208_23 + var_208_33 + arg_208_0 then
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
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play410122051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410122051
		arg_209_1.duration_ = 2.57

		local var_209_0 = {
			zh = 2.566,
			ja = 1.866
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
				arg_209_0:Play410122052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1056"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1056 = var_212_0.localPosition
				var_212_0.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1056", 2)

				local var_212_2 = var_212_0.childCount

				for iter_212_0 = 0, var_212_2 - 1 do
					local var_212_3 = var_212_0:GetChild(iter_212_0)

					if var_212_3.name == "split_1_1" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_4 then
				local var_212_5 = (arg_209_1.time_ - var_212_1) / var_212_4
				local var_212_6 = Vector3.New(-390, -350, -180)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1056, var_212_6, var_212_5)
			end

			if arg_209_1.time_ >= var_212_1 + var_212_4 and arg_209_1.time_ < var_212_1 + var_212_4 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_212_7 = arg_209_1.actors_["1060"].transform
			local var_212_8 = 0

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.var_.moveOldPos1060 = var_212_7.localPosition
				var_212_7.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1060", 7)

				local var_212_9 = var_212_7.childCount

				for iter_212_1 = 0, var_212_9 - 1 do
					local var_212_10 = var_212_7:GetChild(iter_212_1)

					if var_212_10.name == "" or not string.find(var_212_10.name, "split") then
						var_212_10.gameObject:SetActive(true)
					else
						var_212_10.gameObject:SetActive(false)
					end
				end
			end

			local var_212_11 = 0.001

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_11 then
				local var_212_12 = (arg_209_1.time_ - var_212_8) / var_212_11
				local var_212_13 = Vector3.New(0, -2000, -40)

				var_212_7.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1060, var_212_13, var_212_12)
			end

			if arg_209_1.time_ >= var_212_8 + var_212_11 and arg_209_1.time_ < var_212_8 + var_212_11 + arg_212_0 then
				var_212_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_212_14 = "10063"

			if arg_209_1.actors_[var_212_14] == nil then
				local var_212_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10063")

				if not isNil(var_212_15) then
					local var_212_16 = Object.Instantiate(var_212_15, arg_209_1.canvasGo_.transform)

					var_212_16.transform:SetSiblingIndex(1)

					var_212_16.name = var_212_14
					var_212_16.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_209_1.actors_[var_212_14] = var_212_16

					local var_212_17 = var_212_16:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_209_1.isInRecall_ then
						for iter_212_2, iter_212_3 in ipairs(var_212_17) do
							iter_212_3.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_212_18 = arg_209_1.actors_["10063"].transform
			local var_212_19 = 0

			if var_212_19 < arg_209_1.time_ and arg_209_1.time_ <= var_212_19 + arg_212_0 then
				arg_209_1.var_.moveOldPos10063 = var_212_18.localPosition
				var_212_18.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10063", 4)

				local var_212_20 = var_212_18.childCount

				for iter_212_4 = 0, var_212_20 - 1 do
					local var_212_21 = var_212_18:GetChild(iter_212_4)

					if var_212_21.name == "" or not string.find(var_212_21.name, "split") then
						var_212_21.gameObject:SetActive(true)
					else
						var_212_21.gameObject:SetActive(false)
					end
				end
			end

			local var_212_22 = 0.001

			if var_212_19 <= arg_209_1.time_ and arg_209_1.time_ < var_212_19 + var_212_22 then
				local var_212_23 = (arg_209_1.time_ - var_212_19) / var_212_22
				local var_212_24 = Vector3.New(390, -535, -105)

				var_212_18.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10063, var_212_24, var_212_23)
			end

			if arg_209_1.time_ >= var_212_19 + var_212_22 and arg_209_1.time_ < var_212_19 + var_212_22 + arg_212_0 then
				var_212_18.localPosition = Vector3.New(390, -535, -105)
			end

			local var_212_25 = arg_209_1.actors_["1056"]
			local var_212_26 = 0

			if var_212_26 < arg_209_1.time_ and arg_209_1.time_ <= var_212_26 + arg_212_0 and not isNil(var_212_25) and arg_209_1.var_.actorSpriteComps1056 == nil then
				arg_209_1.var_.actorSpriteComps1056 = var_212_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_27 = 0.034

			if var_212_26 <= arg_209_1.time_ and arg_209_1.time_ < var_212_26 + var_212_27 and not isNil(var_212_25) then
				local var_212_28 = (arg_209_1.time_ - var_212_26) / var_212_27

				if arg_209_1.var_.actorSpriteComps1056 then
					for iter_212_5, iter_212_6 in pairs(arg_209_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_212_6 then
							if arg_209_1.isInRecall_ then
								local var_212_29 = Mathf.Lerp(iter_212_6.color.r, arg_209_1.hightColor2.r, var_212_28)
								local var_212_30 = Mathf.Lerp(iter_212_6.color.g, arg_209_1.hightColor2.g, var_212_28)
								local var_212_31 = Mathf.Lerp(iter_212_6.color.b, arg_209_1.hightColor2.b, var_212_28)

								iter_212_6.color = Color.New(var_212_29, var_212_30, var_212_31)
							else
								local var_212_32 = Mathf.Lerp(iter_212_6.color.r, 0.5, var_212_28)

								iter_212_6.color = Color.New(var_212_32, var_212_32, var_212_32)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_26 + var_212_27 and arg_209_1.time_ < var_212_26 + var_212_27 + arg_212_0 and not isNil(var_212_25) and arg_209_1.var_.actorSpriteComps1056 then
				for iter_212_7, iter_212_8 in pairs(arg_209_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_212_8 then
						if arg_209_1.isInRecall_ then
							iter_212_8.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1056 = nil
			end

			local var_212_33 = arg_209_1.actors_["1060"]
			local var_212_34 = 0

			if var_212_34 < arg_209_1.time_ and arg_209_1.time_ <= var_212_34 + arg_212_0 and not isNil(var_212_33) and arg_209_1.var_.actorSpriteComps1060 == nil then
				arg_209_1.var_.actorSpriteComps1060 = var_212_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_35 = 0.034

			if var_212_34 <= arg_209_1.time_ and arg_209_1.time_ < var_212_34 + var_212_35 and not isNil(var_212_33) then
				local var_212_36 = (arg_209_1.time_ - var_212_34) / var_212_35

				if arg_209_1.var_.actorSpriteComps1060 then
					for iter_212_9, iter_212_10 in pairs(arg_209_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_212_10 then
							if arg_209_1.isInRecall_ then
								local var_212_37 = Mathf.Lerp(iter_212_10.color.r, arg_209_1.hightColor2.r, var_212_36)
								local var_212_38 = Mathf.Lerp(iter_212_10.color.g, arg_209_1.hightColor2.g, var_212_36)
								local var_212_39 = Mathf.Lerp(iter_212_10.color.b, arg_209_1.hightColor2.b, var_212_36)

								iter_212_10.color = Color.New(var_212_37, var_212_38, var_212_39)
							else
								local var_212_40 = Mathf.Lerp(iter_212_10.color.r, 0.5, var_212_36)

								iter_212_10.color = Color.New(var_212_40, var_212_40, var_212_40)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_34 + var_212_35 and arg_209_1.time_ < var_212_34 + var_212_35 + arg_212_0 and not isNil(var_212_33) and arg_209_1.var_.actorSpriteComps1060 then
				for iter_212_11, iter_212_12 in pairs(arg_209_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_212_12 then
						if arg_209_1.isInRecall_ then
							iter_212_12.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1060 = nil
			end

			local var_212_41 = arg_209_1.actors_["10063"]
			local var_212_42 = 0

			if var_212_42 < arg_209_1.time_ and arg_209_1.time_ <= var_212_42 + arg_212_0 and not isNil(var_212_41) and arg_209_1.var_.actorSpriteComps10063 == nil then
				arg_209_1.var_.actorSpriteComps10063 = var_212_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_43 = 0.034

			if var_212_42 <= arg_209_1.time_ and arg_209_1.time_ < var_212_42 + var_212_43 and not isNil(var_212_41) then
				local var_212_44 = (arg_209_1.time_ - var_212_42) / var_212_43

				if arg_209_1.var_.actorSpriteComps10063 then
					for iter_212_13, iter_212_14 in pairs(arg_209_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_212_14 then
							if arg_209_1.isInRecall_ then
								local var_212_45 = Mathf.Lerp(iter_212_14.color.r, arg_209_1.hightColor1.r, var_212_44)
								local var_212_46 = Mathf.Lerp(iter_212_14.color.g, arg_209_1.hightColor1.g, var_212_44)
								local var_212_47 = Mathf.Lerp(iter_212_14.color.b, arg_209_1.hightColor1.b, var_212_44)

								iter_212_14.color = Color.New(var_212_45, var_212_46, var_212_47)
							else
								local var_212_48 = Mathf.Lerp(iter_212_14.color.r, 1, var_212_44)

								iter_212_14.color = Color.New(var_212_48, var_212_48, var_212_48)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_42 + var_212_43 and arg_209_1.time_ < var_212_42 + var_212_43 + arg_212_0 and not isNil(var_212_41) and arg_209_1.var_.actorSpriteComps10063 then
				for iter_212_15, iter_212_16 in pairs(arg_209_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_212_16 then
						if arg_209_1.isInRecall_ then
							iter_212_16.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_16.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10063 = nil
			end

			local var_212_49 = 0
			local var_212_50 = 0.125

			if var_212_49 < arg_209_1.time_ and arg_209_1.time_ <= var_212_49 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_51 = arg_209_1:FormatText(StoryNameCfg[591].name)

				arg_209_1.leftNameTxt_.text = var_212_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_52 = arg_209_1:GetWordFromCfg(410122051)
				local var_212_53 = arg_209_1:FormatText(var_212_52.content)

				arg_209_1.text_.text = var_212_53

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_54 = 5
				local var_212_55 = utf8.len(var_212_53)
				local var_212_56 = var_212_54 <= 0 and var_212_50 or var_212_50 * (var_212_55 / var_212_54)

				if var_212_56 > 0 and var_212_50 < var_212_56 then
					arg_209_1.talkMaxDuration = var_212_56

					if var_212_56 + var_212_49 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_56 + var_212_49
					end
				end

				arg_209_1.text_.text = var_212_53
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122051", "story_v_out_410122.awb") ~= 0 then
					local var_212_57 = manager.audio:GetVoiceLength("story_v_out_410122", "410122051", "story_v_out_410122.awb") / 1000

					if var_212_57 + var_212_49 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_57 + var_212_49
					end

					if var_212_52.prefab_name ~= "" and arg_209_1.actors_[var_212_52.prefab_name] ~= nil then
						local var_212_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_52.prefab_name].transform, "story_v_out_410122", "410122051", "story_v_out_410122.awb")

						arg_209_1:RecordAudio("410122051", var_212_58)
						arg_209_1:RecordAudio("410122051", var_212_58)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_410122", "410122051", "story_v_out_410122.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_410122", "410122051", "story_v_out_410122.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_59 = math.max(var_212_50, arg_209_1.talkMaxDuration)

			if var_212_49 <= arg_209_1.time_ and arg_209_1.time_ < var_212_49 + var_212_59 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_49) / var_212_59

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_49 + var_212_59 and arg_209_1.time_ < var_212_49 + var_212_59 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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

		arg_209_1:InitPlayNodeList()
	end,
	Play410122052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410122052
		arg_213_1.duration_ = 2.57

		local var_213_0 = {
			zh = 1.633,
			ja = 2.566
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
				arg_213_0:Play410122053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1056"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps1056 == nil then
				arg_213_1.var_.actorSpriteComps1056 = var_216_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_2 = 0.034

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.actorSpriteComps1056 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								local var_216_4 = Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, var_216_3)
								local var_216_5 = Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, var_216_3)
								local var_216_6 = Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, var_216_3)

								iter_216_1.color = Color.New(var_216_4, var_216_5, var_216_6)
							else
								local var_216_7 = Mathf.Lerp(iter_216_1.color.r, 1, var_216_3)

								iter_216_1.color = Color.New(var_216_7, var_216_7, var_216_7)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps1056 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_216_3 then
						if arg_213_1.isInRecall_ then
							iter_216_3.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1056 = nil
			end

			local var_216_8 = arg_213_1.actors_["10063"]
			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps10063 == nil then
				arg_213_1.var_.actorSpriteComps10063 = var_216_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_10 = 0.034

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 and not isNil(var_216_8) then
				local var_216_11 = (arg_213_1.time_ - var_216_9) / var_216_10

				if arg_213_1.var_.actorSpriteComps10063 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								local var_216_12 = Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor2.r, var_216_11)
								local var_216_13 = Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor2.g, var_216_11)
								local var_216_14 = Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor2.b, var_216_11)

								iter_216_5.color = Color.New(var_216_12, var_216_13, var_216_14)
							else
								local var_216_15 = Mathf.Lerp(iter_216_5.color.r, 0.5, var_216_11)

								iter_216_5.color = Color.New(var_216_15, var_216_15, var_216_15)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps10063 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_216_7 then
						if arg_213_1.isInRecall_ then
							iter_216_7.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10063 = nil
			end

			local var_216_16 = arg_213_1.actors_["1056"].transform
			local var_216_17 = 0

			if var_216_17 < arg_213_1.time_ and arg_213_1.time_ <= var_216_17 + arg_216_0 then
				arg_213_1.var_.moveOldPos1056 = var_216_16.localPosition
				var_216_16.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1056", 2)

				local var_216_18 = var_216_16.childCount

				for iter_216_8 = 0, var_216_18 - 1 do
					local var_216_19 = var_216_16:GetChild(iter_216_8)

					if var_216_19.name == "split_2" or not string.find(var_216_19.name, "split") then
						var_216_19.gameObject:SetActive(true)
					else
						var_216_19.gameObject:SetActive(false)
					end
				end
			end

			local var_216_20 = 0.001

			if var_216_17 <= arg_213_1.time_ and arg_213_1.time_ < var_216_17 + var_216_20 then
				local var_216_21 = (arg_213_1.time_ - var_216_17) / var_216_20
				local var_216_22 = Vector3.New(-390, -350, -180)

				var_216_16.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1056, var_216_22, var_216_21)
			end

			if arg_213_1.time_ >= var_216_17 + var_216_20 and arg_213_1.time_ < var_216_17 + var_216_20 + arg_216_0 then
				var_216_16.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_216_23 = 0
			local var_216_24 = 0.15

			if var_216_23 < arg_213_1.time_ and arg_213_1.time_ <= var_216_23 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_25 = arg_213_1:FormatText(StoryNameCfg[605].name)

				arg_213_1.leftNameTxt_.text = var_216_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_26 = arg_213_1:GetWordFromCfg(410122052)
				local var_216_27 = arg_213_1:FormatText(var_216_26.content)

				arg_213_1.text_.text = var_216_27

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_28 = 6
				local var_216_29 = utf8.len(var_216_27)
				local var_216_30 = var_216_28 <= 0 and var_216_24 or var_216_24 * (var_216_29 / var_216_28)

				if var_216_30 > 0 and var_216_24 < var_216_30 then
					arg_213_1.talkMaxDuration = var_216_30

					if var_216_30 + var_216_23 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_30 + var_216_23
					end
				end

				arg_213_1.text_.text = var_216_27
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122052", "story_v_out_410122.awb") ~= 0 then
					local var_216_31 = manager.audio:GetVoiceLength("story_v_out_410122", "410122052", "story_v_out_410122.awb") / 1000

					if var_216_31 + var_216_23 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_31 + var_216_23
					end

					if var_216_26.prefab_name ~= "" and arg_213_1.actors_[var_216_26.prefab_name] ~= nil then
						local var_216_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_26.prefab_name].transform, "story_v_out_410122", "410122052", "story_v_out_410122.awb")

						arg_213_1:RecordAudio("410122052", var_216_32)
						arg_213_1:RecordAudio("410122052", var_216_32)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_410122", "410122052", "story_v_out_410122.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_410122", "410122052", "story_v_out_410122.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_33 = math.max(var_216_24, arg_213_1.talkMaxDuration)

			if var_216_23 <= arg_213_1.time_ and arg_213_1.time_ < var_216_23 + var_216_33 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_23) / var_216_33

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_23 + var_216_33 and arg_213_1.time_ < var_216_23 + var_216_33 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play410122053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410122053
		arg_217_1.duration_ = 9.03

		local var_217_0 = {
			zh = 7.266,
			ja = 9.033
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
				arg_217_0:Play410122054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10063"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10063 == nil then
				arg_217_1.var_.actorSpriteComps10063 = var_220_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_2 = 0.266666666666667

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.actorSpriteComps10063 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								local var_220_4 = Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor1.r, var_220_3)
								local var_220_5 = Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor1.g, var_220_3)
								local var_220_6 = Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor1.b, var_220_3)

								iter_220_1.color = Color.New(var_220_4, var_220_5, var_220_6)
							else
								local var_220_7 = Mathf.Lerp(iter_220_1.color.r, 1, var_220_3)

								iter_220_1.color = Color.New(var_220_7, var_220_7, var_220_7)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10063 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_220_3 then
						if arg_217_1.isInRecall_ then
							iter_220_3.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10063 = nil
			end

			local var_220_8 = arg_217_1.actors_["1056"]
			local var_220_9 = 0

			if var_220_9 < arg_217_1.time_ and arg_217_1.time_ <= var_220_9 + arg_220_0 and not isNil(var_220_8) and arg_217_1.var_.actorSpriteComps1056 == nil then
				arg_217_1.var_.actorSpriteComps1056 = var_220_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_10 = 0.266666666666667

			if var_220_9 <= arg_217_1.time_ and arg_217_1.time_ < var_220_9 + var_220_10 and not isNil(var_220_8) then
				local var_220_11 = (arg_217_1.time_ - var_220_9) / var_220_10

				if arg_217_1.var_.actorSpriteComps1056 then
					for iter_220_4, iter_220_5 in pairs(arg_217_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_220_5 then
							if arg_217_1.isInRecall_ then
								local var_220_12 = Mathf.Lerp(iter_220_5.color.r, arg_217_1.hightColor2.r, var_220_11)
								local var_220_13 = Mathf.Lerp(iter_220_5.color.g, arg_217_1.hightColor2.g, var_220_11)
								local var_220_14 = Mathf.Lerp(iter_220_5.color.b, arg_217_1.hightColor2.b, var_220_11)

								iter_220_5.color = Color.New(var_220_12, var_220_13, var_220_14)
							else
								local var_220_15 = Mathf.Lerp(iter_220_5.color.r, 0.5, var_220_11)

								iter_220_5.color = Color.New(var_220_15, var_220_15, var_220_15)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_9 + var_220_10 and arg_217_1.time_ < var_220_9 + var_220_10 + arg_220_0 and not isNil(var_220_8) and arg_217_1.var_.actorSpriteComps1056 then
				for iter_220_6, iter_220_7 in pairs(arg_217_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_220_7 then
						if arg_217_1.isInRecall_ then
							iter_220_7.color = arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_220_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1056 = nil
			end

			local var_220_16 = 0
			local var_220_17 = 0.675

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_18 = arg_217_1:FormatText(StoryNameCfg[591].name)

				arg_217_1.leftNameTxt_.text = var_220_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_19 = arg_217_1:GetWordFromCfg(410122053)
				local var_220_20 = arg_217_1:FormatText(var_220_19.content)

				arg_217_1.text_.text = var_220_20

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_21 = 27
				local var_220_22 = utf8.len(var_220_20)
				local var_220_23 = var_220_21 <= 0 and var_220_17 or var_220_17 * (var_220_22 / var_220_21)

				if var_220_23 > 0 and var_220_17 < var_220_23 then
					arg_217_1.talkMaxDuration = var_220_23

					if var_220_23 + var_220_16 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_16
					end
				end

				arg_217_1.text_.text = var_220_20
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122053", "story_v_out_410122.awb") ~= 0 then
					local var_220_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122053", "story_v_out_410122.awb") / 1000

					if var_220_24 + var_220_16 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_24 + var_220_16
					end

					if var_220_19.prefab_name ~= "" and arg_217_1.actors_[var_220_19.prefab_name] ~= nil then
						local var_220_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_19.prefab_name].transform, "story_v_out_410122", "410122053", "story_v_out_410122.awb")

						arg_217_1:RecordAudio("410122053", var_220_25)
						arg_217_1:RecordAudio("410122053", var_220_25)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_410122", "410122053", "story_v_out_410122.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_410122", "410122053", "story_v_out_410122.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_26 = math.max(var_220_17, arg_217_1.talkMaxDuration)

			if var_220_16 <= arg_217_1.time_ and arg_217_1.time_ < var_220_16 + var_220_26 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_16) / var_220_26

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_16 + var_220_26 and arg_217_1.time_ < var_220_16 + var_220_26 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play410122054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410122054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play410122055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10063"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10063 == nil then
				arg_221_1.var_.actorSpriteComps10063 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.0666666666666667

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps10063 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10063:ToTable()) do
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

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10063 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10063 = nil
			end

			local var_224_8 = arg_221_1.actors_["1056"].transform
			local var_224_9 = 0

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				arg_221_1.var_.moveOldPos1056 = var_224_8.localPosition
				var_224_8.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1056", 7)

				local var_224_10 = var_224_8.childCount

				for iter_224_4 = 0, var_224_10 - 1 do
					local var_224_11 = var_224_8:GetChild(iter_224_4)

					if var_224_11.name == "split_1_1" or not string.find(var_224_11.name, "split") then
						var_224_11.gameObject:SetActive(true)
					else
						var_224_11.gameObject:SetActive(false)
					end
				end
			end

			local var_224_12 = 0.0666666666666667

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_12 then
				local var_224_13 = (arg_221_1.time_ - var_224_9) / var_224_12
				local var_224_14 = Vector3.New(0, -2000, -180)

				var_224_8.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1056, var_224_14, var_224_13)
			end

			if arg_221_1.time_ >= var_224_9 + var_224_12 and arg_221_1.time_ < var_224_9 + var_224_12 + arg_224_0 then
				var_224_8.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_224_15 = arg_221_1.actors_["10063"].transform
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 then
				arg_221_1.var_.moveOldPos10063 = var_224_15.localPosition
				var_224_15.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10063", 7)

				local var_224_17 = var_224_15.childCount

				for iter_224_5 = 0, var_224_17 - 1 do
					local var_224_18 = var_224_15:GetChild(iter_224_5)

					if var_224_18.name == "" or not string.find(var_224_18.name, "split") then
						var_224_18.gameObject:SetActive(true)
					else
						var_224_18.gameObject:SetActive(false)
					end
				end
			end

			local var_224_19 = 0.0666666666666667

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_19 then
				local var_224_20 = (arg_221_1.time_ - var_224_16) / var_224_19
				local var_224_21 = Vector3.New(0, -2000, -105)

				var_224_15.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10063, var_224_21, var_224_20)
			end

			if arg_221_1.time_ >= var_224_16 + var_224_19 and arg_221_1.time_ < var_224_16 + var_224_19 + arg_224_0 then
				var_224_15.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_224_22 = 0
			local var_224_23 = 1.35

			if var_224_22 < arg_221_1.time_ and arg_221_1.time_ <= var_224_22 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_24 = arg_221_1:GetWordFromCfg(410122054)
				local var_224_25 = arg_221_1:FormatText(var_224_24.content)

				arg_221_1.text_.text = var_224_25

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_26 = 54
				local var_224_27 = utf8.len(var_224_25)
				local var_224_28 = var_224_26 <= 0 and var_224_23 or var_224_23 * (var_224_27 / var_224_26)

				if var_224_28 > 0 and var_224_23 < var_224_28 then
					arg_221_1.talkMaxDuration = var_224_28

					if var_224_28 + var_224_22 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_28 + var_224_22
					end
				end

				arg_221_1.text_.text = var_224_25
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_29 = math.max(var_224_23, arg_221_1.talkMaxDuration)

			if var_224_22 <= arg_221_1.time_ and arg_221_1.time_ < var_224_22 + var_224_29 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_22) / var_224_29

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_22 + var_224_29 and arg_221_1.time_ < var_224_22 + var_224_29 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play410122055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410122055
		arg_225_1.duration_ = 7.77

		local var_225_0 = {
			zh = 4.7,
			ja = 7.766
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
				arg_225_0:Play410122056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10063"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10063 == nil then
				arg_225_1.var_.actorSpriteComps10063 = var_228_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_2 = 0.034

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.actorSpriteComps10063 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								local var_228_4 = Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor1.r, var_228_3)
								local var_228_5 = Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor1.g, var_228_3)
								local var_228_6 = Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor1.b, var_228_3)

								iter_228_1.color = Color.New(var_228_4, var_228_5, var_228_6)
							else
								local var_228_7 = Mathf.Lerp(iter_228_1.color.r, 1, var_228_3)

								iter_228_1.color = Color.New(var_228_7, var_228_7, var_228_7)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10063 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_228_3 then
						if arg_225_1.isInRecall_ then
							iter_228_3.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10063 = nil
			end

			local var_228_8 = arg_225_1.actors_["10063"].transform
			local var_228_9 = 0

			if var_228_9 < arg_225_1.time_ and arg_225_1.time_ <= var_228_9 + arg_228_0 then
				arg_225_1.var_.moveOldPos10063 = var_228_8.localPosition
				var_228_8.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10063", 2)

				local var_228_10 = var_228_8.childCount

				for iter_228_4 = 0, var_228_10 - 1 do
					local var_228_11 = var_228_8:GetChild(iter_228_4)

					if var_228_11.name == "" or not string.find(var_228_11.name, "split") then
						var_228_11.gameObject:SetActive(true)
					else
						var_228_11.gameObject:SetActive(false)
					end
				end
			end

			local var_228_12 = 0.001

			if var_228_9 <= arg_225_1.time_ and arg_225_1.time_ < var_228_9 + var_228_12 then
				local var_228_13 = (arg_225_1.time_ - var_228_9) / var_228_12
				local var_228_14 = Vector3.New(-390, -535, -105)

				var_228_8.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10063, var_228_14, var_228_13)
			end

			if arg_225_1.time_ >= var_228_9 + var_228_12 and arg_225_1.time_ < var_228_9 + var_228_12 + arg_228_0 then
				var_228_8.localPosition = Vector3.New(-390, -535, -105)
			end

			local var_228_15 = arg_225_1.actors_["1060"].transform
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 then
				arg_225_1.var_.moveOldPos1060 = var_228_15.localPosition
				var_228_15.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1060", 4)

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

			local var_228_19 = 0.0666666666666667

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_19 then
				local var_228_20 = (arg_225_1.time_ - var_228_16) / var_228_19
				local var_228_21 = Vector3.New(420.9, -430.8, 6.9)

				var_228_15.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1060, var_228_21, var_228_20)
			end

			if arg_225_1.time_ >= var_228_16 + var_228_19 and arg_225_1.time_ < var_228_16 + var_228_19 + arg_228_0 then
				var_228_15.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_228_22 = 0
			local var_228_23 = 0.575

			if var_228_22 < arg_225_1.time_ and arg_225_1.time_ <= var_228_22 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_24 = arg_225_1:FormatText(StoryNameCfg[591].name)

				arg_225_1.leftNameTxt_.text = var_228_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_25 = arg_225_1:GetWordFromCfg(410122055)
				local var_228_26 = arg_225_1:FormatText(var_228_25.content)

				arg_225_1.text_.text = var_228_26

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_27 = 23
				local var_228_28 = utf8.len(var_228_26)
				local var_228_29 = var_228_27 <= 0 and var_228_23 or var_228_23 * (var_228_28 / var_228_27)

				if var_228_29 > 0 and var_228_23 < var_228_29 then
					arg_225_1.talkMaxDuration = var_228_29

					if var_228_29 + var_228_22 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_29 + var_228_22
					end
				end

				arg_225_1.text_.text = var_228_26
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122055", "story_v_out_410122.awb") ~= 0 then
					local var_228_30 = manager.audio:GetVoiceLength("story_v_out_410122", "410122055", "story_v_out_410122.awb") / 1000

					if var_228_30 + var_228_22 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_30 + var_228_22
					end

					if var_228_25.prefab_name ~= "" and arg_225_1.actors_[var_228_25.prefab_name] ~= nil then
						local var_228_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_25.prefab_name].transform, "story_v_out_410122", "410122055", "story_v_out_410122.awb")

						arg_225_1:RecordAudio("410122055", var_228_31)
						arg_225_1:RecordAudio("410122055", var_228_31)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410122", "410122055", "story_v_out_410122.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410122", "410122055", "story_v_out_410122.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_32 = math.max(var_228_23, arg_225_1.talkMaxDuration)

			if var_228_22 <= arg_225_1.time_ and arg_225_1.time_ < var_228_22 + var_228_32 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_22) / var_228_32

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_22 + var_228_32 and arg_225_1.time_ < var_228_22 + var_228_32 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play410122056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410122056
		arg_229_1.duration_ = 4.17

		local var_229_0 = {
			zh = 1.7,
			ja = 4.166
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
				arg_229_0:Play410122057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1060"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1060 == nil then
				arg_229_1.var_.actorSpriteComps1060 = var_232_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_2 = 0.034

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.actorSpriteComps1060 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1060 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_232_3 then
						if arg_229_1.isInRecall_ then
							iter_232_3.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1060 = nil
			end

			local var_232_8 = arg_229_1.actors_["10063"]
			local var_232_9 = 0

			if var_232_9 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.actorSpriteComps10063 == nil then
				arg_229_1.var_.actorSpriteComps10063 = var_232_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_10 = 0.034

			if var_232_9 <= arg_229_1.time_ and arg_229_1.time_ < var_232_9 + var_232_10 and not isNil(var_232_8) then
				local var_232_11 = (arg_229_1.time_ - var_232_9) / var_232_10

				if arg_229_1.var_.actorSpriteComps10063 then
					for iter_232_4, iter_232_5 in pairs(arg_229_1.var_.actorSpriteComps10063:ToTable()) do
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

			if arg_229_1.time_ >= var_232_9 + var_232_10 and arg_229_1.time_ < var_232_9 + var_232_10 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.actorSpriteComps10063 then
				for iter_232_6, iter_232_7 in pairs(arg_229_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_232_7 then
						if arg_229_1.isInRecall_ then
							iter_232_7.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10063 = nil
			end

			local var_232_16 = 0
			local var_232_17 = 0.25

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_18 = arg_229_1:FormatText(StoryNameCfg[584].name)

				arg_229_1.leftNameTxt_.text = var_232_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_19 = arg_229_1:GetWordFromCfg(410122056)
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122056", "story_v_out_410122.awb") ~= 0 then
					local var_232_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122056", "story_v_out_410122.awb") / 1000

					if var_232_24 + var_232_16 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_24 + var_232_16
					end

					if var_232_19.prefab_name ~= "" and arg_229_1.actors_[var_232_19.prefab_name] ~= nil then
						local var_232_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_19.prefab_name].transform, "story_v_out_410122", "410122056", "story_v_out_410122.awb")

						arg_229_1:RecordAudio("410122056", var_232_25)
						arg_229_1:RecordAudio("410122056", var_232_25)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410122", "410122056", "story_v_out_410122.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410122", "410122056", "story_v_out_410122.awb")
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
	Play410122057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410122057
		arg_233_1.duration_ = 13.9

		local var_233_0 = {
			zh = 9.8,
			ja = 13.9
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
				arg_233_0:Play410122058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10063"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps10063 == nil then
				arg_233_1.var_.actorSpriteComps10063 = var_236_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_2 = 0.034

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.actorSpriteComps10063 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								local var_236_4 = Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor1.r, var_236_3)
								local var_236_5 = Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor1.g, var_236_3)
								local var_236_6 = Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor1.b, var_236_3)

								iter_236_1.color = Color.New(var_236_4, var_236_5, var_236_6)
							else
								local var_236_7 = Mathf.Lerp(iter_236_1.color.r, 1, var_236_3)

								iter_236_1.color = Color.New(var_236_7, var_236_7, var_236_7)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps10063 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_236_3 then
						if arg_233_1.isInRecall_ then
							iter_236_3.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10063 = nil
			end

			local var_236_8 = arg_233_1.actors_["1060"]
			local var_236_9 = 0

			if var_236_9 < arg_233_1.time_ and arg_233_1.time_ <= var_236_9 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.actorSpriteComps1060 == nil then
				arg_233_1.var_.actorSpriteComps1060 = var_236_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_10 = 0.034

			if var_236_9 <= arg_233_1.time_ and arg_233_1.time_ < var_236_9 + var_236_10 and not isNil(var_236_8) then
				local var_236_11 = (arg_233_1.time_ - var_236_9) / var_236_10

				if arg_233_1.var_.actorSpriteComps1060 then
					for iter_236_4, iter_236_5 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_236_5 then
							if arg_233_1.isInRecall_ then
								local var_236_12 = Mathf.Lerp(iter_236_5.color.r, arg_233_1.hightColor2.r, var_236_11)
								local var_236_13 = Mathf.Lerp(iter_236_5.color.g, arg_233_1.hightColor2.g, var_236_11)
								local var_236_14 = Mathf.Lerp(iter_236_5.color.b, arg_233_1.hightColor2.b, var_236_11)

								iter_236_5.color = Color.New(var_236_12, var_236_13, var_236_14)
							else
								local var_236_15 = Mathf.Lerp(iter_236_5.color.r, 0.5, var_236_11)

								iter_236_5.color = Color.New(var_236_15, var_236_15, var_236_15)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_9 + var_236_10 and arg_233_1.time_ < var_236_9 + var_236_10 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.actorSpriteComps1060 then
				for iter_236_6, iter_236_7 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_236_7 then
						if arg_233_1.isInRecall_ then
							iter_236_7.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1060 = nil
			end

			local var_236_16 = 0
			local var_236_17 = 1.225

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_18 = arg_233_1:FormatText(StoryNameCfg[591].name)

				arg_233_1.leftNameTxt_.text = var_236_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_19 = arg_233_1:GetWordFromCfg(410122057)
				local var_236_20 = arg_233_1:FormatText(var_236_19.content)

				arg_233_1.text_.text = var_236_20

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_21 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122057", "story_v_out_410122.awb") ~= 0 then
					local var_236_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122057", "story_v_out_410122.awb") / 1000

					if var_236_24 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_24 + var_236_16
					end

					if var_236_19.prefab_name ~= "" and arg_233_1.actors_[var_236_19.prefab_name] ~= nil then
						local var_236_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_19.prefab_name].transform, "story_v_out_410122", "410122057", "story_v_out_410122.awb")

						arg_233_1:RecordAudio("410122057", var_236_25)
						arg_233_1:RecordAudio("410122057", var_236_25)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_410122", "410122057", "story_v_out_410122.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_410122", "410122057", "story_v_out_410122.awb")
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
	Play410122058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410122058
		arg_237_1.duration_ = 4.17

		local var_237_0 = {
			zh = 4.066,
			ja = 4.166
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
				arg_237_0:Play410122059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1060"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.actorSpriteComps1060 == nil then
				arg_237_1.var_.actorSpriteComps1060 = var_240_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_2 = 0.034

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.actorSpriteComps1060 then
					for iter_240_0, iter_240_1 in pairs(arg_237_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_240_1 then
							if arg_237_1.isInRecall_ then
								local var_240_4 = Mathf.Lerp(iter_240_1.color.r, arg_237_1.hightColor1.r, var_240_3)
								local var_240_5 = Mathf.Lerp(iter_240_1.color.g, arg_237_1.hightColor1.g, var_240_3)
								local var_240_6 = Mathf.Lerp(iter_240_1.color.b, arg_237_1.hightColor1.b, var_240_3)

								iter_240_1.color = Color.New(var_240_4, var_240_5, var_240_6)
							else
								local var_240_7 = Mathf.Lerp(iter_240_1.color.r, 1, var_240_3)

								iter_240_1.color = Color.New(var_240_7, var_240_7, var_240_7)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.actorSpriteComps1060 then
				for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_240_3 then
						if arg_237_1.isInRecall_ then
							iter_240_3.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps1060 = nil
			end

			local var_240_8 = arg_237_1.actors_["10063"]
			local var_240_9 = 0

			if var_240_9 < arg_237_1.time_ and arg_237_1.time_ <= var_240_9 + arg_240_0 and not isNil(var_240_8) and arg_237_1.var_.actorSpriteComps10063 == nil then
				arg_237_1.var_.actorSpriteComps10063 = var_240_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_10 = 0.034

			if var_240_9 <= arg_237_1.time_ and arg_237_1.time_ < var_240_9 + var_240_10 and not isNil(var_240_8) then
				local var_240_11 = (arg_237_1.time_ - var_240_9) / var_240_10

				if arg_237_1.var_.actorSpriteComps10063 then
					for iter_240_4, iter_240_5 in pairs(arg_237_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_240_5 then
							if arg_237_1.isInRecall_ then
								local var_240_12 = Mathf.Lerp(iter_240_5.color.r, arg_237_1.hightColor2.r, var_240_11)
								local var_240_13 = Mathf.Lerp(iter_240_5.color.g, arg_237_1.hightColor2.g, var_240_11)
								local var_240_14 = Mathf.Lerp(iter_240_5.color.b, arg_237_1.hightColor2.b, var_240_11)

								iter_240_5.color = Color.New(var_240_12, var_240_13, var_240_14)
							else
								local var_240_15 = Mathf.Lerp(iter_240_5.color.r, 0.5, var_240_11)

								iter_240_5.color = Color.New(var_240_15, var_240_15, var_240_15)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_9 + var_240_10 and arg_237_1.time_ < var_240_9 + var_240_10 + arg_240_0 and not isNil(var_240_8) and arg_237_1.var_.actorSpriteComps10063 then
				for iter_240_6, iter_240_7 in pairs(arg_237_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_240_7 then
						if arg_237_1.isInRecall_ then
							iter_240_7.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10063 = nil
			end

			local var_240_16 = 0
			local var_240_17 = 0.475

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_18 = arg_237_1:FormatText(StoryNameCfg[584].name)

				arg_237_1.leftNameTxt_.text = var_240_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_19 = arg_237_1:GetWordFromCfg(410122058)
				local var_240_20 = arg_237_1:FormatText(var_240_19.content)

				arg_237_1.text_.text = var_240_20

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_21 = 19
				local var_240_22 = utf8.len(var_240_20)
				local var_240_23 = var_240_21 <= 0 and var_240_17 or var_240_17 * (var_240_22 / var_240_21)

				if var_240_23 > 0 and var_240_17 < var_240_23 then
					arg_237_1.talkMaxDuration = var_240_23

					if var_240_23 + var_240_16 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_23 + var_240_16
					end
				end

				arg_237_1.text_.text = var_240_20
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122058", "story_v_out_410122.awb") ~= 0 then
					local var_240_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122058", "story_v_out_410122.awb") / 1000

					if var_240_24 + var_240_16 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_24 + var_240_16
					end

					if var_240_19.prefab_name ~= "" and arg_237_1.actors_[var_240_19.prefab_name] ~= nil then
						local var_240_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_19.prefab_name].transform, "story_v_out_410122", "410122058", "story_v_out_410122.awb")

						arg_237_1:RecordAudio("410122058", var_240_25)
						arg_237_1:RecordAudio("410122058", var_240_25)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410122", "410122058", "story_v_out_410122.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410122", "410122058", "story_v_out_410122.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_26 = math.max(var_240_17, arg_237_1.talkMaxDuration)

			if var_240_16 <= arg_237_1.time_ and arg_237_1.time_ < var_240_16 + var_240_26 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_16) / var_240_26

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_16 + var_240_26 and arg_237_1.time_ < var_240_16 + var_240_26 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play410122059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410122059
		arg_241_1.duration_ = 7.17

		local var_241_0 = {
			zh = 7.166,
			ja = 6.333
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
				arg_241_0:Play410122060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10063"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps10063 == nil then
				arg_241_1.var_.actorSpriteComps10063 = var_244_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_2 = 0.034

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.actorSpriteComps10063 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps10063:ToTable()) do
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

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps10063 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_244_3 then
						if arg_241_1.isInRecall_ then
							iter_244_3.color = arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_244_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps10063 = nil
			end

			local var_244_8 = arg_241_1.actors_["1060"]
			local var_244_9 = 0

			if var_244_9 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 and not isNil(var_244_8) and arg_241_1.var_.actorSpriteComps1060 == nil then
				arg_241_1.var_.actorSpriteComps1060 = var_244_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_10 = 0.034

			if var_244_9 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_10 and not isNil(var_244_8) then
				local var_244_11 = (arg_241_1.time_ - var_244_9) / var_244_10

				if arg_241_1.var_.actorSpriteComps1060 then
					for iter_244_4, iter_244_5 in pairs(arg_241_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_244_5 then
							if arg_241_1.isInRecall_ then
								local var_244_12 = Mathf.Lerp(iter_244_5.color.r, arg_241_1.hightColor2.r, var_244_11)
								local var_244_13 = Mathf.Lerp(iter_244_5.color.g, arg_241_1.hightColor2.g, var_244_11)
								local var_244_14 = Mathf.Lerp(iter_244_5.color.b, arg_241_1.hightColor2.b, var_244_11)

								iter_244_5.color = Color.New(var_244_12, var_244_13, var_244_14)
							else
								local var_244_15 = Mathf.Lerp(iter_244_5.color.r, 0.5, var_244_11)

								iter_244_5.color = Color.New(var_244_15, var_244_15, var_244_15)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_9 + var_244_10 and arg_241_1.time_ < var_244_9 + var_244_10 + arg_244_0 and not isNil(var_244_8) and arg_241_1.var_.actorSpriteComps1060 then
				for iter_244_6, iter_244_7 in pairs(arg_241_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_244_7 then
						if arg_241_1.isInRecall_ then
							iter_244_7.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps1060 = nil
			end

			local var_244_16 = 0
			local var_244_17 = 0.9

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_18 = arg_241_1:FormatText(StoryNameCfg[591].name)

				arg_241_1.leftNameTxt_.text = var_244_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_19 = arg_241_1:GetWordFromCfg(410122059)
				local var_244_20 = arg_241_1:FormatText(var_244_19.content)

				arg_241_1.text_.text = var_244_20

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_21 = 36
				local var_244_22 = utf8.len(var_244_20)
				local var_244_23 = var_244_21 <= 0 and var_244_17 or var_244_17 * (var_244_22 / var_244_21)

				if var_244_23 > 0 and var_244_17 < var_244_23 then
					arg_241_1.talkMaxDuration = var_244_23

					if var_244_23 + var_244_16 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_16
					end
				end

				arg_241_1.text_.text = var_244_20
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122059", "story_v_out_410122.awb") ~= 0 then
					local var_244_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122059", "story_v_out_410122.awb") / 1000

					if var_244_24 + var_244_16 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_24 + var_244_16
					end

					if var_244_19.prefab_name ~= "" and arg_241_1.actors_[var_244_19.prefab_name] ~= nil then
						local var_244_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_19.prefab_name].transform, "story_v_out_410122", "410122059", "story_v_out_410122.awb")

						arg_241_1:RecordAudio("410122059", var_244_25)
						arg_241_1:RecordAudio("410122059", var_244_25)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410122", "410122059", "story_v_out_410122.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410122", "410122059", "story_v_out_410122.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_26 = math.max(var_244_17, arg_241_1.talkMaxDuration)

			if var_244_16 <= arg_241_1.time_ and arg_241_1.time_ < var_244_16 + var_244_26 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_16) / var_244_26

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_16 + var_244_26 and arg_241_1.time_ < var_244_16 + var_244_26 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play410122060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410122060
		arg_245_1.duration_ = 9.77

		local var_245_0 = {
			zh = 8.433,
			ja = 9.766
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
				arg_245_0:Play410122061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 1.15

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[591].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:GetWordFromCfg(410122060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122060", "story_v_out_410122.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122060", "story_v_out_410122.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_410122", "410122060", "story_v_out_410122.awb")

						arg_245_1:RecordAudio("410122060", var_248_9)
						arg_245_1:RecordAudio("410122060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_410122", "410122060", "story_v_out_410122.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_410122", "410122060", "story_v_out_410122.awb")
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
	Play410122061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410122061
		arg_249_1.duration_ = 9.43

		local var_249_0 = {
			zh = 9.433,
			ja = 9.166
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
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play410122062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 1.125

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[591].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:GetWordFromCfg(410122061)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 45
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122061", "story_v_out_410122.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122061", "story_v_out_410122.awb") / 1000

					if var_252_8 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_0
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_410122", "410122061", "story_v_out_410122.awb")

						arg_249_1:RecordAudio("410122061", var_252_9)
						arg_249_1:RecordAudio("410122061", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410122", "410122061", "story_v_out_410122.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410122", "410122061", "story_v_out_410122.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_10 and arg_249_1.time_ < var_252_0 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play410122062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410122062
		arg_253_1.duration_ = 4.17

		local var_253_0 = {
			zh = 3.5,
			ja = 4.166
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
				arg_253_0:Play410122063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1060"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps1060 == nil then
				arg_253_1.var_.actorSpriteComps1060 = var_256_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_2 = 0.034

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.actorSpriteComps1060 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps1060 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_256_3 then
						if arg_253_1.isInRecall_ then
							iter_256_3.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1060 = nil
			end

			local var_256_8 = arg_253_1.actors_["10063"]
			local var_256_9 = 0

			if var_256_9 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps10063 == nil then
				arg_253_1.var_.actorSpriteComps10063 = var_256_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_10 = 0.034

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_10 and not isNil(var_256_8) then
				local var_256_11 = (arg_253_1.time_ - var_256_9) / var_256_10

				if arg_253_1.var_.actorSpriteComps10063 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								local var_256_12 = Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, var_256_11)
								local var_256_13 = Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, var_256_11)
								local var_256_14 = Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, var_256_11)

								iter_256_5.color = Color.New(var_256_12, var_256_13, var_256_14)
							else
								local var_256_15 = Mathf.Lerp(iter_256_5.color.r, 0.5, var_256_11)

								iter_256_5.color = Color.New(var_256_15, var_256_15, var_256_15)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_9 + var_256_10 and arg_253_1.time_ < var_256_9 + var_256_10 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps10063 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_256_7 then
						if arg_253_1.isInRecall_ then
							iter_256_7.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10063 = nil
			end

			local var_256_16 = 0
			local var_256_17 = 0.3

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_18 = arg_253_1:FormatText(StoryNameCfg[584].name)

				arg_253_1.leftNameTxt_.text = var_256_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_19 = arg_253_1:GetWordFromCfg(410122062)
				local var_256_20 = arg_253_1:FormatText(var_256_19.content)

				arg_253_1.text_.text = var_256_20

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_21 = 12
				local var_256_22 = utf8.len(var_256_20)
				local var_256_23 = var_256_21 <= 0 and var_256_17 or var_256_17 * (var_256_22 / var_256_21)

				if var_256_23 > 0 and var_256_17 < var_256_23 then
					arg_253_1.talkMaxDuration = var_256_23

					if var_256_23 + var_256_16 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_23 + var_256_16
					end
				end

				arg_253_1.text_.text = var_256_20
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122062", "story_v_out_410122.awb") ~= 0 then
					local var_256_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122062", "story_v_out_410122.awb") / 1000

					if var_256_24 + var_256_16 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_24 + var_256_16
					end

					if var_256_19.prefab_name ~= "" and arg_253_1.actors_[var_256_19.prefab_name] ~= nil then
						local var_256_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_19.prefab_name].transform, "story_v_out_410122", "410122062", "story_v_out_410122.awb")

						arg_253_1:RecordAudio("410122062", var_256_25)
						arg_253_1:RecordAudio("410122062", var_256_25)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_410122", "410122062", "story_v_out_410122.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_410122", "410122062", "story_v_out_410122.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_26 = math.max(var_256_17, arg_253_1.talkMaxDuration)

			if var_256_16 <= arg_253_1.time_ and arg_253_1.time_ < var_256_16 + var_256_26 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_16) / var_256_26

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_16 + var_256_26 and arg_253_1.time_ < var_256_16 + var_256_26 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play410122063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410122063
		arg_257_1.duration_ = 6

		local var_257_0 = {
			zh = 4.8,
			ja = 6
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
				arg_257_0:Play410122064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10063"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10063 == nil then
				arg_257_1.var_.actorSpriteComps10063 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.034

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps10063 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10063:ToTable()) do
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

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10063 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10063 = nil
			end

			local var_260_8 = arg_257_1.actors_["1060"]
			local var_260_9 = 0

			if var_260_9 < arg_257_1.time_ and arg_257_1.time_ <= var_260_9 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps1060 == nil then
				arg_257_1.var_.actorSpriteComps1060 = var_260_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_10 = 0.034

			if var_260_9 <= arg_257_1.time_ and arg_257_1.time_ < var_260_9 + var_260_10 and not isNil(var_260_8) then
				local var_260_11 = (arg_257_1.time_ - var_260_9) / var_260_10

				if arg_257_1.var_.actorSpriteComps1060 then
					for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_257_1.time_ >= var_260_9 + var_260_10 and arg_257_1.time_ < var_260_9 + var_260_10 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps1060 then
				for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_260_7 then
						if arg_257_1.isInRecall_ then
							iter_260_7.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1060 = nil
			end

			local var_260_16 = 0
			local var_260_17 = 0.5

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_18 = arg_257_1:FormatText(StoryNameCfg[591].name)

				arg_257_1.leftNameTxt_.text = var_260_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_19 = arg_257_1:GetWordFromCfg(410122063)
				local var_260_20 = arg_257_1:FormatText(var_260_19.content)

				arg_257_1.text_.text = var_260_20

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_21 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122063", "story_v_out_410122.awb") ~= 0 then
					local var_260_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122063", "story_v_out_410122.awb") / 1000

					if var_260_24 + var_260_16 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_24 + var_260_16
					end

					if var_260_19.prefab_name ~= "" and arg_257_1.actors_[var_260_19.prefab_name] ~= nil then
						local var_260_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_19.prefab_name].transform, "story_v_out_410122", "410122063", "story_v_out_410122.awb")

						arg_257_1:RecordAudio("410122063", var_260_25)
						arg_257_1:RecordAudio("410122063", var_260_25)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_410122", "410122063", "story_v_out_410122.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_410122", "410122063", "story_v_out_410122.awb")
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
	Play410122064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410122064
		arg_261_1.duration_ = 14.43

		local var_261_0 = {
			zh = 13.9,
			ja = 14.433
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
				arg_261_0:Play410122065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 1.675

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[591].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:GetWordFromCfg(410122064)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 67
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122064", "story_v_out_410122.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122064", "story_v_out_410122.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_410122", "410122064", "story_v_out_410122.awb")

						arg_261_1:RecordAudio("410122064", var_264_9)
						arg_261_1:RecordAudio("410122064", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410122", "410122064", "story_v_out_410122.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410122", "410122064", "story_v_out_410122.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play410122065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410122065
		arg_265_1.duration_ = 18.3

		local var_265_0 = {
			zh = 11.633,
			ja = 18.3
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
				arg_265_0:Play410122066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 1.525

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[591].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(410122065)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 61
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122065", "story_v_out_410122.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122065", "story_v_out_410122.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_410122", "410122065", "story_v_out_410122.awb")

						arg_265_1:RecordAudio("410122065", var_268_9)
						arg_265_1:RecordAudio("410122065", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410122", "410122065", "story_v_out_410122.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410122", "410122065", "story_v_out_410122.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_10 and arg_265_1.time_ < var_268_0 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play410122066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410122066
		arg_269_1.duration_ = 4.97

		local var_269_0 = {
			zh = 4.2,
			ja = 4.966
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
				arg_269_0:Play410122067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.35

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[591].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:GetWordFromCfg(410122066)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 15
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122066", "story_v_out_410122.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122066", "story_v_out_410122.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_410122", "410122066", "story_v_out_410122.awb")

						arg_269_1:RecordAudio("410122066", var_272_9)
						arg_269_1:RecordAudio("410122066", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410122", "410122066", "story_v_out_410122.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410122", "410122066", "story_v_out_410122.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play410122067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410122067
		arg_273_1.duration_ = 6.87

		local var_273_0 = {
			zh = 1.5,
			ja = 6.866
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
				arg_273_0:Play410122068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1060"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1060 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1060", 4)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "split_4" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(420.9, -430.8, 6.9)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1060, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_276_7 = arg_273_1.actors_["1060"]
			local var_276_8 = 0

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1060 == nil then
				arg_273_1.var_.actorSpriteComps1060 = var_276_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_9 = 0.034

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 and not isNil(var_276_7) then
				local var_276_10 = (arg_273_1.time_ - var_276_8) / var_276_9

				if arg_273_1.var_.actorSpriteComps1060 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								local var_276_11 = Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor1.r, var_276_10)
								local var_276_12 = Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor1.g, var_276_10)
								local var_276_13 = Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor1.b, var_276_10)

								iter_276_2.color = Color.New(var_276_11, var_276_12, var_276_13)
							else
								local var_276_14 = Mathf.Lerp(iter_276_2.color.r, 1, var_276_10)

								iter_276_2.color = Color.New(var_276_14, var_276_14, var_276_14)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1060 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_276_4 then
						if arg_273_1.isInRecall_ then
							iter_276_4.color = arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_276_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps1060 = nil
			end

			local var_276_15 = arg_273_1.actors_["10063"]
			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.actorSpriteComps10063 == nil then
				arg_273_1.var_.actorSpriteComps10063 = var_276_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_17 = 0.034

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 and not isNil(var_276_15) then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17

				if arg_273_1.var_.actorSpriteComps10063 then
					for iter_276_5, iter_276_6 in pairs(arg_273_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_276_6 then
							if arg_273_1.isInRecall_ then
								local var_276_19 = Mathf.Lerp(iter_276_6.color.r, arg_273_1.hightColor2.r, var_276_18)
								local var_276_20 = Mathf.Lerp(iter_276_6.color.g, arg_273_1.hightColor2.g, var_276_18)
								local var_276_21 = Mathf.Lerp(iter_276_6.color.b, arg_273_1.hightColor2.b, var_276_18)

								iter_276_6.color = Color.New(var_276_19, var_276_20, var_276_21)
							else
								local var_276_22 = Mathf.Lerp(iter_276_6.color.r, 0.5, var_276_18)

								iter_276_6.color = Color.New(var_276_22, var_276_22, var_276_22)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.actorSpriteComps10063 then
				for iter_276_7, iter_276_8 in pairs(arg_273_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_276_8 then
						if arg_273_1.isInRecall_ then
							iter_276_8.color = arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_276_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps10063 = nil
			end

			local var_276_23 = arg_273_1.actors_["1056"].transform
			local var_276_24 = 0

			if var_276_24 < arg_273_1.time_ and arg_273_1.time_ <= var_276_24 + arg_276_0 then
				arg_273_1.var_.moveOldPos1056 = var_276_23.localPosition
				var_276_23.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1056", 7)

				local var_276_25 = var_276_23.childCount

				for iter_276_9 = 0, var_276_25 - 1 do
					local var_276_26 = var_276_23:GetChild(iter_276_9)

					if var_276_26.name == "split_4" or not string.find(var_276_26.name, "split") then
						var_276_26.gameObject:SetActive(true)
					else
						var_276_26.gameObject:SetActive(false)
					end
				end
			end

			local var_276_27 = 0.001

			if var_276_24 <= arg_273_1.time_ and arg_273_1.time_ < var_276_24 + var_276_27 then
				local var_276_28 = (arg_273_1.time_ - var_276_24) / var_276_27
				local var_276_29 = Vector3.New(0, -2000, -40)

				var_276_23.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1056, var_276_29, var_276_28)
			end

			if arg_273_1.time_ >= var_276_24 + var_276_27 and arg_273_1.time_ < var_276_24 + var_276_27 + arg_276_0 then
				var_276_23.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_276_30 = arg_273_1.actors_["10063"].transform
			local var_276_31 = 0

			if var_276_31 < arg_273_1.time_ and arg_273_1.time_ <= var_276_31 + arg_276_0 then
				arg_273_1.var_.moveOldPos10063 = var_276_30.localPosition
				var_276_30.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10063", 2)

				local var_276_32 = var_276_30.childCount

				for iter_276_10 = 0, var_276_32 - 1 do
					local var_276_33 = var_276_30:GetChild(iter_276_10)

					if var_276_33.name == "split_4" or not string.find(var_276_33.name, "split") then
						var_276_33.gameObject:SetActive(true)
					else
						var_276_33.gameObject:SetActive(false)
					end
				end
			end

			local var_276_34 = 0.001

			if var_276_31 <= arg_273_1.time_ and arg_273_1.time_ < var_276_31 + var_276_34 then
				local var_276_35 = (arg_273_1.time_ - var_276_31) / var_276_34
				local var_276_36 = Vector3.New(-390, -535, -105)

				var_276_30.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10063, var_276_36, var_276_35)
			end

			if arg_273_1.time_ >= var_276_31 + var_276_34 and arg_273_1.time_ < var_276_31 + var_276_34 + arg_276_0 then
				var_276_30.localPosition = Vector3.New(-390, -535, -105)
			end

			local var_276_37 = 0
			local var_276_38 = 0.225

			if var_276_37 < arg_273_1.time_ and arg_273_1.time_ <= var_276_37 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_39 = arg_273_1:FormatText(StoryNameCfg[584].name)

				arg_273_1.leftNameTxt_.text = var_276_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_40 = arg_273_1:GetWordFromCfg(410122067)
				local var_276_41 = arg_273_1:FormatText(var_276_40.content)

				arg_273_1.text_.text = var_276_41

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_42 = 9
				local var_276_43 = utf8.len(var_276_41)
				local var_276_44 = var_276_42 <= 0 and var_276_38 or var_276_38 * (var_276_43 / var_276_42)

				if var_276_44 > 0 and var_276_38 < var_276_44 then
					arg_273_1.talkMaxDuration = var_276_44

					if var_276_44 + var_276_37 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_44 + var_276_37
					end
				end

				arg_273_1.text_.text = var_276_41
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122067", "story_v_out_410122.awb") ~= 0 then
					local var_276_45 = manager.audio:GetVoiceLength("story_v_out_410122", "410122067", "story_v_out_410122.awb") / 1000

					if var_276_45 + var_276_37 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_45 + var_276_37
					end

					if var_276_40.prefab_name ~= "" and arg_273_1.actors_[var_276_40.prefab_name] ~= nil then
						local var_276_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_40.prefab_name].transform, "story_v_out_410122", "410122067", "story_v_out_410122.awb")

						arg_273_1:RecordAudio("410122067", var_276_46)
						arg_273_1:RecordAudio("410122067", var_276_46)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410122", "410122067", "story_v_out_410122.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410122", "410122067", "story_v_out_410122.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_47 = math.max(var_276_38, arg_273_1.talkMaxDuration)

			if var_276_37 <= arg_273_1.time_ and arg_273_1.time_ < var_276_37 + var_276_47 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_37) / var_276_47

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_37 + var_276_47 and arg_273_1.time_ < var_276_37 + var_276_47 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play410122068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410122068
		arg_277_1.duration_ = 13.6

		local var_277_0 = {
			zh = 10.3,
			ja = 13.6
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
				arg_277_0:Play410122069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10063"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps10063 == nil then
				arg_277_1.var_.actorSpriteComps10063 = var_280_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_2 = 0.034

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.actorSpriteComps10063 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps10063:ToTable()) do
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

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps10063 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_280_3 then
						if arg_277_1.isInRecall_ then
							iter_280_3.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps10063 = nil
			end

			local var_280_8 = arg_277_1.actors_["1060"]
			local var_280_9 = 0

			if var_280_9 < arg_277_1.time_ and arg_277_1.time_ <= var_280_9 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps1060 == nil then
				arg_277_1.var_.actorSpriteComps1060 = var_280_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_10 = 0.034

			if var_280_9 <= arg_277_1.time_ and arg_277_1.time_ < var_280_9 + var_280_10 and not isNil(var_280_8) then
				local var_280_11 = (arg_277_1.time_ - var_280_9) / var_280_10

				if arg_277_1.var_.actorSpriteComps1060 then
					for iter_280_4, iter_280_5 in pairs(arg_277_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_277_1.time_ >= var_280_9 + var_280_10 and arg_277_1.time_ < var_280_9 + var_280_10 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps1060 then
				for iter_280_6, iter_280_7 in pairs(arg_277_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_280_7 then
						if arg_277_1.isInRecall_ then
							iter_280_7.color = arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_280_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1060 = nil
			end

			local var_280_16 = 0
			local var_280_17 = 0.95

			if var_280_16 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_18 = arg_277_1:FormatText(StoryNameCfg[591].name)

				arg_277_1.leftNameTxt_.text = var_280_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_19 = arg_277_1:GetWordFromCfg(410122068)
				local var_280_20 = arg_277_1:FormatText(var_280_19.content)

				arg_277_1.text_.text = var_280_20

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_21 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122068", "story_v_out_410122.awb") ~= 0 then
					local var_280_24 = manager.audio:GetVoiceLength("story_v_out_410122", "410122068", "story_v_out_410122.awb") / 1000

					if var_280_24 + var_280_16 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_24 + var_280_16
					end

					if var_280_19.prefab_name ~= "" and arg_277_1.actors_[var_280_19.prefab_name] ~= nil then
						local var_280_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_19.prefab_name].transform, "story_v_out_410122", "410122068", "story_v_out_410122.awb")

						arg_277_1:RecordAudio("410122068", var_280_25)
						arg_277_1:RecordAudio("410122068", var_280_25)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410122", "410122068", "story_v_out_410122.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410122", "410122068", "story_v_out_410122.awb")
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
	Play410122069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410122069
		arg_281_1.duration_ = 18.07

		local var_281_0 = {
			zh = 7.833,
			ja = 18.066
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
				arg_281_0:Play410122070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 1.025

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[591].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:GetWordFromCfg(410122069)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 41
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122069", "story_v_out_410122.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122069", "story_v_out_410122.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_410122", "410122069", "story_v_out_410122.awb")

						arg_281_1:RecordAudio("410122069", var_284_9)
						arg_281_1:RecordAudio("410122069", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410122", "410122069", "story_v_out_410122.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410122", "410122069", "story_v_out_410122.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_10 and arg_281_1.time_ < var_284_0 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play410122070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410122070
		arg_285_1.duration_ = 11.83

		local var_285_0 = {
			zh = 8.266,
			ja = 11.833
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play410122071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1060"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1060 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1060", 4)

				local var_288_2 = var_288_0.childCount

				for iter_288_0 = 0, var_288_2 - 1 do
					local var_288_3 = var_288_0:GetChild(iter_288_0)

					if var_288_3.name == "" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_4 then
				local var_288_5 = (arg_285_1.time_ - var_288_1) / var_288_4
				local var_288_6 = Vector3.New(420.9, -430.8, 6.9)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1060, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_288_7 = arg_285_1.actors_["1060"]
			local var_288_8 = 0

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps1060 == nil then
				arg_285_1.var_.actorSpriteComps1060 = var_288_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_9 = 0.034

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_9 and not isNil(var_288_7) then
				local var_288_10 = (arg_285_1.time_ - var_288_8) / var_288_9

				if arg_285_1.var_.actorSpriteComps1060 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_288_2 then
							if arg_285_1.isInRecall_ then
								local var_288_11 = Mathf.Lerp(iter_288_2.color.r, arg_285_1.hightColor1.r, var_288_10)
								local var_288_12 = Mathf.Lerp(iter_288_2.color.g, arg_285_1.hightColor1.g, var_288_10)
								local var_288_13 = Mathf.Lerp(iter_288_2.color.b, arg_285_1.hightColor1.b, var_288_10)

								iter_288_2.color = Color.New(var_288_11, var_288_12, var_288_13)
							else
								local var_288_14 = Mathf.Lerp(iter_288_2.color.r, 1, var_288_10)

								iter_288_2.color = Color.New(var_288_14, var_288_14, var_288_14)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_8 + var_288_9 and arg_285_1.time_ < var_288_8 + var_288_9 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps1060 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_288_4 then
						if arg_285_1.isInRecall_ then
							iter_288_4.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1060 = nil
			end

			local var_288_15 = arg_285_1.actors_["10063"]
			local var_288_16 = 0

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.actorSpriteComps10063 == nil then
				arg_285_1.var_.actorSpriteComps10063 = var_288_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_17 = 0.034

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_17 and not isNil(var_288_15) then
				local var_288_18 = (arg_285_1.time_ - var_288_16) / var_288_17

				if arg_285_1.var_.actorSpriteComps10063 then
					for iter_288_5, iter_288_6 in pairs(arg_285_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_288_6 then
							if arg_285_1.isInRecall_ then
								local var_288_19 = Mathf.Lerp(iter_288_6.color.r, arg_285_1.hightColor2.r, var_288_18)
								local var_288_20 = Mathf.Lerp(iter_288_6.color.g, arg_285_1.hightColor2.g, var_288_18)
								local var_288_21 = Mathf.Lerp(iter_288_6.color.b, arg_285_1.hightColor2.b, var_288_18)

								iter_288_6.color = Color.New(var_288_19, var_288_20, var_288_21)
							else
								local var_288_22 = Mathf.Lerp(iter_288_6.color.r, 0.5, var_288_18)

								iter_288_6.color = Color.New(var_288_22, var_288_22, var_288_22)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.actorSpriteComps10063 then
				for iter_288_7, iter_288_8 in pairs(arg_285_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_288_8 then
						if arg_285_1.isInRecall_ then
							iter_288_8.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10063 = nil
			end

			local var_288_23 = 0
			local var_288_24 = 1

			if var_288_23 < arg_285_1.time_ and arg_285_1.time_ <= var_288_23 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_25 = arg_285_1:FormatText(StoryNameCfg[584].name)

				arg_285_1.leftNameTxt_.text = var_288_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_26 = arg_285_1:GetWordFromCfg(410122070)
				local var_288_27 = arg_285_1:FormatText(var_288_26.content)

				arg_285_1.text_.text = var_288_27

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_28 = 40
				local var_288_29 = utf8.len(var_288_27)
				local var_288_30 = var_288_28 <= 0 and var_288_24 or var_288_24 * (var_288_29 / var_288_28)

				if var_288_30 > 0 and var_288_24 < var_288_30 then
					arg_285_1.talkMaxDuration = var_288_30

					if var_288_30 + var_288_23 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_30 + var_288_23
					end
				end

				arg_285_1.text_.text = var_288_27
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122070", "story_v_out_410122.awb") ~= 0 then
					local var_288_31 = manager.audio:GetVoiceLength("story_v_out_410122", "410122070", "story_v_out_410122.awb") / 1000

					if var_288_31 + var_288_23 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_31 + var_288_23
					end

					if var_288_26.prefab_name ~= "" and arg_285_1.actors_[var_288_26.prefab_name] ~= nil then
						local var_288_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_26.prefab_name].transform, "story_v_out_410122", "410122070", "story_v_out_410122.awb")

						arg_285_1:RecordAudio("410122070", var_288_32)
						arg_285_1:RecordAudio("410122070", var_288_32)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410122", "410122070", "story_v_out_410122.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410122", "410122070", "story_v_out_410122.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_33 = math.max(var_288_24, arg_285_1.talkMaxDuration)

			if var_288_23 <= arg_285_1.time_ and arg_285_1.time_ < var_288_23 + var_288_33 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_23) / var_288_33

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_23 + var_288_33 and arg_285_1.time_ < var_288_23 + var_288_33 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
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

		arg_285_1:InitPlayNodeList()
	end,
	Play410122071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410122071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play410122072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1060"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1060 == nil then
				arg_289_1.var_.actorSpriteComps1060 = var_292_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_2 = 0.034

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.actorSpriteComps1060 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								local var_292_4 = Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor2.r, var_292_3)
								local var_292_5 = Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor2.g, var_292_3)
								local var_292_6 = Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor2.b, var_292_3)

								iter_292_1.color = Color.New(var_292_4, var_292_5, var_292_6)
							else
								local var_292_7 = Mathf.Lerp(iter_292_1.color.r, 0.5, var_292_3)

								iter_292_1.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1060 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_292_3 then
						if arg_289_1.isInRecall_ then
							iter_292_3.color = arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_292_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1060 = nil
			end

			local var_292_8 = 0
			local var_292_9 = 1.25

			if var_292_8 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_10 = arg_289_1:GetWordFromCfg(410122071)
				local var_292_11 = arg_289_1:FormatText(var_292_10.content)

				arg_289_1.text_.text = var_292_11

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_12 = 50
				local var_292_13 = utf8.len(var_292_11)
				local var_292_14 = var_292_12 <= 0 and var_292_9 or var_292_9 * (var_292_13 / var_292_12)

				if var_292_14 > 0 and var_292_9 < var_292_14 then
					arg_289_1.talkMaxDuration = var_292_14

					if var_292_14 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_8
					end
				end

				arg_289_1.text_.text = var_292_11
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_15 = math.max(var_292_9, arg_289_1.talkMaxDuration)

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_15 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_8) / var_292_15

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_8 + var_292_15 and arg_289_1.time_ < var_292_8 + var_292_15 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play410122072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410122072
		arg_293_1.duration_ = 13.63

		local var_293_0 = {
			zh = 13.633,
			ja = 6
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
				arg_293_0:Play410122073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["10063"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps10063 == nil then
				arg_293_1.var_.actorSpriteComps10063 = var_296_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_2 = 0.333333333333333

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.actorSpriteComps10063 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								local var_296_4 = Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor1.r, var_296_3)
								local var_296_5 = Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor1.g, var_296_3)
								local var_296_6 = Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor1.b, var_296_3)

								iter_296_1.color = Color.New(var_296_4, var_296_5, var_296_6)
							else
								local var_296_7 = Mathf.Lerp(iter_296_1.color.r, 1, var_296_3)

								iter_296_1.color = Color.New(var_296_7, var_296_7, var_296_7)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps10063 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_296_3 then
						if arg_293_1.isInRecall_ then
							iter_296_3.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps10063 = nil
			end

			local var_296_8 = 0
			local var_296_9 = 0.4

			if var_296_8 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_10 = arg_293_1:FormatText(StoryNameCfg[591].name)

				arg_293_1.leftNameTxt_.text = var_296_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_11 = arg_293_1:GetWordFromCfg(410122072)
				local var_296_12 = arg_293_1:FormatText(var_296_11.content)

				arg_293_1.text_.text = var_296_12

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_13 = 16
				local var_296_14 = utf8.len(var_296_12)
				local var_296_15 = var_296_13 <= 0 and var_296_9 or var_296_9 * (var_296_14 / var_296_13)

				if var_296_15 > 0 and var_296_9 < var_296_15 then
					arg_293_1.talkMaxDuration = var_296_15

					if var_296_15 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_15 + var_296_8
					end
				end

				arg_293_1.text_.text = var_296_12
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122072", "story_v_out_410122.awb") ~= 0 then
					local var_296_16 = manager.audio:GetVoiceLength("story_v_out_410122", "410122072", "story_v_out_410122.awb") / 1000

					if var_296_16 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_16 + var_296_8
					end

					if var_296_11.prefab_name ~= "" and arg_293_1.actors_[var_296_11.prefab_name] ~= nil then
						local var_296_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_11.prefab_name].transform, "story_v_out_410122", "410122072", "story_v_out_410122.awb")

						arg_293_1:RecordAudio("410122072", var_296_17)
						arg_293_1:RecordAudio("410122072", var_296_17)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410122", "410122072", "story_v_out_410122.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410122", "410122072", "story_v_out_410122.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_18 = math.max(var_296_9, arg_293_1.talkMaxDuration)

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_18 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_8) / var_296_18

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_8 + var_296_18 and arg_293_1.time_ < var_296_8 + var_296_18 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play410122073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410122073
		arg_297_1.duration_ = 7.07

		local var_297_0 = {
			zh = 7.066,
			ja = 6.966
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
				arg_297_0:Play410122074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.5

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[591].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_3 = arg_297_1:GetWordFromCfg(410122073)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 20
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122073", "story_v_out_410122.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122073", "story_v_out_410122.awb") / 1000

					if var_300_8 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_0
					end

					if var_300_3.prefab_name ~= "" and arg_297_1.actors_[var_300_3.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_3.prefab_name].transform, "story_v_out_410122", "410122073", "story_v_out_410122.awb")

						arg_297_1:RecordAudio("410122073", var_300_9)
						arg_297_1:RecordAudio("410122073", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410122", "410122073", "story_v_out_410122.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410122", "410122073", "story_v_out_410122.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_10 and arg_297_1.time_ < var_300_0 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play410122074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410122074
		arg_301_1.duration_ = 14.87

		local var_301_0 = {
			zh = 10.9,
			ja = 14.866
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
				arg_301_0:Play410122075(arg_301_1)
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

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[591].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:GetWordFromCfg(410122074)
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

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122074", "story_v_out_410122.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122074", "story_v_out_410122.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_410122", "410122074", "story_v_out_410122.awb")

						arg_301_1:RecordAudio("410122074", var_304_9)
						arg_301_1:RecordAudio("410122074", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_410122", "410122074", "story_v_out_410122.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_410122", "410122074", "story_v_out_410122.awb")
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
	Play410122075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410122075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play410122076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["10063"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos10063 = var_308_0.localPosition
				var_308_0.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("10063", 7)

				local var_308_2 = var_308_0.childCount

				for iter_308_0 = 0, var_308_2 - 1 do
					local var_308_3 = var_308_0:GetChild(iter_308_0)

					if var_308_3.name == "" or not string.find(var_308_3.name, "split") then
						var_308_3.gameObject:SetActive(true)
					else
						var_308_3.gameObject:SetActive(false)
					end
				end
			end

			local var_308_4 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_4 then
				local var_308_5 = (arg_305_1.time_ - var_308_1) / var_308_4
				local var_308_6 = Vector3.New(0, -2000, -105)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10063, var_308_6, var_308_5)
			end

			if arg_305_1.time_ >= var_308_1 + var_308_4 and arg_305_1.time_ < var_308_1 + var_308_4 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_308_7 = arg_305_1.actors_["10063"]
			local var_308_8 = 0

			if var_308_8 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 and not isNil(var_308_7) and arg_305_1.var_.actorSpriteComps10063 == nil then
				arg_305_1.var_.actorSpriteComps10063 = var_308_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_9 = 0.034

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_9 and not isNil(var_308_7) then
				local var_308_10 = (arg_305_1.time_ - var_308_8) / var_308_9

				if arg_305_1.var_.actorSpriteComps10063 then
					for iter_308_1, iter_308_2 in pairs(arg_305_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_308_2 then
							if arg_305_1.isInRecall_ then
								local var_308_11 = Mathf.Lerp(iter_308_2.color.r, arg_305_1.hightColor2.r, var_308_10)
								local var_308_12 = Mathf.Lerp(iter_308_2.color.g, arg_305_1.hightColor2.g, var_308_10)
								local var_308_13 = Mathf.Lerp(iter_308_2.color.b, arg_305_1.hightColor2.b, var_308_10)

								iter_308_2.color = Color.New(var_308_11, var_308_12, var_308_13)
							else
								local var_308_14 = Mathf.Lerp(iter_308_2.color.r, 0.5, var_308_10)

								iter_308_2.color = Color.New(var_308_14, var_308_14, var_308_14)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_8 + var_308_9 and arg_305_1.time_ < var_308_8 + var_308_9 + arg_308_0 and not isNil(var_308_7) and arg_305_1.var_.actorSpriteComps10063 then
				for iter_308_3, iter_308_4 in pairs(arg_305_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_308_4 then
						if arg_305_1.isInRecall_ then
							iter_308_4.color = arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_308_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps10063 = nil
			end

			local var_308_15 = arg_305_1.actors_["1060"].transform
			local var_308_16 = 0

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.var_.moveOldPos1060 = var_308_15.localPosition
				var_308_15.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1060", 7)

				local var_308_17 = var_308_15.childCount

				for iter_308_5 = 0, var_308_17 - 1 do
					local var_308_18 = var_308_15:GetChild(iter_308_5)

					if var_308_18.name == "" or not string.find(var_308_18.name, "split") then
						var_308_18.gameObject:SetActive(true)
					else
						var_308_18.gameObject:SetActive(false)
					end
				end
			end

			local var_308_19 = 0.001

			if var_308_16 <= arg_305_1.time_ and arg_305_1.time_ < var_308_16 + var_308_19 then
				local var_308_20 = (arg_305_1.time_ - var_308_16) / var_308_19
				local var_308_21 = Vector3.New(0, -2000, -40)

				var_308_15.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1060, var_308_21, var_308_20)
			end

			if arg_305_1.time_ >= var_308_16 + var_308_19 and arg_305_1.time_ < var_308_16 + var_308_19 + arg_308_0 then
				var_308_15.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_308_22 = 0
			local var_308_23 = 0.75

			if var_308_22 < arg_305_1.time_ and arg_305_1.time_ <= var_308_22 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_24 = arg_305_1:GetWordFromCfg(410122075)
				local var_308_25 = arg_305_1:FormatText(var_308_24.content)

				arg_305_1.text_.text = var_308_25

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_26 = 30
				local var_308_27 = utf8.len(var_308_25)
				local var_308_28 = var_308_26 <= 0 and var_308_23 or var_308_23 * (var_308_27 / var_308_26)

				if var_308_28 > 0 and var_308_23 < var_308_28 then
					arg_305_1.talkMaxDuration = var_308_28

					if var_308_28 + var_308_22 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_28 + var_308_22
					end
				end

				arg_305_1.text_.text = var_308_25
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_29 = math.max(var_308_23, arg_305_1.talkMaxDuration)

			if var_308_22 <= arg_305_1.time_ and arg_305_1.time_ < var_308_22 + var_308_29 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_22) / var_308_29

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_22 + var_308_29 and arg_305_1.time_ < var_308_22 + var_308_29 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play410122076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 410122076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play410122077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 1.725

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_2 = arg_309_1:GetWordFromCfg(410122076)
				local var_312_3 = arg_309_1:FormatText(var_312_2.content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 69
				local var_312_5 = utf8.len(var_312_3)
				local var_312_6 = var_312_4 <= 0 and var_312_1 or var_312_1 * (var_312_5 / var_312_4)

				if var_312_6 > 0 and var_312_1 < var_312_6 then
					arg_309_1.talkMaxDuration = var_312_6

					if var_312_6 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_7 and arg_309_1.time_ < var_312_0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play410122077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 410122077
		arg_313_1.duration_ = 6.27

		local var_313_0 = {
			zh = 6.266,
			ja = 4.833
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play410122078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.5

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[596].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10059")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:GetWordFromCfg(410122077)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 20
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122077", "story_v_out_410122.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122077", "story_v_out_410122.awb") / 1000

					if var_316_8 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_0
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_out_410122", "410122077", "story_v_out_410122.awb")

						arg_313_1:RecordAudio("410122077", var_316_9)
						arg_313_1:RecordAudio("410122077", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_410122", "410122077", "story_v_out_410122.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_410122", "410122077", "story_v_out_410122.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_10 and arg_313_1.time_ < var_316_0 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play410122078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 410122078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play410122079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 1.575

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(410122078)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 63
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play410122079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 410122079
		arg_321_1.duration_ = 3.7

		local var_321_0 = {
			zh = 1.9,
			ja = 3.7
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play410122080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1060"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1060 = var_324_0.localPosition
				var_324_0.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("1060", 3)

				local var_324_2 = var_324_0.childCount

				for iter_324_0 = 0, var_324_2 - 1 do
					local var_324_3 = var_324_0:GetChild(iter_324_0)

					if var_324_3.name == "" or not string.find(var_324_3.name, "split") then
						var_324_3.gameObject:SetActive(true)
					else
						var_324_3.gameObject:SetActive(false)
					end
				end
			end

			local var_324_4 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_4 then
				local var_324_5 = (arg_321_1.time_ - var_324_1) / var_324_4
				local var_324_6 = Vector3.New(33.4, -430.8, 6.9)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1060, var_324_6, var_324_5)
			end

			if arg_321_1.time_ >= var_324_1 + var_324_4 and arg_321_1.time_ < var_324_1 + var_324_4 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_324_7 = arg_321_1.actors_["1060"]
			local var_324_8 = 0

			if var_324_8 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 and not isNil(var_324_7) and arg_321_1.var_.actorSpriteComps1060 == nil then
				arg_321_1.var_.actorSpriteComps1060 = var_324_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_9 = 0.034

			if var_324_8 <= arg_321_1.time_ and arg_321_1.time_ < var_324_8 + var_324_9 and not isNil(var_324_7) then
				local var_324_10 = (arg_321_1.time_ - var_324_8) / var_324_9

				if arg_321_1.var_.actorSpriteComps1060 then
					for iter_324_1, iter_324_2 in pairs(arg_321_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_324_2 then
							if arg_321_1.isInRecall_ then
								local var_324_11 = Mathf.Lerp(iter_324_2.color.r, arg_321_1.hightColor1.r, var_324_10)
								local var_324_12 = Mathf.Lerp(iter_324_2.color.g, arg_321_1.hightColor1.g, var_324_10)
								local var_324_13 = Mathf.Lerp(iter_324_2.color.b, arg_321_1.hightColor1.b, var_324_10)

								iter_324_2.color = Color.New(var_324_11, var_324_12, var_324_13)
							else
								local var_324_14 = Mathf.Lerp(iter_324_2.color.r, 1, var_324_10)

								iter_324_2.color = Color.New(var_324_14, var_324_14, var_324_14)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_8 + var_324_9 and arg_321_1.time_ < var_324_8 + var_324_9 + arg_324_0 and not isNil(var_324_7) and arg_321_1.var_.actorSpriteComps1060 then
				for iter_324_3, iter_324_4 in pairs(arg_321_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_324_4 then
						if arg_321_1.isInRecall_ then
							iter_324_4.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_324_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps1060 = nil
			end

			local var_324_15 = 0
			local var_324_16 = 0.25

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_17 = arg_321_1:FormatText(StoryNameCfg[584].name)

				arg_321_1.leftNameTxt_.text = var_324_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_18 = arg_321_1:GetWordFromCfg(410122079)
				local var_324_19 = arg_321_1:FormatText(var_324_18.content)

				arg_321_1.text_.text = var_324_19

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_20 = 10
				local var_324_21 = utf8.len(var_324_19)
				local var_324_22 = var_324_20 <= 0 and var_324_16 or var_324_16 * (var_324_21 / var_324_20)

				if var_324_22 > 0 and var_324_16 < var_324_22 then
					arg_321_1.talkMaxDuration = var_324_22

					if var_324_22 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_22 + var_324_15
					end
				end

				arg_321_1.text_.text = var_324_19
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122079", "story_v_out_410122.awb") ~= 0 then
					local var_324_23 = manager.audio:GetVoiceLength("story_v_out_410122", "410122079", "story_v_out_410122.awb") / 1000

					if var_324_23 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_15
					end

					if var_324_18.prefab_name ~= "" and arg_321_1.actors_[var_324_18.prefab_name] ~= nil then
						local var_324_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_18.prefab_name].transform, "story_v_out_410122", "410122079", "story_v_out_410122.awb")

						arg_321_1:RecordAudio("410122079", var_324_24)
						arg_321_1:RecordAudio("410122079", var_324_24)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_410122", "410122079", "story_v_out_410122.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_410122", "410122079", "story_v_out_410122.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_25 = math.max(var_324_16, arg_321_1.talkMaxDuration)

			if var_324_15 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_25 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_15) / var_324_25

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_15 + var_324_25 and arg_321_1.time_ < var_324_15 + var_324_25 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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

		arg_321_1:InitPlayNodeList()
	end,
	Play410122080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 410122080
		arg_325_1.duration_ = 8

		local var_325_0 = {
			zh = 7.833,
			ja = 8
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play410122081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.975

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[584].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_3 = arg_325_1:GetWordFromCfg(410122080)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 39
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122080", "story_v_out_410122.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_410122", "410122080", "story_v_out_410122.awb") / 1000

					if var_328_8 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_0
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_out_410122", "410122080", "story_v_out_410122.awb")

						arg_325_1:RecordAudio("410122080", var_328_9)
						arg_325_1:RecordAudio("410122080", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_410122", "410122080", "story_v_out_410122.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_410122", "410122080", "story_v_out_410122.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_10 and arg_325_1.time_ < var_328_0 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play410122081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 410122081
		arg_329_1.duration_ = 6.7

		local var_329_0 = {
			zh = 3.133,
			ja = 6.7
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play410122082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1060"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos1060 = var_332_0.localPosition
				var_332_0.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1060", 4)

				local var_332_2 = var_332_0.childCount

				for iter_332_0 = 0, var_332_2 - 1 do
					local var_332_3 = var_332_0:GetChild(iter_332_0)

					if var_332_3.name == "split_1" or not string.find(var_332_3.name, "split") then
						var_332_3.gameObject:SetActive(true)
					else
						var_332_3.gameObject:SetActive(false)
					end
				end
			end

			local var_332_4 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_4 then
				local var_332_5 = (arg_329_1.time_ - var_332_1) / var_332_4
				local var_332_6 = Vector3.New(420.9, -430.8, 6.9)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1060, var_332_6, var_332_5)
			end

			if arg_329_1.time_ >= var_332_1 + var_332_4 and arg_329_1.time_ < var_332_1 + var_332_4 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_332_7 = arg_329_1.actors_["1056"].transform
			local var_332_8 = 0

			if var_332_8 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.var_.moveOldPos1056 = var_332_7.localPosition
				var_332_7.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1056", 2)

				local var_332_9 = var_332_7.childCount

				for iter_332_1 = 0, var_332_9 - 1 do
					local var_332_10 = var_332_7:GetChild(iter_332_1)

					if var_332_10.name == "split_1" or not string.find(var_332_10.name, "split") then
						var_332_10.gameObject:SetActive(true)
					else
						var_332_10.gameObject:SetActive(false)
					end
				end
			end

			local var_332_11 = 0.001

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_11 then
				local var_332_12 = (arg_329_1.time_ - var_332_8) / var_332_11
				local var_332_13 = Vector3.New(-390, -350, -180)

				var_332_7.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1056, var_332_13, var_332_12)
			end

			if arg_329_1.time_ >= var_332_8 + var_332_11 and arg_329_1.time_ < var_332_8 + var_332_11 + arg_332_0 then
				var_332_7.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_332_14 = arg_329_1.actors_["1060"]
			local var_332_15 = 0

			if var_332_15 < arg_329_1.time_ and arg_329_1.time_ <= var_332_15 + arg_332_0 and not isNil(var_332_14) and arg_329_1.var_.actorSpriteComps1060 == nil then
				arg_329_1.var_.actorSpriteComps1060 = var_332_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_16 = 0.034

			if var_332_15 <= arg_329_1.time_ and arg_329_1.time_ < var_332_15 + var_332_16 and not isNil(var_332_14) then
				local var_332_17 = (arg_329_1.time_ - var_332_15) / var_332_16

				if arg_329_1.var_.actorSpriteComps1060 then
					for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_332_3 then
							if arg_329_1.isInRecall_ then
								local var_332_18 = Mathf.Lerp(iter_332_3.color.r, arg_329_1.hightColor2.r, var_332_17)
								local var_332_19 = Mathf.Lerp(iter_332_3.color.g, arg_329_1.hightColor2.g, var_332_17)
								local var_332_20 = Mathf.Lerp(iter_332_3.color.b, arg_329_1.hightColor2.b, var_332_17)

								iter_332_3.color = Color.New(var_332_18, var_332_19, var_332_20)
							else
								local var_332_21 = Mathf.Lerp(iter_332_3.color.r, 0.5, var_332_17)

								iter_332_3.color = Color.New(var_332_21, var_332_21, var_332_21)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_15 + var_332_16 and arg_329_1.time_ < var_332_15 + var_332_16 + arg_332_0 and not isNil(var_332_14) and arg_329_1.var_.actorSpriteComps1060 then
				for iter_332_4, iter_332_5 in pairs(arg_329_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_332_5 then
						if arg_329_1.isInRecall_ then
							iter_332_5.color = arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_332_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps1060 = nil
			end

			local var_332_22 = arg_329_1.actors_["1056"]
			local var_332_23 = 0

			if var_332_23 < arg_329_1.time_ and arg_329_1.time_ <= var_332_23 + arg_332_0 and not isNil(var_332_22) and arg_329_1.var_.actorSpriteComps1056 == nil then
				arg_329_1.var_.actorSpriteComps1056 = var_332_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_24 = 0.034

			if var_332_23 <= arg_329_1.time_ and arg_329_1.time_ < var_332_23 + var_332_24 and not isNil(var_332_22) then
				local var_332_25 = (arg_329_1.time_ - var_332_23) / var_332_24

				if arg_329_1.var_.actorSpriteComps1056 then
					for iter_332_6, iter_332_7 in pairs(arg_329_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_332_7 then
							if arg_329_1.isInRecall_ then
								local var_332_26 = Mathf.Lerp(iter_332_7.color.r, arg_329_1.hightColor1.r, var_332_25)
								local var_332_27 = Mathf.Lerp(iter_332_7.color.g, arg_329_1.hightColor1.g, var_332_25)
								local var_332_28 = Mathf.Lerp(iter_332_7.color.b, arg_329_1.hightColor1.b, var_332_25)

								iter_332_7.color = Color.New(var_332_26, var_332_27, var_332_28)
							else
								local var_332_29 = Mathf.Lerp(iter_332_7.color.r, 1, var_332_25)

								iter_332_7.color = Color.New(var_332_29, var_332_29, var_332_29)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_23 + var_332_24 and arg_329_1.time_ < var_332_23 + var_332_24 + arg_332_0 and not isNil(var_332_22) and arg_329_1.var_.actorSpriteComps1056 then
				for iter_332_8, iter_332_9 in pairs(arg_329_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_332_9 then
						if arg_329_1.isInRecall_ then
							iter_332_9.color = arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_332_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps1056 = nil
			end

			local var_332_30 = 0
			local var_332_31 = 0.4

			if var_332_30 < arg_329_1.time_ and arg_329_1.time_ <= var_332_30 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_32 = arg_329_1:FormatText(StoryNameCfg[605].name)

				arg_329_1.leftNameTxt_.text = var_332_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_33 = arg_329_1:GetWordFromCfg(410122081)
				local var_332_34 = arg_329_1:FormatText(var_332_33.content)

				arg_329_1.text_.text = var_332_34

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_35 = 16
				local var_332_36 = utf8.len(var_332_34)
				local var_332_37 = var_332_35 <= 0 and var_332_31 or var_332_31 * (var_332_36 / var_332_35)

				if var_332_37 > 0 and var_332_31 < var_332_37 then
					arg_329_1.talkMaxDuration = var_332_37

					if var_332_37 + var_332_30 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_37 + var_332_30
					end
				end

				arg_329_1.text_.text = var_332_34
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122081", "story_v_out_410122.awb") ~= 0 then
					local var_332_38 = manager.audio:GetVoiceLength("story_v_out_410122", "410122081", "story_v_out_410122.awb") / 1000

					if var_332_38 + var_332_30 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_38 + var_332_30
					end

					if var_332_33.prefab_name ~= "" and arg_329_1.actors_[var_332_33.prefab_name] ~= nil then
						local var_332_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_33.prefab_name].transform, "story_v_out_410122", "410122081", "story_v_out_410122.awb")

						arg_329_1:RecordAudio("410122081", var_332_39)
						arg_329_1:RecordAudio("410122081", var_332_39)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_410122", "410122081", "story_v_out_410122.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_410122", "410122081", "story_v_out_410122.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_40 = math.max(var_332_31, arg_329_1.talkMaxDuration)

			if var_332_30 <= arg_329_1.time_ and arg_329_1.time_ < var_332_30 + var_332_40 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_30) / var_332_40

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_30 + var_332_40 and arg_329_1.time_ < var_332_30 + var_332_40 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play410122082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 410122082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play410122083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1060"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos1060 = var_336_0.localPosition
				var_336_0.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1060", 7)

				local var_336_2 = var_336_0.childCount

				for iter_336_0 = 0, var_336_2 - 1 do
					local var_336_3 = var_336_0:GetChild(iter_336_0)

					if var_336_3.name == "" or not string.find(var_336_3.name, "split") then
						var_336_3.gameObject:SetActive(true)
					else
						var_336_3.gameObject:SetActive(false)
					end
				end
			end

			local var_336_4 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_4 then
				local var_336_5 = (arg_333_1.time_ - var_336_1) / var_336_4
				local var_336_6 = Vector3.New(0, -2000, -40)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1060, var_336_6, var_336_5)
			end

			if arg_333_1.time_ >= var_336_1 + var_336_4 and arg_333_1.time_ < var_336_1 + var_336_4 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_336_7 = arg_333_1.actors_["1056"].transform
			local var_336_8 = 0

			if var_336_8 < arg_333_1.time_ and arg_333_1.time_ <= var_336_8 + arg_336_0 then
				arg_333_1.var_.moveOldPos1056 = var_336_7.localPosition
				var_336_7.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1056", 7)

				local var_336_9 = var_336_7.childCount

				for iter_336_1 = 0, var_336_9 - 1 do
					local var_336_10 = var_336_7:GetChild(iter_336_1)

					if var_336_10.name == "" or not string.find(var_336_10.name, "split") then
						var_336_10.gameObject:SetActive(true)
					else
						var_336_10.gameObject:SetActive(false)
					end
				end
			end

			local var_336_11 = 0.001

			if var_336_8 <= arg_333_1.time_ and arg_333_1.time_ < var_336_8 + var_336_11 then
				local var_336_12 = (arg_333_1.time_ - var_336_8) / var_336_11
				local var_336_13 = Vector3.New(0, -2000, -180)

				var_336_7.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1056, var_336_13, var_336_12)
			end

			if arg_333_1.time_ >= var_336_8 + var_336_11 and arg_333_1.time_ < var_336_8 + var_336_11 + arg_336_0 then
				var_336_7.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_336_14 = arg_333_1.actors_["1060"]
			local var_336_15 = 0

			if var_336_15 < arg_333_1.time_ and arg_333_1.time_ <= var_336_15 + arg_336_0 and not isNil(var_336_14) and arg_333_1.var_.actorSpriteComps1060 == nil then
				arg_333_1.var_.actorSpriteComps1060 = var_336_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_16 = 0.034

			if var_336_15 <= arg_333_1.time_ and arg_333_1.time_ < var_336_15 + var_336_16 and not isNil(var_336_14) then
				local var_336_17 = (arg_333_1.time_ - var_336_15) / var_336_16

				if arg_333_1.var_.actorSpriteComps1060 then
					for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_336_3 then
							if arg_333_1.isInRecall_ then
								local var_336_18 = Mathf.Lerp(iter_336_3.color.r, arg_333_1.hightColor2.r, var_336_17)
								local var_336_19 = Mathf.Lerp(iter_336_3.color.g, arg_333_1.hightColor2.g, var_336_17)
								local var_336_20 = Mathf.Lerp(iter_336_3.color.b, arg_333_1.hightColor2.b, var_336_17)

								iter_336_3.color = Color.New(var_336_18, var_336_19, var_336_20)
							else
								local var_336_21 = Mathf.Lerp(iter_336_3.color.r, 0.5, var_336_17)

								iter_336_3.color = Color.New(var_336_21, var_336_21, var_336_21)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_15 + var_336_16 and arg_333_1.time_ < var_336_15 + var_336_16 + arg_336_0 and not isNil(var_336_14) and arg_333_1.var_.actorSpriteComps1060 then
				for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_336_5 then
						if arg_333_1.isInRecall_ then
							iter_336_5.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps1060 = nil
			end

			local var_336_22 = arg_333_1.actors_["1056"]
			local var_336_23 = 0

			if var_336_23 < arg_333_1.time_ and arg_333_1.time_ <= var_336_23 + arg_336_0 and not isNil(var_336_22) and arg_333_1.var_.actorSpriteComps1056 == nil then
				arg_333_1.var_.actorSpriteComps1056 = var_336_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_24 = 0.034

			if var_336_23 <= arg_333_1.time_ and arg_333_1.time_ < var_336_23 + var_336_24 and not isNil(var_336_22) then
				local var_336_25 = (arg_333_1.time_ - var_336_23) / var_336_24

				if arg_333_1.var_.actorSpriteComps1056 then
					for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_336_7 then
							if arg_333_1.isInRecall_ then
								local var_336_26 = Mathf.Lerp(iter_336_7.color.r, arg_333_1.hightColor2.r, var_336_25)
								local var_336_27 = Mathf.Lerp(iter_336_7.color.g, arg_333_1.hightColor2.g, var_336_25)
								local var_336_28 = Mathf.Lerp(iter_336_7.color.b, arg_333_1.hightColor2.b, var_336_25)

								iter_336_7.color = Color.New(var_336_26, var_336_27, var_336_28)
							else
								local var_336_29 = Mathf.Lerp(iter_336_7.color.r, 0.5, var_336_25)

								iter_336_7.color = Color.New(var_336_29, var_336_29, var_336_29)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_23 + var_336_24 and arg_333_1.time_ < var_336_23 + var_336_24 + arg_336_0 and not isNil(var_336_22) and arg_333_1.var_.actorSpriteComps1056 then
				for iter_336_8, iter_336_9 in pairs(arg_333_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_336_9 then
						if arg_333_1.isInRecall_ then
							iter_336_9.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps1056 = nil
			end

			local var_336_30 = 0
			local var_336_31 = 0.625

			if var_336_30 < arg_333_1.time_ and arg_333_1.time_ <= var_336_30 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_32 = arg_333_1:GetWordFromCfg(410122082)
				local var_336_33 = arg_333_1:FormatText(var_336_32.content)

				arg_333_1.text_.text = var_336_33

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_34 = 25
				local var_336_35 = utf8.len(var_336_33)
				local var_336_36 = var_336_34 <= 0 and var_336_31 or var_336_31 * (var_336_35 / var_336_34)

				if var_336_36 > 0 and var_336_31 < var_336_36 then
					arg_333_1.talkMaxDuration = var_336_36

					if var_336_36 + var_336_30 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_36 + var_336_30
					end
				end

				arg_333_1.text_.text = var_336_33
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_37 = math.max(var_336_31, arg_333_1.talkMaxDuration)

			if var_336_30 <= arg_333_1.time_ and arg_333_1.time_ < var_336_30 + var_336_37 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_30) / var_336_37

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_30 + var_336_37 and arg_333_1.time_ < var_336_30 + var_336_37 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play410122083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 410122083
		arg_337_1.duration_ = 11.6

		local var_337_0 = {
			zh = 7.433,
			ja = 11.6
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
			arg_337_1.auto_ = false
		end

		function arg_337_1.playNext_(arg_339_0)
			arg_337_1.onStoryFinished_()
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1060"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos1060 = var_340_0.localPosition
				var_340_0.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("1060", 3)

				local var_340_2 = var_340_0.childCount

				for iter_340_0 = 0, var_340_2 - 1 do
					local var_340_3 = var_340_0:GetChild(iter_340_0)

					if var_340_3.name == "" or not string.find(var_340_3.name, "split") then
						var_340_3.gameObject:SetActive(true)
					else
						var_340_3.gameObject:SetActive(false)
					end
				end
			end

			local var_340_4 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_4 then
				local var_340_5 = (arg_337_1.time_ - var_340_1) / var_340_4
				local var_340_6 = Vector3.New(33.4, -430.8, 6.9)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1060, var_340_6, var_340_5)
			end

			if arg_337_1.time_ >= var_340_1 + var_340_4 and arg_337_1.time_ < var_340_1 + var_340_4 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_340_7 = arg_337_1.actors_["1060"]
			local var_340_8 = 0

			if var_340_8 < arg_337_1.time_ and arg_337_1.time_ <= var_340_8 + arg_340_0 and not isNil(var_340_7) and arg_337_1.var_.actorSpriteComps1060 == nil then
				arg_337_1.var_.actorSpriteComps1060 = var_340_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_9 = 0.034

			if var_340_8 <= arg_337_1.time_ and arg_337_1.time_ < var_340_8 + var_340_9 and not isNil(var_340_7) then
				local var_340_10 = (arg_337_1.time_ - var_340_8) / var_340_9

				if arg_337_1.var_.actorSpriteComps1060 then
					for iter_340_1, iter_340_2 in pairs(arg_337_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_340_2 then
							if arg_337_1.isInRecall_ then
								local var_340_11 = Mathf.Lerp(iter_340_2.color.r, arg_337_1.hightColor1.r, var_340_10)
								local var_340_12 = Mathf.Lerp(iter_340_2.color.g, arg_337_1.hightColor1.g, var_340_10)
								local var_340_13 = Mathf.Lerp(iter_340_2.color.b, arg_337_1.hightColor1.b, var_340_10)

								iter_340_2.color = Color.New(var_340_11, var_340_12, var_340_13)
							else
								local var_340_14 = Mathf.Lerp(iter_340_2.color.r, 1, var_340_10)

								iter_340_2.color = Color.New(var_340_14, var_340_14, var_340_14)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_8 + var_340_9 and arg_337_1.time_ < var_340_8 + var_340_9 + arg_340_0 and not isNil(var_340_7) and arg_337_1.var_.actorSpriteComps1060 then
				for iter_340_3, iter_340_4 in pairs(arg_337_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_340_4 then
						if arg_337_1.isInRecall_ then
							iter_340_4.color = arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_340_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps1060 = nil
			end

			local var_340_15 = 0
			local var_340_16 = 0.725

			if var_340_15 < arg_337_1.time_ and arg_337_1.time_ <= var_340_15 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_17 = arg_337_1:FormatText(StoryNameCfg[584].name)

				arg_337_1.leftNameTxt_.text = var_340_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_18 = arg_337_1:GetWordFromCfg(410122083)
				local var_340_19 = arg_337_1:FormatText(var_340_18.content)

				arg_337_1.text_.text = var_340_19

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_20 = 29
				local var_340_21 = utf8.len(var_340_19)
				local var_340_22 = var_340_20 <= 0 and var_340_16 or var_340_16 * (var_340_21 / var_340_20)

				if var_340_22 > 0 and var_340_16 < var_340_22 then
					arg_337_1.talkMaxDuration = var_340_22

					if var_340_22 + var_340_15 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_22 + var_340_15
					end
				end

				arg_337_1.text_.text = var_340_19
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410122", "410122083", "story_v_out_410122.awb") ~= 0 then
					local var_340_23 = manager.audio:GetVoiceLength("story_v_out_410122", "410122083", "story_v_out_410122.awb") / 1000

					if var_340_23 + var_340_15 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_23 + var_340_15
					end

					if var_340_18.prefab_name ~= "" and arg_337_1.actors_[var_340_18.prefab_name] ~= nil then
						local var_340_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_18.prefab_name].transform, "story_v_out_410122", "410122083", "story_v_out_410122.awb")

						arg_337_1:RecordAudio("410122083", var_340_24)
						arg_337_1:RecordAudio("410122083", var_340_24)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_410122", "410122083", "story_v_out_410122.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_410122", "410122083", "story_v_out_410122.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_25 = math.max(var_340_16, arg_337_1.talkMaxDuration)

			if var_340_15 <= arg_337_1.time_ and arg_337_1.time_ < var_340_15 + var_340_25 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_15) / var_340_25

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_15 + var_340_25 and arg_337_1.time_ < var_340_15 + var_340_25 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
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

		arg_337_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST62a",
		"TextureConfig/Background/LZ0107",
		"TextureConfig/Background/L04g"
	},
	voices = {
		"story_v_out_410122.awb"
	}
}
