return {
	Play413152001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413152001
		arg_1_1.duration_ = 9.1

		local var_1_0 = {
			zh = 5.733,
			ja = 9.1
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
				arg_1_0:Play413152002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F08i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08i")
				var_4_0.name = "F08i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F08i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F08i

				arg_1_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F08i" then
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

			if 1.26666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.26666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.525

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_18 = arg_1_1:GetWordFromCfg(413152001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 21 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 21)

				if (21 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 21)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152001", "story_v_out_413152.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_413152", "413152001", "story_v_out_413152.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_413152", "413152001", "story_v_out_413152.awb")

						arg_1_1:RecordAudio("413152001", var_4_23)
						arg_1_1:RecordAudio("413152001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413152", "413152001", "story_v_out_413152.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413152", "413152001", "story_v_out_413152.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413152002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413152002
		arg_9_1.duration_ = 6.9

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 6.9
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
				arg_9_0:Play413152003(arg_9_1)
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

			local var_12_9 = 0.5

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				if arg_9_1.var_.characterEffect10094 then
					arg_9_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue10094, 1, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and arg_9_1.var_.characterEffect10094 then
				arg_9_1.var_.characterEffect10094.alpha = 1
			end

			local var_12_10 = 0
			local var_12_11 = 0.225

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

				local var_12_12 = arg_9_1:GetWordFromCfg(413152002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 9 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 9)

				if (9 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 9)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152002", "story_v_out_413152.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_413152", "413152002", "story_v_out_413152.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_413152", "413152002", "story_v_out_413152.awb")

						arg_9_1:RecordAudio("413152002", var_12_17)
						arg_9_1:RecordAudio("413152002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413152", "413152002", "story_v_out_413152.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413152", "413152002", "story_v_out_413152.awb")
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
	Play413152003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413152003
		arg_13_1.duration_ = 5.57

		local var_13_0 = {
			zh = 2.5,
			ja = 5.566
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
				arg_13_0:Play413152004(arg_13_1)
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
			local var_16_6 = 0.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_7 = arg_13_1:GetWordFromCfg(413152003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 12 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 12)

				if (12 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 12)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152003", "story_v_out_413152.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152003", "story_v_out_413152.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_413152", "413152003", "story_v_out_413152.awb")

						arg_13_1:RecordAudio("413152003", var_16_12)
						arg_13_1:RecordAudio("413152003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413152", "413152003", "story_v_out_413152.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413152", "413152003", "story_v_out_413152.awb")
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
	Play413152004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413152004
		arg_17_1.duration_ = 4

		local var_17_0 = {
			zh = 2.2,
			ja = 4
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
				arg_17_0:Play413152005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10094 = arg_17_1.actors_["10094"].transform.localPosition
				arg_17_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10094", 3)

				for iter_20_0 = 0, arg_17_1.actors_["10094"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["10094"].transform:GetChild(iter_20_0)

					if var_20_0.name == "" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_20_2 = arg_17_1.actors_["10094"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10094 == nil then
				arg_17_1.var_.actorSpriteComps10094 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps10094 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10094 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10094 = nil
			end

			local var_20_5 = 0
			local var_20_6 = 0.2

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(413152004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 8 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 8)

				if (8 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 8)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152004", "story_v_out_413152.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152004", "story_v_out_413152.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_413152", "413152004", "story_v_out_413152.awb")

						arg_17_1:RecordAudio("413152004", var_20_12)
						arg_17_1:RecordAudio("413152004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413152", "413152004", "story_v_out_413152.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413152", "413152004", "story_v_out_413152.awb")
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
				actorName = "10094",
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
	Play413152005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413152005
		arg_21_1.duration_ = 8.27

		local var_21_0 = {
			zh = 5.3,
			ja = 8.266
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
				arg_21_0:Play413152006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10094"]) and arg_21_1.var_.actorSpriteComps10094 == nil then
				arg_21_1.var_.actorSpriteComps10094 = arg_21_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10094"]) then
				if arg_21_1.var_.actorSpriteComps10094 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10094"]) and arg_21_1.var_.actorSpriteComps10094 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10094 = nil
			end

			local var_24_2 = 0
			local var_24_3 = 0.625

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_4 = arg_21_1:GetWordFromCfg(413152005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 25 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 25)

				if (25 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 25)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152005", "story_v_out_413152.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152005", "story_v_out_413152.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_413152", "413152005", "story_v_out_413152.awb")

						arg_21_1:RecordAudio("413152005", var_24_9)
						arg_21_1:RecordAudio("413152005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413152", "413152005", "story_v_out_413152.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413152", "413152005", "story_v_out_413152.awb")
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

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play413152006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413152006
		arg_25_1.duration_ = 3

		local var_25_0 = {
			zh = 2.266,
			ja = 3
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
				arg_25_0:Play413152007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10094 = arg_25_1.actors_["10094"].transform.localPosition
				arg_25_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10094", 3)

				for iter_28_0 = 0, arg_25_1.actors_["10094"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10094"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_28_2 = arg_25_1.actors_["10094"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10094 == nil then
				arg_25_1.var_.actorSpriteComps10094 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10094 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10094 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10094 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(413152006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 11 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 11)

				if (11 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 11)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152006", "story_v_out_413152.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152006", "story_v_out_413152.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_413152", "413152006", "story_v_out_413152.awb")

						arg_25_1:RecordAudio("413152006", var_28_12)
						arg_25_1:RecordAudio("413152006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413152", "413152006", "story_v_out_413152.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413152", "413152006", "story_v_out_413152.awb")
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
				actorName = "10094",
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
	Play413152007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413152007
		arg_29_1.duration_ = 4.33

		local var_29_0 = {
			zh = 1.999999999999,
			ja = 4.333
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
				arg_29_0:Play413152008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10094 = arg_29_1.actors_["10094"].transform.localPosition
				arg_29_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10094", 3)

				for iter_32_0 = 0, arg_29_1.actors_["10094"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10094"].transform:GetChild(iter_32_0)

					if var_32_0.name == "" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_32_2 = arg_29_1.actors_["10094"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10094 == nil then
				arg_29_1.var_.actorSpriteComps10094 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10094 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								iter_32_2.color = Color.New(Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_2.color.r, 1, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_2.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10094 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10094 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.25

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
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

				local var_32_7 = arg_29_1:GetWordFromCfg(413152007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 10 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 10)

				if (10 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 10)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152007", "story_v_out_413152.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152007", "story_v_out_413152.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_413152", "413152007", "story_v_out_413152.awb")

						arg_29_1:RecordAudio("413152007", var_32_12)
						arg_29_1:RecordAudio("413152007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413152", "413152007", "story_v_out_413152.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413152", "413152007", "story_v_out_413152.awb")
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

		arg_29_1.nodeConfigList_ = {
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
	Play413152008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413152008
		arg_33_1.duration_ = 4.3

		local var_33_0 = {
			zh = 4.3,
			ja = 4.1
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
				arg_33_0:Play413152009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10094"]) and arg_33_1.var_.actorSpriteComps10094 == nil then
				arg_33_1.var_.actorSpriteComps10094 = arg_33_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10094"]) then
				if arg_33_1.var_.actorSpriteComps10094 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10094"]) and arg_33_1.var_.actorSpriteComps10094 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10094 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 0.45

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_4 = arg_33_1:GetWordFromCfg(413152008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 18 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 18)

				if (18 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 18)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152008", "story_v_out_413152.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152008", "story_v_out_413152.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_413152", "413152008", "story_v_out_413152.awb")

						arg_33_1:RecordAudio("413152008", var_36_9)
						arg_33_1:RecordAudio("413152008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413152", "413152008", "story_v_out_413152.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413152", "413152008", "story_v_out_413152.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play413152009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413152009
		arg_37_1.duration_ = 4

		local var_37_0 = {
			zh = 4,
			ja = 1.999999999999
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
				arg_37_0:Play413152010(arg_37_1)
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
			local var_40_6 = 0.525

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

				local var_40_7 = arg_37_1:GetWordFromCfg(413152009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 21 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 21)

				if (21 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 21)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152009", "story_v_out_413152.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152009", "story_v_out_413152.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_413152", "413152009", "story_v_out_413152.awb")

						arg_37_1:RecordAudio("413152009", var_40_12)
						arg_37_1:RecordAudio("413152009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413152", "413152009", "story_v_out_413152.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413152", "413152009", "story_v_out_413152.awb")
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
	Play413152010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413152010
		arg_41_1.duration_ = 4.53

		local var_41_0 = {
			zh = 2.4,
			ja = 4.533
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
				arg_41_0:Play413152011(arg_41_1)
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
								iter_44_2.color = Color.New(Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_2.color.r, 1, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_2.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10094 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10094 = nil
			end

			local var_44_5 = 0
			local var_44_6 = 0.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
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

				local var_44_7 = arg_41_1:GetWordFromCfg(413152010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 10 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 10)

				if (10 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 10)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152010", "story_v_out_413152.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152010", "story_v_out_413152.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_413152", "413152010", "story_v_out_413152.awb")

						arg_41_1:RecordAudio("413152010", var_44_12)
						arg_41_1:RecordAudio("413152010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413152", "413152010", "story_v_out_413152.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413152", "413152010", "story_v_out_413152.awb")
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
	Play413152011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413152011
		arg_45_1.duration_ = 4.7

		local var_45_0 = {
			zh = 3.2,
			ja = 4.7
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
				arg_45_0:Play413152012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10094"]) and arg_45_1.var_.actorSpriteComps10094 == nil then
				arg_45_1.var_.actorSpriteComps10094 = arg_45_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10094"]) then
				if arg_45_1.var_.actorSpriteComps10094 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10094"]) and arg_45_1.var_.actorSpriteComps10094 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10094 = nil
			end

			local var_48_2 = 0
			local var_48_3 = 0.425

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_4 = arg_45_1:GetWordFromCfg(413152011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 17 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 17)

				if (17 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 17)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152011", "story_v_out_413152.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152011", "story_v_out_413152.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_413152", "413152011", "story_v_out_413152.awb")

						arg_45_1:RecordAudio("413152011", var_48_9)
						arg_45_1:RecordAudio("413152011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413152", "413152011", "story_v_out_413152.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413152", "413152011", "story_v_out_413152.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_10 and arg_45_1.time_ < var_48_2 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play413152012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413152012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play413152013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10094 = arg_49_1.actors_["10094"].transform.localPosition
				arg_49_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10094", 7)

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
				arg_49_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["10094"].transform.localPosition = Vector3.New(0, -2000, 0)
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
			local var_52_6 = 1.2

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(413152012).content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 48 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 48)

				if (48 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 48)) > 0 and var_52_6 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_10 and arg_49_1.time_ < var_52_5 + var_52_10 + arg_52_0 then
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
	Play413152013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413152013
		arg_53_1.duration_ = 7.4

		local var_53_0 = {
			zh = 5.3,
			ja = 7.4
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
				arg_53_0:Play413152014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10094 = arg_53_1.actors_["10094"].transform.localPosition
				arg_53_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10094", 3)

				for iter_56_0 = 0, arg_53_1.actors_["10094"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["10094"].transform:GetChild(iter_56_0)

					if var_56_0.name == "" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_56_2 = arg_53_1.actors_["10094"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10094 == nil then
				arg_53_1.var_.actorSpriteComps10094 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps10094 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10094 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_56_4 then
						iter_56_4.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10094 = nil
			end

			local var_56_5 = 0
			local var_56_6 = 0.575

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
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

				local var_56_7 = arg_53_1:GetWordFromCfg(413152013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 23 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 23)

				if (23 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 23)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152013", "story_v_out_413152.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152013", "story_v_out_413152.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_413152", "413152013", "story_v_out_413152.awb")

						arg_53_1:RecordAudio("413152013", var_56_12)
						arg_53_1:RecordAudio("413152013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413152", "413152013", "story_v_out_413152.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413152", "413152013", "story_v_out_413152.awb")
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
	Play413152014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413152014
		arg_57_1.duration_ = 4.13

		local var_57_0 = {
			zh = 3.7,
			ja = 4.133
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
				arg_57_0:Play413152015(arg_57_1)
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
			local var_60_6 = 0.35

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

				local var_60_7 = arg_57_1:GetWordFromCfg(413152014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 14 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 14)

				if (14 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 14)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152014", "story_v_out_413152.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152014", "story_v_out_413152.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_413152", "413152014", "story_v_out_413152.awb")

						arg_57_1:RecordAudio("413152014", var_60_12)
						arg_57_1:RecordAudio("413152014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413152", "413152014", "story_v_out_413152.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413152", "413152014", "story_v_out_413152.awb")
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
	Play413152015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413152015
		arg_61_1.duration_ = 5.8

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play413152016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if arg_61_1.bgs_.ST0603 == nil then
				local var_64_0 = Object.Instantiate(arg_61_1.paintGo_)

				var_64_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0603")
				var_64_0.name = "ST0603"
				var_64_0.transform.parent = arg_61_1.stage_.transform
				var_64_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.bgs_.ST0603 = var_64_0
			end

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= 2 + arg_64_0 then
				local var_64_1 = arg_61_1.bgs_.ST0603

				arg_61_1.bgs_.ST0603.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_64_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_2 = var_64_1:GetComponent("SpriteRenderer")

				if var_64_2 and var_64_2.sprite then
					local var_64_3 = 2 * (var_64_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_64_1.transform.localScale = Vector3.New(var_64_3 / var_64_2.sprite.bounds.size.y < var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x and var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x or var_64_3 / var_64_2.sprite.bounds.size.y, var_64_3 / var_64_2.sprite.bounds.size.y < var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x and var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x or var_64_3 / var_64_2.sprite.bounds.size.y, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "ST0603" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_4 = 3.999999999999

			if 3.999999999999 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			if arg_61_1.time_ >= var_64_4 + 0.3 and arg_61_1.time_ < var_64_4 + 0.3 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_5 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_6 = 2

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_6 then
				local var_64_7 = Color.New(0, 0, 0)

				var_64_7.a = Mathf.Lerp(0, 1, (arg_61_1.time_ - var_64_5) / var_64_6)
				arg_61_1.mask_.color = var_64_7
			end

			if arg_61_1.time_ >= var_64_5 + var_64_6 and arg_61_1.time_ < var_64_5 + var_64_6 + arg_64_0 then
				local var_64_8 = Color.New(0, 0, 0)

				var_64_8.a = 1
				arg_61_1.mask_.color = var_64_8
			end

			local var_64_9 = 2

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_10 = 2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 then
				local var_64_11 = Color.New(0, 0, 0)

				var_64_11.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_9) / var_64_10)
				arg_61_1.mask_.color = var_64_11
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 then
				local var_64_12 = Color.New(0, 0, 0)

				arg_61_1.mask_.enabled = false
				var_64_12.a = 0
				arg_61_1.mask_.color = var_64_12
			end

			local var_64_13 = arg_61_1.actors_["10094"].transform

			if 1.999999999999 < arg_61_1.time_ and arg_61_1.time_ <= 1.999999999999 + arg_64_0 then
				arg_61_1.var_.moveOldPos10094 = var_64_13.localPosition
				var_64_13.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10094", 7)

				for iter_64_2 = 0, var_64_13.childCount - 1 do
					local var_64_14 = var_64_13:GetChild(iter_64_2)

					if var_64_14.name == "" or not string.find(var_64_14.name, "split") then
						var_64_14.gameObject:SetActive(true)
					else
						var_64_14.gameObject:SetActive(false)
					end
				end
			end

			local var_64_15 = 0.001

			if 1.999999999999 <= arg_61_1.time_ and arg_61_1.time_ < 1.999999999999 + var_64_15 then
				var_64_13.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_61_1.time_ - 1.999999999999) / var_64_15)
			end

			if arg_61_1.time_ >= 1.999999999999 + var_64_15 and arg_61_1.time_ < 1.999999999999 + var_64_15 + arg_64_0 then
				var_64_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_16 = "10093"

			if arg_61_1.actors_["10093"] == nil then
				local var_64_17 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_64_17) then
					local var_64_18 = Object.Instantiate(var_64_17, arg_61_1.canvasGo_.transform)

					var_64_18.transform:SetSiblingIndex(1)

					var_64_18.name = var_64_16
					var_64_18.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_61_1.actors_[var_64_16] = var_64_18

					if arg_61_1.isInRecall_ then
						for iter_64_3, iter_64_4 in ipairs((var_64_18:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_64_4.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_64_19 = arg_61_1.actors_["10093"].transform

			if 3.8 < arg_61_1.time_ and arg_61_1.time_ <= 3.8 + arg_64_0 then
				arg_61_1.var_.moveOldPos10093 = var_64_19.localPosition
				var_64_19.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10093", 3)

				for iter_64_5 = 0, var_64_19.childCount - 1 do
					local var_64_20 = var_64_19:GetChild(iter_64_5)

					if var_64_20.name == "split_5" or not string.find(var_64_20.name, "split") then
						var_64_20.gameObject:SetActive(true)
					else
						var_64_20.gameObject:SetActive(false)
					end
				end
			end

			local var_64_21 = 0.001

			if 3.8 <= arg_61_1.time_ and arg_61_1.time_ < 3.8 + var_64_21 then
				var_64_19.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_61_1.time_ - 3.8) / var_64_21)
			end

			if arg_61_1.time_ >= 3.8 + var_64_21 and arg_61_1.time_ < 3.8 + var_64_21 + arg_64_0 then
				var_64_19.localPosition = Vector3.New(0, -345, -245)
			end

			local var_64_22 = arg_61_1.actors_["10093"]

			if 3.8 < arg_61_1.time_ and arg_61_1.time_ <= 3.8 + arg_64_0 and not isNil(var_64_22) and arg_61_1.var_.actorSpriteComps10093 == nil then
				arg_61_1.var_.actorSpriteComps10093 = var_64_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_23 = 2

			if 3.8 <= arg_61_1.time_ and arg_61_1.time_ < 3.8 + var_64_23 and not isNil(var_64_22) then
				if arg_61_1.var_.actorSpriteComps10093 then
					for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_64_7 then
							if arg_61_1.isInRecall_ then
								iter_64_7.color = Color.New(Mathf.Lerp(iter_64_7.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 3.8) / var_64_23), Mathf.Lerp(iter_64_7.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 3.8) / var_64_23), (Mathf.Lerp(iter_64_7.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 3.8) / var_64_23)))
							else
								local var_64_24 = Mathf.Lerp(iter_64_7.color.r, 1, (arg_61_1.time_ - 3.8) / var_64_23)

								iter_64_7.color = Color.New(var_64_24, var_64_24, var_64_24)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 3.8 + var_64_23 and arg_61_1.time_ < 3.8 + var_64_23 + arg_64_0 and not isNil(var_64_22) and arg_61_1.var_.actorSpriteComps10093 then
				for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_64_9 then
						iter_64_9.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10093 = nil
			end

			if 3.8 < arg_61_1.time_ and arg_61_1.time_ <= 3.8 + arg_64_0 then
				local var_64_25 = arg_61_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_25 then
					arg_61_1.var_.alphaOldValue10093 = var_64_25.alpha
					arg_61_1.var_.characterEffect10093 = var_64_25
				end

				arg_61_1.var_.alphaOldValue10093 = 0
			end

			local var_64_26 = 0.2

			if 3.8 <= arg_61_1.time_ and arg_61_1.time_ < 3.8 + var_64_26 then
				if arg_61_1.var_.characterEffect10093 then
					arg_61_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_61_1.var_.alphaOldValue10093, 1, (arg_61_1.time_ - 3.8) / var_64_26)
				end
			end

			if arg_61_1.time_ >= 3.8 + var_64_26 and arg_61_1.time_ < 3.8 + var_64_26 + arg_64_0 and arg_61_1.var_.characterEffect10093 then
				arg_61_1.var_.characterEffect10093.alpha = 1
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_27 = 3.999999999999
			local var_64_28 = 0.075

			if 3.999999999999 < arg_61_1.time_ and arg_61_1.time_ <= var_64_27 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_29 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_29:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_30 = arg_61_1:GetWordFromCfg(413152015)
				local var_64_31 = arg_61_1:FormatText(var_64_30.content)

				arg_61_1.text_.text = var_64_31

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_33 = 3 <= 0 and var_64_28 or var_64_28 * (utf8.len(var_64_31) / 3)

				if (3 <= 0 and var_64_28 or var_64_28 * (utf8.len(var_64_31) / 3)) > 0 and var_64_28 < var_64_33 then
					arg_61_1.talkMaxDuration = var_64_33
					var_64_27 = var_64_27 + 0.3

					if var_64_33 + var_64_27 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_33 + var_64_27
					end
				end

				arg_61_1.text_.text = var_64_31
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152015", "story_v_out_413152.awb") ~= 0 then
					local var_64_34 = manager.audio:GetVoiceLength("story_v_out_413152", "413152015", "story_v_out_413152.awb") / 1000

					if var_64_34 + var_64_27 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_34 + var_64_27
					end

					if var_64_30.prefab_name ~= "" and arg_61_1.actors_[var_64_30.prefab_name] ~= nil then
						local var_64_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_30.prefab_name].transform, "story_v_out_413152", "413152015", "story_v_out_413152.awb")

						arg_61_1:RecordAudio("413152015", var_64_35)
						arg_61_1:RecordAudio("413152015", var_64_35)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413152", "413152015", "story_v_out_413152.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413152", "413152015", "story_v_out_413152.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_36 = var_64_27 + 0.3
			local var_64_37 = math.max(var_64_28, arg_61_1.talkMaxDuration)

			if var_64_27 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_36 + var_64_37 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_36) / var_64_37

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_36 + var_64_37 and arg_61_1.time_ < var_64_36 + var_64_37 + arg_64_0 then
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
				startTime = 1.999999999999,
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

		arg_61_1:InitPlayNodeList()
	end,
	Play413152016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 413152016
		arg_67_1.duration_ = 3.57

		local var_67_0 = {
			zh = 2.733,
			ja = 3.566
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
				arg_67_0:Play413152017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.275

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(413152016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 11 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 11)

				if (11 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 11)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152016", "story_v_out_413152.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152016", "story_v_out_413152.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_413152", "413152016", "story_v_out_413152.awb")

						arg_67_1:RecordAudio("413152016", var_70_6)
						arg_67_1:RecordAudio("413152016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_413152", "413152016", "story_v_out_413152.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_413152", "413152016", "story_v_out_413152.awb")
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
	Play413152017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 413152017
		arg_71_1.duration_ = 2.57

		local var_71_0 = {
			zh = 2.566,
			ja = 1.833
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
				arg_71_0:Play413152018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.275

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(413152017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 11 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 11)

				if (11 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 11)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152017", "story_v_out_413152.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152017", "story_v_out_413152.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_413152", "413152017", "story_v_out_413152.awb")

						arg_71_1:RecordAudio("413152017", var_74_6)
						arg_71_1:RecordAudio("413152017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_413152", "413152017", "story_v_out_413152.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_413152", "413152017", "story_v_out_413152.awb")
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
	Play413152018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 413152018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play413152019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10093 = arg_75_1.actors_["10093"].transform.localPosition
				arg_75_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10093", 7)

				for iter_78_0 = 0, arg_75_1.actors_["10093"].transform.childCount - 1 do
					local var_78_0 = arg_75_1.actors_["10093"].transform:GetChild(iter_78_0)

					if var_78_0.name == "" or not string.find(var_78_0.name, "split") then
						var_78_0.gameObject:SetActive(true)
					else
						var_78_0.gameObject:SetActive(false)
					end
				end
			end

			local var_78_1 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 then
				arg_75_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_75_1.time_ - 0) / var_78_1)
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 then
				arg_75_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_78_2 = arg_75_1.actors_["10093"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps10093 == nil then
				arg_75_1.var_.actorSpriteComps10093 = var_78_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_3 = 2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.actorSpriteComps10093 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_78_2 then
							if arg_75_1.isInRecall_ then
								iter_78_2.color = Color.New(Mathf.Lerp(iter_78_2.color.r, arg_75_1.hightColor2.r, (arg_75_1.time_ - 0) / var_78_3), Mathf.Lerp(iter_78_2.color.g, arg_75_1.hightColor2.g, (arg_75_1.time_ - 0) / var_78_3), (Mathf.Lerp(iter_78_2.color.b, arg_75_1.hightColor2.b, (arg_75_1.time_ - 0) / var_78_3)))
							else
								local var_78_4 = Mathf.Lerp(iter_78_2.color.r, 0.5, (arg_75_1.time_ - 0) / var_78_3)

								iter_78_2.color = Color.New(var_78_4, var_78_4, var_78_4)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps10093 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_78_4 then
						iter_78_4.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_75_1.var_.actorSpriteComps10093 = nil
			end

			local var_78_5 = 0
			local var_78_6 = 0.85

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(413152018).content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 34 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_7) / 34)

				if (34 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_7) / 34)) > 0 and var_78_6 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_6, arg_75_1.talkMaxDuration)

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_5) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_5 + var_78_10 and arg_75_1.time_ < var_78_5 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play413152019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 413152019
		arg_79_1.duration_ = 6.17

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play413152020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = false

				arg_79_1:SetGaussion(false)
			end

			local var_82_0 = 0.4

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				local var_82_1 = Color.New(1, 1, 1)

				var_82_1.a = Mathf.Lerp(1, 0, (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.mask_.color = var_82_1
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				local var_82_2 = Color.New(1, 1, 1)

				arg_79_1.mask_.enabled = false
				var_82_2.a = 0
				arg_79_1.mask_.color = var_82_2
			end

			local var_82_3 = manager.ui.mainCamera.transform

			if 0.3 < arg_79_1.time_ and arg_79_1.time_ <= 0.3 + arg_82_0 then
				arg_79_1.var_.shakeOldPos = var_82_3.localPosition
			end

			local var_82_4 = 0.866666666666667

			if 0.3 <= arg_79_1.time_ and arg_79_1.time_ < 0.3 + var_82_4 then
				local var_82_5, var_82_6 = math.modf((arg_79_1.time_ - 0.3) / 0.066)

				var_82_3.localPosition = Vector3.New(var_82_6 * 0.13, var_82_6 * 0.13, var_82_6 * 0.13) + arg_79_1.var_.shakeOldPos
			end

			if arg_79_1.time_ >= 0.3 + var_82_4 and arg_79_1.time_ < 0.3 + var_82_4 + arg_82_0 then
				var_82_3.localPosition = arg_79_1.var_.shakeOldPos
			end

			local var_82_7 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			if arg_79_1.time_ >= var_82_7 + 1.16666666666667 and arg_79_1.time_ < var_82_7 + 1.16666666666667 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			if 0.3 < arg_79_1.time_ and arg_79_1.time_ <= 0.3 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_stonecrushing", "")
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_9 = 1.16666666666667
			local var_82_10 = 1.525

			if 1.16666666666667 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_11 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_11:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_12 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(413152019).content)

				arg_79_1.text_.text = var_82_12

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_14 = 61 <= 0 and var_82_10 or var_82_10 * (utf8.len(var_82_12) / 61)

				if (61 <= 0 and var_82_10 or var_82_10 * (utf8.len(var_82_12) / 61)) > 0 and var_82_10 < var_82_14 then
					arg_79_1.talkMaxDuration = var_82_14
					var_82_9 = var_82_9 + 0.3

					if var_82_14 + var_82_9 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_9
					end
				end

				arg_79_1.text_.text = var_82_12
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_15 = var_82_9 + 0.3
			local var_82_16 = math.max(var_82_10, arg_79_1.talkMaxDuration)

			if var_82_9 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_15 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_15) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_15 + var_82_16 and arg_79_1.time_ < var_82_15 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play413152020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413152020
		arg_85_1.duration_ = 20.53

		local var_85_0 = {
			zh = 12.366,
			ja = 20.533
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
				arg_85_0:Play413152021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if arg_85_1.actors_["10092_1"] == nil then
				local var_88_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092_1")

				if not isNil(var_88_0) then
					local var_88_1 = Object.Instantiate(var_88_0, arg_85_1.canvasGo_.transform)

					var_88_1.transform:SetSiblingIndex(1)

					var_88_1.name = "10092_1"
					var_88_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_85_1.actors_["10092_1"] = var_88_1

					if arg_85_1.isInRecall_ then
						for iter_88_0, iter_88_1 in ipairs((var_88_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_88_1.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_88_2 = arg_85_1.actors_["10092_1"].transform

			if 3 < arg_85_1.time_ and arg_85_1.time_ <= 3 + arg_88_0 then
				arg_85_1.var_.moveOldPos10092_1 = var_88_2.localPosition
				var_88_2.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_88_2 = 0, var_88_2.childCount - 1 do
					local var_88_3 = var_88_2:GetChild(iter_88_2)

					if var_88_3.name == "split_1_1" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if 3 <= arg_85_1.time_ and arg_85_1.time_ < 3 + var_88_4 then
				var_88_2.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_85_1.time_ - 3) / var_88_4)
			end

			if arg_85_1.time_ >= 3 + var_88_4 and arg_85_1.time_ < 3 + var_88_4 + arg_88_0 then
				var_88_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_88_5 = arg_85_1.actors_["10092_1"]

			if 3 < arg_85_1.time_ and arg_85_1.time_ <= 3 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps10092_1 == nil then
				arg_85_1.var_.actorSpriteComps10092_1 = var_88_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_6 = 2

			if 3 <= arg_85_1.time_ and arg_85_1.time_ < 3 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.actorSpriteComps10092_1 then
					for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_88_4 then
							if arg_85_1.isInRecall_ then
								iter_88_4.color = Color.New(Mathf.Lerp(iter_88_4.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 3) / var_88_6), Mathf.Lerp(iter_88_4.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 3) / var_88_6), (Mathf.Lerp(iter_88_4.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 3) / var_88_6)))
							else
								local var_88_7 = Mathf.Lerp(iter_88_4.color.r, 1, (arg_85_1.time_ - 3) / var_88_6)

								iter_88_4.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 3 + var_88_6 and arg_85_1.time_ < 3 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps10092_1 then
				for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_88_6 then
						iter_88_6.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_88_8 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_9 = 1.16666666666667

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 then
				local var_88_10 = Color.New(0, 0, 0)

				var_88_10.a = Mathf.Lerp(0, 1, (arg_85_1.time_ - var_88_8) / var_88_9)
				arg_85_1.mask_.color = var_88_10
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 then
				local var_88_11 = Color.New(0, 0, 0)

				var_88_11.a = 1
				arg_85_1.mask_.color = var_88_11
			end

			local var_88_12 = 1.16666666666667

			if 1.16666666666667 < arg_85_1.time_ and arg_85_1.time_ <= var_88_12 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_13 = 2

			if var_88_12 <= arg_85_1.time_ and arg_85_1.time_ < var_88_12 + var_88_13 then
				local var_88_14 = Color.New(0, 0, 0)

				var_88_14.a = Mathf.Lerp(1, 0, (arg_85_1.time_ - var_88_12) / var_88_13)
				arg_85_1.mask_.color = var_88_14
			end

			if arg_85_1.time_ >= var_88_12 + var_88_13 and arg_85_1.time_ < var_88_12 + var_88_13 + arg_88_0 then
				local var_88_15 = Color.New(0, 0, 0)

				arg_85_1.mask_.enabled = false
				var_88_15.a = 0
				arg_85_1.mask_.color = var_88_15
			end

			if 1.16666666666667 < arg_85_1.time_ and arg_85_1.time_ <= 1.16666666666667 + arg_88_0 then
				local var_88_16 = arg_85_1.bgs_.ST0603

				arg_85_1.bgs_.ST0603.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_17 = var_88_16:GetComponent("SpriteRenderer")

				if var_88_17 and var_88_17.sprite then
					local var_88_18 = 2 * (var_88_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_16.transform.localScale = Vector3.New(var_88_18 / var_88_17.sprite.bounds.size.y < var_88_18 * manager.ui.mainCameraCom_.aspect / var_88_17.sprite.bounds.size.x and var_88_18 * manager.ui.mainCameraCom_.aspect / var_88_17.sprite.bounds.size.x or var_88_18 / var_88_17.sprite.bounds.size.y, var_88_18 / var_88_17.sprite.bounds.size.y < var_88_18 * manager.ui.mainCameraCom_.aspect / var_88_17.sprite.bounds.size.x and var_88_18 * manager.ui.mainCameraCom_.aspect / var_88_17.sprite.bounds.size.x or var_88_18 / var_88_17.sprite.bounds.size.y, 0)
				end

				for iter_88_7, iter_88_8 in pairs(arg_85_1.bgs_) do
					if iter_88_7 ~= "ST0603" then
						iter_88_8.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_19 = 1.16666666666667

			arg_85_1.isInRecall_ = true

			if var_88_19 < arg_85_1.time_ and arg_85_1.time_ <= var_88_19 + arg_88_0 then
				arg_85_1.screenFilterGo_:SetActive(true)

				arg_85_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_85_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_85_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_88_9, iter_88_10 in pairs(arg_85_1.actors_) do
					for iter_88_11, iter_88_12 in ipairs((iter_88_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_88_12.color = iter_88_12.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_88_20 = 0.2

			if var_88_19 <= arg_85_1.time_ and arg_85_1.time_ < var_88_19 + var_88_20 then
				arg_85_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_85_1.time_ - var_88_19) / var_88_20)
			end

			if arg_85_1.time_ >= var_88_19 + var_88_20 and arg_85_1.time_ < var_88_19 + var_88_20 + arg_88_0 then
				arg_85_1.screenFilterEffect_.weight = 1
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_21 = 3
			local var_88_22 = 0.975

			if 3 < arg_85_1.time_ and arg_85_1.time_ <= var_88_21 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_23 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_23:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_24 = arg_85_1:GetWordFromCfg(413152020)
				local var_88_25 = arg_85_1:FormatText(var_88_24.content)

				arg_85_1.text_.text = var_88_25

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_27 = 39 <= 0 and var_88_22 or var_88_22 * (utf8.len(var_88_25) / 39)

				if (39 <= 0 and var_88_22 or var_88_22 * (utf8.len(var_88_25) / 39)) > 0 and var_88_22 < var_88_27 then
					arg_85_1.talkMaxDuration = var_88_27
					var_88_21 = var_88_21 + 0.3

					if var_88_27 + var_88_21 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_27 + var_88_21
					end
				end

				arg_85_1.text_.text = var_88_25
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152020", "story_v_out_413152.awb") ~= 0 then
					local var_88_28 = manager.audio:GetVoiceLength("story_v_out_413152", "413152020", "story_v_out_413152.awb") / 1000

					if var_88_28 + var_88_21 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_28 + var_88_21
					end

					if var_88_24.prefab_name ~= "" and arg_85_1.actors_[var_88_24.prefab_name] ~= nil then
						local var_88_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_24.prefab_name].transform, "story_v_out_413152", "413152020", "story_v_out_413152.awb")

						arg_85_1:RecordAudio("413152020", var_88_29)
						arg_85_1:RecordAudio("413152020", var_88_29)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413152", "413152020", "story_v_out_413152.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413152", "413152020", "story_v_out_413152.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_30 = var_88_21 + 0.3
			local var_88_31 = math.max(var_88_22, arg_85_1.talkMaxDuration)

			if var_88_21 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_30 + var_88_31 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_30) / var_88_31

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_30 + var_88_31 and arg_85_1.time_ < var_88_30 + var_88_31 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play413152021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 413152021
		arg_91_1.duration_ = 8.03

		local var_91_0 = {
			zh = 5.066,
			ja = 8.033
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
				arg_91_0:Play413152022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.475

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
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

				local var_94_1 = arg_91_1:GetWordFromCfg(413152021)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 19 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 19)

				if (19 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 19)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152021", "story_v_out_413152.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152021", "story_v_out_413152.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_413152", "413152021", "story_v_out_413152.awb")

						arg_91_1:RecordAudio("413152021", var_94_6)
						arg_91_1:RecordAudio("413152021", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_413152", "413152021", "story_v_out_413152.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_413152", "413152021", "story_v_out_413152.awb")
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
	Play413152022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 413152022
		arg_95_1.duration_ = 8.3

		local var_95_0 = {
			zh = 6.966,
			ja = 8.3
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
				arg_95_0:Play413152023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 1.14933333333333 < arg_95_1.time_ and arg_95_1.time_ <= 1.14933333333333 + arg_98_0 then
				arg_95_1.var_.moveOldPos10092_1 = arg_95_1.actors_["10092_1"].transform.localPosition
				arg_95_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_98_0 = 0, arg_95_1.actors_["10092_1"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["10092_1"].transform:GetChild(iter_98_0)

					if var_98_0.name == "" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 1.14933333333333 <= arg_95_1.time_ and arg_95_1.time_ < 1.14933333333333 + var_98_1 then
				arg_95_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_95_1.time_ - 1.14933333333333) / var_98_1)
			end

			if arg_95_1.time_ >= 1.14933333333333 + var_98_1 and arg_95_1.time_ < 1.14933333333333 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_98_2 = arg_95_1.actors_["10093"].transform

			if 2.03333333333333 < arg_95_1.time_ and arg_95_1.time_ <= 2.03333333333333 + arg_98_0 then
				arg_95_1.var_.moveOldPos10093 = var_98_2.localPosition
				var_98_2.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10093", 3)

				for iter_98_1 = 0, var_98_2.childCount - 1 do
					local var_98_3 = var_98_2:GetChild(iter_98_1)

					if var_98_3.name == "split_4" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if 2.03333333333333 <= arg_95_1.time_ and arg_95_1.time_ < 2.03333333333333 + var_98_4 then
				var_98_2.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_95_1.time_ - 2.03333333333333) / var_98_4)
			end

			if arg_95_1.time_ >= 2.03333333333333 + var_98_4 and arg_95_1.time_ < 2.03333333333333 + var_98_4 + arg_98_0 then
				var_98_2.localPosition = Vector3.New(0, -345, -245)
			end

			local var_98_5 = arg_95_1.actors_["10093"]

			if 2.03333333333333 < arg_95_1.time_ and arg_95_1.time_ <= 2.03333333333333 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps10093 == nil then
				arg_95_1.var_.actorSpriteComps10093 = var_98_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_6 = 2

			if 2.03333333333333 <= arg_95_1.time_ and arg_95_1.time_ < 2.03333333333333 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.actorSpriteComps10093 then
					for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_98_3 then
							if arg_95_1.isInRecall_ then
								iter_98_3.color = Color.New(Mathf.Lerp(iter_98_3.color.r, arg_95_1.hightColor1.r, (arg_95_1.time_ - 2.03333333333333) / var_98_6), Mathf.Lerp(iter_98_3.color.g, arg_95_1.hightColor1.g, (arg_95_1.time_ - 2.03333333333333) / var_98_6), (Mathf.Lerp(iter_98_3.color.b, arg_95_1.hightColor1.b, (arg_95_1.time_ - 2.03333333333333) / var_98_6)))
							else
								local var_98_7 = Mathf.Lerp(iter_98_3.color.r, 1, (arg_95_1.time_ - 2.03333333333333) / var_98_6)

								iter_98_3.color = Color.New(var_98_7, var_98_7, var_98_7)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 2.03333333333333 + var_98_6 and arg_95_1.time_ < 2.03333333333333 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps10093 then
				for iter_98_4, iter_98_5 in pairs(arg_95_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_98_5 then
						iter_98_5.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_95_1.var_.actorSpriteComps10093 = nil
			end

			local var_98_8 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_9 = 1.16666666666667

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_9 then
				local var_98_10 = Color.New(0, 0, 0)

				var_98_10.a = Mathf.Lerp(0, 1, (arg_95_1.time_ - var_98_8) / var_98_9)
				arg_95_1.mask_.color = var_98_10
			end

			if arg_95_1.time_ >= var_98_8 + var_98_9 and arg_95_1.time_ < var_98_8 + var_98_9 + arg_98_0 then
				local var_98_11 = Color.New(0, 0, 0)

				var_98_11.a = 1
				arg_95_1.mask_.color = var_98_11
			end

			local var_98_12 = 1.16666666666667

			if 1.16666666666667 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_13 = 1.06666666666667

			if var_98_12 <= arg_95_1.time_ and arg_95_1.time_ < var_98_12 + var_98_13 then
				local var_98_14 = Color.New(0, 0, 0)

				var_98_14.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_12) / var_98_13)
				arg_95_1.mask_.color = var_98_14
			end

			if arg_95_1.time_ >= var_98_12 + var_98_13 and arg_95_1.time_ < var_98_12 + var_98_13 + arg_98_0 then
				local var_98_15 = Color.New(0, 0, 0)

				arg_95_1.mask_.enabled = false
				var_98_15.a = 0
				arg_95_1.mask_.color = var_98_15
			end

			if 1.16666666666667 < arg_95_1.time_ and arg_95_1.time_ <= 1.16666666666667 + arg_98_0 then
				local var_98_16 = arg_95_1.bgs_.ST0603

				arg_95_1.bgs_.ST0603.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_98_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_17 = var_98_16:GetComponent("SpriteRenderer")

				if var_98_17 and var_98_17.sprite then
					local var_98_18 = 2 * (var_98_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_98_16.transform.localScale = Vector3.New(var_98_18 / var_98_17.sprite.bounds.size.y < var_98_18 * manager.ui.mainCameraCom_.aspect / var_98_17.sprite.bounds.size.x and var_98_18 * manager.ui.mainCameraCom_.aspect / var_98_17.sprite.bounds.size.x or var_98_18 / var_98_17.sprite.bounds.size.y, var_98_18 / var_98_17.sprite.bounds.size.y < var_98_18 * manager.ui.mainCameraCom_.aspect / var_98_17.sprite.bounds.size.x and var_98_18 * manager.ui.mainCameraCom_.aspect / var_98_17.sprite.bounds.size.x or var_98_18 / var_98_17.sprite.bounds.size.y, 0)
				end

				for iter_98_6, iter_98_7 in pairs(arg_95_1.bgs_) do
					if iter_98_6 ~= "ST0603" then
						iter_98_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_19 = 1.16666666666667

			arg_95_1.isInRecall_ = false

			if var_98_19 < arg_95_1.time_ and arg_95_1.time_ <= var_98_19 + arg_98_0 then
				arg_95_1.screenFilterGo_:SetActive(false)

				for iter_98_8, iter_98_9 in pairs(arg_95_1.actors_) do
					for iter_98_10, iter_98_11 in ipairs((iter_98_9:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_98_11.color = iter_98_11.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_98_20 = 0.2

			if var_98_19 <= arg_95_1.time_ and arg_95_1.time_ < var_98_19 + var_98_20 then
				arg_95_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_19) / var_98_20)
			end

			if arg_95_1.time_ >= var_98_19 + var_98_20 and arg_95_1.time_ < var_98_19 + var_98_20 + arg_98_0 then
				arg_95_1.screenFilterEffect_.weight = 0
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_21 = 2.2
			local var_98_22 = 0.5

			if 2.2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_21 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_23 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_23:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_24 = arg_95_1:GetWordFromCfg(413152022)
				local var_98_25 = arg_95_1:FormatText(var_98_24.content)

				arg_95_1.text_.text = var_98_25

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_27 = 20 <= 0 and var_98_22 or var_98_22 * (utf8.len(var_98_25) / 20)

				if (20 <= 0 and var_98_22 or var_98_22 * (utf8.len(var_98_25) / 20)) > 0 and var_98_22 < var_98_27 then
					arg_95_1.talkMaxDuration = var_98_27
					var_98_21 = var_98_21 + 0.3

					if var_98_27 + var_98_21 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_27 + var_98_21
					end
				end

				arg_95_1.text_.text = var_98_25
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152022", "story_v_out_413152.awb") ~= 0 then
					local var_98_28 = manager.audio:GetVoiceLength("story_v_out_413152", "413152022", "story_v_out_413152.awb") / 1000

					if var_98_28 + var_98_21 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_28 + var_98_21
					end

					if var_98_24.prefab_name ~= "" and arg_95_1.actors_[var_98_24.prefab_name] ~= nil then
						local var_98_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_24.prefab_name].transform, "story_v_out_413152", "413152022", "story_v_out_413152.awb")

						arg_95_1:RecordAudio("413152022", var_98_29)
						arg_95_1:RecordAudio("413152022", var_98_29)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_413152", "413152022", "story_v_out_413152.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_413152", "413152022", "story_v_out_413152.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_30 = var_98_21 + 0.3
			local var_98_31 = math.max(var_98_22, arg_95_1.talkMaxDuration)

			if var_98_21 + 0.3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_30 + var_98_31 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_30) / var_98_31

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_30 + var_98_31 and arg_95_1.time_ < var_98_30 + var_98_31 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.14933333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play413152023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413152023
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413152024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10093 = arg_101_1.actors_["10093"].transform.localPosition
				arg_101_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10093", 6)

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
				arg_101_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["10093"].transform.localPosition = Vector3.New(1500, -345, -245)
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
			local var_104_6 = 1.275

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

				local var_104_7 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(413152023).content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 51 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_7) / 51)

				if (51 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_7) / 51)) > 0 and var_104_6 < var_104_9 then
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
	Play413152024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413152024
		arg_105_1.duration_ = 9.87

		local var_105_0 = {
			zh = 9.866,
			ja = 8.133
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
				arg_105_0:Play413152025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10093 = arg_105_1.actors_["10093"].transform.localPosition
				arg_105_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10093", 3)

				for iter_108_0 = 0, arg_105_1.actors_["10093"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["10093"].transform:GetChild(iter_108_0)

					if var_108_0.name == "split_4" or not string.find(var_108_0.name, "split") then
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
			local var_108_6 = 0.625

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

				local var_108_7 = arg_105_1:GetWordFromCfg(413152024)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 25 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 25)

				if (25 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 25)) > 0 and var_108_6 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10

					if var_108_10 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152024", "story_v_out_413152.awb") ~= 0 then
					local var_108_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152024", "story_v_out_413152.awb") / 1000

					if var_108_11 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_5
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_out_413152", "413152024", "story_v_out_413152.awb")

						arg_105_1:RecordAudio("413152024", var_108_12)
						arg_105_1:RecordAudio("413152024", var_108_12)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413152", "413152024", "story_v_out_413152.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413152", "413152024", "story_v_out_413152.awb")
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
	Play413152025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413152025
		arg_109_1.duration_ = 8.5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play413152026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if arg_109_1.bgs_.F10g == nil then
				local var_112_0 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10g")
				var_112_0.name = "F10g"
				var_112_0.transform.parent = arg_109_1.stage_.transform
				var_112_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_.F10g = var_112_0
			end

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				local var_112_1 = arg_109_1.bgs_.F10g

				arg_109_1.bgs_.F10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_2 = var_112_1:GetComponent("SpriteRenderer")

				if var_112_2 and var_112_2.sprite then
					local var_112_3 = 2 * (var_112_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_1.transform.localScale = Vector3.New(var_112_3 / var_112_2.sprite.bounds.size.y < var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x and var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x or var_112_3 / var_112_2.sprite.bounds.size.y, var_112_3 / var_112_2.sprite.bounds.size.y < var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x and var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x or var_112_3 / var_112_2.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "F10g" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_4 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_5 = 2

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_5 then
				local var_112_6 = Color.New(0, 0, 0)

				var_112_6.a = Mathf.Lerp(0, 1, (arg_109_1.time_ - var_112_4) / var_112_5)
				arg_109_1.mask_.color = var_112_6
			end

			if arg_109_1.time_ >= var_112_4 + var_112_5 and arg_109_1.time_ < var_112_4 + var_112_5 + arg_112_0 then
				local var_112_7 = Color.New(0, 0, 0)

				var_112_7.a = 1
				arg_109_1.mask_.color = var_112_7
			end

			local var_112_8 = 2

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_9 = 2

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 then
				local var_112_10 = Color.New(0, 0, 0)

				var_112_10.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_8) / var_112_9)
				arg_109_1.mask_.color = var_112_10
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 then
				local var_112_11 = Color.New(0, 0, 0)

				arg_109_1.mask_.enabled = false
				var_112_11.a = 0
				arg_109_1.mask_.color = var_112_11
			end

			local var_112_12 = arg_109_1.actors_["10093"].transform

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				arg_109_1.var_.moveOldPos10093 = var_112_12.localPosition
				var_112_12.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10093", 7)

				for iter_112_2 = 0, var_112_12.childCount - 1 do
					local var_112_13 = var_112_12:GetChild(iter_112_2)

					if var_112_13.name == "" or not string.find(var_112_13.name, "split") then
						var_112_13.gameObject:SetActive(true)
					else
						var_112_13.gameObject:SetActive(false)
					end
				end
			end

			local var_112_14 = 0.001

			if 2 <= arg_109_1.time_ and arg_109_1.time_ < 2 + var_112_14 then
				var_112_12.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_109_1.time_ - 2) / var_112_14)
			end

			if arg_109_1.time_ >= 2 + var_112_14 and arg_109_1.time_ < 2 + var_112_14 + arg_112_0 then
				var_112_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if 2.6 < arg_109_1.time_ and arg_109_1.time_ <= 2.6 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword02", "")
			end

			local var_112_16 = manager.ui.mainCamera.transform

			if 3.4 < arg_109_1.time_ and arg_109_1.time_ <= 3.4 + arg_112_0 then
				arg_109_1.var_.shakeOldPos = var_112_16.localPosition
			end

			local var_112_17 = 0.6

			if 3.4 <= arg_109_1.time_ and arg_109_1.time_ < 3.4 + var_112_17 then
				local var_112_18, var_112_19 = math.modf((arg_109_1.time_ - 3.4) / 0.066)

				var_112_16.localPosition = Vector3.New(var_112_19 * 0.13, var_112_19 * 0.13, var_112_19 * 0.13) + arg_109_1.var_.shakeOldPos
			end

			if arg_109_1.time_ >= 3.4 + var_112_17 and arg_109_1.time_ < 3.4 + var_112_17 + arg_112_0 then
				var_112_16.localPosition = arg_109_1.var_.shakeOldPos
			end

			if 2.83333333333333 < arg_109_1.time_ and arg_109_1.time_ <= 2.83333333333333 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_scream", "")
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_21 = 3.5
			local var_112_22 = 0.8

			if 3.5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_21 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_23 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_23:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_24 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(413152025).content)

				arg_109_1.text_.text = var_112_24

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_26 = 32 <= 0 and var_112_22 or var_112_22 * (utf8.len(var_112_24) / 32)

				if (32 <= 0 and var_112_22 or var_112_22 * (utf8.len(var_112_24) / 32)) > 0 and var_112_22 < var_112_26 then
					arg_109_1.talkMaxDuration = var_112_26
					var_112_21 = var_112_21 + 0.3

					if var_112_26 + var_112_21 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_26 + var_112_21
					end
				end

				arg_109_1.text_.text = var_112_24
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_27 = var_112_21 + 0.3
			local var_112_28 = math.max(var_112_22, arg_109_1.talkMaxDuration)

			if var_112_21 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_27 + var_112_28 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_27) / var_112_28

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_27 + var_112_28 and arg_109_1.time_ < var_112_27 + var_112_28 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play413152026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413152026
		arg_115_1.duration_ = 4.47

		local var_115_0 = {
			zh = 4.466,
			ja = 3.433
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
				arg_115_0:Play413152027(arg_115_1)
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

				arg_115_1:CheckSpriteTmpPos("10022", 3)

				for iter_118_2 = 0, var_118_2.childCount - 1 do
					local var_118_3 = var_118_2:GetChild(iter_118_2)

					if var_118_3.name == "split_6" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_2.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_115_1.time_ - 0) / var_118_4)
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_2.localPosition = Vector3.New(0, -315, -320)
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
			local var_118_9 = 0.575

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

				local var_118_10 = arg_115_1:GetWordFromCfg(413152026)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 23 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 23)

				if (23 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 23)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152026", "story_v_out_413152.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_413152", "413152026", "story_v_out_413152.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_413152", "413152026", "story_v_out_413152.awb")

						arg_115_1:RecordAudio("413152026", var_118_15)
						arg_115_1:RecordAudio("413152026", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_413152", "413152026", "story_v_out_413152.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_413152", "413152026", "story_v_out_413152.awb")
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
	Play413152027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413152027
		arg_119_1.duration_ = 5.7

		local var_119_0 = {
			zh = 3.9,
			ja = 5.7
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
				arg_119_0:Play413152028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10022"]) and arg_119_1.var_.actorSpriteComps10022 == nil then
				arg_119_1.var_.actorSpriteComps10022 = arg_119_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_0 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10022"]) then
				if arg_119_1.var_.actorSpriteComps10022 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								iter_122_1.color = Color.New(Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor2.r, (arg_119_1.time_ - 0) / var_122_0), Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor2.g, (arg_119_1.time_ - 0) / var_122_0), (Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor2.b, (arg_119_1.time_ - 0) / var_122_0)))
							else
								local var_122_1 = Mathf.Lerp(iter_122_1.color.r, 0.5, (arg_119_1.time_ - 0) / var_122_0)

								iter_122_1.color = Color.New(var_122_1, var_122_1, var_122_1)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10022"]) and arg_119_1.var_.actorSpriteComps10022 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou01", "")
			end

			local var_122_3 = 0
			local var_122_4 = 0.5

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_3 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_5 = arg_119_1:GetWordFromCfg(413152027)
				local var_122_6 = arg_119_1:FormatText(var_122_5.content)

				arg_119_1.text_.text = var_122_6

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_8 = 20 <= 0 and var_122_4 or var_122_4 * (utf8.len(var_122_6) / 20)

				if (20 <= 0 and var_122_4 or var_122_4 * (utf8.len(var_122_6) / 20)) > 0 and var_122_4 < var_122_8 then
					arg_119_1.talkMaxDuration = var_122_8

					if var_122_8 + var_122_3 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_3
					end
				end

				arg_119_1.text_.text = var_122_6
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152027", "story_v_out_413152.awb") ~= 0 then
					local var_122_9 = manager.audio:GetVoiceLength("story_v_out_413152", "413152027", "story_v_out_413152.awb") / 1000

					if var_122_9 + var_122_3 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_3
					end

					if var_122_5.prefab_name ~= "" and arg_119_1.actors_[var_122_5.prefab_name] ~= nil then
						local var_122_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_5.prefab_name].transform, "story_v_out_413152", "413152027", "story_v_out_413152.awb")

						arg_119_1:RecordAudio("413152027", var_122_10)
						arg_119_1:RecordAudio("413152027", var_122_10)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413152", "413152027", "story_v_out_413152.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413152", "413152027", "story_v_out_413152.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_11 = math.max(var_122_4, arg_119_1.talkMaxDuration)

			if var_122_3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_3 + var_122_11 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_3) / var_122_11

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_3 + var_122_11 and arg_119_1.time_ < var_122_3 + var_122_11 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play413152028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413152028
		arg_123_1.duration_ = 5.73

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play413152029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10022 = arg_123_1.actors_["10022"].transform.localPosition
				arg_123_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10022", 6)

				for iter_126_0 = 0, arg_123_1.actors_["10022"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["10022"].transform:GetChild(iter_126_0)

					if var_126_0.name == "" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["10022"].transform.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_126_2 = arg_123_1.actors_["10022"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10022 == nil then
				arg_123_1.var_.actorSpriteComps10022 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps10022 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_126_2 then
							if arg_123_1.isInRecall_ then
								iter_126_2.color = Color.New(Mathf.Lerp(iter_126_2.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_3), Mathf.Lerp(iter_126_2.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_3), (Mathf.Lerp(iter_126_2.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_3)))
							else
								local var_126_4 = Mathf.Lerp(iter_126_2.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_3)

								iter_126_2.color = Color.New(var_126_4, var_126_4, var_126_4)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10022 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_126_4 then
						iter_126_4.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10022 = nil
			end

			local var_126_5 = manager.ui.mainCamera.transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.shakeOldPos = var_126_5.localPosition
			end

			local var_126_6 = 0.533333333333333

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 then
				local var_126_7, var_126_8 = math.modf((arg_123_1.time_ - 0) / 0.066)

				var_126_5.localPosition = Vector3.New(var_126_8 * 0.13, var_126_8 * 0.13, var_126_8 * 0.13) + arg_123_1.var_.shakeOldPos
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 then
				var_126_5.localPosition = arg_123_1.var_.shakeOldPos
			end

			local var_126_9 = 0

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			if arg_123_1.time_ >= var_126_9 + 0.533333333333333 and arg_123_1.time_ < var_126_9 + 0.533333333333333 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_10 = 0.733333333333333
			local var_126_11 = 0.975

			if 0.733333333333333 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_12 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_12:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_13 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(413152028).content)

				arg_123_1.text_.text = var_126_13

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_15 = 39 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 39)

				if (39 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 39)) > 0 and var_126_11 < var_126_15 then
					arg_123_1.talkMaxDuration = var_126_15
					var_126_10 = var_126_10 + 0.3

					if var_126_15 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_10
					end
				end

				arg_123_1.text_.text = var_126_13
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = var_126_10 + 0.3
			local var_126_17 = math.max(var_126_11, arg_123_1.talkMaxDuration)

			if var_126_10 + 0.3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_16) / var_126_17

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 then
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
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play413152029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413152029
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play413152030(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.975

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(413152029).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 39 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 39)

				if (39 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 39)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play413152030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413152030
		arg_133_1.duration_ = 3.7

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play413152031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10022 = arg_133_1.actors_["10022"].transform.localPosition
				arg_133_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10022", 3)

				for iter_136_0 = 0, arg_133_1.actors_["10022"].transform.childCount - 1 do
					local var_136_0 = arg_133_1.actors_["10022"].transform:GetChild(iter_136_0)

					if var_136_0.name == "split_6" or not string.find(var_136_0.name, "split") then
						var_136_0.gameObject:SetActive(true)
					else
						var_136_0.gameObject:SetActive(false)
					end
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_133_1.time_ - 0) / var_136_1)
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_136_2 = arg_133_1.actors_["10022"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10022 == nil then
				arg_133_1.var_.actorSpriteComps10022 = var_136_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_3 = 2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.actorSpriteComps10022 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								iter_136_2.color = Color.New(Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, (arg_133_1.time_ - 0) / var_136_3), Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, (arg_133_1.time_ - 0) / var_136_3), (Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, (arg_133_1.time_ - 0) / var_136_3)))
							else
								local var_136_4 = Mathf.Lerp(iter_136_2.color.r, 1, (arg_133_1.time_ - 0) / var_136_3)

								iter_136_2.color = Color.New(var_136_4, var_136_4, var_136_4)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10022 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_136_4 then
						iter_136_4.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_133_1.var_.actorSpriteComps10022 = nil
			end

			local var_136_5 = 0
			local var_136_6 = 0.425

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_7 = arg_133_1:GetWordFromCfg(413152030)
				local var_136_8 = arg_133_1:FormatText(var_136_7.content)

				arg_133_1.text_.text = var_136_8

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 17 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 17)

				if (17 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 17)) > 0 and var_136_6 < var_136_10 then
					arg_133_1.talkMaxDuration = var_136_10

					if var_136_10 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_5
					end
				end

				arg_133_1.text_.text = var_136_8
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152030", "story_v_out_413152.awb") ~= 0 then
					local var_136_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152030", "story_v_out_413152.awb") / 1000

					if var_136_11 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_5
					end

					if var_136_7.prefab_name ~= "" and arg_133_1.actors_[var_136_7.prefab_name] ~= nil then
						local var_136_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_7.prefab_name].transform, "story_v_out_413152", "413152030", "story_v_out_413152.awb")

						arg_133_1:RecordAudio("413152030", var_136_12)
						arg_133_1:RecordAudio("413152030", var_136_12)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413152", "413152030", "story_v_out_413152.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413152", "413152030", "story_v_out_413152.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_13 = math.max(var_136_6, arg_133_1.talkMaxDuration)

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_5) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_5 + var_136_13 and arg_133_1.time_ < var_136_5 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play413152031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413152031
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play413152032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10022 = arg_137_1.actors_["10022"].transform.localPosition
				arg_137_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10022", 6)

				for iter_140_0 = 0, arg_137_1.actors_["10022"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["10022"].transform:GetChild(iter_140_0)

					if var_140_0.name == "" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["10022"].transform.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_140_2 = arg_137_1.actors_["10022"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10022 == nil then
				arg_137_1.var_.actorSpriteComps10022 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps10022 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								iter_140_2.color = Color.New(Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_3), Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_3), (Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_3)))
							else
								local var_140_4 = Mathf.Lerp(iter_140_2.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_3)

								iter_140_2.color = Color.New(var_140_4, var_140_4, var_140_4)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10022 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_140_4 then
						iter_140_4.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10022 = nil
			end

			local var_140_5 = 0
			local var_140_6 = 0.775

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(413152031).content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 31 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_7) / 31)

				if (31 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_7) / 31)) > 0 and var_140_6 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_10 and arg_137_1.time_ < var_140_5 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play413152032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413152032
		arg_141_1.duration_ = 7.2

		local var_141_0 = {
			zh = 7.2,
			ja = 7.066
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
				arg_141_0:Play413152033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10022 = arg_141_1.actors_["10022"].transform.localPosition
				arg_141_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10022", 3)

				for iter_144_0 = 0, arg_141_1.actors_["10022"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["10022"].transform:GetChild(iter_144_0)

					if var_144_0.name == "split_8" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_144_2 = arg_141_1.actors_["10022"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10022 == nil then
				arg_141_1.var_.actorSpriteComps10022 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps10022 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								iter_144_2.color = Color.New(Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_3), Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_3), (Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_3)))
							else
								local var_144_4 = Mathf.Lerp(iter_144_2.color.r, 1, (arg_141_1.time_ - 0) / var_144_3)

								iter_144_2.color = Color.New(var_144_4, var_144_4, var_144_4)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10022 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_144_4 then
						iter_144_4.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps10022 = nil
			end

			local var_144_5 = 0
			local var_144_6 = 0.8

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(413152032)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 32 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 32)

				if (32 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 32)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152032", "story_v_out_413152.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152032", "story_v_out_413152.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_413152", "413152032", "story_v_out_413152.awb")

						arg_141_1:RecordAudio("413152032", var_144_12)
						arg_141_1:RecordAudio("413152032", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413152", "413152032", "story_v_out_413152.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413152", "413152032", "story_v_out_413152.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_13 = math.max(var_144_6, arg_141_1.talkMaxDuration)

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_13 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_5) / var_144_13

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_5 + var_144_13 and arg_141_1.time_ < var_144_5 + var_144_13 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play413152033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413152033
		arg_145_1.duration_ = 5.27

		local var_145_0 = {
			zh = 4.466,
			ja = 5.266
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
				arg_145_0:Play413152034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.4

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(413152033)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 16 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 16)

				if (16 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 16)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152033", "story_v_out_413152.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152033", "story_v_out_413152.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_413152", "413152033", "story_v_out_413152.awb")

						arg_145_1:RecordAudio("413152033", var_148_6)
						arg_145_1:RecordAudio("413152033", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413152", "413152033", "story_v_out_413152.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413152", "413152033", "story_v_out_413152.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play413152034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413152034
		arg_149_1.duration_ = 8.33

		local var_149_0 = {
			zh = 6.733,
			ja = 8.333
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
				arg_149_0:Play413152035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10022"]) and arg_149_1.var_.actorSpriteComps10022 == nil then
				arg_149_1.var_.actorSpriteComps10022 = arg_149_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10022"]) then
				if arg_149_1.var_.actorSpriteComps10022 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								iter_152_1.color = Color.New(Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_0), Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_0), (Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_0)))
							else
								local var_152_1 = Mathf.Lerp(iter_152_1.color.r, 1, (arg_149_1.time_ - 0) / var_152_0)

								iter_152_1.color = Color.New(var_152_1, var_152_1, var_152_1)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10022"]) and arg_149_1.var_.actorSpriteComps10022 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps10022 = nil
			end

			local var_152_2 = 0
			local var_152_3 = 0.775

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_4 = arg_149_1:GetWordFromCfg(413152034)
				local var_152_5 = arg_149_1:FormatText(var_152_4.content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 31 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 31)

				if (31 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 31)) > 0 and var_152_3 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152034", "story_v_out_413152.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152034", "story_v_out_413152.awb") / 1000

					if var_152_8 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_2
					end

					if var_152_4.prefab_name ~= "" and arg_149_1.actors_[var_152_4.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_4.prefab_name].transform, "story_v_out_413152", "413152034", "story_v_out_413152.awb")

						arg_149_1:RecordAudio("413152034", var_152_9)
						arg_149_1:RecordAudio("413152034", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_413152", "413152034", "story_v_out_413152.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_413152", "413152034", "story_v_out_413152.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_10 and arg_149_1.time_ < var_152_2 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play413152035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413152035
		arg_153_1.duration_ = 9.97

		local var_153_0 = {
			zh = 6.966,
			ja = 9.966
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
				arg_153_0:Play413152036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10022"]) and arg_153_1.var_.actorSpriteComps10022 == nil then
				arg_153_1.var_.actorSpriteComps10022 = arg_153_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10022"]) then
				if arg_153_1.var_.actorSpriteComps10022 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								iter_156_1.color = Color.New(Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_0), Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_0), (Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_0)))
							else
								local var_156_1 = Mathf.Lerp(iter_156_1.color.r, 1, (arg_153_1.time_ - 0) / var_156_0)

								iter_156_1.color = Color.New(var_156_1, var_156_1, var_156_1)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10022"]) and arg_153_1.var_.actorSpriteComps10022 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps10022 = nil
			end

			local var_156_2 = 0
			local var_156_3 = 0.75

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_4 = arg_153_1:GetWordFromCfg(413152035)
				local var_156_5 = arg_153_1:FormatText(var_156_4.content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_7 = 30 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 30)

				if (30 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 30)) > 0 and var_156_3 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152035", "story_v_out_413152.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152035", "story_v_out_413152.awb") / 1000

					if var_156_8 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_2
					end

					if var_156_4.prefab_name ~= "" and arg_153_1.actors_[var_156_4.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_4.prefab_name].transform, "story_v_out_413152", "413152035", "story_v_out_413152.awb")

						arg_153_1:RecordAudio("413152035", var_156_9)
						arg_153_1:RecordAudio("413152035", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413152", "413152035", "story_v_out_413152.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413152", "413152035", "story_v_out_413152.awb")
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
	Play413152036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413152036
		arg_157_1.duration_ = 6.6

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play413152037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 1.366 < arg_157_1.time_ and arg_157_1.time_ <= 1.366 + arg_160_0 then
				arg_157_1.var_.moveOldPos10022 = arg_157_1.actors_["10022"].transform.localPosition
				arg_157_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10022", 7)

				for iter_160_0 = 0, arg_157_1.actors_["10022"].transform.childCount - 1 do
					local var_160_0 = arg_157_1.actors_["10022"].transform:GetChild(iter_160_0)

					if var_160_0.name == "" or not string.find(var_160_0.name, "split") then
						var_160_0.gameObject:SetActive(true)
					else
						var_160_0.gameObject:SetActive(false)
					end
				end
			end

			local var_160_1 = 0.001

			if 1.366 <= arg_157_1.time_ and arg_157_1.time_ < 1.366 + var_160_1 then
				arg_157_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_157_1.time_ - 1.366) / var_160_1)
			end

			if arg_157_1.time_ >= 1.366 + var_160_1 and arg_157_1.time_ < 1.366 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_2 = arg_157_1.actors_["10022"]

			if 1.366 < arg_157_1.time_ and arg_157_1.time_ <= 1.366 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps10022 == nil then
				arg_157_1.var_.actorSpriteComps10022 = var_160_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_3 = 0.034

			if 1.366 <= arg_157_1.time_ and arg_157_1.time_ < 1.366 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.actorSpriteComps10022 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								iter_160_2.color = Color.New(Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 1.366) / var_160_3), Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 1.366) / var_160_3), (Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 1.366) / var_160_3)))
							else
								local var_160_4 = Mathf.Lerp(iter_160_2.color.r, 0.5, (arg_157_1.time_ - 1.366) / var_160_3)

								iter_160_2.color = Color.New(var_160_4, var_160_4, var_160_4)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 1.366 + var_160_3 and arg_157_1.time_ < 1.366 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps10022 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_160_4 then
						iter_160_4.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10022 = nil
			end

			local var_160_5 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_6 = 1.4

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_6 then
				local var_160_7 = Color.New(1, 1, 1)

				var_160_7.a = Mathf.Lerp(0, 1, (arg_157_1.time_ - var_160_5) / var_160_6)
				arg_157_1.mask_.color = var_160_7
			end

			if arg_157_1.time_ >= var_160_5 + var_160_6 and arg_157_1.time_ < var_160_5 + var_160_6 + arg_160_0 then
				local var_160_8 = Color.New(1, 1, 1)

				var_160_8.a = 1
				arg_157_1.mask_.color = var_160_8
			end

			local var_160_9 = 1.4

			if 1.4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_10 = 1.4

			if var_160_9 <= arg_157_1.time_ and arg_157_1.time_ < var_160_9 + var_160_10 then
				local var_160_11 = Color.New(1, 1, 1)

				var_160_11.a = Mathf.Lerp(1, 0, (arg_157_1.time_ - var_160_9) / var_160_10)
				arg_157_1.mask_.color = var_160_11
			end

			if arg_157_1.time_ >= var_160_9 + var_160_10 and arg_157_1.time_ < var_160_9 + var_160_10 + arg_160_0 then
				local var_160_12 = Color.New(1, 1, 1)

				arg_157_1.mask_.enabled = false
				var_160_12.a = 0
				arg_157_1.mask_.color = var_160_12
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_13 = 1.6
			local var_160_14 = 0.975

			if 1.6 < arg_157_1.time_ and arg_157_1.time_ <= var_160_13 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_15 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_15:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_16 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(413152036).content)

				arg_157_1.text_.text = var_160_16

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_18 = 39 <= 0 and var_160_14 or var_160_14 * (utf8.len(var_160_16) / 39)

				if (39 <= 0 and var_160_14 or var_160_14 * (utf8.len(var_160_16) / 39)) > 0 and var_160_14 < var_160_18 then
					arg_157_1.talkMaxDuration = var_160_18
					var_160_13 = var_160_13 + 0.3

					if var_160_18 + var_160_13 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_18 + var_160_13
					end
				end

				arg_157_1.text_.text = var_160_16
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_19 = var_160_13 + 0.3
			local var_160_20 = math.max(var_160_14, arg_157_1.talkMaxDuration)

			if var_160_13 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_19 + var_160_20 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_19) / var_160_20

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_19 + var_160_20 and arg_157_1.time_ < var_160_19 + var_160_20 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.366,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play413152037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413152037
		arg_163_1.duration_ = 7

		local var_163_0 = {
			zh = 6.4,
			ja = 7
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
				arg_163_0:Play413152038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10022 = arg_163_1.actors_["10022"].transform.localPosition
				arg_163_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10022", 3)

				for iter_166_0 = 0, arg_163_1.actors_["10022"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["10022"].transform:GetChild(iter_166_0)

					if var_166_0.name == "split_8" or not string.find(var_166_0.name, "split") then
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
			local var_166_6 = 0.775

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

				local var_166_7 = arg_163_1:GetWordFromCfg(413152037)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 31 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 31)

				if (31 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 31)) > 0 and var_166_6 < var_166_10 then
					arg_163_1.talkMaxDuration = var_166_10

					if var_166_10 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152037", "story_v_out_413152.awb") ~= 0 then
					local var_166_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152037", "story_v_out_413152.awb") / 1000

					if var_166_11 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_5
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_out_413152", "413152037", "story_v_out_413152.awb")

						arg_163_1:RecordAudio("413152037", var_166_12)
						arg_163_1:RecordAudio("413152037", var_166_12)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413152", "413152037", "story_v_out_413152.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413152", "413152037", "story_v_out_413152.awb")
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
	Play413152038 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413152038
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play413152039(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10022 = arg_167_1.actors_["10022"].transform.localPosition
				arg_167_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10022", 6)

				for iter_170_0 = 0, arg_167_1.actors_["10022"].transform.childCount - 1 do
					local var_170_0 = arg_167_1.actors_["10022"].transform:GetChild(iter_170_0)

					if var_170_0.name == "" or not string.find(var_170_0.name, "split") then
						var_170_0.gameObject:SetActive(true)
					else
						var_170_0.gameObject:SetActive(false)
					end
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_167_1.time_ - 0) / var_170_1)
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["10022"].transform.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_170_2 = arg_167_1.actors_["10022"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10022 == nil then
				arg_167_1.var_.actorSpriteComps10022 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps10022 then
					for iter_170_1, iter_170_2 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_170_2 then
							if arg_167_1.isInRecall_ then
								iter_170_2.color = Color.New(Mathf.Lerp(iter_170_2.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_3), Mathf.Lerp(iter_170_2.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_3), (Mathf.Lerp(iter_170_2.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_3)))
							else
								local var_170_4 = Mathf.Lerp(iter_170_2.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_3)

								iter_170_2.color = Color.New(var_170_4, var_170_4, var_170_4)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10022 then
				for iter_170_3, iter_170_4 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_170_4 then
						iter_170_4.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10022 = nil
			end

			local var_170_5 = 0
			local var_170_6 = 1.25

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(413152038).content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 50 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 50)

				if (50 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 50)) > 0 and var_170_6 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_10 and arg_167_1.time_ < var_170_5 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play413152039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413152039
		arg_171_1.duration_ = 3.57

		local var_171_0 = {
			zh = 3.366,
			ja = 3.566
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
				arg_171_0:Play413152040(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10022 = arg_171_1.actors_["10022"].transform.localPosition
				arg_171_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10022", 3)

				for iter_174_0 = 0, arg_171_1.actors_["10022"].transform.childCount - 1 do
					local var_174_0 = arg_171_1.actors_["10022"].transform:GetChild(iter_174_0)

					if var_174_0.name == "split_2" or not string.find(var_174_0.name, "split") then
						var_174_0.gameObject:SetActive(true)
					else
						var_174_0.gameObject:SetActive(false)
					end
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_171_1.time_ - 0) / var_174_1)
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_174_2 = arg_171_1.actors_["10022"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10022 == nil then
				arg_171_1.var_.actorSpriteComps10022 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps10022 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_174_2 then
							if arg_171_1.isInRecall_ then
								iter_174_2.color = Color.New(Mathf.Lerp(iter_174_2.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_3), Mathf.Lerp(iter_174_2.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_3), (Mathf.Lerp(iter_174_2.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_3)))
							else
								local var_174_4 = Mathf.Lerp(iter_174_2.color.r, 1, (arg_171_1.time_ - 0) / var_174_3)

								iter_174_2.color = Color.New(var_174_4, var_174_4, var_174_4)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10022 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_174_4 then
						iter_174_4.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps10022 = nil
			end

			local var_174_5 = 0
			local var_174_6 = 0.325

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:GetWordFromCfg(413152039)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 13 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 13)

				if (13 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 13)) > 0 and var_174_6 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152039", "story_v_out_413152.awb") ~= 0 then
					local var_174_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152039", "story_v_out_413152.awb") / 1000

					if var_174_11 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_5
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_413152", "413152039", "story_v_out_413152.awb")

						arg_171_1:RecordAudio("413152039", var_174_12)
						arg_171_1:RecordAudio("413152039", var_174_12)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413152", "413152039", "story_v_out_413152.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413152", "413152039", "story_v_out_413152.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_13 and arg_171_1.time_ < var_174_5 + var_174_13 + arg_174_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play413152040 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413152040
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play413152041(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10022 = arg_175_1.actors_["10022"].transform.localPosition
				arg_175_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10022", 6)

				for iter_178_0 = 0, arg_175_1.actors_["10022"].transform.childCount - 1 do
					local var_178_0 = arg_175_1.actors_["10022"].transform:GetChild(iter_178_0)

					if var_178_0.name == "" or not string.find(var_178_0.name, "split") then
						var_178_0.gameObject:SetActive(true)
					else
						var_178_0.gameObject:SetActive(false)
					end
				end
			end

			local var_178_1 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_1 then
				arg_175_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_175_1.time_ - 0) / var_178_1)
			end

			if arg_175_1.time_ >= 0 + var_178_1 and arg_175_1.time_ < 0 + var_178_1 + arg_178_0 then
				arg_175_1.actors_["10022"].transform.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_178_2 = arg_175_1.actors_["10022"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10022 == nil then
				arg_175_1.var_.actorSpriteComps10022 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps10022 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10022 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_178_4 then
						iter_178_4.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps10022 = nil
			end

			local var_178_5 = 0
			local var_178_6 = 1

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_7 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(413152040).content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 40 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_7) / 40)

				if (40 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_7) / 40)) > 0 and var_178_6 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_5
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_6, arg_175_1.talkMaxDuration)

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_5) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_5 + var_178_10 and arg_175_1.time_ < var_178_5 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play413152041 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 413152041
		arg_179_1.duration_ = 2.9

		local var_179_0 = {
			zh = 2.9,
			ja = 2.5
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
				arg_179_0:Play413152042(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10022 = arg_179_1.actors_["10022"].transform.localPosition
				arg_179_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10022", 3)

				for iter_182_0 = 0, arg_179_1.actors_["10022"].transform.childCount - 1 do
					local var_182_0 = arg_179_1.actors_["10022"].transform:GetChild(iter_182_0)

					if var_182_0.name == "split_6" or not string.find(var_182_0.name, "split") then
						var_182_0.gameObject:SetActive(true)
					else
						var_182_0.gameObject:SetActive(false)
					end
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_179_1.time_ - 0) / var_182_1)
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_182_2 = arg_179_1.actors_["10022"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps10022 == nil then
				arg_179_1.var_.actorSpriteComps10022 = var_182_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_3 = 2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.actorSpriteComps10022 then
					for iter_182_1, iter_182_2 in pairs(arg_179_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_182_2 then
							if arg_179_1.isInRecall_ then
								iter_182_2.color = Color.New(Mathf.Lerp(iter_182_2.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_3), Mathf.Lerp(iter_182_2.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_3), (Mathf.Lerp(iter_182_2.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_3)))
							else
								local var_182_4 = Mathf.Lerp(iter_182_2.color.r, 1, (arg_179_1.time_ - 0) / var_182_3)

								iter_182_2.color = Color.New(var_182_4, var_182_4, var_182_4)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps10022 then
				for iter_182_3, iter_182_4 in pairs(arg_179_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_182_4 then
						iter_182_4.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps10022 = nil
			end

			local var_182_5 = 0
			local var_182_6 = 0.275

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:GetWordFromCfg(413152041)
				local var_182_8 = arg_179_1:FormatText(var_182_7.content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 11 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 11)

				if (11 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 11)) > 0 and var_182_6 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_8
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152041", "story_v_out_413152.awb") ~= 0 then
					local var_182_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152041", "story_v_out_413152.awb") / 1000

					if var_182_11 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_5
					end

					if var_182_7.prefab_name ~= "" and arg_179_1.actors_[var_182_7.prefab_name] ~= nil then
						local var_182_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_7.prefab_name].transform, "story_v_out_413152", "413152041", "story_v_out_413152.awb")

						arg_179_1:RecordAudio("413152041", var_182_12)
						arg_179_1:RecordAudio("413152041", var_182_12)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_413152", "413152041", "story_v_out_413152.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_413152", "413152041", "story_v_out_413152.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_13 = math.max(var_182_6, arg_179_1.talkMaxDuration)

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_13 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_5) / var_182_13

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_5 + var_182_13 and arg_179_1.time_ < var_182_5 + var_182_13 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play413152042 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 413152042
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play413152043(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10022 = arg_183_1.actors_["10022"].transform.localPosition
				arg_183_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10022", 6)

				for iter_186_0 = 0, arg_183_1.actors_["10022"].transform.childCount - 1 do
					local var_186_0 = arg_183_1.actors_["10022"].transform:GetChild(iter_186_0)

					if var_186_0.name == "" or not string.find(var_186_0.name, "split") then
						var_186_0.gameObject:SetActive(true)
					else
						var_186_0.gameObject:SetActive(false)
					end
				end
			end

			local var_186_1 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 then
				arg_183_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_183_1.time_ - 0) / var_186_1)
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 then
				arg_183_1.actors_["10022"].transform.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_186_2 = arg_183_1.actors_["10022"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps10022 == nil then
				arg_183_1.var_.actorSpriteComps10022 = var_186_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_3 = 2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.actorSpriteComps10022 then
					for iter_186_1, iter_186_2 in pairs(arg_183_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_186_2 then
							if arg_183_1.isInRecall_ then
								iter_186_2.color = Color.New(Mathf.Lerp(iter_186_2.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_3), Mathf.Lerp(iter_186_2.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_3), (Mathf.Lerp(iter_186_2.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_3)))
							else
								local var_186_4 = Mathf.Lerp(iter_186_2.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_3)

								iter_186_2.color = Color.New(var_186_4, var_186_4, var_186_4)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps10022 then
				for iter_186_3, iter_186_4 in pairs(arg_183_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_186_4 then
						iter_186_4.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			local var_186_6 = 0
			local var_186_7 = 0.775

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(413152042).content)

				arg_183_1.text_.text = var_186_8

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_10 = 31 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_8) / 31)

				if (31 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_8) / 31)) > 0 and var_186_7 < var_186_10 then
					arg_183_1.talkMaxDuration = var_186_10

					if var_186_10 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_8
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_11 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_11 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_11

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_11 and arg_183_1.time_ < var_186_6 + var_186_11 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play413152043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 413152043
		arg_187_1.duration_ = 2

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play413152044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10022 = arg_187_1.actors_["10022"].transform.localPosition
				arg_187_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10022", 3)

				for iter_190_0 = 0, arg_187_1.actors_["10022"].transform.childCount - 1 do
					local var_190_0 = arg_187_1.actors_["10022"].transform:GetChild(iter_190_0)

					if var_190_0.name == "split_2" or not string.find(var_190_0.name, "split") then
						var_190_0.gameObject:SetActive(true)
					else
						var_190_0.gameObject:SetActive(false)
					end
				end
			end

			local var_190_1 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 then
				arg_187_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_187_1.time_ - 0) / var_190_1)
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 then
				arg_187_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_190_2 = arg_187_1.actors_["10022"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps10022 == nil then
				arg_187_1.var_.actorSpriteComps10022 = var_190_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_3 = 2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 and not isNil(var_190_2) then
				if arg_187_1.var_.actorSpriteComps10022 then
					for iter_190_1, iter_190_2 in pairs(arg_187_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_190_2 then
							if arg_187_1.isInRecall_ then
								iter_190_2.color = Color.New(Mathf.Lerp(iter_190_2.color.r, arg_187_1.hightColor1.r, (arg_187_1.time_ - 0) / var_190_3), Mathf.Lerp(iter_190_2.color.g, arg_187_1.hightColor1.g, (arg_187_1.time_ - 0) / var_190_3), (Mathf.Lerp(iter_190_2.color.b, arg_187_1.hightColor1.b, (arg_187_1.time_ - 0) / var_190_3)))
							else
								local var_190_4 = Mathf.Lerp(iter_190_2.color.r, 1, (arg_187_1.time_ - 0) / var_190_3)

								iter_190_2.color = Color.New(var_190_4, var_190_4, var_190_4)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps10022 then
				for iter_190_3, iter_190_4 in pairs(arg_187_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_190_4 then
						iter_190_4.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_187_1.var_.actorSpriteComps10022 = nil
			end

			local var_190_5 = 0
			local var_190_6 = 0.1

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_7 = arg_187_1:GetWordFromCfg(413152043)
				local var_190_8 = arg_187_1:FormatText(var_190_7.content)

				arg_187_1.text_.text = var_190_8

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_10 = 4 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_8) / 4)

				if (4 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_8) / 4)) > 0 and var_190_6 < var_190_10 then
					arg_187_1.talkMaxDuration = var_190_10

					if var_190_10 + var_190_5 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_5
					end
				end

				arg_187_1.text_.text = var_190_8
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152043", "story_v_out_413152.awb") ~= 0 then
					local var_190_11 = manager.audio:GetVoiceLength("story_v_out_413152", "413152043", "story_v_out_413152.awb") / 1000

					if var_190_11 + var_190_5 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_11 + var_190_5
					end

					if var_190_7.prefab_name ~= "" and arg_187_1.actors_[var_190_7.prefab_name] ~= nil then
						local var_190_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_7.prefab_name].transform, "story_v_out_413152", "413152043", "story_v_out_413152.awb")

						arg_187_1:RecordAudio("413152043", var_190_12)
						arg_187_1:RecordAudio("413152043", var_190_12)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_413152", "413152043", "story_v_out_413152.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_413152", "413152043", "story_v_out_413152.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_13 = math.max(var_190_6, arg_187_1.talkMaxDuration)

			if var_190_5 <= arg_187_1.time_ and arg_187_1.time_ < var_190_5 + var_190_13 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_5) / var_190_13

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_5 + var_190_13 and arg_187_1.time_ < var_190_5 + var_190_13 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play413152044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 413152044
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play413152045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10022 = arg_191_1.actors_["10022"].transform.localPosition
				arg_191_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10022", 6)

				for iter_194_0 = 0, arg_191_1.actors_["10022"].transform.childCount - 1 do
					local var_194_0 = arg_191_1.actors_["10022"].transform:GetChild(iter_194_0)

					if var_194_0.name == "" or not string.find(var_194_0.name, "split") then
						var_194_0.gameObject:SetActive(true)
					else
						var_194_0.gameObject:SetActive(false)
					end
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_191_1.time_ - 0) / var_194_1)
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["10022"].transform.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_194_2 = arg_191_1.actors_["10022"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10022 == nil then
				arg_191_1.var_.actorSpriteComps10022 = var_194_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_3 = 2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.actorSpriteComps10022 then
					for iter_194_1, iter_194_2 in pairs(arg_191_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_194_2 then
							if arg_191_1.isInRecall_ then
								iter_194_2.color = Color.New(Mathf.Lerp(iter_194_2.color.r, arg_191_1.hightColor2.r, (arg_191_1.time_ - 0) / var_194_3), Mathf.Lerp(iter_194_2.color.g, arg_191_1.hightColor2.g, (arg_191_1.time_ - 0) / var_194_3), (Mathf.Lerp(iter_194_2.color.b, arg_191_1.hightColor2.b, (arg_191_1.time_ - 0) / var_194_3)))
							else
								local var_194_4 = Mathf.Lerp(iter_194_2.color.r, 0.5, (arg_191_1.time_ - 0) / var_194_3)

								iter_194_2.color = Color.New(var_194_4, var_194_4, var_194_4)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10022 then
				for iter_194_3, iter_194_4 in pairs(arg_191_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_194_4 then
						iter_194_4.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_191_1.var_.actorSpriteComps10022 = nil
			end

			local var_194_5 = 0
			local var_194_6 = 0.7

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_7 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(413152044).content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 28 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_7) / 28)

				if (28 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_7) / 28)) > 0 and var_194_6 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_10 and arg_191_1.time_ < var_194_5 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play413152045 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 413152045
		arg_195_1.duration_ = 6

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play413152046(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0.333333333333333 < arg_195_1.time_ and arg_195_1.time_ <= 0.333333333333333 + arg_198_0 then
				arg_195_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_198_0 = 0.5

			if 0.333333333333333 <= arg_195_1.time_ and arg_195_1.time_ < 0.333333333333333 + var_198_0 then
				local var_198_1, var_198_2 = math.modf((arg_195_1.time_ - 0.333333333333333) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_198_2 * 0.13, var_198_2 * 0.13, var_198_2 * 0.13) + arg_195_1.var_.shakeOldPos
			end

			if arg_195_1.time_ >= 0.333333333333333 + var_198_0 and arg_195_1.time_ < 0.333333333333333 + var_198_0 + arg_198_0 then
				manager.ui.mainCamera.transform.localPosition = arg_195_1.var_.shakeOldPos
			end

			local var_198_3 = 0

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_3 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = false

				arg_195_1:SetGaussion(false)
			end

			local var_198_4 = 0.333333333333333

			if var_198_3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_3 + var_198_4 then
				local var_198_5 = Color.New(1, 1, 1)

				var_198_5.a = Mathf.Lerp(1, 0, (arg_195_1.time_ - var_198_3) / var_198_4)
				arg_195_1.mask_.color = var_198_5
			end

			if arg_195_1.time_ >= var_198_3 + var_198_4 and arg_195_1.time_ < var_198_3 + var_198_4 + arg_198_0 then
				local var_198_6 = Color.New(1, 1, 1)

				arg_195_1.mask_.enabled = false
				var_198_6.a = 0
				arg_195_1.mask_.color = var_198_6
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_arrow2", "")
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_8 = 1
			local var_198_9 = 0.925

			if 1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_10 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_10:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_11 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(413152045).content)

				arg_195_1.text_.text = var_198_11

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_13 = 37 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_11) / 37)

				if (37 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_11) / 37)) > 0 and var_198_9 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13
					var_198_8 = var_198_8 + 0.3

					if var_198_13 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_8
					end
				end

				arg_195_1.text_.text = var_198_11
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = var_198_8 + 0.3
			local var_198_15 = math.max(var_198_9, arg_195_1.talkMaxDuration)

			if var_198_8 + 0.3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_14 + var_198_15 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_14) / var_198_15

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_14 + var_198_15 and arg_195_1.time_ < var_198_14 + var_198_15 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play413152046 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413152046
		arg_201_1.duration_ = 3.8

		local var_201_0 = {
			zh = 3.8,
			ja = 2.5
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
				arg_201_0:Play413152047(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.475

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_3")

				arg_201_1.callingController_:SetSelectedState("calling")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:GetWordFromCfg(413152046)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 19 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 19)

				if (19 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 19)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152046", "story_v_out_413152.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152046", "story_v_out_413152.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_413152", "413152046", "story_v_out_413152.awb")

						arg_201_1:RecordAudio("413152046", var_204_6)
						arg_201_1:RecordAudio("413152046", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413152", "413152046", "story_v_out_413152.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413152", "413152046", "story_v_out_413152.awb")
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
	Play413152047 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413152047
		arg_205_1.duration_ = 2.7

		local var_205_0 = {
			zh = 2.7,
			ja = 1.933
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
				arg_205_0:Play413152048(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.3

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_1")

				arg_205_1.callingController_:SetSelectedState("calling")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:GetWordFromCfg(413152047)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 12 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 12)

				if (12 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 12)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152047", "story_v_out_413152.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152047", "story_v_out_413152.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_413152", "413152047", "story_v_out_413152.awb")

						arg_205_1:RecordAudio("413152047", var_208_6)
						arg_205_1:RecordAudio("413152047", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_413152", "413152047", "story_v_out_413152.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_413152", "413152047", "story_v_out_413152.awb")
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
	Play413152048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413152048
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play413152049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10093 = arg_209_1.actors_["10093"].transform.localPosition
				arg_209_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10093", 6)

				for iter_212_0 = 0, arg_209_1.actors_["10093"].transform.childCount - 1 do
					local var_212_0 = arg_209_1.actors_["10093"].transform:GetChild(iter_212_0)

					if var_212_0.name == "" or not string.find(var_212_0.name, "split") then
						var_212_0.gameObject:SetActive(true)
					else
						var_212_0.gameObject:SetActive(false)
					end
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_209_1.time_ - 0) / var_212_1)
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["10093"].transform.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_212_2 = 0
			local var_212_3 = 0.975

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_4 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(413152048).content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_6 = 39 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_4) / 39)

				if (39 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_4) / 39)) > 0 and var_212_3 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_7 and arg_209_1.time_ < var_212_2 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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
	Play413152049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413152049
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play413152050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.975

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(413152049).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 39 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 39)

				if (39 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 39)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play413152050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413152050
		arg_217_1.duration_ = 7.7

		local var_217_0 = {
			zh = 7.7,
			ja = 6.516666666666
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
				arg_217_0:Play413152051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if arg_217_1.bgs_.SS1310 == nil then
				local var_220_0 = Object.Instantiate(arg_217_1.paintGo_)

				var_220_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1310")
				var_220_0.name = "SS1310"
				var_220_0.transform.parent = arg_217_1.stage_.transform
				var_220_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.bgs_.SS1310 = var_220_0
			end

			if 1.96666666666667 < arg_217_1.time_ and arg_217_1.time_ <= 1.96666666666667 + arg_220_0 then
				local var_220_1 = arg_217_1.bgs_.SS1310

				arg_217_1.bgs_.SS1310.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_220_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_220_2 = var_220_1:GetComponent("SpriteRenderer")

				if var_220_2 and var_220_2.sprite then
					local var_220_3 = 2 * (var_220_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_220_1.transform.localScale = Vector3.New(var_220_3 / var_220_2.sprite.bounds.size.y < var_220_3 * manager.ui.mainCameraCom_.aspect / var_220_2.sprite.bounds.size.x and var_220_3 * manager.ui.mainCameraCom_.aspect / var_220_2.sprite.bounds.size.x or var_220_3 / var_220_2.sprite.bounds.size.y, var_220_3 / var_220_2.sprite.bounds.size.y < var_220_3 * manager.ui.mainCameraCom_.aspect / var_220_2.sprite.bounds.size.x and var_220_3 * manager.ui.mainCameraCom_.aspect / var_220_2.sprite.bounds.size.x or var_220_3 / var_220_2.sprite.bounds.size.y, 0)
				end

				for iter_220_0, iter_220_1 in pairs(arg_217_1.bgs_) do
					if iter_220_0 ~= "SS1310" then
						iter_220_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_220_4 = 4

			if 4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			if arg_217_1.time_ >= var_220_4 + 0.3 and arg_217_1.time_ < var_220_4 + 0.3 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			local var_220_5 = 0

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_6 = 2

			if var_220_5 <= arg_217_1.time_ and arg_217_1.time_ < var_220_5 + var_220_6 then
				local var_220_7 = Color.New(0, 0, 0)

				var_220_7.a = Mathf.Lerp(0, 1, (arg_217_1.time_ - var_220_5) / var_220_6)
				arg_217_1.mask_.color = var_220_7
			end

			if arg_217_1.time_ >= var_220_5 + var_220_6 and arg_217_1.time_ < var_220_5 + var_220_6 + arg_220_0 then
				local var_220_8 = Color.New(0, 0, 0)

				var_220_8.a = 1
				arg_217_1.mask_.color = var_220_8
			end

			local var_220_9 = 2

			if 2 < arg_217_1.time_ and arg_217_1.time_ <= var_220_9 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_10 = 2

			if var_220_9 <= arg_217_1.time_ and arg_217_1.time_ < var_220_9 + var_220_10 then
				local var_220_11 = Color.New(0, 0, 0)

				var_220_11.a = Mathf.Lerp(1, 0, (arg_217_1.time_ - var_220_9) / var_220_10)
				arg_217_1.mask_.color = var_220_11
			end

			if arg_217_1.time_ >= var_220_9 + var_220_10 and arg_217_1.time_ < var_220_9 + var_220_10 + arg_220_0 then
				local var_220_12 = Color.New(0, 0, 0)

				arg_217_1.mask_.enabled = false
				var_220_12.a = 0
				arg_217_1.mask_.color = var_220_12
			end

			local var_220_13 = arg_217_1.bgs_.SS1310.transform

			if 2 < arg_217_1.time_ and arg_217_1.time_ <= 2 + arg_220_0 then
				arg_217_1.var_.moveOldPosSS1310 = var_220_13.localPosition
			end

			local var_220_14 = 0.001

			if 2 <= arg_217_1.time_ and arg_217_1.time_ < 2 + var_220_14 then
				var_220_13.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPosSS1310, Vector3.New(0, 1, 9.5), (arg_217_1.time_ - 2) / var_220_14)
			end

			if arg_217_1.time_ >= 2 + var_220_14 and arg_217_1.time_ < 2 + var_220_14 + arg_220_0 then
				var_220_13.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_220_15 = arg_217_1.bgs_.SS1310.transform

			if 2.01666666666667 < arg_217_1.time_ and arg_217_1.time_ <= 2.01666666666667 + arg_220_0 then
				arg_217_1.var_.moveOldPosSS1310 = var_220_15.localPosition
			end

			local var_220_16 = 4.5

			if 2.01666666666667 <= arg_217_1.time_ and arg_217_1.time_ < 2.01666666666667 + var_220_16 then
				var_220_15.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPosSS1310, Vector3.New(0, 1, 10), (arg_217_1.time_ - 2.01666666666667) / var_220_16)
			end

			if arg_217_1.time_ >= 2.01666666666667 + var_220_16 and arg_217_1.time_ < 2.01666666666667 + var_220_16 + arg_220_0 then
				var_220_15.localPosition = Vector3.New(0, 1, 10)
			end

			local var_220_17 = 4

			if 4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_17 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			if arg_217_1.time_ >= var_220_17 + 2.51666666666667 and arg_217_1.time_ < var_220_17 + 2.51666666666667 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			if arg_217_1.frameCnt_ <= 1 then
				arg_217_1.dialog_:SetActive(false)
			end

			local var_220_18 = 4
			local var_220_19 = 0.35

			if 4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_18 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				arg_217_1.dialog_:SetActive(true)

				arg_217_1.dialogCg_.alpha = 0

				local var_220_20 = LeanTween.value(arg_217_1.dialog_, 0, 1, 0.3)

				var_220_20:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_217_1.dialogCg_.alpha = arg_221_0
				end))
				var_220_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_217_1.dialog_)
					var_220_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_217_1.duration_ = arg_217_1.duration_ + 0.3

				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_21 = arg_217_1:GetWordFromCfg(413152050)
				local var_220_22 = arg_217_1:FormatText(var_220_21.content)

				arg_217_1.text_.text = var_220_22

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_24 = 14 <= 0 and var_220_19 or var_220_19 * (utf8.len(var_220_22) / 14)

				if (14 <= 0 and var_220_19 or var_220_19 * (utf8.len(var_220_22) / 14)) > 0 and var_220_19 < var_220_24 then
					arg_217_1.talkMaxDuration = var_220_24
					var_220_18 = var_220_18 + 0.3

					if var_220_24 + var_220_18 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_24 + var_220_18
					end
				end

				arg_217_1.text_.text = var_220_22
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152050", "story_v_out_413152.awb") ~= 0 then
					local var_220_25 = manager.audio:GetVoiceLength("story_v_out_413152", "413152050", "story_v_out_413152.awb") / 1000

					if var_220_25 + var_220_18 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_25 + var_220_18
					end

					if var_220_21.prefab_name ~= "" and arg_217_1.actors_[var_220_21.prefab_name] ~= nil then
						local var_220_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_21.prefab_name].transform, "story_v_out_413152", "413152050", "story_v_out_413152.awb")

						arg_217_1:RecordAudio("413152050", var_220_26)
						arg_217_1:RecordAudio("413152050", var_220_26)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413152", "413152050", "story_v_out_413152.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413152", "413152050", "story_v_out_413152.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_27 = var_220_18 + 0.3
			local var_220_28 = math.max(var_220_19, arg_217_1.talkMaxDuration)

			if var_220_18 + 0.3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_27 + var_220_28 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_27) / var_220_28

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_27 + var_220_28 and arg_217_1.time_ < var_220_27 + var_220_28 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1310",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1310",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play413152051 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 413152051
		arg_223_1.duration_ = 3.47

		local var_223_0 = {
			zh = 3.466,
			ja = 3.3
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
				arg_223_0:Play413152052(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.425

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:GetWordFromCfg(413152051)
				local var_226_2 = arg_223_1:FormatText(var_226_1.content)

				arg_223_1.text_.text = var_226_2

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 17 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 17)

				if (17 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 17)) > 0 and var_226_0 < var_226_4 then
					arg_223_1.talkMaxDuration = var_226_4

					if var_226_4 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_4 + 0
					end
				end

				arg_223_1.text_.text = var_226_2
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152051", "story_v_out_413152.awb") ~= 0 then
					local var_226_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152051", "story_v_out_413152.awb") / 1000

					if var_226_5 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + 0
					end

					if var_226_1.prefab_name ~= "" and arg_223_1.actors_[var_226_1.prefab_name] ~= nil then
						local var_226_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_1.prefab_name].transform, "story_v_out_413152", "413152051", "story_v_out_413152.awb")

						arg_223_1:RecordAudio("413152051", var_226_6)
						arg_223_1:RecordAudio("413152051", var_226_6)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_413152", "413152051", "story_v_out_413152.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_413152", "413152051", "story_v_out_413152.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play413152052 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 413152052
		arg_227_1.duration_ = 8

		local var_227_0 = {
			zh = 4.2,
			ja = 8
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
				arg_227_0:Play413152053(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.525

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(413152052)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 21 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 21)

				if (21 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 21)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152052", "story_v_out_413152.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152052", "story_v_out_413152.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_413152", "413152052", "story_v_out_413152.awb")

						arg_227_1:RecordAudio("413152052", var_230_6)
						arg_227_1:RecordAudio("413152052", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_413152", "413152052", "story_v_out_413152.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_413152", "413152052", "story_v_out_413152.awb")
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
	Play413152053 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 413152053
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play413152054(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 1.3

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_1 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(413152053).content)

				arg_231_1.text_.text = var_234_1

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_3 = 52 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 52)

				if (52 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 52)) > 0 and var_234_0 < var_234_3 then
					arg_231_1.talkMaxDuration = var_234_3

					if var_234_3 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_3 + 0
					end
				end

				arg_231_1.text_.text = var_234_1
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_4 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_4

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play413152054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 413152054
		arg_235_1.duration_ = 3.97

		local var_235_0 = {
			zh = 3.666,
			ja = 3.966
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play413152055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_238_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_235_1.bgmTxt_.text ~= var_238_2 and arg_235_1.bgmTxt_.text ~= "" then
						if arg_235_1.bgmTxt2_.text ~= "" then
							arg_235_1.bgmTxt_.text = arg_235_1.bgmTxt2_.text
						end

						arg_235_1.bgmTxt2_.text = var_238_2

						arg_235_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_235_1.bgmTxt_.text = var_238_2
						arg_235_1.bgmTxt2_.text = var_238_2
					end

					if arg_235_1.bgmTimer then
						arg_235_1.bgmTimer:Stop()

						arg_235_1.bgmTimer = nil
					end

					if arg_235_1.settingData.show_music_name == 1 then
						arg_235_1.musicController:SetSelectedState("show")
						arg_235_1.musicAnimator_:Play("open", 0, 0)

						if arg_235_1.settingData.music_time ~= 0 then
							arg_235_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_235_1.settingData.music_time), function()
								if arg_235_1 == nil or isNil(arg_235_1.bgmTxt_) then
									return
								end

								arg_235_1.musicController:SetSelectedState("hide")
								arg_235_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_238_3 = 0
			local var_238_4 = 0.325

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_3 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_5 = arg_235_1:GetWordFromCfg(413152054)
				local var_238_6 = arg_235_1:FormatText(var_238_5.content)

				arg_235_1.text_.text = var_238_6

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_8 = 13 <= 0 and var_238_4 or var_238_4 * (utf8.len(var_238_6) / 13)

				if (13 <= 0 and var_238_4 or var_238_4 * (utf8.len(var_238_6) / 13)) > 0 and var_238_4 < var_238_8 then
					arg_235_1.talkMaxDuration = var_238_8

					if var_238_8 + var_238_3 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_3
					end
				end

				arg_235_1.text_.text = var_238_6
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152054", "story_v_out_413152.awb") ~= 0 then
					local var_238_9 = manager.audio:GetVoiceLength("story_v_out_413152", "413152054", "story_v_out_413152.awb") / 1000

					if var_238_9 + var_238_3 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_3
					end

					if var_238_5.prefab_name ~= "" and arg_235_1.actors_[var_238_5.prefab_name] ~= nil then
						local var_238_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_5.prefab_name].transform, "story_v_out_413152", "413152054", "story_v_out_413152.awb")

						arg_235_1:RecordAudio("413152054", var_238_10)
						arg_235_1:RecordAudio("413152054", var_238_10)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_413152", "413152054", "story_v_out_413152.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_413152", "413152054", "story_v_out_413152.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_11 = math.max(var_238_4, arg_235_1.talkMaxDuration)

			if var_238_3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_3 + var_238_11 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_3) / var_238_11

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_3 + var_238_11 and arg_235_1.time_ < var_238_3 + var_238_11 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play413152055 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 413152055
		arg_240_1.duration_ = 6.87

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play413152056(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPosSS1310 = arg_240_1.bgs_.SS1310.transform.localPosition
			end

			local var_243_0 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 then
				arg_240_1.bgs_.SS1310.transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPosSS1310, Vector3.New(0, 1, 10), (arg_240_1.time_ - 0) / var_243_0)
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 then
				arg_240_1.bgs_.SS1310.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_243_1 = arg_240_1.bgs_.SS1310.transform

			if 0.034 < arg_240_1.time_ and arg_240_1.time_ <= 0.034 + arg_243_0 then
				arg_240_1.var_.moveOldPosSS1310 = var_243_1.localPosition
			end

			local var_243_2 = 3.566

			if 0.034 <= arg_240_1.time_ and arg_240_1.time_ < 0.034 + var_243_2 then
				var_243_1.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPosSS1310, Vector3.New(0, 1, 9), (arg_240_1.time_ - 0.034) / var_243_2)
			end

			if arg_240_1.time_ >= 0.034 + var_243_2 and arg_240_1.time_ < 0.034 + var_243_2 + arg_243_0 then
				var_243_1.localPosition = Vector3.New(0, 1, 9)
			end

			local var_243_3 = 0

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_3 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_4 = 1

			if var_243_3 <= arg_240_1.time_ and arg_240_1.time_ < var_243_3 + var_243_4 then
				local var_243_5 = Color.New(1, 1, 1)

				var_243_5.a = Mathf.Lerp(1, 0, (arg_240_1.time_ - var_243_3) / var_243_4)
				arg_240_1.mask_.color = var_243_5
			end

			if arg_240_1.time_ >= var_243_3 + var_243_4 and arg_240_1.time_ < var_243_3 + var_243_4 + arg_243_0 then
				local var_243_6 = Color.New(1, 1, 1)

				arg_240_1.mask_.enabled = false
				var_243_6.a = 0
				arg_240_1.mask_.color = var_243_6
			end

			local var_243_7 = 1

			if 1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_7 + arg_243_0 then
				arg_240_1.allBtn_.enabled = false
			end

			if arg_240_1.time_ >= var_243_7 + 2.6 and arg_240_1.time_ < var_243_7 + 2.6 + arg_243_0 then
				arg_240_1.allBtn_.enabled = true
			end

			if 0.266666666666667 < arg_240_1.time_ and arg_240_1.time_ <= 0.266666666666667 + arg_243_0 then
				arg_240_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_swordlight", "")
			end

			if 0.8 < arg_240_1.time_ and arg_240_1.time_ <= 0.8 + arg_243_0 then
				arg_240_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_crake", "")
			end

			if 0.866666666666667 < arg_240_1.time_ and arg_240_1.time_ <= 0.866666666666667 + arg_243_0 then
				arg_240_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_statue", "")
			end

			if arg_240_1.frameCnt_ <= 1 then
				arg_240_1.dialog_:SetActive(false)
			end

			local var_243_11 = 1.86666666666667
			local var_243_12 = 1.375

			if 1.86666666666667 < arg_240_1.time_ and arg_240_1.time_ <= var_243_11 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0

				arg_240_1.dialog_:SetActive(true)

				arg_240_1.dialogCg_.alpha = 0

				local var_243_13 = LeanTween.value(arg_240_1.dialog_, 0, 1, 0.3)

				var_243_13:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_240_1.dialogCg_.alpha = arg_244_0
				end))
				var_243_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_240_1.dialog_)
					var_243_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_240_1.duration_ = arg_240_1.duration_ + 0.3

				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_14 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(413152055).content)

				arg_240_1.text_.text = var_243_14

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_16 = 55 <= 0 and var_243_12 or var_243_12 * (utf8.len(var_243_14) / 55)

				if (55 <= 0 and var_243_12 or var_243_12 * (utf8.len(var_243_14) / 55)) > 0 and var_243_12 < var_243_16 then
					arg_240_1.talkMaxDuration = var_243_16
					var_243_11 = var_243_11 + 0.3

					if var_243_16 + var_243_11 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_16 + var_243_11
					end
				end

				arg_240_1.text_.text = var_243_14
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_17 = var_243_11 + 0.3
			local var_243_18 = math.max(var_243_12, arg_240_1.talkMaxDuration)

			if var_243_11 + 0.3 <= arg_240_1.time_ and arg_240_1.time_ < var_243_17 + var_243_18 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_17) / var_243_18

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_17 + var_243_18 and arg_240_1.time_ < var_243_17 + var_243_18 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1310",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1310",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.566,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play413152056 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 413152056
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play413152057(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.975

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(413152056).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 39 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 39)

				if (39 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 39)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play413152057 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 413152057
		arg_250_1.duration_ = 11

		local var_250_0 = {
			zh = 7.866,
			ja = 11
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play413152058(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 2 < arg_250_1.time_ and arg_250_1.time_ <= 2 + arg_253_0 then
				local var_253_0 = arg_250_1.bgs_.F10g

				arg_250_1.bgs_.F10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_253_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_253_1 = var_253_0:GetComponent("SpriteRenderer")

				if var_253_1 and var_253_1.sprite then
					local var_253_2 = 2 * (var_253_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_253_0.transform.localScale = Vector3.New(var_253_2 / var_253_1.sprite.bounds.size.y < var_253_2 * manager.ui.mainCameraCom_.aspect / var_253_1.sprite.bounds.size.x and var_253_2 * manager.ui.mainCameraCom_.aspect / var_253_1.sprite.bounds.size.x or var_253_2 / var_253_1.sprite.bounds.size.y, var_253_2 / var_253_1.sprite.bounds.size.y < var_253_2 * manager.ui.mainCameraCom_.aspect / var_253_1.sprite.bounds.size.x and var_253_2 * manager.ui.mainCameraCom_.aspect / var_253_1.sprite.bounds.size.x or var_253_2 / var_253_1.sprite.bounds.size.y, 0)
				end

				for iter_253_0, iter_253_1 in pairs(arg_250_1.bgs_) do
					if iter_253_0 ~= "F10g" then
						iter_253_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_253_3 = 0

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_3 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_4 = 2

			if var_253_3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_3 + var_253_4 then
				local var_253_5 = Color.New(0, 0, 0)

				var_253_5.a = Mathf.Lerp(0, 1, (arg_250_1.time_ - var_253_3) / var_253_4)
				arg_250_1.mask_.color = var_253_5
			end

			if arg_250_1.time_ >= var_253_3 + var_253_4 and arg_250_1.time_ < var_253_3 + var_253_4 + arg_253_0 then
				local var_253_6 = Color.New(0, 0, 0)

				var_253_6.a = 1
				arg_250_1.mask_.color = var_253_6
			end

			local var_253_7 = 2

			if 2 < arg_250_1.time_ and arg_250_1.time_ <= var_253_7 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_8 = 2

			if var_253_7 <= arg_250_1.time_ and arg_250_1.time_ < var_253_7 + var_253_8 then
				local var_253_9 = Color.New(0, 0, 0)

				var_253_9.a = Mathf.Lerp(1, 0, (arg_250_1.time_ - var_253_7) / var_253_8)
				arg_250_1.mask_.color = var_253_9
			end

			if arg_250_1.time_ >= var_253_7 + var_253_8 and arg_250_1.time_ < var_253_7 + var_253_8 + arg_253_0 then
				local var_253_10 = Color.New(0, 0, 0)

				arg_250_1.mask_.enabled = false
				var_253_10.a = 0
				arg_250_1.mask_.color = var_253_10
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_253_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_250_1.bgmTxt_.text ~= var_253_13 and arg_250_1.bgmTxt_.text ~= "" then
						if arg_250_1.bgmTxt2_.text ~= "" then
							arg_250_1.bgmTxt_.text = arg_250_1.bgmTxt2_.text
						end

						arg_250_1.bgmTxt2_.text = var_253_13

						arg_250_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_250_1.bgmTxt_.text = var_253_13
						arg_250_1.bgmTxt2_.text = var_253_13
					end

					if arg_250_1.bgmTimer then
						arg_250_1.bgmTimer:Stop()

						arg_250_1.bgmTimer = nil
					end

					if arg_250_1.settingData.show_music_name == 1 then
						arg_250_1.musicController:SetSelectedState("show")
						arg_250_1.musicAnimator_:Play("open", 0, 0)

						if arg_250_1.settingData.music_time ~= 0 then
							arg_250_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_250_1.settingData.music_time), function()
								if arg_250_1 == nil or isNil(arg_250_1.bgmTxt_) then
									return
								end

								arg_250_1.musicController:SetSelectedState("hide")
								arg_250_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.26666666666667 < arg_250_1.time_ and arg_250_1.time_ <= 1.26666666666667 + arg_253_0 then
				arg_250_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_253_16 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_250_1.bgmTxt_.text ~= var_253_16 and arg_250_1.bgmTxt_.text ~= "" then
						if arg_250_1.bgmTxt2_.text ~= "" then
							arg_250_1.bgmTxt_.text = arg_250_1.bgmTxt2_.text
						end

						arg_250_1.bgmTxt2_.text = var_253_16

						arg_250_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_250_1.bgmTxt_.text = var_253_16
						arg_250_1.bgmTxt2_.text = var_253_16
					end

					if arg_250_1.bgmTimer then
						arg_250_1.bgmTimer:Stop()

						arg_250_1.bgmTimer = nil
					end

					if arg_250_1.settingData.show_music_name == 1 then
						arg_250_1.musicController:SetSelectedState("show")
						arg_250_1.musicAnimator_:Play("open", 0, 0)

						if arg_250_1.settingData.music_time ~= 0 then
							arg_250_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_250_1.settingData.music_time), function()
								if arg_250_1 == nil or isNil(arg_250_1.bgmTxt_) then
									return
								end

								arg_250_1.musicController:SetSelectedState("hide")
								arg_250_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_250_1.frameCnt_ <= 1 then
				arg_250_1.dialog_:SetActive(false)
			end

			local var_253_17 = 4
			local var_253_18 = 0.525

			if 4 < arg_250_1.time_ and arg_250_1.time_ <= var_253_17 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0

				arg_250_1.dialog_:SetActive(true)

				arg_250_1.dialogCg_.alpha = 0

				local var_253_19 = LeanTween.value(arg_250_1.dialog_, 0, 1, 0.3)

				var_253_19:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_250_1.dialogCg_.alpha = arg_256_0
				end))
				var_253_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_250_1.dialog_)
					var_253_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_250_1.duration_ = arg_250_1.duration_ + 0.3

				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_20 = arg_250_1:GetWordFromCfg(413152057)
				local var_253_21 = arg_250_1:FormatText(var_253_20.content)

				arg_250_1.text_.text = var_253_21

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_23 = 19 <= 0 and var_253_18 or var_253_18 * (utf8.len(var_253_21) / 19)

				if (19 <= 0 and var_253_18 or var_253_18 * (utf8.len(var_253_21) / 19)) > 0 and var_253_18 < var_253_23 then
					arg_250_1.talkMaxDuration = var_253_23
					var_253_17 = var_253_17 + 0.3

					if var_253_23 + var_253_17 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_23 + var_253_17
					end
				end

				arg_250_1.text_.text = var_253_21
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152057", "story_v_out_413152.awb") ~= 0 then
					local var_253_24 = manager.audio:GetVoiceLength("story_v_out_413152", "413152057", "story_v_out_413152.awb") / 1000

					if var_253_24 + var_253_17 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_24 + var_253_17
					end

					if var_253_20.prefab_name ~= "" and arg_250_1.actors_[var_253_20.prefab_name] ~= nil then
						local var_253_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_20.prefab_name].transform, "story_v_out_413152", "413152057", "story_v_out_413152.awb")

						arg_250_1:RecordAudio("413152057", var_253_25)
						arg_250_1:RecordAudio("413152057", var_253_25)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_413152", "413152057", "story_v_out_413152.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_413152", "413152057", "story_v_out_413152.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_26 = var_253_17 + 0.3
			local var_253_27 = math.max(var_253_18, arg_250_1.talkMaxDuration)

			if var_253_17 + 0.3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_26 + var_253_27 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_26) / var_253_27

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_26 + var_253_27 and arg_250_1.time_ < var_253_26 + var_253_27 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play413152058 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 413152058
		arg_258_1.duration_ = 4.47

		local var_258_0 = {
			zh = 3.766,
			ja = 4.466
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play413152059(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.375

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_1 = arg_258_1:GetWordFromCfg(413152058)
				local var_261_2 = arg_258_1:FormatText(var_261_1.content)

				arg_258_1.text_.text = var_261_2

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 15 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 15)

				if (15 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 15)) > 0 and var_261_0 < var_261_4 then
					arg_258_1.talkMaxDuration = var_261_4

					if var_261_4 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_4 + 0
					end
				end

				arg_258_1.text_.text = var_261_2
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152058", "story_v_out_413152.awb") ~= 0 then
					local var_261_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152058", "story_v_out_413152.awb") / 1000

					if var_261_5 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + 0
					end

					if var_261_1.prefab_name ~= "" and arg_258_1.actors_[var_261_1.prefab_name] ~= nil then
						local var_261_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_1.prefab_name].transform, "story_v_out_413152", "413152058", "story_v_out_413152.awb")

						arg_258_1:RecordAudio("413152058", var_261_6)
						arg_258_1:RecordAudio("413152058", var_261_6)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_413152", "413152058", "story_v_out_413152.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_413152", "413152058", "story_v_out_413152.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play413152059 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 413152059
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play413152060(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.65

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(413152059).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 26 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 26)

				if (26 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 26)) > 0 and var_265_0 < var_265_3 then
					arg_262_1.talkMaxDuration = var_265_3

					if var_265_3 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_3 + 0
					end
				end

				arg_262_1.text_.text = var_265_1
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_4 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_4

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play413152060 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 413152060
		arg_266_1.duration_ = 12.93

		local var_266_0 = {
			zh = 11.266,
			ja = 12.933
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play413152061(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.775

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_4")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_1 = arg_266_1:GetWordFromCfg(413152060)
				local var_269_2 = arg_266_1:FormatText(var_269_1.content)

				arg_266_1.text_.text = var_269_2

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 31 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 31)

				if (31 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 31)) > 0 and var_269_0 < var_269_4 then
					arg_266_1.talkMaxDuration = var_269_4

					if var_269_4 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_4 + 0
					end
				end

				arg_266_1.text_.text = var_269_2
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152060", "story_v_out_413152.awb") ~= 0 then
					local var_269_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152060", "story_v_out_413152.awb") / 1000

					if var_269_5 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + 0
					end

					if var_269_1.prefab_name ~= "" and arg_266_1.actors_[var_269_1.prefab_name] ~= nil then
						local var_269_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_1.prefab_name].transform, "story_v_out_413152", "413152060", "story_v_out_413152.awb")

						arg_266_1:RecordAudio("413152060", var_269_6)
						arg_266_1:RecordAudio("413152060", var_269_6)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_413152", "413152060", "story_v_out_413152.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_413152", "413152060", "story_v_out_413152.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play413152061 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 413152061
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play413152062(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.8

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(413152061).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 32 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 32)

				if (32 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 32)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play413152062 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 413152062
		arg_274_1.duration_ = 8.87

		local var_274_0 = {
			zh = 5.166,
			ja = 8.866
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play413152063(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.5

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_8")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_1 = arg_274_1:GetWordFromCfg(413152062)
				local var_277_2 = arg_274_1:FormatText(var_277_1.content)

				arg_274_1.text_.text = var_277_2

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 20 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 20)

				if (20 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 20)) > 0 and var_277_0 < var_277_4 then
					arg_274_1.talkMaxDuration = var_277_4

					if var_277_4 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_4 + 0
					end
				end

				arg_274_1.text_.text = var_277_2
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152062", "story_v_out_413152.awb") ~= 0 then
					local var_277_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152062", "story_v_out_413152.awb") / 1000

					if var_277_5 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + 0
					end

					if var_277_1.prefab_name ~= "" and arg_274_1.actors_[var_277_1.prefab_name] ~= nil then
						local var_277_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_1.prefab_name].transform, "story_v_out_413152", "413152062", "story_v_out_413152.awb")

						arg_274_1:RecordAudio("413152062", var_277_6)
						arg_274_1:RecordAudio("413152062", var_277_6)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_413152", "413152062", "story_v_out_413152.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_413152", "413152062", "story_v_out_413152.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_7 and arg_274_1.time_ < 0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play413152063 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 413152063
		arg_278_1.duration_ = 4.53

		local var_278_0 = {
			zh = 4.533,
			ja = 3.833
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play413152064(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.35

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_1 = arg_278_1:GetWordFromCfg(413152063)
				local var_281_2 = arg_278_1:FormatText(var_281_1.content)

				arg_278_1.text_.text = var_281_2

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 14 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 14)

				if (14 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 14)) > 0 and var_281_0 < var_281_4 then
					arg_278_1.talkMaxDuration = var_281_4

					if var_281_4 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_4 + 0
					end
				end

				arg_278_1.text_.text = var_281_2
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152063", "story_v_out_413152.awb") ~= 0 then
					local var_281_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152063", "story_v_out_413152.awb") / 1000

					if var_281_5 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + 0
					end

					if var_281_1.prefab_name ~= "" and arg_278_1.actors_[var_281_1.prefab_name] ~= nil then
						local var_281_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_1.prefab_name].transform, "story_v_out_413152", "413152063", "story_v_out_413152.awb")

						arg_278_1:RecordAudio("413152063", var_281_6)
						arg_278_1:RecordAudio("413152063", var_281_6)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_413152", "413152063", "story_v_out_413152.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_413152", "413152063", "story_v_out_413152.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play413152064 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 413152064
		arg_282_1.duration_ = 2.57

		local var_282_0 = {
			zh = 1.233,
			ja = 2.566
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play413152065(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.125

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_1 = arg_282_1:GetWordFromCfg(413152064)
				local var_285_2 = arg_282_1:FormatText(var_285_1.content)

				arg_282_1.text_.text = var_285_2

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 5 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 5)

				if (5 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 5)) > 0 and var_285_0 < var_285_4 then
					arg_282_1.talkMaxDuration = var_285_4

					if var_285_4 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_4 + 0
					end
				end

				arg_282_1.text_.text = var_285_2
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152064", "story_v_out_413152.awb") ~= 0 then
					local var_285_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152064", "story_v_out_413152.awb") / 1000

					if var_285_5 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + 0
					end

					if var_285_1.prefab_name ~= "" and arg_282_1.actors_[var_285_1.prefab_name] ~= nil then
						local var_285_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_1.prefab_name].transform, "story_v_out_413152", "413152064", "story_v_out_413152.awb")

						arg_282_1:RecordAudio("413152064", var_285_6)
						arg_282_1:RecordAudio("413152064", var_285_6)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_413152", "413152064", "story_v_out_413152.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_413152", "413152064", "story_v_out_413152.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_7 and arg_282_1.time_ < 0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play413152065 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 413152065
		arg_286_1.duration_ = 3.77

		local var_286_0 = {
			zh = 3.2,
			ja = 3.766
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play413152066(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.225

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_1 = arg_286_1:GetWordFromCfg(413152065)
				local var_289_2 = arg_286_1:FormatText(var_289_1.content)

				arg_286_1.text_.text = var_289_2

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 9 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 9)

				if (9 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 9)) > 0 and var_289_0 < var_289_4 then
					arg_286_1.talkMaxDuration = var_289_4

					if var_289_4 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_4 + 0
					end
				end

				arg_286_1.text_.text = var_289_2
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152065", "story_v_out_413152.awb") ~= 0 then
					local var_289_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152065", "story_v_out_413152.awb") / 1000

					if var_289_5 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + 0
					end

					if var_289_1.prefab_name ~= "" and arg_286_1.actors_[var_289_1.prefab_name] ~= nil then
						local var_289_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_1.prefab_name].transform, "story_v_out_413152", "413152065", "story_v_out_413152.awb")

						arg_286_1:RecordAudio("413152065", var_289_6)
						arg_286_1:RecordAudio("413152065", var_289_6)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_413152", "413152065", "story_v_out_413152.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_413152", "413152065", "story_v_out_413152.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play413152066 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 413152066
		arg_290_1.duration_ = 6.3

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play413152067(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_0 = 0.366666666666667

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 then
				local var_293_1 = Color.New(1, 0, 0)

				var_293_1.a = Mathf.Lerp(0, 1, (arg_290_1.time_ - 0) / var_293_0)
				arg_290_1.mask_.color = var_293_1
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 then
				local var_293_2 = Color.New(1, 0, 0)

				var_293_2.a = 1
				arg_290_1.mask_.color = var_293_2
			end

			local var_293_3 = 0.366666666666667

			if 0.366666666666667 < arg_290_1.time_ and arg_290_1.time_ <= var_293_3 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_4 = 0.633333333333333

			if var_293_3 <= arg_290_1.time_ and arg_290_1.time_ < var_293_3 + var_293_4 then
				local var_293_5 = Color.New(1, 0, 0)

				var_293_5.a = Mathf.Lerp(1, 0, (arg_290_1.time_ - var_293_3) / var_293_4)
				arg_290_1.mask_.color = var_293_5
			end

			if arg_290_1.time_ >= var_293_3 + var_293_4 and arg_290_1.time_ < var_293_3 + var_293_4 + arg_293_0 then
				local var_293_6 = Color.New(1, 0, 0)

				arg_290_1.mask_.enabled = false
				var_293_6.a = 0
				arg_290_1.mask_.color = var_293_6
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_7 = 1.3
			local var_293_8 = 1.075

			if 1.3 < arg_290_1.time_ and arg_290_1.time_ <= var_293_7 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_9 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_9:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_290_1.dialogCg_.alpha = arg_294_0
				end))
				var_293_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_10 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(413152066).content)

				arg_290_1.text_.text = var_293_10

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_12 = 43 <= 0 and var_293_8 or var_293_8 * (utf8.len(var_293_10) / 43)

				if (43 <= 0 and var_293_8 or var_293_8 * (utf8.len(var_293_10) / 43)) > 0 and var_293_8 < var_293_12 then
					arg_290_1.talkMaxDuration = var_293_12
					var_293_7 = var_293_7 + 0.3

					if var_293_12 + var_293_7 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_12 + var_293_7
					end
				end

				arg_290_1.text_.text = var_293_10
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_13 = var_293_7 + 0.3
			local var_293_14 = math.max(var_293_8, arg_290_1.talkMaxDuration)

			if var_293_7 + 0.3 <= arg_290_1.time_ and arg_290_1.time_ < var_293_13 + var_293_14 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_13) / var_293_14

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_13 + var_293_14 and arg_290_1.time_ < var_293_13 + var_293_14 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play413152067 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 413152067
		arg_296_1.duration_ = 4.6

		local var_296_0 = {
			zh = 2.933,
			ja = 4.6
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
				arg_296_0:Play413152068(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0.275

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_3")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_1 = arg_296_1:GetWordFromCfg(413152067)
				local var_299_2 = arg_296_1:FormatText(var_299_1.content)

				arg_296_1.text_.text = var_299_2

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_4 = 11 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 11)

				if (11 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 11)) > 0 and var_299_0 < var_299_4 then
					arg_296_1.talkMaxDuration = var_299_4

					if var_299_4 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_4 + 0
					end
				end

				arg_296_1.text_.text = var_299_2
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152067", "story_v_out_413152.awb") ~= 0 then
					local var_299_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152067", "story_v_out_413152.awb") / 1000

					if var_299_5 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + 0
					end

					if var_299_1.prefab_name ~= "" and arg_296_1.actors_[var_299_1.prefab_name] ~= nil then
						local var_299_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_1.prefab_name].transform, "story_v_out_413152", "413152067", "story_v_out_413152.awb")

						arg_296_1:RecordAudio("413152067", var_299_6)
						arg_296_1:RecordAudio("413152067", var_299_6)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_413152", "413152067", "story_v_out_413152.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_413152", "413152067", "story_v_out_413152.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_7 = math.max(var_299_0, arg_296_1.talkMaxDuration)

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_7 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - 0) / var_299_7

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= 0 + var_299_7 and arg_296_1.time_ < 0 + var_299_7 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play413152068 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 413152068
		arg_300_1.duration_ = 10.17

		local var_300_0 = {
			zh = 8.133,
			ja = 10.166
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
				arg_300_0:Play413152069(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.8

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_3")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_1 = arg_300_1:GetWordFromCfg(413152068)
				local var_303_2 = arg_300_1:FormatText(var_303_1.content)

				arg_300_1.text_.text = var_303_2

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 32 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 32)

				if (32 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 32)) > 0 and var_303_0 < var_303_4 then
					arg_300_1.talkMaxDuration = var_303_4

					if var_303_4 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_4 + 0
					end
				end

				arg_300_1.text_.text = var_303_2
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152068", "story_v_out_413152.awb") ~= 0 then
					local var_303_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152068", "story_v_out_413152.awb") / 1000

					if var_303_5 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + 0
					end

					if var_303_1.prefab_name ~= "" and arg_300_1.actors_[var_303_1.prefab_name] ~= nil then
						local var_303_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_1.prefab_name].transform, "story_v_out_413152", "413152068", "story_v_out_413152.awb")

						arg_300_1:RecordAudio("413152068", var_303_6)
						arg_300_1:RecordAudio("413152068", var_303_6)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_413152", "413152068", "story_v_out_413152.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_413152", "413152068", "story_v_out_413152.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play413152069 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 413152069
		arg_304_1.duration_ = 4.57

		local var_304_0 = {
			zh = 4.1,
			ja = 4.566
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
				arg_304_0:Play413152070(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0.4

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10094_split_1")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_1 = arg_304_1:GetWordFromCfg(413152069)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 16 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 16)

				if (16 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 16)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152069", "story_v_out_413152.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152069", "story_v_out_413152.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_out_413152", "413152069", "story_v_out_413152.awb")

						arg_304_1:RecordAudio("413152069", var_307_6)
						arg_304_1:RecordAudio("413152069", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_413152", "413152069", "story_v_out_413152.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_413152", "413152069", "story_v_out_413152.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play413152070 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 413152070
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play413152071(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 1.1

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_1 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(413152070).content)

				arg_308_1.text_.text = var_311_1

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_3 = 44 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 44)

				if (44 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 44)) > 0 and var_311_0 < var_311_3 then
					arg_308_1.talkMaxDuration = var_311_3

					if var_311_3 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_3 + 0
					end
				end

				arg_308_1.text_.text = var_311_1
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_4 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_4

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play413152071 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 413152071
		arg_312_1.duration_ = 5.5

		local var_312_0 = {
			zh = 3.2,
			ja = 5.5
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
				arg_312_0:Play413152072(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10094 = arg_312_1.actors_["10094"].transform.localPosition
				arg_312_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("10094", 3)

				for iter_315_0 = 0, arg_312_1.actors_["10094"].transform.childCount - 1 do
					local var_315_0 = arg_312_1.actors_["10094"].transform:GetChild(iter_315_0)

					if var_315_0.name == "" or not string.find(var_315_0.name, "split") then
						var_315_0.gameObject:SetActive(true)
					else
						var_315_0.gameObject:SetActive(false)
					end
				end
			end

			local var_315_1 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_1 then
				arg_312_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_312_1.time_ - 0) / var_315_1)
			end

			if arg_312_1.time_ >= 0 + var_315_1 and arg_312_1.time_ < 0 + var_315_1 + arg_315_0 then
				arg_312_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_315_2 = arg_312_1.actors_["10094"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps10094 == nil then
				arg_312_1.var_.actorSpriteComps10094 = var_315_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_3 = 2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_3 and not isNil(var_315_2) then
				if arg_312_1.var_.actorSpriteComps10094 then
					for iter_315_1, iter_315_2 in pairs(arg_312_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_312_1.time_ >= 0 + var_315_3 and arg_312_1.time_ < 0 + var_315_3 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps10094 then
				for iter_315_3, iter_315_4 in pairs(arg_312_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_315_4 then
						iter_315_4.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_312_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				local var_315_5 = arg_312_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_315_5 then
					arg_312_1.var_.alphaOldValue10094 = var_315_5.alpha
					arg_312_1.var_.characterEffect10094 = var_315_5
				end

				arg_312_1.var_.alphaOldValue10094 = 0
			end

			local var_315_6 = 0.5

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_6 then
				if arg_312_1.var_.characterEffect10094 then
					arg_312_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_312_1.var_.alphaOldValue10094, 1, (arg_312_1.time_ - 0) / var_315_6)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_6 and arg_312_1.time_ < 0 + var_315_6 + arg_315_0 and arg_312_1.var_.characterEffect10094 then
				arg_312_1.var_.characterEffect10094.alpha = 1
			end

			local var_315_7 = 0
			local var_315_8 = 0.3

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_7 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_9 = arg_312_1:GetWordFromCfg(413152071)
				local var_315_10 = arg_312_1:FormatText(var_315_9.content)

				arg_312_1.text_.text = var_315_10

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_12 = 12 <= 0 and var_315_8 or var_315_8 * (utf8.len(var_315_10) / 12)

				if (12 <= 0 and var_315_8 or var_315_8 * (utf8.len(var_315_10) / 12)) > 0 and var_315_8 < var_315_12 then
					arg_312_1.talkMaxDuration = var_315_12

					if var_315_12 + var_315_7 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_12 + var_315_7
					end
				end

				arg_312_1.text_.text = var_315_10
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152071", "story_v_out_413152.awb") ~= 0 then
					local var_315_13 = manager.audio:GetVoiceLength("story_v_out_413152", "413152071", "story_v_out_413152.awb") / 1000

					if var_315_13 + var_315_7 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_13 + var_315_7
					end

					if var_315_9.prefab_name ~= "" and arg_312_1.actors_[var_315_9.prefab_name] ~= nil then
						local var_315_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_9.prefab_name].transform, "story_v_out_413152", "413152071", "story_v_out_413152.awb")

						arg_312_1:RecordAudio("413152071", var_315_14)
						arg_312_1:RecordAudio("413152071", var_315_14)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_413152", "413152071", "story_v_out_413152.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_413152", "413152071", "story_v_out_413152.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_15 = math.max(var_315_8, arg_312_1.talkMaxDuration)

			if var_315_7 <= arg_312_1.time_ and arg_312_1.time_ < var_315_7 + var_315_15 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_7) / var_315_15

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_7 + var_315_15 and arg_312_1.time_ < var_315_7 + var_315_15 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
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

		arg_312_1:InitPlayNodeList()
	end,
	Play413152072 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 413152072
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play413152073(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos10094 = arg_316_1.actors_["10094"].transform.localPosition
				arg_316_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10094", 6)

				for iter_319_0 = 0, arg_316_1.actors_["10094"].transform.childCount - 1 do
					local var_319_0 = arg_316_1.actors_["10094"].transform:GetChild(iter_319_0)

					if var_319_0.name == "" or not string.find(var_319_0.name, "split") then
						var_319_0.gameObject:SetActive(true)
					else
						var_319_0.gameObject:SetActive(false)
					end
				end
			end

			local var_319_1 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_1 then
				arg_316_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10094, Vector3.New(1500, -340, -414), (arg_316_1.time_ - 0) / var_319_1)
			end

			if arg_316_1.time_ >= 0 + var_319_1 and arg_316_1.time_ < 0 + var_319_1 + arg_319_0 then
				arg_316_1.actors_["10094"].transform.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_319_2 = 0
			local var_319_3 = 1.05

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_2 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_4 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(413152072).content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_6 = 42 <= 0 and var_319_3 or var_319_3 * (utf8.len(var_319_4) / 42)

				if (42 <= 0 and var_319_3 or var_319_3 * (utf8.len(var_319_4) / 42)) > 0 and var_319_3 < var_319_6 then
					arg_316_1.talkMaxDuration = var_319_6

					if var_319_6 + var_319_2 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_6 + var_319_2
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_3, arg_316_1.talkMaxDuration)

			if var_319_2 <= arg_316_1.time_ and arg_316_1.time_ < var_319_2 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_2) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_2 + var_319_7 and arg_316_1.time_ < var_319_2 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
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

		arg_316_1:InitPlayNodeList()
	end,
	Play413152073 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 413152073
		arg_320_1.duration_ = 5.27

		local var_320_0 = {
			zh = 5.266,
			ja = 4.266
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
				arg_320_0:Play413152074(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.35

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_1 = arg_320_1:GetWordFromCfg(413152073)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 14 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 14)

				if (14 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 14)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152073", "story_v_out_413152.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152073", "story_v_out_413152.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_413152", "413152073", "story_v_out_413152.awb")

						arg_320_1:RecordAudio("413152073", var_323_6)
						arg_320_1:RecordAudio("413152073", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_413152", "413152073", "story_v_out_413152.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_413152", "413152073", "story_v_out_413152.awb")
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
	Play413152074 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 413152074
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play413152075(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0.875

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_1 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(413152074).content)

				arg_324_1.text_.text = var_327_1

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_3 = 35 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 35)

				if (35 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 35)) > 0 and var_327_0 < var_327_3 then
					arg_324_1.talkMaxDuration = var_327_3

					if var_327_3 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_3 + 0
					end
				end

				arg_324_1.text_.text = var_327_1
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_4 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_4

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play413152075 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 413152075
		arg_328_1.duration_ = 3.1

		local var_328_0 = {
			zh = 3.1,
			ja = 3
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
				arg_328_0:Play413152076(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0.125

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_1 = arg_328_1:GetWordFromCfg(413152075)
				local var_331_2 = arg_328_1:FormatText(var_331_1.content)

				arg_328_1.text_.text = var_331_2

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_4 = 5 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 5)

				if (5 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 5)) > 0 and var_331_0 < var_331_4 then
					arg_328_1.talkMaxDuration = var_331_4

					if var_331_4 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_4 + 0
					end
				end

				arg_328_1.text_.text = var_331_2
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152075", "story_v_out_413152.awb") ~= 0 then
					local var_331_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152075", "story_v_out_413152.awb") / 1000

					if var_331_5 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + 0
					end

					if var_331_1.prefab_name ~= "" and arg_328_1.actors_[var_331_1.prefab_name] ~= nil then
						local var_331_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_1.prefab_name].transform, "story_v_out_413152", "413152075", "story_v_out_413152.awb")

						arg_328_1:RecordAudio("413152075", var_331_6)
						arg_328_1:RecordAudio("413152075", var_331_6)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_413152", "413152075", "story_v_out_413152.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_413152", "413152075", "story_v_out_413152.awb")
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
	Play413152076 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 413152076
		arg_332_1.duration_ = 5.23

		local var_332_0 = {
			zh = 3.6,
			ja = 5.233
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
				arg_332_0:Play413152077(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0.2

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_1 = arg_332_1:GetWordFromCfg(413152076)
				local var_335_2 = arg_332_1:FormatText(var_335_1.content)

				arg_332_1.text_.text = var_335_2

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_4 = 8 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 8)

				if (8 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 8)) > 0 and var_335_0 < var_335_4 then
					arg_332_1.talkMaxDuration = var_335_4

					if var_335_4 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_4 + 0
					end
				end

				arg_332_1.text_.text = var_335_2
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152076", "story_v_out_413152.awb") ~= 0 then
					local var_335_5 = manager.audio:GetVoiceLength("story_v_out_413152", "413152076", "story_v_out_413152.awb") / 1000

					if var_335_5 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + 0
					end

					if var_335_1.prefab_name ~= "" and arg_332_1.actors_[var_335_1.prefab_name] ~= nil then
						local var_335_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_1.prefab_name].transform, "story_v_out_413152", "413152076", "story_v_out_413152.awb")

						arg_332_1:RecordAudio("413152076", var_335_6)
						arg_332_1:RecordAudio("413152076", var_335_6)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_413152", "413152076", "story_v_out_413152.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_413152", "413152076", "story_v_out_413152.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_7 = math.max(var_335_0, arg_332_1.talkMaxDuration)

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_7 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - 0) / var_335_7

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= 0 + var_335_7 and arg_332_1.time_ < 0 + var_335_7 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play413152077 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 413152077
		arg_336_1.duration_ = 1.6

		local var_336_0 = {
			zh = 1.26633333333333,
			ja = 1.59933333333333
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
			arg_336_1.auto_ = false
		end

		function arg_336_1.playNext_(arg_338_0)
			arg_336_1.onStoryFinished_()
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.allBtn_.enabled = false
			end

			if arg_336_1.time_ >= 0 + 0.133333333333333 and arg_336_1.time_ < 0 + 0.133333333333333 + arg_339_0 then
				arg_336_1.allBtn_.enabled = true
			end

			local var_339_0 = 0.133333333333333
			local var_339_1 = 0.133333333333333

			if 0.133333333333333 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_2 = arg_336_1:GetWordFromCfg(413152077)
				local var_339_3 = arg_336_1:FormatText(var_339_2.content)

				arg_336_1.text_.text = var_339_3

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 6 <= 0 and var_339_1 or var_339_1 * (utf8.len(var_339_3) / 6)

				if (6 <= 0 and var_339_1 or var_339_1 * (utf8.len(var_339_3) / 6)) > 0 and var_339_1 < var_339_5 then
					arg_336_1.talkMaxDuration = var_339_5

					if var_339_5 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_3
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152077", "story_v_out_413152.awb") ~= 0 then
					local var_339_6 = manager.audio:GetVoiceLength("story_v_out_413152", "413152077", "story_v_out_413152.awb") / 1000

					if var_339_6 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_6 + var_339_0
					end

					if var_339_2.prefab_name ~= "" and arg_336_1.actors_[var_339_2.prefab_name] ~= nil then
						local var_339_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_2.prefab_name].transform, "story_v_out_413152", "413152077", "story_v_out_413152.awb")

						arg_336_1:RecordAudio("413152077", var_339_7)
						arg_336_1:RecordAudio("413152077", var_339_7)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_413152", "413152077", "story_v_out_413152.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_413152", "413152077", "story_v_out_413152.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_8 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_8 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_8

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_8 and arg_336_1.time_ < var_339_0 + var_339_8 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/ST0603",
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/SS1310"
	},
	voices = {
		"story_v_out_413152.awb"
	}
}
