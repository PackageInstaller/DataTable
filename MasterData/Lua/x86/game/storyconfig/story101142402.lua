return {
	Play114242001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114242001
		arg_1_1.duration_ = 11.83

		local var_1_0 = {
			ja = 8.632999999999,
			ko = 11.765999999999,
			zh = 11.132999999999,
			en = 11.832999999999
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
				arg_1_0:Play114242002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.actors_["10018"] == nil then
				local var_4_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10018")

				if not isNil(var_4_0) then
					local var_4_1 = Object.Instantiate(var_4_0, arg_1_1.canvasGo_.transform)

					var_4_1.transform:SetSiblingIndex(1)

					var_4_1.name = "10018"
					var_4_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_["10018"] = var_4_1

					if arg_1_1.isInRecall_ then
						for iter_4_0, iter_4_1 in ipairs((var_4_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_1.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_2 = arg_1_1.actors_["10018"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10018 = var_4_2.localPosition
				var_4_2.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10018", 2)

				for iter_4_2 = 0, var_4_2.childCount - 1 do
					local var_4_3 = var_4_2:GetChild(iter_4_2)

					if var_4_3.name == "split_2" or not string.find(var_4_3.name, "split") then
						var_4_3.gameObject:SetActive(true)
					else
						var_4_3.gameObject:SetActive(false)
					end
				end
			end

			local var_4_4 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_4 then
				var_4_2.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_1_1.time_ - 1.8) / var_4_4)
			end

			if arg_1_1.time_ >= 1.8 + var_4_4 and arg_1_1.time_ < 1.8 + var_4_4 + arg_4_0 then
				var_4_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_4_5 = arg_1_1.actors_["10018"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.actorSpriteComps10018 == nil then
				arg_1_1.var_.actorSpriteComps10018 = var_4_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_6 = 0.034

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_6 and not isNil(var_4_5) then
				if arg_1_1.var_.actorSpriteComps10018 then
					for iter_4_3, iter_4_4 in pairs(arg_1_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_4_4 then
							if arg_1_1.isInRecall_ then
								iter_4_4.color = Color.New(Mathf.Lerp(iter_4_4.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.8) / var_4_6), Mathf.Lerp(iter_4_4.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.8) / var_4_6), (Mathf.Lerp(iter_4_4.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.8) / var_4_6)))
							else
								local var_4_7 = Mathf.Lerp(iter_4_4.color.r, 1, (arg_1_1.time_ - 1.8) / var_4_6)

								iter_4_4.color = Color.New(var_4_7, var_4_7, var_4_7)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_6 and arg_1_1.time_ < 1.8 + var_4_6 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.actorSpriteComps10018 then
				for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_4_6 then
						iter_4_6.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10018 = nil
			end

			local var_4_8 = "ST25"

			if arg_1_1.bgs_.ST25 == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_10 = arg_1_1.bgs_.ST25

				arg_1_1.bgs_.ST25.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_11 = var_4_10:GetComponent("SpriteRenderer")

				if var_4_11 and var_4_11.sprite then
					local var_4_12 = 2 * (var_4_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_10.transform.localScale = Vector3.New(var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, 0)
				end

				for iter_4_7, iter_4_8 in pairs(arg_1_1.bgs_) do
					if iter_4_7 ~= "ST25" then
						iter_4_8.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_13 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_14 = 2

			if var_4_13 <= arg_1_1.time_ and arg_1_1.time_ < var_4_13 + var_4_14 then
				local var_4_15 = Color.New(0, 0, 0)

				var_4_15.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_13) / var_4_14)
				arg_1_1.mask_.color = var_4_15
			end

			if arg_1_1.time_ >= var_4_13 + var_4_14 and arg_1_1.time_ < var_4_13 + var_4_14 + arg_4_0 then
				local var_4_16 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_16.a = 0
				arg_1_1.mask_.color = var_4_16
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_17 = arg_1_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_17 then
					arg_1_1.var_.alphaOldValue10018 = var_4_17.alpha
					arg_1_1.var_.characterEffect10018 = var_4_17
				end

				arg_1_1.var_.alphaOldValue10018 = 0
			end

			local var_4_18 = 0.5

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_18 then
				if arg_1_1.var_.characterEffect10018 then
					arg_1_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10018, 1, (arg_1_1.time_ - 1.8) / var_4_18)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_18 and arg_1_1.time_ < 1.8 + var_4_18 + arg_4_0 and arg_1_1.var_.characterEffect10018 then
				arg_1_1.var_.characterEffect10018.alpha = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 1.999999999999
			local var_4_26 = 1.1

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(114242001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 44 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 44)

				if (44 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 44)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242001", "story_v_out_114242.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_114242", "114242001", "story_v_out_114242.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_114242", "114242001", "story_v_out_114242.awb")

						arg_1_1:RecordAudio("114242001", var_4_33)
						arg_1_1:RecordAudio("114242001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114242", "114242001", "story_v_out_114242.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114242", "114242001", "story_v_out_114242.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114242002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114242002
		arg_9_1.duration_ = 6.43

		local var_9_0 = {
			ja = 4.666,
			ko = 5.1,
			zh = 6.433,
			en = 4.333
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
				arg_9_0:Play114242003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10015"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10015"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10015"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10015"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10015 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10015", 4)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "split_5" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_12_5 = arg_9_1.actors_["10018"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10018 == nil then
				arg_9_1.var_.actorSpriteComps10018 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps10018 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								iter_12_4.color = Color.New(Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_6), Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_6), (Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_6)))
							else
								local var_12_7 = Mathf.Lerp(iter_12_4.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_6)

								iter_12_4.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10018 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_12_6 then
						iter_12_6.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10018 = nil
			end

			local var_12_8 = arg_9_1.actors_["10015"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps10015 == nil then
				arg_9_1.var_.actorSpriteComps10015 = var_12_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_9 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.actorSpriteComps10015 then
					for iter_12_7, iter_12_8 in pairs(arg_9_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_12_8 then
							if arg_9_1.isInRecall_ then
								iter_12_8.color = Color.New(Mathf.Lerp(iter_12_8.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_9), Mathf.Lerp(iter_12_8.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_9), (Mathf.Lerp(iter_12_8.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_9)))
							else
								local var_12_10 = Mathf.Lerp(iter_12_8.color.r, 1, (arg_9_1.time_ - 0) / var_12_9)

								iter_12_8.color = Color.New(var_12_10, var_12_10, var_12_10)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps10015 then
				for iter_12_9, iter_12_10 in pairs(arg_9_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_12_10 then
						iter_12_10.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_11 = arg_9_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_11 then
					arg_9_1.var_.alphaOldValue10015 = var_12_11.alpha
					arg_9_1.var_.characterEffect10015 = var_12_11
				end

				arg_9_1.var_.alphaOldValue10015 = 0
			end

			local var_12_12 = 0.5

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_12 then
				if arg_9_1.var_.characterEffect10015 then
					arg_9_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue10015, 1, (arg_9_1.time_ - 0) / var_12_12)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_12 and arg_9_1.time_ < 0 + var_12_12 + arg_12_0 and arg_9_1.var_.characterEffect10015 then
				arg_9_1.var_.characterEffect10015.alpha = 1
			end

			local var_12_13 = 0
			local var_12_14 = 0.65

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_13 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_15 = arg_9_1:GetWordFromCfg(114242002)
				local var_12_16 = arg_9_1:FormatText(var_12_15.content)

				arg_9_1.text_.text = var_12_16

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_18 = 26 <= 0 and var_12_14 or var_12_14 * (utf8.len(var_12_16) / 26)

				if (26 <= 0 and var_12_14 or var_12_14 * (utf8.len(var_12_16) / 26)) > 0 and var_12_14 < var_12_18 then
					arg_9_1.talkMaxDuration = var_12_18

					if var_12_18 + var_12_13 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_13
					end
				end

				arg_9_1.text_.text = var_12_16
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242002", "story_v_out_114242.awb") ~= 0 then
					local var_12_19 = manager.audio:GetVoiceLength("story_v_out_114242", "114242002", "story_v_out_114242.awb") / 1000

					if var_12_19 + var_12_13 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_13
					end

					if var_12_15.prefab_name ~= "" and arg_9_1.actors_[var_12_15.prefab_name] ~= nil then
						local var_12_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_15.prefab_name].transform, "story_v_out_114242", "114242002", "story_v_out_114242.awb")

						arg_9_1:RecordAudio("114242002", var_12_20)
						arg_9_1:RecordAudio("114242002", var_12_20)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114242", "114242002", "story_v_out_114242.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114242", "114242002", "story_v_out_114242.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_21 = math.max(var_12_14, arg_9_1.talkMaxDuration)

			if var_12_13 <= arg_9_1.time_ and arg_9_1.time_ < var_12_13 + var_12_21 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_13) / var_12_21

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_13 + var_12_21 and arg_9_1.time_ < var_12_13 + var_12_21 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114242003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114242003
		arg_13_1.duration_ = 13.63

		local var_13_0 = {
			ja = 13.633,
			ko = 11.733,
			zh = 13.133,
			en = 9.633
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
				arg_13_0:Play114242004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10018"]) and arg_13_1.var_.actorSpriteComps10018 == nil then
				arg_13_1.var_.actorSpriteComps10018 = arg_13_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10018"]) then
				if arg_13_1.var_.actorSpriteComps10018 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								iter_16_1.color = Color.New(Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_0), Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_0), (Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_0)))
							else
								local var_16_1 = Mathf.Lerp(iter_16_1.color.r, 1, (arg_13_1.time_ - 0) / var_16_0)

								iter_16_1.color = Color.New(var_16_1, var_16_1, var_16_1)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10018"]) and arg_13_1.var_.actorSpriteComps10018 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10018 = nil
			end

			local var_16_2 = arg_13_1.actors_["10015"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10015 == nil then
				arg_13_1.var_.actorSpriteComps10015 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps10015 then
					for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_16_5 then
							if arg_13_1.isInRecall_ then
								iter_16_5.color = Color.New(Mathf.Lerp(iter_16_5.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_5.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_5.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_5.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_5.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10015 then
				for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_16_7 then
						iter_16_7.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10015 = nil
			end

			local var_16_5 = arg_13_1.actors_["10018"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10018 = var_16_5.localPosition
				var_16_5.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10018", 2)

				for iter_16_8 = 0, var_16_5.childCount - 1 do
					local var_16_6 = var_16_5:GetChild(iter_16_8)

					if var_16_6.name == "split_1" or not string.find(var_16_6.name, "split") then
						var_16_6.gameObject:SetActive(true)
					else
						var_16_6.gameObject:SetActive(false)
					end
				end
			end

			local var_16_7 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_13_1.time_ - 0) / var_16_7)
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_16_8 = 0
			local var_16_9 = 1.125

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(114242003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 45 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 45)

				if (45 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 45)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242003", "story_v_out_114242.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_114242", "114242003", "story_v_out_114242.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_114242", "114242003", "story_v_out_114242.awb")

						arg_13_1:RecordAudio("114242003", var_16_15)
						arg_13_1:RecordAudio("114242003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114242", "114242003", "story_v_out_114242.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114242", "114242003", "story_v_out_114242.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114242004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114242004
		arg_17_1.duration_ = 7.9

		local var_17_0 = {
			ja = 7.4,
			ko = 7.5,
			zh = 7.9,
			en = 6.033
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
				arg_17_0:Play114242005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.9

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(114242004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 36)

				if (36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 36)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242004", "story_v_out_114242.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_114242", "114242004", "story_v_out_114242.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_114242", "114242004", "story_v_out_114242.awb")

						arg_17_1:RecordAudio("114242004", var_20_6)
						arg_17_1:RecordAudio("114242004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114242", "114242004", "story_v_out_114242.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114242", "114242004", "story_v_out_114242.awb")
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
	Play114242005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114242005
		arg_21_1.duration_ = 4.13

		local var_21_0 = {
			ja = 2.266,
			ko = 4.133,
			zh = 3.433,
			en = 2.7
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
				arg_21_0:Play114242006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10018"]) and arg_21_1.var_.actorSpriteComps10018 == nil then
				arg_21_1.var_.actorSpriteComps10018 = arg_21_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10018"]) then
				if arg_21_1.var_.actorSpriteComps10018 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10018"]) and arg_21_1.var_.actorSpriteComps10018 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10018 = nil
			end

			local var_24_2 = arg_21_1.actors_["10015"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10015 == nil then
				arg_21_1.var_.actorSpriteComps10015 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10015 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								iter_24_5.color = Color.New(Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_5.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_5.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10015 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_24_7 then
						iter_24_7.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10015 = nil
			end

			local var_24_5 = 0
			local var_24_6 = 0.4

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(114242005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 16 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 16)

				if (16 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 16)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242005", "story_v_out_114242.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_114242", "114242005", "story_v_out_114242.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_114242", "114242005", "story_v_out_114242.awb")

						arg_21_1:RecordAudio("114242005", var_24_12)
						arg_21_1:RecordAudio("114242005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114242", "114242005", "story_v_out_114242.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114242", "114242005", "story_v_out_114242.awb")
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

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114242006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114242006
		arg_25_1.duration_ = 12.1

		local var_25_0 = {
			ja = 10.966,
			ko = 11.666,
			zh = 11.033,
			en = 12.1
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
				arg_25_0:Play114242007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10018"]) and arg_25_1.var_.actorSpriteComps10018 == nil then
				arg_25_1.var_.actorSpriteComps10018 = arg_25_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10018"]) then
				if arg_25_1.var_.actorSpriteComps10018 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								iter_28_1.color = Color.New(Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_0), Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_0), (Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_0)))
							else
								local var_28_1 = Mathf.Lerp(iter_28_1.color.r, 1, (arg_25_1.time_ - 0) / var_28_0)

								iter_28_1.color = Color.New(var_28_1, var_28_1, var_28_1)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10018"]) and arg_25_1.var_.actorSpriteComps10018 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10018 = nil
			end

			local var_28_2 = arg_25_1.actors_["10015"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10015 == nil then
				arg_25_1.var_.actorSpriteComps10015 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10015 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								iter_28_5.color = Color.New(Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_5.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_5.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10015 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_28_7 then
						iter_28_7.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10015 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 1.15

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(114242006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 46 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 46)

				if (46 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 46)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242006", "story_v_out_114242.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_114242", "114242006", "story_v_out_114242.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_114242", "114242006", "story_v_out_114242.awb")

						arg_25_1:RecordAudio("114242006", var_28_12)
						arg_25_1:RecordAudio("114242006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114242", "114242006", "story_v_out_114242.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114242", "114242006", "story_v_out_114242.awb")
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

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114242007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114242007
		arg_29_1.duration_ = 5.2

		local var_29_0 = {
			ja = 5.2,
			ko = 4.6,
			zh = 4.166,
			en = 4.066
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
				arg_29_0:Play114242008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10018"]) and arg_29_1.var_.actorSpriteComps10018 == nil then
				arg_29_1.var_.actorSpriteComps10018 = arg_29_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10018"]) then
				if arg_29_1.var_.actorSpriteComps10018 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								iter_32_1.color = Color.New(Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_0), Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_0), (Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_0)))
							else
								local var_32_1 = Mathf.Lerp(iter_32_1.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_0)

								iter_32_1.color = Color.New(var_32_1, var_32_1, var_32_1)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10018"]) and arg_29_1.var_.actorSpriteComps10018 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10018 = nil
			end

			local var_32_2 = arg_29_1.actors_["10015"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10015 == nil then
				arg_29_1.var_.actorSpriteComps10015 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10015 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								iter_32_5.color = Color.New(Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_5.color.r, 1, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_5.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10015 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_32_7 then
						iter_32_7.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10015 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(114242007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 13 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 13)

				if (13 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 13)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242007", "story_v_out_114242.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_114242", "114242007", "story_v_out_114242.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_114242", "114242007", "story_v_out_114242.awb")

						arg_29_1:RecordAudio("114242007", var_32_12)
						arg_29_1:RecordAudio("114242007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114242", "114242007", "story_v_out_114242.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114242", "114242007", "story_v_out_114242.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_6, arg_29_1.talkMaxDuration)

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_5) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_5 + var_32_13 and arg_29_1.time_ < var_32_5 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114242008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114242008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play114242009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10015"]) and arg_33_1.var_.actorSpriteComps10015 == nil then
				arg_33_1.var_.actorSpriteComps10015 = arg_33_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10015"]) then
				if arg_33_1.var_.actorSpriteComps10015 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								iter_36_1.color = Color.New(Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_0), Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_0), (Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_0)))
							else
								local var_36_1 = Mathf.Lerp(iter_36_1.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_0)

								iter_36_1.color = Color.New(var_36_1, var_36_1, var_36_1)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10015"]) and arg_33_1.var_.actorSpriteComps10015 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10015 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 0.575

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(114242008).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 23 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 23)

				if (23 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 23)) > 0 and var_36_3 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_7 and arg_33_1.time_ < var_36_2 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114242009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114242009
		arg_37_1.duration_ = 4

		local var_37_0 = {
			ja = 3.233,
			ko = 4,
			zh = 3.466,
			en = 2.6
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
				arg_37_0:Play114242010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10015"]) and arg_37_1.var_.actorSpriteComps10015 == nil then
				arg_37_1.var_.actorSpriteComps10015 = arg_37_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10015"]) then
				if arg_37_1.var_.actorSpriteComps10015 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 1, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10015"]) and arg_37_1.var_.actorSpriteComps10015 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10015 = nil
			end

			local var_40_2 = arg_37_1.actors_["10015"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10015 = var_40_2.localPosition
				var_40_2.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10015", 4)

				for iter_40_4 = 0, var_40_2.childCount - 1 do
					local var_40_3 = var_40_2:GetChild(iter_40_4)

					if var_40_3.name == "split_1" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_2.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_37_1.time_ - 0) / var_40_4)
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_40_5 = 0
			local var_40_6 = 0.325

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(114242009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 13 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 13)

				if (13 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 13)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242009", "story_v_out_114242.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_114242", "114242009", "story_v_out_114242.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_114242", "114242009", "story_v_out_114242.awb")

						arg_37_1:RecordAudio("114242009", var_40_12)
						arg_37_1:RecordAudio("114242009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114242", "114242009", "story_v_out_114242.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114242", "114242009", "story_v_out_114242.awb")
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
				actorName = "10015",
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
	Play114242010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114242010
		arg_41_1.duration_ = 2.83

		local var_41_0 = {
			ja = 2.5,
			ko = 2.833,
			zh = 2.333,
			en = 2.066
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
				arg_41_0:Play114242011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10018"]) and arg_41_1.var_.actorSpriteComps10018 == nil then
				arg_41_1.var_.actorSpriteComps10018 = arg_41_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10018"]) then
				if arg_41_1.var_.actorSpriteComps10018 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 1, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10018"]) and arg_41_1.var_.actorSpriteComps10018 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10018 = nil
			end

			local var_44_2 = arg_41_1.actors_["10015"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10015 == nil then
				arg_41_1.var_.actorSpriteComps10015 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10015 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_5.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_5.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10015 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10015 = nil
			end

			local var_44_5 = 0
			local var_44_6 = 0.175

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(114242010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 7 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 7)

				if (7 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 7)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242010", "story_v_out_114242.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_114242", "114242010", "story_v_out_114242.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_114242", "114242010", "story_v_out_114242.awb")

						arg_41_1:RecordAudio("114242010", var_44_12)
						arg_41_1:RecordAudio("114242010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114242", "114242010", "story_v_out_114242.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114242", "114242010", "story_v_out_114242.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_6, arg_41_1.talkMaxDuration)

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_5) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_5 + var_44_13 and arg_41_1.time_ < var_44_5 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114242011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114242011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play114242012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10018"]) and arg_45_1.var_.actorSpriteComps10018 == nil then
				arg_45_1.var_.actorSpriteComps10018 = arg_45_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10018"]) then
				if arg_45_1.var_.actorSpriteComps10018 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								iter_48_1.color = Color.New(Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_0), Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_0), (Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_0)))
							else
								local var_48_1 = Mathf.Lerp(iter_48_1.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_0)

								iter_48_1.color = Color.New(var_48_1, var_48_1, var_48_1)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10018"]) and arg_45_1.var_.actorSpriteComps10018 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10018 = nil
			end

			local var_48_2 = 0
			local var_48_3 = 0.6

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(114242011).content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 24 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 24)

				if (24 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 24)) > 0 and var_48_3 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_7 and arg_45_1.time_ < var_48_2 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114242012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114242012
		arg_49_1.duration_ = 5.9

		local var_49_0 = {
			ja = 5.9,
			ko = 5.533,
			zh = 4.5,
			en = 4.966
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
				arg_49_0:Play114242013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10018"]) and arg_49_1.var_.actorSpriteComps10018 == nil then
				arg_49_1.var_.actorSpriteComps10018 = arg_49_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10018"]) then
				if arg_49_1.var_.actorSpriteComps10018 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 1, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10018"]) and arg_49_1.var_.actorSpriteComps10018 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps10018 = nil
			end

			local var_52_2 = 0
			local var_52_3 = 0.65

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(114242012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 26 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 26)

				if (26 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 26)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242012", "story_v_out_114242.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242012", "story_v_out_114242.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_114242", "114242012", "story_v_out_114242.awb")

						arg_49_1:RecordAudio("114242012", var_52_9)
						arg_49_1:RecordAudio("114242012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114242", "114242012", "story_v_out_114242.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114242", "114242012", "story_v_out_114242.awb")
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
	Play114242013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114242013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play114242014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10018"]) and arg_53_1.var_.actorSpriteComps10018 == nil then
				arg_53_1.var_.actorSpriteComps10018 = arg_53_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10018"]) then
				if arg_53_1.var_.actorSpriteComps10018 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10018"]) and arg_53_1.var_.actorSpriteComps10018 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps10018 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 1.325

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

				local var_56_4 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(114242013).content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 53 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 53)

				if (53 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 53)) > 0 and var_56_3 < var_56_6 then
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
	Play114242014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114242014
		arg_57_1.duration_ = 4.9

		local var_57_0 = {
			ja = 3.966,
			ko = 4.9,
			zh = 4,
			en = 2.866
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
				arg_57_0:Play114242015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10015"]) and arg_57_1.var_.actorSpriteComps10015 == nil then
				arg_57_1.var_.actorSpriteComps10015 = arg_57_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10015"]) then
				if arg_57_1.var_.actorSpriteComps10015 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 1, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10015"]) and arg_57_1.var_.actorSpriteComps10015 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10015 = nil
			end

			local var_60_2 = 0
			local var_60_3 = 0.325

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(114242014)
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

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242014", "story_v_out_114242.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242014", "story_v_out_114242.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_114242", "114242014", "story_v_out_114242.awb")

						arg_57_1:RecordAudio("114242014", var_60_9)
						arg_57_1:RecordAudio("114242014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114242", "114242014", "story_v_out_114242.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114242", "114242014", "story_v_out_114242.awb")
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
	Play114242015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114242015
		arg_61_1.duration_ = 12.07

		local var_61_0 = {
			ja = 9.533,
			ko = 12.066,
			zh = 11.866,
			en = 11.366
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
				arg_61_0:Play114242016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if arg_61_1.bgs_.F01a == nil then
				local var_64_0 = Object.Instantiate(arg_61_1.paintGo_)

				var_64_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01a")
				var_64_0.name = "F01a"
				var_64_0.transform.parent = arg_61_1.stage_.transform
				var_64_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.bgs_.F01a = var_64_0
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_1 = arg_61_1.bgs_.F01a

				arg_61_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_64_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_2 = var_64_1:GetComponent("SpriteRenderer")

				if var_64_2 and var_64_2.sprite then
					local var_64_3 = 2 * (var_64_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_64_1.transform.localScale = Vector3.New(var_64_3 / var_64_2.sprite.bounds.size.y < var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x and var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x or var_64_3 / var_64_2.sprite.bounds.size.y, var_64_3 / var_64_2.sprite.bounds.size.y < var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x and var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x or var_64_3 / var_64_2.sprite.bounds.size.y, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "F01a" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_4 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_5 = 2

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_5 then
				local var_64_6 = Color.New(1, 1, 1)

				var_64_6.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_4) / var_64_5)
				arg_61_1.mask_.color = var_64_6
			end

			if arg_61_1.time_ >= var_64_4 + var_64_5 and arg_61_1.time_ < var_64_4 + var_64_5 + arg_64_0 then
				local var_64_7 = Color.New(1, 1, 1)

				arg_61_1.mask_.enabled = false
				var_64_7.a = 0
				arg_61_1.mask_.color = var_64_7
			end

			local var_64_8 = arg_61_1.actors_["10018"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10018 = var_64_8.localPosition
				var_64_8.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10018", 7)

				for iter_64_2 = 0, var_64_8.childCount - 1 do
					local var_64_9 = var_64_8:GetChild(iter_64_2)

					if var_64_9.name == "split_1" or not string.find(var_64_9.name, "split") then
						var_64_9.gameObject:SetActive(true)
					else
						var_64_9.gameObject:SetActive(false)
					end
				end
			end

			local var_64_10 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_10 then
				var_64_8.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10018, Vector3.New(0, -2000, -180), (arg_61_1.time_ - 0) / var_64_10)
			end

			if arg_61_1.time_ >= 0 + var_64_10 and arg_61_1.time_ < 0 + var_64_10 + arg_64_0 then
				var_64_8.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_64_11 = arg_61_1.actors_["10015"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10015 = var_64_11.localPosition
				var_64_11.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10015", 7)

				for iter_64_3 = 0, var_64_11.childCount - 1 do
					local var_64_12 = var_64_11:GetChild(iter_64_3)

					if var_64_12.name == "split_1" or not string.find(var_64_12.name, "split") then
						var_64_12.gameObject:SetActive(true)
					else
						var_64_12.gameObject:SetActive(false)
					end
				end
			end

			local var_64_13 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_13 then
				var_64_11.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10015, Vector3.New(0, -2000, 450), (arg_61_1.time_ - 0) / var_64_13)
			end

			if arg_61_1.time_ >= 0 + var_64_13 and arg_61_1.time_ < 0 + var_64_13 + arg_64_0 then
				var_64_11.localPosition = Vector3.New(0, -2000, 450)
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_14 = 2
			local var_64_15 = 1.175

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_16 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_16:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_17 = arg_61_1:GetWordFromCfg(114242015)
				local var_64_18 = arg_61_1:FormatText(var_64_17.content)

				arg_61_1.text_.text = var_64_18

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 46 <= 0 and var_64_15 or var_64_15 * (utf8.len(var_64_18) / 46)

				if (46 <= 0 and var_64_15 or var_64_15 * (utf8.len(var_64_18) / 46)) > 0 and var_64_15 < var_64_20 then
					arg_61_1.talkMaxDuration = var_64_20
					var_64_14 = var_64_14 + 0.3

					if var_64_20 + var_64_14 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_14
					end
				end

				arg_61_1.text_.text = var_64_18
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242015", "story_v_out_114242.awb") ~= 0 then
					local var_64_21 = manager.audio:GetVoiceLength("story_v_out_114242", "114242015", "story_v_out_114242.awb") / 1000

					if var_64_21 + var_64_14 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_21 + var_64_14
					end

					if var_64_17.prefab_name ~= "" and arg_61_1.actors_[var_64_17.prefab_name] ~= nil then
						local var_64_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_17.prefab_name].transform, "story_v_out_114242", "114242015", "story_v_out_114242.awb")

						arg_61_1:RecordAudio("114242015", var_64_22)
						arg_61_1:RecordAudio("114242015", var_64_22)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114242", "114242015", "story_v_out_114242.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114242", "114242015", "story_v_out_114242.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_23 = var_64_14 + 0.3
			local var_64_24 = math.max(var_64_15, arg_61_1.talkMaxDuration)

			if var_64_14 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_24 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_23) / var_64_24

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_23 + var_64_24 and arg_61_1.time_ < var_64_23 + var_64_24 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10015",
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
	Play114242016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 114242016
		arg_67_1.duration_ = 1.57

		local var_67_0 = {
			ja = 1.4,
			ko = 0.999999999999,
			zh = 1.133,
			en = 1.566
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play114242017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.075

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104201")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(114242016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 3 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 3)

				if (3 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 3)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242016", "story_v_out_114242.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_114242", "114242016", "story_v_out_114242.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_114242", "114242016", "story_v_out_114242.awb")

						arg_67_1:RecordAudio("114242016", var_70_6)
						arg_67_1:RecordAudio("114242016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_114242", "114242016", "story_v_out_114242.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_114242", "114242016", "story_v_out_114242.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play114242017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 114242017
		arg_71_1.duration_ = 1.83

		local var_71_0 = {
			ja = 1.833,
			ko = 1.5,
			zh = 1.6,
			en = 1.133
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
				arg_71_0:Play114242018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.1

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:GetWordFromCfg(114242017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 4 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 4)

				if (4 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 4)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242017", "story_v_out_114242.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_114242", "114242017", "story_v_out_114242.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_114242", "114242017", "story_v_out_114242.awb")

						arg_71_1:RecordAudio("114242017", var_74_6)
						arg_71_1:RecordAudio("114242017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_114242", "114242017", "story_v_out_114242.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_114242", "114242017", "story_v_out_114242.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play114242018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 114242018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play114242019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.025

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(114242018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 41 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 41)

				if (41 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 41)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play114242019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 114242019
		arg_79_1.duration_ = 6.5

		local var_79_0 = {
			ja = 6.5,
			ko = 4.633,
			zh = 5.4,
			en = 3.533
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
				arg_79_0:Play114242020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10018 = arg_79_1.actors_["10018"].transform.localPosition
				arg_79_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10018", 2)

				for iter_82_0 = 0, arg_79_1.actors_["10018"].transform.childCount - 1 do
					local var_82_0 = arg_79_1.actors_["10018"].transform:GetChild(iter_82_0)

					if var_82_0.name == "split_1" or not string.find(var_82_0.name, "split") then
						var_82_0.gameObject:SetActive(true)
					else
						var_82_0.gameObject:SetActive(false)
					end
				end
			end

			local var_82_1 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				arg_79_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_79_1.time_ - 0) / var_82_1)
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				arg_79_1.actors_["10018"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_82_2 = arg_79_1.actors_["10018"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10018 == nil then
				arg_79_1.var_.actorSpriteComps10018 = var_82_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_3 = 0.034

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.actorSpriteComps10018 then
					for iter_82_1, iter_82_2 in pairs(arg_79_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10018 then
				for iter_82_3, iter_82_4 in pairs(arg_79_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_82_4 then
						iter_82_4.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps10018 = nil
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				local var_82_5 = arg_79_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_82_5 then
					arg_79_1.var_.alphaOldValue10018 = var_82_5.alpha
					arg_79_1.var_.characterEffect10018 = var_82_5
				end

				arg_79_1.var_.alphaOldValue10018 = 0
			end

			local var_82_6 = 0.5

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_6 then
				if arg_79_1.var_.characterEffect10018 then
					arg_79_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_79_1.var_.alphaOldValue10018, 1, (arg_79_1.time_ - 0) / var_82_6)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_6 and arg_79_1.time_ < 0 + var_82_6 + arg_82_0 and arg_79_1.var_.characterEffect10018 then
				arg_79_1.var_.characterEffect10018.alpha = 1
			end

			local var_82_7 = 0
			local var_82_8 = 0.575

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_9 = arg_79_1:GetWordFromCfg(114242019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_12 = 23 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_10) / 23)

				if (23 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_10) / 23)) > 0 and var_82_8 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_7
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242019", "story_v_out_114242.awb") ~= 0 then
					local var_82_13 = manager.audio:GetVoiceLength("story_v_out_114242", "114242019", "story_v_out_114242.awb") / 1000

					if var_82_13 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_7
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_out_114242", "114242019", "story_v_out_114242.awb")

						arg_79_1:RecordAudio("114242019", var_82_14)
						arg_79_1:RecordAudio("114242019", var_82_14)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_114242", "114242019", "story_v_out_114242.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_114242", "114242019", "story_v_out_114242.awb")
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
				actorName = "10018",
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
	Play114242020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 114242020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play114242021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["10018"]) and arg_83_1.var_.actorSpriteComps10018 == nil then
				arg_83_1.var_.actorSpriteComps10018 = arg_83_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_0 = 0.034

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["10018"]) then
				if arg_83_1.var_.actorSpriteComps10018 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								iter_86_1.color = Color.New(Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor2.r, (arg_83_1.time_ - 0) / var_86_0), Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor2.g, (arg_83_1.time_ - 0) / var_86_0), (Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor2.b, (arg_83_1.time_ - 0) / var_86_0)))
							else
								local var_86_1 = Mathf.Lerp(iter_86_1.color.r, 0.5, (arg_83_1.time_ - 0) / var_86_0)

								iter_86_1.color = Color.New(var_86_1, var_86_1, var_86_1)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["10018"]) and arg_83_1.var_.actorSpriteComps10018 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_86_3 then
						iter_86_3.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_83_1.var_.actorSpriteComps10018 = nil
			end

			local var_86_2 = 0
			local var_86_3 = 1.625

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_4 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(114242020).content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 64 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_4) / 64)

				if (64 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_4) / 64)) > 0 and var_86_3 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_7 and arg_83_1.time_ < var_86_2 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play114242021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 114242021
		arg_87_1.duration_ = 16.77

		local var_87_0 = {
			ja = 7.866,
			ko = 10.266,
			zh = 16.766,
			en = 11.8
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
				arg_87_0:Play114242022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.actors_["104201_1"] == nil then
				local var_90_0 = Object.Instantiate(arg_87_1.imageGo_, arg_87_1.canvasGo_.transform)

				var_90_0.transform:SetSiblingIndex(1)

				var_90_0.name = "104201_1"

				local var_90_1 = var_90_0:GetComponent(typeof(Image))

				var_90_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "104201_1")

				var_90_1:SetNativeSize()

				var_90_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_87_1.actors_["104201_1"] = var_90_0
			end

			local var_90_2 = arg_87_1.actors_["104201_1"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos104201_1 = var_90_2.localPosition
				var_90_2.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("104201_1", 4)
			end

			local var_90_3 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 then
				var_90_2.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos104201_1, Vector3.New(390, -350, -180), (arg_87_1.time_ - 0) / var_90_3)
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 then
				var_90_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_90_4 = arg_87_1.actors_["104201_1"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_4) then
				local var_90_5 = var_90_4:GetComponent("Image")

				if var_90_5 then
					arg_87_1.var_.highlightMatValue104201_1 = var_90_5
				end
			end

			local var_90_6 = 0.034

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_6 and not isNil(var_90_4) then
				if arg_87_1.var_.highlightMatValue104201_1 then
					local var_90_7 = Mathf.Lerp(0.5, 1, (arg_87_1.time_ - 0) / var_90_6)

					arg_87_1.var_.highlightMatValue104201_1.color.r = var_90_7
					arg_87_1.var_.highlightMatValue104201_1.color.g = var_90_7
					arg_87_1.var_.highlightMatValue104201_1.color.b = var_90_7
					arg_87_1.var_.highlightMatValue104201_1.color = arg_87_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_87_1.time_ >= 0 + var_90_6 and arg_87_1.time_ < 0 + var_90_6 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.highlightMatValue104201_1 then
				var_90_4.transform:SetSiblingIndex(1)

				arg_87_1.var_.highlightMatValue104201_1.color.r = 1
				arg_87_1.var_.highlightMatValue104201_1.color.g = 1
				arg_87_1.var_.highlightMatValue104201_1.color.b = 1
				arg_87_1.var_.highlightMatValue104201_1.color = arg_87_1.var_.highlightMatValue104201_1.color
			end

			local var_90_8 = "104201"

			if arg_87_1.actors_["104201"] == nil then
				local var_90_9 = Object.Instantiate(arg_87_1.imageGo_, arg_87_1.canvasGo_.transform)

				var_90_9.transform:SetSiblingIndex(1)

				var_90_9.name = var_90_8

				local var_90_10 = var_90_9:GetComponent(typeof(Image))

				var_90_10.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "104201")

				var_90_10:SetNativeSize()

				var_90_9.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_87_1.actors_[var_90_8] = var_90_9
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				local var_90_11 = arg_87_1.actors_["104201"]:GetComponent("Image")

				if var_90_11 then
					arg_87_1.var_.alphaMatValue104201 = var_90_11
					arg_87_1.var_.alphaOldValue104201 = var_90_11.color.a
				end

				arg_87_1.var_.alphaOldValue104201 = 0
			end

			local var_90_12 = 0.5

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_12 then
				if arg_87_1.var_.alphaMatValue104201 then
					arg_87_1.var_.alphaMatValue104201.color.a = Mathf.Lerp(arg_87_1.var_.alphaOldValue104201, 1, (arg_87_1.time_ - 0) / var_90_12)
					arg_87_1.var_.alphaMatValue104201.color = arg_87_1.var_.alphaMatValue104201.color
				end
			end

			if arg_87_1.time_ >= 0 + var_90_12 and arg_87_1.time_ < 0 + var_90_12 + arg_90_0 and arg_87_1.var_.alphaMatValue104201 then
				arg_87_1.var_.alphaMatValue104201.color.a = 1
				arg_87_1.var_.alphaMatValue104201.color = arg_87_1.var_.alphaMatValue104201.color
			end

			local var_90_13 = 0
			local var_90_14 = 1.775

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_15 = arg_87_1:GetWordFromCfg(114242021)
				local var_90_16 = arg_87_1:FormatText(var_90_15.content)

				arg_87_1.text_.text = var_90_16

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_18 = 70 <= 0 and var_90_14 or var_90_14 * (utf8.len(var_90_16) / 70)

				if (70 <= 0 and var_90_14 or var_90_14 * (utf8.len(var_90_16) / 70)) > 0 and var_90_14 < var_90_18 then
					arg_87_1.talkMaxDuration = var_90_18

					if var_90_18 + var_90_13 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_18 + var_90_13
					end
				end

				arg_87_1.text_.text = var_90_16
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242021", "story_v_out_114242.awb") ~= 0 then
					local var_90_19 = manager.audio:GetVoiceLength("story_v_out_114242", "114242021", "story_v_out_114242.awb") / 1000

					if var_90_19 + var_90_13 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_19 + var_90_13
					end

					if var_90_15.prefab_name ~= "" and arg_87_1.actors_[var_90_15.prefab_name] ~= nil then
						local var_90_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_15.prefab_name].transform, "story_v_out_114242", "114242021", "story_v_out_114242.awb")

						arg_87_1:RecordAudio("114242021", var_90_20)
						arg_87_1:RecordAudio("114242021", var_90_20)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_114242", "114242021", "story_v_out_114242.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_114242", "114242021", "story_v_out_114242.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_21 = math.max(var_90_14, arg_87_1.talkMaxDuration)

			if var_90_13 <= arg_87_1.time_ and arg_87_1.time_ < var_90_13 + var_90_21 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_13) / var_90_21

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_13 + var_90_21 and arg_87_1.time_ < var_90_13 + var_90_21 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104201_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play114242022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 114242022
		arg_91_1.duration_ = 18.53

		local var_91_0 = {
			ja = 13.333,
			ko = 11.7,
			zh = 16.6,
			en = 18.533
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
				arg_91_0:Play114242023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["10018"]) and arg_91_1.var_.actorSpriteComps10018 == nil then
				arg_91_1.var_.actorSpriteComps10018 = arg_91_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_0 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["10018"]) then
				if arg_91_1.var_.actorSpriteComps10018 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								iter_94_1.color = Color.New(Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor1.r, (arg_91_1.time_ - 0) / var_94_0), Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor1.g, (arg_91_1.time_ - 0) / var_94_0), (Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor1.b, (arg_91_1.time_ - 0) / var_94_0)))
							else
								local var_94_1 = Mathf.Lerp(iter_94_1.color.r, 1, (arg_91_1.time_ - 0) / var_94_0)

								iter_94_1.color = Color.New(var_94_1, var_94_1, var_94_1)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["10018"]) and arg_91_1.var_.actorSpriteComps10018 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_94_3 then
						iter_94_3.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps10018 = nil
			end

			local var_94_2 = arg_91_1.actors_["104201_1"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) then
				local var_94_3 = var_94_2:GetComponent("Image")

				if var_94_3 then
					arg_91_1.var_.highlightMatValue104201_1 = var_94_3
				end
			end

			local var_94_4 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 and not isNil(var_94_2) then
				if arg_91_1.var_.highlightMatValue104201_1 then
					local var_94_5 = Mathf.Lerp(1, 0.5, (arg_91_1.time_ - 0) / var_94_4)

					arg_91_1.var_.highlightMatValue104201_1.color.r = var_94_5
					arg_91_1.var_.highlightMatValue104201_1.color.g = var_94_5
					arg_91_1.var_.highlightMatValue104201_1.color.b = var_94_5
					arg_91_1.var_.highlightMatValue104201_1.color = arg_91_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.highlightMatValue104201_1 then
				arg_91_1.var_.highlightMatValue104201_1.color.r = 0.5
				arg_91_1.var_.highlightMatValue104201_1.color.g = 0.5
				arg_91_1.var_.highlightMatValue104201_1.color.b = 0.5
				arg_91_1.var_.highlightMatValue104201_1.color = arg_91_1.var_.highlightMatValue104201_1.color
			end

			local var_94_6 = 0
			local var_94_7 = 2.05

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_8 = arg_91_1:GetWordFromCfg(114242022)
				local var_94_9 = arg_91_1:FormatText(var_94_8.content)

				arg_91_1.text_.text = var_94_9

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 79 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 79)

				if (79 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 79)) > 0 and var_94_7 < var_94_11 then
					arg_91_1.talkMaxDuration = var_94_11

					if var_94_11 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_9
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242022", "story_v_out_114242.awb") ~= 0 then
					local var_94_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242022", "story_v_out_114242.awb") / 1000

					if var_94_12 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_6
					end

					if var_94_8.prefab_name ~= "" and arg_91_1.actors_[var_94_8.prefab_name] ~= nil then
						local var_94_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_8.prefab_name].transform, "story_v_out_114242", "114242022", "story_v_out_114242.awb")

						arg_91_1:RecordAudio("114242022", var_94_13)
						arg_91_1:RecordAudio("114242022", var_94_13)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_114242", "114242022", "story_v_out_114242.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_114242", "114242022", "story_v_out_114242.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_14 and arg_91_1.time_ < var_94_6 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play114242023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 114242023
		arg_95_1.duration_ = 13.7

		local var_95_0 = {
			ja = 13.7,
			ko = 7.6,
			zh = 9.266,
			en = 10.633
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play114242024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["10018"]) and arg_95_1.var_.actorSpriteComps10018 == nil then
				arg_95_1.var_.actorSpriteComps10018 = arg_95_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_0 = 0.034

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["10018"]) then
				if arg_95_1.var_.actorSpriteComps10018 then
					for iter_98_0, iter_98_1 in pairs(arg_95_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_98_1 then
							if arg_95_1.isInRecall_ then
								iter_98_1.color = Color.New(Mathf.Lerp(iter_98_1.color.r, arg_95_1.hightColor2.r, (arg_95_1.time_ - 0) / var_98_0), Mathf.Lerp(iter_98_1.color.g, arg_95_1.hightColor2.g, (arg_95_1.time_ - 0) / var_98_0), (Mathf.Lerp(iter_98_1.color.b, arg_95_1.hightColor2.b, (arg_95_1.time_ - 0) / var_98_0)))
							else
								local var_98_1 = Mathf.Lerp(iter_98_1.color.r, 0.5, (arg_95_1.time_ - 0) / var_98_0)

								iter_98_1.color = Color.New(var_98_1, var_98_1, var_98_1)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["10018"]) and arg_95_1.var_.actorSpriteComps10018 then
				for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_98_3 then
						iter_98_3.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps10018 = nil
			end

			local var_98_2 = arg_95_1.actors_["104201_1"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) then
				local var_98_3 = var_98_2:GetComponent("Image")

				if var_98_3 then
					arg_95_1.var_.highlightMatValue104201_1 = var_98_3
				end
			end

			local var_98_4 = 0.034

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 and not isNil(var_98_2) then
				if arg_95_1.var_.highlightMatValue104201_1 then
					local var_98_5 = Mathf.Lerp(0.5, 1, (arg_95_1.time_ - 0) / var_98_4)

					arg_95_1.var_.highlightMatValue104201_1.color.r = var_98_5
					arg_95_1.var_.highlightMatValue104201_1.color.g = var_98_5
					arg_95_1.var_.highlightMatValue104201_1.color.b = var_98_5
					arg_95_1.var_.highlightMatValue104201_1.color = arg_95_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.highlightMatValue104201_1 then
				var_98_2.transform:SetSiblingIndex(1)

				arg_95_1.var_.highlightMatValue104201_1.color.r = 1
				arg_95_1.var_.highlightMatValue104201_1.color.g = 1
				arg_95_1.var_.highlightMatValue104201_1.color.b = 1
				arg_95_1.var_.highlightMatValue104201_1.color = arg_95_1.var_.highlightMatValue104201_1.color
			end

			local var_98_6 = 0
			local var_98_7 = 0.825

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_8 = arg_95_1:GetWordFromCfg(114242023)
				local var_98_9 = arg_95_1:FormatText(var_98_8.content)

				arg_95_1.text_.text = var_98_9

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 33 <= 0 and var_98_7 or var_98_7 * (utf8.len(var_98_9) / 33)

				if (33 <= 0 and var_98_7 or var_98_7 * (utf8.len(var_98_9) / 33)) > 0 and var_98_7 < var_98_11 then
					arg_95_1.talkMaxDuration = var_98_11

					if var_98_11 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_11 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_9
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242023", "story_v_out_114242.awb") ~= 0 then
					local var_98_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242023", "story_v_out_114242.awb") / 1000

					if var_98_12 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_12 + var_98_6
					end

					if var_98_8.prefab_name ~= "" and arg_95_1.actors_[var_98_8.prefab_name] ~= nil then
						local var_98_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_8.prefab_name].transform, "story_v_out_114242", "114242023", "story_v_out_114242.awb")

						arg_95_1:RecordAudio("114242023", var_98_13)
						arg_95_1:RecordAudio("114242023", var_98_13)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_114242", "114242023", "story_v_out_114242.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_114242", "114242023", "story_v_out_114242.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_14 and arg_95_1.time_ < var_98_6 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play114242024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 114242024
		arg_99_1.duration_ = 10.03

		local var_99_0 = {
			ja = 10.033,
			ko = 7.566,
			zh = 9.066,
			en = 8.333
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
				arg_99_0:Play114242025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["10018"]) and arg_99_1.var_.actorSpriteComps10018 == nil then
				arg_99_1.var_.actorSpriteComps10018 = arg_99_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_0 = 0.034

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["10018"]) then
				if arg_99_1.var_.actorSpriteComps10018 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								iter_102_1.color = Color.New(Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor1.r, (arg_99_1.time_ - 0) / var_102_0), Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor1.g, (arg_99_1.time_ - 0) / var_102_0), (Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor1.b, (arg_99_1.time_ - 0) / var_102_0)))
							else
								local var_102_1 = Mathf.Lerp(iter_102_1.color.r, 1, (arg_99_1.time_ - 0) / var_102_0)

								iter_102_1.color = Color.New(var_102_1, var_102_1, var_102_1)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["10018"]) and arg_99_1.var_.actorSpriteComps10018 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_102_3 then
						iter_102_3.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_99_1.var_.actorSpriteComps10018 = nil
			end

			local var_102_2 = arg_99_1.actors_["104201_1"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_2) then
				local var_102_3 = var_102_2:GetComponent("Image")

				if var_102_3 then
					arg_99_1.var_.highlightMatValue104201_1 = var_102_3
				end
			end

			local var_102_4 = 0.034

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 and not isNil(var_102_2) then
				if arg_99_1.var_.highlightMatValue104201_1 then
					local var_102_5 = Mathf.Lerp(1, 0.5, (arg_99_1.time_ - 0) / var_102_4)

					arg_99_1.var_.highlightMatValue104201_1.color.r = var_102_5
					arg_99_1.var_.highlightMatValue104201_1.color.g = var_102_5
					arg_99_1.var_.highlightMatValue104201_1.color.b = var_102_5
					arg_99_1.var_.highlightMatValue104201_1.color = arg_99_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.highlightMatValue104201_1 then
				arg_99_1.var_.highlightMatValue104201_1.color.r = 0.5
				arg_99_1.var_.highlightMatValue104201_1.color.g = 0.5
				arg_99_1.var_.highlightMatValue104201_1.color.b = 0.5
				arg_99_1.var_.highlightMatValue104201_1.color = arg_99_1.var_.highlightMatValue104201_1.color
			end

			local var_102_6 = 0
			local var_102_7 = 0.875

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:GetWordFromCfg(114242024)
				local var_102_9 = arg_99_1:FormatText(var_102_8.content)

				arg_99_1.text_.text = var_102_9

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 35 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 35)

				if (35 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 35)) > 0 and var_102_7 < var_102_11 then
					arg_99_1.talkMaxDuration = var_102_11

					if var_102_11 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_9
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242024", "story_v_out_114242.awb") ~= 0 then
					local var_102_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242024", "story_v_out_114242.awb") / 1000

					if var_102_12 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_6
					end

					if var_102_8.prefab_name ~= "" and arg_99_1.actors_[var_102_8.prefab_name] ~= nil then
						local var_102_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_8.prefab_name].transform, "story_v_out_114242", "114242024", "story_v_out_114242.awb")

						arg_99_1:RecordAudio("114242024", var_102_13)
						arg_99_1:RecordAudio("114242024", var_102_13)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_114242", "114242024", "story_v_out_114242.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_114242", "114242024", "story_v_out_114242.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_14 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_14 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_14

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_14 and arg_99_1.time_ < var_102_6 + var_102_14 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play114242025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 114242025
		arg_103_1.duration_ = 10.67

		local var_103_0 = {
			ja = 10.666,
			ko = 6.8,
			zh = 9.7,
			en = 8.4
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
				arg_103_0:Play114242026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["10018"]) and arg_103_1.var_.actorSpriteComps10018 == nil then
				arg_103_1.var_.actorSpriteComps10018 = arg_103_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.034

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["10018"]) then
				if arg_103_1.var_.actorSpriteComps10018 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								iter_106_1.color = Color.New(Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor2.r, (arg_103_1.time_ - 0) / var_106_0), Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor2.g, (arg_103_1.time_ - 0) / var_106_0), (Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor2.b, (arg_103_1.time_ - 0) / var_106_0)))
							else
								local var_106_1 = Mathf.Lerp(iter_106_1.color.r, 0.5, (arg_103_1.time_ - 0) / var_106_0)

								iter_106_1.color = Color.New(var_106_1, var_106_1, var_106_1)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["10018"]) and arg_103_1.var_.actorSpriteComps10018 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_103_1.var_.actorSpriteComps10018 = nil
			end

			local var_106_2 = arg_103_1.actors_["104201_1"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) then
				local var_106_3 = var_106_2:GetComponent("Image")

				if var_106_3 then
					arg_103_1.var_.highlightMatValue104201_1 = var_106_3
				end
			end

			local var_106_4 = 0.034

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 and not isNil(var_106_2) then
				if arg_103_1.var_.highlightMatValue104201_1 then
					local var_106_5 = Mathf.Lerp(0.5, 1, (arg_103_1.time_ - 0) / var_106_4)

					arg_103_1.var_.highlightMatValue104201_1.color.r = var_106_5
					arg_103_1.var_.highlightMatValue104201_1.color.g = var_106_5
					arg_103_1.var_.highlightMatValue104201_1.color.b = var_106_5
					arg_103_1.var_.highlightMatValue104201_1.color = arg_103_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.highlightMatValue104201_1 then
				var_106_2.transform:SetSiblingIndex(1)

				arg_103_1.var_.highlightMatValue104201_1.color.r = 1
				arg_103_1.var_.highlightMatValue104201_1.color.g = 1
				arg_103_1.var_.highlightMatValue104201_1.color.b = 1
				arg_103_1.var_.highlightMatValue104201_1.color = arg_103_1.var_.highlightMatValue104201_1.color
			end

			local var_106_6 = 0
			local var_106_7 = 0.875

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_8 = arg_103_1:GetWordFromCfg(114242025)
				local var_106_9 = arg_103_1:FormatText(var_106_8.content)

				arg_103_1.text_.text = var_106_9

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_11 = 35 <= 0 and var_106_7 or var_106_7 * (utf8.len(var_106_9) / 35)

				if (35 <= 0 and var_106_7 or var_106_7 * (utf8.len(var_106_9) / 35)) > 0 and var_106_7 < var_106_11 then
					arg_103_1.talkMaxDuration = var_106_11

					if var_106_11 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_9
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242025", "story_v_out_114242.awb") ~= 0 then
					local var_106_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242025", "story_v_out_114242.awb") / 1000

					if var_106_12 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_12 + var_106_6
					end

					if var_106_8.prefab_name ~= "" and arg_103_1.actors_[var_106_8.prefab_name] ~= nil then
						local var_106_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_8.prefab_name].transform, "story_v_out_114242", "114242025", "story_v_out_114242.awb")

						arg_103_1:RecordAudio("114242025", var_106_13)
						arg_103_1:RecordAudio("114242025", var_106_13)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_114242", "114242025", "story_v_out_114242.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_114242", "114242025", "story_v_out_114242.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_14 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_14 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_14

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_14 and arg_103_1.time_ < var_106_6 + var_106_14 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play114242026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114242026
		arg_107_1.duration_ = 4.23

		local var_107_0 = {
			ja = 3.5,
			ko = 3.733,
			zh = 4.233,
			en = 4.133
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
				arg_107_0:Play114242027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10018"]) and arg_107_1.var_.actorSpriteComps10018 == nil then
				arg_107_1.var_.actorSpriteComps10018 = arg_107_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.034

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10018"]) then
				if arg_107_1.var_.actorSpriteComps10018 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10018"]) and arg_107_1.var_.actorSpriteComps10018 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps10018 = nil
			end

			local var_110_2 = arg_107_1.actors_["104201_1"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) then
				local var_110_3 = var_110_2:GetComponent("Image")

				if var_110_3 then
					arg_107_1.var_.highlightMatValue104201_1 = var_110_3
				end
			end

			local var_110_4 = 0.034

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 and not isNil(var_110_2) then
				if arg_107_1.var_.highlightMatValue104201_1 then
					local var_110_5 = Mathf.Lerp(1, 0.5, (arg_107_1.time_ - 0) / var_110_4)

					arg_107_1.var_.highlightMatValue104201_1.color.r = var_110_5
					arg_107_1.var_.highlightMatValue104201_1.color.g = var_110_5
					arg_107_1.var_.highlightMatValue104201_1.color.b = var_110_5
					arg_107_1.var_.highlightMatValue104201_1.color = arg_107_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.highlightMatValue104201_1 then
				arg_107_1.var_.highlightMatValue104201_1.color.r = 0.5
				arg_107_1.var_.highlightMatValue104201_1.color.g = 0.5
				arg_107_1.var_.highlightMatValue104201_1.color.b = 0.5
				arg_107_1.var_.highlightMatValue104201_1.color = arg_107_1.var_.highlightMatValue104201_1.color
			end

			local var_110_6 = 0
			local var_110_7 = 0.45

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_8 = arg_107_1:GetWordFromCfg(114242026)
				local var_110_9 = arg_107_1:FormatText(var_110_8.content)

				arg_107_1.text_.text = var_110_9

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 18 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 18)

				if (18 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 18)) > 0 and var_110_7 < var_110_11 then
					arg_107_1.talkMaxDuration = var_110_11

					if var_110_11 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_9
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242026", "story_v_out_114242.awb") ~= 0 then
					local var_110_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242026", "story_v_out_114242.awb") / 1000

					if var_110_12 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_6
					end

					if var_110_8.prefab_name ~= "" and arg_107_1.actors_[var_110_8.prefab_name] ~= nil then
						local var_110_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_8.prefab_name].transform, "story_v_out_114242", "114242026", "story_v_out_114242.awb")

						arg_107_1:RecordAudio("114242026", var_110_13)
						arg_107_1:RecordAudio("114242026", var_110_13)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_114242", "114242026", "story_v_out_114242.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_114242", "114242026", "story_v_out_114242.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114242027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114242027
		arg_111_1.duration_ = 15.9

		local var_111_0 = {
			ja = 15.9,
			ko = 11.9,
			zh = 11.2,
			en = 15.2
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play114242028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["10018"]) and arg_111_1.var_.actorSpriteComps10018 == nil then
				arg_111_1.var_.actorSpriteComps10018 = arg_111_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["10018"]) then
				if arg_111_1.var_.actorSpriteComps10018 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["10018"]) and arg_111_1.var_.actorSpriteComps10018 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps10018 = nil
			end

			local var_114_2 = arg_111_1.actors_["104201_1"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) then
				local var_114_3 = var_114_2:GetComponent("Image")

				if var_114_3 then
					arg_111_1.var_.highlightMatValue104201_1 = var_114_3
				end
			end

			local var_114_4 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 and not isNil(var_114_2) then
				if arg_111_1.var_.highlightMatValue104201_1 then
					local var_114_5 = Mathf.Lerp(0.5, 1, (arg_111_1.time_ - 0) / var_114_4)

					arg_111_1.var_.highlightMatValue104201_1.color.r = var_114_5
					arg_111_1.var_.highlightMatValue104201_1.color.g = var_114_5
					arg_111_1.var_.highlightMatValue104201_1.color.b = var_114_5
					arg_111_1.var_.highlightMatValue104201_1.color = arg_111_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.highlightMatValue104201_1 then
				var_114_2.transform:SetSiblingIndex(1)

				arg_111_1.var_.highlightMatValue104201_1.color.r = 1
				arg_111_1.var_.highlightMatValue104201_1.color.g = 1
				arg_111_1.var_.highlightMatValue104201_1.color.b = 1
				arg_111_1.var_.highlightMatValue104201_1.color = arg_111_1.var_.highlightMatValue104201_1.color
			end

			local var_114_6 = 0
			local var_114_7 = 1.25

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_8 = arg_111_1:GetWordFromCfg(114242027)
				local var_114_9 = arg_111_1:FormatText(var_114_8.content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 50 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 50)

				if (50 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 50)) > 0 and var_114_7 < var_114_11 then
					arg_111_1.talkMaxDuration = var_114_11

					if var_114_11 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242027", "story_v_out_114242.awb") ~= 0 then
					local var_114_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242027", "story_v_out_114242.awb") / 1000

					if var_114_12 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_6
					end

					if var_114_8.prefab_name ~= "" and arg_111_1.actors_[var_114_8.prefab_name] ~= nil then
						local var_114_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_8.prefab_name].transform, "story_v_out_114242", "114242027", "story_v_out_114242.awb")

						arg_111_1:RecordAudio("114242027", var_114_13)
						arg_111_1:RecordAudio("114242027", var_114_13)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_114242", "114242027", "story_v_out_114242.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_114242", "114242027", "story_v_out_114242.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_14 and arg_111_1.time_ < var_114_6 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play114242028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114242028
		arg_115_1.duration_ = 5.87

		local var_115_0 = {
			ja = 3.766,
			ko = 5.866,
			zh = 5.5,
			en = 4.033
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
				arg_115_0:Play114242029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["10018"]) and arg_115_1.var_.actorSpriteComps10018 == nil then
				arg_115_1.var_.actorSpriteComps10018 = arg_115_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_0 = 0.034

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["10018"]) then
				if arg_115_1.var_.actorSpriteComps10018 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["10018"]) and arg_115_1.var_.actorSpriteComps10018 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_118_3 then
						iter_118_3.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps10018 = nil
			end

			local var_118_2 = arg_115_1.actors_["104201_1"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) then
				local var_118_3 = var_118_2:GetComponent("Image")

				if var_118_3 then
					arg_115_1.var_.highlightMatValue104201_1 = var_118_3
				end
			end

			local var_118_4 = 0.034

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 and not isNil(var_118_2) then
				if arg_115_1.var_.highlightMatValue104201_1 then
					local var_118_5 = Mathf.Lerp(1, 0.5, (arg_115_1.time_ - 0) / var_118_4)

					arg_115_1.var_.highlightMatValue104201_1.color.r = var_118_5
					arg_115_1.var_.highlightMatValue104201_1.color.g = var_118_5
					arg_115_1.var_.highlightMatValue104201_1.color.b = var_118_5
					arg_115_1.var_.highlightMatValue104201_1.color = arg_115_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.highlightMatValue104201_1 then
				arg_115_1.var_.highlightMatValue104201_1.color.r = 0.5
				arg_115_1.var_.highlightMatValue104201_1.color.g = 0.5
				arg_115_1.var_.highlightMatValue104201_1.color.b = 0.5
				arg_115_1.var_.highlightMatValue104201_1.color = arg_115_1.var_.highlightMatValue104201_1.color
			end

			local var_118_6 = 0
			local var_118_7 = 0.525

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:GetWordFromCfg(114242028)
				local var_118_9 = arg_115_1:FormatText(var_118_8.content)

				arg_115_1.text_.text = var_118_9

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 21 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_9) / 21)

				if (21 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_9) / 21)) > 0 and var_118_7 < var_118_11 then
					arg_115_1.talkMaxDuration = var_118_11

					if var_118_11 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_9
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242028", "story_v_out_114242.awb") ~= 0 then
					local var_118_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242028", "story_v_out_114242.awb") / 1000

					if var_118_12 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_12 + var_118_6
					end

					if var_118_8.prefab_name ~= "" and arg_115_1.actors_[var_118_8.prefab_name] ~= nil then
						local var_118_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_8.prefab_name].transform, "story_v_out_114242", "114242028", "story_v_out_114242.awb")

						arg_115_1:RecordAudio("114242028", var_118_13)
						arg_115_1:RecordAudio("114242028", var_118_13)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_114242", "114242028", "story_v_out_114242.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_114242", "114242028", "story_v_out_114242.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_14 and arg_115_1.time_ < var_118_6 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play114242029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114242029
		arg_119_1.duration_ = 14.83

		local var_119_0 = {
			ja = 14.833,
			ko = 10.9,
			zh = 13.766,
			en = 13.9
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
				arg_119_0:Play114242030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10018"]) and arg_119_1.var_.actorSpriteComps10018 == nil then
				arg_119_1.var_.actorSpriteComps10018 = arg_119_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_0 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10018"]) then
				if arg_119_1.var_.actorSpriteComps10018 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10018"]) and arg_119_1.var_.actorSpriteComps10018 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10018 = nil
			end

			local var_122_2 = 0
			local var_122_3 = 1.325

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:GetWordFromCfg(114242029)
				local var_122_5 = arg_119_1:FormatText(var_122_4.content)

				arg_119_1.text_.text = var_122_5

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_7 = 53 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 53)

				if (53 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 53)) > 0 and var_122_3 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_5
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242029", "story_v_out_114242.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242029", "story_v_out_114242.awb") / 1000

					if var_122_8 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_2
					end

					if var_122_4.prefab_name ~= "" and arg_119_1.actors_[var_122_4.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_4.prefab_name].transform, "story_v_out_114242", "114242029", "story_v_out_114242.awb")

						arg_119_1:RecordAudio("114242029", var_122_9)
						arg_119_1:RecordAudio("114242029", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_114242", "114242029", "story_v_out_114242.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_114242", "114242029", "story_v_out_114242.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_10 and arg_119_1.time_ < var_122_2 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play114242030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114242030
		arg_123_1.duration_ = 3.7

		local var_123_0 = {
			ja = 3.7,
			ko = 2.866,
			zh = 3.1,
			en = 3.6
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
				arg_123_0:Play114242031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10018"]) and arg_123_1.var_.actorSpriteComps10018 == nil then
				arg_123_1.var_.actorSpriteComps10018 = arg_123_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10018"]) then
				if arg_123_1.var_.actorSpriteComps10018 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10018"]) and arg_123_1.var_.actorSpriteComps10018 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10018 = nil
			end

			local var_126_2 = arg_123_1.actors_["104201_1"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) then
				local var_126_3 = var_126_2:GetComponent("Image")

				if var_126_3 then
					arg_123_1.var_.highlightMatValue104201_1 = var_126_3
				end
			end

			local var_126_4 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 and not isNil(var_126_2) then
				if arg_123_1.var_.highlightMatValue104201_1 then
					local var_126_5 = Mathf.Lerp(0.5, 1, (arg_123_1.time_ - 0) / var_126_4)

					arg_123_1.var_.highlightMatValue104201_1.color.r = var_126_5
					arg_123_1.var_.highlightMatValue104201_1.color.g = var_126_5
					arg_123_1.var_.highlightMatValue104201_1.color.b = var_126_5
					arg_123_1.var_.highlightMatValue104201_1.color = arg_123_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.highlightMatValue104201_1 then
				var_126_2.transform:SetSiblingIndex(1)

				arg_123_1.var_.highlightMatValue104201_1.color.r = 1
				arg_123_1.var_.highlightMatValue104201_1.color.g = 1
				arg_123_1.var_.highlightMatValue104201_1.color.b = 1
				arg_123_1.var_.highlightMatValue104201_1.color = arg_123_1.var_.highlightMatValue104201_1.color
			end

			local var_126_6 = 0
			local var_126_7 = 0.25

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_8 = arg_123_1:GetWordFromCfg(114242030)
				local var_126_9 = arg_123_1:FormatText(var_126_8.content)

				arg_123_1.text_.text = var_126_9

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 10 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 10)

				if (10 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 10)) > 0 and var_126_7 < var_126_11 then
					arg_123_1.talkMaxDuration = var_126_11

					if var_126_11 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_9
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242030", "story_v_out_114242.awb") ~= 0 then
					local var_126_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242030", "story_v_out_114242.awb") / 1000

					if var_126_12 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_6
					end

					if var_126_8.prefab_name ~= "" and arg_123_1.actors_[var_126_8.prefab_name] ~= nil then
						local var_126_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_8.prefab_name].transform, "story_v_out_114242", "114242030", "story_v_out_114242.awb")

						arg_123_1:RecordAudio("114242030", var_126_13)
						arg_123_1:RecordAudio("114242030", var_126_13)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_114242", "114242030", "story_v_out_114242.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_114242", "114242030", "story_v_out_114242.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_14 and arg_123_1.time_ < var_126_6 + var_126_14 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play114242031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114242031
		arg_127_1.duration_ = 15.27

		local var_127_0 = {
			ja = 9.333,
			ko = 10.433,
			zh = 15.266,
			en = 14.133
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
				arg_127_0:Play114242032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10018"]) and arg_127_1.var_.actorSpriteComps10018 == nil then
				arg_127_1.var_.actorSpriteComps10018 = arg_127_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10018"]) then
				if arg_127_1.var_.actorSpriteComps10018 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10018"]) and arg_127_1.var_.actorSpriteComps10018 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10018 = nil
			end

			local var_130_2 = arg_127_1.actors_["104201_1"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) then
				local var_130_3 = var_130_2:GetComponent("Image")

				if var_130_3 then
					arg_127_1.var_.highlightMatValue104201_1 = var_130_3
				end
			end

			local var_130_4 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 and not isNil(var_130_2) then
				if arg_127_1.var_.highlightMatValue104201_1 then
					local var_130_5 = Mathf.Lerp(1, 0.5, (arg_127_1.time_ - 0) / var_130_4)

					arg_127_1.var_.highlightMatValue104201_1.color.r = var_130_5
					arg_127_1.var_.highlightMatValue104201_1.color.g = var_130_5
					arg_127_1.var_.highlightMatValue104201_1.color.b = var_130_5
					arg_127_1.var_.highlightMatValue104201_1.color = arg_127_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.highlightMatValue104201_1 then
				arg_127_1.var_.highlightMatValue104201_1.color.r = 0.5
				arg_127_1.var_.highlightMatValue104201_1.color.g = 0.5
				arg_127_1.var_.highlightMatValue104201_1.color.b = 0.5
				arg_127_1.var_.highlightMatValue104201_1.color = arg_127_1.var_.highlightMatValue104201_1.color
			end

			local var_130_6 = 0
			local var_130_7 = 1.475

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:GetWordFromCfg(114242031)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 59 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 59)

				if (59 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 59)) > 0 and var_130_7 < var_130_11 then
					arg_127_1.talkMaxDuration = var_130_11

					if var_130_11 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242031", "story_v_out_114242.awb") ~= 0 then
					local var_130_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242031", "story_v_out_114242.awb") / 1000

					if var_130_12 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_6
					end

					if var_130_8.prefab_name ~= "" and arg_127_1.actors_[var_130_8.prefab_name] ~= nil then
						local var_130_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_8.prefab_name].transform, "story_v_out_114242", "114242031", "story_v_out_114242.awb")

						arg_127_1:RecordAudio("114242031", var_130_13)
						arg_127_1:RecordAudio("114242031", var_130_13)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_114242", "114242031", "story_v_out_114242.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_114242", "114242031", "story_v_out_114242.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play114242032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114242032
		arg_131_1.duration_ = 9.23

		local var_131_0 = {
			ja = 3.766,
			ko = 4.5,
			zh = 5.6,
			en = 9.233
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
				arg_131_0:Play114242033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["10018"]) and arg_131_1.var_.actorSpriteComps10018 == nil then
				arg_131_1.var_.actorSpriteComps10018 = arg_131_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["10018"]) then
				if arg_131_1.var_.actorSpriteComps10018 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["10018"]) and arg_131_1.var_.actorSpriteComps10018 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps10018 = nil
			end

			local var_134_2 = arg_131_1.actors_["104201_1"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) then
				local var_134_3 = var_134_2:GetComponent("Image")

				if var_134_3 then
					arg_131_1.var_.highlightMatValue104201_1 = var_134_3
				end
			end

			local var_134_4 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 and not isNil(var_134_2) then
				if arg_131_1.var_.highlightMatValue104201_1 then
					local var_134_5 = Mathf.Lerp(0.5, 1, (arg_131_1.time_ - 0) / var_134_4)

					arg_131_1.var_.highlightMatValue104201_1.color.r = var_134_5
					arg_131_1.var_.highlightMatValue104201_1.color.g = var_134_5
					arg_131_1.var_.highlightMatValue104201_1.color.b = var_134_5
					arg_131_1.var_.highlightMatValue104201_1.color = arg_131_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.highlightMatValue104201_1 then
				var_134_2.transform:SetSiblingIndex(1)

				arg_131_1.var_.highlightMatValue104201_1.color.r = 1
				arg_131_1.var_.highlightMatValue104201_1.color.g = 1
				arg_131_1.var_.highlightMatValue104201_1.color.b = 1
				arg_131_1.var_.highlightMatValue104201_1.color = arg_131_1.var_.highlightMatValue104201_1.color
			end

			local var_134_6 = 0
			local var_134_7 = 0.575

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(114242032)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 23 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 23)

				if (23 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 23)) > 0 and var_134_7 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242032", "story_v_out_114242.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242032", "story_v_out_114242.awb") / 1000

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_114242", "114242032", "story_v_out_114242.awb")

						arg_131_1:RecordAudio("114242032", var_134_13)
						arg_131_1:RecordAudio("114242032", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_114242", "114242032", "story_v_out_114242.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_114242", "114242032", "story_v_out_114242.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_14 and arg_131_1.time_ < var_134_6 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play114242033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 114242033
		arg_135_1.duration_ = 9

		local var_135_0 = {
			ja = 9,
			ko = 5.233,
			zh = 7.4,
			en = 5.733
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
				arg_135_0:Play114242034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10018"]) and arg_135_1.var_.actorSpriteComps10018 == nil then
				arg_135_1.var_.actorSpriteComps10018 = arg_135_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.034

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10018"]) then
				if arg_135_1.var_.actorSpriteComps10018 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10018"]) and arg_135_1.var_.actorSpriteComps10018 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10018 = nil
			end

			local var_138_2 = arg_135_1.actors_["104201_1"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) then
				local var_138_3 = var_138_2:GetComponent("Image")

				if var_138_3 then
					arg_135_1.var_.highlightMatValue104201_1 = var_138_3
				end
			end

			local var_138_4 = 0.034

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 and not isNil(var_138_2) then
				if arg_135_1.var_.highlightMatValue104201_1 then
					local var_138_5 = Mathf.Lerp(1, 0.5, (arg_135_1.time_ - 0) / var_138_4)

					arg_135_1.var_.highlightMatValue104201_1.color.r = var_138_5
					arg_135_1.var_.highlightMatValue104201_1.color.g = var_138_5
					arg_135_1.var_.highlightMatValue104201_1.color.b = var_138_5
					arg_135_1.var_.highlightMatValue104201_1.color = arg_135_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.highlightMatValue104201_1 then
				arg_135_1.var_.highlightMatValue104201_1.color.r = 0.5
				arg_135_1.var_.highlightMatValue104201_1.color.g = 0.5
				arg_135_1.var_.highlightMatValue104201_1.color.b = 0.5
				arg_135_1.var_.highlightMatValue104201_1.color = arg_135_1.var_.highlightMatValue104201_1.color
			end

			local var_138_6 = 0
			local var_138_7 = 0.65

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_8 = arg_135_1:GetWordFromCfg(114242033)
				local var_138_9 = arg_135_1:FormatText(var_138_8.content)

				arg_135_1.text_.text = var_138_9

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 26 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_9) / 26)

				if (26 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_9) / 26)) > 0 and var_138_7 < var_138_11 then
					arg_135_1.talkMaxDuration = var_138_11

					if var_138_11 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_9
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242033", "story_v_out_114242.awb") ~= 0 then
					local var_138_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242033", "story_v_out_114242.awb") / 1000

					if var_138_12 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_12 + var_138_6
					end

					if var_138_8.prefab_name ~= "" and arg_135_1.actors_[var_138_8.prefab_name] ~= nil then
						local var_138_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_8.prefab_name].transform, "story_v_out_114242", "114242033", "story_v_out_114242.awb")

						arg_135_1:RecordAudio("114242033", var_138_13)
						arg_135_1:RecordAudio("114242033", var_138_13)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_114242", "114242033", "story_v_out_114242.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_114242", "114242033", "story_v_out_114242.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_14 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_14 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_14

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_14 and arg_135_1.time_ < var_138_6 + var_138_14 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play114242034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114242034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play114242035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10018"]) and arg_139_1.var_.actorSpriteComps10018 == nil then
				arg_139_1.var_.actorSpriteComps10018 = arg_139_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.034

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10018"]) then
				if arg_139_1.var_.actorSpriteComps10018 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10018"]) and arg_139_1.var_.actorSpriteComps10018 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps10018 = nil
			end

			local var_142_2 = 0
			local var_142_3 = 0.65

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(114242034).content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 26 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 26)

				if (26 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 26)) > 0 and var_142_3 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_7 and arg_139_1.time_ < var_142_2 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play114242035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114242035
		arg_143_1.duration_ = 3.1

		local var_143_0 = {
			ja = 2.933,
			ko = 3.1,
			zh = 2.233,
			en = 2.466
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
				arg_143_0:Play114242036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10018"]) and arg_143_1.var_.actorSpriteComps10018 == nil then
				arg_143_1.var_.actorSpriteComps10018 = arg_143_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_0 = 0.034

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10018"]) then
				if arg_143_1.var_.actorSpriteComps10018 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								iter_146_1.color = Color.New(Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_0), Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_0), (Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_0)))
							else
								local var_146_1 = Mathf.Lerp(iter_146_1.color.r, 1, (arg_143_1.time_ - 0) / var_146_0)

								iter_146_1.color = Color.New(var_146_1, var_146_1, var_146_1)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10018"]) and arg_143_1.var_.actorSpriteComps10018 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps10018 = nil
			end

			local var_146_2 = 0
			local var_146_3 = 0.3

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(114242035)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 12 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 12)

				if (12 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 12)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242035", "story_v_out_114242.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242035", "story_v_out_114242.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_114242", "114242035", "story_v_out_114242.awb")

						arg_143_1:RecordAudio("114242035", var_146_9)
						arg_143_1:RecordAudio("114242035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_114242", "114242035", "story_v_out_114242.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_114242", "114242035", "story_v_out_114242.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play114242036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 114242036
		arg_147_1.duration_ = 15.57

		local var_147_0 = {
			ja = 14.8,
			ko = 13.7,
			zh = 15.566,
			en = 12.533
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
				arg_147_0:Play114242037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 1.8

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:GetWordFromCfg(114242036)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 72 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 72)

				if (72 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 72)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242036", "story_v_out_114242.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_114242", "114242036", "story_v_out_114242.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_114242", "114242036", "story_v_out_114242.awb")

						arg_147_1:RecordAudio("114242036", var_150_6)
						arg_147_1:RecordAudio("114242036", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_114242", "114242036", "story_v_out_114242.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_114242", "114242036", "story_v_out_114242.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play114242037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114242037
		arg_151_1.duration_ = 16.5

		local var_151_0 = {
			ja = 16.5,
			ko = 13.8,
			zh = 14.033,
			en = 15.333
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
				arg_151_0:Play114242038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10018"]) and arg_151_1.var_.actorSpriteComps10018 == nil then
				arg_151_1.var_.actorSpriteComps10018 = arg_151_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.034

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10018"]) then
				if arg_151_1.var_.actorSpriteComps10018 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10018"]) and arg_151_1.var_.actorSpriteComps10018 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10018 = nil
			end

			local var_154_2 = arg_151_1.actors_["104201_1"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) then
				local var_154_3 = var_154_2:GetComponent("Image")

				if var_154_3 then
					arg_151_1.var_.highlightMatValue104201_1 = var_154_3
				end
			end

			local var_154_4 = 0.034

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 and not isNil(var_154_2) then
				if arg_151_1.var_.highlightMatValue104201_1 then
					local var_154_5 = Mathf.Lerp(0.5, 1, (arg_151_1.time_ - 0) / var_154_4)

					arg_151_1.var_.highlightMatValue104201_1.color.r = var_154_5
					arg_151_1.var_.highlightMatValue104201_1.color.g = var_154_5
					arg_151_1.var_.highlightMatValue104201_1.color.b = var_154_5
					arg_151_1.var_.highlightMatValue104201_1.color = arg_151_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.highlightMatValue104201_1 then
				var_154_2.transform:SetSiblingIndex(1)

				arg_151_1.var_.highlightMatValue104201_1.color.r = 1
				arg_151_1.var_.highlightMatValue104201_1.color.g = 1
				arg_151_1.var_.highlightMatValue104201_1.color.b = 1
				arg_151_1.var_.highlightMatValue104201_1.color = arg_151_1.var_.highlightMatValue104201_1.color
			end

			local var_154_6 = 0
			local var_154_7 = 1.55

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:GetWordFromCfg(114242037)
				local var_154_9 = arg_151_1:FormatText(var_154_8.content)

				arg_151_1.text_.text = var_154_9

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 62 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_9) / 62)

				if (62 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_9) / 62)) > 0 and var_154_7 < var_154_11 then
					arg_151_1.talkMaxDuration = var_154_11

					if var_154_11 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_9
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242037", "story_v_out_114242.awb") ~= 0 then
					local var_154_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242037", "story_v_out_114242.awb") / 1000

					if var_154_12 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_12 + var_154_6
					end

					if var_154_8.prefab_name ~= "" and arg_151_1.actors_[var_154_8.prefab_name] ~= nil then
						local var_154_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_8.prefab_name].transform, "story_v_out_114242", "114242037", "story_v_out_114242.awb")

						arg_151_1:RecordAudio("114242037", var_154_13)
						arg_151_1:RecordAudio("114242037", var_154_13)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_114242", "114242037", "story_v_out_114242.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_114242", "114242037", "story_v_out_114242.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114242038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114242038
		arg_155_1.duration_ = 15.1

		local var_155_0 = {
			ja = 10.233,
			ko = 11.9,
			zh = 15.1,
			en = 12.666
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
				arg_155_0:Play114242039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10018"]) and arg_155_1.var_.actorSpriteComps10018 == nil then
				arg_155_1.var_.actorSpriteComps10018 = arg_155_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_0 = 0.034

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10018"]) then
				if arg_155_1.var_.actorSpriteComps10018 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								iter_158_1.color = Color.New(Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_0), Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_0), (Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_0)))
							else
								local var_158_1 = Mathf.Lerp(iter_158_1.color.r, 1, (arg_155_1.time_ - 0) / var_158_0)

								iter_158_1.color = Color.New(var_158_1, var_158_1, var_158_1)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10018"]) and arg_155_1.var_.actorSpriteComps10018 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_158_3 then
						iter_158_3.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps10018 = nil
			end

			local var_158_2 = arg_155_1.actors_["104201_1"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) then
				local var_158_3 = var_158_2:GetComponent("Image")

				if var_158_3 then
					arg_155_1.var_.highlightMatValue104201_1 = var_158_3
				end
			end

			local var_158_4 = 0.034

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 and not isNil(var_158_2) then
				if arg_155_1.var_.highlightMatValue104201_1 then
					local var_158_5 = Mathf.Lerp(1, 0.5, (arg_155_1.time_ - 0) / var_158_4)

					arg_155_1.var_.highlightMatValue104201_1.color.r = var_158_5
					arg_155_1.var_.highlightMatValue104201_1.color.g = var_158_5
					arg_155_1.var_.highlightMatValue104201_1.color.b = var_158_5
					arg_155_1.var_.highlightMatValue104201_1.color = arg_155_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.highlightMatValue104201_1 then
				arg_155_1.var_.highlightMatValue104201_1.color.r = 0.5
				arg_155_1.var_.highlightMatValue104201_1.color.g = 0.5
				arg_155_1.var_.highlightMatValue104201_1.color.b = 0.5
				arg_155_1.var_.highlightMatValue104201_1.color = arg_155_1.var_.highlightMatValue104201_1.color
			end

			local var_158_6 = 0
			local var_158_7 = 1.525

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:GetWordFromCfg(114242038)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 62 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 62)

				if (62 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 62)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242038", "story_v_out_114242.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242038", "story_v_out_114242.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_114242", "114242038", "story_v_out_114242.awb")

						arg_155_1:RecordAudio("114242038", var_158_13)
						arg_155_1:RecordAudio("114242038", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_114242", "114242038", "story_v_out_114242.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_114242", "114242038", "story_v_out_114242.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play114242039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114242039
		arg_159_1.duration_ = 2.27

		local var_159_0 = {
			ja = 1.066,
			ko = 1.3,
			zh = 2.266,
			en = 1
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
				arg_159_0:Play114242040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10018"]) and arg_159_1.var_.actorSpriteComps10018 == nil then
				arg_159_1.var_.actorSpriteComps10018 = arg_159_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 0.034

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10018"]) then
				if arg_159_1.var_.actorSpriteComps10018 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10018"]) and arg_159_1.var_.actorSpriteComps10018 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps10018 = nil
			end

			local var_162_2 = arg_159_1.actors_["104201_1"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) then
				local var_162_3 = var_162_2:GetComponent("Image")

				if var_162_3 then
					arg_159_1.var_.highlightMatValue104201_1 = var_162_3
				end
			end

			local var_162_4 = 0.034

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 and not isNil(var_162_2) then
				if arg_159_1.var_.highlightMatValue104201_1 then
					local var_162_5 = Mathf.Lerp(0.5, 1, (arg_159_1.time_ - 0) / var_162_4)

					arg_159_1.var_.highlightMatValue104201_1.color.r = var_162_5
					arg_159_1.var_.highlightMatValue104201_1.color.g = var_162_5
					arg_159_1.var_.highlightMatValue104201_1.color.b = var_162_5
					arg_159_1.var_.highlightMatValue104201_1.color = arg_159_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.highlightMatValue104201_1 then
				var_162_2.transform:SetSiblingIndex(1)

				arg_159_1.var_.highlightMatValue104201_1.color.r = 1
				arg_159_1.var_.highlightMatValue104201_1.color.g = 1
				arg_159_1.var_.highlightMatValue104201_1.color.b = 1
				arg_159_1.var_.highlightMatValue104201_1.color = arg_159_1.var_.highlightMatValue104201_1.color
			end

			local var_162_6 = 0
			local var_162_7 = 0.05

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(114242039)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 2 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 2)

				if (2 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 2)) > 0 and var_162_7 < var_162_11 then
					arg_159_1.talkMaxDuration = var_162_11

					if var_162_11 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242039", "story_v_out_114242.awb") ~= 0 then
					local var_162_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242039", "story_v_out_114242.awb") / 1000

					if var_162_12 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_6
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_114242", "114242039", "story_v_out_114242.awb")

						arg_159_1:RecordAudio("114242039", var_162_13)
						arg_159_1:RecordAudio("114242039", var_162_13)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_114242", "114242039", "story_v_out_114242.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_114242", "114242039", "story_v_out_114242.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play114242040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 114242040
		arg_163_1.duration_ = 13.37

		local var_163_0 = {
			ja = 6.033,
			ko = 8.533,
			zh = 8.7,
			en = 13.366
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
				arg_163_0:Play114242041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10018"]) and arg_163_1.var_.actorSpriteComps10018 == nil then
				arg_163_1.var_.actorSpriteComps10018 = arg_163_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.034

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10018"]) then
				if arg_163_1.var_.actorSpriteComps10018 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 1, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10018"]) and arg_163_1.var_.actorSpriteComps10018 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10018 = nil
			end

			local var_166_2 = arg_163_1.actors_["104201_1"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) then
				local var_166_3 = var_166_2:GetComponent("Image")

				if var_166_3 then
					arg_163_1.var_.highlightMatValue104201_1 = var_166_3
				end
			end

			local var_166_4 = 0.034

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 and not isNil(var_166_2) then
				if arg_163_1.var_.highlightMatValue104201_1 then
					local var_166_5 = Mathf.Lerp(1, 0.5, (arg_163_1.time_ - 0) / var_166_4)

					arg_163_1.var_.highlightMatValue104201_1.color.r = var_166_5
					arg_163_1.var_.highlightMatValue104201_1.color.g = var_166_5
					arg_163_1.var_.highlightMatValue104201_1.color.b = var_166_5
					arg_163_1.var_.highlightMatValue104201_1.color = arg_163_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.highlightMatValue104201_1 then
				arg_163_1.var_.highlightMatValue104201_1.color.r = 0.5
				arg_163_1.var_.highlightMatValue104201_1.color.g = 0.5
				arg_163_1.var_.highlightMatValue104201_1.color.b = 0.5
				arg_163_1.var_.highlightMatValue104201_1.color = arg_163_1.var_.highlightMatValue104201_1.color
			end

			local var_166_6 = 0
			local var_166_7 = 1.075

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_8 = arg_163_1:GetWordFromCfg(114242040)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 43 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 43)

				if (43 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 43)) > 0 and var_166_7 < var_166_11 then
					arg_163_1.talkMaxDuration = var_166_11

					if var_166_11 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242040", "story_v_out_114242.awb") ~= 0 then
					local var_166_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242040", "story_v_out_114242.awb") / 1000

					if var_166_12 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_6
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_114242", "114242040", "story_v_out_114242.awb")

						arg_163_1:RecordAudio("114242040", var_166_13)
						arg_163_1:RecordAudio("114242040", var_166_13)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_114242", "114242040", "story_v_out_114242.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_114242", "114242040", "story_v_out_114242.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play114242041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 114242041
		arg_167_1.duration_ = 3.4

		local var_167_0 = {
			ja = 3.4,
			ko = 2.833,
			zh = 3.3,
			en = 2.866
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
				arg_167_0:Play114242042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10018"]) and arg_167_1.var_.actorSpriteComps10018 == nil then
				arg_167_1.var_.actorSpriteComps10018 = arg_167_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.034

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10018"]) then
				if arg_167_1.var_.actorSpriteComps10018 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10018"]) and arg_167_1.var_.actorSpriteComps10018 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10018 = nil
			end

			local var_170_2 = arg_167_1.actors_["104201_1"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) then
				local var_170_3 = var_170_2:GetComponent("Image")

				if var_170_3 then
					arg_167_1.var_.highlightMatValue104201_1 = var_170_3
				end
			end

			local var_170_4 = 0.034

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 and not isNil(var_170_2) then
				if arg_167_1.var_.highlightMatValue104201_1 then
					local var_170_5 = Mathf.Lerp(0.5, 1, (arg_167_1.time_ - 0) / var_170_4)

					arg_167_1.var_.highlightMatValue104201_1.color.r = var_170_5
					arg_167_1.var_.highlightMatValue104201_1.color.g = var_170_5
					arg_167_1.var_.highlightMatValue104201_1.color.b = var_170_5
					arg_167_1.var_.highlightMatValue104201_1.color = arg_167_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.highlightMatValue104201_1 then
				var_170_2.transform:SetSiblingIndex(1)

				arg_167_1.var_.highlightMatValue104201_1.color.r = 1
				arg_167_1.var_.highlightMatValue104201_1.color.g = 1
				arg_167_1.var_.highlightMatValue104201_1.color.b = 1
				arg_167_1.var_.highlightMatValue104201_1.color = arg_167_1.var_.highlightMatValue104201_1.color
			end

			local var_170_6 = 0
			local var_170_7 = 0.225

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_8 = arg_167_1:GetWordFromCfg(114242041)
				local var_170_9 = arg_167_1:FormatText(var_170_8.content)

				arg_167_1.text_.text = var_170_9

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 9 <= 0 and var_170_7 or var_170_7 * (utf8.len(var_170_9) / 9)

				if (9 <= 0 and var_170_7 or var_170_7 * (utf8.len(var_170_9) / 9)) > 0 and var_170_7 < var_170_11 then
					arg_167_1.talkMaxDuration = var_170_11

					if var_170_11 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_9
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242041", "story_v_out_114242.awb") ~= 0 then
					local var_170_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242041", "story_v_out_114242.awb") / 1000

					if var_170_12 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_12 + var_170_6
					end

					if var_170_8.prefab_name ~= "" and arg_167_1.actors_[var_170_8.prefab_name] ~= nil then
						local var_170_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_8.prefab_name].transform, "story_v_out_114242", "114242041", "story_v_out_114242.awb")

						arg_167_1:RecordAudio("114242041", var_170_13)
						arg_167_1:RecordAudio("114242041", var_170_13)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_114242", "114242041", "story_v_out_114242.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_114242", "114242041", "story_v_out_114242.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play114242042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 114242042
		arg_171_1.duration_ = 7.9

		local var_171_0 = {
			ja = 7.9,
			ko = 6.966,
			zh = 6.833,
			en = 7.566
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
				arg_171_0:Play114242043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10018"]) and arg_171_1.var_.actorSpriteComps10018 == nil then
				arg_171_1.var_.actorSpriteComps10018 = arg_171_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.034

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10018"]) then
				if arg_171_1.var_.actorSpriteComps10018 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								iter_174_1.color = Color.New(Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_0), Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_0), (Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_0)))
							else
								local var_174_1 = Mathf.Lerp(iter_174_1.color.r, 1, (arg_171_1.time_ - 0) / var_174_0)

								iter_174_1.color = Color.New(var_174_1, var_174_1, var_174_1)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10018"]) and arg_171_1.var_.actorSpriteComps10018 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps10018 = nil
			end

			local var_174_2 = arg_171_1.actors_["104201_1"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) then
				local var_174_3 = var_174_2:GetComponent("Image")

				if var_174_3 then
					arg_171_1.var_.highlightMatValue104201_1 = var_174_3
				end
			end

			local var_174_4 = 0.034

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 and not isNil(var_174_2) then
				if arg_171_1.var_.highlightMatValue104201_1 then
					local var_174_5 = Mathf.Lerp(1, 0.5, (arg_171_1.time_ - 0) / var_174_4)

					arg_171_1.var_.highlightMatValue104201_1.color.r = var_174_5
					arg_171_1.var_.highlightMatValue104201_1.color.g = var_174_5
					arg_171_1.var_.highlightMatValue104201_1.color.b = var_174_5
					arg_171_1.var_.highlightMatValue104201_1.color = arg_171_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.highlightMatValue104201_1 then
				arg_171_1.var_.highlightMatValue104201_1.color.r = 0.5
				arg_171_1.var_.highlightMatValue104201_1.color.g = 0.5
				arg_171_1.var_.highlightMatValue104201_1.color.b = 0.5
				arg_171_1.var_.highlightMatValue104201_1.color = arg_171_1.var_.highlightMatValue104201_1.color
			end

			local var_174_6 = 0
			local var_174_7 = 0.825

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_8 = arg_171_1:GetWordFromCfg(114242042)
				local var_174_9 = arg_171_1:FormatText(var_174_8.content)

				arg_171_1.text_.text = var_174_9

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_11 = 33 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_9) / 33)

				if (33 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_9) / 33)) > 0 and var_174_7 < var_174_11 then
					arg_171_1.talkMaxDuration = var_174_11

					if var_174_11 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_6
					end
				end

				arg_171_1.text_.text = var_174_9
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242042", "story_v_out_114242.awb") ~= 0 then
					local var_174_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242042", "story_v_out_114242.awb") / 1000

					if var_174_12 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_12 + var_174_6
					end

					if var_174_8.prefab_name ~= "" and arg_171_1.actors_[var_174_8.prefab_name] ~= nil then
						local var_174_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_8.prefab_name].transform, "story_v_out_114242", "114242042", "story_v_out_114242.awb")

						arg_171_1:RecordAudio("114242042", var_174_13)
						arg_171_1:RecordAudio("114242042", var_174_13)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_114242", "114242042", "story_v_out_114242.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_114242", "114242042", "story_v_out_114242.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_14 = math.max(var_174_7, arg_171_1.talkMaxDuration)

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_14 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_6) / var_174_14

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_6 + var_174_14 and arg_171_1.time_ < var_174_6 + var_174_14 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play114242043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 114242043
		arg_175_1.duration_ = 7

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play114242044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				local var_178_0 = arg_175_1.bgs_.ST25

				arg_175_1.bgs_.ST25.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_178_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_1 = var_178_0:GetComponent("SpriteRenderer")

				if var_178_1 and var_178_1.sprite then
					local var_178_2 = 2 * (var_178_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_178_0.transform.localScale = Vector3.New(var_178_2 / var_178_1.sprite.bounds.size.y < var_178_2 * manager.ui.mainCameraCom_.aspect / var_178_1.sprite.bounds.size.x and var_178_2 * manager.ui.mainCameraCom_.aspect / var_178_1.sprite.bounds.size.x or var_178_2 / var_178_1.sprite.bounds.size.y, var_178_2 / var_178_1.sprite.bounds.size.y < var_178_2 * manager.ui.mainCameraCom_.aspect / var_178_1.sprite.bounds.size.x and var_178_2 * manager.ui.mainCameraCom_.aspect / var_178_1.sprite.bounds.size.x or var_178_2 / var_178_1.sprite.bounds.size.y, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "ST25" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_3 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_4 = 2

			if var_178_3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_3 + var_178_4 then
				local var_178_5 = Color.New(1, 1, 1)

				var_178_5.a = Mathf.Lerp(1, 0, (arg_175_1.time_ - var_178_3) / var_178_4)
				arg_175_1.mask_.color = var_178_5
			end

			if arg_175_1.time_ >= var_178_3 + var_178_4 and arg_175_1.time_ < var_178_3 + var_178_4 + arg_178_0 then
				local var_178_6 = Color.New(1, 1, 1)

				arg_175_1.mask_.enabled = false
				var_178_6.a = 0
				arg_175_1.mask_.color = var_178_6
			end

			local var_178_7 = arg_175_1.actors_["10018"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10018 = var_178_7.localPosition
				var_178_7.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10018", 7)

				for iter_178_2 = 0, var_178_7.childCount - 1 do
					local var_178_8 = var_178_7:GetChild(iter_178_2)

					if var_178_8.name == "split_1" or not string.find(var_178_8.name, "split") then
						var_178_8.gameObject:SetActive(true)
					else
						var_178_8.gameObject:SetActive(false)
					end
				end
			end

			local var_178_9 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_9 then
				var_178_7.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10018, Vector3.New(0, -2000, -180), (arg_175_1.time_ - 0) / var_178_9)
			end

			if arg_175_1.time_ >= 0 + var_178_9 and arg_175_1.time_ < 0 + var_178_9 + arg_178_0 then
				var_178_7.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_178_10 = arg_175_1.actors_["104201_1"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos104201_1 = var_178_10.localPosition
				var_178_10.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("104201_1", 7)
			end

			local var_178_11 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_11 then
				var_178_10.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos104201_1, Vector3.New(0, -2000, -180), (arg_175_1.time_ - 0) / var_178_11)
			end

			if arg_175_1.time_ >= 0 + var_178_11 and arg_175_1.time_ < 0 + var_178_11 + arg_178_0 then
				var_178_10.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_12 = 2
			local var_178_13 = 0.05

			if 2 < arg_175_1.time_ and arg_175_1.time_ <= var_178_12 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_14 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_14:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_15 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(114242043).content)

				arg_175_1.text_.text = var_178_15

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_17 = 2 <= 0 and var_178_13 or var_178_13 * (utf8.len(var_178_15) / 2)

				if (2 <= 0 and var_178_13 or var_178_13 * (utf8.len(var_178_15) / 2)) > 0 and var_178_13 < var_178_17 then
					arg_175_1.talkMaxDuration = var_178_17
					var_178_12 = var_178_12 + 0.3

					if var_178_17 + var_178_12 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_17 + var_178_12
					end
				end

				arg_175_1.text_.text = var_178_15
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_18 = var_178_12 + 0.3
			local var_178_19 = math.max(var_178_13, arg_175_1.talkMaxDuration)

			if var_178_12 + 0.3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_18 + var_178_19 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_18) / var_178_19

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_18 + var_178_19 and arg_175_1.time_ < var_178_18 + var_178_19 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104201_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play114242044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114242044
		arg_181_1.duration_ = 3

		local var_181_0 = {
			ja = 2.9,
			ko = 2.233,
			zh = 3,
			en = 2.3
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
				arg_181_0:Play114242045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10015 = arg_181_1.actors_["10015"].transform.localPosition
				arg_181_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10015", 4)

				for iter_184_0 = 0, arg_181_1.actors_["10015"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["10015"].transform:GetChild(iter_184_0)

					if var_184_0.name == "split_1" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_184_2 = arg_181_1.actors_["10015"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps10015 == nil then
				arg_181_1.var_.actorSpriteComps10015 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps10015 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_184_2 then
							if arg_181_1.isInRecall_ then
								iter_184_2.color = Color.New(Mathf.Lerp(iter_184_2.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_2.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_2.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_2.color.r, 1, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_2.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps10015 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_184_4 then
						iter_184_4.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				local var_184_5 = arg_181_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_184_5 then
					arg_181_1.var_.alphaOldValue10015 = var_184_5.alpha
					arg_181_1.var_.characterEffect10015 = var_184_5
				end

				arg_181_1.var_.alphaOldValue10015 = 0
			end

			local var_184_6 = 0.5

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 then
				if arg_181_1.var_.characterEffect10015 then
					arg_181_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_181_1.var_.alphaOldValue10015, 1, (arg_181_1.time_ - 0) / var_184_6)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and arg_181_1.var_.characterEffect10015 then
				arg_181_1.var_.characterEffect10015.alpha = 1
			end

			local var_184_7 = 0
			local var_184_8 = 0.3

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_7 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_9 = arg_181_1:GetWordFromCfg(114242044)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_12 = 12 <= 0 and var_184_8 or var_184_8 * (utf8.len(var_184_10) / 12)

				if (12 <= 0 and var_184_8 or var_184_8 * (utf8.len(var_184_10) / 12)) > 0 and var_184_8 < var_184_12 then
					arg_181_1.talkMaxDuration = var_184_12

					if var_184_12 + var_184_7 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_7
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242044", "story_v_out_114242.awb") ~= 0 then
					local var_184_13 = manager.audio:GetVoiceLength("story_v_out_114242", "114242044", "story_v_out_114242.awb") / 1000

					if var_184_13 + var_184_7 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_7
					end

					if var_184_9.prefab_name ~= "" and arg_181_1.actors_[var_184_9.prefab_name] ~= nil then
						local var_184_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_9.prefab_name].transform, "story_v_out_114242", "114242044", "story_v_out_114242.awb")

						arg_181_1:RecordAudio("114242044", var_184_14)
						arg_181_1:RecordAudio("114242044", var_184_14)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114242", "114242044", "story_v_out_114242.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114242", "114242044", "story_v_out_114242.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_15 = math.max(var_184_8, arg_181_1.talkMaxDuration)

			if var_184_7 <= arg_181_1.time_ and arg_181_1.time_ < var_184_7 + var_184_15 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_7) / var_184_15

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_7 + var_184_15 and arg_181_1.time_ < var_184_7 + var_184_15 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play114242045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114242045
		arg_185_1.duration_ = 3.5

		local var_185_0 = {
			ja = 2.3,
			ko = 3.466,
			zh = 3.5,
			en = 3.3
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
				arg_185_0:Play114242046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10018 = arg_185_1.actors_["10018"].transform.localPosition
				arg_185_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10018", 2)

				for iter_188_0 = 0, arg_185_1.actors_["10018"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["10018"].transform:GetChild(iter_188_0)

					if var_188_0.name == "split_2" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10018"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_188_2 = arg_185_1.actors_["10015"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10015 == nil then
				arg_185_1.var_.actorSpriteComps10015 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps10015 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								iter_188_2.color = Color.New(Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_3), Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_3), (Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_3)))
							else
								local var_188_4 = Mathf.Lerp(iter_188_2.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_3)

								iter_188_2.color = Color.New(var_188_4, var_188_4, var_188_4)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10015 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_188_4 then
						iter_188_4.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps10015 = nil
			end

			local var_188_5 = arg_185_1.actors_["10018"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10018 == nil then
				arg_185_1.var_.actorSpriteComps10018 = var_188_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_6 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_6 and not isNil(var_188_5) then
				if arg_185_1.var_.actorSpriteComps10018 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_188_6 then
							if arg_185_1.isInRecall_ then
								iter_188_6.color = Color.New(Mathf.Lerp(iter_188_6.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_6), Mathf.Lerp(iter_188_6.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_6), (Mathf.Lerp(iter_188_6.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_6)))
							else
								local var_188_7 = Mathf.Lerp(iter_188_6.color.r, 1, (arg_185_1.time_ - 0) / var_188_6)

								iter_188_6.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_6 and arg_185_1.time_ < 0 + var_188_6 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10018 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_188_8 then
						iter_188_8.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps10018 = nil
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				local var_188_8 = arg_185_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_188_8 then
					arg_185_1.var_.alphaOldValue10018 = var_188_8.alpha
					arg_185_1.var_.characterEffect10018 = var_188_8
				end

				arg_185_1.var_.alphaOldValue10018 = 0
			end

			local var_188_9 = 0.5

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_9 then
				if arg_185_1.var_.characterEffect10018 then
					arg_185_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_185_1.var_.alphaOldValue10018, 1, (arg_185_1.time_ - 0) / var_188_9)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_9 and arg_185_1.time_ < 0 + var_188_9 + arg_188_0 and arg_185_1.var_.characterEffect10018 then
				arg_185_1.var_.characterEffect10018.alpha = 1
			end

			local var_188_10 = 0
			local var_188_11 = 0.15

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_12 = arg_185_1:GetWordFromCfg(114242045)
				local var_188_13 = arg_185_1:FormatText(var_188_12.content)

				arg_185_1.text_.text = var_188_13

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_15 = 6 <= 0 and var_188_11 or var_188_11 * (utf8.len(var_188_13) / 6)

				if (6 <= 0 and var_188_11 or var_188_11 * (utf8.len(var_188_13) / 6)) > 0 and var_188_11 < var_188_15 then
					arg_185_1.talkMaxDuration = var_188_15

					if var_188_15 + var_188_10 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_15 + var_188_10
					end
				end

				arg_185_1.text_.text = var_188_13
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242045", "story_v_out_114242.awb") ~= 0 then
					local var_188_16 = manager.audio:GetVoiceLength("story_v_out_114242", "114242045", "story_v_out_114242.awb") / 1000

					if var_188_16 + var_188_10 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_16 + var_188_10
					end

					if var_188_12.prefab_name ~= "" and arg_185_1.actors_[var_188_12.prefab_name] ~= nil then
						local var_188_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_12.prefab_name].transform, "story_v_out_114242", "114242045", "story_v_out_114242.awb")

						arg_185_1:RecordAudio("114242045", var_188_17)
						arg_185_1:RecordAudio("114242045", var_188_17)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_114242", "114242045", "story_v_out_114242.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_114242", "114242045", "story_v_out_114242.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_18 = math.max(var_188_11, arg_185_1.talkMaxDuration)

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_18 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_10) / var_188_18

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_10 + var_188_18 and arg_185_1.time_ < var_188_10 + var_188_18 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114242046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114242046
		arg_189_1.duration_ = 1.9

		local var_189_0 = {
			ja = 0.999999999999,
			ko = 1.433,
			zh = 1.9,
			en = 1.233
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
				arg_189_0:Play114242047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10015"]) and arg_189_1.var_.actorSpriteComps10015 == nil then
				arg_189_1.var_.actorSpriteComps10015 = arg_189_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10015"]) then
				if arg_189_1.var_.actorSpriteComps10015 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_0), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_0), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_0)))
							else
								local var_192_1 = Mathf.Lerp(iter_192_1.color.r, 1, (arg_189_1.time_ - 0) / var_192_0)

								iter_192_1.color = Color.New(var_192_1, var_192_1, var_192_1)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10015"]) and arg_189_1.var_.actorSpriteComps10015 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps10015 = nil
			end

			local var_192_2 = arg_189_1.actors_["10018"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10018 == nil then
				arg_189_1.var_.actorSpriteComps10018 = var_192_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_3 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.actorSpriteComps10018 then
					for iter_192_4, iter_192_5 in pairs(arg_189_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_192_5 then
							if arg_189_1.isInRecall_ then
								iter_192_5.color = Color.New(Mathf.Lerp(iter_192_5.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_3), Mathf.Lerp(iter_192_5.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_3), (Mathf.Lerp(iter_192_5.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_3)))
							else
								local var_192_4 = Mathf.Lerp(iter_192_5.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_3)

								iter_192_5.color = Color.New(var_192_4, var_192_4, var_192_4)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10018 then
				for iter_192_6, iter_192_7 in pairs(arg_189_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_192_7 then
						iter_192_7.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps10018 = nil
			end

			local var_192_5 = arg_189_1.actors_["10015"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10015 = var_192_5.localPosition
				var_192_5.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10015", 4)

				for iter_192_8 = 0, var_192_5.childCount - 1 do
					local var_192_6 = var_192_5:GetChild(iter_192_8)

					if var_192_6.name == "split_5" or not string.find(var_192_6.name, "split") then
						var_192_6.gameObject:SetActive(true)
					else
						var_192_6.gameObject:SetActive(false)
					end
				end
			end

			local var_192_7 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				var_192_5.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_189_1.time_ - 0) / var_192_7)
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				var_192_5.localPosition = Vector3.New(390, -350, -180)
			end

			local var_192_8 = 0
			local var_192_9 = 0.075

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_10 = arg_189_1:GetWordFromCfg(114242046)
				local var_192_11 = arg_189_1:FormatText(var_192_10.content)

				arg_189_1.text_.text = var_192_11

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 3 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 3)

				if (3 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 3)) > 0 and var_192_9 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_11
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242046", "story_v_out_114242.awb") ~= 0 then
					local var_192_14 = manager.audio:GetVoiceLength("story_v_out_114242", "114242046", "story_v_out_114242.awb") / 1000

					if var_192_14 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_8
					end

					if var_192_10.prefab_name ~= "" and arg_189_1.actors_[var_192_10.prefab_name] ~= nil then
						local var_192_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_10.prefab_name].transform, "story_v_out_114242", "114242046", "story_v_out_114242.awb")

						arg_189_1:RecordAudio("114242046", var_192_15)
						arg_189_1:RecordAudio("114242046", var_192_15)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114242", "114242046", "story_v_out_114242.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114242", "114242046", "story_v_out_114242.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_16 and arg_189_1.time_ < var_192_8 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114242047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114242047
		arg_193_1.duration_ = 10.6

		local var_193_0 = {
			ja = 8.3,
			ko = 8.9,
			zh = 10.6,
			en = 8.633
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
				arg_193_0:Play114242048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["10015"]) and arg_193_1.var_.actorSpriteComps10015 == nil then
				arg_193_1.var_.actorSpriteComps10015 = arg_193_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_0 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["10015"]) then
				if arg_193_1.var_.actorSpriteComps10015 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								iter_196_1.color = Color.New(Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_0), Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_0), (Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_0)))
							else
								local var_196_1 = Mathf.Lerp(iter_196_1.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_0)

								iter_196_1.color = Color.New(var_196_1, var_196_1, var_196_1)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["10015"]) and arg_193_1.var_.actorSpriteComps10015 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_196_3 then
						iter_196_3.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps10015 = nil
			end

			local var_196_2 = arg_193_1.actors_["10018"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10018 == nil then
				arg_193_1.var_.actorSpriteComps10018 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps10018 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								iter_196_5.color = Color.New(Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_5.color.r, 1, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_5.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10018 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_196_7 then
						iter_196_7.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10018 = nil
			end

			local var_196_5 = arg_193_1.actors_["10018"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10018 = var_196_5.localPosition
				var_196_5.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10018", 2)

				for iter_196_8 = 0, var_196_5.childCount - 1 do
					local var_196_6 = var_196_5:GetChild(iter_196_8)

					if var_196_6.name == "split_1" or not string.find(var_196_6.name, "split") then
						var_196_6.gameObject:SetActive(true)
					else
						var_196_6.gameObject:SetActive(false)
					end
				end
			end

			local var_196_7 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				var_196_5.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_193_1.time_ - 0) / var_196_7)
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				var_196_5.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_196_8 = 0
			local var_196_9 = 1.025

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_10 = arg_193_1:GetWordFromCfg(114242047)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 41 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 41)

				if (41 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 41)) > 0 and var_196_9 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242047", "story_v_out_114242.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_out_114242", "114242047", "story_v_out_114242.awb") / 1000

					if var_196_14 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_8
					end

					if var_196_10.prefab_name ~= "" and arg_193_1.actors_[var_196_10.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_10.prefab_name].transform, "story_v_out_114242", "114242047", "story_v_out_114242.awb")

						arg_193_1:RecordAudio("114242047", var_196_15)
						arg_193_1:RecordAudio("114242047", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_114242", "114242047", "story_v_out_114242.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_114242", "114242047", "story_v_out_114242.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_9, arg_193_1.talkMaxDuration)

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_8) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_8 + var_196_16 and arg_193_1.time_ < var_196_8 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114242048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 114242048
		arg_197_1.duration_ = 6.97

		local var_197_0 = {
			ja = 6.8,
			ko = 5.5,
			zh = 6.533,
			en = 6.966
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
				arg_197_0:Play114242049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["10018"]) and arg_197_1.var_.actorSpriteComps10018 == nil then
				arg_197_1.var_.actorSpriteComps10018 = arg_197_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_0 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["10018"]) then
				if arg_197_1.var_.actorSpriteComps10018 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								iter_200_1.color = Color.New(Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_0), Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_0), (Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_0)))
							else
								local var_200_1 = Mathf.Lerp(iter_200_1.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_0)

								iter_200_1.color = Color.New(var_200_1, var_200_1, var_200_1)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["10018"]) and arg_197_1.var_.actorSpriteComps10018 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_200_3 then
						iter_200_3.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps10018 = nil
			end

			local var_200_2 = arg_197_1.actors_["10015"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10015 == nil then
				arg_197_1.var_.actorSpriteComps10015 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps10015 then
					for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_200_5 then
							if arg_197_1.isInRecall_ then
								iter_200_5.color = Color.New(Mathf.Lerp(iter_200_5.color.r, arg_197_1.hightColor1.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_5.color.g, arg_197_1.hightColor1.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_5.color.b, arg_197_1.hightColor1.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_5.color.r, 1, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_5.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10015 then
				for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_200_7 then
						iter_200_7.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps10015 = nil
			end

			local var_200_5 = 0
			local var_200_6 = 0.675

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_7 = arg_197_1:GetWordFromCfg(114242048)
				local var_200_8 = arg_197_1:FormatText(var_200_7.content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_10 = 27 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 27)

				if (27 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 27)) > 0 and var_200_6 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_5
					end
				end

				arg_197_1.text_.text = var_200_8
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242048", "story_v_out_114242.awb") ~= 0 then
					local var_200_11 = manager.audio:GetVoiceLength("story_v_out_114242", "114242048", "story_v_out_114242.awb") / 1000

					if var_200_11 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_5
					end

					if var_200_7.prefab_name ~= "" and arg_197_1.actors_[var_200_7.prefab_name] ~= nil then
						local var_200_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_7.prefab_name].transform, "story_v_out_114242", "114242048", "story_v_out_114242.awb")

						arg_197_1:RecordAudio("114242048", var_200_12)
						arg_197_1:RecordAudio("114242048", var_200_12)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_114242", "114242048", "story_v_out_114242.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_114242", "114242048", "story_v_out_114242.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_13 = math.max(var_200_6, arg_197_1.talkMaxDuration)

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_13 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_5) / var_200_13

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_5 + var_200_13 and arg_197_1.time_ < var_200_5 + var_200_13 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play114242049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114242049
		arg_201_1.duration_ = 9.27

		local var_201_0 = {
			ja = 6.332999999999,
			ko = 7.999999999999,
			zh = 9.265999999999,
			en = 7.532999999999
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
				arg_201_0:Play114242050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				local var_204_0 = arg_201_1.bgs_.F01a

				arg_201_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_204_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_1 = var_204_0:GetComponent("SpriteRenderer")

				if var_204_1 and var_204_1.sprite then
					local var_204_2 = 2 * (var_204_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_204_0.transform.localScale = Vector3.New(var_204_2 / var_204_1.sprite.bounds.size.y < var_204_2 * manager.ui.mainCameraCom_.aspect / var_204_1.sprite.bounds.size.x and var_204_2 * manager.ui.mainCameraCom_.aspect / var_204_1.sprite.bounds.size.x or var_204_2 / var_204_1.sprite.bounds.size.y, var_204_2 / var_204_1.sprite.bounds.size.y < var_204_2 * manager.ui.mainCameraCom_.aspect / var_204_1.sprite.bounds.size.x and var_204_2 * manager.ui.mainCameraCom_.aspect / var_204_1.sprite.bounds.size.x or var_204_2 / var_204_1.sprite.bounds.size.y, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "F01a" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_3 = arg_201_1.actors_["10015"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10015 = var_204_3.localPosition
				var_204_3.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10015", 7)

				for iter_204_2 = 0, var_204_3.childCount - 1 do
					local var_204_4 = var_204_3:GetChild(iter_204_2)

					if var_204_4.name == "split_5" or not string.find(var_204_4.name, "split") then
						var_204_4.gameObject:SetActive(true)
					else
						var_204_4.gameObject:SetActive(false)
					end
				end
			end

			local var_204_5 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_5 then
				var_204_3.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10015, Vector3.New(0, -2000, 450), (arg_201_1.time_ - 0) / var_204_5)
			end

			if arg_201_1.time_ >= 0 + var_204_5 and arg_201_1.time_ < 0 + var_204_5 + arg_204_0 then
				var_204_3.localPosition = Vector3.New(0, -2000, 450)
			end

			local var_204_6 = arg_201_1.actors_["10018"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10018 = var_204_6.localPosition
				var_204_6.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10018", 7)

				for iter_204_3 = 0, var_204_6.childCount - 1 do
					local var_204_7 = var_204_6:GetChild(iter_204_3)

					if var_204_7.name == "split_1" or not string.find(var_204_7.name, "split") then
						var_204_7.gameObject:SetActive(true)
					else
						var_204_7.gameObject:SetActive(false)
					end
				end
			end

			local var_204_8 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_8 then
				var_204_6.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10018, Vector3.New(0, -2000, -180), (arg_201_1.time_ - 0) / var_204_8)
			end

			if arg_201_1.time_ >= 0 + var_204_8 and arg_201_1.time_ < 0 + var_204_8 + arg_204_0 then
				var_204_6.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_204_9 = 0

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_10 = 2

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_10 then
				local var_204_11 = Color.New(1, 1, 1)

				var_204_11.a = Mathf.Lerp(1, 0, (arg_201_1.time_ - var_204_9) / var_204_10)
				arg_201_1.mask_.color = var_204_11
			end

			if arg_201_1.time_ >= var_204_9 + var_204_10 and arg_201_1.time_ < var_204_9 + var_204_10 + arg_204_0 then
				local var_204_12 = Color.New(1, 1, 1)

				arg_201_1.mask_.enabled = false
				var_204_12.a = 0
				arg_201_1.mask_.color = var_204_12
			end

			local var_204_13 = 2

			if 2 < arg_201_1.time_ and arg_201_1.time_ <= var_204_13 + arg_204_0 then
				arg_201_1.var_.shakeOldPos = var_204_6.localPosition
			end

			local var_204_14 = 0.6

			if var_204_13 <= arg_201_1.time_ and arg_201_1.time_ < var_204_13 + var_204_14 then
				local var_204_15, var_204_16 = math.modf((arg_201_1.time_ - var_204_13) / 0)

				var_204_6.localPosition = Vector3.New(var_204_16 * 0, var_204_16 * 0, var_204_16 * 0) + arg_201_1.var_.shakeOldPos
			end

			if arg_201_1.time_ >= var_204_13 + var_204_14 and arg_201_1.time_ < var_204_13 + var_204_14 + arg_204_0 then
				var_204_6.localPosition = arg_201_1.var_.shakeOldPos
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_17 = 1.999999999999
			local var_204_18 = 0.475

			if 1.999999999999 < arg_201_1.time_ and arg_201_1.time_ <= var_204_17 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_19 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_19:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_20 = arg_201_1:GetWordFromCfg(114242049)
				local var_204_21 = arg_201_1:FormatText(var_204_20.content)

				arg_201_1.text_.text = var_204_21

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_23 = 19 <= 0 and var_204_18 or var_204_18 * (utf8.len(var_204_21) / 19)

				if (19 <= 0 and var_204_18 or var_204_18 * (utf8.len(var_204_21) / 19)) > 0 and var_204_18 < var_204_23 then
					arg_201_1.talkMaxDuration = var_204_23
					var_204_17 = var_204_17 + 0.3

					if var_204_23 + var_204_17 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_23 + var_204_17
					end
				end

				arg_201_1.text_.text = var_204_21
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242049", "story_v_out_114242.awb") ~= 0 then
					local var_204_24 = manager.audio:GetVoiceLength("story_v_out_114242", "114242049", "story_v_out_114242.awb") / 1000

					if var_204_24 + var_204_17 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_24 + var_204_17
					end

					if var_204_20.prefab_name ~= "" and arg_201_1.actors_[var_204_20.prefab_name] ~= nil then
						local var_204_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_20.prefab_name].transform, "story_v_out_114242", "114242049", "story_v_out_114242.awb")

						arg_201_1:RecordAudio("114242049", var_204_25)
						arg_201_1:RecordAudio("114242049", var_204_25)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114242", "114242049", "story_v_out_114242.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114242", "114242049", "story_v_out_114242.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_26 = var_204_17 + 0.3
			local var_204_27 = math.max(var_204_18, arg_201_1.talkMaxDuration)

			if var_204_17 + 0.3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_26 + var_204_27 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_26) / var_204_27

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_26 + var_204_27 and arg_201_1.time_ < var_204_26 + var_204_27 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10018",
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
	Play114242050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 114242050
		arg_207_1.duration_ = 5.3

		local var_207_0 = {
			ja = 3.566,
			ko = 5.066,
			zh = 5.3,
			en = 3.933
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
				arg_207_0:Play114242051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10018 = arg_207_1.actors_["10018"].transform.localPosition
				arg_207_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10018", 3)

				for iter_210_0 = 0, arg_207_1.actors_["10018"].transform.childCount - 1 do
					local var_210_0 = arg_207_1.actors_["10018"].transform:GetChild(iter_210_0)

					if var_210_0.name == "split_5" or not string.find(var_210_0.name, "split") then
						var_210_0.gameObject:SetActive(true)
					else
						var_210_0.gameObject:SetActive(false)
					end
				end
			end

			local var_210_1 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 then
				arg_207_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10018, Vector3.New(0, -350, -180), (arg_207_1.time_ - 0) / var_210_1)
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 then
				arg_207_1.actors_["10018"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_210_2 = arg_207_1.actors_["10018"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps10018 == nil then
				arg_207_1.var_.actorSpriteComps10018 = var_210_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_3 = 0.034

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.actorSpriteComps10018 then
					for iter_210_1, iter_210_2 in pairs(arg_207_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_210_2 then
							if arg_207_1.isInRecall_ then
								iter_210_2.color = Color.New(Mathf.Lerp(iter_210_2.color.r, arg_207_1.hightColor1.r, (arg_207_1.time_ - 0) / var_210_3), Mathf.Lerp(iter_210_2.color.g, arg_207_1.hightColor1.g, (arg_207_1.time_ - 0) / var_210_3), (Mathf.Lerp(iter_210_2.color.b, arg_207_1.hightColor1.b, (arg_207_1.time_ - 0) / var_210_3)))
							else
								local var_210_4 = Mathf.Lerp(iter_210_2.color.r, 1, (arg_207_1.time_ - 0) / var_210_3)

								iter_210_2.color = Color.New(var_210_4, var_210_4, var_210_4)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps10018 then
				for iter_210_3, iter_210_4 in pairs(arg_207_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_210_4 then
						iter_210_4.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_207_1.var_.actorSpriteComps10018 = nil
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				local var_210_5 = arg_207_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_210_5 then
					arg_207_1.var_.alphaOldValue10018 = var_210_5.alpha
					arg_207_1.var_.characterEffect10018 = var_210_5
				end

				arg_207_1.var_.alphaOldValue10018 = 0
			end

			local var_210_6 = 0.5

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_6 then
				if arg_207_1.var_.characterEffect10018 then
					arg_207_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_207_1.var_.alphaOldValue10018, 1, (arg_207_1.time_ - 0) / var_210_6)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_6 and arg_207_1.time_ < 0 + var_210_6 + arg_210_0 and arg_207_1.var_.characterEffect10018 then
				arg_207_1.var_.characterEffect10018.alpha = 1
			end

			local var_210_7 = 0
			local var_210_8 = 0.475

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_9 = arg_207_1:GetWordFromCfg(114242050)
				local var_210_10 = arg_207_1:FormatText(var_210_9.content)

				arg_207_1.text_.text = var_210_10

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_12 = 19 <= 0 and var_210_8 or var_210_8 * (utf8.len(var_210_10) / 19)

				if (19 <= 0 and var_210_8 or var_210_8 * (utf8.len(var_210_10) / 19)) > 0 and var_210_8 < var_210_12 then
					arg_207_1.talkMaxDuration = var_210_12

					if var_210_12 + var_210_7 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_7
					end
				end

				arg_207_1.text_.text = var_210_10
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242050", "story_v_out_114242.awb") ~= 0 then
					local var_210_13 = manager.audio:GetVoiceLength("story_v_out_114242", "114242050", "story_v_out_114242.awb") / 1000

					if var_210_13 + var_210_7 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_7
					end

					if var_210_9.prefab_name ~= "" and arg_207_1.actors_[var_210_9.prefab_name] ~= nil then
						local var_210_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_9.prefab_name].transform, "story_v_out_114242", "114242050", "story_v_out_114242.awb")

						arg_207_1:RecordAudio("114242050", var_210_14)
						arg_207_1:RecordAudio("114242050", var_210_14)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_114242", "114242050", "story_v_out_114242.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_114242", "114242050", "story_v_out_114242.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_15 = math.max(var_210_8, arg_207_1.talkMaxDuration)

			if var_210_7 <= arg_207_1.time_ and arg_207_1.time_ < var_210_7 + var_210_15 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_7) / var_210_15

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_7 + var_210_15 and arg_207_1.time_ < var_210_7 + var_210_15 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114242051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 114242051
		arg_211_1.duration_ = 4.83

		local var_211_0 = {
			ja = 3.766,
			ko = 4.833,
			zh = 4.6,
			en = 4.3
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
				arg_211_0:Play114242052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10018"]) and arg_211_1.var_.actorSpriteComps10018 == nil then
				arg_211_1.var_.actorSpriteComps10018 = arg_211_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 0.034

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10018"]) then
				if arg_211_1.var_.actorSpriteComps10018 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								iter_214_1.color = Color.New(Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, (arg_211_1.time_ - 0) / var_214_0), Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, (arg_211_1.time_ - 0) / var_214_0), (Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, (arg_211_1.time_ - 0) / var_214_0)))
							else
								local var_214_1 = Mathf.Lerp(iter_214_1.color.r, 0.5, (arg_211_1.time_ - 0) / var_214_0)

								iter_214_1.color = Color.New(var_214_1, var_214_1, var_214_1)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10018"]) and arg_211_1.var_.actorSpriteComps10018 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_211_1.var_.actorSpriteComps10018 = nil
			end

			local var_214_2 = 0
			local var_214_3 = 0.475

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_4 = arg_211_1:GetWordFromCfg(114242051)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 19 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 19)

				if (19 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 19)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242051", "story_v_out_114242.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242051", "story_v_out_114242.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_out_114242", "114242051", "story_v_out_114242.awb")

						arg_211_1:RecordAudio("114242051", var_214_9)
						arg_211_1:RecordAudio("114242051", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_114242", "114242051", "story_v_out_114242.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_114242", "114242051", "story_v_out_114242.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_10 and arg_211_1.time_ < var_214_2 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play114242052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 114242052
		arg_215_1.duration_ = 3.57

		local var_215_0 = {
			ja = 3.533,
			ko = 3.566,
			zh = 2.866,
			en = 3.366
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play114242053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.225

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:GetWordFromCfg(114242052)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 9 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 9)

				if (9 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 9)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242052", "story_v_out_114242.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_114242", "114242052", "story_v_out_114242.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_114242", "114242052", "story_v_out_114242.awb")

						arg_215_1:RecordAudio("114242052", var_218_6)
						arg_215_1:RecordAudio("114242052", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_114242", "114242052", "story_v_out_114242.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_114242", "114242052", "story_v_out_114242.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play114242053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 114242053
		arg_219_1.duration_ = 3.03

		local var_219_0 = {
			ja = 3.033,
			ko = 2.033,
			zh = 2.433,
			en = 2.033
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play114242054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.175

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[233].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:GetWordFromCfg(114242053)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 7 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 7)

				if (7 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 7)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242053", "story_v_out_114242.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_114242", "114242053", "story_v_out_114242.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_114242", "114242053", "story_v_out_114242.awb")

						arg_219_1:RecordAudio("114242053", var_222_6)
						arg_219_1:RecordAudio("114242053", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_114242", "114242053", "story_v_out_114242.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_114242", "114242053", "story_v_out_114242.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play114242054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 114242054
		arg_223_1.duration_ = 12.73

		local var_223_0 = {
			ja = 9.266,
			ko = 10.433,
			zh = 12.733,
			en = 10.566
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play114242055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["10018"]) and arg_223_1.var_.actorSpriteComps10018 == nil then
				arg_223_1.var_.actorSpriteComps10018 = arg_223_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.034

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["10018"]) then
				if arg_223_1.var_.actorSpriteComps10018 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								iter_226_1.color = Color.New(Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor1.r, (arg_223_1.time_ - 0) / var_226_0), Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor1.g, (arg_223_1.time_ - 0) / var_226_0), (Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor1.b, (arg_223_1.time_ - 0) / var_226_0)))
							else
								local var_226_1 = Mathf.Lerp(iter_226_1.color.r, 1, (arg_223_1.time_ - 0) / var_226_0)

								iter_226_1.color = Color.New(var_226_1, var_226_1, var_226_1)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["10018"]) and arg_223_1.var_.actorSpriteComps10018 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps10018 = nil
			end

			local var_226_2 = arg_223_1.actors_["10018"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10018 = var_226_2.localPosition
				var_226_2.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10018", 3)

				for iter_226_4 = 0, var_226_2.childCount - 1 do
					local var_226_3 = var_226_2:GetChild(iter_226_4)

					if var_226_3.name == "split_1" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_2.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10018, Vector3.New(0, -350, -180), (arg_223_1.time_ - 0) / var_226_4)
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_226_5 = 0
			local var_226_6 = 1.15

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:GetWordFromCfg(114242054)
				local var_226_8 = arg_223_1:FormatText(var_226_7.content)

				arg_223_1.text_.text = var_226_8

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 46 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 46)

				if (46 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 46)) > 0 and var_226_6 < var_226_10 then
					arg_223_1.talkMaxDuration = var_226_10

					if var_226_10 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_8
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242054", "story_v_out_114242.awb") ~= 0 then
					local var_226_11 = manager.audio:GetVoiceLength("story_v_out_114242", "114242054", "story_v_out_114242.awb") / 1000

					if var_226_11 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_5
					end

					if var_226_7.prefab_name ~= "" and arg_223_1.actors_[var_226_7.prefab_name] ~= nil then
						local var_226_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_7.prefab_name].transform, "story_v_out_114242", "114242054", "story_v_out_114242.awb")

						arg_223_1:RecordAudio("114242054", var_226_12)
						arg_223_1:RecordAudio("114242054", var_226_12)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_114242", "114242054", "story_v_out_114242.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_114242", "114242054", "story_v_out_114242.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_13 = math.max(var_226_6, arg_223_1.talkMaxDuration)

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_13 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_5) / var_226_13

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_5 + var_226_13 and arg_223_1.time_ < var_226_5 + var_226_13 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play114242055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 114242055
		arg_227_1.duration_ = 4.9

		local var_227_0 = {
			ja = 3.9,
			ko = 4.9,
			zh = 4.166,
			en = 3.8
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play114242056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.45

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(114242055)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 18 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 18)

				if (18 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 18)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242055", "story_v_out_114242.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_114242", "114242055", "story_v_out_114242.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_114242", "114242055", "story_v_out_114242.awb")

						arg_227_1:RecordAudio("114242055", var_230_6)
						arg_227_1:RecordAudio("114242055", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_114242", "114242055", "story_v_out_114242.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_114242", "114242055", "story_v_out_114242.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play114242056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 114242056
		arg_231_1.duration_ = 1.37

		local var_231_0 = {
			ja = 1.366,
			ko = 1.1,
			zh = 0.999999999999,
			en = 1.066
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play114242057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10018 = arg_231_1.actors_["10018"].transform.localPosition
				arg_231_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10018", 2)

				for iter_234_0 = 0, arg_231_1.actors_["10018"].transform.childCount - 1 do
					local var_234_0 = arg_231_1.actors_["10018"].transform:GetChild(iter_234_0)

					if var_234_0.name == "split_1" or not string.find(var_234_0.name, "split") then
						var_234_0.gameObject:SetActive(true)
					else
						var_234_0.gameObject:SetActive(false)
					end
				end
			end

			local var_234_1 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 then
				arg_231_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_231_1.time_ - 0) / var_234_1)
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 then
				arg_231_1.actors_["10018"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_234_2 = arg_231_1.actors_["104201_1"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos104201_1 = var_234_2.localPosition
				var_234_2.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("104201_1", 4)
			end

			local var_234_3 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 then
				var_234_2.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104201_1, Vector3.New(390, -350, -180), (arg_231_1.time_ - 0) / var_234_3)
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 then
				var_234_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_234_4 = arg_231_1.actors_["10018"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.actorSpriteComps10018 == nil then
				arg_231_1.var_.actorSpriteComps10018 = var_234_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_5 = 0.034

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_5 and not isNil(var_234_4) then
				if arg_231_1.var_.actorSpriteComps10018 then
					for iter_234_1, iter_234_2 in pairs(arg_231_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_234_2 then
							if arg_231_1.isInRecall_ then
								iter_234_2.color = Color.New(Mathf.Lerp(iter_234_2.color.r, arg_231_1.hightColor2.r, (arg_231_1.time_ - 0) / var_234_5), Mathf.Lerp(iter_234_2.color.g, arg_231_1.hightColor2.g, (arg_231_1.time_ - 0) / var_234_5), (Mathf.Lerp(iter_234_2.color.b, arg_231_1.hightColor2.b, (arg_231_1.time_ - 0) / var_234_5)))
							else
								local var_234_6 = Mathf.Lerp(iter_234_2.color.r, 0.5, (arg_231_1.time_ - 0) / var_234_5)

								iter_234_2.color = Color.New(var_234_6, var_234_6, var_234_6)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_5 and arg_231_1.time_ < 0 + var_234_5 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.actorSpriteComps10018 then
				for iter_234_3, iter_234_4 in pairs(arg_231_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_234_4 then
						iter_234_4.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps10018 = nil
			end

			local var_234_7 = arg_231_1.actors_["104201_1"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_7) then
				local var_234_8 = var_234_7:GetComponent("Image")

				if var_234_8 then
					arg_231_1.var_.highlightMatValue104201_1 = var_234_8
				end
			end

			local var_234_9 = 0.034

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_9 and not isNil(var_234_7) then
				if arg_231_1.var_.highlightMatValue104201_1 then
					local var_234_10 = Mathf.Lerp(0.5, 1, (arg_231_1.time_ - 0) / var_234_9)

					arg_231_1.var_.highlightMatValue104201_1.color.r = var_234_10
					arg_231_1.var_.highlightMatValue104201_1.color.g = var_234_10
					arg_231_1.var_.highlightMatValue104201_1.color.b = var_234_10
					arg_231_1.var_.highlightMatValue104201_1.color = arg_231_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_231_1.time_ >= 0 + var_234_9 and arg_231_1.time_ < 0 + var_234_9 + arg_234_0 and not isNil(var_234_7) and arg_231_1.var_.highlightMatValue104201_1 then
				var_234_7.transform:SetSiblingIndex(1)

				arg_231_1.var_.highlightMatValue104201_1.color.r = 1
				arg_231_1.var_.highlightMatValue104201_1.color.g = 1
				arg_231_1.var_.highlightMatValue104201_1.color.b = 1
				arg_231_1.var_.highlightMatValue104201_1.color = arg_231_1.var_.highlightMatValue104201_1.color
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				local var_234_11 = arg_231_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_234_11 then
					arg_231_1.var_.alphaOldValue10018 = var_234_11.alpha
					arg_231_1.var_.characterEffect10018 = var_234_11
				end

				arg_231_1.var_.alphaOldValue10018 = 0
			end

			local var_234_12 = 0.5

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_12 then
				if arg_231_1.var_.characterEffect10018 then
					arg_231_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_231_1.var_.alphaOldValue10018, 1, (arg_231_1.time_ - 0) / var_234_12)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_12 and arg_231_1.time_ < 0 + var_234_12 + arg_234_0 and arg_231_1.var_.characterEffect10018 then
				arg_231_1.var_.characterEffect10018.alpha = 1
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				local var_234_13 = arg_231_1.actors_["104201_1"]:GetComponent("Image")

				if var_234_13 then
					arg_231_1.var_.alphaMatValue104201_1 = var_234_13
					arg_231_1.var_.alphaOldValue104201_1 = var_234_13.color.a
				end

				arg_231_1.var_.alphaOldValue104201_1 = 0
			end

			local var_234_14 = 0.5

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_14 then
				if arg_231_1.var_.alphaMatValue104201_1 then
					arg_231_1.var_.alphaMatValue104201_1.color.a = Mathf.Lerp(arg_231_1.var_.alphaOldValue104201_1, 1, (arg_231_1.time_ - 0) / var_234_14)
					arg_231_1.var_.alphaMatValue104201_1.color = arg_231_1.var_.alphaMatValue104201_1.color
				end
			end

			if arg_231_1.time_ >= 0 + var_234_14 and arg_231_1.time_ < 0 + var_234_14 + arg_234_0 and arg_231_1.var_.alphaMatValue104201_1 then
				arg_231_1.var_.alphaMatValue104201_1.color.a = 1
				arg_231_1.var_.alphaMatValue104201_1.color = arg_231_1.var_.alphaMatValue104201_1.color
			end

			local var_234_15 = 0
			local var_234_16 = 0.075

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_17 = arg_231_1:GetWordFromCfg(114242056)
				local var_234_18 = arg_231_1:FormatText(var_234_17.content)

				arg_231_1.text_.text = var_234_18

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_20 = 3 <= 0 and var_234_16 or var_234_16 * (utf8.len(var_234_18) / 3)

				if (3 <= 0 and var_234_16 or var_234_16 * (utf8.len(var_234_18) / 3)) > 0 and var_234_16 < var_234_20 then
					arg_231_1.talkMaxDuration = var_234_20

					if var_234_20 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_20 + var_234_15
					end
				end

				arg_231_1.text_.text = var_234_18
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242056", "story_v_out_114242.awb") ~= 0 then
					local var_234_21 = manager.audio:GetVoiceLength("story_v_out_114242", "114242056", "story_v_out_114242.awb") / 1000

					if var_234_21 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_21 + var_234_15
					end

					if var_234_17.prefab_name ~= "" and arg_231_1.actors_[var_234_17.prefab_name] ~= nil then
						local var_234_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_17.prefab_name].transform, "story_v_out_114242", "114242056", "story_v_out_114242.awb")

						arg_231_1:RecordAudio("114242056", var_234_22)
						arg_231_1:RecordAudio("114242056", var_234_22)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_114242", "114242056", "story_v_out_114242.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_114242", "114242056", "story_v_out_114242.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_23 = math.max(var_234_16, arg_231_1.talkMaxDuration)

			if var_234_15 <= arg_231_1.time_ and arg_231_1.time_ < var_234_15 + var_234_23 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_15) / var_234_23

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_15 + var_234_23 and arg_231_1.time_ < var_234_15 + var_234_23 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104201_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play114242057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 114242057
		arg_235_1.duration_ = 1

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play114242058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10018"]) and arg_235_1.var_.actorSpriteComps10018 == nil then
				arg_235_1.var_.actorSpriteComps10018 = arg_235_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_0 = 0.034

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["10018"]) then
				if arg_235_1.var_.actorSpriteComps10018 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								iter_238_1.color = Color.New(Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 0) / var_238_0), Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 0) / var_238_0), (Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 0) / var_238_0)))
							else
								local var_238_1 = Mathf.Lerp(iter_238_1.color.r, 1, (arg_235_1.time_ - 0) / var_238_0)

								iter_238_1.color = Color.New(var_238_1, var_238_1, var_238_1)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["10018"]) and arg_235_1.var_.actorSpriteComps10018 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_238_3 then
						iter_238_3.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps10018 = nil
			end

			local var_238_2 = arg_235_1.actors_["104201_1"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) then
				local var_238_3 = var_238_2:GetComponent("Image")

				if var_238_3 then
					arg_235_1.var_.highlightMatValue104201_1 = var_238_3
				end
			end

			local var_238_4 = 0.034

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 and not isNil(var_238_2) then
				if arg_235_1.var_.highlightMatValue104201_1 then
					local var_238_5 = Mathf.Lerp(1, 0.5, (arg_235_1.time_ - 0) / var_238_4)

					arg_235_1.var_.highlightMatValue104201_1.color.r = var_238_5
					arg_235_1.var_.highlightMatValue104201_1.color.g = var_238_5
					arg_235_1.var_.highlightMatValue104201_1.color.b = var_238_5
					arg_235_1.var_.highlightMatValue104201_1.color = arg_235_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.highlightMatValue104201_1 then
				arg_235_1.var_.highlightMatValue104201_1.color.r = 0.5
				arg_235_1.var_.highlightMatValue104201_1.color.g = 0.5
				arg_235_1.var_.highlightMatValue104201_1.color.b = 0.5
				arg_235_1.var_.highlightMatValue104201_1.color = arg_235_1.var_.highlightMatValue104201_1.color
			end

			local var_238_6 = 0
			local var_238_7 = 0.05

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_8 = arg_235_1:GetWordFromCfg(114242057)
				local var_238_9 = arg_235_1:FormatText(var_238_8.content)

				arg_235_1.text_.text = var_238_9

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 2 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_9) / 2)

				if (2 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_9) / 2)) > 0 and var_238_7 < var_238_11 then
					arg_235_1.talkMaxDuration = var_238_11

					if var_238_11 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_9
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242057", "story_v_out_114242.awb") ~= 0 then
					local var_238_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242057", "story_v_out_114242.awb") / 1000

					if var_238_12 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_12 + var_238_6
					end

					if var_238_8.prefab_name ~= "" and arg_235_1.actors_[var_238_8.prefab_name] ~= nil then
						local var_238_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_8.prefab_name].transform, "story_v_out_114242", "114242057", "story_v_out_114242.awb")

						arg_235_1:RecordAudio("114242057", var_238_13)
						arg_235_1:RecordAudio("114242057", var_238_13)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_114242", "114242057", "story_v_out_114242.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_114242", "114242057", "story_v_out_114242.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_14 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_14 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_14

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_14 and arg_235_1.time_ < var_238_6 + var_238_14 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play114242058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 114242058
		arg_239_1.duration_ = 7.33

		local var_239_0 = {
			ja = 6.533,
			ko = 5.633,
			zh = 7.333,
			en = 6.4
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play114242059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["10018"]) and arg_239_1.var_.actorSpriteComps10018 == nil then
				arg_239_1.var_.actorSpriteComps10018 = arg_239_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_0 = 0.034

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["10018"]) then
				if arg_239_1.var_.actorSpriteComps10018 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								iter_242_1.color = Color.New(Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor2.r, (arg_239_1.time_ - 0) / var_242_0), Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor2.g, (arg_239_1.time_ - 0) / var_242_0), (Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor2.b, (arg_239_1.time_ - 0) / var_242_0)))
							else
								local var_242_1 = Mathf.Lerp(iter_242_1.color.r, 0.5, (arg_239_1.time_ - 0) / var_242_0)

								iter_242_1.color = Color.New(var_242_1, var_242_1, var_242_1)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["10018"]) and arg_239_1.var_.actorSpriteComps10018 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_242_3 then
						iter_242_3.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_239_1.var_.actorSpriteComps10018 = nil
			end

			local var_242_2 = arg_239_1.actors_["104201_1"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) then
				local var_242_3 = var_242_2:GetComponent("Image")

				if var_242_3 then
					arg_239_1.var_.highlightMatValue104201_1 = var_242_3
				end
			end

			local var_242_4 = 0.034

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 and not isNil(var_242_2) then
				if arg_239_1.var_.highlightMatValue104201_1 then
					local var_242_5 = Mathf.Lerp(0.5, 1, (arg_239_1.time_ - 0) / var_242_4)

					arg_239_1.var_.highlightMatValue104201_1.color.r = var_242_5
					arg_239_1.var_.highlightMatValue104201_1.color.g = var_242_5
					arg_239_1.var_.highlightMatValue104201_1.color.b = var_242_5
					arg_239_1.var_.highlightMatValue104201_1.color = arg_239_1.var_.highlightMatValue104201_1.color
				end
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.highlightMatValue104201_1 then
				var_242_2.transform:SetSiblingIndex(1)

				arg_239_1.var_.highlightMatValue104201_1.color.r = 1
				arg_239_1.var_.highlightMatValue104201_1.color.g = 1
				arg_239_1.var_.highlightMatValue104201_1.color.b = 1
				arg_239_1.var_.highlightMatValue104201_1.color = arg_239_1.var_.highlightMatValue104201_1.color
			end

			local var_242_6 = 0
			local var_242_7 = 0.8

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_8 = arg_239_1:GetWordFromCfg(114242058)
				local var_242_9 = arg_239_1:FormatText(var_242_8.content)

				arg_239_1.text_.text = var_242_9

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_11 = 32 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_9) / 32)

				if (32 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_9) / 32)) > 0 and var_242_7 < var_242_11 then
					arg_239_1.talkMaxDuration = var_242_11

					if var_242_11 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_11 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_9
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242058", "story_v_out_114242.awb") ~= 0 then
					local var_242_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242058", "story_v_out_114242.awb") / 1000

					if var_242_12 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_12 + var_242_6
					end

					if var_242_8.prefab_name ~= "" and arg_239_1.actors_[var_242_8.prefab_name] ~= nil then
						local var_242_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_8.prefab_name].transform, "story_v_out_114242", "114242058", "story_v_out_114242.awb")

						arg_239_1:RecordAudio("114242058", var_242_13)
						arg_239_1:RecordAudio("114242058", var_242_13)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_114242", "114242058", "story_v_out_114242.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_114242", "114242058", "story_v_out_114242.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_14 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_14 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_14

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_14 and arg_239_1.time_ < var_242_6 + var_242_14 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play114242059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 114242059
		arg_243_1.duration_ = 10.47

		local var_243_0 = {
			ja = 10.466,
			ko = 10.033,
			zh = 10.333,
			en = 6.9
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play114242060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.9

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(114242059)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 37 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 37)

				if (37 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 37)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242059", "story_v_out_114242.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_114242", "114242059", "story_v_out_114242.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_114242", "114242059", "story_v_out_114242.awb")

						arg_243_1:RecordAudio("114242059", var_246_6)
						arg_243_1:RecordAudio("114242059", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_114242", "114242059", "story_v_out_114242.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_114242", "114242059", "story_v_out_114242.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play114242060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 114242060
		arg_247_1.duration_ = 9.83

		local var_247_0 = {
			ja = 8.732999999999,
			ko = 7.965999999999,
			zh = 9.832999999999,
			en = 9.065999999999
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
				arg_247_0:Play114242061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				local var_250_0 = arg_247_1.bgs_.ST25

				arg_247_1.bgs_.ST25.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_250_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_1 = var_250_0:GetComponent("SpriteRenderer")

				if var_250_1 and var_250_1.sprite then
					local var_250_2 = 2 * (var_250_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_250_0.transform.localScale = Vector3.New(var_250_2 / var_250_1.sprite.bounds.size.y < var_250_2 * manager.ui.mainCameraCom_.aspect / var_250_1.sprite.bounds.size.x and var_250_2 * manager.ui.mainCameraCom_.aspect / var_250_1.sprite.bounds.size.x or var_250_2 / var_250_1.sprite.bounds.size.y, var_250_2 / var_250_1.sprite.bounds.size.y < var_250_2 * manager.ui.mainCameraCom_.aspect / var_250_1.sprite.bounds.size.x and var_250_2 * manager.ui.mainCameraCom_.aspect / var_250_1.sprite.bounds.size.x or var_250_2 / var_250_1.sprite.bounds.size.y, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "ST25" then
						iter_250_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_250_3 = 0

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_3 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = false

				arg_247_1:SetGaussion(false)
			end

			local var_250_4 = 2

			if var_250_3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_3 + var_250_4 then
				local var_250_5 = Color.New(1, 1, 1)

				var_250_5.a = Mathf.Lerp(1, 0, (arg_247_1.time_ - var_250_3) / var_250_4)
				arg_247_1.mask_.color = var_250_5
			end

			if arg_247_1.time_ >= var_250_3 + var_250_4 and arg_247_1.time_ < var_250_3 + var_250_4 + arg_250_0 then
				local var_250_6 = Color.New(1, 1, 1)

				arg_247_1.mask_.enabled = false
				var_250_6.a = 0
				arg_247_1.mask_.color = var_250_6
			end

			local var_250_7 = arg_247_1.actors_["10018"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10018 = var_250_7.localPosition
				var_250_7.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10018", 7)

				for iter_250_2 = 0, var_250_7.childCount - 1 do
					local var_250_8 = var_250_7:GetChild(iter_250_2)

					if var_250_8.name == "split_1" or not string.find(var_250_8.name, "split") then
						var_250_8.gameObject:SetActive(true)
					else
						var_250_8.gameObject:SetActive(false)
					end
				end
			end

			local var_250_9 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_9 then
				var_250_7.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10018, Vector3.New(0, -2000, -180), (arg_247_1.time_ - 0) / var_250_9)
			end

			if arg_247_1.time_ >= 0 + var_250_9 and arg_247_1.time_ < 0 + var_250_9 + arg_250_0 then
				var_250_7.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_250_10 = arg_247_1.actors_["10018"].transform

			if 1.8 < arg_247_1.time_ and arg_247_1.time_ <= 1.8 + arg_250_0 then
				arg_247_1.var_.moveOldPos10018 = var_250_10.localPosition
				var_250_10.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10018", 2)

				for iter_250_3 = 0, var_250_10.childCount - 1 do
					local var_250_11 = var_250_10:GetChild(iter_250_3)

					if var_250_11.name == "split_1" or not string.find(var_250_11.name, "split") then
						var_250_11.gameObject:SetActive(true)
					else
						var_250_11.gameObject:SetActive(false)
					end
				end
			end

			local var_250_12 = 0.001

			if 1.8 <= arg_247_1.time_ and arg_247_1.time_ < 1.8 + var_250_12 then
				var_250_10.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_247_1.time_ - 1.8) / var_250_12)
			end

			if arg_247_1.time_ >= 1.8 + var_250_12 and arg_247_1.time_ < 1.8 + var_250_12 + arg_250_0 then
				var_250_10.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_250_13 = arg_247_1.actors_["104201_1"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos104201_1 = var_250_13.localPosition
				var_250_13.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("104201_1", 7)
			end

			local var_250_14 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_14 then
				var_250_13.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos104201_1, Vector3.New(0, -2000, -180), (arg_247_1.time_ - 0) / var_250_14)
			end

			if arg_247_1.time_ >= 0 + var_250_14 and arg_247_1.time_ < 0 + var_250_14 + arg_250_0 then
				var_250_13.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_250_15 = arg_247_1.actors_["10018"]

			if 1.8 < arg_247_1.time_ and arg_247_1.time_ <= 1.8 + arg_250_0 and not isNil(var_250_15) and arg_247_1.var_.actorSpriteComps10018 == nil then
				arg_247_1.var_.actorSpriteComps10018 = var_250_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_16 = 0.034

			if 1.8 <= arg_247_1.time_ and arg_247_1.time_ < 1.8 + var_250_16 and not isNil(var_250_15) then
				if arg_247_1.var_.actorSpriteComps10018 then
					for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_250_5 then
							if arg_247_1.isInRecall_ then
								iter_250_5.color = Color.New(Mathf.Lerp(iter_250_5.color.r, arg_247_1.hightColor1.r, (arg_247_1.time_ - 1.8) / var_250_16), Mathf.Lerp(iter_250_5.color.g, arg_247_1.hightColor1.g, (arg_247_1.time_ - 1.8) / var_250_16), (Mathf.Lerp(iter_250_5.color.b, arg_247_1.hightColor1.b, (arg_247_1.time_ - 1.8) / var_250_16)))
							else
								local var_250_17 = Mathf.Lerp(iter_250_5.color.r, 1, (arg_247_1.time_ - 1.8) / var_250_16)

								iter_250_5.color = Color.New(var_250_17, var_250_17, var_250_17)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 1.8 + var_250_16 and arg_247_1.time_ < 1.8 + var_250_16 + arg_250_0 and not isNil(var_250_15) and arg_247_1.var_.actorSpriteComps10018 then
				for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_250_7 then
						iter_250_7.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps10018 = nil
			end

			if 1.8 < arg_247_1.time_ and arg_247_1.time_ <= 1.8 + arg_250_0 then
				local var_250_18 = arg_247_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_250_18 then
					arg_247_1.var_.alphaOldValue10018 = var_250_18.alpha
					arg_247_1.var_.characterEffect10018 = var_250_18
				end

				arg_247_1.var_.alphaOldValue10018 = 0
			end

			local var_250_19 = 0.5

			if 1.8 <= arg_247_1.time_ and arg_247_1.time_ < 1.8 + var_250_19 then
				if arg_247_1.var_.characterEffect10018 then
					arg_247_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_247_1.var_.alphaOldValue10018, 1, (arg_247_1.time_ - 1.8) / var_250_19)
				end
			end

			if arg_247_1.time_ >= 1.8 + var_250_19 and arg_247_1.time_ < 1.8 + var_250_19 + arg_250_0 and arg_247_1.var_.characterEffect10018 then
				arg_247_1.var_.characterEffect10018.alpha = 1
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_20 = 1.999999999999
			local var_250_21 = 0.85

			if 1.999999999999 < arg_247_1.time_ and arg_247_1.time_ <= var_250_20 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_22 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_22:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_23 = arg_247_1:GetWordFromCfg(114242060)
				local var_250_24 = arg_247_1:FormatText(var_250_23.content)

				arg_247_1.text_.text = var_250_24

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_26 = 34 <= 0 and var_250_21 or var_250_21 * (utf8.len(var_250_24) / 34)

				if (34 <= 0 and var_250_21 or var_250_21 * (utf8.len(var_250_24) / 34)) > 0 and var_250_21 < var_250_26 then
					arg_247_1.talkMaxDuration = var_250_26
					var_250_20 = var_250_20 + 0.3

					if var_250_26 + var_250_20 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_26 + var_250_20
					end
				end

				arg_247_1.text_.text = var_250_24
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242060", "story_v_out_114242.awb") ~= 0 then
					local var_250_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242060", "story_v_out_114242.awb") / 1000

					if var_250_27 + var_250_20 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_27 + var_250_20
					end

					if var_250_23.prefab_name ~= "" and arg_247_1.actors_[var_250_23.prefab_name] ~= nil then
						local var_250_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_23.prefab_name].transform, "story_v_out_114242", "114242060", "story_v_out_114242.awb")

						arg_247_1:RecordAudio("114242060", var_250_28)
						arg_247_1:RecordAudio("114242060", var_250_28)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_114242", "114242060", "story_v_out_114242.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_114242", "114242060", "story_v_out_114242.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_29 = var_250_20 + 0.3
			local var_250_30 = math.max(var_250_21, arg_247_1.talkMaxDuration)

			if var_250_20 + 0.3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_29 + var_250_30 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_29) / var_250_30

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_29 + var_250_30 and arg_247_1.time_ < var_250_29 + var_250_30 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104201_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play114242061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 114242061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play114242062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["10018"]) and arg_253_1.var_.actorSpriteComps10018 == nil then
				arg_253_1.var_.actorSpriteComps10018 = arg_253_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_0 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["10018"]) then
				if arg_253_1.var_.actorSpriteComps10018 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								iter_256_1.color = Color.New(Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_0), Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_0), (Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_0)))
							else
								local var_256_1 = Mathf.Lerp(iter_256_1.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_0)

								iter_256_1.color = Color.New(var_256_1, var_256_1, var_256_1)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["10018"]) and arg_253_1.var_.actorSpriteComps10018 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_256_3 then
						iter_256_3.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps10018 = nil
			end

			local var_256_2 = 0
			local var_256_3 = 0.7

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_2 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_4 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(114242061).content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_6 = 28 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_4) / 28)

				if (28 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_4) / 28)) > 0 and var_256_3 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_2
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_3, arg_253_1.talkMaxDuration)

			if var_256_2 <= arg_253_1.time_ and arg_253_1.time_ < var_256_2 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_2) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_2 + var_256_7 and arg_253_1.time_ < var_256_2 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play114242062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 114242062
		arg_257_1.duration_ = 12.2

		local var_257_0 = {
			ja = 12.2,
			ko = 10.633,
			zh = 11.933,
			en = 8.633
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
				arg_257_0:Play114242063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["10018"]) and arg_257_1.var_.actorSpriteComps10018 == nil then
				arg_257_1.var_.actorSpriteComps10018 = arg_257_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_0 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["10018"]) then
				if arg_257_1.var_.actorSpriteComps10018 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								iter_260_1.color = Color.New(Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor1.r, (arg_257_1.time_ - 0) / var_260_0), Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor1.g, (arg_257_1.time_ - 0) / var_260_0), (Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor1.b, (arg_257_1.time_ - 0) / var_260_0)))
							else
								local var_260_1 = Mathf.Lerp(iter_260_1.color.r, 1, (arg_257_1.time_ - 0) / var_260_0)

								iter_260_1.color = Color.New(var_260_1, var_260_1, var_260_1)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["10018"]) and arg_257_1.var_.actorSpriteComps10018 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_260_3 then
						iter_260_3.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps10018 = nil
			end

			local var_260_2 = 0
			local var_260_3 = 1.3

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_4 = arg_257_1:GetWordFromCfg(114242062)
				local var_260_5 = arg_257_1:FormatText(var_260_4.content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 51 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 51)

				if (51 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 51)) > 0 and var_260_3 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242062", "story_v_out_114242.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242062", "story_v_out_114242.awb") / 1000

					if var_260_8 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_2
					end

					if var_260_4.prefab_name ~= "" and arg_257_1.actors_[var_260_4.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_4.prefab_name].transform, "story_v_out_114242", "114242062", "story_v_out_114242.awb")

						arg_257_1:RecordAudio("114242062", var_260_9)
						arg_257_1:RecordAudio("114242062", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_114242", "114242062", "story_v_out_114242.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_114242", "114242062", "story_v_out_114242.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_10 and arg_257_1.time_ < var_260_2 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play114242063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 114242063
		arg_261_1.duration_ = 12.2

		local var_261_0 = {
			ja = 12.2,
			ko = 10.6,
			zh = 9.866,
			en = 7.7
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
				arg_261_0:Play114242064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10015 = arg_261_1.actors_["10015"].transform.localPosition
				arg_261_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10015", 4)

				for iter_264_0 = 0, arg_261_1.actors_["10015"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["10015"].transform:GetChild(iter_264_0)

					if var_264_0.name == "split_1" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_264_2 = arg_261_1.actors_["10018"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10018 == nil then
				arg_261_1.var_.actorSpriteComps10018 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps10018 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								iter_264_2.color = Color.New(Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_2.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_2.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10018 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_264_4 then
						iter_264_4.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps10018 = nil
			end

			local var_264_5 = arg_261_1.actors_["10015"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.actorSpriteComps10015 == nil then
				arg_261_1.var_.actorSpriteComps10015 = var_264_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_6 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_6 and not isNil(var_264_5) then
				if arg_261_1.var_.actorSpriteComps10015 then
					for iter_264_5, iter_264_6 in pairs(arg_261_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_264_6 then
							if arg_261_1.isInRecall_ then
								iter_264_6.color = Color.New(Mathf.Lerp(iter_264_6.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_6), Mathf.Lerp(iter_264_6.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_6), (Mathf.Lerp(iter_264_6.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_6)))
							else
								local var_264_7 = Mathf.Lerp(iter_264_6.color.r, 1, (arg_261_1.time_ - 0) / var_264_6)

								iter_264_6.color = Color.New(var_264_7, var_264_7, var_264_7)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_6 and arg_261_1.time_ < 0 + var_264_6 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.actorSpriteComps10015 then
				for iter_264_7, iter_264_8 in pairs(arg_261_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_264_8 then
						iter_264_8.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				local var_264_8 = arg_261_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_264_8 then
					arg_261_1.var_.alphaOldValue10015 = var_264_8.alpha
					arg_261_1.var_.characterEffect10015 = var_264_8
				end

				arg_261_1.var_.alphaOldValue10015 = 0
			end

			local var_264_9 = 0.5

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_9 then
				if arg_261_1.var_.characterEffect10015 then
					arg_261_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_261_1.var_.alphaOldValue10015, 1, (arg_261_1.time_ - 0) / var_264_9)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_9 and arg_261_1.time_ < 0 + var_264_9 + arg_264_0 and arg_261_1.var_.characterEffect10015 then
				arg_261_1.var_.characterEffect10015.alpha = 1
			end

			local var_264_10 = 0
			local var_264_11 = 1.15

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_12 = arg_261_1:GetWordFromCfg(114242063)
				local var_264_13 = arg_261_1:FormatText(var_264_12.content)

				arg_261_1.text_.text = var_264_13

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_15 = 46 <= 0 and var_264_11 or var_264_11 * (utf8.len(var_264_13) / 46)

				if (46 <= 0 and var_264_11 or var_264_11 * (utf8.len(var_264_13) / 46)) > 0 and var_264_11 < var_264_15 then
					arg_261_1.talkMaxDuration = var_264_15

					if var_264_15 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_15 + var_264_10
					end
				end

				arg_261_1.text_.text = var_264_13
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242063", "story_v_out_114242.awb") ~= 0 then
					local var_264_16 = manager.audio:GetVoiceLength("story_v_out_114242", "114242063", "story_v_out_114242.awb") / 1000

					if var_264_16 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_16 + var_264_10
					end

					if var_264_12.prefab_name ~= "" and arg_261_1.actors_[var_264_12.prefab_name] ~= nil then
						local var_264_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_12.prefab_name].transform, "story_v_out_114242", "114242063", "story_v_out_114242.awb")

						arg_261_1:RecordAudio("114242063", var_264_17)
						arg_261_1:RecordAudio("114242063", var_264_17)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_114242", "114242063", "story_v_out_114242.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_114242", "114242063", "story_v_out_114242.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_18 = math.max(var_264_11, arg_261_1.talkMaxDuration)

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_18 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_10) / var_264_18

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_10 + var_264_18 and arg_261_1.time_ < var_264_10 + var_264_18 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114242064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 114242064
		arg_265_1.duration_ = 8.43

		local var_265_0 = {
			ja = 3.9,
			ko = 7.833,
			zh = 7.6,
			en = 8.433
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
				arg_265_0:Play114242065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.925

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:GetWordFromCfg(114242064)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 37 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 37)

				if (37 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 37)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242064", "story_v_out_114242.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_114242", "114242064", "story_v_out_114242.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_114242", "114242064", "story_v_out_114242.awb")

						arg_265_1:RecordAudio("114242064", var_268_6)
						arg_265_1:RecordAudio("114242064", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_114242", "114242064", "story_v_out_114242.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_114242", "114242064", "story_v_out_114242.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play114242065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 114242065
		arg_269_1.duration_ = 8.67

		local var_269_0 = {
			ja = 8.4,
			ko = 8.666,
			zh = 7.3,
			en = 8
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
				arg_269_0:Play114242066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.9

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:GetWordFromCfg(114242065)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 36 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 36)

				if (36 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 36)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242065", "story_v_out_114242.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_114242", "114242065", "story_v_out_114242.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_114242", "114242065", "story_v_out_114242.awb")

						arg_269_1:RecordAudio("114242065", var_272_6)
						arg_269_1:RecordAudio("114242065", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_114242", "114242065", "story_v_out_114242.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_114242", "114242065", "story_v_out_114242.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play114242066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 114242066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play114242067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["10015"]) and arg_273_1.var_.actorSpriteComps10015 == nil then
				arg_273_1.var_.actorSpriteComps10015 = arg_273_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_0 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["10015"]) then
				if arg_273_1.var_.actorSpriteComps10015 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_276_1 then
							if arg_273_1.isInRecall_ then
								iter_276_1.color = Color.New(Mathf.Lerp(iter_276_1.color.r, arg_273_1.hightColor2.r, (arg_273_1.time_ - 0) / var_276_0), Mathf.Lerp(iter_276_1.color.g, arg_273_1.hightColor2.g, (arg_273_1.time_ - 0) / var_276_0), (Mathf.Lerp(iter_276_1.color.b, arg_273_1.hightColor2.b, (arg_273_1.time_ - 0) / var_276_0)))
							else
								local var_276_1 = Mathf.Lerp(iter_276_1.color.r, 0.5, (arg_273_1.time_ - 0) / var_276_0)

								iter_276_1.color = Color.New(var_276_1, var_276_1, var_276_1)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["10015"]) and arg_273_1.var_.actorSpriteComps10015 then
				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_276_3 then
						iter_276_3.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_273_1.var_.actorSpriteComps10015 = nil
			end

			local var_276_2 = 0
			local var_276_3 = 1.65

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_4 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(114242066).content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_6 = 66 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_4) / 66)

				if (66 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_4) / 66)) > 0 and var_276_3 < var_276_6 then
					arg_273_1.talkMaxDuration = var_276_6

					if var_276_6 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_2
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_3, arg_273_1.talkMaxDuration)

			if var_276_2 <= arg_273_1.time_ and arg_273_1.time_ < var_276_2 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_2) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_2 + var_276_7 and arg_273_1.time_ < var_276_2 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play114242067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 114242067
		arg_277_1.duration_ = 6.63

		local var_277_0 = {
			ja = 6.633,
			ko = 4.466,
			zh = 4.1,
			en = 3.666
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
				arg_277_0:Play114242068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10015 = arg_277_1.actors_["10015"].transform.localPosition
				arg_277_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("10015", 4)

				for iter_280_0 = 0, arg_277_1.actors_["10015"].transform.childCount - 1 do
					local var_280_0 = arg_277_1.actors_["10015"].transform:GetChild(iter_280_0)

					if var_280_0.name == "split_2" or not string.find(var_280_0.name, "split") then
						var_280_0.gameObject:SetActive(true)
					else
						var_280_0.gameObject:SetActive(false)
					end
				end
			end

			local var_280_1 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_1 then
				arg_277_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_277_1.time_ - 0) / var_280_1)
			end

			if arg_277_1.time_ >= 0 + var_280_1 and arg_277_1.time_ < 0 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_280_2 = arg_277_1.actors_["10015"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps10015 == nil then
				arg_277_1.var_.actorSpriteComps10015 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 0.034

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps10015 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								iter_280_2.color = Color.New(Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_2.color.r, 1, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_2.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps10015 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_280_4 then
						iter_280_4.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps10015 = nil
			end

			local var_280_5 = 0
			local var_280_6 = 0.45

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_7 = arg_277_1:GetWordFromCfg(114242067)
				local var_280_8 = arg_277_1:FormatText(var_280_7.content)

				arg_277_1.text_.text = var_280_8

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_10 = 18 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 18)

				if (18 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 18)) > 0 and var_280_6 < var_280_10 then
					arg_277_1.talkMaxDuration = var_280_10

					if var_280_10 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_5
					end
				end

				arg_277_1.text_.text = var_280_8
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242067", "story_v_out_114242.awb") ~= 0 then
					local var_280_11 = manager.audio:GetVoiceLength("story_v_out_114242", "114242067", "story_v_out_114242.awb") / 1000

					if var_280_11 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_5
					end

					if var_280_7.prefab_name ~= "" and arg_277_1.actors_[var_280_7.prefab_name] ~= nil then
						local var_280_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_7.prefab_name].transform, "story_v_out_114242", "114242067", "story_v_out_114242.awb")

						arg_277_1:RecordAudio("114242067", var_280_12)
						arg_277_1:RecordAudio("114242067", var_280_12)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_114242", "114242067", "story_v_out_114242.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_114242", "114242067", "story_v_out_114242.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_13 = math.max(var_280_6, arg_277_1.talkMaxDuration)

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_13 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_5) / var_280_13

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_5 + var_280_13 and arg_277_1.time_ < var_280_5 + var_280_13 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114242068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 114242068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play114242069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["10015"]) and arg_281_1.var_.actorSpriteComps10015 == nil then
				arg_281_1.var_.actorSpriteComps10015 = arg_281_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_0 = 0.034

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["10015"]) then
				if arg_281_1.var_.actorSpriteComps10015 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								iter_284_1.color = Color.New(Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor2.r, (arg_281_1.time_ - 0) / var_284_0), Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor2.g, (arg_281_1.time_ - 0) / var_284_0), (Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor2.b, (arg_281_1.time_ - 0) / var_284_0)))
							else
								local var_284_1 = Mathf.Lerp(iter_284_1.color.r, 0.5, (arg_281_1.time_ - 0) / var_284_0)

								iter_284_1.color = Color.New(var_284_1, var_284_1, var_284_1)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["10015"]) and arg_281_1.var_.actorSpriteComps10015 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_284_3 then
						iter_284_3.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps10015 = nil
			end

			local var_284_2 = 0
			local var_284_3 = 0.875

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_4 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(114242068).content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_6 = 35 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_4) / 35)

				if (35 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_4) / 35)) > 0 and var_284_3 < var_284_6 then
					arg_281_1.talkMaxDuration = var_284_6

					if var_284_6 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_7 and arg_281_1.time_ < var_284_2 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play114242069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 114242069
		arg_285_1.duration_ = 1.5

		local var_285_0 = {
			ja = 1.5,
			ko = 1.4,
			en = 1.4
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
				arg_285_0:Play114242070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["10015"]) and arg_285_1.var_.actorSpriteComps10015 == nil then
				arg_285_1.var_.actorSpriteComps10015 = arg_285_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["10015"]) then
				if arg_285_1.var_.actorSpriteComps10015 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								iter_288_1.color = Color.New(Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor1.r, (arg_285_1.time_ - 0) / var_288_0), Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor1.g, (arg_285_1.time_ - 0) / var_288_0), (Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor1.b, (arg_285_1.time_ - 0) / var_288_0)))
							else
								local var_288_1 = Mathf.Lerp(iter_288_1.color.r, 1, (arg_285_1.time_ - 0) / var_288_0)

								iter_288_1.color = Color.New(var_288_1, var_288_1, var_288_1)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10015"]) and arg_285_1.var_.actorSpriteComps10015 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps10015 = nil
			end

			local var_288_2 = arg_285_1.actors_["10015"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10015 = var_288_2.localPosition
				var_288_2.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10015", 4)

				for iter_288_4 = 0, var_288_2.childCount - 1 do
					local var_288_3 = var_288_2:GetChild(iter_288_4)

					if var_288_3.name == "split_1" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				var_288_2.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_285_1.time_ - 0) / var_288_4)
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				var_288_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_288_5 = 0
			local var_288_6 = 0.05

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_7 = arg_285_1:GetWordFromCfg(114242069)
				local var_288_8 = arg_285_1:FormatText(var_288_7.content)

				arg_285_1.text_.text = var_288_8

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_10 = 2 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 2)

				if (2 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 2)) > 0 and var_288_6 < var_288_10 then
					arg_285_1.talkMaxDuration = var_288_10

					if var_288_10 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_5
					end
				end

				arg_285_1.text_.text = var_288_8
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242069", "story_v_out_114242.awb") ~= 0 then
					local var_288_11 = manager.audio:GetVoiceLength("story_v_out_114242", "114242069", "story_v_out_114242.awb") / 1000

					if var_288_11 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_5
					end

					if var_288_7.prefab_name ~= "" and arg_285_1.actors_[var_288_7.prefab_name] ~= nil then
						local var_288_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_7.prefab_name].transform, "story_v_out_114242", "114242069", "story_v_out_114242.awb")

						arg_285_1:RecordAudio("114242069", var_288_12)
						arg_285_1:RecordAudio("114242069", var_288_12)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_114242", "114242069", "story_v_out_114242.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_114242", "114242069", "story_v_out_114242.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_13 = math.max(var_288_6, arg_285_1.talkMaxDuration)

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_13 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_5) / var_288_13

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_5 + var_288_13 and arg_285_1.time_ < var_288_5 + var_288_13 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114242070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 114242070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play114242071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				local var_292_0 = arg_289_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_292_0 then
					arg_289_1.var_.alphaOldValue10015 = var_292_0.alpha
					arg_289_1.var_.characterEffect10015 = var_292_0
				end

				arg_289_1.var_.alphaOldValue10015 = 1
			end

			local var_292_1 = 0.5

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 then
				if arg_289_1.var_.characterEffect10015 then
					arg_289_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_289_1.var_.alphaOldValue10015, 0, (arg_289_1.time_ - 0) / var_292_1)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 and arg_289_1.var_.characterEffect10015 then
				arg_289_1.var_.characterEffect10015.alpha = 0
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				local var_292_2 = arg_289_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_292_2 then
					arg_289_1.var_.alphaOldValue10018 = var_292_2.alpha
					arg_289_1.var_.characterEffect10018 = var_292_2
				end

				arg_289_1.var_.alphaOldValue10018 = 1
			end

			local var_292_3 = 0.5

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 then
				if arg_289_1.var_.characterEffect10018 then
					arg_289_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_289_1.var_.alphaOldValue10018, 0, (arg_289_1.time_ - 0) / var_292_3)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and arg_289_1.var_.characterEffect10018 then
				arg_289_1.var_.characterEffect10018.alpha = 0
			end

			local var_292_4 = 0
			local var_292_5 = 0.675

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(114242070).content)

				arg_289_1.text_.text = var_292_6

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_8 = 27 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_6) / 27)

				if (27 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_6) / 27)) > 0 and var_292_5 < var_292_8 then
					arg_289_1.talkMaxDuration = var_292_8

					if var_292_8 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_6
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_9 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_9 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_9

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_9 and arg_289_1.time_ < var_292_4 + var_292_9 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play114242071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 114242071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play114242072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1.15

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(114242071).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 46 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 46)

				if (46 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 46)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play114242072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 114242072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play114242073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.475

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(114242072).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 19 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 19)

				if (19 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 19)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play114242073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 114242073
		arg_301_1.duration_ = 6.63

		local var_301_0 = {
			ja = 6.633,
			ko = 5.733,
			zh = 5.5,
			en = 6.566
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
				arg_301_0:Play114242074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_304_0 = 0.6

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				local var_304_1, var_304_2 = math.modf((arg_301_1.time_ - 0) / 0)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_304_2 * 0, var_304_2 * 0, var_304_2 * 0) + arg_301_1.var_.shakeOldPos
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				manager.ui.mainCamera.transform.localPosition = arg_301_1.var_.shakeOldPos
			end

			local var_304_3 = 0

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_3 + arg_304_0 then
				arg_301_1.allBtn_.enabled = false
			end

			if arg_301_1.time_ >= var_304_3 + 0.6 and arg_301_1.time_ < var_304_3 + 0.6 + arg_304_0 then
				arg_301_1.allBtn_.enabled = true
			end

			local var_304_4 = 0
			local var_304_5 = 0.6

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(114242073)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 24 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 24)

				if (24 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 24)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242073", "story_v_out_114242.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_out_114242", "114242073", "story_v_out_114242.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_out_114242", "114242073", "story_v_out_114242.awb")

						arg_301_1:RecordAudio("114242073", var_304_11)
						arg_301_1:RecordAudio("114242073", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_114242", "114242073", "story_v_out_114242.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_114242", "114242073", "story_v_out_114242.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play114242074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 114242074
		arg_305_1.duration_ = 1.17

		local var_305_0 = {
			ja = 1.166,
			ko = 0.999999999999,
			zh = 0.999999999999,
			en = 1.166
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play114242075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:AudioAction("play", "effect", "se_story_activity_1_4_3", "se_story_activity_1_4_3_sword", "")
			end

			local var_308_1 = 0
			local var_308_2 = 0.1

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015_split4")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(114242074)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_6 = 4 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_4) / 4)

				if (4 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_4) / 4)) > 0 and var_308_2 < var_308_6 then
					arg_305_1.talkMaxDuration = var_308_6

					if var_308_6 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242074", "story_v_out_114242.awb") ~= 0 then
					local var_308_7 = manager.audio:GetVoiceLength("story_v_out_114242", "114242074", "story_v_out_114242.awb") / 1000

					if var_308_7 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_1
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_114242", "114242074", "story_v_out_114242.awb")

						arg_305_1:RecordAudio("114242074", var_308_8)
						arg_305_1:RecordAudio("114242074", var_308_8)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_114242", "114242074", "story_v_out_114242.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_114242", "114242074", "story_v_out_114242.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_9 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_9 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_9

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_9 and arg_305_1.time_ < var_308_1 + var_308_9 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play114242075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 114242075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play114242076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 1.5

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(114242075).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 60 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 60)

				if (60 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 60)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play114242076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 114242076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play114242077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.75

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(114242076).content)

				arg_313_1.text_.text = var_316_1

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_3 = 30 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 30)

				if (30 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 30)) > 0 and var_316_0 < var_316_3 then
					arg_313_1.talkMaxDuration = var_316_3

					if var_316_3 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_3 + 0
					end
				end

				arg_313_1.text_.text = var_316_1
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_4 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_4

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play114242077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 114242077
		arg_317_1.duration_ = 1.27

		local var_317_0 = {
			ja = 0.999999999999,
			ko = 1.266,
			zh = 1.1,
			en = 1.066
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play114242078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos10015 = arg_317_1.actors_["10015"].transform.localPosition
				arg_317_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("10015", 3)

				for iter_320_0 = 0, arg_317_1.actors_["10015"].transform.childCount - 1 do
					local var_320_0 = arg_317_1.actors_["10015"].transform:GetChild(iter_320_0)

					if var_320_0.name == "split_6" or not string.find(var_320_0.name, "split") then
						var_320_0.gameObject:SetActive(true)
					else
						var_320_0.gameObject:SetActive(false)
					end
				end
			end

			local var_320_1 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_1 then
				arg_317_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10015, Vector3.New(0, -350, -180), (arg_317_1.time_ - 0) / var_320_1)
			end

			if arg_317_1.time_ >= 0 + var_320_1 and arg_317_1.time_ < 0 + var_320_1 + arg_320_0 then
				arg_317_1.actors_["10015"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_320_2 = arg_317_1.actors_["10015"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps10015 == nil then
				arg_317_1.var_.actorSpriteComps10015 = var_320_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_3 = 0.034

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_3 and not isNil(var_320_2) then
				if arg_317_1.var_.actorSpriteComps10015 then
					for iter_320_1, iter_320_2 in pairs(arg_317_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_320_2 then
							if arg_317_1.isInRecall_ then
								iter_320_2.color = Color.New(Mathf.Lerp(iter_320_2.color.r, arg_317_1.hightColor1.r, (arg_317_1.time_ - 0) / var_320_3), Mathf.Lerp(iter_320_2.color.g, arg_317_1.hightColor1.g, (arg_317_1.time_ - 0) / var_320_3), (Mathf.Lerp(iter_320_2.color.b, arg_317_1.hightColor1.b, (arg_317_1.time_ - 0) / var_320_3)))
							else
								local var_320_4 = Mathf.Lerp(iter_320_2.color.r, 1, (arg_317_1.time_ - 0) / var_320_3)

								iter_320_2.color = Color.New(var_320_4, var_320_4, var_320_4)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_3 and arg_317_1.time_ < 0 + var_320_3 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps10015 then
				for iter_320_3, iter_320_4 in pairs(arg_317_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_320_4 then
						iter_320_4.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_317_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				local var_320_5 = arg_317_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_320_5 then
					arg_317_1.var_.alphaOldValue10015 = var_320_5.alpha
					arg_317_1.var_.characterEffect10015 = var_320_5
				end

				arg_317_1.var_.alphaOldValue10015 = 0
			end

			local var_320_6 = 0.5

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_6 then
				if arg_317_1.var_.characterEffect10015 then
					arg_317_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_317_1.var_.alphaOldValue10015, 1, (arg_317_1.time_ - 0) / var_320_6)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_6 and arg_317_1.time_ < 0 + var_320_6 + arg_320_0 and arg_317_1.var_.characterEffect10015 then
				arg_317_1.var_.characterEffect10015.alpha = 1
			end

			local var_320_7 = 0
			local var_320_8 = 0.05

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_7 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_9 = arg_317_1:GetWordFromCfg(114242077)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_12 = 2 <= 0 and var_320_8 or var_320_8 * (utf8.len(var_320_10) / 2)

				if (2 <= 0 and var_320_8 or var_320_8 * (utf8.len(var_320_10) / 2)) > 0 and var_320_8 < var_320_12 then
					arg_317_1.talkMaxDuration = var_320_12

					if var_320_12 + var_320_7 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_12 + var_320_7
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242077", "story_v_out_114242.awb") ~= 0 then
					local var_320_13 = manager.audio:GetVoiceLength("story_v_out_114242", "114242077", "story_v_out_114242.awb") / 1000

					if var_320_13 + var_320_7 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_7
					end

					if var_320_9.prefab_name ~= "" and arg_317_1.actors_[var_320_9.prefab_name] ~= nil then
						local var_320_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_9.prefab_name].transform, "story_v_out_114242", "114242077", "story_v_out_114242.awb")

						arg_317_1:RecordAudio("114242077", var_320_14)
						arg_317_1:RecordAudio("114242077", var_320_14)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_114242", "114242077", "story_v_out_114242.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_114242", "114242077", "story_v_out_114242.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_15 = math.max(var_320_8, arg_317_1.talkMaxDuration)

			if var_320_7 <= arg_317_1.time_ and arg_317_1.time_ < var_320_7 + var_320_15 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_7) / var_320_15

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_7 + var_320_15 and arg_317_1.time_ < var_320_7 + var_320_15 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play114242078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 114242078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
			arg_321_1.auto_ = false
		end

		function arg_321_1.playNext_(arg_323_0)
			arg_321_1.onStoryFinished_()
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["10015"]) and arg_321_1.var_.actorSpriteComps10015 == nil then
				arg_321_1.var_.actorSpriteComps10015 = arg_321_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_0 = 0.034

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["10015"]) then
				if arg_321_1.var_.actorSpriteComps10015 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								iter_324_1.color = Color.New(Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor2.r, (arg_321_1.time_ - 0) / var_324_0), Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor2.g, (arg_321_1.time_ - 0) / var_324_0), (Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor2.b, (arg_321_1.time_ - 0) / var_324_0)))
							else
								local var_324_1 = Mathf.Lerp(iter_324_1.color.r, 0.5, (arg_321_1.time_ - 0) / var_324_0)

								iter_324_1.color = Color.New(var_324_1, var_324_1, var_324_1)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["10015"]) and arg_321_1.var_.actorSpriteComps10015 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_324_3 then
						iter_324_3.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_321_1.var_.actorSpriteComps10015 = nil
			end

			local var_324_2 = 0
			local var_324_3 = 0.675

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(114242078).content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_6 = 27 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_4) / 27)

				if (27 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_4) / 27)) > 0 and var_324_3 < var_324_6 then
					arg_321_1.talkMaxDuration = var_324_6

					if var_324_6 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_6 + var_324_2
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_3, arg_321_1.talkMaxDuration)

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_2) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_2 + var_324_7 and arg_321_1.time_ < var_324_2 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST25",
		"TextureConfig/Background/F01a"
	},
	voices = {
		"story_v_out_114242.awb"
	}
}
