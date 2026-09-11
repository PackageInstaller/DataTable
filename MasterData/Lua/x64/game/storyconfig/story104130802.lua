return {
	Play413082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413082001
		arg_1_1.duration_ = 10.77

		local var_1_0 = {
			zh = 10.766,
			ja = 6.366
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
				arg_1_0:Play413082002(arg_1_1)
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
			local var_4_16 = 0.3

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(413082001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 12 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 12)

				if (12 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 12)) > 0 and var_4_16 < var_4_21 then
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

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082001", "story_v_out_413082.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_413082", "413082001", "story_v_out_413082.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_413082", "413082001", "story_v_out_413082.awb")

						arg_1_1:RecordAudio("413082001", var_4_23)
						arg_1_1:RecordAudio("413082001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413082", "413082001", "story_v_out_413082.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413082", "413082001", "story_v_out_413082.awb")
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
	Play413082002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413082002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413082003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_123_02", "se_story_123_02_Vine", "")
			end

			if 0.2 < arg_9_1.time_ and arg_9_1.time_ <= 0.2 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_123_02", "se_story_123_02_fire", "")
			end

			local var_12_2 = 0
			local var_12_3 = 1.575

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_4 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(413082002).content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 63 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 63)

				if (63 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 63)) > 0 and var_12_3 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_3, arg_9_1.talkMaxDuration)

			if var_12_2 <= arg_9_1.time_ and arg_9_1.time_ < var_12_2 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_2) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_2 + var_12_7 and arg_9_1.time_ < var_12_2 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play413082003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413082003
		arg_13_1.duration_ = 3.87

		local var_13_0 = {
			zh = 3.066,
			ja = 3.866
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
				arg_13_0:Play413082004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10022"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "10022"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["10022"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["10022"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10022 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10022", 3)

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
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_16_5 = arg_13_1.actors_["10022"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps10022 == nil then
				arg_13_1.var_.actorSpriteComps10022 = var_16_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.actorSpriteComps10022 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								iter_16_4.color = Color.New(Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_6), Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_6), (Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_6)))
							else
								local var_16_7 = Mathf.Lerp(iter_16_4.color.r, 1, (arg_13_1.time_ - 0) / var_16_6)

								iter_16_4.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps10022 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_16_6 then
						iter_16_6.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_8 = arg_13_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_8 then
					arg_13_1.var_.alphaOldValue10022 = var_16_8.alpha
					arg_13_1.var_.characterEffect10022 = var_16_8
				end

				arg_13_1.var_.alphaOldValue10022 = 0
			end

			local var_16_9 = 0.5

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				if arg_13_1.var_.characterEffect10022 then
					arg_13_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_13_1.var_.alphaOldValue10022, 1, (arg_13_1.time_ - 0) / var_16_9)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 and arg_13_1.var_.characterEffect10022 then
				arg_13_1.var_.characterEffect10022.alpha = 1
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_10 = 0.3
			local var_16_11 = 0.3

			if 0.3 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_12 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_12:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:GetWordFromCfg(413082003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 12 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_14) / 12)

				if (12 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_14) / 12)) > 0 and var_16_11 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16
					var_16_10 = var_16_10 + 0.3

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082003", "story_v_out_413082.awb") ~= 0 then
					local var_16_17 = manager.audio:GetVoiceLength("story_v_out_413082", "413082003", "story_v_out_413082.awb") / 1000

					if var_16_17 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_10
					end

					if var_16_13.prefab_name ~= "" and arg_13_1.actors_[var_16_13.prefab_name] ~= nil then
						local var_16_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_13.prefab_name].transform, "story_v_out_413082", "413082003", "story_v_out_413082.awb")

						arg_13_1:RecordAudio("413082003", var_16_18)
						arg_13_1:RecordAudio("413082003", var_16_18)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413082", "413082003", "story_v_out_413082.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413082", "413082003", "story_v_out_413082.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_19 = var_16_10 + 0.3
			local var_16_20 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_20 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_19) / var_16_20

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_19 + var_16_20 and arg_13_1.time_ < var_16_19 + var_16_20 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play413082004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 413082004
		arg_19_1.duration_ = 5.57

		local var_19_0 = {
			zh = 5.566,
			ja = 5.5
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play413082005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.625

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_1 = arg_19_1:GetWordFromCfg(413082004)
				local var_22_2 = arg_19_1:FormatText(var_22_1.content)

				arg_19_1.text_.text = var_22_2

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_4 = 25 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_2) / 25)

				if (25 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_2) / 25)) > 0 and var_22_0 < var_22_4 then
					arg_19_1.talkMaxDuration = var_22_4

					if var_22_4 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_4 + 0
					end
				end

				arg_19_1.text_.text = var_22_2
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082004", "story_v_out_413082.awb") ~= 0 then
					local var_22_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082004", "story_v_out_413082.awb") / 1000

					if var_22_5 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_5 + 0
					end

					if var_22_1.prefab_name ~= "" and arg_19_1.actors_[var_22_1.prefab_name] ~= nil then
						local var_22_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_1.prefab_name].transform, "story_v_out_413082", "413082004", "story_v_out_413082.awb")

						arg_19_1:RecordAudio("413082004", var_22_6)
						arg_19_1:RecordAudio("413082004", var_22_6)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_413082", "413082004", "story_v_out_413082.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_413082", "413082004", "story_v_out_413082.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_7 and arg_19_1.time_ < 0 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play413082005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 413082005
		arg_23_1.duration_ = 5.43

		local var_23_0 = {
			zh = 3.033,
			ja = 5.433
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
				arg_23_0:Play413082006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.35

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:GetWordFromCfg(413082005)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 14 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 14)

				if (14 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 14)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082005", "story_v_out_413082.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082005", "story_v_out_413082.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_413082", "413082005", "story_v_out_413082.awb")

						arg_23_1:RecordAudio("413082005", var_26_6)
						arg_23_1:RecordAudio("413082005", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_413082", "413082005", "story_v_out_413082.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_413082", "413082005", "story_v_out_413082.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play413082006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 413082006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play413082007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos10022 = arg_27_1.actors_["10022"].transform.localPosition
				arg_27_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("10022", 0)

				for iter_30_0 = 0, arg_27_1.actors_["10022"].transform.childCount - 1 do
					local var_30_0 = arg_27_1.actors_["10022"].transform:GetChild(iter_30_0)

					if var_30_0.name == "" or not string.find(var_30_0.name, "split") then
						var_30_0.gameObject:SetActive(true)
					else
						var_30_0.gameObject:SetActive(false)
					end
				end
			end

			local var_30_1 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_1 then
				arg_27_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_27_1.time_ - 0) / var_30_1)
			end

			if arg_27_1.time_ >= 0 + var_30_1 and arg_27_1.time_ < 0 + var_30_1 + arg_30_0 then
				arg_27_1.actors_["10022"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_30_2 = arg_27_1.actors_["10022"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.actorSpriteComps10022 == nil then
				arg_27_1.var_.actorSpriteComps10022 = var_30_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_3 = 2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_3 and not isNil(var_30_2) then
				if arg_27_1.var_.actorSpriteComps10022 then
					for iter_30_1, iter_30_2 in pairs(arg_27_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_30_2 then
							if arg_27_1.isInRecall_ then
								iter_30_2.color = Color.New(Mathf.Lerp(iter_30_2.color.r, arg_27_1.hightColor2.r, (arg_27_1.time_ - 0) / var_30_3), Mathf.Lerp(iter_30_2.color.g, arg_27_1.hightColor2.g, (arg_27_1.time_ - 0) / var_30_3), (Mathf.Lerp(iter_30_2.color.b, arg_27_1.hightColor2.b, (arg_27_1.time_ - 0) / var_30_3)))
							else
								local var_30_4 = Mathf.Lerp(iter_30_2.color.r, 0.5, (arg_27_1.time_ - 0) / var_30_3)

								iter_30_2.color = Color.New(var_30_4, var_30_4, var_30_4)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_3 and arg_27_1.time_ < 0 + var_30_3 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.actorSpriteComps10022 then
				for iter_30_3, iter_30_4 in pairs(arg_27_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_30_4 then
						iter_30_4.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_27_1.var_.actorSpriteComps10022 = nil
			end

			local var_30_5 = 0
			local var_30_6 = 1.55

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_7 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(413082006).content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 62 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_7) / 62)

				if (62 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_7) / 62)) > 0 and var_30_6 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_5
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_6, arg_27_1.talkMaxDuration)

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_5) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_5 + var_30_10 and arg_27_1.time_ < var_30_5 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play413082007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 413082007
		arg_31_1.duration_ = 6.1

		local var_31_0 = {
			zh = 4.266,
			ja = 6.1
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play413082008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos10022 = arg_31_1.actors_["10022"].transform.localPosition
				arg_31_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("10022", 3)

				for iter_34_0 = 0, arg_31_1.actors_["10022"].transform.childCount - 1 do
					local var_34_0 = arg_31_1.actors_["10022"].transform:GetChild(iter_34_0)

					if var_34_0.name == "split_8" or not string.find(var_34_0.name, "split") then
						var_34_0.gameObject:SetActive(true)
					else
						var_34_0.gameObject:SetActive(false)
					end
				end
			end

			local var_34_1 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 then
				arg_31_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_31_1.time_ - 0) / var_34_1)
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 then
				arg_31_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_34_2 = arg_31_1.actors_["10022"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps10022 == nil then
				arg_31_1.var_.actorSpriteComps10022 = var_34_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_3 = 2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 and not isNil(var_34_2) then
				if arg_31_1.var_.actorSpriteComps10022 then
					for iter_34_1, iter_34_2 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_34_2 then
							if arg_31_1.isInRecall_ then
								iter_34_2.color = Color.New(Mathf.Lerp(iter_34_2.color.r, arg_31_1.hightColor1.r, (arg_31_1.time_ - 0) / var_34_3), Mathf.Lerp(iter_34_2.color.g, arg_31_1.hightColor1.g, (arg_31_1.time_ - 0) / var_34_3), (Mathf.Lerp(iter_34_2.color.b, arg_31_1.hightColor1.b, (arg_31_1.time_ - 0) / var_34_3)))
							else
								local var_34_4 = Mathf.Lerp(iter_34_2.color.r, 1, (arg_31_1.time_ - 0) / var_34_3)

								iter_34_2.color = Color.New(var_34_4, var_34_4, var_34_4)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps10022 then
				for iter_34_3, iter_34_4 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_34_4 then
						iter_34_4.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_31_1.var_.actorSpriteComps10022 = nil
			end

			local var_34_5 = 0
			local var_34_6 = 0.6

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_7 = arg_31_1:GetWordFromCfg(413082007)
				local var_34_8 = arg_31_1:FormatText(var_34_7.content)

				arg_31_1.text_.text = var_34_8

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_10 = 24 <= 0 and var_34_6 or var_34_6 * (utf8.len(var_34_8) / 24)

				if (24 <= 0 and var_34_6 or var_34_6 * (utf8.len(var_34_8) / 24)) > 0 and var_34_6 < var_34_10 then
					arg_31_1.talkMaxDuration = var_34_10

					if var_34_10 + var_34_5 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_5
					end
				end

				arg_31_1.text_.text = var_34_8
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082007", "story_v_out_413082.awb") ~= 0 then
					local var_34_11 = manager.audio:GetVoiceLength("story_v_out_413082", "413082007", "story_v_out_413082.awb") / 1000

					if var_34_11 + var_34_5 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_11 + var_34_5
					end

					if var_34_7.prefab_name ~= "" and arg_31_1.actors_[var_34_7.prefab_name] ~= nil then
						local var_34_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_7.prefab_name].transform, "story_v_out_413082", "413082007", "story_v_out_413082.awb")

						arg_31_1:RecordAudio("413082007", var_34_12)
						arg_31_1:RecordAudio("413082007", var_34_12)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_413082", "413082007", "story_v_out_413082.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_413082", "413082007", "story_v_out_413082.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_13 = math.max(var_34_6, arg_31_1.talkMaxDuration)

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_13 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_5) / var_34_13

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_5 + var_34_13 and arg_31_1.time_ < var_34_5 + var_34_13 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play413082008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 413082008
		arg_35_1.duration_ = 6.6

		local var_35_0 = {
			zh = 3.4,
			ja = 6.6
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
				arg_35_0:Play413082009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.45

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:GetWordFromCfg(413082008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 18 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 18)

				if (18 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 18)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082008", "story_v_out_413082.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082008", "story_v_out_413082.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_413082", "413082008", "story_v_out_413082.awb")

						arg_35_1:RecordAudio("413082008", var_38_6)
						arg_35_1:RecordAudio("413082008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_413082", "413082008", "story_v_out_413082.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_413082", "413082008", "story_v_out_413082.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play413082009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413082009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play413082010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10022 = arg_39_1.actors_["10022"].transform.localPosition
				arg_39_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10022", 0)

				for iter_42_0 = 0, arg_39_1.actors_["10022"].transform.childCount - 1 do
					local var_42_0 = arg_39_1.actors_["10022"].transform:GetChild(iter_42_0)

					if var_42_0.name == "" or not string.find(var_42_0.name, "split") then
						var_42_0.gameObject:SetActive(true)
					else
						var_42_0.gameObject:SetActive(false)
					end
				end
			end

			local var_42_1 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 then
				arg_39_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_39_1.time_ - 0) / var_42_1)
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 then
				arg_39_1.actors_["10022"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_42_2 = arg_39_1.actors_["10022"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps10022 == nil then
				arg_39_1.var_.actorSpriteComps10022 = var_42_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_3 = 2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 and not isNil(var_42_2) then
				if arg_39_1.var_.actorSpriteComps10022 then
					for iter_42_1, iter_42_2 in pairs(arg_39_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_42_2 then
							if arg_39_1.isInRecall_ then
								iter_42_2.color = Color.New(Mathf.Lerp(iter_42_2.color.r, arg_39_1.hightColor2.r, (arg_39_1.time_ - 0) / var_42_3), Mathf.Lerp(iter_42_2.color.g, arg_39_1.hightColor2.g, (arg_39_1.time_ - 0) / var_42_3), (Mathf.Lerp(iter_42_2.color.b, arg_39_1.hightColor2.b, (arg_39_1.time_ - 0) / var_42_3)))
							else
								local var_42_4 = Mathf.Lerp(iter_42_2.color.r, 0.5, (arg_39_1.time_ - 0) / var_42_3)

								iter_42_2.color = Color.New(var_42_4, var_42_4, var_42_4)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps10022 then
				for iter_42_3, iter_42_4 in pairs(arg_39_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_42_4 then
						iter_42_4.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_39_1.var_.actorSpriteComps10022 = nil
			end

			local var_42_5 = 0
			local var_42_6 = 1.225

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_7 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(413082009).content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 49 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_7) / 49)

				if (49 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_7) / 49)) > 0 and var_42_6 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_5
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_6, arg_39_1.talkMaxDuration)

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_5) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_5 + var_42_10 and arg_39_1.time_ < var_42_5 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play413082010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413082010
		arg_43_1.duration_ = 9.1

		local var_43_0 = {
			zh = 9.1,
			ja = 5.966
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
				arg_43_0:Play413082011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["10096"] == nil then
				local var_46_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_46_0) then
					local var_46_1 = Object.Instantiate(var_46_0, arg_43_1.canvasGo_.transform)

					var_46_1.transform:SetSiblingIndex(1)

					var_46_1.name = "10096"
					var_46_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_43_1.actors_["10096"] = var_46_1

					if arg_43_1.isInRecall_ then
						for iter_46_0, iter_46_1 in ipairs((var_46_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_46_1.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_46_2 = arg_43_1.actors_["10096"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10096 = var_46_2.localPosition
				var_46_2.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10096", 7)

				for iter_46_2 = 0, var_46_2.childCount - 1 do
					local var_46_3 = var_46_2:GetChild(iter_46_2)

					if var_46_3.name == "" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_2.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10096, Vector3.New(0, -2000, -180), (arg_43_1.time_ - 0) / var_46_4)
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_46_5 = arg_43_1.actors_["10096"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.actorSpriteComps10096 == nil then
				arg_43_1.var_.actorSpriteComps10096 = var_46_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_6 = 2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_6 and not isNil(var_46_5) then
				if arg_43_1.var_.actorSpriteComps10096 then
					for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_46_4 then
							if arg_43_1.isInRecall_ then
								iter_46_4.color = Color.New(Mathf.Lerp(iter_46_4.color.r, arg_43_1.hightColor1.r, (arg_43_1.time_ - 0) / var_46_6), Mathf.Lerp(iter_46_4.color.g, arg_43_1.hightColor1.g, (arg_43_1.time_ - 0) / var_46_6), (Mathf.Lerp(iter_46_4.color.b, arg_43_1.hightColor1.b, (arg_43_1.time_ - 0) / var_46_6)))
							else
								local var_46_7 = Mathf.Lerp(iter_46_4.color.r, 1, (arg_43_1.time_ - 0) / var_46_6)

								iter_46_4.color = Color.New(var_46_7, var_46_7, var_46_7)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_6 and arg_43_1.time_ < 0 + var_46_6 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.actorSpriteComps10096 then
				for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_46_6 then
						iter_46_6.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_43_1.var_.actorSpriteComps10096 = nil
			end

			local var_46_8 = 0
			local var_46_9 = 0.3

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_6")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_10 = arg_43_1:GetWordFromCfg(413082010)
				local var_46_11 = arg_43_1:FormatText(var_46_10.content)

				arg_43_1.text_.text = var_46_11

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_13 = 12 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 12)

				if (12 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 12)) > 0 and var_46_9 < var_46_13 then
					arg_43_1.talkMaxDuration = var_46_13

					if var_46_13 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_11
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082010", "story_v_out_413082.awb") ~= 0 then
					local var_46_14 = manager.audio:GetVoiceLength("story_v_out_413082", "413082010", "story_v_out_413082.awb") / 1000

					if var_46_14 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_14 + var_46_8
					end

					if var_46_10.prefab_name ~= "" and arg_43_1.actors_[var_46_10.prefab_name] ~= nil then
						local var_46_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_10.prefab_name].transform, "story_v_out_413082", "413082010", "story_v_out_413082.awb")

						arg_43_1:RecordAudio("413082010", var_46_15)
						arg_43_1:RecordAudio("413082010", var_46_15)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413082", "413082010", "story_v_out_413082.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413082", "413082010", "story_v_out_413082.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_16 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_16 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_8) / var_46_16

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_8 + var_46_16 and arg_43_1.time_ < var_46_8 + var_46_16 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play413082011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413082011
		arg_47_1.duration_ = 7.3

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play413082012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.25

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:GetWordFromCfg(413082011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 10 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 10)

				if (10 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 10)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082011", "story_v_out_413082.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082011", "story_v_out_413082.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_413082", "413082011", "story_v_out_413082.awb")

						arg_47_1:RecordAudio("413082011", var_50_6)
						arg_47_1:RecordAudio("413082011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_413082", "413082011", "story_v_out_413082.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_413082", "413082011", "story_v_out_413082.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play413082012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413082012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play413082013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10096 = arg_51_1.actors_["10096"].transform.localPosition
				arg_51_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10096", 0)

				for iter_54_0 = 0, arg_51_1.actors_["10096"].transform.childCount - 1 do
					local var_54_0 = arg_51_1.actors_["10096"].transform:GetChild(iter_54_0)

					if var_54_0.name == "" or not string.find(var_54_0.name, "split") then
						var_54_0.gameObject:SetActive(true)
					else
						var_54_0.gameObject:SetActive(false)
					end
				end
			end

			local var_54_1 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 then
				arg_51_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10096, Vector3.New(-1500, -350, -180), (arg_51_1.time_ - 0) / var_54_1)
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 then
				arg_51_1.actors_["10096"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_54_2 = arg_51_1.actors_["10096"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps10096 == nil then
				arg_51_1.var_.actorSpriteComps10096 = var_54_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_3 = 2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.actorSpriteComps10096 then
					for iter_54_1, iter_54_2 in pairs(arg_51_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_54_2 then
							if arg_51_1.isInRecall_ then
								iter_54_2.color = Color.New(Mathf.Lerp(iter_54_2.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_3), Mathf.Lerp(iter_54_2.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_3), (Mathf.Lerp(iter_54_2.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_3)))
							else
								local var_54_4 = Mathf.Lerp(iter_54_2.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_3)

								iter_54_2.color = Color.New(var_54_4, var_54_4, var_54_4)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps10096 then
				for iter_54_3, iter_54_4 in pairs(arg_51_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_54_4 then
						iter_54_4.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps10096 = nil
			end

			local var_54_5 = 0
			local var_54_6 = 1.25

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_7 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(413082012).content)

				arg_51_1.text_.text = var_54_7

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 50 <= 0 and var_54_6 or var_54_6 * (utf8.len(var_54_7) / 50)

				if (50 <= 0 and var_54_6 or var_54_6 * (utf8.len(var_54_7) / 50)) > 0 and var_54_6 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9

					if var_54_9 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_5
					end
				end

				arg_51_1.text_.text = var_54_7
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_6, arg_51_1.talkMaxDuration)

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_5) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_5 + var_54_10 and arg_51_1.time_ < var_54_5 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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

		arg_51_1:InitPlayNodeList()
	end,
	Play413082013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413082013
		arg_55_1.duration_ = 5.83

		local var_55_0 = {
			zh = 5.833,
			ja = 5.7
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play413082014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10022 = arg_55_1.actors_["10022"].transform.localPosition
				arg_55_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10022", 3)

				for iter_58_0 = 0, arg_55_1.actors_["10022"].transform.childCount - 1 do
					local var_58_0 = arg_55_1.actors_["10022"].transform:GetChild(iter_58_0)

					if var_58_0.name == "split_6" or not string.find(var_58_0.name, "split") then
						var_58_0.gameObject:SetActive(true)
					else
						var_58_0.gameObject:SetActive(false)
					end
				end
			end

			local var_58_1 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 then
				arg_55_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_55_1.time_ - 0) / var_58_1)
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 then
				arg_55_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_58_2 = arg_55_1.actors_["10022"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps10022 == nil then
				arg_55_1.var_.actorSpriteComps10022 = var_58_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_3 = 2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.actorSpriteComps10022 then
					for iter_58_1, iter_58_2 in pairs(arg_55_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_58_2 then
							if arg_55_1.isInRecall_ then
								iter_58_2.color = Color.New(Mathf.Lerp(iter_58_2.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 0) / var_58_3), Mathf.Lerp(iter_58_2.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 0) / var_58_3), (Mathf.Lerp(iter_58_2.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 0) / var_58_3)))
							else
								local var_58_4 = Mathf.Lerp(iter_58_2.color.r, 1, (arg_55_1.time_ - 0) / var_58_3)

								iter_58_2.color = Color.New(var_58_4, var_58_4, var_58_4)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps10022 then
				for iter_58_3, iter_58_4 in pairs(arg_55_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_58_4 then
						iter_58_4.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps10022 = nil
			end

			local var_58_5 = 0
			local var_58_6 = 0.725

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_7 = arg_55_1:GetWordFromCfg(413082013)
				local var_58_8 = arg_55_1:FormatText(var_58_7.content)

				arg_55_1.text_.text = var_58_8

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_10 = 29 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 29)

				if (29 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 29)) > 0 and var_58_6 < var_58_10 then
					arg_55_1.talkMaxDuration = var_58_10

					if var_58_10 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_5
					end
				end

				arg_55_1.text_.text = var_58_8
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082013", "story_v_out_413082.awb") ~= 0 then
					local var_58_11 = manager.audio:GetVoiceLength("story_v_out_413082", "413082013", "story_v_out_413082.awb") / 1000

					if var_58_11 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_5
					end

					if var_58_7.prefab_name ~= "" and arg_55_1.actors_[var_58_7.prefab_name] ~= nil then
						local var_58_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_7.prefab_name].transform, "story_v_out_413082", "413082013", "story_v_out_413082.awb")

						arg_55_1:RecordAudio("413082013", var_58_12)
						arg_55_1:RecordAudio("413082013", var_58_12)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_413082", "413082013", "story_v_out_413082.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_413082", "413082013", "story_v_out_413082.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_13 = math.max(var_58_6, arg_55_1.talkMaxDuration)

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_13 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_5) / var_58_13

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_5 + var_58_13 and arg_55_1.time_ < var_58_5 + var_58_13 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play413082014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 413082014
		arg_59_1.duration_ = 8.37

		local var_59_0 = {
			zh = 8.366,
			ja = 4.8
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
				arg_59_0:Play413082015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10022 = arg_59_1.actors_["10022"].transform.localPosition
				arg_59_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10022", 7)

				for iter_62_0 = 0, arg_59_1.actors_["10022"].transform.childCount - 1 do
					local var_62_0 = arg_59_1.actors_["10022"].transform:GetChild(iter_62_0)

					if var_62_0.name == "" or not string.find(var_62_0.name, "split") then
						var_62_0.gameObject:SetActive(true)
					else
						var_62_0.gameObject:SetActive(false)
					end
				end
			end

			local var_62_1 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 then
				arg_59_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_59_1.time_ - 0) / var_62_1)
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 then
				arg_59_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_62_2 = 0
			local var_62_3 = 0.2

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_4 = arg_59_1:GetWordFromCfg(413082014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 8 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 8)

				if (8 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 8)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082014", "story_v_out_413082.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082014", "story_v_out_413082.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_413082", "413082014", "story_v_out_413082.awb")

						arg_59_1:RecordAudio("413082014", var_62_9)
						arg_59_1:RecordAudio("413082014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_413082", "413082014", "story_v_out_413082.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_413082", "413082014", "story_v_out_413082.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_10 and arg_59_1.time_ < var_62_2 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play413082015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 413082015
		arg_63_1.duration_ = 3.73

		local var_63_0 = {
			zh = 3.166,
			ja = 3.733
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play413082016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10022"]) and arg_63_1.var_.actorSpriteComps10022 == nil then
				arg_63_1.var_.actorSpriteComps10022 = arg_63_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_0 = 2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10022"]) then
				if arg_63_1.var_.actorSpriteComps10022 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								iter_66_1.color = Color.New(Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_0), Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_0), (Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_0)))
							else
								local var_66_1 = Mathf.Lerp(iter_66_1.color.r, 1, (arg_63_1.time_ - 0) / var_66_0)

								iter_66_1.color = Color.New(var_66_1, var_66_1, var_66_1)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10022"]) and arg_63_1.var_.actorSpriteComps10022 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps10022 = nil
			end

			local var_66_2 = arg_63_1.actors_["10096"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10096 == nil then
				arg_63_1.var_.actorSpriteComps10096 = var_66_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_3 = 2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.actorSpriteComps10096 then
					for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_66_5 then
							if arg_63_1.isInRecall_ then
								iter_66_5.color = Color.New(Mathf.Lerp(iter_66_5.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_3), Mathf.Lerp(iter_66_5.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_3), (Mathf.Lerp(iter_66_5.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_3)))
							else
								local var_66_4 = Mathf.Lerp(iter_66_5.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_3)

								iter_66_5.color = Color.New(var_66_4, var_66_4, var_66_4)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10096 then
				for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_66_7 then
						iter_66_7.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps10096 = nil
			end

			local var_66_5 = arg_63_1.actors_["10022"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10022 = var_66_5.localPosition
				var_66_5.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10022", 3)

				for iter_66_8 = 0, var_66_5.childCount - 1 do
					local var_66_6 = var_66_5:GetChild(iter_66_8)

					if var_66_6.name == "split_6" or not string.find(var_66_6.name, "split") then
						var_66_6.gameObject:SetActive(true)
					else
						var_66_6.gameObject:SetActive(false)
					end
				end
			end

			local var_66_7 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				var_66_5.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_63_1.time_ - 0) / var_66_7)
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				var_66_5.localPosition = Vector3.New(0, -315, -320)
			end

			local var_66_8 = 0
			local var_66_9 = 0.45

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_10 = arg_63_1:GetWordFromCfg(413082015)
				local var_66_11 = arg_63_1:FormatText(var_66_10.content)

				arg_63_1.text_.text = var_66_11

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_13 = 18 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 18)

				if (18 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 18)) > 0 and var_66_9 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_8
					end
				end

				arg_63_1.text_.text = var_66_11
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082015", "story_v_out_413082.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_413082", "413082015", "story_v_out_413082.awb") / 1000

					if var_66_14 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_8
					end

					if var_66_10.prefab_name ~= "" and arg_63_1.actors_[var_66_10.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_10.prefab_name].transform, "story_v_out_413082", "413082015", "story_v_out_413082.awb")

						arg_63_1:RecordAudio("413082015", var_66_15)
						arg_63_1:RecordAudio("413082015", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_413082", "413082015", "story_v_out_413082.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_413082", "413082015", "story_v_out_413082.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_9, arg_63_1.talkMaxDuration)

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_8) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_8 + var_66_16 and arg_63_1.time_ < var_66_8 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play413082016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 413082016
		arg_67_1.duration_ = 4.2

		local var_67_0 = {
			zh = 2.4,
			ja = 4.2
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
				arg_67_0:Play413082017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.3

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(413082016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 12 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 12)

				if (12 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 12)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082016", "story_v_out_413082.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082016", "story_v_out_413082.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_413082", "413082016", "story_v_out_413082.awb")

						arg_67_1:RecordAudio("413082016", var_70_6)
						arg_67_1:RecordAudio("413082016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_413082", "413082016", "story_v_out_413082.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_413082", "413082016", "story_v_out_413082.awb")
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
	Play413082017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 413082017
		arg_71_1.duration_ = 6

		local var_71_0 = {
			zh = 5.1,
			ja = 6
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
				arg_71_0:Play413082018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10022 = arg_71_1.actors_["10022"].transform.localPosition
				arg_71_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10022", 3)

				for iter_74_0 = 0, arg_71_1.actors_["10022"].transform.childCount - 1 do
					local var_74_0 = arg_71_1.actors_["10022"].transform:GetChild(iter_74_0)

					if var_74_0.name == "split_2" or not string.find(var_74_0.name, "split") then
						var_74_0.gameObject:SetActive(true)
					else
						var_74_0.gameObject:SetActive(false)
					end
				end
			end

			local var_74_1 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 then
				arg_71_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_71_1.time_ - 0) / var_74_1)
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 then
				arg_71_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_74_2 = 0
			local var_74_3 = 0.5

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_4 = arg_71_1:GetWordFromCfg(413082017)
				local var_74_5 = arg_71_1:FormatText(var_74_4.content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_7 = 20 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_5) / 20)

				if (20 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_5) / 20)) > 0 and var_74_3 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_2
					end
				end

				arg_71_1.text_.text = var_74_5
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082017", "story_v_out_413082.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082017", "story_v_out_413082.awb") / 1000

					if var_74_8 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_2
					end

					if var_74_4.prefab_name ~= "" and arg_71_1.actors_[var_74_4.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_4.prefab_name].transform, "story_v_out_413082", "413082017", "story_v_out_413082.awb")

						arg_71_1:RecordAudio("413082017", var_74_9)
						arg_71_1:RecordAudio("413082017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_413082", "413082017", "story_v_out_413082.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_413082", "413082017", "story_v_out_413082.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_3, arg_71_1.talkMaxDuration)

			if var_74_2 <= arg_71_1.time_ and arg_71_1.time_ < var_74_2 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_2) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_2 + var_74_10 and arg_71_1.time_ < var_74_2 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play413082018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 413082018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play413082019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10022 = arg_75_1.actors_["10022"].transform.localPosition
				arg_75_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10022", 0)

				for iter_78_0 = 0, arg_75_1.actors_["10022"].transform.childCount - 1 do
					local var_78_0 = arg_75_1.actors_["10022"].transform:GetChild(iter_78_0)

					if var_78_0.name == "" or not string.find(var_78_0.name, "split") then
						var_78_0.gameObject:SetActive(true)
					else
						var_78_0.gameObject:SetActive(false)
					end
				end
			end

			local var_78_1 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 then
				arg_75_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_75_1.time_ - 0) / var_78_1)
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 then
				arg_75_1.actors_["10022"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_78_2 = arg_75_1.actors_["10096"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps10096 == nil then
				arg_75_1.var_.actorSpriteComps10096 = var_78_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_3 = 2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.actorSpriteComps10096 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps10096 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_78_4 then
						iter_78_4.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_75_1.var_.actorSpriteComps10096 = nil
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_78_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_75_1.bgmTxt_.text ~= var_78_7 and arg_75_1.bgmTxt_.text ~= "" then
						if arg_75_1.bgmTxt2_.text ~= "" then
							arg_75_1.bgmTxt_.text = arg_75_1.bgmTxt2_.text
						end

						arg_75_1.bgmTxt2_.text = var_78_7

						arg_75_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_75_1.bgmTxt_.text = var_78_7
						arg_75_1.bgmTxt2_.text = var_78_7
					end

					if arg_75_1.bgmTimer then
						arg_75_1.bgmTimer:Stop()

						arg_75_1.bgmTimer = nil
					end

					if arg_75_1.settingData.show_music_name == 1 then
						arg_75_1.musicController:SetSelectedState("show")
						arg_75_1.musicAnimator_:Play("open", 0, 0)

						if arg_75_1.settingData.music_time ~= 0 then
							arg_75_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_75_1.settingData.music_time), function()
								if arg_75_1 == nil or isNil(arg_75_1.bgmTxt_) then
									return
								end

								arg_75_1.musicController:SetSelectedState("hide")
								arg_75_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_78_8 = 0
			local var_78_9 = 1.425

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_10 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(413082018).content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_12 = 57 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_10) / 57)

				if (57 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_10) / 57)) > 0 and var_78_9 < var_78_12 then
					arg_75_1.talkMaxDuration = var_78_12

					if var_78_12 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_13 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_13 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_8) / var_78_13

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_8 + var_78_13 and arg_75_1.time_ < var_78_8 + var_78_13 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play413082019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 413082019
		arg_80_1.duration_ = 3.17

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play413082020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_83_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_80_1.bgmTxt_.text ~= var_83_2 and arg_80_1.bgmTxt_.text ~= "" then
						if arg_80_1.bgmTxt2_.text ~= "" then
							arg_80_1.bgmTxt_.text = arg_80_1.bgmTxt2_.text
						end

						arg_80_1.bgmTxt2_.text = var_83_2

						arg_80_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_80_1.bgmTxt_.text = var_83_2
						arg_80_1.bgmTxt2_.text = var_83_2
					end

					if arg_80_1.bgmTimer then
						arg_80_1.bgmTimer:Stop()

						arg_80_1.bgmTimer = nil
					end

					if arg_80_1.settingData.show_music_name == 1 then
						arg_80_1.musicController:SetSelectedState("show")
						arg_80_1.musicAnimator_:Play("open", 0, 0)

						if arg_80_1.settingData.music_time ~= 0 then
							arg_80_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_80_1.settingData.music_time), function()
								if arg_80_1 == nil or isNil(arg_80_1.bgmTxt_) then
									return
								end

								arg_80_1.musicController:SetSelectedState("hide")
								arg_80_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_3 = 0.266666666666667
			local var_83_4 = 0.125

			if 0.266666666666667 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_5 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_5:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_80_1.dialogCg_.alpha = arg_85_0
				end))
				var_83_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10094")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_6 = arg_80_1:GetWordFromCfg(413082019)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 5 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_7) / 5)

				if (5 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_7) / 5)) > 0 and var_83_4 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9
					var_83_3 = var_83_3 + 0.3

					if var_83_9 + var_83_3 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_3
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082019", "story_v_out_413082.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_413082", "413082019", "story_v_out_413082.awb") / 1000

					if var_83_10 + var_83_3 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_3
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_413082", "413082019", "story_v_out_413082.awb")

						arg_80_1:RecordAudio("413082019", var_83_11)
						arg_80_1:RecordAudio("413082019", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_413082", "413082019", "story_v_out_413082.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_413082", "413082019", "story_v_out_413082.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = var_83_3 + 0.3
			local var_83_13 = math.max(var_83_4, arg_80_1.talkMaxDuration)

			if var_83_3 + 0.3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_13 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_12) / var_83_13

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_12 + var_83_13 and arg_80_1.time_ < var_83_12 + var_83_13 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play413082020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 413082020
		arg_87_1.duration_ = 8.57

		local var_87_0 = {
			zh = 7.56633333333333,
			ja = 8.56633333333333
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
				arg_87_0:Play413082021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_0 = 1.3

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				local var_90_1 = Color.New(0, 0, 0)

				var_90_1.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.mask_.color = var_90_1
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				local var_90_2 = Color.New(0, 0, 0)

				var_90_2.a = 1
				arg_87_1.mask_.color = var_90_2
			end

			local var_90_3 = 1.30066666666667

			if 1.30066666666667 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_4 = 2.43333333333333

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_4 then
				local var_90_5 = Color.New(0, 0, 0)

				var_90_5.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_3) / var_90_4)
				arg_87_1.mask_.color = var_90_5
			end

			if arg_87_1.time_ >= var_90_3 + var_90_4 and arg_87_1.time_ < var_90_3 + var_90_4 + arg_90_0 then
				local var_90_6 = Color.New(0, 0, 0)

				arg_87_1.mask_.enabled = false
				var_90_6.a = 0
				arg_87_1.mask_.color = var_90_6
			end

			local var_90_7 = "SS1306"

			if arg_87_1.bgs_.SS1306 == nil then
				local var_90_8 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_90_7)
				var_90_8.name = var_90_7
				var_90_8.transform.parent = arg_87_1.stage_.transform
				var_90_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_[var_90_7] = var_90_8
			end

			local var_90_9 = arg_87_1.bgs_.SS1306.transform

			if 1.30066666666667 < arg_87_1.time_ and arg_87_1.time_ <= 1.30066666666667 + arg_90_0 then
				arg_87_1.var_.moveOldPosSS1306 = var_90_9.localPosition
			end

			local var_90_10 = 0.001

			if 1.30066666666667 <= arg_87_1.time_ and arg_87_1.time_ < 1.30066666666667 + var_90_10 then
				var_90_9.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPosSS1306, Vector3.New(-1.22, 1, 7.11), (arg_87_1.time_ - 1.30066666666667) / var_90_10)
			end

			if arg_87_1.time_ >= 1.30066666666667 + var_90_10 and arg_87_1.time_ < 1.30066666666667 + var_90_10 + arg_90_0 then
				var_90_9.localPosition = Vector3.New(-1.22, 1, 7.11)
			end

			local var_90_11 = arg_87_1.bgs_.SS1306.transform

			if 1.31733333333333 < arg_87_1.time_ and arg_87_1.time_ <= 1.31733333333333 + arg_90_0 then
				arg_87_1.var_.moveOldPosSS1306 = var_90_11.localPosition
			end

			local var_90_12 = 2.916

			if 1.31733333333333 <= arg_87_1.time_ and arg_87_1.time_ < 1.31733333333333 + var_90_12 then
				var_90_11.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPosSS1306, Vector3.New(0, 1, 8.6), (arg_87_1.time_ - 1.31733333333333) / var_90_12)
			end

			if arg_87_1.time_ >= 1.31733333333333 + var_90_12 and arg_87_1.time_ < 1.31733333333333 + var_90_12 + arg_90_0 then
				var_90_11.localPosition = Vector3.New(0, 1, 8.6)
			end

			if 1.284 < arg_87_1.time_ and arg_87_1.time_ <= 1.284 + arg_90_0 then
				local var_90_13 = arg_87_1.bgs_.SS1306

				arg_87_1.bgs_.SS1306.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_14 = var_90_13:GetComponent("SpriteRenderer")

				if var_90_14 and var_90_14.sprite then
					local var_90_15 = 2 * (var_90_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_13.transform.localScale = Vector3.New(var_90_15 / var_90_14.sprite.bounds.size.y < var_90_15 * manager.ui.mainCameraCom_.aspect / var_90_14.sprite.bounds.size.x and var_90_15 * manager.ui.mainCameraCom_.aspect / var_90_14.sprite.bounds.size.x or var_90_15 / var_90_14.sprite.bounds.size.y, var_90_15 / var_90_14.sprite.bounds.size.y < var_90_15 * manager.ui.mainCameraCom_.aspect / var_90_14.sprite.bounds.size.x and var_90_15 * manager.ui.mainCameraCom_.aspect / var_90_14.sprite.bounds.size.x or var_90_15 / var_90_14.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "SS1306" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_16 = "10094"

			if arg_87_1.actors_["10094"] == nil then
				local var_90_17 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_90_17) then
					local var_90_18 = Object.Instantiate(var_90_17, arg_87_1.canvasGo_.transform)

					var_90_18.transform:SetSiblingIndex(1)

					var_90_18.name = var_90_16
					var_90_18.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_87_1.actors_[var_90_16] = var_90_18

					if arg_87_1.isInRecall_ then
						for iter_90_2, iter_90_3 in ipairs((var_90_18:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_90_3.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_90_19 = arg_87_1.actors_["10094"].transform

			if 1.284 < arg_87_1.time_ and arg_87_1.time_ <= 1.284 + arg_90_0 then
				arg_87_1.var_.moveOldPos10094 = var_90_19.localPosition
				var_90_19.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10094", 7)

				for iter_90_4 = 0, var_90_19.childCount - 1 do
					local var_90_20 = var_90_19:GetChild(iter_90_4)

					if var_90_20.name == "" or not string.find(var_90_20.name, "split") then
						var_90_20.gameObject:SetActive(true)
					else
						var_90_20.gameObject:SetActive(false)
					end
				end
			end

			local var_90_21 = 0.001

			if 1.284 <= arg_87_1.time_ and arg_87_1.time_ < 1.284 + var_90_21 then
				var_90_19.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_87_1.time_ - 1.284) / var_90_21)
			end

			if arg_87_1.time_ >= 1.284 + var_90_21 and arg_87_1.time_ < 1.284 + var_90_21 + arg_90_0 then
				var_90_19.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_22 = 2.83333333333333
			local var_90_23 = 0.375

			if 2.83333333333333 < arg_87_1.time_ and arg_87_1.time_ <= var_90_22 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_24 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_24:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_25 = arg_87_1:GetWordFromCfg(413082020)
				local var_90_26 = arg_87_1:FormatText(var_90_25.content)

				arg_87_1.text_.text = var_90_26

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_28 = 15 <= 0 and var_90_23 or var_90_23 * (utf8.len(var_90_26) / 15)

				if (15 <= 0 and var_90_23 or var_90_23 * (utf8.len(var_90_26) / 15)) > 0 and var_90_23 < var_90_28 then
					arg_87_1.talkMaxDuration = var_90_28
					var_90_22 = var_90_22 + 0.3

					if var_90_28 + var_90_22 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_28 + var_90_22
					end
				end

				arg_87_1.text_.text = var_90_26
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082020", "story_v_out_413082.awb") ~= 0 then
					local var_90_29 = manager.audio:GetVoiceLength("story_v_out_413082", "413082020", "story_v_out_413082.awb") / 1000

					if var_90_29 + var_90_22 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_29 + var_90_22
					end

					if var_90_25.prefab_name ~= "" and arg_87_1.actors_[var_90_25.prefab_name] ~= nil then
						local var_90_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_25.prefab_name].transform, "story_v_out_413082", "413082020", "story_v_out_413082.awb")

						arg_87_1:RecordAudio("413082020", var_90_30)
						arg_87_1:RecordAudio("413082020", var_90_30)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_413082", "413082020", "story_v_out_413082.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_413082", "413082020", "story_v_out_413082.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_31 = var_90_22 + 0.3
			local var_90_32 = math.max(var_90_23, arg_87_1.talkMaxDuration)

			if var_90_22 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_31 + var_90_32 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_31) / var_90_32

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_31 + var_90_32 and arg_87_1.time_ < var_90_31 + var_90_32 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.30066666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.916,
				className = "StoryMoveNode",
				startTime = 1.31733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666668,
				className = "StoryMoveNode",
				startTime = 1.284,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play413082021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413082021
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play413082022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:AudioAction("play", "music", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge.awb")

				local var_96_2 = manager.audio:GetAudioName("bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge")

				if "" ~= "" then
					if arg_93_1.bgmTxt_.text ~= var_96_2 and arg_93_1.bgmTxt_.text ~= "" then
						if arg_93_1.bgmTxt2_.text ~= "" then
							arg_93_1.bgmTxt_.text = arg_93_1.bgmTxt2_.text
						end

						arg_93_1.bgmTxt2_.text = var_96_2

						arg_93_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_93_1.bgmTxt_.text = var_96_2
						arg_93_1.bgmTxt2_.text = var_96_2
					end

					if arg_93_1.bgmTimer then
						arg_93_1.bgmTimer:Stop()

						arg_93_1.bgmTimer = nil
					end

					if arg_93_1.settingData.show_music_name == 1 then
						arg_93_1.musicController:SetSelectedState("show")
						arg_93_1.musicAnimator_:Play("open", 0, 0)

						if arg_93_1.settingData.music_time ~= 0 then
							arg_93_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_93_1.settingData.music_time), function()
								if arg_93_1 == nil or isNil(arg_93_1.bgmTxt_) then
									return
								end

								arg_93_1.musicController:SetSelectedState("hide")
								arg_93_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_96_3 = 0
			local var_96_4 = 1.675

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(413082021).content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 67 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 67)

				if (67 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 67)) > 0 and var_96_4 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_3
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_4, arg_93_1.talkMaxDuration)

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_3) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_3 + var_96_8 and arg_93_1.time_ < var_96_3 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play413082022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 413082022
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play413082023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 1.2

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(413082022).content)

				arg_98_1.text_.text = var_101_1

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_3 = 48 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 48)

				if (48 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 48)) > 0 and var_101_0 < var_101_3 then
					arg_98_1.talkMaxDuration = var_101_3

					if var_101_3 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_3 + 0
					end
				end

				arg_98_1.text_.text = var_101_1
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_4 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_4

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play413082023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 413082023
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play413082024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 1.425

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(413082023).content)

				arg_102_1.text_.text = var_105_1

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_3 = 57 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 57)

				if (57 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 57)) > 0 and var_105_0 < var_105_3 then
					arg_102_1.talkMaxDuration = var_105_3

					if var_105_3 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_3 + 0
					end
				end

				arg_102_1.text_.text = var_105_1
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_4 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_4

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play413082024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 413082024
		arg_106_1.duration_ = 9.37

		local var_106_0 = {
			zh = 9.366,
			ja = 4.666
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play413082025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.55

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_3")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_1 = arg_106_1:GetWordFromCfg(413082024)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 21 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 21)

				if (21 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 21)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082024", "story_v_out_413082.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082024", "story_v_out_413082.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_413082", "413082024", "story_v_out_413082.awb")

						arg_106_1:RecordAudio("413082024", var_109_6)
						arg_106_1:RecordAudio("413082024", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_413082", "413082024", "story_v_out_413082.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_413082", "413082024", "story_v_out_413082.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play413082025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 413082025
		arg_110_1.duration_ = 4.47

		local var_110_0 = {
			zh = 4.466,
			ja = 2.866
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play413082026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.35

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:GetWordFromCfg(413082025)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 14 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 14)

				if (14 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 14)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082025", "story_v_out_413082.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082025", "story_v_out_413082.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_413082", "413082025", "story_v_out_413082.awb")

						arg_110_1:RecordAudio("413082025", var_113_6)
						arg_110_1:RecordAudio("413082025", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_413082", "413082025", "story_v_out_413082.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_413082", "413082025", "story_v_out_413082.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play413082026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 413082026
		arg_114_1.duration_ = 9.5

		local var_114_0 = {
			zh = 9.5,
			ja = 4.733
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play413082027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.2

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_1 = arg_114_1:GetWordFromCfg(413082026)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 8 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 8)

				if (8 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 8)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082026", "story_v_out_413082.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082026", "story_v_out_413082.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_413082", "413082026", "story_v_out_413082.awb")

						arg_114_1:RecordAudio("413082026", var_117_6)
						arg_114_1:RecordAudio("413082026", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_413082", "413082026", "story_v_out_413082.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_413082", "413082026", "story_v_out_413082.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play413082027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 413082027
		arg_118_1.duration_ = 6.17

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play413082028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_0 = 0.9

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				local var_121_1 = Color.New(1, 1, 1)

				var_121_1.a = Mathf.Lerp(1, 0, (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.mask_.color = var_121_1
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				local var_121_2 = Color.New(1, 1, 1)

				arg_118_1.mask_.enabled = false
				var_121_2.a = 0
				arg_118_1.mask_.color = var_121_2
			end

			local var_121_3 = arg_118_1.bgs_.SS1306.transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPosSS1306 = var_121_3.localPosition
			end

			local var_121_4 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				var_121_3.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPosSS1306, Vector3.New(0, 1, 8.6), (arg_118_1.time_ - 0) / var_121_4)
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				var_121_3.localPosition = Vector3.New(0, 1, 8.6)
			end

			local var_121_5 = arg_118_1.bgs_.SS1306.transform

			if 0.0166666666666667 < arg_118_1.time_ and arg_118_1.time_ <= 0.0166666666666667 + arg_121_0 then
				arg_118_1.var_.moveOldPosSS1306 = var_121_5.localPosition
			end

			local var_121_6 = 1.48333333333333

			if 0.0166666666666667 <= arg_118_1.time_ and arg_118_1.time_ < 0.0166666666666667 + var_121_6 then
				var_121_5.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPosSS1306, Vector3.New(0, 1, 10), (arg_118_1.time_ - 0.0166666666666667) / var_121_6)
			end

			if arg_118_1.time_ >= 0.0166666666666667 + var_121_6 and arg_118_1.time_ < 0.0166666666666667 + var_121_6 + arg_121_0 then
				var_121_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_121_7 = 0

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_7 + arg_121_0 then
				arg_118_1.allBtn_.enabled = false
			end

			if arg_118_1.time_ >= var_121_7 + 2.96666666666667 and arg_118_1.time_ < var_121_7 + 2.96666666666667 + arg_121_0 then
				arg_118_1.allBtn_.enabled = true
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_8 = 1.16666666666667
			local var_121_9 = 1.925

			if 1.16666666666667 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_10 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_10:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_11 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(413082027).content)

				arg_118_1.text_.text = var_121_11

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_13 = 77 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_11) / 77)

				if (77 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_11) / 77)) > 0 and var_121_9 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13
					var_121_8 = var_121_8 + 0.3

					if var_121_13 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_8
					end
				end

				arg_118_1.text_.text = var_121_11
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = var_121_8 + 0.3
			local var_121_15 = math.max(var_121_9, arg_118_1.talkMaxDuration)

			if var_121_8 + 0.3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_14 + var_121_15 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_14) / var_121_15

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_14 + var_121_15 and arg_118_1.time_ < var_121_14 + var_121_15 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.48333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play413082028 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 413082028
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play413082029(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 1.55

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(413082028).content)

				arg_124_1.text_.text = var_127_1

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_3 = 62 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 62)

				if (62 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 62)) > 0 and var_127_0 < var_127_3 then
					arg_124_1.talkMaxDuration = var_127_3

					if var_127_3 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_3 + 0
					end
				end

				arg_124_1.text_.text = var_127_1
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_4 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_4

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play413082029 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 413082029
		arg_128_1.duration_ = 12.13

		local var_128_0 = {
			zh = 6.733,
			ja = 12.133
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
				arg_128_0:Play413082030(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.575

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_1 = arg_128_1:GetWordFromCfg(413082029)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 23 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 23)

				if (23 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 23)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082029", "story_v_out_413082.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082029", "story_v_out_413082.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_413082", "413082029", "story_v_out_413082.awb")

						arg_128_1:RecordAudio("413082029", var_131_6)
						arg_128_1:RecordAudio("413082029", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_413082", "413082029", "story_v_out_413082.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_413082", "413082029", "story_v_out_413082.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play413082030 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 413082030
		arg_132_1.duration_ = 5.63

		local var_132_0 = {
			zh = 3.966,
			ja = 5.633
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
				arg_132_0:Play413082031(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.4

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_2")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_1 = arg_132_1:GetWordFromCfg(413082030)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 16 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 16)

				if (16 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 16)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082030", "story_v_out_413082.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082030", "story_v_out_413082.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_413082", "413082030", "story_v_out_413082.awb")

						arg_132_1:RecordAudio("413082030", var_135_6)
						arg_132_1:RecordAudio("413082030", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_413082", "413082030", "story_v_out_413082.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_413082", "413082030", "story_v_out_413082.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play413082031 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 413082031
		arg_136_1.duration_ = 7.97

		local var_136_0 = {
			zh = 2,
			ja = 7.966
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
				arg_136_0:Play413082032(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.2

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_1 = arg_136_1:GetWordFromCfg(413082031)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 8 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 8)

				if (8 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 8)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082031", "story_v_out_413082.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082031", "story_v_out_413082.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_413082", "413082031", "story_v_out_413082.awb")

						arg_136_1:RecordAudio("413082031", var_139_6)
						arg_136_1:RecordAudio("413082031", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_413082", "413082031", "story_v_out_413082.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_413082", "413082031", "story_v_out_413082.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play413082032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 413082032
		arg_140_1.duration_ = 6.3

		local var_140_0 = {
			zh = 6.3,
			ja = 5.2
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
				arg_140_0:Play413082033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.425

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_1 = arg_140_1:GetWordFromCfg(413082032)
				local var_143_2 = arg_140_1:FormatText(var_143_1.content)

				arg_140_1.text_.text = var_143_2

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 17 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 17)

				if (17 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 17)) > 0 and var_143_0 < var_143_4 then
					arg_140_1.talkMaxDuration = var_143_4

					if var_143_4 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_4 + 0
					end
				end

				arg_140_1.text_.text = var_143_2
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082032", "story_v_out_413082.awb") ~= 0 then
					local var_143_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082032", "story_v_out_413082.awb") / 1000

					if var_143_5 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + 0
					end

					if var_143_1.prefab_name ~= "" and arg_140_1.actors_[var_143_1.prefab_name] ~= nil then
						local var_143_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_1.prefab_name].transform, "story_v_out_413082", "413082032", "story_v_out_413082.awb")

						arg_140_1:RecordAudio("413082032", var_143_6)
						arg_140_1:RecordAudio("413082032", var_143_6)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_413082", "413082032", "story_v_out_413082.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_413082", "413082032", "story_v_out_413082.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play413082033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 413082033
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play413082034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 1.025

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(413082033).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 41 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 41)

				if (41 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 41)) > 0 and var_147_0 < var_147_3 then
					arg_144_1.talkMaxDuration = var_147_3

					if var_147_3 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_3 + 0
					end
				end

				arg_144_1.text_.text = var_147_1
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_4 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_4

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play413082034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 413082034
		arg_148_1.duration_ = 5.67

		local var_148_0 = {
			zh = 3.5,
			ja = 5.666
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play413082035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.225

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_8")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_1 = arg_148_1:GetWordFromCfg(413082034)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 9 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 9)

				if (9 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 9)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082034", "story_v_out_413082.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082034", "story_v_out_413082.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_413082", "413082034", "story_v_out_413082.awb")

						arg_148_1:RecordAudio("413082034", var_151_6)
						arg_148_1:RecordAudio("413082034", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_413082", "413082034", "story_v_out_413082.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_413082", "413082034", "story_v_out_413082.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play413082035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 413082035
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play413082036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 1.6

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(413082035).content)

				arg_152_1.text_.text = var_155_1

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_3 = 64 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 64)

				if (64 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 64)) > 0 and var_155_0 < var_155_3 then
					arg_152_1.talkMaxDuration = var_155_3

					if var_155_3 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_3 + 0
					end
				end

				arg_152_1.text_.text = var_155_1
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_4 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_4

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play413082036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 413082036
		arg_156_1.duration_ = 3.73

		local var_156_0 = {
			zh = 3.733,
			ja = 2.1
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play413082037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			if arg_156_1.time_ >= 0 + 1.86666666666667 and arg_156_1.time_ < 0 + 1.86666666666667 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_0 = 0
			local var_159_1 = 0.175

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_2 = arg_156_1:GetWordFromCfg(413082036)
				local var_159_3 = arg_156_1:FormatText(var_159_2.content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 7 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 7)

				if (7 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 7)) > 0 and var_159_1 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082036", "story_v_out_413082.awb") ~= 0 then
					local var_159_6 = manager.audio:GetVoiceLength("story_v_out_413082", "413082036", "story_v_out_413082.awb") / 1000

					if var_159_6 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_0
					end

					if var_159_2.prefab_name ~= "" and arg_156_1.actors_[var_159_2.prefab_name] ~= nil then
						local var_159_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_2.prefab_name].transform, "story_v_out_413082", "413082036", "story_v_out_413082.awb")

						arg_156_1:RecordAudio("413082036", var_159_7)
						arg_156_1:RecordAudio("413082036", var_159_7)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_413082", "413082036", "story_v_out_413082.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_413082", "413082036", "story_v_out_413082.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_8 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_8 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_8

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_8 and arg_156_1.time_ < var_159_0 + var_159_8 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play413082037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 413082037
		arg_160_1.duration_ = 8.67

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play413082038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 2 < arg_160_1.time_ and arg_160_1.time_ <= 2 + arg_163_0 then
				local var_163_0 = arg_160_1.bgs_.F08i

				arg_160_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_163_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_1 = var_163_0:GetComponent("SpriteRenderer")

				if var_163_1 and var_163_1.sprite then
					local var_163_2 = 2 * (var_163_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_163_0.transform.localScale = Vector3.New(var_163_2 / var_163_1.sprite.bounds.size.y < var_163_2 * manager.ui.mainCameraCom_.aspect / var_163_1.sprite.bounds.size.x and var_163_2 * manager.ui.mainCameraCom_.aspect / var_163_1.sprite.bounds.size.x or var_163_2 / var_163_1.sprite.bounds.size.y, var_163_2 / var_163_1.sprite.bounds.size.y < var_163_2 * manager.ui.mainCameraCom_.aspect / var_163_1.sprite.bounds.size.x and var_163_2 * manager.ui.mainCameraCom_.aspect / var_163_1.sprite.bounds.size.x or var_163_2 / var_163_1.sprite.bounds.size.y, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "F08i" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_3 = 3.46666666666667

			if 3.46666666666667 < arg_160_1.time_ and arg_160_1.time_ <= var_163_3 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			if arg_160_1.time_ >= var_163_3 + 0.3 and arg_160_1.time_ < var_163_3 + 0.3 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_4 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_5 = 2

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_5 then
				local var_163_6 = Color.New(1, 1, 1)

				var_163_6.a = Mathf.Lerp(0, 1, (arg_160_1.time_ - var_163_4) / var_163_5)
				arg_160_1.mask_.color = var_163_6
			end

			if arg_160_1.time_ >= var_163_4 + var_163_5 and arg_160_1.time_ < var_163_4 + var_163_5 + arg_163_0 then
				local var_163_7 = Color.New(1, 1, 1)

				var_163_7.a = 1
				arg_160_1.mask_.color = var_163_7
			end

			local var_163_8 = 2

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_9 = 1.46666666666667

			if var_163_8 <= arg_160_1.time_ and arg_160_1.time_ < var_163_8 + var_163_9 then
				local var_163_10 = Color.New(1, 1, 1)

				var_163_10.a = Mathf.Lerp(1, 0, (arg_160_1.time_ - var_163_8) / var_163_9)
				arg_160_1.mask_.color = var_163_10
			end

			if arg_160_1.time_ >= var_163_8 + var_163_9 and arg_160_1.time_ < var_163_8 + var_163_9 + arg_163_0 then
				local var_163_11 = Color.New(1, 1, 1)

				arg_160_1.mask_.enabled = false
				var_163_11.a = 0
				arg_160_1.mask_.color = var_163_11
			end

			local var_163_12 = arg_160_1.actors_["10094"].transform

			if 1.966 < arg_160_1.time_ and arg_160_1.time_ <= 1.966 + arg_163_0 then
				arg_160_1.var_.moveOldPos10094 = var_163_12.localPosition
				var_163_12.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("10094", 7)

				for iter_163_2 = 0, var_163_12.childCount - 1 do
					local var_163_13 = var_163_12:GetChild(iter_163_2)

					if var_163_13.name == "" or not string.find(var_163_13.name, "split") then
						var_163_13.gameObject:SetActive(true)
					else
						var_163_13.gameObject:SetActive(false)
					end
				end
			end

			local var_163_14 = 0.001

			if 1.966 <= arg_160_1.time_ and arg_160_1.time_ < 1.966 + var_163_14 then
				var_163_12.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_160_1.time_ - 1.966) / var_163_14)
			end

			if arg_160_1.time_ >= 1.966 + var_163_14 and arg_160_1.time_ < 1.966 + var_163_14 + arg_163_0 then
				var_163_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_163_15 = arg_160_1.actors_["10094"]

			if 1.966 < arg_160_1.time_ and arg_160_1.time_ <= 1.966 + arg_163_0 and not isNil(var_163_15) and arg_160_1.var_.actorSpriteComps10094 == nil then
				arg_160_1.var_.actorSpriteComps10094 = var_163_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_16 = 0.0340000000000005

			if 1.966 <= arg_160_1.time_ and arg_160_1.time_ < 1.966 + var_163_16 and not isNil(var_163_15) then
				if arg_160_1.var_.actorSpriteComps10094 then
					for iter_163_3, iter_163_4 in pairs(arg_160_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_163_4 then
							if arg_160_1.isInRecall_ then
								iter_163_4.color = Color.New(Mathf.Lerp(iter_163_4.color.r, arg_160_1.hightColor2.r, (arg_160_1.time_ - 1.966) / var_163_16), Mathf.Lerp(iter_163_4.color.g, arg_160_1.hightColor2.g, (arg_160_1.time_ - 1.966) / var_163_16), (Mathf.Lerp(iter_163_4.color.b, arg_160_1.hightColor2.b, (arg_160_1.time_ - 1.966) / var_163_16)))
							else
								local var_163_17 = Mathf.Lerp(iter_163_4.color.r, 0.5, (arg_160_1.time_ - 1.966) / var_163_16)

								iter_163_4.color = Color.New(var_163_17, var_163_17, var_163_17)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= 1.966 + var_163_16 and arg_160_1.time_ < 1.966 + var_163_16 + arg_163_0 and not isNil(var_163_15) and arg_160_1.var_.actorSpriteComps10094 then
				for iter_163_5, iter_163_6 in pairs(arg_160_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_163_6 then
						iter_163_6.color = arg_160_1.isInRecall_ and (arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_160_1.var_.actorSpriteComps10094 = nil
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_18 = 3.66666666666667
			local var_163_19 = 1.475

			if 3.66666666666667 < arg_160_1.time_ and arg_160_1.time_ <= var_163_18 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_20 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_20:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_21 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(413082037).content)

				arg_160_1.text_.text = var_163_21

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_23 = 59 <= 0 and var_163_19 or var_163_19 * (utf8.len(var_163_21) / 59)

				if (59 <= 0 and var_163_19 or var_163_19 * (utf8.len(var_163_21) / 59)) > 0 and var_163_19 < var_163_23 then
					arg_160_1.talkMaxDuration = var_163_23
					var_163_18 = var_163_18 + 0.3

					if var_163_23 + var_163_18 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_23 + var_163_18
					end
				end

				arg_160_1.text_.text = var_163_21
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_24 = var_163_18 + 0.3
			local var_163_25 = math.max(var_163_19, arg_160_1.talkMaxDuration)

			if var_163_18 + 0.3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_24 + var_163_25 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_24) / var_163_25

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_24 + var_163_25 and arg_160_1.time_ < var_163_24 + var_163_25 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
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

		arg_160_1:InitPlayNodeList()
	end,
	Play413082038 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 413082038
		arg_166_1.duration_ = 2

		local var_166_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_166_0:Play413082039(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos10022 = arg_166_1.actors_["10022"].transform.localPosition
				arg_166_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10022", 2)

				for iter_169_0 = 0, arg_166_1.actors_["10022"].transform.childCount - 1 do
					local var_169_0 = arg_166_1.actors_["10022"].transform:GetChild(iter_169_0)

					if var_169_0.name == "split_3" or not string.find(var_169_0.name, "split") then
						var_169_0.gameObject:SetActive(true)
					else
						var_169_0.gameObject:SetActive(false)
					end
				end
			end

			local var_169_1 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_1 then
				arg_166_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_166_1.time_ - 0) / var_169_1)
			end

			if arg_166_1.time_ >= 0 + var_169_1 and arg_166_1.time_ < 0 + var_169_1 + arg_169_0 then
				arg_166_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_169_2 = arg_166_1.actors_["10022"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.actorSpriteComps10022 == nil then
				arg_166_1.var_.actorSpriteComps10022 = var_169_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_3 = 2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_3 and not isNil(var_169_2) then
				if arg_166_1.var_.actorSpriteComps10022 then
					for iter_169_1, iter_169_2 in pairs(arg_166_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_169_2 then
							if arg_166_1.isInRecall_ then
								iter_169_2.color = Color.New(Mathf.Lerp(iter_169_2.color.r, arg_166_1.hightColor1.r, (arg_166_1.time_ - 0) / var_169_3), Mathf.Lerp(iter_169_2.color.g, arg_166_1.hightColor1.g, (arg_166_1.time_ - 0) / var_169_3), (Mathf.Lerp(iter_169_2.color.b, arg_166_1.hightColor1.b, (arg_166_1.time_ - 0) / var_169_3)))
							else
								local var_169_4 = Mathf.Lerp(iter_169_2.color.r, 1, (arg_166_1.time_ - 0) / var_169_3)

								iter_169_2.color = Color.New(var_169_4, var_169_4, var_169_4)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_3 and arg_166_1.time_ < 0 + var_169_3 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.actorSpriteComps10022 then
				for iter_169_3, iter_169_4 in pairs(arg_166_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_169_4 then
						iter_169_4.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_166_1.var_.actorSpriteComps10022 = nil
			end

			local var_169_5 = 0
			local var_169_6 = 0.2

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
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

				local var_169_7 = arg_166_1:GetWordFromCfg(413082038)
				local var_169_8 = arg_166_1:FormatText(var_169_7.content)

				arg_166_1.text_.text = var_169_8

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_10 = 8 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_8) / 8)

				if (8 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_8) / 8)) > 0 and var_169_6 < var_169_10 then
					arg_166_1.talkMaxDuration = var_169_10

					if var_169_10 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_5
					end
				end

				arg_166_1.text_.text = var_169_8
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082038", "story_v_out_413082.awb") ~= 0 then
					local var_169_11 = manager.audio:GetVoiceLength("story_v_out_413082", "413082038", "story_v_out_413082.awb") / 1000

					if var_169_11 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_11 + var_169_5
					end

					if var_169_7.prefab_name ~= "" and arg_166_1.actors_[var_169_7.prefab_name] ~= nil then
						local var_169_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_7.prefab_name].transform, "story_v_out_413082", "413082038", "story_v_out_413082.awb")

						arg_166_1:RecordAudio("413082038", var_169_12)
						arg_166_1:RecordAudio("413082038", var_169_12)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_413082", "413082038", "story_v_out_413082.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_413082", "413082038", "story_v_out_413082.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_13 = math.max(var_169_6, arg_166_1.talkMaxDuration)

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_13 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_5) / var_169_13

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_5 + var_169_13 and arg_166_1.time_ < var_169_5 + var_169_13 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
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

		arg_166_1:InitPlayNodeList()
	end,
	Play413082039 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 413082039
		arg_170_1.duration_ = 5.57

		local var_170_0 = {
			zh = 5.566,
			ja = 3.733
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
				arg_170_0:Play413082040(arg_170_1)
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

			local var_173_2 = arg_170_1.actors_["10094"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos10094 = var_173_2.localPosition
				var_173_2.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("10094", 4)

				for iter_173_4 = 0, var_173_2.childCount - 1 do
					local var_173_3 = var_173_2:GetChild(iter_173_4)

					if var_173_3.name == "split_1" or not string.find(var_173_3.name, "split") then
						var_173_3.gameObject:SetActive(true)
					else
						var_173_3.gameObject:SetActive(false)
					end
				end
			end

			local var_173_4 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				var_173_2.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_170_1.time_ - 0) / var_173_4)
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				var_173_2.localPosition = Vector3.New(390, -340, -414)
			end

			local var_173_5 = arg_170_1.actors_["10094"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_5) and arg_170_1.var_.actorSpriteComps10094 == nil then
				arg_170_1.var_.actorSpriteComps10094 = var_173_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_6 = 2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_6 and not isNil(var_173_5) then
				if arg_170_1.var_.actorSpriteComps10094 then
					for iter_173_5, iter_173_6 in pairs(arg_170_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_173_6 then
							if arg_170_1.isInRecall_ then
								iter_173_6.color = Color.New(Mathf.Lerp(iter_173_6.color.r, arg_170_1.hightColor1.r, (arg_170_1.time_ - 0) / var_173_6), Mathf.Lerp(iter_173_6.color.g, arg_170_1.hightColor1.g, (arg_170_1.time_ - 0) / var_173_6), (Mathf.Lerp(iter_173_6.color.b, arg_170_1.hightColor1.b, (arg_170_1.time_ - 0) / var_173_6)))
							else
								local var_173_7 = Mathf.Lerp(iter_173_6.color.r, 1, (arg_170_1.time_ - 0) / var_173_6)

								iter_173_6.color = Color.New(var_173_7, var_173_7, var_173_7)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_6 and arg_170_1.time_ < 0 + var_173_6 + arg_173_0 and not isNil(var_173_5) and arg_170_1.var_.actorSpriteComps10094 then
				for iter_173_7, iter_173_8 in pairs(arg_170_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_173_8 then
						iter_173_8.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_170_1.var_.actorSpriteComps10094 = nil
			end

			local var_173_8 = 0
			local var_173_9 = 0.3

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_10 = arg_170_1:GetWordFromCfg(413082039)
				local var_173_11 = arg_170_1:FormatText(var_173_10.content)

				arg_170_1.text_.text = var_173_11

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_13 = 12 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_11) / 12)

				if (12 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_11) / 12)) > 0 and var_173_9 < var_173_13 then
					arg_170_1.talkMaxDuration = var_173_13

					if var_173_13 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_8
					end
				end

				arg_170_1.text_.text = var_173_11
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082039", "story_v_out_413082.awb") ~= 0 then
					local var_173_14 = manager.audio:GetVoiceLength("story_v_out_413082", "413082039", "story_v_out_413082.awb") / 1000

					if var_173_14 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_14 + var_173_8
					end

					if var_173_10.prefab_name ~= "" and arg_170_1.actors_[var_173_10.prefab_name] ~= nil then
						local var_173_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_10.prefab_name].transform, "story_v_out_413082", "413082039", "story_v_out_413082.awb")

						arg_170_1:RecordAudio("413082039", var_173_15)
						arg_170_1:RecordAudio("413082039", var_173_15)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_413082", "413082039", "story_v_out_413082.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_413082", "413082039", "story_v_out_413082.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_9, arg_170_1.talkMaxDuration)

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_8) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_8 + var_173_16 and arg_170_1.time_ < var_173_8 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play413082040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 413082040
		arg_174_1.duration_ = 2.33

		local var_174_0 = {
			zh = 1.7,
			ja = 2.333
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
				arg_174_0:Play413082041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10094 = arg_174_1.actors_["10094"].transform.localPosition
				arg_174_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10094", 4)

				for iter_177_0 = 0, arg_174_1.actors_["10094"].transform.childCount - 1 do
					local var_177_0 = arg_174_1.actors_["10094"].transform:GetChild(iter_177_0)

					if var_177_0.name == "" or not string.find(var_177_0.name, "split") then
						var_177_0.gameObject:SetActive(true)
					else
						var_177_0.gameObject:SetActive(false)
					end
				end
			end

			local var_177_1 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 then
				arg_174_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_174_1.time_ - 0) / var_177_1)
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 then
				arg_174_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_177_2 = 0
			local var_177_3 = 0.2

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_2 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_4 = arg_174_1:GetWordFromCfg(413082040)
				local var_177_5 = arg_174_1:FormatText(var_177_4.content)

				arg_174_1.text_.text = var_177_5

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_7 = 8 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 8)

				if (8 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 8)) > 0 and var_177_3 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_2
					end
				end

				arg_174_1.text_.text = var_177_5
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082040", "story_v_out_413082.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082040", "story_v_out_413082.awb") / 1000

					if var_177_8 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_2
					end

					if var_177_4.prefab_name ~= "" and arg_174_1.actors_[var_177_4.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_4.prefab_name].transform, "story_v_out_413082", "413082040", "story_v_out_413082.awb")

						arg_174_1:RecordAudio("413082040", var_177_9)
						arg_174_1:RecordAudio("413082040", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_413082", "413082040", "story_v_out_413082.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_413082", "413082040", "story_v_out_413082.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_3, arg_174_1.talkMaxDuration)

			if var_177_2 <= arg_174_1.time_ and arg_174_1.time_ < var_177_2 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_2) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_2 + var_177_10 and arg_174_1.time_ < var_177_2 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
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

		arg_174_1:InitPlayNodeList()
	end,
	Play413082041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 413082041
		arg_178_1.duration_ = 4.43

		local var_178_0 = {
			zh = 2.533,
			ja = 4.433
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play413082042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10022 = arg_178_1.actors_["10022"].transform.localPosition
				arg_178_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10022", 2)

				for iter_181_0 = 0, arg_178_1.actors_["10022"].transform.childCount - 1 do
					local var_181_0 = arg_178_1.actors_["10022"].transform:GetChild(iter_181_0)

					if var_181_0.name == "split_6" or not string.find(var_181_0.name, "split") then
						var_181_0.gameObject:SetActive(true)
					else
						var_181_0.gameObject:SetActive(false)
					end
				end
			end

			local var_181_1 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_1 then
				arg_178_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_178_1.time_ - 0) / var_181_1)
			end

			if arg_178_1.time_ >= 0 + var_181_1 and arg_178_1.time_ < 0 + var_181_1 + arg_181_0 then
				arg_178_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_181_2 = arg_178_1.actors_["10022"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.actorSpriteComps10022 == nil then
				arg_178_1.var_.actorSpriteComps10022 = var_181_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_3 = 2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_3 and not isNil(var_181_2) then
				if arg_178_1.var_.actorSpriteComps10022 then
					for iter_181_1, iter_181_2 in pairs(arg_178_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_181_2 then
							if arg_178_1.isInRecall_ then
								iter_181_2.color = Color.New(Mathf.Lerp(iter_181_2.color.r, arg_178_1.hightColor1.r, (arg_178_1.time_ - 0) / var_181_3), Mathf.Lerp(iter_181_2.color.g, arg_178_1.hightColor1.g, (arg_178_1.time_ - 0) / var_181_3), (Mathf.Lerp(iter_181_2.color.b, arg_178_1.hightColor1.b, (arg_178_1.time_ - 0) / var_181_3)))
							else
								local var_181_4 = Mathf.Lerp(iter_181_2.color.r, 1, (arg_178_1.time_ - 0) / var_181_3)

								iter_181_2.color = Color.New(var_181_4, var_181_4, var_181_4)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_3 and arg_178_1.time_ < 0 + var_181_3 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.actorSpriteComps10022 then
				for iter_181_3, iter_181_4 in pairs(arg_178_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_181_4 then
						iter_181_4.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_178_1.var_.actorSpriteComps10022 = nil
			end

			local var_181_5 = arg_178_1.actors_["10094"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_5) and arg_178_1.var_.actorSpriteComps10094 == nil then
				arg_178_1.var_.actorSpriteComps10094 = var_181_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_6 = 2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_6 and not isNil(var_181_5) then
				if arg_178_1.var_.actorSpriteComps10094 then
					for iter_181_5, iter_181_6 in pairs(arg_178_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_181_6 then
							if arg_178_1.isInRecall_ then
								iter_181_6.color = Color.New(Mathf.Lerp(iter_181_6.color.r, arg_178_1.hightColor2.r, (arg_178_1.time_ - 0) / var_181_6), Mathf.Lerp(iter_181_6.color.g, arg_178_1.hightColor2.g, (arg_178_1.time_ - 0) / var_181_6), (Mathf.Lerp(iter_181_6.color.b, arg_178_1.hightColor2.b, (arg_178_1.time_ - 0) / var_181_6)))
							else
								local var_181_7 = Mathf.Lerp(iter_181_6.color.r, 0.5, (arg_178_1.time_ - 0) / var_181_6)

								iter_181_6.color = Color.New(var_181_7, var_181_7, var_181_7)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_6 and arg_178_1.time_ < 0 + var_181_6 + arg_181_0 and not isNil(var_181_5) and arg_178_1.var_.actorSpriteComps10094 then
				for iter_181_7, iter_181_8 in pairs(arg_178_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_181_8 then
						iter_181_8.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_178_1.var_.actorSpriteComps10094 = nil
			end

			local var_181_8 = 0
			local var_181_9 = 0.2

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_8 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_10 = arg_178_1:GetWordFromCfg(413082041)
				local var_181_11 = arg_178_1:FormatText(var_181_10.content)

				arg_178_1.text_.text = var_181_11

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_13 = 8 <= 0 and var_181_9 or var_181_9 * (utf8.len(var_181_11) / 8)

				if (8 <= 0 and var_181_9 or var_181_9 * (utf8.len(var_181_11) / 8)) > 0 and var_181_9 < var_181_13 then
					arg_178_1.talkMaxDuration = var_181_13

					if var_181_13 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_13 + var_181_8
					end
				end

				arg_178_1.text_.text = var_181_11
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082041", "story_v_out_413082.awb") ~= 0 then
					local var_181_14 = manager.audio:GetVoiceLength("story_v_out_413082", "413082041", "story_v_out_413082.awb") / 1000

					if var_181_14 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_14 + var_181_8
					end

					if var_181_10.prefab_name ~= "" and arg_178_1.actors_[var_181_10.prefab_name] ~= nil then
						local var_181_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_10.prefab_name].transform, "story_v_out_413082", "413082041", "story_v_out_413082.awb")

						arg_178_1:RecordAudio("413082041", var_181_15)
						arg_178_1:RecordAudio("413082041", var_181_15)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_413082", "413082041", "story_v_out_413082.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_413082", "413082041", "story_v_out_413082.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_16 = math.max(var_181_9, arg_178_1.talkMaxDuration)

			if var_181_8 <= arg_178_1.time_ and arg_178_1.time_ < var_181_8 + var_181_16 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_8) / var_181_16

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_8 + var_181_16 and arg_178_1.time_ < var_181_8 + var_181_16 + arg_181_0 then
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
	Play413082042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 413082042
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play413082043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["10022"]) and arg_182_1.var_.actorSpriteComps10022 == nil then
				arg_182_1.var_.actorSpriteComps10022 = arg_182_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_0 = 2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["10022"]) then
				if arg_182_1.var_.actorSpriteComps10022 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								iter_185_1.color = Color.New(Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor2.r, (arg_182_1.time_ - 0) / var_185_0), Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor2.g, (arg_182_1.time_ - 0) / var_185_0), (Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor2.b, (arg_182_1.time_ - 0) / var_185_0)))
							else
								local var_185_1 = Mathf.Lerp(iter_185_1.color.r, 0.5, (arg_182_1.time_ - 0) / var_185_0)

								iter_185_1.color = Color.New(var_185_1, var_185_1, var_185_1)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["10022"]) and arg_182_1.var_.actorSpriteComps10022 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_185_3 then
						iter_185_3.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_182_1.var_.actorSpriteComps10022 = nil
			end

			local var_185_2 = 0
			local var_185_3 = 1.7

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_4 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(413082042).content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_6 = 68 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_4) / 68)

				if (68 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_4) / 68)) > 0 and var_185_3 < var_185_6 then
					arg_182_1.talkMaxDuration = var_185_6

					if var_185_6 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_6 + var_185_2
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_3, arg_182_1.talkMaxDuration)

			if var_185_2 <= arg_182_1.time_ and arg_182_1.time_ < var_185_2 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_2) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_2 + var_185_7 and arg_182_1.time_ < var_185_2 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play413082043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 413082043
		arg_186_1.duration_ = 5.3

		local var_186_0 = {
			zh = 5.3,
			ja = 3.8
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
				arg_186_0:Play413082044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10022 = arg_186_1.actors_["10022"].transform.localPosition
				arg_186_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("10022", 2)

				for iter_189_0 = 0, arg_186_1.actors_["10022"].transform.childCount - 1 do
					local var_189_0 = arg_186_1.actors_["10022"].transform:GetChild(iter_189_0)

					if var_189_0.name == "split_3" or not string.find(var_189_0.name, "split") then
						var_189_0.gameObject:SetActive(true)
					else
						var_189_0.gameObject:SetActive(false)
					end
				end
			end

			local var_189_1 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_1 then
				arg_186_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_186_1.time_ - 0) / var_189_1)
			end

			if arg_186_1.time_ >= 0 + var_189_1 and arg_186_1.time_ < 0 + var_189_1 + arg_189_0 then
				arg_186_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_189_2 = arg_186_1.actors_["10022"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.actorSpriteComps10022 == nil then
				arg_186_1.var_.actorSpriteComps10022 = var_189_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_3 = 2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_3 and not isNil(var_189_2) then
				if arg_186_1.var_.actorSpriteComps10022 then
					for iter_189_1, iter_189_2 in pairs(arg_186_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_189_2 then
							if arg_186_1.isInRecall_ then
								iter_189_2.color = Color.New(Mathf.Lerp(iter_189_2.color.r, arg_186_1.hightColor1.r, (arg_186_1.time_ - 0) / var_189_3), Mathf.Lerp(iter_189_2.color.g, arg_186_1.hightColor1.g, (arg_186_1.time_ - 0) / var_189_3), (Mathf.Lerp(iter_189_2.color.b, arg_186_1.hightColor1.b, (arg_186_1.time_ - 0) / var_189_3)))
							else
								local var_189_4 = Mathf.Lerp(iter_189_2.color.r, 1, (arg_186_1.time_ - 0) / var_189_3)

								iter_189_2.color = Color.New(var_189_4, var_189_4, var_189_4)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_3 and arg_186_1.time_ < 0 + var_189_3 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.actorSpriteComps10022 then
				for iter_189_3, iter_189_4 in pairs(arg_186_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_189_4 then
						iter_189_4.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_186_1.var_.actorSpriteComps10022 = nil
			end

			local var_189_5 = 0
			local var_189_6 = 0.625

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_7 = arg_186_1:GetWordFromCfg(413082043)
				local var_189_8 = arg_186_1:FormatText(var_189_7.content)

				arg_186_1.text_.text = var_189_8

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_10 = 25 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_8) / 25)

				if (25 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_8) / 25)) > 0 and var_189_6 < var_189_10 then
					arg_186_1.talkMaxDuration = var_189_10

					if var_189_10 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_5
					end
				end

				arg_186_1.text_.text = var_189_8
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082043", "story_v_out_413082.awb") ~= 0 then
					local var_189_11 = manager.audio:GetVoiceLength("story_v_out_413082", "413082043", "story_v_out_413082.awb") / 1000

					if var_189_11 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_11 + var_189_5
					end

					if var_189_7.prefab_name ~= "" and arg_186_1.actors_[var_189_7.prefab_name] ~= nil then
						local var_189_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_7.prefab_name].transform, "story_v_out_413082", "413082043", "story_v_out_413082.awb")

						arg_186_1:RecordAudio("413082043", var_189_12)
						arg_186_1:RecordAudio("413082043", var_189_12)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_413082", "413082043", "story_v_out_413082.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_413082", "413082043", "story_v_out_413082.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_13 = math.max(var_189_6, arg_186_1.talkMaxDuration)

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_13 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_5) / var_189_13

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_5 + var_189_13 and arg_186_1.time_ < var_189_5 + var_189_13 + arg_189_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play413082044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 413082044
		arg_190_1.duration_ = 7.71

		local var_190_0 = {
			zh = 7.708,
			ja = 5.675
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play413082045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos10022 = arg_190_1.actors_["10022"].transform.localPosition
				arg_190_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("10022", 0)

				for iter_193_0 = 0, arg_190_1.actors_["10022"].transform.childCount - 1 do
					local var_193_0 = arg_190_1.actors_["10022"].transform:GetChild(iter_193_0)

					if var_193_0.name == "" or not string.find(var_193_0.name, "split") then
						var_193_0.gameObject:SetActive(true)
					else
						var_193_0.gameObject:SetActive(false)
					end
				end
			end

			local var_193_1 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_1 then
				arg_190_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_190_1.time_ - 0) / var_193_1)
			end

			if arg_190_1.time_ >= 0 + var_193_1 and arg_190_1.time_ < 0 + var_193_1 + arg_193_0 then
				arg_190_1.actors_["10022"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_193_2 = "10092"

			if arg_190_1.actors_["10092"] == nil then
				local var_193_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_193_3) then
					local var_193_4 = Object.Instantiate(var_193_3, arg_190_1.canvasGo_.transform)

					var_193_4.transform:SetSiblingIndex(1)

					var_193_4.name = var_193_2
					var_193_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_190_1.actors_[var_193_2] = var_193_4

					if arg_190_1.isInRecall_ then
						for iter_193_1, iter_193_2 in ipairs((var_193_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_193_2.color = arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_193_5 = arg_190_1.actors_["10092"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos10092 = var_193_5.localPosition
				var_193_5.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("10092", 0)

				for iter_193_3 = 0, var_193_5.childCount - 1 do
					local var_193_6 = var_193_5:GetChild(iter_193_3)

					if var_193_6.name == "" or not string.find(var_193_6.name, "split") then
						var_193_6.gameObject:SetActive(true)
					else
						var_193_6.gameObject:SetActive(false)
					end
				end
			end

			local var_193_7 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_7 then
				var_193_5.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10092, Vector3.New(-1500, -350, -180), (arg_190_1.time_ - 0) / var_193_7)
			end

			if arg_190_1.time_ >= 0 + var_193_7 and arg_190_1.time_ < 0 + var_193_7 + arg_193_0 then
				var_193_5.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_193_8 = arg_190_1.actors_["10094"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos10094 = var_193_8.localPosition
				var_193_8.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("10094", 3)

				for iter_193_4 = 0, var_193_8.childCount - 1 do
					local var_193_9 = var_193_8:GetChild(iter_193_4)

					if var_193_9.name == "" or not string.find(var_193_9.name, "split") then
						var_193_9.gameObject:SetActive(true)
					else
						var_193_9.gameObject:SetActive(false)
					end
				end
			end

			local var_193_10 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_10 then
				var_193_8.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_190_1.time_ - 0) / var_193_10)
			end

			if arg_190_1.time_ >= 0 + var_193_10 and arg_190_1.time_ < 0 + var_193_10 + arg_193_0 then
				var_193_8.localPosition = Vector3.New(0, -340, -414)
			end

			local var_193_11 = arg_190_1.actors_["10022"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_11) and arg_190_1.var_.actorSpriteComps10022 == nil then
				arg_190_1.var_.actorSpriteComps10022 = var_193_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_12 = 2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_12 and not isNil(var_193_11) then
				if arg_190_1.var_.actorSpriteComps10022 then
					for iter_193_5, iter_193_6 in pairs(arg_190_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_193_6 then
							if arg_190_1.isInRecall_ then
								iter_193_6.color = Color.New(Mathf.Lerp(iter_193_6.color.r, arg_190_1.hightColor2.r, (arg_190_1.time_ - 0) / var_193_12), Mathf.Lerp(iter_193_6.color.g, arg_190_1.hightColor2.g, (arg_190_1.time_ - 0) / var_193_12), (Mathf.Lerp(iter_193_6.color.b, arg_190_1.hightColor2.b, (arg_190_1.time_ - 0) / var_193_12)))
							else
								local var_193_13 = Mathf.Lerp(iter_193_6.color.r, 0.5, (arg_190_1.time_ - 0) / var_193_12)

								iter_193_6.color = Color.New(var_193_13, var_193_13, var_193_13)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_12 and arg_190_1.time_ < 0 + var_193_12 + arg_193_0 and not isNil(var_193_11) and arg_190_1.var_.actorSpriteComps10022 then
				for iter_193_7, iter_193_8 in pairs(arg_190_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_193_8 then
						iter_193_8.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_190_1.var_.actorSpriteComps10022 = nil
			end

			local var_193_14 = arg_190_1.actors_["10092"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_14) and arg_190_1.var_.actorSpriteComps10092 == nil then
				arg_190_1.var_.actorSpriteComps10092 = var_193_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_15 = 2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_15 and not isNil(var_193_14) then
				if arg_190_1.var_.actorSpriteComps10092 then
					for iter_193_9, iter_193_10 in pairs(arg_190_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_193_10 then
							if arg_190_1.isInRecall_ then
								iter_193_10.color = Color.New(Mathf.Lerp(iter_193_10.color.r, arg_190_1.hightColor2.r, (arg_190_1.time_ - 0) / var_193_15), Mathf.Lerp(iter_193_10.color.g, arg_190_1.hightColor2.g, (arg_190_1.time_ - 0) / var_193_15), (Mathf.Lerp(iter_193_10.color.b, arg_190_1.hightColor2.b, (arg_190_1.time_ - 0) / var_193_15)))
							else
								local var_193_16 = Mathf.Lerp(iter_193_10.color.r, 0.5, (arg_190_1.time_ - 0) / var_193_15)

								iter_193_10.color = Color.New(var_193_16, var_193_16, var_193_16)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_15 and arg_190_1.time_ < 0 + var_193_15 + arg_193_0 and not isNil(var_193_14) and arg_190_1.var_.actorSpriteComps10092 then
				for iter_193_11, iter_193_12 in pairs(arg_190_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_193_12 then
						iter_193_12.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_190_1.var_.actorSpriteComps10092 = nil
			end

			local var_193_17 = arg_190_1.actors_["10094"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_17) and arg_190_1.var_.actorSpriteComps10094 == nil then
				arg_190_1.var_.actorSpriteComps10094 = var_193_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_18 = 2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_18 and not isNil(var_193_17) then
				if arg_190_1.var_.actorSpriteComps10094 then
					for iter_193_13, iter_193_14 in pairs(arg_190_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_193_14 then
							if arg_190_1.isInRecall_ then
								iter_193_14.color = Color.New(Mathf.Lerp(iter_193_14.color.r, arg_190_1.hightColor1.r, (arg_190_1.time_ - 0) / var_193_18), Mathf.Lerp(iter_193_14.color.g, arg_190_1.hightColor1.g, (arg_190_1.time_ - 0) / var_193_18), (Mathf.Lerp(iter_193_14.color.b, arg_190_1.hightColor1.b, (arg_190_1.time_ - 0) / var_193_18)))
							else
								local var_193_19 = Mathf.Lerp(iter_193_14.color.r, 1, (arg_190_1.time_ - 0) / var_193_18)

								iter_193_14.color = Color.New(var_193_19, var_193_19, var_193_19)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_18 and arg_190_1.time_ < 0 + var_193_18 + arg_193_0 and not isNil(var_193_17) and arg_190_1.var_.actorSpriteComps10094 then
				for iter_193_15, iter_193_16 in pairs(arg_190_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_193_16 then
						iter_193_16.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_190_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				local var_193_20 = arg_190_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_193_20 then
					arg_190_1.var_.alphaOldValue10094 = var_193_20.alpha
					arg_190_1.var_.characterEffect10094 = var_193_20
				end

				arg_190_1.var_.alphaOldValue10094 = 0
			end

			local var_193_21 = 0.5

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_21 then
				if arg_190_1.var_.characterEffect10094 then
					arg_190_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_190_1.var_.alphaOldValue10094, 1, (arg_190_1.time_ - 0) / var_193_21)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_21 and arg_190_1.time_ < 0 + var_193_21 + arg_193_0 and arg_190_1.var_.characterEffect10094 then
				arg_190_1.var_.characterEffect10094.alpha = 1
			end

			if arg_190_1.frameCnt_ <= 1 then
				arg_190_1.dialog_:SetActive(false)
			end

			local var_193_22 = 0.275
			local var_193_23 = 0.725

			if 0.275 < arg_190_1.time_ and arg_190_1.time_ <= var_193_22 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0

				arg_190_1.dialog_:SetActive(true)

				arg_190_1.dialogCg_.alpha = 0

				local var_193_24 = LeanTween.value(arg_190_1.dialog_, 0, 1, 0.3)

				var_193_24:setOnUpdate(LuaHelper.FloatAction(function(arg_194_0)
					arg_190_1.dialogCg_.alpha = arg_194_0
				end))
				var_193_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_190_1.dialog_)
					var_193_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_190_1.duration_ = arg_190_1.duration_ + 0.3

				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_25 = arg_190_1:GetWordFromCfg(413082044)
				local var_193_26 = arg_190_1:FormatText(var_193_25.content)

				arg_190_1.text_.text = var_193_26

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_28 = 29 <= 0 and var_193_23 or var_193_23 * (utf8.len(var_193_26) / 29)

				if (29 <= 0 and var_193_23 or var_193_23 * (utf8.len(var_193_26) / 29)) > 0 and var_193_23 < var_193_28 then
					arg_190_1.talkMaxDuration = var_193_28
					var_193_22 = var_193_22 + 0.3

					if var_193_28 + var_193_22 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_28 + var_193_22
					end
				end

				arg_190_1.text_.text = var_193_26
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082044", "story_v_out_413082.awb") ~= 0 then
					local var_193_29 = manager.audio:GetVoiceLength("story_v_out_413082", "413082044", "story_v_out_413082.awb") / 1000

					if var_193_29 + var_193_22 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_29 + var_193_22
					end

					if var_193_25.prefab_name ~= "" and arg_190_1.actors_[var_193_25.prefab_name] ~= nil then
						local var_193_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_25.prefab_name].transform, "story_v_out_413082", "413082044", "story_v_out_413082.awb")

						arg_190_1:RecordAudio("413082044", var_193_30)
						arg_190_1:RecordAudio("413082044", var_193_30)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_413082", "413082044", "story_v_out_413082.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_413082", "413082044", "story_v_out_413082.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_31 = var_193_22 + 0.3
			local var_193_32 = math.max(var_193_23, arg_190_1.talkMaxDuration)

			if var_193_22 + 0.3 <= arg_190_1.time_ and arg_190_1.time_ < var_193_31 + var_193_32 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_31) / var_193_32

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_31 + var_193_32 and arg_190_1.time_ < var_193_31 + var_193_32 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
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

		arg_190_1:InitPlayNodeList()
	end,
	Play413082045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 413082045
		arg_196_1.duration_ = 10.5

		local var_196_0 = {
			zh = 5.466,
			ja = 10.5
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
				arg_196_0:Play413082046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.625

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_1 = arg_196_1:GetWordFromCfg(413082045)
				local var_199_2 = arg_196_1:FormatText(var_199_1.content)

				arg_196_1.text_.text = var_199_2

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 25 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 25)

				if (25 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 25)) > 0 and var_199_0 < var_199_4 then
					arg_196_1.talkMaxDuration = var_199_4

					if var_199_4 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_4 + 0
					end
				end

				arg_196_1.text_.text = var_199_2
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082045", "story_v_out_413082.awb") ~= 0 then
					local var_199_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082045", "story_v_out_413082.awb") / 1000

					if var_199_5 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + 0
					end

					if var_199_1.prefab_name ~= "" and arg_196_1.actors_[var_199_1.prefab_name] ~= nil then
						local var_199_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_1.prefab_name].transform, "story_v_out_413082", "413082045", "story_v_out_413082.awb")

						arg_196_1:RecordAudio("413082045", var_199_6)
						arg_196_1:RecordAudio("413082045", var_199_6)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_413082", "413082045", "story_v_out_413082.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_413082", "413082045", "story_v_out_413082.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play413082046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 413082046
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play413082047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos10094 = arg_200_1.actors_["10094"].transform.localPosition
				arg_200_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10094", 7)

				for iter_203_0 = 0, arg_200_1.actors_["10094"].transform.childCount - 1 do
					local var_203_0 = arg_200_1.actors_["10094"].transform:GetChild(iter_203_0)

					if var_203_0.name == "" or not string.find(var_203_0.name, "split") then
						var_203_0.gameObject:SetActive(true)
					else
						var_203_0.gameObject:SetActive(false)
					end
				end
			end

			local var_203_1 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_1 then
				arg_200_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_200_1.time_ - 0) / var_203_1)
			end

			if arg_200_1.time_ >= 0 + var_203_1 and arg_200_1.time_ < 0 + var_203_1 + arg_203_0 then
				arg_200_1.actors_["10094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_2 = arg_200_1.actors_["10094"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10094 == nil then
				arg_200_1.var_.actorSpriteComps10094 = var_203_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_3 = 2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.actorSpriteComps10094 then
					for iter_203_1, iter_203_2 in pairs(arg_200_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_203_2 then
							if arg_200_1.isInRecall_ then
								iter_203_2.color = Color.New(Mathf.Lerp(iter_203_2.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_3), Mathf.Lerp(iter_203_2.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_3), (Mathf.Lerp(iter_203_2.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_3)))
							else
								local var_203_4 = Mathf.Lerp(iter_203_2.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_3)

								iter_203_2.color = Color.New(var_203_4, var_203_4, var_203_4)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10094 then
				for iter_203_3, iter_203_4 in pairs(arg_200_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_203_4 then
						iter_203_4.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10094 = nil
			end

			local var_203_5 = 0
			local var_203_6 = 1.675

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_7 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(413082046).content)

				arg_200_1.text_.text = var_203_7

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_9 = 67 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_7) / 67)

				if (67 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_7) / 67)) > 0 and var_203_6 < var_203_9 then
					arg_200_1.talkMaxDuration = var_203_9

					if var_203_9 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_9 + var_203_5
					end
				end

				arg_200_1.text_.text = var_203_7
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_10 = math.max(var_203_6, arg_200_1.talkMaxDuration)

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_10 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_5) / var_203_10

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_5 + var_203_10 and arg_200_1.time_ < var_203_5 + var_203_10 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
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

		arg_200_1:InitPlayNodeList()
	end,
	Play413082047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 413082047
		arg_204_1.duration_ = 2.87

		local var_204_0 = {
			zh = 2.866,
			ja = 2.633
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
				arg_204_0:Play413082048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10022 = arg_204_1.actors_["10022"].transform.localPosition
				arg_204_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10022", 3)

				for iter_207_0 = 0, arg_204_1.actors_["10022"].transform.childCount - 1 do
					local var_207_0 = arg_204_1.actors_["10022"].transform:GetChild(iter_207_0)

					if var_207_0.name == "split_8" or not string.find(var_207_0.name, "split") then
						var_207_0.gameObject:SetActive(true)
					else
						var_207_0.gameObject:SetActive(false)
					end
				end
			end

			local var_207_1 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_1 then
				arg_204_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_204_1.time_ - 0) / var_207_1)
			end

			if arg_204_1.time_ >= 0 + var_207_1 and arg_204_1.time_ < 0 + var_207_1 + arg_207_0 then
				arg_204_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_207_2 = arg_204_1.actors_["10022"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps10022 == nil then
				arg_204_1.var_.actorSpriteComps10022 = var_207_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_3 = 2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.actorSpriteComps10022 then
					for iter_207_1, iter_207_2 in pairs(arg_204_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_207_2 then
							if arg_204_1.isInRecall_ then
								iter_207_2.color = Color.New(Mathf.Lerp(iter_207_2.color.r, arg_204_1.hightColor1.r, (arg_204_1.time_ - 0) / var_207_3), Mathf.Lerp(iter_207_2.color.g, arg_204_1.hightColor1.g, (arg_204_1.time_ - 0) / var_207_3), (Mathf.Lerp(iter_207_2.color.b, arg_204_1.hightColor1.b, (arg_204_1.time_ - 0) / var_207_3)))
							else
								local var_207_4 = Mathf.Lerp(iter_207_2.color.r, 1, (arg_204_1.time_ - 0) / var_207_3)

								iter_207_2.color = Color.New(var_207_4, var_207_4, var_207_4)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps10022 then
				for iter_207_3, iter_207_4 in pairs(arg_204_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_207_4 then
						iter_207_4.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
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

				local var_207_7 = arg_204_1:GetWordFromCfg(413082047)
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

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082047", "story_v_out_413082.awb") ~= 0 then
					local var_207_11 = manager.audio:GetVoiceLength("story_v_out_413082", "413082047", "story_v_out_413082.awb") / 1000

					if var_207_11 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_11 + var_207_5
					end

					if var_207_7.prefab_name ~= "" and arg_204_1.actors_[var_207_7.prefab_name] ~= nil then
						local var_207_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_7.prefab_name].transform, "story_v_out_413082", "413082047", "story_v_out_413082.awb")

						arg_204_1:RecordAudio("413082047", var_207_12)
						arg_204_1:RecordAudio("413082047", var_207_12)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_413082", "413082047", "story_v_out_413082.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_413082", "413082047", "story_v_out_413082.awb")
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

		arg_204_1.nodeConfigList_ = {
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

		arg_204_1:InitPlayNodeList()
	end,
	Play413082048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 413082048
		arg_208_1.duration_ = 6.9

		local var_208_0 = {
			zh = 4.1,
			ja = 6.9
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
				arg_208_0:Play413082049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["10022"]) and arg_208_1.var_.actorSpriteComps10022 == nil then
				arg_208_1.var_.actorSpriteComps10022 = arg_208_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_0 = 2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["10022"]) then
				if arg_208_1.var_.actorSpriteComps10022 then
					for iter_211_0, iter_211_1 in pairs(arg_208_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_211_1 then
							if arg_208_1.isInRecall_ then
								iter_211_1.color = Color.New(Mathf.Lerp(iter_211_1.color.r, arg_208_1.hightColor2.r, (arg_208_1.time_ - 0) / var_211_0), Mathf.Lerp(iter_211_1.color.g, arg_208_1.hightColor2.g, (arg_208_1.time_ - 0) / var_211_0), (Mathf.Lerp(iter_211_1.color.b, arg_208_1.hightColor2.b, (arg_208_1.time_ - 0) / var_211_0)))
							else
								local var_211_1 = Mathf.Lerp(iter_211_1.color.r, 0.5, (arg_208_1.time_ - 0) / var_211_0)

								iter_211_1.color = Color.New(var_211_1, var_211_1, var_211_1)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["10022"]) and arg_208_1.var_.actorSpriteComps10022 then
				for iter_211_2, iter_211_3 in pairs(arg_208_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_211_3 then
						iter_211_3.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_208_1.var_.actorSpriteComps10022 = nil
			end

			local var_211_2 = 0
			local var_211_3 = 0.525

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_2 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_208_1.callingController_:SetSelectedState("calling")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_4 = arg_208_1:GetWordFromCfg(413082048)
				local var_211_5 = arg_208_1:FormatText(var_211_4.content)

				arg_208_1.text_.text = var_211_5

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_7 = 21 <= 0 and var_211_3 or var_211_3 * (utf8.len(var_211_5) / 21)

				if (21 <= 0 and var_211_3 or var_211_3 * (utf8.len(var_211_5) / 21)) > 0 and var_211_3 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_2
					end
				end

				arg_208_1.text_.text = var_211_5
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082048", "story_v_out_413082.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082048", "story_v_out_413082.awb") / 1000

					if var_211_8 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_2
					end

					if var_211_4.prefab_name ~= "" and arg_208_1.actors_[var_211_4.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_4.prefab_name].transform, "story_v_out_413082", "413082048", "story_v_out_413082.awb")

						arg_208_1:RecordAudio("413082048", var_211_9)
						arg_208_1:RecordAudio("413082048", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_413082", "413082048", "story_v_out_413082.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_413082", "413082048", "story_v_out_413082.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_3, arg_208_1.talkMaxDuration)

			if var_211_2 <= arg_208_1.time_ and arg_208_1.time_ < var_211_2 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_2) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_2 + var_211_10 and arg_208_1.time_ < var_211_2 + var_211_10 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play413082049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 413082049
		arg_212_1.duration_ = 8.8

		local var_212_0 = {
			zh = 3.8,
			ja = 8.8
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
				arg_212_0:Play413082050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0.575

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_212_1.callingController_:SetSelectedState("calling")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_1 = arg_212_1:GetWordFromCfg(413082049)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 23 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 23)

				if (23 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 23)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082049", "story_v_out_413082.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082049", "story_v_out_413082.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_413082", "413082049", "story_v_out_413082.awb")

						arg_212_1:RecordAudio("413082049", var_215_6)
						arg_212_1:RecordAudio("413082049", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_413082", "413082049", "story_v_out_413082.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_413082", "413082049", "story_v_out_413082.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play413082050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 413082050
		arg_216_1.duration_ = 3.67

		local var_216_0 = {
			zh = 2.6,
			ja = 3.666
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
				arg_216_0:Play413082051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["10022"]) and arg_216_1.var_.actorSpriteComps10022 == nil then
				arg_216_1.var_.actorSpriteComps10022 = arg_216_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_0 = 2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["10022"]) then
				if arg_216_1.var_.actorSpriteComps10022 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								iter_219_1.color = Color.New(Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor1.r, (arg_216_1.time_ - 0) / var_219_0), Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor1.g, (arg_216_1.time_ - 0) / var_219_0), (Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor1.b, (arg_216_1.time_ - 0) / var_219_0)))
							else
								local var_219_1 = Mathf.Lerp(iter_219_1.color.r, 1, (arg_216_1.time_ - 0) / var_219_0)

								iter_219_1.color = Color.New(var_219_1, var_219_1, var_219_1)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["10022"]) and arg_216_1.var_.actorSpriteComps10022 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_219_3 then
						iter_219_3.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_216_1.var_.actorSpriteComps10022 = nil
			end

			local var_219_2 = 0
			local var_219_3 = 0.375

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_2 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_4 = arg_216_1:GetWordFromCfg(413082050)
				local var_219_5 = arg_216_1:FormatText(var_219_4.content)

				arg_216_1.text_.text = var_219_5

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_7 = 15 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_5) / 15)

				if (15 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_5) / 15)) > 0 and var_219_3 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_2
					end
				end

				arg_216_1.text_.text = var_219_5
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082050", "story_v_out_413082.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082050", "story_v_out_413082.awb") / 1000

					if var_219_8 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_2
					end

					if var_219_4.prefab_name ~= "" and arg_216_1.actors_[var_219_4.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_4.prefab_name].transform, "story_v_out_413082", "413082050", "story_v_out_413082.awb")

						arg_216_1:RecordAudio("413082050", var_219_9)
						arg_216_1:RecordAudio("413082050", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_413082", "413082050", "story_v_out_413082.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_413082", "413082050", "story_v_out_413082.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_3, arg_216_1.talkMaxDuration)

			if var_219_2 <= arg_216_1.time_ and arg_216_1.time_ < var_219_2 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_2) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_2 + var_219_10 and arg_216_1.time_ < var_219_2 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play413082051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 413082051
		arg_220_1.duration_ = 10.7

		local var_220_0 = {
			zh = 5.366,
			ja = 10.7
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
				arg_220_0:Play413082052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["10022"]) and arg_220_1.var_.actorSpriteComps10022 == nil then
				arg_220_1.var_.actorSpriteComps10022 = arg_220_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_0 = 2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["10022"]) then
				if arg_220_1.var_.actorSpriteComps10022 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["10022"]) and arg_220_1.var_.actorSpriteComps10022 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_223_3 then
						iter_223_3.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_220_1.var_.actorSpriteComps10022 = nil
			end

			local var_223_2 = 0
			local var_223_3 = 0.775

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_2 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_220_1.callingController_:SetSelectedState("calling")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_4 = arg_220_1:GetWordFromCfg(413082051)
				local var_223_5 = arg_220_1:FormatText(var_223_4.content)

				arg_220_1.text_.text = var_223_5

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_7 = 31 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 31)

				if (31 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 31)) > 0 and var_223_3 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_2
					end
				end

				arg_220_1.text_.text = var_223_5
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082051", "story_v_out_413082.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_out_413082", "413082051", "story_v_out_413082.awb") / 1000

					if var_223_8 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_2
					end

					if var_223_4.prefab_name ~= "" and arg_220_1.actors_[var_223_4.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_4.prefab_name].transform, "story_v_out_413082", "413082051", "story_v_out_413082.awb")

						arg_220_1:RecordAudio("413082051", var_223_9)
						arg_220_1:RecordAudio("413082051", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_413082", "413082051", "story_v_out_413082.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_413082", "413082051", "story_v_out_413082.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_3, arg_220_1.talkMaxDuration)

			if var_223_2 <= arg_220_1.time_ and arg_220_1.time_ < var_223_2 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_2) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_2 + var_223_10 and arg_220_1.time_ < var_223_2 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play413082052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 413082052
		arg_224_1.duration_ = 11.57

		local var_224_0 = {
			zh = 5.033,
			ja = 11.566
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
				arg_224_0:Play413082053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0.75

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_224_1.callingController_:SetSelectedState("calling")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_1 = arg_224_1:GetWordFromCfg(413082052)
				local var_227_2 = arg_224_1:FormatText(var_227_1.content)

				arg_224_1.text_.text = var_227_2

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 30 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 30)

				if (30 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 30)) > 0 and var_227_0 < var_227_4 then
					arg_224_1.talkMaxDuration = var_227_4

					if var_227_4 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_4 + 0
					end
				end

				arg_224_1.text_.text = var_227_2
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082052", "story_v_out_413082.awb") ~= 0 then
					local var_227_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082052", "story_v_out_413082.awb") / 1000

					if var_227_5 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + 0
					end

					if var_227_1.prefab_name ~= "" and arg_224_1.actors_[var_227_1.prefab_name] ~= nil then
						local var_227_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_1.prefab_name].transform, "story_v_out_413082", "413082052", "story_v_out_413082.awb")

						arg_224_1:RecordAudio("413082052", var_227_6)
						arg_224_1:RecordAudio("413082052", var_227_6)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_413082", "413082052", "story_v_out_413082.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_413082", "413082052", "story_v_out_413082.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_7 and arg_224_1.time_ < 0 + var_227_7 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play413082053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 413082053
		arg_228_1.duration_ = 5.43

		local var_228_0 = {
			zh = 5.166,
			ja = 5.433
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
				arg_228_0:Play413082054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos10022 = arg_228_1.actors_["10022"].transform.localPosition
				arg_228_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10022", 0)

				for iter_231_0 = 0, arg_228_1.actors_["10022"].transform.childCount - 1 do
					local var_231_0 = arg_228_1.actors_["10022"].transform:GetChild(iter_231_0)

					if var_231_0.name == "" or not string.find(var_231_0.name, "split") then
						var_231_0.gameObject:SetActive(true)
					else
						var_231_0.gameObject:SetActive(false)
					end
				end
			end

			local var_231_1 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_1 then
				arg_228_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_228_1.time_ - 0) / var_231_1)
			end

			if arg_228_1.time_ >= 0 + var_231_1 and arg_228_1.time_ < 0 + var_231_1 + arg_231_0 then
				arg_228_1.actors_["10022"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_231_2 = arg_228_1.actors_["10092"].transform

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos10092 = var_231_2.localPosition
				var_231_2.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10092", 0)

				for iter_231_1 = 0, var_231_2.childCount - 1 do
					local var_231_3 = var_231_2:GetChild(iter_231_1)

					if var_231_3.name == "" or not string.find(var_231_3.name, "split") then
						var_231_3.gameObject:SetActive(true)
					else
						var_231_3.gameObject:SetActive(false)
					end
				end
			end

			local var_231_4 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				var_231_2.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10092, Vector3.New(-1500, -350, -180), (arg_228_1.time_ - 0) / var_231_4)
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				var_231_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_231_5 = arg_228_1.actors_["10094"].transform

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos10094 = var_231_5.localPosition
				var_231_5.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10094", 3)

				for iter_231_2 = 0, var_231_5.childCount - 1 do
					local var_231_6 = var_231_5:GetChild(iter_231_2)

					if var_231_6.name == "split_2" or not string.find(var_231_6.name, "split") then
						var_231_6.gameObject:SetActive(true)
					else
						var_231_6.gameObject:SetActive(false)
					end
				end
			end

			local var_231_7 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 then
				var_231_5.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_228_1.time_ - 0) / var_231_7)
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 then
				var_231_5.localPosition = Vector3.New(0, -340, -414)
			end

			local var_231_8 = arg_228_1.actors_["10022"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_8) and arg_228_1.var_.actorSpriteComps10022 == nil then
				arg_228_1.var_.actorSpriteComps10022 = var_231_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_9 = 2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_9 and not isNil(var_231_8) then
				if arg_228_1.var_.actorSpriteComps10022 then
					for iter_231_3, iter_231_4 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_231_4 then
							if arg_228_1.isInRecall_ then
								iter_231_4.color = Color.New(Mathf.Lerp(iter_231_4.color.r, arg_228_1.hightColor2.r, (arg_228_1.time_ - 0) / var_231_9), Mathf.Lerp(iter_231_4.color.g, arg_228_1.hightColor2.g, (arg_228_1.time_ - 0) / var_231_9), (Mathf.Lerp(iter_231_4.color.b, arg_228_1.hightColor2.b, (arg_228_1.time_ - 0) / var_231_9)))
							else
								local var_231_10 = Mathf.Lerp(iter_231_4.color.r, 0.5, (arg_228_1.time_ - 0) / var_231_9)

								iter_231_4.color = Color.New(var_231_10, var_231_10, var_231_10)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_9 and arg_228_1.time_ < 0 + var_231_9 + arg_231_0 and not isNil(var_231_8) and arg_228_1.var_.actorSpriteComps10022 then
				for iter_231_5, iter_231_6 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_231_6 then
						iter_231_6.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_228_1.var_.actorSpriteComps10022 = nil
			end

			local var_231_11 = arg_228_1.actors_["10092"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_11) and arg_228_1.var_.actorSpriteComps10092 == nil then
				arg_228_1.var_.actorSpriteComps10092 = var_231_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_12 = 2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_12 and not isNil(var_231_11) then
				if arg_228_1.var_.actorSpriteComps10092 then
					for iter_231_7, iter_231_8 in pairs(arg_228_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_231_8 then
							if arg_228_1.isInRecall_ then
								iter_231_8.color = Color.New(Mathf.Lerp(iter_231_8.color.r, arg_228_1.hightColor2.r, (arg_228_1.time_ - 0) / var_231_12), Mathf.Lerp(iter_231_8.color.g, arg_228_1.hightColor2.g, (arg_228_1.time_ - 0) / var_231_12), (Mathf.Lerp(iter_231_8.color.b, arg_228_1.hightColor2.b, (arg_228_1.time_ - 0) / var_231_12)))
							else
								local var_231_13 = Mathf.Lerp(iter_231_8.color.r, 0.5, (arg_228_1.time_ - 0) / var_231_12)

								iter_231_8.color = Color.New(var_231_13, var_231_13, var_231_13)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_12 and arg_228_1.time_ < 0 + var_231_12 + arg_231_0 and not isNil(var_231_11) and arg_228_1.var_.actorSpriteComps10092 then
				for iter_231_9, iter_231_10 in pairs(arg_228_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_231_10 then
						iter_231_10.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_228_1.var_.actorSpriteComps10092 = nil
			end

			local var_231_14 = arg_228_1.actors_["10094"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_14) and arg_228_1.var_.actorSpriteComps10094 == nil then
				arg_228_1.var_.actorSpriteComps10094 = var_231_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_15 = 2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_15 and not isNil(var_231_14) then
				if arg_228_1.var_.actorSpriteComps10094 then
					for iter_231_11, iter_231_12 in pairs(arg_228_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_231_12 then
							if arg_228_1.isInRecall_ then
								iter_231_12.color = Color.New(Mathf.Lerp(iter_231_12.color.r, arg_228_1.hightColor1.r, (arg_228_1.time_ - 0) / var_231_15), Mathf.Lerp(iter_231_12.color.g, arg_228_1.hightColor1.g, (arg_228_1.time_ - 0) / var_231_15), (Mathf.Lerp(iter_231_12.color.b, arg_228_1.hightColor1.b, (arg_228_1.time_ - 0) / var_231_15)))
							else
								local var_231_16 = Mathf.Lerp(iter_231_12.color.r, 1, (arg_228_1.time_ - 0) / var_231_15)

								iter_231_12.color = Color.New(var_231_16, var_231_16, var_231_16)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_15 and arg_228_1.time_ < 0 + var_231_15 + arg_231_0 and not isNil(var_231_14) and arg_228_1.var_.actorSpriteComps10094 then
				for iter_231_13, iter_231_14 in pairs(arg_228_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_231_14 then
						iter_231_14.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_228_1.var_.actorSpriteComps10094 = nil
			end

			local var_231_17 = 0
			local var_231_18 = 0.5

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_17 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_19 = arg_228_1:GetWordFromCfg(413082053)
				local var_231_20 = arg_228_1:FormatText(var_231_19.content)

				arg_228_1.text_.text = var_231_20

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_22 = 20 <= 0 and var_231_18 or var_231_18 * (utf8.len(var_231_20) / 20)

				if (20 <= 0 and var_231_18 or var_231_18 * (utf8.len(var_231_20) / 20)) > 0 and var_231_18 < var_231_22 then
					arg_228_1.talkMaxDuration = var_231_22

					if var_231_22 + var_231_17 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_22 + var_231_17
					end
				end

				arg_228_1.text_.text = var_231_20
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082053", "story_v_out_413082.awb") ~= 0 then
					local var_231_23 = manager.audio:GetVoiceLength("story_v_out_413082", "413082053", "story_v_out_413082.awb") / 1000

					if var_231_23 + var_231_17 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_23 + var_231_17
					end

					if var_231_19.prefab_name ~= "" and arg_228_1.actors_[var_231_19.prefab_name] ~= nil then
						local var_231_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_19.prefab_name].transform, "story_v_out_413082", "413082053", "story_v_out_413082.awb")

						arg_228_1:RecordAudio("413082053", var_231_24)
						arg_228_1:RecordAudio("413082053", var_231_24)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_413082", "413082053", "story_v_out_413082.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_413082", "413082053", "story_v_out_413082.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_25 = math.max(var_231_18, arg_228_1.talkMaxDuration)

			if var_231_17 <= arg_228_1.time_ and arg_228_1.time_ < var_231_17 + var_231_25 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_17) / var_231_25

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_17 + var_231_25 and arg_228_1.time_ < var_231_17 + var_231_25 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
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

		arg_228_1:InitPlayNodeList()
	end,
	Play413082054 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 413082054
		arg_232_1.duration_ = 2

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play413082055(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10022 = arg_232_1.actors_["10022"].transform.localPosition
				arg_232_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10022", 4)

				for iter_235_0 = 0, arg_232_1.actors_["10022"].transform.childCount - 1 do
					local var_235_0 = arg_232_1.actors_["10022"].transform:GetChild(iter_235_0)

					if var_235_0.name == "split_6" or not string.find(var_235_0.name, "split") then
						var_235_0.gameObject:SetActive(true)
					else
						var_235_0.gameObject:SetActive(false)
					end
				end
			end

			local var_235_1 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_1 then
				arg_232_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_232_1.time_ - 0) / var_235_1)
			end

			if arg_232_1.time_ >= 0 + var_235_1 and arg_232_1.time_ < 0 + var_235_1 + arg_235_0 then
				arg_232_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_235_2 = arg_232_1.actors_["10094"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10094 = var_235_2.localPosition
				var_235_2.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10094", 2)

				for iter_235_1 = 0, var_235_2.childCount - 1 do
					local var_235_3 = var_235_2:GetChild(iter_235_1)

					if var_235_3.name == "split_2" or not string.find(var_235_3.name, "split") then
						var_235_3.gameObject:SetActive(true)
					else
						var_235_3.gameObject:SetActive(false)
					end
				end
			end

			local var_235_4 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				var_235_2.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_232_1.time_ - 0) / var_235_4)
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				var_235_2.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_235_5 = arg_232_1.actors_["10022"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_5) and arg_232_1.var_.actorSpriteComps10022 == nil then
				arg_232_1.var_.actorSpriteComps10022 = var_235_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_6 = 2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_6 and not isNil(var_235_5) then
				if arg_232_1.var_.actorSpriteComps10022 then
					for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_235_3 then
							if arg_232_1.isInRecall_ then
								iter_235_3.color = Color.New(Mathf.Lerp(iter_235_3.color.r, arg_232_1.hightColor1.r, (arg_232_1.time_ - 0) / var_235_6), Mathf.Lerp(iter_235_3.color.g, arg_232_1.hightColor1.g, (arg_232_1.time_ - 0) / var_235_6), (Mathf.Lerp(iter_235_3.color.b, arg_232_1.hightColor1.b, (arg_232_1.time_ - 0) / var_235_6)))
							else
								local var_235_7 = Mathf.Lerp(iter_235_3.color.r, 1, (arg_232_1.time_ - 0) / var_235_6)

								iter_235_3.color = Color.New(var_235_7, var_235_7, var_235_7)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_6 and arg_232_1.time_ < 0 + var_235_6 + arg_235_0 and not isNil(var_235_5) and arg_232_1.var_.actorSpriteComps10022 then
				for iter_235_4, iter_235_5 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_235_5 then
						iter_235_5.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_232_1.var_.actorSpriteComps10022 = nil
			end

			local var_235_8 = arg_232_1.actors_["10094"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps10094 == nil then
				arg_232_1.var_.actorSpriteComps10094 = var_235_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_9 = 2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_9 and not isNil(var_235_8) then
				if arg_232_1.var_.actorSpriteComps10094 then
					for iter_235_6, iter_235_7 in pairs(arg_232_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_235_7 then
							if arg_232_1.isInRecall_ then
								iter_235_7.color = Color.New(Mathf.Lerp(iter_235_7.color.r, arg_232_1.hightColor2.r, (arg_232_1.time_ - 0) / var_235_9), Mathf.Lerp(iter_235_7.color.g, arg_232_1.hightColor2.g, (arg_232_1.time_ - 0) / var_235_9), (Mathf.Lerp(iter_235_7.color.b, arg_232_1.hightColor2.b, (arg_232_1.time_ - 0) / var_235_9)))
							else
								local var_235_10 = Mathf.Lerp(iter_235_7.color.r, 0.5, (arg_232_1.time_ - 0) / var_235_9)

								iter_235_7.color = Color.New(var_235_10, var_235_10, var_235_10)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_9 and arg_232_1.time_ < 0 + var_235_9 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps10094 then
				for iter_235_8, iter_235_9 in pairs(arg_232_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_235_9 then
						iter_235_9.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_232_1.var_.actorSpriteComps10094 = nil
			end

			local var_235_11 = 0
			local var_235_12 = 0.075

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

				local var_235_13 = arg_232_1:GetWordFromCfg(413082054)
				local var_235_14 = arg_232_1:FormatText(var_235_13.content)

				arg_232_1.text_.text = var_235_14

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_16 = 3 <= 0 and var_235_12 or var_235_12 * (utf8.len(var_235_14) / 3)

				if (3 <= 0 and var_235_12 or var_235_12 * (utf8.len(var_235_14) / 3)) > 0 and var_235_12 < var_235_16 then
					arg_232_1.talkMaxDuration = var_235_16

					if var_235_16 + var_235_11 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_16 + var_235_11
					end
				end

				arg_232_1.text_.text = var_235_14
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082054", "story_v_out_413082.awb") ~= 0 then
					local var_235_17 = manager.audio:GetVoiceLength("story_v_out_413082", "413082054", "story_v_out_413082.awb") / 1000

					if var_235_17 + var_235_11 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_17 + var_235_11
					end

					if var_235_13.prefab_name ~= "" and arg_232_1.actors_[var_235_13.prefab_name] ~= nil then
						local var_235_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_13.prefab_name].transform, "story_v_out_413082", "413082054", "story_v_out_413082.awb")

						arg_232_1:RecordAudio("413082054", var_235_18)
						arg_232_1:RecordAudio("413082054", var_235_18)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_413082", "413082054", "story_v_out_413082.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_413082", "413082054", "story_v_out_413082.awb")
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

		arg_232_1:InitPlayNodeList()
	end,
	Play413082055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 413082055
		arg_236_1.duration_ = 2.47

		local var_236_0 = {
			zh = 2.333,
			ja = 2.466
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
				arg_236_0:Play413082056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["10094"]) and arg_236_1.var_.actorSpriteComps10094 == nil then
				arg_236_1.var_.actorSpriteComps10094 = arg_236_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_0 = 2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["10094"]) then
				if arg_236_1.var_.actorSpriteComps10094 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								iter_239_1.color = Color.New(Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor1.r, (arg_236_1.time_ - 0) / var_239_0), Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor1.g, (arg_236_1.time_ - 0) / var_239_0), (Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor1.b, (arg_236_1.time_ - 0) / var_239_0)))
							else
								local var_239_1 = Mathf.Lerp(iter_239_1.color.r, 1, (arg_236_1.time_ - 0) / var_239_0)

								iter_239_1.color = Color.New(var_239_1, var_239_1, var_239_1)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["10094"]) and arg_236_1.var_.actorSpriteComps10094 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_239_3 then
						iter_239_3.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_236_1.var_.actorSpriteComps10094 = nil
			end

			local var_239_2 = arg_236_1.actors_["10022"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.actorSpriteComps10022 == nil then
				arg_236_1.var_.actorSpriteComps10022 = var_239_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_3 = 2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_3 and not isNil(var_239_2) then
				if arg_236_1.var_.actorSpriteComps10022 then
					for iter_239_4, iter_239_5 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_239_5 then
							if arg_236_1.isInRecall_ then
								iter_239_5.color = Color.New(Mathf.Lerp(iter_239_5.color.r, arg_236_1.hightColor2.r, (arg_236_1.time_ - 0) / var_239_3), Mathf.Lerp(iter_239_5.color.g, arg_236_1.hightColor2.g, (arg_236_1.time_ - 0) / var_239_3), (Mathf.Lerp(iter_239_5.color.b, arg_236_1.hightColor2.b, (arg_236_1.time_ - 0) / var_239_3)))
							else
								local var_239_4 = Mathf.Lerp(iter_239_5.color.r, 0.5, (arg_236_1.time_ - 0) / var_239_3)

								iter_239_5.color = Color.New(var_239_4, var_239_4, var_239_4)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_3 and arg_236_1.time_ < 0 + var_239_3 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.actorSpriteComps10022 then
				for iter_239_6, iter_239_7 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_239_7 then
						iter_239_7.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_236_1.var_.actorSpriteComps10022 = nil
			end

			local var_239_5 = 0
			local var_239_6 = 0.25

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_7 = arg_236_1:GetWordFromCfg(413082055)
				local var_239_8 = arg_236_1:FormatText(var_239_7.content)

				arg_236_1.text_.text = var_239_8

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_10 = 10 <= 0 and var_239_6 or var_239_6 * (utf8.len(var_239_8) / 10)

				if (10 <= 0 and var_239_6 or var_239_6 * (utf8.len(var_239_8) / 10)) > 0 and var_239_6 < var_239_10 then
					arg_236_1.talkMaxDuration = var_239_10

					if var_239_10 + var_239_5 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_5
					end
				end

				arg_236_1.text_.text = var_239_8
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082055", "story_v_out_413082.awb") ~= 0 then
					local var_239_11 = manager.audio:GetVoiceLength("story_v_out_413082", "413082055", "story_v_out_413082.awb") / 1000

					if var_239_11 + var_239_5 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_11 + var_239_5
					end

					if var_239_7.prefab_name ~= "" and arg_236_1.actors_[var_239_7.prefab_name] ~= nil then
						local var_239_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_7.prefab_name].transform, "story_v_out_413082", "413082055", "story_v_out_413082.awb")

						arg_236_1:RecordAudio("413082055", var_239_12)
						arg_236_1:RecordAudio("413082055", var_239_12)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_413082", "413082055", "story_v_out_413082.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_413082", "413082055", "story_v_out_413082.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_13 = math.max(var_239_6, arg_236_1.talkMaxDuration)

			if var_239_5 <= arg_236_1.time_ and arg_236_1.time_ < var_239_5 + var_239_13 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_5) / var_239_13

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_5 + var_239_13 and arg_236_1.time_ < var_239_5 + var_239_13 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play413082056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 413082056
		arg_240_1.duration_ = 4.87

		local var_240_0 = {
			zh = 4.433,
			ja = 4.866
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
				arg_240_0:Play413082057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.575

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:GetWordFromCfg(413082056)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 23 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 23)

				if (23 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 23)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082056", "story_v_out_413082.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082056", "story_v_out_413082.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_413082", "413082056", "story_v_out_413082.awb")

						arg_240_1:RecordAudio("413082056", var_243_6)
						arg_240_1:RecordAudio("413082056", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_413082", "413082056", "story_v_out_413082.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_413082", "413082056", "story_v_out_413082.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play413082057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 413082057
		arg_244_1.duration_ = 5

		local var_244_0 = {
			zh = 5,
			ja = 4.5
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
			arg_244_1.auto_ = false
		end

		function arg_244_1.playNext_(arg_246_0)
			arg_244_1.onStoryFinished_()
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.5

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_1 = arg_244_1:GetWordFromCfg(413082057)
				local var_247_2 = arg_244_1:FormatText(var_247_1.content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 20 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 20)

				if (20 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 20)) > 0 and var_247_0 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + 0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413082", "413082057", "story_v_out_413082.awb") ~= 0 then
					local var_247_5 = manager.audio:GetVoiceLength("story_v_out_413082", "413082057", "story_v_out_413082.awb") / 1000

					if var_247_5 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + 0
					end

					if var_247_1.prefab_name ~= "" and arg_244_1.actors_[var_247_1.prefab_name] ~= nil then
						local var_247_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_1.prefab_name].transform, "story_v_out_413082", "413082057", "story_v_out_413082.awb")

						arg_244_1:RecordAudio("413082057", var_247_6)
						arg_244_1:RecordAudio("413082057", var_247_6)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_413082", "413082057", "story_v_out_413082.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_413082", "413082057", "story_v_out_413082.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/SS1306"
	},
	voices = {
		"story_v_out_413082.awb"
	}
}
