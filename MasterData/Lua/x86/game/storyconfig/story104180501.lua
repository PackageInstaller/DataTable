return {
	Play418051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418051001
		arg_1_1.duration_ = 4.27

		local var_1_0 = {
			ja = 4.266,
			CriLanguages = 3.9,
			zh = 3.9
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
				arg_1_0:Play418051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 0 + 0.3 and arg_1_1.time_ < 0 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 2.1

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = Color.New(0, 0, 0)

				var_4_2.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_0) / var_4_1)
				arg_1_1.mask_.color = var_4_2
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_3 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_3.a = 0
				arg_1_1.mask_.color = var_4_3
			end

			local var_4_4 = "1073"

			if arg_1_1.actors_["1073"] == nil then
				local var_4_5 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1073")

				if not isNil(var_4_5) then
					local var_4_6 = Object.Instantiate(var_4_5, arg_1_1.canvasGo_.transform)

					var_4_6.transform:SetSiblingIndex(1)

					var_4_6.name = var_4_4
					var_4_6.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_4] = var_4_6

					if arg_1_1.isInRecall_ then
						for iter_4_0, iter_4_1 in ipairs((var_4_6:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_1.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_7 = arg_1_1.actors_["1073"]

			if 1.799999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.799999999999 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.actorSpriteComps1073 == nil then
				arg_1_1.var_.actorSpriteComps1073 = var_4_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_8 = 0.2

			if 1.799999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.799999999999 + var_4_8 and not isNil(var_4_7) then
				if arg_1_1.var_.actorSpriteComps1073 then
					for iter_4_2, iter_4_3 in pairs(arg_1_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_4_3 then
							if arg_1_1.isInRecall_ then
								iter_4_3.color = Color.New(Mathf.Lerp(iter_4_3.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.799999999999) / var_4_8), Mathf.Lerp(iter_4_3.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.799999999999) / var_4_8), (Mathf.Lerp(iter_4_3.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.799999999999) / var_4_8)))
							else
								local var_4_9 = Mathf.Lerp(iter_4_3.color.r, 1, (arg_1_1.time_ - 1.799999999999) / var_4_8)

								iter_4_3.color = Color.New(var_4_9, var_4_9, var_4_9)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.799999999999 + var_4_8 and arg_1_1.time_ < 1.799999999999 + var_4_8 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.actorSpriteComps1073 then
				for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_4_5 then
						iter_4_5.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1073 = nil
			end

			local var_4_10 = arg_1_1.actors_["1073"].transform

			if 1.799999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.799999999999 + arg_4_0 then
				arg_1_1.var_.moveOldPos1073 = var_4_10.localPosition
				var_4_10.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1073", 3)

				for iter_4_6 = 0, var_4_10.childCount - 1 do
					local var_4_11 = var_4_10:GetChild(iter_4_6)

					if var_4_11.name == "split_1" or not string.find(var_4_11.name, "split") then
						var_4_11.gameObject:SetActive(true)
					else
						var_4_11.gameObject:SetActive(false)
					end
				end
			end

			local var_4_12 = 0.001

			if 1.799999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.799999999999 + var_4_12 then
				var_4_10.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1073, Vector3.New(38.6, -414.5, -207.2), (arg_1_1.time_ - 1.799999999999) / var_4_12)
			end

			if arg_1_1.time_ >= 1.799999999999 + var_4_12 and arg_1_1.time_ < 1.799999999999 + var_4_12 + arg_4_0 then
				var_4_10.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			if 1.799999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.799999999999 + arg_4_0 then
				local var_4_13 = arg_1_1.actors_["1073"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_13 then
					arg_1_1.var_.alphaOldValue1073 = var_4_13.alpha
					arg_1_1.var_.characterEffect1073 = var_4_13
				end

				arg_1_1.var_.alphaOldValue1073 = 0
			end

			local var_4_14 = 0.2

			if 1.799999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.799999999999 + var_4_14 then
				if arg_1_1.var_.characterEffect1073 then
					arg_1_1.var_.characterEffect1073.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue1073, 1, (arg_1_1.time_ - 1.799999999999) / var_4_14)
				end
			end

			if arg_1_1.time_ >= 1.799999999999 + var_4_14 and arg_1_1.time_ < 1.799999999999 + var_4_14 + arg_4_0 and arg_1_1.var_.characterEffect1073 then
				arg_1_1.var_.characterEffect1073.alpha = 1
			end

			local var_4_15 = "ST1002"

			if arg_1_1.bgs_.ST1002 == nil then
				local var_4_16 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_15)
				var_4_16.name = var_4_15
				var_4_16.transform.parent = arg_1_1.stage_.transform
				var_4_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_15] = var_4_16
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_17 = arg_1_1.bgs_.ST1002

				arg_1_1.bgs_.ST1002.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_18 = var_4_17:GetComponent("SpriteRenderer")

				if var_4_18 and var_4_18.sprite then
					local var_4_19 = 2 * (var_4_17.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_17.transform.localScale = Vector3.New(var_4_19 / var_4_18.sprite.bounds.size.y < var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x and var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x or var_4_19 / var_4_18.sprite.bounds.size.y, var_4_19 / var_4_18.sprite.bounds.size.y < var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x and var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x or var_4_19 / var_4_18.sprite.bounds.size.y, 0)
				end

				for iter_4_7, iter_4_8 in pairs(arg_1_1.bgs_) do
					if iter_4_7 ~= "ST1002" then
						iter_4_8.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.05 < arg_1_1.time_ and arg_1_1.time_ <= 0.05 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street", "")
			end

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			local var_4_24 = 2.1
			local var_4_25 = 0.2

			if 2.1 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(418051001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 8 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 8)

				if (8 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 8)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051001", "story_v_side_old_418051.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051001", "story_v_side_old_418051.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_side_old_418051", "418051001", "story_v_side_old_418051.awb")

						arg_1_1:RecordAudio("418051001", var_4_32)
						arg_1_1:RecordAudio("418051001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051001", "story_v_side_old_418051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051001", "story_v_side_old_418051.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
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
	Play418051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418051002
		arg_8_1.duration_ = 2.2

		local var_8_0 = {
			ja = 1.366,
			CriLanguages = 2.2,
			zh = 2.2
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play418051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["10135"] == nil then
				local var_11_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10135")

				if not isNil(var_11_0) then
					local var_11_1 = Object.Instantiate(var_11_0, arg_8_1.canvasGo_.transform)

					var_11_1.transform:SetSiblingIndex(1)

					var_11_1.name = "10135"
					var_11_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_8_1.actors_["10135"] = var_11_1

					if arg_8_1.isInRecall_ then
						for iter_11_0, iter_11_1 in ipairs((var_11_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_11_1.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_11_2 = arg_8_1.actors_["10135"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps10135 == nil then
				arg_8_1.var_.actorSpriteComps10135 = var_11_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_3 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_3 and not isNil(var_11_2) then
				if arg_8_1.var_.actorSpriteComps10135 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_11_3 then
							if arg_8_1.isInRecall_ then
								iter_11_3.color = Color.New(Mathf.Lerp(iter_11_3.color.r, arg_8_1.hightColor1.r, (arg_8_1.time_ - 0) / var_11_3), Mathf.Lerp(iter_11_3.color.g, arg_8_1.hightColor1.g, (arg_8_1.time_ - 0) / var_11_3), (Mathf.Lerp(iter_11_3.color.b, arg_8_1.hightColor1.b, (arg_8_1.time_ - 0) / var_11_3)))
							else
								local var_11_4 = Mathf.Lerp(iter_11_3.color.r, 1, (arg_8_1.time_ - 0) / var_11_3)

								iter_11_3.color = Color.New(var_11_4, var_11_4, var_11_4)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= 0 + var_11_3 and arg_8_1.time_ < 0 + var_11_3 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps10135 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_11_5 then
						iter_11_5.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_8_1.var_.actorSpriteComps10135 = nil
			end

			local var_11_5 = arg_8_1.actors_["1073"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.actorSpriteComps1073 == nil then
				arg_8_1.var_.actorSpriteComps1073 = var_11_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.actorSpriteComps1073 then
					for iter_11_6, iter_11_7 in pairs(arg_8_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_11_7 then
							if arg_8_1.isInRecall_ then
								iter_11_7.color = Color.New(Mathf.Lerp(iter_11_7.color.r, arg_8_1.hightColor2.r, (arg_8_1.time_ - 0) / var_11_6), Mathf.Lerp(iter_11_7.color.g, arg_8_1.hightColor2.g, (arg_8_1.time_ - 0) / var_11_6), (Mathf.Lerp(iter_11_7.color.b, arg_8_1.hightColor2.b, (arg_8_1.time_ - 0) / var_11_6)))
							else
								local var_11_7 = Mathf.Lerp(iter_11_7.color.r, 0.5, (arg_8_1.time_ - 0) / var_11_6)

								iter_11_7.color = Color.New(var_11_7, var_11_7, var_11_7)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.actorSpriteComps1073 then
				for iter_11_8, iter_11_9 in pairs(arg_8_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_11_9 then
						iter_11_9.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_8_1.var_.actorSpriteComps1073 = nil
			end

			local var_11_8 = arg_8_1.actors_["1073"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1073 = var_11_8.localPosition
				var_11_8.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("1073", 7)

				for iter_11_10 = 0, var_11_8.childCount - 1 do
					local var_11_9 = var_11_8:GetChild(iter_11_10)

					if var_11_9.name == "" or not string.find(var_11_9.name, "split") then
						var_11_9.gameObject:SetActive(true)
					else
						var_11_9.gameObject:SetActive(false)
					end
				end
			end

			local var_11_10 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_10 then
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_8_1.time_ - 0) / var_11_10)
			end

			if arg_8_1.time_ >= 0 + var_11_10 and arg_8_1.time_ < 0 + var_11_10 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_11_11 = arg_8_1.actors_["10135"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos10135 = var_11_11.localPosition
				var_11_11.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10135", 3)

				for iter_11_11 = 0, var_11_11.childCount - 1 do
					local var_11_12 = var_11_11:GetChild(iter_11_11)

					if var_11_12.name == "split_5" or not string.find(var_11_12.name, "split") then
						var_11_12.gameObject:SetActive(true)
					else
						var_11_12.gameObject:SetActive(false)
					end
				end
			end

			local var_11_13 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_13 then
				var_11_11.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10135, Vector3.New(-12.7, -363.6, -305.9), (arg_8_1.time_ - 0) / var_11_13)
			end

			if arg_8_1.time_ >= 0 + var_11_13 and arg_8_1.time_ < 0 + var_11_13 + arg_11_0 then
				var_11_11.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_11_14 = arg_8_1.actors_["1073"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1073 = var_11_14.localPosition
				var_11_14.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("1073", 7)

				for iter_11_12 = 0, var_11_14.childCount - 1 do
					local var_11_15 = var_11_14:GetChild(iter_11_12)

					if var_11_15.name == "split_1" or not string.find(var_11_15.name, "split") then
						var_11_15.gameObject:SetActive(true)
					else
						var_11_15.gameObject:SetActive(false)
					end
				end
			end

			local var_11_16 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_16 then
				var_11_14.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_8_1.time_ - 0) / var_11_16)
			end

			if arg_8_1.time_ >= 0 + var_11_16 and arg_8_1.time_ < 0 + var_11_16 + arg_11_0 then
				var_11_14.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_11_17 = 0
			local var_11_18 = 0.125

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_19 = arg_8_1:GetWordFromCfg(418051002)
				local var_11_20 = arg_8_1:FormatText(var_11_19.content)

				arg_8_1.text_.text = var_11_20

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_22 = 5 <= 0 and var_11_18 or var_11_18 * (utf8.len(var_11_20) / 5)

				if (5 <= 0 and var_11_18 or var_11_18 * (utf8.len(var_11_20) / 5)) > 0 and var_11_18 < var_11_22 then
					arg_8_1.talkMaxDuration = var_11_22

					if var_11_22 + var_11_17 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_22 + var_11_17
					end
				end

				arg_8_1.text_.text = var_11_20
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051002", "story_v_side_old_418051.awb") ~= 0 then
					local var_11_23 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051002", "story_v_side_old_418051.awb") / 1000

					if var_11_23 + var_11_17 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_23 + var_11_17
					end

					if var_11_19.prefab_name ~= "" and arg_8_1.actors_[var_11_19.prefab_name] ~= nil then
						local var_11_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_19.prefab_name].transform, "story_v_side_old_418051", "418051002", "story_v_side_old_418051.awb")

						arg_8_1:RecordAudio("418051002", var_11_24)
						arg_8_1:RecordAudio("418051002", var_11_24)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051002", "story_v_side_old_418051.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051002", "story_v_side_old_418051.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_25 = math.max(var_11_18, arg_8_1.talkMaxDuration)

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_25 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_17) / var_11_25

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_17 + var_11_25 and arg_8_1.time_ < var_11_17 + var_11_25 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play418051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418051003
		arg_12_1.duration_ = 3.6

		local var_12_0 = {
			ja = 3.066,
			CriLanguages = 3.6,
			zh = 3.6
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play418051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1073"]) and arg_12_1.var_.actorSpriteComps1073 == nil then
				arg_12_1.var_.actorSpriteComps1073 = arg_12_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_0 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1073"]) then
				if arg_12_1.var_.actorSpriteComps1073 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_15_1 then
							if arg_12_1.isInRecall_ then
								iter_15_1.color = Color.New(Mathf.Lerp(iter_15_1.color.r, arg_12_1.hightColor1.r, (arg_12_1.time_ - 0) / var_15_0), Mathf.Lerp(iter_15_1.color.g, arg_12_1.hightColor1.g, (arg_12_1.time_ - 0) / var_15_0), (Mathf.Lerp(iter_15_1.color.b, arg_12_1.hightColor1.b, (arg_12_1.time_ - 0) / var_15_0)))
							else
								local var_15_1 = Mathf.Lerp(iter_15_1.color.r, 1, (arg_12_1.time_ - 0) / var_15_0)

								iter_15_1.color = Color.New(var_15_1, var_15_1, var_15_1)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1073"]) and arg_12_1.var_.actorSpriteComps1073 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_15_3 then
						iter_15_3.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_12_1.var_.actorSpriteComps1073 = nil
			end

			local var_15_2 = arg_12_1.actors_["10135"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.actorSpriteComps10135 == nil then
				arg_12_1.var_.actorSpriteComps10135 = var_15_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_3 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 and not isNil(var_15_2) then
				if arg_12_1.var_.actorSpriteComps10135 then
					for iter_15_4, iter_15_5 in pairs(arg_12_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_15_5 then
							if arg_12_1.isInRecall_ then
								iter_15_5.color = Color.New(Mathf.Lerp(iter_15_5.color.r, arg_12_1.hightColor2.r, (arg_12_1.time_ - 0) / var_15_3), Mathf.Lerp(iter_15_5.color.g, arg_12_1.hightColor2.g, (arg_12_1.time_ - 0) / var_15_3), (Mathf.Lerp(iter_15_5.color.b, arg_12_1.hightColor2.b, (arg_12_1.time_ - 0) / var_15_3)))
							else
								local var_15_4 = Mathf.Lerp(iter_15_5.color.r, 0.5, (arg_12_1.time_ - 0) / var_15_3)

								iter_15_5.color = Color.New(var_15_4, var_15_4, var_15_4)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.actorSpriteComps10135 then
				for iter_15_6, iter_15_7 in pairs(arg_12_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_15_7 then
						iter_15_7.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_12_1.var_.actorSpriteComps10135 = nil
			end

			local var_15_5 = arg_12_1.actors_["10135"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos10135 = var_15_5.localPosition
				var_15_5.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10135", 4)

				for iter_15_8 = 0, var_15_5.childCount - 1 do
					local var_15_6 = var_15_5:GetChild(iter_15_8)

					if var_15_6.name == "split_5" or not string.find(var_15_6.name, "split") then
						var_15_6.gameObject:SetActive(true)
					else
						var_15_6.gameObject:SetActive(false)
					end
				end
			end

			local var_15_7 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_12_1.time_ - 0) / var_15_7)
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_15_8 = arg_12_1.actors_["1073"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1073 = var_15_8.localPosition
				var_15_8.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("1073", 2)

				for iter_15_9 = 0, var_15_8.childCount - 1 do
					local var_15_9 = var_15_8:GetChild(iter_15_9)

					if var_15_9.name == "" or not string.find(var_15_9.name, "split") then
						var_15_9.gameObject:SetActive(true)
					else
						var_15_9.gameObject:SetActive(false)
					end
				end
			end

			local var_15_10 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_10 then
				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_12_1.time_ - 0) / var_15_10)
			end

			if arg_12_1.time_ >= 0 + var_15_10 and arg_12_1.time_ < 0 + var_15_10 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_15_11 = 0
			local var_15_12 = 0.35

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_13 = arg_12_1:GetWordFromCfg(418051003)
				local var_15_14 = arg_12_1:FormatText(var_15_13.content)

				arg_12_1.text_.text = var_15_14

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_16 = 14 <= 0 and var_15_12 or var_15_12 * (utf8.len(var_15_14) / 14)

				if (14 <= 0 and var_15_12 or var_15_12 * (utf8.len(var_15_14) / 14)) > 0 and var_15_12 < var_15_16 then
					arg_12_1.talkMaxDuration = var_15_16

					if var_15_16 + var_15_11 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_11
					end
				end

				arg_12_1.text_.text = var_15_14
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051003", "story_v_side_old_418051.awb") ~= 0 then
					local var_15_17 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051003", "story_v_side_old_418051.awb") / 1000

					if var_15_17 + var_15_11 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_11
					end

					if var_15_13.prefab_name ~= "" and arg_12_1.actors_[var_15_13.prefab_name] ~= nil then
						local var_15_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_13.prefab_name].transform, "story_v_side_old_418051", "418051003", "story_v_side_old_418051.awb")

						arg_12_1:RecordAudio("418051003", var_15_18)
						arg_12_1:RecordAudio("418051003", var_15_18)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051003", "story_v_side_old_418051.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051003", "story_v_side_old_418051.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_19 = math.max(var_15_12, arg_12_1.talkMaxDuration)

			if var_15_11 <= arg_12_1.time_ and arg_12_1.time_ < var_15_11 + var_15_19 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_11) / var_15_19

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_11 + var_15_19 and arg_12_1.time_ < var_15_11 + var_15_19 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play418051004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418051004
		arg_16_1.duration_ = 5.8

		local var_16_0 = {
			ja = 3.4,
			CriLanguages = 5.8,
			zh = 5.8
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play418051005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["10135"]) and arg_16_1.var_.actorSpriteComps10135 == nil then
				arg_16_1.var_.actorSpriteComps10135 = arg_16_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_0 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["10135"]) then
				if arg_16_1.var_.actorSpriteComps10135 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_19_1 then
							if arg_16_1.isInRecall_ then
								iter_19_1.color = Color.New(Mathf.Lerp(iter_19_1.color.r, arg_16_1.hightColor1.r, (arg_16_1.time_ - 0) / var_19_0), Mathf.Lerp(iter_19_1.color.g, arg_16_1.hightColor1.g, (arg_16_1.time_ - 0) / var_19_0), (Mathf.Lerp(iter_19_1.color.b, arg_16_1.hightColor1.b, (arg_16_1.time_ - 0) / var_19_0)))
							else
								local var_19_1 = Mathf.Lerp(iter_19_1.color.r, 1, (arg_16_1.time_ - 0) / var_19_0)

								iter_19_1.color = Color.New(var_19_1, var_19_1, var_19_1)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["10135"]) and arg_16_1.var_.actorSpriteComps10135 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_19_3 then
						iter_19_3.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_16_1.var_.actorSpriteComps10135 = nil
			end

			local var_19_2 = arg_16_1.actors_["1073"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.actorSpriteComps1073 == nil then
				arg_16_1.var_.actorSpriteComps1073 = var_19_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_3 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 and not isNil(var_19_2) then
				if arg_16_1.var_.actorSpriteComps1073 then
					for iter_19_4, iter_19_5 in pairs(arg_16_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_19_5 then
							if arg_16_1.isInRecall_ then
								iter_19_5.color = Color.New(Mathf.Lerp(iter_19_5.color.r, arg_16_1.hightColor2.r, (arg_16_1.time_ - 0) / var_19_3), Mathf.Lerp(iter_19_5.color.g, arg_16_1.hightColor2.g, (arg_16_1.time_ - 0) / var_19_3), (Mathf.Lerp(iter_19_5.color.b, arg_16_1.hightColor2.b, (arg_16_1.time_ - 0) / var_19_3)))
							else
								local var_19_4 = Mathf.Lerp(iter_19_5.color.r, 0.5, (arg_16_1.time_ - 0) / var_19_3)

								iter_19_5.color = Color.New(var_19_4, var_19_4, var_19_4)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.actorSpriteComps1073 then
				for iter_19_6, iter_19_7 in pairs(arg_16_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_19_7 then
						iter_19_7.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_16_1.var_.actorSpriteComps1073 = nil
			end

			local var_19_5 = arg_16_1.actors_["10135"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10135 = var_19_5.localPosition
				var_19_5.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10135", 4)

				for iter_19_8 = 0, var_19_5.childCount - 1 do
					local var_19_6 = var_19_5:GetChild(iter_19_8)

					if var_19_6.name == "split_5" or not string.find(var_19_6.name, "split") then
						var_19_6.gameObject:SetActive(true)
					else
						var_19_6.gameObject:SetActive(false)
					end
				end
			end

			local var_19_7 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_16_1.time_ - 0) / var_19_7)
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_19_8 = 0
			local var_19_9 = 0.6

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(418051004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 24 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 24)

				if (24 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 24)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051004", "story_v_side_old_418051.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051004", "story_v_side_old_418051.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_side_old_418051", "418051004", "story_v_side_old_418051.awb")

						arg_16_1:RecordAudio("418051004", var_19_15)
						arg_16_1:RecordAudio("418051004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051004", "story_v_side_old_418051.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051004", "story_v_side_old_418051.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play418051005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418051005
		arg_20_1.duration_ = 7.33

		local var_20_0 = {
			ja = 7.333,
			CriLanguages = 6.033,
			zh = 6.033
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play418051006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1073"]) and arg_20_1.var_.actorSpriteComps1073 == nil then
				arg_20_1.var_.actorSpriteComps1073 = arg_20_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1073"]) then
				if arg_20_1.var_.actorSpriteComps1073 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_23_1 then
							if arg_20_1.isInRecall_ then
								iter_23_1.color = Color.New(Mathf.Lerp(iter_23_1.color.r, arg_20_1.hightColor1.r, (arg_20_1.time_ - 0) / var_23_0), Mathf.Lerp(iter_23_1.color.g, arg_20_1.hightColor1.g, (arg_20_1.time_ - 0) / var_23_0), (Mathf.Lerp(iter_23_1.color.b, arg_20_1.hightColor1.b, (arg_20_1.time_ - 0) / var_23_0)))
							else
								local var_23_1 = Mathf.Lerp(iter_23_1.color.r, 1, (arg_20_1.time_ - 0) / var_23_0)

								iter_23_1.color = Color.New(var_23_1, var_23_1, var_23_1)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1073"]) and arg_20_1.var_.actorSpriteComps1073 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_23_3 then
						iter_23_3.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_20_1.var_.actorSpriteComps1073 = nil
			end

			local var_23_2 = arg_20_1.actors_["10135"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps10135 == nil then
				arg_20_1.var_.actorSpriteComps10135 = var_23_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_3 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.actorSpriteComps10135 then
					for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_23_5 then
							if arg_20_1.isInRecall_ then
								iter_23_5.color = Color.New(Mathf.Lerp(iter_23_5.color.r, arg_20_1.hightColor2.r, (arg_20_1.time_ - 0) / var_23_3), Mathf.Lerp(iter_23_5.color.g, arg_20_1.hightColor2.g, (arg_20_1.time_ - 0) / var_23_3), (Mathf.Lerp(iter_23_5.color.b, arg_20_1.hightColor2.b, (arg_20_1.time_ - 0) / var_23_3)))
							else
								local var_23_4 = Mathf.Lerp(iter_23_5.color.r, 0.5, (arg_20_1.time_ - 0) / var_23_3)

								iter_23_5.color = Color.New(var_23_4, var_23_4, var_23_4)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps10135 then
				for iter_23_6, iter_23_7 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_23_7 then
						iter_23_7.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_20_1.var_.actorSpriteComps10135 = nil
			end

			local var_23_5 = 0
			local var_23_6 = 0.65

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_7 = arg_20_1:GetWordFromCfg(418051005)
				local var_23_8 = arg_20_1:FormatText(var_23_7.content)

				arg_20_1.text_.text = var_23_8

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_10 = 26 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_8) / 26)

				if (26 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_8) / 26)) > 0 and var_23_6 < var_23_10 then
					arg_20_1.talkMaxDuration = var_23_10

					if var_23_10 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_5
					end
				end

				arg_20_1.text_.text = var_23_8
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051005", "story_v_side_old_418051.awb") ~= 0 then
					local var_23_11 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051005", "story_v_side_old_418051.awb") / 1000

					if var_23_11 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_5
					end

					if var_23_7.prefab_name ~= "" and arg_20_1.actors_[var_23_7.prefab_name] ~= nil then
						local var_23_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_7.prefab_name].transform, "story_v_side_old_418051", "418051005", "story_v_side_old_418051.awb")

						arg_20_1:RecordAudio("418051005", var_23_12)
						arg_20_1:RecordAudio("418051005", var_23_12)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051005", "story_v_side_old_418051.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051005", "story_v_side_old_418051.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_13 = math.max(var_23_6, arg_20_1.talkMaxDuration)

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_13 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_5) / var_23_13

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_5 + var_23_13 and arg_20_1.time_ < var_23_5 + var_23_13 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play418051006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418051006
		arg_24_1.duration_ = 16.3

		local var_24_0 = {
			ja = 16.3,
			CriLanguages = 11.933,
			zh = 11.933
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play418051007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["10135"]) and arg_24_1.var_.actorSpriteComps10135 == nil then
				arg_24_1.var_.actorSpriteComps10135 = arg_24_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["10135"]) then
				if arg_24_1.var_.actorSpriteComps10135 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								iter_27_1.color = Color.New(Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor1.r, (arg_24_1.time_ - 0) / var_27_0), Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor1.g, (arg_24_1.time_ - 0) / var_27_0), (Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor1.b, (arg_24_1.time_ - 0) / var_27_0)))
							else
								local var_27_1 = Mathf.Lerp(iter_27_1.color.r, 1, (arg_24_1.time_ - 0) / var_27_0)

								iter_27_1.color = Color.New(var_27_1, var_27_1, var_27_1)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["10135"]) and arg_24_1.var_.actorSpriteComps10135 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_27_3 then
						iter_27_3.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_24_1.var_.actorSpriteComps10135 = nil
			end

			local var_27_2 = arg_24_1.actors_["1073"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps1073 == nil then
				arg_24_1.var_.actorSpriteComps1073 = var_27_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_3 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.actorSpriteComps1073 then
					for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_27_5 then
							if arg_24_1.isInRecall_ then
								iter_27_5.color = Color.New(Mathf.Lerp(iter_27_5.color.r, arg_24_1.hightColor2.r, (arg_24_1.time_ - 0) / var_27_3), Mathf.Lerp(iter_27_5.color.g, arg_24_1.hightColor2.g, (arg_24_1.time_ - 0) / var_27_3), (Mathf.Lerp(iter_27_5.color.b, arg_24_1.hightColor2.b, (arg_24_1.time_ - 0) / var_27_3)))
							else
								local var_27_4 = Mathf.Lerp(iter_27_5.color.r, 0.5, (arg_24_1.time_ - 0) / var_27_3)

								iter_27_5.color = Color.New(var_27_4, var_27_4, var_27_4)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps1073 then
				for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_27_7 then
						iter_27_7.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_24_1.var_.actorSpriteComps1073 = nil
			end

			local var_27_5 = 0
			local var_27_6 = 1.325

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_7 = arg_24_1:GetWordFromCfg(418051006)
				local var_27_8 = arg_24_1:FormatText(var_27_7.content)

				arg_24_1.text_.text = var_27_8

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 53 <= 0 and var_27_6 or var_27_6 * (utf8.len(var_27_8) / 53)

				if (53 <= 0 and var_27_6 or var_27_6 * (utf8.len(var_27_8) / 53)) > 0 and var_27_6 < var_27_10 then
					arg_24_1.talkMaxDuration = var_27_10

					if var_27_10 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_5
					end
				end

				arg_24_1.text_.text = var_27_8
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051006", "story_v_side_old_418051.awb") ~= 0 then
					local var_27_11 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051006", "story_v_side_old_418051.awb") / 1000

					if var_27_11 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_5
					end

					if var_27_7.prefab_name ~= "" and arg_24_1.actors_[var_27_7.prefab_name] ~= nil then
						local var_27_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_7.prefab_name].transform, "story_v_side_old_418051", "418051006", "story_v_side_old_418051.awb")

						arg_24_1:RecordAudio("418051006", var_27_12)
						arg_24_1:RecordAudio("418051006", var_27_12)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051006", "story_v_side_old_418051.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051006", "story_v_side_old_418051.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_13 = math.max(var_27_6, arg_24_1.talkMaxDuration)

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_13 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_5) / var_27_13

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_5 + var_27_13 and arg_24_1.time_ < var_27_5 + var_27_13 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play418051007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 418051007
		arg_28_1.duration_ = 19.47

		local var_28_0 = {
			ja = 19.466,
			CriLanguages = 13.333,
			zh = 13.333
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play418051008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 1.375

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:GetWordFromCfg(418051007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 55 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 55)

				if (55 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 55)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051007", "story_v_side_old_418051.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051007", "story_v_side_old_418051.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_side_old_418051", "418051007", "story_v_side_old_418051.awb")

						arg_28_1:RecordAudio("418051007", var_31_6)
						arg_28_1:RecordAudio("418051007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051007", "story_v_side_old_418051.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051007", "story_v_side_old_418051.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play418051008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 418051008
		arg_32_1.duration_ = 8.7

		local var_32_0 = {
			ja = 8.7,
			CriLanguages = 5.666,
			zh = 5.666
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play418051009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["1072"] == nil then
				local var_35_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1072")

				if not isNil(var_35_0) then
					local var_35_1 = Object.Instantiate(var_35_0, arg_32_1.canvasGo_.transform)

					var_35_1.transform:SetSiblingIndex(1)

					var_35_1.name = "1072"
					var_35_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_32_1.actors_["1072"] = var_35_1

					if arg_32_1.isInRecall_ then
						for iter_35_0, iter_35_1 in ipairs((var_35_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_35_1.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_35_2 = arg_32_1.actors_["1072"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps1072 == nil then
				arg_32_1.var_.actorSpriteComps1072 = var_35_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_3 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.actorSpriteComps1072 then
					for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_35_3 then
							if arg_32_1.isInRecall_ then
								iter_35_3.color = Color.New(Mathf.Lerp(iter_35_3.color.r, arg_32_1.hightColor1.r, (arg_32_1.time_ - 0) / var_35_3), Mathf.Lerp(iter_35_3.color.g, arg_32_1.hightColor1.g, (arg_32_1.time_ - 0) / var_35_3), (Mathf.Lerp(iter_35_3.color.b, arg_32_1.hightColor1.b, (arg_32_1.time_ - 0) / var_35_3)))
							else
								local var_35_4 = Mathf.Lerp(iter_35_3.color.r, 1, (arg_32_1.time_ - 0) / var_35_3)

								iter_35_3.color = Color.New(var_35_4, var_35_4, var_35_4)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps1072 then
				for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_35_5 then
						iter_35_5.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_32_1.var_.actorSpriteComps1072 = nil
			end

			local var_35_5 = arg_32_1.actors_["10135"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.actorSpriteComps10135 == nil then
				arg_32_1.var_.actorSpriteComps10135 = var_35_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_6 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.actorSpriteComps10135 then
					for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_35_7 then
							if arg_32_1.isInRecall_ then
								iter_35_7.color = Color.New(Mathf.Lerp(iter_35_7.color.r, arg_32_1.hightColor2.r, (arg_32_1.time_ - 0) / var_35_6), Mathf.Lerp(iter_35_7.color.g, arg_32_1.hightColor2.g, (arg_32_1.time_ - 0) / var_35_6), (Mathf.Lerp(iter_35_7.color.b, arg_32_1.hightColor2.b, (arg_32_1.time_ - 0) / var_35_6)))
							else
								local var_35_7 = Mathf.Lerp(iter_35_7.color.r, 0.5, (arg_32_1.time_ - 0) / var_35_6)

								iter_35_7.color = Color.New(var_35_7, var_35_7, var_35_7)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.actorSpriteComps10135 then
				for iter_35_8, iter_35_9 in pairs(arg_32_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_35_9 then
						iter_35_9.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_32_1.var_.actorSpriteComps10135 = nil
			end

			local var_35_8 = arg_32_1.actors_["10135"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10135 = var_35_8.localPosition
				var_35_8.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10135", 7)

				for iter_35_10 = 0, var_35_8.childCount - 1 do
					local var_35_9 = var_35_8:GetChild(iter_35_10)

					if var_35_9.name == "" or not string.find(var_35_9.name, "split") then
						var_35_9.gameObject:SetActive(true)
					else
						var_35_9.gameObject:SetActive(false)
					end
				end
			end

			local var_35_10 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_10 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_32_1.time_ - 0) / var_35_10)
			end

			if arg_32_1.time_ >= 0 + var_35_10 and arg_32_1.time_ < 0 + var_35_10 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_35_11 = arg_32_1.actors_["1073"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1073 = var_35_11.localPosition
				var_35_11.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("1073", 7)

				for iter_35_11 = 0, var_35_11.childCount - 1 do
					local var_35_12 = var_35_11:GetChild(iter_35_11)

					if var_35_12.name == "" or not string.find(var_35_12.name, "split") then
						var_35_12.gameObject:SetActive(true)
					else
						var_35_12.gameObject:SetActive(false)
					end
				end
			end

			local var_35_13 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_13 then
				var_35_11.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_32_1.time_ - 0) / var_35_13)
			end

			if arg_32_1.time_ >= 0 + var_35_13 and arg_32_1.time_ < 0 + var_35_13 + arg_35_0 then
				var_35_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_35_14 = arg_32_1.actors_["1072"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1072 = var_35_14.localPosition
				var_35_14.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("1072", 3)

				for iter_35_12 = 0, var_35_14.childCount - 1 do
					local var_35_15 = var_35_14:GetChild(iter_35_12)

					if var_35_15.name == "" or not string.find(var_35_15.name, "split") then
						var_35_15.gameObject:SetActive(true)
					else
						var_35_15.gameObject:SetActive(false)
					end
				end
			end

			local var_35_16 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_16 then
				var_35_14.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1072, Vector3.New(30.1, -428.9, -184.1), (arg_32_1.time_ - 0) / var_35_16)
			end

			if arg_32_1.time_ >= 0 + var_35_16 and arg_32_1.time_ < 0 + var_35_16 + arg_35_0 then
				var_35_14.localPosition = Vector3.New(30.1, -428.9, -184.1)
			end

			local var_35_17 = 0
			local var_35_18 = 0.625

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_19 = arg_32_1:GetWordFromCfg(418051008)
				local var_35_20 = arg_32_1:FormatText(var_35_19.content)

				arg_32_1.text_.text = var_35_20

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_22 = 25 <= 0 and var_35_18 or var_35_18 * (utf8.len(var_35_20) / 25)

				if (25 <= 0 and var_35_18 or var_35_18 * (utf8.len(var_35_20) / 25)) > 0 and var_35_18 < var_35_22 then
					arg_32_1.talkMaxDuration = var_35_22

					if var_35_22 + var_35_17 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_17
					end
				end

				arg_32_1.text_.text = var_35_20
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051008", "story_v_side_old_418051.awb") ~= 0 then
					local var_35_23 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051008", "story_v_side_old_418051.awb") / 1000

					if var_35_23 + var_35_17 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_17
					end

					if var_35_19.prefab_name ~= "" and arg_32_1.actors_[var_35_19.prefab_name] ~= nil then
						local var_35_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_19.prefab_name].transform, "story_v_side_old_418051", "418051008", "story_v_side_old_418051.awb")

						arg_32_1:RecordAudio("418051008", var_35_24)
						arg_32_1:RecordAudio("418051008", var_35_24)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051008", "story_v_side_old_418051.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051008", "story_v_side_old_418051.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_25 = math.max(var_35_18, arg_32_1.talkMaxDuration)

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_25 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_17) / var_35_25

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_17 + var_35_25 and arg_32_1.time_ < var_35_17 + var_35_25 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play418051009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 418051009
		arg_36_1.duration_ = 3.47

		local var_36_0 = {
			ja = 3.466,
			CriLanguages = 3.133,
			zh = 3.133
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play418051010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1073"]) and arg_36_1.var_.actorSpriteComps1073 == nil then
				arg_36_1.var_.actorSpriteComps1073 = arg_36_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1073"]) then
				if arg_36_1.var_.actorSpriteComps1073 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_39_1 then
							if arg_36_1.isInRecall_ then
								iter_39_1.color = Color.New(Mathf.Lerp(iter_39_1.color.r, arg_36_1.hightColor1.r, (arg_36_1.time_ - 0) / var_39_0), Mathf.Lerp(iter_39_1.color.g, arg_36_1.hightColor1.g, (arg_36_1.time_ - 0) / var_39_0), (Mathf.Lerp(iter_39_1.color.b, arg_36_1.hightColor1.b, (arg_36_1.time_ - 0) / var_39_0)))
							else
								local var_39_1 = Mathf.Lerp(iter_39_1.color.r, 1, (arg_36_1.time_ - 0) / var_39_0)

								iter_39_1.color = Color.New(var_39_1, var_39_1, var_39_1)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1073"]) and arg_36_1.var_.actorSpriteComps1073 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_39_3 then
						iter_39_3.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_36_1.var_.actorSpriteComps1073 = nil
			end

			local var_39_2 = arg_36_1.actors_["1072"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps1072 == nil then
				arg_36_1.var_.actorSpriteComps1072 = var_39_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_3 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.actorSpriteComps1072 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_39_5 then
							if arg_36_1.isInRecall_ then
								iter_39_5.color = Color.New(Mathf.Lerp(iter_39_5.color.r, arg_36_1.hightColor2.r, (arg_36_1.time_ - 0) / var_39_3), Mathf.Lerp(iter_39_5.color.g, arg_36_1.hightColor2.g, (arg_36_1.time_ - 0) / var_39_3), (Mathf.Lerp(iter_39_5.color.b, arg_36_1.hightColor2.b, (arg_36_1.time_ - 0) / var_39_3)))
							else
								local var_39_4 = Mathf.Lerp(iter_39_5.color.r, 0.5, (arg_36_1.time_ - 0) / var_39_3)

								iter_39_5.color = Color.New(var_39_4, var_39_4, var_39_4)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps1072 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_39_7 then
						iter_39_7.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_36_1.var_.actorSpriteComps1072 = nil
			end

			local var_39_5 = arg_36_1.actors_["1073"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1073 = var_39_5.localPosition
				var_39_5.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("1073", 3)

				for iter_39_8 = 0, var_39_5.childCount - 1 do
					local var_39_6 = var_39_5:GetChild(iter_39_8)

					if var_39_6.name == "" or not string.find(var_39_6.name, "split") then
						var_39_6.gameObject:SetActive(true)
					else
						var_39_6.gameObject:SetActive(false)
					end
				end
			end

			local var_39_7 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				var_39_5.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1073, Vector3.New(38.6, -414.5, -207.2), (arg_36_1.time_ - 0) / var_39_7)
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				var_39_5.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_39_8 = arg_36_1.actors_["1072"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1072 = var_39_8.localPosition
				var_39_8.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("1072", 7)

				for iter_39_9 = 0, var_39_8.childCount - 1 do
					local var_39_9 = var_39_8:GetChild(iter_39_9)

					if var_39_9.name == "" or not string.find(var_39_9.name, "split") then
						var_39_9.gameObject:SetActive(true)
					else
						var_39_9.gameObject:SetActive(false)
					end
				end
			end

			local var_39_10 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_10 then
				var_39_8.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1072, Vector3.New(0, -2000, 0), (arg_36_1.time_ - 0) / var_39_10)
			end

			if arg_36_1.time_ >= 0 + var_39_10 and arg_36_1.time_ < 0 + var_39_10 + arg_39_0 then
				var_39_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_39_11 = 0
			local var_39_12 = 0.4

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_13 = arg_36_1:GetWordFromCfg(418051009)
				local var_39_14 = arg_36_1:FormatText(var_39_13.content)

				arg_36_1.text_.text = var_39_14

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_16 = 16 <= 0 and var_39_12 or var_39_12 * (utf8.len(var_39_14) / 16)

				if (16 <= 0 and var_39_12 or var_39_12 * (utf8.len(var_39_14) / 16)) > 0 and var_39_12 < var_39_16 then
					arg_36_1.talkMaxDuration = var_39_16

					if var_39_16 + var_39_11 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_16 + var_39_11
					end
				end

				arg_36_1.text_.text = var_39_14
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051009", "story_v_side_old_418051.awb") ~= 0 then
					local var_39_17 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051009", "story_v_side_old_418051.awb") / 1000

					if var_39_17 + var_39_11 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_11
					end

					if var_39_13.prefab_name ~= "" and arg_36_1.actors_[var_39_13.prefab_name] ~= nil then
						local var_39_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_13.prefab_name].transform, "story_v_side_old_418051", "418051009", "story_v_side_old_418051.awb")

						arg_36_1:RecordAudio("418051009", var_39_18)
						arg_36_1:RecordAudio("418051009", var_39_18)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051009", "story_v_side_old_418051.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051009", "story_v_side_old_418051.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_19 = math.max(var_39_12, arg_36_1.talkMaxDuration)

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_19 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_11) / var_39_19

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_11 + var_39_19 and arg_36_1.time_ < var_39_11 + var_39_19 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play418051010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 418051010
		arg_40_1.duration_ = 8.8

		local var_40_0 = {
			ja = 8.8,
			CriLanguages = 6.166,
			zh = 6.166
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play418051011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1072"]) and arg_40_1.var_.actorSpriteComps1072 == nil then
				arg_40_1.var_.actorSpriteComps1072 = arg_40_1.actors_["1072"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1072"]) then
				if arg_40_1.var_.actorSpriteComps1072 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								iter_43_1.color = Color.New(Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor1.r, (arg_40_1.time_ - 0) / var_43_0), Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor1.g, (arg_40_1.time_ - 0) / var_43_0), (Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor1.b, (arg_40_1.time_ - 0) / var_43_0)))
							else
								local var_43_1 = Mathf.Lerp(iter_43_1.color.r, 1, (arg_40_1.time_ - 0) / var_43_0)

								iter_43_1.color = Color.New(var_43_1, var_43_1, var_43_1)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1072"]) and arg_40_1.var_.actorSpriteComps1072 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_43_3 then
						iter_43_3.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_40_1.var_.actorSpriteComps1072 = nil
			end

			local var_43_2 = arg_40_1.actors_["1073"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.actorSpriteComps1073 == nil then
				arg_40_1.var_.actorSpriteComps1073 = var_43_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_3 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.actorSpriteComps1073 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_43_5 then
							if arg_40_1.isInRecall_ then
								iter_43_5.color = Color.New(Mathf.Lerp(iter_43_5.color.r, arg_40_1.hightColor2.r, (arg_40_1.time_ - 0) / var_43_3), Mathf.Lerp(iter_43_5.color.g, arg_40_1.hightColor2.g, (arg_40_1.time_ - 0) / var_43_3), (Mathf.Lerp(iter_43_5.color.b, arg_40_1.hightColor2.b, (arg_40_1.time_ - 0) / var_43_3)))
							else
								local var_43_4 = Mathf.Lerp(iter_43_5.color.r, 0.5, (arg_40_1.time_ - 0) / var_43_3)

								iter_43_5.color = Color.New(var_43_4, var_43_4, var_43_4)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.actorSpriteComps1073 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_43_7 then
						iter_43_7.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_40_1.var_.actorSpriteComps1073 = nil
			end

			local var_43_5 = arg_40_1.actors_["1072"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1072 = var_43_5.localPosition
				var_43_5.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("1072", 3)

				for iter_43_8 = 0, var_43_5.childCount - 1 do
					local var_43_6 = var_43_5:GetChild(iter_43_8)

					if var_43_6.name == "split_7" or not string.find(var_43_6.name, "split") then
						var_43_6.gameObject:SetActive(true)
					else
						var_43_6.gameObject:SetActive(false)
					end
				end
			end

			local var_43_7 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1072, Vector3.New(30.1, -428.9, -184.1), (arg_40_1.time_ - 0) / var_43_7)
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(30.1, -428.9, -184.1)
			end

			local var_43_8 = arg_40_1.actors_["1073"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1073 = var_43_8.localPosition
				var_43_8.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("1073", 7)

				for iter_43_9 = 0, var_43_8.childCount - 1 do
					local var_43_9 = var_43_8:GetChild(iter_43_9)

					if var_43_9.name == "" or not string.find(var_43_9.name, "split") then
						var_43_9.gameObject:SetActive(true)
					else
						var_43_9.gameObject:SetActive(false)
					end
				end
			end

			local var_43_10 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_10 then
				var_43_8.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_40_1.time_ - 0) / var_43_10)
			end

			if arg_40_1.time_ >= 0 + var_43_10 and arg_40_1.time_ < 0 + var_43_10 + arg_43_0 then
				var_43_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_43_11 = 0
			local var_43_12 = 0.65

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_13 = arg_40_1:GetWordFromCfg(418051010)
				local var_43_14 = arg_40_1:FormatText(var_43_13.content)

				arg_40_1.text_.text = var_43_14

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_16 = 26 <= 0 and var_43_12 or var_43_12 * (utf8.len(var_43_14) / 26)

				if (26 <= 0 and var_43_12 or var_43_12 * (utf8.len(var_43_14) / 26)) > 0 and var_43_12 < var_43_16 then
					arg_40_1.talkMaxDuration = var_43_16

					if var_43_16 + var_43_11 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_16 + var_43_11
					end
				end

				arg_40_1.text_.text = var_43_14
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051010", "story_v_side_old_418051.awb") ~= 0 then
					local var_43_17 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051010", "story_v_side_old_418051.awb") / 1000

					if var_43_17 + var_43_11 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_11
					end

					if var_43_13.prefab_name ~= "" and arg_40_1.actors_[var_43_13.prefab_name] ~= nil then
						local var_43_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_13.prefab_name].transform, "story_v_side_old_418051", "418051010", "story_v_side_old_418051.awb")

						arg_40_1:RecordAudio("418051010", var_43_18)
						arg_40_1:RecordAudio("418051010", var_43_18)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051010", "story_v_side_old_418051.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051010", "story_v_side_old_418051.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_19 = math.max(var_43_12, arg_40_1.talkMaxDuration)

			if var_43_11 <= arg_40_1.time_ and arg_40_1.time_ < var_43_11 + var_43_19 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_11) / var_43_19

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_11 + var_43_19 and arg_40_1.time_ < var_43_11 + var_43_19 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play418051011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 418051011
		arg_44_1.duration_ = 4.1

		local var_44_0 = {
			ja = 4.1,
			CriLanguages = 2.866,
			zh = 2.866
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play418051012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["10135"]) and arg_44_1.var_.actorSpriteComps10135 == nil then
				arg_44_1.var_.actorSpriteComps10135 = arg_44_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["10135"]) then
				if arg_44_1.var_.actorSpriteComps10135 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								iter_47_1.color = Color.New(Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor1.r, (arg_44_1.time_ - 0) / var_47_0), Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor1.g, (arg_44_1.time_ - 0) / var_47_0), (Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor1.b, (arg_44_1.time_ - 0) / var_47_0)))
							else
								local var_47_1 = Mathf.Lerp(iter_47_1.color.r, 1, (arg_44_1.time_ - 0) / var_47_0)

								iter_47_1.color = Color.New(var_47_1, var_47_1, var_47_1)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["10135"]) and arg_44_1.var_.actorSpriteComps10135 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_47_3 then
						iter_47_3.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_44_1.var_.actorSpriteComps10135 = nil
			end

			local var_47_2 = arg_44_1.actors_["1072"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps1072 == nil then
				arg_44_1.var_.actorSpriteComps1072 = var_47_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_3 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.actorSpriteComps1072 then
					for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_47_5 then
							if arg_44_1.isInRecall_ then
								iter_47_5.color = Color.New(Mathf.Lerp(iter_47_5.color.r, arg_44_1.hightColor2.r, (arg_44_1.time_ - 0) / var_47_3), Mathf.Lerp(iter_47_5.color.g, arg_44_1.hightColor2.g, (arg_44_1.time_ - 0) / var_47_3), (Mathf.Lerp(iter_47_5.color.b, arg_44_1.hightColor2.b, (arg_44_1.time_ - 0) / var_47_3)))
							else
								local var_47_4 = Mathf.Lerp(iter_47_5.color.r, 0.5, (arg_44_1.time_ - 0) / var_47_3)

								iter_47_5.color = Color.New(var_47_4, var_47_4, var_47_4)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps1072 then
				for iter_47_6, iter_47_7 in pairs(arg_44_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_47_7 then
						iter_47_7.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_44_1.var_.actorSpriteComps1072 = nil
			end

			local var_47_5 = arg_44_1.actors_["1072"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1072 = var_47_5.localPosition
				var_47_5.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("1072", 2)

				for iter_47_8 = 0, var_47_5.childCount - 1 do
					local var_47_6 = var_47_5:GetChild(iter_47_8)

					if var_47_6.name == "" or not string.find(var_47_6.name, "split") then
						var_47_6.gameObject:SetActive(true)
					else
						var_47_6.gameObject:SetActive(false)
					end
				end
			end

			local var_47_7 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				var_47_5.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1072, Vector3.New(-434.2, -428.9, -184.1), (arg_44_1.time_ - 0) / var_47_7)
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				var_47_5.localPosition = Vector3.New(-434.2, -428.9, -184.1)
			end

			local var_47_8 = arg_44_1.actors_["10135"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos10135 = var_47_8.localPosition
				var_47_8.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("10135", 4)

				for iter_47_9 = 0, var_47_8.childCount - 1 do
					local var_47_9 = var_47_8:GetChild(iter_47_9)

					if var_47_9.name == "split_6" or not string.find(var_47_9.name, "split") then
						var_47_9.gameObject:SetActive(true)
					else
						var_47_9.gameObject:SetActive(false)
					end
				end
			end

			local var_47_10 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_10 then
				var_47_8.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_44_1.time_ - 0) / var_47_10)
			end

			if arg_44_1.time_ >= 0 + var_47_10 and arg_44_1.time_ < 0 + var_47_10 + arg_47_0 then
				var_47_8.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_47_11 = 0
			local var_47_12 = 0.35

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_13 = arg_44_1:GetWordFromCfg(418051011)
				local var_47_14 = arg_44_1:FormatText(var_47_13.content)

				arg_44_1.text_.text = var_47_14

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_16 = 14 <= 0 and var_47_12 or var_47_12 * (utf8.len(var_47_14) / 14)

				if (14 <= 0 and var_47_12 or var_47_12 * (utf8.len(var_47_14) / 14)) > 0 and var_47_12 < var_47_16 then
					arg_44_1.talkMaxDuration = var_47_16

					if var_47_16 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_16 + var_47_11
					end
				end

				arg_44_1.text_.text = var_47_14
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051011", "story_v_side_old_418051.awb") ~= 0 then
					local var_47_17 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051011", "story_v_side_old_418051.awb") / 1000

					if var_47_17 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_11
					end

					if var_47_13.prefab_name ~= "" and arg_44_1.actors_[var_47_13.prefab_name] ~= nil then
						local var_47_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_13.prefab_name].transform, "story_v_side_old_418051", "418051011", "story_v_side_old_418051.awb")

						arg_44_1:RecordAudio("418051011", var_47_18)
						arg_44_1:RecordAudio("418051011", var_47_18)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051011", "story_v_side_old_418051.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051011", "story_v_side_old_418051.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_19 = math.max(var_47_12, arg_44_1.talkMaxDuration)

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_19 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_11) / var_47_19

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_11 + var_47_19 and arg_44_1.time_ < var_47_11 + var_47_19 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play418051012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 418051012
		arg_48_1.duration_ = 7.4

		local var_48_0 = {
			ja = 7.4,
			CriLanguages = 4.8,
			zh = 4.8
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play418051013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1072"]) and arg_48_1.var_.actorSpriteComps1072 == nil then
				arg_48_1.var_.actorSpriteComps1072 = arg_48_1.actors_["1072"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1072"]) then
				if arg_48_1.var_.actorSpriteComps1072 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								iter_51_1.color = Color.New(Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor1.r, (arg_48_1.time_ - 0) / var_51_0), Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor1.g, (arg_48_1.time_ - 0) / var_51_0), (Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor1.b, (arg_48_1.time_ - 0) / var_51_0)))
							else
								local var_51_1 = Mathf.Lerp(iter_51_1.color.r, 1, (arg_48_1.time_ - 0) / var_51_0)

								iter_51_1.color = Color.New(var_51_1, var_51_1, var_51_1)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1072"]) and arg_48_1.var_.actorSpriteComps1072 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_48_1.var_.actorSpriteComps1072 = nil
			end

			local var_51_2 = arg_48_1.actors_["10135"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.actorSpriteComps10135 == nil then
				arg_48_1.var_.actorSpriteComps10135 = var_51_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_3 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.actorSpriteComps10135 then
					for iter_51_4, iter_51_5 in pairs(arg_48_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_51_5 then
							if arg_48_1.isInRecall_ then
								iter_51_5.color = Color.New(Mathf.Lerp(iter_51_5.color.r, arg_48_1.hightColor2.r, (arg_48_1.time_ - 0) / var_51_3), Mathf.Lerp(iter_51_5.color.g, arg_48_1.hightColor2.g, (arg_48_1.time_ - 0) / var_51_3), (Mathf.Lerp(iter_51_5.color.b, arg_48_1.hightColor2.b, (arg_48_1.time_ - 0) / var_51_3)))
							else
								local var_51_4 = Mathf.Lerp(iter_51_5.color.r, 0.5, (arg_48_1.time_ - 0) / var_51_3)

								iter_51_5.color = Color.New(var_51_4, var_51_4, var_51_4)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.actorSpriteComps10135 then
				for iter_51_6, iter_51_7 in pairs(arg_48_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_51_7 then
						iter_51_7.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_48_1.var_.actorSpriteComps10135 = nil
			end

			local var_51_5 = arg_48_1.actors_["1072"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1072 = var_51_5.localPosition
				var_51_5.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("1072", 2)

				for iter_51_8 = 0, var_51_5.childCount - 1 do
					local var_51_6 = var_51_5:GetChild(iter_51_8)

					if var_51_6.name == "split_2" or not string.find(var_51_6.name, "split") then
						var_51_6.gameObject:SetActive(true)
					else
						var_51_6.gameObject:SetActive(false)
					end
				end
			end

			local var_51_7 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				var_51_5.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1072, Vector3.New(-434.2, -428.9, -184.1), (arg_48_1.time_ - 0) / var_51_7)
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				var_51_5.localPosition = Vector3.New(-434.2, -428.9, -184.1)
			end

			local var_51_8 = 0
			local var_51_9 = 0.575

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_10 = arg_48_1:GetWordFromCfg(418051012)
				local var_51_11 = arg_48_1:FormatText(var_51_10.content)

				arg_48_1.text_.text = var_51_11

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_13 = 23 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 23)

				if (23 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 23)) > 0 and var_51_9 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_11
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051012", "story_v_side_old_418051.awb") ~= 0 then
					local var_51_14 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051012", "story_v_side_old_418051.awb") / 1000

					if var_51_14 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_8
					end

					if var_51_10.prefab_name ~= "" and arg_48_1.actors_[var_51_10.prefab_name] ~= nil then
						local var_51_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_10.prefab_name].transform, "story_v_side_old_418051", "418051012", "story_v_side_old_418051.awb")

						arg_48_1:RecordAudio("418051012", var_51_15)
						arg_48_1:RecordAudio("418051012", var_51_15)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051012", "story_v_side_old_418051.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051012", "story_v_side_old_418051.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_16 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_16 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_16

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_16 and arg_48_1.time_ < var_51_8 + var_51_16 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play418051013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 418051013
		arg_52_1.duration_ = 5.7

		local var_52_0 = {
			ja = 4,
			CriLanguages = 5.7,
			zh = 5.7
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play418051014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1073"]) and arg_52_1.var_.actorSpriteComps1073 == nil then
				arg_52_1.var_.actorSpriteComps1073 = arg_52_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_0 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1073"]) then
				if arg_52_1.var_.actorSpriteComps1073 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_55_1 then
							if arg_52_1.isInRecall_ then
								iter_55_1.color = Color.New(Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor1.r, (arg_52_1.time_ - 0) / var_55_0), Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor1.g, (arg_52_1.time_ - 0) / var_55_0), (Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor1.b, (arg_52_1.time_ - 0) / var_55_0)))
							else
								local var_55_1 = Mathf.Lerp(iter_55_1.color.r, 1, (arg_52_1.time_ - 0) / var_55_0)

								iter_55_1.color = Color.New(var_55_1, var_55_1, var_55_1)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1073"]) and arg_52_1.var_.actorSpriteComps1073 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_55_3 then
						iter_55_3.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_52_1.var_.actorSpriteComps1073 = nil
			end

			local var_55_2 = arg_52_1.actors_["1072"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps1072 == nil then
				arg_52_1.var_.actorSpriteComps1072 = var_55_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_3 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.actorSpriteComps1072 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_55_5 then
							if arg_52_1.isInRecall_ then
								iter_55_5.color = Color.New(Mathf.Lerp(iter_55_5.color.r, arg_52_1.hightColor2.r, (arg_52_1.time_ - 0) / var_55_3), Mathf.Lerp(iter_55_5.color.g, arg_52_1.hightColor2.g, (arg_52_1.time_ - 0) / var_55_3), (Mathf.Lerp(iter_55_5.color.b, arg_52_1.hightColor2.b, (arg_52_1.time_ - 0) / var_55_3)))
							else
								local var_55_4 = Mathf.Lerp(iter_55_5.color.r, 0.5, (arg_52_1.time_ - 0) / var_55_3)

								iter_55_5.color = Color.New(var_55_4, var_55_4, var_55_4)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps1072 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_55_7 then
						iter_55_7.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_52_1.var_.actorSpriteComps1072 = nil
			end

			local var_55_5 = 0
			local var_55_6 = 0.725

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1073_split_1")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_7 = arg_52_1:GetWordFromCfg(418051013)
				local var_55_8 = arg_52_1:FormatText(var_55_7.content)

				arg_52_1.text_.text = var_55_8

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_10 = 29 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_8) / 29)

				if (29 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_8) / 29)) > 0 and var_55_6 < var_55_10 then
					arg_52_1.talkMaxDuration = var_55_10

					if var_55_10 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_5
					end
				end

				arg_52_1.text_.text = var_55_8
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051013", "story_v_side_old_418051.awb") ~= 0 then
					local var_55_11 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051013", "story_v_side_old_418051.awb") / 1000

					if var_55_11 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_5
					end

					if var_55_7.prefab_name ~= "" and arg_52_1.actors_[var_55_7.prefab_name] ~= nil then
						local var_55_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_7.prefab_name].transform, "story_v_side_old_418051", "418051013", "story_v_side_old_418051.awb")

						arg_52_1:RecordAudio("418051013", var_55_12)
						arg_52_1:RecordAudio("418051013", var_55_12)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051013", "story_v_side_old_418051.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051013", "story_v_side_old_418051.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_13 = math.max(var_55_6, arg_52_1.talkMaxDuration)

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_13 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_5) / var_55_13

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_5 + var_55_13 and arg_52_1.time_ < var_55_5 + var_55_13 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play418051014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 418051014
		arg_56_1.duration_ = 7.5

		local var_56_0 = {
			ja = 7.5,
			CriLanguages = 5.533,
			zh = 5.933
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play418051015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1072"]) and arg_56_1.var_.actorSpriteComps1072 == nil then
				arg_56_1.var_.actorSpriteComps1072 = arg_56_1.actors_["1072"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1072"]) then
				if arg_56_1.var_.actorSpriteComps1072 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								iter_59_1.color = Color.New(Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor1.r, (arg_56_1.time_ - 0) / var_59_0), Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor1.g, (arg_56_1.time_ - 0) / var_59_0), (Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor1.b, (arg_56_1.time_ - 0) / var_59_0)))
							else
								local var_59_1 = Mathf.Lerp(iter_59_1.color.r, 1, (arg_56_1.time_ - 0) / var_59_0)

								iter_59_1.color = Color.New(var_59_1, var_59_1, var_59_1)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1072"]) and arg_56_1.var_.actorSpriteComps1072 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_56_1.var_.actorSpriteComps1072 = nil
			end

			local var_59_2 = arg_56_1.actors_["1073"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps1073 == nil then
				arg_56_1.var_.actorSpriteComps1073 = var_59_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_3 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.actorSpriteComps1073 then
					for iter_59_4, iter_59_5 in pairs(arg_56_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_59_5 then
							if arg_56_1.isInRecall_ then
								iter_59_5.color = Color.New(Mathf.Lerp(iter_59_5.color.r, arg_56_1.hightColor2.r, (arg_56_1.time_ - 0) / var_59_3), Mathf.Lerp(iter_59_5.color.g, arg_56_1.hightColor2.g, (arg_56_1.time_ - 0) / var_59_3), (Mathf.Lerp(iter_59_5.color.b, arg_56_1.hightColor2.b, (arg_56_1.time_ - 0) / var_59_3)))
							else
								local var_59_4 = Mathf.Lerp(iter_59_5.color.r, 0.5, (arg_56_1.time_ - 0) / var_59_3)

								iter_59_5.color = Color.New(var_59_4, var_59_4, var_59_4)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps1073 then
				for iter_59_6, iter_59_7 in pairs(arg_56_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_59_7 then
						iter_59_7.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_56_1.var_.actorSpriteComps1073 = nil
			end

			local var_59_5 = arg_56_1.actors_["1072"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1072 = var_59_5.localPosition
				var_59_5.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("1072", 2)

				for iter_59_8 = 0, var_59_5.childCount - 1 do
					local var_59_6 = var_59_5:GetChild(iter_59_8)

					if var_59_6.name == "" or not string.find(var_59_6.name, "split") then
						var_59_6.gameObject:SetActive(true)
					else
						var_59_6.gameObject:SetActive(false)
					end
				end
			end

			local var_59_7 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				var_59_5.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1072, Vector3.New(-434.2, -428.9, -184.1), (arg_56_1.time_ - 0) / var_59_7)
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				var_59_5.localPosition = Vector3.New(-434.2, -428.9, -184.1)
			end

			local var_59_8 = 0
			local var_59_9 = 0.725

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_10 = arg_56_1:GetWordFromCfg(418051014)
				local var_59_11 = arg_56_1:FormatText(var_59_10.content)

				arg_56_1.text_.text = var_59_11

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_13 = 29 <= 0 and var_59_9 or var_59_9 * (utf8.len(var_59_11) / 29)

				if (29 <= 0 and var_59_9 or var_59_9 * (utf8.len(var_59_11) / 29)) > 0 and var_59_9 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_8
					end
				end

				arg_56_1.text_.text = var_59_11
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051014", "story_v_side_old_418051.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051014", "story_v_side_old_418051.awb") / 1000

					if var_59_14 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_8
					end

					if var_59_10.prefab_name ~= "" and arg_56_1.actors_[var_59_10.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_10.prefab_name].transform, "story_v_side_old_418051", "418051014", "story_v_side_old_418051.awb")

						arg_56_1:RecordAudio("418051014", var_59_15)
						arg_56_1:RecordAudio("418051014", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051014", "story_v_side_old_418051.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051014", "story_v_side_old_418051.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_9, arg_56_1.talkMaxDuration)

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_8) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_8 + var_59_16 and arg_56_1.time_ < var_59_8 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play418051015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 418051015
		arg_60_1.duration_ = 12.7

		local var_60_0 = {
			ja = 12.7,
			CriLanguages = 10.833,
			zh = 10.833
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play418051016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["10135"]) and arg_60_1.var_.actorSpriteComps10135 == nil then
				arg_60_1.var_.actorSpriteComps10135 = arg_60_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["10135"]) then
				if arg_60_1.var_.actorSpriteComps10135 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								iter_63_1.color = Color.New(Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor1.r, (arg_60_1.time_ - 0) / var_63_0), Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor1.g, (arg_60_1.time_ - 0) / var_63_0), (Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor1.b, (arg_60_1.time_ - 0) / var_63_0)))
							else
								local var_63_1 = Mathf.Lerp(iter_63_1.color.r, 1, (arg_60_1.time_ - 0) / var_63_0)

								iter_63_1.color = Color.New(var_63_1, var_63_1, var_63_1)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["10135"]) and arg_60_1.var_.actorSpriteComps10135 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_63_3 then
						iter_63_3.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_60_1.var_.actorSpriteComps10135 = nil
			end

			local var_63_2 = arg_60_1.actors_["1072"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.actorSpriteComps1072 == nil then
				arg_60_1.var_.actorSpriteComps1072 = var_63_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_3 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.actorSpriteComps1072 then
					for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_63_5 then
							if arg_60_1.isInRecall_ then
								iter_63_5.color = Color.New(Mathf.Lerp(iter_63_5.color.r, arg_60_1.hightColor2.r, (arg_60_1.time_ - 0) / var_63_3), Mathf.Lerp(iter_63_5.color.g, arg_60_1.hightColor2.g, (arg_60_1.time_ - 0) / var_63_3), (Mathf.Lerp(iter_63_5.color.b, arg_60_1.hightColor2.b, (arg_60_1.time_ - 0) / var_63_3)))
							else
								local var_63_4 = Mathf.Lerp(iter_63_5.color.r, 0.5, (arg_60_1.time_ - 0) / var_63_3)

								iter_63_5.color = Color.New(var_63_4, var_63_4, var_63_4)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.actorSpriteComps1072 then
				for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_63_7 then
						iter_63_7.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_60_1.var_.actorSpriteComps1072 = nil
			end

			local var_63_5 = arg_60_1.actors_["10135"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10135 = var_63_5.localPosition
				var_63_5.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("10135", 4)

				for iter_63_8 = 0, var_63_5.childCount - 1 do
					local var_63_6 = var_63_5:GetChild(iter_63_8)

					if var_63_6.name == "split_5" or not string.find(var_63_6.name, "split") then
						var_63_6.gameObject:SetActive(true)
					else
						var_63_6.gameObject:SetActive(false)
					end
				end
			end

			local var_63_7 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				var_63_5.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_60_1.time_ - 0) / var_63_7)
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				var_63_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_63_8 = 0
			local var_63_9 = 1.3

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_8 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_10 = arg_60_1:GetWordFromCfg(418051015)
				local var_63_11 = arg_60_1:FormatText(var_63_10.content)

				arg_60_1.text_.text = var_63_11

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_13 = 52 <= 0 and var_63_9 or var_63_9 * (utf8.len(var_63_11) / 52)

				if (52 <= 0 and var_63_9 or var_63_9 * (utf8.len(var_63_11) / 52)) > 0 and var_63_9 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_8
					end
				end

				arg_60_1.text_.text = var_63_11
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051015", "story_v_side_old_418051.awb") ~= 0 then
					local var_63_14 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051015", "story_v_side_old_418051.awb") / 1000

					if var_63_14 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_8
					end

					if var_63_10.prefab_name ~= "" and arg_60_1.actors_[var_63_10.prefab_name] ~= nil then
						local var_63_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_10.prefab_name].transform, "story_v_side_old_418051", "418051015", "story_v_side_old_418051.awb")

						arg_60_1:RecordAudio("418051015", var_63_15)
						arg_60_1:RecordAudio("418051015", var_63_15)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051015", "story_v_side_old_418051.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051015", "story_v_side_old_418051.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_16 = math.max(var_63_9, arg_60_1.talkMaxDuration)

			if var_63_8 <= arg_60_1.time_ and arg_60_1.time_ < var_63_8 + var_63_16 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_8) / var_63_16

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_8 + var_63_16 and arg_60_1.time_ < var_63_8 + var_63_16 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play418051016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 418051016
		arg_64_1.duration_ = 18.4

		local var_64_0 = {
			ja = 18.4,
			CriLanguages = 15.066,
			zh = 15.066
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
				arg_64_0:Play418051017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1072"]) and arg_64_1.var_.actorSpriteComps1072 == nil then
				arg_64_1.var_.actorSpriteComps1072 = arg_64_1.actors_["1072"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1072"]) then
				if arg_64_1.var_.actorSpriteComps1072 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								iter_67_1.color = Color.New(Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor1.r, (arg_64_1.time_ - 0) / var_67_0), Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor1.g, (arg_64_1.time_ - 0) / var_67_0), (Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor1.b, (arg_64_1.time_ - 0) / var_67_0)))
							else
								local var_67_1 = Mathf.Lerp(iter_67_1.color.r, 1, (arg_64_1.time_ - 0) / var_67_0)

								iter_67_1.color = Color.New(var_67_1, var_67_1, var_67_1)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1072"]) and arg_64_1.var_.actorSpriteComps1072 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_67_3 then
						iter_67_3.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_64_1.var_.actorSpriteComps1072 = nil
			end

			local var_67_2 = arg_64_1.actors_["10135"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps10135 == nil then
				arg_64_1.var_.actorSpriteComps10135 = var_67_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_3 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.actorSpriteComps10135 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_67_5 then
							if arg_64_1.isInRecall_ then
								iter_67_5.color = Color.New(Mathf.Lerp(iter_67_5.color.r, arg_64_1.hightColor2.r, (arg_64_1.time_ - 0) / var_67_3), Mathf.Lerp(iter_67_5.color.g, arg_64_1.hightColor2.g, (arg_64_1.time_ - 0) / var_67_3), (Mathf.Lerp(iter_67_5.color.b, arg_64_1.hightColor2.b, (arg_64_1.time_ - 0) / var_67_3)))
							else
								local var_67_4 = Mathf.Lerp(iter_67_5.color.r, 0.5, (arg_64_1.time_ - 0) / var_67_3)

								iter_67_5.color = Color.New(var_67_4, var_67_4, var_67_4)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps10135 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_67_7 then
						iter_67_7.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_64_1.var_.actorSpriteComps10135 = nil
			end

			local var_67_5 = 0
			local var_67_6 = 1.6

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_7 = arg_64_1:GetWordFromCfg(418051016)
				local var_67_8 = arg_64_1:FormatText(var_67_7.content)

				arg_64_1.text_.text = var_67_8

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_10 = 64 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_8) / 64)

				if (64 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_8) / 64)) > 0 and var_67_6 < var_67_10 then
					arg_64_1.talkMaxDuration = var_67_10

					if var_67_10 + var_67_5 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_5
					end
				end

				arg_64_1.text_.text = var_67_8
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051016", "story_v_side_old_418051.awb") ~= 0 then
					local var_67_11 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051016", "story_v_side_old_418051.awb") / 1000

					if var_67_11 + var_67_5 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_11 + var_67_5
					end

					if var_67_7.prefab_name ~= "" and arg_64_1.actors_[var_67_7.prefab_name] ~= nil then
						local var_67_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_7.prefab_name].transform, "story_v_side_old_418051", "418051016", "story_v_side_old_418051.awb")

						arg_64_1:RecordAudio("418051016", var_67_12)
						arg_64_1:RecordAudio("418051016", var_67_12)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051016", "story_v_side_old_418051.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051016", "story_v_side_old_418051.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_13 = math.max(var_67_6, arg_64_1.talkMaxDuration)

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_13 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_5) / var_67_13

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_5 + var_67_13 and arg_64_1.time_ < var_67_5 + var_67_13 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play418051017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 418051017
		arg_68_1.duration_ = 12.03

		local var_68_0 = {
			ja = 12.033,
			CriLanguages = 9.166,
			zh = 9.166
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play418051018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10135"]) and arg_68_1.var_.actorSpriteComps10135 == nil then
				arg_68_1.var_.actorSpriteComps10135 = arg_68_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10135"]) then
				if arg_68_1.var_.actorSpriteComps10135 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								iter_71_1.color = Color.New(Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor1.r, (arg_68_1.time_ - 0) / var_71_0), Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor1.g, (arg_68_1.time_ - 0) / var_71_0), (Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor1.b, (arg_68_1.time_ - 0) / var_71_0)))
							else
								local var_71_1 = Mathf.Lerp(iter_71_1.color.r, 1, (arg_68_1.time_ - 0) / var_71_0)

								iter_71_1.color = Color.New(var_71_1, var_71_1, var_71_1)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10135"]) and arg_68_1.var_.actorSpriteComps10135 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_71_3 then
						iter_71_3.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_68_1.var_.actorSpriteComps10135 = nil
			end

			local var_71_2 = arg_68_1.actors_["1072"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.actorSpriteComps1072 == nil then
				arg_68_1.var_.actorSpriteComps1072 = var_71_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_3 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.actorSpriteComps1072 then
					for iter_71_4, iter_71_5 in pairs(arg_68_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_71_5 then
							if arg_68_1.isInRecall_ then
								iter_71_5.color = Color.New(Mathf.Lerp(iter_71_5.color.r, arg_68_1.hightColor2.r, (arg_68_1.time_ - 0) / var_71_3), Mathf.Lerp(iter_71_5.color.g, arg_68_1.hightColor2.g, (arg_68_1.time_ - 0) / var_71_3), (Mathf.Lerp(iter_71_5.color.b, arg_68_1.hightColor2.b, (arg_68_1.time_ - 0) / var_71_3)))
							else
								local var_71_4 = Mathf.Lerp(iter_71_5.color.r, 0.5, (arg_68_1.time_ - 0) / var_71_3)

								iter_71_5.color = Color.New(var_71_4, var_71_4, var_71_4)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.actorSpriteComps1072 then
				for iter_71_6, iter_71_7 in pairs(arg_68_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_71_7 then
						iter_71_7.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_68_1.var_.actorSpriteComps1072 = nil
			end

			local var_71_5 = arg_68_1.actors_["10135"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos10135 = var_71_5.localPosition
				var_71_5.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10135", 4)

				for iter_71_8 = 0, var_71_5.childCount - 1 do
					local var_71_6 = var_71_5:GetChild(iter_71_8)

					if var_71_6.name == "split_5" or not string.find(var_71_6.name, "split") then
						var_71_6.gameObject:SetActive(true)
					else
						var_71_6.gameObject:SetActive(false)
					end
				end
			end

			local var_71_7 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				var_71_5.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_68_1.time_ - 0) / var_71_7)
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				var_71_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_71_8 = 0
			local var_71_9 = 0.925

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_10 = arg_68_1:GetWordFromCfg(418051017)
				local var_71_11 = arg_68_1:FormatText(var_71_10.content)

				arg_68_1.text_.text = var_71_11

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_13 = 37 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 37)

				if (37 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 37)) > 0 and var_71_9 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_8
					end
				end

				arg_68_1.text_.text = var_71_11
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051017", "story_v_side_old_418051.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051017", "story_v_side_old_418051.awb") / 1000

					if var_71_14 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_8
					end

					if var_71_10.prefab_name ~= "" and arg_68_1.actors_[var_71_10.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_10.prefab_name].transform, "story_v_side_old_418051", "418051017", "story_v_side_old_418051.awb")

						arg_68_1:RecordAudio("418051017", var_71_15)
						arg_68_1:RecordAudio("418051017", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051017", "story_v_side_old_418051.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051017", "story_v_side_old_418051.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_9, arg_68_1.talkMaxDuration)

			if var_71_8 <= arg_68_1.time_ and arg_68_1.time_ < var_71_8 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_8) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_8 + var_71_16 and arg_68_1.time_ < var_71_8 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play418051018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 418051018
		arg_72_1.duration_ = 17.4

		local var_72_0 = {
			ja = 17.4,
			CriLanguages = 12.2,
			zh = 12.2
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play418051019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1072"]) and arg_72_1.var_.actorSpriteComps1072 == nil then
				arg_72_1.var_.actorSpriteComps1072 = arg_72_1.actors_["1072"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1072"]) then
				if arg_72_1.var_.actorSpriteComps1072 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								iter_75_1.color = Color.New(Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor1.r, (arg_72_1.time_ - 0) / var_75_0), Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor1.g, (arg_72_1.time_ - 0) / var_75_0), (Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor1.b, (arg_72_1.time_ - 0) / var_75_0)))
							else
								local var_75_1 = Mathf.Lerp(iter_75_1.color.r, 1, (arg_72_1.time_ - 0) / var_75_0)

								iter_75_1.color = Color.New(var_75_1, var_75_1, var_75_1)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1072"]) and arg_72_1.var_.actorSpriteComps1072 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_75_3 then
						iter_75_3.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_72_1.var_.actorSpriteComps1072 = nil
			end

			local var_75_2 = arg_72_1.actors_["10135"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps10135 == nil then
				arg_72_1.var_.actorSpriteComps10135 = var_75_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_3 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.actorSpriteComps10135 then
					for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_75_5 then
							if arg_72_1.isInRecall_ then
								iter_75_5.color = Color.New(Mathf.Lerp(iter_75_5.color.r, arg_72_1.hightColor2.r, (arg_72_1.time_ - 0) / var_75_3), Mathf.Lerp(iter_75_5.color.g, arg_72_1.hightColor2.g, (arg_72_1.time_ - 0) / var_75_3), (Mathf.Lerp(iter_75_5.color.b, arg_72_1.hightColor2.b, (arg_72_1.time_ - 0) / var_75_3)))
							else
								local var_75_4 = Mathf.Lerp(iter_75_5.color.r, 0.5, (arg_72_1.time_ - 0) / var_75_3)

								iter_75_5.color = Color.New(var_75_4, var_75_4, var_75_4)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps10135 then
				for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_75_7 then
						iter_75_7.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_72_1.var_.actorSpriteComps10135 = nil
			end

			local var_75_5 = arg_72_1.actors_["1072"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1072 = var_75_5.localPosition
				var_75_5.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("1072", 2)

				for iter_75_8 = 0, var_75_5.childCount - 1 do
					local var_75_6 = var_75_5:GetChild(iter_75_8)

					if var_75_6.name == "" or not string.find(var_75_6.name, "split") then
						var_75_6.gameObject:SetActive(true)
					else
						var_75_6.gameObject:SetActive(false)
					end
				end
			end

			local var_75_7 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				var_75_5.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1072, Vector3.New(-434.2, -428.9, -184.1), (arg_72_1.time_ - 0) / var_75_7)
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				var_75_5.localPosition = Vector3.New(-434.2, -428.9, -184.1)
			end

			local var_75_8 = 0
			local var_75_9 = 1.3

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_10 = arg_72_1:GetWordFromCfg(418051018)
				local var_75_11 = arg_72_1:FormatText(var_75_10.content)

				arg_72_1.text_.text = var_75_11

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 52 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 52)

				if (52 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 52)) > 0 and var_75_9 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_8
					end
				end

				arg_72_1.text_.text = var_75_11
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051018", "story_v_side_old_418051.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051018", "story_v_side_old_418051.awb") / 1000

					if var_75_14 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_8
					end

					if var_75_10.prefab_name ~= "" and arg_72_1.actors_[var_75_10.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_10.prefab_name].transform, "story_v_side_old_418051", "418051018", "story_v_side_old_418051.awb")

						arg_72_1:RecordAudio("418051018", var_75_15)
						arg_72_1:RecordAudio("418051018", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051018", "story_v_side_old_418051.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051018", "story_v_side_old_418051.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_9, arg_72_1.talkMaxDuration)

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_8) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_8 + var_75_16 and arg_72_1.time_ < var_75_8 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play418051019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 418051019
		arg_76_1.duration_ = 3.23

		local var_76_0 = {
			ja = 3.233,
			CriLanguages = 3.033,
			zh = 3.033
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play418051020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1073"]) and arg_76_1.var_.actorSpriteComps1073 == nil then
				arg_76_1.var_.actorSpriteComps1073 = arg_76_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_0 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1073"]) then
				if arg_76_1.var_.actorSpriteComps1073 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								iter_79_1.color = Color.New(Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor1.r, (arg_76_1.time_ - 0) / var_79_0), Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor1.g, (arg_76_1.time_ - 0) / var_79_0), (Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor1.b, (arg_76_1.time_ - 0) / var_79_0)))
							else
								local var_79_1 = Mathf.Lerp(iter_79_1.color.r, 1, (arg_76_1.time_ - 0) / var_79_0)

								iter_79_1.color = Color.New(var_79_1, var_79_1, var_79_1)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1073"]) and arg_76_1.var_.actorSpriteComps1073 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_79_3 then
						iter_79_3.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_76_1.var_.actorSpriteComps1073 = nil
			end

			local var_79_2 = arg_76_1.actors_["1072"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1072 == nil then
				arg_76_1.var_.actorSpriteComps1072 = var_79_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_3 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.actorSpriteComps1072 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_79_5 then
							if arg_76_1.isInRecall_ then
								iter_79_5.color = Color.New(Mathf.Lerp(iter_79_5.color.r, arg_76_1.hightColor2.r, (arg_76_1.time_ - 0) / var_79_3), Mathf.Lerp(iter_79_5.color.g, arg_76_1.hightColor2.g, (arg_76_1.time_ - 0) / var_79_3), (Mathf.Lerp(iter_79_5.color.b, arg_76_1.hightColor2.b, (arg_76_1.time_ - 0) / var_79_3)))
							else
								local var_79_4 = Mathf.Lerp(iter_79_5.color.r, 0.5, (arg_76_1.time_ - 0) / var_79_3)

								iter_79_5.color = Color.New(var_79_4, var_79_4, var_79_4)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1072 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_79_7 then
						iter_79_7.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_76_1.var_.actorSpriteComps1072 = nil
			end

			local var_79_5 = arg_76_1.actors_["1072"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1072 = var_79_5.localPosition
				var_79_5.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1072", 7)

				for iter_79_8 = 0, var_79_5.childCount - 1 do
					local var_79_6 = var_79_5:GetChild(iter_79_8)

					if var_79_6.name == "" or not string.find(var_79_6.name, "split") then
						var_79_6.gameObject:SetActive(true)
					else
						var_79_6.gameObject:SetActive(false)
					end
				end
			end

			local var_79_7 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1072, Vector3.New(0, -2000, 0), (arg_76_1.time_ - 0) / var_79_7)
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_79_8 = arg_76_1.actors_["1073"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1073 = var_79_8.localPosition
				var_79_8.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1073", 2)

				for iter_79_9 = 0, var_79_8.childCount - 1 do
					local var_79_9 = var_79_8:GetChild(iter_79_9)

					if var_79_9.name == "" or not string.find(var_79_9.name, "split") then
						var_79_9.gameObject:SetActive(true)
					else
						var_79_9.gameObject:SetActive(false)
					end
				end
			end

			local var_79_10 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_10 then
				var_79_8.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_76_1.time_ - 0) / var_79_10)
			end

			if arg_76_1.time_ >= 0 + var_79_10 and arg_76_1.time_ < 0 + var_79_10 + arg_79_0 then
				var_79_8.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_79_11 = 0
			local var_79_12 = 0.4

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_13 = arg_76_1:GetWordFromCfg(418051019)
				local var_79_14 = arg_76_1:FormatText(var_79_13.content)

				arg_76_1.text_.text = var_79_14

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_16 = 16 <= 0 and var_79_12 or var_79_12 * (utf8.len(var_79_14) / 16)

				if (16 <= 0 and var_79_12 or var_79_12 * (utf8.len(var_79_14) / 16)) > 0 and var_79_12 < var_79_16 then
					arg_76_1.talkMaxDuration = var_79_16

					if var_79_16 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_16 + var_79_11
					end
				end

				arg_76_1.text_.text = var_79_14
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051019", "story_v_side_old_418051.awb") ~= 0 then
					local var_79_17 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051019", "story_v_side_old_418051.awb") / 1000

					if var_79_17 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_17 + var_79_11
					end

					if var_79_13.prefab_name ~= "" and arg_76_1.actors_[var_79_13.prefab_name] ~= nil then
						local var_79_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_13.prefab_name].transform, "story_v_side_old_418051", "418051019", "story_v_side_old_418051.awb")

						arg_76_1:RecordAudio("418051019", var_79_18)
						arg_76_1:RecordAudio("418051019", var_79_18)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051019", "story_v_side_old_418051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051019", "story_v_side_old_418051.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_19 = math.max(var_79_12, arg_76_1.talkMaxDuration)

			if var_79_11 <= arg_76_1.time_ and arg_76_1.time_ < var_79_11 + var_79_19 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_11) / var_79_19

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_11 + var_79_19 and arg_76_1.time_ < var_79_11 + var_79_19 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play418051020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 418051020
		arg_80_1.duration_ = 9.27

		local var_80_0 = {
			ja = 9.266,
			CriLanguages = 5.166,
			zh = 5.166
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play418051021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.75

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:GetWordFromCfg(418051020)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 30 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 30)

				if (30 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 30)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051020", "story_v_side_old_418051.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051020", "story_v_side_old_418051.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_side_old_418051", "418051020", "story_v_side_old_418051.awb")

						arg_80_1:RecordAudio("418051020", var_83_6)
						arg_80_1:RecordAudio("418051020", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051020", "story_v_side_old_418051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051020", "story_v_side_old_418051.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play418051021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 418051021
		arg_84_1.duration_ = 4.07

		local var_84_0 = {
			ja = 4.066,
			CriLanguages = 2.5,
			zh = 2.5
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play418051022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["10135"]) and arg_84_1.var_.actorSpriteComps10135 == nil then
				arg_84_1.var_.actorSpriteComps10135 = arg_84_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["10135"]) then
				if arg_84_1.var_.actorSpriteComps10135 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								iter_87_1.color = Color.New(Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor1.r, (arg_84_1.time_ - 0) / var_87_0), Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor1.g, (arg_84_1.time_ - 0) / var_87_0), (Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor1.b, (arg_84_1.time_ - 0) / var_87_0)))
							else
								local var_87_1 = Mathf.Lerp(iter_87_1.color.r, 1, (arg_84_1.time_ - 0) / var_87_0)

								iter_87_1.color = Color.New(var_87_1, var_87_1, var_87_1)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["10135"]) and arg_84_1.var_.actorSpriteComps10135 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_87_3 then
						iter_87_3.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_84_1.var_.actorSpriteComps10135 = nil
			end

			local var_87_2 = arg_84_1.actors_["1073"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.actorSpriteComps1073 == nil then
				arg_84_1.var_.actorSpriteComps1073 = var_87_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_3 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.actorSpriteComps1073 then
					for iter_87_4, iter_87_5 in pairs(arg_84_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_87_5 then
							if arg_84_1.isInRecall_ then
								iter_87_5.color = Color.New(Mathf.Lerp(iter_87_5.color.r, arg_84_1.hightColor2.r, (arg_84_1.time_ - 0) / var_87_3), Mathf.Lerp(iter_87_5.color.g, arg_84_1.hightColor2.g, (arg_84_1.time_ - 0) / var_87_3), (Mathf.Lerp(iter_87_5.color.b, arg_84_1.hightColor2.b, (arg_84_1.time_ - 0) / var_87_3)))
							else
								local var_87_4 = Mathf.Lerp(iter_87_5.color.r, 0.5, (arg_84_1.time_ - 0) / var_87_3)

								iter_87_5.color = Color.New(var_87_4, var_87_4, var_87_4)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.actorSpriteComps1073 then
				for iter_87_6, iter_87_7 in pairs(arg_84_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_87_7 then
						iter_87_7.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_84_1.var_.actorSpriteComps1073 = nil
			end

			local var_87_5 = arg_84_1.actors_["10135"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos10135 = var_87_5.localPosition
				var_87_5.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("10135", 4)

				for iter_87_8 = 0, var_87_5.childCount - 1 do
					local var_87_6 = var_87_5:GetChild(iter_87_8)

					if var_87_6.name == "" or not string.find(var_87_6.name, "split") then
						var_87_6.gameObject:SetActive(true)
					else
						var_87_6.gameObject:SetActive(false)
					end
				end
			end

			local var_87_7 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				var_87_5.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_84_1.time_ - 0) / var_87_7)
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				var_87_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_87_8 = 0
			local var_87_9 = 0.25

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_8 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_10 = arg_84_1:GetWordFromCfg(418051021)
				local var_87_11 = arg_84_1:FormatText(var_87_10.content)

				arg_84_1.text_.text = var_87_11

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_13 = 10 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_11) / 10)

				if (10 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_11) / 10)) > 0 and var_87_9 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_8
					end
				end

				arg_84_1.text_.text = var_87_11
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051021", "story_v_side_old_418051.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051021", "story_v_side_old_418051.awb") / 1000

					if var_87_14 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_8
					end

					if var_87_10.prefab_name ~= "" and arg_84_1.actors_[var_87_10.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_10.prefab_name].transform, "story_v_side_old_418051", "418051021", "story_v_side_old_418051.awb")

						arg_84_1:RecordAudio("418051021", var_87_15)
						arg_84_1:RecordAudio("418051021", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051021", "story_v_side_old_418051.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051021", "story_v_side_old_418051.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_9, arg_84_1.talkMaxDuration)

			if var_87_8 <= arg_84_1.time_ and arg_84_1.time_ < var_87_8 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_8) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_8 + var_87_16 and arg_84_1.time_ < var_87_8 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play418051022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 418051022
		arg_88_1.duration_ = 7.07

		local var_88_0 = {
			ja = 7.066,
			CriLanguages = 6.766,
			zh = 6.766
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play418051023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1073"]) and arg_88_1.var_.actorSpriteComps1073 == nil then
				arg_88_1.var_.actorSpriteComps1073 = arg_88_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_0 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1073"]) then
				if arg_88_1.var_.actorSpriteComps1073 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								iter_91_1.color = Color.New(Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor1.r, (arg_88_1.time_ - 0) / var_91_0), Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor1.g, (arg_88_1.time_ - 0) / var_91_0), (Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor1.b, (arg_88_1.time_ - 0) / var_91_0)))
							else
								local var_91_1 = Mathf.Lerp(iter_91_1.color.r, 1, (arg_88_1.time_ - 0) / var_91_0)

								iter_91_1.color = Color.New(var_91_1, var_91_1, var_91_1)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1073"]) and arg_88_1.var_.actorSpriteComps1073 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_91_3 then
						iter_91_3.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_88_1.var_.actorSpriteComps1073 = nil
			end

			local var_91_2 = arg_88_1.actors_["10135"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.actorSpriteComps10135 == nil then
				arg_88_1.var_.actorSpriteComps10135 = var_91_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_3 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.actorSpriteComps10135 then
					for iter_91_4, iter_91_5 in pairs(arg_88_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_91_5 then
							if arg_88_1.isInRecall_ then
								iter_91_5.color = Color.New(Mathf.Lerp(iter_91_5.color.r, arg_88_1.hightColor2.r, (arg_88_1.time_ - 0) / var_91_3), Mathf.Lerp(iter_91_5.color.g, arg_88_1.hightColor2.g, (arg_88_1.time_ - 0) / var_91_3), (Mathf.Lerp(iter_91_5.color.b, arg_88_1.hightColor2.b, (arg_88_1.time_ - 0) / var_91_3)))
							else
								local var_91_4 = Mathf.Lerp(iter_91_5.color.r, 0.5, (arg_88_1.time_ - 0) / var_91_3)

								iter_91_5.color = Color.New(var_91_4, var_91_4, var_91_4)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.actorSpriteComps10135 then
				for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_91_7 then
						iter_91_7.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_88_1.var_.actorSpriteComps10135 = nil
			end

			local var_91_5 = arg_88_1.actors_["1073"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1073 = var_91_5.localPosition
				var_91_5.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("1073", 2)

				for iter_91_8 = 0, var_91_5.childCount - 1 do
					local var_91_6 = var_91_5:GetChild(iter_91_8)

					if var_91_6.name == "" or not string.find(var_91_6.name, "split") then
						var_91_6.gameObject:SetActive(true)
					else
						var_91_6.gameObject:SetActive(false)
					end
				end
			end

			local var_91_7 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				var_91_5.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_88_1.time_ - 0) / var_91_7)
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				var_91_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_91_8 = 0
			local var_91_9 = 0.9

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_10 = arg_88_1:GetWordFromCfg(418051022)
				local var_91_11 = arg_88_1:FormatText(var_91_10.content)

				arg_88_1.text_.text = var_91_11

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_13 = 36 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 36)

				if (36 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 36)) > 0 and var_91_9 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_8
					end
				end

				arg_88_1.text_.text = var_91_11
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051022", "story_v_side_old_418051.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051022", "story_v_side_old_418051.awb") / 1000

					if var_91_14 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_8
					end

					if var_91_10.prefab_name ~= "" and arg_88_1.actors_[var_91_10.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_10.prefab_name].transform, "story_v_side_old_418051", "418051022", "story_v_side_old_418051.awb")

						arg_88_1:RecordAudio("418051022", var_91_15)
						arg_88_1:RecordAudio("418051022", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051022", "story_v_side_old_418051.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051022", "story_v_side_old_418051.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_9, arg_88_1.talkMaxDuration)

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_8) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_8 + var_91_16 and arg_88_1.time_ < var_91_8 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play418051023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 418051023
		arg_92_1.duration_ = 3.07

		local var_92_0 = {
			ja = 3.066,
			CriLanguages = 1.233,
			zh = 1.233
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
				arg_92_0:Play418051024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["10135"]) and arg_92_1.var_.actorSpriteComps10135 == nil then
				arg_92_1.var_.actorSpriteComps10135 = arg_92_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_0 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["10135"]) then
				if arg_92_1.var_.actorSpriteComps10135 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								iter_95_1.color = Color.New(Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor1.r, (arg_92_1.time_ - 0) / var_95_0), Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor1.g, (arg_92_1.time_ - 0) / var_95_0), (Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor1.b, (arg_92_1.time_ - 0) / var_95_0)))
							else
								local var_95_1 = Mathf.Lerp(iter_95_1.color.r, 1, (arg_92_1.time_ - 0) / var_95_0)

								iter_95_1.color = Color.New(var_95_1, var_95_1, var_95_1)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["10135"]) and arg_92_1.var_.actorSpriteComps10135 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_95_3 then
						iter_95_3.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_92_1.var_.actorSpriteComps10135 = nil
			end

			local var_95_2 = arg_92_1.actors_["1073"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.actorSpriteComps1073 == nil then
				arg_92_1.var_.actorSpriteComps1073 = var_95_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_3 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.actorSpriteComps1073 then
					for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_95_5 then
							if arg_92_1.isInRecall_ then
								iter_95_5.color = Color.New(Mathf.Lerp(iter_95_5.color.r, arg_92_1.hightColor2.r, (arg_92_1.time_ - 0) / var_95_3), Mathf.Lerp(iter_95_5.color.g, arg_92_1.hightColor2.g, (arg_92_1.time_ - 0) / var_95_3), (Mathf.Lerp(iter_95_5.color.b, arg_92_1.hightColor2.b, (arg_92_1.time_ - 0) / var_95_3)))
							else
								local var_95_4 = Mathf.Lerp(iter_95_5.color.r, 0.5, (arg_92_1.time_ - 0) / var_95_3)

								iter_95_5.color = Color.New(var_95_4, var_95_4, var_95_4)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.actorSpriteComps1073 then
				for iter_95_6, iter_95_7 in pairs(arg_92_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_95_7 then
						iter_95_7.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_92_1.var_.actorSpriteComps1073 = nil
			end

			local var_95_5 = 0
			local var_95_6 = 0.1

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_7 = arg_92_1:GetWordFromCfg(418051023)
				local var_95_8 = arg_92_1:FormatText(var_95_7.content)

				arg_92_1.text_.text = var_95_8

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 4 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_8) / 4)

				if (4 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_8) / 4)) > 0 and var_95_6 < var_95_10 then
					arg_92_1.talkMaxDuration = var_95_10

					if var_95_10 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_5
					end
				end

				arg_92_1.text_.text = var_95_8
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051023", "story_v_side_old_418051.awb") ~= 0 then
					local var_95_11 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051023", "story_v_side_old_418051.awb") / 1000

					if var_95_11 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_5
					end

					if var_95_7.prefab_name ~= "" and arg_92_1.actors_[var_95_7.prefab_name] ~= nil then
						local var_95_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_7.prefab_name].transform, "story_v_side_old_418051", "418051023", "story_v_side_old_418051.awb")

						arg_92_1:RecordAudio("418051023", var_95_12)
						arg_92_1:RecordAudio("418051023", var_95_12)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051023", "story_v_side_old_418051.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051023", "story_v_side_old_418051.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_13 = math.max(var_95_6, arg_92_1.talkMaxDuration)

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_13 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_5) / var_95_13

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_5 + var_95_13 and arg_92_1.time_ < var_95_5 + var_95_13 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play418051024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 418051024
		arg_96_1.duration_ = 5.63

		local var_96_0 = {
			ja = 5.633,
			CriLanguages = 3.833,
			zh = 3.833
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
				arg_96_0:Play418051025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1072"]) and arg_96_1.var_.actorSpriteComps1072 == nil then
				arg_96_1.var_.actorSpriteComps1072 = arg_96_1.actors_["1072"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1072"]) then
				if arg_96_1.var_.actorSpriteComps1072 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								iter_99_1.color = Color.New(Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor1.r, (arg_96_1.time_ - 0) / var_99_0), Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor1.g, (arg_96_1.time_ - 0) / var_99_0), (Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor1.b, (arg_96_1.time_ - 0) / var_99_0)))
							else
								local var_99_1 = Mathf.Lerp(iter_99_1.color.r, 1, (arg_96_1.time_ - 0) / var_99_0)

								iter_99_1.color = Color.New(var_99_1, var_99_1, var_99_1)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1072"]) and arg_96_1.var_.actorSpriteComps1072 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_99_3 then
						iter_99_3.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_96_1.var_.actorSpriteComps1072 = nil
			end

			local var_99_2 = arg_96_1.actors_["10135"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.actorSpriteComps10135 == nil then
				arg_96_1.var_.actorSpriteComps10135 = var_99_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_3 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.actorSpriteComps10135 then
					for iter_99_4, iter_99_5 in pairs(arg_96_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_99_5 then
							if arg_96_1.isInRecall_ then
								iter_99_5.color = Color.New(Mathf.Lerp(iter_99_5.color.r, arg_96_1.hightColor2.r, (arg_96_1.time_ - 0) / var_99_3), Mathf.Lerp(iter_99_5.color.g, arg_96_1.hightColor2.g, (arg_96_1.time_ - 0) / var_99_3), (Mathf.Lerp(iter_99_5.color.b, arg_96_1.hightColor2.b, (arg_96_1.time_ - 0) / var_99_3)))
							else
								local var_99_4 = Mathf.Lerp(iter_99_5.color.r, 0.5, (arg_96_1.time_ - 0) / var_99_3)

								iter_99_5.color = Color.New(var_99_4, var_99_4, var_99_4)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.actorSpriteComps10135 then
				for iter_99_6, iter_99_7 in pairs(arg_96_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_99_7 then
						iter_99_7.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_96_1.var_.actorSpriteComps10135 = nil
			end

			local var_99_5 = arg_96_1.actors_["1072"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1072 = var_99_5.localPosition
				var_99_5.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1072", 3)

				for iter_99_8 = 0, var_99_5.childCount - 1 do
					local var_99_6 = var_99_5:GetChild(iter_99_8)

					if var_99_6.name == "split_7" or not string.find(var_99_6.name, "split") then
						var_99_6.gameObject:SetActive(true)
					else
						var_99_6.gameObject:SetActive(false)
					end
				end
			end

			local var_99_7 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				var_99_5.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1072, Vector3.New(30.1, -428.9, -184.1), (arg_96_1.time_ - 0) / var_99_7)
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				var_99_5.localPosition = Vector3.New(30.1, -428.9, -184.1)
			end

			local var_99_8 = arg_96_1.actors_["1073"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1073 = var_99_8.localPosition
				var_99_8.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1073", 7)

				for iter_99_9 = 0, var_99_8.childCount - 1 do
					local var_99_9 = var_99_8:GetChild(iter_99_9)

					if var_99_9.name == "" or not string.find(var_99_9.name, "split") then
						var_99_9.gameObject:SetActive(true)
					else
						var_99_9.gameObject:SetActive(false)
					end
				end
			end

			local var_99_10 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_10 then
				var_99_8.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_96_1.time_ - 0) / var_99_10)
			end

			if arg_96_1.time_ >= 0 + var_99_10 and arg_96_1.time_ < 0 + var_99_10 + arg_99_0 then
				var_99_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_99_11 = arg_96_1.actors_["10135"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos10135 = var_99_11.localPosition
				var_99_11.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("10135", 7)

				for iter_99_10 = 0, var_99_11.childCount - 1 do
					local var_99_12 = var_99_11:GetChild(iter_99_10)

					if var_99_12.name == "" or not string.find(var_99_12.name, "split") then
						var_99_12.gameObject:SetActive(true)
					else
						var_99_12.gameObject:SetActive(false)
					end
				end
			end

			local var_99_13 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_13 then
				var_99_11.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_96_1.time_ - 0) / var_99_13)
			end

			if arg_96_1.time_ >= 0 + var_99_13 and arg_96_1.time_ < 0 + var_99_13 + arg_99_0 then
				var_99_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_99_14 = 0
			local var_99_15 = 0.45

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_16 = arg_96_1:GetWordFromCfg(418051024)
				local var_99_17 = arg_96_1:FormatText(var_99_16.content)

				arg_96_1.text_.text = var_99_17

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_19 = 18 <= 0 and var_99_15 or var_99_15 * (utf8.len(var_99_17) / 18)

				if (18 <= 0 and var_99_15 or var_99_15 * (utf8.len(var_99_17) / 18)) > 0 and var_99_15 < var_99_19 then
					arg_96_1.talkMaxDuration = var_99_19

					if var_99_19 + var_99_14 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_14
					end
				end

				arg_96_1.text_.text = var_99_17
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051024", "story_v_side_old_418051.awb") ~= 0 then
					local var_99_20 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051024", "story_v_side_old_418051.awb") / 1000

					if var_99_20 + var_99_14 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_20 + var_99_14
					end

					if var_99_16.prefab_name ~= "" and arg_96_1.actors_[var_99_16.prefab_name] ~= nil then
						local var_99_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_16.prefab_name].transform, "story_v_side_old_418051", "418051024", "story_v_side_old_418051.awb")

						arg_96_1:RecordAudio("418051024", var_99_21)
						arg_96_1:RecordAudio("418051024", var_99_21)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051024", "story_v_side_old_418051.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051024", "story_v_side_old_418051.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_22 = math.max(var_99_15, arg_96_1.talkMaxDuration)

			if var_99_14 <= arg_96_1.time_ and arg_96_1.time_ < var_99_14 + var_99_22 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_14) / var_99_22

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_14 + var_99_22 and arg_96_1.time_ < var_99_14 + var_99_22 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
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
	Play418051025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 418051025
		arg_100_1.duration_ = 5.53

		local var_100_0 = {
			ja = 5.533,
			CriLanguages = 4.5,
			zh = 4.5
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
				arg_100_0:Play418051026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1073"]) and arg_100_1.var_.actorSpriteComps1073 == nil then
				arg_100_1.var_.actorSpriteComps1073 = arg_100_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1073"]) then
				if arg_100_1.var_.actorSpriteComps1073 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								iter_103_1.color = Color.New(Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor1.r, (arg_100_1.time_ - 0) / var_103_0), Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor1.g, (arg_100_1.time_ - 0) / var_103_0), (Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor1.b, (arg_100_1.time_ - 0) / var_103_0)))
							else
								local var_103_1 = Mathf.Lerp(iter_103_1.color.r, 1, (arg_100_1.time_ - 0) / var_103_0)

								iter_103_1.color = Color.New(var_103_1, var_103_1, var_103_1)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1073"]) and arg_100_1.var_.actorSpriteComps1073 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_103_3 then
						iter_103_3.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_100_1.var_.actorSpriteComps1073 = nil
			end

			local var_103_2 = arg_100_1.actors_["1072"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.actorSpriteComps1072 == nil then
				arg_100_1.var_.actorSpriteComps1072 = var_103_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_3 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.actorSpriteComps1072 then
					for iter_103_4, iter_103_5 in pairs(arg_100_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_103_5 then
							if arg_100_1.isInRecall_ then
								iter_103_5.color = Color.New(Mathf.Lerp(iter_103_5.color.r, arg_100_1.hightColor2.r, (arg_100_1.time_ - 0) / var_103_3), Mathf.Lerp(iter_103_5.color.g, arg_100_1.hightColor2.g, (arg_100_1.time_ - 0) / var_103_3), (Mathf.Lerp(iter_103_5.color.b, arg_100_1.hightColor2.b, (arg_100_1.time_ - 0) / var_103_3)))
							else
								local var_103_4 = Mathf.Lerp(iter_103_5.color.r, 0.5, (arg_100_1.time_ - 0) / var_103_3)

								iter_103_5.color = Color.New(var_103_4, var_103_4, var_103_4)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.actorSpriteComps1072 then
				for iter_103_6, iter_103_7 in pairs(arg_100_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_103_7 then
						iter_103_7.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_100_1.var_.actorSpriteComps1072 = nil
			end

			local var_103_5 = 0
			local var_103_6 = 0.45

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1073_split_1")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_7 = arg_100_1:GetWordFromCfg(418051025)
				local var_103_8 = arg_100_1:FormatText(var_103_7.content)

				arg_100_1.text_.text = var_103_8

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_10 = 18 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_8) / 18)

				if (18 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_8) / 18)) > 0 and var_103_6 < var_103_10 then
					arg_100_1.talkMaxDuration = var_103_10

					if var_103_10 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_5
					end
				end

				arg_100_1.text_.text = var_103_8
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051025", "story_v_side_old_418051.awb") ~= 0 then
					local var_103_11 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051025", "story_v_side_old_418051.awb") / 1000

					if var_103_11 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_11 + var_103_5
					end

					if var_103_7.prefab_name ~= "" and arg_100_1.actors_[var_103_7.prefab_name] ~= nil then
						local var_103_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_7.prefab_name].transform, "story_v_side_old_418051", "418051025", "story_v_side_old_418051.awb")

						arg_100_1:RecordAudio("418051025", var_103_12)
						arg_100_1:RecordAudio("418051025", var_103_12)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051025", "story_v_side_old_418051.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051025", "story_v_side_old_418051.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_13 = math.max(var_103_6, arg_100_1.talkMaxDuration)

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_13 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_5) / var_103_13

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_5 + var_103_13 and arg_100_1.time_ < var_103_5 + var_103_13 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play418051026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 418051026
		arg_104_1.duration_ = 12.87

		local var_104_0 = {
			ja = 12.866,
			CriLanguages = 8.3,
			zh = 7.533
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
				arg_104_0:Play418051027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1072"]) and arg_104_1.var_.actorSpriteComps1072 == nil then
				arg_104_1.var_.actorSpriteComps1072 = arg_104_1.actors_["1072"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_0 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1072"]) then
				if arg_104_1.var_.actorSpriteComps1072 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								iter_107_1.color = Color.New(Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor1.r, (arg_104_1.time_ - 0) / var_107_0), Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor1.g, (arg_104_1.time_ - 0) / var_107_0), (Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor1.b, (arg_104_1.time_ - 0) / var_107_0)))
							else
								local var_107_1 = Mathf.Lerp(iter_107_1.color.r, 1, (arg_104_1.time_ - 0) / var_107_0)

								iter_107_1.color = Color.New(var_107_1, var_107_1, var_107_1)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1072"]) and arg_104_1.var_.actorSpriteComps1072 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_107_3 then
						iter_107_3.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_104_1.var_.actorSpriteComps1072 = nil
			end

			local var_107_2 = arg_104_1.actors_["1073"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps1073 == nil then
				arg_104_1.var_.actorSpriteComps1073 = var_107_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_3 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.actorSpriteComps1073 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								iter_107_5.color = Color.New(Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor2.r, (arg_104_1.time_ - 0) / var_107_3), Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor2.g, (arg_104_1.time_ - 0) / var_107_3), (Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor2.b, (arg_104_1.time_ - 0) / var_107_3)))
							else
								local var_107_4 = Mathf.Lerp(iter_107_5.color.r, 0.5, (arg_104_1.time_ - 0) / var_107_3)

								iter_107_5.color = Color.New(var_107_4, var_107_4, var_107_4)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps1073 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_107_7 then
						iter_107_7.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_104_1.var_.actorSpriteComps1073 = nil
			end

			local var_107_5 = arg_104_1.actors_["1072"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1072 = var_107_5.localPosition
				var_107_5.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1072", 3)

				for iter_107_8 = 0, var_107_5.childCount - 1 do
					local var_107_6 = var_107_5:GetChild(iter_107_8)

					if var_107_6.name == "" or not string.find(var_107_6.name, "split") then
						var_107_6.gameObject:SetActive(true)
					else
						var_107_6.gameObject:SetActive(false)
					end
				end
			end

			local var_107_7 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				var_107_5.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1072, Vector3.New(30.1, -428.9, -184.1), (arg_104_1.time_ - 0) / var_107_7)
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				var_107_5.localPosition = Vector3.New(30.1, -428.9, -184.1)
			end

			local var_107_8 = 0
			local var_107_9 = 0.9

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_8 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_10 = arg_104_1:GetWordFromCfg(418051026)
				local var_107_11 = arg_104_1:FormatText(var_107_10.content)

				arg_104_1.text_.text = var_107_11

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_13 = 34 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 34)

				if (34 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 34)) > 0 and var_107_9 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_8
					end
				end

				arg_104_1.text_.text = var_107_11
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051026", "story_v_side_old_418051.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051026", "story_v_side_old_418051.awb") / 1000

					if var_107_14 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_8
					end

					if var_107_10.prefab_name ~= "" and arg_104_1.actors_[var_107_10.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_10.prefab_name].transform, "story_v_side_old_418051", "418051026", "story_v_side_old_418051.awb")

						arg_104_1:RecordAudio("418051026", var_107_15)
						arg_104_1:RecordAudio("418051026", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051026", "story_v_side_old_418051.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051026", "story_v_side_old_418051.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_9, arg_104_1.talkMaxDuration)

			if var_107_8 <= arg_104_1.time_ and arg_104_1.time_ < var_107_8 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_8) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_8 + var_107_16 and arg_104_1.time_ < var_107_8 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
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
	Play418051027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 418051027
		arg_108_1.duration_ = 11.67

		local var_108_0 = {
			ja = 11.666,
			CriLanguages = 8,
			zh = 8
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
				arg_108_0:Play418051028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 1.025

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:GetWordFromCfg(418051027)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 41 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 41)

				if (41 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 41)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051027", "story_v_side_old_418051.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051027", "story_v_side_old_418051.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_side_old_418051", "418051027", "story_v_side_old_418051.awb")

						arg_108_1:RecordAudio("418051027", var_111_6)
						arg_108_1:RecordAudio("418051027", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051027", "story_v_side_old_418051.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051027", "story_v_side_old_418051.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play418051028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 418051028
		arg_112_1.duration_ = 11.73

		local var_112_0 = {
			ja = 11.733,
			CriLanguages = 8.633,
			zh = 8.633
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
				arg_112_0:Play418051029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1072 = arg_112_1.actors_["1072"].transform.localPosition
				arg_112_1.actors_["1072"].transform.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("1072", 3)

				for iter_115_0 = 0, arg_112_1.actors_["1072"].transform.childCount - 1 do
					local var_115_0 = arg_112_1.actors_["1072"].transform:GetChild(iter_115_0)

					if var_115_0.name == "" or not string.find(var_115_0.name, "split") then
						var_115_0.gameObject:SetActive(true)
					else
						var_115_0.gameObject:SetActive(false)
					end
				end
			end

			local var_115_1 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_1 then
				arg_112_1.actors_["1072"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1072, Vector3.New(30.1, -428.9, -184.1), (arg_112_1.time_ - 0) / var_115_1)
			end

			if arg_112_1.time_ >= 0 + var_115_1 and arg_112_1.time_ < 0 + var_115_1 + arg_115_0 then
				arg_112_1.actors_["1072"].transform.localPosition = Vector3.New(30.1, -428.9, -184.1)
			end

			local var_115_2 = 0
			local var_115_3 = 1.025

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(418051028)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 41 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 41)

				if (41 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 41)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051028", "story_v_side_old_418051.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051028", "story_v_side_old_418051.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_side_old_418051", "418051028", "story_v_side_old_418051.awb")

						arg_112_1:RecordAudio("418051028", var_115_9)
						arg_112_1:RecordAudio("418051028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051028", "story_v_side_old_418051.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051028", "story_v_side_old_418051.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
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
	Play418051029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 418051029
		arg_116_1.duration_ = 6.13

		local var_116_0 = {
			ja = 6.133,
			CriLanguages = 4.266,
			zh = 4.266
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
				arg_116_0:Play418051030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["10135"]) and arg_116_1.var_.actorSpriteComps10135 == nil then
				arg_116_1.var_.actorSpriteComps10135 = arg_116_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["10135"]) then
				if arg_116_1.var_.actorSpriteComps10135 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								iter_119_1.color = Color.New(Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, (arg_116_1.time_ - 0) / var_119_0), Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, (arg_116_1.time_ - 0) / var_119_0), (Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, (arg_116_1.time_ - 0) / var_119_0)))
							else
								local var_119_1 = Mathf.Lerp(iter_119_1.color.r, 1, (arg_116_1.time_ - 0) / var_119_0)

								iter_119_1.color = Color.New(var_119_1, var_119_1, var_119_1)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["10135"]) and arg_116_1.var_.actorSpriteComps10135 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps10135 = nil
			end

			local var_119_2 = arg_116_1.actors_["1072"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps1072 == nil then
				arg_116_1.var_.actorSpriteComps1072 = var_119_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_3 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.actorSpriteComps1072 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_119_5 then
							if arg_116_1.isInRecall_ then
								iter_119_5.color = Color.New(Mathf.Lerp(iter_119_5.color.r, arg_116_1.hightColor2.r, (arg_116_1.time_ - 0) / var_119_3), Mathf.Lerp(iter_119_5.color.g, arg_116_1.hightColor2.g, (arg_116_1.time_ - 0) / var_119_3), (Mathf.Lerp(iter_119_5.color.b, arg_116_1.hightColor2.b, (arg_116_1.time_ - 0) / var_119_3)))
							else
								local var_119_4 = Mathf.Lerp(iter_119_5.color.r, 0.5, (arg_116_1.time_ - 0) / var_119_3)

								iter_119_5.color = Color.New(var_119_4, var_119_4, var_119_4)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps1072 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_119_7 then
						iter_119_7.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_116_1.var_.actorSpriteComps1072 = nil
			end

			local var_119_5 = arg_116_1.actors_["1072"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1072 = var_119_5.localPosition
				var_119_5.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1072", 2)

				for iter_119_8 = 0, var_119_5.childCount - 1 do
					local var_119_6 = var_119_5:GetChild(iter_119_8)

					if var_119_6.name == "" or not string.find(var_119_6.name, "split") then
						var_119_6.gameObject:SetActive(true)
					else
						var_119_6.gameObject:SetActive(false)
					end
				end
			end

			local var_119_7 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				var_119_5.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1072, Vector3.New(-434.2, -428.9, -184.1), (arg_116_1.time_ - 0) / var_119_7)
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				var_119_5.localPosition = Vector3.New(-434.2, -428.9, -184.1)
			end

			local var_119_8 = arg_116_1.actors_["10135"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos10135 = var_119_8.localPosition
				var_119_8.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("10135", 4)

				for iter_119_9 = 0, var_119_8.childCount - 1 do
					local var_119_9 = var_119_8:GetChild(iter_119_9)

					if var_119_9.name == "" or not string.find(var_119_9.name, "split") then
						var_119_9.gameObject:SetActive(true)
					else
						var_119_9.gameObject:SetActive(false)
					end
				end
			end

			local var_119_10 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_10 then
				var_119_8.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_116_1.time_ - 0) / var_119_10)
			end

			if arg_116_1.time_ >= 0 + var_119_10 and arg_116_1.time_ < 0 + var_119_10 + arg_119_0 then
				var_119_8.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_119_11 = 0
			local var_119_12 = 0.525

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_13 = arg_116_1:GetWordFromCfg(418051029)
				local var_119_14 = arg_116_1:FormatText(var_119_13.content)

				arg_116_1.text_.text = var_119_14

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_16 = 21 <= 0 and var_119_12 or var_119_12 * (utf8.len(var_119_14) / 21)

				if (21 <= 0 and var_119_12 or var_119_12 * (utf8.len(var_119_14) / 21)) > 0 and var_119_12 < var_119_16 then
					arg_116_1.talkMaxDuration = var_119_16

					if var_119_16 + var_119_11 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_16 + var_119_11
					end
				end

				arg_116_1.text_.text = var_119_14
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051029", "story_v_side_old_418051.awb") ~= 0 then
					local var_119_17 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051029", "story_v_side_old_418051.awb") / 1000

					if var_119_17 + var_119_11 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_17 + var_119_11
					end

					if var_119_13.prefab_name ~= "" and arg_116_1.actors_[var_119_13.prefab_name] ~= nil then
						local var_119_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_13.prefab_name].transform, "story_v_side_old_418051", "418051029", "story_v_side_old_418051.awb")

						arg_116_1:RecordAudio("418051029", var_119_18)
						arg_116_1:RecordAudio("418051029", var_119_18)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051029", "story_v_side_old_418051.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051029", "story_v_side_old_418051.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_19 = math.max(var_119_12, arg_116_1.talkMaxDuration)

			if var_119_11 <= arg_116_1.time_ and arg_116_1.time_ < var_119_11 + var_119_19 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_11) / var_119_19

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_11 + var_119_19 and arg_116_1.time_ < var_119_11 + var_119_19 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
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
	Play418051030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 418051030
		arg_120_1.duration_ = 7.57

		local var_120_0 = {
			ja = 7.566,
			CriLanguages = 4.766,
			zh = 4.766
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
				arg_120_0:Play418051031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1072"]) and arg_120_1.var_.actorSpriteComps1072 == nil then
				arg_120_1.var_.actorSpriteComps1072 = arg_120_1.actors_["1072"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1072"]) then
				if arg_120_1.var_.actorSpriteComps1072 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								iter_123_1.color = Color.New(Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, (arg_120_1.time_ - 0) / var_123_0), Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, (arg_120_1.time_ - 0) / var_123_0), (Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, (arg_120_1.time_ - 0) / var_123_0)))
							else
								local var_123_1 = Mathf.Lerp(iter_123_1.color.r, 1, (arg_120_1.time_ - 0) / var_123_0)

								iter_123_1.color = Color.New(var_123_1, var_123_1, var_123_1)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1072"]) and arg_120_1.var_.actorSpriteComps1072 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_123_3 then
						iter_123_3.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_120_1.var_.actorSpriteComps1072 = nil
			end

			local var_123_2 = arg_120_1.actors_["10135"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps10135 == nil then
				arg_120_1.var_.actorSpriteComps10135 = var_123_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_3 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.actorSpriteComps10135 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								iter_123_5.color = Color.New(Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, (arg_120_1.time_ - 0) / var_123_3), Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, (arg_120_1.time_ - 0) / var_123_3), (Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, (arg_120_1.time_ - 0) / var_123_3)))
							else
								local var_123_4 = Mathf.Lerp(iter_123_5.color.r, 0.5, (arg_120_1.time_ - 0) / var_123_3)

								iter_123_5.color = Color.New(var_123_4, var_123_4, var_123_4)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps10135 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_123_7 then
						iter_123_7.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_120_1.var_.actorSpriteComps10135 = nil
			end

			local var_123_5 = 0
			local var_123_6 = 0.675

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_7 = arg_120_1:GetWordFromCfg(418051030)
				local var_123_8 = arg_120_1:FormatText(var_123_7.content)

				arg_120_1.text_.text = var_123_8

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_10 = 27 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 27)

				if (27 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 27)) > 0 and var_123_6 < var_123_10 then
					arg_120_1.talkMaxDuration = var_123_10

					if var_123_10 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_5
					end
				end

				arg_120_1.text_.text = var_123_8
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051030", "story_v_side_old_418051.awb") ~= 0 then
					local var_123_11 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051030", "story_v_side_old_418051.awb") / 1000

					if var_123_11 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_5
					end

					if var_123_7.prefab_name ~= "" and arg_120_1.actors_[var_123_7.prefab_name] ~= nil then
						local var_123_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_7.prefab_name].transform, "story_v_side_old_418051", "418051030", "story_v_side_old_418051.awb")

						arg_120_1:RecordAudio("418051030", var_123_12)
						arg_120_1:RecordAudio("418051030", var_123_12)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051030", "story_v_side_old_418051.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051030", "story_v_side_old_418051.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_13 = math.max(var_123_6, arg_120_1.talkMaxDuration)

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_13 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_5) / var_123_13

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_5 + var_123_13 and arg_120_1.time_ < var_123_5 + var_123_13 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play418051031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 418051031
		arg_124_1.duration_ = 2.63

		local var_124_0 = {
			ja = 2.633,
			CriLanguages = 1.8,
			zh = 1.8
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
			arg_124_1.auto_ = false
		end

		function arg_124_1.playNext_(arg_126_0)
			arg_124_1.onStoryFinished_()
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1073"]) and arg_124_1.var_.actorSpriteComps1073 == nil then
				arg_124_1.var_.actorSpriteComps1073 = arg_124_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1073"]) then
				if arg_124_1.var_.actorSpriteComps1073 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								iter_127_1.color = Color.New(Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor1.r, (arg_124_1.time_ - 0) / var_127_0), Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor1.g, (arg_124_1.time_ - 0) / var_127_0), (Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor1.b, (arg_124_1.time_ - 0) / var_127_0)))
							else
								local var_127_1 = Mathf.Lerp(iter_127_1.color.r, 1, (arg_124_1.time_ - 0) / var_127_0)

								iter_127_1.color = Color.New(var_127_1, var_127_1, var_127_1)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1073"]) and arg_124_1.var_.actorSpriteComps1073 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_124_1.var_.actorSpriteComps1073 = nil
			end

			local var_127_2 = arg_124_1.actors_["1072"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps1072 == nil then
				arg_124_1.var_.actorSpriteComps1072 = var_127_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_3 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.actorSpriteComps1072 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								iter_127_5.color = Color.New(Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor2.r, (arg_124_1.time_ - 0) / var_127_3), Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor2.g, (arg_124_1.time_ - 0) / var_127_3), (Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor2.b, (arg_124_1.time_ - 0) / var_127_3)))
							else
								local var_127_4 = Mathf.Lerp(iter_127_5.color.r, 0.5, (arg_124_1.time_ - 0) / var_127_3)

								iter_127_5.color = Color.New(var_127_4, var_127_4, var_127_4)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps1072 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_127_7 then
						iter_127_7.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_124_1.var_.actorSpriteComps1072 = nil
			end

			local var_127_5 = 0
			local var_127_6 = 0.2

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1073_split_1")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_7 = arg_124_1:GetWordFromCfg(418051031)
				local var_127_8 = arg_124_1:FormatText(var_127_7.content)

				arg_124_1.text_.text = var_127_8

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_10 = 8 <= 0 and var_127_6 or var_127_6 * (utf8.len(var_127_8) / 8)

				if (8 <= 0 and var_127_6 or var_127_6 * (utf8.len(var_127_8) / 8)) > 0 and var_127_6 < var_127_10 then
					arg_124_1.talkMaxDuration = var_127_10

					if var_127_10 + var_127_5 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_5
					end
				end

				arg_124_1.text_.text = var_127_8
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418051", "418051031", "story_v_side_old_418051.awb") ~= 0 then
					local var_127_11 = manager.audio:GetVoiceLength("story_v_side_old_418051", "418051031", "story_v_side_old_418051.awb") / 1000

					if var_127_11 + var_127_5 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_11 + var_127_5
					end

					if var_127_7.prefab_name ~= "" and arg_124_1.actors_[var_127_7.prefab_name] ~= nil then
						local var_127_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_7.prefab_name].transform, "story_v_side_old_418051", "418051031", "story_v_side_old_418051.awb")

						arg_124_1:RecordAudio("418051031", var_127_12)
						arg_124_1:RecordAudio("418051031", var_127_12)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_old_418051", "418051031", "story_v_side_old_418051.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_old_418051", "418051031", "story_v_side_old_418051.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_13 = math.max(var_127_6, arg_124_1.talkMaxDuration)

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_13 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_5) / var_127_13

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_5 + var_127_13 and arg_124_1.time_ < var_127_5 + var_127_13 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST1002"
	},
	voices = {
		"story_v_side_old_418051.awb"
	}
}
