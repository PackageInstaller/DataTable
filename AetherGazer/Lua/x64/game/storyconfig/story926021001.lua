return {
	Play926021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926021001
		arg_1_1.duration_ = 11.13

		local var_1_0 = {
			zh = 9.133,
			ja = 11.133
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
				arg_1_0:Play926021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I22g"

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
				local var_4_5 = arg_1_1.bgs_.I22g

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
					if iter_4_0 ~= "I22g" then
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

			local var_4_36 = 0
			local var_4_37 = 0.433333333333333

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "music"

				arg_1_1:AudioAction(var_4_38, var_4_39, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_40 = ""
				local var_4_41 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_41 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_41 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_41

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_41
						arg_1_1.bgmTxt2_.text = var_4_41
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

			local var_4_42 = 0.666666666666667
			local var_4_43 = 1

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_46 = ""
				local var_4_47 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if var_4_47 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_47 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_47

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_47
						arg_1_1.bgmTxt2_.text = var_4_47
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

			local var_4_48 = 0.166666666666667
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "effect"

				arg_1_1:AudioAction(var_4_50, var_4_51, "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_52 = 2
			local var_4_53 = 0.8

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_54 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_54:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_55 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10144_split_1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_56 = arg_1_1:GetWordFromCfg(926021001)
				local var_4_57 = arg_1_1:FormatText(var_4_56.content)

				arg_1_1.text_.text = var_4_57

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_58 = 32
				local var_4_59 = utf8.len(var_4_57)
				local var_4_60 = var_4_58 <= 0 and var_4_53 or var_4_53 * (var_4_59 / var_4_58)

				if var_4_60 > 0 and var_4_53 < var_4_60 then
					arg_1_1.talkMaxDuration = var_4_60
					var_4_52 = var_4_52 + 0.3

					if var_4_60 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_52
					end
				end

				arg_1_1.text_.text = var_4_57
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021001", "story_v_out_926021.awb") ~= 0 then
					local var_4_61 = manager.audio:GetVoiceLength("story_v_out_926021", "926021001", "story_v_out_926021.awb") / 1000

					if var_4_61 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_52
					end

					if var_4_56.prefab_name ~= "" and arg_1_1.actors_[var_4_56.prefab_name] ~= nil then
						local var_4_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_56.prefab_name].transform, "story_v_out_926021", "926021001", "story_v_out_926021.awb")

						arg_1_1:RecordAudio("926021001", var_4_62)
						arg_1_1:RecordAudio("926021001", var_4_62)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926021", "926021001", "story_v_out_926021.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926021", "926021001", "story_v_out_926021.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_63 = var_4_52 + 0.3
			local var_4_64 = math.max(var_4_53, arg_1_1.talkMaxDuration)

			if var_4_63 <= arg_1_1.time_ and arg_1_1.time_ < var_4_63 + var_4_64 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_63) / var_4_64

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play926021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926021002
		arg_9_1.duration_ = 1.33

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play926021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "106103"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

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

			local var_12_4 = arg_9_1.actors_["106103"]
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps106103 == nil then
				arg_9_1.var_.actorSpriteComps106103 = var_12_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.2

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_6 and not isNil(var_12_4) then
				local var_12_7 = (arg_9_1.time_ - var_12_5) / var_12_6

				if arg_9_1.var_.actorSpriteComps106103 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_12_3 then
							if arg_9_1.isInRecall_ then
								local var_12_8 = Mathf.Lerp(iter_12_3.color.r, arg_9_1.hightColor1.r, var_12_7)
								local var_12_9 = Mathf.Lerp(iter_12_3.color.g, arg_9_1.hightColor1.g, var_12_7)
								local var_12_10 = Mathf.Lerp(iter_12_3.color.b, arg_9_1.hightColor1.b, var_12_7)

								iter_12_3.color = Color.New(var_12_8, var_12_9, var_12_10)
							else
								local var_12_11 = Mathf.Lerp(iter_12_3.color.r, 1, var_12_7)

								iter_12_3.color = Color.New(var_12_11, var_12_11, var_12_11)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_5 + var_12_6 and arg_9_1.time_ < var_12_5 + var_12_6 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps106103 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_12_5 then
						if arg_9_1.isInRecall_ then
							iter_12_5.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps106103 = nil
			end

			local var_12_12 = arg_9_1.actors_["106103"].transform
			local var_12_13 = 0

			if var_12_13 < arg_9_1.time_ and arg_9_1.time_ <= var_12_13 + arg_12_0 then
				arg_9_1.var_.moveOldPos106103 = var_12_12.localPosition
				var_12_12.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("106103", 2)

				local var_12_14 = var_12_12.childCount

				for iter_12_6 = 0, var_12_14 - 1 do
					local var_12_15 = var_12_12:GetChild(iter_12_6)

					if var_12_15.name == "split_3" or not string.find(var_12_15.name, "split") then
						var_12_15.gameObject:SetActive(true)
					else
						var_12_15.gameObject:SetActive(false)
					end
				end
			end

			local var_12_16 = 0.001

			if var_12_13 <= arg_9_1.time_ and arg_9_1.time_ < var_12_13 + var_12_16 then
				local var_12_17 = (arg_9_1.time_ - var_12_13) / var_12_16
				local var_12_18 = Vector3.New(-428.4, -398.2, -333.7)

				var_12_12.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos106103, var_12_18, var_12_17)
			end

			if arg_9_1.time_ >= var_12_13 + var_12_16 and arg_9_1.time_ < var_12_13 + var_12_16 + arg_12_0 then
				var_12_12.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_12_19 = 0
			local var_12_20 = 0.075

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_21 = arg_9_1:FormatText(StoryNameCfg[612].name)

				arg_9_1.leftNameTxt_.text = var_12_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_22 = arg_9_1:GetWordFromCfg(926021002)
				local var_12_23 = arg_9_1:FormatText(var_12_22.content)

				arg_9_1.text_.text = var_12_23

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_24 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021002", "story_v_out_926021.awb") ~= 0 then
					local var_12_27 = manager.audio:GetVoiceLength("story_v_out_926021", "926021002", "story_v_out_926021.awb") / 1000

					if var_12_27 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_19
					end

					if var_12_22.prefab_name ~= "" and arg_9_1.actors_[var_12_22.prefab_name] ~= nil then
						local var_12_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_22.prefab_name].transform, "story_v_out_926021", "926021002", "story_v_out_926021.awb")

						arg_9_1:RecordAudio("926021002", var_12_28)
						arg_9_1:RecordAudio("926021002", var_12_28)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_926021", "926021002", "story_v_out_926021.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_926021", "926021002", "story_v_out_926021.awb")
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
				actorName = "106103",
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
	Play926021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926021003
		arg_13_1.duration_ = 1.07

		local var_13_0 = {
			zh = 1,
			ja = 1.066
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
				arg_13_0:Play926021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "128404"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

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

			local var_16_4 = arg_13_1.actors_["128404"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps128404 == nil then
				arg_13_1.var_.actorSpriteComps128404 = var_16_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.2

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.actorSpriteComps128404 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps128404 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_16_5 then
						if arg_13_1.isInRecall_ then
							iter_16_5.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps128404 = nil
			end

			local var_16_12 = arg_13_1.actors_["106103"]
			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 and not isNil(var_16_12) and arg_13_1.var_.actorSpriteComps106103 == nil then
				arg_13_1.var_.actorSpriteComps106103 = var_16_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_14 = 0.2

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_14 and not isNil(var_16_12) then
				local var_16_15 = (arg_13_1.time_ - var_16_13) / var_16_14

				if arg_13_1.var_.actorSpriteComps106103 then
					for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_16_7 then
							if arg_13_1.isInRecall_ then
								local var_16_16 = Mathf.Lerp(iter_16_7.color.r, arg_13_1.hightColor2.r, var_16_15)
								local var_16_17 = Mathf.Lerp(iter_16_7.color.g, arg_13_1.hightColor2.g, var_16_15)
								local var_16_18 = Mathf.Lerp(iter_16_7.color.b, arg_13_1.hightColor2.b, var_16_15)

								iter_16_7.color = Color.New(var_16_16, var_16_17, var_16_18)
							else
								local var_16_19 = Mathf.Lerp(iter_16_7.color.r, 0.5, var_16_15)

								iter_16_7.color = Color.New(var_16_19, var_16_19, var_16_19)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_13 + var_16_14 and arg_13_1.time_ < var_16_13 + var_16_14 + arg_16_0 and not isNil(var_16_12) and arg_13_1.var_.actorSpriteComps106103 then
				for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_16_9 then
						if arg_13_1.isInRecall_ then
							iter_16_9.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps106103 = nil
			end

			local var_16_20 = arg_13_1.actors_["128404"].transform
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.var_.moveOldPos128404 = var_16_20.localPosition
				var_16_20.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("128404", 4)

				local var_16_22 = var_16_20.childCount

				for iter_16_10 = 0, var_16_22 - 1 do
					local var_16_23 = var_16_20:GetChild(iter_16_10)

					if var_16_23.name == "split_6" or not string.find(var_16_23.name, "split") then
						var_16_23.gameObject:SetActive(true)
					else
						var_16_23.gameObject:SetActive(false)
					end
				end
			end

			local var_16_24 = 0.001

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_24 then
				local var_16_25 = (arg_13_1.time_ - var_16_21) / var_16_24
				local var_16_26 = Vector3.New(390.2, -356, -362.3)

				var_16_20.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos128404, var_16_26, var_16_25)
			end

			if arg_13_1.time_ >= var_16_21 + var_16_24 and arg_13_1.time_ < var_16_21 + var_16_24 + arg_16_0 then
				var_16_20.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_16_27 = 0
			local var_16_28 = 0.075

			if var_16_27 < arg_13_1.time_ and arg_13_1.time_ <= var_16_27 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_29 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_30 = arg_13_1:GetWordFromCfg(926021003)
				local var_16_31 = arg_13_1:FormatText(var_16_30.content)

				arg_13_1.text_.text = var_16_31

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_32 = 3
				local var_16_33 = utf8.len(var_16_31)
				local var_16_34 = var_16_32 <= 0 and var_16_28 or var_16_28 * (var_16_33 / var_16_32)

				if var_16_34 > 0 and var_16_28 < var_16_34 then
					arg_13_1.talkMaxDuration = var_16_34

					if var_16_34 + var_16_27 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_34 + var_16_27
					end
				end

				arg_13_1.text_.text = var_16_31
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021003", "story_v_out_926021.awb") ~= 0 then
					local var_16_35 = manager.audio:GetVoiceLength("story_v_out_926021", "926021003", "story_v_out_926021.awb") / 1000

					if var_16_35 + var_16_27 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_35 + var_16_27
					end

					if var_16_30.prefab_name ~= "" and arg_13_1.actors_[var_16_30.prefab_name] ~= nil then
						local var_16_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_30.prefab_name].transform, "story_v_out_926021", "926021003", "story_v_out_926021.awb")

						arg_13_1:RecordAudio("926021003", var_16_36)
						arg_13_1:RecordAudio("926021003", var_16_36)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_926021", "926021003", "story_v_out_926021.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_926021", "926021003", "story_v_out_926021.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_37 = math.max(var_16_28, arg_13_1.talkMaxDuration)

			if var_16_27 <= arg_13_1.time_ and arg_13_1.time_ < var_16_27 + var_16_37 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_27) / var_16_37

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_27 + var_16_37 and arg_13_1.time_ < var_16_27 + var_16_37 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926021004
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"

			SetActive(arg_17_1.choicesGo_, true)

			for iter_18_0, iter_18_1 in ipairs(arg_17_1.choices_) do
				local var_18_0 = iter_18_0 <= 1

				SetActive(iter_18_1.go, var_18_0)
			end

			arg_17_1.choices_[1].txt.text = arg_17_1:FormatText(StoryChoiceCfg[1314].name)
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play926021005(arg_17_1)
			end

			arg_17_1:RecordChoiceLog(926021004, 1314)
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["128404"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps128404 == nil then
				arg_17_1.var_.actorSpriteComps128404 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps128404 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps128404 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play926021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926021005
		arg_21_1.duration_ = 11.93

		local var_21_0 = {
			zh = 10.966,
			ja = 11.933
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
				arg_21_0:Play926021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "10144"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(var_24_1, arg_21_1.canvasGo_.transform)

					var_24_2.transform:SetSiblingIndex(1)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_21_1.isInRecall_ then
						for iter_24_0, iter_24_1 in ipairs(var_24_3) do
							iter_24_1.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_4 = arg_21_1.actors_["10144"]
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.actorSpriteComps10144 == nil then
				arg_21_1.var_.actorSpriteComps10144 = var_24_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 0.2

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 and not isNil(var_24_4) then
				local var_24_7 = (arg_21_1.time_ - var_24_5) / var_24_6

				if arg_21_1.var_.actorSpriteComps10144 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								local var_24_8 = Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor1.r, var_24_7)
								local var_24_9 = Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor1.g, var_24_7)
								local var_24_10 = Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor1.b, var_24_7)

								iter_24_3.color = Color.New(var_24_8, var_24_9, var_24_10)
							else
								local var_24_11 = Mathf.Lerp(iter_24_3.color.r, 1, var_24_7)

								iter_24_3.color = Color.New(var_24_11, var_24_11, var_24_11)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.actorSpriteComps10144 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_24_5 then
						if arg_21_1.isInRecall_ then
							iter_24_5.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10144 = nil
			end

			local var_24_12 = arg_21_1.actors_["128404"].transform
			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1.var_.moveOldPos128404 = var_24_12.localPosition
				var_24_12.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("128404", 7)

				local var_24_14 = var_24_12.childCount

				for iter_24_6 = 0, var_24_14 - 1 do
					local var_24_15 = var_24_12:GetChild(iter_24_6)

					if var_24_15.name == "split_2" or not string.find(var_24_15.name, "split") then
						var_24_15.gameObject:SetActive(true)
					else
						var_24_15.gameObject:SetActive(false)
					end
				end
			end

			local var_24_16 = 0.001

			if var_24_13 <= arg_21_1.time_ and arg_21_1.time_ < var_24_13 + var_24_16 then
				local var_24_17 = (arg_21_1.time_ - var_24_13) / var_24_16
				local var_24_18 = Vector3.New(0, -2000, 0)

				var_24_12.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos128404, var_24_18, var_24_17)
			end

			if arg_21_1.time_ >= var_24_13 + var_24_16 and arg_21_1.time_ < var_24_13 + var_24_16 + arg_24_0 then
				var_24_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_19 = arg_21_1.actors_["10144"].transform
			local var_24_20 = 0

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1.var_.moveOldPos10144 = var_24_19.localPosition
				var_24_19.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10144", 3)

				local var_24_21 = var_24_19.childCount

				for iter_24_7 = 0, var_24_21 - 1 do
					local var_24_22 = var_24_19:GetChild(iter_24_7)

					if var_24_22.name == "split_2" or not string.find(var_24_22.name, "split") then
						var_24_22.gameObject:SetActive(true)
					else
						var_24_22.gameObject:SetActive(false)
					end
				end
			end

			local var_24_23 = 0.001

			if var_24_20 <= arg_21_1.time_ and arg_21_1.time_ < var_24_20 + var_24_23 then
				local var_24_24 = (arg_21_1.time_ - var_24_20) / var_24_23
				local var_24_25 = Vector3.New(-31.5, -381.1, -285.9)

				var_24_19.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10144, var_24_25, var_24_24)
			end

			if arg_21_1.time_ >= var_24_20 + var_24_23 and arg_21_1.time_ < var_24_20 + var_24_23 + arg_24_0 then
				var_24_19.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_24_26 = arg_21_1.actors_["106103"].transform
			local var_24_27 = 0

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				arg_21_1.var_.moveOldPos106103 = var_24_26.localPosition
				var_24_26.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("106103", 7)

				local var_24_28 = var_24_26.childCount

				for iter_24_8 = 0, var_24_28 - 1 do
					local var_24_29 = var_24_26:GetChild(iter_24_8)

					if var_24_29.name == "split_3" or not string.find(var_24_29.name, "split") then
						var_24_29.gameObject:SetActive(true)
					else
						var_24_29.gameObject:SetActive(false)
					end
				end
			end

			local var_24_30 = 0.001

			if var_24_27 <= arg_21_1.time_ and arg_21_1.time_ < var_24_27 + var_24_30 then
				local var_24_31 = (arg_21_1.time_ - var_24_27) / var_24_30
				local var_24_32 = Vector3.New(0, -2000, 0)

				var_24_26.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos106103, var_24_32, var_24_31)
			end

			if arg_21_1.time_ >= var_24_27 + var_24_30 and arg_21_1.time_ < var_24_27 + var_24_30 + arg_24_0 then
				var_24_26.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_33 = 0
			local var_24_34 = 1.125

			if var_24_33 < arg_21_1.time_ and arg_21_1.time_ <= var_24_33 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_35 = arg_21_1:FormatText(StoryNameCfg[1297].name)

				arg_21_1.leftNameTxt_.text = var_24_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_36 = arg_21_1:GetWordFromCfg(926021005)
				local var_24_37 = arg_21_1:FormatText(var_24_36.content)

				arg_21_1.text_.text = var_24_37

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_38 = 45
				local var_24_39 = utf8.len(var_24_37)
				local var_24_40 = var_24_38 <= 0 and var_24_34 or var_24_34 * (var_24_39 / var_24_38)

				if var_24_40 > 0 and var_24_34 < var_24_40 then
					arg_21_1.talkMaxDuration = var_24_40

					if var_24_40 + var_24_33 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_40 + var_24_33
					end
				end

				arg_21_1.text_.text = var_24_37
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021005", "story_v_out_926021.awb") ~= 0 then
					local var_24_41 = manager.audio:GetVoiceLength("story_v_out_926021", "926021005", "story_v_out_926021.awb") / 1000

					if var_24_41 + var_24_33 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_41 + var_24_33
					end

					if var_24_36.prefab_name ~= "" and arg_21_1.actors_[var_24_36.prefab_name] ~= nil then
						local var_24_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_36.prefab_name].transform, "story_v_out_926021", "926021005", "story_v_out_926021.awb")

						arg_21_1:RecordAudio("926021005", var_24_42)
						arg_21_1:RecordAudio("926021005", var_24_42)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_926021", "926021005", "story_v_out_926021.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_926021", "926021005", "story_v_out_926021.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_43 = math.max(var_24_34, arg_21_1.talkMaxDuration)

			if var_24_33 <= arg_21_1.time_ and arg_21_1.time_ < var_24_33 + var_24_43 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_33) / var_24_43

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_33 + var_24_43 and arg_21_1.time_ < var_24_33 + var_24_43 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
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
	Play926021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 926021006
		arg_25_1.duration_ = 12

		local var_25_0 = {
			zh = 6.833,
			ja = 12
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
				arg_25_0:Play926021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10144"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10144 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10144", 3)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "split_7" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10144, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_28_7 = 0
			local var_28_8 = 0.775

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_9 = arg_25_1:FormatText(StoryNameCfg[1297].name)

				arg_25_1.leftNameTxt_.text = var_28_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(926021006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 31
				local var_28_13 = utf8.len(var_28_11)
				local var_28_14 = var_28_12 <= 0 and var_28_8 or var_28_8 * (var_28_13 / var_28_12)

				if var_28_14 > 0 and var_28_8 < var_28_14 then
					arg_25_1.talkMaxDuration = var_28_14

					if var_28_14 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021006", "story_v_out_926021.awb") ~= 0 then
					local var_28_15 = manager.audio:GetVoiceLength("story_v_out_926021", "926021006", "story_v_out_926021.awb") / 1000

					if var_28_15 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_7
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_926021", "926021006", "story_v_out_926021.awb")

						arg_25_1:RecordAudio("926021006", var_28_16)
						arg_25_1:RecordAudio("926021006", var_28_16)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_926021", "926021006", "story_v_out_926021.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_926021", "926021006", "story_v_out_926021.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_17 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_17 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_17

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_17 and arg_25_1.time_ < var_28_7 + var_28_17 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926021007
		arg_29_1.duration_ = 1.33

		local var_29_0 = {
			zh = 1.2,
			ja = 1.333
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
				arg_29_0:Play926021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "104701"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(var_32_1, arg_29_1.canvasGo_.transform)

					var_32_2.transform:SetSiblingIndex(1)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_29_1.isInRecall_ then
						for iter_32_0, iter_32_1 in ipairs(var_32_3) do
							iter_32_1.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_4 = arg_29_1.actors_["104701"]
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.actorSpriteComps104701 == nil then
				arg_29_1.var_.actorSpriteComps104701 = var_32_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_6 = 0.2

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 and not isNil(var_32_4) then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / var_32_6

				if arg_29_1.var_.actorSpriteComps104701 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_32_3 then
							if arg_29_1.isInRecall_ then
								local var_32_8 = Mathf.Lerp(iter_32_3.color.r, arg_29_1.hightColor1.r, var_32_7)
								local var_32_9 = Mathf.Lerp(iter_32_3.color.g, arg_29_1.hightColor1.g, var_32_7)
								local var_32_10 = Mathf.Lerp(iter_32_3.color.b, arg_29_1.hightColor1.b, var_32_7)

								iter_32_3.color = Color.New(var_32_8, var_32_9, var_32_10)
							else
								local var_32_11 = Mathf.Lerp(iter_32_3.color.r, 1, var_32_7)

								iter_32_3.color = Color.New(var_32_11, var_32_11, var_32_11)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.actorSpriteComps104701 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_32_5 then
						if arg_29_1.isInRecall_ then
							iter_32_5.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps104701 = nil
			end

			local var_32_12 = arg_29_1.actors_["10144"]
			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 and not isNil(var_32_12) and arg_29_1.var_.actorSpriteComps10144 == nil then
				arg_29_1.var_.actorSpriteComps10144 = var_32_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_14 = 0.2

			if var_32_13 <= arg_29_1.time_ and arg_29_1.time_ < var_32_13 + var_32_14 and not isNil(var_32_12) then
				local var_32_15 = (arg_29_1.time_ - var_32_13) / var_32_14

				if arg_29_1.var_.actorSpriteComps10144 then
					for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_32_7 then
							if arg_29_1.isInRecall_ then
								local var_32_16 = Mathf.Lerp(iter_32_7.color.r, arg_29_1.hightColor2.r, var_32_15)
								local var_32_17 = Mathf.Lerp(iter_32_7.color.g, arg_29_1.hightColor2.g, var_32_15)
								local var_32_18 = Mathf.Lerp(iter_32_7.color.b, arg_29_1.hightColor2.b, var_32_15)

								iter_32_7.color = Color.New(var_32_16, var_32_17, var_32_18)
							else
								local var_32_19 = Mathf.Lerp(iter_32_7.color.r, 0.5, var_32_15)

								iter_32_7.color = Color.New(var_32_19, var_32_19, var_32_19)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_13 + var_32_14 and arg_29_1.time_ < var_32_13 + var_32_14 + arg_32_0 and not isNil(var_32_12) and arg_29_1.var_.actorSpriteComps10144 then
				for iter_32_8, iter_32_9 in pairs(arg_29_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_32_9 then
						if arg_29_1.isInRecall_ then
							iter_32_9.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10144 = nil
			end

			local var_32_20 = 0
			local var_32_21 = 0.075

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_22 = arg_29_1:FormatText(StoryNameCfg[1296].name)

				arg_29_1.leftNameTxt_.text = var_32_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_23 = arg_29_1:GetWordFromCfg(926021007)
				local var_32_24 = arg_29_1:FormatText(var_32_23.content)

				arg_29_1.text_.text = var_32_24

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_25 = 3
				local var_32_26 = utf8.len(var_32_24)
				local var_32_27 = var_32_25 <= 0 and var_32_21 or var_32_21 * (var_32_26 / var_32_25)

				if var_32_27 > 0 and var_32_21 < var_32_27 then
					arg_29_1.talkMaxDuration = var_32_27

					if var_32_27 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_27 + var_32_20
					end
				end

				arg_29_1.text_.text = var_32_24
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021007", "story_v_out_926021.awb") ~= 0 then
					local var_32_28 = manager.audio:GetVoiceLength("story_v_out_926021", "926021007", "story_v_out_926021.awb") / 1000

					if var_32_28 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_20
					end

					if var_32_23.prefab_name ~= "" and arg_29_1.actors_[var_32_23.prefab_name] ~= nil then
						local var_32_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_23.prefab_name].transform, "story_v_out_926021", "926021007", "story_v_out_926021.awb")

						arg_29_1:RecordAudio("926021007", var_32_29)
						arg_29_1:RecordAudio("926021007", var_32_29)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926021", "926021007", "story_v_out_926021.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926021", "926021007", "story_v_out_926021.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_30 = math.max(var_32_21, arg_29_1.talkMaxDuration)

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_30 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_20) / var_32_30

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_20 + var_32_30 and arg_29_1.time_ < var_32_20 + var_32_30 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play926021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926021008
		arg_33_1.duration_ = 9.47

		local var_33_0 = {
			zh = 6.7,
			ja = 9.466
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
				arg_33_0:Play926021009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10144"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10144 == nil then
				arg_33_1.var_.actorSpriteComps10144 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10144 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10144 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10144 = nil
			end

			local var_36_8 = arg_33_1.actors_["104701"]
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps104701 == nil then
				arg_33_1.var_.actorSpriteComps104701 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_10 = 0.2

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_10 and not isNil(var_36_8) then
				local var_36_11 = (arg_33_1.time_ - var_36_9) / var_36_10

				if arg_33_1.var_.actorSpriteComps104701 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_33_1.time_ >= var_36_9 + var_36_10 and arg_33_1.time_ < var_36_9 + var_36_10 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps104701 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_36_7 then
						if arg_33_1.isInRecall_ then
							iter_36_7.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps104701 = nil
			end

			local var_36_16 = arg_33_1.actors_["10144"].transform
			local var_36_17 = 0

			if var_36_17 < arg_33_1.time_ and arg_33_1.time_ <= var_36_17 + arg_36_0 then
				arg_33_1.var_.moveOldPos10144 = var_36_16.localPosition
				var_36_16.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10144", 3)

				local var_36_18 = var_36_16.childCount

				for iter_36_8 = 0, var_36_18 - 1 do
					local var_36_19 = var_36_16:GetChild(iter_36_8)

					if var_36_19.name == "" or not string.find(var_36_19.name, "split") then
						var_36_19.gameObject:SetActive(true)
					else
						var_36_19.gameObject:SetActive(false)
					end
				end
			end

			local var_36_20 = 0.001

			if var_36_17 <= arg_33_1.time_ and arg_33_1.time_ < var_36_17 + var_36_20 then
				local var_36_21 = (arg_33_1.time_ - var_36_17) / var_36_20
				local var_36_22 = Vector3.New(-31.5, -381.1, -285.9)

				var_36_16.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10144, var_36_22, var_36_21)
			end

			if arg_33_1.time_ >= var_36_17 + var_36_20 and arg_33_1.time_ < var_36_17 + var_36_20 + arg_36_0 then
				var_36_16.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_36_23 = 0
			local var_36_24 = 0.725

			if var_36_23 < arg_33_1.time_ and arg_33_1.time_ <= var_36_23 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_25 = arg_33_1:FormatText(StoryNameCfg[1297].name)

				arg_33_1.leftNameTxt_.text = var_36_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_26 = arg_33_1:GetWordFromCfg(926021008)
				local var_36_27 = arg_33_1:FormatText(var_36_26.content)

				arg_33_1.text_.text = var_36_27

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_28 = 29
				local var_36_29 = utf8.len(var_36_27)
				local var_36_30 = var_36_28 <= 0 and var_36_24 or var_36_24 * (var_36_29 / var_36_28)

				if var_36_30 > 0 and var_36_24 < var_36_30 then
					arg_33_1.talkMaxDuration = var_36_30

					if var_36_30 + var_36_23 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_30 + var_36_23
					end
				end

				arg_33_1.text_.text = var_36_27
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021008", "story_v_out_926021.awb") ~= 0 then
					local var_36_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021008", "story_v_out_926021.awb") / 1000

					if var_36_31 + var_36_23 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_31 + var_36_23
					end

					if var_36_26.prefab_name ~= "" and arg_33_1.actors_[var_36_26.prefab_name] ~= nil then
						local var_36_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_26.prefab_name].transform, "story_v_out_926021", "926021008", "story_v_out_926021.awb")

						arg_33_1:RecordAudio("926021008", var_36_32)
						arg_33_1:RecordAudio("926021008", var_36_32)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_926021", "926021008", "story_v_out_926021.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_926021", "926021008", "story_v_out_926021.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_33 = math.max(var_36_24, arg_33_1.talkMaxDuration)

			if var_36_23 <= arg_33_1.time_ and arg_33_1.time_ < var_36_23 + var_36_33 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_23) / var_36_33

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_23 + var_36_33 and arg_33_1.time_ < var_36_23 + var_36_33 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926021009
		arg_37_1.duration_ = 1.97

		local var_37_0 = {
			zh = 1.533,
			ja = 1.966
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
				arg_37_0:Play926021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["106103"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps106103 == nil then
				arg_37_1.var_.actorSpriteComps106103 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps106103 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps106103 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps106103 = nil
			end

			local var_40_8 = arg_37_1.actors_["10144"]
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10144 == nil then
				arg_37_1.var_.actorSpriteComps10144 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_10 = 0.2

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 and not isNil(var_40_8) then
				local var_40_11 = (arg_37_1.time_ - var_40_9) / var_40_10

				if arg_37_1.var_.actorSpriteComps10144 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10144 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_40_7 then
						if arg_37_1.isInRecall_ then
							iter_40_7.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10144 = nil
			end

			local var_40_16 = arg_37_1.actors_["10144"].transform
			local var_40_17 = 0

			if var_40_17 < arg_37_1.time_ and arg_37_1.time_ <= var_40_17 + arg_40_0 then
				arg_37_1.var_.moveOldPos10144 = var_40_16.localPosition
				var_40_16.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10144", 7)

				local var_40_18 = var_40_16.childCount

				for iter_40_8 = 0, var_40_18 - 1 do
					local var_40_19 = var_40_16:GetChild(iter_40_8)

					if var_40_19.name == "" or not string.find(var_40_19.name, "split") then
						var_40_19.gameObject:SetActive(true)
					else
						var_40_19.gameObject:SetActive(false)
					end
				end
			end

			local var_40_20 = 0.001

			if var_40_17 <= arg_37_1.time_ and arg_37_1.time_ < var_40_17 + var_40_20 then
				local var_40_21 = (arg_37_1.time_ - var_40_17) / var_40_20
				local var_40_22 = Vector3.New(0, -2000, 0)

				var_40_16.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10144, var_40_22, var_40_21)
			end

			if arg_37_1.time_ >= var_40_17 + var_40_20 and arg_37_1.time_ < var_40_17 + var_40_20 + arg_40_0 then
				var_40_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_23 = arg_37_1.actors_["106103"].transform
			local var_40_24 = 0

			if var_40_24 < arg_37_1.time_ and arg_37_1.time_ <= var_40_24 + arg_40_0 then
				arg_37_1.var_.moveOldPos106103 = var_40_23.localPosition
				var_40_23.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("106103", 2)

				local var_40_25 = var_40_23.childCount

				for iter_40_9 = 0, var_40_25 - 1 do
					local var_40_26 = var_40_23:GetChild(iter_40_9)

					if var_40_26.name == "" or not string.find(var_40_26.name, "split") then
						var_40_26.gameObject:SetActive(true)
					else
						var_40_26.gameObject:SetActive(false)
					end
				end
			end

			local var_40_27 = 0.001

			if var_40_24 <= arg_37_1.time_ and arg_37_1.time_ < var_40_24 + var_40_27 then
				local var_40_28 = (arg_37_1.time_ - var_40_24) / var_40_27
				local var_40_29 = Vector3.New(-428.4, -398.2, -333.7)

				var_40_23.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos106103, var_40_29, var_40_28)
			end

			if arg_37_1.time_ >= var_40_24 + var_40_27 and arg_37_1.time_ < var_40_24 + var_40_27 + arg_40_0 then
				var_40_23.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_40_30 = 0
			local var_40_31 = 0.125

			if var_40_30 < arg_37_1.time_ and arg_37_1.time_ <= var_40_30 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_32 = arg_37_1:FormatText(StoryNameCfg[612].name)

				arg_37_1.leftNameTxt_.text = var_40_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_33 = arg_37_1:GetWordFromCfg(926021009)
				local var_40_34 = arg_37_1:FormatText(var_40_33.content)

				arg_37_1.text_.text = var_40_34

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_35 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021009", "story_v_out_926021.awb") ~= 0 then
					local var_40_38 = manager.audio:GetVoiceLength("story_v_out_926021", "926021009", "story_v_out_926021.awb") / 1000

					if var_40_38 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_38 + var_40_30
					end

					if var_40_33.prefab_name ~= "" and arg_37_1.actors_[var_40_33.prefab_name] ~= nil then
						local var_40_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_33.prefab_name].transform, "story_v_out_926021", "926021009", "story_v_out_926021.awb")

						arg_37_1:RecordAudio("926021009", var_40_39)
						arg_37_1:RecordAudio("926021009", var_40_39)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926021", "926021009", "story_v_out_926021.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926021", "926021009", "story_v_out_926021.awb")
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
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
	Play926021010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926021010
		arg_41_1.duration_ = 3.47

		local var_41_0 = {
			zh = 2.233,
			ja = 3.466
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
				arg_41_0:Play926021011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["128404"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps128404 == nil then
				arg_41_1.var_.actorSpriteComps128404 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps128404 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps128404 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps128404 = nil
			end

			local var_44_8 = arg_41_1.actors_["106103"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps106103 == nil then
				arg_41_1.var_.actorSpriteComps106103 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps106103 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps106103 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps106103 = nil
			end

			local var_44_16 = arg_41_1.actors_["128404"].transform
			local var_44_17 = 0

			if var_44_17 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				arg_41_1.var_.moveOldPos128404 = var_44_16.localPosition
				var_44_16.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("128404", 4)

				local var_44_18 = var_44_16.childCount

				for iter_44_8 = 0, var_44_18 - 1 do
					local var_44_19 = var_44_16:GetChild(iter_44_8)

					if var_44_19.name == "" or not string.find(var_44_19.name, "split") then
						var_44_19.gameObject:SetActive(true)
					else
						var_44_19.gameObject:SetActive(false)
					end
				end
			end

			local var_44_20 = 0.001

			if var_44_17 <= arg_41_1.time_ and arg_41_1.time_ < var_44_17 + var_44_20 then
				local var_44_21 = (arg_41_1.time_ - var_44_17) / var_44_20
				local var_44_22 = Vector3.New(390.2, -356, -362.3)

				var_44_16.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos128404, var_44_22, var_44_21)
			end

			if arg_41_1.time_ >= var_44_17 + var_44_20 and arg_41_1.time_ < var_44_17 + var_44_20 + arg_44_0 then
				var_44_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_44_23 = 0
			local var_44_24 = 0.2

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_25 = arg_41_1:FormatText(StoryNameCfg[6].name)

				arg_41_1.leftNameTxt_.text = var_44_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_26 = arg_41_1:GetWordFromCfg(926021010)
				local var_44_27 = arg_41_1:FormatText(var_44_26.content)

				arg_41_1.text_.text = var_44_27

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_28 = 8
				local var_44_29 = utf8.len(var_44_27)
				local var_44_30 = var_44_28 <= 0 and var_44_24 or var_44_24 * (var_44_29 / var_44_28)

				if var_44_30 > 0 and var_44_24 < var_44_30 then
					arg_41_1.talkMaxDuration = var_44_30

					if var_44_30 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_30 + var_44_23
					end
				end

				arg_41_1.text_.text = var_44_27
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021010", "story_v_out_926021.awb") ~= 0 then
					local var_44_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021010", "story_v_out_926021.awb") / 1000

					if var_44_31 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_23
					end

					if var_44_26.prefab_name ~= "" and arg_41_1.actors_[var_44_26.prefab_name] ~= nil then
						local var_44_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_26.prefab_name].transform, "story_v_out_926021", "926021010", "story_v_out_926021.awb")

						arg_41_1:RecordAudio("926021010", var_44_32)
						arg_41_1:RecordAudio("926021010", var_44_32)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926021", "926021010", "story_v_out_926021.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926021", "926021010", "story_v_out_926021.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_33 = math.max(var_44_24, arg_41_1.talkMaxDuration)

			if var_44_23 <= arg_41_1.time_ and arg_41_1.time_ < var_44_23 + var_44_33 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_23) / var_44_33

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_23 + var_44_33 and arg_41_1.time_ < var_44_23 + var_44_33 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926021011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926021011
		arg_45_1.duration_ = 1

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"

			SetActive(arg_45_1.choicesGo_, true)

			for iter_46_0, iter_46_1 in ipairs(arg_45_1.choices_) do
				local var_46_0 = iter_46_0 <= 1

				SetActive(iter_46_1.go, var_46_0)
			end

			arg_45_1.choices_[1].txt.text = arg_45_1:FormatText(StoryChoiceCfg[1315].name)
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play926021012(arg_45_1)
			end

			arg_45_1:RecordChoiceLog(926021011, 1315)
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["128404"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps128404 == nil then
				arg_45_1.var_.actorSpriteComps128404 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps128404 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps128404 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play926021012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926021012
		arg_49_1.duration_ = 6.7

		local var_49_0 = {
			zh = 5.466,
			ja = 6.7
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
				arg_49_0:Play926021013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10144"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10144 == nil then
				arg_49_1.var_.actorSpriteComps10144 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10144 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10144 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10144 = nil
			end

			local var_52_8 = arg_49_1.actors_["128404"].transform
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1.var_.moveOldPos128404 = var_52_8.localPosition
				var_52_8.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("128404", 7)

				local var_52_10 = var_52_8.childCount

				for iter_52_4 = 0, var_52_10 - 1 do
					local var_52_11 = var_52_8:GetChild(iter_52_4)

					if var_52_11.name == "" or not string.find(var_52_11.name, "split") then
						var_52_11.gameObject:SetActive(true)
					else
						var_52_11.gameObject:SetActive(false)
					end
				end
			end

			local var_52_12 = 0.001

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_12 then
				local var_52_13 = (arg_49_1.time_ - var_52_9) / var_52_12
				local var_52_14 = Vector3.New(0, -2000, 0)

				var_52_8.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos128404, var_52_14, var_52_13)
			end

			if arg_49_1.time_ >= var_52_9 + var_52_12 and arg_49_1.time_ < var_52_9 + var_52_12 + arg_52_0 then
				var_52_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_15 = arg_49_1.actors_["106103"].transform
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.var_.moveOldPos106103 = var_52_15.localPosition
				var_52_15.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("106103", 7)

				local var_52_17 = var_52_15.childCount

				for iter_52_5 = 0, var_52_17 - 1 do
					local var_52_18 = var_52_15:GetChild(iter_52_5)

					if var_52_18.name == "" or not string.find(var_52_18.name, "split") then
						var_52_18.gameObject:SetActive(true)
					else
						var_52_18.gameObject:SetActive(false)
					end
				end
			end

			local var_52_19 = 0.001

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_19 then
				local var_52_20 = (arg_49_1.time_ - var_52_16) / var_52_19
				local var_52_21 = Vector3.New(0, -2000, 0)

				var_52_15.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos106103, var_52_21, var_52_20)
			end

			if arg_49_1.time_ >= var_52_16 + var_52_19 and arg_49_1.time_ < var_52_16 + var_52_19 + arg_52_0 then
				var_52_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_22 = arg_49_1.actors_["10144"].transform
			local var_52_23 = 0

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.var_.moveOldPos10144 = var_52_22.localPosition
				var_52_22.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10144", 3)

				local var_52_24 = var_52_22.childCount

				for iter_52_6 = 0, var_52_24 - 1 do
					local var_52_25 = var_52_22:GetChild(iter_52_6)

					if var_52_25.name == "" or not string.find(var_52_25.name, "split") then
						var_52_25.gameObject:SetActive(true)
					else
						var_52_25.gameObject:SetActive(false)
					end
				end
			end

			local var_52_26 = 0.001

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_26 then
				local var_52_27 = (arg_49_1.time_ - var_52_23) / var_52_26
				local var_52_28 = Vector3.New(-31.5, -381.1, -285.9)

				var_52_22.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10144, var_52_28, var_52_27)
			end

			if arg_49_1.time_ >= var_52_23 + var_52_26 and arg_49_1.time_ < var_52_23 + var_52_26 + arg_52_0 then
				var_52_22.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_52_29 = 0
			local var_52_30 = 0.5

			if var_52_29 < arg_49_1.time_ and arg_49_1.time_ <= var_52_29 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_31 = arg_49_1:FormatText(StoryNameCfg[1297].name)

				arg_49_1.leftNameTxt_.text = var_52_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_32 = arg_49_1:GetWordFromCfg(926021012)
				local var_52_33 = arg_49_1:FormatText(var_52_32.content)

				arg_49_1.text_.text = var_52_33

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_34 = 20
				local var_52_35 = utf8.len(var_52_33)
				local var_52_36 = var_52_34 <= 0 and var_52_30 or var_52_30 * (var_52_35 / var_52_34)

				if var_52_36 > 0 and var_52_30 < var_52_36 then
					arg_49_1.talkMaxDuration = var_52_36

					if var_52_36 + var_52_29 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_36 + var_52_29
					end
				end

				arg_49_1.text_.text = var_52_33
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021012", "story_v_out_926021.awb") ~= 0 then
					local var_52_37 = manager.audio:GetVoiceLength("story_v_out_926021", "926021012", "story_v_out_926021.awb") / 1000

					if var_52_37 + var_52_29 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_37 + var_52_29
					end

					if var_52_32.prefab_name ~= "" and arg_49_1.actors_[var_52_32.prefab_name] ~= nil then
						local var_52_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_32.prefab_name].transform, "story_v_out_926021", "926021012", "story_v_out_926021.awb")

						arg_49_1:RecordAudio("926021012", var_52_38)
						arg_49_1:RecordAudio("926021012", var_52_38)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926021", "926021012", "story_v_out_926021.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926021", "926021012", "story_v_out_926021.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_39 = math.max(var_52_30, arg_49_1.talkMaxDuration)

			if var_52_29 <= arg_49_1.time_ and arg_49_1.time_ < var_52_29 + var_52_39 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_29) / var_52_39

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_29 + var_52_39 and arg_49_1.time_ < var_52_29 + var_52_39 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926021013
		arg_53_1.duration_ = 12.93

		local var_53_0 = {
			zh = 8.166,
			ja = 12.933
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
				arg_53_0:Play926021014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.05

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1297].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(926021013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021013", "story_v_out_926021.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021013", "story_v_out_926021.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_926021", "926021013", "story_v_out_926021.awb")

						arg_53_1:RecordAudio("926021013", var_56_9)
						arg_53_1:RecordAudio("926021013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_926021", "926021013", "story_v_out_926021.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_926021", "926021013", "story_v_out_926021.awb")
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
	Play926021014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926021014
		arg_57_1.duration_ = 5.97

		local var_57_0 = {
			zh = 4.3,
			ja = 5.966
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
				arg_57_0:Play926021015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10144"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10144 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10144", 3)

				local var_60_2 = var_60_0.childCount

				for iter_60_0 = 0, var_60_2 - 1 do
					local var_60_3 = var_60_0:GetChild(iter_60_0)

					if var_60_3.name == "split_2" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_4 then
				local var_60_5 = (arg_57_1.time_ - var_60_1) / var_60_4
				local var_60_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10144, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_60_7 = 0
			local var_60_8 = 0.5

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_9 = arg_57_1:FormatText(StoryNameCfg[1297].name)

				arg_57_1.leftNameTxt_.text = var_60_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(926021014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_12 = 20
				local var_60_13 = utf8.len(var_60_11)
				local var_60_14 = var_60_12 <= 0 and var_60_8 or var_60_8 * (var_60_13 / var_60_12)

				if var_60_14 > 0 and var_60_8 < var_60_14 then
					arg_57_1.talkMaxDuration = var_60_14

					if var_60_14 + var_60_7 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_7
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021014", "story_v_out_926021.awb") ~= 0 then
					local var_60_15 = manager.audio:GetVoiceLength("story_v_out_926021", "926021014", "story_v_out_926021.awb") / 1000

					if var_60_15 + var_60_7 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_7
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_926021", "926021014", "story_v_out_926021.awb")

						arg_57_1:RecordAudio("926021014", var_60_16)
						arg_57_1:RecordAudio("926021014", var_60_16)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_926021", "926021014", "story_v_out_926021.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_926021", "926021014", "story_v_out_926021.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_17 = math.max(var_60_8, arg_57_1.talkMaxDuration)

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_17 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_7) / var_60_17

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_7 + var_60_17 and arg_57_1.time_ < var_60_7 + var_60_17 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926021015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play926021016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10144"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10144 == nil then
				arg_61_1.var_.actorSpriteComps10144 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10144 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10144 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10144 = nil
			end

			local var_64_8 = 0
			local var_64_9 = 0.325

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_10 = arg_61_1:FormatText(StoryNameCfg[7].name)

				arg_61_1.leftNameTxt_.text = var_64_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_11 = arg_61_1:GetWordFromCfg(926021015)
				local var_64_12 = arg_61_1:FormatText(var_64_11.content)

				arg_61_1.text_.text = var_64_12

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 13
				local var_64_14 = utf8.len(var_64_12)
				local var_64_15 = var_64_13 <= 0 and var_64_9 or var_64_9 * (var_64_14 / var_64_13)

				if var_64_15 > 0 and var_64_9 < var_64_15 then
					arg_61_1.talkMaxDuration = var_64_15

					if var_64_15 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_15 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_12
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play926021016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926021016
		arg_65_1.duration_ = 8.83

		local var_65_0 = {
			zh = 6.333,
			ja = 8.833
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
				arg_65_0:Play926021017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10144"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10144 == nil then
				arg_65_1.var_.actorSpriteComps10144 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10144 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 1, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10144 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10144 = nil
			end

			local var_68_8 = arg_65_1.actors_["10144"].transform
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.var_.moveOldPos10144 = var_68_8.localPosition
				var_68_8.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10144", 3)

				local var_68_10 = var_68_8.childCount

				for iter_68_4 = 0, var_68_10 - 1 do
					local var_68_11 = var_68_8:GetChild(iter_68_4)

					if var_68_11.name == "" or not string.find(var_68_11.name, "split") then
						var_68_11.gameObject:SetActive(true)
					else
						var_68_11.gameObject:SetActive(false)
					end
				end
			end

			local var_68_12 = 0.001

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_12 then
				local var_68_13 = (arg_65_1.time_ - var_68_9) / var_68_12
				local var_68_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_68_8.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10144, var_68_14, var_68_13)
			end

			if arg_65_1.time_ >= var_68_9 + var_68_12 and arg_65_1.time_ < var_68_9 + var_68_12 + arg_68_0 then
				var_68_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_68_15 = 0
			local var_68_16 = 0.7

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[1297].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(926021016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 28
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021016", "story_v_out_926021.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_926021", "926021016", "story_v_out_926021.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_926021", "926021016", "story_v_out_926021.awb")

						arg_65_1:RecordAudio("926021016", var_68_24)
						arg_65_1:RecordAudio("926021016", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_926021", "926021016", "story_v_out_926021.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_926021", "926021016", "story_v_out_926021.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926021017
		arg_69_1.duration_ = 13.67

		local var_69_0 = {
			zh = 10.433,
			ja = 13.666
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
				arg_69_0:Play926021018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.1

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[1297].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(926021017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 44
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021017", "story_v_out_926021.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021017", "story_v_out_926021.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_926021", "926021017", "story_v_out_926021.awb")

						arg_69_1:RecordAudio("926021017", var_72_9)
						arg_69_1:RecordAudio("926021017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_926021", "926021017", "story_v_out_926021.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_926021", "926021017", "story_v_out_926021.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play926021018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926021018
		arg_73_1.duration_ = 10.7

		local var_73_0 = {
			zh = 8.2,
			ja = 10.7
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
				arg_73_0:Play926021019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10144"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10144 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10144", 3)

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
				local var_76_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10144, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_76_7 = 0
			local var_76_8 = 1.05

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_9 = arg_73_1:FormatText(StoryNameCfg[1297].name)

				arg_73_1.leftNameTxt_.text = var_76_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(926021018)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_12 = 42
				local var_76_13 = utf8.len(var_76_11)
				local var_76_14 = var_76_12 <= 0 and var_76_8 or var_76_8 * (var_76_13 / var_76_12)

				if var_76_14 > 0 and var_76_8 < var_76_14 then
					arg_73_1.talkMaxDuration = var_76_14

					if var_76_14 + var_76_7 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_7
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021018", "story_v_out_926021.awb") ~= 0 then
					local var_76_15 = manager.audio:GetVoiceLength("story_v_out_926021", "926021018", "story_v_out_926021.awb") / 1000

					if var_76_15 + var_76_7 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_15 + var_76_7
					end

					if var_76_10.prefab_name ~= "" and arg_73_1.actors_[var_76_10.prefab_name] ~= nil then
						local var_76_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_10.prefab_name].transform, "story_v_out_926021", "926021018", "story_v_out_926021.awb")

						arg_73_1:RecordAudio("926021018", var_76_16)
						arg_73_1:RecordAudio("926021018", var_76_16)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_926021", "926021018", "story_v_out_926021.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_926021", "926021018", "story_v_out_926021.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_17 = math.max(var_76_8, arg_73_1.talkMaxDuration)

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_17 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_7) / var_76_17

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_7 + var_76_17 and arg_73_1.time_ < var_76_7 + var_76_17 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926021019
		arg_77_1.duration_ = 2.6

		local var_77_0 = {
			zh = 2.6,
			ja = 2.3
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
				arg_77_0:Play926021020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.35

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[1297].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(926021019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 14
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021019", "story_v_out_926021.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021019", "story_v_out_926021.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_926021", "926021019", "story_v_out_926021.awb")

						arg_77_1:RecordAudio("926021019", var_80_9)
						arg_77_1:RecordAudio("926021019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_926021", "926021019", "story_v_out_926021.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_926021", "926021019", "story_v_out_926021.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play926021020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 926021020
		arg_81_1.duration_ = 1

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"

			SetActive(arg_81_1.choicesGo_, true)

			for iter_82_0, iter_82_1 in ipairs(arg_81_1.choices_) do
				local var_82_0 = iter_82_0 <= 2

				SetActive(iter_82_1.go, var_82_0)
			end

			arg_81_1.choices_[1].txt.text = arg_81_1:FormatText(StoryChoiceCfg[1316].name)
			arg_81_1.choices_[2].txt.text = arg_81_1:FormatText(StoryChoiceCfg[1317].name)
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play926021021(arg_81_1)
			end

			if arg_83_0 == 2 then
				arg_81_0:Play926021021(arg_81_1)
			end

			arg_81_1:RecordChoiceLog(926021020, 1316, 1317)
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10144"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10144 == nil then
				arg_81_1.var_.actorSpriteComps10144 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps10144 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10144 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10144 = nil
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play926021021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 926021021
		arg_85_1.duration_ = 9.1

		local var_85_0 = {
			zh = 6.4,
			ja = 9.1
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
				arg_85_0:Play926021022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10144"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10144 == nil then
				arg_85_1.var_.actorSpriteComps10144 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10144 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10144 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10144 = nil
			end

			local var_88_8 = arg_85_1.actors_["10144"].transform
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 then
				arg_85_1.var_.moveOldPos10144 = var_88_8.localPosition
				var_88_8.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10144", 3)

				local var_88_10 = var_88_8.childCount

				for iter_88_4 = 0, var_88_10 - 1 do
					local var_88_11 = var_88_8:GetChild(iter_88_4)

					if var_88_11.name == "split_4" or not string.find(var_88_11.name, "split") then
						var_88_11.gameObject:SetActive(true)
					else
						var_88_11.gameObject:SetActive(false)
					end
				end
			end

			local var_88_12 = 0.001

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_12 then
				local var_88_13 = (arg_85_1.time_ - var_88_9) / var_88_12
				local var_88_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_88_8.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10144, var_88_14, var_88_13)
			end

			if arg_85_1.time_ >= var_88_9 + var_88_12 and arg_85_1.time_ < var_88_9 + var_88_12 + arg_88_0 then
				var_88_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_88_15 = 0
			local var_88_16 = 0.825

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[1297].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(926021021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 33
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021021", "story_v_out_926021.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_926021", "926021021", "story_v_out_926021.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_926021", "926021021", "story_v_out_926021.awb")

						arg_85_1:RecordAudio("926021021", var_88_24)
						arg_85_1:RecordAudio("926021021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_926021", "926021021", "story_v_out_926021.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_926021", "926021021", "story_v_out_926021.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 926021022
		arg_89_1.duration_ = 8.57

		local var_89_0 = {
			zh = 6.833,
			ja = 8.566
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
				arg_89_0:Play926021023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10144"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10144 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10144", 3)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "split_7" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10144, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_92_7 = 0
			local var_92_8 = 0.825

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_9 = arg_89_1:FormatText(StoryNameCfg[1297].name)

				arg_89_1.leftNameTxt_.text = var_92_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(926021022)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_12 = 33
				local var_92_13 = utf8.len(var_92_11)
				local var_92_14 = var_92_12 <= 0 and var_92_8 or var_92_8 * (var_92_13 / var_92_12)

				if var_92_14 > 0 and var_92_8 < var_92_14 then
					arg_89_1.talkMaxDuration = var_92_14

					if var_92_14 + var_92_7 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_7
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021022", "story_v_out_926021.awb") ~= 0 then
					local var_92_15 = manager.audio:GetVoiceLength("story_v_out_926021", "926021022", "story_v_out_926021.awb") / 1000

					if var_92_15 + var_92_7 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_15 + var_92_7
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_926021", "926021022", "story_v_out_926021.awb")

						arg_89_1:RecordAudio("926021022", var_92_16)
						arg_89_1:RecordAudio("926021022", var_92_16)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_926021", "926021022", "story_v_out_926021.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_926021", "926021022", "story_v_out_926021.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_17 = math.max(var_92_8, arg_89_1.talkMaxDuration)

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_17 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_7) / var_92_17

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_7 + var_92_17 and arg_89_1.time_ < var_92_7 + var_92_17 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 926021023
		arg_93_1.duration_ = 11.13

		local var_93_0 = {
			zh = 8,
			ja = 11.133
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
				arg_93_0:Play926021024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.1

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[1297].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(926021023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021023", "story_v_out_926021.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021023", "story_v_out_926021.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_926021", "926021023", "story_v_out_926021.awb")

						arg_93_1:RecordAudio("926021023", var_96_9)
						arg_93_1:RecordAudio("926021023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_926021", "926021023", "story_v_out_926021.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_926021", "926021023", "story_v_out_926021.awb")
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
	Play926021024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 926021024
		arg_97_1.duration_ = 8.13

		local var_97_0 = {
			zh = 6.4,
			ja = 8.133
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
				arg_97_0:Play926021025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["128404"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps128404 == nil then
				arg_97_1.var_.actorSpriteComps128404 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps128404 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps128404 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps128404 = nil
			end

			local var_100_8 = arg_97_1.actors_["10144"]
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10144 == nil then
				arg_97_1.var_.actorSpriteComps10144 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_10 = 0.2

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_10 and not isNil(var_100_8) then
				local var_100_11 = (arg_97_1.time_ - var_100_9) / var_100_10

				if arg_97_1.var_.actorSpriteComps10144 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_97_1.time_ >= var_100_9 + var_100_10 and arg_97_1.time_ < var_100_9 + var_100_10 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10144 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_100_7 then
						if arg_97_1.isInRecall_ then
							iter_100_7.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10144 = nil
			end

			local var_100_16 = arg_97_1.actors_["128404"].transform
			local var_100_17 = 0

			if var_100_17 < arg_97_1.time_ and arg_97_1.time_ <= var_100_17 + arg_100_0 then
				arg_97_1.var_.moveOldPos128404 = var_100_16.localPosition
				var_100_16.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("128404", 3)

				local var_100_18 = var_100_16.childCount

				for iter_100_8 = 0, var_100_18 - 1 do
					local var_100_19 = var_100_16:GetChild(iter_100_8)

					if var_100_19.name == "split_6" or not string.find(var_100_19.name, "split") then
						var_100_19.gameObject:SetActive(true)
					else
						var_100_19.gameObject:SetActive(false)
					end
				end
			end

			local var_100_20 = 0.001

			if var_100_17 <= arg_97_1.time_ and arg_97_1.time_ < var_100_17 + var_100_20 then
				local var_100_21 = (arg_97_1.time_ - var_100_17) / var_100_20
				local var_100_22 = Vector3.New(-16.1, -362, -375)

				var_100_16.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos128404, var_100_22, var_100_21)
			end

			if arg_97_1.time_ >= var_100_17 + var_100_20 and arg_97_1.time_ < var_100_17 + var_100_20 + arg_100_0 then
				var_100_16.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_100_23 = arg_97_1.actors_["10144"].transform
			local var_100_24 = 0

			if var_100_24 < arg_97_1.time_ and arg_97_1.time_ <= var_100_24 + arg_100_0 then
				arg_97_1.var_.moveOldPos10144 = var_100_23.localPosition
				var_100_23.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10144", 7)

				local var_100_25 = var_100_23.childCount

				for iter_100_9 = 0, var_100_25 - 1 do
					local var_100_26 = var_100_23:GetChild(iter_100_9)

					if var_100_26.name == "" or not string.find(var_100_26.name, "split") then
						var_100_26.gameObject:SetActive(true)
					else
						var_100_26.gameObject:SetActive(false)
					end
				end
			end

			local var_100_27 = 0.001

			if var_100_24 <= arg_97_1.time_ and arg_97_1.time_ < var_100_24 + var_100_27 then
				local var_100_28 = (arg_97_1.time_ - var_100_24) / var_100_27
				local var_100_29 = Vector3.New(0, -2000, 0)

				var_100_23.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10144, var_100_29, var_100_28)
			end

			if arg_97_1.time_ >= var_100_24 + var_100_27 and arg_97_1.time_ < var_100_24 + var_100_27 + arg_100_0 then
				var_100_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_30 = 0
			local var_100_31 = 0.75

			if var_100_30 < arg_97_1.time_ and arg_97_1.time_ <= var_100_30 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_32 = arg_97_1:FormatText(StoryNameCfg[6].name)

				arg_97_1.leftNameTxt_.text = var_100_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_33 = arg_97_1:GetWordFromCfg(926021024)
				local var_100_34 = arg_97_1:FormatText(var_100_33.content)

				arg_97_1.text_.text = var_100_34

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_35 = 30
				local var_100_36 = utf8.len(var_100_34)
				local var_100_37 = var_100_35 <= 0 and var_100_31 or var_100_31 * (var_100_36 / var_100_35)

				if var_100_37 > 0 and var_100_31 < var_100_37 then
					arg_97_1.talkMaxDuration = var_100_37

					if var_100_37 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_37 + var_100_30
					end
				end

				arg_97_1.text_.text = var_100_34
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021024", "story_v_out_926021.awb") ~= 0 then
					local var_100_38 = manager.audio:GetVoiceLength("story_v_out_926021", "926021024", "story_v_out_926021.awb") / 1000

					if var_100_38 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_38 + var_100_30
					end

					if var_100_33.prefab_name ~= "" and arg_97_1.actors_[var_100_33.prefab_name] ~= nil then
						local var_100_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_33.prefab_name].transform, "story_v_out_926021", "926021024", "story_v_out_926021.awb")

						arg_97_1:RecordAudio("926021024", var_100_39)
						arg_97_1:RecordAudio("926021024", var_100_39)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_926021", "926021024", "story_v_out_926021.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_926021", "926021024", "story_v_out_926021.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_40 = math.max(var_100_31, arg_97_1.talkMaxDuration)

			if var_100_30 <= arg_97_1.time_ and arg_97_1.time_ < var_100_30 + var_100_40 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_30) / var_100_40

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_30 + var_100_40 and arg_97_1.time_ < var_100_30 + var_100_40 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 926021025
		arg_101_1.duration_ = 7.7

		local var_101_0 = {
			zh = 4.333,
			ja = 7.7
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
				arg_101_0:Play926021026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10144"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10144 == nil then
				arg_101_1.var_.actorSpriteComps10144 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps10144 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10144 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10144 = nil
			end

			local var_104_8 = arg_101_1.actors_["128404"]
			local var_104_9 = 0

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps128404 == nil then
				arg_101_1.var_.actorSpriteComps128404 = var_104_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_10 = 0.2

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_10 and not isNil(var_104_8) then
				local var_104_11 = (arg_101_1.time_ - var_104_9) / var_104_10

				if arg_101_1.var_.actorSpriteComps128404 then
					for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_101_1.time_ >= var_104_9 + var_104_10 and arg_101_1.time_ < var_104_9 + var_104_10 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps128404 then
				for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_104_7 then
						if arg_101_1.isInRecall_ then
							iter_104_7.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps128404 = nil
			end

			local var_104_16 = arg_101_1.actors_["10144"].transform
			local var_104_17 = 0

			if var_104_17 < arg_101_1.time_ and arg_101_1.time_ <= var_104_17 + arg_104_0 then
				arg_101_1.var_.moveOldPos10144 = var_104_16.localPosition
				var_104_16.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10144", 3)

				local var_104_18 = var_104_16.childCount

				for iter_104_8 = 0, var_104_18 - 1 do
					local var_104_19 = var_104_16:GetChild(iter_104_8)

					if var_104_19.name == "" or not string.find(var_104_19.name, "split") then
						var_104_19.gameObject:SetActive(true)
					else
						var_104_19.gameObject:SetActive(false)
					end
				end
			end

			local var_104_20 = 0.001

			if var_104_17 <= arg_101_1.time_ and arg_101_1.time_ < var_104_17 + var_104_20 then
				local var_104_21 = (arg_101_1.time_ - var_104_17) / var_104_20
				local var_104_22 = Vector3.New(-31.5, -381.1, -285.9)

				var_104_16.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10144, var_104_22, var_104_21)
			end

			if arg_101_1.time_ >= var_104_17 + var_104_20 and arg_101_1.time_ < var_104_17 + var_104_20 + arg_104_0 then
				var_104_16.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_104_23 = 0
			local var_104_24 = 0.65

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_25 = arg_101_1:FormatText(StoryNameCfg[1297].name)

				arg_101_1.leftNameTxt_.text = var_104_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_26 = arg_101_1:GetWordFromCfg(926021025)
				local var_104_27 = arg_101_1:FormatText(var_104_26.content)

				arg_101_1.text_.text = var_104_27

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_28 = 26
				local var_104_29 = utf8.len(var_104_27)
				local var_104_30 = var_104_28 <= 0 and var_104_24 or var_104_24 * (var_104_29 / var_104_28)

				if var_104_30 > 0 and var_104_24 < var_104_30 then
					arg_101_1.talkMaxDuration = var_104_30

					if var_104_30 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_30 + var_104_23
					end
				end

				arg_101_1.text_.text = var_104_27
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021025", "story_v_out_926021.awb") ~= 0 then
					local var_104_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021025", "story_v_out_926021.awb") / 1000

					if var_104_31 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_31 + var_104_23
					end

					if var_104_26.prefab_name ~= "" and arg_101_1.actors_[var_104_26.prefab_name] ~= nil then
						local var_104_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_26.prefab_name].transform, "story_v_out_926021", "926021025", "story_v_out_926021.awb")

						arg_101_1:RecordAudio("926021025", var_104_32)
						arg_101_1:RecordAudio("926021025", var_104_32)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_926021", "926021025", "story_v_out_926021.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_926021", "926021025", "story_v_out_926021.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_33 = math.max(var_104_24, arg_101_1.talkMaxDuration)

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_33 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_23) / var_104_33

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_23 + var_104_33 and arg_101_1.time_ < var_104_23 + var_104_33 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 926021026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play926021027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10144"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10144 == nil then
				arg_105_1.var_.actorSpriteComps10144 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps10144 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10144 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10144 = nil
			end

			local var_108_8 = 0
			local var_108_9 = 0.425

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_10 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_11 = arg_105_1:GetWordFromCfg(926021026)
				local var_108_12 = arg_105_1:FormatText(var_108_11.content)

				arg_105_1.text_.text = var_108_12

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 17
				local var_108_14 = utf8.len(var_108_12)
				local var_108_15 = var_108_13 <= 0 and var_108_9 or var_108_9 * (var_108_14 / var_108_13)

				if var_108_15 > 0 and var_108_9 < var_108_15 then
					arg_105_1.talkMaxDuration = var_108_15

					if var_108_15 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_15 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_12
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play926021027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 926021027
		arg_109_1.duration_ = 13.23

		local var_109_0 = {
			zh = 7.166,
			ja = 13.233
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
				arg_109_0:Play926021028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10144"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps10144 == nil then
				arg_109_1.var_.actorSpriteComps10144 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps10144 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps10144 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10144 = nil
			end

			local var_112_8 = 0
			local var_112_9 = 0.925

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_10 = arg_109_1:FormatText(StoryNameCfg[1297].name)

				arg_109_1.leftNameTxt_.text = var_112_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_11 = arg_109_1:GetWordFromCfg(926021027)
				local var_112_12 = arg_109_1:FormatText(var_112_11.content)

				arg_109_1.text_.text = var_112_12

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 37
				local var_112_14 = utf8.len(var_112_12)
				local var_112_15 = var_112_13 <= 0 and var_112_9 or var_112_9 * (var_112_14 / var_112_13)

				if var_112_15 > 0 and var_112_9 < var_112_15 then
					arg_109_1.talkMaxDuration = var_112_15

					if var_112_15 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_15 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_12
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021027", "story_v_out_926021.awb") ~= 0 then
					local var_112_16 = manager.audio:GetVoiceLength("story_v_out_926021", "926021027", "story_v_out_926021.awb") / 1000

					if var_112_16 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_16 + var_112_8
					end

					if var_112_11.prefab_name ~= "" and arg_109_1.actors_[var_112_11.prefab_name] ~= nil then
						local var_112_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_11.prefab_name].transform, "story_v_out_926021", "926021027", "story_v_out_926021.awb")

						arg_109_1:RecordAudio("926021027", var_112_17)
						arg_109_1:RecordAudio("926021027", var_112_17)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_926021", "926021027", "story_v_out_926021.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_926021", "926021027", "story_v_out_926021.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_18 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_18 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_18

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_18 and arg_109_1.time_ < var_112_8 + var_112_18 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play926021028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 926021028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play926021029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10144"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10144 == nil then
				arg_113_1.var_.actorSpriteComps10144 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps10144 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_4 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, var_116_3)
								local var_116_5 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, var_116_3)
								local var_116_6 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, var_116_3)

								iter_116_1.color = Color.New(var_116_4, var_116_5, var_116_6)
							else
								local var_116_7 = Mathf.Lerp(iter_116_1.color.r, 0.5, var_116_3)

								iter_116_1.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10144 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10144 = nil
			end

			local var_116_8 = 0
			local var_116_9 = 0.675

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_10 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_11 = arg_113_1:GetWordFromCfg(926021028)
				local var_116_12 = arg_113_1:FormatText(var_116_11.content)

				arg_113_1.text_.text = var_116_12

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 27
				local var_116_14 = utf8.len(var_116_12)
				local var_116_15 = var_116_13 <= 0 and var_116_9 or var_116_9 * (var_116_14 / var_116_13)

				if var_116_15 > 0 and var_116_9 < var_116_15 then
					arg_113_1.talkMaxDuration = var_116_15

					if var_116_15 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_15 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_12
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play926021029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 926021029
		arg_117_1.duration_ = 5.77

		local var_117_0 = {
			zh = 3.3,
			ja = 5.766
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
				arg_117_0:Play926021030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10144"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10144 == nil then
				arg_117_1.var_.actorSpriteComps10144 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps10144 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_4 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, var_120_3)
								local var_120_5 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, var_120_3)
								local var_120_6 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, var_120_3)

								iter_120_1.color = Color.New(var_120_4, var_120_5, var_120_6)
							else
								local var_120_7 = Mathf.Lerp(iter_120_1.color.r, 1, var_120_3)

								iter_120_1.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10144 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10144 = nil
			end

			local var_120_8 = arg_117_1.actors_["10144"].transform
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1.var_.moveOldPos10144 = var_120_8.localPosition
				var_120_8.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10144", 3)

				local var_120_10 = var_120_8.childCount

				for iter_120_4 = 0, var_120_10 - 1 do
					local var_120_11 = var_120_8:GetChild(iter_120_4)

					if var_120_11.name == "" or not string.find(var_120_11.name, "split") then
						var_120_11.gameObject:SetActive(true)
					else
						var_120_11.gameObject:SetActive(false)
					end
				end
			end

			local var_120_12 = 0.001

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_12 then
				local var_120_13 = (arg_117_1.time_ - var_120_9) / var_120_12
				local var_120_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_120_8.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10144, var_120_14, var_120_13)
			end

			if arg_117_1.time_ >= var_120_9 + var_120_12 and arg_117_1.time_ < var_120_9 + var_120_12 + arg_120_0 then
				var_120_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_120_15 = 0
			local var_120_16 = 0.425

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[1297].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(926021029)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 17
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021029", "story_v_out_926021.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_out_926021", "926021029", "story_v_out_926021.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_out_926021", "926021029", "story_v_out_926021.awb")

						arg_117_1:RecordAudio("926021029", var_120_24)
						arg_117_1:RecordAudio("926021029", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_926021", "926021029", "story_v_out_926021.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_926021", "926021029", "story_v_out_926021.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_25 and arg_117_1.time_ < var_120_15 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 926021030
		arg_121_1.duration_ = 4.83

		local var_121_0 = {
			zh = 4.566,
			ja = 4.833
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
				arg_121_0:Play926021031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.625

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[1297].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(926021030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 25
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021030", "story_v_out_926021.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021030", "story_v_out_926021.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_926021", "926021030", "story_v_out_926021.awb")

						arg_121_1:RecordAudio("926021030", var_124_9)
						arg_121_1:RecordAudio("926021030", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_926021", "926021030", "story_v_out_926021.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_926021", "926021030", "story_v_out_926021.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_10 and arg_121_1.time_ < var_124_0 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play926021031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 926021031
		arg_125_1.duration_ = 7.13

		local var_125_0 = {
			zh = 5.666,
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
				arg_125_0:Play926021032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.8

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[1297].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(926021031)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 32
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021031", "story_v_out_926021.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021031", "story_v_out_926021.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_926021", "926021031", "story_v_out_926021.awb")

						arg_125_1:RecordAudio("926021031", var_128_9)
						arg_125_1:RecordAudio("926021031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_926021", "926021031", "story_v_out_926021.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_926021", "926021031", "story_v_out_926021.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_10 and arg_125_1.time_ < var_128_0 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play926021032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 926021032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play926021033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10144"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10144 == nil then
				arg_129_1.var_.actorSpriteComps10144 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps10144 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								local var_132_4 = Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor2.r, var_132_3)
								local var_132_5 = Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor2.g, var_132_3)
								local var_132_6 = Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor2.b, var_132_3)

								iter_132_1.color = Color.New(var_132_4, var_132_5, var_132_6)
							else
								local var_132_7 = Mathf.Lerp(iter_132_1.color.r, 0.5, var_132_3)

								iter_132_1.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10144 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_132_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10144 = nil
			end

			local var_132_8 = 0
			local var_132_9 = 0.25

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_10 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_11 = arg_129_1:GetWordFromCfg(926021032)
				local var_132_12 = arg_129_1:FormatText(var_132_11.content)

				arg_129_1.text_.text = var_132_12

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 10
				local var_132_14 = utf8.len(var_132_12)
				local var_132_15 = var_132_13 <= 0 and var_132_9 or var_132_9 * (var_132_14 / var_132_13)

				if var_132_15 > 0 and var_132_9 < var_132_15 then
					arg_129_1.talkMaxDuration = var_132_15

					if var_132_15 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_15 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_12
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_16 and arg_129_1.time_ < var_132_8 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play926021033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 926021033
		arg_133_1.duration_ = 4

		local var_133_0 = {
			zh = 1.833,
			ja = 4
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
				arg_133_0:Play926021034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10144"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10144 == nil then
				arg_133_1.var_.actorSpriteComps10144 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps10144 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10144 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10144 = nil
			end

			local var_136_8 = arg_133_1.actors_["10144"].transform
			local var_136_9 = 0

			if var_136_9 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 then
				arg_133_1.var_.moveOldPos10144 = var_136_8.localPosition
				var_136_8.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10144", 3)

				local var_136_10 = var_136_8.childCount

				for iter_136_4 = 0, var_136_10 - 1 do
					local var_136_11 = var_136_8:GetChild(iter_136_4)

					if var_136_11.name == "split_2" or not string.find(var_136_11.name, "split") then
						var_136_11.gameObject:SetActive(true)
					else
						var_136_11.gameObject:SetActive(false)
					end
				end
			end

			local var_136_12 = 0.001

			if var_136_9 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_12 then
				local var_136_13 = (arg_133_1.time_ - var_136_9) / var_136_12
				local var_136_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_136_8.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10144, var_136_14, var_136_13)
			end

			if arg_133_1.time_ >= var_136_9 + var_136_12 and arg_133_1.time_ < var_136_9 + var_136_12 + arg_136_0 then
				var_136_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_136_15 = 0
			local var_136_16 = 0.25

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_17 = arg_133_1:FormatText(StoryNameCfg[1297].name)

				arg_133_1.leftNameTxt_.text = var_136_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_18 = arg_133_1:GetWordFromCfg(926021033)
				local var_136_19 = arg_133_1:FormatText(var_136_18.content)

				arg_133_1.text_.text = var_136_19

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021033", "story_v_out_926021.awb") ~= 0 then
					local var_136_23 = manager.audio:GetVoiceLength("story_v_out_926021", "926021033", "story_v_out_926021.awb") / 1000

					if var_136_23 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_15
					end

					if var_136_18.prefab_name ~= "" and arg_133_1.actors_[var_136_18.prefab_name] ~= nil then
						local var_136_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_18.prefab_name].transform, "story_v_out_926021", "926021033", "story_v_out_926021.awb")

						arg_133_1:RecordAudio("926021033", var_136_24)
						arg_133_1:RecordAudio("926021033", var_136_24)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_926021", "926021033", "story_v_out_926021.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_926021", "926021033", "story_v_out_926021.awb")
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
				actorName = "10144",
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
	Play926021034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 926021034
		arg_137_1.duration_ = 4.17

		local var_137_0 = {
			zh = 3.233,
			ja = 4.166
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
				arg_137_0:Play926021035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["104701"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps104701 == nil then
				arg_137_1.var_.actorSpriteComps104701 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps104701 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps104701 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps104701 = nil
			end

			local var_140_8 = arg_137_1.actors_["10144"]
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps10144 == nil then
				arg_137_1.var_.actorSpriteComps10144 = var_140_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_10 = 0.2

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_10 and not isNil(var_140_8) then
				local var_140_11 = (arg_137_1.time_ - var_140_9) / var_140_10

				if arg_137_1.var_.actorSpriteComps10144 then
					for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_137_1.time_ >= var_140_9 + var_140_10 and arg_137_1.time_ < var_140_9 + var_140_10 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps10144 then
				for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_140_7 then
						if arg_137_1.isInRecall_ then
							iter_140_7.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10144 = nil
			end

			local var_140_16 = arg_137_1.actors_["104701"].transform
			local var_140_17 = 0

			if var_140_17 < arg_137_1.time_ and arg_137_1.time_ <= var_140_17 + arg_140_0 then
				arg_137_1.var_.moveOldPos104701 = var_140_16.localPosition
				var_140_16.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("104701", 3)

				local var_140_18 = var_140_16.childCount

				for iter_140_8 = 0, var_140_18 - 1 do
					local var_140_19 = var_140_16:GetChild(iter_140_8)

					if var_140_19.name == "" or not string.find(var_140_19.name, "split") then
						var_140_19.gameObject:SetActive(true)
					else
						var_140_19.gameObject:SetActive(false)
					end
				end
			end

			local var_140_20 = 0.001

			if var_140_17 <= arg_137_1.time_ and arg_137_1.time_ < var_140_17 + var_140_20 then
				local var_140_21 = (arg_137_1.time_ - var_140_17) / var_140_20
				local var_140_22 = Vector3.New(-67.4, -386.8, -295)

				var_140_16.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos104701, var_140_22, var_140_21)
			end

			if arg_137_1.time_ >= var_140_17 + var_140_20 and arg_137_1.time_ < var_140_17 + var_140_20 + arg_140_0 then
				var_140_16.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_140_23 = arg_137_1.actors_["10144"].transform
			local var_140_24 = 0

			if var_140_24 < arg_137_1.time_ and arg_137_1.time_ <= var_140_24 + arg_140_0 then
				arg_137_1.var_.moveOldPos10144 = var_140_23.localPosition
				var_140_23.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10144", 7)

				local var_140_25 = var_140_23.childCount

				for iter_140_9 = 0, var_140_25 - 1 do
					local var_140_26 = var_140_23:GetChild(iter_140_9)

					if var_140_26.name == "" or not string.find(var_140_26.name, "split") then
						var_140_26.gameObject:SetActive(true)
					else
						var_140_26.gameObject:SetActive(false)
					end
				end
			end

			local var_140_27 = 0.001

			if var_140_24 <= arg_137_1.time_ and arg_137_1.time_ < var_140_24 + var_140_27 then
				local var_140_28 = (arg_137_1.time_ - var_140_24) / var_140_27
				local var_140_29 = Vector3.New(0, -2000, 0)

				var_140_23.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10144, var_140_29, var_140_28)
			end

			if arg_137_1.time_ >= var_140_24 + var_140_27 and arg_137_1.time_ < var_140_24 + var_140_27 + arg_140_0 then
				var_140_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_140_30 = 0
			local var_140_31 = 0.325

			if var_140_30 < arg_137_1.time_ and arg_137_1.time_ <= var_140_30 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_32 = arg_137_1:FormatText(StoryNameCfg[1296].name)

				arg_137_1.leftNameTxt_.text = var_140_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_33 = arg_137_1:GetWordFromCfg(926021034)
				local var_140_34 = arg_137_1:FormatText(var_140_33.content)

				arg_137_1.text_.text = var_140_34

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_35 = 13
				local var_140_36 = utf8.len(var_140_34)
				local var_140_37 = var_140_35 <= 0 and var_140_31 or var_140_31 * (var_140_36 / var_140_35)

				if var_140_37 > 0 and var_140_31 < var_140_37 then
					arg_137_1.talkMaxDuration = var_140_37

					if var_140_37 + var_140_30 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_37 + var_140_30
					end
				end

				arg_137_1.text_.text = var_140_34
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021034", "story_v_out_926021.awb") ~= 0 then
					local var_140_38 = manager.audio:GetVoiceLength("story_v_out_926021", "926021034", "story_v_out_926021.awb") / 1000

					if var_140_38 + var_140_30 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_38 + var_140_30
					end

					if var_140_33.prefab_name ~= "" and arg_137_1.actors_[var_140_33.prefab_name] ~= nil then
						local var_140_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_33.prefab_name].transform, "story_v_out_926021", "926021034", "story_v_out_926021.awb")

						arg_137_1:RecordAudio("926021034", var_140_39)
						arg_137_1:RecordAudio("926021034", var_140_39)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_926021", "926021034", "story_v_out_926021.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_926021", "926021034", "story_v_out_926021.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_40 = math.max(var_140_31, arg_137_1.talkMaxDuration)

			if var_140_30 <= arg_137_1.time_ and arg_137_1.time_ < var_140_30 + var_140_40 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_30) / var_140_40

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_30 + var_140_40 and arg_137_1.time_ < var_140_30 + var_140_40 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 926021035
		arg_141_1.duration_ = 12.1

		local var_141_0 = {
			zh = 11.1,
			ja = 12.1
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
				arg_141_0:Play926021036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10144"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10144 == nil then
				arg_141_1.var_.actorSpriteComps10144 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps10144 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor1.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor1.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor1.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 1, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10144 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10144 = nil
			end

			local var_144_8 = arg_141_1.actors_["104701"]
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps104701 == nil then
				arg_141_1.var_.actorSpriteComps104701 = var_144_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_10 = 0.2

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_10 and not isNil(var_144_8) then
				local var_144_11 = (arg_141_1.time_ - var_144_9) / var_144_10

				if arg_141_1.var_.actorSpriteComps104701 then
					for iter_144_4, iter_144_5 in pairs(arg_141_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_144_5 then
							if arg_141_1.isInRecall_ then
								local var_144_12 = Mathf.Lerp(iter_144_5.color.r, arg_141_1.hightColor2.r, var_144_11)
								local var_144_13 = Mathf.Lerp(iter_144_5.color.g, arg_141_1.hightColor2.g, var_144_11)
								local var_144_14 = Mathf.Lerp(iter_144_5.color.b, arg_141_1.hightColor2.b, var_144_11)

								iter_144_5.color = Color.New(var_144_12, var_144_13, var_144_14)
							else
								local var_144_15 = Mathf.Lerp(iter_144_5.color.r, 0.5, var_144_11)

								iter_144_5.color = Color.New(var_144_15, var_144_15, var_144_15)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_9 + var_144_10 and arg_141_1.time_ < var_144_9 + var_144_10 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps104701 then
				for iter_144_6, iter_144_7 in pairs(arg_141_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_144_7 then
						if arg_141_1.isInRecall_ then
							iter_144_7.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps104701 = nil
			end

			local var_144_16 = arg_141_1.actors_["104701"].transform
			local var_144_17 = 0

			if var_144_17 < arg_141_1.time_ and arg_141_1.time_ <= var_144_17 + arg_144_0 then
				arg_141_1.var_.moveOldPos104701 = var_144_16.localPosition
				var_144_16.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("104701", 4)

				local var_144_18 = var_144_16.childCount

				for iter_144_8 = 0, var_144_18 - 1 do
					local var_144_19 = var_144_16:GetChild(iter_144_8)

					if var_144_19.name == "" or not string.find(var_144_19.name, "split") then
						var_144_19.gameObject:SetActive(true)
					else
						var_144_19.gameObject:SetActive(false)
					end
				end
			end

			local var_144_20 = 0.001

			if var_144_17 <= arg_141_1.time_ and arg_141_1.time_ < var_144_17 + var_144_20 then
				local var_144_21 = (arg_141_1.time_ - var_144_17) / var_144_20
				local var_144_22 = Vector3.New(372.4, -386.8, -295)

				var_144_16.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos104701, var_144_22, var_144_21)
			end

			if arg_141_1.time_ >= var_144_17 + var_144_20 and arg_141_1.time_ < var_144_17 + var_144_20 + arg_144_0 then
				var_144_16.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_144_23 = arg_141_1.actors_["10144"].transform
			local var_144_24 = 0

			if var_144_24 < arg_141_1.time_ and arg_141_1.time_ <= var_144_24 + arg_144_0 then
				arg_141_1.var_.moveOldPos10144 = var_144_23.localPosition
				var_144_23.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10144", 2)

				local var_144_25 = var_144_23.childCount

				for iter_144_9 = 0, var_144_25 - 1 do
					local var_144_26 = var_144_23:GetChild(iter_144_9)

					if var_144_26.name == "" or not string.find(var_144_26.name, "split") then
						var_144_26.gameObject:SetActive(true)
					else
						var_144_26.gameObject:SetActive(false)
					end
				end
			end

			local var_144_27 = 0.001

			if var_144_24 <= arg_141_1.time_ and arg_141_1.time_ < var_144_24 + var_144_27 then
				local var_144_28 = (arg_141_1.time_ - var_144_24) / var_144_27
				local var_144_29 = Vector3.New(-507.9, -381.1, -285.9)

				var_144_23.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10144, var_144_29, var_144_28)
			end

			if arg_141_1.time_ >= var_144_24 + var_144_27 and arg_141_1.time_ < var_144_24 + var_144_27 + arg_144_0 then
				var_144_23.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_144_30 = 0
			local var_144_31 = 1.375

			if var_144_30 < arg_141_1.time_ and arg_141_1.time_ <= var_144_30 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_32 = arg_141_1:FormatText(StoryNameCfg[1297].name)

				arg_141_1.leftNameTxt_.text = var_144_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_33 = arg_141_1:GetWordFromCfg(926021035)
				local var_144_34 = arg_141_1:FormatText(var_144_33.content)

				arg_141_1.text_.text = var_144_34

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_35 = 57
				local var_144_36 = utf8.len(var_144_34)
				local var_144_37 = var_144_35 <= 0 and var_144_31 or var_144_31 * (var_144_36 / var_144_35)

				if var_144_37 > 0 and var_144_31 < var_144_37 then
					arg_141_1.talkMaxDuration = var_144_37

					if var_144_37 + var_144_30 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_37 + var_144_30
					end
				end

				arg_141_1.text_.text = var_144_34
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021035", "story_v_out_926021.awb") ~= 0 then
					local var_144_38 = manager.audio:GetVoiceLength("story_v_out_926021", "926021035", "story_v_out_926021.awb") / 1000

					if var_144_38 + var_144_30 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_38 + var_144_30
					end

					if var_144_33.prefab_name ~= "" and arg_141_1.actors_[var_144_33.prefab_name] ~= nil then
						local var_144_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_33.prefab_name].transform, "story_v_out_926021", "926021035", "story_v_out_926021.awb")

						arg_141_1:RecordAudio("926021035", var_144_39)
						arg_141_1:RecordAudio("926021035", var_144_39)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_926021", "926021035", "story_v_out_926021.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_926021", "926021035", "story_v_out_926021.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_40 = math.max(var_144_31, arg_141_1.talkMaxDuration)

			if var_144_30 <= arg_141_1.time_ and arg_141_1.time_ < var_144_30 + var_144_40 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_30) / var_144_40

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_30 + var_144_40 and arg_141_1.time_ < var_144_30 + var_144_40 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 926021036
		arg_145_1.duration_ = 2.97

		local var_145_0 = {
			zh = 2.966,
			ja = 1.666
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
				arg_145_0:Play926021037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["104701"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps104701 == nil then
				arg_145_1.var_.actorSpriteComps104701 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps104701 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps104701 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps104701 = nil
			end

			local var_148_8 = arg_145_1.actors_["10144"]
			local var_148_9 = 0

			if var_148_9 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 and not isNil(var_148_8) and arg_145_1.var_.actorSpriteComps10144 == nil then
				arg_145_1.var_.actorSpriteComps10144 = var_148_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_10 = 0.2

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_10 and not isNil(var_148_8) then
				local var_148_11 = (arg_145_1.time_ - var_148_9) / var_148_10

				if arg_145_1.var_.actorSpriteComps10144 then
					for iter_148_4, iter_148_5 in pairs(arg_145_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_148_5 then
							if arg_145_1.isInRecall_ then
								local var_148_12 = Mathf.Lerp(iter_148_5.color.r, arg_145_1.hightColor2.r, var_148_11)
								local var_148_13 = Mathf.Lerp(iter_148_5.color.g, arg_145_1.hightColor2.g, var_148_11)
								local var_148_14 = Mathf.Lerp(iter_148_5.color.b, arg_145_1.hightColor2.b, var_148_11)

								iter_148_5.color = Color.New(var_148_12, var_148_13, var_148_14)
							else
								local var_148_15 = Mathf.Lerp(iter_148_5.color.r, 0.5, var_148_11)

								iter_148_5.color = Color.New(var_148_15, var_148_15, var_148_15)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_9 + var_148_10 and arg_145_1.time_ < var_148_9 + var_148_10 + arg_148_0 and not isNil(var_148_8) and arg_145_1.var_.actorSpriteComps10144 then
				for iter_148_6, iter_148_7 in pairs(arg_145_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_148_7 then
						if arg_145_1.isInRecall_ then
							iter_148_7.color = arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_148_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10144 = nil
			end

			local var_148_16 = arg_145_1.actors_["104701"].transform
			local var_148_17 = 0

			if var_148_17 < arg_145_1.time_ and arg_145_1.time_ <= var_148_17 + arg_148_0 then
				arg_145_1.var_.moveOldPos104701 = var_148_16.localPosition
				var_148_16.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("104701", 4)

				local var_148_18 = var_148_16.childCount

				for iter_148_8 = 0, var_148_18 - 1 do
					local var_148_19 = var_148_16:GetChild(iter_148_8)

					if var_148_19.name == "split_5" or not string.find(var_148_19.name, "split") then
						var_148_19.gameObject:SetActive(true)
					else
						var_148_19.gameObject:SetActive(false)
					end
				end
			end

			local var_148_20 = 0.001

			if var_148_17 <= arg_145_1.time_ and arg_145_1.time_ < var_148_17 + var_148_20 then
				local var_148_21 = (arg_145_1.time_ - var_148_17) / var_148_20
				local var_148_22 = Vector3.New(372.4, -386.8, -295)

				var_148_16.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos104701, var_148_22, var_148_21)
			end

			if arg_145_1.time_ >= var_148_17 + var_148_20 and arg_145_1.time_ < var_148_17 + var_148_20 + arg_148_0 then
				var_148_16.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_148_23 = 0
			local var_148_24 = 0.275

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_25 = arg_145_1:FormatText(StoryNameCfg[1296].name)

				arg_145_1.leftNameTxt_.text = var_148_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_26 = arg_145_1:GetWordFromCfg(926021036)
				local var_148_27 = arg_145_1:FormatText(var_148_26.content)

				arg_145_1.text_.text = var_148_27

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_28 = 11
				local var_148_29 = utf8.len(var_148_27)
				local var_148_30 = var_148_28 <= 0 and var_148_24 or var_148_24 * (var_148_29 / var_148_28)

				if var_148_30 > 0 and var_148_24 < var_148_30 then
					arg_145_1.talkMaxDuration = var_148_30

					if var_148_30 + var_148_23 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_30 + var_148_23
					end
				end

				arg_145_1.text_.text = var_148_27
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021036", "story_v_out_926021.awb") ~= 0 then
					local var_148_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021036", "story_v_out_926021.awb") / 1000

					if var_148_31 + var_148_23 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_31 + var_148_23
					end

					if var_148_26.prefab_name ~= "" and arg_145_1.actors_[var_148_26.prefab_name] ~= nil then
						local var_148_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_26.prefab_name].transform, "story_v_out_926021", "926021036", "story_v_out_926021.awb")

						arg_145_1:RecordAudio("926021036", var_148_32)
						arg_145_1:RecordAudio("926021036", var_148_32)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_926021", "926021036", "story_v_out_926021.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_926021", "926021036", "story_v_out_926021.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_33 = math.max(var_148_24, arg_145_1.talkMaxDuration)

			if var_148_23 <= arg_145_1.time_ and arg_145_1.time_ < var_148_23 + var_148_33 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_23) / var_148_33

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_23 + var_148_33 and arg_145_1.time_ < var_148_23 + var_148_33 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
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
	Play926021037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 926021037
		arg_149_1.duration_ = 11.93

		local var_149_0 = {
			zh = 6.6,
			ja = 11.933
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
				arg_149_0:Play926021038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10144"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10144 == nil then
				arg_149_1.var_.actorSpriteComps10144 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps10144 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor1.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor1.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor1.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 1, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10144 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10144 = nil
			end

			local var_152_8 = arg_149_1.actors_["104701"]
			local var_152_9 = 0

			if var_152_9 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps104701 == nil then
				arg_149_1.var_.actorSpriteComps104701 = var_152_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_10 = 0.2

			if var_152_9 <= arg_149_1.time_ and arg_149_1.time_ < var_152_9 + var_152_10 and not isNil(var_152_8) then
				local var_152_11 = (arg_149_1.time_ - var_152_9) / var_152_10

				if arg_149_1.var_.actorSpriteComps104701 then
					for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_152_5 then
							if arg_149_1.isInRecall_ then
								local var_152_12 = Mathf.Lerp(iter_152_5.color.r, arg_149_1.hightColor2.r, var_152_11)
								local var_152_13 = Mathf.Lerp(iter_152_5.color.g, arg_149_1.hightColor2.g, var_152_11)
								local var_152_14 = Mathf.Lerp(iter_152_5.color.b, arg_149_1.hightColor2.b, var_152_11)

								iter_152_5.color = Color.New(var_152_12, var_152_13, var_152_14)
							else
								local var_152_15 = Mathf.Lerp(iter_152_5.color.r, 0.5, var_152_11)

								iter_152_5.color = Color.New(var_152_15, var_152_15, var_152_15)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_9 + var_152_10 and arg_149_1.time_ < var_152_9 + var_152_10 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps104701 then
				for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_152_7 then
						if arg_149_1.isInRecall_ then
							iter_152_7.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps104701 = nil
			end

			local var_152_16 = 0
			local var_152_17 = 0.775

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_18 = arg_149_1:FormatText(StoryNameCfg[1297].name)

				arg_149_1.leftNameTxt_.text = var_152_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_19 = arg_149_1:GetWordFromCfg(926021037)
				local var_152_20 = arg_149_1:FormatText(var_152_19.content)

				arg_149_1.text_.text = var_152_20

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_21 = 31
				local var_152_22 = utf8.len(var_152_20)
				local var_152_23 = var_152_21 <= 0 and var_152_17 or var_152_17 * (var_152_22 / var_152_21)

				if var_152_23 > 0 and var_152_17 < var_152_23 then
					arg_149_1.talkMaxDuration = var_152_23

					if var_152_23 + var_152_16 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_23 + var_152_16
					end
				end

				arg_149_1.text_.text = var_152_20
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021037", "story_v_out_926021.awb") ~= 0 then
					local var_152_24 = manager.audio:GetVoiceLength("story_v_out_926021", "926021037", "story_v_out_926021.awb") / 1000

					if var_152_24 + var_152_16 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_24 + var_152_16
					end

					if var_152_19.prefab_name ~= "" and arg_149_1.actors_[var_152_19.prefab_name] ~= nil then
						local var_152_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_19.prefab_name].transform, "story_v_out_926021", "926021037", "story_v_out_926021.awb")

						arg_149_1:RecordAudio("926021037", var_152_25)
						arg_149_1:RecordAudio("926021037", var_152_25)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_926021", "926021037", "story_v_out_926021.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_926021", "926021037", "story_v_out_926021.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_26 = math.max(var_152_17, arg_149_1.talkMaxDuration)

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_26 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_16) / var_152_26

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_16 + var_152_26 and arg_149_1.time_ < var_152_16 + var_152_26 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play926021038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 926021038
		arg_153_1.duration_ = 6.37

		local var_153_0 = {
			zh = 5.966,
			ja = 6.366
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
				arg_153_0:Play926021039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["104701"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps104701 == nil then
				arg_153_1.var_.actorSpriteComps104701 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps104701 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps104701 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps104701 = nil
			end

			local var_156_8 = arg_153_1.actors_["10144"]
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps10144 == nil then
				arg_153_1.var_.actorSpriteComps10144 = var_156_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_10 = 0.2

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_10 and not isNil(var_156_8) then
				local var_156_11 = (arg_153_1.time_ - var_156_9) / var_156_10

				if arg_153_1.var_.actorSpriteComps10144 then
					for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_156_5 then
							if arg_153_1.isInRecall_ then
								local var_156_12 = Mathf.Lerp(iter_156_5.color.r, arg_153_1.hightColor2.r, var_156_11)
								local var_156_13 = Mathf.Lerp(iter_156_5.color.g, arg_153_1.hightColor2.g, var_156_11)
								local var_156_14 = Mathf.Lerp(iter_156_5.color.b, arg_153_1.hightColor2.b, var_156_11)

								iter_156_5.color = Color.New(var_156_12, var_156_13, var_156_14)
							else
								local var_156_15 = Mathf.Lerp(iter_156_5.color.r, 0.5, var_156_11)

								iter_156_5.color = Color.New(var_156_15, var_156_15, var_156_15)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_9 + var_156_10 and arg_153_1.time_ < var_156_9 + var_156_10 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps10144 then
				for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_156_7 then
						if arg_153_1.isInRecall_ then
							iter_156_7.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10144 = nil
			end

			local var_156_16 = arg_153_1.actors_["104701"].transform
			local var_156_17 = 0

			if var_156_17 < arg_153_1.time_ and arg_153_1.time_ <= var_156_17 + arg_156_0 then
				arg_153_1.var_.moveOldPos104701 = var_156_16.localPosition
				var_156_16.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("104701", 4)

				local var_156_18 = var_156_16.childCount

				for iter_156_8 = 0, var_156_18 - 1 do
					local var_156_19 = var_156_16:GetChild(iter_156_8)

					if var_156_19.name == "split_1" or not string.find(var_156_19.name, "split") then
						var_156_19.gameObject:SetActive(true)
					else
						var_156_19.gameObject:SetActive(false)
					end
				end
			end

			local var_156_20 = 0.001

			if var_156_17 <= arg_153_1.time_ and arg_153_1.time_ < var_156_17 + var_156_20 then
				local var_156_21 = (arg_153_1.time_ - var_156_17) / var_156_20
				local var_156_22 = Vector3.New(372.4, -386.8, -295)

				var_156_16.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos104701, var_156_22, var_156_21)
			end

			if arg_153_1.time_ >= var_156_17 + var_156_20 and arg_153_1.time_ < var_156_17 + var_156_20 + arg_156_0 then
				var_156_16.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_156_23 = 0
			local var_156_24 = 0.775

			if var_156_23 < arg_153_1.time_ and arg_153_1.time_ <= var_156_23 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_25 = arg_153_1:FormatText(StoryNameCfg[1296].name)

				arg_153_1.leftNameTxt_.text = var_156_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_26 = arg_153_1:GetWordFromCfg(926021038)
				local var_156_27 = arg_153_1:FormatText(var_156_26.content)

				arg_153_1.text_.text = var_156_27

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_28 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021038", "story_v_out_926021.awb") ~= 0 then
					local var_156_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021038", "story_v_out_926021.awb") / 1000

					if var_156_31 + var_156_23 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_31 + var_156_23
					end

					if var_156_26.prefab_name ~= "" and arg_153_1.actors_[var_156_26.prefab_name] ~= nil then
						local var_156_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_26.prefab_name].transform, "story_v_out_926021", "926021038", "story_v_out_926021.awb")

						arg_153_1:RecordAudio("926021038", var_156_32)
						arg_153_1:RecordAudio("926021038", var_156_32)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_926021", "926021038", "story_v_out_926021.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_926021", "926021038", "story_v_out_926021.awb")
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
				actorName = "104701",
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
	Play926021039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 926021039
		arg_157_1.duration_ = 2.8

		local var_157_0 = {
			zh = 1.7,
			ja = 2.8
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
				arg_157_0:Play926021040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10144"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10144 == nil then
				arg_157_1.var_.actorSpriteComps10144 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps10144 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10144 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10144 = nil
			end

			local var_160_8 = arg_157_1.actors_["104701"]
			local var_160_9 = 0

			if var_160_9 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps104701 == nil then
				arg_157_1.var_.actorSpriteComps104701 = var_160_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_10 = 0.2

			if var_160_9 <= arg_157_1.time_ and arg_157_1.time_ < var_160_9 + var_160_10 and not isNil(var_160_8) then
				local var_160_11 = (arg_157_1.time_ - var_160_9) / var_160_10

				if arg_157_1.var_.actorSpriteComps104701 then
					for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_157_1.time_ >= var_160_9 + var_160_10 and arg_157_1.time_ < var_160_9 + var_160_10 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps104701 then
				for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_160_7 then
						if arg_157_1.isInRecall_ then
							iter_160_7.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps104701 = nil
			end

			local var_160_16 = arg_157_1.actors_["10144"].transform
			local var_160_17 = 0

			if var_160_17 < arg_157_1.time_ and arg_157_1.time_ <= var_160_17 + arg_160_0 then
				arg_157_1.var_.moveOldPos10144 = var_160_16.localPosition
				var_160_16.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10144", 2)

				local var_160_18 = var_160_16.childCount

				for iter_160_8 = 0, var_160_18 - 1 do
					local var_160_19 = var_160_16:GetChild(iter_160_8)

					if var_160_19.name == "" or not string.find(var_160_19.name, "split") then
						var_160_19.gameObject:SetActive(true)
					else
						var_160_19.gameObject:SetActive(false)
					end
				end
			end

			local var_160_20 = 0.001

			if var_160_17 <= arg_157_1.time_ and arg_157_1.time_ < var_160_17 + var_160_20 then
				local var_160_21 = (arg_157_1.time_ - var_160_17) / var_160_20
				local var_160_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_160_16.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10144, var_160_22, var_160_21)
			end

			if arg_157_1.time_ >= var_160_17 + var_160_20 and arg_157_1.time_ < var_160_17 + var_160_20 + arg_160_0 then
				var_160_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_160_23 = 0
			local var_160_24 = 0.2

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_25 = arg_157_1:FormatText(StoryNameCfg[1297].name)

				arg_157_1.leftNameTxt_.text = var_160_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_26 = arg_157_1:GetWordFromCfg(926021039)
				local var_160_27 = arg_157_1:FormatText(var_160_26.content)

				arg_157_1.text_.text = var_160_27

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_28 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021039", "story_v_out_926021.awb") ~= 0 then
					local var_160_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021039", "story_v_out_926021.awb") / 1000

					if var_160_31 + var_160_23 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_31 + var_160_23
					end

					if var_160_26.prefab_name ~= "" and arg_157_1.actors_[var_160_26.prefab_name] ~= nil then
						local var_160_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_26.prefab_name].transform, "story_v_out_926021", "926021039", "story_v_out_926021.awb")

						arg_157_1:RecordAudio("926021039", var_160_32)
						arg_157_1:RecordAudio("926021039", var_160_32)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_926021", "926021039", "story_v_out_926021.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_926021", "926021039", "story_v_out_926021.awb")
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
				actorName = "10144",
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
	Play926021040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 926021040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play926021041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10144"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10144 == nil then
				arg_161_1.var_.actorSpriteComps10144 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps10144 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10144 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10144 = nil
			end

			local var_164_8 = arg_161_1.actors_["104701"].transform
			local var_164_9 = 0

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 then
				arg_161_1.var_.moveOldPos104701 = var_164_8.localPosition
				var_164_8.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("104701", 7)

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

				var_164_8.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos104701, var_164_14, var_164_13)
			end

			if arg_161_1.time_ >= var_164_9 + var_164_12 and arg_161_1.time_ < var_164_9 + var_164_12 + arg_164_0 then
				var_164_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_164_15 = arg_161_1.actors_["10144"].transform
			local var_164_16 = 0

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1.var_.moveOldPos10144 = var_164_15.localPosition
				var_164_15.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10144", 7)

				local var_164_17 = var_164_15.childCount

				for iter_164_5 = 0, var_164_17 - 1 do
					local var_164_18 = var_164_15:GetChild(iter_164_5)

					if var_164_18.name == "" or not string.find(var_164_18.name, "split") then
						var_164_18.gameObject:SetActive(true)
					else
						var_164_18.gameObject:SetActive(false)
					end
				end
			end

			local var_164_19 = 0.001

			if var_164_16 <= arg_161_1.time_ and arg_161_1.time_ < var_164_16 + var_164_19 then
				local var_164_20 = (arg_161_1.time_ - var_164_16) / var_164_19
				local var_164_21 = Vector3.New(0, -2000, 0)

				var_164_15.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10144, var_164_21, var_164_20)
			end

			if arg_161_1.time_ >= var_164_16 + var_164_19 and arg_161_1.time_ < var_164_16 + var_164_19 + arg_164_0 then
				var_164_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_164_22 = 0.166666666666667
			local var_164_23 = 1

			if var_164_22 < arg_161_1.time_ and arg_161_1.time_ <= var_164_22 + arg_164_0 then
				local var_164_24 = "play"
				local var_164_25 = "effect"

				arg_161_1:AudioAction(var_164_24, var_164_25, "se_story_140", "se_story_140_data01", "")
			end

			local var_164_26 = 0
			local var_164_27 = 1.175

			if var_164_26 < arg_161_1.time_ and arg_161_1.time_ <= var_164_26 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_28 = arg_161_1:GetWordFromCfg(926021040)
				local var_164_29 = arg_161_1:FormatText(var_164_28.content)

				arg_161_1.text_.text = var_164_29

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_30 = 47
				local var_164_31 = utf8.len(var_164_29)
				local var_164_32 = var_164_30 <= 0 and var_164_27 or var_164_27 * (var_164_31 / var_164_30)

				if var_164_32 > 0 and var_164_27 < var_164_32 then
					arg_161_1.talkMaxDuration = var_164_32

					if var_164_32 + var_164_26 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_32 + var_164_26
					end
				end

				arg_161_1.text_.text = var_164_29
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_33 = math.max(var_164_27, arg_161_1.talkMaxDuration)

			if var_164_26 <= arg_161_1.time_ and arg_161_1.time_ < var_164_26 + var_164_33 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_26) / var_164_33

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_26 + var_164_33 and arg_161_1.time_ < var_164_26 + var_164_33 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 926021041
		arg_165_1.duration_ = 13.8

		local var_165_0 = {
			zh = 7.433,
			ja = 13.8
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
				arg_165_0:Play926021042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10144"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10144 == nil then
				arg_165_1.var_.actorSpriteComps10144 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps10144 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								local var_168_4 = Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, var_168_3)
								local var_168_5 = Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, var_168_3)
								local var_168_6 = Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, var_168_3)

								iter_168_1.color = Color.New(var_168_4, var_168_5, var_168_6)
							else
								local var_168_7 = Mathf.Lerp(iter_168_1.color.r, 1, var_168_3)

								iter_168_1.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10144 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10144 = nil
			end

			local var_168_8 = arg_165_1.actors_["10144"].transform
			local var_168_9 = 0

			if var_168_9 < arg_165_1.time_ and arg_165_1.time_ <= var_168_9 + arg_168_0 then
				arg_165_1.var_.moveOldPos10144 = var_168_8.localPosition
				var_168_8.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10144", 3)

				local var_168_10 = var_168_8.childCount

				for iter_168_4 = 0, var_168_10 - 1 do
					local var_168_11 = var_168_8:GetChild(iter_168_4)

					if var_168_11.name == "split_8" or not string.find(var_168_11.name, "split") then
						var_168_11.gameObject:SetActive(true)
					else
						var_168_11.gameObject:SetActive(false)
					end
				end
			end

			local var_168_12 = 0.001

			if var_168_9 <= arg_165_1.time_ and arg_165_1.time_ < var_168_9 + var_168_12 then
				local var_168_13 = (arg_165_1.time_ - var_168_9) / var_168_12
				local var_168_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_168_8.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10144, var_168_14, var_168_13)
			end

			if arg_165_1.time_ >= var_168_9 + var_168_12 and arg_165_1.time_ < var_168_9 + var_168_12 + arg_168_0 then
				var_168_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_168_15 = 0
			local var_168_16 = 1

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[1297].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(926021041)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 40
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021041", "story_v_out_926021.awb") ~= 0 then
					local var_168_23 = manager.audio:GetVoiceLength("story_v_out_926021", "926021041", "story_v_out_926021.awb") / 1000

					if var_168_23 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_15
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_out_926021", "926021041", "story_v_out_926021.awb")

						arg_165_1:RecordAudio("926021041", var_168_24)
						arg_165_1:RecordAudio("926021041", var_168_24)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_926021", "926021041", "story_v_out_926021.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_926021", "926021041", "story_v_out_926021.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_25 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_25 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_25

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_25 and arg_165_1.time_ < var_168_15 + var_168_25 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 926021042
		arg_169_1.duration_ = 9.77

		local var_169_0 = {
			zh = 6.666,
			ja = 9.766
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
				arg_169_0:Play926021043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.825

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[1297].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:GetWordFromCfg(926021042)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 33
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021042", "story_v_out_926021.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021042", "story_v_out_926021.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_926021", "926021042", "story_v_out_926021.awb")

						arg_169_1:RecordAudio("926021042", var_172_9)
						arg_169_1:RecordAudio("926021042", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_926021", "926021042", "story_v_out_926021.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_926021", "926021042", "story_v_out_926021.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play926021043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 926021043
		arg_173_1.duration_ = 2.43

		local var_173_0 = {
			zh = 2.2,
			ja = 2.433
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
				arg_173_0:Play926021044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10144"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos10144 = var_176_0.localPosition
				var_176_0.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10144", 3)

				local var_176_2 = var_176_0.childCount

				for iter_176_0 = 0, var_176_2 - 1 do
					local var_176_3 = var_176_0:GetChild(iter_176_0)

					if var_176_3.name == "split_8" or not string.find(var_176_3.name, "split") then
						var_176_3.gameObject:SetActive(true)
					else
						var_176_3.gameObject:SetActive(false)
					end
				end
			end

			local var_176_4 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_4 then
				local var_176_5 = (arg_173_1.time_ - var_176_1) / var_176_4
				local var_176_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10144, var_176_6, var_176_5)
			end

			if arg_173_1.time_ >= var_176_1 + var_176_4 and arg_173_1.time_ < var_176_1 + var_176_4 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_176_7 = 0
			local var_176_8 = 0.225

			if var_176_7 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_9 = arg_173_1:FormatText(StoryNameCfg[1297].name)

				arg_173_1.leftNameTxt_.text = var_176_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(926021043)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_12 = 9
				local var_176_13 = utf8.len(var_176_11)
				local var_176_14 = var_176_12 <= 0 and var_176_8 or var_176_8 * (var_176_13 / var_176_12)

				if var_176_14 > 0 and var_176_8 < var_176_14 then
					arg_173_1.talkMaxDuration = var_176_14

					if var_176_14 + var_176_7 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_7
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021043", "story_v_out_926021.awb") ~= 0 then
					local var_176_15 = manager.audio:GetVoiceLength("story_v_out_926021", "926021043", "story_v_out_926021.awb") / 1000

					if var_176_15 + var_176_7 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_15 + var_176_7
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_926021", "926021043", "story_v_out_926021.awb")

						arg_173_1:RecordAudio("926021043", var_176_16)
						arg_173_1:RecordAudio("926021043", var_176_16)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_926021", "926021043", "story_v_out_926021.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_926021", "926021043", "story_v_out_926021.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_17 = math.max(var_176_8, arg_173_1.talkMaxDuration)

			if var_176_7 <= arg_173_1.time_ and arg_173_1.time_ < var_176_7 + var_176_17 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_7) / var_176_17

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_7 + var_176_17 and arg_173_1.time_ < var_176_7 + var_176_17 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 926021044
		arg_177_1.duration_ = 1.57

		local var_177_0 = {
			zh = 0.999999999999,
			ja = 1.566
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play926021045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["106103"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps106103 == nil then
				arg_177_1.var_.actorSpriteComps106103 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps106103 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_4 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, var_180_3)
								local var_180_5 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, var_180_3)
								local var_180_6 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, var_180_3)

								iter_180_1.color = Color.New(var_180_4, var_180_5, var_180_6)
							else
								local var_180_7 = Mathf.Lerp(iter_180_1.color.r, 1, var_180_3)

								iter_180_1.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps106103 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps106103 = nil
			end

			local var_180_8 = arg_177_1.actors_["10144"]
			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps10144 == nil then
				arg_177_1.var_.actorSpriteComps10144 = var_180_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_10 = 0.2

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_10 and not isNil(var_180_8) then
				local var_180_11 = (arg_177_1.time_ - var_180_9) / var_180_10

				if arg_177_1.var_.actorSpriteComps10144 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								local var_180_12 = Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor2.r, var_180_11)
								local var_180_13 = Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor2.g, var_180_11)
								local var_180_14 = Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor2.b, var_180_11)

								iter_180_5.color = Color.New(var_180_12, var_180_13, var_180_14)
							else
								local var_180_15 = Mathf.Lerp(iter_180_5.color.r, 0.5, var_180_11)

								iter_180_5.color = Color.New(var_180_15, var_180_15, var_180_15)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_9 + var_180_10 and arg_177_1.time_ < var_180_9 + var_180_10 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps10144 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_180_7 then
						if arg_177_1.isInRecall_ then
							iter_180_7.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10144 = nil
			end

			local var_180_16 = 0
			local var_180_17 = 0.075

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_18 = arg_177_1:FormatText(StoryNameCfg[612].name)

				arg_177_1.leftNameTxt_.text = var_180_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_19 = arg_177_1:GetWordFromCfg(926021044)
				local var_180_20 = arg_177_1:FormatText(var_180_19.content)

				arg_177_1.text_.text = var_180_20

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_21 = 3
				local var_180_22 = utf8.len(var_180_20)
				local var_180_23 = var_180_21 <= 0 and var_180_17 or var_180_17 * (var_180_22 / var_180_21)

				if var_180_23 > 0 and var_180_17 < var_180_23 then
					arg_177_1.talkMaxDuration = var_180_23

					if var_180_23 + var_180_16 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_16
					end
				end

				arg_177_1.text_.text = var_180_20
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021044", "story_v_out_926021.awb") ~= 0 then
					local var_180_24 = manager.audio:GetVoiceLength("story_v_out_926021", "926021044", "story_v_out_926021.awb") / 1000

					if var_180_24 + var_180_16 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_24 + var_180_16
					end

					if var_180_19.prefab_name ~= "" and arg_177_1.actors_[var_180_19.prefab_name] ~= nil then
						local var_180_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_19.prefab_name].transform, "story_v_out_926021", "926021044", "story_v_out_926021.awb")

						arg_177_1:RecordAudio("926021044", var_180_25)
						arg_177_1:RecordAudio("926021044", var_180_25)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_926021", "926021044", "story_v_out_926021.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_926021", "926021044", "story_v_out_926021.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_26 = math.max(var_180_17, arg_177_1.talkMaxDuration)

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_26 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_16) / var_180_26

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_16 + var_180_26 and arg_177_1.time_ < var_180_16 + var_180_26 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play926021045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 926021045
		arg_181_1.duration_ = 15.27

		local var_181_0 = {
			zh = 8.9,
			ja = 15.266
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
				arg_181_0:Play926021046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10144"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10144 == nil then
				arg_181_1.var_.actorSpriteComps10144 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps10144 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 1, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10144 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10144 = nil
			end

			local var_184_8 = arg_181_1.actors_["106103"]
			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps106103 == nil then
				arg_181_1.var_.actorSpriteComps106103 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_10 = 0.2

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_10 and not isNil(var_184_8) then
				local var_184_11 = (arg_181_1.time_ - var_184_9) / var_184_10

				if arg_181_1.var_.actorSpriteComps106103 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								local var_184_12 = Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, var_184_11)
								local var_184_13 = Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, var_184_11)
								local var_184_14 = Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, var_184_11)

								iter_184_5.color = Color.New(var_184_12, var_184_13, var_184_14)
							else
								local var_184_15 = Mathf.Lerp(iter_184_5.color.r, 0.5, var_184_11)

								iter_184_5.color = Color.New(var_184_15, var_184_15, var_184_15)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_9 + var_184_10 and arg_181_1.time_ < var_184_9 + var_184_10 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps106103 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_184_7 then
						if arg_181_1.isInRecall_ then
							iter_184_7.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps106103 = nil
			end

			local var_184_16 = 0
			local var_184_17 = 1.1

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_18 = arg_181_1:FormatText(StoryNameCfg[1297].name)

				arg_181_1.leftNameTxt_.text = var_184_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_19 = arg_181_1:GetWordFromCfg(926021045)
				local var_184_20 = arg_181_1:FormatText(var_184_19.content)

				arg_181_1.text_.text = var_184_20

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_21 = 44
				local var_184_22 = utf8.len(var_184_20)
				local var_184_23 = var_184_21 <= 0 and var_184_17 or var_184_17 * (var_184_22 / var_184_21)

				if var_184_23 > 0 and var_184_17 < var_184_23 then
					arg_181_1.talkMaxDuration = var_184_23

					if var_184_23 + var_184_16 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_23 + var_184_16
					end
				end

				arg_181_1.text_.text = var_184_20
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021045", "story_v_out_926021.awb") ~= 0 then
					local var_184_24 = manager.audio:GetVoiceLength("story_v_out_926021", "926021045", "story_v_out_926021.awb") / 1000

					if var_184_24 + var_184_16 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_24 + var_184_16
					end

					if var_184_19.prefab_name ~= "" and arg_181_1.actors_[var_184_19.prefab_name] ~= nil then
						local var_184_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_19.prefab_name].transform, "story_v_out_926021", "926021045", "story_v_out_926021.awb")

						arg_181_1:RecordAudio("926021045", var_184_25)
						arg_181_1:RecordAudio("926021045", var_184_25)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_926021", "926021045", "story_v_out_926021.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_926021", "926021045", "story_v_out_926021.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_26 = math.max(var_184_17, arg_181_1.talkMaxDuration)

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_26 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_16) / var_184_26

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_16 + var_184_26 and arg_181_1.time_ < var_184_16 + var_184_26 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play926021046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 926021046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play926021047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10144"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10144 == nil then
				arg_185_1.var_.actorSpriteComps10144 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps10144 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								local var_188_4 = Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor2.r, var_188_3)
								local var_188_5 = Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor2.g, var_188_3)
								local var_188_6 = Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor2.b, var_188_3)

								iter_188_1.color = Color.New(var_188_4, var_188_5, var_188_6)
							else
								local var_188_7 = Mathf.Lerp(iter_188_1.color.r, 0.5, var_188_3)

								iter_188_1.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10144 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10144 = nil
			end

			local var_188_8 = 0
			local var_188_9 = 0.25

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_10 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_11 = arg_185_1:GetWordFromCfg(926021046)
				local var_188_12 = arg_185_1:FormatText(var_188_11.content)

				arg_185_1.text_.text = var_188_12

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 10
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
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play926021047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 926021047
		arg_189_1.duration_ = 7.3

		local var_189_0 = {
			zh = 7.3,
			ja = 6.3
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
				arg_189_0:Play926021048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["106103"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps106103 == nil then
				arg_189_1.var_.actorSpriteComps106103 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps106103 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								local var_192_4 = Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor1.r, var_192_3)
								local var_192_5 = Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor1.g, var_192_3)
								local var_192_6 = Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor1.b, var_192_3)

								iter_192_1.color = Color.New(var_192_4, var_192_5, var_192_6)
							else
								local var_192_7 = Mathf.Lerp(iter_192_1.color.r, 1, var_192_3)

								iter_192_1.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps106103 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps106103 = nil
			end

			local var_192_8 = arg_189_1.actors_["10144"].transform
			local var_192_9 = 0

			if var_192_9 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1.var_.moveOldPos10144 = var_192_8.localPosition
				var_192_8.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10144", 7)

				local var_192_10 = var_192_8.childCount

				for iter_192_4 = 0, var_192_10 - 1 do
					local var_192_11 = var_192_8:GetChild(iter_192_4)

					if var_192_11.name == "" or not string.find(var_192_11.name, "split") then
						var_192_11.gameObject:SetActive(true)
					else
						var_192_11.gameObject:SetActive(false)
					end
				end
			end

			local var_192_12 = 0.001

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_12 then
				local var_192_13 = (arg_189_1.time_ - var_192_9) / var_192_12
				local var_192_14 = Vector3.New(0, -2000, 0)

				var_192_8.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10144, var_192_14, var_192_13)
			end

			if arg_189_1.time_ >= var_192_9 + var_192_12 and arg_189_1.time_ < var_192_9 + var_192_12 + arg_192_0 then
				var_192_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_15 = arg_189_1.actors_["106103"].transform
			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.var_.moveOldPos106103 = var_192_15.localPosition
				var_192_15.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("106103", 3)

				local var_192_17 = var_192_15.childCount

				for iter_192_5 = 0, var_192_17 - 1 do
					local var_192_18 = var_192_15:GetChild(iter_192_5)

					if var_192_18.name == "split_4" or not string.find(var_192_18.name, "split") then
						var_192_18.gameObject:SetActive(true)
					else
						var_192_18.gameObject:SetActive(false)
					end
				end
			end

			local var_192_19 = 0.001

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_19 then
				local var_192_20 = (arg_189_1.time_ - var_192_16) / var_192_19
				local var_192_21 = Vector3.New(-36.6, -398.2, -333.7)

				var_192_15.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos106103, var_192_21, var_192_20)
			end

			if arg_189_1.time_ >= var_192_16 + var_192_19 and arg_189_1.time_ < var_192_16 + var_192_19 + arg_192_0 then
				var_192_15.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_192_22 = 0
			local var_192_23 = 0.8

			if var_192_22 < arg_189_1.time_ and arg_189_1.time_ <= var_192_22 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_24 = arg_189_1:FormatText(StoryNameCfg[612].name)

				arg_189_1.leftNameTxt_.text = var_192_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_25 = arg_189_1:GetWordFromCfg(926021047)
				local var_192_26 = arg_189_1:FormatText(var_192_25.content)

				arg_189_1.text_.text = var_192_26

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_27 = 32
				local var_192_28 = utf8.len(var_192_26)
				local var_192_29 = var_192_27 <= 0 and var_192_23 or var_192_23 * (var_192_28 / var_192_27)

				if var_192_29 > 0 and var_192_23 < var_192_29 then
					arg_189_1.talkMaxDuration = var_192_29

					if var_192_29 + var_192_22 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_29 + var_192_22
					end
				end

				arg_189_1.text_.text = var_192_26
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021047", "story_v_out_926021.awb") ~= 0 then
					local var_192_30 = manager.audio:GetVoiceLength("story_v_out_926021", "926021047", "story_v_out_926021.awb") / 1000

					if var_192_30 + var_192_22 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_30 + var_192_22
					end

					if var_192_25.prefab_name ~= "" and arg_189_1.actors_[var_192_25.prefab_name] ~= nil then
						local var_192_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_25.prefab_name].transform, "story_v_out_926021", "926021047", "story_v_out_926021.awb")

						arg_189_1:RecordAudio("926021047", var_192_31)
						arg_189_1:RecordAudio("926021047", var_192_31)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_926021", "926021047", "story_v_out_926021.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_926021", "926021047", "story_v_out_926021.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_32 = math.max(var_192_23, arg_189_1.talkMaxDuration)

			if var_192_22 <= arg_189_1.time_ and arg_189_1.time_ < var_192_22 + var_192_32 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_22) / var_192_32

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_22 + var_192_32 and arg_189_1.time_ < var_192_22 + var_192_32 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
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
	Play926021048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 926021048
		arg_193_1.duration_ = 8.17

		local var_193_0 = {
			zh = 5.6,
			ja = 8.166
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
				arg_193_0:Play926021049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["128404"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps128404 == nil then
				arg_193_1.var_.actorSpriteComps128404 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps128404 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps128404 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps128404 = nil
			end

			local var_196_8 = arg_193_1.actors_["106103"]
			local var_196_9 = 0

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps106103 == nil then
				arg_193_1.var_.actorSpriteComps106103 = var_196_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_10 = 0.2

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_10 and not isNil(var_196_8) then
				local var_196_11 = (arg_193_1.time_ - var_196_9) / var_196_10

				if arg_193_1.var_.actorSpriteComps106103 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_193_1.time_ >= var_196_9 + var_196_10 and arg_193_1.time_ < var_196_9 + var_196_10 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps106103 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_196_7 then
						if arg_193_1.isInRecall_ then
							iter_196_7.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps106103 = nil
			end

			local var_196_16 = arg_193_1.actors_["106103"].transform
			local var_196_17 = 0

			if var_196_17 < arg_193_1.time_ and arg_193_1.time_ <= var_196_17 + arg_196_0 then
				arg_193_1.var_.moveOldPos106103 = var_196_16.localPosition
				var_196_16.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("106103", 7)

				local var_196_18 = var_196_16.childCount

				for iter_196_8 = 0, var_196_18 - 1 do
					local var_196_19 = var_196_16:GetChild(iter_196_8)

					if var_196_19.name == "" or not string.find(var_196_19.name, "split") then
						var_196_19.gameObject:SetActive(true)
					else
						var_196_19.gameObject:SetActive(false)
					end
				end
			end

			local var_196_20 = 0.001

			if var_196_17 <= arg_193_1.time_ and arg_193_1.time_ < var_196_17 + var_196_20 then
				local var_196_21 = (arg_193_1.time_ - var_196_17) / var_196_20
				local var_196_22 = Vector3.New(0, -2000, 0)

				var_196_16.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos106103, var_196_22, var_196_21)
			end

			if arg_193_1.time_ >= var_196_17 + var_196_20 and arg_193_1.time_ < var_196_17 + var_196_20 + arg_196_0 then
				var_196_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_23 = arg_193_1.actors_["128404"].transform
			local var_196_24 = 0

			if var_196_24 < arg_193_1.time_ and arg_193_1.time_ <= var_196_24 + arg_196_0 then
				arg_193_1.var_.moveOldPos128404 = var_196_23.localPosition
				var_196_23.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("128404", 3)

				local var_196_25 = var_196_23.childCount

				for iter_196_9 = 0, var_196_25 - 1 do
					local var_196_26 = var_196_23:GetChild(iter_196_9)

					if var_196_26.name == "" or not string.find(var_196_26.name, "split") then
						var_196_26.gameObject:SetActive(true)
					else
						var_196_26.gameObject:SetActive(false)
					end
				end
			end

			local var_196_27 = 0.001

			if var_196_24 <= arg_193_1.time_ and arg_193_1.time_ < var_196_24 + var_196_27 then
				local var_196_28 = (arg_193_1.time_ - var_196_24) / var_196_27
				local var_196_29 = Vector3.New(-16.1, -362, -375)

				var_196_23.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos128404, var_196_29, var_196_28)
			end

			if arg_193_1.time_ >= var_196_24 + var_196_27 and arg_193_1.time_ < var_196_24 + var_196_27 + arg_196_0 then
				var_196_23.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_196_30 = 0
			local var_196_31 = 0.7

			if var_196_30 < arg_193_1.time_ and arg_193_1.time_ <= var_196_30 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_32 = arg_193_1:FormatText(StoryNameCfg[6].name)

				arg_193_1.leftNameTxt_.text = var_196_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_33 = arg_193_1:GetWordFromCfg(926021048)
				local var_196_34 = arg_193_1:FormatText(var_196_33.content)

				arg_193_1.text_.text = var_196_34

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_35 = 28
				local var_196_36 = utf8.len(var_196_34)
				local var_196_37 = var_196_35 <= 0 and var_196_31 or var_196_31 * (var_196_36 / var_196_35)

				if var_196_37 > 0 and var_196_31 < var_196_37 then
					arg_193_1.talkMaxDuration = var_196_37

					if var_196_37 + var_196_30 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_37 + var_196_30
					end
				end

				arg_193_1.text_.text = var_196_34
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021048", "story_v_out_926021.awb") ~= 0 then
					local var_196_38 = manager.audio:GetVoiceLength("story_v_out_926021", "926021048", "story_v_out_926021.awb") / 1000

					if var_196_38 + var_196_30 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_38 + var_196_30
					end

					if var_196_33.prefab_name ~= "" and arg_193_1.actors_[var_196_33.prefab_name] ~= nil then
						local var_196_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_33.prefab_name].transform, "story_v_out_926021", "926021048", "story_v_out_926021.awb")

						arg_193_1:RecordAudio("926021048", var_196_39)
						arg_193_1:RecordAudio("926021048", var_196_39)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_926021", "926021048", "story_v_out_926021.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_926021", "926021048", "story_v_out_926021.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_40 = math.max(var_196_31, arg_193_1.talkMaxDuration)

			if var_196_30 <= arg_193_1.time_ and arg_193_1.time_ < var_196_30 + var_196_40 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_30) / var_196_40

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_30 + var_196_40 and arg_193_1.time_ < var_196_30 + var_196_40 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
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
	Play926021049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 926021049
		arg_197_1.duration_ = 11.1

		local var_197_0 = {
			zh = 7.133,
			ja = 11.1
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
				arg_197_0:Play926021050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10144"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps10144 == nil then
				arg_197_1.var_.actorSpriteComps10144 = var_200_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_2 = 0.2

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.actorSpriteComps10144 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								local var_200_4 = Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor1.r, var_200_3)
								local var_200_5 = Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor1.g, var_200_3)
								local var_200_6 = Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor1.b, var_200_3)

								iter_200_1.color = Color.New(var_200_4, var_200_5, var_200_6)
							else
								local var_200_7 = Mathf.Lerp(iter_200_1.color.r, 1, var_200_3)

								iter_200_1.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps10144 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_200_3 then
						if arg_197_1.isInRecall_ then
							iter_200_3.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10144 = nil
			end

			local var_200_8 = arg_197_1.actors_["128404"]
			local var_200_9 = 0

			if var_200_9 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps128404 == nil then
				arg_197_1.var_.actorSpriteComps128404 = var_200_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_10 = 0.2

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_10 and not isNil(var_200_8) then
				local var_200_11 = (arg_197_1.time_ - var_200_9) / var_200_10

				if arg_197_1.var_.actorSpriteComps128404 then
					for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_200_5 then
							if arg_197_1.isInRecall_ then
								local var_200_12 = Mathf.Lerp(iter_200_5.color.r, arg_197_1.hightColor2.r, var_200_11)
								local var_200_13 = Mathf.Lerp(iter_200_5.color.g, arg_197_1.hightColor2.g, var_200_11)
								local var_200_14 = Mathf.Lerp(iter_200_5.color.b, arg_197_1.hightColor2.b, var_200_11)

								iter_200_5.color = Color.New(var_200_12, var_200_13, var_200_14)
							else
								local var_200_15 = Mathf.Lerp(iter_200_5.color.r, 0.5, var_200_11)

								iter_200_5.color = Color.New(var_200_15, var_200_15, var_200_15)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_9 + var_200_10 and arg_197_1.time_ < var_200_9 + var_200_10 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps128404 then
				for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_200_7 then
						if arg_197_1.isInRecall_ then
							iter_200_7.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps128404 = nil
			end

			local var_200_16 = arg_197_1.actors_["128404"].transform
			local var_200_17 = 0

			if var_200_17 < arg_197_1.time_ and arg_197_1.time_ <= var_200_17 + arg_200_0 then
				arg_197_1.var_.moveOldPos128404 = var_200_16.localPosition
				var_200_16.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("128404", 7)

				local var_200_18 = var_200_16.childCount

				for iter_200_8 = 0, var_200_18 - 1 do
					local var_200_19 = var_200_16:GetChild(iter_200_8)

					if var_200_19.name == "" or not string.find(var_200_19.name, "split") then
						var_200_19.gameObject:SetActive(true)
					else
						var_200_19.gameObject:SetActive(false)
					end
				end
			end

			local var_200_20 = 0.001

			if var_200_17 <= arg_197_1.time_ and arg_197_1.time_ < var_200_17 + var_200_20 then
				local var_200_21 = (arg_197_1.time_ - var_200_17) / var_200_20
				local var_200_22 = Vector3.New(0, -2000, 0)

				var_200_16.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos128404, var_200_22, var_200_21)
			end

			if arg_197_1.time_ >= var_200_17 + var_200_20 and arg_197_1.time_ < var_200_17 + var_200_20 + arg_200_0 then
				var_200_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_200_23 = arg_197_1.actors_["10144"].transform
			local var_200_24 = 0

			if var_200_24 < arg_197_1.time_ and arg_197_1.time_ <= var_200_24 + arg_200_0 then
				arg_197_1.var_.moveOldPos10144 = var_200_23.localPosition
				var_200_23.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10144", 3)

				local var_200_25 = var_200_23.childCount

				for iter_200_9 = 0, var_200_25 - 1 do
					local var_200_26 = var_200_23:GetChild(iter_200_9)

					if var_200_26.name == "split_10" or not string.find(var_200_26.name, "split") then
						var_200_26.gameObject:SetActive(true)
					else
						var_200_26.gameObject:SetActive(false)
					end
				end
			end

			local var_200_27 = 0.001

			if var_200_24 <= arg_197_1.time_ and arg_197_1.time_ < var_200_24 + var_200_27 then
				local var_200_28 = (arg_197_1.time_ - var_200_24) / var_200_27
				local var_200_29 = Vector3.New(-31.5, -381.1, -285.9)

				var_200_23.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10144, var_200_29, var_200_28)
			end

			if arg_197_1.time_ >= var_200_24 + var_200_27 and arg_197_1.time_ < var_200_24 + var_200_27 + arg_200_0 then
				var_200_23.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_200_30 = 0
			local var_200_31 = 0.675

			if var_200_30 < arg_197_1.time_ and arg_197_1.time_ <= var_200_30 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_32 = arg_197_1:FormatText(StoryNameCfg[1297].name)

				arg_197_1.leftNameTxt_.text = var_200_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_33 = arg_197_1:GetWordFromCfg(926021049)
				local var_200_34 = arg_197_1:FormatText(var_200_33.content)

				arg_197_1.text_.text = var_200_34

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_35 = 27
				local var_200_36 = utf8.len(var_200_34)
				local var_200_37 = var_200_35 <= 0 and var_200_31 or var_200_31 * (var_200_36 / var_200_35)

				if var_200_37 > 0 and var_200_31 < var_200_37 then
					arg_197_1.talkMaxDuration = var_200_37

					if var_200_37 + var_200_30 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_37 + var_200_30
					end
				end

				arg_197_1.text_.text = var_200_34
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021049", "story_v_out_926021.awb") ~= 0 then
					local var_200_38 = manager.audio:GetVoiceLength("story_v_out_926021", "926021049", "story_v_out_926021.awb") / 1000

					if var_200_38 + var_200_30 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_38 + var_200_30
					end

					if var_200_33.prefab_name ~= "" and arg_197_1.actors_[var_200_33.prefab_name] ~= nil then
						local var_200_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_33.prefab_name].transform, "story_v_out_926021", "926021049", "story_v_out_926021.awb")

						arg_197_1:RecordAudio("926021049", var_200_39)
						arg_197_1:RecordAudio("926021049", var_200_39)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_926021", "926021049", "story_v_out_926021.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_926021", "926021049", "story_v_out_926021.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_40 = math.max(var_200_31, arg_197_1.talkMaxDuration)

			if var_200_30 <= arg_197_1.time_ and arg_197_1.time_ < var_200_30 + var_200_40 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_30) / var_200_40

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_30 + var_200_40 and arg_197_1.time_ < var_200_30 + var_200_40 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 926021050
		arg_201_1.duration_ = 9.7

		local var_201_0 = {
			zh = 5.3,
			ja = 9.7
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
				arg_201_0:Play926021051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10144"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10144 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10144", 3)

				local var_204_2 = var_204_0.childCount

				for iter_204_0 = 0, var_204_2 - 1 do
					local var_204_3 = var_204_0:GetChild(iter_204_0)

					if var_204_3.name == "split_8" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_4 then
				local var_204_5 = (arg_201_1.time_ - var_204_1) / var_204_4
				local var_204_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10144, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_204_7 = 0
			local var_204_8 = 0.7

			if var_204_7 < arg_201_1.time_ and arg_201_1.time_ <= var_204_7 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_9 = arg_201_1:FormatText(StoryNameCfg[1297].name)

				arg_201_1.leftNameTxt_.text = var_204_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_10 = arg_201_1:GetWordFromCfg(926021050)
				local var_204_11 = arg_201_1:FormatText(var_204_10.content)

				arg_201_1.text_.text = var_204_11

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_12 = 28
				local var_204_13 = utf8.len(var_204_11)
				local var_204_14 = var_204_12 <= 0 and var_204_8 or var_204_8 * (var_204_13 / var_204_12)

				if var_204_14 > 0 and var_204_8 < var_204_14 then
					arg_201_1.talkMaxDuration = var_204_14

					if var_204_14 + var_204_7 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_7
					end
				end

				arg_201_1.text_.text = var_204_11
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021050", "story_v_out_926021.awb") ~= 0 then
					local var_204_15 = manager.audio:GetVoiceLength("story_v_out_926021", "926021050", "story_v_out_926021.awb") / 1000

					if var_204_15 + var_204_7 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_15 + var_204_7
					end

					if var_204_10.prefab_name ~= "" and arg_201_1.actors_[var_204_10.prefab_name] ~= nil then
						local var_204_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_10.prefab_name].transform, "story_v_out_926021", "926021050", "story_v_out_926021.awb")

						arg_201_1:RecordAudio("926021050", var_204_16)
						arg_201_1:RecordAudio("926021050", var_204_16)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_926021", "926021050", "story_v_out_926021.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_926021", "926021050", "story_v_out_926021.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_17 = math.max(var_204_8, arg_201_1.talkMaxDuration)

			if var_204_7 <= arg_201_1.time_ and arg_201_1.time_ < var_204_7 + var_204_17 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_7) / var_204_17

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_7 + var_204_17 and arg_201_1.time_ < var_204_7 + var_204_17 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 926021051
		arg_205_1.duration_ = 2.13

		local var_205_0 = {
			zh = 2.133,
			ja = 1.6
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
				arg_205_0:Play926021052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.175

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[1297].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(926021051)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 7
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021051", "story_v_out_926021.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021051", "story_v_out_926021.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_926021", "926021051", "story_v_out_926021.awb")

						arg_205_1:RecordAudio("926021051", var_208_9)
						arg_205_1:RecordAudio("926021051", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_926021", "926021051", "story_v_out_926021.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_926021", "926021051", "story_v_out_926021.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play926021052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 926021052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play926021053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10144"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10144 == nil then
				arg_209_1.var_.actorSpriteComps10144 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps10144 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								local var_212_4 = Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor2.r, var_212_3)
								local var_212_5 = Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor2.g, var_212_3)
								local var_212_6 = Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor2.b, var_212_3)

								iter_212_1.color = Color.New(var_212_4, var_212_5, var_212_6)
							else
								local var_212_7 = Mathf.Lerp(iter_212_1.color.r, 0.5, var_212_3)

								iter_212_1.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10144 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10144 = nil
			end

			local var_212_8 = 0
			local var_212_9 = 0.325

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_10 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_11 = arg_209_1:GetWordFromCfg(926021052)
				local var_212_12 = arg_209_1:FormatText(var_212_11.content)

				arg_209_1.text_.text = var_212_12

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 13
				local var_212_14 = utf8.len(var_212_12)
				local var_212_15 = var_212_13 <= 0 and var_212_9 or var_212_9 * (var_212_14 / var_212_13)

				if var_212_15 > 0 and var_212_9 < var_212_15 then
					arg_209_1.talkMaxDuration = var_212_15

					if var_212_15 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_15 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_12
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play926021053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 926021053
		arg_213_1.duration_ = 5.8

		local var_213_0 = {
			zh = 4.3,
			ja = 5.8
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
				arg_213_0:Play926021054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["128404"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps128404 == nil then
				arg_213_1.var_.actorSpriteComps128404 = var_216_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.actorSpriteComps128404 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps128404 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_216_3 then
						if arg_213_1.isInRecall_ then
							iter_216_3.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps128404 = nil
			end

			local var_216_8 = arg_213_1.actors_["128404"].transform
			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 then
				arg_213_1.var_.moveOldPos128404 = var_216_8.localPosition
				var_216_8.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("128404", 3)

				local var_216_10 = var_216_8.childCount

				for iter_216_4 = 0, var_216_10 - 1 do
					local var_216_11 = var_216_8:GetChild(iter_216_4)

					if var_216_11.name == "split_6" or not string.find(var_216_11.name, "split") then
						var_216_11.gameObject:SetActive(true)
					else
						var_216_11.gameObject:SetActive(false)
					end
				end
			end

			local var_216_12 = 0.001

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_12 then
				local var_216_13 = (arg_213_1.time_ - var_216_9) / var_216_12
				local var_216_14 = Vector3.New(-16.1, -362, -375)

				var_216_8.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos128404, var_216_14, var_216_13)
			end

			if arg_213_1.time_ >= var_216_9 + var_216_12 and arg_213_1.time_ < var_216_9 + var_216_12 + arg_216_0 then
				var_216_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_216_15 = arg_213_1.actors_["10144"].transform
			local var_216_16 = 0

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1.var_.moveOldPos10144 = var_216_15.localPosition
				var_216_15.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10144", 7)

				local var_216_17 = var_216_15.childCount

				for iter_216_5 = 0, var_216_17 - 1 do
					local var_216_18 = var_216_15:GetChild(iter_216_5)

					if var_216_18.name == "" or not string.find(var_216_18.name, "split") then
						var_216_18.gameObject:SetActive(true)
					else
						var_216_18.gameObject:SetActive(false)
					end
				end
			end

			local var_216_19 = 0.001

			if var_216_16 <= arg_213_1.time_ and arg_213_1.time_ < var_216_16 + var_216_19 then
				local var_216_20 = (arg_213_1.time_ - var_216_16) / var_216_19
				local var_216_21 = Vector3.New(0, -2000, 0)

				var_216_15.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10144, var_216_21, var_216_20)
			end

			if arg_213_1.time_ >= var_216_16 + var_216_19 and arg_213_1.time_ < var_216_16 + var_216_19 + arg_216_0 then
				var_216_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_216_22 = 0
			local var_216_23 = 0.675

			if var_216_22 < arg_213_1.time_ and arg_213_1.time_ <= var_216_22 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_24 = arg_213_1:FormatText(StoryNameCfg[6].name)

				arg_213_1.leftNameTxt_.text = var_216_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_25 = arg_213_1:GetWordFromCfg(926021053)
				local var_216_26 = arg_213_1:FormatText(var_216_25.content)

				arg_213_1.text_.text = var_216_26

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_27 = 27
				local var_216_28 = utf8.len(var_216_26)
				local var_216_29 = var_216_27 <= 0 and var_216_23 or var_216_23 * (var_216_28 / var_216_27)

				if var_216_29 > 0 and var_216_23 < var_216_29 then
					arg_213_1.talkMaxDuration = var_216_29

					if var_216_29 + var_216_22 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_29 + var_216_22
					end
				end

				arg_213_1.text_.text = var_216_26
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021053", "story_v_out_926021.awb") ~= 0 then
					local var_216_30 = manager.audio:GetVoiceLength("story_v_out_926021", "926021053", "story_v_out_926021.awb") / 1000

					if var_216_30 + var_216_22 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_30 + var_216_22
					end

					if var_216_25.prefab_name ~= "" and arg_213_1.actors_[var_216_25.prefab_name] ~= nil then
						local var_216_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_25.prefab_name].transform, "story_v_out_926021", "926021053", "story_v_out_926021.awb")

						arg_213_1:RecordAudio("926021053", var_216_31)
						arg_213_1:RecordAudio("926021053", var_216_31)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_926021", "926021053", "story_v_out_926021.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_926021", "926021053", "story_v_out_926021.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_32 = math.max(var_216_23, arg_213_1.talkMaxDuration)

			if var_216_22 <= arg_213_1.time_ and arg_213_1.time_ < var_216_22 + var_216_32 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_22) / var_216_32

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_22 + var_216_32 and arg_213_1.time_ < var_216_22 + var_216_32 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 926021054
		arg_217_1.duration_ = 10.67

		local var_217_0 = {
			zh = 8.366,
			ja = 10.666
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
				arg_217_0:Play926021055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10144"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10144 == nil then
				arg_217_1.var_.actorSpriteComps10144 = var_220_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_2 = 0.2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.actorSpriteComps10144 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10144 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_220_3 then
						if arg_217_1.isInRecall_ then
							iter_220_3.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10144 = nil
			end

			local var_220_8 = arg_217_1.actors_["128404"]
			local var_220_9 = 0

			if var_220_9 < arg_217_1.time_ and arg_217_1.time_ <= var_220_9 + arg_220_0 and not isNil(var_220_8) and arg_217_1.var_.actorSpriteComps128404 == nil then
				arg_217_1.var_.actorSpriteComps128404 = var_220_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_10 = 0.2

			if var_220_9 <= arg_217_1.time_ and arg_217_1.time_ < var_220_9 + var_220_10 and not isNil(var_220_8) then
				local var_220_11 = (arg_217_1.time_ - var_220_9) / var_220_10

				if arg_217_1.var_.actorSpriteComps128404 then
					for iter_220_4, iter_220_5 in pairs(arg_217_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_217_1.time_ >= var_220_9 + var_220_10 and arg_217_1.time_ < var_220_9 + var_220_10 + arg_220_0 and not isNil(var_220_8) and arg_217_1.var_.actorSpriteComps128404 then
				for iter_220_6, iter_220_7 in pairs(arg_217_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_220_7 then
						if arg_217_1.isInRecall_ then
							iter_220_7.color = arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_220_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps128404 = nil
			end

			local var_220_16 = arg_217_1.actors_["128404"].transform
			local var_220_17 = 0

			if var_220_17 < arg_217_1.time_ and arg_217_1.time_ <= var_220_17 + arg_220_0 then
				arg_217_1.var_.moveOldPos128404 = var_220_16.localPosition
				var_220_16.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("128404", 7)

				local var_220_18 = var_220_16.childCount

				for iter_220_8 = 0, var_220_18 - 1 do
					local var_220_19 = var_220_16:GetChild(iter_220_8)

					if var_220_19.name == "" or not string.find(var_220_19.name, "split") then
						var_220_19.gameObject:SetActive(true)
					else
						var_220_19.gameObject:SetActive(false)
					end
				end
			end

			local var_220_20 = 0.001

			if var_220_17 <= arg_217_1.time_ and arg_217_1.time_ < var_220_17 + var_220_20 then
				local var_220_21 = (arg_217_1.time_ - var_220_17) / var_220_20
				local var_220_22 = Vector3.New(0, -2000, 0)

				var_220_16.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos128404, var_220_22, var_220_21)
			end

			if arg_217_1.time_ >= var_220_17 + var_220_20 and arg_217_1.time_ < var_220_17 + var_220_20 + arg_220_0 then
				var_220_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_220_23 = arg_217_1.actors_["10144"].transform
			local var_220_24 = 0

			if var_220_24 < arg_217_1.time_ and arg_217_1.time_ <= var_220_24 + arg_220_0 then
				arg_217_1.var_.moveOldPos10144 = var_220_23.localPosition
				var_220_23.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10144", 3)

				local var_220_25 = var_220_23.childCount

				for iter_220_9 = 0, var_220_25 - 1 do
					local var_220_26 = var_220_23:GetChild(iter_220_9)

					if var_220_26.name == "split_8" or not string.find(var_220_26.name, "split") then
						var_220_26.gameObject:SetActive(true)
					else
						var_220_26.gameObject:SetActive(false)
					end
				end
			end

			local var_220_27 = 0.001

			if var_220_24 <= arg_217_1.time_ and arg_217_1.time_ < var_220_24 + var_220_27 then
				local var_220_28 = (arg_217_1.time_ - var_220_24) / var_220_27
				local var_220_29 = Vector3.New(-31.5, -381.1, -285.9)

				var_220_23.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10144, var_220_29, var_220_28)
			end

			if arg_217_1.time_ >= var_220_24 + var_220_27 and arg_217_1.time_ < var_220_24 + var_220_27 + arg_220_0 then
				var_220_23.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_220_30 = 0
			local var_220_31 = 0.9

			if var_220_30 < arg_217_1.time_ and arg_217_1.time_ <= var_220_30 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_32 = arg_217_1:FormatText(StoryNameCfg[1297].name)

				arg_217_1.leftNameTxt_.text = var_220_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_33 = arg_217_1:GetWordFromCfg(926021054)
				local var_220_34 = arg_217_1:FormatText(var_220_33.content)

				arg_217_1.text_.text = var_220_34

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_35 = 36
				local var_220_36 = utf8.len(var_220_34)
				local var_220_37 = var_220_35 <= 0 and var_220_31 or var_220_31 * (var_220_36 / var_220_35)

				if var_220_37 > 0 and var_220_31 < var_220_37 then
					arg_217_1.talkMaxDuration = var_220_37

					if var_220_37 + var_220_30 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_37 + var_220_30
					end
				end

				arg_217_1.text_.text = var_220_34
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021054", "story_v_out_926021.awb") ~= 0 then
					local var_220_38 = manager.audio:GetVoiceLength("story_v_out_926021", "926021054", "story_v_out_926021.awb") / 1000

					if var_220_38 + var_220_30 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_38 + var_220_30
					end

					if var_220_33.prefab_name ~= "" and arg_217_1.actors_[var_220_33.prefab_name] ~= nil then
						local var_220_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_33.prefab_name].transform, "story_v_out_926021", "926021054", "story_v_out_926021.awb")

						arg_217_1:RecordAudio("926021054", var_220_39)
						arg_217_1:RecordAudio("926021054", var_220_39)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_926021", "926021054", "story_v_out_926021.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_926021", "926021054", "story_v_out_926021.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_40 = math.max(var_220_31, arg_217_1.talkMaxDuration)

			if var_220_30 <= arg_217_1.time_ and arg_217_1.time_ < var_220_30 + var_220_40 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_30) / var_220_40

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_30 + var_220_40 and arg_217_1.time_ < var_220_30 + var_220_40 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 926021055
		arg_221_1.duration_ = 7.83

		local var_221_0 = {
			zh = 5.733,
			ja = 7.833
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
				arg_221_0:Play926021056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.475

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[1297].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:GetWordFromCfg(926021055)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 19
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021055", "story_v_out_926021.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021055", "story_v_out_926021.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_926021", "926021055", "story_v_out_926021.awb")

						arg_221_1:RecordAudio("926021055", var_224_9)
						arg_221_1:RecordAudio("926021055", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_926021", "926021055", "story_v_out_926021.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_926021", "926021055", "story_v_out_926021.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play926021056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 926021056
		arg_225_1.duration_ = 10.1

		local var_225_0 = {
			zh = 6.866,
			ja = 10.1
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
				arg_225_0:Play926021057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.925

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[1297].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:GetWordFromCfg(926021056)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 37
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021056", "story_v_out_926021.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021056", "story_v_out_926021.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_926021", "926021056", "story_v_out_926021.awb")

						arg_225_1:RecordAudio("926021056", var_228_9)
						arg_225_1:RecordAudio("926021056", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_926021", "926021056", "story_v_out_926021.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_926021", "926021056", "story_v_out_926021.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_10 and arg_225_1.time_ < var_228_0 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play926021057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 926021057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play926021058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10144"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps10144 == nil then
				arg_229_1.var_.actorSpriteComps10144 = var_232_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_2 = 0.2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.actorSpriteComps10144 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								local var_232_4 = Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor2.r, var_232_3)
								local var_232_5 = Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor2.g, var_232_3)
								local var_232_6 = Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor2.b, var_232_3)

								iter_232_1.color = Color.New(var_232_4, var_232_5, var_232_6)
							else
								local var_232_7 = Mathf.Lerp(iter_232_1.color.r, 0.5, var_232_3)

								iter_232_1.color = Color.New(var_232_7, var_232_7, var_232_7)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps10144 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_232_3 then
						if arg_229_1.isInRecall_ then
							iter_232_3.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10144 = nil
			end

			local var_232_8 = 0
			local var_232_9 = 0.2

			if var_232_8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_10 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_11 = arg_229_1:GetWordFromCfg(926021057)
				local var_232_12 = arg_229_1:FormatText(var_232_11.content)

				arg_229_1.text_.text = var_232_12

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_13 = 8
				local var_232_14 = utf8.len(var_232_12)
				local var_232_15 = var_232_13 <= 0 and var_232_9 or var_232_9 * (var_232_14 / var_232_13)

				if var_232_15 > 0 and var_232_9 < var_232_15 then
					arg_229_1.talkMaxDuration = var_232_15

					if var_232_15 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_15 + var_232_8
					end
				end

				arg_229_1.text_.text = var_232_12
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_16 = math.max(var_232_9, arg_229_1.talkMaxDuration)

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_8) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_8 + var_232_16 and arg_229_1.time_ < var_232_8 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play926021058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 926021058
		arg_233_1.duration_ = 4.6

		local var_233_0 = {
			zh = 4.033,
			ja = 4.6
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
				arg_233_0:Play926021059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10144"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps10144 == nil then
				arg_233_1.var_.actorSpriteComps10144 = var_236_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_2 = 0.2

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.actorSpriteComps10144 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps10144 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_236_3 then
						if arg_233_1.isInRecall_ then
							iter_236_3.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10144 = nil
			end

			local var_236_8 = 0
			local var_236_9 = 0.525

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_10 = arg_233_1:FormatText(StoryNameCfg[1297].name)

				arg_233_1.leftNameTxt_.text = var_236_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_11 = arg_233_1:GetWordFromCfg(926021058)
				local var_236_12 = arg_233_1:FormatText(var_236_11.content)

				arg_233_1.text_.text = var_236_12

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 21
				local var_236_14 = utf8.len(var_236_12)
				local var_236_15 = var_236_13 <= 0 and var_236_9 or var_236_9 * (var_236_14 / var_236_13)

				if var_236_15 > 0 and var_236_9 < var_236_15 then
					arg_233_1.talkMaxDuration = var_236_15

					if var_236_15 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_15 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_12
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021058", "story_v_out_926021.awb") ~= 0 then
					local var_236_16 = manager.audio:GetVoiceLength("story_v_out_926021", "926021058", "story_v_out_926021.awb") / 1000

					if var_236_16 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_16 + var_236_8
					end

					if var_236_11.prefab_name ~= "" and arg_233_1.actors_[var_236_11.prefab_name] ~= nil then
						local var_236_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_11.prefab_name].transform, "story_v_out_926021", "926021058", "story_v_out_926021.awb")

						arg_233_1:RecordAudio("926021058", var_236_17)
						arg_233_1:RecordAudio("926021058", var_236_17)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_926021", "926021058", "story_v_out_926021.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_926021", "926021058", "story_v_out_926021.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_18 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_18 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_18

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_18 and arg_233_1.time_ < var_236_8 + var_236_18 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play926021059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 926021059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play926021060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10144"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.actorSpriteComps10144 == nil then
				arg_237_1.var_.actorSpriteComps10144 = var_240_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_2 = 0.2

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.actorSpriteComps10144 then
					for iter_240_0, iter_240_1 in pairs(arg_237_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_240_1 then
							if arg_237_1.isInRecall_ then
								local var_240_4 = Mathf.Lerp(iter_240_1.color.r, arg_237_1.hightColor2.r, var_240_3)
								local var_240_5 = Mathf.Lerp(iter_240_1.color.g, arg_237_1.hightColor2.g, var_240_3)
								local var_240_6 = Mathf.Lerp(iter_240_1.color.b, arg_237_1.hightColor2.b, var_240_3)

								iter_240_1.color = Color.New(var_240_4, var_240_5, var_240_6)
							else
								local var_240_7 = Mathf.Lerp(iter_240_1.color.r, 0.5, var_240_3)

								iter_240_1.color = Color.New(var_240_7, var_240_7, var_240_7)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.actorSpriteComps10144 then
				for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_240_3 then
						if arg_237_1.isInRecall_ then
							iter_240_3.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10144 = nil
			end

			local var_240_8 = 0
			local var_240_9 = 0.425

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_10 = arg_237_1:FormatText(StoryNameCfg[7].name)

				arg_237_1.leftNameTxt_.text = var_240_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_11 = arg_237_1:GetWordFromCfg(926021059)
				local var_240_12 = arg_237_1:FormatText(var_240_11.content)

				arg_237_1.text_.text = var_240_12

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 17
				local var_240_14 = utf8.len(var_240_12)
				local var_240_15 = var_240_13 <= 0 and var_240_9 or var_240_9 * (var_240_14 / var_240_13)

				if var_240_15 > 0 and var_240_9 < var_240_15 then
					arg_237_1.talkMaxDuration = var_240_15

					if var_240_15 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_15 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_12
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_16 and arg_237_1.time_ < var_240_8 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play926021060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 926021060
		arg_241_1.duration_ = 12.77

		local var_241_0 = {
			zh = 8.233,
			ja = 12.766
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
				arg_241_0:Play926021061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10144"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps10144 == nil then
				arg_241_1.var_.actorSpriteComps10144 = var_244_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_2 = 0.2

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.actorSpriteComps10144 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps10144 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_244_3 then
						if arg_241_1.isInRecall_ then
							iter_244_3.color = arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_244_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps10144 = nil
			end

			local var_244_8 = 0
			local var_244_9 = 1.1

			if var_244_8 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_10 = arg_241_1:FormatText(StoryNameCfg[1297].name)

				arg_241_1.leftNameTxt_.text = var_244_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_11 = arg_241_1:GetWordFromCfg(926021060)
				local var_244_12 = arg_241_1:FormatText(var_244_11.content)

				arg_241_1.text_.text = var_244_12

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_13 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021060", "story_v_out_926021.awb") ~= 0 then
					local var_244_16 = manager.audio:GetVoiceLength("story_v_out_926021", "926021060", "story_v_out_926021.awb") / 1000

					if var_244_16 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_16 + var_244_8
					end

					if var_244_11.prefab_name ~= "" and arg_241_1.actors_[var_244_11.prefab_name] ~= nil then
						local var_244_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_11.prefab_name].transform, "story_v_out_926021", "926021060", "story_v_out_926021.awb")

						arg_241_1:RecordAudio("926021060", var_244_17)
						arg_241_1:RecordAudio("926021060", var_244_17)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_926021", "926021060", "story_v_out_926021.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_926021", "926021060", "story_v_out_926021.awb")
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
	Play926021061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 926021061
		arg_245_1.duration_ = 7.1

		local var_245_0 = {
			zh = 4.4,
			ja = 7.1
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
				arg_245_0:Play926021062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.55

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[1297].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:GetWordFromCfg(926021061)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021061", "story_v_out_926021.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021061", "story_v_out_926021.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_926021", "926021061", "story_v_out_926021.awb")

						arg_245_1:RecordAudio("926021061", var_248_9)
						arg_245_1:RecordAudio("926021061", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_926021", "926021061", "story_v_out_926021.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_926021", "926021061", "story_v_out_926021.awb")
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
	Play926021062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 926021062
		arg_249_1.duration_ = 6.9

		local var_249_0 = {
			zh = 4.7,
			ja = 6.9
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
				arg_249_0:Play926021063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["106103"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.actorSpriteComps106103 == nil then
				arg_249_1.var_.actorSpriteComps106103 = var_252_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_2 = 0.2

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.actorSpriteComps106103 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_252_1 then
							if arg_249_1.isInRecall_ then
								local var_252_4 = Mathf.Lerp(iter_252_1.color.r, arg_249_1.hightColor1.r, var_252_3)
								local var_252_5 = Mathf.Lerp(iter_252_1.color.g, arg_249_1.hightColor1.g, var_252_3)
								local var_252_6 = Mathf.Lerp(iter_252_1.color.b, arg_249_1.hightColor1.b, var_252_3)

								iter_252_1.color = Color.New(var_252_4, var_252_5, var_252_6)
							else
								local var_252_7 = Mathf.Lerp(iter_252_1.color.r, 1, var_252_3)

								iter_252_1.color = Color.New(var_252_7, var_252_7, var_252_7)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.actorSpriteComps106103 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_252_3 then
						if arg_249_1.isInRecall_ then
							iter_252_3.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps106103 = nil
			end

			local var_252_8 = arg_249_1.actors_["10144"]
			local var_252_9 = 0

			if var_252_9 < arg_249_1.time_ and arg_249_1.time_ <= var_252_9 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10144 == nil then
				arg_249_1.var_.actorSpriteComps10144 = var_252_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_10 = 0.2

			if var_252_9 <= arg_249_1.time_ and arg_249_1.time_ < var_252_9 + var_252_10 and not isNil(var_252_8) then
				local var_252_11 = (arg_249_1.time_ - var_252_9) / var_252_10

				if arg_249_1.var_.actorSpriteComps10144 then
					for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_252_5 then
							if arg_249_1.isInRecall_ then
								local var_252_12 = Mathf.Lerp(iter_252_5.color.r, arg_249_1.hightColor2.r, var_252_11)
								local var_252_13 = Mathf.Lerp(iter_252_5.color.g, arg_249_1.hightColor2.g, var_252_11)
								local var_252_14 = Mathf.Lerp(iter_252_5.color.b, arg_249_1.hightColor2.b, var_252_11)

								iter_252_5.color = Color.New(var_252_12, var_252_13, var_252_14)
							else
								local var_252_15 = Mathf.Lerp(iter_252_5.color.r, 0.5, var_252_11)

								iter_252_5.color = Color.New(var_252_15, var_252_15, var_252_15)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_9 + var_252_10 and arg_249_1.time_ < var_252_9 + var_252_10 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10144 then
				for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_252_7 then
						if arg_249_1.isInRecall_ then
							iter_252_7.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps10144 = nil
			end

			local var_252_16 = 0
			local var_252_17 = 0.6

			if var_252_16 < arg_249_1.time_ and arg_249_1.time_ <= var_252_16 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_18 = arg_249_1:FormatText(StoryNameCfg[612].name)

				arg_249_1.leftNameTxt_.text = var_252_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_19 = arg_249_1:GetWordFromCfg(926021062)
				local var_252_20 = arg_249_1:FormatText(var_252_19.content)

				arg_249_1.text_.text = var_252_20

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_21 = 24
				local var_252_22 = utf8.len(var_252_20)
				local var_252_23 = var_252_21 <= 0 and var_252_17 or var_252_17 * (var_252_22 / var_252_21)

				if var_252_23 > 0 and var_252_17 < var_252_23 then
					arg_249_1.talkMaxDuration = var_252_23

					if var_252_23 + var_252_16 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_23 + var_252_16
					end
				end

				arg_249_1.text_.text = var_252_20
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021062", "story_v_out_926021.awb") ~= 0 then
					local var_252_24 = manager.audio:GetVoiceLength("story_v_out_926021", "926021062", "story_v_out_926021.awb") / 1000

					if var_252_24 + var_252_16 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_24 + var_252_16
					end

					if var_252_19.prefab_name ~= "" and arg_249_1.actors_[var_252_19.prefab_name] ~= nil then
						local var_252_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_19.prefab_name].transform, "story_v_out_926021", "926021062", "story_v_out_926021.awb")

						arg_249_1:RecordAudio("926021062", var_252_25)
						arg_249_1:RecordAudio("926021062", var_252_25)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_926021", "926021062", "story_v_out_926021.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_926021", "926021062", "story_v_out_926021.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_26 = math.max(var_252_17, arg_249_1.talkMaxDuration)

			if var_252_16 <= arg_249_1.time_ and arg_249_1.time_ < var_252_16 + var_252_26 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_16) / var_252_26

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_16 + var_252_26 and arg_249_1.time_ < var_252_16 + var_252_26 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play926021063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 926021063
		arg_253_1.duration_ = 8

		local var_253_0 = {
			zh = 5.166,
			ja = 8
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
				arg_253_0:Play926021064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10144"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps10144 == nil then
				arg_253_1.var_.actorSpriteComps10144 = var_256_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_2 = 0.2

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.actorSpriteComps10144 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps10144 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_256_3 then
						if arg_253_1.isInRecall_ then
							iter_256_3.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10144 = nil
			end

			local var_256_8 = arg_253_1.actors_["106103"]
			local var_256_9 = 0

			if var_256_9 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps106103 == nil then
				arg_253_1.var_.actorSpriteComps106103 = var_256_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_10 = 0.2

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_10 and not isNil(var_256_8) then
				local var_256_11 = (arg_253_1.time_ - var_256_9) / var_256_10

				if arg_253_1.var_.actorSpriteComps106103 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_253_1.time_ >= var_256_9 + var_256_10 and arg_253_1.time_ < var_256_9 + var_256_10 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps106103 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_256_7 then
						if arg_253_1.isInRecall_ then
							iter_256_7.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps106103 = nil
			end

			local var_256_16 = arg_253_1.actors_["10144"].transform
			local var_256_17 = 0

			if var_256_17 < arg_253_1.time_ and arg_253_1.time_ <= var_256_17 + arg_256_0 then
				arg_253_1.var_.moveOldPos10144 = var_256_16.localPosition
				var_256_16.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10144", 3)

				local var_256_18 = var_256_16.childCount

				for iter_256_8 = 0, var_256_18 - 1 do
					local var_256_19 = var_256_16:GetChild(iter_256_8)

					if var_256_19.name == "split_10" or not string.find(var_256_19.name, "split") then
						var_256_19.gameObject:SetActive(true)
					else
						var_256_19.gameObject:SetActive(false)
					end
				end
			end

			local var_256_20 = 0.001

			if var_256_17 <= arg_253_1.time_ and arg_253_1.time_ < var_256_17 + var_256_20 then
				local var_256_21 = (arg_253_1.time_ - var_256_17) / var_256_20
				local var_256_22 = Vector3.New(-31.5, -381.1, -285.9)

				var_256_16.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10144, var_256_22, var_256_21)
			end

			if arg_253_1.time_ >= var_256_17 + var_256_20 and arg_253_1.time_ < var_256_17 + var_256_20 + arg_256_0 then
				var_256_16.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_256_23 = 0
			local var_256_24 = 0.65

			if var_256_23 < arg_253_1.time_ and arg_253_1.time_ <= var_256_23 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_25 = arg_253_1:FormatText(StoryNameCfg[1297].name)

				arg_253_1.leftNameTxt_.text = var_256_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_26 = arg_253_1:GetWordFromCfg(926021063)
				local var_256_27 = arg_253_1:FormatText(var_256_26.content)

				arg_253_1.text_.text = var_256_27

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_28 = 26
				local var_256_29 = utf8.len(var_256_27)
				local var_256_30 = var_256_28 <= 0 and var_256_24 or var_256_24 * (var_256_29 / var_256_28)

				if var_256_30 > 0 and var_256_24 < var_256_30 then
					arg_253_1.talkMaxDuration = var_256_30

					if var_256_30 + var_256_23 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_30 + var_256_23
					end
				end

				arg_253_1.text_.text = var_256_27
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021063", "story_v_out_926021.awb") ~= 0 then
					local var_256_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021063", "story_v_out_926021.awb") / 1000

					if var_256_31 + var_256_23 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_31 + var_256_23
					end

					if var_256_26.prefab_name ~= "" and arg_253_1.actors_[var_256_26.prefab_name] ~= nil then
						local var_256_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_26.prefab_name].transform, "story_v_out_926021", "926021063", "story_v_out_926021.awb")

						arg_253_1:RecordAudio("926021063", var_256_32)
						arg_253_1:RecordAudio("926021063", var_256_32)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_926021", "926021063", "story_v_out_926021.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_926021", "926021063", "story_v_out_926021.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_33 = math.max(var_256_24, arg_253_1.talkMaxDuration)

			if var_256_23 <= arg_253_1.time_ and arg_253_1.time_ < var_256_23 + var_256_33 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_23) / var_256_33

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_23 + var_256_33 and arg_253_1.time_ < var_256_23 + var_256_33 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play926021064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 926021064
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play926021065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10144"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10144 == nil then
				arg_257_1.var_.actorSpriteComps10144 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps10144 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								local var_260_4 = Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor2.r, var_260_3)
								local var_260_5 = Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor2.g, var_260_3)
								local var_260_6 = Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor2.b, var_260_3)

								iter_260_1.color = Color.New(var_260_4, var_260_5, var_260_6)
							else
								local var_260_7 = Mathf.Lerp(iter_260_1.color.r, 0.5, var_260_3)

								iter_260_1.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10144 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10144 = nil
			end

			local var_260_8 = 0
			local var_260_9 = 0.2

			if var_260_8 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_10 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_11 = arg_257_1:GetWordFromCfg(926021064)
				local var_260_12 = arg_257_1:FormatText(var_260_11.content)

				arg_257_1.text_.text = var_260_12

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 8
				local var_260_14 = utf8.len(var_260_12)
				local var_260_15 = var_260_13 <= 0 and var_260_9 or var_260_9 * (var_260_14 / var_260_13)

				if var_260_15 > 0 and var_260_9 < var_260_15 then
					arg_257_1.talkMaxDuration = var_260_15

					if var_260_15 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_15 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_12
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_16 and arg_257_1.time_ < var_260_8 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play926021065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 926021065
		arg_261_1.duration_ = 5.83

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play926021066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10144"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10144 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10144", 7)

				local var_264_2 = var_264_0.childCount

				for iter_264_0 = 0, var_264_2 - 1 do
					local var_264_3 = var_264_0:GetChild(iter_264_0)

					if var_264_3.name == "" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_4 then
				local var_264_5 = (arg_261_1.time_ - var_264_1) / var_264_4
				local var_264_6 = Vector3.New(0, -2000, 0)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10144, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_264_7 = 0

			if var_264_7 < arg_261_1.time_ and arg_261_1.time_ <= var_264_7 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_8 = 0.833333333333333

			if var_264_7 <= arg_261_1.time_ and arg_261_1.time_ < var_264_7 + var_264_8 then
				local var_264_9 = (arg_261_1.time_ - var_264_7) / var_264_8
				local var_264_10 = Color.New(0, 0, 0)

				var_264_10.a = Mathf.Lerp(1, 0, var_264_9)
				arg_261_1.mask_.color = var_264_10
			end

			if arg_261_1.time_ >= var_264_7 + var_264_8 and arg_261_1.time_ < var_264_7 + var_264_8 + arg_264_0 then
				local var_264_11 = Color.New(0, 0, 0)
				local var_264_12 = 0

				arg_261_1.mask_.enabled = false
				var_264_11.a = var_264_12
				arg_261_1.mask_.color = var_264_11
			end

			local var_264_13 = 0

			if var_264_13 < arg_261_1.time_ and arg_261_1.time_ <= var_264_13 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			local var_264_14 = 1

			if arg_261_1.time_ >= var_264_13 + var_264_14 and arg_261_1.time_ < var_264_13 + var_264_14 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			local var_264_15 = 0.3
			local var_264_16 = 1

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				local var_264_17 = "play"
				local var_264_18 = "effect"

				arg_261_1:AudioAction(var_264_17, var_264_18, "se_story_143", "se_story_143_hungry02", "")
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_19 = 0.833333333333333
			local var_264_20 = 1.375

			if var_264_19 < arg_261_1.time_ and arg_261_1.time_ <= var_264_19 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_21 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_21:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_22 = arg_261_1:GetWordFromCfg(926021065)
				local var_264_23 = arg_261_1:FormatText(var_264_22.content)

				arg_261_1.text_.text = var_264_23

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_24 = 55
				local var_264_25 = utf8.len(var_264_23)
				local var_264_26 = var_264_24 <= 0 and var_264_20 or var_264_20 * (var_264_25 / var_264_24)

				if var_264_26 > 0 and var_264_20 < var_264_26 then
					arg_261_1.talkMaxDuration = var_264_26
					var_264_19 = var_264_19 + 0.3

					if var_264_26 + var_264_19 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_26 + var_264_19
					end
				end

				arg_261_1.text_.text = var_264_23
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_27 = var_264_19 + 0.3
			local var_264_28 = math.max(var_264_20, arg_261_1.talkMaxDuration)

			if var_264_27 <= arg_261_1.time_ and arg_261_1.time_ < var_264_27 + var_264_28 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_27) / var_264_28

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_27 + var_264_28 and arg_261_1.time_ < var_264_27 + var_264_28 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play926021066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 926021066
		arg_267_1.duration_ = 2.33

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play926021067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["128404"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps128404 == nil then
				arg_267_1.var_.actorSpriteComps128404 = var_270_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_2 = 0.2

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.actorSpriteComps128404 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								local var_270_4 = Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, var_270_3)
								local var_270_5 = Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, var_270_3)
								local var_270_6 = Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, var_270_3)

								iter_270_1.color = Color.New(var_270_4, var_270_5, var_270_6)
							else
								local var_270_7 = Mathf.Lerp(iter_270_1.color.r, 1, var_270_3)

								iter_270_1.color = Color.New(var_270_7, var_270_7, var_270_7)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps128404 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_270_3 then
						if arg_267_1.isInRecall_ then
							iter_270_3.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_270_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps128404 = nil
			end

			local var_270_8 = arg_267_1.actors_["128404"].transform
			local var_270_9 = 0

			if var_270_9 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 then
				arg_267_1.var_.moveOldPos128404 = var_270_8.localPosition
				var_270_8.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("128404", 3)

				local var_270_10 = var_270_8.childCount

				for iter_270_4 = 0, var_270_10 - 1 do
					local var_270_11 = var_270_8:GetChild(iter_270_4)

					if var_270_11.name == "split_5" or not string.find(var_270_11.name, "split") then
						var_270_11.gameObject:SetActive(true)
					else
						var_270_11.gameObject:SetActive(false)
					end
				end
			end

			local var_270_12 = 0.001

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_12 then
				local var_270_13 = (arg_267_1.time_ - var_270_9) / var_270_12
				local var_270_14 = Vector3.New(-16.1, -362, -375)

				var_270_8.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos128404, var_270_14, var_270_13)
			end

			if arg_267_1.time_ >= var_270_9 + var_270_12 and arg_267_1.time_ < var_270_9 + var_270_12 + arg_270_0 then
				var_270_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_270_15 = 0
			local var_270_16 = 0.175

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_17 = arg_267_1:FormatText(StoryNameCfg[6].name)

				arg_267_1.leftNameTxt_.text = var_270_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_18 = arg_267_1:GetWordFromCfg(926021066)
				local var_270_19 = arg_267_1:FormatText(var_270_18.content)

				arg_267_1.text_.text = var_270_19

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_20 = 7
				local var_270_21 = utf8.len(var_270_19)
				local var_270_22 = var_270_20 <= 0 and var_270_16 or var_270_16 * (var_270_21 / var_270_20)

				if var_270_22 > 0 and var_270_16 < var_270_22 then
					arg_267_1.talkMaxDuration = var_270_22

					if var_270_22 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_22 + var_270_15
					end
				end

				arg_267_1.text_.text = var_270_19
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021066", "story_v_out_926021.awb") ~= 0 then
					local var_270_23 = manager.audio:GetVoiceLength("story_v_out_926021", "926021066", "story_v_out_926021.awb") / 1000

					if var_270_23 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_23 + var_270_15
					end

					if var_270_18.prefab_name ~= "" and arg_267_1.actors_[var_270_18.prefab_name] ~= nil then
						local var_270_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_18.prefab_name].transform, "story_v_out_926021", "926021066", "story_v_out_926021.awb")

						arg_267_1:RecordAudio("926021066", var_270_24)
						arg_267_1:RecordAudio("926021066", var_270_24)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_926021", "926021066", "story_v_out_926021.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_926021", "926021066", "story_v_out_926021.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_25 = math.max(var_270_16, arg_267_1.talkMaxDuration)

			if var_270_15 <= arg_267_1.time_ and arg_267_1.time_ < var_270_15 + var_270_25 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_15) / var_270_25

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_15 + var_270_25 and arg_267_1.time_ < var_270_15 + var_270_25 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play926021067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 926021067
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play926021068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["128404"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps128404 == nil then
				arg_271_1.var_.actorSpriteComps128404 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps128404 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								local var_274_4 = Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor2.r, var_274_3)
								local var_274_5 = Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor2.g, var_274_3)
								local var_274_6 = Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor2.b, var_274_3)

								iter_274_1.color = Color.New(var_274_4, var_274_5, var_274_6)
							else
								local var_274_7 = Mathf.Lerp(iter_274_1.color.r, 0.5, var_274_3)

								iter_274_1.color = Color.New(var_274_7, var_274_7, var_274_7)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps128404 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps128404 = nil
			end

			local var_274_8 = 0
			local var_274_9 = 0.125

			if var_274_8 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_10 = arg_271_1:FormatText(StoryNameCfg[7].name)

				arg_271_1.leftNameTxt_.text = var_274_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_11 = arg_271_1:GetWordFromCfg(926021067)
				local var_274_12 = arg_271_1:FormatText(var_274_11.content)

				arg_271_1.text_.text = var_274_12

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_13 = 5
				local var_274_14 = utf8.len(var_274_12)
				local var_274_15 = var_274_13 <= 0 and var_274_9 or var_274_9 * (var_274_14 / var_274_13)

				if var_274_15 > 0 and var_274_9 < var_274_15 then
					arg_271_1.talkMaxDuration = var_274_15

					if var_274_15 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_15 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_12
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_16 and arg_271_1.time_ < var_274_8 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play926021068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 926021068
		arg_275_1.duration_ = 5.8

		local var_275_0 = {
			zh = 4.233,
			ja = 5.8
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play926021069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10144"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10144 == nil then
				arg_275_1.var_.actorSpriteComps10144 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps10144 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								local var_278_4 = Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor1.r, var_278_3)
								local var_278_5 = Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor1.g, var_278_3)
								local var_278_6 = Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor1.b, var_278_3)

								iter_278_1.color = Color.New(var_278_4, var_278_5, var_278_6)
							else
								local var_278_7 = Mathf.Lerp(iter_278_1.color.r, 1, var_278_3)

								iter_278_1.color = Color.New(var_278_7, var_278_7, var_278_7)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10144 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_278_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps10144 = nil
			end

			local var_278_8 = arg_275_1.actors_["128404"].transform
			local var_278_9 = 0

			if var_278_9 < arg_275_1.time_ and arg_275_1.time_ <= var_278_9 + arg_278_0 then
				arg_275_1.var_.moveOldPos128404 = var_278_8.localPosition
				var_278_8.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("128404", 7)

				local var_278_10 = var_278_8.childCount

				for iter_278_4 = 0, var_278_10 - 1 do
					local var_278_11 = var_278_8:GetChild(iter_278_4)

					if var_278_11.name == "" or not string.find(var_278_11.name, "split") then
						var_278_11.gameObject:SetActive(true)
					else
						var_278_11.gameObject:SetActive(false)
					end
				end
			end

			local var_278_12 = 0.001

			if var_278_9 <= arg_275_1.time_ and arg_275_1.time_ < var_278_9 + var_278_12 then
				local var_278_13 = (arg_275_1.time_ - var_278_9) / var_278_12
				local var_278_14 = Vector3.New(0, -2000, 0)

				var_278_8.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos128404, var_278_14, var_278_13)
			end

			if arg_275_1.time_ >= var_278_9 + var_278_12 and arg_275_1.time_ < var_278_9 + var_278_12 + arg_278_0 then
				var_278_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_278_15 = arg_275_1.actors_["10144"].transform
			local var_278_16 = 0

			if var_278_16 < arg_275_1.time_ and arg_275_1.time_ <= var_278_16 + arg_278_0 then
				arg_275_1.var_.moveOldPos10144 = var_278_15.localPosition
				var_278_15.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10144", 3)

				local var_278_17 = var_278_15.childCount

				for iter_278_5 = 0, var_278_17 - 1 do
					local var_278_18 = var_278_15:GetChild(iter_278_5)

					if var_278_18.name == "split_8" or not string.find(var_278_18.name, "split") then
						var_278_18.gameObject:SetActive(true)
					else
						var_278_18.gameObject:SetActive(false)
					end
				end
			end

			local var_278_19 = 0.001

			if var_278_16 <= arg_275_1.time_ and arg_275_1.time_ < var_278_16 + var_278_19 then
				local var_278_20 = (arg_275_1.time_ - var_278_16) / var_278_19
				local var_278_21 = Vector3.New(-31.5, -381.1, -285.9)

				var_278_15.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10144, var_278_21, var_278_20)
			end

			if arg_275_1.time_ >= var_278_16 + var_278_19 and arg_275_1.time_ < var_278_16 + var_278_19 + arg_278_0 then
				var_278_15.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_278_22 = 0
			local var_278_23 = 0.475

			if var_278_22 < arg_275_1.time_ and arg_275_1.time_ <= var_278_22 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_24 = arg_275_1:FormatText(StoryNameCfg[1297].name)

				arg_275_1.leftNameTxt_.text = var_278_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_25 = arg_275_1:GetWordFromCfg(926021068)
				local var_278_26 = arg_275_1:FormatText(var_278_25.content)

				arg_275_1.text_.text = var_278_26

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_27 = 19
				local var_278_28 = utf8.len(var_278_26)
				local var_278_29 = var_278_27 <= 0 and var_278_23 or var_278_23 * (var_278_28 / var_278_27)

				if var_278_29 > 0 and var_278_23 < var_278_29 then
					arg_275_1.talkMaxDuration = var_278_29

					if var_278_29 + var_278_22 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_29 + var_278_22
					end
				end

				arg_275_1.text_.text = var_278_26
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021068", "story_v_out_926021.awb") ~= 0 then
					local var_278_30 = manager.audio:GetVoiceLength("story_v_out_926021", "926021068", "story_v_out_926021.awb") / 1000

					if var_278_30 + var_278_22 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_30 + var_278_22
					end

					if var_278_25.prefab_name ~= "" and arg_275_1.actors_[var_278_25.prefab_name] ~= nil then
						local var_278_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_25.prefab_name].transform, "story_v_out_926021", "926021068", "story_v_out_926021.awb")

						arg_275_1:RecordAudio("926021068", var_278_31)
						arg_275_1:RecordAudio("926021068", var_278_31)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_926021", "926021068", "story_v_out_926021.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_926021", "926021068", "story_v_out_926021.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_32 = math.max(var_278_23, arg_275_1.talkMaxDuration)

			if var_278_22 <= arg_275_1.time_ and arg_275_1.time_ < var_278_22 + var_278_32 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_22) / var_278_32

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_22 + var_278_32 and arg_275_1.time_ < var_278_22 + var_278_32 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play926021069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 926021069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play926021070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10144"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10144 == nil then
				arg_279_1.var_.actorSpriteComps10144 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps10144 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								local var_282_4 = Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor2.r, var_282_3)
								local var_282_5 = Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor2.g, var_282_3)
								local var_282_6 = Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor2.b, var_282_3)

								iter_282_1.color = Color.New(var_282_4, var_282_5, var_282_6)
							else
								local var_282_7 = Mathf.Lerp(iter_282_1.color.r, 0.5, var_282_3)

								iter_282_1.color = Color.New(var_282_7, var_282_7, var_282_7)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10144 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_282_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10144 = nil
			end

			local var_282_8 = 0
			local var_282_9 = 0.175

			if var_282_8 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_10 = arg_279_1:FormatText(StoryNameCfg[7].name)

				arg_279_1.leftNameTxt_.text = var_282_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_11 = arg_279_1:GetWordFromCfg(926021069)
				local var_282_12 = arg_279_1:FormatText(var_282_11.content)

				arg_279_1.text_.text = var_282_12

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_13 = 7
				local var_282_14 = utf8.len(var_282_12)
				local var_282_15 = var_282_13 <= 0 and var_282_9 or var_282_9 * (var_282_14 / var_282_13)

				if var_282_15 > 0 and var_282_9 < var_282_15 then
					arg_279_1.talkMaxDuration = var_282_15

					if var_282_15 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_15 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_12
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_16 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_16 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_16

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_16 and arg_279_1.time_ < var_282_8 + var_282_16 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play926021070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 926021070
		arg_283_1.duration_ = 5.93

		local var_283_0 = {
			zh = 4.233,
			ja = 5.933
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play926021071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10144"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10144 == nil then
				arg_283_1.var_.actorSpriteComps10144 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps10144 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								local var_286_4 = Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor1.r, var_286_3)
								local var_286_5 = Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor1.g, var_286_3)
								local var_286_6 = Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor1.b, var_286_3)

								iter_286_1.color = Color.New(var_286_4, var_286_5, var_286_6)
							else
								local var_286_7 = Mathf.Lerp(iter_286_1.color.r, 1, var_286_3)

								iter_286_1.color = Color.New(var_286_7, var_286_7, var_286_7)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10144 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_286_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps10144 = nil
			end

			local var_286_8 = 0
			local var_286_9 = 0.475

			if var_286_8 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_10 = arg_283_1:FormatText(StoryNameCfg[1297].name)

				arg_283_1.leftNameTxt_.text = var_286_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_11 = arg_283_1:GetWordFromCfg(926021070)
				local var_286_12 = arg_283_1:FormatText(var_286_11.content)

				arg_283_1.text_.text = var_286_12

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 19
				local var_286_14 = utf8.len(var_286_12)
				local var_286_15 = var_286_13 <= 0 and var_286_9 or var_286_9 * (var_286_14 / var_286_13)

				if var_286_15 > 0 and var_286_9 < var_286_15 then
					arg_283_1.talkMaxDuration = var_286_15

					if var_286_15 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_15 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_12
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021070", "story_v_out_926021.awb") ~= 0 then
					local var_286_16 = manager.audio:GetVoiceLength("story_v_out_926021", "926021070", "story_v_out_926021.awb") / 1000

					if var_286_16 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_16 + var_286_8
					end

					if var_286_11.prefab_name ~= "" and arg_283_1.actors_[var_286_11.prefab_name] ~= nil then
						local var_286_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_11.prefab_name].transform, "story_v_out_926021", "926021070", "story_v_out_926021.awb")

						arg_283_1:RecordAudio("926021070", var_286_17)
						arg_283_1:RecordAudio("926021070", var_286_17)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_926021", "926021070", "story_v_out_926021.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_926021", "926021070", "story_v_out_926021.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_18 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_18 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_18

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_18 and arg_283_1.time_ < var_286_8 + var_286_18 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play926021071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 926021071
		arg_287_1.duration_ = 6

		local var_287_0 = {
			zh = 6,
			ja = 5.933
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play926021072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 0.825

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_2 = arg_287_1:FormatText(StoryNameCfg[1297].name)

				arg_287_1.leftNameTxt_.text = var_290_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_3 = arg_287_1:GetWordFromCfg(926021071)
				local var_290_4 = arg_287_1:FormatText(var_290_3.content)

				arg_287_1.text_.text = var_290_4

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 33
				local var_290_6 = utf8.len(var_290_4)
				local var_290_7 = var_290_5 <= 0 and var_290_1 or var_290_1 * (var_290_6 / var_290_5)

				if var_290_7 > 0 and var_290_1 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_4
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021071", "story_v_out_926021.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021071", "story_v_out_926021.awb") / 1000

					if var_290_8 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_0
					end

					if var_290_3.prefab_name ~= "" and arg_287_1.actors_[var_290_3.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_3.prefab_name].transform, "story_v_out_926021", "926021071", "story_v_out_926021.awb")

						arg_287_1:RecordAudio("926021071", var_290_9)
						arg_287_1:RecordAudio("926021071", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_926021", "926021071", "story_v_out_926021.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_926021", "926021071", "story_v_out_926021.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_10 and arg_287_1.time_ < var_290_0 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play926021072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 926021072
		arg_291_1.duration_ = 6.9

		local var_291_0 = {
			zh = 4.7,
			ja = 6.9
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play926021073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 0.625

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[1297].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_3 = arg_291_1:GetWordFromCfg(926021072)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 25
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021072", "story_v_out_926021.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021072", "story_v_out_926021.awb") / 1000

					if var_294_8 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_0
					end

					if var_294_3.prefab_name ~= "" and arg_291_1.actors_[var_294_3.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_3.prefab_name].transform, "story_v_out_926021", "926021072", "story_v_out_926021.awb")

						arg_291_1:RecordAudio("926021072", var_294_9)
						arg_291_1:RecordAudio("926021072", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_926021", "926021072", "story_v_out_926021.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_926021", "926021072", "story_v_out_926021.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_10 and arg_291_1.time_ < var_294_0 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play926021073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 926021073
		arg_295_1.duration_ = 6.6

		local var_295_0 = {
			zh = 4.133,
			ja = 6.6
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play926021074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["128404"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps128404 == nil then
				arg_295_1.var_.actorSpriteComps128404 = var_298_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_2 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.actorSpriteComps128404 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								local var_298_4 = Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, var_298_3)
								local var_298_5 = Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, var_298_3)
								local var_298_6 = Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, var_298_3)

								iter_298_1.color = Color.New(var_298_4, var_298_5, var_298_6)
							else
								local var_298_7 = Mathf.Lerp(iter_298_1.color.r, 1, var_298_3)

								iter_298_1.color = Color.New(var_298_7, var_298_7, var_298_7)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps128404 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_298_3 then
						if arg_295_1.isInRecall_ then
							iter_298_3.color = arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_298_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps128404 = nil
			end

			local var_298_8 = arg_295_1.actors_["10144"]
			local var_298_9 = 0

			if var_298_9 < arg_295_1.time_ and arg_295_1.time_ <= var_298_9 + arg_298_0 and not isNil(var_298_8) and arg_295_1.var_.actorSpriteComps10144 == nil then
				arg_295_1.var_.actorSpriteComps10144 = var_298_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_10 = 0.2

			if var_298_9 <= arg_295_1.time_ and arg_295_1.time_ < var_298_9 + var_298_10 and not isNil(var_298_8) then
				local var_298_11 = (arg_295_1.time_ - var_298_9) / var_298_10

				if arg_295_1.var_.actorSpriteComps10144 then
					for iter_298_4, iter_298_5 in pairs(arg_295_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_298_5 then
							if arg_295_1.isInRecall_ then
								local var_298_12 = Mathf.Lerp(iter_298_5.color.r, arg_295_1.hightColor2.r, var_298_11)
								local var_298_13 = Mathf.Lerp(iter_298_5.color.g, arg_295_1.hightColor2.g, var_298_11)
								local var_298_14 = Mathf.Lerp(iter_298_5.color.b, arg_295_1.hightColor2.b, var_298_11)

								iter_298_5.color = Color.New(var_298_12, var_298_13, var_298_14)
							else
								local var_298_15 = Mathf.Lerp(iter_298_5.color.r, 0.5, var_298_11)

								iter_298_5.color = Color.New(var_298_15, var_298_15, var_298_15)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_9 + var_298_10 and arg_295_1.time_ < var_298_9 + var_298_10 + arg_298_0 and not isNil(var_298_8) and arg_295_1.var_.actorSpriteComps10144 then
				for iter_298_6, iter_298_7 in pairs(arg_295_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_298_7 then
						if arg_295_1.isInRecall_ then
							iter_298_7.color = arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_298_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps10144 = nil
			end

			local var_298_16 = arg_295_1.actors_["128404"].transform
			local var_298_17 = 0

			if var_298_17 < arg_295_1.time_ and arg_295_1.time_ <= var_298_17 + arg_298_0 then
				arg_295_1.var_.moveOldPos128404 = var_298_16.localPosition
				var_298_16.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("128404", 2)

				local var_298_18 = var_298_16.childCount

				for iter_298_8 = 0, var_298_18 - 1 do
					local var_298_19 = var_298_16:GetChild(iter_298_8)

					if var_298_19.name == "split_4" or not string.find(var_298_19.name, "split") then
						var_298_19.gameObject:SetActive(true)
					else
						var_298_19.gameObject:SetActive(false)
					end
				end
			end

			local var_298_20 = 0.001

			if var_298_17 <= arg_295_1.time_ and arg_295_1.time_ < var_298_17 + var_298_20 then
				local var_298_21 = (arg_295_1.time_ - var_298_17) / var_298_20
				local var_298_22 = Vector3.New(-428.5, -356, -362.3)

				var_298_16.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos128404, var_298_22, var_298_21)
			end

			if arg_295_1.time_ >= var_298_17 + var_298_20 and arg_295_1.time_ < var_298_17 + var_298_20 + arg_298_0 then
				var_298_16.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_298_23 = arg_295_1.actors_["10144"].transform
			local var_298_24 = 0

			if var_298_24 < arg_295_1.time_ and arg_295_1.time_ <= var_298_24 + arg_298_0 then
				arg_295_1.var_.moveOldPos10144 = var_298_23.localPosition
				var_298_23.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10144", 4)

				local var_298_25 = var_298_23.childCount

				for iter_298_9 = 0, var_298_25 - 1 do
					local var_298_26 = var_298_23:GetChild(iter_298_9)

					if var_298_26.name == "split_8" or not string.find(var_298_26.name, "split") then
						var_298_26.gameObject:SetActive(true)
					else
						var_298_26.gameObject:SetActive(false)
					end
				end
			end

			local var_298_27 = 0.001

			if var_298_24 <= arg_295_1.time_ and arg_295_1.time_ < var_298_24 + var_298_27 then
				local var_298_28 = (arg_295_1.time_ - var_298_24) / var_298_27
				local var_298_29 = Vector3.New(435.8, -381.1, -285.9)

				var_298_23.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10144, var_298_29, var_298_28)
			end

			if arg_295_1.time_ >= var_298_24 + var_298_27 and arg_295_1.time_ < var_298_24 + var_298_27 + arg_298_0 then
				var_298_23.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_298_30 = 0
			local var_298_31 = 0.425

			if var_298_30 < arg_295_1.time_ and arg_295_1.time_ <= var_298_30 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_32 = arg_295_1:FormatText(StoryNameCfg[6].name)

				arg_295_1.leftNameTxt_.text = var_298_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_33 = arg_295_1:GetWordFromCfg(926021073)
				local var_298_34 = arg_295_1:FormatText(var_298_33.content)

				arg_295_1.text_.text = var_298_34

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_35 = 17
				local var_298_36 = utf8.len(var_298_34)
				local var_298_37 = var_298_35 <= 0 and var_298_31 or var_298_31 * (var_298_36 / var_298_35)

				if var_298_37 > 0 and var_298_31 < var_298_37 then
					arg_295_1.talkMaxDuration = var_298_37

					if var_298_37 + var_298_30 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_37 + var_298_30
					end
				end

				arg_295_1.text_.text = var_298_34
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021073", "story_v_out_926021.awb") ~= 0 then
					local var_298_38 = manager.audio:GetVoiceLength("story_v_out_926021", "926021073", "story_v_out_926021.awb") / 1000

					if var_298_38 + var_298_30 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_38 + var_298_30
					end

					if var_298_33.prefab_name ~= "" and arg_295_1.actors_[var_298_33.prefab_name] ~= nil then
						local var_298_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_33.prefab_name].transform, "story_v_out_926021", "926021073", "story_v_out_926021.awb")

						arg_295_1:RecordAudio("926021073", var_298_39)
						arg_295_1:RecordAudio("926021073", var_298_39)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_926021", "926021073", "story_v_out_926021.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_926021", "926021073", "story_v_out_926021.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_40 = math.max(var_298_31, arg_295_1.talkMaxDuration)

			if var_298_30 <= arg_295_1.time_ and arg_295_1.time_ < var_298_30 + var_298_40 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_30) / var_298_40

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_30 + var_298_40 and arg_295_1.time_ < var_298_30 + var_298_40 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play926021074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 926021074
		arg_299_1.duration_ = 14.13

		local var_299_0 = {
			zh = 8.4,
			ja = 14.133
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play926021075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["10144"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps10144 == nil then
				arg_299_1.var_.actorSpriteComps10144 = var_302_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_2 = 0.2

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.actorSpriteComps10144 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_302_1 then
							if arg_299_1.isInRecall_ then
								local var_302_4 = Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor1.r, var_302_3)
								local var_302_5 = Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor1.g, var_302_3)
								local var_302_6 = Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor1.b, var_302_3)

								iter_302_1.color = Color.New(var_302_4, var_302_5, var_302_6)
							else
								local var_302_7 = Mathf.Lerp(iter_302_1.color.r, 1, var_302_3)

								iter_302_1.color = Color.New(var_302_7, var_302_7, var_302_7)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps10144 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_302_3 then
						if arg_299_1.isInRecall_ then
							iter_302_3.color = arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_302_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps10144 = nil
			end

			local var_302_8 = arg_299_1.actors_["128404"]
			local var_302_9 = 0

			if var_302_9 < arg_299_1.time_ and arg_299_1.time_ <= var_302_9 + arg_302_0 and not isNil(var_302_8) and arg_299_1.var_.actorSpriteComps128404 == nil then
				arg_299_1.var_.actorSpriteComps128404 = var_302_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_10 = 0.2

			if var_302_9 <= arg_299_1.time_ and arg_299_1.time_ < var_302_9 + var_302_10 and not isNil(var_302_8) then
				local var_302_11 = (arg_299_1.time_ - var_302_9) / var_302_10

				if arg_299_1.var_.actorSpriteComps128404 then
					for iter_302_4, iter_302_5 in pairs(arg_299_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_302_5 then
							if arg_299_1.isInRecall_ then
								local var_302_12 = Mathf.Lerp(iter_302_5.color.r, arg_299_1.hightColor2.r, var_302_11)
								local var_302_13 = Mathf.Lerp(iter_302_5.color.g, arg_299_1.hightColor2.g, var_302_11)
								local var_302_14 = Mathf.Lerp(iter_302_5.color.b, arg_299_1.hightColor2.b, var_302_11)

								iter_302_5.color = Color.New(var_302_12, var_302_13, var_302_14)
							else
								local var_302_15 = Mathf.Lerp(iter_302_5.color.r, 0.5, var_302_11)

								iter_302_5.color = Color.New(var_302_15, var_302_15, var_302_15)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_9 + var_302_10 and arg_299_1.time_ < var_302_9 + var_302_10 + arg_302_0 and not isNil(var_302_8) and arg_299_1.var_.actorSpriteComps128404 then
				for iter_302_6, iter_302_7 in pairs(arg_299_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_302_7 then
						if arg_299_1.isInRecall_ then
							iter_302_7.color = arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_302_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps128404 = nil
			end

			local var_302_16 = arg_299_1.actors_["10144"].transform
			local var_302_17 = 0

			if var_302_17 < arg_299_1.time_ and arg_299_1.time_ <= var_302_17 + arg_302_0 then
				arg_299_1.var_.moveOldPos10144 = var_302_16.localPosition
				var_302_16.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10144", 4)

				local var_302_18 = var_302_16.childCount

				for iter_302_8 = 0, var_302_18 - 1 do
					local var_302_19 = var_302_16:GetChild(iter_302_8)

					if var_302_19.name == "split_10" or not string.find(var_302_19.name, "split") then
						var_302_19.gameObject:SetActive(true)
					else
						var_302_19.gameObject:SetActive(false)
					end
				end
			end

			local var_302_20 = 0.001

			if var_302_17 <= arg_299_1.time_ and arg_299_1.time_ < var_302_17 + var_302_20 then
				local var_302_21 = (arg_299_1.time_ - var_302_17) / var_302_20
				local var_302_22 = Vector3.New(435.8, -381.1, -285.9)

				var_302_16.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10144, var_302_22, var_302_21)
			end

			if arg_299_1.time_ >= var_302_17 + var_302_20 and arg_299_1.time_ < var_302_17 + var_302_20 + arg_302_0 then
				var_302_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_302_23 = 0
			local var_302_24 = 1.125

			if var_302_23 < arg_299_1.time_ and arg_299_1.time_ <= var_302_23 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_25 = arg_299_1:FormatText(StoryNameCfg[1297].name)

				arg_299_1.leftNameTxt_.text = var_302_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_26 = arg_299_1:GetWordFromCfg(926021074)
				local var_302_27 = arg_299_1:FormatText(var_302_26.content)

				arg_299_1.text_.text = var_302_27

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_28 = 45
				local var_302_29 = utf8.len(var_302_27)
				local var_302_30 = var_302_28 <= 0 and var_302_24 or var_302_24 * (var_302_29 / var_302_28)

				if var_302_30 > 0 and var_302_24 < var_302_30 then
					arg_299_1.talkMaxDuration = var_302_30

					if var_302_30 + var_302_23 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_30 + var_302_23
					end
				end

				arg_299_1.text_.text = var_302_27
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021074", "story_v_out_926021.awb") ~= 0 then
					local var_302_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021074", "story_v_out_926021.awb") / 1000

					if var_302_31 + var_302_23 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_31 + var_302_23
					end

					if var_302_26.prefab_name ~= "" and arg_299_1.actors_[var_302_26.prefab_name] ~= nil then
						local var_302_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_26.prefab_name].transform, "story_v_out_926021", "926021074", "story_v_out_926021.awb")

						arg_299_1:RecordAudio("926021074", var_302_32)
						arg_299_1:RecordAudio("926021074", var_302_32)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_926021", "926021074", "story_v_out_926021.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_926021", "926021074", "story_v_out_926021.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_33 = math.max(var_302_24, arg_299_1.talkMaxDuration)

			if var_302_23 <= arg_299_1.time_ and arg_299_1.time_ < var_302_23 + var_302_33 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_23) / var_302_33

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_23 + var_302_33 and arg_299_1.time_ < var_302_23 + var_302_33 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play926021075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 926021075
		arg_303_1.duration_ = 12.3

		local var_303_0 = {
			zh = 8.3,
			ja = 12.3
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play926021076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.75

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[1297].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(926021075)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 46
				local var_306_6 = utf8.len(var_306_4)
				local var_306_7 = var_306_5 <= 0 and var_306_1 or var_306_1 * (var_306_6 / var_306_5)

				if var_306_7 > 0 and var_306_1 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021075", "story_v_out_926021.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021075", "story_v_out_926021.awb") / 1000

					if var_306_8 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_0
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_926021", "926021075", "story_v_out_926021.awb")

						arg_303_1:RecordAudio("926021075", var_306_9)
						arg_303_1:RecordAudio("926021075", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_926021", "926021075", "story_v_out_926021.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_926021", "926021075", "story_v_out_926021.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_10 and arg_303_1.time_ < var_306_0 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play926021076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 926021076
		arg_307_1.duration_ = 6.1

		local var_307_0 = {
			zh = 4.7,
			ja = 6.1
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play926021077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["10144"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos10144 = var_310_0.localPosition
				var_310_0.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("10144", 4)

				local var_310_2 = var_310_0.childCount

				for iter_310_0 = 0, var_310_2 - 1 do
					local var_310_3 = var_310_0:GetChild(iter_310_0)

					if var_310_3.name == "split_8" or not string.find(var_310_3.name, "split") then
						var_310_3.gameObject:SetActive(true)
					else
						var_310_3.gameObject:SetActive(false)
					end
				end
			end

			local var_310_4 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_4 then
				local var_310_5 = (arg_307_1.time_ - var_310_1) / var_310_4
				local var_310_6 = Vector3.New(435.8, -381.1, -285.9)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10144, var_310_6, var_310_5)
			end

			if arg_307_1.time_ >= var_310_1 + var_310_4 and arg_307_1.time_ < var_310_1 + var_310_4 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_310_7 = 0
			local var_310_8 = 0.6

			if var_310_7 < arg_307_1.time_ and arg_307_1.time_ <= var_310_7 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_9 = arg_307_1:FormatText(StoryNameCfg[1297].name)

				arg_307_1.leftNameTxt_.text = var_310_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_10 = arg_307_1:GetWordFromCfg(926021076)
				local var_310_11 = arg_307_1:FormatText(var_310_10.content)

				arg_307_1.text_.text = var_310_11

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_12 = 24
				local var_310_13 = utf8.len(var_310_11)
				local var_310_14 = var_310_12 <= 0 and var_310_8 or var_310_8 * (var_310_13 / var_310_12)

				if var_310_14 > 0 and var_310_8 < var_310_14 then
					arg_307_1.talkMaxDuration = var_310_14

					if var_310_14 + var_310_7 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_14 + var_310_7
					end
				end

				arg_307_1.text_.text = var_310_11
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021076", "story_v_out_926021.awb") ~= 0 then
					local var_310_15 = manager.audio:GetVoiceLength("story_v_out_926021", "926021076", "story_v_out_926021.awb") / 1000

					if var_310_15 + var_310_7 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_15 + var_310_7
					end

					if var_310_10.prefab_name ~= "" and arg_307_1.actors_[var_310_10.prefab_name] ~= nil then
						local var_310_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_10.prefab_name].transform, "story_v_out_926021", "926021076", "story_v_out_926021.awb")

						arg_307_1:RecordAudio("926021076", var_310_16)
						arg_307_1:RecordAudio("926021076", var_310_16)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_926021", "926021076", "story_v_out_926021.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_926021", "926021076", "story_v_out_926021.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_17 = math.max(var_310_8, arg_307_1.talkMaxDuration)

			if var_310_7 <= arg_307_1.time_ and arg_307_1.time_ < var_310_7 + var_310_17 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_7) / var_310_17

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_7 + var_310_17 and arg_307_1.time_ < var_310_7 + var_310_17 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play926021077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 926021077
		arg_311_1.duration_ = 9.13

		local var_311_0 = {
			zh = 5.766,
			ja = 9.133
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play926021078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["128404"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps128404 == nil then
				arg_311_1.var_.actorSpriteComps128404 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps128404 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								local var_314_4 = Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor1.r, var_314_3)
								local var_314_5 = Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor1.g, var_314_3)
								local var_314_6 = Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor1.b, var_314_3)

								iter_314_1.color = Color.New(var_314_4, var_314_5, var_314_6)
							else
								local var_314_7 = Mathf.Lerp(iter_314_1.color.r, 1, var_314_3)

								iter_314_1.color = Color.New(var_314_7, var_314_7, var_314_7)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps128404 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_314_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps128404 = nil
			end

			local var_314_8 = arg_311_1.actors_["10144"]
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps10144 == nil then
				arg_311_1.var_.actorSpriteComps10144 = var_314_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_10 = 0.2

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_10 and not isNil(var_314_8) then
				local var_314_11 = (arg_311_1.time_ - var_314_9) / var_314_10

				if arg_311_1.var_.actorSpriteComps10144 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_314_5 then
							if arg_311_1.isInRecall_ then
								local var_314_12 = Mathf.Lerp(iter_314_5.color.r, arg_311_1.hightColor2.r, var_314_11)
								local var_314_13 = Mathf.Lerp(iter_314_5.color.g, arg_311_1.hightColor2.g, var_314_11)
								local var_314_14 = Mathf.Lerp(iter_314_5.color.b, arg_311_1.hightColor2.b, var_314_11)

								iter_314_5.color = Color.New(var_314_12, var_314_13, var_314_14)
							else
								local var_314_15 = Mathf.Lerp(iter_314_5.color.r, 0.5, var_314_11)

								iter_314_5.color = Color.New(var_314_15, var_314_15, var_314_15)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_9 + var_314_10 and arg_311_1.time_ < var_314_9 + var_314_10 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps10144 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_314_7 then
						if arg_311_1.isInRecall_ then
							iter_314_7.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps10144 = nil
			end

			local var_314_16 = arg_311_1.actors_["128404"].transform
			local var_314_17 = 0

			if var_314_17 < arg_311_1.time_ and arg_311_1.time_ <= var_314_17 + arg_314_0 then
				arg_311_1.var_.moveOldPos128404 = var_314_16.localPosition
				var_314_16.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("128404", 2)

				local var_314_18 = var_314_16.childCount

				for iter_314_8 = 0, var_314_18 - 1 do
					local var_314_19 = var_314_16:GetChild(iter_314_8)

					if var_314_19.name == "split_6" or not string.find(var_314_19.name, "split") then
						var_314_19.gameObject:SetActive(true)
					else
						var_314_19.gameObject:SetActive(false)
					end
				end
			end

			local var_314_20 = 0.001

			if var_314_17 <= arg_311_1.time_ and arg_311_1.time_ < var_314_17 + var_314_20 then
				local var_314_21 = (arg_311_1.time_ - var_314_17) / var_314_20
				local var_314_22 = Vector3.New(-428.5, -356, -362.3)

				var_314_16.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos128404, var_314_22, var_314_21)
			end

			if arg_311_1.time_ >= var_314_17 + var_314_20 and arg_311_1.time_ < var_314_17 + var_314_20 + arg_314_0 then
				var_314_16.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_314_23 = 0
			local var_314_24 = 0.825

			if var_314_23 < arg_311_1.time_ and arg_311_1.time_ <= var_314_23 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_25 = arg_311_1:FormatText(StoryNameCfg[6].name)

				arg_311_1.leftNameTxt_.text = var_314_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_26 = arg_311_1:GetWordFromCfg(926021077)
				local var_314_27 = arg_311_1:FormatText(var_314_26.content)

				arg_311_1.text_.text = var_314_27

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_28 = 33
				local var_314_29 = utf8.len(var_314_27)
				local var_314_30 = var_314_28 <= 0 and var_314_24 or var_314_24 * (var_314_29 / var_314_28)

				if var_314_30 > 0 and var_314_24 < var_314_30 then
					arg_311_1.talkMaxDuration = var_314_30

					if var_314_30 + var_314_23 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_30 + var_314_23
					end
				end

				arg_311_1.text_.text = var_314_27
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021077", "story_v_out_926021.awb") ~= 0 then
					local var_314_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021077", "story_v_out_926021.awb") / 1000

					if var_314_31 + var_314_23 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_31 + var_314_23
					end

					if var_314_26.prefab_name ~= "" and arg_311_1.actors_[var_314_26.prefab_name] ~= nil then
						local var_314_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_26.prefab_name].transform, "story_v_out_926021", "926021077", "story_v_out_926021.awb")

						arg_311_1:RecordAudio("926021077", var_314_32)
						arg_311_1:RecordAudio("926021077", var_314_32)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_926021", "926021077", "story_v_out_926021.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_926021", "926021077", "story_v_out_926021.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_33 = math.max(var_314_24, arg_311_1.talkMaxDuration)

			if var_314_23 <= arg_311_1.time_ and arg_311_1.time_ < var_314_23 + var_314_33 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_23) / var_314_33

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_23 + var_314_33 and arg_311_1.time_ < var_314_23 + var_314_33 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play926021078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 926021078
		arg_315_1.duration_ = 6.77

		local var_315_0 = {
			zh = 5.6,
			ja = 6.766
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play926021079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["104701"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps104701 == nil then
				arg_315_1.var_.actorSpriteComps104701 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps104701 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								local var_318_4 = Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, var_318_3)
								local var_318_5 = Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, var_318_3)
								local var_318_6 = Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, var_318_3)

								iter_318_1.color = Color.New(var_318_4, var_318_5, var_318_6)
							else
								local var_318_7 = Mathf.Lerp(iter_318_1.color.r, 1, var_318_3)

								iter_318_1.color = Color.New(var_318_7, var_318_7, var_318_7)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps104701 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps104701 = nil
			end

			local var_318_8 = arg_315_1.actors_["128404"]
			local var_318_9 = 0

			if var_318_9 < arg_315_1.time_ and arg_315_1.time_ <= var_318_9 + arg_318_0 and not isNil(var_318_8) and arg_315_1.var_.actorSpriteComps128404 == nil then
				arg_315_1.var_.actorSpriteComps128404 = var_318_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_10 = 0.2

			if var_318_9 <= arg_315_1.time_ and arg_315_1.time_ < var_318_9 + var_318_10 and not isNil(var_318_8) then
				local var_318_11 = (arg_315_1.time_ - var_318_9) / var_318_10

				if arg_315_1.var_.actorSpriteComps128404 then
					for iter_318_4, iter_318_5 in pairs(arg_315_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_318_5 then
							if arg_315_1.isInRecall_ then
								local var_318_12 = Mathf.Lerp(iter_318_5.color.r, arg_315_1.hightColor2.r, var_318_11)
								local var_318_13 = Mathf.Lerp(iter_318_5.color.g, arg_315_1.hightColor2.g, var_318_11)
								local var_318_14 = Mathf.Lerp(iter_318_5.color.b, arg_315_1.hightColor2.b, var_318_11)

								iter_318_5.color = Color.New(var_318_12, var_318_13, var_318_14)
							else
								local var_318_15 = Mathf.Lerp(iter_318_5.color.r, 0.5, var_318_11)

								iter_318_5.color = Color.New(var_318_15, var_318_15, var_318_15)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_9 + var_318_10 and arg_315_1.time_ < var_318_9 + var_318_10 + arg_318_0 and not isNil(var_318_8) and arg_315_1.var_.actorSpriteComps128404 then
				for iter_318_6, iter_318_7 in pairs(arg_315_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_318_7 then
						if arg_315_1.isInRecall_ then
							iter_318_7.color = arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_318_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps128404 = nil
			end

			local var_318_16 = 0
			local var_318_17 = 0.65

			if var_318_16 < arg_315_1.time_ and arg_315_1.time_ <= var_318_16 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_18 = arg_315_1:FormatText(StoryNameCfg[1296].name)

				arg_315_1.leftNameTxt_.text = var_318_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_19 = arg_315_1:GetWordFromCfg(926021078)
				local var_318_20 = arg_315_1:FormatText(var_318_19.content)

				arg_315_1.text_.text = var_318_20

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_21 = 26
				local var_318_22 = utf8.len(var_318_20)
				local var_318_23 = var_318_21 <= 0 and var_318_17 or var_318_17 * (var_318_22 / var_318_21)

				if var_318_23 > 0 and var_318_17 < var_318_23 then
					arg_315_1.talkMaxDuration = var_318_23

					if var_318_23 + var_318_16 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_23 + var_318_16
					end
				end

				arg_315_1.text_.text = var_318_20
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021078", "story_v_out_926021.awb") ~= 0 then
					local var_318_24 = manager.audio:GetVoiceLength("story_v_out_926021", "926021078", "story_v_out_926021.awb") / 1000

					if var_318_24 + var_318_16 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_24 + var_318_16
					end

					if var_318_19.prefab_name ~= "" and arg_315_1.actors_[var_318_19.prefab_name] ~= nil then
						local var_318_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_19.prefab_name].transform, "story_v_out_926021", "926021078", "story_v_out_926021.awb")

						arg_315_1:RecordAudio("926021078", var_318_25)
						arg_315_1:RecordAudio("926021078", var_318_25)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_926021", "926021078", "story_v_out_926021.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_926021", "926021078", "story_v_out_926021.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_26 = math.max(var_318_17, arg_315_1.talkMaxDuration)

			if var_318_16 <= arg_315_1.time_ and arg_315_1.time_ < var_318_16 + var_318_26 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_16) / var_318_26

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_16 + var_318_26 and arg_315_1.time_ < var_318_16 + var_318_26 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play926021079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 926021079
		arg_319_1.duration_ = 2.2

		local var_319_0 = {
			zh = 1.6,
			ja = 2.2
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play926021080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["128404"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps128404 == nil then
				arg_319_1.var_.actorSpriteComps128404 = var_322_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_2 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.actorSpriteComps128404 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								local var_322_4 = Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor1.r, var_322_3)
								local var_322_5 = Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor1.g, var_322_3)
								local var_322_6 = Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor1.b, var_322_3)

								iter_322_1.color = Color.New(var_322_4, var_322_5, var_322_6)
							else
								local var_322_7 = Mathf.Lerp(iter_322_1.color.r, 1, var_322_3)

								iter_322_1.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps128404 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_322_3 then
						if arg_319_1.isInRecall_ then
							iter_322_3.color = arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_322_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps128404 = nil
			end

			local var_322_8 = arg_319_1.actors_["104701"]
			local var_322_9 = 0

			if var_322_9 < arg_319_1.time_ and arg_319_1.time_ <= var_322_9 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps104701 == nil then
				arg_319_1.var_.actorSpriteComps104701 = var_322_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_10 = 0.2

			if var_322_9 <= arg_319_1.time_ and arg_319_1.time_ < var_322_9 + var_322_10 and not isNil(var_322_8) then
				local var_322_11 = (arg_319_1.time_ - var_322_9) / var_322_10

				if arg_319_1.var_.actorSpriteComps104701 then
					for iter_322_4, iter_322_5 in pairs(arg_319_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_322_5 then
							if arg_319_1.isInRecall_ then
								local var_322_12 = Mathf.Lerp(iter_322_5.color.r, arg_319_1.hightColor2.r, var_322_11)
								local var_322_13 = Mathf.Lerp(iter_322_5.color.g, arg_319_1.hightColor2.g, var_322_11)
								local var_322_14 = Mathf.Lerp(iter_322_5.color.b, arg_319_1.hightColor2.b, var_322_11)

								iter_322_5.color = Color.New(var_322_12, var_322_13, var_322_14)
							else
								local var_322_15 = Mathf.Lerp(iter_322_5.color.r, 0.5, var_322_11)

								iter_322_5.color = Color.New(var_322_15, var_322_15, var_322_15)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_9 + var_322_10 and arg_319_1.time_ < var_322_9 + var_322_10 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps104701 then
				for iter_322_6, iter_322_7 in pairs(arg_319_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_322_7 then
						if arg_319_1.isInRecall_ then
							iter_322_7.color = arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_322_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps104701 = nil
			end

			local var_322_16 = arg_319_1.actors_["128404"].transform
			local var_322_17 = 0

			if var_322_17 < arg_319_1.time_ and arg_319_1.time_ <= var_322_17 + arg_322_0 then
				arg_319_1.var_.moveOldPos128404 = var_322_16.localPosition
				var_322_16.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("128404", 2)

				local var_322_18 = var_322_16.childCount

				for iter_322_8 = 0, var_322_18 - 1 do
					local var_322_19 = var_322_16:GetChild(iter_322_8)

					if var_322_19.name == "split_4" or not string.find(var_322_19.name, "split") then
						var_322_19.gameObject:SetActive(true)
					else
						var_322_19.gameObject:SetActive(false)
					end
				end
			end

			local var_322_20 = 0.001

			if var_322_17 <= arg_319_1.time_ and arg_319_1.time_ < var_322_17 + var_322_20 then
				local var_322_21 = (arg_319_1.time_ - var_322_17) / var_322_20
				local var_322_22 = Vector3.New(-428.5, -356, -362.3)

				var_322_16.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos128404, var_322_22, var_322_21)
			end

			if arg_319_1.time_ >= var_322_17 + var_322_20 and arg_319_1.time_ < var_322_17 + var_322_20 + arg_322_0 then
				var_322_16.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_322_23 = 0
			local var_322_24 = 0.1

			if var_322_23 < arg_319_1.time_ and arg_319_1.time_ <= var_322_23 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_25 = arg_319_1:FormatText(StoryNameCfg[6].name)

				arg_319_1.leftNameTxt_.text = var_322_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_26 = arg_319_1:GetWordFromCfg(926021079)
				local var_322_27 = arg_319_1:FormatText(var_322_26.content)

				arg_319_1.text_.text = var_322_27

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_28 = 4
				local var_322_29 = utf8.len(var_322_27)
				local var_322_30 = var_322_28 <= 0 and var_322_24 or var_322_24 * (var_322_29 / var_322_28)

				if var_322_30 > 0 and var_322_24 < var_322_30 then
					arg_319_1.talkMaxDuration = var_322_30

					if var_322_30 + var_322_23 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_30 + var_322_23
					end
				end

				arg_319_1.text_.text = var_322_27
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021079", "story_v_out_926021.awb") ~= 0 then
					local var_322_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021079", "story_v_out_926021.awb") / 1000

					if var_322_31 + var_322_23 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_31 + var_322_23
					end

					if var_322_26.prefab_name ~= "" and arg_319_1.actors_[var_322_26.prefab_name] ~= nil then
						local var_322_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_26.prefab_name].transform, "story_v_out_926021", "926021079", "story_v_out_926021.awb")

						arg_319_1:RecordAudio("926021079", var_322_32)
						arg_319_1:RecordAudio("926021079", var_322_32)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_926021", "926021079", "story_v_out_926021.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_926021", "926021079", "story_v_out_926021.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_33 = math.max(var_322_24, arg_319_1.talkMaxDuration)

			if var_322_23 <= arg_319_1.time_ and arg_319_1.time_ < var_322_23 + var_322_33 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_23) / var_322_33

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_23 + var_322_33 and arg_319_1.time_ < var_322_23 + var_322_33 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play926021080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 926021080
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play926021081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["128404"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps128404 == nil then
				arg_323_1.var_.actorSpriteComps128404 = var_326_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.actorSpriteComps128404 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								local var_326_4 = Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor2.r, var_326_3)
								local var_326_5 = Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor2.g, var_326_3)
								local var_326_6 = Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor2.b, var_326_3)

								iter_326_1.color = Color.New(var_326_4, var_326_5, var_326_6)
							else
								local var_326_7 = Mathf.Lerp(iter_326_1.color.r, 0.5, var_326_3)

								iter_326_1.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps128404 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_326_3 then
						if arg_323_1.isInRecall_ then
							iter_326_3.color = arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_326_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps128404 = nil
			end

			local var_326_8 = 0
			local var_326_9 = 0.3

			if var_326_8 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_10 = arg_323_1:FormatText(StoryNameCfg[7].name)

				arg_323_1.leftNameTxt_.text = var_326_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_11 = arg_323_1:GetWordFromCfg(926021080)
				local var_326_12 = arg_323_1:FormatText(var_326_11.content)

				arg_323_1.text_.text = var_326_12

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 12
				local var_326_14 = utf8.len(var_326_12)
				local var_326_15 = var_326_13 <= 0 and var_326_9 or var_326_9 * (var_326_14 / var_326_13)

				if var_326_15 > 0 and var_326_9 < var_326_15 then
					arg_323_1.talkMaxDuration = var_326_15

					if var_326_15 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_15 + var_326_8
					end
				end

				arg_323_1.text_.text = var_326_12
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_16 = math.max(var_326_9, arg_323_1.talkMaxDuration)

			if var_326_8 <= arg_323_1.time_ and arg_323_1.time_ < var_326_8 + var_326_16 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_8) / var_326_16

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_8 + var_326_16 and arg_323_1.time_ < var_326_8 + var_326_16 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play926021081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 926021081
		arg_327_1.duration_ = 5.6

		local var_327_0 = {
			zh = 5.3,
			ja = 5.6
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play926021082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10144"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10144 == nil then
				arg_327_1.var_.actorSpriteComps10144 = var_330_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_2 = 0.2

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.actorSpriteComps10144 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								local var_330_4 = Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor1.r, var_330_3)
								local var_330_5 = Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor1.g, var_330_3)
								local var_330_6 = Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor1.b, var_330_3)

								iter_330_1.color = Color.New(var_330_4, var_330_5, var_330_6)
							else
								local var_330_7 = Mathf.Lerp(iter_330_1.color.r, 1, var_330_3)

								iter_330_1.color = Color.New(var_330_7, var_330_7, var_330_7)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10144 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_330_3 then
						if arg_327_1.isInRecall_ then
							iter_330_3.color = arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_330_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps10144 = nil
			end

			local var_330_8 = 0
			local var_330_9 = 0.7

			if var_330_8 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_10 = arg_327_1:FormatText(StoryNameCfg[1297].name)

				arg_327_1.leftNameTxt_.text = var_330_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_11 = arg_327_1:GetWordFromCfg(926021081)
				local var_330_12 = arg_327_1:FormatText(var_330_11.content)

				arg_327_1.text_.text = var_330_12

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 27
				local var_330_14 = utf8.len(var_330_12)
				local var_330_15 = var_330_13 <= 0 and var_330_9 or var_330_9 * (var_330_14 / var_330_13)

				if var_330_15 > 0 and var_330_9 < var_330_15 then
					arg_327_1.talkMaxDuration = var_330_15

					if var_330_15 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_15 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_12
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021081", "story_v_out_926021.awb") ~= 0 then
					local var_330_16 = manager.audio:GetVoiceLength("story_v_out_926021", "926021081", "story_v_out_926021.awb") / 1000

					if var_330_16 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_16 + var_330_8
					end

					if var_330_11.prefab_name ~= "" and arg_327_1.actors_[var_330_11.prefab_name] ~= nil then
						local var_330_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_11.prefab_name].transform, "story_v_out_926021", "926021081", "story_v_out_926021.awb")

						arg_327_1:RecordAudio("926021081", var_330_17)
						arg_327_1:RecordAudio("926021081", var_330_17)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_926021", "926021081", "story_v_out_926021.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_926021", "926021081", "story_v_out_926021.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_18 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_18 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_8) / var_330_18

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_8 + var_330_18 and arg_327_1.time_ < var_330_8 + var_330_18 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play926021082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 926021082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play926021083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["10144"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps10144 == nil then
				arg_331_1.var_.actorSpriteComps10144 = var_334_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_2 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.actorSpriteComps10144 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								local var_334_4 = Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor2.r, var_334_3)
								local var_334_5 = Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor2.g, var_334_3)
								local var_334_6 = Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor2.b, var_334_3)

								iter_334_1.color = Color.New(var_334_4, var_334_5, var_334_6)
							else
								local var_334_7 = Mathf.Lerp(iter_334_1.color.r, 0.5, var_334_3)

								iter_334_1.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps10144 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_334_3 then
						if arg_331_1.isInRecall_ then
							iter_334_3.color = arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_334_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10144 = nil
			end

			local var_334_8 = arg_331_1.actors_["128404"].transform
			local var_334_9 = 0

			if var_334_9 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 then
				arg_331_1.var_.moveOldPos128404 = var_334_8.localPosition
				var_334_8.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("128404", 7)

				local var_334_10 = var_334_8.childCount

				for iter_334_4 = 0, var_334_10 - 1 do
					local var_334_11 = var_334_8:GetChild(iter_334_4)

					if var_334_11.name == "" or not string.find(var_334_11.name, "split") then
						var_334_11.gameObject:SetActive(true)
					else
						var_334_11.gameObject:SetActive(false)
					end
				end
			end

			local var_334_12 = 0.001

			if var_334_9 <= arg_331_1.time_ and arg_331_1.time_ < var_334_9 + var_334_12 then
				local var_334_13 = (arg_331_1.time_ - var_334_9) / var_334_12
				local var_334_14 = Vector3.New(0, -2000, 0)

				var_334_8.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos128404, var_334_14, var_334_13)
			end

			if arg_331_1.time_ >= var_334_9 + var_334_12 and arg_331_1.time_ < var_334_9 + var_334_12 + arg_334_0 then
				var_334_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_334_15 = arg_331_1.actors_["10144"].transform
			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 then
				arg_331_1.var_.moveOldPos10144 = var_334_15.localPosition
				var_334_15.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10144", 7)

				local var_334_17 = var_334_15.childCount

				for iter_334_5 = 0, var_334_17 - 1 do
					local var_334_18 = var_334_15:GetChild(iter_334_5)

					if var_334_18.name == "" or not string.find(var_334_18.name, "split") then
						var_334_18.gameObject:SetActive(true)
					else
						var_334_18.gameObject:SetActive(false)
					end
				end
			end

			local var_334_19 = 0.001

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_19 then
				local var_334_20 = (arg_331_1.time_ - var_334_16) / var_334_19
				local var_334_21 = Vector3.New(0, -2000, 0)

				var_334_15.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10144, var_334_21, var_334_20)
			end

			if arg_331_1.time_ >= var_334_16 + var_334_19 and arg_331_1.time_ < var_334_16 + var_334_19 + arg_334_0 then
				var_334_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_334_22 = 0
			local var_334_23 = 0.9

			if var_334_22 < arg_331_1.time_ and arg_331_1.time_ <= var_334_22 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_24 = arg_331_1:GetWordFromCfg(926021082)
				local var_334_25 = arg_331_1:FormatText(var_334_24.content)

				arg_331_1.text_.text = var_334_25

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_26 = 43
				local var_334_27 = utf8.len(var_334_25)
				local var_334_28 = var_334_26 <= 0 and var_334_23 or var_334_23 * (var_334_27 / var_334_26)

				if var_334_28 > 0 and var_334_23 < var_334_28 then
					arg_331_1.talkMaxDuration = var_334_28

					if var_334_28 + var_334_22 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_28 + var_334_22
					end
				end

				arg_331_1.text_.text = var_334_25
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_29 = math.max(var_334_23, arg_331_1.talkMaxDuration)

			if var_334_22 <= arg_331_1.time_ and arg_331_1.time_ < var_334_22 + var_334_29 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_22) / var_334_29

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_22 + var_334_29 and arg_331_1.time_ < var_334_22 + var_334_29 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play926021083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 926021083
		arg_335_1.duration_ = 3

		local var_335_0 = {
			zh = 2.366,
			ja = 3
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play926021084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["10144"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps10144 == nil then
				arg_335_1.var_.actorSpriteComps10144 = var_338_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_2 = 0.2

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.actorSpriteComps10144 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								local var_338_4 = Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor1.r, var_338_3)
								local var_338_5 = Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor1.g, var_338_3)
								local var_338_6 = Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor1.b, var_338_3)

								iter_338_1.color = Color.New(var_338_4, var_338_5, var_338_6)
							else
								local var_338_7 = Mathf.Lerp(iter_338_1.color.r, 1, var_338_3)

								iter_338_1.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps10144 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_338_3 then
						if arg_335_1.isInRecall_ then
							iter_338_3.color = arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_338_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps10144 = nil
			end

			local var_338_8 = arg_335_1.actors_["10144"].transform
			local var_338_9 = 0

			if var_338_9 < arg_335_1.time_ and arg_335_1.time_ <= var_338_9 + arg_338_0 then
				arg_335_1.var_.moveOldPos10144 = var_338_8.localPosition
				var_338_8.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10144", 3)

				local var_338_10 = var_338_8.childCount

				for iter_338_4 = 0, var_338_10 - 1 do
					local var_338_11 = var_338_8:GetChild(iter_338_4)

					if var_338_11.name == "" or not string.find(var_338_11.name, "split") then
						var_338_11.gameObject:SetActive(true)
					else
						var_338_11.gameObject:SetActive(false)
					end
				end
			end

			local var_338_12 = 0.001

			if var_338_9 <= arg_335_1.time_ and arg_335_1.time_ < var_338_9 + var_338_12 then
				local var_338_13 = (arg_335_1.time_ - var_338_9) / var_338_12
				local var_338_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_338_8.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10144, var_338_14, var_338_13)
			end

			if arg_335_1.time_ >= var_338_9 + var_338_12 and arg_335_1.time_ < var_338_9 + var_338_12 + arg_338_0 then
				var_338_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_338_15 = 0
			local var_338_16 = 0.275

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_17 = arg_335_1:FormatText(StoryNameCfg[1297].name)

				arg_335_1.leftNameTxt_.text = var_338_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_18 = arg_335_1:GetWordFromCfg(926021083)
				local var_338_19 = arg_335_1:FormatText(var_338_18.content)

				arg_335_1.text_.text = var_338_19

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_20 = 11
				local var_338_21 = utf8.len(var_338_19)
				local var_338_22 = var_338_20 <= 0 and var_338_16 or var_338_16 * (var_338_21 / var_338_20)

				if var_338_22 > 0 and var_338_16 < var_338_22 then
					arg_335_1.talkMaxDuration = var_338_22

					if var_338_22 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_22 + var_338_15
					end
				end

				arg_335_1.text_.text = var_338_19
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021083", "story_v_out_926021.awb") ~= 0 then
					local var_338_23 = manager.audio:GetVoiceLength("story_v_out_926021", "926021083", "story_v_out_926021.awb") / 1000

					if var_338_23 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_23 + var_338_15
					end

					if var_338_18.prefab_name ~= "" and arg_335_1.actors_[var_338_18.prefab_name] ~= nil then
						local var_338_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_18.prefab_name].transform, "story_v_out_926021", "926021083", "story_v_out_926021.awb")

						arg_335_1:RecordAudio("926021083", var_338_24)
						arg_335_1:RecordAudio("926021083", var_338_24)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_926021", "926021083", "story_v_out_926021.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_926021", "926021083", "story_v_out_926021.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_25 = math.max(var_338_16, arg_335_1.talkMaxDuration)

			if var_338_15 <= arg_335_1.time_ and arg_335_1.time_ < var_338_15 + var_338_25 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_15) / var_338_25

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_15 + var_338_25 and arg_335_1.time_ < var_338_15 + var_338_25 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play926021084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 926021084
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play926021085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["10144"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps10144 == nil then
				arg_339_1.var_.actorSpriteComps10144 = var_342_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_2 = 0.2

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.actorSpriteComps10144 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								local var_342_4 = Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor2.r, var_342_3)
								local var_342_5 = Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor2.g, var_342_3)
								local var_342_6 = Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor2.b, var_342_3)

								iter_342_1.color = Color.New(var_342_4, var_342_5, var_342_6)
							else
								local var_342_7 = Mathf.Lerp(iter_342_1.color.r, 0.5, var_342_3)

								iter_342_1.color = Color.New(var_342_7, var_342_7, var_342_7)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps10144 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_342_3 then
						if arg_339_1.isInRecall_ then
							iter_342_3.color = arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_342_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps10144 = nil
			end

			local var_342_8 = 0
			local var_342_9 = 0.35

			if var_342_8 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_10 = arg_339_1:FormatText(StoryNameCfg[7].name)

				arg_339_1.leftNameTxt_.text = var_342_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_11 = arg_339_1:GetWordFromCfg(926021084)
				local var_342_12 = arg_339_1:FormatText(var_342_11.content)

				arg_339_1.text_.text = var_342_12

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_13 = 14
				local var_342_14 = utf8.len(var_342_12)
				local var_342_15 = var_342_13 <= 0 and var_342_9 or var_342_9 * (var_342_14 / var_342_13)

				if var_342_15 > 0 and var_342_9 < var_342_15 then
					arg_339_1.talkMaxDuration = var_342_15

					if var_342_15 + var_342_8 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_15 + var_342_8
					end
				end

				arg_339_1.text_.text = var_342_12
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_16 = math.max(var_342_9, arg_339_1.talkMaxDuration)

			if var_342_8 <= arg_339_1.time_ and arg_339_1.time_ < var_342_8 + var_342_16 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_8) / var_342_16

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_8 + var_342_16 and arg_339_1.time_ < var_342_8 + var_342_16 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play926021085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 926021085
		arg_343_1.duration_ = 5.5

		local var_343_0 = {
			zh = 4.9,
			ja = 5.5
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play926021086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["106103"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps106103 == nil then
				arg_343_1.var_.actorSpriteComps106103 = var_346_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_2 = 0.2

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.actorSpriteComps106103 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								local var_346_4 = Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor1.r, var_346_3)
								local var_346_5 = Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor1.g, var_346_3)
								local var_346_6 = Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor1.b, var_346_3)

								iter_346_1.color = Color.New(var_346_4, var_346_5, var_346_6)
							else
								local var_346_7 = Mathf.Lerp(iter_346_1.color.r, 1, var_346_3)

								iter_346_1.color = Color.New(var_346_7, var_346_7, var_346_7)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps106103 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_346_3 then
						if arg_343_1.isInRecall_ then
							iter_346_3.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps106103 = nil
			end

			local var_346_8 = arg_343_1.actors_["10144"].transform
			local var_346_9 = 0

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1.var_.moveOldPos10144 = var_346_8.localPosition
				var_346_8.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10144", 4)

				local var_346_10 = var_346_8.childCount

				for iter_346_4 = 0, var_346_10 - 1 do
					local var_346_11 = var_346_8:GetChild(iter_346_4)

					if var_346_11.name == "" or not string.find(var_346_11.name, "split") then
						var_346_11.gameObject:SetActive(true)
					else
						var_346_11.gameObject:SetActive(false)
					end
				end
			end

			local var_346_12 = 0.001

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_12 then
				local var_346_13 = (arg_343_1.time_ - var_346_9) / var_346_12
				local var_346_14 = Vector3.New(435.8, -381.1, -285.9)

				var_346_8.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10144, var_346_14, var_346_13)
			end

			if arg_343_1.time_ >= var_346_9 + var_346_12 and arg_343_1.time_ < var_346_9 + var_346_12 + arg_346_0 then
				var_346_8.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_346_15 = arg_343_1.actors_["106103"].transform
			local var_346_16 = 0

			if var_346_16 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 then
				arg_343_1.var_.moveOldPos106103 = var_346_15.localPosition
				var_346_15.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("106103", 2)

				local var_346_17 = var_346_15.childCount

				for iter_346_5 = 0, var_346_17 - 1 do
					local var_346_18 = var_346_15:GetChild(iter_346_5)

					if var_346_18.name == "" or not string.find(var_346_18.name, "split") then
						var_346_18.gameObject:SetActive(true)
					else
						var_346_18.gameObject:SetActive(false)
					end
				end
			end

			local var_346_19 = 0.001

			if var_346_16 <= arg_343_1.time_ and arg_343_1.time_ < var_346_16 + var_346_19 then
				local var_346_20 = (arg_343_1.time_ - var_346_16) / var_346_19
				local var_346_21 = Vector3.New(-428.4, -398.2, -333.7)

				var_346_15.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos106103, var_346_21, var_346_20)
			end

			if arg_343_1.time_ >= var_346_16 + var_346_19 and arg_343_1.time_ < var_346_16 + var_346_19 + arg_346_0 then
				var_346_15.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_346_22 = 0
			local var_346_23 = 0.6

			if var_346_22 < arg_343_1.time_ and arg_343_1.time_ <= var_346_22 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_24 = arg_343_1:FormatText(StoryNameCfg[612].name)

				arg_343_1.leftNameTxt_.text = var_346_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_25 = arg_343_1:GetWordFromCfg(926021085)
				local var_346_26 = arg_343_1:FormatText(var_346_25.content)

				arg_343_1.text_.text = var_346_26

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_27 = 24
				local var_346_28 = utf8.len(var_346_26)
				local var_346_29 = var_346_27 <= 0 and var_346_23 or var_346_23 * (var_346_28 / var_346_27)

				if var_346_29 > 0 and var_346_23 < var_346_29 then
					arg_343_1.talkMaxDuration = var_346_29

					if var_346_29 + var_346_22 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_29 + var_346_22
					end
				end

				arg_343_1.text_.text = var_346_26
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021085", "story_v_out_926021.awb") ~= 0 then
					local var_346_30 = manager.audio:GetVoiceLength("story_v_out_926021", "926021085", "story_v_out_926021.awb") / 1000

					if var_346_30 + var_346_22 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_30 + var_346_22
					end

					if var_346_25.prefab_name ~= "" and arg_343_1.actors_[var_346_25.prefab_name] ~= nil then
						local var_346_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_25.prefab_name].transform, "story_v_out_926021", "926021085", "story_v_out_926021.awb")

						arg_343_1:RecordAudio("926021085", var_346_31)
						arg_343_1:RecordAudio("926021085", var_346_31)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_926021", "926021085", "story_v_out_926021.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_926021", "926021085", "story_v_out_926021.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_32 = math.max(var_346_23, arg_343_1.talkMaxDuration)

			if var_346_22 <= arg_343_1.time_ and arg_343_1.time_ < var_346_22 + var_346_32 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_22) / var_346_32

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_22 + var_346_32 and arg_343_1.time_ < var_346_22 + var_346_32 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play926021086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 926021086
		arg_347_1.duration_ = 5.97

		local var_347_0 = {
			zh = 5.966,
			ja = 5.566
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play926021087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10144"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10144 == nil then
				arg_347_1.var_.actorSpriteComps10144 = var_350_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.actorSpriteComps10144 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								local var_350_4 = Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor1.r, var_350_3)
								local var_350_5 = Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor1.g, var_350_3)
								local var_350_6 = Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor1.b, var_350_3)

								iter_350_1.color = Color.New(var_350_4, var_350_5, var_350_6)
							else
								local var_350_7 = Mathf.Lerp(iter_350_1.color.r, 1, var_350_3)

								iter_350_1.color = Color.New(var_350_7, var_350_7, var_350_7)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10144 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_350_3 then
						if arg_347_1.isInRecall_ then
							iter_350_3.color = arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_350_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10144 = nil
			end

			local var_350_8 = arg_347_1.actors_["106103"]
			local var_350_9 = 0

			if var_350_9 < arg_347_1.time_ and arg_347_1.time_ <= var_350_9 + arg_350_0 and not isNil(var_350_8) and arg_347_1.var_.actorSpriteComps106103 == nil then
				arg_347_1.var_.actorSpriteComps106103 = var_350_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_10 = 0.2

			if var_350_9 <= arg_347_1.time_ and arg_347_1.time_ < var_350_9 + var_350_10 and not isNil(var_350_8) then
				local var_350_11 = (arg_347_1.time_ - var_350_9) / var_350_10

				if arg_347_1.var_.actorSpriteComps106103 then
					for iter_350_4, iter_350_5 in pairs(arg_347_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_350_5 then
							if arg_347_1.isInRecall_ then
								local var_350_12 = Mathf.Lerp(iter_350_5.color.r, arg_347_1.hightColor2.r, var_350_11)
								local var_350_13 = Mathf.Lerp(iter_350_5.color.g, arg_347_1.hightColor2.g, var_350_11)
								local var_350_14 = Mathf.Lerp(iter_350_5.color.b, arg_347_1.hightColor2.b, var_350_11)

								iter_350_5.color = Color.New(var_350_12, var_350_13, var_350_14)
							else
								local var_350_15 = Mathf.Lerp(iter_350_5.color.r, 0.5, var_350_11)

								iter_350_5.color = Color.New(var_350_15, var_350_15, var_350_15)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_9 + var_350_10 and arg_347_1.time_ < var_350_9 + var_350_10 + arg_350_0 and not isNil(var_350_8) and arg_347_1.var_.actorSpriteComps106103 then
				for iter_350_6, iter_350_7 in pairs(arg_347_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_350_7 then
						if arg_347_1.isInRecall_ then
							iter_350_7.color = arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_350_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps106103 = nil
			end

			local var_350_16 = 0
			local var_350_17 = 0.8

			if var_350_16 < arg_347_1.time_ and arg_347_1.time_ <= var_350_16 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_18 = arg_347_1:FormatText(StoryNameCfg[1297].name)

				arg_347_1.leftNameTxt_.text = var_350_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_19 = arg_347_1:GetWordFromCfg(926021086)
				local var_350_20 = arg_347_1:FormatText(var_350_19.content)

				arg_347_1.text_.text = var_350_20

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_21 = 32
				local var_350_22 = utf8.len(var_350_20)
				local var_350_23 = var_350_21 <= 0 and var_350_17 or var_350_17 * (var_350_22 / var_350_21)

				if var_350_23 > 0 and var_350_17 < var_350_23 then
					arg_347_1.talkMaxDuration = var_350_23

					if var_350_23 + var_350_16 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_23 + var_350_16
					end
				end

				arg_347_1.text_.text = var_350_20
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021086", "story_v_out_926021.awb") ~= 0 then
					local var_350_24 = manager.audio:GetVoiceLength("story_v_out_926021", "926021086", "story_v_out_926021.awb") / 1000

					if var_350_24 + var_350_16 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_24 + var_350_16
					end

					if var_350_19.prefab_name ~= "" and arg_347_1.actors_[var_350_19.prefab_name] ~= nil then
						local var_350_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_19.prefab_name].transform, "story_v_out_926021", "926021086", "story_v_out_926021.awb")

						arg_347_1:RecordAudio("926021086", var_350_25)
						arg_347_1:RecordAudio("926021086", var_350_25)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_926021", "926021086", "story_v_out_926021.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_926021", "926021086", "story_v_out_926021.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_26 = math.max(var_350_17, arg_347_1.talkMaxDuration)

			if var_350_16 <= arg_347_1.time_ and arg_347_1.time_ < var_350_16 + var_350_26 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_16) / var_350_26

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_16 + var_350_26 and arg_347_1.time_ < var_350_16 + var_350_26 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play926021087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 926021087
		arg_351_1.duration_ = 6.6

		local var_351_0 = {
			zh = 4.6,
			ja = 6.6
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play926021088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 0.575

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_2 = arg_351_1:FormatText(StoryNameCfg[1297].name)

				arg_351_1.leftNameTxt_.text = var_354_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_3 = arg_351_1:GetWordFromCfg(926021087)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 23
				local var_354_6 = utf8.len(var_354_4)
				local var_354_7 = var_354_5 <= 0 and var_354_1 or var_354_1 * (var_354_6 / var_354_5)

				if var_354_7 > 0 and var_354_1 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021087", "story_v_out_926021.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021087", "story_v_out_926021.awb") / 1000

					if var_354_8 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_0
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_926021", "926021087", "story_v_out_926021.awb")

						arg_351_1:RecordAudio("926021087", var_354_9)
						arg_351_1:RecordAudio("926021087", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_926021", "926021087", "story_v_out_926021.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_926021", "926021087", "story_v_out_926021.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_10 and arg_351_1.time_ < var_354_0 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play926021088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 926021088
		arg_355_1.duration_ = 8.87

		local var_355_0 = {
			zh = 5.066,
			ja = 8.866
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play926021089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10144"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos10144 = var_358_0.localPosition
				var_358_0.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10144", 4)

				local var_358_2 = var_358_0.childCount

				for iter_358_0 = 0, var_358_2 - 1 do
					local var_358_3 = var_358_0:GetChild(iter_358_0)

					if var_358_3.name == "split_4" or not string.find(var_358_3.name, "split") then
						var_358_3.gameObject:SetActive(true)
					else
						var_358_3.gameObject:SetActive(false)
					end
				end
			end

			local var_358_4 = 0.001

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_4 then
				local var_358_5 = (arg_355_1.time_ - var_358_1) / var_358_4
				local var_358_6 = Vector3.New(435.8, -381.1, -285.9)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10144, var_358_6, var_358_5)
			end

			if arg_355_1.time_ >= var_358_1 + var_358_4 and arg_355_1.time_ < var_358_1 + var_358_4 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_358_7 = 0
			local var_358_8 = 0.7

			if var_358_7 < arg_355_1.time_ and arg_355_1.time_ <= var_358_7 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_9 = arg_355_1:FormatText(StoryNameCfg[1297].name)

				arg_355_1.leftNameTxt_.text = var_358_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_10 = arg_355_1:GetWordFromCfg(926021088)
				local var_358_11 = arg_355_1:FormatText(var_358_10.content)

				arg_355_1.text_.text = var_358_11

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_12 = 28
				local var_358_13 = utf8.len(var_358_11)
				local var_358_14 = var_358_12 <= 0 and var_358_8 or var_358_8 * (var_358_13 / var_358_12)

				if var_358_14 > 0 and var_358_8 < var_358_14 then
					arg_355_1.talkMaxDuration = var_358_14

					if var_358_14 + var_358_7 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_7
					end
				end

				arg_355_1.text_.text = var_358_11
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021088", "story_v_out_926021.awb") ~= 0 then
					local var_358_15 = manager.audio:GetVoiceLength("story_v_out_926021", "926021088", "story_v_out_926021.awb") / 1000

					if var_358_15 + var_358_7 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_15 + var_358_7
					end

					if var_358_10.prefab_name ~= "" and arg_355_1.actors_[var_358_10.prefab_name] ~= nil then
						local var_358_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_10.prefab_name].transform, "story_v_out_926021", "926021088", "story_v_out_926021.awb")

						arg_355_1:RecordAudio("926021088", var_358_16)
						arg_355_1:RecordAudio("926021088", var_358_16)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_926021", "926021088", "story_v_out_926021.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_926021", "926021088", "story_v_out_926021.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_17 = math.max(var_358_8, arg_355_1.talkMaxDuration)

			if var_358_7 <= arg_355_1.time_ and arg_355_1.time_ < var_358_7 + var_358_17 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_7) / var_358_17

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_7 + var_358_17 and arg_355_1.time_ < var_358_7 + var_358_17 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play926021089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 926021089
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play926021090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["10144"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps10144 == nil then
				arg_359_1.var_.actorSpriteComps10144 = var_362_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_2 = 0.2

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.actorSpriteComps10144 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								local var_362_4 = Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor2.r, var_362_3)
								local var_362_5 = Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor2.g, var_362_3)
								local var_362_6 = Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor2.b, var_362_3)

								iter_362_1.color = Color.New(var_362_4, var_362_5, var_362_6)
							else
								local var_362_7 = Mathf.Lerp(iter_362_1.color.r, 0.5, var_362_3)

								iter_362_1.color = Color.New(var_362_7, var_362_7, var_362_7)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps10144 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_362_3 then
						if arg_359_1.isInRecall_ then
							iter_362_3.color = arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_362_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps10144 = nil
			end

			local var_362_8 = arg_359_1.actors_["10144"].transform
			local var_362_9 = 0

			if var_362_9 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 then
				arg_359_1.var_.moveOldPos10144 = var_362_8.localPosition
				var_362_8.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10144", 7)

				local var_362_10 = var_362_8.childCount

				for iter_362_4 = 0, var_362_10 - 1 do
					local var_362_11 = var_362_8:GetChild(iter_362_4)

					if var_362_11.name == "" or not string.find(var_362_11.name, "split") then
						var_362_11.gameObject:SetActive(true)
					else
						var_362_11.gameObject:SetActive(false)
					end
				end
			end

			local var_362_12 = 0.001

			if var_362_9 <= arg_359_1.time_ and arg_359_1.time_ < var_362_9 + var_362_12 then
				local var_362_13 = (arg_359_1.time_ - var_362_9) / var_362_12
				local var_362_14 = Vector3.New(0, -2000, 0)

				var_362_8.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10144, var_362_14, var_362_13)
			end

			if arg_359_1.time_ >= var_362_9 + var_362_12 and arg_359_1.time_ < var_362_9 + var_362_12 + arg_362_0 then
				var_362_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_362_15 = arg_359_1.actors_["106103"].transform
			local var_362_16 = 0

			if var_362_16 < arg_359_1.time_ and arg_359_1.time_ <= var_362_16 + arg_362_0 then
				arg_359_1.var_.moveOldPos106103 = var_362_15.localPosition
				var_362_15.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("106103", 7)

				local var_362_17 = var_362_15.childCount

				for iter_362_5 = 0, var_362_17 - 1 do
					local var_362_18 = var_362_15:GetChild(iter_362_5)

					if var_362_18.name == "" or not string.find(var_362_18.name, "split") then
						var_362_18.gameObject:SetActive(true)
					else
						var_362_18.gameObject:SetActive(false)
					end
				end
			end

			local var_362_19 = 0.001

			if var_362_16 <= arg_359_1.time_ and arg_359_1.time_ < var_362_16 + var_362_19 then
				local var_362_20 = (arg_359_1.time_ - var_362_16) / var_362_19
				local var_362_21 = Vector3.New(0, -2000, 0)

				var_362_15.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos106103, var_362_21, var_362_20)
			end

			if arg_359_1.time_ >= var_362_16 + var_362_19 and arg_359_1.time_ < var_362_16 + var_362_19 + arg_362_0 then
				var_362_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_362_22 = 0
			local var_362_23 = 0.825

			if var_362_22 < arg_359_1.time_ and arg_359_1.time_ <= var_362_22 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_24 = arg_359_1:GetWordFromCfg(926021089)
				local var_362_25 = arg_359_1:FormatText(var_362_24.content)

				arg_359_1.text_.text = var_362_25

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_26 = 33
				local var_362_27 = utf8.len(var_362_25)
				local var_362_28 = var_362_26 <= 0 and var_362_23 or var_362_23 * (var_362_27 / var_362_26)

				if var_362_28 > 0 and var_362_23 < var_362_28 then
					arg_359_1.talkMaxDuration = var_362_28

					if var_362_28 + var_362_22 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_28 + var_362_22
					end
				end

				arg_359_1.text_.text = var_362_25
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_29 = math.max(var_362_23, arg_359_1.talkMaxDuration)

			if var_362_22 <= arg_359_1.time_ and arg_359_1.time_ < var_362_22 + var_362_29 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_22) / var_362_29

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_22 + var_362_29 and arg_359_1.time_ < var_362_22 + var_362_29 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play926021090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 926021090
		arg_363_1.duration_ = 5.4

		local var_363_0 = {
			zh = 4.833,
			ja = 5.4
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play926021091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["10144"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps10144 == nil then
				arg_363_1.var_.actorSpriteComps10144 = var_366_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_2 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.actorSpriteComps10144 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								local var_366_4 = Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor1.r, var_366_3)
								local var_366_5 = Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor1.g, var_366_3)
								local var_366_6 = Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor1.b, var_366_3)

								iter_366_1.color = Color.New(var_366_4, var_366_5, var_366_6)
							else
								local var_366_7 = Mathf.Lerp(iter_366_1.color.r, 1, var_366_3)

								iter_366_1.color = Color.New(var_366_7, var_366_7, var_366_7)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps10144 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_366_3 then
						if arg_363_1.isInRecall_ then
							iter_366_3.color = arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_366_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps10144 = nil
			end

			local var_366_8 = 0
			local var_366_9 = 0.475

			if var_366_8 < arg_363_1.time_ and arg_363_1.time_ <= var_366_8 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_10 = arg_363_1:FormatText(StoryNameCfg[1297].name)

				arg_363_1.leftNameTxt_.text = var_366_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10144_split_1")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_11 = arg_363_1:GetWordFromCfg(926021090)
				local var_366_12 = arg_363_1:FormatText(var_366_11.content)

				arg_363_1.text_.text = var_366_12

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_13 = 19
				local var_366_14 = utf8.len(var_366_12)
				local var_366_15 = var_366_13 <= 0 and var_366_9 or var_366_9 * (var_366_14 / var_366_13)

				if var_366_15 > 0 and var_366_9 < var_366_15 then
					arg_363_1.talkMaxDuration = var_366_15

					if var_366_15 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_15 + var_366_8
					end
				end

				arg_363_1.text_.text = var_366_12
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021090", "story_v_out_926021.awb") ~= 0 then
					local var_366_16 = manager.audio:GetVoiceLength("story_v_out_926021", "926021090", "story_v_out_926021.awb") / 1000

					if var_366_16 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_16 + var_366_8
					end

					if var_366_11.prefab_name ~= "" and arg_363_1.actors_[var_366_11.prefab_name] ~= nil then
						local var_366_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_11.prefab_name].transform, "story_v_out_926021", "926021090", "story_v_out_926021.awb")

						arg_363_1:RecordAudio("926021090", var_366_17)
						arg_363_1:RecordAudio("926021090", var_366_17)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_926021", "926021090", "story_v_out_926021.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_926021", "926021090", "story_v_out_926021.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_18 = math.max(var_366_9, arg_363_1.talkMaxDuration)

			if var_366_8 <= arg_363_1.time_ and arg_363_1.time_ < var_366_8 + var_366_18 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_8) / var_366_18

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_8 + var_366_18 and arg_363_1.time_ < var_366_8 + var_366_18 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play926021091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 926021091
		arg_367_1.duration_ = 6.33

		local var_367_0 = {
			zh = 5,
			ja = 6.333
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play926021092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["128404"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps128404 == nil then
				arg_367_1.var_.actorSpriteComps128404 = var_370_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_2 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.actorSpriteComps128404 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_370_1 then
							if arg_367_1.isInRecall_ then
								local var_370_4 = Mathf.Lerp(iter_370_1.color.r, arg_367_1.hightColor1.r, var_370_3)
								local var_370_5 = Mathf.Lerp(iter_370_1.color.g, arg_367_1.hightColor1.g, var_370_3)
								local var_370_6 = Mathf.Lerp(iter_370_1.color.b, arg_367_1.hightColor1.b, var_370_3)

								iter_370_1.color = Color.New(var_370_4, var_370_5, var_370_6)
							else
								local var_370_7 = Mathf.Lerp(iter_370_1.color.r, 1, var_370_3)

								iter_370_1.color = Color.New(var_370_7, var_370_7, var_370_7)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps128404 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_370_3 then
						if arg_367_1.isInRecall_ then
							iter_370_3.color = arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_370_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps128404 = nil
			end

			local var_370_8 = arg_367_1.actors_["10144"]
			local var_370_9 = 0

			if var_370_9 < arg_367_1.time_ and arg_367_1.time_ <= var_370_9 + arg_370_0 and not isNil(var_370_8) and arg_367_1.var_.actorSpriteComps10144 == nil then
				arg_367_1.var_.actorSpriteComps10144 = var_370_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_10 = 0.2

			if var_370_9 <= arg_367_1.time_ and arg_367_1.time_ < var_370_9 + var_370_10 and not isNil(var_370_8) then
				local var_370_11 = (arg_367_1.time_ - var_370_9) / var_370_10

				if arg_367_1.var_.actorSpriteComps10144 then
					for iter_370_4, iter_370_5 in pairs(arg_367_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_370_5 then
							if arg_367_1.isInRecall_ then
								local var_370_12 = Mathf.Lerp(iter_370_5.color.r, arg_367_1.hightColor2.r, var_370_11)
								local var_370_13 = Mathf.Lerp(iter_370_5.color.g, arg_367_1.hightColor2.g, var_370_11)
								local var_370_14 = Mathf.Lerp(iter_370_5.color.b, arg_367_1.hightColor2.b, var_370_11)

								iter_370_5.color = Color.New(var_370_12, var_370_13, var_370_14)
							else
								local var_370_15 = Mathf.Lerp(iter_370_5.color.r, 0.5, var_370_11)

								iter_370_5.color = Color.New(var_370_15, var_370_15, var_370_15)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= var_370_9 + var_370_10 and arg_367_1.time_ < var_370_9 + var_370_10 + arg_370_0 and not isNil(var_370_8) and arg_367_1.var_.actorSpriteComps10144 then
				for iter_370_6, iter_370_7 in pairs(arg_367_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_370_7 then
						if arg_367_1.isInRecall_ then
							iter_370_7.color = arg_367_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_370_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps10144 = nil
			end

			local var_370_16 = arg_367_1.actors_["128404"].transform
			local var_370_17 = 0

			if var_370_17 < arg_367_1.time_ and arg_367_1.time_ <= var_370_17 + arg_370_0 then
				arg_367_1.var_.moveOldPos128404 = var_370_16.localPosition
				var_370_16.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("128404", 2)

				local var_370_18 = var_370_16.childCount

				for iter_370_8 = 0, var_370_18 - 1 do
					local var_370_19 = var_370_16:GetChild(iter_370_8)

					if var_370_19.name == "split_4" or not string.find(var_370_19.name, "split") then
						var_370_19.gameObject:SetActive(true)
					else
						var_370_19.gameObject:SetActive(false)
					end
				end
			end

			local var_370_20 = 0.001

			if var_370_17 <= arg_367_1.time_ and arg_367_1.time_ < var_370_17 + var_370_20 then
				local var_370_21 = (arg_367_1.time_ - var_370_17) / var_370_20
				local var_370_22 = Vector3.New(-428.5, -356, -362.3)

				var_370_16.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos128404, var_370_22, var_370_21)
			end

			if arg_367_1.time_ >= var_370_17 + var_370_20 and arg_367_1.time_ < var_370_17 + var_370_20 + arg_370_0 then
				var_370_16.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_370_23 = 0
			local var_370_24 = 0.475

			if var_370_23 < arg_367_1.time_ and arg_367_1.time_ <= var_370_23 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_25 = arg_367_1:FormatText(StoryNameCfg[6].name)

				arg_367_1.leftNameTxt_.text = var_370_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_26 = arg_367_1:GetWordFromCfg(926021091)
				local var_370_27 = arg_367_1:FormatText(var_370_26.content)

				arg_367_1.text_.text = var_370_27

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_28 = 19
				local var_370_29 = utf8.len(var_370_27)
				local var_370_30 = var_370_28 <= 0 and var_370_24 or var_370_24 * (var_370_29 / var_370_28)

				if var_370_30 > 0 and var_370_24 < var_370_30 then
					arg_367_1.talkMaxDuration = var_370_30

					if var_370_30 + var_370_23 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_30 + var_370_23
					end
				end

				arg_367_1.text_.text = var_370_27
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021091", "story_v_out_926021.awb") ~= 0 then
					local var_370_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021091", "story_v_out_926021.awb") / 1000

					if var_370_31 + var_370_23 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_31 + var_370_23
					end

					if var_370_26.prefab_name ~= "" and arg_367_1.actors_[var_370_26.prefab_name] ~= nil then
						local var_370_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_26.prefab_name].transform, "story_v_out_926021", "926021091", "story_v_out_926021.awb")

						arg_367_1:RecordAudio("926021091", var_370_32)
						arg_367_1:RecordAudio("926021091", var_370_32)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_926021", "926021091", "story_v_out_926021.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_926021", "926021091", "story_v_out_926021.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_33 = math.max(var_370_24, arg_367_1.talkMaxDuration)

			if var_370_23 <= arg_367_1.time_ and arg_367_1.time_ < var_370_23 + var_370_33 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_23) / var_370_33

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_23 + var_370_33 and arg_367_1.time_ < var_370_23 + var_370_33 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play926021092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 926021092
		arg_371_1.duration_ = 4.53

		local var_371_0 = {
			zh = 4.533,
			ja = 4.133
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play926021093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["106103"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps106103 == nil then
				arg_371_1.var_.actorSpriteComps106103 = var_374_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_2 = 0.2

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.actorSpriteComps106103 then
					for iter_374_0, iter_374_1 in pairs(arg_371_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_374_1 then
							if arg_371_1.isInRecall_ then
								local var_374_4 = Mathf.Lerp(iter_374_1.color.r, arg_371_1.hightColor1.r, var_374_3)
								local var_374_5 = Mathf.Lerp(iter_374_1.color.g, arg_371_1.hightColor1.g, var_374_3)
								local var_374_6 = Mathf.Lerp(iter_374_1.color.b, arg_371_1.hightColor1.b, var_374_3)

								iter_374_1.color = Color.New(var_374_4, var_374_5, var_374_6)
							else
								local var_374_7 = Mathf.Lerp(iter_374_1.color.r, 1, var_374_3)

								iter_374_1.color = Color.New(var_374_7, var_374_7, var_374_7)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps106103 then
				for iter_374_2, iter_374_3 in pairs(arg_371_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_374_3 then
						if arg_371_1.isInRecall_ then
							iter_374_3.color = arg_371_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_374_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps106103 = nil
			end

			local var_374_8 = arg_371_1.actors_["128404"]
			local var_374_9 = 0

			if var_374_9 < arg_371_1.time_ and arg_371_1.time_ <= var_374_9 + arg_374_0 and not isNil(var_374_8) and arg_371_1.var_.actorSpriteComps128404 == nil then
				arg_371_1.var_.actorSpriteComps128404 = var_374_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_10 = 0.2

			if var_374_9 <= arg_371_1.time_ and arg_371_1.time_ < var_374_9 + var_374_10 and not isNil(var_374_8) then
				local var_374_11 = (arg_371_1.time_ - var_374_9) / var_374_10

				if arg_371_1.var_.actorSpriteComps128404 then
					for iter_374_4, iter_374_5 in pairs(arg_371_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_374_5 then
							if arg_371_1.isInRecall_ then
								local var_374_12 = Mathf.Lerp(iter_374_5.color.r, arg_371_1.hightColor2.r, var_374_11)
								local var_374_13 = Mathf.Lerp(iter_374_5.color.g, arg_371_1.hightColor2.g, var_374_11)
								local var_374_14 = Mathf.Lerp(iter_374_5.color.b, arg_371_1.hightColor2.b, var_374_11)

								iter_374_5.color = Color.New(var_374_12, var_374_13, var_374_14)
							else
								local var_374_15 = Mathf.Lerp(iter_374_5.color.r, 0.5, var_374_11)

								iter_374_5.color = Color.New(var_374_15, var_374_15, var_374_15)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_9 + var_374_10 and arg_371_1.time_ < var_374_9 + var_374_10 + arg_374_0 and not isNil(var_374_8) and arg_371_1.var_.actorSpriteComps128404 then
				for iter_374_6, iter_374_7 in pairs(arg_371_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_374_7 then
						if arg_371_1.isInRecall_ then
							iter_374_7.color = arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_374_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps128404 = nil
			end

			local var_374_16 = arg_371_1.actors_["106103"].transform
			local var_374_17 = 0

			if var_374_17 < arg_371_1.time_ and arg_371_1.time_ <= var_374_17 + arg_374_0 then
				arg_371_1.var_.moveOldPos106103 = var_374_16.localPosition
				var_374_16.localScale = Vector3.New(1, 1, 1)

				arg_371_1:CheckSpriteTmpPos("106103", 4)

				local var_374_18 = var_374_16.childCount

				for iter_374_8 = 0, var_374_18 - 1 do
					local var_374_19 = var_374_16:GetChild(iter_374_8)

					if var_374_19.name == "split_3" or not string.find(var_374_19.name, "split") then
						var_374_19.gameObject:SetActive(true)
					else
						var_374_19.gameObject:SetActive(false)
					end
				end
			end

			local var_374_20 = 0.001

			if var_374_17 <= arg_371_1.time_ and arg_371_1.time_ < var_374_17 + var_374_20 then
				local var_374_21 = (arg_371_1.time_ - var_374_17) / var_374_20
				local var_374_22 = Vector3.New(442.7, -398.2, -333.7)

				var_374_16.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos106103, var_374_22, var_374_21)
			end

			if arg_371_1.time_ >= var_374_17 + var_374_20 and arg_371_1.time_ < var_374_17 + var_374_20 + arg_374_0 then
				var_374_16.localPosition = Vector3.New(442.7, -398.2, -333.7)
			end

			local var_374_23 = 0
			local var_374_24 = 0.475

			if var_374_23 < arg_371_1.time_ and arg_371_1.time_ <= var_374_23 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_25 = arg_371_1:FormatText(StoryNameCfg[612].name)

				arg_371_1.leftNameTxt_.text = var_374_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_26 = arg_371_1:GetWordFromCfg(926021092)
				local var_374_27 = arg_371_1:FormatText(var_374_26.content)

				arg_371_1.text_.text = var_374_27

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_28 = 19
				local var_374_29 = utf8.len(var_374_27)
				local var_374_30 = var_374_28 <= 0 and var_374_24 or var_374_24 * (var_374_29 / var_374_28)

				if var_374_30 > 0 and var_374_24 < var_374_30 then
					arg_371_1.talkMaxDuration = var_374_30

					if var_374_30 + var_374_23 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_30 + var_374_23
					end
				end

				arg_371_1.text_.text = var_374_27
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021092", "story_v_out_926021.awb") ~= 0 then
					local var_374_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021092", "story_v_out_926021.awb") / 1000

					if var_374_31 + var_374_23 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_31 + var_374_23
					end

					if var_374_26.prefab_name ~= "" and arg_371_1.actors_[var_374_26.prefab_name] ~= nil then
						local var_374_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_26.prefab_name].transform, "story_v_out_926021", "926021092", "story_v_out_926021.awb")

						arg_371_1:RecordAudio("926021092", var_374_32)
						arg_371_1:RecordAudio("926021092", var_374_32)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_926021", "926021092", "story_v_out_926021.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_926021", "926021092", "story_v_out_926021.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_33 = math.max(var_374_24, arg_371_1.talkMaxDuration)

			if var_374_23 <= arg_371_1.time_ and arg_371_1.time_ < var_374_23 + var_374_33 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_23) / var_374_33

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_23 + var_374_33 and arg_371_1.time_ < var_374_23 + var_374_33 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play926021093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 926021093
		arg_375_1.duration_ = 2.47

		local var_375_0 = {
			zh = 2.466,
			ja = 2.1
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play926021094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0
			local var_378_1 = 0.375

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_2 = arg_375_1:FormatText(StoryNameCfg[612].name)

				arg_375_1.leftNameTxt_.text = var_378_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_3 = arg_375_1:GetWordFromCfg(926021093)
				local var_378_4 = arg_375_1:FormatText(var_378_3.content)

				arg_375_1.text_.text = var_378_4

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 15
				local var_378_6 = utf8.len(var_378_4)
				local var_378_7 = var_378_5 <= 0 and var_378_1 or var_378_1 * (var_378_6 / var_378_5)

				if var_378_7 > 0 and var_378_1 < var_378_7 then
					arg_375_1.talkMaxDuration = var_378_7

					if var_378_7 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_7 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_4
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021093", "story_v_out_926021.awb") ~= 0 then
					local var_378_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021093", "story_v_out_926021.awb") / 1000

					if var_378_8 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_0
					end

					if var_378_3.prefab_name ~= "" and arg_375_1.actors_[var_378_3.prefab_name] ~= nil then
						local var_378_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_3.prefab_name].transform, "story_v_out_926021", "926021093", "story_v_out_926021.awb")

						arg_375_1:RecordAudio("926021093", var_378_9)
						arg_375_1:RecordAudio("926021093", var_378_9)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_926021", "926021093", "story_v_out_926021.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_926021", "926021093", "story_v_out_926021.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_10 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_10 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_10

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_10 and arg_375_1.time_ < var_378_0 + var_378_10 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play926021094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 926021094
		arg_379_1.duration_ = 10.17

		local var_379_0 = {
			zh = 5.666,
			ja = 10.166
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play926021095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["104701"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps104701 == nil then
				arg_379_1.var_.actorSpriteComps104701 = var_382_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_2 = 0.2

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.actorSpriteComps104701 then
					for iter_382_0, iter_382_1 in pairs(arg_379_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_382_1 then
							if arg_379_1.isInRecall_ then
								local var_382_4 = Mathf.Lerp(iter_382_1.color.r, arg_379_1.hightColor1.r, var_382_3)
								local var_382_5 = Mathf.Lerp(iter_382_1.color.g, arg_379_1.hightColor1.g, var_382_3)
								local var_382_6 = Mathf.Lerp(iter_382_1.color.b, arg_379_1.hightColor1.b, var_382_3)

								iter_382_1.color = Color.New(var_382_4, var_382_5, var_382_6)
							else
								local var_382_7 = Mathf.Lerp(iter_382_1.color.r, 1, var_382_3)

								iter_382_1.color = Color.New(var_382_7, var_382_7, var_382_7)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps104701 then
				for iter_382_2, iter_382_3 in pairs(arg_379_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_382_3 then
						if arg_379_1.isInRecall_ then
							iter_382_3.color = arg_379_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_382_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_379_1.var_.actorSpriteComps104701 = nil
			end

			local var_382_8 = arg_379_1.actors_["106103"]
			local var_382_9 = 0

			if var_382_9 < arg_379_1.time_ and arg_379_1.time_ <= var_382_9 + arg_382_0 and not isNil(var_382_8) and arg_379_1.var_.actorSpriteComps106103 == nil then
				arg_379_1.var_.actorSpriteComps106103 = var_382_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_10 = 0.2

			if var_382_9 <= arg_379_1.time_ and arg_379_1.time_ < var_382_9 + var_382_10 and not isNil(var_382_8) then
				local var_382_11 = (arg_379_1.time_ - var_382_9) / var_382_10

				if arg_379_1.var_.actorSpriteComps106103 then
					for iter_382_4, iter_382_5 in pairs(arg_379_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_382_5 then
							if arg_379_1.isInRecall_ then
								local var_382_12 = Mathf.Lerp(iter_382_5.color.r, arg_379_1.hightColor2.r, var_382_11)
								local var_382_13 = Mathf.Lerp(iter_382_5.color.g, arg_379_1.hightColor2.g, var_382_11)
								local var_382_14 = Mathf.Lerp(iter_382_5.color.b, arg_379_1.hightColor2.b, var_382_11)

								iter_382_5.color = Color.New(var_382_12, var_382_13, var_382_14)
							else
								local var_382_15 = Mathf.Lerp(iter_382_5.color.r, 0.5, var_382_11)

								iter_382_5.color = Color.New(var_382_15, var_382_15, var_382_15)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= var_382_9 + var_382_10 and arg_379_1.time_ < var_382_9 + var_382_10 + arg_382_0 and not isNil(var_382_8) and arg_379_1.var_.actorSpriteComps106103 then
				for iter_382_6, iter_382_7 in pairs(arg_379_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_382_7 then
						if arg_379_1.isInRecall_ then
							iter_382_7.color = arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_382_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_379_1.var_.actorSpriteComps106103 = nil
			end

			local var_382_16 = arg_379_1.actors_["128404"].transform
			local var_382_17 = 0

			if var_382_17 < arg_379_1.time_ and arg_379_1.time_ <= var_382_17 + arg_382_0 then
				arg_379_1.var_.moveOldPos128404 = var_382_16.localPosition
				var_382_16.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("128404", 7)

				local var_382_18 = var_382_16.childCount

				for iter_382_8 = 0, var_382_18 - 1 do
					local var_382_19 = var_382_16:GetChild(iter_382_8)

					if var_382_19.name == "" or not string.find(var_382_19.name, "split") then
						var_382_19.gameObject:SetActive(true)
					else
						var_382_19.gameObject:SetActive(false)
					end
				end
			end

			local var_382_20 = 0.001

			if var_382_17 <= arg_379_1.time_ and arg_379_1.time_ < var_382_17 + var_382_20 then
				local var_382_21 = (arg_379_1.time_ - var_382_17) / var_382_20
				local var_382_22 = Vector3.New(0, -2000, 0)

				var_382_16.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos128404, var_382_22, var_382_21)
			end

			if arg_379_1.time_ >= var_382_17 + var_382_20 and arg_379_1.time_ < var_382_17 + var_382_20 + arg_382_0 then
				var_382_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_382_23 = arg_379_1.actors_["106103"].transform
			local var_382_24 = 0

			if var_382_24 < arg_379_1.time_ and arg_379_1.time_ <= var_382_24 + arg_382_0 then
				arg_379_1.var_.moveOldPos106103 = var_382_23.localPosition
				var_382_23.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("106103", 7)

				local var_382_25 = var_382_23.childCount

				for iter_382_9 = 0, var_382_25 - 1 do
					local var_382_26 = var_382_23:GetChild(iter_382_9)

					if var_382_26.name == "" or not string.find(var_382_26.name, "split") then
						var_382_26.gameObject:SetActive(true)
					else
						var_382_26.gameObject:SetActive(false)
					end
				end
			end

			local var_382_27 = 0.001

			if var_382_24 <= arg_379_1.time_ and arg_379_1.time_ < var_382_24 + var_382_27 then
				local var_382_28 = (arg_379_1.time_ - var_382_24) / var_382_27
				local var_382_29 = Vector3.New(0, -2000, 0)

				var_382_23.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos106103, var_382_29, var_382_28)
			end

			if arg_379_1.time_ >= var_382_24 + var_382_27 and arg_379_1.time_ < var_382_24 + var_382_27 + arg_382_0 then
				var_382_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_382_30 = arg_379_1.actors_["104701"].transform
			local var_382_31 = 0

			if var_382_31 < arg_379_1.time_ and arg_379_1.time_ <= var_382_31 + arg_382_0 then
				arg_379_1.var_.moveOldPos104701 = var_382_30.localPosition
				var_382_30.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("104701", 2)

				local var_382_32 = var_382_30.childCount

				for iter_382_10 = 0, var_382_32 - 1 do
					local var_382_33 = var_382_30:GetChild(iter_382_10)

					if var_382_33.name == "" or not string.find(var_382_33.name, "split") then
						var_382_33.gameObject:SetActive(true)
					else
						var_382_33.gameObject:SetActive(false)
					end
				end
			end

			local var_382_34 = 0.001

			if var_382_31 <= arg_379_1.time_ and arg_379_1.time_ < var_382_31 + var_382_34 then
				local var_382_35 = (arg_379_1.time_ - var_382_31) / var_382_34
				local var_382_36 = Vector3.New(-528.7, -386.8, -295)

				var_382_30.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos104701, var_382_36, var_382_35)
			end

			if arg_379_1.time_ >= var_382_31 + var_382_34 and arg_379_1.time_ < var_382_31 + var_382_34 + arg_382_0 then
				var_382_30.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			local var_382_37 = 0
			local var_382_38 = 0.6

			if var_382_37 < arg_379_1.time_ and arg_379_1.time_ <= var_382_37 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_39 = arg_379_1:FormatText(StoryNameCfg[1296].name)

				arg_379_1.leftNameTxt_.text = var_382_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_40 = arg_379_1:GetWordFromCfg(926021094)
				local var_382_41 = arg_379_1:FormatText(var_382_40.content)

				arg_379_1.text_.text = var_382_41

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_42 = 24
				local var_382_43 = utf8.len(var_382_41)
				local var_382_44 = var_382_42 <= 0 and var_382_38 or var_382_38 * (var_382_43 / var_382_42)

				if var_382_44 > 0 and var_382_38 < var_382_44 then
					arg_379_1.talkMaxDuration = var_382_44

					if var_382_44 + var_382_37 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_44 + var_382_37
					end
				end

				arg_379_1.text_.text = var_382_41
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021094", "story_v_out_926021.awb") ~= 0 then
					local var_382_45 = manager.audio:GetVoiceLength("story_v_out_926021", "926021094", "story_v_out_926021.awb") / 1000

					if var_382_45 + var_382_37 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_45 + var_382_37
					end

					if var_382_40.prefab_name ~= "" and arg_379_1.actors_[var_382_40.prefab_name] ~= nil then
						local var_382_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_40.prefab_name].transform, "story_v_out_926021", "926021094", "story_v_out_926021.awb")

						arg_379_1:RecordAudio("926021094", var_382_46)
						arg_379_1:RecordAudio("926021094", var_382_46)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_926021", "926021094", "story_v_out_926021.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_926021", "926021094", "story_v_out_926021.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_47 = math.max(var_382_38, arg_379_1.talkMaxDuration)

			if var_382_37 <= arg_379_1.time_ and arg_379_1.time_ < var_382_37 + var_382_47 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_37) / var_382_47

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_37 + var_382_47 and arg_379_1.time_ < var_382_37 + var_382_47 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play926021095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 926021095
		arg_383_1.duration_ = 4.03

		local var_383_0 = {
			zh = 3.266,
			ja = 4.033
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play926021096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["10144"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.actorSpriteComps10144 == nil then
				arg_383_1.var_.actorSpriteComps10144 = var_386_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_2 = 0.2

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.actorSpriteComps10144 then
					for iter_386_0, iter_386_1 in pairs(arg_383_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_386_1 then
							if arg_383_1.isInRecall_ then
								local var_386_4 = Mathf.Lerp(iter_386_1.color.r, arg_383_1.hightColor1.r, var_386_3)
								local var_386_5 = Mathf.Lerp(iter_386_1.color.g, arg_383_1.hightColor1.g, var_386_3)
								local var_386_6 = Mathf.Lerp(iter_386_1.color.b, arg_383_1.hightColor1.b, var_386_3)

								iter_386_1.color = Color.New(var_386_4, var_386_5, var_386_6)
							else
								local var_386_7 = Mathf.Lerp(iter_386_1.color.r, 1, var_386_3)

								iter_386_1.color = Color.New(var_386_7, var_386_7, var_386_7)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.actorSpriteComps10144 then
				for iter_386_2, iter_386_3 in pairs(arg_383_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_386_3 then
						if arg_383_1.isInRecall_ then
							iter_386_3.color = arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_386_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps10144 = nil
			end

			local var_386_8 = arg_383_1.actors_["104701"]
			local var_386_9 = 0

			if var_386_9 < arg_383_1.time_ and arg_383_1.time_ <= var_386_9 + arg_386_0 and not isNil(var_386_8) and arg_383_1.var_.actorSpriteComps104701 == nil then
				arg_383_1.var_.actorSpriteComps104701 = var_386_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_10 = 0.2

			if var_386_9 <= arg_383_1.time_ and arg_383_1.time_ < var_386_9 + var_386_10 and not isNil(var_386_8) then
				local var_386_11 = (arg_383_1.time_ - var_386_9) / var_386_10

				if arg_383_1.var_.actorSpriteComps104701 then
					for iter_386_4, iter_386_5 in pairs(arg_383_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_386_5 then
							if arg_383_1.isInRecall_ then
								local var_386_12 = Mathf.Lerp(iter_386_5.color.r, arg_383_1.hightColor2.r, var_386_11)
								local var_386_13 = Mathf.Lerp(iter_386_5.color.g, arg_383_1.hightColor2.g, var_386_11)
								local var_386_14 = Mathf.Lerp(iter_386_5.color.b, arg_383_1.hightColor2.b, var_386_11)

								iter_386_5.color = Color.New(var_386_12, var_386_13, var_386_14)
							else
								local var_386_15 = Mathf.Lerp(iter_386_5.color.r, 0.5, var_386_11)

								iter_386_5.color = Color.New(var_386_15, var_386_15, var_386_15)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_9 + var_386_10 and arg_383_1.time_ < var_386_9 + var_386_10 + arg_386_0 and not isNil(var_386_8) and arg_383_1.var_.actorSpriteComps104701 then
				for iter_386_6, iter_386_7 in pairs(arg_383_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_386_7 then
						if arg_383_1.isInRecall_ then
							iter_386_7.color = arg_383_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_386_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps104701 = nil
			end

			local var_386_16 = arg_383_1.actors_["10144"].transform
			local var_386_17 = 0

			if var_386_17 < arg_383_1.time_ and arg_383_1.time_ <= var_386_17 + arg_386_0 then
				arg_383_1.var_.moveOldPos10144 = var_386_16.localPosition
				var_386_16.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10144", 4)

				local var_386_18 = var_386_16.childCount

				for iter_386_8 = 0, var_386_18 - 1 do
					local var_386_19 = var_386_16:GetChild(iter_386_8)

					if var_386_19.name == "" or not string.find(var_386_19.name, "split") then
						var_386_19.gameObject:SetActive(true)
					else
						var_386_19.gameObject:SetActive(false)
					end
				end
			end

			local var_386_20 = 0.001

			if var_386_17 <= arg_383_1.time_ and arg_383_1.time_ < var_386_17 + var_386_20 then
				local var_386_21 = (arg_383_1.time_ - var_386_17) / var_386_20
				local var_386_22 = Vector3.New(435.8, -381.1, -285.9)

				var_386_16.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10144, var_386_22, var_386_21)
			end

			if arg_383_1.time_ >= var_386_17 + var_386_20 and arg_383_1.time_ < var_386_17 + var_386_20 + arg_386_0 then
				var_386_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_386_23 = 0
			local var_386_24 = 0.35

			if var_386_23 < arg_383_1.time_ and arg_383_1.time_ <= var_386_23 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_25 = arg_383_1:FormatText(StoryNameCfg[1297].name)

				arg_383_1.leftNameTxt_.text = var_386_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_26 = arg_383_1:GetWordFromCfg(926021095)
				local var_386_27 = arg_383_1:FormatText(var_386_26.content)

				arg_383_1.text_.text = var_386_27

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_28 = 14
				local var_386_29 = utf8.len(var_386_27)
				local var_386_30 = var_386_28 <= 0 and var_386_24 or var_386_24 * (var_386_29 / var_386_28)

				if var_386_30 > 0 and var_386_24 < var_386_30 then
					arg_383_1.talkMaxDuration = var_386_30

					if var_386_30 + var_386_23 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_30 + var_386_23
					end
				end

				arg_383_1.text_.text = var_386_27
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021095", "story_v_out_926021.awb") ~= 0 then
					local var_386_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021095", "story_v_out_926021.awb") / 1000

					if var_386_31 + var_386_23 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_31 + var_386_23
					end

					if var_386_26.prefab_name ~= "" and arg_383_1.actors_[var_386_26.prefab_name] ~= nil then
						local var_386_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_26.prefab_name].transform, "story_v_out_926021", "926021095", "story_v_out_926021.awb")

						arg_383_1:RecordAudio("926021095", var_386_32)
						arg_383_1:RecordAudio("926021095", var_386_32)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_926021", "926021095", "story_v_out_926021.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_926021", "926021095", "story_v_out_926021.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_33 = math.max(var_386_24, arg_383_1.talkMaxDuration)

			if var_386_23 <= arg_383_1.time_ and arg_383_1.time_ < var_386_23 + var_386_33 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_23) / var_386_33

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_23 + var_386_33 and arg_383_1.time_ < var_386_23 + var_386_33 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play926021096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 926021096
		arg_387_1.duration_ = 5.63

		local var_387_0 = {
			zh = 5.633,
			ja = 5.3
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play926021097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 0.7

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[1297].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_3 = arg_387_1:GetWordFromCfg(926021096)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 28
				local var_390_6 = utf8.len(var_390_4)
				local var_390_7 = var_390_5 <= 0 and var_390_1 or var_390_1 * (var_390_6 / var_390_5)

				if var_390_7 > 0 and var_390_1 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021096", "story_v_out_926021.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021096", "story_v_out_926021.awb") / 1000

					if var_390_8 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_0
					end

					if var_390_3.prefab_name ~= "" and arg_387_1.actors_[var_390_3.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_3.prefab_name].transform, "story_v_out_926021", "926021096", "story_v_out_926021.awb")

						arg_387_1:RecordAudio("926021096", var_390_9)
						arg_387_1:RecordAudio("926021096", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_926021", "926021096", "story_v_out_926021.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_926021", "926021096", "story_v_out_926021.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_10 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_10

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_10 and arg_387_1.time_ < var_390_0 + var_390_10 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play926021097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 926021097
		arg_391_1.duration_ = 3.7

		local var_391_0 = {
			zh = 3.1,
			ja = 3.7
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play926021098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["104701"]
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.actorSpriteComps104701 == nil then
				arg_391_1.var_.actorSpriteComps104701 = var_394_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_2 = 0.2

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 and not isNil(var_394_0) then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2

				if arg_391_1.var_.actorSpriteComps104701 then
					for iter_394_0, iter_394_1 in pairs(arg_391_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_394_1 then
							if arg_391_1.isInRecall_ then
								local var_394_4 = Mathf.Lerp(iter_394_1.color.r, arg_391_1.hightColor1.r, var_394_3)
								local var_394_5 = Mathf.Lerp(iter_394_1.color.g, arg_391_1.hightColor1.g, var_394_3)
								local var_394_6 = Mathf.Lerp(iter_394_1.color.b, arg_391_1.hightColor1.b, var_394_3)

								iter_394_1.color = Color.New(var_394_4, var_394_5, var_394_6)
							else
								local var_394_7 = Mathf.Lerp(iter_394_1.color.r, 1, var_394_3)

								iter_394_1.color = Color.New(var_394_7, var_394_7, var_394_7)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.actorSpriteComps104701 then
				for iter_394_2, iter_394_3 in pairs(arg_391_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_394_3 then
						if arg_391_1.isInRecall_ then
							iter_394_3.color = arg_391_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_394_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_391_1.var_.actorSpriteComps104701 = nil
			end

			local var_394_8 = arg_391_1.actors_["10144"]
			local var_394_9 = 0

			if var_394_9 < arg_391_1.time_ and arg_391_1.time_ <= var_394_9 + arg_394_0 and not isNil(var_394_8) and arg_391_1.var_.actorSpriteComps10144 == nil then
				arg_391_1.var_.actorSpriteComps10144 = var_394_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_10 = 0.2

			if var_394_9 <= arg_391_1.time_ and arg_391_1.time_ < var_394_9 + var_394_10 and not isNil(var_394_8) then
				local var_394_11 = (arg_391_1.time_ - var_394_9) / var_394_10

				if arg_391_1.var_.actorSpriteComps10144 then
					for iter_394_4, iter_394_5 in pairs(arg_391_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_394_5 then
							if arg_391_1.isInRecall_ then
								local var_394_12 = Mathf.Lerp(iter_394_5.color.r, arg_391_1.hightColor2.r, var_394_11)
								local var_394_13 = Mathf.Lerp(iter_394_5.color.g, arg_391_1.hightColor2.g, var_394_11)
								local var_394_14 = Mathf.Lerp(iter_394_5.color.b, arg_391_1.hightColor2.b, var_394_11)

								iter_394_5.color = Color.New(var_394_12, var_394_13, var_394_14)
							else
								local var_394_15 = Mathf.Lerp(iter_394_5.color.r, 0.5, var_394_11)

								iter_394_5.color = Color.New(var_394_15, var_394_15, var_394_15)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= var_394_9 + var_394_10 and arg_391_1.time_ < var_394_9 + var_394_10 + arg_394_0 and not isNil(var_394_8) and arg_391_1.var_.actorSpriteComps10144 then
				for iter_394_6, iter_394_7 in pairs(arg_391_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_394_7 then
						if arg_391_1.isInRecall_ then
							iter_394_7.color = arg_391_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_394_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_391_1.var_.actorSpriteComps10144 = nil
			end

			local var_394_16 = 0
			local var_394_17 = 0.375

			if var_394_16 < arg_391_1.time_ and arg_391_1.time_ <= var_394_16 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_18 = arg_391_1:FormatText(StoryNameCfg[1296].name)

				arg_391_1.leftNameTxt_.text = var_394_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_19 = arg_391_1:GetWordFromCfg(926021097)
				local var_394_20 = arg_391_1:FormatText(var_394_19.content)

				arg_391_1.text_.text = var_394_20

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_21 = 15
				local var_394_22 = utf8.len(var_394_20)
				local var_394_23 = var_394_21 <= 0 and var_394_17 or var_394_17 * (var_394_22 / var_394_21)

				if var_394_23 > 0 and var_394_17 < var_394_23 then
					arg_391_1.talkMaxDuration = var_394_23

					if var_394_23 + var_394_16 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_23 + var_394_16
					end
				end

				arg_391_1.text_.text = var_394_20
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021097", "story_v_out_926021.awb") ~= 0 then
					local var_394_24 = manager.audio:GetVoiceLength("story_v_out_926021", "926021097", "story_v_out_926021.awb") / 1000

					if var_394_24 + var_394_16 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_24 + var_394_16
					end

					if var_394_19.prefab_name ~= "" and arg_391_1.actors_[var_394_19.prefab_name] ~= nil then
						local var_394_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_19.prefab_name].transform, "story_v_out_926021", "926021097", "story_v_out_926021.awb")

						arg_391_1:RecordAudio("926021097", var_394_25)
						arg_391_1:RecordAudio("926021097", var_394_25)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_926021", "926021097", "story_v_out_926021.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_926021", "926021097", "story_v_out_926021.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_26 = math.max(var_394_17, arg_391_1.talkMaxDuration)

			if var_394_16 <= arg_391_1.time_ and arg_391_1.time_ < var_394_16 + var_394_26 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_16) / var_394_26

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_16 + var_394_26 and arg_391_1.time_ < var_394_16 + var_394_26 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play926021098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 926021098
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play926021099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["104701"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.actorSpriteComps104701 == nil then
				arg_395_1.var_.actorSpriteComps104701 = var_398_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_398_2 = 0.2

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 and not isNil(var_398_0) then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.actorSpriteComps104701 then
					for iter_398_0, iter_398_1 in pairs(arg_395_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_398_1 then
							if arg_395_1.isInRecall_ then
								local var_398_4 = Mathf.Lerp(iter_398_1.color.r, arg_395_1.hightColor2.r, var_398_3)
								local var_398_5 = Mathf.Lerp(iter_398_1.color.g, arg_395_1.hightColor2.g, var_398_3)
								local var_398_6 = Mathf.Lerp(iter_398_1.color.b, arg_395_1.hightColor2.b, var_398_3)

								iter_398_1.color = Color.New(var_398_4, var_398_5, var_398_6)
							else
								local var_398_7 = Mathf.Lerp(iter_398_1.color.r, 0.5, var_398_3)

								iter_398_1.color = Color.New(var_398_7, var_398_7, var_398_7)
							end
						end
					end
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.actorSpriteComps104701 then
				for iter_398_2, iter_398_3 in pairs(arg_395_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_398_3 then
						if arg_395_1.isInRecall_ then
							iter_398_3.color = arg_395_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_398_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_395_1.var_.actorSpriteComps104701 = nil
			end

			local var_398_8 = arg_395_1.actors_["10144"].transform
			local var_398_9 = 0

			if var_398_9 < arg_395_1.time_ and arg_395_1.time_ <= var_398_9 + arg_398_0 then
				arg_395_1.var_.moveOldPos10144 = var_398_8.localPosition
				var_398_8.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("10144", 7)

				local var_398_10 = var_398_8.childCount

				for iter_398_4 = 0, var_398_10 - 1 do
					local var_398_11 = var_398_8:GetChild(iter_398_4)

					if var_398_11.name == "" or not string.find(var_398_11.name, "split") then
						var_398_11.gameObject:SetActive(true)
					else
						var_398_11.gameObject:SetActive(false)
					end
				end
			end

			local var_398_12 = 0.001

			if var_398_9 <= arg_395_1.time_ and arg_395_1.time_ < var_398_9 + var_398_12 then
				local var_398_13 = (arg_395_1.time_ - var_398_9) / var_398_12
				local var_398_14 = Vector3.New(0, -2000, 0)

				var_398_8.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos10144, var_398_14, var_398_13)
			end

			if arg_395_1.time_ >= var_398_9 + var_398_12 and arg_395_1.time_ < var_398_9 + var_398_12 + arg_398_0 then
				var_398_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_398_15 = arg_395_1.actors_["104701"].transform
			local var_398_16 = 0

			if var_398_16 < arg_395_1.time_ and arg_395_1.time_ <= var_398_16 + arg_398_0 then
				arg_395_1.var_.moveOldPos104701 = var_398_15.localPosition
				var_398_15.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("104701", 7)

				local var_398_17 = var_398_15.childCount

				for iter_398_5 = 0, var_398_17 - 1 do
					local var_398_18 = var_398_15:GetChild(iter_398_5)

					if var_398_18.name == "" or not string.find(var_398_18.name, "split") then
						var_398_18.gameObject:SetActive(true)
					else
						var_398_18.gameObject:SetActive(false)
					end
				end
			end

			local var_398_19 = 0.001

			if var_398_16 <= arg_395_1.time_ and arg_395_1.time_ < var_398_16 + var_398_19 then
				local var_398_20 = (arg_395_1.time_ - var_398_16) / var_398_19
				local var_398_21 = Vector3.New(0, -2000, 0)

				var_398_15.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos104701, var_398_21, var_398_20)
			end

			if arg_395_1.time_ >= var_398_16 + var_398_19 and arg_395_1.time_ < var_398_16 + var_398_19 + arg_398_0 then
				var_398_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_398_22 = 0
			local var_398_23 = 0.325

			if var_398_22 < arg_395_1.time_ and arg_395_1.time_ <= var_398_22 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_24 = arg_395_1:FormatText(StoryNameCfg[7].name)

				arg_395_1.leftNameTxt_.text = var_398_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_25 = arg_395_1:GetWordFromCfg(926021098)
				local var_398_26 = arg_395_1:FormatText(var_398_25.content)

				arg_395_1.text_.text = var_398_26

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_27 = 13
				local var_398_28 = utf8.len(var_398_26)
				local var_398_29 = var_398_27 <= 0 and var_398_23 or var_398_23 * (var_398_28 / var_398_27)

				if var_398_29 > 0 and var_398_23 < var_398_29 then
					arg_395_1.talkMaxDuration = var_398_29

					if var_398_29 + var_398_22 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_29 + var_398_22
					end
				end

				arg_395_1.text_.text = var_398_26
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_30 = math.max(var_398_23, arg_395_1.talkMaxDuration)

			if var_398_22 <= arg_395_1.time_ and arg_395_1.time_ < var_398_22 + var_398_30 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_22) / var_398_30

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_22 + var_398_30 and arg_395_1.time_ < var_398_22 + var_398_30 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play926021099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 926021099
		arg_399_1.duration_ = 8.6

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play926021100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = "ST0108"

			if arg_399_1.bgs_[var_402_0] == nil then
				local var_402_1 = Object.Instantiate(arg_399_1.paintGo_)

				var_402_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_402_0)
				var_402_1.name = var_402_0
				var_402_1.transform.parent = arg_399_1.stage_.transform
				var_402_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_399_1.bgs_[var_402_0] = var_402_1
			end

			local var_402_2 = 2

			if var_402_2 < arg_399_1.time_ and arg_399_1.time_ <= var_402_2 + arg_402_0 then
				local var_402_3 = manager.ui.mainCamera.transform.localPosition
				local var_402_4 = Vector3.New(0, 0, 10) + Vector3.New(var_402_3.x, var_402_3.y, 0)
				local var_402_5 = arg_399_1.bgs_.ST0108

				var_402_5.transform.localPosition = var_402_4
				var_402_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_402_6 = var_402_5:GetComponent("SpriteRenderer")

				if var_402_6 and var_402_6.sprite then
					local var_402_7 = (var_402_5.transform.localPosition - var_402_3).z
					local var_402_8 = manager.ui.mainCameraCom_
					local var_402_9 = 2 * var_402_7 * Mathf.Tan(var_402_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_402_10 = var_402_9 * var_402_8.aspect
					local var_402_11 = var_402_6.sprite.bounds.size.x
					local var_402_12 = var_402_6.sprite.bounds.size.y
					local var_402_13 = var_402_10 / var_402_11
					local var_402_14 = var_402_9 / var_402_12
					local var_402_15 = var_402_14 < var_402_13 and var_402_13 or var_402_14

					var_402_5.transform.localScale = Vector3.New(var_402_15, var_402_15, 0)
				end

				for iter_402_0, iter_402_1 in pairs(arg_399_1.bgs_) do
					if iter_402_0 ~= "ST0108" then
						iter_402_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_402_16 = 0

			if var_402_16 < arg_399_1.time_ and arg_399_1.time_ <= var_402_16 + arg_402_0 then
				arg_399_1.allBtn_.enabled = false
			end

			local var_402_17 = 0.3

			if arg_399_1.time_ >= var_402_16 + var_402_17 and arg_399_1.time_ < var_402_16 + var_402_17 + arg_402_0 then
				arg_399_1.allBtn_.enabled = true
			end

			local var_402_18 = 0

			if var_402_18 < arg_399_1.time_ and arg_399_1.time_ <= var_402_18 + arg_402_0 then
				arg_399_1.mask_.enabled = true
				arg_399_1.mask_.raycastTarget = true

				arg_399_1:SetGaussion(false)
			end

			local var_402_19 = 2

			if var_402_18 <= arg_399_1.time_ and arg_399_1.time_ < var_402_18 + var_402_19 then
				local var_402_20 = (arg_399_1.time_ - var_402_18) / var_402_19
				local var_402_21 = Color.New(0, 0, 0)

				var_402_21.a = Mathf.Lerp(0, 1, var_402_20)
				arg_399_1.mask_.color = var_402_21
			end

			if arg_399_1.time_ >= var_402_18 + var_402_19 and arg_399_1.time_ < var_402_18 + var_402_19 + arg_402_0 then
				local var_402_22 = Color.New(0, 0, 0)

				var_402_22.a = 1
				arg_399_1.mask_.color = var_402_22
			end

			local var_402_23 = 2

			if var_402_23 < arg_399_1.time_ and arg_399_1.time_ <= var_402_23 + arg_402_0 then
				arg_399_1.mask_.enabled = true
				arg_399_1.mask_.raycastTarget = true

				arg_399_1:SetGaussion(false)
			end

			local var_402_24 = 2

			if var_402_23 <= arg_399_1.time_ and arg_399_1.time_ < var_402_23 + var_402_24 then
				local var_402_25 = (arg_399_1.time_ - var_402_23) / var_402_24
				local var_402_26 = Color.New(0, 0, 0)

				var_402_26.a = Mathf.Lerp(1, 0, var_402_25)
				arg_399_1.mask_.color = var_402_26
			end

			if arg_399_1.time_ >= var_402_23 + var_402_24 and arg_399_1.time_ < var_402_23 + var_402_24 + arg_402_0 then
				local var_402_27 = Color.New(0, 0, 0)
				local var_402_28 = 0

				arg_399_1.mask_.enabled = false
				var_402_27.a = var_402_28
				arg_399_1.mask_.color = var_402_27
			end

			local var_402_29 = 0.166666666666667
			local var_402_30 = 1

			if var_402_29 < arg_399_1.time_ and arg_399_1.time_ <= var_402_29 + arg_402_0 then
				local var_402_31 = "stop"
				local var_402_32 = "effect"

				arg_399_1:AudioAction(var_402_31, var_402_32, "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			local var_402_33 = 1.5
			local var_402_34 = 1

			if var_402_33 < arg_399_1.time_ and arg_399_1.time_ <= var_402_33 + arg_402_0 then
				local var_402_35 = "play"
				local var_402_36 = "effect"

				arg_399_1:AudioAction(var_402_35, var_402_36, "se_story_143", "se_story_143_amb_town", "")
			end

			local var_402_37 = 0
			local var_402_38 = 0.433333333333333

			if var_402_37 < arg_399_1.time_ and arg_399_1.time_ <= var_402_37 + arg_402_0 then
				local var_402_39 = "play"
				local var_402_40 = "music"

				arg_399_1:AudioAction(var_402_39, var_402_40, "ui_battle", "ui_battle_stopbgm", "")

				local var_402_41 = ""
				local var_402_42 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_402_42 ~= "" then
					if arg_399_1.bgmTxt_.text ~= var_402_42 and arg_399_1.bgmTxt_.text ~= "" then
						if arg_399_1.bgmTxt2_.text ~= "" then
							arg_399_1.bgmTxt_.text = arg_399_1.bgmTxt2_.text
						end

						arg_399_1.bgmTxt2_.text = var_402_42

						arg_399_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_399_1.bgmTxt_.text = var_402_42
						arg_399_1.bgmTxt2_.text = var_402_42
					end

					if arg_399_1.bgmTimer then
						arg_399_1.bgmTimer:Stop()

						arg_399_1.bgmTimer = nil
					end

					if arg_399_1.settingData.show_music_name == 1 then
						arg_399_1.musicController:SetSelectedState("show")
						arg_399_1.musicAnimator_:Play("open", 0, 0)

						if arg_399_1.settingData.music_time ~= 0 then
							arg_399_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_399_1.settingData.music_time), function()
								if arg_399_1 == nil or isNil(arg_399_1.bgmTxt_) then
									return
								end

								arg_399_1.musicController:SetSelectedState("hide")
								arg_399_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_399_1.frameCnt_ <= 1 then
				arg_399_1.dialog_:SetActive(false)
			end

			local var_402_43 = 3.6
			local var_402_44 = 1.075

			if var_402_43 < arg_399_1.time_ and arg_399_1.time_ <= var_402_43 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0

				arg_399_1.dialog_:SetActive(true)

				arg_399_1.dialogCg_.alpha = 0

				local var_402_45 = LeanTween.value(arg_399_1.dialog_, 0, 1, 0.3)

				var_402_45:setOnUpdate(LuaHelper.FloatAction(function(arg_404_0)
					arg_399_1.dialogCg_.alpha = arg_404_0
				end))
				var_402_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_399_1.dialog_)
					var_402_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_399_1.duration_ = arg_399_1.duration_ + 0.3

				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_46 = arg_399_1:GetWordFromCfg(926021099)
				local var_402_47 = arg_399_1:FormatText(var_402_46.content)

				arg_399_1.text_.text = var_402_47

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_48 = 43
				local var_402_49 = utf8.len(var_402_47)
				local var_402_50 = var_402_48 <= 0 and var_402_44 or var_402_44 * (var_402_49 / var_402_48)

				if var_402_50 > 0 and var_402_44 < var_402_50 then
					arg_399_1.talkMaxDuration = var_402_50
					var_402_43 = var_402_43 + 0.3

					if var_402_50 + var_402_43 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_50 + var_402_43
					end
				end

				arg_399_1.text_.text = var_402_47
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_51 = var_402_43 + 0.3
			local var_402_52 = math.max(var_402_44, arg_399_1.talkMaxDuration)

			if var_402_51 <= arg_399_1.time_ and arg_399_1.time_ < var_402_51 + var_402_52 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_51) / var_402_52

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_51 + var_402_52 and arg_399_1.time_ < var_402_51 + var_402_52 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play926021100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 926021100
		arg_406_1.duration_ = 4.4

		local var_406_0 = {
			zh = 3.533,
			ja = 4.4
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
				arg_406_0:Play926021101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["104701"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.actorSpriteComps104701 == nil then
				arg_406_1.var_.actorSpriteComps104701 = var_409_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_2 = 0.2

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.actorSpriteComps104701 then
					for iter_409_0, iter_409_1 in pairs(arg_406_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_409_1 then
							if arg_406_1.isInRecall_ then
								local var_409_4 = Mathf.Lerp(iter_409_1.color.r, arg_406_1.hightColor1.r, var_409_3)
								local var_409_5 = Mathf.Lerp(iter_409_1.color.g, arg_406_1.hightColor1.g, var_409_3)
								local var_409_6 = Mathf.Lerp(iter_409_1.color.b, arg_406_1.hightColor1.b, var_409_3)

								iter_409_1.color = Color.New(var_409_4, var_409_5, var_409_6)
							else
								local var_409_7 = Mathf.Lerp(iter_409_1.color.r, 1, var_409_3)

								iter_409_1.color = Color.New(var_409_7, var_409_7, var_409_7)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.actorSpriteComps104701 then
				for iter_409_2, iter_409_3 in pairs(arg_406_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_409_3 then
						if arg_406_1.isInRecall_ then
							iter_409_3.color = arg_406_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_409_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_406_1.var_.actorSpriteComps104701 = nil
			end

			local var_409_8 = arg_406_1.actors_["104701"].transform
			local var_409_9 = 0

			if var_409_9 < arg_406_1.time_ and arg_406_1.time_ <= var_409_9 + arg_409_0 then
				arg_406_1.var_.moveOldPos104701 = var_409_8.localPosition
				var_409_8.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("104701", 2)

				local var_409_10 = var_409_8.childCount

				for iter_409_4 = 0, var_409_10 - 1 do
					local var_409_11 = var_409_8:GetChild(iter_409_4)

					if var_409_11.name == "" or not string.find(var_409_11.name, "split") then
						var_409_11.gameObject:SetActive(true)
					else
						var_409_11.gameObject:SetActive(false)
					end
				end
			end

			local var_409_12 = 0.001

			if var_409_9 <= arg_406_1.time_ and arg_406_1.time_ < var_409_9 + var_409_12 then
				local var_409_13 = (arg_406_1.time_ - var_409_9) / var_409_12
				local var_409_14 = Vector3.New(-528.7, -386.8, -295)

				var_409_8.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos104701, var_409_14, var_409_13)
			end

			if arg_406_1.time_ >= var_409_9 + var_409_12 and arg_406_1.time_ < var_409_9 + var_409_12 + arg_409_0 then
				var_409_8.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			local var_409_15 = 0
			local var_409_16 = 0.35

			if var_409_15 < arg_406_1.time_ and arg_406_1.time_ <= var_409_15 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_17 = arg_406_1:FormatText(StoryNameCfg[1296].name)

				arg_406_1.leftNameTxt_.text = var_409_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_18 = arg_406_1:GetWordFromCfg(926021100)
				local var_409_19 = arg_406_1:FormatText(var_409_18.content)

				arg_406_1.text_.text = var_409_19

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_20 = 14
				local var_409_21 = utf8.len(var_409_19)
				local var_409_22 = var_409_20 <= 0 and var_409_16 or var_409_16 * (var_409_21 / var_409_20)

				if var_409_22 > 0 and var_409_16 < var_409_22 then
					arg_406_1.talkMaxDuration = var_409_22

					if var_409_22 + var_409_15 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_22 + var_409_15
					end
				end

				arg_406_1.text_.text = var_409_19
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021100", "story_v_out_926021.awb") ~= 0 then
					local var_409_23 = manager.audio:GetVoiceLength("story_v_out_926021", "926021100", "story_v_out_926021.awb") / 1000

					if var_409_23 + var_409_15 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_23 + var_409_15
					end

					if var_409_18.prefab_name ~= "" and arg_406_1.actors_[var_409_18.prefab_name] ~= nil then
						local var_409_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_18.prefab_name].transform, "story_v_out_926021", "926021100", "story_v_out_926021.awb")

						arg_406_1:RecordAudio("926021100", var_409_24)
						arg_406_1:RecordAudio("926021100", var_409_24)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_926021", "926021100", "story_v_out_926021.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_926021", "926021100", "story_v_out_926021.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_25 = math.max(var_409_16, arg_406_1.talkMaxDuration)

			if var_409_15 <= arg_406_1.time_ and arg_406_1.time_ < var_409_15 + var_409_25 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_15) / var_409_25

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_15 + var_409_25 and arg_406_1.time_ < var_409_15 + var_409_25 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
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
	Play926021101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 926021101
		arg_410_1.duration_ = 3.23

		local var_410_0 = {
			zh = 2.166,
			ja = 3.233
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
				arg_410_0:Play926021102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["10144"]
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.actorSpriteComps10144 == nil then
				arg_410_1.var_.actorSpriteComps10144 = var_413_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_2 = 0.2

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 and not isNil(var_413_0) then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2

				if arg_410_1.var_.actorSpriteComps10144 then
					for iter_413_0, iter_413_1 in pairs(arg_410_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_413_1 then
							if arg_410_1.isInRecall_ then
								local var_413_4 = Mathf.Lerp(iter_413_1.color.r, arg_410_1.hightColor1.r, var_413_3)
								local var_413_5 = Mathf.Lerp(iter_413_1.color.g, arg_410_1.hightColor1.g, var_413_3)
								local var_413_6 = Mathf.Lerp(iter_413_1.color.b, arg_410_1.hightColor1.b, var_413_3)

								iter_413_1.color = Color.New(var_413_4, var_413_5, var_413_6)
							else
								local var_413_7 = Mathf.Lerp(iter_413_1.color.r, 1, var_413_3)

								iter_413_1.color = Color.New(var_413_7, var_413_7, var_413_7)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.actorSpriteComps10144 then
				for iter_413_2, iter_413_3 in pairs(arg_410_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_413_3 then
						if arg_410_1.isInRecall_ then
							iter_413_3.color = arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_413_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_410_1.var_.actorSpriteComps10144 = nil
			end

			local var_413_8 = arg_410_1.actors_["104701"]
			local var_413_9 = 0

			if var_413_9 < arg_410_1.time_ and arg_410_1.time_ <= var_413_9 + arg_413_0 and not isNil(var_413_8) and arg_410_1.var_.actorSpriteComps104701 == nil then
				arg_410_1.var_.actorSpriteComps104701 = var_413_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_10 = 0.2

			if var_413_9 <= arg_410_1.time_ and arg_410_1.time_ < var_413_9 + var_413_10 and not isNil(var_413_8) then
				local var_413_11 = (arg_410_1.time_ - var_413_9) / var_413_10

				if arg_410_1.var_.actorSpriteComps104701 then
					for iter_413_4, iter_413_5 in pairs(arg_410_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_413_5 then
							if arg_410_1.isInRecall_ then
								local var_413_12 = Mathf.Lerp(iter_413_5.color.r, arg_410_1.hightColor2.r, var_413_11)
								local var_413_13 = Mathf.Lerp(iter_413_5.color.g, arg_410_1.hightColor2.g, var_413_11)
								local var_413_14 = Mathf.Lerp(iter_413_5.color.b, arg_410_1.hightColor2.b, var_413_11)

								iter_413_5.color = Color.New(var_413_12, var_413_13, var_413_14)
							else
								local var_413_15 = Mathf.Lerp(iter_413_5.color.r, 0.5, var_413_11)

								iter_413_5.color = Color.New(var_413_15, var_413_15, var_413_15)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= var_413_9 + var_413_10 and arg_410_1.time_ < var_413_9 + var_413_10 + arg_413_0 and not isNil(var_413_8) and arg_410_1.var_.actorSpriteComps104701 then
				for iter_413_6, iter_413_7 in pairs(arg_410_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_413_7 then
						if arg_410_1.isInRecall_ then
							iter_413_7.color = arg_410_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_413_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_410_1.var_.actorSpriteComps104701 = nil
			end

			local var_413_16 = arg_410_1.actors_["10144"].transform
			local var_413_17 = 0

			if var_413_17 < arg_410_1.time_ and arg_410_1.time_ <= var_413_17 + arg_413_0 then
				arg_410_1.var_.moveOldPos10144 = var_413_16.localPosition
				var_413_16.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("10144", 4)

				local var_413_18 = var_413_16.childCount

				for iter_413_8 = 0, var_413_18 - 1 do
					local var_413_19 = var_413_16:GetChild(iter_413_8)

					if var_413_19.name == "" or not string.find(var_413_19.name, "split") then
						var_413_19.gameObject:SetActive(true)
					else
						var_413_19.gameObject:SetActive(false)
					end
				end
			end

			local var_413_20 = 0.001

			if var_413_17 <= arg_410_1.time_ and arg_410_1.time_ < var_413_17 + var_413_20 then
				local var_413_21 = (arg_410_1.time_ - var_413_17) / var_413_20
				local var_413_22 = Vector3.New(435.8, -381.1, -285.9)

				var_413_16.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos10144, var_413_22, var_413_21)
			end

			if arg_410_1.time_ >= var_413_17 + var_413_20 and arg_410_1.time_ < var_413_17 + var_413_20 + arg_413_0 then
				var_413_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_413_23 = 0
			local var_413_24 = 0.275

			if var_413_23 < arg_410_1.time_ and arg_410_1.time_ <= var_413_23 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_25 = arg_410_1:FormatText(StoryNameCfg[1297].name)

				arg_410_1.leftNameTxt_.text = var_413_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_26 = arg_410_1:GetWordFromCfg(926021101)
				local var_413_27 = arg_410_1:FormatText(var_413_26.content)

				arg_410_1.text_.text = var_413_27

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_28 = 11
				local var_413_29 = utf8.len(var_413_27)
				local var_413_30 = var_413_28 <= 0 and var_413_24 or var_413_24 * (var_413_29 / var_413_28)

				if var_413_30 > 0 and var_413_24 < var_413_30 then
					arg_410_1.talkMaxDuration = var_413_30

					if var_413_30 + var_413_23 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_30 + var_413_23
					end
				end

				arg_410_1.text_.text = var_413_27
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021101", "story_v_out_926021.awb") ~= 0 then
					local var_413_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021101", "story_v_out_926021.awb") / 1000

					if var_413_31 + var_413_23 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_31 + var_413_23
					end

					if var_413_26.prefab_name ~= "" and arg_410_1.actors_[var_413_26.prefab_name] ~= nil then
						local var_413_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_26.prefab_name].transform, "story_v_out_926021", "926021101", "story_v_out_926021.awb")

						arg_410_1:RecordAudio("926021101", var_413_32)
						arg_410_1:RecordAudio("926021101", var_413_32)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_926021", "926021101", "story_v_out_926021.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_926021", "926021101", "story_v_out_926021.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_33 = math.max(var_413_24, arg_410_1.talkMaxDuration)

			if var_413_23 <= arg_410_1.time_ and arg_410_1.time_ < var_413_23 + var_413_33 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_23) / var_413_33

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_23 + var_413_33 and arg_410_1.time_ < var_413_23 + var_413_33 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926021102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 926021102
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play926021103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["10144"]
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.actorSpriteComps10144 == nil then
				arg_414_1.var_.actorSpriteComps10144 = var_417_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_2 = 0.2

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 and not isNil(var_417_0) then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2

				if arg_414_1.var_.actorSpriteComps10144 then
					for iter_417_0, iter_417_1 in pairs(arg_414_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.actorSpriteComps10144 then
				for iter_417_2, iter_417_3 in pairs(arg_414_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_417_3 then
						if arg_414_1.isInRecall_ then
							iter_417_3.color = arg_414_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_417_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_414_1.var_.actorSpriteComps10144 = nil
			end

			local var_417_8 = 0
			local var_417_9 = 0.275

			if var_417_8 < arg_414_1.time_ and arg_414_1.time_ <= var_417_8 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_10 = arg_414_1:FormatText(StoryNameCfg[7].name)

				arg_414_1.leftNameTxt_.text = var_417_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_11 = arg_414_1:GetWordFromCfg(926021102)
				local var_417_12 = arg_414_1:FormatText(var_417_11.content)

				arg_414_1.text_.text = var_417_12

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_13 = 11
				local var_417_14 = utf8.len(var_417_12)
				local var_417_15 = var_417_13 <= 0 and var_417_9 or var_417_9 * (var_417_14 / var_417_13)

				if var_417_15 > 0 and var_417_9 < var_417_15 then
					arg_414_1.talkMaxDuration = var_417_15

					if var_417_15 + var_417_8 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_15 + var_417_8
					end
				end

				arg_414_1.text_.text = var_417_12
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_16 = math.max(var_417_9, arg_414_1.talkMaxDuration)

			if var_417_8 <= arg_414_1.time_ and arg_414_1.time_ < var_417_8 + var_417_16 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_8) / var_417_16

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_8 + var_417_16 and arg_414_1.time_ < var_417_8 + var_417_16 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play926021103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 926021103
		arg_418_1.duration_ = 6.8

		local var_418_0 = {
			zh = 3.733,
			ja = 6.8
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
				arg_418_0:Play926021104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["10144"]
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.actorSpriteComps10144 == nil then
				arg_418_1.var_.actorSpriteComps10144 = var_421_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_421_2 = 0.2

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 and not isNil(var_421_0) then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2

				if arg_418_1.var_.actorSpriteComps10144 then
					for iter_421_0, iter_421_1 in pairs(arg_418_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.actorSpriteComps10144 then
				for iter_421_2, iter_421_3 in pairs(arg_418_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_421_3 then
						if arg_418_1.isInRecall_ then
							iter_421_3.color = arg_418_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_421_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_418_1.var_.actorSpriteComps10144 = nil
			end

			local var_421_8 = 0
			local var_421_9 = 0.45

			if var_421_8 < arg_418_1.time_ and arg_418_1.time_ <= var_421_8 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_10 = arg_418_1:FormatText(StoryNameCfg[1297].name)

				arg_418_1.leftNameTxt_.text = var_421_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_11 = arg_418_1:GetWordFromCfg(926021103)
				local var_421_12 = arg_418_1:FormatText(var_421_11.content)

				arg_418_1.text_.text = var_421_12

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_13 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021103", "story_v_out_926021.awb") ~= 0 then
					local var_421_16 = manager.audio:GetVoiceLength("story_v_out_926021", "926021103", "story_v_out_926021.awb") / 1000

					if var_421_16 + var_421_8 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_16 + var_421_8
					end

					if var_421_11.prefab_name ~= "" and arg_418_1.actors_[var_421_11.prefab_name] ~= nil then
						local var_421_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_11.prefab_name].transform, "story_v_out_926021", "926021103", "story_v_out_926021.awb")

						arg_418_1:RecordAudio("926021103", var_421_17)
						arg_418_1:RecordAudio("926021103", var_421_17)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_926021", "926021103", "story_v_out_926021.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_926021", "926021103", "story_v_out_926021.awb")
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
	Play926021104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 926021104
		arg_422_1.duration_ = 6.93

		local var_422_0 = {
			zh = 3.333,
			ja = 6.933
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
				arg_422_0:Play926021105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["104701"]
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.actorSpriteComps104701 == nil then
				arg_422_1.var_.actorSpriteComps104701 = var_425_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_2 = 0.2

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 and not isNil(var_425_0) then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2

				if arg_422_1.var_.actorSpriteComps104701 then
					for iter_425_0, iter_425_1 in pairs(arg_422_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_425_1 then
							if arg_422_1.isInRecall_ then
								local var_425_4 = Mathf.Lerp(iter_425_1.color.r, arg_422_1.hightColor1.r, var_425_3)
								local var_425_5 = Mathf.Lerp(iter_425_1.color.g, arg_422_1.hightColor1.g, var_425_3)
								local var_425_6 = Mathf.Lerp(iter_425_1.color.b, arg_422_1.hightColor1.b, var_425_3)

								iter_425_1.color = Color.New(var_425_4, var_425_5, var_425_6)
							else
								local var_425_7 = Mathf.Lerp(iter_425_1.color.r, 1, var_425_3)

								iter_425_1.color = Color.New(var_425_7, var_425_7, var_425_7)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.actorSpriteComps104701 then
				for iter_425_2, iter_425_3 in pairs(arg_422_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_425_3 then
						if arg_422_1.isInRecall_ then
							iter_425_3.color = arg_422_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_425_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_422_1.var_.actorSpriteComps104701 = nil
			end

			local var_425_8 = arg_422_1.actors_["10144"]
			local var_425_9 = 0

			if var_425_9 < arg_422_1.time_ and arg_422_1.time_ <= var_425_9 + arg_425_0 and not isNil(var_425_8) and arg_422_1.var_.actorSpriteComps10144 == nil then
				arg_422_1.var_.actorSpriteComps10144 = var_425_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_10 = 0.2

			if var_425_9 <= arg_422_1.time_ and arg_422_1.time_ < var_425_9 + var_425_10 and not isNil(var_425_8) then
				local var_425_11 = (arg_422_1.time_ - var_425_9) / var_425_10

				if arg_422_1.var_.actorSpriteComps10144 then
					for iter_425_4, iter_425_5 in pairs(arg_422_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_425_5 then
							if arg_422_1.isInRecall_ then
								local var_425_12 = Mathf.Lerp(iter_425_5.color.r, arg_422_1.hightColor2.r, var_425_11)
								local var_425_13 = Mathf.Lerp(iter_425_5.color.g, arg_422_1.hightColor2.g, var_425_11)
								local var_425_14 = Mathf.Lerp(iter_425_5.color.b, arg_422_1.hightColor2.b, var_425_11)

								iter_425_5.color = Color.New(var_425_12, var_425_13, var_425_14)
							else
								local var_425_15 = Mathf.Lerp(iter_425_5.color.r, 0.5, var_425_11)

								iter_425_5.color = Color.New(var_425_15, var_425_15, var_425_15)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= var_425_9 + var_425_10 and arg_422_1.time_ < var_425_9 + var_425_10 + arg_425_0 and not isNil(var_425_8) and arg_422_1.var_.actorSpriteComps10144 then
				for iter_425_6, iter_425_7 in pairs(arg_422_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_425_7 then
						if arg_422_1.isInRecall_ then
							iter_425_7.color = arg_422_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_425_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_422_1.var_.actorSpriteComps10144 = nil
			end

			local var_425_16 = 0
			local var_425_17 = 0.425

			if var_425_16 < arg_422_1.time_ and arg_422_1.time_ <= var_425_16 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_18 = arg_422_1:FormatText(StoryNameCfg[1296].name)

				arg_422_1.leftNameTxt_.text = var_425_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_19 = arg_422_1:GetWordFromCfg(926021104)
				local var_425_20 = arg_422_1:FormatText(var_425_19.content)

				arg_422_1.text_.text = var_425_20

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_21 = 17
				local var_425_22 = utf8.len(var_425_20)
				local var_425_23 = var_425_21 <= 0 and var_425_17 or var_425_17 * (var_425_22 / var_425_21)

				if var_425_23 > 0 and var_425_17 < var_425_23 then
					arg_422_1.talkMaxDuration = var_425_23

					if var_425_23 + var_425_16 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_23 + var_425_16
					end
				end

				arg_422_1.text_.text = var_425_20
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021104", "story_v_out_926021.awb") ~= 0 then
					local var_425_24 = manager.audio:GetVoiceLength("story_v_out_926021", "926021104", "story_v_out_926021.awb") / 1000

					if var_425_24 + var_425_16 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_24 + var_425_16
					end

					if var_425_19.prefab_name ~= "" and arg_422_1.actors_[var_425_19.prefab_name] ~= nil then
						local var_425_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_19.prefab_name].transform, "story_v_out_926021", "926021104", "story_v_out_926021.awb")

						arg_422_1:RecordAudio("926021104", var_425_25)
						arg_422_1:RecordAudio("926021104", var_425_25)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_926021", "926021104", "story_v_out_926021.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_926021", "926021104", "story_v_out_926021.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_26 = math.max(var_425_17, arg_422_1.talkMaxDuration)

			if var_425_16 <= arg_422_1.time_ and arg_422_1.time_ < var_425_16 + var_425_26 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_16) / var_425_26

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_16 + var_425_26 and arg_422_1.time_ < var_425_16 + var_425_26 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play926021105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 926021105
		arg_426_1.duration_ = 6

		local var_426_0 = {
			zh = 5.066,
			ja = 6
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
				arg_426_0:Play926021106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["10144"]
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.actorSpriteComps10144 == nil then
				arg_426_1.var_.actorSpriteComps10144 = var_429_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_429_2 = 0.2

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 and not isNil(var_429_0) then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2

				if arg_426_1.var_.actorSpriteComps10144 then
					for iter_429_0, iter_429_1 in pairs(arg_426_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_429_1 then
							if arg_426_1.isInRecall_ then
								local var_429_4 = Mathf.Lerp(iter_429_1.color.r, arg_426_1.hightColor1.r, var_429_3)
								local var_429_5 = Mathf.Lerp(iter_429_1.color.g, arg_426_1.hightColor1.g, var_429_3)
								local var_429_6 = Mathf.Lerp(iter_429_1.color.b, arg_426_1.hightColor1.b, var_429_3)

								iter_429_1.color = Color.New(var_429_4, var_429_5, var_429_6)
							else
								local var_429_7 = Mathf.Lerp(iter_429_1.color.r, 1, var_429_3)

								iter_429_1.color = Color.New(var_429_7, var_429_7, var_429_7)
							end
						end
					end
				end
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.actorSpriteComps10144 then
				for iter_429_2, iter_429_3 in pairs(arg_426_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_429_3 then
						if arg_426_1.isInRecall_ then
							iter_429_3.color = arg_426_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_429_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_426_1.var_.actorSpriteComps10144 = nil
			end

			local var_429_8 = arg_426_1.actors_["104701"]
			local var_429_9 = 0

			if var_429_9 < arg_426_1.time_ and arg_426_1.time_ <= var_429_9 + arg_429_0 and not isNil(var_429_8) and arg_426_1.var_.actorSpriteComps104701 == nil then
				arg_426_1.var_.actorSpriteComps104701 = var_429_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_429_10 = 0.2

			if var_429_9 <= arg_426_1.time_ and arg_426_1.time_ < var_429_9 + var_429_10 and not isNil(var_429_8) then
				local var_429_11 = (arg_426_1.time_ - var_429_9) / var_429_10

				if arg_426_1.var_.actorSpriteComps104701 then
					for iter_429_4, iter_429_5 in pairs(arg_426_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_429_5 then
							if arg_426_1.isInRecall_ then
								local var_429_12 = Mathf.Lerp(iter_429_5.color.r, arg_426_1.hightColor2.r, var_429_11)
								local var_429_13 = Mathf.Lerp(iter_429_5.color.g, arg_426_1.hightColor2.g, var_429_11)
								local var_429_14 = Mathf.Lerp(iter_429_5.color.b, arg_426_1.hightColor2.b, var_429_11)

								iter_429_5.color = Color.New(var_429_12, var_429_13, var_429_14)
							else
								local var_429_15 = Mathf.Lerp(iter_429_5.color.r, 0.5, var_429_11)

								iter_429_5.color = Color.New(var_429_15, var_429_15, var_429_15)
							end
						end
					end
				end
			end

			if arg_426_1.time_ >= var_429_9 + var_429_10 and arg_426_1.time_ < var_429_9 + var_429_10 + arg_429_0 and not isNil(var_429_8) and arg_426_1.var_.actorSpriteComps104701 then
				for iter_429_6, iter_429_7 in pairs(arg_426_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_429_7 then
						if arg_426_1.isInRecall_ then
							iter_429_7.color = arg_426_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_429_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_426_1.var_.actorSpriteComps104701 = nil
			end

			local var_429_16 = arg_426_1.actors_["10144"].transform
			local var_429_17 = 0

			if var_429_17 < arg_426_1.time_ and arg_426_1.time_ <= var_429_17 + arg_429_0 then
				arg_426_1.var_.moveOldPos10144 = var_429_16.localPosition
				var_429_16.localScale = Vector3.New(1, 1, 1)

				arg_426_1:CheckSpriteTmpPos("10144", 4)

				local var_429_18 = var_429_16.childCount

				for iter_429_8 = 0, var_429_18 - 1 do
					local var_429_19 = var_429_16:GetChild(iter_429_8)

					if var_429_19.name == "split_2" or not string.find(var_429_19.name, "split") then
						var_429_19.gameObject:SetActive(true)
					else
						var_429_19.gameObject:SetActive(false)
					end
				end
			end

			local var_429_20 = 0.001

			if var_429_17 <= arg_426_1.time_ and arg_426_1.time_ < var_429_17 + var_429_20 then
				local var_429_21 = (arg_426_1.time_ - var_429_17) / var_429_20
				local var_429_22 = Vector3.New(435.8, -381.1, -285.9)

				var_429_16.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos10144, var_429_22, var_429_21)
			end

			if arg_426_1.time_ >= var_429_17 + var_429_20 and arg_426_1.time_ < var_429_17 + var_429_20 + arg_429_0 then
				var_429_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_429_23 = 0
			local var_429_24 = 0.675

			if var_429_23 < arg_426_1.time_ and arg_426_1.time_ <= var_429_23 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_25 = arg_426_1:FormatText(StoryNameCfg[1297].name)

				arg_426_1.leftNameTxt_.text = var_429_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_26 = arg_426_1:GetWordFromCfg(926021105)
				local var_429_27 = arg_426_1:FormatText(var_429_26.content)

				arg_426_1.text_.text = var_429_27

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_28 = 27
				local var_429_29 = utf8.len(var_429_27)
				local var_429_30 = var_429_28 <= 0 and var_429_24 or var_429_24 * (var_429_29 / var_429_28)

				if var_429_30 > 0 and var_429_24 < var_429_30 then
					arg_426_1.talkMaxDuration = var_429_30

					if var_429_30 + var_429_23 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_30 + var_429_23
					end
				end

				arg_426_1.text_.text = var_429_27
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021105", "story_v_out_926021.awb") ~= 0 then
					local var_429_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021105", "story_v_out_926021.awb") / 1000

					if var_429_31 + var_429_23 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_31 + var_429_23
					end

					if var_429_26.prefab_name ~= "" and arg_426_1.actors_[var_429_26.prefab_name] ~= nil then
						local var_429_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_26.prefab_name].transform, "story_v_out_926021", "926021105", "story_v_out_926021.awb")

						arg_426_1:RecordAudio("926021105", var_429_32)
						arg_426_1:RecordAudio("926021105", var_429_32)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_926021", "926021105", "story_v_out_926021.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_926021", "926021105", "story_v_out_926021.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_33 = math.max(var_429_24, arg_426_1.talkMaxDuration)

			if var_429_23 <= arg_426_1.time_ and arg_426_1.time_ < var_429_23 + var_429_33 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_23) / var_429_33

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_23 + var_429_33 and arg_426_1.time_ < var_429_23 + var_429_33 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play926021106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 926021106
		arg_430_1.duration_ = 4.53

		local var_430_0 = {
			zh = 4.533,
			ja = 3.533
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
				arg_430_0:Play926021107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["106103"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.actorSpriteComps106103 == nil then
				arg_430_1.var_.actorSpriteComps106103 = var_433_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_2 = 0.2

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.actorSpriteComps106103 then
					for iter_433_0, iter_433_1 in pairs(arg_430_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_433_1 then
							if arg_430_1.isInRecall_ then
								local var_433_4 = Mathf.Lerp(iter_433_1.color.r, arg_430_1.hightColor1.r, var_433_3)
								local var_433_5 = Mathf.Lerp(iter_433_1.color.g, arg_430_1.hightColor1.g, var_433_3)
								local var_433_6 = Mathf.Lerp(iter_433_1.color.b, arg_430_1.hightColor1.b, var_433_3)

								iter_433_1.color = Color.New(var_433_4, var_433_5, var_433_6)
							else
								local var_433_7 = Mathf.Lerp(iter_433_1.color.r, 1, var_433_3)

								iter_433_1.color = Color.New(var_433_7, var_433_7, var_433_7)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.actorSpriteComps106103 then
				for iter_433_2, iter_433_3 in pairs(arg_430_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_433_3 then
						if arg_430_1.isInRecall_ then
							iter_433_3.color = arg_430_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_433_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_430_1.var_.actorSpriteComps106103 = nil
			end

			local var_433_8 = arg_430_1.actors_["10144"]
			local var_433_9 = 0

			if var_433_9 < arg_430_1.time_ and arg_430_1.time_ <= var_433_9 + arg_433_0 and not isNil(var_433_8) and arg_430_1.var_.actorSpriteComps10144 == nil then
				arg_430_1.var_.actorSpriteComps10144 = var_433_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_10 = 0.2

			if var_433_9 <= arg_430_1.time_ and arg_430_1.time_ < var_433_9 + var_433_10 and not isNil(var_433_8) then
				local var_433_11 = (arg_430_1.time_ - var_433_9) / var_433_10

				if arg_430_1.var_.actorSpriteComps10144 then
					for iter_433_4, iter_433_5 in pairs(arg_430_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_433_5 then
							if arg_430_1.isInRecall_ then
								local var_433_12 = Mathf.Lerp(iter_433_5.color.r, arg_430_1.hightColor2.r, var_433_11)
								local var_433_13 = Mathf.Lerp(iter_433_5.color.g, arg_430_1.hightColor2.g, var_433_11)
								local var_433_14 = Mathf.Lerp(iter_433_5.color.b, arg_430_1.hightColor2.b, var_433_11)

								iter_433_5.color = Color.New(var_433_12, var_433_13, var_433_14)
							else
								local var_433_15 = Mathf.Lerp(iter_433_5.color.r, 0.5, var_433_11)

								iter_433_5.color = Color.New(var_433_15, var_433_15, var_433_15)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= var_433_9 + var_433_10 and arg_430_1.time_ < var_433_9 + var_433_10 + arg_433_0 and not isNil(var_433_8) and arg_430_1.var_.actorSpriteComps10144 then
				for iter_433_6, iter_433_7 in pairs(arg_430_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_433_7 then
						if arg_430_1.isInRecall_ then
							iter_433_7.color = arg_430_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_433_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_430_1.var_.actorSpriteComps10144 = nil
			end

			local var_433_16 = arg_430_1.actors_["10144"].transform
			local var_433_17 = 0

			if var_433_17 < arg_430_1.time_ and arg_430_1.time_ <= var_433_17 + arg_433_0 then
				arg_430_1.var_.moveOldPos10144 = var_433_16.localPosition
				var_433_16.localScale = Vector3.New(1, 1, 1)

				arg_430_1:CheckSpriteTmpPos("10144", 7)

				local var_433_18 = var_433_16.childCount

				for iter_433_8 = 0, var_433_18 - 1 do
					local var_433_19 = var_433_16:GetChild(iter_433_8)

					if var_433_19.name == "" or not string.find(var_433_19.name, "split") then
						var_433_19.gameObject:SetActive(true)
					else
						var_433_19.gameObject:SetActive(false)
					end
				end
			end

			local var_433_20 = 0.001

			if var_433_17 <= arg_430_1.time_ and arg_430_1.time_ < var_433_17 + var_433_20 then
				local var_433_21 = (arg_430_1.time_ - var_433_17) / var_433_20
				local var_433_22 = Vector3.New(0, -2000, 0)

				var_433_16.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos10144, var_433_22, var_433_21)
			end

			if arg_430_1.time_ >= var_433_17 + var_433_20 and arg_430_1.time_ < var_433_17 + var_433_20 + arg_433_0 then
				var_433_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_433_23 = arg_430_1.actors_["104701"].transform
			local var_433_24 = 0

			if var_433_24 < arg_430_1.time_ and arg_430_1.time_ <= var_433_24 + arg_433_0 then
				arg_430_1.var_.moveOldPos104701 = var_433_23.localPosition
				var_433_23.localScale = Vector3.New(1, 1, 1)

				arg_430_1:CheckSpriteTmpPos("104701", 7)

				local var_433_25 = var_433_23.childCount

				for iter_433_9 = 0, var_433_25 - 1 do
					local var_433_26 = var_433_23:GetChild(iter_433_9)

					if var_433_26.name == "" or not string.find(var_433_26.name, "split") then
						var_433_26.gameObject:SetActive(true)
					else
						var_433_26.gameObject:SetActive(false)
					end
				end
			end

			local var_433_27 = 0.001

			if var_433_24 <= arg_430_1.time_ and arg_430_1.time_ < var_433_24 + var_433_27 then
				local var_433_28 = (arg_430_1.time_ - var_433_24) / var_433_27
				local var_433_29 = Vector3.New(0, -2000, 0)

				var_433_23.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos104701, var_433_29, var_433_28)
			end

			if arg_430_1.time_ >= var_433_24 + var_433_27 and arg_430_1.time_ < var_433_24 + var_433_27 + arg_433_0 then
				var_433_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_433_30 = arg_430_1.actors_["106103"].transform
			local var_433_31 = 0

			if var_433_31 < arg_430_1.time_ and arg_430_1.time_ <= var_433_31 + arg_433_0 then
				arg_430_1.var_.moveOldPos106103 = var_433_30.localPosition
				var_433_30.localScale = Vector3.New(1, 1, 1)

				arg_430_1:CheckSpriteTmpPos("106103", 7)

				local var_433_32 = var_433_30.childCount

				for iter_433_10 = 0, var_433_32 - 1 do
					local var_433_33 = var_433_30:GetChild(iter_433_10)

					if var_433_33.name == "split_4" or not string.find(var_433_33.name, "split") then
						var_433_33.gameObject:SetActive(true)
					else
						var_433_33.gameObject:SetActive(false)
					end
				end
			end

			local var_433_34 = 0.1

			if var_433_31 <= arg_430_1.time_ and arg_430_1.time_ < var_433_31 + var_433_34 then
				local var_433_35 = (arg_430_1.time_ - var_433_31) / var_433_34
				local var_433_36 = Vector3.New(0, -2000, 0)

				var_433_30.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos106103, var_433_36, var_433_35)
			end

			if arg_430_1.time_ >= var_433_31 + var_433_34 and arg_430_1.time_ < var_433_31 + var_433_34 + arg_433_0 then
				var_433_30.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_433_37 = 0
			local var_433_38 = 0.25

			if var_433_37 < arg_430_1.time_ and arg_430_1.time_ <= var_433_37 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0

				arg_430_1.dialog_:SetActive(true)

				arg_430_1.dialogCg_.alpha = 0

				local var_433_39 = LeanTween.value(arg_430_1.dialog_, 0, 1, 0.3)

				var_433_39:setOnUpdate(LuaHelper.FloatAction(function(arg_434_0)
					arg_430_1.dialogCg_.alpha = arg_434_0
				end))
				var_433_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_430_1.dialog_)
					var_433_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_430_1.duration_ = arg_430_1.duration_ + 0.3

				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_40 = arg_430_1:FormatText(StoryNameCfg[612].name)

				arg_430_1.leftNameTxt_.text = var_433_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_4")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_41 = arg_430_1:GetWordFromCfg(926021106)
				local var_433_42 = arg_430_1:FormatText(var_433_41.content)

				arg_430_1.text_.text = var_433_42

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_43 = 10
				local var_433_44 = utf8.len(var_433_42)
				local var_433_45 = var_433_43 <= 0 and var_433_38 or var_433_38 * (var_433_44 / var_433_43)

				if var_433_45 > 0 and var_433_38 < var_433_45 then
					arg_430_1.talkMaxDuration = var_433_45
					var_433_37 = var_433_37 + 0.3

					if var_433_45 + var_433_37 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_45 + var_433_37
					end
				end

				arg_430_1.text_.text = var_433_42
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021106", "story_v_out_926021.awb") ~= 0 then
					local var_433_46 = manager.audio:GetVoiceLength("story_v_out_926021", "926021106", "story_v_out_926021.awb") / 1000

					if var_433_46 + var_433_37 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_46 + var_433_37
					end

					if var_433_41.prefab_name ~= "" and arg_430_1.actors_[var_433_41.prefab_name] ~= nil then
						local var_433_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_41.prefab_name].transform, "story_v_out_926021", "926021106", "story_v_out_926021.awb")

						arg_430_1:RecordAudio("926021106", var_433_47)
						arg_430_1:RecordAudio("926021106", var_433_47)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_926021", "926021106", "story_v_out_926021.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_926021", "926021106", "story_v_out_926021.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_48 = var_433_37 + 0.3
			local var_433_49 = math.max(var_433_38, arg_430_1.talkMaxDuration)

			if var_433_48 <= arg_430_1.time_ and arg_430_1.time_ < var_433_48 + var_433_49 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_48) / var_433_49

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_48 + var_433_49 and arg_430_1.time_ < var_433_48 + var_433_49 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play926021107 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 926021107
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play926021108(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0.166666666666667
			local var_439_1 = 1

			if var_439_0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_0 + arg_439_0 then
				local var_439_2 = "play"
				local var_439_3 = "effect"

				arg_436_1:AudioAction(var_439_2, var_439_3, "se_story_143", "se_story_143_walk01", "")
			end

			local var_439_4 = 0
			local var_439_5 = 1.45

			if var_439_4 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_6 = arg_436_1:GetWordFromCfg(926021107)
				local var_439_7 = arg_436_1:FormatText(var_439_6.content)

				arg_436_1.text_.text = var_439_7

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_8 = 58
				local var_439_9 = utf8.len(var_439_7)
				local var_439_10 = var_439_8 <= 0 and var_439_5 or var_439_5 * (var_439_9 / var_439_8)

				if var_439_10 > 0 and var_439_5 < var_439_10 then
					arg_436_1.talkMaxDuration = var_439_10

					if var_439_10 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_10 + var_439_4
					end
				end

				arg_436_1.text_.text = var_439_7
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_11 = math.max(var_439_5, arg_436_1.talkMaxDuration)

			if var_439_4 <= arg_436_1.time_ and arg_436_1.time_ < var_439_4 + var_439_11 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_4) / var_439_11

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_4 + var_439_11 and arg_436_1.time_ < var_439_4 + var_439_11 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play926021108 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 926021108
		arg_440_1.duration_ = 5.63

		local var_440_0 = {
			zh = 3.433,
			ja = 5.633
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play926021109(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["10144"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.actorSpriteComps10144 == nil then
				arg_440_1.var_.actorSpriteComps10144 = var_443_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_2 = 0.2

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.actorSpriteComps10144 then
					for iter_443_0, iter_443_1 in pairs(arg_440_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_443_1 then
							if arg_440_1.isInRecall_ then
								local var_443_4 = Mathf.Lerp(iter_443_1.color.r, arg_440_1.hightColor1.r, var_443_3)
								local var_443_5 = Mathf.Lerp(iter_443_1.color.g, arg_440_1.hightColor1.g, var_443_3)
								local var_443_6 = Mathf.Lerp(iter_443_1.color.b, arg_440_1.hightColor1.b, var_443_3)

								iter_443_1.color = Color.New(var_443_4, var_443_5, var_443_6)
							else
								local var_443_7 = Mathf.Lerp(iter_443_1.color.r, 1, var_443_3)

								iter_443_1.color = Color.New(var_443_7, var_443_7, var_443_7)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.actorSpriteComps10144 then
				for iter_443_2, iter_443_3 in pairs(arg_440_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_443_3 then
						if arg_440_1.isInRecall_ then
							iter_443_3.color = arg_440_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_443_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_440_1.var_.actorSpriteComps10144 = nil
			end

			local var_443_8 = arg_440_1.actors_["10144"].transform
			local var_443_9 = 0

			if var_443_9 < arg_440_1.time_ and arg_440_1.time_ <= var_443_9 + arg_443_0 then
				arg_440_1.var_.moveOldPos10144 = var_443_8.localPosition
				var_443_8.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10144", 2)

				local var_443_10 = var_443_8.childCount

				for iter_443_4 = 0, var_443_10 - 1 do
					local var_443_11 = var_443_8:GetChild(iter_443_4)

					if var_443_11.name == "" or not string.find(var_443_11.name, "split") then
						var_443_11.gameObject:SetActive(true)
					else
						var_443_11.gameObject:SetActive(false)
					end
				end
			end

			local var_443_12 = 0.001

			if var_443_9 <= arg_440_1.time_ and arg_440_1.time_ < var_443_9 + var_443_12 then
				local var_443_13 = (arg_440_1.time_ - var_443_9) / var_443_12
				local var_443_14 = Vector3.New(-507.9, -381.1, -285.9)

				var_443_8.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10144, var_443_14, var_443_13)
			end

			if arg_440_1.time_ >= var_443_9 + var_443_12 and arg_440_1.time_ < var_443_9 + var_443_12 + arg_443_0 then
				var_443_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_443_15 = 0
			local var_443_16 = 0.475

			if var_443_15 < arg_440_1.time_ and arg_440_1.time_ <= var_443_15 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_17 = arg_440_1:FormatText(StoryNameCfg[1297].name)

				arg_440_1.leftNameTxt_.text = var_443_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_18 = arg_440_1:GetWordFromCfg(926021108)
				local var_443_19 = arg_440_1:FormatText(var_443_18.content)

				arg_440_1.text_.text = var_443_19

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_20 = 19
				local var_443_21 = utf8.len(var_443_19)
				local var_443_22 = var_443_20 <= 0 and var_443_16 or var_443_16 * (var_443_21 / var_443_20)

				if var_443_22 > 0 and var_443_16 < var_443_22 then
					arg_440_1.talkMaxDuration = var_443_22

					if var_443_22 + var_443_15 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_22 + var_443_15
					end
				end

				arg_440_1.text_.text = var_443_19
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021108", "story_v_out_926021.awb") ~= 0 then
					local var_443_23 = manager.audio:GetVoiceLength("story_v_out_926021", "926021108", "story_v_out_926021.awb") / 1000

					if var_443_23 + var_443_15 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_23 + var_443_15
					end

					if var_443_18.prefab_name ~= "" and arg_440_1.actors_[var_443_18.prefab_name] ~= nil then
						local var_443_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_18.prefab_name].transform, "story_v_out_926021", "926021108", "story_v_out_926021.awb")

						arg_440_1:RecordAudio("926021108", var_443_24)
						arg_440_1:RecordAudio("926021108", var_443_24)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_926021", "926021108", "story_v_out_926021.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_926021", "926021108", "story_v_out_926021.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_25 = math.max(var_443_16, arg_440_1.talkMaxDuration)

			if var_443_15 <= arg_440_1.time_ and arg_440_1.time_ < var_443_15 + var_443_25 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_15) / var_443_25

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_15 + var_443_25 and arg_440_1.time_ < var_443_15 + var_443_25 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play926021109 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 926021109
		arg_444_1.duration_ = 5.97

		local var_444_0 = {
			zh = 5.066,
			ja = 5.966
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play926021110(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["104701"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.actorSpriteComps104701 == nil then
				arg_444_1.var_.actorSpriteComps104701 = var_447_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_2 = 0.2

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.actorSpriteComps104701 then
					for iter_447_0, iter_447_1 in pairs(arg_444_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_447_1 then
							if arg_444_1.isInRecall_ then
								local var_447_4 = Mathf.Lerp(iter_447_1.color.r, arg_444_1.hightColor1.r, var_447_3)
								local var_447_5 = Mathf.Lerp(iter_447_1.color.g, arg_444_1.hightColor1.g, var_447_3)
								local var_447_6 = Mathf.Lerp(iter_447_1.color.b, arg_444_1.hightColor1.b, var_447_3)

								iter_447_1.color = Color.New(var_447_4, var_447_5, var_447_6)
							else
								local var_447_7 = Mathf.Lerp(iter_447_1.color.r, 1, var_447_3)

								iter_447_1.color = Color.New(var_447_7, var_447_7, var_447_7)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.actorSpriteComps104701 then
				for iter_447_2, iter_447_3 in pairs(arg_444_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_447_3 then
						if arg_444_1.isInRecall_ then
							iter_447_3.color = arg_444_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_447_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_444_1.var_.actorSpriteComps104701 = nil
			end

			local var_447_8 = arg_444_1.actors_["10144"]
			local var_447_9 = 0

			if var_447_9 < arg_444_1.time_ and arg_444_1.time_ <= var_447_9 + arg_447_0 and not isNil(var_447_8) and arg_444_1.var_.actorSpriteComps10144 == nil then
				arg_444_1.var_.actorSpriteComps10144 = var_447_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_10 = 0.2

			if var_447_9 <= arg_444_1.time_ and arg_444_1.time_ < var_447_9 + var_447_10 and not isNil(var_447_8) then
				local var_447_11 = (arg_444_1.time_ - var_447_9) / var_447_10

				if arg_444_1.var_.actorSpriteComps10144 then
					for iter_447_4, iter_447_5 in pairs(arg_444_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_447_5 then
							if arg_444_1.isInRecall_ then
								local var_447_12 = Mathf.Lerp(iter_447_5.color.r, arg_444_1.hightColor2.r, var_447_11)
								local var_447_13 = Mathf.Lerp(iter_447_5.color.g, arg_444_1.hightColor2.g, var_447_11)
								local var_447_14 = Mathf.Lerp(iter_447_5.color.b, arg_444_1.hightColor2.b, var_447_11)

								iter_447_5.color = Color.New(var_447_12, var_447_13, var_447_14)
							else
								local var_447_15 = Mathf.Lerp(iter_447_5.color.r, 0.5, var_447_11)

								iter_447_5.color = Color.New(var_447_15, var_447_15, var_447_15)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= var_447_9 + var_447_10 and arg_444_1.time_ < var_447_9 + var_447_10 + arg_447_0 and not isNil(var_447_8) and arg_444_1.var_.actorSpriteComps10144 then
				for iter_447_6, iter_447_7 in pairs(arg_444_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_447_7 then
						if arg_444_1.isInRecall_ then
							iter_447_7.color = arg_444_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_447_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_444_1.var_.actorSpriteComps10144 = nil
			end

			local var_447_16 = arg_444_1.actors_["104701"].transform
			local var_447_17 = 0

			if var_447_17 < arg_444_1.time_ and arg_444_1.time_ <= var_447_17 + arg_447_0 then
				arg_444_1.var_.moveOldPos104701 = var_447_16.localPosition
				var_447_16.localScale = Vector3.New(1, 1, 1)

				arg_444_1:CheckSpriteTmpPos("104701", 4)

				local var_447_18 = var_447_16.childCount

				for iter_447_8 = 0, var_447_18 - 1 do
					local var_447_19 = var_447_16:GetChild(iter_447_8)

					if var_447_19.name == "" or not string.find(var_447_19.name, "split") then
						var_447_19.gameObject:SetActive(true)
					else
						var_447_19.gameObject:SetActive(false)
					end
				end
			end

			local var_447_20 = 0.001

			if var_447_17 <= arg_444_1.time_ and arg_444_1.time_ < var_447_17 + var_447_20 then
				local var_447_21 = (arg_444_1.time_ - var_447_17) / var_447_20
				local var_447_22 = Vector3.New(372.4, -386.8, -295)

				var_447_16.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos104701, var_447_22, var_447_21)
			end

			if arg_444_1.time_ >= var_447_17 + var_447_20 and arg_444_1.time_ < var_447_17 + var_447_20 + arg_447_0 then
				var_447_16.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_447_23 = 0
			local var_447_24 = 0.575

			if var_447_23 < arg_444_1.time_ and arg_444_1.time_ <= var_447_23 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_25 = arg_444_1:FormatText(StoryNameCfg[1296].name)

				arg_444_1.leftNameTxt_.text = var_447_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_26 = arg_444_1:GetWordFromCfg(926021109)
				local var_447_27 = arg_444_1:FormatText(var_447_26.content)

				arg_444_1.text_.text = var_447_27

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_28 = 23
				local var_447_29 = utf8.len(var_447_27)
				local var_447_30 = var_447_28 <= 0 and var_447_24 or var_447_24 * (var_447_29 / var_447_28)

				if var_447_30 > 0 and var_447_24 < var_447_30 then
					arg_444_1.talkMaxDuration = var_447_30

					if var_447_30 + var_447_23 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_30 + var_447_23
					end
				end

				arg_444_1.text_.text = var_447_27
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021109", "story_v_out_926021.awb") ~= 0 then
					local var_447_31 = manager.audio:GetVoiceLength("story_v_out_926021", "926021109", "story_v_out_926021.awb") / 1000

					if var_447_31 + var_447_23 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_31 + var_447_23
					end

					if var_447_26.prefab_name ~= "" and arg_444_1.actors_[var_447_26.prefab_name] ~= nil then
						local var_447_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_26.prefab_name].transform, "story_v_out_926021", "926021109", "story_v_out_926021.awb")

						arg_444_1:RecordAudio("926021109", var_447_32)
						arg_444_1:RecordAudio("926021109", var_447_32)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_926021", "926021109", "story_v_out_926021.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_926021", "926021109", "story_v_out_926021.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_33 = math.max(var_447_24, arg_444_1.talkMaxDuration)

			if var_447_23 <= arg_444_1.time_ and arg_444_1.time_ < var_447_23 + var_447_33 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_23) / var_447_33

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_23 + var_447_33 and arg_444_1.time_ < var_447_23 + var_447_33 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play926021110 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 926021110
		arg_448_1.duration_ = 6.07

		local var_448_0 = {
			zh = 6.066,
			ja = 5.733
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play926021111(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["106103"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps106103 == nil then
				arg_448_1.var_.actorSpriteComps106103 = var_451_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_2 = 0.2

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.actorSpriteComps106103 then
					for iter_451_0, iter_451_1 in pairs(arg_448_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_451_1 then
							if arg_448_1.isInRecall_ then
								local var_451_4 = Mathf.Lerp(iter_451_1.color.r, arg_448_1.hightColor1.r, var_451_3)
								local var_451_5 = Mathf.Lerp(iter_451_1.color.g, arg_448_1.hightColor1.g, var_451_3)
								local var_451_6 = Mathf.Lerp(iter_451_1.color.b, arg_448_1.hightColor1.b, var_451_3)

								iter_451_1.color = Color.New(var_451_4, var_451_5, var_451_6)
							else
								local var_451_7 = Mathf.Lerp(iter_451_1.color.r, 1, var_451_3)

								iter_451_1.color = Color.New(var_451_7, var_451_7, var_451_7)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps106103 then
				for iter_451_2, iter_451_3 in pairs(arg_448_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_451_3 then
						if arg_448_1.isInRecall_ then
							iter_451_3.color = arg_448_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_451_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_448_1.var_.actorSpriteComps106103 = nil
			end

			local var_451_8 = arg_448_1.actors_["104701"]
			local var_451_9 = 0

			if var_451_9 < arg_448_1.time_ and arg_448_1.time_ <= var_451_9 + arg_451_0 and not isNil(var_451_8) and arg_448_1.var_.actorSpriteComps104701 == nil then
				arg_448_1.var_.actorSpriteComps104701 = var_451_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_10 = 0.2

			if var_451_9 <= arg_448_1.time_ and arg_448_1.time_ < var_451_9 + var_451_10 and not isNil(var_451_8) then
				local var_451_11 = (arg_448_1.time_ - var_451_9) / var_451_10

				if arg_448_1.var_.actorSpriteComps104701 then
					for iter_451_4, iter_451_5 in pairs(arg_448_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_451_5 then
							if arg_448_1.isInRecall_ then
								local var_451_12 = Mathf.Lerp(iter_451_5.color.r, arg_448_1.hightColor2.r, var_451_11)
								local var_451_13 = Mathf.Lerp(iter_451_5.color.g, arg_448_1.hightColor2.g, var_451_11)
								local var_451_14 = Mathf.Lerp(iter_451_5.color.b, arg_448_1.hightColor2.b, var_451_11)

								iter_451_5.color = Color.New(var_451_12, var_451_13, var_451_14)
							else
								local var_451_15 = Mathf.Lerp(iter_451_5.color.r, 0.5, var_451_11)

								iter_451_5.color = Color.New(var_451_15, var_451_15, var_451_15)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= var_451_9 + var_451_10 and arg_448_1.time_ < var_451_9 + var_451_10 + arg_451_0 and not isNil(var_451_8) and arg_448_1.var_.actorSpriteComps104701 then
				for iter_451_6, iter_451_7 in pairs(arg_448_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_451_7 then
						if arg_448_1.isInRecall_ then
							iter_451_7.color = arg_448_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_451_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_448_1.var_.actorSpriteComps104701 = nil
			end

			local var_451_16 = arg_448_1.actors_["10144"].transform
			local var_451_17 = 0

			if var_451_17 < arg_448_1.time_ and arg_448_1.time_ <= var_451_17 + arg_451_0 then
				arg_448_1.var_.moveOldPos10144 = var_451_16.localPosition
				var_451_16.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("10144", 7)

				local var_451_18 = var_451_16.childCount

				for iter_451_8 = 0, var_451_18 - 1 do
					local var_451_19 = var_451_16:GetChild(iter_451_8)

					if var_451_19.name == "" or not string.find(var_451_19.name, "split") then
						var_451_19.gameObject:SetActive(true)
					else
						var_451_19.gameObject:SetActive(false)
					end
				end
			end

			local var_451_20 = 0.001

			if var_451_17 <= arg_448_1.time_ and arg_448_1.time_ < var_451_17 + var_451_20 then
				local var_451_21 = (arg_448_1.time_ - var_451_17) / var_451_20
				local var_451_22 = Vector3.New(0, -2000, 0)

				var_451_16.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos10144, var_451_22, var_451_21)
			end

			if arg_448_1.time_ >= var_451_17 + var_451_20 and arg_448_1.time_ < var_451_17 + var_451_20 + arg_451_0 then
				var_451_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_451_23 = arg_448_1.actors_["104701"].transform
			local var_451_24 = 0

			if var_451_24 < arg_448_1.time_ and arg_448_1.time_ <= var_451_24 + arg_451_0 then
				arg_448_1.var_.moveOldPos104701 = var_451_23.localPosition
				var_451_23.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("104701", 7)

				local var_451_25 = var_451_23.childCount

				for iter_451_9 = 0, var_451_25 - 1 do
					local var_451_26 = var_451_23:GetChild(iter_451_9)

					if var_451_26.name == "" or not string.find(var_451_26.name, "split") then
						var_451_26.gameObject:SetActive(true)
					else
						var_451_26.gameObject:SetActive(false)
					end
				end
			end

			local var_451_27 = 0.001

			if var_451_24 <= arg_448_1.time_ and arg_448_1.time_ < var_451_24 + var_451_27 then
				local var_451_28 = (arg_448_1.time_ - var_451_24) / var_451_27
				local var_451_29 = Vector3.New(0, -2000, 0)

				var_451_23.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos104701, var_451_29, var_451_28)
			end

			if arg_448_1.time_ >= var_451_24 + var_451_27 and arg_448_1.time_ < var_451_24 + var_451_27 + arg_451_0 then
				var_451_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_451_30 = arg_448_1.actors_["106103"].transform
			local var_451_31 = 0

			if var_451_31 < arg_448_1.time_ and arg_448_1.time_ <= var_451_31 + arg_451_0 then
				arg_448_1.var_.moveOldPos106103 = var_451_30.localPosition
				var_451_30.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("106103", 3)

				local var_451_32 = var_451_30.childCount

				for iter_451_10 = 0, var_451_32 - 1 do
					local var_451_33 = var_451_30:GetChild(iter_451_10)

					if var_451_33.name == "split_4" or not string.find(var_451_33.name, "split") then
						var_451_33.gameObject:SetActive(true)
					else
						var_451_33.gameObject:SetActive(false)
					end
				end
			end

			local var_451_34 = 0.001

			if var_451_31 <= arg_448_1.time_ and arg_448_1.time_ < var_451_31 + var_451_34 then
				local var_451_35 = (arg_448_1.time_ - var_451_31) / var_451_34
				local var_451_36 = Vector3.New(-36.6, -398.2, -333.7)

				var_451_30.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos106103, var_451_36, var_451_35)
			end

			if arg_448_1.time_ >= var_451_31 + var_451_34 and arg_448_1.time_ < var_451_31 + var_451_34 + arg_451_0 then
				var_451_30.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_451_37 = 0
			local var_451_38 = 0.475

			if var_451_37 < arg_448_1.time_ and arg_448_1.time_ <= var_451_37 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_39 = arg_448_1:FormatText(StoryNameCfg[612].name)

				arg_448_1.leftNameTxt_.text = var_451_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_40 = arg_448_1:GetWordFromCfg(926021110)
				local var_451_41 = arg_448_1:FormatText(var_451_40.content)

				arg_448_1.text_.text = var_451_41

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_42 = 19
				local var_451_43 = utf8.len(var_451_41)
				local var_451_44 = var_451_42 <= 0 and var_451_38 or var_451_38 * (var_451_43 / var_451_42)

				if var_451_44 > 0 and var_451_38 < var_451_44 then
					arg_448_1.talkMaxDuration = var_451_44

					if var_451_44 + var_451_37 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_44 + var_451_37
					end
				end

				arg_448_1.text_.text = var_451_41
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021110", "story_v_out_926021.awb") ~= 0 then
					local var_451_45 = manager.audio:GetVoiceLength("story_v_out_926021", "926021110", "story_v_out_926021.awb") / 1000

					if var_451_45 + var_451_37 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_45 + var_451_37
					end

					if var_451_40.prefab_name ~= "" and arg_448_1.actors_[var_451_40.prefab_name] ~= nil then
						local var_451_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_40.prefab_name].transform, "story_v_out_926021", "926021110", "story_v_out_926021.awb")

						arg_448_1:RecordAudio("926021110", var_451_46)
						arg_448_1:RecordAudio("926021110", var_451_46)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_926021", "926021110", "story_v_out_926021.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_926021", "926021110", "story_v_out_926021.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_47 = math.max(var_451_38, arg_448_1.talkMaxDuration)

			if var_451_37 <= arg_448_1.time_ and arg_448_1.time_ < var_451_37 + var_451_47 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_37) / var_451_47

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_37 + var_451_47 and arg_448_1.time_ < var_451_37 + var_451_47 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play926021111 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 926021111
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play926021112(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["106103"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps106103 == nil then
				arg_452_1.var_.actorSpriteComps106103 = var_455_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_2 = 0.2

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.actorSpriteComps106103 then
					for iter_455_0, iter_455_1 in pairs(arg_452_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_455_1 then
							if arg_452_1.isInRecall_ then
								local var_455_4 = Mathf.Lerp(iter_455_1.color.r, arg_452_1.hightColor2.r, var_455_3)
								local var_455_5 = Mathf.Lerp(iter_455_1.color.g, arg_452_1.hightColor2.g, var_455_3)
								local var_455_6 = Mathf.Lerp(iter_455_1.color.b, arg_452_1.hightColor2.b, var_455_3)

								iter_455_1.color = Color.New(var_455_4, var_455_5, var_455_6)
							else
								local var_455_7 = Mathf.Lerp(iter_455_1.color.r, 0.5, var_455_3)

								iter_455_1.color = Color.New(var_455_7, var_455_7, var_455_7)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps106103 then
				for iter_455_2, iter_455_3 in pairs(arg_452_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_455_3 then
						if arg_452_1.isInRecall_ then
							iter_455_3.color = arg_452_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_455_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_452_1.var_.actorSpriteComps106103 = nil
			end

			local var_455_8 = 0
			local var_455_9 = 0.825

			if var_455_8 < arg_452_1.time_ and arg_452_1.time_ <= var_455_8 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_10 = arg_452_1:FormatText(StoryNameCfg[7].name)

				arg_452_1.leftNameTxt_.text = var_455_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_11 = arg_452_1:GetWordFromCfg(926021111)
				local var_455_12 = arg_452_1:FormatText(var_455_11.content)

				arg_452_1.text_.text = var_455_12

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_13 = 33
				local var_455_14 = utf8.len(var_455_12)
				local var_455_15 = var_455_13 <= 0 and var_455_9 or var_455_9 * (var_455_14 / var_455_13)

				if var_455_15 > 0 and var_455_9 < var_455_15 then
					arg_452_1.talkMaxDuration = var_455_15

					if var_455_15 + var_455_8 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_15 + var_455_8
					end
				end

				arg_452_1.text_.text = var_455_12
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_16 = math.max(var_455_9, arg_452_1.talkMaxDuration)

			if var_455_8 <= arg_452_1.time_ and arg_452_1.time_ < var_455_8 + var_455_16 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_8) / var_455_16

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_8 + var_455_16 and arg_452_1.time_ < var_455_8 + var_455_16 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play926021112 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 926021112
		arg_456_1.duration_ = 3.87

		local var_456_0 = {
			zh = 3.866,
			ja = 3.6
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play926021113(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["106103"]
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.actorSpriteComps106103 == nil then
				arg_456_1.var_.actorSpriteComps106103 = var_459_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_2 = 0.2

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 and not isNil(var_459_0) then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2

				if arg_456_1.var_.actorSpriteComps106103 then
					for iter_459_0, iter_459_1 in pairs(arg_456_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_459_1 then
							if arg_456_1.isInRecall_ then
								local var_459_4 = Mathf.Lerp(iter_459_1.color.r, arg_456_1.hightColor1.r, var_459_3)
								local var_459_5 = Mathf.Lerp(iter_459_1.color.g, arg_456_1.hightColor1.g, var_459_3)
								local var_459_6 = Mathf.Lerp(iter_459_1.color.b, arg_456_1.hightColor1.b, var_459_3)

								iter_459_1.color = Color.New(var_459_4, var_459_5, var_459_6)
							else
								local var_459_7 = Mathf.Lerp(iter_459_1.color.r, 1, var_459_3)

								iter_459_1.color = Color.New(var_459_7, var_459_7, var_459_7)
							end
						end
					end
				end
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.actorSpriteComps106103 then
				for iter_459_2, iter_459_3 in pairs(arg_456_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_459_3 then
						if arg_456_1.isInRecall_ then
							iter_459_3.color = arg_456_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_459_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_456_1.var_.actorSpriteComps106103 = nil
			end

			local var_459_8 = 0
			local var_459_9 = 0.3

			if var_459_8 < arg_456_1.time_ and arg_456_1.time_ <= var_459_8 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_10 = arg_456_1:FormatText(StoryNameCfg[612].name)

				arg_456_1.leftNameTxt_.text = var_459_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_11 = arg_456_1:GetWordFromCfg(926021112)
				local var_459_12 = arg_456_1:FormatText(var_459_11.content)

				arg_456_1.text_.text = var_459_12

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_13 = 12
				local var_459_14 = utf8.len(var_459_12)
				local var_459_15 = var_459_13 <= 0 and var_459_9 or var_459_9 * (var_459_14 / var_459_13)

				if var_459_15 > 0 and var_459_9 < var_459_15 then
					arg_456_1.talkMaxDuration = var_459_15

					if var_459_15 + var_459_8 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_15 + var_459_8
					end
				end

				arg_456_1.text_.text = var_459_12
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021112", "story_v_out_926021.awb") ~= 0 then
					local var_459_16 = manager.audio:GetVoiceLength("story_v_out_926021", "926021112", "story_v_out_926021.awb") / 1000

					if var_459_16 + var_459_8 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_16 + var_459_8
					end

					if var_459_11.prefab_name ~= "" and arg_456_1.actors_[var_459_11.prefab_name] ~= nil then
						local var_459_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_11.prefab_name].transform, "story_v_out_926021", "926021112", "story_v_out_926021.awb")

						arg_456_1:RecordAudio("926021112", var_459_17)
						arg_456_1:RecordAudio("926021112", var_459_17)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_926021", "926021112", "story_v_out_926021.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_926021", "926021112", "story_v_out_926021.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_18 = math.max(var_459_9, arg_456_1.talkMaxDuration)

			if var_459_8 <= arg_456_1.time_ and arg_456_1.time_ < var_459_8 + var_459_18 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_8) / var_459_18

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_8 + var_459_18 and arg_456_1.time_ < var_459_8 + var_459_18 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play926021113 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 926021113
		arg_460_1.duration_ = 5.13

		local var_460_0 = {
			zh = 4.033,
			ja = 5.133
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play926021114(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["10144"]
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.actorSpriteComps10144 == nil then
				arg_460_1.var_.actorSpriteComps10144 = var_463_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_2 = 0.2

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 and not isNil(var_463_0) then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2

				if arg_460_1.var_.actorSpriteComps10144 then
					for iter_463_0, iter_463_1 in pairs(arg_460_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_463_1 then
							if arg_460_1.isInRecall_ then
								local var_463_4 = Mathf.Lerp(iter_463_1.color.r, arg_460_1.hightColor1.r, var_463_3)
								local var_463_5 = Mathf.Lerp(iter_463_1.color.g, arg_460_1.hightColor1.g, var_463_3)
								local var_463_6 = Mathf.Lerp(iter_463_1.color.b, arg_460_1.hightColor1.b, var_463_3)

								iter_463_1.color = Color.New(var_463_4, var_463_5, var_463_6)
							else
								local var_463_7 = Mathf.Lerp(iter_463_1.color.r, 1, var_463_3)

								iter_463_1.color = Color.New(var_463_7, var_463_7, var_463_7)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.actorSpriteComps10144 then
				for iter_463_2, iter_463_3 in pairs(arg_460_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_463_3 then
						if arg_460_1.isInRecall_ then
							iter_463_3.color = arg_460_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_463_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_460_1.var_.actorSpriteComps10144 = nil
			end

			local var_463_8 = arg_460_1.actors_["106103"]
			local var_463_9 = 0

			if var_463_9 < arg_460_1.time_ and arg_460_1.time_ <= var_463_9 + arg_463_0 and not isNil(var_463_8) and arg_460_1.var_.actorSpriteComps106103 == nil then
				arg_460_1.var_.actorSpriteComps106103 = var_463_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_10 = 0.2

			if var_463_9 <= arg_460_1.time_ and arg_460_1.time_ < var_463_9 + var_463_10 and not isNil(var_463_8) then
				local var_463_11 = (arg_460_1.time_ - var_463_9) / var_463_10

				if arg_460_1.var_.actorSpriteComps106103 then
					for iter_463_4, iter_463_5 in pairs(arg_460_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_463_5 then
							if arg_460_1.isInRecall_ then
								local var_463_12 = Mathf.Lerp(iter_463_5.color.r, arg_460_1.hightColor2.r, var_463_11)
								local var_463_13 = Mathf.Lerp(iter_463_5.color.g, arg_460_1.hightColor2.g, var_463_11)
								local var_463_14 = Mathf.Lerp(iter_463_5.color.b, arg_460_1.hightColor2.b, var_463_11)

								iter_463_5.color = Color.New(var_463_12, var_463_13, var_463_14)
							else
								local var_463_15 = Mathf.Lerp(iter_463_5.color.r, 0.5, var_463_11)

								iter_463_5.color = Color.New(var_463_15, var_463_15, var_463_15)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= var_463_9 + var_463_10 and arg_460_1.time_ < var_463_9 + var_463_10 + arg_463_0 and not isNil(var_463_8) and arg_460_1.var_.actorSpriteComps106103 then
				for iter_463_6, iter_463_7 in pairs(arg_460_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_463_7 then
						if arg_460_1.isInRecall_ then
							iter_463_7.color = arg_460_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_463_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_460_1.var_.actorSpriteComps106103 = nil
			end

			local var_463_16 = arg_460_1.actors_["10144"].transform
			local var_463_17 = 0

			if var_463_17 < arg_460_1.time_ and arg_460_1.time_ <= var_463_17 + arg_463_0 then
				arg_460_1.var_.moveOldPos10144 = var_463_16.localPosition
				var_463_16.localScale = Vector3.New(1, 1, 1)

				arg_460_1:CheckSpriteTmpPos("10144", 3)

				local var_463_18 = var_463_16.childCount

				for iter_463_8 = 0, var_463_18 - 1 do
					local var_463_19 = var_463_16:GetChild(iter_463_8)

					if var_463_19.name == "split_1" or not string.find(var_463_19.name, "split") then
						var_463_19.gameObject:SetActive(true)
					else
						var_463_19.gameObject:SetActive(false)
					end
				end
			end

			local var_463_20 = 0.001

			if var_463_17 <= arg_460_1.time_ and arg_460_1.time_ < var_463_17 + var_463_20 then
				local var_463_21 = (arg_460_1.time_ - var_463_17) / var_463_20
				local var_463_22 = Vector3.New(-31.5, -381.1, -285.9)

				var_463_16.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos10144, var_463_22, var_463_21)
			end

			if arg_460_1.time_ >= var_463_17 + var_463_20 and arg_460_1.time_ < var_463_17 + var_463_20 + arg_463_0 then
				var_463_16.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_463_23 = arg_460_1.actors_["106103"].transform
			local var_463_24 = 0

			if var_463_24 < arg_460_1.time_ and arg_460_1.time_ <= var_463_24 + arg_463_0 then
				arg_460_1.var_.moveOldPos106103 = var_463_23.localPosition
				var_463_23.localScale = Vector3.New(1, 1, 1)

				arg_460_1:CheckSpriteTmpPos("106103", 7)

				local var_463_25 = var_463_23.childCount

				for iter_463_9 = 0, var_463_25 - 1 do
					local var_463_26 = var_463_23:GetChild(iter_463_9)

					if var_463_26.name == "split_2" or not string.find(var_463_26.name, "split") then
						var_463_26.gameObject:SetActive(true)
					else
						var_463_26.gameObject:SetActive(false)
					end
				end
			end

			local var_463_27 = 0.001

			if var_463_24 <= arg_460_1.time_ and arg_460_1.time_ < var_463_24 + var_463_27 then
				local var_463_28 = (arg_460_1.time_ - var_463_24) / var_463_27
				local var_463_29 = Vector3.New(0, -2000, 0)

				var_463_23.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos106103, var_463_29, var_463_28)
			end

			if arg_460_1.time_ >= var_463_24 + var_463_27 and arg_460_1.time_ < var_463_24 + var_463_27 + arg_463_0 then
				var_463_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_463_30 = 0
			local var_463_31 = 0.45

			if var_463_30 < arg_460_1.time_ and arg_460_1.time_ <= var_463_30 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_32 = arg_460_1:FormatText(StoryNameCfg[1297].name)

				arg_460_1.leftNameTxt_.text = var_463_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_33 = arg_460_1:GetWordFromCfg(926021113)
				local var_463_34 = arg_460_1:FormatText(var_463_33.content)

				arg_460_1.text_.text = var_463_34

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_35 = 18
				local var_463_36 = utf8.len(var_463_34)
				local var_463_37 = var_463_35 <= 0 and var_463_31 or var_463_31 * (var_463_36 / var_463_35)

				if var_463_37 > 0 and var_463_31 < var_463_37 then
					arg_460_1.talkMaxDuration = var_463_37

					if var_463_37 + var_463_30 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_37 + var_463_30
					end
				end

				arg_460_1.text_.text = var_463_34
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021113", "story_v_out_926021.awb") ~= 0 then
					local var_463_38 = manager.audio:GetVoiceLength("story_v_out_926021", "926021113", "story_v_out_926021.awb") / 1000

					if var_463_38 + var_463_30 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_38 + var_463_30
					end

					if var_463_33.prefab_name ~= "" and arg_460_1.actors_[var_463_33.prefab_name] ~= nil then
						local var_463_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_33.prefab_name].transform, "story_v_out_926021", "926021113", "story_v_out_926021.awb")

						arg_460_1:RecordAudio("926021113", var_463_39)
						arg_460_1:RecordAudio("926021113", var_463_39)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_926021", "926021113", "story_v_out_926021.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_926021", "926021113", "story_v_out_926021.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_40 = math.max(var_463_31, arg_460_1.talkMaxDuration)

			if var_463_30 <= arg_460_1.time_ and arg_460_1.time_ < var_463_30 + var_463_40 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_30) / var_463_40

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_30 + var_463_40 and arg_460_1.time_ < var_463_30 + var_463_40 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play926021114 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 926021114
		arg_464_1.duration_ = 8.85

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play926021115(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = "ST0114"

			if arg_464_1.bgs_[var_467_0] == nil then
				local var_467_1 = Object.Instantiate(arg_464_1.paintGo_)

				var_467_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_467_0)
				var_467_1.name = var_467_0
				var_467_1.transform.parent = arg_464_1.stage_.transform
				var_467_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_464_1.bgs_[var_467_0] = var_467_1
			end

			local var_467_2 = 1.56666666666667

			if var_467_2 < arg_464_1.time_ and arg_464_1.time_ <= var_467_2 + arg_467_0 then
				local var_467_3 = manager.ui.mainCamera.transform.localPosition
				local var_467_4 = Vector3.New(0, 0, 10) + Vector3.New(var_467_3.x, var_467_3.y, 0)
				local var_467_5 = arg_464_1.bgs_.ST0114

				var_467_5.transform.localPosition = var_467_4
				var_467_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_467_6 = var_467_5:GetComponent("SpriteRenderer")

				if var_467_6 and var_467_6.sprite then
					local var_467_7 = (var_467_5.transform.localPosition - var_467_3).z
					local var_467_8 = manager.ui.mainCameraCom_
					local var_467_9 = 2 * var_467_7 * Mathf.Tan(var_467_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_467_10 = var_467_9 * var_467_8.aspect
					local var_467_11 = var_467_6.sprite.bounds.size.x
					local var_467_12 = var_467_6.sprite.bounds.size.y
					local var_467_13 = var_467_10 / var_467_11
					local var_467_14 = var_467_9 / var_467_12
					local var_467_15 = var_467_14 < var_467_13 and var_467_13 or var_467_14

					var_467_5.transform.localScale = Vector3.New(var_467_15, var_467_15, 0)
				end

				for iter_467_0, iter_467_1 in pairs(arg_464_1.bgs_) do
					if iter_467_0 ~= "ST0114" then
						iter_467_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_467_16 = 1.56666666666667

			if var_467_16 < arg_464_1.time_ and arg_464_1.time_ <= var_467_16 + arg_467_0 then
				arg_464_1.allBtn_.enabled = false
			end

			local var_467_17 = 0.3

			if arg_464_1.time_ >= var_467_16 + var_467_17 and arg_464_1.time_ < var_467_16 + var_467_17 + arg_467_0 then
				arg_464_1.allBtn_.enabled = true
			end

			local var_467_18 = 0

			if var_467_18 < arg_464_1.time_ and arg_464_1.time_ <= var_467_18 + arg_467_0 then
				arg_464_1.mask_.enabled = true
				arg_464_1.mask_.raycastTarget = true

				arg_464_1:SetGaussion(false)
			end

			local var_467_19 = 1.56666666666667

			if var_467_18 <= arg_464_1.time_ and arg_464_1.time_ < var_467_18 + var_467_19 then
				local var_467_20 = (arg_464_1.time_ - var_467_18) / var_467_19
				local var_467_21 = Color.New(0, 0, 0)

				var_467_21.a = Mathf.Lerp(0, 1, var_467_20)
				arg_464_1.mask_.color = var_467_21
			end

			if arg_464_1.time_ >= var_467_18 + var_467_19 and arg_464_1.time_ < var_467_18 + var_467_19 + arg_467_0 then
				local var_467_22 = Color.New(0, 0, 0)

				var_467_22.a = 1
				arg_464_1.mask_.color = var_467_22
			end

			local var_467_23 = 1.56666666666667

			if var_467_23 < arg_464_1.time_ and arg_464_1.time_ <= var_467_23 + arg_467_0 then
				arg_464_1.mask_.enabled = true
				arg_464_1.mask_.raycastTarget = true

				arg_464_1:SetGaussion(false)
			end

			local var_467_24 = 2.28333333333333

			if var_467_23 <= arg_464_1.time_ and arg_464_1.time_ < var_467_23 + var_467_24 then
				local var_467_25 = (arg_464_1.time_ - var_467_23) / var_467_24
				local var_467_26 = Color.New(0, 0, 0)

				var_467_26.a = Mathf.Lerp(1, 0, var_467_25)
				arg_464_1.mask_.color = var_467_26
			end

			if arg_464_1.time_ >= var_467_23 + var_467_24 and arg_464_1.time_ < var_467_23 + var_467_24 + arg_467_0 then
				local var_467_27 = Color.New(0, 0, 0)
				local var_467_28 = 0

				arg_464_1.mask_.enabled = false
				var_467_27.a = var_467_28
				arg_464_1.mask_.color = var_467_27
			end

			local var_467_29 = arg_464_1.actors_["10144"]
			local var_467_30 = 1.56666666666667

			if var_467_30 < arg_464_1.time_ and arg_464_1.time_ <= var_467_30 + arg_467_0 and not isNil(var_467_29) and arg_464_1.var_.actorSpriteComps10144 == nil then
				arg_464_1.var_.actorSpriteComps10144 = var_467_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_31 = 0.2

			if var_467_30 <= arg_464_1.time_ and arg_464_1.time_ < var_467_30 + var_467_31 and not isNil(var_467_29) then
				local var_467_32 = (arg_464_1.time_ - var_467_30) / var_467_31

				if arg_464_1.var_.actorSpriteComps10144 then
					for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_467_3 then
							if arg_464_1.isInRecall_ then
								local var_467_33 = Mathf.Lerp(iter_467_3.color.r, arg_464_1.hightColor2.r, var_467_32)
								local var_467_34 = Mathf.Lerp(iter_467_3.color.g, arg_464_1.hightColor2.g, var_467_32)
								local var_467_35 = Mathf.Lerp(iter_467_3.color.b, arg_464_1.hightColor2.b, var_467_32)

								iter_467_3.color = Color.New(var_467_33, var_467_34, var_467_35)
							else
								local var_467_36 = Mathf.Lerp(iter_467_3.color.r, 0.5, var_467_32)

								iter_467_3.color = Color.New(var_467_36, var_467_36, var_467_36)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= var_467_30 + var_467_31 and arg_464_1.time_ < var_467_30 + var_467_31 + arg_467_0 and not isNil(var_467_29) and arg_464_1.var_.actorSpriteComps10144 then
				for iter_467_4, iter_467_5 in pairs(arg_464_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_467_5 then
						if arg_464_1.isInRecall_ then
							iter_467_5.color = arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_467_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_464_1.var_.actorSpriteComps10144 = nil
			end

			local var_467_37 = arg_464_1.actors_["10144"].transform
			local var_467_38 = 1.56666666666667

			if var_467_38 < arg_464_1.time_ and arg_464_1.time_ <= var_467_38 + arg_467_0 then
				arg_464_1.var_.moveOldPos10144 = var_467_37.localPosition
				var_467_37.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("10144", 7)

				local var_467_39 = var_467_37.childCount

				for iter_467_6 = 0, var_467_39 - 1 do
					local var_467_40 = var_467_37:GetChild(iter_467_6)

					if var_467_40.name == "" or not string.find(var_467_40.name, "split") then
						var_467_40.gameObject:SetActive(true)
					else
						var_467_40.gameObject:SetActive(false)
					end
				end
			end

			local var_467_41 = 0.001

			if var_467_38 <= arg_464_1.time_ and arg_464_1.time_ < var_467_38 + var_467_41 then
				local var_467_42 = (arg_464_1.time_ - var_467_38) / var_467_41
				local var_467_43 = Vector3.New(0, -2000, 0)

				var_467_37.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos10144, var_467_43, var_467_42)
			end

			if arg_464_1.time_ >= var_467_38 + var_467_41 and arg_464_1.time_ < var_467_38 + var_467_41 + arg_467_0 then
				var_467_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_467_44 = arg_464_1.actors_["106103"].transform
			local var_467_45 = 1.56666666666667

			if var_467_45 < arg_464_1.time_ and arg_464_1.time_ <= var_467_45 + arg_467_0 then
				arg_464_1.var_.moveOldPos106103 = var_467_44.localPosition
				var_467_44.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("106103", 7)

				local var_467_46 = var_467_44.childCount

				for iter_467_7 = 0, var_467_46 - 1 do
					local var_467_47 = var_467_44:GetChild(iter_467_7)

					if var_467_47.name == "" or not string.find(var_467_47.name, "split") then
						var_467_47.gameObject:SetActive(true)
					else
						var_467_47.gameObject:SetActive(false)
					end
				end
			end

			local var_467_48 = 0.001

			if var_467_45 <= arg_464_1.time_ and arg_464_1.time_ < var_467_45 + var_467_48 then
				local var_467_49 = (arg_464_1.time_ - var_467_45) / var_467_48
				local var_467_50 = Vector3.New(0, -2000, 0)

				var_467_44.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos106103, var_467_50, var_467_49)
			end

			if arg_464_1.time_ >= var_467_45 + var_467_48 and arg_464_1.time_ < var_467_45 + var_467_48 + arg_467_0 then
				var_467_44.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_467_51 = 0
			local var_467_52 = 0.433333333333333

			if var_467_51 < arg_464_1.time_ and arg_464_1.time_ <= var_467_51 + arg_467_0 then
				local var_467_53 = "play"
				local var_467_54 = "music"

				arg_464_1:AudioAction(var_467_53, var_467_54, "ui_battle", "ui_battle_stopbgm", "")

				local var_467_55 = ""
				local var_467_56 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_467_56 ~= "" then
					if arg_464_1.bgmTxt_.text ~= var_467_56 and arg_464_1.bgmTxt_.text ~= "" then
						if arg_464_1.bgmTxt2_.text ~= "" then
							arg_464_1.bgmTxt_.text = arg_464_1.bgmTxt2_.text
						end

						arg_464_1.bgmTxt2_.text = var_467_56

						arg_464_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_464_1.bgmTxt_.text = var_467_56
						arg_464_1.bgmTxt2_.text = var_467_56
					end

					if arg_464_1.bgmTimer then
						arg_464_1.bgmTimer:Stop()

						arg_464_1.bgmTimer = nil
					end

					if arg_464_1.settingData.show_music_name == 1 then
						arg_464_1.musicController:SetSelectedState("show")
						arg_464_1.musicAnimator_:Play("open", 0, 0)

						if arg_464_1.settingData.music_time ~= 0 then
							arg_464_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_464_1.settingData.music_time), function()
								if arg_464_1 == nil or isNil(arg_464_1.bgmTxt_) then
									return
								end

								arg_464_1.musicController:SetSelectedState("hide")
								arg_464_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_467_57 = 1.60066666666667
			local var_467_58 = 1

			if var_467_57 < arg_464_1.time_ and arg_464_1.time_ <= var_467_57 + arg_467_0 then
				local var_467_59 = "play"
				local var_467_60 = "music"

				arg_464_1:AudioAction(var_467_59, var_467_60, "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")

				local var_467_61 = ""
				local var_467_62 = manager.audio:GetAudioName("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern")

				if var_467_62 ~= "" then
					if arg_464_1.bgmTxt_.text ~= var_467_62 and arg_464_1.bgmTxt_.text ~= "" then
						if arg_464_1.bgmTxt2_.text ~= "" then
							arg_464_1.bgmTxt_.text = arg_464_1.bgmTxt2_.text
						end

						arg_464_1.bgmTxt2_.text = var_467_62

						arg_464_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_464_1.bgmTxt_.text = var_467_62
						arg_464_1.bgmTxt2_.text = var_467_62
					end

					if arg_464_1.bgmTimer then
						arg_464_1.bgmTimer:Stop()

						arg_464_1.bgmTimer = nil
					end

					if arg_464_1.settingData.show_music_name == 1 then
						arg_464_1.musicController:SetSelectedState("show")
						arg_464_1.musicAnimator_:Play("open", 0, 0)

						if arg_464_1.settingData.music_time ~= 0 then
							arg_464_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_464_1.settingData.music_time), function()
								if arg_464_1 == nil or isNil(arg_464_1.bgmTxt_) then
									return
								end

								arg_464_1.musicController:SetSelectedState("hide")
								arg_464_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_467_63 = 0.566666666666667
			local var_467_64 = 1

			if var_467_63 < arg_464_1.time_ and arg_464_1.time_ <= var_467_63 + arg_467_0 then
				local var_467_65 = "stop"
				local var_467_66 = "effect"

				arg_464_1:AudioAction(var_467_65, var_467_66, "se_story_143", "se_story_143_amb_town", "")
			end

			local var_467_67 = 1.60066666666667
			local var_467_68 = 1

			if var_467_67 < arg_464_1.time_ and arg_464_1.time_ <= var_467_67 + arg_467_0 then
				local var_467_69 = "play"
				local var_467_70 = "effect"

				arg_464_1:AudioAction(var_467_69, var_467_70, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_467_71 = 2
			local var_467_72 = 1

			if var_467_71 < arg_464_1.time_ and arg_464_1.time_ <= var_467_71 + arg_467_0 then
				local var_467_73 = "play"
				local var_467_74 = "effect"

				arg_464_1:AudioAction(var_467_73, var_467_74, "se_story_143", "se_story_143_door", "")
			end

			if arg_464_1.frameCnt_ <= 1 then
				arg_464_1.dialog_:SetActive(false)
			end

			local var_467_75 = 3.85
			local var_467_76 = 0.65

			if var_467_75 < arg_464_1.time_ and arg_464_1.time_ <= var_467_75 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0

				arg_464_1.dialog_:SetActive(true)

				arg_464_1.dialogCg_.alpha = 0

				local var_467_77 = LeanTween.value(arg_464_1.dialog_, 0, 1, 0.3)

				var_467_77:setOnUpdate(LuaHelper.FloatAction(function(arg_470_0)
					arg_464_1.dialogCg_.alpha = arg_470_0
				end))
				var_467_77:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_464_1.dialog_)
					var_467_77:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_464_1.duration_ = arg_464_1.duration_ + 0.3

				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_78 = arg_464_1:GetWordFromCfg(926021114)
				local var_467_79 = arg_464_1:FormatText(var_467_78.content)

				arg_464_1.text_.text = var_467_79

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_80 = 26
				local var_467_81 = utf8.len(var_467_79)
				local var_467_82 = var_467_80 <= 0 and var_467_76 or var_467_76 * (var_467_81 / var_467_80)

				if var_467_82 > 0 and var_467_76 < var_467_82 then
					arg_464_1.talkMaxDuration = var_467_82
					var_467_75 = var_467_75 + 0.3

					if var_467_82 + var_467_75 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_82 + var_467_75
					end
				end

				arg_464_1.text_.text = var_467_79
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_83 = var_467_75 + 0.3
			local var_467_84 = math.max(var_467_76, arg_464_1.talkMaxDuration)

			if var_467_83 <= arg_464_1.time_ and arg_464_1.time_ < var_467_83 + var_467_84 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_83) / var_467_84

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_83 + var_467_84 and arg_464_1.time_ < var_467_83 + var_467_84 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play926021115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 926021115
		arg_472_1.duration_ = 3.63

		local var_472_0 = {
			zh = 3.633,
			ja = 2.233
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play926021116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["106103"]
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.actorSpriteComps106103 == nil then
				arg_472_1.var_.actorSpriteComps106103 = var_475_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_475_2 = 0.2

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 and not isNil(var_475_0) then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2

				if arg_472_1.var_.actorSpriteComps106103 then
					for iter_475_0, iter_475_1 in pairs(arg_472_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_475_1 then
							if arg_472_1.isInRecall_ then
								local var_475_4 = Mathf.Lerp(iter_475_1.color.r, arg_472_1.hightColor1.r, var_475_3)
								local var_475_5 = Mathf.Lerp(iter_475_1.color.g, arg_472_1.hightColor1.g, var_475_3)
								local var_475_6 = Mathf.Lerp(iter_475_1.color.b, arg_472_1.hightColor1.b, var_475_3)

								iter_475_1.color = Color.New(var_475_4, var_475_5, var_475_6)
							else
								local var_475_7 = Mathf.Lerp(iter_475_1.color.r, 1, var_475_3)

								iter_475_1.color = Color.New(var_475_7, var_475_7, var_475_7)
							end
						end
					end
				end
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.actorSpriteComps106103 then
				for iter_475_2, iter_475_3 in pairs(arg_472_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_475_3 then
						if arg_472_1.isInRecall_ then
							iter_475_3.color = arg_472_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_475_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_472_1.var_.actorSpriteComps106103 = nil
			end

			local var_475_8 = 0
			local var_475_9 = 0.15

			if var_475_8 < arg_472_1.time_ and arg_472_1.time_ <= var_475_8 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_10 = arg_472_1:FormatText(StoryNameCfg[612].name)

				arg_472_1.leftNameTxt_.text = var_475_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, true)
				arg_472_1.iconController_:SetSelectedState("hero")

				arg_472_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_472_1.callingController_:SetSelectedState("normal")

				arg_472_1.keyicon_.color = Color.New(1, 1, 1)
				arg_472_1.icon_.color = Color.New(1, 1, 1)

				local var_475_11 = arg_472_1:GetWordFromCfg(926021115)
				local var_475_12 = arg_472_1:FormatText(var_475_11.content)

				arg_472_1.text_.text = var_475_12

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_13 = 6
				local var_475_14 = utf8.len(var_475_12)
				local var_475_15 = var_475_13 <= 0 and var_475_9 or var_475_9 * (var_475_14 / var_475_13)

				if var_475_15 > 0 and var_475_9 < var_475_15 then
					arg_472_1.talkMaxDuration = var_475_15

					if var_475_15 + var_475_8 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_15 + var_475_8
					end
				end

				arg_472_1.text_.text = var_475_12
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021115", "story_v_out_926021.awb") ~= 0 then
					local var_475_16 = manager.audio:GetVoiceLength("story_v_out_926021", "926021115", "story_v_out_926021.awb") / 1000

					if var_475_16 + var_475_8 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_16 + var_475_8
					end

					if var_475_11.prefab_name ~= "" and arg_472_1.actors_[var_475_11.prefab_name] ~= nil then
						local var_475_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_11.prefab_name].transform, "story_v_out_926021", "926021115", "story_v_out_926021.awb")

						arg_472_1:RecordAudio("926021115", var_475_17)
						arg_472_1:RecordAudio("926021115", var_475_17)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_926021", "926021115", "story_v_out_926021.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_926021", "926021115", "story_v_out_926021.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_18 = math.max(var_475_9, arg_472_1.talkMaxDuration)

			if var_475_8 <= arg_472_1.time_ and arg_472_1.time_ < var_475_8 + var_475_18 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_8) / var_475_18

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_8 + var_475_18 and arg_472_1.time_ < var_475_8 + var_475_18 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play926021116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 926021116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play926021117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["106103"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.actorSpriteComps106103 == nil then
				arg_476_1.var_.actorSpriteComps106103 = var_479_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_479_2 = 0.2

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.actorSpriteComps106103 then
					for iter_479_0, iter_479_1 in pairs(arg_476_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_479_1 then
							if arg_476_1.isInRecall_ then
								local var_479_4 = Mathf.Lerp(iter_479_1.color.r, arg_476_1.hightColor2.r, var_479_3)
								local var_479_5 = Mathf.Lerp(iter_479_1.color.g, arg_476_1.hightColor2.g, var_479_3)
								local var_479_6 = Mathf.Lerp(iter_479_1.color.b, arg_476_1.hightColor2.b, var_479_3)

								iter_479_1.color = Color.New(var_479_4, var_479_5, var_479_6)
							else
								local var_479_7 = Mathf.Lerp(iter_479_1.color.r, 0.5, var_479_3)

								iter_479_1.color = Color.New(var_479_7, var_479_7, var_479_7)
							end
						end
					end
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.actorSpriteComps106103 then
				for iter_479_2, iter_479_3 in pairs(arg_476_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_479_3 then
						if arg_476_1.isInRecall_ then
							iter_479_3.color = arg_476_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_479_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_476_1.var_.actorSpriteComps106103 = nil
			end

			local var_479_8 = 0
			local var_479_9 = 0.9

			if var_479_8 < arg_476_1.time_ and arg_476_1.time_ <= var_479_8 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_10 = arg_476_1:GetWordFromCfg(926021116)
				local var_479_11 = arg_476_1:FormatText(var_479_10.content)

				arg_476_1.text_.text = var_479_11

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_12 = 36
				local var_479_13 = utf8.len(var_479_11)
				local var_479_14 = var_479_12 <= 0 and var_479_9 or var_479_9 * (var_479_13 / var_479_12)

				if var_479_14 > 0 and var_479_9 < var_479_14 then
					arg_476_1.talkMaxDuration = var_479_14

					if var_479_14 + var_479_8 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_14 + var_479_8
					end
				end

				arg_476_1.text_.text = var_479_11
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_15 = math.max(var_479_9, arg_476_1.talkMaxDuration)

			if var_479_8 <= arg_476_1.time_ and arg_476_1.time_ < var_479_8 + var_479_15 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_8) / var_479_15

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_8 + var_479_15 and arg_476_1.time_ < var_479_8 + var_479_15 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play926021117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 926021117
		arg_480_1.duration_ = 4.03

		local var_480_0 = {
			zh = 2.666,
			ja = 4.033
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play926021118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["10144"]
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 and not isNil(var_483_0) and arg_480_1.var_.actorSpriteComps10144 == nil then
				arg_480_1.var_.actorSpriteComps10144 = var_483_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_2 = 0.2

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_2 and not isNil(var_483_0) then
				local var_483_3 = (arg_480_1.time_ - var_483_1) / var_483_2

				if arg_480_1.var_.actorSpriteComps10144 then
					for iter_483_0, iter_483_1 in pairs(arg_480_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_483_1 then
							if arg_480_1.isInRecall_ then
								local var_483_4 = Mathf.Lerp(iter_483_1.color.r, arg_480_1.hightColor1.r, var_483_3)
								local var_483_5 = Mathf.Lerp(iter_483_1.color.g, arg_480_1.hightColor1.g, var_483_3)
								local var_483_6 = Mathf.Lerp(iter_483_1.color.b, arg_480_1.hightColor1.b, var_483_3)

								iter_483_1.color = Color.New(var_483_4, var_483_5, var_483_6)
							else
								local var_483_7 = Mathf.Lerp(iter_483_1.color.r, 1, var_483_3)

								iter_483_1.color = Color.New(var_483_7, var_483_7, var_483_7)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= var_483_1 + var_483_2 and arg_480_1.time_ < var_483_1 + var_483_2 + arg_483_0 and not isNil(var_483_0) and arg_480_1.var_.actorSpriteComps10144 then
				for iter_483_2, iter_483_3 in pairs(arg_480_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_483_3 then
						if arg_480_1.isInRecall_ then
							iter_483_3.color = arg_480_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_483_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_480_1.var_.actorSpriteComps10144 = nil
			end

			local var_483_8 = arg_480_1.actors_["10144"].transform
			local var_483_9 = 0

			if var_483_9 < arg_480_1.time_ and arg_480_1.time_ <= var_483_9 + arg_483_0 then
				arg_480_1.var_.moveOldPos10144 = var_483_8.localPosition
				var_483_8.localScale = Vector3.New(1, 1, 1)

				arg_480_1:CheckSpriteTmpPos("10144", 3)

				local var_483_10 = var_483_8.childCount

				for iter_483_4 = 0, var_483_10 - 1 do
					local var_483_11 = var_483_8:GetChild(iter_483_4)

					if var_483_11.name == "" or not string.find(var_483_11.name, "split") then
						var_483_11.gameObject:SetActive(true)
					else
						var_483_11.gameObject:SetActive(false)
					end
				end
			end

			local var_483_12 = 0.001

			if var_483_9 <= arg_480_1.time_ and arg_480_1.time_ < var_483_9 + var_483_12 then
				local var_483_13 = (arg_480_1.time_ - var_483_9) / var_483_12
				local var_483_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_483_8.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos10144, var_483_14, var_483_13)
			end

			if arg_480_1.time_ >= var_483_9 + var_483_12 and arg_480_1.time_ < var_483_9 + var_483_12 + arg_483_0 then
				var_483_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_483_15 = 0
			local var_483_16 = 0.425

			if var_483_15 < arg_480_1.time_ and arg_480_1.time_ <= var_483_15 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_17 = arg_480_1:FormatText(StoryNameCfg[1297].name)

				arg_480_1.leftNameTxt_.text = var_483_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_18 = arg_480_1:GetWordFromCfg(926021117)
				local var_483_19 = arg_480_1:FormatText(var_483_18.content)

				arg_480_1.text_.text = var_483_19

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_20 = 17
				local var_483_21 = utf8.len(var_483_19)
				local var_483_22 = var_483_20 <= 0 and var_483_16 or var_483_16 * (var_483_21 / var_483_20)

				if var_483_22 > 0 and var_483_16 < var_483_22 then
					arg_480_1.talkMaxDuration = var_483_22

					if var_483_22 + var_483_15 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_22 + var_483_15
					end
				end

				arg_480_1.text_.text = var_483_19
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021117", "story_v_out_926021.awb") ~= 0 then
					local var_483_23 = manager.audio:GetVoiceLength("story_v_out_926021", "926021117", "story_v_out_926021.awb") / 1000

					if var_483_23 + var_483_15 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_23 + var_483_15
					end

					if var_483_18.prefab_name ~= "" and arg_480_1.actors_[var_483_18.prefab_name] ~= nil then
						local var_483_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_18.prefab_name].transform, "story_v_out_926021", "926021117", "story_v_out_926021.awb")

						arg_480_1:RecordAudio("926021117", var_483_24)
						arg_480_1:RecordAudio("926021117", var_483_24)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_926021", "926021117", "story_v_out_926021.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_926021", "926021117", "story_v_out_926021.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_25 = math.max(var_483_16, arg_480_1.talkMaxDuration)

			if var_483_15 <= arg_480_1.time_ and arg_480_1.time_ < var_483_15 + var_483_25 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_15) / var_483_25

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_15 + var_483_25 and arg_480_1.time_ < var_483_15 + var_483_25 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play926021118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 926021118
		arg_484_1.duration_ = 1.57

		local var_484_0 = {
			zh = 1.033,
			ja = 1.566
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play926021119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["106103"]
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.actorSpriteComps106103 == nil then
				arg_484_1.var_.actorSpriteComps106103 = var_487_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_487_2 = 0.2

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 and not isNil(var_487_0) then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2

				if arg_484_1.var_.actorSpriteComps106103 then
					for iter_487_0, iter_487_1 in pairs(arg_484_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_487_1 then
							if arg_484_1.isInRecall_ then
								local var_487_4 = Mathf.Lerp(iter_487_1.color.r, arg_484_1.hightColor1.r, var_487_3)
								local var_487_5 = Mathf.Lerp(iter_487_1.color.g, arg_484_1.hightColor1.g, var_487_3)
								local var_487_6 = Mathf.Lerp(iter_487_1.color.b, arg_484_1.hightColor1.b, var_487_3)

								iter_487_1.color = Color.New(var_487_4, var_487_5, var_487_6)
							else
								local var_487_7 = Mathf.Lerp(iter_487_1.color.r, 1, var_487_3)

								iter_487_1.color = Color.New(var_487_7, var_487_7, var_487_7)
							end
						end
					end
				end
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.actorSpriteComps106103 then
				for iter_487_2, iter_487_3 in pairs(arg_484_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_487_3 then
						if arg_484_1.isInRecall_ then
							iter_487_3.color = arg_484_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_487_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_484_1.var_.actorSpriteComps106103 = nil
			end

			local var_487_8 = arg_484_1.actors_["10144"]
			local var_487_9 = 0

			if var_487_9 < arg_484_1.time_ and arg_484_1.time_ <= var_487_9 + arg_487_0 and not isNil(var_487_8) and arg_484_1.var_.actorSpriteComps10144 == nil then
				arg_484_1.var_.actorSpriteComps10144 = var_487_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_487_10 = 0.2

			if var_487_9 <= arg_484_1.time_ and arg_484_1.time_ < var_487_9 + var_487_10 and not isNil(var_487_8) then
				local var_487_11 = (arg_484_1.time_ - var_487_9) / var_487_10

				if arg_484_1.var_.actorSpriteComps10144 then
					for iter_487_4, iter_487_5 in pairs(arg_484_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_487_5 then
							if arg_484_1.isInRecall_ then
								local var_487_12 = Mathf.Lerp(iter_487_5.color.r, arg_484_1.hightColor2.r, var_487_11)
								local var_487_13 = Mathf.Lerp(iter_487_5.color.g, arg_484_1.hightColor2.g, var_487_11)
								local var_487_14 = Mathf.Lerp(iter_487_5.color.b, arg_484_1.hightColor2.b, var_487_11)

								iter_487_5.color = Color.New(var_487_12, var_487_13, var_487_14)
							else
								local var_487_15 = Mathf.Lerp(iter_487_5.color.r, 0.5, var_487_11)

								iter_487_5.color = Color.New(var_487_15, var_487_15, var_487_15)
							end
						end
					end
				end
			end

			if arg_484_1.time_ >= var_487_9 + var_487_10 and arg_484_1.time_ < var_487_9 + var_487_10 + arg_487_0 and not isNil(var_487_8) and arg_484_1.var_.actorSpriteComps10144 then
				for iter_487_6, iter_487_7 in pairs(arg_484_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_487_7 then
						if arg_484_1.isInRecall_ then
							iter_487_7.color = arg_484_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_487_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_484_1.var_.actorSpriteComps10144 = nil
			end

			local var_487_16 = 0
			local var_487_17 = 0.05

			if var_487_16 < arg_484_1.time_ and arg_484_1.time_ <= var_487_16 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_18 = arg_484_1:FormatText(StoryNameCfg[612].name)

				arg_484_1.leftNameTxt_.text = var_487_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_19 = arg_484_1:GetWordFromCfg(926021118)
				local var_487_20 = arg_484_1:FormatText(var_487_19.content)

				arg_484_1.text_.text = var_487_20

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_21 = 2
				local var_487_22 = utf8.len(var_487_20)
				local var_487_23 = var_487_21 <= 0 and var_487_17 or var_487_17 * (var_487_22 / var_487_21)

				if var_487_23 > 0 and var_487_17 < var_487_23 then
					arg_484_1.talkMaxDuration = var_487_23

					if var_487_23 + var_487_16 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_23 + var_487_16
					end
				end

				arg_484_1.text_.text = var_487_20
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021118", "story_v_out_926021.awb") ~= 0 then
					local var_487_24 = manager.audio:GetVoiceLength("story_v_out_926021", "926021118", "story_v_out_926021.awb") / 1000

					if var_487_24 + var_487_16 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_24 + var_487_16
					end

					if var_487_19.prefab_name ~= "" and arg_484_1.actors_[var_487_19.prefab_name] ~= nil then
						local var_487_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_19.prefab_name].transform, "story_v_out_926021", "926021118", "story_v_out_926021.awb")

						arg_484_1:RecordAudio("926021118", var_487_25)
						arg_484_1:RecordAudio("926021118", var_487_25)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_926021", "926021118", "story_v_out_926021.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_926021", "926021118", "story_v_out_926021.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_26 = math.max(var_487_17, arg_484_1.talkMaxDuration)

			if var_487_16 <= arg_484_1.time_ and arg_484_1.time_ < var_487_16 + var_487_26 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_16) / var_487_26

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_16 + var_487_26 and arg_484_1.time_ < var_487_16 + var_487_26 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play926021119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 926021119
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play926021120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["106103"]
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.actorSpriteComps106103 == nil then
				arg_488_1.var_.actorSpriteComps106103 = var_491_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_491_2 = 0.2

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 and not isNil(var_491_0) then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2

				if arg_488_1.var_.actorSpriteComps106103 then
					for iter_491_0, iter_491_1 in pairs(arg_488_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_491_1 then
							if arg_488_1.isInRecall_ then
								local var_491_4 = Mathf.Lerp(iter_491_1.color.r, arg_488_1.hightColor2.r, var_491_3)
								local var_491_5 = Mathf.Lerp(iter_491_1.color.g, arg_488_1.hightColor2.g, var_491_3)
								local var_491_6 = Mathf.Lerp(iter_491_1.color.b, arg_488_1.hightColor2.b, var_491_3)

								iter_491_1.color = Color.New(var_491_4, var_491_5, var_491_6)
							else
								local var_491_7 = Mathf.Lerp(iter_491_1.color.r, 0.5, var_491_3)

								iter_491_1.color = Color.New(var_491_7, var_491_7, var_491_7)
							end
						end
					end
				end
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.actorSpriteComps106103 then
				for iter_491_2, iter_491_3 in pairs(arg_488_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_491_3 then
						if arg_488_1.isInRecall_ then
							iter_491_3.color = arg_488_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_491_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_488_1.var_.actorSpriteComps106103 = nil
			end

			local var_491_8 = 0
			local var_491_9 = 1.225

			if var_491_8 < arg_488_1.time_ and arg_488_1.time_ <= var_491_8 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_10 = arg_488_1:GetWordFromCfg(926021119)
				local var_491_11 = arg_488_1:FormatText(var_491_10.content)

				arg_488_1.text_.text = var_491_11

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_12 = 49
				local var_491_13 = utf8.len(var_491_11)
				local var_491_14 = var_491_12 <= 0 and var_491_9 or var_491_9 * (var_491_13 / var_491_12)

				if var_491_14 > 0 and var_491_9 < var_491_14 then
					arg_488_1.talkMaxDuration = var_491_14

					if var_491_14 + var_491_8 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_14 + var_491_8
					end
				end

				arg_488_1.text_.text = var_491_11
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_15 = math.max(var_491_9, arg_488_1.talkMaxDuration)

			if var_491_8 <= arg_488_1.time_ and arg_488_1.time_ < var_491_8 + var_491_15 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_8) / var_491_15

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_8 + var_491_15 and arg_488_1.time_ < var_491_8 + var_491_15 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play926021120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 926021120
		arg_492_1.duration_ = 4.17

		local var_492_0 = {
			zh = 2.566,
			ja = 4.166
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play926021121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["10144"]
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.actorSpriteComps10144 == nil then
				arg_492_1.var_.actorSpriteComps10144 = var_495_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_495_2 = 0.2

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_2 and not isNil(var_495_0) then
				local var_495_3 = (arg_492_1.time_ - var_495_1) / var_495_2

				if arg_492_1.var_.actorSpriteComps10144 then
					for iter_495_0, iter_495_1 in pairs(arg_492_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_495_1 then
							if arg_492_1.isInRecall_ then
								local var_495_4 = Mathf.Lerp(iter_495_1.color.r, arg_492_1.hightColor1.r, var_495_3)
								local var_495_5 = Mathf.Lerp(iter_495_1.color.g, arg_492_1.hightColor1.g, var_495_3)
								local var_495_6 = Mathf.Lerp(iter_495_1.color.b, arg_492_1.hightColor1.b, var_495_3)

								iter_495_1.color = Color.New(var_495_4, var_495_5, var_495_6)
							else
								local var_495_7 = Mathf.Lerp(iter_495_1.color.r, 1, var_495_3)

								iter_495_1.color = Color.New(var_495_7, var_495_7, var_495_7)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= var_495_1 + var_495_2 and arg_492_1.time_ < var_495_1 + var_495_2 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.actorSpriteComps10144 then
				for iter_495_2, iter_495_3 in pairs(arg_492_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_495_3 then
						if arg_492_1.isInRecall_ then
							iter_495_3.color = arg_492_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_495_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_492_1.var_.actorSpriteComps10144 = nil
			end

			local var_495_8 = arg_492_1.actors_["10144"].transform
			local var_495_9 = 0

			if var_495_9 < arg_492_1.time_ and arg_492_1.time_ <= var_495_9 + arg_495_0 then
				arg_492_1.var_.moveOldPos10144 = var_495_8.localPosition
				var_495_8.localScale = Vector3.New(1, 1, 1)

				arg_492_1:CheckSpriteTmpPos("10144", 3)

				local var_495_10 = var_495_8.childCount

				for iter_495_4 = 0, var_495_10 - 1 do
					local var_495_11 = var_495_8:GetChild(iter_495_4)

					if var_495_11.name == "split_2" or not string.find(var_495_11.name, "split") then
						var_495_11.gameObject:SetActive(true)
					else
						var_495_11.gameObject:SetActive(false)
					end
				end
			end

			local var_495_12 = 0.001

			if var_495_9 <= arg_492_1.time_ and arg_492_1.time_ < var_495_9 + var_495_12 then
				local var_495_13 = (arg_492_1.time_ - var_495_9) / var_495_12
				local var_495_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_495_8.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos10144, var_495_14, var_495_13)
			end

			if arg_492_1.time_ >= var_495_9 + var_495_12 and arg_492_1.time_ < var_495_9 + var_495_12 + arg_495_0 then
				var_495_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_495_15 = 0
			local var_495_16 = 0.3

			if var_495_15 < arg_492_1.time_ and arg_492_1.time_ <= var_495_15 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_17 = arg_492_1:FormatText(StoryNameCfg[1297].name)

				arg_492_1.leftNameTxt_.text = var_495_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_18 = arg_492_1:GetWordFromCfg(926021120)
				local var_495_19 = arg_492_1:FormatText(var_495_18.content)

				arg_492_1.text_.text = var_495_19

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_20 = 12
				local var_495_21 = utf8.len(var_495_19)
				local var_495_22 = var_495_20 <= 0 and var_495_16 or var_495_16 * (var_495_21 / var_495_20)

				if var_495_22 > 0 and var_495_16 < var_495_22 then
					arg_492_1.talkMaxDuration = var_495_22

					if var_495_22 + var_495_15 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_22 + var_495_15
					end
				end

				arg_492_1.text_.text = var_495_19
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021120", "story_v_out_926021.awb") ~= 0 then
					local var_495_23 = manager.audio:GetVoiceLength("story_v_out_926021", "926021120", "story_v_out_926021.awb") / 1000

					if var_495_23 + var_495_15 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_23 + var_495_15
					end

					if var_495_18.prefab_name ~= "" and arg_492_1.actors_[var_495_18.prefab_name] ~= nil then
						local var_495_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_18.prefab_name].transform, "story_v_out_926021", "926021120", "story_v_out_926021.awb")

						arg_492_1:RecordAudio("926021120", var_495_24)
						arg_492_1:RecordAudio("926021120", var_495_24)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_926021", "926021120", "story_v_out_926021.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_926021", "926021120", "story_v_out_926021.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_25 = math.max(var_495_16, arg_492_1.talkMaxDuration)

			if var_495_15 <= arg_492_1.time_ and arg_492_1.time_ < var_495_15 + var_495_25 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_15) / var_495_25

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_15 + var_495_25 and arg_492_1.time_ < var_495_15 + var_495_25 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play926021121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 926021121
		arg_496_1.duration_ = 5.43

		local var_496_0 = {
			zh = 5.266,
			ja = 5.433
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play926021122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["106103"]
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.actorSpriteComps106103 == nil then
				arg_496_1.var_.actorSpriteComps106103 = var_499_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_2 = 0.2

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 and not isNil(var_499_0) then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2

				if arg_496_1.var_.actorSpriteComps106103 then
					for iter_499_0, iter_499_1 in pairs(arg_496_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_499_1 then
							if arg_496_1.isInRecall_ then
								local var_499_4 = Mathf.Lerp(iter_499_1.color.r, arg_496_1.hightColor1.r, var_499_3)
								local var_499_5 = Mathf.Lerp(iter_499_1.color.g, arg_496_1.hightColor1.g, var_499_3)
								local var_499_6 = Mathf.Lerp(iter_499_1.color.b, arg_496_1.hightColor1.b, var_499_3)

								iter_499_1.color = Color.New(var_499_4, var_499_5, var_499_6)
							else
								local var_499_7 = Mathf.Lerp(iter_499_1.color.r, 1, var_499_3)

								iter_499_1.color = Color.New(var_499_7, var_499_7, var_499_7)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.actorSpriteComps106103 then
				for iter_499_2, iter_499_3 in pairs(arg_496_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_499_3 then
						if arg_496_1.isInRecall_ then
							iter_499_3.color = arg_496_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_499_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_496_1.var_.actorSpriteComps106103 = nil
			end

			local var_499_8 = arg_496_1.actors_["10144"]
			local var_499_9 = 0

			if var_499_9 < arg_496_1.time_ and arg_496_1.time_ <= var_499_9 + arg_499_0 and not isNil(var_499_8) and arg_496_1.var_.actorSpriteComps10144 == nil then
				arg_496_1.var_.actorSpriteComps10144 = var_499_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_10 = 0.2

			if var_499_9 <= arg_496_1.time_ and arg_496_1.time_ < var_499_9 + var_499_10 and not isNil(var_499_8) then
				local var_499_11 = (arg_496_1.time_ - var_499_9) / var_499_10

				if arg_496_1.var_.actorSpriteComps10144 then
					for iter_499_4, iter_499_5 in pairs(arg_496_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_499_5 then
							if arg_496_1.isInRecall_ then
								local var_499_12 = Mathf.Lerp(iter_499_5.color.r, arg_496_1.hightColor2.r, var_499_11)
								local var_499_13 = Mathf.Lerp(iter_499_5.color.g, arg_496_1.hightColor2.g, var_499_11)
								local var_499_14 = Mathf.Lerp(iter_499_5.color.b, arg_496_1.hightColor2.b, var_499_11)

								iter_499_5.color = Color.New(var_499_12, var_499_13, var_499_14)
							else
								local var_499_15 = Mathf.Lerp(iter_499_5.color.r, 0.5, var_499_11)

								iter_499_5.color = Color.New(var_499_15, var_499_15, var_499_15)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= var_499_9 + var_499_10 and arg_496_1.time_ < var_499_9 + var_499_10 + arg_499_0 and not isNil(var_499_8) and arg_496_1.var_.actorSpriteComps10144 then
				for iter_499_6, iter_499_7 in pairs(arg_496_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_499_7 then
						if arg_496_1.isInRecall_ then
							iter_499_7.color = arg_496_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_499_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_496_1.var_.actorSpriteComps10144 = nil
			end

			local var_499_16 = arg_496_1.actors_["106103"].transform
			local var_499_17 = 0

			if var_499_17 < arg_496_1.time_ and arg_496_1.time_ <= var_499_17 + arg_499_0 then
				arg_496_1.var_.moveOldPos106103 = var_499_16.localPosition
				var_499_16.localScale = Vector3.New(1, 1, 1)

				arg_496_1:CheckSpriteTmpPos("106103", 4)

				local var_499_18 = var_499_16.childCount

				for iter_499_8 = 0, var_499_18 - 1 do
					local var_499_19 = var_499_16:GetChild(iter_499_8)

					if var_499_19.name == "split_4" or not string.find(var_499_19.name, "split") then
						var_499_19.gameObject:SetActive(true)
					else
						var_499_19.gameObject:SetActive(false)
					end
				end
			end

			local var_499_20 = 0.001

			if var_499_17 <= arg_496_1.time_ and arg_496_1.time_ < var_499_17 + var_499_20 then
				local var_499_21 = (arg_496_1.time_ - var_499_17) / var_499_20
				local var_499_22 = Vector3.New(442.7, -398.2, -333.7)

				var_499_16.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos106103, var_499_22, var_499_21)
			end

			if arg_496_1.time_ >= var_499_17 + var_499_20 and arg_496_1.time_ < var_499_17 + var_499_20 + arg_499_0 then
				var_499_16.localPosition = Vector3.New(442.7, -398.2, -333.7)
			end

			local var_499_23 = arg_496_1.actors_["10144"].transform
			local var_499_24 = 0

			if var_499_24 < arg_496_1.time_ and arg_496_1.time_ <= var_499_24 + arg_499_0 then
				arg_496_1.var_.moveOldPos10144 = var_499_23.localPosition
				var_499_23.localScale = Vector3.New(1, 1, 1)

				arg_496_1:CheckSpriteTmpPos("10144", 2)

				local var_499_25 = var_499_23.childCount

				for iter_499_9 = 0, var_499_25 - 1 do
					local var_499_26 = var_499_23:GetChild(iter_499_9)

					if var_499_26.name == "split_1" or not string.find(var_499_26.name, "split") then
						var_499_26.gameObject:SetActive(true)
					else
						var_499_26.gameObject:SetActive(false)
					end
				end
			end

			local var_499_27 = 0.001

			if var_499_24 <= arg_496_1.time_ and arg_496_1.time_ < var_499_24 + var_499_27 then
				local var_499_28 = (arg_496_1.time_ - var_499_24) / var_499_27
				local var_499_29 = Vector3.New(-507.9, -381.1, -285.9)

				var_499_23.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos10144, var_499_29, var_499_28)
			end

			if arg_496_1.time_ >= var_499_24 + var_499_27 and arg_496_1.time_ < var_499_24 + var_499_27 + arg_499_0 then
				var_499_23.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_499_30 = 0
			local var_499_31 = 0.6

			if var_499_30 < arg_496_1.time_ and arg_496_1.time_ <= var_499_30 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_32 = arg_496_1:FormatText(StoryNameCfg[612].name)

				arg_496_1.leftNameTxt_.text = var_499_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_33 = arg_496_1:GetWordFromCfg(926021121)
				local var_499_34 = arg_496_1:FormatText(var_499_33.content)

				arg_496_1.text_.text = var_499_34

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_35 = 24
				local var_499_36 = utf8.len(var_499_34)
				local var_499_37 = var_499_35 <= 0 and var_499_31 or var_499_31 * (var_499_36 / var_499_35)

				if var_499_37 > 0 and var_499_31 < var_499_37 then
					arg_496_1.talkMaxDuration = var_499_37

					if var_499_37 + var_499_30 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_37 + var_499_30
					end
				end

				arg_496_1.text_.text = var_499_34
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021121", "story_v_out_926021.awb") ~= 0 then
					local var_499_38 = manager.audio:GetVoiceLength("story_v_out_926021", "926021121", "story_v_out_926021.awb") / 1000

					if var_499_38 + var_499_30 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_38 + var_499_30
					end

					if var_499_33.prefab_name ~= "" and arg_496_1.actors_[var_499_33.prefab_name] ~= nil then
						local var_499_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_33.prefab_name].transform, "story_v_out_926021", "926021121", "story_v_out_926021.awb")

						arg_496_1:RecordAudio("926021121", var_499_39)
						arg_496_1:RecordAudio("926021121", var_499_39)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_926021", "926021121", "story_v_out_926021.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_926021", "926021121", "story_v_out_926021.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_40 = math.max(var_499_31, arg_496_1.talkMaxDuration)

			if var_499_30 <= arg_496_1.time_ and arg_496_1.time_ < var_499_30 + var_499_40 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_30) / var_499_40

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_30 + var_499_40 and arg_496_1.time_ < var_499_30 + var_499_40 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play926021122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 926021122
		arg_500_1.duration_ = 5.33

		local var_500_0 = {
			zh = 2.466,
			ja = 5.333
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play926021123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = arg_500_1.actors_["10144"]
			local var_503_1 = 0

			if var_503_1 < arg_500_1.time_ and arg_500_1.time_ <= var_503_1 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.actorSpriteComps10144 == nil then
				arg_500_1.var_.actorSpriteComps10144 = var_503_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_503_2 = 0.2

			if var_503_1 <= arg_500_1.time_ and arg_500_1.time_ < var_503_1 + var_503_2 and not isNil(var_503_0) then
				local var_503_3 = (arg_500_1.time_ - var_503_1) / var_503_2

				if arg_500_1.var_.actorSpriteComps10144 then
					for iter_503_0, iter_503_1 in pairs(arg_500_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_503_1 then
							if arg_500_1.isInRecall_ then
								local var_503_4 = Mathf.Lerp(iter_503_1.color.r, arg_500_1.hightColor1.r, var_503_3)
								local var_503_5 = Mathf.Lerp(iter_503_1.color.g, arg_500_1.hightColor1.g, var_503_3)
								local var_503_6 = Mathf.Lerp(iter_503_1.color.b, arg_500_1.hightColor1.b, var_503_3)

								iter_503_1.color = Color.New(var_503_4, var_503_5, var_503_6)
							else
								local var_503_7 = Mathf.Lerp(iter_503_1.color.r, 1, var_503_3)

								iter_503_1.color = Color.New(var_503_7, var_503_7, var_503_7)
							end
						end
					end
				end
			end

			if arg_500_1.time_ >= var_503_1 + var_503_2 and arg_500_1.time_ < var_503_1 + var_503_2 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.actorSpriteComps10144 then
				for iter_503_2, iter_503_3 in pairs(arg_500_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_503_3 then
						if arg_500_1.isInRecall_ then
							iter_503_3.color = arg_500_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_503_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_500_1.var_.actorSpriteComps10144 = nil
			end

			local var_503_8 = arg_500_1.actors_["106103"]
			local var_503_9 = 0

			if var_503_9 < arg_500_1.time_ and arg_500_1.time_ <= var_503_9 + arg_503_0 and not isNil(var_503_8) and arg_500_1.var_.actorSpriteComps106103 == nil then
				arg_500_1.var_.actorSpriteComps106103 = var_503_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_503_10 = 0.2

			if var_503_9 <= arg_500_1.time_ and arg_500_1.time_ < var_503_9 + var_503_10 and not isNil(var_503_8) then
				local var_503_11 = (arg_500_1.time_ - var_503_9) / var_503_10

				if arg_500_1.var_.actorSpriteComps106103 then
					for iter_503_4, iter_503_5 in pairs(arg_500_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_503_5 then
							if arg_500_1.isInRecall_ then
								local var_503_12 = Mathf.Lerp(iter_503_5.color.r, arg_500_1.hightColor2.r, var_503_11)
								local var_503_13 = Mathf.Lerp(iter_503_5.color.g, arg_500_1.hightColor2.g, var_503_11)
								local var_503_14 = Mathf.Lerp(iter_503_5.color.b, arg_500_1.hightColor2.b, var_503_11)

								iter_503_5.color = Color.New(var_503_12, var_503_13, var_503_14)
							else
								local var_503_15 = Mathf.Lerp(iter_503_5.color.r, 0.5, var_503_11)

								iter_503_5.color = Color.New(var_503_15, var_503_15, var_503_15)
							end
						end
					end
				end
			end

			if arg_500_1.time_ >= var_503_9 + var_503_10 and arg_500_1.time_ < var_503_9 + var_503_10 + arg_503_0 and not isNil(var_503_8) and arg_500_1.var_.actorSpriteComps106103 then
				for iter_503_6, iter_503_7 in pairs(arg_500_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_503_7 then
						if arg_500_1.isInRecall_ then
							iter_503_7.color = arg_500_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_503_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_500_1.var_.actorSpriteComps106103 = nil
			end

			local var_503_16 = 0
			local var_503_17 = 0.275

			if var_503_16 < arg_500_1.time_ and arg_500_1.time_ <= var_503_16 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_18 = arg_500_1:FormatText(StoryNameCfg[1297].name)

				arg_500_1.leftNameTxt_.text = var_503_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_19 = arg_500_1:GetWordFromCfg(926021122)
				local var_503_20 = arg_500_1:FormatText(var_503_19.content)

				arg_500_1.text_.text = var_503_20

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_21 = 11
				local var_503_22 = utf8.len(var_503_20)
				local var_503_23 = var_503_21 <= 0 and var_503_17 or var_503_17 * (var_503_22 / var_503_21)

				if var_503_23 > 0 and var_503_17 < var_503_23 then
					arg_500_1.talkMaxDuration = var_503_23

					if var_503_23 + var_503_16 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_23 + var_503_16
					end
				end

				arg_500_1.text_.text = var_503_20
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021122", "story_v_out_926021.awb") ~= 0 then
					local var_503_24 = manager.audio:GetVoiceLength("story_v_out_926021", "926021122", "story_v_out_926021.awb") / 1000

					if var_503_24 + var_503_16 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_24 + var_503_16
					end

					if var_503_19.prefab_name ~= "" and arg_500_1.actors_[var_503_19.prefab_name] ~= nil then
						local var_503_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_19.prefab_name].transform, "story_v_out_926021", "926021122", "story_v_out_926021.awb")

						arg_500_1:RecordAudio("926021122", var_503_25)
						arg_500_1:RecordAudio("926021122", var_503_25)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_926021", "926021122", "story_v_out_926021.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_926021", "926021122", "story_v_out_926021.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_26 = math.max(var_503_17, arg_500_1.talkMaxDuration)

			if var_503_16 <= arg_500_1.time_ and arg_500_1.time_ < var_503_16 + var_503_26 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_16) / var_503_26

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_16 + var_503_26 and arg_500_1.time_ < var_503_16 + var_503_26 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play926021123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 926021123
		arg_504_1.duration_ = 6.07

		local var_504_0 = {
			zh = 3.933,
			ja = 6.066
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play926021124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.55

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_2 = arg_504_1:FormatText(StoryNameCfg[1297].name)

				arg_504_1.leftNameTxt_.text = var_507_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_3 = arg_504_1:GetWordFromCfg(926021123)
				local var_507_4 = arg_504_1:FormatText(var_507_3.content)

				arg_504_1.text_.text = var_507_4

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 22
				local var_507_6 = utf8.len(var_507_4)
				local var_507_7 = var_507_5 <= 0 and var_507_1 or var_507_1 * (var_507_6 / var_507_5)

				if var_507_7 > 0 and var_507_1 < var_507_7 then
					arg_504_1.talkMaxDuration = var_507_7

					if var_507_7 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_7 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_4
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021123", "story_v_out_926021.awb") ~= 0 then
					local var_507_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021123", "story_v_out_926021.awb") / 1000

					if var_507_8 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_8 + var_507_0
					end

					if var_507_3.prefab_name ~= "" and arg_504_1.actors_[var_507_3.prefab_name] ~= nil then
						local var_507_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_3.prefab_name].transform, "story_v_out_926021", "926021123", "story_v_out_926021.awb")

						arg_504_1:RecordAudio("926021123", var_507_9)
						arg_504_1:RecordAudio("926021123", var_507_9)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_926021", "926021123", "story_v_out_926021.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_926021", "926021123", "story_v_out_926021.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_10 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_10 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_10

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_10 and arg_504_1.time_ < var_507_0 + var_507_10 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play926021124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 926021124
		arg_508_1.duration_ = 5.7

		local var_508_0 = {
			zh = 4.033,
			ja = 5.7
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play926021125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["104701"]
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.actorSpriteComps104701 == nil then
				arg_508_1.var_.actorSpriteComps104701 = var_511_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_511_2 = 0.2

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 and not isNil(var_511_0) then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2

				if arg_508_1.var_.actorSpriteComps104701 then
					for iter_511_0, iter_511_1 in pairs(arg_508_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_511_1 then
							if arg_508_1.isInRecall_ then
								local var_511_4 = Mathf.Lerp(iter_511_1.color.r, arg_508_1.hightColor1.r, var_511_3)
								local var_511_5 = Mathf.Lerp(iter_511_1.color.g, arg_508_1.hightColor1.g, var_511_3)
								local var_511_6 = Mathf.Lerp(iter_511_1.color.b, arg_508_1.hightColor1.b, var_511_3)

								iter_511_1.color = Color.New(var_511_4, var_511_5, var_511_6)
							else
								local var_511_7 = Mathf.Lerp(iter_511_1.color.r, 1, var_511_3)

								iter_511_1.color = Color.New(var_511_7, var_511_7, var_511_7)
							end
						end
					end
				end
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.actorSpriteComps104701 then
				for iter_511_2, iter_511_3 in pairs(arg_508_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_511_3 then
						if arg_508_1.isInRecall_ then
							iter_511_3.color = arg_508_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_511_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_508_1.var_.actorSpriteComps104701 = nil
			end

			local var_511_8 = arg_508_1.actors_["10144"]
			local var_511_9 = 0

			if var_511_9 < arg_508_1.time_ and arg_508_1.time_ <= var_511_9 + arg_511_0 and not isNil(var_511_8) and arg_508_1.var_.actorSpriteComps10144 == nil then
				arg_508_1.var_.actorSpriteComps10144 = var_511_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_511_10 = 0.2

			if var_511_9 <= arg_508_1.time_ and arg_508_1.time_ < var_511_9 + var_511_10 and not isNil(var_511_8) then
				local var_511_11 = (arg_508_1.time_ - var_511_9) / var_511_10

				if arg_508_1.var_.actorSpriteComps10144 then
					for iter_511_4, iter_511_5 in pairs(arg_508_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_511_5 then
							if arg_508_1.isInRecall_ then
								local var_511_12 = Mathf.Lerp(iter_511_5.color.r, arg_508_1.hightColor2.r, var_511_11)
								local var_511_13 = Mathf.Lerp(iter_511_5.color.g, arg_508_1.hightColor2.g, var_511_11)
								local var_511_14 = Mathf.Lerp(iter_511_5.color.b, arg_508_1.hightColor2.b, var_511_11)

								iter_511_5.color = Color.New(var_511_12, var_511_13, var_511_14)
							else
								local var_511_15 = Mathf.Lerp(iter_511_5.color.r, 0.5, var_511_11)

								iter_511_5.color = Color.New(var_511_15, var_511_15, var_511_15)
							end
						end
					end
				end
			end

			if arg_508_1.time_ >= var_511_9 + var_511_10 and arg_508_1.time_ < var_511_9 + var_511_10 + arg_511_0 and not isNil(var_511_8) and arg_508_1.var_.actorSpriteComps10144 then
				for iter_511_6, iter_511_7 in pairs(arg_508_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_511_7 then
						if arg_508_1.isInRecall_ then
							iter_511_7.color = arg_508_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_511_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_508_1.var_.actorSpriteComps10144 = nil
			end

			local var_511_16 = arg_508_1.actors_["106103"].transform
			local var_511_17 = 0

			if var_511_17 < arg_508_1.time_ and arg_508_1.time_ <= var_511_17 + arg_511_0 then
				arg_508_1.var_.moveOldPos106103 = var_511_16.localPosition
				var_511_16.localScale = Vector3.New(1, 1, 1)

				arg_508_1:CheckSpriteTmpPos("106103", 7)

				local var_511_18 = var_511_16.childCount

				for iter_511_8 = 0, var_511_18 - 1 do
					local var_511_19 = var_511_16:GetChild(iter_511_8)

					if var_511_19.name == "" or not string.find(var_511_19.name, "split") then
						var_511_19.gameObject:SetActive(true)
					else
						var_511_19.gameObject:SetActive(false)
					end
				end
			end

			local var_511_20 = 0.001

			if var_511_17 <= arg_508_1.time_ and arg_508_1.time_ < var_511_17 + var_511_20 then
				local var_511_21 = (arg_508_1.time_ - var_511_17) / var_511_20
				local var_511_22 = Vector3.New(0, -2000, 0)

				var_511_16.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos106103, var_511_22, var_511_21)
			end

			if arg_508_1.time_ >= var_511_17 + var_511_20 and arg_508_1.time_ < var_511_17 + var_511_20 + arg_511_0 then
				var_511_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_511_23 = arg_508_1.actors_["104701"].transform
			local var_511_24 = 0

			if var_511_24 < arg_508_1.time_ and arg_508_1.time_ <= var_511_24 + arg_511_0 then
				arg_508_1.var_.moveOldPos104701 = var_511_23.localPosition
				var_511_23.localScale = Vector3.New(1, 1, 1)

				arg_508_1:CheckSpriteTmpPos("104701", 3)

				local var_511_25 = var_511_23.childCount

				for iter_511_9 = 0, var_511_25 - 1 do
					local var_511_26 = var_511_23:GetChild(iter_511_9)

					if var_511_26.name == "" or not string.find(var_511_26.name, "split") then
						var_511_26.gameObject:SetActive(true)
					else
						var_511_26.gameObject:SetActive(false)
					end
				end
			end

			local var_511_27 = 0.001

			if var_511_24 <= arg_508_1.time_ and arg_508_1.time_ < var_511_24 + var_511_27 then
				local var_511_28 = (arg_508_1.time_ - var_511_24) / var_511_27
				local var_511_29 = Vector3.New(-67.4, -386.8, -295)

				var_511_23.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos104701, var_511_29, var_511_28)
			end

			if arg_508_1.time_ >= var_511_24 + var_511_27 and arg_508_1.time_ < var_511_24 + var_511_27 + arg_511_0 then
				var_511_23.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_511_30 = arg_508_1.actors_["10144"].transform
			local var_511_31 = 0

			if var_511_31 < arg_508_1.time_ and arg_508_1.time_ <= var_511_31 + arg_511_0 then
				arg_508_1.var_.moveOldPos10144 = var_511_30.localPosition
				var_511_30.localScale = Vector3.New(1, 1, 1)

				arg_508_1:CheckSpriteTmpPos("10144", 7)

				local var_511_32 = var_511_30.childCount

				for iter_511_10 = 0, var_511_32 - 1 do
					local var_511_33 = var_511_30:GetChild(iter_511_10)

					if var_511_33.name == "split_4" or not string.find(var_511_33.name, "split") then
						var_511_33.gameObject:SetActive(true)
					else
						var_511_33.gameObject:SetActive(false)
					end
				end
			end

			local var_511_34 = 0.001

			if var_511_31 <= arg_508_1.time_ and arg_508_1.time_ < var_511_31 + var_511_34 then
				local var_511_35 = (arg_508_1.time_ - var_511_31) / var_511_34
				local var_511_36 = Vector3.New(0, -2000, 0)

				var_511_30.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos10144, var_511_36, var_511_35)
			end

			if arg_508_1.time_ >= var_511_31 + var_511_34 and arg_508_1.time_ < var_511_31 + var_511_34 + arg_511_0 then
				var_511_30.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_511_37 = 0
			local var_511_38 = 0.425

			if var_511_37 < arg_508_1.time_ and arg_508_1.time_ <= var_511_37 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_39 = arg_508_1:FormatText(StoryNameCfg[1296].name)

				arg_508_1.leftNameTxt_.text = var_511_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_40 = arg_508_1:GetWordFromCfg(926021124)
				local var_511_41 = arg_508_1:FormatText(var_511_40.content)

				arg_508_1.text_.text = var_511_41

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_42 = 17
				local var_511_43 = utf8.len(var_511_41)
				local var_511_44 = var_511_42 <= 0 and var_511_38 or var_511_38 * (var_511_43 / var_511_42)

				if var_511_44 > 0 and var_511_38 < var_511_44 then
					arg_508_1.talkMaxDuration = var_511_44

					if var_511_44 + var_511_37 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_44 + var_511_37
					end
				end

				arg_508_1.text_.text = var_511_41
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021124", "story_v_out_926021.awb") ~= 0 then
					local var_511_45 = manager.audio:GetVoiceLength("story_v_out_926021", "926021124", "story_v_out_926021.awb") / 1000

					if var_511_45 + var_511_37 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_45 + var_511_37
					end

					if var_511_40.prefab_name ~= "" and arg_508_1.actors_[var_511_40.prefab_name] ~= nil then
						local var_511_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_40.prefab_name].transform, "story_v_out_926021", "926021124", "story_v_out_926021.awb")

						arg_508_1:RecordAudio("926021124", var_511_46)
						arg_508_1:RecordAudio("926021124", var_511_46)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_926021", "926021124", "story_v_out_926021.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_926021", "926021124", "story_v_out_926021.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_47 = math.max(var_511_38, arg_508_1.talkMaxDuration)

			if var_511_37 <= arg_508_1.time_ and arg_508_1.time_ < var_511_37 + var_511_47 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_37) / var_511_47

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_37 + var_511_47 and arg_508_1.time_ < var_511_37 + var_511_47 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play926021125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 926021125
		arg_512_1.duration_ = 5.43

		local var_512_0 = {
			zh = 5.066,
			ja = 5.433
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play926021126(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["10144"]
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.actorSpriteComps10144 == nil then
				arg_512_1.var_.actorSpriteComps10144 = var_515_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_515_2 = 0.2

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_2 and not isNil(var_515_0) then
				local var_515_3 = (arg_512_1.time_ - var_515_1) / var_515_2

				if arg_512_1.var_.actorSpriteComps10144 then
					for iter_515_0, iter_515_1 in pairs(arg_512_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_515_1 then
							if arg_512_1.isInRecall_ then
								local var_515_4 = Mathf.Lerp(iter_515_1.color.r, arg_512_1.hightColor1.r, var_515_3)
								local var_515_5 = Mathf.Lerp(iter_515_1.color.g, arg_512_1.hightColor1.g, var_515_3)
								local var_515_6 = Mathf.Lerp(iter_515_1.color.b, arg_512_1.hightColor1.b, var_515_3)

								iter_515_1.color = Color.New(var_515_4, var_515_5, var_515_6)
							else
								local var_515_7 = Mathf.Lerp(iter_515_1.color.r, 1, var_515_3)

								iter_515_1.color = Color.New(var_515_7, var_515_7, var_515_7)
							end
						end
					end
				end
			end

			if arg_512_1.time_ >= var_515_1 + var_515_2 and arg_512_1.time_ < var_515_1 + var_515_2 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.actorSpriteComps10144 then
				for iter_515_2, iter_515_3 in pairs(arg_512_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_515_3 then
						if arg_512_1.isInRecall_ then
							iter_515_3.color = arg_512_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_515_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_512_1.var_.actorSpriteComps10144 = nil
			end

			local var_515_8 = arg_512_1.actors_["104701"]
			local var_515_9 = 0

			if var_515_9 < arg_512_1.time_ and arg_512_1.time_ <= var_515_9 + arg_515_0 and not isNil(var_515_8) and arg_512_1.var_.actorSpriteComps104701 == nil then
				arg_512_1.var_.actorSpriteComps104701 = var_515_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_515_10 = 0.2

			if var_515_9 <= arg_512_1.time_ and arg_512_1.time_ < var_515_9 + var_515_10 and not isNil(var_515_8) then
				local var_515_11 = (arg_512_1.time_ - var_515_9) / var_515_10

				if arg_512_1.var_.actorSpriteComps104701 then
					for iter_515_4, iter_515_5 in pairs(arg_512_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_515_5 then
							if arg_512_1.isInRecall_ then
								local var_515_12 = Mathf.Lerp(iter_515_5.color.r, arg_512_1.hightColor2.r, var_515_11)
								local var_515_13 = Mathf.Lerp(iter_515_5.color.g, arg_512_1.hightColor2.g, var_515_11)
								local var_515_14 = Mathf.Lerp(iter_515_5.color.b, arg_512_1.hightColor2.b, var_515_11)

								iter_515_5.color = Color.New(var_515_12, var_515_13, var_515_14)
							else
								local var_515_15 = Mathf.Lerp(iter_515_5.color.r, 0.5, var_515_11)

								iter_515_5.color = Color.New(var_515_15, var_515_15, var_515_15)
							end
						end
					end
				end
			end

			if arg_512_1.time_ >= var_515_9 + var_515_10 and arg_512_1.time_ < var_515_9 + var_515_10 + arg_515_0 and not isNil(var_515_8) and arg_512_1.var_.actorSpriteComps104701 then
				for iter_515_6, iter_515_7 in pairs(arg_512_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_515_7 then
						if arg_512_1.isInRecall_ then
							iter_515_7.color = arg_512_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_515_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_512_1.var_.actorSpriteComps104701 = nil
			end

			local var_515_16 = arg_512_1.actors_["104701"].transform
			local var_515_17 = 0

			if var_515_17 < arg_512_1.time_ and arg_512_1.time_ <= var_515_17 + arg_515_0 then
				arg_512_1.var_.moveOldPos104701 = var_515_16.localPosition
				var_515_16.localScale = Vector3.New(1, 1, 1)

				arg_512_1:CheckSpriteTmpPos("104701", 3)

				local var_515_18 = var_515_16.childCount

				for iter_515_8 = 0, var_515_18 - 1 do
					local var_515_19 = var_515_16:GetChild(iter_515_8)

					if var_515_19.name == "split_4" or not string.find(var_515_19.name, "split") then
						var_515_19.gameObject:SetActive(true)
					else
						var_515_19.gameObject:SetActive(false)
					end
				end
			end

			local var_515_20 = 0.001

			if var_515_17 <= arg_512_1.time_ and arg_512_1.time_ < var_515_17 + var_515_20 then
				local var_515_21 = (arg_512_1.time_ - var_515_17) / var_515_20
				local var_515_22 = Vector3.New(-67.4, -386.8, -295)

				var_515_16.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos104701, var_515_22, var_515_21)
			end

			if arg_512_1.time_ >= var_515_17 + var_515_20 and arg_512_1.time_ < var_515_17 + var_515_20 + arg_515_0 then
				var_515_16.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_515_23 = arg_512_1.actors_["10144"].transform
			local var_515_24 = 0

			if var_515_24 < arg_512_1.time_ and arg_512_1.time_ <= var_515_24 + arg_515_0 then
				arg_512_1.var_.moveOldPos10144 = var_515_23.localPosition
				var_515_23.localScale = Vector3.New(1, 1, 1)

				arg_512_1:CheckSpriteTmpPos("10144", 3)

				local var_515_25 = var_515_23.childCount

				for iter_515_9 = 0, var_515_25 - 1 do
					local var_515_26 = var_515_23:GetChild(iter_515_9)

					if var_515_26.name == "split_1" or not string.find(var_515_26.name, "split") then
						var_515_26.gameObject:SetActive(true)
					else
						var_515_26.gameObject:SetActive(false)
					end
				end
			end

			local var_515_27 = 0.001

			if var_515_24 <= arg_512_1.time_ and arg_512_1.time_ < var_515_24 + var_515_27 then
				local var_515_28 = (arg_512_1.time_ - var_515_24) / var_515_27
				local var_515_29 = Vector3.New(-31.5, -381.1, -285.9)

				var_515_23.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos10144, var_515_29, var_515_28)
			end

			if arg_512_1.time_ >= var_515_24 + var_515_27 and arg_512_1.time_ < var_515_24 + var_515_27 + arg_515_0 then
				var_515_23.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_515_30 = 0
			local var_515_31 = 0.7

			if var_515_30 < arg_512_1.time_ and arg_512_1.time_ <= var_515_30 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_32 = arg_512_1:FormatText(StoryNameCfg[1297].name)

				arg_512_1.leftNameTxt_.text = var_515_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_33 = arg_512_1:GetWordFromCfg(926021125)
				local var_515_34 = arg_512_1:FormatText(var_515_33.content)

				arg_512_1.text_.text = var_515_34

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_35 = 28
				local var_515_36 = utf8.len(var_515_34)
				local var_515_37 = var_515_35 <= 0 and var_515_31 or var_515_31 * (var_515_36 / var_515_35)

				if var_515_37 > 0 and var_515_31 < var_515_37 then
					arg_512_1.talkMaxDuration = var_515_37

					if var_515_37 + var_515_30 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_37 + var_515_30
					end
				end

				arg_512_1.text_.text = var_515_34
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021125", "story_v_out_926021.awb") ~= 0 then
					local var_515_38 = manager.audio:GetVoiceLength("story_v_out_926021", "926021125", "story_v_out_926021.awb") / 1000

					if var_515_38 + var_515_30 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_38 + var_515_30
					end

					if var_515_33.prefab_name ~= "" and arg_512_1.actors_[var_515_33.prefab_name] ~= nil then
						local var_515_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_33.prefab_name].transform, "story_v_out_926021", "926021125", "story_v_out_926021.awb")

						arg_512_1:RecordAudio("926021125", var_515_39)
						arg_512_1:RecordAudio("926021125", var_515_39)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_926021", "926021125", "story_v_out_926021.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_926021", "926021125", "story_v_out_926021.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_40 = math.max(var_515_31, arg_512_1.talkMaxDuration)

			if var_515_30 <= arg_512_1.time_ and arg_512_1.time_ < var_515_30 + var_515_40 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_30) / var_515_40

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_30 + var_515_40 and arg_512_1.time_ < var_515_30 + var_515_40 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	Play926021126 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 926021126
		arg_516_1.duration_ = 4.23

		local var_516_0 = {
			zh = 3.633,
			ja = 4.233
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play926021127(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["10144"].transform
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 then
				arg_516_1.var_.moveOldPos10144 = var_519_0.localPosition
				var_519_0.localScale = Vector3.New(1, 1, 1)

				arg_516_1:CheckSpriteTmpPos("10144", 3)

				local var_519_2 = var_519_0.childCount

				for iter_519_0 = 0, var_519_2 - 1 do
					local var_519_3 = var_519_0:GetChild(iter_519_0)

					if var_519_3.name == "split_4" or not string.find(var_519_3.name, "split") then
						var_519_3.gameObject:SetActive(true)
					else
						var_519_3.gameObject:SetActive(false)
					end
				end
			end

			local var_519_4 = 0.001

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_4 then
				local var_519_5 = (arg_516_1.time_ - var_519_1) / var_519_4
				local var_519_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_519_0.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos10144, var_519_6, var_519_5)
			end

			if arg_516_1.time_ >= var_519_1 + var_519_4 and arg_516_1.time_ < var_519_1 + var_519_4 + arg_519_0 then
				var_519_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_519_7 = 0
			local var_519_8 = 0.525

			if var_519_7 < arg_516_1.time_ and arg_516_1.time_ <= var_519_7 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_9 = arg_516_1:FormatText(StoryNameCfg[1297].name)

				arg_516_1.leftNameTxt_.text = var_519_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_10 = arg_516_1:GetWordFromCfg(926021126)
				local var_519_11 = arg_516_1:FormatText(var_519_10.content)

				arg_516_1.text_.text = var_519_11

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_12 = 21
				local var_519_13 = utf8.len(var_519_11)
				local var_519_14 = var_519_12 <= 0 and var_519_8 or var_519_8 * (var_519_13 / var_519_12)

				if var_519_14 > 0 and var_519_8 < var_519_14 then
					arg_516_1.talkMaxDuration = var_519_14

					if var_519_14 + var_519_7 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_14 + var_519_7
					end
				end

				arg_516_1.text_.text = var_519_11
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021126", "story_v_out_926021.awb") ~= 0 then
					local var_519_15 = manager.audio:GetVoiceLength("story_v_out_926021", "926021126", "story_v_out_926021.awb") / 1000

					if var_519_15 + var_519_7 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_15 + var_519_7
					end

					if var_519_10.prefab_name ~= "" and arg_516_1.actors_[var_519_10.prefab_name] ~= nil then
						local var_519_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_10.prefab_name].transform, "story_v_out_926021", "926021126", "story_v_out_926021.awb")

						arg_516_1:RecordAudio("926021126", var_519_16)
						arg_516_1:RecordAudio("926021126", var_519_16)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_926021", "926021126", "story_v_out_926021.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_926021", "926021126", "story_v_out_926021.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_17 = math.max(var_519_8, arg_516_1.talkMaxDuration)

			if var_519_7 <= arg_516_1.time_ and arg_516_1.time_ < var_519_7 + var_519_17 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_7) / var_519_17

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_7 + var_519_17 and arg_516_1.time_ < var_519_7 + var_519_17 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play926021127 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 926021127
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play926021128(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = arg_520_1.actors_["10144"]
			local var_523_1 = 0

			if var_523_1 < arg_520_1.time_ and arg_520_1.time_ <= var_523_1 + arg_523_0 and not isNil(var_523_0) and arg_520_1.var_.actorSpriteComps10144 == nil then
				arg_520_1.var_.actorSpriteComps10144 = var_523_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_523_2 = 0.2

			if var_523_1 <= arg_520_1.time_ and arg_520_1.time_ < var_523_1 + var_523_2 and not isNil(var_523_0) then
				local var_523_3 = (arg_520_1.time_ - var_523_1) / var_523_2

				if arg_520_1.var_.actorSpriteComps10144 then
					for iter_523_0, iter_523_1 in pairs(arg_520_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_523_1 then
							if arg_520_1.isInRecall_ then
								local var_523_4 = Mathf.Lerp(iter_523_1.color.r, arg_520_1.hightColor2.r, var_523_3)
								local var_523_5 = Mathf.Lerp(iter_523_1.color.g, arg_520_1.hightColor2.g, var_523_3)
								local var_523_6 = Mathf.Lerp(iter_523_1.color.b, arg_520_1.hightColor2.b, var_523_3)

								iter_523_1.color = Color.New(var_523_4, var_523_5, var_523_6)
							else
								local var_523_7 = Mathf.Lerp(iter_523_1.color.r, 0.5, var_523_3)

								iter_523_1.color = Color.New(var_523_7, var_523_7, var_523_7)
							end
						end
					end
				end
			end

			if arg_520_1.time_ >= var_523_1 + var_523_2 and arg_520_1.time_ < var_523_1 + var_523_2 + arg_523_0 and not isNil(var_523_0) and arg_520_1.var_.actorSpriteComps10144 then
				for iter_523_2, iter_523_3 in pairs(arg_520_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_523_3 then
						if arg_520_1.isInRecall_ then
							iter_523_3.color = arg_520_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_523_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_520_1.var_.actorSpriteComps10144 = nil
			end

			local var_523_8 = 0
			local var_523_9 = 0.325

			if var_523_8 < arg_520_1.time_ and arg_520_1.time_ <= var_523_8 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_10 = arg_520_1:FormatText(StoryNameCfg[7].name)

				arg_520_1.leftNameTxt_.text = var_523_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_11 = arg_520_1:GetWordFromCfg(926021127)
				local var_523_12 = arg_520_1:FormatText(var_523_11.content)

				arg_520_1.text_.text = var_523_12

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_13 = 13
				local var_523_14 = utf8.len(var_523_12)
				local var_523_15 = var_523_13 <= 0 and var_523_9 or var_523_9 * (var_523_14 / var_523_13)

				if var_523_15 > 0 and var_523_9 < var_523_15 then
					arg_520_1.talkMaxDuration = var_523_15

					if var_523_15 + var_523_8 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_15 + var_523_8
					end
				end

				arg_520_1.text_.text = var_523_12
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_16 = math.max(var_523_9, arg_520_1.talkMaxDuration)

			if var_523_8 <= arg_520_1.time_ and arg_520_1.time_ < var_523_8 + var_523_16 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_8) / var_523_16

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_8 + var_523_16 and arg_520_1.time_ < var_523_8 + var_523_16 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play926021128 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 926021128
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
			arg_524_1.auto_ = false
		end

		function arg_524_1.playNext_(arg_526_0)
			arg_524_1.onStoryFinished_()
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0
			local var_527_1 = 0.575

			if var_527_0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_2 = arg_524_1:FormatText(StoryNameCfg[7].name)

				arg_524_1.leftNameTxt_.text = var_527_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_3 = arg_524_1:GetWordFromCfg(926021128)
				local var_527_4 = arg_524_1:FormatText(var_527_3.content)

				arg_524_1.text_.text = var_527_4

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 23
				local var_527_6 = utf8.len(var_527_4)
				local var_527_7 = var_527_5 <= 0 and var_527_1 or var_527_1 * (var_527_6 / var_527_5)

				if var_527_7 > 0 and var_527_1 < var_527_7 then
					arg_524_1.talkMaxDuration = var_527_7

					if var_527_7 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_7 + var_527_0
					end
				end

				arg_524_1.text_.text = var_527_4
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_8 = math.max(var_527_1, arg_524_1.talkMaxDuration)

			if var_527_0 <= arg_524_1.time_ and arg_524_1.time_ < var_527_0 + var_527_8 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_0) / var_527_8

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_0 + var_527_8 and arg_524_1.time_ < var_527_0 + var_527_8 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I22g",
		"TextureConfig/Background/ST0108",
		"TextureConfig/Background/ST0114"
	},
	voices = {
		"story_v_out_926021.awb"
	}
}
