return {
	Play413062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413062001
		arg_1_1.duration_ = 6.07

		local var_1_0 = {
			zh = 6.065999999999,
			ja = 5.265999999999
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
				arg_1_0:Play413062002(arg_1_1)
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

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "10092"

			if arg_1_1.actors_["10092"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

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

			local var_4_12 = arg_1_1.actors_["10092"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10092 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10092", 2)

				for iter_4_4 = 0, var_4_12.childCount - 1 do
					local var_4_13 = var_4_12:GetChild(iter_4_4)

					if var_4_13.name == "" or not string.find(var_4_13.name, "split") then
						var_4_13.gameObject:SetActive(true)
					else
						var_4_13.gameObject:SetActive(false)
					end
				end
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_1_1.time_ - 1.8) / var_4_14)
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_4_15 = arg_1_1.actors_["10092"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10092 == nil then
				arg_1_1.var_.actorSpriteComps10092 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps10092 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.8) / var_4_16), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.8) / var_4_16), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.8) / var_4_16)))
							else
								local var_4_17 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 1.8) / var_4_16)

								iter_4_6.color = Color.New(var_4_17, var_4_17, var_4_17)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10092 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10092 = nil
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue10092 = var_4_18.alpha
					arg_1_1.var_.characterEffect10092 = var_4_18
				end

				arg_1_1.var_.alphaOldValue10092 = 0
			end

			local var_4_19 = 0.5

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_19 then
				if arg_1_1.var_.characterEffect10092 then
					arg_1_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10092, 1, (arg_1_1.time_ - 1.8) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_19 and arg_1_1.time_ < 1.8 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect10092 then
				arg_1_1.var_.characterEffect10092.alpha = 1
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

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

			local var_4_26 = 1.999999999999
			local var_4_27 = 0.55

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(413062001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 22 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 22)

				if (22 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 22)) > 0 and var_4_27 < var_4_32 then
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

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062001", "story_v_out_413062.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_413062", "413062001", "story_v_out_413062.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_413062", "413062001", "story_v_out_413062.awb")

						arg_1_1:RecordAudio("413062001", var_4_34)
						arg_1_1:RecordAudio("413062001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413062", "413062001", "story_v_out_413062.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413062", "413062001", "story_v_out_413062.awb")
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
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play413062002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413062002
		arg_9_1.duration_ = 9.63

		local var_9_0 = {
			zh = 6.4,
			ja = 9.633
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
				arg_9_0:Play413062003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.65

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(413062002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 26 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 26)

				if (26 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 26)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062002", "story_v_out_413062.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062002", "story_v_out_413062.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_413062", "413062002", "story_v_out_413062.awb")

						arg_9_1:RecordAudio("413062002", var_12_6)
						arg_9_1:RecordAudio("413062002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413062", "413062002", "story_v_out_413062.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413062", "413062002", "story_v_out_413062.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play413062003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413062003
		arg_13_1.duration_ = 3.83

		local var_13_0 = {
			zh = 3.4,
			ja = 3.833
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
				arg_13_0:Play413062004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10093"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "10093"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["10093"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["10093"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10093 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10093", 4)

				for iter_16_2 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_2)

					if var_16_3.name == "split_6" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_16_5 = arg_13_1.actors_["10092"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps10092 == nil then
				arg_13_1.var_.actorSpriteComps10092 = var_16_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.actorSpriteComps10092 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								iter_16_4.color = Color.New(Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_6), Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_6), (Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_6)))
							else
								local var_16_7 = Mathf.Lerp(iter_16_4.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_6)

								iter_16_4.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps10092 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_16_6 then
						iter_16_6.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10092 = nil
			end

			local var_16_8 = arg_13_1.actors_["10093"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10093 == nil then
				arg_13_1.var_.actorSpriteComps10093 = var_16_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 and not isNil(var_16_8) then
				if arg_13_1.var_.actorSpriteComps10093 then
					for iter_16_7, iter_16_8 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_16_8 then
							if arg_13_1.isInRecall_ then
								iter_16_8.color = Color.New(Mathf.Lerp(iter_16_8.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_9), Mathf.Lerp(iter_16_8.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_9), (Mathf.Lerp(iter_16_8.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_9)))
							else
								local var_16_10 = Mathf.Lerp(iter_16_8.color.r, 1, (arg_13_1.time_ - 0) / var_16_9)

								iter_16_8.color = Color.New(var_16_10, var_16_10, var_16_10)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10093 then
				for iter_16_9, iter_16_10 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_16_10 then
						iter_16_10.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10093 = nil
			end

			local var_16_11 = 0
			local var_16_12 = 0.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
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

				local var_16_13 = arg_13_1:GetWordFromCfg(413062003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 18 <= 0 and var_16_12 or var_16_12 * (utf8.len(var_16_14) / 18)

				if (18 <= 0 and var_16_12 or var_16_12 * (utf8.len(var_16_14) / 18)) > 0 and var_16_12 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16

					if var_16_16 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062003", "story_v_out_413062.awb") ~= 0 then
					local var_16_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062003", "story_v_out_413062.awb") / 1000

					if var_16_17 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_11
					end

					if var_16_13.prefab_name ~= "" and arg_13_1.actors_[var_16_13.prefab_name] ~= nil then
						local var_16_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_13.prefab_name].transform, "story_v_out_413062", "413062003", "story_v_out_413062.awb")

						arg_13_1:RecordAudio("413062003", var_16_18)
						arg_13_1:RecordAudio("413062003", var_16_18)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413062", "413062003", "story_v_out_413062.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413062", "413062003", "story_v_out_413062.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_19 = math.max(var_16_12, arg_13_1.talkMaxDuration)

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_19 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_11) / var_16_19

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_11 + var_16_19 and arg_13_1.time_ < var_16_11 + var_16_19 + arg_16_0 then
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
	Play413062004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413062004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play413062005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10093 = arg_17_1.actors_["10093"].transform.localPosition
				arg_17_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10093", 7)

				for iter_20_0 = 0, arg_17_1.actors_["10093"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["10093"].transform:GetChild(iter_20_0)

					if var_20_0.name == "" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_2 = arg_17_1.actors_["10093"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10093 == nil then
				arg_17_1.var_.actorSpriteComps10093 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps10093 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_20_2 then
							if arg_17_1.isInRecall_ then
								iter_20_2.color = Color.New(Mathf.Lerp(iter_20_2.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_2.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_2.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_2.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_2.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10093 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps10093 = nil
			end

			local var_20_5 = arg_17_1.actors_["10092"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10092 = var_20_5.localPosition
				var_20_5.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10092", 7)

				for iter_20_5 = 0, var_20_5.childCount - 1 do
					local var_20_6 = var_20_5:GetChild(iter_20_5)

					if var_20_6.name == "" or not string.find(var_20_6.name, "split") then
						var_20_6.gameObject:SetActive(true)
					else
						var_20_6.gameObject:SetActive(false)
					end
				end
			end

			local var_20_7 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_17_1.time_ - 0) / var_20_7)
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_8 = 0
			local var_20_9 = 1.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(413062004).content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_12 = 65 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_10) / 65)

				if (65 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_10) / 65)) > 0 and var_20_9 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_13 and arg_17_1.time_ < var_20_8 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play413062005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413062005
		arg_21_1.duration_ = 3.47

		local var_21_0 = {
			zh = 3.466,
			ja = 1.999999999999
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
				arg_21_0:Play413062006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10093 = arg_21_1.actors_["10093"].transform.localPosition
				arg_21_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10093", 3)

				for iter_24_0 = 0, arg_21_1.actors_["10093"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10093"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
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

			local var_24_2 = arg_21_1.actors_["10093"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10093 == nil then
				arg_21_1.var_.actorSpriteComps10093 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10093 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_24_2 then
							if arg_21_1.isInRecall_ then
								iter_24_2.color = Color.New(Mathf.Lerp(iter_24_2.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_2.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_2.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_2.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_2.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10093 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_24_4 then
						iter_24_4.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10093 = nil
			end

			local var_24_5 = 0
			local var_24_6 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
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

				local var_24_7 = arg_21_1:GetWordFromCfg(413062005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 17 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 17)

				if (17 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 17)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062005", "story_v_out_413062.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062005", "story_v_out_413062.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_413062", "413062005", "story_v_out_413062.awb")

						arg_21_1:RecordAudio("413062005", var_24_12)
						arg_21_1:RecordAudio("413062005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413062", "413062005", "story_v_out_413062.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413062", "413062005", "story_v_out_413062.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_13 and arg_21_1.time_ < var_24_5 + var_24_13 + arg_24_0 then
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
	Play413062006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413062006
		arg_25_1.duration_ = 7.37

		local var_25_0 = {
			zh = 4,
			ja = 7.366
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
				arg_25_0:Play413062007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.625

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
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

				local var_28_1 = arg_25_1:GetWordFromCfg(413062006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 25 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 25)

				if (25 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 25)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062006", "story_v_out_413062.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062006", "story_v_out_413062.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_413062", "413062006", "story_v_out_413062.awb")

						arg_25_1:RecordAudio("413062006", var_28_6)
						arg_25_1:RecordAudio("413062006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413062", "413062006", "story_v_out_413062.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413062", "413062006", "story_v_out_413062.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play413062007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413062007
		arg_29_1.duration_ = 2.77

		local var_29_0 = {
			zh = 1.999999999999,
			ja = 2.766
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
				arg_29_0:Play413062008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10093 = arg_29_1.actors_["10093"].transform.localPosition
				arg_29_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10093", 0)

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
				arg_29_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10093, Vector3.New(-5000, -345, -245), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10093"].transform.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_32_2 = arg_29_1.actors_["10092"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10092 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10092", 0)

				for iter_32_1 = 0, var_32_2.childCount - 1 do
					local var_32_3 = var_32_2:GetChild(iter_32_1)

					if var_32_3.name == "" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_29_1.time_ - 0) / var_32_4)
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_32_5 = "10094"

			if arg_29_1.actors_["10094"] == nil then
				local var_32_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_32_6) then
					local var_32_7 = Object.Instantiate(var_32_6, arg_29_1.canvasGo_.transform)

					var_32_7.transform:SetSiblingIndex(1)

					var_32_7.name = var_32_5
					var_32_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_[var_32_5] = var_32_7

					if arg_29_1.isInRecall_ then
						for iter_32_2, iter_32_3 in ipairs((var_32_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_8 = arg_29_1.actors_["10094"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10094 = var_32_8.localPosition
				var_32_8.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10094", 3)

				for iter_32_4 = 0, var_32_8.childCount - 1 do
					local var_32_9 = var_32_8:GetChild(iter_32_4)

					if var_32_9.name == "" or not string.find(var_32_9.name, "split") then
						var_32_9.gameObject:SetActive(true)
					else
						var_32_9.gameObject:SetActive(false)
					end
				end
			end

			local var_32_10 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_10 then
				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_29_1.time_ - 0) / var_32_10)
			end

			if arg_29_1.time_ >= 0 + var_32_10 and arg_29_1.time_ < 0 + var_32_10 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(0, -340, -414)
			end

			local var_32_11 = arg_29_1.actors_["10093"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_11) and arg_29_1.var_.actorSpriteComps10093 == nil then
				arg_29_1.var_.actorSpriteComps10093 = var_32_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_12 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_12 and not isNil(var_32_11) then
				if arg_29_1.var_.actorSpriteComps10093 then
					for iter_32_5, iter_32_6 in pairs(arg_29_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_32_6 then
							if arg_29_1.isInRecall_ then
								iter_32_6.color = Color.New(Mathf.Lerp(iter_32_6.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_12), Mathf.Lerp(iter_32_6.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_12), (Mathf.Lerp(iter_32_6.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_12)))
							else
								local var_32_13 = Mathf.Lerp(iter_32_6.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_12)

								iter_32_6.color = Color.New(var_32_13, var_32_13, var_32_13)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_12 and arg_29_1.time_ < 0 + var_32_12 + arg_32_0 and not isNil(var_32_11) and arg_29_1.var_.actorSpriteComps10093 then
				for iter_32_7, iter_32_8 in pairs(arg_29_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_32_8 then
						iter_32_8.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10093 = nil
			end

			local var_32_14 = arg_29_1.actors_["10092"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps10092 == nil then
				arg_29_1.var_.actorSpriteComps10092 = var_32_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_15 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_15 and not isNil(var_32_14) then
				if arg_29_1.var_.actorSpriteComps10092 then
					for iter_32_9, iter_32_10 in pairs(arg_29_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_32_10 then
							if arg_29_1.isInRecall_ then
								iter_32_10.color = Color.New(Mathf.Lerp(iter_32_10.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_15), Mathf.Lerp(iter_32_10.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_15), (Mathf.Lerp(iter_32_10.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_15)))
							else
								local var_32_16 = Mathf.Lerp(iter_32_10.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_15)

								iter_32_10.color = Color.New(var_32_16, var_32_16, var_32_16)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_15 and arg_29_1.time_ < 0 + var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps10092 then
				for iter_32_11, iter_32_12 in pairs(arg_29_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_32_12 then
						iter_32_12.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10092 = nil
			end

			local var_32_17 = arg_29_1.actors_["10094"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_17) and arg_29_1.var_.actorSpriteComps10094 == nil then
				arg_29_1.var_.actorSpriteComps10094 = var_32_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_18 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_18 and not isNil(var_32_17) then
				if arg_29_1.var_.actorSpriteComps10094 then
					for iter_32_13, iter_32_14 in pairs(arg_29_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_32_14 then
							if arg_29_1.isInRecall_ then
								iter_32_14.color = Color.New(Mathf.Lerp(iter_32_14.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_18), Mathf.Lerp(iter_32_14.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_18), (Mathf.Lerp(iter_32_14.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_18)))
							else
								local var_32_19 = Mathf.Lerp(iter_32_14.color.r, 1, (arg_29_1.time_ - 0) / var_32_18)

								iter_32_14.color = Color.New(var_32_19, var_32_19, var_32_19)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_18 and arg_29_1.time_ < 0 + var_32_18 + arg_32_0 and not isNil(var_32_17) and arg_29_1.var_.actorSpriteComps10094 then
				for iter_32_15, iter_32_16 in pairs(arg_29_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_32_16 then
						iter_32_16.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10094 = nil
			end

			local var_32_20 = 0
			local var_32_21 = 0.2

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_22 = arg_29_1:GetWordFromCfg(413062007)
				local var_32_23 = arg_29_1:FormatText(var_32_22.content)

				arg_29_1.text_.text = var_32_23

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_25 = 8 <= 0 and var_32_21 or var_32_21 * (utf8.len(var_32_23) / 8)

				if (8 <= 0 and var_32_21 or var_32_21 * (utf8.len(var_32_23) / 8)) > 0 and var_32_21 < var_32_25 then
					arg_29_1.talkMaxDuration = var_32_25

					if var_32_25 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_25 + var_32_20
					end
				end

				arg_29_1.text_.text = var_32_23
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062007", "story_v_out_413062.awb") ~= 0 then
					local var_32_26 = manager.audio:GetVoiceLength("story_v_out_413062", "413062007", "story_v_out_413062.awb") / 1000

					if var_32_26 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_26 + var_32_20
					end

					if var_32_22.prefab_name ~= "" and arg_29_1.actors_[var_32_22.prefab_name] ~= nil then
						local var_32_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_22.prefab_name].transform, "story_v_out_413062", "413062007", "story_v_out_413062.awb")

						arg_29_1:RecordAudio("413062007", var_32_27)
						arg_29_1:RecordAudio("413062007", var_32_27)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413062", "413062007", "story_v_out_413062.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413062", "413062007", "story_v_out_413062.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_28 = math.max(var_32_21, arg_29_1.talkMaxDuration)

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_28 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_20) / var_32_28

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_20 + var_32_28 and arg_29_1.time_ < var_32_20 + var_32_28 + arg_32_0 then
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

		arg_29_1:InitPlayNodeList()
	end,
	Play413062008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413062008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play413062009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10094 = arg_33_1.actors_["10094"].transform.localPosition
				arg_33_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10094", 3)

				for iter_36_0 = 0, arg_33_1.actors_["10094"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["10094"].transform:GetChild(iter_36_0)

					if var_36_0.name == "" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_36_2 = arg_33_1.actors_["10094"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10094 == nil then
				arg_33_1.var_.actorSpriteComps10094 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps10094 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								iter_36_2.color = Color.New(Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_2.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_2.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10094 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_36_4 then
						iter_36_4.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10094 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 1.625

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(413062008).content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 65 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_7) / 65)

				if (65 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_7) / 65)) > 0 and var_36_6 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_10 and arg_33_1.time_ < var_36_5 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play413062009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413062009
		arg_37_1.duration_ = 4.07

		local var_37_0 = {
			zh = 3.333,
			ja = 4.066
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
				arg_37_0:Play413062010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10094 = arg_37_1.actors_["10094"].transform.localPosition
				arg_37_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10094", 3)

				for iter_40_0 = 0, arg_37_1.actors_["10094"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["10094"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_2" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_40_2 = arg_37_1.actors_["10094"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10094 == nil then
				arg_37_1.var_.actorSpriteComps10094 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps10094 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								iter_40_2.color = Color.New(Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_2.color.r, 1, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_2.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10094 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10094 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 0.3

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(413062009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 12 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 12)

				if (12 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 12)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062009", "story_v_out_413062.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062009", "story_v_out_413062.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_413062", "413062009", "story_v_out_413062.awb")

						arg_37_1:RecordAudio("413062009", var_40_12)
						arg_37_1:RecordAudio("413062009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413062", "413062009", "story_v_out_413062.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413062", "413062009", "story_v_out_413062.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_13 and arg_37_1.time_ < var_40_5 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play413062010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413062010
		arg_41_1.duration_ = 5.4

		local var_41_0 = {
			zh = 4.533,
			ja = 5.4
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
				arg_41_0:Play413062011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10092 = arg_41_1.actors_["10092"].transform.localPosition
				arg_41_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10092", 3)

				for iter_44_0 = 0, arg_41_1.actors_["10092"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10092"].transform:GetChild(iter_44_0)

					if var_44_0.name == "split_5" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_44_2 = arg_41_1.actors_["10094"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10094 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10094", 0)

				for iter_44_1 = 0, var_44_2.childCount - 1 do
					local var_44_3 = var_44_2:GetChild(iter_44_1)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_44_5 = arg_41_1.actors_["10092"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps10092 == nil then
				arg_41_1.var_.actorSpriteComps10092 = var_44_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_6 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.actorSpriteComps10092 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_44_3 then
							if arg_41_1.isInRecall_ then
								iter_44_3.color = Color.New(Mathf.Lerp(iter_44_3.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_6), Mathf.Lerp(iter_44_3.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_6), (Mathf.Lerp(iter_44_3.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_6)))
							else
								local var_44_7 = Mathf.Lerp(iter_44_3.color.r, 1, (arg_41_1.time_ - 0) / var_44_6)

								iter_44_3.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps10092 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_44_5 then
						iter_44_5.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10092 = nil
			end

			local var_44_8 = arg_41_1.actors_["10094"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10094 == nil then
				arg_41_1.var_.actorSpriteComps10094 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_9 and not isNil(var_44_8) then
				if arg_41_1.var_.actorSpriteComps10094 then
					for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_44_7 then
							if arg_41_1.isInRecall_ then
								iter_44_7.color = Color.New(Mathf.Lerp(iter_44_7.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_9), Mathf.Lerp(iter_44_7.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_9), (Mathf.Lerp(iter_44_7.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_9)))
							else
								local var_44_10 = Mathf.Lerp(iter_44_7.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_9)

								iter_44_7.color = Color.New(var_44_10, var_44_10, var_44_10)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10094 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_44_9 then
						iter_44_9.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10094 = nil
			end

			local var_44_11 = 0
			local var_44_12 = 0.65

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_13 = arg_41_1:GetWordFromCfg(413062010)
				local var_44_14 = arg_41_1:FormatText(var_44_13.content)

				arg_41_1.text_.text = var_44_14

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 26 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 26)

				if (26 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 26)) > 0 and var_44_12 < var_44_16 then
					arg_41_1.talkMaxDuration = var_44_16

					if var_44_16 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_14
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062010", "story_v_out_413062.awb") ~= 0 then
					local var_44_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062010", "story_v_out_413062.awb") / 1000

					if var_44_17 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_11
					end

					if var_44_13.prefab_name ~= "" and arg_41_1.actors_[var_44_13.prefab_name] ~= nil then
						local var_44_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_13.prefab_name].transform, "story_v_out_413062", "413062010", "story_v_out_413062.awb")

						arg_41_1:RecordAudio("413062010", var_44_18)
						arg_41_1:RecordAudio("413062010", var_44_18)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413062", "413062010", "story_v_out_413062.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413062", "413062010", "story_v_out_413062.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_19 = math.max(var_44_12, arg_41_1.talkMaxDuration)

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_19 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_11) / var_44_19

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_11 + var_44_19 and arg_41_1.time_ < var_44_11 + var_44_19 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play413062011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413062011
		arg_45_1.duration_ = 8.37

		local var_45_0 = {
			zh = 8.366,
			ja = 5.533
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
				arg_45_0:Play413062012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.925

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(413062011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 37 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 37)

				if (37 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 37)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062011", "story_v_out_413062.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062011", "story_v_out_413062.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_413062", "413062011", "story_v_out_413062.awb")

						arg_45_1:RecordAudio("413062011", var_48_6)
						arg_45_1:RecordAudio("413062011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413062", "413062011", "story_v_out_413062.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413062", "413062011", "story_v_out_413062.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play413062012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413062012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play413062013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10092"]) and arg_49_1.var_.actorSpriteComps10092 == nil then
				arg_49_1.var_.actorSpriteComps10092 = arg_49_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10092"]) then
				if arg_49_1.var_.actorSpriteComps10092 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10092"]) and arg_49_1.var_.actorSpriteComps10092 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10092 = nil
			end

			local var_52_2 = 0
			local var_52_3 = 0.95

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(413062012).content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 33 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 33)

				if (33 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 33)) > 0 and var_52_3 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_7 and arg_49_1.time_ < var_52_2 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play413062013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413062013
		arg_53_1.duration_ = 5.6

		local var_53_0 = {
			zh = 5.6,
			ja = 3.266
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
				arg_53_0:Play413062014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10092 = arg_53_1.actors_["10092"].transform.localPosition
				arg_53_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10092", 7)

				for iter_56_0 = 0, arg_53_1.actors_["10092"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["10092"].transform:GetChild(iter_56_0)

					if var_56_0.name == "" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_56_2 = arg_53_1.actors_["10094"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10094 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10094", 3)

				for iter_56_1 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_1)

					if var_56_3.name == "" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_56_5 = arg_53_1.actors_["10092"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps10092 == nil then
				arg_53_1.var_.actorSpriteComps10092 = var_56_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_6 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.actorSpriteComps10092 then
					for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_56_3 then
							if arg_53_1.isInRecall_ then
								iter_56_3.color = Color.New(Mathf.Lerp(iter_56_3.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_6), Mathf.Lerp(iter_56_3.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_6), (Mathf.Lerp(iter_56_3.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_6)))
							else
								local var_56_7 = Mathf.Lerp(iter_56_3.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_6)

								iter_56_3.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps10092 then
				for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_56_5 then
						iter_56_5.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps10092 = nil
			end

			local var_56_8 = arg_53_1.actors_["10094"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps10094 == nil then
				arg_53_1.var_.actorSpriteComps10094 = var_56_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_9 and not isNil(var_56_8) then
				if arg_53_1.var_.actorSpriteComps10094 then
					for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_56_7 then
							if arg_53_1.isInRecall_ then
								iter_56_7.color = Color.New(Mathf.Lerp(iter_56_7.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_9), Mathf.Lerp(iter_56_7.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_9), (Mathf.Lerp(iter_56_7.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_9)))
							else
								local var_56_10 = Mathf.Lerp(iter_56_7.color.r, 1, (arg_53_1.time_ - 0) / var_56_9)

								iter_56_7.color = Color.New(var_56_10, var_56_10, var_56_10)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_9 and arg_53_1.time_ < 0 + var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps10094 then
				for iter_56_8, iter_56_9 in pairs(arg_53_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_56_9 then
						iter_56_9.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10094 = nil
			end

			local var_56_11 = 0
			local var_56_12 = 0.65

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_13 = arg_53_1:GetWordFromCfg(413062013)
				local var_56_14 = arg_53_1:FormatText(var_56_13.content)

				arg_53_1.text_.text = var_56_14

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 26 <= 0 and var_56_12 or var_56_12 * (utf8.len(var_56_14) / 26)

				if (26 <= 0 and var_56_12 or var_56_12 * (utf8.len(var_56_14) / 26)) > 0 and var_56_12 < var_56_16 then
					arg_53_1.talkMaxDuration = var_56_16

					if var_56_16 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_16 + var_56_11
					end
				end

				arg_53_1.text_.text = var_56_14
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062013", "story_v_out_413062.awb") ~= 0 then
					local var_56_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062013", "story_v_out_413062.awb") / 1000

					if var_56_17 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_17 + var_56_11
					end

					if var_56_13.prefab_name ~= "" and arg_53_1.actors_[var_56_13.prefab_name] ~= nil then
						local var_56_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_13.prefab_name].transform, "story_v_out_413062", "413062013", "story_v_out_413062.awb")

						arg_53_1:RecordAudio("413062013", var_56_18)
						arg_53_1:RecordAudio("413062013", var_56_18)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413062", "413062013", "story_v_out_413062.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413062", "413062013", "story_v_out_413062.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_19 = math.max(var_56_12, arg_53_1.talkMaxDuration)

			if var_56_11 <= arg_53_1.time_ and arg_53_1.time_ < var_56_11 + var_56_19 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_11) / var_56_19

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_11 + var_56_19 and arg_53_1.time_ < var_56_11 + var_56_19 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play413062014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413062014
		arg_57_1.duration_ = 4.97

		local var_57_0 = {
			zh = 2.9,
			ja = 4.966
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
				arg_57_0:Play413062015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.425

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(413062014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 17 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 17)

				if (17 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 17)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062014", "story_v_out_413062.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062014", "story_v_out_413062.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_413062", "413062014", "story_v_out_413062.awb")

						arg_57_1:RecordAudio("413062014", var_60_6)
						arg_57_1:RecordAudio("413062014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413062", "413062014", "story_v_out_413062.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413062", "413062014", "story_v_out_413062.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play413062015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413062015
		arg_61_1.duration_ = 4.4

		local var_61_0 = {
			zh = 4.4,
			ja = 2.466
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
				arg_61_0:Play413062016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10093 = arg_61_1.actors_["10093"].transform.localPosition
				arg_61_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10093", 3)

				for iter_64_0 = 0, arg_61_1.actors_["10093"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["10093"].transform:GetChild(iter_64_0)

					if var_64_0.name == "" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_64_2 = arg_61_1.actors_["10094"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10094 = var_64_2.localPosition
				var_64_2.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10094", 7)

				for iter_64_1 = 0, var_64_2.childCount - 1 do
					local var_64_3 = var_64_2:GetChild(iter_64_1)

					if var_64_3.name == "" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_2.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_61_1.time_ - 0) / var_64_4)
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_5 = arg_61_1.actors_["10093"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps10093 == nil then
				arg_61_1.var_.actorSpriteComps10093 = var_64_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_6 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.actorSpriteComps10093 then
					for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_64_3 then
							if arg_61_1.isInRecall_ then
								iter_64_3.color = Color.New(Mathf.Lerp(iter_64_3.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_6), Mathf.Lerp(iter_64_3.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_6), (Mathf.Lerp(iter_64_3.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_6)))
							else
								local var_64_7 = Mathf.Lerp(iter_64_3.color.r, 1, (arg_61_1.time_ - 0) / var_64_6)

								iter_64_3.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps10093 then
				for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_64_5 then
						iter_64_5.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10093 = nil
			end

			local var_64_8 = arg_61_1.actors_["10094"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10094 == nil then
				arg_61_1.var_.actorSpriteComps10094 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_9 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_9 and not isNil(var_64_8) then
				if arg_61_1.var_.actorSpriteComps10094 then
					for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_64_7 then
							if arg_61_1.isInRecall_ then
								iter_64_7.color = Color.New(Mathf.Lerp(iter_64_7.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_9), Mathf.Lerp(iter_64_7.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_9), (Mathf.Lerp(iter_64_7.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_9)))
							else
								local var_64_10 = Mathf.Lerp(iter_64_7.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_9)

								iter_64_7.color = Color.New(var_64_10, var_64_10, var_64_10)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_9 and arg_61_1.time_ < 0 + var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10094 then
				for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_64_9 then
						iter_64_9.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10094 = nil
			end

			local var_64_11 = 0
			local var_64_12 = 0.6

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_13 = arg_61_1:GetWordFromCfg(413062015)
				local var_64_14 = arg_61_1:FormatText(var_64_13.content)

				arg_61_1.text_.text = var_64_14

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_16 = 24 <= 0 and var_64_12 or var_64_12 * (utf8.len(var_64_14) / 24)

				if (24 <= 0 and var_64_12 or var_64_12 * (utf8.len(var_64_14) / 24)) > 0 and var_64_12 < var_64_16 then
					arg_61_1.talkMaxDuration = var_64_16

					if var_64_16 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_11
					end
				end

				arg_61_1.text_.text = var_64_14
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062015", "story_v_out_413062.awb") ~= 0 then
					local var_64_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062015", "story_v_out_413062.awb") / 1000

					if var_64_17 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_11
					end

					if var_64_13.prefab_name ~= "" and arg_61_1.actors_[var_64_13.prefab_name] ~= nil then
						local var_64_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_13.prefab_name].transform, "story_v_out_413062", "413062015", "story_v_out_413062.awb")

						arg_61_1:RecordAudio("413062015", var_64_18)
						arg_61_1:RecordAudio("413062015", var_64_18)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413062", "413062015", "story_v_out_413062.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413062", "413062015", "story_v_out_413062.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_19 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_19 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_19

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_19 and arg_61_1.time_ < var_64_11 + var_64_19 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play413062016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413062016
		arg_65_1.duration_ = 11.9

		local var_65_0 = {
			zh = 6.4,
			ja = 11.9
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
				arg_65_0:Play413062017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10094 = arg_65_1.actors_["10094"].transform.localPosition
				arg_65_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10094", 0)

				for iter_68_0 = 0, arg_65_1.actors_["10094"].transform.childCount - 1 do
					local var_68_0 = arg_65_1.actors_["10094"].transform:GetChild(iter_68_0)

					if var_68_0.name == "" or not string.find(var_68_0.name, "split") then
						var_68_0.gameObject:SetActive(true)
					else
						var_68_0.gameObject:SetActive(false)
					end
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_65_1.time_ - 0) / var_68_1)
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_68_2 = arg_65_1.actors_["10094"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10094 = var_68_2.localPosition
				var_68_2.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10094", 3)

				for iter_68_1 = 0, var_68_2.childCount - 1 do
					local var_68_3 = var_68_2:GetChild(iter_68_1)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_65_1.time_ - 0) / var_68_4)
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_68_5 = arg_65_1.actors_["10094"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps10094 == nil then
				arg_65_1.var_.actorSpriteComps10094 = var_68_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_6 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.actorSpriteComps10094 then
					for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_68_3 then
							if arg_65_1.isInRecall_ then
								iter_68_3.color = Color.New(Mathf.Lerp(iter_68_3.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_6), Mathf.Lerp(iter_68_3.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_6), (Mathf.Lerp(iter_68_3.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_6)))
							else
								local var_68_7 = Mathf.Lerp(iter_68_3.color.r, 1, (arg_65_1.time_ - 0) / var_68_6)

								iter_68_3.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps10094 then
				for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_68_5 then
						iter_68_5.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10094 = nil
			end

			local var_68_8 = arg_65_1.actors_["10094"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10094 == nil then
				arg_65_1.var_.actorSpriteComps10094 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_9 and not isNil(var_68_8) then
				if arg_65_1.var_.actorSpriteComps10094 then
					for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_68_7 then
							if arg_65_1.isInRecall_ then
								iter_68_7.color = Color.New(Mathf.Lerp(iter_68_7.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_9), Mathf.Lerp(iter_68_7.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_9), (Mathf.Lerp(iter_68_7.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_9)))
							else
								local var_68_10 = Mathf.Lerp(iter_68_7.color.r, 1, (arg_65_1.time_ - 0) / var_68_9)

								iter_68_7.color = Color.New(var_68_10, var_68_10, var_68_10)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_9 and arg_65_1.time_ < 0 + var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10094 then
				for iter_68_8, iter_68_9 in pairs(arg_65_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_68_9 then
						iter_68_9.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10094 = nil
			end

			local var_68_11 = 0
			local var_68_12 = 0.8

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_13 = arg_65_1:GetWordFromCfg(413062016)
				local var_68_14 = arg_65_1:FormatText(var_68_13.content)

				arg_65_1.text_.text = var_68_14

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_16 = 32 <= 0 and var_68_12 or var_68_12 * (utf8.len(var_68_14) / 32)

				if (32 <= 0 and var_68_12 or var_68_12 * (utf8.len(var_68_14) / 32)) > 0 and var_68_12 < var_68_16 then
					arg_65_1.talkMaxDuration = var_68_16

					if var_68_16 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_11
					end
				end

				arg_65_1.text_.text = var_68_14
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062016", "story_v_out_413062.awb") ~= 0 then
					local var_68_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062016", "story_v_out_413062.awb") / 1000

					if var_68_17 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_11
					end

					if var_68_13.prefab_name ~= "" and arg_65_1.actors_[var_68_13.prefab_name] ~= nil then
						local var_68_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_13.prefab_name].transform, "story_v_out_413062", "413062016", "story_v_out_413062.awb")

						arg_65_1:RecordAudio("413062016", var_68_18)
						arg_65_1:RecordAudio("413062016", var_68_18)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413062", "413062016", "story_v_out_413062.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413062", "413062016", "story_v_out_413062.awb")
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
				actorName = "10094",
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
	Play413062017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413062017
		arg_69_1.duration_ = 11.57

		local var_69_0 = {
			zh = 11.133,
			ja = 11.566
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
				arg_69_0:Play413062018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(413062017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 50 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 50)

				if (50 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 50)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062017", "story_v_out_413062.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062017", "story_v_out_413062.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_413062", "413062017", "story_v_out_413062.awb")

						arg_69_1:RecordAudio("413062017", var_72_6)
						arg_69_1:RecordAudio("413062017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413062", "413062017", "story_v_out_413062.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413062", "413062017", "story_v_out_413062.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play413062018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413062018
		arg_73_1.duration_ = 9.4

		local var_73_0 = {
			zh = 6.933,
			ja = 9.4
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
				arg_73_0:Play413062019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.675

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(413062018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 27 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 27)

				if (27 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 27)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062018", "story_v_out_413062.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062018", "story_v_out_413062.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_413062", "413062018", "story_v_out_413062.awb")

						arg_73_1:RecordAudio("413062018", var_76_6)
						arg_73_1:RecordAudio("413062018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413062", "413062018", "story_v_out_413062.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413062", "413062018", "story_v_out_413062.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play413062019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413062019
		arg_77_1.duration_ = 6.8

		local var_77_0 = {
			zh = 5.366,
			ja = 6.8
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
				arg_77_0:Play413062020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10094 = arg_77_1.actors_["10094"].transform.localPosition
				arg_77_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10094", 4)

				for iter_80_0 = 0, arg_77_1.actors_["10094"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["10094"].transform:GetChild(iter_80_0)

					if var_80_0.name == "" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_80_2 = arg_77_1.actors_["10092"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10092 = var_80_2.localPosition
				var_80_2.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10092", 2)

				for iter_80_1 = 0, var_80_2.childCount - 1 do
					local var_80_3 = var_80_2:GetChild(iter_80_1)

					if var_80_3.name == "split_5" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_2.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_77_1.time_ - 0) / var_80_4)
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_80_5 = arg_77_1.actors_["10094"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps10094 == nil then
				arg_77_1.var_.actorSpriteComps10094 = var_80_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_6 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.actorSpriteComps10094 then
					for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_80_3 then
							if arg_77_1.isInRecall_ then
								iter_80_3.color = Color.New(Mathf.Lerp(iter_80_3.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_6), Mathf.Lerp(iter_80_3.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_6), (Mathf.Lerp(iter_80_3.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_6)))
							else
								local var_80_7 = Mathf.Lerp(iter_80_3.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_6)

								iter_80_3.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps10094 then
				for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_80_5 then
						iter_80_5.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10094 = nil
			end

			local var_80_8 = arg_77_1.actors_["10092"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10092 == nil then
				arg_77_1.var_.actorSpriteComps10092 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_9 and not isNil(var_80_8) then
				if arg_77_1.var_.actorSpriteComps10092 then
					for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_80_7 then
							if arg_77_1.isInRecall_ then
								iter_80_7.color = Color.New(Mathf.Lerp(iter_80_7.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_9), Mathf.Lerp(iter_80_7.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_9), (Mathf.Lerp(iter_80_7.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_9)))
							else
								local var_80_10 = Mathf.Lerp(iter_80_7.color.r, 1, (arg_77_1.time_ - 0) / var_80_9)

								iter_80_7.color = Color.New(var_80_10, var_80_10, var_80_10)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_9 and arg_77_1.time_ < 0 + var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10092 then
				for iter_80_8, iter_80_9 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_80_9 then
						iter_80_9.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10092 = nil
			end

			local var_80_11 = 0
			local var_80_12 = 0.55

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:GetWordFromCfg(413062019)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_16 = 22 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_14) / 22)

				if (22 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_14) / 22)) > 0 and var_80_12 < var_80_16 then
					arg_77_1.talkMaxDuration = var_80_16

					if var_80_16 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_11
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062019", "story_v_out_413062.awb") ~= 0 then
					local var_80_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062019", "story_v_out_413062.awb") / 1000

					if var_80_17 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_11
					end

					if var_80_13.prefab_name ~= "" and arg_77_1.actors_[var_80_13.prefab_name] ~= nil then
						local var_80_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_13.prefab_name].transform, "story_v_out_413062", "413062019", "story_v_out_413062.awb")

						arg_77_1:RecordAudio("413062019", var_80_18)
						arg_77_1:RecordAudio("413062019", var_80_18)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413062", "413062019", "story_v_out_413062.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413062", "413062019", "story_v_out_413062.awb")
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

		arg_77_1:InitPlayNodeList()
	end,
	Play413062020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413062020
		arg_81_1.duration_ = 5.37

		local var_81_0 = {
			zh = 1.999999999999,
			ja = 5.366
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
				arg_81_0:Play413062021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10094 = arg_81_1.actors_["10094"].transform.localPosition
				arg_81_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10094", 4)

				for iter_84_0 = 0, arg_81_1.actors_["10094"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["10094"].transform:GetChild(iter_84_0)

					if var_84_0.name == "split_2" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_84_2 = arg_81_1.actors_["10094"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10094 == nil then
				arg_81_1.var_.actorSpriteComps10094 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps10094 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								iter_84_2.color = Color.New(Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_2.color.r, 1, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_2.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10094 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_84_4 then
						iter_84_4.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps10094 = nil
			end

			local var_84_5 = arg_81_1.actors_["10092"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps10092 == nil then
				arg_81_1.var_.actorSpriteComps10092 = var_84_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_6 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.actorSpriteComps10092 then
					for iter_84_5, iter_84_6 in pairs(arg_81_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_84_6 then
							if arg_81_1.isInRecall_ then
								iter_84_6.color = Color.New(Mathf.Lerp(iter_84_6.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_6), Mathf.Lerp(iter_84_6.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_6), (Mathf.Lerp(iter_84_6.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_6)))
							else
								local var_84_7 = Mathf.Lerp(iter_84_6.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_6)

								iter_84_6.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps10092 then
				for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_84_8 then
						iter_84_8.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10092 = nil
			end

			local var_84_8 = 0
			local var_84_9 = 0.225

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(413062020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 9 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 9)

				if (9 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 9)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062020", "story_v_out_413062.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_413062", "413062020", "story_v_out_413062.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_413062", "413062020", "story_v_out_413062.awb")

						arg_81_1:RecordAudio("413062020", var_84_15)
						arg_81_1:RecordAudio("413062020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413062", "413062020", "story_v_out_413062.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413062", "413062020", "story_v_out_413062.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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

		arg_81_1:InitPlayNodeList()
	end,
	Play413062021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413062021
		arg_85_1.duration_ = 9.07

		local var_85_0 = {
			zh = 7.466,
			ja = 9.066
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
				arg_85_0:Play413062022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.925

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(413062021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 37 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 37)

				if (37 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 37)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062021", "story_v_out_413062.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062021", "story_v_out_413062.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_413062", "413062021", "story_v_out_413062.awb")

						arg_85_1:RecordAudio("413062021", var_88_6)
						arg_85_1:RecordAudio("413062021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413062", "413062021", "story_v_out_413062.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413062", "413062021", "story_v_out_413062.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413062022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413062022
		arg_89_1.duration_ = 13.77

		local var_89_0 = {
			zh = 6.866,
			ja = 13.766
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
				arg_89_0:Play413062023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10094 = arg_89_1.actors_["10094"].transform.localPosition
				arg_89_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10094", 4)

				for iter_92_0 = 0, arg_89_1.actors_["10094"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["10094"].transform:GetChild(iter_92_0)

					if var_92_0.name == "" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_92_2 = arg_89_1.actors_["10092"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10092 = var_92_2.localPosition
				var_92_2.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10092", 2)

				for iter_92_1 = 0, var_92_2.childCount - 1 do
					local var_92_3 = var_92_2:GetChild(iter_92_1)

					if var_92_3.name == "split_8" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_2.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_89_1.time_ - 0) / var_92_4)
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_92_5 = arg_89_1.actors_["10094"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps10094 == nil then
				arg_89_1.var_.actorSpriteComps10094 = var_92_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_6 = 2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.actorSpriteComps10094 then
					for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_92_3 then
							if arg_89_1.isInRecall_ then
								iter_92_3.color = Color.New(Mathf.Lerp(iter_92_3.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_6), Mathf.Lerp(iter_92_3.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_6), (Mathf.Lerp(iter_92_3.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_6)))
							else
								local var_92_7 = Mathf.Lerp(iter_92_3.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_6)

								iter_92_3.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps10094 then
				for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_92_5 then
						iter_92_5.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps10094 = nil
			end

			local var_92_8 = arg_89_1.actors_["10092"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10092 == nil then
				arg_89_1.var_.actorSpriteComps10092 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_9 and not isNil(var_92_8) then
				if arg_89_1.var_.actorSpriteComps10092 then
					for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_92_7 then
							if arg_89_1.isInRecall_ then
								iter_92_7.color = Color.New(Mathf.Lerp(iter_92_7.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_9), Mathf.Lerp(iter_92_7.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_9), (Mathf.Lerp(iter_92_7.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_9)))
							else
								local var_92_10 = Mathf.Lerp(iter_92_7.color.r, 1, (arg_89_1.time_ - 0) / var_92_9)

								iter_92_7.color = Color.New(var_92_10, var_92_10, var_92_10)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_9 and arg_89_1.time_ < 0 + var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10092 then
				for iter_92_8, iter_92_9 in pairs(arg_89_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_92_9 then
						iter_92_9.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps10092 = nil
			end

			local var_92_11 = 0
			local var_92_12 = 0.925

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_13 = arg_89_1:GetWordFromCfg(413062022)
				local var_92_14 = arg_89_1:FormatText(var_92_13.content)

				arg_89_1.text_.text = var_92_14

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 37 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 37)

				if (37 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 37)) > 0 and var_92_12 < var_92_16 then
					arg_89_1.talkMaxDuration = var_92_16

					if var_92_16 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_14
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062022", "story_v_out_413062.awb") ~= 0 then
					local var_92_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062022", "story_v_out_413062.awb") / 1000

					if var_92_17 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_11
					end

					if var_92_13.prefab_name ~= "" and arg_89_1.actors_[var_92_13.prefab_name] ~= nil then
						local var_92_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_13.prefab_name].transform, "story_v_out_413062", "413062022", "story_v_out_413062.awb")

						arg_89_1:RecordAudio("413062022", var_92_18)
						arg_89_1:RecordAudio("413062022", var_92_18)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413062", "413062022", "story_v_out_413062.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413062", "413062022", "story_v_out_413062.awb")
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

		arg_89_1:InitPlayNodeList()
	end,
	Play413062023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413062023
		arg_93_1.duration_ = 7.9

		local var_93_0 = {
			zh = 3.8,
			ja = 7.9
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
				arg_93_0:Play413062024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.45

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(413062023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 18 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 18)

				if (18 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 18)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062023", "story_v_out_413062.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062023", "story_v_out_413062.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_413062", "413062023", "story_v_out_413062.awb")

						arg_93_1:RecordAudio("413062023", var_96_6)
						arg_93_1:RecordAudio("413062023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413062", "413062023", "story_v_out_413062.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413062", "413062023", "story_v_out_413062.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play413062024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413062024
		arg_97_1.duration_ = 2.17

		local var_97_0 = {
			zh = 2.166,
			ja = 1.999999999999
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
				arg_97_0:Play413062025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10094 = arg_97_1.actors_["10094"].transform.localPosition
				arg_97_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10094", 0)

				for iter_100_0 = 0, arg_97_1.actors_["10094"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["10094"].transform:GetChild(iter_100_0)

					if var_100_0.name == "" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_100_2 = arg_97_1.actors_["10092"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10092 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10092", 0)

				for iter_100_1 = 0, var_100_2.childCount - 1 do
					local var_100_3 = var_100_2:GetChild(iter_100_1)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_100_5 = arg_97_1.actors_["10093"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10093 = var_100_5.localPosition
				var_100_5.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10093", 3)

				for iter_100_2 = 0, var_100_5.childCount - 1 do
					local var_100_6 = var_100_5:GetChild(iter_100_2)

					if var_100_6.name == "split_4" or not string.find(var_100_6.name, "split") then
						var_100_6.gameObject:SetActive(true)
					else
						var_100_6.gameObject:SetActive(false)
					end
				end
			end

			local var_100_7 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				var_100_5.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_97_1.time_ - 0) / var_100_7)
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				var_100_5.localPosition = Vector3.New(0, -345, -245)
			end

			local var_100_8 = arg_97_1.actors_["10094"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10094 == nil then
				arg_97_1.var_.actorSpriteComps10094 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_9 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_9 and not isNil(var_100_8) then
				if arg_97_1.var_.actorSpriteComps10094 then
					for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_100_4 then
							if arg_97_1.isInRecall_ then
								iter_100_4.color = Color.New(Mathf.Lerp(iter_100_4.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_9), Mathf.Lerp(iter_100_4.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_9), (Mathf.Lerp(iter_100_4.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_9)))
							else
								local var_100_10 = Mathf.Lerp(iter_100_4.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_9)

								iter_100_4.color = Color.New(var_100_10, var_100_10, var_100_10)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_9 and arg_97_1.time_ < 0 + var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10094 then
				for iter_100_5, iter_100_6 in pairs(arg_97_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_100_6 then
						iter_100_6.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps10094 = nil
			end

			local var_100_11 = arg_97_1.actors_["10092"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_11) and arg_97_1.var_.actorSpriteComps10092 == nil then
				arg_97_1.var_.actorSpriteComps10092 = var_100_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_12 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_12 and not isNil(var_100_11) then
				if arg_97_1.var_.actorSpriteComps10092 then
					for iter_100_7, iter_100_8 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_100_8 then
							if arg_97_1.isInRecall_ then
								iter_100_8.color = Color.New(Mathf.Lerp(iter_100_8.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_12), Mathf.Lerp(iter_100_8.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_12), (Mathf.Lerp(iter_100_8.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_12)))
							else
								local var_100_13 = Mathf.Lerp(iter_100_8.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_12)

								iter_100_8.color = Color.New(var_100_13, var_100_13, var_100_13)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_12 and arg_97_1.time_ < 0 + var_100_12 + arg_100_0 and not isNil(var_100_11) and arg_97_1.var_.actorSpriteComps10092 then
				for iter_100_9, iter_100_10 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_100_10 then
						iter_100_10.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps10092 = nil
			end

			local var_100_14 = arg_97_1.actors_["10093"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_14) and arg_97_1.var_.actorSpriteComps10093 == nil then
				arg_97_1.var_.actorSpriteComps10093 = var_100_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_15 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_15 and not isNil(var_100_14) then
				if arg_97_1.var_.actorSpriteComps10093 then
					for iter_100_11, iter_100_12 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_100_12 then
							if arg_97_1.isInRecall_ then
								iter_100_12.color = Color.New(Mathf.Lerp(iter_100_12.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_15), Mathf.Lerp(iter_100_12.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_15), (Mathf.Lerp(iter_100_12.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_15)))
							else
								local var_100_16 = Mathf.Lerp(iter_100_12.color.r, 1, (arg_97_1.time_ - 0) / var_100_15)

								iter_100_12.color = Color.New(var_100_16, var_100_16, var_100_16)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_15 and arg_97_1.time_ < 0 + var_100_15 + arg_100_0 and not isNil(var_100_14) and arg_97_1.var_.actorSpriteComps10093 then
				for iter_100_13, iter_100_14 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_100_14 then
						iter_100_14.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps10093 = nil
			end

			local var_100_17 = 0
			local var_100_18 = 0.3

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_17 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_19 = arg_97_1:GetWordFromCfg(413062024)
				local var_100_20 = arg_97_1:FormatText(var_100_19.content)

				arg_97_1.text_.text = var_100_20

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_22 = 12 <= 0 and var_100_18 or var_100_18 * (utf8.len(var_100_20) / 12)

				if (12 <= 0 and var_100_18 or var_100_18 * (utf8.len(var_100_20) / 12)) > 0 and var_100_18 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_17 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_17
					end
				end

				arg_97_1.text_.text = var_100_20
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062024", "story_v_out_413062.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_413062", "413062024", "story_v_out_413062.awb") / 1000

					if var_100_23 + var_100_17 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_17
					end

					if var_100_19.prefab_name ~= "" and arg_97_1.actors_[var_100_19.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_19.prefab_name].transform, "story_v_out_413062", "413062024", "story_v_out_413062.awb")

						arg_97_1:RecordAudio("413062024", var_100_24)
						arg_97_1:RecordAudio("413062024", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413062", "413062024", "story_v_out_413062.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413062", "413062024", "story_v_out_413062.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_25 = math.max(var_100_18, arg_97_1.talkMaxDuration)

			if var_100_17 <= arg_97_1.time_ and arg_97_1.time_ < var_100_17 + var_100_25 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_17) / var_100_25

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_17 + var_100_25 and arg_97_1.time_ < var_100_17 + var_100_25 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play413062025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413062025
		arg_101_1.duration_ = 13.9

		local var_101_0 = {
			zh = 6.4,
			ja = 13.9
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
				arg_101_0:Play413062026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.8

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(413062025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 32 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 32)

				if (32 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 32)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062025", "story_v_out_413062.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062025", "story_v_out_413062.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_413062", "413062025", "story_v_out_413062.awb")

						arg_101_1:RecordAudio("413062025", var_104_6)
						arg_101_1:RecordAudio("413062025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413062", "413062025", "story_v_out_413062.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413062", "413062025", "story_v_out_413062.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play413062026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413062026
		arg_105_1.duration_ = 8.33

		local var_105_0 = {
			zh = 4.333,
			ja = 8.333
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
				arg_105_0:Play413062027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10093 = arg_105_1.actors_["10093"].transform.localPosition
				arg_105_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10093", 0)

				for iter_108_0 = 0, arg_105_1.actors_["10093"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["10093"].transform:GetChild(iter_108_0)

					if var_108_0.name == "split_2" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10093, Vector3.New(-5000, -345, -245), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["10093"].transform.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_108_2 = arg_105_1.actors_["10092"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10092 = var_108_2.localPosition
				var_108_2.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10092", 3)

				for iter_108_1 = 0, var_108_2.childCount - 1 do
					local var_108_3 = var_108_2:GetChild(iter_108_1)

					if var_108_3.name == "split_2" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_2.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_105_1.time_ - 0) / var_108_4)
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_108_5 = arg_105_1.actors_["10093"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps10093 == nil then
				arg_105_1.var_.actorSpriteComps10093 = var_108_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_6 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.actorSpriteComps10093 then
					for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_108_3 then
							if arg_105_1.isInRecall_ then
								iter_108_3.color = Color.New(Mathf.Lerp(iter_108_3.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 0) / var_108_6), Mathf.Lerp(iter_108_3.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 0) / var_108_6), (Mathf.Lerp(iter_108_3.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 0) / var_108_6)))
							else
								local var_108_7 = Mathf.Lerp(iter_108_3.color.r, 0.5, (arg_105_1.time_ - 0) / var_108_6)

								iter_108_3.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps10093 then
				for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_108_5 then
						iter_108_5.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps10093 = nil
			end

			local var_108_8 = arg_105_1.actors_["10092"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps10092 == nil then
				arg_105_1.var_.actorSpriteComps10092 = var_108_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_9 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_9 and not isNil(var_108_8) then
				if arg_105_1.var_.actorSpriteComps10092 then
					for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_108_7 then
							if arg_105_1.isInRecall_ then
								iter_108_7.color = Color.New(Mathf.Lerp(iter_108_7.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_9), Mathf.Lerp(iter_108_7.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_9), (Mathf.Lerp(iter_108_7.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_9)))
							else
								local var_108_10 = Mathf.Lerp(iter_108_7.color.r, 1, (arg_105_1.time_ - 0) / var_108_9)

								iter_108_7.color = Color.New(var_108_10, var_108_10, var_108_10)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_9 and arg_105_1.time_ < 0 + var_108_9 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps10092 then
				for iter_108_8, iter_108_9 in pairs(arg_105_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_108_9 then
						iter_108_9.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10092 = nil
			end

			local var_108_11 = 0
			local var_108_12 = 0.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_13 = arg_105_1:GetWordFromCfg(413062026)
				local var_108_14 = arg_105_1:FormatText(var_108_13.content)

				arg_105_1.text_.text = var_108_14

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_16 = 19 <= 0 and var_108_12 or var_108_12 * (utf8.len(var_108_14) / 19)

				if (19 <= 0 and var_108_12 or var_108_12 * (utf8.len(var_108_14) / 19)) > 0 and var_108_12 < var_108_16 then
					arg_105_1.talkMaxDuration = var_108_16

					if var_108_16 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_16 + var_108_11
					end
				end

				arg_105_1.text_.text = var_108_14
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062026", "story_v_out_413062.awb") ~= 0 then
					local var_108_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062026", "story_v_out_413062.awb") / 1000

					if var_108_17 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_17 + var_108_11
					end

					if var_108_13.prefab_name ~= "" and arg_105_1.actors_[var_108_13.prefab_name] ~= nil then
						local var_108_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_13.prefab_name].transform, "story_v_out_413062", "413062026", "story_v_out_413062.awb")

						arg_105_1:RecordAudio("413062026", var_108_18)
						arg_105_1:RecordAudio("413062026", var_108_18)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413062", "413062026", "story_v_out_413062.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413062", "413062026", "story_v_out_413062.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_19 = math.max(var_108_12, arg_105_1.talkMaxDuration)

			if var_108_11 <= arg_105_1.time_ and arg_105_1.time_ < var_108_11 + var_108_19 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_11) / var_108_19

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_11 + var_108_19 and arg_105_1.time_ < var_108_11 + var_108_19 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play413062027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413062027
		arg_109_1.duration_ = 5.9

		local var_109_0 = {
			zh = 5.2,
			ja = 5.9
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
				arg_109_0:Play413062028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.65

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(413062027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 26 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 26)

				if (26 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 26)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062027", "story_v_out_413062.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062027", "story_v_out_413062.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_413062", "413062027", "story_v_out_413062.awb")

						arg_109_1:RecordAudio("413062027", var_112_6)
						arg_109_1:RecordAudio("413062027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413062", "413062027", "story_v_out_413062.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413062", "413062027", "story_v_out_413062.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play413062028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413062028
		arg_113_1.duration_ = 5.6

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play413062029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10092 = arg_113_1.actors_["10092"].transform.localPosition
				arg_113_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10092", 0)

				for iter_116_0 = 0, arg_113_1.actors_["10092"].transform.childCount - 1 do
					local var_116_0 = arg_113_1.actors_["10092"].transform:GetChild(iter_116_0)

					if var_116_0.name == "" or not string.find(var_116_0.name, "split") then
						var_116_0.gameObject:SetActive(true)
					else
						var_116_0.gameObject:SetActive(false)
					end
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_113_1.time_ - 0) / var_116_1)
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_116_2 = arg_113_1.actors_["10092"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10092 == nil then
				arg_113_1.var_.actorSpriteComps10092 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps10092 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								iter_116_2.color = Color.New(Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_3), Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_3), (Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_3)))
							else
								local var_116_4 = Mathf.Lerp(iter_116_2.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_3)

								iter_116_2.color = Color.New(var_116_4, var_116_4, var_116_4)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10092 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_116_4 then
						iter_116_4.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps10092 = nil
			end

			local var_116_5 = manager.ui.mainCamera.transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.shakeOldPos = var_116_5.localPosition
			end

			local var_116_6 = 0.6

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 then
				local var_116_7, var_116_8 = math.modf((arg_113_1.time_ - 0) / 0.066)

				var_116_5.localPosition = Vector3.New(var_116_8 * 0.13, var_116_8 * 0.13, var_116_8 * 0.13) + arg_113_1.var_.shakeOldPos
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 then
				var_116_5.localPosition = arg_113_1.var_.shakeOldPos
			end

			local var_116_9 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= var_116_9 + 0.6 and arg_113_1.time_ < var_116_9 + 0.6 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_10 = 0.6
			local var_116_11 = 1.6

			if 0.6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_12 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_12:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_13 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(413062028).content)

				arg_113_1.text_.text = var_116_13

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_15 = 64 <= 0 and var_116_11 or var_116_11 * (utf8.len(var_116_13) / 64)

				if (64 <= 0 and var_116_11 or var_116_11 * (utf8.len(var_116_13) / 64)) > 0 and var_116_11 < var_116_15 then
					arg_113_1.talkMaxDuration = var_116_15
					var_116_10 = var_116_10 + 0.3

					if var_116_15 + var_116_10 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_15 + var_116_10
					end
				end

				arg_113_1.text_.text = var_116_13
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = var_116_10 + 0.3
			local var_116_17 = math.max(var_116_11, arg_113_1.talkMaxDuration)

			if var_116_10 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_16) / var_116_17

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play413062029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413062029
		arg_119_1.duration_ = 4.23

		local var_119_0 = {
			zh = 2.633,
			ja = 4.233
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
				arg_119_0:Play413062030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10092 = arg_119_1.actors_["10092"].transform.localPosition
				arg_119_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10092", 3)

				for iter_122_0 = 0, arg_119_1.actors_["10092"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10092"].transform:GetChild(iter_122_0)

					if var_122_0.name == "" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_122_2 = arg_119_1.actors_["10092"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10092 == nil then
				arg_119_1.var_.actorSpriteComps10092 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps10092 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10092 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_122_4 then
						iter_122_4.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10092 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 0.275

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(413062029)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 11 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 11)

				if (11 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 11)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062029", "story_v_out_413062.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062029", "story_v_out_413062.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_413062", "413062029", "story_v_out_413062.awb")

						arg_119_1:RecordAudio("413062029", var_122_12)
						arg_119_1:RecordAudio("413062029", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413062", "413062029", "story_v_out_413062.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413062", "413062029", "story_v_out_413062.awb")
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

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play413062030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413062030
		arg_123_1.duration_ = 3.1

		local var_123_0 = {
			zh = 2.866,
			ja = 3.1
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
				arg_123_0:Play413062031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10092 = arg_123_1.actors_["10092"].transform.localPosition
				arg_123_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10092", 0)

				for iter_126_0 = 0, arg_123_1.actors_["10092"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["10092"].transform:GetChild(iter_126_0)

					if var_126_0.name == "" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_126_2 = arg_123_1.actors_["10093"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10093 = var_126_2.localPosition
				var_126_2.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10093", 3)

				for iter_126_1 = 0, var_126_2.childCount - 1 do
					local var_126_3 = var_126_2:GetChild(iter_126_1)

					if var_126_3.name == "split_5" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_2.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_123_1.time_ - 0) / var_126_4)
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_2.localPosition = Vector3.New(0, -345, -245)
			end

			local var_126_5 = arg_123_1.actors_["10092"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps10092 == nil then
				arg_123_1.var_.actorSpriteComps10092 = var_126_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_6 = 2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.actorSpriteComps10092 then
					for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_126_3 then
							if arg_123_1.isInRecall_ then
								iter_126_3.color = Color.New(Mathf.Lerp(iter_126_3.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_6), Mathf.Lerp(iter_126_3.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_6), (Mathf.Lerp(iter_126_3.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_6)))
							else
								local var_126_7 = Mathf.Lerp(iter_126_3.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_6)

								iter_126_3.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps10092 then
				for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_126_5 then
						iter_126_5.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10092 = nil
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
								iter_126_7.color = Color.New(Mathf.Lerp(iter_126_7.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_9), Mathf.Lerp(iter_126_7.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_9), (Mathf.Lerp(iter_126_7.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_9)))
							else
								local var_126_10 = Mathf.Lerp(iter_126_7.color.r, 1, (arg_123_1.time_ - 0) / var_126_9)

								iter_126_7.color = Color.New(var_126_10, var_126_10, var_126_10)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_9 and arg_123_1.time_ < 0 + var_126_9 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps10093 then
				for iter_126_8, iter_126_9 in pairs(arg_123_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_126_9 then
						iter_126_9.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10093 = nil
			end

			local var_126_11 = 0
			local var_126_12 = 0.375

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_13 = arg_123_1:GetWordFromCfg(413062030)
				local var_126_14 = arg_123_1:FormatText(var_126_13.content)

				arg_123_1.text_.text = var_126_14

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_16 = 15 <= 0 and var_126_12 or var_126_12 * (utf8.len(var_126_14) / 15)

				if (15 <= 0 and var_126_12 or var_126_12 * (utf8.len(var_126_14) / 15)) > 0 and var_126_12 < var_126_16 then
					arg_123_1.talkMaxDuration = var_126_16

					if var_126_16 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_16 + var_126_11
					end
				end

				arg_123_1.text_.text = var_126_14
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062030", "story_v_out_413062.awb") ~= 0 then
					local var_126_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062030", "story_v_out_413062.awb") / 1000

					if var_126_17 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_17 + var_126_11
					end

					if var_126_13.prefab_name ~= "" and arg_123_1.actors_[var_126_13.prefab_name] ~= nil then
						local var_126_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_13.prefab_name].transform, "story_v_out_413062", "413062030", "story_v_out_413062.awb")

						arg_123_1:RecordAudio("413062030", var_126_18)
						arg_123_1:RecordAudio("413062030", var_126_18)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413062", "413062030", "story_v_out_413062.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413062", "413062030", "story_v_out_413062.awb")
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

		arg_123_1:InitPlayNodeList()
	end,
	Play413062031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413062031
		arg_127_1.duration_ = 6.97

		local var_127_0 = {
			zh = 4.466,
			ja = 6.966
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
				arg_127_0:Play413062032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10093 = arg_127_1.actors_["10093"].transform.localPosition
				arg_127_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10093", 0)

				for iter_130_0 = 0, arg_127_1.actors_["10093"].transform.childCount - 1 do
					local var_130_0 = arg_127_1.actors_["10093"].transform:GetChild(iter_130_0)

					if var_130_0.name == "" or not string.find(var_130_0.name, "split") then
						var_130_0.gameObject:SetActive(true)
					else
						var_130_0.gameObject:SetActive(false)
					end
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10093, Vector3.New(-5000, -345, -245), (arg_127_1.time_ - 0) / var_130_1)
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["10093"].transform.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_130_2 = arg_127_1.actors_["10092"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10092 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10092", 3)

				for iter_130_1 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_1)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_130_5 = arg_127_1.actors_["10093"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.actorSpriteComps10093 == nil then
				arg_127_1.var_.actorSpriteComps10093 = var_130_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_6 = 2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_6 and not isNil(var_130_5) then
				if arg_127_1.var_.actorSpriteComps10093 then
					for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_130_3 then
							if arg_127_1.isInRecall_ then
								iter_130_3.color = Color.New(Mathf.Lerp(iter_130_3.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_6), Mathf.Lerp(iter_130_3.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_6), (Mathf.Lerp(iter_130_3.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_6)))
							else
								local var_130_7 = Mathf.Lerp(iter_130_3.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_6)

								iter_130_3.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_6 and arg_127_1.time_ < 0 + var_130_6 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.actorSpriteComps10093 then
				for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_130_5 then
						iter_130_5.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10093 = nil
			end

			local var_130_8 = arg_127_1.actors_["10092"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10092 == nil then
				arg_127_1.var_.actorSpriteComps10092 = var_130_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_9 = 2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_9 and not isNil(var_130_8) then
				if arg_127_1.var_.actorSpriteComps10092 then
					for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_130_7 then
							if arg_127_1.isInRecall_ then
								iter_130_7.color = Color.New(Mathf.Lerp(iter_130_7.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_9), Mathf.Lerp(iter_130_7.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_9), (Mathf.Lerp(iter_130_7.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_9)))
							else
								local var_130_10 = Mathf.Lerp(iter_130_7.color.r, 1, (arg_127_1.time_ - 0) / var_130_9)

								iter_130_7.color = Color.New(var_130_10, var_130_10, var_130_10)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_9 and arg_127_1.time_ < 0 + var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10092 then
				for iter_130_8, iter_130_9 in pairs(arg_127_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_130_9 then
						iter_130_9.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10092 = nil
			end

			local var_130_11 = 0
			local var_130_12 = 0.725

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_11 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_13 = arg_127_1:GetWordFromCfg(413062031)
				local var_130_14 = arg_127_1:FormatText(var_130_13.content)

				arg_127_1.text_.text = var_130_14

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_16 = 29 <= 0 and var_130_12 or var_130_12 * (utf8.len(var_130_14) / 29)

				if (29 <= 0 and var_130_12 or var_130_12 * (utf8.len(var_130_14) / 29)) > 0 and var_130_12 < var_130_16 then
					arg_127_1.talkMaxDuration = var_130_16

					if var_130_16 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_16 + var_130_11
					end
				end

				arg_127_1.text_.text = var_130_14
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062031", "story_v_out_413062.awb") ~= 0 then
					local var_130_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062031", "story_v_out_413062.awb") / 1000

					if var_130_17 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_17 + var_130_11
					end

					if var_130_13.prefab_name ~= "" and arg_127_1.actors_[var_130_13.prefab_name] ~= nil then
						local var_130_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_13.prefab_name].transform, "story_v_out_413062", "413062031", "story_v_out_413062.awb")

						arg_127_1:RecordAudio("413062031", var_130_18)
						arg_127_1:RecordAudio("413062031", var_130_18)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413062", "413062031", "story_v_out_413062.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413062", "413062031", "story_v_out_413062.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_19 = math.max(var_130_12, arg_127_1.talkMaxDuration)

			if var_130_11 <= arg_127_1.time_ and arg_127_1.time_ < var_130_11 + var_130_19 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_11) / var_130_19

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_11 + var_130_19 and arg_127_1.time_ < var_130_11 + var_130_19 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play413062032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413062032
		arg_131_1.duration_ = 7.1

		local var_131_0 = {
			zh = 3.733,
			ja = 7.1
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
				arg_131_0:Play413062033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.55

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(413062032)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 22 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 22)

				if (22 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 22)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062032", "story_v_out_413062.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062032", "story_v_out_413062.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_413062", "413062032", "story_v_out_413062.awb")

						arg_131_1:RecordAudio("413062032", var_134_6)
						arg_131_1:RecordAudio("413062032", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413062", "413062032", "story_v_out_413062.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413062", "413062032", "story_v_out_413062.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play413062033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413062033
		arg_135_1.duration_ = 9.07

		local var_135_0 = {
			zh = 4.4,
			ja = 9.066
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
				arg_135_0:Play413062034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10094 = arg_135_1.actors_["10094"].transform.localPosition
				arg_135_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10094", 3)

				for iter_138_0 = 0, arg_135_1.actors_["10094"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["10094"].transform:GetChild(iter_138_0)

					if var_138_0.name == "" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_138_2 = arg_135_1.actors_["10092"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10092 = var_138_2.localPosition
				var_138_2.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10092", 0)

				for iter_138_1 = 0, var_138_2.childCount - 1 do
					local var_138_3 = var_138_2:GetChild(iter_138_1)

					if var_138_3.name == "" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				var_138_2.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_135_1.time_ - 0) / var_138_4)
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				var_138_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_138_5 = arg_135_1.actors_["10094"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps10094 == nil then
				arg_135_1.var_.actorSpriteComps10094 = var_138_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_6 = 2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.actorSpriteComps10094 then
					for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_138_3 then
							if arg_135_1.isInRecall_ then
								iter_138_3.color = Color.New(Mathf.Lerp(iter_138_3.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_6), Mathf.Lerp(iter_138_3.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_6), (Mathf.Lerp(iter_138_3.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_6)))
							else
								local var_138_7 = Mathf.Lerp(iter_138_3.color.r, 1, (arg_135_1.time_ - 0) / var_138_6)

								iter_138_3.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps10094 then
				for iter_138_4, iter_138_5 in pairs(arg_135_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_138_5 then
						iter_138_5.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10094 = nil
			end

			local var_138_8 = arg_135_1.actors_["10092"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.actorSpriteComps10092 == nil then
				arg_135_1.var_.actorSpriteComps10092 = var_138_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_9 and not isNil(var_138_8) then
				if arg_135_1.var_.actorSpriteComps10092 then
					for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_138_7 then
							if arg_135_1.isInRecall_ then
								iter_138_7.color = Color.New(Mathf.Lerp(iter_138_7.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_9), Mathf.Lerp(iter_138_7.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_9), (Mathf.Lerp(iter_138_7.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_9)))
							else
								local var_138_10 = Mathf.Lerp(iter_138_7.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_9)

								iter_138_7.color = Color.New(var_138_10, var_138_10, var_138_10)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_9 and arg_135_1.time_ < 0 + var_138_9 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.actorSpriteComps10092 then
				for iter_138_8, iter_138_9 in pairs(arg_135_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_138_9 then
						iter_138_9.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10092 = nil
			end

			local var_138_11 = 0
			local var_138_12 = 0.55

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_13 = arg_135_1:GetWordFromCfg(413062033)
				local var_138_14 = arg_135_1:FormatText(var_138_13.content)

				arg_135_1.text_.text = var_138_14

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_16 = 22 <= 0 and var_138_12 or var_138_12 * (utf8.len(var_138_14) / 22)

				if (22 <= 0 and var_138_12 or var_138_12 * (utf8.len(var_138_14) / 22)) > 0 and var_138_12 < var_138_16 then
					arg_135_1.talkMaxDuration = var_138_16

					if var_138_16 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_11
					end
				end

				arg_135_1.text_.text = var_138_14
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062033", "story_v_out_413062.awb") ~= 0 then
					local var_138_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062033", "story_v_out_413062.awb") / 1000

					if var_138_17 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_17 + var_138_11
					end

					if var_138_13.prefab_name ~= "" and arg_135_1.actors_[var_138_13.prefab_name] ~= nil then
						local var_138_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_13.prefab_name].transform, "story_v_out_413062", "413062033", "story_v_out_413062.awb")

						arg_135_1:RecordAudio("413062033", var_138_18)
						arg_135_1:RecordAudio("413062033", var_138_18)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_413062", "413062033", "story_v_out_413062.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_413062", "413062033", "story_v_out_413062.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_19 = math.max(var_138_12, arg_135_1.talkMaxDuration)

			if var_138_11 <= arg_135_1.time_ and arg_135_1.time_ < var_138_11 + var_138_19 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_11) / var_138_19

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_11 + var_138_19 and arg_135_1.time_ < var_138_11 + var_138_19 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play413062034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413062034
		arg_139_1.duration_ = 6.37

		local var_139_0 = {
			zh = 6.366,
			ja = 4.966
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
				arg_139_0:Play413062035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10094 = arg_139_1.actors_["10094"].transform.localPosition
				arg_139_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10094", 0)

				for iter_142_0 = 0, arg_139_1.actors_["10094"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["10094"].transform:GetChild(iter_142_0)

					if var_142_0.name == "" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_142_2 = arg_139_1.actors_["10093"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10093 = var_142_2.localPosition
				var_142_2.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10093", 3)

				for iter_142_1 = 0, var_142_2.childCount - 1 do
					local var_142_3 = var_142_2:GetChild(iter_142_1)

					if var_142_3.name == "split_3" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_2.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_139_1.time_ - 0) / var_142_4)
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_2.localPosition = Vector3.New(0, -345, -245)
			end

			local var_142_5 = arg_139_1.actors_["10094"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.actorSpriteComps10094 == nil then
				arg_139_1.var_.actorSpriteComps10094 = var_142_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_6 = 2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.actorSpriteComps10094 then
					for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_142_3 then
							if arg_139_1.isInRecall_ then
								iter_142_3.color = Color.New(Mathf.Lerp(iter_142_3.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_6), Mathf.Lerp(iter_142_3.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_6), (Mathf.Lerp(iter_142_3.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_6)))
							else
								local var_142_7 = Mathf.Lerp(iter_142_3.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_6)

								iter_142_3.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.actorSpriteComps10094 then
				for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_142_5 then
						iter_142_5.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps10094 = nil
			end

			local var_142_8 = arg_139_1.actors_["10093"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps10093 == nil then
				arg_139_1.var_.actorSpriteComps10093 = var_142_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_9 = 2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_9 and not isNil(var_142_8) then
				if arg_139_1.var_.actorSpriteComps10093 then
					for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_142_7 then
							if arg_139_1.isInRecall_ then
								iter_142_7.color = Color.New(Mathf.Lerp(iter_142_7.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_9), Mathf.Lerp(iter_142_7.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_9), (Mathf.Lerp(iter_142_7.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_9)))
							else
								local var_142_10 = Mathf.Lerp(iter_142_7.color.r, 1, (arg_139_1.time_ - 0) / var_142_9)

								iter_142_7.color = Color.New(var_142_10, var_142_10, var_142_10)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_9 and arg_139_1.time_ < 0 + var_142_9 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps10093 then
				for iter_142_8, iter_142_9 in pairs(arg_139_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_142_9 then
						iter_142_9.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps10093 = nil
			end

			local var_142_11 = 0
			local var_142_12 = 0.725

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
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

				local var_142_13 = arg_139_1:GetWordFromCfg(413062034)
				local var_142_14 = arg_139_1:FormatText(var_142_13.content)

				arg_139_1.text_.text = var_142_14

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_16 = 29 <= 0 and var_142_12 or var_142_12 * (utf8.len(var_142_14) / 29)

				if (29 <= 0 and var_142_12 or var_142_12 * (utf8.len(var_142_14) / 29)) > 0 and var_142_12 < var_142_16 then
					arg_139_1.talkMaxDuration = var_142_16

					if var_142_16 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_16 + var_142_11
					end
				end

				arg_139_1.text_.text = var_142_14
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062034", "story_v_out_413062.awb") ~= 0 then
					local var_142_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062034", "story_v_out_413062.awb") / 1000

					if var_142_17 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_17 + var_142_11
					end

					if var_142_13.prefab_name ~= "" and arg_139_1.actors_[var_142_13.prefab_name] ~= nil then
						local var_142_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_13.prefab_name].transform, "story_v_out_413062", "413062034", "story_v_out_413062.awb")

						arg_139_1:RecordAudio("413062034", var_142_18)
						arg_139_1:RecordAudio("413062034", var_142_18)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413062", "413062034", "story_v_out_413062.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413062", "413062034", "story_v_out_413062.awb")
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
	Play413062035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413062035
		arg_143_1.duration_ = 5.4

		local var_143_0 = {
			zh = 1.766,
			ja = 5.4
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
				arg_143_0:Play413062036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.3

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:GetWordFromCfg(413062035)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 12 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 12)

				if (12 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 12)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062035", "story_v_out_413062.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062035", "story_v_out_413062.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_413062", "413062035", "story_v_out_413062.awb")

						arg_143_1:RecordAudio("413062035", var_146_6)
						arg_143_1:RecordAudio("413062035", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413062", "413062035", "story_v_out_413062.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413062", "413062035", "story_v_out_413062.awb")
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
	Play413062036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413062036
		arg_147_1.duration_ = 11.03

		local var_147_0 = {
			zh = 11.032999999999,
			ja = 10.399999999999
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
				arg_147_0:Play413062037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.bgs_.ST71a == nil then
				local var_150_0 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST71a")
				var_150_0.name = "ST71a"
				var_150_0.transform.parent = arg_147_1.stage_.transform
				var_150_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_.ST71a = var_150_0
			end

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= 2 + arg_150_0 then
				local var_150_1 = arg_147_1.bgs_.ST71a

				arg_147_1.bgs_.ST71a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_2 = var_150_1:GetComponent("SpriteRenderer")

				if var_150_2 and var_150_2.sprite then
					local var_150_3 = 2 * (var_150_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_1.transform.localScale = Vector3.New(var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "ST71a" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_4 = 3.999999999999

			if 3.999999999999 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			if arg_147_1.time_ >= var_150_4 + 0.3 and arg_147_1.time_ < var_150_4 + 0.3 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			local var_150_5 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_6 = 2

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_6 then
				local var_150_7 = Color.New(0, 0, 0)

				var_150_7.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_5) / var_150_6)
				arg_147_1.mask_.color = var_150_7
			end

			if arg_147_1.time_ >= var_150_5 + var_150_6 and arg_147_1.time_ < var_150_5 + var_150_6 + arg_150_0 then
				local var_150_8 = Color.New(0, 0, 0)

				var_150_8.a = 1
				arg_147_1.mask_.color = var_150_8
			end

			local var_150_9 = 2

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_10 = 2

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_10 then
				local var_150_11 = Color.New(0, 0, 0)

				var_150_11.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_9) / var_150_10)
				arg_147_1.mask_.color = var_150_11
			end

			if arg_147_1.time_ >= var_150_9 + var_150_10 and arg_147_1.time_ < var_150_9 + var_150_10 + arg_150_0 then
				local var_150_12 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_12.a = 0
				arg_147_1.mask_.color = var_150_12
			end

			local var_150_13 = arg_147_1.actors_["10093"].transform

			if 1.966 < arg_147_1.time_ and arg_147_1.time_ <= 1.966 + arg_150_0 then
				arg_147_1.var_.moveOldPos10093 = var_150_13.localPosition
				var_150_13.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10093", 0)

				for iter_150_2 = 0, var_150_13.childCount - 1 do
					local var_150_14 = var_150_13:GetChild(iter_150_2)

					if var_150_14.name == "" or not string.find(var_150_14.name, "split") then
						var_150_14.gameObject:SetActive(true)
					else
						var_150_14.gameObject:SetActive(false)
					end
				end
			end

			local var_150_15 = 0.001

			if 1.966 <= arg_147_1.time_ and arg_147_1.time_ < 1.966 + var_150_15 then
				var_150_13.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10093, Vector3.New(-5000, -345, -245), (arg_147_1.time_ - 1.966) / var_150_15)
			end

			if arg_147_1.time_ >= 1.966 + var_150_15 and arg_147_1.time_ < 1.966 + var_150_15 + arg_150_0 then
				var_150_13.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_150_16 = "10022"

			if arg_147_1.actors_["10022"] == nil then
				local var_150_17 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_150_17) then
					local var_150_18 = Object.Instantiate(var_150_17, arg_147_1.canvasGo_.transform)

					var_150_18.transform:SetSiblingIndex(1)

					var_150_18.name = var_150_16
					var_150_18.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_147_1.actors_[var_150_16] = var_150_18

					if arg_147_1.isInRecall_ then
						for iter_150_3, iter_150_4 in ipairs((var_150_18:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_150_4.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_150_19 = arg_147_1.actors_["10022"].transform

			if 3.8 < arg_147_1.time_ and arg_147_1.time_ <= 3.8 + arg_150_0 then
				arg_147_1.var_.moveOldPos10022 = var_150_19.localPosition
				var_150_19.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10022", 3)

				for iter_150_5 = 0, var_150_19.childCount - 1 do
					local var_150_20 = var_150_19:GetChild(iter_150_5)

					if var_150_20.name == "split_8" or not string.find(var_150_20.name, "split") then
						var_150_20.gameObject:SetActive(true)
					else
						var_150_20.gameObject:SetActive(false)
					end
				end
			end

			local var_150_21 = 0.001

			if 3.8 <= arg_147_1.time_ and arg_147_1.time_ < 3.8 + var_150_21 then
				var_150_19.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_147_1.time_ - 3.8) / var_150_21)
			end

			if arg_147_1.time_ >= 3.8 + var_150_21 and arg_147_1.time_ < 3.8 + var_150_21 + arg_150_0 then
				var_150_19.localPosition = Vector3.New(0, -315, -320)
			end

			local var_150_22 = arg_147_1.actors_["10093"]

			if 1.966 < arg_147_1.time_ and arg_147_1.time_ <= 1.966 + arg_150_0 and not isNil(var_150_22) and arg_147_1.var_.actorSpriteComps10093 == nil then
				arg_147_1.var_.actorSpriteComps10093 = var_150_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_23 = 0.034

			if 1.966 <= arg_147_1.time_ and arg_147_1.time_ < 1.966 + var_150_23 and not isNil(var_150_22) then
				if arg_147_1.var_.actorSpriteComps10093 then
					for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_150_7 then
							if arg_147_1.isInRecall_ then
								iter_150_7.color = Color.New(Mathf.Lerp(iter_150_7.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 1.966) / var_150_23), Mathf.Lerp(iter_150_7.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 1.966) / var_150_23), (Mathf.Lerp(iter_150_7.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 1.966) / var_150_23)))
							else
								local var_150_24 = Mathf.Lerp(iter_150_7.color.r, 0.5, (arg_147_1.time_ - 1.966) / var_150_23)

								iter_150_7.color = Color.New(var_150_24, var_150_24, var_150_24)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 1.966 + var_150_23 and arg_147_1.time_ < 1.966 + var_150_23 + arg_150_0 and not isNil(var_150_22) and arg_147_1.var_.actorSpriteComps10093 then
				for iter_150_8, iter_150_9 in pairs(arg_147_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_150_9 then
						iter_150_9.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps10093 = nil
			end

			local var_150_25 = arg_147_1.actors_["10022"]

			if 3.8 < arg_147_1.time_ and arg_147_1.time_ <= 3.8 + arg_150_0 and not isNil(var_150_25) and arg_147_1.var_.actorSpriteComps10022 == nil then
				arg_147_1.var_.actorSpriteComps10022 = var_150_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_26 = 0.2

			if 3.8 <= arg_147_1.time_ and arg_147_1.time_ < 3.8 + var_150_26 and not isNil(var_150_25) then
				if arg_147_1.var_.actorSpriteComps10022 then
					for iter_150_10, iter_150_11 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_150_11 then
							if arg_147_1.isInRecall_ then
								iter_150_11.color = Color.New(Mathf.Lerp(iter_150_11.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 3.8) / var_150_26), Mathf.Lerp(iter_150_11.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 3.8) / var_150_26), (Mathf.Lerp(iter_150_11.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 3.8) / var_150_26)))
							else
								local var_150_27 = Mathf.Lerp(iter_150_11.color.r, 1, (arg_147_1.time_ - 3.8) / var_150_26)

								iter_150_11.color = Color.New(var_150_27, var_150_27, var_150_27)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 3.8 + var_150_26 and arg_147_1.time_ < 3.8 + var_150_26 + arg_150_0 and not isNil(var_150_25) and arg_147_1.var_.actorSpriteComps10022 then
				for iter_150_12, iter_150_13 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_150_13 then
						iter_150_13.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps10022 = nil
			end

			if 3.799999999999 < arg_147_1.time_ and arg_147_1.time_ <= 3.799999999999 + arg_150_0 then
				local var_150_28 = arg_147_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_150_28 then
					arg_147_1.var_.alphaOldValue10022 = var_150_28.alpha
					arg_147_1.var_.characterEffect10022 = var_150_28
				end

				arg_147_1.var_.alphaOldValue10022 = 0
			end

			local var_150_29 = 0.5

			if 3.799999999999 <= arg_147_1.time_ and arg_147_1.time_ < 3.799999999999 + var_150_29 then
				if arg_147_1.var_.characterEffect10022 then
					arg_147_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_147_1.var_.alphaOldValue10022, 1, (arg_147_1.time_ - 3.799999999999) / var_150_29)
				end
			end

			if arg_147_1.time_ >= 3.799999999999 + var_150_29 and arg_147_1.time_ < 3.799999999999 + var_150_29 + arg_150_0 and arg_147_1.var_.characterEffect10022 then
				arg_147_1.var_.characterEffect10022.alpha = 1
			end

			if 1.966 < arg_147_1.time_ and arg_147_1.time_ <= 1.966 + arg_150_0 then
				arg_147_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete.awb")

				local var_150_32 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete")

				if "" ~= "" then
					if arg_147_1.bgmTxt_.text ~= var_150_32 and arg_147_1.bgmTxt_.text ~= "" then
						if arg_147_1.bgmTxt2_.text ~= "" then
							arg_147_1.bgmTxt_.text = arg_147_1.bgmTxt2_.text
						end

						arg_147_1.bgmTxt2_.text = var_150_32

						arg_147_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_147_1.bgmTxt_.text = var_150_32
						arg_147_1.bgmTxt2_.text = var_150_32
					end

					if arg_147_1.bgmTimer then
						arg_147_1.bgmTimer:Stop()

						arg_147_1.bgmTimer = nil
					end

					if arg_147_1.settingData.show_music_name == 1 then
						arg_147_1.musicController:SetSelectedState("show")
						arg_147_1.musicAnimator_:Play("open", 0, 0)

						if arg_147_1.settingData.music_time ~= 0 then
							arg_147_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_147_1.settingData.music_time), function()
								if arg_147_1 == nil or isNil(arg_147_1.bgmTxt_) then
									return
								end

								arg_147_1.musicController:SetSelectedState("hide")
								arg_147_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_33 = 3.999999999999
			local var_150_34 = 0.575

			if 3.999999999999 < arg_147_1.time_ and arg_147_1.time_ <= var_150_33 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_35 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_35:setOnUpdate(LuaHelper.FloatAction(function(arg_152_0)
					arg_147_1.dialogCg_.alpha = arg_152_0
				end))
				var_150_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_36 = arg_147_1:GetWordFromCfg(413062036)
				local var_150_37 = arg_147_1:FormatText(var_150_36.content)

				arg_147_1.text_.text = var_150_37

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_39 = 23 <= 0 and var_150_34 or var_150_34 * (utf8.len(var_150_37) / 23)

				if (23 <= 0 and var_150_34 or var_150_34 * (utf8.len(var_150_37) / 23)) > 0 and var_150_34 < var_150_39 then
					arg_147_1.talkMaxDuration = var_150_39
					var_150_33 = var_150_33 + 0.3

					if var_150_39 + var_150_33 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_39 + var_150_33
					end
				end

				arg_147_1.text_.text = var_150_37
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062036", "story_v_out_413062.awb") ~= 0 then
					local var_150_40 = manager.audio:GetVoiceLength("story_v_out_413062", "413062036", "story_v_out_413062.awb") / 1000

					if var_150_40 + var_150_33 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_40 + var_150_33
					end

					if var_150_36.prefab_name ~= "" and arg_147_1.actors_[var_150_36.prefab_name] ~= nil then
						local var_150_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_36.prefab_name].transform, "story_v_out_413062", "413062036", "story_v_out_413062.awb")

						arg_147_1:RecordAudio("413062036", var_150_41)
						arg_147_1:RecordAudio("413062036", var_150_41)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413062", "413062036", "story_v_out_413062.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413062", "413062036", "story_v_out_413062.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_42 = var_150_33 + 0.3
			local var_150_43 = math.max(var_150_34, arg_147_1.talkMaxDuration)

			if var_150_33 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_42 + var_150_43 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_42) / var_150_43

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_42 + var_150_43 and arg_147_1.time_ < var_150_42 + var_150_43 + arg_150_0 then
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
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play413062037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 413062037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play413062038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["10022"]) and arg_154_1.var_.actorSpriteComps10022 == nil then
				arg_154_1.var_.actorSpriteComps10022 = arg_154_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_0 = 2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["10022"]) then
				if arg_154_1.var_.actorSpriteComps10022 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								iter_157_1.color = Color.New(Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor2.r, (arg_154_1.time_ - 0) / var_157_0), Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor2.g, (arg_154_1.time_ - 0) / var_157_0), (Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor2.b, (arg_154_1.time_ - 0) / var_157_0)))
							else
								local var_157_1 = Mathf.Lerp(iter_157_1.color.r, 0.5, (arg_154_1.time_ - 0) / var_157_0)

								iter_157_1.color = Color.New(var_157_1, var_157_1, var_157_1)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["10022"]) and arg_154_1.var_.actorSpriteComps10022 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_157_3 then
						iter_157_3.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_154_1.var_.actorSpriteComps10022 = nil
			end

			local var_157_2 = 0
			local var_157_3 = 1.4

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_4 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(413062037).content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_6 = 56 <= 0 and var_157_3 or var_157_3 * (utf8.len(var_157_4) / 56)

				if (56 <= 0 and var_157_3 or var_157_3 * (utf8.len(var_157_4) / 56)) > 0 and var_157_3 < var_157_6 then
					arg_154_1.talkMaxDuration = var_157_6

					if var_157_6 + var_157_2 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_6 + var_157_2
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_3, arg_154_1.talkMaxDuration)

			if var_157_2 <= arg_154_1.time_ and arg_154_1.time_ < var_157_2 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_2) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_2 + var_157_7 and arg_154_1.time_ < var_157_2 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play413062038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 413062038
		arg_158_1.duration_ = 9.97

		local var_158_0 = {
			zh = 4.733,
			ja = 9.966
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play413062039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["10022"]) and arg_158_1.var_.actorSpriteComps10022 == nil then
				arg_158_1.var_.actorSpriteComps10022 = arg_158_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_0 = 2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["10022"]) then
				if arg_158_1.var_.actorSpriteComps10022 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_161_1 then
							if arg_158_1.isInRecall_ then
								iter_161_1.color = Color.New(Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor1.r, (arg_158_1.time_ - 0) / var_161_0), Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor1.g, (arg_158_1.time_ - 0) / var_161_0), (Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor1.b, (arg_158_1.time_ - 0) / var_161_0)))
							else
								local var_161_1 = Mathf.Lerp(iter_161_1.color.r, 1, (arg_158_1.time_ - 0) / var_161_0)

								iter_161_1.color = Color.New(var_161_1, var_161_1, var_161_1)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["10022"]) and arg_158_1.var_.actorSpriteComps10022 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_161_3 then
						iter_161_3.color = arg_158_1.isInRecall_ and (arg_158_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_158_1.var_.actorSpriteComps10022 = nil
			end

			local var_161_2 = 0
			local var_161_3 = 0.625

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_4 = arg_158_1:GetWordFromCfg(413062038)
				local var_161_5 = arg_158_1:FormatText(var_161_4.content)

				arg_158_1.text_.text = var_161_5

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_7 = 25 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 25)

				if (25 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 25)) > 0 and var_161_3 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_5
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062038", "story_v_out_413062.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_413062", "413062038", "story_v_out_413062.awb") / 1000

					if var_161_8 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_2
					end

					if var_161_4.prefab_name ~= "" and arg_158_1.actors_[var_161_4.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_4.prefab_name].transform, "story_v_out_413062", "413062038", "story_v_out_413062.awb")

						arg_158_1:RecordAudio("413062038", var_161_9)
						arg_158_1:RecordAudio("413062038", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_413062", "413062038", "story_v_out_413062.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_413062", "413062038", "story_v_out_413062.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_10 and arg_158_1.time_ < var_161_2 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play413062039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 413062039
		arg_162_1.duration_ = 6.7

		local var_162_0 = {
			zh = 2.6,
			ja = 6.7
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play413062040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.3

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:GetWordFromCfg(413062039)
				local var_165_2 = arg_162_1:FormatText(var_165_1.content)

				arg_162_1.text_.text = var_165_2

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 12 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 12)

				if (12 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 12)) > 0 and var_165_0 < var_165_4 then
					arg_162_1.talkMaxDuration = var_165_4

					if var_165_4 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_4 + 0
					end
				end

				arg_162_1.text_.text = var_165_2
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062039", "story_v_out_413062.awb") ~= 0 then
					local var_165_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062039", "story_v_out_413062.awb") / 1000

					if var_165_5 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + 0
					end

					if var_165_1.prefab_name ~= "" and arg_162_1.actors_[var_165_1.prefab_name] ~= nil then
						local var_165_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_1.prefab_name].transform, "story_v_out_413062", "413062039", "story_v_out_413062.awb")

						arg_162_1:RecordAudio("413062039", var_165_6)
						arg_162_1:RecordAudio("413062039", var_165_6)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_413062", "413062039", "story_v_out_413062.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_413062", "413062039", "story_v_out_413062.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play413062040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 413062040
		arg_166_1.duration_ = 8.8

		local var_166_0 = {
			zh = 6.3,
			ja = 8.8
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play413062041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0.6

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_1 = arg_166_1:GetWordFromCfg(413062040)
				local var_169_2 = arg_166_1:FormatText(var_169_1.content)

				arg_166_1.text_.text = var_169_2

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 24 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 24)

				if (24 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 24)) > 0 and var_169_0 < var_169_4 then
					arg_166_1.talkMaxDuration = var_169_4

					if var_169_4 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_4 + 0
					end
				end

				arg_166_1.text_.text = var_169_2
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062040", "story_v_out_413062.awb") ~= 0 then
					local var_169_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062040", "story_v_out_413062.awb") / 1000

					if var_169_5 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + 0
					end

					if var_169_1.prefab_name ~= "" and arg_166_1.actors_[var_169_1.prefab_name] ~= nil then
						local var_169_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_1.prefab_name].transform, "story_v_out_413062", "413062040", "story_v_out_413062.awb")

						arg_166_1:RecordAudio("413062040", var_169_6)
						arg_166_1:RecordAudio("413062040", var_169_6)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_413062", "413062040", "story_v_out_413062.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_413062", "413062040", "story_v_out_413062.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_7 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_7 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_7

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_7 and arg_166_1.time_ < 0 + var_169_7 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play413062041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 413062041
		arg_170_1.duration_ = 6.43

		local var_170_0 = {
			zh = 6.433,
			ja = 4.9
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play413062042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10022"]) and arg_170_1.var_.actorSpriteComps10022 == nil then
				arg_170_1.var_.actorSpriteComps10022 = arg_170_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_0 = 2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10022"]) then
				if arg_170_1.var_.actorSpriteComps10022 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								iter_173_1.color = Color.New(Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor2.r, (arg_170_1.time_ - 0) / var_173_0), Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor2.g, (arg_170_1.time_ - 0) / var_173_0), (Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor2.b, (arg_170_1.time_ - 0) / var_173_0)))
							else
								local var_173_1 = Mathf.Lerp(iter_173_1.color.r, 0.5, (arg_170_1.time_ - 0) / var_173_0)

								iter_173_1.color = Color.New(var_173_1, var_173_1, var_173_1)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10022"]) and arg_170_1.var_.actorSpriteComps10022 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_173_3 then
						iter_173_3.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_170_1.var_.actorSpriteComps10022 = nil
			end

			local var_173_2 = 0
			local var_173_3 = 0.225

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_4 = arg_170_1:GetWordFromCfg(413062041)
				local var_173_5 = arg_170_1:FormatText(var_173_4.content)

				arg_170_1.text_.text = var_173_5

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_7 = 9 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_5) / 9)

				if (9 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_5) / 9)) > 0 and var_173_3 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_2
					end
				end

				arg_170_1.text_.text = var_173_5
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062041", "story_v_out_413062.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_413062", "413062041", "story_v_out_413062.awb") / 1000

					if var_173_8 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_2
					end

					if var_173_4.prefab_name ~= "" and arg_170_1.actors_[var_173_4.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_4.prefab_name].transform, "story_v_out_413062", "413062041", "story_v_out_413062.awb")

						arg_170_1:RecordAudio("413062041", var_173_9)
						arg_170_1:RecordAudio("413062041", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_413062", "413062041", "story_v_out_413062.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_413062", "413062041", "story_v_out_413062.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_3, arg_170_1.talkMaxDuration)

			if var_173_2 <= arg_170_1.time_ and arg_170_1.time_ < var_173_2 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_2) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_2 + var_173_10 and arg_170_1.time_ < var_173_2 + var_173_10 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play413062042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 413062042
		arg_174_1.duration_ = 4.6

		local var_174_0 = {
			zh = 1.999999999999,
			ja = 4.6
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play413062043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10022 = arg_174_1.actors_["10022"].transform.localPosition
				arg_174_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10022", 3)

				for iter_177_0 = 0, arg_174_1.actors_["10022"].transform.childCount - 1 do
					local var_177_0 = arg_174_1.actors_["10022"].transform:GetChild(iter_177_0)

					if var_177_0.name == "split_6" or not string.find(var_177_0.name, "split") then
						var_177_0.gameObject:SetActive(true)
					else
						var_177_0.gameObject:SetActive(false)
					end
				end
			end

			local var_177_1 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 then
				arg_174_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_174_1.time_ - 0) / var_177_1)
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 then
				arg_174_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_177_2 = arg_174_1.actors_["10022"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps10022 == nil then
				arg_174_1.var_.actorSpriteComps10022 = var_177_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_3 = 2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.actorSpriteComps10022 then
					for iter_177_1, iter_177_2 in pairs(arg_174_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_177_2 then
							if arg_174_1.isInRecall_ then
								iter_177_2.color = Color.New(Mathf.Lerp(iter_177_2.color.r, arg_174_1.hightColor1.r, (arg_174_1.time_ - 0) / var_177_3), Mathf.Lerp(iter_177_2.color.g, arg_174_1.hightColor1.g, (arg_174_1.time_ - 0) / var_177_3), (Mathf.Lerp(iter_177_2.color.b, arg_174_1.hightColor1.b, (arg_174_1.time_ - 0) / var_177_3)))
							else
								local var_177_4 = Mathf.Lerp(iter_177_2.color.r, 1, (arg_174_1.time_ - 0) / var_177_3)

								iter_177_2.color = Color.New(var_177_4, var_177_4, var_177_4)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps10022 then
				for iter_177_3, iter_177_4 in pairs(arg_174_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_177_4 then
						iter_177_4.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_174_1.var_.actorSpriteComps10022 = nil
			end

			local var_177_5 = 0
			local var_177_6 = 0.125

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_7 = arg_174_1:GetWordFromCfg(413062042)
				local var_177_8 = arg_174_1:FormatText(var_177_7.content)

				arg_174_1.text_.text = var_177_8

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_10 = 5 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_8) / 5)

				if (5 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_8) / 5)) > 0 and var_177_6 < var_177_10 then
					arg_174_1.talkMaxDuration = var_177_10

					if var_177_10 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_5
					end
				end

				arg_174_1.text_.text = var_177_8
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062042", "story_v_out_413062.awb") ~= 0 then
					local var_177_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062042", "story_v_out_413062.awb") / 1000

					if var_177_11 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_11 + var_177_5
					end

					if var_177_7.prefab_name ~= "" and arg_174_1.actors_[var_177_7.prefab_name] ~= nil then
						local var_177_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_7.prefab_name].transform, "story_v_out_413062", "413062042", "story_v_out_413062.awb")

						arg_174_1:RecordAudio("413062042", var_177_12)
						arg_174_1:RecordAudio("413062042", var_177_12)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_413062", "413062042", "story_v_out_413062.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_413062", "413062042", "story_v_out_413062.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_13 = math.max(var_177_6, arg_174_1.talkMaxDuration)

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_13 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_5) / var_177_13

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_5 + var_177_13 and arg_174_1.time_ < var_177_5 + var_177_13 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
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

		arg_174_1:InitPlayNodeList()
	end,
	Play413062043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 413062043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play413062044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10022 = arg_178_1.actors_["10022"].transform.localPosition
				arg_178_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10022", 7)

				for iter_181_0 = 0, arg_178_1.actors_["10022"].transform.childCount - 1 do
					local var_181_0 = arg_178_1.actors_["10022"].transform:GetChild(iter_181_0)

					if var_181_0.name == "" or not string.find(var_181_0.name, "split") then
						var_181_0.gameObject:SetActive(true)
					else
						var_181_0.gameObject:SetActive(false)
					end
				end
			end

			local var_181_1 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_1 then
				arg_178_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_178_1.time_ - 0) / var_181_1)
			end

			if arg_178_1.time_ >= 0 + var_181_1 and arg_178_1.time_ < 0 + var_181_1 + arg_181_0 then
				arg_178_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_181_2 = 0
			local var_181_3 = 0.925

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_4 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(413062043).content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_6 = 37 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_4) / 37)

				if (37 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_4) / 37)) > 0 and var_181_3 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_2
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_3, arg_178_1.talkMaxDuration)

			if var_181_2 <= arg_178_1.time_ and arg_178_1.time_ < var_181_2 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_2) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_2 + var_181_7 and arg_178_1.time_ < var_181_2 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
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

		arg_178_1:InitPlayNodeList()
	end,
	Play413062044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 413062044
		arg_182_1.duration_ = 5.77

		local var_182_0 = {
			zh = 4.233,
			ja = 5.766
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play413062045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos10022 = arg_182_1.actors_["10022"].transform.localPosition
				arg_182_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10022", 3)

				for iter_185_0 = 0, arg_182_1.actors_["10022"].transform.childCount - 1 do
					local var_185_0 = arg_182_1.actors_["10022"].transform:GetChild(iter_185_0)

					if var_185_0.name == "split_8" or not string.find(var_185_0.name, "split") then
						var_185_0.gameObject:SetActive(true)
					else
						var_185_0.gameObject:SetActive(false)
					end
				end
			end

			local var_185_1 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_1 then
				arg_182_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_182_1.time_ - 0) / var_185_1)
			end

			if arg_182_1.time_ >= 0 + var_185_1 and arg_182_1.time_ < 0 + var_185_1 + arg_185_0 then
				arg_182_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_185_2 = arg_182_1.actors_["10022"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.actorSpriteComps10022 == nil then
				arg_182_1.var_.actorSpriteComps10022 = var_185_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_3 = 2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_3 and not isNil(var_185_2) then
				if arg_182_1.var_.actorSpriteComps10022 then
					for iter_185_1, iter_185_2 in pairs(arg_182_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_185_2 then
							if arg_182_1.isInRecall_ then
								iter_185_2.color = Color.New(Mathf.Lerp(iter_185_2.color.r, arg_182_1.hightColor1.r, (arg_182_1.time_ - 0) / var_185_3), Mathf.Lerp(iter_185_2.color.g, arg_182_1.hightColor1.g, (arg_182_1.time_ - 0) / var_185_3), (Mathf.Lerp(iter_185_2.color.b, arg_182_1.hightColor1.b, (arg_182_1.time_ - 0) / var_185_3)))
							else
								local var_185_4 = Mathf.Lerp(iter_185_2.color.r, 1, (arg_182_1.time_ - 0) / var_185_3)

								iter_185_2.color = Color.New(var_185_4, var_185_4, var_185_4)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_3 and arg_182_1.time_ < 0 + var_185_3 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.actorSpriteComps10022 then
				for iter_185_3, iter_185_4 in pairs(arg_182_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_185_4 then
						iter_185_4.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_182_1.var_.actorSpriteComps10022 = nil
			end

			local var_185_5 = 0
			local var_185_6 = 0.625

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_7 = arg_182_1:GetWordFromCfg(413062044)
				local var_185_8 = arg_182_1:FormatText(var_185_7.content)

				arg_182_1.text_.text = var_185_8

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_10 = 25 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 25)

				if (25 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 25)) > 0 and var_185_6 < var_185_10 then
					arg_182_1.talkMaxDuration = var_185_10

					if var_185_10 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_5
					end
				end

				arg_182_1.text_.text = var_185_8
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062044", "story_v_out_413062.awb") ~= 0 then
					local var_185_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062044", "story_v_out_413062.awb") / 1000

					if var_185_11 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_11 + var_185_5
					end

					if var_185_7.prefab_name ~= "" and arg_182_1.actors_[var_185_7.prefab_name] ~= nil then
						local var_185_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_7.prefab_name].transform, "story_v_out_413062", "413062044", "story_v_out_413062.awb")

						arg_182_1:RecordAudio("413062044", var_185_12)
						arg_182_1:RecordAudio("413062044", var_185_12)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_413062", "413062044", "story_v_out_413062.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_413062", "413062044", "story_v_out_413062.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_13 = math.max(var_185_6, arg_182_1.talkMaxDuration)

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_13 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_5) / var_185_13

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_5 + var_185_13 and arg_182_1.time_ < var_185_5 + var_185_13 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
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

		arg_182_1:InitPlayNodeList()
	end,
	Play413062045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 413062045
		arg_186_1.duration_ = 9.23

		local var_186_0 = {
			zh = 9.233,
			ja = 6.9
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play413062046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if arg_186_1.bgs_.F08i == nil then
				local var_189_0 = Object.Instantiate(arg_186_1.paintGo_)

				var_189_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08i")
				var_189_0.name = "F08i"
				var_189_0.transform.parent = arg_186_1.stage_.transform
				var_189_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.bgs_.F08i = var_189_0
			end

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= 2 + arg_189_0 then
				local var_189_1 = arg_186_1.bgs_.F08i

				arg_186_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_189_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_189_2 = var_189_1:GetComponent("SpriteRenderer")

				if var_189_2 and var_189_2.sprite then
					local var_189_3 = 2 * (var_189_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_189_1.transform.localScale = Vector3.New(var_189_3 / var_189_2.sprite.bounds.size.y < var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x and var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x or var_189_3 / var_189_2.sprite.bounds.size.y, var_189_3 / var_189_2.sprite.bounds.size.y < var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x and var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x or var_189_3 / var_189_2.sprite.bounds.size.y, 0)
				end

				for iter_189_0, iter_189_1 in pairs(arg_186_1.bgs_) do
					if iter_189_0 ~= "F08i" then
						iter_189_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_189_4 = 4

			if 4 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.allBtn_.enabled = false
			end

			if arg_186_1.time_ >= var_189_4 + 0.3 and arg_186_1.time_ < var_189_4 + 0.3 + arg_189_0 then
				arg_186_1.allBtn_.enabled = true
			end

			local var_189_5 = 0

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_6 = 2

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_6 then
				local var_189_7 = Color.New(0, 0, 0)

				var_189_7.a = Mathf.Lerp(0, 1, (arg_186_1.time_ - var_189_5) / var_189_6)
				arg_186_1.mask_.color = var_189_7
			end

			if arg_186_1.time_ >= var_189_5 + var_189_6 and arg_186_1.time_ < var_189_5 + var_189_6 + arg_189_0 then
				local var_189_8 = Color.New(0, 0, 0)

				var_189_8.a = 1
				arg_186_1.mask_.color = var_189_8
			end

			local var_189_9 = 2

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= var_189_9 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_10 = 2

			if var_189_9 <= arg_186_1.time_ and arg_186_1.time_ < var_189_9 + var_189_10 then
				local var_189_11 = Color.New(0, 0, 0)

				var_189_11.a = Mathf.Lerp(1, 0, (arg_186_1.time_ - var_189_9) / var_189_10)
				arg_186_1.mask_.color = var_189_11
			end

			if arg_186_1.time_ >= var_189_9 + var_189_10 and arg_186_1.time_ < var_189_9 + var_189_10 + arg_189_0 then
				local var_189_12 = Color.New(0, 0, 0)

				arg_186_1.mask_.enabled = false
				var_189_12.a = 0
				arg_186_1.mask_.color = var_189_12
			end

			local var_189_13 = arg_186_1.actors_["10022"].transform

			if 1.966 < arg_186_1.time_ and arg_186_1.time_ <= 1.966 + arg_189_0 then
				arg_186_1.var_.moveOldPos10022 = var_189_13.localPosition
				var_189_13.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("10022", 7)

				for iter_189_2 = 0, var_189_13.childCount - 1 do
					local var_189_14 = var_189_13:GetChild(iter_189_2)

					if var_189_14.name == "split_6" or not string.find(var_189_14.name, "split") then
						var_189_14.gameObject:SetActive(true)
					else
						var_189_14.gameObject:SetActive(false)
					end
				end
			end

			local var_189_15 = 0.001

			if 1.966 <= arg_186_1.time_ and arg_186_1.time_ < 1.966 + var_189_15 then
				var_189_13.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_186_1.time_ - 1.966) / var_189_15)
			end

			if arg_186_1.time_ >= 1.966 + var_189_15 and arg_186_1.time_ < 1.966 + var_189_15 + arg_189_0 then
				var_189_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_189_16 = arg_186_1.actors_["10022"]

			if 1.966 < arg_186_1.time_ and arg_186_1.time_ <= 1.966 + arg_189_0 and not isNil(var_189_16) and arg_186_1.var_.actorSpriteComps10022 == nil then
				arg_186_1.var_.actorSpriteComps10022 = var_189_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_17 = 0.034

			if 1.966 <= arg_186_1.time_ and arg_186_1.time_ < 1.966 + var_189_17 and not isNil(var_189_16) then
				if arg_186_1.var_.actorSpriteComps10022 then
					for iter_189_3, iter_189_4 in pairs(arg_186_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_189_4 then
							if arg_186_1.isInRecall_ then
								iter_189_4.color = Color.New(Mathf.Lerp(iter_189_4.color.r, arg_186_1.hightColor1.r, (arg_186_1.time_ - 1.966) / var_189_17), Mathf.Lerp(iter_189_4.color.g, arg_186_1.hightColor1.g, (arg_186_1.time_ - 1.966) / var_189_17), (Mathf.Lerp(iter_189_4.color.b, arg_186_1.hightColor1.b, (arg_186_1.time_ - 1.966) / var_189_17)))
							else
								local var_189_18 = Mathf.Lerp(iter_189_4.color.r, 1, (arg_186_1.time_ - 1.966) / var_189_17)

								iter_189_4.color = Color.New(var_189_18, var_189_18, var_189_18)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 1.966 + var_189_17 and arg_186_1.time_ < 1.966 + var_189_17 + arg_189_0 and not isNil(var_189_16) and arg_186_1.var_.actorSpriteComps10022 then
				for iter_189_5, iter_189_6 in pairs(arg_186_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_189_6 then
						iter_189_6.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_186_1.var_.actorSpriteComps10022 = nil
			end

			local var_189_19 = arg_186_1.actors_["10022"].transform

			if 3.8 < arg_186_1.time_ and arg_186_1.time_ <= 3.8 + arg_189_0 then
				arg_186_1.var_.moveOldPos10022 = var_189_19.localPosition
				var_189_19.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("10022", 3)

				for iter_189_7 = 0, var_189_19.childCount - 1 do
					local var_189_20 = var_189_19:GetChild(iter_189_7)

					if var_189_20.name == "split_2" or not string.find(var_189_20.name, "split") then
						var_189_20.gameObject:SetActive(true)
					else
						var_189_20.gameObject:SetActive(false)
					end
				end
			end

			local var_189_21 = 0.001

			if 3.8 <= arg_186_1.time_ and arg_186_1.time_ < 3.8 + var_189_21 then
				var_189_19.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_186_1.time_ - 3.8) / var_189_21)
			end

			if arg_186_1.time_ >= 3.8 + var_189_21 and arg_186_1.time_ < 3.8 + var_189_21 + arg_189_0 then
				var_189_19.localPosition = Vector3.New(0, -315, -320)
			end

			local var_189_22 = arg_186_1.actors_["10022"]

			if 3.8 < arg_186_1.time_ and arg_186_1.time_ <= 3.8 + arg_189_0 and not isNil(var_189_22) and arg_186_1.var_.actorSpriteComps10022 == nil then
				arg_186_1.var_.actorSpriteComps10022 = var_189_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_23 = 2

			if 3.8 <= arg_186_1.time_ and arg_186_1.time_ < 3.8 + var_189_23 and not isNil(var_189_22) then
				if arg_186_1.var_.actorSpriteComps10022 then
					for iter_189_8, iter_189_9 in pairs(arg_186_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_189_9 then
							if arg_186_1.isInRecall_ then
								iter_189_9.color = Color.New(Mathf.Lerp(iter_189_9.color.r, arg_186_1.hightColor1.r, (arg_186_1.time_ - 3.8) / var_189_23), Mathf.Lerp(iter_189_9.color.g, arg_186_1.hightColor1.g, (arg_186_1.time_ - 3.8) / var_189_23), (Mathf.Lerp(iter_189_9.color.b, arg_186_1.hightColor1.b, (arg_186_1.time_ - 3.8) / var_189_23)))
							else
								local var_189_24 = Mathf.Lerp(iter_189_9.color.r, 1, (arg_186_1.time_ - 3.8) / var_189_23)

								iter_189_9.color = Color.New(var_189_24, var_189_24, var_189_24)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 3.8 + var_189_23 and arg_186_1.time_ < 3.8 + var_189_23 + arg_189_0 and not isNil(var_189_22) and arg_186_1.var_.actorSpriteComps10022 then
				for iter_189_10, iter_189_11 in pairs(arg_186_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_189_11 then
						iter_189_11.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_186_1.var_.actorSpriteComps10022 = nil
			end

			if 3.8 < arg_186_1.time_ and arg_186_1.time_ <= 3.8 + arg_189_0 then
				local var_189_25 = arg_186_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_189_25 then
					arg_186_1.var_.alphaOldValue10022 = var_189_25.alpha
					arg_186_1.var_.characterEffect10022 = var_189_25
				end

				arg_186_1.var_.alphaOldValue10022 = 0
			end

			local var_189_26 = 0.5

			if 3.8 <= arg_186_1.time_ and arg_186_1.time_ < 3.8 + var_189_26 then
				if arg_186_1.var_.characterEffect10022 then
					arg_186_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_186_1.var_.alphaOldValue10022, 1, (arg_186_1.time_ - 3.8) / var_189_26)
				end
			end

			if arg_186_1.time_ >= 3.8 + var_189_26 and arg_186_1.time_ < 3.8 + var_189_26 + arg_189_0 and arg_186_1.var_.characterEffect10022 then
				arg_186_1.var_.characterEffect10022.alpha = 1
			end

			if arg_186_1.frameCnt_ <= 1 then
				arg_186_1.dialog_:SetActive(false)
			end

			local var_189_27 = 4
			local var_189_28 = 0.575

			if 4 < arg_186_1.time_ and arg_186_1.time_ <= var_189_27 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_29 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_29:setOnUpdate(LuaHelper.FloatAction(function(arg_190_0)
					arg_186_1.dialogCg_.alpha = arg_190_0
				end))
				var_189_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_30 = arg_186_1:GetWordFromCfg(413062045)
				local var_189_31 = arg_186_1:FormatText(var_189_30.content)

				arg_186_1.text_.text = var_189_31

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_33 = 23 <= 0 and var_189_28 or var_189_28 * (utf8.len(var_189_31) / 23)

				if (23 <= 0 and var_189_28 or var_189_28 * (utf8.len(var_189_31) / 23)) > 0 and var_189_28 < var_189_33 then
					arg_186_1.talkMaxDuration = var_189_33
					var_189_27 = var_189_27 + 0.3

					if var_189_33 + var_189_27 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_33 + var_189_27
					end
				end

				arg_186_1.text_.text = var_189_31
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062045", "story_v_out_413062.awb") ~= 0 then
					local var_189_34 = manager.audio:GetVoiceLength("story_v_out_413062", "413062045", "story_v_out_413062.awb") / 1000

					if var_189_34 + var_189_27 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_34 + var_189_27
					end

					if var_189_30.prefab_name ~= "" and arg_186_1.actors_[var_189_30.prefab_name] ~= nil then
						local var_189_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_30.prefab_name].transform, "story_v_out_413062", "413062045", "story_v_out_413062.awb")

						arg_186_1:RecordAudio("413062045", var_189_35)
						arg_186_1:RecordAudio("413062045", var_189_35)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_413062", "413062045", "story_v_out_413062.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_413062", "413062045", "story_v_out_413062.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_36 = var_189_27 + 0.3
			local var_189_37 = math.max(var_189_28, arg_186_1.talkMaxDuration)

			if var_189_27 + 0.3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_36 + var_189_37 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_36) / var_189_37

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_36 + var_189_37 and arg_186_1.time_ < var_189_36 + var_189_37 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play413062046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 413062046
		arg_192_1.duration_ = 8

		local var_192_0 = {
			zh = 3.8,
			ja = 8
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
				arg_192_0:Play413062047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if arg_192_1.actors_["10097"] == nil then
				local var_195_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10097")

				if not isNil(var_195_0) then
					local var_195_1 = Object.Instantiate(var_195_0, arg_192_1.canvasGo_.transform)

					var_195_1.transform:SetSiblingIndex(1)

					var_195_1.name = "10097"
					var_195_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_192_1.actors_["10097"] = var_195_1

					if arg_192_1.isInRecall_ then
						for iter_195_0, iter_195_1 in ipairs((var_195_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_195_1.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_195_2 = arg_192_1.actors_["10097"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10097 = var_195_2.localPosition
				var_195_2.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10097", 2)

				for iter_195_2 = 0, var_195_2.childCount - 1 do
					local var_195_3 = var_195_2:GetChild(iter_195_2)

					if var_195_3.name == "" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				var_195_2.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_192_1.time_ - 0) / var_195_4)
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				var_195_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_195_5 = arg_192_1.actors_["10022"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10022 = var_195_5.localPosition
				var_195_5.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10022", 4)

				for iter_195_3 = 0, var_195_5.childCount - 1 do
					local var_195_6 = var_195_5:GetChild(iter_195_3)

					if var_195_6.name == "split_8" or not string.find(var_195_6.name, "split") then
						var_195_6.gameObject:SetActive(true)
					else
						var_195_6.gameObject:SetActive(false)
					end
				end
			end

			local var_195_7 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_7 then
				var_195_5.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_192_1.time_ - 0) / var_195_7)
			end

			if arg_192_1.time_ >= 0 + var_195_7 and arg_192_1.time_ < 0 + var_195_7 + arg_195_0 then
				var_195_5.localPosition = Vector3.New(390, -315, -320)
			end

			local var_195_8 = arg_192_1.actors_["10097"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps10097 == nil then
				arg_192_1.var_.actorSpriteComps10097 = var_195_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_9 = 2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_9 and not isNil(var_195_8) then
				if arg_192_1.var_.actorSpriteComps10097 then
					for iter_195_4, iter_195_5 in pairs(arg_192_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_195_5 then
							if arg_192_1.isInRecall_ then
								iter_195_5.color = Color.New(Mathf.Lerp(iter_195_5.color.r, arg_192_1.hightColor1.r, (arg_192_1.time_ - 0) / var_195_9), Mathf.Lerp(iter_195_5.color.g, arg_192_1.hightColor1.g, (arg_192_1.time_ - 0) / var_195_9), (Mathf.Lerp(iter_195_5.color.b, arg_192_1.hightColor1.b, (arg_192_1.time_ - 0) / var_195_9)))
							else
								local var_195_10 = Mathf.Lerp(iter_195_5.color.r, 1, (arg_192_1.time_ - 0) / var_195_9)

								iter_195_5.color = Color.New(var_195_10, var_195_10, var_195_10)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_9 and arg_192_1.time_ < 0 + var_195_9 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps10097 then
				for iter_195_6, iter_195_7 in pairs(arg_192_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_195_7 then
						iter_195_7.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_192_1.var_.actorSpriteComps10097 = nil
			end

			local var_195_11 = arg_192_1.actors_["10022"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_11) and arg_192_1.var_.actorSpriteComps10022 == nil then
				arg_192_1.var_.actorSpriteComps10022 = var_195_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_12 = 2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_12 and not isNil(var_195_11) then
				if arg_192_1.var_.actorSpriteComps10022 then
					for iter_195_8, iter_195_9 in pairs(arg_192_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_195_9 then
							if arg_192_1.isInRecall_ then
								iter_195_9.color = Color.New(Mathf.Lerp(iter_195_9.color.r, arg_192_1.hightColor2.r, (arg_192_1.time_ - 0) / var_195_12), Mathf.Lerp(iter_195_9.color.g, arg_192_1.hightColor2.g, (arg_192_1.time_ - 0) / var_195_12), (Mathf.Lerp(iter_195_9.color.b, arg_192_1.hightColor2.b, (arg_192_1.time_ - 0) / var_195_12)))
							else
								local var_195_13 = Mathf.Lerp(iter_195_9.color.r, 0.5, (arg_192_1.time_ - 0) / var_195_12)

								iter_195_9.color = Color.New(var_195_13, var_195_13, var_195_13)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_12 and arg_192_1.time_ < 0 + var_195_12 + arg_195_0 and not isNil(var_195_11) and arg_192_1.var_.actorSpriteComps10022 then
				for iter_195_10, iter_195_11 in pairs(arg_192_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_195_11 then
						iter_195_11.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_192_1.var_.actorSpriteComps10022 = nil
			end

			local var_195_14 = 0
			local var_195_15 = 0.35

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_14 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_16 = arg_192_1:GetWordFromCfg(413062046)
				local var_195_17 = arg_192_1:FormatText(var_195_16.content)

				arg_192_1.text_.text = var_195_17

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_19 = 14 <= 0 and var_195_15 or var_195_15 * (utf8.len(var_195_17) / 14)

				if (14 <= 0 and var_195_15 or var_195_15 * (utf8.len(var_195_17) / 14)) > 0 and var_195_15 < var_195_19 then
					arg_192_1.talkMaxDuration = var_195_19

					if var_195_19 + var_195_14 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_19 + var_195_14
					end
				end

				arg_192_1.text_.text = var_195_17
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062046", "story_v_out_413062.awb") ~= 0 then
					local var_195_20 = manager.audio:GetVoiceLength("story_v_out_413062", "413062046", "story_v_out_413062.awb") / 1000

					if var_195_20 + var_195_14 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_20 + var_195_14
					end

					if var_195_16.prefab_name ~= "" and arg_192_1.actors_[var_195_16.prefab_name] ~= nil then
						local var_195_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_16.prefab_name].transform, "story_v_out_413062", "413062046", "story_v_out_413062.awb")

						arg_192_1:RecordAudio("413062046", var_195_21)
						arg_192_1:RecordAudio("413062046", var_195_21)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_413062", "413062046", "story_v_out_413062.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_413062", "413062046", "story_v_out_413062.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_22 = math.max(var_195_15, arg_192_1.talkMaxDuration)

			if var_195_14 <= arg_192_1.time_ and arg_192_1.time_ < var_195_14 + var_195_22 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_14) / var_195_22

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_14 + var_195_22 and arg_192_1.time_ < var_195_14 + var_195_22 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_192_1:InitPlayNodeList()
	end,
	Play413062047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 413062047
		arg_196_1.duration_ = 4.2

		local var_196_0 = {
			zh = 2.9,
			ja = 4.2
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
				arg_196_0:Play413062048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10097 = arg_196_1.actors_["10097"].transform.localPosition
				arg_196_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10097", 2)

				for iter_199_0 = 0, arg_196_1.actors_["10097"].transform.childCount - 1 do
					local var_199_0 = arg_196_1.actors_["10097"].transform:GetChild(iter_199_0)

					if var_199_0.name == "split_1" or not string.find(var_199_0.name, "split") then
						var_199_0.gameObject:SetActive(true)
					else
						var_199_0.gameObject:SetActive(false)
					end
				end
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_196_1.time_ - 0) / var_199_1)
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_199_2 = arg_196_1.actors_["10097"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10097 == nil then
				arg_196_1.var_.actorSpriteComps10097 = var_199_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_3 = 2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.actorSpriteComps10097 then
					for iter_199_1, iter_199_2 in pairs(arg_196_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_199_2 then
							if arg_196_1.isInRecall_ then
								iter_199_2.color = Color.New(Mathf.Lerp(iter_199_2.color.r, arg_196_1.hightColor2.r, (arg_196_1.time_ - 0) / var_199_3), Mathf.Lerp(iter_199_2.color.g, arg_196_1.hightColor2.g, (arg_196_1.time_ - 0) / var_199_3), (Mathf.Lerp(iter_199_2.color.b, arg_196_1.hightColor2.b, (arg_196_1.time_ - 0) / var_199_3)))
							else
								local var_199_4 = Mathf.Lerp(iter_199_2.color.r, 0.5, (arg_196_1.time_ - 0) / var_199_3)

								iter_199_2.color = Color.New(var_199_4, var_199_4, var_199_4)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10097 then
				for iter_199_3, iter_199_4 in pairs(arg_196_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_199_4 then
						iter_199_4.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_196_1.var_.actorSpriteComps10097 = nil
			end

			local var_199_5 = arg_196_1.actors_["10022"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_5) and arg_196_1.var_.actorSpriteComps10022 == nil then
				arg_196_1.var_.actorSpriteComps10022 = var_199_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_6 = 2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_6 and not isNil(var_199_5) then
				if arg_196_1.var_.actorSpriteComps10022 then
					for iter_199_5, iter_199_6 in pairs(arg_196_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_199_6 then
							if arg_196_1.isInRecall_ then
								iter_199_6.color = Color.New(Mathf.Lerp(iter_199_6.color.r, arg_196_1.hightColor1.r, (arg_196_1.time_ - 0) / var_199_6), Mathf.Lerp(iter_199_6.color.g, arg_196_1.hightColor1.g, (arg_196_1.time_ - 0) / var_199_6), (Mathf.Lerp(iter_199_6.color.b, arg_196_1.hightColor1.b, (arg_196_1.time_ - 0) / var_199_6)))
							else
								local var_199_7 = Mathf.Lerp(iter_199_6.color.r, 1, (arg_196_1.time_ - 0) / var_199_6)

								iter_199_6.color = Color.New(var_199_7, var_199_7, var_199_7)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_6 and arg_196_1.time_ < 0 + var_199_6 + arg_199_0 and not isNil(var_199_5) and arg_196_1.var_.actorSpriteComps10022 then
				for iter_199_7, iter_199_8 in pairs(arg_196_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_199_8 then
						iter_199_8.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_196_1.var_.actorSpriteComps10022 = nil
			end

			local var_199_8 = 0
			local var_199_9 = 0.325

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_8 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_10 = arg_196_1:GetWordFromCfg(413062047)
				local var_199_11 = arg_196_1:FormatText(var_199_10.content)

				arg_196_1.text_.text = var_199_11

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_13 = 13 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_11) / 13)

				if (13 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_11) / 13)) > 0 and var_199_9 < var_199_13 then
					arg_196_1.talkMaxDuration = var_199_13

					if var_199_13 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_13 + var_199_8
					end
				end

				arg_196_1.text_.text = var_199_11
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062047", "story_v_out_413062.awb") ~= 0 then
					local var_199_14 = manager.audio:GetVoiceLength("story_v_out_413062", "413062047", "story_v_out_413062.awb") / 1000

					if var_199_14 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_14 + var_199_8
					end

					if var_199_10.prefab_name ~= "" and arg_196_1.actors_[var_199_10.prefab_name] ~= nil then
						local var_199_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_10.prefab_name].transform, "story_v_out_413062", "413062047", "story_v_out_413062.awb")

						arg_196_1:RecordAudio("413062047", var_199_15)
						arg_196_1:RecordAudio("413062047", var_199_15)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_413062", "413062047", "story_v_out_413062.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_413062", "413062047", "story_v_out_413062.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_16 = math.max(var_199_9, arg_196_1.talkMaxDuration)

			if var_199_8 <= arg_196_1.time_ and arg_196_1.time_ < var_199_8 + var_199_16 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_8) / var_199_16

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_8 + var_199_16 and arg_196_1.time_ < var_199_8 + var_199_16 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play413062048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 413062048
		arg_200_1.duration_ = 9.73

		local var_200_0 = {
			zh = 3.166,
			ja = 9.733
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play413062049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["10097"]) and arg_200_1.var_.actorSpriteComps10097 == nil then
				arg_200_1.var_.actorSpriteComps10097 = arg_200_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_0 = 2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["10097"]) then
				if arg_200_1.var_.actorSpriteComps10097 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								iter_203_1.color = Color.New(Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor1.r, (arg_200_1.time_ - 0) / var_203_0), Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor1.g, (arg_200_1.time_ - 0) / var_203_0), (Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor1.b, (arg_200_1.time_ - 0) / var_203_0)))
							else
								local var_203_1 = Mathf.Lerp(iter_203_1.color.r, 1, (arg_200_1.time_ - 0) / var_203_0)

								iter_203_1.color = Color.New(var_203_1, var_203_1, var_203_1)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["10097"]) and arg_200_1.var_.actorSpriteComps10097 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_203_3 then
						iter_203_3.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_200_1.var_.actorSpriteComps10097 = nil
			end

			local var_203_2 = arg_200_1.actors_["10022"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10022 == nil then
				arg_200_1.var_.actorSpriteComps10022 = var_203_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_3 = 2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.actorSpriteComps10022 then
					for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_203_5 then
							if arg_200_1.isInRecall_ then
								iter_203_5.color = Color.New(Mathf.Lerp(iter_203_5.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_3), Mathf.Lerp(iter_203_5.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_3), (Mathf.Lerp(iter_203_5.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_3)))
							else
								local var_203_4 = Mathf.Lerp(iter_203_5.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_3)

								iter_203_5.color = Color.New(var_203_4, var_203_4, var_203_4)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10022 then
				for iter_203_6, iter_203_7 in pairs(arg_200_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_203_7 then
						iter_203_7.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10022 = nil
			end

			local var_203_5 = 0
			local var_203_6 = 0.3

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_7 = arg_200_1:GetWordFromCfg(413062048)
				local var_203_8 = arg_200_1:FormatText(var_203_7.content)

				arg_200_1.text_.text = var_203_8

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_10 = 12 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_8) / 12)

				if (12 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_8) / 12)) > 0 and var_203_6 < var_203_10 then
					arg_200_1.talkMaxDuration = var_203_10

					if var_203_10 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_5
					end
				end

				arg_200_1.text_.text = var_203_8
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062048", "story_v_out_413062.awb") ~= 0 then
					local var_203_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062048", "story_v_out_413062.awb") / 1000

					if var_203_11 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_11 + var_203_5
					end

					if var_203_7.prefab_name ~= "" and arg_200_1.actors_[var_203_7.prefab_name] ~= nil then
						local var_203_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_7.prefab_name].transform, "story_v_out_413062", "413062048", "story_v_out_413062.awb")

						arg_200_1:RecordAudio("413062048", var_203_12)
						arg_200_1:RecordAudio("413062048", var_203_12)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_413062", "413062048", "story_v_out_413062.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_413062", "413062048", "story_v_out_413062.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_13 = math.max(var_203_6, arg_200_1.talkMaxDuration)

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_13 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_5) / var_203_13

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_5 + var_203_13 and arg_200_1.time_ < var_203_5 + var_203_13 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play413062049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 413062049
		arg_204_1.duration_ = 4.83

		local var_204_0 = {
			zh = 2.966,
			ja = 4.833
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play413062050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["10097"]) and arg_204_1.var_.actorSpriteComps10097 == nil then
				arg_204_1.var_.actorSpriteComps10097 = arg_204_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_0 = 2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["10097"]) then
				if arg_204_1.var_.actorSpriteComps10097 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								iter_207_1.color = Color.New(Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor2.r, (arg_204_1.time_ - 0) / var_207_0), Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor2.g, (arg_204_1.time_ - 0) / var_207_0), (Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor2.b, (arg_204_1.time_ - 0) / var_207_0)))
							else
								local var_207_1 = Mathf.Lerp(iter_207_1.color.r, 0.5, (arg_204_1.time_ - 0) / var_207_0)

								iter_207_1.color = Color.New(var_207_1, var_207_1, var_207_1)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["10097"]) and arg_204_1.var_.actorSpriteComps10097 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_207_3 then
						iter_207_3.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_204_1.var_.actorSpriteComps10097 = nil
			end

			local var_207_2 = arg_204_1.actors_["10022"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps10022 == nil then
				arg_204_1.var_.actorSpriteComps10022 = var_207_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_3 = 2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.actorSpriteComps10022 then
					for iter_207_4, iter_207_5 in pairs(arg_204_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_207_5 then
							if arg_204_1.isInRecall_ then
								iter_207_5.color = Color.New(Mathf.Lerp(iter_207_5.color.r, arg_204_1.hightColor1.r, (arg_204_1.time_ - 0) / var_207_3), Mathf.Lerp(iter_207_5.color.g, arg_204_1.hightColor1.g, (arg_204_1.time_ - 0) / var_207_3), (Mathf.Lerp(iter_207_5.color.b, arg_204_1.hightColor1.b, (arg_204_1.time_ - 0) / var_207_3)))
							else
								local var_207_4 = Mathf.Lerp(iter_207_5.color.r, 1, (arg_204_1.time_ - 0) / var_207_3)

								iter_207_5.color = Color.New(var_207_4, var_207_4, var_207_4)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps10022 then
				for iter_207_6, iter_207_7 in pairs(arg_204_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_207_7 then
						iter_207_7.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_204_1.var_.actorSpriteComps10022 = nil
			end

			local var_207_5 = 0
			local var_207_6 = 0.425

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_7 = arg_204_1:GetWordFromCfg(413062049)
				local var_207_8 = arg_204_1:FormatText(var_207_7.content)

				arg_204_1.text_.text = var_207_8

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_10 = 17 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_8) / 17)

				if (17 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_8) / 17)) > 0 and var_207_6 < var_207_10 then
					arg_204_1.talkMaxDuration = var_207_10

					if var_207_10 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_5
					end
				end

				arg_204_1.text_.text = var_207_8
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062049", "story_v_out_413062.awb") ~= 0 then
					local var_207_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062049", "story_v_out_413062.awb") / 1000

					if var_207_11 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_11 + var_207_5
					end

					if var_207_7.prefab_name ~= "" and arg_204_1.actors_[var_207_7.prefab_name] ~= nil then
						local var_207_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_7.prefab_name].transform, "story_v_out_413062", "413062049", "story_v_out_413062.awb")

						arg_204_1:RecordAudio("413062049", var_207_12)
						arg_204_1:RecordAudio("413062049", var_207_12)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_413062", "413062049", "story_v_out_413062.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_413062", "413062049", "story_v_out_413062.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_13 = math.max(var_207_6, arg_204_1.talkMaxDuration)

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_13 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_5) / var_207_13

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_5 + var_207_13 and arg_204_1.time_ < var_207_5 + var_207_13 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play413062050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 413062050
		arg_208_1.duration_ = 8.03

		local var_208_0 = {
			zh = 7.4,
			ja = 8.033
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play413062051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["10097"]) and arg_208_1.var_.actorSpriteComps10097 == nil then
				arg_208_1.var_.actorSpriteComps10097 = arg_208_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_0 = 2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["10097"]) then
				if arg_208_1.var_.actorSpriteComps10097 then
					for iter_211_0, iter_211_1 in pairs(arg_208_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_211_1 then
							if arg_208_1.isInRecall_ then
								iter_211_1.color = Color.New(Mathf.Lerp(iter_211_1.color.r, arg_208_1.hightColor1.r, (arg_208_1.time_ - 0) / var_211_0), Mathf.Lerp(iter_211_1.color.g, arg_208_1.hightColor1.g, (arg_208_1.time_ - 0) / var_211_0), (Mathf.Lerp(iter_211_1.color.b, arg_208_1.hightColor1.b, (arg_208_1.time_ - 0) / var_211_0)))
							else
								local var_211_1 = Mathf.Lerp(iter_211_1.color.r, 1, (arg_208_1.time_ - 0) / var_211_0)

								iter_211_1.color = Color.New(var_211_1, var_211_1, var_211_1)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["10097"]) and arg_208_1.var_.actorSpriteComps10097 then
				for iter_211_2, iter_211_3 in pairs(arg_208_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_211_3 then
						iter_211_3.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_208_1.var_.actorSpriteComps10097 = nil
			end

			local var_211_2 = arg_208_1.actors_["10022"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.actorSpriteComps10022 == nil then
				arg_208_1.var_.actorSpriteComps10022 = var_211_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_3 = 2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_3 and not isNil(var_211_2) then
				if arg_208_1.var_.actorSpriteComps10022 then
					for iter_211_4, iter_211_5 in pairs(arg_208_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_211_5 then
							if arg_208_1.isInRecall_ then
								iter_211_5.color = Color.New(Mathf.Lerp(iter_211_5.color.r, arg_208_1.hightColor2.r, (arg_208_1.time_ - 0) / var_211_3), Mathf.Lerp(iter_211_5.color.g, arg_208_1.hightColor2.g, (arg_208_1.time_ - 0) / var_211_3), (Mathf.Lerp(iter_211_5.color.b, arg_208_1.hightColor2.b, (arg_208_1.time_ - 0) / var_211_3)))
							else
								local var_211_4 = Mathf.Lerp(iter_211_5.color.r, 0.5, (arg_208_1.time_ - 0) / var_211_3)

								iter_211_5.color = Color.New(var_211_4, var_211_4, var_211_4)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 0 + var_211_3 and arg_208_1.time_ < 0 + var_211_3 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.actorSpriteComps10022 then
				for iter_211_6, iter_211_7 in pairs(arg_208_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_211_7 then
						iter_211_7.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_208_1.var_.actorSpriteComps10022 = nil
			end

			local var_211_5 = 0
			local var_211_6 = 0.875

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_7 = arg_208_1:GetWordFromCfg(413062050)
				local var_211_8 = arg_208_1:FormatText(var_211_7.content)

				arg_208_1.text_.text = var_211_8

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_10 = 35 <= 0 and var_211_6 or var_211_6 * (utf8.len(var_211_8) / 35)

				if (35 <= 0 and var_211_6 or var_211_6 * (utf8.len(var_211_8) / 35)) > 0 and var_211_6 < var_211_10 then
					arg_208_1.talkMaxDuration = var_211_10

					if var_211_10 + var_211_5 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_5
					end
				end

				arg_208_1.text_.text = var_211_8
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062050", "story_v_out_413062.awb") ~= 0 then
					local var_211_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062050", "story_v_out_413062.awb") / 1000

					if var_211_11 + var_211_5 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_11 + var_211_5
					end

					if var_211_7.prefab_name ~= "" and arg_208_1.actors_[var_211_7.prefab_name] ~= nil then
						local var_211_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_7.prefab_name].transform, "story_v_out_413062", "413062050", "story_v_out_413062.awb")

						arg_208_1:RecordAudio("413062050", var_211_12)
						arg_208_1:RecordAudio("413062050", var_211_12)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_413062", "413062050", "story_v_out_413062.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_413062", "413062050", "story_v_out_413062.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_13 = math.max(var_211_6, arg_208_1.talkMaxDuration)

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_13 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_5) / var_211_13

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_5 + var_211_13 and arg_208_1.time_ < var_211_5 + var_211_13 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play413062051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 413062051
		arg_212_1.duration_ = 8.13

		local var_212_0 = {
			zh = 3.433,
			ja = 8.133
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
				arg_212_0:Play413062052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["10097"]) and arg_212_1.var_.actorSpriteComps10097 == nil then
				arg_212_1.var_.actorSpriteComps10097 = arg_212_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_0 = 2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["10097"]) then
				if arg_212_1.var_.actorSpriteComps10097 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								iter_215_1.color = Color.New(Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor2.r, (arg_212_1.time_ - 0) / var_215_0), Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor2.g, (arg_212_1.time_ - 0) / var_215_0), (Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor2.b, (arg_212_1.time_ - 0) / var_215_0)))
							else
								local var_215_1 = Mathf.Lerp(iter_215_1.color.r, 0.5, (arg_212_1.time_ - 0) / var_215_0)

								iter_215_1.color = Color.New(var_215_1, var_215_1, var_215_1)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["10097"]) and arg_212_1.var_.actorSpriteComps10097 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_215_3 then
						iter_215_3.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_212_1.var_.actorSpriteComps10097 = nil
			end

			local var_215_2 = arg_212_1.actors_["10022"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10022 == nil then
				arg_212_1.var_.actorSpriteComps10022 = var_215_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_3 = 2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.actorSpriteComps10022 then
					for iter_215_4, iter_215_5 in pairs(arg_212_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_215_5 then
							if arg_212_1.isInRecall_ then
								iter_215_5.color = Color.New(Mathf.Lerp(iter_215_5.color.r, arg_212_1.hightColor1.r, (arg_212_1.time_ - 0) / var_215_3), Mathf.Lerp(iter_215_5.color.g, arg_212_1.hightColor1.g, (arg_212_1.time_ - 0) / var_215_3), (Mathf.Lerp(iter_215_5.color.b, arg_212_1.hightColor1.b, (arg_212_1.time_ - 0) / var_215_3)))
							else
								local var_215_4 = Mathf.Lerp(iter_215_5.color.r, 1, (arg_212_1.time_ - 0) / var_215_3)

								iter_215_5.color = Color.New(var_215_4, var_215_4, var_215_4)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10022 then
				for iter_215_6, iter_215_7 in pairs(arg_212_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_215_7 then
						iter_215_7.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_212_1.var_.actorSpriteComps10022 = nil
			end

			local var_215_5 = 0
			local var_215_6 = 0.45

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_7 = arg_212_1:GetWordFromCfg(413062051)
				local var_215_8 = arg_212_1:FormatText(var_215_7.content)

				arg_212_1.text_.text = var_215_8

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_10 = 18 <= 0 and var_215_6 or var_215_6 * (utf8.len(var_215_8) / 18)

				if (18 <= 0 and var_215_6 or var_215_6 * (utf8.len(var_215_8) / 18)) > 0 and var_215_6 < var_215_10 then
					arg_212_1.talkMaxDuration = var_215_10

					if var_215_10 + var_215_5 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_5
					end
				end

				arg_212_1.text_.text = var_215_8
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062051", "story_v_out_413062.awb") ~= 0 then
					local var_215_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062051", "story_v_out_413062.awb") / 1000

					if var_215_11 + var_215_5 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_11 + var_215_5
					end

					if var_215_7.prefab_name ~= "" and arg_212_1.actors_[var_215_7.prefab_name] ~= nil then
						local var_215_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_7.prefab_name].transform, "story_v_out_413062", "413062051", "story_v_out_413062.awb")

						arg_212_1:RecordAudio("413062051", var_215_12)
						arg_212_1:RecordAudio("413062051", var_215_12)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_413062", "413062051", "story_v_out_413062.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_413062", "413062051", "story_v_out_413062.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_13 = math.max(var_215_6, arg_212_1.talkMaxDuration)

			if var_215_5 <= arg_212_1.time_ and arg_212_1.time_ < var_215_5 + var_215_13 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_5) / var_215_13

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_5 + var_215_13 and arg_212_1.time_ < var_215_5 + var_215_13 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play413062052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 413062052
		arg_216_1.duration_ = 12.93

		local var_216_0 = {
			zh = 5.5,
			ja = 12.933
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play413062053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10097 = arg_216_1.actors_["10097"].transform.localPosition
				arg_216_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("10097", 2)

				for iter_219_0 = 0, arg_216_1.actors_["10097"].transform.childCount - 1 do
					local var_219_0 = arg_216_1.actors_["10097"].transform:GetChild(iter_219_0)

					if var_219_0.name == "split_2" or not string.find(var_219_0.name, "split") then
						var_219_0.gameObject:SetActive(true)
					else
						var_219_0.gameObject:SetActive(false)
					end
				end
			end

			local var_219_1 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_1 then
				arg_216_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_216_1.time_ - 0) / var_219_1)
			end

			if arg_216_1.time_ >= 0 + var_219_1 and arg_216_1.time_ < 0 + var_219_1 + arg_219_0 then
				arg_216_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_219_2 = arg_216_1.actors_["10097"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.actorSpriteComps10097 == nil then
				arg_216_1.var_.actorSpriteComps10097 = var_219_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_3 = 2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_3 and not isNil(var_219_2) then
				if arg_216_1.var_.actorSpriteComps10097 then
					for iter_219_1, iter_219_2 in pairs(arg_216_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_219_2 then
							if arg_216_1.isInRecall_ then
								iter_219_2.color = Color.New(Mathf.Lerp(iter_219_2.color.r, arg_216_1.hightColor1.r, (arg_216_1.time_ - 0) / var_219_3), Mathf.Lerp(iter_219_2.color.g, arg_216_1.hightColor1.g, (arg_216_1.time_ - 0) / var_219_3), (Mathf.Lerp(iter_219_2.color.b, arg_216_1.hightColor1.b, (arg_216_1.time_ - 0) / var_219_3)))
							else
								local var_219_4 = Mathf.Lerp(iter_219_2.color.r, 1, (arg_216_1.time_ - 0) / var_219_3)

								iter_219_2.color = Color.New(var_219_4, var_219_4, var_219_4)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 0 + var_219_3 and arg_216_1.time_ < 0 + var_219_3 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.actorSpriteComps10097 then
				for iter_219_3, iter_219_4 in pairs(arg_216_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_219_4 then
						iter_219_4.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_216_1.var_.actorSpriteComps10097 = nil
			end

			local var_219_5 = arg_216_1.actors_["10022"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_5) and arg_216_1.var_.actorSpriteComps10022 == nil then
				arg_216_1.var_.actorSpriteComps10022 = var_219_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_6 = 2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_6 and not isNil(var_219_5) then
				if arg_216_1.var_.actorSpriteComps10022 then
					for iter_219_5, iter_219_6 in pairs(arg_216_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_219_6 then
							if arg_216_1.isInRecall_ then
								iter_219_6.color = Color.New(Mathf.Lerp(iter_219_6.color.r, arg_216_1.hightColor2.r, (arg_216_1.time_ - 0) / var_219_6), Mathf.Lerp(iter_219_6.color.g, arg_216_1.hightColor2.g, (arg_216_1.time_ - 0) / var_219_6), (Mathf.Lerp(iter_219_6.color.b, arg_216_1.hightColor2.b, (arg_216_1.time_ - 0) / var_219_6)))
							else
								local var_219_7 = Mathf.Lerp(iter_219_6.color.r, 0.5, (arg_216_1.time_ - 0) / var_219_6)

								iter_219_6.color = Color.New(var_219_7, var_219_7, var_219_7)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 0 + var_219_6 and arg_216_1.time_ < 0 + var_219_6 + arg_219_0 and not isNil(var_219_5) and arg_216_1.var_.actorSpriteComps10022 then
				for iter_219_7, iter_219_8 in pairs(arg_216_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_219_8 then
						iter_219_8.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_216_1.var_.actorSpriteComps10022 = nil
			end

			local var_219_8 = 0
			local var_219_9 = 0.625

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_8 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_10 = arg_216_1:GetWordFromCfg(413062052)
				local var_219_11 = arg_216_1:FormatText(var_219_10.content)

				arg_216_1.text_.text = var_219_11

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_13 = 25 <= 0 and var_219_9 or var_219_9 * (utf8.len(var_219_11) / 25)

				if (25 <= 0 and var_219_9 or var_219_9 * (utf8.len(var_219_11) / 25)) > 0 and var_219_9 < var_219_13 then
					arg_216_1.talkMaxDuration = var_219_13

					if var_219_13 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_8
					end
				end

				arg_216_1.text_.text = var_219_11
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062052", "story_v_out_413062.awb") ~= 0 then
					local var_219_14 = manager.audio:GetVoiceLength("story_v_out_413062", "413062052", "story_v_out_413062.awb") / 1000

					if var_219_14 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_8
					end

					if var_219_10.prefab_name ~= "" and arg_216_1.actors_[var_219_10.prefab_name] ~= nil then
						local var_219_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_10.prefab_name].transform, "story_v_out_413062", "413062052", "story_v_out_413062.awb")

						arg_216_1:RecordAudio("413062052", var_219_15)
						arg_216_1:RecordAudio("413062052", var_219_15)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_413062", "413062052", "story_v_out_413062.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_413062", "413062052", "story_v_out_413062.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_16 = math.max(var_219_9, arg_216_1.talkMaxDuration)

			if var_219_8 <= arg_216_1.time_ and arg_216_1.time_ < var_219_8 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_8) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_8 + var_219_16 and arg_216_1.time_ < var_219_8 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play413062053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 413062053
		arg_220_1.duration_ = 5.3

		local var_220_0 = {
			zh = 3.9,
			ja = 5.3
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
				arg_220_0:Play413062054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["10097"]) and arg_220_1.var_.actorSpriteComps10097 == nil then
				arg_220_1.var_.actorSpriteComps10097 = arg_220_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_0 = 2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["10097"]) then
				if arg_220_1.var_.actorSpriteComps10097 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								iter_223_1.color = Color.New(Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor2.r, (arg_220_1.time_ - 0) / var_223_0), Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor2.g, (arg_220_1.time_ - 0) / var_223_0), (Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor2.b, (arg_220_1.time_ - 0) / var_223_0)))
							else
								local var_223_1 = Mathf.Lerp(iter_223_1.color.r, 0.5, (arg_220_1.time_ - 0) / var_223_0)

								iter_223_1.color = Color.New(var_223_1, var_223_1, var_223_1)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["10097"]) and arg_220_1.var_.actorSpriteComps10097 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_223_3 then
						iter_223_3.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_220_1.var_.actorSpriteComps10097 = nil
			end

			local var_223_2 = arg_220_1.actors_["10022"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.actorSpriteComps10022 == nil then
				arg_220_1.var_.actorSpriteComps10022 = var_223_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_3 = 2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_3 and not isNil(var_223_2) then
				if arg_220_1.var_.actorSpriteComps10022 then
					for iter_223_4, iter_223_5 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_223_5 then
							if arg_220_1.isInRecall_ then
								iter_223_5.color = Color.New(Mathf.Lerp(iter_223_5.color.r, arg_220_1.hightColor1.r, (arg_220_1.time_ - 0) / var_223_3), Mathf.Lerp(iter_223_5.color.g, arg_220_1.hightColor1.g, (arg_220_1.time_ - 0) / var_223_3), (Mathf.Lerp(iter_223_5.color.b, arg_220_1.hightColor1.b, (arg_220_1.time_ - 0) / var_223_3)))
							else
								local var_223_4 = Mathf.Lerp(iter_223_5.color.r, 1, (arg_220_1.time_ - 0) / var_223_3)

								iter_223_5.color = Color.New(var_223_4, var_223_4, var_223_4)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_3 and arg_220_1.time_ < 0 + var_223_3 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.actorSpriteComps10022 then
				for iter_223_6, iter_223_7 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_223_7 then
						iter_223_7.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_220_1.var_.actorSpriteComps10022 = nil
			end

			local var_223_5 = 0
			local var_223_6 = 0.625

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_7 = arg_220_1:GetWordFromCfg(413062053)
				local var_223_8 = arg_220_1:FormatText(var_223_7.content)

				arg_220_1.text_.text = var_223_8

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_10 = 25 <= 0 and var_223_6 or var_223_6 * (utf8.len(var_223_8) / 25)

				if (25 <= 0 and var_223_6 or var_223_6 * (utf8.len(var_223_8) / 25)) > 0 and var_223_6 < var_223_10 then
					arg_220_1.talkMaxDuration = var_223_10

					if var_223_10 + var_223_5 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_5
					end
				end

				arg_220_1.text_.text = var_223_8
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062053", "story_v_out_413062.awb") ~= 0 then
					local var_223_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062053", "story_v_out_413062.awb") / 1000

					if var_223_11 + var_223_5 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_11 + var_223_5
					end

					if var_223_7.prefab_name ~= "" and arg_220_1.actors_[var_223_7.prefab_name] ~= nil then
						local var_223_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_7.prefab_name].transform, "story_v_out_413062", "413062053", "story_v_out_413062.awb")

						arg_220_1:RecordAudio("413062053", var_223_12)
						arg_220_1:RecordAudio("413062053", var_223_12)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_413062", "413062053", "story_v_out_413062.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_413062", "413062053", "story_v_out_413062.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_13 = math.max(var_223_6, arg_220_1.talkMaxDuration)

			if var_223_5 <= arg_220_1.time_ and arg_220_1.time_ < var_223_5 + var_223_13 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_5) / var_223_13

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_5 + var_223_13 and arg_220_1.time_ < var_223_5 + var_223_13 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play413062054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 413062054
		arg_224_1.duration_ = 5.73

		local var_224_0 = {
			zh = 5.733,
			ja = 2.3
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
				arg_224_0:Play413062055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos10097 = arg_224_1.actors_["10097"].transform.localPosition
				arg_224_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("10097", 2)

				for iter_227_0 = 0, arg_224_1.actors_["10097"].transform.childCount - 1 do
					local var_227_0 = arg_224_1.actors_["10097"].transform:GetChild(iter_227_0)

					if var_227_0.name == "split_3" or not string.find(var_227_0.name, "split") then
						var_227_0.gameObject:SetActive(true)
					else
						var_227_0.gameObject:SetActive(false)
					end
				end
			end

			local var_227_1 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_1 then
				arg_224_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_224_1.time_ - 0) / var_227_1)
			end

			if arg_224_1.time_ >= 0 + var_227_1 and arg_224_1.time_ < 0 + var_227_1 + arg_227_0 then
				arg_224_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_227_2 = arg_224_1.actors_["10097"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps10097 == nil then
				arg_224_1.var_.actorSpriteComps10097 = var_227_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_3 = 2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 and not isNil(var_227_2) then
				if arg_224_1.var_.actorSpriteComps10097 then
					for iter_227_1, iter_227_2 in pairs(arg_224_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_227_2 then
							if arg_224_1.isInRecall_ then
								iter_227_2.color = Color.New(Mathf.Lerp(iter_227_2.color.r, arg_224_1.hightColor1.r, (arg_224_1.time_ - 0) / var_227_3), Mathf.Lerp(iter_227_2.color.g, arg_224_1.hightColor1.g, (arg_224_1.time_ - 0) / var_227_3), (Mathf.Lerp(iter_227_2.color.b, arg_224_1.hightColor1.b, (arg_224_1.time_ - 0) / var_227_3)))
							else
								local var_227_4 = Mathf.Lerp(iter_227_2.color.r, 1, (arg_224_1.time_ - 0) / var_227_3)

								iter_227_2.color = Color.New(var_227_4, var_227_4, var_227_4)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps10097 then
				for iter_227_3, iter_227_4 in pairs(arg_224_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_227_4 then
						iter_227_4.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_224_1.var_.actorSpriteComps10097 = nil
			end

			local var_227_5 = arg_224_1.actors_["10022"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.actorSpriteComps10022 == nil then
				arg_224_1.var_.actorSpriteComps10022 = var_227_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_6 = 2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_6 and not isNil(var_227_5) then
				if arg_224_1.var_.actorSpriteComps10022 then
					for iter_227_5, iter_227_6 in pairs(arg_224_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_227_6 then
							if arg_224_1.isInRecall_ then
								iter_227_6.color = Color.New(Mathf.Lerp(iter_227_6.color.r, arg_224_1.hightColor2.r, (arg_224_1.time_ - 0) / var_227_6), Mathf.Lerp(iter_227_6.color.g, arg_224_1.hightColor2.g, (arg_224_1.time_ - 0) / var_227_6), (Mathf.Lerp(iter_227_6.color.b, arg_224_1.hightColor2.b, (arg_224_1.time_ - 0) / var_227_6)))
							else
								local var_227_7 = Mathf.Lerp(iter_227_6.color.r, 0.5, (arg_224_1.time_ - 0) / var_227_6)

								iter_227_6.color = Color.New(var_227_7, var_227_7, var_227_7)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_6 and arg_224_1.time_ < 0 + var_227_6 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.actorSpriteComps10022 then
				for iter_227_7, iter_227_8 in pairs(arg_224_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_227_8 then
						iter_227_8.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_224_1.var_.actorSpriteComps10022 = nil
			end

			local var_227_8 = 0
			local var_227_9 = 0.45

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_10 = arg_224_1:GetWordFromCfg(413062054)
				local var_227_11 = arg_224_1:FormatText(var_227_10.content)

				arg_224_1.text_.text = var_227_11

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_13 = 18 <= 0 and var_227_9 or var_227_9 * (utf8.len(var_227_11) / 18)

				if (18 <= 0 and var_227_9 or var_227_9 * (utf8.len(var_227_11) / 18)) > 0 and var_227_9 < var_227_13 then
					arg_224_1.talkMaxDuration = var_227_13

					if var_227_13 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_13 + var_227_8
					end
				end

				arg_224_1.text_.text = var_227_11
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062054", "story_v_out_413062.awb") ~= 0 then
					local var_227_14 = manager.audio:GetVoiceLength("story_v_out_413062", "413062054", "story_v_out_413062.awb") / 1000

					if var_227_14 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_14 + var_227_8
					end

					if var_227_10.prefab_name ~= "" and arg_224_1.actors_[var_227_10.prefab_name] ~= nil then
						local var_227_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_10.prefab_name].transform, "story_v_out_413062", "413062054", "story_v_out_413062.awb")

						arg_224_1:RecordAudio("413062054", var_227_15)
						arg_224_1:RecordAudio("413062054", var_227_15)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_413062", "413062054", "story_v_out_413062.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_413062", "413062054", "story_v_out_413062.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_16 = math.max(var_227_9, arg_224_1.talkMaxDuration)

			if var_227_8 <= arg_224_1.time_ and arg_224_1.time_ < var_227_8 + var_227_16 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_8) / var_227_16

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_8 + var_227_16 and arg_224_1.time_ < var_227_8 + var_227_16 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413062055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 413062055
		arg_228_1.duration_ = 8.17

		local var_228_0 = {
			zh = 6.866,
			ja = 8.166
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
				arg_228_0:Play413062056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.75

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:GetWordFromCfg(413062055)
				local var_231_2 = arg_228_1:FormatText(var_231_1.content)

				arg_228_1.text_.text = var_231_2

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_4 = 30 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 30)

				if (30 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 30)) > 0 and var_231_0 < var_231_4 then
					arg_228_1.talkMaxDuration = var_231_4

					if var_231_4 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_4 + 0
					end
				end

				arg_228_1.text_.text = var_231_2
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062055", "story_v_out_413062.awb") ~= 0 then
					local var_231_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062055", "story_v_out_413062.awb") / 1000

					if var_231_5 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + 0
					end

					if var_231_1.prefab_name ~= "" and arg_228_1.actors_[var_231_1.prefab_name] ~= nil then
						local var_231_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_1.prefab_name].transform, "story_v_out_413062", "413062055", "story_v_out_413062.awb")

						arg_228_1:RecordAudio("413062055", var_231_6)
						arg_228_1:RecordAudio("413062055", var_231_6)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_413062", "413062055", "story_v_out_413062.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_413062", "413062055", "story_v_out_413062.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_7 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_7

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play413062056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 413062056
		arg_232_1.duration_ = 8.63

		local var_232_0 = {
			zh = 6.533,
			ja = 8.633
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
				arg_232_0:Play413062057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10097 = arg_232_1.actors_["10097"].transform.localPosition
				arg_232_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10097", 2)

				for iter_235_0 = 0, arg_232_1.actors_["10097"].transform.childCount - 1 do
					local var_235_0 = arg_232_1.actors_["10097"].transform:GetChild(iter_235_0)

					if var_235_0.name == "" or not string.find(var_235_0.name, "split") then
						var_235_0.gameObject:SetActive(true)
					else
						var_235_0.gameObject:SetActive(false)
					end
				end
			end

			local var_235_1 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_1 then
				arg_232_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_232_1.time_ - 0) / var_235_1)
			end

			if arg_232_1.time_ >= 0 + var_235_1 and arg_232_1.time_ < 0 + var_235_1 + arg_235_0 then
				arg_232_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_235_2 = arg_232_1.actors_["10022"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10022 = var_235_2.localPosition
				var_235_2.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10022", 4)

				for iter_235_1 = 0, var_235_2.childCount - 1 do
					local var_235_3 = var_235_2:GetChild(iter_235_1)

					if var_235_3.name == "split_8" or not string.find(var_235_3.name, "split") then
						var_235_3.gameObject:SetActive(true)
					else
						var_235_3.gameObject:SetActive(false)
					end
				end
			end

			local var_235_4 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				var_235_2.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_232_1.time_ - 0) / var_235_4)
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				var_235_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_235_5 = arg_232_1.actors_["10097"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_5) and arg_232_1.var_.actorSpriteComps10097 == nil then
				arg_232_1.var_.actorSpriteComps10097 = var_235_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_6 = 2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_6 and not isNil(var_235_5) then
				if arg_232_1.var_.actorSpriteComps10097 then
					for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_235_3 then
							if arg_232_1.isInRecall_ then
								iter_235_3.color = Color.New(Mathf.Lerp(iter_235_3.color.r, arg_232_1.hightColor2.r, (arg_232_1.time_ - 0) / var_235_6), Mathf.Lerp(iter_235_3.color.g, arg_232_1.hightColor2.g, (arg_232_1.time_ - 0) / var_235_6), (Mathf.Lerp(iter_235_3.color.b, arg_232_1.hightColor2.b, (arg_232_1.time_ - 0) / var_235_6)))
							else
								local var_235_7 = Mathf.Lerp(iter_235_3.color.r, 0.5, (arg_232_1.time_ - 0) / var_235_6)

								iter_235_3.color = Color.New(var_235_7, var_235_7, var_235_7)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_6 and arg_232_1.time_ < 0 + var_235_6 + arg_235_0 and not isNil(var_235_5) and arg_232_1.var_.actorSpriteComps10097 then
				for iter_235_4, iter_235_5 in pairs(arg_232_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_235_5 then
						iter_235_5.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_232_1.var_.actorSpriteComps10097 = nil
			end

			local var_235_8 = arg_232_1.actors_["10022"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps10022 == nil then
				arg_232_1.var_.actorSpriteComps10022 = var_235_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_9 = 2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_9 and not isNil(var_235_8) then
				if arg_232_1.var_.actorSpriteComps10022 then
					for iter_235_6, iter_235_7 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_235_7 then
							if arg_232_1.isInRecall_ then
								iter_235_7.color = Color.New(Mathf.Lerp(iter_235_7.color.r, arg_232_1.hightColor1.r, (arg_232_1.time_ - 0) / var_235_9), Mathf.Lerp(iter_235_7.color.g, arg_232_1.hightColor1.g, (arg_232_1.time_ - 0) / var_235_9), (Mathf.Lerp(iter_235_7.color.b, arg_232_1.hightColor1.b, (arg_232_1.time_ - 0) / var_235_9)))
							else
								local var_235_10 = Mathf.Lerp(iter_235_7.color.r, 1, (arg_232_1.time_ - 0) / var_235_9)

								iter_235_7.color = Color.New(var_235_10, var_235_10, var_235_10)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_9 and arg_232_1.time_ < 0 + var_235_9 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps10022 then
				for iter_235_8, iter_235_9 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_235_9 then
						iter_235_9.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_232_1.var_.actorSpriteComps10022 = nil
			end

			local var_235_11 = 0
			local var_235_12 = 0.925

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_11 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_13 = arg_232_1:GetWordFromCfg(413062056)
				local var_235_14 = arg_232_1:FormatText(var_235_13.content)

				arg_232_1.text_.text = var_235_14

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_16 = 37 <= 0 and var_235_12 or var_235_12 * (utf8.len(var_235_14) / 37)

				if (37 <= 0 and var_235_12 or var_235_12 * (utf8.len(var_235_14) / 37)) > 0 and var_235_12 < var_235_16 then
					arg_232_1.talkMaxDuration = var_235_16

					if var_235_16 + var_235_11 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_16 + var_235_11
					end
				end

				arg_232_1.text_.text = var_235_14
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062056", "story_v_out_413062.awb") ~= 0 then
					local var_235_17 = manager.audio:GetVoiceLength("story_v_out_413062", "413062056", "story_v_out_413062.awb") / 1000

					if var_235_17 + var_235_11 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_17 + var_235_11
					end

					if var_235_13.prefab_name ~= "" and arg_232_1.actors_[var_235_13.prefab_name] ~= nil then
						local var_235_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_13.prefab_name].transform, "story_v_out_413062", "413062056", "story_v_out_413062.awb")

						arg_232_1:RecordAudio("413062056", var_235_18)
						arg_232_1:RecordAudio("413062056", var_235_18)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_413062", "413062056", "story_v_out_413062.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_413062", "413062056", "story_v_out_413062.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_19 = math.max(var_235_12, arg_232_1.talkMaxDuration)

			if var_235_11 <= arg_232_1.time_ and arg_232_1.time_ < var_235_11 + var_235_19 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_11) / var_235_19

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_11 + var_235_19 and arg_232_1.time_ < var_235_11 + var_235_19 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_232_1:InitPlayNodeList()
	end,
	Play413062057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 413062057
		arg_236_1.duration_ = 4.93

		local var_236_0 = {
			zh = 2.666,
			ja = 4.933
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
				arg_236_0:Play413062058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10022 = arg_236_1.actors_["10022"].transform.localPosition
				arg_236_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("10022", 4)

				for iter_239_0 = 0, arg_236_1.actors_["10022"].transform.childCount - 1 do
					local var_239_0 = arg_236_1.actors_["10022"].transform:GetChild(iter_239_0)

					if var_239_0.name == "split_3" or not string.find(var_239_0.name, "split") then
						var_239_0.gameObject:SetActive(true)
					else
						var_239_0.gameObject:SetActive(false)
					end
				end
			end

			local var_239_1 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 then
				arg_236_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_236_1.time_ - 0) / var_239_1)
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 then
				arg_236_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_239_2 = 0
			local var_239_3 = 0.375

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_2 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_4 = arg_236_1:GetWordFromCfg(413062057)
				local var_239_5 = arg_236_1:FormatText(var_239_4.content)

				arg_236_1.text_.text = var_239_5

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_7 = 15 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_5) / 15)

				if (15 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_5) / 15)) > 0 and var_239_3 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_2
					end
				end

				arg_236_1.text_.text = var_239_5
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062057", "story_v_out_413062.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_413062", "413062057", "story_v_out_413062.awb") / 1000

					if var_239_8 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_2
					end

					if var_239_4.prefab_name ~= "" and arg_236_1.actors_[var_239_4.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_4.prefab_name].transform, "story_v_out_413062", "413062057", "story_v_out_413062.awb")

						arg_236_1:RecordAudio("413062057", var_239_9)
						arg_236_1:RecordAudio("413062057", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_413062", "413062057", "story_v_out_413062.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_413062", "413062057", "story_v_out_413062.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_3, arg_236_1.talkMaxDuration)

			if var_239_2 <= arg_236_1.time_ and arg_236_1.time_ < var_239_2 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_2) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_2 + var_239_10 and arg_236_1.time_ < var_239_2 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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

		arg_236_1:InitPlayNodeList()
	end,
	Play413062058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 413062058
		arg_240_1.duration_ = 11.87

		local var_240_0 = {
			zh = 9.9,
			ja = 11.866
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
				arg_240_0:Play413062059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10097 = arg_240_1.actors_["10097"].transform.localPosition
				arg_240_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10097", 2)

				for iter_243_0 = 0, arg_240_1.actors_["10097"].transform.childCount - 1 do
					local var_243_0 = arg_240_1.actors_["10097"].transform:GetChild(iter_243_0)

					if var_243_0.name == "split_4" or not string.find(var_243_0.name, "split") then
						var_243_0.gameObject:SetActive(true)
					else
						var_243_0.gameObject:SetActive(false)
					end
				end
			end

			local var_243_1 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_1 then
				arg_240_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_240_1.time_ - 0) / var_243_1)
			end

			if arg_240_1.time_ >= 0 + var_243_1 and arg_240_1.time_ < 0 + var_243_1 + arg_243_0 then
				arg_240_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_243_2 = arg_240_1.actors_["10097"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.actorSpriteComps10097 == nil then
				arg_240_1.var_.actorSpriteComps10097 = var_243_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_3 = 2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_3 and not isNil(var_243_2) then
				if arg_240_1.var_.actorSpriteComps10097 then
					for iter_243_1, iter_243_2 in pairs(arg_240_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_243_2 then
							if arg_240_1.isInRecall_ then
								iter_243_2.color = Color.New(Mathf.Lerp(iter_243_2.color.r, arg_240_1.hightColor1.r, (arg_240_1.time_ - 0) / var_243_3), Mathf.Lerp(iter_243_2.color.g, arg_240_1.hightColor1.g, (arg_240_1.time_ - 0) / var_243_3), (Mathf.Lerp(iter_243_2.color.b, arg_240_1.hightColor1.b, (arg_240_1.time_ - 0) / var_243_3)))
							else
								local var_243_4 = Mathf.Lerp(iter_243_2.color.r, 1, (arg_240_1.time_ - 0) / var_243_3)

								iter_243_2.color = Color.New(var_243_4, var_243_4, var_243_4)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= 0 + var_243_3 and arg_240_1.time_ < 0 + var_243_3 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.actorSpriteComps10097 then
				for iter_243_3, iter_243_4 in pairs(arg_240_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_243_4 then
						iter_243_4.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_240_1.var_.actorSpriteComps10097 = nil
			end

			local var_243_5 = arg_240_1.actors_["10022"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_5) and arg_240_1.var_.actorSpriteComps10022 == nil then
				arg_240_1.var_.actorSpriteComps10022 = var_243_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_6 = 2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_6 and not isNil(var_243_5) then
				if arg_240_1.var_.actorSpriteComps10022 then
					for iter_243_5, iter_243_6 in pairs(arg_240_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_243_6 then
							if arg_240_1.isInRecall_ then
								iter_243_6.color = Color.New(Mathf.Lerp(iter_243_6.color.r, arg_240_1.hightColor2.r, (arg_240_1.time_ - 0) / var_243_6), Mathf.Lerp(iter_243_6.color.g, arg_240_1.hightColor2.g, (arg_240_1.time_ - 0) / var_243_6), (Mathf.Lerp(iter_243_6.color.b, arg_240_1.hightColor2.b, (arg_240_1.time_ - 0) / var_243_6)))
							else
								local var_243_7 = Mathf.Lerp(iter_243_6.color.r, 0.5, (arg_240_1.time_ - 0) / var_243_6)

								iter_243_6.color = Color.New(var_243_7, var_243_7, var_243_7)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= 0 + var_243_6 and arg_240_1.time_ < 0 + var_243_6 + arg_243_0 and not isNil(var_243_5) and arg_240_1.var_.actorSpriteComps10022 then
				for iter_243_7, iter_243_8 in pairs(arg_240_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_243_8 then
						iter_243_8.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_240_1.var_.actorSpriteComps10022 = nil
			end

			if 0.566666666666667 < arg_240_1.time_ and arg_240_1.time_ <= 0.566666666666667 + arg_243_0 then
				arg_240_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_watch", "")
			end

			local var_243_9 = 0
			local var_243_10 = 0.925

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_9 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_11 = arg_240_1:GetWordFromCfg(413062058)
				local var_243_12 = arg_240_1:FormatText(var_243_11.content)

				arg_240_1.text_.text = var_243_12

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_14 = 37 <= 0 and var_243_10 or var_243_10 * (utf8.len(var_243_12) / 37)

				if (37 <= 0 and var_243_10 or var_243_10 * (utf8.len(var_243_12) / 37)) > 0 and var_243_10 < var_243_14 then
					arg_240_1.talkMaxDuration = var_243_14

					if var_243_14 + var_243_9 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_14 + var_243_9
					end
				end

				arg_240_1.text_.text = var_243_12
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062058", "story_v_out_413062.awb") ~= 0 then
					local var_243_15 = manager.audio:GetVoiceLength("story_v_out_413062", "413062058", "story_v_out_413062.awb") / 1000

					if var_243_15 + var_243_9 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_15 + var_243_9
					end

					if var_243_11.prefab_name ~= "" and arg_240_1.actors_[var_243_11.prefab_name] ~= nil then
						local var_243_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_11.prefab_name].transform, "story_v_out_413062", "413062058", "story_v_out_413062.awb")

						arg_240_1:RecordAudio("413062058", var_243_16)
						arg_240_1:RecordAudio("413062058", var_243_16)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_413062", "413062058", "story_v_out_413062.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_413062", "413062058", "story_v_out_413062.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_17 = math.max(var_243_10, arg_240_1.talkMaxDuration)

			if var_243_9 <= arg_240_1.time_ and arg_240_1.time_ < var_243_9 + var_243_17 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_9) / var_243_17

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_9 + var_243_17 and arg_240_1.time_ < var_243_9 + var_243_17 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413062059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 413062059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play413062060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos10097 = arg_244_1.actors_["10097"].transform.localPosition
				arg_244_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("10097", 2)

				for iter_247_0 = 0, arg_244_1.actors_["10097"].transform.childCount - 1 do
					local var_247_0 = arg_244_1.actors_["10097"].transform:GetChild(iter_247_0)

					if var_247_0.name == "" or not string.find(var_247_0.name, "split") then
						var_247_0.gameObject:SetActive(true)
					else
						var_247_0.gameObject:SetActive(false)
					end
				end
			end

			local var_247_1 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_1 then
				arg_244_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_244_1.time_ - 0) / var_247_1)
			end

			if arg_244_1.time_ >= 0 + var_247_1 and arg_244_1.time_ < 0 + var_247_1 + arg_247_0 then
				arg_244_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_247_2 = arg_244_1.actors_["10097"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps10097 == nil then
				arg_244_1.var_.actorSpriteComps10097 = var_247_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_3 = 2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_3 and not isNil(var_247_2) then
				if arg_244_1.var_.actorSpriteComps10097 then
					for iter_247_1, iter_247_2 in pairs(arg_244_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_247_2 then
							if arg_244_1.isInRecall_ then
								iter_247_2.color = Color.New(Mathf.Lerp(iter_247_2.color.r, arg_244_1.hightColor2.r, (arg_244_1.time_ - 0) / var_247_3), Mathf.Lerp(iter_247_2.color.g, arg_244_1.hightColor2.g, (arg_244_1.time_ - 0) / var_247_3), (Mathf.Lerp(iter_247_2.color.b, arg_244_1.hightColor2.b, (arg_244_1.time_ - 0) / var_247_3)))
							else
								local var_247_4 = Mathf.Lerp(iter_247_2.color.r, 0.5, (arg_244_1.time_ - 0) / var_247_3)

								iter_247_2.color = Color.New(var_247_4, var_247_4, var_247_4)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_3 and arg_244_1.time_ < 0 + var_247_3 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps10097 then
				for iter_247_3, iter_247_4 in pairs(arg_244_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_247_4 then
						iter_247_4.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_244_1.var_.actorSpriteComps10097 = nil
			end

			local var_247_5 = 0
			local var_247_6 = 0.975

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_7 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(413062059).content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 39 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_7) / 39)

				if (39 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_7) / 39)) > 0 and var_247_6 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_5
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_6, arg_244_1.talkMaxDuration)

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_5) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_5 + var_247_10 and arg_244_1.time_ < var_247_5 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play413062060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 413062060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play413062061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.775

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(413062060).content)

				arg_248_1.text_.text = var_251_1

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_3 = 31 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 31)

				if (31 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 31)) > 0 and var_251_0 < var_251_3 then
					arg_248_1.talkMaxDuration = var_251_3

					if var_251_3 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_3 + 0
					end
				end

				arg_248_1.text_.text = var_251_1
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_4 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_4

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play413062061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 413062061
		arg_252_1.duration_ = 3.37

		local var_252_0 = {
			zh = 2.4,
			ja = 3.366
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
				arg_252_0:Play413062062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10022 = arg_252_1.actors_["10022"].transform.localPosition
				arg_252_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("10022", 4)

				for iter_255_0 = 0, arg_252_1.actors_["10022"].transform.childCount - 1 do
					local var_255_0 = arg_252_1.actors_["10022"].transform:GetChild(iter_255_0)

					if var_255_0.name == "split_3" or not string.find(var_255_0.name, "split") then
						var_255_0.gameObject:SetActive(true)
					else
						var_255_0.gameObject:SetActive(false)
					end
				end
			end

			local var_255_1 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_1 then
				arg_252_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_252_1.time_ - 0) / var_255_1)
			end

			if arg_252_1.time_ >= 0 + var_255_1 and arg_252_1.time_ < 0 + var_255_1 + arg_255_0 then
				arg_252_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_255_2 = arg_252_1.actors_["10022"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps10022 == nil then
				arg_252_1.var_.actorSpriteComps10022 = var_255_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_3 = 2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_3 and not isNil(var_255_2) then
				if arg_252_1.var_.actorSpriteComps10022 then
					for iter_255_1, iter_255_2 in pairs(arg_252_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_255_2 then
							if arg_252_1.isInRecall_ then
								iter_255_2.color = Color.New(Mathf.Lerp(iter_255_2.color.r, arg_252_1.hightColor1.r, (arg_252_1.time_ - 0) / var_255_3), Mathf.Lerp(iter_255_2.color.g, arg_252_1.hightColor1.g, (arg_252_1.time_ - 0) / var_255_3), (Mathf.Lerp(iter_255_2.color.b, arg_252_1.hightColor1.b, (arg_252_1.time_ - 0) / var_255_3)))
							else
								local var_255_4 = Mathf.Lerp(iter_255_2.color.r, 1, (arg_252_1.time_ - 0) / var_255_3)

								iter_255_2.color = Color.New(var_255_4, var_255_4, var_255_4)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_3 and arg_252_1.time_ < 0 + var_255_3 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps10022 then
				for iter_255_3, iter_255_4 in pairs(arg_252_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_255_4 then
						iter_255_4.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_252_1.var_.actorSpriteComps10022 = nil
			end

			local var_255_5 = 0
			local var_255_6 = 0.375

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_7 = arg_252_1:GetWordFromCfg(413062061)
				local var_255_8 = arg_252_1:FormatText(var_255_7.content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_10 = 15 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 15)

				if (15 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 15)) > 0 and var_255_6 < var_255_10 then
					arg_252_1.talkMaxDuration = var_255_10

					if var_255_10 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_5
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062061", "story_v_out_413062.awb") ~= 0 then
					local var_255_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062061", "story_v_out_413062.awb") / 1000

					if var_255_11 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_5
					end

					if var_255_7.prefab_name ~= "" and arg_252_1.actors_[var_255_7.prefab_name] ~= nil then
						local var_255_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_7.prefab_name].transform, "story_v_out_413062", "413062061", "story_v_out_413062.awb")

						arg_252_1:RecordAudio("413062061", var_255_12)
						arg_252_1:RecordAudio("413062061", var_255_12)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_413062", "413062061", "story_v_out_413062.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_413062", "413062061", "story_v_out_413062.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_13 = math.max(var_255_6, arg_252_1.talkMaxDuration)

			if var_255_5 <= arg_252_1.time_ and arg_252_1.time_ < var_255_5 + var_255_13 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_5) / var_255_13

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_5 + var_255_13 and arg_252_1.time_ < var_255_5 + var_255_13 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
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

		arg_252_1:InitPlayNodeList()
	end,
	Play413062062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 413062062
		arg_256_1.duration_ = 2

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play413062063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["10097"]) and arg_256_1.var_.actorSpriteComps10097 == nil then
				arg_256_1.var_.actorSpriteComps10097 = arg_256_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_0 = 2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["10097"]) then
				if arg_256_1.var_.actorSpriteComps10097 then
					for iter_259_0, iter_259_1 in pairs(arg_256_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_259_1 then
							if arg_256_1.isInRecall_ then
								iter_259_1.color = Color.New(Mathf.Lerp(iter_259_1.color.r, arg_256_1.hightColor1.r, (arg_256_1.time_ - 0) / var_259_0), Mathf.Lerp(iter_259_1.color.g, arg_256_1.hightColor1.g, (arg_256_1.time_ - 0) / var_259_0), (Mathf.Lerp(iter_259_1.color.b, arg_256_1.hightColor1.b, (arg_256_1.time_ - 0) / var_259_0)))
							else
								local var_259_1 = Mathf.Lerp(iter_259_1.color.r, 1, (arg_256_1.time_ - 0) / var_259_0)

								iter_259_1.color = Color.New(var_259_1, var_259_1, var_259_1)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["10097"]) and arg_256_1.var_.actorSpriteComps10097 then
				for iter_259_2, iter_259_3 in pairs(arg_256_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_259_3 then
						iter_259_3.color = arg_256_1.isInRecall_ and (arg_256_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_256_1.var_.actorSpriteComps10097 = nil
			end

			local var_259_2 = arg_256_1.actors_["10022"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.actorSpriteComps10022 == nil then
				arg_256_1.var_.actorSpriteComps10022 = var_259_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_3 = 2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_3 and not isNil(var_259_2) then
				if arg_256_1.var_.actorSpriteComps10022 then
					for iter_259_4, iter_259_5 in pairs(arg_256_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_259_5 then
							if arg_256_1.isInRecall_ then
								iter_259_5.color = Color.New(Mathf.Lerp(iter_259_5.color.r, arg_256_1.hightColor2.r, (arg_256_1.time_ - 0) / var_259_3), Mathf.Lerp(iter_259_5.color.g, arg_256_1.hightColor2.g, (arg_256_1.time_ - 0) / var_259_3), (Mathf.Lerp(iter_259_5.color.b, arg_256_1.hightColor2.b, (arg_256_1.time_ - 0) / var_259_3)))
							else
								local var_259_4 = Mathf.Lerp(iter_259_5.color.r, 0.5, (arg_256_1.time_ - 0) / var_259_3)

								iter_259_5.color = Color.New(var_259_4, var_259_4, var_259_4)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= 0 + var_259_3 and arg_256_1.time_ < 0 + var_259_3 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.actorSpriteComps10022 then
				for iter_259_6, iter_259_7 in pairs(arg_256_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_259_7 then
						iter_259_7.color = arg_256_1.isInRecall_ and (arg_256_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_256_1.var_.actorSpriteComps10022 = nil
			end

			local var_259_5 = 0
			local var_259_6 = 0.125

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_7 = arg_256_1:GetWordFromCfg(413062062)
				local var_259_8 = arg_256_1:FormatText(var_259_7.content)

				arg_256_1.text_.text = var_259_8

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_10 = 5 <= 0 and var_259_6 or var_259_6 * (utf8.len(var_259_8) / 5)

				if (5 <= 0 and var_259_6 or var_259_6 * (utf8.len(var_259_8) / 5)) > 0 and var_259_6 < var_259_10 then
					arg_256_1.talkMaxDuration = var_259_10

					if var_259_10 + var_259_5 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_5
					end
				end

				arg_256_1.text_.text = var_259_8
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062062", "story_v_out_413062.awb") ~= 0 then
					local var_259_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062062", "story_v_out_413062.awb") / 1000

					if var_259_11 + var_259_5 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_11 + var_259_5
					end

					if var_259_7.prefab_name ~= "" and arg_256_1.actors_[var_259_7.prefab_name] ~= nil then
						local var_259_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_7.prefab_name].transform, "story_v_out_413062", "413062062", "story_v_out_413062.awb")

						arg_256_1:RecordAudio("413062062", var_259_12)
						arg_256_1:RecordAudio("413062062", var_259_12)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_413062", "413062062", "story_v_out_413062.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_413062", "413062062", "story_v_out_413062.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_13 = math.max(var_259_6, arg_256_1.talkMaxDuration)

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_13 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_5) / var_259_13

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_5 + var_259_13 and arg_256_1.time_ < var_259_5 + var_259_13 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play413062063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 413062063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play413062064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10097 = arg_260_1.actors_["10097"].transform.localPosition
				arg_260_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("10097", 2)

				for iter_263_0 = 0, arg_260_1.actors_["10097"].transform.childCount - 1 do
					local var_263_0 = arg_260_1.actors_["10097"].transform:GetChild(iter_263_0)

					if var_263_0.name == "" or not string.find(var_263_0.name, "split") then
						var_263_0.gameObject:SetActive(true)
					else
						var_263_0.gameObject:SetActive(false)
					end
				end
			end

			local var_263_1 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_1 then
				arg_260_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_260_1.time_ - 0) / var_263_1)
			end

			if arg_260_1.time_ >= 0 + var_263_1 and arg_260_1.time_ < 0 + var_263_1 + arg_263_0 then
				arg_260_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_263_2 = arg_260_1.actors_["10097"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_2) and arg_260_1.var_.actorSpriteComps10097 == nil then
				arg_260_1.var_.actorSpriteComps10097 = var_263_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_3 = 2

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_3 and not isNil(var_263_2) then
				if arg_260_1.var_.actorSpriteComps10097 then
					for iter_263_1, iter_263_2 in pairs(arg_260_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_263_2 then
							if arg_260_1.isInRecall_ then
								iter_263_2.color = Color.New(Mathf.Lerp(iter_263_2.color.r, arg_260_1.hightColor2.r, (arg_260_1.time_ - 0) / var_263_3), Mathf.Lerp(iter_263_2.color.g, arg_260_1.hightColor2.g, (arg_260_1.time_ - 0) / var_263_3), (Mathf.Lerp(iter_263_2.color.b, arg_260_1.hightColor2.b, (arg_260_1.time_ - 0) / var_263_3)))
							else
								local var_263_4 = Mathf.Lerp(iter_263_2.color.r, 0.5, (arg_260_1.time_ - 0) / var_263_3)

								iter_263_2.color = Color.New(var_263_4, var_263_4, var_263_4)
							end
						end
					end
				end
			end

			if arg_260_1.time_ >= 0 + var_263_3 and arg_260_1.time_ < 0 + var_263_3 + arg_263_0 and not isNil(var_263_2) and arg_260_1.var_.actorSpriteComps10097 then
				for iter_263_3, iter_263_4 in pairs(arg_260_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_263_4 then
						iter_263_4.color = arg_260_1.isInRecall_ and (arg_260_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_260_1.var_.actorSpriteComps10097 = nil
			end

			local var_263_5 = 0
			local var_263_6 = 0.9

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_7 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(413062063).content)

				arg_260_1.text_.text = var_263_7

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_9 = 36 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_7) / 36)

				if (36 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_7) / 36)) > 0 and var_263_6 < var_263_9 then
					arg_260_1.talkMaxDuration = var_263_9

					if var_263_9 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_9 + var_263_5
					end
				end

				arg_260_1.text_.text = var_263_7
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_6, arg_260_1.talkMaxDuration)

			if var_263_5 <= arg_260_1.time_ and arg_260_1.time_ < var_263_5 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_5) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_5 + var_263_10 and arg_260_1.time_ < var_263_5 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play413062064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 413062064
		arg_264_1.duration_ = 14

		local var_264_0 = {
			zh = 10.433,
			ja = 14
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play413062065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos10097 = arg_264_1.actors_["10097"].transform.localPosition
				arg_264_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("10097", 2)

				for iter_267_0 = 0, arg_264_1.actors_["10097"].transform.childCount - 1 do
					local var_267_0 = arg_264_1.actors_["10097"].transform:GetChild(iter_267_0)

					if var_267_0.name == "split_3" or not string.find(var_267_0.name, "split") then
						var_267_0.gameObject:SetActive(true)
					else
						var_267_0.gameObject:SetActive(false)
					end
				end
			end

			local var_267_1 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_1 then
				arg_264_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_264_1.time_ - 0) / var_267_1)
			end

			if arg_264_1.time_ >= 0 + var_267_1 and arg_264_1.time_ < 0 + var_267_1 + arg_267_0 then
				arg_264_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_267_2 = arg_264_1.actors_["10097"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.actorSpriteComps10097 == nil then
				arg_264_1.var_.actorSpriteComps10097 = var_267_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_3 = 2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_3 and not isNil(var_267_2) then
				if arg_264_1.var_.actorSpriteComps10097 then
					for iter_267_1, iter_267_2 in pairs(arg_264_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_267_2 then
							if arg_264_1.isInRecall_ then
								iter_267_2.color = Color.New(Mathf.Lerp(iter_267_2.color.r, arg_264_1.hightColor1.r, (arg_264_1.time_ - 0) / var_267_3), Mathf.Lerp(iter_267_2.color.g, arg_264_1.hightColor1.g, (arg_264_1.time_ - 0) / var_267_3), (Mathf.Lerp(iter_267_2.color.b, arg_264_1.hightColor1.b, (arg_264_1.time_ - 0) / var_267_3)))
							else
								local var_267_4 = Mathf.Lerp(iter_267_2.color.r, 1, (arg_264_1.time_ - 0) / var_267_3)

								iter_267_2.color = Color.New(var_267_4, var_267_4, var_267_4)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= 0 + var_267_3 and arg_264_1.time_ < 0 + var_267_3 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.actorSpriteComps10097 then
				for iter_267_3, iter_267_4 in pairs(arg_264_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_267_4 then
						iter_267_4.color = arg_264_1.isInRecall_ and (arg_264_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_264_1.var_.actorSpriteComps10097 = nil
			end

			local var_267_5 = 0
			local var_267_6 = 0.875

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_5 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_7 = arg_264_1:GetWordFromCfg(413062064)
				local var_267_8 = arg_264_1:FormatText(var_267_7.content)

				arg_264_1.text_.text = var_267_8

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_10 = 35 <= 0 and var_267_6 or var_267_6 * (utf8.len(var_267_8) / 35)

				if (35 <= 0 and var_267_6 or var_267_6 * (utf8.len(var_267_8) / 35)) > 0 and var_267_6 < var_267_10 then
					arg_264_1.talkMaxDuration = var_267_10

					if var_267_10 + var_267_5 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_5
					end
				end

				arg_264_1.text_.text = var_267_8
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062064", "story_v_out_413062.awb") ~= 0 then
					local var_267_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062064", "story_v_out_413062.awb") / 1000

					if var_267_11 + var_267_5 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_11 + var_267_5
					end

					if var_267_7.prefab_name ~= "" and arg_264_1.actors_[var_267_7.prefab_name] ~= nil then
						local var_267_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_7.prefab_name].transform, "story_v_out_413062", "413062064", "story_v_out_413062.awb")

						arg_264_1:RecordAudio("413062064", var_267_12)
						arg_264_1:RecordAudio("413062064", var_267_12)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_413062", "413062064", "story_v_out_413062.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_413062", "413062064", "story_v_out_413062.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_13 = math.max(var_267_6, arg_264_1.talkMaxDuration)

			if var_267_5 <= arg_264_1.time_ and arg_264_1.time_ < var_267_5 + var_267_13 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_5) / var_267_13

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_5 + var_267_13 and arg_264_1.time_ < var_267_5 + var_267_13 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play413062065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 413062065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play413062066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos10097 = arg_268_1.actors_["10097"].transform.localPosition
				arg_268_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10097", 7)

				for iter_271_0 = 0, arg_268_1.actors_["10097"].transform.childCount - 1 do
					local var_271_0 = arg_268_1.actors_["10097"].transform:GetChild(iter_271_0)

					if var_271_0.name == "" or not string.find(var_271_0.name, "split") then
						var_271_0.gameObject:SetActive(true)
					else
						var_271_0.gameObject:SetActive(false)
					end
				end
			end

			local var_271_1 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_1 then
				arg_268_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_268_1.time_ - 0) / var_271_1)
			end

			if arg_268_1.time_ >= 0 + var_271_1 and arg_268_1.time_ < 0 + var_271_1 + arg_271_0 then
				arg_268_1.actors_["10097"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_271_2 = arg_268_1.actors_["10022"].transform

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos10022 = var_271_2.localPosition
				var_271_2.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10022", 7)

				for iter_271_1 = 0, var_271_2.childCount - 1 do
					local var_271_3 = var_271_2:GetChild(iter_271_1)

					if var_271_3.name == "split_8" or not string.find(var_271_3.name, "split") then
						var_271_3.gameObject:SetActive(true)
					else
						var_271_3.gameObject:SetActive(false)
					end
				end
			end

			local var_271_4 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				var_271_2.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_268_1.time_ - 0) / var_271_4)
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				var_271_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				local var_271_5 = arg_268_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_271_5 then
					arg_268_1.var_.alphaOldValue10022 = var_271_5.alpha
					arg_268_1.var_.characterEffect10022 = var_271_5
				end

				arg_268_1.var_.alphaOldValue10022 = 0
			end

			local var_271_6 = 0.5

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_6 then
				if arg_268_1.var_.characterEffect10022 then
					arg_268_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_268_1.var_.alphaOldValue10022, 1, (arg_268_1.time_ - 0) / var_271_6)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_6 and arg_268_1.time_ < 0 + var_271_6 + arg_271_0 and arg_268_1.var_.characterEffect10022 then
				arg_268_1.var_.characterEffect10022.alpha = 1
			end

			local var_271_7 = 0
			local var_271_8 = 0.925

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_7 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_9 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(413062065).content)

				arg_268_1.text_.text = var_271_9

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_11 = 37 <= 0 and var_271_8 or var_271_8 * (utf8.len(var_271_9) / 37)

				if (37 <= 0 and var_271_8 or var_271_8 * (utf8.len(var_271_9) / 37)) > 0 and var_271_8 < var_271_11 then
					arg_268_1.talkMaxDuration = var_271_11

					if var_271_11 + var_271_7 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_11 + var_271_7
					end
				end

				arg_268_1.text_.text = var_271_9
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_12 = math.max(var_271_8, arg_268_1.talkMaxDuration)

			if var_271_7 <= arg_268_1.time_ and arg_268_1.time_ < var_271_7 + var_271_12 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_7) / var_271_12

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_7 + var_271_12 and arg_268_1.time_ < var_271_7 + var_271_12 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play413062066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 413062066
		arg_272_1.duration_ = 5.7

		local var_272_0 = {
			zh = 5.066,
			ja = 5.7
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play413062067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["10022"]) and arg_272_1.var_.actorSpriteComps10022 == nil then
				arg_272_1.var_.actorSpriteComps10022 = arg_272_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_0 = 2

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["10022"]) then
				if arg_272_1.var_.actorSpriteComps10022 then
					for iter_275_0, iter_275_1 in pairs(arg_272_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_275_1 then
							if arg_272_1.isInRecall_ then
								iter_275_1.color = Color.New(Mathf.Lerp(iter_275_1.color.r, arg_272_1.hightColor1.r, (arg_272_1.time_ - 0) / var_275_0), Mathf.Lerp(iter_275_1.color.g, arg_272_1.hightColor1.g, (arg_272_1.time_ - 0) / var_275_0), (Mathf.Lerp(iter_275_1.color.b, arg_272_1.hightColor1.b, (arg_272_1.time_ - 0) / var_275_0)))
							else
								local var_275_1 = Mathf.Lerp(iter_275_1.color.r, 1, (arg_272_1.time_ - 0) / var_275_0)

								iter_275_1.color = Color.New(var_275_1, var_275_1, var_275_1)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["10022"]) and arg_272_1.var_.actorSpriteComps10022 then
				for iter_275_2, iter_275_3 in pairs(arg_272_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_275_3 then
						iter_275_3.color = arg_272_1.isInRecall_ and (arg_272_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_272_1.var_.actorSpriteComps10022 = nil
			end

			local var_275_2 = arg_272_1.actors_["10022"].transform

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos10022 = var_275_2.localPosition
				var_275_2.localScale = Vector3.New(1, 1, 1)

				arg_272_1:CheckSpriteTmpPos("10022", 3)

				for iter_275_4 = 0, var_275_2.childCount - 1 do
					local var_275_3 = var_275_2:GetChild(iter_275_4)

					if var_275_3.name == "split_8" or not string.find(var_275_3.name, "split") then
						var_275_3.gameObject:SetActive(true)
					else
						var_275_3.gameObject:SetActive(false)
					end
				end
			end

			local var_275_4 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				var_275_2.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_272_1.time_ - 0) / var_275_4)
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				var_275_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_275_5 = 0
			local var_275_6 = 0.6

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_5 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_7 = arg_272_1:GetWordFromCfg(413062066)
				local var_275_8 = arg_272_1:FormatText(var_275_7.content)

				arg_272_1.text_.text = var_275_8

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_10 = 24 <= 0 and var_275_6 or var_275_6 * (utf8.len(var_275_8) / 24)

				if (24 <= 0 and var_275_6 or var_275_6 * (utf8.len(var_275_8) / 24)) > 0 and var_275_6 < var_275_10 then
					arg_272_1.talkMaxDuration = var_275_10

					if var_275_10 + var_275_5 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_5
					end
				end

				arg_272_1.text_.text = var_275_8
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062066", "story_v_out_413062.awb") ~= 0 then
					local var_275_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062066", "story_v_out_413062.awb") / 1000

					if var_275_11 + var_275_5 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_11 + var_275_5
					end

					if var_275_7.prefab_name ~= "" and arg_272_1.actors_[var_275_7.prefab_name] ~= nil then
						local var_275_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_7.prefab_name].transform, "story_v_out_413062", "413062066", "story_v_out_413062.awb")

						arg_272_1:RecordAudio("413062066", var_275_12)
						arg_272_1:RecordAudio("413062066", var_275_12)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_413062", "413062066", "story_v_out_413062.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_413062", "413062066", "story_v_out_413062.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_13 = math.max(var_275_6, arg_272_1.talkMaxDuration)

			if var_275_5 <= arg_272_1.time_ and arg_272_1.time_ < var_275_5 + var_275_13 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_5) / var_275_13

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_5 + var_275_13 and arg_272_1.time_ < var_275_5 + var_275_13 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play413062067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 413062067
		arg_276_1.duration_ = 5.67

		local var_276_0 = {
			zh = 5.666,
			ja = 4
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play413062068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.85

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_1 = arg_276_1:GetWordFromCfg(413062067)
				local var_279_2 = arg_276_1:FormatText(var_279_1.content)

				arg_276_1.text_.text = var_279_2

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_4 = 34 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 34)

				if (34 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 34)) > 0 and var_279_0 < var_279_4 then
					arg_276_1.talkMaxDuration = var_279_4

					if var_279_4 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_4 + 0
					end
				end

				arg_276_1.text_.text = var_279_2
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062067", "story_v_out_413062.awb") ~= 0 then
					local var_279_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062067", "story_v_out_413062.awb") / 1000

					if var_279_5 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + 0
					end

					if var_279_1.prefab_name ~= "" and arg_276_1.actors_[var_279_1.prefab_name] ~= nil then
						local var_279_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_1.prefab_name].transform, "story_v_out_413062", "413062067", "story_v_out_413062.awb")

						arg_276_1:RecordAudio("413062067", var_279_6)
						arg_276_1:RecordAudio("413062067", var_279_6)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_413062", "413062067", "story_v_out_413062.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_413062", "413062067", "story_v_out_413062.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_7 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_7 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_7

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_7 and arg_276_1.time_ < 0 + var_279_7 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play413062068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 413062068
		arg_280_1.duration_ = 9.17

		local var_280_0 = {
			zh = 9.166,
			ja = 7.433
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
				arg_280_0:Play413062069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10022 = arg_280_1.actors_["10022"].transform.localPosition
				arg_280_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("10022", 3)

				for iter_283_0 = 0, arg_280_1.actors_["10022"].transform.childCount - 1 do
					local var_283_0 = arg_280_1.actors_["10022"].transform:GetChild(iter_283_0)

					if var_283_0.name == "split_6" or not string.find(var_283_0.name, "split") then
						var_283_0.gameObject:SetActive(true)
					else
						var_283_0.gameObject:SetActive(false)
					end
				end
			end

			local var_283_1 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_1 then
				arg_280_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_280_1.time_ - 0) / var_283_1)
			end

			if arg_280_1.time_ >= 0 + var_283_1 and arg_280_1.time_ < 0 + var_283_1 + arg_283_0 then
				arg_280_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_283_2 = 0
			local var_283_3 = 0.85

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_2 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_4 = arg_280_1:GetWordFromCfg(413062068)
				local var_283_5 = arg_280_1:FormatText(var_283_4.content)

				arg_280_1.text_.text = var_283_5

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_7 = 34 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 34)

				if (34 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 34)) > 0 and var_283_3 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_2
					end
				end

				arg_280_1.text_.text = var_283_5
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062068", "story_v_out_413062.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_out_413062", "413062068", "story_v_out_413062.awb") / 1000

					if var_283_8 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_2
					end

					if var_283_4.prefab_name ~= "" and arg_280_1.actors_[var_283_4.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_4.prefab_name].transform, "story_v_out_413062", "413062068", "story_v_out_413062.awb")

						arg_280_1:RecordAudio("413062068", var_283_9)
						arg_280_1:RecordAudio("413062068", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_413062", "413062068", "story_v_out_413062.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_413062", "413062068", "story_v_out_413062.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_3, arg_280_1.talkMaxDuration)

			if var_283_2 <= arg_280_1.time_ and arg_280_1.time_ < var_283_2 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_2) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_2 + var_283_10 and arg_280_1.time_ < var_283_2 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
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

		arg_280_1:InitPlayNodeList()
	end,
	Play413062069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 413062069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play413062070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos10022 = arg_284_1.actors_["10022"].transform.localPosition
				arg_284_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("10022", 7)

				for iter_287_0 = 0, arg_284_1.actors_["10022"].transform.childCount - 1 do
					local var_287_0 = arg_284_1.actors_["10022"].transform:GetChild(iter_287_0)

					if var_287_0.name == "" or not string.find(var_287_0.name, "split") then
						var_287_0.gameObject:SetActive(true)
					else
						var_287_0.gameObject:SetActive(false)
					end
				end
			end

			local var_287_1 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_1 then
				arg_284_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_284_1.time_ - 0) / var_287_1)
			end

			if arg_284_1.time_ >= 0 + var_287_1 and arg_284_1.time_ < 0 + var_287_1 + arg_287_0 then
				arg_284_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_287_2 = arg_284_1.actors_["10022"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_2) and arg_284_1.var_.actorSpriteComps10022 == nil then
				arg_284_1.var_.actorSpriteComps10022 = var_287_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_3 = 2

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_3 and not isNil(var_287_2) then
				if arg_284_1.var_.actorSpriteComps10022 then
					for iter_287_1, iter_287_2 in pairs(arg_284_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_287_2 then
							if arg_284_1.isInRecall_ then
								iter_287_2.color = Color.New(Mathf.Lerp(iter_287_2.color.r, arg_284_1.hightColor2.r, (arg_284_1.time_ - 0) / var_287_3), Mathf.Lerp(iter_287_2.color.g, arg_284_1.hightColor2.g, (arg_284_1.time_ - 0) / var_287_3), (Mathf.Lerp(iter_287_2.color.b, arg_284_1.hightColor2.b, (arg_284_1.time_ - 0) / var_287_3)))
							else
								local var_287_4 = Mathf.Lerp(iter_287_2.color.r, 0.5, (arg_284_1.time_ - 0) / var_287_3)

								iter_287_2.color = Color.New(var_287_4, var_287_4, var_287_4)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= 0 + var_287_3 and arg_284_1.time_ < 0 + var_287_3 + arg_287_0 and not isNil(var_287_2) and arg_284_1.var_.actorSpriteComps10022 then
				for iter_287_3, iter_287_4 in pairs(arg_284_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_287_4 then
						iter_287_4.color = arg_284_1.isInRecall_ and (arg_284_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_284_1.var_.actorSpriteComps10022 = nil
			end

			local var_287_5 = 0
			local var_287_6 = 1.175

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_7 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(413062069).content)

				arg_284_1.text_.text = var_287_7

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_9 = 47 <= 0 and var_287_6 or var_287_6 * (utf8.len(var_287_7) / 47)

				if (47 <= 0 and var_287_6 or var_287_6 * (utf8.len(var_287_7) / 47)) > 0 and var_287_6 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9

					if var_287_9 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_5
					end
				end

				arg_284_1.text_.text = var_287_7
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_6, arg_284_1.talkMaxDuration)

			if var_287_5 <= arg_284_1.time_ and arg_284_1.time_ < var_287_5 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_5) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_5 + var_287_10 and arg_284_1.time_ < var_287_5 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
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

		arg_284_1:InitPlayNodeList()
	end,
	Play413062070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 413062070
		arg_288_1.duration_ = 3.9

		local var_288_0 = {
			zh = 2.6,
			ja = 3.9
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play413062071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos10022 = arg_288_1.actors_["10022"].transform.localPosition
				arg_288_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("10022", 3)

				for iter_291_0 = 0, arg_288_1.actors_["10022"].transform.childCount - 1 do
					local var_291_0 = arg_288_1.actors_["10022"].transform:GetChild(iter_291_0)

					if var_291_0.name == "split_6" or not string.find(var_291_0.name, "split") then
						var_291_0.gameObject:SetActive(true)
					else
						var_291_0.gameObject:SetActive(false)
					end
				end
			end

			local var_291_1 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_1 then
				arg_288_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_288_1.time_ - 0) / var_291_1)
			end

			if arg_288_1.time_ >= 0 + var_291_1 and arg_288_1.time_ < 0 + var_291_1 + arg_291_0 then
				arg_288_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_291_2 = arg_288_1.actors_["10022"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.actorSpriteComps10022 == nil then
				arg_288_1.var_.actorSpriteComps10022 = var_291_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_3 = 2

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_3 and not isNil(var_291_2) then
				if arg_288_1.var_.actorSpriteComps10022 then
					for iter_291_1, iter_291_2 in pairs(arg_288_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_291_2 then
							if arg_288_1.isInRecall_ then
								iter_291_2.color = Color.New(Mathf.Lerp(iter_291_2.color.r, arg_288_1.hightColor1.r, (arg_288_1.time_ - 0) / var_291_3), Mathf.Lerp(iter_291_2.color.g, arg_288_1.hightColor1.g, (arg_288_1.time_ - 0) / var_291_3), (Mathf.Lerp(iter_291_2.color.b, arg_288_1.hightColor1.b, (arg_288_1.time_ - 0) / var_291_3)))
							else
								local var_291_4 = Mathf.Lerp(iter_291_2.color.r, 1, (arg_288_1.time_ - 0) / var_291_3)

								iter_291_2.color = Color.New(var_291_4, var_291_4, var_291_4)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= 0 + var_291_3 and arg_288_1.time_ < 0 + var_291_3 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.actorSpriteComps10022 then
				for iter_291_3, iter_291_4 in pairs(arg_288_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_291_4 then
						iter_291_4.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_288_1.var_.actorSpriteComps10022 = nil
			end

			local var_291_5 = 0
			local var_291_6 = 0.325

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_5 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_7 = arg_288_1:GetWordFromCfg(413062070)
				local var_291_8 = arg_288_1:FormatText(var_291_7.content)

				arg_288_1.text_.text = var_291_8

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_10 = 13 <= 0 and var_291_6 or var_291_6 * (utf8.len(var_291_8) / 13)

				if (13 <= 0 and var_291_6 or var_291_6 * (utf8.len(var_291_8) / 13)) > 0 and var_291_6 < var_291_10 then
					arg_288_1.talkMaxDuration = var_291_10

					if var_291_10 + var_291_5 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_5
					end
				end

				arg_288_1.text_.text = var_291_8
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062070", "story_v_out_413062.awb") ~= 0 then
					local var_291_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062070", "story_v_out_413062.awb") / 1000

					if var_291_11 + var_291_5 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_11 + var_291_5
					end

					if var_291_7.prefab_name ~= "" and arg_288_1.actors_[var_291_7.prefab_name] ~= nil then
						local var_291_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_7.prefab_name].transform, "story_v_out_413062", "413062070", "story_v_out_413062.awb")

						arg_288_1:RecordAudio("413062070", var_291_12)
						arg_288_1:RecordAudio("413062070", var_291_12)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_413062", "413062070", "story_v_out_413062.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_413062", "413062070", "story_v_out_413062.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_13 = math.max(var_291_6, arg_288_1.talkMaxDuration)

			if var_291_5 <= arg_288_1.time_ and arg_288_1.time_ < var_291_5 + var_291_13 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_5) / var_291_13

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_5 + var_291_13 and arg_288_1.time_ < var_291_5 + var_291_13 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
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

		arg_288_1:InitPlayNodeList()
	end,
	Play413062071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 413062071
		arg_292_1.duration_ = 3.73

		local var_292_0 = {
			zh = 1.6,
			ja = 3.733
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
				arg_292_0:Play413062072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.25

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_1 = arg_292_1:GetWordFromCfg(413062071)
				local var_295_2 = arg_292_1:FormatText(var_295_1.content)

				arg_292_1.text_.text = var_295_2

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 10 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 10)

				if (10 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 10)) > 0 and var_295_0 < var_295_4 then
					arg_292_1.talkMaxDuration = var_295_4

					if var_295_4 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_4 + 0
					end
				end

				arg_292_1.text_.text = var_295_2
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062071", "story_v_out_413062.awb") ~= 0 then
					local var_295_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062071", "story_v_out_413062.awb") / 1000

					if var_295_5 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + 0
					end

					if var_295_1.prefab_name ~= "" and arg_292_1.actors_[var_295_1.prefab_name] ~= nil then
						local var_295_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_1.prefab_name].transform, "story_v_out_413062", "413062071", "story_v_out_413062.awb")

						arg_292_1:RecordAudio("413062071", var_295_6)
						arg_292_1:RecordAudio("413062071", var_295_6)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_413062", "413062071", "story_v_out_413062.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_413062", "413062071", "story_v_out_413062.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_7 and arg_292_1.time_ < 0 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play413062072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 413062072
		arg_296_1.duration_ = 9

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play413062073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if arg_296_1.bgs_.F08g == nil then
				local var_299_0 = Object.Instantiate(arg_296_1.paintGo_)

				var_299_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08g")
				var_299_0.name = "F08g"
				var_299_0.transform.parent = arg_296_1.stage_.transform
				var_299_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.bgs_.F08g = var_299_0
			end

			if 2 < arg_296_1.time_ and arg_296_1.time_ <= 2 + arg_299_0 then
				local var_299_1 = arg_296_1.bgs_.F08g

				arg_296_1.bgs_.F08g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_299_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_299_2 = var_299_1:GetComponent("SpriteRenderer")

				if var_299_2 and var_299_2.sprite then
					local var_299_3 = 2 * (var_299_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_299_1.transform.localScale = Vector3.New(var_299_3 / var_299_2.sprite.bounds.size.y < var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x and var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x or var_299_3 / var_299_2.sprite.bounds.size.y, var_299_3 / var_299_2.sprite.bounds.size.y < var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x and var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x or var_299_3 / var_299_2.sprite.bounds.size.y, 0)
				end

				for iter_299_0, iter_299_1 in pairs(arg_296_1.bgs_) do
					if iter_299_0 ~= "F08g" then
						iter_299_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_299_4 = 4

			if 4 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.allBtn_.enabled = false
			end

			if arg_296_1.time_ >= var_299_4 + 0.3 and arg_296_1.time_ < var_299_4 + 0.3 + arg_299_0 then
				arg_296_1.allBtn_.enabled = true
			end

			local var_299_5 = 0

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_6 = 2

			if var_299_5 <= arg_296_1.time_ and arg_296_1.time_ < var_299_5 + var_299_6 then
				local var_299_7 = Color.New(0, 0, 0)

				var_299_7.a = Mathf.Lerp(0, 1, (arg_296_1.time_ - var_299_5) / var_299_6)
				arg_296_1.mask_.color = var_299_7
			end

			if arg_296_1.time_ >= var_299_5 + var_299_6 and arg_296_1.time_ < var_299_5 + var_299_6 + arg_299_0 then
				local var_299_8 = Color.New(0, 0, 0)

				var_299_8.a = 1
				arg_296_1.mask_.color = var_299_8
			end

			local var_299_9 = 2

			if 2 < arg_296_1.time_ and arg_296_1.time_ <= var_299_9 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_10 = 2

			if var_299_9 <= arg_296_1.time_ and arg_296_1.time_ < var_299_9 + var_299_10 then
				local var_299_11 = Color.New(0, 0, 0)

				var_299_11.a = Mathf.Lerp(1, 0, (arg_296_1.time_ - var_299_9) / var_299_10)
				arg_296_1.mask_.color = var_299_11
			end

			if arg_296_1.time_ >= var_299_9 + var_299_10 and arg_296_1.time_ < var_299_9 + var_299_10 + arg_299_0 then
				local var_299_12 = Color.New(0, 0, 0)

				arg_296_1.mask_.enabled = false
				var_299_12.a = 0
				arg_296_1.mask_.color = var_299_12
			end

			local var_299_13 = arg_296_1.actors_["10022"].transform

			if 1.966 < arg_296_1.time_ and arg_296_1.time_ <= 1.966 + arg_299_0 then
				arg_296_1.var_.moveOldPos10022 = var_299_13.localPosition
				var_299_13.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10022", 7)

				for iter_299_2 = 0, var_299_13.childCount - 1 do
					local var_299_14 = var_299_13:GetChild(iter_299_2)

					if var_299_14.name == "" or not string.find(var_299_14.name, "split") then
						var_299_14.gameObject:SetActive(true)
					else
						var_299_14.gameObject:SetActive(false)
					end
				end
			end

			local var_299_15 = 0.001

			if 1.966 <= arg_296_1.time_ and arg_296_1.time_ < 1.966 + var_299_15 then
				var_299_13.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_296_1.time_ - 1.966) / var_299_15)
			end

			if arg_296_1.time_ >= 1.966 + var_299_15 and arg_296_1.time_ < 1.966 + var_299_15 + arg_299_0 then
				var_299_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_299_16 = arg_296_1.actors_["10022"]

			if 1.966 < arg_296_1.time_ and arg_296_1.time_ <= 1.966 + arg_299_0 and not isNil(var_299_16) and arg_296_1.var_.actorSpriteComps10022 == nil then
				arg_296_1.var_.actorSpriteComps10022 = var_299_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_17 = 0.034

			if 1.966 <= arg_296_1.time_ and arg_296_1.time_ < 1.966 + var_299_17 and not isNil(var_299_16) then
				if arg_296_1.var_.actorSpriteComps10022 then
					for iter_299_3, iter_299_4 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_299_4 then
							if arg_296_1.isInRecall_ then
								iter_299_4.color = Color.New(Mathf.Lerp(iter_299_4.color.r, arg_296_1.hightColor2.r, (arg_296_1.time_ - 1.966) / var_299_17), Mathf.Lerp(iter_299_4.color.g, arg_296_1.hightColor2.g, (arg_296_1.time_ - 1.966) / var_299_17), (Mathf.Lerp(iter_299_4.color.b, arg_296_1.hightColor2.b, (arg_296_1.time_ - 1.966) / var_299_17)))
							else
								local var_299_18 = Mathf.Lerp(iter_299_4.color.r, 0.5, (arg_296_1.time_ - 1.966) / var_299_17)

								iter_299_4.color = Color.New(var_299_18, var_299_18, var_299_18)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 1.966 + var_299_17 and arg_296_1.time_ < 1.966 + var_299_17 + arg_299_0 and not isNil(var_299_16) and arg_296_1.var_.actorSpriteComps10022 then
				for iter_299_5, iter_299_6 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_299_6 then
						iter_299_6.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_296_1.var_.actorSpriteComps10022 = nil
			end

			if arg_296_1.frameCnt_ <= 1 then
				arg_296_1.dialog_:SetActive(false)
			end

			local var_299_19 = 4
			local var_299_20 = 1.5

			if 4 < arg_296_1.time_ and arg_296_1.time_ <= var_299_19 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0

				arg_296_1.dialog_:SetActive(true)

				arg_296_1.dialogCg_.alpha = 0

				local var_299_21 = LeanTween.value(arg_296_1.dialog_, 0, 1, 0.3)

				var_299_21:setOnUpdate(LuaHelper.FloatAction(function(arg_300_0)
					arg_296_1.dialogCg_.alpha = arg_300_0
				end))
				var_299_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_296_1.dialog_)
					var_299_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_296_1.duration_ = arg_296_1.duration_ + 0.3

				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_22 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(413062072).content)

				arg_296_1.text_.text = var_299_22

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_24 = 60 <= 0 and var_299_20 or var_299_20 * (utf8.len(var_299_22) / 60)

				if (60 <= 0 and var_299_20 or var_299_20 * (utf8.len(var_299_22) / 60)) > 0 and var_299_20 < var_299_24 then
					arg_296_1.talkMaxDuration = var_299_24
					var_299_19 = var_299_19 + 0.3

					if var_299_24 + var_299_19 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_24 + var_299_19
					end
				end

				arg_296_1.text_.text = var_299_22
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_25 = var_299_19 + 0.3
			local var_299_26 = math.max(var_299_20, arg_296_1.talkMaxDuration)

			if var_299_19 + 0.3 <= arg_296_1.time_ and arg_296_1.time_ < var_299_25 + var_299_26 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_25) / var_299_26

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_25 + var_299_26 and arg_296_1.time_ < var_299_25 + var_299_26 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play413062073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 413062073
		arg_302_1.duration_ = 9.17

		local var_302_0 = {
			zh = 9.166,
			ja = 8.566
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play413062074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos10022 = arg_302_1.actors_["10022"].transform.localPosition
				arg_302_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("10022", 3)

				for iter_305_0 = 0, arg_302_1.actors_["10022"].transform.childCount - 1 do
					local var_305_0 = arg_302_1.actors_["10022"].transform:GetChild(iter_305_0)

					if var_305_0.name == "split_3" or not string.find(var_305_0.name, "split") then
						var_305_0.gameObject:SetActive(true)
					else
						var_305_0.gameObject:SetActive(false)
					end
				end
			end

			local var_305_1 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_1 then
				arg_302_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_302_1.time_ - 0) / var_305_1)
			end

			if arg_302_1.time_ >= 0 + var_305_1 and arg_302_1.time_ < 0 + var_305_1 + arg_305_0 then
				arg_302_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_305_2 = arg_302_1.actors_["10022"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_2) and arg_302_1.var_.actorSpriteComps10022 == nil then
				arg_302_1.var_.actorSpriteComps10022 = var_305_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_3 = 2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_3 and not isNil(var_305_2) then
				if arg_302_1.var_.actorSpriteComps10022 then
					for iter_305_1, iter_305_2 in pairs(arg_302_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_305_2 then
							if arg_302_1.isInRecall_ then
								iter_305_2.color = Color.New(Mathf.Lerp(iter_305_2.color.r, arg_302_1.hightColor1.r, (arg_302_1.time_ - 0) / var_305_3), Mathf.Lerp(iter_305_2.color.g, arg_302_1.hightColor1.g, (arg_302_1.time_ - 0) / var_305_3), (Mathf.Lerp(iter_305_2.color.b, arg_302_1.hightColor1.b, (arg_302_1.time_ - 0) / var_305_3)))
							else
								local var_305_4 = Mathf.Lerp(iter_305_2.color.r, 1, (arg_302_1.time_ - 0) / var_305_3)

								iter_305_2.color = Color.New(var_305_4, var_305_4, var_305_4)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_3 and arg_302_1.time_ < 0 + var_305_3 + arg_305_0 and not isNil(var_305_2) and arg_302_1.var_.actorSpriteComps10022 then
				for iter_305_3, iter_305_4 in pairs(arg_302_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_305_4 then
						iter_305_4.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_302_1.var_.actorSpriteComps10022 = nil
			end

			local var_305_5 = 0
			local var_305_6 = 0.675

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_7 = arg_302_1:GetWordFromCfg(413062073)
				local var_305_8 = arg_302_1:FormatText(var_305_7.content)

				arg_302_1.text_.text = var_305_8

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_10 = 27 <= 0 and var_305_6 or var_305_6 * (utf8.len(var_305_8) / 27)

				if (27 <= 0 and var_305_6 or var_305_6 * (utf8.len(var_305_8) / 27)) > 0 and var_305_6 < var_305_10 then
					arg_302_1.talkMaxDuration = var_305_10

					if var_305_10 + var_305_5 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_5
					end
				end

				arg_302_1.text_.text = var_305_8
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062073", "story_v_out_413062.awb") ~= 0 then
					local var_305_11 = manager.audio:GetVoiceLength("story_v_out_413062", "413062073", "story_v_out_413062.awb") / 1000

					if var_305_11 + var_305_5 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_11 + var_305_5
					end

					if var_305_7.prefab_name ~= "" and arg_302_1.actors_[var_305_7.prefab_name] ~= nil then
						local var_305_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_7.prefab_name].transform, "story_v_out_413062", "413062073", "story_v_out_413062.awb")

						arg_302_1:RecordAudio("413062073", var_305_12)
						arg_302_1:RecordAudio("413062073", var_305_12)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_413062", "413062073", "story_v_out_413062.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_413062", "413062073", "story_v_out_413062.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_13 = math.max(var_305_6, arg_302_1.talkMaxDuration)

			if var_305_5 <= arg_302_1.time_ and arg_302_1.time_ < var_305_5 + var_305_13 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_5) / var_305_13

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_5 + var_305_13 and arg_302_1.time_ < var_305_5 + var_305_13 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
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

		arg_302_1:InitPlayNodeList()
	end,
	Play413062074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 413062074
		arg_306_1.duration_ = 9.33

		local var_306_0 = {
			zh = 7.6,
			ja = 9.333
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play413062075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.95

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:GetWordFromCfg(413062074)
				local var_309_2 = arg_306_1:FormatText(var_309_1.content)

				arg_306_1.text_.text = var_309_2

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 38 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 38)

				if (38 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 38)) > 0 and var_309_0 < var_309_4 then
					arg_306_1.talkMaxDuration = var_309_4

					if var_309_4 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_4 + 0
					end
				end

				arg_306_1.text_.text = var_309_2
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062074", "story_v_out_413062.awb") ~= 0 then
					local var_309_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062074", "story_v_out_413062.awb") / 1000

					if var_309_5 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + 0
					end

					if var_309_1.prefab_name ~= "" and arg_306_1.actors_[var_309_1.prefab_name] ~= nil then
						local var_309_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_1.prefab_name].transform, "story_v_out_413062", "413062074", "story_v_out_413062.awb")

						arg_306_1:RecordAudio("413062074", var_309_6)
						arg_306_1:RecordAudio("413062074", var_309_6)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_413062", "413062074", "story_v_out_413062.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_413062", "413062074", "story_v_out_413062.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play413062075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 413062075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play413062076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos10022 = arg_310_1.actors_["10022"].transform.localPosition
				arg_310_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_310_1:CheckSpriteTmpPos("10022", 7)

				for iter_313_0 = 0, arg_310_1.actors_["10022"].transform.childCount - 1 do
					local var_313_0 = arg_310_1.actors_["10022"].transform:GetChild(iter_313_0)

					if var_313_0.name == "" or not string.find(var_313_0.name, "split") then
						var_313_0.gameObject:SetActive(true)
					else
						var_313_0.gameObject:SetActive(false)
					end
				end
			end

			local var_313_1 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_1 then
				arg_310_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_310_1.time_ - 0) / var_313_1)
			end

			if arg_310_1.time_ >= 0 + var_313_1 and arg_310_1.time_ < 0 + var_313_1 + arg_313_0 then
				arg_310_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_313_2 = arg_310_1.actors_["10022"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps10022 == nil then
				arg_310_1.var_.actorSpriteComps10022 = var_313_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_3 = 2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_3 and not isNil(var_313_2) then
				if arg_310_1.var_.actorSpriteComps10022 then
					for iter_313_1, iter_313_2 in pairs(arg_310_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_313_2 then
							if arg_310_1.isInRecall_ then
								iter_313_2.color = Color.New(Mathf.Lerp(iter_313_2.color.r, arg_310_1.hightColor2.r, (arg_310_1.time_ - 0) / var_313_3), Mathf.Lerp(iter_313_2.color.g, arg_310_1.hightColor2.g, (arg_310_1.time_ - 0) / var_313_3), (Mathf.Lerp(iter_313_2.color.b, arg_310_1.hightColor2.b, (arg_310_1.time_ - 0) / var_313_3)))
							else
								local var_313_4 = Mathf.Lerp(iter_313_2.color.r, 0.5, (arg_310_1.time_ - 0) / var_313_3)

								iter_313_2.color = Color.New(var_313_4, var_313_4, var_313_4)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_3 and arg_310_1.time_ < 0 + var_313_3 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps10022 then
				for iter_313_3, iter_313_4 in pairs(arg_310_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_313_4 then
						iter_313_4.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_310_1.var_.actorSpriteComps10022 = nil
			end

			local var_313_5 = 0
			local var_313_6 = 1.325

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_7 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(413062075).content)

				arg_310_1.text_.text = var_313_7

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_9 = 53 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_7) / 53)

				if (53 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_7) / 53)) > 0 and var_313_6 < var_313_9 then
					arg_310_1.talkMaxDuration = var_313_9

					if var_313_9 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_9 + var_313_5
					end
				end

				arg_310_1.text_.text = var_313_7
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_10 = math.max(var_313_6, arg_310_1.talkMaxDuration)

			if var_313_5 <= arg_310_1.time_ and arg_310_1.time_ < var_313_5 + var_313_10 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_5) / var_313_10

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_5 + var_313_10 and arg_310_1.time_ < var_313_5 + var_313_10 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
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

		arg_310_1:InitPlayNodeList()
	end,
	Play413062076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 413062076
		arg_314_1.duration_ = 6.43

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play413062077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0.5 < arg_314_1.time_ and arg_314_1.time_ <= 0.5 + arg_317_0 then
				arg_314_1.mask_.enabled = true
				arg_314_1.mask_.raycastTarget = true

				arg_314_1:SetGaussion(false)
			end

			local var_317_0 = 1.23333333333333

			if 0.5 <= arg_314_1.time_ and arg_314_1.time_ < 0.5 + var_317_0 then
				local var_317_1 = Color.New(1, 1, 1)

				var_317_1.a = Mathf.Lerp(1, 0, (arg_314_1.time_ - 0.5) / var_317_0)
				arg_314_1.mask_.color = var_317_1
			end

			if arg_314_1.time_ >= 0.5 + var_317_0 and arg_314_1.time_ < 0.5 + var_317_0 + arg_317_0 then
				local var_317_2 = Color.New(1, 1, 1)

				arg_314_1.mask_.enabled = false
				var_317_2.a = 0
				arg_314_1.mask_.color = var_317_2
			end

			local var_317_3 = 0

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_3 + arg_317_0 then
				arg_314_1.allBtn_.enabled = false
			end

			if arg_314_1.time_ >= var_317_3 + 0.5 and arg_314_1.time_ < var_317_3 + 0.5 + arg_317_0 then
				arg_314_1.allBtn_.enabled = true
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:AudioAction("play", "effect", "se_story", "se_story_alarmloop", "")
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_317_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_314_1.bgmTxt_.text ~= var_317_7 and arg_314_1.bgmTxt_.text ~= "" then
						if arg_314_1.bgmTxt2_.text ~= "" then
							arg_314_1.bgmTxt_.text = arg_314_1.bgmTxt2_.text
						end

						arg_314_1.bgmTxt2_.text = var_317_7

						arg_314_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_314_1.bgmTxt_.text = var_317_7
						arg_314_1.bgmTxt2_.text = var_317_7
					end

					if arg_314_1.bgmTimer then
						arg_314_1.bgmTimer:Stop()

						arg_314_1.bgmTimer = nil
					end

					if arg_314_1.settingData.show_music_name == 1 then
						arg_314_1.musicController:SetSelectedState("show")
						arg_314_1.musicAnimator_:Play("open", 0, 0)

						if arg_314_1.settingData.music_time ~= 0 then
							arg_314_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_314_1.settingData.music_time), function()
								if arg_314_1 == nil or isNil(arg_314_1.bgmTxt_) then
									return
								end

								arg_314_1.musicController:SetSelectedState("hide")
								arg_314_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_314_1.time_ and arg_314_1.time_ <= 0.366666666666667 + arg_317_0 then
				arg_314_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_317_10 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

				if "" ~= "" then
					if arg_314_1.bgmTxt_.text ~= var_317_10 and arg_314_1.bgmTxt_.text ~= "" then
						if arg_314_1.bgmTxt2_.text ~= "" then
							arg_314_1.bgmTxt_.text = arg_314_1.bgmTxt2_.text
						end

						arg_314_1.bgmTxt2_.text = var_317_10

						arg_314_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_314_1.bgmTxt_.text = var_317_10
						arg_314_1.bgmTxt2_.text = var_317_10
					end

					if arg_314_1.bgmTimer then
						arg_314_1.bgmTimer:Stop()

						arg_314_1.bgmTimer = nil
					end

					if arg_314_1.settingData.show_music_name == 1 then
						arg_314_1.musicController:SetSelectedState("show")
						arg_314_1.musicAnimator_:Play("open", 0, 0)

						if arg_314_1.settingData.music_time ~= 0 then
							arg_314_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_314_1.settingData.music_time), function()
								if arg_314_1 == nil or isNil(arg_314_1.bgmTxt_) then
									return
								end

								arg_314_1.musicController:SetSelectedState("hide")
								arg_314_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_314_1.frameCnt_ <= 1 then
				arg_314_1.dialog_:SetActive(false)
			end

			local var_317_11 = 1.43333333333333
			local var_317_12 = 1.575

			if 1.43333333333333 < arg_314_1.time_ and arg_314_1.time_ <= var_317_11 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0

				arg_314_1.dialog_:SetActive(true)

				arg_314_1.dialogCg_.alpha = 0

				local var_317_13 = LeanTween.value(arg_314_1.dialog_, 0, 1, 0.3)

				var_317_13:setOnUpdate(LuaHelper.FloatAction(function(arg_320_0)
					arg_314_1.dialogCg_.alpha = arg_320_0
				end))
				var_317_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_314_1.dialog_)
					var_317_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_314_1.duration_ = arg_314_1.duration_ + 0.3

				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_14 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(413062076).content)

				arg_314_1.text_.text = var_317_14

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_16 = 63 <= 0 and var_317_12 or var_317_12 * (utf8.len(var_317_14) / 63)

				if (63 <= 0 and var_317_12 or var_317_12 * (utf8.len(var_317_14) / 63)) > 0 and var_317_12 < var_317_16 then
					arg_314_1.talkMaxDuration = var_317_16
					var_317_11 = var_317_11 + 0.3

					if var_317_16 + var_317_11 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_16 + var_317_11
					end
				end

				arg_314_1.text_.text = var_317_14
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_17 = var_317_11 + 0.3
			local var_317_18 = math.max(var_317_12, arg_314_1.talkMaxDuration)

			if var_317_11 + 0.3 <= arg_314_1.time_ and arg_314_1.time_ < var_317_17 + var_317_18 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_17) / var_317_18

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_17 + var_317_18 and arg_314_1.time_ < var_317_17 + var_317_18 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play413062077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 413062077
		arg_322_1.duration_ = 3.07

		local var_322_0 = {
			zh = 2.6,
			ja = 3.067
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
			arg_322_1.auto_ = false
		end

		function arg_322_1.playNext_(arg_324_0)
			arg_322_1.onStoryFinished_()
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.2

			if 0.034 < arg_322_1.time_ and arg_322_1.time_ <= 0.034 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_1 = arg_322_1:GetWordFromCfg(413062077)
				local var_325_2 = arg_322_1:FormatText(var_325_1.content)

				arg_322_1.text_.text = var_325_2

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 8 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 8)

				if (8 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 8)) > 0 and var_325_0 < var_325_4 then
					arg_322_1.talkMaxDuration = var_325_4

					if var_325_4 + 0.034 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_4 + 0.034
					end
				end

				arg_322_1.text_.text = var_325_2
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413062", "413062077", "story_v_out_413062.awb") ~= 0 then
					local var_325_5 = manager.audio:GetVoiceLength("story_v_out_413062", "413062077", "story_v_out_413062.awb") / 1000

					if var_325_5 + 0.034 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + 0.034
					end

					if var_325_1.prefab_name ~= "" and arg_322_1.actors_[var_325_1.prefab_name] ~= nil then
						local var_325_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_1.prefab_name].transform, "story_v_out_413062", "413062077", "story_v_out_413062.awb")

						arg_322_1:RecordAudio("413062077", var_325_6)
						arg_322_1:RecordAudio("413062077", var_325_6)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_413062", "413062077", "story_v_out_413062.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_413062", "413062077", "story_v_out_413062.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0.034 <= arg_322_1.time_ and arg_322_1.time_ < 0.034 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0.034) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0.034 + var_325_7 and arg_322_1.time_ < 0.034 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/ST71a",
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/F08g"
	},
	voices = {
		"story_v_out_413062.awb"
	}
}
