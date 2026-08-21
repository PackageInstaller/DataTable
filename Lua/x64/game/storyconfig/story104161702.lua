return {
	Play416172001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416172001
		arg_1_1.duration_ = 4.5

		local var_1_0 = {
			zh = 4.099999999999,
			ja = 4.499999999999
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
				arg_1_0:Play416172002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I13i"

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
				local var_4_5 = arg_1_1.bgs_.I13i

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
					if iter_4_0 ~= "I13i" then
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

			local var_4_24 = 0
			local var_4_25 = 0.2

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_30 = 0.466666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 1.999999999999
			local var_4_37 = 0.225

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[8].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10122_split_1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(416172001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 9
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172001", "story_v_out_416172.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_416172", "416172001", "story_v_out_416172.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_416172", "416172001", "story_v_out_416172.awb")

						arg_1_1:RecordAudio("416172001", var_4_46)
						arg_1_1:RecordAudio("416172001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416172", "416172001", "story_v_out_416172.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416172", "416172001", "story_v_out_416172.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play416172002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416172002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416172003(arg_9_1)
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

				local var_12_2 = arg_9_1:GetWordFromCfg(416172002)
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
	Play416172003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416172003
		arg_13_1.duration_ = 3.7

		local var_13_0 = {
			zh = 3.266,
			ja = 3.7
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
				arg_13_0:Play416172004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10122"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10122")

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

			local var_16_4 = arg_13_1.actors_["10122"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps10122 == nil then
				arg_13_1.var_.actorSpriteComps10122 = var_16_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.2

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.actorSpriteComps10122 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								local var_16_8 = Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor1.r, var_16_7)
								local var_16_9 = Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor1.g, var_16_7)
								local var_16_10 = Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor1.b, var_16_7)

								iter_16_3.color = Color.New(var_16_8, var_16_9, var_16_10)
							else
								local var_16_11 = Mathf.Lerp(iter_16_3.color.r, 1, var_16_7)

								iter_16_3.color = Color.New(var_16_11, var_16_11, var_16_11)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps10122 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_16_5 then
						if arg_13_1.isInRecall_ then
							iter_16_5.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10122 = nil
			end

			local var_16_12 = arg_13_1.actors_["10122"].transform
			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1.var_.moveOldPos10122 = var_16_12.localPosition
				var_16_12.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10122", 2)

				local var_16_14 = var_16_12.childCount

				for iter_16_6 = 0, var_16_14 - 1 do
					local var_16_15 = var_16_12:GetChild(iter_16_6)

					if var_16_15.name == "" or not string.find(var_16_15.name, "split") then
						var_16_15.gameObject:SetActive(true)
					else
						var_16_15.gameObject:SetActive(false)
					end
				end
			end

			local var_16_16 = 0.001

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_16 then
				local var_16_17 = (arg_13_1.time_ - var_16_13) / var_16_16
				local var_16_18 = Vector3.New(-390, -380, -100)

				var_16_12.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10122, var_16_18, var_16_17)
			end

			if arg_13_1.time_ >= var_16_13 + var_16_16 and arg_13_1.time_ < var_16_13 + var_16_16 + arg_16_0 then
				var_16_12.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_16_19 = 0
			local var_16_20 = 0.3

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_21 = arg_13_1:FormatText(StoryNameCfg[8].name)

				arg_13_1.leftNameTxt_.text = var_16_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_22 = arg_13_1:GetWordFromCfg(416172003)
				local var_16_23 = arg_13_1:FormatText(var_16_22.content)

				arg_13_1.text_.text = var_16_23

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_24 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172003", "story_v_out_416172.awb") ~= 0 then
					local var_16_27 = manager.audio:GetVoiceLength("story_v_out_416172", "416172003", "story_v_out_416172.awb") / 1000

					if var_16_27 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_19
					end

					if var_16_22.prefab_name ~= "" and arg_13_1.actors_[var_16_22.prefab_name] ~= nil then
						local var_16_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_22.prefab_name].transform, "story_v_out_416172", "416172003", "story_v_out_416172.awb")

						arg_13_1:RecordAudio("416172003", var_16_28)
						arg_13_1:RecordAudio("416172003", var_16_28)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416172", "416172003", "story_v_out_416172.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416172", "416172003", "story_v_out_416172.awb")
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
				actorName = "10122",
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
	Play416172004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416172004
		arg_17_1.duration_ = 8.23

		local var_17_0 = {
			zh = 3.8,
			ja = 8.233
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
				arg_17_0:Play416172005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "10127"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

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

			local var_20_4 = arg_17_1.actors_["10127"]
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps10127 == nil then
				arg_17_1.var_.actorSpriteComps10127 = var_20_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.2

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 and not isNil(var_20_4) then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6

				if arg_17_1.var_.actorSpriteComps10127 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								local var_20_8 = Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, var_20_7)
								local var_20_9 = Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, var_20_7)
								local var_20_10 = Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, var_20_7)

								iter_20_3.color = Color.New(var_20_8, var_20_9, var_20_10)
							else
								local var_20_11 = Mathf.Lerp(iter_20_3.color.r, 1, var_20_7)

								iter_20_3.color = Color.New(var_20_11, var_20_11, var_20_11)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps10127 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_20_5 then
						if arg_17_1.isInRecall_ then
							iter_20_5.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10127 = nil
			end

			local var_20_12 = arg_17_1.actors_["10122"]
			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 and not isNil(var_20_12) and arg_17_1.var_.actorSpriteComps10122 == nil then
				arg_17_1.var_.actorSpriteComps10122 = var_20_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_14 = 0.2

			if var_20_13 <= arg_17_1.time_ and arg_17_1.time_ < var_20_13 + var_20_14 and not isNil(var_20_12) then
				local var_20_15 = (arg_17_1.time_ - var_20_13) / var_20_14

				if arg_17_1.var_.actorSpriteComps10122 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								local var_20_16 = Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor2.r, var_20_15)
								local var_20_17 = Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor2.g, var_20_15)
								local var_20_18 = Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor2.b, var_20_15)

								iter_20_7.color = Color.New(var_20_16, var_20_17, var_20_18)
							else
								local var_20_19 = Mathf.Lerp(iter_20_7.color.r, 0.5, var_20_15)

								iter_20_7.color = Color.New(var_20_19, var_20_19, var_20_19)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_13 + var_20_14 and arg_17_1.time_ < var_20_13 + var_20_14 + arg_20_0 and not isNil(var_20_12) and arg_17_1.var_.actorSpriteComps10122 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_20_9 then
						if arg_17_1.isInRecall_ then
							iter_20_9.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10122 = nil
			end

			local var_20_20 = arg_17_1.actors_["10127"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos10127 = var_20_20.localPosition
				var_20_20.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10127", 4)

				local var_20_22 = var_20_20.childCount

				for iter_20_10 = 0, var_20_22 - 1 do
					local var_20_23 = var_20_20:GetChild(iter_20_10)

					if var_20_23.name == "" or not string.find(var_20_23.name, "split") then
						var_20_23.gameObject:SetActive(true)
					else
						var_20_23.gameObject:SetActive(false)
					end
				end
			end

			local var_20_24 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_24 then
				local var_20_25 = (arg_17_1.time_ - var_20_21) / var_20_24
				local var_20_26 = Vector3.New(345, -387.4, -316.5)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10127, var_20_26, var_20_25)
			end

			if arg_17_1.time_ >= var_20_21 + var_20_24 and arg_17_1.time_ < var_20_21 + var_20_24 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_20_27 = 0
			local var_20_28 = 0.55

			if var_20_27 < arg_17_1.time_ and arg_17_1.time_ <= var_20_27 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_29 = arg_17_1:FormatText(StoryNameCfg[236].name)

				arg_17_1.leftNameTxt_.text = var_20_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_30 = arg_17_1:GetWordFromCfg(416172004)
				local var_20_31 = arg_17_1:FormatText(var_20_30.content)

				arg_17_1.text_.text = var_20_31

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_32 = 22
				local var_20_33 = utf8.len(var_20_31)
				local var_20_34 = var_20_32 <= 0 and var_20_28 or var_20_28 * (var_20_33 / var_20_32)

				if var_20_34 > 0 and var_20_28 < var_20_34 then
					arg_17_1.talkMaxDuration = var_20_34

					if var_20_34 + var_20_27 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_34 + var_20_27
					end
				end

				arg_17_1.text_.text = var_20_31
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172004", "story_v_out_416172.awb") ~= 0 then
					local var_20_35 = manager.audio:GetVoiceLength("story_v_out_416172", "416172004", "story_v_out_416172.awb") / 1000

					if var_20_35 + var_20_27 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_35 + var_20_27
					end

					if var_20_30.prefab_name ~= "" and arg_17_1.actors_[var_20_30.prefab_name] ~= nil then
						local var_20_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_30.prefab_name].transform, "story_v_out_416172", "416172004", "story_v_out_416172.awb")

						arg_17_1:RecordAudio("416172004", var_20_36)
						arg_17_1:RecordAudio("416172004", var_20_36)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416172", "416172004", "story_v_out_416172.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416172", "416172004", "story_v_out_416172.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_37 = math.max(var_20_28, arg_17_1.talkMaxDuration)

			if var_20_27 <= arg_17_1.time_ and arg_17_1.time_ < var_20_27 + var_20_37 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_27) / var_20_37

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_27 + var_20_37 and arg_17_1.time_ < var_20_27 + var_20_37 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play416172005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416172005
		arg_21_1.duration_ = 7.83

		local var_21_0 = {
			zh = 5.733,
			ja = 7.833
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
				arg_21_0:Play416172006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10122"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10122 == nil then
				arg_21_1.var_.actorSpriteComps10122 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10122 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 1, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10122 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10122 = nil
			end

			local var_24_8 = arg_21_1.actors_["10127"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10127 == nil then
				arg_21_1.var_.actorSpriteComps10127 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.2

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps10127 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								local var_24_12 = Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, var_24_11)
								local var_24_13 = Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, var_24_11)
								local var_24_14 = Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, var_24_11)

								iter_24_5.color = Color.New(var_24_12, var_24_13, var_24_14)
							else
								local var_24_15 = Mathf.Lerp(iter_24_5.color.r, 0.5, var_24_11)

								iter_24_5.color = Color.New(var_24_15, var_24_15, var_24_15)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10127 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10127 = nil
			end

			local var_24_16 = 0
			local var_24_17 = 0.525

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_18 = arg_21_1:FormatText(StoryNameCfg[8].name)

				arg_21_1.leftNameTxt_.text = var_24_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:GetWordFromCfg(416172005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172005", "story_v_out_416172.awb") ~= 0 then
					local var_24_24 = manager.audio:GetVoiceLength("story_v_out_416172", "416172005", "story_v_out_416172.awb") / 1000

					if var_24_24 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_16
					end

					if var_24_19.prefab_name ~= "" and arg_21_1.actors_[var_24_19.prefab_name] ~= nil then
						local var_24_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_19.prefab_name].transform, "story_v_out_416172", "416172005", "story_v_out_416172.awb")

						arg_21_1:RecordAudio("416172005", var_24_25)
						arg_21_1:RecordAudio("416172005", var_24_25)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416172", "416172005", "story_v_out_416172.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416172", "416172005", "story_v_out_416172.awb")
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
	Play416172006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416172006
		arg_25_1.duration_ = 13.33

		local var_25_0 = {
			zh = 4.233,
			ja = 13.333
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
				arg_25_0:Play416172007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10127"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10127 == nil then
				arg_25_1.var_.actorSpriteComps10127 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps10127 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10127 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10127 = nil
			end

			local var_28_8 = arg_25_1.actors_["10122"]
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10122 == nil then
				arg_25_1.var_.actorSpriteComps10122 = var_28_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_10 = 0.2

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 and not isNil(var_28_8) then
				local var_28_11 = (arg_25_1.time_ - var_28_9) / var_28_10

				if arg_25_1.var_.actorSpriteComps10122 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								local var_28_12 = Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor2.r, var_28_11)
								local var_28_13 = Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor2.g, var_28_11)
								local var_28_14 = Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor2.b, var_28_11)

								iter_28_5.color = Color.New(var_28_12, var_28_13, var_28_14)
							else
								local var_28_15 = Mathf.Lerp(iter_28_5.color.r, 0.5, var_28_11)

								iter_28_5.color = Color.New(var_28_15, var_28_15, var_28_15)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10122 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_28_7 then
						if arg_25_1.isInRecall_ then
							iter_28_7.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10122 = nil
			end

			local var_28_16 = 0
			local var_28_17 = 0.575

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_18 = arg_25_1:FormatText(StoryNameCfg[236].name)

				arg_25_1.leftNameTxt_.text = var_28_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_19 = arg_25_1:GetWordFromCfg(416172006)
				local var_28_20 = arg_25_1:FormatText(var_28_19.content)

				arg_25_1.text_.text = var_28_20

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_21 = 23
				local var_28_22 = utf8.len(var_28_20)
				local var_28_23 = var_28_21 <= 0 and var_28_17 or var_28_17 * (var_28_22 / var_28_21)

				if var_28_23 > 0 and var_28_17 < var_28_23 then
					arg_25_1.talkMaxDuration = var_28_23

					if var_28_23 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_16
					end
				end

				arg_25_1.text_.text = var_28_20
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172006", "story_v_out_416172.awb") ~= 0 then
					local var_28_24 = manager.audio:GetVoiceLength("story_v_out_416172", "416172006", "story_v_out_416172.awb") / 1000

					if var_28_24 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_24 + var_28_16
					end

					if var_28_19.prefab_name ~= "" and arg_25_1.actors_[var_28_19.prefab_name] ~= nil then
						local var_28_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_19.prefab_name].transform, "story_v_out_416172", "416172006", "story_v_out_416172.awb")

						arg_25_1:RecordAudio("416172006", var_28_25)
						arg_25_1:RecordAudio("416172006", var_28_25)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416172", "416172006", "story_v_out_416172.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416172", "416172006", "story_v_out_416172.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_26 = math.max(var_28_17, arg_25_1.talkMaxDuration)

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_26 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_16) / var_28_26

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_16 + var_28_26 and arg_25_1.time_ < var_28_16 + var_28_26 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play416172007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416172007
		arg_29_1.duration_ = 6.63

		local var_29_0 = {
			zh = 4.933,
			ja = 6.633
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
				arg_29_0:Play416172008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10122"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10122 == nil then
				arg_29_1.var_.actorSpriteComps10122 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10122 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10122 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10122 = nil
			end

			local var_32_8 = arg_29_1.actors_["10127"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10127 == nil then
				arg_29_1.var_.actorSpriteComps10127 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.2

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps10127 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10127 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10127 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.65

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_18 = arg_29_1:FormatText(StoryNameCfg[8].name)

				arg_29_1.leftNameTxt_.text = var_32_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(416172007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172007", "story_v_out_416172.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_416172", "416172007", "story_v_out_416172.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_416172", "416172007", "story_v_out_416172.awb")

						arg_29_1:RecordAudio("416172007", var_32_25)
						arg_29_1:RecordAudio("416172007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416172", "416172007", "story_v_out_416172.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416172", "416172007", "story_v_out_416172.awb")
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
	Play416172008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416172008
		arg_33_1.duration_ = 7.4

		local var_33_0 = {
			zh = 4.166,
			ja = 7.4
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
				arg_33_0:Play416172009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10122"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10122 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10122", 2)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "split_4" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(-390, -380, -100)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10122, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_36_7 = 0
			local var_36_8 = 0.475

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_9 = arg_33_1:FormatText(StoryNameCfg[8].name)

				arg_33_1.leftNameTxt_.text = var_36_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(416172008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_12 = 19
				local var_36_13 = utf8.len(var_36_11)
				local var_36_14 = var_36_12 <= 0 and var_36_8 or var_36_8 * (var_36_13 / var_36_12)

				if var_36_14 > 0 and var_36_8 < var_36_14 then
					arg_33_1.talkMaxDuration = var_36_14

					if var_36_14 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_7
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172008", "story_v_out_416172.awb") ~= 0 then
					local var_36_15 = manager.audio:GetVoiceLength("story_v_out_416172", "416172008", "story_v_out_416172.awb") / 1000

					if var_36_15 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_7
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_416172", "416172008", "story_v_out_416172.awb")

						arg_33_1:RecordAudio("416172008", var_36_16)
						arg_33_1:RecordAudio("416172008", var_36_16)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416172", "416172008", "story_v_out_416172.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416172", "416172008", "story_v_out_416172.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_17 = math.max(var_36_8, arg_33_1.talkMaxDuration)

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_17 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_7) / var_36_17

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_7 + var_36_17 and arg_33_1.time_ < var_36_7 + var_36_17 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416172009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416172009
		arg_37_1.duration_ = 9.97

		local var_37_0 = {
			zh = 7.033,
			ja = 9.966
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
				arg_37_0:Play416172010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10127"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10127 == nil then
				arg_37_1.var_.actorSpriteComps10127 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps10127 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10127 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10127 = nil
			end

			local var_40_8 = arg_37_1.actors_["10122"]
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10122 == nil then
				arg_37_1.var_.actorSpriteComps10122 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_10 = 0.2

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 and not isNil(var_40_8) then
				local var_40_11 = (arg_37_1.time_ - var_40_9) / var_40_10

				if arg_37_1.var_.actorSpriteComps10122 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10122 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_40_7 then
						if arg_37_1.isInRecall_ then
							iter_40_7.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10122 = nil
			end

			local var_40_16 = 0
			local var_40_17 = 0.925

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_18 = arg_37_1:FormatText(StoryNameCfg[236].name)

				arg_37_1.leftNameTxt_.text = var_40_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_19 = arg_37_1:GetWordFromCfg(416172009)
				local var_40_20 = arg_37_1:FormatText(var_40_19.content)

				arg_37_1.text_.text = var_40_20

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_21 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172009", "story_v_out_416172.awb") ~= 0 then
					local var_40_24 = manager.audio:GetVoiceLength("story_v_out_416172", "416172009", "story_v_out_416172.awb") / 1000

					if var_40_24 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_24 + var_40_16
					end

					if var_40_19.prefab_name ~= "" and arg_37_1.actors_[var_40_19.prefab_name] ~= nil then
						local var_40_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_19.prefab_name].transform, "story_v_out_416172", "416172009", "story_v_out_416172.awb")

						arg_37_1:RecordAudio("416172009", var_40_25)
						arg_37_1:RecordAudio("416172009", var_40_25)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416172", "416172009", "story_v_out_416172.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416172", "416172009", "story_v_out_416172.awb")
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
	Play416172010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416172010
		arg_41_1.duration_ = 4.1

		local var_41_0 = {
			zh = 4.1,
			ja = 3.1
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
				arg_41_0:Play416172011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10122"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10122 == nil then
				arg_41_1.var_.actorSpriteComps10122 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10122 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 1, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10122 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10122 = nil
			end

			local var_44_8 = arg_41_1.actors_["10127"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10127 == nil then
				arg_41_1.var_.actorSpriteComps10127 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps10127 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								local var_44_12 = Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, var_44_11)
								local var_44_13 = Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, var_44_11)
								local var_44_14 = Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, var_44_11)

								iter_44_5.color = Color.New(var_44_12, var_44_13, var_44_14)
							else
								local var_44_15 = Mathf.Lerp(iter_44_5.color.r, 0.5, var_44_11)

								iter_44_5.color = Color.New(var_44_15, var_44_15, var_44_15)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10127 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10127 = nil
			end

			local var_44_16 = 0
			local var_44_17 = 0.475

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_18 = arg_41_1:FormatText(StoryNameCfg[8].name)

				arg_41_1.leftNameTxt_.text = var_44_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_19 = arg_41_1:GetWordFromCfg(416172010)
				local var_44_20 = arg_41_1:FormatText(var_44_19.content)

				arg_41_1.text_.text = var_44_20

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_21 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172010", "story_v_out_416172.awb") ~= 0 then
					local var_44_24 = manager.audio:GetVoiceLength("story_v_out_416172", "416172010", "story_v_out_416172.awb") / 1000

					if var_44_24 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_16
					end

					if var_44_19.prefab_name ~= "" and arg_41_1.actors_[var_44_19.prefab_name] ~= nil then
						local var_44_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_19.prefab_name].transform, "story_v_out_416172", "416172010", "story_v_out_416172.awb")

						arg_41_1:RecordAudio("416172010", var_44_25)
						arg_41_1:RecordAudio("416172010", var_44_25)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416172", "416172010", "story_v_out_416172.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416172", "416172010", "story_v_out_416172.awb")
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
	Play416172011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416172011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play416172012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10122"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10122 == nil then
				arg_45_1.var_.actorSpriteComps10122 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps10122 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 0.5, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10122 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10122 = nil
			end

			local var_48_8 = arg_45_1.actors_["10122"].transform
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.var_.moveOldPos10122 = var_48_8.localPosition
				var_48_8.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10122", 7)

				local var_48_10 = var_48_8.childCount

				for iter_48_4 = 0, var_48_10 - 1 do
					local var_48_11 = var_48_8:GetChild(iter_48_4)

					if var_48_11.name == "" or not string.find(var_48_11.name, "split") then
						var_48_11.gameObject:SetActive(true)
					else
						var_48_11.gameObject:SetActive(false)
					end
				end
			end

			local var_48_12 = 0.001

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_12 then
				local var_48_13 = (arg_45_1.time_ - var_48_9) / var_48_12
				local var_48_14 = Vector3.New(0, -2000, 0)

				var_48_8.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10122, var_48_14, var_48_13)
			end

			if arg_45_1.time_ >= var_48_9 + var_48_12 and arg_45_1.time_ < var_48_9 + var_48_12 + arg_48_0 then
				var_48_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_15 = arg_45_1.actors_["10127"].transform
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.var_.moveOldPos10127 = var_48_15.localPosition
				var_48_15.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10127", 7)

				local var_48_17 = var_48_15.childCount

				for iter_48_5 = 0, var_48_17 - 1 do
					local var_48_18 = var_48_15:GetChild(iter_48_5)

					if var_48_18.name == "" or not string.find(var_48_18.name, "split") then
						var_48_18.gameObject:SetActive(true)
					else
						var_48_18.gameObject:SetActive(false)
					end
				end
			end

			local var_48_19 = 0.001

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_19 then
				local var_48_20 = (arg_45_1.time_ - var_48_16) / var_48_19
				local var_48_21 = Vector3.New(0, -2000, 0)

				var_48_15.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10127, var_48_21, var_48_20)
			end

			if arg_45_1.time_ >= var_48_16 + var_48_19 and arg_45_1.time_ < var_48_16 + var_48_19 + arg_48_0 then
				var_48_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_22 = 0
			local var_48_23 = 0.975

			if var_48_22 < arg_45_1.time_ and arg_45_1.time_ <= var_48_22 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_24 = arg_45_1:GetWordFromCfg(416172011)
				local var_48_25 = arg_45_1:FormatText(var_48_24.content)

				arg_45_1.text_.text = var_48_25

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_26 = 39
				local var_48_27 = utf8.len(var_48_25)
				local var_48_28 = var_48_26 <= 0 and var_48_23 or var_48_23 * (var_48_27 / var_48_26)

				if var_48_28 > 0 and var_48_23 < var_48_28 then
					arg_45_1.talkMaxDuration = var_48_28

					if var_48_28 + var_48_22 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_28 + var_48_22
					end
				end

				arg_45_1.text_.text = var_48_25
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_29 = math.max(var_48_23, arg_45_1.talkMaxDuration)

			if var_48_22 <= arg_45_1.time_ and arg_45_1.time_ < var_48_22 + var_48_29 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_22) / var_48_29

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_22 + var_48_29 and arg_45_1.time_ < var_48_22 + var_48_29 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
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
	Play416172012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416172012
		arg_49_1.duration_ = 5.17

		local var_49_0 = {
			zh = 5.166,
			ja = 4.466
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
				arg_49_0:Play416172013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10122"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10122 == nil then
				arg_49_1.var_.actorSpriteComps10122 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10122 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 1, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10122 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10122 = nil
			end

			local var_52_8 = arg_49_1.actors_["10122"].transform
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1.var_.moveOldPos10122 = var_52_8.localPosition
				var_52_8.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10122", 2)

				local var_52_10 = var_52_8.childCount

				for iter_52_4 = 0, var_52_10 - 1 do
					local var_52_11 = var_52_8:GetChild(iter_52_4)

					if var_52_11.name == "split_4" or not string.find(var_52_11.name, "split") then
						var_52_11.gameObject:SetActive(true)
					else
						var_52_11.gameObject:SetActive(false)
					end
				end
			end

			local var_52_12 = 0.001

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_12 then
				local var_52_13 = (arg_49_1.time_ - var_52_9) / var_52_12
				local var_52_14 = Vector3.New(-390, -380, -100)

				var_52_8.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10122, var_52_14, var_52_13)
			end

			if arg_49_1.time_ >= var_52_9 + var_52_12 and arg_49_1.time_ < var_52_9 + var_52_12 + arg_52_0 then
				var_52_8.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_52_15 = 0
			local var_52_16 = 0.475

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[8].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(416172012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172012", "story_v_out_416172.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_416172", "416172012", "story_v_out_416172.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_416172", "416172012", "story_v_out_416172.awb")

						arg_49_1:RecordAudio("416172012", var_52_24)
						arg_49_1:RecordAudio("416172012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416172", "416172012", "story_v_out_416172.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416172", "416172012", "story_v_out_416172.awb")
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
				actorName = "10122",
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
	Play416172013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416172013
		arg_53_1.duration_ = 5.07

		local var_53_0 = {
			zh = 5.066,
			ja = 4.3
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
				arg_53_0:Play416172014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10122"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10122 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10122", 2)

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
				local var_56_6 = Vector3.New(-390, -380, -100)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10122, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_56_7 = 0
			local var_56_8 = 0.55

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_9 = arg_53_1:FormatText(StoryNameCfg[8].name)

				arg_53_1.leftNameTxt_.text = var_56_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(416172013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_12 = 22
				local var_56_13 = utf8.len(var_56_11)
				local var_56_14 = var_56_12 <= 0 and var_56_8 or var_56_8 * (var_56_13 / var_56_12)

				if var_56_14 > 0 and var_56_8 < var_56_14 then
					arg_53_1.talkMaxDuration = var_56_14

					if var_56_14 + var_56_7 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_7
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172013", "story_v_out_416172.awb") ~= 0 then
					local var_56_15 = manager.audio:GetVoiceLength("story_v_out_416172", "416172013", "story_v_out_416172.awb") / 1000

					if var_56_15 + var_56_7 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_7
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_416172", "416172013", "story_v_out_416172.awb")

						arg_53_1:RecordAudio("416172013", var_56_16)
						arg_53_1:RecordAudio("416172013", var_56_16)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416172", "416172013", "story_v_out_416172.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416172", "416172013", "story_v_out_416172.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_17 = math.max(var_56_8, arg_53_1.talkMaxDuration)

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_17 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_7) / var_56_17

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_7 + var_56_17 and arg_53_1.time_ < var_56_7 + var_56_17 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416172014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416172014
		arg_57_1.duration_ = 6.27

		local var_57_0 = {
			zh = 6.266,
			ja = 4.933
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
				arg_57_0:Play416172015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10127"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10127 == nil then
				arg_57_1.var_.actorSpriteComps10127 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10127 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 1, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10127 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10127 = nil
			end

			local var_60_8 = arg_57_1.actors_["10122"]
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10122 == nil then
				arg_57_1.var_.actorSpriteComps10122 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_10 = 0.2

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 and not isNil(var_60_8) then
				local var_60_11 = (arg_57_1.time_ - var_60_9) / var_60_10

				if arg_57_1.var_.actorSpriteComps10122 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								local var_60_12 = Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor2.r, var_60_11)
								local var_60_13 = Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor2.g, var_60_11)
								local var_60_14 = Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor2.b, var_60_11)

								iter_60_5.color = Color.New(var_60_12, var_60_13, var_60_14)
							else
								local var_60_15 = Mathf.Lerp(iter_60_5.color.r, 0.5, var_60_11)

								iter_60_5.color = Color.New(var_60_15, var_60_15, var_60_15)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10122 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_60_7 then
						if arg_57_1.isInRecall_ then
							iter_60_7.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10122 = nil
			end

			local var_60_16 = arg_57_1.actors_["10127"].transform
			local var_60_17 = 0

			if var_60_17 < arg_57_1.time_ and arg_57_1.time_ <= var_60_17 + arg_60_0 then
				arg_57_1.var_.moveOldPos10127 = var_60_16.localPosition
				var_60_16.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10127", 4)

				local var_60_18 = var_60_16.childCount

				for iter_60_8 = 0, var_60_18 - 1 do
					local var_60_19 = var_60_16:GetChild(iter_60_8)

					if var_60_19.name == "split_6" or not string.find(var_60_19.name, "split") then
						var_60_19.gameObject:SetActive(true)
					else
						var_60_19.gameObject:SetActive(false)
					end
				end
			end

			local var_60_20 = 0.001

			if var_60_17 <= arg_57_1.time_ and arg_57_1.time_ < var_60_17 + var_60_20 then
				local var_60_21 = (arg_57_1.time_ - var_60_17) / var_60_20
				local var_60_22 = Vector3.New(345, -387.4, -316.5)

				var_60_16.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10127, var_60_22, var_60_21)
			end

			if arg_57_1.time_ >= var_60_17 + var_60_20 and arg_57_1.time_ < var_60_17 + var_60_20 + arg_60_0 then
				var_60_16.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_60_23 = 0
			local var_60_24 = 0.75

			if var_60_23 < arg_57_1.time_ and arg_57_1.time_ <= var_60_23 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_25 = arg_57_1:FormatText(StoryNameCfg[236].name)

				arg_57_1.leftNameTxt_.text = var_60_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_26 = arg_57_1:GetWordFromCfg(416172014)
				local var_60_27 = arg_57_1:FormatText(var_60_26.content)

				arg_57_1.text_.text = var_60_27

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_28 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172014", "story_v_out_416172.awb") ~= 0 then
					local var_60_31 = manager.audio:GetVoiceLength("story_v_out_416172", "416172014", "story_v_out_416172.awb") / 1000

					if var_60_31 + var_60_23 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_31 + var_60_23
					end

					if var_60_26.prefab_name ~= "" and arg_57_1.actors_[var_60_26.prefab_name] ~= nil then
						local var_60_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_26.prefab_name].transform, "story_v_out_416172", "416172014", "story_v_out_416172.awb")

						arg_57_1:RecordAudio("416172014", var_60_32)
						arg_57_1:RecordAudio("416172014", var_60_32)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416172", "416172014", "story_v_out_416172.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416172", "416172014", "story_v_out_416172.awb")
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
				actorName = "10127",
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
	Play416172015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416172015
		arg_61_1.duration_ = 6

		local var_61_0 = {
			zh = 6,
			ja = 4.733
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
				arg_61_0:Play416172016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10122"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10122 == nil then
				arg_61_1.var_.actorSpriteComps10122 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10122 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10122 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10122 = nil
			end

			local var_64_8 = arg_61_1.actors_["10127"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10127 == nil then
				arg_61_1.var_.actorSpriteComps10127 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps10127 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 0.5, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10127 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10127 = nil
			end

			local var_64_16 = arg_61_1.actors_["10122"].transform
			local var_64_17 = 0

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 then
				arg_61_1.var_.moveOldPos10122 = var_64_16.localPosition
				var_64_16.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10122", 2)

				local var_64_18 = var_64_16.childCount

				for iter_64_8 = 0, var_64_18 - 1 do
					local var_64_19 = var_64_16:GetChild(iter_64_8)

					if var_64_19.name == "split_2" or not string.find(var_64_19.name, "split") then
						var_64_19.gameObject:SetActive(true)
					else
						var_64_19.gameObject:SetActive(false)
					end
				end
			end

			local var_64_20 = 0.001

			if var_64_17 <= arg_61_1.time_ and arg_61_1.time_ < var_64_17 + var_64_20 then
				local var_64_21 = (arg_61_1.time_ - var_64_17) / var_64_20
				local var_64_22 = Vector3.New(-390, -380, -100)

				var_64_16.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10122, var_64_22, var_64_21)
			end

			if arg_61_1.time_ >= var_64_17 + var_64_20 and arg_61_1.time_ < var_64_17 + var_64_20 + arg_64_0 then
				var_64_16.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_64_23 = 0
			local var_64_24 = 0.625

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_25 = arg_61_1:FormatText(StoryNameCfg[8].name)

				arg_61_1.leftNameTxt_.text = var_64_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_26 = arg_61_1:GetWordFromCfg(416172015)
				local var_64_27 = arg_61_1:FormatText(var_64_26.content)

				arg_61_1.text_.text = var_64_27

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_28 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172015", "story_v_out_416172.awb") ~= 0 then
					local var_64_31 = manager.audio:GetVoiceLength("story_v_out_416172", "416172015", "story_v_out_416172.awb") / 1000

					if var_64_31 + var_64_23 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_31 + var_64_23
					end

					if var_64_26.prefab_name ~= "" and arg_61_1.actors_[var_64_26.prefab_name] ~= nil then
						local var_64_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_26.prefab_name].transform, "story_v_out_416172", "416172015", "story_v_out_416172.awb")

						arg_61_1:RecordAudio("416172015", var_64_32)
						arg_61_1:RecordAudio("416172015", var_64_32)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416172", "416172015", "story_v_out_416172.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416172", "416172015", "story_v_out_416172.awb")
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
				actorName = "10122",
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
	Play416172016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416172016
		arg_65_1.duration_ = 8.9

		local var_65_0 = {
			zh = 5.033,
			ja = 8.9
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
				arg_65_0:Play416172017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.55

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[8].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(416172016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172016", "story_v_out_416172.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_416172", "416172016", "story_v_out_416172.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_416172", "416172016", "story_v_out_416172.awb")

						arg_65_1:RecordAudio("416172016", var_68_9)
						arg_65_1:RecordAudio("416172016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416172", "416172016", "story_v_out_416172.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416172", "416172016", "story_v_out_416172.awb")
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
	Play416172017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416172017
		arg_69_1.duration_ = 1.5

		local var_69_0 = {
			zh = 1.066,
			ja = 1.5
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
				arg_69_0:Play416172018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10127"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10127 == nil then
				arg_69_1.var_.actorSpriteComps10127 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps10127 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 1, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10127 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10127 = nil
			end

			local var_72_8 = arg_69_1.actors_["10122"]
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10122 == nil then
				arg_69_1.var_.actorSpriteComps10122 = var_72_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_10 = 0.2

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 and not isNil(var_72_8) then
				local var_72_11 = (arg_69_1.time_ - var_72_9) / var_72_10

				if arg_69_1.var_.actorSpriteComps10122 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								local var_72_12 = Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor2.r, var_72_11)
								local var_72_13 = Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor2.g, var_72_11)
								local var_72_14 = Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor2.b, var_72_11)

								iter_72_5.color = Color.New(var_72_12, var_72_13, var_72_14)
							else
								local var_72_15 = Mathf.Lerp(iter_72_5.color.r, 0.5, var_72_11)

								iter_72_5.color = Color.New(var_72_15, var_72_15, var_72_15)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10122 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_72_7 then
						if arg_69_1.isInRecall_ then
							iter_72_7.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10122 = nil
			end

			local var_72_16 = arg_69_1.actors_["10127"].transform
			local var_72_17 = 0

			if var_72_17 < arg_69_1.time_ and arg_69_1.time_ <= var_72_17 + arg_72_0 then
				arg_69_1.var_.moveOldPos10127 = var_72_16.localPosition
				var_72_16.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10127", 4)

				local var_72_18 = var_72_16.childCount

				for iter_72_8 = 0, var_72_18 - 1 do
					local var_72_19 = var_72_16:GetChild(iter_72_8)

					if var_72_19.name == "split_1" or not string.find(var_72_19.name, "split") then
						var_72_19.gameObject:SetActive(true)
					else
						var_72_19.gameObject:SetActive(false)
					end
				end
			end

			local var_72_20 = 0.001

			if var_72_17 <= arg_69_1.time_ and arg_69_1.time_ < var_72_17 + var_72_20 then
				local var_72_21 = (arg_69_1.time_ - var_72_17) / var_72_20
				local var_72_22 = Vector3.New(345, -387.4, -316.5)

				var_72_16.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10127, var_72_22, var_72_21)
			end

			if arg_69_1.time_ >= var_72_17 + var_72_20 and arg_69_1.time_ < var_72_17 + var_72_20 + arg_72_0 then
				var_72_16.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_72_23 = 0
			local var_72_24 = 0.125

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

				local var_72_26 = arg_69_1:GetWordFromCfg(416172017)
				local var_72_27 = arg_69_1:FormatText(var_72_26.content)

				arg_69_1.text_.text = var_72_27

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_28 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172017", "story_v_out_416172.awb") ~= 0 then
					local var_72_31 = manager.audio:GetVoiceLength("story_v_out_416172", "416172017", "story_v_out_416172.awb") / 1000

					if var_72_31 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_31 + var_72_23
					end

					if var_72_26.prefab_name ~= "" and arg_69_1.actors_[var_72_26.prefab_name] ~= nil then
						local var_72_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_26.prefab_name].transform, "story_v_out_416172", "416172017", "story_v_out_416172.awb")

						arg_69_1:RecordAudio("416172017", var_72_32)
						arg_69_1:RecordAudio("416172017", var_72_32)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_416172", "416172017", "story_v_out_416172.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_416172", "416172017", "story_v_out_416172.awb")
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
				actorName = "10127",
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
	Play416172018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416172018
		arg_73_1.duration_ = 2.4

		local var_73_0 = {
			zh = 2.1,
			ja = 2.4
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
				arg_73_0:Play416172019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10122"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10122 == nil then
				arg_73_1.var_.actorSpriteComps10122 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10122 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 1, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10122 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10122 = nil
			end

			local var_76_8 = arg_73_1.actors_["10127"]
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10127 == nil then
				arg_73_1.var_.actorSpriteComps10127 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_10 = 0.2

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_10 and not isNil(var_76_8) then
				local var_76_11 = (arg_73_1.time_ - var_76_9) / var_76_10

				if arg_73_1.var_.actorSpriteComps10127 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_76_5 then
							if arg_73_1.isInRecall_ then
								local var_76_12 = Mathf.Lerp(iter_76_5.color.r, arg_73_1.hightColor2.r, var_76_11)
								local var_76_13 = Mathf.Lerp(iter_76_5.color.g, arg_73_1.hightColor2.g, var_76_11)
								local var_76_14 = Mathf.Lerp(iter_76_5.color.b, arg_73_1.hightColor2.b, var_76_11)

								iter_76_5.color = Color.New(var_76_12, var_76_13, var_76_14)
							else
								local var_76_15 = Mathf.Lerp(iter_76_5.color.r, 0.5, var_76_11)

								iter_76_5.color = Color.New(var_76_15, var_76_15, var_76_15)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_9 + var_76_10 and arg_73_1.time_ < var_76_9 + var_76_10 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10127 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_76_7 then
						if arg_73_1.isInRecall_ then
							iter_76_7.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10127 = nil
			end

			local var_76_16 = 0
			local var_76_17 = 0.2

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_18 = arg_73_1:FormatText(StoryNameCfg[8].name)

				arg_73_1.leftNameTxt_.text = var_76_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_19 = arg_73_1:GetWordFromCfg(416172018)
				local var_76_20 = arg_73_1:FormatText(var_76_19.content)

				arg_73_1.text_.text = var_76_20

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_21 = 8
				local var_76_22 = utf8.len(var_76_20)
				local var_76_23 = var_76_21 <= 0 and var_76_17 or var_76_17 * (var_76_22 / var_76_21)

				if var_76_23 > 0 and var_76_17 < var_76_23 then
					arg_73_1.talkMaxDuration = var_76_23

					if var_76_23 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_16
					end
				end

				arg_73_1.text_.text = var_76_20
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172018", "story_v_out_416172.awb") ~= 0 then
					local var_76_24 = manager.audio:GetVoiceLength("story_v_out_416172", "416172018", "story_v_out_416172.awb") / 1000

					if var_76_24 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_24 + var_76_16
					end

					if var_76_19.prefab_name ~= "" and arg_73_1.actors_[var_76_19.prefab_name] ~= nil then
						local var_76_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_19.prefab_name].transform, "story_v_out_416172", "416172018", "story_v_out_416172.awb")

						arg_73_1:RecordAudio("416172018", var_76_25)
						arg_73_1:RecordAudio("416172018", var_76_25)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416172", "416172018", "story_v_out_416172.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416172", "416172018", "story_v_out_416172.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_26 = math.max(var_76_17, arg_73_1.talkMaxDuration)

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_26 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_16) / var_76_26

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_16 + var_76_26 and arg_73_1.time_ < var_76_16 + var_76_26 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play416172019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416172019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play416172020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10122"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10122 == nil then
				arg_77_1.var_.actorSpriteComps10122 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps10122 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor2.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor2.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor2.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 0.5, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10122 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10122 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 1.275

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(416172019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_12 = 51
				local var_80_13 = utf8.len(var_80_11)
				local var_80_14 = var_80_12 <= 0 and var_80_9 or var_80_9 * (var_80_13 / var_80_12)

				if var_80_14 > 0 and var_80_9 < var_80_14 then
					arg_77_1.talkMaxDuration = var_80_14

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_15 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_15 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_15

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_15 and arg_77_1.time_ < var_80_8 + var_80_15 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play416172020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416172020
		arg_81_1.duration_ = 7.13

		local var_81_0 = {
			zh = 4.4,
			ja = 7.133
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
				arg_81_0:Play416172021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10122"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10122 == nil then
				arg_81_1.var_.actorSpriteComps10122 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps10122 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								local var_84_4 = Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, var_84_3)
								local var_84_5 = Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, var_84_3)
								local var_84_6 = Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, var_84_3)

								iter_84_1.color = Color.New(var_84_4, var_84_5, var_84_6)
							else
								local var_84_7 = Mathf.Lerp(iter_84_1.color.r, 1, var_84_3)

								iter_84_1.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10122 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10122 = nil
			end

			local var_84_8 = arg_81_1.actors_["10122"].transform
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 then
				arg_81_1.var_.moveOldPos10122 = var_84_8.localPosition
				var_84_8.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10122", 2)

				local var_84_10 = var_84_8.childCount

				for iter_84_4 = 0, var_84_10 - 1 do
					local var_84_11 = var_84_8:GetChild(iter_84_4)

					if var_84_11.name == "" or not string.find(var_84_11.name, "split") then
						var_84_11.gameObject:SetActive(true)
					else
						var_84_11.gameObject:SetActive(false)
					end
				end
			end

			local var_84_12 = 0.001

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_12 then
				local var_84_13 = (arg_81_1.time_ - var_84_9) / var_84_12
				local var_84_14 = Vector3.New(-390, -380, -100)

				var_84_8.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10122, var_84_14, var_84_13)
			end

			if arg_81_1.time_ >= var_84_9 + var_84_12 and arg_81_1.time_ < var_84_9 + var_84_12 + arg_84_0 then
				var_84_8.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_84_15 = 0
			local var_84_16 = 0.6

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_17 = arg_81_1:FormatText(StoryNameCfg[8].name)

				arg_81_1.leftNameTxt_.text = var_84_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_18 = arg_81_1:GetWordFromCfg(416172020)
				local var_84_19 = arg_81_1:FormatText(var_84_18.content)

				arg_81_1.text_.text = var_84_19

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_20 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172020", "story_v_out_416172.awb") ~= 0 then
					local var_84_23 = manager.audio:GetVoiceLength("story_v_out_416172", "416172020", "story_v_out_416172.awb") / 1000

					if var_84_23 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_15
					end

					if var_84_18.prefab_name ~= "" and arg_81_1.actors_[var_84_18.prefab_name] ~= nil then
						local var_84_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_18.prefab_name].transform, "story_v_out_416172", "416172020", "story_v_out_416172.awb")

						arg_81_1:RecordAudio("416172020", var_84_24)
						arg_81_1:RecordAudio("416172020", var_84_24)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416172", "416172020", "story_v_out_416172.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416172", "416172020", "story_v_out_416172.awb")
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
				actorName = "10122",
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
	Play416172021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416172021
		arg_85_1.duration_ = 6

		local var_85_0 = {
			zh = 3.866,
			ja = 6
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
				arg_85_0:Play416172022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10127"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10127 == nil then
				arg_85_1.var_.actorSpriteComps10127 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10127 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10127 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10127 = nil
			end

			local var_88_8 = arg_85_1.actors_["10122"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10122 == nil then
				arg_85_1.var_.actorSpriteComps10122 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 0.2

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps10122 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10122 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10122 = nil
			end

			local var_88_16 = arg_85_1.actors_["10127"].transform
			local var_88_17 = 0

			if var_88_17 < arg_85_1.time_ and arg_85_1.time_ <= var_88_17 + arg_88_0 then
				arg_85_1.var_.moveOldPos10127 = var_88_16.localPosition
				var_88_16.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10127", 4)

				local var_88_18 = var_88_16.childCount

				for iter_88_8 = 0, var_88_18 - 1 do
					local var_88_19 = var_88_16:GetChild(iter_88_8)

					if var_88_19.name == "split_1" or not string.find(var_88_19.name, "split") then
						var_88_19.gameObject:SetActive(true)
					else
						var_88_19.gameObject:SetActive(false)
					end
				end
			end

			local var_88_20 = 0.001

			if var_88_17 <= arg_85_1.time_ and arg_85_1.time_ < var_88_17 + var_88_20 then
				local var_88_21 = (arg_85_1.time_ - var_88_17) / var_88_20
				local var_88_22 = Vector3.New(345, -387.4, -316.5)

				var_88_16.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10127, var_88_22, var_88_21)
			end

			if arg_85_1.time_ >= var_88_17 + var_88_20 and arg_85_1.time_ < var_88_17 + var_88_20 + arg_88_0 then
				var_88_16.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_88_23 = 0
			local var_88_24 = 0.525

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_25 = arg_85_1:FormatText(StoryNameCfg[236].name)

				arg_85_1.leftNameTxt_.text = var_88_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:GetWordFromCfg(416172021)
				local var_88_27 = arg_85_1:FormatText(var_88_26.content)

				arg_85_1.text_.text = var_88_27

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172021", "story_v_out_416172.awb") ~= 0 then
					local var_88_31 = manager.audio:GetVoiceLength("story_v_out_416172", "416172021", "story_v_out_416172.awb") / 1000

					if var_88_31 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_31 + var_88_23
					end

					if var_88_26.prefab_name ~= "" and arg_85_1.actors_[var_88_26.prefab_name] ~= nil then
						local var_88_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_26.prefab_name].transform, "story_v_out_416172", "416172021", "story_v_out_416172.awb")

						arg_85_1:RecordAudio("416172021", var_88_32)
						arg_85_1:RecordAudio("416172021", var_88_32)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416172", "416172021", "story_v_out_416172.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416172", "416172021", "story_v_out_416172.awb")
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
				actorName = "10127",
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
	Play416172022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416172022
		arg_89_1.duration_ = 6.03

		local var_89_0 = {
			zh = 4.9,
			ja = 6.033
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
				arg_89_0:Play416172023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10122"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10122 == nil then
				arg_89_1.var_.actorSpriteComps10122 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps10122 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								local var_92_4 = Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, var_92_3)
								local var_92_5 = Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, var_92_3)
								local var_92_6 = Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, var_92_3)

								iter_92_1.color = Color.New(var_92_4, var_92_5, var_92_6)
							else
								local var_92_7 = Mathf.Lerp(iter_92_1.color.r, 1, var_92_3)

								iter_92_1.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10122 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10122 = nil
			end

			local var_92_8 = arg_89_1.actors_["10127"]
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10127 == nil then
				arg_89_1.var_.actorSpriteComps10127 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_10 = 0.2

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 and not isNil(var_92_8) then
				local var_92_11 = (arg_89_1.time_ - var_92_9) / var_92_10

				if arg_89_1.var_.actorSpriteComps10127 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								local var_92_12 = Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, var_92_11)
								local var_92_13 = Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, var_92_11)
								local var_92_14 = Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, var_92_11)

								iter_92_5.color = Color.New(var_92_12, var_92_13, var_92_14)
							else
								local var_92_15 = Mathf.Lerp(iter_92_5.color.r, 0.5, var_92_11)

								iter_92_5.color = Color.New(var_92_15, var_92_15, var_92_15)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10127 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_92_7 then
						if arg_89_1.isInRecall_ then
							iter_92_7.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10127 = nil
			end

			local var_92_16 = 0
			local var_92_17 = 0.675

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_18 = arg_89_1:FormatText(StoryNameCfg[8].name)

				arg_89_1.leftNameTxt_.text = var_92_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_19 = arg_89_1:GetWordFromCfg(416172022)
				local var_92_20 = arg_89_1:FormatText(var_92_19.content)

				arg_89_1.text_.text = var_92_20

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_21 = 27
				local var_92_22 = utf8.len(var_92_20)
				local var_92_23 = var_92_21 <= 0 and var_92_17 or var_92_17 * (var_92_22 / var_92_21)

				if var_92_23 > 0 and var_92_17 < var_92_23 then
					arg_89_1.talkMaxDuration = var_92_23

					if var_92_23 + var_92_16 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_16
					end
				end

				arg_89_1.text_.text = var_92_20
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172022", "story_v_out_416172.awb") ~= 0 then
					local var_92_24 = manager.audio:GetVoiceLength("story_v_out_416172", "416172022", "story_v_out_416172.awb") / 1000

					if var_92_24 + var_92_16 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_24 + var_92_16
					end

					if var_92_19.prefab_name ~= "" and arg_89_1.actors_[var_92_19.prefab_name] ~= nil then
						local var_92_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_19.prefab_name].transform, "story_v_out_416172", "416172022", "story_v_out_416172.awb")

						arg_89_1:RecordAudio("416172022", var_92_25)
						arg_89_1:RecordAudio("416172022", var_92_25)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416172", "416172022", "story_v_out_416172.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416172", "416172022", "story_v_out_416172.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_26 = math.max(var_92_17, arg_89_1.talkMaxDuration)

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_26 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_16) / var_92_26

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_16 + var_92_26 and arg_89_1.time_ < var_92_16 + var_92_26 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play416172023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416172023
		arg_93_1.duration_ = 11.2

		local var_93_0 = {
			zh = 6.6,
			ja = 11.2
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
				arg_93_0:Play416172024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.825

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[8].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(416172023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 33
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172023", "story_v_out_416172.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_416172", "416172023", "story_v_out_416172.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_416172", "416172023", "story_v_out_416172.awb")

						arg_93_1:RecordAudio("416172023", var_96_9)
						arg_93_1:RecordAudio("416172023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416172", "416172023", "story_v_out_416172.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416172", "416172023", "story_v_out_416172.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play416172024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416172024
		arg_97_1.duration_ = 5.77

		local var_97_0 = {
			zh = 5.766,
			ja = 5.4
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
				arg_97_0:Play416172025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10127"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10127 == nil then
				arg_97_1.var_.actorSpriteComps10127 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps10127 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor1.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor1.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor1.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 1, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10127 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10127 = nil
			end

			local var_100_8 = arg_97_1.actors_["10122"]
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10122 == nil then
				arg_97_1.var_.actorSpriteComps10122 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_10 = 0.2

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_10 and not isNil(var_100_8) then
				local var_100_11 = (arg_97_1.time_ - var_100_9) / var_100_10

				if arg_97_1.var_.actorSpriteComps10122 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								local var_100_12 = Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor2.r, var_100_11)
								local var_100_13 = Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor2.g, var_100_11)
								local var_100_14 = Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor2.b, var_100_11)

								iter_100_5.color = Color.New(var_100_12, var_100_13, var_100_14)
							else
								local var_100_15 = Mathf.Lerp(iter_100_5.color.r, 0.5, var_100_11)

								iter_100_5.color = Color.New(var_100_15, var_100_15, var_100_15)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_9 + var_100_10 and arg_97_1.time_ < var_100_9 + var_100_10 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10122 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_100_7 then
						if arg_97_1.isInRecall_ then
							iter_100_7.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10122 = nil
			end

			local var_100_16 = arg_97_1.actors_["10127"].transform
			local var_100_17 = 0

			if var_100_17 < arg_97_1.time_ and arg_97_1.time_ <= var_100_17 + arg_100_0 then
				arg_97_1.var_.moveOldPos10127 = var_100_16.localPosition
				var_100_16.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10127", 4)

				local var_100_18 = var_100_16.childCount

				for iter_100_8 = 0, var_100_18 - 1 do
					local var_100_19 = var_100_16:GetChild(iter_100_8)

					if var_100_19.name == "split_4" or not string.find(var_100_19.name, "split") then
						var_100_19.gameObject:SetActive(true)
					else
						var_100_19.gameObject:SetActive(false)
					end
				end
			end

			local var_100_20 = 0.001

			if var_100_17 <= arg_97_1.time_ and arg_97_1.time_ < var_100_17 + var_100_20 then
				local var_100_21 = (arg_97_1.time_ - var_100_17) / var_100_20
				local var_100_22 = Vector3.New(345, -387.4, -316.5)

				var_100_16.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10127, var_100_22, var_100_21)
			end

			if arg_97_1.time_ >= var_100_17 + var_100_20 and arg_97_1.time_ < var_100_17 + var_100_20 + arg_100_0 then
				var_100_16.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_100_23 = 0
			local var_100_24 = 0.55

			if var_100_23 < arg_97_1.time_ and arg_97_1.time_ <= var_100_23 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_25 = arg_97_1:FormatText(StoryNameCfg[236].name)

				arg_97_1.leftNameTxt_.text = var_100_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_26 = arg_97_1:GetWordFromCfg(416172024)
				local var_100_27 = arg_97_1:FormatText(var_100_26.content)

				arg_97_1.text_.text = var_100_27

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_28 = 22
				local var_100_29 = utf8.len(var_100_27)
				local var_100_30 = var_100_28 <= 0 and var_100_24 or var_100_24 * (var_100_29 / var_100_28)

				if var_100_30 > 0 and var_100_24 < var_100_30 then
					arg_97_1.talkMaxDuration = var_100_30

					if var_100_30 + var_100_23 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_30 + var_100_23
					end
				end

				arg_97_1.text_.text = var_100_27
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172024", "story_v_out_416172.awb") ~= 0 then
					local var_100_31 = manager.audio:GetVoiceLength("story_v_out_416172", "416172024", "story_v_out_416172.awb") / 1000

					if var_100_31 + var_100_23 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_31 + var_100_23
					end

					if var_100_26.prefab_name ~= "" and arg_97_1.actors_[var_100_26.prefab_name] ~= nil then
						local var_100_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_26.prefab_name].transform, "story_v_out_416172", "416172024", "story_v_out_416172.awb")

						arg_97_1:RecordAudio("416172024", var_100_32)
						arg_97_1:RecordAudio("416172024", var_100_32)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_416172", "416172024", "story_v_out_416172.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_416172", "416172024", "story_v_out_416172.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_33 = math.max(var_100_24, arg_97_1.talkMaxDuration)

			if var_100_23 <= arg_97_1.time_ and arg_97_1.time_ < var_100_23 + var_100_33 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_23) / var_100_33

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_23 + var_100_33 and arg_97_1.time_ < var_100_23 + var_100_33 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play416172025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416172025
		arg_101_1.duration_ = 6.13

		local var_101_0 = {
			zh = 3.4,
			ja = 6.133
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
				arg_101_0:Play416172026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10122"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10122 == nil then
				arg_101_1.var_.actorSpriteComps10122 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps10122 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10122 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10122 = nil
			end

			local var_104_8 = arg_101_1.actors_["10127"]
			local var_104_9 = 0

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps10127 == nil then
				arg_101_1.var_.actorSpriteComps10127 = var_104_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_10 = 0.2

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_10 and not isNil(var_104_8) then
				local var_104_11 = (arg_101_1.time_ - var_104_9) / var_104_10

				if arg_101_1.var_.actorSpriteComps10127 then
					for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_104_5 then
							if arg_101_1.isInRecall_ then
								local var_104_12 = Mathf.Lerp(iter_104_5.color.r, arg_101_1.hightColor2.r, var_104_11)
								local var_104_13 = Mathf.Lerp(iter_104_5.color.g, arg_101_1.hightColor2.g, var_104_11)
								local var_104_14 = Mathf.Lerp(iter_104_5.color.b, arg_101_1.hightColor2.b, var_104_11)

								iter_104_5.color = Color.New(var_104_12, var_104_13, var_104_14)
							else
								local var_104_15 = Mathf.Lerp(iter_104_5.color.r, 0.5, var_104_11)

								iter_104_5.color = Color.New(var_104_15, var_104_15, var_104_15)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_9 + var_104_10 and arg_101_1.time_ < var_104_9 + var_104_10 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps10127 then
				for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_104_7 then
						if arg_101_1.isInRecall_ then
							iter_104_7.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10127 = nil
			end

			local var_104_16 = 0
			local var_104_17 = 0.45

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_18 = arg_101_1:FormatText(StoryNameCfg[8].name)

				arg_101_1.leftNameTxt_.text = var_104_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_19 = arg_101_1:GetWordFromCfg(416172025)
				local var_104_20 = arg_101_1:FormatText(var_104_19.content)

				arg_101_1.text_.text = var_104_20

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_21 = 18
				local var_104_22 = utf8.len(var_104_20)
				local var_104_23 = var_104_21 <= 0 and var_104_17 or var_104_17 * (var_104_22 / var_104_21)

				if var_104_23 > 0 and var_104_17 < var_104_23 then
					arg_101_1.talkMaxDuration = var_104_23

					if var_104_23 + var_104_16 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_16
					end
				end

				arg_101_1.text_.text = var_104_20
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172025", "story_v_out_416172.awb") ~= 0 then
					local var_104_24 = manager.audio:GetVoiceLength("story_v_out_416172", "416172025", "story_v_out_416172.awb") / 1000

					if var_104_24 + var_104_16 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_24 + var_104_16
					end

					if var_104_19.prefab_name ~= "" and arg_101_1.actors_[var_104_19.prefab_name] ~= nil then
						local var_104_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_19.prefab_name].transform, "story_v_out_416172", "416172025", "story_v_out_416172.awb")

						arg_101_1:RecordAudio("416172025", var_104_25)
						arg_101_1:RecordAudio("416172025", var_104_25)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416172", "416172025", "story_v_out_416172.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416172", "416172025", "story_v_out_416172.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_26 = math.max(var_104_17, arg_101_1.talkMaxDuration)

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_26 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_16) / var_104_26

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_16 + var_104_26 and arg_101_1.time_ < var_104_16 + var_104_26 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play416172026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 416172026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play416172027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10122"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10122 == nil then
				arg_105_1.var_.actorSpriteComps10122 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps10122 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor2.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor2.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor2.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 0.5, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10122 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10122 = nil
			end

			local var_108_8 = arg_105_1.actors_["10122"].transform
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1.var_.moveOldPos10122 = var_108_8.localPosition
				var_108_8.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10122", 7)

				local var_108_10 = var_108_8.childCount

				for iter_108_4 = 0, var_108_10 - 1 do
					local var_108_11 = var_108_8:GetChild(iter_108_4)

					if var_108_11.name == "" or not string.find(var_108_11.name, "split") then
						var_108_11.gameObject:SetActive(true)
					else
						var_108_11.gameObject:SetActive(false)
					end
				end
			end

			local var_108_12 = 0.001

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_12 then
				local var_108_13 = (arg_105_1.time_ - var_108_9) / var_108_12
				local var_108_14 = Vector3.New(0, -2000, 0)

				var_108_8.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10122, var_108_14, var_108_13)
			end

			if arg_105_1.time_ >= var_108_9 + var_108_12 and arg_105_1.time_ < var_108_9 + var_108_12 + arg_108_0 then
				var_108_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_108_15 = arg_105_1.actors_["10127"].transform
			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.var_.moveOldPos10127 = var_108_15.localPosition
				var_108_15.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10127", 7)

				local var_108_17 = var_108_15.childCount

				for iter_108_5 = 0, var_108_17 - 1 do
					local var_108_18 = var_108_15:GetChild(iter_108_5)

					if var_108_18.name == "" or not string.find(var_108_18.name, "split") then
						var_108_18.gameObject:SetActive(true)
					else
						var_108_18.gameObject:SetActive(false)
					end
				end
			end

			local var_108_19 = 0.001

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_19 then
				local var_108_20 = (arg_105_1.time_ - var_108_16) / var_108_19
				local var_108_21 = Vector3.New(0, -2000, 0)

				var_108_15.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10127, var_108_21, var_108_20)
			end

			if arg_105_1.time_ >= var_108_16 + var_108_19 and arg_105_1.time_ < var_108_16 + var_108_19 + arg_108_0 then
				var_108_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_108_22 = 0
			local var_108_23 = 1.4

			if var_108_22 < arg_105_1.time_ and arg_105_1.time_ <= var_108_22 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_24 = arg_105_1:GetWordFromCfg(416172026)
				local var_108_25 = arg_105_1:FormatText(var_108_24.content)

				arg_105_1.text_.text = var_108_25

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_26 = 56
				local var_108_27 = utf8.len(var_108_25)
				local var_108_28 = var_108_26 <= 0 and var_108_23 or var_108_23 * (var_108_27 / var_108_26)

				if var_108_28 > 0 and var_108_23 < var_108_28 then
					arg_105_1.talkMaxDuration = var_108_28

					if var_108_28 + var_108_22 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_28 + var_108_22
					end
				end

				arg_105_1.text_.text = var_108_25
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_29 = math.max(var_108_23, arg_105_1.talkMaxDuration)

			if var_108_22 <= arg_105_1.time_ and arg_105_1.time_ < var_108_22 + var_108_29 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_22) / var_108_29

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_22 + var_108_29 and arg_105_1.time_ < var_108_22 + var_108_29 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
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
	Play416172027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 416172027
		arg_109_1.duration_ = 3.63

		local var_109_0 = {
			zh = 3.633,
			ja = 2.9
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
				arg_109_0:Play416172028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10122"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps10122 == nil then
				arg_109_1.var_.actorSpriteComps10122 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps10122 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								local var_112_4 = Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor1.r, var_112_3)
								local var_112_5 = Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor1.g, var_112_3)
								local var_112_6 = Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor1.b, var_112_3)

								iter_112_1.color = Color.New(var_112_4, var_112_5, var_112_6)
							else
								local var_112_7 = Mathf.Lerp(iter_112_1.color.r, 1, var_112_3)

								iter_112_1.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps10122 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10122 = nil
			end

			local var_112_8 = arg_109_1.actors_["10122"].transform
			local var_112_9 = 0

			if var_112_9 < arg_109_1.time_ and arg_109_1.time_ <= var_112_9 + arg_112_0 then
				arg_109_1.var_.moveOldPos10122 = var_112_8.localPosition
				var_112_8.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10122", 3)

				local var_112_10 = var_112_8.childCount

				for iter_112_4 = 0, var_112_10 - 1 do
					local var_112_11 = var_112_8:GetChild(iter_112_4)

					if var_112_11.name == "split_2" or not string.find(var_112_11.name, "split") then
						var_112_11.gameObject:SetActive(true)
					else
						var_112_11.gameObject:SetActive(false)
					end
				end
			end

			local var_112_12 = 0.001

			if var_112_9 <= arg_109_1.time_ and arg_109_1.time_ < var_112_9 + var_112_12 then
				local var_112_13 = (arg_109_1.time_ - var_112_9) / var_112_12
				local var_112_14 = Vector3.New(0, -380, -100)

				var_112_8.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10122, var_112_14, var_112_13)
			end

			if arg_109_1.time_ >= var_112_9 + var_112_12 and arg_109_1.time_ < var_112_9 + var_112_12 + arg_112_0 then
				var_112_8.localPosition = Vector3.New(0, -380, -100)
			end

			local var_112_15 = 0
			local var_112_16 = 0.5

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[8].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(416172027)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 20
				local var_112_21 = utf8.len(var_112_19)
				local var_112_22 = var_112_20 <= 0 and var_112_16 or var_112_16 * (var_112_21 / var_112_20)

				if var_112_22 > 0 and var_112_16 < var_112_22 then
					arg_109_1.talkMaxDuration = var_112_22

					if var_112_22 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172027", "story_v_out_416172.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_416172", "416172027", "story_v_out_416172.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_416172", "416172027", "story_v_out_416172.awb")

						arg_109_1:RecordAudio("416172027", var_112_24)
						arg_109_1:RecordAudio("416172027", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_416172", "416172027", "story_v_out_416172.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_416172", "416172027", "story_v_out_416172.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_25 and arg_109_1.time_ < var_112_15 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416172028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 416172028
		arg_113_1.duration_ = 6.57

		local var_113_0 = {
			zh = 6.166,
			ja = 6.566
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
				arg_113_0:Play416172029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10127"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10127 == nil then
				arg_113_1.var_.actorSpriteComps10127 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps10127 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10127 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10127 = nil
			end

			local var_116_8 = arg_113_1.actors_["10122"]
			local var_116_9 = 0

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps10122 == nil then
				arg_113_1.var_.actorSpriteComps10122 = var_116_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_10 = 0.2

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 and not isNil(var_116_8) then
				local var_116_11 = (arg_113_1.time_ - var_116_9) / var_116_10

				if arg_113_1.var_.actorSpriteComps10122 then
					for iter_116_4, iter_116_5 in pairs(arg_113_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps10122 then
				for iter_116_6, iter_116_7 in pairs(arg_113_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_116_7 then
						if arg_113_1.isInRecall_ then
							iter_116_7.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10122 = nil
			end

			local var_116_16 = 0
			local var_116_17 = 0.775

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_18 = arg_113_1:FormatText(StoryNameCfg[236].name)

				arg_113_1.leftNameTxt_.text = var_116_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_19 = arg_113_1:GetWordFromCfg(416172028)
				local var_116_20 = arg_113_1:FormatText(var_116_19.content)

				arg_113_1.text_.text = var_116_20

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_21 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172028", "story_v_out_416172.awb") ~= 0 then
					local var_116_24 = manager.audio:GetVoiceLength("story_v_out_416172", "416172028", "story_v_out_416172.awb") / 1000

					if var_116_24 + var_116_16 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_24 + var_116_16
					end

					if var_116_19.prefab_name ~= "" and arg_113_1.actors_[var_116_19.prefab_name] ~= nil then
						local var_116_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_19.prefab_name].transform, "story_v_out_416172", "416172028", "story_v_out_416172.awb")

						arg_113_1:RecordAudio("416172028", var_116_25)
						arg_113_1:RecordAudio("416172028", var_116_25)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_416172", "416172028", "story_v_out_416172.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_416172", "416172028", "story_v_out_416172.awb")
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
	Play416172029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 416172029
		arg_117_1.duration_ = 8.25

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play416172030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.6

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				local var_120_1 = manager.ui.mainCamera.transform.localPosition
				local var_120_2 = Vector3.New(0, 0, 10) + Vector3.New(var_120_1.x, var_120_1.y, 0)
				local var_120_3 = arg_117_1.bgs_.I13i

				var_120_3.transform.localPosition = var_120_2
				var_120_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_4 = var_120_3:GetComponent("SpriteRenderer")

				if var_120_4 and var_120_4.sprite then
					local var_120_5 = (var_120_3.transform.localPosition - var_120_1).z
					local var_120_6 = manager.ui.mainCameraCom_
					local var_120_7 = 2 * var_120_5 * Mathf.Tan(var_120_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_120_8 = var_120_7 * var_120_6.aspect
					local var_120_9 = var_120_4.sprite.bounds.size.x
					local var_120_10 = var_120_4.sprite.bounds.size.y
					local var_120_11 = var_120_8 / var_120_9
					local var_120_12 = var_120_7 / var_120_10
					local var_120_13 = var_120_12 < var_120_11 and var_120_11 or var_120_12

					var_120_3.transform.localScale = Vector3.New(var_120_13, var_120_13, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "I13i" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_14 = 1.6

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			local var_120_15 = 0.3

			if arg_117_1.time_ >= var_120_14 + var_120_15 and arg_117_1.time_ < var_120_14 + var_120_15 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_17 = 1.6

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

			local var_120_21 = 1.6

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

			local var_120_27 = arg_117_1.actors_["10127"]
			local var_120_28 = 1.6

			if var_120_28 < arg_117_1.time_ and arg_117_1.time_ <= var_120_28 + arg_120_0 and not isNil(var_120_27) and arg_117_1.var_.actorSpriteComps10127 == nil then
				arg_117_1.var_.actorSpriteComps10127 = var_120_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_29 = 0.2

			if var_120_28 <= arg_117_1.time_ and arg_117_1.time_ < var_120_28 + var_120_29 and not isNil(var_120_27) then
				local var_120_30 = (arg_117_1.time_ - var_120_28) / var_120_29

				if arg_117_1.var_.actorSpriteComps10127 then
					for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_120_3 then
							if arg_117_1.isInRecall_ then
								local var_120_31 = Mathf.Lerp(iter_120_3.color.r, arg_117_1.hightColor2.r, var_120_30)
								local var_120_32 = Mathf.Lerp(iter_120_3.color.g, arg_117_1.hightColor2.g, var_120_30)
								local var_120_33 = Mathf.Lerp(iter_120_3.color.b, arg_117_1.hightColor2.b, var_120_30)

								iter_120_3.color = Color.New(var_120_31, var_120_32, var_120_33)
							else
								local var_120_34 = Mathf.Lerp(iter_120_3.color.r, 0.5, var_120_30)

								iter_120_3.color = Color.New(var_120_34, var_120_34, var_120_34)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_28 + var_120_29 and arg_117_1.time_ < var_120_28 + var_120_29 + arg_120_0 and not isNil(var_120_27) and arg_117_1.var_.actorSpriteComps10127 then
				for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_120_5 then
						if arg_117_1.isInRecall_ then
							iter_120_5.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10127 = nil
			end

			local var_120_35 = arg_117_1.actors_["10122"].transform
			local var_120_36 = 1.6

			if var_120_36 < arg_117_1.time_ and arg_117_1.time_ <= var_120_36 + arg_120_0 then
				arg_117_1.var_.moveOldPos10122 = var_120_35.localPosition
				var_120_35.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10122", 7)

				local var_120_37 = var_120_35.childCount

				for iter_120_6 = 0, var_120_37 - 1 do
					local var_120_38 = var_120_35:GetChild(iter_120_6)

					if var_120_38.name == "" or not string.find(var_120_38.name, "split") then
						var_120_38.gameObject:SetActive(true)
					else
						var_120_38.gameObject:SetActive(false)
					end
				end
			end

			local var_120_39 = 0.001

			if var_120_36 <= arg_117_1.time_ and arg_117_1.time_ < var_120_36 + var_120_39 then
				local var_120_40 = (arg_117_1.time_ - var_120_36) / var_120_39
				local var_120_41 = Vector3.New(0, -2000, 0)

				var_120_35.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10122, var_120_41, var_120_40)
			end

			if arg_117_1.time_ >= var_120_36 + var_120_39 and arg_117_1.time_ < var_120_36 + var_120_39 + arg_120_0 then
				var_120_35.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_120_42 = 2.75387010141276
			local var_120_43 = 1

			if var_120_42 < arg_117_1.time_ and arg_117_1.time_ <= var_120_42 + arg_120_0 then
				local var_120_44 = "play"
				local var_120_45 = "effect"

				arg_117_1:AudioAction(var_120_44, var_120_45, "se_story_15", "se_story_15_gun02", "")
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_46 = 3.24677139869891
			local var_120_47 = 1.6

			if var_120_46 < arg_117_1.time_ and arg_117_1.time_ <= var_120_46 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_48 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_48:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_49 = arg_117_1:GetWordFromCfg(416172029)
				local var_120_50 = arg_117_1:FormatText(var_120_49.content)

				arg_117_1.text_.text = var_120_50

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_51 = 64
				local var_120_52 = utf8.len(var_120_50)
				local var_120_53 = var_120_51 <= 0 and var_120_47 or var_120_47 * (var_120_52 / var_120_51)

				if var_120_53 > 0 and var_120_47 < var_120_53 then
					arg_117_1.talkMaxDuration = var_120_53
					var_120_46 = var_120_46 + 0.3

					if var_120_53 + var_120_46 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_53 + var_120_46
					end
				end

				arg_117_1.text_.text = var_120_50
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_54 = var_120_46 + 0.3
			local var_120_55 = math.max(var_120_47, arg_117_1.talkMaxDuration)

			if var_120_54 <= arg_117_1.time_ and arg_117_1.time_ < var_120_54 + var_120_55 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_54) / var_120_55

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_54 + var_120_55 and arg_117_1.time_ < var_120_54 + var_120_55 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play416172030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416172030
		arg_123_1.duration_ = 4.9

		local var_123_0 = {
			zh = 4.1,
			ja = 4.9
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play416172031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10122"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10122 == nil then
				arg_123_1.var_.actorSpriteComps10122 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps10122 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								local var_126_4 = Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor1.r, var_126_3)
								local var_126_5 = Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor1.g, var_126_3)
								local var_126_6 = Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor1.b, var_126_3)

								iter_126_1.color = Color.New(var_126_4, var_126_5, var_126_6)
							else
								local var_126_7 = Mathf.Lerp(iter_126_1.color.r, 1, var_126_3)

								iter_126_1.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10122 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10122 = nil
			end

			local var_126_8 = arg_123_1.actors_["10122"].transform
			local var_126_9 = 0

			if var_126_9 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 then
				arg_123_1.var_.moveOldPos10122 = var_126_8.localPosition
				var_126_8.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10122", 3)

				local var_126_10 = var_126_8.childCount

				for iter_126_4 = 0, var_126_10 - 1 do
					local var_126_11 = var_126_8:GetChild(iter_126_4)

					if var_126_11.name == "" or not string.find(var_126_11.name, "split") then
						var_126_11.gameObject:SetActive(true)
					else
						var_126_11.gameObject:SetActive(false)
					end
				end
			end

			local var_126_12 = 0.001

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_12 then
				local var_126_13 = (arg_123_1.time_ - var_126_9) / var_126_12
				local var_126_14 = Vector3.New(0, -380, -100)

				var_126_8.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10122, var_126_14, var_126_13)
			end

			if arg_123_1.time_ >= var_126_9 + var_126_12 and arg_123_1.time_ < var_126_9 + var_126_12 + arg_126_0 then
				var_126_8.localPosition = Vector3.New(0, -380, -100)
			end

			local var_126_15 = 3.03333333333333
			local var_126_16 = 1

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				local var_126_17 = "play"
				local var_126_18 = "effect"

				arg_123_1:AudioAction(var_126_17, var_126_18, "se_story_139", "se_story_139_lasergun", "")
			end

			local var_126_19 = 0
			local var_126_20 = 0.4

			if var_126_19 < arg_123_1.time_ and arg_123_1.time_ <= var_126_19 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_21 = arg_123_1:FormatText(StoryNameCfg[8].name)

				arg_123_1.leftNameTxt_.text = var_126_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_22 = arg_123_1:GetWordFromCfg(416172030)
				local var_126_23 = arg_123_1:FormatText(var_126_22.content)

				arg_123_1.text_.text = var_126_23

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_24 = 16
				local var_126_25 = utf8.len(var_126_23)
				local var_126_26 = var_126_24 <= 0 and var_126_20 or var_126_20 * (var_126_25 / var_126_24)

				if var_126_26 > 0 and var_126_20 < var_126_26 then
					arg_123_1.talkMaxDuration = var_126_26

					if var_126_26 + var_126_19 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_26 + var_126_19
					end
				end

				arg_123_1.text_.text = var_126_23
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172030", "story_v_out_416172.awb") ~= 0 then
					local var_126_27 = manager.audio:GetVoiceLength("story_v_out_416172", "416172030", "story_v_out_416172.awb") / 1000

					if var_126_27 + var_126_19 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_27 + var_126_19
					end

					if var_126_22.prefab_name ~= "" and arg_123_1.actors_[var_126_22.prefab_name] ~= nil then
						local var_126_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_22.prefab_name].transform, "story_v_out_416172", "416172030", "story_v_out_416172.awb")

						arg_123_1:RecordAudio("416172030", var_126_28)
						arg_123_1:RecordAudio("416172030", var_126_28)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_416172", "416172030", "story_v_out_416172.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_416172", "416172030", "story_v_out_416172.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_29 = math.max(var_126_20, arg_123_1.talkMaxDuration)

			if var_126_19 <= arg_123_1.time_ and arg_123_1.time_ < var_126_19 + var_126_29 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_19) / var_126_29

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_19 + var_126_29 and arg_123_1.time_ < var_126_19 + var_126_29 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play416172031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 416172031
		arg_127_1.duration_ = 5.9

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play416172032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10122"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos10122 = var_130_0.localPosition
				var_130_0.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10122", 7)

				local var_130_2 = var_130_0.childCount

				for iter_130_0 = 0, var_130_2 - 1 do
					local var_130_3 = var_130_0:GetChild(iter_130_0)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_4 then
				local var_130_5 = (arg_127_1.time_ - var_130_1) / var_130_4
				local var_130_6 = Vector3.New(0, -2000, 0)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10122, var_130_6, var_130_5)
			end

			if arg_127_1.time_ >= var_130_1 + var_130_4 and arg_127_1.time_ < var_130_1 + var_130_4 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			local var_130_8 = 1.13333333333333

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_9 = manager.ui.mainCamera.transform
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				local var_130_11 = arg_127_1.var_.effect744
				local var_130_12
				local var_130_13 = var_130_9

				if not var_130_11 then
					var_130_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_130_13)
					var_130_11.name = "744"
					arg_127_1.var_.effect744 = var_130_11
				else
					var_130_11.transform:SetParent(var_130_13)
				end

				var_130_11.transform.localPosition = Vector3.New(0, 0.21, 0)
				var_130_11.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_130_14 = manager.ui.mainCameraCom_
				local var_130_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_130_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_130_16 = var_130_11.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_130_17 = 15
				local var_130_18 = 2 * var_130_17 * Mathf.Tan(var_130_14.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_130_14.aspect
				local var_130_19 = 1
				local var_130_20 = 1.7777777777777777

				if var_130_20 < var_130_14.aspect then
					var_130_19 = var_130_18 / (2 * var_130_17 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_130_20)
				end

				for iter_130_1, iter_130_2 in ipairs(var_130_16) do
					local var_130_21 = iter_130_2.transform.localScale

					iter_130_2.transform.localScale = Vector3.New(var_130_21.x / var_130_15 * var_130_19, var_130_21.y / var_130_15, var_130_21.z)
				end
			end

			local var_130_22 = manager.ui.mainCamera.transform
			local var_130_23 = 0.3

			if var_130_23 < arg_127_1.time_ and arg_127_1.time_ <= var_130_23 + arg_130_0 then
				local var_130_24 = arg_127_1.var_.effect745
				local var_130_25
				local var_130_26 = var_130_22

				if not var_130_24 then
					var_130_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_130_26)
					var_130_24.name = "745"
					arg_127_1.var_.effect745 = var_130_24
				else
					var_130_24.transform:SetParent(var_130_26)
				end

				var_130_24.transform.localPosition = Vector3.New(0, 0.21, 0)
				var_130_24.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_130_27 = manager.ui.mainCameraCom_
				local var_130_28 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_130_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_130_29 = var_130_24.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_130_30 = 15
				local var_130_31 = 2 * var_130_30 * Mathf.Tan(var_130_27.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_130_27.aspect
				local var_130_32 = 1
				local var_130_33 = 1.7777777777777777

				if var_130_33 < var_130_27.aspect then
					var_130_32 = var_130_31 / (2 * var_130_30 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_130_33)
				end

				for iter_130_3, iter_130_4 in ipairs(var_130_29) do
					local var_130_34 = iter_130_4.transform.localScale

					iter_130_4.transform.localScale = Vector3.New(var_130_34.x / var_130_28 * var_130_32, var_130_34.y / var_130_28, var_130_34.z)
				end
			end

			local var_130_35 = manager.ui.mainCamera.transform
			local var_130_36 = 2.16666666666667

			if var_130_36 < arg_127_1.time_ and arg_127_1.time_ <= var_130_36 + arg_130_0 then
				local var_130_37 = arg_127_1.var_.effect744

				if var_130_37 then
					Object.Destroy(var_130_37)

					arg_127_1.var_.effect744 = nil
				end
			end

			local var_130_38 = manager.ui.mainCamera.transform
			local var_130_39 = 2.46666666666667

			if var_130_39 < arg_127_1.time_ and arg_127_1.time_ <= var_130_39 + arg_130_0 then
				local var_130_40 = arg_127_1.var_.effect745

				if var_130_40 then
					Object.Destroy(var_130_40)

					arg_127_1.var_.effect745 = nil
				end
			end

			local var_130_41 = 0
			local var_130_42 = 1

			if var_130_41 < arg_127_1.time_ and arg_127_1.time_ <= var_130_41 + arg_130_0 then
				local var_130_43 = "play"
				local var_130_44 = "effect"

				arg_127_1:AudioAction(var_130_43, var_130_44, "se_story_139", "se_story_139_monstersmash03", "")
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_45 = 0.9
			local var_130_46 = 1.825

			if var_130_45 < arg_127_1.time_ and arg_127_1.time_ <= var_130_45 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_47 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_47:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_48 = arg_127_1:GetWordFromCfg(416172031)
				local var_130_49 = arg_127_1:FormatText(var_130_48.content)

				arg_127_1.text_.text = var_130_49

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_50 = 73
				local var_130_51 = utf8.len(var_130_49)
				local var_130_52 = var_130_50 <= 0 and var_130_46 or var_130_46 * (var_130_51 / var_130_50)

				if var_130_52 > 0 and var_130_46 < var_130_52 then
					arg_127_1.talkMaxDuration = var_130_52
					var_130_45 = var_130_45 + 0.3

					if var_130_52 + var_130_45 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_52 + var_130_45
					end
				end

				arg_127_1.text_.text = var_130_49
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_53 = var_130_45 + 0.3
			local var_130_54 = math.max(var_130_46, arg_127_1.talkMaxDuration)

			if var_130_53 <= arg_127_1.time_ and arg_127_1.time_ < var_130_53 + var_130_54 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_53) / var_130_54

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_53 + var_130_54 and arg_127_1.time_ < var_130_53 + var_130_54 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416172032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416172032
		arg_133_1.duration_ = 6.1

		local var_133_0 = {
			zh = 4,
			ja = 6.1
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
				arg_133_0:Play416172033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10122"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10122 == nil then
				arg_133_1.var_.actorSpriteComps10122 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps10122 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								local var_136_4 = Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor1.r, var_136_3)
								local var_136_5 = Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor1.g, var_136_3)
								local var_136_6 = Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor1.b, var_136_3)

								iter_136_1.color = Color.New(var_136_4, var_136_5, var_136_6)
							else
								local var_136_7 = Mathf.Lerp(iter_136_1.color.r, 1, var_136_3)

								iter_136_1.color = Color.New(var_136_7, var_136_7, var_136_7)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10122 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10122 = nil
			end

			local var_136_8 = arg_133_1.actors_["10122"].transform
			local var_136_9 = 0

			if var_136_9 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 then
				arg_133_1.var_.moveOldPos10122 = var_136_8.localPosition
				var_136_8.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10122", 3)

				local var_136_10 = var_136_8.childCount

				for iter_136_4 = 0, var_136_10 - 1 do
					local var_136_11 = var_136_8:GetChild(iter_136_4)

					if var_136_11.name == "" or not string.find(var_136_11.name, "split") then
						var_136_11.gameObject:SetActive(true)
					else
						var_136_11.gameObject:SetActive(false)
					end
				end
			end

			local var_136_12 = 0.001

			if var_136_9 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_12 then
				local var_136_13 = (arg_133_1.time_ - var_136_9) / var_136_12
				local var_136_14 = Vector3.New(0, -380, -100)

				var_136_8.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10122, var_136_14, var_136_13)
			end

			if arg_133_1.time_ >= var_136_9 + var_136_12 and arg_133_1.time_ < var_136_9 + var_136_12 + arg_136_0 then
				var_136_8.localPosition = Vector3.New(0, -380, -100)
			end

			local var_136_15 = 0
			local var_136_16 = 0.5

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_17 = arg_133_1:FormatText(StoryNameCfg[8].name)

				arg_133_1.leftNameTxt_.text = var_136_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_18 = arg_133_1:GetWordFromCfg(416172032)
				local var_136_19 = arg_133_1:FormatText(var_136_18.content)

				arg_133_1.text_.text = var_136_19

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_20 = 20
				local var_136_21 = utf8.len(var_136_19)
				local var_136_22 = var_136_20 <= 0 and var_136_16 or var_136_16 * (var_136_21 / var_136_20)

				if var_136_22 > 0 and var_136_16 < var_136_22 then
					arg_133_1.talkMaxDuration = var_136_22

					if var_136_22 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_22 + var_136_15
					end
				end

				arg_133_1.text_.text = var_136_19
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172032", "story_v_out_416172.awb") ~= 0 then
					local var_136_23 = manager.audio:GetVoiceLength("story_v_out_416172", "416172032", "story_v_out_416172.awb") / 1000

					if var_136_23 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_15
					end

					if var_136_18.prefab_name ~= "" and arg_133_1.actors_[var_136_18.prefab_name] ~= nil then
						local var_136_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_18.prefab_name].transform, "story_v_out_416172", "416172032", "story_v_out_416172.awb")

						arg_133_1:RecordAudio("416172032", var_136_24)
						arg_133_1:RecordAudio("416172032", var_136_24)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_416172", "416172032", "story_v_out_416172.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_416172", "416172032", "story_v_out_416172.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_25 = math.max(var_136_16, arg_133_1.talkMaxDuration)

			if var_136_15 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_25 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_15) / var_136_25

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_15 + var_136_25 and arg_133_1.time_ < var_136_15 + var_136_25 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416172033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416172033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play416172034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10122"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10122 == nil then
				arg_137_1.var_.actorSpriteComps10122 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps10122 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								local var_140_4 = Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, var_140_3)
								local var_140_5 = Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, var_140_3)
								local var_140_6 = Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, var_140_3)

								iter_140_1.color = Color.New(var_140_4, var_140_5, var_140_6)
							else
								local var_140_7 = Mathf.Lerp(iter_140_1.color.r, 0.5, var_140_3)

								iter_140_1.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10122 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10122 = nil
			end

			local var_140_8 = arg_137_1.actors_["10122"].transform
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1.var_.moveOldPos10122 = var_140_8.localPosition
				var_140_8.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10122", 7)

				local var_140_10 = var_140_8.childCount

				for iter_140_4 = 0, var_140_10 - 1 do
					local var_140_11 = var_140_8:GetChild(iter_140_4)

					if var_140_11.name == "" or not string.find(var_140_11.name, "split") then
						var_140_11.gameObject:SetActive(true)
					else
						var_140_11.gameObject:SetActive(false)
					end
				end
			end

			local var_140_12 = 0.001

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_12 then
				local var_140_13 = (arg_137_1.time_ - var_140_9) / var_140_12
				local var_140_14 = Vector3.New(0, -2000, 0)

				var_140_8.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10122, var_140_14, var_140_13)
			end

			if arg_137_1.time_ >= var_140_9 + var_140_12 and arg_137_1.time_ < var_140_9 + var_140_12 + arg_140_0 then
				var_140_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_140_15 = 0
			local var_140_16 = 1.725

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_17 = arg_137_1:GetWordFromCfg(416172033)
				local var_140_18 = arg_137_1:FormatText(var_140_17.content)

				arg_137_1.text_.text = var_140_18

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_19 = 69
				local var_140_20 = utf8.len(var_140_18)
				local var_140_21 = var_140_19 <= 0 and var_140_16 or var_140_16 * (var_140_20 / var_140_19)

				if var_140_21 > 0 and var_140_16 < var_140_21 then
					arg_137_1.talkMaxDuration = var_140_21

					if var_140_21 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_21 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_18
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_22 and arg_137_1.time_ < var_140_15 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416172034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416172034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play416172035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.05
			local var_144_1 = 1

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				local var_144_2 = "play"
				local var_144_3 = "effect"

				arg_141_1:AudioAction(var_144_2, var_144_3, "se_story_138", "se_story_138_lasergun", "")
			end

			local var_144_4 = 0
			local var_144_5 = 1.225

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(416172034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_8 = 49
				local var_144_9 = utf8.len(var_144_7)
				local var_144_10 = var_144_8 <= 0 and var_144_5 or var_144_5 * (var_144_9 / var_144_8)

				if var_144_10 > 0 and var_144_5 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_11 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_11 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_11

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_11 and arg_141_1.time_ < var_144_4 + var_144_11 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play416172035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416172035
		arg_145_1.duration_ = 3.57

		local var_145_0 = {
			zh = 3.033,
			ja = 3.566
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
				arg_145_0:Play416172036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10122"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10122 == nil then
				arg_145_1.var_.actorSpriteComps10122 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps10122 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10122 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10122 = nil
			end

			local var_148_8 = arg_145_1.actors_["10122"].transform
			local var_148_9 = 0

			if var_148_9 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.var_.moveOldPos10122 = var_148_8.localPosition
				var_148_8.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10122", 3)

				local var_148_10 = var_148_8.childCount

				for iter_148_4 = 0, var_148_10 - 1 do
					local var_148_11 = var_148_8:GetChild(iter_148_4)

					if var_148_11.name == "split_2" or not string.find(var_148_11.name, "split") then
						var_148_11.gameObject:SetActive(true)
					else
						var_148_11.gameObject:SetActive(false)
					end
				end
			end

			local var_148_12 = 0.001

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_12 then
				local var_148_13 = (arg_145_1.time_ - var_148_9) / var_148_12
				local var_148_14 = Vector3.New(0, -380, -100)

				var_148_8.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10122, var_148_14, var_148_13)
			end

			if arg_145_1.time_ >= var_148_9 + var_148_12 and arg_145_1.time_ < var_148_9 + var_148_12 + arg_148_0 then
				var_148_8.localPosition = Vector3.New(0, -380, -100)
			end

			local var_148_15 = 0
			local var_148_16 = 0.325

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[8].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(416172035)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 13
				local var_148_21 = utf8.len(var_148_19)
				local var_148_22 = var_148_20 <= 0 and var_148_16 or var_148_16 * (var_148_21 / var_148_20)

				if var_148_22 > 0 and var_148_16 < var_148_22 then
					arg_145_1.talkMaxDuration = var_148_22

					if var_148_22 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_19
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172035", "story_v_out_416172.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_416172", "416172035", "story_v_out_416172.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_416172", "416172035", "story_v_out_416172.awb")

						arg_145_1:RecordAudio("416172035", var_148_24)
						arg_145_1:RecordAudio("416172035", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416172", "416172035", "story_v_out_416172.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416172", "416172035", "story_v_out_416172.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_25 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_25

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_25 and arg_145_1.time_ < var_148_15 + var_148_25 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416172036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416172036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play416172037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10122"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10122 == nil then
				arg_149_1.var_.actorSpriteComps10122 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps10122 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 0.5, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10122 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10122 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 2.1

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(416172036)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_12 = 84
				local var_152_13 = utf8.len(var_152_11)
				local var_152_14 = var_152_12 <= 0 and var_152_9 or var_152_9 * (var_152_13 / var_152_12)

				if var_152_14 > 0 and var_152_9 < var_152_14 then
					arg_149_1.talkMaxDuration = var_152_14

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_15 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_15 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_15

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_15 and arg_149_1.time_ < var_152_8 + var_152_15 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play416172037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416172037
		arg_153_1.duration_ = 2.7

		local var_153_0 = {
			zh = 2.633,
			ja = 2.7
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
				arg_153_0:Play416172038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10122"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10122 == nil then
				arg_153_1.var_.actorSpriteComps10122 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps10122 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								local var_156_4 = Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, var_156_3)
								local var_156_5 = Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, var_156_3)
								local var_156_6 = Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, var_156_3)

								iter_156_1.color = Color.New(var_156_4, var_156_5, var_156_6)
							else
								local var_156_7 = Mathf.Lerp(iter_156_1.color.r, 1, var_156_3)

								iter_156_1.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10122 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10122 = nil
			end

			local var_156_8 = arg_153_1.actors_["10122"].transform
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.var_.moveOldPos10122 = var_156_8.localPosition
				var_156_8.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10122", 3)

				local var_156_10 = var_156_8.childCount

				for iter_156_4 = 0, var_156_10 - 1 do
					local var_156_11 = var_156_8:GetChild(iter_156_4)

					if var_156_11.name == "" or not string.find(var_156_11.name, "split") then
						var_156_11.gameObject:SetActive(true)
					else
						var_156_11.gameObject:SetActive(false)
					end
				end
			end

			local var_156_12 = 0.001

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_12 then
				local var_156_13 = (arg_153_1.time_ - var_156_9) / var_156_12
				local var_156_14 = Vector3.New(0, -380, -100)

				var_156_8.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10122, var_156_14, var_156_13)
			end

			if arg_153_1.time_ >= var_156_9 + var_156_12 and arg_153_1.time_ < var_156_9 + var_156_12 + arg_156_0 then
				var_156_8.localPosition = Vector3.New(0, -380, -100)
			end

			local var_156_15 = 0
			local var_156_16 = 0.275

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_17 = arg_153_1:FormatText(StoryNameCfg[8].name)

				arg_153_1.leftNameTxt_.text = var_156_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_18 = arg_153_1:GetWordFromCfg(416172037)
				local var_156_19 = arg_153_1:FormatText(var_156_18.content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_20 = 11
				local var_156_21 = utf8.len(var_156_19)
				local var_156_22 = var_156_20 <= 0 and var_156_16 or var_156_16 * (var_156_21 / var_156_20)

				if var_156_22 > 0 and var_156_16 < var_156_22 then
					arg_153_1.talkMaxDuration = var_156_22

					if var_156_22 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_22 + var_156_15
					end
				end

				arg_153_1.text_.text = var_156_19
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172037", "story_v_out_416172.awb") ~= 0 then
					local var_156_23 = manager.audio:GetVoiceLength("story_v_out_416172", "416172037", "story_v_out_416172.awb") / 1000

					if var_156_23 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_15
					end

					if var_156_18.prefab_name ~= "" and arg_153_1.actors_[var_156_18.prefab_name] ~= nil then
						local var_156_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_18.prefab_name].transform, "story_v_out_416172", "416172037", "story_v_out_416172.awb")

						arg_153_1:RecordAudio("416172037", var_156_24)
						arg_153_1:RecordAudio("416172037", var_156_24)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416172", "416172037", "story_v_out_416172.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416172", "416172037", "story_v_out_416172.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_25 = math.max(var_156_16, arg_153_1.talkMaxDuration)

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_25 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_25

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_25 and arg_153_1.time_ < var_156_15 + var_156_25 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416172038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416172038
		arg_157_1.duration_ = 3.7

		local var_157_0 = {
			zh = 3.033,
			ja = 3.7
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
				arg_157_0:Play416172039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.4

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[8].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(416172038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 16
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172038", "story_v_out_416172.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_416172", "416172038", "story_v_out_416172.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_416172", "416172038", "story_v_out_416172.awb")

						arg_157_1:RecordAudio("416172038", var_160_9)
						arg_157_1:RecordAudio("416172038", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_416172", "416172038", "story_v_out_416172.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_416172", "416172038", "story_v_out_416172.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play416172039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 416172039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play416172040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10122"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10122 == nil then
				arg_161_1.var_.actorSpriteComps10122 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps10122 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10122 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10122 = nil
			end

			local var_164_8 = arg_161_1.actors_["10122"].transform
			local var_164_9 = 0

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 then
				arg_161_1.var_.moveOldPos10122 = var_164_8.localPosition
				var_164_8.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10122", 7)

				local var_164_10 = var_164_8.childCount

				for iter_164_4 = 0, var_164_10 - 1 do
					local var_164_11 = var_164_8:GetChild(iter_164_4)

					if var_164_11.name == "" or not string.find(var_164_11.name, "split") then
						var_164_11.gameObject:SetActive(true)
					else
						var_164_11.gameObject:SetActive(false)
					end
				end
			end

			local var_164_12 = 0.001

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_12 then
				local var_164_13 = (arg_161_1.time_ - var_164_9) / var_164_12
				local var_164_14 = Vector3.New(0, -2000, 0)

				var_164_8.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10122, var_164_14, var_164_13)
			end

			if arg_161_1.time_ >= var_164_9 + var_164_12 and arg_161_1.time_ < var_164_9 + var_164_12 + arg_164_0 then
				var_164_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_164_15 = 0
			local var_164_16 = 1.625

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_17 = arg_161_1:GetWordFromCfg(416172039)
				local var_164_18 = arg_161_1:FormatText(var_164_17.content)

				arg_161_1.text_.text = var_164_18

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_19 = 65
				local var_164_20 = utf8.len(var_164_18)
				local var_164_21 = var_164_19 <= 0 and var_164_16 or var_164_16 * (var_164_20 / var_164_19)

				if var_164_21 > 0 and var_164_16 < var_164_21 then
					arg_161_1.talkMaxDuration = var_164_21

					if var_164_21 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_21 + var_164_15
					end
				end

				arg_161_1.text_.text = var_164_18
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_22 = math.max(var_164_16, arg_161_1.talkMaxDuration)

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_22 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_15) / var_164_22

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_15 + var_164_22 and arg_161_1.time_ < var_164_15 + var_164_22 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416172040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416172040
		arg_165_1.duration_ = 3.2

		local var_165_0 = {
			zh = 1.7,
			ja = 3.2
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
				arg_165_0:Play416172041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.175

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
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(416172040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172040", "story_v_out_416172.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_416172", "416172040", "story_v_out_416172.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_416172", "416172040", "story_v_out_416172.awb")

						arg_165_1:RecordAudio("416172040", var_168_9)
						arg_165_1:RecordAudio("416172040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416172", "416172040", "story_v_out_416172.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416172", "416172040", "story_v_out_416172.awb")
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
	Play416172041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416172041
		arg_169_1.duration_ = 5.8

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play416172042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10127"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps10127 == nil then
				arg_169_1.var_.actorSpriteComps10127 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps10127 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps10127 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10127 = nil
			end

			local var_172_8 = 0

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_9 = 0.3

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_9 then
				local var_172_10 = (arg_169_1.time_ - var_172_8) / var_172_9
				local var_172_11 = Color.New(1, 1, 1)

				var_172_11.a = Mathf.Lerp(1, 0, var_172_10)
				arg_169_1.mask_.color = var_172_11
			end

			if arg_169_1.time_ >= var_172_8 + var_172_9 and arg_169_1.time_ < var_172_8 + var_172_9 + arg_172_0 then
				local var_172_12 = Color.New(1, 1, 1)
				local var_172_13 = 0

				arg_169_1.mask_.enabled = false
				var_172_12.a = var_172_13
				arg_169_1.mask_.color = var_172_12
			end

			local var_172_14 = 0.3

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_15 = 0.266666666666667

			if var_172_14 <= arg_169_1.time_ and arg_169_1.time_ < var_172_14 + var_172_15 then
				local var_172_16 = (arg_169_1.time_ - var_172_14) / var_172_15
				local var_172_17 = Color.New(1, 1, 1)

				var_172_17.a = Mathf.Lerp(1, 0, var_172_16)
				arg_169_1.mask_.color = var_172_17
			end

			if arg_169_1.time_ >= var_172_14 + var_172_15 and arg_169_1.time_ < var_172_14 + var_172_15 + arg_172_0 then
				local var_172_18 = Color.New(1, 1, 1)
				local var_172_19 = 0

				arg_169_1.mask_.enabled = false
				var_172_18.a = var_172_19
				arg_169_1.mask_.color = var_172_18
			end

			local var_172_20 = 0

			if var_172_20 < arg_169_1.time_ and arg_169_1.time_ <= var_172_20 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			local var_172_21 = 0.8

			if arg_169_1.time_ >= var_172_20 + var_172_21 and arg_169_1.time_ < var_172_20 + var_172_21 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end

			local var_172_22 = 0.3
			local var_172_23 = 1

			if var_172_22 < arg_169_1.time_ and arg_169_1.time_ <= var_172_22 + arg_172_0 then
				local var_172_24 = "play"
				local var_172_25 = "effect"

				arg_169_1:AudioAction(var_172_24, var_172_25, "se_story_139", "se_story_139_waterimpact", "")
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_26 = 0.8
			local var_172_27 = 1.4

			if var_172_26 < arg_169_1.time_ and arg_169_1.time_ <= var_172_26 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_28 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_28:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_29 = arg_169_1:GetWordFromCfg(416172041)
				local var_172_30 = arg_169_1:FormatText(var_172_29.content)

				arg_169_1.text_.text = var_172_30

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_31 = 56
				local var_172_32 = utf8.len(var_172_30)
				local var_172_33 = var_172_31 <= 0 and var_172_27 or var_172_27 * (var_172_32 / var_172_31)

				if var_172_33 > 0 and var_172_27 < var_172_33 then
					arg_169_1.talkMaxDuration = var_172_33
					var_172_26 = var_172_26 + 0.3

					if var_172_33 + var_172_26 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_33 + var_172_26
					end
				end

				arg_169_1.text_.text = var_172_30
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_34 = var_172_26 + 0.3
			local var_172_35 = math.max(var_172_27, arg_169_1.talkMaxDuration)

			if var_172_34 <= arg_169_1.time_ and arg_169_1.time_ < var_172_34 + var_172_35 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_34) / var_172_35

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_34 + var_172_35 and arg_169_1.time_ < var_172_34 + var_172_35 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play416172042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 416172042
		arg_175_1.duration_ = 6.1

		local var_175_0 = {
			zh = 3.6,
			ja = 6.1
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play416172043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.35

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[36].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(416172042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 14
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172042", "story_v_out_416172.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_416172", "416172042", "story_v_out_416172.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_416172", "416172042", "story_v_out_416172.awb")

						arg_175_1:RecordAudio("416172042", var_178_9)
						arg_175_1:RecordAudio("416172042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_416172", "416172042", "story_v_out_416172.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_416172", "416172042", "story_v_out_416172.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_10 and arg_175_1.time_ < var_178_0 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play416172043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 416172043
		arg_179_1.duration_ = 6.47

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play416172044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = "1019"

			if arg_179_1.actors_[var_182_0] == nil then
				local var_182_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1019")

				if not isNil(var_182_1) then
					local var_182_2 = Object.Instantiate(var_182_1, arg_179_1.canvasGo_.transform)

					var_182_2.transform:SetSiblingIndex(1)

					var_182_2.name = var_182_0
					var_182_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_179_1.actors_[var_182_0] = var_182_2

					local var_182_3 = var_182_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_179_1.isInRecall_ then
						for iter_182_0, iter_182_1 in ipairs(var_182_3) do
							iter_182_1.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_182_4 = arg_179_1.actors_["1019"]
			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.actorSpriteComps1019 == nil then
				arg_179_1.var_.actorSpriteComps1019 = var_182_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_6 = 0.2

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_6 and not isNil(var_182_4) then
				local var_182_7 = (arg_179_1.time_ - var_182_5) / var_182_6

				if arg_179_1.var_.actorSpriteComps1019 then
					for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_182_3 then
							if arg_179_1.isInRecall_ then
								local var_182_8 = Mathf.Lerp(iter_182_3.color.r, arg_179_1.hightColor2.r, var_182_7)
								local var_182_9 = Mathf.Lerp(iter_182_3.color.g, arg_179_1.hightColor2.g, var_182_7)
								local var_182_10 = Mathf.Lerp(iter_182_3.color.b, arg_179_1.hightColor2.b, var_182_7)

								iter_182_3.color = Color.New(var_182_8, var_182_9, var_182_10)
							else
								local var_182_11 = Mathf.Lerp(iter_182_3.color.r, 0.5, var_182_7)

								iter_182_3.color = Color.New(var_182_11, var_182_11, var_182_11)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_5 + var_182_6 and arg_179_1.time_ < var_182_5 + var_182_6 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.actorSpriteComps1019 then
				for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_182_5 then
						if arg_179_1.isInRecall_ then
							iter_182_5.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1019 = nil
			end

			local var_182_12 = manager.ui.mainCamera.transform
			local var_182_13 = 0

			if var_182_13 < arg_179_1.time_ and arg_179_1.time_ <= var_182_13 + arg_182_0 then
				arg_179_1.var_.shakeOldPos = var_182_12.localPosition
			end

			local var_182_14 = 0.733333333333333

			if var_182_13 <= arg_179_1.time_ and arg_179_1.time_ < var_182_13 + var_182_14 then
				local var_182_15 = (arg_179_1.time_ - var_182_13) / 0.066
				local var_182_16, var_182_17 = math.modf(var_182_15)

				var_182_12.localPosition = Vector3.New(var_182_17 * 0.13, var_182_17 * 0.13, var_182_17 * 0.13) + arg_179_1.var_.shakeOldPos
			end

			if arg_179_1.time_ >= var_182_13 + var_182_14 and arg_179_1.time_ < var_182_13 + var_182_14 + arg_182_0 then
				var_182_12.localPosition = arg_179_1.var_.shakeOldPos
			end

			local var_182_18 = 0.5

			if var_182_18 < arg_179_1.time_ and arg_179_1.time_ <= var_182_18 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = true

				arg_179_1:SetGaussion(false)
			end

			local var_182_19 = 0.966666666666667

			if var_182_18 <= arg_179_1.time_ and arg_179_1.time_ < var_182_18 + var_182_19 then
				local var_182_20 = (arg_179_1.time_ - var_182_18) / var_182_19
				local var_182_21 = Color.New(0.4150943, 0.02936988, 0.02936988)

				var_182_21.a = Mathf.Lerp(1, 0, var_182_20)
				arg_179_1.mask_.color = var_182_21
			end

			if arg_179_1.time_ >= var_182_18 + var_182_19 and arg_179_1.time_ < var_182_18 + var_182_19 + arg_182_0 then
				local var_182_22 = Color.New(0.4150943, 0.02936988, 0.02936988)
				local var_182_23 = 0

				arg_179_1.mask_.enabled = false
				var_182_22.a = var_182_23
				arg_179_1.mask_.color = var_182_22
			end

			local var_182_24 = 0

			if var_182_24 < arg_179_1.time_ and arg_179_1.time_ <= var_182_24 + arg_182_0 then
				arg_179_1.allBtn_.enabled = false
			end

			local var_182_25 = 1.66666666666667

			if arg_179_1.time_ >= var_182_24 + var_182_25 and arg_179_1.time_ < var_182_24 + var_182_25 + arg_182_0 then
				arg_179_1.allBtn_.enabled = true
			end

			local var_182_26 = 0.666666666666667
			local var_182_27 = 1

			if var_182_26 < arg_179_1.time_ and arg_179_1.time_ <= var_182_26 + arg_182_0 then
				local var_182_28 = "play"
				local var_182_29 = "effect"

				arg_179_1:AudioAction(var_182_28, var_182_29, "se_story_side_1039", "se_story_1039_water", "")
			end

			if arg_179_1.frameCnt_ <= 1 then
				arg_179_1.dialog_:SetActive(false)
			end

			local var_182_30 = 1.46666666666667
			local var_182_31 = 1.825

			if var_182_30 < arg_179_1.time_ and arg_179_1.time_ <= var_182_30 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_32 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_32:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_33 = arg_179_1:GetWordFromCfg(416172043)
				local var_182_34 = arg_179_1:FormatText(var_182_33.content)

				arg_179_1.text_.text = var_182_34

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_35 = 73
				local var_182_36 = utf8.len(var_182_34)
				local var_182_37 = var_182_35 <= 0 and var_182_31 or var_182_31 * (var_182_36 / var_182_35)

				if var_182_37 > 0 and var_182_31 < var_182_37 then
					arg_179_1.talkMaxDuration = var_182_37
					var_182_30 = var_182_30 + 0.3

					if var_182_37 + var_182_30 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_37 + var_182_30
					end
				end

				arg_179_1.text_.text = var_182_34
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_38 = var_182_30 + 0.3
			local var_182_39 = math.max(var_182_31, arg_179_1.talkMaxDuration)

			if var_182_38 <= arg_179_1.time_ and arg_179_1.time_ < var_182_38 + var_182_39 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_38) / var_182_39

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_38 + var_182_39 and arg_179_1.time_ < var_182_38 + var_182_39 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play416172044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416172044
		arg_185_1.duration_ = 2.7

		local var_185_0 = {
			zh = 1.833,
			ja = 2.7
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
				arg_185_0:Play416172045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10127"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10127 == nil then
				arg_185_1.var_.actorSpriteComps10127 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps10127 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								local var_188_4 = Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor1.r, var_188_3)
								local var_188_5 = Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor1.g, var_188_3)
								local var_188_6 = Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor1.b, var_188_3)

								iter_188_1.color = Color.New(var_188_4, var_188_5, var_188_6)
							else
								local var_188_7 = Mathf.Lerp(iter_188_1.color.r, 1, var_188_3)

								iter_188_1.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10127 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10127 = nil
			end

			local var_188_8 = 0
			local var_188_9 = 0.125

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_10 = arg_185_1:FormatText(StoryNameCfg[236].name)

				arg_185_1.leftNameTxt_.text = var_188_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_5")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_11 = arg_185_1:GetWordFromCfg(416172044)
				local var_188_12 = arg_185_1:FormatText(var_188_11.content)

				arg_185_1.text_.text = var_188_12

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 5
				local var_188_14 = utf8.len(var_188_12)
				local var_188_15 = var_188_13 <= 0 and var_188_9 or var_188_9 * (var_188_14 / var_188_13)

				if var_188_15 > 0 and var_188_9 < var_188_15 then
					arg_185_1.talkMaxDuration = var_188_15

					if var_188_15 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_15 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_12
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172044", "story_v_out_416172.awb") ~= 0 then
					local var_188_16 = manager.audio:GetVoiceLength("story_v_out_416172", "416172044", "story_v_out_416172.awb") / 1000

					if var_188_16 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_16 + var_188_8
					end

					if var_188_11.prefab_name ~= "" and arg_185_1.actors_[var_188_11.prefab_name] ~= nil then
						local var_188_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_11.prefab_name].transform, "story_v_out_416172", "416172044", "story_v_out_416172.awb")

						arg_185_1:RecordAudio("416172044", var_188_17)
						arg_185_1:RecordAudio("416172044", var_188_17)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_416172", "416172044", "story_v_out_416172.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_416172", "416172044", "story_v_out_416172.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_18 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_18 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_18

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_18 and arg_185_1.time_ < var_188_8 + var_188_18 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play416172045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416172045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play416172046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 1.475

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(416172045)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 59
				local var_192_5 = utf8.len(var_192_3)
				local var_192_6 = var_192_4 <= 0 and var_192_1 or var_192_1 * (var_192_5 / var_192_4)

				if var_192_6 > 0 and var_192_1 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_7 and arg_189_1.time_ < var_192_0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play416172046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416172046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play416172047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 1.85

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(416172046)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 74
				local var_196_5 = utf8.len(var_196_3)
				local var_196_6 = var_196_4 <= 0 and var_196_1 or var_196_1 * (var_196_5 / var_196_4)

				if var_196_6 > 0 and var_196_1 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_7 and arg_193_1.time_ < var_196_0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play416172047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 416172047
		arg_197_1.duration_ = 13.47

		local var_197_0 = {
			zh = 5.766,
			ja = 13.466
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
			arg_197_1.auto_ = false
		end

		function arg_197_1.playNext_(arg_199_0)
			arg_197_1.onStoryFinished_()
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.allBtn_.enabled = false
			end

			local var_200_1 = 2.9

			if arg_197_1.time_ >= var_200_0 + var_200_1 and arg_197_1.time_ < var_200_0 + var_200_1 + arg_200_0 then
				arg_197_1.allBtn_.enabled = true
			end

			local var_200_2 = 0
			local var_200_3 = 0.35

			if var_200_2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_4 = arg_197_1:FormatText(StoryNameCfg[36].name)

				arg_197_1.leftNameTxt_.text = var_200_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_5 = arg_197_1:GetWordFromCfg(416172047)
				local var_200_6 = arg_197_1:FormatText(var_200_5.content)

				arg_197_1.text_.text = var_200_6

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 14
				local var_200_8 = utf8.len(var_200_6)
				local var_200_9 = var_200_7 <= 0 and var_200_3 or var_200_3 * (var_200_8 / var_200_7)

				if var_200_9 > 0 and var_200_3 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_2
					end
				end

				arg_197_1.text_.text = var_200_6
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416172", "416172047", "story_v_out_416172.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_out_416172", "416172047", "story_v_out_416172.awb") / 1000

					if var_200_10 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_2
					end

					if var_200_5.prefab_name ~= "" and arg_197_1.actors_[var_200_5.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_5.prefab_name].transform, "story_v_out_416172", "416172047", "story_v_out_416172.awb")

						arg_197_1:RecordAudio("416172047", var_200_11)
						arg_197_1:RecordAudio("416172047", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_416172", "416172047", "story_v_out_416172.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_416172", "416172047", "story_v_out_416172.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_3, arg_197_1.talkMaxDuration)

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_2) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_2 + var_200_12 and arg_197_1.time_ < var_200_2 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I13i"
	},
	voices = {
		"story_v_out_416172.awb"
	}
}
