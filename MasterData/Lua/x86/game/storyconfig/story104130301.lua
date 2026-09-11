return {
	Play413031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413031001
		arg_1_1.duration_ = 4.13

		local var_1_0 = {
			zh = 4.133,
			ja = 3.3
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
				arg_1_0:Play413031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0601 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0601")
				var_4_0.name = "ST0601"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0601 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0601

				arg_1_1.bgs_.ST0601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0601" then
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10093 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10093", 3)

				for iter_4_4 = 0, var_4_12.childCount - 1 do
					local var_4_13 = var_4_12:GetChild(iter_4_4)

					if var_4_13.name == "split_4" or not string.find(var_4_13.name, "split") then
						var_4_13.gameObject:SetActive(true)
					else
						var_4_13.gameObject:SetActive(false)
					end
				end
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_1_1.time_ - 1.8) / var_4_14)
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -345, -245)
			end

			local var_4_15 = arg_1_1.actors_["10093"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10093 == nil then
				arg_1_1.var_.actorSpriteComps10093 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 0.1

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps10093 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10093 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10093 = nil
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue10093 = var_4_18.alpha
					arg_1_1.var_.characterEffect10093 = var_4_18
				end

				arg_1_1.var_.alphaOldValue10093 = 0
			end

			local var_4_19 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_19 then
				if arg_1_1.var_.characterEffect10093 then
					arg_1_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10093, 1, (arg_1_1.time_ - 1.8) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_19 and arg_1_1.time_ < 1.8 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect10093 then
				arg_1_1.var_.characterEffect10093.alpha = 1
			end

			if 1.799999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.799999999999 + arg_4_0 then
				local var_4_20 = arg_1_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_20 then
					arg_1_1.var_.alphaOldValue10093 = var_4_20.alpha
					arg_1_1.var_.characterEffect10093 = var_4_20
				end

				arg_1_1.var_.alphaOldValue10093 = 0
			end

			local var_4_21 = 0.5

			if 1.799999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.799999999999 + var_4_21 then
				if arg_1_1.var_.characterEffect10093 then
					arg_1_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10093, 1, (arg_1_1.time_ - 1.799999999999) / var_4_21)
				end
			end

			if arg_1_1.time_ >= 1.799999999999 + var_4_21 and arg_1_1.time_ < 1.799999999999 + var_4_21 + arg_4_0 and arg_1_1.var_.characterEffect10093 then
				arg_1_1.var_.characterEffect10093.alpha = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete.awb")

				local var_4_27 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete")

				if "" ~= "" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_28 = 2
			local var_4_29 = 0.15

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_31 = arg_1_1:GetWordFromCfg(413031001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 6 <= 0 and var_4_29 or var_4_29 * (utf8.len(var_4_32) / 6)

				if (6 <= 0 and var_4_29 or var_4_29 * (utf8.len(var_4_32) / 6)) > 0 and var_4_29 < var_4_34 then
					arg_1_1.talkMaxDuration = var_4_34
					var_4_28 = var_4_28 + 0.3

					if var_4_34 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031001", "story_v_out_413031.awb") ~= 0 then
					local var_4_35 = manager.audio:GetVoiceLength("story_v_out_413031", "413031001", "story_v_out_413031.awb") / 1000

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end

					if var_4_31.prefab_name ~= "" and arg_1_1.actors_[var_4_31.prefab_name] ~= nil then
						local var_4_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_31.prefab_name].transform, "story_v_out_413031", "413031001", "story_v_out_413031.awb")

						arg_1_1:RecordAudio("413031001", var_4_36)
						arg_1_1:RecordAudio("413031001", var_4_36)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413031", "413031001", "story_v_out_413031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413031", "413031001", "story_v_out_413031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_37 = var_4_28 + 0.3
			local var_4_38 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_28 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_37) / var_4_38

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
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
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play413031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413031002
		arg_9_1.duration_ = 4.3

		local var_9_0 = {
			zh = 2.966,
			ja = 4.3
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
				arg_9_0:Play413031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10093 = arg_9_1.actors_["10093"].transform.localPosition
				arg_9_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10093", 7)

				for iter_12_0 = 0, arg_9_1.actors_["10093"].transform.childCount - 1 do
					local var_12_0 = arg_9_1.actors_["10093"].transform:GetChild(iter_12_0)

					if var_12_0.name == "split_7" or not string.find(var_12_0.name, "split") then
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

			local var_12_2 = "10092"

			if arg_9_1.actors_["10092"] == nil then
				local var_12_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_12_3) then
					local var_12_4 = Object.Instantiate(var_12_3, arg_9_1.canvasGo_.transform)

					var_12_4.transform:SetSiblingIndex(1)

					var_12_4.name = var_12_2
					var_12_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_2] = var_12_4

					if arg_9_1.isInRecall_ then
						for iter_12_1, iter_12_2 in ipairs((var_12_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_2.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_5 = arg_9_1.actors_["10092"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10092 = var_12_5.localPosition
				var_12_5.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10092", 3)

				for iter_12_3 = 0, var_12_5.childCount - 1 do
					local var_12_6 = var_12_5:GetChild(iter_12_3)

					if var_12_6.name == "split_8" or not string.find(var_12_6.name, "split") then
						var_12_6.gameObject:SetActive(true)
					else
						var_12_6.gameObject:SetActive(false)
					end
				end
			end

			local var_12_7 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_9_1.time_ - 0) / var_12_7)
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -300, -295)
			end

			local var_12_8 = arg_9_1.actors_["10093"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps10093 == nil then
				arg_9_1.var_.actorSpriteComps10093 = var_12_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_9 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.actorSpriteComps10093 then
					for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_12_5 then
							if arg_9_1.isInRecall_ then
								iter_12_5.color = Color.New(Mathf.Lerp(iter_12_5.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_9), Mathf.Lerp(iter_12_5.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_9), (Mathf.Lerp(iter_12_5.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_9)))
							else
								local var_12_10 = Mathf.Lerp(iter_12_5.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_9)

								iter_12_5.color = Color.New(var_12_10, var_12_10, var_12_10)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps10093 then
				for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_12_7 then
						iter_12_7.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10093 = nil
			end

			local var_12_11 = arg_9_1.actors_["10092"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10092 == nil then
				arg_9_1.var_.actorSpriteComps10092 = var_12_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_12 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_12 and not isNil(var_12_11) then
				if arg_9_1.var_.actorSpriteComps10092 then
					for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_12_9 then
							if arg_9_1.isInRecall_ then
								iter_12_9.color = Color.New(Mathf.Lerp(iter_12_9.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_12), Mathf.Lerp(iter_12_9.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_12), (Mathf.Lerp(iter_12_9.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_12)))
							else
								local var_12_13 = Mathf.Lerp(iter_12_9.color.r, 1, (arg_9_1.time_ - 0) / var_12_12)

								iter_12_9.color = Color.New(var_12_13, var_12_13, var_12_13)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_12 and arg_9_1.time_ < 0 + var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10092 then
				for iter_12_10, iter_12_11 in pairs(arg_9_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_12_11 then
						iter_12_11.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10092 = nil
			end

			local var_12_14 = 0
			local var_12_15 = 0.3

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
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

				local var_12_16 = arg_9_1:GetWordFromCfg(413031002)
				local var_12_17 = arg_9_1:FormatText(var_12_16.content)

				arg_9_1.text_.text = var_12_17

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 12 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 12)

				if (12 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 12)) > 0 and var_12_15 < var_12_19 then
					arg_9_1.talkMaxDuration = var_12_19

					if var_12_19 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_14
					end
				end

				arg_9_1.text_.text = var_12_17
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031002", "story_v_out_413031.awb") ~= 0 then
					local var_12_20 = manager.audio:GetVoiceLength("story_v_out_413031", "413031002", "story_v_out_413031.awb") / 1000

					if var_12_20 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_20 + var_12_14
					end

					if var_12_16.prefab_name ~= "" and arg_9_1.actors_[var_12_16.prefab_name] ~= nil then
						local var_12_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_16.prefab_name].transform, "story_v_out_413031", "413031002", "story_v_out_413031.awb")

						arg_9_1:RecordAudio("413031002", var_12_21)
						arg_9_1:RecordAudio("413031002", var_12_21)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413031", "413031002", "story_v_out_413031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413031", "413031002", "story_v_out_413031.awb")
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

		arg_9_1:InitPlayNodeList()
	end,
	Play413031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413031003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play413031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10092 = arg_13_1.actors_["10092"].transform.localPosition
				arg_13_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10092", 7)

				for iter_16_0 = 0, arg_13_1.actors_["10092"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["10092"].transform:GetChild(iter_16_0)

					if var_16_0.name == "split_4" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_16_2 = arg_13_1.actors_["10092"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10092 == nil then
				arg_13_1.var_.actorSpriteComps10092 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps10092 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								iter_16_2.color = Color.New(Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_2.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_2.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10092 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_16_4 then
						iter_16_4.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10092 = nil
			end

			local var_16_5 = 0
			local var_16_6 = 0.65

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(413031003).content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 26 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 26)

				if (26 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 26)) > 0 and var_16_6 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_10 and arg_13_1.time_ < var_16_5 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play413031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413031004
		arg_17_1.duration_ = 7.63

		local var_17_0 = {
			zh = 5.7,
			ja = 7.633
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
				arg_17_0:Play413031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10092 = arg_17_1.actors_["10092"].transform.localPosition
				arg_17_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10092", 3)

				for iter_20_0 = 0, arg_17_1.actors_["10092"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["10092"].transform:GetChild(iter_20_0)

					if var_20_0.name == "" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_20_2 = arg_17_1.actors_["10092"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10092 == nil then
				arg_17_1.var_.actorSpriteComps10092 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps10092 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_20_2 then
							if arg_17_1.isInRecall_ then
								iter_20_2.color = Color.New(Mathf.Lerp(iter_20_2.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_2.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_2.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_2.color.r, 1, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_2.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10092 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10092 = nil
			end

			local var_20_5 = 0
			local var_20_6 = 0.575

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(413031004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 23 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 23)

				if (23 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 23)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031004", "story_v_out_413031.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031004", "story_v_out_413031.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_413031", "413031004", "story_v_out_413031.awb")

						arg_17_1:RecordAudio("413031004", var_20_12)
						arg_17_1:RecordAudio("413031004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413031", "413031004", "story_v_out_413031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413031", "413031004", "story_v_out_413031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_13 and arg_17_1.time_ < var_20_5 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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
	Play413031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413031005
		arg_21_1.duration_ = 11.6

		local var_21_0 = {
			zh = 4.266,
			ja = 11.6
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
				arg_21_0:Play413031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10092 = arg_21_1.actors_["10092"].transform.localPosition
				arg_21_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10092", 0)

				for iter_24_0 = 0, arg_21_1.actors_["10092"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10092"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_24_2 = "10094"

			if arg_21_1.actors_["10094"] == nil then
				local var_24_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_24_3) then
					local var_24_4 = Object.Instantiate(var_24_3, arg_21_1.canvasGo_.transform)

					var_24_4.transform:SetSiblingIndex(1)

					var_24_4.name = var_24_2
					var_24_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_2] = var_24_4

					if arg_21_1.isInRecall_ then
						for iter_24_1, iter_24_2 in ipairs((var_24_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_24_2.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_5 = arg_21_1.actors_["10094"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10094 = var_24_5.localPosition
				var_24_5.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10094", 3)

				for iter_24_3 = 0, var_24_5.childCount - 1 do
					local var_24_6 = var_24_5:GetChild(iter_24_3)

					if var_24_6.name == "" or not string.find(var_24_6.name, "split") then
						var_24_6.gameObject:SetActive(true)
					else
						var_24_6.gameObject:SetActive(false)
					end
				end
			end

			local var_24_7 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_21_1.time_ - 0) / var_24_7)
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -340, -414)
			end

			local var_24_8 = arg_21_1.actors_["10092"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10092 == nil then
				arg_21_1.var_.actorSpriteComps10092 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 and not isNil(var_24_8) then
				if arg_21_1.var_.actorSpriteComps10092 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								iter_24_5.color = Color.New(Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_9), Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_9), (Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_9)))
							else
								local var_24_10 = Mathf.Lerp(iter_24_5.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_9)

								iter_24_5.color = Color.New(var_24_10, var_24_10, var_24_10)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10092 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_24_7 then
						iter_24_7.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10092 = nil
			end

			local var_24_11 = arg_21_1.actors_["10094"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_11) and arg_21_1.var_.actorSpriteComps10094 == nil then
				arg_21_1.var_.actorSpriteComps10094 = var_24_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_12 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_12 and not isNil(var_24_11) then
				if arg_21_1.var_.actorSpriteComps10094 then
					for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_24_9 then
							if arg_21_1.isInRecall_ then
								iter_24_9.color = Color.New(Mathf.Lerp(iter_24_9.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_12), Mathf.Lerp(iter_24_9.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_12), (Mathf.Lerp(iter_24_9.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_12)))
							else
								local var_24_13 = Mathf.Lerp(iter_24_9.color.r, 1, (arg_21_1.time_ - 0) / var_24_12)

								iter_24_9.color = Color.New(var_24_13, var_24_13, var_24_13)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_12 and arg_21_1.time_ < 0 + var_24_12 + arg_24_0 and not isNil(var_24_11) and arg_21_1.var_.actorSpriteComps10094 then
				for iter_24_10, iter_24_11 in pairs(arg_21_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_24_11 then
						iter_24_11.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10094 = nil
			end

			local var_24_14 = 0
			local var_24_15 = 0.525

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_16 = arg_21_1:GetWordFromCfg(413031005)
				local var_24_17 = arg_21_1:FormatText(var_24_16.content)

				arg_21_1.text_.text = var_24_17

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_19 = 21 <= 0 and var_24_15 or var_24_15 * (utf8.len(var_24_17) / 21)

				if (21 <= 0 and var_24_15 or var_24_15 * (utf8.len(var_24_17) / 21)) > 0 and var_24_15 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19

					if var_24_19 + var_24_14 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_14
					end
				end

				arg_21_1.text_.text = var_24_17
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031005", "story_v_out_413031.awb") ~= 0 then
					local var_24_20 = manager.audio:GetVoiceLength("story_v_out_413031", "413031005", "story_v_out_413031.awb") / 1000

					if var_24_20 + var_24_14 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_20 + var_24_14
					end

					if var_24_16.prefab_name ~= "" and arg_21_1.actors_[var_24_16.prefab_name] ~= nil then
						local var_24_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_16.prefab_name].transform, "story_v_out_413031", "413031005", "story_v_out_413031.awb")

						arg_21_1:RecordAudio("413031005", var_24_21)
						arg_21_1:RecordAudio("413031005", var_24_21)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413031", "413031005", "story_v_out_413031.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413031", "413031005", "story_v_out_413031.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = math.max(var_24_15, arg_21_1.talkMaxDuration)

			if var_24_14 <= arg_21_1.time_ and arg_21_1.time_ < var_24_14 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_14) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_14 + var_24_22 and arg_21_1.time_ < var_24_14 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play413031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413031006
		arg_25_1.duration_ = 14.97

		local var_25_0 = {
			zh = 8.866,
			ja = 14.966
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
				arg_25_0:Play413031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["10022"] == nil then
				local var_28_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_28_0) then
					local var_28_1 = Object.Instantiate(var_28_0, arg_25_1.canvasGo_.transform)

					var_28_1.transform:SetSiblingIndex(1)

					var_28_1.name = "10022"
					var_28_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_25_1.actors_["10022"] = var_28_1

					if arg_25_1.isInRecall_ then
						for iter_28_0, iter_28_1 in ipairs((var_28_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_28_1.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_28_2 = arg_25_1.actors_["10022"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10022 = var_28_2.localPosition
				var_28_2.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10022", 3)

				for iter_28_2 = 0, var_28_2.childCount - 1 do
					local var_28_3 = var_28_2:GetChild(iter_28_2)

					if var_28_3.name == "split_3" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_2.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_25_1.time_ - 0) / var_28_4)
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_28_5 = arg_25_1.actors_["10022"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps10022 == nil then
				arg_25_1.var_.actorSpriteComps10022 = var_28_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_6 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.actorSpriteComps10022 then
					for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_28_4 then
							if arg_25_1.isInRecall_ then
								iter_28_4.color = Color.New(Mathf.Lerp(iter_28_4.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_6), Mathf.Lerp(iter_28_4.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_6), (Mathf.Lerp(iter_28_4.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_6)))
							else
								local var_28_7 = Mathf.Lerp(iter_28_4.color.r, 1, (arg_25_1.time_ - 0) / var_28_6)

								iter_28_4.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps10022 then
				for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_28_6 then
						iter_28_6.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10022 = nil
			end

			local var_28_8 = arg_25_1.actors_["10094"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10094 == nil then
				arg_25_1.var_.actorSpriteComps10094 = var_28_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_9 and not isNil(var_28_8) then
				if arg_25_1.var_.actorSpriteComps10094 then
					for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_28_8 then
							if arg_25_1.isInRecall_ then
								iter_28_8.color = Color.New(Mathf.Lerp(iter_28_8.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_9), Mathf.Lerp(iter_28_8.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_9), (Mathf.Lerp(iter_28_8.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_9)))
							else
								local var_28_10 = Mathf.Lerp(iter_28_8.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_9)

								iter_28_8.color = Color.New(var_28_10, var_28_10, var_28_10)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_9 and arg_25_1.time_ < 0 + var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10094 then
				for iter_28_9, iter_28_10 in pairs(arg_25_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_28_10 then
						iter_28_10.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10094 = nil
			end

			local var_28_11 = 0
			local var_28_12 = 1.1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_13 = arg_25_1:GetWordFromCfg(413031006)
				local var_28_14 = arg_25_1:FormatText(var_28_13.content)

				arg_25_1.text_.text = var_28_14

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 44 <= 0 and var_28_12 or var_28_12 * (utf8.len(var_28_14) / 44)

				if (44 <= 0 and var_28_12 or var_28_12 * (utf8.len(var_28_14) / 44)) > 0 and var_28_12 < var_28_16 then
					arg_25_1.talkMaxDuration = var_28_16

					if var_28_16 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_14
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031006", "story_v_out_413031.awb") ~= 0 then
					local var_28_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031006", "story_v_out_413031.awb") / 1000

					if var_28_17 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_11
					end

					if var_28_13.prefab_name ~= "" and arg_25_1.actors_[var_28_13.prefab_name] ~= nil then
						local var_28_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_13.prefab_name].transform, "story_v_out_413031", "413031006", "story_v_out_413031.awb")

						arg_25_1:RecordAudio("413031006", var_28_18)
						arg_25_1:RecordAudio("413031006", var_28_18)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413031", "413031006", "story_v_out_413031.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413031", "413031006", "story_v_out_413031.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_19 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_19 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_19

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_19 and arg_25_1.time_ < var_28_11 + var_28_19 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play413031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413031007
		arg_29_1.duration_ = 9.6

		local var_29_0 = {
			zh = 5.733,
			ja = 9.6
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
				arg_29_0:Play413031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.8

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(413031007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 32 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 32)

				if (32 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 32)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031007", "story_v_out_413031.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031007", "story_v_out_413031.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_413031", "413031007", "story_v_out_413031.awb")

						arg_29_1:RecordAudio("413031007", var_32_6)
						arg_29_1:RecordAudio("413031007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413031", "413031007", "story_v_out_413031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413031", "413031007", "story_v_out_413031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play413031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413031008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play413031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10092 = arg_33_1.actors_["10092"].transform.localPosition
				arg_33_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10092", 3)

				for iter_36_0 = 0, arg_33_1.actors_["10092"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["10092"].transform:GetChild(iter_36_0)

					if var_36_0.name == "split_5" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_36_2 = arg_33_1.actors_["10092"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10092 == nil then
				arg_33_1.var_.actorSpriteComps10092 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps10092 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								iter_36_2.color = Color.New(Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_2.color.r, 1, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_2.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10092 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_36_4 then
						iter_36_4.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps10092 = nil
			end

			local var_36_5 = arg_33_1.actors_["10022"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps10022 == nil then
				arg_33_1.var_.actorSpriteComps10022 = var_36_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_6 = 2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.actorSpriteComps10022 then
					for iter_36_5, iter_36_6 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_36_6 then
							if arg_33_1.isInRecall_ then
								iter_36_6.color = Color.New(Mathf.Lerp(iter_36_6.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_6), Mathf.Lerp(iter_36_6.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_6), (Mathf.Lerp(iter_36_6.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_6)))
							else
								local var_36_7 = Mathf.Lerp(iter_36_6.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_6)

								iter_36_6.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps10022 then
				for iter_36_7, iter_36_8 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_36_8 then
						iter_36_8.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10022 = nil
			end

			local var_36_8 = 0
			local var_36_9 = 0.125

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(413031008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 5 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 5)

				if (5 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 5)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031008", "story_v_out_413031.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031008", "story_v_out_413031.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_413031", "413031008", "story_v_out_413031.awb")

						arg_33_1:RecordAudio("413031008", var_36_15)
						arg_33_1:RecordAudio("413031008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413031", "413031008", "story_v_out_413031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413031", "413031008", "story_v_out_413031.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play413031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413031009
		arg_37_1.duration_ = 6.83

		local var_37_0 = {
			zh = 6.833,
			ja = 5.433
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
				arg_37_0:Play413031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10022 = arg_37_1.actors_["10022"].transform.localPosition
				arg_37_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10022", 3)

				for iter_40_0 = 0, arg_37_1.actors_["10022"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["10022"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_3" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_40_2 = arg_37_1.actors_["10022"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10022 == nil then
				arg_37_1.var_.actorSpriteComps10022 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps10022 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10022 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10022 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 0.975

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(413031009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 39 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 39)

				if (39 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 39)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031009", "story_v_out_413031.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031009", "story_v_out_413031.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_413031", "413031009", "story_v_out_413031.awb")

						arg_37_1:RecordAudio("413031009", var_40_12)
						arg_37_1:RecordAudio("413031009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413031", "413031009", "story_v_out_413031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413031", "413031009", "story_v_out_413031.awb")
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
				actorName = "10022",
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
	Play413031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413031010
		arg_41_1.duration_ = 2.03

		local var_41_0 = {
			zh = 2.033,
			ja = 1.999999999999
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
				arg_41_0:Play413031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10092 = arg_41_1.actors_["10092"].transform.localPosition
				arg_41_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10092", 0)

				for iter_44_0 = 0, arg_41_1.actors_["10092"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10092"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_44_2 = arg_41_1.actors_["10094"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10094 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10094", 3)

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
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(0, -340, -414)
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
								iter_44_3.color = Color.New(Mathf.Lerp(iter_44_3.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_6), Mathf.Lerp(iter_44_3.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_6), (Mathf.Lerp(iter_44_3.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_6)))
							else
								local var_44_7 = Mathf.Lerp(iter_44_3.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_6)

								iter_44_3.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps10092 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_44_5 then
						iter_44_5.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
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
								iter_44_7.color = Color.New(Mathf.Lerp(iter_44_7.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_9), Mathf.Lerp(iter_44_7.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_9), (Mathf.Lerp(iter_44_7.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_9)))
							else
								local var_44_10 = Mathf.Lerp(iter_44_7.color.r, 1, (arg_41_1.time_ - 0) / var_44_9)

								iter_44_7.color = Color.New(var_44_10, var_44_10, var_44_10)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10094 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_44_9 then
						iter_44_9.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10094 = nil
			end

			local var_44_11 = 0
			local var_44_12 = 0.275

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_13 = arg_41_1:GetWordFromCfg(413031010)
				local var_44_14 = arg_41_1:FormatText(var_44_13.content)

				arg_41_1.text_.text = var_44_14

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 11 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 11)

				if (11 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 11)) > 0 and var_44_12 < var_44_16 then
					arg_41_1.talkMaxDuration = var_44_16

					if var_44_16 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_14
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031010", "story_v_out_413031.awb") ~= 0 then
					local var_44_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031010", "story_v_out_413031.awb") / 1000

					if var_44_17 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_11
					end

					if var_44_13.prefab_name ~= "" and arg_41_1.actors_[var_44_13.prefab_name] ~= nil then
						local var_44_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_13.prefab_name].transform, "story_v_out_413031", "413031010", "story_v_out_413031.awb")

						arg_41_1:RecordAudio("413031010", var_44_18)
						arg_41_1:RecordAudio("413031010", var_44_18)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413031", "413031010", "story_v_out_413031.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413031", "413031010", "story_v_out_413031.awb")
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
	Play413031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413031011
		arg_45_1.duration_ = 8.7

		local var_45_0 = {
			zh = 4.3,
			ja = 8.7
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
				arg_45_0:Play413031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10022 = arg_45_1.actors_["10022"].transform.localPosition
				arg_45_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10022", 3)

				for iter_48_0 = 0, arg_45_1.actors_["10022"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["10022"].transform:GetChild(iter_48_0)

					if var_48_0.name == "split_3" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_48_2 = arg_45_1.actors_["10094"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10094 = var_48_2.localPosition
				var_48_2.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10094", 0)

				for iter_48_1 = 0, var_48_2.childCount - 1 do
					local var_48_3 = var_48_2:GetChild(iter_48_1)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_2.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_45_1.time_ - 0) / var_48_4)
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_2.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_48_5 = arg_45_1.actors_["10022"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10022 == nil then
				arg_45_1.var_.actorSpriteComps10022 = var_48_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.actorSpriteComps10022 then
					for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_48_3 then
							if arg_45_1.isInRecall_ then
								iter_48_3.color = Color.New(Mathf.Lerp(iter_48_3.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_6), Mathf.Lerp(iter_48_3.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_6), (Mathf.Lerp(iter_48_3.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_6)))
							else
								local var_48_7 = Mathf.Lerp(iter_48_3.color.r, 1, (arg_45_1.time_ - 0) / var_48_6)

								iter_48_3.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10022 then
				for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_48_5 then
						iter_48_5.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10022 = nil
			end

			local var_48_8 = arg_45_1.actors_["10094"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10094 == nil then
				arg_45_1.var_.actorSpriteComps10094 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_9 and not isNil(var_48_8) then
				if arg_45_1.var_.actorSpriteComps10094 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_48_7 then
							if arg_45_1.isInRecall_ then
								iter_48_7.color = Color.New(Mathf.Lerp(iter_48_7.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_9), Mathf.Lerp(iter_48_7.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_9), (Mathf.Lerp(iter_48_7.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_9)))
							else
								local var_48_10 = Mathf.Lerp(iter_48_7.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_9)

								iter_48_7.color = Color.New(var_48_10, var_48_10, var_48_10)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_9 and arg_45_1.time_ < 0 + var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10094 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_48_9 then
						iter_48_9.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10094 = nil
			end

			local var_48_11 = 0
			local var_48_12 = 0.5

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(413031011)
				local var_48_14 = arg_45_1:FormatText(var_48_13.content)

				arg_45_1.text_.text = var_48_14

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 20 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_14) / 20)

				if (20 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_14) / 20)) > 0 and var_48_12 < var_48_16 then
					arg_45_1.talkMaxDuration = var_48_16

					if var_48_16 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_14
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031011", "story_v_out_413031.awb") ~= 0 then
					local var_48_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031011", "story_v_out_413031.awb") / 1000

					if var_48_17 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_11
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_413031", "413031011", "story_v_out_413031.awb")

						arg_45_1:RecordAudio("413031011", var_48_18)
						arg_45_1:RecordAudio("413031011", var_48_18)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413031", "413031011", "story_v_out_413031.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413031", "413031011", "story_v_out_413031.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_19 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_19 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_19

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_19 and arg_45_1.time_ < var_48_11 + var_48_19 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play413031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413031012
		arg_49_1.duration_ = 3.6

		local var_49_0 = {
			zh = 3.6,
			ja = 2.633
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
				arg_49_0:Play413031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10022"]) and arg_49_1.var_.actorSpriteComps10022 == nil then
				arg_49_1.var_.actorSpriteComps10022 = arg_49_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10022"]) then
				if arg_49_1.var_.actorSpriteComps10022 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10022"]) and arg_49_1.var_.actorSpriteComps10022 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10022 = nil
			end

			local var_52_2 = 0
			local var_52_3 = 0.225

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_4 = arg_49_1:GetWordFromCfg(413031012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 9 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 9)

				if (9 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 9)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031012", "story_v_out_413031.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031012", "story_v_out_413031.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_413031", "413031012", "story_v_out_413031.awb")

						arg_49_1:RecordAudio("413031012", var_52_9)
						arg_49_1:RecordAudio("413031012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413031", "413031012", "story_v_out_413031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413031", "413031012", "story_v_out_413031.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play413031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413031013
		arg_53_1.duration_ = 3.63

		local var_53_0 = {
			zh = 2.233,
			ja = 3.633
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
				arg_53_0:Play413031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10092 = arg_53_1.actors_["10092"].transform.localPosition
				arg_53_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10092", 3)

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
				arg_53_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_56_2 = arg_53_1.actors_["10092"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10092 == nil then
				arg_53_1.var_.actorSpriteComps10092 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps10092 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_56_2 then
							if arg_53_1.isInRecall_ then
								iter_56_2.color = Color.New(Mathf.Lerp(iter_56_2.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_3), Mathf.Lerp(iter_56_2.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_3), (Mathf.Lerp(iter_56_2.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_3)))
							else
								local var_56_4 = Mathf.Lerp(iter_56_2.color.r, 1, (arg_53_1.time_ - 0) / var_56_3)

								iter_56_2.color = Color.New(var_56_4, var_56_4, var_56_4)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10092 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_56_4 then
						iter_56_4.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10092 = nil
			end

			local var_56_5 = 0
			local var_56_6 = 0.225

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(413031013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 9 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 9)

				if (9 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 9)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031013", "story_v_out_413031.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031013", "story_v_out_413031.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_413031", "413031013", "story_v_out_413031.awb")

						arg_53_1:RecordAudio("413031013", var_56_12)
						arg_53_1:RecordAudio("413031013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413031", "413031013", "story_v_out_413031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413031", "413031013", "story_v_out_413031.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_13 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_13

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_13 and arg_53_1.time_ < var_56_5 + var_56_13 + arg_56_0 then
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
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play413031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413031014
		arg_57_1.duration_ = 4.17

		local var_57_0 = {
			zh = 4.166,
			ja = 2.5
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
				arg_57_0:Play413031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10092"]) and arg_57_1.var_.actorSpriteComps10092 == nil then
				arg_57_1.var_.actorSpriteComps10092 = arg_57_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10092"]) then
				if arg_57_1.var_.actorSpriteComps10092 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10092"]) and arg_57_1.var_.actorSpriteComps10092 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10092 = nil
			end

			local var_60_2 = 0
			local var_60_3 = 0.325

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_4 = arg_57_1:GetWordFromCfg(413031014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 13 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 13)

				if (13 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 13)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031014", "story_v_out_413031.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031014", "story_v_out_413031.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_413031", "413031014", "story_v_out_413031.awb")

						arg_57_1:RecordAudio("413031014", var_60_9)
						arg_57_1:RecordAudio("413031014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413031", "413031014", "story_v_out_413031.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413031", "413031014", "story_v_out_413031.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play413031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413031015
		arg_61_1.duration_ = 14.57

		local var_61_0 = {
			zh = 10.733,
			ja = 14.566
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
				arg_61_0:Play413031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10092"]) and arg_61_1.var_.actorSpriteComps10092 == nil then
				arg_61_1.var_.actorSpriteComps10092 = arg_61_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10092"]) then
				if arg_61_1.var_.actorSpriteComps10092 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10092"]) and arg_61_1.var_.actorSpriteComps10092 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10092 = nil
			end

			local var_64_2 = 0
			local var_64_3 = 1.2

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(413031015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 48 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 48)

				if (48 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 48)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031015", "story_v_out_413031.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031015", "story_v_out_413031.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_413031", "413031015", "story_v_out_413031.awb")

						arg_61_1:RecordAudio("413031015", var_64_9)
						arg_61_1:RecordAudio("413031015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413031", "413031015", "story_v_out_413031.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413031", "413031015", "story_v_out_413031.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play413031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413031016
		arg_65_1.duration_ = 5.83

		local var_65_0 = {
			zh = 5.833,
			ja = 3.533
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
				arg_65_0:Play413031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10092"]) and arg_65_1.var_.actorSpriteComps10092 == nil then
				arg_65_1.var_.actorSpriteComps10092 = arg_65_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10092"]) then
				if arg_65_1.var_.actorSpriteComps10092 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10092"]) and arg_65_1.var_.actorSpriteComps10092 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps10092 = nil
			end

			local var_68_2 = 0
			local var_68_3 = 0.475

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_4 = arg_65_1:GetWordFromCfg(413031016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 20 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 20)

				if (20 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 20)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031016", "story_v_out_413031.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031016", "story_v_out_413031.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_413031", "413031016", "story_v_out_413031.awb")

						arg_65_1:RecordAudio("413031016", var_68_9)
						arg_65_1:RecordAudio("413031016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413031", "413031016", "story_v_out_413031.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413031", "413031016", "story_v_out_413031.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play413031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413031017
		arg_69_1.duration_ = 3.8

		local var_69_0 = {
			zh = 3,
			ja = 3.8
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
				arg_69_0:Play413031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10092 = arg_69_1.actors_["10092"].transform.localPosition
				arg_69_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10092", 3)

				for iter_72_0 = 0, arg_69_1.actors_["10092"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10092"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_1_1" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_72_2 = arg_69_1.actors_["10092"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10092 == nil then
				arg_69_1.var_.actorSpriteComps10092 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps10092 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								iter_72_2.color = Color.New(Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_2.color.r, 1, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_2.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10092 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_72_4 then
						iter_72_4.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10092 = nil
			end

			local var_72_5 = 0
			local var_72_6 = 0.325

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:GetWordFromCfg(413031017)
				local var_72_8 = arg_69_1:FormatText(var_72_7.content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 13 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 13)

				if (13 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 13)) > 0 and var_72_6 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031017", "story_v_out_413031.awb") ~= 0 then
					local var_72_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031017", "story_v_out_413031.awb") / 1000

					if var_72_11 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_5
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_413031", "413031017", "story_v_out_413031.awb")

						arg_69_1:RecordAudio("413031017", var_72_12)
						arg_69_1:RecordAudio("413031017", var_72_12)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413031", "413031017", "story_v_out_413031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413031", "413031017", "story_v_out_413031.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_13 and arg_69_1.time_ < var_72_5 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play413031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413031018
		arg_73_1.duration_ = 11.03

		local var_73_0 = {
			zh = 9.533,
			ja = 11.033
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
				arg_73_0:Play413031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10092"]) and arg_73_1.var_.actorSpriteComps10092 == nil then
				arg_73_1.var_.actorSpriteComps10092 = arg_73_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10092"]) then
				if arg_73_1.var_.actorSpriteComps10092 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10092"]) and arg_73_1.var_.actorSpriteComps10092 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10092 = nil
			end

			local var_76_2 = 0
			local var_76_3 = 1

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_4 = arg_73_1:GetWordFromCfg(413031018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 40 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 40)

				if (40 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 40)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031018", "story_v_out_413031.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031018", "story_v_out_413031.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_413031", "413031018", "story_v_out_413031.awb")

						arg_73_1:RecordAudio("413031018", var_76_9)
						arg_73_1:RecordAudio("413031018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413031", "413031018", "story_v_out_413031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413031", "413031018", "story_v_out_413031.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play413031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413031019
		arg_77_1.duration_ = 12.8

		local var_77_0 = {
			zh = 10.565999999999,
			ja = 12.799999999999
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
				arg_77_0:Play413031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.bgs_.F08i == nil then
				local var_80_0 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08i")
				var_80_0.name = "F08i"
				var_80_0.transform.parent = arg_77_1.stage_.transform
				var_80_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_.F08i = var_80_0
			end

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= 2 + arg_80_0 then
				local var_80_1 = arg_77_1.bgs_.F08i

				arg_77_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_80_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_2 = var_80_1:GetComponent("SpriteRenderer")

				if var_80_2 and var_80_2.sprite then
					local var_80_3 = 2 * (var_80_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_80_1.transform.localScale = Vector3.New(var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "F08i" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_4 = 3.999999999999

			if 3.999999999999 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			if arg_77_1.time_ >= var_80_4 + 0.3 and arg_77_1.time_ < var_80_4 + 0.3 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			local var_80_5 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_6 = 2

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 then
				local var_80_7 = Color.New(0, 0, 0)

				var_80_7.a = Mathf.Lerp(0, 1, (arg_77_1.time_ - var_80_5) / var_80_6)
				arg_77_1.mask_.color = var_80_7
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 then
				local var_80_8 = Color.New(0, 0, 0)

				var_80_8.a = 1
				arg_77_1.mask_.color = var_80_8
			end

			local var_80_9 = 2

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_10 = 2

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 then
				local var_80_11 = Color.New(0, 0, 0)

				var_80_11.a = Mathf.Lerp(1, 0, (arg_77_1.time_ - var_80_9) / var_80_10)
				arg_77_1.mask_.color = var_80_11
			end

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 then
				local var_80_12 = Color.New(0, 0, 0)

				arg_77_1.mask_.enabled = false
				var_80_12.a = 0
				arg_77_1.mask_.color = var_80_12
			end

			local var_80_13 = arg_77_1.actors_["10092"].transform

			if 1.966 < arg_77_1.time_ and arg_77_1.time_ <= 1.966 + arg_80_0 then
				arg_77_1.var_.moveOldPos10092 = var_80_13.localPosition
				var_80_13.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10092", 0)

				for iter_80_2 = 0, var_80_13.childCount - 1 do
					local var_80_14 = var_80_13:GetChild(iter_80_2)

					if var_80_14.name == "" or not string.find(var_80_14.name, "split") then
						var_80_14.gameObject:SetActive(true)
					else
						var_80_14.gameObject:SetActive(false)
					end
				end
			end

			local var_80_15 = 0.001

			if 1.966 <= arg_77_1.time_ and arg_77_1.time_ < 1.966 + var_80_15 then
				var_80_13.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_77_1.time_ - 1.966) / var_80_15)
			end

			if arg_77_1.time_ >= 1.966 + var_80_15 and arg_77_1.time_ < 1.966 + var_80_15 + arg_80_0 then
				var_80_13.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_80_16 = arg_77_1.actors_["10093"].transform

			if 3.8 < arg_77_1.time_ and arg_77_1.time_ <= 3.8 + arg_80_0 then
				arg_77_1.var_.moveOldPos10093 = var_80_16.localPosition
				var_80_16.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10093", 3)

				for iter_80_3 = 0, var_80_16.childCount - 1 do
					local var_80_17 = var_80_16:GetChild(iter_80_3)

					if var_80_17.name == "" or not string.find(var_80_17.name, "split") then
						var_80_17.gameObject:SetActive(true)
					else
						var_80_17.gameObject:SetActive(false)
					end
				end
			end

			local var_80_18 = 0.001

			if 3.8 <= arg_77_1.time_ and arg_77_1.time_ < 3.8 + var_80_18 then
				var_80_16.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_77_1.time_ - 3.8) / var_80_18)
			end

			if arg_77_1.time_ >= 3.8 + var_80_18 and arg_77_1.time_ < 3.8 + var_80_18 + arg_80_0 then
				var_80_16.localPosition = Vector3.New(0, -345, -245)
			end

			local var_80_19 = arg_77_1.actors_["10092"]

			if 1.966 < arg_77_1.time_ and arg_77_1.time_ <= 1.966 + arg_80_0 and not isNil(var_80_19) and arg_77_1.var_.actorSpriteComps10092 == nil then
				arg_77_1.var_.actorSpriteComps10092 = var_80_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_20 = 0.034

			if 1.966 <= arg_77_1.time_ and arg_77_1.time_ < 1.966 + var_80_20 and not isNil(var_80_19) then
				if arg_77_1.var_.actorSpriteComps10092 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								iter_80_5.color = Color.New(Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 1.966) / var_80_20), Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 1.966) / var_80_20), (Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 1.966) / var_80_20)))
							else
								local var_80_21 = Mathf.Lerp(iter_80_5.color.r, 0.5, (arg_77_1.time_ - 1.966) / var_80_20)

								iter_80_5.color = Color.New(var_80_21, var_80_21, var_80_21)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 1.966 + var_80_20 and arg_77_1.time_ < 1.966 + var_80_20 + arg_80_0 and not isNil(var_80_19) and arg_77_1.var_.actorSpriteComps10092 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_80_7 then
						iter_80_7.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10092 = nil
			end

			local var_80_22 = arg_77_1.actors_["10093"]

			if 3.8 < arg_77_1.time_ and arg_77_1.time_ <= 3.8 + arg_80_0 and not isNil(var_80_22) and arg_77_1.var_.actorSpriteComps10093 == nil then
				arg_77_1.var_.actorSpriteComps10093 = var_80_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_23 = 0.034

			if 3.8 <= arg_77_1.time_ and arg_77_1.time_ < 3.8 + var_80_23 and not isNil(var_80_22) then
				if arg_77_1.var_.actorSpriteComps10093 then
					for iter_80_8, iter_80_9 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_80_9 then
							if arg_77_1.isInRecall_ then
								iter_80_9.color = Color.New(Mathf.Lerp(iter_80_9.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 3.8) / var_80_23), Mathf.Lerp(iter_80_9.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 3.8) / var_80_23), (Mathf.Lerp(iter_80_9.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 3.8) / var_80_23)))
							else
								local var_80_24 = Mathf.Lerp(iter_80_9.color.r, 1, (arg_77_1.time_ - 3.8) / var_80_23)

								iter_80_9.color = Color.New(var_80_24, var_80_24, var_80_24)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 3.8 + var_80_23 and arg_77_1.time_ < 3.8 + var_80_23 + arg_80_0 and not isNil(var_80_22) and arg_77_1.var_.actorSpriteComps10093 then
				for iter_80_10, iter_80_11 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_80_11 then
						iter_80_11.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10093 = nil
			end

			if 3.799999999999 < arg_77_1.time_ and arg_77_1.time_ <= 3.799999999999 + arg_80_0 then
				local var_80_25 = arg_77_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_80_25 then
					arg_77_1.var_.alphaOldValue10093 = var_80_25.alpha
					arg_77_1.var_.characterEffect10093 = var_80_25
				end

				arg_77_1.var_.alphaOldValue10093 = 0
			end

			local var_80_26 = 0.2

			if 3.799999999999 <= arg_77_1.time_ and arg_77_1.time_ < 3.799999999999 + var_80_26 then
				if arg_77_1.var_.characterEffect10093 then
					arg_77_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_77_1.var_.alphaOldValue10093, 1, (arg_77_1.time_ - 3.799999999999) / var_80_26)
				end
			end

			if arg_77_1.time_ >= 3.799999999999 + var_80_26 and arg_77_1.time_ < 3.799999999999 + var_80_26 + arg_80_0 and arg_77_1.var_.characterEffect10093 then
				arg_77_1.var_.characterEffect10093.alpha = 1
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_80_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_77_1.bgmTxt_.text ~= var_80_29 and arg_77_1.bgmTxt_.text ~= "" then
						if arg_77_1.bgmTxt2_.text ~= "" then
							arg_77_1.bgmTxt_.text = arg_77_1.bgmTxt2_.text
						end

						arg_77_1.bgmTxt2_.text = var_80_29

						arg_77_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_77_1.bgmTxt_.text = var_80_29
						arg_77_1.bgmTxt2_.text = var_80_29
					end

					if arg_77_1.bgmTimer then
						arg_77_1.bgmTimer:Stop()

						arg_77_1.bgmTimer = nil
					end

					if arg_77_1.settingData.show_music_name == 1 then
						arg_77_1.musicController:SetSelectedState("show")
						arg_77_1.musicAnimator_:Play("open", 0, 0)

						if arg_77_1.settingData.music_time ~= 0 then
							arg_77_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_77_1.settingData.music_time), function()
								if arg_77_1 == nil or isNil(arg_77_1.bgmTxt_) then
									return
								end

								arg_77_1.musicController:SetSelectedState("hide")
								arg_77_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= 2 + arg_80_0 then
				arg_77_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_80_32 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_77_1.bgmTxt_.text ~= var_80_32 and arg_77_1.bgmTxt_.text ~= "" then
						if arg_77_1.bgmTxt2_.text ~= "" then
							arg_77_1.bgmTxt_.text = arg_77_1.bgmTxt2_.text
						end

						arg_77_1.bgmTxt2_.text = var_80_32

						arg_77_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_77_1.bgmTxt_.text = var_80_32
						arg_77_1.bgmTxt2_.text = var_80_32
					end

					if arg_77_1.bgmTimer then
						arg_77_1.bgmTimer:Stop()

						arg_77_1.bgmTimer = nil
					end

					if arg_77_1.settingData.show_music_name == 1 then
						arg_77_1.musicController:SetSelectedState("show")
						arg_77_1.musicAnimator_:Play("open", 0, 0)

						if arg_77_1.settingData.music_time ~= 0 then
							arg_77_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_77_1.settingData.music_time), function()
								if arg_77_1 == nil or isNil(arg_77_1.bgmTxt_) then
									return
								end

								arg_77_1.musicController:SetSelectedState("hide")
								arg_77_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_33 = 3.999999999999
			local var_80_34 = 0.8

			if 3.999999999999 < arg_77_1.time_ and arg_77_1.time_ <= var_80_33 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_35 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_35:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_77_1.dialogCg_.alpha = arg_83_0
				end))
				var_80_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_36 = arg_77_1:GetWordFromCfg(413031019)
				local var_80_37 = arg_77_1:FormatText(var_80_36.content)

				arg_77_1.text_.text = var_80_37

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_39 = 32 <= 0 and var_80_34 or var_80_34 * (utf8.len(var_80_37) / 32)

				if (32 <= 0 and var_80_34 or var_80_34 * (utf8.len(var_80_37) / 32)) > 0 and var_80_34 < var_80_39 then
					arg_77_1.talkMaxDuration = var_80_39
					var_80_33 = var_80_33 + 0.3

					if var_80_39 + var_80_33 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_39 + var_80_33
					end
				end

				arg_77_1.text_.text = var_80_37
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031019", "story_v_out_413031.awb") ~= 0 then
					local var_80_40 = manager.audio:GetVoiceLength("story_v_out_413031", "413031019", "story_v_out_413031.awb") / 1000

					if var_80_40 + var_80_33 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_40 + var_80_33
					end

					if var_80_36.prefab_name ~= "" and arg_77_1.actors_[var_80_36.prefab_name] ~= nil then
						local var_80_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_36.prefab_name].transform, "story_v_out_413031", "413031019", "story_v_out_413031.awb")

						arg_77_1:RecordAudio("413031019", var_80_41)
						arg_77_1:RecordAudio("413031019", var_80_41)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413031", "413031019", "story_v_out_413031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413031", "413031019", "story_v_out_413031.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_42 = var_80_33 + 0.3
			local var_80_43 = math.max(var_80_34, arg_77_1.talkMaxDuration)

			if var_80_33 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_42 + var_80_43 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_42) / var_80_43

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_42 + var_80_43 and arg_77_1.time_ < var_80_42 + var_80_43 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play413031020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413031020
		arg_85_1.duration_ = 6.83

		local var_85_0 = {
			zh = 4.466,
			ja = 6.833
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
				arg_85_0:Play413031021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.625

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(413031020)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 25 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 25)

				if (25 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 25)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031020", "story_v_out_413031.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031020", "story_v_out_413031.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_413031", "413031020", "story_v_out_413031.awb")

						arg_85_1:RecordAudio("413031020", var_88_6)
						arg_85_1:RecordAudio("413031020", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413031", "413031020", "story_v_out_413031.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413031", "413031020", "story_v_out_413031.awb")
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
	Play413031021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413031021
		arg_89_1.duration_ = 7.57

		local var_89_0 = {
			zh = 7.566,
			ja = 2.966
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
				arg_89_0:Play413031022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10093 = arg_89_1.actors_["10093"].transform.localPosition
				arg_89_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10093", 3)

				for iter_92_0 = 0, arg_89_1.actors_["10093"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["10093"].transform:GetChild(iter_92_0)

					if var_92_0.name == "split_5" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_92_2 = arg_89_1.actors_["10093"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.shakeOldPos10093 = var_92_2.localPosition
			end

			local var_92_3 = 0.6

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 then
				local var_92_4, var_92_5 = math.modf((arg_89_1.time_ - 0) / 0.066)

				var_92_2.localPosition = Vector3.New(var_92_5 * 0.13, var_92_5 * 0.13, var_92_5 * 0.13) + arg_89_1.var_.shakeOldPos10093
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 then
				var_92_2.localPosition = arg_89_1.var_.shakeOldPos10093
			end

			local var_92_6 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			if arg_89_1.time_ >= var_92_6 + 0.6 and arg_89_1.time_ < var_92_6 + 0.6 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_7 = 0
			local var_92_8 = 0.475

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_9 = arg_89_1:GetWordFromCfg(413031021)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_12 = 19 <= 0 and var_92_8 or var_92_8 * (utf8.len(var_92_10) / 19)

				if (19 <= 0 and var_92_8 or var_92_8 * (utf8.len(var_92_10) / 19)) > 0 and var_92_8 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_7 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_7
					end
				end

				arg_89_1.text_.text = var_92_10
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031021", "story_v_out_413031.awb") ~= 0 then
					local var_92_13 = manager.audio:GetVoiceLength("story_v_out_413031", "413031021", "story_v_out_413031.awb") / 1000

					if var_92_13 + var_92_7 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_7
					end

					if var_92_9.prefab_name ~= "" and arg_89_1.actors_[var_92_9.prefab_name] ~= nil then
						local var_92_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_9.prefab_name].transform, "story_v_out_413031", "413031021", "story_v_out_413031.awb")

						arg_89_1:RecordAudio("413031021", var_92_14)
						arg_89_1:RecordAudio("413031021", var_92_14)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413031", "413031021", "story_v_out_413031.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413031", "413031021", "story_v_out_413031.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_15 = math.max(var_92_8, arg_89_1.talkMaxDuration)

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_15 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_7) / var_92_15

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_7 + var_92_15 and arg_89_1.time_ < var_92_7 + var_92_15 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play413031022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413031022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play413031023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10093 = arg_93_1.actors_["10093"].transform.localPosition
				arg_93_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10093", 7)

				for iter_96_0 = 0, arg_93_1.actors_["10093"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["10093"].transform:GetChild(iter_96_0)

					if var_96_0.name == "split_4" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_96_2 = arg_93_1.actors_["10093"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps10093 == nil then
				arg_93_1.var_.actorSpriteComps10093 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps10093 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								iter_96_2.color = Color.New(Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_3), Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_3), (Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_3)))
							else
								local var_96_4 = Mathf.Lerp(iter_96_2.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_3)

								iter_96_2.color = Color.New(var_96_4, var_96_4, var_96_4)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps10093 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_96_4 then
						iter_96_4.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10093 = nil
			end

			local var_96_5 = 0
			local var_96_6 = 1.75

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_7 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(413031022).content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 70 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_7) / 70)

				if (70 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_7) / 70)) > 0 and var_96_6 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_6, arg_93_1.talkMaxDuration)

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_5) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_5 + var_96_10 and arg_93_1.time_ < var_96_5 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play413031023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413031023
		arg_97_1.duration_ = 5.8

		local var_97_0 = {
			zh = 4.1,
			ja = 5.8
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
				arg_97_0:Play413031024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10093 = arg_97_1.actors_["10093"].transform.localPosition
				arg_97_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10093", 3)

				for iter_100_0 = 0, arg_97_1.actors_["10093"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["10093"].transform:GetChild(iter_100_0)

					if var_100_0.name == "split_3" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_100_2 = arg_97_1.actors_["10093"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10093 == nil then
				arg_97_1.var_.actorSpriteComps10093 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps10093 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_100_2 then
							if arg_97_1.isInRecall_ then
								iter_100_2.color = Color.New(Mathf.Lerp(iter_100_2.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_2.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_2.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_2.color.r, 1, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_2.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10093 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_100_4 then
						iter_100_4.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps10093 = nil
			end

			local var_100_5 = 0
			local var_100_6 = 0.425

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
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

				local var_100_7 = arg_97_1:GetWordFromCfg(413031023)
				local var_100_8 = arg_97_1:FormatText(var_100_7.content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 17 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 17)

				if (17 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 17)) > 0 and var_100_6 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031023", "story_v_out_413031.awb") ~= 0 then
					local var_100_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031023", "story_v_out_413031.awb") / 1000

					if var_100_11 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_5
					end

					if var_100_7.prefab_name ~= "" and arg_97_1.actors_[var_100_7.prefab_name] ~= nil then
						local var_100_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_7.prefab_name].transform, "story_v_out_413031", "413031023", "story_v_out_413031.awb")

						arg_97_1:RecordAudio("413031023", var_100_12)
						arg_97_1:RecordAudio("413031023", var_100_12)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413031", "413031023", "story_v_out_413031.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413031", "413031023", "story_v_out_413031.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_13 and arg_97_1.time_ < var_100_5 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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
	Play413031024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413031024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413031025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10093 = arg_101_1.actors_["10093"].transform.localPosition
				arg_101_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10093", 3)

				for iter_104_0 = 0, arg_101_1.actors_["10093"].transform.childCount - 1 do
					local var_104_0 = arg_101_1.actors_["10093"].transform:GetChild(iter_104_0)

					if var_104_0.name == "" or not string.find(var_104_0.name, "split") then
						var_104_0.gameObject:SetActive(true)
					else
						var_104_0.gameObject:SetActive(false)
					end
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_104_2 = arg_101_1.actors_["10093"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10093 == nil then
				arg_101_1.var_.actorSpriteComps10093 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps10093 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								iter_104_2.color = Color.New(Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_2.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_2.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10093 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_104_4 then
						iter_104_4.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10093 = nil
			end

			local var_104_5 = 0
			local var_104_6 = 1.2

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_7 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(413031024).content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 48 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_7) / 48)

				if (48 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_7) / 48)) > 0 and var_104_6 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_5
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_6, arg_101_1.talkMaxDuration)

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_5) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_5 + var_104_10 and arg_101_1.time_ < var_104_5 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play413031025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413031025
		arg_105_1.duration_ = 2.33

		local var_105_0 = {
			zh = 2.333,
			ja = 2.233
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
				arg_105_0:Play413031026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10093 = arg_105_1.actors_["10093"].transform.localPosition
				arg_105_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10093", 3)

				for iter_108_0 = 0, arg_105_1.actors_["10093"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["10093"].transform:GetChild(iter_108_0)

					if var_108_0.name == "split_5" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_108_2 = arg_105_1.actors_["10093"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10093 == nil then
				arg_105_1.var_.actorSpriteComps10093 = var_108_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_3 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.actorSpriteComps10093 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_108_2 then
							if arg_105_1.isInRecall_ then
								iter_108_2.color = Color.New(Mathf.Lerp(iter_108_2.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_3), Mathf.Lerp(iter_108_2.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_3), (Mathf.Lerp(iter_108_2.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_3)))
							else
								local var_108_4 = Mathf.Lerp(iter_108_2.color.r, 1, (arg_105_1.time_ - 0) / var_108_3)

								iter_108_2.color = Color.New(var_108_4, var_108_4, var_108_4)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10093 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_108_4 then
						iter_108_4.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10093 = nil
			end

			local var_108_5 = 0
			local var_108_6 = 0.2

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_7 = arg_105_1:GetWordFromCfg(413031025)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 8 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 8)

				if (8 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 8)) > 0 and var_108_6 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10

					if var_108_10 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031025", "story_v_out_413031.awb") ~= 0 then
					local var_108_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031025", "story_v_out_413031.awb") / 1000

					if var_108_11 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_5
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_out_413031", "413031025", "story_v_out_413031.awb")

						arg_105_1:RecordAudio("413031025", var_108_12)
						arg_105_1:RecordAudio("413031025", var_108_12)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413031", "413031025", "story_v_out_413031.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413031", "413031025", "story_v_out_413031.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = math.max(var_108_6, arg_105_1.talkMaxDuration)

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_13 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_5) / var_108_13

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_5 + var_108_13 and arg_105_1.time_ < var_108_5 + var_108_13 + arg_108_0 then
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
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play413031026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413031026
		arg_109_1.duration_ = 1.5

		local var_109_0 = {
			zh = 1.5,
			ja = 1.2
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
				arg_109_0:Play413031027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.15

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(413031026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 6 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 6)

				if (6 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 6)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031026", "story_v_out_413031.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031026", "story_v_out_413031.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_413031", "413031026", "story_v_out_413031.awb")

						arg_109_1:RecordAudio("413031026", var_112_6)
						arg_109_1:RecordAudio("413031026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413031", "413031026", "story_v_out_413031.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413031", "413031026", "story_v_out_413031.awb")
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
	Play413031027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413031027
		arg_113_1.duration_ = 8.87

		local var_113_0 = {
			zh = 8.3,
			ja = 8.866
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
				arg_113_0:Play413031028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if arg_113_1.bgs_.F08f == nil then
				local var_116_0 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08f")
				var_116_0.name = "F08f"
				var_116_0.transform.parent = arg_113_1.stage_.transform
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_.F08f = var_116_0
			end

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				local var_116_1 = arg_113_1.bgs_.F08f

				arg_113_1.bgs_.F08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_2 = var_116_1:GetComponent("SpriteRenderer")

				if var_116_2 and var_116_2.sprite then
					local var_116_3 = 2 * (var_116_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_1.transform.localScale = Vector3.New(var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "F08f" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_4 = 3.999999999999

			if 3.999999999999 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= var_116_4 + 0.3 and arg_113_1.time_ < var_116_4 + 0.3 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			local var_116_5 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_6 = 2

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_6 then
				local var_116_7 = Color.New(0, 0, 0)

				var_116_7.a = Mathf.Lerp(0, 1, (arg_113_1.time_ - var_116_5) / var_116_6)
				arg_113_1.mask_.color = var_116_7
			end

			if arg_113_1.time_ >= var_116_5 + var_116_6 and arg_113_1.time_ < var_116_5 + var_116_6 + arg_116_0 then
				local var_116_8 = Color.New(0, 0, 0)

				var_116_8.a = 1
				arg_113_1.mask_.color = var_116_8
			end

			local var_116_9 = 2

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_10 = 2

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 then
				local var_116_11 = Color.New(0, 0, 0)

				var_116_11.a = Mathf.Lerp(1, 0, (arg_113_1.time_ - var_116_9) / var_116_10)
				arg_113_1.mask_.color = var_116_11
			end

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 then
				local var_116_12 = Color.New(0, 0, 0)

				arg_113_1.mask_.enabled = false
				var_116_12.a = 0
				arg_113_1.mask_.color = var_116_12
			end

			local var_116_13 = arg_113_1.actors_["10093"].transform

			if 1.966 < arg_113_1.time_ and arg_113_1.time_ <= 1.966 + arg_116_0 then
				arg_113_1.var_.moveOldPos10093 = var_116_13.localPosition
				var_116_13.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10093", 0)

				for iter_116_2 = 0, var_116_13.childCount - 1 do
					local var_116_14 = var_116_13:GetChild(iter_116_2)

					if var_116_14.name == "" or not string.find(var_116_14.name, "split") then
						var_116_14.gameObject:SetActive(true)
					else
						var_116_14.gameObject:SetActive(false)
					end
				end
			end

			local var_116_15 = 0.001

			if 1.966 <= arg_113_1.time_ and arg_113_1.time_ < 1.966 + var_116_15 then
				var_116_13.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10093, Vector3.New(-5000, -345, -245), (arg_113_1.time_ - 1.966) / var_116_15)
			end

			if arg_113_1.time_ >= 1.966 + var_116_15 and arg_113_1.time_ < 1.966 + var_116_15 + arg_116_0 then
				var_116_13.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_116_16 = arg_113_1.actors_["10093"]

			if 1.966 < arg_113_1.time_ and arg_113_1.time_ <= 1.966 + arg_116_0 and not isNil(var_116_16) and arg_113_1.var_.actorSpriteComps10093 == nil then
				arg_113_1.var_.actorSpriteComps10093 = var_116_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_17 = 0.034

			if 1.966 <= arg_113_1.time_ and arg_113_1.time_ < 1.966 + var_116_17 and not isNil(var_116_16) then
				if arg_113_1.var_.actorSpriteComps10093 then
					for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_116_4 then
							if arg_113_1.isInRecall_ then
								iter_116_4.color = Color.New(Mathf.Lerp(iter_116_4.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 1.966) / var_116_17), Mathf.Lerp(iter_116_4.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 1.966) / var_116_17), (Mathf.Lerp(iter_116_4.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 1.966) / var_116_17)))
							else
								local var_116_18 = Mathf.Lerp(iter_116_4.color.r, 0.5, (arg_113_1.time_ - 1.966) / var_116_17)

								iter_116_4.color = Color.New(var_116_18, var_116_18, var_116_18)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 1.966 + var_116_17 and arg_113_1.time_ < 1.966 + var_116_17 + arg_116_0 and not isNil(var_116_16) and arg_113_1.var_.actorSpriteComps10093 then
				for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_116_6 then
						iter_116_6.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps10093 = nil
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_19 = 4
			local var_116_20 = 0.425

			if 4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_19 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_21 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_21:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_22 = arg_113_1:GetWordFromCfg(413031027)
				local var_116_23 = arg_113_1:FormatText(var_116_22.content)

				arg_113_1.text_.text = var_116_23

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_25 = 17 <= 0 and var_116_20 or var_116_20 * (utf8.len(var_116_23) / 17)

				if (17 <= 0 and var_116_20 or var_116_20 * (utf8.len(var_116_23) / 17)) > 0 and var_116_20 < var_116_25 then
					arg_113_1.talkMaxDuration = var_116_25
					var_116_19 = var_116_19 + 0.3

					if var_116_25 + var_116_19 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_25 + var_116_19
					end
				end

				arg_113_1.text_.text = var_116_23
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031027", "story_v_out_413031.awb") ~= 0 then
					local var_116_26 = manager.audio:GetVoiceLength("story_v_out_413031", "413031027", "story_v_out_413031.awb") / 1000

					if var_116_26 + var_116_19 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_26 + var_116_19
					end

					if var_116_22.prefab_name ~= "" and arg_113_1.actors_[var_116_22.prefab_name] ~= nil then
						local var_116_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_22.prefab_name].transform, "story_v_out_413031", "413031027", "story_v_out_413031.awb")

						arg_113_1:RecordAudio("413031027", var_116_27)
						arg_113_1:RecordAudio("413031027", var_116_27)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413031", "413031027", "story_v_out_413031.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413031", "413031027", "story_v_out_413031.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_28 = var_116_19 + 0.3
			local var_116_29 = math.max(var_116_20, arg_113_1.talkMaxDuration)

			if var_116_19 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_28 + var_116_29 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_28) / var_116_29

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_28 + var_116_29 and arg_113_1.time_ < var_116_28 + var_116_29 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play413031028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413031028
		arg_119_1.duration_ = 7.27

		local var_119_0 = {
			zh = 4.4,
			ja = 7.266
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
				arg_119_0:Play413031029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10022 = arg_119_1.actors_["10022"].transform.localPosition
				arg_119_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10022", 3)

				for iter_122_0 = 0, arg_119_1.actors_["10022"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10022"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_6" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_122_2 = arg_119_1.actors_["10022"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10022 == nil then
				arg_119_1.var_.actorSpriteComps10022 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps10022 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10022 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_122_4 then
						iter_122_4.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10022 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 0.625

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(413031028)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 25 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 25)

				if (25 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 25)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031028", "story_v_out_413031.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031028", "story_v_out_413031.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_413031", "413031028", "story_v_out_413031.awb")

						arg_119_1:RecordAudio("413031028", var_122_12)
						arg_119_1:RecordAudio("413031028", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413031", "413031028", "story_v_out_413031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413031", "413031028", "story_v_out_413031.awb")
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
				actorName = "10022",
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
	Play413031029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413031029
		arg_123_1.duration_ = 13.1

		local var_123_0 = {
			zh = 7.233,
			ja = 13.1
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
				arg_123_0:Play413031030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10022"]) and arg_123_1.var_.actorSpriteComps10022 == nil then
				arg_123_1.var_.actorSpriteComps10022 = arg_123_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10022"]) then
				if arg_123_1.var_.actorSpriteComps10022 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								iter_126_1.color = Color.New(Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_0), Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_0), (Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_0)))
							else
								local var_126_1 = Mathf.Lerp(iter_126_1.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_0)

								iter_126_1.color = Color.New(var_126_1, var_126_1, var_126_1)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10022"]) and arg_123_1.var_.actorSpriteComps10022 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10022 = nil
			end

			local var_126_2 = 0
			local var_126_3 = 0.625

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_4 = arg_123_1:GetWordFromCfg(413031029)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 25 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 25)

				if (25 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 25)) > 0 and var_126_3 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031029", "story_v_out_413031.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031029", "story_v_out_413031.awb") / 1000

					if var_126_8 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_2
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_out_413031", "413031029", "story_v_out_413031.awb")

						arg_123_1:RecordAudio("413031029", var_126_9)
						arg_123_1:RecordAudio("413031029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413031", "413031029", "story_v_out_413031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413031", "413031029", "story_v_out_413031.awb")
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

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play413031030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413031030
		arg_127_1.duration_ = 6.97

		local var_127_0 = {
			zh = 4.4,
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
				arg_127_0:Play413031031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10022"]) and arg_127_1.var_.actorSpriteComps10022 == nil then
				arg_127_1.var_.actorSpriteComps10022 = arg_127_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10022"]) then
				if arg_127_1.var_.actorSpriteComps10022 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								iter_130_1.color = Color.New(Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_0), Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_0), (Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_0)))
							else
								local var_130_1 = Mathf.Lerp(iter_130_1.color.r, 1, (arg_127_1.time_ - 0) / var_130_0)

								iter_130_1.color = Color.New(var_130_1, var_130_1, var_130_1)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10022"]) and arg_127_1.var_.actorSpriteComps10022 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10022 = nil
			end

			local var_130_2 = 0
			local var_130_3 = 0.625

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
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

				local var_130_4 = arg_127_1:GetWordFromCfg(413031030)
				local var_130_5 = arg_127_1:FormatText(var_130_4.content)

				arg_127_1.text_.text = var_130_5

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_7 = 25 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 25)

				if (25 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 25)) > 0 and var_130_3 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_5
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031030", "story_v_out_413031.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031030", "story_v_out_413031.awb") / 1000

					if var_130_8 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_2
					end

					if var_130_4.prefab_name ~= "" and arg_127_1.actors_[var_130_4.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_4.prefab_name].transform, "story_v_out_413031", "413031030", "story_v_out_413031.awb")

						arg_127_1:RecordAudio("413031030", var_130_9)
						arg_127_1:RecordAudio("413031030", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413031", "413031030", "story_v_out_413031.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413031", "413031030", "story_v_out_413031.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_3, arg_127_1.talkMaxDuration)

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_2) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_2 + var_130_10 and arg_127_1.time_ < var_130_2 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play413031031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413031031
		arg_131_1.duration_ = 3.53

		local var_131_0 = {
			zh = 2.4,
			ja = 3.533
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
				arg_131_0:Play413031032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["10022"]) and arg_131_1.var_.actorSpriteComps10022 == nil then
				arg_131_1.var_.actorSpriteComps10022 = arg_131_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["10022"]) then
				if arg_131_1.var_.actorSpriteComps10022 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								iter_134_1.color = Color.New(Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor2.r, (arg_131_1.time_ - 0) / var_134_0), Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor2.g, (arg_131_1.time_ - 0) / var_134_0), (Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor2.b, (arg_131_1.time_ - 0) / var_134_0)))
							else
								local var_134_1 = Mathf.Lerp(iter_134_1.color.r, 0.5, (arg_131_1.time_ - 0) / var_134_0)

								iter_134_1.color = Color.New(var_134_1, var_134_1, var_134_1)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["10022"]) and arg_131_1.var_.actorSpriteComps10022 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps10022 = nil
			end

			local var_134_2 = 0
			local var_134_3 = 0.275

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_4 = arg_131_1:GetWordFromCfg(413031031)
				local var_134_5 = arg_131_1:FormatText(var_134_4.content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 11 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 11)

				if (11 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 11)) > 0 and var_134_3 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031031", "story_v_out_413031.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031031", "story_v_out_413031.awb") / 1000

					if var_134_8 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_2
					end

					if var_134_4.prefab_name ~= "" and arg_131_1.actors_[var_134_4.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_4.prefab_name].transform, "story_v_out_413031", "413031031", "story_v_out_413031.awb")

						arg_131_1:RecordAudio("413031031", var_134_9)
						arg_131_1:RecordAudio("413031031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413031", "413031031", "story_v_out_413031.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413031", "413031031", "story_v_out_413031.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_10 and arg_131_1.time_ < var_134_2 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play413031032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413031032
		arg_135_1.duration_ = 10.2

		local var_135_0 = {
			zh = 8.466,
			ja = 10.2
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
				arg_135_0:Play413031033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10022"]) and arg_135_1.var_.actorSpriteComps10022 == nil then
				arg_135_1.var_.actorSpriteComps10022 = arg_135_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10022"]) then
				if arg_135_1.var_.actorSpriteComps10022 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10022"]) and arg_135_1.var_.actorSpriteComps10022 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10022 = nil
			end

			local var_138_2 = 0
			local var_138_3 = 1.075

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
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

				local var_138_4 = arg_135_1:GetWordFromCfg(413031032)
				local var_138_5 = arg_135_1:FormatText(var_138_4.content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 43 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 43)

				if (43 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 43)) > 0 and var_138_3 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031032", "story_v_out_413031.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031032", "story_v_out_413031.awb") / 1000

					if var_138_8 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_2
					end

					if var_138_4.prefab_name ~= "" and arg_135_1.actors_[var_138_4.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_4.prefab_name].transform, "story_v_out_413031", "413031032", "story_v_out_413031.awb")

						arg_135_1:RecordAudio("413031032", var_138_9)
						arg_135_1:RecordAudio("413031032", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_413031", "413031032", "story_v_out_413031.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_413031", "413031032", "story_v_out_413031.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_10 and arg_135_1.time_ < var_138_2 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play413031033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413031033
		arg_139_1.duration_ = 3.8

		local var_139_0 = {
			zh = 2.5,
			ja = 3.8
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
				arg_139_0:Play413031034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10022"]) and arg_139_1.var_.actorSpriteComps10022 == nil then
				arg_139_1.var_.actorSpriteComps10022 = arg_139_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10022"]) then
				if arg_139_1.var_.actorSpriteComps10022 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10022"]) and arg_139_1.var_.actorSpriteComps10022 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps10022 = nil
			end

			local var_142_2 = 0
			local var_142_3 = 0.225

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_4 = arg_139_1:GetWordFromCfg(413031033)
				local var_142_5 = arg_139_1:FormatText(var_142_4.content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 9 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 9)

				if (9 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 9)) > 0 and var_142_3 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031033", "story_v_out_413031.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031033", "story_v_out_413031.awb") / 1000

					if var_142_8 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_2
					end

					if var_142_4.prefab_name ~= "" and arg_139_1.actors_[var_142_4.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_4.prefab_name].transform, "story_v_out_413031", "413031033", "story_v_out_413031.awb")

						arg_139_1:RecordAudio("413031033", var_142_9)
						arg_139_1:RecordAudio("413031033", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413031", "413031033", "story_v_out_413031.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413031", "413031033", "story_v_out_413031.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_10 and arg_139_1.time_ < var_142_2 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play413031034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413031034
		arg_143_1.duration_ = 5.43

		local var_143_0 = {
			zh = 4,
			ja = 5.433
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
				arg_143_0:Play413031035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.525

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:GetWordFromCfg(413031034)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 21 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 21)

				if (21 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 21)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031034", "story_v_out_413031.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031034", "story_v_out_413031.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_413031", "413031034", "story_v_out_413031.awb")

						arg_143_1:RecordAudio("413031034", var_146_6)
						arg_143_1:RecordAudio("413031034", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413031", "413031034", "story_v_out_413031.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413031", "413031034", "story_v_out_413031.awb")
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
	Play413031035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413031035
		arg_147_1.duration_ = 15.7

		local var_147_0 = {
			zh = 8.2,
			ja = 15.7
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
				arg_147_0:Play413031036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10022"]) and arg_147_1.var_.actorSpriteComps10022 == nil then
				arg_147_1.var_.actorSpriteComps10022 = arg_147_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10022"]) then
				if arg_147_1.var_.actorSpriteComps10022 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10022"]) and arg_147_1.var_.actorSpriteComps10022 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps10022 = nil
			end

			local var_150_2 = 0
			local var_150_3 = 1.125

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(413031035)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 45 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 45)

				if (45 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 45)) > 0 and var_150_3 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031035", "story_v_out_413031.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031035", "story_v_out_413031.awb") / 1000

					if var_150_8 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_2
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_out_413031", "413031035", "story_v_out_413031.awb")

						arg_147_1:RecordAudio("413031035", var_150_9)
						arg_147_1:RecordAudio("413031035", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413031", "413031035", "story_v_out_413031.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413031", "413031035", "story_v_out_413031.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_10 and arg_147_1.time_ < var_150_2 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play413031036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413031036
		arg_151_1.duration_ = 11.2

		local var_151_0 = {
			zh = 8.4,
			ja = 11.2
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
				arg_151_0:Play413031037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10022"]) and arg_151_1.var_.actorSpriteComps10022 == nil then
				arg_151_1.var_.actorSpriteComps10022 = arg_151_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10022"]) then
				if arg_151_1.var_.actorSpriteComps10022 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10022"]) and arg_151_1.var_.actorSpriteComps10022 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10022 = nil
			end

			local var_154_2 = 0
			local var_154_3 = 1.125

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_4 = arg_151_1:GetWordFromCfg(413031036)
				local var_154_5 = arg_151_1:FormatText(var_154_4.content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 45 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 45)

				if (45 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 45)) > 0 and var_154_3 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031036", "story_v_out_413031.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031036", "story_v_out_413031.awb") / 1000

					if var_154_8 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_2
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_out_413031", "413031036", "story_v_out_413031.awb")

						arg_151_1:RecordAudio("413031036", var_154_9)
						arg_151_1:RecordAudio("413031036", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413031", "413031036", "story_v_out_413031.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413031", "413031036", "story_v_out_413031.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_10 and arg_151_1.time_ < var_154_2 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play413031037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 413031037
		arg_155_1.duration_ = 3

		local var_155_0 = {
			zh = 2.566,
			ja = 3
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
				arg_155_0:Play413031038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10022 = arg_155_1.actors_["10022"].transform.localPosition
				arg_155_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10022", 3)

				for iter_158_0 = 0, arg_155_1.actors_["10022"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["10022"].transform:GetChild(iter_158_0)

					if var_158_0.name == "split_2" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_158_2 = arg_155_1.actors_["10022"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10022 == nil then
				arg_155_1.var_.actorSpriteComps10022 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps10022 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10022 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_158_4 then
						iter_158_4.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps10022 = nil
			end

			local var_158_5 = 0
			local var_158_6 = 0.375

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_7 = arg_155_1:GetWordFromCfg(413031037)
				local var_158_8 = arg_155_1:FormatText(var_158_7.content)

				arg_155_1.text_.text = var_158_8

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_10 = 15 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 15)

				if (15 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 15)) > 0 and var_158_6 < var_158_10 then
					arg_155_1.talkMaxDuration = var_158_10

					if var_158_10 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_5
					end
				end

				arg_155_1.text_.text = var_158_8
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031037", "story_v_out_413031.awb") ~= 0 then
					local var_158_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031037", "story_v_out_413031.awb") / 1000

					if var_158_11 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_5
					end

					if var_158_7.prefab_name ~= "" and arg_155_1.actors_[var_158_7.prefab_name] ~= nil then
						local var_158_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_7.prefab_name].transform, "story_v_out_413031", "413031037", "story_v_out_413031.awb")

						arg_155_1:RecordAudio("413031037", var_158_12)
						arg_155_1:RecordAudio("413031037", var_158_12)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_413031", "413031037", "story_v_out_413031.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_413031", "413031037", "story_v_out_413031.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_13 = math.max(var_158_6, arg_155_1.talkMaxDuration)

			if var_158_5 <= arg_155_1.time_ and arg_155_1.time_ < var_158_5 + var_158_13 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_5) / var_158_13

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_5 + var_158_13 and arg_155_1.time_ < var_158_5 + var_158_13 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play413031038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 413031038
		arg_159_1.duration_ = 5.13

		local var_159_0 = {
			zh = 3.033,
			ja = 5.133
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
				arg_159_0:Play413031039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10022"]) and arg_159_1.var_.actorSpriteComps10022 == nil then
				arg_159_1.var_.actorSpriteComps10022 = arg_159_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10022"]) then
				if arg_159_1.var_.actorSpriteComps10022 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								iter_162_1.color = Color.New(Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor2.r, (arg_159_1.time_ - 0) / var_162_0), Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor2.g, (arg_159_1.time_ - 0) / var_162_0), (Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor2.b, (arg_159_1.time_ - 0) / var_162_0)))
							else
								local var_162_1 = Mathf.Lerp(iter_162_1.color.r, 0.5, (arg_159_1.time_ - 0) / var_162_0)

								iter_162_1.color = Color.New(var_162_1, var_162_1, var_162_1)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10022"]) and arg_159_1.var_.actorSpriteComps10022 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps10022 = nil
			end

			local var_162_2 = 0
			local var_162_3 = 0.425

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_4 = arg_159_1:GetWordFromCfg(413031038)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 17 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 17)

				if (17 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 17)) > 0 and var_162_3 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031038", "story_v_out_413031.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031038", "story_v_out_413031.awb") / 1000

					if var_162_8 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_2
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_413031", "413031038", "story_v_out_413031.awb")

						arg_159_1:RecordAudio("413031038", var_162_9)
						arg_159_1:RecordAudio("413031038", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413031", "413031038", "story_v_out_413031.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413031", "413031038", "story_v_out_413031.awb")
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

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play413031039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413031039
		arg_163_1.duration_ = 10.37

		local var_163_0 = {
			zh = 7.066,
			ja = 10.366
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
				arg_163_0:Play413031040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10022 = arg_163_1.actors_["10022"].transform.localPosition
				arg_163_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10022", 3)

				for iter_166_0 = 0, arg_163_1.actors_["10022"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["10022"].transform:GetChild(iter_166_0)

					if var_166_0.name == "split_3" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_166_2 = arg_163_1.actors_["10022"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10022 == nil then
				arg_163_1.var_.actorSpriteComps10022 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps10022 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10022 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_166_4 then
						iter_166_4.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10022 = nil
			end

			local var_166_5 = 0
			local var_166_6 = 0.875

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_7 = arg_163_1:GetWordFromCfg(413031039)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 35 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 35)

				if (35 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 35)) > 0 and var_166_6 < var_166_10 then
					arg_163_1.talkMaxDuration = var_166_10

					if var_166_10 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031039", "story_v_out_413031.awb") ~= 0 then
					local var_166_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031039", "story_v_out_413031.awb") / 1000

					if var_166_11 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_5
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_out_413031", "413031039", "story_v_out_413031.awb")

						arg_163_1:RecordAudio("413031039", var_166_12)
						arg_163_1:RecordAudio("413031039", var_166_12)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413031", "413031039", "story_v_out_413031.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413031", "413031039", "story_v_out_413031.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_13 = math.max(var_166_6, arg_163_1.talkMaxDuration)

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_13 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_5) / var_166_13

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_5 + var_166_13 and arg_163_1.time_ < var_166_5 + var_166_13 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play413031040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413031040
		arg_167_1.duration_ = 4.47

		local var_167_0 = {
			zh = 3.833,
			ja = 4.466
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
				arg_167_0:Play413031041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10022"]) and arg_167_1.var_.actorSpriteComps10022 == nil then
				arg_167_1.var_.actorSpriteComps10022 = arg_167_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10022"]) then
				if arg_167_1.var_.actorSpriteComps10022 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								iter_170_1.color = Color.New(Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_0), Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_0), (Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_0)))
							else
								local var_170_1 = Mathf.Lerp(iter_170_1.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_0)

								iter_170_1.color = Color.New(var_170_1, var_170_1, var_170_1)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10022"]) and arg_167_1.var_.actorSpriteComps10022 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10022 = nil
			end

			local var_170_2 = 0
			local var_170_3 = 0.475

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_4 = arg_167_1:GetWordFromCfg(413031040)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 19 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 19)

				if (19 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 19)) > 0 and var_170_3 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031040", "story_v_out_413031.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031040", "story_v_out_413031.awb") / 1000

					if var_170_8 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_2
					end

					if var_170_4.prefab_name ~= "" and arg_167_1.actors_[var_170_4.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_4.prefab_name].transform, "story_v_out_413031", "413031040", "story_v_out_413031.awb")

						arg_167_1:RecordAudio("413031040", var_170_9)
						arg_167_1:RecordAudio("413031040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413031", "413031040", "story_v_out_413031.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413031", "413031040", "story_v_out_413031.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_10 and arg_167_1.time_ < var_170_2 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play413031041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413031041
		arg_171_1.duration_ = 9.27

		local var_171_0 = {
			zh = 9.266,
			ja = 9.166
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
				arg_171_0:Play413031042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if arg_171_1.bgs_.F08l == nil then
				local var_174_0 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08l")
				var_174_0.name = "F08l"
				var_174_0.transform.parent = arg_171_1.stage_.transform
				var_174_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_.F08l = var_174_0
			end

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= 2 + arg_174_0 then
				local var_174_1 = arg_171_1.bgs_.F08l

				arg_171_1.bgs_.F08l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_174_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_2 = var_174_1:GetComponent("SpriteRenderer")

				if var_174_2 and var_174_2.sprite then
					local var_174_3 = 2 * (var_174_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_174_1.transform.localScale = Vector3.New(var_174_3 / var_174_2.sprite.bounds.size.y < var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x and var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x or var_174_3 / var_174_2.sprite.bounds.size.y, var_174_3 / var_174_2.sprite.bounds.size.y < var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x and var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x or var_174_3 / var_174_2.sprite.bounds.size.y, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "F08l" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_4 = 4

			if 4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			if arg_171_1.time_ >= var_174_4 + 0.3 and arg_171_1.time_ < var_174_4 + 0.3 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			local var_174_5 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_6 = 2

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_6 then
				local var_174_7 = Color.New(0, 0, 0)

				var_174_7.a = Mathf.Lerp(0, 1, (arg_171_1.time_ - var_174_5) / var_174_6)
				arg_171_1.mask_.color = var_174_7
			end

			if arg_171_1.time_ >= var_174_5 + var_174_6 and arg_171_1.time_ < var_174_5 + var_174_6 + arg_174_0 then
				local var_174_8 = Color.New(0, 0, 0)

				var_174_8.a = 1
				arg_171_1.mask_.color = var_174_8
			end

			local var_174_9 = 2

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_10 = 2

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_10 then
				local var_174_11 = Color.New(0, 0, 0)

				var_174_11.a = Mathf.Lerp(1, 0, (arg_171_1.time_ - var_174_9) / var_174_10)
				arg_171_1.mask_.color = var_174_11
			end

			if arg_171_1.time_ >= var_174_9 + var_174_10 and arg_171_1.time_ < var_174_9 + var_174_10 + arg_174_0 then
				local var_174_12 = Color.New(0, 0, 0)

				arg_171_1.mask_.enabled = false
				var_174_12.a = 0
				arg_171_1.mask_.color = var_174_12
			end

			local var_174_13 = arg_171_1.actors_["10022"].transform

			if 1.966 < arg_171_1.time_ and arg_171_1.time_ <= 1.966 + arg_174_0 then
				arg_171_1.var_.moveOldPos10022 = var_174_13.localPosition
				var_174_13.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10022", 0)

				for iter_174_2 = 0, var_174_13.childCount - 1 do
					local var_174_14 = var_174_13:GetChild(iter_174_2)

					if var_174_14.name == "" or not string.find(var_174_14.name, "split") then
						var_174_14.gameObject:SetActive(true)
					else
						var_174_14.gameObject:SetActive(false)
					end
				end
			end

			local var_174_15 = 0.001

			if 1.966 <= arg_171_1.time_ and arg_171_1.time_ < 1.966 + var_174_15 then
				var_174_13.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_171_1.time_ - 1.966) / var_174_15)
			end

			if arg_171_1.time_ >= 1.966 + var_174_15 and arg_171_1.time_ < 1.966 + var_174_15 + arg_174_0 then
				var_174_13.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_174_16 = arg_171_1.actors_["10093"].transform

			if 3.8 < arg_171_1.time_ and arg_171_1.time_ <= 3.8 + arg_174_0 then
				arg_171_1.var_.moveOldPos10093 = var_174_16.localPosition
				var_174_16.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10093", 3)

				for iter_174_3 = 0, var_174_16.childCount - 1 do
					local var_174_17 = var_174_16:GetChild(iter_174_3)

					if var_174_17.name == "split_5" or not string.find(var_174_17.name, "split") then
						var_174_17.gameObject:SetActive(true)
					else
						var_174_17.gameObject:SetActive(false)
					end
				end
			end

			local var_174_18 = 0.001

			if 3.8 <= arg_171_1.time_ and arg_171_1.time_ < 3.8 + var_174_18 then
				var_174_16.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_171_1.time_ - 3.8) / var_174_18)
			end

			if arg_171_1.time_ >= 3.8 + var_174_18 and arg_171_1.time_ < 3.8 + var_174_18 + arg_174_0 then
				var_174_16.localPosition = Vector3.New(0, -345, -245)
			end

			local var_174_19 = arg_171_1.actors_["10093"]

			if 3.8 < arg_171_1.time_ and arg_171_1.time_ <= 3.8 + arg_174_0 and not isNil(var_174_19) and arg_171_1.var_.actorSpriteComps10093 == nil then
				arg_171_1.var_.actorSpriteComps10093 = var_174_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_20 = 0.1

			if 3.8 <= arg_171_1.time_ and arg_171_1.time_ < 3.8 + var_174_20 and not isNil(var_174_19) then
				if arg_171_1.var_.actorSpriteComps10093 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								iter_174_5.color = Color.New(Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 3.8) / var_174_20), Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 3.8) / var_174_20), (Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 3.8) / var_174_20)))
							else
								local var_174_21 = Mathf.Lerp(iter_174_5.color.r, 1, (arg_171_1.time_ - 3.8) / var_174_20)

								iter_174_5.color = Color.New(var_174_21, var_174_21, var_174_21)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 3.8 + var_174_20 and arg_171_1.time_ < 3.8 + var_174_20 + arg_174_0 and not isNil(var_174_19) and arg_171_1.var_.actorSpriteComps10093 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_174_7 then
						iter_174_7.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps10093 = nil
			end

			if 3.8 < arg_171_1.time_ and arg_171_1.time_ <= 3.8 + arg_174_0 then
				local var_174_22 = arg_171_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_174_22 then
					arg_171_1.var_.alphaOldValue10093 = var_174_22.alpha
					arg_171_1.var_.characterEffect10093 = var_174_22
				end

				arg_171_1.var_.alphaOldValue10093 = 0
			end

			local var_174_23 = 0.5

			if 3.8 <= arg_171_1.time_ and arg_171_1.time_ < 3.8 + var_174_23 then
				if arg_171_1.var_.characterEffect10093 then
					arg_171_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_171_1.var_.alphaOldValue10093, 1, (arg_171_1.time_ - 3.8) / var_174_23)
				end
			end

			if arg_171_1.time_ >= 3.8 + var_174_23 and arg_171_1.time_ < 3.8 + var_174_23 + arg_174_0 and arg_171_1.var_.characterEffect10093 then
				arg_171_1.var_.characterEffect10093.alpha = 1
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_24 = 4
			local var_174_25 = 0.325

			if 4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_24 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_26 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_26:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_27 = arg_171_1:GetWordFromCfg(413031041)
				local var_174_28 = arg_171_1:FormatText(var_174_27.content)

				arg_171_1.text_.text = var_174_28

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_30 = 13 <= 0 and var_174_25 or var_174_25 * (utf8.len(var_174_28) / 13)

				if (13 <= 0 and var_174_25 or var_174_25 * (utf8.len(var_174_28) / 13)) > 0 and var_174_25 < var_174_30 then
					arg_171_1.talkMaxDuration = var_174_30
					var_174_24 = var_174_24 + 0.3

					if var_174_30 + var_174_24 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_30 + var_174_24
					end
				end

				arg_171_1.text_.text = var_174_28
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031041", "story_v_out_413031.awb") ~= 0 then
					local var_174_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031041", "story_v_out_413031.awb") / 1000

					if var_174_31 + var_174_24 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_31 + var_174_24
					end

					if var_174_27.prefab_name ~= "" and arg_171_1.actors_[var_174_27.prefab_name] ~= nil then
						local var_174_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_27.prefab_name].transform, "story_v_out_413031", "413031041", "story_v_out_413031.awb")

						arg_171_1:RecordAudio("413031041", var_174_32)
						arg_171_1:RecordAudio("413031041", var_174_32)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413031", "413031041", "story_v_out_413031.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413031", "413031041", "story_v_out_413031.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_33 = var_174_24 + 0.3
			local var_174_34 = math.max(var_174_25, arg_171_1.talkMaxDuration)

			if var_174_24 + 0.3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_33 + var_174_34 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_33) / var_174_34

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_33 + var_174_34 and arg_171_1.time_ < var_174_33 + var_174_34 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play413031042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 413031042
		arg_177_1.duration_ = 6.2

		local var_177_0 = {
			zh = 6.2,
			ja = 5.4
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
				arg_177_0:Play413031043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.525

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(413031042)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 21 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 21)

				if (21 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 21)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031042", "story_v_out_413031.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031042", "story_v_out_413031.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_413031", "413031042", "story_v_out_413031.awb")

						arg_177_1:RecordAudio("413031042", var_180_6)
						arg_177_1:RecordAudio("413031042", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_413031", "413031042", "story_v_out_413031.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_413031", "413031042", "story_v_out_413031.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play413031043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413031043
		arg_181_1.duration_ = 9.5

		local var_181_0 = {
			zh = 4.633,
			ja = 9.5
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
				arg_181_0:Play413031044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10093"]) and arg_181_1.var_.actorSpriteComps10093 == nil then
				arg_181_1.var_.actorSpriteComps10093 = arg_181_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["10093"]) then
				if arg_181_1.var_.actorSpriteComps10093 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								iter_184_1.color = Color.New(Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_0), Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_0), (Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_0)))
							else
								local var_184_1 = Mathf.Lerp(iter_184_1.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_0)

								iter_184_1.color = Color.New(var_184_1, var_184_1, var_184_1)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["10093"]) and arg_181_1.var_.actorSpriteComps10093 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps10093 = nil
			end

			local var_184_2 = 0
			local var_184_3 = 0.575

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_4 = arg_181_1:GetWordFromCfg(413031043)
				local var_184_5 = arg_181_1:FormatText(var_184_4.content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 23 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 23)

				if (23 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 23)) > 0 and var_184_3 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031043", "story_v_out_413031.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031043", "story_v_out_413031.awb") / 1000

					if var_184_8 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_2
					end

					if var_184_4.prefab_name ~= "" and arg_181_1.actors_[var_184_4.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_4.prefab_name].transform, "story_v_out_413031", "413031043", "story_v_out_413031.awb")

						arg_181_1:RecordAudio("413031043", var_184_9)
						arg_181_1:RecordAudio("413031043", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_413031", "413031043", "story_v_out_413031.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_413031", "413031043", "story_v_out_413031.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_10 and arg_181_1.time_ < var_184_2 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play413031044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413031044
		arg_185_1.duration_ = 5.33

		local var_185_0 = {
			zh = 3.833,
			ja = 5.333
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
				arg_185_0:Play413031045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.45

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:GetWordFromCfg(413031044)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 18 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 18)

				if (18 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 18)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031044", "story_v_out_413031.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031044", "story_v_out_413031.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_413031", "413031044", "story_v_out_413031.awb")

						arg_185_1:RecordAudio("413031044", var_188_6)
						arg_185_1:RecordAudio("413031044", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413031", "413031044", "story_v_out_413031.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413031", "413031044", "story_v_out_413031.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play413031045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413031045
		arg_189_1.duration_ = 2.17

		local var_189_0 = {
			zh = 2.166,
			ja = 1.999999999999
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
				arg_189_0:Play413031046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10093 = arg_189_1.actors_["10093"].transform.localPosition
				arg_189_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10093", 3)

				for iter_192_0 = 0, arg_189_1.actors_["10093"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["10093"].transform:GetChild(iter_192_0)

					if var_192_0.name == "split_5" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_192_2 = arg_189_1.actors_["10093"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10093 == nil then
				arg_189_1.var_.actorSpriteComps10093 = var_192_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_3 = 2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.actorSpriteComps10093 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								iter_192_2.color = Color.New(Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_3), Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_3), (Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_3)))
							else
								local var_192_4 = Mathf.Lerp(iter_192_2.color.r, 1, (arg_189_1.time_ - 0) / var_192_3)

								iter_192_2.color = Color.New(var_192_4, var_192_4, var_192_4)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10093 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_192_4 then
						iter_192_4.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps10093 = nil
			end

			local var_192_5 = 0
			local var_192_6 = 0.225

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(413031045)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 9 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 9)

				if (9 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 9)) > 0 and var_192_6 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031045", "story_v_out_413031.awb") ~= 0 then
					local var_192_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031045", "story_v_out_413031.awb") / 1000

					if var_192_11 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_5
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_413031", "413031045", "story_v_out_413031.awb")

						arg_189_1:RecordAudio("413031045", var_192_12)
						arg_189_1:RecordAudio("413031045", var_192_12)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413031", "413031045", "story_v_out_413031.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413031", "413031045", "story_v_out_413031.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_13 = math.max(var_192_6, arg_189_1.talkMaxDuration)

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_13 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_5) / var_192_13

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_5 + var_192_13 and arg_189_1.time_ < var_192_5 + var_192_13 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
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

		arg_189_1:InitPlayNodeList()
	end,
	Play413031046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413031046
		arg_193_1.duration_ = 5.7

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play413031047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10093 = arg_193_1.actors_["10093"].transform.localPosition
				arg_193_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10093", 7)

				for iter_196_0 = 0, arg_193_1.actors_["10093"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["10093"].transform:GetChild(iter_196_0)

					if var_196_0.name == "" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_2 = arg_193_1.actors_["10093"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10093 == nil then
				arg_193_1.var_.actorSpriteComps10093 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps10093 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								iter_196_2.color = Color.New(Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_2.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_2.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10093 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_196_4 then
						iter_196_4.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps10093 = nil
			end

			local var_196_5 = manager.ui.mainCamera.transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.shakeOldPos = var_196_5.localPosition
			end

			local var_196_6 = 0.6

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 then
				local var_196_7, var_196_8 = math.modf((arg_193_1.time_ - 0) / 0.066)

				var_196_5.localPosition = Vector3.New(var_196_8 * 0.13, var_196_8 * 0.13, var_196_8 * 0.13) + arg_193_1.var_.shakeOldPos
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 then
				var_196_5.localPosition = arg_193_1.var_.shakeOldPos
			end

			local var_196_9 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			if arg_193_1.time_ >= var_196_9 + 0.6 and arg_193_1.time_ < var_196_9 + 0.6 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_arrow2", "")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_196_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_13 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_13

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_13
						arg_193_1.bgmTxt2_.text = var_196_13
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_193_1.time_ and arg_193_1.time_ <= 0.366666666666667 + arg_196_0 then
				arg_193_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_196_16 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_16 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_16

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_16
						arg_193_1.bgmTxt2_.text = var_196_16
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_196_17 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_17 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_18 = 0.433333333333333

			if var_196_17 <= arg_193_1.time_ and arg_193_1.time_ < var_196_17 + var_196_18 then
				local var_196_19 = Color.New(1, 1, 1)

				var_196_19.a = Mathf.Lerp(1, 0, (arg_193_1.time_ - var_196_17) / var_196_18)
				arg_193_1.mask_.color = var_196_19
			end

			if arg_193_1.time_ >= var_196_17 + var_196_18 and arg_193_1.time_ < var_196_17 + var_196_18 + arg_196_0 then
				local var_196_20 = Color.New(1, 1, 1)

				arg_193_1.mask_.enabled = false
				var_196_20.a = 0
				arg_193_1.mask_.color = var_196_20
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_21 = 0.7
			local var_196_22 = 1.3

			if 0.7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_21 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_23 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_23:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_193_1.dialogCg_.alpha = arg_199_0
				end))
				var_196_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_24 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(413031046).content)

				arg_193_1.text_.text = var_196_24

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_26 = 52 <= 0 and var_196_22 or var_196_22 * (utf8.len(var_196_24) / 52)

				if (52 <= 0 and var_196_22 or var_196_22 * (utf8.len(var_196_24) / 52)) > 0 and var_196_22 < var_196_26 then
					arg_193_1.talkMaxDuration = var_196_26
					var_196_21 = var_196_21 + 0.3

					if var_196_26 + var_196_21 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_26 + var_196_21
					end
				end

				arg_193_1.text_.text = var_196_24
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_27 = var_196_21 + 0.3
			local var_196_28 = math.max(var_196_22, arg_193_1.talkMaxDuration)

			if var_196_21 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_27 + var_196_28 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_27) / var_196_28

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_27 + var_196_28 and arg_193_1.time_ < var_196_27 + var_196_28 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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

		arg_193_1:InitPlayNodeList()
	end,
	Play413031047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413031047
		arg_201_1.duration_ = 4.07

		local var_201_0 = {
			zh = 1.9,
			ja = 4.066
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
				arg_201_0:Play413031048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.15

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:GetWordFromCfg(413031047)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 6 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 6)

				if (6 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 6)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031047", "story_v_out_413031.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031047", "story_v_out_413031.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_413031", "413031047", "story_v_out_413031.awb")

						arg_201_1:RecordAudio("413031047", var_204_6)
						arg_201_1:RecordAudio("413031047", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413031", "413031047", "story_v_out_413031.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413031", "413031047", "story_v_out_413031.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play413031048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413031048
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play413031049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.375

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(413031048).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 55 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 55)

				if (55 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 55)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play413031049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413031049
		arg_209_1.duration_ = 4.6

		local var_209_0 = {
			zh = 2.4,
			ja = 4.6
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
				arg_209_0:Play413031050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_212_0 = 0.6

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				local var_212_1, var_212_2 = math.modf((arg_209_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_212_2 * 0.13, var_212_2 * 0.13, var_212_2 * 0.13) + arg_209_1.var_.shakeOldPos
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				manager.ui.mainCamera.transform.localPosition = arg_209_1.var_.shakeOldPos
			end

			local var_212_3 = 0

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_3 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			if arg_209_1.time_ >= var_212_3 + 0.6 and arg_209_1.time_ < var_212_3 + 0.6 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_4 = 0
			local var_212_5 = 0.25

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_6 = arg_209_1:GetWordFromCfg(413031049)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 10 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 10)

				if (10 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 10)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031049", "story_v_out_413031.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_413031", "413031049", "story_v_out_413031.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_413031", "413031049", "story_v_out_413031.awb")

						arg_209_1:RecordAudio("413031049", var_212_11)
						arg_209_1:RecordAudio("413031049", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_413031", "413031049", "story_v_out_413031.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_413031", "413031049", "story_v_out_413031.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play413031050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413031050
		arg_213_1.duration_ = 8.1

		local var_213_0 = {
			zh = 5.733,
			ja = 8.1
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
				arg_213_0:Play413031051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10093 = arg_213_1.actors_["10093"].transform.localPosition
				arg_213_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10093", 3)

				for iter_216_0 = 0, arg_213_1.actors_["10093"].transform.childCount - 1 do
					local var_216_0 = arg_213_1.actors_["10093"].transform:GetChild(iter_216_0)

					if var_216_0.name == "split_4" or not string.find(var_216_0.name, "split") then
						var_216_0.gameObject:SetActive(true)
					else
						var_216_0.gameObject:SetActive(false)
					end
				end
			end

			local var_216_1 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_1 then
				arg_213_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_213_1.time_ - 0) / var_216_1)
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 then
				arg_213_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_216_2 = arg_213_1.actors_["10093"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10093 == nil then
				arg_213_1.var_.actorSpriteComps10093 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps10093 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_216_2 then
							if arg_213_1.isInRecall_ then
								iter_216_2.color = Color.New(Mathf.Lerp(iter_216_2.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_2.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_2.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_2.color.r, 1, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_2.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10093 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_216_4 then
						iter_216_4.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps10093 = nil
			end

			local var_216_5 = 0
			local var_216_6 = 0.85

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:GetWordFromCfg(413031050)
				local var_216_8 = arg_213_1:FormatText(var_216_7.content)

				arg_213_1.text_.text = var_216_8

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_10 = 34 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 34)

				if (34 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 34)) > 0 and var_216_6 < var_216_10 then
					arg_213_1.talkMaxDuration = var_216_10

					if var_216_10 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_8
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031050", "story_v_out_413031.awb") ~= 0 then
					local var_216_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031050", "story_v_out_413031.awb") / 1000

					if var_216_11 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_5
					end

					if var_216_7.prefab_name ~= "" and arg_213_1.actors_[var_216_7.prefab_name] ~= nil then
						local var_216_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_7.prefab_name].transform, "story_v_out_413031", "413031050", "story_v_out_413031.awb")

						arg_213_1:RecordAudio("413031050", var_216_12)
						arg_213_1:RecordAudio("413031050", var_216_12)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413031", "413031050", "story_v_out_413031.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413031", "413031050", "story_v_out_413031.awb")
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

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play413031051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413031051
		arg_217_1.duration_ = 2.47

		local var_217_0 = {
			zh = 2.266,
			ja = 2.466
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
				arg_217_0:Play413031052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.3

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(413031051)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 12 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 12)

				if (12 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 12)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031051", "story_v_out_413031.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031051", "story_v_out_413031.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_413031", "413031051", "story_v_out_413031.awb")

						arg_217_1:RecordAudio("413031051", var_220_6)
						arg_217_1:RecordAudio("413031051", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413031", "413031051", "story_v_out_413031.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413031", "413031051", "story_v_out_413031.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play413031052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413031052
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play413031053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10093"]) and arg_221_1.var_.actorSpriteComps10093 == nil then
				arg_221_1.var_.actorSpriteComps10093 = arg_221_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_0 = 2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10093"]) then
				if arg_221_1.var_.actorSpriteComps10093 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								iter_224_1.color = Color.New(Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_0), Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_0), (Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_0)))
							else
								local var_224_1 = Mathf.Lerp(iter_224_1.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_0)

								iter_224_1.color = Color.New(var_224_1, var_224_1, var_224_1)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10093"]) and arg_221_1.var_.actorSpriteComps10093 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_224_3 then
						iter_224_3.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps10093 = nil
			end

			local var_224_2 = 0
			local var_224_3 = 1.075

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(413031052).content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_6 = 43 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_4) / 43)

				if (43 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_4) / 43)) > 0 and var_224_3 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6

					if var_224_6 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_7 and arg_221_1.time_ < var_224_2 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play413031053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413031053
		arg_225_1.duration_ = 8.07

		local var_225_0 = {
			zh = 6.833,
			ja = 8.066
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
				arg_225_0:Play413031054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.6

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:GetWordFromCfg(413031053)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 24 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 24)

				if (24 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 24)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031053", "story_v_out_413031.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031053", "story_v_out_413031.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_413031", "413031053", "story_v_out_413031.awb")

						arg_225_1:RecordAudio("413031053", var_228_6)
						arg_225_1:RecordAudio("413031053", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413031", "413031053", "story_v_out_413031.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413031", "413031053", "story_v_out_413031.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play413031054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 413031054
		arg_229_1.duration_ = 2.63

		local var_229_0 = {
			zh = 1.999999999999,
			ja = 2.633
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
				arg_229_0:Play413031055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos10093 = arg_229_1.actors_["10093"].transform.localPosition
				arg_229_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10093", 3)

				for iter_232_0 = 0, arg_229_1.actors_["10093"].transform.childCount - 1 do
					local var_232_0 = arg_229_1.actors_["10093"].transform:GetChild(iter_232_0)

					if var_232_0.name == "split_6" or not string.find(var_232_0.name, "split") then
						var_232_0.gameObject:SetActive(true)
					else
						var_232_0.gameObject:SetActive(false)
					end
				end
			end

			local var_232_1 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_1 then
				arg_229_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_229_1.time_ - 0) / var_232_1)
			end

			if arg_229_1.time_ >= 0 + var_232_1 and arg_229_1.time_ < 0 + var_232_1 + arg_232_0 then
				arg_229_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_232_2 = arg_229_1.actors_["10093"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps10093 == nil then
				arg_229_1.var_.actorSpriteComps10093 = var_232_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_3 = 2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.actorSpriteComps10093 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_232_2 then
							if arg_229_1.isInRecall_ then
								iter_232_2.color = Color.New(Mathf.Lerp(iter_232_2.color.r, arg_229_1.hightColor1.r, (arg_229_1.time_ - 0) / var_232_3), Mathf.Lerp(iter_232_2.color.g, arg_229_1.hightColor1.g, (arg_229_1.time_ - 0) / var_232_3), (Mathf.Lerp(iter_232_2.color.b, arg_229_1.hightColor1.b, (arg_229_1.time_ - 0) / var_232_3)))
							else
								local var_232_4 = Mathf.Lerp(iter_232_2.color.r, 1, (arg_229_1.time_ - 0) / var_232_3)

								iter_232_2.color = Color.New(var_232_4, var_232_4, var_232_4)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps10093 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_232_4 then
						iter_232_4.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_229_1.var_.actorSpriteComps10093 = nil
			end

			local var_232_5 = 0
			local var_232_6 = 0.1

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_7 = arg_229_1:GetWordFromCfg(413031054)
				local var_232_8 = arg_229_1:FormatText(var_232_7.content)

				arg_229_1.text_.text = var_232_8

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_10 = 5 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 5)

				if (5 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 5)) > 0 and var_232_6 < var_232_10 then
					arg_229_1.talkMaxDuration = var_232_10

					if var_232_10 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_5
					end
				end

				arg_229_1.text_.text = var_232_8
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031054", "story_v_out_413031.awb") ~= 0 then
					local var_232_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031054", "story_v_out_413031.awb") / 1000

					if var_232_11 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_5
					end

					if var_232_7.prefab_name ~= "" and arg_229_1.actors_[var_232_7.prefab_name] ~= nil then
						local var_232_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_7.prefab_name].transform, "story_v_out_413031", "413031054", "story_v_out_413031.awb")

						arg_229_1:RecordAudio("413031054", var_232_12)
						arg_229_1:RecordAudio("413031054", var_232_12)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_413031", "413031054", "story_v_out_413031.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_413031", "413031054", "story_v_out_413031.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_13 = math.max(var_232_6, arg_229_1.talkMaxDuration)

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_13 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_5) / var_232_13

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_5 + var_232_13 and arg_229_1.time_ < var_232_5 + var_232_13 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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

		arg_229_1:InitPlayNodeList()
	end,
	Play413031055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 413031055
		arg_233_1.duration_ = 6.97

		local var_233_0 = {
			zh = 6.966,
			ja = 6.233
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
				arg_233_0:Play413031056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["10093"]) and arg_233_1.var_.actorSpriteComps10093 == nil then
				arg_233_1.var_.actorSpriteComps10093 = arg_233_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_0 = 2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["10093"]) then
				if arg_233_1.var_.actorSpriteComps10093 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								iter_236_1.color = Color.New(Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor2.r, (arg_233_1.time_ - 0) / var_236_0), Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor2.g, (arg_233_1.time_ - 0) / var_236_0), (Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor2.b, (arg_233_1.time_ - 0) / var_236_0)))
							else
								local var_236_1 = Mathf.Lerp(iter_236_1.color.r, 0.5, (arg_233_1.time_ - 0) / var_236_0)

								iter_236_1.color = Color.New(var_236_1, var_236_1, var_236_1)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["10093"]) and arg_233_1.var_.actorSpriteComps10093 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_236_3 then
						iter_236_3.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_233_1.var_.actorSpriteComps10093 = nil
			end

			local var_236_2 = 0
			local var_236_3 = 0.675

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_4 = arg_233_1:GetWordFromCfg(413031055)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 27 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 27)

				if (27 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 27)) > 0 and var_236_3 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031055", "story_v_out_413031.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031055", "story_v_out_413031.awb") / 1000

					if var_236_8 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_2
					end

					if var_236_4.prefab_name ~= "" and arg_233_1.actors_[var_236_4.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_4.prefab_name].transform, "story_v_out_413031", "413031055", "story_v_out_413031.awb")

						arg_233_1:RecordAudio("413031055", var_236_9)
						arg_233_1:RecordAudio("413031055", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_413031", "413031055", "story_v_out_413031.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_413031", "413031055", "story_v_out_413031.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 <= arg_233_1.time_ and arg_233_1.time_ < var_236_2 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_2) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_2 + var_236_10 and arg_233_1.time_ < var_236_2 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play413031056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 413031056
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play413031057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 1.225

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(413031056).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 49 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 49)

				if (49 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 49)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play413031057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 413031057
		arg_241_1.duration_ = 9

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play413031058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 1.999999999999 < arg_241_1.time_ and arg_241_1.time_ <= 1.999999999999 + arg_244_0 then
				local var_244_0 = arg_241_1.bgs_.F08l

				arg_241_1.bgs_.F08l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_244_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_244_1 = var_244_0:GetComponent("SpriteRenderer")

				if var_244_1 and var_244_1.sprite then
					local var_244_2 = 2 * (var_244_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_244_0.transform.localScale = Vector3.New(var_244_2 / var_244_1.sprite.bounds.size.y < var_244_2 * manager.ui.mainCameraCom_.aspect / var_244_1.sprite.bounds.size.x and var_244_2 * manager.ui.mainCameraCom_.aspect / var_244_1.sprite.bounds.size.x or var_244_2 / var_244_1.sprite.bounds.size.y, var_244_2 / var_244_1.sprite.bounds.size.y < var_244_2 * manager.ui.mainCameraCom_.aspect / var_244_1.sprite.bounds.size.x and var_244_2 * manager.ui.mainCameraCom_.aspect / var_244_1.sprite.bounds.size.x or var_244_2 / var_244_1.sprite.bounds.size.y, 0)
				end

				for iter_244_0, iter_244_1 in pairs(arg_241_1.bgs_) do
					if iter_244_0 ~= "F08l" then
						iter_244_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_244_3 = 4.033333333331

			if 4.033333333331 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.allBtn_.enabled = false
			end

			if arg_241_1.time_ >= var_244_3 + 0.2 and arg_241_1.time_ < var_244_3 + 0.2 + arg_244_0 then
				arg_241_1.allBtn_.enabled = true
			end

			local var_244_4 = 0

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_5 = 2

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_5 then
				local var_244_6 = Color.New(0, 0, 0)

				var_244_6.a = Mathf.Lerp(0, 1, (arg_241_1.time_ - var_244_4) / var_244_5)
				arg_241_1.mask_.color = var_244_6
			end

			if arg_241_1.time_ >= var_244_4 + var_244_5 and arg_241_1.time_ < var_244_4 + var_244_5 + arg_244_0 then
				local var_244_7 = Color.New(0, 0, 0)

				var_244_7.a = 1
				arg_241_1.mask_.color = var_244_7
			end

			local var_244_8 = 2

			if 2 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_9 = 2

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_9 then
				local var_244_10 = Color.New(0, 0, 0)

				var_244_10.a = Mathf.Lerp(1, 0, (arg_241_1.time_ - var_244_8) / var_244_9)
				arg_241_1.mask_.color = var_244_10
			end

			if arg_241_1.time_ >= var_244_8 + var_244_9 and arg_241_1.time_ < var_244_8 + var_244_9 + arg_244_0 then
				local var_244_11 = Color.New(0, 0, 0)

				arg_241_1.mask_.enabled = false
				var_244_11.a = 0
				arg_241_1.mask_.color = var_244_11
			end

			local var_244_12 = arg_241_1.actors_["10093"].transform

			if 1.98333333333333 < arg_241_1.time_ and arg_241_1.time_ <= 1.98333333333333 + arg_244_0 then
				arg_241_1.var_.moveOldPos10093 = var_244_12.localPosition
				var_244_12.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("10093", 7)

				for iter_244_2 = 0, var_244_12.childCount - 1 do
					local var_244_13 = var_244_12:GetChild(iter_244_2)

					if var_244_13.name == "" or not string.find(var_244_13.name, "split") then
						var_244_13.gameObject:SetActive(true)
					else
						var_244_13.gameObject:SetActive(false)
					end
				end
			end

			local var_244_14 = 0.001

			if 1.98333333333333 <= arg_241_1.time_ and arg_241_1.time_ < 1.98333333333333 + var_244_14 then
				var_244_12.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_241_1.time_ - 1.98333333333333) / var_244_14)
			end

			if arg_241_1.time_ >= 1.98333333333333 + var_244_14 and arg_241_1.time_ < 1.98333333333333 + var_244_14 + arg_244_0 then
				var_244_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_244_15 = arg_241_1.actors_["10093"]

			if 1.98333333333333 < arg_241_1.time_ and arg_241_1.time_ <= 1.98333333333333 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.actorSpriteComps10093 == nil then
				arg_241_1.var_.actorSpriteComps10093 = var_244_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_16 = 0.0166666666666666

			if 1.98333333333333 <= arg_241_1.time_ and arg_241_1.time_ < 1.98333333333333 + var_244_16 and not isNil(var_244_15) then
				if arg_241_1.var_.actorSpriteComps10093 then
					for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_244_4 then
							if arg_241_1.isInRecall_ then
								iter_244_4.color = Color.New(Mathf.Lerp(iter_244_4.color.r, arg_241_1.hightColor2.r, (arg_241_1.time_ - 1.98333333333333) / var_244_16), Mathf.Lerp(iter_244_4.color.g, arg_241_1.hightColor2.g, (arg_241_1.time_ - 1.98333333333333) / var_244_16), (Mathf.Lerp(iter_244_4.color.b, arg_241_1.hightColor2.b, (arg_241_1.time_ - 1.98333333333333) / var_244_16)))
							else
								local var_244_17 = Mathf.Lerp(iter_244_4.color.r, 0.5, (arg_241_1.time_ - 1.98333333333333) / var_244_16)

								iter_244_4.color = Color.New(var_244_17, var_244_17, var_244_17)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 1.98333333333333 + var_244_16 and arg_241_1.time_ < 1.98333333333333 + var_244_16 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.actorSpriteComps10093 then
				for iter_244_5, iter_244_6 in pairs(arg_241_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_244_6 then
						iter_244_6.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_241_1.var_.actorSpriteComps10093 = nil
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_18 = 3.999999999999
			local var_244_19 = 1.45

			if 3.999999999999 < arg_241_1.time_ and arg_241_1.time_ <= var_244_18 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_20 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_20:setOnUpdate(LuaHelper.FloatAction(function(arg_245_0)
					arg_241_1.dialogCg_.alpha = arg_245_0
				end))
				var_244_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_21 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(413031057).content)

				arg_241_1.text_.text = var_244_21

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_23 = 58 <= 0 and var_244_19 or var_244_19 * (utf8.len(var_244_21) / 58)

				if (58 <= 0 and var_244_19 or var_244_19 * (utf8.len(var_244_21) / 58)) > 0 and var_244_19 < var_244_23 then
					arg_241_1.talkMaxDuration = var_244_23
					var_244_18 = var_244_18 + 0.3

					if var_244_23 + var_244_18 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_18
					end
				end

				arg_241_1.text_.text = var_244_21
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_24 = var_244_18 + 0.3
			local var_244_25 = math.max(var_244_19, arg_241_1.talkMaxDuration)

			if var_244_18 + 0.3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_24 + var_244_25 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_24) / var_244_25

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_24 + var_244_25 and arg_241_1.time_ < var_244_24 + var_244_25 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666665,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play413031058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 413031058
		arg_247_1.duration_ = 4.03

		local var_247_0 = {
			zh = 3.733,
			ja = 4.033
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play413031059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10093 = arg_247_1.actors_["10093"].transform.localPosition
				arg_247_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10093", 3)

				for iter_250_0 = 0, arg_247_1.actors_["10093"].transform.childCount - 1 do
					local var_250_0 = arg_247_1.actors_["10093"].transform:GetChild(iter_250_0)

					if var_250_0.name == "split_4" or not string.find(var_250_0.name, "split") then
						var_250_0.gameObject:SetActive(true)
					else
						var_250_0.gameObject:SetActive(false)
					end
				end
			end

			local var_250_1 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_1 then
				arg_247_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_247_1.time_ - 0) / var_250_1)
			end

			if arg_247_1.time_ >= 0 + var_250_1 and arg_247_1.time_ < 0 + var_250_1 + arg_250_0 then
				arg_247_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_250_2 = arg_247_1.actors_["10093"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.actorSpriteComps10093 == nil then
				arg_247_1.var_.actorSpriteComps10093 = var_250_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_3 = 2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_3 and not isNil(var_250_2) then
				if arg_247_1.var_.actorSpriteComps10093 then
					for iter_250_1, iter_250_2 in pairs(arg_247_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_250_2 then
							if arg_247_1.isInRecall_ then
								iter_250_2.color = Color.New(Mathf.Lerp(iter_250_2.color.r, arg_247_1.hightColor1.r, (arg_247_1.time_ - 0) / var_250_3), Mathf.Lerp(iter_250_2.color.g, arg_247_1.hightColor1.g, (arg_247_1.time_ - 0) / var_250_3), (Mathf.Lerp(iter_250_2.color.b, arg_247_1.hightColor1.b, (arg_247_1.time_ - 0) / var_250_3)))
							else
								local var_250_4 = Mathf.Lerp(iter_250_2.color.r, 1, (arg_247_1.time_ - 0) / var_250_3)

								iter_250_2.color = Color.New(var_250_4, var_250_4, var_250_4)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_3 and arg_247_1.time_ < 0 + var_250_3 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.actorSpriteComps10093 then
				for iter_250_3, iter_250_4 in pairs(arg_247_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_250_4 then
						iter_250_4.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps10093 = nil
			end

			local var_250_5 = 0
			local var_250_6 = 0.45

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_7 = arg_247_1:GetWordFromCfg(413031058)
				local var_250_8 = arg_247_1:FormatText(var_250_7.content)

				arg_247_1.text_.text = var_250_8

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_10 = 18 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 18)

				if (18 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 18)) > 0 and var_250_6 < var_250_10 then
					arg_247_1.talkMaxDuration = var_250_10

					if var_250_10 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_5
					end
				end

				arg_247_1.text_.text = var_250_8
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031058", "story_v_out_413031.awb") ~= 0 then
					local var_250_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031058", "story_v_out_413031.awb") / 1000

					if var_250_11 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_5
					end

					if var_250_7.prefab_name ~= "" and arg_247_1.actors_[var_250_7.prefab_name] ~= nil then
						local var_250_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_7.prefab_name].transform, "story_v_out_413031", "413031058", "story_v_out_413031.awb")

						arg_247_1:RecordAudio("413031058", var_250_12)
						arg_247_1:RecordAudio("413031058", var_250_12)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_413031", "413031058", "story_v_out_413031.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_413031", "413031058", "story_v_out_413031.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_13 = math.max(var_250_6, arg_247_1.talkMaxDuration)

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_13 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_5) / var_250_13

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_5 + var_250_13 and arg_247_1.time_ < var_250_5 + var_250_13 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
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

		arg_247_1:InitPlayNodeList()
	end,
	Play413031059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 413031059
		arg_251_1.duration_ = 2.33

		local var_251_0 = {
			zh = 2.333,
			ja = 2.266
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play413031060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10093"]) and arg_251_1.var_.actorSpriteComps10093 == nil then
				arg_251_1.var_.actorSpriteComps10093 = arg_251_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10093"]) then
				if arg_251_1.var_.actorSpriteComps10093 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								iter_254_1.color = Color.New(Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor2.r, (arg_251_1.time_ - 0) / var_254_0), Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor2.g, (arg_251_1.time_ - 0) / var_254_0), (Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor2.b, (arg_251_1.time_ - 0) / var_254_0)))
							else
								local var_254_1 = Mathf.Lerp(iter_254_1.color.r, 0.5, (arg_251_1.time_ - 0) / var_254_0)

								iter_254_1.color = Color.New(var_254_1, var_254_1, var_254_1)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10093"]) and arg_251_1.var_.actorSpriteComps10093 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps10093 = nil
			end

			local var_254_2 = 0
			local var_254_3 = 0.175

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_4 = arg_251_1:GetWordFromCfg(413031059)
				local var_254_5 = arg_251_1:FormatText(var_254_4.content)

				arg_251_1.text_.text = var_254_5

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 7 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 7)

				if (7 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 7)) > 0 and var_254_3 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_5
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031059", "story_v_out_413031.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031059", "story_v_out_413031.awb") / 1000

					if var_254_8 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_2
					end

					if var_254_4.prefab_name ~= "" and arg_251_1.actors_[var_254_4.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_4.prefab_name].transform, "story_v_out_413031", "413031059", "story_v_out_413031.awb")

						arg_251_1:RecordAudio("413031059", var_254_9)
						arg_251_1:RecordAudio("413031059", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_413031", "413031059", "story_v_out_413031.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_413031", "413031059", "story_v_out_413031.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_10 and arg_251_1.time_ < var_254_2 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play413031060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 413031060
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play413031061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0.733333333333333 < arg_255_1.time_ and arg_255_1.time_ <= 0.733333333333333 + arg_258_0 then
				arg_255_1:AudioAction("play", "effect", "se_story_16", "se_story_16_foot03", "")
			end

			local var_258_1 = 0
			local var_258_2 = 1.225

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(413031060).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 49 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 49)

				if (49 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 49)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play413031061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 413031061
		arg_259_1.duration_ = 2.57

		local var_259_0 = {
			zh = 1.999999999999,
			ja = 2.566
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play413031062(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10093 = arg_259_1.actors_["10093"].transform.localPosition
				arg_259_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10093", 3)

				for iter_262_0 = 0, arg_259_1.actors_["10093"].transform.childCount - 1 do
					local var_262_0 = arg_259_1.actors_["10093"].transform:GetChild(iter_262_0)

					if var_262_0.name == "" or not string.find(var_262_0.name, "split") then
						var_262_0.gameObject:SetActive(true)
					else
						var_262_0.gameObject:SetActive(false)
					end
				end
			end

			local var_262_1 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_1 then
				arg_259_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_259_1.time_ - 0) / var_262_1)
			end

			if arg_259_1.time_ >= 0 + var_262_1 and arg_259_1.time_ < 0 + var_262_1 + arg_262_0 then
				arg_259_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_262_2 = arg_259_1.actors_["10093"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps10093 == nil then
				arg_259_1.var_.actorSpriteComps10093 = var_262_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_3 = 2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.actorSpriteComps10093 then
					for iter_262_1, iter_262_2 in pairs(arg_259_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_262_2 then
							if arg_259_1.isInRecall_ then
								iter_262_2.color = Color.New(Mathf.Lerp(iter_262_2.color.r, arg_259_1.hightColor1.r, (arg_259_1.time_ - 0) / var_262_3), Mathf.Lerp(iter_262_2.color.g, arg_259_1.hightColor1.g, (arg_259_1.time_ - 0) / var_262_3), (Mathf.Lerp(iter_262_2.color.b, arg_259_1.hightColor1.b, (arg_259_1.time_ - 0) / var_262_3)))
							else
								local var_262_4 = Mathf.Lerp(iter_262_2.color.r, 1, (arg_259_1.time_ - 0) / var_262_3)

								iter_262_2.color = Color.New(var_262_4, var_262_4, var_262_4)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps10093 then
				for iter_262_3, iter_262_4 in pairs(arg_259_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_262_4 then
						iter_262_4.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps10093 = nil
			end

			local var_262_5 = 0
			local var_262_6 = 0.075

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_7 = arg_259_1:GetWordFromCfg(413031061)
				local var_262_8 = arg_259_1:FormatText(var_262_7.content)

				arg_259_1.text_.text = var_262_8

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_10 = 3 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 3)

				if (3 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 3)) > 0 and var_262_6 < var_262_10 then
					arg_259_1.talkMaxDuration = var_262_10

					if var_262_10 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_5
					end
				end

				arg_259_1.text_.text = var_262_8
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031061", "story_v_out_413031.awb") ~= 0 then
					local var_262_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031061", "story_v_out_413031.awb") / 1000

					if var_262_11 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_5
					end

					if var_262_7.prefab_name ~= "" and arg_259_1.actors_[var_262_7.prefab_name] ~= nil then
						local var_262_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_7.prefab_name].transform, "story_v_out_413031", "413031061", "story_v_out_413031.awb")

						arg_259_1:RecordAudio("413031061", var_262_12)
						arg_259_1:RecordAudio("413031061", var_262_12)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_413031", "413031061", "story_v_out_413031.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_413031", "413031061", "story_v_out_413031.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_13 = math.max(var_262_6, arg_259_1.talkMaxDuration)

			if var_262_5 <= arg_259_1.time_ and arg_259_1.time_ < var_262_5 + var_262_13 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_5) / var_262_13

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_5 + var_262_13 and arg_259_1.time_ < var_262_5 + var_262_13 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play413031062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 413031062
		arg_263_1.duration_ = 7.3

		local var_263_0 = {
			zh = 4.1,
			ja = 7.3
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play413031063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["10093"]) and arg_263_1.var_.actorSpriteComps10093 == nil then
				arg_263_1.var_.actorSpriteComps10093 = arg_263_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_0 = 2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["10093"]) then
				if arg_263_1.var_.actorSpriteComps10093 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								iter_266_1.color = Color.New(Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor2.r, (arg_263_1.time_ - 0) / var_266_0), Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor2.g, (arg_263_1.time_ - 0) / var_266_0), (Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor2.b, (arg_263_1.time_ - 0) / var_266_0)))
							else
								local var_266_1 = Mathf.Lerp(iter_266_1.color.r, 0.5, (arg_263_1.time_ - 0) / var_266_0)

								iter_266_1.color = Color.New(var_266_1, var_266_1, var_266_1)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["10093"]) and arg_263_1.var_.actorSpriteComps10093 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_266_3 then
						iter_266_3.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_263_1.var_.actorSpriteComps10093 = nil
			end

			local var_266_2 = 0
			local var_266_3 = 0.35

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_4 = arg_263_1:GetWordFromCfg(413031062)
				local var_266_5 = arg_263_1:FormatText(var_266_4.content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_7 = 14 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 14)

				if (14 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 14)) > 0 and var_266_3 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_2
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031062", "story_v_out_413031.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031062", "story_v_out_413031.awb") / 1000

					if var_266_8 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_2
					end

					if var_266_4.prefab_name ~= "" and arg_263_1.actors_[var_266_4.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_4.prefab_name].transform, "story_v_out_413031", "413031062", "story_v_out_413031.awb")

						arg_263_1:RecordAudio("413031062", var_266_9)
						arg_263_1:RecordAudio("413031062", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_413031", "413031062", "story_v_out_413031.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_413031", "413031062", "story_v_out_413031.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_3, arg_263_1.talkMaxDuration)

			if var_266_2 <= arg_263_1.time_ and arg_263_1.time_ < var_266_2 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_2) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_2 + var_266_10 and arg_263_1.time_ < var_266_2 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play413031063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 413031063
		arg_267_1.duration_ = 7.47

		local var_267_0 = {
			zh = 4.4,
			ja = 7.466
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play413031064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.425

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:GetWordFromCfg(413031063)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 17 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 17)

				if (17 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 17)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031063", "story_v_out_413031.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031063", "story_v_out_413031.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_413031", "413031063", "story_v_out_413031.awb")

						arg_267_1:RecordAudio("413031063", var_270_6)
						arg_267_1:RecordAudio("413031063", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_413031", "413031063", "story_v_out_413031.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_413031", "413031063", "story_v_out_413031.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play413031064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 413031064
		arg_271_1.duration_ = 2

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play413031065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos10093 = arg_271_1.actors_["10093"].transform.localPosition
				arg_271_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10093", 3)

				for iter_274_0 = 0, arg_271_1.actors_["10093"].transform.childCount - 1 do
					local var_274_0 = arg_271_1.actors_["10093"].transform:GetChild(iter_274_0)

					if var_274_0.name == "split_4" or not string.find(var_274_0.name, "split") then
						var_274_0.gameObject:SetActive(true)
					else
						var_274_0.gameObject:SetActive(false)
					end
				end
			end

			local var_274_1 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_1 then
				arg_271_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_271_1.time_ - 0) / var_274_1)
			end

			if arg_271_1.time_ >= 0 + var_274_1 and arg_271_1.time_ < 0 + var_274_1 + arg_274_0 then
				arg_271_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_274_2 = arg_271_1.actors_["10093"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps10093 == nil then
				arg_271_1.var_.actorSpriteComps10093 = var_274_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_3 = 2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.actorSpriteComps10093 then
					for iter_274_1, iter_274_2 in pairs(arg_271_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_274_2 then
							if arg_271_1.isInRecall_ then
								iter_274_2.color = Color.New(Mathf.Lerp(iter_274_2.color.r, arg_271_1.hightColor1.r, (arg_271_1.time_ - 0) / var_274_3), Mathf.Lerp(iter_274_2.color.g, arg_271_1.hightColor1.g, (arg_271_1.time_ - 0) / var_274_3), (Mathf.Lerp(iter_274_2.color.b, arg_271_1.hightColor1.b, (arg_271_1.time_ - 0) / var_274_3)))
							else
								local var_274_4 = Mathf.Lerp(iter_274_2.color.r, 1, (arg_271_1.time_ - 0) / var_274_3)

								iter_274_2.color = Color.New(var_274_4, var_274_4, var_274_4)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps10093 then
				for iter_274_3, iter_274_4 in pairs(arg_271_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_274_4 then
						iter_274_4.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_271_1.var_.actorSpriteComps10093 = nil
			end

			local var_274_5 = 0
			local var_274_6 = 0.05

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_7 = arg_271_1:GetWordFromCfg(413031064)
				local var_274_8 = arg_271_1:FormatText(var_274_7.content)

				arg_271_1.text_.text = var_274_8

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 2 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 2)

				if (2 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 2)) > 0 and var_274_6 < var_274_10 then
					arg_271_1.talkMaxDuration = var_274_10

					if var_274_10 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_5
					end
				end

				arg_271_1.text_.text = var_274_8
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031064", "story_v_out_413031.awb") ~= 0 then
					local var_274_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031064", "story_v_out_413031.awb") / 1000

					if var_274_11 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_5
					end

					if var_274_7.prefab_name ~= "" and arg_271_1.actors_[var_274_7.prefab_name] ~= nil then
						local var_274_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_7.prefab_name].transform, "story_v_out_413031", "413031064", "story_v_out_413031.awb")

						arg_271_1:RecordAudio("413031064", var_274_12)
						arg_271_1:RecordAudio("413031064", var_274_12)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_413031", "413031064", "story_v_out_413031.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_413031", "413031064", "story_v_out_413031.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_6, arg_271_1.talkMaxDuration)

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_5) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_5 + var_274_13 and arg_271_1.time_ < var_274_5 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play413031065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 413031065
		arg_275_1.duration_ = 10.57

		local var_275_0 = {
			zh = 6.866,
			ja = 10.566
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
				arg_275_0:Play413031066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if arg_275_1.actors_["10096"] == nil then
				local var_278_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_278_0) then
					local var_278_1 = Object.Instantiate(var_278_0, arg_275_1.canvasGo_.transform)

					var_278_1.transform:SetSiblingIndex(1)

					var_278_1.name = "10096"
					var_278_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_275_1.actors_["10096"] = var_278_1

					if arg_275_1.isInRecall_ then
						for iter_278_0, iter_278_1 in ipairs((var_278_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_278_1.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_278_2 = arg_275_1.actors_["10096"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10096 = var_278_2.localPosition
				var_278_2.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10096", 2)

				for iter_278_2 = 0, var_278_2.childCount - 1 do
					local var_278_3 = var_278_2:GetChild(iter_278_2)

					if var_278_3.name == "" or not string.find(var_278_3.name, "split") then
						var_278_3.gameObject:SetActive(true)
					else
						var_278_3.gameObject:SetActive(false)
					end
				end
			end

			local var_278_4 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				var_278_2.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10096, Vector3.New(-390, -350, -210), (arg_275_1.time_ - 0) / var_278_4)
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				var_278_2.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_278_5 = arg_275_1.actors_["10096"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_5) and arg_275_1.var_.actorSpriteComps10096 == nil then
				arg_275_1.var_.actorSpriteComps10096 = var_278_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_6 = 2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_6 and not isNil(var_278_5) then
				if arg_275_1.var_.actorSpriteComps10096 then
					for iter_278_3, iter_278_4 in pairs(arg_275_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_278_4 then
							if arg_275_1.isInRecall_ then
								iter_278_4.color = Color.New(Mathf.Lerp(iter_278_4.color.r, arg_275_1.hightColor1.r, (arg_275_1.time_ - 0) / var_278_6), Mathf.Lerp(iter_278_4.color.g, arg_275_1.hightColor1.g, (arg_275_1.time_ - 0) / var_278_6), (Mathf.Lerp(iter_278_4.color.b, arg_275_1.hightColor1.b, (arg_275_1.time_ - 0) / var_278_6)))
							else
								local var_278_7 = Mathf.Lerp(iter_278_4.color.r, 1, (arg_275_1.time_ - 0) / var_278_6)

								iter_278_4.color = Color.New(var_278_7, var_278_7, var_278_7)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_6 and arg_275_1.time_ < 0 + var_278_6 + arg_278_0 and not isNil(var_278_5) and arg_275_1.var_.actorSpriteComps10096 then
				for iter_278_5, iter_278_6 in pairs(arg_275_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_278_6 then
						iter_278_6.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_275_1.var_.actorSpriteComps10096 = nil
			end

			local var_278_8 = arg_275_1.actors_["10093"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps10093 == nil then
				arg_275_1.var_.actorSpriteComps10093 = var_278_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_9 = 2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_9 and not isNil(var_278_8) then
				if arg_275_1.var_.actorSpriteComps10093 then
					for iter_278_7, iter_278_8 in pairs(arg_275_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_278_8 then
							if arg_275_1.isInRecall_ then
								iter_278_8.color = Color.New(Mathf.Lerp(iter_278_8.color.r, arg_275_1.hightColor2.r, (arg_275_1.time_ - 0) / var_278_9), Mathf.Lerp(iter_278_8.color.g, arg_275_1.hightColor2.g, (arg_275_1.time_ - 0) / var_278_9), (Mathf.Lerp(iter_278_8.color.b, arg_275_1.hightColor2.b, (arg_275_1.time_ - 0) / var_278_9)))
							else
								local var_278_10 = Mathf.Lerp(iter_278_8.color.r, 0.5, (arg_275_1.time_ - 0) / var_278_9)

								iter_278_8.color = Color.New(var_278_10, var_278_10, var_278_10)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_9 and arg_275_1.time_ < 0 + var_278_9 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps10093 then
				for iter_278_9, iter_278_10 in pairs(arg_275_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_278_10 then
						iter_278_10.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_275_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				local var_278_11 = arg_275_1.actors_["10096"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_278_11 then
					arg_275_1.var_.alphaOldValue10096 = var_278_11.alpha
					arg_275_1.var_.characterEffect10096 = var_278_11
				end

				arg_275_1.var_.alphaOldValue10096 = 0
			end

			local var_278_12 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_12 then
				if arg_275_1.var_.characterEffect10096 then
					arg_275_1.var_.characterEffect10096.alpha = Mathf.Lerp(arg_275_1.var_.alphaOldValue10096, 1, (arg_275_1.time_ - 0) / var_278_12)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_12 and arg_275_1.time_ < 0 + var_278_12 + arg_278_0 and arg_275_1.var_.characterEffect10096 then
				arg_275_1.var_.characterEffect10096.alpha = 1
			end

			local var_278_13 = arg_275_1.actors_["10093"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10093 = var_278_13.localPosition
				var_278_13.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10093", 4)

				for iter_278_11 = 0, var_278_13.childCount - 1 do
					local var_278_14 = var_278_13:GetChild(iter_278_11)

					if var_278_14.name == "" or not string.find(var_278_14.name, "split") then
						var_278_14.gameObject:SetActive(true)
					else
						var_278_14.gameObject:SetActive(false)
					end
				end
			end

			local var_278_15 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_15 then
				var_278_13.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_275_1.time_ - 0) / var_278_15)
			end

			if arg_275_1.time_ >= 0 + var_278_15 and arg_275_1.time_ < 0 + var_278_15 + arg_278_0 then
				var_278_13.localPosition = Vector3.New(390, -345, -245)
			end

			local var_278_16 = 0
			local var_278_17 = 0.475

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_16 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_18 = arg_275_1:GetWordFromCfg(413031065)
				local var_278_19 = arg_275_1:FormatText(var_278_18.content)

				arg_275_1.text_.text = var_278_19

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_21 = 19 <= 0 and var_278_17 or var_278_17 * (utf8.len(var_278_19) / 19)

				if (19 <= 0 and var_278_17 or var_278_17 * (utf8.len(var_278_19) / 19)) > 0 and var_278_17 < var_278_21 then
					arg_275_1.talkMaxDuration = var_278_21

					if var_278_21 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_21 + var_278_16
					end
				end

				arg_275_1.text_.text = var_278_19
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031065", "story_v_out_413031.awb") ~= 0 then
					local var_278_22 = manager.audio:GetVoiceLength("story_v_out_413031", "413031065", "story_v_out_413031.awb") / 1000

					if var_278_22 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_22 + var_278_16
					end

					if var_278_18.prefab_name ~= "" and arg_275_1.actors_[var_278_18.prefab_name] ~= nil then
						local var_278_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_18.prefab_name].transform, "story_v_out_413031", "413031065", "story_v_out_413031.awb")

						arg_275_1:RecordAudio("413031065", var_278_23)
						arg_275_1:RecordAudio("413031065", var_278_23)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_413031", "413031065", "story_v_out_413031.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_413031", "413031065", "story_v_out_413031.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_24 = math.max(var_278_17, arg_275_1.talkMaxDuration)

			if var_278_16 <= arg_275_1.time_ and arg_275_1.time_ < var_278_16 + var_278_24 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_16) / var_278_24

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_16 + var_278_24 and arg_275_1.time_ < var_278_16 + var_278_24 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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

		arg_275_1:InitPlayNodeList()
	end,
	Play413031066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 413031066
		arg_279_1.duration_ = 3.67

		local var_279_0 = {
			zh = 3.666,
			ja = 1.999999999999
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play413031067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["10093"]) and arg_279_1.var_.actorSpriteComps10093 == nil then
				arg_279_1.var_.actorSpriteComps10093 = arg_279_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_0 = 2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["10093"]) then
				if arg_279_1.var_.actorSpriteComps10093 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								iter_282_1.color = Color.New(Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, (arg_279_1.time_ - 0) / var_282_0), Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, (arg_279_1.time_ - 0) / var_282_0), (Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, (arg_279_1.time_ - 0) / var_282_0)))
							else
								local var_282_1 = Mathf.Lerp(iter_282_1.color.r, 1, (arg_279_1.time_ - 0) / var_282_0)

								iter_282_1.color = Color.New(var_282_1, var_282_1, var_282_1)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["10093"]) and arg_279_1.var_.actorSpriteComps10093 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_282_3 then
						iter_282_3.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps10093 = nil
			end

			local var_282_2 = arg_279_1.actors_["10096"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.actorSpriteComps10096 == nil then
				arg_279_1.var_.actorSpriteComps10096 = var_282_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_3 = 2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_3 and not isNil(var_282_2) then
				if arg_279_1.var_.actorSpriteComps10096 then
					for iter_282_4, iter_282_5 in pairs(arg_279_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_282_5 then
							if arg_279_1.isInRecall_ then
								iter_282_5.color = Color.New(Mathf.Lerp(iter_282_5.color.r, arg_279_1.hightColor2.r, (arg_279_1.time_ - 0) / var_282_3), Mathf.Lerp(iter_282_5.color.g, arg_279_1.hightColor2.g, (arg_279_1.time_ - 0) / var_282_3), (Mathf.Lerp(iter_282_5.color.b, arg_279_1.hightColor2.b, (arg_279_1.time_ - 0) / var_282_3)))
							else
								local var_282_4 = Mathf.Lerp(iter_282_5.color.r, 0.5, (arg_279_1.time_ - 0) / var_282_3)

								iter_282_5.color = Color.New(var_282_4, var_282_4, var_282_4)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_3 and arg_279_1.time_ < 0 + var_282_3 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.actorSpriteComps10096 then
				for iter_282_6, iter_282_7 in pairs(arg_279_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_282_7 then
						iter_282_7.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_279_1.var_.actorSpriteComps10096 = nil
			end

			local var_282_5 = 0
			local var_282_6 = 0.3

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_7 = arg_279_1:GetWordFromCfg(413031066)
				local var_282_8 = arg_279_1:FormatText(var_282_7.content)

				arg_279_1.text_.text = var_282_8

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_10 = 12 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 12)

				if (12 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 12)) > 0 and var_282_6 < var_282_10 then
					arg_279_1.talkMaxDuration = var_282_10

					if var_282_10 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_8
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031066", "story_v_out_413031.awb") ~= 0 then
					local var_282_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031066", "story_v_out_413031.awb") / 1000

					if var_282_11 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_5
					end

					if var_282_7.prefab_name ~= "" and arg_279_1.actors_[var_282_7.prefab_name] ~= nil then
						local var_282_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_7.prefab_name].transform, "story_v_out_413031", "413031066", "story_v_out_413031.awb")

						arg_279_1:RecordAudio("413031066", var_282_12)
						arg_279_1:RecordAudio("413031066", var_282_12)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_413031", "413031066", "story_v_out_413031.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_413031", "413031066", "story_v_out_413031.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_13 = math.max(var_282_6, arg_279_1.talkMaxDuration)

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_13 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_5) / var_282_13

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_5 + var_282_13 and arg_279_1.time_ < var_282_5 + var_282_13 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play413031067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 413031067
		arg_283_1.duration_ = 7.33

		local var_283_0 = {
			zh = 6.3,
			ja = 7.333
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
				arg_283_0:Play413031068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["10096"]) and arg_283_1.var_.actorSpriteComps10096 == nil then
				arg_283_1.var_.actorSpriteComps10096 = arg_283_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_0 = 2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["10096"]) then
				if arg_283_1.var_.actorSpriteComps10096 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								iter_286_1.color = Color.New(Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor1.r, (arg_283_1.time_ - 0) / var_286_0), Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor1.g, (arg_283_1.time_ - 0) / var_286_0), (Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor1.b, (arg_283_1.time_ - 0) / var_286_0)))
							else
								local var_286_1 = Mathf.Lerp(iter_286_1.color.r, 1, (arg_283_1.time_ - 0) / var_286_0)

								iter_286_1.color = Color.New(var_286_1, var_286_1, var_286_1)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["10096"]) and arg_283_1.var_.actorSpriteComps10096 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_286_3 then
						iter_286_3.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_283_1.var_.actorSpriteComps10096 = nil
			end

			local var_286_2 = arg_283_1.actors_["10093"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.actorSpriteComps10093 == nil then
				arg_283_1.var_.actorSpriteComps10093 = var_286_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_3 = 2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_3 and not isNil(var_286_2) then
				if arg_283_1.var_.actorSpriteComps10093 then
					for iter_286_4, iter_286_5 in pairs(arg_283_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_286_5 then
							if arg_283_1.isInRecall_ then
								iter_286_5.color = Color.New(Mathf.Lerp(iter_286_5.color.r, arg_283_1.hightColor2.r, (arg_283_1.time_ - 0) / var_286_3), Mathf.Lerp(iter_286_5.color.g, arg_283_1.hightColor2.g, (arg_283_1.time_ - 0) / var_286_3), (Mathf.Lerp(iter_286_5.color.b, arg_283_1.hightColor2.b, (arg_283_1.time_ - 0) / var_286_3)))
							else
								local var_286_4 = Mathf.Lerp(iter_286_5.color.r, 0.5, (arg_283_1.time_ - 0) / var_286_3)

								iter_286_5.color = Color.New(var_286_4, var_286_4, var_286_4)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_3 and arg_283_1.time_ < 0 + var_286_3 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.actorSpriteComps10093 then
				for iter_286_6, iter_286_7 in pairs(arg_283_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_286_7 then
						iter_286_7.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_283_1.var_.actorSpriteComps10093 = nil
			end

			local var_286_5 = 0
			local var_286_6 = 0.425

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_7 = arg_283_1:GetWordFromCfg(413031067)
				local var_286_8 = arg_283_1:FormatText(var_286_7.content)

				arg_283_1.text_.text = var_286_8

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_10 = 17 <= 0 and var_286_6 or var_286_6 * (utf8.len(var_286_8) / 17)

				if (17 <= 0 and var_286_6 or var_286_6 * (utf8.len(var_286_8) / 17)) > 0 and var_286_6 < var_286_10 then
					arg_283_1.talkMaxDuration = var_286_10

					if var_286_10 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_5
					end
				end

				arg_283_1.text_.text = var_286_8
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031067", "story_v_out_413031.awb") ~= 0 then
					local var_286_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031067", "story_v_out_413031.awb") / 1000

					if var_286_11 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_11 + var_286_5
					end

					if var_286_7.prefab_name ~= "" and arg_283_1.actors_[var_286_7.prefab_name] ~= nil then
						local var_286_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_7.prefab_name].transform, "story_v_out_413031", "413031067", "story_v_out_413031.awb")

						arg_283_1:RecordAudio("413031067", var_286_12)
						arg_283_1:RecordAudio("413031067", var_286_12)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_413031", "413031067", "story_v_out_413031.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_413031", "413031067", "story_v_out_413031.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_13 = math.max(var_286_6, arg_283_1.talkMaxDuration)

			if var_286_5 <= arg_283_1.time_ and arg_283_1.time_ < var_286_5 + var_286_13 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_5) / var_286_13

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_5 + var_286_13 and arg_283_1.time_ < var_286_5 + var_286_13 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play413031068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 413031068
		arg_287_1.duration_ = 2

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play413031069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["10093"]) and arg_287_1.var_.actorSpriteComps10093 == nil then
				arg_287_1.var_.actorSpriteComps10093 = arg_287_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_0 = 2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["10093"]) then
				if arg_287_1.var_.actorSpriteComps10093 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								iter_290_1.color = Color.New(Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor1.r, (arg_287_1.time_ - 0) / var_290_0), Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor1.g, (arg_287_1.time_ - 0) / var_290_0), (Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor1.b, (arg_287_1.time_ - 0) / var_290_0)))
							else
								local var_290_1 = Mathf.Lerp(iter_290_1.color.r, 1, (arg_287_1.time_ - 0) / var_290_0)

								iter_290_1.color = Color.New(var_290_1, var_290_1, var_290_1)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["10093"]) and arg_287_1.var_.actorSpriteComps10093 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_290_3 then
						iter_290_3.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_287_1.var_.actorSpriteComps10093 = nil
			end

			local var_290_2 = arg_287_1.actors_["10096"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.actorSpriteComps10096 == nil then
				arg_287_1.var_.actorSpriteComps10096 = var_290_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_3 = 2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_3 and not isNil(var_290_2) then
				if arg_287_1.var_.actorSpriteComps10096 then
					for iter_290_4, iter_290_5 in pairs(arg_287_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_290_5 then
							if arg_287_1.isInRecall_ then
								iter_290_5.color = Color.New(Mathf.Lerp(iter_290_5.color.r, arg_287_1.hightColor2.r, (arg_287_1.time_ - 0) / var_290_3), Mathf.Lerp(iter_290_5.color.g, arg_287_1.hightColor2.g, (arg_287_1.time_ - 0) / var_290_3), (Mathf.Lerp(iter_290_5.color.b, arg_287_1.hightColor2.b, (arg_287_1.time_ - 0) / var_290_3)))
							else
								local var_290_4 = Mathf.Lerp(iter_290_5.color.r, 0.5, (arg_287_1.time_ - 0) / var_290_3)

								iter_290_5.color = Color.New(var_290_4, var_290_4, var_290_4)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_3 and arg_287_1.time_ < 0 + var_290_3 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.actorSpriteComps10096 then
				for iter_290_6, iter_290_7 in pairs(arg_287_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_290_7 then
						iter_290_7.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_287_1.var_.actorSpriteComps10096 = nil
			end

			local var_290_5 = 0
			local var_290_6 = 0.225

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_7 = arg_287_1:GetWordFromCfg(413031068)
				local var_290_8 = arg_287_1:FormatText(var_290_7.content)

				arg_287_1.text_.text = var_290_8

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_10 = 9 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 9)

				if (9 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 9)) > 0 and var_290_6 < var_290_10 then
					arg_287_1.talkMaxDuration = var_290_10

					if var_290_10 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_5
					end
				end

				arg_287_1.text_.text = var_290_8
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031068", "story_v_out_413031.awb") ~= 0 then
					local var_290_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031068", "story_v_out_413031.awb") / 1000

					if var_290_11 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_11 + var_290_5
					end

					if var_290_7.prefab_name ~= "" and arg_287_1.actors_[var_290_7.prefab_name] ~= nil then
						local var_290_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_7.prefab_name].transform, "story_v_out_413031", "413031068", "story_v_out_413031.awb")

						arg_287_1:RecordAudio("413031068", var_290_12)
						arg_287_1:RecordAudio("413031068", var_290_12)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_413031", "413031068", "story_v_out_413031.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_413031", "413031068", "story_v_out_413031.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_13 = math.max(var_290_6, arg_287_1.talkMaxDuration)

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_13 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_5) / var_290_13

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_5 + var_290_13 and arg_287_1.time_ < var_290_5 + var_290_13 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play413031069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 413031069
		arg_291_1.duration_ = 11.9

		local var_291_0 = {
			zh = 4.033,
			ja = 11.9
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
				arg_291_0:Play413031070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["10096"]) and arg_291_1.var_.actorSpriteComps10096 == nil then
				arg_291_1.var_.actorSpriteComps10096 = arg_291_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["10096"]) then
				if arg_291_1.var_.actorSpriteComps10096 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								iter_294_1.color = Color.New(Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor1.r, (arg_291_1.time_ - 0) / var_294_0), Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor1.g, (arg_291_1.time_ - 0) / var_294_0), (Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor1.b, (arg_291_1.time_ - 0) / var_294_0)))
							else
								local var_294_1 = Mathf.Lerp(iter_294_1.color.r, 1, (arg_291_1.time_ - 0) / var_294_0)

								iter_294_1.color = Color.New(var_294_1, var_294_1, var_294_1)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["10096"]) and arg_291_1.var_.actorSpriteComps10096 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_291_1.var_.actorSpriteComps10096 = nil
			end

			local var_294_2 = arg_291_1.actors_["10093"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps10093 == nil then
				arg_291_1.var_.actorSpriteComps10093 = var_294_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_3 = 2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_3 and not isNil(var_294_2) then
				if arg_291_1.var_.actorSpriteComps10093 then
					for iter_294_4, iter_294_5 in pairs(arg_291_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_294_5 then
							if arg_291_1.isInRecall_ then
								iter_294_5.color = Color.New(Mathf.Lerp(iter_294_5.color.r, arg_291_1.hightColor2.r, (arg_291_1.time_ - 0) / var_294_3), Mathf.Lerp(iter_294_5.color.g, arg_291_1.hightColor2.g, (arg_291_1.time_ - 0) / var_294_3), (Mathf.Lerp(iter_294_5.color.b, arg_291_1.hightColor2.b, (arg_291_1.time_ - 0) / var_294_3)))
							else
								local var_294_4 = Mathf.Lerp(iter_294_5.color.r, 0.5, (arg_291_1.time_ - 0) / var_294_3)

								iter_294_5.color = Color.New(var_294_4, var_294_4, var_294_4)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_3 and arg_291_1.time_ < 0 + var_294_3 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps10093 then
				for iter_294_6, iter_294_7 in pairs(arg_291_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_294_7 then
						iter_294_7.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps10093 = nil
			end

			local var_294_5 = 0
			local var_294_6 = 0.35

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_7 = arg_291_1:GetWordFromCfg(413031069)
				local var_294_8 = arg_291_1:FormatText(var_294_7.content)

				arg_291_1.text_.text = var_294_8

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_10 = 14 <= 0 and var_294_6 or var_294_6 * (utf8.len(var_294_8) / 14)

				if (14 <= 0 and var_294_6 or var_294_6 * (utf8.len(var_294_8) / 14)) > 0 and var_294_6 < var_294_10 then
					arg_291_1.talkMaxDuration = var_294_10

					if var_294_10 + var_294_5 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_10 + var_294_5
					end
				end

				arg_291_1.text_.text = var_294_8
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031069", "story_v_out_413031.awb") ~= 0 then
					local var_294_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031069", "story_v_out_413031.awb") / 1000

					if var_294_11 + var_294_5 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_11 + var_294_5
					end

					if var_294_7.prefab_name ~= "" and arg_291_1.actors_[var_294_7.prefab_name] ~= nil then
						local var_294_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_7.prefab_name].transform, "story_v_out_413031", "413031069", "story_v_out_413031.awb")

						arg_291_1:RecordAudio("413031069", var_294_12)
						arg_291_1:RecordAudio("413031069", var_294_12)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_413031", "413031069", "story_v_out_413031.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_413031", "413031069", "story_v_out_413031.awb")
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

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play413031070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 413031070
		arg_295_1.duration_ = 8.13

		local var_295_0 = {
			zh = 3.7,
			ja = 8.133
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
				arg_295_0:Play413031071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10093 = arg_295_1.actors_["10093"].transform.localPosition
				arg_295_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10093", 4)

				for iter_298_0 = 0, arg_295_1.actors_["10093"].transform.childCount - 1 do
					local var_298_0 = arg_295_1.actors_["10093"].transform:GetChild(iter_298_0)

					if var_298_0.name == "split_3" or not string.find(var_298_0.name, "split") then
						var_298_0.gameObject:SetActive(true)
					else
						var_298_0.gameObject:SetActive(false)
					end
				end
			end

			local var_298_1 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_1 then
				arg_295_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_295_1.time_ - 0) / var_298_1)
			end

			if arg_295_1.time_ >= 0 + var_298_1 and arg_295_1.time_ < 0 + var_298_1 + arg_298_0 then
				arg_295_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_298_2 = arg_295_1.actors_["10093"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.actorSpriteComps10093 == nil then
				arg_295_1.var_.actorSpriteComps10093 = var_298_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_3 = 2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_3 and not isNil(var_298_2) then
				if arg_295_1.var_.actorSpriteComps10093 then
					for iter_298_1, iter_298_2 in pairs(arg_295_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_298_2 then
							if arg_295_1.isInRecall_ then
								iter_298_2.color = Color.New(Mathf.Lerp(iter_298_2.color.r, arg_295_1.hightColor1.r, (arg_295_1.time_ - 0) / var_298_3), Mathf.Lerp(iter_298_2.color.g, arg_295_1.hightColor1.g, (arg_295_1.time_ - 0) / var_298_3), (Mathf.Lerp(iter_298_2.color.b, arg_295_1.hightColor1.b, (arg_295_1.time_ - 0) / var_298_3)))
							else
								local var_298_4 = Mathf.Lerp(iter_298_2.color.r, 1, (arg_295_1.time_ - 0) / var_298_3)

								iter_298_2.color = Color.New(var_298_4, var_298_4, var_298_4)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_3 and arg_295_1.time_ < 0 + var_298_3 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.actorSpriteComps10093 then
				for iter_298_3, iter_298_4 in pairs(arg_295_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_298_4 then
						iter_298_4.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_295_1.var_.actorSpriteComps10093 = nil
			end

			local var_298_5 = arg_295_1.actors_["10096"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_5) and arg_295_1.var_.actorSpriteComps10096 == nil then
				arg_295_1.var_.actorSpriteComps10096 = var_298_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_6 = 2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_6 and not isNil(var_298_5) then
				if arg_295_1.var_.actorSpriteComps10096 then
					for iter_298_5, iter_298_6 in pairs(arg_295_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_298_6 then
							if arg_295_1.isInRecall_ then
								iter_298_6.color = Color.New(Mathf.Lerp(iter_298_6.color.r, arg_295_1.hightColor2.r, (arg_295_1.time_ - 0) / var_298_6), Mathf.Lerp(iter_298_6.color.g, arg_295_1.hightColor2.g, (arg_295_1.time_ - 0) / var_298_6), (Mathf.Lerp(iter_298_6.color.b, arg_295_1.hightColor2.b, (arg_295_1.time_ - 0) / var_298_6)))
							else
								local var_298_7 = Mathf.Lerp(iter_298_6.color.r, 0.5, (arg_295_1.time_ - 0) / var_298_6)

								iter_298_6.color = Color.New(var_298_7, var_298_7, var_298_7)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_6 and arg_295_1.time_ < 0 + var_298_6 + arg_298_0 and not isNil(var_298_5) and arg_295_1.var_.actorSpriteComps10096 then
				for iter_298_7, iter_298_8 in pairs(arg_295_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_298_8 then
						iter_298_8.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_295_1.var_.actorSpriteComps10096 = nil
			end

			local var_298_8 = 0
			local var_298_9 = 0.45

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_10 = arg_295_1:GetWordFromCfg(413031070)
				local var_298_11 = arg_295_1:FormatText(var_298_10.content)

				arg_295_1.text_.text = var_298_11

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_13 = 18 <= 0 and var_298_9 or var_298_9 * (utf8.len(var_298_11) / 18)

				if (18 <= 0 and var_298_9 or var_298_9 * (utf8.len(var_298_11) / 18)) > 0 and var_298_9 < var_298_13 then
					arg_295_1.talkMaxDuration = var_298_13

					if var_298_13 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_13 + var_298_8
					end
				end

				arg_295_1.text_.text = var_298_11
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031070", "story_v_out_413031.awb") ~= 0 then
					local var_298_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031070", "story_v_out_413031.awb") / 1000

					if var_298_14 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_14 + var_298_8
					end

					if var_298_10.prefab_name ~= "" and arg_295_1.actors_[var_298_10.prefab_name] ~= nil then
						local var_298_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_10.prefab_name].transform, "story_v_out_413031", "413031070", "story_v_out_413031.awb")

						arg_295_1:RecordAudio("413031070", var_298_15)
						arg_295_1:RecordAudio("413031070", var_298_15)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_413031", "413031070", "story_v_out_413031.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_413031", "413031070", "story_v_out_413031.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_16 = math.max(var_298_9, arg_295_1.talkMaxDuration)

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_16 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_8) / var_298_16

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_8 + var_298_16 and arg_295_1.time_ < var_298_8 + var_298_16 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play413031071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 413031071
		arg_299_1.duration_ = 9.17

		local var_299_0 = {
			zh = 8.5,
			ja = 9.166
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
				arg_299_0:Play413031072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["10096"]) and arg_299_1.var_.actorSpriteComps10096 == nil then
				arg_299_1.var_.actorSpriteComps10096 = arg_299_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_0 = 2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["10096"]) then
				if arg_299_1.var_.actorSpriteComps10096 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_302_1 then
							if arg_299_1.isInRecall_ then
								iter_302_1.color = Color.New(Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor1.r, (arg_299_1.time_ - 0) / var_302_0), Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor1.g, (arg_299_1.time_ - 0) / var_302_0), (Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor1.b, (arg_299_1.time_ - 0) / var_302_0)))
							else
								local var_302_1 = Mathf.Lerp(iter_302_1.color.r, 1, (arg_299_1.time_ - 0) / var_302_0)

								iter_302_1.color = Color.New(var_302_1, var_302_1, var_302_1)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["10096"]) and arg_299_1.var_.actorSpriteComps10096 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_302_3 then
						iter_302_3.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_299_1.var_.actorSpriteComps10096 = nil
			end

			local var_302_2 = arg_299_1.actors_["10093"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10093 == nil then
				arg_299_1.var_.actorSpriteComps10093 = var_302_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_3 = 2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_3 and not isNil(var_302_2) then
				if arg_299_1.var_.actorSpriteComps10093 then
					for iter_302_4, iter_302_5 in pairs(arg_299_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_302_5 then
							if arg_299_1.isInRecall_ then
								iter_302_5.color = Color.New(Mathf.Lerp(iter_302_5.color.r, arg_299_1.hightColor2.r, (arg_299_1.time_ - 0) / var_302_3), Mathf.Lerp(iter_302_5.color.g, arg_299_1.hightColor2.g, (arg_299_1.time_ - 0) / var_302_3), (Mathf.Lerp(iter_302_5.color.b, arg_299_1.hightColor2.b, (arg_299_1.time_ - 0) / var_302_3)))
							else
								local var_302_4 = Mathf.Lerp(iter_302_5.color.r, 0.5, (arg_299_1.time_ - 0) / var_302_3)

								iter_302_5.color = Color.New(var_302_4, var_302_4, var_302_4)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_3 and arg_299_1.time_ < 0 + var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10093 then
				for iter_302_6, iter_302_7 in pairs(arg_299_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_302_7 then
						iter_302_7.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_299_1.var_.actorSpriteComps10093 = nil
			end

			local var_302_5 = 0
			local var_302_6 = 0.775

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_7 = arg_299_1:GetWordFromCfg(413031071)
				local var_302_8 = arg_299_1:FormatText(var_302_7.content)

				arg_299_1.text_.text = var_302_8

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_10 = 31 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 31)

				if (31 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 31)) > 0 and var_302_6 < var_302_10 then
					arg_299_1.talkMaxDuration = var_302_10

					if var_302_10 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_5
					end
				end

				arg_299_1.text_.text = var_302_8
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031071", "story_v_out_413031.awb") ~= 0 then
					local var_302_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031071", "story_v_out_413031.awb") / 1000

					if var_302_11 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_11 + var_302_5
					end

					if var_302_7.prefab_name ~= "" and arg_299_1.actors_[var_302_7.prefab_name] ~= nil then
						local var_302_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_7.prefab_name].transform, "story_v_out_413031", "413031071", "story_v_out_413031.awb")

						arg_299_1:RecordAudio("413031071", var_302_12)
						arg_299_1:RecordAudio("413031071", var_302_12)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_413031", "413031071", "story_v_out_413031.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_413031", "413031071", "story_v_out_413031.awb")
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

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play413031072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 413031072
		arg_303_1.duration_ = 3.13

		local var_303_0 = {
			zh = 1.999999999999,
			ja = 3.133
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
				arg_303_0:Play413031073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos10093 = arg_303_1.actors_["10093"].transform.localPosition
				arg_303_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("10093", 4)

				for iter_306_0 = 0, arg_303_1.actors_["10093"].transform.childCount - 1 do
					local var_306_0 = arg_303_1.actors_["10093"].transform:GetChild(iter_306_0)

					if var_306_0.name == "" or not string.find(var_306_0.name, "split") then
						var_306_0.gameObject:SetActive(true)
					else
						var_306_0.gameObject:SetActive(false)
					end
				end
			end

			local var_306_1 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_1 then
				arg_303_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_303_1.time_ - 0) / var_306_1)
			end

			if arg_303_1.time_ >= 0 + var_306_1 and arg_303_1.time_ < 0 + var_306_1 + arg_306_0 then
				arg_303_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_306_2 = arg_303_1.actors_["10093"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_2) and arg_303_1.var_.actorSpriteComps10093 == nil then
				arg_303_1.var_.actorSpriteComps10093 = var_306_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_3 = 2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_3 and not isNil(var_306_2) then
				if arg_303_1.var_.actorSpriteComps10093 then
					for iter_306_1, iter_306_2 in pairs(arg_303_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_306_2 then
							if arg_303_1.isInRecall_ then
								iter_306_2.color = Color.New(Mathf.Lerp(iter_306_2.color.r, arg_303_1.hightColor1.r, (arg_303_1.time_ - 0) / var_306_3), Mathf.Lerp(iter_306_2.color.g, arg_303_1.hightColor1.g, (arg_303_1.time_ - 0) / var_306_3), (Mathf.Lerp(iter_306_2.color.b, arg_303_1.hightColor1.b, (arg_303_1.time_ - 0) / var_306_3)))
							else
								local var_306_4 = Mathf.Lerp(iter_306_2.color.r, 1, (arg_303_1.time_ - 0) / var_306_3)

								iter_306_2.color = Color.New(var_306_4, var_306_4, var_306_4)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_3 and arg_303_1.time_ < 0 + var_306_3 + arg_306_0 and not isNil(var_306_2) and arg_303_1.var_.actorSpriteComps10093 then
				for iter_306_3, iter_306_4 in pairs(arg_303_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_306_4 then
						iter_306_4.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_303_1.var_.actorSpriteComps10093 = nil
			end

			local var_306_5 = arg_303_1.actors_["10096"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.actorSpriteComps10096 == nil then
				arg_303_1.var_.actorSpriteComps10096 = var_306_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_6 = 2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_6 and not isNil(var_306_5) then
				if arg_303_1.var_.actorSpriteComps10096 then
					for iter_306_5, iter_306_6 in pairs(arg_303_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_306_6 then
							if arg_303_1.isInRecall_ then
								iter_306_6.color = Color.New(Mathf.Lerp(iter_306_6.color.r, arg_303_1.hightColor2.r, (arg_303_1.time_ - 0) / var_306_6), Mathf.Lerp(iter_306_6.color.g, arg_303_1.hightColor2.g, (arg_303_1.time_ - 0) / var_306_6), (Mathf.Lerp(iter_306_6.color.b, arg_303_1.hightColor2.b, (arg_303_1.time_ - 0) / var_306_6)))
							else
								local var_306_7 = Mathf.Lerp(iter_306_6.color.r, 0.5, (arg_303_1.time_ - 0) / var_306_6)

								iter_306_6.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_6 and arg_303_1.time_ < 0 + var_306_6 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.actorSpriteComps10096 then
				for iter_306_7, iter_306_8 in pairs(arg_303_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_306_8 then
						iter_306_8.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_303_1.var_.actorSpriteComps10096 = nil
			end

			local var_306_8 = 0
			local var_306_9 = 0.2

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_10 = arg_303_1:GetWordFromCfg(413031072)
				local var_306_11 = arg_303_1:FormatText(var_306_10.content)

				arg_303_1.text_.text = var_306_11

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_13 = 8 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 8)

				if (8 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 8)) > 0 and var_306_9 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_8
					end
				end

				arg_303_1.text_.text = var_306_11
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031072", "story_v_out_413031.awb") ~= 0 then
					local var_306_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031072", "story_v_out_413031.awb") / 1000

					if var_306_14 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_8
					end

					if var_306_10.prefab_name ~= "" and arg_303_1.actors_[var_306_10.prefab_name] ~= nil then
						local var_306_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_10.prefab_name].transform, "story_v_out_413031", "413031072", "story_v_out_413031.awb")

						arg_303_1:RecordAudio("413031072", var_306_15)
						arg_303_1:RecordAudio("413031072", var_306_15)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_413031", "413031072", "story_v_out_413031.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_413031", "413031072", "story_v_out_413031.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_16 = math.max(var_306_9, arg_303_1.talkMaxDuration)

			if var_306_8 <= arg_303_1.time_ and arg_303_1.time_ < var_306_8 + var_306_16 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_8) / var_306_16

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_8 + var_306_16 and arg_303_1.time_ < var_306_8 + var_306_16 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play413031073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 413031073
		arg_307_1.duration_ = 10.73

		local var_307_0 = {
			zh = 5.266,
			ja = 10.733
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
				arg_307_0:Play413031074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["10096"]) and arg_307_1.var_.actorSpriteComps10096 == nil then
				arg_307_1.var_.actorSpriteComps10096 = arg_307_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_0 = 2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["10096"]) then
				if arg_307_1.var_.actorSpriteComps10096 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["10096"]) and arg_307_1.var_.actorSpriteComps10096 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_310_3 then
						iter_310_3.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_307_1.var_.actorSpriteComps10096 = nil
			end

			local var_310_2 = arg_307_1.actors_["10093"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps10093 == nil then
				arg_307_1.var_.actorSpriteComps10093 = var_310_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_3 = 2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_3 and not isNil(var_310_2) then
				if arg_307_1.var_.actorSpriteComps10093 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_307_1.time_ >= 0 + var_310_3 and arg_307_1.time_ < 0 + var_310_3 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps10093 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_310_7 then
						iter_310_7.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_307_1.var_.actorSpriteComps10093 = nil
			end

			local var_310_5 = 0
			local var_310_6 = 0.575

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_7 = arg_307_1:GetWordFromCfg(413031073)
				local var_310_8 = arg_307_1:FormatText(var_310_7.content)

				arg_307_1.text_.text = var_310_8

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_10 = 23 <= 0 and var_310_6 or var_310_6 * (utf8.len(var_310_8) / 23)

				if (23 <= 0 and var_310_6 or var_310_6 * (utf8.len(var_310_8) / 23)) > 0 and var_310_6 < var_310_10 then
					arg_307_1.talkMaxDuration = var_310_10

					if var_310_10 + var_310_5 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_5
					end
				end

				arg_307_1.text_.text = var_310_8
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031073", "story_v_out_413031.awb") ~= 0 then
					local var_310_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031073", "story_v_out_413031.awb") / 1000

					if var_310_11 + var_310_5 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_11 + var_310_5
					end

					if var_310_7.prefab_name ~= "" and arg_307_1.actors_[var_310_7.prefab_name] ~= nil then
						local var_310_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_7.prefab_name].transform, "story_v_out_413031", "413031073", "story_v_out_413031.awb")

						arg_307_1:RecordAudio("413031073", var_310_12)
						arg_307_1:RecordAudio("413031073", var_310_12)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_413031", "413031073", "story_v_out_413031.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_413031", "413031073", "story_v_out_413031.awb")
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
	Play413031074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 413031074
		arg_311_1.duration_ = 10.73

		local var_311_0 = {
			zh = 7.166,
			ja = 10.733
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
				arg_311_0:Play413031075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.6

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:GetWordFromCfg(413031074)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 24 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 24)

				if (24 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 24)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031074", "story_v_out_413031.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031074", "story_v_out_413031.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_out_413031", "413031074", "story_v_out_413031.awb")

						arg_311_1:RecordAudio("413031074", var_314_6)
						arg_311_1:RecordAudio("413031074", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_413031", "413031074", "story_v_out_413031.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_413031", "413031074", "story_v_out_413031.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play413031075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 413031075
		arg_315_1.duration_ = 4

		local var_315_0 = {
			zh = 2.5,
			ja = 4
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
				arg_315_0:Play413031076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["10093"]) and arg_315_1.var_.actorSpriteComps10093 == nil then
				arg_315_1.var_.actorSpriteComps10093 = arg_315_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_0 = 2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["10093"]) then
				if arg_315_1.var_.actorSpriteComps10093 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								iter_318_1.color = Color.New(Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, (arg_315_1.time_ - 0) / var_318_0), Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, (arg_315_1.time_ - 0) / var_318_0), (Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, (arg_315_1.time_ - 0) / var_318_0)))
							else
								local var_318_1 = Mathf.Lerp(iter_318_1.color.r, 1, (arg_315_1.time_ - 0) / var_318_0)

								iter_318_1.color = Color.New(var_318_1, var_318_1, var_318_1)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["10093"]) and arg_315_1.var_.actorSpriteComps10093 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_318_3 then
						iter_318_3.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_315_1.var_.actorSpriteComps10093 = nil
			end

			local var_318_2 = arg_315_1.actors_["10096"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps10096 == nil then
				arg_315_1.var_.actorSpriteComps10096 = var_318_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_3 = 2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_3 and not isNil(var_318_2) then
				if arg_315_1.var_.actorSpriteComps10096 then
					for iter_318_4, iter_318_5 in pairs(arg_315_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_318_5 then
							if arg_315_1.isInRecall_ then
								iter_318_5.color = Color.New(Mathf.Lerp(iter_318_5.color.r, arg_315_1.hightColor2.r, (arg_315_1.time_ - 0) / var_318_3), Mathf.Lerp(iter_318_5.color.g, arg_315_1.hightColor2.g, (arg_315_1.time_ - 0) / var_318_3), (Mathf.Lerp(iter_318_5.color.b, arg_315_1.hightColor2.b, (arg_315_1.time_ - 0) / var_318_3)))
							else
								local var_318_4 = Mathf.Lerp(iter_318_5.color.r, 0.5, (arg_315_1.time_ - 0) / var_318_3)

								iter_318_5.color = Color.New(var_318_4, var_318_4, var_318_4)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_3 and arg_315_1.time_ < 0 + var_318_3 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps10096 then
				for iter_318_6, iter_318_7 in pairs(arg_315_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_318_7 then
						iter_318_7.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_315_1.var_.actorSpriteComps10096 = nil
			end

			local var_318_5 = 0
			local var_318_6 = 0.4

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_5 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_7 = arg_315_1:GetWordFromCfg(413031075)
				local var_318_8 = arg_315_1:FormatText(var_318_7.content)

				arg_315_1.text_.text = var_318_8

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_10 = 16 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 16)

				if (16 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 16)) > 0 and var_318_6 < var_318_10 then
					arg_315_1.talkMaxDuration = var_318_10

					if var_318_10 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_10 + var_318_5
					end
				end

				arg_315_1.text_.text = var_318_8
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031075", "story_v_out_413031.awb") ~= 0 then
					local var_318_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031075", "story_v_out_413031.awb") / 1000

					if var_318_11 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_11 + var_318_5
					end

					if var_318_7.prefab_name ~= "" and arg_315_1.actors_[var_318_7.prefab_name] ~= nil then
						local var_318_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_7.prefab_name].transform, "story_v_out_413031", "413031075", "story_v_out_413031.awb")

						arg_315_1:RecordAudio("413031075", var_318_12)
						arg_315_1:RecordAudio("413031075", var_318_12)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_413031", "413031075", "story_v_out_413031.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_413031", "413031075", "story_v_out_413031.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_13 = math.max(var_318_6, arg_315_1.talkMaxDuration)

			if var_318_5 <= arg_315_1.time_ and arg_315_1.time_ < var_318_5 + var_318_13 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_5) / var_318_13

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_5 + var_318_13 and arg_315_1.time_ < var_318_5 + var_318_13 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play413031076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 413031076
		arg_319_1.duration_ = 15.23

		local var_319_0 = {
			zh = 8,
			ja = 15.233
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
				arg_319_0:Play413031077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos10096 = arg_319_1.actors_["10096"].transform.localPosition
				arg_319_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("10096", 2)

				for iter_322_0 = 0, arg_319_1.actors_["10096"].transform.childCount - 1 do
					local var_322_0 = arg_319_1.actors_["10096"].transform:GetChild(iter_322_0)

					if var_322_0.name == "" or not string.find(var_322_0.name, "split") then
						var_322_0.gameObject:SetActive(true)
					else
						var_322_0.gameObject:SetActive(false)
					end
				end
			end

			local var_322_1 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 then
				arg_319_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10096, Vector3.New(-390, -350, -210), (arg_319_1.time_ - 0) / var_322_1)
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 then
				arg_319_1.actors_["10096"].transform.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_322_2 = arg_319_1.actors_["10096"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.actorSpriteComps10096 == nil then
				arg_319_1.var_.actorSpriteComps10096 = var_322_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_3 = 2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_3 and not isNil(var_322_2) then
				if arg_319_1.var_.actorSpriteComps10096 then
					for iter_322_1, iter_322_2 in pairs(arg_319_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_322_2 then
							if arg_319_1.isInRecall_ then
								iter_322_2.color = Color.New(Mathf.Lerp(iter_322_2.color.r, arg_319_1.hightColor1.r, (arg_319_1.time_ - 0) / var_322_3), Mathf.Lerp(iter_322_2.color.g, arg_319_1.hightColor1.g, (arg_319_1.time_ - 0) / var_322_3), (Mathf.Lerp(iter_322_2.color.b, arg_319_1.hightColor1.b, (arg_319_1.time_ - 0) / var_322_3)))
							else
								local var_322_4 = Mathf.Lerp(iter_322_2.color.r, 1, (arg_319_1.time_ - 0) / var_322_3)

								iter_322_2.color = Color.New(var_322_4, var_322_4, var_322_4)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_3 and arg_319_1.time_ < 0 + var_322_3 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.actorSpriteComps10096 then
				for iter_322_3, iter_322_4 in pairs(arg_319_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_322_4 then
						iter_322_4.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_319_1.var_.actorSpriteComps10096 = nil
			end

			local var_322_5 = arg_319_1.actors_["10093"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.actorSpriteComps10093 == nil then
				arg_319_1.var_.actorSpriteComps10093 = var_322_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_6 = 2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_6 and not isNil(var_322_5) then
				if arg_319_1.var_.actorSpriteComps10093 then
					for iter_322_5, iter_322_6 in pairs(arg_319_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_322_6 then
							if arg_319_1.isInRecall_ then
								iter_322_6.color = Color.New(Mathf.Lerp(iter_322_6.color.r, arg_319_1.hightColor2.r, (arg_319_1.time_ - 0) / var_322_6), Mathf.Lerp(iter_322_6.color.g, arg_319_1.hightColor2.g, (arg_319_1.time_ - 0) / var_322_6), (Mathf.Lerp(iter_322_6.color.b, arg_319_1.hightColor2.b, (arg_319_1.time_ - 0) / var_322_6)))
							else
								local var_322_7 = Mathf.Lerp(iter_322_6.color.r, 0.5, (arg_319_1.time_ - 0) / var_322_6)

								iter_322_6.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_6 and arg_319_1.time_ < 0 + var_322_6 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.actorSpriteComps10093 then
				for iter_322_7, iter_322_8 in pairs(arg_319_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_322_8 then
						iter_322_8.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_319_1.var_.actorSpriteComps10093 = nil
			end

			local var_322_8 = 0
			local var_322_9 = 0.725

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_10 = arg_319_1:GetWordFromCfg(413031076)
				local var_322_11 = arg_319_1:FormatText(var_322_10.content)

				arg_319_1.text_.text = var_322_11

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_13 = 29 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 29)

				if (29 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 29)) > 0 and var_322_9 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_8
					end
				end

				arg_319_1.text_.text = var_322_11
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031076", "story_v_out_413031.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031076", "story_v_out_413031.awb") / 1000

					if var_322_14 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_8
					end

					if var_322_10.prefab_name ~= "" and arg_319_1.actors_[var_322_10.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_10.prefab_name].transform, "story_v_out_413031", "413031076", "story_v_out_413031.awb")

						arg_319_1:RecordAudio("413031076", var_322_15)
						arg_319_1:RecordAudio("413031076", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_413031", "413031076", "story_v_out_413031.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_413031", "413031076", "story_v_out_413031.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_9, arg_319_1.talkMaxDuration)

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_8) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_8 + var_322_16 and arg_319_1.time_ < var_322_8 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413031077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 413031077
		arg_323_1.duration_ = 7.9

		local var_323_0 = {
			zh = 3.466,
			ja = 7.9
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
				arg_323_0:Play413031078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0.3

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_1 = arg_323_1:GetWordFromCfg(413031077)
				local var_326_2 = arg_323_1:FormatText(var_326_1.content)

				arg_323_1.text_.text = var_326_2

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_4 = 12 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 12)

				if (12 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 12)) > 0 and var_326_0 < var_326_4 then
					arg_323_1.talkMaxDuration = var_326_4

					if var_326_4 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_4 + 0
					end
				end

				arg_323_1.text_.text = var_326_2
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031077", "story_v_out_413031.awb") ~= 0 then
					local var_326_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031077", "story_v_out_413031.awb") / 1000

					if var_326_5 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + 0
					end

					if var_326_1.prefab_name ~= "" and arg_323_1.actors_[var_326_1.prefab_name] ~= nil then
						local var_326_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_1.prefab_name].transform, "story_v_out_413031", "413031077", "story_v_out_413031.awb")

						arg_323_1:RecordAudio("413031077", var_326_6)
						arg_323_1:RecordAudio("413031077", var_326_6)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_413031", "413031077", "story_v_out_413031.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_413031", "413031077", "story_v_out_413031.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_7 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_7 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_7

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_7 and arg_323_1.time_ < 0 + var_326_7 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play413031078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 413031078
		arg_327_1.duration_ = 2.9

		local var_327_0 = {
			zh = 1.999999999999,
			ja = 2.9
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
				arg_327_0:Play413031079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos10093 = arg_327_1.actors_["10093"].transform.localPosition
				arg_327_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10093", 4)

				for iter_330_0 = 0, arg_327_1.actors_["10093"].transform.childCount - 1 do
					local var_330_0 = arg_327_1.actors_["10093"].transform:GetChild(iter_330_0)

					if var_330_0.name == "split_3" or not string.find(var_330_0.name, "split") then
						var_330_0.gameObject:SetActive(true)
					else
						var_330_0.gameObject:SetActive(false)
					end
				end
			end

			local var_330_1 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_1 then
				arg_327_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_327_1.time_ - 0) / var_330_1)
			end

			if arg_327_1.time_ >= 0 + var_330_1 and arg_327_1.time_ < 0 + var_330_1 + arg_330_0 then
				arg_327_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_330_2 = arg_327_1.actors_["10096"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos10096 = var_330_2.localPosition
				var_330_2.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10096", 2)

				for iter_330_1 = 0, var_330_2.childCount - 1 do
					local var_330_3 = var_330_2:GetChild(iter_330_1)

					if var_330_3.name == "" or not string.find(var_330_3.name, "split") then
						var_330_3.gameObject:SetActive(true)
					else
						var_330_3.gameObject:SetActive(false)
					end
				end
			end

			local var_330_4 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				var_330_2.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10096, Vector3.New(-390, -350, -210), (arg_327_1.time_ - 0) / var_330_4)
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				var_330_2.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_330_5 = arg_327_1.actors_["10093"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_5) and arg_327_1.var_.actorSpriteComps10093 == nil then
				arg_327_1.var_.actorSpriteComps10093 = var_330_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_6 = 2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_6 and not isNil(var_330_5) then
				if arg_327_1.var_.actorSpriteComps10093 then
					for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_330_3 then
							if arg_327_1.isInRecall_ then
								iter_330_3.color = Color.New(Mathf.Lerp(iter_330_3.color.r, arg_327_1.hightColor1.r, (arg_327_1.time_ - 0) / var_330_6), Mathf.Lerp(iter_330_3.color.g, arg_327_1.hightColor1.g, (arg_327_1.time_ - 0) / var_330_6), (Mathf.Lerp(iter_330_3.color.b, arg_327_1.hightColor1.b, (arg_327_1.time_ - 0) / var_330_6)))
							else
								local var_330_7 = Mathf.Lerp(iter_330_3.color.r, 1, (arg_327_1.time_ - 0) / var_330_6)

								iter_330_3.color = Color.New(var_330_7, var_330_7, var_330_7)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_6 and arg_327_1.time_ < 0 + var_330_6 + arg_330_0 and not isNil(var_330_5) and arg_327_1.var_.actorSpriteComps10093 then
				for iter_330_4, iter_330_5 in pairs(arg_327_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_330_5 then
						iter_330_5.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_327_1.var_.actorSpriteComps10093 = nil
			end

			local var_330_8 = arg_327_1.actors_["10096"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_8) and arg_327_1.var_.actorSpriteComps10096 == nil then
				arg_327_1.var_.actorSpriteComps10096 = var_330_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_9 = 2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_9 and not isNil(var_330_8) then
				if arg_327_1.var_.actorSpriteComps10096 then
					for iter_330_6, iter_330_7 in pairs(arg_327_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_330_7 then
							if arg_327_1.isInRecall_ then
								iter_330_7.color = Color.New(Mathf.Lerp(iter_330_7.color.r, arg_327_1.hightColor2.r, (arg_327_1.time_ - 0) / var_330_9), Mathf.Lerp(iter_330_7.color.g, arg_327_1.hightColor2.g, (arg_327_1.time_ - 0) / var_330_9), (Mathf.Lerp(iter_330_7.color.b, arg_327_1.hightColor2.b, (arg_327_1.time_ - 0) / var_330_9)))
							else
								local var_330_10 = Mathf.Lerp(iter_330_7.color.r, 0.5, (arg_327_1.time_ - 0) / var_330_9)

								iter_330_7.color = Color.New(var_330_10, var_330_10, var_330_10)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_9 and arg_327_1.time_ < 0 + var_330_9 + arg_330_0 and not isNil(var_330_8) and arg_327_1.var_.actorSpriteComps10096 then
				for iter_330_8, iter_330_9 in pairs(arg_327_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_330_9 then
						iter_330_9.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_327_1.var_.actorSpriteComps10096 = nil
			end

			local var_330_11 = 0
			local var_330_12 = 0.15

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_11 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_13 = arg_327_1:GetWordFromCfg(413031078)
				local var_330_14 = arg_327_1:FormatText(var_330_13.content)

				arg_327_1.text_.text = var_330_14

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_16 = 6 <= 0 and var_330_12 or var_330_12 * (utf8.len(var_330_14) / 6)

				if (6 <= 0 and var_330_12 or var_330_12 * (utf8.len(var_330_14) / 6)) > 0 and var_330_12 < var_330_16 then
					arg_327_1.talkMaxDuration = var_330_16

					if var_330_16 + var_330_11 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_16 + var_330_11
					end
				end

				arg_327_1.text_.text = var_330_14
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031078", "story_v_out_413031.awb") ~= 0 then
					local var_330_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031078", "story_v_out_413031.awb") / 1000

					if var_330_17 + var_330_11 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_17 + var_330_11
					end

					if var_330_13.prefab_name ~= "" and arg_327_1.actors_[var_330_13.prefab_name] ~= nil then
						local var_330_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_13.prefab_name].transform, "story_v_out_413031", "413031078", "story_v_out_413031.awb")

						arg_327_1:RecordAudio("413031078", var_330_18)
						arg_327_1:RecordAudio("413031078", var_330_18)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_413031", "413031078", "story_v_out_413031.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_413031", "413031078", "story_v_out_413031.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_19 = math.max(var_330_12, arg_327_1.talkMaxDuration)

			if var_330_11 <= arg_327_1.time_ and arg_327_1.time_ < var_330_11 + var_330_19 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_11) / var_330_19

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_11 + var_330_19 and arg_327_1.time_ < var_330_11 + var_330_19 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
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
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play413031079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 413031079
		arg_331_1.duration_ = 9.2

		local var_331_0 = {
			zh = 9.2,
			ja = 8.9
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
				arg_331_0:Play413031080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos10093 = arg_331_1.actors_["10093"].transform.localPosition
				arg_331_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10093", 4)

				for iter_334_0 = 0, arg_331_1.actors_["10093"].transform.childCount - 1 do
					local var_334_0 = arg_331_1.actors_["10093"].transform:GetChild(iter_334_0)

					if var_334_0.name == "" or not string.find(var_334_0.name, "split") then
						var_334_0.gameObject:SetActive(true)
					else
						var_334_0.gameObject:SetActive(false)
					end
				end
			end

			local var_334_1 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_1 then
				arg_331_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_331_1.time_ - 0) / var_334_1)
			end

			if arg_331_1.time_ >= 0 + var_334_1 and arg_331_1.time_ < 0 + var_334_1 + arg_334_0 then
				arg_331_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_334_2 = arg_331_1.actors_["10096"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.actorSpriteComps10096 == nil then
				arg_331_1.var_.actorSpriteComps10096 = var_334_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_3 = 2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_3 and not isNil(var_334_2) then
				if arg_331_1.var_.actorSpriteComps10096 then
					for iter_334_1, iter_334_2 in pairs(arg_331_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_331_1.time_ >= 0 + var_334_3 and arg_331_1.time_ < 0 + var_334_3 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.actorSpriteComps10096 then
				for iter_334_3, iter_334_4 in pairs(arg_331_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_334_4 then
						iter_334_4.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_331_1.var_.actorSpriteComps10096 = nil
			end

			local var_334_5 = arg_331_1.actors_["10093"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.actorSpriteComps10093 == nil then
				arg_331_1.var_.actorSpriteComps10093 = var_334_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_6 = 2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_6 and not isNil(var_334_5) then
				if arg_331_1.var_.actorSpriteComps10093 then
					for iter_334_5, iter_334_6 in pairs(arg_331_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_331_1.time_ >= 0 + var_334_6 and arg_331_1.time_ < 0 + var_334_6 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.actorSpriteComps10093 then
				for iter_334_7, iter_334_8 in pairs(arg_331_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_334_8 then
						iter_334_8.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_331_1.var_.actorSpriteComps10093 = nil
			end

			local var_334_8 = 0
			local var_334_9 = 0.675

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_10 = arg_331_1:GetWordFromCfg(413031079)
				local var_334_11 = arg_331_1:FormatText(var_334_10.content)

				arg_331_1.text_.text = var_334_11

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_13 = 27 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 27)

				if (27 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 27)) > 0 and var_334_9 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_8
					end
				end

				arg_331_1.text_.text = var_334_11
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031079", "story_v_out_413031.awb") ~= 0 then
					local var_334_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031079", "story_v_out_413031.awb") / 1000

					if var_334_14 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_8
					end

					if var_334_10.prefab_name ~= "" and arg_331_1.actors_[var_334_10.prefab_name] ~= nil then
						local var_334_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_10.prefab_name].transform, "story_v_out_413031", "413031079", "story_v_out_413031.awb")

						arg_331_1:RecordAudio("413031079", var_334_15)
						arg_331_1:RecordAudio("413031079", var_334_15)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_413031", "413031079", "story_v_out_413031.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_413031", "413031079", "story_v_out_413031.awb")
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
				actorName = "10093",
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
	Play413031080 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 413031080
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play413031081(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos10096 = arg_335_1.actors_["10096"].transform.localPosition
				arg_335_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10096", 2)

				for iter_338_0 = 0, arg_335_1.actors_["10096"].transform.childCount - 1 do
					local var_338_0 = arg_335_1.actors_["10096"].transform:GetChild(iter_338_0)

					if var_338_0.name == "" or not string.find(var_338_0.name, "split") then
						var_338_0.gameObject:SetActive(true)
					else
						var_338_0.gameObject:SetActive(false)
					end
				end
			end

			local var_338_1 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_1 then
				arg_335_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10096, Vector3.New(-390, -350, -210), (arg_335_1.time_ - 0) / var_338_1)
			end

			if arg_335_1.time_ >= 0 + var_338_1 and arg_335_1.time_ < 0 + var_338_1 + arg_338_0 then
				arg_335_1.actors_["10096"].transform.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_338_2 = arg_335_1.actors_["10096"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10096 == nil then
				arg_335_1.var_.actorSpriteComps10096 = var_338_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_3 = 2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_3 and not isNil(var_338_2) then
				if arg_335_1.var_.actorSpriteComps10096 then
					for iter_338_1, iter_338_2 in pairs(arg_335_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_338_2 then
							if arg_335_1.isInRecall_ then
								iter_338_2.color = Color.New(Mathf.Lerp(iter_338_2.color.r, arg_335_1.hightColor2.r, (arg_335_1.time_ - 0) / var_338_3), Mathf.Lerp(iter_338_2.color.g, arg_335_1.hightColor2.g, (arg_335_1.time_ - 0) / var_338_3), (Mathf.Lerp(iter_338_2.color.b, arg_335_1.hightColor2.b, (arg_335_1.time_ - 0) / var_338_3)))
							else
								local var_338_4 = Mathf.Lerp(iter_338_2.color.r, 0.5, (arg_335_1.time_ - 0) / var_338_3)

								iter_338_2.color = Color.New(var_338_4, var_338_4, var_338_4)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_3 and arg_335_1.time_ < 0 + var_338_3 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10096 then
				for iter_338_3, iter_338_4 in pairs(arg_335_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_338_4 then
						iter_338_4.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_335_1.var_.actorSpriteComps10096 = nil
			end

			local var_338_5 = 0
			local var_338_6 = 1.2

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_5 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_7 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(413031080).content)

				arg_335_1.text_.text = var_338_7

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_9 = 48 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_7) / 48)

				if (48 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_7) / 48)) > 0 and var_338_6 < var_338_9 then
					arg_335_1.talkMaxDuration = var_338_9

					if var_338_9 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_9 + var_338_5
					end
				end

				arg_335_1.text_.text = var_338_7
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_6, arg_335_1.talkMaxDuration)

			if var_338_5 <= arg_335_1.time_ and arg_335_1.time_ < var_338_5 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_5) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_5 + var_338_10 and arg_335_1.time_ < var_338_5 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413031081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 413031081
		arg_339_1.duration_ = 15.53

		local var_339_0 = {
			zh = 8.166,
			ja = 15.533
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
				arg_339_0:Play413031082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos10096 = arg_339_1.actors_["10096"].transform.localPosition
				arg_339_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10096", 2)

				for iter_342_0 = 0, arg_339_1.actors_["10096"].transform.childCount - 1 do
					local var_342_0 = arg_339_1.actors_["10096"].transform:GetChild(iter_342_0)

					if var_342_0.name == "" or not string.find(var_342_0.name, "split") then
						var_342_0.gameObject:SetActive(true)
					else
						var_342_0.gameObject:SetActive(false)
					end
				end
			end

			local var_342_1 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_1 then
				arg_339_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10096, Vector3.New(-390, -350, -210), (arg_339_1.time_ - 0) / var_342_1)
			end

			if arg_339_1.time_ >= 0 + var_342_1 and arg_339_1.time_ < 0 + var_342_1 + arg_342_0 then
				arg_339_1.actors_["10096"].transform.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_342_2 = arg_339_1.actors_["10096"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.actorSpriteComps10096 == nil then
				arg_339_1.var_.actorSpriteComps10096 = var_342_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_3 = 2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_3 and not isNil(var_342_2) then
				if arg_339_1.var_.actorSpriteComps10096 then
					for iter_342_1, iter_342_2 in pairs(arg_339_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_342_2 then
							if arg_339_1.isInRecall_ then
								iter_342_2.color = Color.New(Mathf.Lerp(iter_342_2.color.r, arg_339_1.hightColor1.r, (arg_339_1.time_ - 0) / var_342_3), Mathf.Lerp(iter_342_2.color.g, arg_339_1.hightColor1.g, (arg_339_1.time_ - 0) / var_342_3), (Mathf.Lerp(iter_342_2.color.b, arg_339_1.hightColor1.b, (arg_339_1.time_ - 0) / var_342_3)))
							else
								local var_342_4 = Mathf.Lerp(iter_342_2.color.r, 1, (arg_339_1.time_ - 0) / var_342_3)

								iter_342_2.color = Color.New(var_342_4, var_342_4, var_342_4)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_3 and arg_339_1.time_ < 0 + var_342_3 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.actorSpriteComps10096 then
				for iter_342_3, iter_342_4 in pairs(arg_339_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_342_4 then
						iter_342_4.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_339_1.var_.actorSpriteComps10096 = nil
			end

			local var_342_5 = 0
			local var_342_6 = 0.625

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_7 = arg_339_1:GetWordFromCfg(413031081)
				local var_342_8 = arg_339_1:FormatText(var_342_7.content)

				arg_339_1.text_.text = var_342_8

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_10 = 25 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 25)

				if (25 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 25)) > 0 and var_342_6 < var_342_10 then
					arg_339_1.talkMaxDuration = var_342_10

					if var_342_10 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_5
					end
				end

				arg_339_1.text_.text = var_342_8
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031081", "story_v_out_413031.awb") ~= 0 then
					local var_342_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031081", "story_v_out_413031.awb") / 1000

					if var_342_11 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_11 + var_342_5
					end

					if var_342_7.prefab_name ~= "" and arg_339_1.actors_[var_342_7.prefab_name] ~= nil then
						local var_342_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_7.prefab_name].transform, "story_v_out_413031", "413031081", "story_v_out_413031.awb")

						arg_339_1:RecordAudio("413031081", var_342_12)
						arg_339_1:RecordAudio("413031081", var_342_12)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_413031", "413031081", "story_v_out_413031.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_413031", "413031081", "story_v_out_413031.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_13 = math.max(var_342_6, arg_339_1.talkMaxDuration)

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_13 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_5) / var_342_13

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_5 + var_342_13 and arg_339_1.time_ < var_342_5 + var_342_13 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play413031082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 413031082
		arg_343_1.duration_ = 3.17

		local var_343_0 = {
			zh = 3.166,
			ja = 2.133
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
				arg_343_0:Play413031083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10093 = arg_343_1.actors_["10093"].transform.localPosition
				arg_343_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10093", 4)

				for iter_346_0 = 0, arg_343_1.actors_["10093"].transform.childCount - 1 do
					local var_346_0 = arg_343_1.actors_["10093"].transform:GetChild(iter_346_0)

					if var_346_0.name == "split_5" or not string.find(var_346_0.name, "split") then
						var_346_0.gameObject:SetActive(true)
					else
						var_346_0.gameObject:SetActive(false)
					end
				end
			end

			local var_346_1 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_1 then
				arg_343_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_343_1.time_ - 0) / var_346_1)
			end

			if arg_343_1.time_ >= 0 + var_346_1 and arg_343_1.time_ < 0 + var_346_1 + arg_346_0 then
				arg_343_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_346_2 = arg_343_1.actors_["10096"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10096 = var_346_2.localPosition
				var_346_2.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10096", 2)

				for iter_346_1 = 0, var_346_2.childCount - 1 do
					local var_346_3 = var_346_2:GetChild(iter_346_1)

					if var_346_3.name == "" or not string.find(var_346_3.name, "split") then
						var_346_3.gameObject:SetActive(true)
					else
						var_346_3.gameObject:SetActive(false)
					end
				end
			end

			local var_346_4 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				var_346_2.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10096, Vector3.New(-390, -350, -210), (arg_343_1.time_ - 0) / var_346_4)
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				var_346_2.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_346_5 = arg_343_1.actors_["10093"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_5) and arg_343_1.var_.actorSpriteComps10093 == nil then
				arg_343_1.var_.actorSpriteComps10093 = var_346_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_6 = 2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_6 and not isNil(var_346_5) then
				if arg_343_1.var_.actorSpriteComps10093 then
					for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_346_3 then
							if arg_343_1.isInRecall_ then
								iter_346_3.color = Color.New(Mathf.Lerp(iter_346_3.color.r, arg_343_1.hightColor1.r, (arg_343_1.time_ - 0) / var_346_6), Mathf.Lerp(iter_346_3.color.g, arg_343_1.hightColor1.g, (arg_343_1.time_ - 0) / var_346_6), (Mathf.Lerp(iter_346_3.color.b, arg_343_1.hightColor1.b, (arg_343_1.time_ - 0) / var_346_6)))
							else
								local var_346_7 = Mathf.Lerp(iter_346_3.color.r, 1, (arg_343_1.time_ - 0) / var_346_6)

								iter_346_3.color = Color.New(var_346_7, var_346_7, var_346_7)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_6 and arg_343_1.time_ < 0 + var_346_6 + arg_346_0 and not isNil(var_346_5) and arg_343_1.var_.actorSpriteComps10093 then
				for iter_346_4, iter_346_5 in pairs(arg_343_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_346_5 then
						iter_346_5.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps10093 = nil
			end

			local var_346_8 = arg_343_1.actors_["10096"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps10096 == nil then
				arg_343_1.var_.actorSpriteComps10096 = var_346_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_9 = 2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_9 and not isNil(var_346_8) then
				if arg_343_1.var_.actorSpriteComps10096 then
					for iter_346_6, iter_346_7 in pairs(arg_343_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_346_7 then
							if arg_343_1.isInRecall_ then
								iter_346_7.color = Color.New(Mathf.Lerp(iter_346_7.color.r, arg_343_1.hightColor2.r, (arg_343_1.time_ - 0) / var_346_9), Mathf.Lerp(iter_346_7.color.g, arg_343_1.hightColor2.g, (arg_343_1.time_ - 0) / var_346_9), (Mathf.Lerp(iter_346_7.color.b, arg_343_1.hightColor2.b, (arg_343_1.time_ - 0) / var_346_9)))
							else
								local var_346_10 = Mathf.Lerp(iter_346_7.color.r, 0.5, (arg_343_1.time_ - 0) / var_346_9)

								iter_346_7.color = Color.New(var_346_10, var_346_10, var_346_10)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_9 and arg_343_1.time_ < 0 + var_346_9 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps10096 then
				for iter_346_8, iter_346_9 in pairs(arg_343_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_346_9 then
						iter_346_9.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_343_1.var_.actorSpriteComps10096 = nil
			end

			local var_346_11 = 0
			local var_346_12 = 0.2

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_11 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_13 = arg_343_1:GetWordFromCfg(413031082)
				local var_346_14 = arg_343_1:FormatText(var_346_13.content)

				arg_343_1.text_.text = var_346_14

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_16 = 8 <= 0 and var_346_12 or var_346_12 * (utf8.len(var_346_14) / 8)

				if (8 <= 0 and var_346_12 or var_346_12 * (utf8.len(var_346_14) / 8)) > 0 and var_346_12 < var_346_16 then
					arg_343_1.talkMaxDuration = var_346_16

					if var_346_16 + var_346_11 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_16 + var_346_11
					end
				end

				arg_343_1.text_.text = var_346_14
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031082", "story_v_out_413031.awb") ~= 0 then
					local var_346_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031082", "story_v_out_413031.awb") / 1000

					if var_346_17 + var_346_11 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_17 + var_346_11
					end

					if var_346_13.prefab_name ~= "" and arg_343_1.actors_[var_346_13.prefab_name] ~= nil then
						local var_346_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_13.prefab_name].transform, "story_v_out_413031", "413031082", "story_v_out_413031.awb")

						arg_343_1:RecordAudio("413031082", var_346_18)
						arg_343_1:RecordAudio("413031082", var_346_18)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_413031", "413031082", "story_v_out_413031.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_413031", "413031082", "story_v_out_413031.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_19 = math.max(var_346_12, arg_343_1.talkMaxDuration)

			if var_346_11 <= arg_343_1.time_ and arg_343_1.time_ < var_346_11 + var_346_19 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_11) / var_346_19

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_11 + var_346_19 and arg_343_1.time_ < var_346_11 + var_346_19 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
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
				actorName = "10096",
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
	Play413031083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 413031083
		arg_347_1.duration_ = 12.9

		local var_347_0 = {
			zh = 8.5,
			ja = 12.9
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
				arg_347_0:Play413031084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos10096 = arg_347_1.actors_["10096"].transform.localPosition
				arg_347_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10096", 2)

				for iter_350_0 = 0, arg_347_1.actors_["10096"].transform.childCount - 1 do
					local var_350_0 = arg_347_1.actors_["10096"].transform:GetChild(iter_350_0)

					if var_350_0.name == "" or not string.find(var_350_0.name, "split") then
						var_350_0.gameObject:SetActive(true)
					else
						var_350_0.gameObject:SetActive(false)
					end
				end
			end

			local var_350_1 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_1 then
				arg_347_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10096, Vector3.New(-390, -350, -210), (arg_347_1.time_ - 0) / var_350_1)
			end

			if arg_347_1.time_ >= 0 + var_350_1 and arg_347_1.time_ < 0 + var_350_1 + arg_350_0 then
				arg_347_1.actors_["10096"].transform.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_350_2 = arg_347_1.actors_["10096"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10096 == nil then
				arg_347_1.var_.actorSpriteComps10096 = var_350_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_3 = 2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.actorSpriteComps10096 then
					for iter_350_1, iter_350_2 in pairs(arg_347_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_350_2 then
							if arg_347_1.isInRecall_ then
								iter_350_2.color = Color.New(Mathf.Lerp(iter_350_2.color.r, arg_347_1.hightColor1.r, (arg_347_1.time_ - 0) / var_350_3), Mathf.Lerp(iter_350_2.color.g, arg_347_1.hightColor1.g, (arg_347_1.time_ - 0) / var_350_3), (Mathf.Lerp(iter_350_2.color.b, arg_347_1.hightColor1.b, (arg_347_1.time_ - 0) / var_350_3)))
							else
								local var_350_4 = Mathf.Lerp(iter_350_2.color.r, 1, (arg_347_1.time_ - 0) / var_350_3)

								iter_350_2.color = Color.New(var_350_4, var_350_4, var_350_4)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10096 then
				for iter_350_3, iter_350_4 in pairs(arg_347_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_350_4 then
						iter_350_4.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_347_1.var_.actorSpriteComps10096 = nil
			end

			local var_350_5 = arg_347_1.actors_["10093"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_5) and arg_347_1.var_.actorSpriteComps10093 == nil then
				arg_347_1.var_.actorSpriteComps10093 = var_350_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_6 = 2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_6 and not isNil(var_350_5) then
				if arg_347_1.var_.actorSpriteComps10093 then
					for iter_350_5, iter_350_6 in pairs(arg_347_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_350_6 then
							if arg_347_1.isInRecall_ then
								iter_350_6.color = Color.New(Mathf.Lerp(iter_350_6.color.r, arg_347_1.hightColor2.r, (arg_347_1.time_ - 0) / var_350_6), Mathf.Lerp(iter_350_6.color.g, arg_347_1.hightColor2.g, (arg_347_1.time_ - 0) / var_350_6), (Mathf.Lerp(iter_350_6.color.b, arg_347_1.hightColor2.b, (arg_347_1.time_ - 0) / var_350_6)))
							else
								local var_350_7 = Mathf.Lerp(iter_350_6.color.r, 0.5, (arg_347_1.time_ - 0) / var_350_6)

								iter_350_6.color = Color.New(var_350_7, var_350_7, var_350_7)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_6 and arg_347_1.time_ < 0 + var_350_6 + arg_350_0 and not isNil(var_350_5) and arg_347_1.var_.actorSpriteComps10093 then
				for iter_350_7, iter_350_8 in pairs(arg_347_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_350_8 then
						iter_350_8.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_347_1.var_.actorSpriteComps10093 = nil
			end

			local var_350_8 = 0
			local var_350_9 = 0.725

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_8 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_10 = arg_347_1:GetWordFromCfg(413031083)
				local var_350_11 = arg_347_1:FormatText(var_350_10.content)

				arg_347_1.text_.text = var_350_11

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_13 = 29 <= 0 and var_350_9 or var_350_9 * (utf8.len(var_350_11) / 29)

				if (29 <= 0 and var_350_9 or var_350_9 * (utf8.len(var_350_11) / 29)) > 0 and var_350_9 < var_350_13 then
					arg_347_1.talkMaxDuration = var_350_13

					if var_350_13 + var_350_8 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_13 + var_350_8
					end
				end

				arg_347_1.text_.text = var_350_11
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031083", "story_v_out_413031.awb") ~= 0 then
					local var_350_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031083", "story_v_out_413031.awb") / 1000

					if var_350_14 + var_350_8 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_14 + var_350_8
					end

					if var_350_10.prefab_name ~= "" and arg_347_1.actors_[var_350_10.prefab_name] ~= nil then
						local var_350_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_10.prefab_name].transform, "story_v_out_413031", "413031083", "story_v_out_413031.awb")

						arg_347_1:RecordAudio("413031083", var_350_15)
						arg_347_1:RecordAudio("413031083", var_350_15)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_413031", "413031083", "story_v_out_413031.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_413031", "413031083", "story_v_out_413031.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_16 = math.max(var_350_9, arg_347_1.talkMaxDuration)

			if var_350_8 <= arg_347_1.time_ and arg_347_1.time_ < var_350_8 + var_350_16 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_8) / var_350_16

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_8 + var_350_16 and arg_347_1.time_ < var_350_8 + var_350_16 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play413031084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 413031084
		arg_351_1.duration_ = 12.27

		local var_351_0 = {
			zh = 5.833,
			ja = 12.266
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
				arg_351_0:Play413031085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.allBtn_.enabled = false
			end

			if arg_351_1.time_ >= 0 + 1 and arg_351_1.time_ < 0 + 1 + arg_354_0 then
				arg_351_1.allBtn_.enabled = true
			end

			local var_354_0 = 0
			local var_354_1 = 0.425

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_2 = arg_351_1:GetWordFromCfg(413031084)
				local var_354_3 = arg_351_1:FormatText(var_354_2.content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 17 <= 0 and var_354_1 or var_354_1 * (utf8.len(var_354_3) / 17)

				if (17 <= 0 and var_354_1 or var_354_1 * (utf8.len(var_354_3) / 17)) > 0 and var_354_1 < var_354_5 then
					arg_351_1.talkMaxDuration = var_354_5

					if var_354_5 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031084", "story_v_out_413031.awb") ~= 0 then
					local var_354_6 = manager.audio:GetVoiceLength("story_v_out_413031", "413031084", "story_v_out_413031.awb") / 1000

					if var_354_6 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_0
					end

					if var_354_2.prefab_name ~= "" and arg_351_1.actors_[var_354_2.prefab_name] ~= nil then
						local var_354_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_2.prefab_name].transform, "story_v_out_413031", "413031084", "story_v_out_413031.awb")

						arg_351_1:RecordAudio("413031084", var_354_7)
						arg_351_1:RecordAudio("413031084", var_354_7)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_413031", "413031084", "story_v_out_413031.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_413031", "413031084", "story_v_out_413031.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_8 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_8 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_8

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_8 and arg_351_1.time_ < var_354_0 + var_354_8 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play413031085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 413031085
		arg_355_1.duration_ = 6

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play413031086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos10096 = arg_355_1.actors_["10096"].transform.localPosition
				arg_355_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10096", 0)

				for iter_358_0 = 0, arg_355_1.actors_["10096"].transform.childCount - 1 do
					local var_358_0 = arg_355_1.actors_["10096"].transform:GetChild(iter_358_0)

					if var_358_0.name == "" or not string.find(var_358_0.name, "split") then
						var_358_0.gameObject:SetActive(true)
					else
						var_358_0.gameObject:SetActive(false)
					end
				end
			end

			local var_358_1 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_1 then
				arg_355_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10096, Vector3.New(-5000, -350, -210), (arg_355_1.time_ - 0) / var_358_1)
			end

			if arg_355_1.time_ >= 0 + var_358_1 and arg_355_1.time_ < 0 + var_358_1 + arg_358_0 then
				arg_355_1.actors_["10096"].transform.localPosition = Vector3.New(-5000, -350, -210)
			end

			local var_358_2 = arg_355_1.actors_["10093"].transform

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos10093 = var_358_2.localPosition
				var_358_2.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10093", 0)

				for iter_358_1 = 0, var_358_2.childCount - 1 do
					local var_358_3 = var_358_2:GetChild(iter_358_1)

					if var_358_3.name == "" or not string.find(var_358_3.name, "split") then
						var_358_3.gameObject:SetActive(true)
					else
						var_358_3.gameObject:SetActive(false)
					end
				end
			end

			local var_358_4 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				var_358_2.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10093, Vector3.New(-5000, -345, -245), (arg_355_1.time_ - 0) / var_358_4)
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				var_358_2.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_358_5 = arg_355_1.actors_["10096"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_5) and arg_355_1.var_.actorSpriteComps10096 == nil then
				arg_355_1.var_.actorSpriteComps10096 = var_358_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_6 = 2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_6 and not isNil(var_358_5) then
				if arg_355_1.var_.actorSpriteComps10096 then
					for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_358_3 then
							if arg_355_1.isInRecall_ then
								iter_358_3.color = Color.New(Mathf.Lerp(iter_358_3.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 0) / var_358_6), Mathf.Lerp(iter_358_3.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 0) / var_358_6), (Mathf.Lerp(iter_358_3.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 0) / var_358_6)))
							else
								local var_358_7 = Mathf.Lerp(iter_358_3.color.r, 0.5, (arg_355_1.time_ - 0) / var_358_6)

								iter_358_3.color = Color.New(var_358_7, var_358_7, var_358_7)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_6 and arg_355_1.time_ < 0 + var_358_6 + arg_358_0 and not isNil(var_358_5) and arg_355_1.var_.actorSpriteComps10096 then
				for iter_358_4, iter_358_5 in pairs(arg_355_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_358_5 then
						iter_358_5.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps10096 = nil
			end

			local var_358_8 = arg_355_1.actors_["10093"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_8) and arg_355_1.var_.actorSpriteComps10093 == nil then
				arg_355_1.var_.actorSpriteComps10093 = var_358_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_9 = 2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_9 and not isNil(var_358_8) then
				if arg_355_1.var_.actorSpriteComps10093 then
					for iter_358_6, iter_358_7 in pairs(arg_355_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_358_7 then
							if arg_355_1.isInRecall_ then
								iter_358_7.color = Color.New(Mathf.Lerp(iter_358_7.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 0) / var_358_9), Mathf.Lerp(iter_358_7.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 0) / var_358_9), (Mathf.Lerp(iter_358_7.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 0) / var_358_9)))
							else
								local var_358_10 = Mathf.Lerp(iter_358_7.color.r, 0.5, (arg_355_1.time_ - 0) / var_358_9)

								iter_358_7.color = Color.New(var_358_10, var_358_10, var_358_10)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_9 and arg_355_1.time_ < 0 + var_358_9 + arg_358_0 and not isNil(var_358_8) and arg_355_1.var_.actorSpriteComps10093 then
				for iter_358_8, iter_358_9 in pairs(arg_355_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_358_9 then
						iter_358_9.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps10093 = nil
			end

			local var_358_11 = manager.ui.mainCamera.transform

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.shakeOldPos = var_358_11.localPosition
			end

			local var_358_12 = 0.6

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_12 then
				local var_358_13, var_358_14 = math.modf((arg_355_1.time_ - 0) / 0.066)

				var_358_11.localPosition = Vector3.New(var_358_14 * 0.13, var_358_14 * 0.13, var_358_14 * 0.13) + arg_355_1.var_.shakeOldPos
			end

			if arg_355_1.time_ >= 0 + var_358_12 and arg_355_1.time_ < 0 + var_358_12 + arg_358_0 then
				var_358_11.localPosition = arg_355_1.var_.shakeOldPos
			end

			local var_358_15 = 0

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 then
				arg_355_1.allBtn_.enabled = false
			end

			if arg_355_1.time_ >= var_358_15 + 0.6 and arg_355_1.time_ < var_358_15 + 0.6 + arg_358_0 then
				arg_355_1.allBtn_.enabled = true
			end

			if arg_355_1.frameCnt_ <= 1 then
				arg_355_1.dialog_:SetActive(false)
			end

			local var_358_16 = 1
			local var_358_17 = 1.575

			if 1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_16 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0

				arg_355_1.dialog_:SetActive(true)

				arg_355_1.dialogCg_.alpha = 0

				local var_358_18 = LeanTween.value(arg_355_1.dialog_, 0, 1, 0.3)

				var_358_18:setOnUpdate(LuaHelper.FloatAction(function(arg_359_0)
					arg_355_1.dialogCg_.alpha = arg_359_0
				end))
				var_358_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_355_1.dialog_)
					var_358_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_355_1.duration_ = arg_355_1.duration_ + 0.3

				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_19 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(413031085).content)

				arg_355_1.text_.text = var_358_19

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_21 = 63 <= 0 and var_358_17 or var_358_17 * (utf8.len(var_358_19) / 63)

				if (63 <= 0 and var_358_17 or var_358_17 * (utf8.len(var_358_19) / 63)) > 0 and var_358_17 < var_358_21 then
					arg_355_1.talkMaxDuration = var_358_21
					var_358_16 = var_358_16 + 0.3

					if var_358_21 + var_358_16 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_21 + var_358_16
					end
				end

				arg_355_1.text_.text = var_358_19
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_22 = var_358_16 + 0.3
			local var_358_23 = math.max(var_358_17, arg_355_1.talkMaxDuration)

			if var_358_16 + 0.3 <= arg_355_1.time_ and arg_355_1.time_ < var_358_22 + var_358_23 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_22) / var_358_23

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_22 + var_358_23 and arg_355_1.time_ < var_358_22 + var_358_23 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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

		arg_355_1:InitPlayNodeList()
	end,
	Play413031086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 413031086
		arg_361_1.duration_ = 4.47

		local var_361_0 = {
			zh = 3.833,
			ja = 4.466
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play413031087(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10022 = arg_361_1.actors_["10022"].transform.localPosition
				arg_361_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10022", 3)

				for iter_364_0 = 0, arg_361_1.actors_["10022"].transform.childCount - 1 do
					local var_364_0 = arg_361_1.actors_["10022"].transform:GetChild(iter_364_0)

					if var_364_0.name == "split_8" or not string.find(var_364_0.name, "split") then
						var_364_0.gameObject:SetActive(true)
					else
						var_364_0.gameObject:SetActive(false)
					end
				end
			end

			local var_364_1 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_1 then
				arg_361_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_361_1.time_ - 0) / var_364_1)
			end

			if arg_361_1.time_ >= 0 + var_364_1 and arg_361_1.time_ < 0 + var_364_1 + arg_364_0 then
				arg_361_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_364_2 = arg_361_1.actors_["10022"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.actorSpriteComps10022 == nil then
				arg_361_1.var_.actorSpriteComps10022 = var_364_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_3 = 2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_3 and not isNil(var_364_2) then
				if arg_361_1.var_.actorSpriteComps10022 then
					for iter_364_1, iter_364_2 in pairs(arg_361_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_364_2 then
							if arg_361_1.isInRecall_ then
								iter_364_2.color = Color.New(Mathf.Lerp(iter_364_2.color.r, arg_361_1.hightColor1.r, (arg_361_1.time_ - 0) / var_364_3), Mathf.Lerp(iter_364_2.color.g, arg_361_1.hightColor1.g, (arg_361_1.time_ - 0) / var_364_3), (Mathf.Lerp(iter_364_2.color.b, arg_361_1.hightColor1.b, (arg_361_1.time_ - 0) / var_364_3)))
							else
								local var_364_4 = Mathf.Lerp(iter_364_2.color.r, 1, (arg_361_1.time_ - 0) / var_364_3)

								iter_364_2.color = Color.New(var_364_4, var_364_4, var_364_4)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_3 and arg_361_1.time_ < 0 + var_364_3 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.actorSpriteComps10022 then
				for iter_364_3, iter_364_4 in pairs(arg_361_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_364_4 then
						iter_364_4.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_361_1.var_.actorSpriteComps10022 = nil
			end

			local var_364_5 = 0
			local var_364_6 = 0.5

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_5 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_7 = arg_361_1:GetWordFromCfg(413031086)
				local var_364_8 = arg_361_1:FormatText(var_364_7.content)

				arg_361_1.text_.text = var_364_8

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_10 = 20 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_8) / 20)

				if (20 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_8) / 20)) > 0 and var_364_6 < var_364_10 then
					arg_361_1.talkMaxDuration = var_364_10

					if var_364_10 + var_364_5 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_5
					end
				end

				arg_361_1.text_.text = var_364_8
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031086", "story_v_out_413031.awb") ~= 0 then
					local var_364_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031086", "story_v_out_413031.awb") / 1000

					if var_364_11 + var_364_5 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_11 + var_364_5
					end

					if var_364_7.prefab_name ~= "" and arg_361_1.actors_[var_364_7.prefab_name] ~= nil then
						local var_364_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_7.prefab_name].transform, "story_v_out_413031", "413031086", "story_v_out_413031.awb")

						arg_361_1:RecordAudio("413031086", var_364_12)
						arg_361_1:RecordAudio("413031086", var_364_12)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_413031", "413031086", "story_v_out_413031.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_413031", "413031086", "story_v_out_413031.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_13 = math.max(var_364_6, arg_361_1.talkMaxDuration)

			if var_364_5 <= arg_361_1.time_ and arg_361_1.time_ < var_364_5 + var_364_13 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_5) / var_364_13

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_5 + var_364_13 and arg_361_1.time_ < var_364_5 + var_364_13 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play413031087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 413031087
		arg_365_1.duration_ = 2

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play413031088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos10093 = arg_365_1.actors_["10093"].transform.localPosition
				arg_365_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("10093", 3)

				for iter_368_0 = 0, arg_365_1.actors_["10093"].transform.childCount - 1 do
					local var_368_0 = arg_365_1.actors_["10093"].transform:GetChild(iter_368_0)

					if var_368_0.name == "split_4" or not string.find(var_368_0.name, "split") then
						var_368_0.gameObject:SetActive(true)
					else
						var_368_0.gameObject:SetActive(false)
					end
				end
			end

			local var_368_1 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_1 then
				arg_365_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_365_1.time_ - 0) / var_368_1)
			end

			if arg_365_1.time_ >= 0 + var_368_1 and arg_365_1.time_ < 0 + var_368_1 + arg_368_0 then
				arg_365_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_368_2 = arg_365_1.actors_["10022"].transform

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos10022 = var_368_2.localPosition
				var_368_2.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("10022", 7)

				for iter_368_1 = 0, var_368_2.childCount - 1 do
					local var_368_3 = var_368_2:GetChild(iter_368_1)

					if var_368_3.name == "" or not string.find(var_368_3.name, "split") then
						var_368_3.gameObject:SetActive(true)
					else
						var_368_3.gameObject:SetActive(false)
					end
				end
			end

			local var_368_4 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				var_368_2.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_365_1.time_ - 0) / var_368_4)
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				var_368_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_368_5 = arg_365_1.actors_["10093"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.actorSpriteComps10093 == nil then
				arg_365_1.var_.actorSpriteComps10093 = var_368_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_6 = 2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_6 and not isNil(var_368_5) then
				if arg_365_1.var_.actorSpriteComps10093 then
					for iter_368_2, iter_368_3 in pairs(arg_365_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_368_3 then
							if arg_365_1.isInRecall_ then
								iter_368_3.color = Color.New(Mathf.Lerp(iter_368_3.color.r, arg_365_1.hightColor1.r, (arg_365_1.time_ - 0) / var_368_6), Mathf.Lerp(iter_368_3.color.g, arg_365_1.hightColor1.g, (arg_365_1.time_ - 0) / var_368_6), (Mathf.Lerp(iter_368_3.color.b, arg_365_1.hightColor1.b, (arg_365_1.time_ - 0) / var_368_6)))
							else
								local var_368_7 = Mathf.Lerp(iter_368_3.color.r, 1, (arg_365_1.time_ - 0) / var_368_6)

								iter_368_3.color = Color.New(var_368_7, var_368_7, var_368_7)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_6 and arg_365_1.time_ < 0 + var_368_6 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.actorSpriteComps10093 then
				for iter_368_4, iter_368_5 in pairs(arg_365_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_368_5 then
						iter_368_5.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_365_1.var_.actorSpriteComps10093 = nil
			end

			local var_368_8 = arg_365_1.actors_["10022"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_8) and arg_365_1.var_.actorSpriteComps10022 == nil then
				arg_365_1.var_.actorSpriteComps10022 = var_368_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_9 = 2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_9 and not isNil(var_368_8) then
				if arg_365_1.var_.actorSpriteComps10022 then
					for iter_368_6, iter_368_7 in pairs(arg_365_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_368_7 then
							if arg_365_1.isInRecall_ then
								iter_368_7.color = Color.New(Mathf.Lerp(iter_368_7.color.r, arg_365_1.hightColor2.r, (arg_365_1.time_ - 0) / var_368_9), Mathf.Lerp(iter_368_7.color.g, arg_365_1.hightColor2.g, (arg_365_1.time_ - 0) / var_368_9), (Mathf.Lerp(iter_368_7.color.b, arg_365_1.hightColor2.b, (arg_365_1.time_ - 0) / var_368_9)))
							else
								local var_368_10 = Mathf.Lerp(iter_368_7.color.r, 0.5, (arg_365_1.time_ - 0) / var_368_9)

								iter_368_7.color = Color.New(var_368_10, var_368_10, var_368_10)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_9 and arg_365_1.time_ < 0 + var_368_9 + arg_368_0 and not isNil(var_368_8) and arg_365_1.var_.actorSpriteComps10022 then
				for iter_368_8, iter_368_9 in pairs(arg_365_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_368_9 then
						iter_368_9.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_365_1.var_.actorSpriteComps10022 = nil
			end

			local var_368_11 = 0
			local var_368_12 = 0.1

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_11 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_13 = arg_365_1:GetWordFromCfg(413031087)
				local var_368_14 = arg_365_1:FormatText(var_368_13.content)

				arg_365_1.text_.text = var_368_14

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_16 = 4 <= 0 and var_368_12 or var_368_12 * (utf8.len(var_368_14) / 4)

				if (4 <= 0 and var_368_12 or var_368_12 * (utf8.len(var_368_14) / 4)) > 0 and var_368_12 < var_368_16 then
					arg_365_1.talkMaxDuration = var_368_16

					if var_368_16 + var_368_11 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_16 + var_368_11
					end
				end

				arg_365_1.text_.text = var_368_14
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031087", "story_v_out_413031.awb") ~= 0 then
					local var_368_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031087", "story_v_out_413031.awb") / 1000

					if var_368_17 + var_368_11 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_17 + var_368_11
					end

					if var_368_13.prefab_name ~= "" and arg_365_1.actors_[var_368_13.prefab_name] ~= nil then
						local var_368_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_13.prefab_name].transform, "story_v_out_413031", "413031087", "story_v_out_413031.awb")

						arg_365_1:RecordAudio("413031087", var_368_18)
						arg_365_1:RecordAudio("413031087", var_368_18)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_413031", "413031087", "story_v_out_413031.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_413031", "413031087", "story_v_out_413031.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_19 = math.max(var_368_12, arg_365_1.talkMaxDuration)

			if var_368_11 <= arg_365_1.time_ and arg_365_1.time_ < var_368_11 + var_368_19 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_11) / var_368_19

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_11 + var_368_19 and arg_365_1.time_ < var_368_11 + var_368_19 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
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
				actorName = "10022",
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
	Play413031088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 413031088
		arg_369_1.duration_ = 5.53

		local var_369_0 = {
			zh = 4.966,
			ja = 5.533
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play413031089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos10022 = arg_369_1.actors_["10022"].transform.localPosition
				arg_369_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10022", 3)

				for iter_372_0 = 0, arg_369_1.actors_["10022"].transform.childCount - 1 do
					local var_372_0 = arg_369_1.actors_["10022"].transform:GetChild(iter_372_0)

					if var_372_0.name == "split_6" or not string.find(var_372_0.name, "split") then
						var_372_0.gameObject:SetActive(true)
					else
						var_372_0.gameObject:SetActive(false)
					end
				end
			end

			local var_372_1 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_1 then
				arg_369_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_369_1.time_ - 0) / var_372_1)
			end

			if arg_369_1.time_ >= 0 + var_372_1 and arg_369_1.time_ < 0 + var_372_1 + arg_372_0 then
				arg_369_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_372_2 = arg_369_1.actors_["10022"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps10022 == nil then
				arg_369_1.var_.actorSpriteComps10022 = var_372_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_3 = 2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 and not isNil(var_372_2) then
				if arg_369_1.var_.actorSpriteComps10022 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_372_2 then
							if arg_369_1.isInRecall_ then
								iter_372_2.color = Color.New(Mathf.Lerp(iter_372_2.color.r, arg_369_1.hightColor1.r, (arg_369_1.time_ - 0) / var_372_3), Mathf.Lerp(iter_372_2.color.g, arg_369_1.hightColor1.g, (arg_369_1.time_ - 0) / var_372_3), (Mathf.Lerp(iter_372_2.color.b, arg_369_1.hightColor1.b, (arg_369_1.time_ - 0) / var_372_3)))
							else
								local var_372_4 = Mathf.Lerp(iter_372_2.color.r, 1, (arg_369_1.time_ - 0) / var_372_3)

								iter_372_2.color = Color.New(var_372_4, var_372_4, var_372_4)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps10022 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_372_4 then
						iter_372_4.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps10022 = nil
			end

			local var_372_5 = arg_369_1.actors_["10093"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.actorSpriteComps10093 == nil then
				arg_369_1.var_.actorSpriteComps10093 = var_372_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_6 = 2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_6 and not isNil(var_372_5) then
				if arg_369_1.var_.actorSpriteComps10093 then
					for iter_372_5, iter_372_6 in pairs(arg_369_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_372_6 then
							if arg_369_1.isInRecall_ then
								iter_372_6.color = Color.New(Mathf.Lerp(iter_372_6.color.r, arg_369_1.hightColor2.r, (arg_369_1.time_ - 0) / var_372_6), Mathf.Lerp(iter_372_6.color.g, arg_369_1.hightColor2.g, (arg_369_1.time_ - 0) / var_372_6), (Mathf.Lerp(iter_372_6.color.b, arg_369_1.hightColor2.b, (arg_369_1.time_ - 0) / var_372_6)))
							else
								local var_372_7 = Mathf.Lerp(iter_372_6.color.r, 0.5, (arg_369_1.time_ - 0) / var_372_6)

								iter_372_6.color = Color.New(var_372_7, var_372_7, var_372_7)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_6 and arg_369_1.time_ < 0 + var_372_6 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.actorSpriteComps10093 then
				for iter_372_7, iter_372_8 in pairs(arg_369_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_372_8 then
						iter_372_8.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_369_1.var_.actorSpriteComps10093 = nil
			end

			local var_372_8 = 0
			local var_372_9 = 0.625

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_10 = arg_369_1:GetWordFromCfg(413031088)
				local var_372_11 = arg_369_1:FormatText(var_372_10.content)

				arg_369_1.text_.text = var_372_11

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_13 = 25 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_11) / 25)

				if (25 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_11) / 25)) > 0 and var_372_9 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_8
					end
				end

				arg_369_1.text_.text = var_372_11
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031088", "story_v_out_413031.awb") ~= 0 then
					local var_372_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031088", "story_v_out_413031.awb") / 1000

					if var_372_14 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_14 + var_372_8
					end

					if var_372_10.prefab_name ~= "" and arg_369_1.actors_[var_372_10.prefab_name] ~= nil then
						local var_372_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_10.prefab_name].transform, "story_v_out_413031", "413031088", "story_v_out_413031.awb")

						arg_369_1:RecordAudio("413031088", var_372_15)
						arg_369_1:RecordAudio("413031088", var_372_15)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_413031", "413031088", "story_v_out_413031.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_413031", "413031088", "story_v_out_413031.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_16 = math.max(var_372_9, arg_369_1.talkMaxDuration)

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_16 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_8) / var_372_16

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_8 + var_372_16 and arg_369_1.time_ < var_372_8 + var_372_16 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	Play413031089 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 413031089
		arg_373_1.duration_ = 8.73

		local var_373_0 = {
			zh = 8.733,
			ja = 8.466
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play413031090(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos10022 = arg_373_1.actors_["10022"].transform.localPosition
				arg_373_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("10022", 0)

				for iter_376_0 = 0, arg_373_1.actors_["10022"].transform.childCount - 1 do
					local var_376_0 = arg_373_1.actors_["10022"].transform:GetChild(iter_376_0)

					if var_376_0.name == "" or not string.find(var_376_0.name, "split") then
						var_376_0.gameObject:SetActive(true)
					else
						var_376_0.gameObject:SetActive(false)
					end
				end
			end

			local var_376_1 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_1 then
				arg_373_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_373_1.time_ - 0) / var_376_1)
			end

			if arg_373_1.time_ >= 0 + var_376_1 and arg_373_1.time_ < 0 + var_376_1 + arg_376_0 then
				arg_373_1.actors_["10022"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_376_2 = arg_373_1.actors_["10096"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos10096 = var_376_2.localPosition
				var_376_2.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("10096", 3)

				for iter_376_1 = 0, var_376_2.childCount - 1 do
					local var_376_3 = var_376_2:GetChild(iter_376_1)

					if var_376_3.name == "" or not string.find(var_376_3.name, "split") then
						var_376_3.gameObject:SetActive(true)
					else
						var_376_3.gameObject:SetActive(false)
					end
				end
			end

			local var_376_4 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 then
				var_376_2.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10096, Vector3.New(0, -350, -210), (arg_373_1.time_ - 0) / var_376_4)
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 then
				var_376_2.localPosition = Vector3.New(0, -350, -210)
			end

			local var_376_5 = arg_373_1.actors_["10022"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_5) and arg_373_1.var_.actorSpriteComps10022 == nil then
				arg_373_1.var_.actorSpriteComps10022 = var_376_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_6 = 2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_6 and not isNil(var_376_5) then
				if arg_373_1.var_.actorSpriteComps10022 then
					for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_376_3 then
							if arg_373_1.isInRecall_ then
								iter_376_3.color = Color.New(Mathf.Lerp(iter_376_3.color.r, arg_373_1.hightColor2.r, (arg_373_1.time_ - 0) / var_376_6), Mathf.Lerp(iter_376_3.color.g, arg_373_1.hightColor2.g, (arg_373_1.time_ - 0) / var_376_6), (Mathf.Lerp(iter_376_3.color.b, arg_373_1.hightColor2.b, (arg_373_1.time_ - 0) / var_376_6)))
							else
								local var_376_7 = Mathf.Lerp(iter_376_3.color.r, 0.5, (arg_373_1.time_ - 0) / var_376_6)

								iter_376_3.color = Color.New(var_376_7, var_376_7, var_376_7)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_6 and arg_373_1.time_ < 0 + var_376_6 + arg_376_0 and not isNil(var_376_5) and arg_373_1.var_.actorSpriteComps10022 then
				for iter_376_4, iter_376_5 in pairs(arg_373_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_376_5 then
						iter_376_5.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps10022 = nil
			end

			local var_376_8 = arg_373_1.actors_["10096"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_8) and arg_373_1.var_.actorSpriteComps10096 == nil then
				arg_373_1.var_.actorSpriteComps10096 = var_376_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_9 = 2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_9 and not isNil(var_376_8) then
				if arg_373_1.var_.actorSpriteComps10096 then
					for iter_376_6, iter_376_7 in pairs(arg_373_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_376_7 then
							if arg_373_1.isInRecall_ then
								iter_376_7.color = Color.New(Mathf.Lerp(iter_376_7.color.r, arg_373_1.hightColor1.r, (arg_373_1.time_ - 0) / var_376_9), Mathf.Lerp(iter_376_7.color.g, arg_373_1.hightColor1.g, (arg_373_1.time_ - 0) / var_376_9), (Mathf.Lerp(iter_376_7.color.b, arg_373_1.hightColor1.b, (arg_373_1.time_ - 0) / var_376_9)))
							else
								local var_376_10 = Mathf.Lerp(iter_376_7.color.r, 1, (arg_373_1.time_ - 0) / var_376_9)

								iter_376_7.color = Color.New(var_376_10, var_376_10, var_376_10)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_9 and arg_373_1.time_ < 0 + var_376_9 + arg_376_0 and not isNil(var_376_8) and arg_373_1.var_.actorSpriteComps10096 then
				for iter_376_8, iter_376_9 in pairs(arg_373_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_376_9 then
						iter_376_9.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_373_1.var_.actorSpriteComps10096 = nil
			end

			local var_376_11 = 0
			local var_376_12 = 0.575

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_11 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_13 = arg_373_1:GetWordFromCfg(413031089)
				local var_376_14 = arg_373_1:FormatText(var_376_13.content)

				arg_373_1.text_.text = var_376_14

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_16 = 23 <= 0 and var_376_12 or var_376_12 * (utf8.len(var_376_14) / 23)

				if (23 <= 0 and var_376_12 or var_376_12 * (utf8.len(var_376_14) / 23)) > 0 and var_376_12 < var_376_16 then
					arg_373_1.talkMaxDuration = var_376_16

					if var_376_16 + var_376_11 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_16 + var_376_11
					end
				end

				arg_373_1.text_.text = var_376_14
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031089", "story_v_out_413031.awb") ~= 0 then
					local var_376_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031089", "story_v_out_413031.awb") / 1000

					if var_376_17 + var_376_11 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_17 + var_376_11
					end

					if var_376_13.prefab_name ~= "" and arg_373_1.actors_[var_376_13.prefab_name] ~= nil then
						local var_376_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_13.prefab_name].transform, "story_v_out_413031", "413031089", "story_v_out_413031.awb")

						arg_373_1:RecordAudio("413031089", var_376_18)
						arg_373_1:RecordAudio("413031089", var_376_18)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_413031", "413031089", "story_v_out_413031.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_413031", "413031089", "story_v_out_413031.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_19 = math.max(var_376_12, arg_373_1.talkMaxDuration)

			if var_376_11 <= arg_373_1.time_ and arg_373_1.time_ < var_376_11 + var_376_19 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_11) / var_376_19

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_11 + var_376_19 and arg_373_1.time_ < var_376_11 + var_376_19 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play413031090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 413031090
		arg_377_1.duration_ = 7.9

		local var_377_0 = {
			zh = 4.8,
			ja = 7.9
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play413031091(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos10022 = arg_377_1.actors_["10022"].transform.localPosition
				arg_377_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10022", 3)

				for iter_380_0 = 0, arg_377_1.actors_["10022"].transform.childCount - 1 do
					local var_380_0 = arg_377_1.actors_["10022"].transform:GetChild(iter_380_0)

					if var_380_0.name == "split_6" or not string.find(var_380_0.name, "split") then
						var_380_0.gameObject:SetActive(true)
					else
						var_380_0.gameObject:SetActive(false)
					end
				end
			end

			local var_380_1 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_1 then
				arg_377_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_377_1.time_ - 0) / var_380_1)
			end

			if arg_377_1.time_ >= 0 + var_380_1 and arg_377_1.time_ < 0 + var_380_1 + arg_380_0 then
				arg_377_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_380_2 = arg_377_1.actors_["10096"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos10096 = var_380_2.localPosition
				var_380_2.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10096", 0)

				for iter_380_1 = 0, var_380_2.childCount - 1 do
					local var_380_3 = var_380_2:GetChild(iter_380_1)

					if var_380_3.name == "" or not string.find(var_380_3.name, "split") then
						var_380_3.gameObject:SetActive(true)
					else
						var_380_3.gameObject:SetActive(false)
					end
				end
			end

			local var_380_4 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				var_380_2.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10096, Vector3.New(-5000, -350, -210), (arg_377_1.time_ - 0) / var_380_4)
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				var_380_2.localPosition = Vector3.New(-5000, -350, -210)
			end

			local var_380_5 = arg_377_1.actors_["10022"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.actorSpriteComps10022 == nil then
				arg_377_1.var_.actorSpriteComps10022 = var_380_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_6 = 2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_6 and not isNil(var_380_5) then
				if arg_377_1.var_.actorSpriteComps10022 then
					for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_380_3 then
							if arg_377_1.isInRecall_ then
								iter_380_3.color = Color.New(Mathf.Lerp(iter_380_3.color.r, arg_377_1.hightColor1.r, (arg_377_1.time_ - 0) / var_380_6), Mathf.Lerp(iter_380_3.color.g, arg_377_1.hightColor1.g, (arg_377_1.time_ - 0) / var_380_6), (Mathf.Lerp(iter_380_3.color.b, arg_377_1.hightColor1.b, (arg_377_1.time_ - 0) / var_380_6)))
							else
								local var_380_7 = Mathf.Lerp(iter_380_3.color.r, 1, (arg_377_1.time_ - 0) / var_380_6)

								iter_380_3.color = Color.New(var_380_7, var_380_7, var_380_7)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_6 and arg_377_1.time_ < 0 + var_380_6 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.actorSpriteComps10022 then
				for iter_380_4, iter_380_5 in pairs(arg_377_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_380_5 then
						iter_380_5.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_377_1.var_.actorSpriteComps10022 = nil
			end

			local var_380_8 = arg_377_1.actors_["10096"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_8) and arg_377_1.var_.actorSpriteComps10096 == nil then
				arg_377_1.var_.actorSpriteComps10096 = var_380_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_9 = 2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_9 and not isNil(var_380_8) then
				if arg_377_1.var_.actorSpriteComps10096 then
					for iter_380_6, iter_380_7 in pairs(arg_377_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_380_7 then
							if arg_377_1.isInRecall_ then
								iter_380_7.color = Color.New(Mathf.Lerp(iter_380_7.color.r, arg_377_1.hightColor2.r, (arg_377_1.time_ - 0) / var_380_9), Mathf.Lerp(iter_380_7.color.g, arg_377_1.hightColor2.g, (arg_377_1.time_ - 0) / var_380_9), (Mathf.Lerp(iter_380_7.color.b, arg_377_1.hightColor2.b, (arg_377_1.time_ - 0) / var_380_9)))
							else
								local var_380_10 = Mathf.Lerp(iter_380_7.color.r, 0.5, (arg_377_1.time_ - 0) / var_380_9)

								iter_380_7.color = Color.New(var_380_10, var_380_10, var_380_10)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_9 and arg_377_1.time_ < 0 + var_380_9 + arg_380_0 and not isNil(var_380_8) and arg_377_1.var_.actorSpriteComps10096 then
				for iter_380_8, iter_380_9 in pairs(arg_377_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_380_9 then
						iter_380_9.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_377_1.var_.actorSpriteComps10096 = nil
			end

			local var_380_11 = 0
			local var_380_12 = 0.6

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_11 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_13 = arg_377_1:GetWordFromCfg(413031090)
				local var_380_14 = arg_377_1:FormatText(var_380_13.content)

				arg_377_1.text_.text = var_380_14

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_16 = 24 <= 0 and var_380_12 or var_380_12 * (utf8.len(var_380_14) / 24)

				if (24 <= 0 and var_380_12 or var_380_12 * (utf8.len(var_380_14) / 24)) > 0 and var_380_12 < var_380_16 then
					arg_377_1.talkMaxDuration = var_380_16

					if var_380_16 + var_380_11 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_16 + var_380_11
					end
				end

				arg_377_1.text_.text = var_380_14
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031090", "story_v_out_413031.awb") ~= 0 then
					local var_380_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031090", "story_v_out_413031.awb") / 1000

					if var_380_17 + var_380_11 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_17 + var_380_11
					end

					if var_380_13.prefab_name ~= "" and arg_377_1.actors_[var_380_13.prefab_name] ~= nil then
						local var_380_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_13.prefab_name].transform, "story_v_out_413031", "413031090", "story_v_out_413031.awb")

						arg_377_1:RecordAudio("413031090", var_380_18)
						arg_377_1:RecordAudio("413031090", var_380_18)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_413031", "413031090", "story_v_out_413031.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_413031", "413031090", "story_v_out_413031.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_19 = math.max(var_380_12, arg_377_1.talkMaxDuration)

			if var_380_11 <= arg_377_1.time_ and arg_377_1.time_ < var_380_11 + var_380_19 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_11) / var_380_19

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_11 + var_380_19 and arg_377_1.time_ < var_380_11 + var_380_19 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
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
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play413031091 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 413031091
		arg_381_1.duration_ = 14.33

		local var_381_0 = {
			zh = 7.966,
			ja = 14.333
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play413031092(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos10022 = arg_381_1.actors_["10022"].transform.localPosition
				arg_381_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("10022", 0)

				for iter_384_0 = 0, arg_381_1.actors_["10022"].transform.childCount - 1 do
					local var_384_0 = arg_381_1.actors_["10022"].transform:GetChild(iter_384_0)

					if var_384_0.name == "" or not string.find(var_384_0.name, "split") then
						var_384_0.gameObject:SetActive(true)
					else
						var_384_0.gameObject:SetActive(false)
					end
				end
			end

			local var_384_1 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_1 then
				arg_381_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_381_1.time_ - 0) / var_384_1)
			end

			if arg_381_1.time_ >= 0 + var_384_1 and arg_381_1.time_ < 0 + var_384_1 + arg_384_0 then
				arg_381_1.actors_["10022"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_384_2 = arg_381_1.actors_["10096"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos10096 = var_384_2.localPosition
				var_384_2.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("10096", 3)

				for iter_384_1 = 0, var_384_2.childCount - 1 do
					local var_384_3 = var_384_2:GetChild(iter_384_1)

					if var_384_3.name == "" or not string.find(var_384_3.name, "split") then
						var_384_3.gameObject:SetActive(true)
					else
						var_384_3.gameObject:SetActive(false)
					end
				end
			end

			local var_384_4 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				var_384_2.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10096, Vector3.New(0, -350, -210), (arg_381_1.time_ - 0) / var_384_4)
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				var_384_2.localPosition = Vector3.New(0, -350, -210)
			end

			local var_384_5 = arg_381_1.actors_["10022"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_5) and arg_381_1.var_.actorSpriteComps10022 == nil then
				arg_381_1.var_.actorSpriteComps10022 = var_384_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_6 = 2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_6 and not isNil(var_384_5) then
				if arg_381_1.var_.actorSpriteComps10022 then
					for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_384_3 then
							if arg_381_1.isInRecall_ then
								iter_384_3.color = Color.New(Mathf.Lerp(iter_384_3.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_6), Mathf.Lerp(iter_384_3.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_6), (Mathf.Lerp(iter_384_3.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_6)))
							else
								local var_384_7 = Mathf.Lerp(iter_384_3.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_6)

								iter_384_3.color = Color.New(var_384_7, var_384_7, var_384_7)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_6 and arg_381_1.time_ < 0 + var_384_6 + arg_384_0 and not isNil(var_384_5) and arg_381_1.var_.actorSpriteComps10022 then
				for iter_384_4, iter_384_5 in pairs(arg_381_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_384_5 then
						iter_384_5.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps10022 = nil
			end

			local var_384_8 = arg_381_1.actors_["10096"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_8) and arg_381_1.var_.actorSpriteComps10096 == nil then
				arg_381_1.var_.actorSpriteComps10096 = var_384_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_9 = 2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_9 and not isNil(var_384_8) then
				if arg_381_1.var_.actorSpriteComps10096 then
					for iter_384_6, iter_384_7 in pairs(arg_381_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_384_7 then
							if arg_381_1.isInRecall_ then
								iter_384_7.color = Color.New(Mathf.Lerp(iter_384_7.color.r, arg_381_1.hightColor1.r, (arg_381_1.time_ - 0) / var_384_9), Mathf.Lerp(iter_384_7.color.g, arg_381_1.hightColor1.g, (arg_381_1.time_ - 0) / var_384_9), (Mathf.Lerp(iter_384_7.color.b, arg_381_1.hightColor1.b, (arg_381_1.time_ - 0) / var_384_9)))
							else
								local var_384_10 = Mathf.Lerp(iter_384_7.color.r, 1, (arg_381_1.time_ - 0) / var_384_9)

								iter_384_7.color = Color.New(var_384_10, var_384_10, var_384_10)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_9 and arg_381_1.time_ < 0 + var_384_9 + arg_384_0 and not isNil(var_384_8) and arg_381_1.var_.actorSpriteComps10096 then
				for iter_384_8, iter_384_9 in pairs(arg_381_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_384_9 then
						iter_384_9.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_381_1.var_.actorSpriteComps10096 = nil
			end

			local var_384_11 = 0
			local var_384_12 = 0.5

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_11 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_13 = arg_381_1:GetWordFromCfg(413031091)
				local var_384_14 = arg_381_1:FormatText(var_384_13.content)

				arg_381_1.text_.text = var_384_14

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_16 = 20 <= 0 and var_384_12 or var_384_12 * (utf8.len(var_384_14) / 20)

				if (20 <= 0 and var_384_12 or var_384_12 * (utf8.len(var_384_14) / 20)) > 0 and var_384_12 < var_384_16 then
					arg_381_1.talkMaxDuration = var_384_16

					if var_384_16 + var_384_11 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_16 + var_384_11
					end
				end

				arg_381_1.text_.text = var_384_14
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031091", "story_v_out_413031.awb") ~= 0 then
					local var_384_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031091", "story_v_out_413031.awb") / 1000

					if var_384_17 + var_384_11 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_17 + var_384_11
					end

					if var_384_13.prefab_name ~= "" and arg_381_1.actors_[var_384_13.prefab_name] ~= nil then
						local var_384_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_13.prefab_name].transform, "story_v_out_413031", "413031091", "story_v_out_413031.awb")

						arg_381_1:RecordAudio("413031091", var_384_18)
						arg_381_1:RecordAudio("413031091", var_384_18)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_413031", "413031091", "story_v_out_413031.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_413031", "413031091", "story_v_out_413031.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_19 = math.max(var_384_12, arg_381_1.talkMaxDuration)

			if var_384_11 <= arg_381_1.time_ and arg_381_1.time_ < var_384_11 + var_384_19 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_11) / var_384_19

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_11 + var_384_19 and arg_381_1.time_ < var_384_11 + var_384_19 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
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
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play413031092 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 413031092
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play413031093(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos10096 = arg_385_1.actors_["10096"].transform.localPosition
				arg_385_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("10096", 0)

				for iter_388_0 = 0, arg_385_1.actors_["10096"].transform.childCount - 1 do
					local var_388_0 = arg_385_1.actors_["10096"].transform:GetChild(iter_388_0)

					if var_388_0.name == "" or not string.find(var_388_0.name, "split") then
						var_388_0.gameObject:SetActive(true)
					else
						var_388_0.gameObject:SetActive(false)
					end
				end
			end

			local var_388_1 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_1 then
				arg_385_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10096, Vector3.New(-5000, -350, -210), (arg_385_1.time_ - 0) / var_388_1)
			end

			if arg_385_1.time_ >= 0 + var_388_1 and arg_385_1.time_ < 0 + var_388_1 + arg_388_0 then
				arg_385_1.actors_["10096"].transform.localPosition = Vector3.New(-5000, -350, -210)
			end

			local var_388_2 = arg_385_1.actors_["10096"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps10096 == nil then
				arg_385_1.var_.actorSpriteComps10096 = var_388_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_3 = 2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_3 and not isNil(var_388_2) then
				if arg_385_1.var_.actorSpriteComps10096 then
					for iter_388_1, iter_388_2 in pairs(arg_385_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_388_2 then
							if arg_385_1.isInRecall_ then
								iter_388_2.color = Color.New(Mathf.Lerp(iter_388_2.color.r, arg_385_1.hightColor2.r, (arg_385_1.time_ - 0) / var_388_3), Mathf.Lerp(iter_388_2.color.g, arg_385_1.hightColor2.g, (arg_385_1.time_ - 0) / var_388_3), (Mathf.Lerp(iter_388_2.color.b, arg_385_1.hightColor2.b, (arg_385_1.time_ - 0) / var_388_3)))
							else
								local var_388_4 = Mathf.Lerp(iter_388_2.color.r, 0.5, (arg_385_1.time_ - 0) / var_388_3)

								iter_388_2.color = Color.New(var_388_4, var_388_4, var_388_4)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_3 and arg_385_1.time_ < 0 + var_388_3 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps10096 then
				for iter_388_3, iter_388_4 in pairs(arg_385_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_388_4 then
						iter_388_4.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_385_1.var_.actorSpriteComps10096 = nil
			end

			local var_388_5 = 0
			local var_388_6 = 1.075

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_7 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(413031092).content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 43 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_7) / 43)

				if (43 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_7) / 43)) > 0 and var_388_6 < var_388_9 then
					arg_385_1.talkMaxDuration = var_388_9

					if var_388_9 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_9 + var_388_5
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_10 = math.max(var_388_6, arg_385_1.talkMaxDuration)

			if var_388_5 <= arg_385_1.time_ and arg_385_1.time_ < var_388_5 + var_388_10 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_5) / var_388_10

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_5 + var_388_10 and arg_385_1.time_ < var_388_5 + var_388_10 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play413031093 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 413031093
		arg_389_1.duration_ = 15.88

		local var_389_0 = {
			zh = 13.1111379988407,
			ja = 15.8781379988407
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play413031094(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 2 < arg_389_1.time_ and arg_389_1.time_ <= 2 + arg_392_0 then
				local var_392_0 = arg_389_1.bgs_.F08l

				arg_389_1.bgs_.F08l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_392_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_392_1 = var_392_0:GetComponent("SpriteRenderer")

				if var_392_1 and var_392_1.sprite then
					local var_392_2 = 2 * (var_392_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_392_0.transform.localScale = Vector3.New(var_392_2 / var_392_1.sprite.bounds.size.y < var_392_2 * manager.ui.mainCameraCom_.aspect / var_392_1.sprite.bounds.size.x and var_392_2 * manager.ui.mainCameraCom_.aspect / var_392_1.sprite.bounds.size.x or var_392_2 / var_392_1.sprite.bounds.size.y, var_392_2 / var_392_1.sprite.bounds.size.y < var_392_2 * manager.ui.mainCameraCom_.aspect / var_392_1.sprite.bounds.size.x and var_392_2 * manager.ui.mainCameraCom_.aspect / var_392_1.sprite.bounds.size.x or var_392_2 / var_392_1.sprite.bounds.size.y, 0)
				end

				for iter_392_0, iter_392_1 in pairs(arg_389_1.bgs_) do
					if iter_392_0 ~= "F08l" then
						iter_392_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_392_3 = 3.8

			if 3.8 < arg_389_1.time_ and arg_389_1.time_ <= var_392_3 + arg_392_0 then
				arg_389_1.allBtn_.enabled = false
			end

			if arg_389_1.time_ >= var_392_3 + 0.3 and arg_389_1.time_ < var_392_3 + 0.3 + arg_392_0 then
				arg_389_1.allBtn_.enabled = true
			end

			local var_392_4 = 0

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_4 + arg_392_0 then
				arg_389_1.mask_.enabled = true
				arg_389_1.mask_.raycastTarget = true

				arg_389_1:SetGaussion(false)
			end

			local var_392_5 = 2

			if var_392_4 <= arg_389_1.time_ and arg_389_1.time_ < var_392_4 + var_392_5 then
				local var_392_6 = Color.New(0, 0, 0)

				var_392_6.a = Mathf.Lerp(0, 1, (arg_389_1.time_ - var_392_4) / var_392_5)
				arg_389_1.mask_.color = var_392_6
			end

			if arg_389_1.time_ >= var_392_4 + var_392_5 and arg_389_1.time_ < var_392_4 + var_392_5 + arg_392_0 then
				local var_392_7 = Color.New(0, 0, 0)

				var_392_7.a = 1
				arg_389_1.mask_.color = var_392_7
			end

			local var_392_8 = 2

			if 2 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 then
				arg_389_1.mask_.enabled = true
				arg_389_1.mask_.raycastTarget = true

				arg_389_1:SetGaussion(false)
			end

			local var_392_9 = 2

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_9 then
				local var_392_10 = Color.New(0, 0, 0)

				var_392_10.a = Mathf.Lerp(1, 0, (arg_389_1.time_ - var_392_8) / var_392_9)
				arg_389_1.mask_.color = var_392_10
			end

			if arg_389_1.time_ >= var_392_8 + var_392_9 and arg_389_1.time_ < var_392_8 + var_392_9 + arg_392_0 then
				local var_392_11 = Color.New(0, 0, 0)

				arg_389_1.mask_.enabled = false
				var_392_11.a = 0
				arg_389_1.mask_.color = var_392_11
			end

			local var_392_12 = arg_389_1.actors_["10022"].transform

			if 3.8 < arg_389_1.time_ and arg_389_1.time_ <= 3.8 + arg_392_0 then
				arg_389_1.var_.moveOldPos10022 = var_392_12.localPosition
				var_392_12.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10022", 3)

				for iter_392_2 = 0, var_392_12.childCount - 1 do
					local var_392_13 = var_392_12:GetChild(iter_392_2)

					if var_392_13.name == "split_6" or not string.find(var_392_13.name, "split") then
						var_392_13.gameObject:SetActive(true)
					else
						var_392_13.gameObject:SetActive(false)
					end
				end
			end

			local var_392_14 = 0.001

			if 3.8 <= arg_389_1.time_ and arg_389_1.time_ < 3.8 + var_392_14 then
				var_392_12.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_389_1.time_ - 3.8) / var_392_14)
			end

			if arg_389_1.time_ >= 3.8 + var_392_14 and arg_389_1.time_ < 3.8 + var_392_14 + arg_392_0 then
				var_392_12.localPosition = Vector3.New(0, -315, -320)
			end

			local var_392_15 = arg_389_1.actors_["10022"]

			if 3.8 < arg_389_1.time_ and arg_389_1.time_ <= 3.8 + arg_392_0 and not isNil(var_392_15) and arg_389_1.var_.actorSpriteComps10022 == nil then
				arg_389_1.var_.actorSpriteComps10022 = var_392_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_16 = 0.034

			if 3.8 <= arg_389_1.time_ and arg_389_1.time_ < 3.8 + var_392_16 and not isNil(var_392_15) then
				if arg_389_1.var_.actorSpriteComps10022 then
					for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_392_4 then
							if arg_389_1.isInRecall_ then
								iter_392_4.color = Color.New(Mathf.Lerp(iter_392_4.color.r, arg_389_1.hightColor1.r, (arg_389_1.time_ - 3.8) / var_392_16), Mathf.Lerp(iter_392_4.color.g, arg_389_1.hightColor1.g, (arg_389_1.time_ - 3.8) / var_392_16), (Mathf.Lerp(iter_392_4.color.b, arg_389_1.hightColor1.b, (arg_389_1.time_ - 3.8) / var_392_16)))
							else
								local var_392_17 = Mathf.Lerp(iter_392_4.color.r, 1, (arg_389_1.time_ - 3.8) / var_392_16)

								iter_392_4.color = Color.New(var_392_17, var_392_17, var_392_17)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 3.8 + var_392_16 and arg_389_1.time_ < 3.8 + var_392_16 + arg_392_0 and not isNil(var_392_15) and arg_389_1.var_.actorSpriteComps10022 then
				for iter_392_5, iter_392_6 in pairs(arg_389_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_392_6 then
						iter_392_6.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_389_1.var_.actorSpriteComps10022 = nil
			end

			if 3.8 < arg_389_1.time_ and arg_389_1.time_ <= 3.8 + arg_392_0 then
				local var_392_18 = arg_389_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_392_18 then
					arg_389_1.var_.alphaOldValue10022 = var_392_18.alpha
					arg_389_1.var_.characterEffect10022 = var_392_18
				end

				arg_389_1.var_.alphaOldValue10022 = 0
			end

			local var_392_19 = 0.2

			if 3.8 <= arg_389_1.time_ and arg_389_1.time_ < 3.8 + var_392_19 then
				if arg_389_1.var_.characterEffect10022 then
					arg_389_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_389_1.var_.alphaOldValue10022, 1, (arg_389_1.time_ - 3.8) / var_392_19)
				end
			end

			if arg_389_1.time_ >= 3.8 + var_392_19 and arg_389_1.time_ < 3.8 + var_392_19 + arg_392_0 and arg_389_1.var_.characterEffect10022 then
				arg_389_1.var_.characterEffect10022.alpha = 1
			end

			if 2 < arg_389_1.time_ and arg_389_1.time_ <= 2 + arg_392_0 then
				arg_389_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete.awb")

				local var_392_22 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete")

				if "" ~= "" then
					if arg_389_1.bgmTxt_.text ~= var_392_22 and arg_389_1.bgmTxt_.text ~= "" then
						if arg_389_1.bgmTxt2_.text ~= "" then
							arg_389_1.bgmTxt_.text = arg_389_1.bgmTxt2_.text
						end

						arg_389_1.bgmTxt2_.text = var_392_22

						arg_389_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_389_1.bgmTxt_.text = var_392_22
						arg_389_1.bgmTxt2_.text = var_392_22
					end

					if arg_389_1.bgmTimer then
						arg_389_1.bgmTimer:Stop()

						arg_389_1.bgmTimer = nil
					end

					if arg_389_1.settingData.show_music_name == 1 then
						arg_389_1.musicController:SetSelectedState("show")
						arg_389_1.musicAnimator_:Play("open", 0, 0)

						if arg_389_1.settingData.music_time ~= 0 then
							arg_389_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_389_1.settingData.music_time), function()
								if arg_389_1 == nil or isNil(arg_389_1.bgmTxt_) then
									return
								end

								arg_389_1.musicController:SetSelectedState("hide")
								arg_389_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_389_1.frameCnt_ <= 1 then
				arg_389_1.dialog_:SetActive(false)
			end

			local var_392_23 = 3.9781379988407
			local var_392_24 = 1.1

			if 3.9781379988407 < arg_389_1.time_ and arg_389_1.time_ <= var_392_23 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0

				arg_389_1.dialog_:SetActive(true)

				arg_389_1.dialogCg_.alpha = 0

				local var_392_25 = LeanTween.value(arg_389_1.dialog_, 0, 1, 0.3)

				var_392_25:setOnUpdate(LuaHelper.FloatAction(function(arg_394_0)
					arg_389_1.dialogCg_.alpha = arg_394_0
				end))
				var_392_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_389_1.dialog_)
					var_392_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_389_1.duration_ = arg_389_1.duration_ + 0.3

				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_26 = arg_389_1:GetWordFromCfg(413031093)
				local var_392_27 = arg_389_1:FormatText(var_392_26.content)

				arg_389_1.text_.text = var_392_27

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_29 = 44 <= 0 and var_392_24 or var_392_24 * (utf8.len(var_392_27) / 44)

				if (44 <= 0 and var_392_24 or var_392_24 * (utf8.len(var_392_27) / 44)) > 0 and var_392_24 < var_392_29 then
					arg_389_1.talkMaxDuration = var_392_29
					var_392_23 = var_392_23 + 0.3

					if var_392_29 + var_392_23 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_29 + var_392_23
					end
				end

				arg_389_1.text_.text = var_392_27
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031093", "story_v_out_413031.awb") ~= 0 then
					local var_392_30 = manager.audio:GetVoiceLength("story_v_out_413031", "413031093", "story_v_out_413031.awb") / 1000

					if var_392_30 + var_392_23 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_30 + var_392_23
					end

					if var_392_26.prefab_name ~= "" and arg_389_1.actors_[var_392_26.prefab_name] ~= nil then
						local var_392_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_26.prefab_name].transform, "story_v_out_413031", "413031093", "story_v_out_413031.awb")

						arg_389_1:RecordAudio("413031093", var_392_31)
						arg_389_1:RecordAudio("413031093", var_392_31)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_413031", "413031093", "story_v_out_413031.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_413031", "413031093", "story_v_out_413031.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_32 = var_392_23 + 0.3
			local var_392_33 = math.max(var_392_24, arg_389_1.talkMaxDuration)

			if var_392_23 + 0.3 <= arg_389_1.time_ and arg_389_1.time_ < var_392_32 + var_392_33 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_32) / var_392_33

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_32 + var_392_33 and arg_389_1.time_ < var_392_32 + var_392_33 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
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

		arg_389_1:InitPlayNodeList()
	end,
	Play413031094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 413031094
		arg_396_1.duration_ = 2.5

		local var_396_0 = {
			zh = 1.999999999999,
			ja = 2.5
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play413031095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos10093 = arg_396_1.actors_["10093"].transform.localPosition
				arg_396_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_396_1:CheckSpriteTmpPos("10093", 3)

				for iter_399_0 = 0, arg_396_1.actors_["10093"].transform.childCount - 1 do
					local var_399_0 = arg_396_1.actors_["10093"].transform:GetChild(iter_399_0)

					if var_399_0.name == "split_4" or not string.find(var_399_0.name, "split") then
						var_399_0.gameObject:SetActive(true)
					else
						var_399_0.gameObject:SetActive(false)
					end
				end
			end

			local var_399_1 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_1 then
				arg_396_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_396_1.time_ - 0) / var_399_1)
			end

			if arg_396_1.time_ >= 0 + var_399_1 and arg_396_1.time_ < 0 + var_399_1 + arg_399_0 then
				arg_396_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_399_2 = arg_396_1.actors_["10093"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_2) and arg_396_1.var_.actorSpriteComps10093 == nil then
				arg_396_1.var_.actorSpriteComps10093 = var_399_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_3 = 2

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_3 and not isNil(var_399_2) then
				if arg_396_1.var_.actorSpriteComps10093 then
					for iter_399_1, iter_399_2 in pairs(arg_396_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_399_2 then
							if arg_396_1.isInRecall_ then
								iter_399_2.color = Color.New(Mathf.Lerp(iter_399_2.color.r, arg_396_1.hightColor1.r, (arg_396_1.time_ - 0) / var_399_3), Mathf.Lerp(iter_399_2.color.g, arg_396_1.hightColor1.g, (arg_396_1.time_ - 0) / var_399_3), (Mathf.Lerp(iter_399_2.color.b, arg_396_1.hightColor1.b, (arg_396_1.time_ - 0) / var_399_3)))
							else
								local var_399_4 = Mathf.Lerp(iter_399_2.color.r, 1, (arg_396_1.time_ - 0) / var_399_3)

								iter_399_2.color = Color.New(var_399_4, var_399_4, var_399_4)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= 0 + var_399_3 and arg_396_1.time_ < 0 + var_399_3 + arg_399_0 and not isNil(var_399_2) and arg_396_1.var_.actorSpriteComps10093 then
				for iter_399_3, iter_399_4 in pairs(arg_396_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_399_4 then
						iter_399_4.color = arg_396_1.isInRecall_ and (arg_396_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_396_1.var_.actorSpriteComps10093 = nil
			end

			local var_399_5 = arg_396_1.actors_["10022"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_5) and arg_396_1.var_.actorSpriteComps10022 == nil then
				arg_396_1.var_.actorSpriteComps10022 = var_399_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_6 = 2

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_6 and not isNil(var_399_5) then
				if arg_396_1.var_.actorSpriteComps10022 then
					for iter_399_5, iter_399_6 in pairs(arg_396_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_399_6 then
							if arg_396_1.isInRecall_ then
								iter_399_6.color = Color.New(Mathf.Lerp(iter_399_6.color.r, arg_396_1.hightColor2.r, (arg_396_1.time_ - 0) / var_399_6), Mathf.Lerp(iter_399_6.color.g, arg_396_1.hightColor2.g, (arg_396_1.time_ - 0) / var_399_6), (Mathf.Lerp(iter_399_6.color.b, arg_396_1.hightColor2.b, (arg_396_1.time_ - 0) / var_399_6)))
							else
								local var_399_7 = Mathf.Lerp(iter_399_6.color.r, 0.5, (arg_396_1.time_ - 0) / var_399_6)

								iter_399_6.color = Color.New(var_399_7, var_399_7, var_399_7)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= 0 + var_399_6 and arg_396_1.time_ < 0 + var_399_6 + arg_399_0 and not isNil(var_399_5) and arg_396_1.var_.actorSpriteComps10022 then
				for iter_399_7, iter_399_8 in pairs(arg_396_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_399_8 then
						iter_399_8.color = arg_396_1.isInRecall_ and (arg_396_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_396_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				local var_399_8 = arg_396_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_399_8 then
					arg_396_1.var_.alphaOldValue10093 = var_399_8.alpha
					arg_396_1.var_.characterEffect10093 = var_399_8
				end

				arg_396_1.var_.alphaOldValue10093 = 0
			end

			local var_399_9 = 0.2

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_9 then
				if arg_396_1.var_.characterEffect10093 then
					arg_396_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_396_1.var_.alphaOldValue10093, 1, (arg_396_1.time_ - 0) / var_399_9)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_9 and arg_396_1.time_ < 0 + var_399_9 + arg_399_0 and arg_396_1.var_.characterEffect10093 then
				arg_396_1.var_.characterEffect10093.alpha = 1
			end

			local var_399_10 = 0
			local var_399_11 = 0.15

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_10 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_12 = arg_396_1:GetWordFromCfg(413031094)
				local var_399_13 = arg_396_1:FormatText(var_399_12.content)

				arg_396_1.text_.text = var_399_13

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_15 = 6 <= 0 and var_399_11 or var_399_11 * (utf8.len(var_399_13) / 6)

				if (6 <= 0 and var_399_11 or var_399_11 * (utf8.len(var_399_13) / 6)) > 0 and var_399_11 < var_399_15 then
					arg_396_1.talkMaxDuration = var_399_15

					if var_399_15 + var_399_10 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_15 + var_399_10
					end
				end

				arg_396_1.text_.text = var_399_13
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031094", "story_v_out_413031.awb") ~= 0 then
					local var_399_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031094", "story_v_out_413031.awb") / 1000

					if var_399_16 + var_399_10 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_16 + var_399_10
					end

					if var_399_12.prefab_name ~= "" and arg_396_1.actors_[var_399_12.prefab_name] ~= nil then
						local var_399_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_12.prefab_name].transform, "story_v_out_413031", "413031094", "story_v_out_413031.awb")

						arg_396_1:RecordAudio("413031094", var_399_17)
						arg_396_1:RecordAudio("413031094", var_399_17)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_413031", "413031094", "story_v_out_413031.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_413031", "413031094", "story_v_out_413031.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_18 = math.max(var_399_11, arg_396_1.talkMaxDuration)

			if var_399_10 <= arg_396_1.time_ and arg_396_1.time_ < var_399_10 + var_399_18 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_10) / var_399_18

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_10 + var_399_18 and arg_396_1.time_ < var_399_10 + var_399_18 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
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

		arg_396_1:InitPlayNodeList()
	end,
	Play413031095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 413031095
		arg_400_1.duration_ = 7.67

		local var_400_0 = {
			zh = 5,
			ja = 7.666
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play413031096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos10093 = arg_400_1.actors_["10093"].transform.localPosition
				arg_400_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("10093", 2)

				for iter_403_0 = 0, arg_400_1.actors_["10093"].transform.childCount - 1 do
					local var_403_0 = arg_400_1.actors_["10093"].transform:GetChild(iter_403_0)

					if var_403_0.name == "" or not string.find(var_403_0.name, "split") then
						var_403_0.gameObject:SetActive(true)
					else
						var_403_0.gameObject:SetActive(false)
					end
				end
			end

			local var_403_1 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_1 then
				arg_400_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_400_1.time_ - 0) / var_403_1)
			end

			if arg_400_1.time_ >= 0 + var_403_1 and arg_400_1.time_ < 0 + var_403_1 + arg_403_0 then
				arg_400_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_403_2 = arg_400_1.actors_["10022"].transform

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos10022 = var_403_2.localPosition
				var_403_2.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("10022", 4)

				for iter_403_1 = 0, var_403_2.childCount - 1 do
					local var_403_3 = var_403_2:GetChild(iter_403_1)

					if var_403_3.name == "split_6" or not string.find(var_403_3.name, "split") then
						var_403_3.gameObject:SetActive(true)
					else
						var_403_3.gameObject:SetActive(false)
					end
				end
			end

			local var_403_4 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_4 then
				var_403_2.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_400_1.time_ - 0) / var_403_4)
			end

			if arg_400_1.time_ >= 0 + var_403_4 and arg_400_1.time_ < 0 + var_403_4 + arg_403_0 then
				var_403_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_403_5 = arg_400_1.actors_["10093"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_5) and arg_400_1.var_.actorSpriteComps10093 == nil then
				arg_400_1.var_.actorSpriteComps10093 = var_403_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_6 = 2

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_6 and not isNil(var_403_5) then
				if arg_400_1.var_.actorSpriteComps10093 then
					for iter_403_2, iter_403_3 in pairs(arg_400_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_403_3 then
							if arg_400_1.isInRecall_ then
								iter_403_3.color = Color.New(Mathf.Lerp(iter_403_3.color.r, arg_400_1.hightColor2.r, (arg_400_1.time_ - 0) / var_403_6), Mathf.Lerp(iter_403_3.color.g, arg_400_1.hightColor2.g, (arg_400_1.time_ - 0) / var_403_6), (Mathf.Lerp(iter_403_3.color.b, arg_400_1.hightColor2.b, (arg_400_1.time_ - 0) / var_403_6)))
							else
								local var_403_7 = Mathf.Lerp(iter_403_3.color.r, 0.5, (arg_400_1.time_ - 0) / var_403_6)

								iter_403_3.color = Color.New(var_403_7, var_403_7, var_403_7)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= 0 + var_403_6 and arg_400_1.time_ < 0 + var_403_6 + arg_403_0 and not isNil(var_403_5) and arg_400_1.var_.actorSpriteComps10093 then
				for iter_403_4, iter_403_5 in pairs(arg_400_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_403_5 then
						iter_403_5.color = arg_400_1.isInRecall_ and (arg_400_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_400_1.var_.actorSpriteComps10093 = nil
			end

			local var_403_8 = arg_400_1.actors_["10022"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_8) and arg_400_1.var_.actorSpriteComps10022 == nil then
				arg_400_1.var_.actorSpriteComps10022 = var_403_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_9 = 2

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_9 and not isNil(var_403_8) then
				if arg_400_1.var_.actorSpriteComps10022 then
					for iter_403_6, iter_403_7 in pairs(arg_400_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_403_7 then
							if arg_400_1.isInRecall_ then
								iter_403_7.color = Color.New(Mathf.Lerp(iter_403_7.color.r, arg_400_1.hightColor1.r, (arg_400_1.time_ - 0) / var_403_9), Mathf.Lerp(iter_403_7.color.g, arg_400_1.hightColor1.g, (arg_400_1.time_ - 0) / var_403_9), (Mathf.Lerp(iter_403_7.color.b, arg_400_1.hightColor1.b, (arg_400_1.time_ - 0) / var_403_9)))
							else
								local var_403_10 = Mathf.Lerp(iter_403_7.color.r, 1, (arg_400_1.time_ - 0) / var_403_9)

								iter_403_7.color = Color.New(var_403_10, var_403_10, var_403_10)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= 0 + var_403_9 and arg_400_1.time_ < 0 + var_403_9 + arg_403_0 and not isNil(var_403_8) and arg_400_1.var_.actorSpriteComps10022 then
				for iter_403_8, iter_403_9 in pairs(arg_400_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_403_9 then
						iter_403_9.color = arg_400_1.isInRecall_ and (arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_400_1.var_.actorSpriteComps10022 = nil
			end

			local var_403_11 = 0
			local var_403_12 = 0.7

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_11 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_13 = arg_400_1:GetWordFromCfg(413031095)
				local var_403_14 = arg_400_1:FormatText(var_403_13.content)

				arg_400_1.text_.text = var_403_14

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_16 = 28 <= 0 and var_403_12 or var_403_12 * (utf8.len(var_403_14) / 28)

				if (28 <= 0 and var_403_12 or var_403_12 * (utf8.len(var_403_14) / 28)) > 0 and var_403_12 < var_403_16 then
					arg_400_1.talkMaxDuration = var_403_16

					if var_403_16 + var_403_11 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_16 + var_403_11
					end
				end

				arg_400_1.text_.text = var_403_14
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031095", "story_v_out_413031.awb") ~= 0 then
					local var_403_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031095", "story_v_out_413031.awb") / 1000

					if var_403_17 + var_403_11 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_17 + var_403_11
					end

					if var_403_13.prefab_name ~= "" and arg_400_1.actors_[var_403_13.prefab_name] ~= nil then
						local var_403_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_13.prefab_name].transform, "story_v_out_413031", "413031095", "story_v_out_413031.awb")

						arg_400_1:RecordAudio("413031095", var_403_18)
						arg_400_1:RecordAudio("413031095", var_403_18)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_413031", "413031095", "story_v_out_413031.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_413031", "413031095", "story_v_out_413031.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_19 = math.max(var_403_12, arg_400_1.talkMaxDuration)

			if var_403_11 <= arg_400_1.time_ and arg_400_1.time_ < var_403_11 + var_403_19 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_11) / var_403_19

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_11 + var_403_19 and arg_400_1.time_ < var_403_11 + var_403_19 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play413031096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 413031096
		arg_404_1.duration_ = 7.4

		local var_404_0 = {
			zh = 7.4,
			ja = 5.466
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play413031097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos10093 = arg_404_1.actors_["10093"].transform.localPosition
				arg_404_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_404_1:CheckSpriteTmpPos("10093", 2)

				for iter_407_0 = 0, arg_404_1.actors_["10093"].transform.childCount - 1 do
					local var_407_0 = arg_404_1.actors_["10093"].transform:GetChild(iter_407_0)

					if var_407_0.name == "split_4" or not string.find(var_407_0.name, "split") then
						var_407_0.gameObject:SetActive(true)
					else
						var_407_0.gameObject:SetActive(false)
					end
				end
			end

			local var_407_1 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_1 then
				arg_404_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_404_1.time_ - 0) / var_407_1)
			end

			if arg_404_1.time_ >= 0 + var_407_1 and arg_404_1.time_ < 0 + var_407_1 + arg_407_0 then
				arg_404_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_407_2 = arg_404_1.actors_["10093"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_2) and arg_404_1.var_.actorSpriteComps10093 == nil then
				arg_404_1.var_.actorSpriteComps10093 = var_407_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_3 = 2

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_3 and not isNil(var_407_2) then
				if arg_404_1.var_.actorSpriteComps10093 then
					for iter_407_1, iter_407_2 in pairs(arg_404_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_407_2 then
							if arg_404_1.isInRecall_ then
								iter_407_2.color = Color.New(Mathf.Lerp(iter_407_2.color.r, arg_404_1.hightColor1.r, (arg_404_1.time_ - 0) / var_407_3), Mathf.Lerp(iter_407_2.color.g, arg_404_1.hightColor1.g, (arg_404_1.time_ - 0) / var_407_3), (Mathf.Lerp(iter_407_2.color.b, arg_404_1.hightColor1.b, (arg_404_1.time_ - 0) / var_407_3)))
							else
								local var_407_4 = Mathf.Lerp(iter_407_2.color.r, 1, (arg_404_1.time_ - 0) / var_407_3)

								iter_407_2.color = Color.New(var_407_4, var_407_4, var_407_4)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= 0 + var_407_3 and arg_404_1.time_ < 0 + var_407_3 + arg_407_0 and not isNil(var_407_2) and arg_404_1.var_.actorSpriteComps10093 then
				for iter_407_3, iter_407_4 in pairs(arg_404_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_407_4 then
						iter_407_4.color = arg_404_1.isInRecall_ and (arg_404_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_404_1.var_.actorSpriteComps10093 = nil
			end

			local var_407_5 = arg_404_1.actors_["10022"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_5) and arg_404_1.var_.actorSpriteComps10022 == nil then
				arg_404_1.var_.actorSpriteComps10022 = var_407_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_6 = 2

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_6 and not isNil(var_407_5) then
				if arg_404_1.var_.actorSpriteComps10022 then
					for iter_407_5, iter_407_6 in pairs(arg_404_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_407_6 then
							if arg_404_1.isInRecall_ then
								iter_407_6.color = Color.New(Mathf.Lerp(iter_407_6.color.r, arg_404_1.hightColor2.r, (arg_404_1.time_ - 0) / var_407_6), Mathf.Lerp(iter_407_6.color.g, arg_404_1.hightColor2.g, (arg_404_1.time_ - 0) / var_407_6), (Mathf.Lerp(iter_407_6.color.b, arg_404_1.hightColor2.b, (arg_404_1.time_ - 0) / var_407_6)))
							else
								local var_407_7 = Mathf.Lerp(iter_407_6.color.r, 0.5, (arg_404_1.time_ - 0) / var_407_6)

								iter_407_6.color = Color.New(var_407_7, var_407_7, var_407_7)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= 0 + var_407_6 and arg_404_1.time_ < 0 + var_407_6 + arg_407_0 and not isNil(var_407_5) and arg_404_1.var_.actorSpriteComps10022 then
				for iter_407_7, iter_407_8 in pairs(arg_404_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_407_8 then
						iter_407_8.color = arg_404_1.isInRecall_ and (arg_404_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_404_1.var_.actorSpriteComps10022 = nil
			end

			local var_407_8 = 0
			local var_407_9 = 0.95

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_8 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_10 = arg_404_1:GetWordFromCfg(413031096)
				local var_407_11 = arg_404_1:FormatText(var_407_10.content)

				arg_404_1.text_.text = var_407_11

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_13 = 38 <= 0 and var_407_9 or var_407_9 * (utf8.len(var_407_11) / 38)

				if (38 <= 0 and var_407_9 or var_407_9 * (utf8.len(var_407_11) / 38)) > 0 and var_407_9 < var_407_13 then
					arg_404_1.talkMaxDuration = var_407_13

					if var_407_13 + var_407_8 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_13 + var_407_8
					end
				end

				arg_404_1.text_.text = var_407_11
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031096", "story_v_out_413031.awb") ~= 0 then
					local var_407_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031096", "story_v_out_413031.awb") / 1000

					if var_407_14 + var_407_8 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_14 + var_407_8
					end

					if var_407_10.prefab_name ~= "" and arg_404_1.actors_[var_407_10.prefab_name] ~= nil then
						local var_407_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_10.prefab_name].transform, "story_v_out_413031", "413031096", "story_v_out_413031.awb")

						arg_404_1:RecordAudio("413031096", var_407_15)
						arg_404_1:RecordAudio("413031096", var_407_15)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_413031", "413031096", "story_v_out_413031.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_413031", "413031096", "story_v_out_413031.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_16 = math.max(var_407_9, arg_404_1.talkMaxDuration)

			if var_407_8 <= arg_404_1.time_ and arg_404_1.time_ < var_407_8 + var_407_16 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_8) / var_407_16

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_8 + var_407_16 and arg_404_1.time_ < var_407_8 + var_407_16 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
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

		arg_404_1:InitPlayNodeList()
	end,
	Play413031097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 413031097
		arg_408_1.duration_ = 8.17

		local var_408_0 = {
			zh = 5.866,
			ja = 8.166
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play413031098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.8

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_1 = arg_408_1:GetWordFromCfg(413031097)
				local var_411_2 = arg_408_1:FormatText(var_411_1.content)

				arg_408_1.text_.text = var_411_2

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 32 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 32)

				if (32 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 32)) > 0 and var_411_0 < var_411_4 then
					arg_408_1.talkMaxDuration = var_411_4

					if var_411_4 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_4 + 0
					end
				end

				arg_408_1.text_.text = var_411_2
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031097", "story_v_out_413031.awb") ~= 0 then
					local var_411_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031097", "story_v_out_413031.awb") / 1000

					if var_411_5 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + 0
					end

					if var_411_1.prefab_name ~= "" and arg_408_1.actors_[var_411_1.prefab_name] ~= nil then
						local var_411_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_1.prefab_name].transform, "story_v_out_413031", "413031097", "story_v_out_413031.awb")

						arg_408_1:RecordAudio("413031097", var_411_6)
						arg_408_1:RecordAudio("413031097", var_411_6)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_413031", "413031097", "story_v_out_413031.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_413031", "413031097", "story_v_out_413031.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_7 and arg_408_1.time_ < 0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play413031098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 413031098
		arg_412_1.duration_ = 6.63

		local var_412_0 = {
			zh = 3.133,
			ja = 6.633
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play413031099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(arg_412_1.actors_["10093"]) and arg_412_1.var_.actorSpriteComps10093 == nil then
				arg_412_1.var_.actorSpriteComps10093 = arg_412_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_0 = 2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 and not isNil(arg_412_1.actors_["10093"]) then
				if arg_412_1.var_.actorSpriteComps10093 then
					for iter_415_0, iter_415_1 in pairs(arg_412_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_415_1 then
							if arg_412_1.isInRecall_ then
								iter_415_1.color = Color.New(Mathf.Lerp(iter_415_1.color.r, arg_412_1.hightColor2.r, (arg_412_1.time_ - 0) / var_415_0), Mathf.Lerp(iter_415_1.color.g, arg_412_1.hightColor2.g, (arg_412_1.time_ - 0) / var_415_0), (Mathf.Lerp(iter_415_1.color.b, arg_412_1.hightColor2.b, (arg_412_1.time_ - 0) / var_415_0)))
							else
								local var_415_1 = Mathf.Lerp(iter_415_1.color.r, 0.5, (arg_412_1.time_ - 0) / var_415_0)

								iter_415_1.color = Color.New(var_415_1, var_415_1, var_415_1)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 and not isNil(arg_412_1.actors_["10093"]) and arg_412_1.var_.actorSpriteComps10093 then
				for iter_415_2, iter_415_3 in pairs(arg_412_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_415_3 then
						iter_415_3.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_412_1.var_.actorSpriteComps10093 = nil
			end

			local var_415_2 = arg_412_1.actors_["10022"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.actorSpriteComps10022 == nil then
				arg_412_1.var_.actorSpriteComps10022 = var_415_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_3 = 2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_3 and not isNil(var_415_2) then
				if arg_412_1.var_.actorSpriteComps10022 then
					for iter_415_4, iter_415_5 in pairs(arg_412_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_415_5 then
							if arg_412_1.isInRecall_ then
								iter_415_5.color = Color.New(Mathf.Lerp(iter_415_5.color.r, arg_412_1.hightColor1.r, (arg_412_1.time_ - 0) / var_415_3), Mathf.Lerp(iter_415_5.color.g, arg_412_1.hightColor1.g, (arg_412_1.time_ - 0) / var_415_3), (Mathf.Lerp(iter_415_5.color.b, arg_412_1.hightColor1.b, (arg_412_1.time_ - 0) / var_415_3)))
							else
								local var_415_4 = Mathf.Lerp(iter_415_5.color.r, 1, (arg_412_1.time_ - 0) / var_415_3)

								iter_415_5.color = Color.New(var_415_4, var_415_4, var_415_4)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_3 and arg_412_1.time_ < 0 + var_415_3 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.actorSpriteComps10022 then
				for iter_415_6, iter_415_7 in pairs(arg_412_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_415_7 then
						iter_415_7.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_412_1.var_.actorSpriteComps10022 = nil
			end

			local var_415_5 = 0
			local var_415_6 = 0.475

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_5 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_7 = arg_412_1:GetWordFromCfg(413031098)
				local var_415_8 = arg_412_1:FormatText(var_415_7.content)

				arg_412_1.text_.text = var_415_8

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_10 = 19 <= 0 and var_415_6 or var_415_6 * (utf8.len(var_415_8) / 19)

				if (19 <= 0 and var_415_6 or var_415_6 * (utf8.len(var_415_8) / 19)) > 0 and var_415_6 < var_415_10 then
					arg_412_1.talkMaxDuration = var_415_10

					if var_415_10 + var_415_5 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_10 + var_415_5
					end
				end

				arg_412_1.text_.text = var_415_8
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031098", "story_v_out_413031.awb") ~= 0 then
					local var_415_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031098", "story_v_out_413031.awb") / 1000

					if var_415_11 + var_415_5 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_11 + var_415_5
					end

					if var_415_7.prefab_name ~= "" and arg_412_1.actors_[var_415_7.prefab_name] ~= nil then
						local var_415_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_7.prefab_name].transform, "story_v_out_413031", "413031098", "story_v_out_413031.awb")

						arg_412_1:RecordAudio("413031098", var_415_12)
						arg_412_1:RecordAudio("413031098", var_415_12)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_413031", "413031098", "story_v_out_413031.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_413031", "413031098", "story_v_out_413031.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_13 = math.max(var_415_6, arg_412_1.talkMaxDuration)

			if var_415_5 <= arg_412_1.time_ and arg_412_1.time_ < var_415_5 + var_415_13 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_5) / var_415_13

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_5 + var_415_13 and arg_412_1.time_ < var_415_5 + var_415_13 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play413031099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 413031099
		arg_416_1.duration_ = 11.03

		local var_416_0 = {
			zh = 9.833,
			ja = 11.033
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play413031100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos10093 = arg_416_1.actors_["10093"].transform.localPosition
				arg_416_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("10093", 2)

				for iter_419_0 = 0, arg_416_1.actors_["10093"].transform.childCount - 1 do
					local var_419_0 = arg_416_1.actors_["10093"].transform:GetChild(iter_419_0)

					if var_419_0.name == "split_6" or not string.find(var_419_0.name, "split") then
						var_419_0.gameObject:SetActive(true)
					else
						var_419_0.gameObject:SetActive(false)
					end
				end
			end

			local var_419_1 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_1 then
				arg_416_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_416_1.time_ - 0) / var_419_1)
			end

			if arg_416_1.time_ >= 0 + var_419_1 and arg_416_1.time_ < 0 + var_419_1 + arg_419_0 then
				arg_416_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_419_2 = arg_416_1.actors_["10093"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_2) and arg_416_1.var_.actorSpriteComps10093 == nil then
				arg_416_1.var_.actorSpriteComps10093 = var_419_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_3 = 2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_3 and not isNil(var_419_2) then
				if arg_416_1.var_.actorSpriteComps10093 then
					for iter_419_1, iter_419_2 in pairs(arg_416_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_419_2 then
							if arg_416_1.isInRecall_ then
								iter_419_2.color = Color.New(Mathf.Lerp(iter_419_2.color.r, arg_416_1.hightColor1.r, (arg_416_1.time_ - 0) / var_419_3), Mathf.Lerp(iter_419_2.color.g, arg_416_1.hightColor1.g, (arg_416_1.time_ - 0) / var_419_3), (Mathf.Lerp(iter_419_2.color.b, arg_416_1.hightColor1.b, (arg_416_1.time_ - 0) / var_419_3)))
							else
								local var_419_4 = Mathf.Lerp(iter_419_2.color.r, 1, (arg_416_1.time_ - 0) / var_419_3)

								iter_419_2.color = Color.New(var_419_4, var_419_4, var_419_4)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= 0 + var_419_3 and arg_416_1.time_ < 0 + var_419_3 + arg_419_0 and not isNil(var_419_2) and arg_416_1.var_.actorSpriteComps10093 then
				for iter_419_3, iter_419_4 in pairs(arg_416_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_419_4 then
						iter_419_4.color = arg_416_1.isInRecall_ and (arg_416_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_416_1.var_.actorSpriteComps10093 = nil
			end

			local var_419_5 = arg_416_1.actors_["10022"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_5) and arg_416_1.var_.actorSpriteComps10022 == nil then
				arg_416_1.var_.actorSpriteComps10022 = var_419_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_6 = 2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_6 and not isNil(var_419_5) then
				if arg_416_1.var_.actorSpriteComps10022 then
					for iter_419_5, iter_419_6 in pairs(arg_416_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_419_6 then
							if arg_416_1.isInRecall_ then
								iter_419_6.color = Color.New(Mathf.Lerp(iter_419_6.color.r, arg_416_1.hightColor2.r, (arg_416_1.time_ - 0) / var_419_6), Mathf.Lerp(iter_419_6.color.g, arg_416_1.hightColor2.g, (arg_416_1.time_ - 0) / var_419_6), (Mathf.Lerp(iter_419_6.color.b, arg_416_1.hightColor2.b, (arg_416_1.time_ - 0) / var_419_6)))
							else
								local var_419_7 = Mathf.Lerp(iter_419_6.color.r, 0.5, (arg_416_1.time_ - 0) / var_419_6)

								iter_419_6.color = Color.New(var_419_7, var_419_7, var_419_7)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= 0 + var_419_6 and arg_416_1.time_ < 0 + var_419_6 + arg_419_0 and not isNil(var_419_5) and arg_416_1.var_.actorSpriteComps10022 then
				for iter_419_7, iter_419_8 in pairs(arg_416_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_419_8 then
						iter_419_8.color = arg_416_1.isInRecall_ and (arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_416_1.var_.actorSpriteComps10022 = nil
			end

			local var_419_8 = 0
			local var_419_9 = 1.05

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_8 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_10 = arg_416_1:GetWordFromCfg(413031099)
				local var_419_11 = arg_416_1:FormatText(var_419_10.content)

				arg_416_1.text_.text = var_419_11

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_13 = 42 <= 0 and var_419_9 or var_419_9 * (utf8.len(var_419_11) / 42)

				if (42 <= 0 and var_419_9 or var_419_9 * (utf8.len(var_419_11) / 42)) > 0 and var_419_9 < var_419_13 then
					arg_416_1.talkMaxDuration = var_419_13

					if var_419_13 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_13 + var_419_8
					end
				end

				arg_416_1.text_.text = var_419_11
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031099", "story_v_out_413031.awb") ~= 0 then
					local var_419_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031099", "story_v_out_413031.awb") / 1000

					if var_419_14 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_14 + var_419_8
					end

					if var_419_10.prefab_name ~= "" and arg_416_1.actors_[var_419_10.prefab_name] ~= nil then
						local var_419_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_10.prefab_name].transform, "story_v_out_413031", "413031099", "story_v_out_413031.awb")

						arg_416_1:RecordAudio("413031099", var_419_15)
						arg_416_1:RecordAudio("413031099", var_419_15)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_413031", "413031099", "story_v_out_413031.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_413031", "413031099", "story_v_out_413031.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_16 = math.max(var_419_9, arg_416_1.talkMaxDuration)

			if var_419_8 <= arg_416_1.time_ and arg_416_1.time_ < var_419_8 + var_419_16 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_8) / var_419_16

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_8 + var_419_16 and arg_416_1.time_ < var_419_8 + var_419_16 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
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

		arg_416_1:InitPlayNodeList()
	end,
	Play413031100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 413031100
		arg_420_1.duration_ = 8.83

		local var_420_0 = {
			zh = 3.933,
			ja = 8.833
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play413031101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos10022 = arg_420_1.actors_["10022"].transform.localPosition
				arg_420_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_420_1:CheckSpriteTmpPos("10022", 4)

				for iter_423_0 = 0, arg_420_1.actors_["10022"].transform.childCount - 1 do
					local var_423_0 = arg_420_1.actors_["10022"].transform:GetChild(iter_423_0)

					if var_423_0.name == "split_8" or not string.find(var_423_0.name, "split") then
						var_423_0.gameObject:SetActive(true)
					else
						var_423_0.gameObject:SetActive(false)
					end
				end
			end

			local var_423_1 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_1 then
				arg_420_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_420_1.time_ - 0) / var_423_1)
			end

			if arg_420_1.time_ >= 0 + var_423_1 and arg_420_1.time_ < 0 + var_423_1 + arg_423_0 then
				arg_420_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_423_2 = arg_420_1.actors_["10093"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_2) and arg_420_1.var_.actorSpriteComps10093 == nil then
				arg_420_1.var_.actorSpriteComps10093 = var_423_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_3 = 2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_3 and not isNil(var_423_2) then
				if arg_420_1.var_.actorSpriteComps10093 then
					for iter_423_1, iter_423_2 in pairs(arg_420_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_423_2 then
							if arg_420_1.isInRecall_ then
								iter_423_2.color = Color.New(Mathf.Lerp(iter_423_2.color.r, arg_420_1.hightColor2.r, (arg_420_1.time_ - 0) / var_423_3), Mathf.Lerp(iter_423_2.color.g, arg_420_1.hightColor2.g, (arg_420_1.time_ - 0) / var_423_3), (Mathf.Lerp(iter_423_2.color.b, arg_420_1.hightColor2.b, (arg_420_1.time_ - 0) / var_423_3)))
							else
								local var_423_4 = Mathf.Lerp(iter_423_2.color.r, 0.5, (arg_420_1.time_ - 0) / var_423_3)

								iter_423_2.color = Color.New(var_423_4, var_423_4, var_423_4)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= 0 + var_423_3 and arg_420_1.time_ < 0 + var_423_3 + arg_423_0 and not isNil(var_423_2) and arg_420_1.var_.actorSpriteComps10093 then
				for iter_423_3, iter_423_4 in pairs(arg_420_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_423_4 then
						iter_423_4.color = arg_420_1.isInRecall_ and (arg_420_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_420_1.var_.actorSpriteComps10093 = nil
			end

			local var_423_5 = arg_420_1.actors_["10022"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_5) and arg_420_1.var_.actorSpriteComps10022 == nil then
				arg_420_1.var_.actorSpriteComps10022 = var_423_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_6 = 2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_6 and not isNil(var_423_5) then
				if arg_420_1.var_.actorSpriteComps10022 then
					for iter_423_5, iter_423_6 in pairs(arg_420_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_423_6 then
							if arg_420_1.isInRecall_ then
								iter_423_6.color = Color.New(Mathf.Lerp(iter_423_6.color.r, arg_420_1.hightColor1.r, (arg_420_1.time_ - 0) / var_423_6), Mathf.Lerp(iter_423_6.color.g, arg_420_1.hightColor1.g, (arg_420_1.time_ - 0) / var_423_6), (Mathf.Lerp(iter_423_6.color.b, arg_420_1.hightColor1.b, (arg_420_1.time_ - 0) / var_423_6)))
							else
								local var_423_7 = Mathf.Lerp(iter_423_6.color.r, 1, (arg_420_1.time_ - 0) / var_423_6)

								iter_423_6.color = Color.New(var_423_7, var_423_7, var_423_7)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= 0 + var_423_6 and arg_420_1.time_ < 0 + var_423_6 + arg_423_0 and not isNil(var_423_5) and arg_420_1.var_.actorSpriteComps10022 then
				for iter_423_7, iter_423_8 in pairs(arg_420_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_423_8 then
						iter_423_8.color = arg_420_1.isInRecall_ and (arg_420_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_420_1.var_.actorSpriteComps10022 = nil
			end

			local var_423_8 = 0
			local var_423_9 = 0.6

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_8 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_10 = arg_420_1:GetWordFromCfg(413031100)
				local var_423_11 = arg_420_1:FormatText(var_423_10.content)

				arg_420_1.text_.text = var_423_11

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_13 = 24 <= 0 and var_423_9 or var_423_9 * (utf8.len(var_423_11) / 24)

				if (24 <= 0 and var_423_9 or var_423_9 * (utf8.len(var_423_11) / 24)) > 0 and var_423_9 < var_423_13 then
					arg_420_1.talkMaxDuration = var_423_13

					if var_423_13 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_8
					end
				end

				arg_420_1.text_.text = var_423_11
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031100", "story_v_out_413031.awb") ~= 0 then
					local var_423_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031100", "story_v_out_413031.awb") / 1000

					if var_423_14 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_14 + var_423_8
					end

					if var_423_10.prefab_name ~= "" and arg_420_1.actors_[var_423_10.prefab_name] ~= nil then
						local var_423_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_10.prefab_name].transform, "story_v_out_413031", "413031100", "story_v_out_413031.awb")

						arg_420_1:RecordAudio("413031100", var_423_15)
						arg_420_1:RecordAudio("413031100", var_423_15)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_413031", "413031100", "story_v_out_413031.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_413031", "413031100", "story_v_out_413031.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_16 = math.max(var_423_9, arg_420_1.talkMaxDuration)

			if var_423_8 <= arg_420_1.time_ and arg_420_1.time_ < var_423_8 + var_423_16 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_8) / var_423_16

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_8 + var_423_16 and arg_420_1.time_ < var_423_8 + var_423_16 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
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

		arg_420_1:InitPlayNodeList()
	end,
	Play413031101 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 413031101
		arg_424_1.duration_ = 3.23

		local var_424_0 = {
			zh = 3,
			ja = 3.233
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play413031102(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos10093 = arg_424_1.actors_["10093"].transform.localPosition
				arg_424_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("10093", 2)

				for iter_427_0 = 0, arg_424_1.actors_["10093"].transform.childCount - 1 do
					local var_427_0 = arg_424_1.actors_["10093"].transform:GetChild(iter_427_0)

					if var_427_0.name == "split_4" or not string.find(var_427_0.name, "split") then
						var_427_0.gameObject:SetActive(true)
					else
						var_427_0.gameObject:SetActive(false)
					end
				end
			end

			local var_427_1 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_1 then
				arg_424_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_424_1.time_ - 0) / var_427_1)
			end

			if arg_424_1.time_ >= 0 + var_427_1 and arg_424_1.time_ < 0 + var_427_1 + arg_427_0 then
				arg_424_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_427_2 = arg_424_1.actors_["10093"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_2) and arg_424_1.var_.actorSpriteComps10093 == nil then
				arg_424_1.var_.actorSpriteComps10093 = var_427_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_3 = 2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_3 and not isNil(var_427_2) then
				if arg_424_1.var_.actorSpriteComps10093 then
					for iter_427_1, iter_427_2 in pairs(arg_424_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_427_2 then
							if arg_424_1.isInRecall_ then
								iter_427_2.color = Color.New(Mathf.Lerp(iter_427_2.color.r, arg_424_1.hightColor1.r, (arg_424_1.time_ - 0) / var_427_3), Mathf.Lerp(iter_427_2.color.g, arg_424_1.hightColor1.g, (arg_424_1.time_ - 0) / var_427_3), (Mathf.Lerp(iter_427_2.color.b, arg_424_1.hightColor1.b, (arg_424_1.time_ - 0) / var_427_3)))
							else
								local var_427_4 = Mathf.Lerp(iter_427_2.color.r, 1, (arg_424_1.time_ - 0) / var_427_3)

								iter_427_2.color = Color.New(var_427_4, var_427_4, var_427_4)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= 0 + var_427_3 and arg_424_1.time_ < 0 + var_427_3 + arg_427_0 and not isNil(var_427_2) and arg_424_1.var_.actorSpriteComps10093 then
				for iter_427_3, iter_427_4 in pairs(arg_424_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_427_4 then
						iter_427_4.color = arg_424_1.isInRecall_ and (arg_424_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_424_1.var_.actorSpriteComps10093 = nil
			end

			local var_427_5 = arg_424_1.actors_["10022"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_5) and arg_424_1.var_.actorSpriteComps10022 == nil then
				arg_424_1.var_.actorSpriteComps10022 = var_427_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_6 = 2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_6 and not isNil(var_427_5) then
				if arg_424_1.var_.actorSpriteComps10022 then
					for iter_427_5, iter_427_6 in pairs(arg_424_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_427_6 then
							if arg_424_1.isInRecall_ then
								iter_427_6.color = Color.New(Mathf.Lerp(iter_427_6.color.r, arg_424_1.hightColor2.r, (arg_424_1.time_ - 0) / var_427_6), Mathf.Lerp(iter_427_6.color.g, arg_424_1.hightColor2.g, (arg_424_1.time_ - 0) / var_427_6), (Mathf.Lerp(iter_427_6.color.b, arg_424_1.hightColor2.b, (arg_424_1.time_ - 0) / var_427_6)))
							else
								local var_427_7 = Mathf.Lerp(iter_427_6.color.r, 0.5, (arg_424_1.time_ - 0) / var_427_6)

								iter_427_6.color = Color.New(var_427_7, var_427_7, var_427_7)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= 0 + var_427_6 and arg_424_1.time_ < 0 + var_427_6 + arg_427_0 and not isNil(var_427_5) and arg_424_1.var_.actorSpriteComps10022 then
				for iter_427_7, iter_427_8 in pairs(arg_424_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_427_8 then
						iter_427_8.color = arg_424_1.isInRecall_ and (arg_424_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_424_1.var_.actorSpriteComps10022 = nil
			end

			local var_427_8 = 0
			local var_427_9 = 0.375

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_8 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_10 = arg_424_1:GetWordFromCfg(413031101)
				local var_427_11 = arg_424_1:FormatText(var_427_10.content)

				arg_424_1.text_.text = var_427_11

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_13 = 15 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 15)

				if (15 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 15)) > 0 and var_427_9 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_8
					end
				end

				arg_424_1.text_.text = var_427_11
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031101", "story_v_out_413031.awb") ~= 0 then
					local var_427_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031101", "story_v_out_413031.awb") / 1000

					if var_427_14 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_14 + var_427_8
					end

					if var_427_10.prefab_name ~= "" and arg_424_1.actors_[var_427_10.prefab_name] ~= nil then
						local var_427_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_10.prefab_name].transform, "story_v_out_413031", "413031101", "story_v_out_413031.awb")

						arg_424_1:RecordAudio("413031101", var_427_15)
						arg_424_1:RecordAudio("413031101", var_427_15)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_413031", "413031101", "story_v_out_413031.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_413031", "413031101", "story_v_out_413031.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_16 = math.max(var_427_9, arg_424_1.talkMaxDuration)

			if var_427_8 <= arg_424_1.time_ and arg_424_1.time_ < var_427_8 + var_427_16 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_8) / var_427_16

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_8 + var_427_16 and arg_424_1.time_ < var_427_8 + var_427_16 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
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

		arg_424_1:InitPlayNodeList()
	end,
	Play413031102 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 413031102
		arg_428_1.duration_ = 4.3

		local var_428_0 = {
			zh = 3.233,
			ja = 4.3
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play413031103(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos10022 = arg_428_1.actors_["10022"].transform.localPosition
				arg_428_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("10022", 4)

				for iter_431_0 = 0, arg_428_1.actors_["10022"].transform.childCount - 1 do
					local var_431_0 = arg_428_1.actors_["10022"].transform:GetChild(iter_431_0)

					if var_431_0.name == "split_6" or not string.find(var_431_0.name, "split") then
						var_431_0.gameObject:SetActive(true)
					else
						var_431_0.gameObject:SetActive(false)
					end
				end
			end

			local var_431_1 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_1 then
				arg_428_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_428_1.time_ - 0) / var_431_1)
			end

			if arg_428_1.time_ >= 0 + var_431_1 and arg_428_1.time_ < 0 + var_431_1 + arg_431_0 then
				arg_428_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_431_2 = arg_428_1.actors_["10093"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_2) and arg_428_1.var_.actorSpriteComps10093 == nil then
				arg_428_1.var_.actorSpriteComps10093 = var_431_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_3 = 2

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_3 and not isNil(var_431_2) then
				if arg_428_1.var_.actorSpriteComps10093 then
					for iter_431_1, iter_431_2 in pairs(arg_428_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_431_2 then
							if arg_428_1.isInRecall_ then
								iter_431_2.color = Color.New(Mathf.Lerp(iter_431_2.color.r, arg_428_1.hightColor2.r, (arg_428_1.time_ - 0) / var_431_3), Mathf.Lerp(iter_431_2.color.g, arg_428_1.hightColor2.g, (arg_428_1.time_ - 0) / var_431_3), (Mathf.Lerp(iter_431_2.color.b, arg_428_1.hightColor2.b, (arg_428_1.time_ - 0) / var_431_3)))
							else
								local var_431_4 = Mathf.Lerp(iter_431_2.color.r, 0.5, (arg_428_1.time_ - 0) / var_431_3)

								iter_431_2.color = Color.New(var_431_4, var_431_4, var_431_4)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= 0 + var_431_3 and arg_428_1.time_ < 0 + var_431_3 + arg_431_0 and not isNil(var_431_2) and arg_428_1.var_.actorSpriteComps10093 then
				for iter_431_3, iter_431_4 in pairs(arg_428_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_431_4 then
						iter_431_4.color = arg_428_1.isInRecall_ and (arg_428_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_428_1.var_.actorSpriteComps10093 = nil
			end

			local var_431_5 = arg_428_1.actors_["10022"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_5) and arg_428_1.var_.actorSpriteComps10022 == nil then
				arg_428_1.var_.actorSpriteComps10022 = var_431_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_6 = 2

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_6 and not isNil(var_431_5) then
				if arg_428_1.var_.actorSpriteComps10022 then
					for iter_431_5, iter_431_6 in pairs(arg_428_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_431_6 then
							if arg_428_1.isInRecall_ then
								iter_431_6.color = Color.New(Mathf.Lerp(iter_431_6.color.r, arg_428_1.hightColor1.r, (arg_428_1.time_ - 0) / var_431_6), Mathf.Lerp(iter_431_6.color.g, arg_428_1.hightColor1.g, (arg_428_1.time_ - 0) / var_431_6), (Mathf.Lerp(iter_431_6.color.b, arg_428_1.hightColor1.b, (arg_428_1.time_ - 0) / var_431_6)))
							else
								local var_431_7 = Mathf.Lerp(iter_431_6.color.r, 1, (arg_428_1.time_ - 0) / var_431_6)

								iter_431_6.color = Color.New(var_431_7, var_431_7, var_431_7)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= 0 + var_431_6 and arg_428_1.time_ < 0 + var_431_6 + arg_431_0 and not isNil(var_431_5) and arg_428_1.var_.actorSpriteComps10022 then
				for iter_431_7, iter_431_8 in pairs(arg_428_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_431_8 then
						iter_431_8.color = arg_428_1.isInRecall_ and (arg_428_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_428_1.var_.actorSpriteComps10022 = nil
			end

			local var_431_8 = 0
			local var_431_9 = 0.35

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_8 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_10 = arg_428_1:GetWordFromCfg(413031102)
				local var_431_11 = arg_428_1:FormatText(var_431_10.content)

				arg_428_1.text_.text = var_431_11

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_13 = 14 <= 0 and var_431_9 or var_431_9 * (utf8.len(var_431_11) / 14)

				if (14 <= 0 and var_431_9 or var_431_9 * (utf8.len(var_431_11) / 14)) > 0 and var_431_9 < var_431_13 then
					arg_428_1.talkMaxDuration = var_431_13

					if var_431_13 + var_431_8 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_13 + var_431_8
					end
				end

				arg_428_1.text_.text = var_431_11
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031102", "story_v_out_413031.awb") ~= 0 then
					local var_431_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031102", "story_v_out_413031.awb") / 1000

					if var_431_14 + var_431_8 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_14 + var_431_8
					end

					if var_431_10.prefab_name ~= "" and arg_428_1.actors_[var_431_10.prefab_name] ~= nil then
						local var_431_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_10.prefab_name].transform, "story_v_out_413031", "413031102", "story_v_out_413031.awb")

						arg_428_1:RecordAudio("413031102", var_431_15)
						arg_428_1:RecordAudio("413031102", var_431_15)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_413031", "413031102", "story_v_out_413031.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_413031", "413031102", "story_v_out_413031.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_16 = math.max(var_431_9, arg_428_1.talkMaxDuration)

			if var_431_8 <= arg_428_1.time_ and arg_428_1.time_ < var_431_8 + var_431_16 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_8) / var_431_16

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_8 + var_431_16 and arg_428_1.time_ < var_431_8 + var_431_16 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
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

		arg_428_1:InitPlayNodeList()
	end,
	Play413031103 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 413031103
		arg_432_1.duration_ = 8.53

		local var_432_0 = {
			zh = 6.733,
			ja = 8.533
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play413031104(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos10093 = arg_432_1.actors_["10093"].transform.localPosition
				arg_432_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("10093", 2)

				for iter_435_0 = 0, arg_432_1.actors_["10093"].transform.childCount - 1 do
					local var_435_0 = arg_432_1.actors_["10093"].transform:GetChild(iter_435_0)

					if var_435_0.name == "" or not string.find(var_435_0.name, "split") then
						var_435_0.gameObject:SetActive(true)
					else
						var_435_0.gameObject:SetActive(false)
					end
				end
			end

			local var_435_1 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_1 then
				arg_432_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_432_1.time_ - 0) / var_435_1)
			end

			if arg_432_1.time_ >= 0 + var_435_1 and arg_432_1.time_ < 0 + var_435_1 + arg_435_0 then
				arg_432_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_435_2 = arg_432_1.actors_["10022"].transform

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos10022 = var_435_2.localPosition
				var_435_2.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("10022", 4)

				for iter_435_1 = 0, var_435_2.childCount - 1 do
					local var_435_3 = var_435_2:GetChild(iter_435_1)

					if var_435_3.name == "" or not string.find(var_435_3.name, "split") then
						var_435_3.gameObject:SetActive(true)
					else
						var_435_3.gameObject:SetActive(false)
					end
				end
			end

			local var_435_4 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_4 then
				var_435_2.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_432_1.time_ - 0) / var_435_4)
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 then
				var_435_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_435_5 = arg_432_1.actors_["10093"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_5) and arg_432_1.var_.actorSpriteComps10093 == nil then
				arg_432_1.var_.actorSpriteComps10093 = var_435_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_6 = 2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_6 and not isNil(var_435_5) then
				if arg_432_1.var_.actorSpriteComps10093 then
					for iter_435_2, iter_435_3 in pairs(arg_432_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_435_3 then
							if arg_432_1.isInRecall_ then
								iter_435_3.color = Color.New(Mathf.Lerp(iter_435_3.color.r, arg_432_1.hightColor1.r, (arg_432_1.time_ - 0) / var_435_6), Mathf.Lerp(iter_435_3.color.g, arg_432_1.hightColor1.g, (arg_432_1.time_ - 0) / var_435_6), (Mathf.Lerp(iter_435_3.color.b, arg_432_1.hightColor1.b, (arg_432_1.time_ - 0) / var_435_6)))
							else
								local var_435_7 = Mathf.Lerp(iter_435_3.color.r, 1, (arg_432_1.time_ - 0) / var_435_6)

								iter_435_3.color = Color.New(var_435_7, var_435_7, var_435_7)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_6 and arg_432_1.time_ < 0 + var_435_6 + arg_435_0 and not isNil(var_435_5) and arg_432_1.var_.actorSpriteComps10093 then
				for iter_435_4, iter_435_5 in pairs(arg_432_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_435_5 then
						iter_435_5.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_432_1.var_.actorSpriteComps10093 = nil
			end

			local var_435_8 = arg_432_1.actors_["10022"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_8) and arg_432_1.var_.actorSpriteComps10022 == nil then
				arg_432_1.var_.actorSpriteComps10022 = var_435_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_9 = 2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_9 and not isNil(var_435_8) then
				if arg_432_1.var_.actorSpriteComps10022 then
					for iter_435_6, iter_435_7 in pairs(arg_432_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_435_7 then
							if arg_432_1.isInRecall_ then
								iter_435_7.color = Color.New(Mathf.Lerp(iter_435_7.color.r, arg_432_1.hightColor2.r, (arg_432_1.time_ - 0) / var_435_9), Mathf.Lerp(iter_435_7.color.g, arg_432_1.hightColor2.g, (arg_432_1.time_ - 0) / var_435_9), (Mathf.Lerp(iter_435_7.color.b, arg_432_1.hightColor2.b, (arg_432_1.time_ - 0) / var_435_9)))
							else
								local var_435_10 = Mathf.Lerp(iter_435_7.color.r, 0.5, (arg_432_1.time_ - 0) / var_435_9)

								iter_435_7.color = Color.New(var_435_10, var_435_10, var_435_10)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_9 and arg_432_1.time_ < 0 + var_435_9 + arg_435_0 and not isNil(var_435_8) and arg_432_1.var_.actorSpriteComps10022 then
				for iter_435_8, iter_435_9 in pairs(arg_432_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_435_9 then
						iter_435_9.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_432_1.var_.actorSpriteComps10022 = nil
			end

			local var_435_11 = 0
			local var_435_12 = 0.8

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_11 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_13 = arg_432_1:GetWordFromCfg(413031103)
				local var_435_14 = arg_432_1:FormatText(var_435_13.content)

				arg_432_1.text_.text = var_435_14

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_16 = 32 <= 0 and var_435_12 or var_435_12 * (utf8.len(var_435_14) / 32)

				if (32 <= 0 and var_435_12 or var_435_12 * (utf8.len(var_435_14) / 32)) > 0 and var_435_12 < var_435_16 then
					arg_432_1.talkMaxDuration = var_435_16

					if var_435_16 + var_435_11 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_16 + var_435_11
					end
				end

				arg_432_1.text_.text = var_435_14
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031103", "story_v_out_413031.awb") ~= 0 then
					local var_435_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031103", "story_v_out_413031.awb") / 1000

					if var_435_17 + var_435_11 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_17 + var_435_11
					end

					if var_435_13.prefab_name ~= "" and arg_432_1.actors_[var_435_13.prefab_name] ~= nil then
						local var_435_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_13.prefab_name].transform, "story_v_out_413031", "413031103", "story_v_out_413031.awb")

						arg_432_1:RecordAudio("413031103", var_435_18)
						arg_432_1:RecordAudio("413031103", var_435_18)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_413031", "413031103", "story_v_out_413031.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_413031", "413031103", "story_v_out_413031.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_19 = math.max(var_435_12, arg_432_1.talkMaxDuration)

			if var_435_11 <= arg_432_1.time_ and arg_432_1.time_ < var_435_11 + var_435_19 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_11) / var_435_19

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_11 + var_435_19 and arg_432_1.time_ < var_435_11 + var_435_19 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play413031104 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 413031104
		arg_436_1.duration_ = 11.77

		local var_436_0 = {
			zh = 7.4,
			ja = 11.766
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play413031105(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos10093 = arg_436_1.actors_["10093"].transform.localPosition
				arg_436_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("10093", 2)

				for iter_439_0 = 0, arg_436_1.actors_["10093"].transform.childCount - 1 do
					local var_439_0 = arg_436_1.actors_["10093"].transform:GetChild(iter_439_0)

					if var_439_0.name == "" or not string.find(var_439_0.name, "split") then
						var_439_0.gameObject:SetActive(true)
					else
						var_439_0.gameObject:SetActive(false)
					end
				end
			end

			local var_439_1 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_1 then
				arg_436_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_436_1.time_ - 0) / var_439_1)
			end

			if arg_436_1.time_ >= 0 + var_439_1 and arg_436_1.time_ < 0 + var_439_1 + arg_439_0 then
				arg_436_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_439_2 = arg_436_1.actors_["10022"].transform

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos10022 = var_439_2.localPosition
				var_439_2.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("10022", 4)

				for iter_439_1 = 0, var_439_2.childCount - 1 do
					local var_439_3 = var_439_2:GetChild(iter_439_1)

					if var_439_3.name == "split_8" or not string.find(var_439_3.name, "split") then
						var_439_3.gameObject:SetActive(true)
					else
						var_439_3.gameObject:SetActive(false)
					end
				end
			end

			local var_439_4 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_4 then
				var_439_2.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_436_1.time_ - 0) / var_439_4)
			end

			if arg_436_1.time_ >= 0 + var_439_4 and arg_436_1.time_ < 0 + var_439_4 + arg_439_0 then
				var_439_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_439_5 = arg_436_1.actors_["10093"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_5) and arg_436_1.var_.actorSpriteComps10093 == nil then
				arg_436_1.var_.actorSpriteComps10093 = var_439_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_6 = 2

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_6 and not isNil(var_439_5) then
				if arg_436_1.var_.actorSpriteComps10093 then
					for iter_439_2, iter_439_3 in pairs(arg_436_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_439_3 then
							if arg_436_1.isInRecall_ then
								iter_439_3.color = Color.New(Mathf.Lerp(iter_439_3.color.r, arg_436_1.hightColor2.r, (arg_436_1.time_ - 0) / var_439_6), Mathf.Lerp(iter_439_3.color.g, arg_436_1.hightColor2.g, (arg_436_1.time_ - 0) / var_439_6), (Mathf.Lerp(iter_439_3.color.b, arg_436_1.hightColor2.b, (arg_436_1.time_ - 0) / var_439_6)))
							else
								local var_439_7 = Mathf.Lerp(iter_439_3.color.r, 0.5, (arg_436_1.time_ - 0) / var_439_6)

								iter_439_3.color = Color.New(var_439_7, var_439_7, var_439_7)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= 0 + var_439_6 and arg_436_1.time_ < 0 + var_439_6 + arg_439_0 and not isNil(var_439_5) and arg_436_1.var_.actorSpriteComps10093 then
				for iter_439_4, iter_439_5 in pairs(arg_436_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_439_5 then
						iter_439_5.color = arg_436_1.isInRecall_ and (arg_436_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_436_1.var_.actorSpriteComps10093 = nil
			end

			local var_439_8 = arg_436_1.actors_["10022"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_8) and arg_436_1.var_.actorSpriteComps10022 == nil then
				arg_436_1.var_.actorSpriteComps10022 = var_439_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_9 = 2

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_9 and not isNil(var_439_8) then
				if arg_436_1.var_.actorSpriteComps10022 then
					for iter_439_6, iter_439_7 in pairs(arg_436_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_439_7 then
							if arg_436_1.isInRecall_ then
								iter_439_7.color = Color.New(Mathf.Lerp(iter_439_7.color.r, arg_436_1.hightColor1.r, (arg_436_1.time_ - 0) / var_439_9), Mathf.Lerp(iter_439_7.color.g, arg_436_1.hightColor1.g, (arg_436_1.time_ - 0) / var_439_9), (Mathf.Lerp(iter_439_7.color.b, arg_436_1.hightColor1.b, (arg_436_1.time_ - 0) / var_439_9)))
							else
								local var_439_10 = Mathf.Lerp(iter_439_7.color.r, 1, (arg_436_1.time_ - 0) / var_439_9)

								iter_439_7.color = Color.New(var_439_10, var_439_10, var_439_10)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= 0 + var_439_9 and arg_436_1.time_ < 0 + var_439_9 + arg_439_0 and not isNil(var_439_8) and arg_436_1.var_.actorSpriteComps10022 then
				for iter_439_8, iter_439_9 in pairs(arg_436_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_439_9 then
						iter_439_9.color = arg_436_1.isInRecall_ and (arg_436_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_436_1.var_.actorSpriteComps10022 = nil
			end

			local var_439_11 = 0
			local var_439_12 = 0.875

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_11 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_13 = arg_436_1:GetWordFromCfg(413031104)
				local var_439_14 = arg_436_1:FormatText(var_439_13.content)

				arg_436_1.text_.text = var_439_14

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_16 = 35 <= 0 and var_439_12 or var_439_12 * (utf8.len(var_439_14) / 35)

				if (35 <= 0 and var_439_12 or var_439_12 * (utf8.len(var_439_14) / 35)) > 0 and var_439_12 < var_439_16 then
					arg_436_1.talkMaxDuration = var_439_16

					if var_439_16 + var_439_11 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_16 + var_439_11
					end
				end

				arg_436_1.text_.text = var_439_14
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031104", "story_v_out_413031.awb") ~= 0 then
					local var_439_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031104", "story_v_out_413031.awb") / 1000

					if var_439_17 + var_439_11 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_17 + var_439_11
					end

					if var_439_13.prefab_name ~= "" and arg_436_1.actors_[var_439_13.prefab_name] ~= nil then
						local var_439_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_13.prefab_name].transform, "story_v_out_413031", "413031104", "story_v_out_413031.awb")

						arg_436_1:RecordAudio("413031104", var_439_18)
						arg_436_1:RecordAudio("413031104", var_439_18)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_413031", "413031104", "story_v_out_413031.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_413031", "413031104", "story_v_out_413031.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_19 = math.max(var_439_12, arg_436_1.talkMaxDuration)

			if var_439_11 <= arg_436_1.time_ and arg_436_1.time_ < var_439_11 + var_439_19 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_11) / var_439_19

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_11 + var_439_19 and arg_436_1.time_ < var_439_11 + var_439_19 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play413031105 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 413031105
		arg_440_1.duration_ = 8.1

		local var_440_0 = {
			zh = 5.433,
			ja = 8.1
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
				arg_440_0:Play413031106(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos10093 = arg_440_1.actors_["10093"].transform.localPosition
				arg_440_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10093", 2)

				for iter_443_0 = 0, arg_440_1.actors_["10093"].transform.childCount - 1 do
					local var_443_0 = arg_440_1.actors_["10093"].transform:GetChild(iter_443_0)

					if var_443_0.name == "split_6" or not string.find(var_443_0.name, "split") then
						var_443_0.gameObject:SetActive(true)
					else
						var_443_0.gameObject:SetActive(false)
					end
				end
			end

			local var_443_1 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_1 then
				arg_440_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_440_1.time_ - 0) / var_443_1)
			end

			if arg_440_1.time_ >= 0 + var_443_1 and arg_440_1.time_ < 0 + var_443_1 + arg_443_0 then
				arg_440_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_443_2 = arg_440_1.actors_["10022"].transform

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos10022 = var_443_2.localPosition
				var_443_2.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10022", 4)

				for iter_443_1 = 0, var_443_2.childCount - 1 do
					local var_443_3 = var_443_2:GetChild(iter_443_1)

					if var_443_3.name == "" or not string.find(var_443_3.name, "split") then
						var_443_3.gameObject:SetActive(true)
					else
						var_443_3.gameObject:SetActive(false)
					end
				end
			end

			local var_443_4 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_4 then
				var_443_2.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_440_1.time_ - 0) / var_443_4)
			end

			if arg_440_1.time_ >= 0 + var_443_4 and arg_440_1.time_ < 0 + var_443_4 + arg_443_0 then
				var_443_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_443_5 = arg_440_1.actors_["10093"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_5) and arg_440_1.var_.actorSpriteComps10093 == nil then
				arg_440_1.var_.actorSpriteComps10093 = var_443_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_6 = 2

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_6 and not isNil(var_443_5) then
				if arg_440_1.var_.actorSpriteComps10093 then
					for iter_443_2, iter_443_3 in pairs(arg_440_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_443_3 then
							if arg_440_1.isInRecall_ then
								iter_443_3.color = Color.New(Mathf.Lerp(iter_443_3.color.r, arg_440_1.hightColor1.r, (arg_440_1.time_ - 0) / var_443_6), Mathf.Lerp(iter_443_3.color.g, arg_440_1.hightColor1.g, (arg_440_1.time_ - 0) / var_443_6), (Mathf.Lerp(iter_443_3.color.b, arg_440_1.hightColor1.b, (arg_440_1.time_ - 0) / var_443_6)))
							else
								local var_443_7 = Mathf.Lerp(iter_443_3.color.r, 1, (arg_440_1.time_ - 0) / var_443_6)

								iter_443_3.color = Color.New(var_443_7, var_443_7, var_443_7)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= 0 + var_443_6 and arg_440_1.time_ < 0 + var_443_6 + arg_443_0 and not isNil(var_443_5) and arg_440_1.var_.actorSpriteComps10093 then
				for iter_443_4, iter_443_5 in pairs(arg_440_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_443_5 then
						iter_443_5.color = arg_440_1.isInRecall_ and (arg_440_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_440_1.var_.actorSpriteComps10093 = nil
			end

			local var_443_8 = arg_440_1.actors_["10022"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_8) and arg_440_1.var_.actorSpriteComps10022 == nil then
				arg_440_1.var_.actorSpriteComps10022 = var_443_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_9 = 2

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_9 and not isNil(var_443_8) then
				if arg_440_1.var_.actorSpriteComps10022 then
					for iter_443_6, iter_443_7 in pairs(arg_440_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_443_7 then
							if arg_440_1.isInRecall_ then
								iter_443_7.color = Color.New(Mathf.Lerp(iter_443_7.color.r, arg_440_1.hightColor2.r, (arg_440_1.time_ - 0) / var_443_9), Mathf.Lerp(iter_443_7.color.g, arg_440_1.hightColor2.g, (arg_440_1.time_ - 0) / var_443_9), (Mathf.Lerp(iter_443_7.color.b, arg_440_1.hightColor2.b, (arg_440_1.time_ - 0) / var_443_9)))
							else
								local var_443_10 = Mathf.Lerp(iter_443_7.color.r, 0.5, (arg_440_1.time_ - 0) / var_443_9)

								iter_443_7.color = Color.New(var_443_10, var_443_10, var_443_10)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= 0 + var_443_9 and arg_440_1.time_ < 0 + var_443_9 + arg_443_0 and not isNil(var_443_8) and arg_440_1.var_.actorSpriteComps10022 then
				for iter_443_8, iter_443_9 in pairs(arg_440_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_443_9 then
						iter_443_9.color = arg_440_1.isInRecall_ and (arg_440_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_440_1.var_.actorSpriteComps10022 = nil
			end

			local var_443_11 = 0
			local var_443_12 = 0.6

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_11 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_13 = arg_440_1:GetWordFromCfg(413031105)
				local var_443_14 = arg_440_1:FormatText(var_443_13.content)

				arg_440_1.text_.text = var_443_14

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_16 = 24 <= 0 and var_443_12 or var_443_12 * (utf8.len(var_443_14) / 24)

				if (24 <= 0 and var_443_12 or var_443_12 * (utf8.len(var_443_14) / 24)) > 0 and var_443_12 < var_443_16 then
					arg_440_1.talkMaxDuration = var_443_16

					if var_443_16 + var_443_11 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_16 + var_443_11
					end
				end

				arg_440_1.text_.text = var_443_14
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031105", "story_v_out_413031.awb") ~= 0 then
					local var_443_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031105", "story_v_out_413031.awb") / 1000

					if var_443_17 + var_443_11 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_17 + var_443_11
					end

					if var_443_13.prefab_name ~= "" and arg_440_1.actors_[var_443_13.prefab_name] ~= nil then
						local var_443_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_13.prefab_name].transform, "story_v_out_413031", "413031105", "story_v_out_413031.awb")

						arg_440_1:RecordAudio("413031105", var_443_18)
						arg_440_1:RecordAudio("413031105", var_443_18)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_413031", "413031105", "story_v_out_413031.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_413031", "413031105", "story_v_out_413031.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_19 = math.max(var_443_12, arg_440_1.talkMaxDuration)

			if var_443_11 <= arg_440_1.time_ and arg_440_1.time_ < var_443_11 + var_443_19 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_11) / var_443_19

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_11 + var_443_19 and arg_440_1.time_ < var_443_11 + var_443_19 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
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
				actorName = "10022",
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
	Play413031106 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 413031106
		arg_444_1.duration_ = 11.67

		local var_444_0 = {
			zh = 8.733,
			ja = 11.666
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
				arg_444_0:Play413031107(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos10093 = arg_444_1.actors_["10093"].transform.localPosition
				arg_444_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_444_1:CheckSpriteTmpPos("10093", 2)

				for iter_447_0 = 0, arg_444_1.actors_["10093"].transform.childCount - 1 do
					local var_447_0 = arg_444_1.actors_["10093"].transform:GetChild(iter_447_0)

					if var_447_0.name == "" or not string.find(var_447_0.name, "split") then
						var_447_0.gameObject:SetActive(true)
					else
						var_447_0.gameObject:SetActive(false)
					end
				end
			end

			local var_447_1 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_1 then
				arg_444_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_444_1.time_ - 0) / var_447_1)
			end

			if arg_444_1.time_ >= 0 + var_447_1 and arg_444_1.time_ < 0 + var_447_1 + arg_447_0 then
				arg_444_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_447_2 = arg_444_1.actors_["10022"].transform

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos10022 = var_447_2.localPosition
				var_447_2.localScale = Vector3.New(1, 1, 1)

				arg_444_1:CheckSpriteTmpPos("10022", 4)

				for iter_447_1 = 0, var_447_2.childCount - 1 do
					local var_447_3 = var_447_2:GetChild(iter_447_1)

					if var_447_3.name == "split_3" or not string.find(var_447_3.name, "split") then
						var_447_3.gameObject:SetActive(true)
					else
						var_447_3.gameObject:SetActive(false)
					end
				end
			end

			local var_447_4 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_4 then
				var_447_2.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_444_1.time_ - 0) / var_447_4)
			end

			if arg_444_1.time_ >= 0 + var_447_4 and arg_444_1.time_ < 0 + var_447_4 + arg_447_0 then
				var_447_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_447_5 = arg_444_1.actors_["10093"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_5) and arg_444_1.var_.actorSpriteComps10093 == nil then
				arg_444_1.var_.actorSpriteComps10093 = var_447_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_6 = 2

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_6 and not isNil(var_447_5) then
				if arg_444_1.var_.actorSpriteComps10093 then
					for iter_447_2, iter_447_3 in pairs(arg_444_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_447_3 then
							if arg_444_1.isInRecall_ then
								iter_447_3.color = Color.New(Mathf.Lerp(iter_447_3.color.r, arg_444_1.hightColor2.r, (arg_444_1.time_ - 0) / var_447_6), Mathf.Lerp(iter_447_3.color.g, arg_444_1.hightColor2.g, (arg_444_1.time_ - 0) / var_447_6), (Mathf.Lerp(iter_447_3.color.b, arg_444_1.hightColor2.b, (arg_444_1.time_ - 0) / var_447_6)))
							else
								local var_447_7 = Mathf.Lerp(iter_447_3.color.r, 0.5, (arg_444_1.time_ - 0) / var_447_6)

								iter_447_3.color = Color.New(var_447_7, var_447_7, var_447_7)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= 0 + var_447_6 and arg_444_1.time_ < 0 + var_447_6 + arg_447_0 and not isNil(var_447_5) and arg_444_1.var_.actorSpriteComps10093 then
				for iter_447_4, iter_447_5 in pairs(arg_444_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_447_5 then
						iter_447_5.color = arg_444_1.isInRecall_ and (arg_444_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_444_1.var_.actorSpriteComps10093 = nil
			end

			local var_447_8 = arg_444_1.actors_["10022"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_8) and arg_444_1.var_.actorSpriteComps10022 == nil then
				arg_444_1.var_.actorSpriteComps10022 = var_447_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_9 = 2

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_9 and not isNil(var_447_8) then
				if arg_444_1.var_.actorSpriteComps10022 then
					for iter_447_6, iter_447_7 in pairs(arg_444_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_447_7 then
							if arg_444_1.isInRecall_ then
								iter_447_7.color = Color.New(Mathf.Lerp(iter_447_7.color.r, arg_444_1.hightColor1.r, (arg_444_1.time_ - 0) / var_447_9), Mathf.Lerp(iter_447_7.color.g, arg_444_1.hightColor1.g, (arg_444_1.time_ - 0) / var_447_9), (Mathf.Lerp(iter_447_7.color.b, arg_444_1.hightColor1.b, (arg_444_1.time_ - 0) / var_447_9)))
							else
								local var_447_10 = Mathf.Lerp(iter_447_7.color.r, 1, (arg_444_1.time_ - 0) / var_447_9)

								iter_447_7.color = Color.New(var_447_10, var_447_10, var_447_10)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= 0 + var_447_9 and arg_444_1.time_ < 0 + var_447_9 + arg_447_0 and not isNil(var_447_8) and arg_444_1.var_.actorSpriteComps10022 then
				for iter_447_8, iter_447_9 in pairs(arg_444_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_447_9 then
						iter_447_9.color = arg_444_1.isInRecall_ and (arg_444_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_444_1.var_.actorSpriteComps10022 = nil
			end

			local var_447_11 = 0
			local var_447_12 = 0.975

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_11 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_13 = arg_444_1:GetWordFromCfg(413031106)
				local var_447_14 = arg_444_1:FormatText(var_447_13.content)

				arg_444_1.text_.text = var_447_14

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_16 = 39 <= 0 and var_447_12 or var_447_12 * (utf8.len(var_447_14) / 39)

				if (39 <= 0 and var_447_12 or var_447_12 * (utf8.len(var_447_14) / 39)) > 0 and var_447_12 < var_447_16 then
					arg_444_1.talkMaxDuration = var_447_16

					if var_447_16 + var_447_11 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_16 + var_447_11
					end
				end

				arg_444_1.text_.text = var_447_14
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031106", "story_v_out_413031.awb") ~= 0 then
					local var_447_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031106", "story_v_out_413031.awb") / 1000

					if var_447_17 + var_447_11 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_17 + var_447_11
					end

					if var_447_13.prefab_name ~= "" and arg_444_1.actors_[var_447_13.prefab_name] ~= nil then
						local var_447_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_13.prefab_name].transform, "story_v_out_413031", "413031106", "story_v_out_413031.awb")

						arg_444_1:RecordAudio("413031106", var_447_18)
						arg_444_1:RecordAudio("413031106", var_447_18)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_413031", "413031106", "story_v_out_413031.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_413031", "413031106", "story_v_out_413031.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_19 = math.max(var_447_12, arg_444_1.talkMaxDuration)

			if var_447_11 <= arg_444_1.time_ and arg_444_1.time_ < var_447_11 + var_447_19 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_11) / var_447_19

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_11 + var_447_19 and arg_444_1.time_ < var_447_11 + var_447_19 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
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
				actorName = "10022",
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
	Play413031107 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 413031107
		arg_448_1.duration_ = 5.4

		local var_448_0 = {
			zh = 4.733,
			ja = 5.4
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
				arg_448_0:Play413031108(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["10093"]) and arg_448_1.var_.actorSpriteComps10093 == nil then
				arg_448_1.var_.actorSpriteComps10093 = arg_448_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_0 = 2

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["10093"]) then
				if arg_448_1.var_.actorSpriteComps10093 then
					for iter_451_0, iter_451_1 in pairs(arg_448_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_451_1 then
							if arg_448_1.isInRecall_ then
								iter_451_1.color = Color.New(Mathf.Lerp(iter_451_1.color.r, arg_448_1.hightColor1.r, (arg_448_1.time_ - 0) / var_451_0), Mathf.Lerp(iter_451_1.color.g, arg_448_1.hightColor1.g, (arg_448_1.time_ - 0) / var_451_0), (Mathf.Lerp(iter_451_1.color.b, arg_448_1.hightColor1.b, (arg_448_1.time_ - 0) / var_451_0)))
							else
								local var_451_1 = Mathf.Lerp(iter_451_1.color.r, 1, (arg_448_1.time_ - 0) / var_451_0)

								iter_451_1.color = Color.New(var_451_1, var_451_1, var_451_1)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["10093"]) and arg_448_1.var_.actorSpriteComps10093 then
				for iter_451_2, iter_451_3 in pairs(arg_448_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_451_3 then
						iter_451_3.color = arg_448_1.isInRecall_ and (arg_448_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_448_1.var_.actorSpriteComps10093 = nil
			end

			local var_451_2 = arg_448_1.actors_["10022"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_2) and arg_448_1.var_.actorSpriteComps10022 == nil then
				arg_448_1.var_.actorSpriteComps10022 = var_451_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_3 = 2

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_3 and not isNil(var_451_2) then
				if arg_448_1.var_.actorSpriteComps10022 then
					for iter_451_4, iter_451_5 in pairs(arg_448_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_451_5 then
							if arg_448_1.isInRecall_ then
								iter_451_5.color = Color.New(Mathf.Lerp(iter_451_5.color.r, arg_448_1.hightColor2.r, (arg_448_1.time_ - 0) / var_451_3), Mathf.Lerp(iter_451_5.color.g, arg_448_1.hightColor2.g, (arg_448_1.time_ - 0) / var_451_3), (Mathf.Lerp(iter_451_5.color.b, arg_448_1.hightColor2.b, (arg_448_1.time_ - 0) / var_451_3)))
							else
								local var_451_4 = Mathf.Lerp(iter_451_5.color.r, 0.5, (arg_448_1.time_ - 0) / var_451_3)

								iter_451_5.color = Color.New(var_451_4, var_451_4, var_451_4)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= 0 + var_451_3 and arg_448_1.time_ < 0 + var_451_3 + arg_451_0 and not isNil(var_451_2) and arg_448_1.var_.actorSpriteComps10022 then
				for iter_451_6, iter_451_7 in pairs(arg_448_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_451_7 then
						iter_451_7.color = arg_448_1.isInRecall_ and (arg_448_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_448_1.var_.actorSpriteComps10022 = nil
			end

			local var_451_5 = 0
			local var_451_6 = 0.6

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_5 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_7 = arg_448_1:GetWordFromCfg(413031107)
				local var_451_8 = arg_448_1:FormatText(var_451_7.content)

				arg_448_1.text_.text = var_451_8

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_10 = 24 <= 0 and var_451_6 or var_451_6 * (utf8.len(var_451_8) / 24)

				if (24 <= 0 and var_451_6 or var_451_6 * (utf8.len(var_451_8) / 24)) > 0 and var_451_6 < var_451_10 then
					arg_448_1.talkMaxDuration = var_451_10

					if var_451_10 + var_451_5 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_10 + var_451_5
					end
				end

				arg_448_1.text_.text = var_451_8
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031107", "story_v_out_413031.awb") ~= 0 then
					local var_451_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031107", "story_v_out_413031.awb") / 1000

					if var_451_11 + var_451_5 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_11 + var_451_5
					end

					if var_451_7.prefab_name ~= "" and arg_448_1.actors_[var_451_7.prefab_name] ~= nil then
						local var_451_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_7.prefab_name].transform, "story_v_out_413031", "413031107", "story_v_out_413031.awb")

						arg_448_1:RecordAudio("413031107", var_451_12)
						arg_448_1:RecordAudio("413031107", var_451_12)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_413031", "413031107", "story_v_out_413031.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_413031", "413031107", "story_v_out_413031.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_13 = math.max(var_451_6, arg_448_1.talkMaxDuration)

			if var_451_5 <= arg_448_1.time_ and arg_448_1.time_ < var_451_5 + var_451_13 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_5) / var_451_13

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_5 + var_451_13 and arg_448_1.time_ < var_451_5 + var_451_13 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play413031108 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 413031108
		arg_452_1.duration_ = 10.23

		local var_452_0 = {
			zh = 7.5,
			ja = 10.233
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play413031109(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0.95

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_1 = arg_452_1:GetWordFromCfg(413031108)
				local var_455_2 = arg_452_1:FormatText(var_455_1.content)

				arg_452_1.text_.text = var_455_2

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_4 = 38 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_2) / 38)

				if (38 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_2) / 38)) > 0 and var_455_0 < var_455_4 then
					arg_452_1.talkMaxDuration = var_455_4

					if var_455_4 + 0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_4 + 0
					end
				end

				arg_452_1.text_.text = var_455_2
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031108", "story_v_out_413031.awb") ~= 0 then
					local var_455_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031108", "story_v_out_413031.awb") / 1000

					if var_455_5 + 0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_5 + 0
					end

					if var_455_1.prefab_name ~= "" and arg_452_1.actors_[var_455_1.prefab_name] ~= nil then
						local var_455_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_1.prefab_name].transform, "story_v_out_413031", "413031108", "story_v_out_413031.awb")

						arg_452_1:RecordAudio("413031108", var_455_6)
						arg_452_1:RecordAudio("413031108", var_455_6)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_413031", "413031108", "story_v_out_413031.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_413031", "413031108", "story_v_out_413031.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_7 = math.max(var_455_0, arg_452_1.talkMaxDuration)

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_7 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - 0) / var_455_7

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= 0 + var_455_7 and arg_452_1.time_ < 0 + var_455_7 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play413031109 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 413031109
		arg_456_1.duration_ = 10.4

		local var_456_0 = {
			zh = 6.666,
			ja = 10.4
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
				arg_456_0:Play413031110(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0.825

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_1 = arg_456_1:GetWordFromCfg(413031109)
				local var_459_2 = arg_456_1:FormatText(var_459_1.content)

				arg_456_1.text_.text = var_459_2

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_4 = 33 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_2) / 33)

				if (33 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_2) / 33)) > 0 and var_459_0 < var_459_4 then
					arg_456_1.talkMaxDuration = var_459_4

					if var_459_4 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_4 + 0
					end
				end

				arg_456_1.text_.text = var_459_2
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031109", "story_v_out_413031.awb") ~= 0 then
					local var_459_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031109", "story_v_out_413031.awb") / 1000

					if var_459_5 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_5 + 0
					end

					if var_459_1.prefab_name ~= "" and arg_456_1.actors_[var_459_1.prefab_name] ~= nil then
						local var_459_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_1.prefab_name].transform, "story_v_out_413031", "413031109", "story_v_out_413031.awb")

						arg_456_1:RecordAudio("413031109", var_459_6)
						arg_456_1:RecordAudio("413031109", var_459_6)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_413031", "413031109", "story_v_out_413031.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_413031", "413031109", "story_v_out_413031.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_7 = math.max(var_459_0, arg_456_1.talkMaxDuration)

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_7 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - 0) / var_459_7

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= 0 + var_459_7 and arg_456_1.time_ < 0 + var_459_7 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play413031110 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 413031110
		arg_460_1.duration_ = 8.83

		local var_460_0 = {
			zh = 4.6,
			ja = 8.833
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
				arg_460_0:Play413031111(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0.75

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_1 = arg_460_1:GetWordFromCfg(413031110)
				local var_463_2 = arg_460_1:FormatText(var_463_1.content)

				arg_460_1.text_.text = var_463_2

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_4 = 30 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_2) / 30)

				if (30 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_2) / 30)) > 0 and var_463_0 < var_463_4 then
					arg_460_1.talkMaxDuration = var_463_4

					if var_463_4 + 0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_4 + 0
					end
				end

				arg_460_1.text_.text = var_463_2
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031110", "story_v_out_413031.awb") ~= 0 then
					local var_463_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031110", "story_v_out_413031.awb") / 1000

					if var_463_5 + 0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_5 + 0
					end

					if var_463_1.prefab_name ~= "" and arg_460_1.actors_[var_463_1.prefab_name] ~= nil then
						local var_463_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_1.prefab_name].transform, "story_v_out_413031", "413031110", "story_v_out_413031.awb")

						arg_460_1:RecordAudio("413031110", var_463_6)
						arg_460_1:RecordAudio("413031110", var_463_6)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_413031", "413031110", "story_v_out_413031.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_413031", "413031110", "story_v_out_413031.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_7 = math.max(var_463_0, arg_460_1.talkMaxDuration)

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_7 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - 0) / var_463_7

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= 0 + var_463_7 and arg_460_1.time_ < 0 + var_463_7 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play413031111 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 413031111
		arg_464_1.duration_ = 4.3

		local var_464_0 = {
			zh = 2.166,
			ja = 4.3
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play413031112(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos10093 = arg_464_1.actors_["10093"].transform.localPosition
				arg_464_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("10093", 2)

				for iter_467_0 = 0, arg_464_1.actors_["10093"].transform.childCount - 1 do
					local var_467_0 = arg_464_1.actors_["10093"].transform:GetChild(iter_467_0)

					if var_467_0.name == "" or not string.find(var_467_0.name, "split") then
						var_467_0.gameObject:SetActive(true)
					else
						var_467_0.gameObject:SetActive(false)
					end
				end
			end

			local var_467_1 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_1 then
				arg_464_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_464_1.time_ - 0) / var_467_1)
			end

			if arg_464_1.time_ >= 0 + var_467_1 and arg_464_1.time_ < 0 + var_467_1 + arg_467_0 then
				arg_464_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_467_2 = arg_464_1.actors_["10022"].transform

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos10022 = var_467_2.localPosition
				var_467_2.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("10022", 4)

				for iter_467_1 = 0, var_467_2.childCount - 1 do
					local var_467_3 = var_467_2:GetChild(iter_467_1)

					if var_467_3.name == "split_3" or not string.find(var_467_3.name, "split") then
						var_467_3.gameObject:SetActive(true)
					else
						var_467_3.gameObject:SetActive(false)
					end
				end
			end

			local var_467_4 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_4 then
				var_467_2.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_464_1.time_ - 0) / var_467_4)
			end

			if arg_464_1.time_ >= 0 + var_467_4 and arg_464_1.time_ < 0 + var_467_4 + arg_467_0 then
				var_467_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_467_5 = arg_464_1.actors_["10093"]

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(var_467_5) and arg_464_1.var_.actorSpriteComps10093 == nil then
				arg_464_1.var_.actorSpriteComps10093 = var_467_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_6 = 2

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_6 and not isNil(var_467_5) then
				if arg_464_1.var_.actorSpriteComps10093 then
					for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_467_3 then
							if arg_464_1.isInRecall_ then
								iter_467_3.color = Color.New(Mathf.Lerp(iter_467_3.color.r, arg_464_1.hightColor2.r, (arg_464_1.time_ - 0) / var_467_6), Mathf.Lerp(iter_467_3.color.g, arg_464_1.hightColor2.g, (arg_464_1.time_ - 0) / var_467_6), (Mathf.Lerp(iter_467_3.color.b, arg_464_1.hightColor2.b, (arg_464_1.time_ - 0) / var_467_6)))
							else
								local var_467_7 = Mathf.Lerp(iter_467_3.color.r, 0.5, (arg_464_1.time_ - 0) / var_467_6)

								iter_467_3.color = Color.New(var_467_7, var_467_7, var_467_7)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= 0 + var_467_6 and arg_464_1.time_ < 0 + var_467_6 + arg_467_0 and not isNil(var_467_5) and arg_464_1.var_.actorSpriteComps10093 then
				for iter_467_4, iter_467_5 in pairs(arg_464_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_467_5 then
						iter_467_5.color = arg_464_1.isInRecall_ and (arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_464_1.var_.actorSpriteComps10093 = nil
			end

			local var_467_8 = arg_464_1.actors_["10022"]

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(var_467_8) and arg_464_1.var_.actorSpriteComps10022 == nil then
				arg_464_1.var_.actorSpriteComps10022 = var_467_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_9 = 2

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_9 and not isNil(var_467_8) then
				if arg_464_1.var_.actorSpriteComps10022 then
					for iter_467_6, iter_467_7 in pairs(arg_464_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_467_7 then
							if arg_464_1.isInRecall_ then
								iter_467_7.color = Color.New(Mathf.Lerp(iter_467_7.color.r, arg_464_1.hightColor1.r, (arg_464_1.time_ - 0) / var_467_9), Mathf.Lerp(iter_467_7.color.g, arg_464_1.hightColor1.g, (arg_464_1.time_ - 0) / var_467_9), (Mathf.Lerp(iter_467_7.color.b, arg_464_1.hightColor1.b, (arg_464_1.time_ - 0) / var_467_9)))
							else
								local var_467_10 = Mathf.Lerp(iter_467_7.color.r, 1, (arg_464_1.time_ - 0) / var_467_9)

								iter_467_7.color = Color.New(var_467_10, var_467_10, var_467_10)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= 0 + var_467_9 and arg_464_1.time_ < 0 + var_467_9 + arg_467_0 and not isNil(var_467_8) and arg_464_1.var_.actorSpriteComps10022 then
				for iter_467_8, iter_467_9 in pairs(arg_464_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_467_9 then
						iter_467_9.color = arg_464_1.isInRecall_ and (arg_464_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_464_1.var_.actorSpriteComps10022 = nil
			end

			local var_467_11 = 0
			local var_467_12 = 0.375

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_11 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_13 = arg_464_1:GetWordFromCfg(413031111)
				local var_467_14 = arg_464_1:FormatText(var_467_13.content)

				arg_464_1.text_.text = var_467_14

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_16 = 15 <= 0 and var_467_12 or var_467_12 * (utf8.len(var_467_14) / 15)

				if (15 <= 0 and var_467_12 or var_467_12 * (utf8.len(var_467_14) / 15)) > 0 and var_467_12 < var_467_16 then
					arg_464_1.talkMaxDuration = var_467_16

					if var_467_16 + var_467_11 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_16 + var_467_11
					end
				end

				arg_464_1.text_.text = var_467_14
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031111", "story_v_out_413031.awb") ~= 0 then
					local var_467_17 = manager.audio:GetVoiceLength("story_v_out_413031", "413031111", "story_v_out_413031.awb") / 1000

					if var_467_17 + var_467_11 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_17 + var_467_11
					end

					if var_467_13.prefab_name ~= "" and arg_464_1.actors_[var_467_13.prefab_name] ~= nil then
						local var_467_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_13.prefab_name].transform, "story_v_out_413031", "413031111", "story_v_out_413031.awb")

						arg_464_1:RecordAudio("413031111", var_467_18)
						arg_464_1:RecordAudio("413031111", var_467_18)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_413031", "413031111", "story_v_out_413031.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_413031", "413031111", "story_v_out_413031.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_19 = math.max(var_467_12, arg_464_1.talkMaxDuration)

			if var_467_11 <= arg_464_1.time_ and arg_464_1.time_ < var_467_11 + var_467_19 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_11) / var_467_19

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_11 + var_467_19 and arg_464_1.time_ < var_467_11 + var_467_19 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play413031112 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 413031112
		arg_468_1.duration_ = 9

		local var_468_0 = {
			zh = 4.366,
			ja = 9
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play413031113(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(arg_468_1.actors_["10093"]) and arg_468_1.var_.actorSpriteComps10093 == nil then
				arg_468_1.var_.actorSpriteComps10093 = arg_468_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_471_0 = 2

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 and not isNil(arg_468_1.actors_["10093"]) then
				if arg_468_1.var_.actorSpriteComps10093 then
					for iter_471_0, iter_471_1 in pairs(arg_468_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_471_1 then
							if arg_468_1.isInRecall_ then
								iter_471_1.color = Color.New(Mathf.Lerp(iter_471_1.color.r, arg_468_1.hightColor1.r, (arg_468_1.time_ - 0) / var_471_0), Mathf.Lerp(iter_471_1.color.g, arg_468_1.hightColor1.g, (arg_468_1.time_ - 0) / var_471_0), (Mathf.Lerp(iter_471_1.color.b, arg_468_1.hightColor1.b, (arg_468_1.time_ - 0) / var_471_0)))
							else
								local var_471_1 = Mathf.Lerp(iter_471_1.color.r, 1, (arg_468_1.time_ - 0) / var_471_0)

								iter_471_1.color = Color.New(var_471_1, var_471_1, var_471_1)
							end
						end
					end
				end
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 and not isNil(arg_468_1.actors_["10093"]) and arg_468_1.var_.actorSpriteComps10093 then
				for iter_471_2, iter_471_3 in pairs(arg_468_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_471_3 then
						iter_471_3.color = arg_468_1.isInRecall_ and (arg_468_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_468_1.var_.actorSpriteComps10093 = nil
			end

			local var_471_2 = arg_468_1.actors_["10022"]

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(var_471_2) and arg_468_1.var_.actorSpriteComps10022 == nil then
				arg_468_1.var_.actorSpriteComps10022 = var_471_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_471_3 = 2

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_3 and not isNil(var_471_2) then
				if arg_468_1.var_.actorSpriteComps10022 then
					for iter_471_4, iter_471_5 in pairs(arg_468_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_471_5 then
							if arg_468_1.isInRecall_ then
								iter_471_5.color = Color.New(Mathf.Lerp(iter_471_5.color.r, arg_468_1.hightColor2.r, (arg_468_1.time_ - 0) / var_471_3), Mathf.Lerp(iter_471_5.color.g, arg_468_1.hightColor2.g, (arg_468_1.time_ - 0) / var_471_3), (Mathf.Lerp(iter_471_5.color.b, arg_468_1.hightColor2.b, (arg_468_1.time_ - 0) / var_471_3)))
							else
								local var_471_4 = Mathf.Lerp(iter_471_5.color.r, 0.5, (arg_468_1.time_ - 0) / var_471_3)

								iter_471_5.color = Color.New(var_471_4, var_471_4, var_471_4)
							end
						end
					end
				end
			end

			if arg_468_1.time_ >= 0 + var_471_3 and arg_468_1.time_ < 0 + var_471_3 + arg_471_0 and not isNil(var_471_2) and arg_468_1.var_.actorSpriteComps10022 then
				for iter_471_6, iter_471_7 in pairs(arg_468_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_471_7 then
						iter_471_7.color = arg_468_1.isInRecall_ and (arg_468_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_468_1.var_.actorSpriteComps10022 = nil
			end

			local var_471_5 = 0
			local var_471_6 = 0.625

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_5 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_7 = arg_468_1:GetWordFromCfg(413031112)
				local var_471_8 = arg_468_1:FormatText(var_471_7.content)

				arg_468_1.text_.text = var_471_8

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_10 = 25 <= 0 and var_471_6 or var_471_6 * (utf8.len(var_471_8) / 25)

				if (25 <= 0 and var_471_6 or var_471_6 * (utf8.len(var_471_8) / 25)) > 0 and var_471_6 < var_471_10 then
					arg_468_1.talkMaxDuration = var_471_10

					if var_471_10 + var_471_5 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_10 + var_471_5
					end
				end

				arg_468_1.text_.text = var_471_8
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031112", "story_v_out_413031.awb") ~= 0 then
					local var_471_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031112", "story_v_out_413031.awb") / 1000

					if var_471_11 + var_471_5 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_11 + var_471_5
					end

					if var_471_7.prefab_name ~= "" and arg_468_1.actors_[var_471_7.prefab_name] ~= nil then
						local var_471_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_7.prefab_name].transform, "story_v_out_413031", "413031112", "story_v_out_413031.awb")

						arg_468_1:RecordAudio("413031112", var_471_12)
						arg_468_1:RecordAudio("413031112", var_471_12)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_413031", "413031112", "story_v_out_413031.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_413031", "413031112", "story_v_out_413031.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_13 = math.max(var_471_6, arg_468_1.talkMaxDuration)

			if var_471_5 <= arg_468_1.time_ and arg_468_1.time_ < var_471_5 + var_471_13 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_5) / var_471_13

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_5 + var_471_13 and arg_468_1.time_ < var_471_5 + var_471_13 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play413031113 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 413031113
		arg_472_1.duration_ = 6.83

		local var_472_0 = {
			zh = 6.833,
			ja = 5.933
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
				arg_472_0:Play413031114(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.var_.moveOldPos10093 = arg_472_1.actors_["10093"].transform.localPosition
				arg_472_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_472_1:CheckSpriteTmpPos("10093", 2)

				for iter_475_0 = 0, arg_472_1.actors_["10093"].transform.childCount - 1 do
					local var_475_0 = arg_472_1.actors_["10093"].transform:GetChild(iter_475_0)

					if var_475_0.name == "split_4" or not string.find(var_475_0.name, "split") then
						var_475_0.gameObject:SetActive(true)
					else
						var_475_0.gameObject:SetActive(false)
					end
				end
			end

			local var_475_1 = 0.001

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_1 then
				arg_472_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_472_1.time_ - 0) / var_475_1)
			end

			if arg_472_1.time_ >= 0 + var_475_1 and arg_472_1.time_ < 0 + var_475_1 + arg_475_0 then
				arg_472_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_475_2 = 0
			local var_475_3 = 0.525

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_2 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_4 = arg_472_1:GetWordFromCfg(413031113)
				local var_475_5 = arg_472_1:FormatText(var_475_4.content)

				arg_472_1.text_.text = var_475_5

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_7 = 21 <= 0 and var_475_3 or var_475_3 * (utf8.len(var_475_5) / 21)

				if (21 <= 0 and var_475_3 or var_475_3 * (utf8.len(var_475_5) / 21)) > 0 and var_475_3 < var_475_7 then
					arg_472_1.talkMaxDuration = var_475_7

					if var_475_7 + var_475_2 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_2
					end
				end

				arg_472_1.text_.text = var_475_5
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031113", "story_v_out_413031.awb") ~= 0 then
					local var_475_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031113", "story_v_out_413031.awb") / 1000

					if var_475_8 + var_475_2 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_8 + var_475_2
					end

					if var_475_4.prefab_name ~= "" and arg_472_1.actors_[var_475_4.prefab_name] ~= nil then
						local var_475_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_4.prefab_name].transform, "story_v_out_413031", "413031113", "story_v_out_413031.awb")

						arg_472_1:RecordAudio("413031113", var_475_9)
						arg_472_1:RecordAudio("413031113", var_475_9)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_413031", "413031113", "story_v_out_413031.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_413031", "413031113", "story_v_out_413031.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_10 = math.max(var_475_3, arg_472_1.talkMaxDuration)

			if var_475_2 <= arg_472_1.time_ and arg_472_1.time_ < var_475_2 + var_475_10 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_2) / var_475_10

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_2 + var_475_10 and arg_472_1.time_ < var_475_2 + var_475_10 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
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

		arg_472_1:InitPlayNodeList()
	end,
	Play413031114 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 413031114
		arg_476_1.duration_ = 9.43

		local var_476_0 = {
			zh = 7.166,
			ja = 9.433
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play413031115(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0.825

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_1 = arg_476_1:GetWordFromCfg(413031114)
				local var_479_2 = arg_476_1:FormatText(var_479_1.content)

				arg_476_1.text_.text = var_479_2

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_4 = 33 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_2) / 33)

				if (33 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_2) / 33)) > 0 and var_479_0 < var_479_4 then
					arg_476_1.talkMaxDuration = var_479_4

					if var_479_4 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_4 + 0
					end
				end

				arg_476_1.text_.text = var_479_2
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031114", "story_v_out_413031.awb") ~= 0 then
					local var_479_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031114", "story_v_out_413031.awb") / 1000

					if var_479_5 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + 0
					end

					if var_479_1.prefab_name ~= "" and arg_476_1.actors_[var_479_1.prefab_name] ~= nil then
						local var_479_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_1.prefab_name].transform, "story_v_out_413031", "413031114", "story_v_out_413031.awb")

						arg_476_1:RecordAudio("413031114", var_479_6)
						arg_476_1:RecordAudio("413031114", var_479_6)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_out_413031", "413031114", "story_v_out_413031.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_out_413031", "413031114", "story_v_out_413031.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_7 = math.max(var_479_0, arg_476_1.talkMaxDuration)

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_7 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - 0) / var_479_7

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= 0 + var_479_7 and arg_476_1.time_ < 0 + var_479_7 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play413031115 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 413031115
		arg_480_1.duration_ = 14.23

		local var_480_0 = {
			zh = 10.733,
			ja = 14.233
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
				arg_480_0:Play413031116(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos10022 = arg_480_1.actors_["10022"].transform.localPosition
				arg_480_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_480_1:CheckSpriteTmpPos("10022", 4)

				for iter_483_0 = 0, arg_480_1.actors_["10022"].transform.childCount - 1 do
					local var_483_0 = arg_480_1.actors_["10022"].transform:GetChild(iter_483_0)

					if var_483_0.name == "split_3" or not string.find(var_483_0.name, "split") then
						var_483_0.gameObject:SetActive(true)
					else
						var_483_0.gameObject:SetActive(false)
					end
				end
			end

			local var_483_1 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_1 then
				arg_480_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_480_1.time_ - 0) / var_483_1)
			end

			if arg_480_1.time_ >= 0 + var_483_1 and arg_480_1.time_ < 0 + var_483_1 + arg_483_0 then
				arg_480_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_483_2 = arg_480_1.actors_["10093"]

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(var_483_2) and arg_480_1.var_.actorSpriteComps10093 == nil then
				arg_480_1.var_.actorSpriteComps10093 = var_483_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_3 = 2

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_3 and not isNil(var_483_2) then
				if arg_480_1.var_.actorSpriteComps10093 then
					for iter_483_1, iter_483_2 in pairs(arg_480_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_483_2 then
							if arg_480_1.isInRecall_ then
								iter_483_2.color = Color.New(Mathf.Lerp(iter_483_2.color.r, arg_480_1.hightColor2.r, (arg_480_1.time_ - 0) / var_483_3), Mathf.Lerp(iter_483_2.color.g, arg_480_1.hightColor2.g, (arg_480_1.time_ - 0) / var_483_3), (Mathf.Lerp(iter_483_2.color.b, arg_480_1.hightColor2.b, (arg_480_1.time_ - 0) / var_483_3)))
							else
								local var_483_4 = Mathf.Lerp(iter_483_2.color.r, 0.5, (arg_480_1.time_ - 0) / var_483_3)

								iter_483_2.color = Color.New(var_483_4, var_483_4, var_483_4)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= 0 + var_483_3 and arg_480_1.time_ < 0 + var_483_3 + arg_483_0 and not isNil(var_483_2) and arg_480_1.var_.actorSpriteComps10093 then
				for iter_483_3, iter_483_4 in pairs(arg_480_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_483_4 then
						iter_483_4.color = arg_480_1.isInRecall_ and (arg_480_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_480_1.var_.actorSpriteComps10093 = nil
			end

			local var_483_5 = arg_480_1.actors_["10022"]

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(var_483_5) and arg_480_1.var_.actorSpriteComps10022 == nil then
				arg_480_1.var_.actorSpriteComps10022 = var_483_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_6 = 2

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_6 and not isNil(var_483_5) then
				if arg_480_1.var_.actorSpriteComps10022 then
					for iter_483_5, iter_483_6 in pairs(arg_480_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_483_6 then
							if arg_480_1.isInRecall_ then
								iter_483_6.color = Color.New(Mathf.Lerp(iter_483_6.color.r, arg_480_1.hightColor1.r, (arg_480_1.time_ - 0) / var_483_6), Mathf.Lerp(iter_483_6.color.g, arg_480_1.hightColor1.g, (arg_480_1.time_ - 0) / var_483_6), (Mathf.Lerp(iter_483_6.color.b, arg_480_1.hightColor1.b, (arg_480_1.time_ - 0) / var_483_6)))
							else
								local var_483_7 = Mathf.Lerp(iter_483_6.color.r, 1, (arg_480_1.time_ - 0) / var_483_6)

								iter_483_6.color = Color.New(var_483_7, var_483_7, var_483_7)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= 0 + var_483_6 and arg_480_1.time_ < 0 + var_483_6 + arg_483_0 and not isNil(var_483_5) and arg_480_1.var_.actorSpriteComps10022 then
				for iter_483_7, iter_483_8 in pairs(arg_480_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_483_8 then
						iter_483_8.color = arg_480_1.isInRecall_ and (arg_480_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_480_1.var_.actorSpriteComps10022 = nil
			end

			local var_483_8 = 0
			local var_483_9 = 0.975

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_8 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_10 = arg_480_1:GetWordFromCfg(413031115)
				local var_483_11 = arg_480_1:FormatText(var_483_10.content)

				arg_480_1.text_.text = var_483_11

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_13 = 39 <= 0 and var_483_9 or var_483_9 * (utf8.len(var_483_11) / 39)

				if (39 <= 0 and var_483_9 or var_483_9 * (utf8.len(var_483_11) / 39)) > 0 and var_483_9 < var_483_13 then
					arg_480_1.talkMaxDuration = var_483_13

					if var_483_13 + var_483_8 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_13 + var_483_8
					end
				end

				arg_480_1.text_.text = var_483_11
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031115", "story_v_out_413031.awb") ~= 0 then
					local var_483_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031115", "story_v_out_413031.awb") / 1000

					if var_483_14 + var_483_8 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_14 + var_483_8
					end

					if var_483_10.prefab_name ~= "" and arg_480_1.actors_[var_483_10.prefab_name] ~= nil then
						local var_483_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_10.prefab_name].transform, "story_v_out_413031", "413031115", "story_v_out_413031.awb")

						arg_480_1:RecordAudio("413031115", var_483_15)
						arg_480_1:RecordAudio("413031115", var_483_15)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_413031", "413031115", "story_v_out_413031.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_413031", "413031115", "story_v_out_413031.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_16 = math.max(var_483_9, arg_480_1.talkMaxDuration)

			if var_483_8 <= arg_480_1.time_ and arg_480_1.time_ < var_483_8 + var_483_16 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_8) / var_483_16

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_8 + var_483_16 and arg_480_1.time_ < var_483_8 + var_483_16 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
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

		arg_480_1:InitPlayNodeList()
	end,
	Play413031116 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 413031116
		arg_484_1.duration_ = 13.6

		local var_484_0 = {
			zh = 6.133,
			ja = 13.6
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
				arg_484_0:Play413031117(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0.85

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_1 = arg_484_1:GetWordFromCfg(413031116)
				local var_487_2 = arg_484_1:FormatText(var_487_1.content)

				arg_484_1.text_.text = var_487_2

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_4 = 34 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_2) / 34)

				if (34 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_2) / 34)) > 0 and var_487_0 < var_487_4 then
					arg_484_1.talkMaxDuration = var_487_4

					if var_487_4 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_4 + 0
					end
				end

				arg_484_1.text_.text = var_487_2
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031116", "story_v_out_413031.awb") ~= 0 then
					local var_487_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031116", "story_v_out_413031.awb") / 1000

					if var_487_5 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_5 + 0
					end

					if var_487_1.prefab_name ~= "" and arg_484_1.actors_[var_487_1.prefab_name] ~= nil then
						local var_487_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_1.prefab_name].transform, "story_v_out_413031", "413031116", "story_v_out_413031.awb")

						arg_484_1:RecordAudio("413031116", var_487_6)
						arg_484_1:RecordAudio("413031116", var_487_6)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_413031", "413031116", "story_v_out_413031.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_413031", "413031116", "story_v_out_413031.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_7 = math.max(var_487_0, arg_484_1.talkMaxDuration)

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_7 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - 0) / var_487_7

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= 0 + var_487_7 and arg_484_1.time_ < 0 + var_487_7 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play413031117 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 413031117
		arg_488_1.duration_ = 7.73

		local var_488_0 = {
			zh = 4.3,
			ja = 7.733
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play413031118(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0.575

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_1 = arg_488_1:GetWordFromCfg(413031117)
				local var_491_2 = arg_488_1:FormatText(var_491_1.content)

				arg_488_1.text_.text = var_491_2

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_4 = 23 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_2) / 23)

				if (23 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_2) / 23)) > 0 and var_491_0 < var_491_4 then
					arg_488_1.talkMaxDuration = var_491_4

					if var_491_4 + 0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_4 + 0
					end
				end

				arg_488_1.text_.text = var_491_2
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031117", "story_v_out_413031.awb") ~= 0 then
					local var_491_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031117", "story_v_out_413031.awb") / 1000

					if var_491_5 + 0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_5 + 0
					end

					if var_491_1.prefab_name ~= "" and arg_488_1.actors_[var_491_1.prefab_name] ~= nil then
						local var_491_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_1.prefab_name].transform, "story_v_out_413031", "413031117", "story_v_out_413031.awb")

						arg_488_1:RecordAudio("413031117", var_491_6)
						arg_488_1:RecordAudio("413031117", var_491_6)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_413031", "413031117", "story_v_out_413031.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_413031", "413031117", "story_v_out_413031.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_7 = math.max(var_491_0, arg_488_1.talkMaxDuration)

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_7 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - 0) / var_491_7

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= 0 + var_491_7 and arg_488_1.time_ < 0 + var_491_7 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play413031118 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 413031118
		arg_492_1.duration_ = 5.9

		local var_492_0 = {
			zh = 1.999999999999,
			ja = 5.9
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
				arg_492_0:Play413031119(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos10093 = arg_492_1.actors_["10093"].transform.localPosition
				arg_492_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_492_1:CheckSpriteTmpPos("10093", 2)

				for iter_495_0 = 0, arg_492_1.actors_["10093"].transform.childCount - 1 do
					local var_495_0 = arg_492_1.actors_["10093"].transform:GetChild(iter_495_0)

					if var_495_0.name == "split_6" or not string.find(var_495_0.name, "split") then
						var_495_0.gameObject:SetActive(true)
					else
						var_495_0.gameObject:SetActive(false)
					end
				end
			end

			local var_495_1 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_1 then
				arg_492_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_492_1.time_ - 0) / var_495_1)
			end

			if arg_492_1.time_ >= 0 + var_495_1 and arg_492_1.time_ < 0 + var_495_1 + arg_495_0 then
				arg_492_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_495_2 = arg_492_1.actors_["10093"]

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(var_495_2) and arg_492_1.var_.actorSpriteComps10093 == nil then
				arg_492_1.var_.actorSpriteComps10093 = var_495_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_495_3 = 2

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_3 and not isNil(var_495_2) then
				if arg_492_1.var_.actorSpriteComps10093 then
					for iter_495_1, iter_495_2 in pairs(arg_492_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_495_2 then
							if arg_492_1.isInRecall_ then
								iter_495_2.color = Color.New(Mathf.Lerp(iter_495_2.color.r, arg_492_1.hightColor1.r, (arg_492_1.time_ - 0) / var_495_3), Mathf.Lerp(iter_495_2.color.g, arg_492_1.hightColor1.g, (arg_492_1.time_ - 0) / var_495_3), (Mathf.Lerp(iter_495_2.color.b, arg_492_1.hightColor1.b, (arg_492_1.time_ - 0) / var_495_3)))
							else
								local var_495_4 = Mathf.Lerp(iter_495_2.color.r, 1, (arg_492_1.time_ - 0) / var_495_3)

								iter_495_2.color = Color.New(var_495_4, var_495_4, var_495_4)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= 0 + var_495_3 and arg_492_1.time_ < 0 + var_495_3 + arg_495_0 and not isNil(var_495_2) and arg_492_1.var_.actorSpriteComps10093 then
				for iter_495_3, iter_495_4 in pairs(arg_492_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_495_4 then
						iter_495_4.color = arg_492_1.isInRecall_ and (arg_492_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_492_1.var_.actorSpriteComps10093 = nil
			end

			local var_495_5 = arg_492_1.actors_["10022"]

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(var_495_5) and arg_492_1.var_.actorSpriteComps10022 == nil then
				arg_492_1.var_.actorSpriteComps10022 = var_495_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_495_6 = 2

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_6 and not isNil(var_495_5) then
				if arg_492_1.var_.actorSpriteComps10022 then
					for iter_495_5, iter_495_6 in pairs(arg_492_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_495_6 then
							if arg_492_1.isInRecall_ then
								iter_495_6.color = Color.New(Mathf.Lerp(iter_495_6.color.r, arg_492_1.hightColor2.r, (arg_492_1.time_ - 0) / var_495_6), Mathf.Lerp(iter_495_6.color.g, arg_492_1.hightColor2.g, (arg_492_1.time_ - 0) / var_495_6), (Mathf.Lerp(iter_495_6.color.b, arg_492_1.hightColor2.b, (arg_492_1.time_ - 0) / var_495_6)))
							else
								local var_495_7 = Mathf.Lerp(iter_495_6.color.r, 0.5, (arg_492_1.time_ - 0) / var_495_6)

								iter_495_6.color = Color.New(var_495_7, var_495_7, var_495_7)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= 0 + var_495_6 and arg_492_1.time_ < 0 + var_495_6 + arg_495_0 and not isNil(var_495_5) and arg_492_1.var_.actorSpriteComps10022 then
				for iter_495_7, iter_495_8 in pairs(arg_492_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_495_8 then
						iter_495_8.color = arg_492_1.isInRecall_ and (arg_492_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_492_1.var_.actorSpriteComps10022 = nil
			end

			local var_495_8 = 0
			local var_495_9 = 0.225

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_8 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_10 = arg_492_1:GetWordFromCfg(413031118)
				local var_495_11 = arg_492_1:FormatText(var_495_10.content)

				arg_492_1.text_.text = var_495_11

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_13 = 9 <= 0 and var_495_9 or var_495_9 * (utf8.len(var_495_11) / 9)

				if (9 <= 0 and var_495_9 or var_495_9 * (utf8.len(var_495_11) / 9)) > 0 and var_495_9 < var_495_13 then
					arg_492_1.talkMaxDuration = var_495_13

					if var_495_13 + var_495_8 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_13 + var_495_8
					end
				end

				arg_492_1.text_.text = var_495_11
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031118", "story_v_out_413031.awb") ~= 0 then
					local var_495_14 = manager.audio:GetVoiceLength("story_v_out_413031", "413031118", "story_v_out_413031.awb") / 1000

					if var_495_14 + var_495_8 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_14 + var_495_8
					end

					if var_495_10.prefab_name ~= "" and arg_492_1.actors_[var_495_10.prefab_name] ~= nil then
						local var_495_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_10.prefab_name].transform, "story_v_out_413031", "413031118", "story_v_out_413031.awb")

						arg_492_1:RecordAudio("413031118", var_495_15)
						arg_492_1:RecordAudio("413031118", var_495_15)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_413031", "413031118", "story_v_out_413031.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_413031", "413031118", "story_v_out_413031.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_16 = math.max(var_495_9, arg_492_1.talkMaxDuration)

			if var_495_8 <= arg_492_1.time_ and arg_492_1.time_ < var_495_8 + var_495_16 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_8) / var_495_16

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_8 + var_495_16 and arg_492_1.time_ < var_495_8 + var_495_16 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
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

		arg_492_1:InitPlayNodeList()
	end,
	Play413031119 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 413031119
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play413031120(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos10093 = arg_496_1.actors_["10093"].transform.localPosition
				arg_496_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_496_1:CheckSpriteTmpPos("10093", 0)

				for iter_499_0 = 0, arg_496_1.actors_["10093"].transform.childCount - 1 do
					local var_499_0 = arg_496_1.actors_["10093"].transform:GetChild(iter_499_0)

					if var_499_0.name == "" or not string.find(var_499_0.name, "split") then
						var_499_0.gameObject:SetActive(true)
					else
						var_499_0.gameObject:SetActive(false)
					end
				end
			end

			local var_499_1 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_1 then
				arg_496_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos10093, Vector3.New(-5000, -345, -245), (arg_496_1.time_ - 0) / var_499_1)
			end

			if arg_496_1.time_ >= 0 + var_499_1 and arg_496_1.time_ < 0 + var_499_1 + arg_499_0 then
				arg_496_1.actors_["10093"].transform.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_499_2 = arg_496_1.actors_["10022"].transform

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos10022 = var_499_2.localPosition
				var_499_2.localScale = Vector3.New(1, 1, 1)

				arg_496_1:CheckSpriteTmpPos("10022", 0)

				for iter_499_1 = 0, var_499_2.childCount - 1 do
					local var_499_3 = var_499_2:GetChild(iter_499_1)

					if var_499_3.name == "" or not string.find(var_499_3.name, "split") then
						var_499_3.gameObject:SetActive(true)
					else
						var_499_3.gameObject:SetActive(false)
					end
				end
			end

			local var_499_4 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_4 then
				var_499_2.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_496_1.time_ - 0) / var_499_4)
			end

			if arg_496_1.time_ >= 0 + var_499_4 and arg_496_1.time_ < 0 + var_499_4 + arg_499_0 then
				var_499_2.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_499_5 = arg_496_1.actors_["10093"]

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(var_499_5) and arg_496_1.var_.actorSpriteComps10093 == nil then
				arg_496_1.var_.actorSpriteComps10093 = var_499_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_6 = 2

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_6 and not isNil(var_499_5) then
				if arg_496_1.var_.actorSpriteComps10093 then
					for iter_499_2, iter_499_3 in pairs(arg_496_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_499_3 then
							if arg_496_1.isInRecall_ then
								iter_499_3.color = Color.New(Mathf.Lerp(iter_499_3.color.r, arg_496_1.hightColor2.r, (arg_496_1.time_ - 0) / var_499_6), Mathf.Lerp(iter_499_3.color.g, arg_496_1.hightColor2.g, (arg_496_1.time_ - 0) / var_499_6), (Mathf.Lerp(iter_499_3.color.b, arg_496_1.hightColor2.b, (arg_496_1.time_ - 0) / var_499_6)))
							else
								local var_499_7 = Mathf.Lerp(iter_499_3.color.r, 0.5, (arg_496_1.time_ - 0) / var_499_6)

								iter_499_3.color = Color.New(var_499_7, var_499_7, var_499_7)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= 0 + var_499_6 and arg_496_1.time_ < 0 + var_499_6 + arg_499_0 and not isNil(var_499_5) and arg_496_1.var_.actorSpriteComps10093 then
				for iter_499_4, iter_499_5 in pairs(arg_496_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_499_5 then
						iter_499_5.color = arg_496_1.isInRecall_ and (arg_496_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_496_1.var_.actorSpriteComps10093 = nil
			end

			local var_499_8 = arg_496_1.actors_["10022"]

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(var_499_8) and arg_496_1.var_.actorSpriteComps10022 == nil then
				arg_496_1.var_.actorSpriteComps10022 = var_499_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_9 = 2

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_9 and not isNil(var_499_8) then
				if arg_496_1.var_.actorSpriteComps10022 then
					for iter_499_6, iter_499_7 in pairs(arg_496_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_499_7 then
							if arg_496_1.isInRecall_ then
								iter_499_7.color = Color.New(Mathf.Lerp(iter_499_7.color.r, arg_496_1.hightColor2.r, (arg_496_1.time_ - 0) / var_499_9), Mathf.Lerp(iter_499_7.color.g, arg_496_1.hightColor2.g, (arg_496_1.time_ - 0) / var_499_9), (Mathf.Lerp(iter_499_7.color.b, arg_496_1.hightColor2.b, (arg_496_1.time_ - 0) / var_499_9)))
							else
								local var_499_10 = Mathf.Lerp(iter_499_7.color.r, 0.5, (arg_496_1.time_ - 0) / var_499_9)

								iter_499_7.color = Color.New(var_499_10, var_499_10, var_499_10)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= 0 + var_499_9 and arg_496_1.time_ < 0 + var_499_9 + arg_499_0 and not isNil(var_499_8) and arg_496_1.var_.actorSpriteComps10022 then
				for iter_499_8, iter_499_9 in pairs(arg_496_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_499_9 then
						iter_499_9.color = arg_496_1.isInRecall_ and (arg_496_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_496_1.var_.actorSpriteComps10022 = nil
			end

			local var_499_11 = 0
			local var_499_12 = 1.05

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_11 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_13 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(413031119).content)

				arg_496_1.text_.text = var_499_13

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_15 = 42 <= 0 and var_499_12 or var_499_12 * (utf8.len(var_499_13) / 42)

				if (42 <= 0 and var_499_12 or var_499_12 * (utf8.len(var_499_13) / 42)) > 0 and var_499_12 < var_499_15 then
					arg_496_1.talkMaxDuration = var_499_15

					if var_499_15 + var_499_11 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_15 + var_499_11
					end
				end

				arg_496_1.text_.text = var_499_13
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_16 = math.max(var_499_12, arg_496_1.talkMaxDuration)

			if var_499_11 <= arg_496_1.time_ and arg_496_1.time_ < var_499_11 + var_499_16 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_11) / var_499_16

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_11 + var_499_16 and arg_496_1.time_ < var_499_11 + var_499_16 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
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
				actorName = "10022",
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
	Play413031120 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 413031120
		arg_500_1.duration_ = 17.53

		local var_500_0 = {
			zh = 17.5333333333333,
			ja = 14.2333333333333
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
				arg_500_0:Play413031121(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if arg_500_1.bgs_.SS1302 == nil then
				local var_503_0 = Object.Instantiate(arg_500_1.paintGo_)

				var_503_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1302")
				var_503_0.name = "SS1302"
				var_503_0.transform.parent = arg_500_1.stage_.transform
				var_503_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_500_1.bgs_.SS1302 = var_503_0
			end

			if 1.98333333333333 < arg_500_1.time_ and arg_500_1.time_ <= 1.98333333333333 + arg_503_0 then
				local var_503_1 = arg_500_1.bgs_.SS1302

				arg_500_1.bgs_.SS1302.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_503_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_503_2 = var_503_1:GetComponent("SpriteRenderer")

				if var_503_2 and var_503_2.sprite then
					local var_503_3 = 2 * (var_503_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_503_1.transform.localScale = Vector3.New(var_503_3 / var_503_2.sprite.bounds.size.y < var_503_3 * manager.ui.mainCameraCom_.aspect / var_503_2.sprite.bounds.size.x and var_503_3 * manager.ui.mainCameraCom_.aspect / var_503_2.sprite.bounds.size.x or var_503_3 / var_503_2.sprite.bounds.size.y, var_503_3 / var_503_2.sprite.bounds.size.y < var_503_3 * manager.ui.mainCameraCom_.aspect / var_503_2.sprite.bounds.size.x and var_503_3 * manager.ui.mainCameraCom_.aspect / var_503_2.sprite.bounds.size.x or var_503_3 / var_503_2.sprite.bounds.size.y, 0)
				end

				for iter_503_0, iter_503_1 in pairs(arg_500_1.bgs_) do
					if iter_503_0 ~= "SS1302" then
						iter_503_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_503_4 = 0

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_4 + arg_503_0 then
				arg_500_1.mask_.enabled = true
				arg_500_1.mask_.raycastTarget = true

				arg_500_1:SetGaussion(false)
			end

			local var_503_5 = 2

			if var_503_4 <= arg_500_1.time_ and arg_500_1.time_ < var_503_4 + var_503_5 then
				local var_503_6 = Color.New(0, 0, 0)

				var_503_6.a = Mathf.Lerp(0, 1, (arg_500_1.time_ - var_503_4) / var_503_5)
				arg_500_1.mask_.color = var_503_6
			end

			if arg_500_1.time_ >= var_503_4 + var_503_5 and arg_500_1.time_ < var_503_4 + var_503_5 + arg_503_0 then
				local var_503_7 = Color.New(0, 0, 0)

				var_503_7.a = 1
				arg_500_1.mask_.color = var_503_7
			end

			local var_503_8 = 2

			if 2 < arg_500_1.time_ and arg_500_1.time_ <= var_503_8 + arg_503_0 then
				arg_500_1.mask_.enabled = true
				arg_500_1.mask_.raycastTarget = true

				arg_500_1:SetGaussion(false)
			end

			local var_503_9 = 2

			if var_503_8 <= arg_500_1.time_ and arg_500_1.time_ < var_503_8 + var_503_9 then
				local var_503_10 = Color.New(0, 0, 0)

				var_503_10.a = Mathf.Lerp(1, 0, (arg_500_1.time_ - var_503_8) / var_503_9)
				arg_500_1.mask_.color = var_503_10
			end

			if arg_500_1.time_ >= var_503_8 + var_503_9 and arg_500_1.time_ < var_503_8 + var_503_9 + arg_503_0 then
				local var_503_11 = Color.New(0, 0, 0)

				arg_500_1.mask_.enabled = false
				var_503_11.a = 0
				arg_500_1.mask_.color = var_503_11
			end

			local var_503_12 = arg_500_1.bgs_.SS1302.transform

			if 2 < arg_500_1.time_ and arg_500_1.time_ <= 2 + arg_503_0 then
				arg_500_1.var_.moveOldPosSS1302 = var_503_12.localPosition
			end

			local var_503_13 = 0.001

			if 2 <= arg_500_1.time_ and arg_500_1.time_ < 2 + var_503_13 then
				var_503_12.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPosSS1302, Vector3.New(0, 1, 10), (arg_500_1.time_ - 2) / var_503_13)
			end

			if arg_500_1.time_ >= 2 + var_503_13 and arg_500_1.time_ < 2 + var_503_13 + arg_503_0 then
				var_503_12.localPosition = Vector3.New(0, 1, 10)
			end

			local var_503_14 = arg_500_1.bgs_.SS1302.transform

			if 2.01666666666667 < arg_500_1.time_ and arg_500_1.time_ <= 2.01666666666667 + arg_503_0 then
				arg_500_1.var_.moveOldPosSS1302 = var_503_14.localPosition
			end

			local var_503_15 = 2.15

			if 2.01666666666667 <= arg_500_1.time_ and arg_500_1.time_ < 2.01666666666667 + var_503_15 then
				var_503_14.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPosSS1302, Vector3.New(0, 0.9, 9.56), (arg_500_1.time_ - 2.01666666666667) / var_503_15)
			end

			if arg_500_1.time_ >= 2.01666666666667 + var_503_15 and arg_500_1.time_ < 2.01666666666667 + var_503_15 + arg_503_0 then
				var_503_14.localPosition = Vector3.New(0, 0.9, 9.56)
			end

			if arg_500_1.frameCnt_ <= 1 then
				arg_500_1.dialog_:SetActive(false)
			end

			local var_503_16 = 3.83333333333333
			local var_503_17 = 0.85

			if 3.83333333333333 < arg_500_1.time_ and arg_500_1.time_ <= var_503_16 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0

				arg_500_1.dialog_:SetActive(true)

				arg_500_1.dialogCg_.alpha = 0

				local var_503_18 = LeanTween.value(arg_500_1.dialog_, 0, 1, 0.3)

				var_503_18:setOnUpdate(LuaHelper.FloatAction(function(arg_504_0)
					arg_500_1.dialogCg_.alpha = arg_504_0
				end))
				var_503_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_500_1.dialog_)
					var_503_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_500_1.duration_ = arg_500_1.duration_ + 0.3

				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_19 = arg_500_1:GetWordFromCfg(413031120)
				local var_503_20 = arg_500_1:FormatText(var_503_19.content)

				arg_500_1.text_.text = var_503_20

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_22 = 34 <= 0 and var_503_17 or var_503_17 * (utf8.len(var_503_20) / 34)

				if (34 <= 0 and var_503_17 or var_503_17 * (utf8.len(var_503_20) / 34)) > 0 and var_503_17 < var_503_22 then
					arg_500_1.talkMaxDuration = var_503_22
					var_503_16 = var_503_16 + 0.3

					if var_503_22 + var_503_16 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_22 + var_503_16
					end
				end

				arg_500_1.text_.text = var_503_20
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031120", "story_v_out_413031.awb") ~= 0 then
					local var_503_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031120", "story_v_out_413031.awb") / 1000

					if var_503_23 + var_503_16 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_23 + var_503_16
					end

					if var_503_19.prefab_name ~= "" and arg_500_1.actors_[var_503_19.prefab_name] ~= nil then
						local var_503_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_19.prefab_name].transform, "story_v_out_413031", "413031120", "story_v_out_413031.awb")

						arg_500_1:RecordAudio("413031120", var_503_24)
						arg_500_1:RecordAudio("413031120", var_503_24)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_413031", "413031120", "story_v_out_413031.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_413031", "413031120", "story_v_out_413031.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_25 = var_503_16 + 0.3
			local var_503_26 = math.max(var_503_17, arg_500_1.talkMaxDuration)

			if var_503_16 + 0.3 <= arg_500_1.time_ and arg_500_1.time_ < var_503_25 + var_503_26 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_25) / var_503_26

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_25 + var_503_26 and arg_500_1.time_ < var_503_25 + var_503_26 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1302",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1302",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.15,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_500_1:InitPlayNodeList()
	end,
	Play413031121 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 413031121
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play413031122(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if arg_506_1.actors_["10095"] == nil then
				local var_509_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10095")

				if not isNil(var_509_0) then
					local var_509_1 = Object.Instantiate(var_509_0, arg_506_1.canvasGo_.transform)

					var_509_1.transform:SetSiblingIndex(1)

					var_509_1.name = "10095"
					var_509_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_506_1.actors_["10095"] = var_509_1

					if arg_506_1.isInRecall_ then
						for iter_509_0, iter_509_1 in ipairs((var_509_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_509_1.color = arg_506_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				local var_509_2 = arg_506_1.actors_["10095"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_509_2 then
					arg_506_1.var_.alphaOldValue10095 = var_509_2.alpha
					arg_506_1.var_.characterEffect10095 = var_509_2
				end

				arg_506_1.var_.alphaOldValue10095 = 1
			end

			local var_509_3 = 0.5

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_3 then
				if arg_506_1.var_.characterEffect10095 then
					arg_506_1.var_.characterEffect10095.alpha = Mathf.Lerp(arg_506_1.var_.alphaOldValue10095, 0, (arg_506_1.time_ - 0) / var_509_3)
				end
			end

			if arg_506_1.time_ >= 0 + var_509_3 and arg_506_1.time_ < 0 + var_509_3 + arg_509_0 and arg_506_1.var_.characterEffect10095 then
				arg_506_1.var_.characterEffect10095.alpha = 0
			end

			local var_509_4 = 0
			local var_509_5 = 1.325

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_4 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_6 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(413031121).content)

				arg_506_1.text_.text = var_509_6

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_8 = 53 <= 0 and var_509_5 or var_509_5 * (utf8.len(var_509_6) / 53)

				if (53 <= 0 and var_509_5 or var_509_5 * (utf8.len(var_509_6) / 53)) > 0 and var_509_5 < var_509_8 then
					arg_506_1.talkMaxDuration = var_509_8

					if var_509_8 + var_509_4 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_8 + var_509_4
					end
				end

				arg_506_1.text_.text = var_509_6
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_9 = math.max(var_509_5, arg_506_1.talkMaxDuration)

			if var_509_4 <= arg_506_1.time_ and arg_506_1.time_ < var_509_4 + var_509_9 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_4) / var_509_9

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_4 + var_509_9 and arg_506_1.time_ < var_509_4 + var_509_9 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play413031122 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 413031122
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play413031123(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 1.1

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_1 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(413031122).content)

				arg_510_1.text_.text = var_513_1

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_3 = 44 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 44)

				if (44 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 44)) > 0 and var_513_0 < var_513_3 then
					arg_510_1.talkMaxDuration = var_513_3

					if var_513_3 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_3 + 0
					end
				end

				arg_510_1.text_.text = var_513_1
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_4 = math.max(var_513_0, arg_510_1.talkMaxDuration)

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_4 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - 0) / var_513_4

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= 0 + var_513_4 and arg_510_1.time_ < 0 + var_513_4 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play413031123 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 413031123
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play413031124(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0.366666666666667 < arg_514_1.time_ and arg_514_1.time_ <= 0.366666666666667 + arg_517_0 then
				arg_514_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_paper", "")
			end

			local var_517_1 = 0
			local var_517_2 = 0.875

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, false)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_3 = arg_514_1:FormatText(arg_514_1:GetWordFromCfg(413031123).content)

				arg_514_1.text_.text = var_517_3

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_5 = 35 <= 0 and var_517_2 or var_517_2 * (utf8.len(var_517_3) / 35)

				if (35 <= 0 and var_517_2 or var_517_2 * (utf8.len(var_517_3) / 35)) > 0 and var_517_2 < var_517_5 then
					arg_514_1.talkMaxDuration = var_517_5

					if var_517_5 + var_517_1 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_5 + var_517_1
					end
				end

				arg_514_1.text_.text = var_517_3
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_6 = math.max(var_517_2, arg_514_1.talkMaxDuration)

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_6 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_1) / var_517_6

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_1 + var_517_6 and arg_514_1.time_ < var_517_1 + var_517_6 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play413031124 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 413031124
		arg_518_1.duration_ = 9.57

		local var_518_0 = {
			zh = 8.166,
			ja = 9.566
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
				arg_518_0:Play413031125(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 0.625

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_1 = arg_518_1:GetWordFromCfg(413031124)
				local var_521_2 = arg_518_1:FormatText(var_521_1.content)

				arg_518_1.text_.text = var_521_2

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_4 = 25 <= 0 and var_521_0 or var_521_0 * (utf8.len(var_521_2) / 25)

				if (25 <= 0 and var_521_0 or var_521_0 * (utf8.len(var_521_2) / 25)) > 0 and var_521_0 < var_521_4 then
					arg_518_1.talkMaxDuration = var_521_4

					if var_521_4 + 0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_4 + 0
					end
				end

				arg_518_1.text_.text = var_521_2
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031124", "story_v_out_413031.awb") ~= 0 then
					local var_521_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031124", "story_v_out_413031.awb") / 1000

					if var_521_5 + 0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_5 + 0
					end

					if var_521_1.prefab_name ~= "" and arg_518_1.actors_[var_521_1.prefab_name] ~= nil then
						local var_521_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_1.prefab_name].transform, "story_v_out_413031", "413031124", "story_v_out_413031.awb")

						arg_518_1:RecordAudio("413031124", var_521_6)
						arg_518_1:RecordAudio("413031124", var_521_6)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_413031", "413031124", "story_v_out_413031.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_413031", "413031124", "story_v_out_413031.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_7 = math.max(var_521_0, arg_518_1.talkMaxDuration)

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_7 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - 0) / var_521_7

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= 0 + var_521_7 and arg_518_1.time_ < 0 + var_521_7 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play413031125 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 413031125
		arg_522_1.duration_ = 5.83

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play413031126(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_9000

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(arg_522_1.actors_["10095"]) and arg_522_1.var_.actorSpriteComps10095 == nil then
				arg_522_1.var_.actorSpriteComps10095 = arg_522_1.actors_["10095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_525_0 = 2

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 and not isNil(arg_522_1.actors_["10095"]) then
				if arg_522_1.var_.actorSpriteComps10095 then
					for iter_525_0, iter_525_1 in pairs(arg_522_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_525_1 then
							if arg_522_1.isInRecall_ then
								iter_525_1.color = Color.New(Mathf.Lerp(iter_525_1.color.r, arg_522_1.hightColor2.r, (arg_522_1.time_ - 0) / var_525_0), Mathf.Lerp(iter_525_1.color.g, arg_522_1.hightColor2.g, (arg_522_1.time_ - 0) / var_525_0), (Mathf.Lerp(iter_525_1.color.b, arg_522_1.hightColor2.b, (arg_522_1.time_ - 0) / var_525_0)))
							else
								local var_525_1 = Mathf.Lerp(iter_525_1.color.r, 0.5, (arg_522_1.time_ - 0) / var_525_0)

								iter_525_1.color = Color.New(var_525_1, var_525_1, var_525_1)
							end
						end
					end
				end
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 and not isNil(arg_522_1.actors_["10095"]) and arg_522_1.var_.actorSpriteComps10095 then
				for iter_525_2, iter_525_3 in pairs(arg_522_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_525_3 then
						iter_525_3.color = arg_522_1.isInRecall_ and (arg_522_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_522_1.var_.actorSpriteComps10095 = nil
			end

			local var_525_2 = 0

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_2 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_3 = 1

			if var_525_2 <= arg_522_1.time_ and arg_522_1.time_ < var_525_2 + var_525_3 then
				local var_525_4 = Color.New(1, 1, 1)

				var_525_4.a = Mathf.Lerp(1, 0, (arg_522_1.time_ - var_525_2) / var_525_3)
				arg_522_1.mask_.color = var_525_4
			end

			if arg_522_1.time_ >= var_525_2 + var_525_3 and arg_522_1.time_ < var_525_2 + var_525_3 + arg_525_0 then
				local var_525_5 = Color.New(1, 1, 1)

				arg_522_1.mask_.enabled = false
				var_525_5.a = 0
				arg_522_1.mask_.color = var_525_5
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				local var_525_6 = arg_522_1.var_.effectsecainiuqu1

				if not arg_522_1.var_.effectsecainiuqu1 then
					var_525_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_525_6.name = "secainiuqu1"
					arg_522_1.var_.effectsecainiuqu1 = var_525_6
				else
					var_525_6.transform:SetParent(var_525_9000)
				end

				var_525_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_525_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_525_8 = "SS1302a"

			if arg_522_1.bgs_.SS1302a == nil then
				local var_525_9 = Object.Instantiate(arg_522_1.paintGo_)

				var_525_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_525_8)
				var_525_9.name = var_525_8
				var_525_9.transform.parent = arg_522_1.stage_.transform
				var_525_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_522_1.bgs_[var_525_8] = var_525_9
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				local var_525_10 = arg_522_1.bgs_.SS1302a

				arg_522_1.bgs_.SS1302a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_525_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_525_11 = var_525_10:GetComponent("SpriteRenderer")

				if var_525_11 and var_525_11.sprite then
					local var_525_12 = 2 * (var_525_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_525_10.transform.localScale = Vector3.New(var_525_12 / var_525_11.sprite.bounds.size.y < var_525_12 * manager.ui.mainCameraCom_.aspect / var_525_11.sprite.bounds.size.x and var_525_12 * manager.ui.mainCameraCom_.aspect / var_525_11.sprite.bounds.size.x or var_525_12 / var_525_11.sprite.bounds.size.y, var_525_12 / var_525_11.sprite.bounds.size.y < var_525_12 * manager.ui.mainCameraCom_.aspect / var_525_11.sprite.bounds.size.x and var_525_12 * manager.ui.mainCameraCom_.aspect / var_525_11.sprite.bounds.size.x or var_525_12 / var_525_11.sprite.bounds.size.y, 0)
				end

				for iter_525_4, iter_525_5 in pairs(arg_522_1.bgs_) do
					if iter_525_4 ~= "SS1302a" then
						iter_525_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_522_1.frameCnt_ <= 1 then
				arg_522_1.dialog_:SetActive(false)
			end

			local var_525_13 = 0.833333333333333
			local var_525_14 = 1.5

			if 0.833333333333333 < arg_522_1.time_ and arg_522_1.time_ <= var_525_13 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0

				arg_522_1.dialog_:SetActive(true)

				arg_522_1.dialogCg_.alpha = 0

				local var_525_15 = LeanTween.value(arg_522_1.dialog_, 0, 1, 0.3)

				var_525_15:setOnUpdate(LuaHelper.FloatAction(function(arg_526_0)
					arg_522_1.dialogCg_.alpha = arg_526_0
				end))
				var_525_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_522_1.dialog_)
					var_525_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_522_1.duration_ = arg_522_1.duration_ + 0.3

				SetActive(arg_522_1.leftNameGo_, false)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_16 = arg_522_1:FormatText(arg_522_1:GetWordFromCfg(413031125).content)

				arg_522_1.text_.text = var_525_16

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_18 = 60 <= 0 and var_525_14 or var_525_14 * (utf8.len(var_525_16) / 60)

				if (60 <= 0 and var_525_14 or var_525_14 * (utf8.len(var_525_16) / 60)) > 0 and var_525_14 < var_525_18 then
					arg_522_1.talkMaxDuration = var_525_18
					var_525_13 = var_525_13 + 0.3

					if var_525_18 + var_525_13 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_18 + var_525_13
					end
				end

				arg_522_1.text_.text = var_525_16
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_19 = var_525_13 + 0.3
			local var_525_20 = math.max(var_525_14, arg_522_1.talkMaxDuration)

			if var_525_13 + 0.3 <= arg_522_1.time_ and arg_522_1.time_ < var_525_19 + var_525_20 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_19) / var_525_20

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_19 + var_525_20 and arg_522_1.time_ < var_525_19 + var_525_20 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play413031126 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 413031126
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play413031127(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 1.5

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_1 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(413031126).content)

				arg_528_1.text_.text = var_531_1

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_3 = 60 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 60)

				if (60 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 60)) > 0 and var_531_0 < var_531_3 then
					arg_528_1.talkMaxDuration = var_531_3

					if var_531_3 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_3 + 0
					end
				end

				arg_528_1.text_.text = var_531_1
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_4 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_4

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play413031127 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 413031127
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play413031128(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 1.025

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_1 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(413031127).content)

				arg_532_1.text_.text = var_535_1

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_3 = 41 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 41)

				if (41 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 41)) > 0 and var_535_0 < var_535_3 then
					arg_532_1.talkMaxDuration = var_535_3

					if var_535_3 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_3 + 0
					end
				end

				arg_532_1.text_.text = var_535_1
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_4 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_4 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_4

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_4 and arg_532_1.time_ < 0 + var_535_4 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play413031128 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 413031128
		arg_536_1.duration_ = 3.83

		local var_536_0 = {
			zh = 2.6,
			ja = 3.833
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play413031129(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				if arg_536_1.var_.effectsecainiuqu1 then
					Object.Destroy(arg_536_1.var_.effectsecainiuqu1)

					arg_536_1.var_.effectsecainiuqu1 = nil
				end
			end

			local var_539_1 = 0
			local var_539_2 = 0.2

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_3 = arg_536_1:GetWordFromCfg(413031128)
				local var_539_4 = arg_536_1:FormatText(var_539_3.content)

				arg_536_1.text_.text = var_539_4

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_6 = 8 <= 0 and var_539_2 or var_539_2 * (utf8.len(var_539_4) / 8)

				if (8 <= 0 and var_539_2 or var_539_2 * (utf8.len(var_539_4) / 8)) > 0 and var_539_2 < var_539_6 then
					arg_536_1.talkMaxDuration = var_539_6

					if var_539_6 + var_539_1 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_6 + var_539_1
					end
				end

				arg_536_1.text_.text = var_539_4
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031128", "story_v_out_413031.awb") ~= 0 then
					local var_539_7 = manager.audio:GetVoiceLength("story_v_out_413031", "413031128", "story_v_out_413031.awb") / 1000

					if var_539_7 + var_539_1 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_7 + var_539_1
					end

					if var_539_3.prefab_name ~= "" and arg_536_1.actors_[var_539_3.prefab_name] ~= nil then
						local var_539_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_3.prefab_name].transform, "story_v_out_413031", "413031128", "story_v_out_413031.awb")

						arg_536_1:RecordAudio("413031128", var_539_8)
						arg_536_1:RecordAudio("413031128", var_539_8)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_413031", "413031128", "story_v_out_413031.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_413031", "413031128", "story_v_out_413031.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_9 = math.max(var_539_2, arg_536_1.talkMaxDuration)

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_9 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_1) / var_539_9

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_1 + var_539_9 and arg_536_1.time_ < var_539_1 + var_539_9 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play413031129 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 413031129
		arg_540_1.duration_ = 2.5

		local var_540_0 = {
			zh = 2.5,
			ja = 1.366
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play413031130(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0.225

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_1")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_1 = arg_540_1:GetWordFromCfg(413031129)
				local var_543_2 = arg_540_1:FormatText(var_543_1.content)

				arg_540_1.text_.text = var_543_2

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_4 = 9 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 9)

				if (9 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 9)) > 0 and var_543_0 < var_543_4 then
					arg_540_1.talkMaxDuration = var_543_4

					if var_543_4 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_4 + 0
					end
				end

				arg_540_1.text_.text = var_543_2
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031129", "story_v_out_413031.awb") ~= 0 then
					local var_543_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031129", "story_v_out_413031.awb") / 1000

					if var_543_5 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_5 + 0
					end

					if var_543_1.prefab_name ~= "" and arg_540_1.actors_[var_543_1.prefab_name] ~= nil then
						local var_543_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_1.prefab_name].transform, "story_v_out_413031", "413031129", "story_v_out_413031.awb")

						arg_540_1:RecordAudio("413031129", var_543_6)
						arg_540_1:RecordAudio("413031129", var_543_6)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_413031", "413031129", "story_v_out_413031.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_413031", "413031129", "story_v_out_413031.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_7 = math.max(var_543_0, arg_540_1.talkMaxDuration)

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_7 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - 0) / var_543_7

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= 0 + var_543_7 and arg_540_1.time_ < 0 + var_543_7 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play413031130 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 413031130
		arg_544_1.duration_ = 7.33

		local var_544_0 = {
			zh = 6.233,
			ja = 7.333
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play413031131(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0.775

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_1 = arg_544_1:GetWordFromCfg(413031130)
				local var_547_2 = arg_544_1:FormatText(var_547_1.content)

				arg_544_1.text_.text = var_547_2

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_4 = 31 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 31)

				if (31 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 31)) > 0 and var_547_0 < var_547_4 then
					arg_544_1.talkMaxDuration = var_547_4

					if var_547_4 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_4 + 0
					end
				end

				arg_544_1.text_.text = var_547_2
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031130", "story_v_out_413031.awb") ~= 0 then
					local var_547_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031130", "story_v_out_413031.awb") / 1000

					if var_547_5 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_5 + 0
					end

					if var_547_1.prefab_name ~= "" and arg_544_1.actors_[var_547_1.prefab_name] ~= nil then
						local var_547_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_1.prefab_name].transform, "story_v_out_413031", "413031130", "story_v_out_413031.awb")

						arg_544_1:RecordAudio("413031130", var_547_6)
						arg_544_1:RecordAudio("413031130", var_547_6)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_413031", "413031130", "story_v_out_413031.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_413031", "413031130", "story_v_out_413031.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_7 = math.max(var_547_0, arg_544_1.talkMaxDuration)

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_7 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - 0) / var_547_7

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= 0 + var_547_7 and arg_544_1.time_ < 0 + var_547_7 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play413031131 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 413031131
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play413031132(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 1.025

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_1 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(413031131).content)

				arg_548_1.text_.text = var_551_1

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_3 = 41 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_1) / 41)

				if (41 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_1) / 41)) > 0 and var_551_0 < var_551_3 then
					arg_548_1.talkMaxDuration = var_551_3

					if var_551_3 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_3 + 0
					end
				end

				arg_548_1.text_.text = var_551_1
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_4 = math.max(var_551_0, arg_548_1.talkMaxDuration)

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_4 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - 0) / var_551_4

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= 0 + var_551_4 and arg_548_1.time_ < 0 + var_551_4 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play413031132 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 413031132
		arg_552_1.duration_ = 5.03

		local var_552_0 = {
			zh = 3.5,
			ja = 5.033
		}
		local var_552_1 = manager.audio:GetLocalizationFlag()

		if var_552_0[var_552_1] ~= nil then
			arg_552_1.duration_ = var_552_0[var_552_1]
		end

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play413031133(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0.525

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_1 = arg_552_1:GetWordFromCfg(413031132)
				local var_555_2 = arg_552_1:FormatText(var_555_1.content)

				arg_552_1.text_.text = var_555_2

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_4 = 21 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 21)

				if (21 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 21)) > 0 and var_555_0 < var_555_4 then
					arg_552_1.talkMaxDuration = var_555_4

					if var_555_4 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_4 + 0
					end
				end

				arg_552_1.text_.text = var_555_2
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031132", "story_v_out_413031.awb") ~= 0 then
					local var_555_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031132", "story_v_out_413031.awb") / 1000

					if var_555_5 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_5 + 0
					end

					if var_555_1.prefab_name ~= "" and arg_552_1.actors_[var_555_1.prefab_name] ~= nil then
						local var_555_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_1.prefab_name].transform, "story_v_out_413031", "413031132", "story_v_out_413031.awb")

						arg_552_1:RecordAudio("413031132", var_555_6)
						arg_552_1:RecordAudio("413031132", var_555_6)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_out_413031", "413031132", "story_v_out_413031.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_out_413031", "413031132", "story_v_out_413031.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_7 = math.max(var_555_0, arg_552_1.talkMaxDuration)

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_7 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - 0) / var_555_7

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= 0 + var_555_7 and arg_552_1.time_ < 0 + var_555_7 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play413031133 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 413031133
		arg_556_1.duration_ = 4.7

		local var_556_0 = {
			zh = 1.833,
			ja = 4.7
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play413031134(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0.225

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, true)
				arg_556_1.iconController_:SetSelectedState("hero")

				arg_556_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_556_1.callingController_:SetSelectedState("normal")

				arg_556_1.keyicon_.color = Color.New(1, 1, 1)
				arg_556_1.icon_.color = Color.New(1, 1, 1)

				local var_559_1 = arg_556_1:GetWordFromCfg(413031133)
				local var_559_2 = arg_556_1:FormatText(var_559_1.content)

				arg_556_1.text_.text = var_559_2

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_4 = 9 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_2) / 9)

				if (9 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_2) / 9)) > 0 and var_559_0 < var_559_4 then
					arg_556_1.talkMaxDuration = var_559_4

					if var_559_4 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_4 + 0
					end
				end

				arg_556_1.text_.text = var_559_2
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031133", "story_v_out_413031.awb") ~= 0 then
					local var_559_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031133", "story_v_out_413031.awb") / 1000

					if var_559_5 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_5 + 0
					end

					if var_559_1.prefab_name ~= "" and arg_556_1.actors_[var_559_1.prefab_name] ~= nil then
						local var_559_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_1.prefab_name].transform, "story_v_out_413031", "413031133", "story_v_out_413031.awb")

						arg_556_1:RecordAudio("413031133", var_559_6)
						arg_556_1:RecordAudio("413031133", var_559_6)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_out_413031", "413031133", "story_v_out_413031.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_out_413031", "413031133", "story_v_out_413031.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_7 = math.max(var_559_0, arg_556_1.talkMaxDuration)

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_7 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - 0) / var_559_7

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= 0 + var_559_7 and arg_556_1.time_ < 0 + var_559_7 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play413031134 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 413031134
		arg_560_1.duration_ = 3.13

		local var_560_0 = {
			zh = 3.133,
			ja = 2.033
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play413031135(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0.225

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_1 = arg_560_1:GetWordFromCfg(413031134)
				local var_563_2 = arg_560_1:FormatText(var_563_1.content)

				arg_560_1.text_.text = var_563_2

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_4 = 9 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 9)

				if (9 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 9)) > 0 and var_563_0 < var_563_4 then
					arg_560_1.talkMaxDuration = var_563_4

					if var_563_4 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_4 + 0
					end
				end

				arg_560_1.text_.text = var_563_2
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031134", "story_v_out_413031.awb") ~= 0 then
					local var_563_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031134", "story_v_out_413031.awb") / 1000

					if var_563_5 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_5 + 0
					end

					if var_563_1.prefab_name ~= "" and arg_560_1.actors_[var_563_1.prefab_name] ~= nil then
						local var_563_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_1.prefab_name].transform, "story_v_out_413031", "413031134", "story_v_out_413031.awb")

						arg_560_1:RecordAudio("413031134", var_563_6)
						arg_560_1:RecordAudio("413031134", var_563_6)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_413031", "413031134", "story_v_out_413031.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_413031", "413031134", "story_v_out_413031.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_7 = math.max(var_563_0, arg_560_1.talkMaxDuration)

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_7 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - 0) / var_563_7

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= 0 + var_563_7 and arg_560_1.time_ < 0 + var_563_7 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play413031135 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 413031135
		arg_564_1.duration_ = 3.3

		local var_564_0 = {
			zh = 3.3,
			ja = 1.833
		}
		local var_564_1 = manager.audio:GetLocalizationFlag()

		if var_564_0[var_564_1] ~= nil then
			arg_564_1.duration_ = var_564_0[var_564_1]
		end

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play413031136(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 0.4

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				arg_564_1.leftNameTxt_.text = arg_564_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, true)
				arg_564_1.iconController_:SetSelectedState("hero")

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_1 = arg_564_1:GetWordFromCfg(413031135)
				local var_567_2 = arg_564_1:FormatText(var_567_1.content)

				arg_564_1.text_.text = var_567_2

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_4 = 16 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_2) / 16)

				if (16 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_2) / 16)) > 0 and var_567_0 < var_567_4 then
					arg_564_1.talkMaxDuration = var_567_4

					if var_567_4 + 0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_4 + 0
					end
				end

				arg_564_1.text_.text = var_567_2
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031135", "story_v_out_413031.awb") ~= 0 then
					local var_567_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031135", "story_v_out_413031.awb") / 1000

					if var_567_5 + 0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_5 + 0
					end

					if var_567_1.prefab_name ~= "" and arg_564_1.actors_[var_567_1.prefab_name] ~= nil then
						local var_567_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_1.prefab_name].transform, "story_v_out_413031", "413031135", "story_v_out_413031.awb")

						arg_564_1:RecordAudio("413031135", var_567_6)
						arg_564_1:RecordAudio("413031135", var_567_6)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_out_413031", "413031135", "story_v_out_413031.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_out_413031", "413031135", "story_v_out_413031.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_7 = math.max(var_567_0, arg_564_1.talkMaxDuration)

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_7 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - 0) / var_567_7

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= 0 + var_567_7 and arg_564_1.time_ < 0 + var_567_7 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play413031136 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 413031136
		arg_568_1.duration_ = 5.23

		local var_568_0 = {
			zh = 3.966,
			ja = 5.233
		}
		local var_568_1 = manager.audio:GetLocalizationFlag()

		if var_568_0[var_568_1] ~= nil then
			arg_568_1.duration_ = var_568_0[var_568_1]
		end

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play413031137(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 and not isNil(arg_568_1.actors_["10022"]) and arg_568_1.var_.actorSpriteComps10022 == nil then
				arg_568_1.var_.actorSpriteComps10022 = arg_568_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_571_0 = 2

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_0 and not isNil(arg_568_1.actors_["10022"]) then
				if arg_568_1.var_.actorSpriteComps10022 then
					for iter_571_0, iter_571_1 in pairs(arg_568_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_571_1 then
							if arg_568_1.isInRecall_ then
								iter_571_1.color = Color.New(Mathf.Lerp(iter_571_1.color.r, arg_568_1.hightColor2.r, (arg_568_1.time_ - 0) / var_571_0), Mathf.Lerp(iter_571_1.color.g, arg_568_1.hightColor2.g, (arg_568_1.time_ - 0) / var_571_0), (Mathf.Lerp(iter_571_1.color.b, arg_568_1.hightColor2.b, (arg_568_1.time_ - 0) / var_571_0)))
							else
								local var_571_1 = Mathf.Lerp(iter_571_1.color.r, 0.5, (arg_568_1.time_ - 0) / var_571_0)

								iter_571_1.color = Color.New(var_571_1, var_571_1, var_571_1)
							end
						end
					end
				end
			end

			if arg_568_1.time_ >= 0 + var_571_0 and arg_568_1.time_ < 0 + var_571_0 + arg_571_0 and not isNil(arg_568_1.actors_["10022"]) and arg_568_1.var_.actorSpriteComps10022 then
				for iter_571_2, iter_571_3 in pairs(arg_568_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_571_3 then
						iter_571_3.color = arg_568_1.isInRecall_ and (arg_568_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_568_1.var_.actorSpriteComps10022 = nil
			end

			local var_571_2 = 0
			local var_571_3 = 0.4

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_2 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				arg_568_1.leftNameTxt_.text = arg_568_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, true)
				arg_568_1.iconController_:SetSelectedState("hero")

				arg_568_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_568_1.callingController_:SetSelectedState("normal")

				arg_568_1.keyicon_.color = Color.New(1, 1, 1)
				arg_568_1.icon_.color = Color.New(1, 1, 1)

				local var_571_4 = arg_568_1:GetWordFromCfg(413031136)
				local var_571_5 = arg_568_1:FormatText(var_571_4.content)

				arg_568_1.text_.text = var_571_5

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_7 = 16 <= 0 and var_571_3 or var_571_3 * (utf8.len(var_571_5) / 16)

				if (16 <= 0 and var_571_3 or var_571_3 * (utf8.len(var_571_5) / 16)) > 0 and var_571_3 < var_571_7 then
					arg_568_1.talkMaxDuration = var_571_7

					if var_571_7 + var_571_2 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_7 + var_571_2
					end
				end

				arg_568_1.text_.text = var_571_5
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031136", "story_v_out_413031.awb") ~= 0 then
					local var_571_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031136", "story_v_out_413031.awb") / 1000

					if var_571_8 + var_571_2 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_8 + var_571_2
					end

					if var_571_4.prefab_name ~= "" and arg_568_1.actors_[var_571_4.prefab_name] ~= nil then
						local var_571_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_4.prefab_name].transform, "story_v_out_413031", "413031136", "story_v_out_413031.awb")

						arg_568_1:RecordAudio("413031136", var_571_9)
						arg_568_1:RecordAudio("413031136", var_571_9)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_out_413031", "413031136", "story_v_out_413031.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_out_413031", "413031136", "story_v_out_413031.awb")
				end

				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_10 = math.max(var_571_3, arg_568_1.talkMaxDuration)

			if var_571_2 <= arg_568_1.time_ and arg_568_1.time_ < var_571_2 + var_571_10 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_2) / var_571_10

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_2 + var_571_10 and arg_568_1.time_ < var_571_2 + var_571_10 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play413031137 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 413031137
		arg_572_1.duration_ = 7.07

		local var_572_0 = {
			zh = 7.066,
			ja = 6.733
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
			arg_572_1.auto_ = false
		end

		function arg_572_1.playNext_(arg_574_0)
			arg_572_1.onStoryFinished_()
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0.725

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, true)
				arg_572_1.iconController_:SetSelectedState("hero")

				arg_572_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_2")

				arg_572_1.callingController_:SetSelectedState("normal")

				arg_572_1.keyicon_.color = Color.New(1, 1, 1)
				arg_572_1.icon_.color = Color.New(1, 1, 1)

				local var_575_1 = arg_572_1:GetWordFromCfg(413031137)
				local var_575_2 = arg_572_1:FormatText(var_575_1.content)

				arg_572_1.text_.text = var_575_2

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_4 = 29 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_2) / 29)

				if (29 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_2) / 29)) > 0 and var_575_0 < var_575_4 then
					arg_572_1.talkMaxDuration = var_575_4

					if var_575_4 + 0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_4 + 0
					end
				end

				arg_572_1.text_.text = var_575_2
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031137", "story_v_out_413031.awb") ~= 0 then
					local var_575_5 = manager.audio:GetVoiceLength("story_v_out_413031", "413031137", "story_v_out_413031.awb") / 1000

					if var_575_5 + 0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_5 + 0
					end

					if var_575_1.prefab_name ~= "" and arg_572_1.actors_[var_575_1.prefab_name] ~= nil then
						local var_575_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_1.prefab_name].transform, "story_v_out_413031", "413031137", "story_v_out_413031.awb")

						arg_572_1:RecordAudio("413031137", var_575_6)
						arg_572_1:RecordAudio("413031137", var_575_6)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_413031", "413031137", "story_v_out_413031.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_413031", "413031137", "story_v_out_413031.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_7 = math.max(var_575_0, arg_572_1.talkMaxDuration)

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_7 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - 0) / var_575_7

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= 0 + var_575_7 and arg_572_1.time_ < 0 + var_575_7 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0601",
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/F08f",
		"TextureConfig/Background/F08l",
		"TextureConfig/Background/SS1302",
		"TextureConfig/Background/SS1302a"
	},
	voices = {
		"story_v_out_413031.awb"
	}
}
