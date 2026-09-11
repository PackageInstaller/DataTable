return {
	Play926081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926081001
		arg_1_1.duration_ = 7.17

		local var_1_0 = {
			zh = 5,
			ja = 7.166
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
				arg_1_0:Play926081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I20f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I20f")
				var_4_0.name = "I20f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I20f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I20f

				arg_1_1.bgs_.I20f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I20f" then
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

			local var_4_9 = "10144"

			if arg_1_1.actors_["10144"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

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

			local var_4_12 = arg_1_1.actors_["10144"]

			if 1.799999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.799999999999 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10144 == nil then
				arg_1_1.var_.actorSpriteComps10144 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 1.799999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.799999999999 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps10144 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.799999999999) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.799999999999) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.799999999999) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 1.799999999999) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.799999999999 + var_4_13 and arg_1_1.time_ < 1.799999999999 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10144 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10144 = nil
			end

			local var_4_15 = arg_1_1.actors_["10144"].transform

			if 1.799999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.799999999999 + arg_4_0 then
				arg_1_1.var_.moveOldPos10144 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10144", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "split_2" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 1.799999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.799999999999 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_1_1.time_ - 1.799999999999) / var_4_17)
			end

			if arg_1_1.time_ >= 1.799999999999 + var_4_17 and arg_1_1.time_ < 1.799999999999 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			if 1.799999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.799999999999 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue10144 = var_4_18.alpha
					arg_1_1.var_.characterEffect10144 = var_4_18
				end

				arg_1_1.var_.alphaOldValue10144 = 0
			end

			local var_4_19 = 0.200000000001

			if 1.799999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.799999999999 + var_4_19 then
				if arg_1_1.var_.characterEffect10144 then
					arg_1_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10144, 1, (arg_1_1.time_ - 1.799999999999) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.799999999999 + var_4_19 and arg_1_1.time_ < 1.799999999999 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect10144 then
				arg_1_1.var_.characterEffect10144.alpha = 1
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle")

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
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_27 = 2
			local var_4_28 = 0.25

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_30 = arg_1_1:GetWordFromCfg(926081001)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.text_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 10 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 10)

				if (10 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 10)) > 0 and var_4_28 < var_4_33 then
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

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081001", "story_v_out_926081.awb") ~= 0 then
					local var_4_34 = manager.audio:GetVoiceLength("story_v_out_926081", "926081001", "story_v_out_926081.awb") / 1000

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end

					if var_4_30.prefab_name ~= "" and arg_1_1.actors_[var_4_30.prefab_name] ~= nil then
						local var_4_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_30.prefab_name].transform, "story_v_out_926081", "926081001", "story_v_out_926081.awb")

						arg_1_1:RecordAudio("926081001", var_4_35)
						arg_1_1:RecordAudio("926081001", var_4_35)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926081", "926081001", "story_v_out_926081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926081", "926081001", "story_v_out_926081.awb")
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.799999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play926081002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926081002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play926081003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["10144"]) and arg_9_1.var_.actorSpriteComps10144 == nil then
				arg_9_1.var_.actorSpriteComps10144 = arg_9_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_0 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["10144"]) then
				if arg_9_1.var_.actorSpriteComps10144 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								iter_12_1.color = Color.New(Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_0), Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_0), (Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_0)))
							else
								local var_12_1 = Mathf.Lerp(iter_12_1.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_0)

								iter_12_1.color = Color.New(var_12_1, var_12_1, var_12_1)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["10144"]) and arg_9_1.var_.actorSpriteComps10144 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10144 = nil
			end

			local var_12_2 = 0
			local var_12_3 = 0.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_4 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(926081002).content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 8 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 8)

				if (8 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 8)) > 0 and var_12_3 < var_12_6 then
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
	Play926081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926081003
		arg_13_1.duration_ = 6.93

		local var_13_0 = {
			zh = 5.2,
			ja = 6.933
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
				arg_13_0:Play926081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10144"]) and arg_13_1.var_.actorSpriteComps10144 == nil then
				arg_13_1.var_.actorSpriteComps10144 = arg_13_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10144"]) then
				if arg_13_1.var_.actorSpriteComps10144 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10144"]) and arg_13_1.var_.actorSpriteComps10144 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10144 = nil
			end

			local var_16_2 = arg_13_1.actors_["10144"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10144 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10144", 3)

				for iter_16_4 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_4)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_16_5 = 0
			local var_16_6 = 0.6

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
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

				local var_16_7 = arg_13_1:GetWordFromCfg(926081003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 24 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 24)

				if (24 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 24)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081003", "story_v_out_926081.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_926081", "926081003", "story_v_out_926081.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_926081", "926081003", "story_v_out_926081.awb")

						arg_13_1:RecordAudio("926081003", var_16_12)
						arg_13_1:RecordAudio("926081003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_926081", "926081003", "story_v_out_926081.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_926081", "926081003", "story_v_out_926081.awb")
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
				actorName = "10144",
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
	Play926081004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926081004
		arg_17_1.duration_ = 4.6

		local var_17_0 = {
			zh = 3.5,
			ja = 4.6
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
				arg_17_0:Play926081005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.35

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(926081004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 14 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 14)

				if (14 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 14)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081004", "story_v_out_926081.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_926081", "926081004", "story_v_out_926081.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_926081", "926081004", "story_v_out_926081.awb")

						arg_17_1:RecordAudio("926081004", var_20_6)
						arg_17_1:RecordAudio("926081004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_926081", "926081004", "story_v_out_926081.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_926081", "926081004", "story_v_out_926081.awb")
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
	Play926081005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926081005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play926081006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10144"]) and arg_21_1.var_.actorSpriteComps10144 == nil then
				arg_21_1.var_.actorSpriteComps10144 = arg_21_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10144"]) then
				if arg_21_1.var_.actorSpriteComps10144 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10144"]) and arg_21_1.var_.actorSpriteComps10144 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10144 = nil
			end

			local var_24_2 = 0
			local var_24_3 = 0.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_4 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(926081005).content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 13 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 13)

				if (13 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 13)) > 0 and var_24_3 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_7 and arg_21_1.time_ < var_24_2 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play926081006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 926081006
		arg_25_1.duration_ = 5.2

		local var_25_0 = {
			zh = 3.866,
			ja = 5.2
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
				arg_25_0:Play926081007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10144"]) and arg_25_1.var_.actorSpriteComps10144 == nil then
				arg_25_1.var_.actorSpriteComps10144 = arg_25_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10144"]) then
				if arg_25_1.var_.actorSpriteComps10144 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10144"]) and arg_25_1.var_.actorSpriteComps10144 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10144 = nil
			end

			local var_28_2 = 0
			local var_28_3 = 0.4

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(926081006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 16 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 16)

				if (16 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 16)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081006", "story_v_out_926081.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_926081", "926081006", "story_v_out_926081.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_926081", "926081006", "story_v_out_926081.awb")

						arg_25_1:RecordAudio("926081006", var_28_9)
						arg_25_1:RecordAudio("926081006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_926081", "926081006", "story_v_out_926081.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_926081", "926081006", "story_v_out_926081.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play926081007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926081007
		arg_29_1.duration_ = 10.13

		local var_29_0 = {
			zh = 6.433,
			ja = 10.133
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
				arg_29_0:Play926081008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10144 = arg_29_1.actors_["10144"].transform.localPosition
				arg_29_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10144", 3)

				for iter_32_0 = 0, arg_29_1.actors_["10144"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10144"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_7" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_32_2 = 0
			local var_32_3 = 0.825

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(926081007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 33 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 33)

				if (33 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 33)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081007", "story_v_out_926081.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_926081", "926081007", "story_v_out_926081.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_926081", "926081007", "story_v_out_926081.awb")

						arg_29_1:RecordAudio("926081007", var_32_9)
						arg_29_1:RecordAudio("926081007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926081", "926081007", "story_v_out_926081.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926081", "926081007", "story_v_out_926081.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play926081008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926081008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play926081009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10144"]) and arg_33_1.var_.actorSpriteComps10144 == nil then
				arg_33_1.var_.actorSpriteComps10144 = arg_33_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10144"]) then
				if arg_33_1.var_.actorSpriteComps10144 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10144"]) and arg_33_1.var_.actorSpriteComps10144 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10144 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 0.15

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(926081008).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 6 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 6)

				if (6 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 6)) > 0 and var_36_3 < var_36_6 then
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
	Play926081009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926081009
		arg_37_1.duration_ = 8.1

		local var_37_0 = {
			zh = 6.1,
			ja = 8.1
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
				arg_37_0:Play926081010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10144"]) and arg_37_1.var_.actorSpriteComps10144 == nil then
				arg_37_1.var_.actorSpriteComps10144 = arg_37_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10144"]) then
				if arg_37_1.var_.actorSpriteComps10144 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10144"]) and arg_37_1.var_.actorSpriteComps10144 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10144 = nil
			end

			local var_40_2 = arg_37_1.actors_["10144"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10144 = var_40_2.localPosition
				var_40_2.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10144", 3)

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
				var_40_2.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_37_1.time_ - 0) / var_40_4)
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_40_5 = 0
			local var_40_6 = 0.7

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(926081009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 28 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 28)

				if (28 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 28)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081009", "story_v_out_926081.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_926081", "926081009", "story_v_out_926081.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_926081", "926081009", "story_v_out_926081.awb")

						arg_37_1:RecordAudio("926081009", var_40_12)
						arg_37_1:RecordAudio("926081009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926081", "926081009", "story_v_out_926081.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926081", "926081009", "story_v_out_926081.awb")
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
				actorName = "10144",
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
	Play926081010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926081010
		arg_41_1.duration_ = 4.6

		local var_41_0 = {
			zh = 4.266,
			ja = 4.6
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
				arg_41_0:Play926081011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.5

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(926081010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 20 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 20)

				if (20 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 20)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081010", "story_v_out_926081.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_926081", "926081010", "story_v_out_926081.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_926081", "926081010", "story_v_out_926081.awb")

						arg_41_1:RecordAudio("926081010", var_44_6)
						arg_41_1:RecordAudio("926081010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926081", "926081010", "story_v_out_926081.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926081", "926081010", "story_v_out_926081.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play926081011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926081011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play926081012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10144"]) and arg_45_1.var_.actorSpriteComps10144 == nil then
				arg_45_1.var_.actorSpriteComps10144 = arg_45_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10144"]) then
				if arg_45_1.var_.actorSpriteComps10144 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10144"]) and arg_45_1.var_.actorSpriteComps10144 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10144 = nil
			end

			local var_48_2 = 0
			local var_48_3 = 0.475

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_4 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(926081011).content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 19 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 19)

				if (19 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 19)) > 0 and var_48_3 < var_48_6 then
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
	Play926081012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926081012
		arg_49_1.duration_ = 7.1

		local var_49_0 = {
			zh = 4.366,
			ja = 7.1
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
				arg_49_0:Play926081013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10144"]) and arg_49_1.var_.actorSpriteComps10144 == nil then
				arg_49_1.var_.actorSpriteComps10144 = arg_49_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10144"]) then
				if arg_49_1.var_.actorSpriteComps10144 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10144"]) and arg_49_1.var_.actorSpriteComps10144 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps10144 = nil
			end

			local var_52_2 = arg_49_1.actors_["10144"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10144 = var_52_2.localPosition
				var_52_2.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10144", 3)

				for iter_52_4 = 0, var_52_2.childCount - 1 do
					local var_52_3 = var_52_2:GetChild(iter_52_4)

					if var_52_3.name == "" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_49_1.time_ - 0) / var_52_4)
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_52_5 = 0
			local var_52_6 = 0.425

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(926081012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 17 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 17)

				if (17 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 17)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081012", "story_v_out_926081.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_926081", "926081012", "story_v_out_926081.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_926081", "926081012", "story_v_out_926081.awb")

						arg_49_1:RecordAudio("926081012", var_52_12)
						arg_49_1:RecordAudio("926081012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926081", "926081012", "story_v_out_926081.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926081", "926081012", "story_v_out_926081.awb")
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
	Play926081013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926081013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play926081014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10144"]) and arg_53_1.var_.actorSpriteComps10144 == nil then
				arg_53_1.var_.actorSpriteComps10144 = arg_53_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10144"]) then
				if arg_53_1.var_.actorSpriteComps10144 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10144"]) and arg_53_1.var_.actorSpriteComps10144 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps10144 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 0.175

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_4 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(926081013).content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 7 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 7)

				if (7 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 7)) > 0 and var_56_3 < var_56_6 then
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
	Play926081014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926081014
		arg_57_1.duration_ = 2.4

		local var_57_0 = {
			zh = 2.133,
			ja = 2.4
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
				arg_57_0:Play926081015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10144"]) and arg_57_1.var_.actorSpriteComps10144 == nil then
				arg_57_1.var_.actorSpriteComps10144 = arg_57_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10144"]) then
				if arg_57_1.var_.actorSpriteComps10144 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10144"]) and arg_57_1.var_.actorSpriteComps10144 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10144 = nil
			end

			local var_60_2 = 0
			local var_60_3 = 0.225

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(926081014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 9 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 9)

				if (9 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 9)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081014", "story_v_out_926081.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_926081", "926081014", "story_v_out_926081.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_926081", "926081014", "story_v_out_926081.awb")

						arg_57_1:RecordAudio("926081014", var_60_9)
						arg_57_1:RecordAudio("926081014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_926081", "926081014", "story_v_out_926081.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_926081", "926081014", "story_v_out_926081.awb")
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
	Play926081015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926081015
		arg_61_1.duration_ = 8.6

		local var_61_0 = {
			zh = 6.466,
			ja = 8.6
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
				arg_61_0:Play926081016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10144 = arg_61_1.actors_["10144"].transform.localPosition
				arg_61_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10144", 3)

				for iter_64_0 = 0, arg_61_1.actors_["10144"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["10144"].transform:GetChild(iter_64_0)

					if var_64_0.name == "" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_64_2 = 0
			local var_64_3 = 0.675

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(926081015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 27 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 27)

				if (27 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 27)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081015", "story_v_out_926081.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_926081", "926081015", "story_v_out_926081.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_926081", "926081015", "story_v_out_926081.awb")

						arg_61_1:RecordAudio("926081015", var_64_9)
						arg_61_1:RecordAudio("926081015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_926081", "926081015", "story_v_out_926081.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_926081", "926081015", "story_v_out_926081.awb")
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

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play926081016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926081016
		arg_65_1.duration_ = 4.83

		local var_65_0 = {
			zh = 2.933,
			ja = 4.833
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
				arg_65_0:Play926081017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.375

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
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

				local var_68_1 = arg_65_1:GetWordFromCfg(926081016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 15 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 15)

				if (15 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 15)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081016", "story_v_out_926081.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_926081", "926081016", "story_v_out_926081.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_926081", "926081016", "story_v_out_926081.awb")

						arg_65_1:RecordAudio("926081016", var_68_6)
						arg_65_1:RecordAudio("926081016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_926081", "926081016", "story_v_out_926081.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_926081", "926081016", "story_v_out_926081.awb")
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
	Play926081017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926081017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play926081018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10144"]) and arg_69_1.var_.actorSpriteComps10144 == nil then
				arg_69_1.var_.actorSpriteComps10144 = arg_69_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10144"]) then
				if arg_69_1.var_.actorSpriteComps10144 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10144"]) and arg_69_1.var_.actorSpriteComps10144 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10144 = nil
			end

			local var_72_2 = 0
			local var_72_3 = 0.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_4 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(926081017).content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 10 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_4) / 10)

				if (10 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_4) / 10)) > 0 and var_72_3 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_7 and arg_69_1.time_ < var_72_2 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play926081018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926081018
		arg_73_1.duration_ = 6.03

		local var_73_0 = {
			zh = 3.833,
			ja = 6.033
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
				arg_73_0:Play926081019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10144"]) and arg_73_1.var_.actorSpriteComps10144 == nil then
				arg_73_1.var_.actorSpriteComps10144 = arg_73_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10144"]) then
				if arg_73_1.var_.actorSpriteComps10144 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 1, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10144"]) and arg_73_1.var_.actorSpriteComps10144 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10144 = nil
			end

			local var_76_2 = 0
			local var_76_3 = 0.45

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(926081018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 18 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 18)

				if (18 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 18)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081018", "story_v_out_926081.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_926081", "926081018", "story_v_out_926081.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_926081", "926081018", "story_v_out_926081.awb")

						arg_73_1:RecordAudio("926081018", var_76_9)
						arg_73_1:RecordAudio("926081018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_926081", "926081018", "story_v_out_926081.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_926081", "926081018", "story_v_out_926081.awb")
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
	Play926081019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926081019
		arg_77_1.duration_ = 5.23

		local var_77_0 = {
			zh = 3.9,
			ja = 5.233
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
				arg_77_0:Play926081020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10144 = arg_77_1.actors_["10144"].transform.localPosition
				arg_77_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10144", 3)

				for iter_80_0 = 0, arg_77_1.actors_["10144"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["10144"].transform:GetChild(iter_80_0)

					if var_80_0.name == "split_7" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_80_2 = 0
			local var_80_3 = 0.475

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(926081019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 19 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 19)

				if (19 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 19)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081019", "story_v_out_926081.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_926081", "926081019", "story_v_out_926081.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_926081", "926081019", "story_v_out_926081.awb")

						arg_77_1:RecordAudio("926081019", var_80_9)
						arg_77_1:RecordAudio("926081019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_926081", "926081019", "story_v_out_926081.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_926081", "926081019", "story_v_out_926081.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play926081020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 926081020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play926081021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10144"]) and arg_81_1.var_.actorSpriteComps10144 == nil then
				arg_81_1.var_.actorSpriteComps10144 = arg_81_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10144"]) then
				if arg_81_1.var_.actorSpriteComps10144 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10144"]) and arg_81_1.var_.actorSpriteComps10144 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10144 = nil
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_84_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_81_1.bgmTxt_.text ~= var_84_4 and arg_81_1.bgmTxt_.text ~= "" then
						if arg_81_1.bgmTxt2_.text ~= "" then
							arg_81_1.bgmTxt_.text = arg_81_1.bgmTxt2_.text
						end

						arg_81_1.bgmTxt2_.text = var_84_4

						arg_81_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_81_1.bgmTxt_.text = var_84_4
						arg_81_1.bgmTxt2_.text = var_84_4
					end

					if arg_81_1.bgmTimer then
						arg_81_1.bgmTimer:Stop()

						arg_81_1.bgmTimer = nil
					end

					if arg_81_1.settingData.show_music_name == 1 then
						arg_81_1.musicController:SetSelectedState("show")
						arg_81_1.musicAnimator_:Play("open", 0, 0)

						if arg_81_1.settingData.music_time ~= 0 then
							arg_81_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_81_1.settingData.music_time), function()
								if arg_81_1 == nil or isNil(arg_81_1.bgmTxt_) then
									return
								end

								arg_81_1.musicController:SetSelectedState("hide")
								arg_81_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_84_5 = 0
			local var_84_6 = 0.35

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
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

				local var_84_7 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(926081020).content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 14 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 14)

				if (14 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 14)) > 0 and var_84_6 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_10 and arg_81_1.time_ < var_84_5 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play926081021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 926081021
		arg_86_1.duration_ = 6.9

		local var_86_0 = {
			zh = 4.8,
			ja = 6.9
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play926081022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["10144"]) and arg_86_1.var_.actorSpriteComps10144 == nil then
				arg_86_1.var_.actorSpriteComps10144 = arg_86_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["10144"]) then
				if arg_86_1.var_.actorSpriteComps10144 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								iter_89_1.color = Color.New(Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor1.r, (arg_86_1.time_ - 0) / var_89_0), Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor1.g, (arg_86_1.time_ - 0) / var_89_0), (Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor1.b, (arg_86_1.time_ - 0) / var_89_0)))
							else
								local var_89_1 = Mathf.Lerp(iter_89_1.color.r, 1, (arg_86_1.time_ - 0) / var_89_0)

								iter_89_1.color = Color.New(var_89_1, var_89_1, var_89_1)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["10144"]) and arg_86_1.var_.actorSpriteComps10144 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_86_1.var_.actorSpriteComps10144 = nil
			end

			local var_89_2 = arg_86_1.actors_["10144"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10144 = var_89_2.localPosition
				var_89_2.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10144", 3)

				for iter_89_4 = 0, var_89_2.childCount - 1 do
					local var_89_3 = var_89_2:GetChild(iter_89_4)

					if var_89_3.name == "split_1" or not string.find(var_89_3.name, "split") then
						var_89_3.gameObject:SetActive(true)
					else
						var_89_3.gameObject:SetActive(false)
					end
				end
			end

			local var_89_4 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				var_89_2.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_86_1.time_ - 0) / var_89_4)
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				var_89_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_89_5 = 0
			local var_89_6 = 0.6

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_7 = arg_86_1:GetWordFromCfg(926081021)
				local var_89_8 = arg_86_1:FormatText(var_89_7.content)

				arg_86_1.text_.text = var_89_8

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_10 = 24 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_8) / 24)

				if (24 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_8) / 24)) > 0 and var_89_6 < var_89_10 then
					arg_86_1.talkMaxDuration = var_89_10

					if var_89_10 + var_89_5 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_5
					end
				end

				arg_86_1.text_.text = var_89_8
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081021", "story_v_out_926081.awb") ~= 0 then
					local var_89_11 = manager.audio:GetVoiceLength("story_v_out_926081", "926081021", "story_v_out_926081.awb") / 1000

					if var_89_11 + var_89_5 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_5
					end

					if var_89_7.prefab_name ~= "" and arg_86_1.actors_[var_89_7.prefab_name] ~= nil then
						local var_89_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_7.prefab_name].transform, "story_v_out_926081", "926081021", "story_v_out_926081.awb")

						arg_86_1:RecordAudio("926081021", var_89_12)
						arg_86_1:RecordAudio("926081021", var_89_12)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_926081", "926081021", "story_v_out_926081.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_926081", "926081021", "story_v_out_926081.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_13 = math.max(var_89_6, arg_86_1.talkMaxDuration)

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_13 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_5) / var_89_13

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_5 + var_89_13 and arg_86_1.time_ < var_89_5 + var_89_13 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play926081022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 926081022
		arg_90_1.duration_ = 9.57

		local var_90_0 = {
			zh = 8.7,
			ja = 9.566
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play926081023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_93_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_90_1.bgmTxt_.text ~= var_93_2 and arg_90_1.bgmTxt_.text ~= "" then
						if arg_90_1.bgmTxt2_.text ~= "" then
							arg_90_1.bgmTxt_.text = arg_90_1.bgmTxt2_.text
						end

						arg_90_1.bgmTxt2_.text = var_93_2

						arg_90_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_90_1.bgmTxt_.text = var_93_2
						arg_90_1.bgmTxt2_.text = var_93_2
					end

					if arg_90_1.bgmTimer then
						arg_90_1.bgmTimer:Stop()

						arg_90_1.bgmTimer = nil
					end

					if arg_90_1.settingData.show_music_name == 1 then
						arg_90_1.musicController:SetSelectedState("show")
						arg_90_1.musicAnimator_:Play("open", 0, 0)

						if arg_90_1.settingData.music_time ~= 0 then
							arg_90_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_90_1.settingData.music_time), function()
								if arg_90_1 == nil or isNil(arg_90_1.bgmTxt_) then
									return
								end

								arg_90_1.musicController:SetSelectedState("hide")
								arg_90_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_90_1.time_ and arg_90_1.time_ <= 0.433333333333333 + arg_93_0 then
				arg_90_1:AudioAction("play", "music", "bgm_activity_4_3_story_duel", "bgm_activity_4_3_story_duel", "bgm_activity_4_3_story_duel.awb")

				local var_93_5 = manager.audio:GetAudioName("bgm_activity_4_3_story_duel", "bgm_activity_4_3_story_duel")

				if "" ~= "" then
					if arg_90_1.bgmTxt_.text ~= var_93_5 and arg_90_1.bgmTxt_.text ~= "" then
						if arg_90_1.bgmTxt2_.text ~= "" then
							arg_90_1.bgmTxt_.text = arg_90_1.bgmTxt2_.text
						end

						arg_90_1.bgmTxt2_.text = var_93_5

						arg_90_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_90_1.bgmTxt_.text = var_93_5
						arg_90_1.bgmTxt2_.text = var_93_5
					end

					if arg_90_1.bgmTimer then
						arg_90_1.bgmTimer:Stop()

						arg_90_1.bgmTimer = nil
					end

					if arg_90_1.settingData.show_music_name == 1 then
						arg_90_1.musicController:SetSelectedState("show")
						arg_90_1.musicAnimator_:Play("open", 0, 0)

						if arg_90_1.settingData.music_time ~= 0 then
							arg_90_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_90_1.settingData.music_time), function()
								if arg_90_1 == nil or isNil(arg_90_1.bgmTxt_) then
									return
								end

								arg_90_1.musicController:SetSelectedState("hide")
								arg_90_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_93_6 = 0
			local var_93_7 = 1.025

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_8 = arg_90_1:GetWordFromCfg(926081022)
				local var_93_9 = arg_90_1:FormatText(var_93_8.content)

				arg_90_1.text_.text = var_93_9

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 41 <= 0 and var_93_7 or var_93_7 * (utf8.len(var_93_9) / 41)

				if (41 <= 0 and var_93_7 or var_93_7 * (utf8.len(var_93_9) / 41)) > 0 and var_93_7 < var_93_11 then
					arg_90_1.talkMaxDuration = var_93_11

					if var_93_11 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_11 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_9
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081022", "story_v_out_926081.awb") ~= 0 then
					local var_93_12 = manager.audio:GetVoiceLength("story_v_out_926081", "926081022", "story_v_out_926081.awb") / 1000

					if var_93_12 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_12 + var_93_6
					end

					if var_93_8.prefab_name ~= "" and arg_90_1.actors_[var_93_8.prefab_name] ~= nil then
						local var_93_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_8.prefab_name].transform, "story_v_out_926081", "926081022", "story_v_out_926081.awb")

						arg_90_1:RecordAudio("926081022", var_93_13)
						arg_90_1:RecordAudio("926081022", var_93_13)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_926081", "926081022", "story_v_out_926081.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_926081", "926081022", "story_v_out_926081.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_14 and arg_90_1.time_ < var_93_6 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play926081023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 926081023
		arg_96_1.duration_ = 10.17

		local var_96_0 = {
			zh = 9.1,
			ja = 10.166
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
				arg_96_0:Play926081024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 1.125

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:GetWordFromCfg(926081023)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 45 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 45)

				if (45 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 45)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081023", "story_v_out_926081.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_926081", "926081023", "story_v_out_926081.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_926081", "926081023", "story_v_out_926081.awb")

						arg_96_1:RecordAudio("926081023", var_99_6)
						arg_96_1:RecordAudio("926081023", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_926081", "926081023", "story_v_out_926081.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_926081", "926081023", "story_v_out_926081.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play926081024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 926081024
		arg_100_1.duration_ = 6.23

		local var_100_0 = {
			zh = 4.266,
			ja = 6.233
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play926081025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos10144 = arg_100_1.actors_["10144"].transform.localPosition
				arg_100_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10144", 3)

				for iter_103_0 = 0, arg_100_1.actors_["10144"].transform.childCount - 1 do
					local var_103_0 = arg_100_1.actors_["10144"].transform:GetChild(iter_103_0)

					if var_103_0.name == "" or not string.find(var_103_0.name, "split") then
						var_103_0.gameObject:SetActive(true)
					else
						var_103_0.gameObject:SetActive(false)
					end
				end
			end

			local var_103_1 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_1 then
				arg_100_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_100_1.time_ - 0) / var_103_1)
			end

			if arg_100_1.time_ >= 0 + var_103_1 and arg_100_1.time_ < 0 + var_103_1 + arg_103_0 then
				arg_100_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_103_2 = 0
			local var_103_3 = 0.575

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_4 = arg_100_1:GetWordFromCfg(926081024)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 23 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 23)

				if (23 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 23)) > 0 and var_103_3 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081024", "story_v_out_926081.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_926081", "926081024", "story_v_out_926081.awb") / 1000

					if var_103_8 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_2
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_out_926081", "926081024", "story_v_out_926081.awb")

						arg_100_1:RecordAudio("926081024", var_103_9)
						arg_100_1:RecordAudio("926081024", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_926081", "926081024", "story_v_out_926081.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_926081", "926081024", "story_v_out_926081.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_10 and arg_100_1.time_ < var_103_2 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
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

		arg_100_1:InitPlayNodeList()
	end,
	Play926081025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 926081025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play926081026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["10144"]) and arg_104_1.var_.actorSpriteComps10144 == nil then
				arg_104_1.var_.actorSpriteComps10144 = arg_104_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_0 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["10144"]) then
				if arg_104_1.var_.actorSpriteComps10144 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								iter_107_1.color = Color.New(Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor2.r, (arg_104_1.time_ - 0) / var_107_0), Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor2.g, (arg_104_1.time_ - 0) / var_107_0), (Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor2.b, (arg_104_1.time_ - 0) / var_107_0)))
							else
								local var_107_1 = Mathf.Lerp(iter_107_1.color.r, 0.5, (arg_104_1.time_ - 0) / var_107_0)

								iter_107_1.color = Color.New(var_107_1, var_107_1, var_107_1)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["10144"]) and arg_104_1.var_.actorSpriteComps10144 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_107_3 then
						iter_107_3.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_104_1.var_.actorSpriteComps10144 = nil
			end

			local var_107_2 = 0
			local var_107_3 = 0.725

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_4 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(926081025).content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_6 = 29 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_4) / 29)

				if (29 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_4) / 29)) > 0 and var_107_3 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_7 and arg_104_1.time_ < var_107_2 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play926081026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 926081026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play926081027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.675

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(926081026).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 27 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 27)

				if (27 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 27)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play926081027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 926081027
		arg_112_1.duration_ = 2.4

		local var_112_0 = {
			zh = 2.2,
			ja = 2.4
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
				arg_112_0:Play926081028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if arg_112_1.actors_["128404"] == nil then
				local var_115_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_115_0) then
					local var_115_1 = Object.Instantiate(var_115_0, arg_112_1.canvasGo_.transform)

					var_115_1.transform:SetSiblingIndex(1)

					var_115_1.name = "128404"
					var_115_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_112_1.actors_["128404"] = var_115_1

					if arg_112_1.isInRecall_ then
						for iter_115_0, iter_115_1 in ipairs((var_115_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_115_1.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_115_2 = arg_112_1.actors_["128404"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.actorSpriteComps128404 == nil then
				arg_112_1.var_.actorSpriteComps128404 = var_115_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_3 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.actorSpriteComps128404 then
					for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_115_3 then
							if arg_112_1.isInRecall_ then
								iter_115_3.color = Color.New(Mathf.Lerp(iter_115_3.color.r, arg_112_1.hightColor1.r, (arg_112_1.time_ - 0) / var_115_3), Mathf.Lerp(iter_115_3.color.g, arg_112_1.hightColor1.g, (arg_112_1.time_ - 0) / var_115_3), (Mathf.Lerp(iter_115_3.color.b, arg_112_1.hightColor1.b, (arg_112_1.time_ - 0) / var_115_3)))
							else
								local var_115_4 = Mathf.Lerp(iter_115_3.color.r, 1, (arg_112_1.time_ - 0) / var_115_3)

								iter_115_3.color = Color.New(var_115_4, var_115_4, var_115_4)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.actorSpriteComps128404 then
				for iter_115_4, iter_115_5 in pairs(arg_112_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_115_5 then
						iter_115_5.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_112_1.var_.actorSpriteComps128404 = nil
			end

			local var_115_5 = arg_112_1.actors_["10144"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos10144 = var_115_5.localPosition
				var_115_5.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10144", 7)

				for iter_115_6 = 0, var_115_5.childCount - 1 do
					local var_115_6 = var_115_5:GetChild(iter_115_6)

					if var_115_6.name == "" or not string.find(var_115_6.name, "split") then
						var_115_6.gameObject:SetActive(true)
					else
						var_115_6.gameObject:SetActive(false)
					end
				end
			end

			local var_115_7 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				var_115_5.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_112_1.time_ - 0) / var_115_7)
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				var_115_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_115_8 = arg_112_1.actors_["128404"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos128404 = var_115_8.localPosition
				var_115_8.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("128404", 3)

				for iter_115_7 = 0, var_115_8.childCount - 1 do
					local var_115_9 = var_115_8:GetChild(iter_115_7)

					if var_115_9.name == "" or not string.find(var_115_9.name, "split") then
						var_115_9.gameObject:SetActive(true)
					else
						var_115_9.gameObject:SetActive(false)
					end
				end
			end

			local var_115_10 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_10 then
				var_115_8.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_112_1.time_ - 0) / var_115_10)
			end

			if arg_112_1.time_ >= 0 + var_115_10 and arg_112_1.time_ < 0 + var_115_10 + arg_115_0 then
				var_115_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_115_11 = 0
			local var_115_12 = 0.25

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_11 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_13 = arg_112_1:GetWordFromCfg(926081027)
				local var_115_14 = arg_112_1:FormatText(var_115_13.content)

				arg_112_1.text_.text = var_115_14

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_16 = 10 <= 0 and var_115_12 or var_115_12 * (utf8.len(var_115_14) / 10)

				if (10 <= 0 and var_115_12 or var_115_12 * (utf8.len(var_115_14) / 10)) > 0 and var_115_12 < var_115_16 then
					arg_112_1.talkMaxDuration = var_115_16

					if var_115_16 + var_115_11 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_16 + var_115_11
					end
				end

				arg_112_1.text_.text = var_115_14
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081027", "story_v_out_926081.awb") ~= 0 then
					local var_115_17 = manager.audio:GetVoiceLength("story_v_out_926081", "926081027", "story_v_out_926081.awb") / 1000

					if var_115_17 + var_115_11 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_17 + var_115_11
					end

					if var_115_13.prefab_name ~= "" and arg_112_1.actors_[var_115_13.prefab_name] ~= nil then
						local var_115_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_13.prefab_name].transform, "story_v_out_926081", "926081027", "story_v_out_926081.awb")

						arg_112_1:RecordAudio("926081027", var_115_18)
						arg_112_1:RecordAudio("926081027", var_115_18)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_926081", "926081027", "story_v_out_926081.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_926081", "926081027", "story_v_out_926081.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_19 = math.max(var_115_12, arg_112_1.talkMaxDuration)

			if var_115_11 <= arg_112_1.time_ and arg_112_1.time_ < var_115_11 + var_115_19 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_11) / var_115_19

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_11 + var_115_19 and arg_112_1.time_ < var_115_11 + var_115_19 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play926081028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 926081028
		arg_116_1.duration_ = 7.5

		local var_116_0 = {
			zh = 7.5,
			ja = 4.933
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play926081029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos128404 = arg_116_1.actors_["128404"].transform.localPosition
				arg_116_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("128404", 3)

				for iter_119_0 = 0, arg_116_1.actors_["128404"].transform.childCount - 1 do
					local var_119_0 = arg_116_1.actors_["128404"].transform:GetChild(iter_119_0)

					if var_119_0.name == "split_6" or not string.find(var_119_0.name, "split") then
						var_119_0.gameObject:SetActive(true)
					else
						var_119_0.gameObject:SetActive(false)
					end
				end
			end

			local var_119_1 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 then
				arg_116_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_116_1.time_ - 0) / var_119_1)
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 then
				arg_116_1.actors_["128404"].transform.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_119_2 = 0
			local var_119_3 = 0.725

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_2 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_4 = arg_116_1:GetWordFromCfg(926081028)
				local var_119_5 = arg_116_1:FormatText(var_119_4.content)

				arg_116_1.text_.text = var_119_5

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_7 = 29 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_5) / 29)

				if (29 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_5) / 29)) > 0 and var_119_3 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_2
					end
				end

				arg_116_1.text_.text = var_119_5
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081028", "story_v_out_926081.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_926081", "926081028", "story_v_out_926081.awb") / 1000

					if var_119_8 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_2
					end

					if var_119_4.prefab_name ~= "" and arg_116_1.actors_[var_119_4.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_4.prefab_name].transform, "story_v_out_926081", "926081028", "story_v_out_926081.awb")

						arg_116_1:RecordAudio("926081028", var_119_9)
						arg_116_1:RecordAudio("926081028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_926081", "926081028", "story_v_out_926081.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_926081", "926081028", "story_v_out_926081.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_3, arg_116_1.talkMaxDuration)

			if var_119_2 <= arg_116_1.time_ and arg_116_1.time_ < var_119_2 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_2) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_2 + var_119_10 and arg_116_1.time_ < var_119_2 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play926081029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 926081029
		arg_120_1.duration_ = 12.6

		local var_120_0 = {
			zh = 11.133,
			ja = 12.6
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
				arg_120_0:Play926081030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 1.075

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:GetWordFromCfg(926081029)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 43 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 43)

				if (43 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 43)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081029", "story_v_out_926081.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_926081", "926081029", "story_v_out_926081.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_926081", "926081029", "story_v_out_926081.awb")

						arg_120_1:RecordAudio("926081029", var_123_6)
						arg_120_1:RecordAudio("926081029", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_926081", "926081029", "story_v_out_926081.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_926081", "926081029", "story_v_out_926081.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play926081030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 926081030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play926081031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["128404"]) and arg_124_1.var_.actorSpriteComps128404 == nil then
				arg_124_1.var_.actorSpriteComps128404 = arg_124_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["128404"]) then
				if arg_124_1.var_.actorSpriteComps128404 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								iter_127_1.color = Color.New(Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, (arg_124_1.time_ - 0) / var_127_0), Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, (arg_124_1.time_ - 0) / var_127_0), (Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, (arg_124_1.time_ - 0) / var_127_0)))
							else
								local var_127_1 = Mathf.Lerp(iter_127_1.color.r, 0.5, (arg_124_1.time_ - 0) / var_127_0)

								iter_127_1.color = Color.New(var_127_1, var_127_1, var_127_1)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["128404"]) and arg_124_1.var_.actorSpriteComps128404 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_124_1.var_.actorSpriteComps128404 = nil
			end

			local var_127_2 = 0
			local var_127_3 = 0.3

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_4 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(926081030).content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_6 = 12 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_4) / 12)

				if (12 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_4) / 12)) > 0 and var_127_3 < var_127_6 then
					arg_124_1.talkMaxDuration = var_127_6

					if var_127_6 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_7 and arg_124_1.time_ < var_127_2 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play926081031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 926081031
		arg_128_1.duration_ = 11.87

		local var_128_0 = {
			zh = 7.766,
			ja = 11.866
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
				arg_128_0:Play926081032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["128404"]) and arg_128_1.var_.actorSpriteComps128404 == nil then
				arg_128_1.var_.actorSpriteComps128404 = arg_128_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["128404"]) then
				if arg_128_1.var_.actorSpriteComps128404 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								iter_131_1.color = Color.New(Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, (arg_128_1.time_ - 0) / var_131_0), Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, (arg_128_1.time_ - 0) / var_131_0), (Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, (arg_128_1.time_ - 0) / var_131_0)))
							else
								local var_131_1 = Mathf.Lerp(iter_131_1.color.r, 1, (arg_128_1.time_ - 0) / var_131_0)

								iter_131_1.color = Color.New(var_131_1, var_131_1, var_131_1)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["128404"]) and arg_128_1.var_.actorSpriteComps128404 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_128_1.var_.actorSpriteComps128404 = nil
			end

			local var_131_2 = arg_128_1.actors_["128404"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos128404 = var_131_2.localPosition
				var_131_2.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("128404", 3)

				for iter_131_4 = 0, var_131_2.childCount - 1 do
					local var_131_3 = var_131_2:GetChild(iter_131_4)

					if var_131_3.name == "" or not string.find(var_131_3.name, "split") then
						var_131_3.gameObject:SetActive(true)
					else
						var_131_3.gameObject:SetActive(false)
					end
				end
			end

			local var_131_4 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				var_131_2.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_128_1.time_ - 0) / var_131_4)
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				var_131_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_131_5 = 0
			local var_131_6 = 1.05

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:GetWordFromCfg(926081031)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 42 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 42)

				if (42 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 42)) > 0 and var_131_6 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10

					if var_131_10 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081031", "story_v_out_926081.awb") ~= 0 then
					local var_131_11 = manager.audio:GetVoiceLength("story_v_out_926081", "926081031", "story_v_out_926081.awb") / 1000

					if var_131_11 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_5
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_926081", "926081031", "story_v_out_926081.awb")

						arg_128_1:RecordAudio("926081031", var_131_12)
						arg_128_1:RecordAudio("926081031", var_131_12)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_926081", "926081031", "story_v_out_926081.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_926081", "926081031", "story_v_out_926081.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_13 = math.max(var_131_6, arg_128_1.talkMaxDuration)

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_13 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_5) / var_131_13

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_5 + var_131_13 and arg_128_1.time_ < var_131_5 + var_131_13 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play926081032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 926081032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play926081033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["128404"]) and arg_132_1.var_.actorSpriteComps128404 == nil then
				arg_132_1.var_.actorSpriteComps128404 = arg_132_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["128404"]) then
				if arg_132_1.var_.actorSpriteComps128404 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor2.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor2.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor2.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 0.5, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["128404"]) and arg_132_1.var_.actorSpriteComps128404 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_132_1.var_.actorSpriteComps128404 = nil
			end

			local var_135_2 = 0
			local var_135_3 = 0.275

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_4 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(926081032).content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 11 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_4) / 11)

				if (11 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_4) / 11)) > 0 and var_135_3 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_2
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_3, arg_132_1.talkMaxDuration)

			if var_135_2 <= arg_132_1.time_ and arg_132_1.time_ < var_135_2 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_2) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_2 + var_135_7 and arg_132_1.time_ < var_135_2 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play926081033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 926081033
		arg_136_1.duration_ = 12.6

		local var_136_0 = {
			zh = 9.966,
			ja = 12.6
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
				arg_136_0:Play926081034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["128404"]) and arg_136_1.var_.actorSpriteComps128404 == nil then
				arg_136_1.var_.actorSpriteComps128404 = arg_136_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["128404"]) then
				if arg_136_1.var_.actorSpriteComps128404 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								iter_139_1.color = Color.New(Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor1.r, (arg_136_1.time_ - 0) / var_139_0), Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor1.g, (arg_136_1.time_ - 0) / var_139_0), (Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor1.b, (arg_136_1.time_ - 0) / var_139_0)))
							else
								local var_139_1 = Mathf.Lerp(iter_139_1.color.r, 1, (arg_136_1.time_ - 0) / var_139_0)

								iter_139_1.color = Color.New(var_139_1, var_139_1, var_139_1)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["128404"]) and arg_136_1.var_.actorSpriteComps128404 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_139_3 then
						iter_139_3.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_136_1.var_.actorSpriteComps128404 = nil
			end

			local var_139_2 = 0
			local var_139_3 = 1.075

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_4 = arg_136_1:GetWordFromCfg(926081033)
				local var_139_5 = arg_136_1:FormatText(var_139_4.content)

				arg_136_1.text_.text = var_139_5

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_7 = 43 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 43)

				if (43 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 43)) > 0 and var_139_3 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_2
					end
				end

				arg_136_1.text_.text = var_139_5
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081033", "story_v_out_926081.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_926081", "926081033", "story_v_out_926081.awb") / 1000

					if var_139_8 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_2
					end

					if var_139_4.prefab_name ~= "" and arg_136_1.actors_[var_139_4.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_4.prefab_name].transform, "story_v_out_926081", "926081033", "story_v_out_926081.awb")

						arg_136_1:RecordAudio("926081033", var_139_9)
						arg_136_1:RecordAudio("926081033", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_926081", "926081033", "story_v_out_926081.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_926081", "926081033", "story_v_out_926081.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_3, arg_136_1.talkMaxDuration)

			if var_139_2 <= arg_136_1.time_ and arg_136_1.time_ < var_139_2 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_2) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_2 + var_139_10 and arg_136_1.time_ < var_139_2 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play926081034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 926081034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play926081035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["128404"]) and arg_140_1.var_.actorSpriteComps128404 == nil then
				arg_140_1.var_.actorSpriteComps128404 = arg_140_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["128404"]) then
				if arg_140_1.var_.actorSpriteComps128404 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								iter_143_1.color = Color.New(Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor2.r, (arg_140_1.time_ - 0) / var_143_0), Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor2.g, (arg_140_1.time_ - 0) / var_143_0), (Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor2.b, (arg_140_1.time_ - 0) / var_143_0)))
							else
								local var_143_1 = Mathf.Lerp(iter_143_1.color.r, 0.5, (arg_140_1.time_ - 0) / var_143_0)

								iter_143_1.color = Color.New(var_143_1, var_143_1, var_143_1)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["128404"]) and arg_140_1.var_.actorSpriteComps128404 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_140_1.var_.actorSpriteComps128404 = nil
			end

			local var_143_2 = 0
			local var_143_3 = 0.875

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_4 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(926081034).content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_6 = 35 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_4) / 35)

				if (35 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_4) / 35)) > 0 and var_143_3 < var_143_6 then
					arg_140_1.talkMaxDuration = var_143_6

					if var_143_6 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_7 and arg_140_1.time_ < var_143_2 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play926081035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 926081035
		arg_144_1.duration_ = 4.47

		local var_144_0 = {
			zh = 4.466,
			ja = 4.233
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play926081036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if arg_144_1.actors_["106603"] == nil then
				local var_147_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_147_0) then
					local var_147_1 = Object.Instantiate(var_147_0, arg_144_1.canvasGo_.transform)

					var_147_1.transform:SetSiblingIndex(1)

					var_147_1.name = "106603"
					var_147_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_144_1.actors_["106603"] = var_147_1

					if arg_144_1.isInRecall_ then
						for iter_147_0, iter_147_1 in ipairs((var_147_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_147_1.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_147_2 = arg_144_1.actors_["106603"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps106603 == nil then
				arg_144_1.var_.actorSpriteComps106603 = var_147_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_3 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 and not isNil(var_147_2) then
				if arg_144_1.var_.actorSpriteComps106603 then
					for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_147_3 then
							if arg_144_1.isInRecall_ then
								iter_147_3.color = Color.New(Mathf.Lerp(iter_147_3.color.r, arg_144_1.hightColor1.r, (arg_144_1.time_ - 0) / var_147_3), Mathf.Lerp(iter_147_3.color.g, arg_144_1.hightColor1.g, (arg_144_1.time_ - 0) / var_147_3), (Mathf.Lerp(iter_147_3.color.b, arg_144_1.hightColor1.b, (arg_144_1.time_ - 0) / var_147_3)))
							else
								local var_147_4 = Mathf.Lerp(iter_147_3.color.r, 1, (arg_144_1.time_ - 0) / var_147_3)

								iter_147_3.color = Color.New(var_147_4, var_147_4, var_147_4)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps106603 then
				for iter_147_4, iter_147_5 in pairs(arg_144_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_147_5 then
						iter_147_5.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_144_1.var_.actorSpriteComps106603 = nil
			end

			local var_147_5 = arg_144_1.actors_["128404"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos128404 = var_147_5.localPosition
				var_147_5.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("128404", 7)

				for iter_147_6 = 0, var_147_5.childCount - 1 do
					local var_147_6 = var_147_5:GetChild(iter_147_6)

					if var_147_6.name == "" or not string.find(var_147_6.name, "split") then
						var_147_6.gameObject:SetActive(true)
					else
						var_147_6.gameObject:SetActive(false)
					end
				end
			end

			local var_147_7 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				var_147_5.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_144_1.time_ - 0) / var_147_7)
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				var_147_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_147_8 = arg_144_1.actors_["106603"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos106603 = var_147_8.localPosition
				var_147_8.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("106603", 3)

				for iter_147_7 = 0, var_147_8.childCount - 1 do
					local var_147_9 = var_147_8:GetChild(iter_147_7)

					if var_147_9.name == "" or not string.find(var_147_9.name, "split") then
						var_147_9.gameObject:SetActive(true)
					else
						var_147_9.gameObject:SetActive(false)
					end
				end
			end

			local var_147_10 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_10 then
				var_147_8.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_144_1.time_ - 0) / var_147_10)
			end

			if arg_144_1.time_ >= 0 + var_147_10 and arg_144_1.time_ < 0 + var_147_10 + arg_147_0 then
				var_147_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_147_11 = 0
			local var_147_12 = 0.5

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_11 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_13 = arg_144_1:GetWordFromCfg(926081035)
				local var_147_14 = arg_144_1:FormatText(var_147_13.content)

				arg_144_1.text_.text = var_147_14

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_16 = 20 <= 0 and var_147_12 or var_147_12 * (utf8.len(var_147_14) / 20)

				if (20 <= 0 and var_147_12 or var_147_12 * (utf8.len(var_147_14) / 20)) > 0 and var_147_12 < var_147_16 then
					arg_144_1.talkMaxDuration = var_147_16

					if var_147_16 + var_147_11 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_16 + var_147_11
					end
				end

				arg_144_1.text_.text = var_147_14
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081035", "story_v_out_926081.awb") ~= 0 then
					local var_147_17 = manager.audio:GetVoiceLength("story_v_out_926081", "926081035", "story_v_out_926081.awb") / 1000

					if var_147_17 + var_147_11 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_17 + var_147_11
					end

					if var_147_13.prefab_name ~= "" and arg_144_1.actors_[var_147_13.prefab_name] ~= nil then
						local var_147_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_13.prefab_name].transform, "story_v_out_926081", "926081035", "story_v_out_926081.awb")

						arg_144_1:RecordAudio("926081035", var_147_18)
						arg_144_1:RecordAudio("926081035", var_147_18)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_926081", "926081035", "story_v_out_926081.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_926081", "926081035", "story_v_out_926081.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_19 = math.max(var_147_12, arg_144_1.talkMaxDuration)

			if var_147_11 <= arg_144_1.time_ and arg_144_1.time_ < var_147_11 + var_147_19 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_11) / var_147_19

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_11 + var_147_19 and arg_144_1.time_ < var_147_11 + var_147_19 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play926081036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 926081036
		arg_148_1.duration_ = 1

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"

			SetActive(arg_148_1.choicesGo_, true)

			for iter_149_0, iter_149_1 in ipairs(arg_148_1.choices_) do
				SetActive(iter_149_1.go, iter_149_0 <= 1)
			end

			arg_148_1.choices_[1].txt.text = arg_148_1:FormatText(StoryChoiceCfg[1330].name)
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play926081037(arg_148_1)
			end

			arg_148_1:RecordChoiceLog(926081036, 1330)
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["106603"]) and arg_148_1.var_.actorSpriteComps106603 == nil then
				arg_148_1.var_.actorSpriteComps106603 = arg_148_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["106603"]) then
				if arg_148_1.var_.actorSpriteComps106603 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								iter_151_1.color = Color.New(Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor2.r, (arg_148_1.time_ - 0) / var_151_0), Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor2.g, (arg_148_1.time_ - 0) / var_151_0), (Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor2.b, (arg_148_1.time_ - 0) / var_151_0)))
							else
								local var_151_1 = Mathf.Lerp(iter_151_1.color.r, 0.5, (arg_148_1.time_ - 0) / var_151_0)

								iter_151_1.color = Color.New(var_151_1, var_151_1, var_151_1)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["106603"]) and arg_148_1.var_.actorSpriteComps106603 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_151_3 then
						iter_151_3.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_148_1.var_.actorSpriteComps106603 = nil
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play926081037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 926081037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play926081038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos106603 = arg_152_1.actors_["106603"].transform.localPosition
				arg_152_1.actors_["106603"].transform.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("106603", 7)

				for iter_155_0 = 0, arg_152_1.actors_["106603"].transform.childCount - 1 do
					local var_155_0 = arg_152_1.actors_["106603"].transform:GetChild(iter_155_0)

					if var_155_0.name == "" or not string.find(var_155_0.name, "split") then
						var_155_0.gameObject:SetActive(true)
					else
						var_155_0.gameObject:SetActive(false)
					end
				end
			end

			local var_155_1 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_1 then
				arg_152_1.actors_["106603"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_152_1.time_ - 0) / var_155_1)
			end

			if arg_152_1.time_ >= 0 + var_155_1 and arg_152_1.time_ < 0 + var_155_1 + arg_155_0 then
				arg_152_1.actors_["106603"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_155_2 = 0
			local var_155_3 = 0.475

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_4 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(926081037).content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_6 = 31 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_4) / 31)

				if (31 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_4) / 31)) > 0 and var_155_3 < var_155_6 then
					arg_152_1.talkMaxDuration = var_155_6

					if var_155_6 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_7 and arg_152_1.time_ < var_155_2 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play926081038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 926081038
		arg_156_1.duration_ = 3.5

		local var_156_0 = {
			zh = 2.666,
			ja = 3.5
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
				arg_156_0:Play926081039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["128404"]) and arg_156_1.var_.actorSpriteComps128404 == nil then
				arg_156_1.var_.actorSpriteComps128404 = arg_156_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_0 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["128404"]) then
				if arg_156_1.var_.actorSpriteComps128404 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								iter_159_1.color = Color.New(Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor1.r, (arg_156_1.time_ - 0) / var_159_0), Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor1.g, (arg_156_1.time_ - 0) / var_159_0), (Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor1.b, (arg_156_1.time_ - 0) / var_159_0)))
							else
								local var_159_1 = Mathf.Lerp(iter_159_1.color.r, 1, (arg_156_1.time_ - 0) / var_159_0)

								iter_159_1.color = Color.New(var_159_1, var_159_1, var_159_1)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["128404"]) and arg_156_1.var_.actorSpriteComps128404 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_159_3 then
						iter_159_3.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_156_1.var_.actorSpriteComps128404 = nil
			end

			local var_159_2 = arg_156_1.actors_["128404"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos128404 = var_159_2.localPosition
				var_159_2.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("128404", 3)

				for iter_159_4 = 0, var_159_2.childCount - 1 do
					local var_159_3 = var_159_2:GetChild(iter_159_4)

					if var_159_3.name == "split_5" or not string.find(var_159_3.name, "split") then
						var_159_3.gameObject:SetActive(true)
					else
						var_159_3.gameObject:SetActive(false)
					end
				end
			end

			local var_159_4 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				var_159_2.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_156_1.time_ - 0) / var_159_4)
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				var_159_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_159_5 = 0
			local var_159_6 = 0.0329999998211861

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_7 = arg_156_1:GetWordFromCfg(926081038)
				local var_159_8 = arg_156_1:FormatText(var_159_7.content)

				arg_156_1.text_.text = var_159_8

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_10 = 9 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_8) / 9)

				if (9 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_8) / 9)) > 0 and var_159_6 < var_159_10 then
					arg_156_1.talkMaxDuration = var_159_10

					if var_159_10 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_5
					end
				end

				arg_156_1.text_.text = var_159_8
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081038", "story_v_out_926081.awb") ~= 0 then
					local var_159_11 = manager.audio:GetVoiceLength("story_v_out_926081", "926081038", "story_v_out_926081.awb") / 1000

					if var_159_11 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_5
					end

					if var_159_7.prefab_name ~= "" and arg_156_1.actors_[var_159_7.prefab_name] ~= nil then
						local var_159_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_7.prefab_name].transform, "story_v_out_926081", "926081038", "story_v_out_926081.awb")

						arg_156_1:RecordAudio("926081038", var_159_12)
						arg_156_1:RecordAudio("926081038", var_159_12)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_926081", "926081038", "story_v_out_926081.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_926081", "926081038", "story_v_out_926081.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_13 = math.max(var_159_6, arg_156_1.talkMaxDuration)

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_13 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_5) / var_159_13

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_5 + var_159_13 and arg_156_1.time_ < var_159_5 + var_159_13 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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

		arg_156_1:InitPlayNodeList()
	end,
	Play926081039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 926081039
		arg_160_1.duration_ = 6.2

		local var_160_0 = {
			zh = 6.2,
			ja = 5.833
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
				arg_160_0:Play926081040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["106603"]) and arg_160_1.var_.actorSpriteComps106603 == nil then
				arg_160_1.var_.actorSpriteComps106603 = arg_160_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_0 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["106603"]) then
				if arg_160_1.var_.actorSpriteComps106603 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_163_1 then
							if arg_160_1.isInRecall_ then
								iter_163_1.color = Color.New(Mathf.Lerp(iter_163_1.color.r, arg_160_1.hightColor1.r, (arg_160_1.time_ - 0) / var_163_0), Mathf.Lerp(iter_163_1.color.g, arg_160_1.hightColor1.g, (arg_160_1.time_ - 0) / var_163_0), (Mathf.Lerp(iter_163_1.color.b, arg_160_1.hightColor1.b, (arg_160_1.time_ - 0) / var_163_0)))
							else
								local var_163_1 = Mathf.Lerp(iter_163_1.color.r, 1, (arg_160_1.time_ - 0) / var_163_0)

								iter_163_1.color = Color.New(var_163_1, var_163_1, var_163_1)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["106603"]) and arg_160_1.var_.actorSpriteComps106603 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_163_3 then
						iter_163_3.color = arg_160_1.isInRecall_ and (arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_160_1.var_.actorSpriteComps106603 = nil
			end

			local var_163_2 = arg_160_1.actors_["128404"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.actorSpriteComps128404 == nil then
				arg_160_1.var_.actorSpriteComps128404 = var_163_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_3 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_3 and not isNil(var_163_2) then
				if arg_160_1.var_.actorSpriteComps128404 then
					for iter_163_4, iter_163_5 in pairs(arg_160_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_163_5 then
							if arg_160_1.isInRecall_ then
								iter_163_5.color = Color.New(Mathf.Lerp(iter_163_5.color.r, arg_160_1.hightColor2.r, (arg_160_1.time_ - 0) / var_163_3), Mathf.Lerp(iter_163_5.color.g, arg_160_1.hightColor2.g, (arg_160_1.time_ - 0) / var_163_3), (Mathf.Lerp(iter_163_5.color.b, arg_160_1.hightColor2.b, (arg_160_1.time_ - 0) / var_163_3)))
							else
								local var_163_4 = Mathf.Lerp(iter_163_5.color.r, 0.5, (arg_160_1.time_ - 0) / var_163_3)

								iter_163_5.color = Color.New(var_163_4, var_163_4, var_163_4)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= 0 + var_163_3 and arg_160_1.time_ < 0 + var_163_3 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.actorSpriteComps128404 then
				for iter_163_6, iter_163_7 in pairs(arg_160_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_163_7 then
						iter_163_7.color = arg_160_1.isInRecall_ and (arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_160_1.var_.actorSpriteComps128404 = nil
			end

			local var_163_5 = arg_160_1.actors_["128404"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos128404 = var_163_5.localPosition
				var_163_5.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("128404", 7)

				for iter_163_8 = 0, var_163_5.childCount - 1 do
					local var_163_6 = var_163_5:GetChild(iter_163_8)

					if var_163_6.name == "" or not string.find(var_163_6.name, "split") then
						var_163_6.gameObject:SetActive(true)
					else
						var_163_6.gameObject:SetActive(false)
					end
				end
			end

			local var_163_7 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				var_163_5.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_160_1.time_ - 0) / var_163_7)
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				var_163_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_163_8 = arg_160_1.actors_["106603"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos106603 = var_163_8.localPosition
				var_163_8.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("106603", 3)

				for iter_163_9 = 0, var_163_8.childCount - 1 do
					local var_163_9 = var_163_8:GetChild(iter_163_9)

					if var_163_9.name == "split_4" or not string.find(var_163_9.name, "split") then
						var_163_9.gameObject:SetActive(true)
					else
						var_163_9.gameObject:SetActive(false)
					end
				end
			end

			local var_163_10 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_10 then
				var_163_8.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_160_1.time_ - 0) / var_163_10)
			end

			if arg_160_1.time_ >= 0 + var_163_10 and arg_160_1.time_ < 0 + var_163_10 + arg_163_0 then
				var_163_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_163_11 = 0
			local var_163_12 = 0.0329999998211861

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_11 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_13 = arg_160_1:GetWordFromCfg(926081039)
				local var_163_14 = arg_160_1:FormatText(var_163_13.content)

				arg_160_1.text_.text = var_163_14

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_16 = 29 <= 0 and var_163_12 or var_163_12 * (utf8.len(var_163_14) / 29)

				if (29 <= 0 and var_163_12 or var_163_12 * (utf8.len(var_163_14) / 29)) > 0 and var_163_12 < var_163_16 then
					arg_160_1.talkMaxDuration = var_163_16

					if var_163_16 + var_163_11 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_16 + var_163_11
					end
				end

				arg_160_1.text_.text = var_163_14
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081039", "story_v_out_926081.awb") ~= 0 then
					local var_163_17 = manager.audio:GetVoiceLength("story_v_out_926081", "926081039", "story_v_out_926081.awb") / 1000

					if var_163_17 + var_163_11 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_17 + var_163_11
					end

					if var_163_13.prefab_name ~= "" and arg_160_1.actors_[var_163_13.prefab_name] ~= nil then
						local var_163_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_13.prefab_name].transform, "story_v_out_926081", "926081039", "story_v_out_926081.awb")

						arg_160_1:RecordAudio("926081039", var_163_18)
						arg_160_1:RecordAudio("926081039", var_163_18)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_926081", "926081039", "story_v_out_926081.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_926081", "926081039", "story_v_out_926081.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_19 = math.max(var_163_12, arg_160_1.talkMaxDuration)

			if var_163_11 <= arg_160_1.time_ and arg_160_1.time_ < var_163_11 + var_163_19 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_11) / var_163_19

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_11 + var_163_19 and arg_160_1.time_ < var_163_11 + var_163_19 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
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

		arg_160_1:InitPlayNodeList()
	end,
	Play926081040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 926081040
		arg_164_1.duration_ = 4.93

		local var_164_0 = {
			zh = 3.4,
			ja = 4.933
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
				arg_164_0:Play926081041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["10144"]) and arg_164_1.var_.actorSpriteComps10144 == nil then
				arg_164_1.var_.actorSpriteComps10144 = arg_164_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_0 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["10144"]) then
				if arg_164_1.var_.actorSpriteComps10144 then
					for iter_167_0, iter_167_1 in pairs(arg_164_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_167_1 then
							if arg_164_1.isInRecall_ then
								iter_167_1.color = Color.New(Mathf.Lerp(iter_167_1.color.r, arg_164_1.hightColor1.r, (arg_164_1.time_ - 0) / var_167_0), Mathf.Lerp(iter_167_1.color.g, arg_164_1.hightColor1.g, (arg_164_1.time_ - 0) / var_167_0), (Mathf.Lerp(iter_167_1.color.b, arg_164_1.hightColor1.b, (arg_164_1.time_ - 0) / var_167_0)))
							else
								local var_167_1 = Mathf.Lerp(iter_167_1.color.r, 1, (arg_164_1.time_ - 0) / var_167_0)

								iter_167_1.color = Color.New(var_167_1, var_167_1, var_167_1)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["10144"]) and arg_164_1.var_.actorSpriteComps10144 then
				for iter_167_2, iter_167_3 in pairs(arg_164_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_167_3 then
						iter_167_3.color = arg_164_1.isInRecall_ and (arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_164_1.var_.actorSpriteComps10144 = nil
			end

			local var_167_2 = arg_164_1.actors_["106603"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.actorSpriteComps106603 == nil then
				arg_164_1.var_.actorSpriteComps106603 = var_167_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_3 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_3 and not isNil(var_167_2) then
				if arg_164_1.var_.actorSpriteComps106603 then
					for iter_167_4, iter_167_5 in pairs(arg_164_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_167_5 then
							if arg_164_1.isInRecall_ then
								iter_167_5.color = Color.New(Mathf.Lerp(iter_167_5.color.r, arg_164_1.hightColor2.r, (arg_164_1.time_ - 0) / var_167_3), Mathf.Lerp(iter_167_5.color.g, arg_164_1.hightColor2.g, (arg_164_1.time_ - 0) / var_167_3), (Mathf.Lerp(iter_167_5.color.b, arg_164_1.hightColor2.b, (arg_164_1.time_ - 0) / var_167_3)))
							else
								local var_167_4 = Mathf.Lerp(iter_167_5.color.r, 0.5, (arg_164_1.time_ - 0) / var_167_3)

								iter_167_5.color = Color.New(var_167_4, var_167_4, var_167_4)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= 0 + var_167_3 and arg_164_1.time_ < 0 + var_167_3 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.actorSpriteComps106603 then
				for iter_167_6, iter_167_7 in pairs(arg_164_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_167_7 then
						iter_167_7.color = arg_164_1.isInRecall_ and (arg_164_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_164_1.var_.actorSpriteComps106603 = nil
			end

			local var_167_5 = arg_164_1.actors_["10144"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos10144 = var_167_5.localPosition
				var_167_5.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("10144", 3)

				for iter_167_8 = 0, var_167_5.childCount - 1 do
					local var_167_6 = var_167_5:GetChild(iter_167_8)

					if var_167_6.name == "" or not string.find(var_167_6.name, "split") then
						var_167_6.gameObject:SetActive(true)
					else
						var_167_6.gameObject:SetActive(false)
					end
				end
			end

			local var_167_7 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				var_167_5.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_164_1.time_ - 0) / var_167_7)
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				var_167_5.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_167_8 = 0
			local var_167_9 = 0.0329999998211861

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_8 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_10 = arg_164_1:GetWordFromCfg(926081040)
				local var_167_11 = arg_164_1:FormatText(var_167_10.content)

				arg_164_1.text_.text = var_167_11

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_13 = 18 <= 0 and var_167_9 or var_167_9 * (utf8.len(var_167_11) / 18)

				if (18 <= 0 and var_167_9 or var_167_9 * (utf8.len(var_167_11) / 18)) > 0 and var_167_9 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_8
					end
				end

				arg_164_1.text_.text = var_167_11
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081040", "story_v_out_926081.awb") ~= 0 then
					local var_167_14 = manager.audio:GetVoiceLength("story_v_out_926081", "926081040", "story_v_out_926081.awb") / 1000

					if var_167_14 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_8
					end

					if var_167_10.prefab_name ~= "" and arg_164_1.actors_[var_167_10.prefab_name] ~= nil then
						local var_167_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_10.prefab_name].transform, "story_v_out_926081", "926081040", "story_v_out_926081.awb")

						arg_164_1:RecordAudio("926081040", var_167_15)
						arg_164_1:RecordAudio("926081040", var_167_15)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_926081", "926081040", "story_v_out_926081.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_926081", "926081040", "story_v_out_926081.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_9, arg_164_1.talkMaxDuration)

			if var_167_8 <= arg_164_1.time_ and arg_164_1.time_ < var_167_8 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_8) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_8 + var_167_16 and arg_164_1.time_ < var_167_8 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play926081041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 926081041
		arg_168_1.duration_ = 6.67

		local var_168_0 = {
			zh = 4.9,
			ja = 6.666
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
			arg_168_1.auto_ = false
		end

		function arg_168_1.playNext_(arg_170_0)
			arg_168_1.onStoryFinished_()
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos10144 = arg_168_1.actors_["10144"].transform.localPosition
				arg_168_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10144", 3)

				for iter_171_0 = 0, arg_168_1.actors_["10144"].transform.childCount - 1 do
					local var_171_0 = arg_168_1.actors_["10144"].transform:GetChild(iter_171_0)

					if var_171_0.name == "split_7" or not string.find(var_171_0.name, "split") then
						var_171_0.gameObject:SetActive(true)
					else
						var_171_0.gameObject:SetActive(false)
					end
				end
			end

			local var_171_1 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_1 then
				arg_168_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_168_1.time_ - 0) / var_171_1)
			end

			if arg_168_1.time_ >= 0 + var_171_1 and arg_168_1.time_ < 0 + var_171_1 + arg_171_0 then
				arg_168_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_171_2 = 0
			local var_171_3 = 0.0329999998211861

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_2 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_4 = arg_168_1:GetWordFromCfg(926081041)
				local var_171_5 = arg_168_1:FormatText(var_171_4.content)

				arg_168_1.text_.text = var_171_5

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_7 = 19 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 19)

				if (19 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 19)) > 0 and var_171_3 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_2
					end
				end

				arg_168_1.text_.text = var_171_5
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926081", "926081041", "story_v_out_926081.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_926081", "926081041", "story_v_out_926081.awb") / 1000

					if var_171_8 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_2
					end

					if var_171_4.prefab_name ~= "" and arg_168_1.actors_[var_171_4.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_4.prefab_name].transform, "story_v_out_926081", "926081041", "story_v_out_926081.awb")

						arg_168_1:RecordAudio("926081041", var_171_9)
						arg_168_1:RecordAudio("926081041", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_926081", "926081041", "story_v_out_926081.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_926081", "926081041", "story_v_out_926081.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_3, arg_168_1.talkMaxDuration)

			if var_171_2 <= arg_168_1.time_ and arg_168_1.time_ < var_171_2 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_2) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_2 + var_171_10 and arg_168_1.time_ < var_171_2 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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

		arg_168_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I20f"
	},
	voices = {
		"story_v_out_926081.awb"
	}
}
