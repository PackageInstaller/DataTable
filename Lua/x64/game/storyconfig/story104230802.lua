return {
	Play423082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423082001
		arg_1_1.duration_ = 4.97

		local var_1_0 = {
			zh = 4.966,
			ja = 4.866
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
				arg_1_0:Play423082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I25f"

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
				local var_4_5 = arg_1_1.bgs_.I25f

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
					if iter_4_0 ~= "I25f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_24 = "1083"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

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

			local var_4_28 = arg_1_1.actors_["1083"]
			local var_4_29 = 2

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1083 == nil then
				arg_1_1.var_.actorSpriteComps1083 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps1083 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1083 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1083 = nil
			end

			local var_4_36 = arg_1_1.actors_["1083"].transform
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos1083 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1083", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "split_7" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(-50, -345, -345)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1083, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_4_43 = 0.166666666666667
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "effect"

				arg_1_1:AudioAction(var_4_45, var_4_46, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_4_47 = 0
			local var_4_48 = 0.3

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = 0.500666666666667
			local var_4_54 = 1

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous.awb")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous")

				if var_4_58 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_58 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_58

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_58
						arg_1_1.bgmTxt2_.text = var_4_58
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

			local var_4_59 = 2
			local var_4_60 = 0.4

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_61 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_61:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[1332].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(423082001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 16
				local var_4_66 = utf8.len(var_4_64)
				local var_4_67 = var_4_65 <= 0 and var_4_60 or var_4_60 * (var_4_66 / var_4_65)

				if var_4_67 > 0 and var_4_60 < var_4_67 then
					arg_1_1.talkMaxDuration = var_4_67
					var_4_59 = var_4_59 + 0.3

					if var_4_67 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_59
					end
				end

				arg_1_1.text_.text = var_4_64
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082001", "story_v_out_423082.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_423082", "423082001", "story_v_out_423082.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_423082", "423082001", "story_v_out_423082.awb")

						arg_1_1:RecordAudio("423082001", var_4_69)
						arg_1_1:RecordAudio("423082001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423082", "423082001", "story_v_out_423082.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423082", "423082001", "story_v_out_423082.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_70 = var_4_59 + 0.3
			local var_4_71 = math.max(var_4_60, arg_1_1.talkMaxDuration)

			if var_4_70 <= arg_1_1.time_ and arg_1_1.time_ < var_4_70 + var_4_71 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_70) / var_4_71

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_70 + var_4_71 and arg_1_1.time_ < var_4_70 + var_4_71 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play423082002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423082002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423082003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1083"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1083 == nil then
				arg_9_1.var_.actorSpriteComps1083 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps1083 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								local var_12_4 = Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor2.r, var_12_3)
								local var_12_5 = Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor2.g, var_12_3)
								local var_12_6 = Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor2.b, var_12_3)

								iter_12_1.color = Color.New(var_12_4, var_12_5, var_12_6)
							else
								local var_12_7 = Mathf.Lerp(iter_12_1.color.r, 0.5, var_12_3)

								iter_12_1.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1083 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1083 = nil
			end

			local var_12_8 = arg_9_1.actors_["1083"].transform
			local var_12_9 = 0

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1.var_.moveOldPos1083 = var_12_8.localPosition
				var_12_8.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1083", 7)

				local var_12_10 = var_12_8.childCount

				for iter_12_4 = 0, var_12_10 - 1 do
					local var_12_11 = var_12_8:GetChild(iter_12_4)

					if var_12_11.name == "" or not string.find(var_12_11.name, "split") then
						var_12_11.gameObject:SetActive(true)
					else
						var_12_11.gameObject:SetActive(false)
					end
				end
			end

			local var_12_12 = 0.001

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_12 then
				local var_12_13 = (arg_9_1.time_ - var_12_9) / var_12_12
				local var_12_14 = Vector3.New(0, -2000, 0)

				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1083, var_12_14, var_12_13)
			end

			if arg_9_1.time_ >= var_12_9 + var_12_12 and arg_9_1.time_ < var_12_9 + var_12_12 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_15 = manager.ui.mainCamera.transform
			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_15.localPosition
			end

			local var_12_17 = 2

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 then
				local var_12_18 = (arg_9_1.time_ - var_12_16) / 0.066
				local var_12_19, var_12_20 = math.modf(var_12_18)

				var_12_15.localPosition = Vector3.New(var_12_20 * 0.02, var_12_20 * 0.02, var_12_20 * 0.02) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 then
				var_12_15.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_21 = manager.ui.mainCamera.transform
			local var_12_22 = 0

			if var_12_22 < arg_9_1.time_ and arg_9_1.time_ <= var_12_22 + arg_12_0 then
				local var_12_23 = arg_9_1.var_.effectzhuihuoche1
				local var_12_24
				local var_12_25 = var_12_21

				if not var_12_23 then
					var_12_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_12_25)
					var_12_23.name = "zhuihuoche1"
					arg_9_1.var_.effectzhuihuoche1 = var_12_23
				else
					var_12_23.transform:SetParent(var_12_25)
				end

				var_12_23.transform.localPosition = Vector3.New(-0.2, 0, 0)
				var_12_23.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_12_26 = manager.ui.mainCamera.transform
			local var_12_27 = 1

			if var_12_27 < arg_9_1.time_ and arg_9_1.time_ <= var_12_27 + arg_12_0 then
				local var_12_28 = arg_9_1.var_.effectzhuihuoche1

				if var_12_28 then
					Object.Destroy(var_12_28)

					arg_9_1.var_.effectzhuihuoche1 = nil
				end
			end

			local var_12_29 = manager.ui.mainCamera.transform
			local var_12_30 = 0.2

			if var_12_30 < arg_9_1.time_ and arg_9_1.time_ <= var_12_30 + arg_12_0 then
				local var_12_31 = arg_9_1.var_.effectzhuihuoche2
				local var_12_32
				local var_12_33 = var_12_29

				if not var_12_31 then
					var_12_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_12_33)
					var_12_31.name = "zhuihuoche2"
					arg_9_1.var_.effectzhuihuoche2 = var_12_31
				else
					var_12_31.transform:SetParent(var_12_33)
				end

				var_12_31.transform.localPosition = Vector3.New(0.5, 0, 0)
				var_12_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_12_34 = manager.ui.mainCamera.transform
			local var_12_35 = 1.2

			if var_12_35 < arg_9_1.time_ and arg_9_1.time_ <= var_12_35 + arg_12_0 then
				local var_12_36 = arg_9_1.var_.effectzhuihuoche2

				if var_12_36 then
					Object.Destroy(var_12_36)

					arg_9_1.var_.effectzhuihuoche2 = nil
				end
			end

			local var_12_37 = manager.ui.mainCamera.transform
			local var_12_38 = 0.4

			if var_12_38 < arg_9_1.time_ and arg_9_1.time_ <= var_12_38 + arg_12_0 then
				local var_12_39 = arg_9_1.var_.effectzhuihuoche3
				local var_12_40
				local var_12_41 = var_12_37

				if not var_12_39 then
					var_12_39 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_12_41)
					var_12_39.name = "zhuihuoche3"
					arg_9_1.var_.effectzhuihuoche3 = var_12_39
				else
					var_12_39.transform:SetParent(var_12_41)
				end

				var_12_39.transform.localPosition = Vector3.New(1, 0, 0)
				var_12_39.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_12_42 = manager.ui.mainCamera.transform
			local var_12_43 = 1.4

			if var_12_43 < arg_9_1.time_ and arg_9_1.time_ <= var_12_43 + arg_12_0 then
				local var_12_44 = arg_9_1.var_.effectzhuihuoche3

				if var_12_44 then
					Object.Destroy(var_12_44)

					arg_9_1.var_.effectzhuihuoche3 = nil
				end
			end

			local var_12_45 = manager.ui.mainCamera.transform
			local var_12_46 = 0

			if var_12_46 < arg_9_1.time_ and arg_9_1.time_ <= var_12_46 + arg_12_0 then
				local var_12_47 = arg_9_1.var_.effectaishizhuiche1
				local var_12_48
				local var_12_49 = var_12_45

				if not var_12_47 then
					var_12_47 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), var_12_49)
					var_12_47.name = "aishizhuiche1"
					arg_9_1.var_.effectaishizhuiche1 = var_12_47
				else
					var_12_47.transform:SetParent(var_12_49)
				end

				var_12_47.transform.localPosition = Vector3.New(0, 0, 0)
				var_12_47.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_12_50 = 0
			local var_12_51 = 1

			if var_12_50 < arg_9_1.time_ and arg_9_1.time_ <= var_12_50 + arg_12_0 then
				local var_12_52 = "play"
				local var_12_53 = "effect"

				arg_9_1:AudioAction(var_12_52, var_12_53, "se_story_1311", "se_story_1311_gun02", "")
			end

			local var_12_54 = 0
			local var_12_55 = 1.85

			if var_12_54 < arg_9_1.time_ and arg_9_1.time_ <= var_12_54 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_56 = arg_9_1:GetWordFromCfg(423082002)
				local var_12_57 = arg_9_1:FormatText(var_12_56.content)

				arg_9_1.text_.text = var_12_57

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_58 = 74
				local var_12_59 = utf8.len(var_12_57)
				local var_12_60 = var_12_58 <= 0 and var_12_55 or var_12_55 * (var_12_59 / var_12_58)

				if var_12_60 > 0 and var_12_55 < var_12_60 then
					arg_9_1.talkMaxDuration = var_12_60

					if var_12_60 + var_12_54 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_60 + var_12_54
					end
				end

				arg_9_1.text_.text = var_12_57
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_61 = math.max(var_12_55, arg_9_1.talkMaxDuration)

			if var_12_54 <= arg_9_1.time_ and arg_9_1.time_ < var_12_54 + var_12_61 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_54) / var_12_61

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_54 + var_12_61 and arg_9_1.time_ < var_12_54 + var_12_61 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423082003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423082003
		arg_13_1.duration_ = 4.3

		local var_13_0 = {
			zh = 3.966,
			ja = 4.3
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
				arg_13_0:Play423082004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1083"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1083 == nil then
				arg_13_1.var_.actorSpriteComps1083 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps1083 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								local var_16_4 = Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor1.r, var_16_3)
								local var_16_5 = Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor1.g, var_16_3)
								local var_16_6 = Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor1.b, var_16_3)

								iter_16_1.color = Color.New(var_16_4, var_16_5, var_16_6)
							else
								local var_16_7 = Mathf.Lerp(iter_16_1.color.r, 1, var_16_3)

								iter_16_1.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1083 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1083 = nil
			end

			local var_16_8 = arg_13_1.actors_["1083"].transform
			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.var_.moveOldPos1083 = var_16_8.localPosition
				var_16_8.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1083", 3)

				local var_16_10 = var_16_8.childCount

				for iter_16_4 = 0, var_16_10 - 1 do
					local var_16_11 = var_16_8:GetChild(iter_16_4)

					if var_16_11.name == "split_3" or not string.find(var_16_11.name, "split") then
						var_16_11.gameObject:SetActive(true)
					else
						var_16_11.gameObject:SetActive(false)
					end
				end
			end

			local var_16_12 = 0.001

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_12 then
				local var_16_13 = (arg_13_1.time_ - var_16_9) / var_16_12
				local var_16_14 = Vector3.New(-50, -345, -345)

				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1083, var_16_14, var_16_13)
			end

			if arg_13_1.time_ >= var_16_9 + var_16_12 and arg_13_1.time_ < var_16_9 + var_16_12 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_16_15 = arg_13_1.actors_["1083"]
			local var_16_16 = 0

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 then
				local var_16_17 = var_16_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_17 then
					arg_13_1.var_.alphaOldValue1083 = var_16_17.alpha
					arg_13_1.var_.characterEffect1083 = var_16_17
				end

				arg_13_1.var_.alphaOldValue1083 = 0
			end

			local var_16_18 = 0.6

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_18 then
				local var_16_19 = (arg_13_1.time_ - var_16_16) / var_16_18
				local var_16_20 = Mathf.Lerp(arg_13_1.var_.alphaOldValue1083, 1, var_16_19)

				if arg_13_1.var_.characterEffect1083 then
					arg_13_1.var_.characterEffect1083.alpha = var_16_20
				end
			end

			if arg_13_1.time_ >= var_16_16 + var_16_18 and arg_13_1.time_ < var_16_16 + var_16_18 + arg_16_0 and arg_13_1.var_.characterEffect1083 then
				arg_13_1.var_.characterEffect1083.alpha = 1
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_21 = 0.4
			local var_16_22 = 0.475

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_23 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_23:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_24 = arg_13_1:FormatText(StoryNameCfg[1332].name)

				arg_13_1.leftNameTxt_.text = var_16_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_25 = arg_13_1:GetWordFromCfg(423082003)
				local var_16_26 = arg_13_1:FormatText(var_16_25.content)

				arg_13_1.text_.text = var_16_26

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_27 = 19
				local var_16_28 = utf8.len(var_16_26)
				local var_16_29 = var_16_27 <= 0 and var_16_22 or var_16_22 * (var_16_28 / var_16_27)

				if var_16_29 > 0 and var_16_22 < var_16_29 then
					arg_13_1.talkMaxDuration = var_16_29
					var_16_21 = var_16_21 + 0.3

					if var_16_29 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_29 + var_16_21
					end
				end

				arg_13_1.text_.text = var_16_26
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082003", "story_v_out_423082.awb") ~= 0 then
					local var_16_30 = manager.audio:GetVoiceLength("story_v_out_423082", "423082003", "story_v_out_423082.awb") / 1000

					if var_16_30 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_30 + var_16_21
					end

					if var_16_25.prefab_name ~= "" and arg_13_1.actors_[var_16_25.prefab_name] ~= nil then
						local var_16_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_25.prefab_name].transform, "story_v_out_423082", "423082003", "story_v_out_423082.awb")

						arg_13_1:RecordAudio("423082003", var_16_31)
						arg_13_1:RecordAudio("423082003", var_16_31)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_423082", "423082003", "story_v_out_423082.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_423082", "423082003", "story_v_out_423082.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_32 = var_16_21 + 0.3
			local var_16_33 = math.max(var_16_22, arg_13_1.talkMaxDuration)

			if var_16_32 <= arg_13_1.time_ and arg_13_1.time_ < var_16_32 + var_16_33 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_32) / var_16_33

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_32 + var_16_33 and arg_13_1.time_ < var_16_32 + var_16_33 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423082004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 423082004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play423082005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1083"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.actorSpriteComps1083 == nil then
				arg_19_1.var_.actorSpriteComps1083 = var_22_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_2 = 0.2

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 and not isNil(var_22_0) then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.actorSpriteComps1083 then
					for iter_22_0, iter_22_1 in pairs(arg_19_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_22_1 then
							if arg_19_1.isInRecall_ then
								local var_22_4 = Mathf.Lerp(iter_22_1.color.r, arg_19_1.hightColor2.r, var_22_3)
								local var_22_5 = Mathf.Lerp(iter_22_1.color.g, arg_19_1.hightColor2.g, var_22_3)
								local var_22_6 = Mathf.Lerp(iter_22_1.color.b, arg_19_1.hightColor2.b, var_22_3)

								iter_22_1.color = Color.New(var_22_4, var_22_5, var_22_6)
							else
								local var_22_7 = Mathf.Lerp(iter_22_1.color.r, 0.5, var_22_3)

								iter_22_1.color = Color.New(var_22_7, var_22_7, var_22_7)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.actorSpriteComps1083 then
				for iter_22_2, iter_22_3 in pairs(arg_19_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_22_3 then
						if arg_19_1.isInRecall_ then
							iter_22_3.color = arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_22_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_19_1.var_.actorSpriteComps1083 = nil
			end

			local var_22_8 = arg_19_1.actors_["1083"].transform
			local var_22_9 = 0

			if var_22_9 < arg_19_1.time_ and arg_19_1.time_ <= var_22_9 + arg_22_0 then
				arg_19_1.var_.moveOldPos1083 = var_22_8.localPosition
				var_22_8.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1083", 3)

				local var_22_10 = var_22_8.childCount

				for iter_22_4 = 0, var_22_10 - 1 do
					local var_22_11 = var_22_8:GetChild(iter_22_4)

					if var_22_11.name == "split_7" or not string.find(var_22_11.name, "split") then
						var_22_11.gameObject:SetActive(true)
					else
						var_22_11.gameObject:SetActive(false)
					end
				end
			end

			local var_22_12 = 0.001

			if var_22_9 <= arg_19_1.time_ and arg_19_1.time_ < var_22_9 + var_22_12 then
				local var_22_13 = (arg_19_1.time_ - var_22_9) / var_22_12
				local var_22_14 = Vector3.New(-50, -345, -345)

				var_22_8.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1083, var_22_14, var_22_13)
			end

			if arg_19_1.time_ >= var_22_9 + var_22_12 and arg_19_1.time_ < var_22_9 + var_22_12 + arg_22_0 then
				var_22_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_22_15 = 0
			local var_22_16 = 0.425

			if var_22_15 < arg_19_1.time_ and arg_19_1.time_ <= var_22_15 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_17 = arg_19_1:FormatText(StoryNameCfg[7].name)

				arg_19_1.leftNameTxt_.text = var_22_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_18 = arg_19_1:GetWordFromCfg(423082004)
				local var_22_19 = arg_19_1:FormatText(var_22_18.content)

				arg_19_1.text_.text = var_22_19

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_20 = 17
				local var_22_21 = utf8.len(var_22_19)
				local var_22_22 = var_22_20 <= 0 and var_22_16 or var_22_16 * (var_22_21 / var_22_20)

				if var_22_22 > 0 and var_22_16 < var_22_22 then
					arg_19_1.talkMaxDuration = var_22_22

					if var_22_22 + var_22_15 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_22 + var_22_15
					end
				end

				arg_19_1.text_.text = var_22_19
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_23 = math.max(var_22_16, arg_19_1.talkMaxDuration)

			if var_22_15 <= arg_19_1.time_ and arg_19_1.time_ < var_22_15 + var_22_23 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_15) / var_22_23

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_15 + var_22_23 and arg_19_1.time_ < var_22_15 + var_22_23 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423082005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 423082005
		arg_23_1.duration_ = 5

		local var_23_0 = {
			zh = 3.4,
			ja = 5
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
				arg_23_0:Play423082006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1083"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.actorSpriteComps1083 == nil then
				arg_23_1.var_.actorSpriteComps1083 = var_26_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_2 = 0.2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.actorSpriteComps1083 then
					for iter_26_0, iter_26_1 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_26_1 then
							if arg_23_1.isInRecall_ then
								local var_26_4 = Mathf.Lerp(iter_26_1.color.r, arg_23_1.hightColor1.r, var_26_3)
								local var_26_5 = Mathf.Lerp(iter_26_1.color.g, arg_23_1.hightColor1.g, var_26_3)
								local var_26_6 = Mathf.Lerp(iter_26_1.color.b, arg_23_1.hightColor1.b, var_26_3)

								iter_26_1.color = Color.New(var_26_4, var_26_5, var_26_6)
							else
								local var_26_7 = Mathf.Lerp(iter_26_1.color.r, 1, var_26_3)

								iter_26_1.color = Color.New(var_26_7, var_26_7, var_26_7)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.actorSpriteComps1083 then
				for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_26_3 then
						if arg_23_1.isInRecall_ then
							iter_26_3.color = arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_26_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_23_1.var_.actorSpriteComps1083 = nil
			end

			local var_26_8 = arg_23_1.actors_["1083"].transform
			local var_26_9 = 0

			if var_26_9 < arg_23_1.time_ and arg_23_1.time_ <= var_26_9 + arg_26_0 then
				arg_23_1.var_.moveOldPos1083 = var_26_8.localPosition
				var_26_8.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("1083", 3)

				local var_26_10 = var_26_8.childCount

				for iter_26_4 = 0, var_26_10 - 1 do
					local var_26_11 = var_26_8:GetChild(iter_26_4)

					if var_26_11.name == "split_3" or not string.find(var_26_11.name, "split") then
						var_26_11.gameObject:SetActive(true)
					else
						var_26_11.gameObject:SetActive(false)
					end
				end
			end

			local var_26_12 = 0.001

			if var_26_9 <= arg_23_1.time_ and arg_23_1.time_ < var_26_9 + var_26_12 then
				local var_26_13 = (arg_23_1.time_ - var_26_9) / var_26_12
				local var_26_14 = Vector3.New(-50, -345, -345)

				var_26_8.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1083, var_26_14, var_26_13)
			end

			if arg_23_1.time_ >= var_26_9 + var_26_12 and arg_23_1.time_ < var_26_9 + var_26_12 + arg_26_0 then
				var_26_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_26_15 = 0
			local var_26_16 = 0.425

			if var_26_15 < arg_23_1.time_ and arg_23_1.time_ <= var_26_15 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_17 = arg_23_1:FormatText(StoryNameCfg[1332].name)

				arg_23_1.leftNameTxt_.text = var_26_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_18 = arg_23_1:GetWordFromCfg(423082005)
				local var_26_19 = arg_23_1:FormatText(var_26_18.content)

				arg_23_1.text_.text = var_26_19

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_20 = 17
				local var_26_21 = utf8.len(var_26_19)
				local var_26_22 = var_26_20 <= 0 and var_26_16 or var_26_16 * (var_26_21 / var_26_20)

				if var_26_22 > 0 and var_26_16 < var_26_22 then
					arg_23_1.talkMaxDuration = var_26_22

					if var_26_22 + var_26_15 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_22 + var_26_15
					end
				end

				arg_23_1.text_.text = var_26_19
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082005", "story_v_out_423082.awb") ~= 0 then
					local var_26_23 = manager.audio:GetVoiceLength("story_v_out_423082", "423082005", "story_v_out_423082.awb") / 1000

					if var_26_23 + var_26_15 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_23 + var_26_15
					end

					if var_26_18.prefab_name ~= "" and arg_23_1.actors_[var_26_18.prefab_name] ~= nil then
						local var_26_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_18.prefab_name].transform, "story_v_out_423082", "423082005", "story_v_out_423082.awb")

						arg_23_1:RecordAudio("423082005", var_26_24)
						arg_23_1:RecordAudio("423082005", var_26_24)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_423082", "423082005", "story_v_out_423082.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_423082", "423082005", "story_v_out_423082.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_25 = math.max(var_26_16, arg_23_1.talkMaxDuration)

			if var_26_15 <= arg_23_1.time_ and arg_23_1.time_ < var_26_15 + var_26_25 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_15) / var_26_25

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_15 + var_26_25 and arg_23_1.time_ < var_26_15 + var_26_25 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423082006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 423082006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play423082007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1083"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps1083 == nil then
				arg_27_1.var_.actorSpriteComps1083 = var_30_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_2 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.actorSpriteComps1083 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								local var_30_4 = Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor2.r, var_30_3)
								local var_30_5 = Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor2.g, var_30_3)
								local var_30_6 = Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor2.b, var_30_3)

								iter_30_1.color = Color.New(var_30_4, var_30_5, var_30_6)
							else
								local var_30_7 = Mathf.Lerp(iter_30_1.color.r, 0.5, var_30_3)

								iter_30_1.color = Color.New(var_30_7, var_30_7, var_30_7)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps1083 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_30_3 then
						if arg_27_1.isInRecall_ then
							iter_30_3.color = arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_30_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps1083 = nil
			end

			local var_30_8 = 0
			local var_30_9 = 0.6

			if var_30_8 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_10 = arg_27_1:FormatText(StoryNameCfg[7].name)

				arg_27_1.leftNameTxt_.text = var_30_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_11 = arg_27_1:GetWordFromCfg(423082006)
				local var_30_12 = arg_27_1:FormatText(var_30_11.content)

				arg_27_1.text_.text = var_30_12

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 24
				local var_30_14 = utf8.len(var_30_12)
				local var_30_15 = var_30_13 <= 0 and var_30_9 or var_30_9 * (var_30_14 / var_30_13)

				if var_30_15 > 0 and var_30_9 < var_30_15 then
					arg_27_1.talkMaxDuration = var_30_15

					if var_30_15 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_15 + var_30_8
					end
				end

				arg_27_1.text_.text = var_30_12
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_16 = math.max(var_30_9, arg_27_1.talkMaxDuration)

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_16 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_8) / var_30_16

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_8 + var_30_16 and arg_27_1.time_ < var_30_8 + var_30_16 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play423082007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 423082007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play423082008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1083"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1083 = var_34_0.localPosition
				var_34_0.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1083", 7)

				local var_34_2 = var_34_0.childCount

				for iter_34_0 = 0, var_34_2 - 1 do
					local var_34_3 = var_34_0:GetChild(iter_34_0)

					if var_34_3.name == "" or not string.find(var_34_3.name, "split") then
						var_34_3.gameObject:SetActive(true)
					else
						var_34_3.gameObject:SetActive(false)
					end
				end
			end

			local var_34_4 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_4 then
				local var_34_5 = (arg_31_1.time_ - var_34_1) / var_34_4
				local var_34_6 = Vector3.New(0, -2000, 0)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1083, var_34_6, var_34_5)
			end

			if arg_31_1.time_ >= var_34_1 + var_34_4 and arg_31_1.time_ < var_34_1 + var_34_4 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_34_7 = manager.ui.mainCamera.transform
			local var_34_8 = 0

			if var_34_8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				local var_34_9 = arg_31_1.var_.effectcheliangbaozhahongguang
				local var_34_10
				local var_34_11 = var_34_7

				if not var_34_9 then
					var_34_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), var_34_11)
					var_34_9.name = "cheliangbaozhahongguang"
					arg_31_1.var_.effectcheliangbaozhahongguang = var_34_9
				else
					var_34_9.transform:SetParent(var_34_11)
				end

				var_34_9.transform.localPosition = Vector3.New(0, 0, -2)
				var_34_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_34_12 = 1.7777777777777777
				local var_34_13 = Screen.width / Screen.height
				local var_34_14 = var_34_13 / var_34_12
				local var_34_15 = Mathf.Max(var_34_12 / var_34_13, 1)

				var_34_9.transform.localScale = Vector3.New(var_34_9.transform.localScale.x * var_34_14, var_34_9.transform.localScale.y * var_34_15, var_34_9.transform.localScale.z)
			end

			local var_34_16 = 0
			local var_34_17 = 1.9

			if var_34_16 < arg_31_1.time_ and arg_31_1.time_ <= var_34_16 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_18 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_18:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_19 = arg_31_1:GetWordFromCfg(423082007)
				local var_34_20 = arg_31_1:FormatText(var_34_19.content)

				arg_31_1.text_.text = var_34_20

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_21 = 76
				local var_34_22 = utf8.len(var_34_20)
				local var_34_23 = var_34_21 <= 0 and var_34_17 or var_34_17 * (var_34_22 / var_34_21)

				if var_34_23 > 0 and var_34_17 < var_34_23 then
					arg_31_1.talkMaxDuration = var_34_23
					var_34_16 = var_34_16 + 0.3

					if var_34_23 + var_34_16 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_23 + var_34_16
					end
				end

				arg_31_1.text_.text = var_34_20
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_24 = var_34_16 + 0.3
			local var_34_25 = math.max(var_34_17, arg_31_1.talkMaxDuration)

			if var_34_24 <= arg_31_1.time_ and arg_31_1.time_ < var_34_24 + var_34_25 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_24) / var_34_25

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_24 + var_34_25 and arg_31_1.time_ < var_34_24 + var_34_25 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423082008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423082008
		arg_37_1.duration_ = 6.03

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play423082009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_1 = 0.2

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_1 then
				local var_40_2 = (arg_37_1.time_ - var_40_0) / var_40_1
				local var_40_3 = Color.New(0.9716981, 0.4364897, 0)

				var_40_3.a = Mathf.Lerp(0, 1, var_40_2)
				arg_37_1.mask_.color = var_40_3
			end

			if arg_37_1.time_ >= var_40_0 + var_40_1 and arg_37_1.time_ < var_40_0 + var_40_1 + arg_40_0 then
				local var_40_4 = Color.New(0.9716981, 0.4364897, 0)

				var_40_4.a = 1
				arg_37_1.mask_.color = var_40_4
			end

			local var_40_5 = 0.2

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_6 = 1

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6
				local var_40_8 = Color.New(0.9716981, 0.4364897, 0)

				var_40_8.a = Mathf.Lerp(1, 0, var_40_7)
				arg_37_1.mask_.color = var_40_8
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 then
				local var_40_9 = Color.New(0.9716981, 0.4364897, 0)
				local var_40_10 = 0

				arg_37_1.mask_.enabled = false
				var_40_9.a = var_40_10
				arg_37_1.mask_.color = var_40_9
			end

			local var_40_11 = manager.ui.mainCamera.transform
			local var_40_12 = 0.2

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				local var_40_13 = arg_37_1.var_.effectqichezhale1
				local var_40_14
				local var_40_15 = var_40_11

				if not var_40_13 then
					var_40_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), var_40_15)
					var_40_13.name = "qichezhale1"
					arg_37_1.var_.effectqichezhale1 = var_40_13
				else
					var_40_13.transform:SetParent(var_40_15)
				end

				var_40_13.transform.localPosition = Vector3.New(0, 0, 5)
				var_40_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_40_16 = manager.ui.mainCameraCom_
				local var_40_17 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_40_16.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_40_18 = var_40_13.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_40_19 = 15
				local var_40_20 = 2 * var_40_19 * Mathf.Tan(var_40_16.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_40_16.aspect
				local var_40_21 = 1
				local var_40_22 = 1.7777777777777777

				if var_40_22 < var_40_16.aspect then
					var_40_21 = var_40_20 / (2 * var_40_19 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_40_22)
				end

				for iter_40_0, iter_40_1 in ipairs(var_40_18) do
					local var_40_23 = iter_40_1.transform.localScale

					iter_40_1.transform.localScale = Vector3.New(var_40_23.x / var_40_17 * var_40_21, var_40_23.y / var_40_17, var_40_23.z)
				end
			end

			local var_40_24 = manager.ui.mainCamera.transform
			local var_40_25 = 2.7

			if var_40_25 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 then
				local var_40_26 = arg_37_1.var_.effectqichezhale1

				if var_40_26 then
					Object.Destroy(var_40_26)

					arg_37_1.var_.effectqichezhale1 = nil
				end
			end

			local var_40_27 = manager.ui.mainCamera.transform
			local var_40_28 = 0.2

			if var_40_28 < arg_37_1.time_ and arg_37_1.time_ <= var_40_28 + arg_40_0 then
				local var_40_29 = arg_37_1.var_.effectaishizhuiche1

				if var_40_29 then
					Object.Destroy(var_40_29)

					arg_37_1.var_.effectaishizhuiche1 = nil
				end
			end

			local var_40_30 = manager.ui.mainCamera.transform
			local var_40_31 = 0.2

			if var_40_31 < arg_37_1.time_ and arg_37_1.time_ <= var_40_31 + arg_40_0 then
				arg_37_1.var_.shakeOldPos = var_40_30.localPosition
			end

			local var_40_32 = 1.5

			if var_40_31 <= arg_37_1.time_ and arg_37_1.time_ < var_40_31 + var_40_32 then
				local var_40_33 = (arg_37_1.time_ - var_40_31) / 0.066
				local var_40_34, var_40_35 = math.modf(var_40_33)

				var_40_30.localPosition = Vector3.New(var_40_35 * 0.13, var_40_35 * 0.13, var_40_35 * 0.13) + arg_37_1.var_.shakeOldPos
			end

			if arg_37_1.time_ >= var_40_31 + var_40_32 and arg_37_1.time_ < var_40_31 + var_40_32 + arg_40_0 then
				var_40_30.localPosition = arg_37_1.var_.shakeOldPos
			end

			local var_40_36 = 0.2
			local var_40_37 = 1

			if var_40_36 < arg_37_1.time_ and arg_37_1.time_ <= var_40_36 + arg_40_0 then
				local var_40_38 = "play"
				local var_40_39 = "effect"

				arg_37_1:AudioAction(var_40_38, var_40_39, "se_story_144", "se_story_144_smash", "")
			end

			local var_40_40 = manager.ui.mainCamera.transform
			local var_40_41 = 0

			if var_40_41 < arg_37_1.time_ and arg_37_1.time_ <= var_40_41 + arg_40_0 then
				local var_40_42 = arg_37_1.var_.effectcheliangbaozhahongguang

				if var_40_42 then
					Object.Destroy(var_40_42)

					arg_37_1.var_.effectcheliangbaozhahongguang = nil
				end
			end

			local var_40_43 = manager.ui.mainCamera.transform
			local var_40_44 = 0.3

			if var_40_44 < arg_37_1.time_ and arg_37_1.time_ <= var_40_44 + arg_40_0 then
				local var_40_45 = arg_37_1.var_.effectaishizhuiche1

				if var_40_45 then
					Object.Destroy(var_40_45)

					arg_37_1.var_.effectaishizhuiche1 = nil
				end
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_46 = 1.03333333333333
			local var_40_47 = 1.9

			if var_40_46 < arg_37_1.time_ and arg_37_1.time_ <= var_40_46 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_48 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_48:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_49 = arg_37_1:GetWordFromCfg(423082008)
				local var_40_50 = arg_37_1:FormatText(var_40_49.content)

				arg_37_1.text_.text = var_40_50

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_51 = 76
				local var_40_52 = utf8.len(var_40_50)
				local var_40_53 = var_40_51 <= 0 and var_40_47 or var_40_47 * (var_40_52 / var_40_51)

				if var_40_53 > 0 and var_40_47 < var_40_53 then
					arg_37_1.talkMaxDuration = var_40_53
					var_40_46 = var_40_46 + 0.3

					if var_40_53 + var_40_46 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_53 + var_40_46
					end
				end

				arg_37_1.text_.text = var_40_50
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_54 = var_40_46 + 0.3
			local var_40_55 = math.max(var_40_47, arg_37_1.talkMaxDuration)

			if var_40_54 <= arg_37_1.time_ and arg_37_1.time_ < var_40_54 + var_40_55 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_54) / var_40_55

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_54 + var_40_55 and arg_37_1.time_ < var_40_54 + var_40_55 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play423082009 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 423082009
		arg_43_1.duration_ = 4.9

		local var_43_0 = {
			zh = 3.666,
			ja = 4.9
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
				arg_43_0:Play423082010(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1083"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps1083 == nil then
				arg_43_1.var_.actorSpriteComps1083 = var_46_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_2 = 0.2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.actorSpriteComps1083 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps1083 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_46_3 then
						if arg_43_1.isInRecall_ then
							iter_46_3.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps1083 = nil
			end

			local var_46_8 = arg_43_1.actors_["1083"].transform
			local var_46_9 = 0

			if var_46_9 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 then
				arg_43_1.var_.moveOldPos1083 = var_46_8.localPosition
				var_46_8.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1083", 3)

				local var_46_10 = var_46_8.childCount

				for iter_46_4 = 0, var_46_10 - 1 do
					local var_46_11 = var_46_8:GetChild(iter_46_4)

					if var_46_11.name == "split_7" or not string.find(var_46_11.name, "split") then
						var_46_11.gameObject:SetActive(true)
					else
						var_46_11.gameObject:SetActive(false)
					end
				end
			end

			local var_46_12 = 0.001

			if var_46_9 <= arg_43_1.time_ and arg_43_1.time_ < var_46_9 + var_46_12 then
				local var_46_13 = (arg_43_1.time_ - var_46_9) / var_46_12
				local var_46_14 = Vector3.New(-50, -345, -345)

				var_46_8.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1083, var_46_14, var_46_13)
			end

			if arg_43_1.time_ >= var_46_9 + var_46_12 and arg_43_1.time_ < var_46_9 + var_46_12 + arg_46_0 then
				var_46_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_46_15 = 0
			local var_46_16 = 0.375

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_17 = arg_43_1:FormatText(StoryNameCfg[1332].name)

				arg_43_1.leftNameTxt_.text = var_46_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_18 = arg_43_1:GetWordFromCfg(423082009)
				local var_46_19 = arg_43_1:FormatText(var_46_18.content)

				arg_43_1.text_.text = var_46_19

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_20 = 15
				local var_46_21 = utf8.len(var_46_19)
				local var_46_22 = var_46_20 <= 0 and var_46_16 or var_46_16 * (var_46_21 / var_46_20)

				if var_46_22 > 0 and var_46_16 < var_46_22 then
					arg_43_1.talkMaxDuration = var_46_22

					if var_46_22 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_22 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_19
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082009", "story_v_out_423082.awb") ~= 0 then
					local var_46_23 = manager.audio:GetVoiceLength("story_v_out_423082", "423082009", "story_v_out_423082.awb") / 1000

					if var_46_23 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_23 + var_46_15
					end

					if var_46_18.prefab_name ~= "" and arg_43_1.actors_[var_46_18.prefab_name] ~= nil then
						local var_46_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_18.prefab_name].transform, "story_v_out_423082", "423082009", "story_v_out_423082.awb")

						arg_43_1:RecordAudio("423082009", var_46_24)
						arg_43_1:RecordAudio("423082009", var_46_24)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_423082", "423082009", "story_v_out_423082.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_423082", "423082009", "story_v_out_423082.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_25 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 <= arg_43_1.time_ and arg_43_1.time_ < var_46_15 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_15) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_15 + var_46_25 and arg_43_1.time_ < var_46_15 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play423082010 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 423082010
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play423082011(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1083"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps1083 == nil then
				arg_47_1.var_.actorSpriteComps1083 = var_50_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_2 = 0.2

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.actorSpriteComps1083 then
					for iter_50_0, iter_50_1 in pairs(arg_47_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_50_1 then
							if arg_47_1.isInRecall_ then
								local var_50_4 = Mathf.Lerp(iter_50_1.color.r, arg_47_1.hightColor2.r, var_50_3)
								local var_50_5 = Mathf.Lerp(iter_50_1.color.g, arg_47_1.hightColor2.g, var_50_3)
								local var_50_6 = Mathf.Lerp(iter_50_1.color.b, arg_47_1.hightColor2.b, var_50_3)

								iter_50_1.color = Color.New(var_50_4, var_50_5, var_50_6)
							else
								local var_50_7 = Mathf.Lerp(iter_50_1.color.r, 0.5, var_50_3)

								iter_50_1.color = Color.New(var_50_7, var_50_7, var_50_7)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps1083 then
				for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_50_3 then
						if arg_47_1.isInRecall_ then
							iter_50_3.color = arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_50_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps1083 = nil
			end

			local var_50_8 = 0
			local var_50_9 = 0.325

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_10 = arg_47_1:FormatText(StoryNameCfg[7].name)

				arg_47_1.leftNameTxt_.text = var_50_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_11 = arg_47_1:GetWordFromCfg(423082010)
				local var_50_12 = arg_47_1:FormatText(var_50_11.content)

				arg_47_1.text_.text = var_50_12

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 13
				local var_50_14 = utf8.len(var_50_12)
				local var_50_15 = var_50_13 <= 0 and var_50_9 or var_50_9 * (var_50_14 / var_50_13)

				if var_50_15 > 0 and var_50_9 < var_50_15 then
					arg_47_1.talkMaxDuration = var_50_15

					if var_50_15 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_15 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_12
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play423082011 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 423082011
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play423082012(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1083"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1083 = var_54_0.localPosition
				var_54_0.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1083", 7)

				local var_54_2 = var_54_0.childCount

				for iter_54_0 = 0, var_54_2 - 1 do
					local var_54_3 = var_54_0:GetChild(iter_54_0)

					if var_54_3.name == "" or not string.find(var_54_3.name, "split") then
						var_54_3.gameObject:SetActive(true)
					else
						var_54_3.gameObject:SetActive(false)
					end
				end
			end

			local var_54_4 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_4 then
				local var_54_5 = (arg_51_1.time_ - var_54_1) / var_54_4
				local var_54_6 = Vector3.New(0, -2000, 0)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1083, var_54_6, var_54_5)
			end

			if arg_51_1.time_ >= var_54_1 + var_54_4 and arg_51_1.time_ < var_54_1 + var_54_4 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_54_7 = 0.233333333333333
			local var_54_8 = 1

			if var_54_7 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 then
				local var_54_9 = "play"
				local var_54_10 = "effect"

				arg_51_1:AudioAction(var_54_9, var_54_10, "se_story_140", "se_story_140_footstep_run02", "")
			end

			local var_54_11 = 0
			local var_54_12 = 1.55

			if var_54_11 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_13 = arg_51_1:GetWordFromCfg(423082011)
				local var_54_14 = arg_51_1:FormatText(var_54_13.content)

				arg_51_1.text_.text = var_54_14

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_15 = 62
				local var_54_16 = utf8.len(var_54_14)
				local var_54_17 = var_54_15 <= 0 and var_54_12 or var_54_12 * (var_54_16 / var_54_15)

				if var_54_17 > 0 and var_54_12 < var_54_17 then
					arg_51_1.talkMaxDuration = var_54_17

					if var_54_17 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_17 + var_54_11
					end
				end

				arg_51_1.text_.text = var_54_14
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_18 = math.max(var_54_12, arg_51_1.talkMaxDuration)

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_18 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_11) / var_54_18

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_11 + var_54_18 and arg_51_1.time_ < var_54_11 + var_54_18 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423082012 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 423082012
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play423082013(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.65

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[7].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(423082012)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 26
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_8 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_8 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_8

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_8 and arg_55_1.time_ < var_58_0 + var_58_8 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play423082013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 423082013
		arg_59_1.duration_ = 6.43

		local var_59_0 = {
			zh = 5.566,
			ja = 6.433
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
				arg_59_0:Play423082014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.3

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				local var_62_2 = "play"
				local var_62_3 = "music"

				arg_59_1:AudioAction(var_62_2, var_62_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_62_4 = ""
				local var_62_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_62_5 ~= "" then
					if arg_59_1.bgmTxt_.text ~= var_62_5 and arg_59_1.bgmTxt_.text ~= "" then
						if arg_59_1.bgmTxt2_.text ~= "" then
							arg_59_1.bgmTxt_.text = arg_59_1.bgmTxt2_.text
						end

						arg_59_1.bgmTxt2_.text = var_62_5

						arg_59_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_59_1.bgmTxt_.text = var_62_5
						arg_59_1.bgmTxt2_.text = var_62_5
					end

					if arg_59_1.bgmTimer then
						arg_59_1.bgmTimer:Stop()

						arg_59_1.bgmTimer = nil
					end

					if arg_59_1.settingData.show_music_name == 1 then
						arg_59_1.musicController:SetSelectedState("show")
						arg_59_1.musicAnimator_:Play("open", 0, 0)

						if arg_59_1.settingData.music_time ~= 0 then
							arg_59_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_59_1.settingData.music_time), function()
								if arg_59_1 == nil or isNil(arg_59_1.bgmTxt_) then
									return
								end

								arg_59_1.musicController:SetSelectedState("hide")
								arg_59_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_62_6 = 0
			local var_62_7 = 0.5

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_8 = arg_59_1:FormatText(StoryNameCfg[1334].name)

				arg_59_1.leftNameTxt_.text = var_62_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_9 = arg_59_1:GetWordFromCfg(423082013)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 20
				local var_62_12 = utf8.len(var_62_10)
				local var_62_13 = var_62_11 <= 0 and var_62_7 or var_62_7 * (var_62_12 / var_62_11)

				if var_62_13 > 0 and var_62_7 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082013", "story_v_out_423082.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_423082", "423082013", "story_v_out_423082.awb") / 1000

					if var_62_14 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_6
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_out_423082", "423082013", "story_v_out_423082.awb")

						arg_59_1:RecordAudio("423082013", var_62_15)
						arg_59_1:RecordAudio("423082013", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_423082", "423082013", "story_v_out_423082.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_423082", "423082013", "story_v_out_423082.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_16 and arg_59_1.time_ < var_62_6 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play423082014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 423082014
		arg_64_1.duration_ = 5.37

		local var_64_0 = {
			zh = 4.166,
			ja = 5.366
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
				arg_64_0:Play423082015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1083"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1083 == nil then
				arg_64_1.var_.actorSpriteComps1083 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps1083 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1083 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps1083 = nil
			end

			local var_67_8 = arg_64_1.actors_["1083"].transform
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				arg_64_1.var_.moveOldPos1083 = var_67_8.localPosition
				var_67_8.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("1083", 3)

				local var_67_10 = var_67_8.childCount

				for iter_67_4 = 0, var_67_10 - 1 do
					local var_67_11 = var_67_8:GetChild(iter_67_4)

					if var_67_11.name == "split_6" or not string.find(var_67_11.name, "split") then
						var_67_11.gameObject:SetActive(true)
					else
						var_67_11.gameObject:SetActive(false)
					end
				end
			end

			local var_67_12 = 0.001

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_9) / var_67_12
				local var_67_14 = Vector3.New(-50, -345, -345)

				var_67_8.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1083, var_67_14, var_67_13)
			end

			if arg_64_1.time_ >= var_67_9 + var_67_12 and arg_64_1.time_ < var_67_9 + var_67_12 + arg_67_0 then
				var_67_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_67_15 = 0
			local var_67_16 = 0.3

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				local var_67_17 = "play"
				local var_67_18 = "music"

				arg_64_1:AudioAction(var_67_17, var_67_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_67_19 = ""
				local var_67_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_67_20 ~= "" then
					if arg_64_1.bgmTxt_.text ~= var_67_20 and arg_64_1.bgmTxt_.text ~= "" then
						if arg_64_1.bgmTxt2_.text ~= "" then
							arg_64_1.bgmTxt_.text = arg_64_1.bgmTxt2_.text
						end

						arg_64_1.bgmTxt2_.text = var_67_20

						arg_64_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_64_1.bgmTxt_.text = var_67_20
						arg_64_1.bgmTxt2_.text = var_67_20
					end

					if arg_64_1.bgmTimer then
						arg_64_1.bgmTimer:Stop()

						arg_64_1.bgmTimer = nil
					end

					if arg_64_1.settingData.show_music_name == 1 then
						arg_64_1.musicController:SetSelectedState("show")
						arg_64_1.musicAnimator_:Play("open", 0, 0)

						if arg_64_1.settingData.music_time ~= 0 then
							arg_64_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_64_1.settingData.music_time), function()
								if arg_64_1 == nil or isNil(arg_64_1.bgmTxt_) then
									return
								end

								arg_64_1.musicController:SetSelectedState("hide")
								arg_64_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_67_21 = 0.500666666666667
			local var_67_22 = 1

			if var_67_21 < arg_64_1.time_ and arg_64_1.time_ <= var_67_21 + arg_67_0 then
				local var_67_23 = "play"
				local var_67_24 = "music"

				arg_64_1:AudioAction(var_67_23, var_67_24, "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street.awb")

				local var_67_25 = ""
				local var_67_26 = manager.audio:GetAudioName("bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street")

				if var_67_26 ~= "" then
					if arg_64_1.bgmTxt_.text ~= var_67_26 and arg_64_1.bgmTxt_.text ~= "" then
						if arg_64_1.bgmTxt2_.text ~= "" then
							arg_64_1.bgmTxt_.text = arg_64_1.bgmTxt2_.text
						end

						arg_64_1.bgmTxt2_.text = var_67_26

						arg_64_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_64_1.bgmTxt_.text = var_67_26
						arg_64_1.bgmTxt2_.text = var_67_26
					end

					if arg_64_1.bgmTimer then
						arg_64_1.bgmTimer:Stop()

						arg_64_1.bgmTimer = nil
					end

					if arg_64_1.settingData.show_music_name == 1 then
						arg_64_1.musicController:SetSelectedState("show")
						arg_64_1.musicAnimator_:Play("open", 0, 0)

						if arg_64_1.settingData.music_time ~= 0 then
							arg_64_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_64_1.settingData.music_time), function()
								if arg_64_1 == nil or isNil(arg_64_1.bgmTxt_) then
									return
								end

								arg_64_1.musicController:SetSelectedState("hide")
								arg_64_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_67_27 = 0
			local var_67_28 = 0.5

			if var_67_27 < arg_64_1.time_ and arg_64_1.time_ <= var_67_27 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_29 = arg_64_1:FormatText(StoryNameCfg[1332].name)

				arg_64_1.leftNameTxt_.text = var_67_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_30 = arg_64_1:GetWordFromCfg(423082014)
				local var_67_31 = arg_64_1:FormatText(var_67_30.content)

				arg_64_1.text_.text = var_67_31

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_32 = 20
				local var_67_33 = utf8.len(var_67_31)
				local var_67_34 = var_67_32 <= 0 and var_67_28 or var_67_28 * (var_67_33 / var_67_32)

				if var_67_34 > 0 and var_67_28 < var_67_34 then
					arg_64_1.talkMaxDuration = var_67_34

					if var_67_34 + var_67_27 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_34 + var_67_27
					end
				end

				arg_64_1.text_.text = var_67_31
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082014", "story_v_out_423082.awb") ~= 0 then
					local var_67_35 = manager.audio:GetVoiceLength("story_v_out_423082", "423082014", "story_v_out_423082.awb") / 1000

					if var_67_35 + var_67_27 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_35 + var_67_27
					end

					if var_67_30.prefab_name ~= "" and arg_64_1.actors_[var_67_30.prefab_name] ~= nil then
						local var_67_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_30.prefab_name].transform, "story_v_out_423082", "423082014", "story_v_out_423082.awb")

						arg_64_1:RecordAudio("423082014", var_67_36)
						arg_64_1:RecordAudio("423082014", var_67_36)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_423082", "423082014", "story_v_out_423082.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_423082", "423082014", "story_v_out_423082.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_37 = math.max(var_67_28, arg_64_1.talkMaxDuration)

			if var_67_27 <= arg_64_1.time_ and arg_64_1.time_ < var_67_27 + var_67_37 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_27) / var_67_37

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_27 + var_67_37 and arg_64_1.time_ < var_67_27 + var_67_37 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423082015 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 423082015
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play423082016(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1083"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps1083 == nil then
				arg_70_1.var_.actorSpriteComps1083 = var_73_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.actorSpriteComps1083 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								local var_73_4 = Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor2.r, var_73_3)
								local var_73_5 = Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor2.g, var_73_3)
								local var_73_6 = Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor2.b, var_73_3)

								iter_73_1.color = Color.New(var_73_4, var_73_5, var_73_6)
							else
								local var_73_7 = Mathf.Lerp(iter_73_1.color.r, 0.5, var_73_3)

								iter_73_1.color = Color.New(var_73_7, var_73_7, var_73_7)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps1083 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_73_3 then
						if arg_70_1.isInRecall_ then
							iter_73_3.color = arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_73_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps1083 = nil
			end

			local var_73_8 = arg_70_1.actors_["1083"].transform
			local var_73_9 = 0

			if var_73_9 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 then
				arg_70_1.var_.moveOldPos1083 = var_73_8.localPosition
				var_73_8.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1083", 7)

				local var_73_10 = var_73_8.childCount

				for iter_73_4 = 0, var_73_10 - 1 do
					local var_73_11 = var_73_8:GetChild(iter_73_4)

					if var_73_11.name == "" or not string.find(var_73_11.name, "split") then
						var_73_11.gameObject:SetActive(true)
					else
						var_73_11.gameObject:SetActive(false)
					end
				end
			end

			local var_73_12 = 0.001

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_12 then
				local var_73_13 = (arg_70_1.time_ - var_73_9) / var_73_12
				local var_73_14 = Vector3.New(0, -2000, 0)

				var_73_8.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1083, var_73_14, var_73_13)
			end

			if arg_70_1.time_ >= var_73_9 + var_73_12 and arg_70_1.time_ < var_73_9 + var_73_12 + arg_73_0 then
				var_73_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_73_15 = 0
			local var_73_16 = 1.7

			if var_73_15 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_17 = arg_70_1:GetWordFromCfg(423082015)
				local var_73_18 = arg_70_1:FormatText(var_73_17.content)

				arg_70_1.text_.text = var_73_18

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_19 = 68
				local var_73_20 = utf8.len(var_73_18)
				local var_73_21 = var_73_19 <= 0 and var_73_16 or var_73_16 * (var_73_20 / var_73_19)

				if var_73_21 > 0 and var_73_16 < var_73_21 then
					arg_70_1.talkMaxDuration = var_73_21

					if var_73_21 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_21 + var_73_15
					end
				end

				arg_70_1.text_.text = var_73_18
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_22 = math.max(var_73_16, arg_70_1.talkMaxDuration)

			if var_73_15 <= arg_70_1.time_ and arg_70_1.time_ < var_73_15 + var_73_22 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_15) / var_73_22

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_15 + var_73_22 and arg_70_1.time_ < var_73_15 + var_73_22 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play423082016 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 423082016
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play423082017(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.65

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(423082016)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 26
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play423082017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 423082017
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play423082018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.75

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[7].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:GetWordFromCfg(423082017)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 30
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_8 and arg_78_1.time_ < var_81_0 + var_81_8 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play423082018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 423082018
		arg_82_1.duration_ = 10.87

		local var_82_0 = {
			zh = 6.733,
			ja = 10.866
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
				arg_82_0:Play423082019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = manager.ui.mainCamera.transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.shakeOldPos = var_85_0.localPosition
			end

			local var_85_2 = 0.6

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / 0.066
				local var_85_4, var_85_5 = math.modf(var_85_3)

				var_85_0.localPosition = Vector3.New(var_85_5 * 0.13, var_85_5 * 0.13, var_85_5 * 0.13) + arg_82_1.var_.shakeOldPos
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = arg_82_1.var_.shakeOldPos
			end

			local var_85_6 = 0

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			local var_85_7 = 0.6

			if arg_82_1.time_ >= var_85_6 + var_85_7 and arg_82_1.time_ < var_85_6 + var_85_7 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_8 = 0
			local var_85_9 = 0.5

			if var_85_8 < arg_82_1.time_ and arg_82_1.time_ <= var_85_8 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_10 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_10:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_11 = arg_82_1:FormatText(StoryNameCfg[1334].name)

				arg_82_1.leftNameTxt_.text = var_85_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_12 = arg_82_1:GetWordFromCfg(423082018)
				local var_85_13 = arg_82_1:FormatText(var_85_12.content)

				arg_82_1.text_.text = var_85_13

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_14 = 20
				local var_85_15 = utf8.len(var_85_13)
				local var_85_16 = var_85_14 <= 0 and var_85_9 or var_85_9 * (var_85_15 / var_85_14)

				if var_85_16 > 0 and var_85_9 < var_85_16 then
					arg_82_1.talkMaxDuration = var_85_16
					var_85_8 = var_85_8 + 0.3

					if var_85_16 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_16 + var_85_8
					end
				end

				arg_82_1.text_.text = var_85_13
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082018", "story_v_out_423082.awb") ~= 0 then
					local var_85_17 = manager.audio:GetVoiceLength("story_v_out_423082", "423082018", "story_v_out_423082.awb") / 1000

					if var_85_17 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_17 + var_85_8
					end

					if var_85_12.prefab_name ~= "" and arg_82_1.actors_[var_85_12.prefab_name] ~= nil then
						local var_85_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_12.prefab_name].transform, "story_v_out_423082", "423082018", "story_v_out_423082.awb")

						arg_82_1:RecordAudio("423082018", var_85_18)
						arg_82_1:RecordAudio("423082018", var_85_18)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_423082", "423082018", "story_v_out_423082.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_423082", "423082018", "story_v_out_423082.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_19 = var_85_8 + 0.3
			local var_85_20 = math.max(var_85_9, arg_82_1.talkMaxDuration)

			if var_85_19 <= arg_82_1.time_ and arg_82_1.time_ < var_85_19 + var_85_20 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_19) / var_85_20

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_19 + var_85_20 and arg_82_1.time_ < var_85_19 + var_85_20 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play423082019 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 423082019
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play423082020(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1.625

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_2 = arg_88_1:GetWordFromCfg(423082019)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 65
				local var_91_5 = utf8.len(var_91_3)
				local var_91_6 = var_91_4 <= 0 and var_91_1 or var_91_1 * (var_91_5 / var_91_4)

				if var_91_6 > 0 and var_91_1 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_7 and arg_88_1.time_ < var_91_0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play423082020 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 423082020
		arg_92_1.duration_ = 1.3

		local var_92_0 = {
			zh = 0.999999999999,
			ja = 1.3
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
				arg_92_0:Play423082021(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1083"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1083 = var_95_0.localPosition
				var_95_0.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1083", 3)

				local var_95_2 = var_95_0.childCount

				for iter_95_0 = 0, var_95_2 - 1 do
					local var_95_3 = var_95_0:GetChild(iter_95_0)

					if var_95_3.name == "split_6" or not string.find(var_95_3.name, "split") then
						var_95_3.gameObject:SetActive(true)
					else
						var_95_3.gameObject:SetActive(false)
					end
				end
			end

			local var_95_4 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_4 then
				local var_95_5 = (arg_92_1.time_ - var_95_1) / var_95_4
				local var_95_6 = Vector3.New(-50, -345, -345)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1083, var_95_6, var_95_5)
			end

			if arg_92_1.time_ >= var_95_1 + var_95_4 and arg_92_1.time_ < var_95_1 + var_95_4 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_95_7 = arg_92_1.actors_["1083"]
			local var_95_8 = 0

			if var_95_8 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 and not isNil(var_95_7) and arg_92_1.var_.actorSpriteComps1083 == nil then
				arg_92_1.var_.actorSpriteComps1083 = var_95_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_9 = 0.2

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_9 and not isNil(var_95_7) then
				local var_95_10 = (arg_92_1.time_ - var_95_8) / var_95_9

				if arg_92_1.var_.actorSpriteComps1083 then
					for iter_95_1, iter_95_2 in pairs(arg_92_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_95_2 then
							if arg_92_1.isInRecall_ then
								local var_95_11 = Mathf.Lerp(iter_95_2.color.r, arg_92_1.hightColor1.r, var_95_10)
								local var_95_12 = Mathf.Lerp(iter_95_2.color.g, arg_92_1.hightColor1.g, var_95_10)
								local var_95_13 = Mathf.Lerp(iter_95_2.color.b, arg_92_1.hightColor1.b, var_95_10)

								iter_95_2.color = Color.New(var_95_11, var_95_12, var_95_13)
							else
								local var_95_14 = Mathf.Lerp(iter_95_2.color.r, 1, var_95_10)

								iter_95_2.color = Color.New(var_95_14, var_95_14, var_95_14)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_8 + var_95_9 and arg_92_1.time_ < var_95_8 + var_95_9 + arg_95_0 and not isNil(var_95_7) and arg_92_1.var_.actorSpriteComps1083 then
				for iter_95_3, iter_95_4 in pairs(arg_92_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_95_4 then
						if arg_92_1.isInRecall_ then
							iter_95_4.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_95_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps1083 = nil
			end

			local var_95_15 = 0
			local var_95_16 = 0.05

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_17 = arg_92_1:FormatText(StoryNameCfg[1341].name)

				arg_92_1.leftNameTxt_.text = var_95_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_18 = arg_92_1:GetWordFromCfg(423082020)
				local var_95_19 = arg_92_1:FormatText(var_95_18.content)

				arg_92_1.text_.text = var_95_19

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_20 = 2
				local var_95_21 = utf8.len(var_95_19)
				local var_95_22 = var_95_20 <= 0 and var_95_16 or var_95_16 * (var_95_21 / var_95_20)

				if var_95_22 > 0 and var_95_16 < var_95_22 then
					arg_92_1.talkMaxDuration = var_95_22

					if var_95_22 + var_95_15 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_22 + var_95_15
					end
				end

				arg_92_1.text_.text = var_95_19
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082020", "story_v_out_423082.awb") ~= 0 then
					local var_95_23 = manager.audio:GetVoiceLength("story_v_out_423082", "423082020", "story_v_out_423082.awb") / 1000

					if var_95_23 + var_95_15 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_23 + var_95_15
					end

					if var_95_18.prefab_name ~= "" and arg_92_1.actors_[var_95_18.prefab_name] ~= nil then
						local var_95_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_18.prefab_name].transform, "story_v_out_423082", "423082020", "story_v_out_423082.awb")

						arg_92_1:RecordAudio("423082020", var_95_24)
						arg_92_1:RecordAudio("423082020", var_95_24)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_423082", "423082020", "story_v_out_423082.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_423082", "423082020", "story_v_out_423082.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_25 = math.max(var_95_16, arg_92_1.talkMaxDuration)

			if var_95_15 <= arg_92_1.time_ and arg_92_1.time_ < var_95_15 + var_95_25 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_15) / var_95_25

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_15 + var_95_25 and arg_92_1.time_ < var_95_15 + var_95_25 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423082021 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 423082021
		arg_96_1.duration_ = 4.67

		local var_96_0 = {
			zh = 4.666,
			ja = 3.8
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play423082022(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1083"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1083 = var_99_0.localPosition
				var_99_0.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1083", 3)

				local var_99_2 = var_99_0.childCount

				for iter_99_0 = 0, var_99_2 - 1 do
					local var_99_3 = var_99_0:GetChild(iter_99_0)

					if var_99_3.name == "split_6" or not string.find(var_99_3.name, "split") then
						var_99_3.gameObject:SetActive(true)
					else
						var_99_3.gameObject:SetActive(false)
					end
				end
			end

			local var_99_4 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_4 then
				local var_99_5 = (arg_96_1.time_ - var_99_1) / var_99_4
				local var_99_6 = Vector3.New(-50, -345, -345)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1083, var_99_6, var_99_5)
			end

			if arg_96_1.time_ >= var_99_1 + var_99_4 and arg_96_1.time_ < var_99_1 + var_99_4 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_99_7 = 0
			local var_99_8 = 0.425

			if var_99_7 < arg_96_1.time_ and arg_96_1.time_ <= var_99_7 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_9 = arg_96_1:FormatText(StoryNameCfg[1332].name)

				arg_96_1.leftNameTxt_.text = var_99_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_10 = arg_96_1:GetWordFromCfg(423082021)
				local var_99_11 = arg_96_1:FormatText(var_99_10.content)

				arg_96_1.text_.text = var_99_11

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_12 = 17
				local var_99_13 = utf8.len(var_99_11)
				local var_99_14 = var_99_12 <= 0 and var_99_8 or var_99_8 * (var_99_13 / var_99_12)

				if var_99_14 > 0 and var_99_8 < var_99_14 then
					arg_96_1.talkMaxDuration = var_99_14

					if var_99_14 + var_99_7 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_7
					end
				end

				arg_96_1.text_.text = var_99_11
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082021", "story_v_out_423082.awb") ~= 0 then
					local var_99_15 = manager.audio:GetVoiceLength("story_v_out_423082", "423082021", "story_v_out_423082.awb") / 1000

					if var_99_15 + var_99_7 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_15 + var_99_7
					end

					if var_99_10.prefab_name ~= "" and arg_96_1.actors_[var_99_10.prefab_name] ~= nil then
						local var_99_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_10.prefab_name].transform, "story_v_out_423082", "423082021", "story_v_out_423082.awb")

						arg_96_1:RecordAudio("423082021", var_99_16)
						arg_96_1:RecordAudio("423082021", var_99_16)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_423082", "423082021", "story_v_out_423082.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_423082", "423082021", "story_v_out_423082.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_17 = math.max(var_99_8, arg_96_1.talkMaxDuration)

			if var_99_7 <= arg_96_1.time_ and arg_96_1.time_ < var_99_7 + var_99_17 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_7) / var_99_17

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_7 + var_99_17 and arg_96_1.time_ < var_99_7 + var_99_17 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423082022 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 423082022
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play423082023(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1083"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps1083 == nil then
				arg_100_1.var_.actorSpriteComps1083 = var_103_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.actorSpriteComps1083 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								local var_103_4 = Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor2.r, var_103_3)
								local var_103_5 = Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor2.g, var_103_3)
								local var_103_6 = Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor2.b, var_103_3)

								iter_103_1.color = Color.New(var_103_4, var_103_5, var_103_6)
							else
								local var_103_7 = Mathf.Lerp(iter_103_1.color.r, 0.5, var_103_3)

								iter_103_1.color = Color.New(var_103_7, var_103_7, var_103_7)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps1083 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_103_3 then
						if arg_100_1.isInRecall_ then
							iter_103_3.color = arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_103_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps1083 = nil
			end

			local var_103_8 = 0
			local var_103_9 = 0.675

			if var_103_8 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_10 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_11 = arg_100_1:GetWordFromCfg(423082022)
				local var_103_12 = arg_100_1:FormatText(var_103_11.content)

				arg_100_1.text_.text = var_103_12

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 27
				local var_103_14 = utf8.len(var_103_12)
				local var_103_15 = var_103_13 <= 0 and var_103_9 or var_103_9 * (var_103_14 / var_103_13)

				if var_103_15 > 0 and var_103_9 < var_103_15 then
					arg_100_1.talkMaxDuration = var_103_15

					if var_103_15 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_15 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_12
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_16 and arg_100_1.time_ < var_103_8 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play423082023 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 423082023
		arg_104_1.duration_ = 8.5

		local var_104_0 = {
			zh = 6.5,
			ja = 8.5
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
				arg_104_0:Play423082024(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1083"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1083 = var_107_0.localPosition
				var_107_0.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1083", 7)

				local var_107_2 = var_107_0.childCount

				for iter_107_0 = 0, var_107_2 - 1 do
					local var_107_3 = var_107_0:GetChild(iter_107_0)

					if var_107_3.name == "split_6" or not string.find(var_107_3.name, "split") then
						var_107_3.gameObject:SetActive(true)
					else
						var_107_3.gameObject:SetActive(false)
					end
				end
			end

			local var_107_4 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_4 then
				local var_107_5 = (arg_104_1.time_ - var_107_1) / var_107_4
				local var_107_6 = Vector3.New(0, -2000, 0)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1083, var_107_6, var_107_5)
			end

			if arg_104_1.time_ >= var_107_1 + var_107_4 and arg_104_1.time_ < var_107_1 + var_107_4 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_107_7 = 0
			local var_107_8 = 0.55

			if var_107_7 < arg_104_1.time_ and arg_104_1.time_ <= var_107_7 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_9 = arg_104_1:FormatText(StoryNameCfg[1334].name)

				arg_104_1.leftNameTxt_.text = var_107_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_10 = arg_104_1:GetWordFromCfg(423082023)
				local var_107_11 = arg_104_1:FormatText(var_107_10.content)

				arg_104_1.text_.text = var_107_11

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_12 = 22
				local var_107_13 = utf8.len(var_107_11)
				local var_107_14 = var_107_12 <= 0 and var_107_8 or var_107_8 * (var_107_13 / var_107_12)

				if var_107_14 > 0 and var_107_8 < var_107_14 then
					arg_104_1.talkMaxDuration = var_107_14

					if var_107_14 + var_107_7 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_7
					end
				end

				arg_104_1.text_.text = var_107_11
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082023", "story_v_out_423082.awb") ~= 0 then
					local var_107_15 = manager.audio:GetVoiceLength("story_v_out_423082", "423082023", "story_v_out_423082.awb") / 1000

					if var_107_15 + var_107_7 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_15 + var_107_7
					end

					if var_107_10.prefab_name ~= "" and arg_104_1.actors_[var_107_10.prefab_name] ~= nil then
						local var_107_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_10.prefab_name].transform, "story_v_out_423082", "423082023", "story_v_out_423082.awb")

						arg_104_1:RecordAudio("423082023", var_107_16)
						arg_104_1:RecordAudio("423082023", var_107_16)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_423082", "423082023", "story_v_out_423082.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_423082", "423082023", "story_v_out_423082.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_17 = math.max(var_107_8, arg_104_1.talkMaxDuration)

			if var_107_7 <= arg_104_1.time_ and arg_104_1.time_ < var_107_7 + var_107_17 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_7) / var_107_17

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_7 + var_107_17 and arg_104_1.time_ < var_107_7 + var_107_17 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423082024 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 423082024
		arg_108_1.duration_ = 12.5

		local var_108_0 = {
			zh = 6.1,
			ja = 12.5
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
				arg_108_0:Play423082025(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.65

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[1334].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(423082024)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082024", "story_v_out_423082.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_423082", "423082024", "story_v_out_423082.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_423082", "423082024", "story_v_out_423082.awb")

						arg_108_1:RecordAudio("423082024", var_111_9)
						arg_108_1:RecordAudio("423082024", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_423082", "423082024", "story_v_out_423082.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_423082", "423082024", "story_v_out_423082.awb")
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
	Play423082025 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 423082025
		arg_112_1.duration_ = 19.23

		local var_112_0 = {
			zh = 9.666,
			ja = 19.233
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
				arg_112_0:Play423082026(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 1.2

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[1334].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(423082025)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 48
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082025", "story_v_out_423082.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_423082", "423082025", "story_v_out_423082.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_423082", "423082025", "story_v_out_423082.awb")

						arg_112_1:RecordAudio("423082025", var_115_9)
						arg_112_1:RecordAudio("423082025", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_423082", "423082025", "story_v_out_423082.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_423082", "423082025", "story_v_out_423082.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play423082026 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 423082026
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play423082027(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.775

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(423082026)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 31
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_8 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_8 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_8

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_8 and arg_116_1.time_ < var_119_0 + var_119_8 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play423082027 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 423082027
		arg_120_1.duration_ = 11.6

		local var_120_0 = {
			zh = 5.2,
			ja = 11.6
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
				arg_120_0:Play423082028(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.55

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[1334].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(423082027)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 22
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082027", "story_v_out_423082.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_423082", "423082027", "story_v_out_423082.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_423082", "423082027", "story_v_out_423082.awb")

						arg_120_1:RecordAudio("423082027", var_123_9)
						arg_120_1:RecordAudio("423082027", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_423082", "423082027", "story_v_out_423082.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_423082", "423082027", "story_v_out_423082.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play423082028 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 423082028
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play423082029(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 1.875

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_2 = arg_124_1:GetWordFromCfg(423082028)
				local var_127_3 = arg_124_1:FormatText(var_127_2.content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 75
				local var_127_5 = utf8.len(var_127_3)
				local var_127_6 = var_127_4 <= 0 and var_127_1 or var_127_1 * (var_127_5 / var_127_4)

				if var_127_6 > 0 and var_127_1 < var_127_6 then
					arg_124_1.talkMaxDuration = var_127_6

					if var_127_6 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_7 and arg_124_1.time_ < var_127_0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play423082029 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 423082029
		arg_128_1.duration_ = 6.43

		local var_128_0 = {
			zh = 4.8,
			ja = 6.433
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
				arg_128_0:Play423082030(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1083"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1083 == nil then
				arg_128_1.var_.actorSpriteComps1083 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps1083 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1083 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps1083 = nil
			end

			local var_131_8 = arg_128_1.actors_["1083"].transform
			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 then
				arg_128_1.var_.moveOldPos1083 = var_131_8.localPosition
				var_131_8.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1083", 3)

				local var_131_10 = var_131_8.childCount

				for iter_131_4 = 0, var_131_10 - 1 do
					local var_131_11 = var_131_8:GetChild(iter_131_4)

					if var_131_11.name == "" or not string.find(var_131_11.name, "split") then
						var_131_11.gameObject:SetActive(true)
					else
						var_131_11.gameObject:SetActive(false)
					end
				end
			end

			local var_131_12 = 0.001

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_12 then
				local var_131_13 = (arg_128_1.time_ - var_131_9) / var_131_12
				local var_131_14 = Vector3.New(-50, -345, -345)

				var_131_8.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1083, var_131_14, var_131_13)
			end

			if arg_128_1.time_ >= var_131_9 + var_131_12 and arg_128_1.time_ < var_131_9 + var_131_12 + arg_131_0 then
				var_131_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_131_15 = 0
			local var_131_16 = 0.525

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[1332].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(423082029)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 21
				local var_131_21 = utf8.len(var_131_19)
				local var_131_22 = var_131_20 <= 0 and var_131_16 or var_131_16 * (var_131_21 / var_131_20)

				if var_131_22 > 0 and var_131_16 < var_131_22 then
					arg_128_1.talkMaxDuration = var_131_22

					if var_131_22 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_19
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082029", "story_v_out_423082.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_out_423082", "423082029", "story_v_out_423082.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_out_423082", "423082029", "story_v_out_423082.awb")

						arg_128_1:RecordAudio("423082029", var_131_24)
						arg_128_1:RecordAudio("423082029", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_423082", "423082029", "story_v_out_423082.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_423082", "423082029", "story_v_out_423082.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_25 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_25 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_25

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_25 and arg_128_1.time_ < var_131_15 + var_131_25 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play423082030 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 423082030
		arg_132_1.duration_ = 10.93

		local var_132_0 = {
			zh = 7.766,
			ja = 10.933
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
				arg_132_0:Play423082031(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1083"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1083 == nil then
				arg_132_1.var_.actorSpriteComps1083 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps1083 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								local var_135_4 = Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor2.r, var_135_3)
								local var_135_5 = Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor2.g, var_135_3)
								local var_135_6 = Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor2.b, var_135_3)

								iter_135_1.color = Color.New(var_135_4, var_135_5, var_135_6)
							else
								local var_135_7 = Mathf.Lerp(iter_135_1.color.r, 0.5, var_135_3)

								iter_135_1.color = Color.New(var_135_7, var_135_7, var_135_7)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1083 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1083 = nil
			end

			local var_135_8 = 0
			local var_135_9 = 0.775

			if var_135_8 < arg_132_1.time_ and arg_132_1.time_ <= var_135_8 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_10 = arg_132_1:FormatText(StoryNameCfg[1334].name)

				arg_132_1.leftNameTxt_.text = var_135_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_11 = arg_132_1:GetWordFromCfg(423082030)
				local var_135_12 = arg_132_1:FormatText(var_135_11.content)

				arg_132_1.text_.text = var_135_12

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 31
				local var_135_14 = utf8.len(var_135_12)
				local var_135_15 = var_135_13 <= 0 and var_135_9 or var_135_9 * (var_135_14 / var_135_13)

				if var_135_15 > 0 and var_135_9 < var_135_15 then
					arg_132_1.talkMaxDuration = var_135_15

					if var_135_15 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_15 + var_135_8
					end
				end

				arg_132_1.text_.text = var_135_12
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082030", "story_v_out_423082.awb") ~= 0 then
					local var_135_16 = manager.audio:GetVoiceLength("story_v_out_423082", "423082030", "story_v_out_423082.awb") / 1000

					if var_135_16 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_16 + var_135_8
					end

					if var_135_11.prefab_name ~= "" and arg_132_1.actors_[var_135_11.prefab_name] ~= nil then
						local var_135_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_11.prefab_name].transform, "story_v_out_423082", "423082030", "story_v_out_423082.awb")

						arg_132_1:RecordAudio("423082030", var_135_17)
						arg_132_1:RecordAudio("423082030", var_135_17)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_423082", "423082030", "story_v_out_423082.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_423082", "423082030", "story_v_out_423082.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_18 = math.max(var_135_9, arg_132_1.talkMaxDuration)

			if var_135_8 <= arg_132_1.time_ and arg_132_1.time_ < var_135_8 + var_135_18 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_8) / var_135_18

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_8 + var_135_18 and arg_132_1.time_ < var_135_8 + var_135_18 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play423082031 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 423082031
		arg_136_1.duration_ = 5.77

		local var_136_0 = {
			zh = 4.833,
			ja = 5.766
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play423082032(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1083"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps1083 == nil then
				arg_136_1.var_.actorSpriteComps1083 = var_139_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.actorSpriteComps1083 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								local var_139_4 = Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor1.r, var_139_3)
								local var_139_5 = Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor1.g, var_139_3)
								local var_139_6 = Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor1.b, var_139_3)

								iter_139_1.color = Color.New(var_139_4, var_139_5, var_139_6)
							else
								local var_139_7 = Mathf.Lerp(iter_139_1.color.r, 1, var_139_3)

								iter_139_1.color = Color.New(var_139_7, var_139_7, var_139_7)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps1083 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_139_3 then
						if arg_136_1.isInRecall_ then
							iter_139_3.color = arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_139_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps1083 = nil
			end

			local var_139_8 = arg_136_1.actors_["1083"].transform
			local var_139_9 = 0

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 then
				arg_136_1.var_.moveOldPos1083 = var_139_8.localPosition
				var_139_8.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1083", 3)

				local var_139_10 = var_139_8.childCount

				for iter_139_4 = 0, var_139_10 - 1 do
					local var_139_11 = var_139_8:GetChild(iter_139_4)

					if var_139_11.name == "split_2" or not string.find(var_139_11.name, "split") then
						var_139_11.gameObject:SetActive(true)
					else
						var_139_11.gameObject:SetActive(false)
					end
				end
			end

			local var_139_12 = 0.001

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_12 then
				local var_139_13 = (arg_136_1.time_ - var_139_9) / var_139_12
				local var_139_14 = Vector3.New(-50, -345, -345)

				var_139_8.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1083, var_139_14, var_139_13)
			end

			if arg_136_1.time_ >= var_139_9 + var_139_12 and arg_136_1.time_ < var_139_9 + var_139_12 + arg_139_0 then
				var_139_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_139_15 = 0
			local var_139_16 = 0.475

			if var_139_15 < arg_136_1.time_ and arg_136_1.time_ <= var_139_15 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_17 = arg_136_1:FormatText(StoryNameCfg[1332].name)

				arg_136_1.leftNameTxt_.text = var_139_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_18 = arg_136_1:GetWordFromCfg(423082031)
				local var_139_19 = arg_136_1:FormatText(var_139_18.content)

				arg_136_1.text_.text = var_139_19

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_20 = 19
				local var_139_21 = utf8.len(var_139_19)
				local var_139_22 = var_139_20 <= 0 and var_139_16 or var_139_16 * (var_139_21 / var_139_20)

				if var_139_22 > 0 and var_139_16 < var_139_22 then
					arg_136_1.talkMaxDuration = var_139_22

					if var_139_22 + var_139_15 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_22 + var_139_15
					end
				end

				arg_136_1.text_.text = var_139_19
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082031", "story_v_out_423082.awb") ~= 0 then
					local var_139_23 = manager.audio:GetVoiceLength("story_v_out_423082", "423082031", "story_v_out_423082.awb") / 1000

					if var_139_23 + var_139_15 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_23 + var_139_15
					end

					if var_139_18.prefab_name ~= "" and arg_136_1.actors_[var_139_18.prefab_name] ~= nil then
						local var_139_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_18.prefab_name].transform, "story_v_out_423082", "423082031", "story_v_out_423082.awb")

						arg_136_1:RecordAudio("423082031", var_139_24)
						arg_136_1:RecordAudio("423082031", var_139_24)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_423082", "423082031", "story_v_out_423082.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_423082", "423082031", "story_v_out_423082.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_25 = math.max(var_139_16, arg_136_1.talkMaxDuration)

			if var_139_15 <= arg_136_1.time_ and arg_136_1.time_ < var_139_15 + var_139_25 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_15) / var_139_25

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_15 + var_139_25 and arg_136_1.time_ < var_139_15 + var_139_25 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play423082032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 423082032
		arg_140_1.duration_ = 6.93

		local var_140_0 = {
			zh = 4.8,
			ja = 6.933
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play423082033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1083"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1083 == nil then
				arg_140_1.var_.actorSpriteComps1083 = var_143_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.actorSpriteComps1083 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								local var_143_4 = Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor2.r, var_143_3)
								local var_143_5 = Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor2.g, var_143_3)
								local var_143_6 = Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor2.b, var_143_3)

								iter_143_1.color = Color.New(var_143_4, var_143_5, var_143_6)
							else
								local var_143_7 = Mathf.Lerp(iter_143_1.color.r, 0.5, var_143_3)

								iter_143_1.color = Color.New(var_143_7, var_143_7, var_143_7)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1083 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_143_3 then
						if arg_140_1.isInRecall_ then
							iter_143_3.color = arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_143_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps1083 = nil
			end

			local var_143_8 = 0.0666666666666667
			local var_143_9 = 1

			if var_143_8 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				local var_143_10 = "play"
				local var_143_11 = "effect"

				arg_140_1:AudioAction(var_143_10, var_143_11, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_143_12 = 0
			local var_143_13 = 0.55

			if var_143_12 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_14 = arg_140_1:FormatText(StoryNameCfg[1334].name)

				arg_140_1.leftNameTxt_.text = var_143_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_15 = arg_140_1:GetWordFromCfg(423082032)
				local var_143_16 = arg_140_1:FormatText(var_143_15.content)

				arg_140_1.text_.text = var_143_16

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_17 = 22
				local var_143_18 = utf8.len(var_143_16)
				local var_143_19 = var_143_17 <= 0 and var_143_13 or var_143_13 * (var_143_18 / var_143_17)

				if var_143_19 > 0 and var_143_13 < var_143_19 then
					arg_140_1.talkMaxDuration = var_143_19

					if var_143_19 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_19 + var_143_12
					end
				end

				arg_140_1.text_.text = var_143_16
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082032", "story_v_out_423082.awb") ~= 0 then
					local var_143_20 = manager.audio:GetVoiceLength("story_v_out_423082", "423082032", "story_v_out_423082.awb") / 1000

					if var_143_20 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_20 + var_143_12
					end

					if var_143_15.prefab_name ~= "" and arg_140_1.actors_[var_143_15.prefab_name] ~= nil then
						local var_143_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_15.prefab_name].transform, "story_v_out_423082", "423082032", "story_v_out_423082.awb")

						arg_140_1:RecordAudio("423082032", var_143_21)
						arg_140_1:RecordAudio("423082032", var_143_21)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_423082", "423082032", "story_v_out_423082.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_423082", "423082032", "story_v_out_423082.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_22 = math.max(var_143_13, arg_140_1.talkMaxDuration)

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_22 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_12) / var_143_22

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_12 + var_143_22 and arg_140_1.time_ < var_143_12 + var_143_22 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play423082033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 423082033
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play423082034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.775

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(423082033)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 31
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_8 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_8 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_8

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_8 and arg_144_1.time_ < var_147_0 + var_147_8 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play423082034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 423082034
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play423082035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.825

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[7].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:GetWordFromCfg(423082034)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 33
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_8 and arg_148_1.time_ < var_151_0 + var_151_8 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play423082035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 423082035
		arg_152_1.duration_ = 6.5

		local var_152_0 = {
			zh = 6.5,
			ja = 6.3
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play423082036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1083"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1083 == nil then
				arg_152_1.var_.actorSpriteComps1083 = var_155_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_2 = 0.2

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.actorSpriteComps1083 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								local var_155_4 = Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor1.r, var_155_3)
								local var_155_5 = Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor1.g, var_155_3)
								local var_155_6 = Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor1.b, var_155_3)

								iter_155_1.color = Color.New(var_155_4, var_155_5, var_155_6)
							else
								local var_155_7 = Mathf.Lerp(iter_155_1.color.r, 1, var_155_3)

								iter_155_1.color = Color.New(var_155_7, var_155_7, var_155_7)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1083 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_155_3 then
						if arg_152_1.isInRecall_ then
							iter_155_3.color = arg_152_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_155_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps1083 = nil
			end

			local var_155_8 = arg_152_1.actors_["1083"].transform
			local var_155_9 = 0

			if var_155_9 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 then
				arg_152_1.var_.moveOldPos1083 = var_155_8.localPosition
				var_155_8.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1083", 3)

				local var_155_10 = var_155_8.childCount

				for iter_155_4 = 0, var_155_10 - 1 do
					local var_155_11 = var_155_8:GetChild(iter_155_4)

					if var_155_11.name == "" or not string.find(var_155_11.name, "split") then
						var_155_11.gameObject:SetActive(true)
					else
						var_155_11.gameObject:SetActive(false)
					end
				end
			end

			local var_155_12 = 0.001

			if var_155_9 <= arg_152_1.time_ and arg_152_1.time_ < var_155_9 + var_155_12 then
				local var_155_13 = (arg_152_1.time_ - var_155_9) / var_155_12
				local var_155_14 = Vector3.New(-50, -345, -345)

				var_155_8.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1083, var_155_14, var_155_13)
			end

			if arg_152_1.time_ >= var_155_9 + var_155_12 and arg_152_1.time_ < var_155_9 + var_155_12 + arg_155_0 then
				var_155_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_155_15 = 0
			local var_155_16 = 0.75

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[1332].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(423082035)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 30
				local var_155_21 = utf8.len(var_155_19)
				local var_155_22 = var_155_20 <= 0 and var_155_16 or var_155_16 * (var_155_21 / var_155_20)

				if var_155_22 > 0 and var_155_16 < var_155_22 then
					arg_152_1.talkMaxDuration = var_155_22

					if var_155_22 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_22 + var_155_15
					end
				end

				arg_152_1.text_.text = var_155_19
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082035", "story_v_out_423082.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_out_423082", "423082035", "story_v_out_423082.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_out_423082", "423082035", "story_v_out_423082.awb")

						arg_152_1:RecordAudio("423082035", var_155_24)
						arg_152_1:RecordAudio("423082035", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_423082", "423082035", "story_v_out_423082.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_423082", "423082035", "story_v_out_423082.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_25 = math.max(var_155_16, arg_152_1.talkMaxDuration)

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_25 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_15) / var_155_25

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_15 + var_155_25 and arg_152_1.time_ < var_155_15 + var_155_25 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play423082036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 423082036
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play423082037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1083"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps1083 == nil then
				arg_156_1.var_.actorSpriteComps1083 = var_159_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.actorSpriteComps1083 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								local var_159_4 = Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor2.r, var_159_3)
								local var_159_5 = Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor2.g, var_159_3)
								local var_159_6 = Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor2.b, var_159_3)

								iter_159_1.color = Color.New(var_159_4, var_159_5, var_159_6)
							else
								local var_159_7 = Mathf.Lerp(iter_159_1.color.r, 0.5, var_159_3)

								iter_159_1.color = Color.New(var_159_7, var_159_7, var_159_7)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps1083 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_159_3 then
						if arg_156_1.isInRecall_ then
							iter_159_3.color = arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_159_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps1083 = nil
			end

			local var_159_8 = arg_156_1.actors_["1083"].transform
			local var_159_9 = 0

			if var_159_9 < arg_156_1.time_ and arg_156_1.time_ <= var_159_9 + arg_159_0 then
				arg_156_1.var_.moveOldPos1083 = var_159_8.localPosition
				var_159_8.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("1083", 7)

				local var_159_10 = var_159_8.childCount

				for iter_159_4 = 0, var_159_10 - 1 do
					local var_159_11 = var_159_8:GetChild(iter_159_4)

					if var_159_11.name == "" or not string.find(var_159_11.name, "split") then
						var_159_11.gameObject:SetActive(true)
					else
						var_159_11.gameObject:SetActive(false)
					end
				end
			end

			local var_159_12 = 0.001

			if var_159_9 <= arg_156_1.time_ and arg_156_1.time_ < var_159_9 + var_159_12 then
				local var_159_13 = (arg_156_1.time_ - var_159_9) / var_159_12
				local var_159_14 = Vector3.New(0, -2000, 0)

				var_159_8.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1083, var_159_14, var_159_13)
			end

			if arg_156_1.time_ >= var_159_9 + var_159_12 and arg_156_1.time_ < var_159_9 + var_159_12 + arg_159_0 then
				var_159_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_159_15 = 1
			local var_159_16 = 1

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				local var_159_17 = "play"
				local var_159_18 = "effect"

				arg_156_1:AudioAction(var_159_17, var_159_18, "se_story_122_01", "se_story_122_01_metaldoor", "")
			end

			local var_159_19 = 0
			local var_159_20 = 1.825

			if var_159_19 < arg_156_1.time_ and arg_156_1.time_ <= var_159_19 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_21 = arg_156_1:GetWordFromCfg(423082036)
				local var_159_22 = arg_156_1:FormatText(var_159_21.content)

				arg_156_1.text_.text = var_159_22

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_23 = 69
				local var_159_24 = utf8.len(var_159_22)
				local var_159_25 = var_159_23 <= 0 and var_159_20 or var_159_20 * (var_159_24 / var_159_23)

				if var_159_25 > 0 and var_159_20 < var_159_25 then
					arg_156_1.talkMaxDuration = var_159_25

					if var_159_25 + var_159_19 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_25 + var_159_19
					end
				end

				arg_156_1.text_.text = var_159_22
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_26 = math.max(var_159_20, arg_156_1.talkMaxDuration)

			if var_159_19 <= arg_156_1.time_ and arg_156_1.time_ < var_159_19 + var_159_26 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_19) / var_159_26

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_19 + var_159_26 and arg_156_1.time_ < var_159_19 + var_159_26 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play423082037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 423082037
		arg_160_1.duration_ = 8.77

		local var_160_0 = {
			zh = 7.533,
			ja = 8.766
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play423082038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = "10146"

			if arg_160_1.actors_[var_163_0] == nil then
				local var_163_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10146")

				if not isNil(var_163_1) then
					local var_163_2 = Object.Instantiate(var_163_1, arg_160_1.canvasGo_.transform)

					var_163_2.transform:SetSiblingIndex(1)

					var_163_2.name = var_163_0
					var_163_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_160_1.actors_[var_163_0] = var_163_2

					local var_163_3 = var_163_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_160_1.isInRecall_ then
						for iter_163_0, iter_163_1 in ipairs(var_163_3) do
							iter_163_1.color = arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_163_4 = arg_160_1.actors_["10146"]
			local var_163_5 = 0

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.actorSpriteComps10146 == nil then
				arg_160_1.var_.actorSpriteComps10146 = var_163_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_6 = 0.2

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 and not isNil(var_163_4) then
				local var_163_7 = (arg_160_1.time_ - var_163_5) / var_163_6

				if arg_160_1.var_.actorSpriteComps10146 then
					for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_163_3 then
							if arg_160_1.isInRecall_ then
								local var_163_8 = Mathf.Lerp(iter_163_3.color.r, arg_160_1.hightColor1.r, var_163_7)
								local var_163_9 = Mathf.Lerp(iter_163_3.color.g, arg_160_1.hightColor1.g, var_163_7)
								local var_163_10 = Mathf.Lerp(iter_163_3.color.b, arg_160_1.hightColor1.b, var_163_7)

								iter_163_3.color = Color.New(var_163_8, var_163_9, var_163_10)
							else
								local var_163_11 = Mathf.Lerp(iter_163_3.color.r, 1, var_163_7)

								iter_163_3.color = Color.New(var_163_11, var_163_11, var_163_11)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.actorSpriteComps10146 then
				for iter_163_4, iter_163_5 in pairs(arg_160_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_163_5 then
						if arg_160_1.isInRecall_ then
							iter_163_5.color = arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_163_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_160_1.var_.actorSpriteComps10146 = nil
			end

			local var_163_12 = arg_160_1.actors_["10146"].transform
			local var_163_13 = 0

			if var_163_13 < arg_160_1.time_ and arg_160_1.time_ <= var_163_13 + arg_163_0 then
				arg_160_1.var_.moveOldPos10146 = var_163_12.localPosition
				var_163_12.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("10146", 3)

				local var_163_14 = var_163_12.childCount

				for iter_163_6 = 0, var_163_14 - 1 do
					local var_163_15 = var_163_12:GetChild(iter_163_6)

					if var_163_15.name == "split_3" or not string.find(var_163_15.name, "split") then
						var_163_15.gameObject:SetActive(true)
					else
						var_163_15.gameObject:SetActive(false)
					end
				end
			end

			local var_163_16 = 0.001

			if var_163_13 <= arg_160_1.time_ and arg_160_1.time_ < var_163_13 + var_163_16 then
				local var_163_17 = (arg_160_1.time_ - var_163_13) / var_163_16
				local var_163_18 = Vector3.New(0, -350, -320)

				var_163_12.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10146, var_163_18, var_163_17)
			end

			if arg_160_1.time_ >= var_163_13 + var_163_16 and arg_160_1.time_ < var_163_13 + var_163_16 + arg_163_0 then
				var_163_12.localPosition = Vector3.New(0, -350, -320)
			end

			local var_163_19 = 0
			local var_163_20 = 0.4

			if var_163_19 < arg_160_1.time_ and arg_160_1.time_ <= var_163_19 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_21 = arg_160_1:FormatText(StoryNameCfg[1338].name)

				arg_160_1.leftNameTxt_.text = var_163_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_22 = arg_160_1:GetWordFromCfg(423082037)
				local var_163_23 = arg_160_1:FormatText(var_163_22.content)

				arg_160_1.text_.text = var_163_23

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_24 = 16
				local var_163_25 = utf8.len(var_163_23)
				local var_163_26 = var_163_24 <= 0 and var_163_20 or var_163_20 * (var_163_25 / var_163_24)

				if var_163_26 > 0 and var_163_20 < var_163_26 then
					arg_160_1.talkMaxDuration = var_163_26

					if var_163_26 + var_163_19 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_26 + var_163_19
					end
				end

				arg_160_1.text_.text = var_163_23
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082037", "story_v_out_423082.awb") ~= 0 then
					local var_163_27 = manager.audio:GetVoiceLength("story_v_out_423082", "423082037", "story_v_out_423082.awb") / 1000

					if var_163_27 + var_163_19 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_27 + var_163_19
					end

					if var_163_22.prefab_name ~= "" and arg_160_1.actors_[var_163_22.prefab_name] ~= nil then
						local var_163_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_22.prefab_name].transform, "story_v_out_423082", "423082037", "story_v_out_423082.awb")

						arg_160_1:RecordAudio("423082037", var_163_28)
						arg_160_1:RecordAudio("423082037", var_163_28)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_423082", "423082037", "story_v_out_423082.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_423082", "423082037", "story_v_out_423082.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_29 = math.max(var_163_20, arg_160_1.talkMaxDuration)

			if var_163_19 <= arg_160_1.time_ and arg_160_1.time_ < var_163_19 + var_163_29 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_19) / var_163_29

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_19 + var_163_29 and arg_160_1.time_ < var_163_19 + var_163_29 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play423082038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 423082038
		arg_164_1.duration_ = 13.3

		local var_164_0 = {
			zh = 8.666,
			ja = 13.3
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play423082039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 1.05

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[1338].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:GetWordFromCfg(423082038)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 42
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082038", "story_v_out_423082.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_423082", "423082038", "story_v_out_423082.awb") / 1000

					if var_167_8 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_0
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_423082", "423082038", "story_v_out_423082.awb")

						arg_164_1:RecordAudio("423082038", var_167_9)
						arg_164_1:RecordAudio("423082038", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_423082", "423082038", "story_v_out_423082.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_423082", "423082038", "story_v_out_423082.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_10 and arg_164_1.time_ < var_167_0 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play423082039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 423082039
		arg_168_1.duration_ = 12.17

		local var_168_0 = {
			zh = 9,
			ja = 12.166
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play423082040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 0.925

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_2 = arg_168_1:FormatText(StoryNameCfg[1338].name)

				arg_168_1.leftNameTxt_.text = var_171_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_3 = arg_168_1:GetWordFromCfg(423082039)
				local var_171_4 = arg_168_1:FormatText(var_171_3.content)

				arg_168_1.text_.text = var_171_4

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 37
				local var_171_6 = utf8.len(var_171_4)
				local var_171_7 = var_171_5 <= 0 and var_171_1 or var_171_1 * (var_171_6 / var_171_5)

				if var_171_7 > 0 and var_171_1 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_4
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082039", "story_v_out_423082.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_423082", "423082039", "story_v_out_423082.awb") / 1000

					if var_171_8 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_0
					end

					if var_171_3.prefab_name ~= "" and arg_168_1.actors_[var_171_3.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_3.prefab_name].transform, "story_v_out_423082", "423082039", "story_v_out_423082.awb")

						arg_168_1:RecordAudio("423082039", var_171_9)
						arg_168_1:RecordAudio("423082039", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_423082", "423082039", "story_v_out_423082.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_423082", "423082039", "story_v_out_423082.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_10 and arg_168_1.time_ < var_171_0 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play423082040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 423082040
		arg_172_1.duration_ = 5.67

		local var_172_0 = {
			zh = 5.666,
			ja = 5.133
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
			arg_172_1.auto_ = false
		end

		function arg_172_1.playNext_(arg_174_0)
			arg_172_1.onStoryFinished_()
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.525

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[1338].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:GetWordFromCfg(423082040)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 21
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082040", "story_v_out_423082.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_out_423082", "423082040", "story_v_out_423082.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_423082", "423082040", "story_v_out_423082.awb")

						arg_172_1:RecordAudio("423082040", var_175_9)
						arg_172_1:RecordAudio("423082040", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_423082", "423082040", "story_v_out_423082.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_423082", "423082040", "story_v_out_423082.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_10 and arg_172_1.time_ < var_175_0 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I25f"
	},
	voices = {
		"story_v_out_423082.awb"
	}
}
