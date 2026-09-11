return {
	Play413101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413101001
		arg_1_1.duration_ = 3.4

		local var_1_0 = {
			zh = 3.4,
			ja = 3.266
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
				arg_1_0:Play413101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F10g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10g")
				var_4_0.name = "F10g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F10g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F10g

				arg_1_1.bgs_.F10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F10g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "10093"

			if arg_1_1.actors_["10093"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_4_10) then
					local var_4_11 = Object.Instantiate(var_4_10, arg_1_1.canvasGo_.transform)

					var_4_11.transform:SetSiblingIndex(1)

					var_4_11.name = var_4_9
					var_4_11.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_9] = var_4_11

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_11:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_12 = arg_1_1.actors_["10093"].transform

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos10093 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10093", 3)

				for iter_4_4 = 0, var_4_12.childCount - 1 do
					local var_4_13 = var_4_12:GetChild(iter_4_4)

					if var_4_13.name == "split_3" or not string.find(var_4_13.name, "split") then
						var_4_13.gameObject:SetActive(true)
					else
						var_4_13.gameObject:SetActive(false)
					end
				end
			end

			local var_4_14 = 0.001

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_1_1.time_ - 1.86666666666667) / var_4_14)
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_14 and arg_1_1.time_ < 1.86666666666667 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -345, -245)
			end

			local var_4_15 = arg_1_1.actors_["10093"]

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10093 == nil then
				arg_1_1.var_.actorSpriteComps10093 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 0.833333333333333

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps10093 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.86666666666667) / var_4_16), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.86666666666667) / var_4_16), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.86666666666667) / var_4_16)))
							else
								local var_4_17 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 1.86666666666667) / var_4_16)

								iter_4_6.color = Color.New(var_4_17, var_4_17, var_4_17)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_16 and arg_1_1.time_ < 1.86666666666667 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10093 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10093 = nil
			end

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue10093 = var_4_18.alpha
					arg_1_1.var_.characterEffect10093 = var_4_18
				end

				arg_1_1.var_.alphaOldValue10093 = 0
			end

			local var_4_19 = 0.233333333333333

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_19 then
				if arg_1_1.var_.characterEffect10093 then
					arg_1_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10093, 1, (arg_1_1.time_ - 1.86666666666667) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_19 and arg_1_1.time_ < 1.86666666666667 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect10093 then
				arg_1_1.var_.characterEffect10093.alpha = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			if 1.26666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.26666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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

			local var_4_26 = 2.1
			local var_4_27 = 0.1

			if 2.1 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_28 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_28:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(413101001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 4 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 4)

				if (4 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 4)) > 0 and var_4_27 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_26 = var_4_26 + 0.3

					if var_4_32 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_26
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101001", "story_v_out_413101.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_413101", "413101001", "story_v_out_413101.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_413101", "413101001", "story_v_out_413101.awb")

						arg_1_1:RecordAudio("413101001", var_4_34)
						arg_1_1:RecordAudio("413101001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413101", "413101001", "story_v_out_413101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413101", "413101001", "story_v_out_413101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_35 = var_4_26 + 0.3
			local var_4_36 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_26 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_35) / var_4_36

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play413101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10093 = arg_9_1.actors_["10093"].transform.localPosition
				arg_9_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10093", 7)

				for iter_12_0 = 0, arg_9_1.actors_["10093"].transform.childCount - 1 do
					local var_12_0 = arg_9_1.actors_["10093"].transform:GetChild(iter_12_0)

					if var_12_0.name == "" or not string.find(var_12_0.name, "split") then
						var_12_0.gameObject:SetActive(true)
					else
						var_12_0.gameObject:SetActive(false)
					end
				end
			end

			local var_12_1 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_1 then
				arg_9_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_1)
			end

			if arg_9_1.time_ >= 0 + var_12_1 and arg_9_1.time_ < 0 + var_12_1 + arg_12_0 then
				arg_9_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_2 = arg_9_1.actors_["10093"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10093 == nil then
				arg_9_1.var_.actorSpriteComps10093 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps10093 then
					for iter_12_1, iter_12_2 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_12_2 then
							if arg_9_1.isInRecall_ then
								iter_12_2.color = Color.New(Mathf.Lerp(iter_12_2.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_3), Mathf.Lerp(iter_12_2.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_3), (Mathf.Lerp(iter_12_2.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_3)))
							else
								local var_12_4 = Mathf.Lerp(iter_12_2.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_3)

								iter_12_2.color = Color.New(var_12_4, var_12_4, var_12_4)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10093 then
				for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_12_4 then
						iter_12_4.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10093 = nil
			end

			local var_12_5 = 0
			local var_12_6 = 1.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_7 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(413101002).content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_9 = 47 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 47)

				if (47 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 47)) > 0 and var_12_6 < var_12_9 then
					arg_9_1.talkMaxDuration = var_12_9

					if var_12_9 + var_12_5 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_5
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_6, arg_9_1.talkMaxDuration)

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_5) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_5 + var_12_10 and arg_9_1.time_ < var_12_5 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413101003
		arg_13_1.duration_ = 4.67

		local var_13_0 = {
			zh = 4.666,
			ja = 2.2
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
				arg_13_0:Play413101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10093 = arg_13_1.actors_["10093"].transform.localPosition
				arg_13_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10093", 3)

				for iter_16_0 = 0, arg_13_1.actors_["10093"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["10093"].transform:GetChild(iter_16_0)

					if var_16_0.name == "split_5" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_16_2 = arg_13_1.actors_["10093"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10093 == nil then
				arg_13_1.var_.actorSpriteComps10093 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps10093 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								iter_16_2.color = Color.New(Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_2.color.r, 1, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_2.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10093 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_16_4 then
						iter_16_4.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10093 = nil
			end

			local var_16_5 = 0
			local var_16_6 = 0.525

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:GetWordFromCfg(413101003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 21 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 21)

				if (21 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 21)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101003", "story_v_out_413101.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101003", "story_v_out_413101.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_413101", "413101003", "story_v_out_413101.awb")

						arg_13_1:RecordAudio("413101003", var_16_12)
						arg_13_1:RecordAudio("413101003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413101", "413101003", "story_v_out_413101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413101", "413101003", "story_v_out_413101.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_13 and arg_13_1.time_ < var_16_5 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413101004
		arg_17_1.duration_ = 4.43

		local var_17_0 = {
			zh = 4.433,
			ja = 3.5
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
				arg_17_0:Play413101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.525

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(413101004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 21 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 21)

				if (21 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 21)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101004", "story_v_out_413101.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101004", "story_v_out_413101.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_413101", "413101004", "story_v_out_413101.awb")

						arg_17_1:RecordAudio("413101004", var_20_6)
						arg_17_1:RecordAudio("413101004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413101", "413101004", "story_v_out_413101.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413101", "413101004", "story_v_out_413101.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play413101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413101005
		arg_21_1.duration_ = 5.43

		local var_21_0 = {
			zh = 5.433,
			ja = 4.633
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
				arg_21_0:Play413101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10093 = arg_21_1.actors_["10093"].transform.localPosition
				arg_21_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10093", 3)

				for iter_24_0 = 0, arg_21_1.actors_["10093"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10093"].transform:GetChild(iter_24_0)

					if var_24_0.name == "split_7" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_24_2 = 0
			local var_24_3 = 0.65

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(413101005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 26 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 26)

				if (26 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 26)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101005", "story_v_out_413101.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101005", "story_v_out_413101.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_413101", "413101005", "story_v_out_413101.awb")

						arg_21_1:RecordAudio("413101005", var_24_9)
						arg_21_1:RecordAudio("413101005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413101", "413101005", "story_v_out_413101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413101", "413101005", "story_v_out_413101.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413101006
		arg_25_1.duration_ = 5.8

		local var_25_0 = {
			zh = 5.8,
			ja = 4.1
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
				arg_25_0:Play413101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10093 = arg_25_1.actors_["10093"].transform.localPosition
				arg_25_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10093", 3)

				for iter_28_0 = 0, arg_25_1.actors_["10093"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10093"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_28_2 = arg_25_1.actors_["10093"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10093 == nil then
				arg_25_1.var_.actorSpriteComps10093 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10093 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								iter_28_2.color = Color.New(Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_2.color.r, 1, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_2.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10093 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10093 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 0.7

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(413101006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 28 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 28)

				if (28 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 28)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101006", "story_v_out_413101.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101006", "story_v_out_413101.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_413101", "413101006", "story_v_out_413101.awb")

						arg_25_1:RecordAudio("413101006", var_28_12)
						arg_25_1:RecordAudio("413101006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413101", "413101006", "story_v_out_413101.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413101", "413101006", "story_v_out_413101.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_13 and arg_25_1.time_ < var_28_5 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413101007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play413101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10093 = arg_29_1.actors_["10093"].transform.localPosition
				arg_29_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10093", 7)

				for iter_32_0 = 0, arg_29_1.actors_["10093"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10093"].transform:GetChild(iter_32_0)

					if var_32_0.name == "" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_2 = arg_29_1.actors_["10093"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10093 == nil then
				arg_29_1.var_.actorSpriteComps10093 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10093 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								iter_32_2.color = Color.New(Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_2.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_2.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10093 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10093 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.675

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(413101007).content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 27 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_7) / 27)

				if (27 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_7) / 27)) > 0 and var_32_6 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_6, arg_29_1.talkMaxDuration)

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_5) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_5 + var_32_10 and arg_29_1.time_ < var_32_5 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play413101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413101008
		arg_33_1.duration_ = 5.63

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play413101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_0 = 0.633333333333333

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				local var_36_1 = Color.New(1, 1, 1)

				var_36_1.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.mask_.color = var_36_1
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				local var_36_2 = Color.New(1, 1, 1)

				arg_33_1.mask_.enabled = false
				var_36_2.a = 0
				arg_33_1.mask_.color = var_36_2
			end

			local var_36_3 = manager.ui.mainCamera.transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_3.localPosition
			end

			local var_36_4 = 0.6

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				local var_36_5, var_36_6 = math.modf((arg_33_1.time_ - 0) / 0.066)

				var_36_3.localPosition = Vector3.New(var_36_6 * 0.13, var_36_6 * 0.13, var_36_6 * 0.13) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_7 = 0.633333333333333
			local var_36_8 = 1.375

			if 0.633333333333333 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_9 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_9:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(413101008).content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_12 = 55 <= 0 and var_36_8 or var_36_8 * (utf8.len(var_36_10) / 55)

				if (55 <= 0 and var_36_8 or var_36_8 * (utf8.len(var_36_10) / 55)) > 0 and var_36_8 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12
					var_36_7 = var_36_7 + 0.3

					if var_36_12 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_7
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = var_36_7 + 0.3
			local var_36_14 = math.max(var_36_8, arg_33_1.talkMaxDuration)

			if var_36_7 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_13 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_13) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_13 + var_36_14 and arg_33_1.time_ < var_36_13 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play413101009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413101009
		arg_39_1.duration_ = 4.53

		local var_39_0 = {
			zh = 3.233,
			ja = 4.533
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
				arg_39_0:Play413101010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10093 = arg_39_1.actors_["10093"].transform.localPosition
				arg_39_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10093", 3)

				for iter_42_0 = 0, arg_39_1.actors_["10093"].transform.childCount - 1 do
					local var_42_0 = arg_39_1.actors_["10093"].transform:GetChild(iter_42_0)

					if var_42_0.name == "split_3" or not string.find(var_42_0.name, "split") then
						var_42_0.gameObject:SetActive(true)
					else
						var_42_0.gameObject:SetActive(false)
					end
				end
			end

			local var_42_1 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 then
				arg_39_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_39_1.time_ - 0) / var_42_1)
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 then
				arg_39_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_42_2 = arg_39_1.actors_["10093"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps10093 == nil then
				arg_39_1.var_.actorSpriteComps10093 = var_42_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_3 = 2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 and not isNil(var_42_2) then
				if arg_39_1.var_.actorSpriteComps10093 then
					for iter_42_1, iter_42_2 in pairs(arg_39_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_42_2 then
							if arg_39_1.isInRecall_ then
								iter_42_2.color = Color.New(Mathf.Lerp(iter_42_2.color.r, arg_39_1.hightColor1.r, (arg_39_1.time_ - 0) / var_42_3), Mathf.Lerp(iter_42_2.color.g, arg_39_1.hightColor1.g, (arg_39_1.time_ - 0) / var_42_3), (Mathf.Lerp(iter_42_2.color.b, arg_39_1.hightColor1.b, (arg_39_1.time_ - 0) / var_42_3)))
							else
								local var_42_4 = Mathf.Lerp(iter_42_2.color.r, 1, (arg_39_1.time_ - 0) / var_42_3)

								iter_42_2.color = Color.New(var_42_4, var_42_4, var_42_4)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps10093 then
				for iter_42_3, iter_42_4 in pairs(arg_39_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_42_4 then
						iter_42_4.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_39_1.var_.actorSpriteComps10093 = nil
			end

			local var_42_5 = 0
			local var_42_6 = 0.4

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_7 = arg_39_1:GetWordFromCfg(413101009)
				local var_42_8 = arg_39_1:FormatText(var_42_7.content)

				arg_39_1.text_.text = var_42_8

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_10 = 16 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_8) / 16)

				if (16 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_8) / 16)) > 0 and var_42_6 < var_42_10 then
					arg_39_1.talkMaxDuration = var_42_10

					if var_42_10 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_5
					end
				end

				arg_39_1.text_.text = var_42_8
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101009", "story_v_out_413101.awb") ~= 0 then
					local var_42_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101009", "story_v_out_413101.awb") / 1000

					if var_42_11 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_11 + var_42_5
					end

					if var_42_7.prefab_name ~= "" and arg_39_1.actors_[var_42_7.prefab_name] ~= nil then
						local var_42_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_7.prefab_name].transform, "story_v_out_413101", "413101009", "story_v_out_413101.awb")

						arg_39_1:RecordAudio("413101009", var_42_12)
						arg_39_1:RecordAudio("413101009", var_42_12)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_413101", "413101009", "story_v_out_413101.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_413101", "413101009", "story_v_out_413101.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_13 = math.max(var_42_6, arg_39_1.talkMaxDuration)

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_13 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_5) / var_42_13

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_5 + var_42_13 and arg_39_1.time_ < var_42_5 + var_42_13 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413101010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play413101011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10093 = arg_43_1.actors_["10093"].transform.localPosition
				arg_43_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10093", 7)

				for iter_46_0 = 0, arg_43_1.actors_["10093"].transform.childCount - 1 do
					local var_46_0 = arg_43_1.actors_["10093"].transform:GetChild(iter_46_0)

					if var_46_0.name == "" or not string.find(var_46_0.name, "split") then
						var_46_0.gameObject:SetActive(true)
					else
						var_46_0.gameObject:SetActive(false)
					end
				end
			end

			local var_46_1 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_1 then
				arg_43_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_43_1.time_ - 0) / var_46_1)
			end

			if arg_43_1.time_ >= 0 + var_46_1 and arg_43_1.time_ < 0 + var_46_1 + arg_46_0 then
				arg_43_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_46_2 = arg_43_1.actors_["10093"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.actorSpriteComps10093 == nil then
				arg_43_1.var_.actorSpriteComps10093 = var_46_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_3 = 0.034

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_3 and not isNil(var_46_2) then
				if arg_43_1.var_.actorSpriteComps10093 then
					for iter_46_1, iter_46_2 in pairs(arg_43_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_46_2 then
							if arg_43_1.isInRecall_ then
								iter_46_2.color = Color.New(Mathf.Lerp(iter_46_2.color.r, arg_43_1.hightColor2.r, (arg_43_1.time_ - 0) / var_46_3), Mathf.Lerp(iter_46_2.color.g, arg_43_1.hightColor2.g, (arg_43_1.time_ - 0) / var_46_3), (Mathf.Lerp(iter_46_2.color.b, arg_43_1.hightColor2.b, (arg_43_1.time_ - 0) / var_46_3)))
							else
								local var_46_4 = Mathf.Lerp(iter_46_2.color.r, 0.5, (arg_43_1.time_ - 0) / var_46_3)

								iter_46_2.color = Color.New(var_46_4, var_46_4, var_46_4)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_3 and arg_43_1.time_ < 0 + var_46_3 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.actorSpriteComps10093 then
				for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_46_4 then
						iter_46_4.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_43_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_hit", "")
			end

			local var_46_6 = manager.ui.mainCamera.transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.shakeOldPos = var_46_6.localPosition
			end

			local var_46_7 = 0.6

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				local var_46_8, var_46_9 = math.modf((arg_43_1.time_ - 0) / 0.066)

				var_46_6.localPosition = Vector3.New(var_46_9 * 0.13, var_46_9 * 0.13, var_46_9 * 0.13) + arg_43_1.var_.shakeOldPos
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				var_46_6.localPosition = arg_43_1.var_.shakeOldPos
			end

			local var_46_10 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			if arg_43_1.time_ >= var_46_10 + 0.6 and arg_43_1.time_ < var_46_10 + 0.6 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_11 = 0
			local var_46_12 = 1.1

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_13 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(413101010).content)

				arg_43_1.text_.text = var_46_13

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_15 = 44 <= 0 and var_46_12 or var_46_12 * (utf8.len(var_46_13) / 44)

				if (44 <= 0 and var_46_12 or var_46_12 * (utf8.len(var_46_13) / 44)) > 0 and var_46_12 < var_46_15 then
					arg_43_1.talkMaxDuration = var_46_15

					if var_46_15 + var_46_11 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_15 + var_46_11
					end
				end

				arg_43_1.text_.text = var_46_13
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_16 = math.max(var_46_12, arg_43_1.talkMaxDuration)

			if var_46_11 <= arg_43_1.time_ and arg_43_1.time_ < var_46_11 + var_46_16 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_11) / var_46_16

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_11 + var_46_16 and arg_43_1.time_ < var_46_11 + var_46_16 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413101011
		arg_47_1.duration_ = 3.07

		local var_47_0 = {
			zh = 3.066,
			ja = 2.533
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
				arg_47_0:Play413101012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10093 = arg_47_1.actors_["10093"].transform.localPosition
				arg_47_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10093", 3)

				for iter_50_0 = 0, arg_47_1.actors_["10093"].transform.childCount - 1 do
					local var_50_0 = arg_47_1.actors_["10093"].transform:GetChild(iter_50_0)

					if var_50_0.name == "split_7" or not string.find(var_50_0.name, "split") then
						var_50_0.gameObject:SetActive(true)
					else
						var_50_0.gameObject:SetActive(false)
					end
				end
			end

			local var_50_1 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				arg_47_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_50_2 = arg_47_1.actors_["10093"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps10093 == nil then
				arg_47_1.var_.actorSpriteComps10093 = var_50_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_3 = 2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.actorSpriteComps10093 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								iter_50_2.color = Color.New(Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_3), Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_3), (Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_3)))
							else
								local var_50_4 = Mathf.Lerp(iter_50_2.color.r, 1, (arg_47_1.time_ - 0) / var_50_3)

								iter_50_2.color = Color.New(var_50_4, var_50_4, var_50_4)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps10093 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_50_4 then
						iter_50_4.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps10093 = nil
			end

			local var_50_5 = 0
			local var_50_6 = 0.4

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_7 = arg_47_1:GetWordFromCfg(413101011)
				local var_50_8 = arg_47_1:FormatText(var_50_7.content)

				arg_47_1.text_.text = var_50_8

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_10 = 17 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_8) / 17)

				if (17 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_8) / 17)) > 0 and var_50_6 < var_50_10 then
					arg_47_1.talkMaxDuration = var_50_10

					if var_50_10 + var_50_5 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_5
					end
				end

				arg_47_1.text_.text = var_50_8
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101011", "story_v_out_413101.awb") ~= 0 then
					local var_50_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101011", "story_v_out_413101.awb") / 1000

					if var_50_11 + var_50_5 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_11 + var_50_5
					end

					if var_50_7.prefab_name ~= "" and arg_47_1.actors_[var_50_7.prefab_name] ~= nil then
						local var_50_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_7.prefab_name].transform, "story_v_out_413101", "413101011", "story_v_out_413101.awb")

						arg_47_1:RecordAudio("413101011", var_50_12)
						arg_47_1:RecordAudio("413101011", var_50_12)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_413101", "413101011", "story_v_out_413101.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_413101", "413101011", "story_v_out_413101.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_13 = math.max(var_50_6, arg_47_1.talkMaxDuration)

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_13 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_5) / var_50_13

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_5 + var_50_13 and arg_47_1.time_ < var_50_5 + var_50_13 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413101012
		arg_51_1.duration_ = 6.37

		local var_51_0 = {
			zh = 3.933,
			ja = 6.366
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
				arg_51_0:Play413101013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.5

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(413101012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 20 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 20)

				if (20 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 20)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101012", "story_v_out_413101.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101012", "story_v_out_413101.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_413101", "413101012", "story_v_out_413101.awb")

						arg_51_1:RecordAudio("413101012", var_54_6)
						arg_51_1:RecordAudio("413101012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_413101", "413101012", "story_v_out_413101.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_413101", "413101012", "story_v_out_413101.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play413101013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413101013
		arg_55_1.duration_ = 5.8

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play413101014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["10093"]) and arg_55_1.var_.actorSpriteComps10093 == nil then
				arg_55_1.var_.actorSpriteComps10093 = arg_55_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_0 = 2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["10093"]) then
				if arg_55_1.var_.actorSpriteComps10093 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								iter_58_1.color = Color.New(Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 0) / var_58_0), Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 0) / var_58_0), (Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 0) / var_58_0)))
							else
								local var_58_1 = Mathf.Lerp(iter_58_1.color.r, 0.5, (arg_55_1.time_ - 0) / var_58_0)

								iter_58_1.color = Color.New(var_58_1, var_58_1, var_58_1)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["10093"]) and arg_55_1.var_.actorSpriteComps10093 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_58_3 then
						iter_58_3.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps10093 = nil
			end

			local var_58_2 = manager.ui.mainCamera.transform

			if 0.366666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 0.366666666666667 + arg_58_0 then
				arg_55_1.var_.shakeOldPos = var_58_2.localPosition
			end

			local var_58_3 = 0.433333333333333

			if 0.366666666666667 <= arg_55_1.time_ and arg_55_1.time_ < 0.366666666666667 + var_58_3 then
				local var_58_4, var_58_5 = math.modf((arg_55_1.time_ - 0.366666666666667) / 0.066)

				var_58_2.localPosition = Vector3.New(var_58_5 * 0.13, var_58_5 * 0.13, var_58_5 * 0.13) + arg_55_1.var_.shakeOldPos
			end

			if arg_55_1.time_ >= 0.366666666666667 + var_58_3 and arg_55_1.time_ < 0.366666666666667 + var_58_3 + arg_58_0 then
				var_58_2.localPosition = arg_55_1.var_.shakeOldPos
			end

			local var_58_6 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_7 = 0.633333333333333

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_7 then
				local var_58_8 = Color.New(0, 0, 0)

				var_58_8.a = Mathf.Lerp(0, 1, (arg_55_1.time_ - var_58_6) / var_58_7)
				arg_55_1.mask_.color = var_58_8
			end

			if arg_55_1.time_ >= var_58_6 + var_58_7 and arg_55_1.time_ < var_58_6 + var_58_7 + arg_58_0 then
				local var_58_9 = Color.New(0, 0, 0)

				var_58_9.a = 1
				arg_55_1.mask_.color = var_58_9
			end

			local var_58_10 = 0.633333333333333

			if 0.633333333333333 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_11 = 0.633333333333333

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 then
				local var_58_12 = Color.New(0, 0, 0)

				var_58_12.a = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_10) / var_58_11)
				arg_55_1.mask_.color = var_58_12
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 then
				local var_58_13 = Color.New(0, 0, 0)

				arg_55_1.mask_.enabled = false
				var_58_13.a = 0
				arg_55_1.mask_.color = var_58_13
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				local var_58_14 = arg_55_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_58_14 then
					arg_55_1.var_.alphaOldValue10093 = var_58_14.alpha
					arg_55_1.var_.characterEffect10093 = var_58_14
				end

				arg_55_1.var_.alphaOldValue10093 = 1
			end

			local var_58_15 = 0.5

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_15 then
				if arg_55_1.var_.characterEffect10093 then
					arg_55_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_55_1.var_.alphaOldValue10093, 0, (arg_55_1.time_ - 0) / var_58_15)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_15 and arg_55_1.time_ < 0 + var_58_15 + arg_58_0 and arg_55_1.var_.characterEffect10093 then
				arg_55_1.var_.characterEffect10093.alpha = 0
			end

			if 0.8 < arg_55_1.time_ and arg_55_1.time_ <= 0.8 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou01", "")
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_17 = 0.8
			local var_58_18 = 1.3

			if 0.8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_17 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_19 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_19:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_20 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(413101013).content)

				arg_55_1.text_.text = var_58_20

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_22 = 52 <= 0 and var_58_18 or var_58_18 * (utf8.len(var_58_20) / 52)

				if (52 <= 0 and var_58_18 or var_58_18 * (utf8.len(var_58_20) / 52)) > 0 and var_58_18 < var_58_22 then
					arg_55_1.talkMaxDuration = var_58_22
					var_58_17 = var_58_17 + 0.3

					if var_58_22 + var_58_17 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_17
					end
				end

				arg_55_1.text_.text = var_58_20
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_23 = var_58_17 + 0.3
			local var_58_24 = math.max(var_58_18, arg_55_1.talkMaxDuration)

			if var_58_17 + 0.3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_23 + var_58_24 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_23) / var_58_24

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_23 + var_58_24 and arg_55_1.time_ < var_58_23 + var_58_24 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play413101014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413101014
		arg_61_1.duration_ = 1.17

		local var_61_0 = {
			zh = 0.999999999999,
			ja = 1.166
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
				arg_61_0:Play413101015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_5")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(413101014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 6 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 6)

				if (6 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 6)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101014", "story_v_out_413101.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101014", "story_v_out_413101.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_413101", "413101014", "story_v_out_413101.awb")

						arg_61_1:RecordAudio("413101014", var_64_6)
						arg_61_1:RecordAudio("413101014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413101", "413101014", "story_v_out_413101.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413101", "413101014", "story_v_out_413101.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play413101015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413101015
		arg_65_1.duration_ = 3.63

		local var_65_0 = {
			zh = 2.6,
			ja = 3.633
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
				arg_65_0:Play413101016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.325

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(413101015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 13)

				if (13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 13)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101015", "story_v_out_413101.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101015", "story_v_out_413101.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_413101", "413101015", "story_v_out_413101.awb")

						arg_65_1:RecordAudio("413101015", var_68_6)
						arg_65_1:RecordAudio("413101015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413101", "413101015", "story_v_out_413101.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413101", "413101015", "story_v_out_413101.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play413101016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413101016
		arg_69_1.duration_ = 5.9

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play413101017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_0 = arg_69_1.var_.effectjianguang1

				if not arg_69_1.var_.effectjianguang1 then
					var_72_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), manager.ui.mainCamera.transform)
					var_72_0.name = "jianguang1"
					arg_69_1.var_.effectjianguang1 = var_72_0
				else
					var_72_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_72_0.transform.localPosition = Vector3.New(0, 0, 0.4)
				var_72_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword02", "")
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_3 = 0.9
			local var_72_4 = 1.075

			if 0.9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_5 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_5:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(413101016).content)

				arg_69_1.text_.text = var_72_6

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_8 = 43 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_6) / 43)

				if (43 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_6) / 43)) > 0 and var_72_4 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8
					var_72_3 = var_72_3 + 0.3

					if var_72_8 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_3
					end
				end

				arg_69_1.text_.text = var_72_6
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = var_72_3 + 0.3
			local var_72_10 = math.max(var_72_4, arg_69_1.talkMaxDuration)

			if var_72_3 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_9) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play413101017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 413101017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play413101018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				if arg_75_1.var_.effectjianguang1 then
					Object.Destroy(arg_75_1.var_.effectjianguang1)

					arg_75_1.var_.effectjianguang1 = nil
				end
			end

			local var_78_1 = manager.ui.mainCamera.transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.shakeOldPos = var_78_1.localPosition
			end

			local var_78_2 = 0.6

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 then
				local var_78_3, var_78_4 = math.modf((arg_75_1.time_ - 0) / 0.066)

				var_78_1.localPosition = Vector3.New(var_78_4 * 0.13, var_78_4 * 0.13, var_78_4 * 0.13) + arg_75_1.var_.shakeOldPos
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 then
				var_78_1.localPosition = arg_75_1.var_.shakeOldPos
			end

			local var_78_5 = 0

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			if arg_75_1.time_ >= var_78_5 + 0.6 and arg_75_1.time_ < var_78_5 + 0.6 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			local var_78_6 = 0
			local var_78_7 = 1.425

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_8 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(413101017).content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 57 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_8) / 57)

				if (57 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_8) / 57)) > 0 and var_78_7 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_11 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_11 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_11

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_11 and arg_75_1.time_ < var_78_6 + var_78_11 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play413101018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 413101018
		arg_79_1.duration_ = 2.27

		local var_79_0 = {
			zh = 1.999999999999,
			ja = 2.266
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
				arg_79_0:Play413101019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10093 = arg_79_1.actors_["10093"].transform.localPosition
				arg_79_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10093", 3)

				for iter_82_0 = 0, arg_79_1.actors_["10093"].transform.childCount - 1 do
					local var_82_0 = arg_79_1.actors_["10093"].transform:GetChild(iter_82_0)

					if var_82_0.name == "split_5" or not string.find(var_82_0.name, "split") then
						var_82_0.gameObject:SetActive(true)
					else
						var_82_0.gameObject:SetActive(false)
					end
				end
			end

			local var_82_1 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				arg_79_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_79_1.time_ - 0) / var_82_1)
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				arg_79_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_82_2 = arg_79_1.actors_["10093"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10093 == nil then
				arg_79_1.var_.actorSpriteComps10093 = var_82_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_3 = 2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.actorSpriteComps10093 then
					for iter_82_1, iter_82_2 in pairs(arg_79_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_82_2 then
							if arg_79_1.isInRecall_ then
								iter_82_2.color = Color.New(Mathf.Lerp(iter_82_2.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 0) / var_82_3), Mathf.Lerp(iter_82_2.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 0) / var_82_3), (Mathf.Lerp(iter_82_2.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 0) / var_82_3)))
							else
								local var_82_4 = Mathf.Lerp(iter_82_2.color.r, 1, (arg_79_1.time_ - 0) / var_82_3)

								iter_82_2.color = Color.New(var_82_4, var_82_4, var_82_4)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10093 then
				for iter_82_3, iter_82_4 in pairs(arg_79_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_82_4 then
						iter_82_4.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				local var_82_5 = arg_79_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_82_5 then
					arg_79_1.var_.alphaOldValue10093 = var_82_5.alpha
					arg_79_1.var_.characterEffect10093 = var_82_5
				end

				arg_79_1.var_.alphaOldValue10093 = 0
			end

			local var_82_6 = 0.0333333333333333

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_6 then
				if arg_79_1.var_.characterEffect10093 then
					arg_79_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_79_1.var_.alphaOldValue10093, 1, (arg_79_1.time_ - 0) / var_82_6)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_6 and arg_79_1.time_ < 0 + var_82_6 + arg_82_0 and arg_79_1.var_.characterEffect10093 then
				arg_79_1.var_.characterEffect10093.alpha = 1
			end

			local var_82_7 = 0
			local var_82_8 = 0.075

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_9 = arg_79_1:GetWordFromCfg(413101018)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_12 = 3 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_10) / 3)

				if (3 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_10) / 3)) > 0 and var_82_8 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_7
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101018", "story_v_out_413101.awb") ~= 0 then
					local var_82_13 = manager.audio:GetVoiceLength("story_v_out_413101", "413101018", "story_v_out_413101.awb") / 1000

					if var_82_13 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_7
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_out_413101", "413101018", "story_v_out_413101.awb")

						arg_79_1:RecordAudio("413101018", var_82_14)
						arg_79_1:RecordAudio("413101018", var_82_14)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_413101", "413101018", "story_v_out_413101.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_413101", "413101018", "story_v_out_413101.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_15 = math.max(var_82_8, arg_79_1.talkMaxDuration)

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_15 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_7) / var_82_15

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_7 + var_82_15 and arg_79_1.time_ < var_82_7 + var_82_15 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play413101019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 413101019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play413101020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10093 = arg_83_1.actors_["10093"].transform.localPosition
				arg_83_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10093", 7)

				for iter_86_0 = 0, arg_83_1.actors_["10093"].transform.childCount - 1 do
					local var_86_0 = arg_83_1.actors_["10093"].transform:GetChild(iter_86_0)

					if var_86_0.name == "" or not string.find(var_86_0.name, "split") then
						var_86_0.gameObject:SetActive(true)
					else
						var_86_0.gameObject:SetActive(false)
					end
				end
			end

			local var_86_1 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 then
				arg_83_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_83_1.time_ - 0) / var_86_1)
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 then
				arg_83_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_86_2 = arg_83_1.actors_["10093"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10093 == nil then
				arg_83_1.var_.actorSpriteComps10093 = var_86_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_3 = 2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.actorSpriteComps10093 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_86_2 then
							if arg_83_1.isInRecall_ then
								iter_86_2.color = Color.New(Mathf.Lerp(iter_86_2.color.r, arg_83_1.hightColor2.r, (arg_83_1.time_ - 0) / var_86_3), Mathf.Lerp(iter_86_2.color.g, arg_83_1.hightColor2.g, (arg_83_1.time_ - 0) / var_86_3), (Mathf.Lerp(iter_86_2.color.b, arg_83_1.hightColor2.b, (arg_83_1.time_ - 0) / var_86_3)))
							else
								local var_86_4 = Mathf.Lerp(iter_86_2.color.r, 0.5, (arg_83_1.time_ - 0) / var_86_3)

								iter_86_2.color = Color.New(var_86_4, var_86_4, var_86_4)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10093 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_86_4 then
						iter_86_4.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_83_1.var_.actorSpriteComps10093 = nil
			end

			local var_86_5 = 0
			local var_86_6 = 1.05

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(413101019).content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 41 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_7) / 41)

				if (41 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_7) / 41)) > 0 and var_86_6 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_6, arg_83_1.talkMaxDuration)

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_5) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_5 + var_86_10 and arg_83_1.time_ < var_86_5 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play413101020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 413101020
		arg_87_1.duration_ = 2

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play413101021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10093 = arg_87_1.actors_["10093"].transform.localPosition
				arg_87_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10093", 3)

				for iter_90_0 = 0, arg_87_1.actors_["10093"].transform.childCount - 1 do
					local var_90_0 = arg_87_1.actors_["10093"].transform:GetChild(iter_90_0)

					if var_90_0.name == "split_4" or not string.find(var_90_0.name, "split") then
						var_90_0.gameObject:SetActive(true)
					else
						var_90_0.gameObject:SetActive(false)
					end
				end
			end

			local var_90_1 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 then
				arg_87_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_87_1.time_ - 0) / var_90_1)
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 then
				arg_87_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_90_2 = arg_87_1.actors_["10093"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps10093 == nil then
				arg_87_1.var_.actorSpriteComps10093 = var_90_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_3 = 2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.actorSpriteComps10093 then
					for iter_90_1, iter_90_2 in pairs(arg_87_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_90_2 then
							if arg_87_1.isInRecall_ then
								iter_90_2.color = Color.New(Mathf.Lerp(iter_90_2.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_3), Mathf.Lerp(iter_90_2.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_3), (Mathf.Lerp(iter_90_2.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_3)))
							else
								local var_90_4 = Mathf.Lerp(iter_90_2.color.r, 1, (arg_87_1.time_ - 0) / var_90_3)

								iter_90_2.color = Color.New(var_90_4, var_90_4, var_90_4)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps10093 then
				for iter_90_3, iter_90_4 in pairs(arg_87_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_90_4 then
						iter_90_4.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps10093 = nil
			end

			local var_90_5 = 0
			local var_90_6 = 0.15

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_7 = arg_87_1:GetWordFromCfg(413101020)
				local var_90_8 = arg_87_1:FormatText(var_90_7.content)

				arg_87_1.text_.text = var_90_8

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 6 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 6)

				if (6 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 6)) > 0 and var_90_6 < var_90_10 then
					arg_87_1.talkMaxDuration = var_90_10

					if var_90_10 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_5
					end
				end

				arg_87_1.text_.text = var_90_8
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101020", "story_v_out_413101.awb") ~= 0 then
					local var_90_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101020", "story_v_out_413101.awb") / 1000

					if var_90_11 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_11 + var_90_5
					end

					if var_90_7.prefab_name ~= "" and arg_87_1.actors_[var_90_7.prefab_name] ~= nil then
						local var_90_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_7.prefab_name].transform, "story_v_out_413101", "413101020", "story_v_out_413101.awb")

						arg_87_1:RecordAudio("413101020", var_90_12)
						arg_87_1:RecordAudio("413101020", var_90_12)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_413101", "413101020", "story_v_out_413101.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_413101", "413101020", "story_v_out_413101.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_6, arg_87_1.talkMaxDuration)

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_5) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_5 + var_90_13 and arg_87_1.time_ < var_90_5 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 413101021
		arg_91_1.duration_ = 4.17

		local var_91_0 = {
			zh = 2.433,
			ja = 4.166
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
				arg_91_0:Play413101022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if arg_91_1.actors_["10092"] == nil then
				local var_94_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_94_0) then
					local var_94_1 = Object.Instantiate(var_94_0, arg_91_1.canvasGo_.transform)

					var_94_1.transform:SetSiblingIndex(1)

					var_94_1.name = "10092"
					var_94_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_91_1.actors_["10092"] = var_94_1

					if arg_91_1.isInRecall_ then
						for iter_94_0, iter_94_1 in ipairs((var_94_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_94_1.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_94_2 = arg_91_1.actors_["10092"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10092 = var_94_2.localPosition
				var_94_2.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10092", 3)

				for iter_94_2 = 0, var_94_2.childCount - 1 do
					local var_94_3 = var_94_2:GetChild(iter_94_2)

					if var_94_3.name == "" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				var_94_2.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_91_1.time_ - 0) / var_94_4)
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				var_94_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_94_5 = arg_91_1.actors_["10093"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10093 = var_94_5.localPosition
				var_94_5.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10093", 7)

				for iter_94_3 = 0, var_94_5.childCount - 1 do
					local var_94_6 = var_94_5:GetChild(iter_94_3)

					if var_94_6.name == "" or not string.find(var_94_6.name, "split") then
						var_94_6.gameObject:SetActive(true)
					else
						var_94_6.gameObject:SetActive(false)
					end
				end
			end

			local var_94_7 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				var_94_5.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_91_1.time_ - 0) / var_94_7)
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				var_94_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_94_8 = arg_91_1.actors_["10092"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps10092 == nil then
				arg_91_1.var_.actorSpriteComps10092 = var_94_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_9 = 2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_9 and not isNil(var_94_8) then
				if arg_91_1.var_.actorSpriteComps10092 then
					for iter_94_4, iter_94_5 in pairs(arg_91_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_94_5 then
							if arg_91_1.isInRecall_ then
								iter_94_5.color = Color.New(Mathf.Lerp(iter_94_5.color.r, arg_91_1.hightColor1.r, (arg_91_1.time_ - 0) / var_94_9), Mathf.Lerp(iter_94_5.color.g, arg_91_1.hightColor1.g, (arg_91_1.time_ - 0) / var_94_9), (Mathf.Lerp(iter_94_5.color.b, arg_91_1.hightColor1.b, (arg_91_1.time_ - 0) / var_94_9)))
							else
								local var_94_10 = Mathf.Lerp(iter_94_5.color.r, 1, (arg_91_1.time_ - 0) / var_94_9)

								iter_94_5.color = Color.New(var_94_10, var_94_10, var_94_10)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_9 and arg_91_1.time_ < 0 + var_94_9 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps10092 then
				for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_94_7 then
						iter_94_7.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps10092 = nil
			end

			local var_94_11 = arg_91_1.actors_["10093"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_11) and arg_91_1.var_.actorSpriteComps10093 == nil then
				arg_91_1.var_.actorSpriteComps10093 = var_94_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_12 = 2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_12 and not isNil(var_94_11) then
				if arg_91_1.var_.actorSpriteComps10093 then
					for iter_94_8, iter_94_9 in pairs(arg_91_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_94_9 then
							if arg_91_1.isInRecall_ then
								iter_94_9.color = Color.New(Mathf.Lerp(iter_94_9.color.r, arg_91_1.hightColor2.r, (arg_91_1.time_ - 0) / var_94_12), Mathf.Lerp(iter_94_9.color.g, arg_91_1.hightColor2.g, (arg_91_1.time_ - 0) / var_94_12), (Mathf.Lerp(iter_94_9.color.b, arg_91_1.hightColor2.b, (arg_91_1.time_ - 0) / var_94_12)))
							else
								local var_94_13 = Mathf.Lerp(iter_94_9.color.r, 0.5, (arg_91_1.time_ - 0) / var_94_12)

								iter_94_9.color = Color.New(var_94_13, var_94_13, var_94_13)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_12 and arg_91_1.time_ < 0 + var_94_12 + arg_94_0 and not isNil(var_94_11) and arg_91_1.var_.actorSpriteComps10093 then
				for iter_94_10, iter_94_11 in pairs(arg_91_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_94_11 then
						iter_94_11.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_91_1.var_.actorSpriteComps10093 = nil
			end

			local var_94_14 = 0
			local var_94_15 = 0.325

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_16 = arg_91_1:GetWordFromCfg(413101021)
				local var_94_17 = arg_91_1:FormatText(var_94_16.content)

				arg_91_1.text_.text = var_94_17

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_19 = 13 <= 0 and var_94_15 or var_94_15 * (utf8.len(var_94_17) / 13)

				if (13 <= 0 and var_94_15 or var_94_15 * (utf8.len(var_94_17) / 13)) > 0 and var_94_15 < var_94_19 then
					arg_91_1.talkMaxDuration = var_94_19

					if var_94_19 + var_94_14 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_19 + var_94_14
					end
				end

				arg_91_1.text_.text = var_94_17
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101021", "story_v_out_413101.awb") ~= 0 then
					local var_94_20 = manager.audio:GetVoiceLength("story_v_out_413101", "413101021", "story_v_out_413101.awb") / 1000

					if var_94_20 + var_94_14 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_20 + var_94_14
					end

					if var_94_16.prefab_name ~= "" and arg_91_1.actors_[var_94_16.prefab_name] ~= nil then
						local var_94_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_16.prefab_name].transform, "story_v_out_413101", "413101021", "story_v_out_413101.awb")

						arg_91_1:RecordAudio("413101021", var_94_21)
						arg_91_1:RecordAudio("413101021", var_94_21)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_413101", "413101021", "story_v_out_413101.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_413101", "413101021", "story_v_out_413101.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_22 = math.max(var_94_15, arg_91_1.talkMaxDuration)

			if var_94_14 <= arg_91_1.time_ and arg_91_1.time_ < var_94_14 + var_94_22 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_14) / var_94_22

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_14 + var_94_22 and arg_91_1.time_ < var_94_14 + var_94_22 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play413101022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 413101022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play413101023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10092 = arg_95_1.actors_["10092"].transform.localPosition
				arg_95_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10092", 6)

				for iter_98_0 = 0, arg_95_1.actors_["10092"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["10092"].transform:GetChild(iter_98_0)

					if var_98_0.name == "" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10092, Vector3.New(1500, -300, -295), (arg_95_1.time_ - 0) / var_98_1)
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["10092"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_98_2 = arg_95_1.actors_["10093"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10093 = var_98_2.localPosition
				var_98_2.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10093", 6)

				for iter_98_1 = 0, var_98_2.childCount - 1 do
					local var_98_3 = var_98_2:GetChild(iter_98_1)

					if var_98_3.name == "" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_2.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_95_1.time_ - 0) / var_98_4)
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_2.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_98_5 = arg_95_1.actors_["10092"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps10092 == nil then
				arg_95_1.var_.actorSpriteComps10092 = var_98_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_6 = 2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.actorSpriteComps10092 then
					for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_98_3 then
							if arg_95_1.isInRecall_ then
								iter_98_3.color = Color.New(Mathf.Lerp(iter_98_3.color.r, arg_95_1.hightColor2.r, (arg_95_1.time_ - 0) / var_98_6), Mathf.Lerp(iter_98_3.color.g, arg_95_1.hightColor2.g, (arg_95_1.time_ - 0) / var_98_6), (Mathf.Lerp(iter_98_3.color.b, arg_95_1.hightColor2.b, (arg_95_1.time_ - 0) / var_98_6)))
							else
								local var_98_7 = Mathf.Lerp(iter_98_3.color.r, 0.5, (arg_95_1.time_ - 0) / var_98_6)

								iter_98_3.color = Color.New(var_98_7, var_98_7, var_98_7)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_6 and arg_95_1.time_ < 0 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps10092 then
				for iter_98_4, iter_98_5 in pairs(arg_95_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_98_5 then
						iter_98_5.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps10092 = nil
			end

			local var_98_8 = arg_95_1.actors_["10093"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_8) and arg_95_1.var_.actorSpriteComps10093 == nil then
				arg_95_1.var_.actorSpriteComps10093 = var_98_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_9 = 2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_9 and not isNil(var_98_8) then
				if arg_95_1.var_.actorSpriteComps10093 then
					for iter_98_6, iter_98_7 in pairs(arg_95_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_98_7 then
							if arg_95_1.isInRecall_ then
								iter_98_7.color = Color.New(Mathf.Lerp(iter_98_7.color.r, arg_95_1.hightColor2.r, (arg_95_1.time_ - 0) / var_98_9), Mathf.Lerp(iter_98_7.color.g, arg_95_1.hightColor2.g, (arg_95_1.time_ - 0) / var_98_9), (Mathf.Lerp(iter_98_7.color.b, arg_95_1.hightColor2.b, (arg_95_1.time_ - 0) / var_98_9)))
							else
								local var_98_10 = Mathf.Lerp(iter_98_7.color.r, 0.5, (arg_95_1.time_ - 0) / var_98_9)

								iter_98_7.color = Color.New(var_98_10, var_98_10, var_98_10)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_9 and arg_95_1.time_ < 0 + var_98_9 + arg_98_0 and not isNil(var_98_8) and arg_95_1.var_.actorSpriteComps10093 then
				for iter_98_8, iter_98_9 in pairs(arg_95_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_98_9 then
						iter_98_9.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps10093 = nil
			end

			local var_98_11 = 0
			local var_98_12 = 0.75

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_11 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_13 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(413101022).content)

				arg_95_1.text_.text = var_98_13

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_15 = 30 <= 0 and var_98_12 or var_98_12 * (utf8.len(var_98_13) / 30)

				if (30 <= 0 and var_98_12 or var_98_12 * (utf8.len(var_98_13) / 30)) > 0 and var_98_12 < var_98_15 then
					arg_95_1.talkMaxDuration = var_98_15

					if var_98_15 + var_98_11 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_15 + var_98_11
					end
				end

				arg_95_1.text_.text = var_98_13
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_12, arg_95_1.talkMaxDuration)

			if var_98_11 <= arg_95_1.time_ and arg_95_1.time_ < var_98_11 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_11) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_11 + var_98_16 and arg_95_1.time_ < var_98_11 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play413101023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 413101023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play413101024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.55

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(413101023).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 62 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 62)

				if (62 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 62)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play413101024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 413101024
		arg_103_1.duration_ = 5.73

		local var_103_0 = {
			zh = 2.966,
			ja = 5.733
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play413101025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if arg_103_1.actors_["10094"] == nil then
				local var_106_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_106_0) then
					local var_106_1 = Object.Instantiate(var_106_0, arg_103_1.canvasGo_.transform)

					var_106_1.transform:SetSiblingIndex(1)

					var_106_1.name = "10094"
					var_106_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_103_1.actors_["10094"] = var_106_1

					if arg_103_1.isInRecall_ then
						for iter_106_0, iter_106_1 in ipairs((var_106_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_106_1.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_106_2 = arg_103_1.actors_["10094"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10094 = var_106_2.localPosition
				var_106_2.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10094", 3)

				for iter_106_2 = 0, var_106_2.childCount - 1 do
					local var_106_3 = var_106_2:GetChild(iter_106_2)

					if var_106_3.name == "split_1" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				var_106_2.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_103_1.time_ - 0) / var_106_4)
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				var_106_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_106_5 = arg_103_1.actors_["10094"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_5) and arg_103_1.var_.actorSpriteComps10094 == nil then
				arg_103_1.var_.actorSpriteComps10094 = var_106_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_6 = 2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_6 and not isNil(var_106_5) then
				if arg_103_1.var_.actorSpriteComps10094 then
					for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_106_4 then
							if arg_103_1.isInRecall_ then
								iter_106_4.color = Color.New(Mathf.Lerp(iter_106_4.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_6), Mathf.Lerp(iter_106_4.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_6), (Mathf.Lerp(iter_106_4.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_6)))
							else
								local var_106_7 = Mathf.Lerp(iter_106_4.color.r, 1, (arg_103_1.time_ - 0) / var_106_6)

								iter_106_4.color = Color.New(var_106_7, var_106_7, var_106_7)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_6 and arg_103_1.time_ < 0 + var_106_6 + arg_106_0 and not isNil(var_106_5) and arg_103_1.var_.actorSpriteComps10094 then
				for iter_106_5, iter_106_6 in pairs(arg_103_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_106_6 then
						iter_106_6.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps10094 = nil
			end

			local var_106_8 = 0
			local var_106_9 = 0.325

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_10 = arg_103_1:GetWordFromCfg(413101024)
				local var_106_11 = arg_103_1:FormatText(var_106_10.content)

				arg_103_1.text_.text = var_106_11

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 13 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 13)

				if (13 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 13)) > 0 and var_106_9 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_8
					end
				end

				arg_103_1.text_.text = var_106_11
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101024", "story_v_out_413101.awb") ~= 0 then
					local var_106_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101024", "story_v_out_413101.awb") / 1000

					if var_106_14 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_8
					end

					if var_106_10.prefab_name ~= "" and arg_103_1.actors_[var_106_10.prefab_name] ~= nil then
						local var_106_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_10.prefab_name].transform, "story_v_out_413101", "413101024", "story_v_out_413101.awb")

						arg_103_1:RecordAudio("413101024", var_106_15)
						arg_103_1:RecordAudio("413101024", var_106_15)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_413101", "413101024", "story_v_out_413101.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_413101", "413101024", "story_v_out_413101.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_16 = math.max(var_106_9, arg_103_1.talkMaxDuration)

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_16 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_8) / var_106_16

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_8 + var_106_16 and arg_103_1.time_ < var_106_8 + var_106_16 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play413101025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 413101025
		arg_107_1.duration_ = 8.47

		local var_107_0 = {
			zh = 5.966,
			ja = 8.466
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
				arg_107_0:Play413101026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10092 = arg_107_1.actors_["10092"].transform.localPosition
				arg_107_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10092", 4)

				for iter_110_0 = 0, arg_107_1.actors_["10092"].transform.childCount - 1 do
					local var_110_0 = arg_107_1.actors_["10092"].transform:GetChild(iter_110_0)

					if var_110_0.name == "" or not string.find(var_110_0.name, "split") then
						var_110_0.gameObject:SetActive(true)
					else
						var_110_0.gameObject:SetActive(false)
					end
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_107_1.time_ - 0) / var_110_1)
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_110_2 = arg_107_1.actors_["10092"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10092 == nil then
				arg_107_1.var_.actorSpriteComps10092 = var_110_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_3 = 2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.actorSpriteComps10092 then
					for iter_110_1, iter_110_2 in pairs(arg_107_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_110_2 then
							if arg_107_1.isInRecall_ then
								iter_110_2.color = Color.New(Mathf.Lerp(iter_110_2.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_3), Mathf.Lerp(iter_110_2.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_3), (Mathf.Lerp(iter_110_2.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_3)))
							else
								local var_110_4 = Mathf.Lerp(iter_110_2.color.r, 1, (arg_107_1.time_ - 0) / var_110_3)

								iter_110_2.color = Color.New(var_110_4, var_110_4, var_110_4)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10092 then
				for iter_110_3, iter_110_4 in pairs(arg_107_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_110_4 then
						iter_110_4.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps10092 = nil
			end

			local var_110_5 = arg_107_1.actors_["10094"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10094 = var_110_5.localPosition
				var_110_5.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10094", 2)

				for iter_110_5 = 0, var_110_5.childCount - 1 do
					local var_110_6 = var_110_5:GetChild(iter_110_5)

					if var_110_6.name == "" or not string.find(var_110_6.name, "split") then
						var_110_6.gameObject:SetActive(true)
					else
						var_110_6.gameObject:SetActive(false)
					end
				end
			end

			local var_110_7 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				var_110_5.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_107_1.time_ - 0) / var_110_7)
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				var_110_5.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_110_8 = arg_107_1.actors_["10094"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps10094 == nil then
				arg_107_1.var_.actorSpriteComps10094 = var_110_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_9 = 2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_9 and not isNil(var_110_8) then
				if arg_107_1.var_.actorSpriteComps10094 then
					for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_110_7 then
							if arg_107_1.isInRecall_ then
								iter_110_7.color = Color.New(Mathf.Lerp(iter_110_7.color.r, arg_107_1.hightColor2.r, (arg_107_1.time_ - 0) / var_110_9), Mathf.Lerp(iter_110_7.color.g, arg_107_1.hightColor2.g, (arg_107_1.time_ - 0) / var_110_9), (Mathf.Lerp(iter_110_7.color.b, arg_107_1.hightColor2.b, (arg_107_1.time_ - 0) / var_110_9)))
							else
								local var_110_10 = Mathf.Lerp(iter_110_7.color.r, 0.5, (arg_107_1.time_ - 0) / var_110_9)

								iter_110_7.color = Color.New(var_110_10, var_110_10, var_110_10)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_9 and arg_107_1.time_ < 0 + var_110_9 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps10094 then
				for iter_110_8, iter_110_9 in pairs(arg_107_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_110_9 then
						iter_110_9.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps10094 = nil
			end

			local var_110_11 = 0
			local var_110_12 = 0.825

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_13 = arg_107_1:GetWordFromCfg(413101025)
				local var_110_14 = arg_107_1:FormatText(var_110_13.content)

				arg_107_1.text_.text = var_110_14

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_16 = 33 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 33)

				if (33 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 33)) > 0 and var_110_12 < var_110_16 then
					arg_107_1.talkMaxDuration = var_110_16

					if var_110_16 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_16 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_14
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101025", "story_v_out_413101.awb") ~= 0 then
					local var_110_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101025", "story_v_out_413101.awb") / 1000

					if var_110_17 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_17 + var_110_11
					end

					if var_110_13.prefab_name ~= "" and arg_107_1.actors_[var_110_13.prefab_name] ~= nil then
						local var_110_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_13.prefab_name].transform, "story_v_out_413101", "413101025", "story_v_out_413101.awb")

						arg_107_1:RecordAudio("413101025", var_110_18)
						arg_107_1:RecordAudio("413101025", var_110_18)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_413101", "413101025", "story_v_out_413101.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_413101", "413101025", "story_v_out_413101.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_19 = math.max(var_110_12, arg_107_1.talkMaxDuration)

			if var_110_11 <= arg_107_1.time_ and arg_107_1.time_ < var_110_11 + var_110_19 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_11) / var_110_19

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_11 + var_110_19 and arg_107_1.time_ < var_110_11 + var_110_19 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413101026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 413101026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play413101027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10092 = arg_111_1.actors_["10092"].transform.localPosition
				arg_111_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10092", 7)

				for iter_114_0 = 0, arg_111_1.actors_["10092"].transform.childCount - 1 do
					local var_114_0 = arg_111_1.actors_["10092"].transform:GetChild(iter_114_0)

					if var_114_0.name == "" or not string.find(var_114_0.name, "split") then
						var_114_0.gameObject:SetActive(true)
					else
						var_114_0.gameObject:SetActive(false)
					end
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_111_1.time_ - 0) / var_114_1)
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_114_2 = arg_111_1.actors_["10092"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps10092 == nil then
				arg_111_1.var_.actorSpriteComps10092 = var_114_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_3 = 2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.actorSpriteComps10092 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_114_2 then
							if arg_111_1.isInRecall_ then
								iter_114_2.color = Color.New(Mathf.Lerp(iter_114_2.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_3), Mathf.Lerp(iter_114_2.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_3), (Mathf.Lerp(iter_114_2.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_3)))
							else
								local var_114_4 = Mathf.Lerp(iter_114_2.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_3)

								iter_114_2.color = Color.New(var_114_4, var_114_4, var_114_4)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps10092 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_114_4 then
						iter_114_4.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps10092 = nil
			end

			local var_114_5 = arg_111_1.actors_["10092"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps10092 == nil then
				arg_111_1.var_.actorSpriteComps10092 = var_114_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_6 = 2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.actorSpriteComps10092 then
					for iter_114_5, iter_114_6 in pairs(arg_111_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_114_6 then
							if arg_111_1.isInRecall_ then
								iter_114_6.color = Color.New(Mathf.Lerp(iter_114_6.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_6), Mathf.Lerp(iter_114_6.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_6), (Mathf.Lerp(iter_114_6.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_6)))
							else
								local var_114_7 = Mathf.Lerp(iter_114_6.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_6)

								iter_114_6.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps10092 then
				for iter_114_7, iter_114_8 in pairs(arg_111_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_114_8 then
						iter_114_8.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps10092 = nil
			end

			local var_114_8 = arg_111_1.actors_["10094"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10094 = var_114_8.localPosition
				var_114_8.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10094", 7)

				for iter_114_9 = 0, var_114_8.childCount - 1 do
					local var_114_9 = var_114_8:GetChild(iter_114_9)

					if var_114_9.name == "" or not string.find(var_114_9.name, "split") then
						var_114_9.gameObject:SetActive(true)
					else
						var_114_9.gameObject:SetActive(false)
					end
				end
			end

			local var_114_10 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_10 then
				var_114_8.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_111_1.time_ - 0) / var_114_10)
			end

			if arg_111_1.time_ >= 0 + var_114_10 and arg_111_1.time_ < 0 + var_114_10 + arg_114_0 then
				var_114_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_114_11 = 0
			local var_114_12 = 1.1

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_13 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(413101026).content)

				arg_111_1.text_.text = var_114_13

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_15 = 44 <= 0 and var_114_12 or var_114_12 * (utf8.len(var_114_13) / 44)

				if (44 <= 0 and var_114_12 or var_114_12 * (utf8.len(var_114_13) / 44)) > 0 and var_114_12 < var_114_15 then
					arg_111_1.talkMaxDuration = var_114_15

					if var_114_15 + var_114_11 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_15 + var_114_11
					end
				end

				arg_111_1.text_.text = var_114_13
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_12, arg_111_1.talkMaxDuration)

			if var_114_11 <= arg_111_1.time_ and arg_111_1.time_ < var_114_11 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_11) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_11 + var_114_16 and arg_111_1.time_ < var_114_11 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play413101027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413101027
		arg_115_1.duration_ = 9.53

		local var_115_0 = {
			zh = 4.9,
			ja = 9.533
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
				arg_115_0:Play413101028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.actors_["10022"] == nil then
				local var_118_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_118_0) then
					local var_118_1 = Object.Instantiate(var_118_0, arg_115_1.canvasGo_.transform)

					var_118_1.transform:SetSiblingIndex(1)

					var_118_1.name = "10022"
					var_118_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_115_1.actors_["10022"] = var_118_1

					if arg_115_1.isInRecall_ then
						for iter_118_0, iter_118_1 in ipairs((var_118_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_118_1.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_118_2 = arg_115_1.actors_["10022"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10022 = var_118_2.localPosition
				var_118_2.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10022", 2)

				for iter_118_2 = 0, var_118_2.childCount - 1 do
					local var_118_3 = var_118_2:GetChild(iter_118_2)

					if var_118_3.name == "split_2" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_2.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_115_1.time_ - 0) / var_118_4)
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_118_5 = arg_115_1.actors_["10022"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps10022 == nil then
				arg_115_1.var_.actorSpriteComps10022 = var_118_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_6 = 2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 and not isNil(var_118_5) then
				if arg_115_1.var_.actorSpriteComps10022 then
					for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_118_4 then
							if arg_115_1.isInRecall_ then
								iter_118_4.color = Color.New(Mathf.Lerp(iter_118_4.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_6), Mathf.Lerp(iter_118_4.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_6), (Mathf.Lerp(iter_118_4.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_6)))
							else
								local var_118_7 = Mathf.Lerp(iter_118_4.color.r, 1, (arg_115_1.time_ - 0) / var_118_6)

								iter_118_4.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps10022 then
				for iter_118_5, iter_118_6 in pairs(arg_115_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_118_6 then
						iter_118_6.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps10022 = nil
			end

			local var_118_8 = 0
			local var_118_9 = 0.775

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_10 = arg_115_1:GetWordFromCfg(413101027)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 31 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 31)

				if (31 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 31)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101027", "story_v_out_413101.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101027", "story_v_out_413101.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_413101", "413101027", "story_v_out_413101.awb")

						arg_115_1:RecordAudio("413101027", var_118_15)
						arg_115_1:RecordAudio("413101027", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_413101", "413101027", "story_v_out_413101.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_413101", "413101027", "story_v_out_413101.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_8) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_8 + var_118_16 and arg_115_1.time_ < var_118_8 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413101028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413101028
		arg_119_1.duration_ = 6.93

		local var_119_0 = {
			zh = 3.766,
			ja = 6.933
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
				arg_119_0:Play413101029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10093 = arg_119_1.actors_["10093"].transform.localPosition
				arg_119_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10093", 4)

				for iter_122_0 = 0, arg_119_1.actors_["10093"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10093"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_4" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_122_2 = arg_119_1.actors_["10093"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10093 == nil then
				arg_119_1.var_.actorSpriteComps10093 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps10093 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								iter_122_2.color = Color.New(Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_3), Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_3), (Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_3)))
							else
								local var_122_4 = Mathf.Lerp(iter_122_2.color.r, 1, (arg_119_1.time_ - 0) / var_122_3)

								iter_122_2.color = Color.New(var_122_4, var_122_4, var_122_4)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10093 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_122_4 then
						iter_122_4.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10093 = nil
			end

			local var_122_5 = arg_119_1.actors_["10022"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.actorSpriteComps10022 == nil then
				arg_119_1.var_.actorSpriteComps10022 = var_122_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_6 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_6 and not isNil(var_122_5) then
				if arg_119_1.var_.actorSpriteComps10022 then
					for iter_122_5, iter_122_6 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_122_6 then
							if arg_119_1.isInRecall_ then
								iter_122_6.color = Color.New(Mathf.Lerp(iter_122_6.color.r, arg_119_1.hightColor2.r, (arg_119_1.time_ - 0) / var_122_6), Mathf.Lerp(iter_122_6.color.g, arg_119_1.hightColor2.g, (arg_119_1.time_ - 0) / var_122_6), (Mathf.Lerp(iter_122_6.color.b, arg_119_1.hightColor2.b, (arg_119_1.time_ - 0) / var_122_6)))
							else
								local var_122_7 = Mathf.Lerp(iter_122_6.color.r, 0.5, (arg_119_1.time_ - 0) / var_122_6)

								iter_122_6.color = Color.New(var_122_7, var_122_7, var_122_7)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_6 and arg_119_1.time_ < 0 + var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.actorSpriteComps10022 then
				for iter_122_7, iter_122_8 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_122_8 then
						iter_122_8.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps10022 = nil
			end

			local var_122_8 = 0
			local var_122_9 = 0.425

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(413101028)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 17 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 17)

				if (17 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 17)) > 0 and var_122_9 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101028", "story_v_out_413101.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101028", "story_v_out_413101.awb") / 1000

					if var_122_14 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_8
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_413101", "413101028", "story_v_out_413101.awb")

						arg_119_1:RecordAudio("413101028", var_122_15)
						arg_119_1:RecordAudio("413101028", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413101", "413101028", "story_v_out_413101.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413101", "413101028", "story_v_out_413101.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_16 = math.max(var_122_9, arg_119_1.talkMaxDuration)

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_16 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_8) / var_122_16

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_8 + var_122_16 and arg_119_1.time_ < var_122_8 + var_122_16 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413101029
		arg_123_1.duration_ = 2.2

		local var_123_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_123_0:Play413101030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10022 = arg_123_1.actors_["10022"].transform.localPosition
				arg_123_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10022", 2)

				for iter_126_0 = 0, arg_123_1.actors_["10022"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["10022"].transform:GetChild(iter_126_0)

					if var_126_0.name == "split_6" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_126_2 = arg_123_1.actors_["10093"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10093 = var_126_2.localPosition
				var_126_2.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10093", 4)

				for iter_126_1 = 0, var_126_2.childCount - 1 do
					local var_126_3 = var_126_2:GetChild(iter_126_1)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_2.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_123_1.time_ - 0) / var_126_4)
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_126_5 = arg_123_1.actors_["10022"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps10022 == nil then
				arg_123_1.var_.actorSpriteComps10022 = var_126_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_6 = 2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.actorSpriteComps10022 then
					for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_126_3 then
							if arg_123_1.isInRecall_ then
								iter_126_3.color = Color.New(Mathf.Lerp(iter_126_3.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_6), Mathf.Lerp(iter_126_3.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_6), (Mathf.Lerp(iter_126_3.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_6)))
							else
								local var_126_7 = Mathf.Lerp(iter_126_3.color.r, 1, (arg_123_1.time_ - 0) / var_126_6)

								iter_126_3.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps10022 then
				for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_126_5 then
						iter_126_5.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10022 = nil
			end

			local var_126_8 = arg_123_1.actors_["10093"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps10093 == nil then
				arg_123_1.var_.actorSpriteComps10093 = var_126_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_9 = 2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_9 and not isNil(var_126_8) then
				if arg_123_1.var_.actorSpriteComps10093 then
					for iter_126_6, iter_126_7 in pairs(arg_123_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_126_7 then
							if arg_123_1.isInRecall_ then
								iter_126_7.color = Color.New(Mathf.Lerp(iter_126_7.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_9), Mathf.Lerp(iter_126_7.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_9), (Mathf.Lerp(iter_126_7.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_9)))
							else
								local var_126_10 = Mathf.Lerp(iter_126_7.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_9)

								iter_126_7.color = Color.New(var_126_10, var_126_10, var_126_10)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_9 and arg_123_1.time_ < 0 + var_126_9 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps10093 then
				for iter_126_8, iter_126_9 in pairs(arg_123_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_126_9 then
						iter_126_9.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10093 = nil
			end

			local var_126_11 = 0
			local var_126_12 = 0.125

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_13 = arg_123_1:GetWordFromCfg(413101029)
				local var_126_14 = arg_123_1:FormatText(var_126_13.content)

				arg_123_1.text_.text = var_126_14

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_16 = 5 <= 0 and var_126_12 or var_126_12 * (utf8.len(var_126_14) / 5)

				if (5 <= 0 and var_126_12 or var_126_12 * (utf8.len(var_126_14) / 5)) > 0 and var_126_12 < var_126_16 then
					arg_123_1.talkMaxDuration = var_126_16

					if var_126_16 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_16 + var_126_11
					end
				end

				arg_123_1.text_.text = var_126_14
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101029", "story_v_out_413101.awb") ~= 0 then
					local var_126_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101029", "story_v_out_413101.awb") / 1000

					if var_126_17 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_17 + var_126_11
					end

					if var_126_13.prefab_name ~= "" and arg_123_1.actors_[var_126_13.prefab_name] ~= nil then
						local var_126_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_13.prefab_name].transform, "story_v_out_413101", "413101029", "story_v_out_413101.awb")

						arg_123_1:RecordAudio("413101029", var_126_18)
						arg_123_1:RecordAudio("413101029", var_126_18)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413101", "413101029", "story_v_out_413101.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413101", "413101029", "story_v_out_413101.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_19 = math.max(var_126_12, arg_123_1.talkMaxDuration)

			if var_126_11 <= arg_123_1.time_ and arg_123_1.time_ < var_126_11 + var_126_19 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_11) / var_126_19

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_11 + var_126_19 and arg_123_1.time_ < var_126_11 + var_126_19 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413101030
		arg_127_1.duration_ = 3.63

		local var_127_0 = {
			zh = 3.633,
			ja = 3.1
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
				arg_127_0:Play413101031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.475

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:GetWordFromCfg(413101030)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 19 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 19)

				if (19 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 19)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101030", "story_v_out_413101.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101030", "story_v_out_413101.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_413101", "413101030", "story_v_out_413101.awb")

						arg_127_1:RecordAudio("413101030", var_130_6)
						arg_127_1:RecordAudio("413101030", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413101", "413101030", "story_v_out_413101.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413101", "413101030", "story_v_out_413101.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play413101031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413101031
		arg_131_1.duration_ = 11.47

		local var_131_0 = {
			zh = 6.4,
			ja = 11.466
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
				arg_131_0:Play413101032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10093 = arg_131_1.actors_["10093"].transform.localPosition
				arg_131_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10093", 4)

				for iter_134_0 = 0, arg_131_1.actors_["10093"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["10093"].transform:GetChild(iter_134_0)

					if var_134_0.name == "split_4" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_134_2 = arg_131_1.actors_["10093"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10093 == nil then
				arg_131_1.var_.actorSpriteComps10093 = var_134_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_3 = 2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.actorSpriteComps10093 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_134_2 then
							if arg_131_1.isInRecall_ then
								iter_134_2.color = Color.New(Mathf.Lerp(iter_134_2.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_3), Mathf.Lerp(iter_134_2.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_3), (Mathf.Lerp(iter_134_2.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_3)))
							else
								local var_134_4 = Mathf.Lerp(iter_134_2.color.r, 1, (arg_131_1.time_ - 0) / var_134_3)

								iter_134_2.color = Color.New(var_134_4, var_134_4, var_134_4)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10093 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_134_4 then
						iter_134_4.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps10093 = nil
			end

			local var_134_5 = arg_131_1.actors_["10022"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.actorSpriteComps10022 == nil then
				arg_131_1.var_.actorSpriteComps10022 = var_134_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_6 = 2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_6 and not isNil(var_134_5) then
				if arg_131_1.var_.actorSpriteComps10022 then
					for iter_134_5, iter_134_6 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_134_6 then
							if arg_131_1.isInRecall_ then
								iter_134_6.color = Color.New(Mathf.Lerp(iter_134_6.color.r, arg_131_1.hightColor2.r, (arg_131_1.time_ - 0) / var_134_6), Mathf.Lerp(iter_134_6.color.g, arg_131_1.hightColor2.g, (arg_131_1.time_ - 0) / var_134_6), (Mathf.Lerp(iter_134_6.color.b, arg_131_1.hightColor2.b, (arg_131_1.time_ - 0) / var_134_6)))
							else
								local var_134_7 = Mathf.Lerp(iter_134_6.color.r, 0.5, (arg_131_1.time_ - 0) / var_134_6)

								iter_134_6.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_6 and arg_131_1.time_ < 0 + var_134_6 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.actorSpriteComps10022 then
				for iter_134_7, iter_134_8 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_134_8 then
						iter_134_8.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps10022 = nil
			end

			local var_134_8 = 0
			local var_134_9 = 0.675

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(413101031)
				local var_134_11 = arg_131_1:FormatText(var_134_10.content)

				arg_131_1.text_.text = var_134_11

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 27 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 27)

				if (27 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 27)) > 0 and var_134_9 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_11
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101031", "story_v_out_413101.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101031", "story_v_out_413101.awb") / 1000

					if var_134_14 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_8
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_413101", "413101031", "story_v_out_413101.awb")

						arg_131_1:RecordAudio("413101031", var_134_15)
						arg_131_1:RecordAudio("413101031", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413101", "413101031", "story_v_out_413101.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413101", "413101031", "story_v_out_413101.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_16 and arg_131_1.time_ < var_134_8 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413101032
		arg_135_1.duration_ = 9.03

		local var_135_0 = {
			zh = 9.033,
			ja = 7.433
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
				arg_135_0:Play413101033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10022 = arg_135_1.actors_["10022"].transform.localPosition
				arg_135_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10022", 2)

				for iter_138_0 = 0, arg_135_1.actors_["10022"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["10022"].transform:GetChild(iter_138_0)

					if var_138_0.name == "split_2" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_138_2 = arg_135_1.actors_["10022"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10022 == nil then
				arg_135_1.var_.actorSpriteComps10022 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps10022 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								iter_138_2.color = Color.New(Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_2.color.r, 1, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_2.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10022 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_138_4 then
						iter_138_4.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10022 = nil
			end

			local var_138_5 = arg_135_1.actors_["10093"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps10093 == nil then
				arg_135_1.var_.actorSpriteComps10093 = var_138_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_6 = 2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.actorSpriteComps10093 then
					for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_138_6 then
							if arg_135_1.isInRecall_ then
								iter_138_6.color = Color.New(Mathf.Lerp(iter_138_6.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_6), Mathf.Lerp(iter_138_6.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_6), (Mathf.Lerp(iter_138_6.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_6)))
							else
								local var_138_7 = Mathf.Lerp(iter_138_6.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_6)

								iter_138_6.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps10093 then
				for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_138_8 then
						iter_138_8.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10093 = nil
			end

			local var_138_8 = 0
			local var_138_9 = 0.8

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_10 = arg_135_1:GetWordFromCfg(413101032)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 31 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 31)

				if (31 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 31)) > 0 and var_138_9 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101032", "story_v_out_413101.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101032", "story_v_out_413101.awb") / 1000

					if var_138_14 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_8
					end

					if var_138_10.prefab_name ~= "" and arg_135_1.actors_[var_138_10.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_10.prefab_name].transform, "story_v_out_413101", "413101032", "story_v_out_413101.awb")

						arg_135_1:RecordAudio("413101032", var_138_15)
						arg_135_1:RecordAudio("413101032", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_413101", "413101032", "story_v_out_413101.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_413101", "413101032", "story_v_out_413101.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_16 and arg_135_1.time_ < var_138_8 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413101033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413101033
		arg_139_1.duration_ = 3.43

		local var_139_0 = {
			zh = 2.666,
			ja = 3.433
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
				arg_139_0:Play413101034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10093 = arg_139_1.actors_["10093"].transform.localPosition
				arg_139_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10093", 4)

				for iter_142_0 = 0, arg_139_1.actors_["10093"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["10093"].transform:GetChild(iter_142_0)

					if var_142_0.name == "split_6" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_142_2 = arg_139_1.actors_["10093"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps10093 == nil then
				arg_139_1.var_.actorSpriteComps10093 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps10093 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								iter_142_2.color = Color.New(Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_2.color.r, 1, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_2.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps10093 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_142_4 then
						iter_142_4.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps10093 = nil
			end

			local var_142_5 = arg_139_1.actors_["10022"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.actorSpriteComps10022 == nil then
				arg_139_1.var_.actorSpriteComps10022 = var_142_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_6 = 2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.actorSpriteComps10022 then
					for iter_142_5, iter_142_6 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_142_6 then
							if arg_139_1.isInRecall_ then
								iter_142_6.color = Color.New(Mathf.Lerp(iter_142_6.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_6), Mathf.Lerp(iter_142_6.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_6), (Mathf.Lerp(iter_142_6.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_6)))
							else
								local var_142_7 = Mathf.Lerp(iter_142_6.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_6)

								iter_142_6.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.actorSpriteComps10022 then
				for iter_142_7, iter_142_8 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_142_8 then
						iter_142_8.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps10022 = nil
			end

			local var_142_8 = 0
			local var_142_9 = 0.275

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(413101033)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 11 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 11)

				if (11 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 11)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101033", "story_v_out_413101.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101033", "story_v_out_413101.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_413101", "413101033", "story_v_out_413101.awb")

						arg_139_1:RecordAudio("413101033", var_142_15)
						arg_139_1:RecordAudio("413101033", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413101", "413101033", "story_v_out_413101.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413101", "413101033", "story_v_out_413101.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413101034
		arg_143_1.duration_ = 8.07

		local var_143_0 = {
			zh = 2.733,
			ja = 8.066
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
				arg_143_0:Play413101035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10022 = arg_143_1.actors_["10022"].transform.localPosition
				arg_143_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10022", 2)

				for iter_146_0 = 0, arg_143_1.actors_["10022"].transform.childCount - 1 do
					local var_146_0 = arg_143_1.actors_["10022"].transform:GetChild(iter_146_0)

					if var_146_0.name == "split_6" or not string.find(var_146_0.name, "split") then
						var_146_0.gameObject:SetActive(true)
					else
						var_146_0.gameObject:SetActive(false)
					end
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_143_1.time_ - 0) / var_146_1)
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_146_2 = arg_143_1.actors_["10093"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10093 = var_146_2.localPosition
				var_146_2.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10093", 4)

				for iter_146_1 = 0, var_146_2.childCount - 1 do
					local var_146_3 = var_146_2:GetChild(iter_146_1)

					if var_146_3.name == "" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				var_146_2.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_143_1.time_ - 0) / var_146_4)
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				var_146_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_146_5 = arg_143_1.actors_["10022"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps10022 == nil then
				arg_143_1.var_.actorSpriteComps10022 = var_146_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_6 = 2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_6 and not isNil(var_146_5) then
				if arg_143_1.var_.actorSpriteComps10022 then
					for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_146_3 then
							if arg_143_1.isInRecall_ then
								iter_146_3.color = Color.New(Mathf.Lerp(iter_146_3.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_6), Mathf.Lerp(iter_146_3.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_6), (Mathf.Lerp(iter_146_3.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_6)))
							else
								local var_146_7 = Mathf.Lerp(iter_146_3.color.r, 1, (arg_143_1.time_ - 0) / var_146_6)

								iter_146_3.color = Color.New(var_146_7, var_146_7, var_146_7)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_6 and arg_143_1.time_ < 0 + var_146_6 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps10022 then
				for iter_146_4, iter_146_5 in pairs(arg_143_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_146_5 then
						iter_146_5.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps10022 = nil
			end

			local var_146_8 = arg_143_1.actors_["10093"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps10093 == nil then
				arg_143_1.var_.actorSpriteComps10093 = var_146_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_9 = 2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_9 and not isNil(var_146_8) then
				if arg_143_1.var_.actorSpriteComps10093 then
					for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_146_7 then
							if arg_143_1.isInRecall_ then
								iter_146_7.color = Color.New(Mathf.Lerp(iter_146_7.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_9), Mathf.Lerp(iter_146_7.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_9), (Mathf.Lerp(iter_146_7.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_9)))
							else
								local var_146_10 = Mathf.Lerp(iter_146_7.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_9)

								iter_146_7.color = Color.New(var_146_10, var_146_10, var_146_10)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_9 and arg_143_1.time_ < 0 + var_146_9 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps10093 then
				for iter_146_8, iter_146_9 in pairs(arg_143_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_146_9 then
						iter_146_9.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps10093 = nil
			end

			local var_146_11 = 0
			local var_146_12 = 0.45

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_13 = arg_143_1:GetWordFromCfg(413101034)
				local var_146_14 = arg_143_1:FormatText(var_146_13.content)

				arg_143_1.text_.text = var_146_14

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_16 = 16 <= 0 and var_146_12 or var_146_12 * (utf8.len(var_146_14) / 16)

				if (16 <= 0 and var_146_12 or var_146_12 * (utf8.len(var_146_14) / 16)) > 0 and var_146_12 < var_146_16 then
					arg_143_1.talkMaxDuration = var_146_16

					if var_146_16 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_16 + var_146_11
					end
				end

				arg_143_1.text_.text = var_146_14
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101034", "story_v_out_413101.awb") ~= 0 then
					local var_146_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101034", "story_v_out_413101.awb") / 1000

					if var_146_17 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_17 + var_146_11
					end

					if var_146_13.prefab_name ~= "" and arg_143_1.actors_[var_146_13.prefab_name] ~= nil then
						local var_146_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_13.prefab_name].transform, "story_v_out_413101", "413101034", "story_v_out_413101.awb")

						arg_143_1:RecordAudio("413101034", var_146_18)
						arg_143_1:RecordAudio("413101034", var_146_18)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413101", "413101034", "story_v_out_413101.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413101", "413101034", "story_v_out_413101.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_19 = math.max(var_146_12, arg_143_1.talkMaxDuration)

			if var_146_11 <= arg_143_1.time_ and arg_143_1.time_ < var_146_11 + var_146_19 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_11) / var_146_19

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_11 + var_146_19 and arg_143_1.time_ < var_146_11 + var_146_19 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413101035
		arg_147_1.duration_ = 5.4

		local var_147_0 = {
			zh = 2.466,
			ja = 5.4
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
				arg_147_0:Play413101036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10093 = arg_147_1.actors_["10093"].transform.localPosition
				arg_147_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10093", 4)

				for iter_150_0 = 0, arg_147_1.actors_["10093"].transform.childCount - 1 do
					local var_150_0 = arg_147_1.actors_["10093"].transform:GetChild(iter_150_0)

					if var_150_0.name == "split_4" or not string.find(var_150_0.name, "split") then
						var_150_0.gameObject:SetActive(true)
					else
						var_150_0.gameObject:SetActive(false)
					end
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_147_1.time_ - 0) / var_150_1)
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_150_2 = arg_147_1.actors_["10093"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps10093 == nil then
				arg_147_1.var_.actorSpriteComps10093 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps10093 then
					for iter_150_1, iter_150_2 in pairs(arg_147_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_150_2 then
							if arg_147_1.isInRecall_ then
								iter_150_2.color = Color.New(Mathf.Lerp(iter_150_2.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_3), Mathf.Lerp(iter_150_2.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_3), (Mathf.Lerp(iter_150_2.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_3)))
							else
								local var_150_4 = Mathf.Lerp(iter_150_2.color.r, 1, (arg_147_1.time_ - 0) / var_150_3)

								iter_150_2.color = Color.New(var_150_4, var_150_4, var_150_4)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps10093 then
				for iter_150_3, iter_150_4 in pairs(arg_147_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_150_4 then
						iter_150_4.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps10093 = nil
			end

			local var_150_5 = arg_147_1.actors_["10022"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.actorSpriteComps10022 == nil then
				arg_147_1.var_.actorSpriteComps10022 = var_150_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_6 = 2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_6 and not isNil(var_150_5) then
				if arg_147_1.var_.actorSpriteComps10022 then
					for iter_150_5, iter_150_6 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_150_6 then
							if arg_147_1.isInRecall_ then
								iter_150_6.color = Color.New(Mathf.Lerp(iter_150_6.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_6), Mathf.Lerp(iter_150_6.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_6), (Mathf.Lerp(iter_150_6.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_6)))
							else
								local var_150_7 = Mathf.Lerp(iter_150_6.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_6)

								iter_150_6.color = Color.New(var_150_7, var_150_7, var_150_7)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_6 and arg_147_1.time_ < 0 + var_150_6 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.actorSpriteComps10022 then
				for iter_150_7, iter_150_8 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_150_8 then
						iter_150_8.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps10022 = nil
			end

			local var_150_8 = 0
			local var_150_9 = 0.375

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_10 = arg_147_1:GetWordFromCfg(413101035)
				local var_150_11 = arg_147_1:FormatText(var_150_10.content)

				arg_147_1.text_.text = var_150_11

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 15 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 15)

				if (15 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 15)) > 0 and var_150_9 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_11
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101035", "story_v_out_413101.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101035", "story_v_out_413101.awb") / 1000

					if var_150_14 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_8
					end

					if var_150_10.prefab_name ~= "" and arg_147_1.actors_[var_150_10.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_10.prefab_name].transform, "story_v_out_413101", "413101035", "story_v_out_413101.awb")

						arg_147_1:RecordAudio("413101035", var_150_15)
						arg_147_1:RecordAudio("413101035", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413101", "413101035", "story_v_out_413101.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413101", "413101035", "story_v_out_413101.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_9, arg_147_1.talkMaxDuration)

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_8) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_8 + var_150_16 and arg_147_1.time_ < var_150_8 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play413101036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413101036
		arg_151_1.duration_ = 9.83

		local var_151_0 = {
			zh = 9.833,
			ja = 7.966
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
				arg_151_0:Play413101037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10022 = arg_151_1.actors_["10022"].transform.localPosition
				arg_151_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10022", 2)

				for iter_154_0 = 0, arg_151_1.actors_["10022"].transform.childCount - 1 do
					local var_154_0 = arg_151_1.actors_["10022"].transform:GetChild(iter_154_0)

					if var_154_0.name == "split_3" or not string.find(var_154_0.name, "split") then
						var_154_0.gameObject:SetActive(true)
					else
						var_154_0.gameObject:SetActive(false)
					end
				end
			end

			local var_154_1 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 then
				arg_151_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_151_1.time_ - 0) / var_154_1)
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 then
				arg_151_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_154_2 = arg_151_1.actors_["10022"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10022 == nil then
				arg_151_1.var_.actorSpriteComps10022 = var_154_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_3 = 2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.actorSpriteComps10022 then
					for iter_154_1, iter_154_2 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_154_2 then
							if arg_151_1.isInRecall_ then
								iter_154_2.color = Color.New(Mathf.Lerp(iter_154_2.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_3), Mathf.Lerp(iter_154_2.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_3), (Mathf.Lerp(iter_154_2.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_3)))
							else
								local var_154_4 = Mathf.Lerp(iter_154_2.color.r, 1, (arg_151_1.time_ - 0) / var_154_3)

								iter_154_2.color = Color.New(var_154_4, var_154_4, var_154_4)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10022 then
				for iter_154_3, iter_154_4 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_154_4 then
						iter_154_4.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps10022 = nil
			end

			local var_154_5 = arg_151_1.actors_["10093"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.actorSpriteComps10093 == nil then
				arg_151_1.var_.actorSpriteComps10093 = var_154_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_6 = 2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_6 and not isNil(var_154_5) then
				if arg_151_1.var_.actorSpriteComps10093 then
					for iter_154_5, iter_154_6 in pairs(arg_151_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_154_6 then
							if arg_151_1.isInRecall_ then
								iter_154_6.color = Color.New(Mathf.Lerp(iter_154_6.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_6), Mathf.Lerp(iter_154_6.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_6), (Mathf.Lerp(iter_154_6.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_6)))
							else
								local var_154_7 = Mathf.Lerp(iter_154_6.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_6)

								iter_154_6.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_6 and arg_151_1.time_ < 0 + var_154_6 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.actorSpriteComps10093 then
				for iter_154_7, iter_154_8 in pairs(arg_151_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_154_8 then
						iter_154_8.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10093 = nil
			end

			local var_154_8 = 0
			local var_154_9 = 0.85

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_10 = arg_151_1:GetWordFromCfg(413101036)
				local var_154_11 = arg_151_1:FormatText(var_154_10.content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 34 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 34)

				if (34 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 34)) > 0 and var_154_9 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101036", "story_v_out_413101.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101036", "story_v_out_413101.awb") / 1000

					if var_154_14 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_8
					end

					if var_154_10.prefab_name ~= "" and arg_151_1.actors_[var_154_10.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_10.prefab_name].transform, "story_v_out_413101", "413101036", "story_v_out_413101.awb")

						arg_151_1:RecordAudio("413101036", var_154_15)
						arg_151_1:RecordAudio("413101036", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413101", "413101036", "story_v_out_413101.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413101", "413101036", "story_v_out_413101.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_16 and arg_151_1.time_ < var_154_8 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play413101037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 413101037
		arg_155_1.duration_ = 4.53

		local var_155_0 = {
			zh = 4.533,
			ja = 3.933
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
				arg_155_0:Play413101038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10093 = arg_155_1.actors_["10093"].transform.localPosition
				arg_155_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10093", 4)

				for iter_158_0 = 0, arg_155_1.actors_["10093"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["10093"].transform:GetChild(iter_158_0)

					if var_158_0.name == "split_2" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_158_2 = arg_155_1.actors_["10093"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10093 == nil then
				arg_155_1.var_.actorSpriteComps10093 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps10093 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								iter_158_2.color = Color.New(Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_3), Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_3), (Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_3)))
							else
								local var_158_4 = Mathf.Lerp(iter_158_2.color.r, 1, (arg_155_1.time_ - 0) / var_158_3)

								iter_158_2.color = Color.New(var_158_4, var_158_4, var_158_4)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10093 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_158_4 then
						iter_158_4.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps10093 = nil
			end

			local var_158_5 = arg_155_1.actors_["10022"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.actorSpriteComps10022 == nil then
				arg_155_1.var_.actorSpriteComps10022 = var_158_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_6 = 2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_6 and not isNil(var_158_5) then
				if arg_155_1.var_.actorSpriteComps10022 then
					for iter_158_5, iter_158_6 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_158_6 then
							if arg_155_1.isInRecall_ then
								iter_158_6.color = Color.New(Mathf.Lerp(iter_158_6.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_6), Mathf.Lerp(iter_158_6.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_6), (Mathf.Lerp(iter_158_6.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_6)))
							else
								local var_158_7 = Mathf.Lerp(iter_158_6.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_6)

								iter_158_6.color = Color.New(var_158_7, var_158_7, var_158_7)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_6 and arg_155_1.time_ < 0 + var_158_6 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.actorSpriteComps10022 then
				for iter_158_7, iter_158_8 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_158_8 then
						iter_158_8.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10022 = nil
			end

			local var_158_8 = 0
			local var_158_9 = 0.55

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_10 = arg_155_1:GetWordFromCfg(413101037)
				local var_158_11 = arg_155_1:FormatText(var_158_10.content)

				arg_155_1.text_.text = var_158_11

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_13 = 22 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 22)

				if (22 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 22)) > 0 and var_158_9 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_8
					end
				end

				arg_155_1.text_.text = var_158_11
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101037", "story_v_out_413101.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101037", "story_v_out_413101.awb") / 1000

					if var_158_14 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_8
					end

					if var_158_10.prefab_name ~= "" and arg_155_1.actors_[var_158_10.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_10.prefab_name].transform, "story_v_out_413101", "413101037", "story_v_out_413101.awb")

						arg_155_1:RecordAudio("413101037", var_158_15)
						arg_155_1:RecordAudio("413101037", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_413101", "413101037", "story_v_out_413101.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_413101", "413101037", "story_v_out_413101.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_9, arg_155_1.talkMaxDuration)

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_8) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_8 + var_158_16 and arg_155_1.time_ < var_158_8 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 413101038
		arg_159_1.duration_ = 5.3

		local var_159_0 = {
			zh = 3.4,
			ja = 5.3
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
				arg_159_0:Play413101039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10022 = arg_159_1.actors_["10022"].transform.localPosition
				arg_159_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10022", 2)

				for iter_162_0 = 0, arg_159_1.actors_["10022"].transform.childCount - 1 do
					local var_162_0 = arg_159_1.actors_["10022"].transform:GetChild(iter_162_0)

					if var_162_0.name == "split_6" or not string.find(var_162_0.name, "split") then
						var_162_0.gameObject:SetActive(true)
					else
						var_162_0.gameObject:SetActive(false)
					end
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_159_1.time_ - 0) / var_162_1)
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_162_2 = arg_159_1.actors_["10022"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps10022 == nil then
				arg_159_1.var_.actorSpriteComps10022 = var_162_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_3 = 2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.actorSpriteComps10022 then
					for iter_162_1, iter_162_2 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_162_2 then
							if arg_159_1.isInRecall_ then
								iter_162_2.color = Color.New(Mathf.Lerp(iter_162_2.color.r, arg_159_1.hightColor1.r, (arg_159_1.time_ - 0) / var_162_3), Mathf.Lerp(iter_162_2.color.g, arg_159_1.hightColor1.g, (arg_159_1.time_ - 0) / var_162_3), (Mathf.Lerp(iter_162_2.color.b, arg_159_1.hightColor1.b, (arg_159_1.time_ - 0) / var_162_3)))
							else
								local var_162_4 = Mathf.Lerp(iter_162_2.color.r, 1, (arg_159_1.time_ - 0) / var_162_3)

								iter_162_2.color = Color.New(var_162_4, var_162_4, var_162_4)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps10022 then
				for iter_162_3, iter_162_4 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_162_4 then
						iter_162_4.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps10022 = nil
			end

			local var_162_5 = arg_159_1.actors_["10093"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.actorSpriteComps10093 == nil then
				arg_159_1.var_.actorSpriteComps10093 = var_162_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_6 = 2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_6 and not isNil(var_162_5) then
				if arg_159_1.var_.actorSpriteComps10093 then
					for iter_162_5, iter_162_6 in pairs(arg_159_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_162_6 then
							if arg_159_1.isInRecall_ then
								iter_162_6.color = Color.New(Mathf.Lerp(iter_162_6.color.r, arg_159_1.hightColor2.r, (arg_159_1.time_ - 0) / var_162_6), Mathf.Lerp(iter_162_6.color.g, arg_159_1.hightColor2.g, (arg_159_1.time_ - 0) / var_162_6), (Mathf.Lerp(iter_162_6.color.b, arg_159_1.hightColor2.b, (arg_159_1.time_ - 0) / var_162_6)))
							else
								local var_162_7 = Mathf.Lerp(iter_162_6.color.r, 0.5, (arg_159_1.time_ - 0) / var_162_6)

								iter_162_6.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_6 and arg_159_1.time_ < 0 + var_162_6 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.actorSpriteComps10093 then
				for iter_162_7, iter_162_8 in pairs(arg_159_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_162_8 then
						iter_162_8.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps10093 = nil
			end

			local var_162_8 = 0
			local var_162_9 = 0.3

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(413101038)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 12 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 12)

				if (12 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 12)) > 0 and var_162_9 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101038", "story_v_out_413101.awb") ~= 0 then
					local var_162_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101038", "story_v_out_413101.awb") / 1000

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_413101", "413101038", "story_v_out_413101.awb")

						arg_159_1:RecordAudio("413101038", var_162_15)
						arg_159_1:RecordAudio("413101038", var_162_15)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413101", "413101038", "story_v_out_413101.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413101", "413101038", "story_v_out_413101.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_16 and arg_159_1.time_ < var_162_8 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play413101039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413101039
		arg_163_1.duration_ = 4.83

		local var_163_0 = {
			zh = 3.3,
			ja = 4.833
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
				arg_163_0:Play413101040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10093 = arg_163_1.actors_["10093"].transform.localPosition
				arg_163_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10093", 4)

				for iter_166_0 = 0, arg_163_1.actors_["10093"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["10093"].transform:GetChild(iter_166_0)

					if var_166_0.name == "split_6" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_166_2 = arg_163_1.actors_["10093"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10093 == nil then
				arg_163_1.var_.actorSpriteComps10093 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps10093 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								iter_166_2.color = Color.New(Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_3), Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_3), (Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_3)))
							else
								local var_166_4 = Mathf.Lerp(iter_166_2.color.r, 1, (arg_163_1.time_ - 0) / var_166_3)

								iter_166_2.color = Color.New(var_166_4, var_166_4, var_166_4)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10093 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_166_4 then
						iter_166_4.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10093 = nil
			end

			local var_166_5 = arg_163_1.actors_["10022"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.actorSpriteComps10022 == nil then
				arg_163_1.var_.actorSpriteComps10022 = var_166_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_6 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_6 and not isNil(var_166_5) then
				if arg_163_1.var_.actorSpriteComps10022 then
					for iter_166_5, iter_166_6 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_166_6 then
							if arg_163_1.isInRecall_ then
								iter_166_6.color = Color.New(Mathf.Lerp(iter_166_6.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_6), Mathf.Lerp(iter_166_6.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_6), (Mathf.Lerp(iter_166_6.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_6)))
							else
								local var_166_7 = Mathf.Lerp(iter_166_6.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_6)

								iter_166_6.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_6 and arg_163_1.time_ < 0 + var_166_6 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.actorSpriteComps10022 then
				for iter_166_7, iter_166_8 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_166_8 then
						iter_166_8.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps10022 = nil
			end

			local var_166_8 = 0
			local var_166_9 = 0.35

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(413101039)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 14 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 14)

				if (14 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 14)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101039", "story_v_out_413101.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101039", "story_v_out_413101.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_413101", "413101039", "story_v_out_413101.awb")

						arg_163_1:RecordAudio("413101039", var_166_15)
						arg_163_1:RecordAudio("413101039", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413101", "413101039", "story_v_out_413101.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413101", "413101039", "story_v_out_413101.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_16 and arg_163_1.time_ < var_166_8 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413101040
		arg_167_1.duration_ = 11.3

		local var_167_0 = {
			zh = 4.766,
			ja = 11.3
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
				arg_167_0:Play413101041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10092 = arg_167_1.actors_["10092"].transform.localPosition
				arg_167_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10092", 2)

				for iter_170_0 = 0, arg_167_1.actors_["10092"].transform.childCount - 1 do
					local var_170_0 = arg_167_1.actors_["10092"].transform:GetChild(iter_170_0)

					if var_170_0.name == "split_1_1" or not string.find(var_170_0.name, "split") then
						var_170_0.gameObject:SetActive(true)
					else
						var_170_0.gameObject:SetActive(false)
					end
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_167_1.time_ - 0) / var_170_1)
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_170_2 = arg_167_1.actors_["10092"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10092 == nil then
				arg_167_1.var_.actorSpriteComps10092 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps10092 then
					for iter_170_1, iter_170_2 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_170_2 then
							if arg_167_1.isInRecall_ then
								iter_170_2.color = Color.New(Mathf.Lerp(iter_170_2.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_3), Mathf.Lerp(iter_170_2.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_3), (Mathf.Lerp(iter_170_2.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_3)))
							else
								local var_170_4 = Mathf.Lerp(iter_170_2.color.r, 1, (arg_167_1.time_ - 0) / var_170_3)

								iter_170_2.color = Color.New(var_170_4, var_170_4, var_170_4)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10092 then
				for iter_170_3, iter_170_4 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_170_4 then
						iter_170_4.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10092 = nil
			end

			local var_170_5 = arg_167_1.actors_["10093"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.actorSpriteComps10093 == nil then
				arg_167_1.var_.actorSpriteComps10093 = var_170_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_6 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 and not isNil(var_170_5) then
				if arg_167_1.var_.actorSpriteComps10093 then
					for iter_170_5, iter_170_6 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_170_6 then
							if arg_167_1.isInRecall_ then
								iter_170_6.color = Color.New(Mathf.Lerp(iter_170_6.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_6), Mathf.Lerp(iter_170_6.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_6), (Mathf.Lerp(iter_170_6.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_6)))
							else
								local var_170_7 = Mathf.Lerp(iter_170_6.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_6)

								iter_170_6.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.actorSpriteComps10093 then
				for iter_170_7, iter_170_8 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_170_8 then
						iter_170_8.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10093 = nil
			end

			local var_170_8 = 0
			local var_170_9 = 0.675

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(413101040)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 27 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 27)

				if (27 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 27)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101040", "story_v_out_413101.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101040", "story_v_out_413101.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_413101", "413101040", "story_v_out_413101.awb")

						arg_167_1:RecordAudio("413101040", var_170_15)
						arg_167_1:RecordAudio("413101040", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413101", "413101040", "story_v_out_413101.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413101", "413101040", "story_v_out_413101.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_16 and arg_167_1.time_ < var_170_8 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413101041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413101041
		arg_171_1.duration_ = 6.93

		local var_171_0 = {
			zh = 2.533,
			ja = 6.933
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
				arg_171_0:Play413101042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10092 = arg_171_1.actors_["10092"].transform.localPosition
				arg_171_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10092", 2)

				for iter_174_0 = 0, arg_171_1.actors_["10092"].transform.childCount - 1 do
					local var_174_0 = arg_171_1.actors_["10092"].transform:GetChild(iter_174_0)

					if var_174_0.name == "split_2" or not string.find(var_174_0.name, "split") then
						var_174_0.gameObject:SetActive(true)
					else
						var_174_0.gameObject:SetActive(false)
					end
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_171_1.time_ - 0) / var_174_1)
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_174_2 = 0
			local var_174_3 = 0.325

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_4 = arg_171_1:GetWordFromCfg(413101041)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 13 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 13)

				if (13 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 13)) > 0 and var_174_3 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_2
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101041", "story_v_out_413101.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101041", "story_v_out_413101.awb") / 1000

					if var_174_8 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_2
					end

					if var_174_4.prefab_name ~= "" and arg_171_1.actors_[var_174_4.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_4.prefab_name].transform, "story_v_out_413101", "413101041", "story_v_out_413101.awb")

						arg_171_1:RecordAudio("413101041", var_174_9)
						arg_171_1:RecordAudio("413101041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413101", "413101041", "story_v_out_413101.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413101", "413101041", "story_v_out_413101.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_3, arg_171_1.talkMaxDuration)

			if var_174_2 <= arg_171_1.time_ and arg_171_1.time_ < var_174_2 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_2) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_2 + var_174_10 and arg_171_1.time_ < var_174_2 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play413101042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413101042
		arg_175_1.duration_ = 7.1

		local var_175_0 = {
			zh = 3.466,
			ja = 7.1
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
				arg_175_0:Play413101043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10093 = arg_175_1.actors_["10093"].transform.localPosition
				arg_175_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10093", 4)

				for iter_178_0 = 0, arg_175_1.actors_["10093"].transform.childCount - 1 do
					local var_178_0 = arg_175_1.actors_["10093"].transform:GetChild(iter_178_0)

					if var_178_0.name == "split_4" or not string.find(var_178_0.name, "split") then
						var_178_0.gameObject:SetActive(true)
					else
						var_178_0.gameObject:SetActive(false)
					end
				end
			end

			local var_178_1 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_1 then
				arg_175_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_175_1.time_ - 0) / var_178_1)
			end

			if arg_175_1.time_ >= 0 + var_178_1 and arg_175_1.time_ < 0 + var_178_1 + arg_178_0 then
				arg_175_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_178_2 = arg_175_1.actors_["10092"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10092 == nil then
				arg_175_1.var_.actorSpriteComps10092 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps10092 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_178_2 then
							if arg_175_1.isInRecall_ then
								iter_178_2.color = Color.New(Mathf.Lerp(iter_178_2.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_2.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_2.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_2.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_2.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10092 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_178_4 then
						iter_178_4.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps10092 = nil
			end

			local var_178_5 = arg_175_1.actors_["10093"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.actorSpriteComps10093 == nil then
				arg_175_1.var_.actorSpriteComps10093 = var_178_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_6 = 2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 and not isNil(var_178_5) then
				if arg_175_1.var_.actorSpriteComps10093 then
					for iter_178_5, iter_178_6 in pairs(arg_175_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_178_6 then
							if arg_175_1.isInRecall_ then
								iter_178_6.color = Color.New(Mathf.Lerp(iter_178_6.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0) / var_178_6), Mathf.Lerp(iter_178_6.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0) / var_178_6), (Mathf.Lerp(iter_178_6.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0) / var_178_6)))
							else
								local var_178_7 = Mathf.Lerp(iter_178_6.color.r, 1, (arg_175_1.time_ - 0) / var_178_6)

								iter_178_6.color = Color.New(var_178_7, var_178_7, var_178_7)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.actorSpriteComps10093 then
				for iter_178_7, iter_178_8 in pairs(arg_175_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_178_8 then
						iter_178_8.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps10093 = nil
			end

			local var_178_8 = 0
			local var_178_9 = 0.5

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(413101042)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 20 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 20)

				if (20 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 20)) > 0 and var_178_9 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101042", "story_v_out_413101.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101042", "story_v_out_413101.awb") / 1000

					if var_178_14 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_8
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_413101", "413101042", "story_v_out_413101.awb")

						arg_175_1:RecordAudio("413101042", var_178_15)
						arg_175_1:RecordAudio("413101042", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_413101", "413101042", "story_v_out_413101.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_413101", "413101042", "story_v_out_413101.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_16 and arg_175_1.time_ < var_178_8 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play413101043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 413101043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play413101044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10092 = arg_179_1.actors_["10092"].transform.localPosition
				arg_179_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10092", 6)

				for iter_182_0 = 0, arg_179_1.actors_["10092"].transform.childCount - 1 do
					local var_182_0 = arg_179_1.actors_["10092"].transform:GetChild(iter_182_0)

					if var_182_0.name == "" or not string.find(var_182_0.name, "split") then
						var_182_0.gameObject:SetActive(true)
					else
						var_182_0.gameObject:SetActive(false)
					end
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10092, Vector3.New(1500, -300, -295), (arg_179_1.time_ - 0) / var_182_1)
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["10092"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_182_2 = arg_179_1.actors_["10093"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10093 = var_182_2.localPosition
				var_182_2.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10093", 6)

				for iter_182_1 = 0, var_182_2.childCount - 1 do
					local var_182_3 = var_182_2:GetChild(iter_182_1)

					if var_182_3.name == "" or not string.find(var_182_3.name, "split") then
						var_182_3.gameObject:SetActive(true)
					else
						var_182_3.gameObject:SetActive(false)
					end
				end
			end

			local var_182_4 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				var_182_2.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_179_1.time_ - 0) / var_182_4)
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				var_182_2.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_182_5 = arg_179_1.actors_["10092"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.actorSpriteComps10092 == nil then
				arg_179_1.var_.actorSpriteComps10092 = var_182_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_6 = 2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_6 and not isNil(var_182_5) then
				if arg_179_1.var_.actorSpriteComps10092 then
					for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_182_3 then
							if arg_179_1.isInRecall_ then
								iter_182_3.color = Color.New(Mathf.Lerp(iter_182_3.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_6), Mathf.Lerp(iter_182_3.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_6), (Mathf.Lerp(iter_182_3.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_6)))
							else
								local var_182_7 = Mathf.Lerp(iter_182_3.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_6)

								iter_182_3.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_6 and arg_179_1.time_ < 0 + var_182_6 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.actorSpriteComps10092 then
				for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_182_5 then
						iter_182_5.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10092 = nil
			end

			local var_182_8 = arg_179_1.actors_["10093"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps10093 == nil then
				arg_179_1.var_.actorSpriteComps10093 = var_182_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_9 = 2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_9 and not isNil(var_182_8) then
				if arg_179_1.var_.actorSpriteComps10093 then
					for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_182_7 then
							if arg_179_1.isInRecall_ then
								iter_182_7.color = Color.New(Mathf.Lerp(iter_182_7.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_9), Mathf.Lerp(iter_182_7.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_9), (Mathf.Lerp(iter_182_7.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_9)))
							else
								local var_182_10 = Mathf.Lerp(iter_182_7.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_9)

								iter_182_7.color = Color.New(var_182_10, var_182_10, var_182_10)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_9 and arg_179_1.time_ < 0 + var_182_9 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps10093 then
				for iter_182_8, iter_182_9 in pairs(arg_179_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_182_9 then
						iter_182_9.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10093 = nil
			end

			local var_182_11 = 0
			local var_182_12 = 1.1

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_13 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(413101043).content)

				arg_179_1.text_.text = var_182_13

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_15 = 44 <= 0 and var_182_12 or var_182_12 * (utf8.len(var_182_13) / 44)

				if (44 <= 0 and var_182_12 or var_182_12 * (utf8.len(var_182_13) / 44)) > 0 and var_182_12 < var_182_15 then
					arg_179_1.talkMaxDuration = var_182_15

					if var_182_15 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_15 + var_182_11
					end
				end

				arg_179_1.text_.text = var_182_13
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_12, arg_179_1.talkMaxDuration)

			if var_182_11 <= arg_179_1.time_ and arg_179_1.time_ < var_182_11 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_11) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_11 + var_182_16 and arg_179_1.time_ < var_182_11 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play413101044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 413101044
		arg_183_1.duration_ = 6.33

		local var_183_0 = {
			zh = 3.733,
			ja = 6.333
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play413101045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10092 = arg_183_1.actors_["10092"].transform.localPosition
				arg_183_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10092", 3)

				for iter_186_0 = 0, arg_183_1.actors_["10092"].transform.childCount - 1 do
					local var_186_0 = arg_183_1.actors_["10092"].transform:GetChild(iter_186_0)

					if var_186_0.name == "" or not string.find(var_186_0.name, "split") then
						var_186_0.gameObject:SetActive(true)
					else
						var_186_0.gameObject:SetActive(false)
					end
				end
			end

			local var_186_1 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 then
				arg_183_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_183_1.time_ - 0) / var_186_1)
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 then
				arg_183_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_186_2 = arg_183_1.actors_["10093"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10093 = var_186_2.localPosition
				var_186_2.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10093", 7)

				for iter_186_1 = 0, var_186_2.childCount - 1 do
					local var_186_3 = var_186_2:GetChild(iter_186_1)

					if var_186_3.name == "" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_2.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_183_1.time_ - 0) / var_186_4)
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_5 = arg_183_1.actors_["10092"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.actorSpriteComps10092 == nil then
				arg_183_1.var_.actorSpriteComps10092 = var_186_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_6 = 2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_6 and not isNil(var_186_5) then
				if arg_183_1.var_.actorSpriteComps10092 then
					for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_186_3 then
							if arg_183_1.isInRecall_ then
								iter_186_3.color = Color.New(Mathf.Lerp(iter_186_3.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_6), Mathf.Lerp(iter_186_3.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_6), (Mathf.Lerp(iter_186_3.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_6)))
							else
								local var_186_7 = Mathf.Lerp(iter_186_3.color.r, 1, (arg_183_1.time_ - 0) / var_186_6)

								iter_186_3.color = Color.New(var_186_7, var_186_7, var_186_7)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_6 and arg_183_1.time_ < 0 + var_186_6 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.actorSpriteComps10092 then
				for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_186_5 then
						iter_186_5.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps10092 = nil
			end

			local var_186_8 = arg_183_1.actors_["10093"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_8) and arg_183_1.var_.actorSpriteComps10093 == nil then
				arg_183_1.var_.actorSpriteComps10093 = var_186_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_9 = 2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_9 and not isNil(var_186_8) then
				if arg_183_1.var_.actorSpriteComps10093 then
					for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_186_7 then
							if arg_183_1.isInRecall_ then
								iter_186_7.color = Color.New(Mathf.Lerp(iter_186_7.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_9), Mathf.Lerp(iter_186_7.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_9), (Mathf.Lerp(iter_186_7.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_9)))
							else
								local var_186_10 = Mathf.Lerp(iter_186_7.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_9)

								iter_186_7.color = Color.New(var_186_10, var_186_10, var_186_10)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_9 and arg_183_1.time_ < 0 + var_186_9 + arg_186_0 and not isNil(var_186_8) and arg_183_1.var_.actorSpriteComps10093 then
				for iter_186_8, iter_186_9 in pairs(arg_183_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_186_9 then
						iter_186_9.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps10093 = nil
			end

			local var_186_11 = 0
			local var_186_12 = 0.475

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_11 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_13 = arg_183_1:GetWordFromCfg(413101044)
				local var_186_14 = arg_183_1:FormatText(var_186_13.content)

				arg_183_1.text_.text = var_186_14

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_16 = 19 <= 0 and var_186_12 or var_186_12 * (utf8.len(var_186_14) / 19)

				if (19 <= 0 and var_186_12 or var_186_12 * (utf8.len(var_186_14) / 19)) > 0 and var_186_12 < var_186_16 then
					arg_183_1.talkMaxDuration = var_186_16

					if var_186_16 + var_186_11 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_16 + var_186_11
					end
				end

				arg_183_1.text_.text = var_186_14
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101044", "story_v_out_413101.awb") ~= 0 then
					local var_186_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101044", "story_v_out_413101.awb") / 1000

					if var_186_17 + var_186_11 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_17 + var_186_11
					end

					if var_186_13.prefab_name ~= "" and arg_183_1.actors_[var_186_13.prefab_name] ~= nil then
						local var_186_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_13.prefab_name].transform, "story_v_out_413101", "413101044", "story_v_out_413101.awb")

						arg_183_1:RecordAudio("413101044", var_186_18)
						arg_183_1:RecordAudio("413101044", var_186_18)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_413101", "413101044", "story_v_out_413101.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_413101", "413101044", "story_v_out_413101.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_19 = math.max(var_186_12, arg_183_1.talkMaxDuration)

			if var_186_11 <= arg_183_1.time_ and arg_183_1.time_ < var_186_11 + var_186_19 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_11) / var_186_19

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_11 + var_186_19 and arg_183_1.time_ < var_186_11 + var_186_19 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play413101045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 413101045
		arg_187_1.duration_ = 7.23

		local var_187_0 = {
			zh = 7.133,
			ja = 7.233
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play413101046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.075

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(413101045)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 43 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 43)

				if (43 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 43)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101045", "story_v_out_413101.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101045", "story_v_out_413101.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_413101", "413101045", "story_v_out_413101.awb")

						arg_187_1:RecordAudio("413101045", var_190_6)
						arg_187_1:RecordAudio("413101045", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_413101", "413101045", "story_v_out_413101.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_413101", "413101045", "story_v_out_413101.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play413101046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 413101046
		arg_191_1.duration_ = 5.53

		local var_191_0 = {
			zh = 3.033,
			ja = 5.533
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play413101047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10092 = arg_191_1.actors_["10092"].transform.localPosition
				arg_191_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10092", 3)

				for iter_194_0 = 0, arg_191_1.actors_["10092"].transform.childCount - 1 do
					local var_194_0 = arg_191_1.actors_["10092"].transform:GetChild(iter_194_0)

					if var_194_0.name == "split_2" or not string.find(var_194_0.name, "split") then
						var_194_0.gameObject:SetActive(true)
					else
						var_194_0.gameObject:SetActive(false)
					end
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_191_1.time_ - 0) / var_194_1)
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_194_2 = arg_191_1.actors_["10092"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10092 == nil then
				arg_191_1.var_.actorSpriteComps10092 = var_194_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_3 = 2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.actorSpriteComps10092 then
					for iter_194_1, iter_194_2 in pairs(arg_191_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_194_2 then
							if arg_191_1.isInRecall_ then
								iter_194_2.color = Color.New(Mathf.Lerp(iter_194_2.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_3), Mathf.Lerp(iter_194_2.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_3), (Mathf.Lerp(iter_194_2.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_3)))
							else
								local var_194_4 = Mathf.Lerp(iter_194_2.color.r, 1, (arg_191_1.time_ - 0) / var_194_3)

								iter_194_2.color = Color.New(var_194_4, var_194_4, var_194_4)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10092 then
				for iter_194_3, iter_194_4 in pairs(arg_191_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_194_4 then
						iter_194_4.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps10092 = nil
			end

			local var_194_5 = 0
			local var_194_6 = 0.375

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_7 = arg_191_1:GetWordFromCfg(413101046)
				local var_194_8 = arg_191_1:FormatText(var_194_7.content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 15 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 15)

				if (15 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 15)) > 0 and var_194_6 < var_194_10 then
					arg_191_1.talkMaxDuration = var_194_10

					if var_194_10 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101046", "story_v_out_413101.awb") ~= 0 then
					local var_194_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101046", "story_v_out_413101.awb") / 1000

					if var_194_11 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_5
					end

					if var_194_7.prefab_name ~= "" and arg_191_1.actors_[var_194_7.prefab_name] ~= nil then
						local var_194_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_7.prefab_name].transform, "story_v_out_413101", "413101046", "story_v_out_413101.awb")

						arg_191_1:RecordAudio("413101046", var_194_12)
						arg_191_1:RecordAudio("413101046", var_194_12)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_413101", "413101046", "story_v_out_413101.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_413101", "413101046", "story_v_out_413101.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_13 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_13 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_13

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_13 and arg_191_1.time_ < var_194_5 + var_194_13 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play413101047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 413101047
		arg_195_1.duration_ = 5.17

		local var_195_0 = {
			zh = 5.166,
			ja = 4.3
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play413101048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10093 = arg_195_1.actors_["10093"].transform.localPosition
				arg_195_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10093", 4)

				for iter_198_0 = 0, arg_195_1.actors_["10093"].transform.childCount - 1 do
					local var_198_0 = arg_195_1.actors_["10093"].transform:GetChild(iter_198_0)

					if var_198_0.name == "split_4" or not string.find(var_198_0.name, "split") then
						var_198_0.gameObject:SetActive(true)
					else
						var_198_0.gameObject:SetActive(false)
					end
				end
			end

			local var_198_1 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_1 then
				arg_195_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_195_1.time_ - 0) / var_198_1)
			end

			if arg_195_1.time_ >= 0 + var_198_1 and arg_195_1.time_ < 0 + var_198_1 + arg_198_0 then
				arg_195_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_198_2 = arg_195_1.actors_["10092"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps10092 == nil then
				arg_195_1.var_.actorSpriteComps10092 = var_198_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_3 = 2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.actorSpriteComps10092 then
					for iter_198_1, iter_198_2 in pairs(arg_195_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_198_2 then
							if arg_195_1.isInRecall_ then
								iter_198_2.color = Color.New(Mathf.Lerp(iter_198_2.color.r, arg_195_1.hightColor2.r, (arg_195_1.time_ - 0) / var_198_3), Mathf.Lerp(iter_198_2.color.g, arg_195_1.hightColor2.g, (arg_195_1.time_ - 0) / var_198_3), (Mathf.Lerp(iter_198_2.color.b, arg_195_1.hightColor2.b, (arg_195_1.time_ - 0) / var_198_3)))
							else
								local var_198_4 = Mathf.Lerp(iter_198_2.color.r, 0.5, (arg_195_1.time_ - 0) / var_198_3)

								iter_198_2.color = Color.New(var_198_4, var_198_4, var_198_4)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps10092 then
				for iter_198_3, iter_198_4 in pairs(arg_195_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_198_4 then
						iter_198_4.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps10092 = nil
			end

			local var_198_5 = arg_195_1.actors_["10093"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.actorSpriteComps10093 == nil then
				arg_195_1.var_.actorSpriteComps10093 = var_198_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_6 = 2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_6 and not isNil(var_198_5) then
				if arg_195_1.var_.actorSpriteComps10093 then
					for iter_198_5, iter_198_6 in pairs(arg_195_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_198_6 then
							if arg_195_1.isInRecall_ then
								iter_198_6.color = Color.New(Mathf.Lerp(iter_198_6.color.r, arg_195_1.hightColor1.r, (arg_195_1.time_ - 0) / var_198_6), Mathf.Lerp(iter_198_6.color.g, arg_195_1.hightColor1.g, (arg_195_1.time_ - 0) / var_198_6), (Mathf.Lerp(iter_198_6.color.b, arg_195_1.hightColor1.b, (arg_195_1.time_ - 0) / var_198_6)))
							else
								local var_198_7 = Mathf.Lerp(iter_198_6.color.r, 1, (arg_195_1.time_ - 0) / var_198_6)

								iter_198_6.color = Color.New(var_198_7, var_198_7, var_198_7)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_6 and arg_195_1.time_ < 0 + var_198_6 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.actorSpriteComps10093 then
				for iter_198_7, iter_198_8 in pairs(arg_195_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_198_8 then
						iter_198_8.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps10093 = nil
			end

			local var_198_8 = arg_195_1.actors_["10092"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10092 = var_198_8.localPosition
				var_198_8.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10092", 2)

				for iter_198_9 = 0, var_198_8.childCount - 1 do
					local var_198_9 = var_198_8:GetChild(iter_198_9)

					if var_198_9.name == "split_2" or not string.find(var_198_9.name, "split") then
						var_198_9.gameObject:SetActive(true)
					else
						var_198_9.gameObject:SetActive(false)
					end
				end
			end

			local var_198_10 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_10 then
				var_198_8.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_195_1.time_ - 0) / var_198_10)
			end

			if arg_195_1.time_ >= 0 + var_198_10 and arg_195_1.time_ < 0 + var_198_10 + arg_198_0 then
				var_198_8.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_198_11 = 0
			local var_198_12 = 0.475

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_11 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_13 = arg_195_1:GetWordFromCfg(413101047)
				local var_198_14 = arg_195_1:FormatText(var_198_13.content)

				arg_195_1.text_.text = var_198_14

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_16 = 19 <= 0 and var_198_12 or var_198_12 * (utf8.len(var_198_14) / 19)

				if (19 <= 0 and var_198_12 or var_198_12 * (utf8.len(var_198_14) / 19)) > 0 and var_198_12 < var_198_16 then
					arg_195_1.talkMaxDuration = var_198_16

					if var_198_16 + var_198_11 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_16 + var_198_11
					end
				end

				arg_195_1.text_.text = var_198_14
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101047", "story_v_out_413101.awb") ~= 0 then
					local var_198_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101047", "story_v_out_413101.awb") / 1000

					if var_198_17 + var_198_11 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_17 + var_198_11
					end

					if var_198_13.prefab_name ~= "" and arg_195_1.actors_[var_198_13.prefab_name] ~= nil then
						local var_198_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_13.prefab_name].transform, "story_v_out_413101", "413101047", "story_v_out_413101.awb")

						arg_195_1:RecordAudio("413101047", var_198_18)
						arg_195_1:RecordAudio("413101047", var_198_18)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_413101", "413101047", "story_v_out_413101.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_413101", "413101047", "story_v_out_413101.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_19 = math.max(var_198_12, arg_195_1.talkMaxDuration)

			if var_198_11 <= arg_195_1.time_ and arg_195_1.time_ < var_198_11 + var_198_19 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_11) / var_198_19

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_11 + var_198_19 and arg_195_1.time_ < var_198_11 + var_198_19 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play413101048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 413101048
		arg_199_1.duration_ = 5.73

		local var_199_0 = {
			zh = 4.96633333333333,
			ja = 5.73333333333333
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play413101049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10022 = arg_199_1.actors_["10022"].transform.localPosition
				arg_199_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10022", 2)

				for iter_202_0 = 0, arg_199_1.actors_["10022"].transform.childCount - 1 do
					local var_202_0 = arg_199_1.actors_["10022"].transform:GetChild(iter_202_0)

					if var_202_0.name == "split_8" or not string.find(var_202_0.name, "split") then
						var_202_0.gameObject:SetActive(true)
					else
						var_202_0.gameObject:SetActive(false)
					end
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_199_1.time_ - 0) / var_202_1)
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_202_2 = arg_199_1.actors_["10022"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10022 == nil then
				arg_199_1.var_.actorSpriteComps10022 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps10022 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_202_2 then
							if arg_199_1.isInRecall_ then
								iter_202_2.color = Color.New(Mathf.Lerp(iter_202_2.color.r, arg_199_1.hightColor1.r, (arg_199_1.time_ - 0) / var_202_3), Mathf.Lerp(iter_202_2.color.g, arg_199_1.hightColor1.g, (arg_199_1.time_ - 0) / var_202_3), (Mathf.Lerp(iter_202_2.color.b, arg_199_1.hightColor1.b, (arg_199_1.time_ - 0) / var_202_3)))
							else
								local var_202_4 = Mathf.Lerp(iter_202_2.color.r, 1, (arg_199_1.time_ - 0) / var_202_3)

								iter_202_2.color = Color.New(var_202_4, var_202_4, var_202_4)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10022 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_202_4 then
						iter_202_4.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps10022 = nil
			end

			local var_202_5 = arg_199_1.actors_["10093"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.actorSpriteComps10093 == nil then
				arg_199_1.var_.actorSpriteComps10093 = var_202_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_6 = 2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_6 and not isNil(var_202_5) then
				if arg_199_1.var_.actorSpriteComps10093 then
					for iter_202_5, iter_202_6 in pairs(arg_199_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_202_6 then
							if arg_199_1.isInRecall_ then
								iter_202_6.color = Color.New(Mathf.Lerp(iter_202_6.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_6), Mathf.Lerp(iter_202_6.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_6), (Mathf.Lerp(iter_202_6.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_6)))
							else
								local var_202_7 = Mathf.Lerp(iter_202_6.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_6)

								iter_202_6.color = Color.New(var_202_7, var_202_7, var_202_7)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_6 and arg_199_1.time_ < 0 + var_202_6 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.actorSpriteComps10093 then
				for iter_202_7, iter_202_8 in pairs(arg_199_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_202_8 then
						iter_202_8.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				local var_202_8 = arg_199_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_202_8 then
					arg_199_1.var_.alphaOldValue10022 = var_202_8.alpha
					arg_199_1.var_.characterEffect10022 = var_202_8
				end

				arg_199_1.var_.alphaOldValue10022 = 0
			end

			local var_202_9 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_9 then
				if arg_199_1.var_.characterEffect10022 then
					arg_199_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_199_1.var_.alphaOldValue10022, 1, (arg_199_1.time_ - 0) / var_202_9)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_9 and arg_199_1.time_ < 0 + var_202_9 + arg_202_0 and arg_199_1.var_.characterEffect10022 then
				arg_199_1.var_.characterEffect10022.alpha = 1
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_10 = 0.433333333333333
			local var_202_11 = 0.725

			if 0.433333333333333 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_12 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_12:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_13 = arg_199_1:GetWordFromCfg(413101048)
				local var_202_14 = arg_199_1:FormatText(var_202_13.content)

				arg_199_1.text_.text = var_202_14

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_16 = 27 <= 0 and var_202_11 or var_202_11 * (utf8.len(var_202_14) / 27)

				if (27 <= 0 and var_202_11 or var_202_11 * (utf8.len(var_202_14) / 27)) > 0 and var_202_11 < var_202_16 then
					arg_199_1.talkMaxDuration = var_202_16
					var_202_10 = var_202_10 + 0.3

					if var_202_16 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_16 + var_202_10
					end
				end

				arg_199_1.text_.text = var_202_14
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101048", "story_v_out_413101.awb") ~= 0 then
					local var_202_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101048", "story_v_out_413101.awb") / 1000

					if var_202_17 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_17 + var_202_10
					end

					if var_202_13.prefab_name ~= "" and arg_199_1.actors_[var_202_13.prefab_name] ~= nil then
						local var_202_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_13.prefab_name].transform, "story_v_out_413101", "413101048", "story_v_out_413101.awb")

						arg_199_1:RecordAudio("413101048", var_202_18)
						arg_199_1:RecordAudio("413101048", var_202_18)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_413101", "413101048", "story_v_out_413101.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_413101", "413101048", "story_v_out_413101.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_19 = var_202_10 + 0.3
			local var_202_20 = math.max(var_202_11, arg_199_1.talkMaxDuration)

			if var_202_10 + 0.3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_19 + var_202_20 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_19) / var_202_20

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_19 + var_202_20 and arg_199_1.time_ < var_202_19 + var_202_20 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play413101049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413101049
		arg_205_1.duration_ = 6.6

		local var_205_0 = {
			zh = 5.9,
			ja = 6.6
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
				arg_205_0:Play413101050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.725

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(413101049)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 29 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 29)

				if (29 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 29)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101049", "story_v_out_413101.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101049", "story_v_out_413101.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_413101", "413101049", "story_v_out_413101.awb")

						arg_205_1:RecordAudio("413101049", var_208_6)
						arg_205_1:RecordAudio("413101049", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_413101", "413101049", "story_v_out_413101.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_413101", "413101049", "story_v_out_413101.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play413101050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413101050
		arg_209_1.duration_ = 4.7

		local var_209_0 = {
			zh = 4.7,
			ja = 2.466
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
				arg_209_0:Play413101051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10022 = arg_209_1.actors_["10022"].transform.localPosition
				arg_209_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10022", 2)

				for iter_212_0 = 0, arg_209_1.actors_["10022"].transform.childCount - 1 do
					local var_212_0 = arg_209_1.actors_["10022"].transform:GetChild(iter_212_0)

					if var_212_0.name == "" or not string.find(var_212_0.name, "split") then
						var_212_0.gameObject:SetActive(true)
					else
						var_212_0.gameObject:SetActive(false)
					end
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_209_1.time_ - 0) / var_212_1)
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_212_2 = arg_209_1.actors_["10093"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10093 = var_212_2.localPosition
				var_212_2.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10093", 4)

				for iter_212_1 = 0, var_212_2.childCount - 1 do
					local var_212_3 = var_212_2:GetChild(iter_212_1)

					if var_212_3.name == "split_5" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_2.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_209_1.time_ - 0) / var_212_4)
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_212_5 = arg_209_1.actors_["10022"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10022 == nil then
				arg_209_1.var_.actorSpriteComps10022 = var_212_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_6 = 2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.actorSpriteComps10022 then
					for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_212_3 then
							if arg_209_1.isInRecall_ then
								iter_212_3.color = Color.New(Mathf.Lerp(iter_212_3.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_6), Mathf.Lerp(iter_212_3.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_6), (Mathf.Lerp(iter_212_3.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_6)))
							else
								local var_212_7 = Mathf.Lerp(iter_212_3.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_6)

								iter_212_3.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10022 then
				for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_212_5 then
						iter_212_5.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10022 = nil
			end

			local var_212_8 = arg_209_1.actors_["10093"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps10093 == nil then
				arg_209_1.var_.actorSpriteComps10093 = var_212_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_9 = 2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_9 and not isNil(var_212_8) then
				if arg_209_1.var_.actorSpriteComps10093 then
					for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_212_7 then
							if arg_209_1.isInRecall_ then
								iter_212_7.color = Color.New(Mathf.Lerp(iter_212_7.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_9), Mathf.Lerp(iter_212_7.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_9), (Mathf.Lerp(iter_212_7.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_9)))
							else
								local var_212_10 = Mathf.Lerp(iter_212_7.color.r, 1, (arg_209_1.time_ - 0) / var_212_9)

								iter_212_7.color = Color.New(var_212_10, var_212_10, var_212_10)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_9 and arg_209_1.time_ < 0 + var_212_9 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps10093 then
				for iter_212_8, iter_212_9 in pairs(arg_209_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_212_9 then
						iter_212_9.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps10093 = nil
			end

			local var_212_11 = 0
			local var_212_12 = 0.325

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_11 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_13 = arg_209_1:GetWordFromCfg(413101050)
				local var_212_14 = arg_209_1:FormatText(var_212_13.content)

				arg_209_1.text_.text = var_212_14

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_16 = 12 <= 0 and var_212_12 or var_212_12 * (utf8.len(var_212_14) / 12)

				if (12 <= 0 and var_212_12 or var_212_12 * (utf8.len(var_212_14) / 12)) > 0 and var_212_12 < var_212_16 then
					arg_209_1.talkMaxDuration = var_212_16

					if var_212_16 + var_212_11 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_16 + var_212_11
					end
				end

				arg_209_1.text_.text = var_212_14
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101050", "story_v_out_413101.awb") ~= 0 then
					local var_212_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101050", "story_v_out_413101.awb") / 1000

					if var_212_17 + var_212_11 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_17 + var_212_11
					end

					if var_212_13.prefab_name ~= "" and arg_209_1.actors_[var_212_13.prefab_name] ~= nil then
						local var_212_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_13.prefab_name].transform, "story_v_out_413101", "413101050", "story_v_out_413101.awb")

						arg_209_1:RecordAudio("413101050", var_212_18)
						arg_209_1:RecordAudio("413101050", var_212_18)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_413101", "413101050", "story_v_out_413101.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_413101", "413101050", "story_v_out_413101.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_19 = math.max(var_212_12, arg_209_1.talkMaxDuration)

			if var_212_11 <= arg_209_1.time_ and arg_209_1.time_ < var_212_11 + var_212_19 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_11) / var_212_19

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_11 + var_212_19 and arg_209_1.time_ < var_212_11 + var_212_19 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413101051
		arg_213_1.duration_ = 7.6

		local var_213_0 = {
			zh = 7.6,
			ja = 4.566
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
				arg_213_0:Play413101052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10022"]) and arg_213_1.var_.actorSpriteComps10022 == nil then
				arg_213_1.var_.actorSpriteComps10022 = arg_213_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10022"]) then
				if arg_213_1.var_.actorSpriteComps10022 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								iter_216_1.color = Color.New(Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_0), Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_0), (Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_0)))
							else
								local var_216_1 = Mathf.Lerp(iter_216_1.color.r, 1, (arg_213_1.time_ - 0) / var_216_0)

								iter_216_1.color = Color.New(var_216_1, var_216_1, var_216_1)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10022"]) and arg_213_1.var_.actorSpriteComps10022 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps10022 = nil
			end

			local var_216_2 = arg_213_1.actors_["10093"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10093 == nil then
				arg_213_1.var_.actorSpriteComps10093 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps10093 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								iter_216_5.color = Color.New(Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_5.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_5.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10093 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_216_7 then
						iter_216_7.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps10093 = nil
			end

			local var_216_5 = 0
			local var_216_6 = 1.025

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:GetWordFromCfg(413101051)
				local var_216_8 = arg_213_1:FormatText(var_216_7.content)

				arg_213_1.text_.text = var_216_8

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_10 = 41 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 41)

				if (41 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 41)) > 0 and var_216_6 < var_216_10 then
					arg_213_1.talkMaxDuration = var_216_10

					if var_216_10 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_8
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101051", "story_v_out_413101.awb") ~= 0 then
					local var_216_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101051", "story_v_out_413101.awb") / 1000

					if var_216_11 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_5
					end

					if var_216_7.prefab_name ~= "" and arg_213_1.actors_[var_216_7.prefab_name] ~= nil then
						local var_216_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_7.prefab_name].transform, "story_v_out_413101", "413101051", "story_v_out_413101.awb")

						arg_213_1:RecordAudio("413101051", var_216_12)
						arg_213_1:RecordAudio("413101051", var_216_12)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413101", "413101051", "story_v_out_413101.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413101", "413101051", "story_v_out_413101.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_13 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_13 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_5) / var_216_13

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_5 + var_216_13 and arg_213_1.time_ < var_216_5 + var_216_13 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play413101052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413101052
		arg_217_1.duration_ = 12.3

		local var_217_0 = {
			zh = 12.3,
			ja = 3.3
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
				arg_217_0:Play413101053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["10022"]) and arg_217_1.var_.actorSpriteComps10022 == nil then
				arg_217_1.var_.actorSpriteComps10022 = arg_217_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_0 = 2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["10022"]) then
				if arg_217_1.var_.actorSpriteComps10022 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								iter_220_1.color = Color.New(Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor1.r, (arg_217_1.time_ - 0) / var_220_0), Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor1.g, (arg_217_1.time_ - 0) / var_220_0), (Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor1.b, (arg_217_1.time_ - 0) / var_220_0)))
							else
								local var_220_1 = Mathf.Lerp(iter_220_1.color.r, 1, (arg_217_1.time_ - 0) / var_220_0)

								iter_220_1.color = Color.New(var_220_1, var_220_1, var_220_1)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["10022"]) and arg_217_1.var_.actorSpriteComps10022 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_217_1.var_.actorSpriteComps10022 = nil
			end

			local var_220_2 = arg_217_1.actors_["10093"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps10093 == nil then
				arg_217_1.var_.actorSpriteComps10093 = var_220_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_3 = 2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.actorSpriteComps10093 then
					for iter_220_4, iter_220_5 in pairs(arg_217_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_220_5 then
							if arg_217_1.isInRecall_ then
								iter_220_5.color = Color.New(Mathf.Lerp(iter_220_5.color.r, arg_217_1.hightColor2.r, (arg_217_1.time_ - 0) / var_220_3), Mathf.Lerp(iter_220_5.color.g, arg_217_1.hightColor2.g, (arg_217_1.time_ - 0) / var_220_3), (Mathf.Lerp(iter_220_5.color.b, arg_217_1.hightColor2.b, (arg_217_1.time_ - 0) / var_220_3)))
							else
								local var_220_4 = Mathf.Lerp(iter_220_5.color.r, 0.5, (arg_217_1.time_ - 0) / var_220_3)

								iter_220_5.color = Color.New(var_220_4, var_220_4, var_220_4)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps10093 then
				for iter_220_6, iter_220_7 in pairs(arg_217_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_220_7 then
						iter_220_7.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_217_1.var_.actorSpriteComps10093 = nil
			end

			local var_220_5 = 0
			local var_220_6 = 1.625

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:GetWordFromCfg(413101052)
				local var_220_8 = arg_217_1:FormatText(var_220_7.content)

				arg_217_1.text_.text = var_220_8

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_10 = 65 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 65)

				if (65 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 65)) > 0 and var_220_6 < var_220_10 then
					arg_217_1.talkMaxDuration = var_220_10

					if var_220_10 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_5
					end
				end

				arg_217_1.text_.text = var_220_8
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101052", "story_v_out_413101.awb") ~= 0 then
					local var_220_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101052", "story_v_out_413101.awb") / 1000

					if var_220_11 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_5
					end

					if var_220_7.prefab_name ~= "" and arg_217_1.actors_[var_220_7.prefab_name] ~= nil then
						local var_220_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_7.prefab_name].transform, "story_v_out_413101", "413101052", "story_v_out_413101.awb")

						arg_217_1:RecordAudio("413101052", var_220_12)
						arg_217_1:RecordAudio("413101052", var_220_12)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413101", "413101052", "story_v_out_413101.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413101", "413101052", "story_v_out_413101.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_13 = math.max(var_220_6, arg_217_1.talkMaxDuration)

			if var_220_5 <= arg_217_1.time_ and arg_217_1.time_ < var_220_5 + var_220_13 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_5) / var_220_13

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_5 + var_220_13 and arg_217_1.time_ < var_220_5 + var_220_13 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play413101053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413101053
		arg_221_1.duration_ = 8.67

		local var_221_0 = {
			zh = 6.366,
			ja = 8.666
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
				arg_221_0:Play413101054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10093 = arg_221_1.actors_["10093"].transform.localPosition
				arg_221_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10093", 4)

				for iter_224_0 = 0, arg_221_1.actors_["10093"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["10093"].transform:GetChild(iter_224_0)

					if var_224_0.name == "split_4" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_224_2 = arg_221_1.actors_["10022"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10022 == nil then
				arg_221_1.var_.actorSpriteComps10022 = var_224_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_3 = 2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.actorSpriteComps10022 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								iter_224_2.color = Color.New(Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_3), Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_3), (Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_3)))
							else
								local var_224_4 = Mathf.Lerp(iter_224_2.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_3)

								iter_224_2.color = Color.New(var_224_4, var_224_4, var_224_4)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10022 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_224_4 then
						iter_224_4.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps10022 = nil
			end

			local var_224_5 = arg_221_1.actors_["10093"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.actorSpriteComps10093 == nil then
				arg_221_1.var_.actorSpriteComps10093 = var_224_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_6 = 2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_6 and not isNil(var_224_5) then
				if arg_221_1.var_.actorSpriteComps10093 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_224_6 then
							if arg_221_1.isInRecall_ then
								iter_224_6.color = Color.New(Mathf.Lerp(iter_224_6.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_6), Mathf.Lerp(iter_224_6.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_6), (Mathf.Lerp(iter_224_6.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_6)))
							else
								local var_224_7 = Mathf.Lerp(iter_224_6.color.r, 1, (arg_221_1.time_ - 0) / var_224_6)

								iter_224_6.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_6 and arg_221_1.time_ < 0 + var_224_6 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.actorSpriteComps10093 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_224_8 then
						iter_224_8.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps10093 = nil
			end

			local var_224_8 = 0
			local var_224_9 = 0.85

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_10 = arg_221_1:GetWordFromCfg(413101053)
				local var_224_11 = arg_221_1:FormatText(var_224_10.content)

				arg_221_1.text_.text = var_224_11

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 34 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 34)

				if (34 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 34)) > 0 and var_224_9 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_11
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101053", "story_v_out_413101.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101053", "story_v_out_413101.awb") / 1000

					if var_224_14 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_8
					end

					if var_224_10.prefab_name ~= "" and arg_221_1.actors_[var_224_10.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_10.prefab_name].transform, "story_v_out_413101", "413101053", "story_v_out_413101.awb")

						arg_221_1:RecordAudio("413101053", var_224_15)
						arg_221_1:RecordAudio("413101053", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_413101", "413101053", "story_v_out_413101.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_413101", "413101053", "story_v_out_413101.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_16 and arg_221_1.time_ < var_224_8 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413101054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413101054
		arg_225_1.duration_ = 3.73

		local var_225_0 = {
			zh = 3.733,
			ja = 3.3
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
				arg_225_0:Play413101055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10022 = arg_225_1.actors_["10022"].transform.localPosition
				arg_225_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10022", 6)

				for iter_228_0 = 0, arg_225_1.actors_["10022"].transform.childCount - 1 do
					local var_228_0 = arg_225_1.actors_["10022"].transform:GetChild(iter_228_0)

					if var_228_0.name == "" or not string.find(var_228_0.name, "split") then
						var_228_0.gameObject:SetActive(true)
					else
						var_228_0.gameObject:SetActive(false)
					end
				end
			end

			local var_228_1 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 then
				arg_225_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_225_1.time_ - 0) / var_228_1)
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 then
				arg_225_1.actors_["10022"].transform.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_228_2 = arg_225_1.actors_["10093"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10093 = var_228_2.localPosition
				var_228_2.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10093", 6)

				for iter_228_1 = 0, var_228_2.childCount - 1 do
					local var_228_3 = var_228_2:GetChild(iter_228_1)

					if var_228_3.name == "" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_2.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_225_1.time_ - 0) / var_228_4)
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_2.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_228_5 = arg_225_1.actors_["10094"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10094 = var_228_5.localPosition
				var_228_5.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10094", 3)

				for iter_228_2 = 0, var_228_5.childCount - 1 do
					local var_228_6 = var_228_5:GetChild(iter_228_2)

					if var_228_6.name == "" or not string.find(var_228_6.name, "split") then
						var_228_6.gameObject:SetActive(true)
					else
						var_228_6.gameObject:SetActive(false)
					end
				end
			end

			local var_228_7 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				var_228_5.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_225_1.time_ - 0) / var_228_7)
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				var_228_5.localPosition = Vector3.New(0, -340, -414)
			end

			local var_228_8 = arg_225_1.actors_["10022"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10022 == nil then
				arg_225_1.var_.actorSpriteComps10022 = var_228_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_9 = 2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_9 and not isNil(var_228_8) then
				if arg_225_1.var_.actorSpriteComps10022 then
					for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_228_4 then
							if arg_225_1.isInRecall_ then
								iter_228_4.color = Color.New(Mathf.Lerp(iter_228_4.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_9), Mathf.Lerp(iter_228_4.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_9), (Mathf.Lerp(iter_228_4.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_9)))
							else
								local var_228_10 = Mathf.Lerp(iter_228_4.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_9)

								iter_228_4.color = Color.New(var_228_10, var_228_10, var_228_10)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_9 and arg_225_1.time_ < 0 + var_228_9 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10022 then
				for iter_228_5, iter_228_6 in pairs(arg_225_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_228_6 then
						iter_228_6.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps10022 = nil
			end

			local var_228_11 = arg_225_1.actors_["10093"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_11) and arg_225_1.var_.actorSpriteComps10093 == nil then
				arg_225_1.var_.actorSpriteComps10093 = var_228_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_12 = 2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_12 and not isNil(var_228_11) then
				if arg_225_1.var_.actorSpriteComps10093 then
					for iter_228_7, iter_228_8 in pairs(arg_225_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_228_8 then
							if arg_225_1.isInRecall_ then
								iter_228_8.color = Color.New(Mathf.Lerp(iter_228_8.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_12), Mathf.Lerp(iter_228_8.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_12), (Mathf.Lerp(iter_228_8.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_12)))
							else
								local var_228_13 = Mathf.Lerp(iter_228_8.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_12)

								iter_228_8.color = Color.New(var_228_13, var_228_13, var_228_13)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_12 and arg_225_1.time_ < 0 + var_228_12 + arg_228_0 and not isNil(var_228_11) and arg_225_1.var_.actorSpriteComps10093 then
				for iter_228_9, iter_228_10 in pairs(arg_225_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_228_10 then
						iter_228_10.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps10093 = nil
			end

			local var_228_14 = arg_225_1.actors_["10094"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_14) and arg_225_1.var_.actorSpriteComps10094 == nil then
				arg_225_1.var_.actorSpriteComps10094 = var_228_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_15 = 2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_15 and not isNil(var_228_14) then
				if arg_225_1.var_.actorSpriteComps10094 then
					for iter_228_11, iter_228_12 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_228_12 then
							if arg_225_1.isInRecall_ then
								iter_228_12.color = Color.New(Mathf.Lerp(iter_228_12.color.r, arg_225_1.hightColor1.r, (arg_225_1.time_ - 0) / var_228_15), Mathf.Lerp(iter_228_12.color.g, arg_225_1.hightColor1.g, (arg_225_1.time_ - 0) / var_228_15), (Mathf.Lerp(iter_228_12.color.b, arg_225_1.hightColor1.b, (arg_225_1.time_ - 0) / var_228_15)))
							else
								local var_228_16 = Mathf.Lerp(iter_228_12.color.r, 1, (arg_225_1.time_ - 0) / var_228_15)

								iter_228_12.color = Color.New(var_228_16, var_228_16, var_228_16)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_15 and arg_225_1.time_ < 0 + var_228_15 + arg_228_0 and not isNil(var_228_14) and arg_225_1.var_.actorSpriteComps10094 then
				for iter_228_13, iter_228_14 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_228_14 then
						iter_228_14.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps10094 = nil
			end

			local var_228_17 = 0
			local var_228_18 = 0.55

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_17 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_19 = arg_225_1:GetWordFromCfg(413101054)
				local var_228_20 = arg_225_1:FormatText(var_228_19.content)

				arg_225_1.text_.text = var_228_20

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_22 = 22 <= 0 and var_228_18 or var_228_18 * (utf8.len(var_228_20) / 22)

				if (22 <= 0 and var_228_18 or var_228_18 * (utf8.len(var_228_20) / 22)) > 0 and var_228_18 < var_228_22 then
					arg_225_1.talkMaxDuration = var_228_22

					if var_228_22 + var_228_17 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_22 + var_228_17
					end
				end

				arg_225_1.text_.text = var_228_20
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101054", "story_v_out_413101.awb") ~= 0 then
					local var_228_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101054", "story_v_out_413101.awb") / 1000

					if var_228_23 + var_228_17 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_17
					end

					if var_228_19.prefab_name ~= "" and arg_225_1.actors_[var_228_19.prefab_name] ~= nil then
						local var_228_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_19.prefab_name].transform, "story_v_out_413101", "413101054", "story_v_out_413101.awb")

						arg_225_1:RecordAudio("413101054", var_228_24)
						arg_225_1:RecordAudio("413101054", var_228_24)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413101", "413101054", "story_v_out_413101.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413101", "413101054", "story_v_out_413101.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_25 = math.max(var_228_18, arg_225_1.talkMaxDuration)

			if var_228_17 <= arg_225_1.time_ and arg_225_1.time_ < var_228_17 + var_228_25 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_17) / var_228_25

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_17 + var_228_25 and arg_225_1.time_ < var_228_17 + var_228_25 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413101055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 413101055
		arg_229_1.duration_ = 8.47

		local var_229_0 = {
			zh = 8.466,
			ja = 6.533
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
				arg_229_0:Play413101056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.825

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(413101055)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 33)

				if (33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 33)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101055", "story_v_out_413101.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101055", "story_v_out_413101.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_413101", "413101055", "story_v_out_413101.awb")

						arg_229_1:RecordAudio("413101055", var_232_6)
						arg_229_1:RecordAudio("413101055", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_413101", "413101055", "story_v_out_413101.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_413101", "413101055", "story_v_out_413101.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play413101056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 413101056
		arg_233_1.duration_ = 15.1

		local var_233_0 = {
			zh = 10.566,
			ja = 15.1
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
				arg_233_0:Play413101057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10094 = arg_233_1.actors_["10094"].transform.localPosition
				arg_233_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10094", 3)

				for iter_236_0 = 0, arg_233_1.actors_["10094"].transform.childCount - 1 do
					local var_236_0 = arg_233_1.actors_["10094"].transform:GetChild(iter_236_0)

					if var_236_0.name == "split_2" or not string.find(var_236_0.name, "split") then
						var_236_0.gameObject:SetActive(true)
					else
						var_236_0.gameObject:SetActive(false)
					end
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_233_1.time_ - 0) / var_236_1)
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_236_2 = arg_233_1.actors_["10094"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps10094 == nil then
				arg_233_1.var_.actorSpriteComps10094 = var_236_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_3 = 2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.actorSpriteComps10094 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_236_2 then
							if arg_233_1.isInRecall_ then
								iter_236_2.color = Color.New(Mathf.Lerp(iter_236_2.color.r, arg_233_1.hightColor1.r, (arg_233_1.time_ - 0) / var_236_3), Mathf.Lerp(iter_236_2.color.g, arg_233_1.hightColor1.g, (arg_233_1.time_ - 0) / var_236_3), (Mathf.Lerp(iter_236_2.color.b, arg_233_1.hightColor1.b, (arg_233_1.time_ - 0) / var_236_3)))
							else
								local var_236_4 = Mathf.Lerp(iter_236_2.color.r, 1, (arg_233_1.time_ - 0) / var_236_3)

								iter_236_2.color = Color.New(var_236_4, var_236_4, var_236_4)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps10094 then
				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_236_4 then
						iter_236_4.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps10094 = nil
			end

			local var_236_5 = 0
			local var_236_6 = 1.25

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_7 = arg_233_1:GetWordFromCfg(413101056)
				local var_236_8 = arg_233_1:FormatText(var_236_7.content)

				arg_233_1.text_.text = var_236_8

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_10 = 50 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_8) / 50)

				if (50 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_8) / 50)) > 0 and var_236_6 < var_236_10 then
					arg_233_1.talkMaxDuration = var_236_10

					if var_236_10 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_5
					end
				end

				arg_233_1.text_.text = var_236_8
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101056", "story_v_out_413101.awb") ~= 0 then
					local var_236_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101056", "story_v_out_413101.awb") / 1000

					if var_236_11 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_5
					end

					if var_236_7.prefab_name ~= "" and arg_233_1.actors_[var_236_7.prefab_name] ~= nil then
						local var_236_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_7.prefab_name].transform, "story_v_out_413101", "413101056", "story_v_out_413101.awb")

						arg_233_1:RecordAudio("413101056", var_236_12)
						arg_233_1:RecordAudio("413101056", var_236_12)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_413101", "413101056", "story_v_out_413101.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_413101", "413101056", "story_v_out_413101.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_13 = math.max(var_236_6, arg_233_1.talkMaxDuration)

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_13 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_5) / var_236_13

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_5 + var_236_13 and arg_233_1.time_ < var_236_5 + var_236_13 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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
	Play413101057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 413101057
		arg_237_1.duration_ = 5.67

		local var_237_0 = {
			zh = 2.533,
			ja = 5.666
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
				arg_237_0:Play413101058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10094 = arg_237_1.actors_["10094"].transform.localPosition
				arg_237_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10094", 2)

				for iter_240_0 = 0, arg_237_1.actors_["10094"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["10094"].transform:GetChild(iter_240_0)

					if var_240_0.name == "split_2" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["10094"].transform.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_240_2 = arg_237_1.actors_["10092"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10092 = var_240_2.localPosition
				var_240_2.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10092", 4)

				for iter_240_1 = 0, var_240_2.childCount - 1 do
					local var_240_3 = var_240_2:GetChild(iter_240_1)

					if var_240_3.name == "split_1_1" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				var_240_2.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_237_1.time_ - 0) / var_240_4)
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				var_240_2.localPosition = Vector3.New(390, -300, -295)
			end

			local var_240_5 = arg_237_1.actors_["10094"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps10094 == nil then
				arg_237_1.var_.actorSpriteComps10094 = var_240_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_6 = 2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 and not isNil(var_240_5) then
				if arg_237_1.var_.actorSpriteComps10094 then
					for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_240_3 then
							if arg_237_1.isInRecall_ then
								iter_240_3.color = Color.New(Mathf.Lerp(iter_240_3.color.r, arg_237_1.hightColor2.r, (arg_237_1.time_ - 0) / var_240_6), Mathf.Lerp(iter_240_3.color.g, arg_237_1.hightColor2.g, (arg_237_1.time_ - 0) / var_240_6), (Mathf.Lerp(iter_240_3.color.b, arg_237_1.hightColor2.b, (arg_237_1.time_ - 0) / var_240_6)))
							else
								local var_240_7 = Mathf.Lerp(iter_240_3.color.r, 0.5, (arg_237_1.time_ - 0) / var_240_6)

								iter_240_3.color = Color.New(var_240_7, var_240_7, var_240_7)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps10094 then
				for iter_240_4, iter_240_5 in pairs(arg_237_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_240_5 then
						iter_240_5.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps10094 = nil
			end

			local var_240_8 = arg_237_1.actors_["10092"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_8) and arg_237_1.var_.actorSpriteComps10092 == nil then
				arg_237_1.var_.actorSpriteComps10092 = var_240_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_9 = 2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_9 and not isNil(var_240_8) then
				if arg_237_1.var_.actorSpriteComps10092 then
					for iter_240_6, iter_240_7 in pairs(arg_237_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_240_7 then
							if arg_237_1.isInRecall_ then
								iter_240_7.color = Color.New(Mathf.Lerp(iter_240_7.color.r, arg_237_1.hightColor1.r, (arg_237_1.time_ - 0) / var_240_9), Mathf.Lerp(iter_240_7.color.g, arg_237_1.hightColor1.g, (arg_237_1.time_ - 0) / var_240_9), (Mathf.Lerp(iter_240_7.color.b, arg_237_1.hightColor1.b, (arg_237_1.time_ - 0) / var_240_9)))
							else
								local var_240_10 = Mathf.Lerp(iter_240_7.color.r, 1, (arg_237_1.time_ - 0) / var_240_9)

								iter_240_7.color = Color.New(var_240_10, var_240_10, var_240_10)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_9 and arg_237_1.time_ < 0 + var_240_9 + arg_240_0 and not isNil(var_240_8) and arg_237_1.var_.actorSpriteComps10092 then
				for iter_240_8, iter_240_9 in pairs(arg_237_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_240_9 then
						iter_240_9.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_237_1.var_.actorSpriteComps10092 = nil
			end

			local var_240_11 = 0
			local var_240_12 = 0.375

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_11 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_13 = arg_237_1:GetWordFromCfg(413101057)
				local var_240_14 = arg_237_1:FormatText(var_240_13.content)

				arg_237_1.text_.text = var_240_14

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_16 = 15 <= 0 and var_240_12 or var_240_12 * (utf8.len(var_240_14) / 15)

				if (15 <= 0 and var_240_12 or var_240_12 * (utf8.len(var_240_14) / 15)) > 0 and var_240_12 < var_240_16 then
					arg_237_1.talkMaxDuration = var_240_16

					if var_240_16 + var_240_11 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_16 + var_240_11
					end
				end

				arg_237_1.text_.text = var_240_14
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101057", "story_v_out_413101.awb") ~= 0 then
					local var_240_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101057", "story_v_out_413101.awb") / 1000

					if var_240_17 + var_240_11 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_17 + var_240_11
					end

					if var_240_13.prefab_name ~= "" and arg_237_1.actors_[var_240_13.prefab_name] ~= nil then
						local var_240_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_13.prefab_name].transform, "story_v_out_413101", "413101057", "story_v_out_413101.awb")

						arg_237_1:RecordAudio("413101057", var_240_18)
						arg_237_1:RecordAudio("413101057", var_240_18)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_413101", "413101057", "story_v_out_413101.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_413101", "413101057", "story_v_out_413101.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_19 = math.max(var_240_12, arg_237_1.talkMaxDuration)

			if var_240_11 <= arg_237_1.time_ and arg_237_1.time_ < var_240_11 + var_240_19 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_11) / var_240_19

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_11 + var_240_19 and arg_237_1.time_ < var_240_11 + var_240_19 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413101058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 413101058
		arg_241_1.duration_ = 11.33

		local var_241_0 = {
			zh = 8.5,
			ja = 11.333
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
				arg_241_0:Play413101059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 1.25

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(413101058)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 50 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 50)

				if (50 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 50)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101058", "story_v_out_413101.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101058", "story_v_out_413101.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_413101", "413101058", "story_v_out_413101.awb")

						arg_241_1:RecordAudio("413101058", var_244_6)
						arg_241_1:RecordAudio("413101058", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_413101", "413101058", "story_v_out_413101.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_413101", "413101058", "story_v_out_413101.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play413101059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 413101059
		arg_245_1.duration_ = 9.8

		local var_245_0 = {
			zh = 9.3,
			ja = 9.8
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
				arg_245_0:Play413101060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos10022 = arg_245_1.actors_["10022"].transform.localPosition
				arg_245_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("10022", 2)

				for iter_248_0 = 0, arg_245_1.actors_["10022"].transform.childCount - 1 do
					local var_248_0 = arg_245_1.actors_["10022"].transform:GetChild(iter_248_0)

					if var_248_0.name == "" or not string.find(var_248_0.name, "split") then
						var_248_0.gameObject:SetActive(true)
					else
						var_248_0.gameObject:SetActive(false)
					end
				end
			end

			local var_248_1 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_1 then
				arg_245_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_245_1.time_ - 0) / var_248_1)
			end

			if arg_245_1.time_ >= 0 + var_248_1 and arg_245_1.time_ < 0 + var_248_1 + arg_248_0 then
				arg_245_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_248_2 = arg_245_1.actors_["10022"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps10022 == nil then
				arg_245_1.var_.actorSpriteComps10022 = var_248_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_3 = 2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 and not isNil(var_248_2) then
				if arg_245_1.var_.actorSpriteComps10022 then
					for iter_248_1, iter_248_2 in pairs(arg_245_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_248_2 then
							if arg_245_1.isInRecall_ then
								iter_248_2.color = Color.New(Mathf.Lerp(iter_248_2.color.r, arg_245_1.hightColor1.r, (arg_245_1.time_ - 0) / var_248_3), Mathf.Lerp(iter_248_2.color.g, arg_245_1.hightColor1.g, (arg_245_1.time_ - 0) / var_248_3), (Mathf.Lerp(iter_248_2.color.b, arg_245_1.hightColor1.b, (arg_245_1.time_ - 0) / var_248_3)))
							else
								local var_248_4 = Mathf.Lerp(iter_248_2.color.r, 1, (arg_245_1.time_ - 0) / var_248_3)

								iter_248_2.color = Color.New(var_248_4, var_248_4, var_248_4)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps10022 then
				for iter_248_3, iter_248_4 in pairs(arg_245_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_248_4 then
						iter_248_4.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_245_1.var_.actorSpriteComps10022 = nil
			end

			local var_248_5 = arg_245_1.actors_["10092"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.actorSpriteComps10092 == nil then
				arg_245_1.var_.actorSpriteComps10092 = var_248_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_6 = 2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_6 and not isNil(var_248_5) then
				if arg_245_1.var_.actorSpriteComps10092 then
					for iter_248_5, iter_248_6 in pairs(arg_245_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_248_6 then
							if arg_245_1.isInRecall_ then
								iter_248_6.color = Color.New(Mathf.Lerp(iter_248_6.color.r, arg_245_1.hightColor2.r, (arg_245_1.time_ - 0) / var_248_6), Mathf.Lerp(iter_248_6.color.g, arg_245_1.hightColor2.g, (arg_245_1.time_ - 0) / var_248_6), (Mathf.Lerp(iter_248_6.color.b, arg_245_1.hightColor2.b, (arg_245_1.time_ - 0) / var_248_6)))
							else
								local var_248_7 = Mathf.Lerp(iter_248_6.color.r, 0.5, (arg_245_1.time_ - 0) / var_248_6)

								iter_248_6.color = Color.New(var_248_7, var_248_7, var_248_7)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_6 and arg_245_1.time_ < 0 + var_248_6 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.actorSpriteComps10092 then
				for iter_248_7, iter_248_8 in pairs(arg_245_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_248_8 then
						iter_248_8.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps10092 = nil
			end

			local var_248_8 = 0
			local var_248_9 = 1.15

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_10 = arg_245_1:GetWordFromCfg(413101059)
				local var_248_11 = arg_245_1:FormatText(var_248_10.content)

				arg_245_1.text_.text = var_248_11

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_13 = 46 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_11) / 46)

				if (46 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_11) / 46)) > 0 and var_248_9 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_8
					end
				end

				arg_245_1.text_.text = var_248_11
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101059", "story_v_out_413101.awb") ~= 0 then
					local var_248_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101059", "story_v_out_413101.awb") / 1000

					if var_248_14 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_14 + var_248_8
					end

					if var_248_10.prefab_name ~= "" and arg_245_1.actors_[var_248_10.prefab_name] ~= nil then
						local var_248_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_10.prefab_name].transform, "story_v_out_413101", "413101059", "story_v_out_413101.awb")

						arg_245_1:RecordAudio("413101059", var_248_15)
						arg_245_1:RecordAudio("413101059", var_248_15)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_413101", "413101059", "story_v_out_413101.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_413101", "413101059", "story_v_out_413101.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_16 = math.max(var_248_9, arg_245_1.talkMaxDuration)

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_16 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_8) / var_248_16

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_8 + var_248_16 and arg_245_1.time_ < var_248_8 + var_248_16 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play413101060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 413101060
		arg_249_1.duration_ = 6.2

		local var_249_0 = {
			zh = 3.733,
			ja = 6.2
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
				arg_249_0:Play413101061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10022 = arg_249_1.actors_["10022"].transform.localPosition
				arg_249_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10022", 2)

				for iter_252_0 = 0, arg_249_1.actors_["10022"].transform.childCount - 1 do
					local var_252_0 = arg_249_1.actors_["10022"].transform:GetChild(iter_252_0)

					if var_252_0.name == "" or not string.find(var_252_0.name, "split") then
						var_252_0.gameObject:SetActive(true)
					else
						var_252_0.gameObject:SetActive(false)
					end
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_249_1.time_ - 0) / var_252_1)
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_252_2 = arg_249_1.actors_["10094"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10094 = var_252_2.localPosition
				var_252_2.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10094", 4)

				for iter_252_1 = 0, var_252_2.childCount - 1 do
					local var_252_3 = var_252_2:GetChild(iter_252_1)

					if var_252_3.name == "" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_249_1.time_ - 0) / var_252_4)
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(390, -340, -414)
			end

			local var_252_5 = arg_249_1.actors_["10022"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps10022 == nil then
				arg_249_1.var_.actorSpriteComps10022 = var_252_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_6 = 2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_6 and not isNil(var_252_5) then
				if arg_249_1.var_.actorSpriteComps10022 then
					for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_252_3 then
							if arg_249_1.isInRecall_ then
								iter_252_3.color = Color.New(Mathf.Lerp(iter_252_3.color.r, arg_249_1.hightColor2.r, (arg_249_1.time_ - 0) / var_252_6), Mathf.Lerp(iter_252_3.color.g, arg_249_1.hightColor2.g, (arg_249_1.time_ - 0) / var_252_6), (Mathf.Lerp(iter_252_3.color.b, arg_249_1.hightColor2.b, (arg_249_1.time_ - 0) / var_252_6)))
							else
								local var_252_7 = Mathf.Lerp(iter_252_3.color.r, 0.5, (arg_249_1.time_ - 0) / var_252_6)

								iter_252_3.color = Color.New(var_252_7, var_252_7, var_252_7)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_6 and arg_249_1.time_ < 0 + var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps10022 then
				for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_252_5 then
						iter_252_5.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps10022 = nil
			end

			local var_252_8 = arg_249_1.actors_["10094"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10094 == nil then
				arg_249_1.var_.actorSpriteComps10094 = var_252_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_9 = 2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_9 and not isNil(var_252_8) then
				if arg_249_1.var_.actorSpriteComps10094 then
					for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_252_7 then
							if arg_249_1.isInRecall_ then
								iter_252_7.color = Color.New(Mathf.Lerp(iter_252_7.color.r, arg_249_1.hightColor1.r, (arg_249_1.time_ - 0) / var_252_9), Mathf.Lerp(iter_252_7.color.g, arg_249_1.hightColor1.g, (arg_249_1.time_ - 0) / var_252_9), (Mathf.Lerp(iter_252_7.color.b, arg_249_1.hightColor1.b, (arg_249_1.time_ - 0) / var_252_9)))
							else
								local var_252_10 = Mathf.Lerp(iter_252_7.color.r, 1, (arg_249_1.time_ - 0) / var_252_9)

								iter_252_7.color = Color.New(var_252_10, var_252_10, var_252_10)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_9 and arg_249_1.time_ < 0 + var_252_9 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10094 then
				for iter_252_8, iter_252_9 in pairs(arg_249_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_252_9 then
						iter_252_9.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps10094 = nil
			end

			local var_252_11 = 0
			local var_252_12 = 0.4

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_13 = arg_249_1:GetWordFromCfg(413101060)
				local var_252_14 = arg_249_1:FormatText(var_252_13.content)

				arg_249_1.text_.text = var_252_14

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_16 = 16 <= 0 and var_252_12 or var_252_12 * (utf8.len(var_252_14) / 16)

				if (16 <= 0 and var_252_12 or var_252_12 * (utf8.len(var_252_14) / 16)) > 0 and var_252_12 < var_252_16 then
					arg_249_1.talkMaxDuration = var_252_16

					if var_252_16 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_16 + var_252_11
					end
				end

				arg_249_1.text_.text = var_252_14
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101060", "story_v_out_413101.awb") ~= 0 then
					local var_252_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101060", "story_v_out_413101.awb") / 1000

					if var_252_17 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_17 + var_252_11
					end

					if var_252_13.prefab_name ~= "" and arg_249_1.actors_[var_252_13.prefab_name] ~= nil then
						local var_252_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_13.prefab_name].transform, "story_v_out_413101", "413101060", "story_v_out_413101.awb")

						arg_249_1:RecordAudio("413101060", var_252_18)
						arg_249_1:RecordAudio("413101060", var_252_18)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_413101", "413101060", "story_v_out_413101.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_413101", "413101060", "story_v_out_413101.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_19 = math.max(var_252_12, arg_249_1.talkMaxDuration)

			if var_252_11 <= arg_249_1.time_ and arg_249_1.time_ < var_252_11 + var_252_19 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_11) / var_252_19

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_11 + var_252_19 and arg_249_1.time_ < var_252_11 + var_252_19 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413101061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 413101061
		arg_253_1.duration_ = 5.73

		local var_253_0 = {
			zh = 4.2,
			ja = 5.733
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
				arg_253_0:Play413101062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10022 = arg_253_1.actors_["10022"].transform.localPosition
				arg_253_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10022", 2)

				for iter_256_0 = 0, arg_253_1.actors_["10022"].transform.childCount - 1 do
					local var_256_0 = arg_253_1.actors_["10022"].transform:GetChild(iter_256_0)

					if var_256_0.name == "split_3" or not string.find(var_256_0.name, "split") then
						var_256_0.gameObject:SetActive(true)
					else
						var_256_0.gameObject:SetActive(false)
					end
				end
			end

			local var_256_1 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_1 then
				arg_253_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_253_1.time_ - 0) / var_256_1)
			end

			if arg_253_1.time_ >= 0 + var_256_1 and arg_253_1.time_ < 0 + var_256_1 + arg_256_0 then
				arg_253_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_256_2 = arg_253_1.actors_["10094"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10094 = var_256_2.localPosition
				var_256_2.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10094", 4)

				for iter_256_1 = 0, var_256_2.childCount - 1 do
					local var_256_3 = var_256_2:GetChild(iter_256_1)

					if var_256_3.name == "" or not string.find(var_256_3.name, "split") then
						var_256_3.gameObject:SetActive(true)
					else
						var_256_3.gameObject:SetActive(false)
					end
				end
			end

			local var_256_4 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				var_256_2.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_253_1.time_ - 0) / var_256_4)
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				var_256_2.localPosition = Vector3.New(390, -340, -414)
			end

			local var_256_5 = arg_253_1.actors_["10022"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.actorSpriteComps10022 == nil then
				arg_253_1.var_.actorSpriteComps10022 = var_256_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_6 = 2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_6 and not isNil(var_256_5) then
				if arg_253_1.var_.actorSpriteComps10022 then
					for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_256_3 then
							if arg_253_1.isInRecall_ then
								iter_256_3.color = Color.New(Mathf.Lerp(iter_256_3.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 0) / var_256_6), Mathf.Lerp(iter_256_3.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 0) / var_256_6), (Mathf.Lerp(iter_256_3.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 0) / var_256_6)))
							else
								local var_256_7 = Mathf.Lerp(iter_256_3.color.r, 1, (arg_253_1.time_ - 0) / var_256_6)

								iter_256_3.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_6 and arg_253_1.time_ < 0 + var_256_6 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.actorSpriteComps10022 then
				for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_256_5 then
						iter_256_5.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps10022 = nil
			end

			local var_256_8 = arg_253_1.actors_["10094"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps10094 == nil then
				arg_253_1.var_.actorSpriteComps10094 = var_256_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_9 = 2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_9 and not isNil(var_256_8) then
				if arg_253_1.var_.actorSpriteComps10094 then
					for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_256_7 then
							if arg_253_1.isInRecall_ then
								iter_256_7.color = Color.New(Mathf.Lerp(iter_256_7.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_9), Mathf.Lerp(iter_256_7.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_9), (Mathf.Lerp(iter_256_7.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_9)))
							else
								local var_256_10 = Mathf.Lerp(iter_256_7.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_9)

								iter_256_7.color = Color.New(var_256_10, var_256_10, var_256_10)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_9 and arg_253_1.time_ < 0 + var_256_9 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps10094 then
				for iter_256_8, iter_256_9 in pairs(arg_253_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_256_9 then
						iter_256_9.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps10094 = nil
			end

			local var_256_11 = 0
			local var_256_12 = 0.6

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_11 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_13 = arg_253_1:GetWordFromCfg(413101061)
				local var_256_14 = arg_253_1:FormatText(var_256_13.content)

				arg_253_1.text_.text = var_256_14

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_16 = 24 <= 0 and var_256_12 or var_256_12 * (utf8.len(var_256_14) / 24)

				if (24 <= 0 and var_256_12 or var_256_12 * (utf8.len(var_256_14) / 24)) > 0 and var_256_12 < var_256_16 then
					arg_253_1.talkMaxDuration = var_256_16

					if var_256_16 + var_256_11 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_16 + var_256_11
					end
				end

				arg_253_1.text_.text = var_256_14
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101061", "story_v_out_413101.awb") ~= 0 then
					local var_256_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101061", "story_v_out_413101.awb") / 1000

					if var_256_17 + var_256_11 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_17 + var_256_11
					end

					if var_256_13.prefab_name ~= "" and arg_253_1.actors_[var_256_13.prefab_name] ~= nil then
						local var_256_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_13.prefab_name].transform, "story_v_out_413101", "413101061", "story_v_out_413101.awb")

						arg_253_1:RecordAudio("413101061", var_256_18)
						arg_253_1:RecordAudio("413101061", var_256_18)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_413101", "413101061", "story_v_out_413101.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_413101", "413101061", "story_v_out_413101.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_19 = math.max(var_256_12, arg_253_1.talkMaxDuration)

			if var_256_11 <= arg_253_1.time_ and arg_253_1.time_ < var_256_11 + var_256_19 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_11) / var_256_19

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_11 + var_256_19 and arg_253_1.time_ < var_256_11 + var_256_19 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413101062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413101062
		arg_257_1.duration_ = 8.87

		local var_257_0 = {
			zh = 3.166,
			ja = 8.866
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
				arg_257_0:Play413101063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["10022"]) and arg_257_1.var_.actorSpriteComps10022 == nil then
				arg_257_1.var_.actorSpriteComps10022 = arg_257_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_0 = 2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["10022"]) then
				if arg_257_1.var_.actorSpriteComps10022 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								iter_260_1.color = Color.New(Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor2.r, (arg_257_1.time_ - 0) / var_260_0), Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor2.g, (arg_257_1.time_ - 0) / var_260_0), (Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor2.b, (arg_257_1.time_ - 0) / var_260_0)))
							else
								local var_260_1 = Mathf.Lerp(iter_260_1.color.r, 0.5, (arg_257_1.time_ - 0) / var_260_0)

								iter_260_1.color = Color.New(var_260_1, var_260_1, var_260_1)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["10022"]) and arg_257_1.var_.actorSpriteComps10022 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_260_3 then
						iter_260_3.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps10022 = nil
			end

			local var_260_2 = arg_257_1.actors_["10094"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps10094 == nil then
				arg_257_1.var_.actorSpriteComps10094 = var_260_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_3 = 2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.actorSpriteComps10094 then
					for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_260_5 then
							if arg_257_1.isInRecall_ then
								iter_260_5.color = Color.New(Mathf.Lerp(iter_260_5.color.r, arg_257_1.hightColor1.r, (arg_257_1.time_ - 0) / var_260_3), Mathf.Lerp(iter_260_5.color.g, arg_257_1.hightColor1.g, (arg_257_1.time_ - 0) / var_260_3), (Mathf.Lerp(iter_260_5.color.b, arg_257_1.hightColor1.b, (arg_257_1.time_ - 0) / var_260_3)))
							else
								local var_260_4 = Mathf.Lerp(iter_260_5.color.r, 1, (arg_257_1.time_ - 0) / var_260_3)

								iter_260_5.color = Color.New(var_260_4, var_260_4, var_260_4)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps10094 then
				for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_260_7 then
						iter_260_7.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps10094 = nil
			end

			local var_260_5 = 0
			local var_260_6 = 0.45

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_7 = arg_257_1:GetWordFromCfg(413101062)
				local var_260_8 = arg_257_1:FormatText(var_260_7.content)

				arg_257_1.text_.text = var_260_8

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_10 = 18 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_8) / 18)

				if (18 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_8) / 18)) > 0 and var_260_6 < var_260_10 then
					arg_257_1.talkMaxDuration = var_260_10

					if var_260_10 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_5
					end
				end

				arg_257_1.text_.text = var_260_8
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101062", "story_v_out_413101.awb") ~= 0 then
					local var_260_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101062", "story_v_out_413101.awb") / 1000

					if var_260_11 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_11 + var_260_5
					end

					if var_260_7.prefab_name ~= "" and arg_257_1.actors_[var_260_7.prefab_name] ~= nil then
						local var_260_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_7.prefab_name].transform, "story_v_out_413101", "413101062", "story_v_out_413101.awb")

						arg_257_1:RecordAudio("413101062", var_260_12)
						arg_257_1:RecordAudio("413101062", var_260_12)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_413101", "413101062", "story_v_out_413101.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_413101", "413101062", "story_v_out_413101.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_13 = math.max(var_260_6, arg_257_1.talkMaxDuration)

			if var_260_5 <= arg_257_1.time_ and arg_257_1.time_ < var_260_5 + var_260_13 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_5) / var_260_13

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_5 + var_260_13 and arg_257_1.time_ < var_260_5 + var_260_13 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play413101063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413101063
		arg_261_1.duration_ = 4.73

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play413101064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["10022"]) and arg_261_1.var_.actorSpriteComps10022 == nil then
				arg_261_1.var_.actorSpriteComps10022 = arg_261_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_0 = 2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["10022"]) then
				if arg_261_1.var_.actorSpriteComps10022 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_264_1 then
							if arg_261_1.isInRecall_ then
								iter_264_1.color = Color.New(Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_0), Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_0), (Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_0)))
							else
								local var_264_1 = Mathf.Lerp(iter_264_1.color.r, 1, (arg_261_1.time_ - 0) / var_264_0)

								iter_264_1.color = Color.New(var_264_1, var_264_1, var_264_1)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["10022"]) and arg_261_1.var_.actorSpriteComps10022 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_264_3 then
						iter_264_3.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps10022 = nil
			end

			local var_264_2 = arg_261_1.actors_["10094"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10094 == nil then
				arg_261_1.var_.actorSpriteComps10094 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps10094 then
					for iter_264_4, iter_264_5 in pairs(arg_261_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_264_5 then
							if arg_261_1.isInRecall_ then
								iter_264_5.color = Color.New(Mathf.Lerp(iter_264_5.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_5.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_5.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_5.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_5.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10094 then
				for iter_264_6, iter_264_7 in pairs(arg_261_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_264_7 then
						iter_264_7.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps10094 = nil
			end

			local var_264_5 = 0
			local var_264_6 = 0.6

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_7 = arg_261_1:GetWordFromCfg(413101063)
				local var_264_8 = arg_261_1:FormatText(var_264_7.content)

				arg_261_1.text_.text = var_264_8

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 24 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 24)

				if (24 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 24)) > 0 and var_264_6 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_5
					end
				end

				arg_261_1.text_.text = var_264_8
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101063", "story_v_out_413101.awb") ~= 0 then
					local var_264_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101063", "story_v_out_413101.awb") / 1000

					if var_264_11 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_5
					end

					if var_264_7.prefab_name ~= "" and arg_261_1.actors_[var_264_7.prefab_name] ~= nil then
						local var_264_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_7.prefab_name].transform, "story_v_out_413101", "413101063", "story_v_out_413101.awb")

						arg_261_1:RecordAudio("413101063", var_264_12)
						arg_261_1:RecordAudio("413101063", var_264_12)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_413101", "413101063", "story_v_out_413101.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_413101", "413101063", "story_v_out_413101.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_13 = math.max(var_264_6, arg_261_1.talkMaxDuration)

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_13 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_5) / var_264_13

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_5 + var_264_13 and arg_261_1.time_ < var_264_5 + var_264_13 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play413101064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 413101064
		arg_265_1.duration_ = 5.93

		local var_265_0 = {
			zh = 3.3,
			ja = 5.933
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
				arg_265_0:Play413101065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10094 = arg_265_1.actors_["10094"].transform.localPosition
				arg_265_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("10094", 4)

				for iter_268_0 = 0, arg_265_1.actors_["10094"].transform.childCount - 1 do
					local var_268_0 = arg_265_1.actors_["10094"].transform:GetChild(iter_268_0)

					if var_268_0.name == "split_2" or not string.find(var_268_0.name, "split") then
						var_268_0.gameObject:SetActive(true)
					else
						var_268_0.gameObject:SetActive(false)
					end
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_265_1.time_ - 0) / var_268_1)
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_268_2 = arg_265_1.actors_["10022"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps10022 == nil then
				arg_265_1.var_.actorSpriteComps10022 = var_268_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_3 = 2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.actorSpriteComps10022 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								iter_268_2.color = Color.New(Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor2.r, (arg_265_1.time_ - 0) / var_268_3), Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor2.g, (arg_265_1.time_ - 0) / var_268_3), (Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor2.b, (arg_265_1.time_ - 0) / var_268_3)))
							else
								local var_268_4 = Mathf.Lerp(iter_268_2.color.r, 0.5, (arg_265_1.time_ - 0) / var_268_3)

								iter_268_2.color = Color.New(var_268_4, var_268_4, var_268_4)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps10022 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_268_4 then
						iter_268_4.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps10022 = nil
			end

			local var_268_5 = arg_265_1.actors_["10094"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.actorSpriteComps10094 == nil then
				arg_265_1.var_.actorSpriteComps10094 = var_268_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_6 = 2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_6 and not isNil(var_268_5) then
				if arg_265_1.var_.actorSpriteComps10094 then
					for iter_268_5, iter_268_6 in pairs(arg_265_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_268_6 then
							if arg_265_1.isInRecall_ then
								iter_268_6.color = Color.New(Mathf.Lerp(iter_268_6.color.r, arg_265_1.hightColor1.r, (arg_265_1.time_ - 0) / var_268_6), Mathf.Lerp(iter_268_6.color.g, arg_265_1.hightColor1.g, (arg_265_1.time_ - 0) / var_268_6), (Mathf.Lerp(iter_268_6.color.b, arg_265_1.hightColor1.b, (arg_265_1.time_ - 0) / var_268_6)))
							else
								local var_268_7 = Mathf.Lerp(iter_268_6.color.r, 1, (arg_265_1.time_ - 0) / var_268_6)

								iter_268_6.color = Color.New(var_268_7, var_268_7, var_268_7)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_6 and arg_265_1.time_ < 0 + var_268_6 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.actorSpriteComps10094 then
				for iter_268_7, iter_268_8 in pairs(arg_265_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_268_8 then
						iter_268_8.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_265_1.var_.actorSpriteComps10094 = nil
			end

			local var_268_8 = 0
			local var_268_9 = 0.375

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:GetWordFromCfg(413101064)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 15 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 15)

				if (15 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 15)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101064", "story_v_out_413101.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101064", "story_v_out_413101.awb") / 1000

					if var_268_14 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_8
					end

					if var_268_10.prefab_name ~= "" and arg_265_1.actors_[var_268_10.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_10.prefab_name].transform, "story_v_out_413101", "413101064", "story_v_out_413101.awb")

						arg_265_1:RecordAudio("413101064", var_268_15)
						arg_265_1:RecordAudio("413101064", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_413101", "413101064", "story_v_out_413101.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_413101", "413101064", "story_v_out_413101.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_16 = math.max(var_268_9, arg_265_1.talkMaxDuration)

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_16 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_8) / var_268_16

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_8 + var_268_16 and arg_265_1.time_ < var_268_8 + var_268_16 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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
	Play413101065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 413101065
		arg_269_1.duration_ = 7.53

		local var_269_0 = {
			zh = 5.3,
			ja = 7.533
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
				arg_269_0:Play413101066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10092 = arg_269_1.actors_["10092"].transform.localPosition
				arg_269_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10092", 2)

				for iter_272_0 = 0, arg_269_1.actors_["10092"].transform.childCount - 1 do
					local var_272_0 = arg_269_1.actors_["10092"].transform:GetChild(iter_272_0)

					if var_272_0.name == "split_1_1" or not string.find(var_272_0.name, "split") then
						var_272_0.gameObject:SetActive(true)
					else
						var_272_0.gameObject:SetActive(false)
					end
				end
			end

			local var_272_1 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_1 then
				arg_269_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_269_1.time_ - 0) / var_272_1)
			end

			if arg_269_1.time_ >= 0 + var_272_1 and arg_269_1.time_ < 0 + var_272_1 + arg_272_0 then
				arg_269_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_272_2 = arg_269_1.actors_["10092"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10092 == nil then
				arg_269_1.var_.actorSpriteComps10092 = var_272_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_3 = 2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.actorSpriteComps10092 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								iter_272_2.color = Color.New(Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_3), Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_3), (Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_3)))
							else
								local var_272_4 = Mathf.Lerp(iter_272_2.color.r, 1, (arg_269_1.time_ - 0) / var_272_3)

								iter_272_2.color = Color.New(var_272_4, var_272_4, var_272_4)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10092 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_272_4 then
						iter_272_4.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps10092 = nil
			end

			local var_272_5 = arg_269_1.actors_["10094"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.actorSpriteComps10094 == nil then
				arg_269_1.var_.actorSpriteComps10094 = var_272_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_6 = 2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_6 and not isNil(var_272_5) then
				if arg_269_1.var_.actorSpriteComps10094 then
					for iter_272_5, iter_272_6 in pairs(arg_269_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_272_6 then
							if arg_269_1.isInRecall_ then
								iter_272_6.color = Color.New(Mathf.Lerp(iter_272_6.color.r, arg_269_1.hightColor2.r, (arg_269_1.time_ - 0) / var_272_6), Mathf.Lerp(iter_272_6.color.g, arg_269_1.hightColor2.g, (arg_269_1.time_ - 0) / var_272_6), (Mathf.Lerp(iter_272_6.color.b, arg_269_1.hightColor2.b, (arg_269_1.time_ - 0) / var_272_6)))
							else
								local var_272_7 = Mathf.Lerp(iter_272_6.color.r, 0.5, (arg_269_1.time_ - 0) / var_272_6)

								iter_272_6.color = Color.New(var_272_7, var_272_7, var_272_7)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_6 and arg_269_1.time_ < 0 + var_272_6 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.actorSpriteComps10094 then
				for iter_272_7, iter_272_8 in pairs(arg_269_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_272_8 then
						iter_272_8.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps10094 = nil
			end

			local var_272_8 = 0
			local var_272_9 = 0.775

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_10 = arg_269_1:GetWordFromCfg(413101065)
				local var_272_11 = arg_269_1:FormatText(var_272_10.content)

				arg_269_1.text_.text = var_272_11

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_13 = 31 <= 0 and var_272_9 or var_272_9 * (utf8.len(var_272_11) / 31)

				if (31 <= 0 and var_272_9 or var_272_9 * (utf8.len(var_272_11) / 31)) > 0 and var_272_9 < var_272_13 then
					arg_269_1.talkMaxDuration = var_272_13

					if var_272_13 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_13 + var_272_8
					end
				end

				arg_269_1.text_.text = var_272_11
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101065", "story_v_out_413101.awb") ~= 0 then
					local var_272_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101065", "story_v_out_413101.awb") / 1000

					if var_272_14 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_14 + var_272_8
					end

					if var_272_10.prefab_name ~= "" and arg_269_1.actors_[var_272_10.prefab_name] ~= nil then
						local var_272_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_10.prefab_name].transform, "story_v_out_413101", "413101065", "story_v_out_413101.awb")

						arg_269_1:RecordAudio("413101065", var_272_15)
						arg_269_1:RecordAudio("413101065", var_272_15)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_413101", "413101065", "story_v_out_413101.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_413101", "413101065", "story_v_out_413101.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_16 = math.max(var_272_9, arg_269_1.talkMaxDuration)

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_16 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_8) / var_272_16

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_8 + var_272_16 and arg_269_1.time_ < var_272_8 + var_272_16 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413101066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 413101066
		arg_273_1.duration_ = 7.2

		local var_273_0 = {
			zh = 3.766,
			ja = 7.2
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
				arg_273_0:Play413101067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.475

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(413101066)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 19 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 19)

				if (19 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 19)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101066", "story_v_out_413101.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101066", "story_v_out_413101.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_413101", "413101066", "story_v_out_413101.awb")

						arg_273_1:RecordAudio("413101066", var_276_6)
						arg_273_1:RecordAudio("413101066", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_413101", "413101066", "story_v_out_413101.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_413101", "413101066", "story_v_out_413101.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play413101067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 413101067
		arg_277_1.duration_ = 5.53

		local var_277_0 = {
			zh = 4.833,
			ja = 5.533
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
				arg_277_0:Play413101068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10094 = arg_277_1.actors_["10094"].transform.localPosition
				arg_277_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("10094", 4)

				for iter_280_0 = 0, arg_277_1.actors_["10094"].transform.childCount - 1 do
					local var_280_0 = arg_277_1.actors_["10094"].transform:GetChild(iter_280_0)

					if var_280_0.name == "split_2" or not string.find(var_280_0.name, "split") then
						var_280_0.gameObject:SetActive(true)
					else
						var_280_0.gameObject:SetActive(false)
					end
				end
			end

			local var_280_1 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_1 then
				arg_277_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_277_1.time_ - 0) / var_280_1)
			end

			if arg_277_1.time_ >= 0 + var_280_1 and arg_277_1.time_ < 0 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_280_2 = arg_277_1.actors_["10092"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps10092 == nil then
				arg_277_1.var_.actorSpriteComps10092 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps10092 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								iter_280_2.color = Color.New(Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor2.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor2.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor2.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_2.color.r, 0.5, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_2.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps10092 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_280_4 then
						iter_280_4.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_277_1.var_.actorSpriteComps10092 = nil
			end

			local var_280_5 = arg_277_1.actors_["10094"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_5) and arg_277_1.var_.actorSpriteComps10094 == nil then
				arg_277_1.var_.actorSpriteComps10094 = var_280_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_6 = 2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_6 and not isNil(var_280_5) then
				if arg_277_1.var_.actorSpriteComps10094 then
					for iter_280_5, iter_280_6 in pairs(arg_277_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_280_6 then
							if arg_277_1.isInRecall_ then
								iter_280_6.color = Color.New(Mathf.Lerp(iter_280_6.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_6), Mathf.Lerp(iter_280_6.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_6), (Mathf.Lerp(iter_280_6.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_6)))
							else
								local var_280_7 = Mathf.Lerp(iter_280_6.color.r, 1, (arg_277_1.time_ - 0) / var_280_6)

								iter_280_6.color = Color.New(var_280_7, var_280_7, var_280_7)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_6 and arg_277_1.time_ < 0 + var_280_6 + arg_280_0 and not isNil(var_280_5) and arg_277_1.var_.actorSpriteComps10094 then
				for iter_280_7, iter_280_8 in pairs(arg_277_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_280_8 then
						iter_280_8.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps10094 = nil
			end

			local var_280_8 = 0
			local var_280_9 = 0.5

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_10 = arg_277_1:GetWordFromCfg(413101067)
				local var_280_11 = arg_277_1:FormatText(var_280_10.content)

				arg_277_1.text_.text = var_280_11

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_13 = 20 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 20)

				if (20 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 20)) > 0 and var_280_9 < var_280_13 then
					arg_277_1.talkMaxDuration = var_280_13

					if var_280_13 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_13 + var_280_8
					end
				end

				arg_277_1.text_.text = var_280_11
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101067", "story_v_out_413101.awb") ~= 0 then
					local var_280_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101067", "story_v_out_413101.awb") / 1000

					if var_280_14 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_14 + var_280_8
					end

					if var_280_10.prefab_name ~= "" and arg_277_1.actors_[var_280_10.prefab_name] ~= nil then
						local var_280_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_10.prefab_name].transform, "story_v_out_413101", "413101067", "story_v_out_413101.awb")

						arg_277_1:RecordAudio("413101067", var_280_15)
						arg_277_1:RecordAudio("413101067", var_280_15)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_413101", "413101067", "story_v_out_413101.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_413101", "413101067", "story_v_out_413101.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_16 = math.max(var_280_9, arg_277_1.talkMaxDuration)

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_16 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_8) / var_280_16

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_8 + var_280_16 and arg_277_1.time_ < var_280_8 + var_280_16 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play413101068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 413101068
		arg_281_1.duration_ = 5.68

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play413101069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10092 = arg_281_1.actors_["10092"].transform.localPosition
				arg_281_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10092", 6)

				for iter_284_0 = 0, arg_281_1.actors_["10092"].transform.childCount - 1 do
					local var_284_0 = arg_281_1.actors_["10092"].transform:GetChild(iter_284_0)

					if var_284_0.name == "" or not string.find(var_284_0.name, "split") then
						var_284_0.gameObject:SetActive(true)
					else
						var_284_0.gameObject:SetActive(false)
					end
				end
			end

			local var_284_1 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 then
				arg_281_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10092, Vector3.New(1500, -300, -295), (arg_281_1.time_ - 0) / var_284_1)
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 then
				arg_281_1.actors_["10092"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_284_2 = arg_281_1.actors_["10094"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10094 = var_284_2.localPosition
				var_284_2.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10094", 6)

				for iter_284_1 = 0, var_284_2.childCount - 1 do
					local var_284_3 = var_284_2:GetChild(iter_284_1)

					if var_284_3.name == "" or not string.find(var_284_3.name, "split") then
						var_284_3.gameObject:SetActive(true)
					else
						var_284_3.gameObject:SetActive(false)
					end
				end
			end

			local var_284_4 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				var_284_2.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10094, Vector3.New(1500, -340, -414), (arg_281_1.time_ - 0) / var_284_4)
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				var_284_2.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_284_5 = arg_281_1.actors_["10092"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.actorSpriteComps10092 == nil then
				arg_281_1.var_.actorSpriteComps10092 = var_284_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_6 = 2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_6 and not isNil(var_284_5) then
				if arg_281_1.var_.actorSpriteComps10092 then
					for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_284_3 then
							if arg_281_1.isInRecall_ then
								iter_284_3.color = Color.New(Mathf.Lerp(iter_284_3.color.r, arg_281_1.hightColor2.r, (arg_281_1.time_ - 0) / var_284_6), Mathf.Lerp(iter_284_3.color.g, arg_281_1.hightColor2.g, (arg_281_1.time_ - 0) / var_284_6), (Mathf.Lerp(iter_284_3.color.b, arg_281_1.hightColor2.b, (arg_281_1.time_ - 0) / var_284_6)))
							else
								local var_284_7 = Mathf.Lerp(iter_284_3.color.r, 0.5, (arg_281_1.time_ - 0) / var_284_6)

								iter_284_3.color = Color.New(var_284_7, var_284_7, var_284_7)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_6 and arg_281_1.time_ < 0 + var_284_6 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.actorSpriteComps10092 then
				for iter_284_4, iter_284_5 in pairs(arg_281_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_284_5 then
						iter_284_5.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps10092 = nil
			end

			local var_284_8 = arg_281_1.actors_["10094"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.actorSpriteComps10094 == nil then
				arg_281_1.var_.actorSpriteComps10094 = var_284_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_9 = 2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_9 and not isNil(var_284_8) then
				if arg_281_1.var_.actorSpriteComps10094 then
					for iter_284_6, iter_284_7 in pairs(arg_281_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_284_7 then
							if arg_281_1.isInRecall_ then
								iter_284_7.color = Color.New(Mathf.Lerp(iter_284_7.color.r, arg_281_1.hightColor2.r, (arg_281_1.time_ - 0) / var_284_9), Mathf.Lerp(iter_284_7.color.g, arg_281_1.hightColor2.g, (arg_281_1.time_ - 0) / var_284_9), (Mathf.Lerp(iter_284_7.color.b, arg_281_1.hightColor2.b, (arg_281_1.time_ - 0) / var_284_9)))
							else
								local var_284_10 = Mathf.Lerp(iter_284_7.color.r, 0.5, (arg_281_1.time_ - 0) / var_284_9)

								iter_284_7.color = Color.New(var_284_10, var_284_10, var_284_10)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_9 and arg_281_1.time_ < 0 + var_284_9 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.actorSpriteComps10094 then
				for iter_284_8, iter_284_9 in pairs(arg_281_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_284_9 then
						iter_284_9.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps10094 = nil
			end

			local var_284_11 = manager.ui.mainCamera.transform

			if 0.2 < arg_281_1.time_ and arg_281_1.time_ <= 0.2 + arg_284_0 then
				arg_281_1.var_.shakeOldPos = var_284_11.localPosition
			end

			local var_284_12 = 0.566666666666667

			if 0.2 <= arg_281_1.time_ and arg_281_1.time_ < 0.2 + var_284_12 then
				local var_284_13, var_284_14 = math.modf((arg_281_1.time_ - 0.2) / 0.066)

				var_284_11.localPosition = Vector3.New(var_284_14 * 0.13, var_284_14 * 0.13, var_284_14 * 0.13) + arg_281_1.var_.shakeOldPos
			end

			if arg_281_1.time_ >= 0.2 + var_284_12 and arg_281_1.time_ < 0.2 + var_284_12 + arg_284_0 then
				var_284_11.localPosition = arg_281_1.var_.shakeOldPos
			end

			local var_284_15 = 0

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = false

				arg_281_1:SetGaussion(false)
			end

			local var_284_16 = 0.3

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_16 then
				local var_284_17 = Color.New(1, 1, 1)

				var_284_17.a = Mathf.Lerp(1, 0, (arg_281_1.time_ - var_284_15) / var_284_16)
				arg_281_1.mask_.color = var_284_17
			end

			if arg_281_1.time_ >= var_284_15 + var_284_16 and arg_281_1.time_ < var_284_15 + var_284_16 + arg_284_0 then
				local var_284_18 = Color.New(1, 1, 1)

				arg_281_1.mask_.enabled = false
				var_284_18.a = 0
				arg_281_1.mask_.color = var_284_18
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:AudioAction("play", "effect", "se_story", "se_story_quake", "")
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_20 = 0.675
			local var_284_21 = 1.325

			if 0.675 < arg_281_1.time_ and arg_281_1.time_ <= var_284_20 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_22 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_22:setOnUpdate(LuaHelper.FloatAction(function(arg_285_0)
					arg_281_1.dialogCg_.alpha = arg_285_0
				end))
				var_284_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_23 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(413101068).content)

				arg_281_1.text_.text = var_284_23

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_25 = 53 <= 0 and var_284_21 or var_284_21 * (utf8.len(var_284_23) / 53)

				if (53 <= 0 and var_284_21 or var_284_21 * (utf8.len(var_284_23) / 53)) > 0 and var_284_21 < var_284_25 then
					arg_281_1.talkMaxDuration = var_284_25
					var_284_20 = var_284_20 + 0.3

					if var_284_25 + var_284_20 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_25 + var_284_20
					end
				end

				arg_281_1.text_.text = var_284_23
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_26 = var_284_20 + 0.3
			local var_284_27 = math.max(var_284_21, arg_281_1.talkMaxDuration)

			if var_284_20 + 0.3 <= arg_281_1.time_ and arg_281_1.time_ < var_284_26 + var_284_27 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_26) / var_284_27

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_26 + var_284_27 and arg_281_1.time_ < var_284_26 + var_284_27 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play413101069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 413101069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play413101070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_water", "")
			end

			local var_290_1 = 0
			local var_290_2 = 1.375

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_3 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(413101069).content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 55 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 55)

				if (55 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 55)) > 0 and var_290_2 < var_290_5 then
					arg_287_1.talkMaxDuration = var_290_5

					if var_290_5 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + var_290_1
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_6 = math.max(var_290_2, arg_287_1.talkMaxDuration)

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_6 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_1) / var_290_6

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_1 + var_290_6 and arg_287_1.time_ < var_290_1 + var_290_6 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play413101070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 413101070
		arg_291_1.duration_ = 5.63

		local var_291_0 = {
			zh = 2.6,
			ja = 5.633
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
				arg_291_0:Play413101071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10094 = arg_291_1.actors_["10094"].transform.localPosition
				arg_291_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10094", 3)

				for iter_294_0 = 0, arg_291_1.actors_["10094"].transform.childCount - 1 do
					local var_294_0 = arg_291_1.actors_["10094"].transform:GetChild(iter_294_0)

					if var_294_0.name == "split_2" or not string.find(var_294_0.name, "split") then
						var_294_0.gameObject:SetActive(true)
					else
						var_294_0.gameObject:SetActive(false)
					end
				end
			end

			local var_294_1 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_1 then
				arg_291_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_291_1.time_ - 0) / var_294_1)
			end

			if arg_291_1.time_ >= 0 + var_294_1 and arg_291_1.time_ < 0 + var_294_1 + arg_294_0 then
				arg_291_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_294_2 = arg_291_1.actors_["10094"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps10094 == nil then
				arg_291_1.var_.actorSpriteComps10094 = var_294_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_3 = 2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_3 and not isNil(var_294_2) then
				if arg_291_1.var_.actorSpriteComps10094 then
					for iter_294_1, iter_294_2 in pairs(arg_291_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_294_2 then
							if arg_291_1.isInRecall_ then
								iter_294_2.color = Color.New(Mathf.Lerp(iter_294_2.color.r, arg_291_1.hightColor1.r, (arg_291_1.time_ - 0) / var_294_3), Mathf.Lerp(iter_294_2.color.g, arg_291_1.hightColor1.g, (arg_291_1.time_ - 0) / var_294_3), (Mathf.Lerp(iter_294_2.color.b, arg_291_1.hightColor1.b, (arg_291_1.time_ - 0) / var_294_3)))
							else
								local var_294_4 = Mathf.Lerp(iter_294_2.color.r, 1, (arg_291_1.time_ - 0) / var_294_3)

								iter_294_2.color = Color.New(var_294_4, var_294_4, var_294_4)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_3 and arg_291_1.time_ < 0 + var_294_3 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps10094 then
				for iter_294_3, iter_294_4 in pairs(arg_291_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_294_4 then
						iter_294_4.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_291_1.var_.actorSpriteComps10094 = nil
			end

			local var_294_5 = 0
			local var_294_6 = 0.325

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_7 = arg_291_1:GetWordFromCfg(413101070)
				local var_294_8 = arg_291_1:FormatText(var_294_7.content)

				arg_291_1.text_.text = var_294_8

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_10 = 13 <= 0 and var_294_6 or var_294_6 * (utf8.len(var_294_8) / 13)

				if (13 <= 0 and var_294_6 or var_294_6 * (utf8.len(var_294_8) / 13)) > 0 and var_294_6 < var_294_10 then
					arg_291_1.talkMaxDuration = var_294_10

					if var_294_10 + var_294_5 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_10 + var_294_5
					end
				end

				arg_291_1.text_.text = var_294_8
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101070", "story_v_out_413101.awb") ~= 0 then
					local var_294_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101070", "story_v_out_413101.awb") / 1000

					if var_294_11 + var_294_5 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_11 + var_294_5
					end

					if var_294_7.prefab_name ~= "" and arg_291_1.actors_[var_294_7.prefab_name] ~= nil then
						local var_294_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_7.prefab_name].transform, "story_v_out_413101", "413101070", "story_v_out_413101.awb")

						arg_291_1:RecordAudio("413101070", var_294_12)
						arg_291_1:RecordAudio("413101070", var_294_12)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_413101", "413101070", "story_v_out_413101.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_413101", "413101070", "story_v_out_413101.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_13 = math.max(var_294_6, arg_291_1.talkMaxDuration)

			if var_294_5 <= arg_291_1.time_ and arg_291_1.time_ < var_294_5 + var_294_13 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_5) / var_294_13

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_5 + var_294_13 and arg_291_1.time_ < var_294_5 + var_294_13 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play413101071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 413101071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play413101072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10094 = arg_295_1.actors_["10094"].transform.localPosition
				arg_295_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10094", 6)

				for iter_298_0 = 0, arg_295_1.actors_["10094"].transform.childCount - 1 do
					local var_298_0 = arg_295_1.actors_["10094"].transform:GetChild(iter_298_0)

					if var_298_0.name == "" or not string.find(var_298_0.name, "split") then
						var_298_0.gameObject:SetActive(true)
					else
						var_298_0.gameObject:SetActive(false)
					end
				end
			end

			local var_298_1 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_1 then
				arg_295_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10094, Vector3.New(1500, -340, -414), (arg_295_1.time_ - 0) / var_298_1)
			end

			if arg_295_1.time_ >= 0 + var_298_1 and arg_295_1.time_ < 0 + var_298_1 + arg_298_0 then
				arg_295_1.actors_["10094"].transform.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_298_2 = arg_295_1.actors_["10094"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.actorSpriteComps10094 == nil then
				arg_295_1.var_.actorSpriteComps10094 = var_298_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_3 = 2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_3 and not isNil(var_298_2) then
				if arg_295_1.var_.actorSpriteComps10094 then
					for iter_298_1, iter_298_2 in pairs(arg_295_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_298_2 then
							if arg_295_1.isInRecall_ then
								iter_298_2.color = Color.New(Mathf.Lerp(iter_298_2.color.r, arg_295_1.hightColor2.r, (arg_295_1.time_ - 0) / var_298_3), Mathf.Lerp(iter_298_2.color.g, arg_295_1.hightColor2.g, (arg_295_1.time_ - 0) / var_298_3), (Mathf.Lerp(iter_298_2.color.b, arg_295_1.hightColor2.b, (arg_295_1.time_ - 0) / var_298_3)))
							else
								local var_298_4 = Mathf.Lerp(iter_298_2.color.r, 0.5, (arg_295_1.time_ - 0) / var_298_3)

								iter_298_2.color = Color.New(var_298_4, var_298_4, var_298_4)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_3 and arg_295_1.time_ < 0 + var_298_3 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.actorSpriteComps10094 then
				for iter_298_3, iter_298_4 in pairs(arg_295_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_298_4 then
						iter_298_4.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_295_1.var_.actorSpriteComps10094 = nil
			end

			local var_298_5 = 0
			local var_298_6 = 1.425

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_5 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_7 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(413101071).content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 57 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_7) / 57)

				if (57 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_7) / 57)) > 0 and var_298_6 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_5 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_5
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_6, arg_295_1.talkMaxDuration)

			if var_298_5 <= arg_295_1.time_ and arg_295_1.time_ < var_298_5 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_5) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_5 + var_298_10 and arg_295_1.time_ < var_298_5 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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
	Play413101072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 413101072
		arg_299_1.duration_ = 2.53

		local var_299_0 = {
			zh = 2.533,
			ja = 1.999999999999
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
				arg_299_0:Play413101073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10092 = arg_299_1.actors_["10092"].transform.localPosition
				arg_299_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10092", 3)

				for iter_302_0 = 0, arg_299_1.actors_["10092"].transform.childCount - 1 do
					local var_302_0 = arg_299_1.actors_["10092"].transform:GetChild(iter_302_0)

					if var_302_0.name == "split_1_1" or not string.find(var_302_0.name, "split") then
						var_302_0.gameObject:SetActive(true)
					else
						var_302_0.gameObject:SetActive(false)
					end
				end
			end

			local var_302_1 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				arg_299_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_299_1.time_ - 0) / var_302_1)
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 then
				arg_299_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_302_2 = arg_299_1.actors_["10092"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10092 == nil then
				arg_299_1.var_.actorSpriteComps10092 = var_302_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_3 = 2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_3 and not isNil(var_302_2) then
				if arg_299_1.var_.actorSpriteComps10092 then
					for iter_302_1, iter_302_2 in pairs(arg_299_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_302_2 then
							if arg_299_1.isInRecall_ then
								iter_302_2.color = Color.New(Mathf.Lerp(iter_302_2.color.r, arg_299_1.hightColor1.r, (arg_299_1.time_ - 0) / var_302_3), Mathf.Lerp(iter_302_2.color.g, arg_299_1.hightColor1.g, (arg_299_1.time_ - 0) / var_302_3), (Mathf.Lerp(iter_302_2.color.b, arg_299_1.hightColor1.b, (arg_299_1.time_ - 0) / var_302_3)))
							else
								local var_302_4 = Mathf.Lerp(iter_302_2.color.r, 1, (arg_299_1.time_ - 0) / var_302_3)

								iter_302_2.color = Color.New(var_302_4, var_302_4, var_302_4)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_3 and arg_299_1.time_ < 0 + var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10092 then
				for iter_302_3, iter_302_4 in pairs(arg_299_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_302_4 then
						iter_302_4.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_299_1.var_.actorSpriteComps10092 = nil
			end

			local var_302_5 = 0
			local var_302_6 = 0.375

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_7 = arg_299_1:GetWordFromCfg(413101072)
				local var_302_8 = arg_299_1:FormatText(var_302_7.content)

				arg_299_1.text_.text = var_302_8

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_10 = 15 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 15)

				if (15 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 15)) > 0 and var_302_6 < var_302_10 then
					arg_299_1.talkMaxDuration = var_302_10

					if var_302_10 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_5
					end
				end

				arg_299_1.text_.text = var_302_8
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101072", "story_v_out_413101.awb") ~= 0 then
					local var_302_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101072", "story_v_out_413101.awb") / 1000

					if var_302_11 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_11 + var_302_5
					end

					if var_302_7.prefab_name ~= "" and arg_299_1.actors_[var_302_7.prefab_name] ~= nil then
						local var_302_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_7.prefab_name].transform, "story_v_out_413101", "413101072", "story_v_out_413101.awb")

						arg_299_1:RecordAudio("413101072", var_302_12)
						arg_299_1:RecordAudio("413101072", var_302_12)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_413101", "413101072", "story_v_out_413101.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_413101", "413101072", "story_v_out_413101.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_13 = math.max(var_302_6, arg_299_1.talkMaxDuration)

			if var_302_5 <= arg_299_1.time_ and arg_299_1.time_ < var_302_5 + var_302_13 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_5) / var_302_13

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_5 + var_302_13 and arg_299_1.time_ < var_302_5 + var_302_13 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413101073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 413101073
		arg_303_1.duration_ = 4.63

		local var_303_0 = {
			zh = 4.3,
			ja = 4.633
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
				arg_303_0:Play413101074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos10092 = arg_303_1.actors_["10092"].transform.localPosition
				arg_303_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("10092", 2)

				for iter_306_0 = 0, arg_303_1.actors_["10092"].transform.childCount - 1 do
					local var_306_0 = arg_303_1.actors_["10092"].transform:GetChild(iter_306_0)

					if var_306_0.name == "split_1_1" or not string.find(var_306_0.name, "split") then
						var_306_0.gameObject:SetActive(true)
					else
						var_306_0.gameObject:SetActive(false)
					end
				end
			end

			local var_306_1 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_1 then
				arg_303_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_303_1.time_ - 0) / var_306_1)
			end

			if arg_303_1.time_ >= 0 + var_306_1 and arg_303_1.time_ < 0 + var_306_1 + arg_306_0 then
				arg_303_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_306_2 = arg_303_1.actors_["10022"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos10022 = var_306_2.localPosition
				var_306_2.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("10022", 4)

				for iter_306_1 = 0, var_306_2.childCount - 1 do
					local var_306_3 = var_306_2:GetChild(iter_306_1)

					if var_306_3.name == "split_6" or not string.find(var_306_3.name, "split") then
						var_306_3.gameObject:SetActive(true)
					else
						var_306_3.gameObject:SetActive(false)
					end
				end
			end

			local var_306_4 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				var_306_2.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_303_1.time_ - 0) / var_306_4)
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				var_306_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_306_5 = arg_303_1.actors_["10092"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.actorSpriteComps10092 == nil then
				arg_303_1.var_.actorSpriteComps10092 = var_306_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_6 = 2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_6 and not isNil(var_306_5) then
				if arg_303_1.var_.actorSpriteComps10092 then
					for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_306_3 then
							if arg_303_1.isInRecall_ then
								iter_306_3.color = Color.New(Mathf.Lerp(iter_306_3.color.r, arg_303_1.hightColor2.r, (arg_303_1.time_ - 0) / var_306_6), Mathf.Lerp(iter_306_3.color.g, arg_303_1.hightColor2.g, (arg_303_1.time_ - 0) / var_306_6), (Mathf.Lerp(iter_306_3.color.b, arg_303_1.hightColor2.b, (arg_303_1.time_ - 0) / var_306_6)))
							else
								local var_306_7 = Mathf.Lerp(iter_306_3.color.r, 0.5, (arg_303_1.time_ - 0) / var_306_6)

								iter_306_3.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_6 and arg_303_1.time_ < 0 + var_306_6 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.actorSpriteComps10092 then
				for iter_306_4, iter_306_5 in pairs(arg_303_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_306_5 then
						iter_306_5.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_303_1.var_.actorSpriteComps10092 = nil
			end

			local var_306_8 = arg_303_1.actors_["10022"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_8) and arg_303_1.var_.actorSpriteComps10022 == nil then
				arg_303_1.var_.actorSpriteComps10022 = var_306_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_9 = 2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_9 and not isNil(var_306_8) then
				if arg_303_1.var_.actorSpriteComps10022 then
					for iter_306_6, iter_306_7 in pairs(arg_303_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_306_7 then
							if arg_303_1.isInRecall_ then
								iter_306_7.color = Color.New(Mathf.Lerp(iter_306_7.color.r, arg_303_1.hightColor1.r, (arg_303_1.time_ - 0) / var_306_9), Mathf.Lerp(iter_306_7.color.g, arg_303_1.hightColor1.g, (arg_303_1.time_ - 0) / var_306_9), (Mathf.Lerp(iter_306_7.color.b, arg_303_1.hightColor1.b, (arg_303_1.time_ - 0) / var_306_9)))
							else
								local var_306_10 = Mathf.Lerp(iter_306_7.color.r, 1, (arg_303_1.time_ - 0) / var_306_9)

								iter_306_7.color = Color.New(var_306_10, var_306_10, var_306_10)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_9 and arg_303_1.time_ < 0 + var_306_9 + arg_306_0 and not isNil(var_306_8) and arg_303_1.var_.actorSpriteComps10022 then
				for iter_306_8, iter_306_9 in pairs(arg_303_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_306_9 then
						iter_306_9.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_303_1.var_.actorSpriteComps10022 = nil
			end

			local var_306_11 = 0
			local var_306_12 = 0.525

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_11 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_13 = arg_303_1:GetWordFromCfg(413101073)
				local var_306_14 = arg_303_1:FormatText(var_306_13.content)

				arg_303_1.text_.text = var_306_14

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_16 = 21 <= 0 and var_306_12 or var_306_12 * (utf8.len(var_306_14) / 21)

				if (21 <= 0 and var_306_12 or var_306_12 * (utf8.len(var_306_14) / 21)) > 0 and var_306_12 < var_306_16 then
					arg_303_1.talkMaxDuration = var_306_16

					if var_306_16 + var_306_11 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_16 + var_306_11
					end
				end

				arg_303_1.text_.text = var_306_14
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101073", "story_v_out_413101.awb") ~= 0 then
					local var_306_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101073", "story_v_out_413101.awb") / 1000

					if var_306_17 + var_306_11 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_17 + var_306_11
					end

					if var_306_13.prefab_name ~= "" and arg_303_1.actors_[var_306_13.prefab_name] ~= nil then
						local var_306_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_13.prefab_name].transform, "story_v_out_413101", "413101073", "story_v_out_413101.awb")

						arg_303_1:RecordAudio("413101073", var_306_18)
						arg_303_1:RecordAudio("413101073", var_306_18)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_413101", "413101073", "story_v_out_413101.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_413101", "413101073", "story_v_out_413101.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_19 = math.max(var_306_12, arg_303_1.talkMaxDuration)

			if var_306_11 <= arg_303_1.time_ and arg_303_1.time_ < var_306_11 + var_306_19 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_11) / var_306_19

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_11 + var_306_19 and arg_303_1.time_ < var_306_11 + var_306_19 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play413101074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 413101074
		arg_307_1.duration_ = 5.37

		local var_307_0 = {
			zh = 2.866,
			ja = 5.366
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
				arg_307_0:Play413101075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["10092"]) and arg_307_1.var_.actorSpriteComps10092 == nil then
				arg_307_1.var_.actorSpriteComps10092 = arg_307_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_0 = 2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["10092"]) then
				if arg_307_1.var_.actorSpriteComps10092 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_310_1 then
							if arg_307_1.isInRecall_ then
								iter_310_1.color = Color.New(Mathf.Lerp(iter_310_1.color.r, arg_307_1.hightColor1.r, (arg_307_1.time_ - 0) / var_310_0), Mathf.Lerp(iter_310_1.color.g, arg_307_1.hightColor1.g, (arg_307_1.time_ - 0) / var_310_0), (Mathf.Lerp(iter_310_1.color.b, arg_307_1.hightColor1.b, (arg_307_1.time_ - 0) / var_310_0)))
							else
								local var_310_1 = Mathf.Lerp(iter_310_1.color.r, 1, (arg_307_1.time_ - 0) / var_310_0)

								iter_310_1.color = Color.New(var_310_1, var_310_1, var_310_1)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["10092"]) and arg_307_1.var_.actorSpriteComps10092 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_310_3 then
						iter_310_3.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_307_1.var_.actorSpriteComps10092 = nil
			end

			local var_310_2 = arg_307_1.actors_["10022"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps10022 == nil then
				arg_307_1.var_.actorSpriteComps10022 = var_310_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_3 = 2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_3 and not isNil(var_310_2) then
				if arg_307_1.var_.actorSpriteComps10022 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_310_5 then
							if arg_307_1.isInRecall_ then
								iter_310_5.color = Color.New(Mathf.Lerp(iter_310_5.color.r, arg_307_1.hightColor2.r, (arg_307_1.time_ - 0) / var_310_3), Mathf.Lerp(iter_310_5.color.g, arg_307_1.hightColor2.g, (arg_307_1.time_ - 0) / var_310_3), (Mathf.Lerp(iter_310_5.color.b, arg_307_1.hightColor2.b, (arg_307_1.time_ - 0) / var_310_3)))
							else
								local var_310_4 = Mathf.Lerp(iter_310_5.color.r, 0.5, (arg_307_1.time_ - 0) / var_310_3)

								iter_310_5.color = Color.New(var_310_4, var_310_4, var_310_4)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_3 and arg_307_1.time_ < 0 + var_310_3 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps10022 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_310_7 then
						iter_310_7.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_307_1.var_.actorSpriteComps10022 = nil
			end

			local var_310_5 = 0
			local var_310_6 = 0.425

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_7 = arg_307_1:GetWordFromCfg(413101074)
				local var_310_8 = arg_307_1:FormatText(var_310_7.content)

				arg_307_1.text_.text = var_310_8

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_10 = 17 <= 0 and var_310_6 or var_310_6 * (utf8.len(var_310_8) / 17)

				if (17 <= 0 and var_310_6 or var_310_6 * (utf8.len(var_310_8) / 17)) > 0 and var_310_6 < var_310_10 then
					arg_307_1.talkMaxDuration = var_310_10

					if var_310_10 + var_310_5 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_5
					end
				end

				arg_307_1.text_.text = var_310_8
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101074", "story_v_out_413101.awb") ~= 0 then
					local var_310_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101074", "story_v_out_413101.awb") / 1000

					if var_310_11 + var_310_5 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_11 + var_310_5
					end

					if var_310_7.prefab_name ~= "" and arg_307_1.actors_[var_310_7.prefab_name] ~= nil then
						local var_310_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_7.prefab_name].transform, "story_v_out_413101", "413101074", "story_v_out_413101.awb")

						arg_307_1:RecordAudio("413101074", var_310_12)
						arg_307_1:RecordAudio("413101074", var_310_12)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_413101", "413101074", "story_v_out_413101.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_413101", "413101074", "story_v_out_413101.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_13 = math.max(var_310_6, arg_307_1.talkMaxDuration)

			if var_310_5 <= arg_307_1.time_ and arg_307_1.time_ < var_310_5 + var_310_13 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_5) / var_310_13

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_5 + var_310_13 and arg_307_1.time_ < var_310_5 + var_310_13 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play413101075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 413101075
		arg_311_1.duration_ = 3.33

		local var_311_0 = {
			zh = 2.366,
			ja = 3.333
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
				arg_311_0:Play413101076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["10092"]) and arg_311_1.var_.actorSpriteComps10092 == nil then
				arg_311_1.var_.actorSpriteComps10092 = arg_311_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_0 = 2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["10092"]) then
				if arg_311_1.var_.actorSpriteComps10092 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								iter_314_1.color = Color.New(Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor2.r, (arg_311_1.time_ - 0) / var_314_0), Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor2.g, (arg_311_1.time_ - 0) / var_314_0), (Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor2.b, (arg_311_1.time_ - 0) / var_314_0)))
							else
								local var_314_1 = Mathf.Lerp(iter_314_1.color.r, 0.5, (arg_311_1.time_ - 0) / var_314_0)

								iter_314_1.color = Color.New(var_314_1, var_314_1, var_314_1)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["10092"]) and arg_311_1.var_.actorSpriteComps10092 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_314_3 then
						iter_314_3.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_311_1.var_.actorSpriteComps10092 = nil
			end

			local var_314_2 = arg_311_1.actors_["10022"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps10022 == nil then
				arg_311_1.var_.actorSpriteComps10022 = var_314_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_3 = 2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_3 and not isNil(var_314_2) then
				if arg_311_1.var_.actorSpriteComps10022 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_314_5 then
							if arg_311_1.isInRecall_ then
								iter_314_5.color = Color.New(Mathf.Lerp(iter_314_5.color.r, arg_311_1.hightColor1.r, (arg_311_1.time_ - 0) / var_314_3), Mathf.Lerp(iter_314_5.color.g, arg_311_1.hightColor1.g, (arg_311_1.time_ - 0) / var_314_3), (Mathf.Lerp(iter_314_5.color.b, arg_311_1.hightColor1.b, (arg_311_1.time_ - 0) / var_314_3)))
							else
								local var_314_4 = Mathf.Lerp(iter_314_5.color.r, 1, (arg_311_1.time_ - 0) / var_314_3)

								iter_314_5.color = Color.New(var_314_4, var_314_4, var_314_4)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_3 and arg_311_1.time_ < 0 + var_314_3 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps10022 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_314_7 then
						iter_314_7.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_311_1.var_.actorSpriteComps10022 = nil
			end

			local var_314_5 = 0
			local var_314_6 = 0.425

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_7 = arg_311_1:GetWordFromCfg(413101075)
				local var_314_8 = arg_311_1:FormatText(var_314_7.content)

				arg_311_1.text_.text = var_314_8

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_10 = 17 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 17)

				if (17 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 17)) > 0 and var_314_6 < var_314_10 then
					arg_311_1.talkMaxDuration = var_314_10

					if var_314_10 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_5
					end
				end

				arg_311_1.text_.text = var_314_8
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101075", "story_v_out_413101.awb") ~= 0 then
					local var_314_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101075", "story_v_out_413101.awb") / 1000

					if var_314_11 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_5
					end

					if var_314_7.prefab_name ~= "" and arg_311_1.actors_[var_314_7.prefab_name] ~= nil then
						local var_314_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_7.prefab_name].transform, "story_v_out_413101", "413101075", "story_v_out_413101.awb")

						arg_311_1:RecordAudio("413101075", var_314_12)
						arg_311_1:RecordAudio("413101075", var_314_12)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_413101", "413101075", "story_v_out_413101.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_413101", "413101075", "story_v_out_413101.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_13 = math.max(var_314_6, arg_311_1.talkMaxDuration)

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_13 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_5) / var_314_13

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_5 + var_314_13 and arg_311_1.time_ < var_314_5 + var_314_13 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play413101076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 413101076
		arg_315_1.duration_ = 7.77

		local var_315_0 = {
			zh = 4.5,
			ja = 7.766
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
				arg_315_0:Play413101077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.7

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:GetWordFromCfg(413101076)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 28 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 28)

				if (28 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 28)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101076", "story_v_out_413101.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101076", "story_v_out_413101.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_out_413101", "413101076", "story_v_out_413101.awb")

						arg_315_1:RecordAudio("413101076", var_318_6)
						arg_315_1:RecordAudio("413101076", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_413101", "413101076", "story_v_out_413101.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_413101", "413101076", "story_v_out_413101.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play413101077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 413101077
		arg_319_1.duration_ = 9.7

		local var_319_0 = {
			zh = 3.966,
			ja = 9.7
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
				arg_319_0:Play413101078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos10092 = arg_319_1.actors_["10092"].transform.localPosition
				arg_319_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("10092", 2)

				for iter_322_0 = 0, arg_319_1.actors_["10092"].transform.childCount - 1 do
					local var_322_0 = arg_319_1.actors_["10092"].transform:GetChild(iter_322_0)

					if var_322_0.name == "split_1_1" or not string.find(var_322_0.name, "split") then
						var_322_0.gameObject:SetActive(true)
					else
						var_322_0.gameObject:SetActive(false)
					end
				end
			end

			local var_322_1 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 then
				arg_319_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_319_1.time_ - 0) / var_322_1)
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 then
				arg_319_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_322_2 = arg_319_1.actors_["10022"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos10022 = var_322_2.localPosition
				var_322_2.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("10022", 4)

				for iter_322_1 = 0, var_322_2.childCount - 1 do
					local var_322_3 = var_322_2:GetChild(iter_322_1)

					if var_322_3.name == "" or not string.find(var_322_3.name, "split") then
						var_322_3.gameObject:SetActive(true)
					else
						var_322_3.gameObject:SetActive(false)
					end
				end
			end

			local var_322_4 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				var_322_2.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_319_1.time_ - 0) / var_322_4)
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				var_322_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_322_5 = arg_319_1.actors_["10092"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.actorSpriteComps10092 == nil then
				arg_319_1.var_.actorSpriteComps10092 = var_322_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_6 = 2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_6 and not isNil(var_322_5) then
				if arg_319_1.var_.actorSpriteComps10092 then
					for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_322_3 then
							if arg_319_1.isInRecall_ then
								iter_322_3.color = Color.New(Mathf.Lerp(iter_322_3.color.r, arg_319_1.hightColor1.r, (arg_319_1.time_ - 0) / var_322_6), Mathf.Lerp(iter_322_3.color.g, arg_319_1.hightColor1.g, (arg_319_1.time_ - 0) / var_322_6), (Mathf.Lerp(iter_322_3.color.b, arg_319_1.hightColor1.b, (arg_319_1.time_ - 0) / var_322_6)))
							else
								local var_322_7 = Mathf.Lerp(iter_322_3.color.r, 1, (arg_319_1.time_ - 0) / var_322_6)

								iter_322_3.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_6 and arg_319_1.time_ < 0 + var_322_6 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.actorSpriteComps10092 then
				for iter_322_4, iter_322_5 in pairs(arg_319_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_322_5 then
						iter_322_5.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_319_1.var_.actorSpriteComps10092 = nil
			end

			local var_322_8 = arg_319_1.actors_["10022"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps10022 == nil then
				arg_319_1.var_.actorSpriteComps10022 = var_322_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_9 = 2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_9 and not isNil(var_322_8) then
				if arg_319_1.var_.actorSpriteComps10022 then
					for iter_322_6, iter_322_7 in pairs(arg_319_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_322_7 then
							if arg_319_1.isInRecall_ then
								iter_322_7.color = Color.New(Mathf.Lerp(iter_322_7.color.r, arg_319_1.hightColor2.r, (arg_319_1.time_ - 0) / var_322_9), Mathf.Lerp(iter_322_7.color.g, arg_319_1.hightColor2.g, (arg_319_1.time_ - 0) / var_322_9), (Mathf.Lerp(iter_322_7.color.b, arg_319_1.hightColor2.b, (arg_319_1.time_ - 0) / var_322_9)))
							else
								local var_322_10 = Mathf.Lerp(iter_322_7.color.r, 0.5, (arg_319_1.time_ - 0) / var_322_9)

								iter_322_7.color = Color.New(var_322_10, var_322_10, var_322_10)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_9 and arg_319_1.time_ < 0 + var_322_9 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps10022 then
				for iter_322_8, iter_322_9 in pairs(arg_319_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_322_9 then
						iter_322_9.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_319_1.var_.actorSpriteComps10022 = nil
			end

			local var_322_11 = 0
			local var_322_12 = 0.675

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_11 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_13 = arg_319_1:GetWordFromCfg(413101077)
				local var_322_14 = arg_319_1:FormatText(var_322_13.content)

				arg_319_1.text_.text = var_322_14

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_16 = 27 <= 0 and var_322_12 or var_322_12 * (utf8.len(var_322_14) / 27)

				if (27 <= 0 and var_322_12 or var_322_12 * (utf8.len(var_322_14) / 27)) > 0 and var_322_12 < var_322_16 then
					arg_319_1.talkMaxDuration = var_322_16

					if var_322_16 + var_322_11 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_16 + var_322_11
					end
				end

				arg_319_1.text_.text = var_322_14
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101077", "story_v_out_413101.awb") ~= 0 then
					local var_322_17 = manager.audio:GetVoiceLength("story_v_out_413101", "413101077", "story_v_out_413101.awb") / 1000

					if var_322_17 + var_322_11 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_17 + var_322_11
					end

					if var_322_13.prefab_name ~= "" and arg_319_1.actors_[var_322_13.prefab_name] ~= nil then
						local var_322_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_13.prefab_name].transform, "story_v_out_413101", "413101077", "story_v_out_413101.awb")

						arg_319_1:RecordAudio("413101077", var_322_18)
						arg_319_1:RecordAudio("413101077", var_322_18)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_413101", "413101077", "story_v_out_413101.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_413101", "413101077", "story_v_out_413101.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_19 = math.max(var_322_12, arg_319_1.talkMaxDuration)

			if var_322_11 <= arg_319_1.time_ and arg_319_1.time_ < var_322_11 + var_322_19 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_11) / var_322_19

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_11 + var_322_19 and arg_319_1.time_ < var_322_11 + var_322_19 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413101078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 413101078
		arg_323_1.duration_ = 8.83

		local var_323_0 = {
			zh = 7.3,
			ja = 8.833
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play413101079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10022 = arg_323_1.actors_["10022"].transform.localPosition
				arg_323_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10022", 4)

				for iter_326_0 = 0, arg_323_1.actors_["10022"].transform.childCount - 1 do
					local var_326_0 = arg_323_1.actors_["10022"].transform:GetChild(iter_326_0)

					if var_326_0.name == "split_6" or not string.find(var_326_0.name, "split") then
						var_326_0.gameObject:SetActive(true)
					else
						var_326_0.gameObject:SetActive(false)
					end
				end
			end

			local var_326_1 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				arg_323_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_323_1.time_ - 0) / var_326_1)
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 then
				arg_323_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_326_2 = arg_323_1.actors_["10092"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10092 == nil then
				arg_323_1.var_.actorSpriteComps10092 = var_326_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_3 = 2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.actorSpriteComps10092 then
					for iter_326_1, iter_326_2 in pairs(arg_323_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_326_2 then
							if arg_323_1.isInRecall_ then
								iter_326_2.color = Color.New(Mathf.Lerp(iter_326_2.color.r, arg_323_1.hightColor2.r, (arg_323_1.time_ - 0) / var_326_3), Mathf.Lerp(iter_326_2.color.g, arg_323_1.hightColor2.g, (arg_323_1.time_ - 0) / var_326_3), (Mathf.Lerp(iter_326_2.color.b, arg_323_1.hightColor2.b, (arg_323_1.time_ - 0) / var_326_3)))
							else
								local var_326_4 = Mathf.Lerp(iter_326_2.color.r, 0.5, (arg_323_1.time_ - 0) / var_326_3)

								iter_326_2.color = Color.New(var_326_4, var_326_4, var_326_4)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10092 then
				for iter_326_3, iter_326_4 in pairs(arg_323_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_326_4 then
						iter_326_4.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_323_1.var_.actorSpriteComps10092 = nil
			end

			local var_326_5 = arg_323_1.actors_["10022"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_5) and arg_323_1.var_.actorSpriteComps10022 == nil then
				arg_323_1.var_.actorSpriteComps10022 = var_326_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_6 = 2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_6 and not isNil(var_326_5) then
				if arg_323_1.var_.actorSpriteComps10022 then
					for iter_326_5, iter_326_6 in pairs(arg_323_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_326_6 then
							if arg_323_1.isInRecall_ then
								iter_326_6.color = Color.New(Mathf.Lerp(iter_326_6.color.r, arg_323_1.hightColor1.r, (arg_323_1.time_ - 0) / var_326_6), Mathf.Lerp(iter_326_6.color.g, arg_323_1.hightColor1.g, (arg_323_1.time_ - 0) / var_326_6), (Mathf.Lerp(iter_326_6.color.b, arg_323_1.hightColor1.b, (arg_323_1.time_ - 0) / var_326_6)))
							else
								local var_326_7 = Mathf.Lerp(iter_326_6.color.r, 1, (arg_323_1.time_ - 0) / var_326_6)

								iter_326_6.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_6 and arg_323_1.time_ < 0 + var_326_6 + arg_326_0 and not isNil(var_326_5) and arg_323_1.var_.actorSpriteComps10022 then
				for iter_326_7, iter_326_8 in pairs(arg_323_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_326_8 then
						iter_326_8.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_323_1.var_.actorSpriteComps10022 = nil
			end

			local var_326_8 = 0
			local var_326_9 = 0.9

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_10 = arg_323_1:GetWordFromCfg(413101078)
				local var_326_11 = arg_323_1:FormatText(var_326_10.content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 36 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 36)

				if (36 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 36)) > 0 and var_326_9 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_8
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101078", "story_v_out_413101.awb") ~= 0 then
					local var_326_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101078", "story_v_out_413101.awb") / 1000

					if var_326_14 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_8
					end

					if var_326_10.prefab_name ~= "" and arg_323_1.actors_[var_326_10.prefab_name] ~= nil then
						local var_326_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_10.prefab_name].transform, "story_v_out_413101", "413101078", "story_v_out_413101.awb")

						arg_323_1:RecordAudio("413101078", var_326_15)
						arg_323_1:RecordAudio("413101078", var_326_15)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_413101", "413101078", "story_v_out_413101.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_413101", "413101078", "story_v_out_413101.awb")
				end

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

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play413101079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 413101079
		arg_327_1.duration_ = 8.8

		local var_327_0 = {
			zh = 3.966,
			ja = 8.8
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
				arg_327_0:Play413101080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.575

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:GetWordFromCfg(413101079)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 23 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 23)

				if (23 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 23)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101079", "story_v_out_413101.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101079", "story_v_out_413101.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_out_413101", "413101079", "story_v_out_413101.awb")

						arg_327_1:RecordAudio("413101079", var_330_6)
						arg_327_1:RecordAudio("413101079", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_413101", "413101079", "story_v_out_413101.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_413101", "413101079", "story_v_out_413101.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play413101080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 413101080
		arg_331_1.duration_ = 9.33

		local var_331_0 = {
			zh = 6.433,
			ja = 9.333
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play413101081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos10092 = arg_331_1.actors_["10092"].transform.localPosition
				arg_331_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10092", 2)

				for iter_334_0 = 0, arg_331_1.actors_["10092"].transform.childCount - 1 do
					local var_334_0 = arg_331_1.actors_["10092"].transform:GetChild(iter_334_0)

					if var_334_0.name == "split_6" or not string.find(var_334_0.name, "split") then
						var_334_0.gameObject:SetActive(true)
					else
						var_334_0.gameObject:SetActive(false)
					end
				end
			end

			local var_334_1 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_1 then
				arg_331_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_331_1.time_ - 0) / var_334_1)
			end

			if arg_331_1.time_ >= 0 + var_334_1 and arg_331_1.time_ < 0 + var_334_1 + arg_334_0 then
				arg_331_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_334_2 = arg_331_1.actors_["10092"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.actorSpriteComps10092 == nil then
				arg_331_1.var_.actorSpriteComps10092 = var_334_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_3 = 2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_3 and not isNil(var_334_2) then
				if arg_331_1.var_.actorSpriteComps10092 then
					for iter_334_1, iter_334_2 in pairs(arg_331_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_334_2 then
							if arg_331_1.isInRecall_ then
								iter_334_2.color = Color.New(Mathf.Lerp(iter_334_2.color.r, arg_331_1.hightColor1.r, (arg_331_1.time_ - 0) / var_334_3), Mathf.Lerp(iter_334_2.color.g, arg_331_1.hightColor1.g, (arg_331_1.time_ - 0) / var_334_3), (Mathf.Lerp(iter_334_2.color.b, arg_331_1.hightColor1.b, (arg_331_1.time_ - 0) / var_334_3)))
							else
								local var_334_4 = Mathf.Lerp(iter_334_2.color.r, 1, (arg_331_1.time_ - 0) / var_334_3)

								iter_334_2.color = Color.New(var_334_4, var_334_4, var_334_4)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_3 and arg_331_1.time_ < 0 + var_334_3 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.actorSpriteComps10092 then
				for iter_334_3, iter_334_4 in pairs(arg_331_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_334_4 then
						iter_334_4.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_331_1.var_.actorSpriteComps10092 = nil
			end

			local var_334_5 = arg_331_1.actors_["10022"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.actorSpriteComps10022 == nil then
				arg_331_1.var_.actorSpriteComps10022 = var_334_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_6 = 2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_6 and not isNil(var_334_5) then
				if arg_331_1.var_.actorSpriteComps10022 then
					for iter_334_5, iter_334_6 in pairs(arg_331_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_334_6 then
							if arg_331_1.isInRecall_ then
								iter_334_6.color = Color.New(Mathf.Lerp(iter_334_6.color.r, arg_331_1.hightColor2.r, (arg_331_1.time_ - 0) / var_334_6), Mathf.Lerp(iter_334_6.color.g, arg_331_1.hightColor2.g, (arg_331_1.time_ - 0) / var_334_6), (Mathf.Lerp(iter_334_6.color.b, arg_331_1.hightColor2.b, (arg_331_1.time_ - 0) / var_334_6)))
							else
								local var_334_7 = Mathf.Lerp(iter_334_6.color.r, 0.5, (arg_331_1.time_ - 0) / var_334_6)

								iter_334_6.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_6 and arg_331_1.time_ < 0 + var_334_6 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.actorSpriteComps10022 then
				for iter_334_7, iter_334_8 in pairs(arg_331_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_334_8 then
						iter_334_8.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_331_1.var_.actorSpriteComps10022 = nil
			end

			local var_334_8 = 0
			local var_334_9 = 0.825

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_10 = arg_331_1:GetWordFromCfg(413101080)
				local var_334_11 = arg_331_1:FormatText(var_334_10.content)

				arg_331_1.text_.text = var_334_11

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_13 = 33 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 33)

				if (33 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 33)) > 0 and var_334_9 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_8
					end
				end

				arg_331_1.text_.text = var_334_11
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101080", "story_v_out_413101.awb") ~= 0 then
					local var_334_14 = manager.audio:GetVoiceLength("story_v_out_413101", "413101080", "story_v_out_413101.awb") / 1000

					if var_334_14 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_8
					end

					if var_334_10.prefab_name ~= "" and arg_331_1.actors_[var_334_10.prefab_name] ~= nil then
						local var_334_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_10.prefab_name].transform, "story_v_out_413101", "413101080", "story_v_out_413101.awb")

						arg_331_1:RecordAudio("413101080", var_334_15)
						arg_331_1:RecordAudio("413101080", var_334_15)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_413101", "413101080", "story_v_out_413101.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_413101", "413101080", "story_v_out_413101.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_16 = math.max(var_334_9, arg_331_1.talkMaxDuration)

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_16 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_8) / var_334_16

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_8 + var_334_16 and arg_331_1.time_ < var_334_8 + var_334_16 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413101081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 413101081
		arg_335_1.duration_ = 9.07

		local var_335_0 = {
			zh = 5.7,
			ja = 9.066
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
				arg_335_0:Play413101082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["10092"]) and arg_335_1.var_.actorSpriteComps10092 == nil then
				arg_335_1.var_.actorSpriteComps10092 = arg_335_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_0 = 2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["10092"]) then
				if arg_335_1.var_.actorSpriteComps10092 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								iter_338_1.color = Color.New(Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor2.r, (arg_335_1.time_ - 0) / var_338_0), Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor2.g, (arg_335_1.time_ - 0) / var_338_0), (Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor2.b, (arg_335_1.time_ - 0) / var_338_0)))
							else
								local var_338_1 = Mathf.Lerp(iter_338_1.color.r, 0.5, (arg_335_1.time_ - 0) / var_338_0)

								iter_338_1.color = Color.New(var_338_1, var_338_1, var_338_1)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["10092"]) and arg_335_1.var_.actorSpriteComps10092 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_338_3 then
						iter_338_3.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_335_1.var_.actorSpriteComps10092 = nil
			end

			local var_338_2 = arg_335_1.actors_["10022"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10022 == nil then
				arg_335_1.var_.actorSpriteComps10022 = var_338_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_3 = 2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_3 and not isNil(var_338_2) then
				if arg_335_1.var_.actorSpriteComps10022 then
					for iter_338_4, iter_338_5 in pairs(arg_335_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_338_5 then
							if arg_335_1.isInRecall_ then
								iter_338_5.color = Color.New(Mathf.Lerp(iter_338_5.color.r, arg_335_1.hightColor1.r, (arg_335_1.time_ - 0) / var_338_3), Mathf.Lerp(iter_338_5.color.g, arg_335_1.hightColor1.g, (arg_335_1.time_ - 0) / var_338_3), (Mathf.Lerp(iter_338_5.color.b, arg_335_1.hightColor1.b, (arg_335_1.time_ - 0) / var_338_3)))
							else
								local var_338_4 = Mathf.Lerp(iter_338_5.color.r, 1, (arg_335_1.time_ - 0) / var_338_3)

								iter_338_5.color = Color.New(var_338_4, var_338_4, var_338_4)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_3 and arg_335_1.time_ < 0 + var_338_3 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10022 then
				for iter_338_6, iter_338_7 in pairs(arg_335_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_338_7 then
						iter_338_7.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_335_1.var_.actorSpriteComps10022 = nil
			end

			local var_338_5 = 0
			local var_338_6 = 0.8

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_5 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_7 = arg_335_1:GetWordFromCfg(413101081)
				local var_338_8 = arg_335_1:FormatText(var_338_7.content)

				arg_335_1.text_.text = var_338_8

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_10 = 32 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 32)

				if (32 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 32)) > 0 and var_338_6 < var_338_10 then
					arg_335_1.talkMaxDuration = var_338_10

					if var_338_10 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_5
					end
				end

				arg_335_1.text_.text = var_338_8
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101081", "story_v_out_413101.awb") ~= 0 then
					local var_338_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101081", "story_v_out_413101.awb") / 1000

					if var_338_11 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_11 + var_338_5
					end

					if var_338_7.prefab_name ~= "" and arg_335_1.actors_[var_338_7.prefab_name] ~= nil then
						local var_338_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_7.prefab_name].transform, "story_v_out_413101", "413101081", "story_v_out_413101.awb")

						arg_335_1:RecordAudio("413101081", var_338_12)
						arg_335_1:RecordAudio("413101081", var_338_12)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_413101", "413101081", "story_v_out_413101.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_413101", "413101081", "story_v_out_413101.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_13 = math.max(var_338_6, arg_335_1.talkMaxDuration)

			if var_338_5 <= arg_335_1.time_ and arg_335_1.time_ < var_338_5 + var_338_13 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_5) / var_338_13

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_5 + var_338_13 and arg_335_1.time_ < var_338_5 + var_338_13 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play413101082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 413101082
		arg_339_1.duration_ = 5.93

		local var_339_0 = {
			zh = 5.933,
			ja = 5.466
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play413101083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.8

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:GetWordFromCfg(413101082)
				local var_342_2 = arg_339_1:FormatText(var_342_1.content)

				arg_339_1.text_.text = var_342_2

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 32 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 32)

				if (32 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 32)) > 0 and var_342_0 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end

				arg_339_1.text_.text = var_342_2
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101082", "story_v_out_413101.awb") ~= 0 then
					local var_342_5 = manager.audio:GetVoiceLength("story_v_out_413101", "413101082", "story_v_out_413101.awb") / 1000

					if var_342_5 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + 0
					end

					if var_342_1.prefab_name ~= "" and arg_339_1.actors_[var_342_1.prefab_name] ~= nil then
						local var_342_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_1.prefab_name].transform, "story_v_out_413101", "413101082", "story_v_out_413101.awb")

						arg_339_1:RecordAudio("413101082", var_342_6)
						arg_339_1:RecordAudio("413101082", var_342_6)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_413101", "413101082", "story_v_out_413101.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_413101", "413101082", "story_v_out_413101.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_7 and arg_339_1.time_ < 0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play413101083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 413101083
		arg_343_1.duration_ = 7.03

		local var_343_0 = {
			zh = 7.03266666666667,
			ja = 6.83266666666667
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
				arg_343_0:Play413101084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if arg_343_1.bgs_.F09f == nil then
				local var_346_0 = Object.Instantiate(arg_343_1.paintGo_)

				var_346_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F09f")
				var_346_0.name = "F09f"
				var_346_0.transform.parent = arg_343_1.stage_.transform
				var_346_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.bgs_.F09f = var_346_0
			end

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				local var_346_1 = arg_343_1.bgs_.F09f

				arg_343_1.bgs_.F09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_346_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_2 = var_346_1:GetComponent("SpriteRenderer")

				if var_346_2 and var_346_2.sprite then
					local var_346_3 = 2 * (var_346_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_346_1.transform.localScale = Vector3.New(var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "F09f" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_4 = 3.96666666666667

			if 3.96666666666667 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.allBtn_.enabled = false
			end

			if arg_343_1.time_ >= var_346_4 + 0.3 and arg_343_1.time_ < var_346_4 + 0.3 + arg_346_0 then
				arg_343_1.allBtn_.enabled = true
			end

			local var_346_5 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_6 = 2

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_6 then
				local var_346_7 = Color.New(0, 0, 0)

				var_346_7.a = Mathf.Lerp(0, 1, (arg_343_1.time_ - var_346_5) / var_346_6)
				arg_343_1.mask_.color = var_346_7
			end

			if arg_343_1.time_ >= var_346_5 + var_346_6 and arg_343_1.time_ < var_346_5 + var_346_6 + arg_346_0 then
				local var_346_8 = Color.New(0, 0, 0)

				var_346_8.a = 1
				arg_343_1.mask_.color = var_346_8
			end

			local var_346_9 = 2

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_10 = 2

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_10 then
				local var_346_11 = Color.New(0, 0, 0)

				var_346_11.a = Mathf.Lerp(1, 0, (arg_343_1.time_ - var_346_9) / var_346_10)
				arg_343_1.mask_.color = var_346_11
			end

			if arg_343_1.time_ >= var_346_9 + var_346_10 and arg_343_1.time_ < var_346_9 + var_346_10 + arg_346_0 then
				local var_346_12 = Color.New(0, 0, 0)

				arg_343_1.mask_.enabled = false
				var_346_12.a = 0
				arg_343_1.mask_.color = var_346_12
			end

			local var_346_13 = arg_343_1.actors_["10092"].transform

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				arg_343_1.var_.moveOldPos10092 = var_346_13.localPosition
				var_346_13.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10092", 7)

				for iter_346_2 = 0, var_346_13.childCount - 1 do
					local var_346_14 = var_346_13:GetChild(iter_346_2)

					if var_346_14.name == "" or not string.find(var_346_14.name, "split") then
						var_346_14.gameObject:SetActive(true)
					else
						var_346_14.gameObject:SetActive(false)
					end
				end
			end

			local var_346_15 = 0.001

			if 2 <= arg_343_1.time_ and arg_343_1.time_ < 2 + var_346_15 then
				var_346_13.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_343_1.time_ - 2) / var_346_15)
			end

			if arg_343_1.time_ >= 2 + var_346_15 and arg_343_1.time_ < 2 + var_346_15 + arg_346_0 then
				var_346_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_346_16 = arg_343_1.actors_["10022"].transform

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				arg_343_1.var_.moveOldPos10022 = var_346_16.localPosition
				var_346_16.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10022", 7)

				for iter_346_3 = 0, var_346_16.childCount - 1 do
					local var_346_17 = var_346_16:GetChild(iter_346_3)

					if var_346_17.name == "" or not string.find(var_346_17.name, "split") then
						var_346_17.gameObject:SetActive(true)
					else
						var_346_17.gameObject:SetActive(false)
					end
				end
			end

			local var_346_18 = 0.001

			if 2 <= arg_343_1.time_ and arg_343_1.time_ < 2 + var_346_18 then
				var_346_16.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_343_1.time_ - 2) / var_346_18)
			end

			if arg_343_1.time_ >= 2 + var_346_18 and arg_343_1.time_ < 2 + var_346_18 + arg_346_0 then
				var_346_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_346_19 = arg_343_1.actors_["10094"].transform

			if 3.8 < arg_343_1.time_ and arg_343_1.time_ <= 3.8 + arg_346_0 then
				arg_343_1.var_.moveOldPos10094 = var_346_19.localPosition
				var_346_19.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10094", 3)

				for iter_346_4 = 0, var_346_19.childCount - 1 do
					local var_346_20 = var_346_19:GetChild(iter_346_4)

					if var_346_20.name == "split_5" or not string.find(var_346_20.name, "split") then
						var_346_20.gameObject:SetActive(true)
					else
						var_346_20.gameObject:SetActive(false)
					end
				end
			end

			local var_346_21 = 0.001

			if 3.8 <= arg_343_1.time_ and arg_343_1.time_ < 3.8 + var_346_21 then
				var_346_19.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_343_1.time_ - 3.8) / var_346_21)
			end

			if arg_343_1.time_ >= 3.8 + var_346_21 and arg_343_1.time_ < 3.8 + var_346_21 + arg_346_0 then
				var_346_19.localPosition = Vector3.New(0, -340, -414)
			end

			local var_346_22 = arg_343_1.actors_["10094"]

			if 3.8 < arg_343_1.time_ and arg_343_1.time_ <= 3.8 + arg_346_0 and not isNil(var_346_22) and arg_343_1.var_.actorSpriteComps10094 == nil then
				arg_343_1.var_.actorSpriteComps10094 = var_346_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_23 = 2

			if 3.8 <= arg_343_1.time_ and arg_343_1.time_ < 3.8 + var_346_23 and not isNil(var_346_22) then
				if arg_343_1.var_.actorSpriteComps10094 then
					for iter_346_5, iter_346_6 in pairs(arg_343_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_346_6 then
							if arg_343_1.isInRecall_ then
								iter_346_6.color = Color.New(Mathf.Lerp(iter_346_6.color.r, arg_343_1.hightColor1.r, (arg_343_1.time_ - 3.8) / var_346_23), Mathf.Lerp(iter_346_6.color.g, arg_343_1.hightColor1.g, (arg_343_1.time_ - 3.8) / var_346_23), (Mathf.Lerp(iter_346_6.color.b, arg_343_1.hightColor1.b, (arg_343_1.time_ - 3.8) / var_346_23)))
							else
								local var_346_24 = Mathf.Lerp(iter_346_6.color.r, 1, (arg_343_1.time_ - 3.8) / var_346_23)

								iter_346_6.color = Color.New(var_346_24, var_346_24, var_346_24)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 3.8 + var_346_23 and arg_343_1.time_ < 3.8 + var_346_23 + arg_346_0 and not isNil(var_346_22) and arg_343_1.var_.actorSpriteComps10094 then
				for iter_346_7, iter_346_8 in pairs(arg_343_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_346_8 then
						iter_346_8.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps10094 = nil
			end

			if 3.8 < arg_343_1.time_ and arg_343_1.time_ <= 3.8 + arg_346_0 then
				local var_346_25 = arg_343_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_346_25 then
					arg_343_1.var_.alphaOldValue10094 = var_346_25.alpha
					arg_343_1.var_.characterEffect10094 = var_346_25
				end

				arg_343_1.var_.alphaOldValue10094 = 0
			end

			local var_346_26 = 0.3

			if 3.8 <= arg_343_1.time_ and arg_343_1.time_ < 3.8 + var_346_26 then
				if arg_343_1.var_.characterEffect10094 then
					arg_343_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_343_1.var_.alphaOldValue10094, 1, (arg_343_1.time_ - 3.8) / var_346_26)
				end
			end

			if arg_343_1.time_ >= 3.8 + var_346_26 and arg_343_1.time_ < 3.8 + var_346_26 + arg_346_0 and arg_343_1.var_.characterEffect10094 then
				arg_343_1.var_.characterEffect10094.alpha = 1
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_27 = 4.26666666666667
			local var_346_28 = 0.325

			if 4.26666666666667 < arg_343_1.time_ and arg_343_1.time_ <= var_346_27 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_29 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_29:setOnUpdate(LuaHelper.FloatAction(function(arg_347_0)
					arg_343_1.dialogCg_.alpha = arg_347_0
				end))
				var_346_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_30 = arg_343_1:GetWordFromCfg(413101083)
				local var_346_31 = arg_343_1:FormatText(var_346_30.content)

				arg_343_1.text_.text = var_346_31

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_33 = 13 <= 0 and var_346_28 or var_346_28 * (utf8.len(var_346_31) / 13)

				if (13 <= 0 and var_346_28 or var_346_28 * (utf8.len(var_346_31) / 13)) > 0 and var_346_28 < var_346_33 then
					arg_343_1.talkMaxDuration = var_346_33
					var_346_27 = var_346_27 + 0.3

					if var_346_33 + var_346_27 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_33 + var_346_27
					end
				end

				arg_343_1.text_.text = var_346_31
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101083", "story_v_out_413101.awb") ~= 0 then
					local var_346_34 = manager.audio:GetVoiceLength("story_v_out_413101", "413101083", "story_v_out_413101.awb") / 1000

					if var_346_34 + var_346_27 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_34 + var_346_27
					end

					if var_346_30.prefab_name ~= "" and arg_343_1.actors_[var_346_30.prefab_name] ~= nil then
						local var_346_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_30.prefab_name].transform, "story_v_out_413101", "413101083", "story_v_out_413101.awb")

						arg_343_1:RecordAudio("413101083", var_346_35)
						arg_343_1:RecordAudio("413101083", var_346_35)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_413101", "413101083", "story_v_out_413101.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_413101", "413101083", "story_v_out_413101.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_36 = var_346_27 + 0.3
			local var_346_37 = math.max(var_346_28, arg_343_1.talkMaxDuration)

			if var_346_27 + 0.3 <= arg_343_1.time_ and arg_343_1.time_ < var_346_36 + var_346_37 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_36) / var_346_37

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_36 + var_346_37 and arg_343_1.time_ < var_346_36 + var_346_37 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play413101084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 413101084
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play413101085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos10094 = arg_349_1.actors_["10094"].transform.localPosition
				arg_349_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_349_1:CheckSpriteTmpPos("10094", 6)

				for iter_352_0 = 0, arg_349_1.actors_["10094"].transform.childCount - 1 do
					local var_352_0 = arg_349_1.actors_["10094"].transform:GetChild(iter_352_0)

					if var_352_0.name == "" or not string.find(var_352_0.name, "split") then
						var_352_0.gameObject:SetActive(true)
					else
						var_352_0.gameObject:SetActive(false)
					end
				end
			end

			local var_352_1 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_1 then
				arg_349_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10094, Vector3.New(1500, -340, -414), (arg_349_1.time_ - 0) / var_352_1)
			end

			if arg_349_1.time_ >= 0 + var_352_1 and arg_349_1.time_ < 0 + var_352_1 + arg_352_0 then
				arg_349_1.actors_["10094"].transform.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_352_2 = arg_349_1.actors_["10094"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps10094 == nil then
				arg_349_1.var_.actorSpriteComps10094 = var_352_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_3 = 2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_3 and not isNil(var_352_2) then
				if arg_349_1.var_.actorSpriteComps10094 then
					for iter_352_1, iter_352_2 in pairs(arg_349_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_352_2 then
							if arg_349_1.isInRecall_ then
								iter_352_2.color = Color.New(Mathf.Lerp(iter_352_2.color.r, arg_349_1.hightColor2.r, (arg_349_1.time_ - 0) / var_352_3), Mathf.Lerp(iter_352_2.color.g, arg_349_1.hightColor2.g, (arg_349_1.time_ - 0) / var_352_3), (Mathf.Lerp(iter_352_2.color.b, arg_349_1.hightColor2.b, (arg_349_1.time_ - 0) / var_352_3)))
							else
								local var_352_4 = Mathf.Lerp(iter_352_2.color.r, 0.5, (arg_349_1.time_ - 0) / var_352_3)

								iter_352_2.color = Color.New(var_352_4, var_352_4, var_352_4)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_3 and arg_349_1.time_ < 0 + var_352_3 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps10094 then
				for iter_352_3, iter_352_4 in pairs(arg_349_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_352_4 then
						iter_352_4.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_349_1.var_.actorSpriteComps10094 = nil
			end

			local var_352_5 = 0
			local var_352_6 = 1.325

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_7 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(413101084).content)

				arg_349_1.text_.text = var_352_7

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 53 <= 0 and var_352_6 or var_352_6 * (utf8.len(var_352_7) / 53)

				if (53 <= 0 and var_352_6 or var_352_6 * (utf8.len(var_352_7) / 53)) > 0 and var_352_6 < var_352_9 then
					arg_349_1.talkMaxDuration = var_352_9

					if var_352_9 + var_352_5 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_5
					end
				end

				arg_349_1.text_.text = var_352_7
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = math.max(var_352_6, arg_349_1.talkMaxDuration)

			if var_352_5 <= arg_349_1.time_ and arg_349_1.time_ < var_352_5 + var_352_10 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_5) / var_352_10

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_5 + var_352_10 and arg_349_1.time_ < var_352_5 + var_352_10 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play413101085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 413101085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play413101086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 1.55

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(413101085).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 62 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 62)

				if (62 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 62)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play413101086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 413101086
		arg_357_1.duration_ = 3.93

		local var_357_0 = {
			zh = 3.433,
			ja = 3.933
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play413101087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos10094 = arg_357_1.actors_["10094"].transform.localPosition
				arg_357_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("10094", 3)

				for iter_360_0 = 0, arg_357_1.actors_["10094"].transform.childCount - 1 do
					local var_360_0 = arg_357_1.actors_["10094"].transform:GetChild(iter_360_0)

					if var_360_0.name == "" or not string.find(var_360_0.name, "split") then
						var_360_0.gameObject:SetActive(true)
					else
						var_360_0.gameObject:SetActive(false)
					end
				end
			end

			local var_360_1 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_1 then
				arg_357_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_357_1.time_ - 0) / var_360_1)
			end

			if arg_357_1.time_ >= 0 + var_360_1 and arg_357_1.time_ < 0 + var_360_1 + arg_360_0 then
				arg_357_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_360_2 = arg_357_1.actors_["10094"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps10094 == nil then
				arg_357_1.var_.actorSpriteComps10094 = var_360_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_3 = 2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_3 and not isNil(var_360_2) then
				if arg_357_1.var_.actorSpriteComps10094 then
					for iter_360_1, iter_360_2 in pairs(arg_357_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_360_2 then
							if arg_357_1.isInRecall_ then
								iter_360_2.color = Color.New(Mathf.Lerp(iter_360_2.color.r, arg_357_1.hightColor1.r, (arg_357_1.time_ - 0) / var_360_3), Mathf.Lerp(iter_360_2.color.g, arg_357_1.hightColor1.g, (arg_357_1.time_ - 0) / var_360_3), (Mathf.Lerp(iter_360_2.color.b, arg_357_1.hightColor1.b, (arg_357_1.time_ - 0) / var_360_3)))
							else
								local var_360_4 = Mathf.Lerp(iter_360_2.color.r, 1, (arg_357_1.time_ - 0) / var_360_3)

								iter_360_2.color = Color.New(var_360_4, var_360_4, var_360_4)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_3 and arg_357_1.time_ < 0 + var_360_3 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps10094 then
				for iter_360_3, iter_360_4 in pairs(arg_357_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_360_4 then
						iter_360_4.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_357_1.var_.actorSpriteComps10094 = nil
			end

			local var_360_5 = 0
			local var_360_6 = 0.325

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_7 = arg_357_1:GetWordFromCfg(413101086)
				local var_360_8 = arg_357_1:FormatText(var_360_7.content)

				arg_357_1.text_.text = var_360_8

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_10 = 13 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_8) / 13)

				if (13 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_8) / 13)) > 0 and var_360_6 < var_360_10 then
					arg_357_1.talkMaxDuration = var_360_10

					if var_360_10 + var_360_5 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_5
					end
				end

				arg_357_1.text_.text = var_360_8
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101086", "story_v_out_413101.awb") ~= 0 then
					local var_360_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101086", "story_v_out_413101.awb") / 1000

					if var_360_11 + var_360_5 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_11 + var_360_5
					end

					if var_360_7.prefab_name ~= "" and arg_357_1.actors_[var_360_7.prefab_name] ~= nil then
						local var_360_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_7.prefab_name].transform, "story_v_out_413101", "413101086", "story_v_out_413101.awb")

						arg_357_1:RecordAudio("413101086", var_360_12)
						arg_357_1:RecordAudio("413101086", var_360_12)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_413101", "413101086", "story_v_out_413101.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_413101", "413101086", "story_v_out_413101.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_13 = math.max(var_360_6, arg_357_1.talkMaxDuration)

			if var_360_5 <= arg_357_1.time_ and arg_357_1.time_ < var_360_5 + var_360_13 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_5) / var_360_13

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_5 + var_360_13 and arg_357_1.time_ < var_360_5 + var_360_13 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play413101087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 413101087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play413101088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10094 = arg_361_1.actors_["10094"].transform.localPosition
				arg_361_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10094", 7)

				for iter_364_0 = 0, arg_361_1.actors_["10094"].transform.childCount - 1 do
					local var_364_0 = arg_361_1.actors_["10094"].transform:GetChild(iter_364_0)

					if var_364_0.name == "" or not string.find(var_364_0.name, "split") then
						var_364_0.gameObject:SetActive(true)
					else
						var_364_0.gameObject:SetActive(false)
					end
				end
			end

			local var_364_1 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_1 then
				arg_361_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_361_1.time_ - 0) / var_364_1)
			end

			if arg_361_1.time_ >= 0 + var_364_1 and arg_361_1.time_ < 0 + var_364_1 + arg_364_0 then
				arg_361_1.actors_["10094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_364_2 = arg_361_1.actors_["10094"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.actorSpriteComps10094 == nil then
				arg_361_1.var_.actorSpriteComps10094 = var_364_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_3 = 2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_3 and not isNil(var_364_2) then
				if arg_361_1.var_.actorSpriteComps10094 then
					for iter_364_1, iter_364_2 in pairs(arg_361_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_364_2 then
							if arg_361_1.isInRecall_ then
								iter_364_2.color = Color.New(Mathf.Lerp(iter_364_2.color.r, arg_361_1.hightColor2.r, (arg_361_1.time_ - 0) / var_364_3), Mathf.Lerp(iter_364_2.color.g, arg_361_1.hightColor2.g, (arg_361_1.time_ - 0) / var_364_3), (Mathf.Lerp(iter_364_2.color.b, arg_361_1.hightColor2.b, (arg_361_1.time_ - 0) / var_364_3)))
							else
								local var_364_4 = Mathf.Lerp(iter_364_2.color.r, 0.5, (arg_361_1.time_ - 0) / var_364_3)

								iter_364_2.color = Color.New(var_364_4, var_364_4, var_364_4)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_3 and arg_361_1.time_ < 0 + var_364_3 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.actorSpriteComps10094 then
				for iter_364_3, iter_364_4 in pairs(arg_361_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_364_4 then
						iter_364_4.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_361_1.var_.actorSpriteComps10094 = nil
			end

			local var_364_5 = 0
			local var_364_6 = 1.05

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_5 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_7 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(413101087).content)

				arg_361_1.text_.text = var_364_7

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_9 = 42 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_7) / 42)

				if (42 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_7) / 42)) > 0 and var_364_6 < var_364_9 then
					arg_361_1.talkMaxDuration = var_364_9

					if var_364_9 + var_364_5 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_9 + var_364_5
					end
				end

				arg_361_1.text_.text = var_364_7
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_6, arg_361_1.talkMaxDuration)

			if var_364_5 <= arg_361_1.time_ and arg_361_1.time_ < var_364_5 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_5) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_5 + var_364_10 and arg_361_1.time_ < var_364_5 + var_364_10 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play413101088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 413101088
		arg_365_1.duration_ = 3.97

		local var_365_0 = {
			zh = 3.966,
			ja = 3.766
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play413101089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos10094 = arg_365_1.actors_["10094"].transform.localPosition
				arg_365_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("10094", 3)

				for iter_368_0 = 0, arg_365_1.actors_["10094"].transform.childCount - 1 do
					local var_368_0 = arg_365_1.actors_["10094"].transform:GetChild(iter_368_0)

					if var_368_0.name == "" or not string.find(var_368_0.name, "split") then
						var_368_0.gameObject:SetActive(true)
					else
						var_368_0.gameObject:SetActive(false)
					end
				end
			end

			local var_368_1 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_1 then
				arg_365_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_365_1.time_ - 0) / var_368_1)
			end

			if arg_365_1.time_ >= 0 + var_368_1 and arg_365_1.time_ < 0 + var_368_1 + arg_368_0 then
				arg_365_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_368_2 = arg_365_1.actors_["10094"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps10094 == nil then
				arg_365_1.var_.actorSpriteComps10094 = var_368_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_3 = 2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_3 and not isNil(var_368_2) then
				if arg_365_1.var_.actorSpriteComps10094 then
					for iter_368_1, iter_368_2 in pairs(arg_365_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_368_2 then
							if arg_365_1.isInRecall_ then
								iter_368_2.color = Color.New(Mathf.Lerp(iter_368_2.color.r, arg_365_1.hightColor1.r, (arg_365_1.time_ - 0) / var_368_3), Mathf.Lerp(iter_368_2.color.g, arg_365_1.hightColor1.g, (arg_365_1.time_ - 0) / var_368_3), (Mathf.Lerp(iter_368_2.color.b, arg_365_1.hightColor1.b, (arg_365_1.time_ - 0) / var_368_3)))
							else
								local var_368_4 = Mathf.Lerp(iter_368_2.color.r, 1, (arg_365_1.time_ - 0) / var_368_3)

								iter_368_2.color = Color.New(var_368_4, var_368_4, var_368_4)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_3 and arg_365_1.time_ < 0 + var_368_3 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps10094 then
				for iter_368_3, iter_368_4 in pairs(arg_365_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_368_4 then
						iter_368_4.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_365_1.var_.actorSpriteComps10094 = nil
			end

			local var_368_5 = 0
			local var_368_6 = 0.325

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_7 = arg_365_1:GetWordFromCfg(413101088)
				local var_368_8 = arg_365_1:FormatText(var_368_7.content)

				arg_365_1.text_.text = var_368_8

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_10 = 13 <= 0 and var_368_6 or var_368_6 * (utf8.len(var_368_8) / 13)

				if (13 <= 0 and var_368_6 or var_368_6 * (utf8.len(var_368_8) / 13)) > 0 and var_368_6 < var_368_10 then
					arg_365_1.talkMaxDuration = var_368_10

					if var_368_10 + var_368_5 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_10 + var_368_5
					end
				end

				arg_365_1.text_.text = var_368_8
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101088", "story_v_out_413101.awb") ~= 0 then
					local var_368_11 = manager.audio:GetVoiceLength("story_v_out_413101", "413101088", "story_v_out_413101.awb") / 1000

					if var_368_11 + var_368_5 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_11 + var_368_5
					end

					if var_368_7.prefab_name ~= "" and arg_365_1.actors_[var_368_7.prefab_name] ~= nil then
						local var_368_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_7.prefab_name].transform, "story_v_out_413101", "413101088", "story_v_out_413101.awb")

						arg_365_1:RecordAudio("413101088", var_368_12)
						arg_365_1:RecordAudio("413101088", var_368_12)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_413101", "413101088", "story_v_out_413101.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_413101", "413101088", "story_v_out_413101.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_13 = math.max(var_368_6, arg_365_1.talkMaxDuration)

			if var_368_5 <= arg_365_1.time_ and arg_365_1.time_ < var_368_5 + var_368_13 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_5) / var_368_13

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_5 + var_368_13 and arg_365_1.time_ < var_368_5 + var_368_13 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play413101089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 413101089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
			arg_369_1.auto_ = false
		end

		function arg_369_1.playNext_(arg_371_0)
			arg_369_1.onStoryFinished_()
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos10094 = arg_369_1.actors_["10094"].transform.localPosition
				arg_369_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10094", 6)

				for iter_372_0 = 0, arg_369_1.actors_["10094"].transform.childCount - 1 do
					local var_372_0 = arg_369_1.actors_["10094"].transform:GetChild(iter_372_0)

					if var_372_0.name == "" or not string.find(var_372_0.name, "split") then
						var_372_0.gameObject:SetActive(true)
					else
						var_372_0.gameObject:SetActive(false)
					end
				end
			end

			local var_372_1 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_1 then
				arg_369_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10094, Vector3.New(1500, -340, -414), (arg_369_1.time_ - 0) / var_372_1)
			end

			if arg_369_1.time_ >= 0 + var_372_1 and arg_369_1.time_ < 0 + var_372_1 + arg_372_0 then
				arg_369_1.actors_["10094"].transform.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_372_2 = arg_369_1.actors_["10094"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps10094 == nil then
				arg_369_1.var_.actorSpriteComps10094 = var_372_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_3 = 2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 and not isNil(var_372_2) then
				if arg_369_1.var_.actorSpriteComps10094 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_372_2 then
							if arg_369_1.isInRecall_ then
								iter_372_2.color = Color.New(Mathf.Lerp(iter_372_2.color.r, arg_369_1.hightColor2.r, (arg_369_1.time_ - 0) / var_372_3), Mathf.Lerp(iter_372_2.color.g, arg_369_1.hightColor2.g, (arg_369_1.time_ - 0) / var_372_3), (Mathf.Lerp(iter_372_2.color.b, arg_369_1.hightColor2.b, (arg_369_1.time_ - 0) / var_372_3)))
							else
								local var_372_4 = Mathf.Lerp(iter_372_2.color.r, 0.5, (arg_369_1.time_ - 0) / var_372_3)

								iter_372_2.color = Color.New(var_372_4, var_372_4, var_372_4)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps10094 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_372_4 then
						iter_372_4.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_369_1.var_.actorSpriteComps10094 = nil
			end

			local var_372_5 = 0
			local var_372_6 = 1.025

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_7 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(413101089).content)

				arg_369_1.text_.text = var_372_7

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_9 = 41 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_7) / 41)

				if (41 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_7) / 41)) > 0 and var_372_6 < var_372_9 then
					arg_369_1.talkMaxDuration = var_372_9

					if var_372_9 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_5
					end
				end

				arg_369_1.text_.text = var_372_7
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_10 = math.max(var_372_6, arg_369_1.talkMaxDuration)

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_10 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_5) / var_372_10

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_5 + var_372_10 and arg_369_1.time_ < var_372_5 + var_372_10 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/F09f"
	},
	voices = {
		"story_v_out_413101.awb"
	}
}
