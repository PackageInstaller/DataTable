return {
	Play413011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413011001
		arg_1_1.duration_ = 7.57

		local var_1_0 = {
			zh = 6.5,
			ja = 7.566
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
				arg_1_0:Play413011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F08l == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08l")
				var_4_0.name = "F08l"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F08l = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F08l

				arg_1_1.bgs_.F08l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F08l" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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
				arg_1_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_crowd02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.475

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(413011001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 19 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 19)

				if (19 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 19)) > 0 and var_4_17 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_16 = var_4_16 + 0.3

					if var_4_22 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011001", "story_v_out_413011.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_413011", "413011001", "story_v_out_413011.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_413011", "413011001", "story_v_out_413011.awb")

						arg_1_1:RecordAudio("413011001", var_4_24)
						arg_1_1:RecordAudio("413011001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413011", "413011001", "story_v_out_413011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413011", "413011001", "story_v_out_413011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_16 + 0.3
			local var_4_26 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413011002
		arg_9_1.duration_ = 2.77

		local var_9_0 = {
			zh = 2.766,
			ja = 1.999999999999
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
				arg_9_0:Play413011003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10094"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10094"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10094"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10094"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10094 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10094", 3)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_12_5 = arg_9_1.actors_["10094"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10094 == nil then
				arg_9_1.var_.actorSpriteComps10094 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps10094 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								iter_12_4.color = Color.New(Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_6), Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_6), (Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_6)))
							else
								local var_12_7 = Mathf.Lerp(iter_12_4.color.r, 1, (arg_9_1.time_ - 0) / var_12_6)

								iter_12_4.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10094 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_12_6 then
						iter_12_6.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_8 = arg_9_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_8 then
					arg_9_1.var_.alphaOldValue10094 = var_12_8.alpha
					arg_9_1.var_.characterEffect10094 = var_12_8
				end

				arg_9_1.var_.alphaOldValue10094 = 0
			end

			local var_12_9 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				if arg_9_1.var_.characterEffect10094 then
					arg_9_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue10094, 1, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and arg_9_1.var_.characterEffect10094 then
				arg_9_1.var_.characterEffect10094.alpha = 1
			end

			local var_12_10 = 0
			local var_12_11 = 0.05

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(413011002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 2 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 2)

				if (2 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 2)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011002", "story_v_out_413011.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_413011", "413011002", "story_v_out_413011.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_413011", "413011002", "story_v_out_413011.awb")

						arg_9_1:RecordAudio("413011002", var_12_17)
						arg_9_1:RecordAudio("413011002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413011", "413011002", "story_v_out_413011.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413011", "413011002", "story_v_out_413011.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_18 and arg_9_1.time_ < var_12_10 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play413011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413011003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play413011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10094 = arg_13_1.actors_["10094"].transform.localPosition
				arg_13_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10094", 3)

				for iter_16_0 = 0, arg_13_1.actors_["10094"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["10094"].transform:GetChild(iter_16_0)

					if var_16_0.name == "" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_16_2 = arg_13_1.actors_["10094"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10094 == nil then
				arg_13_1.var_.actorSpriteComps10094 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps10094 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10094 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_16_4 then
						iter_16_4.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10094 = nil
			end

			local var_16_5 = 0
			local var_16_6 = 1.725

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

				local var_16_7 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(413011003).content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 69 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 69)

				if (69 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 69)) > 0 and var_16_6 < var_16_9 then
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
				actorName = "10094",
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
	Play413011004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413011004
		arg_17_1.duration_ = 14.77

		local var_17_0 = {
			zh = 5.533,
			ja = 14.766
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
				arg_17_0:Play413011005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(413011004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 28 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 28)

				if (28 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 28)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011004", "story_v_out_413011.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011004", "story_v_out_413011.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_413011", "413011004", "story_v_out_413011.awb")

						arg_17_1:RecordAudio("413011004", var_20_6)
						arg_17_1:RecordAudio("413011004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413011", "413011004", "story_v_out_413011.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413011", "413011004", "story_v_out_413011.awb")
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
	Play413011005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413011005
		arg_21_1.duration_ = 4.23

		local var_21_0 = {
			zh = 4.233,
			ja = 3.4
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
				arg_21_0:Play413011006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.375

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(413011005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 15 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 15)

				if (15 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 15)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011005", "story_v_out_413011.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011005", "story_v_out_413011.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_413011", "413011005", "story_v_out_413011.awb")

						arg_21_1:RecordAudio("413011005", var_24_6)
						arg_21_1:RecordAudio("413011005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413011", "413011005", "story_v_out_413011.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413011", "413011005", "story_v_out_413011.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play413011006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413011006
		arg_25_1.duration_ = 7.6

		local var_25_0 = {
			zh = 5.466,
			ja = 7.6
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
				arg_25_0:Play413011007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.65

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(413011006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 26)

				if (26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 26)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011006", "story_v_out_413011.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011006", "story_v_out_413011.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_413011", "413011006", "story_v_out_413011.awb")

						arg_25_1:RecordAudio("413011006", var_28_6)
						arg_25_1:RecordAudio("413011006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413011", "413011006", "story_v_out_413011.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413011", "413011006", "story_v_out_413011.awb")
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
	Play413011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413011007
		arg_29_1.duration_ = 7.53

		local var_29_0 = {
			zh = 5.2,
			ja = 7.533
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
				arg_29_0:Play413011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.725

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(413011007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 29 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 29)

				if (29 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 29)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011007", "story_v_out_413011.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011007", "story_v_out_413011.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_413011", "413011007", "story_v_out_413011.awb")

						arg_29_1:RecordAudio("413011007", var_32_6)
						arg_29_1:RecordAudio("413011007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413011", "413011007", "story_v_out_413011.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413011", "413011007", "story_v_out_413011.awb")
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
	Play413011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413011008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play413011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(413011008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 53 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 53)

				if (53 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 53)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play413011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413011009
		arg_37_1.duration_ = 3.53

		local var_37_0 = {
			zh = 1.999999999999,
			ja = 3.533
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
				arg_37_0:Play413011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10094 = arg_37_1.actors_["10094"].transform.localPosition
				arg_37_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10094", 3)

				for iter_40_0 = 0, arg_37_1.actors_["10094"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["10094"].transform:GetChild(iter_40_0)

					if var_40_0.name == "" or not string.find(var_40_0.name, "split") then
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
			local var_40_6 = 0.2

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

				local var_40_7 = arg_37_1:GetWordFromCfg(413011009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 8 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 8)

				if (8 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 8)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011009", "story_v_out_413011.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011009", "story_v_out_413011.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_413011", "413011009", "story_v_out_413011.awb")

						arg_37_1:RecordAudio("413011009", var_40_12)
						arg_37_1:RecordAudio("413011009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413011", "413011009", "story_v_out_413011.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413011", "413011009", "story_v_out_413011.awb")
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
	Play413011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413011010
		arg_41_1.duration_ = 5.6

		local var_41_0 = {
			zh = 5.6,
			ja = 4.5
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
				arg_41_0:Play413011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10094 = arg_41_1.actors_["10094"].transform.localPosition
				arg_41_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10094", 3)

				for iter_44_0 = 0, arg_41_1.actors_["10094"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10094"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_44_2 = arg_41_1.actors_["10094"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10094 == nil then
				arg_41_1.var_.actorSpriteComps10094 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10094 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								iter_44_2.color = Color.New(Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_2.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_2.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10094 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10094 = nil
			end

			local var_44_5 = 0
			local var_44_6 = 0.675

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_7 = arg_41_1:GetWordFromCfg(413011010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 27 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 27)

				if (27 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 27)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011010", "story_v_out_413011.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011010", "story_v_out_413011.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_413011", "413011010", "story_v_out_413011.awb")

						arg_41_1:RecordAudio("413011010", var_44_12)
						arg_41_1:RecordAudio("413011010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413011", "413011010", "story_v_out_413011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413011", "413011010", "story_v_out_413011.awb")
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

		arg_41_1.nodeConfigList_ = {
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
	Play413011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413011011
		arg_45_1.duration_ = 12.47

		local var_45_0 = {
			zh = 7.6,
			ja = 12.466
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
				arg_45_0:Play413011012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10094 = arg_45_1.actors_["10094"].transform.localPosition
				arg_45_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10094", 3)

				for iter_48_0 = 0, arg_45_1.actors_["10094"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["10094"].transform:GetChild(iter_48_0)

					if var_48_0.name == "" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_48_2 = arg_45_1.actors_["10094"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10094 == nil then
				arg_45_1.var_.actorSpriteComps10094 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps10094 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								iter_48_2.color = Color.New(Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_3), Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_3), (Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_3)))
							else
								local var_48_4 = Mathf.Lerp(iter_48_2.color.r, 1, (arg_45_1.time_ - 0) / var_48_3)

								iter_48_2.color = Color.New(var_48_4, var_48_4, var_48_4)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10094 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_48_4 then
						iter_48_4.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10094 = nil
			end

			local var_48_5 = 0
			local var_48_6 = 0.825

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(413011011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 33 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 33)

				if (33 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 33)) > 0 and var_48_6 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011011", "story_v_out_413011.awb") ~= 0 then
					local var_48_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011011", "story_v_out_413011.awb") / 1000

					if var_48_11 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_5
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_413011", "413011011", "story_v_out_413011.awb")

						arg_45_1:RecordAudio("413011011", var_48_12)
						arg_45_1:RecordAudio("413011011", var_48_12)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413011", "413011011", "story_v_out_413011.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413011", "413011011", "story_v_out_413011.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_13 and arg_45_1.time_ < var_48_5 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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
	Play413011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413011012
		arg_49_1.duration_ = 6.27

		local var_49_0 = {
			zh = 6.2,
			ja = 6.266
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
				arg_49_0:Play413011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10094 = arg_49_1.actors_["10094"].transform.localPosition
				arg_49_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10094", 3)

				for iter_52_0 = 0, arg_49_1.actors_["10094"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["10094"].transform:GetChild(iter_52_0)

					if var_52_0.name == "" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_52_2 = arg_49_1.actors_["10094"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10094 == nil then
				arg_49_1.var_.actorSpriteComps10094 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps10094 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								iter_52_2.color = Color.New(Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_2.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_2.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10094 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_52_4 then
						iter_52_4.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10094 = nil
			end

			local var_52_5 = 0
			local var_52_6 = 0.9

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_7 = arg_49_1:GetWordFromCfg(413011012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 36 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 36)

				if (36 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 36)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011012", "story_v_out_413011.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011012", "story_v_out_413011.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_413011", "413011012", "story_v_out_413011.awb")

						arg_49_1:RecordAudio("413011012", var_52_12)
						arg_49_1:RecordAudio("413011012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413011", "413011012", "story_v_out_413011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413011", "413011012", "story_v_out_413011.awb")
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

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play413011013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413011013
		arg_53_1.duration_ = 12.33

		local var_53_0 = {
			zh = 7.733,
			ja = 12.333
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
				arg_53_0:Play413011014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.025

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(413011013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 41 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 41)

				if (41 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 41)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011013", "story_v_out_413011.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011013", "story_v_out_413011.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_413011", "413011013", "story_v_out_413011.awb")

						arg_53_1:RecordAudio("413011013", var_56_6)
						arg_53_1:RecordAudio("413011013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413011", "413011013", "story_v_out_413011.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413011", "413011013", "story_v_out_413011.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play413011014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413011014
		arg_57_1.duration_ = 4.57

		local var_57_0 = {
			zh = 2.166,
			ja = 4.566
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
				arg_57_0:Play413011015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10094 = arg_57_1.actors_["10094"].transform.localPosition
				arg_57_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10094", 3)

				for iter_60_0 = 0, arg_57_1.actors_["10094"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["10094"].transform:GetChild(iter_60_0)

					if var_60_0.name == "" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_60_2 = arg_57_1.actors_["10094"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10094 == nil then
				arg_57_1.var_.actorSpriteComps10094 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps10094 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_60_2 then
							if arg_57_1.isInRecall_ then
								iter_60_2.color = Color.New(Mathf.Lerp(iter_60_2.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_2.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_2.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_2.color.r, 1, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_2.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10094 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_60_4 then
						iter_60_4.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10094 = nil
			end

			local var_60_5 = 0
			local var_60_6 = 0.3

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
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

				local var_60_7 = arg_57_1:GetWordFromCfg(413011014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 12 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 12)

				if (12 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 12)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011014", "story_v_out_413011.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011014", "story_v_out_413011.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_413011", "413011014", "story_v_out_413011.awb")

						arg_57_1:RecordAudio("413011014", var_60_12)
						arg_57_1:RecordAudio("413011014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413011", "413011014", "story_v_out_413011.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413011", "413011014", "story_v_out_413011.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_13 and arg_57_1.time_ < var_60_5 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play413011015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413011015
		arg_61_1.duration_ = 3.87

		local var_61_0 = {
			zh = 3.866,
			ja = 3.266
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
				arg_61_0:Play413011016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10094 = arg_61_1.actors_["10094"].transform.localPosition
				arg_61_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10094", 3)

				for iter_64_0 = 0, arg_61_1.actors_["10094"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["10094"].transform:GetChild(iter_64_0)

					if var_64_0.name == "" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_64_2 = arg_61_1.actors_["10094"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10094 == nil then
				arg_61_1.var_.actorSpriteComps10094 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps10094 then
					for iter_64_1, iter_64_2 in pairs(arg_61_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_64_2 then
							if arg_61_1.isInRecall_ then
								iter_64_2.color = Color.New(Mathf.Lerp(iter_64_2.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_2.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_2.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_2.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_2.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10094 then
				for iter_64_3, iter_64_4 in pairs(arg_61_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_64_4 then
						iter_64_4.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10094 = nil
			end

			local var_64_5 = 0
			local var_64_6 = 0.325

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_7 = arg_61_1:GetWordFromCfg(413011015)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 13 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 13)

				if (13 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 13)) > 0 and var_64_6 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011015", "story_v_out_413011.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011015", "story_v_out_413011.awb") / 1000

					if var_64_11 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_5
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_413011", "413011015", "story_v_out_413011.awb")

						arg_61_1:RecordAudio("413011015", var_64_12)
						arg_61_1:RecordAudio("413011015", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413011", "413011015", "story_v_out_413011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413011", "413011015", "story_v_out_413011.awb")
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
	Play413011016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413011016
		arg_65_1.duration_ = 13.7

		local var_65_0 = {
			zh = 9.166,
			ja = 13.7
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
				arg_65_0:Play413011017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10094"]) and arg_65_1.var_.actorSpriteComps10094 == nil then
				arg_65_1.var_.actorSpriteComps10094 = arg_65_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10094"]) then
				if arg_65_1.var_.actorSpriteComps10094 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10094"]) and arg_65_1.var_.actorSpriteComps10094 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10094 = nil
			end

			local var_68_2 = 0
			local var_68_3 = 0.925

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
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

				local var_68_4 = arg_65_1:GetWordFromCfg(413011016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 37 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 37)

				if (37 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 37)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011016", "story_v_out_413011.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011016", "story_v_out_413011.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_413011", "413011016", "story_v_out_413011.awb")

						arg_65_1:RecordAudio("413011016", var_68_9)
						arg_65_1:RecordAudio("413011016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413011", "413011016", "story_v_out_413011.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413011", "413011016", "story_v_out_413011.awb")
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
	Play413011017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413011017
		arg_69_1.duration_ = 8.5

		local var_69_0 = {
			zh = 7.2,
			ja = 8.5
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
				arg_69_0:Play413011018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10094"]) and arg_69_1.var_.actorSpriteComps10094 == nil then
				arg_69_1.var_.actorSpriteComps10094 = arg_69_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10094"]) then
				if arg_69_1.var_.actorSpriteComps10094 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								iter_72_1.color = Color.New(Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_0), Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_0), (Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_0)))
							else
								local var_72_1 = Mathf.Lerp(iter_72_1.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_0)

								iter_72_1.color = Color.New(var_72_1, var_72_1, var_72_1)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10094"]) and arg_69_1.var_.actorSpriteComps10094 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10094 = nil
			end

			local var_72_2 = 0
			local var_72_3 = 0.95

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_4 = arg_69_1:GetWordFromCfg(413011017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 38 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 38)

				if (38 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 38)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011017", "story_v_out_413011.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011017", "story_v_out_413011.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_413011", "413011017", "story_v_out_413011.awb")

						arg_69_1:RecordAudio("413011017", var_72_9)
						arg_69_1:RecordAudio("413011017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413011", "413011017", "story_v_out_413011.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413011", "413011017", "story_v_out_413011.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_10 and arg_69_1.time_ < var_72_2 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play413011018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413011018
		arg_73_1.duration_ = 9

		local var_73_0 = {
			zh = 6.7,
			ja = 9
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
				arg_73_0:Play413011019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.725

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(413011018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 29 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 29)

				if (29 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 29)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011018", "story_v_out_413011.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011018", "story_v_out_413011.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_413011", "413011018", "story_v_out_413011.awb")

						arg_73_1:RecordAudio("413011018", var_76_6)
						arg_73_1:RecordAudio("413011018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413011", "413011018", "story_v_out_413011.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413011", "413011018", "story_v_out_413011.awb")
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
	Play413011019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413011019
		arg_77_1.duration_ = 2.8

		local var_77_0 = {
			zh = 2.8,
			ja = 2.1
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
				arg_77_0:Play413011020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10094 = arg_77_1.actors_["10094"].transform.localPosition
				arg_77_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10094", 3)

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
				arg_77_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_80_2 = arg_77_1.actors_["10094"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10094 == nil then
				arg_77_1.var_.actorSpriteComps10094 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10094 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								iter_80_2.color = Color.New(Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_2.color.r, 1, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_2.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10094 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10094 = nil
			end

			local var_80_5 = 0
			local var_80_6 = 0.25

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(413011019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 10 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 10)

				if (10 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 10)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011019", "story_v_out_413011.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011019", "story_v_out_413011.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_413011", "413011019", "story_v_out_413011.awb")

						arg_77_1:RecordAudio("413011019", var_80_12)
						arg_77_1:RecordAudio("413011019", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413011", "413011019", "story_v_out_413011.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413011", "413011019", "story_v_out_413011.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_13 and arg_77_1.time_ < var_80_5 + var_80_13 + arg_80_0 then
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
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play413011020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413011020
		arg_81_1.duration_ = 8.13

		local var_81_0 = {
			zh = 4.9,
			ja = 8.133
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
				arg_81_0:Play413011021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10094 = arg_81_1.actors_["10094"].transform.localPosition
				arg_81_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10094", 3)

				for iter_84_0 = 0, arg_81_1.actors_["10094"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["10094"].transform:GetChild(iter_84_0)

					if var_84_0.name == "" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
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
								iter_84_2.color = Color.New(Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_2.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_2.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10094 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_84_4 then
						iter_84_4.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10094 = nil
			end

			local var_84_5 = 0
			local var_84_6 = 0.75

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_7 = arg_81_1:GetWordFromCfg(413011020)
				local var_84_8 = arg_81_1:FormatText(var_84_7.content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 30 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 30)

				if (30 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 30)) > 0 and var_84_6 < var_84_10 then
					arg_81_1.talkMaxDuration = var_84_10

					if var_84_10 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011020", "story_v_out_413011.awb") ~= 0 then
					local var_84_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011020", "story_v_out_413011.awb") / 1000

					if var_84_11 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_5
					end

					if var_84_7.prefab_name ~= "" and arg_81_1.actors_[var_84_7.prefab_name] ~= nil then
						local var_84_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_7.prefab_name].transform, "story_v_out_413011", "413011020", "story_v_out_413011.awb")

						arg_81_1:RecordAudio("413011020", var_84_12)
						arg_81_1:RecordAudio("413011020", var_84_12)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413011", "413011020", "story_v_out_413011.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413011", "413011020", "story_v_out_413011.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_13 and arg_81_1.time_ < var_84_5 + var_84_13 + arg_84_0 then
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
	Play413011021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413011021
		arg_85_1.duration_ = 7.73

		local var_85_0 = {
			zh = 7.733,
			ja = 7.133
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
				arg_85_0:Play413011022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 2 < arg_85_1.time_ and arg_85_1.time_ <= 2 + arg_88_0 then
				local var_88_0 = arg_85_1.bgs_.F08l

				arg_85_1.bgs_.F08l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_1 = var_88_0:GetComponent("SpriteRenderer")

				if var_88_1 and var_88_1.sprite then
					local var_88_2 = 2 * (var_88_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_0.transform.localScale = Vector3.New(var_88_2 / var_88_1.sprite.bounds.size.y < var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x and var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x or var_88_2 / var_88_1.sprite.bounds.size.y, var_88_2 / var_88_1.sprite.bounds.size.y < var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x and var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x or var_88_2 / var_88_1.sprite.bounds.size.y, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "F08l" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_3 = 4

			if 4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			if arg_85_1.time_ >= var_88_3 + 0.3 and arg_85_1.time_ < var_88_3 + 0.3 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			local var_88_4 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_5 = 2

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_5 then
				local var_88_6 = Color.New(0, 0, 0)

				var_88_6.a = Mathf.Lerp(0, 1, (arg_85_1.time_ - var_88_4) / var_88_5)
				arg_85_1.mask_.color = var_88_6
			end

			if arg_85_1.time_ >= var_88_4 + var_88_5 and arg_85_1.time_ < var_88_4 + var_88_5 + arg_88_0 then
				local var_88_7 = Color.New(0, 0, 0)

				var_88_7.a = 1
				arg_85_1.mask_.color = var_88_7
			end

			local var_88_8 = 2

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_9 = 2

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 then
				local var_88_10 = Color.New(0, 0, 0)

				var_88_10.a = Mathf.Lerp(1, 0, (arg_85_1.time_ - var_88_8) / var_88_9)
				arg_85_1.mask_.color = var_88_10
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 then
				local var_88_11 = Color.New(0, 0, 0)

				arg_85_1.mask_.enabled = false
				var_88_11.a = 0
				arg_85_1.mask_.color = var_88_11
			end

			local var_88_12 = arg_85_1.actors_["10094"].transform

			if 1.966 < arg_85_1.time_ and arg_85_1.time_ <= 1.966 + arg_88_0 then
				arg_85_1.var_.moveOldPos10094 = var_88_12.localPosition
				var_88_12.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10094", 0)

				for iter_88_2 = 0, var_88_12.childCount - 1 do
					local var_88_13 = var_88_12:GetChild(iter_88_2)

					if var_88_13.name == "" or not string.find(var_88_13.name, "split") then
						var_88_13.gameObject:SetActive(true)
					else
						var_88_13.gameObject:SetActive(false)
					end
				end
			end

			local var_88_14 = 0.001

			if 1.966 <= arg_85_1.time_ and arg_85_1.time_ < 1.966 + var_88_14 then
				var_88_12.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_85_1.time_ - 1.966) / var_88_14)
			end

			if arg_85_1.time_ >= 1.966 + var_88_14 and arg_85_1.time_ < 1.966 + var_88_14 + arg_88_0 then
				var_88_12.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_88_15 = arg_85_1.actors_["10094"]

			if 1.966 < arg_85_1.time_ and arg_85_1.time_ <= 1.966 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.actorSpriteComps10094 == nil then
				arg_85_1.var_.actorSpriteComps10094 = var_88_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_16 = 0.034

			if 1.966 <= arg_85_1.time_ and arg_85_1.time_ < 1.966 + var_88_16 and not isNil(var_88_15) then
				if arg_85_1.var_.actorSpriteComps10094 then
					for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_88_4 then
							if arg_85_1.isInRecall_ then
								iter_88_4.color = Color.New(Mathf.Lerp(iter_88_4.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 1.966) / var_88_16), Mathf.Lerp(iter_88_4.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 1.966) / var_88_16), (Mathf.Lerp(iter_88_4.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 1.966) / var_88_16)))
							else
								local var_88_17 = Mathf.Lerp(iter_88_4.color.r, 0.5, (arg_85_1.time_ - 1.966) / var_88_16)

								iter_88_4.color = Color.New(var_88_17, var_88_17, var_88_17)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 1.966 + var_88_16 and arg_85_1.time_ < 1.966 + var_88_16 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.actorSpriteComps10094 then
				for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_88_6 then
						iter_88_6.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10094 = nil
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_18 = 4
			local var_88_19 = 0.525

			if 4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_18 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_20 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_20:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_21 = arg_85_1:GetWordFromCfg(413011021)
				local var_88_22 = arg_85_1:FormatText(var_88_21.content)

				arg_85_1.text_.text = var_88_22

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_24 = 21 <= 0 and var_88_19 or var_88_19 * (utf8.len(var_88_22) / 21)

				if (21 <= 0 and var_88_19 or var_88_19 * (utf8.len(var_88_22) / 21)) > 0 and var_88_19 < var_88_24 then
					arg_85_1.talkMaxDuration = var_88_24
					var_88_18 = var_88_18 + 0.3

					if var_88_24 + var_88_18 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_18
					end
				end

				arg_85_1.text_.text = var_88_22
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011021", "story_v_out_413011.awb") ~= 0 then
					local var_88_25 = manager.audio:GetVoiceLength("story_v_out_413011", "413011021", "story_v_out_413011.awb") / 1000

					if var_88_25 + var_88_18 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_25 + var_88_18
					end

					if var_88_21.prefab_name ~= "" and arg_85_1.actors_[var_88_21.prefab_name] ~= nil then
						local var_88_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_21.prefab_name].transform, "story_v_out_413011", "413011021", "story_v_out_413011.awb")

						arg_85_1:RecordAudio("413011021", var_88_26)
						arg_85_1:RecordAudio("413011021", var_88_26)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413011", "413011021", "story_v_out_413011.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413011", "413011021", "story_v_out_413011.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_27 = var_88_18 + 0.3
			local var_88_28 = math.max(var_88_19, arg_85_1.talkMaxDuration)

			if var_88_18 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_27 + var_88_28 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_27) / var_88_28

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_27 + var_88_28 and arg_85_1.time_ < var_88_27 + var_88_28 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play413011022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 413011022
		arg_91_1.duration_ = 5.63

		local var_91_0 = {
			zh = 2.933,
			ja = 5.633
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
				arg_91_0:Play413011023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.375

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:GetWordFromCfg(413011022)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 15 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 15)

				if (15 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 15)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011022", "story_v_out_413011.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011022", "story_v_out_413011.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_413011", "413011022", "story_v_out_413011.awb")

						arg_91_1:RecordAudio("413011022", var_94_6)
						arg_91_1:RecordAudio("413011022", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_413011", "413011022", "story_v_out_413011.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_413011", "413011022", "story_v_out_413011.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play413011023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 413011023
		arg_95_1.duration_ = 8.17

		local var_95_0 = {
			zh = 5.9,
			ja = 8.166
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
				arg_95_0:Play413011024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.8

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:GetWordFromCfg(413011023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 32 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 32)

				if (32 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 32)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011023", "story_v_out_413011.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011023", "story_v_out_413011.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_413011", "413011023", "story_v_out_413011.awb")

						arg_95_1:RecordAudio("413011023", var_98_6)
						arg_95_1:RecordAudio("413011023", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_413011", "413011023", "story_v_out_413011.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_413011", "413011023", "story_v_out_413011.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play413011024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 413011024
		arg_99_1.duration_ = 8.47

		local var_99_0 = {
			zh = 5.966,
			ja = 8.466
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
				arg_99_0:Play413011025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.625

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:GetWordFromCfg(413011024)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 25 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 25)

				if (25 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 25)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011024", "story_v_out_413011.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011024", "story_v_out_413011.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_413011", "413011024", "story_v_out_413011.awb")

						arg_99_1:RecordAudio("413011024", var_102_6)
						arg_99_1:RecordAudio("413011024", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_413011", "413011024", "story_v_out_413011.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_413011", "413011024", "story_v_out_413011.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play413011025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 413011025
		arg_103_1.duration_ = 5.87

		local var_103_0 = {
			zh = 3.266,
			ja = 5.866
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
				arg_103_0:Play413011026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.425

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_1 = arg_103_1:GetWordFromCfg(413011025)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 17 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 17)

				if (17 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 17)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011025", "story_v_out_413011.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011025", "story_v_out_413011.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_out_413011", "413011025", "story_v_out_413011.awb")

						arg_103_1:RecordAudio("413011025", var_106_6)
						arg_103_1:RecordAudio("413011025", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_413011", "413011025", "story_v_out_413011.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_413011", "413011025", "story_v_out_413011.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play413011026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 413011026
		arg_107_1.duration_ = 7

		local var_107_0 = {
			zh = 2.633,
			ja = 7
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
				arg_107_0:Play413011027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.325

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_1 = arg_107_1:GetWordFromCfg(413011026)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.text_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 13 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 13)

				if (13 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 13)) > 0 and var_110_0 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end

				arg_107_1.text_.text = var_110_2
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011026", "story_v_out_413011.awb") ~= 0 then
					local var_110_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011026", "story_v_out_413011.awb") / 1000

					if var_110_5 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + 0
					end

					if var_110_1.prefab_name ~= "" and arg_107_1.actors_[var_110_1.prefab_name] ~= nil then
						local var_110_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_1.prefab_name].transform, "story_v_out_413011", "413011026", "story_v_out_413011.awb")

						arg_107_1:RecordAudio("413011026", var_110_6)
						arg_107_1:RecordAudio("413011026", var_110_6)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_413011", "413011026", "story_v_out_413011.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_413011", "413011026", "story_v_out_413011.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play413011027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 413011027
		arg_111_1.duration_ = 2.47

		local var_111_0 = {
			zh = 2.466,
			ja = 2.166
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
				arg_111_0:Play413011028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10094 = arg_111_1.actors_["10094"].transform.localPosition
				arg_111_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10094", 3)

				for iter_114_0 = 0, arg_111_1.actors_["10094"].transform.childCount - 1 do
					local var_114_0 = arg_111_1.actors_["10094"].transform:GetChild(iter_114_0)

					if var_114_0.name == "" or not string.find(var_114_0.name, "split") then
						var_114_0.gameObject:SetActive(true)
					else
						var_114_0.gameObject:SetActive(false)
					end
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_111_1.time_ - 0) / var_114_1)
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_114_2 = arg_111_1.actors_["10094"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps10094 == nil then
				arg_111_1.var_.actorSpriteComps10094 = var_114_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_3 = 2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.actorSpriteComps10094 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_114_2 then
							if arg_111_1.isInRecall_ then
								iter_114_2.color = Color.New(Mathf.Lerp(iter_114_2.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_3), Mathf.Lerp(iter_114_2.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_3), (Mathf.Lerp(iter_114_2.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_3)))
							else
								local var_114_4 = Mathf.Lerp(iter_114_2.color.r, 1, (arg_111_1.time_ - 0) / var_114_3)

								iter_114_2.color = Color.New(var_114_4, var_114_4, var_114_4)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps10094 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_114_4 then
						iter_114_4.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps10094 = nil
			end

			if 0.034 < arg_111_1.time_ and arg_111_1.time_ <= 0.034 + arg_114_0 then
				arg_111_1:AudioAction("stop", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			local var_114_6 = 0
			local var_114_7 = 0.275

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_8 = arg_111_1:GetWordFromCfg(413011027)
				local var_114_9 = arg_111_1:FormatText(var_114_8.content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 11 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 11)

				if (11 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 11)) > 0 and var_114_7 < var_114_11 then
					arg_111_1.talkMaxDuration = var_114_11

					if var_114_11 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011027", "story_v_out_413011.awb") ~= 0 then
					local var_114_12 = manager.audio:GetVoiceLength("story_v_out_413011", "413011027", "story_v_out_413011.awb") / 1000

					if var_114_12 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_6
					end

					if var_114_8.prefab_name ~= "" and arg_111_1.actors_[var_114_8.prefab_name] ~= nil then
						local var_114_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_8.prefab_name].transform, "story_v_out_413011", "413011027", "story_v_out_413011.awb")

						arg_111_1:RecordAudio("413011027", var_114_13)
						arg_111_1:RecordAudio("413011027", var_114_13)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_413011", "413011027", "story_v_out_413011.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_413011", "413011027", "story_v_out_413011.awb")
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

		arg_111_1.nodeConfigList_ = {
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
	Play413011028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413011028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play413011029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10094 = arg_115_1.actors_["10094"].transform.localPosition
				arg_115_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10094", 3)

				for iter_118_0 = 0, arg_115_1.actors_["10094"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["10094"].transform:GetChild(iter_118_0)

					if var_118_0.name == "" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_118_2 = arg_115_1.actors_["10094"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10094 == nil then
				arg_115_1.var_.actorSpriteComps10094 = var_118_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_3 = 2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.actorSpriteComps10094 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_118_2 then
							if arg_115_1.isInRecall_ then
								iter_118_2.color = Color.New(Mathf.Lerp(iter_118_2.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_3), Mathf.Lerp(iter_118_2.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_3), (Mathf.Lerp(iter_118_2.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_3)))
							else
								local var_118_4 = Mathf.Lerp(iter_118_2.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_3)

								iter_118_2.color = Color.New(var_118_4, var_118_4, var_118_4)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10094 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_118_4 then
						iter_118_4.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:AudioAction("stop", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			local var_118_6 = 0
			local var_118_7 = 1.15

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(413011028).content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 46 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_8) / 46)

				if (46 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_8) / 46)) > 0 and var_118_7 < var_118_10 then
					arg_115_1.talkMaxDuration = var_118_10

					if var_118_10 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_11 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_11 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_11

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_11 and arg_115_1.time_ < var_118_6 + var_118_11 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play413011029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413011029
		arg_119_1.duration_ = 3.67

		local var_119_0 = {
			zh = 2.466,
			ja = 3.666
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
				arg_119_0:Play413011030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10094 = arg_119_1.actors_["10094"].transform.localPosition
				arg_119_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10094", 3)

				for iter_122_0 = 0, arg_119_1.actors_["10094"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10094"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_3" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_122_2 = arg_119_1.actors_["10094"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10094 == nil then
				arg_119_1.var_.actorSpriteComps10094 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps10094 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10094 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_122_4 then
						iter_122_4.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10094 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 0.275

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(413011029)
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

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011029", "story_v_out_413011.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011029", "story_v_out_413011.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_413011", "413011029", "story_v_out_413011.awb")

						arg_119_1:RecordAudio("413011029", var_122_12)
						arg_119_1:RecordAudio("413011029", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413011", "413011029", "story_v_out_413011.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413011", "413011029", "story_v_out_413011.awb")
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
				actorName = "10094",
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
	Play413011030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413011030
		arg_123_1.duration_ = 13.37

		local var_123_0 = {
			zh = 10.6,
			ja = 13.366
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
				arg_123_0:Play413011031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.bgs_.ST21 == nil then
				local var_126_0 = Object.Instantiate(arg_123_1.paintGo_)

				var_126_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST21")
				var_126_0.name = "ST21"
				var_126_0.transform.parent = arg_123_1.stage_.transform
				var_126_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.bgs_.ST21 = var_126_0
			end

			if 2 < arg_123_1.time_ and arg_123_1.time_ <= 2 + arg_126_0 then
				local var_126_1 = arg_123_1.bgs_.ST21

				arg_123_1.bgs_.ST21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_126_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_2 = var_126_1:GetComponent("SpriteRenderer")

				if var_126_2 and var_126_2.sprite then
					local var_126_3 = 2 * (var_126_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_126_1.transform.localScale = Vector3.New(var_126_3 / var_126_2.sprite.bounds.size.y < var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x and var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x or var_126_3 / var_126_2.sprite.bounds.size.y, var_126_3 / var_126_2.sprite.bounds.size.y < var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x and var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x or var_126_3 / var_126_2.sprite.bounds.size.y, 0)
				end

				for iter_126_0, iter_126_1 in pairs(arg_123_1.bgs_) do
					if iter_126_0 ~= "ST21" then
						iter_126_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_4 = 3.999999999999

			if 3.999999999999 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			if arg_123_1.time_ >= var_126_4 + 0.3 and arg_123_1.time_ < var_126_4 + 0.3 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end

			local var_126_5 = 0

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_6 = 2

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_6 then
				local var_126_7 = Color.New(0, 0, 0)

				var_126_7.a = Mathf.Lerp(0, 1, (arg_123_1.time_ - var_126_5) / var_126_6)
				arg_123_1.mask_.color = var_126_7
			end

			if arg_123_1.time_ >= var_126_5 + var_126_6 and arg_123_1.time_ < var_126_5 + var_126_6 + arg_126_0 then
				local var_126_8 = Color.New(0, 0, 0)

				var_126_8.a = 1
				arg_123_1.mask_.color = var_126_8
			end

			local var_126_9 = 2

			if 2 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_10 = 2

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_10 then
				local var_126_11 = Color.New(0, 0, 0)

				var_126_11.a = Mathf.Lerp(1, 0, (arg_123_1.time_ - var_126_9) / var_126_10)
				arg_123_1.mask_.color = var_126_11
			end

			if arg_123_1.time_ >= var_126_9 + var_126_10 and arg_123_1.time_ < var_126_9 + var_126_10 + arg_126_0 then
				local var_126_12 = Color.New(0, 0, 0)

				arg_123_1.mask_.enabled = false
				var_126_12.a = 0
				arg_123_1.mask_.color = var_126_12
			end

			local var_126_13 = arg_123_1.actors_["10094"].transform

			if 1.966 < arg_123_1.time_ and arg_123_1.time_ <= 1.966 + arg_126_0 then
				arg_123_1.var_.moveOldPos10094 = var_126_13.localPosition
				var_126_13.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10094", 7)

				for iter_126_2 = 0, var_126_13.childCount - 1 do
					local var_126_14 = var_126_13:GetChild(iter_126_2)

					if var_126_14.name == "" or not string.find(var_126_14.name, "split") then
						var_126_14.gameObject:SetActive(true)
					else
						var_126_14.gameObject:SetActive(false)
					end
				end
			end

			local var_126_15 = 0.001

			if 1.966 <= arg_123_1.time_ and arg_123_1.time_ < 1.966 + var_126_15 then
				var_126_13.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_123_1.time_ - 1.966) / var_126_15)
			end

			if arg_123_1.time_ >= 1.966 + var_126_15 and arg_123_1.time_ < 1.966 + var_126_15 + arg_126_0 then
				var_126_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_126_16 = 2

			arg_123_1.isInRecall_ = true

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.screenFilterGo_:SetActive(true)

				arg_123_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_123_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_123_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_126_3, iter_126_4 in pairs(arg_123_1.actors_) do
					for iter_126_5, iter_126_6 in ipairs((iter_126_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_126_6.color = iter_126_6.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_126_17 = 0.0333333333333332

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 then
				arg_123_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_123_1.time_ - var_126_16) / var_126_17)
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 then
				arg_123_1.screenFilterEffect_.weight = 1
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_18 = 4
			local var_126_19 = 0.7

			if 4 < arg_123_1.time_ and arg_123_1.time_ <= var_126_18 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_20 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_20:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_123_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_126_21 = arg_123_1:GetWordFromCfg(413011030)
				local var_126_22 = arg_123_1:FormatText(var_126_21.content)

				arg_123_1.text_.text = var_126_22

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_24 = 28 <= 0 and var_126_19 or var_126_19 * (utf8.len(var_126_22) / 28)

				if (28 <= 0 and var_126_19 or var_126_19 * (utf8.len(var_126_22) / 28)) > 0 and var_126_19 < var_126_24 then
					arg_123_1.talkMaxDuration = var_126_24
					var_126_18 = var_126_18 + 0.3

					if var_126_24 + var_126_18 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_24 + var_126_18
					end
				end

				arg_123_1.text_.text = var_126_22
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011030", "story_v_out_413011.awb") ~= 0 then
					local var_126_25 = manager.audio:GetVoiceLength("story_v_out_413011", "413011030", "story_v_out_413011.awb") / 1000

					if var_126_25 + var_126_18 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_25 + var_126_18
					end

					if var_126_21.prefab_name ~= "" and arg_123_1.actors_[var_126_21.prefab_name] ~= nil then
						local var_126_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_21.prefab_name].transform, "story_v_out_413011", "413011030", "story_v_out_413011.awb")

						arg_123_1:RecordAudio("413011030", var_126_26)
						arg_123_1:RecordAudio("413011030", var_126_26)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413011", "413011030", "story_v_out_413011.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413011", "413011030", "story_v_out_413011.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_27 = var_126_18 + 0.3
			local var_126_28 = math.max(var_126_19, arg_123_1.talkMaxDuration)

			if var_126_18 + 0.3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_27 + var_126_28 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_27) / var_126_28

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_27 + var_126_28 and arg_123_1.time_ < var_126_27 + var_126_28 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play413011031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413011031
		arg_129_1.duration_ = 4.3

		local var_129_0 = {
			zh = 1.666,
			ja = 4.3
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play413011032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10094 = arg_129_1.actors_["10094"].transform.localPosition
				arg_129_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10094", 3)

				for iter_132_0 = 0, arg_129_1.actors_["10094"].transform.childCount - 1 do
					local var_132_0 = arg_129_1.actors_["10094"].transform:GetChild(iter_132_0)

					if var_132_0.name == "" or not string.find(var_132_0.name, "split") then
						var_132_0.gameObject:SetActive(true)
					else
						var_132_0.gameObject:SetActive(false)
					end
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_129_1.time_ - 0) / var_132_1)
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_132_2 = arg_129_1.actors_["10094"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10094 == nil then
				arg_129_1.var_.actorSpriteComps10094 = var_132_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_3 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.actorSpriteComps10094 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_132_2 then
							if arg_129_1.isInRecall_ then
								iter_132_2.color = Color.New(Mathf.Lerp(iter_132_2.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_3), Mathf.Lerp(iter_132_2.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_3), (Mathf.Lerp(iter_132_2.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_3)))
							else
								local var_132_4 = Mathf.Lerp(iter_132_2.color.r, 1, (arg_129_1.time_ - 0) / var_132_3)

								iter_132_2.color = Color.New(var_132_4, var_132_4, var_132_4)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10094 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_132_4 then
						iter_132_4.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				local var_132_5 = arg_129_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_132_5 then
					arg_129_1.var_.alphaOldValue10094 = var_132_5.alpha
					arg_129_1.var_.characterEffect10094 = var_132_5
				end

				arg_129_1.var_.alphaOldValue10094 = 0
			end

			local var_132_6 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 then
				if arg_129_1.var_.characterEffect10094 then
					arg_129_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_129_1.var_.alphaOldValue10094, 1, (arg_129_1.time_ - 0) / var_132_6)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 and arg_129_1.var_.characterEffect10094 then
				arg_129_1.var_.characterEffect10094.alpha = 1
			end

			local var_132_7 = 0
			local var_132_8 = 0.175

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_9 = arg_129_1:GetWordFromCfg(413011031)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_12 = 7 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_10) / 7)

				if (7 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_10) / 7)) > 0 and var_132_8 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_7
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011031", "story_v_out_413011.awb") ~= 0 then
					local var_132_13 = manager.audio:GetVoiceLength("story_v_out_413011", "413011031", "story_v_out_413011.awb") / 1000

					if var_132_13 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_7
					end

					if var_132_9.prefab_name ~= "" and arg_129_1.actors_[var_132_9.prefab_name] ~= nil then
						local var_132_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_9.prefab_name].transform, "story_v_out_413011", "413011031", "story_v_out_413011.awb")

						arg_129_1:RecordAudio("413011031", var_132_14)
						arg_129_1:RecordAudio("413011031", var_132_14)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413011", "413011031", "story_v_out_413011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413011", "413011031", "story_v_out_413011.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_15 = math.max(var_132_8, arg_129_1.talkMaxDuration)

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_15 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_7) / var_132_15

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_7 + var_132_15 and arg_129_1.time_ < var_132_7 + var_132_15 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play413011032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413011032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play413011033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10094"]) and arg_133_1.var_.actorSpriteComps10094 == nil then
				arg_133_1.var_.actorSpriteComps10094 = arg_133_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_0 = 2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10094"]) then
				if arg_133_1.var_.actorSpriteComps10094 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								iter_136_1.color = Color.New(Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor2.r, (arg_133_1.time_ - 0) / var_136_0), Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor2.g, (arg_133_1.time_ - 0) / var_136_0), (Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor2.b, (arg_133_1.time_ - 0) / var_136_0)))
							else
								local var_136_1 = Mathf.Lerp(iter_136_1.color.r, 0.5, (arg_133_1.time_ - 0) / var_136_0)

								iter_136_1.color = Color.New(var_136_1, var_136_1, var_136_1)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10094"]) and arg_133_1.var_.actorSpriteComps10094 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps10094 = nil
			end

			local var_136_2 = 0
			local var_136_3 = 0.975

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(413011032).content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 39 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 39)

				if (39 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 39)) > 0 and var_136_3 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_7 and arg_133_1.time_ < var_136_2 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play413011033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413011033
		arg_137_1.duration_ = 12.27

		local var_137_0 = {
			zh = 8,
			ja = 12.266
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
				arg_137_0:Play413011034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10094"]) and arg_137_1.var_.actorSpriteComps10094 == nil then
				arg_137_1.var_.actorSpriteComps10094 = arg_137_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10094"]) then
				if arg_137_1.var_.actorSpriteComps10094 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								iter_140_1.color = Color.New(Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_0), Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_0), (Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_0)))
							else
								local var_140_1 = Mathf.Lerp(iter_140_1.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_0)

								iter_140_1.color = Color.New(var_140_1, var_140_1, var_140_1)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10094"]) and arg_137_1.var_.actorSpriteComps10094 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_140_3 then
						iter_140_3.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10094 = nil
			end

			local var_140_2 = 0
			local var_140_3 = 0.725

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_137_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_140_4 = arg_137_1:GetWordFromCfg(413011033)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 29 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 29)

				if (29 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 29)) > 0 and var_140_3 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011033", "story_v_out_413011.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011033", "story_v_out_413011.awb") / 1000

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_out_413011", "413011033", "story_v_out_413011.awb")

						arg_137_1:RecordAudio("413011033", var_140_9)
						arg_137_1:RecordAudio("413011033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_413011", "413011033", "story_v_out_413011.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_413011", "413011033", "story_v_out_413011.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_10 and arg_137_1.time_ < var_140_2 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play413011034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413011034
		arg_141_1.duration_ = 4

		local var_141_0 = {
			zh = 4,
			ja = 3.366
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
				arg_141_0:Play413011035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10094"]) and arg_141_1.var_.actorSpriteComps10094 == nil then
				arg_141_1.var_.actorSpriteComps10094 = arg_141_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10094"]) then
				if arg_141_1.var_.actorSpriteComps10094 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								iter_144_1.color = Color.New(Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_0), Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_0), (Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_0)))
							else
								local var_144_1 = Mathf.Lerp(iter_144_1.color.r, 1, (arg_141_1.time_ - 0) / var_144_0)

								iter_144_1.color = Color.New(var_144_1, var_144_1, var_144_1)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10094"]) and arg_141_1.var_.actorSpriteComps10094 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps10094 = nil
			end

			local var_144_2 = 0
			local var_144_3 = 0.5

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:GetWordFromCfg(413011034)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 20 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 20)

				if (20 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 20)) > 0 and var_144_3 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011034", "story_v_out_413011.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011034", "story_v_out_413011.awb") / 1000

					if var_144_8 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_2
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_out_413011", "413011034", "story_v_out_413011.awb")

						arg_141_1:RecordAudio("413011034", var_144_9)
						arg_141_1:RecordAudio("413011034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413011", "413011034", "story_v_out_413011.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413011", "413011034", "story_v_out_413011.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_10 and arg_141_1.time_ < var_144_2 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play413011035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413011035
		arg_145_1.duration_ = 7.33

		local var_145_0 = {
			zh = 6,
			ja = 7.333
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
				arg_145_0:Play413011036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["10094"]) and arg_145_1.var_.actorSpriteComps10094 == nil then
				arg_145_1.var_.actorSpriteComps10094 = arg_145_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_0 = 2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["10094"]) then
				if arg_145_1.var_.actorSpriteComps10094 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								iter_148_1.color = Color.New(Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor2.r, (arg_145_1.time_ - 0) / var_148_0), Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor2.g, (arg_145_1.time_ - 0) / var_148_0), (Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor2.b, (arg_145_1.time_ - 0) / var_148_0)))
							else
								local var_148_1 = Mathf.Lerp(iter_148_1.color.r, 0.5, (arg_145_1.time_ - 0) / var_148_0)

								iter_148_1.color = Color.New(var_148_1, var_148_1, var_148_1)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["10094"]) and arg_145_1.var_.actorSpriteComps10094 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_148_3 then
						iter_148_3.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_145_1.var_.actorSpriteComps10094 = nil
			end

			local var_148_2 = 0
			local var_148_3 = 0.65

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_145_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_148_4 = arg_145_1:GetWordFromCfg(413011035)
				local var_148_5 = arg_145_1:FormatText(var_148_4.content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 24 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 24)

				if (24 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 24)) > 0 and var_148_3 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011035", "story_v_out_413011.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011035", "story_v_out_413011.awb") / 1000

					if var_148_8 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_2
					end

					if var_148_4.prefab_name ~= "" and arg_145_1.actors_[var_148_4.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_4.prefab_name].transform, "story_v_out_413011", "413011035", "story_v_out_413011.awb")

						arg_145_1:RecordAudio("413011035", var_148_9)
						arg_145_1:RecordAudio("413011035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413011", "413011035", "story_v_out_413011.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413011", "413011035", "story_v_out_413011.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_10 and arg_145_1.time_ < var_148_2 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play413011036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413011036
		arg_149_1.duration_ = 9.53

		local var_149_0 = {
			zh = 5.2,
			ja = 9.533
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
				arg_149_0:Play413011037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10094 = arg_149_1.actors_["10094"].transform.localPosition
				arg_149_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10094", 3)

				for iter_152_0 = 0, arg_149_1.actors_["10094"].transform.childCount - 1 do
					local var_152_0 = arg_149_1.actors_["10094"].transform:GetChild(iter_152_0)

					if var_152_0.name == "" or not string.find(var_152_0.name, "split") then
						var_152_0.gameObject:SetActive(true)
					else
						var_152_0.gameObject:SetActive(false)
					end
				end
			end

			local var_152_1 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				arg_149_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_149_1.time_ - 0) / var_152_1)
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 then
				arg_149_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_152_2 = arg_149_1.actors_["10094"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps10094 == nil then
				arg_149_1.var_.actorSpriteComps10094 = var_152_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_3 = 2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.actorSpriteComps10094 then
					for iter_152_1, iter_152_2 in pairs(arg_149_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_152_2 then
							if arg_149_1.isInRecall_ then
								iter_152_2.color = Color.New(Mathf.Lerp(iter_152_2.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_3), Mathf.Lerp(iter_152_2.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_3), (Mathf.Lerp(iter_152_2.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_3)))
							else
								local var_152_4 = Mathf.Lerp(iter_152_2.color.r, 1, (arg_149_1.time_ - 0) / var_152_3)

								iter_152_2.color = Color.New(var_152_4, var_152_4, var_152_4)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps10094 then
				for iter_152_3, iter_152_4 in pairs(arg_149_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_152_4 then
						iter_152_4.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps10094 = nil
			end

			local var_152_5 = 0
			local var_152_6 = 0.55

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_7 = arg_149_1:GetWordFromCfg(413011036)
				local var_152_8 = arg_149_1:FormatText(var_152_7.content)

				arg_149_1.text_.text = var_152_8

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 22 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 22)

				if (22 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 22)) > 0 and var_152_6 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_5
					end
				end

				arg_149_1.text_.text = var_152_8
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011036", "story_v_out_413011.awb") ~= 0 then
					local var_152_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011036", "story_v_out_413011.awb") / 1000

					if var_152_11 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_5
					end

					if var_152_7.prefab_name ~= "" and arg_149_1.actors_[var_152_7.prefab_name] ~= nil then
						local var_152_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_7.prefab_name].transform, "story_v_out_413011", "413011036", "story_v_out_413011.awb")

						arg_149_1:RecordAudio("413011036", var_152_12)
						arg_149_1:RecordAudio("413011036", var_152_12)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_413011", "413011036", "story_v_out_413011.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_413011", "413011036", "story_v_out_413011.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_13 = math.max(var_152_6, arg_149_1.talkMaxDuration)

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_13 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_5) / var_152_13

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_5 + var_152_13 and arg_149_1.time_ < var_152_5 + var_152_13 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play413011037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413011037
		arg_153_1.duration_ = 10.73

		local var_153_0 = {
			zh = 9.2,
			ja = 10.733
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
				arg_153_0:Play413011038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10094"]) and arg_153_1.var_.actorSpriteComps10094 == nil then
				arg_153_1.var_.actorSpriteComps10094 = arg_153_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10094"]) then
				if arg_153_1.var_.actorSpriteComps10094 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								iter_156_1.color = Color.New(Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_0), Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_0), (Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_0)))
							else
								local var_156_1 = Mathf.Lerp(iter_156_1.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_0)

								iter_156_1.color = Color.New(var_156_1, var_156_1, var_156_1)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10094"]) and arg_153_1.var_.actorSpriteComps10094 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps10094 = nil
			end

			local var_156_2 = 0
			local var_156_3 = 0.95

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_153_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_156_4 = arg_153_1:GetWordFromCfg(413011037)
				local var_156_5 = arg_153_1:FormatText(var_156_4.content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_7 = 38 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 38)

				if (38 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 38)) > 0 and var_156_3 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011037", "story_v_out_413011.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011037", "story_v_out_413011.awb") / 1000

					if var_156_8 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_2
					end

					if var_156_4.prefab_name ~= "" and arg_153_1.actors_[var_156_4.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_4.prefab_name].transform, "story_v_out_413011", "413011037", "story_v_out_413011.awb")

						arg_153_1:RecordAudio("413011037", var_156_9)
						arg_153_1:RecordAudio("413011037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413011", "413011037", "story_v_out_413011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413011", "413011037", "story_v_out_413011.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_3, arg_153_1.talkMaxDuration)

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_2) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_2 + var_156_10 and arg_153_1.time_ < var_156_2 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play413011038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413011038
		arg_157_1.duration_ = 2

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play413011039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["10094"]) and arg_157_1.var_.actorSpriteComps10094 == nil then
				arg_157_1.var_.actorSpriteComps10094 = arg_157_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_0 = 2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["10094"]) then
				if arg_157_1.var_.actorSpriteComps10094 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								iter_160_1.color = Color.New(Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 0) / var_160_0), Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 0) / var_160_0), (Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 0) / var_160_0)))
							else
								local var_160_1 = Mathf.Lerp(iter_160_1.color.r, 1, (arg_157_1.time_ - 0) / var_160_0)

								iter_160_1.color = Color.New(var_160_1, var_160_1, var_160_1)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["10094"]) and arg_157_1.var_.actorSpriteComps10094 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_160_3 then
						iter_160_3.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps10094 = nil
			end

			local var_160_2 = 0
			local var_160_3 = 0.175

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:GetWordFromCfg(413011038)
				local var_160_5 = arg_157_1:FormatText(var_160_4.content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_7 = 7 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 7)

				if (7 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 7)) > 0 and var_160_3 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011038", "story_v_out_413011.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011038", "story_v_out_413011.awb") / 1000

					if var_160_8 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_2
					end

					if var_160_4.prefab_name ~= "" and arg_157_1.actors_[var_160_4.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_4.prefab_name].transform, "story_v_out_413011", "413011038", "story_v_out_413011.awb")

						arg_157_1:RecordAudio("413011038", var_160_9)
						arg_157_1:RecordAudio("413011038", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_413011", "413011038", "story_v_out_413011.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_413011", "413011038", "story_v_out_413011.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_10 and arg_157_1.time_ < var_160_2 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play413011039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 413011039
		arg_161_1.duration_ = 6.83

		local var_161_0 = {
			zh = 4.266,
			ja = 6.833
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play413011040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["10094"]) and arg_161_1.var_.actorSpriteComps10094 == nil then
				arg_161_1.var_.actorSpriteComps10094 = arg_161_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_0 = 2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["10094"]) then
				if arg_161_1.var_.actorSpriteComps10094 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								iter_164_1.color = Color.New(Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_0), Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_0), (Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_0)))
							else
								local var_164_1 = Mathf.Lerp(iter_164_1.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_0)

								iter_164_1.color = Color.New(var_164_1, var_164_1, var_164_1)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["10094"]) and arg_161_1.var_.actorSpriteComps10094 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_164_3 then
						iter_164_3.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps10094 = nil
			end

			local var_164_2 = 0
			local var_164_3 = 0.45

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_161_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_164_4 = arg_161_1:GetWordFromCfg(413011039)
				local var_164_5 = arg_161_1:FormatText(var_164_4.content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 18 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 18)

				if (18 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 18)) > 0 and var_164_3 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_2
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011039", "story_v_out_413011.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011039", "story_v_out_413011.awb") / 1000

					if var_164_8 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_2
					end

					if var_164_4.prefab_name ~= "" and arg_161_1.actors_[var_164_4.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_4.prefab_name].transform, "story_v_out_413011", "413011039", "story_v_out_413011.awb")

						arg_161_1:RecordAudio("413011039", var_164_9)
						arg_161_1:RecordAudio("413011039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_413011", "413011039", "story_v_out_413011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_413011", "413011039", "story_v_out_413011.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_3, arg_161_1.talkMaxDuration)

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_2) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_2 + var_164_10 and arg_161_1.time_ < var_164_2 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play413011040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 413011040
		arg_165_1.duration_ = 16.9

		local var_165_0 = {
			zh = 9.2,
			ja = 16.9
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
				arg_165_0:Play413011041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.15

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_165_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_168_1 = arg_165_1:GetWordFromCfg(413011040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 46 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 46)

				if (46 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 46)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011040", "story_v_out_413011.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011040", "story_v_out_413011.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_413011", "413011040", "story_v_out_413011.awb")

						arg_165_1:RecordAudio("413011040", var_168_6)
						arg_165_1:RecordAudio("413011040", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_413011", "413011040", "story_v_out_413011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_413011", "413011040", "story_v_out_413011.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play413011041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 413011041
		arg_169_1.duration_ = 4.83

		local var_169_0 = {
			zh = 2.7,
			ja = 4.833
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
				arg_169_0:Play413011042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["10094"]) and arg_169_1.var_.actorSpriteComps10094 == nil then
				arg_169_1.var_.actorSpriteComps10094 = arg_169_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_0 = 2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["10094"]) then
				if arg_169_1.var_.actorSpriteComps10094 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								iter_172_1.color = Color.New(Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_0), Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_0), (Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_0)))
							else
								local var_172_1 = Mathf.Lerp(iter_172_1.color.r, 1, (arg_169_1.time_ - 0) / var_172_0)

								iter_172_1.color = Color.New(var_172_1, var_172_1, var_172_1)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["10094"]) and arg_169_1.var_.actorSpriteComps10094 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps10094 = nil
			end

			local var_172_2 = 0
			local var_172_3 = 0.375

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_4 = arg_169_1:GetWordFromCfg(413011041)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 15 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 15)

				if (15 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 15)) > 0 and var_172_3 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011041", "story_v_out_413011.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011041", "story_v_out_413011.awb") / 1000

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_out_413011", "413011041", "story_v_out_413011.awb")

						arg_169_1:RecordAudio("413011041", var_172_9)
						arg_169_1:RecordAudio("413011041", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_413011", "413011041", "story_v_out_413011.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_413011", "413011041", "story_v_out_413011.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_10 and arg_169_1.time_ < var_172_2 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play413011042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 413011042
		arg_173_1.duration_ = 7.7

		local var_173_0 = {
			zh = 4.433,
			ja = 7.7
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
				arg_173_0:Play413011043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["10094"]) and arg_173_1.var_.actorSpriteComps10094 == nil then
				arg_173_1.var_.actorSpriteComps10094 = arg_173_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["10094"]) then
				if arg_173_1.var_.actorSpriteComps10094 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								iter_176_1.color = Color.New(Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_0), Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_0), (Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_0)))
							else
								local var_176_1 = Mathf.Lerp(iter_176_1.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_0)

								iter_176_1.color = Color.New(var_176_1, var_176_1, var_176_1)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["10094"]) and arg_173_1.var_.actorSpriteComps10094 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps10094 = nil
			end

			local var_176_2 = 0
			local var_176_3 = 0.45

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_173_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_176_4 = arg_173_1:GetWordFromCfg(413011042)
				local var_176_5 = arg_173_1:FormatText(var_176_4.content)

				arg_173_1.text_.text = var_176_5

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 18 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 18)

				if (18 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 18)) > 0 and var_176_3 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_5
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011042", "story_v_out_413011.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011042", "story_v_out_413011.awb") / 1000

					if var_176_8 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_2
					end

					if var_176_4.prefab_name ~= "" and arg_173_1.actors_[var_176_4.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_4.prefab_name].transform, "story_v_out_413011", "413011042", "story_v_out_413011.awb")

						arg_173_1:RecordAudio("413011042", var_176_9)
						arg_173_1:RecordAudio("413011042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_413011", "413011042", "story_v_out_413011.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_413011", "413011042", "story_v_out_413011.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_10 and arg_173_1.time_ < var_176_2 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play413011043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 413011043
		arg_177_1.duration_ = 2.57

		local var_177_0 = {
			zh = 1.999999999999,
			ja = 2.566
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
				arg_177_0:Play413011044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10094"]) and arg_177_1.var_.actorSpriteComps10094 == nil then
				arg_177_1.var_.actorSpriteComps10094 = arg_177_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10094"]) then
				if arg_177_1.var_.actorSpriteComps10094 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_0), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_0), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_0)))
							else
								local var_180_1 = Mathf.Lerp(iter_180_1.color.r, 1, (arg_177_1.time_ - 0) / var_180_0)

								iter_180_1.color = Color.New(var_180_1, var_180_1, var_180_1)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10094"]) and arg_177_1.var_.actorSpriteComps10094 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps10094 = nil
			end

			local var_180_2 = 0
			local var_180_3 = 0.2

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:GetWordFromCfg(413011043)
				local var_180_5 = arg_177_1:FormatText(var_180_4.content)

				arg_177_1.text_.text = var_180_5

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_7 = 8 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 8)

				if (8 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 8)) > 0 and var_180_3 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_5
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011043", "story_v_out_413011.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011043", "story_v_out_413011.awb") / 1000

					if var_180_8 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_2
					end

					if var_180_4.prefab_name ~= "" and arg_177_1.actors_[var_180_4.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_4.prefab_name].transform, "story_v_out_413011", "413011043", "story_v_out_413011.awb")

						arg_177_1:RecordAudio("413011043", var_180_9)
						arg_177_1:RecordAudio("413011043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_413011", "413011043", "story_v_out_413011.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_413011", "413011043", "story_v_out_413011.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_10 and arg_177_1.time_ < var_180_2 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play413011044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413011044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play413011045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10094"]) and arg_181_1.var_.actorSpriteComps10094 == nil then
				arg_181_1.var_.actorSpriteComps10094 = arg_181_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["10094"]) then
				if arg_181_1.var_.actorSpriteComps10094 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["10094"]) and arg_181_1.var_.actorSpriteComps10094 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps10094 = nil
			end

			local var_184_2 = 0
			local var_184_3 = 0.825

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(413011044).content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_6 = 33 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_4) / 33)

				if (33 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_4) / 33)) > 0 and var_184_3 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_7 and arg_181_1.time_ < var_184_2 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play413011045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413011045
		arg_185_1.duration_ = 13.73

		local var_185_0 = {
			zh = 8.833,
			ja = 13.733
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
				arg_185_0:Play413011046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.925

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_185_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_188_1 = arg_185_1:GetWordFromCfg(413011045)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 37 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 37)

				if (37 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 37)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011045", "story_v_out_413011.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011045", "story_v_out_413011.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_413011", "413011045", "story_v_out_413011.awb")

						arg_185_1:RecordAudio("413011045", var_188_6)
						arg_185_1:RecordAudio("413011045", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413011", "413011045", "story_v_out_413011.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413011", "413011045", "story_v_out_413011.awb")
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
	Play413011046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413011046
		arg_189_1.duration_ = 3.83

		local var_189_0 = {
			zh = 3.133,
			ja = 3.833
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
				arg_189_0:Play413011047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10094"]) and arg_189_1.var_.actorSpriteComps10094 == nil then
				arg_189_1.var_.actorSpriteComps10094 = arg_189_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10094"]) then
				if arg_189_1.var_.actorSpriteComps10094 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10094"]) and arg_189_1.var_.actorSpriteComps10094 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps10094 = nil
			end

			local var_192_2 = arg_189_1.actors_["10094"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10094 = var_192_2.localPosition
				var_192_2.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10094", 3)

				for iter_192_4 = 0, var_192_2.childCount - 1 do
					local var_192_3 = var_192_2:GetChild(iter_192_4)

					if var_192_3.name == "split_5" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_189_1.time_ - 0) / var_192_4)
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_192_5 = 0
			local var_192_6 = 0.375

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(413011046)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 15 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 15)

				if (15 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 15)) > 0 and var_192_6 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011046", "story_v_out_413011.awb") ~= 0 then
					local var_192_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011046", "story_v_out_413011.awb") / 1000

					if var_192_11 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_5
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_413011", "413011046", "story_v_out_413011.awb")

						arg_189_1:RecordAudio("413011046", var_192_12)
						arg_189_1:RecordAudio("413011046", var_192_12)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413011", "413011046", "story_v_out_413011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413011", "413011046", "story_v_out_413011.awb")
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
				actorName = "10094",
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
	Play413011047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413011047
		arg_193_1.duration_ = 5.83

		local var_193_0 = {
			zh = 2.7,
			ja = 5.833
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
				arg_193_0:Play413011048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["10094"]) and arg_193_1.var_.actorSpriteComps10094 == nil then
				arg_193_1.var_.actorSpriteComps10094 = arg_193_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_0 = 2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["10094"]) then
				if arg_193_1.var_.actorSpriteComps10094 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["10094"]) and arg_193_1.var_.actorSpriteComps10094 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_196_3 then
						iter_196_3.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps10094 = nil
			end

			local var_196_2 = 0
			local var_196_3 = 0.325

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_193_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_196_4 = arg_193_1:GetWordFromCfg(413011047)
				local var_196_5 = arg_193_1:FormatText(var_196_4.content)

				arg_193_1.text_.text = var_196_5

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_7 = 13 <= 0 and var_196_3 or var_196_3 * (utf8.len(var_196_5) / 13)

				if (13 <= 0 and var_196_3 or var_196_3 * (utf8.len(var_196_5) / 13)) > 0 and var_196_3 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_2 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_2
					end
				end

				arg_193_1.text_.text = var_196_5
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011047", "story_v_out_413011.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011047", "story_v_out_413011.awb") / 1000

					if var_196_8 + var_196_2 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_2
					end

					if var_196_4.prefab_name ~= "" and arg_193_1.actors_[var_196_4.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_4.prefab_name].transform, "story_v_out_413011", "413011047", "story_v_out_413011.awb")

						arg_193_1:RecordAudio("413011047", var_196_9)
						arg_193_1:RecordAudio("413011047", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413011", "413011047", "story_v_out_413011.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413011", "413011047", "story_v_out_413011.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_3, arg_193_1.talkMaxDuration)

			if var_196_2 <= arg_193_1.time_ and arg_193_1.time_ < var_196_2 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_2) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_2 + var_196_10 and arg_193_1.time_ < var_196_2 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play413011048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 413011048
		arg_197_1.duration_ = 9.93

		local var_197_0 = {
			zh = 6.733,
			ja = 9.933
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
				arg_197_0:Play413011049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.85

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_197_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_200_1 = arg_197_1:GetWordFromCfg(413011048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 34 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 34)

				if (34 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 34)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011048", "story_v_out_413011.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011048", "story_v_out_413011.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_413011", "413011048", "story_v_out_413011.awb")

						arg_197_1:RecordAudio("413011048", var_200_6)
						arg_197_1:RecordAudio("413011048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413011", "413011048", "story_v_out_413011.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413011", "413011048", "story_v_out_413011.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play413011049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413011049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play413011050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if arg_201_1.actors_["1042"] == nil then
				local var_204_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1042")

				if not isNil(var_204_0) then
					local var_204_1 = Object.Instantiate(var_204_0, arg_201_1.canvasGo_.transform)

					var_204_1.transform:SetSiblingIndex(1)

					var_204_1.name = "1042"
					var_204_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_201_1.actors_["1042"] = var_204_1

					if arg_201_1.isInRecall_ then
						for iter_204_0, iter_204_1 in ipairs((var_204_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_204_1.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_204_2 = arg_201_1.actors_["1042"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps1042 == nil then
				arg_201_1.var_.actorSpriteComps1042 = var_204_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_3 = 2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.actorSpriteComps1042 then
					for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1042:ToTable()) do
						if iter_204_3 then
							if arg_201_1.isInRecall_ then
								iter_204_3.color = Color.New(Mathf.Lerp(iter_204_3.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_3), Mathf.Lerp(iter_204_3.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_3), (Mathf.Lerp(iter_204_3.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_3)))
							else
								local var_204_4 = Mathf.Lerp(iter_204_3.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_3)

								iter_204_3.color = Color.New(var_204_4, var_204_4, var_204_4)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps1042 then
				for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps1042:ToTable()) do
					if iter_204_5 then
						iter_204_5.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps1042 = nil
			end

			local var_204_5 = arg_201_1.actors_["10094"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10094 = var_204_5.localPosition
				var_204_5.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10094", 7)

				for iter_204_6 = 0, var_204_5.childCount - 1 do
					local var_204_6 = var_204_5:GetChild(iter_204_6)

					if var_204_6.name == "split_5" or not string.find(var_204_6.name, "split") then
						var_204_6.gameObject:SetActive(true)
					else
						var_204_6.gameObject:SetActive(false)
					end
				end
			end

			local var_204_7 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				var_204_5.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_201_1.time_ - 0) / var_204_7)
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				var_204_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				local var_204_8 = arg_201_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_204_8 then
					arg_201_1.var_.alphaOldValue10094 = var_204_8.alpha
					arg_201_1.var_.characterEffect10094 = var_204_8
				end

				arg_201_1.var_.alphaOldValue10094 = 1
			end

			local var_204_9 = 0.5

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_9 then
				if arg_201_1.var_.characterEffect10094 then
					arg_201_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_201_1.var_.alphaOldValue10094, 0, (arg_201_1.time_ - 0) / var_204_9)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_9 and arg_201_1.time_ < 0 + var_204_9 + arg_204_0 and arg_201_1.var_.characterEffect10094 then
				arg_201_1.var_.characterEffect10094.alpha = 0
			end

			local var_204_10 = 0
			local var_204_11 = 0.925

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_12 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(413011049).content)

				arg_201_1.text_.text = var_204_12

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_14 = 37 <= 0 and var_204_11 or var_204_11 * (utf8.len(var_204_12) / 37)

				if (37 <= 0 and var_204_11 or var_204_11 * (utf8.len(var_204_12) / 37)) > 0 and var_204_11 < var_204_14 then
					arg_201_1.talkMaxDuration = var_204_14

					if var_204_14 + var_204_10 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_10
					end
				end

				arg_201_1.text_.text = var_204_12
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_15 = math.max(var_204_11, arg_201_1.talkMaxDuration)

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_15 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_10) / var_204_15

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_10 + var_204_15 and arg_201_1.time_ < var_204_10 + var_204_15 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
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

		arg_201_1:InitPlayNodeList()
	end,
	Play413011050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413011050
		arg_205_1.duration_ = 5.13

		local var_205_0 = {
			zh = 2.333,
			ja = 5.133
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
				arg_205_0:Play413011051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["10094"]) and arg_205_1.var_.actorSpriteComps10094 == nil then
				arg_205_1.var_.actorSpriteComps10094 = arg_205_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_0 = 2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["10094"]) then
				if arg_205_1.var_.actorSpriteComps10094 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								iter_208_1.color = Color.New(Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_0), Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_0), (Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_0)))
							else
								local var_208_1 = Mathf.Lerp(iter_208_1.color.r, 1, (arg_205_1.time_ - 0) / var_208_0)

								iter_208_1.color = Color.New(var_208_1, var_208_1, var_208_1)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["10094"]) and arg_205_1.var_.actorSpriteComps10094 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_208_3 then
						iter_208_3.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				local var_208_2 = arg_205_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_208_2 then
					arg_205_1.var_.alphaOldValue10094 = var_208_2.alpha
					arg_205_1.var_.characterEffect10094 = var_208_2
				end

				arg_205_1.var_.alphaOldValue10094 = 0
			end

			local var_208_3 = 0.5

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 then
				if arg_205_1.var_.characterEffect10094 then
					arg_205_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_205_1.var_.alphaOldValue10094, 1, (arg_205_1.time_ - 0) / var_208_3)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and arg_205_1.var_.characterEffect10094 then
				arg_205_1.var_.characterEffect10094.alpha = 1
			end

			local var_208_4 = arg_205_1.actors_["10094"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10094 = var_208_4.localPosition
				var_208_4.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10094", 3)

				for iter_208_4 = 0, var_208_4.childCount - 1 do
					local var_208_5 = var_208_4:GetChild(iter_208_4)

					if var_208_5.name == "split_1" or not string.find(var_208_5.name, "split") then
						var_208_5.gameObject:SetActive(true)
					else
						var_208_5.gameObject:SetActive(false)
					end
				end
			end

			local var_208_6 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_6 then
				var_208_4.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_205_1.time_ - 0) / var_208_6)
			end

			if arg_205_1.time_ >= 0 + var_208_6 and arg_205_1.time_ < 0 + var_208_6 + arg_208_0 then
				var_208_4.localPosition = Vector3.New(0, -340, -414)
			end

			local var_208_7 = 0
			local var_208_8 = 0.275

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_7 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_9 = arg_205_1:GetWordFromCfg(413011050)
				local var_208_10 = arg_205_1:FormatText(var_208_9.content)

				arg_205_1.text_.text = var_208_10

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_12 = 11 <= 0 and var_208_8 or var_208_8 * (utf8.len(var_208_10) / 11)

				if (11 <= 0 and var_208_8 or var_208_8 * (utf8.len(var_208_10) / 11)) > 0 and var_208_8 < var_208_12 then
					arg_205_1.talkMaxDuration = var_208_12

					if var_208_12 + var_208_7 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_12 + var_208_7
					end
				end

				arg_205_1.text_.text = var_208_10
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011050", "story_v_out_413011.awb") ~= 0 then
					local var_208_13 = manager.audio:GetVoiceLength("story_v_out_413011", "413011050", "story_v_out_413011.awb") / 1000

					if var_208_13 + var_208_7 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_7
					end

					if var_208_9.prefab_name ~= "" and arg_205_1.actors_[var_208_9.prefab_name] ~= nil then
						local var_208_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_9.prefab_name].transform, "story_v_out_413011", "413011050", "story_v_out_413011.awb")

						arg_205_1:RecordAudio("413011050", var_208_14)
						arg_205_1:RecordAudio("413011050", var_208_14)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_413011", "413011050", "story_v_out_413011.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_413011", "413011050", "story_v_out_413011.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_15 = math.max(var_208_8, arg_205_1.talkMaxDuration)

			if var_208_7 <= arg_205_1.time_ and arg_205_1.time_ < var_208_7 + var_208_15 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_7) / var_208_15

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_7 + var_208_15 and arg_205_1.time_ < var_208_7 + var_208_15 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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

		arg_205_1:InitPlayNodeList()
	end,
	Play413011051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413011051
		arg_209_1.duration_ = 6.83

		local var_209_0 = {
			zh = 3.566,
			ja = 6.833
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
				arg_209_0:Play413011052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["10094"]) and arg_209_1.var_.actorSpriteComps10094 == nil then
				arg_209_1.var_.actorSpriteComps10094 = arg_209_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["10094"]) then
				if arg_209_1.var_.actorSpriteComps10094 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								iter_212_1.color = Color.New(Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_0), Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_0), (Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_0)))
							else
								local var_212_1 = Mathf.Lerp(iter_212_1.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_0)

								iter_212_1.color = Color.New(var_212_1, var_212_1, var_212_1)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["10094"]) and arg_209_1.var_.actorSpriteComps10094 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10094 = nil
			end

			local var_212_2 = 0
			local var_212_3 = 0.45

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_209_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_212_4 = arg_209_1:GetWordFromCfg(413011051)
				local var_212_5 = arg_209_1:FormatText(var_212_4.content)

				arg_209_1.text_.text = var_212_5

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_7 = 18 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 18)

				if (18 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 18)) > 0 and var_212_3 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_5
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011051", "story_v_out_413011.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011051", "story_v_out_413011.awb") / 1000

					if var_212_8 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_2
					end

					if var_212_4.prefab_name ~= "" and arg_209_1.actors_[var_212_4.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_4.prefab_name].transform, "story_v_out_413011", "413011051", "story_v_out_413011.awb")

						arg_209_1:RecordAudio("413011051", var_212_9)
						arg_209_1:RecordAudio("413011051", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_413011", "413011051", "story_v_out_413011.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_413011", "413011051", "story_v_out_413011.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_10 and arg_209_1.time_ < var_212_2 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play413011052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413011052
		arg_213_1.duration_ = 6.77

		local var_213_0 = {
			zh = 4.8,
			ja = 6.766
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
				arg_213_0:Play413011053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1042"]) and arg_213_1.var_.actorSpriteComps1042 == nil then
				arg_213_1.var_.actorSpriteComps1042 = arg_213_1.actors_["1042"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1042"]) then
				if arg_213_1.var_.actorSpriteComps1042 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps1042:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								iter_216_1.color = Color.New(Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_0), Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_0), (Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_0)))
							else
								local var_216_1 = Mathf.Lerp(iter_216_1.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_0)

								iter_216_1.color = Color.New(var_216_1, var_216_1, var_216_1)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1042"]) and arg_213_1.var_.actorSpriteComps1042 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps1042:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps1042 = nil
			end

			local var_216_2 = arg_213_1.actors_["10094"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10094 == nil then
				arg_213_1.var_.actorSpriteComps10094 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps10094 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								iter_216_5.color = Color.New(Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_5.color.r, 1, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_5.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10094 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_216_7 then
						iter_216_7.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps10094 = nil
			end

			local var_216_5 = 0
			local var_216_6 = 0.425

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:GetWordFromCfg(413011052)
				local var_216_8 = arg_213_1:FormatText(var_216_7.content)

				arg_213_1.text_.text = var_216_8

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_10 = 17 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 17)

				if (17 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 17)) > 0 and var_216_6 < var_216_10 then
					arg_213_1.talkMaxDuration = var_216_10

					if var_216_10 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_8
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011052", "story_v_out_413011.awb") ~= 0 then
					local var_216_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011052", "story_v_out_413011.awb") / 1000

					if var_216_11 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_5
					end

					if var_216_7.prefab_name ~= "" and arg_213_1.actors_[var_216_7.prefab_name] ~= nil then
						local var_216_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_7.prefab_name].transform, "story_v_out_413011", "413011052", "story_v_out_413011.awb")

						arg_213_1:RecordAudio("413011052", var_216_12)
						arg_213_1:RecordAudio("413011052", var_216_12)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413011", "413011052", "story_v_out_413011.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413011", "413011052", "story_v_out_413011.awb")
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
	Play413011053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413011053
		arg_217_1.duration_ = 11.67

		local var_217_0 = {
			zh = 8.233,
			ja = 11.666
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
				arg_217_0:Play413011054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["10094"]) and arg_217_1.var_.actorSpriteComps10094 == nil then
				arg_217_1.var_.actorSpriteComps10094 = arg_217_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_0 = 2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["10094"]) then
				if arg_217_1.var_.actorSpriteComps10094 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								iter_220_1.color = Color.New(Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor2.r, (arg_217_1.time_ - 0) / var_220_0), Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor2.g, (arg_217_1.time_ - 0) / var_220_0), (Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor2.b, (arg_217_1.time_ - 0) / var_220_0)))
							else
								local var_220_1 = Mathf.Lerp(iter_220_1.color.r, 0.5, (arg_217_1.time_ - 0) / var_220_0)

								iter_220_1.color = Color.New(var_220_1, var_220_1, var_220_1)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["10094"]) and arg_217_1.var_.actorSpriteComps10094 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_217_1.var_.actorSpriteComps10094 = nil
			end

			local var_220_2 = 0
			local var_220_3 = 0.925

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_217_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_220_4 = arg_217_1:GetWordFromCfg(413011053)
				local var_220_5 = arg_217_1:FormatText(var_220_4.content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_7 = 37 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 37)

				if (37 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 37)) > 0 and var_220_3 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011053", "story_v_out_413011.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011053", "story_v_out_413011.awb") / 1000

					if var_220_8 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_2
					end

					if var_220_4.prefab_name ~= "" and arg_217_1.actors_[var_220_4.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_4.prefab_name].transform, "story_v_out_413011", "413011053", "story_v_out_413011.awb")

						arg_217_1:RecordAudio("413011053", var_220_9)
						arg_217_1:RecordAudio("413011053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413011", "413011053", "story_v_out_413011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413011", "413011053", "story_v_out_413011.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_10 and arg_217_1.time_ < var_220_2 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play413011054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413011054
		arg_221_1.duration_ = 2.63

		local var_221_0 = {
			zh = 1.866,
			ja = 2.633
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
				arg_221_0:Play413011055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.175

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_221_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_224_1 = arg_221_1:GetWordFromCfg(413011054)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 7 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 7)

				if (7 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 7)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011054", "story_v_out_413011.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011054", "story_v_out_413011.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_413011", "413011054", "story_v_out_413011.awb")

						arg_221_1:RecordAudio("413011054", var_224_6)
						arg_221_1:RecordAudio("413011054", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_413011", "413011054", "story_v_out_413011.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_413011", "413011054", "story_v_out_413011.awb")
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
	Play413011055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413011055
		arg_225_1.duration_ = 9

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play413011056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 2 < arg_225_1.time_ and arg_225_1.time_ <= 2 + arg_228_0 then
				local var_228_0 = arg_225_1.bgs_.F08l

				arg_225_1.bgs_.F08l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_228_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_228_1 = var_228_0:GetComponent("SpriteRenderer")

				if var_228_1 and var_228_1.sprite then
					local var_228_2 = 2 * (var_228_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_228_0.transform.localScale = Vector3.New(var_228_2 / var_228_1.sprite.bounds.size.y < var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x and var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x or var_228_2 / var_228_1.sprite.bounds.size.y, var_228_2 / var_228_1.sprite.bounds.size.y < var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x and var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x or var_228_2 / var_228_1.sprite.bounds.size.y, 0)
				end

				for iter_228_0, iter_228_1 in pairs(arg_225_1.bgs_) do
					if iter_228_0 ~= "F08l" then
						iter_228_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_228_3 = 3.999999999999

			if 3.999999999999 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.allBtn_.enabled = false
			end

			if arg_225_1.time_ >= var_228_3 + 0.3 and arg_225_1.time_ < var_228_3 + 0.3 + arg_228_0 then
				arg_225_1.allBtn_.enabled = true
			end

			local var_228_4 = 0

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_5 = 2

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_5 then
				local var_228_6 = Color.New(0, 0, 0)

				var_228_6.a = Mathf.Lerp(0, 1, (arg_225_1.time_ - var_228_4) / var_228_5)
				arg_225_1.mask_.color = var_228_6
			end

			if arg_225_1.time_ >= var_228_4 + var_228_5 and arg_225_1.time_ < var_228_4 + var_228_5 + arg_228_0 then
				local var_228_7 = Color.New(0, 0, 0)

				var_228_7.a = 1
				arg_225_1.mask_.color = var_228_7
			end

			local var_228_8 = 2

			if 2 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_9 = 2

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_9 then
				local var_228_10 = Color.New(0, 0, 0)

				var_228_10.a = Mathf.Lerp(1, 0, (arg_225_1.time_ - var_228_8) / var_228_9)
				arg_225_1.mask_.color = var_228_10
			end

			if arg_225_1.time_ >= var_228_8 + var_228_9 and arg_225_1.time_ < var_228_8 + var_228_9 + arg_228_0 then
				local var_228_11 = Color.New(0, 0, 0)

				arg_225_1.mask_.enabled = false
				var_228_11.a = 0
				arg_225_1.mask_.color = var_228_11
			end

			local var_228_12 = arg_225_1.actors_["10094"].transform

			if 1.966 < arg_225_1.time_ and arg_225_1.time_ <= 1.966 + arg_228_0 then
				arg_225_1.var_.moveOldPos10094 = var_228_12.localPosition
				var_228_12.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10094", 0)

				for iter_228_2 = 0, var_228_12.childCount - 1 do
					local var_228_13 = var_228_12:GetChild(iter_228_2)

					if var_228_13.name == "" or not string.find(var_228_13.name, "split") then
						var_228_13.gameObject:SetActive(true)
					else
						var_228_13.gameObject:SetActive(false)
					end
				end
			end

			local var_228_14 = 0.001

			if 1.966 <= arg_225_1.time_ and arg_225_1.time_ < 1.966 + var_228_14 then
				var_228_12.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_225_1.time_ - 1.966) / var_228_14)
			end

			if arg_225_1.time_ >= 1.966 + var_228_14 and arg_225_1.time_ < 1.966 + var_228_14 + arg_228_0 then
				var_228_12.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_228_15 = 2

			arg_225_1.isInRecall_ = false

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.screenFilterGo_:SetActive(false)

				for iter_228_3, iter_228_4 in pairs(arg_225_1.actors_) do
					for iter_228_5, iter_228_6 in ipairs((iter_228_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_228_6.color = iter_228_6.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_228_16 = 0.0333333333333332

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_16 then
				arg_225_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_225_1.time_ - var_228_15) / var_228_16)
			end

			if arg_225_1.time_ >= var_228_15 + var_228_16 and arg_225_1.time_ < var_228_15 + var_228_16 + arg_228_0 then
				arg_225_1.screenFilterEffect_.weight = 0
			end

			if arg_225_1.frameCnt_ <= 1 then
				arg_225_1.dialog_:SetActive(false)
			end

			local var_228_17 = 3.999999999999
			local var_228_18 = 1.375

			if 3.999999999999 < arg_225_1.time_ and arg_225_1.time_ <= var_228_17 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				arg_225_1.dialog_:SetActive(true)

				arg_225_1.dialogCg_.alpha = 0

				local var_228_19 = LeanTween.value(arg_225_1.dialog_, 0, 1, 0.3)

				var_228_19:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_225_1.dialogCg_.alpha = arg_229_0
				end))
				var_228_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_225_1.dialog_)
					var_228_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_225_1.duration_ = arg_225_1.duration_ + 0.3

				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_20 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(413011055).content)

				arg_225_1.text_.text = var_228_20

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_22 = 55 <= 0 and var_228_18 or var_228_18 * (utf8.len(var_228_20) / 55)

				if (55 <= 0 and var_228_18 or var_228_18 * (utf8.len(var_228_20) / 55)) > 0 and var_228_18 < var_228_22 then
					arg_225_1.talkMaxDuration = var_228_22
					var_228_17 = var_228_17 + 0.3

					if var_228_22 + var_228_17 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_22 + var_228_17
					end
				end

				arg_225_1.text_.text = var_228_20
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_23 = var_228_17 + 0.3
			local var_228_24 = math.max(var_228_18, arg_225_1.talkMaxDuration)

			if var_228_17 + 0.3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_23 + var_228_24 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_23) / var_228_24

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_23 + var_228_24 and arg_225_1.time_ < var_228_23 + var_228_24 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play413011056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 413011056
		arg_231_1.duration_ = 8.17

		local var_231_0 = {
			zh = 6.5,
			ja = 8.166
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
				arg_231_0:Play413011057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.925

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:GetWordFromCfg(413011056)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 37 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 37)

				if (37 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 37)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011056", "story_v_out_413011.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011056", "story_v_out_413011.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_413011", "413011056", "story_v_out_413011.awb")

						arg_231_1:RecordAudio("413011056", var_234_6)
						arg_231_1:RecordAudio("413011056", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_413011", "413011056", "story_v_out_413011.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_413011", "413011056", "story_v_out_413011.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play413011057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 413011057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play413011058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.925

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(413011057).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 37 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 37)

				if (37 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 37)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play413011058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 413011058
		arg_239_1.duration_ = 2

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play413011059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos10094 = arg_239_1.actors_["10094"].transform.localPosition
				arg_239_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("10094", 3)

				for iter_242_0 = 0, arg_239_1.actors_["10094"].transform.childCount - 1 do
					local var_242_0 = arg_239_1.actors_["10094"].transform:GetChild(iter_242_0)

					if var_242_0.name == "" or not string.find(var_242_0.name, "split") then
						var_242_0.gameObject:SetActive(true)
					else
						var_242_0.gameObject:SetActive(false)
					end
				end
			end

			local var_242_1 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 then
				arg_239_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_239_1.time_ - 0) / var_242_1)
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 then
				arg_239_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_242_2 = arg_239_1.actors_["10094"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10094 == nil then
				arg_239_1.var_.actorSpriteComps10094 = var_242_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_3 = 2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.actorSpriteComps10094 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								iter_242_2.color = Color.New(Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor1.r, (arg_239_1.time_ - 0) / var_242_3), Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor1.g, (arg_239_1.time_ - 0) / var_242_3), (Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor1.b, (arg_239_1.time_ - 0) / var_242_3)))
							else
								local var_242_4 = Mathf.Lerp(iter_242_2.color.r, 1, (arg_239_1.time_ - 0) / var_242_3)

								iter_242_2.color = Color.New(var_242_4, var_242_4, var_242_4)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10094 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_242_4 then
						iter_242_4.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				local var_242_5 = arg_239_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_242_5 then
					arg_239_1.var_.alphaOldValue10094 = var_242_5.alpha
					arg_239_1.var_.characterEffect10094 = var_242_5
				end

				arg_239_1.var_.alphaOldValue10094 = 0
			end

			local var_242_6 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_6 then
				if arg_239_1.var_.characterEffect10094 then
					arg_239_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_239_1.var_.alphaOldValue10094, 1, (arg_239_1.time_ - 0) / var_242_6)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_6 and arg_239_1.time_ < 0 + var_242_6 + arg_242_0 and arg_239_1.var_.characterEffect10094 then
				arg_239_1.var_.characterEffect10094.alpha = 1
			end

			local var_242_7 = 0
			local var_242_8 = 0.075

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_7 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_9 = arg_239_1:GetWordFromCfg(413011058)
				local var_242_10 = arg_239_1:FormatText(var_242_9.content)

				arg_239_1.text_.text = var_242_10

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_12 = 3 <= 0 and var_242_8 or var_242_8 * (utf8.len(var_242_10) / 3)

				if (3 <= 0 and var_242_8 or var_242_8 * (utf8.len(var_242_10) / 3)) > 0 and var_242_8 < var_242_12 then
					arg_239_1.talkMaxDuration = var_242_12

					if var_242_12 + var_242_7 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_12 + var_242_7
					end
				end

				arg_239_1.text_.text = var_242_10
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011058", "story_v_out_413011.awb") ~= 0 then
					local var_242_13 = manager.audio:GetVoiceLength("story_v_out_413011", "413011058", "story_v_out_413011.awb") / 1000

					if var_242_13 + var_242_7 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_7
					end

					if var_242_9.prefab_name ~= "" and arg_239_1.actors_[var_242_9.prefab_name] ~= nil then
						local var_242_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_9.prefab_name].transform, "story_v_out_413011", "413011058", "story_v_out_413011.awb")

						arg_239_1:RecordAudio("413011058", var_242_14)
						arg_239_1:RecordAudio("413011058", var_242_14)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_413011", "413011058", "story_v_out_413011.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_413011", "413011058", "story_v_out_413011.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_15 = math.max(var_242_8, arg_239_1.talkMaxDuration)

			if var_242_7 <= arg_239_1.time_ and arg_239_1.time_ < var_242_7 + var_242_15 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_7) / var_242_15

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_7 + var_242_15 and arg_239_1.time_ < var_242_7 + var_242_15 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play413011059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 413011059
		arg_243_1.duration_ = 6.17

		local var_243_0 = {
			zh = 3.866,
			ja = 6.166
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
				arg_243_0:Play413011060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["10094"]) and arg_243_1.var_.actorSpriteComps10094 == nil then
				arg_243_1.var_.actorSpriteComps10094 = arg_243_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["10094"]) then
				if arg_243_1.var_.actorSpriteComps10094 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								iter_246_1.color = Color.New(Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_0), Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_0), (Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_0)))
							else
								local var_246_1 = Mathf.Lerp(iter_246_1.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_0)

								iter_246_1.color = Color.New(var_246_1, var_246_1, var_246_1)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["10094"]) and arg_243_1.var_.actorSpriteComps10094 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps10094 = nil
			end

			local var_246_2 = "10022"

			if arg_243_1.actors_["10022"] == nil then
				local var_246_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_246_3) then
					local var_246_4 = Object.Instantiate(var_246_3, arg_243_1.canvasGo_.transform)

					var_246_4.transform:SetSiblingIndex(1)

					var_246_4.name = var_246_2
					var_246_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_243_1.actors_[var_246_2] = var_246_4

					if arg_243_1.isInRecall_ then
						for iter_246_4, iter_246_5 in ipairs((var_246_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_246_5.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_246_5 = arg_243_1.actors_["10022"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos10022 = var_246_5.localPosition
				var_246_5.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10022", 4)

				for iter_246_6 = 0, var_246_5.childCount - 1 do
					local var_246_6 = var_246_5:GetChild(iter_246_6)

					if var_246_6.name == "split_8" or not string.find(var_246_6.name, "split") then
						var_246_6.gameObject:SetActive(true)
					else
						var_246_6.gameObject:SetActive(false)
					end
				end
			end

			local var_246_7 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				var_246_5.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_243_1.time_ - 0) / var_246_7)
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				var_246_5.localPosition = Vector3.New(390, -315, -320)
			end

			local var_246_8 = arg_243_1.actors_["10094"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos10094 = var_246_8.localPosition
				var_246_8.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10094", 2)

				for iter_246_7 = 0, var_246_8.childCount - 1 do
					local var_246_9 = var_246_8:GetChild(iter_246_7)

					if var_246_9.name == "" or not string.find(var_246_9.name, "split") then
						var_246_9.gameObject:SetActive(true)
					else
						var_246_9.gameObject:SetActive(false)
					end
				end
			end

			local var_246_10 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_10 then
				var_246_8.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_243_1.time_ - 0) / var_246_10)
			end

			if arg_243_1.time_ >= 0 + var_246_10 and arg_243_1.time_ < 0 + var_246_10 + arg_246_0 then
				var_246_8.localPosition = Vector3.New(-390, -340, -414)
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				local var_246_11 = arg_243_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_246_11 then
					arg_243_1.var_.alphaOldValue10022 = var_246_11.alpha
					arg_243_1.var_.characterEffect10022 = var_246_11
				end
			end

			local var_246_12 = 0.5

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_12 then
				if arg_243_1.var_.characterEffect10022 then
					arg_243_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_243_1.var_.alphaOldValue10022, 0.6, (arg_243_1.time_ - 0) / var_246_12)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_12 and arg_243_1.time_ < 0 + var_246_12 + arg_246_0 and arg_243_1.var_.characterEffect10022 then
				arg_243_1.var_.characterEffect10022.alpha = 0.6
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:SetSpriteNiuquEffect("10022", true)
			end

			local var_246_14 = 0
			local var_246_15 = 0.525

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_16 = arg_243_1:GetWordFromCfg(413011059)
				local var_246_17 = arg_243_1:FormatText(var_246_16.content)

				arg_243_1.text_.text = var_246_17

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_19 = 21 <= 0 and var_246_15 or var_246_15 * (utf8.len(var_246_17) / 21)

				if (21 <= 0 and var_246_15 or var_246_15 * (utf8.len(var_246_17) / 21)) > 0 and var_246_15 < var_246_19 then
					arg_243_1.talkMaxDuration = var_246_19

					if var_246_19 + var_246_14 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_19 + var_246_14
					end
				end

				arg_243_1.text_.text = var_246_17
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011059", "story_v_out_413011.awb") ~= 0 then
					local var_246_20 = manager.audio:GetVoiceLength("story_v_out_413011", "413011059", "story_v_out_413011.awb") / 1000

					if var_246_20 + var_246_14 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_20 + var_246_14
					end

					if var_246_16.prefab_name ~= "" and arg_243_1.actors_[var_246_16.prefab_name] ~= nil then
						local var_246_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_16.prefab_name].transform, "story_v_out_413011", "413011059", "story_v_out_413011.awb")

						arg_243_1:RecordAudio("413011059", var_246_21)
						arg_243_1:RecordAudio("413011059", var_246_21)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_413011", "413011059", "story_v_out_413011.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_413011", "413011059", "story_v_out_413011.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_22 = math.max(var_246_15, arg_243_1.talkMaxDuration)

			if var_246_14 <= arg_243_1.time_ and arg_243_1.time_ < var_246_14 + var_246_22 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_14) / var_246_22

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_14 + var_246_22 and arg_243_1.time_ < var_246_14 + var_246_22 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play413011060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 413011060
		arg_247_1.duration_ = 6.07

		local var_247_0 = {
			zh = 4.966,
			ja = 6.066
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
				arg_247_0:Play413011061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10094"]) and arg_247_1.var_.actorSpriteComps10094 == nil then
				arg_247_1.var_.actorSpriteComps10094 = arg_247_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_0 = 2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10094"]) then
				if arg_247_1.var_.actorSpriteComps10094 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								iter_250_1.color = Color.New(Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor1.r, (arg_247_1.time_ - 0) / var_250_0), Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor1.g, (arg_247_1.time_ - 0) / var_250_0), (Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor1.b, (arg_247_1.time_ - 0) / var_250_0)))
							else
								local var_250_1 = Mathf.Lerp(iter_250_1.color.r, 1, (arg_247_1.time_ - 0) / var_250_0)

								iter_250_1.color = Color.New(var_250_1, var_250_1, var_250_1)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10094"]) and arg_247_1.var_.actorSpriteComps10094 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_250_3 then
						iter_250_3.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps10094 = nil
			end

			local var_250_2 = 0
			local var_250_3 = 0.55

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(413011060)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 22 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 22)

				if (22 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 22)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011060", "story_v_out_413011.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011060", "story_v_out_413011.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_413011", "413011060", "story_v_out_413011.awb")

						arg_247_1:RecordAudio("413011060", var_250_9)
						arg_247_1:RecordAudio("413011060", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_413011", "413011060", "story_v_out_413011.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_413011", "413011060", "story_v_out_413011.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play413011061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 413011061
		arg_251_1.duration_ = 5.83

		local var_251_0 = {
			zh = 3.8,
			ja = 5.833
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
				arg_251_0:Play413011062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10094"]) and arg_251_1.var_.actorSpriteComps10094 == nil then
				arg_251_1.var_.actorSpriteComps10094 = arg_251_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10094"]) then
				if arg_251_1.var_.actorSpriteComps10094 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10094"]) and arg_251_1.var_.actorSpriteComps10094 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps10094 = nil
			end

			local var_254_2 = arg_251_1.actors_["10022"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10022 = var_254_2.localPosition
				var_254_2.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10022", 4)

				for iter_254_4 = 0, var_254_2.childCount - 1 do
					local var_254_3 = var_254_2:GetChild(iter_254_4)

					if var_254_3.name == "split_1" or not string.find(var_254_3.name, "split") then
						var_254_3.gameObject:SetActive(true)
					else
						var_254_3.gameObject:SetActive(false)
					end
				end
			end

			local var_254_4 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				var_254_2.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_251_1.time_ - 0) / var_254_4)
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				var_254_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_254_5 = 0
			local var_254_6 = 0.525

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_7 = arg_251_1:GetWordFromCfg(413011061)
				local var_254_8 = arg_251_1:FormatText(var_254_7.content)

				arg_251_1.text_.text = var_254_8

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_10 = 21 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 21)

				if (21 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 21)) > 0 and var_254_6 < var_254_10 then
					arg_251_1.talkMaxDuration = var_254_10

					if var_254_10 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_5
					end
				end

				arg_251_1.text_.text = var_254_8
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011061", "story_v_out_413011.awb") ~= 0 then
					local var_254_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011061", "story_v_out_413011.awb") / 1000

					if var_254_11 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_5
					end

					if var_254_7.prefab_name ~= "" and arg_251_1.actors_[var_254_7.prefab_name] ~= nil then
						local var_254_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_7.prefab_name].transform, "story_v_out_413011", "413011061", "story_v_out_413011.awb")

						arg_251_1:RecordAudio("413011061", var_254_12)
						arg_251_1:RecordAudio("413011061", var_254_12)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_413011", "413011061", "story_v_out_413011.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_413011", "413011061", "story_v_out_413011.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_13 = math.max(var_254_6, arg_251_1.talkMaxDuration)

			if var_254_5 <= arg_251_1.time_ and arg_251_1.time_ < var_254_5 + var_254_13 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_5) / var_254_13

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_5 + var_254_13 and arg_251_1.time_ < var_254_5 + var_254_13 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play413011062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 413011062
		arg_255_1.duration_ = 3.67

		local var_255_0 = {
			zh = 1.999999999999,
			ja = 3.666
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play413011063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10094"]) and arg_255_1.var_.actorSpriteComps10094 == nil then
				arg_255_1.var_.actorSpriteComps10094 = arg_255_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10094"]) then
				if arg_255_1.var_.actorSpriteComps10094 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 1, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10094"]) and arg_255_1.var_.actorSpriteComps10094 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps10094 = nil
			end

			local var_258_2 = 0
			local var_258_3 = 0.175

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:GetWordFromCfg(413011062)
				local var_258_5 = arg_255_1:FormatText(var_258_4.content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 7 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 7)

				if (7 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 7)) > 0 and var_258_3 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011062", "story_v_out_413011.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011062", "story_v_out_413011.awb") / 1000

					if var_258_8 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_2
					end

					if var_258_4.prefab_name ~= "" and arg_255_1.actors_[var_258_4.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_4.prefab_name].transform, "story_v_out_413011", "413011062", "story_v_out_413011.awb")

						arg_255_1:RecordAudio("413011062", var_258_9)
						arg_255_1:RecordAudio("413011062", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_413011", "413011062", "story_v_out_413011.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_413011", "413011062", "story_v_out_413011.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_10 and arg_255_1.time_ < var_258_2 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play413011063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 413011063
		arg_259_1.duration_ = 6.83

		local var_259_0 = {
			zh = 6.766,
			ja = 6.833
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
				arg_259_0:Play413011064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["10094"]) and arg_259_1.var_.actorSpriteComps10094 == nil then
				arg_259_1.var_.actorSpriteComps10094 = arg_259_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["10094"]) then
				if arg_259_1.var_.actorSpriteComps10094 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								iter_262_1.color = Color.New(Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor2.r, (arg_259_1.time_ - 0) / var_262_0), Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor2.g, (arg_259_1.time_ - 0) / var_262_0), (Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor2.b, (arg_259_1.time_ - 0) / var_262_0)))
							else
								local var_262_1 = Mathf.Lerp(iter_262_1.color.r, 0.5, (arg_259_1.time_ - 0) / var_262_0)

								iter_262_1.color = Color.New(var_262_1, var_262_1, var_262_1)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["10094"]) and arg_259_1.var_.actorSpriteComps10094 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_259_1.var_.actorSpriteComps10094 = nil
			end

			local var_262_2 = arg_259_1.actors_["10022"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10022 = var_262_2.localPosition
				var_262_2.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10022", 4)

				for iter_262_4 = 0, var_262_2.childCount - 1 do
					local var_262_3 = var_262_2:GetChild(iter_262_4)

					if var_262_3.name == "split_8" or not string.find(var_262_3.name, "split") then
						var_262_3.gameObject:SetActive(true)
					else
						var_262_3.gameObject:SetActive(false)
					end
				end
			end

			local var_262_4 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				var_262_2.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_259_1.time_ - 0) / var_262_4)
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				var_262_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_262_5 = 0
			local var_262_6 = 0.8

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_7 = arg_259_1:GetWordFromCfg(413011063)
				local var_262_8 = arg_259_1:FormatText(var_262_7.content)

				arg_259_1.text_.text = var_262_8

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_10 = 32 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 32)

				if (32 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 32)) > 0 and var_262_6 < var_262_10 then
					arg_259_1.talkMaxDuration = var_262_10

					if var_262_10 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_5
					end
				end

				arg_259_1.text_.text = var_262_8
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011063", "story_v_out_413011.awb") ~= 0 then
					local var_262_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011063", "story_v_out_413011.awb") / 1000

					if var_262_11 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_5
					end

					if var_262_7.prefab_name ~= "" and arg_259_1.actors_[var_262_7.prefab_name] ~= nil then
						local var_262_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_7.prefab_name].transform, "story_v_out_413011", "413011063", "story_v_out_413011.awb")

						arg_259_1:RecordAudio("413011063", var_262_12)
						arg_259_1:RecordAudio("413011063", var_262_12)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_413011", "413011063", "story_v_out_413011.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_413011", "413011063", "story_v_out_413011.awb")
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
				actorName = "10022",
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
	Play413011064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 413011064
		arg_263_1.duration_ = 9

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play413011065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if arg_263_1.bgs_.F10f == nil then
				local var_266_0 = Object.Instantiate(arg_263_1.paintGo_)

				var_266_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10f")
				var_266_0.name = "F10f"
				var_266_0.transform.parent = arg_263_1.stage_.transform
				var_266_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.bgs_.F10f = var_266_0
			end

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= 2 + arg_266_0 then
				local var_266_1 = arg_263_1.bgs_.F10f

				arg_263_1.bgs_.F10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_266_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_2 = var_266_1:GetComponent("SpriteRenderer")

				if var_266_2 and var_266_2.sprite then
					local var_266_3 = 2 * (var_266_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_266_1.transform.localScale = Vector3.New(var_266_3 / var_266_2.sprite.bounds.size.y < var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x and var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x or var_266_3 / var_266_2.sprite.bounds.size.y, var_266_3 / var_266_2.sprite.bounds.size.y < var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x and var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x or var_266_3 / var_266_2.sprite.bounds.size.y, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "F10f" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_4 = 3.999999999999

			if 3.999999999999 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.allBtn_.enabled = false
			end

			if arg_263_1.time_ >= var_266_4 + 0.3 and arg_263_1.time_ < var_266_4 + 0.3 + arg_266_0 then
				arg_263_1.allBtn_.enabled = true
			end

			local var_266_5 = 0

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_6 = 2

			if var_266_5 <= arg_263_1.time_ and arg_263_1.time_ < var_266_5 + var_266_6 then
				local var_266_7 = Color.New(0, 0, 0)

				var_266_7.a = Mathf.Lerp(0, 1, (arg_263_1.time_ - var_266_5) / var_266_6)
				arg_263_1.mask_.color = var_266_7
			end

			if arg_263_1.time_ >= var_266_5 + var_266_6 and arg_263_1.time_ < var_266_5 + var_266_6 + arg_266_0 then
				local var_266_8 = Color.New(0, 0, 0)

				var_266_8.a = 1
				arg_263_1.mask_.color = var_266_8
			end

			local var_266_9 = 2

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_10 = 2

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_10 then
				local var_266_11 = Color.New(0, 0, 0)

				var_266_11.a = Mathf.Lerp(1, 0, (arg_263_1.time_ - var_266_9) / var_266_10)
				arg_263_1.mask_.color = var_266_11
			end

			if arg_263_1.time_ >= var_266_9 + var_266_10 and arg_263_1.time_ < var_266_9 + var_266_10 + arg_266_0 then
				local var_266_12 = Color.New(0, 0, 0)

				arg_263_1.mask_.enabled = false
				var_266_12.a = 0
				arg_263_1.mask_.color = var_266_12
			end

			local var_266_13 = arg_263_1.actors_["10094"].transform

			if 1.966 < arg_263_1.time_ and arg_263_1.time_ <= 1.966 + arg_266_0 then
				arg_263_1.var_.moveOldPos10094 = var_266_13.localPosition
				var_266_13.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("10094", 0)

				for iter_266_2 = 0, var_266_13.childCount - 1 do
					local var_266_14 = var_266_13:GetChild(iter_266_2)

					if var_266_14.name == "" or not string.find(var_266_14.name, "split") then
						var_266_14.gameObject:SetActive(true)
					else
						var_266_14.gameObject:SetActive(false)
					end
				end
			end

			local var_266_15 = 0.001

			if 1.966 <= arg_263_1.time_ and arg_263_1.time_ < 1.966 + var_266_15 then
				var_266_13.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_263_1.time_ - 1.966) / var_266_15)
			end

			if arg_263_1.time_ >= 1.966 + var_266_15 and arg_263_1.time_ < 1.966 + var_266_15 + arg_266_0 then
				var_266_13.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_266_16 = arg_263_1.actors_["10022"].transform

			if 1.966 < arg_263_1.time_ and arg_263_1.time_ <= 1.966 + arg_266_0 then
				arg_263_1.var_.moveOldPos10022 = var_266_16.localPosition
				var_266_16.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("10022", 0)

				for iter_266_3 = 0, var_266_16.childCount - 1 do
					local var_266_17 = var_266_16:GetChild(iter_266_3)

					if var_266_17.name == "" or not string.find(var_266_17.name, "split") then
						var_266_17.gameObject:SetActive(true)
					else
						var_266_17.gameObject:SetActive(false)
					end
				end
			end

			local var_266_18 = 0.001

			if 1.966 <= arg_263_1.time_ and arg_263_1.time_ < 1.966 + var_266_18 then
				var_266_16.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_263_1.time_ - 1.966) / var_266_18)
			end

			if arg_263_1.time_ >= 1.966 + var_266_18 and arg_263_1.time_ < 1.966 + var_266_18 + arg_266_0 then
				var_266_16.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_266_19 = arg_263_1.actors_["10094"]

			if 1.966 < arg_263_1.time_ and arg_263_1.time_ <= 1.966 + arg_266_0 and not isNil(var_266_19) and arg_263_1.var_.actorSpriteComps10094 == nil then
				arg_263_1.var_.actorSpriteComps10094 = var_266_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_20 = 0.0166666666666667

			if 1.966 <= arg_263_1.time_ and arg_263_1.time_ < 1.966 + var_266_20 and not isNil(var_266_19) then
				if arg_263_1.var_.actorSpriteComps10094 then
					for iter_266_4, iter_266_5 in pairs(arg_263_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_266_5 then
							if arg_263_1.isInRecall_ then
								iter_266_5.color = Color.New(Mathf.Lerp(iter_266_5.color.r, arg_263_1.hightColor2.r, (arg_263_1.time_ - 1.966) / var_266_20), Mathf.Lerp(iter_266_5.color.g, arg_263_1.hightColor2.g, (arg_263_1.time_ - 1.966) / var_266_20), (Mathf.Lerp(iter_266_5.color.b, arg_263_1.hightColor2.b, (arg_263_1.time_ - 1.966) / var_266_20)))
							else
								local var_266_21 = Mathf.Lerp(iter_266_5.color.r, 0.5, (arg_263_1.time_ - 1.966) / var_266_20)

								iter_266_5.color = Color.New(var_266_21, var_266_21, var_266_21)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 1.966 + var_266_20 and arg_263_1.time_ < 1.966 + var_266_20 + arg_266_0 and not isNil(var_266_19) and arg_263_1.var_.actorSpriteComps10094 then
				for iter_266_6, iter_266_7 in pairs(arg_263_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_266_7 then
						iter_266_7.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_263_1.var_.actorSpriteComps10094 = nil
			end

			local var_266_22 = arg_263_1.actors_["10022"]

			if 1.966 < arg_263_1.time_ and arg_263_1.time_ <= 1.966 + arg_266_0 and not isNil(var_266_22) and arg_263_1.var_.actorSpriteComps10022 == nil then
				arg_263_1.var_.actorSpriteComps10022 = var_266_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_23 = 0.0166666666666667

			if 1.966 <= arg_263_1.time_ and arg_263_1.time_ < 1.966 + var_266_23 and not isNil(var_266_22) then
				if arg_263_1.var_.actorSpriteComps10022 then
					for iter_266_8, iter_266_9 in pairs(arg_263_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_266_9 then
							if arg_263_1.isInRecall_ then
								iter_266_9.color = Color.New(Mathf.Lerp(iter_266_9.color.r, arg_263_1.hightColor2.r, (arg_263_1.time_ - 1.966) / var_266_23), Mathf.Lerp(iter_266_9.color.g, arg_263_1.hightColor2.g, (arg_263_1.time_ - 1.966) / var_266_23), (Mathf.Lerp(iter_266_9.color.b, arg_263_1.hightColor2.b, (arg_263_1.time_ - 1.966) / var_266_23)))
							else
								local var_266_24 = Mathf.Lerp(iter_266_9.color.r, 0.5, (arg_263_1.time_ - 1.966) / var_266_23)

								iter_266_9.color = Color.New(var_266_24, var_266_24, var_266_24)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 1.966 + var_266_23 and arg_263_1.time_ < 1.966 + var_266_23 + arg_266_0 and not isNil(var_266_22) and arg_263_1.var_.actorSpriteComps10022 then
				for iter_266_10, iter_266_11 in pairs(arg_263_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_266_11 then
						iter_266_11.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_263_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:AudioAction("play", "music", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_266_27 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

				if "" ~= "" then
					if arg_263_1.bgmTxt_.text ~= var_266_27 and arg_263_1.bgmTxt_.text ~= "" then
						if arg_263_1.bgmTxt2_.text ~= "" then
							arg_263_1.bgmTxt_.text = arg_263_1.bgmTxt2_.text
						end

						arg_263_1.bgmTxt2_.text = var_266_27

						arg_263_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_263_1.bgmTxt_.text = var_266_27
						arg_263_1.bgmTxt2_.text = var_266_27
					end

					if arg_263_1.bgmTimer then
						arg_263_1.bgmTimer:Stop()

						arg_263_1.bgmTimer = nil
					end

					if arg_263_1.settingData.show_music_name == 1 then
						arg_263_1.musicController:SetSelectedState("show")
						arg_263_1.musicAnimator_:Play("open", 0, 0)

						if arg_263_1.settingData.music_time ~= 0 then
							arg_263_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_263_1.settingData.music_time), function()
								if arg_263_1 == nil or isNil(arg_263_1.bgmTxt_) then
									return
								end

								arg_263_1.musicController:SetSelectedState("hide")
								arg_263_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.966 < arg_263_1.time_ and arg_263_1.time_ <= 1.966 + arg_266_0 then
				arg_263_1:SetSpriteNiuquEffect("10022", false)
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_29 = 3.999999999999
			local var_266_30 = 0.75

			if 3.999999999999 < arg_263_1.time_ and arg_263_1.time_ <= var_266_29 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_31 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_31:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_263_1.dialogCg_.alpha = arg_268_0
				end))
				var_266_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_32 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(413011064).content)

				arg_263_1.text_.text = var_266_32

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_34 = 30 <= 0 and var_266_30 or var_266_30 * (utf8.len(var_266_32) / 30)

				if (30 <= 0 and var_266_30 or var_266_30 * (utf8.len(var_266_32) / 30)) > 0 and var_266_30 < var_266_34 then
					arg_263_1.talkMaxDuration = var_266_34
					var_266_29 = var_266_29 + 0.3

					if var_266_34 + var_266_29 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_34 + var_266_29
					end
				end

				arg_263_1.text_.text = var_266_32
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_35 = var_266_29 + 0.3
			local var_266_36 = math.max(var_266_30, arg_263_1.talkMaxDuration)

			if var_266_29 + 0.3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_35 + var_266_36 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_35) / var_266_36

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_35 + var_266_36 and arg_263_1.time_ < var_266_35 + var_266_36 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play413011065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 413011065
		arg_270_1.duration_ = 2

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play413011066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if arg_270_1.actors_["10093"] == nil then
				local var_273_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_273_0) then
					local var_273_1 = Object.Instantiate(var_273_0, arg_270_1.canvasGo_.transform)

					var_273_1.transform:SetSiblingIndex(1)

					var_273_1.name = "10093"
					var_273_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_270_1.actors_["10093"] = var_273_1

					if arg_270_1.isInRecall_ then
						for iter_273_0, iter_273_1 in ipairs((var_273_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_273_1.color = arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_273_2 = arg_270_1.actors_["10093"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos10093 = var_273_2.localPosition
				var_273_2.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("10093", 3)

				for iter_273_2 = 0, var_273_2.childCount - 1 do
					local var_273_3 = var_273_2:GetChild(iter_273_2)

					if var_273_3.name == "split_3" or not string.find(var_273_3.name, "split") then
						var_273_3.gameObject:SetActive(true)
					else
						var_273_3.gameObject:SetActive(false)
					end
				end
			end

			local var_273_4 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				var_273_2.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_270_1.time_ - 0) / var_273_4)
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				var_273_2.localPosition = Vector3.New(0, -345, -245)
			end

			local var_273_5 = arg_270_1.actors_["10093"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.actorSpriteComps10093 == nil then
				arg_270_1.var_.actorSpriteComps10093 = var_273_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_6 = 2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_6 and not isNil(var_273_5) then
				if arg_270_1.var_.actorSpriteComps10093 then
					for iter_273_3, iter_273_4 in pairs(arg_270_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_273_4 then
							if arg_270_1.isInRecall_ then
								iter_273_4.color = Color.New(Mathf.Lerp(iter_273_4.color.r, arg_270_1.hightColor1.r, (arg_270_1.time_ - 0) / var_273_6), Mathf.Lerp(iter_273_4.color.g, arg_270_1.hightColor1.g, (arg_270_1.time_ - 0) / var_273_6), (Mathf.Lerp(iter_273_4.color.b, arg_270_1.hightColor1.b, (arg_270_1.time_ - 0) / var_273_6)))
							else
								local var_273_7 = Mathf.Lerp(iter_273_4.color.r, 1, (arg_270_1.time_ - 0) / var_273_6)

								iter_273_4.color = Color.New(var_273_7, var_273_7, var_273_7)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_6 and arg_270_1.time_ < 0 + var_273_6 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.actorSpriteComps10093 then
				for iter_273_5, iter_273_6 in pairs(arg_270_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_273_6 then
						iter_273_6.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				local var_273_8 = arg_270_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_273_8 then
					arg_270_1.var_.alphaOldValue10093 = var_273_8.alpha
					arg_270_1.var_.characterEffect10093 = var_273_8
				end

				arg_270_1.var_.alphaOldValue10093 = 0
			end

			local var_273_9 = 0.3

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_9 then
				if arg_270_1.var_.characterEffect10093 then
					arg_270_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_270_1.var_.alphaOldValue10093, 1, (arg_270_1.time_ - 0) / var_273_9)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_9 and arg_270_1.time_ < 0 + var_273_9 + arg_273_0 and arg_270_1.var_.characterEffect10093 then
				arg_270_1.var_.characterEffect10093.alpha = 1
			end

			local var_273_10 = manager.ui.mainCamera.transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.shakeOldPos = var_273_10.localPosition
			end

			local var_273_11 = 0.6

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_11 then
				local var_273_12, var_273_13 = math.modf((arg_270_1.time_ - 0) / 0.066)

				var_273_10.localPosition = Vector3.New(var_273_13 * 0.13, var_273_13 * 0.13, var_273_13 * 0.13) + arg_270_1.var_.shakeOldPos
			end

			if arg_270_1.time_ >= 0 + var_273_11 and arg_270_1.time_ < 0 + var_273_11 + arg_273_0 then
				var_273_10.localPosition = arg_270_1.var_.shakeOldPos
			end

			local var_273_14 = 0

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_14 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			if arg_270_1.time_ >= var_273_14 + 0.6 and arg_270_1.time_ < var_273_14 + 0.6 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end

			local var_273_15 = 0
			local var_273_16 = 0.1

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_17 = arg_270_1:GetWordFromCfg(413011065)
				local var_273_18 = arg_270_1:FormatText(var_273_17.content)

				arg_270_1.text_.text = var_273_18

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_20 = 4 <= 0 and var_273_16 or var_273_16 * (utf8.len(var_273_18) / 4)

				if (4 <= 0 and var_273_16 or var_273_16 * (utf8.len(var_273_18) / 4)) > 0 and var_273_16 < var_273_20 then
					arg_270_1.talkMaxDuration = var_273_20

					if var_273_20 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_20 + var_273_15
					end
				end

				arg_270_1.text_.text = var_273_18
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011065", "story_v_out_413011.awb") ~= 0 then
					local var_273_21 = manager.audio:GetVoiceLength("story_v_out_413011", "413011065", "story_v_out_413011.awb") / 1000

					if var_273_21 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_21 + var_273_15
					end

					if var_273_17.prefab_name ~= "" and arg_270_1.actors_[var_273_17.prefab_name] ~= nil then
						local var_273_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_17.prefab_name].transform, "story_v_out_413011", "413011065", "story_v_out_413011.awb")

						arg_270_1:RecordAudio("413011065", var_273_22)
						arg_270_1:RecordAudio("413011065", var_273_22)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_413011", "413011065", "story_v_out_413011.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_413011", "413011065", "story_v_out_413011.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_23 = math.max(var_273_16, arg_270_1.talkMaxDuration)

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_23 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_15) / var_273_23

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_15 + var_273_23 and arg_270_1.time_ < var_273_15 + var_273_23 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
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

		arg_270_1:InitPlayNodeList()
	end,
	Play413011066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 413011066
		arg_274_1.duration_ = 2

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play413011067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos10093 = arg_274_1.actors_["10093"].transform.localPosition
				arg_274_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("10093", 7)

				for iter_277_0 = 0, arg_274_1.actors_["10093"].transform.childCount - 1 do
					local var_277_0 = arg_274_1.actors_["10093"].transform:GetChild(iter_277_0)

					if var_277_0.name == "" or not string.find(var_277_0.name, "split") then
						var_277_0.gameObject:SetActive(true)
					else
						var_277_0.gameObject:SetActive(false)
					end
				end
			end

			local var_277_1 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_1 then
				arg_274_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_274_1.time_ - 0) / var_277_1)
			end

			if arg_274_1.time_ >= 0 + var_277_1 and arg_274_1.time_ < 0 + var_277_1 + arg_277_0 then
				arg_274_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.63333333333333 < arg_274_1.time_ and arg_274_1.time_ <= 1.63333333333333 + arg_277_0 then
				arg_274_1:AudioAction("play", "effect", "c_10079", "c_10079_bullet_7", "")
			end

			local var_277_3 = 0
			local var_277_4 = 0.2

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_3 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_5 = arg_274_1:GetWordFromCfg(413011066)
				local var_277_6 = arg_274_1:FormatText(var_277_5.content)

				arg_274_1.text_.text = var_277_6

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_8 = 8 <= 0 and var_277_4 or var_277_4 * (utf8.len(var_277_6) / 8)

				if (8 <= 0 and var_277_4 or var_277_4 * (utf8.len(var_277_6) / 8)) > 0 and var_277_4 < var_277_8 then
					arg_274_1.talkMaxDuration = var_277_8

					if var_277_8 + var_277_3 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_3
					end
				end

				arg_274_1.text_.text = var_277_6
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011066", "story_v_out_413011.awb") ~= 0 then
					local var_277_9 = manager.audio:GetVoiceLength("story_v_out_413011", "413011066", "story_v_out_413011.awb") / 1000

					if var_277_9 + var_277_3 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_9 + var_277_3
					end

					if var_277_5.prefab_name ~= "" and arg_274_1.actors_[var_277_5.prefab_name] ~= nil then
						local var_277_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_5.prefab_name].transform, "story_v_out_413011", "413011066", "story_v_out_413011.awb")

						arg_274_1:RecordAudio("413011066", var_277_10)
						arg_274_1:RecordAudio("413011066", var_277_10)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_413011", "413011066", "story_v_out_413011.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_413011", "413011066", "story_v_out_413011.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_11 = math.max(var_277_4, arg_274_1.talkMaxDuration)

			if var_277_3 <= arg_274_1.time_ and arg_274_1.time_ < var_277_3 + var_277_11 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_3) / var_277_11

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_3 + var_277_11 and arg_274_1.time_ < var_277_3 + var_277_11 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
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

		arg_274_1:InitPlayNodeList()
	end,
	Play413011067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 413011067
		arg_278_1.duration_ = 6

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play413011068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_9000

			if arg_278_1.actors_["10092"] == nil then
				local var_281_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_281_0) then
					local var_281_1 = Object.Instantiate(var_281_0, arg_278_1.canvasGo_.transform)

					var_281_1.transform:SetSiblingIndex(1)

					var_281_1.name = "10092"
					var_281_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_278_1.actors_["10092"] = var_281_1

					if arg_278_1.isInRecall_ then
						for iter_281_0, iter_281_1 in ipairs((var_281_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_281_1.color = arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_281_2 = arg_278_1.actors_["10092"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.actorSpriteComps10092 == nil then
				arg_278_1.var_.actorSpriteComps10092 = var_281_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_3 = 2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_3 and not isNil(var_281_2) then
				if arg_278_1.var_.actorSpriteComps10092 then
					for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_281_3 then
							if arg_278_1.isInRecall_ then
								iter_281_3.color = Color.New(Mathf.Lerp(iter_281_3.color.r, arg_278_1.hightColor2.r, (arg_278_1.time_ - 0) / var_281_3), Mathf.Lerp(iter_281_3.color.g, arg_278_1.hightColor2.g, (arg_278_1.time_ - 0) / var_281_3), (Mathf.Lerp(iter_281_3.color.b, arg_278_1.hightColor2.b, (arg_278_1.time_ - 0) / var_281_3)))
							else
								local var_281_4 = Mathf.Lerp(iter_281_3.color.r, 0.5, (arg_278_1.time_ - 0) / var_281_3)

								iter_281_3.color = Color.New(var_281_4, var_281_4, var_281_4)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 0 + var_281_3 and arg_278_1.time_ < 0 + var_281_3 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.actorSpriteComps10092 then
				for iter_281_4, iter_281_5 in pairs(arg_278_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_281_5 then
						iter_281_5.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_278_1.var_.actorSpriteComps10092 = nil
			end

			local var_281_5 = manager.ui.mainCamera.transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.shakeOldPos = var_281_5.localPosition
			end

			local var_281_6 = 0.6

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_6 then
				local var_281_7, var_281_8 = math.modf((arg_278_1.time_ - 0) / 0.066)

				var_281_5.localPosition = Vector3.New(var_281_8 * 0.13, var_281_8 * 0.13, var_281_8 * 0.13) + arg_278_1.var_.shakeOldPos
			end

			if arg_278_1.time_ >= 0 + var_281_6 and arg_278_1.time_ < 0 + var_281_6 + arg_281_0 then
				var_281_5.localPosition = arg_278_1.var_.shakeOldPos
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				local var_281_9 = arg_278_1.var_.effectjiaofeng1

				if not arg_278_1.var_.effectjiaofeng1 then
					var_281_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), manager.ui.mainCamera.transform)
					var_281_9.name = "jiaofeng1"
					arg_278_1.var_.effectjiaofeng1 = var_281_9
				else
					var_281_9.transform:SetParent(var_281_9000)
				end

				var_281_9.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_281_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_278_1.time_ and arg_278_1.time_ <= 1 + arg_281_0 then
				if arg_278_1.var_.effectjiaofeng1 then
					Object.Destroy(arg_278_1.var_.effectjiaofeng1)

					arg_278_1.var_.effectjiaofeng1 = nil
				end
			end

			if 0.466666666666667 < arg_278_1.time_ and arg_278_1.time_ <= 0.466666666666667 + arg_281_0 then
				arg_278_1:AudioAction("play", "effect", "se_story_1210", "se_story_1210_weaponfall", "")
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_13 = 1
			local var_281_14 = 0.8

			if 1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_13 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_15 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_15:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_16 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(413011067).content)

				arg_278_1.text_.text = var_281_16

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_18 = 32 <= 0 and var_281_14 or var_281_14 * (utf8.len(var_281_16) / 32)

				if (32 <= 0 and var_281_14 or var_281_14 * (utf8.len(var_281_16) / 32)) > 0 and var_281_14 < var_281_18 then
					arg_278_1.talkMaxDuration = var_281_18
					var_281_13 = var_281_13 + 0.3

					if var_281_18 + var_281_13 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_18 + var_281_13
					end
				end

				arg_278_1.text_.text = var_281_16
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_19 = var_281_13 + 0.3
			local var_281_20 = math.max(var_281_14, arg_278_1.talkMaxDuration)

			if var_281_13 + 0.3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_19 + var_281_20 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_19) / var_281_20

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_19 + var_281_20 and arg_278_1.time_ < var_281_19 + var_281_20 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play413011068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 413011068
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play413011069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_hit02", "")
			end

			if 0.542 < arg_284_1.time_ and arg_284_1.time_ <= 0.542 + arg_287_0 then
				arg_284_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_punch_hit", "")
			end

			local var_287_2 = manager.ui.mainCamera.transform

			if 0.0979541018605232 < arg_284_1.time_ and arg_284_1.time_ <= 0.0979541018605232 + arg_287_0 then
				arg_284_1.var_.shakeOldPos = var_287_2.localPosition
			end

			local var_287_3 = 0.5

			if 0.0979541018605232 <= arg_284_1.time_ and arg_284_1.time_ < 0.0979541018605232 + var_287_3 then
				local var_287_4, var_287_5 = math.modf((arg_284_1.time_ - 0.0979541018605232) / 0.066)

				var_287_2.localPosition = Vector3.New(var_287_5 * 0.13, var_287_5 * 0.13, var_287_5 * 0.13) + arg_284_1.var_.shakeOldPos
			end

			if arg_284_1.time_ >= 0.0979541018605232 + var_287_3 and arg_284_1.time_ < 0.0979541018605232 + var_287_3 + arg_287_0 then
				var_287_2.localPosition = arg_284_1.var_.shakeOldPos
			end

			local var_287_6 = 0

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			if arg_284_1.time_ >= var_287_6 + 0.597954101860523 and arg_284_1.time_ < var_287_6 + 0.597954101860523 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			local var_287_7 = 0
			local var_287_8 = 1

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_7 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_9 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(413011068).content)

				arg_284_1.text_.text = var_287_9

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 40 <= 0 and var_287_8 or var_287_8 * (utf8.len(var_287_9) / 40)

				if (40 <= 0 and var_287_8 or var_287_8 * (utf8.len(var_287_9) / 40)) > 0 and var_287_8 < var_287_11 then
					arg_284_1.talkMaxDuration = var_287_11

					if var_287_11 + var_287_7 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_11 + var_287_7
					end
				end

				arg_284_1.text_.text = var_287_9
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_12 = math.max(var_287_8, arg_284_1.talkMaxDuration)

			if var_287_7 <= arg_284_1.time_ and arg_284_1.time_ < var_287_7 + var_287_12 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_7) / var_287_12

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_7 + var_287_12 and arg_284_1.time_ < var_287_7 + var_287_12 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play413011069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 413011069
		arg_288_1.duration_ = 2.07

		local var_288_0 = {
			zh = 2.066,
			ja = 1.999999999999
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
				arg_288_0:Play413011070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos10092 = arg_288_1.actors_["10092"].transform.localPosition
				arg_288_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("10092", 2)

				for iter_291_0 = 0, arg_288_1.actors_["10092"].transform.childCount - 1 do
					local var_291_0 = arg_288_1.actors_["10092"].transform:GetChild(iter_291_0)

					if var_291_0.name == "" or not string.find(var_291_0.name, "split") then
						var_291_0.gameObject:SetActive(true)
					else
						var_291_0.gameObject:SetActive(false)
					end
				end
			end

			local var_291_1 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_1 then
				arg_288_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_288_1.time_ - 0) / var_291_1)
			end

			if arg_288_1.time_ >= 0 + var_291_1 and arg_288_1.time_ < 0 + var_291_1 + arg_291_0 then
				arg_288_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_291_2 = arg_288_1.actors_["10092"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.actorSpriteComps10092 == nil then
				arg_288_1.var_.actorSpriteComps10092 = var_291_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_3 = 2

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_3 and not isNil(var_291_2) then
				if arg_288_1.var_.actorSpriteComps10092 then
					for iter_291_1, iter_291_2 in pairs(arg_288_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_288_1.time_ >= 0 + var_291_3 and arg_288_1.time_ < 0 + var_291_3 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.actorSpriteComps10092 then
				for iter_291_3, iter_291_4 in pairs(arg_288_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_291_4 then
						iter_291_4.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_288_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				local var_291_5 = arg_288_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_291_5 then
					arg_288_1.var_.alphaOldValue10092 = var_291_5.alpha
					arg_288_1.var_.characterEffect10092 = var_291_5
				end

				arg_288_1.var_.alphaOldValue10092 = 0
			end

			local var_291_6 = 0.3

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_6 then
				if arg_288_1.var_.characterEffect10092 then
					arg_288_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_288_1.var_.alphaOldValue10092, 1, (arg_288_1.time_ - 0) / var_291_6)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_6 and arg_288_1.time_ < 0 + var_291_6 + arg_291_0 and arg_288_1.var_.characterEffect10092 then
				arg_288_1.var_.characterEffect10092.alpha = 1
			end

			local var_291_7 = 0
			local var_291_8 = 0.225

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_7 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_9 = arg_288_1:GetWordFromCfg(413011069)
				local var_291_10 = arg_288_1:FormatText(var_291_9.content)

				arg_288_1.text_.text = var_291_10

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_12 = 9 <= 0 and var_291_8 or var_291_8 * (utf8.len(var_291_10) / 9)

				if (9 <= 0 and var_291_8 or var_291_8 * (utf8.len(var_291_10) / 9)) > 0 and var_291_8 < var_291_12 then
					arg_288_1.talkMaxDuration = var_291_12

					if var_291_12 + var_291_7 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_12 + var_291_7
					end
				end

				arg_288_1.text_.text = var_291_10
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011069", "story_v_out_413011.awb") ~= 0 then
					local var_291_13 = manager.audio:GetVoiceLength("story_v_out_413011", "413011069", "story_v_out_413011.awb") / 1000

					if var_291_13 + var_291_7 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_7
					end

					if var_291_9.prefab_name ~= "" and arg_288_1.actors_[var_291_9.prefab_name] ~= nil then
						local var_291_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_9.prefab_name].transform, "story_v_out_413011", "413011069", "story_v_out_413011.awb")

						arg_288_1:RecordAudio("413011069", var_291_14)
						arg_288_1:RecordAudio("413011069", var_291_14)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_413011", "413011069", "story_v_out_413011.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_413011", "413011069", "story_v_out_413011.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_15 = math.max(var_291_8, arg_288_1.talkMaxDuration)

			if var_291_7 <= arg_288_1.time_ and arg_288_1.time_ < var_291_7 + var_291_15 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_7) / var_291_15

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_7 + var_291_15 and arg_288_1.time_ < var_291_7 + var_291_15 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
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

		arg_288_1:InitPlayNodeList()
	end,
	Play413011070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 413011070
		arg_292_1.duration_ = 5.8

		local var_292_0 = {
			zh = 4.633,
			ja = 5.8
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
				arg_292_0:Play413011071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos10093 = arg_292_1.actors_["10093"].transform.localPosition
				arg_292_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("10093", 4)

				for iter_295_0 = 0, arg_292_1.actors_["10093"].transform.childCount - 1 do
					local var_295_0 = arg_292_1.actors_["10093"].transform:GetChild(iter_295_0)

					if var_295_0.name == "split_4" or not string.find(var_295_0.name, "split") then
						var_295_0.gameObject:SetActive(true)
					else
						var_295_0.gameObject:SetActive(false)
					end
				end
			end

			local var_295_1 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_1 then
				arg_292_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_292_1.time_ - 0) / var_295_1)
			end

			if arg_292_1.time_ >= 0 + var_295_1 and arg_292_1.time_ < 0 + var_295_1 + arg_295_0 then
				arg_292_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_295_2 = arg_292_1.actors_["10093"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.actorSpriteComps10093 == nil then
				arg_292_1.var_.actorSpriteComps10093 = var_295_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_3 = 2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_3 and not isNil(var_295_2) then
				if arg_292_1.var_.actorSpriteComps10093 then
					for iter_295_1, iter_295_2 in pairs(arg_292_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_295_2 then
							if arg_292_1.isInRecall_ then
								iter_295_2.color = Color.New(Mathf.Lerp(iter_295_2.color.r, arg_292_1.hightColor1.r, (arg_292_1.time_ - 0) / var_295_3), Mathf.Lerp(iter_295_2.color.g, arg_292_1.hightColor1.g, (arg_292_1.time_ - 0) / var_295_3), (Mathf.Lerp(iter_295_2.color.b, arg_292_1.hightColor1.b, (arg_292_1.time_ - 0) / var_295_3)))
							else
								local var_295_4 = Mathf.Lerp(iter_295_2.color.r, 1, (arg_292_1.time_ - 0) / var_295_3)

								iter_295_2.color = Color.New(var_295_4, var_295_4, var_295_4)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= 0 + var_295_3 and arg_292_1.time_ < 0 + var_295_3 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.actorSpriteComps10093 then
				for iter_295_3, iter_295_4 in pairs(arg_292_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_295_4 then
						iter_295_4.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_292_1.var_.actorSpriteComps10093 = nil
			end

			local var_295_5 = arg_292_1.actors_["10092"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_5) and arg_292_1.var_.actorSpriteComps10092 == nil then
				arg_292_1.var_.actorSpriteComps10092 = var_295_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_6 = 2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_6 and not isNil(var_295_5) then
				if arg_292_1.var_.actorSpriteComps10092 then
					for iter_295_5, iter_295_6 in pairs(arg_292_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_295_6 then
							if arg_292_1.isInRecall_ then
								iter_295_6.color = Color.New(Mathf.Lerp(iter_295_6.color.r, arg_292_1.hightColor2.r, (arg_292_1.time_ - 0) / var_295_6), Mathf.Lerp(iter_295_6.color.g, arg_292_1.hightColor2.g, (arg_292_1.time_ - 0) / var_295_6), (Mathf.Lerp(iter_295_6.color.b, arg_292_1.hightColor2.b, (arg_292_1.time_ - 0) / var_295_6)))
							else
								local var_295_7 = Mathf.Lerp(iter_295_6.color.r, 0.5, (arg_292_1.time_ - 0) / var_295_6)

								iter_295_6.color = Color.New(var_295_7, var_295_7, var_295_7)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= 0 + var_295_6 and arg_292_1.time_ < 0 + var_295_6 + arg_295_0 and not isNil(var_295_5) and arg_292_1.var_.actorSpriteComps10092 then
				for iter_295_7, iter_295_8 in pairs(arg_292_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_295_8 then
						iter_295_8.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_292_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				local var_295_8 = arg_292_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_295_8 then
					arg_292_1.var_.alphaOldValue10093 = var_295_8.alpha
					arg_292_1.var_.characterEffect10093 = var_295_8
				end

				arg_292_1.var_.alphaOldValue10093 = 0
			end

			local var_295_9 = 0.3

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_9 then
				if arg_292_1.var_.characterEffect10093 then
					arg_292_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_292_1.var_.alphaOldValue10093, 1, (arg_292_1.time_ - 0) / var_295_9)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_9 and arg_292_1.time_ < 0 + var_295_9 + arg_295_0 and arg_292_1.var_.characterEffect10093 then
				arg_292_1.var_.characterEffect10093.alpha = 1
			end

			local var_295_10 = 0
			local var_295_11 = 0.425

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_10 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_12 = arg_292_1:GetWordFromCfg(413011070)
				local var_295_13 = arg_292_1:FormatText(var_295_12.content)

				arg_292_1.text_.text = var_295_13

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_15 = 17 <= 0 and var_295_11 or var_295_11 * (utf8.len(var_295_13) / 17)

				if (17 <= 0 and var_295_11 or var_295_11 * (utf8.len(var_295_13) / 17)) > 0 and var_295_11 < var_295_15 then
					arg_292_1.talkMaxDuration = var_295_15

					if var_295_15 + var_295_10 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_15 + var_295_10
					end
				end

				arg_292_1.text_.text = var_295_13
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011070", "story_v_out_413011.awb") ~= 0 then
					local var_295_16 = manager.audio:GetVoiceLength("story_v_out_413011", "413011070", "story_v_out_413011.awb") / 1000

					if var_295_16 + var_295_10 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_16 + var_295_10
					end

					if var_295_12.prefab_name ~= "" and arg_292_1.actors_[var_295_12.prefab_name] ~= nil then
						local var_295_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_12.prefab_name].transform, "story_v_out_413011", "413011070", "story_v_out_413011.awb")

						arg_292_1:RecordAudio("413011070", var_295_17)
						arg_292_1:RecordAudio("413011070", var_295_17)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_413011", "413011070", "story_v_out_413011.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_413011", "413011070", "story_v_out_413011.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_18 = math.max(var_295_11, arg_292_1.talkMaxDuration)

			if var_295_10 <= arg_292_1.time_ and arg_292_1.time_ < var_295_10 + var_295_18 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_10) / var_295_18

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_10 + var_295_18 and arg_292_1.time_ < var_295_10 + var_295_18 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
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

		arg_292_1:InitPlayNodeList()
	end,
	Play413011071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 413011071
		arg_296_1.duration_ = 11.37

		local var_296_0 = {
			zh = 5.833,
			ja = 11.366
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play413011072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["10093"]) and arg_296_1.var_.actorSpriteComps10093 == nil then
				arg_296_1.var_.actorSpriteComps10093 = arg_296_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_0 = 2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["10093"]) then
				if arg_296_1.var_.actorSpriteComps10093 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_299_1 then
							if arg_296_1.isInRecall_ then
								iter_299_1.color = Color.New(Mathf.Lerp(iter_299_1.color.r, arg_296_1.hightColor2.r, (arg_296_1.time_ - 0) / var_299_0), Mathf.Lerp(iter_299_1.color.g, arg_296_1.hightColor2.g, (arg_296_1.time_ - 0) / var_299_0), (Mathf.Lerp(iter_299_1.color.b, arg_296_1.hightColor2.b, (arg_296_1.time_ - 0) / var_299_0)))
							else
								local var_299_1 = Mathf.Lerp(iter_299_1.color.r, 0.5, (arg_296_1.time_ - 0) / var_299_0)

								iter_299_1.color = Color.New(var_299_1, var_299_1, var_299_1)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["10093"]) and arg_296_1.var_.actorSpriteComps10093 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_299_3 then
						iter_299_3.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_296_1.var_.actorSpriteComps10093 = nil
			end

			local var_299_2 = arg_296_1.actors_["10092"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.actorSpriteComps10092 == nil then
				arg_296_1.var_.actorSpriteComps10092 = var_299_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_3 = 2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_3 and not isNil(var_299_2) then
				if arg_296_1.var_.actorSpriteComps10092 then
					for iter_299_4, iter_299_5 in pairs(arg_296_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_299_5 then
							if arg_296_1.isInRecall_ then
								iter_299_5.color = Color.New(Mathf.Lerp(iter_299_5.color.r, arg_296_1.hightColor1.r, (arg_296_1.time_ - 0) / var_299_3), Mathf.Lerp(iter_299_5.color.g, arg_296_1.hightColor1.g, (arg_296_1.time_ - 0) / var_299_3), (Mathf.Lerp(iter_299_5.color.b, arg_296_1.hightColor1.b, (arg_296_1.time_ - 0) / var_299_3)))
							else
								local var_299_4 = Mathf.Lerp(iter_299_5.color.r, 1, (arg_296_1.time_ - 0) / var_299_3)

								iter_299_5.color = Color.New(var_299_4, var_299_4, var_299_4)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_3 and arg_296_1.time_ < 0 + var_299_3 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.actorSpriteComps10092 then
				for iter_299_6, iter_299_7 in pairs(arg_296_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_299_7 then
						iter_299_7.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_296_1.var_.actorSpriteComps10092 = nil
			end

			local var_299_5 = 0
			local var_299_6 = 0.65

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_7 = arg_296_1:GetWordFromCfg(413011071)
				local var_299_8 = arg_296_1:FormatText(var_299_7.content)

				arg_296_1.text_.text = var_299_8

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_10 = 26 <= 0 and var_299_6 or var_299_6 * (utf8.len(var_299_8) / 26)

				if (26 <= 0 and var_299_6 or var_299_6 * (utf8.len(var_299_8) / 26)) > 0 and var_299_6 < var_299_10 then
					arg_296_1.talkMaxDuration = var_299_10

					if var_299_10 + var_299_5 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_5
					end
				end

				arg_296_1.text_.text = var_299_8
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011071", "story_v_out_413011.awb") ~= 0 then
					local var_299_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011071", "story_v_out_413011.awb") / 1000

					if var_299_11 + var_299_5 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_11 + var_299_5
					end

					if var_299_7.prefab_name ~= "" and arg_296_1.actors_[var_299_7.prefab_name] ~= nil then
						local var_299_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_7.prefab_name].transform, "story_v_out_413011", "413011071", "story_v_out_413011.awb")

						arg_296_1:RecordAudio("413011071", var_299_12)
						arg_296_1:RecordAudio("413011071", var_299_12)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_413011", "413011071", "story_v_out_413011.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_413011", "413011071", "story_v_out_413011.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_13 = math.max(var_299_6, arg_296_1.talkMaxDuration)

			if var_299_5 <= arg_296_1.time_ and arg_296_1.time_ < var_299_5 + var_299_13 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_5) / var_299_13

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_5 + var_299_13 and arg_296_1.time_ < var_299_5 + var_299_13 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play413011072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 413011072
		arg_300_1.duration_ = 9.97

		local var_300_0 = {
			zh = 6.766,
			ja = 9.966
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play413011073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos10092 = arg_300_1.actors_["10092"].transform.localPosition
				arg_300_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("10092", 2)

				for iter_303_0 = 0, arg_300_1.actors_["10092"].transform.childCount - 1 do
					local var_303_0 = arg_300_1.actors_["10092"].transform:GetChild(iter_303_0)

					if var_303_0.name == "split_2" or not string.find(var_303_0.name, "split") then
						var_303_0.gameObject:SetActive(true)
					else
						var_303_0.gameObject:SetActive(false)
					end
				end
			end

			local var_303_1 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_1 then
				arg_300_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_300_1.time_ - 0) / var_303_1)
			end

			if arg_300_1.time_ >= 0 + var_303_1 and arg_300_1.time_ < 0 + var_303_1 + arg_303_0 then
				arg_300_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_303_2 = 0
			local var_303_3 = 0.725

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_2 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_4 = arg_300_1:GetWordFromCfg(413011072)
				local var_303_5 = arg_300_1:FormatText(var_303_4.content)

				arg_300_1.text_.text = var_303_5

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_7 = 29 <= 0 and var_303_3 or var_303_3 * (utf8.len(var_303_5) / 29)

				if (29 <= 0 and var_303_3 or var_303_3 * (utf8.len(var_303_5) / 29)) > 0 and var_303_3 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_2 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_2
					end
				end

				arg_300_1.text_.text = var_303_5
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011072", "story_v_out_413011.awb") ~= 0 then
					local var_303_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011072", "story_v_out_413011.awb") / 1000

					if var_303_8 + var_303_2 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_2
					end

					if var_303_4.prefab_name ~= "" and arg_300_1.actors_[var_303_4.prefab_name] ~= nil then
						local var_303_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_4.prefab_name].transform, "story_v_out_413011", "413011072", "story_v_out_413011.awb")

						arg_300_1:RecordAudio("413011072", var_303_9)
						arg_300_1:RecordAudio("413011072", var_303_9)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_413011", "413011072", "story_v_out_413011.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_413011", "413011072", "story_v_out_413011.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_10 = math.max(var_303_3, arg_300_1.talkMaxDuration)

			if var_303_2 <= arg_300_1.time_ and arg_300_1.time_ < var_303_2 + var_303_10 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_2) / var_303_10

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_2 + var_303_10 and arg_300_1.time_ < var_303_2 + var_303_10 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
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

		arg_300_1:InitPlayNodeList()
	end,
	Play413011073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 413011073
		arg_304_1.duration_ = 6.4

		local var_304_0 = {
			zh = 4.8,
			ja = 6.4
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play413011074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["10093"]) and arg_304_1.var_.actorSpriteComps10093 == nil then
				arg_304_1.var_.actorSpriteComps10093 = arg_304_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_0 = 2

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["10093"]) then
				if arg_304_1.var_.actorSpriteComps10093 then
					for iter_307_0, iter_307_1 in pairs(arg_304_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_307_1 then
							if arg_304_1.isInRecall_ then
								iter_307_1.color = Color.New(Mathf.Lerp(iter_307_1.color.r, arg_304_1.hightColor1.r, (arg_304_1.time_ - 0) / var_307_0), Mathf.Lerp(iter_307_1.color.g, arg_304_1.hightColor1.g, (arg_304_1.time_ - 0) / var_307_0), (Mathf.Lerp(iter_307_1.color.b, arg_304_1.hightColor1.b, (arg_304_1.time_ - 0) / var_307_0)))
							else
								local var_307_1 = Mathf.Lerp(iter_307_1.color.r, 1, (arg_304_1.time_ - 0) / var_307_0)

								iter_307_1.color = Color.New(var_307_1, var_307_1, var_307_1)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["10093"]) and arg_304_1.var_.actorSpriteComps10093 then
				for iter_307_2, iter_307_3 in pairs(arg_304_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_307_3 then
						iter_307_3.color = arg_304_1.isInRecall_ and (arg_304_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_304_1.var_.actorSpriteComps10093 = nil
			end

			local var_307_2 = arg_304_1.actors_["10092"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_2) and arg_304_1.var_.actorSpriteComps10092 == nil then
				arg_304_1.var_.actorSpriteComps10092 = var_307_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_3 = 2

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_3 and not isNil(var_307_2) then
				if arg_304_1.var_.actorSpriteComps10092 then
					for iter_307_4, iter_307_5 in pairs(arg_304_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_307_5 then
							if arg_304_1.isInRecall_ then
								iter_307_5.color = Color.New(Mathf.Lerp(iter_307_5.color.r, arg_304_1.hightColor2.r, (arg_304_1.time_ - 0) / var_307_3), Mathf.Lerp(iter_307_5.color.g, arg_304_1.hightColor2.g, (arg_304_1.time_ - 0) / var_307_3), (Mathf.Lerp(iter_307_5.color.b, arg_304_1.hightColor2.b, (arg_304_1.time_ - 0) / var_307_3)))
							else
								local var_307_4 = Mathf.Lerp(iter_307_5.color.r, 0.5, (arg_304_1.time_ - 0) / var_307_3)

								iter_307_5.color = Color.New(var_307_4, var_307_4, var_307_4)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= 0 + var_307_3 and arg_304_1.time_ < 0 + var_307_3 + arg_307_0 and not isNil(var_307_2) and arg_304_1.var_.actorSpriteComps10092 then
				for iter_307_6, iter_307_7 in pairs(arg_304_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_307_7 then
						iter_307_7.color = arg_304_1.isInRecall_ and (arg_304_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_304_1.var_.actorSpriteComps10092 = nil
			end

			local var_307_5 = 0
			local var_307_6 = 0.575

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_5 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_7 = arg_304_1:GetWordFromCfg(413011073)
				local var_307_8 = arg_304_1:FormatText(var_307_7.content)

				arg_304_1.text_.text = var_307_8

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_10 = 23 <= 0 and var_307_6 or var_307_6 * (utf8.len(var_307_8) / 23)

				if (23 <= 0 and var_307_6 or var_307_6 * (utf8.len(var_307_8) / 23)) > 0 and var_307_6 < var_307_10 then
					arg_304_1.talkMaxDuration = var_307_10

					if var_307_10 + var_307_5 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_10 + var_307_5
					end
				end

				arg_304_1.text_.text = var_307_8
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011073", "story_v_out_413011.awb") ~= 0 then
					local var_307_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011073", "story_v_out_413011.awb") / 1000

					if var_307_11 + var_307_5 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_11 + var_307_5
					end

					if var_307_7.prefab_name ~= "" and arg_304_1.actors_[var_307_7.prefab_name] ~= nil then
						local var_307_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_7.prefab_name].transform, "story_v_out_413011", "413011073", "story_v_out_413011.awb")

						arg_304_1:RecordAudio("413011073", var_307_12)
						arg_304_1:RecordAudio("413011073", var_307_12)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_413011", "413011073", "story_v_out_413011.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_413011", "413011073", "story_v_out_413011.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_13 = math.max(var_307_6, arg_304_1.talkMaxDuration)

			if var_307_5 <= arg_304_1.time_ and arg_304_1.time_ < var_307_5 + var_307_13 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_5) / var_307_13

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_5 + var_307_13 and arg_304_1.time_ < var_307_5 + var_307_13 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play413011074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 413011074
		arg_308_1.duration_ = 10.5

		local var_308_0 = {
			zh = 5.7,
			ja = 10.5
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play413011075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["10093"]) and arg_308_1.var_.actorSpriteComps10093 == nil then
				arg_308_1.var_.actorSpriteComps10093 = arg_308_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_0 = 2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["10093"]) then
				if arg_308_1.var_.actorSpriteComps10093 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								iter_311_1.color = Color.New(Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor2.r, (arg_308_1.time_ - 0) / var_311_0), Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor2.g, (arg_308_1.time_ - 0) / var_311_0), (Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor2.b, (arg_308_1.time_ - 0) / var_311_0)))
							else
								local var_311_1 = Mathf.Lerp(iter_311_1.color.r, 0.5, (arg_308_1.time_ - 0) / var_311_0)

								iter_311_1.color = Color.New(var_311_1, var_311_1, var_311_1)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["10093"]) and arg_308_1.var_.actorSpriteComps10093 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_311_3 then
						iter_311_3.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_308_1.var_.actorSpriteComps10093 = nil
			end

			local var_311_2 = arg_308_1.actors_["10092"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_2) and arg_308_1.var_.actorSpriteComps10092 == nil then
				arg_308_1.var_.actorSpriteComps10092 = var_311_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_3 = 2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_3 and not isNil(var_311_2) then
				if arg_308_1.var_.actorSpriteComps10092 then
					for iter_311_4, iter_311_5 in pairs(arg_308_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_311_5 then
							if arg_308_1.isInRecall_ then
								iter_311_5.color = Color.New(Mathf.Lerp(iter_311_5.color.r, arg_308_1.hightColor1.r, (arg_308_1.time_ - 0) / var_311_3), Mathf.Lerp(iter_311_5.color.g, arg_308_1.hightColor1.g, (arg_308_1.time_ - 0) / var_311_3), (Mathf.Lerp(iter_311_5.color.b, arg_308_1.hightColor1.b, (arg_308_1.time_ - 0) / var_311_3)))
							else
								local var_311_4 = Mathf.Lerp(iter_311_5.color.r, 1, (arg_308_1.time_ - 0) / var_311_3)

								iter_311_5.color = Color.New(var_311_4, var_311_4, var_311_4)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_3 and arg_308_1.time_ < 0 + var_311_3 + arg_311_0 and not isNil(var_311_2) and arg_308_1.var_.actorSpriteComps10092 then
				for iter_311_6, iter_311_7 in pairs(arg_308_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_311_7 then
						iter_311_7.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_308_1.var_.actorSpriteComps10092 = nil
			end

			local var_311_5 = arg_308_1.actors_["10092"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10092 = var_311_5.localPosition
				var_311_5.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("10092", 2)

				for iter_311_8 = 0, var_311_5.childCount - 1 do
					local var_311_6 = var_311_5:GetChild(iter_311_8)

					if var_311_6.name == "split_1_1" or not string.find(var_311_6.name, "split") then
						var_311_6.gameObject:SetActive(true)
					else
						var_311_6.gameObject:SetActive(false)
					end
				end
			end

			local var_311_7 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_7 then
				var_311_5.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_308_1.time_ - 0) / var_311_7)
			end

			if arg_308_1.time_ >= 0 + var_311_7 and arg_308_1.time_ < 0 + var_311_7 + arg_311_0 then
				var_311_5.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_311_8 = 0
			local var_311_9 = 0.675

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_8 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_10 = arg_308_1:GetWordFromCfg(413011074)
				local var_311_11 = arg_308_1:FormatText(var_311_10.content)

				arg_308_1.text_.text = var_311_11

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_13 = 27 <= 0 and var_311_9 or var_311_9 * (utf8.len(var_311_11) / 27)

				if (27 <= 0 and var_311_9 or var_311_9 * (utf8.len(var_311_11) / 27)) > 0 and var_311_9 < var_311_13 then
					arg_308_1.talkMaxDuration = var_311_13

					if var_311_13 + var_311_8 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_13 + var_311_8
					end
				end

				arg_308_1.text_.text = var_311_11
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011074", "story_v_out_413011.awb") ~= 0 then
					local var_311_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011074", "story_v_out_413011.awb") / 1000

					if var_311_14 + var_311_8 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_14 + var_311_8
					end

					if var_311_10.prefab_name ~= "" and arg_308_1.actors_[var_311_10.prefab_name] ~= nil then
						local var_311_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_10.prefab_name].transform, "story_v_out_413011", "413011074", "story_v_out_413011.awb")

						arg_308_1:RecordAudio("413011074", var_311_15)
						arg_308_1:RecordAudio("413011074", var_311_15)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_413011", "413011074", "story_v_out_413011.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_413011", "413011074", "story_v_out_413011.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_16 = math.max(var_311_9, arg_308_1.talkMaxDuration)

			if var_311_8 <= arg_308_1.time_ and arg_308_1.time_ < var_311_8 + var_311_16 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_8) / var_311_16

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_8 + var_311_16 and arg_308_1.time_ < var_311_8 + var_311_16 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
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

		arg_308_1:InitPlayNodeList()
	end,
	Play413011075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 413011075
		arg_312_1.duration_ = 4.5

		local var_312_0 = {
			zh = 1.999999999999,
			ja = 4.5
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play413011076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10093 = arg_312_1.actors_["10093"].transform.localPosition
				arg_312_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("10093", 4)

				for iter_315_0 = 0, arg_312_1.actors_["10093"].transform.childCount - 1 do
					local var_315_0 = arg_312_1.actors_["10093"].transform:GetChild(iter_315_0)

					if var_315_0.name == "" or not string.find(var_315_0.name, "split") then
						var_315_0.gameObject:SetActive(true)
					else
						var_315_0.gameObject:SetActive(false)
					end
				end
			end

			local var_315_1 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_1 then
				arg_312_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_312_1.time_ - 0) / var_315_1)
			end

			if arg_312_1.time_ >= 0 + var_315_1 and arg_312_1.time_ < 0 + var_315_1 + arg_315_0 then
				arg_312_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_315_2 = arg_312_1.actors_["10093"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps10093 == nil then
				arg_312_1.var_.actorSpriteComps10093 = var_315_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_3 = 2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_3 and not isNil(var_315_2) then
				if arg_312_1.var_.actorSpriteComps10093 then
					for iter_315_1, iter_315_2 in pairs(arg_312_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_315_2 then
							if arg_312_1.isInRecall_ then
								iter_315_2.color = Color.New(Mathf.Lerp(iter_315_2.color.r, arg_312_1.hightColor1.r, (arg_312_1.time_ - 0) / var_315_3), Mathf.Lerp(iter_315_2.color.g, arg_312_1.hightColor1.g, (arg_312_1.time_ - 0) / var_315_3), (Mathf.Lerp(iter_315_2.color.b, arg_312_1.hightColor1.b, (arg_312_1.time_ - 0) / var_315_3)))
							else
								local var_315_4 = Mathf.Lerp(iter_315_2.color.r, 1, (arg_312_1.time_ - 0) / var_315_3)

								iter_315_2.color = Color.New(var_315_4, var_315_4, var_315_4)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_3 and arg_312_1.time_ < 0 + var_315_3 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps10093 then
				for iter_315_3, iter_315_4 in pairs(arg_312_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_315_4 then
						iter_315_4.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_312_1.var_.actorSpriteComps10093 = nil
			end

			local var_315_5 = arg_312_1.actors_["10092"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_5) and arg_312_1.var_.actorSpriteComps10092 == nil then
				arg_312_1.var_.actorSpriteComps10092 = var_315_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_6 = 2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_6 and not isNil(var_315_5) then
				if arg_312_1.var_.actorSpriteComps10092 then
					for iter_315_5, iter_315_6 in pairs(arg_312_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_315_6 then
							if arg_312_1.isInRecall_ then
								iter_315_6.color = Color.New(Mathf.Lerp(iter_315_6.color.r, arg_312_1.hightColor2.r, (arg_312_1.time_ - 0) / var_315_6), Mathf.Lerp(iter_315_6.color.g, arg_312_1.hightColor2.g, (arg_312_1.time_ - 0) / var_315_6), (Mathf.Lerp(iter_315_6.color.b, arg_312_1.hightColor2.b, (arg_312_1.time_ - 0) / var_315_6)))
							else
								local var_315_7 = Mathf.Lerp(iter_315_6.color.r, 0.5, (arg_312_1.time_ - 0) / var_315_6)

								iter_315_6.color = Color.New(var_315_7, var_315_7, var_315_7)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_6 and arg_312_1.time_ < 0 + var_315_6 + arg_315_0 and not isNil(var_315_5) and arg_312_1.var_.actorSpriteComps10092 then
				for iter_315_7, iter_315_8 in pairs(arg_312_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_315_8 then
						iter_315_8.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_312_1.var_.actorSpriteComps10092 = nil
			end

			local var_315_8 = 0
			local var_315_9 = 0.275

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_8 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_10 = arg_312_1:GetWordFromCfg(413011075)
				local var_315_11 = arg_312_1:FormatText(var_315_10.content)

				arg_312_1.text_.text = var_315_11

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_13 = 11 <= 0 and var_315_9 or var_315_9 * (utf8.len(var_315_11) / 11)

				if (11 <= 0 and var_315_9 or var_315_9 * (utf8.len(var_315_11) / 11)) > 0 and var_315_9 < var_315_13 then
					arg_312_1.talkMaxDuration = var_315_13

					if var_315_13 + var_315_8 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_13 + var_315_8
					end
				end

				arg_312_1.text_.text = var_315_11
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011075", "story_v_out_413011.awb") ~= 0 then
					local var_315_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011075", "story_v_out_413011.awb") / 1000

					if var_315_14 + var_315_8 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_14 + var_315_8
					end

					if var_315_10.prefab_name ~= "" and arg_312_1.actors_[var_315_10.prefab_name] ~= nil then
						local var_315_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_10.prefab_name].transform, "story_v_out_413011", "413011075", "story_v_out_413011.awb")

						arg_312_1:RecordAudio("413011075", var_315_15)
						arg_312_1:RecordAudio("413011075", var_315_15)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_413011", "413011075", "story_v_out_413011.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_413011", "413011075", "story_v_out_413011.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_16 = math.max(var_315_9, arg_312_1.talkMaxDuration)

			if var_315_8 <= arg_312_1.time_ and arg_312_1.time_ < var_315_8 + var_315_16 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_8) / var_315_16

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_8 + var_315_16 and arg_312_1.time_ < var_315_8 + var_315_16 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
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

		arg_312_1:InitPlayNodeList()
	end,
	Play413011076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 413011076
		arg_316_1.duration_ = 3.6

		local var_316_0 = {
			zh = 2.433,
			ja = 3.6
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play413011077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["10093"]) and arg_316_1.var_.actorSpriteComps10093 == nil then
				arg_316_1.var_.actorSpriteComps10093 = arg_316_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_0 = 2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["10093"]) then
				if arg_316_1.var_.actorSpriteComps10093 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								iter_319_1.color = Color.New(Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor2.r, (arg_316_1.time_ - 0) / var_319_0), Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor2.g, (arg_316_1.time_ - 0) / var_319_0), (Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor2.b, (arg_316_1.time_ - 0) / var_319_0)))
							else
								local var_319_1 = Mathf.Lerp(iter_319_1.color.r, 0.5, (arg_316_1.time_ - 0) / var_319_0)

								iter_319_1.color = Color.New(var_319_1, var_319_1, var_319_1)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["10093"]) and arg_316_1.var_.actorSpriteComps10093 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_319_3 then
						iter_319_3.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_316_1.var_.actorSpriteComps10093 = nil
			end

			local var_319_2 = arg_316_1.actors_["10092"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.actorSpriteComps10092 == nil then
				arg_316_1.var_.actorSpriteComps10092 = var_319_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_3 = 2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_3 and not isNil(var_319_2) then
				if arg_316_1.var_.actorSpriteComps10092 then
					for iter_319_4, iter_319_5 in pairs(arg_316_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_319_5 then
							if arg_316_1.isInRecall_ then
								iter_319_5.color = Color.New(Mathf.Lerp(iter_319_5.color.r, arg_316_1.hightColor1.r, (arg_316_1.time_ - 0) / var_319_3), Mathf.Lerp(iter_319_5.color.g, arg_316_1.hightColor1.g, (arg_316_1.time_ - 0) / var_319_3), (Mathf.Lerp(iter_319_5.color.b, arg_316_1.hightColor1.b, (arg_316_1.time_ - 0) / var_319_3)))
							else
								local var_319_4 = Mathf.Lerp(iter_319_5.color.r, 1, (arg_316_1.time_ - 0) / var_319_3)

								iter_319_5.color = Color.New(var_319_4, var_319_4, var_319_4)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_3 and arg_316_1.time_ < 0 + var_319_3 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.actorSpriteComps10092 then
				for iter_319_6, iter_319_7 in pairs(arg_316_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_319_7 then
						iter_319_7.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_316_1.var_.actorSpriteComps10092 = nil
			end

			local var_319_5 = 0
			local var_319_6 = 0.225

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_5 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_7 = arg_316_1:GetWordFromCfg(413011076)
				local var_319_8 = arg_316_1:FormatText(var_319_7.content)

				arg_316_1.text_.text = var_319_8

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_10 = 9 <= 0 and var_319_6 or var_319_6 * (utf8.len(var_319_8) / 9)

				if (9 <= 0 and var_319_6 or var_319_6 * (utf8.len(var_319_8) / 9)) > 0 and var_319_6 < var_319_10 then
					arg_316_1.talkMaxDuration = var_319_10

					if var_319_10 + var_319_5 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_10 + var_319_5
					end
				end

				arg_316_1.text_.text = var_319_8
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011076", "story_v_out_413011.awb") ~= 0 then
					local var_319_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011076", "story_v_out_413011.awb") / 1000

					if var_319_11 + var_319_5 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_11 + var_319_5
					end

					if var_319_7.prefab_name ~= "" and arg_316_1.actors_[var_319_7.prefab_name] ~= nil then
						local var_319_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_7.prefab_name].transform, "story_v_out_413011", "413011076", "story_v_out_413011.awb")

						arg_316_1:RecordAudio("413011076", var_319_12)
						arg_316_1:RecordAudio("413011076", var_319_12)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_413011", "413011076", "story_v_out_413011.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_413011", "413011076", "story_v_out_413011.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_13 = math.max(var_319_6, arg_316_1.talkMaxDuration)

			if var_319_5 <= arg_316_1.time_ and arg_316_1.time_ < var_319_5 + var_319_13 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_5) / var_319_13

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_5 + var_319_13 and arg_316_1.time_ < var_319_5 + var_319_13 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play413011077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 413011077
		arg_320_1.duration_ = 10.5

		local var_320_0 = {
			zh = 8.566,
			ja = 10.5
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play413011078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 1.1

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:GetWordFromCfg(413011077)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 44 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 44)

				if (44 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 44)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011077", "story_v_out_413011.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011077", "story_v_out_413011.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_413011", "413011077", "story_v_out_413011.awb")

						arg_320_1:RecordAudio("413011077", var_323_6)
						arg_320_1:RecordAudio("413011077", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_413011", "413011077", "story_v_out_413011.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_413011", "413011077", "story_v_out_413011.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play413011078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 413011078
		arg_324_1.duration_ = 12.2

		local var_324_0 = {
			zh = 6.9,
			ja = 12.2
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play413011079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0.95

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_1 = arg_324_1:GetWordFromCfg(413011078)
				local var_327_2 = arg_324_1:FormatText(var_327_1.content)

				arg_324_1.text_.text = var_327_2

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 38 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 38)

				if (38 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 38)) > 0 and var_327_0 < var_327_4 then
					arg_324_1.talkMaxDuration = var_327_4

					if var_327_4 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_4 + 0
					end
				end

				arg_324_1.text_.text = var_327_2
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011078", "story_v_out_413011.awb") ~= 0 then
					local var_327_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011078", "story_v_out_413011.awb") / 1000

					if var_327_5 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + 0
					end

					if var_327_1.prefab_name ~= "" and arg_324_1.actors_[var_327_1.prefab_name] ~= nil then
						local var_327_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_1.prefab_name].transform, "story_v_out_413011", "413011078", "story_v_out_413011.awb")

						arg_324_1:RecordAudio("413011078", var_327_6)
						arg_324_1:RecordAudio("413011078", var_327_6)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_413011", "413011078", "story_v_out_413011.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_413011", "413011078", "story_v_out_413011.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_7 and arg_324_1.time_ < 0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play413011079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 413011079
		arg_328_1.duration_ = 9.23

		local var_328_0 = {
			zh = 4.5,
			ja = 9.233
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play413011080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0.55

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_1 = arg_328_1:GetWordFromCfg(413011079)
				local var_331_2 = arg_328_1:FormatText(var_331_1.content)

				arg_328_1.text_.text = var_331_2

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_4 = 22 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 22)

				if (22 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 22)) > 0 and var_331_0 < var_331_4 then
					arg_328_1.talkMaxDuration = var_331_4

					if var_331_4 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_4 + 0
					end
				end

				arg_328_1.text_.text = var_331_2
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011079", "story_v_out_413011.awb") ~= 0 then
					local var_331_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011079", "story_v_out_413011.awb") / 1000

					if var_331_5 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + 0
					end

					if var_331_1.prefab_name ~= "" and arg_328_1.actors_[var_331_1.prefab_name] ~= nil then
						local var_331_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_1.prefab_name].transform, "story_v_out_413011", "413011079", "story_v_out_413011.awb")

						arg_328_1:RecordAudio("413011079", var_331_6)
						arg_328_1:RecordAudio("413011079", var_331_6)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_413011", "413011079", "story_v_out_413011.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_413011", "413011079", "story_v_out_413011.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_7 = math.max(var_331_0, arg_328_1.talkMaxDuration)

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_7 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - 0) / var_331_7

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= 0 + var_331_7 and arg_328_1.time_ < 0 + var_331_7 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play413011080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 413011080
		arg_332_1.duration_ = 8.2

		local var_332_0 = {
			zh = 7.1,
			ja = 8.2
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play413011081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos10092 = arg_332_1.actors_["10092"].transform.localPosition
				arg_332_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("10092", 2)

				for iter_335_0 = 0, arg_332_1.actors_["10092"].transform.childCount - 1 do
					local var_335_0 = arg_332_1.actors_["10092"].transform:GetChild(iter_335_0)

					if var_335_0.name == "split_6" or not string.find(var_335_0.name, "split") then
						var_335_0.gameObject:SetActive(true)
					else
						var_335_0.gameObject:SetActive(false)
					end
				end
			end

			local var_335_1 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_1 then
				arg_332_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_332_1.time_ - 0) / var_335_1)
			end

			if arg_332_1.time_ >= 0 + var_335_1 and arg_332_1.time_ < 0 + var_335_1 + arg_335_0 then
				arg_332_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_335_2 = 0
			local var_335_3 = 0.575

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_2 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_4 = arg_332_1:GetWordFromCfg(413011080)
				local var_335_5 = arg_332_1:FormatText(var_335_4.content)

				arg_332_1.text_.text = var_335_5

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_7 = 23 <= 0 and var_335_3 or var_335_3 * (utf8.len(var_335_5) / 23)

				if (23 <= 0 and var_335_3 or var_335_3 * (utf8.len(var_335_5) / 23)) > 0 and var_335_3 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_2 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_2
					end
				end

				arg_332_1.text_.text = var_335_5
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011080", "story_v_out_413011.awb") ~= 0 then
					local var_335_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011080", "story_v_out_413011.awb") / 1000

					if var_335_8 + var_335_2 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_8 + var_335_2
					end

					if var_335_4.prefab_name ~= "" and arg_332_1.actors_[var_335_4.prefab_name] ~= nil then
						local var_335_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_4.prefab_name].transform, "story_v_out_413011", "413011080", "story_v_out_413011.awb")

						arg_332_1:RecordAudio("413011080", var_335_9)
						arg_332_1:RecordAudio("413011080", var_335_9)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_413011", "413011080", "story_v_out_413011.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_413011", "413011080", "story_v_out_413011.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_10 = math.max(var_335_3, arg_332_1.talkMaxDuration)

			if var_335_2 <= arg_332_1.time_ and arg_332_1.time_ < var_335_2 + var_335_10 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_2) / var_335_10

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_2 + var_335_10 and arg_332_1.time_ < var_335_2 + var_335_10 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
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

		arg_332_1:InitPlayNodeList()
	end,
	Play413011081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 413011081
		arg_336_1.duration_ = 3.43

		local var_336_0 = {
			zh = 1.999999999999,
			ja = 3.433
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play413011082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos10093 = arg_336_1.actors_["10093"].transform.localPosition
				arg_336_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_336_1:CheckSpriteTmpPos("10093", 4)

				for iter_339_0 = 0, arg_336_1.actors_["10093"].transform.childCount - 1 do
					local var_339_0 = arg_336_1.actors_["10093"].transform:GetChild(iter_339_0)

					if var_339_0.name == "split_7" or not string.find(var_339_0.name, "split") then
						var_339_0.gameObject:SetActive(true)
					else
						var_339_0.gameObject:SetActive(false)
					end
				end
			end

			local var_339_1 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_1 then
				arg_336_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_336_1.time_ - 0) / var_339_1)
			end

			if arg_336_1.time_ >= 0 + var_339_1 and arg_336_1.time_ < 0 + var_339_1 + arg_339_0 then
				arg_336_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_339_2 = arg_336_1.actors_["10093"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_2) and arg_336_1.var_.actorSpriteComps10093 == nil then
				arg_336_1.var_.actorSpriteComps10093 = var_339_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_3 = 2

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_3 and not isNil(var_339_2) then
				if arg_336_1.var_.actorSpriteComps10093 then
					for iter_339_1, iter_339_2 in pairs(arg_336_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_339_2 then
							if arg_336_1.isInRecall_ then
								iter_339_2.color = Color.New(Mathf.Lerp(iter_339_2.color.r, arg_336_1.hightColor1.r, (arg_336_1.time_ - 0) / var_339_3), Mathf.Lerp(iter_339_2.color.g, arg_336_1.hightColor1.g, (arg_336_1.time_ - 0) / var_339_3), (Mathf.Lerp(iter_339_2.color.b, arg_336_1.hightColor1.b, (arg_336_1.time_ - 0) / var_339_3)))
							else
								local var_339_4 = Mathf.Lerp(iter_339_2.color.r, 1, (arg_336_1.time_ - 0) / var_339_3)

								iter_339_2.color = Color.New(var_339_4, var_339_4, var_339_4)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= 0 + var_339_3 and arg_336_1.time_ < 0 + var_339_3 + arg_339_0 and not isNil(var_339_2) and arg_336_1.var_.actorSpriteComps10093 then
				for iter_339_3, iter_339_4 in pairs(arg_336_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_339_4 then
						iter_339_4.color = arg_336_1.isInRecall_ and (arg_336_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_336_1.var_.actorSpriteComps10093 = nil
			end

			local var_339_5 = arg_336_1.actors_["10092"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.actorSpriteComps10092 == nil then
				arg_336_1.var_.actorSpriteComps10092 = var_339_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_6 = 2

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_6 and not isNil(var_339_5) then
				if arg_336_1.var_.actorSpriteComps10092 then
					for iter_339_5, iter_339_6 in pairs(arg_336_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_339_6 then
							if arg_336_1.isInRecall_ then
								iter_339_6.color = Color.New(Mathf.Lerp(iter_339_6.color.r, arg_336_1.hightColor2.r, (arg_336_1.time_ - 0) / var_339_6), Mathf.Lerp(iter_339_6.color.g, arg_336_1.hightColor2.g, (arg_336_1.time_ - 0) / var_339_6), (Mathf.Lerp(iter_339_6.color.b, arg_336_1.hightColor2.b, (arg_336_1.time_ - 0) / var_339_6)))
							else
								local var_339_7 = Mathf.Lerp(iter_339_6.color.r, 0.5, (arg_336_1.time_ - 0) / var_339_6)

								iter_339_6.color = Color.New(var_339_7, var_339_7, var_339_7)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= 0 + var_339_6 and arg_336_1.time_ < 0 + var_339_6 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.actorSpriteComps10092 then
				for iter_339_7, iter_339_8 in pairs(arg_336_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_339_8 then
						iter_339_8.color = arg_336_1.isInRecall_ and (arg_336_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_336_1.var_.actorSpriteComps10092 = nil
			end

			local var_339_8 = 0
			local var_339_9 = 0.175

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_8 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_10 = arg_336_1:GetWordFromCfg(413011081)
				local var_339_11 = arg_336_1:FormatText(var_339_10.content)

				arg_336_1.text_.text = var_339_11

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_13 = 7 <= 0 and var_339_9 or var_339_9 * (utf8.len(var_339_11) / 7)

				if (7 <= 0 and var_339_9 or var_339_9 * (utf8.len(var_339_11) / 7)) > 0 and var_339_9 < var_339_13 then
					arg_336_1.talkMaxDuration = var_339_13

					if var_339_13 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_13 + var_339_8
					end
				end

				arg_336_1.text_.text = var_339_11
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011081", "story_v_out_413011.awb") ~= 0 then
					local var_339_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011081", "story_v_out_413011.awb") / 1000

					if var_339_14 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_14 + var_339_8
					end

					if var_339_10.prefab_name ~= "" and arg_336_1.actors_[var_339_10.prefab_name] ~= nil then
						local var_339_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_10.prefab_name].transform, "story_v_out_413011", "413011081", "story_v_out_413011.awb")

						arg_336_1:RecordAudio("413011081", var_339_15)
						arg_336_1:RecordAudio("413011081", var_339_15)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_413011", "413011081", "story_v_out_413011.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_413011", "413011081", "story_v_out_413011.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_16 = math.max(var_339_9, arg_336_1.talkMaxDuration)

			if var_339_8 <= arg_336_1.time_ and arg_336_1.time_ < var_339_8 + var_339_16 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_8) / var_339_16

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_8 + var_339_16 and arg_336_1.time_ < var_339_8 + var_339_16 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play413011082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 413011082
		arg_340_1.duration_ = 5.3

		local var_340_0 = {
			zh = 4.066,
			ja = 5.3
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play413011083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["10093"]) and arg_340_1.var_.actorSpriteComps10093 == nil then
				arg_340_1.var_.actorSpriteComps10093 = arg_340_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_0 = 2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["10093"]) then
				if arg_340_1.var_.actorSpriteComps10093 then
					for iter_343_0, iter_343_1 in pairs(arg_340_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_343_1 then
							if arg_340_1.isInRecall_ then
								iter_343_1.color = Color.New(Mathf.Lerp(iter_343_1.color.r, arg_340_1.hightColor2.r, (arg_340_1.time_ - 0) / var_343_0), Mathf.Lerp(iter_343_1.color.g, arg_340_1.hightColor2.g, (arg_340_1.time_ - 0) / var_343_0), (Mathf.Lerp(iter_343_1.color.b, arg_340_1.hightColor2.b, (arg_340_1.time_ - 0) / var_343_0)))
							else
								local var_343_1 = Mathf.Lerp(iter_343_1.color.r, 0.5, (arg_340_1.time_ - 0) / var_343_0)

								iter_343_1.color = Color.New(var_343_1, var_343_1, var_343_1)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["10093"]) and arg_340_1.var_.actorSpriteComps10093 then
				for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_343_3 then
						iter_343_3.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_340_1.var_.actorSpriteComps10093 = nil
			end

			local var_343_2 = arg_340_1.actors_["10092"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_2) and arg_340_1.var_.actorSpriteComps10092 == nil then
				arg_340_1.var_.actorSpriteComps10092 = var_343_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_3 = 2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_3 and not isNil(var_343_2) then
				if arg_340_1.var_.actorSpriteComps10092 then
					for iter_343_4, iter_343_5 in pairs(arg_340_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_343_5 then
							if arg_340_1.isInRecall_ then
								iter_343_5.color = Color.New(Mathf.Lerp(iter_343_5.color.r, arg_340_1.hightColor1.r, (arg_340_1.time_ - 0) / var_343_3), Mathf.Lerp(iter_343_5.color.g, arg_340_1.hightColor1.g, (arg_340_1.time_ - 0) / var_343_3), (Mathf.Lerp(iter_343_5.color.b, arg_340_1.hightColor1.b, (arg_340_1.time_ - 0) / var_343_3)))
							else
								local var_343_4 = Mathf.Lerp(iter_343_5.color.r, 1, (arg_340_1.time_ - 0) / var_343_3)

								iter_343_5.color = Color.New(var_343_4, var_343_4, var_343_4)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 0 + var_343_3 and arg_340_1.time_ < 0 + var_343_3 + arg_343_0 and not isNil(var_343_2) and arg_340_1.var_.actorSpriteComps10092 then
				for iter_343_6, iter_343_7 in pairs(arg_340_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_343_7 then
						iter_343_7.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_340_1.var_.actorSpriteComps10092 = nil
			end

			local var_343_5 = 0
			local var_343_6 = 0.475

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_5 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_7 = arg_340_1:GetWordFromCfg(413011082)
				local var_343_8 = arg_340_1:FormatText(var_343_7.content)

				arg_340_1.text_.text = var_343_8

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_10 = 19 <= 0 and var_343_6 or var_343_6 * (utf8.len(var_343_8) / 19)

				if (19 <= 0 and var_343_6 or var_343_6 * (utf8.len(var_343_8) / 19)) > 0 and var_343_6 < var_343_10 then
					arg_340_1.talkMaxDuration = var_343_10

					if var_343_10 + var_343_5 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_10 + var_343_5
					end
				end

				arg_340_1.text_.text = var_343_8
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011082", "story_v_out_413011.awb") ~= 0 then
					local var_343_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011082", "story_v_out_413011.awb") / 1000

					if var_343_11 + var_343_5 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_11 + var_343_5
					end

					if var_343_7.prefab_name ~= "" and arg_340_1.actors_[var_343_7.prefab_name] ~= nil then
						local var_343_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_7.prefab_name].transform, "story_v_out_413011", "413011082", "story_v_out_413011.awb")

						arg_340_1:RecordAudio("413011082", var_343_12)
						arg_340_1:RecordAudio("413011082", var_343_12)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_413011", "413011082", "story_v_out_413011.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_413011", "413011082", "story_v_out_413011.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_13 = math.max(var_343_6, arg_340_1.talkMaxDuration)

			if var_343_5 <= arg_340_1.time_ and arg_340_1.time_ < var_343_5 + var_343_13 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_5) / var_343_13

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_5 + var_343_13 and arg_340_1.time_ < var_343_5 + var_343_13 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play413011083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 413011083
		arg_344_1.duration_ = 7.37

		local var_344_0 = {
			zh = 4.6,
			ja = 7.366
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play413011084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["10093"]) and arg_344_1.var_.actorSpriteComps10093 == nil then
				arg_344_1.var_.actorSpriteComps10093 = arg_344_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_0 = 2

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["10093"]) then
				if arg_344_1.var_.actorSpriteComps10093 then
					for iter_347_0, iter_347_1 in pairs(arg_344_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_347_1 then
							if arg_344_1.isInRecall_ then
								iter_347_1.color = Color.New(Mathf.Lerp(iter_347_1.color.r, arg_344_1.hightColor1.r, (arg_344_1.time_ - 0) / var_347_0), Mathf.Lerp(iter_347_1.color.g, arg_344_1.hightColor1.g, (arg_344_1.time_ - 0) / var_347_0), (Mathf.Lerp(iter_347_1.color.b, arg_344_1.hightColor1.b, (arg_344_1.time_ - 0) / var_347_0)))
							else
								local var_347_1 = Mathf.Lerp(iter_347_1.color.r, 1, (arg_344_1.time_ - 0) / var_347_0)

								iter_347_1.color = Color.New(var_347_1, var_347_1, var_347_1)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["10093"]) and arg_344_1.var_.actorSpriteComps10093 then
				for iter_347_2, iter_347_3 in pairs(arg_344_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_347_3 then
						iter_347_3.color = arg_344_1.isInRecall_ and (arg_344_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_344_1.var_.actorSpriteComps10093 = nil
			end

			local var_347_2 = arg_344_1.actors_["10092"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_2) and arg_344_1.var_.actorSpriteComps10092 == nil then
				arg_344_1.var_.actorSpriteComps10092 = var_347_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_3 = 2

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_3 and not isNil(var_347_2) then
				if arg_344_1.var_.actorSpriteComps10092 then
					for iter_347_4, iter_347_5 in pairs(arg_344_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_347_5 then
							if arg_344_1.isInRecall_ then
								iter_347_5.color = Color.New(Mathf.Lerp(iter_347_5.color.r, arg_344_1.hightColor2.r, (arg_344_1.time_ - 0) / var_347_3), Mathf.Lerp(iter_347_5.color.g, arg_344_1.hightColor2.g, (arg_344_1.time_ - 0) / var_347_3), (Mathf.Lerp(iter_347_5.color.b, arg_344_1.hightColor2.b, (arg_344_1.time_ - 0) / var_347_3)))
							else
								local var_347_4 = Mathf.Lerp(iter_347_5.color.r, 0.5, (arg_344_1.time_ - 0) / var_347_3)

								iter_347_5.color = Color.New(var_347_4, var_347_4, var_347_4)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= 0 + var_347_3 and arg_344_1.time_ < 0 + var_347_3 + arg_347_0 and not isNil(var_347_2) and arg_344_1.var_.actorSpriteComps10092 then
				for iter_347_6, iter_347_7 in pairs(arg_344_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_347_7 then
						iter_347_7.color = arg_344_1.isInRecall_ and (arg_344_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_344_1.var_.actorSpriteComps10092 = nil
			end

			local var_347_5 = 0
			local var_347_6 = 0.675

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_5 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_7 = arg_344_1:GetWordFromCfg(413011083)
				local var_347_8 = arg_344_1:FormatText(var_347_7.content)

				arg_344_1.text_.text = var_347_8

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_10 = 27 <= 0 and var_347_6 or var_347_6 * (utf8.len(var_347_8) / 27)

				if (27 <= 0 and var_347_6 or var_347_6 * (utf8.len(var_347_8) / 27)) > 0 and var_347_6 < var_347_10 then
					arg_344_1.talkMaxDuration = var_347_10

					if var_347_10 + var_347_5 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_10 + var_347_5
					end
				end

				arg_344_1.text_.text = var_347_8
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011083", "story_v_out_413011.awb") ~= 0 then
					local var_347_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011083", "story_v_out_413011.awb") / 1000

					if var_347_11 + var_347_5 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_11 + var_347_5
					end

					if var_347_7.prefab_name ~= "" and arg_344_1.actors_[var_347_7.prefab_name] ~= nil then
						local var_347_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_7.prefab_name].transform, "story_v_out_413011", "413011083", "story_v_out_413011.awb")

						arg_344_1:RecordAudio("413011083", var_347_12)
						arg_344_1:RecordAudio("413011083", var_347_12)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_413011", "413011083", "story_v_out_413011.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_413011", "413011083", "story_v_out_413011.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_13 = math.max(var_347_6, arg_344_1.talkMaxDuration)

			if var_347_5 <= arg_344_1.time_ and arg_344_1.time_ < var_347_5 + var_347_13 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_5) / var_347_13

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_5 + var_347_13 and arg_344_1.time_ < var_347_5 + var_347_13 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play413011084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 413011084
		arg_348_1.duration_ = 9.23

		local var_348_0 = {
			zh = 5.1,
			ja = 9.233
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play413011085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["10093"]) and arg_348_1.var_.actorSpriteComps10093 == nil then
				arg_348_1.var_.actorSpriteComps10093 = arg_348_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_0 = 2

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["10093"]) then
				if arg_348_1.var_.actorSpriteComps10093 then
					for iter_351_0, iter_351_1 in pairs(arg_348_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_351_1 then
							if arg_348_1.isInRecall_ then
								iter_351_1.color = Color.New(Mathf.Lerp(iter_351_1.color.r, arg_348_1.hightColor2.r, (arg_348_1.time_ - 0) / var_351_0), Mathf.Lerp(iter_351_1.color.g, arg_348_1.hightColor2.g, (arg_348_1.time_ - 0) / var_351_0), (Mathf.Lerp(iter_351_1.color.b, arg_348_1.hightColor2.b, (arg_348_1.time_ - 0) / var_351_0)))
							else
								local var_351_1 = Mathf.Lerp(iter_351_1.color.r, 0.5, (arg_348_1.time_ - 0) / var_351_0)

								iter_351_1.color = Color.New(var_351_1, var_351_1, var_351_1)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["10093"]) and arg_348_1.var_.actorSpriteComps10093 then
				for iter_351_2, iter_351_3 in pairs(arg_348_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_351_3 then
						iter_351_3.color = arg_348_1.isInRecall_ and (arg_348_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_348_1.var_.actorSpriteComps10093 = nil
			end

			local var_351_2 = arg_348_1.actors_["10092"]

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(var_351_2) and arg_348_1.var_.actorSpriteComps10092 == nil then
				arg_348_1.var_.actorSpriteComps10092 = var_351_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_3 = 2

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_3 and not isNil(var_351_2) then
				if arg_348_1.var_.actorSpriteComps10092 then
					for iter_351_4, iter_351_5 in pairs(arg_348_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_351_5 then
							if arg_348_1.isInRecall_ then
								iter_351_5.color = Color.New(Mathf.Lerp(iter_351_5.color.r, arg_348_1.hightColor1.r, (arg_348_1.time_ - 0) / var_351_3), Mathf.Lerp(iter_351_5.color.g, arg_348_1.hightColor1.g, (arg_348_1.time_ - 0) / var_351_3), (Mathf.Lerp(iter_351_5.color.b, arg_348_1.hightColor1.b, (arg_348_1.time_ - 0) / var_351_3)))
							else
								local var_351_4 = Mathf.Lerp(iter_351_5.color.r, 1, (arg_348_1.time_ - 0) / var_351_3)

								iter_351_5.color = Color.New(var_351_4, var_351_4, var_351_4)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= 0 + var_351_3 and arg_348_1.time_ < 0 + var_351_3 + arg_351_0 and not isNil(var_351_2) and arg_348_1.var_.actorSpriteComps10092 then
				for iter_351_6, iter_351_7 in pairs(arg_348_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_351_7 then
						iter_351_7.color = arg_348_1.isInRecall_ and (arg_348_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_348_1.var_.actorSpriteComps10092 = nil
			end

			local var_351_5 = arg_348_1.actors_["10092"].transform

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos10092 = var_351_5.localPosition
				var_351_5.localScale = Vector3.New(1, 1, 1)

				arg_348_1:CheckSpriteTmpPos("10092", 2)

				for iter_351_8 = 0, var_351_5.childCount - 1 do
					local var_351_6 = var_351_5:GetChild(iter_351_8)

					if var_351_6.name == "split_6" or not string.find(var_351_6.name, "split") then
						var_351_6.gameObject:SetActive(true)
					else
						var_351_6.gameObject:SetActive(false)
					end
				end
			end

			local var_351_7 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				var_351_5.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_348_1.time_ - 0) / var_351_7)
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				var_351_5.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_351_8 = 0
			local var_351_9 = 0.65

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_8 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_10 = arg_348_1:GetWordFromCfg(413011084)
				local var_351_11 = arg_348_1:FormatText(var_351_10.content)

				arg_348_1.text_.text = var_351_11

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_13 = 26 <= 0 and var_351_9 or var_351_9 * (utf8.len(var_351_11) / 26)

				if (26 <= 0 and var_351_9 or var_351_9 * (utf8.len(var_351_11) / 26)) > 0 and var_351_9 < var_351_13 then
					arg_348_1.talkMaxDuration = var_351_13

					if var_351_13 + var_351_8 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_13 + var_351_8
					end
				end

				arg_348_1.text_.text = var_351_11
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011084", "story_v_out_413011.awb") ~= 0 then
					local var_351_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011084", "story_v_out_413011.awb") / 1000

					if var_351_14 + var_351_8 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_14 + var_351_8
					end

					if var_351_10.prefab_name ~= "" and arg_348_1.actors_[var_351_10.prefab_name] ~= nil then
						local var_351_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_10.prefab_name].transform, "story_v_out_413011", "413011084", "story_v_out_413011.awb")

						arg_348_1:RecordAudio("413011084", var_351_15)
						arg_348_1:RecordAudio("413011084", var_351_15)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_413011", "413011084", "story_v_out_413011.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_413011", "413011084", "story_v_out_413011.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_16 = math.max(var_351_9, arg_348_1.talkMaxDuration)

			if var_351_8 <= arg_348_1.time_ and arg_348_1.time_ < var_351_8 + var_351_16 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_8) / var_351_16

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_8 + var_351_16 and arg_348_1.time_ < var_351_8 + var_351_16 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
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

		arg_348_1:InitPlayNodeList()
	end,
	Play413011085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 413011085
		arg_352_1.duration_ = 3.03

		local var_352_0 = {
			zh = 1.999999999999,
			ja = 3.033
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play413011086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["10093"]) and arg_352_1.var_.actorSpriteComps10093 == nil then
				arg_352_1.var_.actorSpriteComps10093 = arg_352_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_0 = 2

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["10093"]) then
				if arg_352_1.var_.actorSpriteComps10093 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								iter_355_1.color = Color.New(Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor1.r, (arg_352_1.time_ - 0) / var_355_0), Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor1.g, (arg_352_1.time_ - 0) / var_355_0), (Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor1.b, (arg_352_1.time_ - 0) / var_355_0)))
							else
								local var_355_1 = Mathf.Lerp(iter_355_1.color.r, 1, (arg_352_1.time_ - 0) / var_355_0)

								iter_355_1.color = Color.New(var_355_1, var_355_1, var_355_1)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["10093"]) and arg_352_1.var_.actorSpriteComps10093 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_355_3 then
						iter_355_3.color = arg_352_1.isInRecall_ and (arg_352_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_352_1.var_.actorSpriteComps10093 = nil
			end

			local var_355_2 = arg_352_1.actors_["10092"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_2) and arg_352_1.var_.actorSpriteComps10092 == nil then
				arg_352_1.var_.actorSpriteComps10092 = var_355_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_3 = 2

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_3 and not isNil(var_355_2) then
				if arg_352_1.var_.actorSpriteComps10092 then
					for iter_355_4, iter_355_5 in pairs(arg_352_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_355_5 then
							if arg_352_1.isInRecall_ then
								iter_355_5.color = Color.New(Mathf.Lerp(iter_355_5.color.r, arg_352_1.hightColor2.r, (arg_352_1.time_ - 0) / var_355_3), Mathf.Lerp(iter_355_5.color.g, arg_352_1.hightColor2.g, (arg_352_1.time_ - 0) / var_355_3), (Mathf.Lerp(iter_355_5.color.b, arg_352_1.hightColor2.b, (arg_352_1.time_ - 0) / var_355_3)))
							else
								local var_355_4 = Mathf.Lerp(iter_355_5.color.r, 0.5, (arg_352_1.time_ - 0) / var_355_3)

								iter_355_5.color = Color.New(var_355_4, var_355_4, var_355_4)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= 0 + var_355_3 and arg_352_1.time_ < 0 + var_355_3 + arg_355_0 and not isNil(var_355_2) and arg_352_1.var_.actorSpriteComps10092 then
				for iter_355_6, iter_355_7 in pairs(arg_352_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_355_7 then
						iter_355_7.color = arg_352_1.isInRecall_ and (arg_352_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_352_1.var_.actorSpriteComps10092 = nil
			end

			local var_355_5 = 0
			local var_355_6 = 0.125

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_7 = arg_352_1:GetWordFromCfg(413011085)
				local var_355_8 = arg_352_1:FormatText(var_355_7.content)

				arg_352_1.text_.text = var_355_8

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_10 = 5 <= 0 and var_355_6 or var_355_6 * (utf8.len(var_355_8) / 5)

				if (5 <= 0 and var_355_6 or var_355_6 * (utf8.len(var_355_8) / 5)) > 0 and var_355_6 < var_355_10 then
					arg_352_1.talkMaxDuration = var_355_10

					if var_355_10 + var_355_5 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_10 + var_355_5
					end
				end

				arg_352_1.text_.text = var_355_8
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011085", "story_v_out_413011.awb") ~= 0 then
					local var_355_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011085", "story_v_out_413011.awb") / 1000

					if var_355_11 + var_355_5 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_11 + var_355_5
					end

					if var_355_7.prefab_name ~= "" and arg_352_1.actors_[var_355_7.prefab_name] ~= nil then
						local var_355_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_7.prefab_name].transform, "story_v_out_413011", "413011085", "story_v_out_413011.awb")

						arg_352_1:RecordAudio("413011085", var_355_12)
						arg_352_1:RecordAudio("413011085", var_355_12)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_413011", "413011085", "story_v_out_413011.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_413011", "413011085", "story_v_out_413011.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_13 = math.max(var_355_6, arg_352_1.talkMaxDuration)

			if var_355_5 <= arg_352_1.time_ and arg_352_1.time_ < var_355_5 + var_355_13 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_5) / var_355_13

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_5 + var_355_13 and arg_352_1.time_ < var_355_5 + var_355_13 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play413011086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 413011086
		arg_356_1.duration_ = 4

		local var_356_0 = {
			zh = 4,
			ja = 3.766
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play413011087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos10092 = arg_356_1.actors_["10092"].transform.localPosition
				arg_356_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_356_1:CheckSpriteTmpPos("10092", 2)

				for iter_359_0 = 0, arg_356_1.actors_["10092"].transform.childCount - 1 do
					local var_359_0 = arg_356_1.actors_["10092"].transform:GetChild(iter_359_0)

					if var_359_0.name == "split_2" or not string.find(var_359_0.name, "split") then
						var_359_0.gameObject:SetActive(true)
					else
						var_359_0.gameObject:SetActive(false)
					end
				end
			end

			local var_359_1 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_1 then
				arg_356_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_356_1.time_ - 0) / var_359_1)
			end

			if arg_356_1.time_ >= 0 + var_359_1 and arg_356_1.time_ < 0 + var_359_1 + arg_359_0 then
				arg_356_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_359_2 = arg_356_1.actors_["10093"]

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(var_359_2) and arg_356_1.var_.actorSpriteComps10093 == nil then
				arg_356_1.var_.actorSpriteComps10093 = var_359_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_359_3 = 2

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_3 and not isNil(var_359_2) then
				if arg_356_1.var_.actorSpriteComps10093 then
					for iter_359_1, iter_359_2 in pairs(arg_356_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_359_2 then
							if arg_356_1.isInRecall_ then
								iter_359_2.color = Color.New(Mathf.Lerp(iter_359_2.color.r, arg_356_1.hightColor2.r, (arg_356_1.time_ - 0) / var_359_3), Mathf.Lerp(iter_359_2.color.g, arg_356_1.hightColor2.g, (arg_356_1.time_ - 0) / var_359_3), (Mathf.Lerp(iter_359_2.color.b, arg_356_1.hightColor2.b, (arg_356_1.time_ - 0) / var_359_3)))
							else
								local var_359_4 = Mathf.Lerp(iter_359_2.color.r, 0.5, (arg_356_1.time_ - 0) / var_359_3)

								iter_359_2.color = Color.New(var_359_4, var_359_4, var_359_4)
							end
						end
					end
				end
			end

			if arg_356_1.time_ >= 0 + var_359_3 and arg_356_1.time_ < 0 + var_359_3 + arg_359_0 and not isNil(var_359_2) and arg_356_1.var_.actorSpriteComps10093 then
				for iter_359_3, iter_359_4 in pairs(arg_356_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_359_4 then
						iter_359_4.color = arg_356_1.isInRecall_ and (arg_356_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_356_1.var_.actorSpriteComps10093 = nil
			end

			local var_359_5 = arg_356_1.actors_["10092"]

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(var_359_5) and arg_356_1.var_.actorSpriteComps10092 == nil then
				arg_356_1.var_.actorSpriteComps10092 = var_359_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_359_6 = 2

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_6 and not isNil(var_359_5) then
				if arg_356_1.var_.actorSpriteComps10092 then
					for iter_359_5, iter_359_6 in pairs(arg_356_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_359_6 then
							if arg_356_1.isInRecall_ then
								iter_359_6.color = Color.New(Mathf.Lerp(iter_359_6.color.r, arg_356_1.hightColor1.r, (arg_356_1.time_ - 0) / var_359_6), Mathf.Lerp(iter_359_6.color.g, arg_356_1.hightColor1.g, (arg_356_1.time_ - 0) / var_359_6), (Mathf.Lerp(iter_359_6.color.b, arg_356_1.hightColor1.b, (arg_356_1.time_ - 0) / var_359_6)))
							else
								local var_359_7 = Mathf.Lerp(iter_359_6.color.r, 1, (arg_356_1.time_ - 0) / var_359_6)

								iter_359_6.color = Color.New(var_359_7, var_359_7, var_359_7)
							end
						end
					end
				end
			end

			if arg_356_1.time_ >= 0 + var_359_6 and arg_356_1.time_ < 0 + var_359_6 + arg_359_0 and not isNil(var_359_5) and arg_356_1.var_.actorSpriteComps10092 then
				for iter_359_7, iter_359_8 in pairs(arg_356_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_359_8 then
						iter_359_8.color = arg_356_1.isInRecall_ and (arg_356_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_356_1.var_.actorSpriteComps10092 = nil
			end

			local var_359_8 = 0
			local var_359_9 = 0.425

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_8 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_10 = arg_356_1:GetWordFromCfg(413011086)
				local var_359_11 = arg_356_1:FormatText(var_359_10.content)

				arg_356_1.text_.text = var_359_11

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_13 = 17 <= 0 and var_359_9 or var_359_9 * (utf8.len(var_359_11) / 17)

				if (17 <= 0 and var_359_9 or var_359_9 * (utf8.len(var_359_11) / 17)) > 0 and var_359_9 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_8 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_8
					end
				end

				arg_356_1.text_.text = var_359_11
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011086", "story_v_out_413011.awb") ~= 0 then
					local var_359_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011086", "story_v_out_413011.awb") / 1000

					if var_359_14 + var_359_8 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_14 + var_359_8
					end

					if var_359_10.prefab_name ~= "" and arg_356_1.actors_[var_359_10.prefab_name] ~= nil then
						local var_359_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_10.prefab_name].transform, "story_v_out_413011", "413011086", "story_v_out_413011.awb")

						arg_356_1:RecordAudio("413011086", var_359_15)
						arg_356_1:RecordAudio("413011086", var_359_15)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_413011", "413011086", "story_v_out_413011.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_413011", "413011086", "story_v_out_413011.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_16 = math.max(var_359_9, arg_356_1.talkMaxDuration)

			if var_359_8 <= arg_356_1.time_ and arg_356_1.time_ < var_359_8 + var_359_16 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_8) / var_359_16

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_8 + var_359_16 and arg_356_1.time_ < var_359_8 + var_359_16 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
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

		arg_356_1:InitPlayNodeList()
	end,
	Play413011087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 413011087
		arg_360_1.duration_ = 5.6

		local var_360_0 = {
			zh = 5.6,
			ja = 3.866
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play413011088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0.825

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_1 = arg_360_1:GetWordFromCfg(413011087)
				local var_363_2 = arg_360_1:FormatText(var_363_1.content)

				arg_360_1.text_.text = var_363_2

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 33 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 33)

				if (33 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 33)) > 0 and var_363_0 < var_363_4 then
					arg_360_1.talkMaxDuration = var_363_4

					if var_363_4 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_4 + 0
					end
				end

				arg_360_1.text_.text = var_363_2
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011087", "story_v_out_413011.awb") ~= 0 then
					local var_363_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011087", "story_v_out_413011.awb") / 1000

					if var_363_5 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + 0
					end

					if var_363_1.prefab_name ~= "" and arg_360_1.actors_[var_363_1.prefab_name] ~= nil then
						local var_363_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_1.prefab_name].transform, "story_v_out_413011", "413011087", "story_v_out_413011.awb")

						arg_360_1:RecordAudio("413011087", var_363_6)
						arg_360_1:RecordAudio("413011087", var_363_6)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_413011", "413011087", "story_v_out_413011.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_413011", "413011087", "story_v_out_413011.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_7 and arg_360_1.time_ < 0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play413011088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 413011088
		arg_364_1.duration_ = 2.5

		local var_364_0 = {
			zh = 2.5,
			ja = 1.999999999999
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play413011089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos10093 = arg_364_1.actors_["10093"].transform.localPosition
				arg_364_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_364_1:CheckSpriteTmpPos("10093", 4)

				for iter_367_0 = 0, arg_364_1.actors_["10093"].transform.childCount - 1 do
					local var_367_0 = arg_364_1.actors_["10093"].transform:GetChild(iter_367_0)

					if var_367_0.name == "split_1" or not string.find(var_367_0.name, "split") then
						var_367_0.gameObject:SetActive(true)
					else
						var_367_0.gameObject:SetActive(false)
					end
				end
			end

			local var_367_1 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_1 then
				arg_364_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_364_1.time_ - 0) / var_367_1)
			end

			if arg_364_1.time_ >= 0 + var_367_1 and arg_364_1.time_ < 0 + var_367_1 + arg_367_0 then
				arg_364_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_367_2 = arg_364_1.actors_["10093"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_2) and arg_364_1.var_.actorSpriteComps10093 == nil then
				arg_364_1.var_.actorSpriteComps10093 = var_367_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_3 = 2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_3 and not isNil(var_367_2) then
				if arg_364_1.var_.actorSpriteComps10093 then
					for iter_367_1, iter_367_2 in pairs(arg_364_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_367_2 then
							if arg_364_1.isInRecall_ then
								iter_367_2.color = Color.New(Mathf.Lerp(iter_367_2.color.r, arg_364_1.hightColor1.r, (arg_364_1.time_ - 0) / var_367_3), Mathf.Lerp(iter_367_2.color.g, arg_364_1.hightColor1.g, (arg_364_1.time_ - 0) / var_367_3), (Mathf.Lerp(iter_367_2.color.b, arg_364_1.hightColor1.b, (arg_364_1.time_ - 0) / var_367_3)))
							else
								local var_367_4 = Mathf.Lerp(iter_367_2.color.r, 1, (arg_364_1.time_ - 0) / var_367_3)

								iter_367_2.color = Color.New(var_367_4, var_367_4, var_367_4)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= 0 + var_367_3 and arg_364_1.time_ < 0 + var_367_3 + arg_367_0 and not isNil(var_367_2) and arg_364_1.var_.actorSpriteComps10093 then
				for iter_367_3, iter_367_4 in pairs(arg_364_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_367_4 then
						iter_367_4.color = arg_364_1.isInRecall_ and (arg_364_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_364_1.var_.actorSpriteComps10093 = nil
			end

			local var_367_5 = arg_364_1.actors_["10092"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_5) and arg_364_1.var_.actorSpriteComps10092 == nil then
				arg_364_1.var_.actorSpriteComps10092 = var_367_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_6 = 2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_6 and not isNil(var_367_5) then
				if arg_364_1.var_.actorSpriteComps10092 then
					for iter_367_5, iter_367_6 in pairs(arg_364_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_367_6 then
							if arg_364_1.isInRecall_ then
								iter_367_6.color = Color.New(Mathf.Lerp(iter_367_6.color.r, arg_364_1.hightColor2.r, (arg_364_1.time_ - 0) / var_367_6), Mathf.Lerp(iter_367_6.color.g, arg_364_1.hightColor2.g, (arg_364_1.time_ - 0) / var_367_6), (Mathf.Lerp(iter_367_6.color.b, arg_364_1.hightColor2.b, (arg_364_1.time_ - 0) / var_367_6)))
							else
								local var_367_7 = Mathf.Lerp(iter_367_6.color.r, 0.5, (arg_364_1.time_ - 0) / var_367_6)

								iter_367_6.color = Color.New(var_367_7, var_367_7, var_367_7)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= 0 + var_367_6 and arg_364_1.time_ < 0 + var_367_6 + arg_367_0 and not isNil(var_367_5) and arg_364_1.var_.actorSpriteComps10092 then
				for iter_367_7, iter_367_8 in pairs(arg_364_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_367_8 then
						iter_367_8.color = arg_364_1.isInRecall_ and (arg_364_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_364_1.var_.actorSpriteComps10092 = nil
			end

			local var_367_8 = 0
			local var_367_9 = 0.2

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_8 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_10 = arg_364_1:GetWordFromCfg(413011088)
				local var_367_11 = arg_364_1:FormatText(var_367_10.content)

				arg_364_1.text_.text = var_367_11

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_13 = 8 <= 0 and var_367_9 or var_367_9 * (utf8.len(var_367_11) / 8)

				if (8 <= 0 and var_367_9 or var_367_9 * (utf8.len(var_367_11) / 8)) > 0 and var_367_9 < var_367_13 then
					arg_364_1.talkMaxDuration = var_367_13

					if var_367_13 + var_367_8 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_13 + var_367_8
					end
				end

				arg_364_1.text_.text = var_367_11
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011088", "story_v_out_413011.awb") ~= 0 then
					local var_367_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011088", "story_v_out_413011.awb") / 1000

					if var_367_14 + var_367_8 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_14 + var_367_8
					end

					if var_367_10.prefab_name ~= "" and arg_364_1.actors_[var_367_10.prefab_name] ~= nil then
						local var_367_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_10.prefab_name].transform, "story_v_out_413011", "413011088", "story_v_out_413011.awb")

						arg_364_1:RecordAudio("413011088", var_367_15)
						arg_364_1:RecordAudio("413011088", var_367_15)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_413011", "413011088", "story_v_out_413011.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_413011", "413011088", "story_v_out_413011.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_16 = math.max(var_367_9, arg_364_1.talkMaxDuration)

			if var_367_8 <= arg_364_1.time_ and arg_364_1.time_ < var_367_8 + var_367_16 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_8) / var_367_16

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_8 + var_367_16 and arg_364_1.time_ < var_367_8 + var_367_16 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
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

		arg_364_1:InitPlayNodeList()
	end,
	Play413011089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 413011089
		arg_368_1.duration_ = 2

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play413011090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos10092 = arg_368_1.actors_["10092"].transform.localPosition
				arg_368_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_368_1:CheckSpriteTmpPos("10092", 2)

				for iter_371_0 = 0, arg_368_1.actors_["10092"].transform.childCount - 1 do
					local var_371_0 = arg_368_1.actors_["10092"].transform:GetChild(iter_371_0)

					if var_371_0.name == "" or not string.find(var_371_0.name, "split") then
						var_371_0.gameObject:SetActive(true)
					else
						var_371_0.gameObject:SetActive(false)
					end
				end
			end

			local var_371_1 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_1 then
				arg_368_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_368_1.time_ - 0) / var_371_1)
			end

			if arg_368_1.time_ >= 0 + var_371_1 and arg_368_1.time_ < 0 + var_371_1 + arg_371_0 then
				arg_368_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_371_2 = arg_368_1.actors_["10093"]

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(var_371_2) and arg_368_1.var_.actorSpriteComps10093 == nil then
				arg_368_1.var_.actorSpriteComps10093 = var_371_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_3 = 2

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_3 and not isNil(var_371_2) then
				if arg_368_1.var_.actorSpriteComps10093 then
					for iter_371_1, iter_371_2 in pairs(arg_368_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_371_2 then
							if arg_368_1.isInRecall_ then
								iter_371_2.color = Color.New(Mathf.Lerp(iter_371_2.color.r, arg_368_1.hightColor2.r, (arg_368_1.time_ - 0) / var_371_3), Mathf.Lerp(iter_371_2.color.g, arg_368_1.hightColor2.g, (arg_368_1.time_ - 0) / var_371_3), (Mathf.Lerp(iter_371_2.color.b, arg_368_1.hightColor2.b, (arg_368_1.time_ - 0) / var_371_3)))
							else
								local var_371_4 = Mathf.Lerp(iter_371_2.color.r, 0.5, (arg_368_1.time_ - 0) / var_371_3)

								iter_371_2.color = Color.New(var_371_4, var_371_4, var_371_4)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= 0 + var_371_3 and arg_368_1.time_ < 0 + var_371_3 + arg_371_0 and not isNil(var_371_2) and arg_368_1.var_.actorSpriteComps10093 then
				for iter_371_3, iter_371_4 in pairs(arg_368_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_371_4 then
						iter_371_4.color = arg_368_1.isInRecall_ and (arg_368_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_368_1.var_.actorSpriteComps10093 = nil
			end

			local var_371_5 = arg_368_1.actors_["10092"]

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(var_371_5) and arg_368_1.var_.actorSpriteComps10092 == nil then
				arg_368_1.var_.actorSpriteComps10092 = var_371_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_6 = 2

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_6 and not isNil(var_371_5) then
				if arg_368_1.var_.actorSpriteComps10092 then
					for iter_371_5, iter_371_6 in pairs(arg_368_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_371_6 then
							if arg_368_1.isInRecall_ then
								iter_371_6.color = Color.New(Mathf.Lerp(iter_371_6.color.r, arg_368_1.hightColor1.r, (arg_368_1.time_ - 0) / var_371_6), Mathf.Lerp(iter_371_6.color.g, arg_368_1.hightColor1.g, (arg_368_1.time_ - 0) / var_371_6), (Mathf.Lerp(iter_371_6.color.b, arg_368_1.hightColor1.b, (arg_368_1.time_ - 0) / var_371_6)))
							else
								local var_371_7 = Mathf.Lerp(iter_371_6.color.r, 1, (arg_368_1.time_ - 0) / var_371_6)

								iter_371_6.color = Color.New(var_371_7, var_371_7, var_371_7)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= 0 + var_371_6 and arg_368_1.time_ < 0 + var_371_6 + arg_371_0 and not isNil(var_371_5) and arg_368_1.var_.actorSpriteComps10092 then
				for iter_371_7, iter_371_8 in pairs(arg_368_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_371_8 then
						iter_371_8.color = arg_368_1.isInRecall_ and (arg_368_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_368_1.var_.actorSpriteComps10092 = nil
			end

			local var_371_8 = 0
			local var_371_9 = 0.15

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_8 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_10 = arg_368_1:GetWordFromCfg(413011089)
				local var_371_11 = arg_368_1:FormatText(var_371_10.content)

				arg_368_1.text_.text = var_371_11

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_13 = 6 <= 0 and var_371_9 or var_371_9 * (utf8.len(var_371_11) / 6)

				if (6 <= 0 and var_371_9 or var_371_9 * (utf8.len(var_371_11) / 6)) > 0 and var_371_9 < var_371_13 then
					arg_368_1.talkMaxDuration = var_371_13

					if var_371_13 + var_371_8 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_13 + var_371_8
					end
				end

				arg_368_1.text_.text = var_371_11
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011089", "story_v_out_413011.awb") ~= 0 then
					local var_371_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011089", "story_v_out_413011.awb") / 1000

					if var_371_14 + var_371_8 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_14 + var_371_8
					end

					if var_371_10.prefab_name ~= "" and arg_368_1.actors_[var_371_10.prefab_name] ~= nil then
						local var_371_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_10.prefab_name].transform, "story_v_out_413011", "413011089", "story_v_out_413011.awb")

						arg_368_1:RecordAudio("413011089", var_371_15)
						arg_368_1:RecordAudio("413011089", var_371_15)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_413011", "413011089", "story_v_out_413011.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_413011", "413011089", "story_v_out_413011.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_16 = math.max(var_371_9, arg_368_1.talkMaxDuration)

			if var_371_8 <= arg_368_1.time_ and arg_368_1.time_ < var_371_8 + var_371_16 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_8) / var_371_16

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_8 + var_371_16 and arg_368_1.time_ < var_371_8 + var_371_16 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
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

		arg_368_1:InitPlayNodeList()
	end,
	Play413011090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 413011090
		arg_372_1.duration_ = 2

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play413011091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["10093"]) and arg_372_1.var_.actorSpriteComps10093 == nil then
				arg_372_1.var_.actorSpriteComps10093 = arg_372_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_0 = 2

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["10093"]) then
				if arg_372_1.var_.actorSpriteComps10093 then
					for iter_375_0, iter_375_1 in pairs(arg_372_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_375_1 then
							if arg_372_1.isInRecall_ then
								iter_375_1.color = Color.New(Mathf.Lerp(iter_375_1.color.r, arg_372_1.hightColor1.r, (arg_372_1.time_ - 0) / var_375_0), Mathf.Lerp(iter_375_1.color.g, arg_372_1.hightColor1.g, (arg_372_1.time_ - 0) / var_375_0), (Mathf.Lerp(iter_375_1.color.b, arg_372_1.hightColor1.b, (arg_372_1.time_ - 0) / var_375_0)))
							else
								local var_375_1 = Mathf.Lerp(iter_375_1.color.r, 1, (arg_372_1.time_ - 0) / var_375_0)

								iter_375_1.color = Color.New(var_375_1, var_375_1, var_375_1)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["10093"]) and arg_372_1.var_.actorSpriteComps10093 then
				for iter_375_2, iter_375_3 in pairs(arg_372_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_375_3 then
						iter_375_3.color = arg_372_1.isInRecall_ and (arg_372_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_372_1.var_.actorSpriteComps10093 = nil
			end

			local var_375_2 = arg_372_1.actors_["10092"]

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(var_375_2) and arg_372_1.var_.actorSpriteComps10092 == nil then
				arg_372_1.var_.actorSpriteComps10092 = var_375_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_3 = 2

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_3 and not isNil(var_375_2) then
				if arg_372_1.var_.actorSpriteComps10092 then
					for iter_375_4, iter_375_5 in pairs(arg_372_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_375_5 then
							if arg_372_1.isInRecall_ then
								iter_375_5.color = Color.New(Mathf.Lerp(iter_375_5.color.r, arg_372_1.hightColor2.r, (arg_372_1.time_ - 0) / var_375_3), Mathf.Lerp(iter_375_5.color.g, arg_372_1.hightColor2.g, (arg_372_1.time_ - 0) / var_375_3), (Mathf.Lerp(iter_375_5.color.b, arg_372_1.hightColor2.b, (arg_372_1.time_ - 0) / var_375_3)))
							else
								local var_375_4 = Mathf.Lerp(iter_375_5.color.r, 0.5, (arg_372_1.time_ - 0) / var_375_3)

								iter_375_5.color = Color.New(var_375_4, var_375_4, var_375_4)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= 0 + var_375_3 and arg_372_1.time_ < 0 + var_375_3 + arg_375_0 and not isNil(var_375_2) and arg_372_1.var_.actorSpriteComps10092 then
				for iter_375_6, iter_375_7 in pairs(arg_372_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_375_7 then
						iter_375_7.color = arg_372_1.isInRecall_ and (arg_372_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_372_1.var_.actorSpriteComps10092 = nil
			end

			local var_375_5 = 0
			local var_375_6 = 0.1

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_5 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_7 = arg_372_1:GetWordFromCfg(413011090)
				local var_375_8 = arg_372_1:FormatText(var_375_7.content)

				arg_372_1.text_.text = var_375_8

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_10 = 4 <= 0 and var_375_6 or var_375_6 * (utf8.len(var_375_8) / 4)

				if (4 <= 0 and var_375_6 or var_375_6 * (utf8.len(var_375_8) / 4)) > 0 and var_375_6 < var_375_10 then
					arg_372_1.talkMaxDuration = var_375_10

					if var_375_10 + var_375_5 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_10 + var_375_5
					end
				end

				arg_372_1.text_.text = var_375_8
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011090", "story_v_out_413011.awb") ~= 0 then
					local var_375_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011090", "story_v_out_413011.awb") / 1000

					if var_375_11 + var_375_5 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_11 + var_375_5
					end

					if var_375_7.prefab_name ~= "" and arg_372_1.actors_[var_375_7.prefab_name] ~= nil then
						local var_375_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_7.prefab_name].transform, "story_v_out_413011", "413011090", "story_v_out_413011.awb")

						arg_372_1:RecordAudio("413011090", var_375_12)
						arg_372_1:RecordAudio("413011090", var_375_12)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_413011", "413011090", "story_v_out_413011.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_413011", "413011090", "story_v_out_413011.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_13 = math.max(var_375_6, arg_372_1.talkMaxDuration)

			if var_375_5 <= arg_372_1.time_ and arg_372_1.time_ < var_375_5 + var_375_13 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_5) / var_375_13

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_5 + var_375_13 and arg_372_1.time_ < var_375_5 + var_375_13 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play413011091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 413011091
		arg_376_1.duration_ = 8.07

		local var_376_0 = {
			zh = 5.566,
			ja = 8.066
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play413011092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["10093"]) and arg_376_1.var_.actorSpriteComps10093 == nil then
				arg_376_1.var_.actorSpriteComps10093 = arg_376_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_0 = 2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["10093"]) then
				if arg_376_1.var_.actorSpriteComps10093 then
					for iter_379_0, iter_379_1 in pairs(arg_376_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_379_1 then
							if arg_376_1.isInRecall_ then
								iter_379_1.color = Color.New(Mathf.Lerp(iter_379_1.color.r, arg_376_1.hightColor2.r, (arg_376_1.time_ - 0) / var_379_0), Mathf.Lerp(iter_379_1.color.g, arg_376_1.hightColor2.g, (arg_376_1.time_ - 0) / var_379_0), (Mathf.Lerp(iter_379_1.color.b, arg_376_1.hightColor2.b, (arg_376_1.time_ - 0) / var_379_0)))
							else
								local var_379_1 = Mathf.Lerp(iter_379_1.color.r, 0.5, (arg_376_1.time_ - 0) / var_379_0)

								iter_379_1.color = Color.New(var_379_1, var_379_1, var_379_1)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["10093"]) and arg_376_1.var_.actorSpriteComps10093 then
				for iter_379_2, iter_379_3 in pairs(arg_376_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_379_3 then
						iter_379_3.color = arg_376_1.isInRecall_ and (arg_376_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_376_1.var_.actorSpriteComps10093 = nil
			end

			local var_379_2 = arg_376_1.actors_["10092"]

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(var_379_2) and arg_376_1.var_.actorSpriteComps10092 == nil then
				arg_376_1.var_.actorSpriteComps10092 = var_379_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_3 = 2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_3 and not isNil(var_379_2) then
				if arg_376_1.var_.actorSpriteComps10092 then
					for iter_379_4, iter_379_5 in pairs(arg_376_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_379_5 then
							if arg_376_1.isInRecall_ then
								iter_379_5.color = Color.New(Mathf.Lerp(iter_379_5.color.r, arg_376_1.hightColor1.r, (arg_376_1.time_ - 0) / var_379_3), Mathf.Lerp(iter_379_5.color.g, arg_376_1.hightColor1.g, (arg_376_1.time_ - 0) / var_379_3), (Mathf.Lerp(iter_379_5.color.b, arg_376_1.hightColor1.b, (arg_376_1.time_ - 0) / var_379_3)))
							else
								local var_379_4 = Mathf.Lerp(iter_379_5.color.r, 1, (arg_376_1.time_ - 0) / var_379_3)

								iter_379_5.color = Color.New(var_379_4, var_379_4, var_379_4)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= 0 + var_379_3 and arg_376_1.time_ < 0 + var_379_3 + arg_379_0 and not isNil(var_379_2) and arg_376_1.var_.actorSpriteComps10092 then
				for iter_379_6, iter_379_7 in pairs(arg_376_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_379_7 then
						iter_379_7.color = arg_376_1.isInRecall_ and (arg_376_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_376_1.var_.actorSpriteComps10092 = nil
			end

			local var_379_5 = 0
			local var_379_6 = 0.775

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_5 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_7 = arg_376_1:GetWordFromCfg(413011091)
				local var_379_8 = arg_376_1:FormatText(var_379_7.content)

				arg_376_1.text_.text = var_379_8

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_10 = 31 <= 0 and var_379_6 or var_379_6 * (utf8.len(var_379_8) / 31)

				if (31 <= 0 and var_379_6 or var_379_6 * (utf8.len(var_379_8) / 31)) > 0 and var_379_6 < var_379_10 then
					arg_376_1.talkMaxDuration = var_379_10

					if var_379_10 + var_379_5 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_10 + var_379_5
					end
				end

				arg_376_1.text_.text = var_379_8
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011091", "story_v_out_413011.awb") ~= 0 then
					local var_379_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011091", "story_v_out_413011.awb") / 1000

					if var_379_11 + var_379_5 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_11 + var_379_5
					end

					if var_379_7.prefab_name ~= "" and arg_376_1.actors_[var_379_7.prefab_name] ~= nil then
						local var_379_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_7.prefab_name].transform, "story_v_out_413011", "413011091", "story_v_out_413011.awb")

						arg_376_1:RecordAudio("413011091", var_379_12)
						arg_376_1:RecordAudio("413011091", var_379_12)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_413011", "413011091", "story_v_out_413011.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_413011", "413011091", "story_v_out_413011.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_13 = math.max(var_379_6, arg_376_1.talkMaxDuration)

			if var_379_5 <= arg_376_1.time_ and arg_376_1.time_ < var_379_5 + var_379_13 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_5) / var_379_13

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_5 + var_379_13 and arg_376_1.time_ < var_379_5 + var_379_13 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play413011092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 413011092
		arg_380_1.duration_ = 12.07

		local var_380_0 = {
			zh = 6.9,
			ja = 12.066
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play413011093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.775

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_1 = arg_380_1:GetWordFromCfg(413011092)
				local var_383_2 = arg_380_1:FormatText(var_383_1.content)

				arg_380_1.text_.text = var_383_2

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 31 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 31)

				if (31 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 31)) > 0 and var_383_0 < var_383_4 then
					arg_380_1.talkMaxDuration = var_383_4

					if var_383_4 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_4 + 0
					end
				end

				arg_380_1.text_.text = var_383_2
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011092", "story_v_out_413011.awb") ~= 0 then
					local var_383_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011092", "story_v_out_413011.awb") / 1000

					if var_383_5 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + 0
					end

					if var_383_1.prefab_name ~= "" and arg_380_1.actors_[var_383_1.prefab_name] ~= nil then
						local var_383_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_1.prefab_name].transform, "story_v_out_413011", "413011092", "story_v_out_413011.awb")

						arg_380_1:RecordAudio("413011092", var_383_6)
						arg_380_1:RecordAudio("413011092", var_383_6)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_413011", "413011092", "story_v_out_413011.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_413011", "413011092", "story_v_out_413011.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_7 and arg_380_1.time_ < 0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play413011093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 413011093
		arg_384_1.duration_ = 10

		local var_384_0 = {
			zh = 5.6,
			ja = 10
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play413011094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.65

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_1 = arg_384_1:GetWordFromCfg(413011093)
				local var_387_2 = arg_384_1:FormatText(var_387_1.content)

				arg_384_1.text_.text = var_387_2

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_4 = 26 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 26)

				if (26 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 26)) > 0 and var_387_0 < var_387_4 then
					arg_384_1.talkMaxDuration = var_387_4

					if var_387_4 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_4 + 0
					end
				end

				arg_384_1.text_.text = var_387_2
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011093", "story_v_out_413011.awb") ~= 0 then
					local var_387_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011093", "story_v_out_413011.awb") / 1000

					if var_387_5 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + 0
					end

					if var_387_1.prefab_name ~= "" and arg_384_1.actors_[var_387_1.prefab_name] ~= nil then
						local var_387_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_1.prefab_name].transform, "story_v_out_413011", "413011093", "story_v_out_413011.awb")

						arg_384_1:RecordAudio("413011093", var_387_6)
						arg_384_1:RecordAudio("413011093", var_387_6)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_413011", "413011093", "story_v_out_413011.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_413011", "413011093", "story_v_out_413011.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_7 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_7 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_7

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_7 and arg_384_1.time_ < 0 + var_387_7 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play413011094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 413011094
		arg_388_1.duration_ = 3.1

		local var_388_0 = {
			zh = 1.999999999999,
			ja = 3.1
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play413011095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos10093 = arg_388_1.actors_["10093"].transform.localPosition
				arg_388_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("10093", 4)

				for iter_391_0 = 0, arg_388_1.actors_["10093"].transform.childCount - 1 do
					local var_391_0 = arg_388_1.actors_["10093"].transform:GetChild(iter_391_0)

					if var_391_0.name == "" or not string.find(var_391_0.name, "split") then
						var_391_0.gameObject:SetActive(true)
					else
						var_391_0.gameObject:SetActive(false)
					end
				end
			end

			local var_391_1 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_1 then
				arg_388_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_388_1.time_ - 0) / var_391_1)
			end

			if arg_388_1.time_ >= 0 + var_391_1 and arg_388_1.time_ < 0 + var_391_1 + arg_391_0 then
				arg_388_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_391_2 = arg_388_1.actors_["10093"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.actorSpriteComps10093 == nil then
				arg_388_1.var_.actorSpriteComps10093 = var_391_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_3 = 2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_3 and not isNil(var_391_2) then
				if arg_388_1.var_.actorSpriteComps10093 then
					for iter_391_1, iter_391_2 in pairs(arg_388_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_391_2 then
							if arg_388_1.isInRecall_ then
								iter_391_2.color = Color.New(Mathf.Lerp(iter_391_2.color.r, arg_388_1.hightColor1.r, (arg_388_1.time_ - 0) / var_391_3), Mathf.Lerp(iter_391_2.color.g, arg_388_1.hightColor1.g, (arg_388_1.time_ - 0) / var_391_3), (Mathf.Lerp(iter_391_2.color.b, arg_388_1.hightColor1.b, (arg_388_1.time_ - 0) / var_391_3)))
							else
								local var_391_4 = Mathf.Lerp(iter_391_2.color.r, 1, (arg_388_1.time_ - 0) / var_391_3)

								iter_391_2.color = Color.New(var_391_4, var_391_4, var_391_4)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_3 and arg_388_1.time_ < 0 + var_391_3 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.actorSpriteComps10093 then
				for iter_391_3, iter_391_4 in pairs(arg_388_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_391_4 then
						iter_391_4.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_388_1.var_.actorSpriteComps10093 = nil
			end

			local var_391_5 = arg_388_1.actors_["10092"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_5) and arg_388_1.var_.actorSpriteComps10092 == nil then
				arg_388_1.var_.actorSpriteComps10092 = var_391_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_6 = 2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_6 and not isNil(var_391_5) then
				if arg_388_1.var_.actorSpriteComps10092 then
					for iter_391_5, iter_391_6 in pairs(arg_388_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_391_6 then
							if arg_388_1.isInRecall_ then
								iter_391_6.color = Color.New(Mathf.Lerp(iter_391_6.color.r, arg_388_1.hightColor2.r, (arg_388_1.time_ - 0) / var_391_6), Mathf.Lerp(iter_391_6.color.g, arg_388_1.hightColor2.g, (arg_388_1.time_ - 0) / var_391_6), (Mathf.Lerp(iter_391_6.color.b, arg_388_1.hightColor2.b, (arg_388_1.time_ - 0) / var_391_6)))
							else
								local var_391_7 = Mathf.Lerp(iter_391_6.color.r, 0.5, (arg_388_1.time_ - 0) / var_391_6)

								iter_391_6.color = Color.New(var_391_7, var_391_7, var_391_7)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_6 and arg_388_1.time_ < 0 + var_391_6 + arg_391_0 and not isNil(var_391_5) and arg_388_1.var_.actorSpriteComps10092 then
				for iter_391_7, iter_391_8 in pairs(arg_388_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_391_8 then
						iter_391_8.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_388_1.var_.actorSpriteComps10092 = nil
			end

			local var_391_8 = 0
			local var_391_9 = 0.225

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_10 = arg_388_1:GetWordFromCfg(413011094)
				local var_391_11 = arg_388_1:FormatText(var_391_10.content)

				arg_388_1.text_.text = var_391_11

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_13 = 9 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_11) / 9)

				if (9 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_11) / 9)) > 0 and var_391_9 < var_391_13 then
					arg_388_1.talkMaxDuration = var_391_13

					if var_391_13 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_13 + var_391_8
					end
				end

				arg_388_1.text_.text = var_391_11
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011094", "story_v_out_413011.awb") ~= 0 then
					local var_391_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011094", "story_v_out_413011.awb") / 1000

					if var_391_14 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_14 + var_391_8
					end

					if var_391_10.prefab_name ~= "" and arg_388_1.actors_[var_391_10.prefab_name] ~= nil then
						local var_391_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_10.prefab_name].transform, "story_v_out_413011", "413011094", "story_v_out_413011.awb")

						arg_388_1:RecordAudio("413011094", var_391_15)
						arg_388_1:RecordAudio("413011094", var_391_15)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_413011", "413011094", "story_v_out_413011.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_413011", "413011094", "story_v_out_413011.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_16 = math.max(var_391_9, arg_388_1.talkMaxDuration)

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_16 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_8) / var_391_16

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_8 + var_391_16 and arg_388_1.time_ < var_391_8 + var_391_16 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
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

		arg_388_1:InitPlayNodeList()
	end,
	Play413011095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 413011095
		arg_392_1.duration_ = 8.07

		local var_392_0 = {
			zh = 5.8,
			ja = 8.066
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play413011096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["10093"]) and arg_392_1.var_.actorSpriteComps10093 == nil then
				arg_392_1.var_.actorSpriteComps10093 = arg_392_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_0 = 2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["10093"]) then
				if arg_392_1.var_.actorSpriteComps10093 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_395_1 then
							if arg_392_1.isInRecall_ then
								iter_395_1.color = Color.New(Mathf.Lerp(iter_395_1.color.r, arg_392_1.hightColor2.r, (arg_392_1.time_ - 0) / var_395_0), Mathf.Lerp(iter_395_1.color.g, arg_392_1.hightColor2.g, (arg_392_1.time_ - 0) / var_395_0), (Mathf.Lerp(iter_395_1.color.b, arg_392_1.hightColor2.b, (arg_392_1.time_ - 0) / var_395_0)))
							else
								local var_395_1 = Mathf.Lerp(iter_395_1.color.r, 0.5, (arg_392_1.time_ - 0) / var_395_0)

								iter_395_1.color = Color.New(var_395_1, var_395_1, var_395_1)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["10093"]) and arg_392_1.var_.actorSpriteComps10093 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_395_3 then
						iter_395_3.color = arg_392_1.isInRecall_ and (arg_392_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_392_1.var_.actorSpriteComps10093 = nil
			end

			local var_395_2 = arg_392_1.actors_["10092"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_2) and arg_392_1.var_.actorSpriteComps10092 == nil then
				arg_392_1.var_.actorSpriteComps10092 = var_395_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_3 = 2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_3 and not isNil(var_395_2) then
				if arg_392_1.var_.actorSpriteComps10092 then
					for iter_395_4, iter_395_5 in pairs(arg_392_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_395_5 then
							if arg_392_1.isInRecall_ then
								iter_395_5.color = Color.New(Mathf.Lerp(iter_395_5.color.r, arg_392_1.hightColor1.r, (arg_392_1.time_ - 0) / var_395_3), Mathf.Lerp(iter_395_5.color.g, arg_392_1.hightColor1.g, (arg_392_1.time_ - 0) / var_395_3), (Mathf.Lerp(iter_395_5.color.b, arg_392_1.hightColor1.b, (arg_392_1.time_ - 0) / var_395_3)))
							else
								local var_395_4 = Mathf.Lerp(iter_395_5.color.r, 1, (arg_392_1.time_ - 0) / var_395_3)

								iter_395_5.color = Color.New(var_395_4, var_395_4, var_395_4)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= 0 + var_395_3 and arg_392_1.time_ < 0 + var_395_3 + arg_395_0 and not isNil(var_395_2) and arg_392_1.var_.actorSpriteComps10092 then
				for iter_395_6, iter_395_7 in pairs(arg_392_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_395_7 then
						iter_395_7.color = arg_392_1.isInRecall_ and (arg_392_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_392_1.var_.actorSpriteComps10092 = nil
			end

			local var_395_5 = arg_392_1.actors_["10092"].transform

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos10092 = var_395_5.localPosition
				var_395_5.localScale = Vector3.New(1, 1, 1)

				arg_392_1:CheckSpriteTmpPos("10092", 2)

				for iter_395_8 = 0, var_395_5.childCount - 1 do
					local var_395_6 = var_395_5:GetChild(iter_395_8)

					if var_395_6.name == "split_6" or not string.find(var_395_6.name, "split") then
						var_395_6.gameObject:SetActive(true)
					else
						var_395_6.gameObject:SetActive(false)
					end
				end
			end

			local var_395_7 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_7 then
				var_395_5.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_392_1.time_ - 0) / var_395_7)
			end

			if arg_392_1.time_ >= 0 + var_395_7 and arg_392_1.time_ < 0 + var_395_7 + arg_395_0 then
				var_395_5.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_395_8 = 0
			local var_395_9 = 0.725

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_8 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_10 = arg_392_1:GetWordFromCfg(413011095)
				local var_395_11 = arg_392_1:FormatText(var_395_10.content)

				arg_392_1.text_.text = var_395_11

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_13 = 29 <= 0 and var_395_9 or var_395_9 * (utf8.len(var_395_11) / 29)

				if (29 <= 0 and var_395_9 or var_395_9 * (utf8.len(var_395_11) / 29)) > 0 and var_395_9 < var_395_13 then
					arg_392_1.talkMaxDuration = var_395_13

					if var_395_13 + var_395_8 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_13 + var_395_8
					end
				end

				arg_392_1.text_.text = var_395_11
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011095", "story_v_out_413011.awb") ~= 0 then
					local var_395_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011095", "story_v_out_413011.awb") / 1000

					if var_395_14 + var_395_8 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_14 + var_395_8
					end

					if var_395_10.prefab_name ~= "" and arg_392_1.actors_[var_395_10.prefab_name] ~= nil then
						local var_395_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_10.prefab_name].transform, "story_v_out_413011", "413011095", "story_v_out_413011.awb")

						arg_392_1:RecordAudio("413011095", var_395_15)
						arg_392_1:RecordAudio("413011095", var_395_15)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_413011", "413011095", "story_v_out_413011.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_413011", "413011095", "story_v_out_413011.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_16 = math.max(var_395_9, arg_392_1.talkMaxDuration)

			if var_395_8 <= arg_392_1.time_ and arg_392_1.time_ < var_395_8 + var_395_16 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_8) / var_395_16

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_8 + var_395_16 and arg_392_1.time_ < var_395_8 + var_395_16 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
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

		arg_392_1:InitPlayNodeList()
	end,
	Play413011096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 413011096
		arg_396_1.duration_ = 4

		local var_396_0 = {
			zh = 2.8,
			ja = 4
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
				arg_396_0:Play413011097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0.35

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_1 = arg_396_1:GetWordFromCfg(413011096)
				local var_399_2 = arg_396_1:FormatText(var_399_1.content)

				arg_396_1.text_.text = var_399_2

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_4 = 14 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_2) / 14)

				if (14 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_2) / 14)) > 0 and var_399_0 < var_399_4 then
					arg_396_1.talkMaxDuration = var_399_4

					if var_399_4 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_4 + 0
					end
				end

				arg_396_1.text_.text = var_399_2
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011096", "story_v_out_413011.awb") ~= 0 then
					local var_399_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011096", "story_v_out_413011.awb") / 1000

					if var_399_5 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_5 + 0
					end

					if var_399_1.prefab_name ~= "" and arg_396_1.actors_[var_399_1.prefab_name] ~= nil then
						local var_399_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_1.prefab_name].transform, "story_v_out_413011", "413011096", "story_v_out_413011.awb")

						arg_396_1:RecordAudio("413011096", var_399_6)
						arg_396_1:RecordAudio("413011096", var_399_6)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_413011", "413011096", "story_v_out_413011.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_413011", "413011096", "story_v_out_413011.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_7 = math.max(var_399_0, arg_396_1.talkMaxDuration)

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_7 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - 0) / var_399_7

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= 0 + var_399_7 and arg_396_1.time_ < 0 + var_399_7 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play413011097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 413011097
		arg_400_1.duration_ = 7.13

		local var_400_0 = {
			zh = 4.033,
			ja = 7.133
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
				arg_400_0:Play413011098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(arg_400_1.actors_["10093"]) and arg_400_1.var_.actorSpriteComps10093 == nil then
				arg_400_1.var_.actorSpriteComps10093 = arg_400_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_0 = 2

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 and not isNil(arg_400_1.actors_["10093"]) then
				if arg_400_1.var_.actorSpriteComps10093 then
					for iter_403_0, iter_403_1 in pairs(arg_400_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_403_1 then
							if arg_400_1.isInRecall_ then
								iter_403_1.color = Color.New(Mathf.Lerp(iter_403_1.color.r, arg_400_1.hightColor1.r, (arg_400_1.time_ - 0) / var_403_0), Mathf.Lerp(iter_403_1.color.g, arg_400_1.hightColor1.g, (arg_400_1.time_ - 0) / var_403_0), (Mathf.Lerp(iter_403_1.color.b, arg_400_1.hightColor1.b, (arg_400_1.time_ - 0) / var_403_0)))
							else
								local var_403_1 = Mathf.Lerp(iter_403_1.color.r, 1, (arg_400_1.time_ - 0) / var_403_0)

								iter_403_1.color = Color.New(var_403_1, var_403_1, var_403_1)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 and not isNil(arg_400_1.actors_["10093"]) and arg_400_1.var_.actorSpriteComps10093 then
				for iter_403_2, iter_403_3 in pairs(arg_400_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_403_3 then
						iter_403_3.color = arg_400_1.isInRecall_ and (arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_400_1.var_.actorSpriteComps10093 = nil
			end

			local var_403_2 = arg_400_1.actors_["10092"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_2) and arg_400_1.var_.actorSpriteComps10092 == nil then
				arg_400_1.var_.actorSpriteComps10092 = var_403_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_3 = 2

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_3 and not isNil(var_403_2) then
				if arg_400_1.var_.actorSpriteComps10092 then
					for iter_403_4, iter_403_5 in pairs(arg_400_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_403_5 then
							if arg_400_1.isInRecall_ then
								iter_403_5.color = Color.New(Mathf.Lerp(iter_403_5.color.r, arg_400_1.hightColor2.r, (arg_400_1.time_ - 0) / var_403_3), Mathf.Lerp(iter_403_5.color.g, arg_400_1.hightColor2.g, (arg_400_1.time_ - 0) / var_403_3), (Mathf.Lerp(iter_403_5.color.b, arg_400_1.hightColor2.b, (arg_400_1.time_ - 0) / var_403_3)))
							else
								local var_403_4 = Mathf.Lerp(iter_403_5.color.r, 0.5, (arg_400_1.time_ - 0) / var_403_3)

								iter_403_5.color = Color.New(var_403_4, var_403_4, var_403_4)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= 0 + var_403_3 and arg_400_1.time_ < 0 + var_403_3 + arg_403_0 and not isNil(var_403_2) and arg_400_1.var_.actorSpriteComps10092 then
				for iter_403_6, iter_403_7 in pairs(arg_400_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_403_7 then
						iter_403_7.color = arg_400_1.isInRecall_ and (arg_400_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_400_1.var_.actorSpriteComps10092 = nil
			end

			local var_403_5 = 0
			local var_403_6 = 0.35

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_7 = arg_400_1:GetWordFromCfg(413011097)
				local var_403_8 = arg_400_1:FormatText(var_403_7.content)

				arg_400_1.text_.text = var_403_8

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_10 = 14 <= 0 and var_403_6 or var_403_6 * (utf8.len(var_403_8) / 14)

				if (14 <= 0 and var_403_6 or var_403_6 * (utf8.len(var_403_8) / 14)) > 0 and var_403_6 < var_403_10 then
					arg_400_1.talkMaxDuration = var_403_10

					if var_403_10 + var_403_5 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_10 + var_403_5
					end
				end

				arg_400_1.text_.text = var_403_8
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011097", "story_v_out_413011.awb") ~= 0 then
					local var_403_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011097", "story_v_out_413011.awb") / 1000

					if var_403_11 + var_403_5 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_11 + var_403_5
					end

					if var_403_7.prefab_name ~= "" and arg_400_1.actors_[var_403_7.prefab_name] ~= nil then
						local var_403_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_7.prefab_name].transform, "story_v_out_413011", "413011097", "story_v_out_413011.awb")

						arg_400_1:RecordAudio("413011097", var_403_12)
						arg_400_1:RecordAudio("413011097", var_403_12)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_413011", "413011097", "story_v_out_413011.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_413011", "413011097", "story_v_out_413011.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_13 = math.max(var_403_6, arg_400_1.talkMaxDuration)

			if var_403_5 <= arg_400_1.time_ and arg_400_1.time_ < var_403_5 + var_403_13 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_5) / var_403_13

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_5 + var_403_13 and arg_400_1.time_ < var_403_5 + var_403_13 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play413011098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 413011098
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play413011099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos10092 = arg_404_1.actors_["10092"].transform.localPosition
				arg_404_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_404_1:CheckSpriteTmpPos("10092", 0)

				for iter_407_0 = 0, arg_404_1.actors_["10092"].transform.childCount - 1 do
					local var_407_0 = arg_404_1.actors_["10092"].transform:GetChild(iter_407_0)

					if var_407_0.name == "" or not string.find(var_407_0.name, "split") then
						var_407_0.gameObject:SetActive(true)
					else
						var_407_0.gameObject:SetActive(false)
					end
				end
			end

			local var_407_1 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_1 then
				arg_404_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_404_1.time_ - 0) / var_407_1)
			end

			if arg_404_1.time_ >= 0 + var_407_1 and arg_404_1.time_ < 0 + var_407_1 + arg_407_0 then
				arg_404_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_407_2 = arg_404_1.actors_["10093"].transform

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos10093 = var_407_2.localPosition
				var_407_2.localScale = Vector3.New(1, 1, 1)

				arg_404_1:CheckSpriteTmpPos("10093", 0)

				for iter_407_1 = 0, var_407_2.childCount - 1 do
					local var_407_3 = var_407_2:GetChild(iter_407_1)

					if var_407_3.name == "" or not string.find(var_407_3.name, "split") then
						var_407_3.gameObject:SetActive(true)
					else
						var_407_3.gameObject:SetActive(false)
					end
				end
			end

			local var_407_4 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_4 then
				var_407_2.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos10093, Vector3.New(-1500, -350, -180), (arg_404_1.time_ - 0) / var_407_4)
			end

			if arg_404_1.time_ >= 0 + var_407_4 and arg_404_1.time_ < 0 + var_407_4 + arg_407_0 then
				var_407_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_407_5 = arg_404_1.actors_["10092"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_5) and arg_404_1.var_.actorSpriteComps10092 == nil then
				arg_404_1.var_.actorSpriteComps10092 = var_407_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_6 = 2

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_6 and not isNil(var_407_5) then
				if arg_404_1.var_.actorSpriteComps10092 then
					for iter_407_2, iter_407_3 in pairs(arg_404_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_407_3 then
							if arg_404_1.isInRecall_ then
								iter_407_3.color = Color.New(Mathf.Lerp(iter_407_3.color.r, arg_404_1.hightColor2.r, (arg_404_1.time_ - 0) / var_407_6), Mathf.Lerp(iter_407_3.color.g, arg_404_1.hightColor2.g, (arg_404_1.time_ - 0) / var_407_6), (Mathf.Lerp(iter_407_3.color.b, arg_404_1.hightColor2.b, (arg_404_1.time_ - 0) / var_407_6)))
							else
								local var_407_7 = Mathf.Lerp(iter_407_3.color.r, 0.5, (arg_404_1.time_ - 0) / var_407_6)

								iter_407_3.color = Color.New(var_407_7, var_407_7, var_407_7)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= 0 + var_407_6 and arg_404_1.time_ < 0 + var_407_6 + arg_407_0 and not isNil(var_407_5) and arg_404_1.var_.actorSpriteComps10092 then
				for iter_407_4, iter_407_5 in pairs(arg_404_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_407_5 then
						iter_407_5.color = arg_404_1.isInRecall_ and (arg_404_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_404_1.var_.actorSpriteComps10092 = nil
			end

			local var_407_8 = arg_404_1.actors_["10093"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_8) and arg_404_1.var_.actorSpriteComps10093 == nil then
				arg_404_1.var_.actorSpriteComps10093 = var_407_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_9 = 2

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_9 and not isNil(var_407_8) then
				if arg_404_1.var_.actorSpriteComps10093 then
					for iter_407_6, iter_407_7 in pairs(arg_404_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_407_7 then
							if arg_404_1.isInRecall_ then
								iter_407_7.color = Color.New(Mathf.Lerp(iter_407_7.color.r, arg_404_1.hightColor2.r, (arg_404_1.time_ - 0) / var_407_9), Mathf.Lerp(iter_407_7.color.g, arg_404_1.hightColor2.g, (arg_404_1.time_ - 0) / var_407_9), (Mathf.Lerp(iter_407_7.color.b, arg_404_1.hightColor2.b, (arg_404_1.time_ - 0) / var_407_9)))
							else
								local var_407_10 = Mathf.Lerp(iter_407_7.color.r, 0.5, (arg_404_1.time_ - 0) / var_407_9)

								iter_407_7.color = Color.New(var_407_10, var_407_10, var_407_10)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= 0 + var_407_9 and arg_404_1.time_ < 0 + var_407_9 + arg_407_0 and not isNil(var_407_8) and arg_404_1.var_.actorSpriteComps10093 then
				for iter_407_8, iter_407_9 in pairs(arg_404_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_407_9 then
						iter_407_9.color = arg_404_1.isInRecall_ and (arg_404_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_404_1.var_.actorSpriteComps10093 = nil
			end

			local var_407_11 = 0
			local var_407_12 = 1

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_11 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_13 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(413011098).content)

				arg_404_1.text_.text = var_407_13

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_15 = 40 <= 0 and var_407_12 or var_407_12 * (utf8.len(var_407_13) / 40)

				if (40 <= 0 and var_407_12 or var_407_12 * (utf8.len(var_407_13) / 40)) > 0 and var_407_12 < var_407_15 then
					arg_404_1.talkMaxDuration = var_407_15

					if var_407_15 + var_407_11 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_15 + var_407_11
					end
				end

				arg_404_1.text_.text = var_407_13
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_16 = math.max(var_407_12, arg_404_1.talkMaxDuration)

			if var_407_11 <= arg_404_1.time_ and arg_404_1.time_ < var_407_11 + var_407_16 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_11) / var_407_16

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_11 + var_407_16 and arg_404_1.time_ < var_407_11 + var_407_16 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
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

		arg_404_1:InitPlayNodeList()
	end,
	Play413011099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 413011099
		arg_408_1.duration_ = 17.13

		local var_408_0 = {
			zh = 9.8,
			ja = 17.133
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
				arg_408_0:Play413011100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos10092 = arg_408_1.actors_["10092"].transform.localPosition
				arg_408_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_408_1:CheckSpriteTmpPos("10092", 2)

				for iter_411_0 = 0, arg_408_1.actors_["10092"].transform.childCount - 1 do
					local var_411_0 = arg_408_1.actors_["10092"].transform:GetChild(iter_411_0)

					if var_411_0.name == "split_2" or not string.find(var_411_0.name, "split") then
						var_411_0.gameObject:SetActive(true)
					else
						var_411_0.gameObject:SetActive(false)
					end
				end
			end

			local var_411_1 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_1 then
				arg_408_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_408_1.time_ - 0) / var_411_1)
			end

			if arg_408_1.time_ >= 0 + var_411_1 and arg_408_1.time_ < 0 + var_411_1 + arg_411_0 then
				arg_408_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_411_2 = arg_408_1.actors_["10092"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_2) and arg_408_1.var_.actorSpriteComps10092 == nil then
				arg_408_1.var_.actorSpriteComps10092 = var_411_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_411_3 = 2

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_3 and not isNil(var_411_2) then
				if arg_408_1.var_.actorSpriteComps10092 then
					for iter_411_1, iter_411_2 in pairs(arg_408_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_411_2 then
							if arg_408_1.isInRecall_ then
								iter_411_2.color = Color.New(Mathf.Lerp(iter_411_2.color.r, arg_408_1.hightColor1.r, (arg_408_1.time_ - 0) / var_411_3), Mathf.Lerp(iter_411_2.color.g, arg_408_1.hightColor1.g, (arg_408_1.time_ - 0) / var_411_3), (Mathf.Lerp(iter_411_2.color.b, arg_408_1.hightColor1.b, (arg_408_1.time_ - 0) / var_411_3)))
							else
								local var_411_4 = Mathf.Lerp(iter_411_2.color.r, 1, (arg_408_1.time_ - 0) / var_411_3)

								iter_411_2.color = Color.New(var_411_4, var_411_4, var_411_4)
							end
						end
					end
				end
			end

			if arg_408_1.time_ >= 0 + var_411_3 and arg_408_1.time_ < 0 + var_411_3 + arg_411_0 and not isNil(var_411_2) and arg_408_1.var_.actorSpriteComps10092 then
				for iter_411_3, iter_411_4 in pairs(arg_408_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_411_4 then
						iter_411_4.color = arg_408_1.isInRecall_ and (arg_408_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_408_1.var_.actorSpriteComps10092 = nil
			end

			local var_411_5 = 0
			local var_411_6 = 1.075

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_5 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_7 = arg_408_1:GetWordFromCfg(413011099)
				local var_411_8 = arg_408_1:FormatText(var_411_7.content)

				arg_408_1.text_.text = var_411_8

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_10 = 43 <= 0 and var_411_6 or var_411_6 * (utf8.len(var_411_8) / 43)

				if (43 <= 0 and var_411_6 or var_411_6 * (utf8.len(var_411_8) / 43)) > 0 and var_411_6 < var_411_10 then
					arg_408_1.talkMaxDuration = var_411_10

					if var_411_10 + var_411_5 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_10 + var_411_5
					end
				end

				arg_408_1.text_.text = var_411_8
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011099", "story_v_out_413011.awb") ~= 0 then
					local var_411_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011099", "story_v_out_413011.awb") / 1000

					if var_411_11 + var_411_5 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_11 + var_411_5
					end

					if var_411_7.prefab_name ~= "" and arg_408_1.actors_[var_411_7.prefab_name] ~= nil then
						local var_411_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_7.prefab_name].transform, "story_v_out_413011", "413011099", "story_v_out_413011.awb")

						arg_408_1:RecordAudio("413011099", var_411_12)
						arg_408_1:RecordAudio("413011099", var_411_12)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_413011", "413011099", "story_v_out_413011.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_413011", "413011099", "story_v_out_413011.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_13 = math.max(var_411_6, arg_408_1.talkMaxDuration)

			if var_411_5 <= arg_408_1.time_ and arg_408_1.time_ < var_411_5 + var_411_13 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_5) / var_411_13

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_5 + var_411_13 and arg_408_1.time_ < var_411_5 + var_411_13 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
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

		arg_408_1:InitPlayNodeList()
	end,
	Play413011100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 413011100
		arg_412_1.duration_ = 8.43

		local var_412_0 = {
			zh = 5.2,
			ja = 8.433
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
				arg_412_0:Play413011101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos10093 = arg_412_1.actors_["10093"].transform.localPosition
				arg_412_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_412_1:CheckSpriteTmpPos("10093", 4)

				for iter_415_0 = 0, arg_412_1.actors_["10093"].transform.childCount - 1 do
					local var_415_0 = arg_412_1.actors_["10093"].transform:GetChild(iter_415_0)

					if var_415_0.name == "" or not string.find(var_415_0.name, "split") then
						var_415_0.gameObject:SetActive(true)
					else
						var_415_0.gameObject:SetActive(false)
					end
				end
			end

			local var_415_1 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_1 then
				arg_412_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_412_1.time_ - 0) / var_415_1)
			end

			if arg_412_1.time_ >= 0 + var_415_1 and arg_412_1.time_ < 0 + var_415_1 + arg_415_0 then
				arg_412_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_415_2 = arg_412_1.actors_["10093"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.actorSpriteComps10093 == nil then
				arg_412_1.var_.actorSpriteComps10093 = var_415_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_3 = 2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_3 and not isNil(var_415_2) then
				if arg_412_1.var_.actorSpriteComps10093 then
					for iter_415_1, iter_415_2 in pairs(arg_412_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_415_2 then
							if arg_412_1.isInRecall_ then
								iter_415_2.color = Color.New(Mathf.Lerp(iter_415_2.color.r, arg_412_1.hightColor1.r, (arg_412_1.time_ - 0) / var_415_3), Mathf.Lerp(iter_415_2.color.g, arg_412_1.hightColor1.g, (arg_412_1.time_ - 0) / var_415_3), (Mathf.Lerp(iter_415_2.color.b, arg_412_1.hightColor1.b, (arg_412_1.time_ - 0) / var_415_3)))
							else
								local var_415_4 = Mathf.Lerp(iter_415_2.color.r, 1, (arg_412_1.time_ - 0) / var_415_3)

								iter_415_2.color = Color.New(var_415_4, var_415_4, var_415_4)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_3 and arg_412_1.time_ < 0 + var_415_3 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.actorSpriteComps10093 then
				for iter_415_3, iter_415_4 in pairs(arg_412_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_415_4 then
						iter_415_4.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_412_1.var_.actorSpriteComps10093 = nil
			end

			local var_415_5 = arg_412_1.actors_["10092"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_5) and arg_412_1.var_.actorSpriteComps10092 == nil then
				arg_412_1.var_.actorSpriteComps10092 = var_415_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_6 = 2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_6 and not isNil(var_415_5) then
				if arg_412_1.var_.actorSpriteComps10092 then
					for iter_415_5, iter_415_6 in pairs(arg_412_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_415_6 then
							if arg_412_1.isInRecall_ then
								iter_415_6.color = Color.New(Mathf.Lerp(iter_415_6.color.r, arg_412_1.hightColor2.r, (arg_412_1.time_ - 0) / var_415_6), Mathf.Lerp(iter_415_6.color.g, arg_412_1.hightColor2.g, (arg_412_1.time_ - 0) / var_415_6), (Mathf.Lerp(iter_415_6.color.b, arg_412_1.hightColor2.b, (arg_412_1.time_ - 0) / var_415_6)))
							else
								local var_415_7 = Mathf.Lerp(iter_415_6.color.r, 0.5, (arg_412_1.time_ - 0) / var_415_6)

								iter_415_6.color = Color.New(var_415_7, var_415_7, var_415_7)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_6 and arg_412_1.time_ < 0 + var_415_6 + arg_415_0 and not isNil(var_415_5) and arg_412_1.var_.actorSpriteComps10092 then
				for iter_415_7, iter_415_8 in pairs(arg_412_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_415_8 then
						iter_415_8.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_412_1.var_.actorSpriteComps10092 = nil
			end

			local var_415_8 = 0
			local var_415_9 = 0.75

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_8 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_10 = arg_412_1:GetWordFromCfg(413011100)
				local var_415_11 = arg_412_1:FormatText(var_415_10.content)

				arg_412_1.text_.text = var_415_11

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_13 = 30 <= 0 and var_415_9 or var_415_9 * (utf8.len(var_415_11) / 30)

				if (30 <= 0 and var_415_9 or var_415_9 * (utf8.len(var_415_11) / 30)) > 0 and var_415_9 < var_415_13 then
					arg_412_1.talkMaxDuration = var_415_13

					if var_415_13 + var_415_8 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_13 + var_415_8
					end
				end

				arg_412_1.text_.text = var_415_11
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011100", "story_v_out_413011.awb") ~= 0 then
					local var_415_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011100", "story_v_out_413011.awb") / 1000

					if var_415_14 + var_415_8 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_14 + var_415_8
					end

					if var_415_10.prefab_name ~= "" and arg_412_1.actors_[var_415_10.prefab_name] ~= nil then
						local var_415_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_10.prefab_name].transform, "story_v_out_413011", "413011100", "story_v_out_413011.awb")

						arg_412_1:RecordAudio("413011100", var_415_15)
						arg_412_1:RecordAudio("413011100", var_415_15)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_413011", "413011100", "story_v_out_413011.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_413011", "413011100", "story_v_out_413011.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_16 = math.max(var_415_9, arg_412_1.talkMaxDuration)

			if var_415_8 <= arg_412_1.time_ and arg_412_1.time_ < var_415_8 + var_415_16 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_8) / var_415_16

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_8 + var_415_16 and arg_412_1.time_ < var_415_8 + var_415_16 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
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

		arg_412_1:InitPlayNodeList()
	end,
	Play413011101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 413011101
		arg_416_1.duration_ = 9.7

		local var_416_0 = {
			zh = 7.366,
			ja = 9.7
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
				arg_416_0:Play413011102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(arg_416_1.actors_["10093"]) and arg_416_1.var_.actorSpriteComps10093 == nil then
				arg_416_1.var_.actorSpriteComps10093 = arg_416_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_0 = 2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 and not isNil(arg_416_1.actors_["10093"]) then
				if arg_416_1.var_.actorSpriteComps10093 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_419_1 then
							if arg_416_1.isInRecall_ then
								iter_419_1.color = Color.New(Mathf.Lerp(iter_419_1.color.r, arg_416_1.hightColor2.r, (arg_416_1.time_ - 0) / var_419_0), Mathf.Lerp(iter_419_1.color.g, arg_416_1.hightColor2.g, (arg_416_1.time_ - 0) / var_419_0), (Mathf.Lerp(iter_419_1.color.b, arg_416_1.hightColor2.b, (arg_416_1.time_ - 0) / var_419_0)))
							else
								local var_419_1 = Mathf.Lerp(iter_419_1.color.r, 0.5, (arg_416_1.time_ - 0) / var_419_0)

								iter_419_1.color = Color.New(var_419_1, var_419_1, var_419_1)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 and not isNil(arg_416_1.actors_["10093"]) and arg_416_1.var_.actorSpriteComps10093 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_419_3 then
						iter_419_3.color = arg_416_1.isInRecall_ and (arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_416_1.var_.actorSpriteComps10093 = nil
			end

			local var_419_2 = arg_416_1.actors_["10092"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_2) and arg_416_1.var_.actorSpriteComps10092 == nil then
				arg_416_1.var_.actorSpriteComps10092 = var_419_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_3 = 2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_3 and not isNil(var_419_2) then
				if arg_416_1.var_.actorSpriteComps10092 then
					for iter_419_4, iter_419_5 in pairs(arg_416_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_419_5 then
							if arg_416_1.isInRecall_ then
								iter_419_5.color = Color.New(Mathf.Lerp(iter_419_5.color.r, arg_416_1.hightColor1.r, (arg_416_1.time_ - 0) / var_419_3), Mathf.Lerp(iter_419_5.color.g, arg_416_1.hightColor1.g, (arg_416_1.time_ - 0) / var_419_3), (Mathf.Lerp(iter_419_5.color.b, arg_416_1.hightColor1.b, (arg_416_1.time_ - 0) / var_419_3)))
							else
								local var_419_4 = Mathf.Lerp(iter_419_5.color.r, 1, (arg_416_1.time_ - 0) / var_419_3)

								iter_419_5.color = Color.New(var_419_4, var_419_4, var_419_4)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= 0 + var_419_3 and arg_416_1.time_ < 0 + var_419_3 + arg_419_0 and not isNil(var_419_2) and arg_416_1.var_.actorSpriteComps10092 then
				for iter_419_6, iter_419_7 in pairs(arg_416_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_419_7 then
						iter_419_7.color = arg_416_1.isInRecall_ and (arg_416_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_416_1.var_.actorSpriteComps10092 = nil
			end

			local var_419_5 = arg_416_1.actors_["10092"].transform

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos10092 = var_419_5.localPosition
				var_419_5.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("10092", 2)

				for iter_419_8 = 0, var_419_5.childCount - 1 do
					local var_419_6 = var_419_5:GetChild(iter_419_8)

					if var_419_6.name == "split_6" or not string.find(var_419_6.name, "split") then
						var_419_6.gameObject:SetActive(true)
					else
						var_419_6.gameObject:SetActive(false)
					end
				end
			end

			local var_419_7 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				var_419_5.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_416_1.time_ - 0) / var_419_7)
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				var_419_5.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_419_8 = 0
			local var_419_9 = 0.825

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_8 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_10 = arg_416_1:GetWordFromCfg(413011101)
				local var_419_11 = arg_416_1:FormatText(var_419_10.content)

				arg_416_1.text_.text = var_419_11

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_13 = 33 <= 0 and var_419_9 or var_419_9 * (utf8.len(var_419_11) / 33)

				if (33 <= 0 and var_419_9 or var_419_9 * (utf8.len(var_419_11) / 33)) > 0 and var_419_9 < var_419_13 then
					arg_416_1.talkMaxDuration = var_419_13

					if var_419_13 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_13 + var_419_8
					end
				end

				arg_416_1.text_.text = var_419_11
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011101", "story_v_out_413011.awb") ~= 0 then
					local var_419_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011101", "story_v_out_413011.awb") / 1000

					if var_419_14 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_14 + var_419_8
					end

					if var_419_10.prefab_name ~= "" and arg_416_1.actors_[var_419_10.prefab_name] ~= nil then
						local var_419_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_10.prefab_name].transform, "story_v_out_413011", "413011101", "story_v_out_413011.awb")

						arg_416_1:RecordAudio("413011101", var_419_15)
						arg_416_1:RecordAudio("413011101", var_419_15)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_413011", "413011101", "story_v_out_413011.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_413011", "413011101", "story_v_out_413011.awb")
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
				actorName = "10092",
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
	Play413011102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 413011102
		arg_420_1.duration_ = 10.37

		local var_420_0 = {
			zh = 9.4,
			ja = 10.366
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
				arg_420_0:Play413011103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 1.025

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_1 = arg_420_1:GetWordFromCfg(413011102)
				local var_423_2 = arg_420_1:FormatText(var_423_1.content)

				arg_420_1.text_.text = var_423_2

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 41 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 41)

				if (41 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 41)) > 0 and var_423_0 < var_423_4 then
					arg_420_1.talkMaxDuration = var_423_4

					if var_423_4 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_4 + 0
					end
				end

				arg_420_1.text_.text = var_423_2
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011102", "story_v_out_413011.awb") ~= 0 then
					local var_423_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011102", "story_v_out_413011.awb") / 1000

					if var_423_5 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_5 + 0
					end

					if var_423_1.prefab_name ~= "" and arg_420_1.actors_[var_423_1.prefab_name] ~= nil then
						local var_423_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_1.prefab_name].transform, "story_v_out_413011", "413011102", "story_v_out_413011.awb")

						arg_420_1:RecordAudio("413011102", var_423_6)
						arg_420_1:RecordAudio("413011102", var_423_6)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_413011", "413011102", "story_v_out_413011.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_413011", "413011102", "story_v_out_413011.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_0, arg_420_1.talkMaxDuration)

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - 0) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= 0 + var_423_7 and arg_420_1.time_ < 0 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play413011103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 413011103
		arg_424_1.duration_ = 7.6

		local var_424_0 = {
			zh = 6.333,
			ja = 7.6
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
				arg_424_0:Play413011104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos10093 = arg_424_1.actors_["10093"].transform.localPosition
				arg_424_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("10093", 4)

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
				arg_424_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_424_1.time_ - 0) / var_427_1)
			end

			if arg_424_1.time_ >= 0 + var_427_1 and arg_424_1.time_ < 0 + var_427_1 + arg_427_0 then
				arg_424_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
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

			local var_427_5 = arg_424_1.actors_["10092"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_5) and arg_424_1.var_.actorSpriteComps10092 == nil then
				arg_424_1.var_.actorSpriteComps10092 = var_427_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_6 = 2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_6 and not isNil(var_427_5) then
				if arg_424_1.var_.actorSpriteComps10092 then
					for iter_427_5, iter_427_6 in pairs(arg_424_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_424_1.time_ >= 0 + var_427_6 and arg_424_1.time_ < 0 + var_427_6 + arg_427_0 and not isNil(var_427_5) and arg_424_1.var_.actorSpriteComps10092 then
				for iter_427_7, iter_427_8 in pairs(arg_424_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_427_8 then
						iter_427_8.color = arg_424_1.isInRecall_ and (arg_424_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_424_1.var_.actorSpriteComps10092 = nil
			end

			local var_427_8 = 0
			local var_427_9 = 0.625

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

				local var_427_10 = arg_424_1:GetWordFromCfg(413011103)
				local var_427_11 = arg_424_1:FormatText(var_427_10.content)

				arg_424_1.text_.text = var_427_11

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_13 = 25 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 25)

				if (25 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 25)) > 0 and var_427_9 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_8
					end
				end

				arg_424_1.text_.text = var_427_11
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011103", "story_v_out_413011.awb") ~= 0 then
					local var_427_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011103", "story_v_out_413011.awb") / 1000

					if var_427_14 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_14 + var_427_8
					end

					if var_427_10.prefab_name ~= "" and arg_424_1.actors_[var_427_10.prefab_name] ~= nil then
						local var_427_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_10.prefab_name].transform, "story_v_out_413011", "413011103", "story_v_out_413011.awb")

						arg_424_1:RecordAudio("413011103", var_427_15)
						arg_424_1:RecordAudio("413011103", var_427_15)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_413011", "413011103", "story_v_out_413011.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_413011", "413011103", "story_v_out_413011.awb")
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
	Play413011104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 413011104
		arg_428_1.duration_ = 9.7

		local var_428_0 = {
			zh = 5,
			ja = 9.7
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
				arg_428_0:Play413011105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(arg_428_1.actors_["10093"]) and arg_428_1.var_.actorSpriteComps10093 == nil then
				arg_428_1.var_.actorSpriteComps10093 = arg_428_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_0 = 2

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 and not isNil(arg_428_1.actors_["10093"]) then
				if arg_428_1.var_.actorSpriteComps10093 then
					for iter_431_0, iter_431_1 in pairs(arg_428_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_431_1 then
							if arg_428_1.isInRecall_ then
								iter_431_1.color = Color.New(Mathf.Lerp(iter_431_1.color.r, arg_428_1.hightColor2.r, (arg_428_1.time_ - 0) / var_431_0), Mathf.Lerp(iter_431_1.color.g, arg_428_1.hightColor2.g, (arg_428_1.time_ - 0) / var_431_0), (Mathf.Lerp(iter_431_1.color.b, arg_428_1.hightColor2.b, (arg_428_1.time_ - 0) / var_431_0)))
							else
								local var_431_1 = Mathf.Lerp(iter_431_1.color.r, 0.5, (arg_428_1.time_ - 0) / var_431_0)

								iter_431_1.color = Color.New(var_431_1, var_431_1, var_431_1)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 and not isNil(arg_428_1.actors_["10093"]) and arg_428_1.var_.actorSpriteComps10093 then
				for iter_431_2, iter_431_3 in pairs(arg_428_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_431_3 then
						iter_431_3.color = arg_428_1.isInRecall_ and (arg_428_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_428_1.var_.actorSpriteComps10093 = nil
			end

			local var_431_2 = arg_428_1.actors_["10092"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_2) and arg_428_1.var_.actorSpriteComps10092 == nil then
				arg_428_1.var_.actorSpriteComps10092 = var_431_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_3 = 2

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_3 and not isNil(var_431_2) then
				if arg_428_1.var_.actorSpriteComps10092 then
					for iter_431_4, iter_431_5 in pairs(arg_428_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_431_5 then
							if arg_428_1.isInRecall_ then
								iter_431_5.color = Color.New(Mathf.Lerp(iter_431_5.color.r, arg_428_1.hightColor1.r, (arg_428_1.time_ - 0) / var_431_3), Mathf.Lerp(iter_431_5.color.g, arg_428_1.hightColor1.g, (arg_428_1.time_ - 0) / var_431_3), (Mathf.Lerp(iter_431_5.color.b, arg_428_1.hightColor1.b, (arg_428_1.time_ - 0) / var_431_3)))
							else
								local var_431_4 = Mathf.Lerp(iter_431_5.color.r, 1, (arg_428_1.time_ - 0) / var_431_3)

								iter_431_5.color = Color.New(var_431_4, var_431_4, var_431_4)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= 0 + var_431_3 and arg_428_1.time_ < 0 + var_431_3 + arg_431_0 and not isNil(var_431_2) and arg_428_1.var_.actorSpriteComps10092 then
				for iter_431_6, iter_431_7 in pairs(arg_428_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_431_7 then
						iter_431_7.color = arg_428_1.isInRecall_ and (arg_428_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_428_1.var_.actorSpriteComps10092 = nil
			end

			local var_431_5 = 0
			local var_431_6 = 0.475

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_5 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_7 = arg_428_1:GetWordFromCfg(413011104)
				local var_431_8 = arg_428_1:FormatText(var_431_7.content)

				arg_428_1.text_.text = var_431_8

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_10 = 19 <= 0 and var_431_6 or var_431_6 * (utf8.len(var_431_8) / 19)

				if (19 <= 0 and var_431_6 or var_431_6 * (utf8.len(var_431_8) / 19)) > 0 and var_431_6 < var_431_10 then
					arg_428_1.talkMaxDuration = var_431_10

					if var_431_10 + var_431_5 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_10 + var_431_5
					end
				end

				arg_428_1.text_.text = var_431_8
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011104", "story_v_out_413011.awb") ~= 0 then
					local var_431_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011104", "story_v_out_413011.awb") / 1000

					if var_431_11 + var_431_5 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_11 + var_431_5
					end

					if var_431_7.prefab_name ~= "" and arg_428_1.actors_[var_431_7.prefab_name] ~= nil then
						local var_431_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_7.prefab_name].transform, "story_v_out_413011", "413011104", "story_v_out_413011.awb")

						arg_428_1:RecordAudio("413011104", var_431_12)
						arg_428_1:RecordAudio("413011104", var_431_12)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_413011", "413011104", "story_v_out_413011.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_413011", "413011104", "story_v_out_413011.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_13 = math.max(var_431_6, arg_428_1.talkMaxDuration)

			if var_431_5 <= arg_428_1.time_ and arg_428_1.time_ < var_431_5 + var_431_13 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_5) / var_431_13

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_5 + var_431_13 and arg_428_1.time_ < var_431_5 + var_431_13 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play413011105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 413011105
		arg_432_1.duration_ = 2

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play413011106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos10093 = arg_432_1.actors_["10093"].transform.localPosition
				arg_432_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("10093", 4)

				for iter_435_0 = 0, arg_432_1.actors_["10093"].transform.childCount - 1 do
					local var_435_0 = arg_432_1.actors_["10093"].transform:GetChild(iter_435_0)

					if var_435_0.name == "split_6" or not string.find(var_435_0.name, "split") then
						var_435_0.gameObject:SetActive(true)
					else
						var_435_0.gameObject:SetActive(false)
					end
				end
			end

			local var_435_1 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_1 then
				arg_432_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_432_1.time_ - 0) / var_435_1)
			end

			if arg_432_1.time_ >= 0 + var_435_1 and arg_432_1.time_ < 0 + var_435_1 + arg_435_0 then
				arg_432_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_435_2 = arg_432_1.actors_["10093"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.actorSpriteComps10093 == nil then
				arg_432_1.var_.actorSpriteComps10093 = var_435_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_3 = 2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_3 and not isNil(var_435_2) then
				if arg_432_1.var_.actorSpriteComps10093 then
					for iter_435_1, iter_435_2 in pairs(arg_432_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_435_2 then
							if arg_432_1.isInRecall_ then
								iter_435_2.color = Color.New(Mathf.Lerp(iter_435_2.color.r, arg_432_1.hightColor1.r, (arg_432_1.time_ - 0) / var_435_3), Mathf.Lerp(iter_435_2.color.g, arg_432_1.hightColor1.g, (arg_432_1.time_ - 0) / var_435_3), (Mathf.Lerp(iter_435_2.color.b, arg_432_1.hightColor1.b, (arg_432_1.time_ - 0) / var_435_3)))
							else
								local var_435_4 = Mathf.Lerp(iter_435_2.color.r, 1, (arg_432_1.time_ - 0) / var_435_3)

								iter_435_2.color = Color.New(var_435_4, var_435_4, var_435_4)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_3 and arg_432_1.time_ < 0 + var_435_3 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.actorSpriteComps10093 then
				for iter_435_3, iter_435_4 in pairs(arg_432_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_435_4 then
						iter_435_4.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_432_1.var_.actorSpriteComps10093 = nil
			end

			local var_435_5 = arg_432_1.actors_["10092"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_5) and arg_432_1.var_.actorSpriteComps10092 == nil then
				arg_432_1.var_.actorSpriteComps10092 = var_435_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_6 = 2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_6 and not isNil(var_435_5) then
				if arg_432_1.var_.actorSpriteComps10092 then
					for iter_435_5, iter_435_6 in pairs(arg_432_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_435_6 then
							if arg_432_1.isInRecall_ then
								iter_435_6.color = Color.New(Mathf.Lerp(iter_435_6.color.r, arg_432_1.hightColor2.r, (arg_432_1.time_ - 0) / var_435_6), Mathf.Lerp(iter_435_6.color.g, arg_432_1.hightColor2.g, (arg_432_1.time_ - 0) / var_435_6), (Mathf.Lerp(iter_435_6.color.b, arg_432_1.hightColor2.b, (arg_432_1.time_ - 0) / var_435_6)))
							else
								local var_435_7 = Mathf.Lerp(iter_435_6.color.r, 0.5, (arg_432_1.time_ - 0) / var_435_6)

								iter_435_6.color = Color.New(var_435_7, var_435_7, var_435_7)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_6 and arg_432_1.time_ < 0 + var_435_6 + arg_435_0 and not isNil(var_435_5) and arg_432_1.var_.actorSpriteComps10092 then
				for iter_435_7, iter_435_8 in pairs(arg_432_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_435_8 then
						iter_435_8.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_432_1.var_.actorSpriteComps10092 = nil
			end

			local var_435_8 = 0
			local var_435_9 = 0.1

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_8 + arg_435_0 then
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

				local var_435_10 = arg_432_1:GetWordFromCfg(413011105)
				local var_435_11 = arg_432_1:FormatText(var_435_10.content)

				arg_432_1.text_.text = var_435_11

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_13 = 4 <= 0 and var_435_9 or var_435_9 * (utf8.len(var_435_11) / 4)

				if (4 <= 0 and var_435_9 or var_435_9 * (utf8.len(var_435_11) / 4)) > 0 and var_435_9 < var_435_13 then
					arg_432_1.talkMaxDuration = var_435_13

					if var_435_13 + var_435_8 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_13 + var_435_8
					end
				end

				arg_432_1.text_.text = var_435_11
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011105", "story_v_out_413011.awb") ~= 0 then
					local var_435_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011105", "story_v_out_413011.awb") / 1000

					if var_435_14 + var_435_8 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_14 + var_435_8
					end

					if var_435_10.prefab_name ~= "" and arg_432_1.actors_[var_435_10.prefab_name] ~= nil then
						local var_435_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_10.prefab_name].transform, "story_v_out_413011", "413011105", "story_v_out_413011.awb")

						arg_432_1:RecordAudio("413011105", var_435_15)
						arg_432_1:RecordAudio("413011105", var_435_15)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_413011", "413011105", "story_v_out_413011.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_413011", "413011105", "story_v_out_413011.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_16 = math.max(var_435_9, arg_432_1.talkMaxDuration)

			if var_435_8 <= arg_432_1.time_ and arg_432_1.time_ < var_435_8 + var_435_16 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_8) / var_435_16

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_8 + var_435_16 and arg_432_1.time_ < var_435_8 + var_435_16 + arg_435_0 then
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
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play413011106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 413011106
		arg_436_1.duration_ = 13.37

		local var_436_0 = {
			zh = 8.966,
			ja = 13.366
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
				arg_436_0:Play413011107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos10092 = arg_436_1.actors_["10092"].transform.localPosition
				arg_436_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("10092", 2)

				for iter_439_0 = 0, arg_436_1.actors_["10092"].transform.childCount - 1 do
					local var_439_0 = arg_436_1.actors_["10092"].transform:GetChild(iter_439_0)

					if var_439_0.name == "split_1_1" or not string.find(var_439_0.name, "split") then
						var_439_0.gameObject:SetActive(true)
					else
						var_439_0.gameObject:SetActive(false)
					end
				end
			end

			local var_439_1 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_1 then
				arg_436_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_436_1.time_ - 0) / var_439_1)
			end

			if arg_436_1.time_ >= 0 + var_439_1 and arg_436_1.time_ < 0 + var_439_1 + arg_439_0 then
				arg_436_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_439_2 = arg_436_1.actors_["10093"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_2) and arg_436_1.var_.actorSpriteComps10093 == nil then
				arg_436_1.var_.actorSpriteComps10093 = var_439_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_3 = 2

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_3 and not isNil(var_439_2) then
				if arg_436_1.var_.actorSpriteComps10093 then
					for iter_439_1, iter_439_2 in pairs(arg_436_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_439_2 then
							if arg_436_1.isInRecall_ then
								iter_439_2.color = Color.New(Mathf.Lerp(iter_439_2.color.r, arg_436_1.hightColor2.r, (arg_436_1.time_ - 0) / var_439_3), Mathf.Lerp(iter_439_2.color.g, arg_436_1.hightColor2.g, (arg_436_1.time_ - 0) / var_439_3), (Mathf.Lerp(iter_439_2.color.b, arg_436_1.hightColor2.b, (arg_436_1.time_ - 0) / var_439_3)))
							else
								local var_439_4 = Mathf.Lerp(iter_439_2.color.r, 0.5, (arg_436_1.time_ - 0) / var_439_3)

								iter_439_2.color = Color.New(var_439_4, var_439_4, var_439_4)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= 0 + var_439_3 and arg_436_1.time_ < 0 + var_439_3 + arg_439_0 and not isNil(var_439_2) and arg_436_1.var_.actorSpriteComps10093 then
				for iter_439_3, iter_439_4 in pairs(arg_436_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_439_4 then
						iter_439_4.color = arg_436_1.isInRecall_ and (arg_436_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_436_1.var_.actorSpriteComps10093 = nil
			end

			local var_439_5 = arg_436_1.actors_["10092"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_5) and arg_436_1.var_.actorSpriteComps10092 == nil then
				arg_436_1.var_.actorSpriteComps10092 = var_439_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_6 = 2

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_6 and not isNil(var_439_5) then
				if arg_436_1.var_.actorSpriteComps10092 then
					for iter_439_5, iter_439_6 in pairs(arg_436_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_439_6 then
							if arg_436_1.isInRecall_ then
								iter_439_6.color = Color.New(Mathf.Lerp(iter_439_6.color.r, arg_436_1.hightColor1.r, (arg_436_1.time_ - 0) / var_439_6), Mathf.Lerp(iter_439_6.color.g, arg_436_1.hightColor1.g, (arg_436_1.time_ - 0) / var_439_6), (Mathf.Lerp(iter_439_6.color.b, arg_436_1.hightColor1.b, (arg_436_1.time_ - 0) / var_439_6)))
							else
								local var_439_7 = Mathf.Lerp(iter_439_6.color.r, 1, (arg_436_1.time_ - 0) / var_439_6)

								iter_439_6.color = Color.New(var_439_7, var_439_7, var_439_7)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= 0 + var_439_6 and arg_436_1.time_ < 0 + var_439_6 + arg_439_0 and not isNil(var_439_5) and arg_436_1.var_.actorSpriteComps10092 then
				for iter_439_7, iter_439_8 in pairs(arg_436_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_439_8 then
						iter_439_8.color = arg_436_1.isInRecall_ and (arg_436_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_436_1.var_.actorSpriteComps10092 = nil
			end

			local var_439_8 = 0
			local var_439_9 = 1.05

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_8 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_10 = arg_436_1:GetWordFromCfg(413011106)
				local var_439_11 = arg_436_1:FormatText(var_439_10.content)

				arg_436_1.text_.text = var_439_11

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_13 = 42 <= 0 and var_439_9 or var_439_9 * (utf8.len(var_439_11) / 42)

				if (42 <= 0 and var_439_9 or var_439_9 * (utf8.len(var_439_11) / 42)) > 0 and var_439_9 < var_439_13 then
					arg_436_1.talkMaxDuration = var_439_13

					if var_439_13 + var_439_8 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_13 + var_439_8
					end
				end

				arg_436_1.text_.text = var_439_11
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011106", "story_v_out_413011.awb") ~= 0 then
					local var_439_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011106", "story_v_out_413011.awb") / 1000

					if var_439_14 + var_439_8 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_14 + var_439_8
					end

					if var_439_10.prefab_name ~= "" and arg_436_1.actors_[var_439_10.prefab_name] ~= nil then
						local var_439_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_10.prefab_name].transform, "story_v_out_413011", "413011106", "story_v_out_413011.awb")

						arg_436_1:RecordAudio("413011106", var_439_15)
						arg_436_1:RecordAudio("413011106", var_439_15)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_413011", "413011106", "story_v_out_413011.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_413011", "413011106", "story_v_out_413011.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_16 = math.max(var_439_9, arg_436_1.talkMaxDuration)

			if var_439_8 <= arg_436_1.time_ and arg_436_1.time_ < var_439_8 + var_439_16 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_8) / var_439_16

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_8 + var_439_16 and arg_436_1.time_ < var_439_8 + var_439_16 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
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

		arg_436_1:InitPlayNodeList()
	end,
	Play413011107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 413011107
		arg_440_1.duration_ = 10.37

		local var_440_0 = {
			zh = 7.066,
			ja = 10.366
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
				arg_440_0:Play413011108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0.65

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_1 = arg_440_1:GetWordFromCfg(413011107)
				local var_443_2 = arg_440_1:FormatText(var_443_1.content)

				arg_440_1.text_.text = var_443_2

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_4 = 26 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 26)

				if (26 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 26)) > 0 and var_443_0 < var_443_4 then
					arg_440_1.talkMaxDuration = var_443_4

					if var_443_4 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_4 + 0
					end
				end

				arg_440_1.text_.text = var_443_2
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011107", "story_v_out_413011.awb") ~= 0 then
					local var_443_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011107", "story_v_out_413011.awb") / 1000

					if var_443_5 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + 0
					end

					if var_443_1.prefab_name ~= "" and arg_440_1.actors_[var_443_1.prefab_name] ~= nil then
						local var_443_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_1.prefab_name].transform, "story_v_out_413011", "413011107", "story_v_out_413011.awb")

						arg_440_1:RecordAudio("413011107", var_443_6)
						arg_440_1:RecordAudio("413011107", var_443_6)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_413011", "413011107", "story_v_out_413011.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_413011", "413011107", "story_v_out_413011.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_7 = math.max(var_443_0, arg_440_1.talkMaxDuration)

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_7 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - 0) / var_443_7

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= 0 + var_443_7 and arg_440_1.time_ < 0 + var_443_7 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play413011108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 413011108
		arg_444_1.duration_ = 6.27

		local var_444_0 = {
			zh = 3.2,
			ja = 6.266
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
				arg_444_0:Play413011109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos10093 = arg_444_1.actors_["10093"].transform.localPosition
				arg_444_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_444_1:CheckSpriteTmpPos("10093", 4)

				for iter_447_0 = 0, arg_444_1.actors_["10093"].transform.childCount - 1 do
					local var_447_0 = arg_444_1.actors_["10093"].transform:GetChild(iter_447_0)

					if var_447_0.name == "split_4" or not string.find(var_447_0.name, "split") then
						var_447_0.gameObject:SetActive(true)
					else
						var_447_0.gameObject:SetActive(false)
					end
				end
			end

			local var_447_1 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_1 then
				arg_444_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_444_1.time_ - 0) / var_447_1)
			end

			if arg_444_1.time_ >= 0 + var_447_1 and arg_444_1.time_ < 0 + var_447_1 + arg_447_0 then
				arg_444_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_447_2 = arg_444_1.actors_["10093"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.actorSpriteComps10093 == nil then
				arg_444_1.var_.actorSpriteComps10093 = var_447_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_3 = 2

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_3 and not isNil(var_447_2) then
				if arg_444_1.var_.actorSpriteComps10093 then
					for iter_447_1, iter_447_2 in pairs(arg_444_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_447_2 then
							if arg_444_1.isInRecall_ then
								iter_447_2.color = Color.New(Mathf.Lerp(iter_447_2.color.r, arg_444_1.hightColor1.r, (arg_444_1.time_ - 0) / var_447_3), Mathf.Lerp(iter_447_2.color.g, arg_444_1.hightColor1.g, (arg_444_1.time_ - 0) / var_447_3), (Mathf.Lerp(iter_447_2.color.b, arg_444_1.hightColor1.b, (arg_444_1.time_ - 0) / var_447_3)))
							else
								local var_447_4 = Mathf.Lerp(iter_447_2.color.r, 1, (arg_444_1.time_ - 0) / var_447_3)

								iter_447_2.color = Color.New(var_447_4, var_447_4, var_447_4)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= 0 + var_447_3 and arg_444_1.time_ < 0 + var_447_3 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.actorSpriteComps10093 then
				for iter_447_3, iter_447_4 in pairs(arg_444_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_447_4 then
						iter_447_4.color = arg_444_1.isInRecall_ and (arg_444_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_444_1.var_.actorSpriteComps10093 = nil
			end

			local var_447_5 = arg_444_1.actors_["10092"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_5) and arg_444_1.var_.actorSpriteComps10092 == nil then
				arg_444_1.var_.actorSpriteComps10092 = var_447_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_6 = 2

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_6 and not isNil(var_447_5) then
				if arg_444_1.var_.actorSpriteComps10092 then
					for iter_447_5, iter_447_6 in pairs(arg_444_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_447_6 then
							if arg_444_1.isInRecall_ then
								iter_447_6.color = Color.New(Mathf.Lerp(iter_447_6.color.r, arg_444_1.hightColor2.r, (arg_444_1.time_ - 0) / var_447_6), Mathf.Lerp(iter_447_6.color.g, arg_444_1.hightColor2.g, (arg_444_1.time_ - 0) / var_447_6), (Mathf.Lerp(iter_447_6.color.b, arg_444_1.hightColor2.b, (arg_444_1.time_ - 0) / var_447_6)))
							else
								local var_447_7 = Mathf.Lerp(iter_447_6.color.r, 0.5, (arg_444_1.time_ - 0) / var_447_6)

								iter_447_6.color = Color.New(var_447_7, var_447_7, var_447_7)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= 0 + var_447_6 and arg_444_1.time_ < 0 + var_447_6 + arg_447_0 and not isNil(var_447_5) and arg_444_1.var_.actorSpriteComps10092 then
				for iter_447_7, iter_447_8 in pairs(arg_444_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_447_8 then
						iter_447_8.color = arg_444_1.isInRecall_ and (arg_444_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_444_1.var_.actorSpriteComps10092 = nil
			end

			local var_447_8 = 0
			local var_447_9 = 0.375

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_8 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_10 = arg_444_1:GetWordFromCfg(413011108)
				local var_447_11 = arg_444_1:FormatText(var_447_10.content)

				arg_444_1.text_.text = var_447_11

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_13 = 15 <= 0 and var_447_9 or var_447_9 * (utf8.len(var_447_11) / 15)

				if (15 <= 0 and var_447_9 or var_447_9 * (utf8.len(var_447_11) / 15)) > 0 and var_447_9 < var_447_13 then
					arg_444_1.talkMaxDuration = var_447_13

					if var_447_13 + var_447_8 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_13 + var_447_8
					end
				end

				arg_444_1.text_.text = var_447_11
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011108", "story_v_out_413011.awb") ~= 0 then
					local var_447_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011108", "story_v_out_413011.awb") / 1000

					if var_447_14 + var_447_8 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_14 + var_447_8
					end

					if var_447_10.prefab_name ~= "" and arg_444_1.actors_[var_447_10.prefab_name] ~= nil then
						local var_447_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_10.prefab_name].transform, "story_v_out_413011", "413011108", "story_v_out_413011.awb")

						arg_444_1:RecordAudio("413011108", var_447_15)
						arg_444_1:RecordAudio("413011108", var_447_15)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_413011", "413011108", "story_v_out_413011.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_413011", "413011108", "story_v_out_413011.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_16 = math.max(var_447_9, arg_444_1.talkMaxDuration)

			if var_447_8 <= arg_444_1.time_ and arg_444_1.time_ < var_447_8 + var_447_16 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_8) / var_447_16

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_8 + var_447_16 and arg_444_1.time_ < var_447_8 + var_447_16 + arg_447_0 then
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
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play413011109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 413011109
		arg_448_1.duration_ = 12.73

		local var_448_0 = {
			zh = 8.066,
			ja = 12.733
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
				arg_448_0:Play413011110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos10092 = arg_448_1.actors_["10092"].transform.localPosition
				arg_448_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("10092", 2)

				for iter_451_0 = 0, arg_448_1.actors_["10092"].transform.childCount - 1 do
					local var_451_0 = arg_448_1.actors_["10092"].transform:GetChild(iter_451_0)

					if var_451_0.name == "split_2" or not string.find(var_451_0.name, "split") then
						var_451_0.gameObject:SetActive(true)
					else
						var_451_0.gameObject:SetActive(false)
					end
				end
			end

			local var_451_1 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_1 then
				arg_448_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_448_1.time_ - 0) / var_451_1)
			end

			if arg_448_1.time_ >= 0 + var_451_1 and arg_448_1.time_ < 0 + var_451_1 + arg_451_0 then
				arg_448_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_451_2 = arg_448_1.actors_["10093"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_2) and arg_448_1.var_.actorSpriteComps10093 == nil then
				arg_448_1.var_.actorSpriteComps10093 = var_451_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_3 = 2

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_3 and not isNil(var_451_2) then
				if arg_448_1.var_.actorSpriteComps10093 then
					for iter_451_1, iter_451_2 in pairs(arg_448_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_451_2 then
							if arg_448_1.isInRecall_ then
								iter_451_2.color = Color.New(Mathf.Lerp(iter_451_2.color.r, arg_448_1.hightColor2.r, (arg_448_1.time_ - 0) / var_451_3), Mathf.Lerp(iter_451_2.color.g, arg_448_1.hightColor2.g, (arg_448_1.time_ - 0) / var_451_3), (Mathf.Lerp(iter_451_2.color.b, arg_448_1.hightColor2.b, (arg_448_1.time_ - 0) / var_451_3)))
							else
								local var_451_4 = Mathf.Lerp(iter_451_2.color.r, 0.5, (arg_448_1.time_ - 0) / var_451_3)

								iter_451_2.color = Color.New(var_451_4, var_451_4, var_451_4)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= 0 + var_451_3 and arg_448_1.time_ < 0 + var_451_3 + arg_451_0 and not isNil(var_451_2) and arg_448_1.var_.actorSpriteComps10093 then
				for iter_451_3, iter_451_4 in pairs(arg_448_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_451_4 then
						iter_451_4.color = arg_448_1.isInRecall_ and (arg_448_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_448_1.var_.actorSpriteComps10093 = nil
			end

			local var_451_5 = arg_448_1.actors_["10092"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_5) and arg_448_1.var_.actorSpriteComps10092 == nil then
				arg_448_1.var_.actorSpriteComps10092 = var_451_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_6 = 2

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_6 and not isNil(var_451_5) then
				if arg_448_1.var_.actorSpriteComps10092 then
					for iter_451_5, iter_451_6 in pairs(arg_448_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_451_6 then
							if arg_448_1.isInRecall_ then
								iter_451_6.color = Color.New(Mathf.Lerp(iter_451_6.color.r, arg_448_1.hightColor1.r, (arg_448_1.time_ - 0) / var_451_6), Mathf.Lerp(iter_451_6.color.g, arg_448_1.hightColor1.g, (arg_448_1.time_ - 0) / var_451_6), (Mathf.Lerp(iter_451_6.color.b, arg_448_1.hightColor1.b, (arg_448_1.time_ - 0) / var_451_6)))
							else
								local var_451_7 = Mathf.Lerp(iter_451_6.color.r, 1, (arg_448_1.time_ - 0) / var_451_6)

								iter_451_6.color = Color.New(var_451_7, var_451_7, var_451_7)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= 0 + var_451_6 and arg_448_1.time_ < 0 + var_451_6 + arg_451_0 and not isNil(var_451_5) and arg_448_1.var_.actorSpriteComps10092 then
				for iter_451_7, iter_451_8 in pairs(arg_448_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_451_8 then
						iter_451_8.color = arg_448_1.isInRecall_ and (arg_448_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_448_1.var_.actorSpriteComps10092 = nil
			end

			local var_451_8 = 0
			local var_451_9 = 0.85

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_8 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_10 = arg_448_1:GetWordFromCfg(413011109)
				local var_451_11 = arg_448_1:FormatText(var_451_10.content)

				arg_448_1.text_.text = var_451_11

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_13 = 34 <= 0 and var_451_9 or var_451_9 * (utf8.len(var_451_11) / 34)

				if (34 <= 0 and var_451_9 or var_451_9 * (utf8.len(var_451_11) / 34)) > 0 and var_451_9 < var_451_13 then
					arg_448_1.talkMaxDuration = var_451_13

					if var_451_13 + var_451_8 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_13 + var_451_8
					end
				end

				arg_448_1.text_.text = var_451_11
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011109", "story_v_out_413011.awb") ~= 0 then
					local var_451_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011109", "story_v_out_413011.awb") / 1000

					if var_451_14 + var_451_8 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_14 + var_451_8
					end

					if var_451_10.prefab_name ~= "" and arg_448_1.actors_[var_451_10.prefab_name] ~= nil then
						local var_451_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_10.prefab_name].transform, "story_v_out_413011", "413011109", "story_v_out_413011.awb")

						arg_448_1:RecordAudio("413011109", var_451_15)
						arg_448_1:RecordAudio("413011109", var_451_15)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_413011", "413011109", "story_v_out_413011.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_413011", "413011109", "story_v_out_413011.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_16 = math.max(var_451_9, arg_448_1.talkMaxDuration)

			if var_451_8 <= arg_448_1.time_ and arg_448_1.time_ < var_451_8 + var_451_16 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_8) / var_451_16

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_8 + var_451_16 and arg_448_1.time_ < var_451_8 + var_451_16 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
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

		arg_448_1:InitPlayNodeList()
	end,
	Play413011110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 413011110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play413011111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["10092"]) and arg_452_1.var_.actorSpriteComps10092 == nil then
				arg_452_1.var_.actorSpriteComps10092 = arg_452_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_0 = 2

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["10092"]) then
				if arg_452_1.var_.actorSpriteComps10092 then
					for iter_455_0, iter_455_1 in pairs(arg_452_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_455_1 then
							if arg_452_1.isInRecall_ then
								iter_455_1.color = Color.New(Mathf.Lerp(iter_455_1.color.r, arg_452_1.hightColor2.r, (arg_452_1.time_ - 0) / var_455_0), Mathf.Lerp(iter_455_1.color.g, arg_452_1.hightColor2.g, (arg_452_1.time_ - 0) / var_455_0), (Mathf.Lerp(iter_455_1.color.b, arg_452_1.hightColor2.b, (arg_452_1.time_ - 0) / var_455_0)))
							else
								local var_455_1 = Mathf.Lerp(iter_455_1.color.r, 0.5, (arg_452_1.time_ - 0) / var_455_0)

								iter_455_1.color = Color.New(var_455_1, var_455_1, var_455_1)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["10092"]) and arg_452_1.var_.actorSpriteComps10092 then
				for iter_455_2, iter_455_3 in pairs(arg_452_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_455_3 then
						iter_455_3.color = arg_452_1.isInRecall_ and (arg_452_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_452_1.var_.actorSpriteComps10092 = nil
			end

			local var_455_2 = 0
			local var_455_3 = 0.725

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_2 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_4 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(413011110).content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_6 = 29 <= 0 and var_455_3 or var_455_3 * (utf8.len(var_455_4) / 29)

				if (29 <= 0 and var_455_3 or var_455_3 * (utf8.len(var_455_4) / 29)) > 0 and var_455_3 < var_455_6 then
					arg_452_1.talkMaxDuration = var_455_6

					if var_455_6 + var_455_2 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_6 + var_455_2
					end
				end

				arg_452_1.text_.text = var_455_4
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_7 = math.max(var_455_3, arg_452_1.talkMaxDuration)

			if var_455_2 <= arg_452_1.time_ and arg_452_1.time_ < var_455_2 + var_455_7 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_2) / var_455_7

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_2 + var_455_7 and arg_452_1.time_ < var_455_2 + var_455_7 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play413011111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 413011111
		arg_456_1.duration_ = 7.73

		local var_456_0 = {
			zh = 7.2,
			ja = 7.733
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
				arg_456_0:Play413011112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(arg_456_1.actors_["10092"]) and arg_456_1.var_.actorSpriteComps10092 == nil then
				arg_456_1.var_.actorSpriteComps10092 = arg_456_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_0 = 2

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 and not isNil(arg_456_1.actors_["10092"]) then
				if arg_456_1.var_.actorSpriteComps10092 then
					for iter_459_0, iter_459_1 in pairs(arg_456_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_459_1 then
							if arg_456_1.isInRecall_ then
								iter_459_1.color = Color.New(Mathf.Lerp(iter_459_1.color.r, arg_456_1.hightColor1.r, (arg_456_1.time_ - 0) / var_459_0), Mathf.Lerp(iter_459_1.color.g, arg_456_1.hightColor1.g, (arg_456_1.time_ - 0) / var_459_0), (Mathf.Lerp(iter_459_1.color.b, arg_456_1.hightColor1.b, (arg_456_1.time_ - 0) / var_459_0)))
							else
								local var_459_1 = Mathf.Lerp(iter_459_1.color.r, 1, (arg_456_1.time_ - 0) / var_459_0)

								iter_459_1.color = Color.New(var_459_1, var_459_1, var_459_1)
							end
						end
					end
				end
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 and not isNil(arg_456_1.actors_["10092"]) and arg_456_1.var_.actorSpriteComps10092 then
				for iter_459_2, iter_459_3 in pairs(arg_456_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_459_3 then
						iter_459_3.color = arg_456_1.isInRecall_ and (arg_456_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_456_1.var_.actorSpriteComps10092 = nil
			end

			local var_459_2 = arg_456_1.actors_["10092"].transform

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos10092 = var_459_2.localPosition
				var_459_2.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("10092", 2)

				for iter_459_4 = 0, var_459_2.childCount - 1 do
					local var_459_3 = var_459_2:GetChild(iter_459_4)

					if var_459_3.name == "split_1_1" or not string.find(var_459_3.name, "split") then
						var_459_3.gameObject:SetActive(true)
					else
						var_459_3.gameObject:SetActive(false)
					end
				end
			end

			local var_459_4 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 then
				var_459_2.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_456_1.time_ - 0) / var_459_4)
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 then
				var_459_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_459_5 = 0
			local var_459_6 = 0.7

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_5 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_7 = arg_456_1:GetWordFromCfg(413011111)
				local var_459_8 = arg_456_1:FormatText(var_459_7.content)

				arg_456_1.text_.text = var_459_8

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_10 = 28 <= 0 and var_459_6 or var_459_6 * (utf8.len(var_459_8) / 28)

				if (28 <= 0 and var_459_6 or var_459_6 * (utf8.len(var_459_8) / 28)) > 0 and var_459_6 < var_459_10 then
					arg_456_1.talkMaxDuration = var_459_10

					if var_459_10 + var_459_5 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_10 + var_459_5
					end
				end

				arg_456_1.text_.text = var_459_8
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011111", "story_v_out_413011.awb") ~= 0 then
					local var_459_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011111", "story_v_out_413011.awb") / 1000

					if var_459_11 + var_459_5 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_11 + var_459_5
					end

					if var_459_7.prefab_name ~= "" and arg_456_1.actors_[var_459_7.prefab_name] ~= nil then
						local var_459_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_7.prefab_name].transform, "story_v_out_413011", "413011111", "story_v_out_413011.awb")

						arg_456_1:RecordAudio("413011111", var_459_12)
						arg_456_1:RecordAudio("413011111", var_459_12)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_413011", "413011111", "story_v_out_413011.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_413011", "413011111", "story_v_out_413011.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_13 = math.max(var_459_6, arg_456_1.talkMaxDuration)

			if var_459_5 <= arg_456_1.time_ and arg_456_1.time_ < var_459_5 + var_459_13 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_5) / var_459_13

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_5 + var_459_13 and arg_456_1.time_ < var_459_5 + var_459_13 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
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

		arg_456_1:InitPlayNodeList()
	end,
	Play413011112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 413011112
		arg_460_1.duration_ = 2.33

		local var_460_0 = {
			zh = 1.999999999999,
			ja = 2.333
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
				arg_460_0:Play413011113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos10093 = arg_460_1.actors_["10093"].transform.localPosition
				arg_460_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_460_1:CheckSpriteTmpPos("10093", 4)

				for iter_463_0 = 0, arg_460_1.actors_["10093"].transform.childCount - 1 do
					local var_463_0 = arg_460_1.actors_["10093"].transform:GetChild(iter_463_0)

					if var_463_0.name == "" or not string.find(var_463_0.name, "split") then
						var_463_0.gameObject:SetActive(true)
					else
						var_463_0.gameObject:SetActive(false)
					end
				end
			end

			local var_463_1 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_1 then
				arg_460_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_460_1.time_ - 0) / var_463_1)
			end

			if arg_460_1.time_ >= 0 + var_463_1 and arg_460_1.time_ < 0 + var_463_1 + arg_463_0 then
				arg_460_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_463_2 = arg_460_1.actors_["10093"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_2) and arg_460_1.var_.actorSpriteComps10093 == nil then
				arg_460_1.var_.actorSpriteComps10093 = var_463_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_3 = 2

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_3 and not isNil(var_463_2) then
				if arg_460_1.var_.actorSpriteComps10093 then
					for iter_463_1, iter_463_2 in pairs(arg_460_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_463_2 then
							if arg_460_1.isInRecall_ then
								iter_463_2.color = Color.New(Mathf.Lerp(iter_463_2.color.r, arg_460_1.hightColor1.r, (arg_460_1.time_ - 0) / var_463_3), Mathf.Lerp(iter_463_2.color.g, arg_460_1.hightColor1.g, (arg_460_1.time_ - 0) / var_463_3), (Mathf.Lerp(iter_463_2.color.b, arg_460_1.hightColor1.b, (arg_460_1.time_ - 0) / var_463_3)))
							else
								local var_463_4 = Mathf.Lerp(iter_463_2.color.r, 1, (arg_460_1.time_ - 0) / var_463_3)

								iter_463_2.color = Color.New(var_463_4, var_463_4, var_463_4)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= 0 + var_463_3 and arg_460_1.time_ < 0 + var_463_3 + arg_463_0 and not isNil(var_463_2) and arg_460_1.var_.actorSpriteComps10093 then
				for iter_463_3, iter_463_4 in pairs(arg_460_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_463_4 then
						iter_463_4.color = arg_460_1.isInRecall_ and (arg_460_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_460_1.var_.actorSpriteComps10093 = nil
			end

			local var_463_5 = arg_460_1.actors_["10092"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_5) and arg_460_1.var_.actorSpriteComps10092 == nil then
				arg_460_1.var_.actorSpriteComps10092 = var_463_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_6 = 2

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_6 and not isNil(var_463_5) then
				if arg_460_1.var_.actorSpriteComps10092 then
					for iter_463_5, iter_463_6 in pairs(arg_460_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_463_6 then
							if arg_460_1.isInRecall_ then
								iter_463_6.color = Color.New(Mathf.Lerp(iter_463_6.color.r, arg_460_1.hightColor2.r, (arg_460_1.time_ - 0) / var_463_6), Mathf.Lerp(iter_463_6.color.g, arg_460_1.hightColor2.g, (arg_460_1.time_ - 0) / var_463_6), (Mathf.Lerp(iter_463_6.color.b, arg_460_1.hightColor2.b, (arg_460_1.time_ - 0) / var_463_6)))
							else
								local var_463_7 = Mathf.Lerp(iter_463_6.color.r, 0.5, (arg_460_1.time_ - 0) / var_463_6)

								iter_463_6.color = Color.New(var_463_7, var_463_7, var_463_7)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= 0 + var_463_6 and arg_460_1.time_ < 0 + var_463_6 + arg_463_0 and not isNil(var_463_5) and arg_460_1.var_.actorSpriteComps10092 then
				for iter_463_7, iter_463_8 in pairs(arg_460_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_463_8 then
						iter_463_8.color = arg_460_1.isInRecall_ and (arg_460_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_460_1.var_.actorSpriteComps10092 = nil
			end

			local var_463_8 = 0
			local var_463_9 = 0.1

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_8 + arg_463_0 then
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

				local var_463_10 = arg_460_1:GetWordFromCfg(413011112)
				local var_463_11 = arg_460_1:FormatText(var_463_10.content)

				arg_460_1.text_.text = var_463_11

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_13 = 4 <= 0 and var_463_9 or var_463_9 * (utf8.len(var_463_11) / 4)

				if (4 <= 0 and var_463_9 or var_463_9 * (utf8.len(var_463_11) / 4)) > 0 and var_463_9 < var_463_13 then
					arg_460_1.talkMaxDuration = var_463_13

					if var_463_13 + var_463_8 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_13 + var_463_8
					end
				end

				arg_460_1.text_.text = var_463_11
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011112", "story_v_out_413011.awb") ~= 0 then
					local var_463_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011112", "story_v_out_413011.awb") / 1000

					if var_463_14 + var_463_8 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_14 + var_463_8
					end

					if var_463_10.prefab_name ~= "" and arg_460_1.actors_[var_463_10.prefab_name] ~= nil then
						local var_463_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_10.prefab_name].transform, "story_v_out_413011", "413011112", "story_v_out_413011.awb")

						arg_460_1:RecordAudio("413011112", var_463_15)
						arg_460_1:RecordAudio("413011112", var_463_15)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_413011", "413011112", "story_v_out_413011.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_413011", "413011112", "story_v_out_413011.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_16 = math.max(var_463_9, arg_460_1.talkMaxDuration)

			if var_463_8 <= arg_460_1.time_ and arg_460_1.time_ < var_463_8 + var_463_16 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_8) / var_463_16

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_8 + var_463_16 and arg_460_1.time_ < var_463_8 + var_463_16 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
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

		arg_460_1:InitPlayNodeList()
	end,
	Play413011113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 413011113
		arg_464_1.duration_ = 12.77

		local var_464_0 = {
			zh = 7,
			ja = 12.766
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
				arg_464_0:Play413011114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["10093"]) and arg_464_1.var_.actorSpriteComps10093 == nil then
				arg_464_1.var_.actorSpriteComps10093 = arg_464_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_0 = 2

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["10093"]) then
				if arg_464_1.var_.actorSpriteComps10093 then
					for iter_467_0, iter_467_1 in pairs(arg_464_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_467_1 then
							if arg_464_1.isInRecall_ then
								iter_467_1.color = Color.New(Mathf.Lerp(iter_467_1.color.r, arg_464_1.hightColor2.r, (arg_464_1.time_ - 0) / var_467_0), Mathf.Lerp(iter_467_1.color.g, arg_464_1.hightColor2.g, (arg_464_1.time_ - 0) / var_467_0), (Mathf.Lerp(iter_467_1.color.b, arg_464_1.hightColor2.b, (arg_464_1.time_ - 0) / var_467_0)))
							else
								local var_467_1 = Mathf.Lerp(iter_467_1.color.r, 0.5, (arg_464_1.time_ - 0) / var_467_0)

								iter_467_1.color = Color.New(var_467_1, var_467_1, var_467_1)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["10093"]) and arg_464_1.var_.actorSpriteComps10093 then
				for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_467_3 then
						iter_467_3.color = arg_464_1.isInRecall_ and (arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_464_1.var_.actorSpriteComps10093 = nil
			end

			local var_467_2 = arg_464_1.actors_["10092"]

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(var_467_2) and arg_464_1.var_.actorSpriteComps10092 == nil then
				arg_464_1.var_.actorSpriteComps10092 = var_467_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_3 = 2

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_3 and not isNil(var_467_2) then
				if arg_464_1.var_.actorSpriteComps10092 then
					for iter_467_4, iter_467_5 in pairs(arg_464_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_467_5 then
							if arg_464_1.isInRecall_ then
								iter_467_5.color = Color.New(Mathf.Lerp(iter_467_5.color.r, arg_464_1.hightColor1.r, (arg_464_1.time_ - 0) / var_467_3), Mathf.Lerp(iter_467_5.color.g, arg_464_1.hightColor1.g, (arg_464_1.time_ - 0) / var_467_3), (Mathf.Lerp(iter_467_5.color.b, arg_464_1.hightColor1.b, (arg_464_1.time_ - 0) / var_467_3)))
							else
								local var_467_4 = Mathf.Lerp(iter_467_5.color.r, 1, (arg_464_1.time_ - 0) / var_467_3)

								iter_467_5.color = Color.New(var_467_4, var_467_4, var_467_4)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= 0 + var_467_3 and arg_464_1.time_ < 0 + var_467_3 + arg_467_0 and not isNil(var_467_2) and arg_464_1.var_.actorSpriteComps10092 then
				for iter_467_6, iter_467_7 in pairs(arg_464_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_467_7 then
						iter_467_7.color = arg_464_1.isInRecall_ and (arg_464_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_464_1.var_.actorSpriteComps10092 = nil
			end

			local var_467_5 = 0
			local var_467_6 = 0.9

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_5 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_7 = arg_464_1:GetWordFromCfg(413011113)
				local var_467_8 = arg_464_1:FormatText(var_467_7.content)

				arg_464_1.text_.text = var_467_8

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_10 = 36 <= 0 and var_467_6 or var_467_6 * (utf8.len(var_467_8) / 36)

				if (36 <= 0 and var_467_6 or var_467_6 * (utf8.len(var_467_8) / 36)) > 0 and var_467_6 < var_467_10 then
					arg_464_1.talkMaxDuration = var_467_10

					if var_467_10 + var_467_5 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_10 + var_467_5
					end
				end

				arg_464_1.text_.text = var_467_8
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011113", "story_v_out_413011.awb") ~= 0 then
					local var_467_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011113", "story_v_out_413011.awb") / 1000

					if var_467_11 + var_467_5 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_11 + var_467_5
					end

					if var_467_7.prefab_name ~= "" and arg_464_1.actors_[var_467_7.prefab_name] ~= nil then
						local var_467_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_7.prefab_name].transform, "story_v_out_413011", "413011113", "story_v_out_413011.awb")

						arg_464_1:RecordAudio("413011113", var_467_12)
						arg_464_1:RecordAudio("413011113", var_467_12)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_413011", "413011113", "story_v_out_413011.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_413011", "413011113", "story_v_out_413011.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_13 = math.max(var_467_6, arg_464_1.talkMaxDuration)

			if var_467_5 <= arg_464_1.time_ and arg_464_1.time_ < var_467_5 + var_467_13 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_5) / var_467_13

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_5 + var_467_13 and arg_464_1.time_ < var_467_5 + var_467_13 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play413011114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 413011114
		arg_468_1.duration_ = 4.43

		local var_468_0 = {
			zh = 4.433,
			ja = 2.133
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
				arg_468_0:Play413011115(arg_468_1)
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

			local var_471_2 = arg_468_1.actors_["10092"]

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(var_471_2) and arg_468_1.var_.actorSpriteComps10092 == nil then
				arg_468_1.var_.actorSpriteComps10092 = var_471_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_471_3 = 2

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_3 and not isNil(var_471_2) then
				if arg_468_1.var_.actorSpriteComps10092 then
					for iter_471_4, iter_471_5 in pairs(arg_468_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_468_1.time_ >= 0 + var_471_3 and arg_468_1.time_ < 0 + var_471_3 + arg_471_0 and not isNil(var_471_2) and arg_468_1.var_.actorSpriteComps10092 then
				for iter_471_6, iter_471_7 in pairs(arg_468_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_471_7 then
						iter_471_7.color = arg_468_1.isInRecall_ and (arg_468_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_468_1.var_.actorSpriteComps10092 = nil
			end

			local var_471_5 = 0
			local var_471_6 = 0.525

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

				local var_471_7 = arg_468_1:GetWordFromCfg(413011114)
				local var_471_8 = arg_468_1:FormatText(var_471_7.content)

				arg_468_1.text_.text = var_471_8

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_10 = 21 <= 0 and var_471_6 or var_471_6 * (utf8.len(var_471_8) / 21)

				if (21 <= 0 and var_471_6 or var_471_6 * (utf8.len(var_471_8) / 21)) > 0 and var_471_6 < var_471_10 then
					arg_468_1.talkMaxDuration = var_471_10

					if var_471_10 + var_471_5 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_10 + var_471_5
					end
				end

				arg_468_1.text_.text = var_471_8
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011114", "story_v_out_413011.awb") ~= 0 then
					local var_471_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011114", "story_v_out_413011.awb") / 1000

					if var_471_11 + var_471_5 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_11 + var_471_5
					end

					if var_471_7.prefab_name ~= "" and arg_468_1.actors_[var_471_7.prefab_name] ~= nil then
						local var_471_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_7.prefab_name].transform, "story_v_out_413011", "413011114", "story_v_out_413011.awb")

						arg_468_1:RecordAudio("413011114", var_471_12)
						arg_468_1:RecordAudio("413011114", var_471_12)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_413011", "413011114", "story_v_out_413011.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_413011", "413011114", "story_v_out_413011.awb")
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
	Play413011115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 413011115
		arg_472_1.duration_ = 11.6

		local var_472_0 = {
			zh = 6.9,
			ja = 11.6
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
				arg_472_0:Play413011116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0.95

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
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

				local var_475_1 = arg_472_1:GetWordFromCfg(413011115)
				local var_475_2 = arg_472_1:FormatText(var_475_1.content)

				arg_472_1.text_.text = var_475_2

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_4 = 38 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_2) / 38)

				if (38 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_2) / 38)) > 0 and var_475_0 < var_475_4 then
					arg_472_1.talkMaxDuration = var_475_4

					if var_475_4 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_4 + 0
					end
				end

				arg_472_1.text_.text = var_475_2
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011115", "story_v_out_413011.awb") ~= 0 then
					local var_475_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011115", "story_v_out_413011.awb") / 1000

					if var_475_5 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_5 + 0
					end

					if var_475_1.prefab_name ~= "" and arg_472_1.actors_[var_475_1.prefab_name] ~= nil then
						local var_475_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_1.prefab_name].transform, "story_v_out_413011", "413011115", "story_v_out_413011.awb")

						arg_472_1:RecordAudio("413011115", var_475_6)
						arg_472_1:RecordAudio("413011115", var_475_6)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_413011", "413011115", "story_v_out_413011.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_413011", "413011115", "story_v_out_413011.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_7 = math.max(var_475_0, arg_472_1.talkMaxDuration)

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_7 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - 0) / var_475_7

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= 0 + var_475_7 and arg_472_1.time_ < 0 + var_475_7 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play413011116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 413011116
		arg_476_1.duration_ = 3.73

		local var_476_0 = {
			zh = 1.999999999999,
			ja = 3.733
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
				arg_476_0:Play413011117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.var_.moveOldPos10092 = arg_476_1.actors_["10092"].transform.localPosition
				arg_476_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_476_1:CheckSpriteTmpPos("10092", 2)

				for iter_479_0 = 0, arg_476_1.actors_["10092"].transform.childCount - 1 do
					local var_479_0 = arg_476_1.actors_["10092"].transform:GetChild(iter_479_0)

					if var_479_0.name == "split_5" or not string.find(var_479_0.name, "split") then
						var_479_0.gameObject:SetActive(true)
					else
						var_479_0.gameObject:SetActive(false)
					end
				end
			end

			local var_479_1 = 0.001

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_1 then
				arg_476_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_476_1.time_ - 0) / var_479_1)
			end

			if arg_476_1.time_ >= 0 + var_479_1 and arg_476_1.time_ < 0 + var_479_1 + arg_479_0 then
				arg_476_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_479_2 = arg_476_1.actors_["10093"]

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(var_479_2) and arg_476_1.var_.actorSpriteComps10093 == nil then
				arg_476_1.var_.actorSpriteComps10093 = var_479_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_479_3 = 2

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_3 and not isNil(var_479_2) then
				if arg_476_1.var_.actorSpriteComps10093 then
					for iter_479_1, iter_479_2 in pairs(arg_476_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_479_2 then
							if arg_476_1.isInRecall_ then
								iter_479_2.color = Color.New(Mathf.Lerp(iter_479_2.color.r, arg_476_1.hightColor2.r, (arg_476_1.time_ - 0) / var_479_3), Mathf.Lerp(iter_479_2.color.g, arg_476_1.hightColor2.g, (arg_476_1.time_ - 0) / var_479_3), (Mathf.Lerp(iter_479_2.color.b, arg_476_1.hightColor2.b, (arg_476_1.time_ - 0) / var_479_3)))
							else
								local var_479_4 = Mathf.Lerp(iter_479_2.color.r, 0.5, (arg_476_1.time_ - 0) / var_479_3)

								iter_479_2.color = Color.New(var_479_4, var_479_4, var_479_4)
							end
						end
					end
				end
			end

			if arg_476_1.time_ >= 0 + var_479_3 and arg_476_1.time_ < 0 + var_479_3 + arg_479_0 and not isNil(var_479_2) and arg_476_1.var_.actorSpriteComps10093 then
				for iter_479_3, iter_479_4 in pairs(arg_476_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_479_4 then
						iter_479_4.color = arg_476_1.isInRecall_ and (arg_476_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_476_1.var_.actorSpriteComps10093 = nil
			end

			local var_479_5 = arg_476_1.actors_["10092"]

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(var_479_5) and arg_476_1.var_.actorSpriteComps10092 == nil then
				arg_476_1.var_.actorSpriteComps10092 = var_479_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_479_6 = 2

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_6 and not isNil(var_479_5) then
				if arg_476_1.var_.actorSpriteComps10092 then
					for iter_479_5, iter_479_6 in pairs(arg_476_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_479_6 then
							if arg_476_1.isInRecall_ then
								iter_479_6.color = Color.New(Mathf.Lerp(iter_479_6.color.r, arg_476_1.hightColor1.r, (arg_476_1.time_ - 0) / var_479_6), Mathf.Lerp(iter_479_6.color.g, arg_476_1.hightColor1.g, (arg_476_1.time_ - 0) / var_479_6), (Mathf.Lerp(iter_479_6.color.b, arg_476_1.hightColor1.b, (arg_476_1.time_ - 0) / var_479_6)))
							else
								local var_479_7 = Mathf.Lerp(iter_479_6.color.r, 1, (arg_476_1.time_ - 0) / var_479_6)

								iter_479_6.color = Color.New(var_479_7, var_479_7, var_479_7)
							end
						end
					end
				end
			end

			if arg_476_1.time_ >= 0 + var_479_6 and arg_476_1.time_ < 0 + var_479_6 + arg_479_0 and not isNil(var_479_5) and arg_476_1.var_.actorSpriteComps10092 then
				for iter_479_7, iter_479_8 in pairs(arg_476_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_479_8 then
						iter_479_8.color = arg_476_1.isInRecall_ and (arg_476_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_476_1.var_.actorSpriteComps10092 = nil
			end

			local var_479_8 = 0
			local var_479_9 = 0.15

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_8 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_10 = arg_476_1:GetWordFromCfg(413011116)
				local var_479_11 = arg_476_1:FormatText(var_479_10.content)

				arg_476_1.text_.text = var_479_11

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_13 = 6 <= 0 and var_479_9 or var_479_9 * (utf8.len(var_479_11) / 6)

				if (6 <= 0 and var_479_9 or var_479_9 * (utf8.len(var_479_11) / 6)) > 0 and var_479_9 < var_479_13 then
					arg_476_1.talkMaxDuration = var_479_13

					if var_479_13 + var_479_8 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_13 + var_479_8
					end
				end

				arg_476_1.text_.text = var_479_11
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011116", "story_v_out_413011.awb") ~= 0 then
					local var_479_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011116", "story_v_out_413011.awb") / 1000

					if var_479_14 + var_479_8 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_14 + var_479_8
					end

					if var_479_10.prefab_name ~= "" and arg_476_1.actors_[var_479_10.prefab_name] ~= nil then
						local var_479_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_10.prefab_name].transform, "story_v_out_413011", "413011116", "story_v_out_413011.awb")

						arg_476_1:RecordAudio("413011116", var_479_15)
						arg_476_1:RecordAudio("413011116", var_479_15)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_out_413011", "413011116", "story_v_out_413011.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_out_413011", "413011116", "story_v_out_413011.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_16 = math.max(var_479_9, arg_476_1.talkMaxDuration)

			if var_479_8 <= arg_476_1.time_ and arg_476_1.time_ < var_479_8 + var_479_16 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_8) / var_479_16

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_8 + var_479_16 and arg_476_1.time_ < var_479_8 + var_479_16 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
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

		arg_476_1:InitPlayNodeList()
	end,
	Play413011117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 413011117
		arg_480_1.duration_ = 2

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play413011118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(arg_480_1.actors_["10093"]) and arg_480_1.var_.actorSpriteComps10093 == nil then
				arg_480_1.var_.actorSpriteComps10093 = arg_480_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_0 = 2

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 and not isNil(arg_480_1.actors_["10093"]) then
				if arg_480_1.var_.actorSpriteComps10093 then
					for iter_483_0, iter_483_1 in pairs(arg_480_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_483_1 then
							if arg_480_1.isInRecall_ then
								iter_483_1.color = Color.New(Mathf.Lerp(iter_483_1.color.r, arg_480_1.hightColor1.r, (arg_480_1.time_ - 0) / var_483_0), Mathf.Lerp(iter_483_1.color.g, arg_480_1.hightColor1.g, (arg_480_1.time_ - 0) / var_483_0), (Mathf.Lerp(iter_483_1.color.b, arg_480_1.hightColor1.b, (arg_480_1.time_ - 0) / var_483_0)))
							else
								local var_483_1 = Mathf.Lerp(iter_483_1.color.r, 1, (arg_480_1.time_ - 0) / var_483_0)

								iter_483_1.color = Color.New(var_483_1, var_483_1, var_483_1)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 and not isNil(arg_480_1.actors_["10093"]) and arg_480_1.var_.actorSpriteComps10093 then
				for iter_483_2, iter_483_3 in pairs(arg_480_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_483_3 then
						iter_483_3.color = arg_480_1.isInRecall_ and (arg_480_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_480_1.var_.actorSpriteComps10093 = nil
			end

			local var_483_2 = arg_480_1.actors_["10092"]

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(var_483_2) and arg_480_1.var_.actorSpriteComps10092 == nil then
				arg_480_1.var_.actorSpriteComps10092 = var_483_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_3 = 2

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_3 and not isNil(var_483_2) then
				if arg_480_1.var_.actorSpriteComps10092 then
					for iter_483_4, iter_483_5 in pairs(arg_480_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_483_5 then
							if arg_480_1.isInRecall_ then
								iter_483_5.color = Color.New(Mathf.Lerp(iter_483_5.color.r, arg_480_1.hightColor2.r, (arg_480_1.time_ - 0) / var_483_3), Mathf.Lerp(iter_483_5.color.g, arg_480_1.hightColor2.g, (arg_480_1.time_ - 0) / var_483_3), (Mathf.Lerp(iter_483_5.color.b, arg_480_1.hightColor2.b, (arg_480_1.time_ - 0) / var_483_3)))
							else
								local var_483_4 = Mathf.Lerp(iter_483_5.color.r, 0.5, (arg_480_1.time_ - 0) / var_483_3)

								iter_483_5.color = Color.New(var_483_4, var_483_4, var_483_4)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= 0 + var_483_3 and arg_480_1.time_ < 0 + var_483_3 + arg_483_0 and not isNil(var_483_2) and arg_480_1.var_.actorSpriteComps10092 then
				for iter_483_6, iter_483_7 in pairs(arg_480_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_483_7 then
						iter_483_7.color = arg_480_1.isInRecall_ and (arg_480_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_480_1.var_.actorSpriteComps10092 = nil
			end

			local var_483_5 = 0
			local var_483_6 = 0.05

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_5 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_7 = arg_480_1:GetWordFromCfg(413011117)
				local var_483_8 = arg_480_1:FormatText(var_483_7.content)

				arg_480_1.text_.text = var_483_8

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_10 = 2 <= 0 and var_483_6 or var_483_6 * (utf8.len(var_483_8) / 2)

				if (2 <= 0 and var_483_6 or var_483_6 * (utf8.len(var_483_8) / 2)) > 0 and var_483_6 < var_483_10 then
					arg_480_1.talkMaxDuration = var_483_10

					if var_483_10 + var_483_5 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_10 + var_483_5
					end
				end

				arg_480_1.text_.text = var_483_8
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011117", "story_v_out_413011.awb") ~= 0 then
					local var_483_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011117", "story_v_out_413011.awb") / 1000

					if var_483_11 + var_483_5 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_11 + var_483_5
					end

					if var_483_7.prefab_name ~= "" and arg_480_1.actors_[var_483_7.prefab_name] ~= nil then
						local var_483_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_7.prefab_name].transform, "story_v_out_413011", "413011117", "story_v_out_413011.awb")

						arg_480_1:RecordAudio("413011117", var_483_12)
						arg_480_1:RecordAudio("413011117", var_483_12)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_413011", "413011117", "story_v_out_413011.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_413011", "413011117", "story_v_out_413011.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_13 = math.max(var_483_6, arg_480_1.talkMaxDuration)

			if var_483_5 <= arg_480_1.time_ and arg_480_1.time_ < var_483_5 + var_483_13 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_5) / var_483_13

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_5 + var_483_13 and arg_480_1.time_ < var_483_5 + var_483_13 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play413011118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 413011118
		arg_484_1.duration_ = 2.9

		local var_484_0 = {
			zh = 2.866,
			ja = 2.9
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
				arg_484_0:Play413011119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(arg_484_1.actors_["10093"]) and arg_484_1.var_.actorSpriteComps10093 == nil then
				arg_484_1.var_.actorSpriteComps10093 = arg_484_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_487_0 = 2

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_0 and not isNil(arg_484_1.actors_["10093"]) then
				if arg_484_1.var_.actorSpriteComps10093 then
					for iter_487_0, iter_487_1 in pairs(arg_484_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_487_1 then
							if arg_484_1.isInRecall_ then
								iter_487_1.color = Color.New(Mathf.Lerp(iter_487_1.color.r, arg_484_1.hightColor2.r, (arg_484_1.time_ - 0) / var_487_0), Mathf.Lerp(iter_487_1.color.g, arg_484_1.hightColor2.g, (arg_484_1.time_ - 0) / var_487_0), (Mathf.Lerp(iter_487_1.color.b, arg_484_1.hightColor2.b, (arg_484_1.time_ - 0) / var_487_0)))
							else
								local var_487_1 = Mathf.Lerp(iter_487_1.color.r, 0.5, (arg_484_1.time_ - 0) / var_487_0)

								iter_487_1.color = Color.New(var_487_1, var_487_1, var_487_1)
							end
						end
					end
				end
			end

			if arg_484_1.time_ >= 0 + var_487_0 and arg_484_1.time_ < 0 + var_487_0 + arg_487_0 and not isNil(arg_484_1.actors_["10093"]) and arg_484_1.var_.actorSpriteComps10093 then
				for iter_487_2, iter_487_3 in pairs(arg_484_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_487_3 then
						iter_487_3.color = arg_484_1.isInRecall_ and (arg_484_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_484_1.var_.actorSpriteComps10093 = nil
			end

			local var_487_2 = arg_484_1.actors_["10092"]

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(var_487_2) and arg_484_1.var_.actorSpriteComps10092 == nil then
				arg_484_1.var_.actorSpriteComps10092 = var_487_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_487_3 = 2

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_3 and not isNil(var_487_2) then
				if arg_484_1.var_.actorSpriteComps10092 then
					for iter_487_4, iter_487_5 in pairs(arg_484_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_487_5 then
							if arg_484_1.isInRecall_ then
								iter_487_5.color = Color.New(Mathf.Lerp(iter_487_5.color.r, arg_484_1.hightColor1.r, (arg_484_1.time_ - 0) / var_487_3), Mathf.Lerp(iter_487_5.color.g, arg_484_1.hightColor1.g, (arg_484_1.time_ - 0) / var_487_3), (Mathf.Lerp(iter_487_5.color.b, arg_484_1.hightColor1.b, (arg_484_1.time_ - 0) / var_487_3)))
							else
								local var_487_4 = Mathf.Lerp(iter_487_5.color.r, 1, (arg_484_1.time_ - 0) / var_487_3)

								iter_487_5.color = Color.New(var_487_4, var_487_4, var_487_4)
							end
						end
					end
				end
			end

			if arg_484_1.time_ >= 0 + var_487_3 and arg_484_1.time_ < 0 + var_487_3 + arg_487_0 and not isNil(var_487_2) and arg_484_1.var_.actorSpriteComps10092 then
				for iter_487_6, iter_487_7 in pairs(arg_484_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_487_7 then
						iter_487_7.color = arg_484_1.isInRecall_ and (arg_484_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_484_1.var_.actorSpriteComps10092 = nil
			end

			local var_487_5 = 0
			local var_487_6 = 0.3

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_5 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_7 = arg_484_1:GetWordFromCfg(413011118)
				local var_487_8 = arg_484_1:FormatText(var_487_7.content)

				arg_484_1.text_.text = var_487_8

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_10 = 12 <= 0 and var_487_6 or var_487_6 * (utf8.len(var_487_8) / 12)

				if (12 <= 0 and var_487_6 or var_487_6 * (utf8.len(var_487_8) / 12)) > 0 and var_487_6 < var_487_10 then
					arg_484_1.talkMaxDuration = var_487_10

					if var_487_10 + var_487_5 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_10 + var_487_5
					end
				end

				arg_484_1.text_.text = var_487_8
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011118", "story_v_out_413011.awb") ~= 0 then
					local var_487_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011118", "story_v_out_413011.awb") / 1000

					if var_487_11 + var_487_5 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_11 + var_487_5
					end

					if var_487_7.prefab_name ~= "" and arg_484_1.actors_[var_487_7.prefab_name] ~= nil then
						local var_487_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_7.prefab_name].transform, "story_v_out_413011", "413011118", "story_v_out_413011.awb")

						arg_484_1:RecordAudio("413011118", var_487_12)
						arg_484_1:RecordAudio("413011118", var_487_12)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_413011", "413011118", "story_v_out_413011.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_413011", "413011118", "story_v_out_413011.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_13 = math.max(var_487_6, arg_484_1.talkMaxDuration)

			if var_487_5 <= arg_484_1.time_ and arg_484_1.time_ < var_487_5 + var_487_13 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_5) / var_487_13

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_5 + var_487_13 and arg_484_1.time_ < var_487_5 + var_487_13 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play413011119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 413011119
		arg_488_1.duration_ = 3.6

		local var_488_0 = {
			zh = 2.766,
			ja = 3.6
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
				arg_488_0:Play413011120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(arg_488_1.actors_["10093"]) and arg_488_1.var_.actorSpriteComps10093 == nil then
				arg_488_1.var_.actorSpriteComps10093 = arg_488_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_491_0 = 2

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 and not isNil(arg_488_1.actors_["10093"]) then
				if arg_488_1.var_.actorSpriteComps10093 then
					for iter_491_0, iter_491_1 in pairs(arg_488_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_491_1 then
							if arg_488_1.isInRecall_ then
								iter_491_1.color = Color.New(Mathf.Lerp(iter_491_1.color.r, arg_488_1.hightColor1.r, (arg_488_1.time_ - 0) / var_491_0), Mathf.Lerp(iter_491_1.color.g, arg_488_1.hightColor1.g, (arg_488_1.time_ - 0) / var_491_0), (Mathf.Lerp(iter_491_1.color.b, arg_488_1.hightColor1.b, (arg_488_1.time_ - 0) / var_491_0)))
							else
								local var_491_1 = Mathf.Lerp(iter_491_1.color.r, 1, (arg_488_1.time_ - 0) / var_491_0)

								iter_491_1.color = Color.New(var_491_1, var_491_1, var_491_1)
							end
						end
					end
				end
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 and not isNil(arg_488_1.actors_["10093"]) and arg_488_1.var_.actorSpriteComps10093 then
				for iter_491_2, iter_491_3 in pairs(arg_488_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_491_3 then
						iter_491_3.color = arg_488_1.isInRecall_ and (arg_488_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_488_1.var_.actorSpriteComps10093 = nil
			end

			local var_491_2 = arg_488_1.actors_["10092"]

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(var_491_2) and arg_488_1.var_.actorSpriteComps10092 == nil then
				arg_488_1.var_.actorSpriteComps10092 = var_491_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_491_3 = 2

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_3 and not isNil(var_491_2) then
				if arg_488_1.var_.actorSpriteComps10092 then
					for iter_491_4, iter_491_5 in pairs(arg_488_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_491_5 then
							if arg_488_1.isInRecall_ then
								iter_491_5.color = Color.New(Mathf.Lerp(iter_491_5.color.r, arg_488_1.hightColor2.r, (arg_488_1.time_ - 0) / var_491_3), Mathf.Lerp(iter_491_5.color.g, arg_488_1.hightColor2.g, (arg_488_1.time_ - 0) / var_491_3), (Mathf.Lerp(iter_491_5.color.b, arg_488_1.hightColor2.b, (arg_488_1.time_ - 0) / var_491_3)))
							else
								local var_491_4 = Mathf.Lerp(iter_491_5.color.r, 0.5, (arg_488_1.time_ - 0) / var_491_3)

								iter_491_5.color = Color.New(var_491_4, var_491_4, var_491_4)
							end
						end
					end
				end
			end

			if arg_488_1.time_ >= 0 + var_491_3 and arg_488_1.time_ < 0 + var_491_3 + arg_491_0 and not isNil(var_491_2) and arg_488_1.var_.actorSpriteComps10092 then
				for iter_491_6, iter_491_7 in pairs(arg_488_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_491_7 then
						iter_491_7.color = arg_488_1.isInRecall_ and (arg_488_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_488_1.var_.actorSpriteComps10092 = nil
			end

			local var_491_5 = 0
			local var_491_6 = 0.175

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_5 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_7 = arg_488_1:GetWordFromCfg(413011119)
				local var_491_8 = arg_488_1:FormatText(var_491_7.content)

				arg_488_1.text_.text = var_491_8

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_10 = 7 <= 0 and var_491_6 or var_491_6 * (utf8.len(var_491_8) / 7)

				if (7 <= 0 and var_491_6 or var_491_6 * (utf8.len(var_491_8) / 7)) > 0 and var_491_6 < var_491_10 then
					arg_488_1.talkMaxDuration = var_491_10

					if var_491_10 + var_491_5 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_10 + var_491_5
					end
				end

				arg_488_1.text_.text = var_491_8
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011119", "story_v_out_413011.awb") ~= 0 then
					local var_491_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011119", "story_v_out_413011.awb") / 1000

					if var_491_11 + var_491_5 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_11 + var_491_5
					end

					if var_491_7.prefab_name ~= "" and arg_488_1.actors_[var_491_7.prefab_name] ~= nil then
						local var_491_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_7.prefab_name].transform, "story_v_out_413011", "413011119", "story_v_out_413011.awb")

						arg_488_1:RecordAudio("413011119", var_491_12)
						arg_488_1:RecordAudio("413011119", var_491_12)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_413011", "413011119", "story_v_out_413011.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_413011", "413011119", "story_v_out_413011.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_13 = math.max(var_491_6, arg_488_1.talkMaxDuration)

			if var_491_5 <= arg_488_1.time_ and arg_488_1.time_ < var_491_5 + var_491_13 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_5) / var_491_13

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_5 + var_491_13 and arg_488_1.time_ < var_491_5 + var_491_13 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play413011120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 413011120
		arg_492_1.duration_ = 5.03

		local var_492_0 = {
			zh = 4.533,
			ja = 5.033
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
				arg_492_0:Play413011121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos10092 = arg_492_1.actors_["10092"].transform.localPosition
				arg_492_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_492_1:CheckSpriteTmpPos("10092", 2)

				for iter_495_0 = 0, arg_492_1.actors_["10092"].transform.childCount - 1 do
					local var_495_0 = arg_492_1.actors_["10092"].transform:GetChild(iter_495_0)

					if var_495_0.name == "" or not string.find(var_495_0.name, "split") then
						var_495_0.gameObject:SetActive(true)
					else
						var_495_0.gameObject:SetActive(false)
					end
				end
			end

			local var_495_1 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_1 then
				arg_492_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_492_1.time_ - 0) / var_495_1)
			end

			if arg_492_1.time_ >= 0 + var_495_1 and arg_492_1.time_ < 0 + var_495_1 + arg_495_0 then
				arg_492_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
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
								iter_495_2.color = Color.New(Mathf.Lerp(iter_495_2.color.r, arg_492_1.hightColor2.r, (arg_492_1.time_ - 0) / var_495_3), Mathf.Lerp(iter_495_2.color.g, arg_492_1.hightColor2.g, (arg_492_1.time_ - 0) / var_495_3), (Mathf.Lerp(iter_495_2.color.b, arg_492_1.hightColor2.b, (arg_492_1.time_ - 0) / var_495_3)))
							else
								local var_495_4 = Mathf.Lerp(iter_495_2.color.r, 0.5, (arg_492_1.time_ - 0) / var_495_3)

								iter_495_2.color = Color.New(var_495_4, var_495_4, var_495_4)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= 0 + var_495_3 and arg_492_1.time_ < 0 + var_495_3 + arg_495_0 and not isNil(var_495_2) and arg_492_1.var_.actorSpriteComps10093 then
				for iter_495_3, iter_495_4 in pairs(arg_492_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_495_4 then
						iter_495_4.color = arg_492_1.isInRecall_ and (arg_492_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_492_1.var_.actorSpriteComps10093 = nil
			end

			local var_495_5 = arg_492_1.actors_["10092"]

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(var_495_5) and arg_492_1.var_.actorSpriteComps10092 == nil then
				arg_492_1.var_.actorSpriteComps10092 = var_495_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_495_6 = 2

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_6 and not isNil(var_495_5) then
				if arg_492_1.var_.actorSpriteComps10092 then
					for iter_495_5, iter_495_6 in pairs(arg_492_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_495_6 then
							if arg_492_1.isInRecall_ then
								iter_495_6.color = Color.New(Mathf.Lerp(iter_495_6.color.r, arg_492_1.hightColor1.r, (arg_492_1.time_ - 0) / var_495_6), Mathf.Lerp(iter_495_6.color.g, arg_492_1.hightColor1.g, (arg_492_1.time_ - 0) / var_495_6), (Mathf.Lerp(iter_495_6.color.b, arg_492_1.hightColor1.b, (arg_492_1.time_ - 0) / var_495_6)))
							else
								local var_495_7 = Mathf.Lerp(iter_495_6.color.r, 1, (arg_492_1.time_ - 0) / var_495_6)

								iter_495_6.color = Color.New(var_495_7, var_495_7, var_495_7)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= 0 + var_495_6 and arg_492_1.time_ < 0 + var_495_6 + arg_495_0 and not isNil(var_495_5) and arg_492_1.var_.actorSpriteComps10092 then
				for iter_495_7, iter_495_8 in pairs(arg_492_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_495_8 then
						iter_495_8.color = arg_492_1.isInRecall_ and (arg_492_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_492_1.var_.actorSpriteComps10092 = nil
			end

			local var_495_8 = 0
			local var_495_9 = 0.5

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_8 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_10 = arg_492_1:GetWordFromCfg(413011120)
				local var_495_11 = arg_492_1:FormatText(var_495_10.content)

				arg_492_1.text_.text = var_495_11

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_13 = 20 <= 0 and var_495_9 or var_495_9 * (utf8.len(var_495_11) / 20)

				if (20 <= 0 and var_495_9 or var_495_9 * (utf8.len(var_495_11) / 20)) > 0 and var_495_9 < var_495_13 then
					arg_492_1.talkMaxDuration = var_495_13

					if var_495_13 + var_495_8 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_13 + var_495_8
					end
				end

				arg_492_1.text_.text = var_495_11
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011120", "story_v_out_413011.awb") ~= 0 then
					local var_495_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011120", "story_v_out_413011.awb") / 1000

					if var_495_14 + var_495_8 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_14 + var_495_8
					end

					if var_495_10.prefab_name ~= "" and arg_492_1.actors_[var_495_10.prefab_name] ~= nil then
						local var_495_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_10.prefab_name].transform, "story_v_out_413011", "413011120", "story_v_out_413011.awb")

						arg_492_1:RecordAudio("413011120", var_495_15)
						arg_492_1:RecordAudio("413011120", var_495_15)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_413011", "413011120", "story_v_out_413011.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_413011", "413011120", "story_v_out_413011.awb")
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
				actorName = "10092",
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
	Play413011121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 413011121
		arg_496_1.duration_ = 10.17

		local var_496_0 = {
			zh = 5.433,
			ja = 10.166
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
				arg_496_0:Play413011122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0.625

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_1 = arg_496_1:GetWordFromCfg(413011121)
				local var_499_2 = arg_496_1:FormatText(var_499_1.content)

				arg_496_1.text_.text = var_499_2

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_4 = 25 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_2) / 25)

				if (25 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_2) / 25)) > 0 and var_499_0 < var_499_4 then
					arg_496_1.talkMaxDuration = var_499_4

					if var_499_4 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_4 + 0
					end
				end

				arg_496_1.text_.text = var_499_2
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011121", "story_v_out_413011.awb") ~= 0 then
					local var_499_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011121", "story_v_out_413011.awb") / 1000

					if var_499_5 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_5 + 0
					end

					if var_499_1.prefab_name ~= "" and arg_496_1.actors_[var_499_1.prefab_name] ~= nil then
						local var_499_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_1.prefab_name].transform, "story_v_out_413011", "413011121", "story_v_out_413011.awb")

						arg_496_1:RecordAudio("413011121", var_499_6)
						arg_496_1:RecordAudio("413011121", var_499_6)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_413011", "413011121", "story_v_out_413011.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_413011", "413011121", "story_v_out_413011.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_7 = math.max(var_499_0, arg_496_1.talkMaxDuration)

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_7 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - 0) / var_499_7

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= 0 + var_499_7 and arg_496_1.time_ < 0 + var_499_7 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play413011122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 413011122
		arg_500_1.duration_ = 5.87

		local var_500_0 = {
			zh = 5.866,
			ja = 3.066
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
				arg_500_0:Play413011123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.var_.moveOldPos10093 = arg_500_1.actors_["10093"].transform.localPosition
				arg_500_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_500_1:CheckSpriteTmpPos("10093", 4)

				for iter_503_0 = 0, arg_500_1.actors_["10093"].transform.childCount - 1 do
					local var_503_0 = arg_500_1.actors_["10093"].transform:GetChild(iter_503_0)

					if var_503_0.name == "split_4" or not string.find(var_503_0.name, "split") then
						var_503_0.gameObject:SetActive(true)
					else
						var_503_0.gameObject:SetActive(false)
					end
				end
			end

			local var_503_1 = 0.001

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_1 then
				arg_500_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_500_1.time_ - 0) / var_503_1)
			end

			if arg_500_1.time_ >= 0 + var_503_1 and arg_500_1.time_ < 0 + var_503_1 + arg_503_0 then
				arg_500_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_503_2 = arg_500_1.actors_["10093"]

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(var_503_2) and arg_500_1.var_.actorSpriteComps10093 == nil then
				arg_500_1.var_.actorSpriteComps10093 = var_503_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_503_3 = 2

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_3 and not isNil(var_503_2) then
				if arg_500_1.var_.actorSpriteComps10093 then
					for iter_503_1, iter_503_2 in pairs(arg_500_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_503_2 then
							if arg_500_1.isInRecall_ then
								iter_503_2.color = Color.New(Mathf.Lerp(iter_503_2.color.r, arg_500_1.hightColor1.r, (arg_500_1.time_ - 0) / var_503_3), Mathf.Lerp(iter_503_2.color.g, arg_500_1.hightColor1.g, (arg_500_1.time_ - 0) / var_503_3), (Mathf.Lerp(iter_503_2.color.b, arg_500_1.hightColor1.b, (arg_500_1.time_ - 0) / var_503_3)))
							else
								local var_503_4 = Mathf.Lerp(iter_503_2.color.r, 1, (arg_500_1.time_ - 0) / var_503_3)

								iter_503_2.color = Color.New(var_503_4, var_503_4, var_503_4)
							end
						end
					end
				end
			end

			if arg_500_1.time_ >= 0 + var_503_3 and arg_500_1.time_ < 0 + var_503_3 + arg_503_0 and not isNil(var_503_2) and arg_500_1.var_.actorSpriteComps10093 then
				for iter_503_3, iter_503_4 in pairs(arg_500_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_503_4 then
						iter_503_4.color = arg_500_1.isInRecall_ and (arg_500_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_500_1.var_.actorSpriteComps10093 = nil
			end

			local var_503_5 = arg_500_1.actors_["10092"]

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(var_503_5) and arg_500_1.var_.actorSpriteComps10092 == nil then
				arg_500_1.var_.actorSpriteComps10092 = var_503_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_503_6 = 2

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_6 and not isNil(var_503_5) then
				if arg_500_1.var_.actorSpriteComps10092 then
					for iter_503_5, iter_503_6 in pairs(arg_500_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_503_6 then
							if arg_500_1.isInRecall_ then
								iter_503_6.color = Color.New(Mathf.Lerp(iter_503_6.color.r, arg_500_1.hightColor2.r, (arg_500_1.time_ - 0) / var_503_6), Mathf.Lerp(iter_503_6.color.g, arg_500_1.hightColor2.g, (arg_500_1.time_ - 0) / var_503_6), (Mathf.Lerp(iter_503_6.color.b, arg_500_1.hightColor2.b, (arg_500_1.time_ - 0) / var_503_6)))
							else
								local var_503_7 = Mathf.Lerp(iter_503_6.color.r, 0.5, (arg_500_1.time_ - 0) / var_503_6)

								iter_503_6.color = Color.New(var_503_7, var_503_7, var_503_7)
							end
						end
					end
				end
			end

			if arg_500_1.time_ >= 0 + var_503_6 and arg_500_1.time_ < 0 + var_503_6 + arg_503_0 and not isNil(var_503_5) and arg_500_1.var_.actorSpriteComps10092 then
				for iter_503_7, iter_503_8 in pairs(arg_500_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_503_8 then
						iter_503_8.color = arg_500_1.isInRecall_ and (arg_500_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_500_1.var_.actorSpriteComps10092 = nil
			end

			local var_503_8 = 0
			local var_503_9 = 0.8

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_8 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_10 = arg_500_1:GetWordFromCfg(413011122)
				local var_503_11 = arg_500_1:FormatText(var_503_10.content)

				arg_500_1.text_.text = var_503_11

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_13 = 32 <= 0 and var_503_9 or var_503_9 * (utf8.len(var_503_11) / 32)

				if (32 <= 0 and var_503_9 or var_503_9 * (utf8.len(var_503_11) / 32)) > 0 and var_503_9 < var_503_13 then
					arg_500_1.talkMaxDuration = var_503_13

					if var_503_13 + var_503_8 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_13 + var_503_8
					end
				end

				arg_500_1.text_.text = var_503_11
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011122", "story_v_out_413011.awb") ~= 0 then
					local var_503_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011122", "story_v_out_413011.awb") / 1000

					if var_503_14 + var_503_8 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_14 + var_503_8
					end

					if var_503_10.prefab_name ~= "" and arg_500_1.actors_[var_503_10.prefab_name] ~= nil then
						local var_503_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_10.prefab_name].transform, "story_v_out_413011", "413011122", "story_v_out_413011.awb")

						arg_500_1:RecordAudio("413011122", var_503_15)
						arg_500_1:RecordAudio("413011122", var_503_15)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_413011", "413011122", "story_v_out_413011.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_413011", "413011122", "story_v_out_413011.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_16 = math.max(var_503_9, arg_500_1.talkMaxDuration)

			if var_503_8 <= arg_500_1.time_ and arg_500_1.time_ < var_503_8 + var_503_16 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_8) / var_503_16

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_8 + var_503_16 and arg_500_1.time_ < var_503_8 + var_503_16 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
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

		arg_500_1:InitPlayNodeList()
	end,
	Play413011123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 413011123
		arg_504_1.duration_ = 11.23

		local var_504_0 = {
			zh = 7.766,
			ja = 11.233
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
				arg_504_0:Play413011124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(arg_504_1.actors_["10093"]) and arg_504_1.var_.actorSpriteComps10093 == nil then
				arg_504_1.var_.actorSpriteComps10093 = arg_504_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_507_0 = 2

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_0 and not isNil(arg_504_1.actors_["10093"]) then
				if arg_504_1.var_.actorSpriteComps10093 then
					for iter_507_0, iter_507_1 in pairs(arg_504_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_507_1 then
							if arg_504_1.isInRecall_ then
								iter_507_1.color = Color.New(Mathf.Lerp(iter_507_1.color.r, arg_504_1.hightColor2.r, (arg_504_1.time_ - 0) / var_507_0), Mathf.Lerp(iter_507_1.color.g, arg_504_1.hightColor2.g, (arg_504_1.time_ - 0) / var_507_0), (Mathf.Lerp(iter_507_1.color.b, arg_504_1.hightColor2.b, (arg_504_1.time_ - 0) / var_507_0)))
							else
								local var_507_1 = Mathf.Lerp(iter_507_1.color.r, 0.5, (arg_504_1.time_ - 0) / var_507_0)

								iter_507_1.color = Color.New(var_507_1, var_507_1, var_507_1)
							end
						end
					end
				end
			end

			if arg_504_1.time_ >= 0 + var_507_0 and arg_504_1.time_ < 0 + var_507_0 + arg_507_0 and not isNil(arg_504_1.actors_["10093"]) and arg_504_1.var_.actorSpriteComps10093 then
				for iter_507_2, iter_507_3 in pairs(arg_504_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_507_3 then
						iter_507_3.color = arg_504_1.isInRecall_ and (arg_504_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_504_1.var_.actorSpriteComps10093 = nil
			end

			local var_507_2 = arg_504_1.actors_["10092"]

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(var_507_2) and arg_504_1.var_.actorSpriteComps10092 == nil then
				arg_504_1.var_.actorSpriteComps10092 = var_507_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_507_3 = 2

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_3 and not isNil(var_507_2) then
				if arg_504_1.var_.actorSpriteComps10092 then
					for iter_507_4, iter_507_5 in pairs(arg_504_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_507_5 then
							if arg_504_1.isInRecall_ then
								iter_507_5.color = Color.New(Mathf.Lerp(iter_507_5.color.r, arg_504_1.hightColor1.r, (arg_504_1.time_ - 0) / var_507_3), Mathf.Lerp(iter_507_5.color.g, arg_504_1.hightColor1.g, (arg_504_1.time_ - 0) / var_507_3), (Mathf.Lerp(iter_507_5.color.b, arg_504_1.hightColor1.b, (arg_504_1.time_ - 0) / var_507_3)))
							else
								local var_507_4 = Mathf.Lerp(iter_507_5.color.r, 1, (arg_504_1.time_ - 0) / var_507_3)

								iter_507_5.color = Color.New(var_507_4, var_507_4, var_507_4)
							end
						end
					end
				end
			end

			if arg_504_1.time_ >= 0 + var_507_3 and arg_504_1.time_ < 0 + var_507_3 + arg_507_0 and not isNil(var_507_2) and arg_504_1.var_.actorSpriteComps10092 then
				for iter_507_6, iter_507_7 in pairs(arg_504_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_507_7 then
						iter_507_7.color = arg_504_1.isInRecall_ and (arg_504_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_504_1.var_.actorSpriteComps10092 = nil
			end

			local var_507_5 = 0
			local var_507_6 = 0.975

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_5 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_7 = arg_504_1:GetWordFromCfg(413011123)
				local var_507_8 = arg_504_1:FormatText(var_507_7.content)

				arg_504_1.text_.text = var_507_8

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_10 = 39 <= 0 and var_507_6 or var_507_6 * (utf8.len(var_507_8) / 39)

				if (39 <= 0 and var_507_6 or var_507_6 * (utf8.len(var_507_8) / 39)) > 0 and var_507_6 < var_507_10 then
					arg_504_1.talkMaxDuration = var_507_10

					if var_507_10 + var_507_5 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_10 + var_507_5
					end
				end

				arg_504_1.text_.text = var_507_8
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011123", "story_v_out_413011.awb") ~= 0 then
					local var_507_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011123", "story_v_out_413011.awb") / 1000

					if var_507_11 + var_507_5 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_11 + var_507_5
					end

					if var_507_7.prefab_name ~= "" and arg_504_1.actors_[var_507_7.prefab_name] ~= nil then
						local var_507_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_7.prefab_name].transform, "story_v_out_413011", "413011123", "story_v_out_413011.awb")

						arg_504_1:RecordAudio("413011123", var_507_12)
						arg_504_1:RecordAudio("413011123", var_507_12)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_413011", "413011123", "story_v_out_413011.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_413011", "413011123", "story_v_out_413011.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_13 = math.max(var_507_6, arg_504_1.talkMaxDuration)

			if var_507_5 <= arg_504_1.time_ and arg_504_1.time_ < var_507_5 + var_507_13 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_5) / var_507_13

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_5 + var_507_13 and arg_504_1.time_ < var_507_5 + var_507_13 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play413011124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 413011124
		arg_508_1.duration_ = 2

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play413011125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(arg_508_1.actors_["10093"]) and arg_508_1.var_.actorSpriteComps10093 == nil then
				arg_508_1.var_.actorSpriteComps10093 = arg_508_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_511_0 = 2

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_0 and not isNil(arg_508_1.actors_["10093"]) then
				if arg_508_1.var_.actorSpriteComps10093 then
					for iter_511_0, iter_511_1 in pairs(arg_508_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_511_1 then
							if arg_508_1.isInRecall_ then
								iter_511_1.color = Color.New(Mathf.Lerp(iter_511_1.color.r, arg_508_1.hightColor1.r, (arg_508_1.time_ - 0) / var_511_0), Mathf.Lerp(iter_511_1.color.g, arg_508_1.hightColor1.g, (arg_508_1.time_ - 0) / var_511_0), (Mathf.Lerp(iter_511_1.color.b, arg_508_1.hightColor1.b, (arg_508_1.time_ - 0) / var_511_0)))
							else
								local var_511_1 = Mathf.Lerp(iter_511_1.color.r, 1, (arg_508_1.time_ - 0) / var_511_0)

								iter_511_1.color = Color.New(var_511_1, var_511_1, var_511_1)
							end
						end
					end
				end
			end

			if arg_508_1.time_ >= 0 + var_511_0 and arg_508_1.time_ < 0 + var_511_0 + arg_511_0 and not isNil(arg_508_1.actors_["10093"]) and arg_508_1.var_.actorSpriteComps10093 then
				for iter_511_2, iter_511_3 in pairs(arg_508_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_511_3 then
						iter_511_3.color = arg_508_1.isInRecall_ and (arg_508_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_508_1.var_.actorSpriteComps10093 = nil
			end

			local var_511_2 = arg_508_1.actors_["10092"]

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(var_511_2) and arg_508_1.var_.actorSpriteComps10092 == nil then
				arg_508_1.var_.actorSpriteComps10092 = var_511_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_511_3 = 2

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_3 and not isNil(var_511_2) then
				if arg_508_1.var_.actorSpriteComps10092 then
					for iter_511_4, iter_511_5 in pairs(arg_508_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_511_5 then
							if arg_508_1.isInRecall_ then
								iter_511_5.color = Color.New(Mathf.Lerp(iter_511_5.color.r, arg_508_1.hightColor2.r, (arg_508_1.time_ - 0) / var_511_3), Mathf.Lerp(iter_511_5.color.g, arg_508_1.hightColor2.g, (arg_508_1.time_ - 0) / var_511_3), (Mathf.Lerp(iter_511_5.color.b, arg_508_1.hightColor2.b, (arg_508_1.time_ - 0) / var_511_3)))
							else
								local var_511_4 = Mathf.Lerp(iter_511_5.color.r, 0.5, (arg_508_1.time_ - 0) / var_511_3)

								iter_511_5.color = Color.New(var_511_4, var_511_4, var_511_4)
							end
						end
					end
				end
			end

			if arg_508_1.time_ >= 0 + var_511_3 and arg_508_1.time_ < 0 + var_511_3 + arg_511_0 and not isNil(var_511_2) and arg_508_1.var_.actorSpriteComps10092 then
				for iter_511_6, iter_511_7 in pairs(arg_508_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_511_7 then
						iter_511_7.color = arg_508_1.isInRecall_ and (arg_508_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_508_1.var_.actorSpriteComps10092 = nil
			end

			local var_511_5 = 0
			local var_511_6 = 0.2

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_5 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_7 = arg_508_1:GetWordFromCfg(413011124)
				local var_511_8 = arg_508_1:FormatText(var_511_7.content)

				arg_508_1.text_.text = var_511_8

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_10 = 8 <= 0 and var_511_6 or var_511_6 * (utf8.len(var_511_8) / 8)

				if (8 <= 0 and var_511_6 or var_511_6 * (utf8.len(var_511_8) / 8)) > 0 and var_511_6 < var_511_10 then
					arg_508_1.talkMaxDuration = var_511_10

					if var_511_10 + var_511_5 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_10 + var_511_5
					end
				end

				arg_508_1.text_.text = var_511_8
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011124", "story_v_out_413011.awb") ~= 0 then
					local var_511_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011124", "story_v_out_413011.awb") / 1000

					if var_511_11 + var_511_5 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_11 + var_511_5
					end

					if var_511_7.prefab_name ~= "" and arg_508_1.actors_[var_511_7.prefab_name] ~= nil then
						local var_511_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_7.prefab_name].transform, "story_v_out_413011", "413011124", "story_v_out_413011.awb")

						arg_508_1:RecordAudio("413011124", var_511_12)
						arg_508_1:RecordAudio("413011124", var_511_12)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_413011", "413011124", "story_v_out_413011.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_413011", "413011124", "story_v_out_413011.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_13 = math.max(var_511_6, arg_508_1.talkMaxDuration)

			if var_511_5 <= arg_508_1.time_ and arg_508_1.time_ < var_511_5 + var_511_13 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_5) / var_511_13

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_5 + var_511_13 and arg_508_1.time_ < var_511_5 + var_511_13 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play413011125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 413011125
		arg_512_1.duration_ = 8.03

		local var_512_0 = {
			zh = 8.033,
			ja = 5.766
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
				arg_512_0:Play413011126(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPos10092 = arg_512_1.actors_["10092"].transform.localPosition
				arg_512_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_512_1:CheckSpriteTmpPos("10092", 2)

				for iter_515_0 = 0, arg_512_1.actors_["10092"].transform.childCount - 1 do
					local var_515_0 = arg_512_1.actors_["10092"].transform:GetChild(iter_515_0)

					if var_515_0.name == "split_2" or not string.find(var_515_0.name, "split") then
						var_515_0.gameObject:SetActive(true)
					else
						var_515_0.gameObject:SetActive(false)
					end
				end
			end

			local var_515_1 = 0.001

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_1 then
				arg_512_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_512_1.time_ - 0) / var_515_1)
			end

			if arg_512_1.time_ >= 0 + var_515_1 and arg_512_1.time_ < 0 + var_515_1 + arg_515_0 then
				arg_512_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_515_2 = arg_512_1.actors_["10093"]

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(var_515_2) and arg_512_1.var_.actorSpriteComps10093 == nil then
				arg_512_1.var_.actorSpriteComps10093 = var_515_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_515_3 = 2

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_3 and not isNil(var_515_2) then
				if arg_512_1.var_.actorSpriteComps10093 then
					for iter_515_1, iter_515_2 in pairs(arg_512_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_515_2 then
							if arg_512_1.isInRecall_ then
								iter_515_2.color = Color.New(Mathf.Lerp(iter_515_2.color.r, arg_512_1.hightColor2.r, (arg_512_1.time_ - 0) / var_515_3), Mathf.Lerp(iter_515_2.color.g, arg_512_1.hightColor2.g, (arg_512_1.time_ - 0) / var_515_3), (Mathf.Lerp(iter_515_2.color.b, arg_512_1.hightColor2.b, (arg_512_1.time_ - 0) / var_515_3)))
							else
								local var_515_4 = Mathf.Lerp(iter_515_2.color.r, 0.5, (arg_512_1.time_ - 0) / var_515_3)

								iter_515_2.color = Color.New(var_515_4, var_515_4, var_515_4)
							end
						end
					end
				end
			end

			if arg_512_1.time_ >= 0 + var_515_3 and arg_512_1.time_ < 0 + var_515_3 + arg_515_0 and not isNil(var_515_2) and arg_512_1.var_.actorSpriteComps10093 then
				for iter_515_3, iter_515_4 in pairs(arg_512_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_515_4 then
						iter_515_4.color = arg_512_1.isInRecall_ and (arg_512_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_512_1.var_.actorSpriteComps10093 = nil
			end

			local var_515_5 = arg_512_1.actors_["10092"]

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(var_515_5) and arg_512_1.var_.actorSpriteComps10092 == nil then
				arg_512_1.var_.actorSpriteComps10092 = var_515_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_515_6 = 2

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_6 and not isNil(var_515_5) then
				if arg_512_1.var_.actorSpriteComps10092 then
					for iter_515_5, iter_515_6 in pairs(arg_512_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_515_6 then
							if arg_512_1.isInRecall_ then
								iter_515_6.color = Color.New(Mathf.Lerp(iter_515_6.color.r, arg_512_1.hightColor1.r, (arg_512_1.time_ - 0) / var_515_6), Mathf.Lerp(iter_515_6.color.g, arg_512_1.hightColor1.g, (arg_512_1.time_ - 0) / var_515_6), (Mathf.Lerp(iter_515_6.color.b, arg_512_1.hightColor1.b, (arg_512_1.time_ - 0) / var_515_6)))
							else
								local var_515_7 = Mathf.Lerp(iter_515_6.color.r, 1, (arg_512_1.time_ - 0) / var_515_6)

								iter_515_6.color = Color.New(var_515_7, var_515_7, var_515_7)
							end
						end
					end
				end
			end

			if arg_512_1.time_ >= 0 + var_515_6 and arg_512_1.time_ < 0 + var_515_6 + arg_515_0 and not isNil(var_515_5) and arg_512_1.var_.actorSpriteComps10092 then
				for iter_515_7, iter_515_8 in pairs(arg_512_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_515_8 then
						iter_515_8.color = arg_512_1.isInRecall_ and (arg_512_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_512_1.var_.actorSpriteComps10092 = nil
			end

			local var_515_8 = 0
			local var_515_9 = 0.725

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_8 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_10 = arg_512_1:GetWordFromCfg(413011125)
				local var_515_11 = arg_512_1:FormatText(var_515_10.content)

				arg_512_1.text_.text = var_515_11

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_13 = 29 <= 0 and var_515_9 or var_515_9 * (utf8.len(var_515_11) / 29)

				if (29 <= 0 and var_515_9 or var_515_9 * (utf8.len(var_515_11) / 29)) > 0 and var_515_9 < var_515_13 then
					arg_512_1.talkMaxDuration = var_515_13

					if var_515_13 + var_515_8 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_13 + var_515_8
					end
				end

				arg_512_1.text_.text = var_515_11
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011125", "story_v_out_413011.awb") ~= 0 then
					local var_515_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011125", "story_v_out_413011.awb") / 1000

					if var_515_14 + var_515_8 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_14 + var_515_8
					end

					if var_515_10.prefab_name ~= "" and arg_512_1.actors_[var_515_10.prefab_name] ~= nil then
						local var_515_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_10.prefab_name].transform, "story_v_out_413011", "413011125", "story_v_out_413011.awb")

						arg_512_1:RecordAudio("413011125", var_515_15)
						arg_512_1:RecordAudio("413011125", var_515_15)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_413011", "413011125", "story_v_out_413011.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_413011", "413011125", "story_v_out_413011.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_16 = math.max(var_515_9, arg_512_1.talkMaxDuration)

			if var_515_8 <= arg_512_1.time_ and arg_512_1.time_ < var_515_8 + var_515_16 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_8) / var_515_16

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_8 + var_515_16 and arg_512_1.time_ < var_515_8 + var_515_16 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
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

		arg_512_1:InitPlayNodeList()
	end,
	Play413011126 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 413011126
		arg_516_1.duration_ = 2

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play413011127(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.var_.moveOldPos10093 = arg_516_1.actors_["10093"].transform.localPosition
				arg_516_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_516_1:CheckSpriteTmpPos("10093", 4)

				for iter_519_0 = 0, arg_516_1.actors_["10093"].transform.childCount - 1 do
					local var_519_0 = arg_516_1.actors_["10093"].transform:GetChild(iter_519_0)

					if var_519_0.name == "split_5" or not string.find(var_519_0.name, "split") then
						var_519_0.gameObject:SetActive(true)
					else
						var_519_0.gameObject:SetActive(false)
					end
				end
			end

			local var_519_1 = 0.001

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_1 then
				arg_516_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_516_1.time_ - 0) / var_519_1)
			end

			if arg_516_1.time_ >= 0 + var_519_1 and arg_516_1.time_ < 0 + var_519_1 + arg_519_0 then
				arg_516_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_519_2 = arg_516_1.actors_["10093"]

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(var_519_2) and arg_516_1.var_.actorSpriteComps10093 == nil then
				arg_516_1.var_.actorSpriteComps10093 = var_519_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_519_3 = 2

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_3 and not isNil(var_519_2) then
				if arg_516_1.var_.actorSpriteComps10093 then
					for iter_519_1, iter_519_2 in pairs(arg_516_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_519_2 then
							if arg_516_1.isInRecall_ then
								iter_519_2.color = Color.New(Mathf.Lerp(iter_519_2.color.r, arg_516_1.hightColor1.r, (arg_516_1.time_ - 0) / var_519_3), Mathf.Lerp(iter_519_2.color.g, arg_516_1.hightColor1.g, (arg_516_1.time_ - 0) / var_519_3), (Mathf.Lerp(iter_519_2.color.b, arg_516_1.hightColor1.b, (arg_516_1.time_ - 0) / var_519_3)))
							else
								local var_519_4 = Mathf.Lerp(iter_519_2.color.r, 1, (arg_516_1.time_ - 0) / var_519_3)

								iter_519_2.color = Color.New(var_519_4, var_519_4, var_519_4)
							end
						end
					end
				end
			end

			if arg_516_1.time_ >= 0 + var_519_3 and arg_516_1.time_ < 0 + var_519_3 + arg_519_0 and not isNil(var_519_2) and arg_516_1.var_.actorSpriteComps10093 then
				for iter_519_3, iter_519_4 in pairs(arg_516_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_519_4 then
						iter_519_4.color = arg_516_1.isInRecall_ and (arg_516_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_516_1.var_.actorSpriteComps10093 = nil
			end

			local var_519_5 = arg_516_1.actors_["10092"]

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(var_519_5) and arg_516_1.var_.actorSpriteComps10092 == nil then
				arg_516_1.var_.actorSpriteComps10092 = var_519_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_519_6 = 2

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_6 and not isNil(var_519_5) then
				if arg_516_1.var_.actorSpriteComps10092 then
					for iter_519_5, iter_519_6 in pairs(arg_516_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_519_6 then
							if arg_516_1.isInRecall_ then
								iter_519_6.color = Color.New(Mathf.Lerp(iter_519_6.color.r, arg_516_1.hightColor2.r, (arg_516_1.time_ - 0) / var_519_6), Mathf.Lerp(iter_519_6.color.g, arg_516_1.hightColor2.g, (arg_516_1.time_ - 0) / var_519_6), (Mathf.Lerp(iter_519_6.color.b, arg_516_1.hightColor2.b, (arg_516_1.time_ - 0) / var_519_6)))
							else
								local var_519_7 = Mathf.Lerp(iter_519_6.color.r, 0.5, (arg_516_1.time_ - 0) / var_519_6)

								iter_519_6.color = Color.New(var_519_7, var_519_7, var_519_7)
							end
						end
					end
				end
			end

			if arg_516_1.time_ >= 0 + var_519_6 and arg_516_1.time_ < 0 + var_519_6 + arg_519_0 and not isNil(var_519_5) and arg_516_1.var_.actorSpriteComps10092 then
				for iter_519_7, iter_519_8 in pairs(arg_516_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_519_8 then
						iter_519_8.color = arg_516_1.isInRecall_ and (arg_516_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_516_1.var_.actorSpriteComps10092 = nil
			end

			local var_519_8 = 0
			local var_519_9 = 0.075

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_8 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_10 = arg_516_1:GetWordFromCfg(413011126)
				local var_519_11 = arg_516_1:FormatText(var_519_10.content)

				arg_516_1.text_.text = var_519_11

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_13 = 3 <= 0 and var_519_9 or var_519_9 * (utf8.len(var_519_11) / 3)

				if (3 <= 0 and var_519_9 or var_519_9 * (utf8.len(var_519_11) / 3)) > 0 and var_519_9 < var_519_13 then
					arg_516_1.talkMaxDuration = var_519_13

					if var_519_13 + var_519_8 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_13 + var_519_8
					end
				end

				arg_516_1.text_.text = var_519_11
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011126", "story_v_out_413011.awb") ~= 0 then
					local var_519_14 = manager.audio:GetVoiceLength("story_v_out_413011", "413011126", "story_v_out_413011.awb") / 1000

					if var_519_14 + var_519_8 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_14 + var_519_8
					end

					if var_519_10.prefab_name ~= "" and arg_516_1.actors_[var_519_10.prefab_name] ~= nil then
						local var_519_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_10.prefab_name].transform, "story_v_out_413011", "413011126", "story_v_out_413011.awb")

						arg_516_1:RecordAudio("413011126", var_519_15)
						arg_516_1:RecordAudio("413011126", var_519_15)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_413011", "413011126", "story_v_out_413011.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_413011", "413011126", "story_v_out_413011.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_16 = math.max(var_519_9, arg_516_1.talkMaxDuration)

			if var_519_8 <= arg_516_1.time_ and arg_516_1.time_ < var_519_8 + var_519_16 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_8) / var_519_16

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_8 + var_519_16 and arg_516_1.time_ < var_519_8 + var_519_16 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
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

		arg_516_1:InitPlayNodeList()
	end,
	Play413011127 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 413011127
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play413011128(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.var_.moveOldPos10092 = arg_520_1.actors_["10092"].transform.localPosition
				arg_520_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_520_1:CheckSpriteTmpPos("10092", 0)

				for iter_523_0 = 0, arg_520_1.actors_["10092"].transform.childCount - 1 do
					local var_523_0 = arg_520_1.actors_["10092"].transform:GetChild(iter_523_0)

					if var_523_0.name == "" or not string.find(var_523_0.name, "split") then
						var_523_0.gameObject:SetActive(true)
					else
						var_523_0.gameObject:SetActive(false)
					end
				end
			end

			local var_523_1 = 0.001

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_1 then
				arg_520_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_520_1.time_ - 0) / var_523_1)
			end

			if arg_520_1.time_ >= 0 + var_523_1 and arg_520_1.time_ < 0 + var_523_1 + arg_523_0 then
				arg_520_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_523_2 = arg_520_1.actors_["10093"].transform

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.var_.moveOldPos10093 = var_523_2.localPosition
				var_523_2.localScale = Vector3.New(1, 1, 1)

				arg_520_1:CheckSpriteTmpPos("10093", 0)

				for iter_523_1 = 0, var_523_2.childCount - 1 do
					local var_523_3 = var_523_2:GetChild(iter_523_1)

					if var_523_3.name == "" or not string.find(var_523_3.name, "split") then
						var_523_3.gameObject:SetActive(true)
					else
						var_523_3.gameObject:SetActive(false)
					end
				end
			end

			local var_523_4 = 0.001

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_4 then
				var_523_2.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos10093, Vector3.New(-1500, -350, -180), (arg_520_1.time_ - 0) / var_523_4)
			end

			if arg_520_1.time_ >= 0 + var_523_4 and arg_520_1.time_ < 0 + var_523_4 + arg_523_0 then
				var_523_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_523_5 = arg_520_1.actors_["10092"]

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(var_523_5) and arg_520_1.var_.actorSpriteComps10092 == nil then
				arg_520_1.var_.actorSpriteComps10092 = var_523_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_523_6 = 2

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_6 and not isNil(var_523_5) then
				if arg_520_1.var_.actorSpriteComps10092 then
					for iter_523_2, iter_523_3 in pairs(arg_520_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_523_3 then
							if arg_520_1.isInRecall_ then
								iter_523_3.color = Color.New(Mathf.Lerp(iter_523_3.color.r, arg_520_1.hightColor2.r, (arg_520_1.time_ - 0) / var_523_6), Mathf.Lerp(iter_523_3.color.g, arg_520_1.hightColor2.g, (arg_520_1.time_ - 0) / var_523_6), (Mathf.Lerp(iter_523_3.color.b, arg_520_1.hightColor2.b, (arg_520_1.time_ - 0) / var_523_6)))
							else
								local var_523_7 = Mathf.Lerp(iter_523_3.color.r, 0.5, (arg_520_1.time_ - 0) / var_523_6)

								iter_523_3.color = Color.New(var_523_7, var_523_7, var_523_7)
							end
						end
					end
				end
			end

			if arg_520_1.time_ >= 0 + var_523_6 and arg_520_1.time_ < 0 + var_523_6 + arg_523_0 and not isNil(var_523_5) and arg_520_1.var_.actorSpriteComps10092 then
				for iter_523_4, iter_523_5 in pairs(arg_520_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_523_5 then
						iter_523_5.color = arg_520_1.isInRecall_ and (arg_520_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_520_1.var_.actorSpriteComps10092 = nil
			end

			local var_523_8 = arg_520_1.actors_["10093"]

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(var_523_8) and arg_520_1.var_.actorSpriteComps10093 == nil then
				arg_520_1.var_.actorSpriteComps10093 = var_523_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_523_9 = 2

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_9 and not isNil(var_523_8) then
				if arg_520_1.var_.actorSpriteComps10093 then
					for iter_523_6, iter_523_7 in pairs(arg_520_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_523_7 then
							if arg_520_1.isInRecall_ then
								iter_523_7.color = Color.New(Mathf.Lerp(iter_523_7.color.r, arg_520_1.hightColor2.r, (arg_520_1.time_ - 0) / var_523_9), Mathf.Lerp(iter_523_7.color.g, arg_520_1.hightColor2.g, (arg_520_1.time_ - 0) / var_523_9), (Mathf.Lerp(iter_523_7.color.b, arg_520_1.hightColor2.b, (arg_520_1.time_ - 0) / var_523_9)))
							else
								local var_523_10 = Mathf.Lerp(iter_523_7.color.r, 0.5, (arg_520_1.time_ - 0) / var_523_9)

								iter_523_7.color = Color.New(var_523_10, var_523_10, var_523_10)
							end
						end
					end
				end
			end

			if arg_520_1.time_ >= 0 + var_523_9 and arg_520_1.time_ < 0 + var_523_9 + arg_523_0 and not isNil(var_523_8) and arg_520_1.var_.actorSpriteComps10093 then
				for iter_523_8, iter_523_9 in pairs(arg_520_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_523_9 then
						iter_523_9.color = arg_520_1.isInRecall_ and (arg_520_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_520_1.var_.actorSpriteComps10093 = nil
			end

			local var_523_11 = 0
			local var_523_12 = 1.4

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_11 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, false)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_13 = arg_520_1:FormatText(arg_520_1:GetWordFromCfg(413011127).content)

				arg_520_1.text_.text = var_523_13

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_15 = 56 <= 0 and var_523_12 or var_523_12 * (utf8.len(var_523_13) / 56)

				if (56 <= 0 and var_523_12 or var_523_12 * (utf8.len(var_523_13) / 56)) > 0 and var_523_12 < var_523_15 then
					arg_520_1.talkMaxDuration = var_523_15

					if var_523_15 + var_523_11 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_15 + var_523_11
					end
				end

				arg_520_1.text_.text = var_523_13
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_16 = math.max(var_523_12, arg_520_1.talkMaxDuration)

			if var_523_11 <= arg_520_1.time_ and arg_520_1.time_ < var_523_11 + var_523_16 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_11) / var_523_16

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_11 + var_523_16 and arg_520_1.time_ < var_523_11 + var_523_16 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {
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

		arg_520_1:InitPlayNodeList()
	end,
	Play413011128 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 413011128
		arg_524_1.duration_ = 6

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play413011129(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_527_0 = 0.6

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 then
				local var_527_1, var_527_2 = math.modf((arg_524_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_527_2 * 0.13, var_527_2 * 0.13, var_527_2 * 0.13) + arg_524_1.var_.shakeOldPos
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 then
				manager.ui.mainCamera.transform.localPosition = arg_524_1.var_.shakeOldPos
			end

			local var_527_3 = 0

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_3 + arg_527_0 then
				arg_524_1.allBtn_.enabled = false
			end

			if arg_524_1.time_ >= var_527_3 + 0.6 and arg_524_1.time_ < var_527_3 + 0.6 + arg_527_0 then
				arg_524_1.allBtn_.enabled = true
			end

			if 0.0666666666666667 < arg_524_1.time_ and arg_524_1.time_ <= 0.0666666666666667 + arg_527_0 then
				arg_524_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_porcelain_break", "")
			end

			if arg_524_1.frameCnt_ <= 1 then
				arg_524_1.dialog_:SetActive(false)
			end

			local var_527_5 = 1
			local var_527_6 = 1.55

			if 1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_5 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0

				arg_524_1.dialog_:SetActive(true)

				arg_524_1.dialogCg_.alpha = 0

				local var_527_7 = LeanTween.value(arg_524_1.dialog_, 0, 1, 0.3)

				var_527_7:setOnUpdate(LuaHelper.FloatAction(function(arg_528_0)
					arg_524_1.dialogCg_.alpha = arg_528_0
				end))
				var_527_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_524_1.dialog_)
					var_527_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_524_1.duration_ = arg_524_1.duration_ + 0.3

				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_8 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(413011128).content)

				arg_524_1.text_.text = var_527_8

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_10 = 62 <= 0 and var_527_6 or var_527_6 * (utf8.len(var_527_8) / 62)

				if (62 <= 0 and var_527_6 or var_527_6 * (utf8.len(var_527_8) / 62)) > 0 and var_527_6 < var_527_10 then
					arg_524_1.talkMaxDuration = var_527_10
					var_527_5 = var_527_5 + 0.3

					if var_527_10 + var_527_5 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_10 + var_527_5
					end
				end

				arg_524_1.text_.text = var_527_8
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_11 = var_527_5 + 0.3
			local var_527_12 = math.max(var_527_6, arg_524_1.talkMaxDuration)

			if var_527_5 + 0.3 <= arg_524_1.time_ and arg_524_1.time_ < var_527_11 + var_527_12 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_11) / var_527_12

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_11 + var_527_12 and arg_524_1.time_ < var_527_11 + var_527_12 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play413011129 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 413011129
		arg_530_1.duration_ = 9.73

		local var_530_0 = {
			zh = 6.233,
			ja = 9.733
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play413011130(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1.var_.moveOldPos10092 = arg_530_1.actors_["10092"].transform.localPosition
				arg_530_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_530_1:CheckSpriteTmpPos("10092", 3)

				for iter_533_0 = 0, arg_530_1.actors_["10092"].transform.childCount - 1 do
					local var_533_0 = arg_530_1.actors_["10092"].transform:GetChild(iter_533_0)

					if var_533_0.name == "split_2" or not string.find(var_533_0.name, "split") then
						var_533_0.gameObject:SetActive(true)
					else
						var_533_0.gameObject:SetActive(false)
					end
				end
			end

			local var_533_1 = 0.001

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_1 then
				arg_530_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_530_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_530_1.time_ - 0) / var_533_1)
			end

			if arg_530_1.time_ >= 0 + var_533_1 and arg_530_1.time_ < 0 + var_533_1 + arg_533_0 then
				arg_530_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_533_2 = arg_530_1.actors_["10092"]

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 and not isNil(var_533_2) and arg_530_1.var_.actorSpriteComps10092 == nil then
				arg_530_1.var_.actorSpriteComps10092 = var_533_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_533_3 = 2

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_3 and not isNil(var_533_2) then
				if arg_530_1.var_.actorSpriteComps10092 then
					for iter_533_1, iter_533_2 in pairs(arg_530_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_533_2 then
							if arg_530_1.isInRecall_ then
								iter_533_2.color = Color.New(Mathf.Lerp(iter_533_2.color.r, arg_530_1.hightColor1.r, (arg_530_1.time_ - 0) / var_533_3), Mathf.Lerp(iter_533_2.color.g, arg_530_1.hightColor1.g, (arg_530_1.time_ - 0) / var_533_3), (Mathf.Lerp(iter_533_2.color.b, arg_530_1.hightColor1.b, (arg_530_1.time_ - 0) / var_533_3)))
							else
								local var_533_4 = Mathf.Lerp(iter_533_2.color.r, 1, (arg_530_1.time_ - 0) / var_533_3)

								iter_533_2.color = Color.New(var_533_4, var_533_4, var_533_4)
							end
						end
					end
				end
			end

			if arg_530_1.time_ >= 0 + var_533_3 and arg_530_1.time_ < 0 + var_533_3 + arg_533_0 and not isNil(var_533_2) and arg_530_1.var_.actorSpriteComps10092 then
				for iter_533_3, iter_533_4 in pairs(arg_530_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_533_4 then
						iter_533_4.color = arg_530_1.isInRecall_ and (arg_530_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_530_1.var_.actorSpriteComps10092 = nil
			end

			local var_533_5 = 0
			local var_533_6 = 0.55

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_5 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_7 = arg_530_1:GetWordFromCfg(413011129)
				local var_533_8 = arg_530_1:FormatText(var_533_7.content)

				arg_530_1.text_.text = var_533_8

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_10 = 22 <= 0 and var_533_6 or var_533_6 * (utf8.len(var_533_8) / 22)

				if (22 <= 0 and var_533_6 or var_533_6 * (utf8.len(var_533_8) / 22)) > 0 and var_533_6 < var_533_10 then
					arg_530_1.talkMaxDuration = var_533_10

					if var_533_10 + var_533_5 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_10 + var_533_5
					end
				end

				arg_530_1.text_.text = var_533_8
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011129", "story_v_out_413011.awb") ~= 0 then
					local var_533_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011129", "story_v_out_413011.awb") / 1000

					if var_533_11 + var_533_5 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_11 + var_533_5
					end

					if var_533_7.prefab_name ~= "" and arg_530_1.actors_[var_533_7.prefab_name] ~= nil then
						local var_533_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_7.prefab_name].transform, "story_v_out_413011", "413011129", "story_v_out_413011.awb")

						arg_530_1:RecordAudio("413011129", var_533_12)
						arg_530_1:RecordAudio("413011129", var_533_12)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_413011", "413011129", "story_v_out_413011.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_413011", "413011129", "story_v_out_413011.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_13 = math.max(var_533_6, arg_530_1.talkMaxDuration)

			if var_533_5 <= arg_530_1.time_ and arg_530_1.time_ < var_533_5 + var_533_13 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_5) / var_533_13

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_5 + var_533_13 and arg_530_1.time_ < var_533_5 + var_533_13 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {
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

		arg_530_1:InitPlayNodeList()
	end,
	Play413011130 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 413011130
		arg_534_1.duration_ = 4.33

		local var_534_0 = {
			zh = 4.1,
			ja = 4.333
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play413011131(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.var_.moveOldPos10092 = arg_534_1.actors_["10092"].transform.localPosition
				arg_534_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_534_1:CheckSpriteTmpPos("10092", 3)

				for iter_537_0 = 0, arg_534_1.actors_["10092"].transform.childCount - 1 do
					local var_537_0 = arg_534_1.actors_["10092"].transform:GetChild(iter_537_0)

					if var_537_0.name == "split_6" or not string.find(var_537_0.name, "split") then
						var_537_0.gameObject:SetActive(true)
					else
						var_537_0.gameObject:SetActive(false)
					end
				end
			end

			local var_537_1 = 0.001

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_1 then
				arg_534_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_534_1.time_ - 0) / var_537_1)
			end

			if arg_534_1.time_ >= 0 + var_537_1 and arg_534_1.time_ < 0 + var_537_1 + arg_537_0 then
				arg_534_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_537_2 = arg_534_1.actors_["10092"]

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(var_537_2) and arg_534_1.var_.actorSpriteComps10092 == nil then
				arg_534_1.var_.actorSpriteComps10092 = var_537_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_537_3 = 2

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_3 and not isNil(var_537_2) then
				if arg_534_1.var_.actorSpriteComps10092 then
					for iter_537_1, iter_537_2 in pairs(arg_534_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_537_2 then
							if arg_534_1.isInRecall_ then
								iter_537_2.color = Color.New(Mathf.Lerp(iter_537_2.color.r, arg_534_1.hightColor1.r, (arg_534_1.time_ - 0) / var_537_3), Mathf.Lerp(iter_537_2.color.g, arg_534_1.hightColor1.g, (arg_534_1.time_ - 0) / var_537_3), (Mathf.Lerp(iter_537_2.color.b, arg_534_1.hightColor1.b, (arg_534_1.time_ - 0) / var_537_3)))
							else
								local var_537_4 = Mathf.Lerp(iter_537_2.color.r, 1, (arg_534_1.time_ - 0) / var_537_3)

								iter_537_2.color = Color.New(var_537_4, var_537_4, var_537_4)
							end
						end
					end
				end
			end

			if arg_534_1.time_ >= 0 + var_537_3 and arg_534_1.time_ < 0 + var_537_3 + arg_537_0 and not isNil(var_537_2) and arg_534_1.var_.actorSpriteComps10092 then
				for iter_537_3, iter_537_4 in pairs(arg_534_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_537_4 then
						iter_537_4.color = arg_534_1.isInRecall_ and (arg_534_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_534_1.var_.actorSpriteComps10092 = nil
			end

			local var_537_5 = 0
			local var_537_6 = 0.5

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_5 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_7 = arg_534_1:GetWordFromCfg(413011130)
				local var_537_8 = arg_534_1:FormatText(var_537_7.content)

				arg_534_1.text_.text = var_537_8

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_10 = 20 <= 0 and var_537_6 or var_537_6 * (utf8.len(var_537_8) / 20)

				if (20 <= 0 and var_537_6 or var_537_6 * (utf8.len(var_537_8) / 20)) > 0 and var_537_6 < var_537_10 then
					arg_534_1.talkMaxDuration = var_537_10

					if var_537_10 + var_537_5 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_10 + var_537_5
					end
				end

				arg_534_1.text_.text = var_537_8
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011130", "story_v_out_413011.awb") ~= 0 then
					local var_537_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011130", "story_v_out_413011.awb") / 1000

					if var_537_11 + var_537_5 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_11 + var_537_5
					end

					if var_537_7.prefab_name ~= "" and arg_534_1.actors_[var_537_7.prefab_name] ~= nil then
						local var_537_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_7.prefab_name].transform, "story_v_out_413011", "413011130", "story_v_out_413011.awb")

						arg_534_1:RecordAudio("413011130", var_537_12)
						arg_534_1:RecordAudio("413011130", var_537_12)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_413011", "413011130", "story_v_out_413011.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_413011", "413011130", "story_v_out_413011.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_13 = math.max(var_537_6, arg_534_1.talkMaxDuration)

			if var_537_5 <= arg_534_1.time_ and arg_534_1.time_ < var_537_5 + var_537_13 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_5) / var_537_13

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_5 + var_537_13 and arg_534_1.time_ < var_537_5 + var_537_13 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
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

		arg_534_1:InitPlayNodeList()
	end,
	Play413011131 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 413011131
		arg_538_1.duration_ = 5

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play413011132(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.var_.moveOldPos10092 = arg_538_1.actors_["10092"].transform.localPosition
				arg_538_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_538_1:CheckSpriteTmpPos("10092", 0)

				for iter_541_0 = 0, arg_538_1.actors_["10092"].transform.childCount - 1 do
					local var_541_0 = arg_538_1.actors_["10092"].transform:GetChild(iter_541_0)

					if var_541_0.name == "" or not string.find(var_541_0.name, "split") then
						var_541_0.gameObject:SetActive(true)
					else
						var_541_0.gameObject:SetActive(false)
					end
				end
			end

			local var_541_1 = 0.001

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_1 then
				arg_538_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_538_1.time_ - 0) / var_541_1)
			end

			if arg_538_1.time_ >= 0 + var_541_1 and arg_538_1.time_ < 0 + var_541_1 + arg_541_0 then
				arg_538_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_541_2 = arg_538_1.actors_["10092"]

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(var_541_2) and arg_538_1.var_.actorSpriteComps10092 == nil then
				arg_538_1.var_.actorSpriteComps10092 = var_541_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_541_3 = 2

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_3 and not isNil(var_541_2) then
				if arg_538_1.var_.actorSpriteComps10092 then
					for iter_541_1, iter_541_2 in pairs(arg_538_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_541_2 then
							if arg_538_1.isInRecall_ then
								iter_541_2.color = Color.New(Mathf.Lerp(iter_541_2.color.r, arg_538_1.hightColor2.r, (arg_538_1.time_ - 0) / var_541_3), Mathf.Lerp(iter_541_2.color.g, arg_538_1.hightColor2.g, (arg_538_1.time_ - 0) / var_541_3), (Mathf.Lerp(iter_541_2.color.b, arg_538_1.hightColor2.b, (arg_538_1.time_ - 0) / var_541_3)))
							else
								local var_541_4 = Mathf.Lerp(iter_541_2.color.r, 0.5, (arg_538_1.time_ - 0) / var_541_3)

								iter_541_2.color = Color.New(var_541_4, var_541_4, var_541_4)
							end
						end
					end
				end
			end

			if arg_538_1.time_ >= 0 + var_541_3 and arg_538_1.time_ < 0 + var_541_3 + arg_541_0 and not isNil(var_541_2) and arg_538_1.var_.actorSpriteComps10092 then
				for iter_541_3, iter_541_4 in pairs(arg_538_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_541_4 then
						iter_541_4.color = arg_538_1.isInRecall_ and (arg_538_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_538_1.var_.actorSpriteComps10092 = nil
			end

			local var_541_5 = 0
			local var_541_6 = 1.05

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_5 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, false)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_7 = arg_538_1:FormatText(arg_538_1:GetWordFromCfg(413011131).content)

				arg_538_1.text_.text = var_541_7

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_9 = 42 <= 0 and var_541_6 or var_541_6 * (utf8.len(var_541_7) / 42)

				if (42 <= 0 and var_541_6 or var_541_6 * (utf8.len(var_541_7) / 42)) > 0 and var_541_6 < var_541_9 then
					arg_538_1.talkMaxDuration = var_541_9

					if var_541_9 + var_541_5 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_9 + var_541_5
					end
				end

				arg_538_1.text_.text = var_541_7
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)
				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_10 = math.max(var_541_6, arg_538_1.talkMaxDuration)

			if var_541_5 <= arg_538_1.time_ and arg_538_1.time_ < var_541_5 + var_541_10 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_5) / var_541_10

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_5 + var_541_10 and arg_538_1.time_ < var_541_5 + var_541_10 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
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

		arg_538_1:InitPlayNodeList()
	end,
	Play413011132 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 413011132
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play413011133(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0.9

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, false)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_1 = arg_542_1:FormatText(arg_542_1:GetWordFromCfg(413011132).content)

				arg_542_1.text_.text = var_545_1

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_3 = 36 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_1) / 36)

				if (36 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_1) / 36)) > 0 and var_545_0 < var_545_3 then
					arg_542_1.talkMaxDuration = var_545_3

					if var_545_3 + 0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_3 + 0
					end
				end

				arg_542_1.text_.text = var_545_1
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_4 = math.max(var_545_0, arg_542_1.talkMaxDuration)

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_4 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - 0) / var_545_4

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= 0 + var_545_4 and arg_542_1.time_ < 0 + var_545_4 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play413011133 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 413011133
		arg_546_1.duration_ = 12.77

		local var_546_0 = {
			zh = 8.932999999999,
			ja = 12.765999999999
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play413011134(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			if 2 < arg_546_1.time_ and arg_546_1.time_ <= 2 + arg_549_0 then
				local var_549_0 = arg_546_1.bgs_.F10f

				arg_546_1.bgs_.F10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_549_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_549_1 = var_549_0:GetComponent("SpriteRenderer")

				if var_549_1 and var_549_1.sprite then
					local var_549_2 = 2 * (var_549_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_549_0.transform.localScale = Vector3.New(var_549_2 / var_549_1.sprite.bounds.size.y < var_549_2 * manager.ui.mainCameraCom_.aspect / var_549_1.sprite.bounds.size.x and var_549_2 * manager.ui.mainCameraCom_.aspect / var_549_1.sprite.bounds.size.x or var_549_2 / var_549_1.sprite.bounds.size.y, var_549_2 / var_549_1.sprite.bounds.size.y < var_549_2 * manager.ui.mainCameraCom_.aspect / var_549_1.sprite.bounds.size.x and var_549_2 * manager.ui.mainCameraCom_.aspect / var_549_1.sprite.bounds.size.x or var_549_2 / var_549_1.sprite.bounds.size.y, 0)
				end

				for iter_549_0, iter_549_1 in pairs(arg_546_1.bgs_) do
					if iter_549_0 ~= "F10f" then
						iter_549_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_549_3 = 3.999999999999

			if 3.999999999999 < arg_546_1.time_ and arg_546_1.time_ <= var_549_3 + arg_549_0 then
				arg_546_1.allBtn_.enabled = false
			end

			if arg_546_1.time_ >= var_549_3 + 0.3 and arg_546_1.time_ < var_549_3 + 0.3 + arg_549_0 then
				arg_546_1.allBtn_.enabled = true
			end

			local var_549_4 = 0

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_4 + arg_549_0 then
				arg_546_1.mask_.enabled = true
				arg_546_1.mask_.raycastTarget = true

				arg_546_1:SetGaussion(false)
			end

			local var_549_5 = 2

			if var_549_4 <= arg_546_1.time_ and arg_546_1.time_ < var_549_4 + var_549_5 then
				local var_549_6 = Color.New(0, 0, 0)

				var_549_6.a = Mathf.Lerp(0, 1, (arg_546_1.time_ - var_549_4) / var_549_5)
				arg_546_1.mask_.color = var_549_6
			end

			if arg_546_1.time_ >= var_549_4 + var_549_5 and arg_546_1.time_ < var_549_4 + var_549_5 + arg_549_0 then
				local var_549_7 = Color.New(0, 0, 0)

				var_549_7.a = 1
				arg_546_1.mask_.color = var_549_7
			end

			local var_549_8 = 2

			if 2 < arg_546_1.time_ and arg_546_1.time_ <= var_549_8 + arg_549_0 then
				arg_546_1.mask_.enabled = true
				arg_546_1.mask_.raycastTarget = true

				arg_546_1:SetGaussion(false)
			end

			local var_549_9 = 2

			if var_549_8 <= arg_546_1.time_ and arg_546_1.time_ < var_549_8 + var_549_9 then
				local var_549_10 = Color.New(0, 0, 0)

				var_549_10.a = Mathf.Lerp(1, 0, (arg_546_1.time_ - var_549_8) / var_549_9)
				arg_546_1.mask_.color = var_549_10
			end

			if arg_546_1.time_ >= var_549_8 + var_549_9 and arg_546_1.time_ < var_549_8 + var_549_9 + arg_549_0 then
				local var_549_11 = Color.New(0, 0, 0)

				arg_546_1.mask_.enabled = false
				var_549_11.a = 0
				arg_546_1.mask_.color = var_549_11
			end

			local var_549_12 = arg_546_1.actors_["10022"].transform

			if 3.8 < arg_546_1.time_ and arg_546_1.time_ <= 3.8 + arg_549_0 then
				arg_546_1.var_.moveOldPos10022 = var_549_12.localPosition
				var_549_12.localScale = Vector3.New(1, 1, 1)

				arg_546_1:CheckSpriteTmpPos("10022", 3)

				for iter_549_2 = 0, var_549_12.childCount - 1 do
					local var_549_13 = var_549_12:GetChild(iter_549_2)

					if var_549_13.name == "split_8" or not string.find(var_549_13.name, "split") then
						var_549_13.gameObject:SetActive(true)
					else
						var_549_13.gameObject:SetActive(false)
					end
				end
			end

			local var_549_14 = 0.001

			if 3.8 <= arg_546_1.time_ and arg_546_1.time_ < 3.8 + var_549_14 then
				var_549_12.localPosition = Vector3.Lerp(arg_546_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_546_1.time_ - 3.8) / var_549_14)
			end

			if arg_546_1.time_ >= 3.8 + var_549_14 and arg_546_1.time_ < 3.8 + var_549_14 + arg_549_0 then
				var_549_12.localPosition = Vector3.New(0, -315, -320)
			end

			local var_549_15 = arg_546_1.actors_["10022"]

			if 3.8 < arg_546_1.time_ and arg_546_1.time_ <= 3.8 + arg_549_0 and not isNil(var_549_15) and arg_546_1.var_.actorSpriteComps10022 == nil then
				arg_546_1.var_.actorSpriteComps10022 = var_549_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_549_16 = 0.2

			if 3.8 <= arg_546_1.time_ and arg_546_1.time_ < 3.8 + var_549_16 and not isNil(var_549_15) then
				if arg_546_1.var_.actorSpriteComps10022 then
					for iter_549_3, iter_549_4 in pairs(arg_546_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_549_4 then
							if arg_546_1.isInRecall_ then
								iter_549_4.color = Color.New(Mathf.Lerp(iter_549_4.color.r, arg_546_1.hightColor1.r, (arg_546_1.time_ - 3.8) / var_549_16), Mathf.Lerp(iter_549_4.color.g, arg_546_1.hightColor1.g, (arg_546_1.time_ - 3.8) / var_549_16), (Mathf.Lerp(iter_549_4.color.b, arg_546_1.hightColor1.b, (arg_546_1.time_ - 3.8) / var_549_16)))
							else
								local var_549_17 = Mathf.Lerp(iter_549_4.color.r, 1, (arg_546_1.time_ - 3.8) / var_549_16)

								iter_549_4.color = Color.New(var_549_17, var_549_17, var_549_17)
							end
						end
					end
				end
			end

			if arg_546_1.time_ >= 3.8 + var_549_16 and arg_546_1.time_ < 3.8 + var_549_16 + arg_549_0 and not isNil(var_549_15) and arg_546_1.var_.actorSpriteComps10022 then
				for iter_549_5, iter_549_6 in pairs(arg_546_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_549_6 then
						iter_549_6.color = arg_546_1.isInRecall_ and (arg_546_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_546_1.var_.actorSpriteComps10022 = nil
			end

			if 3.799999999999 < arg_546_1.time_ and arg_546_1.time_ <= 3.799999999999 + arg_549_0 then
				local var_549_18 = arg_546_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_549_18 then
					arg_546_1.var_.alphaOldValue10022 = var_549_18.alpha
					arg_546_1.var_.characterEffect10022 = var_549_18
				end

				arg_546_1.var_.alphaOldValue10022 = 0
			end

			local var_549_19 = 0.2

			if 3.799999999999 <= arg_546_1.time_ and arg_546_1.time_ < 3.799999999999 + var_549_19 then
				if arg_546_1.var_.characterEffect10022 then
					arg_546_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_546_1.var_.alphaOldValue10022, 1, (arg_546_1.time_ - 3.799999999999) / var_549_19)
				end
			end

			if arg_546_1.time_ >= 3.799999999999 + var_549_19 and arg_546_1.time_ < 3.799999999999 + var_549_19 + arg_549_0 and arg_546_1.var_.characterEffect10022 then
				arg_546_1.var_.characterEffect10022.alpha = 1
			end

			if arg_546_1.frameCnt_ <= 1 then
				arg_546_1.dialog_:SetActive(false)
			end

			local var_549_20 = 3.999999999999
			local var_549_21 = 0.675

			if 3.999999999999 < arg_546_1.time_ and arg_546_1.time_ <= var_549_20 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0

				arg_546_1.dialog_:SetActive(true)

				arg_546_1.dialogCg_.alpha = 0

				local var_549_22 = LeanTween.value(arg_546_1.dialog_, 0, 1, 0.3)

				var_549_22:setOnUpdate(LuaHelper.FloatAction(function(arg_550_0)
					arg_546_1.dialogCg_.alpha = arg_550_0
				end))
				var_549_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_546_1.dialog_)
					var_549_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_546_1.duration_ = arg_546_1.duration_ + 0.3

				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_23 = arg_546_1:GetWordFromCfg(413011133)
				local var_549_24 = arg_546_1:FormatText(var_549_23.content)

				arg_546_1.text_.text = var_549_24

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_26 = 27 <= 0 and var_549_21 or var_549_21 * (utf8.len(var_549_24) / 27)

				if (27 <= 0 and var_549_21 or var_549_21 * (utf8.len(var_549_24) / 27)) > 0 and var_549_21 < var_549_26 then
					arg_546_1.talkMaxDuration = var_549_26
					var_549_20 = var_549_20 + 0.3

					if var_549_26 + var_549_20 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_26 + var_549_20
					end
				end

				arg_546_1.text_.text = var_549_24
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011133", "story_v_out_413011.awb") ~= 0 then
					local var_549_27 = manager.audio:GetVoiceLength("story_v_out_413011", "413011133", "story_v_out_413011.awb") / 1000

					if var_549_27 + var_549_20 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_27 + var_549_20
					end

					if var_549_23.prefab_name ~= "" and arg_546_1.actors_[var_549_23.prefab_name] ~= nil then
						local var_549_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_23.prefab_name].transform, "story_v_out_413011", "413011133", "story_v_out_413011.awb")

						arg_546_1:RecordAudio("413011133", var_549_28)
						arg_546_1:RecordAudio("413011133", var_549_28)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_out_413011", "413011133", "story_v_out_413011.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_out_413011", "413011133", "story_v_out_413011.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_29 = var_549_20 + 0.3
			local var_549_30 = math.max(var_549_21, arg_546_1.talkMaxDuration)

			if var_549_20 + 0.3 <= arg_546_1.time_ and arg_546_1.time_ < var_549_29 + var_549_30 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_29) / var_549_30

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_29 + var_549_30 and arg_546_1.time_ < var_549_29 + var_549_30 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {
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

		arg_546_1:InitPlayNodeList()
	end,
	Play413011134 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 413011134
		arg_552_1.duration_ = 8.4

		local var_552_0 = {
			zh = 4.033,
			ja = 8.4
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
				arg_552_0:Play413011135(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0.5

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_1 = arg_552_1:GetWordFromCfg(413011134)
				local var_555_2 = arg_552_1:FormatText(var_555_1.content)

				arg_552_1.text_.text = var_555_2

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_4 = 20 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 20)

				if (20 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 20)) > 0 and var_555_0 < var_555_4 then
					arg_552_1.talkMaxDuration = var_555_4

					if var_555_4 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_4 + 0
					end
				end

				arg_552_1.text_.text = var_555_2
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011134", "story_v_out_413011.awb") ~= 0 then
					local var_555_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011134", "story_v_out_413011.awb") / 1000

					if var_555_5 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_5 + 0
					end

					if var_555_1.prefab_name ~= "" and arg_552_1.actors_[var_555_1.prefab_name] ~= nil then
						local var_555_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_1.prefab_name].transform, "story_v_out_413011", "413011134", "story_v_out_413011.awb")

						arg_552_1:RecordAudio("413011134", var_555_6)
						arg_552_1:RecordAudio("413011134", var_555_6)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_out_413011", "413011134", "story_v_out_413011.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_out_413011", "413011134", "story_v_out_413011.awb")
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
	Play413011135 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 413011135
		arg_556_1.duration_ = 3.93

		local var_556_0 = {
			zh = 1.9,
			ja = 3.933
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
				arg_556_0:Play413011136(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 and not isNil(arg_556_1.actors_["10022"]) and arg_556_1.var_.actorSpriteComps10022 == nil then
				arg_556_1.var_.actorSpriteComps10022 = arg_556_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_559_0 = 0.2

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_0 and not isNil(arg_556_1.actors_["10022"]) then
				if arg_556_1.var_.actorSpriteComps10022 then
					for iter_559_0, iter_559_1 in pairs(arg_556_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_559_1 then
							if arg_556_1.isInRecall_ then
								iter_559_1.color = Color.New(Mathf.Lerp(iter_559_1.color.r, arg_556_1.hightColor2.r, (arg_556_1.time_ - 0) / var_559_0), Mathf.Lerp(iter_559_1.color.g, arg_556_1.hightColor2.g, (arg_556_1.time_ - 0) / var_559_0), (Mathf.Lerp(iter_559_1.color.b, arg_556_1.hightColor2.b, (arg_556_1.time_ - 0) / var_559_0)))
							else
								local var_559_1 = Mathf.Lerp(iter_559_1.color.r, 0.5, (arg_556_1.time_ - 0) / var_559_0)

								iter_559_1.color = Color.New(var_559_1, var_559_1, var_559_1)
							end
						end
					end
				end
			end

			if arg_556_1.time_ >= 0 + var_559_0 and arg_556_1.time_ < 0 + var_559_0 + arg_559_0 and not isNil(arg_556_1.actors_["10022"]) and arg_556_1.var_.actorSpriteComps10022 then
				for iter_559_2, iter_559_3 in pairs(arg_556_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_559_3 then
						iter_559_3.color = arg_556_1.isInRecall_ and (arg_556_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_556_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1:SetSpriteNiuquEffect("10094", true)
			end

			local var_559_3 = arg_556_1.actors_["10094"].transform

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.var_.moveOldPos10094 = var_559_3.localPosition
				var_559_3.localScale = Vector3.New(1, 1, 1)

				arg_556_1:CheckSpriteTmpPos("10094", 4)

				for iter_559_4 = 0, var_559_3.childCount - 1 do
					local var_559_4 = var_559_3:GetChild(iter_559_4)

					if var_559_4.name == "split_1" or not string.find(var_559_4.name, "split") then
						var_559_4.gameObject:SetActive(true)
					else
						var_559_4.gameObject:SetActive(false)
					end
				end
			end

			local var_559_5 = 0.001

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_5 then
				var_559_3.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_556_1.time_ - 0) / var_559_5)
			end

			if arg_556_1.time_ >= 0 + var_559_5 and arg_556_1.time_ < 0 + var_559_5 + arg_559_0 then
				var_559_3.localPosition = Vector3.New(390, -340, -414)
			end

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				local var_559_6 = arg_556_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_559_6 then
					arg_556_1.var_.alphaOldValue10094 = var_559_6.alpha
					arg_556_1.var_.characterEffect10094 = var_559_6
				end
			end

			local var_559_7 = 0.5

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_7 then
				if arg_556_1.var_.characterEffect10094 then
					arg_556_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_556_1.var_.alphaOldValue10094, 0.6, (arg_556_1.time_ - 0) / var_559_7)
				end
			end

			if arg_556_1.time_ >= 0 + var_559_7 and arg_556_1.time_ < 0 + var_559_7 + arg_559_0 and arg_556_1.var_.characterEffect10094 then
				arg_556_1.var_.characterEffect10094.alpha = 0.6
			end

			local var_559_8 = arg_556_1.actors_["10022"].transform

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.var_.moveOldPos10022 = var_559_8.localPosition
				var_559_8.localScale = Vector3.New(1, 1, 1)

				arg_556_1:CheckSpriteTmpPos("10022", 2)

				for iter_559_5 = 0, var_559_8.childCount - 1 do
					local var_559_9 = var_559_8:GetChild(iter_559_5)

					if var_559_9.name == "split_1" or not string.find(var_559_9.name, "split") then
						var_559_9.gameObject:SetActive(true)
					else
						var_559_9.gameObject:SetActive(false)
					end
				end
			end

			local var_559_10 = 0.001

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_10 then
				var_559_8.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_556_1.time_ - 0) / var_559_10)
			end

			if arg_556_1.time_ >= 0 + var_559_10 and arg_556_1.time_ < 0 + var_559_10 + arg_559_0 then
				var_559_8.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_559_11 = 0
			local var_559_12 = 0.25

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_11 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_13 = arg_556_1:GetWordFromCfg(413011135)
				local var_559_14 = arg_556_1:FormatText(var_559_13.content)

				arg_556_1.text_.text = var_559_14

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_16 = 10 <= 0 and var_559_12 or var_559_12 * (utf8.len(var_559_14) / 10)

				if (10 <= 0 and var_559_12 or var_559_12 * (utf8.len(var_559_14) / 10)) > 0 and var_559_12 < var_559_16 then
					arg_556_1.talkMaxDuration = var_559_16

					if var_559_16 + var_559_11 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_16 + var_559_11
					end
				end

				arg_556_1.text_.text = var_559_14
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011135", "story_v_out_413011.awb") ~= 0 then
					local var_559_17 = manager.audio:GetVoiceLength("story_v_out_413011", "413011135", "story_v_out_413011.awb") / 1000

					if var_559_17 + var_559_11 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_17 + var_559_11
					end

					if var_559_13.prefab_name ~= "" and arg_556_1.actors_[var_559_13.prefab_name] ~= nil then
						local var_559_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_13.prefab_name].transform, "story_v_out_413011", "413011135", "story_v_out_413011.awb")

						arg_556_1:RecordAudio("413011135", var_559_18)
						arg_556_1:RecordAudio("413011135", var_559_18)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_out_413011", "413011135", "story_v_out_413011.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_out_413011", "413011135", "story_v_out_413011.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_19 = math.max(var_559_12, arg_556_1.talkMaxDuration)

			if var_559_11 <= arg_556_1.time_ and arg_556_1.time_ < var_559_11 + var_559_19 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_11) / var_559_19

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_11 + var_559_19 and arg_556_1.time_ < var_559_11 + var_559_19 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_556_1:InitPlayNodeList()
	end,
	Play413011136 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 413011136
		arg_560_1.duration_ = 4.77

		local var_560_0 = {
			zh = 2.966,
			ja = 4.766
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
				arg_560_0:Play413011137(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 and not isNil(arg_560_1.actors_["10022"]) and arg_560_1.var_.actorSpriteComps10022 == nil then
				arg_560_1.var_.actorSpriteComps10022 = arg_560_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_563_0 = 2

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_0 and not isNil(arg_560_1.actors_["10022"]) then
				if arg_560_1.var_.actorSpriteComps10022 then
					for iter_563_0, iter_563_1 in pairs(arg_560_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_563_1 then
							if arg_560_1.isInRecall_ then
								iter_563_1.color = Color.New(Mathf.Lerp(iter_563_1.color.r, arg_560_1.hightColor1.r, (arg_560_1.time_ - 0) / var_563_0), Mathf.Lerp(iter_563_1.color.g, arg_560_1.hightColor1.g, (arg_560_1.time_ - 0) / var_563_0), (Mathf.Lerp(iter_563_1.color.b, arg_560_1.hightColor1.b, (arg_560_1.time_ - 0) / var_563_0)))
							else
								local var_563_1 = Mathf.Lerp(iter_563_1.color.r, 1, (arg_560_1.time_ - 0) / var_563_0)

								iter_563_1.color = Color.New(var_563_1, var_563_1, var_563_1)
							end
						end
					end
				end
			end

			if arg_560_1.time_ >= 0 + var_563_0 and arg_560_1.time_ < 0 + var_563_0 + arg_563_0 and not isNil(arg_560_1.actors_["10022"]) and arg_560_1.var_.actorSpriteComps10022 then
				for iter_563_2, iter_563_3 in pairs(arg_560_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_563_3 then
						iter_563_3.color = arg_560_1.isInRecall_ and (arg_560_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_560_1.var_.actorSpriteComps10022 = nil
			end

			local var_563_2 = 0
			local var_563_3 = 0.4

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_2 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_4 = arg_560_1:GetWordFromCfg(413011136)
				local var_563_5 = arg_560_1:FormatText(var_563_4.content)

				arg_560_1.text_.text = var_563_5

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_7 = 16 <= 0 and var_563_3 or var_563_3 * (utf8.len(var_563_5) / 16)

				if (16 <= 0 and var_563_3 or var_563_3 * (utf8.len(var_563_5) / 16)) > 0 and var_563_3 < var_563_7 then
					arg_560_1.talkMaxDuration = var_563_7

					if var_563_7 + var_563_2 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_7 + var_563_2
					end
				end

				arg_560_1.text_.text = var_563_5
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011136", "story_v_out_413011.awb") ~= 0 then
					local var_563_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011136", "story_v_out_413011.awb") / 1000

					if var_563_8 + var_563_2 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_8 + var_563_2
					end

					if var_563_4.prefab_name ~= "" and arg_560_1.actors_[var_563_4.prefab_name] ~= nil then
						local var_563_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_4.prefab_name].transform, "story_v_out_413011", "413011136", "story_v_out_413011.awb")

						arg_560_1:RecordAudio("413011136", var_563_9)
						arg_560_1:RecordAudio("413011136", var_563_9)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_413011", "413011136", "story_v_out_413011.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_413011", "413011136", "story_v_out_413011.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_10 = math.max(var_563_3, arg_560_1.talkMaxDuration)

			if var_563_2 <= arg_560_1.time_ and arg_560_1.time_ < var_563_2 + var_563_10 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_2) / var_563_10

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_2 + var_563_10 and arg_560_1.time_ < var_563_2 + var_563_10 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play413011137 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 413011137
		arg_564_1.duration_ = 7.5

		local var_564_0 = {
			zh = 4.1,
			ja = 7.5
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
				arg_564_0:Play413011138(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 and not isNil(arg_564_1.actors_["10022"]) and arg_564_1.var_.actorSpriteComps10022 == nil then
				arg_564_1.var_.actorSpriteComps10022 = arg_564_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_567_0 = 2

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_0 and not isNil(arg_564_1.actors_["10022"]) then
				if arg_564_1.var_.actorSpriteComps10022 then
					for iter_567_0, iter_567_1 in pairs(arg_564_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_567_1 then
							if arg_564_1.isInRecall_ then
								iter_567_1.color = Color.New(Mathf.Lerp(iter_567_1.color.r, arg_564_1.hightColor2.r, (arg_564_1.time_ - 0) / var_567_0), Mathf.Lerp(iter_567_1.color.g, arg_564_1.hightColor2.g, (arg_564_1.time_ - 0) / var_567_0), (Mathf.Lerp(iter_567_1.color.b, arg_564_1.hightColor2.b, (arg_564_1.time_ - 0) / var_567_0)))
							else
								local var_567_1 = Mathf.Lerp(iter_567_1.color.r, 0.5, (arg_564_1.time_ - 0) / var_567_0)

								iter_567_1.color = Color.New(var_567_1, var_567_1, var_567_1)
							end
						end
					end
				end
			end

			if arg_564_1.time_ >= 0 + var_567_0 and arg_564_1.time_ < 0 + var_567_0 + arg_567_0 and not isNil(arg_564_1.actors_["10022"]) and arg_564_1.var_.actorSpriteComps10022 then
				for iter_567_2, iter_567_3 in pairs(arg_564_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_567_3 then
						iter_567_3.color = arg_564_1.isInRecall_ and (arg_564_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_564_1.var_.actorSpriteComps10022 = nil
			end

			local var_567_2 = 0
			local var_567_3 = 0.425

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_2 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				arg_564_1.leftNameTxt_.text = arg_564_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_4 = arg_564_1:GetWordFromCfg(413011137)
				local var_567_5 = arg_564_1:FormatText(var_567_4.content)

				arg_564_1.text_.text = var_567_5

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_7 = 17 <= 0 and var_567_3 or var_567_3 * (utf8.len(var_567_5) / 17)

				if (17 <= 0 and var_567_3 or var_567_3 * (utf8.len(var_567_5) / 17)) > 0 and var_567_3 < var_567_7 then
					arg_564_1.talkMaxDuration = var_567_7

					if var_567_7 + var_567_2 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_7 + var_567_2
					end
				end

				arg_564_1.text_.text = var_567_5
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011137", "story_v_out_413011.awb") ~= 0 then
					local var_567_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011137", "story_v_out_413011.awb") / 1000

					if var_567_8 + var_567_2 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_8 + var_567_2
					end

					if var_567_4.prefab_name ~= "" and arg_564_1.actors_[var_567_4.prefab_name] ~= nil then
						local var_567_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_4.prefab_name].transform, "story_v_out_413011", "413011137", "story_v_out_413011.awb")

						arg_564_1:RecordAudio("413011137", var_567_9)
						arg_564_1:RecordAudio("413011137", var_567_9)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_out_413011", "413011137", "story_v_out_413011.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_out_413011", "413011137", "story_v_out_413011.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_10 = math.max(var_567_3, arg_564_1.talkMaxDuration)

			if var_567_2 <= arg_564_1.time_ and arg_564_1.time_ < var_567_2 + var_567_10 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_2) / var_567_10

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_2 + var_567_10 and arg_564_1.time_ < var_567_2 + var_567_10 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play413011138 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 413011138
		arg_568_1.duration_ = 4.8

		local var_568_0 = {
			zh = 2.666,
			ja = 4.8
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
				arg_568_0:Play413011139(arg_568_1)
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
								iter_571_1.color = Color.New(Mathf.Lerp(iter_571_1.color.r, arg_568_1.hightColor1.r, (arg_568_1.time_ - 0) / var_571_0), Mathf.Lerp(iter_571_1.color.g, arg_568_1.hightColor1.g, (arg_568_1.time_ - 0) / var_571_0), (Mathf.Lerp(iter_571_1.color.b, arg_568_1.hightColor1.b, (arg_568_1.time_ - 0) / var_571_0)))
							else
								local var_571_1 = Mathf.Lerp(iter_571_1.color.r, 1, (arg_568_1.time_ - 0) / var_571_0)

								iter_571_1.color = Color.New(var_571_1, var_571_1, var_571_1)
							end
						end
					end
				end
			end

			if arg_568_1.time_ >= 0 + var_571_0 and arg_568_1.time_ < 0 + var_571_0 + arg_571_0 and not isNil(arg_568_1.actors_["10022"]) and arg_568_1.var_.actorSpriteComps10022 then
				for iter_571_2, iter_571_3 in pairs(arg_568_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_571_3 then
						iter_571_3.color = arg_568_1.isInRecall_ and (arg_568_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_568_1.var_.actorSpriteComps10022 = nil
			end

			local var_571_2 = 0
			local var_571_3 = 0.325

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_2 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				arg_568_1.leftNameTxt_.text = arg_568_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_4 = arg_568_1:GetWordFromCfg(413011138)
				local var_571_5 = arg_568_1:FormatText(var_571_4.content)

				arg_568_1.text_.text = var_571_5

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_7 = 13 <= 0 and var_571_3 or var_571_3 * (utf8.len(var_571_5) / 13)

				if (13 <= 0 and var_571_3 or var_571_3 * (utf8.len(var_571_5) / 13)) > 0 and var_571_3 < var_571_7 then
					arg_568_1.talkMaxDuration = var_571_7

					if var_571_7 + var_571_2 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_7 + var_571_2
					end
				end

				arg_568_1.text_.text = var_571_5
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011138", "story_v_out_413011.awb") ~= 0 then
					local var_571_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011138", "story_v_out_413011.awb") / 1000

					if var_571_8 + var_571_2 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_8 + var_571_2
					end

					if var_571_4.prefab_name ~= "" and arg_568_1.actors_[var_571_4.prefab_name] ~= nil then
						local var_571_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_4.prefab_name].transform, "story_v_out_413011", "413011138", "story_v_out_413011.awb")

						arg_568_1:RecordAudio("413011138", var_571_9)
						arg_568_1:RecordAudio("413011138", var_571_9)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_out_413011", "413011138", "story_v_out_413011.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_out_413011", "413011138", "story_v_out_413011.awb")
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
	Play413011139 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 413011139
		arg_572_1.duration_ = 9.87

		local var_572_0 = {
			zh = 6.666,
			ja = 9.866
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
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play413011140(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 and not isNil(arg_572_1.actors_["10022"]) and arg_572_1.var_.actorSpriteComps10022 == nil then
				arg_572_1.var_.actorSpriteComps10022 = arg_572_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_575_0 = 2

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_0 and not isNil(arg_572_1.actors_["10022"]) then
				if arg_572_1.var_.actorSpriteComps10022 then
					for iter_575_0, iter_575_1 in pairs(arg_572_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_575_1 then
							if arg_572_1.isInRecall_ then
								iter_575_1.color = Color.New(Mathf.Lerp(iter_575_1.color.r, arg_572_1.hightColor2.r, (arg_572_1.time_ - 0) / var_575_0), Mathf.Lerp(iter_575_1.color.g, arg_572_1.hightColor2.g, (arg_572_1.time_ - 0) / var_575_0), (Mathf.Lerp(iter_575_1.color.b, arg_572_1.hightColor2.b, (arg_572_1.time_ - 0) / var_575_0)))
							else
								local var_575_1 = Mathf.Lerp(iter_575_1.color.r, 0.5, (arg_572_1.time_ - 0) / var_575_0)

								iter_575_1.color = Color.New(var_575_1, var_575_1, var_575_1)
							end
						end
					end
				end
			end

			if arg_572_1.time_ >= 0 + var_575_0 and arg_572_1.time_ < 0 + var_575_0 + arg_575_0 and not isNil(arg_572_1.actors_["10022"]) and arg_572_1.var_.actorSpriteComps10022 then
				for iter_575_2, iter_575_3 in pairs(arg_572_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_575_3 then
						iter_575_3.color = arg_572_1.isInRecall_ and (arg_572_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_572_1.var_.actorSpriteComps10022 = nil
			end

			local var_575_2 = arg_572_1.actors_["10094"].transform

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.var_.moveOldPos10094 = var_575_2.localPosition
				var_575_2.localScale = Vector3.New(1, 1, 1)

				arg_572_1:CheckSpriteTmpPos("10094", 4)

				for iter_575_4 = 0, var_575_2.childCount - 1 do
					local var_575_3 = var_575_2:GetChild(iter_575_4)

					if var_575_3.name == "split_2" or not string.find(var_575_3.name, "split") then
						var_575_3.gameObject:SetActive(true)
					else
						var_575_3.gameObject:SetActive(false)
					end
				end
			end

			local var_575_4 = 0.001

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_4 then
				var_575_2.localPosition = Vector3.Lerp(arg_572_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_572_1.time_ - 0) / var_575_4)
			end

			if arg_572_1.time_ >= 0 + var_575_4 and arg_572_1.time_ < 0 + var_575_4 + arg_575_0 then
				var_575_2.localPosition = Vector3.New(390, -340, -414)
			end

			local var_575_5 = 0
			local var_575_6 = 0.775

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_5 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_7 = arg_572_1:GetWordFromCfg(413011139)
				local var_575_8 = arg_572_1:FormatText(var_575_7.content)

				arg_572_1.text_.text = var_575_8

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_10 = 31 <= 0 and var_575_6 or var_575_6 * (utf8.len(var_575_8) / 31)

				if (31 <= 0 and var_575_6 or var_575_6 * (utf8.len(var_575_8) / 31)) > 0 and var_575_6 < var_575_10 then
					arg_572_1.talkMaxDuration = var_575_10

					if var_575_10 + var_575_5 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_10 + var_575_5
					end
				end

				arg_572_1.text_.text = var_575_8
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011139", "story_v_out_413011.awb") ~= 0 then
					local var_575_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011139", "story_v_out_413011.awb") / 1000

					if var_575_11 + var_575_5 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_11 + var_575_5
					end

					if var_575_7.prefab_name ~= "" and arg_572_1.actors_[var_575_7.prefab_name] ~= nil then
						local var_575_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_7.prefab_name].transform, "story_v_out_413011", "413011139", "story_v_out_413011.awb")

						arg_572_1:RecordAudio("413011139", var_575_12)
						arg_572_1:RecordAudio("413011139", var_575_12)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_413011", "413011139", "story_v_out_413011.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_413011", "413011139", "story_v_out_413011.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_13 = math.max(var_575_6, arg_572_1.talkMaxDuration)

			if var_575_5 <= arg_572_1.time_ and arg_572_1.time_ < var_575_5 + var_575_13 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_5) / var_575_13

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_5 + var_575_13 and arg_572_1.time_ < var_575_5 + var_575_13 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {
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

		arg_572_1:InitPlayNodeList()
	end,
	Play413011140 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 413011140
		arg_576_1.duration_ = 9.3

		local var_576_0 = {
			zh = 9.3,
			ja = 7.133
		}
		local var_576_1 = manager.audio:GetLocalizationFlag()

		if var_576_0[var_576_1] ~= nil then
			arg_576_1.duration_ = var_576_0[var_576_1]
		end

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play413011141(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 and not isNil(arg_576_1.actors_["10022"]) and arg_576_1.var_.actorSpriteComps10022 == nil then
				arg_576_1.var_.actorSpriteComps10022 = arg_576_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_579_0 = 2

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_0 and not isNil(arg_576_1.actors_["10022"]) then
				if arg_576_1.var_.actorSpriteComps10022 then
					for iter_579_0, iter_579_1 in pairs(arg_576_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_579_1 then
							if arg_576_1.isInRecall_ then
								iter_579_1.color = Color.New(Mathf.Lerp(iter_579_1.color.r, arg_576_1.hightColor1.r, (arg_576_1.time_ - 0) / var_579_0), Mathf.Lerp(iter_579_1.color.g, arg_576_1.hightColor1.g, (arg_576_1.time_ - 0) / var_579_0), (Mathf.Lerp(iter_579_1.color.b, arg_576_1.hightColor1.b, (arg_576_1.time_ - 0) / var_579_0)))
							else
								local var_579_1 = Mathf.Lerp(iter_579_1.color.r, 1, (arg_576_1.time_ - 0) / var_579_0)

								iter_579_1.color = Color.New(var_579_1, var_579_1, var_579_1)
							end
						end
					end
				end
			end

			if arg_576_1.time_ >= 0 + var_579_0 and arg_576_1.time_ < 0 + var_579_0 + arg_579_0 and not isNil(arg_576_1.actors_["10022"]) and arg_576_1.var_.actorSpriteComps10022 then
				for iter_579_2, iter_579_3 in pairs(arg_576_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_579_3 then
						iter_579_3.color = arg_576_1.isInRecall_ and (arg_576_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_576_1.var_.actorSpriteComps10022 = nil
			end

			local var_579_2 = 0
			local var_579_3 = 1.075

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_2 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				arg_576_1.leftNameTxt_.text = arg_576_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_4 = arg_576_1:GetWordFromCfg(413011140)
				local var_579_5 = arg_576_1:FormatText(var_579_4.content)

				arg_576_1.text_.text = var_579_5

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_7 = 43 <= 0 and var_579_3 or var_579_3 * (utf8.len(var_579_5) / 43)

				if (43 <= 0 and var_579_3 or var_579_3 * (utf8.len(var_579_5) / 43)) > 0 and var_579_3 < var_579_7 then
					arg_576_1.talkMaxDuration = var_579_7

					if var_579_7 + var_579_2 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_7 + var_579_2
					end
				end

				arg_576_1.text_.text = var_579_5
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011140", "story_v_out_413011.awb") ~= 0 then
					local var_579_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011140", "story_v_out_413011.awb") / 1000

					if var_579_8 + var_579_2 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_8 + var_579_2
					end

					if var_579_4.prefab_name ~= "" and arg_576_1.actors_[var_579_4.prefab_name] ~= nil then
						local var_579_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_576_1.actors_[var_579_4.prefab_name].transform, "story_v_out_413011", "413011140", "story_v_out_413011.awb")

						arg_576_1:RecordAudio("413011140", var_579_9)
						arg_576_1:RecordAudio("413011140", var_579_9)
					else
						arg_576_1:AudioAction("play", "voice", "story_v_out_413011", "413011140", "story_v_out_413011.awb")
					end

					arg_576_1:RecordHistoryTalkVoice("story_v_out_413011", "413011140", "story_v_out_413011.awb")
				end

				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_10 = math.max(var_579_3, arg_576_1.talkMaxDuration)

			if var_579_2 <= arg_576_1.time_ and arg_576_1.time_ < var_579_2 + var_579_10 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_2) / var_579_10

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_2 + var_579_10 and arg_576_1.time_ < var_579_2 + var_579_10 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play413011141 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 413011141
		arg_580_1.duration_ = 12.2

		local var_580_0 = {
			zh = 3.633,
			ja = 12.2
		}
		local var_580_1 = manager.audio:GetLocalizationFlag()

		if var_580_0[var_580_1] ~= nil then
			arg_580_1.duration_ = var_580_0[var_580_1]
		end

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play413011142(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 and not isNil(arg_580_1.actors_["10022"]) and arg_580_1.var_.actorSpriteComps10022 == nil then
				arg_580_1.var_.actorSpriteComps10022 = arg_580_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_583_0 = 2

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_0 and not isNil(arg_580_1.actors_["10022"]) then
				if arg_580_1.var_.actorSpriteComps10022 then
					for iter_583_0, iter_583_1 in pairs(arg_580_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_583_1 then
							if arg_580_1.isInRecall_ then
								iter_583_1.color = Color.New(Mathf.Lerp(iter_583_1.color.r, arg_580_1.hightColor2.r, (arg_580_1.time_ - 0) / var_583_0), Mathf.Lerp(iter_583_1.color.g, arg_580_1.hightColor2.g, (arg_580_1.time_ - 0) / var_583_0), (Mathf.Lerp(iter_583_1.color.b, arg_580_1.hightColor2.b, (arg_580_1.time_ - 0) / var_583_0)))
							else
								local var_583_1 = Mathf.Lerp(iter_583_1.color.r, 0.5, (arg_580_1.time_ - 0) / var_583_0)

								iter_583_1.color = Color.New(var_583_1, var_583_1, var_583_1)
							end
						end
					end
				end
			end

			if arg_580_1.time_ >= 0 + var_583_0 and arg_580_1.time_ < 0 + var_583_0 + arg_583_0 and not isNil(arg_580_1.actors_["10022"]) and arg_580_1.var_.actorSpriteComps10022 then
				for iter_583_2, iter_583_3 in pairs(arg_580_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_583_3 then
						iter_583_3.color = arg_580_1.isInRecall_ and (arg_580_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_580_1.var_.actorSpriteComps10022 = nil
			end

			local var_583_2 = 0
			local var_583_3 = 0.4

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_2 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				arg_580_1.leftNameTxt_.text = arg_580_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_4 = arg_580_1:GetWordFromCfg(413011141)
				local var_583_5 = arg_580_1:FormatText(var_583_4.content)

				arg_580_1.text_.text = var_583_5

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_7 = 16 <= 0 and var_583_3 or var_583_3 * (utf8.len(var_583_5) / 16)

				if (16 <= 0 and var_583_3 or var_583_3 * (utf8.len(var_583_5) / 16)) > 0 and var_583_3 < var_583_7 then
					arg_580_1.talkMaxDuration = var_583_7

					if var_583_7 + var_583_2 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_7 + var_583_2
					end
				end

				arg_580_1.text_.text = var_583_5
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011141", "story_v_out_413011.awb") ~= 0 then
					local var_583_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011141", "story_v_out_413011.awb") / 1000

					if var_583_8 + var_583_2 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_8 + var_583_2
					end

					if var_583_4.prefab_name ~= "" and arg_580_1.actors_[var_583_4.prefab_name] ~= nil then
						local var_583_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_580_1.actors_[var_583_4.prefab_name].transform, "story_v_out_413011", "413011141", "story_v_out_413011.awb")

						arg_580_1:RecordAudio("413011141", var_583_9)
						arg_580_1:RecordAudio("413011141", var_583_9)
					else
						arg_580_1:AudioAction("play", "voice", "story_v_out_413011", "413011141", "story_v_out_413011.awb")
					end

					arg_580_1:RecordHistoryTalkVoice("story_v_out_413011", "413011141", "story_v_out_413011.awb")
				end

				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_10 = math.max(var_583_3, arg_580_1.talkMaxDuration)

			if var_583_2 <= arg_580_1.time_ and arg_580_1.time_ < var_583_2 + var_583_10 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_2) / var_583_10

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_2 + var_583_10 and arg_580_1.time_ < var_583_2 + var_583_10 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play413011142 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 413011142
		arg_584_1.duration_ = 4.1

		local var_584_0 = {
			zh = 2.5,
			ja = 4.1
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play413011143(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 and not isNil(arg_584_1.actors_["10022"]) and arg_584_1.var_.actorSpriteComps10022 == nil then
				arg_584_1.var_.actorSpriteComps10022 = arg_584_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_587_0 = 2

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_0 and not isNil(arg_584_1.actors_["10022"]) then
				if arg_584_1.var_.actorSpriteComps10022 then
					for iter_587_0, iter_587_1 in pairs(arg_584_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_587_1 then
							if arg_584_1.isInRecall_ then
								iter_587_1.color = Color.New(Mathf.Lerp(iter_587_1.color.r, arg_584_1.hightColor1.r, (arg_584_1.time_ - 0) / var_587_0), Mathf.Lerp(iter_587_1.color.g, arg_584_1.hightColor1.g, (arg_584_1.time_ - 0) / var_587_0), (Mathf.Lerp(iter_587_1.color.b, arg_584_1.hightColor1.b, (arg_584_1.time_ - 0) / var_587_0)))
							else
								local var_587_1 = Mathf.Lerp(iter_587_1.color.r, 1, (arg_584_1.time_ - 0) / var_587_0)

								iter_587_1.color = Color.New(var_587_1, var_587_1, var_587_1)
							end
						end
					end
				end
			end

			if arg_584_1.time_ >= 0 + var_587_0 and arg_584_1.time_ < 0 + var_587_0 + arg_587_0 and not isNil(arg_584_1.actors_["10022"]) and arg_584_1.var_.actorSpriteComps10022 then
				for iter_587_2, iter_587_3 in pairs(arg_584_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_587_3 then
						iter_587_3.color = arg_584_1.isInRecall_ and (arg_584_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_584_1.var_.actorSpriteComps10022 = nil
			end

			local var_587_2 = arg_584_1.actors_["10022"].transform

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1.var_.moveOldPos10022 = var_587_2.localPosition
				var_587_2.localScale = Vector3.New(1, 1, 1)

				arg_584_1:CheckSpriteTmpPos("10022", 2)

				for iter_587_4 = 0, var_587_2.childCount - 1 do
					local var_587_3 = var_587_2:GetChild(iter_587_4)

					if var_587_3.name == "split_3" or not string.find(var_587_3.name, "split") then
						var_587_3.gameObject:SetActive(true)
					else
						var_587_3.gameObject:SetActive(false)
					end
				end
			end

			local var_587_4 = 0.001

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_4 then
				var_587_2.localPosition = Vector3.Lerp(arg_584_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_584_1.time_ - 0) / var_587_4)
			end

			if arg_584_1.time_ >= 0 + var_587_4 and arg_584_1.time_ < 0 + var_587_4 + arg_587_0 then
				var_587_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_587_5 = 0
			local var_587_6 = 0.275

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_5 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				arg_584_1.leftNameTxt_.text = arg_584_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_7 = arg_584_1:GetWordFromCfg(413011142)
				local var_587_8 = arg_584_1:FormatText(var_587_7.content)

				arg_584_1.text_.text = var_587_8

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_10 = 11 <= 0 and var_587_6 or var_587_6 * (utf8.len(var_587_8) / 11)

				if (11 <= 0 and var_587_6 or var_587_6 * (utf8.len(var_587_8) / 11)) > 0 and var_587_6 < var_587_10 then
					arg_584_1.talkMaxDuration = var_587_10

					if var_587_10 + var_587_5 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_10 + var_587_5
					end
				end

				arg_584_1.text_.text = var_587_8
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011142", "story_v_out_413011.awb") ~= 0 then
					local var_587_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011142", "story_v_out_413011.awb") / 1000

					if var_587_11 + var_587_5 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_11 + var_587_5
					end

					if var_587_7.prefab_name ~= "" and arg_584_1.actors_[var_587_7.prefab_name] ~= nil then
						local var_587_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_7.prefab_name].transform, "story_v_out_413011", "413011142", "story_v_out_413011.awb")

						arg_584_1:RecordAudio("413011142", var_587_12)
						arg_584_1:RecordAudio("413011142", var_587_12)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_out_413011", "413011142", "story_v_out_413011.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_out_413011", "413011142", "story_v_out_413011.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_13 = math.max(var_587_6, arg_584_1.talkMaxDuration)

			if var_587_5 <= arg_584_1.time_ and arg_584_1.time_ < var_587_5 + var_587_13 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_5) / var_587_13

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_5 + var_587_13 and arg_584_1.time_ < var_587_5 + var_587_13 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {
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

		arg_584_1:InitPlayNodeList()
	end,
	Play413011143 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 413011143
		arg_588_1.duration_ = 7.1

		local var_588_0 = {
			zh = 4,
			ja = 7.1
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play413011144(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 and not isNil(arg_588_1.actors_["10022"]) and arg_588_1.var_.actorSpriteComps10022 == nil then
				arg_588_1.var_.actorSpriteComps10022 = arg_588_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_591_0 = 2

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_0 and not isNil(arg_588_1.actors_["10022"]) then
				if arg_588_1.var_.actorSpriteComps10022 then
					for iter_591_0, iter_591_1 in pairs(arg_588_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_591_1 then
							if arg_588_1.isInRecall_ then
								iter_591_1.color = Color.New(Mathf.Lerp(iter_591_1.color.r, arg_588_1.hightColor2.r, (arg_588_1.time_ - 0) / var_591_0), Mathf.Lerp(iter_591_1.color.g, arg_588_1.hightColor2.g, (arg_588_1.time_ - 0) / var_591_0), (Mathf.Lerp(iter_591_1.color.b, arg_588_1.hightColor2.b, (arg_588_1.time_ - 0) / var_591_0)))
							else
								local var_591_1 = Mathf.Lerp(iter_591_1.color.r, 0.5, (arg_588_1.time_ - 0) / var_591_0)

								iter_591_1.color = Color.New(var_591_1, var_591_1, var_591_1)
							end
						end
					end
				end
			end

			if arg_588_1.time_ >= 0 + var_591_0 and arg_588_1.time_ < 0 + var_591_0 + arg_591_0 and not isNil(arg_588_1.actors_["10022"]) and arg_588_1.var_.actorSpriteComps10022 then
				for iter_591_2, iter_591_3 in pairs(arg_588_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_591_3 then
						iter_591_3.color = arg_588_1.isInRecall_ and (arg_588_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_588_1.var_.actorSpriteComps10022 = nil
			end

			local var_591_2 = 0
			local var_591_3 = 0.375

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_2 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				arg_588_1.leftNameTxt_.text = arg_588_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_4 = arg_588_1:GetWordFromCfg(413011143)
				local var_591_5 = arg_588_1:FormatText(var_591_4.content)

				arg_588_1.text_.text = var_591_5

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_7 = 15 <= 0 and var_591_3 or var_591_3 * (utf8.len(var_591_5) / 15)

				if (15 <= 0 and var_591_3 or var_591_3 * (utf8.len(var_591_5) / 15)) > 0 and var_591_3 < var_591_7 then
					arg_588_1.talkMaxDuration = var_591_7

					if var_591_7 + var_591_2 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_7 + var_591_2
					end
				end

				arg_588_1.text_.text = var_591_5
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011143", "story_v_out_413011.awb") ~= 0 then
					local var_591_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011143", "story_v_out_413011.awb") / 1000

					if var_591_8 + var_591_2 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_8 + var_591_2
					end

					if var_591_4.prefab_name ~= "" and arg_588_1.actors_[var_591_4.prefab_name] ~= nil then
						local var_591_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_4.prefab_name].transform, "story_v_out_413011", "413011143", "story_v_out_413011.awb")

						arg_588_1:RecordAudio("413011143", var_591_9)
						arg_588_1:RecordAudio("413011143", var_591_9)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_out_413011", "413011143", "story_v_out_413011.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_out_413011", "413011143", "story_v_out_413011.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_10 = math.max(var_591_3, arg_588_1.talkMaxDuration)

			if var_591_2 <= arg_588_1.time_ and arg_588_1.time_ < var_591_2 + var_591_10 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_2) / var_591_10

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_2 + var_591_10 and arg_588_1.time_ < var_591_2 + var_591_10 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play413011144 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 413011144
		arg_592_1.duration_ = 7.17

		local var_592_0 = {
			zh = 3.433,
			ja = 7.166
		}
		local var_592_1 = manager.audio:GetLocalizationFlag()

		if var_592_0[var_592_1] ~= nil then
			arg_592_1.duration_ = var_592_0[var_592_1]
		end

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play413011145(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 0.35

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				arg_592_1.leftNameTxt_.text = arg_592_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_1 = arg_592_1:GetWordFromCfg(413011144)
				local var_595_2 = arg_592_1:FormatText(var_595_1.content)

				arg_592_1.text_.text = var_595_2

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_4 = 14 <= 0 and var_595_0 or var_595_0 * (utf8.len(var_595_2) / 14)

				if (14 <= 0 and var_595_0 or var_595_0 * (utf8.len(var_595_2) / 14)) > 0 and var_595_0 < var_595_4 then
					arg_592_1.talkMaxDuration = var_595_4

					if var_595_4 + 0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_4 + 0
					end
				end

				arg_592_1.text_.text = var_595_2
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011144", "story_v_out_413011.awb") ~= 0 then
					local var_595_5 = manager.audio:GetVoiceLength("story_v_out_413011", "413011144", "story_v_out_413011.awb") / 1000

					if var_595_5 + 0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_5 + 0
					end

					if var_595_1.prefab_name ~= "" and arg_592_1.actors_[var_595_1.prefab_name] ~= nil then
						local var_595_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_1.prefab_name].transform, "story_v_out_413011", "413011144", "story_v_out_413011.awb")

						arg_592_1:RecordAudio("413011144", var_595_6)
						arg_592_1:RecordAudio("413011144", var_595_6)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_out_413011", "413011144", "story_v_out_413011.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_out_413011", "413011144", "story_v_out_413011.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_7 = math.max(var_595_0, arg_592_1.talkMaxDuration)

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_7 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - 0) / var_595_7

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= 0 + var_595_7 and arg_592_1.time_ < 0 + var_595_7 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play413011145 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 413011145
		arg_596_1.duration_ = 3.81

		local var_596_0 = {
			zh = 3.775,
			ja = 3.808
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play413011146(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_599_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_596_1.bgmTxt_.text ~= var_599_2 and arg_596_1.bgmTxt_.text ~= "" then
						if arg_596_1.bgmTxt2_.text ~= "" then
							arg_596_1.bgmTxt_.text = arg_596_1.bgmTxt2_.text
						end

						arg_596_1.bgmTxt2_.text = var_599_2

						arg_596_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_596_1.bgmTxt_.text = var_599_2
						arg_596_1.bgmTxt2_.text = var_599_2
					end

					if arg_596_1.bgmTimer then
						arg_596_1.bgmTimer:Stop()

						arg_596_1.bgmTimer = nil
					end

					if arg_596_1.settingData.show_music_name == 1 then
						arg_596_1.musicController:SetSelectedState("show")
						arg_596_1.musicAnimator_:Play("open", 0, 0)

						if arg_596_1.settingData.music_time ~= 0 then
							arg_596_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_596_1.settingData.music_time), function()
								if arg_596_1 == nil or isNil(arg_596_1.bgmTxt_) then
									return
								end

								arg_596_1.musicController:SetSelectedState("hide")
								arg_596_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_599_3 = arg_596_1.actors_["10022"].transform

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1.var_.moveOldPos10022 = var_599_3.localPosition
				var_599_3.localScale = Vector3.New(1, 1, 1)

				arg_596_1:CheckSpriteTmpPos("10022", 3)

				for iter_599_0 = 0, var_599_3.childCount - 1 do
					local var_599_4 = var_599_3:GetChild(iter_599_0)

					if var_599_4.name == "split_1" or not string.find(var_599_4.name, "split") then
						var_599_4.gameObject:SetActive(true)
					else
						var_599_4.gameObject:SetActive(false)
					end
				end
			end

			local var_599_5 = 0.001

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_5 then
				var_599_3.localPosition = Vector3.Lerp(arg_596_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_596_1.time_ - 0) / var_599_5)
			end

			if arg_596_1.time_ >= 0 + var_599_5 and arg_596_1.time_ < 0 + var_599_5 + arg_599_0 then
				var_599_3.localPosition = Vector3.New(0, -315, -320)
			end

			local var_599_6 = arg_596_1.actors_["10094"].transform

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1.var_.moveOldPos10094 = var_599_6.localPosition
				var_599_6.localScale = Vector3.New(1, 1, 1)

				arg_596_1:CheckSpriteTmpPos("10094", 7)

				for iter_599_1 = 0, var_599_6.childCount - 1 do
					local var_599_7 = var_599_6:GetChild(iter_599_1)

					if var_599_7.name == "split_1" or not string.find(var_599_7.name, "split") then
						var_599_7.gameObject:SetActive(true)
					else
						var_599_7.gameObject:SetActive(false)
					end
				end
			end

			local var_599_8 = 0.001

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_8 then
				var_599_6.localPosition = Vector3.Lerp(arg_596_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_596_1.time_ - 0) / var_599_8)
			end

			if arg_596_1.time_ >= 0 + var_599_8 and arg_596_1.time_ < 0 + var_599_8 + arg_599_0 then
				var_599_6.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				local var_599_9 = arg_596_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_599_9 then
					arg_596_1.var_.alphaOldValue10094 = var_599_9.alpha
					arg_596_1.var_.characterEffect10094 = var_599_9
				end

				arg_596_1.var_.alphaOldValue10094 = 0
			end

			local var_599_10 = 1

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_10 then
				if arg_596_1.var_.characterEffect10094 then
					arg_596_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_596_1.var_.alphaOldValue10094, 1, (arg_596_1.time_ - 0) / var_599_10)
				end
			end

			if arg_596_1.time_ >= 0 + var_599_10 and arg_596_1.time_ < 0 + var_599_10 + arg_599_0 and arg_596_1.var_.characterEffect10094 then
				arg_596_1.var_.characterEffect10094.alpha = 1
			end

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1:SetSpriteNiuquEffect("10094", false)
			end

			if arg_596_1.frameCnt_ <= 1 then
				arg_596_1.dialog_:SetActive(false)
			end

			local var_599_12 = 0.775
			local var_599_13 = 0.225

			if 0.775 < arg_596_1.time_ and arg_596_1.time_ <= var_599_12 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0

				arg_596_1.dialog_:SetActive(true)

				arg_596_1.dialogCg_.alpha = 0

				local var_599_14 = LeanTween.value(arg_596_1.dialog_, 0, 1, 0.3)

				var_599_14:setOnUpdate(LuaHelper.FloatAction(function(arg_601_0)
					arg_596_1.dialogCg_.alpha = arg_601_0
				end))
				var_599_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_596_1.dialog_)
					var_599_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_596_1.duration_ = arg_596_1.duration_ + 0.3

				SetActive(arg_596_1.leftNameGo_, true)

				arg_596_1.leftNameTxt_.text = arg_596_1:FormatText(StoryNameCfg[997].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, true)
				arg_596_1.iconController_:SetSelectedState("hero")

				arg_596_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_596_1.callingController_:SetSelectedState("calling")

				arg_596_1.keyicon_.color = Color.New(1, 1, 1)
				arg_596_1.icon_.color = Color.New(1, 1, 1)

				local var_599_15 = arg_596_1:GetWordFromCfg(413011145)
				local var_599_16 = arg_596_1:FormatText(var_599_15.content)

				arg_596_1.text_.text = var_599_16

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_18 = 9 <= 0 and var_599_13 or var_599_13 * (utf8.len(var_599_16) / 9)

				if (9 <= 0 and var_599_13 or var_599_13 * (utf8.len(var_599_16) / 9)) > 0 and var_599_13 < var_599_18 then
					arg_596_1.talkMaxDuration = var_599_18
					var_599_12 = var_599_12 + 0.3

					if var_599_18 + var_599_12 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_18 + var_599_12
					end
				end

				arg_596_1.text_.text = var_599_16
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011145", "story_v_out_413011.awb") ~= 0 then
					local var_599_19 = manager.audio:GetVoiceLength("story_v_out_413011", "413011145", "story_v_out_413011.awb") / 1000

					if var_599_19 + var_599_12 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_19 + var_599_12
					end

					if var_599_15.prefab_name ~= "" and arg_596_1.actors_[var_599_15.prefab_name] ~= nil then
						local var_599_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_15.prefab_name].transform, "story_v_out_413011", "413011145", "story_v_out_413011.awb")

						arg_596_1:RecordAudio("413011145", var_599_20)
						arg_596_1:RecordAudio("413011145", var_599_20)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_out_413011", "413011145", "story_v_out_413011.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_out_413011", "413011145", "story_v_out_413011.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_21 = var_599_12 + 0.3
			local var_599_22 = math.max(var_599_13, arg_596_1.talkMaxDuration)

			if var_599_12 + 0.3 <= arg_596_1.time_ and arg_596_1.time_ < var_599_21 + var_599_22 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_21) / var_599_22

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_21 + var_599_22 and arg_596_1.time_ < var_599_21 + var_599_22 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {
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

		arg_596_1:InitPlayNodeList()
	end,
	Play413011146 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 413011146
		arg_603_1.duration_ = 2

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play413011147(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(arg_603_1.actors_["10022"]) and arg_603_1.var_.actorSpriteComps10022 == nil then
				arg_603_1.var_.actorSpriteComps10022 = arg_603_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_606_0 = 2

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_0 and not isNil(arg_603_1.actors_["10022"]) then
				if arg_603_1.var_.actorSpriteComps10022 then
					for iter_606_0, iter_606_1 in pairs(arg_603_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_606_1 then
							if arg_603_1.isInRecall_ then
								iter_606_1.color = Color.New(Mathf.Lerp(iter_606_1.color.r, arg_603_1.hightColor1.r, (arg_603_1.time_ - 0) / var_606_0), Mathf.Lerp(iter_606_1.color.g, arg_603_1.hightColor1.g, (arg_603_1.time_ - 0) / var_606_0), (Mathf.Lerp(iter_606_1.color.b, arg_603_1.hightColor1.b, (arg_603_1.time_ - 0) / var_606_0)))
							else
								local var_606_1 = Mathf.Lerp(iter_606_1.color.r, 1, (arg_603_1.time_ - 0) / var_606_0)

								iter_606_1.color = Color.New(var_606_1, var_606_1, var_606_1)
							end
						end
					end
				end
			end

			if arg_603_1.time_ >= 0 + var_606_0 and arg_603_1.time_ < 0 + var_606_0 + arg_606_0 and not isNil(arg_603_1.actors_["10022"]) and arg_603_1.var_.actorSpriteComps10022 then
				for iter_606_2, iter_606_3 in pairs(arg_603_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_606_3 then
						iter_606_3.color = arg_603_1.isInRecall_ and (arg_603_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_603_1.var_.actorSpriteComps10022 = nil
			end

			local var_606_2 = 0
			local var_606_3 = 0.125

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_2 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_4 = arg_603_1:GetWordFromCfg(413011146)
				local var_606_5 = arg_603_1:FormatText(var_606_4.content)

				arg_603_1.text_.text = var_606_5

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_7 = 5 <= 0 and var_606_3 or var_606_3 * (utf8.len(var_606_5) / 5)

				if (5 <= 0 and var_606_3 or var_606_3 * (utf8.len(var_606_5) / 5)) > 0 and var_606_3 < var_606_7 then
					arg_603_1.talkMaxDuration = var_606_7

					if var_606_7 + var_606_2 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_7 + var_606_2
					end
				end

				arg_603_1.text_.text = var_606_5
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011146", "story_v_out_413011.awb") ~= 0 then
					local var_606_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011146", "story_v_out_413011.awb") / 1000

					if var_606_8 + var_606_2 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_8 + var_606_2
					end

					if var_606_4.prefab_name ~= "" and arg_603_1.actors_[var_606_4.prefab_name] ~= nil then
						local var_606_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_4.prefab_name].transform, "story_v_out_413011", "413011146", "story_v_out_413011.awb")

						arg_603_1:RecordAudio("413011146", var_606_9)
						arg_603_1:RecordAudio("413011146", var_606_9)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_out_413011", "413011146", "story_v_out_413011.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_out_413011", "413011146", "story_v_out_413011.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_10 = math.max(var_606_3, arg_603_1.talkMaxDuration)

			if var_606_2 <= arg_603_1.time_ and arg_603_1.time_ < var_606_2 + var_606_10 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_2) / var_606_10

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_2 + var_606_10 and arg_603_1.time_ < var_606_2 + var_606_10 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play413011147 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 413011147
		arg_607_1.duration_ = 4.6

		local var_607_0 = {
			zh = 3,
			ja = 4.6
		}
		local var_607_1 = manager.audio:GetLocalizationFlag()

		if var_607_0[var_607_1] ~= nil then
			arg_607_1.duration_ = var_607_0[var_607_1]
		end

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play413011148(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 and not isNil(arg_607_1.actors_["10022"]) and arg_607_1.var_.actorSpriteComps10022 == nil then
				arg_607_1.var_.actorSpriteComps10022 = arg_607_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_610_0 = 2

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_0 and not isNil(arg_607_1.actors_["10022"]) then
				if arg_607_1.var_.actorSpriteComps10022 then
					for iter_610_0, iter_610_1 in pairs(arg_607_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_610_1 then
							if arg_607_1.isInRecall_ then
								iter_610_1.color = Color.New(Mathf.Lerp(iter_610_1.color.r, arg_607_1.hightColor2.r, (arg_607_1.time_ - 0) / var_610_0), Mathf.Lerp(iter_610_1.color.g, arg_607_1.hightColor2.g, (arg_607_1.time_ - 0) / var_610_0), (Mathf.Lerp(iter_610_1.color.b, arg_607_1.hightColor2.b, (arg_607_1.time_ - 0) / var_610_0)))
							else
								local var_610_1 = Mathf.Lerp(iter_610_1.color.r, 0.5, (arg_607_1.time_ - 0) / var_610_0)

								iter_610_1.color = Color.New(var_610_1, var_610_1, var_610_1)
							end
						end
					end
				end
			end

			if arg_607_1.time_ >= 0 + var_610_0 and arg_607_1.time_ < 0 + var_610_0 + arg_610_0 and not isNil(arg_607_1.actors_["10022"]) and arg_607_1.var_.actorSpriteComps10022 then
				for iter_610_2, iter_610_3 in pairs(arg_607_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_610_3 then
						iter_610_3.color = arg_607_1.isInRecall_ and (arg_607_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_607_1.var_.actorSpriteComps10022 = nil
			end

			local var_610_2 = 0
			local var_610_3 = 0.2

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_2 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[997].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_607_1.callingController_:SetSelectedState("calling")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_4 = arg_607_1:GetWordFromCfg(413011147)
				local var_610_5 = arg_607_1:FormatText(var_610_4.content)

				arg_607_1.text_.text = var_610_5

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_7 = 8 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_5) / 8)

				if (8 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_5) / 8)) > 0 and var_610_3 < var_610_7 then
					arg_607_1.talkMaxDuration = var_610_7

					if var_610_7 + var_610_2 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_7 + var_610_2
					end
				end

				arg_607_1.text_.text = var_610_5
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011147", "story_v_out_413011.awb") ~= 0 then
					local var_610_8 = manager.audio:GetVoiceLength("story_v_out_413011", "413011147", "story_v_out_413011.awb") / 1000

					if var_610_8 + var_610_2 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_8 + var_610_2
					end

					if var_610_4.prefab_name ~= "" and arg_607_1.actors_[var_610_4.prefab_name] ~= nil then
						local var_610_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_4.prefab_name].transform, "story_v_out_413011", "413011147", "story_v_out_413011.awb")

						arg_607_1:RecordAudio("413011147", var_610_9)
						arg_607_1:RecordAudio("413011147", var_610_9)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_out_413011", "413011147", "story_v_out_413011.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_out_413011", "413011147", "story_v_out_413011.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_10 = math.max(var_610_3, arg_607_1.talkMaxDuration)

			if var_610_2 <= arg_607_1.time_ and arg_607_1.time_ < var_610_2 + var_610_10 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_2) / var_610_10

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_2 + var_610_10 and arg_607_1.time_ < var_610_2 + var_610_10 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play413011148 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 413011148
		arg_611_1.duration_ = 5.83

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play413011149(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_9000

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.var_.moveOldPos10022 = arg_611_1.actors_["10022"].transform.localPosition
				arg_611_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_611_1:CheckSpriteTmpPos("10022", 7)

				for iter_614_0 = 0, arg_611_1.actors_["10022"].transform.childCount - 1 do
					local var_614_0 = arg_611_1.actors_["10022"].transform:GetChild(iter_614_0)

					if var_614_0.name == "" or not string.find(var_614_0.name, "split") then
						var_614_0.gameObject:SetActive(true)
					else
						var_614_0.gameObject:SetActive(false)
					end
				end
			end

			local var_614_1 = 0.001

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_1 then
				arg_611_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_611_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_611_1.time_ - 0) / var_614_1)
			end

			if arg_611_1.time_ >= 0 + var_614_1 and arg_611_1.time_ < 0 + var_614_1 + arg_614_0 then
				arg_611_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				local var_614_2 = arg_611_1.var_.effectzasheng1

				if not arg_611_1.var_.effectzasheng1 then
					var_614_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_614_2.name = "zasheng1"
					arg_611_1.var_.effectzasheng1 = var_614_2
				else
					var_614_2.transform:SetParent(var_614_9000)
				end

				var_614_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_614_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_611_1.time_ and arg_611_1.time_ <= 1 + arg_614_0 then
				if arg_611_1.var_.effectzasheng1 then
					Object.Destroy(arg_611_1.var_.effectzasheng1)

					arg_611_1.var_.effectzasheng1 = nil
				end
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:AudioAction("play", "effect", "se_story_130", "se_story_130_noise", "")
			end

			if arg_611_1.frameCnt_ <= 1 then
				arg_611_1.dialog_:SetActive(false)
			end

			local var_614_6 = 0.833333333333333
			local var_614_7 = 1.75

			if 0.833333333333333 < arg_611_1.time_ and arg_611_1.time_ <= var_614_6 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0

				arg_611_1.dialog_:SetActive(true)

				arg_611_1.dialogCg_.alpha = 0

				local var_614_8 = LeanTween.value(arg_611_1.dialog_, 0, 1, 0.3)

				var_614_8:setOnUpdate(LuaHelper.FloatAction(function(arg_615_0)
					arg_611_1.dialogCg_.alpha = arg_615_0
				end))
				var_614_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_611_1.dialog_)
					var_614_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_611_1.duration_ = arg_611_1.duration_ + 0.3

				SetActive(arg_611_1.leftNameGo_, false)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_9 = arg_611_1:FormatText(arg_611_1:GetWordFromCfg(413011148).content)

				arg_611_1.text_.text = var_614_9

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_11 = 70 <= 0 and var_614_7 or var_614_7 * (utf8.len(var_614_9) / 70)

				if (70 <= 0 and var_614_7 or var_614_7 * (utf8.len(var_614_9) / 70)) > 0 and var_614_7 < var_614_11 then
					arg_611_1.talkMaxDuration = var_614_11
					var_614_6 = var_614_6 + 0.3

					if var_614_11 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_11 + var_614_6
					end
				end

				arg_611_1.text_.text = var_614_9
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_12 = var_614_6 + 0.3
			local var_614_13 = math.max(var_614_7, arg_611_1.talkMaxDuration)

			if var_614_6 + 0.3 <= arg_611_1.time_ and arg_611_1.time_ < var_614_12 + var_614_13 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_12) / var_614_13

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_12 + var_614_13 and arg_611_1.time_ < var_614_12 + var_614_13 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {
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

		arg_611_1:InitPlayNodeList()
	end,
	Play413011149 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 413011149
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play413011150(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0.666666666666667 < arg_617_1.time_ and arg_617_1.time_ <= 0.666666666666667 + arg_620_0 then
				arg_617_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_1028_warning", "")
			end

			local var_620_1 = 0
			local var_620_2 = 1.525

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_1 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, false)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_3 = arg_617_1:FormatText(arg_617_1:GetWordFromCfg(413011149).content)

				arg_617_1.text_.text = var_620_3

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_5 = 61 <= 0 and var_620_2 or var_620_2 * (utf8.len(var_620_3) / 61)

				if (61 <= 0 and var_620_2 or var_620_2 * (utf8.len(var_620_3) / 61)) > 0 and var_620_2 < var_620_5 then
					arg_617_1.talkMaxDuration = var_620_5

					if var_620_5 + var_620_1 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_5 + var_620_1
					end
				end

				arg_617_1.text_.text = var_620_3
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_6 = math.max(var_620_2, arg_617_1.talkMaxDuration)

			if var_620_1 <= arg_617_1.time_ and arg_617_1.time_ < var_620_1 + var_620_6 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_1) / var_620_6

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_1 + var_620_6 and arg_617_1.time_ < var_620_1 + var_620_6 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play413011150 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 413011150
		arg_621_1.duration_ = 2.5

		local var_621_0 = {
			zh = 0.999999999999,
			ja = 2.5
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
			arg_621_1.auto_ = false
		end

		function arg_621_1.playNext_(arg_623_0)
			arg_621_1.onStoryFinished_()
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_624_0 = 1

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_0 then
				local var_624_1, var_624_2 = math.modf((arg_621_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_624_2 * 0.13, var_624_2 * 0.13, var_624_2 * 0.13) + arg_621_1.var_.shakeOldPos
			end

			if arg_621_1.time_ >= 0 + var_624_0 and arg_621_1.time_ < 0 + var_624_0 + arg_624_0 then
				manager.ui.mainCamera.transform.localPosition = arg_621_1.var_.shakeOldPos
			end

			local var_624_3 = 0

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_3 + arg_624_0 then
				arg_621_1.allBtn_.enabled = false
			end

			if arg_621_1.time_ >= var_624_3 + 1 and arg_621_1.time_ < var_624_3 + 1 + arg_624_0 then
				arg_621_1.allBtn_.enabled = true
			end

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_624_5 = 0
			local var_624_6 = 0.075

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_5 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, true)
				arg_621_1.iconController_:SetSelectedState("hero")

				arg_621_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_621_1.callingController_:SetSelectedState("normal")

				arg_621_1.keyicon_.color = Color.New(1, 1, 1)
				arg_621_1.icon_.color = Color.New(1, 1, 1)

				local var_624_7 = arg_621_1:GetWordFromCfg(413011150)
				local var_624_8 = arg_621_1:FormatText(var_624_7.content)

				arg_621_1.text_.text = var_624_8

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_10 = 3 <= 0 and var_624_6 or var_624_6 * (utf8.len(var_624_8) / 3)

				if (3 <= 0 and var_624_6 or var_624_6 * (utf8.len(var_624_8) / 3)) > 0 and var_624_6 < var_624_10 then
					arg_621_1.talkMaxDuration = var_624_10

					if var_624_10 + var_624_5 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_10 + var_624_5
					end
				end

				arg_621_1.text_.text = var_624_8
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413011", "413011150", "story_v_out_413011.awb") ~= 0 then
					local var_624_11 = manager.audio:GetVoiceLength("story_v_out_413011", "413011150", "story_v_out_413011.awb") / 1000

					if var_624_11 + var_624_5 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_11 + var_624_5
					end

					if var_624_7.prefab_name ~= "" and arg_621_1.actors_[var_624_7.prefab_name] ~= nil then
						local var_624_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_7.prefab_name].transform, "story_v_out_413011", "413011150", "story_v_out_413011.awb")

						arg_621_1:RecordAudio("413011150", var_624_12)
						arg_621_1:RecordAudio("413011150", var_624_12)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_413011", "413011150", "story_v_out_413011.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_413011", "413011150", "story_v_out_413011.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_13 = math.max(var_624_6, arg_621_1.talkMaxDuration)

			if var_624_5 <= arg_621_1.time_ and arg_621_1.time_ < var_624_5 + var_624_13 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_5) / var_624_13

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_5 + var_624_13 and arg_621_1.time_ < var_624_5 + var_624_13 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08l",
		"TextureConfig/Background/ST21",
		"TextureConfig/Background/F10f"
	},
	voices = {
		"story_v_out_413011.awb"
	}
}
