return {
	Play418101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418101001
		arg_1_1.duration_ = 9.8

		local var_1_0 = {
			ja = 9.7,
			CriLanguages = 9.8,
			zh = 9.8
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
				arg_1_0:Play418101002(arg_1_1)
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

			local var_4_24 = ""

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "")

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

			local var_4_28 = arg_1_1.actors_[""]
			local var_4_29 = 0

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps == nil then
				arg_1_1.var_.actorSpriteComps = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps = nil
			end

			local var_4_36 = 0.05
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_140", "se_story_140_amb_harbor", "")
			end

			local var_4_40 = 0.2
			local var_4_41 = 0.2

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "music"

				arg_1_1:AudioAction(var_4_42, var_4_43, "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily.awb")

				local var_4_44 = ""
				local var_4_45 = manager.audio:GetAudioName("bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily")

				if var_4_45 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_45 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_45

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_45
						arg_1_1.bgmTxt2_.text = var_4_45
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

			local var_4_46 = 2
			local var_4_47 = 0.65

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_48 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_48:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_49 = arg_1_1:FormatText(StoryNameCfg[1188].name)

				arg_1_1.leftNameTxt_.text = var_4_49

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

				local var_4_50 = arg_1_1:GetWordFromCfg(418101001)
				local var_4_51 = arg_1_1:FormatText(var_4_50.content)

				arg_1_1.text_.text = var_4_51

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_52 = 26
				local var_4_53 = utf8.len(var_4_51)
				local var_4_54 = var_4_52 <= 0 and var_4_47 or var_4_47 * (var_4_53 / var_4_52)

				if var_4_54 > 0 and var_4_47 < var_4_54 then
					arg_1_1.talkMaxDuration = var_4_54
					var_4_46 = var_4_46 + 0.3

					if var_4_54 + var_4_46 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_54 + var_4_46
					end
				end

				arg_1_1.text_.text = var_4_51
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101001", "story_v_side_old_418101.awb") ~= 0 then
					local var_4_55 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101001", "story_v_side_old_418101.awb") / 1000

					if var_4_55 + var_4_46 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_55 + var_4_46
					end

					if var_4_50.prefab_name ~= "" and arg_1_1.actors_[var_4_50.prefab_name] ~= nil then
						local var_4_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_50.prefab_name].transform, "story_v_side_old_418101", "418101001", "story_v_side_old_418101.awb")

						arg_1_1:RecordAudio("418101001", var_4_56)
						arg_1_1:RecordAudio("418101001", var_4_56)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101001", "story_v_side_old_418101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101001", "story_v_side_old_418101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_57 = var_4_46 + 0.3
			local var_4_58 = math.max(var_4_47, arg_1_1.talkMaxDuration)

			if var_4_57 <= arg_1_1.time_ and arg_1_1.time_ < var_4_57 + var_4_58 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_57) / var_4_58

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_57 + var_4_58 and arg_1_1.time_ < var_4_57 + var_4_58 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play418101002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418101002
		arg_8_1.duration_ = 8.27

		local var_8_0 = {
			ja = 8.266,
			CriLanguages = 7.9,
			zh = 7.9
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
				arg_8_0:Play418101003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.7

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[1188].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(418101002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 28
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101002", "story_v_side_old_418101.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101002", "story_v_side_old_418101.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_side_old_418101", "418101002", "story_v_side_old_418101.awb")

						arg_8_1:RecordAudio("418101002", var_11_9)
						arg_8_1:RecordAudio("418101002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101002", "story_v_side_old_418101.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101002", "story_v_side_old_418101.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play418101003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418101003
		arg_12_1.duration_ = 7.47

		local var_12_0 = {
			ja = 7.466,
			CriLanguages = 5.533,
			zh = 5.533
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
				arg_12_0:Play418101004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.575

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[1188].name)

				arg_12_1.leftNameTxt_.text = var_15_2

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

				local var_15_3 = arg_12_1:GetWordFromCfg(418101003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 23
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101003", "story_v_side_old_418101.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101003", "story_v_side_old_418101.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_side_old_418101", "418101003", "story_v_side_old_418101.awb")

						arg_12_1:RecordAudio("418101003", var_15_9)
						arg_12_1:RecordAudio("418101003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101003", "story_v_side_old_418101.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101003", "story_v_side_old_418101.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_10 and arg_12_1.time_ < var_15_0 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play418101004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418101004
		arg_16_1.duration_ = 12.73

		local var_16_0 = {
			ja = 12.733,
			CriLanguages = 9.9,
			zh = 9.9
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
				arg_16_0:Play418101005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.025

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[1188].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(418101004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 41
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101004", "story_v_side_old_418101.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101004", "story_v_side_old_418101.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_side_old_418101", "418101004", "story_v_side_old_418101.awb")

						arg_16_1:RecordAudio("418101004", var_19_9)
						arg_16_1:RecordAudio("418101004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101004", "story_v_side_old_418101.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101004", "story_v_side_old_418101.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play418101005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418101005
		arg_20_1.duration_ = 4.27

		local var_20_0 = {
			ja = 3.833,
			CriLanguages = 4.266,
			zh = 4.266
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
				arg_20_0:Play418101006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "10135"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10135")

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

			local var_23_4 = arg_20_1.actors_["10135"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.actorSpriteComps10135 == nil then
				arg_20_1.var_.actorSpriteComps10135 = var_23_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_6 = 0.2

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.actorSpriteComps10135 then
					for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.actorSpriteComps10135 then
				for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_23_5 then
						if arg_20_1.isInRecall_ then
							iter_23_5.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_23_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps10135 = nil
			end

			local var_23_12 = arg_20_1.actors_["10135"].transform
			local var_23_13 = 0

			if var_23_13 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 then
				arg_20_1.var_.moveOldPos10135 = var_23_12.localPosition
				var_23_12.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("10135", 3)

				local var_23_14 = var_23_12.childCount

				for iter_23_6 = 0, var_23_14 - 1 do
					local var_23_15 = var_23_12:GetChild(iter_23_6)

					if var_23_15.name == "" or not string.find(var_23_15.name, "split") then
						var_23_15.gameObject:SetActive(true)
					else
						var_23_15.gameObject:SetActive(false)
					end
				end
			end

			local var_23_16 = 0.001

			if var_23_13 <= arg_20_1.time_ and arg_20_1.time_ < var_23_13 + var_23_16 then
				local var_23_17 = (arg_20_1.time_ - var_23_13) / var_23_16
				local var_23_18 = Vector3.New(-12.7, -363.6, -305.9)

				var_23_12.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10135, var_23_18, var_23_17)
			end

			if arg_20_1.time_ >= var_23_13 + var_23_16 and arg_20_1.time_ < var_23_13 + var_23_16 + arg_23_0 then
				var_23_12.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_23_19 = 0
			local var_23_20 = 0.5

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_21 = arg_20_1:FormatText(StoryNameCfg[1187].name)

				arg_20_1.leftNameTxt_.text = var_23_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_22 = arg_20_1:GetWordFromCfg(418101005)
				local var_23_23 = arg_20_1:FormatText(var_23_22.content)

				arg_20_1.text_.text = var_23_23

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_24 = 20
				local var_23_25 = utf8.len(var_23_23)
				local var_23_26 = var_23_24 <= 0 and var_23_20 or var_23_20 * (var_23_25 / var_23_24)

				if var_23_26 > 0 and var_23_20 < var_23_26 then
					arg_20_1.talkMaxDuration = var_23_26

					if var_23_26 + var_23_19 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_26 + var_23_19
					end
				end

				arg_20_1.text_.text = var_23_23
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101005", "story_v_side_old_418101.awb") ~= 0 then
					local var_23_27 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101005", "story_v_side_old_418101.awb") / 1000

					if var_23_27 + var_23_19 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_27 + var_23_19
					end

					if var_23_22.prefab_name ~= "" and arg_20_1.actors_[var_23_22.prefab_name] ~= nil then
						local var_23_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_22.prefab_name].transform, "story_v_side_old_418101", "418101005", "story_v_side_old_418101.awb")

						arg_20_1:RecordAudio("418101005", var_23_28)
						arg_20_1:RecordAudio("418101005", var_23_28)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101005", "story_v_side_old_418101.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101005", "story_v_side_old_418101.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_29 = math.max(var_23_20, arg_20_1.talkMaxDuration)

			if var_23_19 <= arg_20_1.time_ and arg_20_1.time_ < var_23_19 + var_23_29 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_19) / var_23_29

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_19 + var_23_29 and arg_20_1.time_ < var_23_19 + var_23_29 + arg_23_0 then
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
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play418101006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418101006
		arg_24_1.duration_ = 3.47

		local var_24_0 = {
			ja = 3.466,
			CriLanguages = 2.666,
			zh = 2.666
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
				arg_24_0:Play418101007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.325

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[1187].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(418101006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 13
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101006", "story_v_side_old_418101.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101006", "story_v_side_old_418101.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_side_old_418101", "418101006", "story_v_side_old_418101.awb")

						arg_24_1:RecordAudio("418101006", var_27_9)
						arg_24_1:RecordAudio("418101006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101006", "story_v_side_old_418101.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101006", "story_v_side_old_418101.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play418101007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 418101007
		arg_28_1.duration_ = 7.1

		local var_28_0 = {
			ja = 7.1,
			CriLanguages = 4.366,
			zh = 4.366
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
				arg_28_0:Play418101008(arg_28_1)
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
			local var_31_9 = 0.45

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

				local var_31_11 = arg_28_1:GetWordFromCfg(418101007)
				local var_31_12 = arg_28_1:FormatText(var_31_11.content)

				arg_28_1.text_.text = var_31_12

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 18
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

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101007", "story_v_side_old_418101.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101007", "story_v_side_old_418101.awb") / 1000

					if var_31_16 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_8
					end

					if var_31_11.prefab_name ~= "" and arg_28_1.actors_[var_31_11.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_11.prefab_name].transform, "story_v_side_old_418101", "418101007", "story_v_side_old_418101.awb")

						arg_28_1:RecordAudio("418101007", var_31_17)
						arg_28_1:RecordAudio("418101007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101007", "story_v_side_old_418101.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101007", "story_v_side_old_418101.awb")
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
	Play418101008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 418101008
		arg_32_1.duration_ = 6.63

		local var_32_0 = {
			ja = 6.6,
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
				arg_32_0:Play418101009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.75

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

				local var_35_3 = arg_32_1:GetWordFromCfg(418101008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101008", "story_v_side_old_418101.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101008", "story_v_side_old_418101.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_side_old_418101", "418101008", "story_v_side_old_418101.awb")

						arg_32_1:RecordAudio("418101008", var_35_9)
						arg_32_1:RecordAudio("418101008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101008", "story_v_side_old_418101.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101008", "story_v_side_old_418101.awb")
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
	Play418101009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 418101009
		arg_36_1.duration_ = 2.63

		local var_36_0 = {
			ja = 2.633,
			CriLanguages = 1.533,
			zh = 1.533
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
				arg_36_0:Play418101010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10135"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps10135 == nil then
				arg_36_1.var_.actorSpriteComps10135 = var_39_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.actorSpriteComps10135 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps10135 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_39_3 then
						if arg_36_1.isInRecall_ then
							iter_39_3.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_39_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps10135 = nil
			end

			local var_39_8 = arg_36_1.actors_["10135"].transform
			local var_39_9 = 0

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 then
				arg_36_1.var_.moveOldPos10135 = var_39_8.localPosition
				var_39_8.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("10135", 3)

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
				local var_39_14 = Vector3.New(-12.7, -363.6, -305.9)

				var_39_8.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10135, var_39_14, var_39_13)
			end

			if arg_36_1.time_ >= var_39_9 + var_39_12 and arg_36_1.time_ < var_39_9 + var_39_12 + arg_39_0 then
				var_39_8.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_39_15 = 0
			local var_39_16 = 0.1

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_17 = arg_36_1:FormatText(StoryNameCfg[1187].name)

				arg_36_1.leftNameTxt_.text = var_39_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_18 = arg_36_1:GetWordFromCfg(418101009)
				local var_39_19 = arg_36_1:FormatText(var_39_18.content)

				arg_36_1.text_.text = var_39_19

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_20 = 4
				local var_39_21 = utf8.len(var_39_19)
				local var_39_22 = var_39_20 <= 0 and var_39_16 or var_39_16 * (var_39_21 / var_39_20)

				if var_39_22 > 0 and var_39_16 < var_39_22 then
					arg_36_1.talkMaxDuration = var_39_22

					if var_39_22 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_22 + var_39_15
					end
				end

				arg_36_1.text_.text = var_39_19
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101009", "story_v_side_old_418101.awb") ~= 0 then
					local var_39_23 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101009", "story_v_side_old_418101.awb") / 1000

					if var_39_23 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_15
					end

					if var_39_18.prefab_name ~= "" and arg_36_1.actors_[var_39_18.prefab_name] ~= nil then
						local var_39_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_18.prefab_name].transform, "story_v_side_old_418101", "418101009", "story_v_side_old_418101.awb")

						arg_36_1:RecordAudio("418101009", var_39_24)
						arg_36_1:RecordAudio("418101009", var_39_24)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101009", "story_v_side_old_418101.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101009", "story_v_side_old_418101.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_25 = math.max(var_39_16, arg_36_1.talkMaxDuration)

			if var_39_15 <= arg_36_1.time_ and arg_36_1.time_ < var_39_15 + var_39_25 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_15) / var_39_25

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_15 + var_39_25 and arg_36_1.time_ < var_39_15 + var_39_25 + arg_39_0 then
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
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play418101010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 418101010
		arg_40_1.duration_ = 10.07

		local var_40_0 = {
			ja = 10.066,
			CriLanguages = 6.233,
			zh = 6.233
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
				arg_40_0:Play418101011(arg_40_1)
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

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10135 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_43_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps10135 = nil
			end

			local var_43_8 = 0
			local var_43_9 = 0.6

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

				local var_43_11 = arg_40_1:GetWordFromCfg(418101010)
				local var_43_12 = arg_40_1:FormatText(var_43_11.content)

				arg_40_1.text_.text = var_43_12

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_13 = 24
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

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101010", "story_v_side_old_418101.awb") ~= 0 then
					local var_43_16 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101010", "story_v_side_old_418101.awb") / 1000

					if var_43_16 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_16 + var_43_8
					end

					if var_43_11.prefab_name ~= "" and arg_40_1.actors_[var_43_11.prefab_name] ~= nil then
						local var_43_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_11.prefab_name].transform, "story_v_side_old_418101", "418101010", "story_v_side_old_418101.awb")

						arg_40_1:RecordAudio("418101010", var_43_17)
						arg_40_1:RecordAudio("418101010", var_43_17)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101010", "story_v_side_old_418101.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101010", "story_v_side_old_418101.awb")
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
	Play418101011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 418101011
		arg_44_1.duration_ = 13.4

		local var_44_0 = {
			ja = 13.4,
			CriLanguages = 10,
			zh = 10
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
				arg_44_0:Play418101012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.05

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

				local var_47_3 = arg_44_1:GetWordFromCfg(418101011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101011", "story_v_side_old_418101.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101011", "story_v_side_old_418101.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_side_old_418101", "418101011", "story_v_side_old_418101.awb")

						arg_44_1:RecordAudio("418101011", var_47_9)
						arg_44_1:RecordAudio("418101011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101011", "story_v_side_old_418101.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101011", "story_v_side_old_418101.awb")
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
	Play418101012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 418101012
		arg_48_1.duration_ = 3.17

		local var_48_0 = {
			ja = 3.166,
			CriLanguages = 2.866,
			zh = 2.866
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
				arg_48_0:Play418101013(arg_48_1)
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

			local var_51_8 = arg_48_1.actors_["10135"].transform
			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.var_.moveOldPos10135 = var_51_8.localPosition
				var_51_8.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("10135", 3)

				local var_51_10 = var_51_8.childCount

				for iter_51_4 = 0, var_51_10 - 1 do
					local var_51_11 = var_51_8:GetChild(iter_51_4)

					if var_51_11.name == "split_5" or not string.find(var_51_11.name, "split") then
						var_51_11.gameObject:SetActive(true)
					else
						var_51_11.gameObject:SetActive(false)
					end
				end
			end

			local var_51_12 = 0.001

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_9) / var_51_12
				local var_51_14 = Vector3.New(-12.7, -363.6, -305.9)

				var_51_8.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10135, var_51_14, var_51_13)
			end

			if arg_48_1.time_ >= var_51_9 + var_51_12 and arg_48_1.time_ < var_51_9 + var_51_12 + arg_51_0 then
				var_51_8.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_51_15 = 0
			local var_51_16 = 0.275

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[1187].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_18 = arg_48_1:GetWordFromCfg(418101012)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 11
				local var_51_21 = utf8.len(var_51_19)
				local var_51_22 = var_51_20 <= 0 and var_51_16 or var_51_16 * (var_51_21 / var_51_20)

				if var_51_22 > 0 and var_51_16 < var_51_22 then
					arg_48_1.talkMaxDuration = var_51_22

					if var_51_22 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_22 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_19
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101012", "story_v_side_old_418101.awb") ~= 0 then
					local var_51_23 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101012", "story_v_side_old_418101.awb") / 1000

					if var_51_23 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_15
					end

					if var_51_18.prefab_name ~= "" and arg_48_1.actors_[var_51_18.prefab_name] ~= nil then
						local var_51_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_18.prefab_name].transform, "story_v_side_old_418101", "418101012", "story_v_side_old_418101.awb")

						arg_48_1:RecordAudio("418101012", var_51_24)
						arg_48_1:RecordAudio("418101012", var_51_24)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101012", "story_v_side_old_418101.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101012", "story_v_side_old_418101.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_25 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_25 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_25

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_25 and arg_48_1.time_ < var_51_15 + var_51_25 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play418101013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 418101013
		arg_52_1.duration_ = 5.73

		local var_52_0 = {
			ja = 5.733,
			CriLanguages = 4.433,
			zh = 4.433
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
				arg_52_0:Play418101014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10135"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps10135 == nil then
				arg_52_1.var_.actorSpriteComps10135 = var_55_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.actorSpriteComps10135 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps10135 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_55_3 then
						if arg_52_1.isInRecall_ then
							iter_55_3.color = arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_55_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps10135 = nil
			end

			local var_55_8 = 0
			local var_55_9 = 0.325

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

				local var_55_11 = arg_52_1:GetWordFromCfg(418101013)
				local var_55_12 = arg_52_1:FormatText(var_55_11.content)

				arg_52_1.text_.text = var_55_12

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 13
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

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101013", "story_v_side_old_418101.awb") ~= 0 then
					local var_55_16 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101013", "story_v_side_old_418101.awb") / 1000

					if var_55_16 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_16 + var_55_8
					end

					if var_55_11.prefab_name ~= "" and arg_52_1.actors_[var_55_11.prefab_name] ~= nil then
						local var_55_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_11.prefab_name].transform, "story_v_side_old_418101", "418101013", "story_v_side_old_418101.awb")

						arg_52_1:RecordAudio("418101013", var_55_17)
						arg_52_1:RecordAudio("418101013", var_55_17)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101013", "story_v_side_old_418101.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101013", "story_v_side_old_418101.awb")
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
	Play418101014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 418101014
		arg_56_1.duration_ = 10.9

		local var_56_0 = {
			ja = 10.9,
			CriLanguages = 7.566,
			zh = 7.566
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
				arg_56_0:Play418101015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.75

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[1188].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(418101014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 30
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101014", "story_v_side_old_418101.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101014", "story_v_side_old_418101.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_side_old_418101", "418101014", "story_v_side_old_418101.awb")

						arg_56_1:RecordAudio("418101014", var_59_9)
						arg_56_1:RecordAudio("418101014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101014", "story_v_side_old_418101.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101014", "story_v_side_old_418101.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_10 and arg_56_1.time_ < var_59_0 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play418101015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 418101015
		arg_60_1.duration_ = 13.33

		local var_60_0 = {
			ja = 13.333,
			CriLanguages = 11.433,
			zh = 11.433
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
				arg_60_0:Play418101016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.975

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[1188].name)

				arg_60_1.leftNameTxt_.text = var_63_2

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

				local var_63_3 = arg_60_1:GetWordFromCfg(418101015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 39
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101015", "story_v_side_old_418101.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101015", "story_v_side_old_418101.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_side_old_418101", "418101015", "story_v_side_old_418101.awb")

						arg_60_1:RecordAudio("418101015", var_63_9)
						arg_60_1:RecordAudio("418101015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101015", "story_v_side_old_418101.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101015", "story_v_side_old_418101.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play418101016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 418101016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play418101017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10135"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos10135 = var_67_0.localPosition
				var_67_0.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10135", 7)

				local var_67_2 = var_67_0.childCount

				for iter_67_0 = 0, var_67_2 - 1 do
					local var_67_3 = var_67_0:GetChild(iter_67_0)

					if var_67_3.name == "" or not string.find(var_67_3.name, "split") then
						var_67_3.gameObject:SetActive(true)
					else
						var_67_3.gameObject:SetActive(false)
					end
				end
			end

			local var_67_4 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_4 then
				local var_67_5 = (arg_64_1.time_ - var_67_1) / var_67_4
				local var_67_6 = Vector3.New(0, -2000, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10135, var_67_6, var_67_5)
			end

			if arg_64_1.time_ >= var_67_1 + var_67_4 and arg_64_1.time_ < var_67_1 + var_67_4 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_67_7 = 0.034
			local var_67_8 = 0.966

			if var_67_7 < arg_64_1.time_ and arg_64_1.time_ <= var_67_7 + arg_67_0 then
				local var_67_9 = "play"
				local var_67_10 = "effect"

				arg_64_1:AudioAction(var_67_9, var_67_10, "se_story_140", "se_story_140_horn", "")
			end

			local var_67_11 = 0
			local var_67_12 = 0.475

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_13 = arg_64_1:GetWordFromCfg(418101016)
				local var_67_14 = arg_64_1:FormatText(var_67_13.content)

				arg_64_1.text_.text = var_67_14

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_15 = 19
				local var_67_16 = utf8.len(var_67_14)
				local var_67_17 = var_67_15 <= 0 and var_67_12 or var_67_12 * (var_67_16 / var_67_15)

				if var_67_17 > 0 and var_67_12 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17

					if var_67_17 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_14
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_18 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_18 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_11) / var_67_18

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_11 + var_67_18 and arg_64_1.time_ < var_67_11 + var_67_18 + arg_67_0 then
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
	Play418101017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 418101017
		arg_68_1.duration_ = 9.67

		local var_68_0 = {
			ja = 7.89933333333333,
			CriLanguages = 9.66633333333333,
			zh = 9.66633333333333
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
				arg_68_0:Play418101018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = "SS1801"

			if arg_68_1.bgs_[var_71_0] == nil then
				local var_71_1 = Object.Instantiate(arg_68_1.paintGo_)

				var_71_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_71_0)
				var_71_1.name = var_71_0
				var_71_1.transform.parent = arg_68_1.stage_.transform
				var_71_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.bgs_[var_71_0] = var_71_1
			end

			local var_71_2 = 1.98333333333333

			if var_71_2 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				local var_71_3 = manager.ui.mainCamera.transform.localPosition
				local var_71_4 = Vector3.New(0, 0, 10) + Vector3.New(var_71_3.x, var_71_3.y, 0)
				local var_71_5 = arg_68_1.bgs_.SS1801

				var_71_5.transform.localPosition = var_71_4
				var_71_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_71_6 = var_71_5:GetComponent("SpriteRenderer")

				if var_71_6 and var_71_6.sprite then
					local var_71_7 = (var_71_5.transform.localPosition - var_71_3).z
					local var_71_8 = manager.ui.mainCameraCom_
					local var_71_9 = 2 * var_71_7 * Mathf.Tan(var_71_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_71_10 = var_71_9 * var_71_8.aspect
					local var_71_11 = var_71_6.sprite.bounds.size.x
					local var_71_12 = var_71_6.sprite.bounds.size.y
					local var_71_13 = var_71_10 / var_71_11
					local var_71_14 = var_71_9 / var_71_12
					local var_71_15 = var_71_14 < var_71_13 and var_71_13 or var_71_14

					var_71_5.transform.localScale = Vector3.New(var_71_15, var_71_15, 0)
				end

				for iter_71_0, iter_71_1 in pairs(arg_68_1.bgs_) do
					if iter_71_0 ~= "SS1801" then
						iter_71_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.allBtn_.enabled = false
			end

			local var_71_17 = 0.3

			if arg_68_1.time_ >= var_71_16 + var_71_17 and arg_68_1.time_ < var_71_16 + var_71_17 + arg_71_0 then
				arg_68_1.allBtn_.enabled = true
			end

			local var_71_18 = 0

			if var_71_18 < arg_68_1.time_ and arg_68_1.time_ <= var_71_18 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_19 = 2

			if var_71_18 <= arg_68_1.time_ and arg_68_1.time_ < var_71_18 + var_71_19 then
				local var_71_20 = (arg_68_1.time_ - var_71_18) / var_71_19
				local var_71_21 = Color.New(0, 0, 0)

				var_71_21.a = Mathf.Lerp(0, 1, var_71_20)
				arg_68_1.mask_.color = var_71_21
			end

			if arg_68_1.time_ >= var_71_18 + var_71_19 and arg_68_1.time_ < var_71_18 + var_71_19 + arg_71_0 then
				local var_71_22 = Color.New(0, 0, 0)

				var_71_22.a = 1
				arg_68_1.mask_.color = var_71_22
			end

			local var_71_23 = 2

			if var_71_23 < arg_68_1.time_ and arg_68_1.time_ <= var_71_23 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_24 = 2

			if var_71_23 <= arg_68_1.time_ and arg_68_1.time_ < var_71_23 + var_71_24 then
				local var_71_25 = (arg_68_1.time_ - var_71_23) / var_71_24
				local var_71_26 = Color.New(0, 0, 0)

				var_71_26.a = Mathf.Lerp(1, 0, var_71_25)
				arg_68_1.mask_.color = var_71_26
			end

			if arg_68_1.time_ >= var_71_23 + var_71_24 and arg_68_1.time_ < var_71_23 + var_71_24 + arg_71_0 then
				local var_71_27 = Color.New(0, 0, 0)
				local var_71_28 = 0

				arg_68_1.mask_.enabled = false
				var_71_27.a = var_71_28
				arg_68_1.mask_.color = var_71_27
			end

			local var_71_29 = 0.466666666666667
			local var_71_30 = 1

			if var_71_29 < arg_68_1.time_ and arg_68_1.time_ <= var_71_29 + arg_71_0 then
				local var_71_31 = "stop"
				local var_71_32 = "effect"

				arg_68_1:AudioAction(var_71_31, var_71_32, "se_story_140", "se_story_140_amb_harbor", "")
			end

			local var_71_33 = 1.9
			local var_71_34 = 1

			if var_71_33 < arg_68_1.time_ and arg_68_1.time_ <= var_71_33 + arg_71_0 then
				local var_71_35 = "play"
				local var_71_36 = "effect"

				arg_68_1:AudioAction(var_71_35, var_71_36, "se_story_140", "se_story_140_amb_wharf", "")
			end

			local var_71_37 = arg_68_1.bgs_.SS1801.transform
			local var_71_38 = 2

			if var_71_38 < arg_68_1.time_ and arg_68_1.time_ <= var_71_38 + arg_71_0 then
				arg_68_1.var_.moveOldPosSS1801 = var_71_37.localPosition
			end

			local var_71_39 = 0.001

			if var_71_38 <= arg_68_1.time_ and arg_68_1.time_ < var_71_38 + var_71_39 then
				local var_71_40 = (arg_68_1.time_ - var_71_38) / var_71_39
				local var_71_41 = Vector3.New(-0.56, 0.67, 4.82)

				var_71_37.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPosSS1801, var_71_41, var_71_40)
			end

			if arg_68_1.time_ >= var_71_38 + var_71_39 and arg_68_1.time_ < var_71_38 + var_71_39 + arg_71_0 then
				var_71_37.localPosition = Vector3.New(-0.56, 0.67, 4.82)
			end

			local var_71_42 = arg_68_1.bgs_.SS1801.transform
			local var_71_43 = 2.9

			if var_71_43 < arg_68_1.time_ and arg_68_1.time_ <= var_71_43 + arg_71_0 then
				arg_68_1.var_.moveOldPosSS1801 = var_71_42.localPosition
			end

			local var_71_44 = 1.983333333332

			if var_71_43 <= arg_68_1.time_ and arg_68_1.time_ < var_71_43 + var_71_44 then
				local var_71_45 = (arg_68_1.time_ - var_71_43) / var_71_44
				local var_71_46 = Vector3.New(0, 1, 6.84)

				var_71_42.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPosSS1801, var_71_46, var_71_45)
			end

			if arg_68_1.time_ >= var_71_43 + var_71_44 and arg_68_1.time_ < var_71_43 + var_71_44 + arg_71_0 then
				var_71_42.localPosition = Vector3.New(0, 1, 6.84)
			end

			local var_71_47 = 3.56666666666667

			if var_71_47 < arg_68_1.time_ and arg_68_1.time_ <= var_71_47 + arg_71_0 then
				arg_68_1.allBtn_.enabled = false
			end

			local var_71_48 = 1.31666666666533

			if arg_68_1.time_ >= var_71_47 + var_71_48 and arg_68_1.time_ < var_71_47 + var_71_48 + arg_71_0 then
				arg_68_1.allBtn_.enabled = true
			end

			if arg_68_1.frameCnt_ <= 1 then
				arg_68_1.dialog_:SetActive(false)
			end

			local var_71_49 = 4.33333333333333
			local var_71_50 = 0.25

			if var_71_49 < arg_68_1.time_ and arg_68_1.time_ <= var_71_49 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				arg_68_1.dialog_:SetActive(true)

				arg_68_1.dialogCg_.alpha = 0

				local var_71_51 = LeanTween.value(arg_68_1.dialog_, 0, 1, 0.3)

				var_71_51:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_68_1.dialogCg_.alpha = arg_72_0
				end))
				var_71_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_68_1.dialog_)
					var_71_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_68_1.duration_ = arg_68_1.duration_ + 0.3

				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_52 = arg_68_1:FormatText(StoryNameCfg[1188].name)

				arg_68_1.leftNameTxt_.text = var_71_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_53 = arg_68_1:GetWordFromCfg(418101017)
				local var_71_54 = arg_68_1:FormatText(var_71_53.content)

				arg_68_1.text_.text = var_71_54

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_55 = 10
				local var_71_56 = utf8.len(var_71_54)
				local var_71_57 = var_71_55 <= 0 and var_71_50 or var_71_50 * (var_71_56 / var_71_55)

				if var_71_57 > 0 and var_71_50 < var_71_57 then
					arg_68_1.talkMaxDuration = var_71_57
					var_71_49 = var_71_49 + 0.3

					if var_71_57 + var_71_49 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_57 + var_71_49
					end
				end

				arg_68_1.text_.text = var_71_54
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101017", "story_v_side_old_418101.awb") ~= 0 then
					local var_71_58 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101017", "story_v_side_old_418101.awb") / 1000

					if var_71_58 + var_71_49 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_58 + var_71_49
					end

					if var_71_53.prefab_name ~= "" and arg_68_1.actors_[var_71_53.prefab_name] ~= nil then
						local var_71_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_53.prefab_name].transform, "story_v_side_old_418101", "418101017", "story_v_side_old_418101.awb")

						arg_68_1:RecordAudio("418101017", var_71_59)
						arg_68_1:RecordAudio("418101017", var_71_59)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101017", "story_v_side_old_418101.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101017", "story_v_side_old_418101.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_60 = var_71_49 + 0.3
			local var_71_61 = math.max(var_71_50, arg_68_1.talkMaxDuration)

			if var_71_60 <= arg_68_1.time_ and arg_68_1.time_ < var_71_60 + var_71_61 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_60) / var_71_61

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_60 + var_71_61 and arg_68_1.time_ < var_71_60 + var_71_61 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1801",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1801",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.983333333332,
				className = "StoryMoveNode",
				startTime = 2.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play418101018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 418101018
		arg_74_1.duration_ = 2.8

		local var_74_0 = {
			ja = 2.8,
			CriLanguages = 2.566,
			zh = 2.566
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play418101019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = "1095"

			if arg_74_1.actors_[var_77_0] == nil then
				local var_77_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1095")

				if not isNil(var_77_1) then
					local var_77_2 = Object.Instantiate(var_77_1, arg_74_1.canvasGo_.transform)

					var_77_2.transform:SetSiblingIndex(1)

					var_77_2.name = var_77_0
					var_77_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_74_1.actors_[var_77_0] = var_77_2

					local var_77_3 = var_77_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_74_1.isInRecall_ then
						for iter_77_0, iter_77_1 in ipairs(var_77_3) do
							iter_77_1.color = arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_77_4 = arg_74_1.actors_["1095"]
			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.actorSpriteComps1095 == nil then
				arg_74_1.var_.actorSpriteComps1095 = var_77_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_6 = 0.2

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 and not isNil(var_77_4) then
				local var_77_7 = (arg_74_1.time_ - var_77_5) / var_77_6

				if arg_74_1.var_.actorSpriteComps1095 then
					for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps1095:ToTable()) do
						if iter_77_3 then
							if arg_74_1.isInRecall_ then
								local var_77_8 = Mathf.Lerp(iter_77_3.color.r, arg_74_1.hightColor1.r, var_77_7)
								local var_77_9 = Mathf.Lerp(iter_77_3.color.g, arg_74_1.hightColor1.g, var_77_7)
								local var_77_10 = Mathf.Lerp(iter_77_3.color.b, arg_74_1.hightColor1.b, var_77_7)

								iter_77_3.color = Color.New(var_77_8, var_77_9, var_77_10)
							else
								local var_77_11 = Mathf.Lerp(iter_77_3.color.r, 1, var_77_7)

								iter_77_3.color = Color.New(var_77_11, var_77_11, var_77_11)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.actorSpriteComps1095 then
				for iter_77_4, iter_77_5 in pairs(arg_74_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_77_5 then
						if arg_74_1.isInRecall_ then
							iter_77_5.color = arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_77_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps1095 = nil
			end

			local var_77_12 = 0
			local var_77_13 = 0.275

			if var_77_12 < arg_74_1.time_ and arg_74_1.time_ <= var_77_12 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_14 = arg_74_1:FormatText(StoryNameCfg[380].name)

				arg_74_1.leftNameTxt_.text = var_77_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_15 = arg_74_1:GetWordFromCfg(418101018)
				local var_77_16 = arg_74_1:FormatText(var_77_15.content)

				arg_74_1.text_.text = var_77_16

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_17 = 11
				local var_77_18 = utf8.len(var_77_16)
				local var_77_19 = var_77_17 <= 0 and var_77_13 or var_77_13 * (var_77_18 / var_77_17)

				if var_77_19 > 0 and var_77_13 < var_77_19 then
					arg_74_1.talkMaxDuration = var_77_19

					if var_77_19 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_19 + var_77_12
					end
				end

				arg_74_1.text_.text = var_77_16
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101018", "story_v_side_old_418101.awb") ~= 0 then
					local var_77_20 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101018", "story_v_side_old_418101.awb") / 1000

					if var_77_20 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_20 + var_77_12
					end

					if var_77_15.prefab_name ~= "" and arg_74_1.actors_[var_77_15.prefab_name] ~= nil then
						local var_77_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_15.prefab_name].transform, "story_v_side_old_418101", "418101018", "story_v_side_old_418101.awb")

						arg_74_1:RecordAudio("418101018", var_77_21)
						arg_74_1:RecordAudio("418101018", var_77_21)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101018", "story_v_side_old_418101.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101018", "story_v_side_old_418101.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_22 = math.max(var_77_13, arg_74_1.talkMaxDuration)

			if var_77_12 <= arg_74_1.time_ and arg_74_1.time_ < var_77_12 + var_77_22 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_12) / var_77_22

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_12 + var_77_22 and arg_74_1.time_ < var_77_12 + var_77_22 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play418101019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 418101019
		arg_78_1.duration_ = 6.67

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play418101020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1095"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps1095 == nil then
				arg_78_1.var_.actorSpriteComps1095 = var_81_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.actorSpriteComps1095 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps1095:ToTable()) do
						if iter_81_1 then
							if arg_78_1.isInRecall_ then
								local var_81_4 = Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor2.r, var_81_3)
								local var_81_5 = Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor2.g, var_81_3)
								local var_81_6 = Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor2.b, var_81_3)

								iter_81_1.color = Color.New(var_81_4, var_81_5, var_81_6)
							else
								local var_81_7 = Mathf.Lerp(iter_81_1.color.r, 0.5, var_81_3)

								iter_81_1.color = Color.New(var_81_7, var_81_7, var_81_7)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps1095 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_81_3 then
						if arg_78_1.isInRecall_ then
							iter_81_3.color = arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_81_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps1095 = nil
			end

			local var_81_8 = 0.05
			local var_81_9 = 1

			if var_81_8 < arg_78_1.time_ and arg_78_1.time_ <= var_81_8 + arg_81_0 then
				local var_81_10 = "play"
				local var_81_11 = "effect"

				arg_78_1:AudioAction(var_81_10, var_81_11, "se_story_140", "se_story_140_horn", "")
			end

			local var_81_12 = 0

			if var_81_12 < arg_78_1.time_ and arg_78_1.time_ <= var_81_12 + arg_81_0 then
				local var_81_13 = manager.ui.mainCamera.transform.localPosition
				local var_81_14 = Vector3.New(0, 0, 10) + Vector3.New(var_81_13.x, var_81_13.y, 0)
				local var_81_15 = arg_78_1.bgs_.SS1801

				var_81_15.transform.localPosition = var_81_14
				var_81_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_16 = var_81_15:GetComponent("SpriteRenderer")

				if var_81_16 and var_81_16.sprite then
					local var_81_17 = (var_81_15.transform.localPosition - var_81_13).z
					local var_81_18 = manager.ui.mainCameraCom_
					local var_81_19 = 2 * var_81_17 * Mathf.Tan(var_81_18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_81_20 = var_81_19 * var_81_18.aspect
					local var_81_21 = var_81_16.sprite.bounds.size.x
					local var_81_22 = var_81_16.sprite.bounds.size.y
					local var_81_23 = var_81_20 / var_81_21
					local var_81_24 = var_81_19 / var_81_22
					local var_81_25 = var_81_24 < var_81_23 and var_81_23 or var_81_24

					var_81_15.transform.localScale = Vector3.New(var_81_25, var_81_25, 0)
				end

				for iter_81_4, iter_81_5 in pairs(arg_78_1.bgs_) do
					if iter_81_4 ~= "SS1801" then
						iter_81_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_26 = 0

			if var_81_26 < arg_78_1.time_ and arg_78_1.time_ <= var_81_26 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			local var_81_27 = 1.66666666666667

			if arg_78_1.time_ >= var_81_26 + var_81_27 and arg_78_1.time_ < var_81_26 + var_81_27 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end

			local var_81_28 = 0

			if var_81_28 < arg_78_1.time_ and arg_78_1.time_ <= var_81_28 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_29 = 1.36666666666667

			if var_81_28 <= arg_78_1.time_ and arg_78_1.time_ < var_81_28 + var_81_29 then
				local var_81_30 = (arg_78_1.time_ - var_81_28) / var_81_29
				local var_81_31 = Color.New(0, 0, 0)

				var_81_31.a = Mathf.Lerp(1, 0, var_81_30)
				arg_78_1.mask_.color = var_81_31
			end

			if arg_78_1.time_ >= var_81_28 + var_81_29 and arg_78_1.time_ < var_81_28 + var_81_29 + arg_81_0 then
				local var_81_32 = Color.New(0, 0, 0)
				local var_81_33 = 0

				arg_78_1.mask_.enabled = false
				var_81_32.a = var_81_33
				arg_78_1.mask_.color = var_81_32
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_34 = 1.66666666666667
			local var_81_35 = 1.45

			if var_81_34 < arg_78_1.time_ and arg_78_1.time_ <= var_81_34 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_36 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_36:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_37 = arg_78_1:GetWordFromCfg(418101019)
				local var_81_38 = arg_78_1:FormatText(var_81_37.content)

				arg_78_1.text_.text = var_81_38

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_39 = 58
				local var_81_40 = utf8.len(var_81_38)
				local var_81_41 = var_81_39 <= 0 and var_81_35 or var_81_35 * (var_81_40 / var_81_39)

				if var_81_41 > 0 and var_81_35 < var_81_41 then
					arg_78_1.talkMaxDuration = var_81_41
					var_81_34 = var_81_34 + 0.3

					if var_81_41 + var_81_34 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_41 + var_81_34
					end
				end

				arg_78_1.text_.text = var_81_38
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_42 = var_81_34 + 0.3
			local var_81_43 = math.max(var_81_35, arg_78_1.talkMaxDuration)

			if var_81_42 <= arg_78_1.time_ and arg_78_1.time_ < var_81_42 + var_81_43 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_42) / var_81_43

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_42 + var_81_43 and arg_78_1.time_ < var_81_42 + var_81_43 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play418101020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 418101020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play418101021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 1.525

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_2 = arg_84_1:GetWordFromCfg(418101020)
				local var_87_3 = arg_84_1:FormatText(var_87_2.content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 61
				local var_87_5 = utf8.len(var_87_3)
				local var_87_6 = var_87_4 <= 0 and var_87_1 or var_87_1 * (var_87_5 / var_87_4)

				if var_87_6 > 0 and var_87_1 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_7 and arg_84_1.time_ < var_87_0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play418101021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 418101021
		arg_88_1.duration_ = 8.7

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play418101022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = "SS1801a"

			if arg_88_1.bgs_[var_91_0] == nil then
				local var_91_1 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_91_0)
				var_91_1.name = var_91_0
				var_91_1.transform.parent = arg_88_1.stage_.transform
				var_91_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_[var_91_0] = var_91_1
			end

			local var_91_2 = 1.79721046729634

			if var_91_2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				local var_91_3 = manager.ui.mainCamera.transform.localPosition
				local var_91_4 = Vector3.New(0, 0, 10) + Vector3.New(var_91_3.x, var_91_3.y, 0)
				local var_91_5 = arg_88_1.bgs_.SS1801a

				var_91_5.transform.localPosition = var_91_4
				var_91_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_6 = var_91_5:GetComponent("SpriteRenderer")

				if var_91_6 and var_91_6.sprite then
					local var_91_7 = (var_91_5.transform.localPosition - var_91_3).z
					local var_91_8 = manager.ui.mainCameraCom_
					local var_91_9 = 2 * var_91_7 * Mathf.Tan(var_91_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_91_10 = var_91_9 * var_91_8.aspect
					local var_91_11 = var_91_6.sprite.bounds.size.x
					local var_91_12 = var_91_6.sprite.bounds.size.y
					local var_91_13 = var_91_10 / var_91_11
					local var_91_14 = var_91_9 / var_91_12
					local var_91_15 = var_91_14 < var_91_13 and var_91_13 or var_91_14

					var_91_5.transform.localScale = Vector3.New(var_91_15, var_91_15, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "SS1801a" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_16 = 0

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			local var_91_17 = 0.3

			if arg_88_1.time_ >= var_91_16 + var_91_17 and arg_88_1.time_ < var_91_16 + var_91_17 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_18 = 0

			if var_91_18 < arg_88_1.time_ and arg_88_1.time_ <= var_91_18 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_19 = 1.83333333333333

			if var_91_18 <= arg_88_1.time_ and arg_88_1.time_ < var_91_18 + var_91_19 then
				local var_91_20 = (arg_88_1.time_ - var_91_18) / var_91_19
				local var_91_21 = Color.New(0, 0, 0)

				var_91_21.a = Mathf.Lerp(0, 1, var_91_20)
				arg_88_1.mask_.color = var_91_21
			end

			if arg_88_1.time_ >= var_91_18 + var_91_19 and arg_88_1.time_ < var_91_18 + var_91_19 + arg_91_0 then
				local var_91_22 = Color.New(0, 0, 0)

				var_91_22.a = 1
				arg_88_1.mask_.color = var_91_22
			end

			local var_91_23 = 1.83333333333333

			if var_91_23 < arg_88_1.time_ and arg_88_1.time_ <= var_91_23 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_24 = 1.99999999999933

			if var_91_23 <= arg_88_1.time_ and arg_88_1.time_ < var_91_23 + var_91_24 then
				local var_91_25 = (arg_88_1.time_ - var_91_23) / var_91_24
				local var_91_26 = Color.New(0, 0, 0)

				var_91_26.a = Mathf.Lerp(1, 0, var_91_25)
				arg_88_1.mask_.color = var_91_26
			end

			if arg_88_1.time_ >= var_91_23 + var_91_24 and arg_88_1.time_ < var_91_23 + var_91_24 + arg_91_0 then
				local var_91_27 = Color.New(0, 0, 0)
				local var_91_28 = 0

				arg_88_1.mask_.enabled = false
				var_91_27.a = var_91_28
				arg_88_1.mask_.color = var_91_27
			end

			local var_91_29 = arg_88_1.bgs_.SS1801a.transform
			local var_91_30 = 1.83333333333333

			if var_91_30 < arg_88_1.time_ and arg_88_1.time_ <= var_91_30 + arg_91_0 then
				arg_88_1.var_.moveOldPosSS1801a = var_91_29.localPosition
			end

			local var_91_31 = 0.001

			if var_91_30 <= arg_88_1.time_ and arg_88_1.time_ < var_91_30 + var_91_31 then
				local var_91_32 = (arg_88_1.time_ - var_91_30) / var_91_31
				local var_91_33 = Vector3.New(0, 1, 9)

				var_91_29.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPosSS1801a, var_91_33, var_91_32)
			end

			if arg_88_1.time_ >= var_91_30 + var_91_31 and arg_88_1.time_ < var_91_30 + var_91_31 + arg_91_0 then
				var_91_29.localPosition = Vector3.New(0, 1, 9)
			end

			local var_91_34 = arg_88_1.bgs_.SS1801a.transform
			local var_91_35 = 1.85

			if var_91_35 < arg_88_1.time_ and arg_88_1.time_ <= var_91_35 + arg_91_0 then
				arg_88_1.var_.moveOldPosSS1801a = var_91_34.localPosition
			end

			local var_91_36 = 1.98333333333267

			if var_91_35 <= arg_88_1.time_ and arg_88_1.time_ < var_91_35 + var_91_36 then
				local var_91_37 = (arg_88_1.time_ - var_91_35) / var_91_36
				local var_91_38 = Vector3.New(0, 1, 10)

				var_91_34.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPosSS1801a, var_91_38, var_91_37)
			end

			if arg_88_1.time_ >= var_91_35 + var_91_36 and arg_88_1.time_ < var_91_35 + var_91_36 + arg_91_0 then
				var_91_34.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_39 = 3.7
			local var_91_40 = 1.125

			if var_91_39 < arg_88_1.time_ and arg_88_1.time_ <= var_91_39 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_41 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_41:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_42 = arg_88_1:GetWordFromCfg(418101021)
				local var_91_43 = arg_88_1:FormatText(var_91_42.content)

				arg_88_1.text_.text = var_91_43

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_44 = 45
				local var_91_45 = utf8.len(var_91_43)
				local var_91_46 = var_91_44 <= 0 and var_91_40 or var_91_40 * (var_91_45 / var_91_44)

				if var_91_46 > 0 and var_91_40 < var_91_46 then
					arg_88_1.talkMaxDuration = var_91_46
					var_91_39 = var_91_39 + 0.3

					if var_91_46 + var_91_39 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_46 + var_91_39
					end
				end

				arg_88_1.text_.text = var_91_43
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_47 = var_91_39 + 0.3
			local var_91_48 = math.max(var_91_40, arg_88_1.talkMaxDuration)

			if var_91_47 <= arg_88_1.time_ and arg_88_1.time_ < var_91_47 + var_91_48 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_47) / var_91_48

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_47 + var_91_48 and arg_88_1.time_ < var_91_47 + var_91_48 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1801a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1801a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.98333333333267,
				className = "StoryMoveNode",
				startTime = 1.85,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play418101022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 418101022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play418101023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.6

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(418101022)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 24
				local var_97_5 = utf8.len(var_97_3)
				local var_97_6 = var_97_4 <= 0 and var_97_1 or var_97_1 * (var_97_5 / var_97_4)

				if var_97_6 > 0 and var_97_1 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_7 and arg_94_1.time_ < var_97_0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play418101023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 418101023
		arg_98_1.duration_ = 8.53

		local var_98_0 = {
			ja = 7.333,
			CriLanguages = 8.533,
			zh = 8.533
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
				arg_98_0:Play418101024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 2

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				local var_101_1 = manager.ui.mainCamera.transform.localPosition
				local var_101_2 = Vector3.New(0, 0, 10) + Vector3.New(var_101_1.x, var_101_1.y, 0)
				local var_101_3 = arg_98_1.bgs_.SS1801

				var_101_3.transform.localPosition = var_101_2
				var_101_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_4 = var_101_3:GetComponent("SpriteRenderer")

				if var_101_4 and var_101_4.sprite then
					local var_101_5 = (var_101_3.transform.localPosition - var_101_1).z
					local var_101_6 = manager.ui.mainCameraCom_
					local var_101_7 = 2 * var_101_5 * Mathf.Tan(var_101_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_101_8 = var_101_7 * var_101_6.aspect
					local var_101_9 = var_101_4.sprite.bounds.size.x
					local var_101_10 = var_101_4.sprite.bounds.size.y
					local var_101_11 = var_101_8 / var_101_9
					local var_101_12 = var_101_7 / var_101_10
					local var_101_13 = var_101_12 < var_101_11 and var_101_11 or var_101_12

					var_101_3.transform.localScale = Vector3.New(var_101_13, var_101_13, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "SS1801" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_14 = 0

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			local var_101_15 = 0.3

			if arg_98_1.time_ >= var_101_14 + var_101_15 and arg_98_1.time_ < var_101_14 + var_101_15 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_16 = 0

			if var_101_16 < arg_98_1.time_ and arg_98_1.time_ <= var_101_16 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_17 = 2

			if var_101_16 <= arg_98_1.time_ and arg_98_1.time_ < var_101_16 + var_101_17 then
				local var_101_18 = (arg_98_1.time_ - var_101_16) / var_101_17
				local var_101_19 = Color.New(0, 0, 0)

				var_101_19.a = Mathf.Lerp(0, 1, var_101_18)
				arg_98_1.mask_.color = var_101_19
			end

			if arg_98_1.time_ >= var_101_16 + var_101_17 and arg_98_1.time_ < var_101_16 + var_101_17 + arg_101_0 then
				local var_101_20 = Color.New(0, 0, 0)

				var_101_20.a = 1
				arg_98_1.mask_.color = var_101_20
			end

			local var_101_21 = 2

			if var_101_21 < arg_98_1.time_ and arg_98_1.time_ <= var_101_21 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_22 = 2

			if var_101_21 <= arg_98_1.time_ and arg_98_1.time_ < var_101_21 + var_101_22 then
				local var_101_23 = (arg_98_1.time_ - var_101_21) / var_101_22
				local var_101_24 = Color.New(0, 0, 0)

				var_101_24.a = Mathf.Lerp(1, 0, var_101_23)
				arg_98_1.mask_.color = var_101_24
			end

			if arg_98_1.time_ >= var_101_21 + var_101_22 and arg_98_1.time_ < var_101_21 + var_101_22 + arg_101_0 then
				local var_101_25 = Color.New(0, 0, 0)
				local var_101_26 = 0

				arg_98_1.mask_.enabled = false
				var_101_25.a = var_101_26
				arg_98_1.mask_.color = var_101_25
			end

			local var_101_27 = arg_98_1.actors_["10135"]
			local var_101_28 = 0

			if var_101_28 < arg_98_1.time_ and arg_98_1.time_ <= var_101_28 + arg_101_0 and not isNil(var_101_27) and arg_98_1.var_.actorSpriteComps10135 == nil then
				arg_98_1.var_.actorSpriteComps10135 = var_101_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_29 = 0.2

			if var_101_28 <= arg_98_1.time_ and arg_98_1.time_ < var_101_28 + var_101_29 and not isNil(var_101_27) then
				local var_101_30 = (arg_98_1.time_ - var_101_28) / var_101_29

				if arg_98_1.var_.actorSpriteComps10135 then
					for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_101_3 then
							if arg_98_1.isInRecall_ then
								local var_101_31 = Mathf.Lerp(iter_101_3.color.r, arg_98_1.hightColor1.r, var_101_30)
								local var_101_32 = Mathf.Lerp(iter_101_3.color.g, arg_98_1.hightColor1.g, var_101_30)
								local var_101_33 = Mathf.Lerp(iter_101_3.color.b, arg_98_1.hightColor1.b, var_101_30)

								iter_101_3.color = Color.New(var_101_31, var_101_32, var_101_33)
							else
								local var_101_34 = Mathf.Lerp(iter_101_3.color.r, 1, var_101_30)

								iter_101_3.color = Color.New(var_101_34, var_101_34, var_101_34)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= var_101_28 + var_101_29 and arg_98_1.time_ < var_101_28 + var_101_29 + arg_101_0 and not isNil(var_101_27) and arg_98_1.var_.actorSpriteComps10135 then
				for iter_101_4, iter_101_5 in pairs(arg_98_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_101_5 then
						if arg_98_1.isInRecall_ then
							iter_101_5.color = arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_101_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps10135 = nil
			end

			local var_101_35 = manager.ui.mainCamera.transform
			local var_101_36 = 2

			if var_101_36 < arg_98_1.time_ and arg_98_1.time_ <= var_101_36 + arg_101_0 then
				local var_101_37 = arg_98_1.var_.effect954
				local var_101_38
				local var_101_39 = var_101_35

				if not var_101_37 then
					var_101_37 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), var_101_39)
					var_101_37.name = "954"
					arg_98_1.var_.effect954 = var_101_37
				else
					var_101_37.transform:SetParent(var_101_39)
				end

				var_101_37.transform.localPosition = Vector3.New(0, 1.62, 0)
				var_101_37.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_40 = 3.8
			local var_101_41 = 0.5

			if var_101_40 < arg_98_1.time_ and arg_98_1.time_ <= var_101_40 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_42 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_42:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_43 = arg_98_1:FormatText(StoryNameCfg[1187].name)

				arg_98_1.leftNameTxt_.text = var_101_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_44 = arg_98_1:GetWordFromCfg(418101023)
				local var_101_45 = arg_98_1:FormatText(var_101_44.content)

				arg_98_1.text_.text = var_101_45

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_46 = 20
				local var_101_47 = utf8.len(var_101_45)
				local var_101_48 = var_101_46 <= 0 and var_101_41 or var_101_41 * (var_101_47 / var_101_46)

				if var_101_48 > 0 and var_101_41 < var_101_48 then
					arg_98_1.talkMaxDuration = var_101_48
					var_101_40 = var_101_40 + 0.3

					if var_101_48 + var_101_40 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_48 + var_101_40
					end
				end

				arg_98_1.text_.text = var_101_45
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101023", "story_v_side_old_418101.awb") ~= 0 then
					local var_101_49 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101023", "story_v_side_old_418101.awb") / 1000

					if var_101_49 + var_101_40 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_49 + var_101_40
					end

					if var_101_44.prefab_name ~= "" and arg_98_1.actors_[var_101_44.prefab_name] ~= nil then
						local var_101_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_44.prefab_name].transform, "story_v_side_old_418101", "418101023", "story_v_side_old_418101.awb")

						arg_98_1:RecordAudio("418101023", var_101_50)
						arg_98_1:RecordAudio("418101023", var_101_50)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101023", "story_v_side_old_418101.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101023", "story_v_side_old_418101.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_51 = var_101_40 + 0.3
			local var_101_52 = math.max(var_101_41, arg_98_1.talkMaxDuration)

			if var_101_51 <= arg_98_1.time_ and arg_98_1.time_ < var_101_51 + var_101_52 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_51) / var_101_52

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_51 + var_101_52 and arg_98_1.time_ < var_101_51 + var_101_52 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play418101024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 418101024
		arg_104_1.duration_ = 1.03

		local var_104_0 = {
			ja = 1.033,
			CriLanguages = 0.999999999999,
			zh = 0.999999999999
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
				arg_104_0:Play418101025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1095"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps1095 == nil then
				arg_104_1.var_.actorSpriteComps1095 = var_107_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.actorSpriteComps1095 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps1095 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_107_3 then
						if arg_104_1.isInRecall_ then
							iter_107_3.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_107_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps1095 = nil
			end

			local var_107_8 = arg_104_1.actors_["10135"]
			local var_107_9 = 0

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps10135 == nil then
				arg_104_1.var_.actorSpriteComps10135 = var_107_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_10 = 0.2

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_10 and not isNil(var_107_8) then
				local var_107_11 = (arg_104_1.time_ - var_107_9) / var_107_10

				if arg_104_1.var_.actorSpriteComps10135 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_104_1.time_ >= var_107_9 + var_107_10 and arg_104_1.time_ < var_107_9 + var_107_10 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps10135 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_107_7 then
						if arg_104_1.isInRecall_ then
							iter_107_7.color = arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_107_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10135 = nil
			end

			local var_107_16 = 0
			local var_107_17 = 0.05

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_18 = arg_104_1:FormatText(StoryNameCfg[380].name)

				arg_104_1.leftNameTxt_.text = var_107_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_19 = arg_104_1:GetWordFromCfg(418101024)
				local var_107_20 = arg_104_1:FormatText(var_107_19.content)

				arg_104_1.text_.text = var_107_20

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_21 = 2
				local var_107_22 = utf8.len(var_107_20)
				local var_107_23 = var_107_21 <= 0 and var_107_17 or var_107_17 * (var_107_22 / var_107_21)

				if var_107_23 > 0 and var_107_17 < var_107_23 then
					arg_104_1.talkMaxDuration = var_107_23

					if var_107_23 + var_107_16 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_23 + var_107_16
					end
				end

				arg_104_1.text_.text = var_107_20
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101024", "story_v_side_old_418101.awb") ~= 0 then
					local var_107_24 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101024", "story_v_side_old_418101.awb") / 1000

					if var_107_24 + var_107_16 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_24 + var_107_16
					end

					if var_107_19.prefab_name ~= "" and arg_104_1.actors_[var_107_19.prefab_name] ~= nil then
						local var_107_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_19.prefab_name].transform, "story_v_side_old_418101", "418101024", "story_v_side_old_418101.awb")

						arg_104_1:RecordAudio("418101024", var_107_25)
						arg_104_1:RecordAudio("418101024", var_107_25)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101024", "story_v_side_old_418101.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101024", "story_v_side_old_418101.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_26 = math.max(var_107_17, arg_104_1.talkMaxDuration)

			if var_107_16 <= arg_104_1.time_ and arg_104_1.time_ < var_107_16 + var_107_26 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_16) / var_107_26

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_16 + var_107_26 and arg_104_1.time_ < var_107_16 + var_107_26 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play418101025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 418101025
		arg_108_1.duration_ = 1.1

		local var_108_0 = {
			ja = 1.033,
			CriLanguages = 1.1,
			zh = 1.1
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
				arg_108_0:Play418101026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10135"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps10135 == nil then
				arg_108_1.var_.actorSpriteComps10135 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps10135 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps10135 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps10135 = nil
			end

			local var_111_8 = arg_108_1.actors_["1095"]
			local var_111_9 = 0

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps1095 == nil then
				arg_108_1.var_.actorSpriteComps1095 = var_111_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_10 = 0.2

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_10 and not isNil(var_111_8) then
				local var_111_11 = (arg_108_1.time_ - var_111_9) / var_111_10

				if arg_108_1.var_.actorSpriteComps1095 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_108_1.time_ >= var_111_9 + var_111_10 and arg_108_1.time_ < var_111_9 + var_111_10 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps1095 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_111_7 then
						if arg_108_1.isInRecall_ then
							iter_111_7.color = arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_111_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1095 = nil
			end

			local var_111_16 = 0
			local var_111_17 = 0.1

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_18 = arg_108_1:FormatText(StoryNameCfg[1187].name)

				arg_108_1.leftNameTxt_.text = var_111_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_19 = arg_108_1:GetWordFromCfg(418101025)
				local var_111_20 = arg_108_1:FormatText(var_111_19.content)

				arg_108_1.text_.text = var_111_20

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_21 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101025", "story_v_side_old_418101.awb") ~= 0 then
					local var_111_24 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101025", "story_v_side_old_418101.awb") / 1000

					if var_111_24 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_24 + var_111_16
					end

					if var_111_19.prefab_name ~= "" and arg_108_1.actors_[var_111_19.prefab_name] ~= nil then
						local var_111_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_19.prefab_name].transform, "story_v_side_old_418101", "418101025", "story_v_side_old_418101.awb")

						arg_108_1:RecordAudio("418101025", var_111_25)
						arg_108_1:RecordAudio("418101025", var_111_25)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101025", "story_v_side_old_418101.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101025", "story_v_side_old_418101.awb")
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
	Play418101026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 418101026
		arg_112_1.duration_ = 3.37

		local var_112_0 = {
			ja = 3.366,
			CriLanguages = 2.8,
			zh = 2.8
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
				arg_112_0:Play418101027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1095"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1095 == nil then
				arg_112_1.var_.actorSpriteComps1095 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps1095 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1095 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps1095 = nil
			end

			local var_115_8 = arg_112_1.actors_["10135"]
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps10135 == nil then
				arg_112_1.var_.actorSpriteComps10135 = var_115_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_10 = 0.2

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_10 and not isNil(var_115_8) then
				local var_115_11 = (arg_112_1.time_ - var_115_9) / var_115_10

				if arg_112_1.var_.actorSpriteComps10135 then
					for iter_115_4, iter_115_5 in pairs(arg_112_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_115_5 then
							if arg_112_1.isInRecall_ then
								local var_115_12 = Mathf.Lerp(iter_115_5.color.r, arg_112_1.hightColor2.r, var_115_11)
								local var_115_13 = Mathf.Lerp(iter_115_5.color.g, arg_112_1.hightColor2.g, var_115_11)
								local var_115_14 = Mathf.Lerp(iter_115_5.color.b, arg_112_1.hightColor2.b, var_115_11)

								iter_115_5.color = Color.New(var_115_12, var_115_13, var_115_14)
							else
								local var_115_15 = Mathf.Lerp(iter_115_5.color.r, 0.5, var_115_11)

								iter_115_5.color = Color.New(var_115_15, var_115_15, var_115_15)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_9 + var_115_10 and arg_112_1.time_ < var_115_9 + var_115_10 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps10135 then
				for iter_115_6, iter_115_7 in pairs(arg_112_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_115_7 then
						if arg_112_1.isInRecall_ then
							iter_115_7.color = arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_115_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps10135 = nil
			end

			local var_115_16 = 0
			local var_115_17 = 0.225

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_18 = arg_112_1:FormatText(StoryNameCfg[380].name)

				arg_112_1.leftNameTxt_.text = var_115_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_19 = arg_112_1:GetWordFromCfg(418101026)
				local var_115_20 = arg_112_1:FormatText(var_115_19.content)

				arg_112_1.text_.text = var_115_20

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_21 = 9
				local var_115_22 = utf8.len(var_115_20)
				local var_115_23 = var_115_21 <= 0 and var_115_17 or var_115_17 * (var_115_22 / var_115_21)

				if var_115_23 > 0 and var_115_17 < var_115_23 then
					arg_112_1.talkMaxDuration = var_115_23

					if var_115_23 + var_115_16 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_23 + var_115_16
					end
				end

				arg_112_1.text_.text = var_115_20
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101026", "story_v_side_old_418101.awb") ~= 0 then
					local var_115_24 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101026", "story_v_side_old_418101.awb") / 1000

					if var_115_24 + var_115_16 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_24 + var_115_16
					end

					if var_115_19.prefab_name ~= "" and arg_112_1.actors_[var_115_19.prefab_name] ~= nil then
						local var_115_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_19.prefab_name].transform, "story_v_side_old_418101", "418101026", "story_v_side_old_418101.awb")

						arg_112_1:RecordAudio("418101026", var_115_25)
						arg_112_1:RecordAudio("418101026", var_115_25)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101026", "story_v_side_old_418101.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101026", "story_v_side_old_418101.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_26 = math.max(var_115_17, arg_112_1.talkMaxDuration)

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_26 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_16) / var_115_26

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_16 + var_115_26 and arg_112_1.time_ < var_115_16 + var_115_26 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play418101027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 418101027
		arg_116_1.duration_ = 3.63

		local var_116_0 = {
			ja = 3.633,
			CriLanguages = 2.633,
			zh = 2.633
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
				arg_116_0:Play418101028(arg_116_1)
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

			local var_119_8 = arg_116_1.actors_["1095"]
			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps1095 == nil then
				arg_116_1.var_.actorSpriteComps1095 = var_119_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_10 = 0.2

			if var_119_9 <= arg_116_1.time_ and arg_116_1.time_ < var_119_9 + var_119_10 and not isNil(var_119_8) then
				local var_119_11 = (arg_116_1.time_ - var_119_9) / var_119_10

				if arg_116_1.var_.actorSpriteComps1095 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_116_1.time_ >= var_119_9 + var_119_10 and arg_116_1.time_ < var_119_9 + var_119_10 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps1095 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_119_7 then
						if arg_116_1.isInRecall_ then
							iter_119_7.color = arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_119_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps1095 = nil
			end

			local var_119_16 = 0
			local var_119_17 = 0.275

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_18 = arg_116_1:FormatText(StoryNameCfg[1187].name)

				arg_116_1.leftNameTxt_.text = var_119_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_19 = arg_116_1:GetWordFromCfg(418101027)
				local var_119_20 = arg_116_1:FormatText(var_119_19.content)

				arg_116_1.text_.text = var_119_20

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_21 = 11
				local var_119_22 = utf8.len(var_119_20)
				local var_119_23 = var_119_21 <= 0 and var_119_17 or var_119_17 * (var_119_22 / var_119_21)

				if var_119_23 > 0 and var_119_17 < var_119_23 then
					arg_116_1.talkMaxDuration = var_119_23

					if var_119_23 + var_119_16 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_16
					end
				end

				arg_116_1.text_.text = var_119_20
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101027", "story_v_side_old_418101.awb") ~= 0 then
					local var_119_24 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101027", "story_v_side_old_418101.awb") / 1000

					if var_119_24 + var_119_16 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_24 + var_119_16
					end

					if var_119_19.prefab_name ~= "" and arg_116_1.actors_[var_119_19.prefab_name] ~= nil then
						local var_119_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_19.prefab_name].transform, "story_v_side_old_418101", "418101027", "story_v_side_old_418101.awb")

						arg_116_1:RecordAudio("418101027", var_119_25)
						arg_116_1:RecordAudio("418101027", var_119_25)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101027", "story_v_side_old_418101.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101027", "story_v_side_old_418101.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_26 = math.max(var_119_17, arg_116_1.talkMaxDuration)

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_26 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_16) / var_119_26

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_16 + var_119_26 and arg_116_1.time_ < var_119_16 + var_119_26 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play418101028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 418101028
		arg_120_1.duration_ = 9.87

		local var_120_0 = {
			ja = 9.866,
			CriLanguages = 7.9,
			zh = 7.9
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
				arg_120_0:Play418101029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1095"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps1095 == nil then
				arg_120_1.var_.actorSpriteComps1095 = var_123_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.actorSpriteComps1095 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps1095 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_123_3 then
						if arg_120_1.isInRecall_ then
							iter_123_3.color = arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_123_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps1095 = nil
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
			local var_123_17 = 0.65

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

				local var_123_19 = arg_120_1:GetWordFromCfg(418101028)
				local var_123_20 = arg_120_1:FormatText(var_123_19.content)

				arg_120_1.text_.text = var_123_20

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_21 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101028", "story_v_side_old_418101.awb") ~= 0 then
					local var_123_24 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101028", "story_v_side_old_418101.awb") / 1000

					if var_123_24 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_24 + var_123_16
					end

					if var_123_19.prefab_name ~= "" and arg_120_1.actors_[var_123_19.prefab_name] ~= nil then
						local var_123_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_19.prefab_name].transform, "story_v_side_old_418101", "418101028", "story_v_side_old_418101.awb")

						arg_120_1:RecordAudio("418101028", var_123_25)
						arg_120_1:RecordAudio("418101028", var_123_25)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101028", "story_v_side_old_418101.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101028", "story_v_side_old_418101.awb")
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
	Play418101029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 418101029
		arg_124_1.duration_ = 8.1

		local var_124_0 = {
			ja = 8.1,
			CriLanguages = 6.433,
			zh = 6.433
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
				arg_124_0:Play418101030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.625

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[380].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(418101029)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 25
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101029", "story_v_side_old_418101.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101029", "story_v_side_old_418101.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_side_old_418101", "418101029", "story_v_side_old_418101.awb")

						arg_124_1:RecordAudio("418101029", var_127_9)
						arg_124_1:RecordAudio("418101029", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101029", "story_v_side_old_418101.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101029", "story_v_side_old_418101.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play418101030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 418101030
		arg_128_1.duration_ = 3.8

		local var_128_0 = {
			ja = 3.8,
			CriLanguages = 3.7,
			zh = 3.7
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
				arg_128_0:Play418101031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10135"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps10135 == nil then
				arg_128_1.var_.actorSpriteComps10135 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps10135 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps10135 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10135 = nil
			end

			local var_131_8 = arg_128_1.actors_["1095"]
			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps1095 == nil then
				arg_128_1.var_.actorSpriteComps1095 = var_131_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_10 = 0.2

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_10 and not isNil(var_131_8) then
				local var_131_11 = (arg_128_1.time_ - var_131_9) / var_131_10

				if arg_128_1.var_.actorSpriteComps1095 then
					for iter_131_4, iter_131_5 in pairs(arg_128_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_128_1.time_ >= var_131_9 + var_131_10 and arg_128_1.time_ < var_131_9 + var_131_10 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps1095 then
				for iter_131_6, iter_131_7 in pairs(arg_128_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_131_7 then
						if arg_128_1.isInRecall_ then
							iter_131_7.color = arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_131_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps1095 = nil
			end

			local var_131_16 = 0
			local var_131_17 = 0.325

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_18 = arg_128_1:FormatText(StoryNameCfg[1187].name)

				arg_128_1.leftNameTxt_.text = var_131_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_19 = arg_128_1:GetWordFromCfg(418101030)
				local var_131_20 = arg_128_1:FormatText(var_131_19.content)

				arg_128_1.text_.text = var_131_20

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_21 = 13
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

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101030", "story_v_side_old_418101.awb") ~= 0 then
					local var_131_24 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101030", "story_v_side_old_418101.awb") / 1000

					if var_131_24 + var_131_16 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_24 + var_131_16
					end

					if var_131_19.prefab_name ~= "" and arg_128_1.actors_[var_131_19.prefab_name] ~= nil then
						local var_131_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_19.prefab_name].transform, "story_v_side_old_418101", "418101030", "story_v_side_old_418101.awb")

						arg_128_1:RecordAudio("418101030", var_131_25)
						arg_128_1:RecordAudio("418101030", var_131_25)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101030", "story_v_side_old_418101.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101030", "story_v_side_old_418101.awb")
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
	Play418101031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 418101031
		arg_132_1.duration_ = 4.9

		local var_132_0 = {
			ja = 3.733,
			CriLanguages = 4.9,
			zh = 4.9
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play418101032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = "1074"

			if arg_132_1.actors_[var_135_0] == nil then
				local var_135_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1074")

				if not isNil(var_135_1) then
					local var_135_2 = Object.Instantiate(var_135_1, arg_132_1.canvasGo_.transform)

					var_135_2.transform:SetSiblingIndex(1)

					var_135_2.name = var_135_0
					var_135_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_132_1.actors_[var_135_0] = var_135_2

					local var_135_3 = var_135_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_132_1.isInRecall_ then
						for iter_135_0, iter_135_1 in ipairs(var_135_3) do
							iter_135_1.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_135_4 = arg_132_1.actors_["1074"]
			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.actorSpriteComps1074 == nil then
				arg_132_1.var_.actorSpriteComps1074 = var_135_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_6 = 0.2

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_6 and not isNil(var_135_4) then
				local var_135_7 = (arg_132_1.time_ - var_135_5) / var_135_6

				if arg_132_1.var_.actorSpriteComps1074 then
					for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_135_3 then
							if arg_132_1.isInRecall_ then
								local var_135_8 = Mathf.Lerp(iter_135_3.color.r, arg_132_1.hightColor1.r, var_135_7)
								local var_135_9 = Mathf.Lerp(iter_135_3.color.g, arg_132_1.hightColor1.g, var_135_7)
								local var_135_10 = Mathf.Lerp(iter_135_3.color.b, arg_132_1.hightColor1.b, var_135_7)

								iter_135_3.color = Color.New(var_135_8, var_135_9, var_135_10)
							else
								local var_135_11 = Mathf.Lerp(iter_135_3.color.r, 1, var_135_7)

								iter_135_3.color = Color.New(var_135_11, var_135_11, var_135_11)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_5 + var_135_6 and arg_132_1.time_ < var_135_5 + var_135_6 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.actorSpriteComps1074 then
				for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_135_5 then
						if arg_132_1.isInRecall_ then
							iter_135_5.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1074 = nil
			end

			local var_135_12 = arg_132_1.actors_["10135"]
			local var_135_13 = 0

			if var_135_13 < arg_132_1.time_ and arg_132_1.time_ <= var_135_13 + arg_135_0 and not isNil(var_135_12) and arg_132_1.var_.actorSpriteComps10135 == nil then
				arg_132_1.var_.actorSpriteComps10135 = var_135_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_14 = 0.2

			if var_135_13 <= arg_132_1.time_ and arg_132_1.time_ < var_135_13 + var_135_14 and not isNil(var_135_12) then
				local var_135_15 = (arg_132_1.time_ - var_135_13) / var_135_14

				if arg_132_1.var_.actorSpriteComps10135 then
					for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_135_7 then
							if arg_132_1.isInRecall_ then
								local var_135_16 = Mathf.Lerp(iter_135_7.color.r, arg_132_1.hightColor2.r, var_135_15)
								local var_135_17 = Mathf.Lerp(iter_135_7.color.g, arg_132_1.hightColor2.g, var_135_15)
								local var_135_18 = Mathf.Lerp(iter_135_7.color.b, arg_132_1.hightColor2.b, var_135_15)

								iter_135_7.color = Color.New(var_135_16, var_135_17, var_135_18)
							else
								local var_135_19 = Mathf.Lerp(iter_135_7.color.r, 0.5, var_135_15)

								iter_135_7.color = Color.New(var_135_19, var_135_19, var_135_19)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_13 + var_135_14 and arg_132_1.time_ < var_135_13 + var_135_14 + arg_135_0 and not isNil(var_135_12) and arg_132_1.var_.actorSpriteComps10135 then
				for iter_135_8, iter_135_9 in pairs(arg_132_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_135_9 then
						if arg_132_1.isInRecall_ then
							iter_135_9.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps10135 = nil
			end

			local var_135_20 = arg_132_1.bgs_.SS1801.transform
			local var_135_21 = 0

			if var_135_21 < arg_132_1.time_ and arg_132_1.time_ <= var_135_21 + arg_135_0 then
				arg_132_1.var_.moveOldPosSS1801 = var_135_20.localPosition
			end

			local var_135_22 = 0.001

			if var_135_21 <= arg_132_1.time_ and arg_132_1.time_ < var_135_21 + var_135_22 then
				local var_135_23 = (arg_132_1.time_ - var_135_21) / var_135_22
				local var_135_24 = Vector3.New(0, 1, 10)

				var_135_20.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPosSS1801, var_135_24, var_135_23)
			end

			if arg_132_1.time_ >= var_135_21 + var_135_22 and arg_132_1.time_ < var_135_21 + var_135_22 + arg_135_0 then
				var_135_20.localPosition = Vector3.New(0, 1, 10)
			end

			local var_135_25 = arg_132_1.bgs_.SS1801.transform
			local var_135_26 = 0.0166666666666667

			if var_135_26 < arg_132_1.time_ and arg_132_1.time_ <= var_135_26 + arg_135_0 then
				arg_132_1.var_.moveOldPosSS1801 = var_135_25.localPosition
			end

			local var_135_27 = 1.78333333333333

			if var_135_26 <= arg_132_1.time_ and arg_132_1.time_ < var_135_26 + var_135_27 then
				local var_135_28 = (arg_132_1.time_ - var_135_26) / var_135_27
				local var_135_29 = Vector3.New(0.4, 0.76, 8.71)

				var_135_25.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPosSS1801, var_135_29, var_135_28)
			end

			if arg_132_1.time_ >= var_135_26 + var_135_27 and arg_132_1.time_ < var_135_26 + var_135_27 + arg_135_0 then
				var_135_25.localPosition = Vector3.New(0.4, 0.76, 8.71)
			end

			local var_135_30 = 0

			if var_135_30 < arg_132_1.time_ and arg_132_1.time_ <= var_135_30 + arg_135_0 then
				arg_132_1.allBtn_.enabled = false
			end

			local var_135_31 = 1.63333333333333

			if arg_132_1.time_ >= var_135_30 + var_135_31 and arg_132_1.time_ < var_135_30 + var_135_31 + arg_135_0 then
				arg_132_1.allBtn_.enabled = true
			end

			if arg_132_1.frameCnt_ <= 1 then
				arg_132_1.dialog_:SetActive(false)
			end

			local var_135_32 = 1.5
			local var_135_33 = 0.225

			if var_135_32 < arg_132_1.time_ and arg_132_1.time_ <= var_135_32 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0

				arg_132_1.dialog_:SetActive(true)

				arg_132_1.dialogCg_.alpha = 0

				local var_135_34 = LeanTween.value(arg_132_1.dialog_, 0, 1, 0.3)

				var_135_34:setOnUpdate(LuaHelper.FloatAction(function(arg_136_0)
					arg_132_1.dialogCg_.alpha = arg_136_0
				end))
				var_135_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_132_1.dialog_)
					var_135_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_132_1.duration_ = arg_132_1.duration_ + 0.3

				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_35 = arg_132_1:FormatText(StoryNameCfg[410].name)

				arg_132_1.leftNameTxt_.text = var_135_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_36 = arg_132_1:GetWordFromCfg(418101031)
				local var_135_37 = arg_132_1:FormatText(var_135_36.content)

				arg_132_1.text_.text = var_135_37

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_38 = 9
				local var_135_39 = utf8.len(var_135_37)
				local var_135_40 = var_135_38 <= 0 and var_135_33 or var_135_33 * (var_135_39 / var_135_38)

				if var_135_40 > 0 and var_135_33 < var_135_40 then
					arg_132_1.talkMaxDuration = var_135_40
					var_135_32 = var_135_32 + 0.3

					if var_135_40 + var_135_32 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_40 + var_135_32
					end
				end

				arg_132_1.text_.text = var_135_37
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418101", "418101031", "story_v_side_old_418101.awb") ~= 0 then
					local var_135_41 = manager.audio:GetVoiceLength("story_v_side_old_418101", "418101031", "story_v_side_old_418101.awb") / 1000

					if var_135_41 + var_135_32 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_41 + var_135_32
					end

					if var_135_36.prefab_name ~= "" and arg_132_1.actors_[var_135_36.prefab_name] ~= nil then
						local var_135_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_36.prefab_name].transform, "story_v_side_old_418101", "418101031", "story_v_side_old_418101.awb")

						arg_132_1:RecordAudio("418101031", var_135_42)
						arg_132_1:RecordAudio("418101031", var_135_42)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_old_418101", "418101031", "story_v_side_old_418101.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_old_418101", "418101031", "story_v_side_old_418101.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_43 = var_135_32 + 0.3
			local var_135_44 = math.max(var_135_33, arg_132_1.talkMaxDuration)

			if var_135_43 <= arg_132_1.time_ and arg_132_1.time_ < var_135_43 + var_135_44 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_43) / var_135_44

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_43 + var_135_44 and arg_132_1.time_ < var_135_43 + var_135_44 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1801",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1801",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.78333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play418101032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 418101032
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play418101033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1074"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps1074 == nil then
				arg_138_1.var_.actorSpriteComps1074 = var_141_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_2 = 0.2

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.actorSpriteComps1074 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								local var_141_4 = Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor2.r, var_141_3)
								local var_141_5 = Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor2.g, var_141_3)
								local var_141_6 = Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor2.b, var_141_3)

								iter_141_1.color = Color.New(var_141_4, var_141_5, var_141_6)
							else
								local var_141_7 = Mathf.Lerp(iter_141_1.color.r, 0.5, var_141_3)

								iter_141_1.color = Color.New(var_141_7, var_141_7, var_141_7)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps1074 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_141_3 then
						if arg_138_1.isInRecall_ then
							iter_141_3.color = arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_141_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps1074 = nil
			end

			local var_141_8 = 0.05
			local var_141_9 = 1

			if var_141_8 < arg_138_1.time_ and arg_138_1.time_ <= var_141_8 + arg_141_0 then
				local var_141_10 = "play"
				local var_141_11 = "effect"

				arg_138_1:AudioAction(var_141_10, var_141_11, "se_story_140", "se_story_140_ship", "")
			end

			local var_141_12 = 0
			local var_141_13 = 0.55

			if var_141_12 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_14 = arg_138_1:GetWordFromCfg(418101032)
				local var_141_15 = arg_138_1:FormatText(var_141_14.content)

				arg_138_1.text_.text = var_141_15

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_16 = 22
				local var_141_17 = utf8.len(var_141_15)
				local var_141_18 = var_141_16 <= 0 and var_141_13 or var_141_13 * (var_141_17 / var_141_16)

				if var_141_18 > 0 and var_141_13 < var_141_18 then
					arg_138_1.talkMaxDuration = var_141_18

					if var_141_18 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_18 + var_141_12
					end
				end

				arg_138_1.text_.text = var_141_15
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_19 = math.max(var_141_13, arg_138_1.talkMaxDuration)

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_19 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_12) / var_141_19

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_12 + var_141_19 and arg_138_1.time_ < var_141_12 + var_141_19 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play418101033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 418101033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
			arg_142_1.auto_ = false
		end

		function arg_142_1.playNext_(arg_144_0)
			arg_142_1.onStoryFinished_()
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 1.075

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_2 = arg_142_1:GetWordFromCfg(418101033)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 43
				local var_145_5 = utf8.len(var_145_3)
				local var_145_6 = var_145_4 <= 0 and var_145_1 or var_145_1 * (var_145_5 / var_145_4)

				if var_145_6 > 0 and var_145_1 < var_145_6 then
					arg_142_1.talkMaxDuration = var_145_6

					if var_145_6 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_7 and arg_142_1.time_ < var_145_0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST1001b",
		"TextureConfig/Background/SS1801",
		"TextureConfig/Background/SS1801a"
	},
	voices = {
		"story_v_side_old_418101.awb"
	}
}
