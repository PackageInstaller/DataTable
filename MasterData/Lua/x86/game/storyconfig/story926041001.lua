return {
	Play926041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926041001
		arg_1_1.duration_ = 9.33

		local var_1_0 = {
			zh = 6.733,
			ja = 9.333
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
				arg_1_0:Play926041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I22f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I22f")
				var_4_0.name = "I22f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I22f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I22f

				arg_1_1.bgs_.I22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I22f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "128404"

			if arg_1_1.actors_["128404"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

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

			local var_4_12 = arg_1_1.actors_["128404"]

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps128404 == nil then
				arg_1_1.var_.actorSpriteComps128404 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 1.46666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.46666666666667 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps128404 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.46666666666667) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.46666666666667) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.46666666666667) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 1.46666666666667) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.46666666666667 + var_4_13 and arg_1_1.time_ < 1.46666666666667 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps128404 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps128404 = nil
			end

			local var_4_15 = arg_1_1.actors_["128404"].transform

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos128404 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("128404", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 1.46666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.46666666666667 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_1_1.time_ - 1.46666666666667) / var_4_17)
			end

			if arg_1_1.time_ >= 1.46666666666667 + var_4_17 and arg_1_1.time_ < 1.46666666666667 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["128404"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue128404 = var_4_18.alpha
					arg_1_1.var_.characterEffect128404 = var_4_18
				end

				arg_1_1.var_.alphaOldValue128404 = 0
			end

			local var_4_19 = 0.366666666666667

			if 1.46666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.46666666666667 + var_4_19 then
				if arg_1_1.var_.characterEffect128404 then
					arg_1_1.var_.characterEffect128404.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue128404, 1, (arg_1_1.time_ - 1.46666666666667) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.46666666666667 + var_4_19 and arg_1_1.time_ < 1.46666666666667 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect128404 then
				arg_1_1.var_.characterEffect128404.alpha = 1
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_27 = 2
			local var_4_28 = 0.6

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_29 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_29:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_30 = arg_1_1:GetWordFromCfg(926041001)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.text_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 24 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 24)

				if (24 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 24)) > 0 and var_4_28 < var_4_33 then
					arg_1_1.talkMaxDuration = var_4_33
					var_4_27 = var_4_27 + 0.3

					if var_4_33 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_27
					end
				end

				arg_1_1.text_.text = var_4_31
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041001", "story_v_out_926041.awb") ~= 0 then
					local var_4_34 = manager.audio:GetVoiceLength("story_v_out_926041", "926041001", "story_v_out_926041.awb") / 1000

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end

					if var_4_30.prefab_name ~= "" and arg_1_1.actors_[var_4_30.prefab_name] ~= nil then
						local var_4_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_30.prefab_name].transform, "story_v_out_926041", "926041001", "story_v_out_926041.awb")

						arg_1_1:RecordAudio("926041001", var_4_35)
						arg_1_1:RecordAudio("926041001", var_4_35)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926041", "926041001", "story_v_out_926041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926041", "926041001", "story_v_out_926041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_27 + 0.3
			local var_4_37 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_27 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play926041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926041002
		arg_9_1.duration_ = 6.17

		local var_9_0 = {
			zh = 4.533,
			ja = 6.166
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
				arg_9_0:Play926041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10144"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10144"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10144"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10144"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10144 == nil then
				arg_9_1.var_.actorSpriteComps10144 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps10144 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_12_3 then
							if arg_9_1.isInRecall_ then
								iter_12_3.color = Color.New(Mathf.Lerp(iter_12_3.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_3), Mathf.Lerp(iter_12_3.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_3), (Mathf.Lerp(iter_12_3.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_3)))
							else
								local var_12_4 = Mathf.Lerp(iter_12_3.color.r, 1, (arg_9_1.time_ - 0) / var_12_3)

								iter_12_3.color = Color.New(var_12_4, var_12_4, var_12_4)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10144 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_12_5 then
						iter_12_5.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10144 = nil
			end

			local var_12_5 = arg_9_1.actors_["128404"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps128404 == nil then
				arg_9_1.var_.actorSpriteComps128404 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps128404 then
					for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_12_7 then
							if arg_9_1.isInRecall_ then
								iter_12_7.color = Color.New(Mathf.Lerp(iter_12_7.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_6), Mathf.Lerp(iter_12_7.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_6), (Mathf.Lerp(iter_12_7.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_6)))
							else
								local var_12_7 = Mathf.Lerp(iter_12_7.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_6)

								iter_12_7.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps128404 then
				for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_12_9 then
						iter_12_9.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps128404 = nil
			end

			local var_12_8 = arg_9_1.actors_["128404"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos128404 = var_12_8.localPosition
				var_12_8.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("128404", 7)

				for iter_12_10 = 0, var_12_8.childCount - 1 do
					local var_12_9 = var_12_8:GetChild(iter_12_10)

					if var_12_9.name == "" or not string.find(var_12_9.name, "split") then
						var_12_9.gameObject:SetActive(true)
					else
						var_12_9.gameObject:SetActive(false)
					end
				end
			end

			local var_12_10 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_10 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_10)
			end

			if arg_9_1.time_ >= 0 + var_12_10 and arg_9_1.time_ < 0 + var_12_10 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_11 = arg_9_1.actors_["10144"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10144 = var_12_11.localPosition
				var_12_11.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10144", 3)

				for iter_12_11 = 0, var_12_11.childCount - 1 do
					local var_12_12 = var_12_11:GetChild(iter_12_11)

					if var_12_12.name == "" or not string.find(var_12_12.name, "split") then
						var_12_12.gameObject:SetActive(true)
					else
						var_12_12.gameObject:SetActive(false)
					end
				end
			end

			local var_12_13 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_13 then
				var_12_11.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_9_1.time_ - 0) / var_12_13)
			end

			if arg_9_1.time_ >= 0 + var_12_13 and arg_9_1.time_ < 0 + var_12_13 + arg_12_0 then
				var_12_11.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_12_14 = 0
			local var_12_15 = 0.625

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_16 = arg_9_1:GetWordFromCfg(926041002)
				local var_12_17 = arg_9_1:FormatText(var_12_16.content)

				arg_9_1.text_.text = var_12_17

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 25 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 25)

				if (25 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 25)) > 0 and var_12_15 < var_12_19 then
					arg_9_1.talkMaxDuration = var_12_19

					if var_12_19 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_14
					end
				end

				arg_9_1.text_.text = var_12_17
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041002", "story_v_out_926041.awb") ~= 0 then
					local var_12_20 = manager.audio:GetVoiceLength("story_v_out_926041", "926041002", "story_v_out_926041.awb") / 1000

					if var_12_20 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_20 + var_12_14
					end

					if var_12_16.prefab_name ~= "" and arg_9_1.actors_[var_12_16.prefab_name] ~= nil then
						local var_12_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_16.prefab_name].transform, "story_v_out_926041", "926041002", "story_v_out_926041.awb")

						arg_9_1:RecordAudio("926041002", var_12_21)
						arg_9_1:RecordAudio("926041002", var_12_21)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_926041", "926041002", "story_v_out_926041.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_926041", "926041002", "story_v_out_926041.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_22 = math.max(var_12_15, arg_9_1.talkMaxDuration)

			if var_12_14 <= arg_9_1.time_ and arg_9_1.time_ < var_12_14 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_14) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_14 + var_12_22 and arg_9_1.time_ < var_12_14 + var_12_22 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play926041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926041003
		arg_13_1.duration_ = 4.83

		local var_13_0 = {
			zh = 3.333,
			ja = 4.833
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
				arg_13_0:Play926041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.5

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(926041003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 20 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 20)

				if (20 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 20)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041003", "story_v_out_926041.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_926041", "926041003", "story_v_out_926041.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_926041", "926041003", "story_v_out_926041.awb")

						arg_13_1:RecordAudio("926041003", var_16_6)
						arg_13_1:RecordAudio("926041003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_926041", "926041003", "story_v_out_926041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_926041", "926041003", "story_v_out_926041.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play926041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926041004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play926041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10144"]) and arg_17_1.var_.actorSpriteComps10144 == nil then
				arg_17_1.var_.actorSpriteComps10144 = arg_17_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10144"]) then
				if arg_17_1.var_.actorSpriteComps10144 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10144"]) and arg_17_1.var_.actorSpriteComps10144 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps10144 = nil
			end

			local var_20_2 = 0
			local var_20_3 = 0.275

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_4 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(926041004).content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 11 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_4) / 11)

				if (11 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_4) / 11)) > 0 and var_20_3 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_7 and arg_17_1.time_ < var_20_2 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play926041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926041005
		arg_21_1.duration_ = 4.95

		local var_21_0 = {
			zh = 4.582999999999,
			ja = 4.949999999999
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
				arg_21_0:Play926041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_9000

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["128404"]) and arg_21_1.var_.actorSpriteComps128404 == nil then
				arg_21_1.var_.actorSpriteComps128404 = arg_21_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["128404"]) then
				if arg_21_1.var_.actorSpriteComps128404 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 1, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["128404"]) and arg_21_1.var_.actorSpriteComps128404 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps128404 = nil
			end

			local var_24_2 = arg_21_1.actors_["10144"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10144 = var_24_2.localPosition
				var_24_2.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10144", 7)

				for iter_24_4 = 0, var_24_2.childCount - 1 do
					local var_24_3 = var_24_2:GetChild(iter_24_4)

					if var_24_3.name == "" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_21_1.time_ - 0) / var_24_4)
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_5 = arg_21_1.actors_["128404"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos128404 = var_24_5.localPosition
				var_24_5.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("128404", 3)

				for iter_24_5 = 0, var_24_5.childCount - 1 do
					local var_24_6 = var_24_5:GetChild(iter_24_5)

					if var_24_6.name == "split_5" or not string.find(var_24_6.name, "split") then
						var_24_6.gameObject:SetActive(true)
					else
						var_24_6.gameObject:SetActive(false)
					end
				end
			end

			local var_24_7 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_21_1.time_ - 0) / var_24_7)
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_8 = arg_21_1.var_.effect74575

				if not arg_21_1.var_.effect74575 then
					var_24_8 = Object.Instantiate(Asset.Load("Widget/System/Story/ui_uistory_loading1_keep"), arg_21_1.story_ui_effectTrs_.transform)
					var_24_8.name = "74575"
					arg_21_1.var_.effect74575 = var_24_8
				else
					var_24_8.transform:SetParent(var_24_9000)
				end

				var_24_8.transform.localPosition = Vector3.New(36.27, -64.1, -264.9)
				var_24_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_24_10 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			if arg_21_1.time_ >= var_24_10 + 2 and arg_21_1.time_ < var_24_10 + 2 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_11 = arg_21_1.actors_["128404"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_24_11 then
					arg_21_1.var_.alphaOldValue128404 = var_24_11.alpha
					arg_21_1.var_.characterEffect128404 = var_24_11
				end

				arg_21_1.var_.alphaOldValue128404 = 0
			end

			local var_24_12 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_12 then
				if arg_21_1.var_.characterEffect128404 then
					arg_21_1.var_.characterEffect128404.alpha = Mathf.Lerp(arg_21_1.var_.alphaOldValue128404, 1, (arg_21_1.time_ - 0) / var_24_12)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_12 and arg_21_1.time_ < 0 + var_24_12 + arg_24_0 and arg_21_1.var_.characterEffect128404 then
				arg_21_1.var_.characterEffect128404.alpha = 1
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_13 = 1.749999999999
			local var_24_14 = 0.25

			if 1.749999999999 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_15 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_15:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_16 = arg_21_1:GetWordFromCfg(926041005)
				local var_24_17 = arg_21_1:FormatText(var_24_16.content)

				arg_21_1.text_.text = var_24_17

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_19 = 10 <= 0 and var_24_14 or var_24_14 * (utf8.len(var_24_17) / 10)

				if (10 <= 0 and var_24_14 or var_24_14 * (utf8.len(var_24_17) / 10)) > 0 and var_24_14 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19
					var_24_13 = var_24_13 + 0.3

					if var_24_19 + var_24_13 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_13
					end
				end

				arg_21_1.text_.text = var_24_17
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041005", "story_v_out_926041.awb") ~= 0 then
					local var_24_20 = manager.audio:GetVoiceLength("story_v_out_926041", "926041005", "story_v_out_926041.awb") / 1000

					if var_24_20 + var_24_13 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_20 + var_24_13
					end

					if var_24_16.prefab_name ~= "" and arg_21_1.actors_[var_24_16.prefab_name] ~= nil then
						local var_24_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_16.prefab_name].transform, "story_v_out_926041", "926041005", "story_v_out_926041.awb")

						arg_21_1:RecordAudio("926041005", var_24_21)
						arg_21_1:RecordAudio("926041005", var_24_21)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_926041", "926041005", "story_v_out_926041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_926041", "926041005", "story_v_out_926041.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = var_24_13 + 0.3
			local var_24_23 = math.max(var_24_14, arg_21_1.talkMaxDuration)

			if var_24_13 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_22 + var_24_23 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_22) / var_24_23

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_22 + var_24_23 and arg_21_1.time_ < var_24_22 + var_24_23 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
				actorName = "128404",
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
	Play926041006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 926041006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play926041007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["128404"]) and arg_27_1.var_.actorSpriteComps128404 == nil then
				arg_27_1.var_.actorSpriteComps128404 = arg_27_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["128404"]) then
				if arg_27_1.var_.actorSpriteComps128404 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								iter_30_1.color = Color.New(Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor2.r, (arg_27_1.time_ - 0) / var_30_0), Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor2.g, (arg_27_1.time_ - 0) / var_30_0), (Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor2.b, (arg_27_1.time_ - 0) / var_30_0)))
							else
								local var_30_1 = Mathf.Lerp(iter_30_1.color.r, 0.5, (arg_27_1.time_ - 0) / var_30_0)

								iter_30_1.color = Color.New(var_30_1, var_30_1, var_30_1)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["128404"]) and arg_27_1.var_.actorSpriteComps128404 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_27_1.var_.actorSpriteComps128404 = nil
			end

			local var_30_2 = 0
			local var_30_3 = 0.625

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[7].name)

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

				local var_30_4 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(926041006).content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_6 = 25 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 25)

				if (25 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 25)) > 0 and var_30_3 < var_30_6 then
					arg_27_1.talkMaxDuration = var_30_6

					if var_30_6 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_2
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_3, arg_27_1.talkMaxDuration)

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_2) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_2 + var_30_7 and arg_27_1.time_ < var_30_2 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play926041007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 926041007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play926041008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.325

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(926041007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 13 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 13)

				if (13 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 13)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play926041008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 926041008
		arg_35_1.duration_ = 5.03

		local var_35_0 = {
			zh = 4,
			ja = 5.033
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play926041009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["128404"]) and arg_35_1.var_.actorSpriteComps128404 == nil then
				arg_35_1.var_.actorSpriteComps128404 = arg_35_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["128404"]) then
				if arg_35_1.var_.actorSpriteComps128404 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								iter_38_1.color = Color.New(Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor1.r, (arg_35_1.time_ - 0) / var_38_0), Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor1.g, (arg_35_1.time_ - 0) / var_38_0), (Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor1.b, (arg_35_1.time_ - 0) / var_38_0)))
							else
								local var_38_1 = Mathf.Lerp(iter_38_1.color.r, 1, (arg_35_1.time_ - 0) / var_38_0)

								iter_38_1.color = Color.New(var_38_1, var_38_1, var_38_1)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["128404"]) and arg_35_1.var_.actorSpriteComps128404 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_38_3 then
						iter_38_3.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_35_1.var_.actorSpriteComps128404 = nil
			end

			local var_38_2 = arg_35_1.actors_["128404"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos128404 = var_38_2.localPosition
				var_38_2.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("128404", 3)

				for iter_38_4 = 0, var_38_2.childCount - 1 do
					local var_38_3 = var_38_2:GetChild(iter_38_4)

					if var_38_3.name == "" or not string.find(var_38_3.name, "split") then
						var_38_3.gameObject:SetActive(true)
					else
						var_38_3.gameObject:SetActive(false)
					end
				end
			end

			local var_38_4 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				var_38_2.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_35_1.time_ - 0) / var_38_4)
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				var_38_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				if arg_35_1.var_.effect74575 then
					Object.Destroy(arg_35_1.var_.effect74575)

					arg_35_1.var_.effect74575 = nil
				end
			end

			local var_38_6 = 0
			local var_38_7 = 0.35

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_8 = arg_35_1:GetWordFromCfg(926041008)
				local var_38_9 = arg_35_1:FormatText(var_38_8.content)

				arg_35_1.text_.text = var_38_9

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_11 = 14 <= 0 and var_38_7 or var_38_7 * (utf8.len(var_38_9) / 14)

				if (14 <= 0 and var_38_7 or var_38_7 * (utf8.len(var_38_9) / 14)) > 0 and var_38_7 < var_38_11 then
					arg_35_1.talkMaxDuration = var_38_11

					if var_38_11 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_11 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_9
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041008", "story_v_out_926041.awb") ~= 0 then
					local var_38_12 = manager.audio:GetVoiceLength("story_v_out_926041", "926041008", "story_v_out_926041.awb") / 1000

					if var_38_12 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_12 + var_38_6
					end

					if var_38_8.prefab_name ~= "" and arg_35_1.actors_[var_38_8.prefab_name] ~= nil then
						local var_38_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_8.prefab_name].transform, "story_v_out_926041", "926041008", "story_v_out_926041.awb")

						arg_35_1:RecordAudio("926041008", var_38_13)
						arg_35_1:RecordAudio("926041008", var_38_13)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_926041", "926041008", "story_v_out_926041.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_926041", "926041008", "story_v_out_926041.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_14 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_14 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_14

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_14 and arg_35_1.time_ < var_38_6 + var_38_14 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play926041009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 926041009
		arg_39_1.duration_ = 2.83

		local var_39_0 = {
			zh = 2.3,
			ja = 2.833
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
				arg_39_0:Play926041010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if arg_39_1.actors_["106103"] == nil then
				local var_42_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

				if not isNil(var_42_0) then
					local var_42_1 = Object.Instantiate(var_42_0, arg_39_1.canvasGo_.transform)

					var_42_1.transform:SetSiblingIndex(1)

					var_42_1.name = "106103"
					var_42_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_39_1.actors_["106103"] = var_42_1

					if arg_39_1.isInRecall_ then
						for iter_42_0, iter_42_1 in ipairs((var_42_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_42_1.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_42_2 = arg_39_1.actors_["106103"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps106103 == nil then
				arg_39_1.var_.actorSpriteComps106103 = var_42_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_3 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 and not isNil(var_42_2) then
				if arg_39_1.var_.actorSpriteComps106103 then
					for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_42_3 then
							if arg_39_1.isInRecall_ then
								iter_42_3.color = Color.New(Mathf.Lerp(iter_42_3.color.r, arg_39_1.hightColor1.r, (arg_39_1.time_ - 0) / var_42_3), Mathf.Lerp(iter_42_3.color.g, arg_39_1.hightColor1.g, (arg_39_1.time_ - 0) / var_42_3), (Mathf.Lerp(iter_42_3.color.b, arg_39_1.hightColor1.b, (arg_39_1.time_ - 0) / var_42_3)))
							else
								local var_42_4 = Mathf.Lerp(iter_42_3.color.r, 1, (arg_39_1.time_ - 0) / var_42_3)

								iter_42_3.color = Color.New(var_42_4, var_42_4, var_42_4)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps106103 then
				for iter_42_4, iter_42_5 in pairs(arg_39_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_42_5 then
						iter_42_5.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_39_1.var_.actorSpriteComps106103 = nil
			end

			local var_42_5 = arg_39_1.actors_["128404"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.actorSpriteComps128404 == nil then
				arg_39_1.var_.actorSpriteComps128404 = var_42_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_6 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_6 and not isNil(var_42_5) then
				if arg_39_1.var_.actorSpriteComps128404 then
					for iter_42_6, iter_42_7 in pairs(arg_39_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_42_7 then
							if arg_39_1.isInRecall_ then
								iter_42_7.color = Color.New(Mathf.Lerp(iter_42_7.color.r, arg_39_1.hightColor2.r, (arg_39_1.time_ - 0) / var_42_6), Mathf.Lerp(iter_42_7.color.g, arg_39_1.hightColor2.g, (arg_39_1.time_ - 0) / var_42_6), (Mathf.Lerp(iter_42_7.color.b, arg_39_1.hightColor2.b, (arg_39_1.time_ - 0) / var_42_6)))
							else
								local var_42_7 = Mathf.Lerp(iter_42_7.color.r, 0.5, (arg_39_1.time_ - 0) / var_42_6)

								iter_42_7.color = Color.New(var_42_7, var_42_7, var_42_7)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_6 and arg_39_1.time_ < 0 + var_42_6 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.actorSpriteComps128404 then
				for iter_42_8, iter_42_9 in pairs(arg_39_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_42_9 then
						iter_42_9.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_39_1.var_.actorSpriteComps128404 = nil
			end

			local var_42_8 = 0
			local var_42_9 = 0.2

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_10 = arg_39_1:GetWordFromCfg(926041009)
				local var_42_11 = arg_39_1:FormatText(var_42_10.content)

				arg_39_1.text_.text = var_42_11

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 8 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 8)

				if (8 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 8)) > 0 and var_42_9 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_11
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041009", "story_v_out_926041.awb") ~= 0 then
					local var_42_14 = manager.audio:GetVoiceLength("story_v_out_926041", "926041009", "story_v_out_926041.awb") / 1000

					if var_42_14 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_14 + var_42_8
					end

					if var_42_10.prefab_name ~= "" and arg_39_1.actors_[var_42_10.prefab_name] ~= nil then
						local var_42_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_10.prefab_name].transform, "story_v_out_926041", "926041009", "story_v_out_926041.awb")

						arg_39_1:RecordAudio("926041009", var_42_15)
						arg_39_1:RecordAudio("926041009", var_42_15)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_926041", "926041009", "story_v_out_926041.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_926041", "926041009", "story_v_out_926041.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_9, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_16 and arg_39_1.time_ < var_42_8 + var_42_16 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play926041010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 926041010
		arg_43_1.duration_ = 8.77

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play926041011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 2 < arg_43_1.time_ and arg_43_1.time_ <= 2 + arg_46_0 then
				local var_46_0 = arg_43_1.bgs_.I22f

				arg_43_1.bgs_.I22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_46_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_1 = var_46_0:GetComponent("SpriteRenderer")

				if var_46_1 and var_46_1.sprite then
					local var_46_2 = 2 * (var_46_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_46_0.transform.localScale = Vector3.New(var_46_2 / var_46_1.sprite.bounds.size.y < var_46_2 * manager.ui.mainCameraCom_.aspect / var_46_1.sprite.bounds.size.x and var_46_2 * manager.ui.mainCameraCom_.aspect / var_46_1.sprite.bounds.size.x or var_46_2 / var_46_1.sprite.bounds.size.y, var_46_2 / var_46_1.sprite.bounds.size.y < var_46_2 * manager.ui.mainCameraCom_.aspect / var_46_1.sprite.bounds.size.x and var_46_2 * manager.ui.mainCameraCom_.aspect / var_46_1.sprite.bounds.size.x or var_46_2 / var_46_1.sprite.bounds.size.y, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "I22f" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_3 = 2

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_3 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			if arg_43_1.time_ >= var_46_3 + 0.3 and arg_43_1.time_ < var_46_3 + 0.3 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_4 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_5 = 2

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_5 then
				local var_46_6 = Color.New(0, 0, 0)

				var_46_6.a = Mathf.Lerp(0, 1, (arg_43_1.time_ - var_46_4) / var_46_5)
				arg_43_1.mask_.color = var_46_6
			end

			if arg_43_1.time_ >= var_46_4 + var_46_5 and arg_43_1.time_ < var_46_4 + var_46_5 + arg_46_0 then
				local var_46_7 = Color.New(0, 0, 0)

				var_46_7.a = 1
				arg_43_1.mask_.color = var_46_7
			end

			local var_46_8 = 2

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_9 = 2

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_9 then
				local var_46_10 = Color.New(0, 0, 0)

				var_46_10.a = Mathf.Lerp(1, 0, (arg_43_1.time_ - var_46_8) / var_46_9)
				arg_43_1.mask_.color = var_46_10
			end

			if arg_43_1.time_ >= var_46_8 + var_46_9 and arg_43_1.time_ < var_46_8 + var_46_9 + arg_46_0 then
				local var_46_11 = Color.New(0, 0, 0)

				arg_43_1.mask_.enabled = false
				var_46_11.a = 0
				arg_43_1.mask_.color = var_46_11
			end

			local var_46_12 = arg_43_1.actors_["106103"]

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= 2 + arg_46_0 and not isNil(var_46_12) and arg_43_1.var_.actorSpriteComps106103 == nil then
				arg_43_1.var_.actorSpriteComps106103 = var_46_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_13 = 0.2

			if 2 <= arg_43_1.time_ and arg_43_1.time_ < 2 + var_46_13 and not isNil(var_46_12) then
				if arg_43_1.var_.actorSpriteComps106103 then
					for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_46_3 then
							if arg_43_1.isInRecall_ then
								iter_46_3.color = Color.New(Mathf.Lerp(iter_46_3.color.r, arg_43_1.hightColor2.r, (arg_43_1.time_ - 2) / var_46_13), Mathf.Lerp(iter_46_3.color.g, arg_43_1.hightColor2.g, (arg_43_1.time_ - 2) / var_46_13), (Mathf.Lerp(iter_46_3.color.b, arg_43_1.hightColor2.b, (arg_43_1.time_ - 2) / var_46_13)))
							else
								local var_46_14 = Mathf.Lerp(iter_46_3.color.r, 0.5, (arg_43_1.time_ - 2) / var_46_13)

								iter_46_3.color = Color.New(var_46_14, var_46_14, var_46_14)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 2 + var_46_13 and arg_43_1.time_ < 2 + var_46_13 + arg_46_0 and not isNil(var_46_12) and arg_43_1.var_.actorSpriteComps106103 then
				for iter_46_4, iter_46_5 in pairs(arg_43_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_46_5 then
						iter_46_5.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_43_1.var_.actorSpriteComps106103 = nil
			end

			local var_46_15 = arg_43_1.actors_["128404"].transform

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= 2 + arg_46_0 then
				arg_43_1.var_.moveOldPos128404 = var_46_15.localPosition
				var_46_15.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("128404", 7)

				for iter_46_6 = 0, var_46_15.childCount - 1 do
					local var_46_16 = var_46_15:GetChild(iter_46_6)

					if var_46_16.name == "" or not string.find(var_46_16.name, "split") then
						var_46_16.gameObject:SetActive(true)
					else
						var_46_16.gameObject:SetActive(false)
					end
				end
			end

			local var_46_17 = 0.001

			if 2 <= arg_43_1.time_ and arg_43_1.time_ < 2 + var_46_17 then
				var_46_15.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_43_1.time_ - 2) / var_46_17)
			end

			if arg_43_1.time_ >= 2 + var_46_17 and arg_43_1.time_ < 2 + var_46_17 + arg_46_0 then
				var_46_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_18 = 3.76666666666667
			local var_46_19 = 0.9

			if 3.76666666666667 < arg_43_1.time_ and arg_43_1.time_ <= var_46_18 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_20 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_20:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_21 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(926041010).content)

				arg_43_1.text_.text = var_46_21

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_23 = 36 <= 0 and var_46_19 or var_46_19 * (utf8.len(var_46_21) / 36)

				if (36 <= 0 and var_46_19 or var_46_19 * (utf8.len(var_46_21) / 36)) > 0 and var_46_19 < var_46_23 then
					arg_43_1.talkMaxDuration = var_46_23
					var_46_18 = var_46_18 + 0.3

					if var_46_23 + var_46_18 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_23 + var_46_18
					end
				end

				arg_43_1.text_.text = var_46_21
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_24 = var_46_18 + 0.3
			local var_46_25 = math.max(var_46_19, arg_43_1.talkMaxDuration)

			if var_46_18 + 0.3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_24 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_24) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_24 + var_46_25 and arg_43_1.time_ < var_46_24 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play926041011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926041011
		arg_49_1.duration_ = 7.37

		local var_49_0 = {
			zh = 7.366,
			ja = 7.166
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
				arg_49_0:Play926041012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.actors_["106603"] == nil then
				local var_52_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_52_0) then
					local var_52_1 = Object.Instantiate(var_52_0, arg_49_1.canvasGo_.transform)

					var_52_1.transform:SetSiblingIndex(1)

					var_52_1.name = "106603"
					var_52_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_49_1.actors_["106603"] = var_52_1

					if arg_49_1.isInRecall_ then
						for iter_52_0, iter_52_1 in ipairs((var_52_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_52_1.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_52_2 = arg_49_1.actors_["106603"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps106603 == nil then
				arg_49_1.var_.actorSpriteComps106603 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps106603 then
					for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_52_3 then
							if arg_49_1.isInRecall_ then
								iter_52_3.color = Color.New(Mathf.Lerp(iter_52_3.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_3.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_3.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_3.color.r, 1, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_3.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps106603 then
				for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_52_5 then
						iter_52_5.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps106603 = nil
			end

			local var_52_5 = 0
			local var_52_6 = 0.45

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106603_split_1")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_7 = arg_49_1:GetWordFromCfg(926041011)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 18 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 18)

				if (18 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 18)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041011", "story_v_out_926041.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_926041", "926041011", "story_v_out_926041.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_926041", "926041011", "story_v_out_926041.awb")

						arg_49_1:RecordAudio("926041011", var_52_12)
						arg_49_1:RecordAudio("926041011", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926041", "926041011", "story_v_out_926041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926041", "926041011", "story_v_out_926041.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_13 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_13 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_13

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_13 and arg_49_1.time_ < var_52_5 + var_52_13 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play926041012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926041012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play926041013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["106603"]) and arg_53_1.var_.actorSpriteComps106603 == nil then
				arg_53_1.var_.actorSpriteComps106603 = arg_53_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["106603"]) then
				if arg_53_1.var_.actorSpriteComps106603 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["106603"]) and arg_53_1.var_.actorSpriteComps106603 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps106603 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 0.825

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(926041012).content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 33 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 33)

				if (33 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 33)) > 0 and var_56_3 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_7 and arg_53_1.time_ < var_56_2 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play926041013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926041013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play926041014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.8

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(926041013).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 32 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 32)

				if (32 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 32)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play926041014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926041014
		arg_61_1.duration_ = 4.3

		local var_61_0 = {
			zh = 2.7,
			ja = 4.3
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
				arg_61_0:Play926041015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["128404"]) and arg_61_1.var_.actorSpriteComps128404 == nil then
				arg_61_1.var_.actorSpriteComps128404 = arg_61_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["128404"]) then
				if arg_61_1.var_.actorSpriteComps128404 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 1, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["128404"]) and arg_61_1.var_.actorSpriteComps128404 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps128404 = nil
			end

			local var_64_2 = arg_61_1.actors_["128404"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos128404 = var_64_2.localPosition
				var_64_2.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("128404", 3)

				for iter_64_4 = 0, var_64_2.childCount - 1 do
					local var_64_3 = var_64_2:GetChild(iter_64_4)

					if var_64_3.name == "split_5" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_2.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_61_1.time_ - 0) / var_64_4)
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_64_5 = 0
			local var_64_6 = 0.35

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(926041014)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 14 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 14)

				if (14 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 14)) > 0 and var_64_6 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041014", "story_v_out_926041.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_926041", "926041014", "story_v_out_926041.awb") / 1000

					if var_64_11 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_5
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_926041", "926041014", "story_v_out_926041.awb")

						arg_61_1:RecordAudio("926041014", var_64_12)
						arg_61_1:RecordAudio("926041014", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_926041", "926041014", "story_v_out_926041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_926041", "926041014", "story_v_out_926041.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_13 and arg_61_1.time_ < var_64_5 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play926041015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926041015
		arg_65_1.duration_ = 4.43

		local var_65_0 = {
			zh = 3.166,
			ja = 4.433
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
				arg_65_0:Play926041016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10144"]) and arg_65_1.var_.actorSpriteComps10144 == nil then
				arg_65_1.var_.actorSpriteComps10144 = arg_65_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10144"]) then
				if arg_65_1.var_.actorSpriteComps10144 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 1, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10144"]) and arg_65_1.var_.actorSpriteComps10144 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10144 = nil
			end

			local var_68_2 = arg_65_1.actors_["128404"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps128404 == nil then
				arg_65_1.var_.actorSpriteComps128404 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps128404 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								iter_68_5.color = Color.New(Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_5.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_5.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps128404 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_68_7 then
						iter_68_7.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps128404 = nil
			end

			local var_68_5 = arg_65_1.actors_["128404"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos128404 = var_68_5.localPosition
				var_68_5.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("128404", 7)

				for iter_68_8 = 0, var_68_5.childCount - 1 do
					local var_68_6 = var_68_5:GetChild(iter_68_8)

					if var_68_6.name == "" or not string.find(var_68_6.name, "split") then
						var_68_6.gameObject:SetActive(true)
					else
						var_68_6.gameObject:SetActive(false)
					end
				end
			end

			local var_68_7 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_65_1.time_ - 0) / var_68_7)
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_8 = arg_65_1.actors_["10144"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10144 = var_68_8.localPosition
				var_68_8.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10144", 3)

				for iter_68_9 = 0, var_68_8.childCount - 1 do
					local var_68_9 = var_68_8:GetChild(iter_68_9)

					if var_68_9.name == "" or not string.find(var_68_9.name, "split") then
						var_68_9.gameObject:SetActive(true)
					else
						var_68_9.gameObject:SetActive(false)
					end
				end
			end

			local var_68_10 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_10 then
				var_68_8.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_65_1.time_ - 0) / var_68_10)
			end

			if arg_65_1.time_ >= 0 + var_68_10 and arg_65_1.time_ < 0 + var_68_10 + arg_68_0 then
				var_68_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_68_11 = 0
			local var_68_12 = 0.425

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_13 = arg_65_1:GetWordFromCfg(926041015)
				local var_68_14 = arg_65_1:FormatText(var_68_13.content)

				arg_65_1.text_.text = var_68_14

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_16 = 17 <= 0 and var_68_12 or var_68_12 * (utf8.len(var_68_14) / 17)

				if (17 <= 0 and var_68_12 or var_68_12 * (utf8.len(var_68_14) / 17)) > 0 and var_68_12 < var_68_16 then
					arg_65_1.talkMaxDuration = var_68_16

					if var_68_16 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_11
					end
				end

				arg_65_1.text_.text = var_68_14
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041015", "story_v_out_926041.awb") ~= 0 then
					local var_68_17 = manager.audio:GetVoiceLength("story_v_out_926041", "926041015", "story_v_out_926041.awb") / 1000

					if var_68_17 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_11
					end

					if var_68_13.prefab_name ~= "" and arg_65_1.actors_[var_68_13.prefab_name] ~= nil then
						local var_68_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_13.prefab_name].transform, "story_v_out_926041", "926041015", "story_v_out_926041.awb")

						arg_65_1:RecordAudio("926041015", var_68_18)
						arg_65_1:RecordAudio("926041015", var_68_18)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_926041", "926041015", "story_v_out_926041.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_926041", "926041015", "story_v_out_926041.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_19 = math.max(var_68_12, arg_65_1.talkMaxDuration)

			if var_68_11 <= arg_65_1.time_ and arg_65_1.time_ < var_68_11 + var_68_19 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_11) / var_68_19

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_11 + var_68_19 and arg_65_1.time_ < var_68_11 + var_68_19 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play926041016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926041016
		arg_69_1.duration_ = 10.4

		local var_69_0 = {
			zh = 10.4,
			ja = 8.466
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
				arg_69_0:Play926041017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["106103"]) and arg_69_1.var_.actorSpriteComps106103 == nil then
				arg_69_1.var_.actorSpriteComps106103 = arg_69_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["106103"]) then
				if arg_69_1.var_.actorSpriteComps106103 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								iter_72_1.color = Color.New(Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_0), Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_0), (Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_0)))
							else
								local var_72_1 = Mathf.Lerp(iter_72_1.color.r, 1, (arg_69_1.time_ - 0) / var_72_0)

								iter_72_1.color = Color.New(var_72_1, var_72_1, var_72_1)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["106103"]) and arg_69_1.var_.actorSpriteComps106103 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps106103 = nil
			end

			local var_72_2 = arg_69_1.actors_["10144"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10144 == nil then
				arg_69_1.var_.actorSpriteComps10144 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps10144 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								iter_72_5.color = Color.New(Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_5.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_5.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10144 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_72_7 then
						iter_72_7.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10144 = nil
			end

			local var_72_5 = arg_69_1.actors_["10144"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10144 = var_72_5.localPosition
				var_72_5.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10144", 7)

				for iter_72_8 = 0, var_72_5.childCount - 1 do
					local var_72_6 = var_72_5:GetChild(iter_72_8)

					if var_72_6.name == "" or not string.find(var_72_6.name, "split") then
						var_72_6.gameObject:SetActive(true)
					else
						var_72_6.gameObject:SetActive(false)
					end
				end
			end

			local var_72_7 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_69_1.time_ - 0) / var_72_7)
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_8 = arg_69_1.actors_["106103"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos106103 = var_72_8.localPosition
				var_72_8.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("106103", 3)

				for iter_72_9 = 0, var_72_8.childCount - 1 do
					local var_72_9 = var_72_8:GetChild(iter_72_9)

					if var_72_9.name == "split_2" or not string.find(var_72_9.name, "split") then
						var_72_9.gameObject:SetActive(true)
					else
						var_72_9.gameObject:SetActive(false)
					end
				end
			end

			local var_72_10 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_10 then
				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_69_1.time_ - 0) / var_72_10)
			end

			if arg_69_1.time_ >= 0 + var_72_10 and arg_69_1.time_ < 0 + var_72_10 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_72_11 = 0
			local var_72_12 = 1.2

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_13 = arg_69_1:GetWordFromCfg(926041016)
				local var_72_14 = arg_69_1:FormatText(var_72_13.content)

				arg_69_1.text_.text = var_72_14

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 48 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 48)

				if (48 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 48)) > 0 and var_72_12 < var_72_16 then
					arg_69_1.talkMaxDuration = var_72_16

					if var_72_16 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_14
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041016", "story_v_out_926041.awb") ~= 0 then
					local var_72_17 = manager.audio:GetVoiceLength("story_v_out_926041", "926041016", "story_v_out_926041.awb") / 1000

					if var_72_17 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_11
					end

					if var_72_13.prefab_name ~= "" and arg_69_1.actors_[var_72_13.prefab_name] ~= nil then
						local var_72_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_13.prefab_name].transform, "story_v_out_926041", "926041016", "story_v_out_926041.awb")

						arg_69_1:RecordAudio("926041016", var_72_18)
						arg_69_1:RecordAudio("926041016", var_72_18)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_926041", "926041016", "story_v_out_926041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_926041", "926041016", "story_v_out_926041.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_19 = math.max(var_72_12, arg_69_1.talkMaxDuration)

			if var_72_11 <= arg_69_1.time_ and arg_69_1.time_ < var_72_11 + var_72_19 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_11) / var_72_19

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_11 + var_72_19 and arg_69_1.time_ < var_72_11 + var_72_19 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play926041017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926041017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play926041018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["106103"]) and arg_73_1.var_.actorSpriteComps106103 == nil then
				arg_73_1.var_.actorSpriteComps106103 = arg_73_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["106103"]) then
				if arg_73_1.var_.actorSpriteComps106103 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["106103"]) and arg_73_1.var_.actorSpriteComps106103 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps106103 = nil
			end

			local var_76_2 = 0
			local var_76_3 = 0.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_4 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(926041017).content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 8 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 8)

				if (8 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 8)) > 0 and var_76_3 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_7 and arg_73_1.time_ < var_76_2 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play926041018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926041018
		arg_77_1.duration_ = 5.53

		local var_77_0 = {
			zh = 5.533,
			ja = 5.466
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
				arg_77_0:Play926041019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.actors_["104701"] == nil then
				local var_80_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_80_0) then
					local var_80_1 = Object.Instantiate(var_80_0, arg_77_1.canvasGo_.transform)

					var_80_1.transform:SetSiblingIndex(1)

					var_80_1.name = "104701"
					var_80_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_77_1.actors_["104701"] = var_80_1

					if arg_77_1.isInRecall_ then
						for iter_80_0, iter_80_1 in ipairs((var_80_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_80_1.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_80_2 = arg_77_1.actors_["104701"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps104701 == nil then
				arg_77_1.var_.actorSpriteComps104701 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps104701 then
					for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_80_3 then
							if arg_77_1.isInRecall_ then
								iter_80_3.color = Color.New(Mathf.Lerp(iter_80_3.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_3.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_3.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_3.color.r, 1, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_3.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps104701 then
				for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_80_5 then
						iter_80_5.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps104701 = nil
			end

			local var_80_5 = arg_77_1.actors_["106103"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos106103 = var_80_5.localPosition
				var_80_5.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("106103", 7)

				for iter_80_6 = 0, var_80_5.childCount - 1 do
					local var_80_6 = var_80_5:GetChild(iter_80_6)

					if var_80_6.name == "" or not string.find(var_80_6.name, "split") then
						var_80_6.gameObject:SetActive(true)
					else
						var_80_6.gameObject:SetActive(false)
					end
				end
			end

			local var_80_7 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_77_1.time_ - 0) / var_80_7)
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_80_8 = arg_77_1.actors_["104701"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos104701 = var_80_8.localPosition
				var_80_8.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("104701", 3)

				for iter_80_7 = 0, var_80_8.childCount - 1 do
					local var_80_9 = var_80_8:GetChild(iter_80_7)

					if var_80_9.name == "" or not string.find(var_80_9.name, "split") then
						var_80_9.gameObject:SetActive(true)
					else
						var_80_9.gameObject:SetActive(false)
					end
				end
			end

			local var_80_10 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_10 then
				var_80_8.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_77_1.time_ - 0) / var_80_10)
			end

			if arg_77_1.time_ >= 0 + var_80_10 and arg_77_1.time_ < 0 + var_80_10 + arg_80_0 then
				var_80_8.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_80_11 = 0
			local var_80_12 = 0.575

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:GetWordFromCfg(926041018)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_16 = 25 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_14) / 25)

				if (25 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_14) / 25)) > 0 and var_80_12 < var_80_16 then
					arg_77_1.talkMaxDuration = var_80_16

					if var_80_16 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_11
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041018", "story_v_out_926041.awb") ~= 0 then
					local var_80_17 = manager.audio:GetVoiceLength("story_v_out_926041", "926041018", "story_v_out_926041.awb") / 1000

					if var_80_17 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_11
					end

					if var_80_13.prefab_name ~= "" and arg_77_1.actors_[var_80_13.prefab_name] ~= nil then
						local var_80_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_13.prefab_name].transform, "story_v_out_926041", "926041018", "story_v_out_926041.awb")

						arg_77_1:RecordAudio("926041018", var_80_18)
						arg_77_1:RecordAudio("926041018", var_80_18)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_926041", "926041018", "story_v_out_926041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_926041", "926041018", "story_v_out_926041.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_19 = math.max(var_80_12, arg_77_1.talkMaxDuration)

			if var_80_11 <= arg_77_1.time_ and arg_77_1.time_ < var_80_11 + var_80_19 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_11) / var_80_19

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_11 + var_80_19 and arg_77_1.time_ < var_80_11 + var_80_19 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play926041019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 926041019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play926041020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["104701"]) and arg_81_1.var_.actorSpriteComps104701 == nil then
				arg_81_1.var_.actorSpriteComps104701 = arg_81_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["104701"]) then
				if arg_81_1.var_.actorSpriteComps104701 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								iter_84_1.color = Color.New(Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_0), Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_0), (Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_0)))
							else
								local var_84_1 = Mathf.Lerp(iter_84_1.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_0)

								iter_84_1.color = Color.New(var_84_1, var_84_1, var_84_1)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["104701"]) and arg_81_1.var_.actorSpriteComps104701 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps104701 = nil
			end

			local var_84_2 = 0
			local var_84_3 = 0.35

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_4 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(926041019).content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 14 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 14)

				if (14 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 14)) > 0 and var_84_3 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_7 and arg_81_1.time_ < var_84_2 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play926041020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 926041020
		arg_85_1.duration_ = 8.6

		local var_85_0 = {
			zh = 7.266,
			ja = 8.6
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
				arg_85_0:Play926041021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10144"]) and arg_85_1.var_.actorSpriteComps10144 == nil then
				arg_85_1.var_.actorSpriteComps10144 = arg_85_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10144"]) then
				if arg_85_1.var_.actorSpriteComps10144 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 1, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10144"]) and arg_85_1.var_.actorSpriteComps10144 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10144 = nil
			end

			local var_88_2 = arg_85_1.actors_["10144"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10144 = var_88_2.localPosition
				var_88_2.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10144", 3)

				for iter_88_4 = 0, var_88_2.childCount - 1 do
					local var_88_3 = var_88_2:GetChild(iter_88_4)

					if var_88_3.name == "" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_2.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_85_1.time_ - 0) / var_88_4)
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_88_5 = 0
			local var_88_6 = 1.025

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(926041020)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 41 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 41)

				if (41 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 41)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041020", "story_v_out_926041.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_926041", "926041020", "story_v_out_926041.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_926041", "926041020", "story_v_out_926041.awb")

						arg_85_1:RecordAudio("926041020", var_88_12)
						arg_85_1:RecordAudio("926041020", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_926041", "926041020", "story_v_out_926041.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_926041", "926041020", "story_v_out_926041.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_13 and arg_85_1.time_ < var_88_5 + var_88_13 + arg_88_0 then
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
	Play926041021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 926041021
		arg_89_1.duration_ = 7.27

		local var_89_0 = {
			zh = 4,
			ja = 7.266
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
				arg_89_0:Play926041022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["128404"]) and arg_89_1.var_.actorSpriteComps128404 == nil then
				arg_89_1.var_.actorSpriteComps128404 = arg_89_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["128404"]) then
				if arg_89_1.var_.actorSpriteComps128404 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								iter_92_1.color = Color.New(Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_0), Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_0), (Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_0)))
							else
								local var_92_1 = Mathf.Lerp(iter_92_1.color.r, 1, (arg_89_1.time_ - 0) / var_92_0)

								iter_92_1.color = Color.New(var_92_1, var_92_1, var_92_1)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["128404"]) and arg_89_1.var_.actorSpriteComps128404 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps128404 = nil
			end

			local var_92_2 = arg_89_1.actors_["10144"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10144 == nil then
				arg_89_1.var_.actorSpriteComps10144 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps10144 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								iter_92_5.color = Color.New(Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_5.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_5.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10144 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_92_7 then
						iter_92_7.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps10144 = nil
			end

			local var_92_5 = arg_89_1.actors_["10144"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10144 = var_92_5.localPosition
				var_92_5.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10144", 7)

				for iter_92_8 = 0, var_92_5.childCount - 1 do
					local var_92_6 = var_92_5:GetChild(iter_92_8)

					if var_92_6.name == "" or not string.find(var_92_6.name, "split") then
						var_92_6.gameObject:SetActive(true)
					else
						var_92_6.gameObject:SetActive(false)
					end
				end
			end

			local var_92_7 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				var_92_5.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_89_1.time_ - 0) / var_92_7)
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				var_92_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_92_8 = arg_89_1.actors_["128404"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos128404 = var_92_8.localPosition
				var_92_8.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("128404", 3)

				for iter_92_9 = 0, var_92_8.childCount - 1 do
					local var_92_9 = var_92_8:GetChild(iter_92_9)

					if var_92_9.name == "" or not string.find(var_92_9.name, "split") then
						var_92_9.gameObject:SetActive(true)
					else
						var_92_9.gameObject:SetActive(false)
					end
				end
			end

			local var_92_10 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_10 then
				var_92_8.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_89_1.time_ - 0) / var_92_10)
			end

			if arg_89_1.time_ >= 0 + var_92_10 and arg_89_1.time_ < 0 + var_92_10 + arg_92_0 then
				var_92_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_92_11 = 0
			local var_92_12 = 0.5

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_13 = arg_89_1:GetWordFromCfg(926041021)
				local var_92_14 = arg_89_1:FormatText(var_92_13.content)

				arg_89_1.text_.text = var_92_14

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 20 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 20)

				if (20 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 20)) > 0 and var_92_12 < var_92_16 then
					arg_89_1.talkMaxDuration = var_92_16

					if var_92_16 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_14
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041021", "story_v_out_926041.awb") ~= 0 then
					local var_92_17 = manager.audio:GetVoiceLength("story_v_out_926041", "926041021", "story_v_out_926041.awb") / 1000

					if var_92_17 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_11
					end

					if var_92_13.prefab_name ~= "" and arg_89_1.actors_[var_92_13.prefab_name] ~= nil then
						local var_92_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_13.prefab_name].transform, "story_v_out_926041", "926041021", "story_v_out_926041.awb")

						arg_89_1:RecordAudio("926041021", var_92_18)
						arg_89_1:RecordAudio("926041021", var_92_18)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_926041", "926041021", "story_v_out_926041.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_926041", "926041021", "story_v_out_926041.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_19 = math.max(var_92_12, arg_89_1.talkMaxDuration)

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_19 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_11) / var_92_19

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_11 + var_92_19 and arg_89_1.time_ < var_92_11 + var_92_19 + arg_92_0 then
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

		arg_89_1:InitPlayNodeList()
	end,
	Play926041022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 926041022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play926041023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["128404"]) and arg_93_1.var_.actorSpriteComps128404 == nil then
				arg_93_1.var_.actorSpriteComps128404 = arg_93_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["128404"]) then
				if arg_93_1.var_.actorSpriteComps128404 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								iter_96_1.color = Color.New(Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_0), Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_0), (Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_0)))
							else
								local var_96_1 = Mathf.Lerp(iter_96_1.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_0)

								iter_96_1.color = Color.New(var_96_1, var_96_1, var_96_1)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["128404"]) and arg_93_1.var_.actorSpriteComps128404 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps128404 = nil
			end

			local var_96_2 = arg_93_1.actors_["128404"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos128404 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("128404", 7)

				for iter_96_4 = 0, var_96_2.childCount - 1 do
					local var_96_3 = var_96_2:GetChild(iter_96_4)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_93_1.time_ - 0) / var_96_4)
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_93_1.time_ and arg_93_1.time_ <= 0.034 + arg_96_0 then
				arg_93_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_swordlightbroken", "")
			end

			local var_96_6 = 0
			local var_96_7 = 1.525

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(926041022).content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 61 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_8) / 61)

				if (61 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_8) / 61)) > 0 and var_96_7 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_11 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_11 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_11

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_11 and arg_93_1.time_ < var_96_6 + var_96_11 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play926041023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 926041023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play926041024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0.8 < arg_97_1.time_ and arg_97_1.time_ <= 0.8 + arg_100_0 then
				arg_97_1:AudioAction("play", "effect", "se_story_16", "se_story_16_fall02", "")
			end

			local var_100_1 = manager.ui.mainCamera.transform

			if 0.8 < arg_97_1.time_ and arg_97_1.time_ <= 0.8 + arg_100_0 then
				arg_97_1.var_.shakeOldPos = var_100_1.localPosition
			end

			local var_100_2 = 1

			if 0.8 <= arg_97_1.time_ and arg_97_1.time_ < 0.8 + var_100_2 then
				local var_100_3, var_100_4 = math.modf((arg_97_1.time_ - 0.8) / 0.066)

				var_100_1.localPosition = Vector3.New(var_100_4 * 0.13, var_100_4 * 0.13, var_100_4 * 0.13) + arg_97_1.var_.shakeOldPos
			end

			if arg_97_1.time_ >= 0.8 + var_100_2 and arg_97_1.time_ < 0.8 + var_100_2 + arg_100_0 then
				var_100_1.localPosition = arg_97_1.var_.shakeOldPos
			end

			local var_100_5 = 0

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			if arg_97_1.time_ >= var_100_5 + 1.8 and arg_97_1.time_ < var_100_5 + 1.8 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end

			local var_100_6 = 0
			local var_100_7 = 1.625

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(926041023).content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 65 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_8) / 65)

				if (65 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_8) / 65)) > 0 and var_100_7 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_11 and arg_97_1.time_ < var_100_6 + var_100_11 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play926041024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 926041024
		arg_101_1.duration_ = 7.8

		local var_101_0 = {
			zh = 5.56666666666667,
			ja = 7.79966666666667
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
				arg_101_0:Play926041025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["128404"]) and arg_101_1.var_.actorSpriteComps128404 == nil then
				arg_101_1.var_.actorSpriteComps128404 = arg_101_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["128404"]) then
				if arg_101_1.var_.actorSpriteComps128404 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								iter_104_1.color = Color.New(Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_0), Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_0), (Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_0)))
							else
								local var_104_1 = Mathf.Lerp(iter_104_1.color.r, 1, (arg_101_1.time_ - 0) / var_104_0)

								iter_104_1.color = Color.New(var_104_1, var_104_1, var_104_1)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["128404"]) and arg_101_1.var_.actorSpriteComps128404 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps128404 = nil
			end

			local var_104_2 = arg_101_1.actors_["128404"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos128404 = var_104_2.localPosition
				var_104_2.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("128404", 3)

				for iter_104_4 = 0, var_104_2.childCount - 1 do
					local var_104_3 = var_104_2:GetChild(iter_104_4)

					if var_104_3.name == "split_4" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.466666666666667

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_2.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos128404, Vector3.New(-37, -369.1, -352.4), (arg_101_1.time_ - 0) / var_104_4)
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_2.localPosition = Vector3.New(-37, -369.1, -352.4)
			end

			local var_104_5 = 0

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			if arg_101_1.time_ >= var_104_5 + 0.866666666666667 and arg_101_1.time_ < var_104_5 + 0.866666666666667 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_6 = arg_101_1.actors_["128404"].transform

			if 0.466666666666667 < arg_101_1.time_ and arg_101_1.time_ <= 0.466666666666667 + arg_104_0 then
				arg_101_1.var_.moveOldPos128404 = var_104_6.localPosition
				var_104_6.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("128404", 3)

				for iter_104_5 = 0, var_104_6.childCount - 1 do
					local var_104_7 = var_104_6:GetChild(iter_104_5)

					if var_104_7.name == "split_4" or not string.find(var_104_7.name, "split") then
						var_104_7.gameObject:SetActive(true)
					else
						var_104_7.gameObject:SetActive(false)
					end
				end
			end

			local var_104_8 = 0.1

			if 0.466666666666667 <= arg_101_1.time_ and arg_101_1.time_ < 0.466666666666667 + var_104_8 then
				var_104_6.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos128404, Vector3.New(-37, -361, -352.4), (arg_101_1.time_ - 0.466666666666667) / var_104_8)
			end

			if arg_101_1.time_ >= 0.466666666666667 + var_104_8 and arg_101_1.time_ < 0.466666666666667 + var_104_8 + arg_104_0 then
				var_104_6.localPosition = Vector3.New(-37, -361, -352.4)
			end

			local var_104_9 = arg_101_1.actors_["128404"].transform

			if 0.566666666666667 < arg_101_1.time_ and arg_101_1.time_ <= 0.566666666666667 + arg_104_0 then
				arg_101_1.var_.moveOldPos128404 = var_104_9.localPosition
				var_104_9.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("128404", 3)

				for iter_104_6 = 0, var_104_9.childCount - 1 do
					local var_104_10 = var_104_9:GetChild(iter_104_6)

					if var_104_10.name == "split_4" or not string.find(var_104_10.name, "split") then
						var_104_10.gameObject:SetActive(true)
					else
						var_104_10.gameObject:SetActive(false)
					end
				end
			end

			local var_104_11 = 0.133333333333333

			if 0.566666666666667 <= arg_101_1.time_ and arg_101_1.time_ < 0.566666666666667 + var_104_11 then
				var_104_9.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos128404, Vector3.New(-37, -369.1, -352.4), (arg_101_1.time_ - 0.566666666666667) / var_104_11)
			end

			if arg_101_1.time_ >= 0.566666666666667 + var_104_11 and arg_101_1.time_ < 0.566666666666667 + var_104_11 + arg_104_0 then
				var_104_9.localPosition = Vector3.New(-37, -369.1, -352.4)
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_12 = 0.766666666666667
			local var_104_13 = 0.625

			if 0.766666666666667 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_14 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_14:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_15 = arg_101_1:GetWordFromCfg(926041024)
				local var_104_16 = arg_101_1:FormatText(var_104_15.content)

				arg_101_1.text_.text = var_104_16

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_18 = 25 <= 0 and var_104_13 or var_104_13 * (utf8.len(var_104_16) / 25)

				if (25 <= 0 and var_104_13 or var_104_13 * (utf8.len(var_104_16) / 25)) > 0 and var_104_13 < var_104_18 then
					arg_101_1.talkMaxDuration = var_104_18
					var_104_12 = var_104_12 + 0.3

					if var_104_18 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_18 + var_104_12
					end
				end

				arg_101_1.text_.text = var_104_16
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041024", "story_v_out_926041.awb") ~= 0 then
					local var_104_19 = manager.audio:GetVoiceLength("story_v_out_926041", "926041024", "story_v_out_926041.awb") / 1000

					if var_104_19 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_19 + var_104_12
					end

					if var_104_15.prefab_name ~= "" and arg_101_1.actors_[var_104_15.prefab_name] ~= nil then
						local var_104_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_15.prefab_name].transform, "story_v_out_926041", "926041024", "story_v_out_926041.awb")

						arg_101_1:RecordAudio("926041024", var_104_20)
						arg_101_1:RecordAudio("926041024", var_104_20)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_926041", "926041024", "story_v_out_926041.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_926041", "926041024", "story_v_out_926041.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_21 = var_104_12 + 0.3
			local var_104_22 = math.max(var_104_13, arg_101_1.talkMaxDuration)

			if var_104_12 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_21 + var_104_22 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_21) / var_104_22

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_21 + var_104_22 and arg_101_1.time_ < var_104_21 + var_104_22 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.466666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0.562,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-28.04, -1698.3, -265.92),
					endPos = Vector3.New(-37, -369.1, -352.4),
					easeType = LeanTweenType.easeInQuad
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.1,
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-37, -369.1, -352.4),
					endPos = Vector3.New(-37, -361, -352.4),
					easeType = LeanTweenType.easeInQuad
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.133333333333333,
				startTime = 0.566666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-37, -361, -352.4),
					endPos = Vector3.New(-37, -369.1, -352.4),
					easeType = LeanTweenType.easeInQuad
				}
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play926041025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 926041025
		arg_107_1.duration_ = 4.2

		local var_107_0 = {
			zh = 3.833,
			ja = 4.2
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
				arg_107_0:Play926041026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["106603"]) and arg_107_1.var_.actorSpriteComps106603 == nil then
				arg_107_1.var_.actorSpriteComps106603 = arg_107_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["106603"]) then
				if arg_107_1.var_.actorSpriteComps106603 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								iter_110_1.color = Color.New(Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_0), Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_0), (Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_0)))
							else
								local var_110_1 = Mathf.Lerp(iter_110_1.color.r, 1, (arg_107_1.time_ - 0) / var_110_0)

								iter_110_1.color = Color.New(var_110_1, var_110_1, var_110_1)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["106603"]) and arg_107_1.var_.actorSpriteComps106603 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps106603 = nil
			end

			local var_110_2 = arg_107_1.actors_["128404"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps128404 == nil then
				arg_107_1.var_.actorSpriteComps128404 = var_110_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_3 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.actorSpriteComps128404 then
					for iter_110_4, iter_110_5 in pairs(arg_107_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_110_5 then
							if arg_107_1.isInRecall_ then
								iter_110_5.color = Color.New(Mathf.Lerp(iter_110_5.color.r, arg_107_1.hightColor2.r, (arg_107_1.time_ - 0) / var_110_3), Mathf.Lerp(iter_110_5.color.g, arg_107_1.hightColor2.g, (arg_107_1.time_ - 0) / var_110_3), (Mathf.Lerp(iter_110_5.color.b, arg_107_1.hightColor2.b, (arg_107_1.time_ - 0) / var_110_3)))
							else
								local var_110_4 = Mathf.Lerp(iter_110_5.color.r, 0.5, (arg_107_1.time_ - 0) / var_110_3)

								iter_110_5.color = Color.New(var_110_4, var_110_4, var_110_4)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps128404 then
				for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_110_7 then
						iter_110_7.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps128404 = nil
			end

			local var_110_5 = arg_107_1.actors_["128404"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos128404 = var_110_5.localPosition
				var_110_5.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("128404", 7)

				for iter_110_8 = 0, var_110_5.childCount - 1 do
					local var_110_6 = var_110_5:GetChild(iter_110_8)

					if var_110_6.name == "" or not string.find(var_110_6.name, "split") then
						var_110_6.gameObject:SetActive(true)
					else
						var_110_6.gameObject:SetActive(false)
					end
				end
			end

			local var_110_7 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				var_110_5.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_107_1.time_ - 0) / var_110_7)
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				var_110_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_110_8 = arg_107_1.actors_["106603"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos106603 = var_110_8.localPosition
				var_110_8.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("106603", 3)

				for iter_110_9 = 0, var_110_8.childCount - 1 do
					local var_110_9 = var_110_8:GetChild(iter_110_9)

					if var_110_9.name == "split_1" or not string.find(var_110_9.name, "split") then
						var_110_9.gameObject:SetActive(true)
					else
						var_110_9.gameObject:SetActive(false)
					end
				end
			end

			local var_110_10 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_10 then
				var_110_8.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_107_1.time_ - 0) / var_110_10)
			end

			if arg_107_1.time_ >= 0 + var_110_10 and arg_107_1.time_ < 0 + var_110_10 + arg_110_0 then
				var_110_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_110_11 = 0
			local var_110_12 = 0.4

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_13 = arg_107_1:GetWordFromCfg(926041025)
				local var_110_14 = arg_107_1:FormatText(var_110_13.content)

				arg_107_1.text_.text = var_110_14

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_16 = 16 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 16)

				if (16 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 16)) > 0 and var_110_12 < var_110_16 then
					arg_107_1.talkMaxDuration = var_110_16

					if var_110_16 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_16 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_14
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041025", "story_v_out_926041.awb") ~= 0 then
					local var_110_17 = manager.audio:GetVoiceLength("story_v_out_926041", "926041025", "story_v_out_926041.awb") / 1000

					if var_110_17 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_17 + var_110_11
					end

					if var_110_13.prefab_name ~= "" and arg_107_1.actors_[var_110_13.prefab_name] ~= nil then
						local var_110_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_13.prefab_name].transform, "story_v_out_926041", "926041025", "story_v_out_926041.awb")

						arg_107_1:RecordAudio("926041025", var_110_18)
						arg_107_1:RecordAudio("926041025", var_110_18)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_926041", "926041025", "story_v_out_926041.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_926041", "926041025", "story_v_out_926041.awb")
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
				actorName = "106603",
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
	Play926041026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 926041026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play926041027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["106603"]) and arg_111_1.var_.actorSpriteComps106603 == nil then
				arg_111_1.var_.actorSpriteComps106603 = arg_111_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["106603"]) then
				if arg_111_1.var_.actorSpriteComps106603 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								iter_114_1.color = Color.New(Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_0), Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_0), (Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_0)))
							else
								local var_114_1 = Mathf.Lerp(iter_114_1.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_0)

								iter_114_1.color = Color.New(var_114_1, var_114_1, var_114_1)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["106603"]) and arg_111_1.var_.actorSpriteComps106603 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps106603 = nil
			end

			local var_114_2 = 0
			local var_114_3 = 0.275

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_4 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(926041026).content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 11 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_4) / 11)

				if (11 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_4) / 11)) > 0 and var_114_3 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_7 and arg_111_1.time_ < var_114_2 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play926041027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 926041027
		arg_115_1.duration_ = 9.17

		local var_115_0 = {
			zh = 7.266,
			ja = 9.166
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
				arg_115_0:Play926041028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["106103"]) and arg_115_1.var_.actorSpriteComps106103 == nil then
				arg_115_1.var_.actorSpriteComps106103 = arg_115_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_0 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["106103"]) then
				if arg_115_1.var_.actorSpriteComps106103 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								iter_118_1.color = Color.New(Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_0), Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_0), (Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_0)))
							else
								local var_118_1 = Mathf.Lerp(iter_118_1.color.r, 1, (arg_115_1.time_ - 0) / var_118_0)

								iter_118_1.color = Color.New(var_118_1, var_118_1, var_118_1)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["106103"]) and arg_115_1.var_.actorSpriteComps106103 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_118_3 then
						iter_118_3.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps106103 = nil
			end

			local var_118_2 = arg_115_1.actors_["106603"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos106603 = var_118_2.localPosition
				var_118_2.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("106603", 4)

				for iter_118_4 = 0, var_118_2.childCount - 1 do
					local var_118_3 = var_118_2:GetChild(iter_118_4)

					if var_118_3.name == "" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_2.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_115_1.time_ - 0) / var_118_4)
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_2.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_118_5 = arg_115_1.actors_["106103"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos106103 = var_118_5.localPosition
				var_118_5.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("106103", 2)

				for iter_118_5 = 0, var_118_5.childCount - 1 do
					local var_118_6 = var_118_5:GetChild(iter_118_5)

					if var_118_6.name == "" or not string.find(var_118_6.name, "split") then
						var_118_6.gameObject:SetActive(true)
					else
						var_118_6.gameObject:SetActive(false)
					end
				end
			end

			local var_118_7 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos106103, Vector3.New(-428.4, -398.2, -333.7), (arg_115_1.time_ - 0) / var_118_7)
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_118_8 = 0
			local var_118_9 = 0.825

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_10 = arg_115_1:GetWordFromCfg(926041027)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 33 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 33)

				if (33 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 33)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041027", "story_v_out_926041.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_926041", "926041027", "story_v_out_926041.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_926041", "926041027", "story_v_out_926041.awb")

						arg_115_1:RecordAudio("926041027", var_118_15)
						arg_115_1:RecordAudio("926041027", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_926041", "926041027", "story_v_out_926041.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_926041", "926041027", "story_v_out_926041.awb")
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
				actorName = "106603",
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

		arg_115_1:InitPlayNodeList()
	end,
	Play926041028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 926041028
		arg_119_1.duration_ = 9.7

		local var_119_0 = {
			zh = 6.466,
			ja = 9.7
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
				arg_119_0:Play926041029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["106603"]) and arg_119_1.var_.actorSpriteComps106603 == nil then
				arg_119_1.var_.actorSpriteComps106603 = arg_119_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["106603"]) then
				if arg_119_1.var_.actorSpriteComps106603 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								iter_122_1.color = Color.New(Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_0), Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_0), (Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_0)))
							else
								local var_122_1 = Mathf.Lerp(iter_122_1.color.r, 1, (arg_119_1.time_ - 0) / var_122_0)

								iter_122_1.color = Color.New(var_122_1, var_122_1, var_122_1)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["106603"]) and arg_119_1.var_.actorSpriteComps106603 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps106603 = nil
			end

			local var_122_2 = arg_119_1.actors_["106103"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps106103 == nil then
				arg_119_1.var_.actorSpriteComps106103 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps106103 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_122_5 then
							if arg_119_1.isInRecall_ then
								iter_122_5.color = Color.New(Mathf.Lerp(iter_122_5.color.r, arg_119_1.hightColor2.r, (arg_119_1.time_ - 0) / var_122_3), Mathf.Lerp(iter_122_5.color.g, arg_119_1.hightColor2.g, (arg_119_1.time_ - 0) / var_122_3), (Mathf.Lerp(iter_122_5.color.b, arg_119_1.hightColor2.b, (arg_119_1.time_ - 0) / var_122_3)))
							else
								local var_122_4 = Mathf.Lerp(iter_122_5.color.r, 0.5, (arg_119_1.time_ - 0) / var_122_3)

								iter_122_5.color = Color.New(var_122_4, var_122_4, var_122_4)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps106103 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_122_7 then
						iter_122_7.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps106103 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 0.775

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(926041028)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 31 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 31)

				if (31 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 31)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041028", "story_v_out_926041.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_926041", "926041028", "story_v_out_926041.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_926041", "926041028", "story_v_out_926041.awb")

						arg_119_1:RecordAudio("926041028", var_122_12)
						arg_119_1:RecordAudio("926041028", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_926041", "926041028", "story_v_out_926041.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_926041", "926041028", "story_v_out_926041.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_13 = math.max(var_122_6, arg_119_1.talkMaxDuration)

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_5) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_5 + var_122_13 and arg_119_1.time_ < var_122_5 + var_122_13 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play926041029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 926041029
		arg_123_1.duration_ = 12.2

		local var_123_0 = {
			zh = 6.033,
			ja = 12.2
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
				arg_123_0:Play926041030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos106603 = arg_123_1.actors_["106603"].transform.localPosition
				arg_123_1.actors_["106603"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("106603", 4)

				for iter_126_0 = 0, arg_123_1.actors_["106603"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["106603"].transform:GetChild(iter_126_0)

					if var_126_0.name == "" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["106603"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["106603"].transform.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_126_2 = 0
			local var_126_3 = 0.725

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:GetWordFromCfg(926041029)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 29 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 29)

				if (29 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 29)) > 0 and var_126_3 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041029", "story_v_out_926041.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_926041", "926041029", "story_v_out_926041.awb") / 1000

					if var_126_8 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_2
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_out_926041", "926041029", "story_v_out_926041.awb")

						arg_123_1:RecordAudio("926041029", var_126_9)
						arg_123_1:RecordAudio("926041029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_926041", "926041029", "story_v_out_926041.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_926041", "926041029", "story_v_out_926041.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_10 and arg_123_1.time_ < var_126_2 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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
	Play926041030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 926041030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play926041031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["106603"]) and arg_127_1.var_.actorSpriteComps106603 == nil then
				arg_127_1.var_.actorSpriteComps106603 = arg_127_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["106603"]) then
				if arg_127_1.var_.actorSpriteComps106603 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								iter_130_1.color = Color.New(Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_0), Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_0), (Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_0)))
							else
								local var_130_1 = Mathf.Lerp(iter_130_1.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_0)

								iter_130_1.color = Color.New(var_130_1, var_130_1, var_130_1)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["106603"]) and arg_127_1.var_.actorSpriteComps106603 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps106603 = nil
			end

			local var_130_2 = arg_127_1.actors_["106603"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos106603 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("106603", 7)

				for iter_130_4 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_4)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_5 = arg_127_1.actors_["106103"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos106103 = var_130_5.localPosition
				var_130_5.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("106103", 7)

				for iter_130_5 = 0, var_130_5.childCount - 1 do
					local var_130_6 = var_130_5:GetChild(iter_130_5)

					if var_130_6.name == "" or not string.find(var_130_6.name, "split") then
						var_130_6.gameObject:SetActive(true)
					else
						var_130_6.gameObject:SetActive(false)
					end
				end
			end

			local var_130_7 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				var_130_5.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_127_1.time_ - 0) / var_130_7)
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				var_130_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_8 = 0
			local var_130_9 = 0.725

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_10 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(926041030).content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_12 = 29 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_10) / 29)

				if (29 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_10) / 29)) > 0 and var_130_9 < var_130_12 then
					arg_127_1.talkMaxDuration = var_130_12

					if var_130_12 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_10
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_9, arg_127_1.talkMaxDuration)

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_8) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_8 + var_130_13 and arg_127_1.time_ < var_130_8 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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

		arg_127_1:InitPlayNodeList()
	end,
	Play926041031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 926041031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play926041032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.25

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(926041031).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 10 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 10)

				if (10 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 10)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play926041032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 926041032
		arg_135_1.duration_ = 7.4

		local var_135_0 = {
			zh = 4.666,
			ja = 7.4
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
				arg_135_0:Play926041033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["104701"]) and arg_135_1.var_.actorSpriteComps104701 == nil then
				arg_135_1.var_.actorSpriteComps104701 = arg_135_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["104701"]) then
				if arg_135_1.var_.actorSpriteComps104701 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 1, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["104701"]) and arg_135_1.var_.actorSpriteComps104701 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps104701 = nil
			end

			local var_138_2 = arg_135_1.actors_["104701"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos104701 = var_138_2.localPosition
				var_138_2.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("104701", 3)

				for iter_138_4 = 0, var_138_2.childCount - 1 do
					local var_138_3 = var_138_2:GetChild(iter_138_4)

					if var_138_3.name == "" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				var_138_2.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_135_1.time_ - 0) / var_138_4)
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				var_138_2.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_138_5 = 0
			local var_138_6 = 0.65

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_7 = arg_135_1:GetWordFromCfg(926041032)
				local var_138_8 = arg_135_1:FormatText(var_138_7.content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 26 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 26)

				if (26 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 26)) > 0 and var_138_6 < var_138_10 then
					arg_135_1.talkMaxDuration = var_138_10

					if var_138_10 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041032", "story_v_out_926041.awb") ~= 0 then
					local var_138_11 = manager.audio:GetVoiceLength("story_v_out_926041", "926041032", "story_v_out_926041.awb") / 1000

					if var_138_11 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_5
					end

					if var_138_7.prefab_name ~= "" and arg_135_1.actors_[var_138_7.prefab_name] ~= nil then
						local var_138_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_7.prefab_name].transform, "story_v_out_926041", "926041032", "story_v_out_926041.awb")

						arg_135_1:RecordAudio("926041032", var_138_12)
						arg_135_1:RecordAudio("926041032", var_138_12)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_926041", "926041032", "story_v_out_926041.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_926041", "926041032", "story_v_out_926041.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_13 = math.max(var_138_6, arg_135_1.talkMaxDuration)

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_13 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_5) / var_138_13

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_5 + var_138_13 and arg_135_1.time_ < var_138_5 + var_138_13 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play926041033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 926041033
		arg_139_1.duration_ = 6.67

		local var_139_0 = {
			zh = 4.733,
			ja = 6.666
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
				arg_139_0:Play926041034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["106603"]) and arg_139_1.var_.actorSpriteComps106603 == nil then
				arg_139_1.var_.actorSpriteComps106603 = arg_139_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["106603"]) then
				if arg_139_1.var_.actorSpriteComps106603 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 1, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["106603"]) and arg_139_1.var_.actorSpriteComps106603 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps106603 = nil
			end

			local var_142_2 = arg_139_1.actors_["104701"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps104701 == nil then
				arg_139_1.var_.actorSpriteComps104701 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps104701 then
					for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_142_5 then
							if arg_139_1.isInRecall_ then
								iter_142_5.color = Color.New(Mathf.Lerp(iter_142_5.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_5.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_5.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_5.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_5.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps104701 then
				for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_142_7 then
						iter_142_7.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps104701 = nil
			end

			local var_142_5 = arg_139_1.actors_["104701"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos104701 = var_142_5.localPosition
				var_142_5.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("104701", 7)

				for iter_142_8 = 0, var_142_5.childCount - 1 do
					local var_142_6 = var_142_5:GetChild(iter_142_8)

					if var_142_6.name == "" or not string.find(var_142_6.name, "split") then
						var_142_6.gameObject:SetActive(true)
					else
						var_142_6.gameObject:SetActive(false)
					end
				end
			end

			local var_142_7 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				var_142_5.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_139_1.time_ - 0) / var_142_7)
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				var_142_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_142_8 = arg_139_1.actors_["106603"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos106603 = var_142_8.localPosition
				var_142_8.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("106603", 3)

				for iter_142_9 = 0, var_142_8.childCount - 1 do
					local var_142_9 = var_142_8:GetChild(iter_142_9)

					if var_142_9.name == "" or not string.find(var_142_9.name, "split") then
						var_142_9.gameObject:SetActive(true)
					else
						var_142_9.gameObject:SetActive(false)
					end
				end
			end

			local var_142_10 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_10 then
				var_142_8.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_139_1.time_ - 0) / var_142_10)
			end

			if arg_139_1.time_ >= 0 + var_142_10 and arg_139_1.time_ < 0 + var_142_10 + arg_142_0 then
				var_142_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_142_11 = 0
			local var_142_12 = 0.575

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_13 = arg_139_1:GetWordFromCfg(926041033)
				local var_142_14 = arg_139_1:FormatText(var_142_13.content)

				arg_139_1.text_.text = var_142_14

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_16 = 23 <= 0 and var_142_12 or var_142_12 * (utf8.len(var_142_14) / 23)

				if (23 <= 0 and var_142_12 or var_142_12 * (utf8.len(var_142_14) / 23)) > 0 and var_142_12 < var_142_16 then
					arg_139_1.talkMaxDuration = var_142_16

					if var_142_16 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_16 + var_142_11
					end
				end

				arg_139_1.text_.text = var_142_14
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041033", "story_v_out_926041.awb") ~= 0 then
					local var_142_17 = manager.audio:GetVoiceLength("story_v_out_926041", "926041033", "story_v_out_926041.awb") / 1000

					if var_142_17 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_17 + var_142_11
					end

					if var_142_13.prefab_name ~= "" and arg_139_1.actors_[var_142_13.prefab_name] ~= nil then
						local var_142_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_13.prefab_name].transform, "story_v_out_926041", "926041033", "story_v_out_926041.awb")

						arg_139_1:RecordAudio("926041033", var_142_18)
						arg_139_1:RecordAudio("926041033", var_142_18)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_926041", "926041033", "story_v_out_926041.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_926041", "926041033", "story_v_out_926041.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_19 = math.max(var_142_12, arg_139_1.talkMaxDuration)

			if var_142_11 <= arg_139_1.time_ and arg_139_1.time_ < var_142_11 + var_142_19 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_11) / var_142_19

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_11 + var_142_19 and arg_139_1.time_ < var_142_11 + var_142_19 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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
				actorName = "106603",
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
	Play926041034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 926041034
		arg_143_1.duration_ = 9.7

		local var_143_0 = {
			zh = 8.166,
			ja = 9.7
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
				arg_143_0:Play926041035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 1.075

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:GetWordFromCfg(926041034)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 43 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 43)

				if (43 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 43)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041034", "story_v_out_926041.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_926041", "926041034", "story_v_out_926041.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_926041", "926041034", "story_v_out_926041.awb")

						arg_143_1:RecordAudio("926041034", var_146_6)
						arg_143_1:RecordAudio("926041034", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_926041", "926041034", "story_v_out_926041.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_926041", "926041034", "story_v_out_926041.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play926041035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 926041035
		arg_147_1.duration_ = 4.43

		local var_147_0 = {
			zh = 3.3,
			ja = 4.433
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
				arg_147_0:Play926041036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["128404"]) and arg_147_1.var_.actorSpriteComps128404 == nil then
				arg_147_1.var_.actorSpriteComps128404 = arg_147_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["128404"]) then
				if arg_147_1.var_.actorSpriteComps128404 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								iter_150_1.color = Color.New(Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_0), Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_0), (Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_0)))
							else
								local var_150_1 = Mathf.Lerp(iter_150_1.color.r, 1, (arg_147_1.time_ - 0) / var_150_0)

								iter_150_1.color = Color.New(var_150_1, var_150_1, var_150_1)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["128404"]) and arg_147_1.var_.actorSpriteComps128404 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps128404 = nil
			end

			local var_150_2 = arg_147_1.actors_["106603"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps106603 == nil then
				arg_147_1.var_.actorSpriteComps106603 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps106603 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_150_5 then
							if arg_147_1.isInRecall_ then
								iter_150_5.color = Color.New(Mathf.Lerp(iter_150_5.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_3), Mathf.Lerp(iter_150_5.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_3), (Mathf.Lerp(iter_150_5.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_3)))
							else
								local var_150_4 = Mathf.Lerp(iter_150_5.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_3)

								iter_150_5.color = Color.New(var_150_4, var_150_4, var_150_4)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps106603 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_150_7 then
						iter_150_7.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps106603 = nil
			end

			local var_150_5 = 0
			local var_150_6 = 0.45

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_7 = arg_147_1:GetWordFromCfg(926041035)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 18 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 18)

				if (18 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 18)) > 0 and var_150_6 < var_150_10 then
					arg_147_1.talkMaxDuration = var_150_10

					if var_150_10 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041035", "story_v_out_926041.awb") ~= 0 then
					local var_150_11 = manager.audio:GetVoiceLength("story_v_out_926041", "926041035", "story_v_out_926041.awb") / 1000

					if var_150_11 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_5
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_926041", "926041035", "story_v_out_926041.awb")

						arg_147_1:RecordAudio("926041035", var_150_12)
						arg_147_1:RecordAudio("926041035", var_150_12)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_926041", "926041035", "story_v_out_926041.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_926041", "926041035", "story_v_out_926041.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_13 = math.max(var_150_6, arg_147_1.talkMaxDuration)

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_13 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_5) / var_150_13

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_5 + var_150_13 and arg_147_1.time_ < var_150_5 + var_150_13 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play926041036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 926041036
		arg_151_1.duration_ = 10.53

		local var_151_0 = {
			zh = 7.033,
			ja = 10.533
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
				arg_151_0:Play926041037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["106603"]) and arg_151_1.var_.actorSpriteComps106603 == nil then
				arg_151_1.var_.actorSpriteComps106603 = arg_151_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["106603"]) then
				if arg_151_1.var_.actorSpriteComps106603 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 1, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["106603"]) and arg_151_1.var_.actorSpriteComps106603 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps106603 = nil
			end

			local var_154_2 = arg_151_1.actors_["128404"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps128404 == nil then
				arg_151_1.var_.actorSpriteComps128404 = var_154_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_3 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.actorSpriteComps128404 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_154_5 then
							if arg_151_1.isInRecall_ then
								iter_154_5.color = Color.New(Mathf.Lerp(iter_154_5.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_3), Mathf.Lerp(iter_154_5.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_3), (Mathf.Lerp(iter_154_5.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_3)))
							else
								local var_154_4 = Mathf.Lerp(iter_154_5.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_3)

								iter_154_5.color = Color.New(var_154_4, var_154_4, var_154_4)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps128404 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_154_7 then
						iter_154_7.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps128404 = nil
			end

			local var_154_5 = arg_151_1.actors_["106603"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos106603 = var_154_5.localPosition
				var_154_5.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("106603", 3)

				for iter_154_8 = 0, var_154_5.childCount - 1 do
					local var_154_6 = var_154_5:GetChild(iter_154_8)

					if var_154_6.name == "split_6" or not string.find(var_154_6.name, "split") then
						var_154_6.gameObject:SetActive(true)
					else
						var_154_6.gameObject:SetActive(false)
					end
				end
			end

			local var_154_7 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				var_154_5.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_151_1.time_ - 0) / var_154_7)
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				var_154_5.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_154_8 = 0
			local var_154_9 = 0.775

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_10 = arg_151_1:GetWordFromCfg(926041036)
				local var_154_11 = arg_151_1:FormatText(var_154_10.content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 31 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 31)

				if (31 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 31)) > 0 and var_154_9 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041036", "story_v_out_926041.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_926041", "926041036", "story_v_out_926041.awb") / 1000

					if var_154_14 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_8
					end

					if var_154_10.prefab_name ~= "" and arg_151_1.actors_[var_154_10.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_10.prefab_name].transform, "story_v_out_926041", "926041036", "story_v_out_926041.awb")

						arg_151_1:RecordAudio("926041036", var_154_15)
						arg_151_1:RecordAudio("926041036", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_926041", "926041036", "story_v_out_926041.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_926041", "926041036", "story_v_out_926041.awb")
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
				actorName = "106603",
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
	Play926041037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 926041037
		arg_155_1.duration_ = 8.63

		local var_155_0 = {
			zh = 6.866,
			ja = 8.633
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
				arg_155_0:Play926041038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.875

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(926041037)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 35 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 35)

				if (35 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 35)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041037", "story_v_out_926041.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_926041", "926041037", "story_v_out_926041.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_926041", "926041037", "story_v_out_926041.awb")

						arg_155_1:RecordAudio("926041037", var_158_6)
						arg_155_1:RecordAudio("926041037", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_926041", "926041037", "story_v_out_926041.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_926041", "926041037", "story_v_out_926041.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play926041038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 926041038
		arg_159_1.duration_ = 8.2

		local var_159_0 = {
			zh = 5.966,
			ja = 8.2
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
				arg_159_0:Play926041039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos106603 = arg_159_1.actors_["106603"].transform.localPosition
				arg_159_1.actors_["106603"].transform.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("106603", 3)

				for iter_162_0 = 0, arg_159_1.actors_["106603"].transform.childCount - 1 do
					local var_162_0 = arg_159_1.actors_["106603"].transform:GetChild(iter_162_0)

					if var_162_0.name == "split_4" or not string.find(var_162_0.name, "split") then
						var_162_0.gameObject:SetActive(true)
					else
						var_162_0.gameObject:SetActive(false)
					end
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["106603"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_159_1.time_ - 0) / var_162_1)
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["106603"].transform.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_162_2 = 0
			local var_162_3 = 0.65

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:GetWordFromCfg(926041038)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 26 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 26)

				if (26 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 26)) > 0 and var_162_3 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041038", "story_v_out_926041.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_926041", "926041038", "story_v_out_926041.awb") / 1000

					if var_162_8 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_2
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_926041", "926041038", "story_v_out_926041.awb")

						arg_159_1:RecordAudio("926041038", var_162_9)
						arg_159_1:RecordAudio("926041038", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_926041", "926041038", "story_v_out_926041.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_926041", "926041038", "story_v_out_926041.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_10 and arg_159_1.time_ < var_162_2 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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
	Play926041039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 926041039
		arg_163_1.duration_ = 1

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"

			SetActive(arg_163_1.choicesGo_, true)

			for iter_164_0, iter_164_1 in ipairs(arg_163_1.choices_) do
				SetActive(iter_164_1.go, iter_164_0 <= 1)
			end

			arg_163_1.choices_[1].txt.text = arg_163_1:FormatText(StoryChoiceCfg[1323].name)
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play926041040(arg_163_1)
			end

			arg_163_1:RecordChoiceLog(926041039, 1323)
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["106603"]) and arg_163_1.var_.actorSpriteComps106603 == nil then
				arg_163_1.var_.actorSpriteComps106603 = arg_163_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["106603"]) then
				if arg_163_1.var_.actorSpriteComps106603 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["106603"]) and arg_163_1.var_.actorSpriteComps106603 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps106603 = nil
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play926041040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 926041040
		arg_167_1.duration_ = 7.6

		local var_167_0 = {
			zh = 3.366,
			ja = 7.6
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
				arg_167_0:Play926041041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["104701"]) and arg_167_1.var_.actorSpriteComps104701 == nil then
				arg_167_1.var_.actorSpriteComps104701 = arg_167_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["104701"]) then
				if arg_167_1.var_.actorSpriteComps104701 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								iter_170_1.color = Color.New(Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_0), Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_0), (Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_0)))
							else
								local var_170_1 = Mathf.Lerp(iter_170_1.color.r, 1, (arg_167_1.time_ - 0) / var_170_0)

								iter_170_1.color = Color.New(var_170_1, var_170_1, var_170_1)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["104701"]) and arg_167_1.var_.actorSpriteComps104701 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps104701 = nil
			end

			local var_170_2 = arg_167_1.actors_["106603"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos106603 = var_170_2.localPosition
				var_170_2.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("106603", 7)

				for iter_170_4 = 0, var_170_2.childCount - 1 do
					local var_170_3 = var_170_2:GetChild(iter_170_4)

					if var_170_3.name == "" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_2.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_167_1.time_ - 0) / var_170_4)
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_170_5 = arg_167_1.actors_["104701"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos104701 = var_170_5.localPosition
				var_170_5.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("104701", 3)

				for iter_170_5 = 0, var_170_5.childCount - 1 do
					local var_170_6 = var_170_5:GetChild(iter_170_5)

					if var_170_6.name == "" or not string.find(var_170_6.name, "split") then
						var_170_6.gameObject:SetActive(true)
					else
						var_170_6.gameObject:SetActive(false)
					end
				end
			end

			local var_170_7 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				var_170_5.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_167_1.time_ - 0) / var_170_7)
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				var_170_5.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_170_8 = 0
			local var_170_9 = 0.425

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(926041040)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 17 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 17)

				if (17 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 17)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041040", "story_v_out_926041.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_926041", "926041040", "story_v_out_926041.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_926041", "926041040", "story_v_out_926041.awb")

						arg_167_1:RecordAudio("926041040", var_170_15)
						arg_167_1:RecordAudio("926041040", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_926041", "926041040", "story_v_out_926041.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_926041", "926041040", "story_v_out_926041.awb")
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
				actorName = "106603",
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

		arg_167_1:InitPlayNodeList()
	end,
	Play926041041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 926041041
		arg_171_1.duration_ = 8.3

		local var_171_0 = {
			zh = 5.566,
			ja = 8.3
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
				arg_171_0:Play926041042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.65

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(926041041)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 26 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 26)

				if (26 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 26)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041041", "story_v_out_926041.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_926041", "926041041", "story_v_out_926041.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_926041", "926041041", "story_v_out_926041.awb")

						arg_171_1:RecordAudio("926041041", var_174_6)
						arg_171_1:RecordAudio("926041041", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_926041", "926041041", "story_v_out_926041.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_926041", "926041041", "story_v_out_926041.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play926041042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 926041042
		arg_175_1.duration_ = 4.6

		local var_175_0 = {
			zh = 2.833,
			ja = 4.6
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
				arg_175_0:Play926041043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.325

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(926041042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 13 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 13)

				if (13 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 13)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041042", "story_v_out_926041.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_926041", "926041042", "story_v_out_926041.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_926041", "926041042", "story_v_out_926041.awb")

						arg_175_1:RecordAudio("926041042", var_178_6)
						arg_175_1:RecordAudio("926041042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_926041", "926041042", "story_v_out_926041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_926041", "926041042", "story_v_out_926041.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play926041043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 926041043
		arg_179_1.duration_ = 2.37

		local var_179_0 = {
			zh = 2.366,
			ja = 2.066
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play926041044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["106603"]) and arg_179_1.var_.actorSpriteComps106603 == nil then
				arg_179_1.var_.actorSpriteComps106603 = arg_179_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["106603"]) then
				if arg_179_1.var_.actorSpriteComps106603 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 1, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["106603"]) and arg_179_1.var_.actorSpriteComps106603 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps106603 = nil
			end

			local var_182_2 = arg_179_1.actors_["104701"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps104701 == nil then
				arg_179_1.var_.actorSpriteComps104701 = var_182_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_3 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.actorSpriteComps104701 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								iter_182_5.color = Color.New(Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_3), Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_3), (Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_3)))
							else
								local var_182_4 = Mathf.Lerp(iter_182_5.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_3)

								iter_182_5.color = Color.New(var_182_4, var_182_4, var_182_4)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps104701 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_182_7 then
						iter_182_7.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps104701 = nil
			end

			local var_182_5 = arg_179_1.actors_["104701"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos104701 = var_182_5.localPosition
				var_182_5.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("104701", 7)

				for iter_182_8 = 0, var_182_5.childCount - 1 do
					local var_182_6 = var_182_5:GetChild(iter_182_8)

					if var_182_6.name == "" or not string.find(var_182_6.name, "split") then
						var_182_6.gameObject:SetActive(true)
					else
						var_182_6.gameObject:SetActive(false)
					end
				end
			end

			local var_182_7 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				var_182_5.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_179_1.time_ - 0) / var_182_7)
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				var_182_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_182_8 = arg_179_1.actors_["106603"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos106603 = var_182_8.localPosition
				var_182_8.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("106603", 3)

				for iter_182_9 = 0, var_182_8.childCount - 1 do
					local var_182_9 = var_182_8:GetChild(iter_182_9)

					if var_182_9.name == "" or not string.find(var_182_9.name, "split") then
						var_182_9.gameObject:SetActive(true)
					else
						var_182_9.gameObject:SetActive(false)
					end
				end
			end

			local var_182_10 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_10 then
				var_182_8.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_179_1.time_ - 0) / var_182_10)
			end

			if arg_179_1.time_ >= 0 + var_182_10 and arg_179_1.time_ < 0 + var_182_10 + arg_182_0 then
				var_182_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_182_11 = 0
			local var_182_12 = 0.175

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_13 = arg_179_1:GetWordFromCfg(926041043)
				local var_182_14 = arg_179_1:FormatText(var_182_13.content)

				arg_179_1.text_.text = var_182_14

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_16 = 7 <= 0 and var_182_12 or var_182_12 * (utf8.len(var_182_14) / 7)

				if (7 <= 0 and var_182_12 or var_182_12 * (utf8.len(var_182_14) / 7)) > 0 and var_182_12 < var_182_16 then
					arg_179_1.talkMaxDuration = var_182_16

					if var_182_16 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_16 + var_182_11
					end
				end

				arg_179_1.text_.text = var_182_14
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041043", "story_v_out_926041.awb") ~= 0 then
					local var_182_17 = manager.audio:GetVoiceLength("story_v_out_926041", "926041043", "story_v_out_926041.awb") / 1000

					if var_182_17 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_17 + var_182_11
					end

					if var_182_13.prefab_name ~= "" and arg_179_1.actors_[var_182_13.prefab_name] ~= nil then
						local var_182_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_13.prefab_name].transform, "story_v_out_926041", "926041043", "story_v_out_926041.awb")

						arg_179_1:RecordAudio("926041043", var_182_18)
						arg_179_1:RecordAudio("926041043", var_182_18)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_926041", "926041043", "story_v_out_926041.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_926041", "926041043", "story_v_out_926041.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_19 = math.max(var_182_12, arg_179_1.talkMaxDuration)

			if var_182_11 <= arg_179_1.time_ and arg_179_1.time_ < var_182_11 + var_182_19 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_11) / var_182_19

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_11 + var_182_19 and arg_179_1.time_ < var_182_11 + var_182_19 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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
				actorName = "106603",
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
	Play926041044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 926041044
		arg_183_1.duration_ = 12.87

		local var_183_0 = {
			zh = 10.5326666666667,
			ja = 12.8666666666667
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
				arg_183_0:Play926041045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if arg_183_1.bgs_.SP92601 == nil then
				local var_186_0 = Object.Instantiate(arg_183_1.paintGo_)

				var_186_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SP92601")
				var_186_0.name = "SP92601"
				var_186_0.transform.parent = arg_183_1.stage_.transform
				var_186_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.bgs_.SP92601 = var_186_0
			end

			if 1.96666666666667 < arg_183_1.time_ and arg_183_1.time_ <= 1.96666666666667 + arg_186_0 then
				local var_186_1 = arg_183_1.bgs_.SP92601

				arg_183_1.bgs_.SP92601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_186_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_2 = var_186_1:GetComponent("SpriteRenderer")

				if var_186_2 and var_186_2.sprite then
					local var_186_3 = 2 * (var_186_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_186_1.transform.localScale = Vector3.New(var_186_3 / var_186_2.sprite.bounds.size.y < var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x and var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x or var_186_3 / var_186_2.sprite.bounds.size.y, var_186_3 / var_186_2.sprite.bounds.size.y < var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x and var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x or var_186_3 / var_186_2.sprite.bounds.size.y, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "SP92601" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_4 = 2

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			if arg_183_1.time_ >= var_186_4 + 0.3 and arg_183_1.time_ < var_186_4 + 0.3 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			local var_186_5 = 0

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_6 = 2

			if var_186_5 <= arg_183_1.time_ and arg_183_1.time_ < var_186_5 + var_186_6 then
				local var_186_7 = Color.New(0, 0, 0)

				var_186_7.a = Mathf.Lerp(0, 1, (arg_183_1.time_ - var_186_5) / var_186_6)
				arg_183_1.mask_.color = var_186_7
			end

			if arg_183_1.time_ >= var_186_5 + var_186_6 and arg_183_1.time_ < var_186_5 + var_186_6 + arg_186_0 then
				local var_186_8 = Color.New(0, 0, 0)

				var_186_8.a = 1
				arg_183_1.mask_.color = var_186_8
			end

			local var_186_9 = 2

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_9 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_10 = 2

			if var_186_9 <= arg_183_1.time_ and arg_183_1.time_ < var_186_9 + var_186_10 then
				local var_186_11 = Color.New(0, 0, 0)

				var_186_11.a = Mathf.Lerp(1, 0, (arg_183_1.time_ - var_186_9) / var_186_10)
				arg_183_1.mask_.color = var_186_11
			end

			if arg_183_1.time_ >= var_186_9 + var_186_10 and arg_183_1.time_ < var_186_9 + var_186_10 + arg_186_0 then
				local var_186_12 = Color.New(0, 0, 0)

				arg_183_1.mask_.enabled = false
				var_186_12.a = 0
				arg_183_1.mask_.color = var_186_12
			end

			local var_186_13 = arg_183_1.actors_["104701"]

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 and not isNil(var_186_13) and arg_183_1.var_.actorSpriteComps104701 == nil then
				arg_183_1.var_.actorSpriteComps104701 = var_186_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_14 = 0.2

			if 2 <= arg_183_1.time_ and arg_183_1.time_ < 2 + var_186_14 and not isNil(var_186_13) then
				if arg_183_1.var_.actorSpriteComps104701 then
					for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_186_3 then
							if arg_183_1.isInRecall_ then
								iter_186_3.color = Color.New(Mathf.Lerp(iter_186_3.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 2) / var_186_14), Mathf.Lerp(iter_186_3.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 2) / var_186_14), (Mathf.Lerp(iter_186_3.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 2) / var_186_14)))
							else
								local var_186_15 = Mathf.Lerp(iter_186_3.color.r, 1, (arg_183_1.time_ - 2) / var_186_14)

								iter_186_3.color = Color.New(var_186_15, var_186_15, var_186_15)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 2 + var_186_14 and arg_183_1.time_ < 2 + var_186_14 + arg_186_0 and not isNil(var_186_13) and arg_183_1.var_.actorSpriteComps104701 then
				for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_186_5 then
						iter_186_5.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps104701 = nil
			end

			local var_186_16 = arg_183_1.actors_["106603"]

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 and not isNil(var_186_16) and arg_183_1.var_.actorSpriteComps106603 == nil then
				arg_183_1.var_.actorSpriteComps106603 = var_186_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_17 = 0.2

			if 2 <= arg_183_1.time_ and arg_183_1.time_ < 2 + var_186_17 and not isNil(var_186_16) then
				if arg_183_1.var_.actorSpriteComps106603 then
					for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_186_7 then
							if arg_183_1.isInRecall_ then
								iter_186_7.color = Color.New(Mathf.Lerp(iter_186_7.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 2) / var_186_17), Mathf.Lerp(iter_186_7.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 2) / var_186_17), (Mathf.Lerp(iter_186_7.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 2) / var_186_17)))
							else
								local var_186_18 = Mathf.Lerp(iter_186_7.color.r, 0.5, (arg_183_1.time_ - 2) / var_186_17)

								iter_186_7.color = Color.New(var_186_18, var_186_18, var_186_18)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 2 + var_186_17 and arg_183_1.time_ < 2 + var_186_17 + arg_186_0 and not isNil(var_186_16) and arg_183_1.var_.actorSpriteComps106603 then
				for iter_186_8, iter_186_9 in pairs(arg_183_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_186_9 then
						iter_186_9.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps106603 = nil
			end

			local var_186_19 = arg_183_1.actors_["104701"].transform

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				arg_183_1.var_.moveOldPos104701 = var_186_19.localPosition
				var_186_19.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("104701", 7)

				for iter_186_10 = 0, var_186_19.childCount - 1 do
					local var_186_20 = var_186_19:GetChild(iter_186_10)

					if var_186_20.name == "" or not string.find(var_186_20.name, "split") then
						var_186_20.gameObject:SetActive(true)
					else
						var_186_20.gameObject:SetActive(false)
					end
				end
			end

			local var_186_21 = 0.001

			if 2 <= arg_183_1.time_ and arg_183_1.time_ < 2 + var_186_21 then
				var_186_19.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_183_1.time_ - 2) / var_186_21)
			end

			if arg_183_1.time_ >= 2 + var_186_21 and arg_183_1.time_ < 2 + var_186_21 + arg_186_0 then
				var_186_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_22 = arg_183_1.actors_["106603"].transform

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				arg_183_1.var_.moveOldPos106603 = var_186_22.localPosition
				var_186_22.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("106603", 7)

				for iter_186_11 = 0, var_186_22.childCount - 1 do
					local var_186_23 = var_186_22:GetChild(iter_186_11)

					if var_186_23.name == "" or not string.find(var_186_23.name, "split") then
						var_186_23.gameObject:SetActive(true)
					else
						var_186_23.gameObject:SetActive(false)
					end
				end
			end

			local var_186_24 = 0.001

			if 2 <= arg_183_1.time_ and arg_183_1.time_ < 2 + var_186_24 then
				var_186_22.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_183_1.time_ - 2) / var_186_24)
			end

			if arg_183_1.time_ >= 2 + var_186_24 and arg_183_1.time_ < 2 + var_186_24 + arg_186_0 then
				var_186_22.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.53333333333333 < arg_183_1.time_ and arg_183_1.time_ <= 1.53333333333333 + arg_186_0 then
				arg_183_1:AudioAction("play", "effect", "se_story_1210", "se_story_1210_morning_loop", "")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_186_28 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_183_1.bgmTxt_.text ~= var_186_28 and arg_183_1.bgmTxt_.text ~= "" then
						if arg_183_1.bgmTxt2_.text ~= "" then
							arg_183_1.bgmTxt_.text = arg_183_1.bgmTxt2_.text
						end

						arg_183_1.bgmTxt2_.text = var_186_28

						arg_183_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_183_1.bgmTxt_.text = var_186_28
						arg_183_1.bgmTxt2_.text = var_186_28
					end

					if arg_183_1.bgmTimer then
						arg_183_1.bgmTimer:Stop()

						arg_183_1.bgmTimer = nil
					end

					if arg_183_1.settingData.show_music_name == 1 then
						arg_183_1.musicController:SetSelectedState("show")
						arg_183_1.musicAnimator_:Play("open", 0, 0)

						if arg_183_1.settingData.music_time ~= 0 then
							arg_183_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_183_1.settingData.music_time), function()
								if arg_183_1 == nil or isNil(arg_183_1.bgmTxt_) then
									return
								end

								arg_183_1.musicController:SetSelectedState("hide")
								arg_183_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.53333333333333 < arg_183_1.time_ and arg_183_1.time_ <= 1.53333333333333 + arg_186_0 then
				arg_183_1:AudioAction("play", "music", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")

				local var_186_31 = manager.audio:GetAudioName("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern")

				if "" ~= "" then
					if arg_183_1.bgmTxt_.text ~= var_186_31 and arg_183_1.bgmTxt_.text ~= "" then
						if arg_183_1.bgmTxt2_.text ~= "" then
							arg_183_1.bgmTxt_.text = arg_183_1.bgmTxt2_.text
						end

						arg_183_1.bgmTxt2_.text = var_186_31

						arg_183_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_183_1.bgmTxt_.text = var_186_31
						arg_183_1.bgmTxt2_.text = var_186_31
					end

					if arg_183_1.bgmTimer then
						arg_183_1.bgmTimer:Stop()

						arg_183_1.bgmTimer = nil
					end

					if arg_183_1.settingData.show_music_name == 1 then
						arg_183_1.musicController:SetSelectedState("show")
						arg_183_1.musicAnimator_:Play("open", 0, 0)

						if arg_183_1.settingData.music_time ~= 0 then
							arg_183_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_183_1.settingData.music_time), function()
								if arg_183_1 == nil or isNil(arg_183_1.bgmTxt_) then
									return
								end

								arg_183_1.musicController:SetSelectedState("hide")
								arg_183_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.466666666666667 < arg_183_1.time_ and arg_183_1.time_ <= 0.466666666666667 + arg_186_0 then
				arg_183_1:AudioAction("stop", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			local var_186_33 = arg_183_1.bgs_.SP92601.transform

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				arg_183_1.var_.moveOldPosSP92601 = var_186_33.localPosition
			end

			local var_186_34 = 0.001

			if 2 <= arg_183_1.time_ and arg_183_1.time_ < 2 + var_186_34 then
				var_186_33.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPosSP92601, Vector3.New(0, 1, 7), (arg_183_1.time_ - 2) / var_186_34)
			end

			if arg_183_1.time_ >= 2 + var_186_34 and arg_183_1.time_ < 2 + var_186_34 + arg_186_0 then
				var_186_33.localPosition = Vector3.New(0, 1, 7)
			end

			local var_186_35 = arg_183_1.bgs_.SP92601.transform

			if 2.034 < arg_183_1.time_ and arg_183_1.time_ <= 2.034 + arg_186_0 then
				arg_183_1.var_.moveOldPosSP92601 = var_186_35.localPosition
			end

			local var_186_36 = 1.89933333333333

			if 2.034 <= arg_183_1.time_ and arg_183_1.time_ < 2.034 + var_186_36 then
				var_186_35.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPosSP92601, Vector3.New(0, 1, 9), (arg_183_1.time_ - 2.034) / var_186_36)
			end

			if arg_183_1.time_ >= 2.034 + var_186_36 and arg_183_1.time_ < 2.034 + var_186_36 + arg_186_0 then
				var_186_35.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_37 = 3.76666666666667
			local var_186_38 = 0.825

			if 3.76666666666667 < arg_183_1.time_ and arg_183_1.time_ <= var_186_37 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_39 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_39:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_183_1.dialogCg_.alpha = arg_189_0
				end))
				var_186_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_40 = arg_183_1:GetWordFromCfg(926041044)
				local var_186_41 = arg_183_1:FormatText(var_186_40.content)

				arg_183_1.text_.text = var_186_41

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_43 = 33 <= 0 and var_186_38 or var_186_38 * (utf8.len(var_186_41) / 33)

				if (33 <= 0 and var_186_38 or var_186_38 * (utf8.len(var_186_41) / 33)) > 0 and var_186_38 < var_186_43 then
					arg_183_1.talkMaxDuration = var_186_43
					var_186_37 = var_186_37 + 0.3

					if var_186_43 + var_186_37 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_43 + var_186_37
					end
				end

				arg_183_1.text_.text = var_186_41
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041044", "story_v_out_926041.awb") ~= 0 then
					local var_186_44 = manager.audio:GetVoiceLength("story_v_out_926041", "926041044", "story_v_out_926041.awb") / 1000

					if var_186_44 + var_186_37 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_44 + var_186_37
					end

					if var_186_40.prefab_name ~= "" and arg_183_1.actors_[var_186_40.prefab_name] ~= nil then
						local var_186_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_40.prefab_name].transform, "story_v_out_926041", "926041044", "story_v_out_926041.awb")

						arg_183_1:RecordAudio("926041044", var_186_45)
						arg_183_1:RecordAudio("926041044", var_186_45)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_926041", "926041044", "story_v_out_926041.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_926041", "926041044", "story_v_out_926041.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_46 = var_186_37 + 0.3
			local var_186_47 = math.max(var_186_38, arg_183_1.talkMaxDuration)

			if var_186_37 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_46 + var_186_47 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_46) / var_186_47

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_46 + var_186_47 and arg_183_1.time_ < var_186_46 + var_186_47 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SP92601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0339999999999998,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SP92601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.89933333333333,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play926041045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 926041045
		arg_191_1.duration_ = 4.4

		local var_191_0 = {
			zh = 3.2,
			ja = 4.4
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
				arg_191_0:Play926041046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["106603"]) and arg_191_1.var_.actorSpriteComps106603 == nil then
				arg_191_1.var_.actorSpriteComps106603 = arg_191_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_0 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["106603"]) then
				if arg_191_1.var_.actorSpriteComps106603 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								iter_194_1.color = Color.New(Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_0), Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_0), (Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_0)))
							else
								local var_194_1 = Mathf.Lerp(iter_194_1.color.r, 1, (arg_191_1.time_ - 0) / var_194_0)

								iter_194_1.color = Color.New(var_194_1, var_194_1, var_194_1)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["106603"]) and arg_191_1.var_.actorSpriteComps106603 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_194_3 then
						iter_194_3.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps106603 = nil
			end

			local var_194_2 = arg_191_1.actors_["104701"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps104701 == nil then
				arg_191_1.var_.actorSpriteComps104701 = var_194_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_3 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.actorSpriteComps104701 then
					for iter_194_4, iter_194_5 in pairs(arg_191_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_194_5 then
							if arg_191_1.isInRecall_ then
								iter_194_5.color = Color.New(Mathf.Lerp(iter_194_5.color.r, arg_191_1.hightColor2.r, (arg_191_1.time_ - 0) / var_194_3), Mathf.Lerp(iter_194_5.color.g, arg_191_1.hightColor2.g, (arg_191_1.time_ - 0) / var_194_3), (Mathf.Lerp(iter_194_5.color.b, arg_191_1.hightColor2.b, (arg_191_1.time_ - 0) / var_194_3)))
							else
								local var_194_4 = Mathf.Lerp(iter_194_5.color.r, 0.5, (arg_191_1.time_ - 0) / var_194_3)

								iter_194_5.color = Color.New(var_194_4, var_194_4, var_194_4)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps104701 then
				for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_194_7 then
						iter_194_7.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_191_1.var_.actorSpriteComps104701 = nil
			end

			local var_194_5 = arg_191_1.actors_["104701"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos104701 = var_194_5.localPosition
				var_194_5.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("104701", 7)

				for iter_194_8 = 0, var_194_5.childCount - 1 do
					local var_194_6 = var_194_5:GetChild(iter_194_8)

					if var_194_6.name == "" or not string.find(var_194_6.name, "split") then
						var_194_6.gameObject:SetActive(true)
					else
						var_194_6.gameObject:SetActive(false)
					end
				end
			end

			local var_194_7 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				var_194_5.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_191_1.time_ - 0) / var_194_7)
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				var_194_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_194_8 = 0
			local var_194_9 = 0.3

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106603_split_1")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_10 = arg_191_1:GetWordFromCfg(926041045)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_13 = 12 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 12)

				if (12 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 12)) > 0 and var_194_9 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_8
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041045", "story_v_out_926041.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_926041", "926041045", "story_v_out_926041.awb") / 1000

					if var_194_14 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_8
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_926041", "926041045", "story_v_out_926041.awb")

						arg_191_1:RecordAudio("926041045", var_194_15)
						arg_191_1:RecordAudio("926041045", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_926041", "926041045", "story_v_out_926041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_926041", "926041045", "story_v_out_926041.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_9, arg_191_1.talkMaxDuration)

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_8) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_8 + var_194_16 and arg_191_1.time_ < var_194_8 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play926041046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 926041046
		arg_195_1.duration_ = 7.9

		local var_195_0 = {
			zh = 6.033,
			ja = 7.9
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
				arg_195_0:Play926041047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10144"]) and arg_195_1.var_.actorSpriteComps10144 == nil then
				arg_195_1.var_.actorSpriteComps10144 = arg_195_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10144"]) then
				if arg_195_1.var_.actorSpriteComps10144 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								iter_198_1.color = Color.New(Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor1.r, (arg_195_1.time_ - 0) / var_198_0), Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor1.g, (arg_195_1.time_ - 0) / var_198_0), (Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor1.b, (arg_195_1.time_ - 0) / var_198_0)))
							else
								local var_198_1 = Mathf.Lerp(iter_198_1.color.r, 1, (arg_195_1.time_ - 0) / var_198_0)

								iter_198_1.color = Color.New(var_198_1, var_198_1, var_198_1)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10144"]) and arg_195_1.var_.actorSpriteComps10144 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps10144 = nil
			end

			local var_198_2 = arg_195_1.actors_["106603"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps106603 == nil then
				arg_195_1.var_.actorSpriteComps106603 = var_198_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_3 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.actorSpriteComps106603 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_198_5 then
							if arg_195_1.isInRecall_ then
								iter_198_5.color = Color.New(Mathf.Lerp(iter_198_5.color.r, arg_195_1.hightColor2.r, (arg_195_1.time_ - 0) / var_198_3), Mathf.Lerp(iter_198_5.color.g, arg_195_1.hightColor2.g, (arg_195_1.time_ - 0) / var_198_3), (Mathf.Lerp(iter_198_5.color.b, arg_195_1.hightColor2.b, (arg_195_1.time_ - 0) / var_198_3)))
							else
								local var_198_4 = Mathf.Lerp(iter_198_5.color.r, 0.5, (arg_195_1.time_ - 0) / var_198_3)

								iter_198_5.color = Color.New(var_198_4, var_198_4, var_198_4)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps106603 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_198_7 then
						iter_198_7.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps106603 = nil
			end

			if 0.1 < arg_195_1.time_ and arg_195_1.time_ <= 0.1 + arg_198_0 then
				arg_195_1:AudioAction("play", "effect", "se_story_143", "se_story_143_heart_damage_funny", "")
			end

			local var_198_6 = 0
			local var_198_7 = 0.7

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:GetWordFromCfg(926041046)
				local var_198_9 = arg_195_1:FormatText(var_198_8.content)

				arg_195_1.text_.text = var_198_9

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 28 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 28)

				if (28 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 28)) > 0 and var_198_7 < var_198_11 then
					arg_195_1.talkMaxDuration = var_198_11

					if var_198_11 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_9
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041046", "story_v_out_926041.awb") ~= 0 then
					local var_198_12 = manager.audio:GetVoiceLength("story_v_out_926041", "926041046", "story_v_out_926041.awb") / 1000

					if var_198_12 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_6
					end

					if var_198_8.prefab_name ~= "" and arg_195_1.actors_[var_198_8.prefab_name] ~= nil then
						local var_198_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_8.prefab_name].transform, "story_v_out_926041", "926041046", "story_v_out_926041.awb")

						arg_195_1:RecordAudio("926041046", var_198_13)
						arg_195_1:RecordAudio("926041046", var_198_13)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_926041", "926041046", "story_v_out_926041.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_926041", "926041046", "story_v_out_926041.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play926041047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 926041047
		arg_199_1.duration_ = 7.83

		local var_199_0 = {
			zh = 5.2,
			ja = 7.833
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
				arg_199_0:Play926041048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.625

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(926041047)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 25 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 25)

				if (25 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 25)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041047", "story_v_out_926041.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_926041", "926041047", "story_v_out_926041.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_926041", "926041047", "story_v_out_926041.awb")

						arg_199_1:RecordAudio("926041047", var_202_6)
						arg_199_1:RecordAudio("926041047", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_926041", "926041047", "story_v_out_926041.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_926041", "926041047", "story_v_out_926041.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play926041048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 926041048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play926041049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10144"]) and arg_203_1.var_.actorSpriteComps10144 == nil then
				arg_203_1.var_.actorSpriteComps10144 = arg_203_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10144"]) then
				if arg_203_1.var_.actorSpriteComps10144 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor2.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor2.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor2.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 0.5, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10144"]) and arg_203_1.var_.actorSpriteComps10144 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_203_1.var_.actorSpriteComps10144 = nil
			end

			local var_206_2 = 0
			local var_206_3 = 0.175

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_4 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(926041048).content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_6 = 7 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_4) / 7)

				if (7 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_4) / 7)) > 0 and var_206_3 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_7 and arg_203_1.time_ < var_206_2 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play926041049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 926041049
		arg_207_1.duration_ = 7.9

		local var_207_0 = {
			zh = 7.6,
			ja = 7.9
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play926041050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["104701"]) and arg_207_1.var_.actorSpriteComps104701 == nil then
				arg_207_1.var_.actorSpriteComps104701 = arg_207_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_0 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["104701"]) then
				if arg_207_1.var_.actorSpriteComps104701 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								iter_210_1.color = Color.New(Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor1.r, (arg_207_1.time_ - 0) / var_210_0), Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor1.g, (arg_207_1.time_ - 0) / var_210_0), (Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor1.b, (arg_207_1.time_ - 0) / var_210_0)))
							else
								local var_210_1 = Mathf.Lerp(iter_210_1.color.r, 1, (arg_207_1.time_ - 0) / var_210_0)

								iter_210_1.color = Color.New(var_210_1, var_210_1, var_210_1)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["104701"]) and arg_207_1.var_.actorSpriteComps104701 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_210_3 then
						iter_210_3.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_207_1.var_.actorSpriteComps104701 = nil
			end

			local var_210_2 = arg_207_1.actors_["106603"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos106603 = var_210_2.localPosition
				var_210_2.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("106603", 7)

				for iter_210_4 = 0, var_210_2.childCount - 1 do
					local var_210_3 = var_210_2:GetChild(iter_210_4)

					if var_210_3.name == "" or not string.find(var_210_3.name, "split") then
						var_210_3.gameObject:SetActive(true)
					else
						var_210_3.gameObject:SetActive(false)
					end
				end
			end

			local var_210_4 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				var_210_2.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_207_1.time_ - 0) / var_210_4)
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				var_210_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_210_5 = arg_207_1.actors_["10144"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10144 = var_210_5.localPosition
				var_210_5.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10144", 7)

				for iter_210_5 = 0, var_210_5.childCount - 1 do
					local var_210_6 = var_210_5:GetChild(iter_210_5)

					if var_210_6.name == "" or not string.find(var_210_6.name, "split") then
						var_210_6.gameObject:SetActive(true)
					else
						var_210_6.gameObject:SetActive(false)
					end
				end
			end

			local var_210_7 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				var_210_5.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_207_1.time_ - 0) / var_210_7)
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				var_210_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_210_8 = arg_207_1.actors_["104701"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos104701 = var_210_8.localPosition
				var_210_8.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("104701", 7)

				for iter_210_6 = 0, var_210_8.childCount - 1 do
					local var_210_9 = var_210_8:GetChild(iter_210_6)

					if var_210_9.name == "" or not string.find(var_210_9.name, "split") then
						var_210_9.gameObject:SetActive(true)
					else
						var_210_9.gameObject:SetActive(false)
					end
				end
			end

			local var_210_10 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_10 then
				var_210_8.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_207_1.time_ - 0) / var_210_10)
			end

			if arg_207_1.time_ >= 0 + var_210_10 and arg_207_1.time_ < 0 + var_210_10 + arg_210_0 then
				var_210_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_210_11 = 0
			local var_210_12 = 0.85

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_11 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_13 = arg_207_1:GetWordFromCfg(926041049)
				local var_210_14 = arg_207_1:FormatText(var_210_13.content)

				arg_207_1.text_.text = var_210_14

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_16 = 34 <= 0 and var_210_12 or var_210_12 * (utf8.len(var_210_14) / 34)

				if (34 <= 0 and var_210_12 or var_210_12 * (utf8.len(var_210_14) / 34)) > 0 and var_210_12 < var_210_16 then
					arg_207_1.talkMaxDuration = var_210_16

					if var_210_16 + var_210_11 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_16 + var_210_11
					end
				end

				arg_207_1.text_.text = var_210_14
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041049", "story_v_out_926041.awb") ~= 0 then
					local var_210_17 = manager.audio:GetVoiceLength("story_v_out_926041", "926041049", "story_v_out_926041.awb") / 1000

					if var_210_17 + var_210_11 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_17 + var_210_11
					end

					if var_210_13.prefab_name ~= "" and arg_207_1.actors_[var_210_13.prefab_name] ~= nil then
						local var_210_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_13.prefab_name].transform, "story_v_out_926041", "926041049", "story_v_out_926041.awb")

						arg_207_1:RecordAudio("926041049", var_210_18)
						arg_207_1:RecordAudio("926041049", var_210_18)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_926041", "926041049", "story_v_out_926041.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_926041", "926041049", "story_v_out_926041.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_19 = math.max(var_210_12, arg_207_1.talkMaxDuration)

			if var_210_11 <= arg_207_1.time_ and arg_207_1.time_ < var_210_11 + var_210_19 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_11) / var_210_19

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_11 + var_210_19 and arg_207_1.time_ < var_210_11 + var_210_19 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play926041050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 926041050
		arg_211_1.duration_ = 3.9

		local var_211_0 = {
			zh = 2.933,
			ja = 3.9
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play926041051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.325

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:GetWordFromCfg(926041050)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 13 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 13)

				if (13 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 13)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041050", "story_v_out_926041.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_926041", "926041050", "story_v_out_926041.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_926041", "926041050", "story_v_out_926041.awb")

						arg_211_1:RecordAudio("926041050", var_214_6)
						arg_211_1:RecordAudio("926041050", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_926041", "926041050", "story_v_out_926041.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_926041", "926041050", "story_v_out_926041.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play926041051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 926041051
		arg_215_1.duration_ = 6.47

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play926041052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["10144"]) and arg_215_1.var_.actorSpriteComps10144 == nil then
				arg_215_1.var_.actorSpriteComps10144 = arg_215_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["10144"]) then
				if arg_215_1.var_.actorSpriteComps10144 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								iter_218_1.color = Color.New(Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor2.r, (arg_215_1.time_ - 0) / var_218_0), Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor2.g, (arg_215_1.time_ - 0) / var_218_0), (Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor2.b, (arg_215_1.time_ - 0) / var_218_0)))
							else
								local var_218_1 = Mathf.Lerp(iter_218_1.color.r, 0.5, (arg_215_1.time_ - 0) / var_218_0)

								iter_218_1.color = Color.New(var_218_1, var_218_1, var_218_1)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["10144"]) and arg_215_1.var_.actorSpriteComps10144 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_218_3 then
						iter_218_3.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_215_1.var_.actorSpriteComps10144 = nil
			end

			local var_218_2 = arg_215_1.bgs_.SP92601.transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPosSP92601 = var_218_2.localPosition
			end

			local var_218_3 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 then
				var_218_2.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPosSP92601, Vector3.New(0, 1, 6), (arg_215_1.time_ - 0) / var_218_3)
			end

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 then
				var_218_2.localPosition = Vector3.New(0, 1, 6)
			end

			local var_218_4 = arg_215_1.bgs_.SP92601.transform

			if 0.0339999999999998 < arg_215_1.time_ and arg_215_1.time_ <= 0.0339999999999998 + arg_218_0 then
				arg_215_1.var_.moveOldPosSP92601 = var_218_4.localPosition
			end

			local var_218_5 = 1.966

			if 0.0339999999999998 <= arg_215_1.time_ and arg_215_1.time_ < 0.0339999999999998 + var_218_5 then
				var_218_4.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPosSP92601, Vector3.New(0, 0.73, 4.06), (arg_215_1.time_ - 0.0339999999999998) / var_218_5)
			end

			if arg_215_1.time_ >= 0.0339999999999998 + var_218_5 and arg_215_1.time_ < 0.0339999999999998 + var_218_5 + arg_218_0 then
				var_218_4.localPosition = Vector3.New(0, 0.73, 4.06)
			end

			local var_218_6 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_7 = 1.26666666666667

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_7 then
				local var_218_8 = Color.New(1, 1, 1)

				var_218_8.a = Mathf.Lerp(1, 0, (arg_215_1.time_ - var_218_6) / var_218_7)
				arg_215_1.mask_.color = var_218_8
			end

			if arg_215_1.time_ >= var_218_6 + var_218_7 and arg_215_1.time_ < var_218_6 + var_218_7 + arg_218_0 then
				local var_218_9 = Color.New(1, 1, 1)

				arg_215_1.mask_.enabled = false
				var_218_9.a = 0
				arg_215_1.mask_.color = var_218_9
			end

			local var_218_10 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			if arg_215_1.time_ >= var_218_10 + 2.5 and arg_215_1.time_ < var_218_10 + 2.5 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			if 0.0339999999999998 < arg_215_1.time_ and arg_215_1.time_ <= 0.0339999999999998 + arg_218_0 then
				arg_215_1:AudioAction("play", "effect", "se_story_143", "se_story_143_door", "")
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_12 = 1.46666666666667
			local var_218_13 = 0.925

			if 1.46666666666667 < arg_215_1.time_ and arg_215_1.time_ <= var_218_12 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_14 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_14:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_15 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(926041051).content)

				arg_215_1.text_.text = var_218_15

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_17 = 37 <= 0 and var_218_13 or var_218_13 * (utf8.len(var_218_15) / 37)

				if (37 <= 0 and var_218_13 or var_218_13 * (utf8.len(var_218_15) / 37)) > 0 and var_218_13 < var_218_17 then
					arg_215_1.talkMaxDuration = var_218_17
					var_218_12 = var_218_12 + 0.3

					if var_218_17 + var_218_12 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_17 + var_218_12
					end
				end

				arg_215_1.text_.text = var_218_15
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_18 = var_218_12 + 0.3
			local var_218_19 = math.max(var_218_13, arg_215_1.talkMaxDuration)

			if var_218_12 + 0.3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_18 + var_218_19 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_18) / var_218_19

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_18 + var_218_19 and arg_215_1.time_ < var_218_18 + var_218_19 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SP92601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0339999999999998,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SP92601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966,
				className = "StoryMoveNode",
				startTime = 0.0339999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play926041052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 926041052
		arg_221_1.duration_ = 1.57

		local var_221_0 = {
			zh = 1.433,
			ja = 1.566
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
			arg_221_1.auto_ = false
		end

		function arg_221_1.playNext_(arg_223_0)
			arg_221_1.onStoryFinished_()
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.125

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(926041052)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 5 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 5)

				if (5 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 5)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041052", "story_v_out_926041.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_926041", "926041052", "story_v_out_926041.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_926041", "926041052", "story_v_out_926041.awb")

						arg_221_1:RecordAudio("926041052", var_224_6)
						arg_221_1:RecordAudio("926041052", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_926041", "926041052", "story_v_out_926041.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_926041", "926041052", "story_v_out_926041.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I22f",
		"TextureConfig/Background/SP92601"
	},
	voices = {
		"story_v_out_926041.awb"
	}
}
